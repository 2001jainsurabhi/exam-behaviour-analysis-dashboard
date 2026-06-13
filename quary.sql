-- Total Rows
SELECT COUNT(*) AS total_rows
FROM candidate_log;

-- Unique Candidates
SELECT COUNT(DISTINCT candidate_id) AS total_candidates
FROM candidate_log;

-- Activity Distribution
SELECT
activity,
COUNT(*) AS total_events,
ROUND(
COUNT(*) * 100.0 /
SUM(COUNT(*)) OVER(),
2
) AS percentage
FROM candidate_log
GROUP BY activity
ORDER BY total_events DESC;

-- Language Distribution

SELECT
    question_language,
    COUNT(*) AS total_events,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage
FROM candidate_log
GROUP BY question_language
ORDER BY total_events DESC;

-- Section-wise Activity

SELECT
    question_section,
    COUNT(*) AS total_events,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage
FROM candidate_log
GROUP BY question_section
ORDER BY question_section;

-- Question Type Distribution

SELECT
    question_type,
    COUNT(*) AS total_events,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage
FROM candidate_log
GROUP BY question_type
ORDER BY total_events DESC;

-- Response Distribution

SELECT
    question_response,
    COUNT(*) AS total_events,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage
FROM candidate_log
WHERE question_response IS NOT NULL
GROUP BY question_response
ORDER BY total_events DESC;

-- Missing Value Analysis

SELECT
COUNT(*) FILTER (WHERE question_response IS NULL) AS response_nulls,
COUNT(*) FILTER (WHERE question_language IS NULL) AS language_nulls,
COUNT(*) FILTER (WHERE question_type IS NULL) AS type_nulls
FROM candidate_log;

-- Hourly Activity Trend

SELECT
DATE_PART('hour', logged_at) AS hour,
COUNT(*) AS total_events
FROM candidate_log
GROUP BY DATE_PART('hour', logged_at)
ORDER BY hour;

-- Activity-wise event count by exam section

SELECT
activity,
question_section,
COUNT(*) AS total_events
FROM candidate_log
GROUP BY activity, question_section
ORDER BY activity, question_section;