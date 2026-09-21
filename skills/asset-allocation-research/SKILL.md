---
name: asset-allocation-research
description: Provides academically-grounded principles for asset allocation, diversification, cross-asset correlation, and portfolio rebalancing, backed by verified sources (peer-reviewed papers via DOI/Crossref, and institutional research from Vanguard/Yale/etc). Use this skill whenever the user asks about portfolio construction, asset allocation strategy, how to diversify a portfolio, correlation between asset classes, when/how to rebalance a portfolio, or wants citations/evidence for investment-related writing (reports, articles, educational content). Also trigger when the user wants to fetch, verify, or refresh a library of trustworthy financial research sources. Do not use for tax advice, specific security recommendations, or real-time market data.
---

# Asset Allocation & Rebalancing Research Skill

หน้าที่ของ skill นี้คือให้ Claude ตอบคำถามเรื่อง asset allocation / diversification / correlation / rebalancing
โดยอิงหลักการจากแหล่งที่ **ตรวจสอบได้จริง** เท่านั้น (ไม่ใช้ความจำหรือคาดเดา) และสามารถ **รีเฟรชแหล่งอ้างอิง**
ผ่านสคริปต์ Python ที่ตรวจสอบความน่าเชื่อถือของแหล่งข้อมูลก่อนนำไปใช้เสมอ

## หลักการที่ต้องใช้ (Core Principles)

รายละเอียดเต็มอยู่ที่ `references/principles.md` — อ่านไฟล์นี้ก่อนตอบคำถามเชิงลึกทุกครั้ง สรุปสั้นๆ:

1. **Diversification / Correlation** — อิง Markowitz (1952) Modern Portfolio Theory: ความเสี่ยงพอร์ตรวมลดลงเมื่อสินทรัพย์มี correlation ต่ำหรือติดลบ ไม่ใช่แค่ผลรวมถ่วงน้ำหนักของความเสี่ยงแต่ละตัว
2. **Asset Allocation Frameworks** — เลือกกรอบตามบริบทผู้ใช้:
   - Yale/Endowment Model (Swensen) — นักลงทุนระยะยาวมาก รับความเสี่ยงสูง มีสินทรัพย์ทางเลือก
   - All Weather / Risk Parity (Dalio) — เน้นความทนทานทุกสภาวะเศรษฐกิจ
   - Index/Passive (Bogle, EMH) — นักลงทุนรายย่อย ต้นทุนต่ำ
3. **Rebalancing** — อิงงานวิจัยเชิงประจักษ์ของ Vanguard: threshold-based rebalancing มักมีประสิทธิภาพ cost-adjusted ดีกว่า calendar-based ล้วนๆ ในช่วงตลาดผันผวนสูง การ rebalance ถี่เกินไปอาจลดประสิทธิภาพสุทธิ (หลังหักต้นทุนธุรกรรม/ภาษี)
4. **Outlook ปัจจุบัน** — ตัวเลขคาดการณ์ผลตอบแทน/ความเสี่ยง 10 ปีข้างหน้า (Vanguard VCMM) และภาพเศรษฐกิจมหภาค (IMF WEO) — เป็น "การคาดการณ์" ไม่ใช่ "ข้อเท็จจริงถาวร" ต้องระบุวันที่เผยแพร่เสมอ
5. **Macro & Geopolitical Risk** — ดอกเบี้ยนโยบาย (Fed FOMC), เสถียรภาพธนาคาร/ระบบการเงิน (IMF GFSR, BIS Quarterly Review), ความเสี่ยงภูมิศาสตร์ (Caldara & Iacoviello GPR Index) — กลุ่มนี้ล้าสมัยเร็วที่สุด (ดอกเบี้ยเปลี่ยนได้ทุก ~6 สัปดาห์) ห้ามใช้ตัวเลขจากความจำเด็ดขาด

**กฎสำคัญ:** ห้ามอ้างตัวเลขหรือข้อสรุปเชิงวิชาการโดยไม่มีแหล่งอ้างอิงใน `references/sources.json` ที่ผ่านการตรวจสอบแล้ว (status = "verified") หากแหล่งข้อมูลยังไม่ได้ตรวจสอบหรือตรวจสอบไม่ผ่าน ให้บอกผู้ใช้ตรงๆ ว่ายังไม่ยืนยันได้ แทนที่จะเดา

## แหล่งอ้างอิงที่เชื่อถือได้ (Trusted Sources)

