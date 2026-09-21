# Portfolio Skills

ชุด Claude Skill สำหรับงานพอร์ตการลงทุน — ติดตั้งเป็น Claude Code plugin ได้ในคำสั่งเดียว

4 skill: จัดสัดส่วนสินทรัพย์อิงงานวิจัย · แผน ตัด/ถือ/ถัว · stress test พอร์ต · และหน้า AI ถก AI

## ติดตั้ง

```
/plugin marketplace add hoon-panphol/claude-plugins
/plugin install portfolio-skills@hoon-panphol
```

จากนั้นพิมพ์ `/reload-plugins` (หรือเปิด session ใหม่) แล้วใช้งานได้เลย — Skill จะถูก
เรียกอัตโนมัติเมื่อคุณถามเรื่องที่ตรงกับ description ของมัน ไม่ต้องพิมพ์ชื่อ skill เอง

ถ้าใช้บน claude.ai แทน: ดาวน์โหลดโฟลเดอร์ใน `skills/` แล้วอัปโหลดเป็น Skill ตามปกติ

## Skill ที่อยู่ในชุดนี้

| Skill | ใช้ตอนไหน | ได้อะไรกลับมา |
|---|---|---|
| `asset-allocation-research` | ถามเรื่องจัดสัดส่วนพอร์ต, diversification, correlation ระหว่างสินทรัพย์, ควร rebalance เมื่อไหร่ หรือต้องการ citation ประกอบบทความการลงทุน | คำตอบที่อ้างอิงเฉพาะแหล่งที่ตรวจสอบแล้ว (peer-reviewed ผ่าน DOI/Crossref + งานวิจัยสถาบันอย่าง Vanguard/Yale) พร้อม dashboard สัดส่วนพอร์ต |
| `portfolio-action-plan` | แปะรายการหุ้นที่ถืออยู่ (พิมพ์เอง, ไฟล์ หรือภาพหน้าจอแอปโบรก) แล้วถามว่าควรทำอะไรต่อ — "จัดพอร์ต", "ปรับพอร์ต", ตัด/ถือ/ถัว | แผนปฏิบัติการเรียงตามลำดับความสำคัญ ระบุตัวที่ควรตัด/ถือ/ถัว พร้อมจังหวะและจำนวนคร่าวๆ เทียบกับ benchmark (SET / S&P 500 / MSCI World) |
| `portfolio-stress-test` | อยากรู้ว่าพอร์ตทนแรงกระแทกได้แค่ไหน — "พอร์ตเสี่ยงไปไหม", "ถ้าเศรษฐกิจถดถอยจะเป็นยังไง", เช็ก allocation drift เทียบ rebalance band | dashboard ประเมินความทนทานรายตัว + สถานการณ์ช็อก (recession, rate shock, geopolitical, digital disruption) ตามกรอบ Capital Agenda |
| `ai-vs-ai-artifact` | อยากได้หน้าเว็บที่มี AI สองตัวถกกันสดๆ ในหน้านั้น — ตัวหนึ่งเสนอ อีกตัวเห็นแค่ตัวเลข (ไม่เห็นเหตุผล) แล้วไล่ค้านตาม checklist | Artifact ที่เผยแพร่ได้ แสดงทั้งฝั่งเสนอและฝั่งค้านคู่กัน ปิดท้ายด้วยช่องให้คุณบันทึกคำตัดสินของตัวเอง ใช้กับเรื่องอื่นได้ด้วย เช่น code review หรือถกแผนงาน |

## สิ่งที่ต้องมี

- Claude Code เวอร์ชันที่รองรับ plugin
- เปิด web search / web fetch ไว้ — ทั้ง 3 skill ดึงข้อมูลสดจากแหล่งที่เชื่อถือได้ ไม่ตอบจากความจำ
- ไม่ต้องติดตั้ง Python หรือ dependency ใดๆ เพิ่ม
- เฉพาะ `ai-vs-ai-artifact`: ต้องใช้งาน Artifact ได้ และหน้าที่สร้างจะเรียก Claude ด้วยโควตาของ**คนที่เปิดหน้านั้น** (ถามขออนุญาตก่อนเรียกครั้งแรกเสมอ)

## ขอบเขตการใช้งาน

Skill ชุดนี้ให้กรอบการวิเคราะห์และข้อมูลอ้างอิงเพื่อการศึกษา **ไม่ใช่คำแนะนำการลงทุนเฉพาะบุคคล**
ไม่ครอบคลุมเรื่องภาษี และไม่รับประกันความถูกต้องของราคาหรือข้อมูลแบบเรียลไทม์
ตัดสินใจลงทุนจริงควรตรวจสอบข้อมูลอีกครั้งและปรึกษาผู้แนะนำการลงทุนที่ได้รับใบอนุญาต

## พัฒนาต่อ

```
git clone https://github.com/hoon-panphol/claude-plugins
claude plugin validate ./claude-plugins
/plugin marketplace add ./claude-plugins    # ทดสอบจากเครื่องก่อน push
```

## License

MIT — ดู [LICENSE](../../LICENSE)
