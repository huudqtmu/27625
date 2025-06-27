pipeline {
 agent any
 
 stages {
	stage('clone'){
		steps {
			echo 'Cloning source code'
			git branch:'main', url: 'https://github.com/huudqtmu/projectnet.git'
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
			//iisreset /stop // stop iis de ghi de file 
			bat 'xcopy "%WORKSPACE%\\publish" /E /Y /I /R "c:\\wwwroot\\P27625"'
 		}
	}

  } // end stages
}//end pipeline
