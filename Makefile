greeting:
	echo "Hello World"
math:
	expr 2 + 2

all: directories downloads freshdata filecheck

directories:
	-mkdir tmp
	-mkdir data

downloads:
	curl "https://www.imf.org/external/datamapper/api/v1/PCPIPCH?periods=2023" -o tmp/inflation.json 
	curl "https://www.imf.org/external/datamapper/api/v1/countries" -o tmp/countries.json

freshdata:
	node imf_to_csv.js

filecheck:
		curl "https://sarusatoshi-projects-public.s3.ap-southeast-2.amazonaws.com/inflation-map/inflation.csv"

		cmp --silent ./tmp/previous.csv ./data/inflation.csv || \
		curl -X POST -H 'Content-type: application/json' \
		--insecure \
		--data '{"text":"The file you asked me to watch has changed!"}' $$SLACK_WEBHOOK
