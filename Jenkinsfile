node{
     
    stage('scm github checkout'){
        git url: 'https://github.com/mithuntechnologiesdevops/java-web-app-docker.git',branch: 'master'
    }
    
    stage(" maven clean package"){
      def mavenhome =  tool name: "maven-3.5.6", type: "maven"
      def mavencmd = "${mavenhome}/bin/mvn"
      sh "${mavencmd} clean package"
      
    } 
    
    
    stage('build docker image'){
        sh 'docker build -t dockerhandson/java-web-app .'
    }
    
    stage('Push Docker Image'){
        withCredentials([string(credentialsId: 'Docker_Hub_Pwd', variable: 'Docker_Hub_Pwd')]) {
          sh "docker login -u dockerhandson -p ${Docker_Hub_Pwd}"
        }
        sh 'docker push dockerhandson/java-web-app'
     }
     
      stage('Run Docker Image In Dev Server'){
        
        def dockerRun = ' docker run  -d -p 8080:8080 --name java-web-app dockerhandson/java-web-app'
         
         sshagent(['DOCKER_SERVER']) {
          sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.20.72 docker stop java-web-app || true'
          sh 'ssh  ubuntu@172.31.20.72 docker rm java-web-app || true'
          sh 'ssh  ubuntu@172.31.20.72 docker rmi -f  $(docker images -q) || true'
          sh "ssh  ubuntu@172.31.20.72 ${dockerRun}"
       }
       
    }
     
     
}
