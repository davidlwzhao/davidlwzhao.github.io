#!/usr/bin/python
'''
### Data schema

    1. Carrier level
        - Carrier ID
        - Carrier Name
        - Carrier Parent?
        - Carrier Country
        - Other flags ...
        
    2. Route level (includes layovers)
        - Route ID
        - Start airport
        - End airport
        
    3. Airport level
        - Airport ID
        - Airport Name
        - Airport Country
        - Geo tag? lat and long?
            - possibly important if want to look at catchment analysis later on
           
    4. Quote level (route & carrier & time level)
        - Departure time
        - Landing time / duration??
        - Carrier ID
        - Route id
        - Price
        - Direct or not flag
        - Layover time?
        - Layover cities (how do I store this?)
        - Currency - GBP
        - Quote time - when was this queried
        - Sourcing

'''

import numpy as np
import pandas as pd
import json
import sqlite3
from datetime import datetime

class AirportDatabaseCoordinator:
    # wrapper around SQLite that facilitates read/writes
    def __init__(self):
        with open('param.json') as f:
            params = json.load(f)

        self.database_name = params['database']
    
    def get(self):
        
        # cursor = conn.execute("SELECT carrier_id, carrier_name, country from CARRIER")
        # for row in cursor:
        #     for i, val in enumerate(row):
        #         print(f"{field[i]} = ", val)
        # df = DataFrame(c.fetchall(), columns=['Brand','Price']) 
        pass
    
    def write(self):
        # Update order is
        # 1. Carriers, Airports
        # 2. Routes
        # 3. Quotes
        # df.to_sql('tbl_name', conn, if_exists='replace', index = False)
        self.conn.execute("INSERT INTO CARRIER (CARRIER_ID,CARRIER_NAME,COUNTRY) \
        VALUES (2, 'Virgin Airways', 'UK')")

        self.conn.commit()
    
    def route(self):
        pass
    
    def get_all_tables(self):
        cursor = self.conn.execute("SELECT name FROM sqlite_master WHERE type='table';")
        for row in cursor:
            print(row)

    def __enter__(self):
        self.conn = sqlite3.connect(self.database_name)
        return self.conn
    
    def __exit__(self, *args):
        self.conn.close()
    
    
class AirportDatabaseExecutor:
    def __init__(self):
        pass