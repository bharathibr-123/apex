"""
VitalReach Backend — FastAPI
AI-Powered Rural Healthcare Copilot
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager

from routers import auth, patients, doctors, appointments, triage, prescriptions, health_records, phc
from core.config import settings


@asynccontextmanager
async def lifespan(app: FastAPI):
    print("✅ VitalReach API started")
    yield
    print("⚡ VitalReach API shutting down")


app = FastAPI(
    title="VitalReach API",
    description="AI-Powered Rural Healthcare Copilot — Backend",
    version="1.0.0",
    lifespan=lifespan,
)

# ── CORS ─────────────────────────────────────────────────────
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ── Routers ───────────────────────────────────────────────────
app.include_router(auth.router,          prefix="/api/auth",         tags=["Auth"])
app.include_router(patients.router,      prefix="/api/patients",     tags=["Patients"])
app.include_router(doctors.router,       prefix="/api/doctors",      tags=["Doctors"])
app.include_router(appointments.router,  prefix="/api/appointments", tags=["Appointments"])
app.include_router(triage.router,        prefix="/api/triage",       tags=["AI Triage"])
app.include_router(prescriptions.router, prefix="/api/prescriptions",tags=["Prescriptions"])
app.include_router(health_records.router,prefix="/api/records",      tags=["Health Records"])
app.include_router(phc.router,           prefix="/api/phc",          tags=["PHC"])


@app.get("/", tags=["Health"])
async def root():
    return {
        "service": "VitalReach API",
        "version": "1.0.0",
        "status": "healthy",
        "message": "AI-Powered Rural Healthcare Copilot"
    }


@app.get("/health", tags=["Health"])
async def health_check():
    return {"status": "ok"}
