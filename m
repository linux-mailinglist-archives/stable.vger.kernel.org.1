Return-Path: <stable+bounces-53164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F4E90D07A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FBB1F21E7C
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05B156220;
	Tue, 18 Jun 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kEz82uoZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35304155C90;
	Tue, 18 Jun 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715517; cv=none; b=Kus61e9FDbQTUt6p5aza3ZcZdDvwqE322yo2p0OHGesBdq8IPeTuwvQwNgzh7/w/vUfsdivoWndd+2h+BjdycAf7UrKAyB9kS8M6dVamNhv7aW0lTE7qGc+/UqPvH9e5iJ7jxUDhsrbxkCdRJU6v2a/UBwihq64kkpjm8cmCn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715517; c=relaxed/simple;
	bh=zKZwCpBSS08olncw3euiUSKR994ddm6gk3GcoqGcOQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEEoKAVEAx+bg9D0mEoQiTFSjWlcA5usrR3olSnl//KW485+wdGoa2LFkz0JPAHzv7C398JKMqaHotzZt/Y46VH2+vZSdmzVmwXQLy+AzfGv+xnBGetqWU7kodh0L7Z74va26kVi1GHNnqXikDaSvXObiHGulXLYPEsAmDLjF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kEz82uoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D32C3277B;
	Tue, 18 Jun 2024 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715517;
	bh=zKZwCpBSS08olncw3euiUSKR994ddm6gk3GcoqGcOQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEz82uoZY2qME2mLXBy092prG9OSyBQYtljji8DKIcKNt5GlIWZfF5IgKPlNHwUp7
	 AcPIkiCNF8b7NvKGiQkKm07khKR1bdohQ4OWlHXfuC8SQPvjFUnms9/H7xirwQD/LQ
	 UzfgtbJkw1tEgpxfx5tfoDlpnHYuIOvp4tBLBKDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Bobrowski <repnop@google.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 335/770] fanotify: add pidfd support to the fanotify API
Date: Tue, 18 Jun 2024 14:33:08 +0200
Message-ID: <20240618123420.197717208@linuxfoundation.org>
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

From: Matthew Bobrowski <repnop@google.com>

[ Upstream commit af579beb666aefb17e9a335c12c788c92932baf1 ]

Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
allows userspace applications to control whether a pidfd information
record containing a pidfd is to be returned alongside the generic
event metadata for each event.

If FAN_REPORT_PIDFD is enabled for a notification group, an additional
struct fanotify_event_info_pidfd object type will be supplied
alongside the generic struct fanotify_event_metadata for a single
event. This functionality is analogous to that of FAN_REPORT_FID in
terms of how the event structure is supplied to a userspace
application. Usage of FAN_REPORT_PIDFD with
FAN_REPORT_FID/FAN_REPORT_DFID_NAME is permitted, and in this case a
struct fanotify_event_info_pidfd object will likely follow any struct
fanotify_event_info_fid object.

Currently, the usage of the FAN_REPORT_TID flag is not permitted along
with FAN_REPORT_PIDFD as the pidfd API currently only supports the
creation of pidfds for thread-group leaders. Additionally, usage of
the FAN_REPORT_PIDFD flag is limited to privileged processes only
i.e. event listeners that are running with the CAP_SYS_ADMIN
capability. Attempting to supply the FAN_REPORT_TID initialization
flags with FAN_REPORT_PIDFD or creating a notification group without
CAP_SYS_ADMIN will result with -EINVAL being returned to the caller.

In the event of a pidfd creation error, there are two types of error
values that can be reported back to the listener. There is
FAN_NOPIDFD, which will be reported in cases where the process
responsible for generating the event has terminated prior to the event
listener being able to read the event. Then there is FAN_EPIDFD, which
will be reported when a more generic pidfd creation error has occurred
when fanotify calls pidfd_create().

Link: https://lore.kernel.org/r/5f9e09cff7ed62bfaa51c1369e0f7ea5f16a91aa.1628398044.git.repnop@google.com
Signed-off-by: Matthew Bobrowski <repnop@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 85 ++++++++++++++++++++++++++++--
 include/linux/fanotify.h           |  3 +-
 include/uapi/linux/fanotify.h      | 13 +++++
 3 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 83405949a71b2..10fb062065b69 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fanotify.h>
 #include <linux/fcntl.h>
+#include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/anon_inodes.h>
@@ -106,6 +107,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
+#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+	sizeof(struct fanotify_event_info_pidfd)
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -138,6 +141,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
 		dot_len = 1;
 	}
 
+	if (info_mode & FAN_REPORT_PIDFD)
+		info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
+
 	if (fh_len)
 		info_len += fanotify_fid_info_len(fh_len, dot_len);
 
@@ -401,13 +407,34 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	return info_len;
 }
 
