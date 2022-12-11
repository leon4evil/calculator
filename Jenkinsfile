pipeline {
    agent any

    environment {
            DOCKERHUB_CREDENTIALS = credentials('8730e26a-94d5-4465-acb5-afb7556a9506')
        }

    stages{
//         stage("Compile"){
//             steps{
//                 sh "./gradlew compileJava"
//             }
//         }
//         stage("Unit test"){
//             steps{
//                 sh "./gradlew test"
//             }
//          }
//         stage("Code coverage"){
//             steps{
//                 sh "./gradlew jacocoTestReport"
//                 publishHTML (target: [
//                     reportDir: 'build/reports/jacoco/test/html',
//                     reportFiles: 'index.html',
//                     reportName: "JaCoCo Report"
//                 ])
//                 sh "./gradlew jacocoTestCoverageVerification"
//             }
//         }
//         stage("Static code analysis"){
//             steps {
//                 publishHTML (target: [
//                 reportDir: 'build/reports/checkstyle',
//                 reportFiles: 'main.html',
//                 reportName: "Checkstyle Report"
//                 ])
//                 sh "./gradlew checkstyleMain"
//             }
//         }
//         stage("Package"){
//             steps{
//                 sh "./gradlew build"
//             }
//         }
//         stage("Docker build"){
//             steps{
//                 sh "docker build -t lh51455/calculator ."
//             }
//         }
//         stage("Docker push"){
//             steps {
//                 sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
//                 sh "docker push lh51455/calculator"
//             }
//         }
        stage("Deploy to staging"){
            steps{
                sh "docker run -d --rm -p 8765:8080 --name calculator lh51455/calculator"
            }
        }
        stage("Acceptance test"){
            steps{
                sleep 120
                sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"
            }
        }

    }
    post {
        always {
            sh "docker stop calculator"
        }
    }
}
