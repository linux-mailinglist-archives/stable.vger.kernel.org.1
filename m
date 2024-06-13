Return-Path: <stable+bounces-50496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C61E7906A7B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4322E1F23EFB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD4142649;
	Thu, 13 Jun 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OSMxhcF8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9A13D534
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276057; cv=none; b=m+y9FMUeY5snSQDiDC1e2UFSel9IG7BlUSALasdXJO0g06/4D548JDpNy6qFiTauDZ+oZFx+8+lIlJv4p8UQDnAhrFNYXW0T5EDOnxucnjBWTxqT4or3y4QqMGXbLrgWqGd5aTd91oxlxbULKXmvlXSdMNyiH6VcWqbBkQ2GvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276057; c=relaxed/simple;
	bh=UexZjPwS6bBrmwX6WaxnT2/DqA46LYoRF+RmM0THwok=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n3V+0+D91Gs5lX8v7vNjnSq+bDptDjs2pNNIc/mcamu6MK1Eut+j+TSOOLr3fUGEtTQVCcVhE5EEKHEtuFD7FLkHMfqN0iQjIFnnheyjaeAgvtKf5ccc92jck/mOfOxFjTydjjI8LhySvlt5tbnb3TEd42Ee51gujXUhn47pGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OSMxhcF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94F6C32786;
	Thu, 13 Jun 2024 10:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276057;
	bh=UexZjPwS6bBrmwX6WaxnT2/DqA46LYoRF+RmM0THwok=;
	h=Subject:To:Cc:From:Date:From;
	b=OSMxhcF8GJ9I1NN2Dgp8vgRNUx+5y43LX0buhrL6MGl2o3U6DUXEd06OIIA1vqJ+G
	 6r0JNTbAw5MekbRomn6uNIYMHCM8DBtGqzb7/f2JyynoztMCMLPGmwnLNE23ZABxbl
	 pYtBfDKtROAV9m1erjSpp8lRwwZvYQskCF5tdOZQ=
Subject: FAILED: patch "[PATCH] eventfs: Update all the eventfs_inodes from the events" failed to apply to 6.6-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,masahiroy@kernel.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 12:54:06 +0200
Message-ID: <2024061306-handed-oyster-2002@gregkh>
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
git cherry-pick -x 340f0c7067a95281ad13734f8225f49c6cf52067
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061306-handed-oyster-2002@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

