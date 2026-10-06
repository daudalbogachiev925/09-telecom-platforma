from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from db import get_session

router = APIRouter()

@router.get("/{subscriber_id}")
def calculate(subscriber_id: int, db: Session = Depends(get_session)):
    row = db.execute(text(open('sql/billing.sql').read())).fetchall()
    for r in row:
        if r[0] == subscriber_id:
            return dict(r._mapping)
    return {}

@router.get("/")
def all_bills(db: Session = Depends(get_session)):
    return [dict(r._mapping) for r in db.execute(text(open('sql/billing.sql').read())).fetchall()]
