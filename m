Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE8734BEE
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFSGy4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 02:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFSGyz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 02:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD33AC6
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 23:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AE1660DDD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 06:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E331C433C0;
        Mon, 19 Jun 2023 06:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687157692;
        bh=0QJrDEegyhz2tGrCv7ox/hxFwl/9FOsGc1CoyqBqEXM=;
        h=Subject:To:Cc:From:Date:From;
        b=AS/TZS5VnRT90aFnFKf2lXqA6wti+6tZg92j9O9sxi55HUWUf7znaIWP3EPQs+/wR
         fSru5Wlm0m0xIB/29hvvGr4R+JU8HpZb05vNSE99N4ZjyPnEiHQDFdZBJ8d0XFZYzG
         9crAIy/FQkW3TZatECGjY4MuaX9JDubn/x9lr5s0=
Subject: FAILED: patch "[PATCH] net/sched: qdisc_destroy() old ingress and clsact Qdiscs" failed to apply to 5.10-stable tree
To:     peilin.ye@bytedance.com, hdanton@sina.com, jhs@mojatatu.com,
        pabeni@redhat.com, vladbu@mellanox.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 19 Jun 2023 08:54:45 +0200
Message-ID: <2023061945-polish-remorse-02cf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 84ad0af0bccd3691cb951c2974c5cb2c10594d4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061945-polish-remorse-02cf@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 84ad0af0bccd3691cb951c2974c5cb2c10594d4a Mon Sep 17 00:00:00 2001
From: Peilin Ye <peilin.ye@bytedance.com>
Date: Sat, 10 Jun 2023 20:30:25 -0700
Subject: [PATCH] net/sched: qdisc_destroy() old ingress and clsact Qdiscs
 before grafting

mini_Qdisc_pair::p_miniq is a double pointer to mini_Qdisc, initialized
in ingress_init() to point to net_device::miniq_ingress.  ingress Qdiscs
access this per-net_device pointer in mini_qdisc_pair_swap().  Similar
for clsact Qdiscs and miniq_egress.

Unfortunately, after introducing RTNL-unlocked RTM_{NEW,DEL,GET}TFILTER
requests (thanks Hillf Danton for the hint), when replacing ingress or
clsact Qdiscs, for example, the old Qdisc ("@old") could access the same
miniq_{in,e}gress pointer(s) concurrently with the new Qdisc ("@new"),
causing race conditions [1] including a use-after-free bug in
mini_qdisc_pair_swap() reported by syzbot:

 BUG: KASAN: slab-use-after-free in mini_qdisc_pair_swap+0x1c2/0x1f0 net/sched/sch_generic.c:1573
 Write of size 8 at addr ffff888045b31308 by task syz-executor690/14901
...
 Call Trace:
  <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
  print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
  print_report mm/kasan/report.c:430 [inline]
  kasan_report+0x11c/0x130 mm/kasan/report.c:536
  mini_qdisc_pair_swap+0x1c2/0x1f0 net/sched/sch_generic.c:1573
  tcf_chain_head_change_item net/sched/cls_api.c:495 [inline]
  tcf_chain0_head_change.isra.0+0xb9/0x120 net/sched/cls_api.c:509
  tcf_chain_tp_insert net/sched/cls_api.c:1826 [inline]
  tcf_chain_tp_insert_unique net/sched/cls_api.c:1875 [inline]
  tc_new_tfilter+0x1de6/0x2290 net/sched/cls_api.c:2266
...

@old and @new should not affect each other.  In other words, @old should
never modify miniq_{in,e}gress after @new, and @new should not update
@old's RCU state.

Fixing without changing sch_api.c turned out to be difficult (please
refer to Closes: for discussions).  Instead, make sure @new's first call
always happen after @old's last call (in {ingress,clsact}_destroy()) has
finished:

In qdisc_graft(), return -EBUSY if @old has any ongoing filter requests,
and call qdisc_destroy() for @old before grafting @new.

Introduce qdisc_refcount_dec_if_one() as the counterpart of
qdisc_refcount_inc_nz() used for filter requests.  Introduce a
non-static version of qdisc_destroy() that does a TCQ_F_BUILTIN check,
just like qdisc_put() etc.

Depends on patch "net/sched: Refactor qdisc_graft() for ingress and
clsact Qdiscs".

