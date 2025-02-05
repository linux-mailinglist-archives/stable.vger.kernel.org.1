Return-Path: <stable+bounces-113178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BA3A29052
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6607A1A02
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59D414B075;
	Wed,  5 Feb 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cRjtO2rb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A47DA6A;
	Wed,  5 Feb 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766086; cv=none; b=AjuXILDWdkIojH/LCnNlFZ5VSF+LbGIC+WSr5fu+D8q2dH0xaqFbTVOugQA1uazRPHiKk8KrrzoOnBNhFRFUDnQiMGth7ehIXNiAajsOUQeoKocak5oiU10ZNtGBzzrufk1MFn4xn/wEbSpIDL0eJfizt+EwkfYEhxYRYd/bJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766086; c=relaxed/simple;
	bh=v/h+atnKTWKxG3Z3Ui2+kGujKJII35f3Lwp5n5wyUno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhOUIJZS+EwX1xcFwvk0fVLPc6GR+55yVaeLULum8Obj0Bj0SZ/PLsKdHoZF3zY5fESmf0XFInHJ46tFOxTdUJ/iNuiLiqJQF+nbSgfBunFcuEXZ8gbpXrgQYdizGOWnuuqxUBZkJoXScMSfUed0I8E66QiBnmJ0ZCPa5M7YT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cRjtO2rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8CEC4CED1;
	Wed,  5 Feb 2025 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766086;
	bh=v/h+atnKTWKxG3Z3Ui2+kGujKJII35f3Lwp5n5wyUno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRjtO2rb4/way0frUAVZ7prweVeAwUaa/jcg3A+KeOek9iyVJWD1YRtmQuHxvFHSm
	 S1ZCKWyxDK8gAlwf0qYxdnn5mIG5ZE7c+IcPX4x2KkmyxysT6UeoYbdz7TqIIVW129
	 hSVERK2i+AaTg7NmoYaJUsg5dq9ram2alsxJViYU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuang Li <shuali@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 241/623] net: sched: refine software bypass handling in tc_run
Date: Wed,  5 Feb 2025 14:39:43 +0100
Message-ID: <20250205134505.447570384@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit a12c76a03386e32413ae8eaaefa337e491880632 ]

This patch addresses issues with filter counting in block (tcf_block),
particularly for software bypass scenarios, by introducing a more
accurate mechanism using useswcnt.

Previously, filtercnt and skipswcnt were introduced by:

  Commit 2081fd3445fe ("net: sched: cls_api: add filter counter") and
  Commit f631ef39d819 ("net: sched: cls_api: add skip_sw counter")

  filtercnt tracked all tp (tcf_proto) objects added to a block, and
  skipswcnt counted tp objects with the skipsw attribute set.

The problem is: a single tp can contain multiple filters, some with skipsw
and others without. The current implementation fails in the case:

  When the first filter in a tp has skipsw, both skipswcnt and filtercnt
  are incremented, then adding a second filter without skipsw to the same
  tp does not modify these counters because tp->counted is already set.

  This results in bypass software behavior based solely on skipswcnt
  equaling filtercnt, even when the block includes filters without
  skipsw. Consequently, filters without skipsw are inadvertently bypassed.

To address this, the patch introduces useswcnt in block to explicitly count
tp objects containing at least one filter without skipsw. Key changes
include:

  Whenever a filter without skipsw is added, its tp is marked with usesw
  and counted in useswcnt. tc_run() now uses useswcnt to determine software
  bypass, eliminating reliance on filtercnt and skipswcnt.

  This refined approach prevents software bypass for blocks containing
  mixed filters, ensuring correct behavior in tc_run().

Additionally, as atomic operations on useswcnt ensure thread safety and
tp->lock guards access to tp->usesw and tp->counted, the broader lock
down_write(&block->cb_lock) is no longer required in tc_new_tfilter(),
and this resolves a performance regression caused by the filter counting
mechanism during parallel filter insertions.

  The improvement can be demonstrated using the following script:

  # cat insert_tc_rules.sh

    tc qdisc add dev ens1f0np0 ingress
    for i in $(seq 16); do
        taskset -c $i tc -b rules_$i.txt &
    done
    wait

  Each of rules_$i.txt files above includes 100000 tc filter rules to a
  mlx5 driver NIC ens1f0np0.

  Without this patch:

  # time sh insert_tc_rules.sh

    real    0m50.780s
    user    0m23.556s
    sys	    4m13.032s

  With this patch:

  # time sh insert_tc_rules.sh

    real    0m17.718s
    user    0m7.807s
    sys     3m45.050s

