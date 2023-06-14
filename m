Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58172C198
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjFLK67 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjFLKym (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C14EC2
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:41:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A60612E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB972C433D2;
        Mon, 12 Jun 2023 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566467;
        bh=fd1KsW0MBP64/lvGeFIS2thFzQJ9M4DPwki4h35rhTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wW6lC7icrDTz/XYMOI30gz715MHeuxEbMtS1MH65RPsjzVxjSqzHuhStl4js/goI2
         4CP0c0zsTDd42YoGqqakq7SJvh8jpIG7g2a6KL4uGKQn/wrwCMLOgQvd6HAdXyDmRa
         LXZHTi1JZaf8GiNSXm+yNorlQrzAKjmX73dBftdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Vlad Buslov <vladbu@nvidia.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 043/132] net: sched: add rcu annotations around qdisc->qdisc_sleeping
Date:   Mon, 12 Jun 2023 12:26:17 +0200
Message-ID: <20230612101712.217291706@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d636fc5dd692c8f4e00ae6e0359c0eceeb5d9bdb ]

syzbot reported a race around qdisc->qdisc_sleeping [1]

It is time we add proper annotations to reads and writes to/from
qdisc->qdisc_sleeping.

[1]
BUG: KCSAN: data-race in dev_graft_qdisc / qdisc_lookup_rcu

read to 0xffff8881286fc618 of 8 bytes by task 6928 on cpu 1:
qdisc_lookup_rcu+0x192/0x2c0 net/sched/sch_api.c:331
__tcf_qdisc_find+0x74/0x3c0 net/sched/cls_api.c:1174
tc_get_tfilter+0x18f/0x990 net/sched/cls_api.c:2547
rtnetlink_rcv_msg+0x7af/0x8c0 net/core/rtnetlink.c:6386
netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2546
rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6413
netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
netlink_unicast+0x56f/0x640 net/netlink/af_netlink.c:1365
netlink_sendmsg+0x665/0x770 net/netlink/af_netlink.c:1913
sock_sendmsg_nosec net/socket.c:724 [inline]
sock_sendmsg net/socket.c:747 [inline]
____sys_sendmsg+0x375/0x4c0 net/socket.c:2503
___sys_sendmsg net/socket.c:2557 [inline]
__sys_sendmsg+0x1e3/0x270 net/socket.c:2586
__do_sys_sendmsg net/socket.c:2595 [inline]
__se_sys_sendmsg net/socket.c:2593 [inline]
__x64_sys_sendmsg+0x46/0x50 net/socket.c:2593
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to 0xffff8881286fc618 of 8 bytes by task 6912 on cpu 0:
dev_graft_qdisc+0x4f/0x80 net/sched/sch_generic.c:1115
qdisc_graft+0x7d0/0xb60 net/sched/sch_api.c:1103
tc_modify_qdisc+0x712/0xf10 net/sched/sch_api.c:1693
rtnetlink_rcv_msg+0x807/0x8c0 net/core/rtnetlink.c:6395
netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2546
rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6413
netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
netlink_unicast+0x56f/0x640 net/netlink/af_netlink.c:1365
netlink_sendmsg+0x665/0x770 net/netlink/af_netlink.c:1913
sock_sendmsg_nosec net/socket.c:724 [inline]
sock_sendmsg net/socket.c:747 [inline]
____sys_sendmsg+0x375/0x4c0 net/socket.c:2503
___sys_sendmsg net/socket.c:2557 [inline]
__sys_sendmsg+0x1e3/0x270 net/socket.c:2586
__do_sys_sendmsg net/socket.c:2595 [inline]
__se_sys_sendmsg net/socket.c:2593 [inline]
__x64_sys_sendmsg+0x46/0x50 net/socket.c:2593
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 6912 Comm: syz-executor.5 Not tainted 6.4.0-rc3-syzkaller-00190-g0d85b27b0cc6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/16/2023

