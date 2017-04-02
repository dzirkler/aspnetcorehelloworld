#!/bin/bash

set -e
rm -fr ./out
dotnet restore ./hwweb
dotnet publish -c Release -o ./out ./hwweb
