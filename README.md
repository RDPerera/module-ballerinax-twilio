# Ballerina Twilio Connector
 
[![Build](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-twilio/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-twilio.svg)](https://github.com/ballerina-platform/module-ballerinax-twilio/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/twilio.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module/twilio)

## Overview

Twilio is a cloud communications platform that allows software developers to programmatically make and receive phone calls, send and receive text messages, and perform other communication functions using its web service APIs. 

The Ballerina Twilio connector supports the [Twilio Basic API version 2010-04-01](https://www.twilio.com/docs/iam/api), enabling users to leverage these communication capabilities within their Ballerina applications.

## Setup guide

Before using the ballerinax-twilio connector you must have access to Twilio API, If you do not have access to Twilio API please complete the following steps:

### Step 1: Create a Twilio account

Creating a Twilio account can be done by visiting [Twilio](https://www.twilio.com) and clicking the "Try Twilio for Free" button.

### Step 2: Obtain a Twilio phone number

All trial projects can provision a free trial phone number for testing. Here's how to get started.

> **Notice:** Trial project phone number selection may be limited. You must upgrade your Twilio project to provision more than one phone number, or to provision a number that is not available to trial projects.

1. Access the Buy a Number page in the Console.

![Get Phone Number](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/get-phone-number.png)

2. Enter the criteria for the phone number you need, and then click Search.

![Configure Phone Number](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/phone-number-config.png)

- Country: Select the desired country from the drop-down menu.
- Number or Location: Select the desired option to search by digits/phrases, or a specific City or Region.
- Capabilities: Select your service needs for this number. 

3. Click Buy to purchase a phone number for your current project or sub-account.

![Search Results](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/search-phone-number.png)
> **Notice:** Many countries require identity documentation for Phone Number compliance. Requests to provision phone numbers with these regulations will be required to select or add the required documentation after clicking Buy in Console. To see which countries and phone number types are affected by these requirements, please see twilio's [Phone Number Regulations](https://www.twilio.com/guidelines/regulatory) site.

### Step 3: Obtain a Twilio account Sid with auth token

Twilio uses two credentials to determine which account an API request is coming from: The account Sid, which acts as a `username`, and the Auth Token which acts as a `password`. You can find your account Sid and auth token in your [Twilio console](https://www.twilio.com/console).

![Twilio Credentials](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-twilio/master/ballerina/resources/get-credentails.png)

Your account's Auth Token is hidden by default. Click show to display the token, and hide to conceal it again. For further information click [here](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them)

## Quickstart

To use the `twilio` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1 - Import the module

Import the Twilio module into your Ballerina program as shown below:

```ballerina
import ballerinax/twilio;
```

### Step 2 - Create a new connector instance

To create a new connector instance, add a configuration as follows (You can use [configurable variables](https://ballerina.io/learn/by-example/configurable.html) to provide the necessary credentials):

```ballerina
configurable string accountSid = ?;
configurable string authToken = ?;

twilio:ConnectionConfig twilioConfig = {
    auth: {
        username: accountSid,
        password: authToken
    }
};

twilio:Client twilio = check new (twilioConfig);
```

### Step 3 - Invoke the connector operation

Invoke the sending SMS operation using the client as shown below:

```ballerina
public function main() returns error? {
    twilio:CreateMessageRequest messageRequest = {
        To: "+XXXXXXXXXXX", // Phone number that you want to send the message to
        From: "+XXXXXXXXXXX", // Twilio phone number
        Body: "Hello from Ballerina"
    };

    twilio:Message response = check twilio->createMessage(messageRequest);

    // Print the status of the message from the response
    io:println("Message Status: ", response?.status);
}
```

### Step 4: Run the Ballerina application

Execute the command below to execute the Ballerina application:

```bash
bal run
```

## Examples

The Twilio connector comes equipped with examples that demonstrate its usage across various scenarios. These examples are conveniently organized into three distinct groups based on the functionalities they showcase. For a more hands-on experience and a deeper understanding of these capabilities, we encourage you to experiment with the provided examples in your development environment.

1. Account management
    - [Create a sub-account](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/accounts/create-sub-account) - Create a subaccount under a Twilio account
    - [Fetch an account](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/accounts/fetch-account) - Get details of a Twilio account
    - [Fetch balance](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/accounts/fetch-balance) - Get the balance of a Twilio account
    - [List accounts](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/accounts/list-accounts) - List all subaccounts under a Twilio account
    - [Update an account](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/accounts/update-account) - Update the name of a Twilio account
2. Call management
    - [Make a call](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/calls/create-call) - Make a call to a phone number via a Twilio
    - [Fetch call log](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/calls/fetch-call-log) - Get details of a call made via a Twilio
    - [List call logs](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/calls/list-call-logs) - Get details of all calls made via a Twilio
    - [Delete a call log](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/calls/delete-call-log) - Delete the log of a call made via Twilio
3. Message management
    - [Send an SMS message](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/messages/create-sms-message) - Send an SMS to a phone number via a Twilio 
    - [Send a Whatsapp message](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/messages/create-whatsapp-message) - Send a Whatsapp message to a phone number via a Twilio
    - [List message logs](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/messages/list-message-logs) - Get details of all messages sent via a Twilio
    - [Fetch a message log](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/messages/fetch-message-log) - Get details of a message sent via a Twilio
    - [Delete a message log](https://github.com/ballerina-platform/module-ballerinax-twilio/tree/master/examples/messages/delete-message-log) - Delete a message log via a Twilio

## Issues and projects 

The **Issues** and **Projects** tabs are disabled for this repository as this is part of the Ballerina library. To report bugs, request new features, start new discussions, view project boards, etc., visit the Ballerina library [parent repository](https://github.com/ballerina-platform/ballerina-library). 

This repository only contains the source code for the package.
 
## Build from the source

### Prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following sources:

   * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
   * [OpenJDK](https://adoptium.net/)

    > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

    > **Note**: Ensure that the Docker daemon is running before executing any tests.

### Build options

Execute the commands below to build from the source.

1. To build the package:
   ```
   ./gradlew clean build
   ```

2. To run the tests:
   ```
   ./gradlew clean test
   ```

3. To build the without the tests:
   ```
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

   The following test environments, along with their respective groups of compatible tests, are available to test the connector.

   Groups | Environment
   ---| ---
   mock_tests | Mock server for Twilio API (Defualt Environment)
   live_tests | Twilio API

   To run tests against these environments, you can follow this [Test Guide](https://github.com/ballerina-platform/module-ballerinax-twilio/blob/master/ballerina/tests/README.md).

5. To debug the package with a remote debugger:
   ```
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:
   ```
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:
    ```
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:
   ```
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [Twilio package](https://central.ballerina.io/ballerinax/twilio/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
