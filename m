Return-Path: <stable+bounces-43722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435A8C441E
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAF71F224A7
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1D81DA20;
	Mon, 13 May 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="usbDDF9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9E5240
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613882; cv=none; b=tXIG2IqgF6bWrk8HnsLKwU/cbRn8j6t4dW48OoG8cQFYch2qtzLaG/9u64+T7+VQ2g+R1bF5hd+IZHx7X6FyTSxaGJVGtwSKRcJN4bYIgWVMbqEYhpcfbbvvCL6JDGblu6KqA6P3KbkzK2v+uBXByPgBxmx1CBaYqTQM6/Cy8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613882; c=relaxed/simple;
	bh=h2iJpObsQs3T74xMyRPTFmrNKvp5JTw5AduUgWE4NAY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wpg0p3OXJqRiWBGtC5xh06+deRM/tJWMdOCUh3AkiA7j7DupI4a7A/clSQ6tx7Sq2mKey10glYIuVw/DHNhlMpKV5nXhOpghPNK0i7cNXXdGTpIecczYGgmsojf91jzd+E8QKDV3Ek0i80zuAcDFtk77nPVMUSVFB+MJnDXRoQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=usbDDF9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8932CC113CC;
	Mon, 13 May 2024 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613881;
	bh=h2iJpObsQs3T74xMyRPTFmrNKvp5JTw5AduUgWE4NAY=;
	h=Subject:To:Cc:From:Date:From;
	b=usbDDF9HI0Td2oDD6jkZPoEX6Zz6fEByuCREPMca13wrd71Cos5R0ZFE6Iympyvml
	 ksazeVwvoWbmbCtnAh9NNXh3zcjVlEJImWdG+41KHOyge1FXzV4nyt4vRvod19sDwp
	 LIRdk2e5liTR/Iv8646eSjnE75ltG3zt7Hhe0RGg=
Subject: FAILED: patch "[PATCH] eventfs: Have "events" directory get permissions from its" failed to apply to 6.8-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:24:31 +0200
Message-ID: <2024051331-sediment-viewable-33bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x d57cf30c4c07837799edec949102b0adf58bae79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051331-sediment-viewable-33bc@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

d57cf30c4c07 ("eventfs: Have "events" directory get permissions from its parent")
d53891d348ac ("eventfs: Do not differentiate the toplevel events directory")
c3137ab6318d ("eventfs: Create eventfs_root_inode to store dentry")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d57cf30c4c07837799edec949102b0adf58bae79 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Thu, 2 May 2024 16:08:27 -0400
Subject: [PATCH] eventfs: Have "events" directory get permissions from its
 parent

The events directory gets its permissions from the root inode. But this
can cause an inconsistency if the instances directory changes its
permissions, as the permissions of the created directories under it should
inherit the permissions of the instances directory when directories under
it are created.

Currently the behavior is:

 # cd /sys/kernel/tracing
 # chgrp 1002 instances
 # mkdir instances/foo
 # ls -l instances/foo
[..]
 -r--r-----  1 root lkp  0 May  1 18:55 buffer_total_size_kb
 -rw-r-----  1 root lkp  0 May  1 18:55 current_tracer
 -rw-r-----  1 root lkp  0 May  1 18:55 error_log
 drwxr-xr-x  1 root root 0 May  1 18:55 events
 --w-------  1 root lkp  0 May  1 18:55 free_buffer
 drwxr-x---  2 root lkp  0 May  1 18:55 options
 drwxr-x--- 10 root lkp  0 May  1 18:55 per_cpu
 -rw-r-----  1 root lkp  0 May  1 18:55 set_event

All the files and directories under "foo" has the "lkp" group except the
"events" directory. That's because its getting its default value from the
mount point instead of its parent.

Have the "events" directory make its default value based on its parent's
permissions. That now gives:

 # ls -l instances/foo
[..]
 -rw-r-----  1 root lkp 0 May  1 21:16 buffer_subbuf_size_kb
 -r--r-----  1 root lkp 0 May  1 21:16 buffer_total_size_kb
 -rw-r-----  1 root lkp 0 May  1 21:16 current_tracer
 -rw-r-----  1 root lkp 0 May  1 21:16 error_log
 drwxr-xr-x  1 root lkp 0 May  1 21:16 events
 --w-------  1 root lkp 0 May  1 21:16 free_buffer
 drwxr-x---  2 root lkp 0 May  1 21:16 options
 drwxr-x--- 10 root lkp 0 May  1 21:16 per_cpu
 -rw-r-----  1 root lkp 0 May  1 21:16 set_event

Link: https://lore.kernel.org/linux-trace-kernel/20240502200906.161887248@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 8186fff7ab649 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6e08405892ae..a878cea70f4c 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -37,6 +37,7 @@ static DEFINE_MUTEX(eventfs_mutex);
 
 struct eventfs_root_inode {
 	struct eventfs_inode		ei;
+	struct inode			*parent_inode;
 	struct dentry			*events_dir;
 };
 
@@ -226,12 +227,23 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 static void update_events_attr(struct eventfs_inode *ei, struct super_block *sb)
 {
-	struct inode *root;
+	struct eventfs_root_inode *rei;
+	struct inode *parent;
 
-	/* Get the tracefs root inode. */
-	root = d_inode(sb->s_root);
-	ei->attr.uid = root->i_uid;
-	ei->attr.gid = root->i_gid;
+	rei = get_root_inode(ei);
+
+	/* Use the parent inode permissions unless root set its permissions */
+	parent = rei->parent_inode;
+
+	if (rei->ei.attr.mode & EVENTFS_SAVE_UID)
+		ei->attr.uid = rei->ei.attr.uid;
+	else
+		ei->attr.uid = parent->i_uid;
+
+	if (rei->ei.attr.mode & EVENTFS_SAVE_GID)
+		ei->attr.gid = rei->ei.attr.gid;
+	else
+		ei->attr.gid = parent->i_gid;
 }
 
 static void set_top_events_ownership(struct inode *inode)
@@ -817,6 +829,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	// Note: we have a ref to the dentry from tracefs_start_creating()
 	rei = get_root_inode(ei);
 	rei->events_dir = dentry;
+	rei->parent_inode = d_inode(dentry->d_sb->s_root);
 
 	ei->entries = entries;
 	ei->nr_entries = size;
@@ -826,10 +839,15 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	uid = d_inode(dentry->d_parent)->i_uid;
 	gid = d_inode(dentry->d_parent)->i_gid;
 
-	/* This is used as the default ownership of the files and directories */
 	ei->attr.uid = uid;
 	ei->attr.gid = gid;
 
+	/*
+	 * When the "events" directory is created, it takes on the
+	 * permissions of its parent. But can be reset on remount.
+	 */
+	ei->attr.mode |= EVENTFS_SAVE_UID | EVENTFS_SAVE_GID;
+
 	INIT_LIST_HEAD(&ei->children);
 	INIT_LIST_HEAD(&ei->list);
 


