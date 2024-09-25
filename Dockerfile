FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app
EXPOSE 8080
# copy .csproj and restore as distinct layers
COPY "Reactivities.sln" "Reactivities.sln"
COPY "API/API.csproj" "API/API.csproj"
COPY "Application/Application.csproj" "Application/Application.csproj"
COPY "Persistence/Persistence.csproj" "Persistence/Persistence.csproj"
COPY "Domain/Domain.csproj" "Domain/Domain.csproj"
COPY "Infrastructure/Infrastructure.csproj" "Infrastructure/Infrastructure.csproj"

RUN dotnet restore "Reactivities.sln"

COPY . .
WORKDIR /app
RUN dotnet publish -c Release -o out

# build a runtime image aspnet is smaller than sdk in first line
# once build done in solutions folder in terminal run : docker build -t mydocusername/myreact .
#  docker build -t stayob/myreactsqlsvr .
# make sure docker desktop is running
# deploy to hub.docker.com and create user there where the userid (stayob) is used above in docker build command
# docker run --rm -it -p 8080:80 stayob/myreactsqlsvr
FROM mcr.microsoft.com/dotnet/aspnet:8.0
COPY --from=build-env /app/out .
ENTRYPOINT [ "dotnet", "API.dll" ]
