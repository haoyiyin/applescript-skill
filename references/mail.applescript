#!/usr/bin/osascript
# Mail App Automation Patterns
# Usage: osascript mail.applescript <action> [params]

-- ============================================
-- SENDING EMAIL
-- ============================================

-- Send simple email
on sendEmail(subjectLine, theContent, theRecipient)
    tell application "Mail"
        set newMessage to make new outgoing message with properties {subject:subjectLine, content:theContent}
        tell newMessage
            make new to recipient at end of to recipients with properties {address:theRecipient}
        end tell
        send newMessage
    end tell
end tell

-- Send email with multiple recipients
on sendEmailToMultiple(subjectLine, theContent, recipientList)
    tell application "Mail"
        set newMessage to make new outgoing message with properties {subject:subjectLine, content:theContent}
        tell newMessage
            repeat with recipientAddr in recipientList
                make new to recipient at end of to recipients with properties {address:recipientAddr}
            end repeat
        end tell
        send newMessage
    end tell
end tell

-- Send email with attachment
on sendEmailWithAttachment(subjectLine, theContent, theRecipient, attachmentPath)
    tell application "Mail"
        set newMessage to make new outgoing message with properties {subject:subjectLine, content:theContent}
        tell newMessage
            make new to recipient at end of to recipients with properties {address:theRecipient}
            make new attachment with properties {file name:attachmentPath} at after the last paragraph
        end tell
        send newMessage
    end tell
end tell

-- Send HTML email
on sendHTMLEmail(subjectLine, htmlContent, theRecipient)
    tell application "Mail"
        set newMessage to make new outgoing message with properties {subject:subjectLine}
        tell newMessage
            set content to htmlContent
            make new to recipient at end of to recipients with properties {address:theRecipient}
        end tell
        send newMessage
    end tell
end tell

-- ============================================
-- INBOX MANAGEMENT
-- ============================================

-- Get unread count
on getUnreadCount()
    tell application "Mail"
        return unread count of inbox
    end tell
end tell

-- Get unread messages
on getUnreadMessages()
    tell application "Mail"
        set unreadList to every message of inbox whose read status is false
        return unreadList
    end tell
end tell

-- Get unread message details
on getUnreadMessageDetails()
    tell application "Mail"
        set unreadList to every message of inbox whose read status is false
        set details to {}
        repeat with msg in unreadList
            set end of details to {subject:subject of msg, sender:sender of msg, dateReceived:date received of msg}
        end repeat
        return details
    end tell
end tell

-- Mark message as read
on markAsRead(theMessage)
    tell application "Mail"
        set read status of theMessage to true
    end tell
end tell

-- Mark all inbox as read
on markAllAsRead()
    tell application "Mail"
        set read status of every message of inbox to true
    end tell
end tell

-- ============================================
-- SEARCH & FILTER
-- ============================================

-- Find messages by subject
on findMessagesBySubject(searchTerm)
    tell application "Mail"
        set foundMessages to every message of inbox whose subject contains searchTerm
        return foundMessages
    end tell
end tell

-- Find messages from sender
on findMessagesFromSender(senderEmail)
    tell application "Mail"
        set foundMessages to every message of inbox whose sender contains senderEmail
        return foundMessages
    end tell
end tell

-- Find messages with attachments
on findMessagesWithAttachments()
    tell application "Mail"
        set foundMessages to every message of inbox whose attachment count > 0
        return foundMessages
    end tell
end tell

-- ============================================
-- DRAFTS
-- ============================================

-- Create draft (don't send)
on createDraft(subjectLine, theContent, theRecipient)
    tell application "Mail"
        set draftMessage to make new outgoing message with properties {subject:subjectLine, content:theContent, visible:false}
        tell draftMessage
            make new to recipient at end of to recipients with properties {address:theRecipient}
        end tell
        -- Don't send, just save as draft
    end tell
end tell

-- ============================================
-- UTILITY
-- ============================================

-- Check if Mail is running
on checkMail()
    tell application "System Events"
        return (name of processes) contains "Mail"
    end tell
end tell

-- Open Mail app
on openMail()
    tell application "Mail"
        activate
    end tell
end tell

-- Get account info
on getAccountInfo()
    tell application "Mail"
        set accounts to every account
        set info to {}
        repeat with acc in accounts
            set end of info to {name:name of acc, email:email address of acc}
        end repeat
        return info
    end tell
end tell

-- ============================================
-- EXAMPLES
-- ============================================

-- Example: Send meeting reminder
-- sendEmail("Meeting Reminder", "Hi, just reminding you about our meeting at 3pm today.", "colleague@example.com")

-- Example: Send report with attachment
-- sendEmailWithAttachment("Weekly Report", "Please find attached the weekly report.", "boss@example.com", "/Users/jax/Documents/weekly-report.pdf")

-- Example: Check unread and notify
-- set count to getUnreadCount()
-- if count > 10 then
--     display notification "You have " & count & " unread emails!"
-- end if

-- Example: Find all emails from specific sender
-- set messages to findMessagesFromSender("newsletter@example.com")
-- repeat with msg in messages
--     markAsRead(msg)
-- end repeat
