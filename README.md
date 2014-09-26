Turnin Webapp
=============

Originally written By Jonathan Clark 2011
For 11-711 at Carnegie Mellon University. 
Modified for Leonid Boytsov in 2014 by adding
a call to a script that can verify archive's consistency.


Overview
========

A tool for instructors that allows students to submit **.tar.gz** files using a web interface.

Features:

* Dead simple web-interface
* Minimal configuration
* Built-in cryptographic receipt system to verify student turn-in claims (in case there is a discrepancy between the file on-disk and a file the student claims to have submitted)
* Tracks multiple submissions

The most recent version of files submitted are kept in data/uploads. The entire history of files submitted by students is kept in data/uploads/all. All generated receipts are logged to data/receipts.log.


Building and Running the WebApp
===============================

This app is built ontop of Scalatra https://github.com/scalatra/scalatra

You'll need Scala 2.9.1+ installed. You probably want to run this as a special user with very few permissions.

```
./build.sh
./run.sh
```

Now have a look at your turnin server running at http://localhost:8081


Configuration
=============

Edit turnin.conf

Several parameters can be changed:

* uploadDir a directory to upload files
* keyFile a file with the key (keep the same for all homeworks)
* receiptLogFile a file with receipts (make it homework specific)
* manifestFile a list of files that must be present (make it homework specific)
* checkScript a script that checks a submitted tar.gz archive for consistency (make it homework specific)
* pageTitle A title of the submission page

A **sample configuration** is provided. In this configuration, files are uploaded to the directory data/hw2

You can change the logo by replacing webapps/turnin/logo.png . Currently, the logo is transparent.

Checking script
=====================

One **must** specify a checking script that accepts that submitted archive as an argument. If the script succeds, it should return 0 and a non-zero status should be produced otherwise. In the case of error, the standard output *is printed to the submitted page*. 


Working with Receipts
=====================

Generating an Encryption Key for Turnin Receipts
------------------------------------------------

You'll need to generate a unique secret key, which will be used to generate recepts. Make sure to keep this secret from the people who you will be giving receipts to.

```
./keygen.sh data/key.bin
```

Verifying the Time and MD5 Checksum of a Submission
---------------------------------------------------

Given the receipt (e.g. a362b2bf7cd6dc646e7fabc478208752), you can verify the time of submission.
If the student also provides the file they claim to have submitted, you can also verify the file's contents.

```
./view.sh data/key.bin a362b2bf7cd6dc646e7fabc478208752
md5sum file_student_claims_submitted.tar.gz
```

Checking for Stolen Receipts
----------------------------

If a student claims the receipt of another student, you can verify this by grepping through the file "receipts.log",
which records all issued receipts.

Manually Generating a Receipt
-----------------------------

You should never need to do this manually since the webapp does this for you. But just in case:

```bash
./generate.sh data/key.bin start.jar
```

Future Features
===============

* The build.sh hardcodes location of scala libraries, but this can probably be fixed
* Protection against bots


References
==========

http://wiki.eclipse.org/Jetty/Reference/Dependencies
http://wiki.eclipse.org/Jetty/Feature/WebAppDeployer
http://www.enavigo.com/2008/08/29/deploying-a-web-application-to-jetty/
http://scalate.fusesource.org/documentation/user-guide.html
