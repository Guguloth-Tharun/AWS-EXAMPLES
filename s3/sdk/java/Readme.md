#create a new Maven project

```sh

mvn archetype:generate \
  -DgroupId=com.mycompany.app \
  -DartifactId=my-app \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DarchetypeVersion=1.5 \
  -DinteractiveMode=false
```

#sudo apt update
#sudo apt install -y openjdk-21-jdk maven

```sh
mvn -B archetype:generate \
  -DarchetypeGroupId=software.amazon.awssdk \
  -DarchetypeArtifactId=archetype-lambda \
  -Dservice=s3 \
  -Dregion=AP_SOUTH_2 \
  -DarchetypeVersion=2.21.29 \
  -DgroupId=com.example.myapp \
  -DartifactId=myapp
  ```