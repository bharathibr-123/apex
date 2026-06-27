-- ============================================================
-- VitalReach Database Schema
-- Run this in Supabase SQL Editor
-- ============================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ── PROFILES (patients, doctors, PHC admins) ─────────────────
CREATE TABLE profiles (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email         TEXT UNIQUE NOT NULL,
  name          TEXT NOT NULL,
  phone         TEXT,
  role          TEXT NOT NULL DEFAULT 'patient' CHECK (role IN ('patient','doctor','phc','admin')),
  age           INT,
  gender        TEXT,
  village       TEXT,
  district      TEXT,
  state         TEXT DEFAULT 'Karnataka',
  blood_group   TEXT,
  allergies     TEXT,
  chronic_conditions TEXT,
  emergency_contact  TEXT,
  health_id     TEXT UNIQUE,
  pwd_hash      TEXT,
  avatar_url    TEXT,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

-- ── PHCs ─────────────────────────────────────────────────────
CREATE TABLE phcs (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name        TEXT NOT NULL,
  address     TEXT,
  district    TEXT,
  state       TEXT DEFAULT 'Karnataka',
  phone       TEXT,
  email       TEXT,
  latitude    DOUBLE PRECISION,
  longitude   DOUBLE PRECISION,
  is_active   BOOLEAN DEFAULT TRUE,
  bed_count   INT DEFAULT 10,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ── DOCTORS ──────────────────────────────────────────────────
CREATE TABLE doctors (
  id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id       UUID REFERENCES profiles(id) ON DELETE CASCADE,
  phc_id           UUID REFERENCES phcs(id),
  name             TEXT NOT NULL,
  specialization   TEXT NOT NULL,
  registration_no  TEXT,
  experience_years INT DEFAULT 0,
  bio              TEXT,
  photo_url        TEXT,
  consultation_fee INT DEFAULT 0,
  is_available     BOOLEAN DEFAULT TRUE,
  languages        TEXT[] DEFAULT ARRAY['en'],
  rating           NUMERIC(3,2) DEFAULT 4.5,
  total_reviews    INT DEFAULT 0,
  created_at       TIMESTAMPTZ DEFAULT NOW()
);

-- ── APPOINTMENTS ─────────────────────────────────────────────
CREATE TABLE appointments (
  id                UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  patient_id        UUID REFERENCES profiles(id) ON DELETE CASCADE,
  doctor_id         UUID REFERENCES doctors(id),
  phc_id            UUID REFERENCES phcs(id),
  appointment_date  DATE NOT NULL,
  appointment_time  TIME NOT NULL,
  symptoms_summary  TEXT,
  triage_level      TEXT DEFAULT 'YELLOW' CHECK (triage_level IN ('GREEN','YELLOW','ORANGE','RED')),
  consultation_type TEXT DEFAULT 'video' CHECK (consultation_type IN ('video','audio','chat')),
  status            TEXT DEFAULT 'scheduled' CHECK (status IN ('scheduled','confirmed','completed','cancelled','no_show')),
  jitsi_room_id     TEXT,
  notes             TEXT,
  created_at        TIMESTAMPTZ DEFAULT NOW()
);

-- ── PRESCRIPTIONS ────────────────────────────────────────────
CREATE TABLE prescriptions (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  patient_id      UUID REFERENCES profiles(id) ON DELETE CASCADE,
  doctor_id       UUID REFERENCES doctors(id),
  appointment_id  UUID REFERENCES appointments(id),
  diagnosis       TEXT NOT NULL,
  medicines       JSONB NOT NULL DEFAULT '[]',
  advice          TEXT,
  follow_up_date  DATE,
  issued_date     DATE NOT NULL DEFAULT CURRENT_DATE,
  is_active       BOOLEAN DEFAULT TRUE,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ── HEALTH RECORDS ───────────────────────────────────────────
CREATE TABLE health_records (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  patient_id   UUID REFERENCES profiles(id) ON DELETE CASCADE,
  record_type  TEXT NOT NULL CHECK (record_type IN ('consultation','lab','vaccination','vitals','allergy','other')),
  title        TEXT NOT NULL,
  description  TEXT,
  doctor_name  TEXT,
  phc_name     TEXT,
  attachments  TEXT[] DEFAULT '{}',
  vitals       JSONB DEFAULT '{}',
  record_date  DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- ── FAMILY MEMBERS ───────────────────────────────────────────
CREATE TABLE family_members (
  id           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  owner_id     UUID REFERENCES profiles(id) ON DELETE CASCADE,
  name         TEXT NOT NULL,
  relation     TEXT NOT NULL,
  age          INT,
  gender       TEXT,
  blood_group  TEXT,
  allergies    TEXT,
  conditions   TEXT,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- ── MEDICINE REMINDERS ───────────────────────────────────────
CREATE TABLE medicine_reminders (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  patient_id      UUID REFERENCES profiles(id) ON DELETE CASCADE,
  prescription_id UUID REFERENCES prescriptions(id),
  medicine_name   TEXT NOT NULL,
  dosage          TEXT,
  frequency       TEXT,
  reminder_times  TEXT[] DEFAULT '{}',
  start_date      DATE,
  end_date        DATE,
  is_active       BOOLEAN DEFAULT TRUE,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ── TRIAGE SESSIONS ──────────────────────────────────────────
CREATE TABLE triage_sessions (
  id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  patient_id      UUID REFERENCES profiles(id),
  symptoms        TEXT,
  triage_level    TEXT,
  triage_result   JSONB,
  chat_history    JSONB DEFAULT '[]',
  language        TEXT DEFAULT 'en',
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ── INDEXES ──────────────────────────────────────────────────
CREATE INDEX idx_appointments_patient    ON appointments(patient_id);
CREATE INDEX idx_appointments_doctor     ON appointments(doctor_id);
CREATE INDEX idx_appointments_date       ON appointments(appointment_date);
CREATE INDEX idx_prescriptions_patient   ON prescriptions(patient_id);
CREATE INDEX idx_health_records_patient  ON health_records(patient_id);
CREATE INDEX idx_family_members_owner    ON family_members(owner_id);
CREATE INDEX idx_medicine_reminders_pat  ON medicine_reminders(patient_id);
CREATE INDEX idx_triage_sessions_patient ON triage_sessions(patient_id);

-- ── ROW LEVEL SECURITY ───────────────────────────────────────
ALTER TABLE profiles          ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments      ENABLE ROW LEVEL SECURITY;
ALTER TABLE prescriptions     ENABLE ROW LEVEL SECURITY;
ALTER TABLE health_records    ENABLE ROW LEVEL SECURITY;
ALTER TABLE family_members    ENABLE ROW LEVEL SECURITY;
ALTER TABLE medicine_reminders ENABLE ROW LEVEL SECURITY;

-- Basic RLS policies (expand as needed)
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Patients see own appointments"
  ON appointments FOR SELECT USING (auth.uid() = patient_id);

CREATE POLICY "Patients see own prescriptions"
  ON prescriptions FOR SELECT USING (auth.uid() = patient_id);

CREATE POLICY "Patients see own records"
  ON health_records FOR SELECT USING (auth.uid() = patient_id);
