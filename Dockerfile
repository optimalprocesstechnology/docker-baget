FROM loicsharma/baget:latest as base
WORKDIR /app

FROM base AS custom
COPY appsettings.json appsettings.json

FROM base AS final
WORKDIR /app
COPY --from=custom /app .
ENTRYPOINT ["dotnet", "BaGet.dll"]
