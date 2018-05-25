FROM tomcat:9.0-jre8
MAINTAINER Tim Robinson <tim.robinson@atos.net>

# Add a tomcat user
RUN groupadd -r tomcat && \
    useradd -g tomcat -d ${CATALINA_HOME} -s /bin/bash tomcat && \
    chown -R tomcat:tomcat $CATALINA_HOME

USER tomcat

# Deploy OpenAM v13.0.0
RUN mkdir /tmp/openam && cd /tmp/openam && \
    wget https://github.com/OpenRock/OpenAM/releases/download/13.0.0/OpenAM-13.0.0.war && \
    mv *.war $CATALINA_HOME/webapps/openam.war

ENV CATALINA_OPTS="-Xmx2048m -server"

# Deploy OpenAM v13.0.0 Config Tools
RUN mkdir /tmp/oam-config && cd /tmp/oam-config && \
    wget https://github.com/OpenRock/OpenAM/releases/download/13.0.0/SSOConfiguratorTools-13.0.0.zip && \
    unzip *.zip && \
    cp sampleconfiguration openam-config.properties && \
    sed -i 's/ACCEPT_LICENSES=false/ACCEPT_LICENSES=true/' openam-config.properties && \
    mkdir $CATALINA_HOME/openam && \
    $CATALINA_HOME/bin/startup.sh && \
    sleep 5 && \
    java -jar openam-configurator-tool-13.0.0.jar \          
             --file openam-config.properties \
             --acceptLicense && \
    rm *.zip

