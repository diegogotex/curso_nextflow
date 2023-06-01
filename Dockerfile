FROM debian:bullseye-slim

LABEL image.author.name "diegogotex"
LABEL image.author.email "diego.go.tex@gmail.com"

RUN apt-get update && apt-get install -y curl cowsay

ENV PATH=$PATH:/usr/games/