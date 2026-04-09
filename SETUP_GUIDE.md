# Flutter Practice App — Setup & Deployment Guide

## 📁 Project Structure
```
flutter_practice_app/
├── lib/
│   ├── main.dart
│   └── screens/
│       ├── login_screen.dart       ← Login with validation
│       ├── dashboard_screen.dart   ← Navigation hub with stats
│       ├── form_screen.dart        ← All form elements
│       ├── table_screen.dart       ← Data table with sort/filter/pagination
│       └── alerts_screen.dart      ← Dialogs, snackbars, bottom sheets
├── pubspec.yaml
└── SETUP_GUIDE.md
```

---

## 🚀 Step 1 — Install Flutter

Download from: https://docs.flutter.dev/get-started/install

Verify installation:
```bash
flutter doctor
```

---

## 🌐 Step 2 — Enable Web Support

```bash
flutter config --enable-web
```

---

## 📦 Step 3 — Get Dependencies

```bash
cd flutter_practice_app
flutter pub get
```

---

## ▶️ Step 4 — Run Locally

```bash
# IMPORTANT: Use HTML renderer for Playwright/Testsigma compatibility
flutter run -d chrome --web-renderer html
```

App opens at: `http://localhost:PORT`

---

## 🌍 Step 5 — Deploy to Firebase (Free, Team Access)

### Install Firebase CLI
```bash
npm install -g firebase-tools
```

### Login to Firebase
```bash
firebase login
```

### Build the app (HTML renderer is critical for automation tools)
```bash
flutter build web --web-renderer html --release
```

### Initialize Firebase Hosting
```bash
firebase init hosting
```
When prompted:
- Public directory: `build/web`
- Single-page app: `Yes`
- Automatic builds with GitHub: `No`

### Deploy
```bash
firebase deploy
```

✅ You'll get a URL like: `https://your-app.web.app`
Share this with your entire team!

---

## 🔐 Login Credentials

| Field    | Value               |
|----------|---------------------|
| Email    | admin@practice.com  |
| Password | Admin@123           |

---

## 🎯 Practice Scenarios

### 1. Login Screen
- Valid login
- Invalid email format validation
- Empty field validation
- Wrong credentials error message
- Password visibility toggle

### 2. Dashboard
- Verify stat cards (Users, Orders, Revenue, Issues)
- Navigate to each module
- Logout and return to login

### 3. Form Elements
- Fill all fields and submit
- Test dropdown selection
- Test radio button selection
- Test checkbox interaction
- Test slider interaction
- Submit without required fields (validation)
- Clear form button

### 4. Data Table
- Search/filter by name, email, role
- Sort by each column (ascending/descending)
- Pagination (next/prev/page numbers)
- Edit and delete row actions
- Verify row count display

### 5. Alerts & Dialogs
- Open and close simple dialog
- Confirm dialog — click OK vs Cancel
- Input dialog — type and submit
- All 4 snackbar types (success/error/warning/info)
- Bottom sheet open and close

---

## 🤖 Playwright Tips

### Enable Semantics (Required!)
Add this to your Playwright test before interacting:
```javascript
await page.evaluate(() => {
  document.querySelector('flt-semantics-placeholder')?.click();
});
```

### Wait for Flutter to Load
```javascript
await page.waitForSelector('flt-glass-pane');
// or
await page.waitForLoadState('networkidle');
```

### Finding Elements
Flutter elements are inside Shadow DOM:
```javascript
// Use semantic labels
await page.getByLabel('Email field').fill('admin@practice.com');
await page.getByLabel('Login button').click();
```

---

## 🤖 Testsigma Tips

- Use **"Enable Accessibility"** step before recording
- Use semantic labels as element identifiers
- Add **wait** steps after page navigation
- Use **Visual testing** for canvas-based elements

---

## ⚠️ Important Notes

1. Always build with `--web-renderer html` (NOT canvaskit) for automation
2. Enable semantics before any interactions
3. Flutter web loads slower than regular web — add sufficient waits
4. Elements are inside Shadow DOM — use tools that support shadow DOM
