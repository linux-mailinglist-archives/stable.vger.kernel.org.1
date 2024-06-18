Return-Path: <stable+bounces-53163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F1D90D078
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC321C23639
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C72155C98;
	Tue, 18 Jun 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZI/SrhYv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E518040;
	Tue, 18 Jun 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715514; cv=none; b=qL0UVUPh1D3SEaqCUSHnsfVIOoCleoAn52+j9M4hHNCBFdOLjaEdNn0rFPpMxoBrmlgiyyYkiwauL0w1g2bWE0fnZInc2+xKIHxhvCAaWEkzL5rs5wHj0kRWQiPcE9U+yS2Pf08kzQkfARVHxF18OVXfUI9zael9XE+n5k4lIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715514; c=relaxed/simple;
	bh=yk8NndeLNMq100oiYxrVE0AWBtw9zD2CDysgU6Ger3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWhKjLDEEP0uq2yEH2m4lTEguNoYBSVqjGNcjLxHzMC4z/aCJzxk4z+at8usRT1v+IAI5ufbcAAfJ/pVXLrpz3SiDNRK8mmWEdKt3K91w2meLwmvzei0Ya2WXD5C5abK6nl7IKCoN7yb0XeinBMM/NsQtEvdiFQf3M0EavYoEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZI/SrhYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF7AC3277B;
	Tue, 18 Jun 2024 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715514;
	bh=yk8NndeLNMq100oiYxrVE0AWBtw9zD2CDysgU6Ger3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZI/SrhYvTupje+Fe9zwIPi1OckUKoDVzLAyTUF5IceZBgCEB/h0b7xcrVLkT7leYp
	 xUTDfgc3LkfCgI2qsn0C8Ze/tgYoOs72TaBxPAqXIifQqp61S1b9iNmcZ7Pr1BJ9RK
	 dEY2vydmg/WLjR+zTsZSkFhIdzXmXMysL5cn9Zwk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Bobrowski <repnop@google.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 334/770] fanotify: introduce a generic info record copying helper
Date: Tue, 18 Jun 2024 14:33:07 +0200
Message-ID: <20240618123420.159717712@linuxfoundation.org>
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

[ Upstream commit 0aca67bb7f0d8c997dfef8ff0bfeb0afb361f0e6 ]

The copy_info_records_to_user() helper allows for the separation of
info record copying routines/conditionals from copy_event_to_user(),
which reduces the overall clutter within this function. This becomes
especially true as we start introducing additional info records in the
future i.e. struct fanotify_event_info_pidfd. On success, this helper
returns the total amount of bytes that have been copied into the user
supplied buffer and on error, a negative value is returned to the
caller.

The newly defined macro FANOTIFY_INFO_MODES can be used to obtain info
record types that have been enabled for a specific notification
group. This macro becomes useful in the subsequent patch when the
FAN_REPORT_PIDFD initialization flag is introduced.

Link: https://lore.kernel.org/r/8872947dfe12ce8ae6e9a7f2d49ea29bc8006af0.1628398044.git.repnop@google.com
Signed-off-by: Matthew Bobrowski <repnop@google.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[ cel: adjusted to apply to v5.10.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 151 ++++++++++++++++-------------
 include/linux/fanotify.h           |   2 +
 2 files changed, 88 insertions(+), 65 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 74b51dab2cdce..83405949a71b2 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -173,7 +173,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	size_t event_size = FAN_EVENT_METADATA_LEN;
 	struct fanotify_event *event = NULL;
 	struct fsnotify_event *fsn_event;
-	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
 
 	pr_debug("%s: group=%p count=%zd\n", __func__, group, count);
 
@@ -183,8 +183,8 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 		goto out;
 
 	event = FANOTIFY_E(fsn_event);
-	if (fid_mode)
-		event_size += fanotify_event_info_len(fid_mode, event);
+	if (info_mode)
+		event_size += fanotify_event_info_len(info_mode, event);
 
 	if (event_size > count) {
 		event = ERR_PTR(-EINVAL);
@@ -401,68 +401,17 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	return info_len;
 }
 
-static ssize_t copy_event_to_user(struct fsnotify_group *group,
-				  struct fanotify_event *event,
-				  char __user *buf, size_t count)
+static int copy_info_records_to_user(struct fanotify_event *event,
+				     struct fanotify_info *info,
+				     unsigned int info_mode,
+				     char __user *buf, size_t count)
 {
-	struct fanotify_event_metadata metadata;
-	struct path *path = fanotify_event_path(event);
-	struct fanotify_info *info = fanotify_event_info(event);
-	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-	struct file *f = NULL;
-	int ret, fd = FAN_NOFD;
-	int info_type = 0;
-
-	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
-
-	metadata.event_len = FAN_EVENT_METADATA_LEN +
-				fanotify_event_info_len(fid_mode, event);
-	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
-	metadata.vers = FANOTIFY_METADATA_VERSION;
-	metadata.reserved = 0;
-	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
-	metadata.pid = pid_vnr(event->pid);
-	/*
-	 * For an unprivileged listener, event->pid can be used to identify the
-	 * events generated by the listener process itself, without disclosing
-	 * the pids of other processes.
-	 */
-	if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
-	    task_tgid(current) != event->pid)
-		metadata.pid = 0;
-
-	/*
-	 * For now, fid mode is required for an unprivileged listener and
-	 * fid mode does not report fd in events.  Keep this check anyway
-	 * for safety in case fid mode requirement is relaxed in the future
-	 * to allow unprivileged listener to get events with no fd and no fid.
-	 */
-	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
-	    path && path->mnt && path->dentry) {
-		fd = create_fd(group, path, &f);
-		if (fd < 0)
-			return fd;
-	}
-	metadata.fd = fd;
+	int ret, total_bytes = 0, info_type = 0;
+	unsigned int fid_mode = info_mode & FANOTIFY_FID_BITS;
 
