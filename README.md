# Claude Plugins by hoon-panphol

Marketplace ปลั๊กอิน Claude — เครื่องมือวิเคราะห์การลงทุนและข้อมูลตลาดหุ้นไทย

## เริ่มใช้งาน

เพิ่ม marketplace นี้ครั้งเดียว แล้วเลือกลงปลั๊กอินที่ต้องการ

```
/plugin marketplace add hoon-panphol/claude-plugins
/plugin install portfolio-skills@hoon-panphol
```

จากนั้น `/reload-plugins` หรือเปิด session ใหม่

## ปลั๊กอินในนี้

| ปลั๊กอิน | ทำอะไร | ติดตั้ง |
|---|---|---|
| [portfolio-skills](plugins/portfolio-skills) | 4 Skill สำหรับงานพอร์ตการลงทุน — จัดสัดส่วนสินทรัพย์อิงงานวิจัยที่ตรวจแหล่งได้, แผน ตัด/ถือ/ถัว รายตัว, stress test พอร์ตตามกรอบ Capital Agenda และหน้า Artifact ที่ให้ AI สองตัวถกกัน | `/plugin install portfolio-skills@hoon-panphol` |
| [aiomax](plugins/aiomax) | เชื่อม Claude เข้ากับคลังข้อมูล AiOMax ผ่าน MCP — ข่าว งบ ปันผล ผู้ถือหุ้น สกรีนหุ้นเชิงตัวเลข/เทคนิค กองทุน ทอง คริปโต และข้อมูลมหภาค ตอบจากข้อมูลจริง ไม่ใช่ความจำของโมเดล (ต้องเป็นสมาชิก AiOMax) | `/plugin install aiomax@hoon-panphol` |

## ใช้ที่ไหนได้บ้าง

`/plugin` เป็นคำสั่งของ **Claude Code** (ทั้งแบบ CLI, ในแอป Desktop และบนเว็บที่ claude.ai/code)
ถ้าคุณใช้ **Claude Desktop หรือ claude.ai แบบแชทธรรมดา** ยังใช้ได้เหมือนกัน แค่ติดตั้งคนละทาง

| | Claude Code | Claude Desktop / claude.ai (แชท) |
|---|---|---|
| **portfolio-skills** | `/plugin install portfolio-skills@hoon-panphol` | Customize → Skills → **+** → Create skill แล้วอัปโหลดไฟล์ `.zip` จาก [`dist/`](dist) ทีละตัว |
| **aiomax** | `/plugin install aiomax@hoon-panphol` | Customize → Connectors → **Add custom connector** แล้ววาง `https://aiomax.panphol.com/mcp` |

รายละเอียดแต่ละทางอยู่ใน README ของปลั๊กอินนั้นๆ

## โครงสร้าง repo

```
claude-plugins/
├── .claude-plugin/
│   └── marketplace.json        ← รายชื่อปลั๊กอินทั้งหมด
├── dist/                       ← ไฟล์ .zip พร้อมอัปโหลดสำหรับ Desktop/web
├── scripts/build-skill-zips.sh ← สร้างไฟล์ใน dist/ ใหม่หลังแก้ skill
└── plugins/
    ├── portfolio-skills/
    │   ├── .claude-plugin/plugin.json
    │   ├── skills/
    │   └── README.md
    └── aiomax/
        ├── .claude-plugin/plugin.json
        ├── .mcp.json
        └── README.md
```

เพิ่มปลั๊กอินตัวใหม่ = สร้างโฟลเดอร์ใต้ `plugins/` พร้อม `.claude-plugin/plugin.json`
แล้วเพิ่มอีกรายการใน `.claude-plugin/marketplace.json` โดยชี้ `source` เป็น path แบบ relative

## พัฒนาต่อ

```
git clone https://github.com/hoon-panphol/claude-plugins
claude plugin validate ./claude-plugins
/plugin marketplace add ./claude-plugins     # ทดสอบจากเครื่องก่อน push
```

## License

MIT — ดู [LICENSE](LICENSE)
