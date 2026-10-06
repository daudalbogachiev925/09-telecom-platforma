from fastapi import APIRouter, Depends
from pydantic import BaseModel
from datetime import datetime
from sqlalchemy.orm import Session
from sqlalchemy import text
from db import get_session

router = APIRouter()

class CdrIn(BaseModel):
    caller: str
    callee: str
    duration: int
    started: datetime
    cell_id: str | None = None
    kind: str = 'voice'
    roaming: bool = False

@router.post("/")
def add(data: CdrIn, db: Session = Depends(get_session)):
    db.execute(text("""
        INSERT INTO cdr (caller, callee, duration, started, cell_id, kind, roaming)
        VALUES (:caller,:callee,:duration,:started,:cell_id,:kind,:roaming)
    """), data.dict())
    db.commit()
    return {"status": "ok"}

@router.get("/by-number/{msisdn}")
def by_number(msisdn: str, limit: int = 100, db: Session = Depends(get_session)):
    return [dict(r._mapping) for r in db.execute(text("""
        SELECT * FROM cdr WHERE caller=:m OR callee=:m ORDER BY started DESC LIMIT :l
    """), {"m": msisdn, "l": limit}).fetchall()]
