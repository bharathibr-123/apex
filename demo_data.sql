-- ============================================================
-- VitalReach — Rich Demo Data (run in Supabase SQL Editor)
-- Your patient UUID: ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4
-- ============================================================

-- ── FAMILY MEMBERS ───────────────────────────────────────────
INSERT INTO family_members (owner_id, name, relation, age, gender, blood_group, allergies, conditions) VALUES
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'Savitha Gowda',  'Wife',       38, 'Female', 'O+',  'Penicillin',       'Mild anaemia'),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'Arjun Gowda',   'Son',        16, 'Male',   'B+',  'None',             'None'),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'Kavya Gowda',   'Daughter',   11, 'Female', 'A+',  'Dust allergy',     'Mild asthma'),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'Nagappa Gowda', 'Father',     72, 'Male',   'B+',  'Sulfa drugs',      'Type 2 Diabetes, Hypertension'),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'Shantha Gowda', 'Mother',     68, 'Female', 'O+',  'None',             'Arthritis');

-- ── MEDICINE REMINDERS ───────────────────────────────────────
INSERT INTO medicine_reminders (patient_id, medicine_name, dosage, frequency, reminder_times, start_date, end_date, is_active) VALUES
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'Paracetamol 500mg',  '1 tablet',   'Three times daily',  ARRAY['08:00','14:00','20:00'], CURRENT_DATE - 3,  CURRENT_DATE + 2,  TRUE),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'Cetirizine 10mg',    '1 tablet',   'Once at night',      ARRAY['21:00'],                CURRENT_DATE - 3,  CURRENT_DATE + 0,  TRUE),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'ORS Sachet',         '1 sachet',   'As needed',          ARRAY['07:00','13:00','19:00'],CURRENT_DATE - 3,  CURRENT_DATE + 2,  TRUE),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'Metformin 500mg',    '1 tablet',   'Twice daily',        ARRAY['08:00','20:00'],        CURRENT_DATE - 30, CURRENT_DATE + 60, TRUE),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'Vitamin D3 60K',     '1 capsule',  'Once a week',        ARRAY['09:00'],                CURRENT_DATE - 14, CURRENT_DATE + 74, TRUE);

-- ── MORE HEALTH RECORDS ──────────────────────────────────────
INSERT INTO health_records (patient_id, record_type, title, description, doctor_name, phc_name, record_date) VALUES
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'lab',          'Blood Sugar Test',        'Fasting: 118 mg/dL, Post-meal: 156 mg/dL — borderline high', 'Dr. Priya Shankar',  'Mysuru Rural PHC',  CURRENT_DATE - 7),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'lab',          'Complete Blood Count',    'Haemoglobin: 13.2 g/dL, WBC: 7200, Platelets: 2.1L — Normal', 'Dr. Priya Shankar',  'Mysuru Rural PHC',  CURRENT_DATE - 7),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'vitals',       'BP & Weight Check',       'BP: 128/82 mmHg, Weight: 69 kg, SpO2: 98%, Temp: 98.6°F',    'Dr. Ravi Kumar',     'Nanjangud PHC',     CURRENT_DATE - 15),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'consultation', 'Diabetes Follow-up',      'Blood sugar slightly elevated. Advised diet control & walking 30 min/day. Continue Metformin.', 'Dr. Suma Gowda', 'Hunsur PHC', CURRENT_DATE - 20),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'vaccination',  'Influenza Vaccine 2025',  'Annual flu vaccine administered. No adverse reactions.',        'PHC Nurse',          'Mysuru Rural PHC',  CURRENT_DATE - 45),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'lab',          'Lipid Profile',           'Total Cholesterol: 198 mg/dL, HDL: 48, LDL: 128 — Borderline', 'Dr. Priya Shankar',  'Mysuru Rural PHC',  CURRENT_DATE - 90),
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4', 'consultation', 'Knee Pain Consultation',  'Mild osteoarthritis in left knee. Physiotherapy recommended. Avoid prolonged standing.', 'Dr. Mohammed Azhar', 'HD Kote Primary Health', CURRENT_DATE - 120);

