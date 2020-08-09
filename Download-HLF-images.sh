#!/bin/bash
# Download the Hyperledger ARM64 images and tag them as the default hyperledgerimages

# fabric-baseimage
docker pull chinyati/fabric-baseimage:arm64-0.4.20
docker tag chinyati/fabric-baseimage:arm64-0.4.20 hyperledger/fabric-baseimage:arm64-0.4.20
docker tag chinyati/fabric-baseimage:arm64-0.4.20 hyperledger/fabric-baseimage

# fabric-baseos
docker pull chinyati/fabric-baseos:arm64-0.4.20
docker tag chinyati/fabric-baseos:arm64-0.4.20 hyperledger/fabric-baseos:arm64-0.4.20
docker tag chinyati/fabric-baseos:arm64-0.4.20 hyperledger/fabric-baseos

# fabric-tools
docker pull chinyati/fabric-tools:arm64-2.1.0
docker tag chinyati/fabric-tools:arm64-2.1.0 hyperledger/fabric-tools:2.1
docker tag chinyati/fabric-tools:arm64-2.1.0 hyperledger/fabric-tools

# orderer
docker pull chinyati/fabric-orderer:arm64-2.1.0
docker tag chinyati/fabric-orderer:arm64-2.1.0 hyperledger/fabric-orderer:2.1
docker tag chinyati/fabric-orderer:arm64-2.1.0 hyperledger/fabric-orderer

# peer
docker pull chinyati/fabric-peer:arm64-2.1.0
docker tag chinyati/fabric-peer:arm64-2.1.0 hyperledger/fabric-peer:2.1
docker tag chinyati/fabric-peer:arm64-2.1.0 hyperledger/fabric-peer

# fabric-ccenv
docker pull chinyati/fabric-ccenv:arm64-2.1.0
docker tag chinyati/fabric-ccenv:arm64-2.1.0 hyperledger/fabric-ccenv:2.1
docker tag chinyati/fabric-ccenv:arm64-2.1.0 hyperledger/fabric-ccenv

# fabric-ca
docker pull chinyati/fabric-ca:arm64-1.4.7
docker tag chinyati/fabric-ca:arm64-1.4.7 hyperledger/fabric-ca:1.4.7
docker tag chinyati/fabric-ca:arm64-1.4.7 hyperledger/fabric-ca

# fabric-kafka
#docker pull chinyati/fabric-kafka:arm64-0.4.20
#docker tag chinyati/fabric-kafka:arm64-0.4.20 hyperledger/fabric-kafka:arm64-0.4.20
#docker tag chinyati/fabric-kafka:arm64-0.4.20 hyperledger/fabric-kafka

# fabric-zookeeper
#docker pull chinyati/fabric-zookeeper:arm64-0.4.20
#docker tag chinyati/fabric-zookeeper:arm64-0.4.20 hyperledger/fabric-zookeeper:arm64-0.4.20
#docker tag chinyati/fabric-zookeeper:arm64-0.4.20 hyperledger/fabric-zookeeper

# couchdb
#docker pull chinyati/fabric-couchdb:arm64-0.4.20
#docker tag chinyati/fabric-couchdb:arm64-0.4.20 hyperledger/fabric-couchdb:arm64-0.4.20
#docker tag chinyati/fabric-couchdb:arm64-0.4.20 hyperledger/fabric-couchdb

# buildenv
# docker pull chinyati/fabric-buildenv
# docker tag chinyati/fabric-buildenv hyperledger/fabric-buildenv
