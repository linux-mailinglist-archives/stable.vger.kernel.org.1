Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC179B9BC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350746AbjIKVlE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbjIKN6n (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:58:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB76CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:58:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11505C433C7;
        Mon, 11 Sep 2023 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440718;
        bh=kCnW9iQ15fDSqS4kNg855vzezOA1JP9q4Y5IxIW3FKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nr7OrrdxPRVq84UhiYvuC0hxhRCTVLPRU8pxPi4/IAZBDwOf5v+yo55x6rmEB5Kzh
         Svj0pQBaaRXhQiDkthRM7BB1ZYqvkWIFWpbM3xH6hlZCJ/oB53cF0THOKc4EGvWJFy
         z8gY9Rel/DnmwgSW1xpXVNGpdIXyz4b6HjsHcP/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>,
        Jeff Xu <jeffxu@google.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 160/739] selftests: memfd: error out test process when child test fails
Date:   Mon, 11 Sep 2023 15:39:19 +0200
Message-ID: <20230911134655.626380520@linuxfoundation.org>
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

[ Upstream commit 99f34659e78b9b781a3248e0b080b4dfca4957e2 ]

Patch series "memfd: cleanups for vm.memfd_noexec", v2.

The most critical issue with vm.memfd_noexec=2 (the fact that passing
MFD_EXEC would bypass it entirely[1]) has been fixed in Andrew's
tree[2], but there are still some outstanding issues that need to be
addressed:

 * vm.memfd_noexec=2 shouldn't reject old-style memfd_create(2) syscalls
   because it will make it far to difficult to ever migrate. Instead it
   should imply MFD_EXEC.

 * The dmesg warnings are pr_warn_once(), which on most systems means
   that they will be used up by systemd or some other boot process and
   userspace developers will never see it.

   - For the !(flags & (MFD_EXEC | MFD_NOEXEC_SEAL)) case, outputting a
     rate-limited message to the kernel log is necessary to tell
     userspace that they should add the new flags.

     Arguably the most ideal way to deal with the spam concern[3,4]
     while still prompting userspace to switch to the new flags would be
     to only log the warning once per task or something similar.
     However, adding something to task_struct for tracking this would be
     needless bloat for a single pr_warn_ratelimited().

     So just switch to pr_info_ratelimited() to avoid spamming the log
     with something that isn't a real warning. There's lots of
     info-level stuff in dmesg, it seems really unlikely that this
     should be an actual problem. Most programs are already switching to
     the new flags anyway.

   - For the vm.memfd_noexec=2 case, we need to log a warning for every
     failure because otherwise userspace will have no idea why their
     previously working program started returning -EACCES (previously
     -EINVAL) from memfd_create(2). pr_warn_once() is simply wrong here.

 * The racheting mechanism for vm.memfd_noexec makes it incredibly
   unappealing for most users to enable the sysctl because enabling it
   on &init_pid_ns means you need a system reboot to unset it. Given the
   actual security threat being protected against, CAP_SYS_ADMIN users
   being restricted in this way makes little sense.

   The argument for this ratcheting by the original author was that it
   allows you to have a hierarchical setting that cannot be unset by
   child pidnses, but this is not accurate -- changing the parent
   pidns's vm.memfd_noexec setting to be more restrictive didn't affect
   children.

   Instead, switch the vm.memfd_noexec sysctl to be properly
   hierarchical and allow CAP_SYS_ADMIN users (in the pidns's owning
   userns) to lower the setting as long as it is not lower than the
   parent's effective setting. This change also makes it so that
   changing a parent pidns's vm.memfd_noexec will affect all
   descendants, providing a properly hierarchical setting. The
   performance impact of this is incredibly minimal since the maximum
   depth of pidns is 32 and it is only checked during memfd_create(2)
   and unshare(CLONE_NEWPID).

 * The memfd selftests would not exit with a non-zero error code when
   certain tests that ran in a forked process (specifically the ones
   related to MFD_EXEC and MFD_NOEXEC_SEAL) failed.

[1]: https://lore.kernel.org/all/ZJwcsU0vI-nzgOB_@codewreck.org/
[2]: https://lore.kernel.org/all/20230705063315.3680666-1-jeffxu@google.com/
[3]: https://lore.kernel.org/Y5yS8wCnuYGLHMj4@x1n/
[4]: https://lore.kernel.org/f185bb42-b29c-977e-312e-3349eea15383@linuxfoundation.org/

This patch (of 5):

Before this change, a test runner using this self test would see a return
code of 0 when the tests using a child process (namely the MFD_NOEXEC_SEAL
and MFD_EXEC tests) failed, masking test failures.

Link: https://lkml.kernel.org/r/20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com
Link: https://lkml.kernel.org/r/20230814-memfd-vm-noexec-uapi-fixes-v2-1-7ff9e3e10ba6@cyphar.com
Fixes: 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Reviewed-by: Jeff Xu <jeffxu@google.com>
Cc: "Christian Brauner (Microsoft)" <brauner@kernel.org>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index dba0e8ba002f8..7fc5d7c3bd65b 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1202,7 +1202,24 @@ static pid_t spawn_newpid_thread(unsigned int flags, int (*fn)(void *))
 
 static void join_newpid_thread(pid_t pid)
 {
-	waitpid(pid, NULL, 0);
+	int wstatus;
+
+	if (waitpid(pid, &wstatus, 0) < 0) {
+		printf("newpid thread: waitpid() failed: %m\n");
+		abort();
+	}
+
+	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != 0) {
+		printf("newpid thread: exited with non-zero error code %d\n",
+		       WEXITSTATUS(wstatus));
+		abort();
+	}
+
+	if (WIFSIGNALED(wstatus)) {
+		printf("newpid thread: killed by signal %d\n",
+		       WTERMSIG(wstatus));
+		abort();
+	}
 }
 
 /*
-- 
2.40.1



