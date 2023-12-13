@echo off
REM Build the restoldphoto:ver1 image
docker build -t restoldphoto:ver1 .

REM Run the restoldphoto:ver1 container interactively
docker-compose up 
