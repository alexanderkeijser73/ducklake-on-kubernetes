INSTALL ducklake;  
LOAD ducklake; 

CREATE OR REPLACE SECRET secret ( 
	TYPE s3, 
	PROVIDER config, 
	ENDPOINT 'minio:9000',
	KEY_ID 'minioadmin', 
	SECRET 'minioadmin',
	USE_SSL FALSE,
	URL_STYLE 'path',
	REGION 'us-west-1'
); 

ATTACH 'ducklake:metadata.ducklake' AS my_ducklake (DATA_PATH 's3://ducklake'); 
USE my_ducklake;

CREATE TABLE earthquakes AS 
SELECT * FROM read_json('https://vega.github.io/vega-datasets/data/earthquakes.json');

CREATE TABLE cars AS 
SELECT * FROM read_json('https://vega.github.io/vega-datasets/data/cars.json');

CREATE TABLE flights AS
SELECT * FROM read_parquet('https://vega.github.io/vega-datasets/data/flights-3m.parquet');


SELECT * FROM my_ducklake.snapshots();

SELECT * FROM flights;
