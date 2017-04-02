FROM microsoft/aspnetcore:1.1.1

COPY ./hwweb/out /app
WORKDIR /app 

ENTRYPOINT ["dotnet", "/app/hwweb.dll"]
