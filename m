Return-Path: <stable+bounces-50497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653EB906A7C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05130284DFD
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5C142648;
	Thu, 13 Jun 2024 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJ+7YPWl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2D13C68A
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276112; cv=none; b=VVRGXCLe6i6uNAO1poVh4PtBBY0Kttc5u7yrX6w+c6nfsj2NQCySUwclylwo9dQnscgzb2TM6wUrxbs7RLfgcgkf/+ecsiuO+XQmQGBzKTxxP8wH5A2Q5E7ZB8BF+3BRTb7eQXX56TNTtJ1mR92rQzBHNr8jClXVdEOZxitMY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276112; c=relaxed/simple;
	bh=ECUY3E+CNzLK5wMlhobRJ4SuuzaD0HVp+3vQfRMkpt8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=amcOTp8h2maOll52dQx80+FSww2DVQXbVdbfH20JuZHThevUDGjPDnAW/P+ntI8PRZWea2mTIzwE6dCco2G4gTJkiyC9wmwkd5yyM1AJVP9jci6RD5KkKIyChZK370Cal9ZoXfihwp/JbV0x+e2+cXZKGpsRbVCeQ9BilJHA2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJ+7YPWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4814C2BBFC;
	Thu, 13 Jun 2024 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276112;
	bh=ECUY3E+CNzLK5wMlhobRJ4SuuzaD0HVp+3vQfRMkpt8=;
	h=Subject:To:Cc:From:Date:From;
	b=DJ+7YPWlwe48WFDrjydYVxwMAU9BQGKk4ZHpwWRIRcR0DvwipzRhUruGV9/p1r7II
	 Bq3NXUJQ7oTypufprI7Z/3zkol+bjUkf+bP+0EXkBYyl1FI2tipQJJTt0pOa5xU5BJ
	 vHnww+rKltYpicOdzR5R7/Db/rI7ASuvj0ubwKQo=
Subject: FAILED: patch "[PATCH] tracefs: Update inode permissions on remount" failed to apply to 6.9-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,masahiroy@kernel.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 12:55:09 +0200
Message-ID: <2024061309-pliable-outcast-adb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 27c046484382d78b4abb0a6e9905a20121af9b35
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061309-pliable-outcast-adb7@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

27c046484382 ("tracefs: Update inode permissions on remount")

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


