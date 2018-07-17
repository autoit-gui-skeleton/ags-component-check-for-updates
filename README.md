AGS-component-check-for-updates
===============================

> Add the feature to check for updates to an AutoIt application built with the [AGS framework](https://v20100v.github.io/autoit-gui-skeleton/). 



<br/>

## How to install AGS-component-check-for-updates ?

In order to simplify the management of the dependencies of an AutoIt project built with AGS framework, we have diverted form its initial use the dependency manager npm, and its evolution Yarn. This allows us to manage the dependencies of an AGS project with other AutoIt libraries, and to share these AutoIt packages from the npmjs.org repository. All AGS packages hosted in this npmjs repository belong to [@autoit-gui-skeleton organization](https://www.npmjs.com/org/autoit-gui-skeleton)

We assume that you have already install [Node.js](https://nodejs.org/) and [Yarn](https://yarnpkg.com/lang/en/), for example with [Chocolatey](https://chocolatey.org/), so to install AGS-component-http-request, just type in the root folder of your project where the `package.json` is saved :

```
λ  yarn add @autoit-gui-skeleton/ags-component-check-for-updates --modules-folder web/vendor
```

This package is installed into the `./vendor` directory. To use it in your AutoIt program, you need to include this library with this instruction:

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-component-check-for-updates/ags-component-check-for-updates.au3'
```



<br/>

## AGS's vendor directory

To install AutoIt dependencies in the `./vendor` directory, and not in the default directory of Node.js `./node_modules`, you must add the `--modules-folder vendor` option. We force this choice to avoid any confusion with a Node.js project. 

Note that with an AGS project, it is not necessary to explicitly write this option on the command line, thanks to the `.yarnrc` file stored at the root of the project. Yarn automatically use this file to add an additional configuration of options.

```
 #./.yarnrc 
 --modules-folder vendor
 ```
 
So with this file you can run `yarn add @autoit-gui-skeleton/ags-component-check-for-updates` to install the dependencies directly into the appropriate `./vendor` directory.



<br/> 

## AGS-component-check-for-updates

### Description

With AGS-component-check-for-updates, you can create an AutoIt application that has a feature to check for updates.

![ags-component-check-for-updates :: update available](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-update-available.png)

To work, it compares the local version of the application installed on the user's PC with the repository of the published versions of the application. This repository is a json file, `RELEASES.json`, which is therefore hosted on a remote server. So we need to connect to the Internet to send an HTTP request to retrieve this file, and we need a JSON parse. This component therefore depends on other AGS components: ags-wrapper-json and ags-component-http-request. If you want to simulate different scenarios ofcheck for updates, you just need to change the value of the application version set in `./src/GLOBALS.au3`.

The remote file `RELEASES.json` looks like this:

```json
{
  "name": "ApplicationWithCheckForUpdates",
  "description": "Example to implementation of AGS-component-check-for-updates",
  "license": "MIT",
  "homepage": "https://autoit-gui-skeleton.github.io",
  "releases": [
    {
      "version": "1.0.0",
      "state": "stable",
      "downloadSetup": "https://myApplication.com/v1.0.0/setup_myApplication_v1.0.0.exe",
      "published": "2018-10-07",
      "releaseNotes": "https://myApplication.com/v1.0.0/README.md"
    },
    {
      "version": "0.1.0",
      "state": "prototype",
      "downloadSetup": "undefined",
      "published": "2014-03-21",
      "releaseNotes": "undefined"
    }
  ]
}
```


### Available methods

This library provides few methods:

 Methods    | Description 
---------------|-------------
`json_decode_from_file($filePath)` | Decode JSON from a given local file.
`json_decode_from_url($jsonfileUrl, $proxy = "")` | Decode JSON from a given URL.
`RELEASES_JSON_get_all_versions($jsonObject)` | Parse all defined version(s) persisted in a decoded RELEASES.json file given.
`RELEASES_JSON_get_last_version($jsonObject)` | Get last version persisted in RELEASES.json
`CheckForUpdates($currentApplicationVersion, $remoteUrlReleasesJson, $proxy = "")` | Compare the current version with the last version persisted in an remote RELEASES.json file, in order to check if an update is available.
`_GUI_launch_CheckForUpdates($main_GUI, $context)` | Launch a check for updates. The build of a GUI exposing the results depends on the context when the check for update is launch : with an user interaction from menu or on startup application. We store the option to search update on starup in the configuration file `./config/parameters.ini` in parameter `LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP`.
`_GUI_build_view_to_CheckForUpdates($main_GUI, $resultCheckForUpdate, $context = "")` | Create a child GUI use to expose the result of a check updater. It exposes if an update of current application is available. The child GUI is related to a given main GUI of application. If this method is execute on startup, we built this child GUI only if an update is available. And when this method is called by a user interaction, we built this child GUI in any case : no update available, new update or experimental.


### Configuration

To configure the behavior of this component, you can set its options in the `./config/parameters.ini` file. For example, you can enable or disable the search of a new update when the application starts, with the `LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP` variable of the section `AGS_CHECK_FOR_UPDATES`.

```ini
## ./config/parameters.ini ##
[AGS_CHECK_FOR_UPDATES]
; [REQUIRED] Enable/disable the search of a new update on start-up.
LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP=1
```


### Example of an application that implements AGS-component-check-for-updates

Take a look of this example of an AutoIt application which implement AGS-component-check-for-updates [ApplicationWithCheckForUpdates](https://github.com/autoit-gui-skeleton/AGS-component-check-for-updates/tree/master/example/ApplicationWithCheckForUpdates). This application have this features :

 - Check update on startup AutoIt application ;
 - Check update from the menu "? > Check for update" ;
 - Change settings application from the view "Configuration > Settings". Values are persisted into the configuration file ./config/parameters.ini. In this view, we can set proxy parameters to specify how this application try to connect to internet.

If the option to check update on startup application is enabled, and if a new version of this application is available, when the user starts application he gives this information on a child window:



<br/>
 
## About
  
### Contributing
 
Comments, pull-request & stars are always welcome !
 
### License
 
Copyright (c) 2018 by [v20100v](https://github.com/v20100v). Released under the MIT license.