Fixes: 3a7d0d07a386 ("net: sched: extend Qdisc with rcu")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vlad Buslov <vladbu@nvidia.com>
Acked-by: Jamal Hadi Salim<jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h |  2 +-
 include/net/sch_generic.h |  6 ++++--
 net/core/dev.c            |  2 +-
 net/sched/sch_api.c       | 26 ++++++++++++++++----------
 net/sched/sch_fq_pie.c    |  2 ++
 net/sched/sch_generic.c   | 30 +++++++++++++++---------------
 net/sched/sch_mq.c        |  8 ++++----
 net/sched/sch_mqprio.c    |  8 ++++----
 net/sched/sch_pie.c       |  5 ++++-
 net/sched/sch_red.c       |  5 ++++-
 net/sched/sch_sfq.c       |  5 ++++-
 net/sched/sch_taprio.c    |  6 +++---
 net/sched/sch_teql.c      |  2 +-
 13 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 74e05b82f1bf7..d5eb3ab8e38f2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -609,7 +609,7 @@ struct netdev_queue {
 	netdevice_tracker	dev_tracker;
 
 	struct Qdisc __rcu	*qdisc;
-	struct Qdisc		*qdisc_sleeping;
+	struct Qdisc __rcu	*qdisc_sleeping;
 #ifdef CONFIG_SYSFS
 	struct kobject		kobj;
 #endif
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index af4aa66aaa4eb..989eb972fcaec 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -543,7 +543,7 @@ static inline struct Qdisc *qdisc_root_bh(const struct Qdisc *qdisc)
 
 static inline struct Qdisc *qdisc_root_sleeping(const struct Qdisc *qdisc)
 {
-	return qdisc->dev_queue->qdisc_sleeping;
+	return rcu_dereference_rtnl(qdisc->dev_queue->qdisc_sleeping);
 }
 
 static inline spinlock_t *qdisc_root_sleeping_lock(const struct Qdisc *qdisc)
@@ -752,7 +752,9 @@ static inline bool qdisc_tx_changing(const struct net_device *dev)
 
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct netdev_queue *txq = netdev_get_tx_queue(dev, i);
-		if (rcu_access_pointer(txq->qdisc) != txq->qdisc_sleeping)
+
+		if (rcu_access_pointer(txq->qdisc) !=
+		    rcu_access_pointer(txq->qdisc_sleeping))
 			return true;
 	}
 	return false;
diff --git a/net/core/dev.c b/net/core/dev.c
index ee00d3cfcb564..a2e3c6470ab3f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10518,7 +10518,7 @@ struct netdev_queue *dev_ingress_queue_create(struct net_device *dev)
 		return NULL;
 	netdev_init_one_queue(dev, queue, NULL);
 	RCU_INIT_POINTER(queue->qdisc, &noop_qdisc);
-	queue->qdisc_sleeping = &noop_qdisc;
+	RCU_INIT_POINTER(queue->qdisc_sleeping, &noop_qdisc);
 	rcu_assign_pointer(dev->ingress_queue, queue);
 #endif
 	return queue;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index f6a7b876d5954..6fb345ec22641 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -308,7 +308,7 @@ struct Qdisc *qdisc_lookup(struct net_device *dev, u32 handle)
 
 	if (dev_ingress_queue(dev))
 		q = qdisc_match_from_root(
-			dev_ingress_queue(dev)->qdisc_sleeping,
+			rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping),
 			handle);
 out:
 	return q;
@@ -327,7 +327,8 @@ struct Qdisc *qdisc_lookup_rcu(struct net_device *dev, u32 handle)
 
 	nq = dev_ingress_queue_rcu(dev);
 	if (nq)
-		q = qdisc_match_from_root(nq->qdisc_sleeping, handle);
+		q = qdisc_match_from_root(rcu_dereference(nq->qdisc_sleeping),
+					  handle);
 out:
 	return q;
 }
