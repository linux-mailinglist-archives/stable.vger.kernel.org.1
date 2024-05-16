Return-Path: <stable+bounces-45277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AB08C75B5
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C959828479A
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC2145B0B;
	Thu, 16 May 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zfqTc7C8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CF145A06
	for <stable@vger.kernel.org>; Thu, 16 May 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861492; cv=none; b=FD6fdxqAcnfPQByedzGw2lzFrceBUD+TUdUZaSTFtXv/UBQLz+YP/lrhl6ApPfN5aSiaL0VmUBl/G+whlYzum7Mtuh3UpHXJnkVMq5W+bTZ+jbc2qci1sqRGtHk1TfFAitxdUG43WT4cTgkKZdoiGJYbUKeS2GPcscoqwxsRSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861492; c=relaxed/simple;
	bh=xLuLaVR52DVHDEZx+9Hx2WqEuyxk3LFardQlJlgFiMU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PKHAGhl6uValvEDVLtmo/cpnGKKmty06Giz1P4XtRYxUgT5hy+X2b9mC8jyMdtJe84NnbdbwkPdePi/F+cLRonXUEIQEjfjoMLIS8vIs/j45Rwf9b4iuNLzzvoMBfgfsVZv9OZq1ULEYc26Mw3mRwHKB1pdsj+Kw+VfWbdbdpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zfqTc7C8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77F6C2BD11;
	Thu, 16 May 2024 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715861491;
	bh=xLuLaVR52DVHDEZx+9Hx2WqEuyxk3LFardQlJlgFiMU=;
	h=Subject:To:Cc:From:Date:From;
	b=zfqTc7C8L87G67dgoFIYkCX0ft8cIyxG4KRz6wBiwnHMqZjdxEQ4t5LfB4ncFXUSa
	 ZyiCVopP8D0qUcwLZOGT9kKWQAELkNbN64zHgsSTlBC4NfykM8UoQ5rJEQmp8NL3bj
	 h8mc1fGAdpWvkcNAMhATvL9eY5qN6oxw0iitVpoM=
Subject: FAILED: patch "[PATCH] eventfs: Do not differentiate the toplevel events directory" failed to apply to 6.6-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 May 2024 14:11:28 +0200
Message-ID: <2024051627-armoire-sleep-3906@gregkh>
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
git cherry-pick -x d53891d348ac3eceaf48f4732a1f4f5c0e0a55ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051627-armoire-sleep-3906@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d53891d348ac ("eventfs: Do not differentiate the toplevel events directory")
99c001cb617d ("tracefs: Avoid using the ei->dentry pointer unnecessarily")
8186fff7ab64 ("tracefs/eventfs: Use root and instance inodes as default ownership")
ad579864637a ("tracefs: Check for dentry->d_inode exists in set_gid()")
7e8358edf503 ("eventfs: Fix file and directory uid and gid ownership")
0dfc852b6fe3 ("eventfs: Have event files and directories default to parent uid and gid")
28e12c09f5aa ("eventfs: Save ownership and mode")
db3a397209b0 ("eventfs: Have a free_ei() that just frees the eventfs_inode")
f2f496370afc ("eventfs: Remove "is_freed" union with rcu head")
29e06c10702e ("eventfs: Fix typo in eventfs_inode union comment")
5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d53891d348ac3eceaf48f4732a1f4f5c0e0a55ce Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Thu, 2 May 2024 16:08:25 -0400
Subject: [PATCH] eventfs: Do not differentiate the toplevel events directory

The toplevel events directory is really no different than the events
directory of instances. Having the two be different caused
inconsistencies and made it harder to fix the permissions bugs.

Make all events directories act the same.

Link: https://lore.kernel.org/linux-trace-kernel/20240502200905.846448710@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 8186fff7ab649 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 15a2a9c3c62b..9dacf65c0b6e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -68,7 +68,6 @@ enum {
 	EVENTFS_SAVE_MODE	= BIT(16),
 	EVENTFS_SAVE_UID	= BIT(17),
 	EVENTFS_SAVE_GID	= BIT(18),
