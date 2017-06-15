//
//  FileManager.swift
//  Keiyo
//
//  Created by OminextMobile on 1/4/17.
//  Copyright © 2017 Ominext. All rights reserved.
//

import Foundation
import UIKit

public class File: NSObject {
    
    public static let fileManager = FileManager.default
    
    public static var documentsDirectory: AnyObject {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first as AnyObject
    }
    
    static var imageDirectory: String {
        return getDirectory(fromDirectory: documentsDirectory, path: "images")!
    }
    
    /// Get directory from a directory and path
    public static func getDirectory(fromDirectory directory: AnyObject, path: String) -> String? {
        let fullPath: String = directory.appendingPathComponent(path) as String
        return getDirectory(fromFullPath: fullPath)
    }
    
    /// Get directory from full path
    public static func getDirectory(fromFullPath fullPath: String) -> String? {
        var fullPathReturn: String?
        if fileManager.fileExists(atPath: fullPath) {
            fullPathReturn = fullPath
        } else {
            do {
                try fileManager.createDirectory(atPath: fullPath, withIntermediateDirectories: false, attributes: nil)
                fullPathReturn = fullPath
            } catch let error {
                print(error.localizedDescription)
            }
        }
        //print(fullPathReturn)
        return fullPathReturn
    }
    
    /**
     Auto create directory if need
     */
    public static func getContentsOfRirectiryAttFullPath(path: String) -> [String]? {
        if let checkedPath = getDirectory(fromFullPath: path) {
            do {
                return try fileManager.contentsOfDirectory(atPath: checkedPath)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    /// Delete file
    public static func deleteFileAddFullPath(path: String) -> Bool {
        if let checkedPath = getDirectory(fromFullPath: path) {
            do {
                try fileManager.removeItem(atPath: checkedPath)
                return true
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return false
    }
    
    static func testSaveImage(image: UIImage?) -> String? {
        if let image = image {
            // Test create file for image
            if let data = UIImagePNGRepresentation(image) {
                let dateF = DateFormatter()
                dateF.dateFormat = "YYYYMMDDHHMMSSFFF"
                let file = dateF.string(from: Date()) + ".png"
                let fileURL = (File.documentsDirectory as? String ?? "") + "/" + file
                do {
                    if (try? data.write(to: URL(fileURLWithPath: fileURL), options: [.atomic])) != nil {
                        print(fileURL)
                        return file
                    } else {
                        print("error saving file")
                    }
                } catch let err {
                    print(err)
                }
            }
        }
        
        return nil
    }
    
}
