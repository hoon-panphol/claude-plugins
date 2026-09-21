---
name: portfolio-stress-test
description: Runs a "Capital Agenda" stress test on an investment portfolio — an asset-allocation table (class / weight / amount / rebalance band) or a stock portfolio (symbol / quantity / cost basis, text or photo) — producing an on-screen HTML dashboard covering allocation drift, per-holding resilience scoring, and shock scenarios (recession, rate shock, geopolitical shock, digital-disruption/activist risk). Uses live web search against credible sources (central banks, IMF/World Bank, regulators, company IR, major financial press) for current macro/fundamental context on every single holding — never a sample. Trigger whenever the user wants to "stress test" a portfolio, check portfolio resilience/risk, review an allocation against rebalance bands, or get a risk dashboard for a list of stocks — even without the words "stress test", e.g. "is my portfolio too risky", "check my asset allocation", "how exposed am I to a recession", or they paste/photograph a holdings table for review.
---

# Portfolio Capital-Agenda Stress Test

Adapts the four-part "Capital Agenda" framework from *The Stress Test Every Business Needs*
(EY / Wiley) — Raising, Investing, Optimizing, Preserving capital, stress-tested against
recession, geopolitical, digital-disruption, and activist-investor risk — from corporate
finance to a personal investment portfolio. Output is an HTML dashboard rendered inline in
this chat (not a downloadable file, not published for external sharing unless the person
asks).

## Step 0 — Read the framework first

Before doing anything else, read both reference files in full — they define the scoring
rubric and the scenario math this whole skill runs on:
- `references/capital-agenda-framework.md` — the 4-dimension scoring rubric + stress flags
- `references/stress-scenarios.md` — the 4 shock scenarios and magnitude ranges

## Step 1 — Get the portfolio

Accept either input shape:
- **Asset allocation table**: asset class, weight %, amount, rebalance band (e.g. the Thai
  table style: หุ้นไทย / หุ้นโลก / ตราสารหนี้ / ทองคำ / REITs, with a rebalance range like 10–20%)
- **Stock portfolio**: symbol, quantity, cost basis — as typed text or as an
  uploaded photo/screenshot (read it with vision; if any row is genuinely unreadable, ask
  the user to confirm just that row rather than guessing — but don't stall on rows you can
  read fine)

If the message doesn't make clear whether the user wants asset-allocation-level analysis,
stock-level analysis, or both, ask once before starting the research (this determines the
whole research plan and is expensive to redo).

## Step 2 — Research every holding, no exceptions

This is a "go deep" skill — thoroughness matters more than speed. For **every single**
asset class or stock in the portfolio (a 12-stock portfolio means 12 full research passes,
not a sample), run 3–5 targeted web searches covering:

1. Current price/valuation snapshot (P/E, P/B, dividend/coupon yield, or the asset-class
   equivalent — credit spread, real yield, etc.)
2. Macro outlook for that asset class / sector / country (most recent outlook available —
   growth, inflation, central bank stance)
3. Fundamental/company-specific developments — earnings, guidance, debt levels, competitive
   position, governance news (stocks only)
4. Geopolitical or regulatory exposure specific to that holding
5. Analyst consensus, credit rating, or institutional outlook where available

**Source bar**: prioritize central banks, IMF/World Bank, exchange/regulator filings (SEC,
SET, etc.), company investor-relations pages, and major financial press (Reuters, Bloomberg,
WSJ, FT, Nikkei Asia, Morningstar, S&P/Moody's/Fitch). Skip forums, unverified blogs, and
promotional content. Track the source and "as of" date for every figure you plan to put on
the dashboard.

Do the full research pass for every holding *before* moving to scoring — keep a compact
internal note per holding (price, 1-line macro view, 1-line fundamental view, key risk flag,
source + date) so Step 3 is just scoring against notes you already have.

## Step 3 — Score every holding

Apply the rubric in `references/capital-agenda-framework.md`:
- 4 dimension scores (Raising / Investing / Optimizing / Preserving), 1–5, each with a
  one-sentence justification grounded in what you found in Step 2
- The 4 stress flags (recession / digital disruption / difficult-investors-governance /
  geopolitical), yes-or-no + one line each

## Step 4 — Portfolio-level analysis

- **Allocation drift**: current weight vs. target vs. rebalance band; flag any breach
- **Concentration**: any single holding or correlated cluster that dominates the portfolio
- **Weighted dimension scores**: portfolio-level Raising/Investing/Optimizing/Preserving
  score (weight-averaged across holdings)
- **Scenario stress test**: apply all 4 scenarios from `references/stress-scenarios.md`,
  using researched sensitivities where you found them and the file's default ranges
  otherwise — always as ranges, never fake-precise single numbers. Show top 3 contributors
  to downside per scenario.
- **Benchmark reference** (optional but valuable): if there's an obvious comparator (e.g. a
  simple 60/40, a relevant local index, or a standard model portfolio), note briefly how this
  portfolio's scenario resilience compares — keep this light, not a full second analysis.

## Step 5 — Build the dashboard

Read `/mnt/skills/public/frontend-design/SKILL.md` before writing any HTML — apply its
guidance on typography, layout and avoiding generic/templated look. Build one self-contained
HTML file with:

- **Header**: overall portfolio resilience grade (a simple traffic-light or score-out-of-5),
  "as of" date, one-line summary of the single biggest risk
- **Allocation table**: current vs. target vs. band, breaches visually flagged
- **Per-holding cards**: name, weight, the 4 dimension scores (small bar/radar), the 4
  stress flags, 2–3 line outlook summary, source links with dates
- **Scenario panel**: the 4 scenarios with portfolio-impact ranges and top contributors
- **Footer**: full source list, and a plain disclaimer that this is a resilience/risk
  mapping exercise, not investment advice or a buy/sell recommendation

Save the file to `/mnt/user-data/outputs/` and use the Artifact tool (publish) so it renders
inline in this chat. The person just wants to view it here — don't proactively push them to
share the link.

## Guardrails

- Never skip, sample, or "represent" a subset of holdings to save time — every holding gets
  the full research pass.
- Never invent a precise number (a beta, a credit rating, an exact price) you didn't
  actually find — say "not found" or give a qualitative read instead.
- Keep this to resilience/risk mapping. Don't issue buy/sell/hold recommendations or
  personalized financial advice — describe exposures and let the person draw conclusions.
