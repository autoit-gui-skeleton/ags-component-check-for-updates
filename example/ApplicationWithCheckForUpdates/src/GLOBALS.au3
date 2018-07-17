#cs ----------------------------------------------------------------------------

Defines application constants and variables declared in global scope.

All constants and global variables are set in one place './src/GLOBALS.au3',
With the exception to global variables of graphic elements which are set in
each specific view file. Don't forget that constants can't longer change their
value over time, unlike global variables.

By convention, all global variables must be written in capital letter and
separated by underscore - for example : Global Const $APP_EMAIL_CONTACT

@project        : ApplicationWithCheckForUpdates
@version        : v1.0.0
@author         : v20100v <v20100v@no-reply.com>
@AGS version    : v1.0.0
@AutoIt version : v3.3.14.5

#ce ----------------------------------------------------------------------------


#include-once


;-------------------------------------------------------------------------------
; Application helper alias
;-------------------------------------------------------------------------------
Global Const $APP_FOLDER_ROOT = @ScriptDir & "/../"
Global Const $APP_FOLDER_ASSETS = @ScriptDir & "/assets"


;-------------------------------------------------------------------------------
; Application parameters
;-------------------------------------------------------------------------------
Global Const $APP_PARAMETERS_INI = @ScriptDir & "/config/parameters.ini"
Local $fileExists = FileExists($APP_PARAMETERS_INI)
If Not $fileExists Then
	MsgBox(16, "Error with load parameters.ini", "Unable to find the file './config/parameters.ini'! " & @CRLF & "This application can not work, you must create this file. You wan use the file './config/parameters.ini.dist' to create it.")
EndIf


;-------------------------------------------------------------------------------
; Application main constants
;-------------------------------------------------------------------------------
Global Const $APP_NAME = "ApplicationWithCheckForUpdates"
Global Const $APP_VERSION = "0.9.0"
Global Const $APP_WEBSITE = "https://myApplication-website.org"
Global Const $APP_EMAIL_CONTACT = "myApplication@website.org"
Global Const $APP_ID = "v20100v.ApplicationWithCheckForUpdates"
Global Const $APP_LIFE_PERIOD = "2018-" & @YEAR
Global Const $APP_COPYRIGHT = "© " & $APP_LIFE_PERIOD & ", v20100v"


;-------------------------------------------------------------------------------
; Application GUI constants
;-------------------------------------------------------------------------------
Global Const $APP_WIDTH = 800
Global Const $APP_HEIGHT = 600
Global Const $APP_GUI_TITLE_COLOR = 0x85C4ED
Global Const $APP_GUI_LINK_COLOR = 0x5487FB


;-------------------------------------------------------------------------------
; AGS-compontents Check Updater constants
;-------------------------------------------------------------------------------
; Specifiy the repository JSON use to check for updates. This json file must persist in a remote server available via
; internet, and without restriction. If you use Github as a control version, you can use it to host this file. In this
; case use this bellow URL.
Global Const $APP_REMOTE_RELEASES_JSON = "https://raw.githubusercontent.com/autoit-gui-skeleton/AGS-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/RELEASES.json"

;-------------------------------------------------------------------------------
; Custom application global variable
;
; Here is an example to defined custom global variables
;-------------------------------------------------------------------------------
Global $OPEN_FILE = False
Global $OPEN_FILE_PATH = -1
Global $OPEN_FILE_NAME = -1
