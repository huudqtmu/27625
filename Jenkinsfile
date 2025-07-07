pipeline {
 agent any

  environment {
        LANG = 'en_US.UTF-8'
        LC_ALL = 'en_US.UTF-8'
		DOCKERHUB_CREDENTIALS = 'hubdocker'  // ID credentials
        IMAGE_NAME = 'huudq/p27625 '  // name of image on Docker Hub -- create repo on hub.docker
		DOCKER_IMAGE_NAME = 'p27625'  // Tên Docker image
        DOCKER_TAG = 'v1'  // Tag cho Docker image
    }

 stages {
	 

	stage('clone'){
		steps {
			echo 'Cloning source code'
			git branch:'main', url: 'https://github.com/huudqtmu/27625.git'
		}
	} // end clone
	stage('restore package') {
		steps
		{
			echo 'Restore package'
			bat 'dotnet restore'
		}
	}
stage ('build') {
		steps {
			echo 'build project netcore'
			bat 'dotnet build  --configuration Release'
		}
	}
stage ('public den t thu muc')
	{
		steps{
			echo 'Publishing...'
			bat 'dotnet publish -c Release -o ./publish'
		}
	}
/*	stage ('Publish') {
		steps {
			echo 'public 2 runnig folder'
			bat 'iisreset /stop'
			bat 'xcopy "%WORKSPACE%\\publish" /E /Y /I /R "c:\\wwwroot\\P27625"'
			bat 'iisreset /start'
 		}
	}
	
	stage('Deploy to IIS') {
            steps {
                powershell '''
                 Import-Module WebAdministration
                if (-not (Test-Path IIS:\\Sites\\P27625)) {
                    New-Website -Name "P27625" -Port 81 -PhysicalPath "c:\\wwwroot\\P27625"
                }
                '''
            } 
        } // end deploy iis
		// dua vao docker image
		stage('docker image') {
            steps {
                 bat '''
					  docker build -t p27625:latest -f "%WORKSPACE%\\Dockerfile" .
					'''
                }
            }
	*/
		stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from Dockerfile
                    docker.build("${DOCKER_IMAGE_NAME}:latest")
                }
            }
        }
		stage('Tag Docker Image') {
            steps {
          		 docker.image("${DOCKER_IMAGE_NAME}:latest").tag("${DOCKER_IMAGE_NAME}:${DOCKER_TAG}")
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // login Docker Hub to push image
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        // login Docker Hub credentials
                    }
                }
            }
        }
		 
        stage('Push Docker Image') {
            steps {
				 
                script {
                    // push Docker image lên Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_TAG}").push()
                    }
                }
            }
        }

        stage('Cleanup') {
            steps {
                // clean image Docker after push
                bat 'docker rmi ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}'
            }
        }

		/*
		// dua vao docker image
		stage('docker run') {
            steps {
				// # Stop old container 
				// bat 'docker stop p27625run'
				 bat '''
					@echo off
					for /f "delims=" %%i in ('docker ps -a --filter "name=p27625run" --format "{{.Names}}"') do (
						set container=%%i
					)
					if defined container (
					 
						docker stop p27625run >nul 2>&1
						 
						docker rm p27625run
					)  
                '''

				// # Remove container 
				 // bat 'docker rm p27625run'

                  bat 'docker run -d --name p27625run -p 91:3000 p27625:latest'
                }
            }
		 */
  } // end stages
}//end pipeline
