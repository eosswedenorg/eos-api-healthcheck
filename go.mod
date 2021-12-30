module github.com/eosswedenorg/eosio-api-healthcheck

go 1.14

require (
	internal/eosapi v1.0.0
	internal/haproxy v1.0.0
	internal/log v1.0.0
	internal/pid v1.0.0
	internal/utils v1.0.0

	github.com/firstrow/tcp_server v0.1.0
	github.com/pborman/getopt/v2 v2.1.0
)

replace internal/haproxy => ./src/haproxy

replace internal/eosapi => ./src/eosapi

replace internal/log => ./src/log

replace internal/pid => ./src/pid

replace internal/utils => ./src/utils