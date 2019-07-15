# pt-logs-autosearch
A shell script for finding log entries in [papetrail](https://papertrailapp.com/) based on certain search terms. The `papertrail` UI doesn't allow searching after a certain point in the past.
This can be done by downloading the `papertrail` archives and searching in them.

Keep in mind that downloading the archives is very slow, because `papertrail` stores archives hourly as of November 2018. This means that if you need to search in a 1 month time span, the script will download 30x24 archives.

## Installation
```bash
git clone https://github.com/slavov-v/pt-logs-autosearch.git
```

## Usage
```bash
sudo chmod +x search_papertrail.sh
./search_papertrail.sh <papertrail token> <start date> <end date> <search term> <search term 2> <search term N>
```

### Example
```bash
./search_papertrail.sh myPapertrailToken 2019-06-01 2019-07-15 "{\"status\": 400" "auth\/login\/"
```
