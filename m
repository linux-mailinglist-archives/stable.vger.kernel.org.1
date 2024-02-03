Return-Path: <stable+bounces-18663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A084839D
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6841C22329
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EE62BB1A;
	Sat,  3 Feb 2024 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pvd5NmRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95445579A;
	Sat,  3 Feb 2024 04:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933965; cv=none; b=ZKlSAP/DMvdxF/8stOOVEqEGtLjht1/yBrS63zgee6RzvVP1z6RtRT709WqMKNc1vDW0JGTimtRYpACIGpr2vAn7zrwJckhBD6eOr2i99tPLxMRyTtvfk8jAyKqetqQhwBA5mIoU2e9z4v8pbkWSdP0CcfFlUQhOSgW81phui7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933965; c=relaxed/simple;
	bh=GG+zn1gHkKRiY1DxMgq0+uusL4Y0Ervu8FMBRRqOiSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENJ280NOreV9QIOCel/ekcAnF9XJeRSCqh3LHeJcuY8wjracsNPhOE9FuQUSLfO/GhDzRE9psot/uuNQ+BvIijBj0dzJbr5wFdfqApseCclUiwYCql+GiIxqpXJe7Fb29BdcMpNUwua9yL9uDwHynkTGmtvNpjNsYc66fqN/Ce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pvd5NmRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C52FC43390;
	Sat,  3 Feb 2024 04:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933965;
	bh=GG+zn1gHkKRiY1DxMgq0+uusL4Y0Ervu8FMBRRqOiSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvd5NmRWWh2E5+Y1atmHKlzFNxuuooFsa/v2GDkXwNyPkfXpndGIWjb2s5ZZHui2i
	 Jd9CMc6u5C5Lo+QGlWwnEh1vqXZ30mqiavgmE/umKtjSZ4xuHIgjsrfeUnDLfk0ADj
	 Wvp8+Hdvez+FsyHRrat8rBJB5piR213EHID5Vf4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 311/353] tracefs: remove stale update_gid code
Date: Fri,  2 Feb 2024 20:07:09 -0800
Message-ID: <20240203035413.680340223@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 29142dc92c37d3259a33aef15b03e6ee25b0d188 ]

The 'eventfs_update_gid()' function is no longer called, so remove it
(and the helper function it uses).

Link: https://lore.kernel.org/all/CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com/

Fixes: 8186fff7ab64 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/tracefs/event_inode.c | 38 --------------------------------------
 fs/tracefs/internal.h    |  1 -
 2 files changed, 39 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 517f1ae1a058..f2d7ad155c00 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -273,44 +273,6 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
 		inode->i_gid = attr->gid;
 }
 
-static void update_gid(struct eventfs_inode *ei, kgid_t gid, int level)
-{
-	struct eventfs_inode *ei_child;
-
-	/* at most we have events/system/event */
-	if (WARN_ON_ONCE(level > 3))
-		return;
-
-	ei->attr.gid = gid;
-
-	if (ei->entry_attrs) {
-		for (int i = 0; i < ei->nr_entries; i++) {
-			ei->entry_attrs[i].gid = gid;
-		}
-	}
-
-	/*
-	 * Only eventfs_inode with dentries are updated, make sure
-	 * all eventfs_inodes are updated. If one of the children
-	 * do not have a dentry, this function must traverse it.
-	 */
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
-		if (!ei_child->dentry)
-			update_gid(ei_child, gid, level + 1);
-	}
-}
-
-void eventfs_update_gid(struct dentry *dentry, kgid_t gid)
-{
-	struct eventfs_inode *ei = dentry->d_fsdata;
-	int idx;
-
-	idx = srcu_read_lock(&eventfs_srcu);
-	update_gid(ei, gid, 0);
-	srcu_read_unlock(&eventfs_srcu, idx);
-}
-
 /**
  * create_file - create a file in the tracefs filesystem
  * @name: the name of the file to create.
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 12b7d0150ae9..af3b43fa75cd 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -81,7 +81,6 @@ struct inode *tracefs_get_inode(struct super_block *sb);
 struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
 struct dentry *eventfs_failed_creating(struct dentry *dentry);
 struct dentry *eventfs_end_creating(struct dentry *dentry);
-void eventfs_update_gid(struct dentry *dentry, kgid_t gid);
 void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.43.0




