FROM microsoft/aspnetcore:1.1.1

COPY ./hwweb/out /app
WORKDIR /app 

EXPOSE 80

ENTRYPOINT ["dotnet", "/app/hwweb.dll"]
