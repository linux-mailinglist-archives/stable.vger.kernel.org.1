Return-Path: <stable+bounces-53083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9605E90D24E
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F16B2D33A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A14153BFC;
	Tue, 18 Jun 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LuKB6nWc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BBE15383C;
	Tue, 18 Jun 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715278; cv=none; b=gEemqtqhsWkubVjDjm0VhOZeyVfs/0kqYmy43UxgyoQ2S6tWBVkkyMyvYLn1Zgv6dh4uH+SQCkMyQjdyVpQmr2QTdx2dH1zOBvXNzaGS/lstnTJKhQUZyKLP42/h1vv26Yy33a16zZzNavp0WZfecN00TFuszU1mFH73Eqkob4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715278; c=relaxed/simple;
	bh=g8L9rbvYakDTk3b6VFIelxZfP1tw3cw35DMS4GKCLos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJs7ouzN6UPexopxpkJs5qOnXuCi5tTH78AA/9h5MvXzzLEZzcNRr/F+UBd8NkYhp10+ur4/NU7FR0/ZKGGUZemTltLPIRe3BJoYoifRHJX/6Uukjr/vDKuLrUTX3RCXrBN6lTFZLMpRoLQGzZKuuZ2Pa3uArF2nNYxJ0ncC/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LuKB6nWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E65C32786;
	Tue, 18 Jun 2024 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715277;
	bh=g8L9rbvYakDTk3b6VFIelxZfP1tw3cw35DMS4GKCLos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LuKB6nWc1c4hulP34//lON4lHZhDumbVu3MYdZi57lKDjGrfVYfKDFtduYKEvylGk
	 JwSRkU1DA6fgem+l2va66S2RZcY6pudu+LuIfbN5CLR9hhmOfjjB/oC9oNvmMrpAhg
	 1D0tj2s1HinAMVmPcl9ytDf012nPrOsVWMgbEswE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 255/770] fanotify: configurable limits via sysfs
Date: Tue, 18 Jun 2024 14:31:48 +0200
Message-ID: <20240618123417.118303878@linuxfoundation.org>
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

[ Upstream commit 5b8fea65d197f408bb00b251c70d842826d6b70b ]

fanotify has some hardcoded limits. The only APIs to escape those limits
are FAN_UNLIMITED_QUEUE and FAN_UNLIMITED_MARKS.

Allow finer grained tuning of the system limits via sysfs tunables under
/proc/sys/fs/fanotify, similar to tunables under /proc/sys/fs/inotify,
with some minor differences.

- max_queued_events - global system tunable for group queue size limit.
  Like the inotify tunable with the same name, it defaults to 16384 and
  applies on initialization of a new group.

- max_user_marks - user ns tunable for marks limit per user.
  Like the inotify tunable named max_user_watches, on a machine with
  sufficient RAM and it defaults to 1048576 in init userns and can be
  further limited per containing user ns.

- max_user_groups - user ns tunable for number of groups per user.
  Like the inotify tunable named max_user_instances, it defaults to 128
  in init userns and can be further limited per containing user ns.

The slightly different tunable names used for fanotify are derived from
the "group" and "mark" terminology used in the fanotify man pages and
throughout the code.

Considering the fact that the default value for max_user_instances was
increased in kernel v5.10 from 8192 to 1048576, leaving the legacy
fanotify limit of 8192 marks per group in addition to the max_user_marks
limit makes little sense, so the per group marks limit has been removed.

Note that when a group is initialized with FAN_UNLIMITED_MARKS, its own
marks are not accounted in the per user marks account, so in effect the
limit of max_user_marks is only for the collection of groups that are
not initialized with FAN_UNLIMITED_MARKS.

Link: https://lore.kernel.org/r/20210304112921.3996419-2-amir73il@gmail.com
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c      |  16 ++--
 fs/notify/fanotify/fanotify_user.c | 123 ++++++++++++++++++++++++-----
 fs/notify/group.c                  |   1 -
 fs/notify/mark.c                   |   4 -
 include/linux/fanotify.h           |   3 +
 include/linux/fsnotify_backend.h   |   6 +-
 include/linux/sched/user.h         |   3 -
 include/linux/user_namespace.h     |   4 +
 kernel/sysctl.c                    |  12 ++-
 kernel/ucount.c                    |   4 +
 10 files changed, 137 insertions(+), 39 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 754e27ead8742..057abd2cf8875 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -801,12 +801,10 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 
 static void fanotify_free_group_priv(struct fsnotify_group *group)
 {
-	struct user_struct *user;
-
 	kfree(group->fanotify_data.merge_hash);
-	user = group->fanotify_data.user;
-	atomic_dec(&user->fanotify_listeners);
-	free_uid(user);
+	if (group->fanotify_data.ucounts)
+		dec_ucount(group->fanotify_data.ucounts,
+			   UCOUNT_FANOTIFY_GROUPS);
 }
 
 static void fanotify_free_path_event(struct fanotify_event *event)
