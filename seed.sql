-- ============================================================
-- VitalReach Fixed Seed Data
-- Run this in Supabase SQL Editor
-- ============================================================

-- Clear old data first
DELETE FROM health_records;
DELETE FROM prescriptions;
DELETE FROM appointments;
DELETE FROM doctors;
DELETE FROM family_members;
DELETE FROM medicine_reminders;
DELETE FROM triage_sessions;
DELETE FROM phcs;
DELETE FROM profiles WHERE email = 'demo@vitalreach.in';

-- ── PHCs ─────────────────────────────────────────────────────
INSERT INTO phcs (id, name, address, district, phone, latitude, longitude) VALUES
  ('a1b2c3d4-0001-4001-8001-000000000001', 'Mysuru Rural PHC',         'Bannur Road, Mysuru',       'Mysuru', '0821-2340001', 12.2958, 76.6394),
  ('a1b2c3d4-0002-4002-8002-000000000002', 'Nanjangud PHC',            'Temple Road, Nanjangud',    'Mysuru', '08221-220002', 11.8750, 76.6845),
  ('a1b2c3d4-0003-4003-8003-000000000003', 'HD Kote Primary Health',   'Main Road, HD Kote',        'Mysuru', '08228-256003', 11.9882, 76.3458),
  ('a1b2c3d4-0004-4004-8004-000000000004', 'Hunsur PHC',               'Bus Stand Road, Hunsur',    'Mysuru', '08222-253004', 12.3031, 76.2903),
  ('a1b2c3d4-0005-4005-8005-000000000005', 'Piriyapatna PHC',          'KR Road, Piriyapatna',      'Kodagu','08227-265005', 12.3402, 76.1031);

-- ── DEMO PATIENT ─────────────────────────────────────────────
INSERT INTO profiles (id, email, name, phone, role, age, village, blood_group, health_id, pwd_hash) VALUES
  (gen_random_uuid(), 'demo@vitalreach.in', 'Ramu Gowda', '9876543210', 'patient', 45,
   'Bannur Village', 'B+', 'VR-DEMO0001',
   '9c4d24ebccd81e3ead28b6f427e73e29ef23f9e80b1e22de1d5c7d9c576e5d22');

-- ── DOCTORS ──────────────────────────────────────────────────
INSERT INTO doctors (id, phc_id, name, specialization, registration_no, experience_years, bio, consultation_fee, is_available, languages, rating) VALUES
  ('d0000001-0001-4001-8001-000000000001', 'a1b2c3d4-0001-4001-8001-000000000001',
   'Dr. Priya Shankar', 'General Physician', 'KMC-2018-4521', 8,
   'MBBS, MD. 8 years rural healthcare experience.', 0, TRUE, ARRAY['en','kn'], 4.8),

  ('d0000001-0002-4002-8002-000000000002', 'a1b2c3d4-0001-4001-8001-000000000001',
   'Dr. Ravi Kumar', 'Pediatrician', 'KMC-2015-3312', 11,
   'MBBS, DCH. Specialist in child healthcare.', 0, TRUE, ARRAY['en','kn','hi'], 4.7),

  ('d0000001-0003-4003-8003-000000000003', 'a1b2c3d4-0002-4002-8002-000000000002',
   'Dr. Anitha Reddy', 'Gynaecologist', 'KMC-2020-5678', 6,
   'MBBS, DGO. Women and maternal health specialist.', 0, TRUE, ARRAY['en','kn'], 4.9),

  ('d0000001-0004-4004-8004-000000000004', 'a1b2c3d4-0003-4003-8003-000000000003',
   'Dr. Mohammed Azhar', 'General Physician', 'KMC-2019-2234', 7,
   'MBBS. Experienced in rural infectious diseases.', 0, TRUE, ARRAY['en','kn','hi'], 4.6),

  ('d0000001-0005-4005-8005-000000000005', 'a1b2c3d4-0004-4004-8004-000000000004',
   'Dr. Suma Gowda', 'Internal Medicine', 'KMC-2016-1123', 10,
   'MBBS, MD. Chronic disease management expert.', 0, TRUE, ARRAY['en','kn'], 4.7);

-- ── APPOINTMENT (using demo patient id lookup) ────────────────
INSERT INTO appointments (patient_id, doctor_id, phc_id, appointment_date, appointment_time, symptoms_summary, triage_level, status, jitsi_room_id)
SELECT
  p.id,
  'd0000001-0001-4001-8001-000000000001',
  'a1b2c3d4-0001-4001-8001-000000000001',
  CURRENT_DATE + 1,
  '10:00',
  'Fever for 3 days, headache, body ache',
  'YELLOW',
  'scheduled',
  'vitalreach-demo-consult-001'
FROM profiles p WHERE p.email = 'demo@vitalreach.in';

-- ── PRESCRIPTION ─────────────────────────────────────────────
INSERT INTO prescriptions (patient_id, doctor_id, diagnosis, medicines, advice, issued_date)
SELECT
  p.id,
  'd0000001-0001-4001-8001-000000000001',
  'Viral Fever',
  '[
    {"name":"Paracetamol 500mg","dosage":"1 tablet","frequency":"3 times a day","duration":"5 days","instructions":"After food"},
    {"name":"Cetirizine 10mg","dosage":"1 tablet","frequency":"Once at night","duration":"3 days","instructions":"Before sleep"},
    {"name":"ORS Sachet","dosage":"1 sachet in 1L water","frequency":"As needed","duration":"Until recovered","instructions":"Drink throughout the day"}
  ]',
  'Take rest. Drink plenty of fluids. Avoid cold food. Return if fever persists beyond 5 days.',
  CURRENT_DATE - 3
FROM profiles p WHERE p.email = 'demo@vitalreach.in';

-- ── HEALTH RECORDS ───────────────────────────────────────────
INSERT INTO health_records (patient_id, record_type, title, description, doctor_name, phc_name, record_date)
SELECT p.id, 'vaccination', 'COVID-19 Vaccination', 'Covishield - Dose 2 completed', 'PHC Staff', 'Mysuru Rural PHC', '2021-08-15'
FROM profiles p WHERE p.email = 'demo@vitalreach.in';

INSERT INTO health_records (patient_id, record_type, title, description, doctor_name, phc_name, record_date, vitals)
SELECT p.id, 'vitals', 'Routine Check', 'BP normal, sugar normal', 'Dr. Priya Shankar', 'Mysuru Rural PHC', CURRENT_DATE - 30,
  '{"bp":"130/85","sugar":"110","weight":"68","temp":"98.6"}'
FROM profiles p WHERE p.email = 'demo@vitalreach.in';

INSERT INTO health_records (patient_id, record_type, title, description, doctor_name, phc_name, record_date)
SELECT p.id, 'consultation', 'Cold & Cough', 'Diagnosed with seasonal allergic rhinitis', 'Dr. Priya Shankar', 'Mysuru Rural PHC', CURRENT_DATE - 60
FROM profiles p WHERE p.email = 'demo@vitalreach.in';

-- Confirm
SELECT 'PHCs: ' || COUNT(*) FROM phcs
UNION ALL SELECT 'Doctors: ' || COUNT(*) FROM doctors
UNION ALL SELECT 'Demo patient: ' || COUNT(*) FROM profiles WHERE email = 'demo@vitalreach.in'
UNION ALL SELECT 'Appointments: ' || COUNT(*) FROM appointments
UNION ALL SELECT 'Prescriptions: ' || COUNT(*) FROM prescriptions
UNION ALL SELECT 'Health Records: ' || COUNT(*) FROM health_records;