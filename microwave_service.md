MicroWave Service
=================
Convert your `doc`s to `pdf` and anything else for that matter.

Chef authors can use this service to convert file formats not currently supported
by Kolibri (doc/docx/ppt) to PDF documents, which are supported.



API
---

Send HTTP POST request with file data as file field in form to the following service URL:

    http://35.185.105.222:8989/unoconv/pdf

response is pdf data of converted file


### Other options

    http://35.185.105.222:8989/healthz
    http://35.185.105.222:8989/unoconv/{format}
    http://35.185.105.222:8989/unoconv/formats


Command line usage
------------------

    curl --form file=@"some local.docx" http://35.185.105.222:8989/unoconv/pdf > converted.pdf


Python usage
------------


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




Deploy
------

    docker run -d \
        -p 8989:3000 \
        --env-file=docker.env \
        --name unoconv \
        zrrrzzt/docker-unoconv-webservice

where `docker.env` contains:

    SERVER_PORT=3000
    PAYLOAD_MAX_SIZE=50048576
    TIMEOUT_SERVER=120000
    TIMEOUT_SOCKET=140000




Links
-----
https://www.one-tab.com/page/m8nFwUEMSAi-K6B55ElhJQ