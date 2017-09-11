The templates in this directory are based on the following sources:

- http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/quickref-ecs.html
- https://aws.amazon.com/blogs/compute/continuous-deployment-to-amazon-ecs-using-aws-codepipeline-aws-codebuild-amazon-ecr-and-aws-cloudformation/

Eventually we will incorporate items from the following sources:

- http://docs.aws.amazon.com/codebuild/latest/userguide/how-to-create-pipeline.html#how-to-create-pipeline-add-test
- https://aws.amazon.com/blogs/aws/codepipeline-update-build-continuous-delivery-workflows-for-cloudformation-stacks/
- http://docs.aws.amazon.com/codecommit/latest/userguide/how-to-migrate-repository-existing.html
- https://sanderknape.com/2016/06/getting-ssl-labs-rating-nginx/ 
- https://aws.amazon.com/blogs/compute/continuous-deployment-for-serverless-applications/
- https://github.com/awslabs/aws-waf-security-automations
- https://sanderknape.com/2017/06/infrastructure-as-code-automated-security-deployment-pipeline/
- https://github.com/andreaswittig/codepipeline-codedeploy-example


Various methods to test with CodePipeline:
- https://aws.amazon.com/blogs/devops/implementing-devsecops-using-aws-codepipeline/

How to do this with an external continuous integration other than CodePipeline (CircleCI):
- https://circleci.com/docs/1.0/continuous-deployment-with-aws-ec2-container-service/

aws --profile webpoc cloudformation validate-template --template-body file:///home/dsmk/projects/docker-bufe-buedu/aws/iam.yaml
