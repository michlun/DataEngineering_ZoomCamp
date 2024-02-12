CREATE OR REPLACE EXTERNAL TABLE awesome-nimbus-412522.taxi_ny.green_taxi_2022_external
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-mlunelli/ny_green_taxi_2022.parquet']
);

CREATE OR REPLACE TABLE awesome-nimbus-412522.taxi_ny.green_taxi_2022 AS
SELECT * FROM awesome-nimbus-412522.taxi_ny.green_taxi_2022_external;

SELECT COUNT(DISTINCT PULocationID) 
FROM awesome-nimbus-412522.taxi_ny.green_taxi_2022_external;

SELECT COUNT(DISTINCT PULocationID) 
FROM awesome-nimbus-412522.taxi_ny.green_taxi_2022;

SELECT COUNT(*)
FROM awesome-nimbus-412522.taxi_ny.green_taxi_2022
WHERE fare_amount = 0;

CREATE OR REPLACE TABLE awesome-nimbus-412522.taxi_ny.green_taxi_2022 AS
SELECT *, TIMESTAMP_MICROS(CAST(lpep_pickup_datetime / 1000 AS INT64)) AS cleaned_pickup_datetime, TIMESTAMP_MICROS(CAST(lpep_dropoff_datetime / 1000 AS INT64)) AS cleaned_dropoff_datetime FROM awesome-nimbus-412522.taxi_ny.green_taxi_2022_external;

CREATE OR REPLACE TABLE awesome-nimbus-412522.taxi_ny.green_taxi_2022_partitioned_clustered
PARTITION BY DATE(cleaned_pickup_datetime)
CLUSTER BY PULocationID AS
SELECT *, TIMESTAMP_MICROS(CAST(lpep_pickup_datetime / 1000 AS INT64)) AS cleaned_pickup_datetime, TIMESTAMP_MICROS(CAST(lpep_dropoff_datetime / 1000 AS INT64)) AS cleaned_dropoff_datetime FROM awesome-nimbus-412522.taxi_ny.green_taxi_2022_external;

SELECT DISTINCT(PULocationID)
FROM awesome-nimbus-412522.taxi_ny.green_taxi_2022
WHERE DATE(cleaned_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

SELECT DISTINCT(PULocationID)
FROM awesome-nimbus-412522.taxi_ny.green_taxi_2022_partitioned_clustered
WHERE DATE(cleaned_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';
