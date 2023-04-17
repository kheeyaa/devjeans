FROM node:14-alpine as build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:stable-alpine

COPY --from=build /app/dist /usr/share/nginx/html

ENV VITE_APP_FIREBASE_KEY=$VITE_APP_FIREBASE_KEY \
    VITE_APP_AUTH_DOMAIN=$VITE_APP_AUTH_DOMAIN \
    VITE_APP_PROJECT_ID=$VITE_APP_PROJECT_ID \
    VITE_APP_STORAGE_BUCKET=$VITE_APP_STORAGE_BUCKET \
    VITE_APP_MESSAGING_SENDER_ID=$VITE_APP_MESSAGING_SENDER_ID \
    VITE_APP_APP_ID=$VITE_APP_APP_ID \
    VITE_APP_MEASUREMENT_ID=$VITE_APP_MEASUREMENT_ID \
    VITE_APP_API_URL=$VITE_APP_API_URL \
    VITE_APP_S3_URL=$VITE_APP_S3_URL \
    VITE_APP_GOOGLE_CLIENT_ID=$VITE_APP_GOOGLE_CLIENT_ID \
    VITE_APP_DATADOG_APP_ID=$VITE_APP_DATADOG_APP_ID \
    VITE_APP_DATADOG_CLIENT_TOKEN=$VITE_APP_DATADOG_CLIENT_TOKEN \
    VITE_APP_DATADOG_SITE=$VITE_APP_DATADOG_SITE \
    VITE_APP_DATADOG_SERVICE=$VITE_APP_DATADOG_SERVICE \
    VITE_APP_DATEDOG_ENV=$VITE_APP_DATEDOG_ENV \
    VITE_APP_KAKAO_KEY=$VITE_APP_KAKAO_KEY \
    VITE_APP_KAKAO_REDIRECT_URI=$VITE_APP_KAKAO_REDIRECT_URI

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
