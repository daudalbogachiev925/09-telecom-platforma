from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from db import get_session

router = APIRouter()

@router.get("/usage")
def usage(db: Session = Depends(get_session)):
    return [dict(r._mapping) for r in db.execute(text(open('sql/usage.sql').read())).fetchall()]

@router.get("/churn")
def churn(db: Session = Depends(get_session)):
    return [dict(r._mapping) for r in db.execute(text(open('sql/churn.sql').read())).fetchall()]

@router.get("/top/{msisdn}")
def top_numbers(msisdn: str, db: Session = Depends(get_session)):
    return [dict(r._mapping) for r in db.execute(text(open('sql/top_numbers.sql').read()),
                                                 {"msisdn": msisdn}).fetchall()]
