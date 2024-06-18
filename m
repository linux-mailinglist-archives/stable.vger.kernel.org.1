Return-Path: <stable+bounces-53237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F8890D0C8
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F351C23F94
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6018E744;
	Tue, 18 Jun 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mFHjxCAh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4913A877;
	Tue, 18 Jun 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715734; cv=none; b=hhQoXVHSrNvymxJCbk2ZQorpElAqXHTWLdJZRxBMUmSXvCU5jCgTpWC7QO/Sorajpj8FH2wDSn74ioKyqdbhhF8EikS49hoO84m+4AmGaiMVk3VUFTnxMqdiENmPH9pIBs/rp4M1h2GFCGh2xapmSq77eQ2m4kAGrtjcGkC0jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715734; c=relaxed/simple;
	bh=YSNs8DAUF2D+MecwZw5HKcKG4OSi5M0EZH5tVgX82rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwnQe0Z3RftfZD9N48gvIiCDGwxR60YAL7c57IrTCjDyWFbw4H0IpBBshISYFTPEb3YVtcEuP/ls43bW3mMnZcXZf9XEP0JjMD0lapRKSYaqdSuE14w4ZsHBTgMqJk71TVsovXN4qTMvCgnf1A1XMwrD8vd3XEu73p+Aj16vbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mFHjxCAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77013C3277B;
	Tue, 18 Jun 2024 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715733;
	bh=YSNs8DAUF2D+MecwZw5HKcKG4OSi5M0EZH5tVgX82rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFHjxCAhrsBoxmo/AZ9jdjBhSWV5+t0p4k2OVYGGuftxVwZlmbopaAluF2HStf523
	 u3GGGL2+/ohDtEe1CX3fIgCFV+jnTVm6L94ItlfOvn2n9HY04EMCuhoytGKNPCSTxZ
	 qTw++uBHLw6cdRz8QZXGK1N8eTg+to/DWX4Sx4Dg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 407/770] fanotify: introduce group flag FAN_REPORT_TARGET_FID
Date: Tue, 18 Jun 2024 14:34:20 +0200
Message-ID: <20240618123422.997660970@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit d61fd650e9d206a71fda789f02a1ced4b19944c4 ]

FAN_REPORT_FID is ambiguous in that it reports the fid of the child for
some events and the fid of the parent for create/delete/move events.

The new FAN_REPORT_TARGET_FID flag is an implicit request to report
the fid of the target object of the operation (a.k.a the child inode)
also in create/delete/move events in addition to the fid of the parent
and the name of the child.

To reduce the test matrix for uninteresting use cases, the new
FAN_REPORT_TARGET_FID flag requires both FAN_REPORT_NAME and
FAN_REPORT_FID.  The convenience macro FAN_REPORT_DFID_NAME_TARGET
combines FAN_REPORT_TARGET_FID with all the required flags.

Link: https://lore.kernel.org/r/20211129201537.1932819-4-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c      | 48 ++++++++++++++++++++++--------
 fs/notify/fanotify/fanotify_user.c | 11 ++++++-
 include/linux/fanotify.h           |  2 +-
 include/uapi/linux/fanotify.h      |  4 +++
 4 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 652fe84cb8acd..85e542b164c8c 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -458,17 +458,41 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 }
 
 /*
- * The inode to use as identifier when reporting fid depends on the event.
- * Report the modified directory inode on dirent modification events.
- * Report the "victim" inode otherwise.
+ * FAN_REPORT_FID is ambiguous in that it reports the fid of the child for
+ * some events and the fid of the parent for create/delete/move events.
+ *
+ * With the FAN_REPORT_TARGET_FID flag, the fid of the child is reported
+ * also in create/delete/move events in addition to the fid of the parent
+ * and the name of the child.
+ */
+static inline bool fanotify_report_child_fid(unsigned int fid_mode, u32 mask)
+{
+	if (mask & ALL_FSNOTIFY_DIRENT_EVENTS)
+		return (fid_mode & FAN_REPORT_TARGET_FID);
+
+	return (fid_mode & FAN_REPORT_FID) && !(mask & FAN_ONDIR);
+}
+
+/*
+ * The inode to use as identifier when reporting fid depends on the event
+ * and the group flags.
+ *
+ * With the group flag FAN_REPORT_TARGET_FID, always report the child fid.
+ *
+ * Without the group flag FAN_REPORT_TARGET_FID, report the modified directory
+ * fid on dirent events and the child fid otherwise.
+ *
  * For example:
- * FS_ATTRIB reports the child inode even if reported on a watched parent.
- * FS_CREATE reports the modified dir inode and not the created inode.
+ * FS_ATTRIB reports the child fid even if reported on a watched parent.
+ * FS_CREATE reports the modified dir fid without FAN_REPORT_TARGET_FID.
+ *       and reports the created child fid with FAN_REPORT_TARGET_FID.
  */
 static struct inode *fanotify_fid_inode(u32 event_mask, const void *data,
-					int data_type, struct inode *dir)
+					int data_type, struct inode *dir,
+					unsigned int fid_mode)
 {
-	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
+	if ((event_mask & ALL_FSNOTIFY_DIRENT_EVENTS) &&
+	    !(fid_mode & FAN_REPORT_TARGET_FID))
 		return dir;
 
 	return fsnotify_data_inode(data, data_type);
@@ -647,10 +671,11 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 {
 	struct fanotify_event *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
-	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
+	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir,
+					      fid_mode);
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
-	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct mem_cgroup *old_memcg;
 	struct inode *child = NULL;
 	bool name_event = false;
@@ -660,11 +685,10 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
-		 * With both flags FAN_REPORT_DIR_FID and FAN_REPORT_FID, we
-		 * report the child fid for events reported on a non-dir child
+		 * For certain events and group flags, report the child fid
 		 * in addition to reporting the parent fid and maybe child name.
 		 */
-		if ((fid_mode & FAN_REPORT_FID) && id != dirid && !ondir)
+		if (fanotify_report_child_fid(fid_mode, mask) && id != dirid)
 			child = id;
 
 		id = dirid;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 2f78999a7aa3d..6b058d652f47b 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1270,6 +1270,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if ((fid_mode & FAN_REPORT_NAME) && !(fid_mode & FAN_REPORT_DIR_FID))
 		return -EINVAL;
 
+	/*
+	 * FAN_REPORT_TARGET_FID requires FAN_REPORT_NAME and FAN_REPORT_FID
+	 * and is used as an indication to report both dir and child fid on all
+	 * dirent events.
+	 */
+	if ((fid_mode & FAN_REPORT_TARGET_FID) &&
+	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
+		return -EINVAL;
+
 	f_flags = O_RDWR | FMODE_NONOTIFY;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
@@ -1680,7 +1689,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 616af2ea20f30..376e050e6f384 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -25,7 +25,7 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 
 #define FANOTIFY_CLASS_BITS	(FAN_CLASS_NOTIF | FANOTIFY_PERM_CLASSES)
 
-#define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
+#define FANOTIFY_FID_BITS	(FAN_REPORT_DFID_NAME_TARGET)
 
 #define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index bd1932c2074d5..60f73639a896a 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -57,9 +57,13 @@
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
+#define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
+/* Convenience macro - FAN_REPORT_TARGET_FID requires all other FID flags */
+#define FAN_REPORT_DFID_NAME_TARGET (FAN_REPORT_DFID_NAME | \
+				     FAN_REPORT_FID | FAN_REPORT_TARGET_FID)
 
 /* Deprecated - do not use this in programs and do not add new flags here! */
 #define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
-- 
2.43.0




