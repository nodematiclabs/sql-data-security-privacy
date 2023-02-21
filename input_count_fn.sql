CREATE OR REPLACE 
FUNCTION `users.input_count`(input_hashed_emails ARRAY<STRING>)
RETURNS BOOL AS
((
  SELECT IF(
    array_length(input_hashed_emails) < 100,
    FALSE,
    TRUE
  )
))