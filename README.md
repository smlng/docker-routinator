# A Docker Setup for the NLnet-Labs Routinator

## Prerequisites

To create and run the docker container you need a host system with
Docker and docker-compose installed. This may need superuser rights
e.g. `sudo`.

## Configure the Routinator

The Routinator will download (rsync) ROAs from the 5 major RIRs, i.e,
AFRINIC, APNIC, ARIN, LACNIC, and RIPE, also refered to as trust anchors.
For downloading TRUST ANCHOR LOCATOR (TAL) files are required, the Routinator
comes with 4 of them, however the TAL for ARIN is not included.
Thus, download the TAL file from [ARIN] and save it into the `tals` folder,
use the RFC7730 format.

The Routinator has not explicit configuration file, but you may remap the
RTR port if needed.

**Note(1)**: do not change host/server or port settings in the Dockerfile,
this can be done in the `docker-compose.yml`. To do so, open the yml
file and change the values in section `ports`, format is `HOST_PORT:DOCKER_PORT`.
For instance to remap the RTR port change `3323:3323` to e.g. `4242:3323`.

**Note(2)**: the service is set to restart always, i.e., on any errors or
restart of the host system.  See section `restart` in `docker-compose.yml` 
to change this if needed.

## Run the Routinator in Docker

Using `docker-compose` this is easy, simply run `sudo docker-compose up -d`.

**Note**: the service is run as non-root, i.e., with user `rpki` (uid=323).

## Updating and Troubleshooting

The `docker-compose` command may require super user rights, i.e., run it 
with `sudo` or as `root`.

Changes to the configuration or new/added TAL files require a service restart.
To restart the service run `docker-compose restart`, if that does not help
run `docker-compose down && docker-compose up -d`.

To update the container(s) or recreate them in case of errors:
1. Stop any running services: `docker-compose down`
2. Force rebuild of the containers: `docker-compose build`
3. Start the service: `docker-compose up -d`

To just stop the container for a moment and start it again use commands
`docker-compose stop` and `docker-compose start`. This halts and
starts the container without deleting or recreating it.

## Copyright and License

For the [ARIN] TAL and the Routinator (see [GitHub]) refer to the respective licenses.
For everything else in this repo the MIT License applies, see LICENSE file for details.

[ARIN]: https://www.arin.net/resources/rpki/tal.html
[GitHub]: https://github.com/NLnetLabs/routinator 