@@ -633,8 +634,13 @@ EXPORT_SYMBOL(qdisc_watchdog_init);
 void qdisc_watchdog_schedule_range_ns(struct qdisc_watchdog *wd, u64 expires,
 				      u64 delta_ns)
 {
-	if (test_bit(__QDISC_STATE_DEACTIVATED,
-		     &qdisc_root_sleeping(wd->qdisc)->state))
+	bool deactivated;
+
+	rcu_read_lock();
+	deactivated = test_bit(__QDISC_STATE_DEACTIVATED,
+			       &qdisc_root_sleeping(wd->qdisc)->state);
+	rcu_read_unlock();
+	if (deactivated)
 		return;
 
 	if (hrtimer_is_queued(&wd->timer)) {
@@ -1473,7 +1479,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				}
 				q = qdisc_leaf(p, clid);
 			} else if (dev_ingress_queue(dev)) {
-				q = dev_ingress_queue(dev)->qdisc_sleeping;
+				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
 		} else {
 			q = rtnl_dereference(dev->qdisc);
@@ -1559,7 +1565,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				}
 				q = qdisc_leaf(p, clid);
 			} else if (dev_ingress_queue_create(dev)) {
-				q = dev_ingress_queue(dev)->qdisc_sleeping;
+				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
 		} else {
 			q = rtnl_dereference(dev->qdisc);
@@ -1800,8 +1806,8 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 
 		dev_queue = dev_ingress_queue(dev);
 		if (dev_queue &&
-		    tc_dump_qdisc_root(dev_queue->qdisc_sleeping, skb, cb,
-				       &q_idx, s_q_idx, false,
+		    tc_dump_qdisc_root(rtnl_dereference(dev_queue->qdisc_sleeping),
+				       skb, cb, &q_idx, s_q_idx, false,
 				       tca[TCA_DUMP_INVISIBLE]) < 0)
 			goto done;
 
@@ -2239,8 +2245,8 @@ static int tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb)
 
 	dev_queue = dev_ingress_queue(dev);
 	if (dev_queue &&
-	    tc_dump_tclass_root(dev_queue->qdisc_sleeping, skb, tcm, cb,
-				&t, s_t, false) < 0)
+	    tc_dump_tclass_root(rtnl_dereference(dev_queue->qdisc_sleeping),
+				skb, tcm, cb, &t, s_t, false) < 0)
 		goto done;
 
 done:
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index c699e5095607d..591d87d5e5c0f 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -379,6 +379,7 @@ static void fq_pie_timer(struct timer_list *t)
 	spinlock_t *root_lock; /* to lock qdisc for probability calculations */
 	u32 idx;
 
+	rcu_read_lock();
 	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 
@@ -391,6 +392,7 @@ static void fq_pie_timer(struct timer_list *t)
 		mod_timer(&q->adapt_timer, jiffies + q->p_params.tupdate);
 
 	spin_unlock(root_lock);
+	rcu_read_unlock();
 }
 
 static int fq_pie_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index a9aadc4e68581..ee43e8ac039ed 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -648,7 +648,7 @@ struct Qdisc_ops noop_qdisc_ops __read_mostly = {
 
 static struct netdev_queue noop_netdev_queue = {
 	RCU_POINTER_INITIALIZER(qdisc, &noop_qdisc),
-	.qdisc_sleeping	=	&noop_qdisc,
+	RCU_POINTER_INITIALIZER(qdisc_sleeping, &noop_qdisc),
 };
 
 struct Qdisc noop_qdisc = {
@@ -1103,7 +1103,7 @@ EXPORT_SYMBOL(qdisc_put_unlocked);
 struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 			      struct Qdisc *qdisc)
 {
-	struct Qdisc *oqdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *oqdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	spinlock_t *root_lock;
 
 	root_lock = qdisc_lock(oqdisc);
@@ -1112,7 +1112,7 @@ struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 	/* ... and graft new one */
 	if (qdisc == NULL)
 		qdisc = &noop_qdisc;
-	dev_queue->qdisc_sleeping = qdisc;
+	rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc);
 	rcu_assign_pointer(dev_queue->qdisc, &noop_qdisc);
 
 	spin_unlock_bh(root_lock);
@@ -1125,12 +1125,12 @@ static void shutdown_scheduler_queue(struct net_device *dev,
 				     struct netdev_queue *dev_queue,
 				     void *_qdisc_default)
 {
-	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	struct Qdisc *qdisc_default = _qdisc_default;
 
 	if (qdisc) {
 		rcu_assign_pointer(dev_queue->qdisc, qdisc_default);
-		dev_queue->qdisc_sleeping = qdisc_default;
+		rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc_default);
 
 		qdisc_put(qdisc);
 	}
@@ -1154,7 +1154,7 @@ static void attach_one_default_qdisc(struct net_device *dev,
 
 	if (!netif_is_multiqueue(dev))
 		qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
-	dev_queue->qdisc_sleeping = qdisc;
+	rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc);
 }
 
 static void attach_default_qdiscs(struct net_device *dev)
