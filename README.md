# Building apps using the turtle-cli
### These steps only apply for building Android apps. MacOS is required to build standalone iOS apps.
#### Following this walkthrough you can always refer to the official turtle-cli documentation [here](https://github.com/expo/turtle).
1. Make sure you have Docker installed.
2. Get into the directory with your Dockerfile and run the `docker build -t turtle .` command. Note that during the installation of turtle-cli a few warnings my appear but simply ignore them and wait for the process to finish.
3. Get back to your project directory and run:
```
docker run --name <name_you_want_to_use_for_this_container> \
-v <path_to_your_project_repository>:/home/node/<repository_directory_name> \
-e EXPO_USERNAME=<your_expo_username> \
-e EXPO_PASSWORD=<your_expo_password> \
-it turtle
```
This will create and run a new container named 'turtle' with all packages and dependencies installed.

4. The container stops once we run the `exit` command in its bash console. To get back into it run:
```
docker start -i turtle
```
5. Get into your container and login to the expo-cli using:
```
expo login --username <your_username> --password <your_password>
```
6. If you don't have a Keystore generated for this app move to your project directory, run `expo build:android` and tell Expo to generate one for you.
7. Once you have a Keystore generated fetch it using `expo fetch:android:keystore` command, and save it safely. This will also create a `*.jks` file in the project repository.
8. Add `EXPO_ANDROID_KEYSTORE_PASSWORD` and `EXPO_ANDROID_KEY_PASSWORD` as your environment variables. You can easily do this by appending proper export commands to the end of the .bashrc file inside your running container like this.
```
echo "export EXPO_ANDROID_KEYSTORE_PASSWORD=<your_keystore_password>" >> ~/.bashrc 
echo "export EXPO_ANDROID_KEY_PASSWORD=<your_key_password>" >> ~..bashrc 
```
9. Reload the .bashrc file with the `source ~/.bashrc` command. In case you added incorrect values to the .bashrc file simply edit it and re-run the `source ~/.bashrc` command.
10. Now we're ready to build the app. Move to your app directory inside the docker container and first run:
```
expo publish
```
And then run:
```
turtle build:android \
--keystore-path /home/node/<your_app_dir_name>/<your_app_dir_name>.jks \
--keystore-alias <your_key_alias> -t apk
```
To get the output file in the `.aab` format simply omit the ` -t apk` argument.
11. The whole process takes a few minutes. Once it finishes you can find the generated file in the `~/expo-apps` directory. To get it out of the container we can move it to our app directory with:
```
mv ~/expo-apps/<your_file_name>.aab ~/alert_app/
```
#### If you have any questions or have spotted any bugs let me know.
