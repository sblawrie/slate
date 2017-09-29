---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

toc_footers:
  - <a href='https://partners.coverfly.com'>Back to Coverfly</a>

includes:

search: true
---

# Introduction

Welcome to the Coverfly Partner API! If you're a partner, 
you can use our API to access Coverfly API endpoints,
which can create and view information on scripts and contests in our database.

All API requests must be made over HTTPS. Calls made over plain HTTP will fail.

We currently only have language bindings in Shell, but PHP and Python libraries are coming soon.
You can view code examples in the dark area to the right.

# Authentication

> To authorize, use this code:

```shell
# With shell, you can just pass the correct header with each request
curl "api_endpoint_here" \
  -H "X-Authorization: yourapikeyhere"
```

> Make sure to replace `yourapiheyhere` with your API key.

Coverfly uses API keys to allow access to the API. You can register a new Coverfly API key by emailing support@coverfly.com.

Coverfly expects for the API key to be included in all API requests to the server in a header that looks like the following:

`X-Authorization: yourapikeyhere`

<aside class="notice">
You must replace <code>yourapikeyhere</code> with your partner API key.
</aside>

# Contests

## Get All Contests

```shell
curl "https://api.coverfly.com/v1/contests" \
    -H "X-Authorization: yourapikeyhere"
    -L \
    -G 
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 1,
    "name": "ScreenCraft Horror Contest (2017)",
    "active": false,
  },
  {
    "id": 2,
    "name": "ScreenCraft Action Contest (2016)",
    "active": true,
  }
]
```

This endpoint retrieves all contest seasons.  Keep in mind that there may be
multiple seasons for each competition.

### HTTP Request

`GET https://api.coverfly.com/v1/contests`

### Query Parameters

None

# Scripts

## Get Scripts for a Given Contest

```shell
curl "https://api.coverfly.com/v1/contests/scripts" \
    -H "X-Authorization: yourapikeyhere" \
    -L \
    -G \
    -d "contest_id=100" \
    -d "offset=0" \
    -d "count=20"
```

> The above command returns JSON structured like this:

```json
[
  {
  "id": 4555,
  "title": "Example Title",
  "email": "user1@email.com",
  "first_name": "User First Name",
  "last_name": "User Last Name",
  "writers": [
    [
      "first_name": "Writer1 First Name",
      "last_name": "Writer1 Last Name"
    ],
    [
      "first_name": "Writer2 First Name",
      "last_name": "Writer2 Last Name"
    ]
  ],
  "package": "ScreenCraft Horror Contest Entry",
  "eliminated": false,
  "placement": "Semifinalist",
  "network": "Coverfly",
  "paid": 99.00,
  "score": 7.6
  },
  {
    "id": 4556,
    "title": "Example Title",
    "email": "user1@email.com",
    "first_name": "User First Name",
    "last_name": "User Last Name",
    "writers": [
      [
        "first_name": "Writer1 First Name",
        "last_name": "Writer1 Last Name"
      ],
      [
        "first_name": "Writer2 First Name",
        "last_name": "Writer2 Last Name"
      ]
    ],
    "package": "ScreenCraft Horror Contest Entry",
    "eliminated": false,
    "placement": "Semifinalist",
    "network": "Coverfly",
    "paid": 99.00,
    "score": 7.6
    }
]
```

This endpoint retrieves scripts for a given contest season.

### HTTP Request

`GET https://api.coverfly.com/v1/contests/scripts?contest_id=1`

### Query Parameters

Parameter | Default | Description | Required
--------- | ------- | ----------- | --------
contest_id | N/A | The Coverfly Contest ID | Yes
offset | 0 | The number of scripts to offset the results by | No
count | 10 | The number of scripts to return | No

## Get a Specific Script

```shell
curl "https://api.coverfly.com/v1/script" \
    -H "X-Authorization: yourapikeyhere" \
    -L \
    -G \
    -d "script_id=1000"
```

> The above command returns JSON structured like this:

```json
{
    "id": 4556,
    "title": "Example Title",
    "email": "user1@email.com",
    "first_name": "User First Name",
    "last_name": "User Last Name",
    "writers": [
      [
        "first_name": "Writer1 First Name",
        "last_name": "Writer1 Last Name"
      ],
      [
        "first_name": "Writer2 First Name",
        "last_name": "Writer2 Last Name"
      ]
    ],
    "package": "ScreenCraft Horror Contest Entry",
    "eliminated": false,
    "placement": "Semifinalist",
    "network": "Coverfly",
    "paid": 99.00,
    "score": 7.6,
    "pdf": "https://link.to.script.pdf"
}
```

This endpoint retrieves a specific script.

<aside class="warning">Links to script PDFs expire after one hour.</aside>

### HTTP Request

`GET https://api.coverfly.com/v1/script?id=1`

### URL Parameters

Parameter | Default | Description | Required
--------- | ------- | ----------- | --------
id | N/A | The id of the script to retrieve | Yes

## Create a Script

```shell
curl "https://api.coverfly.com/v1/script" \
    -X POST \
    -H "X-Authorization:{your_api_key_here}" \
    -F "pdf=@local_pdf.pdf" \
    -F "first_name=Eric" \
    -F "last_name=Lindros" \
    -F "email=example@gmail.com" \
    -F "title=Example Title" \
    -F "package_id=47" \
    -F "pages=104" \
    -F "format=Feature" \
    -F "genre=Drama"
```

> The above command returns JSON structured like this when it succeeds:

```json
{
  "success": true
}
```

> The above command returns JSON structured like this when it fails:

```json
{
  "success": false,
  "error": "invalid_user",
  "message": "User already used free first impression."
}
```

> Failed commands return the following values for `error`:

```
invalid_api_key
invalid_params
invalid_package
invalid_user
internal_error
```

This endpoint creates a script.

### HTTP Request

`POST https://api.coverfly.com/v1/script`

### URL Parameters

Parameter | Default | Description | Required
--------- | ------- | ----------- | --------
pdf | N/A | The local path to the PDF file for the script | Yes
first_name | N/A | The user's first name | Yes
last_name | '' | The user's last name | No
email | N/A | The user's email | Yes
package_id | N/A | The package ID for the script | Yes
title | N/A | The title of the script | Yes
genre | 'Unknown' | The script genre | No
format | 'Unknown' | The script format | No
pages | null | The page count for the script | No

