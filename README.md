# Counter-Strike 1.6 dedicated server docker based

This repository is a configuration set that allow you run a Counter-Strike dedicated server in aws. This project use [this docker image](https://github.com/jimtouz/counter-strike-docker).

# Get Started

Before start, ensure you have **AWS Cli** [installed](https://aws.amazon.com/cli/) and [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) in your machine. Ensure the **profile** is `default`.

First of all, clone this repo:

```
git clone git@github.com:isacaraujo/cs16.git
```

To launch a new server on aws, run:

```
make launch \
	KEYPAIR=<aws keypair name> \
	AVAILABILITY_ZONE=<availability zone> \
	VPC_ID=<vpc id> \
	SUBNET_ID=<subnet id> \
	SERVER_NAME='<server name>' \
	ADMIN_STEAM=0:0:1234566 \
	RCON_PASSWORD=<remote connection password> \
	SERVER_PASSWORD=<server password>
```

To destroy the server, run:

```
make destroy
```

If you are using windows, you must install [cygwin](https://cygwin.com/install.html). Please let me know if you have any problem in windows environment.

## Bots

This installation contains PodBot configured. Use the links bellow to setup the podbot as you like it:

- **List of PodBot commands:** http://podbotmm.bots-united.com/doc_v3/html/pbmm_configuration.html
- **HOW TO: PodBot and Metamod:** https://forums.alliedmods.net/showthread.php?t=220798

## Amxx

This installation run with metamod and amxmodx. So, if you wonder which commands you are able to run, please visit the amx wiki:

https://wiki.alliedmods.net/Commands_(AMX_Mod_X)

#### How to get your STEAM_ID

Run the command `status` at console that will show you your steam id:

```
status
```

#### How to add a new admin on demand

Run the following command in console as admin:

```
amx_addadmin "STEAM_0:0:123456" "abcdefghijklmnopqrstu"
```

## Maps

List of cstrike 1.6 free maps:

- https://www.gamemodd.com/cs/maps/

## Amx Plugins

- https://github.com/mikecao/amx-plugins

## MetaMod Plugins

- http://metamod.org/plugins.html

# Run a dedicated server locally

To run the server locally, ensure you have installed the following programs:

- [docker engine 19 or greater](https://docs.docker.com/engine/install/)
- [docker-compose 1.25 or greater](https://docs.docker.com/compose/install/)

Edit the file `env.secret` as you need. You can see all supported params in [this sheet](https://github.com/jimtouz/counter-strike-docker#propetries).

After edit them, run:

```
docker-compose up -d
```

To stop the server, run:

```
docker-compose down
```

You also can see all game logs by running:

```
docker logs -f cs
```
