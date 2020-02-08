MicroWave Service
=================
Convert your `doc`s to `pdf` and anything else for that matter.

Chef authors can use this service to convert file formats not currently supported
by Kolibri (doc/docx/ppt) to PDF documents, which are supported.

This repo is a copy of the [docker-unoconv-webservice](https://github.com/zrrrzzt/docker-unoconv-webservice), project by GitHub user `zrrrzzt` (Geir Gåsodden).
We've only made small modifications to support more fonts and larger file uploads.



API
---
Send HTTP POST request with file data as file field in form to the following service URL:

    http://35.185.105.222:8989/unoconv/pdf

The response is the pdf data of converted file.


### Other API endpoints

    http://35.185.105.222:8989/healthz
    http://35.185.105.222:8989/unoconv/{format}
    http://35.185.105.222:8989/unoconv/formats



Command line usage
------------------

```bash
curl --form file=@"some local.docx" http://35.185.105.222:8989/unoconv/pdf > converted.pdf
```

Python usage
------------

```python
import requests

# helper
def save_response_content(response, filename):
    with open(filename, 'wb') as localfile:
        localfile.write(response.content)

# go GET a sample.docx
docx_url = 'https://calibre-ebook.com/downloads/demos/demo.docx'
response1 = requests.get(docx_url)
save_response_content(response1, 'sample.docx')

# convert it
microwave_url = 'http://35.185.105.222:8989/unoconv/pdf'
files = {'file': open('sample.docx', 'rb')}
response = requests.post(microwave_url, files=files)
save_response_content(response, 'sample.pdf')
```


### Example usage in a chef

https://github.com/learningequality/sushi-chef-shls/blob/master/sushichef.py#L485



Deploy
------
The MicroWave conversion service can be deployed in any docker environment and
requires only port `8989` to be open on the machine.

#### 1. Set host info 

We currently run `MicroWave` on the same docker machine as `sushibar`, so the
first step to deploying is to set the docker machine environemnt variables:
  
    eval $(docker-machine env gcpsushibarhost)


#### 2. Build docker image

    docker build -t learningequality/docker-unoconv-webservice .

The Dockerfile is nearly identical to the [upstream Dockerfile](https://github.com/zrrrzzt/docker-unoconv-webservice/blob/master/Dockerfile),
except for the installation of some extra font packages.


#### 3. Run container
Start a docker container as follows:

    docker run -d \
        -p 8989:3000 \
        --env-file=env.list \
        --name unoconv \
        learningequality/docker-unoconv-webservice

where the file `env.list` contains:

    SERVER_PORT=3000
    PAYLOAD_MAX_SIZE=52428800
    TIMEOUT_SERVER=120000
    TIMEOUT_SOCKET=140000

These are the default except we allow 50MB file uploads.


You can check that the unoconv service is up by visiting http://35.185.105.222:8989/healthz








TODOs
-----

- Check why table of contents is missing from Final - V2/English/Kolibri Training Pack /1. Training Manual/Facilitation Manual for Kolibri training - Updated July 2018.docx

- Check why pptx --> pdf doesn't work for  Final - V2/Spanish/Presentaciones del entrenamiento/2. Presentación de Kolibri - paso a paso.pptx Increase maximum file size allowed if needed




References
----------
https://www.one-tab.com/page/m8nFwUEMSAi-K6B55ElhJQ


