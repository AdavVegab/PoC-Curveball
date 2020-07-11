# PoC-Curveball (CVE-2020-0601)
 Proof Of Concept for the Curveball vulnerability for the course
 Cryptography and Security - FH Münster
 
 - _Andres David Vega Botero_
 - _Andres Felipe Herrera Upegui_

> Source: ollypwn (https://github.com/ollypwn/CurveBall)

## Set Up
is meant to run on linux with the following packages:

` openssl openssl 1.1.0 `
` ruby 2.4.0 ` 
` node 10.19.0 `

### Preparing node.js

- Go to the TLS directory

`cd TLS`

- install express

`npm install express`


## How to use

### Create the spoofed certificate and run a server
run the POC Bash script, it will run the POC and creates a node server

`bash PoC.sh`

### Change the hosts file in the target

### Curveballed!


