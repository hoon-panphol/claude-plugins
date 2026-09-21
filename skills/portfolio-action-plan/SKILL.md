---
name: portfolio-action-plan
description: >
  Produces a concrete ตัด/ถือ/ถัว (cut/hold/average-down) action plan for a stock portfolio (Thai and/or foreign), ranked by priority with suggested timing and quantity, not just a risk-mapping dashboard. Combines fundamental research, technical/analyst-consensus signals, and a benchmark comparison against a relevant index (SET Index for Thai equities, S&P 500 / MSCI World for foreign equities), grounded in academic portfolio-theory reasoning (Markowitz diversification/concentration risk, valuation-gap vs analyst targets, Vanguard rebalancing research). Trigger this whenever the user shares a portfolio (typed list, spreadsheet, or a screenshot/photo of a broker app) and asks what to do with it, wants a buy/sell/hold recommendation, asks to "manage", "จัดพอร์ต", "ปรับพอร์ต" or "วิเคราะห์พอร์ต" their holdings, or explicitly asks for ตัด/ถือ/ถัว guidance, even if they don't use those exact words. This is different from a pure risk/resilience dashboard - the deliverable here is a specific, ranked list of actions.
---

# Portfolio Action Plan (ตัด / ถือ / ถัว)

Produces a concrete, ranked action plan for an existing stock portfolio — which
holdings to cut, which to hold, which to average into (ถัว) — with suggested
priority order, rough timing, and quantity/percentage. This goes further than
a risk-mapping dashboard: the person wants to know what to actually do.

## Step 0 — Sanity-check the data before anything else

Portfolio screenshots are very often stale (old app session, cached price).
Before treating any price in the input as current:
- Look for timestamp clues (last-login stamps, visible dates, index level
  shown alongside the portfolio).
- If a broad index level appears in the screenshot (e.g. SET Index number),
  web_search the index's actual current level. A gap of more than a few
  percent means the screenshot is stale.
