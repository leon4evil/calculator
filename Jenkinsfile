pipeline {
    agent any

    environment {
            DOCKERHUB_CREDENTIALS = credentials('8730e26a-94d5-4465-acb5-afb7556a9506')
        }

    stages{
        stage("Compile"){
            steps{
                sh "./gradlew compileJava"
            }
        }
        stage("Unit test"){
            steps{
                sh "./gradlew test"
            }
         }
        stage("Code coverage"){
            steps{
                sh "./gradlew jacocoTestReport"
                publishHTML (target: [
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html',
                    reportName: "JaCoCo Report"
                ])
                sh "./gradlew jacocoTestCoverageVerification"
            }
        }
        stage("Static code analysis"){
            steps {
                publishHTML (target: [
                reportDir: 'build/reports/checkstyle',
                reportFiles: 'main.html',
                reportName: "Checkstyle Report"
                ])
                sh "./gradlew checkstyleMain"
            }
        }
        stage("Package"){
            steps{
                sh "./gradlew build"
            }
        }
        stage("Docker build"){
            steps{
                sh "docker build -t lh51455/calculator:${BUILD_TIMESTAMP} ."
            }
        }
        stage("Docker push"){
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh "docker push lh51455/calculator:${BUILD_TIMESTAMP}"
            }
        }
        stage("Update version"){
            steps {
                sh "sed -i 's/{{VERSION}}/${BUILD_TIMESTAMP}/g' deployment.yaml"
            }
        }
        stage("Deploy to staging"){
            steps{
                sh "kubectl config use-context docker-desktop"
                sh "kubectl apply -f hazelcast.yaml"
                sh "kubectl apply -f deployment.yaml"
                sh "kubectl apply -f service.yaml"
                // sh "docker run -d --rm -p 88:8081 --name calculator lh51455/calculator:${BUILD_TIMESTAMP}"
            }
        }
        stage("Acceptance test"){
            steps{
                sleep 30
                // sh "./gradlew acceptanceTest -Dcalculator.url=http://host.docker.internal:30626 --stacktrace"
                sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"
                // sh "test \$(curl --retry-connrefused --retry 5 --retry-delay 1 'http://host.docker.internal:88/sum?a=1&b=4') -eq 5"
            }
        }

        //Performance test stages

        stage("Release (PROD)"){
            steps{
                sh "kubectl config use-context arn:aws:eks:us-west-2:678962441975:cluster/education-eks-0N56QNCT"
                sh "kubectl apply -f hazelcast.yaml"
                sh "kubectl apply -f deployment.yaml"
                sh "kubectl apply -f service.yaml"

            }
        }

        stage("Smoke test"){
            steps{
                sleep 30
                sh "chmod +x smoke-test.sh && ./smoke-test.sh"
            }
        }
    }
    post {
        always {
            sleep 60 //need to sleep otherwise previous step fails
            sh "docker stop calculator:${BUILD_TIMESTAMP}"
        }
    }
}
