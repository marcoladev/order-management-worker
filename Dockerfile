# -----------------------
# Build stage
# -----------------------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy the entire solution
COPY . .

# Restore dependencies
RUN dotnet restore order-management-worker.sln

# Publish the API
RUN dotnet publish src/OrderManagement.Worker/OrderManagement.Worker.csproj \
    -c Release \
    -o /app/publish \
    --no-restore

# -----------------------
# Runtime stage
# -----------------------
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime

WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080

ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

ENTRYPOINT ["dotnet", "OrderManagement.Worker.dll"]