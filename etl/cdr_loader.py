import pandas as pd
from sqlalchemy import create_engine

def load_cdr(file_path: str, engine):
    """CSV: caller,callee,duration,started,cell_id,kind,roaming"""
    df = pd.read_csv(file_path, parse_dates=['started'])
    df.to_sql('cdr', engine, if_exists='append', index=False, method='multi')
    print(f"Загружено {len(df)} записей")

if __name__ == '__main__':
    engine = create_engine('postgresql://tel:tel@localhost/tel')
    load_cdr('cdr_2024_01.csv', engine)
