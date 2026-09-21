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

## โครงสร้าง repo

```
claude-plugins/
├── .claude-plugin/
│   └── marketplace.json        ← รายชื่อปลั๊กอินทั้งหมด
└── plugins/
    └── portfolio-skills/
        ├── .claude-plugin/plugin.json
        ├── skills/
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
