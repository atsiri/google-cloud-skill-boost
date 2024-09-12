1. set API KEY from GCP 

	`export API_KEY=<api_key_provided_by_gcp>`

2. compile request.json from cloud shell 
	`curl "https://language.googleapis.com/v1/documents:classifyText?key=${API_KEY}" \
  	-s -X POST -H "Content-Type: application/json" --data-binary @request.json`

3. retrieve dataset from Cloud Storage
	`gcloud storage cat gs://cloud-training-demos-text/bbc_dataset/entertainment/001.txt`

4. create table `article_data` in BigQuery

5. run these lines in cloud shell
	`export PROJECT=<project_ID>`

	`gcloud iam service-accounts create my-account --display-name my-account
	gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:my-account@$PROJECT.iam.gserviceaccount.com --role=roles/bigquery.admin
	gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:my-account@$PROJECT.iam.gserviceaccount.com --role=roles/serviceusage.serviceUsageConsumer
	gcloud iam service-accounts keys create key.json --iam-account=my-account@$PROJECT.iam.gserviceaccount.com
	export GOOGLE_APPLICATION_CREDENTIALS=key.json`

6. compile the python function from classify-text.py

`python3 classify-text.py`

7. preview the result in BigQuery
`SELECT * FROM news_classification_dataset.article_data`

