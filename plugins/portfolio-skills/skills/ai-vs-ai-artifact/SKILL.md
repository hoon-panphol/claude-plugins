---
name: "ai-vs-ai-artifact"
description: "Use when the user wants a published Artifact where two or more AI calls happen live inside the page itself — e.g. one agent proposes and another challenges/reviews it (\"Claudeception\", AI-checks-AI, adversarial review, self-critique tools). A common use is portfolio review (\"ให้ AI สองตัวถกพอร์ต\", \"หา AI มาค้านพอร์ตนี้\"): one agent proposes an allocation, the other is shown only the numbers — not the reasoning — and attacks them against a named checklist. Use only when the deliverable is a published interactive page; for a plain analysis in chat, use portfolio-action-plan or portfolio-stress-test instead."
---

# AI-vs-AI Artifact

Builds a published HTML Artifact that calls Claude from *inside the page itself*, usually in two roles that check each other: a "proposer" agent produces a draft, and a "challenger" agent — deliberately shown less context than the proposer — tries to find its weaknesses against an explicit checklist. The person reads both sides and makes the final call. This pattern generalizes beyond portfolios: code review (author vs. reviewer), argument stress-testing (advocate vs. skeptic), plan critique (planner vs. red-team), etc.

## The one rule that matters: use `sample`, never `fetch`

A published Artifact page CANNOT call `fetch("https://api.anthropic.com/...")` — that only works transiently in the chat's own unpublished preview, and breaks with "Failed to fetch" the moment the page is opened as a published link. This is the single most common failure mode for this kind of build.

Instead:
1. Before writing code, load the `artifact-capabilities` skill and read `sample.d.ts` under the runtime contract path it points to (e.g. `/mnt/user-data/outputs/artifacts/_contract/<version>/sample.d.ts`).
2. Declare `capabilities: {"sample": {}}` on every `Artifact` publish call for this page (both the first publish and every republish — capabilities are a full-set declaration, so omit only to carry the existing one forward unchanged).
3. In the page's JS, resolve it lazily and design for absence:
   ```js
   const sample = await claude.use('sample');   // null: hide/disable the AI-dependent buttons
   if (!sample) { /* render a message, don't throw */ }
   ```
4. There is no page-controlled system prompt — fold role instructions, task data, and the exact output format into one `input` string (or a turn array), and prefer `sample.json(prompt, opts)` when you want structured output back, since it parses tolerantly (raw JSON, a fenced block, or first-`{`-to-last-`}`).
5. Call only on an explicit viewer action (a button click), never on page load or in a loop — the first call in a view prompts the viewer for consent, waits on their answer, and costs their own usage.
6. Handle the `SampleError` shape by `.code`, not `.message`. At minimum branch on: `not_granted`/`sampling_disabled` (hide the feature, don't retry), `rate_limited` (tell the viewer to wait, don't auto-retry), `invalid_json`/`empty_completion`/`upstream_error`/`refused` (offer a manual "try again" button). Never retry from a loop.
7. Show a visible "Thinking..." state from click until the promise resolves or the first `onText` fires if streaming — the first real text can take 5-60s.

## Designing the adversarial structure

- Decide what the second (challenging/reviewing) agent is and isn't allowed to see. If the point is to catch sycophancy or motivated reasoning, strip the first agent's stated rationale/assumptions/reasoning out of the object before building the second agent's prompt — pass it only the concrete output (the numbers, the code, the claim), not the "why." Build this as a plain JS object transform (e.g. `{asset_class, percent, instruments_example}` only) so it's auditable in the code, not just implied by the prompt wording.
- Give the challenging agent an explicit, named checklist to work through (e.g. for a portfolio: concentration risk, correlation risk, unstated assumptions, worst-case/stress test, fee/liquidity/tax blind spots) and ask for one structured finding per checklist item, each with a flag (found a problem or not) and a short explanation — this produces UI that's easy to scan and prevents the challenger from being vague.
- Always leave a final, explicit human-judgment step in the page itself (a notes field + "save my decision" button) — the point of the tool is to arm the person's judgment with both sides, not to have the AI settle the question. Persist that decision with `localStorage` (per-viewer only, wrapped in try/catch) unless the person specifically wants it shared across viewers, in which case use the `db` capability instead.

## Design pass

Still run the normal `artifact-design` skill and the frontend-design principles: ground the visual metaphor in the *subject matter* of the adversarial task (a hearing/dossier/case-file feel suits a financial or legal review; something else suits a code review or a debate tool), give the two sides visually distinct treatment so the person can tell them apart at a glance, and avoid the generic AI-page tells (cream+terracotta, SaaS card kit, tracked-out ALL-CAPS eyebrows).

## Checklist before publishing

- [ ] No `fetch` to any Anthropic/Claude API endpoint anywhere in the page's JS
- [ ] `capabilities: {"sample": {}}` passed on the publish call
- [ ] `claude.use('sample')` resolved lazily, `null` handled by hiding/disabling, not throwing
- [ ] Every `sample`/`sample.json` call is triggered by an explicit click, not on load or in a loop
- [ ] Challenger agent's input is a checked, minimal object — not the full context — when blindness to reasoning is the point
- [ ] Errors branch on `e.code`; no automatic retries
- [ ] A human decision/notes step exists and is the last word in the page