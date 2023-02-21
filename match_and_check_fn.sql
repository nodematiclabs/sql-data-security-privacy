CREATE OR REPLACE 
FUNCTION `users.match_and_check`(input_hashed_emails ARRAY<STRING>)
RETURNS ARRAY<FLOAT64> AS
(
  IF(
    users.match_count(input_hashed_emails) AND users.input_count(input_hashed_emails),
    ARRAY(
      SELECT TotalPurchases
      FROM `users.purchases`
      WHERE TO_BASE64(SHA512(email)) IN UNNEST(input_hashed_emails)
    ),
    []
  )
)