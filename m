Return-Path: <stable+bounces-50295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ECC90576D
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6231F28741
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B4017FAB7;
	Wed, 12 Jun 2024 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0VgobAHi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF181DDEB
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207507; cv=none; b=OVgG08d4IW2QC5LA8L51EhdqKEOyGHq7wJz1AYzWmxTP9hfkcNJUrqjZvNpFFr2o3cdz4vFg31SJ1fBTCoZngYNOJ1x9EyZCiogwuwz+PHLXSxMtZwOzVBCwIphyiNnK9377bTrFlkO89lkjX5jTZJd9HaWhV3xgRMfK/mjy6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207507; c=relaxed/simple;
	bh=tzfZ7ovOSnntQBtCgMfpspUFVvbCA/g/IGCqOBHsgfU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G92dKpsCHzmsU/77QHECAuWqZFnIj1l2YhZsLOXIiCvZgOtkl7F+lEQLQkO6Pe1vhPI1uJilKI/l+ig+gaYk3MzMSXpldSEghvyxpqoNYRnURP12R9VcK65ufBMgI9qZXNGLDmIWo2JVb7mK6yyzzqlJBjz3Fqa5suu2Q/LXjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0VgobAHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFFEC116B1;
	Wed, 12 Jun 2024 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718207506;
	bh=tzfZ7ovOSnntQBtCgMfpspUFVvbCA/g/IGCqOBHsgfU=;
	h=Subject:To:Cc:From:Date:From;
	b=0VgobAHifG5Vky5ZS5sdQO7lDtWfll2Zc0BpFgb6V2BWTU6/AhBp4DEHNgNGKh61V
	 Z8v5P9Y0zgGwAH4u9dWp0wRcwlYFYhKhyFKkgvgkzTjyhxZFWWRUpC15CENCtEpC+h
	 DSgAhJFY8vbJicz7hrbcfo14dmYVLljlcf0q+oqc=
Subject: FAILED: patch "[PATCH] proc: Move fdinfo PTRACE_MODE_READ check into the inode" failed to apply to 6.1-stable tree
To: code@tyhicks.com,apais@linux.microsoft.com,brauner@kernel.org,christian.koenig@amd.com,hargar@linux.microsoft.com,jannh@google.com,kaleshsingh@google.com,parsonskev@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 17:51:35 +0200
Message-ID: <2024061235-hatchet-upriver-8fa7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0a960ba49869ebe8ff859d000351504dd6b93b68
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061235-hatchet-upriver-8fa7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0a960ba49869 ("proc: Move fdinfo PTRACE_MODE_READ check into the inode .permission operation")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")
5d5bd24f4155 ("crypto: qat - implement dh fallback for primes > 4K")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a960ba49869ebe8ff859d000351504dd6b93b68 Mon Sep 17 00:00:00 2001
From: "Tyler Hicks (Microsoft)" <code@tyhicks.com>
Date: Tue, 30 Apr 2024 19:56:46 -0500
Subject: [PATCH] proc: Move fdinfo PTRACE_MODE_READ check into the inode
 .permission operation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following commits loosened the permissions of /proc/<PID>/fdinfo/
directory, as well as the files within it, from 0500 to 0555 while also
introducing a PTRACE_MODE_READ check between the current task and
<PID>'s task:

 - commit 7bc3fa0172a4 ("procfs: allow reading fdinfo with PTRACE_MODE_READ")
 - commit 1927e498aee1 ("procfs: prevent unprivileged processes accessing fdinfo dir")

Before those changes, inode based system calls like inotify_add_watch(2)
would fail when the current task didn't have sufficient read permissions:

 [...]
 lstat("/proc/1/task/1/fdinfo", {st_mode=S_IFDIR|0500, st_size=0, ...}) = 0
 inotify_add_watch(64, "/proc/1/task/1/fdinfo",
		   IN_MODIFY|IN_ATTRIB|IN_MOVED_FROM|IN_MOVED_TO|IN_CREATE|IN_DELETE|
		   IN_ONLYDIR|IN_DONT_FOLLOW|IN_EXCL_UNLINK) = -1 EACCES (Permission denied)
 [...]

This matches the documented behavior in the inotify_add_watch(2) man
page:

 ERRORS
       EACCES Read access to the given file is not permitted.