-	EVENTFS_TOPLEVEL	= BIT(19),
 };
 
 #define EVENTFS_MODE_MASK	(EVENTFS_SAVE_MODE - 1)
@@ -239,14 +238,10 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return ret;
 }
 
-static void update_top_events_attr(struct eventfs_inode *ei, struct super_block *sb)
+static void update_events_attr(struct eventfs_inode *ei, struct super_block *sb)
 {
 	struct inode *root;
 
-	/* Only update if the "events" was on the top level */
-	if (!ei || !(ei->attr.mode & EVENTFS_TOPLEVEL))
-		return;
-
 	/* Get the tracefs root inode. */
 	root = d_inode(sb->s_root);
 	ei->attr.uid = root->i_uid;
@@ -259,10 +254,10 @@ static void set_top_events_ownership(struct inode *inode)
 	struct eventfs_inode *ei = ti->private;
 
 	/* The top events directory doesn't get automatically updated */
-	if (!ei || !ei->is_events || !(ei->attr.mode & EVENTFS_TOPLEVEL))
+	if (!ei || !ei->is_events)
 		return;
 
-	update_top_events_attr(ei, inode->i_sb);
+	update_events_attr(ei, inode->i_sb);
 
 	if (!(ei->attr.mode & EVENTFS_SAVE_UID))
 		inode->i_uid = ei->attr.uid;
@@ -291,7 +286,7 @@ static int eventfs_permission(struct mnt_idmap *idmap,
 	return generic_permission(idmap, inode, mask);
 }
 
-static const struct inode_operations eventfs_root_dir_inode_operations = {
+static const struct inode_operations eventfs_dir_inode_operations = {
 	.lookup		= eventfs_root_lookup,
 	.setattr	= eventfs_set_attr,
 	.getattr	= eventfs_get_attr,
@@ -359,7 +354,7 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
 
-	update_top_events_attr(ei, dentry->d_sb);
+	update_events_attr(ei, dentry->d_sb);
 
 	return ei;
 }
@@ -465,7 +460,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	update_inode_attr(dentry, inode, &ei->attr,
 			  S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 
-	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_op = &eventfs_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
 	/* All directories will have the same inode number */
@@ -845,14 +840,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	uid = d_inode(dentry->d_parent)->i_uid;
 	gid = d_inode(dentry->d_parent)->i_gid;
 
-	/*
-	 * If the events directory is of the top instance, then parent
-	 * is NULL. Set the attr.mode to reflect this and its permissions will
-	 * default to the tracefs root dentry.
-	 */
-	if (!parent)
-		ei->attr.mode = EVENTFS_TOPLEVEL;
-
 	/* This is used as the default ownership of the files and directories */
 	ei->attr.uid = uid;
 	ei->attr.gid = gid;
@@ -861,13 +848,13 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	INIT_LIST_HEAD(&ei->list);
 
 	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
+	ti->flags |= TRACEFS_EVENT_INODE;
 	ti->private = ei;
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_op = &eventfs_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
 	dentry->d_fsdata = get_ei(ei);
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 29f0c999975b..f704d8348357 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -4,10 +4,9 @@
 
 enum {
 	TRACEFS_EVENT_INODE		= BIT(1),
-	TRACEFS_EVENT_TOP_INODE		= BIT(2),
-	TRACEFS_GID_PERM_SET		= BIT(3),
-	TRACEFS_UID_PERM_SET		= BIT(4),
-	TRACEFS_INSTANCE_INODE		= BIT(5),
+	TRACEFS_GID_PERM_SET		= BIT(2),
+	TRACEFS_UID_PERM_SET		= BIT(3),
+	TRACEFS_INSTANCE_INODE		= BIT(4),
 };
 
 struct tracefs_inode {