Fixes: 047f340b36fc ("net: sched: make skip_sw actually skip software")
Reported-by: Shuang Li <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Tested-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/pkt_cls.h     | 13 +++++++--
 include/net/sch_generic.h |  5 ++--
 net/core/dev.c            | 15 ++++++-----
 net/sched/cls_api.c       | 57 ++++++++++++++++-----------------------
 net/sched/cls_bpf.c       |  2 ++
 net/sched/cls_flower.c    |  2 ++
 net/sched/cls_matchall.c  |  2 ++
 net/sched/cls_u32.c       |  4 +++
 8 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index cf199af85c52e..4eb0ebb9e76c7 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -75,11 +75,11 @@ static inline bool tcf_block_non_null_shared(struct tcf_block *block)
 }
 
 #ifdef CONFIG_NET_CLS_ACT
-DECLARE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
+DECLARE_STATIC_KEY_FALSE(tcf_sw_enabled_key);
 
 static inline bool tcf_block_bypass_sw(struct tcf_block *block)
 {
-	return block && block->bypass_wanted;
+	return block && !atomic_read(&block->useswcnt);
 }
 #endif
 
@@ -760,6 +760,15 @@ tc_cls_common_offload_init(struct flow_cls_common_offload *cls_common,
 		cls_common->extack = extack;
 }
 
