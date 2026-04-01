#!/usr/bin/osascript
# Finder File Management Patterns
# Usage: osascript finder.applescript <action> [params]

-- ============================================
-- FOLDER OPERATIONS
-- ============================================

-- Create folder at path
on createFolder(folderPath, folderName)
    tell application "Finder"
        if not (exists folder (folderPath & folderName)) then
            make new folder at folder folderPath with properties {name:folderName}
        end if
    end tell
end tell

-- Create folder on desktop
on createFolderOnDesktop(folderName)
    tell application "Finder"
        make new folder at desktop with properties {name:folderName}
    end tell
end tell

-- Open folder in new window
on openFolder(folderPath)
    tell application "Finder"
        open folder folderPath
    end tell
end tell

-- ============================================
-- FILE OPERATIONS
-- ============================================

-- List files in folder
on listFiles(folderPath)
    tell application "Finder"
        set fileList to name of every file of folder folderPath
        return fileList
    end tell
end tell

-- List subfolders
on listFolders(folderPath)
    tell application "Finder"
        set folderList to name of every folder of folder folderPath
        return folderList
    end tell
end tell

-- Move file
on moveFile(filePath, destinationPath)
    tell application "Finder"
        move file filePath to folder destinationPath
    end tell
end tell

-- Copy file
on copyFile(filePath, destinationPath)
    tell application "Finder"
        duplicate file filePath to folder destinationPath
    end tell
end tell

-- Delete file (move to trash)
on deleteFile(filePath)
    tell application "Finder"
        delete file filePath
    end tell
end tell

-- Get file info
on getFileInfo(filePath)
    tell application "Finder"
        set theFile to file filePath
        return {name:name of theFile, size:size of theFile, kind:kind of theFile, modificationDate:modification date of theFile}
    end tell
end tell

-- ============================================
-- DESKTOP OPERATIONS
-- ============================================

-- Get desktop path
on getDesktopPath()
    tell application "Finder"
        return path to desktop folder as string
    end tell
end tell

-- List desktop items
on listDesktop()
    tell application "Finder"
        return name of every item of desktop
    end tell
end tell

-- ============================================
-- UTILITY
-- ============================================

-- Convert POSIX path to AppleScript path
on posixToMacPath(posixPath)
    set macPath to POSIX file posixPath as alias
    return macPath as string
end tell

-- Convert AppleScript path to POSIX path
on macToPosixPath(macPath)
    return POSIX path of (macPath as alias)
end tell

-- ============================================
-- EXAMPLES
-- ============================================

-- Example: Create "Downloads" backup folder
-- createFolder((path to downloads folder as string), "Backup")

-- Example: List all PDFs on desktop
-- set items to listDesktop()
-- repeat with item in items
--     if item ends with ".pdf" then log item
-- end repeat

-- Example: Move all downloads to archive
-- set downloads to path to downloads folder as string
-- set archive to (path to documents folder as string) & "Archive:"
-- moveFile(downloads & "file.pdf", archive)
