Return-Path: <stable+bounces-36874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC5289C22A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29030283294
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE7580027;
	Mon,  8 Apr 2024 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GLJkxs7C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183917FBC8;
	Mon,  8 Apr 2024 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582594; cv=none; b=Dxca0tu/WAVfs6J802AdvHdh3jtdMr+s1p56qh8xOjTHuJ2EQuW91pMwr7LeL9E38slXBPVwoXjfL2rKePIZ7QNnQ0BybBb4d/4MdvnpZpQIQub7UNZH5zhidU1n3qhdDwqwqXwNQwL278o+/gXiNkd6C7EWRtZLQDB+8Pkin7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582594; c=relaxed/simple;
	bh=QUw/JlurGEiERxBupHIAifAk+XSWhz+XMu4JitWdrJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic3L+uSvwUv61atun0uKWzjEMc9IxFl2JT2nWzc2N1HaVkenU+bmWHfbmlbU8YnXuOUN/QRE6ymg94YCuqEjXSVGyAWbcDz8GrfjlgIuqZwwwOgtA1c3Hr7ZOdtgHEov4IOfGB5XpMpGRUu6xHs6nwJUm2s31TMIh8ISr70vjQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GLJkxs7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914EBC433C7;
	Mon,  8 Apr 2024 13:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582594;
	bh=QUw/JlurGEiERxBupHIAifAk+XSWhz+XMu4JitWdrJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLJkxs7Cw8utrU/g9Cv1A3boFAJymmYBMFP97l14ds1PmU0b3MCRyvO6iwKLDm0UD
	 nKKvW+/vf7rwvD7OAauBq1HFu5/Z7OTUmmb5A7nRI/nJcT0mtMFM66bvEmOUsF3DqR
	 wa1Ufxg1a9o6ro0Bi1NvWsfo6xSbMv7jxOCOFRfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 105/252] net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()
Date: Mon,  8 Apr 2024 14:56:44 +0200
Message-ID: <20240408125309.903146698@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 7eb322360b0266481e560d1807ee79e0cef5742b upstream.

qdisc_tree_reduce_backlog() is called with the qdisc lock held,
not RTNL.

We must use qdisc_lookup_rcu() instead of qdisc_lookup()

syzbot reported:

WARNING: suspicious RCU usage
6.1.74-syzkaller #0 Not tainted
-----------------------------
net/sched/sch_api.c:305 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
3 locks held by udevd/1142:
  #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:306 [inline]
  #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
  #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: net_tx_action+0x64a/0x970 net/core/dev.c:5282
  #1: ffff888171861108 (&sch->q.lock){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
  #1: ffff888171861108 (&sch->q.lock){+.-.}-{2:2}, at: net_tx_action+0x754/0x970 net/core/dev.c:5297
  #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:306 [inline]
  #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
  #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: qdisc_tree_reduce_backlog+0x84/0x580 net/sched/sch_api.c:792

stack backtrace:
CPU: 1 PID: 1142 Comm: udevd Not tainted 6.1.74-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
  [<ffffffff85b85f14>] __dump_stack lib/dump_stack.c:88 [inline]
  [<ffffffff85b85f14>] dump_stack_lvl+0x1b1/0x28f lib/dump_stack.c:106
  [<ffffffff85b86007>] dump_stack+0x15/0x1e lib/dump_stack.c:113
  [<ffffffff81802299>] lockdep_rcu_suspicious+0x1b9/0x260 kernel/locking/lockdep.c:6592
  [<ffffffff84f0054c>] qdisc_lookup+0xac/0x6f0 net/sched/sch_api.c:305
  [<ffffffff84f037c3>] qdisc_tree_reduce_backlog+0x243/0x580 net/sched/sch_api.c:811
  [<ffffffff84f5b78c>] pfifo_tail_enqueue+0x32c/0x4b0 net/sched/sch_fifo.c:51
  [<ffffffff84fbcf63>] qdisc_enqueue include/net/sch_generic.h:833 [inline]
  [<ffffffff84fbcf63>] netem_dequeue+0xeb3/0x15d0 net/sched/sch_netem.c:723
  [<ffffffff84eecab9>] dequeue_skb net/sched/sch_generic.c:292 [inline]
  [<ffffffff84eecab9>] qdisc_restart net/sched/sch_generic.c:397 [inline]
  [<ffffffff84eecab9>] __qdisc_run+0x249/0x1e60 net/sched/sch_generic.c:415
  [<ffffffff84d7aa96>] qdisc_run+0xd6/0x260 include/net/pkt_sched.h:125
  [<ffffffff84d85d29>] net_tx_action+0x7c9/0x970 net/core/dev.c:5313
  [<ffffffff85e002bd>] __do_softirq+0x2bd/0x9bd kernel/softirq.c:616
  [<ffffffff81568bca>] invoke_softirq kernel/softirq.c:447 [inline]
  [<ffffffff81568bca>] __irq_exit_rcu+0xca/0x230 kernel/softirq.c:700
  [<ffffffff81568ae9>] irq_exit_rcu+0x9/0x20 kernel/softirq.c:712
  [<ffffffff85b89f52>] sysvec_apic_timer_interrupt+0x42/0x90 arch/x86/kernel/apic/apic.c:1107
  [<ffffffff85c00ccb>] asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:656

Fixes: d636fc5dd692 ("net: sched: add rcu annotations around qdisc->qdisc_sleeping")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20240402134133.2352776-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_api.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -809,7 +809,7 @@ void qdisc_tree_reduce_backlog(struct Qd
 		notify = !sch->q.qlen && !WARN_ON_ONCE(!n &&
 						       !qdisc_is_offloaded);
 		/* TODO: perform the search on a per txq basis */
-		sch = qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid));
+		sch = qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));
 		if (sch == NULL) {
 			WARN_ON_ONCE(parentid != TC_H_ROOT);
 			break;



