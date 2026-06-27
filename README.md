# 🏥 VitalReach — AI-Powered Rural Healthcare Copilot

> Healthcare at Your Voice — Built for India's 65 crore rural population

## ✨ What Makes VitalReach Unique

- 🎤 **Voice-first** — Speak symptoms in Kannada, Hindi, Tamil, or English
- 🤖 **AI Triage in <30 seconds** — GREEN / YELLOW / ORANGE / RED with explanation
- 🆘 **Instant emergency detection** — Detects stroke, cardiac, bleeding from free-text
- 🗺️ **PHC Map + Navigation** — Nearest PHC with one-tap Google Maps routing
- 👨‍👩‍👧 **Family Health Wallet** — One account for the entire family
- 🪪 **QR Health Passport** — Scan at any PHC to access complete health history
- 💊 **Digital Prescription PDF** — Doctor writes, patient downloads instantly
- 📹 **Free video consultation** — Jitsi Meet (no app needed)
- 🌐 **4 languages** — English, ಕನ್ನಡ, हिन्दी, தமிழ்

---

## 🚀 Quick Start (5 minutes)

### 1. Clone & Install
\`\`\`bash
git clone https://github.com/your-username/vitalreach.git
cd vitalreach/frontend
npm install
\`\`\`

### 2. Set up environment variables
\`\`\`bash
cp .env.example .env
# Fill in: VITE_SUPABASE_URL, VITE_SUPABASE_ANON_KEY, VITE_GEMINI_API_KEY
\`\`\`

### 3. Set up Supabase
- Create a free project at supabase.com
- Run `supabase/schema.sql` in the SQL Editor
- Run `supabase/seed.sql` for demo data

### 4. Start frontend
\`\`\`bash
npm run dev
# Opens at http://localhost:3000
\`\`\`

### 5. (Optional) Start backend
\`\`\`bash
cd ../backend
pip install -r requirements.txt
cp .env.example .env
uvicorn main:app --reload
# API at http://localhost:8000
\`\`\`

---

## 🎮 Demo Login
- **Email:** demo@vitalreach.in
- **Password:** demo1234

---

## 🛠️ Tech Stack

| Layer      | Technology                          |
|-----------|-------------------------------------|
| Frontend  | React 18 + Vite + TailwindCSS       |
| Backend   | FastAPI (Python)                    |
| Database  | Supabase (PostgreSQL)               |
| AI        | Gemini 1.5 Flash API                |
| Maps      | Leaflet.js + OpenStreetMap          |
| Video     | Jitsi Meet (free embed)             |
| Voice     | Web Speech API (browser built-in)   |
| PDF       | jsPDF                               |
| QR Code   | qrcode.js                           |
| Deploy    | Vercel (frontend) + Railway (backend) |

---

## 📱 Pages

| Route          | Page                  |
|---------------|-----------------------|
| /             | Landing Page          |
| /login        | Login                 |
| /register     | Register              |
| /dashboard    | Patient Dashboard     |
| /chat         | AI Symptom Chat       |
| /triage       | Triage Result         |
| /book         | Book Appointment      |
| /consult/:id  | Video Consultation    |
| /records      | Health Records        |
| /phc-locator  | PHC Map               |
| /family       | Family Wallet         |
| /medicines    | Medicine Reminder     |
| /passport     | QR Health Passport    |
| /emergency    | Emergency SOS         |
| /doctor       | Doctor Dashboard      |

---

## 🏆 Built for National Hackathon

**Team:** Apex (4-members) | **Duration:** 24 hours | **Domain:** Healthcare

> "Every person in rural India deserves world-class healthcare, one voice command at a time."
