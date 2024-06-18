Return-Path: <stable+bounces-53096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7738190D02C
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9078D1C23CBD
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B725E16C693;
	Tue, 18 Jun 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nSqKbig5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74519154444;
	Tue, 18 Jun 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715316; cv=none; b=g5IJPR657GKAPHhxqwXGO7vztENYmlH2Si4oGutCT+UrWFkkDFrmm4sVW4E/sahrZO+9hW+p7ZYQcKAsJdMVWu4eYy664ypxctBfFiCYS7hJe78kM4guWsjzZn/iC+BGaOq1Z6eJ/J5G+/V9LExR5qzBXN0/mmL7dJ1Q+GhTUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715316; c=relaxed/simple;
	bh=+cqdvtkxqieaQlWosEznKWHtGXO/v6cfBXN/e4eC1I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXl51AyNu2tKG1NC1cBrKZG1ufHYEbgKf1VChU91TYoa08inCPBfIwaUijL+18Z0562hN8+hSxSU1YFX0+p31FUWTx8wrbonnI1hr3ppqDs0uKrhycHKsbGWrcRn9HrlMFrrT5iKOJ/p0vBcb0XJCEHv6stfT0W4sV5pEnmLL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nSqKbig5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1695C3277B;
	Tue, 18 Jun 2024 12:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715316;
	bh=+cqdvtkxqieaQlWosEznKWHtGXO/v6cfBXN/e4eC1I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSqKbig5Nt1xdEl9CPVcbxAkdkzkLC5umtw/ivBDZCmrxe92qqI5HcOl60uqPWoPt
	 6P4GUoKWN/JUDU9DI2TkipZalVU47KP7u9yxyX2EXH7Slgc8960zy7BiccTCw5t0/y
	 8eB8YGCdNXrGhuDlz0x4yyqrQptzskBshd4PoyQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Bobrowski <repnop@google.com>,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	Stable@vger.kernel.org
Subject: [PATCH 5.10 267/770] fanotify: fix permission model of unprivileged group
Date: Tue, 18 Jun 2024 14:32:00 +0200
Message-ID: <20240618123417.578048922@linuxfoundation.org>
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

[ Upstream commit a8b98c808eab3ec8f1b5a64be967b0f4af4cae43 ]

Reporting event->pid should depend on the privileges of the user that
initialized the group, not the privileges of the user reading the
events.

Use an internal group flag FANOTIFY_UNPRIV to record the fact that the
group was initialized by an unprivileged user.

To be on the safe side, the premissions to setup filesystem and mount
marks now require that both the user that initialized the group and
the user setting up the mark have CAP_SYS_ADMIN.

Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiA77_P5vtv7e83g0+9d7B5W9ZTE4GfQEYbWmfT1rA=VA@mail.gmail.com/
Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
Cc: <Stable@vger.kernel.org> # v5.12+
Link: https://lore.kernel.org/r/20210524135321.2190062-1-amir73il@gmail.com
Reviewed-by: Matthew Bobrowski <repnop@google.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 30 ++++++++++++++++++++++++------
 fs/notify/fdinfo.c                 |  2 +-
 include/linux/fanotify.h           |  4 ++++
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 98289ace66fac..1c439e2fdcd80 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -424,11 +424,18 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	 * events generated by the listener process itself, without disclosing
 	 * the pids of other processes.
 	 */
-	if (!capable(CAP_SYS_ADMIN) &&
+	if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
 	    task_tgid(current) != event->pid)
 		metadata.pid = 0;
 
-	if (path && path->mnt && path->dentry) {
+	/*
+	 * For now, fid mode is required for an unprivileged listener and
+	 * fid mode does not report fd in events.  Keep this check anyway
+	 * for safety in case fid mode requirement is relaxed in the future
+	 * to allow unprivileged listener to get events with no fd and no fid.
+	 */
+	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
+	    path && path->mnt && path->dentry) {
 		fd = create_fd(group, path, &f);
 		if (fd < 0)
 			return fd;
@@ -1040,6 +1047,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	int f_flags, fd;
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
+	unsigned int internal_flags = 0;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -1053,6 +1061,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		 */
 		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) || !fid_mode)
 			return -EPERM;
+
+		/*
+		 * Setting the internal flag FANOTIFY_UNPRIV on the group
+		 * prevents setting mount/filesystem marks on this group and
+		 * prevents reporting pid and open fd in events.
+		 */
+		internal_flags |= FANOTIFY_UNPRIV;
 	}
 
 #ifdef CONFIG_AUDITSYSCALL
@@ -1105,7 +1120,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		goto out_destroy_group;
 	}
 
-	group->fanotify_data.flags = flags;
+	group->fanotify_data.flags = flags | internal_flags;
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
 	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
@@ -1323,11 +1338,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	group = f.file->private_data;
 
 	/*
-	 * An unprivileged user is not allowed to watch a mount point nor
-	 * a filesystem.
+	 * An unprivileged user is not allowed to setup mount nor filesystem
+	 * marks.  This also includes setting up such marks by a group that
+	 * was initialized by an unprivileged user.
 	 */
 	ret = -EPERM;
-	if (!capable(CAP_SYS_ADMIN) &&
+	if ((!capable(CAP_SYS_ADMIN) ||
+	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
 	    mark_type != FAN_MARK_INODE)
 		goto fput_and_out;
 
@@ -1478,6 +1495,7 @@ static int __init fanotify_user_setup(void)
 	max_marks = clamp(max_marks, FANOTIFY_OLD_DEFAULT_MAX_MARKS,
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
+	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 85b112bd88511..3451708fd035c 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -137,7 +137,7 @@ void fanotify_show_fdinfo(struct seq_file *m, struct file *f)
 	struct fsnotify_group *group = f->private_data;
 
 	seq_printf(m, "fanotify flags:%x event-flags:%x\n",
-		   group->fanotify_data.flags,
+		   group->fanotify_data.flags & FANOTIFY_INIT_FLAGS,
 		   group->fanotify_data.f_flags);
 
 	show_fdinfo(m, f, fanotify_fdinfo);
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index bad41bcb25dfb..a16dbeced1528 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -51,6 +51,10 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
 				 FANOTIFY_USER_INIT_FLAGS)
 
+/* Internal group flags */
+#define FANOTIFY_UNPRIV		0x80000000
+#define FANOTIFY_INTERNAL_GROUP_FLAGS	(FANOTIFY_UNPRIV)
+
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
 				 FAN_MARK_FILESYSTEM)
 
-- 
2.43.0




