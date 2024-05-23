Return-Path: <stable+bounces-46002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1448CDBDE
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 23:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF26A1F23608
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 21:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C0F127E24;
	Thu, 23 May 2024 21:23:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E384A22;
	Thu, 23 May 2024 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499400; cv=none; b=SDRevRk63UcvejOfWhHds6QITR/knASd5sNfC6UffLrNcc3flplGjUv0B3GGB8HPkeR0h3JiHknzP/SHJ/8tl23+h8/CWGY2K2HsubHqqOE37jz+9BL7foOXCYES48hTKRjrxw3JnbaxFX4fKEcspwBGbyr9G/nS542eNybeK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499400; c=relaxed/simple;
	bh=XM0hUwOffQtWwO0Qz54AvVXTV1kQJiBoCu2GXssYZaE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aFwNDQkm1F4GZ7bRBfvQcKpK6LIypUPxW9u28OUXXYjlZmRiqjcbG6Sh/7zx06BZGjjwk/lvJBTm5f63rtTYii/4d4gP57X27+X45JRFiA1pWA9bCVV0vscMnE1mMmmOrLhDvO+6Vq2i9HdQTqR+CS/fAfMqsLvnivnt8joWhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88465C4AF09;
	Thu, 23 May 2024 21:23:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAFuw-00000006l8j-1ene;
	Thu, 23 May 2024 17:24:06 -0400
Message-ID: <20240523212406.254317554@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 23 May 2024 17:23:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 2/8] tracefs: Update inode permissions on remount
References: <20240523212258.883756004@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

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
---
 fs/tracefs/event_inode.c | 17 +++++++++++++----
 fs/tracefs/inode.c       | 15 ++++++++++++---
 2 files changed, 25 insertions(+), 7 deletions(-)

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
+
 
-	if (update_gid)
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
-
+				ti->vfs_inode.i_gid = fsi->gid;
+			}
+
+			/*
+			 * Note, the above ti->vfs_inode updates are
+			 * used in eventfs_remount() so they must come
+			 * before calling it.
+			 */
 			if (ti->flags & TRACEFS_EVENT_INODE)
 				eventfs_remount(ti, update_uid, update_gid);
 		}
-- 
2.43.0



