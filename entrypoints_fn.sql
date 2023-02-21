CREATE OR REPLACE FUNCTION `users.entrypoint`(input_hashed_emails JSON) RETURNS FLOAT64
REMOTE WITH CONNECTION `us.bounded-mean`
OPTIONS (
  endpoint = 'https://CLOUD_RUN_ENDPOINT'
)