@@ -1167,7 +1167,7 @@ static void attach_default_qdiscs(struct net_device *dev)
 	if (!netif_is_multiqueue(dev) ||
 	    dev->priv_flags & IFF_NO_QUEUE) {
 		netdev_for_each_tx_queue(dev, attach_one_default_qdisc, NULL);
-		qdisc = txq->qdisc_sleeping;
+		qdisc = rtnl_dereference(txq->qdisc_sleeping);
 		rcu_assign_pointer(dev->qdisc, qdisc);
 		qdisc_refcount_inc(qdisc);
 	} else {
@@ -1186,7 +1186,7 @@ static void attach_default_qdiscs(struct net_device *dev)
 		netdev_for_each_tx_queue(dev, shutdown_scheduler_queue, &noop_qdisc);
 		dev->priv_flags |= IFF_NO_QUEUE;
 		netdev_for_each_tx_queue(dev, attach_one_default_qdisc, NULL);
-		qdisc = txq->qdisc_sleeping;
+		qdisc = rtnl_dereference(txq->qdisc_sleeping);
 		rcu_assign_pointer(dev->qdisc, qdisc);
 		qdisc_refcount_inc(qdisc);
 		dev->priv_flags ^= IFF_NO_QUEUE;
@@ -1202,7 +1202,7 @@ static void transition_one_qdisc(struct net_device *dev,
 				 struct netdev_queue *dev_queue,
 				 void *_need_watchdog)
 {
-	struct Qdisc *new_qdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *new_qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	int *need_watchdog_p = _need_watchdog;
 
 	if (!(new_qdisc->flags & TCQ_F_BUILTIN))
@@ -1272,7 +1272,7 @@ static void dev_reset_queue(struct net_device *dev,
 	struct Qdisc *qdisc;
 	bool nolock;
 
-	qdisc = dev_queue->qdisc_sleeping;
+	qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	if (!qdisc)
 		return;
 
@@ -1303,7 +1303,7 @@ static bool some_qdisc_is_busy(struct net_device *dev)
 		int val;
 
 		dev_queue = netdev_get_tx_queue(dev, i);
-		q = dev_queue->qdisc_sleeping;
+		q = rtnl_dereference(dev_queue->qdisc_sleeping);
 
 		root_lock = qdisc_lock(q);
 		spin_lock_bh(root_lock);
@@ -1379,7 +1379,7 @@ EXPORT_SYMBOL(dev_deactivate);
 static int qdisc_change_tx_queue_len(struct net_device *dev,
 				     struct netdev_queue *dev_queue)
 {
-	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	const struct Qdisc_ops *ops = qdisc->ops;
 
 	if (ops->change_tx_queue_len)
@@ -1404,7 +1404,7 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx)
 	unsigned int i;
 
 	for (i = new_real_tx; i < dev->real_num_tx_queues; i++) {
-		qdisc = netdev_get_tx_queue(dev, i)->qdisc_sleeping;
+		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, i)->qdisc_sleeping);
 		/* Only update the default qdiscs we created,
 		 * qdiscs with handles are always hashed.
 		 */
@@ -1412,7 +1412,7 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx)
 			qdisc_hash_del(qdisc);
 	}
 	for (i = dev->real_num_tx_queues; i < new_real_tx; i++) {
-		qdisc = netdev_get_tx_queue(dev, i)->qdisc_sleeping;
+		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, i)->qdisc_sleeping);
 		if (qdisc != &noop_qdisc && !qdisc->handle)
 			qdisc_hash_add(qdisc, false);
 	}
