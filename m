Return-Path: <stable+bounces-50498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B0906A7D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4891C242CB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0F142648;
	Thu, 13 Jun 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lf4baGGf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16813C68A
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276121; cv=none; b=SWBQtaVaG9D3kqOweQOreXyIvhgrZEtUXPsgUxEAwhsTnMlgQtKxfnCK2Rqr16+GwuDyXXtrv/J7+DMCx4vLfcV7Oi3eLre0eyk4d6+oYEVREe1jzdEws5YVlgKuRrz4ibt7O3SqaJ/ttMZaBjIESvolma0d09Ok88z6RAC/0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276121; c=relaxed/simple;
	bh=2VLtj0VTjSYA1P6s+Stn4BXiPA85krRqaN72ayZhn6M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NQTYg8b8x+di9nS7KFLLWZYcb8xztdcL4Iw3XqN2R7e9A0v4ZN8e+yfMY1b6MpDpAShNFPb11f/k6RpMoem0PBTHADf7QdvCqioA0Zc0Y7Y4LAgfFvHM87mYjzS+EWpYIikvMbg13wPNRkNVyL7wiYHYGtyyLuyT28C0Z5WDIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lf4baGGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8960FC32786;
	Thu, 13 Jun 2024 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276120;
	bh=2VLtj0VTjSYA1P6s+Stn4BXiPA85krRqaN72ayZhn6M=;
	h=Subject:To:Cc:From:Date:From;
	b=Lf4baGGfMulz+T5UNm82Ohmq91jo8dCcfh4oTPaxYyxBp7xyvTXshWkBxw0shVepB
	 Ogb3vHpy/UPsCsgu42W8q33QXzAjX/FX7BG3Xge5Q6vZ2o0vO7hvjeOZryB98FeP0x
	 VFOIBZsKEqkADj5NoL1xYLqJ6YSOnkx09gyJ5JvQ=
Subject: FAILED: patch "[PATCH] tracefs: Update inode permissions on remount" failed to apply to 6.6-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,masahiroy@kernel.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 12:55:10 +0200
Message-ID: <2024061310-exemplify-snore-c1b0@gregkh>
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
git cherry-pick -x 27c046484382d78b4abb0a6e9905a20121af9b35
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061310-exemplify-snore-c1b0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

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
28e12c09f5aa ("eventfs: Save ownership and mode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27c046484382d78b4abb0a6e9905a20121af9b35 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Thu, 23 May 2024 01:14:27 -0400
Subject: [PATCH] tracefs: Update inode permissions on remount

When a remount happens, if a gid or uid is specified update the inodes to
have the same gid and uid. This will allow the simplification of the
permissions logic for the dynamically created files and directories.

Link: https://lore.kernel.org/linux-trace-kernel/20240523051539.592429986@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Fixes: baa23a8d4360d ("tracefs: Reset permissions on remount if permissions are options")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 55a40a730b10..5dfb1ccd56ea 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -317,20 +317,29 @@ void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
 	if (!ei)
 		return;
 
-	if (update_uid)
+	if (update_uid) {
 		ei->attr.mode &= ~EVENTFS_SAVE_UID;
+		ei->attr.uid = ti->vfs_inode.i_uid;
+	}
 
-	if (update_gid)
+
+	if (update_gid) {
 		ei->attr.mode &= ~EVENTFS_SAVE_GID;
+		ei->attr.gid = ti->vfs_inode.i_gid;
+	}
 
 	if (!ei->entry_attrs)
 		return;
 
 	for (int i = 0; i < ei->nr_entries; i++) {
-		if (update_uid)
+		if (update_uid) {
 			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_UID;
-		if (update_gid)
+			ei->entry_attrs[i].uid = ti->vfs_inode.i_uid;
+		}
+		if (update_gid) {
 			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_GID;
+			ei->entry_attrs[i].gid = ti->vfs_inode.i_gid;
+		}
 	}
 }
 
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index a827f6a716c4..9252e0d78ea2 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -373,12 +373,21 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 
 		rcu_read_lock();
 		list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
-			if (update_uid)
+			if (update_uid) {
 				ti->flags &= ~TRACEFS_UID_PERM_SET;
+				ti->vfs_inode.i_uid = fsi->uid;
+			}
 
-			if (update_gid)
+			if (update_gid) {
 				ti->flags &= ~TRACEFS_GID_PERM_SET;
+				ti->vfs_inode.i_gid = fsi->gid;
+			}
 
+			/*
+			 * Note, the above ti->vfs_inode updates are
+			 * used in eventfs_remount() so they must come
+			 * before calling it.
+			 */
 			if (ti->flags & TRACEFS_EVENT_INODE)
 				eventfs_remount(ti, update_uid, update_gid);
 		}


