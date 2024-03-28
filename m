Return-Path: <stable+bounces-26121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2D870D33
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4331F20F18
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE67D099;
	Mon,  4 Mar 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bY8dplrl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF57D094;
	Mon,  4 Mar 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587896; cv=none; b=MGelAOlu3qEozW3NurPbqLhoCpt7J3nHaeVLmKkGsbErhInfSzHPRBucmS5Lkqg8lt9/pZZVTK7stfRdEQPkxkzI0mmaFhkWC43CnRZq2nBFA75LKHss7RJz1peOAtFUUQBfKTak9SkE6ZJj1caCfBMD69qgjc/eesTrunim3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587896; c=relaxed/simple;
	bh=GGWjdAHxnO5fEC9u5DXKc9iqttmh6MUYiuJc6Vbm4Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTgaxFcKzx/VsGLp8n8UjEqE98k6gK4zdB4lOTUQd4qNu2nOFYgE44FKioFJn5SWhlsXAVIUUw1o8JDRb8kCm3/jTyoSckqZlM7YlCwIAPum4l71hVAEZYXd62zs2/OlPCoQUSTGaZiawIBnFkft7WccmbNeqXVMHWlLzDSFy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bY8dplrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B57C433C7;
	Mon,  4 Mar 2024 21:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587896;
	bh=GGWjdAHxnO5fEC9u5DXKc9iqttmh6MUYiuJc6Vbm4Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bY8dplrlbA0+KWdY8POREkXnGrwpwVL624FqduL/zFzlqr0Iv5P8l3fHwvT5oAm6w
	 H3WowBE/R12TppJLnD2t/hxk78H7yRm6WiAZFbmjaL0a+ZIx/ILll1Es0gFi1E5eVe
	 v1lTvf4HjGRFZHI+eyS/Tw+ioodgLWgV3ef5w1Uw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.7 132/162] af_unix: Fix task hung while purging oob_skb in GC.
Date: Mon,  4 Mar 2024 21:23:17 +0000
Message-ID: <20240304211555.955542487@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit 25236c91b5ab4a26a56ba2e79b8060cf4e047839 upstream.

syzbot reported a task hung; at the same time, GC was looping infinitely
in list_for_each_entry_safe() for OOB skb.  [0]

syzbot demonstrated that the list_for_each_entry_safe() was not actually
safe in this case.

A single skb could have references for multiple sockets.  If we free such
a skb in the list_for_each_entry_safe(), the current and next sockets could
be unlinked in a single iteration.

unix_notinflight() uses list_del_init() to unlink the socket, so the
prefetched next socket forms a loop itself and list_for_each_entry_safe()
never stops.

Here, we must use while() and make sure we always fetch the first socket.

[0]:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5065 Comm: syz-executor236 Not tainted 6.8.0-rc3-syzkaller-00136-g1f719a2f3fa6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0xd/0x60 kernel/kcov.c:207
Code: cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 14 25 40 c2 03 00 <65> 8b 05 b4 7c 78 7e a9 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74
RSP: 0018:ffffc900033efa58 EFLAGS: 00000283
RAX: ffff88807b077800 RBX: ffff88807b077800 RCX: 1ffffffff27b1189
RDX: ffff88802a5a3b80 RSI: ffffffff8968488d RDI: ffff88807b077f70
RBP: ffffc900033efbb0 R08: 0000000000000001 R09: fffffbfff27a900c
R10: ffffffff93d48067 R11: ffffffff8ae000eb R12: ffff88807b077800
R13: dffffc0000000000 R14: ffff88807b077e40 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564f4fc1e3a8 CR3: 000000000d57a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unix_gc+0x563/0x13b0 net/unix/garbage.c:319
 unix_release_sock+0xa93/0xf80 net/unix/af_unix.c:683
 unix_release+0x91/0xf0 net/unix/af_unix.c:1064
 __sock_release+0xb0/0x270 net/socket.c:659
 sock_close+0x1c/0x30 net/socket.c:1421
 __fput+0x270/0xb80 fs/file_table.c:376
 task_work_run+0x14f/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8a/0x2ad0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f9d6cbdac09
Code: Unable to access opcode bytes at 0x7f9d6cbdabdf.
RSP: 002b:00007fff5952feb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9d6cbdac09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f9d6cc552b0 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007f9d6cc552b0
R13: 0000000000000000 R14: 00007f9d6cc55d00 R15: 00007f9d6cbabe70
 </TASK>

Reported-by: syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4fa4a2d1f5a5ee06f006
Fixes: 1279f9d9dec2 ("af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240209220453.96053-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/unix/garbage.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -315,10 +315,11 @@ void unix_gc(void)
 	__skb_queue_purge(&hitlist);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	list_for_each_entry_safe(u, next, &gc_candidates, link) {
-		struct sk_buff *skb = u->oob_skb;
+	while (!list_empty(&gc_candidates)) {
+		u = list_entry(gc_candidates.next, struct unix_sock, link);
+		if (u->oob_skb) {
+			struct sk_buff *skb = u->oob_skb;
 
-		if (skb) {
 			u->oob_skb = NULL;
 			kfree_skb(skb);
 		}



