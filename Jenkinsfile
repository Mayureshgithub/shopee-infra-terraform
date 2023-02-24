pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
            git branch: 'main', url: 'https://github.com/Mayureshgithub/shopee-infra-terraform.git'           
           }
        }
        
        stage ("terraform init") {
            steps {
                sh ('terraform init') 
            }
        }
        stage ("terraform plan") {
            steps {
                sh ('terraform plan') 
            }
        }
        
        stage ("terraform apply") {
            steps {
                
                sh ('terraform apply --auto-approve') 
           }
        }
    }
}