@@ -862,6 +860,13 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
 	}
 }
 
+static void fanotify_freeing_mark(struct fsnotify_mark *mark,
+				  struct fsnotify_group *group)
+{
+	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS))
+		dec_ucount(group->fanotify_data.ucounts, UCOUNT_FANOTIFY_MARKS);
+}
+
 static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
 {
 	kmem_cache_free(fanotify_mark_cache, fsn_mark);
@@ -871,5 +876,6 @@ const struct fsnotify_ops fanotify_fsnotify_ops = {
 	.handle_event = fanotify_handle_event,
 	.free_group_priv = fanotify_free_group_priv,
 	.free_event = fanotify_free_event,
+	.freeing_mark = fanotify_freeing_mark,
 	.free_mark = fanotify_free_mark,
 };
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 1456470d0c4c6..74b4da6354e1c 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -27,8 +27,61 @@
 #include "fanotify.h"
 
 #define FANOTIFY_DEFAULT_MAX_EVENTS	16384
-#define FANOTIFY_DEFAULT_MAX_MARKS	8192
-#define FANOTIFY_DEFAULT_MAX_LISTENERS	128
+#define FANOTIFY_OLD_DEFAULT_MAX_MARKS	8192
+#define FANOTIFY_DEFAULT_MAX_GROUPS	128
+
+/*
+ * Legacy fanotify marks limits (8192) is per group and we introduced a tunable
+ * limit of marks per user, similar to inotify.  Effectively, the legacy limit
+ * of fanotify marks per user is <max marks per group> * <max groups per user>.
+ * This default limit (1M) also happens to match the increased limit of inotify
+ * max_user_watches since v5.10.
+ */
+#define FANOTIFY_DEFAULT_MAX_USER_MARKS	\
+	(FANOTIFY_OLD_DEFAULT_MAX_MARKS * FANOTIFY_DEFAULT_MAX_GROUPS)
+
+/*
+ * Most of the memory cost of adding an inode mark is pinning the marked inode.
+ * The size of the filesystem inode struct is not uniform across filesystems,
+ * so double the size of a VFS inode is used as a conservative approximation.
+ */
+#define INODE_MARK_COST	(2 * sizeof(struct inode))
+
+/* configurable via /proc/sys/fs/fanotify/ */
+static int fanotify_max_queued_events __read_mostly;
+
+#ifdef CONFIG_SYSCTL
+
+#include <linux/sysctl.h>
+
+struct ctl_table fanotify_table[] = {
+	{
+		.procname	= "max_user_groups",
+		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+	{
+		.procname	= "max_user_marks",
+		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS],
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+	{
+		.procname	= "max_queued_events",
+		.data		= &fanotify_max_queued_events,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO
+	},
+	{ }
+};
+#endif /* CONFIG_SYSCTL */
 
 /*
  * All flags that may be specified in parameter event_f_flags of fanotify_init.
@@ -847,24 +900,38 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   unsigned int type,
 						   __kernel_fsid_t *fsid)
 {
+	struct ucounts *ucounts = group->fanotify_data.ucounts;
 	struct fsnotify_mark *mark;
 	int ret;
 
-	if (atomic_read(&group->num_marks) > group->fanotify_data.max_marks)
+	/*
+	 * Enforce per user marks limits per user in all containing user ns.
+	 * A group with FAN_UNLIMITED_MARKS does not contribute to mark count
+	 * in the limited groups account.
+	 */
+	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS) &&
+	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
 		return ERR_PTR(-ENOSPC);
 
 	mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
-	if (!mark)
-		return ERR_PTR(-ENOMEM);
+	if (!mark) {
+		ret = -ENOMEM;
+		goto out_dec_ucounts;
+	}
 
 	fsnotify_init_mark(mark, group);
 	ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
-		return ERR_PTR(ret);
+		goto out_dec_ucounts;
 	}
 
 	return mark;