เก็บอยู่ที่ `references/sources.json` แบ่งเป็น 3 ชั้นความน่าเชื่อถือ (โดเมน):

| ชั้น | ประเภท | ตัวอย่างโดเมนที่อนุญาต | วิธีตรวจสอบโดเมน |
|---|---|---|---|
| Tier 1 | Peer-reviewed journal / มี DOI | jstor.org, afajof.org (Journal of Finance), sciencedirect.com, nber.org, arxiv.org (preprint เท่านั้น ต้องระบุว่าเป็น preprint) | resolve DOI ผ่าน Crossref API (`api.crossref.org`) |
| Tier 2 | Institutional research | vanguard.com, blackrock.com, ssga.com, msci.com | ตรวจโดเมนตรงกับ whitelist + HTTP 200 + (ถ้ามี) ตรวจ snapshot บน Wayback Machine |
| Tier 3 | Regulator / ธนาคารกลาง / องค์กรระหว่างประเทศ | sec.gov, federalreserve.gov, bis.org, imf.org, oecd.org, fred.stlouisfed.org, sec.or.th, bot.or.th | ตรวจโดเมน .gov/.org ของหน่วยงานทางการ + HTTP 200 |

ห้ามใช้แหล่งที่ไม่อยู่ในสามชั้นนี้ (บล็อกส่วนตัว, สื่อรอง, forum) เป็นหลักฐานเชิงวิชาการ — ใช้ได้แค่ประกอบความเข้าใจ ไม่ใช่การอ้างอิง

### สองประเภทข้อมูล: Fact vs Outlook — ตรวจสอบคนละแบบ

`sources.json` แยกแต่ละแหล่งด้วย field `type` ซึ่งกำหนดวิธีตรวจสอบและวิธีใช้อ้างอิงต่างกัน:

| type | ความหมาย | ตัวอย่าง | ตรวจสอบครั้งเดียวพอไหม |
|---|---|---|---|
| `journal_article` | งานวิจัยที่ตีพิมพ์แล้ว (fact/theory คงที่) | Markowitz (1952) | ✅ พอ — ทฤษฎีไม่เปลี่ยน |
| `institutional_research_paper` | งานวิจัยเชิงประจักษ์ของสถาบัน (มักอิงข้อมูลย้อนหลังช่วงที่ระบุไว้ตายตัว) | Vanguard rebalancing studies | ✅ พอ — ผลการศึกษาย้อนหลังไม่เปลี่ยนแม้เวลาผ่านไป |
| `institutional_outlook_report` | **มุมมองคาดการณ์ (forecast) ที่ล้าสมัยได้** | Vanguard VEMO 2026, IMF WEO | ❌ **ต้องตรวจ "ความเก่า" (staleness) ทุกครั้ง** ก่อนอ้างว่าเป็น "ปัจจุบัน" |
| `live_data_api` | แหล่งข้อมูลราคา/สถิติที่อัปเดตต่อเนื่อง ใช้คำนวณ correlation เองจากข้อมูลจริง | FRED API | ตรวจแค่ endpoint ใช้งานได้ — ตัวข้อมูลต้องดึงใหม่ทุกครั้งที่ใช้ ไม่ cache |

**กฎการอ้างอิง outlook:** แม้ status จะเป็น `verified` ก็ต้องพูดว่า "ข้อมูล ณ วันที่ ..." เสมอ ห้ามพูดราวกับเป็นข้อเท็จจริงถาวร เพราะเป็นการคาดการณ์ที่จะถูกแก้ไขในรายงานฉบับถัดไป ถ้า `status: "stale_needs_refresh"` (เกิน `max_staleness_days`) ห้ามใช้อ้างอิง ให้ไปเช็ค `hub_url` เพื่อหาฉบับใหม่กว่าแทน

## Flow การดึงและตรวจสอบข้อมูล (ใช้ tools ของ Claude เอง — ไม่มี Python script แยก)

เมื่อ skill นี้ทำงาน Claude ตรวจสอบแหล่งข้อมูลด้วย `web_search` และ `web_fetch` ที่มีอยู่แล้วโดยตรง
(เป็น read-only tool ใช้ได้ทันทีไม่ต้องขอ approval จากผู้ใช้) ตามขั้นตอนนี้:

