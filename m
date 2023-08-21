Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5879783436
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 23:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjHUUoD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjHUUnT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4C61995;
        Mon, 21 Aug 2023 13:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAEB0649CB;
        Mon, 21 Aug 2023 20:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B067C433C8;
        Mon, 21 Aug 2023 20:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692650514;
        bh=aSTE5D4Nynai4KKSpr/pr1vDYPJV2Tdawj1/xZSMhW4=;
        h=Date:To:From:Subject:From;
        b=1YhL82z71OLGXOIhUUUwWWb1ERzwBTq3H6/zsuDV26zy/yS7Dhiz0WNrPf7SY9GoO
         ZHf6rDh/uy/C1oY/sQi3Upeq4vCRvHnoQ2aPjGLaKQho8qehdZk+1bMLh3991HH9Ph
         xZwk6Vq2lna69WgjBBbwIW5QHVEsqWoyqpBM1NA8=
Date:   Mon, 21 Aug 2023 13:41:53 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        shuah@kernel.org, keescook@chromium.org, jeffxu@google.com,
        dverkamp@chromium.org, brauner@kernel.org, asmadeus@codewreck.org,
        cyphar@cyphar.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] memfd-do-not-eacces-old-memfd_create-users-with-vmmemfd_noexec=2.patch removed from -mm tree
Message-Id: <20230821204154.3B067C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=2
has been removed from the -mm tree.  Its filename was
     memfd-do-not-eacces-old-memfd_create-users-with-vmmemfd_noexec=2.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=2
Date: Mon, 14 Aug 2023 18:40:58 +1000

Given the difficulty of auditing all of userspace to figure out whether
every memfd_create() user has switched to passing MFD_EXEC and
MFD_NOEXEC_SEAL flags, it seems far less distruptive to make it possible
for older programs that don't make use of executable memfds to run under
vm.memfd_noexec=2.  Otherwise, a small dependency change can result in
spurious errors.  For programs that don't use executable memfds, passing
MFD_NOEXEC_SEAL is functionally a no-op and thus having the same

In addition, every failure under vm.memfd_noexec=2 needs to print to the
kernel log so that userspace can figure out where the error came from. 
The concerns about pr_warn_ratelimited() spam that caused the switch to
pr_warn_once()[1,2] do not apply to the vm.memfd_noexec=2 case.

This is a user-visible API change, but as it allows programs to do
something that would be blocked before, and the sysctl itself was broken
and recently released, it seems unlikely this will cause any issues.

[1]: https://lore.kernel.org/Y5yS8wCnuYGLHMj4@x1n/
[2]: https://lore.kernel.org/202212161233.85C9783FB@keescook/

Link: https://lkml.kernel.org/r/20230814-memfd-vm-noexec-uapi-fixes-v2-2-7ff9e3e10ba6@cyphar.com
Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: Jeff Xu <jeffxu@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/pid_namespace.h              |   16 ++--------
 mm/memfd.c                                 |   30 ++++++-------------
 tools/testing/selftests/memfd/memfd_test.c |   22 ++++++++++---
 3 files changed, 32 insertions(+), 36 deletions(-)

--- a/include/linux/pid_namespace.h~memfd-do-not-eacces-old-memfd_create-users-with-vmmemfd_noexec=2
+++ a/include/linux/pid_namespace.h
@@ -17,18 +17,10 @@
 struct fs_pin;
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
-/*
- * sysctl for vm.memfd_noexec
- * 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
- *	acts like MFD_EXEC was set.
- * 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
- *	acts like MFD_NOEXEC_SEAL was set.
- * 2: memfd_create() without MFD_NOEXEC_SEAL will be
- *	rejected.
- */
-#define MEMFD_NOEXEC_SCOPE_EXEC			0
-#define MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL		1
-#define MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED	2
+/* modes for vm.memfd_noexec sysctl */
+#define MEMFD_NOEXEC_SCOPE_EXEC			0 /* MFD_EXEC implied if unset */
+#define MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL		1 /* MFD_NOEXEC_SEAL implied if unset */
+#define MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED	2 /* same as 1, except MFD_EXEC rejected */
 #endif
 
 struct pid_namespace {
--- a/mm/memfd.c~memfd-do-not-eacces-old-memfd_create-users-with-vmmemfd_noexec=2
+++ a/mm/memfd.c
@@ -271,30 +271,22 @@ long memfd_fcntl(struct file *file, unsi
 static int check_sysctl_memfd_noexec(unsigned int *flags)
 {
 #ifdef CONFIG_SYSCTL
-	char comm[TASK_COMM_LEN];
-	int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
-	struct pid_namespace *ns;
-
-	ns = task_active_pid_ns(current);
-	if (ns)
-		sysctl = ns->memfd_noexec_scope;
+	int sysctl = task_active_pid_ns(current)->memfd_noexec_scope;
 
 	if (!(*flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-		if (sysctl == MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)
+		if (sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)
 			*flags |= MFD_NOEXEC_SEAL;
 		else
 			*flags |= MFD_EXEC;
 	}
 
-	if (*flags & MFD_EXEC && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
-		pr_warn_once(
-			"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
-			task_pid_nr(current), get_task_comm(comm, current));
-
+	if (!(*flags & MFD_NOEXEC_SEAL) && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
+		pr_err_ratelimited(
+			"%s[%d]: memfd_create() requires MFD_NOEXEC_SEAL with vm.memfd_noexec=%d\n",
+			current->comm, task_pid_nr(current), sysctl);
 		return -EACCES;
 	}
 #endif
-
 	return 0;
 }
 
@@ -302,7 +294,6 @@ SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
 {
-	char comm[TASK_COMM_LEN];
 	unsigned int *file_seals;
 	struct file *file;
 	int fd, error;
@@ -325,12 +316,13 @@ SYSCALL_DEFINE2(memfd_create,
 
 	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
 		pr_warn_once(
-			"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
-			task_pid_nr(current), get_task_comm(comm, current));
+			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
+			current->comm, task_pid_nr(current));
 	}
 
-	if (check_sysctl_memfd_noexec(&flags) < 0)
-		return -EACCES;
+	error = check_sysctl_memfd_noexec(&flags);
+	if (error < 0)
+		return error;
 
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
--- a/tools/testing/selftests/memfd/memfd_test.c~memfd-do-not-eacces-old-memfd_create-users-with-vmmemfd_noexec=2
+++ a/tools/testing/selftests/memfd/memfd_test.c
@@ -1145,11 +1145,23 @@ static void test_sysctl_child(void)
 
 	printf("%s sysctl 2\n", memfd_str);
 	sysctl_assert_write("2");
-	mfd_fail_new("kern_memfd_sysctl_2",
-		MFD_CLOEXEC | MFD_ALLOW_SEALING);
-	mfd_fail_new("kern_memfd_sysctl_2_MFD_EXEC",
-		MFD_CLOEXEC | MFD_EXEC);
-	fd = mfd_assert_new("", 0, MFD_NOEXEC_SEAL);
+	mfd_fail_new("kern_memfd_sysctl_2_exec",
+		     MFD_EXEC | MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_2_dfl",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_2_noexec_seal",
+			    mfd_def_size,
+			    MFD_NOEXEC_SEAL | MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
 	close(fd);
 
 	sysctl_fail_write("0");
_

Patches currently in -mm which might be from cyphar@cyphar.com are