+
+out_dec_ucounts:
+	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS))
+		dec_ucount(ucounts, UCOUNT_FANOTIFY_MARKS);
+	return ERR_PTR(ret);
 }
 
 
@@ -963,7 +1030,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 {
 	struct fsnotify_group *group;
 	int f_flags, fd;
-	struct user_struct *user;
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 
@@ -1002,12 +1068,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if ((fid_mode & FAN_REPORT_NAME) && !(fid_mode & FAN_REPORT_DIR_FID))
 		return -EINVAL;
 
-	user = get_current_user();
-	if (atomic_read(&user->fanotify_listeners) > FANOTIFY_DEFAULT_MAX_LISTENERS) {
-		free_uid(user);
-		return -EMFILE;
-	}
-
 	f_flags = O_RDWR | FMODE_NONOTIFY;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
@@ -1017,13 +1077,19 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
 	group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops);
 	if (IS_ERR(group)) {
-		free_uid(user);
 		return PTR_ERR(group);
 	}
 
-	group->fanotify_data.user = user;
+	/* Enforce groups limits per user in all containing user ns */
+	group->fanotify_data.ucounts = inc_ucount(current_user_ns(),
+						  current_euid(),
+						  UCOUNT_FANOTIFY_GROUPS);
+	if (!group->fanotify_data.ucounts) {
+		fd = -EMFILE;
+		goto out_destroy_group;
+	}
+
 	group->fanotify_data.flags = flags;
-	atomic_inc(&user->fanotify_listeners);
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
 	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
@@ -1064,16 +1130,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 			goto out_destroy_group;
 		group->max_events = UINT_MAX;
 	} else {
-		group->max_events = FANOTIFY_DEFAULT_MAX_EVENTS;
+		group->max_events = fanotify_max_queued_events;
 	}
 
 	if (flags & FAN_UNLIMITED_MARKS) {
 		fd = -EPERM;
 		if (!capable(CAP_SYS_ADMIN))
 			goto out_destroy_group;
-		group->fanotify_data.max_marks = UINT_MAX;
-	} else {
-		group->fanotify_data.max_marks = FANOTIFY_DEFAULT_MAX_MARKS;
 	}
 
 	if (flags & FAN_ENABLE_AUDIT) {
@@ -1375,6 +1438,21 @@ SYSCALL32_DEFINE6(fanotify_mark,
  */
 static int __init fanotify_user_setup(void)
 {
+	struct sysinfo si;
+	int max_marks;
+
+	si_meminfo(&si);
+	/*
+	 * Allow up to 1% of addressable memory to be accounted for per user
+	 * marks limited to the range [8192, 1048576]. mount and sb marks are
+	 * a lot cheaper than inode marks, but there is no reason for a user
+	 * to have many of those, so calculate by the cost of inode marks.
+	 */
+	max_marks = (((si.totalram - si.totalhigh) / 100) << PAGE_SHIFT) /
+		    INODE_MARK_COST;
+	max_marks = clamp(max_marks, FANOTIFY_OLD_DEFAULT_MAX_MARKS,
+				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
+
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
@@ -1389,6 +1467,11 @@ static int __init fanotify_user_setup(void)
 			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
 	}
 
+	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
+	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =
+					FANOTIFY_DEFAULT_MAX_GROUPS;
+	init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS] = max_marks;
+
 	return 0;
 }
 device_initcall(fanotify_user_setup);
diff --git a/fs/notify/group.c b/fs/notify/group.c
index ffd723ffe46de..fb89c351295d6 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -122,7 +122,6 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 
 	/* set to 0 when there a no external references to this group */
 	refcount_set(&group->refcnt, 1);
-	atomic_set(&group->num_marks, 0);
 	atomic_set(&group->user_waits, 0);
 
 	spin_lock_init(&group->notification_lock);
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 5b44be5f93dd8..7af98a7c33c27 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -391,8 +391,6 @@ void fsnotify_detach_mark(struct fsnotify_mark *mark)
 	list_del_init(&mark->g_list);
 	spin_unlock(&mark->lock);
 
-	atomic_dec(&group->num_marks);
-
 	/* Drop mark reference acquired in fsnotify_add_mark_locked() */
 	fsnotify_put_mark(mark);
 }
