Return-Path: <stable+bounces-43720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC4B8C441C
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321821F229FB
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F135240;
	Mon, 13 May 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dGU9LnxA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A3224D0
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613876; cv=none; b=EI5iXg/X3TRNlcLC1EAez91oz+OdzYFllepG6flj43lalQli2HDzErOd2YQntF212I5VwS97o/Rli9OHERHHzADqeFHKVzCINgSPDqcmwwCZtIT3ZKMjUzkJtBHell9PDukBSCqQlHfICSMdINTSw9ULAWxXhpYVqsAoV0ShdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613876; c=relaxed/simple;
	bh=Q9M9Hy5fB12smomV0aLiLHry2X8Djf0g8YqViBMzLME=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ARaJvWvS6gTW6QPaBlKBTNARvKvPqAnFO+FGWRYtt5WqzK6W6h4x+e75PLK5736AnbzIKLT+JxovJiVs3D3qpj03Cu2RT2DGzpcmbrdd9ylTwF+zLT7BZhpqc65/WITyyskR09V7YWERWaXvdDQdIAg4IoOrS31Q/yXDncaMS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dGU9LnxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB37C113CC;
	Mon, 13 May 2024 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613875;
	bh=Q9M9Hy5fB12smomV0aLiLHry2X8Djf0g8YqViBMzLME=;
	h=Subject:To:Cc:From:Date:From;
	b=dGU9LnxAE/zHf3O+kJqDoPNoW78d4aZoWXCBjAyhZEWequqU6XYdVNBIToxELj8to
	 1HMBV8dshgWE4wrBn11fVmzfs5ghM/jf6X2KQBECh2Twday7FE0F1m8td5s2qevU7g
	 +6zLCuensKlLutV1C8EyeCwrHYjey58YI2j+pSsE=
Subject: FAILED: patch "[PATCH] eventfs/tracing: Add callback for release of an eventfs_inode" failed to apply to 6.8-stable tree
To: rostedt@goodmis.org,Tze-nan.Wu@mediatek.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:24:25 +0200
Message-ID: <2024051325-ranting-skydiver-968e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x b63db58e2fa5d6963db9c45df88e60060f0ff35f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051325-ranting-skydiver-968e@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

b63db58e2fa5 ("eventfs/tracing: Add callback for release of an eventfs_inode")
c3137ab6318d ("eventfs: Create eventfs_root_inode to store dentry")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b63db58e2fa5d6963db9c45df88e60060f0ff35f Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Thu, 2 May 2024 09:03:15 -0400
Subject: [PATCH] eventfs/tracing: Add callback for release of an eventfs_inode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Synthetic events create and destroy tracefs files when they are created
and removed. The tracing subsystem has its own file descriptor
representing the state of the events attached to the tracefs files.
There's a race between the eventfs files and this file descriptor of the
tracing system where the following can cause an issue:

With two scripts 'A' and 'B' doing:

  Script 'A':
    echo "hello int aaa" > /sys/kernel/tracing/synthetic_events
    while :
    do
      echo 0 > /sys/kernel/tracing/events/synthetic/hello/enable
    done

  Script 'B':
    echo > /sys/kernel/tracing/synthetic_events

Script 'A' creates a synthetic event "hello" and then just writes zero
into its enable file.

Script 'B' removes all synthetic events (including the newly created
"hello" event).

What happens is that the opening of the "enable" file has:

 {
	struct trace_event_file *file = inode->i_private;
	int ret;

	ret = tracing_check_open_get_tr(file->tr);
 [..]

But deleting the events frees the "file" descriptor, and a "use after
free" happens with the dereference at "file->tr".

The file descriptor does have a reference counter, but there needs to be a
way to decrement it from the eventfs when the eventfs_inode is removed
that represents this file descriptor.

Add an optional "release" callback to the eventfs_entry array structure,
that gets called when the eventfs file is about to be removed. This allows
for the creating on the eventfs file to increment the tracing file
descriptor ref counter. When the eventfs file is deleted, it can call the
release function that will call the put function for the tracing file
descriptor.

This will protect the tracing file from being freed while a eventfs file
that references it is being opened.

Link: https://lore.kernel.org/linux-trace-kernel/20240426073410.17154-1-Tze-nan.Wu@mediatek.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240502090315.448cba46@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Tze-nan wu <Tze-nan.Wu@mediatek.com>
Tested-by: Tze-nan Wu (吳澤南) <Tze-nan.Wu@mediatek.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 894c6ca1e500..f5510e26f0f6 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -84,10 +84,17 @@ enum {
 static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
+	const struct eventfs_entry *entry;
 	struct eventfs_root_inode *rei;
 
 	WARN_ON_ONCE(!ei->is_freed);
 
+	for (int i = 0; i < ei->nr_entries; i++) {
+		entry = &ei->entries[i];
+		if (entry->release)
+			entry->release(entry->name, ei->data);
+	}
+
 	kfree(ei->entry_attrs);
 	kfree_const(ei->name);
 	if (ei->is_events) {
@@ -112,6 +119,18 @@ static inline void free_ei(struct eventfs_inode *ei)
 	}
 }
 
+/*
+ * Called when creation of an ei fails, do not call release() functions.
+ */
+static inline void cleanup_ei(struct eventfs_inode *ei)
+{
+	if (ei) {
+		/* Set nr_entries to 0 to prevent release() function being called */
+		ei->nr_entries = 0;
+		free_ei(ei);
+	}
+}
+
 static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
 {
 	if (ei)
@@ -734,7 +753,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-		free_ei(ei);
+		cleanup_ei(ei);
 		ei = NULL;
 	}
 	return ei;
@@ -835,7 +854,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ei;
 
  fail:
-	free_ei(ei);
+	cleanup_ei(ei);
 	tracefs_failed_creating(dentry);
 	return ERR_PTR(-ENOMEM);
 }
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 7a5fe17b6bf9..d03f74658716 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -62,6 +62,8 @@ struct eventfs_file;
 typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
 				const struct file_operations **fops);
 
+typedef void (*eventfs_release)(const char *name, void *data);
+
 /**
  * struct eventfs_entry - dynamically created eventfs file call back handler
  * @name:	Then name of the dynamic file in an eventfs directory
@@ -72,6 +74,7 @@ typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
 struct eventfs_entry {
 	const char			*name;
 	eventfs_callback		callback;
+	eventfs_release			release;
 };
 
 struct eventfs_inode;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 52f75c36bbca..6ef29eba90ce 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2552,6 +2552,14 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	return 0;
 }
 
+/* The file is incremented on creation and freeing the enable file decrements it */
+static void event_release(const char *name, void *data)
+{
+	struct trace_event_file *file = data;
+
+	event_file_put(file);
+}
+
 static int
 event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 {
@@ -2566,6 +2574,7 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		{
 			.name		= "enable",
 			.callback	= event_callback,
+			.release	= event_release,
 		},
 		{
 			.name		= "filter",
@@ -2634,6 +2643,9 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		return ret;
 	}
 
+	/* Gets decremented on freeing of the "enable" file */
+	event_file_get(file);
+
 	return 0;
 }
 


