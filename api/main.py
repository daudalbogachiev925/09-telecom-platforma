from fastapi import FastAPI
from routes import subscribers, tariffs, cdr, billing, analytics

app = FastAPI(title="Telecom API")
app.include_router(subscribers.router, prefix="/subscribers", tags=["subscribers"])
app.include_router(tariffs.router, prefix="/tariffs", tags=["tariffs"])
app.include_router(cdr.router, prefix="/cdr", tags=["cdr"])
app.include_router(billing.router, prefix="/billing", tags=["billing"])
app.include_router(analytics.router, prefix="/analytics", tags=["analytics"])

@app.get("/health")
def health(): return {"status": "ok"}
