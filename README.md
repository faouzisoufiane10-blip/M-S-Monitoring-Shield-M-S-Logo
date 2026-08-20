# M‑S — Monitoring & Shield (حزمة رصد واستجابة دفاعية للشبكات اللاسلكية)

![M‑S Logo](./logo-visible.svg)

نبذة
-----
M‑S أداة دفاعية مصمّمة للمؤسسات لتكتشف سلوكيات مشبوهة في شبكات Wi‑Fi، تسجّل الحوادث، ترسل تنبيهات فورية، وتعرض لوحة متابعة (Dashboard). كل الإجراءات الفعلية مرتبطة فقط بالشبكات اللي عندك تفويض عليها.

تنبيه قانوني مهم
-----------------
M‑S للاستخدام القانوني فقط على الشبكات التي تملك تفويضًا لإدارتها أو لاختبارها. أي استعمال ضد شبكات أو أجهزة بدون إذن غير قانوني.

المكوّنات والهيكلة
-------------------
- docker-compose.yml — تشغيل m-s-server + loki + promtail + grafana.  
- server/ — Flask app، endpoint API، واجهة بسيطة، ملف .env.example.  
- sensor/ — Python sensor (قراءة Kismet JSON، تطبيق قواعد، إرسال أحداث للسيرفر).  
- openwrt/ — سكربت apply_safeguards.sh لتطبيق إعدادات أمان آمنة على راوتر OpenWrt.  
- systemd/ — ملفات unit لتشغيل sensor و server كخدمات.  
- docs/screenshots/ — مكان لوضع لقطات الشاشة.  
- logo-visible.svg — شعار مرئي للـ README والواجهة.

تنصيب سريع (مبسّط)
------------------
1) انسخ المشروع لمجلد M-S ثم ادخل للمجلد:
   git clone <repo-url> M-S
   cd M-S

2) إعداد السيرفر (Docker):
   - ثبت Docker و docker‑compose.
   - عدّل server/.env.example ثم انسخه إلى server/.env.
   - شغّل:
     docker-compose up -d --build

3) إعداد الـ Sensor (Raspberry Pi مثال):
   - على الجهاز: ثبت Python 3.10+
   - أنشئ venv وثبّت المتطلبات:
     cd sensor
     python -m venv venv
     source venv/bin/activate
     pip install -r requirements.txt
   - عدّل sensor/config.yaml حسب شبكة السيرفر ومسارات Kismet.
   - شغّل لاختبار:
     python sensor.py --config sensor/config.yaml

4) تشغيل كخدمة (systemd) — مثال للـ sensor:
   sudo cp systemd/m-s-sensor.service /etc/systemd/system/
   sudo systemctl daemon-reload
   sudo systemctl enable --now m-s-sensor

ملاحظات تشغيلية
----------------
- افحص server/data/m-s.db للتأكد من تسجيل الحوادث.  
- غيّر قواعد كشف في sensor/rules.py لتناسب شبكتك وعتباتك.  
- قبل تفعيل أي إجراء آلي على الراوتر، تأكد من صلاحياتك وموافقة مسؤول الشبكة.

المزيد
------
- لربط Telegram: عيّن TELEGRAM_TOKEN و TELEGRAM_CHAT_ID في server/.env.  
- لربط SMTP: عيّن SMTP_* في server/.env.

استعمل M‑S بمسؤولية. شوف الملفات التالية لتبدأ.