```
1. เปิดอ่าน references/sources.json เพื่อดูรายการแหล่งข้อมูลทั้งหมดและสถานะล่าสุด
2. สำหรับแต่ละแหล่งที่ต้องตรวจ (หรือทุกแหล่งถ้าผู้ใช้ขอให้ "รีเฟรช"):
   a. ตรวจโดเมนของ url กับ references/trusted_domains.json (whitelist) ด้วยสายตา/เทียบ hostname
      → ถ้าไม่อยู่ใน whitelist เลย ห้ามใช้เป็นหลักฐาน ข้ามไปแหล่งถัดไป
   b. เรียก web_search ด้วยคำค้นสั้นๆ จากชื่อเรื่อง+ผู้แต่ง+ปี เพื่อยืนยันว่าแหล่งนี้มีอยู่จริง
      และตรวจว่าผลลัพธ์มาจากโดเมนที่ publisher ตัวจริง (เช่น onlinelibrary.wiley.com, academic.oup.com,
      corporate.vanguard.com, imf.org) ไม่ใช่แค่เว็บที่พูดถึงมัน
   c. ถ้าจำเป็นต้องดูเนื้อหาเต็ม (เช่น จะอ้างตัวเลขเฉพาะ) ให้ web_fetch ที่ url โดยตรง
   d. สำหรับ type = "institutional_outlook_report": เทียบ published_date ที่บันทึกไว้กับวันที่ปัจจุบัน
      ถ้าห่างเกิน max_staleness_days → ให้ web_search คำว่า "[ชื่อรายงาน] latest" เพื่อหาฉบับใหม่กว่า
      จาก hub_url แล้วอัปเดต published_date/url ใน sources.json
   e. สำหรับ type = "live_data_api": ไม่ต้อง fetch ข้อมูลจริง (ต้องมี API key ส่วนตัวของผู้ใช้)
      แค่ตรวจว่า endpoint/เอกสารยังอยู่ที่โดเมนเดิมหรือไม่
3. แก้ไข references/sources.json ด้วย str_replace/bash (แก้ field status, verified_at,
   verification_evidence โดยตรง) — บันทึก method: "web_search" หรือ "web_fetch" และ url ที่ใช้ยืนยันไว้เสมอ
4. เมื่อสร้างคำตอบ/บทความ ใช้เฉพาะแหล่งที่ status = "verified" และยังไม่เกิน max_staleness_days
   สำหรับ type = "institutional_outlook_report" ต้องพูด "ข้อมูล ณ วันที่ ..." เสมอ
```

**ข้อดีของวิธีนี้เทียบกับ script แยก:** ไม่ต้องติดตั้ง dependency, ไม่ติดปัญหา network sandbox,
ใช้ความสามารถตัดสินใจของ Claude เองในการอ่านหน้าเว็บจริงว่าใช่ publisher ตัวจริงหรือไม่ (ซึ่ง Python
script ทำแทนไม่ได้ดีเท่า — script เช็คได้แค่ HTTP status/DOI metadata แต่ไม่เข้าใจบริบทหน้าเว็บ)

## เมื่อ Claude ตอบคำถามผู้ใช้โดยใช้ skill นี้

1. อ่าน `references/principles.md` เพื่อดึงหลักการที่เกี่ยวข้อง
2. อ่าน `references/sources.json` และใช้เฉพาะรายการที่ `status: "verified"` เป็นหลักฐานอ้างอิง
   ตรวจ `verified_at` + `max_staleness_days` ด้วยว่ายังไม่เก่าเกินไป (โดยเฉพาะ `fed_fomc_policy_current`
   ที่ล้าสมัยเร็วมาก — เช็คว่ามีมติ FOMC ใหม่กว่าที่บันทึกไว้หรือยังก่อนอ้างอิงเรื่องดอกเบี้ยเสมอ)
3. ถ้าคำถามต้องการแหล่งใหม่ที่ยังไม่มีในลิสต์ หรือแหล่งเดิมเก่าเกินไปแล้ว → ใช้ `web_search`/`web_fetch`
   ตรวจสอบตาม Flow ด้านบนทันที (ไม่ต้องขอ approval เพราะเป็น read-only tool) แล้วอัปเดต sources.json
4. ห้ามคัดลอกข้อความต้นฉบับเกิน 15 คำต่อประโยค (ตามนโยบายลิขสิทธิ์) — สรุปด้วยคำพูดตัวเอง อ้างอิงด้วยชื่อผู้แต่ง/ปี/แหล่งเท่านั้น

