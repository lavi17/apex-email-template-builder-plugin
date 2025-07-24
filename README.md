# Oracle APEX Email Template Builder Plugin

🚀 A **region plugin** for Oracle APEX allowing users to visually build and manage HTML email templates, supporting dynamic HTML, CSS, and image integration for automated email generation within your APEX applications.

---

## ✨ Features

✅ Drag-and-drop HTML content for email templates  
✅ Supports custom CSS/JS integration  
✅ Upload images for email templates  
✅ Uses Oracle PL/SQL package for backend management  
✅ Can be integrated with your application's automated email workflows

---

## 📂 Repository Structure

apex-email-template-builder-plugin/
├── plugin.sql # Exported APEX plugin
├── email_builder_pkg.pks # Package specification
├── email_builder_pkg.pkb # Package body
├── static/
│ ├── email_builder.css # Plugin CSS
│ └── email_builder.js # Plugin JavaScript
└── README.md # This file

---

## 🛠️ Installation

1️⃣ Install the PL/SQL package:
```sql
@path/to/email_builder_pkg.pks
@path/to/email_builder_pkg.pkb

2️⃣ Import the plugin:

Go to App Builder > Shared Components > Plug-ins > Import.

Upload and install plugin.sql.

3️⃣ Upload Static Files:

Go to Shared Components > Static Application Files.

Upload email_builder.css and email_builder.js (if not embedded in plugin).

4️⃣ Use the Plugin:

Add a new region to your page.

Select Region Type: Email Template Builder Plugin.

Configure according to your use case.

5️⃣ Copy below html in plugin region: Header Text

<div id="btn-pallete">
    <div class="t-Button t-Button--hot" onclick="preview(event)">Preview</div>
    <div class="t-Button t-Button--warning" id="send-email">Send Test Email</div>
    <div class="t-Button t-Button--success" id="save-html">Save</div>
</div>

6️⃣ After creating the template you can create your own save process and send email process with html id's for Save and Send Email
