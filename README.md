# Contact Keeper API

Rails 5 API-only backend.

## Endpoints


### List all users
**GET /api/v1/users**

Sample Request:
```
curl -H "Content-Type: application/json" http://contact-keeper-api.herokuapp.com/api/v1/users
```

### Create user
**POST /api/v1/users**

Sample Request:
```
curl -X POST -H "Content-Type: application/json" -d '{ "user": { "username": "jfriedman", "first_name": "Jeff", "last_name": "Friedman", "email": "test@test.com", "phone_number": "617-123-4567", "password": "password", "password_confirmation": "password" }}' http://contact-keeper-api.herokuapp.com/api/v1/users
```

### Show user details
**GET /api/v1/users/:id**

Sample Request:
```
curl -H "Content-Type: application/json" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTU0ODc2OTMsImlzcyI6IkNvbnRhY3QgS2VlcGVyIiwiYXVkIjoiY2xpZW50In0.En5teUqtn2wIOkYPuvnxK1QgkrwRG7Tkj1NGRSvDX-k" http://contact-keeper-api.herokuapp.com/api/v1/users/1
```

Sample Response:
```
{"username":"jfriedman","first_name":"Jeff","last_name":"Friedman","email":"test@test.com","phone_number":"617-111-2222"}
```

### Update user details
**PUT/PATCH /api/v1/users/:id**

Sample Request:
```
curl -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTU0ODc2OTMsImlzcyI6IkNvbnRhY3QgS2VlcGVyIiwiYXVkIjoiY2xpZW50In0.En5teUqtn2wIOkYPuvnxK1QgkrwRG7Tkj1NGRSvDX-k" -d '{ "user": { "phone_number": "617-111-2222" }}' http://contact-keeper-api.herokuapp.com/api/v1/users/1
```

### Log in and receive auth token (JWT)
**POST /api/v1/users/login**

Sample Request:
```
curl -X POST -H "Content-Type: application/json" -d '{ "email": "test@test.com", "password": "password" }' http://contact-keeper-api.herokuapp.com/api/v1/users/login
```

Sample Response:
```
{"auth_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTU0ODc2OTMsImlzcyI6IkNvbnRhY3QgS2VlcGVyIiwiYXVkIjoiY2xpZW50In0.En5teUqtn2wIOkYPuvnxK1QgkrwRG7Tkj1NGRSvDX-k"}
```

### Delete user
**DELETE /api/v1/users/login**

Sample Request:
```
curl -X DELETE -H "Content-Type: application/json" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTU0ODc2OTMsImlzcyI6IkNvbnRhY3QgS2VlcGVyIiwiYXVkIjoiY2xpZW50In0.En5teUqtn2wIOkYPuvnxK1QgkrwRG7Tkj1NGRSvDX-k" http://contact-keeper-api.herokuapp.com/api/v1/users/1
```
