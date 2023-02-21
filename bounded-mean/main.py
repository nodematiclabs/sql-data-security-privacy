import functions_framework

from google.cloud import bigquery

import pydp as dp
from pydp.algorithms.laplacian import BoundedMean

client = bigquery.Client()
bounded_mean = BoundedMean(epsilon=0.9, lower_bound=0.0, upper_bound=5000.0, dtype="float")

@functions_framework.http
def entrypoint(request):
    request_json = request.get_json(silent=True)

    if request_json and 'calls' in request_json:
        results = []
        for call in request_json['calls']:
            query = "SELECT users.match_and_check({})".format(call[0])  # single argument function
            job = client.query(query)
            total_purchases = [row[0] for row in job.result()][0]  # array is in first row, first field
            results.append(
                round(bounded_mean.quick_result(total_purchases))
            )
        return {'replies': results}
    else:
        return ""
