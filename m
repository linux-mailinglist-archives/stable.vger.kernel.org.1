Return-Path: <stable+bounces-42744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1508B7471
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF31B20DE6
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95F12DD87;
	Tue, 30 Apr 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmixLLKp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3EB12D77F;
	Tue, 30 Apr 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476644; cv=none; b=cJ/WJsURQyxLU/h3kVaUGZbuCAx+tNr3+EmsQ6GXg6U8Y80dw+y6jGZwNhDKy/QmJiafKokk8v11cjTw1FsoLhMgrpr5HhaAdGTxLD9DD3frEMVztHSBo9t39MFJ5EYGbAHNJ/i0fKxnDE2Cr2/BJjBNdfbRAlaqBKkjcMQF2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476644; c=relaxed/simple;
	bh=Kn1zDHGC9GsZfd7ouWZWz7PTriU8QcNhotU1r/xN2BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFI+vpAC5GFclUyt/RDwQeEQ/LxqGdog4aXrdxFoC5pWORAwExINs/hS33q25BLBCfIWiwWBPbZ+aifD9d1KCzMRXN0kSqdQwK3J/95cO7q3ROzOu9BNevR/8pO/zS2O87/caWGvuI/McZ+tVp3TPfoTod+FbD8eH1ASJn+E8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmixLLKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982E0C4AF1D;
	Tue, 30 Apr 2024 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476644;
	bh=Kn1zDHGC9GsZfd7ouWZWz7PTriU8QcNhotU1r/xN2BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmixLLKpCIEYsUkdApw+9y7aLFTluwuymV2D/3Uut5UsfAWDKDrwv3AIYSYA6YyY/
	 +SsfGIA5sWDkmHQZVsi9T0zprtM+4EIzpV17KnPedHQDKfu6lqzTlP/zdLYLF1oXk3
	 ZllDRVom/U7juLl9+K3NVjoVxL0Q3erjKvme04P0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com
Subject: [PATCH 6.1 058/110] af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().
Date: Tue, 30 Apr 2024 12:40:27 +0200
Message-ID: <20240430103049.280642111@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 1971d13ffa84a551d29a81fdf5b5ec5be166ac83 ]

syzbot reported a lockdep splat regarding unix_gc_lock and
unix_state_lock().

One is called from recvmsg() for a connected socket, and another
is called from GC for TCP_LISTEN socket.

So, the splat is false-positive.

Let's add a dedicated lock class for the latter to suppress the splat.

Note that this change is not necessary for net-next.git as the issue
is only applied to the old GC impl.

[0]:
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0 Not tainted
 -----------------------------------------------------
kworker/u8:1/11 is trying to acquire lock:
ffff88807cea4e70 (&u->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88807cea4e70 (&u->lock){+.+.}-{2:2}, at: __unix_gc+0x40e/0xf70 net/unix/garbage.c:302

but task is already holding lock:
ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf70 net/unix/garbage.c:261

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

 -> #1 (unix_gc_lock){+.+.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       unix_notinflight+0x13d/0x390 net/unix/garbage.c:140
       unix_detach_fds net/unix/af_unix.c:1819 [inline]
       unix_destruct_scm+0x221/0x350 net/unix/af_unix.c:1876
       skb_release_head_state+0x100/0x250 net/core/skbuff.c:1188
       skb_release_all net/core/skbuff.c:1200 [inline]
       __kfree_skb net/core/skbuff.c:1216 [inline]
       kfree_skb_reason+0x16d/0x3b0 net/core/skbuff.c:1252
       kfree_skb include/linux/skbuff.h:1262 [inline]
       manage_oob net/unix/af_unix.c:2672 [inline]
       unix_stream_read_generic+0x1125/0x2700 net/unix/af_unix.c:2749
       unix_stream_splice_read+0x239/0x320 net/unix/af_unix.c:2981
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_splice+0xf2d/0x1880 fs/splice.c:1379
       __do_splice fs/splice.c:1436 [inline]
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> #0 (&u->lock){+.+.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
       process_one_work kernel/workqueue.c:3254 [inline]
       process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(unix_gc_lock);
                               lock(&u->lock);
                               lock(unix_gc_lock);
  lock(&u->lock);

 *** DEADLOCK ***

3 locks held by kworker/u8:1/11:
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3335
 #1: ffffc90000107d00 (unix_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90000107d00 (unix_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3335
 #2: ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf70 net/unix/garbage.c:261

stack backtrace:
CPU: 0 PID: 11 Comm: kworker/u8:1 Not tainted 6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound __unix_gc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Fixes: 47d8ac011fe1 ("af_unix: Fix garbage collector racing against connect()")
Reported-and-tested-by: syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa379358c28cc87cc307
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240424170443.9832-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/af_unix.h | 3 +++
 net/unix/garbage.c    | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 16d6936baa2fb..e7d71a516bd4d 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -79,6 +79,9 @@ enum unix_socket_lock_class {
 	U_LOCK_NORMAL,
 	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
 	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
+	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
+			     * candidates to close a small race window.
+			     */
 };
 
 static inline void unix_state_lock_nested(struct sock *sk,
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 85c6f05c0fa3c..d2fc795394a52 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -260,7 +260,7 @@ void unix_gc(void)
 			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
 
 			if (sk->sk_state == TCP_LISTEN) {
-				unix_state_lock(sk);
+				unix_state_lock_nested(sk, U_LOCK_GC_LISTENER);
 				unix_state_unlock(sk);
 			}
 		}
-- 
2.43.0




