# Decision framework — full reasoning

## 1. Concentration overrides individual stock opinion

Markowitz (1952), the foundation of Modern Portfolio Theory: portfolio
variance depends on covariance between holdings, not just the weighted sum of
each holding's own risk —

```
σ_p² = w1²σ1² + w2²σ2² + 2·w1·w2·ρ(1,2)·σ1·σ2
```

A single holding above ~20-25% of portfolio value means the portfolio's
outcome is dominated by that one company's idiosyncratic risk almost
regardless of how well-diversified the rest looks. This is a structural flag,
independent of whether you're bullish or bearish on the company — trim for
sizing reasons even if you'd rate the stock a "hold" or "buy" in isolation.
Caveat to state when explaining this: DeMiguel et al. (2009) found
naive 1/N portfolios often perform comparably to "optimized" ones
out-of-sample, because covariance estimates from historical data are noisy —
so this isn't a precise optimization exercise, it's a blunt-but-important
sizing discipline.

## 2. Valuation gap vs analyst consensus

When current price has run up to or past the analyst consensus target price,
that's a signal to take partial profit — not because the stock is bad, but
because the market-implied upside has compressed. This is a lighter-weight,
more practical signal than a full DCF, and should be presented as such
("ราคาใกล้/เกินเป้าหมายที่นักวิเคราะห์ส่วนใหญ่ประเมินไว้ ณ วันที่ ...") — always
with the date, since targets move every earnings season.

## 3. Structural impairment vs ordinary drawdown

Distinguish two very different reasons a stock is down big:
- **Ordinary drawdown**: business still operates normally, sector or company
  is just out of favor or mid-cycle. These are "cut or hold" judgment calls
  based on catalyst visibility, not automatic sells.
- **Structural impairment**: debt default, forced-sell / margin-call cascade
  by major shareholders, going-concern doubt, regulatory delisting track.
  These very rarely mean-revert on the original investment thesis. Recommend
  exiting rather than waiting, and say so plainly — "รอเก็บคืนทุน" (waiting
  to break even) is not a strategy once the thesis is structurally broken.

## 4. Rebalancing cadence

Vanguard's research (2010 study of 1926-2009 data; refreshed 2022 and 2024)
found rebalancing *frequency* matters less than having *a* consistent rule.
Threshold-based rebalancing (rebalance when a holding drifts past a band,
rather than on a fixed calendar) tends to perform better net of transaction
costs than pure calendar-based rebalancing. Practical takeaway for the
skill's output: end every action plan with a standing rule (e.g., "revisit if
any single holding exceeds 20% of portfolio, or if a position without a
fundamental catalyst is down more than 25%") rather than implying the person
needs to re-run this analysis from scratch every time.

## 5. Averaging down (ถัว) — when it's reasonable vs when it's just anchoring

Only recommend adding to a losing or flat position when ALL of:
- The position is currently a small weight in the portfolio (adding to a
  position that's already large compounds concentration risk regardless of
  fundamentals)
- There's a specific, named catalyst (not just "it's cheap now") — a sector
  tailwind, a valuation gap vs comparable peers, a demonstrated earnings
  inflection
- The recommended add is staged/DCA-framed, not a lump sum, so the person
  isn't making a large one-time bet on timing

Never frame averaging down as a way to "reduce average cost" as if that were
inherently good — cost basis is a sunk-cost artifact, not a reason to buy
more. The reason to add must stand on its own regardless of what the current
average cost happens to be.

## Citation discipline

Same rules as the `asset-allocation-research` skill when both are available
in the environment: author + year for academic/institutional principles,
15-word max per direct quote, one quote per source, paraphrase everything
beyond that. Outlook/forecast-type data (analyst targets, macro views) always
gets an "ข้อมูล ณ วันที่ ..." qualifier since it goes stale; historical
research findings (Markowitz, Vanguard studies) don't need that qualifier
since the study itself is a fixed historical fact.
