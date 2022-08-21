pipeline {
  agent any
  stages {
    stage('checkout') {
      steps {
        cleanWs()
        git(url: 'https://gitlab.rebrainme.com/devops_users_repos/2735/do-final-2.git', branch: 'master', credentialsId: 'Jenkins')
      }
    }

    stage('build') {
      steps {
        sh '''#!/bin/bash -xe
	      cd $WORKSPACE
        composer config --no-plugins allow-plugins.composer/installers true
        composer install
        php artisan october:env
        '''
      }
    }

    stage('deploy') {
      steps {
        sh '''#!/bin/bash -xe
        cd $WORKSPACE
        mkdir -p /opt/october/versions/$(git describe --tags)
	      cp -r * /opt/october/versions/$(git describe --tags)
        ln -sf /etc/october/env /var/www/demo/current /opt/october/versions/$(git describe --tags)/.env
	      ln -sf /opt/october/versions/$(git describe --tags) /opt/october/current
        sudo systemctl reload php7.2-fpm.service
        '''
      }
    }
  }
  post {
        always {
            cleanWs()
        }
    }
}
