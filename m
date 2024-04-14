Return-Path: <stable+bounces-37404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3C489C4B5
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26CF1C2258D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620997BAFD;
	Mon,  8 Apr 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ipfTtgP+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB079F0;
	Mon,  8 Apr 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584133; cv=none; b=SmCxb3MwjatNTTwfvXtdPW3szVDt9o5Qyllve892PiEhDRFfBGgR1zZvcf9UYiT+mdpgPtb3qy7emz9wD9SM8wtdQfI7ht/YnTji70G3NrBrwjcAgRBs6wVjG6k88UtRDHfk7lnynKNvCS7DwSDZI4S/Irua6AnzyQIh2zPSjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584133; c=relaxed/simple;
	bh=Q9FSux3J7pTN/zTNokotT29yXAgkER+gy4A6zT1CV4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDktdhrfK2jc5vYhwb1PMHxITYxC3LkVCOqU+oPOaJgJevT+WQiesKWu1uNd0Ls6q1WXK03cXZh30jMIhQOFvRGPAovWwcebjBqiDDO3xgNyCE94M7Li3dFgwRIpqvJUw/LPKAa1q3uACw54RejAA80Qp6V5Csj8RHM3XiMsEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ipfTtgP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D75C433F1;
	Mon,  8 Apr 2024 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584133;
	bh=Q9FSux3J7pTN/zTNokotT29yXAgkER+gy4A6zT1CV4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipfTtgP+Xf/gQ1vb3b8bNFmVvzmVdj4xsILm+insREXXZ85MOai0wAaTzmBRdTs9c
	 tRH7348Ic62GhZW/wk43vr4K/JOI9fRcdeegY36EOIo9IrFb7irjiqupohGn3WlwK4
	 PckKAsK6Gs4hsSYWKjg6UXC3awTxwybVSpbmFLNw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 339/690] fanotify: introduce FAN_MARK_IGNORE
Date: Mon,  8 Apr 2024 14:53:25 +0200
Message-ID: <20240408125411.898784126@linuxfoundation.org>
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

[ Upstream commit e252f2ed1c8c6c3884ab5dd34e003ed21f1fe6e0 ]

This flag is a new way to configure ignore mask which allows adding and
removing the event flags FAN_ONDIR and FAN_EVENT_ON_CHILD in ignore mask.

The legacy FAN_MARK_IGNORED_MASK flag would always ignore events on
directories and would ignore events on children depending on whether
the FAN_EVENT_ON_CHILD flag was set in the (non ignored) mask.

FAN_MARK_IGNORE can be used to ignore events on children without setting
FAN_EVENT_ON_CHILD in the mark's mask and will not ignore events on
directories unconditionally, only when FAN_ONDIR is set in ignore mask.

The new behavior is non-downgradable.  After calling fanotify_mark() with
FAN_MARK_IGNORE once, calling fanotify_mark() with FAN_MARK_IGNORED_MASK
on the same object will return EEXIST error.

Setting the event flags with FAN_MARK_IGNORE on a non-dir inode mark
has no meaning and will return ENOTDIR error.

The meaning of FAN_MARK_IGNORED_SURV_MODIFY is preserved with the new
FAN_MARK_IGNORE flag, but with a few semantic differences:

1. FAN_MARK_IGNORED_SURV_MODIFY is required for filesystem and mount
   marks and on an inode mark on a directory. Omitting this flag
   will return EINVAL or EISDIR error.

2. An ignore mask on a non-directory inode that survives modify could
   never be downgraded to an ignore mask that does not survive modify.
   With new FAN_MARK_IGNORE semantics we make that rule explicit -
   trying to update a surviving ignore mask without the flag
   FAN_MARK_IGNORED_SURV_MODIFY will return EEXIST error.

The conveniene macro FAN_MARK_IGNORE_SURV is added for
(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY), because the
common case should use short constant names.

