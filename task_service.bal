import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:4200"],
        allowCredentials: true,
        allowHeaders: ["Content-Type", "Authorization"],
        allowMethods: ["OPTIONS", "GET", "POST", "PUT", "DELETE"]
    }
}

service /task on new http:Listener(9090) {
    resource function get users() returns User[] | error {
        return users.toArray();
    }

    resource function get users/[int id]() returns User | UserNotFound | error {
        User? user = users[id];
        if user is () {
            UserNotFound userNotFound = {
                body: { message: string `User not found.`, details: string `user/${id}` }
            };
            return userNotFound;
        }
        return user;
    }

    resource function post users(UserRequest newUser) returns http:Created | error {
        // Check if email or password is null
        if (newUser.email == "" || newUser.password == "") {
            error errMsg = error("Email and password must not be null");
            return errMsg;
        }

        int newUserId = users.length() + 1;
        User newUserRecord = {
            id: newUserId,
            email: newUser.email,
            password: newUser.password
        };
        users.add(newUserRecord);

        return http:CREATED;
    }

    resource function post users/resetPassword(ResetPasswordRequest resetRequest) returns http:Response | error {
        string resetEmail = resetRequest.email;
        var userExists = false;

        foreach User user in users {
            if (user.email == resetEmail) {
                userExists = true;
                break;
            }
        }

        http:Response response = new;
        response.setHeader("Access-Control-Allow-Origin", "http://localhost:4200");
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
        response.setHeader("Access-Control-Allow-Credentials", "true");

        if (userExists) {
            response.statusCode = 202;
            response.setHeader("Content-Type", "application/json");
        } else {
            response.statusCode = 400;
            response.setHeader("Content-Type", "application/json");
        }

        return response;
    }

    resource function post auth/login(UserRequest loginInfo) returns http:Response | error {
        http:Response response = new;
        response.setHeader("Access-Control-Allow-Origin", "http://localhost:4200");
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
        response.setHeader("Access-Control-Allow-Credentials", "true");

        User? matchingUser = ();

        foreach User user in users {
            if (user.email == loginInfo.email && user.password == loginInfo.password) {
                matchingUser = user;
                break;
            }
        }

        if (matchingUser is User) {
            response.statusCode = 200;
            response.setHeader("Content-Type", "application/json");
            return response;
        } else {
            response.statusCode = 401;
            response.setHeader("Content-Type", "application/json");
            return response;
        }
    }
}
