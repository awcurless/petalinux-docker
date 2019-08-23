# petalinux-docker #
A Dockerfile for creating a petalinux development environment.

## Building ##
* Before building, download a petalinux installer file.
* To build: `docker build --build-arg installer=petalinux-v2017.4-final-installer.run -t petalinux:latest .`

## Running ##
`docker run -it -v <path-to-project-source>:/home/petalinux/my-project petalinux:latest`
Subsitute `<path-to-project-source>` with the fully qualified path to the petalinux project
directory on your host.

To interact with petalinux tools, run `petalinuxenv` in the container, from there, the `petalinux-config`, `petalinux-build` and other commands are available.
