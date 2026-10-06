from fastapi import APIRouter, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session
from sqlalchemy import text
from db import get_session

router = APIRouter()

class SubIn(BaseModel):
    msisdn: str
    name: str
    tariff_id: int

@router.post("/")
def create(data: SubIn, db: Session = Depends(get_session)):
    row = db.execute(text("""
        INSERT INTO subscribers (msisdn, name, tariff_id) VALUES (:msisdn,:name,:tariff_id)
        RETURNING id
    """), data.dict()).fetchone()
    db.commit()
    return {"id": row[0]}

@router.get("/")
def list_all(db: Session = Depends(get_session)):
    return [dict(r._mapping) for r in db.execute(text("SELECT * FROM subscribers")).fetchall()]
