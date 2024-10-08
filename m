Return-Path: <stable+bounces-81632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A590994881
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E50E1C2099C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CE1DED43;
	Tue,  8 Oct 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tf95JGNN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D01DE3BB;
	Tue,  8 Oct 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389612; cv=none; b=TYQ+HDN5vBYVJsM5iJsreaUuxIeBeKbgg8rgTTf6NFwlbBUWarvCeLtLl34WUynG0rgsoJQwNKGyUw9s3y7TvekwoGRUELjW38c1/84mgCQCpGtb0BxEfWf+WyGMyQsT+qHn/MlmBeVfoIs5Mf/GHJB8eFvHLtowk1nBzpBI7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389612; c=relaxed/simple;
	bh=xg8OOGIv5XfHNHCSdJ9oEcF3RJ9ZDx/M2kL21qq32+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEER1inxUETteP2rCKLAGSPpF6vDRbFepUV6zFWFYXmv56JRS3zFcP4r3KtkQZ0lk2T3W6FIouk53yfa/LInmTVDEKkZAVobQSFbDDhRLS364SnOJXm17SQUZAAQjodOzuqnnAPLN8Z5nYjeF7tsxRtS2r38uJ2oRYGrgUg2db0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tf95JGNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B5C4CEC7;
	Tue,  8 Oct 2024 12:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389611;
	bh=xg8OOGIv5XfHNHCSdJ9oEcF3RJ9ZDx/M2kL21qq32+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tf95JGNN5YhDS/YioTFGT+zPudRhIct7UvEZXg3sGbPCPkN1tqtYWL2q2tE4XfYIw
	 aMIi409/QItvSsr64J7A9y81xTnqnKZMGJnuzOVNst6aUK3dbbFNUiLrsXzAx5yto6
	 xNEeOhuujZSrhWIlmQAjEg5R+J8OalvLJQHWTWmI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+bd8d55ee2acd0a71d8ce@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Tom Parkin <tparkin@katalix.com>,
	James Chapman <jchapman@katalix.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 044/482] ppp: do not assume bh is held in ppp_channel_bridge_input()
Date: Tue,  8 Oct 2024 14:01:47 +0200
Message-ID: <20241008115650.038781462@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit aec7291003df78cb71fd461d7b672912bde55807 ]

Networking receive path is usually handled from BH handler.
However, some protocols need to acquire the socket lock, and
packets might be stored in the socket backlog is the socket was
owned by a user process.

In this case, release_sock(), __release_sock(), and sk_backlog_rcv()
might call the sk->sk_backlog_rcv() handler in process context.

sybot caught ppp was not considering this case in
ppp_channel_bridge_input() :

WARNING: inconsistent lock state
6.11.0-rc7-syzkaller-g5f5673607153 #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
ksoftirqd/1/24 [HC0[0]:SC1[1]:HE1:SE0] takes:
 ffff0000db7f11e0 (&pch->downl){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 ffff0000db7f11e0 (&pch->downl){+.?.}-{2:2}, at: ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2272 [inline]
 ffff0000db7f11e0 (&pch->downl){+.?.}-{2:2}, at: ppp_input+0x16c/0x854 drivers/net/ppp/ppp_generic.c:2304
{SOFTIRQ-ON-W} state was registered at:
   lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2272 [inline]
   ppp_input+0x16c/0x854 drivers/net/ppp/ppp_generic.c:2304
   pppoe_rcv_core+0xfc/0x314 drivers/net/ppp/pppoe.c:379
   sk_backlog_rcv include/net/sock.h:1111 [inline]
   __release_sock+0x1a8/0x3d8 net/core/sock.c:3004
   release_sock+0x68/0x1b8 net/core/sock.c:3558
   pppoe_sendmsg+0xc8/0x5d8 drivers/net/ppp/pppoe.c:903
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg net/socket.c:745 [inline]
   __sys_sendto+0x374/0x4f4 net/socket.c:2204
   __do_sys_sendto net/socket.c:2216 [inline]
   __se_sys_sendto net/socket.c:2212 [inline]
   __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2212
   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
   invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
   el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
   el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
   el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
   el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 282914
 hardirqs last  enabled at (282914): [<ffff80008b42e30c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 hardirqs last  enabled at (282914): [<ffff80008b42e30c>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
 hardirqs last disabled at (282913): [<ffff80008b42e13c>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
 hardirqs last disabled at (282913): [<ffff80008b42e13c>] _raw_spin_lock_irqsave+0x2c/0x7c kernel/locking/spinlock.c:162
 softirqs last  enabled at (282904): [<ffff8000801f8e88>] softirq_handle_end kernel/softirq.c:400 [inline]
 softirqs last  enabled at (282904): [<ffff8000801f8e88>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
 softirqs last disabled at (282909): [<ffff8000801fbdf8>] run_ksoftirqd+0x70/0x158 kernel/softirq.c:928

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&pch->downl);
  <Interrupt>
    lock(&pch->downl);

 *** DEADLOCK ***

1 lock held by ksoftirqd/1/24:
  #0: ffff80008f74dfa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x10/0x4c include/linux/rcupdate.h:325

stack backtrace:
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call trace:
  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
  __dump_stack lib/dump_stack.c:93 [inline]
  dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
  dump_stack+0x1c/0x28 lib/dump_stack.c:128
  print_usage_bug+0x698/0x9ac kernel/locking/lockdep.c:4000
 mark_lock_irq+0x980/0xd2c
  mark_lock+0x258/0x360 kernel/locking/lockdep.c:4677
  __lock_acquire+0xf48/0x779c kernel/locking/lockdep.c:5096
  lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2272 [inline]
  ppp_input+0x16c/0x854 drivers/net/ppp/ppp_generic.c:2304
  ppp_async_process+0x98/0x150 drivers/net/ppp/ppp_async.c:495
  tasklet_action_common+0x318/0x3f4 kernel/softirq.c:785
  tasklet_action+0x68/0x8c kernel/softirq.c:811
  handle_softirqs+0x2e4/0xbfc kernel/softirq.c:554
  run_ksoftirqd+0x70/0x158 kernel/softirq.c:928
  smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
  kthread+0x288/0x310 kernel/kthread.c:389
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN ioctls")
Reported-by: syzbot+bd8d55ee2acd0a71d8ce@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/66f661e2.050a0220.38ace9.000f.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tom Parkin <tparkin@katalix.com>
Cc: James Chapman <jchapman@katalix.com>
Link: https://patch.msgid.link/20240927074553.341910-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/ppp_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index eb9acfcaeb097..9d2656afba660 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2269,7 +2269,7 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 	if (!pchb)
 		goto out_rcu;
 
-	spin_lock(&pchb->downl);
+	spin_lock_bh(&pchb->downl);
 	if (!pchb->chan) {
 		/* channel got unregistered */
 		kfree_skb(skb);
@@ -2281,7 +2281,7 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 		kfree_skb(skb);
 
 outl:
-	spin_unlock(&pchb->downl);
+	spin_unlock_bh(&pchb->downl);
 out_rcu:
 	rcu_read_unlock();
 
-- 
2.43.0




