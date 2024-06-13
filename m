Return-Path: <stable+bounces-51114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20684906E66
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37431F21CDC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6FF145FE8;
	Thu, 13 Jun 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVjTWwxs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5141448E0;
	Thu, 13 Jun 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280350; cv=none; b=Ghl0rX+Oxa7f6qT4eUAQe0Ww2c5nuZrc2qWaXu8PvGOng9pxclwNkrhN2YLTarFjyOC2DtrziIm4DXwTALn3h3U2Z9Y8S/HfPCTRpPc0oSKBnOjAabIr5jPwFwljtHKVnWv7sykHKXfLIBB/sX5t9dV78WJRlOd0SpVubMTwb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280350; c=relaxed/simple;
	bh=e6CkyU5nvuHL12HwWGwEVNj6+RSqEaZSO4KcTqkK0vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGdlSZHow7VE/c9XDL+w9aGSVAmU8u3odqSJA/4Xy6ZjubHOt93Q5RSHNVPlbGgTUJnRBdi/c30CKXg8OF4K2J1fRainjnit8rJQMMKkaGRpEMVOUUB/ENkqH6DHIYCiO65HqklRD31qSGWGSaIwJWh9xqxdjs8M2B35RexmNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVjTWwxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E086C2BBFC;
	Thu, 13 Jun 2024 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280350;
	bh=e6CkyU5nvuHL12HwWGwEVNj6+RSqEaZSO4KcTqkK0vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVjTWwxsXogPTtjTFE+hIkISKVpTDFTrIzg1CWEl5WopWwE1CpPFQdzaGe/JkhlXz
	 A8TpYvElLF05HPI+ZHDGJPba8vTA+B4oxwcF3daeo9UrIis5zN54ukUj7C23G4+QD+
	 7nE9cJT+CWgdAYirLI+NxEq3v1e7I6BRTBuTmF9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Kevin Parsons (Microsoft)" <parsonskev@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Hardik Garg <hargar@linux.microsoft.com>,
	Allen Pais <apais@linux.microsoft.com>,
	"Tyler Hicks (Microsoft)" <code@tyhicks.com>
Subject: [PATCH 6.6 024/137] proc: Move fdinfo PTRACE_MODE_READ check into the inode .permission operation
Date: Thu, 13 Jun 2024 13:33:24 +0200
Message-ID: <20240613113224.225430000@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyler Hicks (Microsoft) <code@tyhicks.com>

commit 0a960ba49869ebe8ff859d000351504dd6b93b68 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/fd.c |   42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -74,7 +74,18 @@ out:
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
@@ -88,18 +99,13 @@ static int proc_fdinfo_access_allowed(st
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
@@ -385,6 +391,8 @@ static struct dentry *proc_fdinfo_instan
 	ei = PROC_I(inode);
 	ei->fd = data->fd;
 
+	inode->i_op = &proc_fdinfo_file_inode_operations;
+
 	inode->i_fop = &proc_fdinfo_file_operations;
 	tid_fd_update_inode(task, inode, 0);
 
@@ -404,23 +412,13 @@ static int proc_readfdinfo(struct file *
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



