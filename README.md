# Application Version: Ballerina 2201.8.2 (Swan Lake Update 8)

# Running the Application

To start the application, navigate to the project's root directory and run the following command:

```bash
bal run

# API TASK

The API should be prepared using the Ballerina programming language ([Ballerina Home](https://ballerina.io/)).

## Endpoints

The API should provide the following endpoints:

### GET /users

- Retrieves a list of all users.

### GET /users/<id>

- Retrieves a single user with a specified identifier.

### POST /users

- In the request body, provide a new object of type User, which will be added to the list of users.

### POST /users/resetPassword

- In the request body, provide the email of the user for whom you want to reset the password. If the user with the given email is found in the list, return a response code of Accepted (202). If the user is not found in the list, return a response code of Bad Request (400).

### POST /auth/login

- In the request body, provide the email and password. If the combination matches a user from the list, return a response code of Ok (200). In case of an incorrect combination, return a response code of Unauthorized (401).

## User List

The list of users used for testing purposes should contain at least three predefined users.

## Data Storage

The list of users should be kept in memory. There is no need to use databases or other data sources.

## User Object

A User is a class that contains three fields:

- id
- email
- password

```

```
