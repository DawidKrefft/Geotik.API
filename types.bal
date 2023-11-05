import ballerina/http;
import ballerina/constraint;

type User record {
    readonly int id;
    string email;
    string password;
};
type UserRequest record {

    @constraint:String{
        pattern: re `([a-zA-Z0-9._%\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,6})*`
    }
    string email;
    string password;
};
type ResetPasswordRequest record {
    string email;
};
type ErrorDetails record {
    string message;
    string details;
};
type UserNotFound record {|
    *http:NotFound;
    ErrorDetails body;
|};