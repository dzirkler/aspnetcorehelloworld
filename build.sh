#!/bin/bash

set -e
rm -fr ./out
dotnet restore ./hwapp
dotnet publish -c Release -o ./out ./hwapp
