Return-Path: <stable+bounces-23177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D8185DFA4
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1F8283A60
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFCD54F93;
	Wed, 21 Feb 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dIvBbcOo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13E566A;
	Wed, 21 Feb 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525813; cv=none; b=IOimTLoBXrW1Qp2eAnUR7beQwIOwDcRMUi6GJCpG8lb6exdtMLXsBOCpDWLRbwbhZ4n6lMVvORbdxxDGn0p+grFpsPrpJUyjaziIQ5JkN904LJ8v3MoOe0HeUs4BIPryW4pd8lXlCYnGgPTYOFemsQBkftDi8iAaK7skwFlzJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525813; c=relaxed/simple;
	bh=iN4p/SeO/BnOxQQyPMBsdVJXdWy6w7YAX1dbsvv9KCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHTxDrWMUoRVFiPejChHe6KkZdlVVGu9mn1k4XCp3yrDO70sboQrmFE7Gps9U1+tx+suB1CsTka9tVfXrqm/AbXYRnrbJjDbLau3aKXNJH8na67kR3vglHYzyWNL02CTQmivAg0ZBwNRg6d/7BD8JtFFZYaqilIkhMB2m6X5tbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dIvBbcOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45452C433F1;
	Wed, 21 Feb 2024 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525813;
	bh=iN4p/SeO/BnOxQQyPMBsdVJXdWy6w7YAX1dbsvv9KCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIvBbcOo+bseXms30u6PQeGBLKQlslaxi4OlyUkQ4urKakAQ0/3siLxwLDKw7l5me
	 Yc9BTwn6AIEFStqdzFjCWN8KEHL9WG5luEAqSlYgS0NsbW5fOHi5S2B8R4StuRLM6V
	 PVQl9EqV1HcSQqLrE8CwHe1br1YNsjRj0Nsur9fE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alfred Piccioni <alpic@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH 5.4 262/267] lsm: new security_file_ioctl_compat() hook
Date: Wed, 21 Feb 2024 14:10:03 +0100
Message-ID: <20240221125948.468633057@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alfred Piccioni <alpic@google.com>

commit f1bb47a31dff6d4b34fb14e99850860ee74bb003 upstream.

Some ioctl commands do not require ioctl permission, but are routed to
other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).

However, if a 32-bit process is running on a 64-bit kernel, it emits
32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
being checked erroneously, which leads to these ioctl operations being
routed to the ioctl permission, rather than the correct file
permissions.

This was also noted in a RED-PEN finding from a while back -
"/* RED-PEN how should LSM module know it's handling 32bit? */".

This patch introduces a new hook, security_file_ioctl_compat(), that is
called from the compat ioctl syscall. All current LSMs have been changed
to support this hook.

Reviewing the three places where we are currently using
security_file_ioctl(), it appears that only SELinux needs a dedicated
compat change; TOMOYO and SMACK appear to be functional without any
change.

Cc: stable@vger.kernel.org
Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
Signed-off-by: Alfred Piccioni <alpic@google.com>
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: subject tweak, line length fixes, and alignment corrections]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/compat_ioctl.c          |    3 +--
 include/linux/lsm_hooks.h  |    9 +++++++++
 include/linux/security.h   |    9 +++++++++
 security/security.c        |   17 +++++++++++++++++
 security/selinux/hooks.c   |   28 ++++++++++++++++++++++++++++
 security/smack/smack_lsm.c |    1 +
 security/tomoyo/tomoyo.c   |    1 +
 7 files changed, 66 insertions(+), 2 deletions(-)

--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -994,8 +994,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned i
 	if (!f.file)
 		goto out;
 
-	/* RED-PEN how should LSM module know it's handling 32bit? */
-	error = security_file_ioctl(f.file, cmd, arg);
+	error = security_file_ioctl_compat(f.file, cmd, arg);
 	if (error)
 		goto out_fput;
 
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -498,6 +498,12 @@
  *	simple integer value.  When @arg represents a user space pointer, it
  *	should never be used by the security module.
  *	Return 0 if permission is granted.
