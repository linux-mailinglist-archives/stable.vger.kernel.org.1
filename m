Return-Path: <stable+bounces-45590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E342B8CC507
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3F3B21BF8
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1761420D4;
	Wed, 22 May 2024 16:42:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9F14198A;
	Wed, 22 May 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396179; cv=none; b=iL8AkjnDx9DFukLwQf08RQRYFKxr6rkVmDTpyjYYsKwnOKJG+v2xJ5JCDajvHuQUk3lPF5LtfouyO0WG4tC4XxpHJD1kZa+RDBunr3/59iqwxFG+sSE8ak4FjY6jG+CT65ztH4tq5nD/GhxD6xOgOD+pF4hbjfsJUan6Yc8m/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396179; c=relaxed/simple;
	bh=RY2yIHAcrXOxPGkFPv3kw8hG3PXOcc30Rvt6upQEfLk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iUP65nzGl4Z3GroTVjuiwSoC8dw0LHpWz0nATByZdj/7uQvHzylaHkM1eG2xQ+V6nHs6TqV1pAUABM4WByXZ3dz6HIMR/o+HpXuaHESMG7bd5Hx8ZiNMzfr7rXH++5hPsJcptSTXYVn2Ljtyhk5jg/HlhYXAyJANwDe74LEBXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31A6C4AF07;
	Wed, 22 May 2024 16:42:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s9p41-00000006HFe-2dWN;
	Wed, 22 May 2024 12:43:41 -0400
Message-ID: <20240522164341.489344112@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 22 May 2024 12:43:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH 2/2] tracefs: Update inode permissions on remount
References: <20240522164320.469785149@goodmis.org>
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

Cc: stable@vger.kernel.org
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