@@ -1449,7 +1449,7 @@ static void dev_init_scheduler_queue(struct net_device *dev,
 	struct Qdisc *qdisc = _qdisc;
 
 	rcu_assign_pointer(dev_queue->qdisc, qdisc);
-	dev_queue->qdisc_sleeping = qdisc;
+	rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc);
 }
 
 void dev_init_scheduler(struct net_device *dev)
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index d0bc660d7401f..c860119a8f091 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -141,7 +141,7 @@ static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 	 * qdisc totals are added at end.
 	 */
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
-		qdisc = netdev_get_tx_queue(dev, ntx)->qdisc_sleeping;
+		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
 		spin_lock_bh(qdisc_lock(qdisc));
 
 		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
@@ -202,7 +202,7 @@ static struct Qdisc *mq_leaf(struct Qdisc *sch, unsigned long cl)
 {
 	struct netdev_queue *dev_queue = mq_queue_get(sch, cl);
 
-	return dev_queue->qdisc_sleeping;
+	return rtnl_dereference(dev_queue->qdisc_sleeping);
 }
 
 static unsigned long mq_find(struct Qdisc *sch, u32 classid)
@@ -221,7 +221,7 @@ static int mq_dump_class(struct Qdisc *sch, unsigned long cl,
 
 	tcm->tcm_parent = TC_H_ROOT;
 	tcm->tcm_handle |= TC_H_MIN(cl);
-	tcm->tcm_info = dev_queue->qdisc_sleeping->handle;
+	tcm->tcm_info = rtnl_dereference(dev_queue->qdisc_sleeping)->handle;
 	return 0;
 }
 
@@ -230,7 +230,7 @@ static int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 {
 	struct netdev_queue *dev_queue = mq_queue_get(sch, cl);
 
-	sch = dev_queue->qdisc_sleeping;
+	sch = rtnl_dereference(dev_queue->qdisc_sleeping);
 	if (gnet_stats_copy_basic(d, sch->cpu_bstats, &sch->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, sch) < 0)
 		return -1;
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 4c68abaa289bd..9f26fb7d5823c 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -399,7 +399,7 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	 * qdisc totals are added at end.
 	 */
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
-		qdisc = netdev_get_tx_queue(dev, ntx)->qdisc_sleeping;
+		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
 		spin_lock_bh(qdisc_lock(qdisc));
 
 		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
@@ -449,7 +449,7 @@ static struct Qdisc *mqprio_leaf(struct Qdisc *sch, unsigned long cl)
 	if (!dev_queue)
 		return NULL;
 
-	return dev_queue->qdisc_sleeping;
+	return rtnl_dereference(dev_queue->qdisc_sleeping);
 }
 
 static unsigned long mqprio_find(struct Qdisc *sch, u32 classid)