-- ── MORE APPOINTMENTS ────────────────────────────────────────
INSERT INTO appointments (patient_id, doctor_id, phc_id, appointment_date, appointment_time, symptoms_summary, triage_level, status, jitsi_room_id) VALUES
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4',
   'd1000001-2222-2222-2222-000000000002',
   'a1b2c3d4-2222-2222-2222-000000000002',
   CURRENT_DATE + 3, '11:00',
   'Child health checkup — Kavya has mild wheezing and cough', 'YELLOW', 'scheduled',
   'vitalreach-kavya-consult-002'),

  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4',
   'd1000001-5555-5555-5555-000000000005',
   'a1b2c3d4-4444-4444-4444-000000000004',
   CURRENT_DATE + 7, '09:30',
   'Diabetes follow-up, blood sugar monitoring', 'GREEN', 'scheduled',
   'vitalreach-diabetes-consult-003'),

  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4',
   'd1000001-1111-1111-1111-000000000001',
   'a1b2c3d4-1111-1111-1111-000000000001',
   CURRENT_DATE - 15, '10:00',
   'Routine checkup, BP monitoring', 'GREEN', 'completed',
   'vitalreach-bp-consult-004'),

  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4',
   'd1000001-4444-4444-4444-000000000004',
   'a1b2c3d4-3333-3333-3333-000000000003',
   CURRENT_DATE - 20, '14:00',
   'Severe stomach pain and vomiting since morning', 'ORANGE', 'completed',
   'vitalreach-stomach-consult-005');

-- ── MORE PRESCRIPTIONS ───────────────────────────────────────
INSERT INTO prescriptions (patient_id, doctor_id, diagnosis, medicines, advice, follow_up_date, issued_date) VALUES
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4',
   'd1000001-5555-5555-5555-000000000005',
   'Type 2 Diabetes Mellitus (Early Stage)',
   '[
     {"name":"Metformin 500mg","dosage":"1 tablet","frequency":"Twice daily after food","duration":"3 months","instructions":"Take after breakfast and dinner"},
     {"name":"Vitamin D3 60000 IU","dosage":"1 capsule","frequency":"Once a week","duration":"3 months","instructions":"Take Sunday morning with milk"},
     {"name":"Glimepiride 1mg","dosage":"1 tablet","frequency":"Once daily before breakfast","duration":"1 month","instructions":"Monitor blood sugar weekly"}
   ]',
   'Avoid sugar, rice, and fried foods. Walk 30 minutes daily. Check blood sugar every week. Eat small meals frequently.',
   CURRENT_DATE + 30,
   CURRENT_DATE - 20),

  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4',
   'd1000001-4444-4444-4444-000000000004',
   'Acute Gastroenteritis',
   '[
     {"name":"Ondansetron 4mg","dosage":"1 tablet","frequency":"Twice daily","duration":"3 days","instructions":"Take 30 min before meals"},
     {"name":"Pantoprazole 40mg","dosage":"1 tablet","frequency":"Once daily","duration":"5 days","instructions":"Take empty stomach in morning"},
     {"name":"ORS Sachet","dosage":"1 sachet in 1L water","frequency":"Sip throughout the day","duration":"3 days","instructions":"Drink at least 3 litres fluid per day"},
     {"name":"Probiotic Capsule","dosage":"1 capsule","frequency":"Once daily","duration":"7 days","instructions":"Take after dinner"}
   ]',
   'Eat only khichdi, curd rice, and banana for 3 days. Avoid spicy and oily food. Come back immediately if vomiting does not stop.',
   CURRENT_DATE - 15,
   CURRENT_DATE - 20);

-- ── TRIAGE SESSIONS (for AI chat history) ────────────────────
INSERT INTO triage_sessions (patient_id, symptoms, triage_level, triage_result, language) VALUES
  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4',
   'Fever 101°F for 3 days, headache, body ache, mild cough',
   'YELLOW',
   '{"level":"YELLOW","explanation":"You have symptoms of viral fever. This is not an emergency but needs medical attention within 24 hours.","actions":["Visit your nearest PHC today or tomorrow","Take Paracetamol 500mg for fever","Drink plenty of fluids and rest","Avoid self-medicating with antibiotics"],"doctor_needed":true}',
   'en'),

  ('ca5ec836-1c2e-4dea-8fcb-db2dfbba55f4',
   'ಹೊಟ್ಟೆ ನೋವು ಮತ್ತು ವಾಂತಿ (Stomach pain and vomiting)',
   'ORANGE',
   '{"level":"ORANGE","explanation":"ನಿಮ್ಮ ಲಕ್ಷಣಗಳು ತೀವ್ರವಾಗಿವೆ. ಇಂದೇ PHC ಗೆ ಹೋಗಿ.","actions":["ಇಂದೇ PHC ಗೆ ಭೇಟಿ ಮಾಡಿ","ನೀರು ಕುಡಿಯುತ್ತಲೇ ಇರಿ","ಘನ ಆಹಾರ ತಿನ್ನಬೇಡಿ"],"doctor_needed":true}',
   'kn');