[1] To illustrate, the syzkaller reproducer adds ingress Qdiscs under
TC_H_ROOT (no longer possible after commit c7cfbd115001 ("net/sched:
sch_ingress: Only create under TC_H_INGRESS")) on eth0 that has 8
transmission queues:

  Thread 1 creates ingress Qdisc A (containing mini Qdisc a1 and a2),
  then adds a flower filter X to A.

  Thread 2 creates another ingress Qdisc B (containing mini Qdisc b1 and
  b2) to replace A, then adds a flower filter Y to B.

 Thread 1               A's refcnt   Thread 2
  RTM_NEWQDISC (A, RTNL-locked)
   qdisc_create(A)               1
   qdisc_graft(A)                9

  RTM_NEWTFILTER (X, RTNL-unlocked)
   __tcf_qdisc_find(A)          10
   tcf_chain0_head_change(A)
   mini_qdisc_pair_swap(A) (1st)
            |
            |                         RTM_NEWQDISC (B, RTNL-locked)
         RCU sync                2     qdisc_graft(B)
            |                    1     notify_and_destroy(A)
            |
   tcf_block_release(A)          0    RTM_NEWTFILTER (Y, RTNL-unlocked)
   qdisc_destroy(A)                    tcf_chain0_head_change(B)
   tcf_chain0_head_change_cb_del(A)    mini_qdisc_pair_swap(B) (2nd)
   mini_qdisc_pair_swap(A) (3rd)                |
           ...                                 ...

Here, B calls mini_qdisc_pair_swap(), pointing eth0->miniq_ingress to
its mini Qdisc, b1.  Then, A calls mini_qdisc_pair_swap() again during
ingress_destroy(), setting eth0->miniq_ingress to NULL, so ingress
packets on eth0 will not find filter Y in sch_handle_ingress().

This is just one of the possible consequences of concurrently accessing
miniq_{in,e}gress pointers.

Fixes: 7a096d579e8e ("net: sched: ingress: set 'unlocked' flag for Qdisc ops")
Fixes: 87f373921c4e ("net: sched: ingress: set 'unlocked' flag for clsact Qdisc ops")
Reported-by: syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000006cf87705f79acf1a@google.com/
Cc: Hillf Danton <hdanton@sina.com>
Cc: Vlad Buslov <vladbu@mellanox.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 27271f2b37cb..12eadecf8cd0 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -137,6 +137,13 @@ static inline void qdisc_refcount_inc(struct Qdisc *qdisc)
 	refcount_inc(&qdisc->refcnt);
 }
 
+static inline bool qdisc_refcount_dec_if_one(struct Qdisc *qdisc)
+{
+	if (qdisc->flags & TCQ_F_BUILTIN)
+		return true;
+	return refcount_dec_if_one(&qdisc->refcnt);
+}
+
 /* Intended to be used by unlocked users, when concurrent qdisc release is
  * possible.
  */
@@ -652,6 +659,7 @@ void dev_deactivate_many(struct list_head *head);
 struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 			      struct Qdisc *qdisc);
 void qdisc_reset(struct Qdisc *qdisc);
+void qdisc_destroy(struct Qdisc *qdisc);
 void qdisc_put(struct Qdisc *qdisc);
 void qdisc_put_unlocked(struct Qdisc *qdisc);
 void qdisc_tree_reduce_backlog(struct Qdisc *qdisc, int n, int len);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 094ca3a5b633..aa6b1fe65151 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1086,10 +1086,22 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		if ((q && q->flags & TCQ_F_INGRESS) ||
 		    (new && new->flags & TCQ_F_INGRESS)) {
 			ingress = 1;
-			if (!dev_ingress_queue(dev)) {
+			dev_queue = dev_ingress_queue(dev);
+			if (!dev_queue) {
 				NL_SET_ERR_MSG(extack, "Device does not have an ingress queue");
 				return -ENOENT;
 			}
+
+			q = rtnl_dereference(dev_queue->qdisc_sleeping);
+
+			/* This is the counterpart of that qdisc_refcount_inc_nz() call in
+			 * __tcf_qdisc_find() for filter requests.
+			 */
+			if (!qdisc_refcount_dec_if_one(q)) {
+				NL_SET_ERR_MSG(extack,
+					       "Current ingress or clsact Qdisc has ongoing filter requests");
+				return -EBUSY;
+			}
 		}
 
 		if (dev->flags & IFF_UP)
@@ -1110,8 +1122,16 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 				qdisc_put(old);
 			}
 		} else {
-			dev_queue = dev_ingress_queue(dev);
-			old = dev_graft_qdisc(dev_queue, new);
+			old = dev_graft_qdisc(dev_queue, NULL);
+
+			/* {ingress,clsact}_destroy() @old before grafting @new to avoid
+			 * unprotected concurrent accesses to net_device::miniq_{in,e}gress
+			 * pointer(s) in mini_qdisc_pair_swap().
+			 */
+			qdisc_notify(net, skb, n, classid, old, new, extack);
+			qdisc_destroy(old);
+
+			dev_graft_qdisc(dev_queue, new);
 		}
 
 skip:
@@ -1125,8 +1145,6 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 
 			if (new && new->ops->attach)
 				new->ops->attach(new);
-		} else {
-			notify_and_destroy(net, skb, n, classid, old, new, extack);
 		}
 
 		if (dev->flags & IFF_UP)
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 3248259eba32..5d7e23f4cc0e 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1046,7 +1046,7 @@ static void qdisc_free_cb(struct rcu_head *head)
 	qdisc_free(q);
 }
 
-static void qdisc_destroy(struct Qdisc *qdisc)
+static void __qdisc_destroy(struct Qdisc *qdisc)
 {
 	const struct Qdisc_ops  *ops = qdisc->ops;
 
@@ -1070,6 +1070,14 @@ static void qdisc_destroy(struct Qdisc *qdisc)
 	call_rcu(&qdisc->rcu, qdisc_free_cb);
 }
 
+void qdisc_destroy(struct Qdisc *qdisc)
+{
+	if (qdisc->flags & TCQ_F_BUILTIN)
+		return;
+
+	__qdisc_destroy(qdisc);
+}
+
 void qdisc_put(struct Qdisc *qdisc)
 {
 	if (!qdisc)
@@ -1079,7 +1087,7 @@ void qdisc_put(struct Qdisc *qdisc)
 	    !refcount_dec_and_test(&qdisc->refcnt))
 		return;
 
-	qdisc_destroy(qdisc);
+	__qdisc_destroy(qdisc);
 }
 EXPORT_SYMBOL(qdisc_put);
 
@@ -1094,7 +1102,7 @@ void qdisc_put_unlocked(struct Qdisc *qdisc)
 	    !refcount_dec_and_rtnl_lock(&qdisc->refcnt))
 		return;
 
-	qdisc_destroy(qdisc);
+	__qdisc_destroy(qdisc);
 	rtnl_unlock();
 }
 EXPORT_SYMBOL(qdisc_put_unlocked);

