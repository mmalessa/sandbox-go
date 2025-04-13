# Go Template
A template of the dockerized development environment for apps in Go.

## Kickstart
1. `make build`
2. `make up`
3. Write some code
4. `make go-build`
5. `./bin/app`

### Visual Studio Code
1. On left bottom corner click `><` icon and select `Attach to running container...` and select container `$(APP_NAME)`
2. Install (Ctrl + Shift + X): 
    - Remote - Containers (Microsoft)
    - Go (Go Team at Google)
3. Run command (Ctrl + Shift + P) `Go: Install/Update tools`, select all and click `OK`
