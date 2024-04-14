Return-Path: <stable+bounces-37358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C3E89C482
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498831C220C7
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C757D08A;
	Mon,  8 Apr 2024 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c958KYeL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471A7D07E;
	Mon,  8 Apr 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583998; cv=none; b=FXY+YmngTlTqCBiDw6lDcTxLHgxRN0kSRJf3D/X7mWL6On0GtkUwkTe5Q6SYcO2fnvcFfYCkqxddXWrdZ+ld1OPQr47+vc5wjO35oD60My7+M0b5bT5LAE5E+NkflQzE5GyolAqjlgDLqVZ4BInMj12Py+XviQbBDBZy1v5OrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583998; c=relaxed/simple;
	bh=IfA2cgyT2MOmurW/6ZbXkRwLApk+xyCXQTaSFw0fq28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R09rxEMCHpdAi1qfVnfkQ0hG39k58f8MU6faOswhqRViPf1YEYadvBAZIOeZIQ4OtMgov49jWKpmO4Bq/w2t3S5l1lpSj3YXaOWXK0NHwMM5MO4xMhsPL12ZGXS2I/GR8AQM4eASCEgvvxMoqW3/XyGxiUOVx+/Zc9NB+mFV5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c958KYeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B42C43394;
	Mon,  8 Apr 2024 13:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583998;
	bh=IfA2cgyT2MOmurW/6ZbXkRwLApk+xyCXQTaSFw0fq28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c958KYeLJnCWBjMCB0S9RAzLtccUwdX4HfESrWVMtMD5YZh9pUP/KZE65+0Vs9RvL
	 oLTrsuQoULoD/3sP5f2MJvT2sQwdus15Gpi1yDz3RCImQy98Cp7yroGXznqctr3rIh
	 n/cretsD+uyUyyo3VqzvcxP+D25cGdY9Wts4hqK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 290/690] inotify: move control flags from mask to mark flags
Date: Mon,  8 Apr 2024 14:52:36 +0200
Message-ID: <20240408125410.109967629@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 38035c04f5865c4ef9597d6beed6a7178f90f64a ]

The inotify control flags in the mark mask (e.g. FS_IN_ONE_SHOT) are not
relevant to object interest mask, so move them to the mark flags.

This frees up some bits in the object interest mask.

Link: https://lore.kernel.org/r/20220422120327.3459282-3-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/fsnotify.c                 |  4 +--
 fs/notify/inotify/inotify.h          | 11 ++++++--
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 fs/notify/inotify/inotify_user.c     | 38 ++++++++++++++++++----------
 include/linux/fsnotify_backend.h     | 16 +++++++-----
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 70a8516b78bc5..6eee19d15e8cd 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -253,7 +253,7 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
 	if (WARN_ON_ONCE(!inode && !dir))
 		return 0;
 
-	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
+	if ((inode_mark->flags & FSNOTIFY_MARK_FLAG_EXCL_UNLINK) &&
 	    path && d_unlinked(path->dentry))
 		return 0;
 
@@ -581,7 +581,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
index 8f00151eb731f..7d5df7a215397 100644
--- a/fs/notify/inotify/inotify.h
+++ b/fs/notify/inotify/inotify.h
@@ -27,11 +27,18 @@ static inline struct inotify_event_info *INOTIFY_E(struct fsnotify_event *fse)
  * userspace.  There is at least one bit (FS_EVENT_ON_CHILD) which is
  * used only internally to the kernel.
  */
-#define INOTIFY_USER_MASK (IN_ALL_EVENTS | IN_ONESHOT | IN_EXCL_UNLINK)
+#define INOTIFY_USER_MASK (IN_ALL_EVENTS)
 
 static inline __u32 inotify_mark_user_mask(struct fsnotify_mark *fsn_mark)
 {
-	return fsn_mark->mask & INOTIFY_USER_MASK;
+	__u32 mask = fsn_mark->mask & INOTIFY_USER_MASK;
+
+	if (fsn_mark->flags & FSNOTIFY_MARK_FLAG_EXCL_UNLINK)
+		mask |= IN_EXCL_UNLINK;
+	if (fsn_mark->flags & FSNOTIFY_MARK_FLAG_IN_ONESHOT)
+		mask |= IN_ONESHOT;
+
+	return mask;
 }
 
 extern void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 8279827836399..993375f0db673 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -129,7 +129,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 		fsnotify_destroy_event(group, fsn_event);
 	}
 
-	if (inode_mark->mask & IN_ONESHOT)
+	if (inode_mark->flags & FSNOTIFY_MARK_FLAG_IN_ONESHOT)
 		fsnotify_destroy_mark(inode_mark, group);
 
 	return 0;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index b87759b8402be..fdce87902b382 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -107,6 +107,21 @@ static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
 	return mask;
 }
 