@@ -656,7 +654,6 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	mark->flags |= FSNOTIFY_MARK_FLAG_ALIVE | FSNOTIFY_MARK_FLAG_ATTACHED;
 
 	list_add(&mark->g_list, &group->marks_list);
-	atomic_inc(&group->num_marks);
 	fsnotify_get_mark(mark); /* for g_list */
 	spin_unlock(&mark->lock);
 
@@ -674,7 +671,6 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 			 FSNOTIFY_MARK_FLAG_ATTACHED);
 	list_del_init(&mark->g_list);
 	spin_unlock(&mark->lock);
-	atomic_dec(&group->num_marks);
 
 	fsnotify_put_mark(mark);
 	return ret;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 3e9c56ee651f7..031a97d8369ae 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -2,8 +2,11 @@
 #ifndef _LINUX_FANOTIFY_H
 #define _LINUX_FANOTIFY_H
 
+#include <linux/sysctl.h>
 #include <uapi/linux/fanotify.h>
 
+extern struct ctl_table fanotify_table[]; /* for sysctl */
+
 #define FAN_GROUP_FLAG(group, flag) \
 	((group)->fanotify_data.flags & (flag))
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 63fb766f0f3ec..1ce66748a2d29 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -206,9 +206,6 @@ struct fsnotify_group {
 
 	/* stores all fastpath marks assoc with this group so they can be cleaned on unregister */
 	struct mutex mark_mutex;	/* protect marks_list */
-	atomic_t num_marks;		/* 1 for each mark and 1 for not being
-					 * past the point of no return when freeing
-					 * a group */
 	atomic_t user_waits;		/* Number of tasks waiting for user
 					 * response */
 	struct list_head marks_list;	/* all inode marks for this group */
@@ -240,8 +237,7 @@ struct fsnotify_group {
 			wait_queue_head_t access_waitq;
 			int flags;           /* flags from fanotify_init() */
 			int f_flags; /* event_f_flags from fanotify_init() */
-			unsigned int max_marks;
-			struct user_struct *user;
+			struct ucounts *ucounts;
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index a8ec3b6093fcb..3632c5d6ec559 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -14,9 +14,6 @@ struct user_struct {
 	refcount_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t sigpending;	/* How many pending signals does this user have? */
-#ifdef CONFIG_FANOTIFY
-	atomic_t fanotify_listeners;
-#endif
 #ifdef CONFIG_EPOLL
 	atomic_long_t epoll_watches; /* The number of file descriptors currently watched */
 #endif
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 7616c7bf4b241..0793951867aef 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -49,6 +49,10 @@ enum ucount_type {
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_INOTIFY_INSTANCES,
 	UCOUNT_INOTIFY_WATCHES,
+#endif
+#ifdef CONFIG_FANOTIFY
+	UCOUNT_FANOTIFY_GROUPS,
+	UCOUNT_FANOTIFY_MARKS,
 #endif
 	UCOUNT_COUNTS,
 };
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 99a19190196e0..b29a9568ebbe4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -142,6 +142,9 @@ static unsigned long hung_task_timeout_max = (LONG_MAX/HZ);
 #ifdef CONFIG_INOTIFY_USER
 #include <linux/inotify.h>
 #endif
+#ifdef CONFIG_FANOTIFY
+#include <linux/fanotify.h>
+#endif
 
 #ifdef CONFIG_PROC_SYSCTL
 
@@ -3330,7 +3333,14 @@ static struct ctl_table fs_table[] = {
 		.mode		= 0555,
 		.child		= inotify_table,
 	},
-#endif	
+#endif
+#ifdef CONFIG_FANOTIFY
+	{
+		.procname	= "fanotify",
+		.mode		= 0555,
+		.child		= fanotify_table,
+	},
+#endif
 #ifdef CONFIG_EPOLL
 	{
 		.procname	= "epoll",
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 11b1596e2542a..8d8874f1c35e2 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -73,6 +73,10 @@ static struct ctl_table user_table[] = {
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_ENTRY("max_inotify_instances"),
 	UCOUNT_ENTRY("max_inotify_watches"),
+#endif
+#ifdef CONFIG_FANOTIFY
+	UCOUNT_ENTRY("max_fanotify_groups"),
+	UCOUNT_ENTRY("max_fanotify_marks"),
 #endif
 	{ }
 };
-- 
2.43.0