+static int copy_pidfd_info_to_user(int pidfd,
+				   char __user *buf,
+				   size_t count)
+{
+	struct fanotify_event_info_pidfd info = { };
+	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+
+	if (WARN_ON_ONCE(info_len > count))
+		return -EFAULT;
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_PIDFD;
+	info.hdr.len = info_len;
+	info.pidfd = pidfd;
+
+	if (copy_to_user(buf, &info, info_len))
+		return -EFAULT;
+
+	return info_len;
+}
+
 static int copy_info_records_to_user(struct fanotify_event *event,
 				     struct fanotify_info *info,
-				     unsigned int info_mode,
+				     unsigned int info_mode, int pidfd,
 				     char __user *buf, size_t count)
 {
 	int ret, total_bytes = 0, info_type = 0;
 	unsigned int fid_mode = info_mode & FANOTIFY_FID_BITS;
+	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
 
 	/*
 	 * Event info records order is as follows: dir fid + name, child fid.
@@ -478,6 +505,16 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (pidfd_mode) {
+		ret = copy_pidfd_info_to_user(pidfd, buf, count);
+		if (ret < 0)
+			return ret;
+
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
 	return total_bytes;
 }
 
@@ -489,8 +526,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	struct path *path = fanotify_event_path(event);
 	struct fanotify_info *info = fanotify_event_info(event);
 	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
+	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
 	struct file *f = NULL;
-	int ret, fd = FAN_NOFD;
+	int ret, pidfd = FAN_NOPIDFD, fd = FAN_NOFD;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -524,6 +562,33 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	}
 	metadata.fd = fd;
 
+	if (pidfd_mode) {
+		/*
+		 * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
+		 * exclusion is ever lifted. At the time of incoporating pidfd
+		 * support within fanotify, the pidfd API only supported the
+		 * creation of pidfds for thread-group leaders.
+		 */
+		WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
+
+		/*
+		 * The PIDTYPE_TGID check for an event->pid is performed
+		 * preemptively in an attempt to catch out cases where the event
+		 * listener reads events after the event generating process has
+		 * already terminated. Report FAN_NOPIDFD to the event listener
+		 * in those cases, with all other pidfd creation errors being
+		 * reported as FAN_EPIDFD.
+		 */
+		if (metadata.pid == 0 ||
+		    !pid_has_task(event->pid, PIDTYPE_TGID)) {
+			pidfd = FAN_NOPIDFD;
+		} else {
+			pidfd = pidfd_create(event->pid, 0);
+			if (pidfd < 0)
+				pidfd = FAN_EPIDFD;
+		}
+	}
+
 	ret = -EFAULT;
 	/*
 	 * Sanity check copy size in case get_one_event() and
@@ -542,7 +607,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		FANOTIFY_PERM(event)->fd = fd;
 
 	if (info_mode) {
-		ret = copy_info_records_to_user(event, info, info_mode,
+		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
 						buf, count);
 		if (ret < 0)
 			goto out_close_fd;
@@ -558,6 +623,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		put_unused_fd(fd);
 		fput(f);
 	}
+
+	if (pidfd >= 0)
+		close_fd(pidfd);
+
 	return ret;
 }
 
@@ -1103,6 +1172,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 #endif
 		return -EINVAL;
 
+	/*
+	 * A pidfd can only be returned for a thread-group leader; thus
+	 * FAN_REPORT_PIDFD and FAN_REPORT_TID need to remain mutually
+	 * exclusive.
+	 */
+	if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
+		return -EINVAL;
+
 	if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
 		return -EINVAL;
 
@@ -1522,7 +1599,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 10a7e26ddba6c..eec3b7c408115 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -27,7 +27,7 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 
 #define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
 
-#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS)
+#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
 
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
@@ -37,6 +37,7 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
  */
 #define FANOTIFY_ADMIN_INIT_FLAGS	(FANOTIFY_PERM_CLASSES | \
 					 FAN_REPORT_TID | \
+					 FAN_REPORT_PIDFD | \
 					 FAN_UNLIMITED_QUEUE | \
 					 FAN_UNLIMITED_MARKS)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index fbf9c5c7dd59a..64553df9d7350 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -51,6 +51,7 @@
 #define FAN_ENABLE_AUDIT	0x00000040
 
 /* Flags to determine fanotify event format */
+#define FAN_REPORT_PIDFD	0x00000080	/* Report pidfd for event->pid */
 #define FAN_REPORT_TID		0x00000100	/* event->pid is thread id */
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
@@ -123,6 +124,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_FID		1
 #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
 #define FAN_EVENT_INFO_TYPE_DFID	3
+#define FAN_EVENT_INFO_TYPE_PIDFD	4
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
@@ -148,6 +150,15 @@ struct fanotify_event_info_fid {
 	unsigned char handle[0];
 };
 
+/*
+ * This structure is used for info records of type FAN_EVENT_INFO_TYPE_PIDFD.
+ * It holds a pidfd for the pid that was responsible for generating an event.
+ */
+struct fanotify_event_info_pidfd {
+	struct fanotify_event_info_header hdr;
+	__s32 pidfd;
+};
+
 struct fanotify_response {
 	__s32 fd;
 	__u32 response;
@@ -160,6 +171,8 @@ struct fanotify_response {
 
 /* No fd set in event */
 #define FAN_NOFD	-1
+#define FAN_NOPIDFD	FAN_NOFD
+#define FAN_EPIDFD	-2
 
 /* Helper functions to deal with fanotify_event_metadata buffers */
 #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
-- 
2.43.0




