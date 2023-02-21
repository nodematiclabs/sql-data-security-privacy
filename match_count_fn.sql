CREATE OR REPLACE 
FUNCTION `users.match_count`(input_hashed_emails ARRAY<STRING>)
RETURNS BOOL AS
((
  SELECT
    IF (
      COUNT(*) < 100,
      FALSE,
      TRUE
    )
  FROM `users.purchases`
  WHERE TO_BASE64(SHA512(email)) IN UNNEST(input_hashed_emails)
))