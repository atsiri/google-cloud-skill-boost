SELECT
  category,
  COUNT(*) c
FROM
  `news_classification_dataset.article_data`
GROUP BY
  category
ORDER BY
  c DESC

-- SELECT
--   article_text,
--   category
-- FROM `news_classification_dataset.article_data`
-- WHERE cast(confidence as float64) > 0.9