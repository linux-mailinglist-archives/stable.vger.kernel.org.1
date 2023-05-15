Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0387038DC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242743AbjEORfz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244429AbjEORfY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343A0120B6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D38362246
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAA5C4339B;
        Mon, 15 May 2023 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171990;
        bh=sgLYlJEycQfjsHuNhERr2TA08C3ZmAIv5aEV0godErw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0UsNybLr/qFpNHU+y3FId1RU2ny6ibuRcuEgBrmxzRLG4OTVZAe/oySgjKeGBkSMW
         CFy9+gTJUGIKzKKDNotbagYsucZI1s6la10kZIe2mL7w3uI/GZ6P1A30I2pns0RBBj
         VCcsFaEuNNiQY+4J0lcWyFlnAL8ihGFoNQq1UkEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com,
        Ayushman Dutta <ayudutta@amazon.com>,
        Kees Cook <keescook@chromium.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
Subject: [PATCH 5.10 001/381] seccomp: Move copy_seccomp() to no failure path.
Date:   Mon, 15 May 2023 18:24:12 +0200
Message-Id: <20230515161736.847344716@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit a1140cb215fa13dcec06d12ba0c3ee105633b7c4 upstream.

Our syzbot instance reported memory leaks in do_seccomp() [0], similar
to the report [1].  It shows that we miss freeing struct seccomp_filter
and some objects included in it.

We can reproduce the issue with the program below [2] which calls one
seccomp() and two clone() syscalls.

The first clone()d child exits earlier than its parent and sends a
signal to kill it during the second clone(), more precisely before the
fatal_signal_pending() test in copy_process().  When the parent receives
the signal, it has to destroy the embryonic process and return -EINTR to
user space.  In the failure path, we have to call seccomp_filter_release()
to decrement the filter's refcount.

Initially, we called it in free_task() called from the failure path, but
the commit 3a15fb6ed92c ("seccomp: release filter after task is fully
dead") moved it to release_task() to notify user space as early as possible
that the filter is no longer used.

To keep the change and current seccomp refcount semantics, let's move
copy_seccomp() just after the signal check and add a WARN_ON_ONCE() in
free_task() for future debugging.

[0]:
unreferenced object 0xffff8880063add00 (size 256):
  comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.914s)
  hex dump (first 32 bytes):
    01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    do_seccomp (./include/linux/slab.h:600 ./include/linux/slab.h:733 kernel/seccomp.c:666 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
unreferenced object 0xffffc90000035000 (size 4096):
  comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 05 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    __vmalloc_node_range (mm/vmalloc.c:3226)
    __vmalloc_node (mm/vmalloc.c:3261 (discriminator 4))
    bpf_prog_alloc_no_stats (kernel/bpf/core.c:91)
    bpf_prog_alloc (kernel/bpf/core.c:129)
    bpf_prog_create_from_user (net/core/filter.c:1414)
    do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
unreferenced object 0xffff888003fa1000 (size 1024):
  comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    bpf_prog_alloc_no_stats (./include/linux/slab.h:600 ./include/linux/slab.h:733 kernel/bpf/core.c:95)
    bpf_prog_alloc (kernel/bpf/core.c:129)
    bpf_prog_create_from_user (net/core/filter.c:1414)
    do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
unreferenced object 0xffff888006360240 (size 16):
  comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
  hex dump (first 16 bytes):
    01 00 37 00 76 65 72 6c e0 83 01 06 80 88 ff ff  ..7.verl........
  backtrace:
    bpf_prog_store_orig_filter (net/core/filter.c:1137)
    bpf_prog_create_from_user (net/core/filter.c:1428)
    do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
unreferenced object 0xffff8880060183e0 (size 8):
  comm "repro_seccomp", pid 230, jiffies 4294687090 (age 9.915s)
  hex dump (first 8 bytes):
    06 00 00 00 00 00 ff 7f                          ........
  backtrace:
    kmemdup (mm/util.c:129)
    bpf_prog_store_orig_filter (net/core/filter.c:1144)
    bpf_prog_create_from_user (net/core/filter.c:1428)
    do_seccomp (kernel/seccomp.c:671 kernel/seccomp.c:708 kernel/seccomp.c:1871 kernel/seccomp.c:1991)
    do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

[1]: https://syzkaller.appspot.com/bug?id=2809bb0ac77ad9aa3f4afe42d6a610aba594a987

[2]:
#define _GNU_SOURCE
#include <sched.h>
#include <signal.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <linux/filter.h>
#include <linux/seccomp.h>

void main(void)
{
	struct sock_filter filter[] = {
		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
	};
	struct sock_fprog fprog = {
		.len = sizeof(filter) / sizeof(filter[0]),
		.filter = filter,
	};
	long i, pid;

	syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER, 0, &fprog);

	for (i = 0; i < 2; i++) {
		pid = syscall(__NR_clone, CLONE_NEWNET | SIGKILL, NULL, NULL, 0);
		if (pid == 0)
			return;
	}
}

Fixes: 3a15fb6ed92c ("seccomp: release filter after task is fully dead")
Reported-by: syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com
Reported-by: Ayushman Dutta <ayudutta@amazon.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220823154532.82913-1-kuniyu@amazon.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/fork.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -441,6 +441,9 @@ void put_task_stack(struct task_struct *
 
 void free_task(struct task_struct *tsk)
 {
+#ifdef CONFIG_SECCOMP
+	WARN_ON_ONCE(tsk->seccomp.filter);
+#endif
 	scs_release(tsk);
 
 #ifndef CONFIG_THREAD_INFO_IN_TASK
@@ -2248,12 +2251,6 @@ static __latent_entropy struct task_stru
 
 	spin_lock(&current->sighand->siglock);
 
-	/*
-	 * Copy seccomp details explicitly here, in case they were changed
-	 * before holding sighand lock.
-	 */
-	copy_seccomp(p);
-
 	rseq_fork(p, clone_flags);
 
 	/* Don't start children in a dying pid namespace */
@@ -2268,6 +2265,14 @@ static __latent_entropy struct task_stru
 		goto bad_fork_cancel_cgroup;
 	}
 
+	/* No more failure paths after this point. */
+
+	/*
+	 * Copy seccomp details explicitly here, in case they were changed
+	 * before holding sighand lock.
+	 */
+	copy_seccomp(p);
+
 	init_task_pid_links(p);
 	if (likely(p->pid)) {
 		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);


