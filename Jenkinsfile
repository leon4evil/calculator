pipeline {
    agent any
    stages{
        stage("Compile"){
            steps{
                sh "./gradlew compileJava"
            }
        }
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
        stage("Docker build"){
            steps{
                sh "docker build -t lh51455/calculator ."
            }
        }
        stage("Docker push"){
            steps{
                sh "docker login -u 'lh51455' -p 'siB5_kH76j$r!k&' docker.io"
                sh "docker push lh51455/calculator"
            }
        }
    }
}