After those changes, inotify_add_watch(2) started succeeding despite the
current task not having PTRACE_MODE_READ privileges on the target task:

 [...]
 lstat("/proc/1/task/1/fdinfo", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
 inotify_add_watch(64, "/proc/1/task/1/fdinfo",
		   IN_MODIFY|IN_ATTRIB|IN_MOVED_FROM|IN_MOVED_TO|IN_CREATE|IN_DELETE|
		   IN_ONLYDIR|IN_DONT_FOLLOW|IN_EXCL_UNLINK) = 1757
 openat(AT_FDCWD, "/proc/1/task/1/fdinfo",
	O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = -1 EACCES (Permission denied)
 [...]

This change in behavior broke .NET prior to v7. See the github link
below for the v7 commit that inadvertently/quietly (?) fixed .NET after
the kernel changes mentioned above.

Return to the old behavior by moving the PTRACE_MODE_READ check out of
the file .open operation and into the inode .permission operation:

 [...]
 lstat("/proc/1/task/1/fdinfo", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
 inotify_add_watch(64, "/proc/1/task/1/fdinfo",
		   IN_MODIFY|IN_ATTRIB|IN_MOVED_FROM|IN_MOVED_TO|IN_CREATE|IN_DELETE|
		   IN_ONLYDIR|IN_DONT_FOLLOW|IN_EXCL_UNLINK) = -1 EACCES (Permission denied)
 [...]

Reported-by: Kevin Parsons (Microsoft) <parsonskev@gmail.com>
Link: https://github.com/dotnet/runtime/commit/89e5469ac591b82d38510fe7de98346cce74ad4f
Link: https://stackoverflow.com/questions/75379065/start-self-contained-net6-build-exe-as-service-on-raspbian-system-unauthorizeda
Fixes: 7bc3fa0172a4 ("procfs: allow reading fdinfo with PTRACE_MODE_READ")
Cc: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Hardik Garg <hargar@linux.microsoft.com>
Cc: Allen Pais <apais@linux.microsoft.com>
Signed-off-by: Tyler Hicks (Microsoft) <code@tyhicks.com>
Link: https://lore.kernel.org/r/20240501005646.745089-1-code@tyhicks.com
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 6e72e5ad42bc..f4b1c8b42a51 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -74,7 +74,18 @@ static int seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int proc_fdinfo_access_allowed(struct inode *inode)
+static int seq_fdinfo_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, seq_show, inode);
+}
+
+/**
+ * Shared /proc/pid/fdinfo and /proc/pid/fdinfo/fd permission helper to ensure
+ * that the current task has PTRACE_MODE_READ in addition to the normal
+ * POSIX-like checks.
+ */
+static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
+				  int mask)
 {
 	bool allowed = false;
 	struct task_struct *task = get_proc_task(inode);
@@ -88,18 +99,13 @@ static int proc_fdinfo_access_allowed(struct inode *inode)
 	if (!allowed)
 		return -EACCES;
 
-	return 0;
+	return generic_permission(idmap, inode, mask);
 }
 
-static int seq_fdinfo_open(struct inode *inode, struct file *file)
-{
-	int ret = proc_fdinfo_access_allowed(inode);
-
-	if (ret)
-		return ret;
-
-	return single_open(file, seq_show, inode);
-}
+static const struct inode_operations proc_fdinfo_file_inode_operations = {
+	.permission	= proc_fdinfo_permission,
+	.setattr	= proc_setattr,
+};
 
 static const struct file_operations proc_fdinfo_file_operations = {
 	.open		= seq_fdinfo_open,
@@ -388,6 +394,8 @@ static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
 	ei = PROC_I(inode);
 	ei->fd = data->fd;
 
+	inode->i_op = &proc_fdinfo_file_inode_operations;
+
 	inode->i_fop = &proc_fdinfo_file_operations;
 	tid_fd_update_inode(task, inode, 0);
 
@@ -407,23 +415,13 @@ static int proc_readfdinfo(struct file *file, struct dir_context *ctx)
 				  proc_fdinfo_instantiate);
 }
 
-static int proc_open_fdinfo(struct inode *inode, struct file *file)
-{
-	int ret = proc_fdinfo_access_allowed(inode);
-
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
+	.permission	= proc_fdinfo_permission,
 	.setattr	= proc_setattr,
 };
 
 const struct file_operations proc_fdinfo_operations = {
-	.open		= proc_open_fdinfo,
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_readfdinfo,
 	.llseek		= generic_file_llseek,


