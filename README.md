# hello-world-cypress

[![Build Status](https://travis-ci.org/mramshaw/hello-world-cypress.svg?branch=master)](https://travis-ci.org/mramshaw/hello-world-cypress)

end-to-end testing with [Cypress](http://www.cypress.io/)

## Overview

This repo shows a basic example of using Cypress and Docker Compose to create simple end-to-end tests for any web application. This example uses a Go application, but you can reuse the pattern in this repository for any web application that can run in Docker.

For more information, see the blog post, ["Easy End-to-End Testing with Cypress."](https://mtlynch.io/painless-web-app-testing)

## Run the test app

The example application is called Sentimentalyzer, a very rudimentary text sentiment analyzer. To run it, enter the following commands:

```bash
$ docker build --tag sentimentalyzer:5.5 .
$ docker run --rm -it -e PORT=8123 -p 8123:8123 sentimentalyzer:5.5
$
```

The app will be running on [http://localhost:8123](http://localhost:8123).

As usual, Ctrl-C to terminate:

```bash
2020/11/04 23:58:49 Listening on port 8123
^Csignal: interrupt
$
```

## Run end-to-end tests

To execute the end-to-end tests for Sentimentalyzer, enter the following commands:

```bash
$ cd e2e && docker-compose up --exit-code-from cypress
```

When the command completes, you will see test output on the console and a video of the test run will appear in the folder `e2e/cypress/integration/videos`.

To clean up:

```bash
$ docker-compose down
Removing e2e_cypress_1_fb36b3dabe75         ... done
Removing e2e_sentimentalyzer_1_c4b0c05d50ed ... done
Removing network e2e_default
$
```

## Running a Docker version of Cypress on mac

Refer to [cy-open-mac.yml](e2e/cy-open-mac.yml).

## Running a Docker version of Cypress on linux

Refer to [cy-open-linux.yml](e2e/cy-open-linux.yml).

Enable Cypress to connect to the X server:

```bash
$ xhost +local:
non-network local connections being added to access control list
$
```

Then run Cypress as follows:

```bash
$ docker-compose -f docker-compose.yml -f cy-open-linux.yml up --exit-code-from cypress
WARNING: using --exit-code-from implies --abort-on-container-exit
Starting e2e_sentimentalyzer_1 ... done
Starting e2e_cypress_1         ... done
Attaching to e2e_sentimentalyzer_1, e2e_cypress_1
sentimentalyzer_1  | 2020/11/05 16:08:03 Listening on port 8123
cypress_1          | [16:1105/160804.047174:ERROR:bus.cc(393)] Failed to connect to the bus: Failed to connect to socket /var/run/dbus/system_bus_socket: No such file or directory
cypress_1          | [16:1105/160806.240109:ERROR:bus.cc(393)] Failed to connect to the bus: Address does not contain a colon
cypress_1          | [16:1105/160806.275258:ERROR:bus.cc(393)] Failed to connect to the bus: Address does not contain a colon
e2e_cypress_1 exited with code 0
Aborting on container exit...
Stopping e2e_sentimentalyzer_1 ... done
$
```

[I cannot figure out how to get rid of the bus errors but the test runner launches.]

To clean up:

```bash
$ docker-compose down
Removing e2e_cypress_1_fb36b3dabe75         ... done
Removing e2e_sentimentalyzer_1_c4b0c05d50ed ... done
Removing network e2e_default
$
```

## Other branches

This repo contains several branches to demonstrate different Cypress scenarios:

| Scenario | Branch |
|----------|---------|
| [Basic Cypress example](https://github.com/mramshaw/hello-world-cypress) | [`master`](https://github.com/mramshaw/hello-world-cypress) |
| [Using Cypress with Chrome browser](https://github.com/mramshaw/hello-world-cypress/tree/chrome) | [`chrome`](https://github.com/mramshaw/hello-world-cypress/tree/chrome) |
| [Running Cypress from within Circle CI](https://github.com/mramshaw/hello-world-cypress/tree/circle) | [`circle`](https://github.com/mramshaw/hello-world-cypress/tree/circle) |
| [Running Cypress from within Travis CI](https://github.com/mramshaw/hello-world-cypress/tree/travis) | [`travis`](https://github.com/mramshaw/hello-world-cypress/tree/travis) |
| [Running Cypress in interactive mode](https://github.com/mramshaw/hello-world-cypress/tree/interactive) | [`interactive`](https://github.com/mramshaw/hello-world-cypress/tree/interactive) |

## To Do

- [x] Upgrade to latest versions of Golang and Cypress
- [x] Clean up Docker image tags as well as `docker-compose` clean-up
- [x] Add instructions on running a Docker version of Cypress on linux
- [ ] Check out some of the Cypress [recipes](http://github.com/cypress-io/cypress-example-recipes)
- [x] Check out some of the Cypress CI/CD implementations
- [x] Add Travis CI badge

## Credits

Running a Docker version of Cypress on mac:

    http://github.com/bahmutov/cypress-open-from-docker-compose

    https://www.cypress.io/blog/2019/05/02/run-cypress-with-a-single-docker-command/

Running a Docker version of Cypress on linux:

    https://stackoverflow.com/questions/59514234/viewing-the-interactive-cypress-test-runner-in-docker-on-linux
