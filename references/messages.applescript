#!/usr/bin/osascript
# Messages (iMessage) Automation Patterns
# Usage: osascript messages.applescript <action> [params]

-- ============================================
-- MESSAGING
-- ============================================

-- Send message to contact (by email or phone)
on sendMessage(theMessage, theRecipient)
    tell application "Messages"
        set theBuddy to buddy theRecipient of (service 1 whose service type is iMessage)
        send theMessage to theBuddy
    end tell
end tell

-- Send message to multiple recipients
on sendGroupMessage(theMessage, recipientList)
    tell application "Messages"
        set theChat to chat with recipients recipientList
        send theMessage to theChat
    end tell
end tell

-- ============================================
-- CHAT MANAGEMENT
-- ============================================

-- Open chat with contact
on openChat(theRecipient)
    tell application "Messages"
        set theBuddy to buddy theRecipient of (service 1 whose service type is iMessage)
        chat with theBuddy
    end tell
end tell

-- Get recent chats
on getRecentChats()
    tell application "Messages"
        set chatList to chats
        return chatList
    end tell
end tell

-- ============================================
-- CONTACT INFO
-- ============================================

-- Get buddy status
on getBuddyStatus(theRecipient)
    tell application "Messages"
        set theBuddy to buddy theRecipient of (service 1 whose service type is iMessage)
        return presence status of theBuddy
    end tell
end tell

-- Check if contact is available
on isContactAvailable(theRecipient)
    try
        set status to getBuddyStatus(theRecipient)
        return status is available
    on error
        return false
    end try
end tell

-- ============================================
-- MESSAGE HISTORY
-- ============================================

-- Get last message from chat
on getLastMessage(theRecipient)
    tell application "Messages"
        set theChat to chat with buddy theRecipient of (service 1 whose service type is iMessage)
        set messageList to every message of theChat
        if (count messageList) > 0 then
            return content of last item of messageList
        else
            return ""
        end if
    end tell
end tell

-- ============================================
-- UTILITY
-- ============================================

-- Check if Messages is running
on checkMessages()
    tell application "System Events"
        return (name of processes) contains "Messages"
    end tell
end tell

-- Open Messages app
on openMessages()
    tell application "Messages"
        activate
    end tell
end tell

-- Quit Messages
on quitMessages()
    tell application "Messages" to quit
end tell

-- ============================================
-- EXAMPLES
-- ============================================

-- Example: Send message to contact
-- sendMessage("Hello! Are you free for a call?", "contact@example.com")

-- Example: Send to multiple people
-- sendGroupMessage("Meeting in 5 minutes", {"person1@example.com", "person2@example.com"})

-- Example: Check if someone is available before messaging
-- if isContactAvailable("contact@example.com") then
--     sendMessage("Quick question!", "contact@example.com")
-- end if

-- Example: Send message only if not already sent
-- set lastMsg to getLastMessage("contact@example.com")
-- if lastMsg does not contain "Hello" then
--     sendMessage("Hello!", "contact@example.com")
-- end if
