# docker-go-dev-environment
 A Complete Go Development Environment With Docker and VS Code

## Requirements

Local development machines need to have following tools installed and working properly:

- [Docker](https:://www.docker.com) for running a full-time containerized development environment. You have to login on your computer to be able to pull Docker images from Docker Hub. You can do this by running the following command:

  ```
   docker login --username <username>
  ```

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) to easily manage Docker installation.

- [Visual Studio Code](https://code.visualstudio.com) with [Remote - Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for writing code with Intellisense, running and debugging code within containers.

Windows users need to additionally have an Unix-shell emulator to be able to run utility scripts ([Git Bash](https://gitforwindows.org) is recommended).

## Usage

#### Develop with Visual Studio Code

To open the repository in VSCode (after cloning the repository into local development machines), developers can either:

- Issue following command (with VSCode command line tool added to `PATH`):

``` shell
code /path/to/this/repository
```

- Or open the repository using VSCode graphical user interface:

  - Select *File* → *Open* → *Browse The Repository*.

  - Or use default keyboard shortcut: *Command* + *O* (or *Ctrl* + *O* on Windows).

Once the repository is opened, as the repository includes `.devcontainer.json`, VSCode will automatically ask you to reopen in container mode.

Just select *Reopen in Container*, or if you've already opened the project in local mode and don't see the above prompt, you can issue the VSCode command (*View* → *Command Pallete* or press *F1*) *Remote-Containers: Reopen in Container* to achieve the same effect.

For the first open, VSCode will automatically build an image based on `.devcontainer.json` and `Dockerfile`, the process may take a while. Latter opens will reuse the prebuilt image.

Once the image was built successfully, VSCode will launch a container from that image and start setting up some essential stuff for it to work. After that, you're now connected to the container within your VSCode client, you can use every features of VSCode as is.

- You can start writing code creating your `main.go` file.

- You can run and debug the application by either selecting *Debug* → *Start Debugging* or using default keyboard shortcut *F5*.

Note that the local workspace will be mounted to `/root/project/` within the container.

#### Run your app directly in the development container from the terminal.

You can also start a containerized development environment and start working on that or even build your own development solution on top of that.

To start the development container, issue following command:

``` shell
./start-go-devcontainer.sh
```

For the first run, the script will build an image based on `Dockerfile`, the process may take a while. Latter runs will reuse the prebuilt image.

Once the image was built successfully, it will launch a container in interactive mode and mount the repository's root directory to `/root/project/` within the container, so that developers can make changes to the repository locally and have those changes automatically reflected into the container.

In interactive mode within the container, developers can issue every `go` CLI commands, e.g to start the application:

``` shell
go run main.go
```

### Build your application within the development container for a specific platform

To start the development container, issue following command:

```
./start-go-devcontainer.sh
```
To compile your application for a platform issue following command inside the container shell:

```
go mod init myproject
go mod tidy
export GOOS=darwin
export GOARCH=amd64
go build -v -o myproject-$GOOS-$GOARCH
```
Available values for `GOOS` and `GOARCH` can be found [here](https://golang.org/doc/install/source#environment).

## Project structure

Quick overview of project structure, components and their roles.

```
├── 📁.vscode/                              # VSCode configurations.
├── 📄start-go-devcontainer.sh              # Shell script to run Go development container.
├── 📄.devcontainer.json                    # VSCode Remote-Containers configuration.
├── 📄.gitignore
├── 📄Dockerfile                            # Instructions to build development Docker image.
├── 📄go.mod                                # Go module file.
├── 🚀main.go                               # Your application code's main entry point.
├── 📦myproject-$os-$arch                   # Your compiled application for a specific platform.
├── 📖LICENSE
├── 📖README.md
```

## Credits
- https://medium.com/gitconnected/go-restful-series-a7addbfef5b1
- https://github.com/phuctm97/go-restful
- https://hub.docker.com/_/golang
