Return-Path: <stable+bounces-46415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C548D041C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211251F21506
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F471CB31B;
	Mon, 27 May 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekSrYCbQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37E71CB313;
	Mon, 27 May 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819462; cv=none; b=MIZIIfcwMYvzzPQFMVWrIwD+3Y6TiyH/lGUU/hbCRTtvMewsqVLmmSVgsBfqZGlYdWm4YnMSEZU4rMuRziAbhUekGYA7YxXGM+aWXNxq4Tr5YeFqiYt0N8DFYiimMaZu3V00QjSZ771adjT1YL1aX0xXFCcdWLDk/l8O98sybl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819462; c=relaxed/simple;
	bh=GAJ0spvR+9Hfp8WiqceJyAQZOHpZP+lvUabgRhVtrGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhkvzNkfiZROFYyTxVEeDoiregsuWTbsxZ1SLkFiioKEYtciKT0JalAOaROCle86g9QPUyxquApgKsZDMZWm9HTyqJxLCOmri6bjLvMa25LPEbk0ZZqhzzzafrG6dcdNiMZyvfVPtKUs/HY7wQR9smDqC57LYYCwBjV1LHqLVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekSrYCbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483E8C32781;
	Mon, 27 May 2024 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819461;
	bh=GAJ0spvR+9Hfp8WiqceJyAQZOHpZP+lvUabgRhVtrGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekSrYCbQYjLTZrF/uBz2jt7OYV8kRn0xheXt4spVf4m3RXdwz3HxlNDOGhBS21tjO
	 x0CO+2e7nnhZr9duKLcveyD1+SG6h4T9ajHca+c9Qy5yDDQmonavVCPplWDxcO+wrS
	 YIc4GS3dJBUhxR2BU48lE/ycHzUSMNmvk40KLlnWHtpVR0ekc/GOa8vXDG2LEh6/uo
	 YMQAfUO4REdUYD1yRr7iqU/wIxJRnVu0xz4xM2D+vfMai6EnDa1bRKLLRumgOMq8wU
	 9oiq9BeWvyYvNvAyjYV3A9odmZ9x4iDymVcOZkfSDnHLYzQgwrNdmEMAgoRup6SDXt
	 KQbHrFoVTQWSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>,
	Xiumei Mu <xmu@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/17] net/sched: fix false lockdep warning on qdisc root lock
Date: Mon, 27 May 2024 10:16:46 -0400
Message-ID: <20240527141712.3853988-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141712.3853988-1-sashal@kernel.org>
References: <20240527141712.3853988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit af0cb3fa3f9ed258d14abab0152e28a0f9593084 ]

