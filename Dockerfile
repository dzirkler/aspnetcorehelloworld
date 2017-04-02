FROM microsoft/dotnet:1.1.1-runtime

COPY ./hwapp/out /app

ENTRYPOINT ["dotnet", "/app/hwapp.dll"]
