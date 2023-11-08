// Copyright (c) 2023 WSO2 LLC. (http://www.wso2.org).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.


import ballerina/io;
import ballerina/random;
import ballerinax/twilio;

// Account configurations
configurable string accountSID = ?;
configurable string authToken = ?;
configurable string twilioPhoneNumber = ?;

public function main() returns error? {
    // Twilio Client configuration
    twilio:ConnectionConfig twilioConfig = {
        auth: {
            username: accountSID,
            password: authToken
        }
    };

    // User Phone Number
    string phoneNumber = "+94712479175";

    // Initialize Twilio Client
    twilio:Client twilioClient = check new (twilioConfig);

    // Generate a random verification code
    string|error verificationCode = generateVerificationCode();

    if verificationCode is string {
        // Send SMS verification
        check sendSMSVerification(twilioClient, phoneNumber, verificationCode);

        // Make a call for verification
        check makeCallVerification(twilioClient, phoneNumber, verificationCode);
    }
}

function generateVerificationCode() returns string|error {
    // Generate a random 6-digit verification code
    int min = 100000;
    int max = 999999;
    int|error code = random:createIntInRange(min,max);
    if code is error{
        return code;
    }
    return code.toString();
}

function sendSMSVerification(twilio:Client twilioClient,string phoneNumber, string verificationCode) returns error?{
    // Send SMS verification
    twilio:CreateMessageRequest messageRequest = {
        To: phoneNumber,
        From: twilioPhoneNumber,
        Body: "Your verification code is: " + verificationCode
    };

    twilio:Message response = check twilioClient->createMessage(messageRequest);

    io:println("SMS verification sent with status: ",response?.status);
}

function makeCallVerification(twilio:Client twilioClient,string phoneNumber,  string verificationCode) returns error?{
    // Make a call for verification
    twilio:CreateCallRequest callRequest = {
        To: phoneNumber,
        From: twilioPhoneNumber,
        Url: "http://yourserver.com/verify-call.xml?code=" + verificationCode
    };

    twilio:Call response = check twilioClient->createCall(callRequest);

    io:println("Call verification initiated with status: ",response?.status);
}