340f0c7067a9 ("eventfs: Update all the eventfs_inodes from the events descriptor")
27c046484382 ("tracefs: Update inode permissions on remount")
baa23a8d4360 ("tracefs: Reset permissions on remount if permissions are options")
8dce06e98c70 ("eventfs: Clean up dentry ops and add revalidate function")
49304c2b93e4 ("tracefs: dentry lookup crapectomy")
4fa4b010b83f ("eventfs: Initialize the tracefs inode properly")
d81786f53aec ("tracefs: Zero out the tracefs_inode when allocating it")
29142dc92c37 ("tracefs: remove stale 'update_gid' code")
8186fff7ab64 ("tracefs/eventfs: Use root and instance inodes as default ownership")
b0f7e2d739b4 ("eventfs: Remove "lookup" parameter from create_dir/file_dentry()")
ad579864637a ("tracefs: Check for dentry->d_inode exists in set_gid()")
7e8358edf503 ("eventfs: Fix file and directory uid and gid ownership")
0dfc852b6fe3 ("eventfs: Have event files and directories default to parent uid and gid")
5eaf7f0589c0 ("eventfs: Fix events beyond NAME_MAX blocking tasks")
f49f950c217b ("eventfs: Make sure that parent->d_inode is locked in creating files/dirs")
fc4561226fea ("eventfs: Do not allow NULL parent to eventfs_start_creating()")
bcae32c5632f ("eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()")
71cade82f2b5 ("eventfs: Do not invalidate dentry in create_file/dir_dentry()")
88903daecacf ("eventfs: Remove expectation that ei->is_freed means ei->dentry == NULL")
44365329f821 ("eventfs: Hold eventfs_mutex when calling callback functions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 340f0c7067a95281ad13734f8225f49c6cf52067 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Thu, 23 May 2024 01:14:28 -0400
Subject: [PATCH] eventfs: Update all the eventfs_inodes from the events
 descriptor

The change to update the permissions of the eventfs_inode had the
misconception that using the tracefs_inode would find all the
eventfs_inodes that have been updated and reset them on remount.
The problem with this approach is that the eventfs_inodes are freed when
they are no longer used (basically the reason the eventfs system exists).
When they are freed, the updated eventfs_inodes are not reset on a remount
because their tracefs_inodes have been freed.

Instead, since the events directory eventfs_inode always has a
tracefs_inode pointing to it (it is not freed when finished), and the
events directory has a link to all its children, have the
eventfs_remount() function only operate on the events eventfs_inode and
have it descend into its children updating their uid and gids.

Link: https://lore.kernel.org/all/CAK7LNARXgaWw3kH9JgrnH4vK6fr8LDkNKf3wq8NhMWJrVwJyVQ@mail.gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240523051539.754424703@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: baa23a8d4360d ("tracefs: Reset permissions on remount if permissions are options")
Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5dfb1ccd56ea..129d0f54ba62 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -305,6 +305,45 @@ static const struct file_operations eventfs_file_operations = {
 	.llseek		= generic_file_llseek,
 };
 
+static void eventfs_set_attrs(struct eventfs_inode *ei, bool update_uid, kuid_t uid,
+			      bool update_gid, kgid_t gid, int level)
+{
+	struct eventfs_inode *ei_child;
+
+	/* Update events/<system>/<event> */
+	if (WARN_ON_ONCE(level > 3))
+		return;
+
+	if (update_uid) {
+		ei->attr.mode &= ~EVENTFS_SAVE_UID;
+		ei->attr.uid = uid;
+	}
+
+	if (update_gid) {
+		ei->attr.mode &= ~EVENTFS_SAVE_GID;
+		ei->attr.gid = gid;
+	}
+
+	list_for_each_entry(ei_child, &ei->children, list) {
+		eventfs_set_attrs(ei_child, update_uid, uid, update_gid, gid, level + 1);
+	}
+
+	if (!ei->entry_attrs)
+		return;
+
+	for (int i = 0; i < ei->nr_entries; i++) {
+		if (update_uid) {
+			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_UID;
+			ei->entry_attrs[i].uid = uid;
+		}
+		if (update_gid) {
+			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_GID;
+			ei->entry_attrs[i].gid = gid;
+		}
+	}
+
+}
+
 /*
  * On a remount of tracefs, if UID or GID options are set, then
  * the mount point inode permissions should be used.
@@ -314,33 +353,12 @@ void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
 {
 	struct eventfs_inode *ei = ti->private;
 
-	if (!ei)
+	/* Only the events directory does the updates */
+	if (!ei || !ei->is_events || ei->is_freed)
 		return;
 
-	if (update_uid) {
-		ei->attr.mode &= ~EVENTFS_SAVE_UID;
-		ei->attr.uid = ti->vfs_inode.i_uid;
-	}
-
-
-	if (update_gid) {
-		ei->attr.mode &= ~EVENTFS_SAVE_GID;
-		ei->attr.gid = ti->vfs_inode.i_gid;
-	}
-
-	if (!ei->entry_attrs)
-		return;
-
-	for (int i = 0; i < ei->nr_entries; i++) {
-		if (update_uid) {
-			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_UID;
-			ei->entry_attrs[i].uid = ti->vfs_inode.i_uid;
-		}
-		if (update_gid) {
-			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_GID;
-			ei->entry_attrs[i].gid = ti->vfs_inode.i_gid;
-		}
-	}
+	eventfs_set_attrs(ei, update_uid, ti->vfs_inode.i_uid,
+			  update_gid, ti->vfs_inode.i_gid, 0);
 }
 
 /* Return the evenfs_inode of the "events" directory */


