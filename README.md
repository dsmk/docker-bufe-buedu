The general workflow while we are building the system is to:

1) Update the test/sut/test_app.sh script to test the new functionality with the current Solaris.  This involves 
   running the script like so `./test/sut/test_app.sh -S test www-test.bu.edu`  - the -S disables the check for 
   upstream headers (only configured in NGINX for now).

2) Once that is done then one needs to update the NGINX configuration to implement the same functionality as 
   Solaris.  This mainly will involve the \*.conf.erb files in the main directory but make involve new environment
   entries.  One can test this on a local build box by running `docker-compose -f www-test.bu.edu.yaml up --build` 
   and then `./test/sut/test_app.sh test`  This is testing with the normal www-test backends.

3) Next the automatic testing needs to be configured.  This involves two sets of changes - `autotest-test.yml` 
   docker-compose file and updates to the `test/backend` Docker image.  The docker-compose file will create a
   container to run the tests, an NGINX frontend container, and a test backend container which emulates test
   responses.  The goal of this test framework is to test and minimize regressions in the frontend containers.  It
   is not intended to be a test of whole services.

4) One can pretest the automatic testing by doing `docker-compose -f autotest-test.yaml up --build ` - if 
   everything is OK then the last line will end "exited with code 0."  Control-C to exit from the test and 
   it will stop all the containers set up.  The test output is stored in the `test/results/` directory and you 
   can see the specific test that failed by searching for `exit code: 1` 

5) When you are ready to release changes you need to check the changes into Git and push them to GitHub.  Here 
   are some common commands:
        a) `git status` - see which files have been modified, which are new, what is selected for commiting, and 
           the branch.
        b) `git diff [file]` - see what has changed from the last commit.
        c) `git add file` - add a file to the list of things to check in.
        d) `git commit -m 'msg'` - commit added files with the message msg (include INC* and ENC* where appropriate)
        e) `git push` - push the changes to github

6) Right now one needs to go to hub.docker.com/r/dsmk/bufe-buedu, select "Build Settings", and select the Trigger
   to start the build.  This will be replaced later.  You can see the status of the build by going to "Build Details"

7) Once the new image is done you can replace the existing container by going to the ECS web console, selecting
   the task we want to modify (bufe-bu.edu-bufe:num), select "Create new revision", and then selecting "Create".  
   This will take a while to run because ECS will create a new container, add it to the ELB/ALB, and wait for the 
   old one to drain completely before being done.  This will be replaced later.

