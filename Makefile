include $(THEOS)/makefiles/common.mk

ADDITIONAL_CFLAGS = -fobjc-arc -Os -Qunused-arguments -Itemp -Wno-c++11-extensions -Xclang -fobjc-runtime-has-weak

TARGET_IPHONEOS_DEPLOYMENT_VERSION = 12.0
TWEAK_NAME = FlexTool

# find ./FLEX -name \*.m -print | grep Classes | rev | cut -d"/" -f1 | rev | sed -e "s/^/temp\//" | tr "\\n" " "
FlexTool_FILES = Tweak.xm temp/FLEXArrayExplorerViewController.m temp/FLEXObjectExplorerFactory.m temp/FLEXGlobalsTableViewControllerEntry.m temp/FLEXImageExplorerViewController.m temp/FLEXClassExplorerViewController.m temp/FLEXDictionaryExplorerViewController.m temp/FLEXDefaultsExplorerViewController.m temp/FLEXViewControllerExplorerViewController.m temp/FLEXSetExplorerViewController.m temp/FLEXLayerExplorerViewController.m temp/FLEXViewExplorerViewController.m temp/FLEXObjectExplorerViewController.m temp/FLEXNetworkTransaction.m temp/FLEXNetworkSettingsTableViewController.m temp/FLEXNetworkRecorder.m temp/FLEXNetworkTransactionTableViewCell.m temp/FLEXNetworkTransactionDetailTableViewController.m temp/FLEXNetworkHistoryTableViewController.m temp/FLEXNetworkObserver.m temp/FLEXToolbarItem.m temp/FLEXExplorerToolbar.m temp/FLEXManager.m temp/FLEXPropertyEditorViewController.m temp/FLEXDefaultEditorViewController.m temp/FLEXMethodCallingViewController.m temp/FLEXIvarEditorViewController.m temp/FLEXFieldEditorViewController.m temp/FLEXArgumentInputStringView.m temp/FLEXArgumentInputColorView.m temp/FLEXArgumentInputView.m temp/FLEXArgumentInputJSONObjectView.m temp/FLEXArgumentInputSwitchView.m temp/FLEXArgumentInputStructView.m temp/FLEXArgumentInputDateView.m temp/FLEXArgumentInputFontView.m temp/FLEXArgumentInputTextView.m temp/FLEXArgumentInputFontsPickerView.m temp/FLEXArgumentInputNumberView.m temp/FLEXArgumentInputViewFactory.m temp/FLEXArgumentInputNotSupportedView.m temp/FLEXFieldEditorView.m temp/FLEXExplorerViewController.m temp/FLEXWindow.m temp/FLEXFileBrowserSearchOperation.m temp/FLEXWebViewController.m temp/FLEXInstancesTableViewController.m temp/FLEXFileBrowserTableViewController.m temp/FLEXFileBrowserFileOperationController.m temp/FLEXSystemLogTableViewController.m temp/FLEXSystemLogMessage.m temp/FLEXSystemLogTableViewCell.m temp/FLEXTableLeftCell.m temp/FLEXTableContentViewController.m temp/FLEXTableListViewController.m temp/FLEXTableColumnHeader.m temp/FLEXMultiColumnTableView.m temp/FLEXTableContentCell.m temp/FLEXRealmDatabaseManager.m temp/FLEXSQLiteDatabaseManager.m temp/FLEXCookiesTableViewController.m temp/FLEXLibrariesTableViewController.m temp/FLEXGlobalsTableViewController.m temp/FLEXLiveObjectsTableViewController.m temp/FLEXClassesTableViewController.m temp/FLEXHierarchyTableViewCell.m temp/FLEXImagePreviewViewController.m temp/FLEXHierarchyTableViewController.m temp/FLEXUtility.m temp/FLEXHeapEnumerator.m temp/FLEXRuntimeUtility.m temp/FLEXKeyboardShortcutManager.m temp/FLEXKeyboardHelpViewController.m temp/FLEXResources.m temp/FLEXMultilineTableViewCell.m

FlexTool_FRAMEWORKS = UIKit CoreGraphics QuartzCore ImageIO
FlexTool_LDFLAGS = -lz -lsqlite3

BUNDLE_NAME = FlexToolBundle
FlexToolBundle_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries
include $(THEOS)/makefiles/bundle.mk
include $(THEOS)/makefiles/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

flatten_flex:
	cp "`find ./FLEX -name "*.m"`" ./temp/
	cp "`find ./FLEX -name "*.h"`" ./temp/