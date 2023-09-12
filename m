Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B749979BCCF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbjIKWGP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbjIKO01 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:26:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AA1DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:26:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0387C433C8;
        Mon, 11 Sep 2023 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442382;
        bh=YxHYLFFt+BuS/065XsKuKBO/bSIyP4Pwa7cwfkbTyAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1dUgCxvJFBlVZ5+9wK8/JHVWcomkP0saUlMS9kS7mhjxIBt27BTRaSDT27yk8sEu
         rxBYTqwU2bT6P2vgVRd4vgCW8WpUnAsqOabC/RP6E5gZJbs6YmIXIIkqM8wqyGomC5
         Zy32wlnbTCYrOxG047rF/G/XXz5lY0j/G+V6xf1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 735/739] memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=2
Date:   Mon, 11 Sep 2023 15:48:54 +0200
Message-ID: <20230911134711.587508479@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksa Sarai <cyphar@cyphar.com>

[ Upstream commit 202e14222fadb246dfdf182e67de1518e86a1e20 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pid_namespace.h              | 16 +++---------
 mm/memfd.c                                 | 30 ++++++++--------------
 tools/testing/selftests/memfd/memfd_test.c | 22 ++++++++++++----
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index c758809d5bcf3..53974d79d98e8 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
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
diff --git a/mm/memfd.c b/mm/memfd.c
index 0bdbd2335af75..d65485c762def 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -271,30 +271,22 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
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
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 8eb49204f9eac..8b7390ad81d11 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
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
-- 
2.40.1