- If stale, tell the person plainly, and propose: keep quantity + avg cost
  (those don't change on their own) but re-fetch every current market price
  by search rather than trusting the screenshot's "market price" / P&L column.
  Confirm this plan with the person before doing 10+ searches on their behalf.
- Never silently present stale % P&L as if it were current.

## Step 1 — Get the portfolio and scope

Accept typed lists, spreadsheets, or photos/screenshots (read via vision).
Required per holding: symbol, quantity, average cost. Nice to have: purchase
date(s). Ask once, up front, whether the person wants Thai holdings, foreign
holdings, or both analyzed — this determines which index to benchmark against
and doesn't need to be re-asked mid-analysis.

## Step 2 — Research every holding, no sampling

For each holding (not a subset — a 12-stock portfolio means 12 research
passes), search for:
1. Current price (search directly — don't reuse a screenshot price)
2. Recent fundamentals: latest quarter earnings trend, margin, guidance
3. Analyst consensus target price and rating (buy/hold/sell) — this is the
   single most useful number for the valuation-gap judgment in Step 4
4. Technical/momentum read if available (trend, support/resistance, recent
   analyst technical notes) — treat as supporting color, not the primary
   driver, since public technical commentary is noisy
5. Any structural red flags: debt default, forced-sell events, going-concern
   language, regulatory action — these override normal valuation logic (see
   Step 4, "structural impairment" category)

Source bar: exchange sites (SET, stock exchange investor pages), sell-side
research summarized in reputable financial press, company IR. Track price
"as of" dates — every price in the eventual output should be traceable.

## Step 3 — Benchmark against the index

Compare portfolio-level return (weighted by current value, not cost) against
the relevant index over a comparable period:
- Thai equities → SET Index (or SET50 if the holdings are large-cap heavy)
- Foreign equities → S&P 500 and/or MSCI World depending on geography mix
Search the index's current level and recent trend. This contextualizes
whether the portfolio's pain points are stock-specific or market-wide.

## Step 4 — Apply the decision framework

Classify every holding into one of four buckets. Do this explicitly per
holding — don't skip straight to a table.

**Cut** — sell some or all:
- Structural impairment: debt default, forced-sell event, going-concern
  doubt, regulatory delisting risk. These don't mean-revert; hold-and-hope is
  not a strategy. Recommend full exit.
- Weak fundamentals + no visible catalyst + no analyst buy rating: sustained
  large loss with a business that's structurally slowing (e.g. shrinking
  sector, no earnings inflection in sight). Recommend exit or heavy trim,
  but give it a short evaluation window (e.g. "re-check in 1 month, cut if no
  positive catalyst by then") rather than forcing an immediate all-or-nothing
  call — see `references/decision-framework.md` for the full reasoning.

**Trim (reduce, don't zero out)**:
- Concentration risk: any single holding above roughly 20-25% of portfolio
  value gets flagged for trimming *regardless of view on the company* — cite
  Markowitz (1952): portfolio risk depends on correlation/concentration, not
  just the sum of individual risks. This is the highest-priority action when
  it applies, because it dominates portfolio-level risk more than any single
  stock's fundamentals.
- Valuation caught up to or exceeded analyst consensus target: take partial
  profit, don't hold blindly expecting further re-rating.

**Hold**:
- Reasonable weight, positive or improving fundamentals, analyst target still
  meaningfully above current price. No action needed; just monitor next
  earnings.

**Average down / ถัว (add)**:
- Only for holdings that are BOTH currently small weight in the portfolio AND
  have a credible re-rating catalyst (sector tailwind, cheap valuation vs
  peers, high dividend yield as downside cushion). Recommend modest,
  staged additions (explicit DCA framing), never a lump-sum add, and never
  into a name that's already a large portfolio weight even if fundamentals
  look fine — that's compounding concentration risk, not diversifying it.

Full reasoning and citations: `references/decision-framework.md`.

## Step 5 — Required outputs

Because this produces a concrete allocation-adjustment recommendation
(equivalent to "จัดสัดส่วนพอร์ต" for 3+ holdings), always include:

1. **Visual dashboard** — use the Visualizer (`mcp__visualize__show_widget`,
   `chart` module) if it is available; if it is not (e.g. in Claude Code), fall
   back to a self-contained HTML artifact, or a plain markdown table when even
   that is unavailable. Either way show: KPI cards (total value, total P/L, index level,
   largest single position), and a horizontal bar chart of %P/L per holding
   color-coded by action bucket (cut=red, trim=amber, hold=blue, add=green).
2. **Per-holding table** in the response text: weight, P/L%, one-line
   fundamental read, analyst rating/target, one-line technical read,
   recommended action. Don't repeat the chart's numbers verbatim — the table
   carries the reasoning, the chart carries the shape.
3. **Ranked, step-by-step action plan** — use `step_card_display_v0` if
   available, else a numbered list. Order by priority (structural
   impairments first, then concentration fixes, then profit-taking, then
   watch-list items, then holds, then adds, then a standing rebalance rule).
   Each step needs a rough quantity/percentage and rough timing — "sell all",
   "trim to ~10-12% of portfolio over 2-4 weeks in tranches", "small DCA
   monthly" — not just a direction.
4. **Sources & reasoning summary** at the end, ~150 words, bulleted by
   category (concentration/diversification, valuation gap, rebalancing
   research, any structural red flags), each with author/year or publication
   + date. This is mandatory whenever the response includes an actual
   proportion/action adjustment, per the citation discipline in
   `references/decision-framework.md`.

## Guardrails

- This produces an actionable framework grounded in reasoning the person can
  evaluate, not a personalized financial-advice guarantee. Say once, plainly,
  that this isn't a substitute for personal financial/tax advice — then don't
  repeat the disclaimer after every holding.
- Never invent an analyst target, price, or financial figure not found via
  search — say "ไม่พบราคาเป้าหมายที่ชัดเจน" instead of guessing.
- Every price used must carry a traceable "as of" date somewhere in the
  research trail (doesn't need to clutter the final table, but be ready to
  cite it if asked).
- Cite academic/institutional sources the way `asset-allocation-research`
  does when available in this environment — same 15-word quote limit,
  paraphrase-first discipline.
