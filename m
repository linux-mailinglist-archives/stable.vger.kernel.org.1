Return-Path: <stable+bounces-51475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9142B90708D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4ABB270F5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A576C145B12;
	Thu, 13 Jun 2024 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="StqEDNvU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641FA1459FA;
	Thu, 13 Jun 2024 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281407; cv=none; b=gEqJBSlzUhfmBLJ6dgZEJHwhJcztmJwKRdISOTu/qX38UZMWhpdTm2ze5T0P6lgNCC021FtyPhVBj5lrDDv7d3cgrneqOsEDYzwAgXjO3UHFKHP8RZY7LjDzH9uoeoP/TS7bjM/9elZcFUTOgIrVxZnwhnys2/jXRbqztFZZ7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281407; c=relaxed/simple;
	bh=HpglYwRDXveDenCgkUTQWh/cX3lDdNnV6LeWjMhsO58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlu91JwR9QKs8K1/tDjVEGrVi6lujU9kKpkC5CwYezxBfA63H6598HCky/5qV9jW/6FRpPAurh3q06UzI7h79Fn3XopJa6h2wZP8R1Dxx3n0a/ftzoXryQeM1Y6kVSBFCXZvmIZVNOlzuGiCOEkqa/GGj7daLLvC/Levm/z8pAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=StqEDNvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB94AC2BBFC;
	Thu, 13 Jun 2024 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281407;
	bh=HpglYwRDXveDenCgkUTQWh/cX3lDdNnV6LeWjMhsO58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StqEDNvUmIVAKa2MJlfvBoI2QYou/YdpvXk8Wp1RCbi8wr4DYNGg/Czilj8diqF7e
	 R3ypS0fZtUihHiA0j4Rq+weP6q0BqL8MWqnqp69bUSk1mqop3nmVtKUnGZEP/0eAUM
	 VTo4ihv38xZmf0UsYSOIg+psGbPfP7288qCuEBas=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 245/317] netfilter: nfnetlink_queue: acquire rcu_read_lock() in instance_destroy_rcu()
Date: Thu, 13 Jun 2024 13:34:23 +0200
Message-ID: <20240613113257.029625387@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit dc21c6cc3d6986d938efbf95de62473982c98dec ]

syzbot reported that nf_reinject() could be called without rcu_read_lock() :

WARNING: suspicious RCU usage
6.9.0-rc7-syzkaller-02060-g5c1672705a1a #0 Not tainted

net/netfilter/nfnetlink_queue.c:263 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor.4/13427:
  #0: ffffffff8e334f60 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
  #0: ffffffff8e334f60 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2190 [inline]
  #0: ffffffff8e334f60 (rcu_callback){....}-{0:0}, at: rcu_core+0xa86/0x1830 kernel/rcu/tree.c:2471
  #1: ffff88801ca92958 (&inst->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
  #1: ffff88801ca92958 (&inst->lock){+.-.}-{2:2}, at: nfqnl_flush net/netfilter/nfnetlink_queue.c:405 [inline]
  #1: ffff88801ca92958 (&inst->lock){+.-.}-{2:2}, at: instance_destroy_rcu+0x30/0x220 net/netfilter/nfnetlink_queue.c:172

stack backtrace:
CPU: 0 PID: 13427 Comm: syz-executor.4 Not tainted 6.9.0-rc7-syzkaller-02060-g5c1672705a1a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <IRQ>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
  nf_reinject net/netfilter/nfnetlink_queue.c:323 [inline]
  nfqnl_reinject+0x6ec/0x1120 net/netfilter/nfnetlink_queue.c:397
  nfqnl_flush net/netfilter/nfnetlink_queue.c:410 [inline]
  instance_destroy_rcu+0x1ae/0x220 net/netfilter/nfnetlink_queue.c:172
  rcu_do_batch kernel/rcu/tree.c:2196 [inline]
  rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
  handle_softirqs+0x2d6/0x990 kernel/softirq.c:554
  __do_softirq kernel/softirq.c:588 [inline]
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>

Fixes: 9872bec773c2 ("[NETFILTER]: nfnetlink: use RCU for queue instances hash")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 9d87606c76ff4..dc6af1919deaf 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -167,7 +167,9 @@ instance_destroy_rcu(struct rcu_head *head)
 	struct nfqnl_instance *inst = container_of(head, struct nfqnl_instance,
 						   rcu);
 
+	rcu_read_lock();
 	nfqnl_flush(inst, NULL, 0);
+	rcu_read_unlock();
 	kfree(inst);
 	module_put(THIS_MODULE);
 }
-- 
2.43.0




