Return-Path: <stable+bounces-45618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014258CCBB1
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 07:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307871C21575
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 05:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F4313B587;
	Thu, 23 May 2024 05:14:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202613AD3E;
	Thu, 23 May 2024 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716441296; cv=none; b=VJJHVZFrtBp02mHbdG5214pNCrK5DNhCG8etBv7+VqG741ucXscWmgxTT/r+iUtXsXAEIQdDYtvuuLGZBrbTVToIfhefIPxZdM96nxjcmXG26h8U821Tzd+FcnmM5mNNfmF+DKDCXZhFQwfp07M69zgJfbX9pFJVSa7M4K8tu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716441296; c=relaxed/simple;
	bh=XqsroI8Co4hl2Eg1PmlEh9f9N1L0jJ02yHQWdWwApwQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oHvRQP7GQ2M2OFrcLPRKzwQj2l3hOn45J6Kv2Sb9udiM3lRQRgcZG6kgWwrM2WbzV6fGfUm5iIZIV1JfZsplyNkAl4hq/HJxmDGIC5lutRBgB2Ff0GOdTuR2WYvBGb5fr9GU11dtmvIBXBRwMskPjeM935rNMg/j1Icwp7UaHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EF9C4AF0D;
	Thu, 23 May 2024 05:14:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sA0nj-00000006W6f-3ijh;
	Thu, 23 May 2024 01:15:39 -0400
Message-ID: <20240523051539.754424703@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 23 May 2024 01:14:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 3/4] eventfs: Update all the eventfs_inodes from the events descriptor
References: <20240523051425.335105631@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

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

Cc: stable@vger.kernel.org
Fixes: baa23a8d4360d ("tracefs: Reset permissions on remount if permissions are options")
Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 44 ++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5dfb1ccd56ea..129d0f54ba62 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -305,27 +305,27 @@ static const struct file_operations eventfs_file_operations = {
 	.llseek		= generic_file_llseek,
 };
 
-/*
- * On a remount of tracefs, if UID or GID options are set, then
- * the mount point inode permissions should be used.
- * Reset the saved permission flags appropriately.
- */
-void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
+static void eventfs_set_attrs(struct eventfs_inode *ei, bool update_uid, kuid_t uid,
+			      bool update_gid, kgid_t gid, int level)
 {
-	struct eventfs_inode *ei = ti->private;
+	struct eventfs_inode *ei_child;
 
-	if (!ei)
+	/* Update events/<system>/<event> */
+	if (WARN_ON_ONCE(level > 3))
 		return;
 
 	if (update_uid) {
 		ei->attr.mode &= ~EVENTFS_SAVE_UID;
-		ei->attr.uid = ti->vfs_inode.i_uid;
+		ei->attr.uid = uid;
 	}
 
-
 	if (update_gid) {
 		ei->attr.mode &= ~EVENTFS_SAVE_GID;
-		ei->attr.gid = ti->vfs_inode.i_gid;
+		ei->attr.gid = gid;
+	}
+
+	list_for_each_entry(ei_child, &ei->children, list) {
+		eventfs_set_attrs(ei_child, update_uid, uid, update_gid, gid, level + 1);
 	}
 
 	if (!ei->entry_attrs)
@@ -334,13 +334,31 @@ void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
 	for (int i = 0; i < ei->nr_entries; i++) {
 		if (update_uid) {
 			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_UID;
-			ei->entry_attrs[i].uid = ti->vfs_inode.i_uid;
+			ei->entry_attrs[i].uid = uid;
 		}
 		if (update_gid) {
 			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_GID;
-			ei->entry_attrs[i].gid = ti->vfs_inode.i_gid;
+			ei->entry_attrs[i].gid = gid;
 		}
 	}
+
+}
+
+/*
+ * On a remount of tracefs, if UID or GID options are set, then
+ * the mount point inode permissions should be used.
+ * Reset the saved permission flags appropriately.
+ */
+void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
+{
+	struct eventfs_inode *ei = ti->private;
+
+	/* Only the events directory does the updates */
+	if (!ei || !ei->is_events || ei->is_freed)
+		return;
+
+	eventfs_set_attrs(ei, update_uid, ti->vfs_inode.i_uid,
+			  update_gid, ti->vfs_inode.i_gid, 0);
 }
 
 /* Return the evenfs_inode of the "events" directory */
-- 
2.43.0



