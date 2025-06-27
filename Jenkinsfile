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

  } // end stages
}//end pipeline
