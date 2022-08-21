
pipeline {
    agent { label 'buildtool' }
    options { 
        timeout(time: 1, unit: 'HOURS')
        retry(2) 
    }
    parameters {
        choice(name: 'GOAL', choices: ['compile', 'package', 'clean package'])
    }
    stages {
        stage('Build the Code and sonarqube-analysis') {
            steps {
//withSonarQubeEnv('sonar') here name will which integrated in jenkins configuration
                withSonarQubeEnv('sonar') {
                    sh script: "mvn ${params.GOAL} sonar:sonar"
                }
            }
        }
        stage('reporting') {
            steps {
                junit testResults: 'target/surefire-reports/*.xml'
            }
        }

    }

}