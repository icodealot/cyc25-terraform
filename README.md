## About the demo

This repo contains various demos of using Terraform to illustrate
concepts presented at CYC25.

## How to use this repo

### 1. Deal with prerequisites
First install the pre-requisites mentioned above.

- Terraform installed (1.10 or higher)
- Docker Desktop, Podman, or similar installed (a docker runtime)
- Make (Optional) if you want to automate the container build

Next, you should be able to call `docker ps` and get a successful
container listing such as:

```log
$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

Note, there are no containers running in the example above.

### 2. Clone this repo and build the container

Clone this repository to your machine and build the container included
in `src/app/backend`. This is a simple Go service that only has 1 endpoint
and the code is just a few lines.

Using `make`:

```shell
cd src
```

```shell
make build
```

or, using `docker build`

```shell
docker build -f app/backend/Dockerfile -t cyc-backend:latest .
```

### 3. Initialize terraform

Open a command-line to your cloned repository and change to the following:

```shell
cd src/cfg/app-terraform
```

Initialize Terraform as follows:

```shell
terraform init -upgrade
```

(`-upgrade` is optional on the first set up but doesn't hurt either)

### 4. Deploy the container using Terraform

Open a command-line to your cloned repository and change to the following:
(you may already be here if you just finished Step 3)

```shell
cd src/cfg/app-terraform
```

Execute a plan

```shell
terraform plan
```

Review the output and then execute an apply.

```shell
terraform apply
```

If all goes well you should now have a container running locally and you
should be able to call the Go endpoint using `curl` or similar.

```log
docker ps
CONTAINER ID   IMAGE          COMMAND      CREATED          STATUS          PORTS                    NAMES
aaaaabbbbccc   aaaabbbcc1234  "/app/cyc"   15 minutes ago   Up 15 minutes   0.0.0.0:8080->8000/tcp   cyc_backend_2025
```

Here is an example using `curl`.

```shell
curl -s http://localhost:8080/hello | jq .
```

which should return output similar to:

```json
{
  "message": "Hello, Commit Your Code!"
}
```

Note, `curl` and `jq` aren't strictly necessary but if you want to use
them to test the endpoint you can install them as needed.

### 5. Explore branches for various demos

The following demos / branches are available:

- `demo_locals` : shows an example of configuring local variables
- `demo_vars` : shows an example of using variables and conditional expressions
- `demo_modules` : shows an example of using modules to group resources
- `demo_conditions` : shows an example of making resources conditionally created