+static inline void tcf_proto_update_usesw(struct tcf_proto *tp, u32 flags)
+{
+	if (tp->usesw)
+		return;
+	if (tc_skip_sw(flags) && tc_in_hw(flags))
+		return;
+	tp->usesw = true;
+}
+
 #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 static inline struct tc_skb_ext *tc_skb_ext_alloc(struct sk_buff *skb)
 {
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 5d74fa7e694cc..1e6324f0d4efd 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -425,6 +425,7 @@ struct tcf_proto {
 	spinlock_t		lock;
 	bool			deleting;
 	bool			counted;
+	bool			usesw;
 	refcount_t		refcnt;
 	struct rcu_head		rcu;
 	struct hlist_node	destroy_ht_node;
@@ -474,9 +475,7 @@ struct tcf_block {
 	struct flow_block flow_block;
 	struct list_head owner_list;
 	bool keep_dst;
-	bool bypass_wanted;
-	atomic_t filtercnt; /* Number of filters */
-	atomic_t skipswcnt; /* Number of skip_sw filters */
+	atomic_t useswcnt;
 	atomic_t offloadcnt; /* Number of oddloaded filters */
 	unsigned int nooffloaddevcnt; /* Number of devs unable to do offload */
 	unsigned int lockeddevcnt; /* Number of devs that require rtnl lock. */
diff --git a/net/core/dev.c b/net/core/dev.c
index 7600820bed6bd..71988f2f484b2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2136,8 +2136,8 @@ EXPORT_SYMBOL_GPL(net_dec_egress_queue);
 #endif
 
 #ifdef CONFIG_NET_CLS_ACT
-DEFINE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
-EXPORT_SYMBOL(tcf_bypass_check_needed_key);
+DEFINE_STATIC_KEY_FALSE(tcf_sw_enabled_key);
+EXPORT_SYMBOL(tcf_sw_enabled_key);
 #endif
 
 DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
@@ -4032,10 +4032,13 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 	if (!miniq)
 		return ret;
 
-	if (static_branch_unlikely(&tcf_bypass_check_needed_key)) {
-		if (tcf_block_bypass_sw(miniq->block))
-			return ret;
-	}
+	/* Global bypass */
+	if (!static_branch_likely(&tcf_sw_enabled_key))
+		return ret;
+
+	/* Block-wise bypass */
+	if (tcf_block_bypass_sw(miniq->block))
+		return ret;
 
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 7578e27260c9b..8e47e5355be61 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -390,6 +390,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
 	tp->protocol = protocol;
 	tp->prio = prio;
 	tp->chain = chain;
+	tp->usesw = !tp->ops->reoffload;
 	spin_lock_init(&tp->lock);
 	refcount_set(&tp->refcnt, 1);
 
@@ -410,39 +411,31 @@ static void tcf_proto_get(struct tcf_proto *tp)
 	refcount_inc(&tp->refcnt);
 }
 
-static void tcf_maintain_bypass(struct tcf_block *block)
+static void tcf_proto_count_usesw(struct tcf_proto *tp, bool add)
 {
-	int filtercnt = atomic_read(&block->filtercnt);
-	int skipswcnt = atomic_read(&block->skipswcnt);
-	bool bypass_wanted = filtercnt > 0 && filtercnt == skipswcnt;
-
-	if (bypass_wanted != block->bypass_wanted) {
 #ifdef CONFIG_NET_CLS_ACT
-		if (bypass_wanted)
-			static_branch_inc(&tcf_bypass_check_needed_key);
-		else
-			static_branch_dec(&tcf_bypass_check_needed_key);
-#endif
-		block->bypass_wanted = bypass_wanted;
+	struct tcf_block *block = tp->chain->block;
+	bool counted = false;
+
+	if (!add) {
+		if (tp->usesw && tp->counted) {
+			if (!atomic_dec_return(&block->useswcnt))
+				static_branch_dec(&tcf_sw_enabled_key);
+			tp->counted = false;
+		}
+		return;
 	}
-}
-
-static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add)
-{
-	lockdep_assert_not_held(&block->cb_lock);
 
-	down_write(&block->cb_lock);
-	if (*counted != add) {
-		if (add) {
-			atomic_inc(&block->filtercnt);
-			*counted = true;
-		} else {
-			atomic_dec(&block->filtercnt);
-			*counted = false;
-		}
+	spin_lock(&tp->lock);
+	if (tp->usesw && !tp->counted) {
+		counted = true;
+		tp->counted = true;
 	}
-	tcf_maintain_bypass(block);
-	up_write(&block->cb_lock);
+	spin_unlock(&tp->lock);
+
+	if (counted && atomic_inc_return(&block->useswcnt) == 1)
+		static_branch_inc(&tcf_sw_enabled_key);
+#endif
 }
 
 static void tcf_chain_put(struct tcf_chain *chain);
@@ -451,7 +444,7 @@ static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
 			      bool sig_destroy, struct netlink_ext_ack *extack)
 {
 	tp->ops->destroy(tp, rtnl_held, extack);
-	tcf_block_filter_cnt_update(tp->chain->block, &tp->counted, false);
+	tcf_proto_count_usesw(tp, false);
 	if (sig_destroy)
 		tcf_proto_signal_destroyed(tp->chain, tp);
 	tcf_chain_put(tp->chain);
@@ -2409,7 +2402,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
 			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
-		tcf_block_filter_cnt_update(block, &tp->counted, true);
+		tcf_proto_count_usesw(tp, true);
 		/* q pointer is NULL for shared blocks */
 		if (q)
 			q->flags &= ~TCQ_F_CAN_BYPASS;
@@ -3532,8 +3525,6 @@ static void tcf_block_offload_inc(struct tcf_block *block, u32 *flags)
 	if (*flags & TCA_CLS_FLAGS_IN_HW)
 		return;
 	*flags |= TCA_CLS_FLAGS_IN_HW;
-	if (tc_skip_sw(*flags))
-		atomic_inc(&block->skipswcnt);
 	atomic_inc(&block->offloadcnt);
 }
 
@@ -3542,8 +3533,6 @@ static void tcf_block_offload_dec(struct tcf_block *block, u32 *flags)
 	if (!(*flags & TCA_CLS_FLAGS_IN_HW))
 		return;
 	*flags &= ~TCA_CLS_FLAGS_IN_HW;
-	if (tc_skip_sw(*flags))
-		atomic_dec(&block->skipswcnt);
 	atomic_dec(&block->offloadcnt);
 }
 
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 1941ebec23ff9..7fbe42f0e5c2b 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -509,6 +509,8 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	if (!tc_in_hw(prog->gen_flags))
 		prog->gen_flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+	tcf_proto_update_usesw(tp, prog->gen_flags);
+
 	if (oldprog) {
 		idr_replace(&head->handle_idr, prog, handle);
 		list_replace_rcu(&oldprog->link, &prog->link);
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 1008ec8a464c9..03505673d5234 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2503,6 +2503,8 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	if (!tc_in_hw(fnew->flags))
 		fnew->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+	tcf_proto_update_usesw(tp, fnew->flags);
+
 	spin_lock(&tp->lock);
 
 	/* tp was deleted concurrently. -EAGAIN will cause caller to lookup
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index 9f1e62ca508d0..f03bf5da39ee8 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -228,6 +228,8 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 	if (!tc_in_hw(new->flags))
 		new->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+	tcf_proto_update_usesw(tp, new->flags);
+
 	*arg = head;
 	rcu_assign_pointer(tp->root, new);
 	return 0;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d3a03c57545bc..2a1c00048fd6f 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -951,6 +951,8 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!tc_in_hw(new->flags))
 			new->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+		tcf_proto_update_usesw(tp, new->flags);
+
 		u32_replace_knode(tp, tp_c, new);
 		tcf_unbind_filter(tp, &n->res);
 		tcf_exts_get_net(&n->exts);
@@ -1164,6 +1166,8 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+		tcf_proto_update_usesw(tp, n->flags);
+
 		ins = &ht->ht[TC_U32_HASH(handle)];
 		for (pins = rtnl_dereference(*ins); pins;
 		     ins = &pins->next, pins = rtnl_dereference(*ins))
-- 
2.39.5