### Output บังคับเมื่อคำตอบมีการ "จัดสัดส่วนพอร์ต" จริง (ไม่ต้องรอผู้ใช้ขอ)

เงื่อนไขที่ทริกเกอร์: คำตอบมีการระบุสัดส่วน % ของ asset class ตั้งแต่ 3 ประเภทขึ้นไป สำหรับเงินลงทุนจำนวนหนึ่ง
(เช่น "จัดพอร์ต X บาท", "แนะนำสัดส่วนการลงทุน") — ไม่ใช่แค่คำถามเชิงทฤษฎีทั่วไป (เช่น "correlation คืออะไร")
เมื่อเข้าเงื่อนไขนี้ Claude ต้องทำ 2 อย่างนี้เสมอ โดยไม่ต้องรอให้ผู้ใช้พิมพ์คำว่า "dashboard" หรือ "แสดงกราฟ":

**5. แสดง dashboard สัดส่วนพอร์ตแบบ inline เสมอ**
ใช้ Visualizer (`mcp__visualize__show_widget`, module `chart`) ถ้ามี — ถ้าไม่มี (เช่นบน Claude Code)
ให้ถอยไปทำเป็น HTML artifact หรือตาราง markdown แทน โดยยังต้องแสดงครบทั้ง 3 อย่างนี้:
   - KPI cards: เงินลงทุนรวม, ระยะเวลา, ระดับความเสี่ยง, สัดส่วนกลุ่มเติบโต/ป้องกัน
   - Donut/pie chart ของสัดส่วน asset class ทุกประเภท พร้อม legend และ tooltip เป็น %
   - ตาราง breakdown: asset class / สัดส่วน / จำนวนเงินจริง (บาท)
   เหตุผลที่บังคับเสมอ: สัดส่วนพอร์ตเป็นข้อมูลแบบ part-to-whole ซึ่งอ่านจากตัวเลขในข้อความอย่างเดียวเข้าใจยากกว่าดูภาพ
   ถือเป็น "data shape" ที่สมควรมีภาพประกอบเสมอตามหลัก proactive visualization ไม่ใช่ตัวเลือกเสริม

**6. ปิดท้ายบทความด้วยสรุปแหล่งอ้างอิงและเหตุผล เสมอ**
เพิ่ม section สั้นๆ ท้ายคำตอบ (หลัง dashboard) หัวข้อ "สรุปแหล่งอ้างอิงและเหตุผล" รูปแบบ bullet ไม่เกิน ~150 คำ ระบุ:
   - หลักการที่ใช้ + แหล่งอ้างอิง (ชื่อผู้แต่ง, ปี, source id จาก sources.json) แยกตามหมวด:
     กระจายความเสี่ยง/correlation, outlook ปัจจุบัน (ต้องระบุ "ข้อมูล ณ วันที่ ..."), macro/ดอกเบี้ย/geopolitical, rebalancing
   - ถ้าใช้แหล่งที่ไม่ได้อยู่ใน sources.json เดิม (เพิ่งค้นด้วย web_search ตามข้อ 3) ให้ระบุด้วยว่าเป็นแหล่งใหม่ที่เพิ่งตรวจสอบ
   ตัวอย่างรูปแบบ:
   ```
   ### สรุปแหล่งอ้างอิงและเหตุผล
   - กระจายความเสี่ยง/correlation: Markowitz (1952), DeMiguel et al. (2009)
   - Outlook ปัจจุบัน: Vanguard VEMO (ข้อมูล ณ 10 ธ.ค. 2025), IMF WEO (ข้อมูล ณ 8 ก.ค. 2026)
   - Macro/ดอกเบี้ย: Fed FOMC (มติล่าสุด 29 ก.ค. 2026 — ควรเช็คซ้ำถ้ามีมติใหม่กว่านี้)
   - Rebalancing: Vanguard threshold-based rebalancing research (2010, 2022, 2024)
   ```

## Reference files

- `references/principles.md` — สรุปหลักการ MPT, correlation, rebalancing, outlook, macro/geopolitical แบบเจาะลึกพร้อมสูตรคำนวณเบื้องต้น
- `references/sources.json` — ฐานข้อมูลแหล่งอ้างอิง 14 รายการ พร้อมสถานะการตรวจสอบและหลักฐาน (ตรวจด้วย web_search/web_fetch ของ Claude เอง)
- `references/trusted_domains.json` — whitelist โดเมนที่อนุญาต แบ่งตาม tier
