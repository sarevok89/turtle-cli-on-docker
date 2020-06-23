# Building apps using the turtle-cli
### These steps only apply for building Android apps. MacOS is required to build standalone iOS apps.
#### Following this walkthrough you can always refer to the official turtle-cli documentation [here](https://github.com/expo/turtle).
1. Make sure you have Docker and the expo-cli installed.
2. Login to your expo-cli using:
```
expo login --username <your_username/email> --password <your_password>
```
3. If you don't have a Keystore generated for this app move to your project directory, run `expo build:android` and tell Expo to generate one for you.
4. Once you have a Keystore generated fetch it using `expo fetch:android:keystore` command, and save it safely. You can also add it and your Expo credentials as environment variables. You can do this by adding the following lines to the `.bashrc` file in your home directory (Linux).
```
export EXPO_USERNAME=<your_expo_username>
export EXPO_PASSWORD=<your_expo_password>
export EXPO_ANDROID_KEYSTORE_PASSWORD=<keystore_password>
export EXPO_ANDROID_KEY_PASSWORD=<key_pass>
```
5. Log out and log back in or run the `source ~/.bashrc` command to re-run your `.bashrc` file and make your changes active. (Linux)
6. Get into the directory with your Dockerfile and run the `docker build -t turtle .` command. Note that during the installation of turtle-cli a few warnings my appear but simply ignore them and wait for the process to finish.
7. Get back to your project directory and run:
```
docker run --name turtle \
-v <path_to_your_project_repository>:/home/node/<app_name> \
-e EXPO_USERNAME=$EXPO_USERNAME \
-e EXPO_PASSWORD=$EXPO_PASSWORD \
-e EXPO_ANDROID_KEYSTORE_PASSWORD=$EXPO_ANDROID_KEYSTORE_PASSWORD \
-e EXPO_ANDROID_KEY_PASSWORD=$EXPO_ANDROID_KEY_PASSWORD \
-e KEYSTORE_ALIAS=$KEYSTORE_ALIAS \
-it turtle
```
This will create and run a new container named 'turtle' with all packages and dependencies installed and map all required environment variables from our host. You can also pass all environment variables values manually.

8. The container stops once we run the `exit` command in its bash console. To get back into it run:
```
docker start -i turtle
```
9. Now we're ready to build the app. Move to your app directory inside the docker container and run:
```
turtle build:android \
--keystore-path /home/node/<your_app_dir_name>/<your_app_dir_name>.jks \
--keystore-alias $KEYSTORE_ALIAS -t apk
```
To get the output file in the `.aab` format simply omit the ` -t apk` argument.
10. The whole process takes a few minutes. Once it finishes you can find the generated file in the `~/expo-apps` directory. To get it out of the container we can move it to our app directory with:
```
mv ~/expo-apps/<your_file_name>.aab ~/alert_app/
```
#### If you have any questions or have spotted any bugs let me know.
