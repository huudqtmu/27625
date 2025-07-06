# Base image chỉ để chạy (runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
 
# thiết lập cổng mặc định
EXPOSE 3000

# Copy bản đã publish vào image
COPY ./publish ./

# Lệnh chạy ứng dụng
ENTRYPOINT ["dotnet", "P27625.dll"]
