Return-Path: <stable+bounces-43721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37498C441D
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CC9282225
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E8481B4;
	Mon, 13 May 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z/oVv6ka"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED7224D0
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613878; cv=none; b=ascAvPXkya91rQZCjRzb/ptSCZYoaanQIQAwdMVmXNu9GRe99vRozfqNokL2chkBzBpZ0yocqQmf+X6dFFVzf0gTlFvHO+AspYbtGoWDHAVaIOPI0fCvjYRY12ydrYz1v3teA9fdscej4zlt4zDNC0s2A9Ud/LBtKcV0bVxUvYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613878; c=relaxed/simple;
	bh=darcLtfh8gWAcYo8v5GmBUm/YyjKb/9Ydabru2kuuZM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XECKpqm+dcjSuZPcDpKGgw9xh44vQMtDHfvJdDdPrgJtb0EYcjmyOLmzCy9gcZJ9Iwj2iiXdNxkg75TLy5hXJKuoXRz+PSyL+IfZ9ebNQSm9D1s+1+MtoWSMtQuQ7WVz+0GxFA6N/6+wiGgdNlfKvDstfTEiGV3h18fsnrWcM9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z/oVv6ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346DBC32782;
	Mon, 13 May 2024 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613878;
	bh=darcLtfh8gWAcYo8v5GmBUm/YyjKb/9Ydabru2kuuZM=;
	h=Subject:To:Cc:From:Date:From;
	b=Z/oVv6kaezPnIDZdq0KIOqr2UDcl4WhS56f5JJDYS0mkZ0Fy+5G8Bl1UXJ0EQ12mY
	 owHNqezaVujtNycDoG8Pu8pDrHbThjw1hem5G92qtPuvw77mWLI7EFQQYJAbT2K+97
	 w5XYKGfme1gkLEPQD92pr/GeGcY3q7ddiLKEdP3M=
Subject: FAILED: patch "[PATCH] eventfs: Have "events" directory get permissions from its" failed to apply to 6.6-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:24:29 +0200
Message-ID: <2024051329-cringing-recast-3368@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d57cf30c4c07837799edec949102b0adf58bae79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051329-cringing-recast-3368@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d57cf30c4c07 ("eventfs: Have "events" directory get permissions from its parent")
d53891d348ac ("eventfs: Do not differentiate the toplevel events directory")
c3137ab6318d ("eventfs: Create eventfs_root_inode to store dentry")
264424dfdd5c ("eventfs: Restructure eventfs_inode structure to be more condensed")
5a49f996046b ("eventfs: Warn if an eventfs_inode is freed without is_freed being set")
43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
408600be78cd ("eventfs: Remove unused d_parent pointer field")
49304c2b93e4 ("tracefs: dentry lookup crapectomy")
99c001cb617d ("tracefs: Avoid using the ei->dentry pointer unnecessarily")
4fa4b010b83f ("eventfs: Initialize the tracefs inode properly")
29142dc92c37 ("tracefs: remove stale 'update_gid' code")
834bf76add3e ("eventfs: Save directory inodes in the eventfs_inode structure")
1057066009c4 ("eventfs: Use kcalloc() instead of kzalloc()")
852e46e239ee ("eventfs: Do not create dentries nor inodes in iterate_shared")
53c41052ba31 ("eventfs: Have the inodes all for files and directories all be the same")
1de94b52d5e8 ("eventfs: Shortcut eventfs_iterate() by skipping entries already read")
704f960dbee2 ("eventfs: Read ei->entries before ei->children in eventfs_iterate()")
1e4624eb5a0e ("eventfs: Do ctx->pos update for all iterations in eventfs_iterate()")
e109deadb733 ("eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is set")
8186fff7ab64 ("tracefs/eventfs: Use root and instance inodes as default ownership")

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
 


