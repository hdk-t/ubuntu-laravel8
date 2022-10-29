# ubuntu_laravel_build
Laravel on Ubuntu Docker Container !  

## Over View
### Latest Version
thideki/ubuntu-laravel8:v2

### DockerHub  
https://hub.docker.com/r/thideki/ubuntu-laravel8

### Environment  
- Ubuntu: 20.04  
- PHP: 7.4  
- npm: latest  
- node.js: latest  
- Composer: latest  
- Laravel: 8.x  
- Nginx: latest  

## Usage
### Image Building
    docker build ./ -t ubuntu-laravel8:local  

### Docker Run
If /opt/html is empty then create Laravel project in /opt/html  
See docker-entrypoint.sh for details  

    docker run -it --name ubuntu_laravel -p 80:80 ubuntu-laravel8:local  