Link: https://lore.kernel.org/r/20220629144210.2983229-4-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/fanotify/fanotify.h      |  2 +
 fs/notify/fanotify/fanotify_user.c | 63 +++++++++++++++++++++++++-----
 include/linux/fanotify.h           |  5 ++-
 include/uapi/linux/fanotify.h      |  8 ++++
 4 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 80e0ec95b1131..1d9f11255c64f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -499,6 +499,8 @@ static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
 		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
 	if (mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF)
 		mflags |= FAN_MARK_EVICTABLE;
+	if (mark->flags & FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS)
+		mflags |= FAN_MARK_IGNORE;
 
 	return mflags;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 870db0f361f4c..879cd65b15187 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1005,7 +1005,7 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 	mask &= ~umask;
 	spin_lock(&fsn_mark->lock);
 	oldmask = fsnotify_calc_mask(fsn_mark);
-	if (!(flags & FAN_MARK_IGNORED_MASK)) {
+	if (!(flags & FANOTIFY_MARK_IGNORE_BITS)) {
 		fsn_mark->mask &= ~mask;
 	} else {
 		fsn_mark->ignore_mask &= ~mask;
@@ -1081,15 +1081,24 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 				       unsigned int fan_flags)
 {
 	bool want_iref = !(fan_flags & FAN_MARK_EVICTABLE);
+	unsigned int ignore = fan_flags & FANOTIFY_MARK_IGNORE_BITS;
 	bool recalc = false;
 
+	/*
+	 * When using FAN_MARK_IGNORE for the first time, mark starts using
+	 * independent event flags in ignore mask.  After that, trying to
+	 * update the ignore mask with the old FAN_MARK_IGNORED_MASK API
+	 * will result in EEXIST error.
+	 */
+	if (ignore == FAN_MARK_IGNORE)
+		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS;
+
 	/*
 	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
 	 * the removal of the FS_MODIFY bit in calculated mask if it was set
 	 * because of an ignore mask that is now going to survive FS_MODIFY.
 	 */
-	if ((fan_flags & FAN_MARK_IGNORED_MASK) &&
-	    (fan_flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
+	if (ignore && (fan_flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
 	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
 		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
 		if (!(fsn_mark->mask & FS_MODIFY))
@@ -1116,7 +1125,7 @@ static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 	bool recalc;
 
 	spin_lock(&fsn_mark->lock);
-	if (!(fan_flags & FAN_MARK_IGNORED_MASK))
+	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
 		fsn_mark->mask |= mask;
 	else
 		fsn_mark->ignore_mask |= mask;
@@ -1193,6 +1202,24 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
 		return -EEXIST;
 
+	/*
+	 * New ignore mask semantics cannot be downgraded to old semantics.
+	 */
+	if (fan_flags & FAN_MARK_IGNORED_MASK &&
+	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS)
+		return -EEXIST;
+
+	/*
+	 * An ignore mask that survives modify could never be downgraded to not
+	 * survive modify.  With new FAN_MARK_IGNORE semantics we make that rule
+	 * explicit and return an error when trying to update the ignore mask
+	 * without the original FAN_MARK_IGNORED_SURV_MODIFY value.
+	 */
+	if (fan_flags & FAN_MARK_IGNORE &&
+	    !(fan_flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
+	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
+		return -EEXIST;
+
 	return 0;
 }
 
@@ -1227,7 +1254,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	 * Error events are pre-allocated per group, only if strictly
 	 * needed (i.e. FAN_FS_ERROR was requested).
 	 */
-	if (!(fan_flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR)) {
+	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS) &&
+	    (mask & FAN_FS_ERROR)) {
 		ret = fanotify_group_init_error_pool(group);
 		if (ret)
 			goto out;
@@ -1271,7 +1299,7 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
 	 * an ignore mask, unless that ignore mask is supposed to survive
 	 * modification changes anyway.
 	 */
-	if ((flags & FAN_MARK_IGNORED_MASK) &&
+	if ((flags & FANOTIFY_MARK_IGNORE_BITS) &&
 	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
 	    inode_is_open_for_write(inode))
 		return 0;
@@ -1527,7 +1555,8 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
 	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
-				 (mask & FAN_RENAME);
+				 (mask & FAN_RENAME) ||
+				 (flags & FAN_MARK_IGNORE);
 
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
@@ -1579,7 +1608,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
-	bool ignore = flags & FAN_MARK_IGNORED_MASK;
+	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
 	unsigned int obj_type, fid_mode;
 	u32 umask = 0;
 	int ret;
@@ -1628,12 +1657,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & ~valid_mask)
 		return -EINVAL;
 
+
+	/* We don't allow FAN_MARK_IGNORE & FAN_MARK_IGNORED_MASK together */
+	if (ignore == (FAN_MARK_IGNORE | FAN_MARK_IGNORED_MASK))
+		return -EINVAL;
+
 	/*
 	 * Event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) have no effect with
 	 * FAN_MARK_IGNORED_MASK.
 	 */
-	if (ignore)
+	if (ignore == FAN_MARK_IGNORED_MASK) {
 		mask &= ~FANOTIFY_EVENT_FLAGS;
+		umask = FANOTIFY_EVENT_FLAGS;
+	}
 
 	f = fdget(fanotify_fd);
 	if (unlikely(!f.file))
@@ -1737,6 +1773,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	else
 		mnt = path.mnt;
 
+	ret = mnt ? -EINVAL : -EISDIR;
+	/* FAN_MARK_IGNORE requires SURV_MODIFY for sb/mount/dir marks */
+	if (mark_cmd == FAN_MARK_ADD && ignore == FAN_MARK_IGNORE &&
+	    (mnt || S_ISDIR(inode->i_mode)) &&
+	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY))
+		goto path_put_and_out;
+
 	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
 	if (mnt || !S_ISDIR(inode->i_mode)) {
 		mask &= ~FAN_EVENT_ON_CHILD;
@@ -1829,7 +1872,7 @@ static int __init fanotify_user_setup(void)
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 10);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index c9e185407ebcb..558844c8d2598 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -64,11 +64,14 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 #define FANOTIFY_MARK_CMD_BITS	(FAN_MARK_ADD | FAN_MARK_REMOVE | \
 				 FAN_MARK_FLUSH)
 
+#define FANOTIFY_MARK_IGNORE_BITS (FAN_MARK_IGNORED_MASK | \
+				   FAN_MARK_IGNORE)
+
 #define FANOTIFY_MARK_FLAGS	(FANOTIFY_MARK_TYPE_BITS | \
 				 FANOTIFY_MARK_CMD_BITS | \
+				 FANOTIFY_MARK_IGNORE_BITS | \
 				 FAN_MARK_DONT_FOLLOW | \
 				 FAN_MARK_ONLYDIR | \
-				 FAN_MARK_IGNORED_MASK | \
 				 FAN_MARK_IGNORED_SURV_MODIFY | \
 				 FAN_MARK_EVICTABLE)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index f1f89132d60e2..d8536d77fea1c 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -83,12 +83,20 @@
 #define FAN_MARK_FLUSH		0x00000080
 /* FAN_MARK_FILESYSTEM is	0x00000100 */
 #define FAN_MARK_EVICTABLE	0x00000200
+/* This bit is mutually exclusive with FAN_MARK_IGNORED_MASK bit */
+#define FAN_MARK_IGNORE		0x00000400
 
 /* These are NOT bitwise flags.  Both bits can be used togther.  */
 #define FAN_MARK_INODE		0x00000000
 #define FAN_MARK_MOUNT		0x00000010
 #define FAN_MARK_FILESYSTEM	0x00000100
 
+/*
+ * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
+ * for non-inode mark types.
+ */
+#define FAN_MARK_IGNORE_SURV	(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY)
+
 /* Deprecated - do not use this in programs and do not add new flags here! */
 #define FAN_ALL_MARK_FLAGS	(FAN_MARK_ADD |\
 				 FAN_MARK_REMOVE |\
-- 
2.43.0