+ * @file_ioctl_compat:
+ *	@file contains the file structure.
+ *	@cmd contains the operation to perform.
+ *	@arg contains the operational arguments.
+ *	Check permission for a compat ioctl operation on @file.
+ *	Return 0 if permission is granted.
  * @mmap_addr :
  *	Check permissions for a mmap operation at @addr.
  *	@addr contains virtual address that will be used for the operation.
@@ -1602,6 +1608,8 @@ union security_list_options {
 	void (*file_free_security)(struct file *file);
 	int (*file_ioctl)(struct file *file, unsigned int cmd,
 				unsigned long arg);
+	int (*file_ioctl_compat)(struct file *file, unsigned int cmd,
+				unsigned long arg);
 	int (*mmap_addr)(unsigned long addr);
 	int (*mmap_file)(struct file *file, unsigned long reqprot,
 				unsigned long prot, unsigned long flags);
@@ -1907,6 +1915,7 @@ struct security_hook_heads {
 	struct hlist_head file_alloc_security;
 	struct hlist_head file_free_security;
 	struct hlist_head file_ioctl;
+	struct hlist_head file_ioctl_compat;
 	struct hlist_head mmap_addr;
 	struct hlist_head mmap_file;
 	struct hlist_head file_mprotect;
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -362,6 +362,8 @@ int security_file_permission(struct file
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+			       unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
 int security_mmap_addr(unsigned long addr);
@@ -906,6 +908,13 @@ static inline int security_file_ioctl(st
 {
 	return 0;
 }
+
+static inline int security_file_ioctl_compat(struct file *file,
+					     unsigned int cmd,
+					     unsigned long arg)
+{
+	return 0;
+}
 
 static inline int security_mmap_file(struct file *file, unsigned long prot,
 				     unsigned long flags)
--- a/security/security.c
+++ b/security/security.c
@@ -1422,6 +1422,23 @@ int security_file_ioctl(struct file *fil
 	return call_int_hook(file_ioctl, 0, file, cmd, arg);
 }
 
+/**
+ * security_file_ioctl_compat() - Check if an ioctl is allowed in compat mode
+ * @file: associated file
+ * @cmd: ioctl cmd
+ * @arg: ioctl arguments
+ *
+ * Compat version of security_file_ioctl() that correctly handles 32-bit
+ * processes running on 64-bit kernels.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+			       unsigned long arg)
+{
+	return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
+}
+
 static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 {
 	/*
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3668,6 +3668,33 @@ static int selinux_file_ioctl(struct fil
 	return error;
 }
 
+static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	/*
+	 * If we are in a 64-bit kernel running 32-bit userspace, we need to
+	 * make sure we don't compare 32-bit flags to 64-bit flags.
+	 */
+	switch (cmd) {
+	case FS_IOC32_GETFLAGS:
+		cmd = FS_IOC_GETFLAGS;
+		break;
+	case FS_IOC32_SETFLAGS:
+		cmd = FS_IOC_SETFLAGS;
+		break;
+	case FS_IOC32_GETVERSION:
+		cmd = FS_IOC_GETVERSION;
+		break;
+	case FS_IOC32_SETVERSION:
+		cmd = FS_IOC_SETVERSION;
+		break;
+	default:
+		break;
+	}
+
+	return selinux_file_ioctl(file, cmd, arg);
+}
+
 static int default_noexec;
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
@@ -6933,6 +6960,7 @@ static struct security_hook_list selinux
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
 	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4648,6 +4648,7 @@ static struct security_hook_list smack_h
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, smack_file_ioctl),
 	LSM_HOOK_INIT(file_lock, smack_file_lock),
 	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
 	LSM_HOOK_INIT(mmap_file, smack_mmap_file),
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -554,6 +554,7 @@ static struct security_hook_list tomoyo_
 	LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
 	LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
 	LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
 	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
 	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
 	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),