-	ret = -EFAULT;
 	/*
-	 * Sanity check copy size in case get_one_event() and
-	 * event_len sizes ever get out of sync.
+	 * Event info records order is as follows: dir fid + name, child fid.
 	 */
-	if (WARN_ON_ONCE(metadata.event_len > count))
-		goto out_close_fd;
-
-	if (copy_to_user(buf, &metadata, FAN_EVENT_METADATA_LEN))
-		goto out_close_fd;
-
-	buf += FAN_EVENT_METADATA_LEN;
-	count -= FAN_EVENT_METADATA_LEN;
-
-	if (fanotify_is_perm_event(event->mask))
-		FANOTIFY_PERM(event)->fd = fd;
-
-	/* Event info records order is: dir fid + name, child fid */
 	if (fanotify_event_dir_fh_len(event)) {
 		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
 					     FAN_EVENT_INFO_TYPE_DFID;
@@ -472,10 +421,11 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 					    fanotify_info_name(info),
 					    info->name_len, buf, count);
 		if (ret < 0)
-			goto out_close_fd;
+			return ret;
 
 		buf += ret;
 		count -= ret;
+		total_bytes += ret;
 	}
 
 	if (fanotify_event_object_fh_len(event)) {
@@ -492,8 +442,8 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 			   (event->mask & FAN_ONDIR)) {
 			/*
 			 * With group flag FAN_REPORT_NAME, if name was not
-			 * recorded in an event on a directory, report the
-			 * name "." with info type DFID_NAME.
+			 * recorded in an event on a directory, report the name
+			 * "." with info type DFID_NAME.
 			 */
 			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
 			dot = ".";
@@ -521,10 +471,81 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 					    info_type, dot, dot_len,
 					    buf, count);
 		if (ret < 0)
-			goto out_close_fd;
+			return ret;
 
 		buf += ret;
 		count -= ret;
+		total_bytes += ret;
+	}
+
+	return total_bytes;
+}
+
+static ssize_t copy_event_to_user(struct fsnotify_group *group,
+				  struct fanotify_event *event,
+				  char __user *buf, size_t count)
+{
+	struct fanotify_event_metadata metadata;
+	struct path *path = fanotify_event_path(event);
+	struct fanotify_info *info = fanotify_event_info(event);
+	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
+	struct file *f = NULL;
+	int ret, fd = FAN_NOFD;
+
+	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
+
+	metadata.event_len = FAN_EVENT_METADATA_LEN +
+				fanotify_event_info_len(info_mode, event);
+	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
+	metadata.vers = FANOTIFY_METADATA_VERSION;
+	metadata.reserved = 0;
+	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
+	metadata.pid = pid_vnr(event->pid);
+	/*
+	 * For an unprivileged listener, event->pid can be used to identify the
+	 * events generated by the listener process itself, without disclosing
+	 * the pids of other processes.
+	 */
+	if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
+	    task_tgid(current) != event->pid)
+		metadata.pid = 0;
+
+	/*
+	 * For now, fid mode is required for an unprivileged listener and
+	 * fid mode does not report fd in events.  Keep this check anyway
+	 * for safety in case fid mode requirement is relaxed in the future
+	 * to allow unprivileged listener to get events with no fd and no fid.
+	 */
+	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
+	    path && path->mnt && path->dentry) {
+		fd = create_fd(group, path, &f);
+		if (fd < 0)
+			return fd;
+	}
+	metadata.fd = fd;
+
+	ret = -EFAULT;
+	/*
+	 * Sanity check copy size in case get_one_event() and
+	 * event_len sizes ever get out of sync.
+	 */
+	if (WARN_ON_ONCE(metadata.event_len > count))
+		goto out_close_fd;
+
+	if (copy_to_user(buf, &metadata, FAN_EVENT_METADATA_LEN))
+		goto out_close_fd;
+
+	buf += FAN_EVENT_METADATA_LEN;
+	count -= FAN_EVENT_METADATA_LEN;
+
+	if (fanotify_is_perm_event(event->mask))
+		FANOTIFY_PERM(event)->fd = fd;
+
+	if (info_mode) {
+		ret = copy_info_records_to_user(event, info, info_mode,
+						buf, count);
+		if (ret < 0)
+			goto out_close_fd;
 	}
 
 	if (f)
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index a16dbeced1528..10a7e26ddba6c 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -27,6 +27,8 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 
 #define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
 
+#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS)
+
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
  * We do not allow unprivileged groups to request permission events.
-- 
2.43.0