Xiumei and Christoph reported the following lockdep splat, complaining of
the qdisc root lock being taken twice:

 ============================================
 WARNING: possible recursive locking detected
 6.7.0-rc3+ #598 Not tainted
 --------------------------------------------
 swapper/2/0 is trying to acquire lock:
 ffff888177190110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0x1560/0x2e70

 but task is already holding lock:
 ffff88811995a110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0x1560/0x2e70

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&sch->q.lock);
   lock(&sch->q.lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 5 locks held by swapper/2/0:
  #0: ffff888135a09d98 ((&in_dev->mr_ifc_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11a/0x510
  #1: ffffffffaaee5260 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x2c0/0x1ed0
  #2: ffffffffaaee5200 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x209/0x2e70
  #3: ffff88811995a110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0x1560/0x2e70
  #4: ffffffffaaee5200 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x209/0x2e70

 stack backtrace:
 CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.7.0-rc3+ #598
 Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7353+9de0a3cc 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x4a/0x80
  __lock_acquire+0xfdd/0x3150
  lock_acquire+0x1ca/0x540
  _raw_spin_lock+0x34/0x80
  __dev_queue_xmit+0x1560/0x2e70
  tcf_mirred_act+0x82e/0x1260 [act_mirred]
  tcf_action_exec+0x161/0x480
  tcf_classify+0x689/0x1170
  prio_enqueue+0x316/0x660 [sch_prio]
  dev_qdisc_enqueue+0x46/0x220
  __dev_queue_xmit+0x1615/0x2e70
  ip_finish_output2+0x1218/0x1ed0
  __ip_finish_output+0x8b3/0x1350
  ip_output+0x163/0x4e0
  igmp_ifc_timer_expire+0x44b/0x930
  call_timer_fn+0x1a2/0x510
  run_timer_softirq+0x54d/0x11a0
  __do_softirq+0x1b3/0x88f
  irq_exit_rcu+0x18f/0x1e0
  sysvec_apic_timer_interrupt+0x6f/0x90
  </IRQ>

This happens when TC does a mirred egress redirect from the root qdisc of
device A to the root qdisc of device B. As long as these two locks aren't
protecting the same qdisc, they can be acquired in chain: add a per-qdisc
lockdep key to silence false warnings.
This dynamic key should safely replace the static key we have in sch_htb:
it was added to allow enqueueing to the device "direct qdisc" while still
holding the qdisc root lock.

v2: don't use static keys anymore in HTB direct qdiscs (thanks Eric Dumazet)

CC: Maxim Mikityanskiy <maxim@isovalent.com>
CC: Xiumei Mu <xmu@redhat.com>
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/451
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Link: https://lore.kernel.org/r/7dc06d6158f72053cf877a82e2a7a5bd23692faa.1713448007.git.dcaratti@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sch_generic.h |  1 +
 net/sched/sch_generic.c   |  3 +++
 net/sched/sch_htb.c       | 22 +++-------------------
 3 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index b3e3128402961..aefdb080ad3d2 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -126,6 +126,7 @@ struct Qdisc {
 
 	struct rcu_head		rcu;
 	netdevice_tracker	dev_tracker;
+	struct lock_class_key	root_lock_key;
 	/* private data */
 	long privdata[] ____cacheline_aligned;
 };
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index a5693e25b2482..d4b4e32aa0e06 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -942,7 +942,9 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	__skb_queue_head_init(&sch->gso_skb);
 	__skb_queue_head_init(&sch->skb_bad_txq);
 	gnet_stats_basic_sync_init(&sch->bstats);
+	lockdep_register_key(&sch->root_lock_key);
 	spin_lock_init(&sch->q.lock);
+	lockdep_set_class(&sch->q.lock, &sch->root_lock_key);
 
 	if (ops->static_flags & TCQ_F_CPUSTATS) {
 		sch->cpu_bstats =
@@ -1062,6 +1064,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 	if (ops->destroy)
 		ops->destroy(qdisc);
 
+	lockdep_unregister_key(&qdisc->root_lock_key);
 	module_put(ops->owner);
 	netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
 
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 67b1879ea8e10..d23f8ea630820 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1036,13 +1036,6 @@ static void htb_work_func(struct work_struct *work)
 	rcu_read_unlock();
 }
 
-static void htb_set_lockdep_class_child(struct Qdisc *q)
-{
-	static struct lock_class_key child_key;
-
-	lockdep_set_class(qdisc_lock(q), &child_key);
-}
-
 static int htb_offload(struct net_device *dev, struct tc_htb_qopt_offload *opt)
 {
 	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_HTB, opt);
@@ -1129,7 +1122,6 @@ static int htb_init(struct Qdisc *sch, struct nlattr *opt,
 			return -ENOMEM;
 		}
 
-		htb_set_lockdep_class_child(qdisc);
 		q->direct_qdiscs[ntx] = qdisc;
 		qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
 	}
@@ -1465,7 +1457,6 @@ static int htb_graft(struct Qdisc *sch, unsigned long arg, struct Qdisc *new,
 	}
 
 	if (q->offload) {
-		htb_set_lockdep_class_child(new);
 		/* One ref for cl->leaf.q, the other for dev_queue->qdisc. */
 		qdisc_refcount_inc(new);
 		old_q = htb_graft_helper(dev_queue, new);
@@ -1728,11 +1719,8 @@ static int htb_delete(struct Qdisc *sch, unsigned long arg,
 		new_q = qdisc_create_dflt(dev_queue, &pfifo_qdisc_ops,
 					  cl->parent->common.classid,
 					  NULL);
-		if (q->offload) {
-			if (new_q)
-				htb_set_lockdep_class_child(new_q);
+		if (q->offload)
 			htb_parent_to_leaf_offload(sch, dev_queue, new_q);
-		}
 	}
 
 	sch_tree_lock(sch);
@@ -1946,13 +1934,9 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 		new_q = qdisc_create_dflt(dev_queue, &pfifo_qdisc_ops,
 					  classid, NULL);
 		if (q->offload) {
-			if (new_q) {
-				htb_set_lockdep_class_child(new_q);
-				/* One ref for cl->leaf.q, the other for
-				 * dev_queue->qdisc.
-				 */
+			/* One ref for cl->leaf.q, the other for dev_queue->qdisc. */
+			if (new_q)
 				qdisc_refcount_inc(new_q);
-			}
 			old_q = htb_graft_helper(dev_queue, new_q);
 			/* No qdisc_put needed. */
 			WARN_ON(!(old_q->flags & TCQ_F_BUILTIN));
-- 
2.43.0


