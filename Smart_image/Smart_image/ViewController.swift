//
//  ViewController.swift
//  Smart_image
//
//  Created by Yifan Xu on 9/23/16.
//  Copyright © 2016 Yifan Xu. All rights reserved.
//

import Cocoa

class ViewController: NSViewController
{

    @IBOutlet weak var blemish: NSButton!
    @IBOutlet weak var DestinationDirectory: NSTextField!
    @IBOutlet weak var SourceDirectory: NSTextField!
    @IBOutlet weak var Brightness: NSTextField!
    var isEditing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func chooseSource(sender: NSButton)
    {
        let dialog = NSOpenPanel();
        dialog.title                   = "Choose source directory";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.URL // Pathname of the file
            
            if (result != nil) {
                let path = result!.path!
                if (sender.title == "Change photo source"){
                    SourceDirectory.stringValue = path
                }else{
                    DestinationDirectory.stringValue = path
                }
                
            }
        } else {
            // User clicked on "Cancel"
            return
        }
        
    }
    @IBAction func process(sender: AnyObject)
    {
        assert(!self.isEditing, "Already editing")
        var argg = ""
        if blemish.state == 0
        {
            argg = "no"
        }
        else
        {
            argg = "yes"
        }
        /*
        let fileManager = NSFileManager.defaultManager()
        var path = fileManager.currentDirectoryPath
        path += "/photo_editor.py "
        var arguments = [String]()
        arguments.append("photo_editor.py ")
        arguments.append("-s ")
        arguments.append(SourceDirectory.stringValue)
        arguments.append("-d ")
        arguments.append(DestinationDirectory.stringValue)
        arguments.append("-f ")
        arguments.append(Brightness.stringValue)
        arguments.append("-g ")
        arguments.append(argg)
        let task = NSTask()
        task.launchPath = "python"
        task.arguments = arguments
        task.launch()
        task.waitUntilExit()*/
        var command = "/Library/Frameworks/Python.framework/Versions/2.7/bin/python "
        command += "/Users/YifanXu/Dropbox/programming/image-processor/photo_editor.py -s "
        command += SourceDirectory.stringValue
        command += " -d "
        command += DestinationDirectory.stringValue
        command += " -f "
        command += Brightness.stringValue
        command += " -g "
        command += argg
        print(command)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            self.isEditing = true
            system(command)
        }
        
    }
    @IBAction func stop_editing(sender: AnyObject)
    {
    }
    override var representedObject: AnyObject?
    {
        didSet
        {
        // Update the view, if already loaded.
        }
    }


}

