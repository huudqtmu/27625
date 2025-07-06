pipeline {
 agent any
 
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
	stage ('Publish') {
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
					  docker build -t p27625:lastest -f "%WORKSPACE%\\Dockerfile" .
					'''
                }
            }

		// dua vao docker image
		stage('docker run') {
            steps {
				# Stop old container 
				 bat 'docker stop p27625run'

				# Remove container 
				 bat 'docker rm p27625run'

                  bat 'docker run -d --name p27625run -p 91:3000 p27625:lastest'
                }
            }
		 
  } // end stages
}//end pipeline