+#define INOTIFY_MARK_FLAGS \
+	(FSNOTIFY_MARK_FLAG_EXCL_UNLINK | FSNOTIFY_MARK_FLAG_IN_ONESHOT)
+
+static inline unsigned int inotify_arg_to_flags(u32 arg)
+{
+	unsigned int flags = 0;
+
+	if (arg & IN_EXCL_UNLINK)
+		flags |= FSNOTIFY_MARK_FLAG_EXCL_UNLINK;
+	if (arg & IN_ONESHOT)
+		flags |= FSNOTIFY_MARK_FLAG_IN_ONESHOT;
+
+	return flags;
+}
+
 static inline u32 inotify_mask_to_arg(__u32 mask)
 {
 	return mask & (IN_ALL_EVENTS | IN_ISDIR | IN_UNMOUNT | IN_IGNORED |
@@ -518,13 +533,10 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	struct fsnotify_mark *fsn_mark;
 	struct inotify_inode_mark *i_mark;
 	__u32 old_mask, new_mask;
-	__u32 mask;
-	int add = (arg & IN_MASK_ADD);
+	int replace = !(arg & IN_MASK_ADD);
 	int create = (arg & IN_MASK_CREATE);
 	int ret;
 
-	mask = inotify_arg_to_mask(inode, arg);
-
 	fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, group);
 	if (!fsn_mark)
 		return -ENOENT;
@@ -537,10 +549,12 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 
 	spin_lock(&fsn_mark->lock);
 	old_mask = fsn_mark->mask;
-	if (add)
-		fsn_mark->mask |= mask;
-	else
-		fsn_mark->mask = mask;
+	if (replace) {
+		fsn_mark->mask = 0;
+		fsn_mark->flags &= ~INOTIFY_MARK_FLAGS;
+	}
+	fsn_mark->mask |= inotify_arg_to_mask(inode, arg);
+	fsn_mark->flags |= inotify_arg_to_flags(arg);
 	new_mask = fsn_mark->mask;
 	spin_unlock(&fsn_mark->lock);
 
@@ -571,19 +585,17 @@ static int inotify_new_watch(struct fsnotify_group *group,
 			     u32 arg)
 {
 	struct inotify_inode_mark *tmp_i_mark;
-	__u32 mask;
 	int ret;
 	struct idr *idr = &group->inotify_data.idr;
 	spinlock_t *idr_lock = &group->inotify_data.idr_lock;
 
-	mask = inotify_arg_to_mask(inode, arg);
-
 	tmp_i_mark = kmem_cache_alloc(inotify_inode_mark_cachep, GFP_KERNEL);
 	if (unlikely(!tmp_i_mark))
 		return -ENOMEM;
 
 	fsnotify_init_mark(&tmp_i_mark->fsn_mark, group);
-	tmp_i_mark->fsn_mark.mask = mask;
+	tmp_i_mark->fsn_mark.mask = inotify_arg_to_mask(inode, arg);
+	tmp_i_mark->fsn_mark.flags = inotify_arg_to_flags(arg);
 	tmp_i_mark->wd = -1;
 
 	ret = inotify_add_to_idr(idr, idr_lock, tmp_i_mark);
@@ -837,9 +849,7 @@ static int __init inotify_user_setup(void)
 	BUILD_BUG_ON(IN_UNMOUNT != FS_UNMOUNT);
 	BUILD_BUG_ON(IN_Q_OVERFLOW != FS_Q_OVERFLOW);
 	BUILD_BUG_ON(IN_IGNORED != FS_IN_IGNORED);
-	BUILD_BUG_ON(IN_EXCL_UNLINK != FS_EXCL_UNLINK);
 	BUILD_BUG_ON(IN_ISDIR != FS_ISDIR);
-	BUILD_BUG_ON(IN_ONESHOT != FS_IN_ONESHOT);
 
 	BUILD_BUG_ON(HWEIGHT32(ALL_INOTIFY_BITS) != 22);
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 0805b74cae441..b1c72edd97845 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -55,7 +55,6 @@
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 
-#define FS_EXCL_UNLINK		0x04000000	/* do not send events if object is unlinked */
 /*
  * Set on inode mark that cares about things that happen to its children.
  * Always set for dnotify and inotify.
@@ -66,7 +65,6 @@
 #define FS_RENAME		0x10000000	/* File was renamed */
 #define FS_DN_MULTISHOT		0x20000000	/* dnotify multishot */
 #define FS_ISDIR		0x40000000	/* event occurred against dir */
-#define FS_IN_ONESHOT		0x80000000	/* only send event once */
 
 #define FS_MOVE			(FS_MOVED_FROM | FS_MOVED_TO)
 
@@ -106,8 +104,7 @@
 			     FS_ERROR)
 
 /* Extra flags that may be reported with event or control handling of events */
-#define ALL_FSNOTIFY_FLAGS  (FS_EXCL_UNLINK | FS_ISDIR | FS_IN_ONESHOT | \
-			     FS_DN_MULTISHOT | FS_EVENT_ON_CHILD)
+#define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
 
 #define ALL_FSNOTIFY_BITS   (ALL_FSNOTIFY_EVENTS | ALL_FSNOTIFY_FLAGS)
 
@@ -473,9 +470,14 @@ struct fsnotify_mark {
 	struct fsnotify_mark_connector *connector;
 	/* Events types to ignore [mark->lock, group->mark_mutex] */
 	__u32 ignored_mask;
-#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x01
-#define FSNOTIFY_MARK_FLAG_ALIVE		0x02
-#define FSNOTIFY_MARK_FLAG_ATTACHED		0x04
+	/* General fsnotify mark flags */
+#define FSNOTIFY_MARK_FLAG_ALIVE		0x0001
+#define FSNOTIFY_MARK_FLAG_ATTACHED		0x0002
+	/* inotify mark flags */
+#define FSNOTIFY_MARK_FLAG_EXCL_UNLINK		0x0010
+#define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x0020
+	/* fanotify mark flags */
+#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
-- 
2.43.0




