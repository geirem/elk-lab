#!/usr/bin/env python3
from datetime import datetime

import time
import uuid as uuid
from flask import json


def gen_log_line() -> str:
    current_ts = time.time()
    current_date = datetime.fromtimestamp(current_ts)
    current_isodate = f'{current_date.strftime("%Y-%m-%dT%H:%M:%S.%f")[:-3]}Z'
    log_line = {
        'endpoint': 'hentFakturagrunnlagStatus',
        'status': 8,
        'policyNumber': '7676634',
        'claimNumber': '1',
        'app': 'dbs-service',
        'appVersion': '0.0.0-5cb9d56f',
        'loglevel': 'INFO',
        'logger_name': 'no.storebrand.dbsservice.endpoints.InvoiceEndpoint',
        'CallID': uuid.uuid4(),
        'message': f'My timestamp should have {str(current_ts - int(current_ts))[1:5]} at the end.',
        'source': {
            'class': 'no.storebrand.dbsservice.endpoints.InvoiceEndpoint',
            'method': 'statusResponseFor',
            'file': 'InvoiceEndpoint.java',
            'line': 443
        },
        'thread': 'http-nio-9090-exec-9',
        '@timestamp': current_isodate,
    }
    return json.dumps(log_line)


with open('./logs/my-rest-api.json', mode='w') as log_file:
    while True:
        time.sleep(2.5)
        log_file.write(gen_log_line())
        log_file.write("\n")
        log_file.flush()
