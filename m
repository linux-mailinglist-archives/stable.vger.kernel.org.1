Return-Path: <stable+bounces-50495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E27EF906A7A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F001F22738
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492F914262B;
	Thu, 13 Jun 2024 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S4z0+W4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B15713C68A
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276049; cv=none; b=pEJ3dAVUwhMPIv5A4Km+/pOu9LMmKLVPc3waeWmxiroCJmxcjtJ4ua1l0S0kXY0B5Szq9wPoi9IfYPg0vU6qIlC+N9Vhaw3POvis9Ml77n83qFKPcAF+ONtqhpn+lKXz9Cm1zOymIj9iML4HzTDnm3PWEgEPTe7S4geGcSYKUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276049; c=relaxed/simple;
	bh=4Irxc81j7yM+jnxXSqEDTiZplj3/nQ9tRxkOt9To7co=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ntPzxDWQ/REcNlj6rfca1Q0Kf+DDir9mRsr/VKGmRFeueRaFuLEUbaj1K7C4SYyb1vSdGjCL7dUL/zHHZtPODG6UaQIAY49yWisr/MrGF4cQmw8qzf807V7Ypn/cfJwy/6ef+Ssi5GHwYAwdyAUkXndzcXdXxVMlubrnw60y3V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S4z0+W4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1096CC32786;
	Thu, 13 Jun 2024 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276048;
	bh=4Irxc81j7yM+jnxXSqEDTiZplj3/nQ9tRxkOt9To7co=;
	h=Subject:To:Cc:From:Date:From;
	b=S4z0+W4bfAzj4OrWsak6cqN4owXOJsS/ewWl0m9867czBw1DwqvfSDvQYhUQnPkab
	 4jNAJ+PYcDrRWL1eVl5VKWKzsf3x98eFKRN88zxwYwLHrf/ACdfdKyg1Xl+FUZeT7+
	 ck48cTRhkL0KQav0tKGEmKeukwHbCk4uLwT43jII=
Subject: FAILED: patch "[PATCH] eventfs: Update all the eventfs_inodes from the events" failed to apply to 6.9-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,masahiroy@kernel.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 12:54:05 +0200
Message-ID: <2024061305-kilogram-handheld-7bd9@gregkh>
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
git cherry-pick -x 340f0c7067a95281ad13734f8225f49c6cf52067
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061305-kilogram-handheld-7bd9@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

340f0c7067a9 ("eventfs: Update all the eventfs_inodes from the events descriptor")
27c046484382 ("tracefs: Update inode permissions on remount")

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


