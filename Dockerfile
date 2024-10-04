# Dart builder stage
FROM dart:stable AS build

# Ilova uchun ishchi katalogni belgilash
WORKDIR /app

# Loyihangizning barcha fayllarini konteynerga ko'chiring
COPY . .

RUN dart pub get

RUN dart compile exe bin/mukammal.dart -o /app/bin/mukammal

# Ikkinchi stage - eng yengilroq konteyner
FROM scratch

# Oldingi build stage-dan kompilyatsiya qilingan fayllarni ko'chirish
COPY --from=build /runtime/ /runtime/
COPY --from=build /app/bin/mukammal /app/bin/mukammal

# Kontenyer ishga tushirilganda bajariladigan buyruq
CMD ["/app/bin/mukammal"]