@@ -482,7 +482,7 @@ static int mqprio_dump_class(struct Qdisc *sch, unsigned long cl,
 		tcm->tcm_parent = (tc < 0) ? 0 :
 			TC_H_MAKE(TC_H_MAJ(sch->handle),
 				  TC_H_MIN(tc + TC_H_MIN_PRIORITY));
-		tcm->tcm_info = dev_queue->qdisc_sleeping->handle;
+		tcm->tcm_info = rtnl_dereference(dev_queue->qdisc_sleeping)->handle;
 	} else {
 		tcm->tcm_parent = TC_H_ROOT;
 		tcm->tcm_info = 0;
@@ -538,7 +538,7 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	} else {
 		struct netdev_queue *dev_queue = mqprio_queue_get(sch, cl);
 
-		sch = dev_queue->qdisc_sleeping;
+		sch = rtnl_dereference(dev_queue->qdisc_sleeping);
 		if (gnet_stats_copy_basic(d, sch->cpu_bstats,
 					  &sch->bstats, true) < 0 ||
 		    qdisc_qstats_copy(d, sch) < 0)
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 265c238047a42..b60b31ef71cc5 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -421,8 +421,10 @@ static void pie_timer(struct timer_list *t)
 {
 	struct pie_sched_data *q = from_timer(q, t, adapt_timer);
 	struct Qdisc *sch = q->sch;
-	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
+	spinlock_t *root_lock;
 
+	rcu_read_lock();
+	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 	pie_calculate_probability(&q->params, &q->vars, sch->qstats.backlog);
 
@@ -430,6 +432,7 @@ static void pie_timer(struct timer_list *t)
 	if (q->params.tupdate)
 		mod_timer(&q->adapt_timer, jiffies + q->params.tupdate);
 	spin_unlock(root_lock);
+	rcu_read_unlock();
 }
 
 static int pie_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 98129324e1573..16277b6a0238d 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -321,12 +321,15 @@ static inline void red_adaptative_timer(struct timer_list *t)
 {
 	struct red_sched_data *q = from_timer(q, t, adapt_timer);
 	struct Qdisc *sch = q->sch;
-	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
+	spinlock_t *root_lock;
 
+	rcu_read_lock();
+	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 	red_adaptative_algo(&q->parms, &q->vars);
 	mod_timer(&q->adapt_timer, jiffies + HZ/2);
 	spin_unlock(root_lock);
+	rcu_read_unlock();
 }
 
 static int red_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index abd436307d6a8..66dcb18638fea 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -606,10 +606,12 @@ static void sfq_perturbation(struct timer_list *t)
 {
 	struct sfq_sched_data *q = from_timer(q, t, perturb_timer);
 	struct Qdisc *sch = q->sch;
-	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
+	spinlock_t *root_lock;
 	siphash_key_t nkey;
 
 	get_random_bytes(&nkey, sizeof(nkey));
+	rcu_read_lock();
+	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 	q->perturbation = nkey;
 	if (!q->filter_list && q->tail)
@@ -618,6 +620,7 @@ static void sfq_perturbation(struct timer_list *t)
 
 	if (q->perturb_period)
 		mod_timer(&q->perturb_timer, jiffies + q->perturb_period);
+	rcu_read_unlock();
 }
 
 static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index c322a61eaeeac..a274a9332f333 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2050,7 +2050,7 @@ static struct Qdisc *taprio_leaf(struct Qdisc *sch, unsigned long cl)
 	if (!dev_queue)
 		return NULL;
 
-	return dev_queue->qdisc_sleeping;
+	return rtnl_dereference(dev_queue->qdisc_sleeping);
 }
 
 static unsigned long taprio_find(struct Qdisc *sch, u32 classid)
@@ -2069,7 +2069,7 @@ static int taprio_dump_class(struct Qdisc *sch, unsigned long cl,
 
 	tcm->tcm_parent = TC_H_ROOT;
 	tcm->tcm_handle |= TC_H_MIN(cl);
-	tcm->tcm_info = dev_queue->qdisc_sleeping->handle;
+	tcm->tcm_info = rtnl_dereference(dev_queue->qdisc_sleeping)->handle;
 
 	return 0;
 }
@@ -2081,7 +2081,7 @@ static int taprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 {
 	struct netdev_queue *dev_queue = taprio_queue_get(sch, cl);
 
-	sch = dev_queue->qdisc_sleeping;
+	sch = rtnl_dereference(dev_queue->qdisc_sleeping);
 	if (gnet_stats_copy_basic(d, NULL, &sch->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, sch) < 0)
 		return -1;
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 16f9238aa51d1..7721239c185fb 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -297,7 +297,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 		struct net_device *slave = qdisc_dev(q);
 		struct netdev_queue *slave_txq = netdev_get_tx_queue(slave, 0);
 
-		if (slave_txq->qdisc_sleeping != q)
+		if (rcu_access_pointer(slave_txq->qdisc_sleeping) != q)
 			continue;
 		if (netif_xmit_stopped(netdev_get_tx_queue(slave, subq)) ||
 		    !netif_running(slave)) {
-- 
2.39.2



