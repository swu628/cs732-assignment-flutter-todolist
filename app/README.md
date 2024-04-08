# Todo List Application
Full tutorial here: https://youtu.be/mMgr47QBZWA


## Getting Started
Before you can launch the To Do List mobile application, you will need to install below tools...
* Flutter
* Android Studio
* Xcode
* An IDE such as Visual Studio Code (not compulsory but an IDE with Flutter extension is recommended)

### Install Flutter
Follow along with the [Flutter](https://docs.flutter.dev/get-started/install) installation website to install Flutter, below also shows a details in how to set it up with macOS M1

1. Open terminal and run the following code to install dependencies: 
```
sudo softwareupdate --install-rosetta --agree-to-license
```
2. Install the Flutter SDK
    1. Download the zip file from [Flutter](https://docs.flutter.dev/get-started/install/macos/mobile-ios?tab=download). It should be donwloaded into the `~/Downloads/` directory as default
    ![Flutter SDK zip file](readme_images/flutter_sdk.png)
    2. Run the code below in terminal to create a new folder under your home directory and goes into the directory. Flutter has suggested to create a directory at `~/development/`
        ```
        mkdir <path-name>
        cd <path-name>
        ```
    3. Run the code below in terminal to extract the zip file into the created folder
        ```
        unzip ~/Downloads/flutter_macos_arm64_3.19.5-stable.zip
        ```
    4. Add Flutter to your path: Either in the zshrc file for zsh terminal (run `vim .zshrc` to open it) or in the bash_profile file for bash terminal (run `vim .bash_profile` to open it). Add the code below
        ```
        export PATH="$PATH:<path-name>/flutter/bin"
        ```

If you run `flutter doctor` command, you will see that the status of all the tools. At this stage there should be error for Android Studio and Xcode as shown below. To elimiate the error, we need to install them...
![Errors](readme_images/errors.png)

### Install Android Studio
1. Install [Android Studio](https://developer.android.com/studio)
2. Open Android Studio => go to `Plugins` => search "Flutter" => cick `Install` (also install Dart) 
3. Go to `More Actions` => select `SDK Manager` => navigate to `Android SDK` => select `SDK Tools` option => install `Android SDK Command-line tools (latest)`
4. Run `flutter doctor --android-licenses` to accept the licences

If you run `flutter doctor` and sees a green tick next to Android Studio as shown below then you can move on to install Xcode.
![No Android Studio error](readme_images/no_androidstudio_error.png)


### Install Xcode
1. Install [Xcode](https://developer.apple.com/xcode/resources/)
2. Open Xcode => select `Settings` => select `location` tab => select version of Xcode in the `Command Line Tools` selector
3. Install cocoapods 
    ```
    sudo gem install cocoapods
    ```
Run `flutter doctor`, if everything shows in green like below, then your're all set!
![No error](readme_images/no_error.png)

### Using Visual Studio Code (not needed but recommended)
1. Install [Visual Studio Code](https://code.visualstudio.com/download)
2. Open Visual Studio Code and install Flutter extension: click on `Extensions` tab => search for "Flutter" => click on `install`
> [!NOTE]
> For your interest, if you want to create a Flutter project, you can use either the terminal or the command palette of Visual Studio Code...
> * **Terminal:** Run `flutter crate <project-name>` to create a flutter app => your app has been crated!
> * **Command palette of VS Code:** Press `Command + Shift + p` => type "flutter:" => click on `New Project` option => select the `Application` template => choose the location where you want to save your project => give a project name => your app has been created!


## How to launch the To Do List mobile application
After the set up has been completed, follow the steps below to run the To Do List Mobile application on your desired simulator...
1. Clone the project
    ```
    git clone https://github.com/UOA-CS732-SE750-Students-2024/cs732-assignment-swu628.git
    ```
2. Can use either the terminal or the Visual Studio Code to launch the project...
    * **Terminal**
        1. Launch either the iOS simulator `open -a Simulator` or the Andriod simulator (open Android Studio => click on `More Actions` => `Virtual Device Manager` => select the device)
        2. Go into the application directory `cd cs732-assignment-swu628`
        3. Run the Flutter app `flutter run`
    * **VS Code**
        1. Open the cloned project
        2. Select emluator: `Cmd+Shift+P` on keyboard for macOS or `Ctrl+Shift+P` for Windows => choose `Flutter: Launch Emulator` => then choose either the iOS or the Andriod emulator
        3. Launch the application by click on `Run` => then click `Run Without Debugging`

After complete the steps above, you should be able to start adding a task!


## Issues

