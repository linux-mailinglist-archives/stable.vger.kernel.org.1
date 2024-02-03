Return-Path: <stable+bounces-18325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA04B848247
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8134728A73E
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D8482DF;
	Sat,  3 Feb 2024 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="il8NttIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AF812E49;
	Sat,  3 Feb 2024 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933717; cv=none; b=aUz5mOA7MHND5Ol8agO1Al64jgcdEFpq7gcWx+vTyhu9OIc/P/GIofZMs1P8ydpqKnP05ZzSgIustjrF4UuWDIx43mgW3yvnUMH69k555yYTIb0o9mtlDz8RYS4ejuGLr0fLnltllK2oq2DfLsUrAgDVF7jsN8t6zrCg08WCg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933717; c=relaxed/simple;
	bh=0xEuSz1OMQw0Y0GAngp5752nO3DFYuJJlSPn6aS4xL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTOs7R4Uuqz8s517y3nNiChST/zSHlF+LmvZza5p0BG5D1psrK+AyLrEid6/we5ZMC4ghZHKIPy6VOSQ06/rSbrnyFYoAdneR+mKm1HCJe84imTaJZ1mZbsm9vJ04BXB56I3ph71/Wx9tdDMEEY0sm0wjzVkWerq8ivKxF+d9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=il8NttIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE158C433F1;
	Sat,  3 Feb 2024 04:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933716;
	bh=0xEuSz1OMQw0Y0GAngp5752nO3DFYuJJlSPn6aS4xL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=il8NttIRm0dZtbjI5AJVCaD9Wnn4lZhQzbuQN6SJht0RSr2CzuCB1YbL2PvaTXiLB
	 KSV26HR+yL1LPpa9J5cFnHhl1sRCwdR9EciQ39hnTYwkqhwmQlgnZQztOWrvRYAhFe
	 8X48AFJyZmN55F6wGoUok0t4jBRQEpqpOG5tcOHA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ale Crismani <ale.crismani@automattic.com>,
	David Wang <00107082@163.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 295/322] netfilter: ipset: fix performance regression in swap operation
Date: Fri,  2 Feb 2024 20:06:32 -0800
Message-ID: <20240203035408.592513874@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

From: Jozsef Kadlecsik <kadlec@netfilter.org>

[ Upstream commit 97f7cf1cd80eeed3b7c808b7c12463295c751001 ]

The patch "netfilter: ipset: fix race condition between swap/destroy
and kernel side add/del/test", commit 28628fa9 fixes a race condition.
But the synchronize_rcu() added to the swap function unnecessarily slows
it down: it can safely be moved to destroy and use call_rcu() instead.

Eric Dumazet pointed out that simply calling the destroy functions as
rcu callback does not work: sets with timeout use garbage collectors
which need cancelling at destroy which can wait. Therefore the destroy
functions are split into two: cancelling garbage collectors safely at
executing the command received by netlink and moving the remaining
part only into the rcu callback.

Link: https://lore.kernel.org/lkml/C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com/
Fixes: 28628fa952fe ("netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test")
Reported-by: Ale Crismani <ale.crismani@automattic.com>
Reported-by: David Wang <00107082@163.com>
Tested-by: David Wang <00107082@163.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter/ipset/ip_set.h  |  4 +++
 net/netfilter/ipset/ip_set_bitmap_gen.h | 14 ++++++++--
 net/netfilter/ipset/ip_set_core.c       | 37 +++++++++++++++++++------
 net/netfilter/ipset/ip_set_hash_gen.h   | 15 ++++++++--
 net/netfilter/ipset/ip_set_list_set.c   | 13 +++++++--
 5 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
index e8c350a3ade1..e9f4f845d760 100644
--- a/include/linux/netfilter/ipset/ip_set.h
+++ b/include/linux/netfilter/ipset/ip_set.h
@@ -186,6 +186,8 @@ struct ip_set_type_variant {
 	/* Return true if "b" set is the same as "a"
 	 * according to the create set parameters */
 	bool (*same_set)(const struct ip_set *a, const struct ip_set *b);
+	/* Cancel ongoing garbage collectors before destroying the set*/
+	void (*cancel_gc)(struct ip_set *set);
 	/* Region-locking is used */
 	bool region_lock;
 };
@@ -242,6 +244,8 @@ extern void ip_set_type_unregister(struct ip_set_type *set_type);
 
 /* A generic IP set */
 struct ip_set {
+	/* For call_cru in destroy */
+	struct rcu_head rcu;
 	/* The name of the set */
 	char name[IPSET_MAXNAMELEN];
 	/* Lock protecting the set data */
diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipset/ip_set_bitmap_gen.h
index 26ab0e9612d8..9523104a90da 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -28,6 +28,7 @@
 #define mtype_del		IPSET_TOKEN(MTYPE, _del)
 #define mtype_list		IPSET_TOKEN(MTYPE, _list)
 #define mtype_gc		IPSET_TOKEN(MTYPE, _gc)
+#define mtype_cancel_gc		IPSET_TOKEN(MTYPE, _cancel_gc)
 #define mtype			MTYPE
 
 #define get_ext(set, map, id)	((map)->extensions + ((set)->dsize * (id)))
@@ -57,9 +58,6 @@ mtype_destroy(struct ip_set *set)
 {
 	struct mtype *map = set->data;
 
-	if (SET_WITH_TIMEOUT(set))
-		del_timer_sync(&map->gc);
-
 	if (set->dsize && set->extensions & IPSET_EXT_DESTROY)
 		mtype_ext_cleanup(set);
 	ip_set_free(map->members);
@@ -288,6 +286,15 @@ mtype_gc(struct timer_list *t)
 	add_timer(&map->gc);
 }
 
+static void
+mtype_cancel_gc(struct ip_set *set)
+{
+	struct mtype *map = set->data;
+
+	if (SET_WITH_TIMEOUT(set))
+		del_timer_sync(&map->gc);
+}
+
 static const struct ip_set_type_variant mtype = {
 	.kadt	= mtype_kadt,
 	.uadt	= mtype_uadt,
@@ -301,6 +308,7 @@ static const struct ip_set_type_variant mtype = {
 	.head	= mtype_head,
 	.list	= mtype_list,
 	.same_set = mtype_same_set,
+	.cancel_gc = mtype_cancel_gc,
 };
 
 #endif /* __IP_SET_BITMAP_IP_GEN_H */
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 4c133e06be1d..bcaad9c009fe 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1182,6 +1182,14 @@ ip_set_destroy_set(struct ip_set *set)
 	kfree(set);
 }
 
+static void
+ip_set_destroy_set_rcu(struct rcu_head *head)
+{
+	struct ip_set *set = container_of(head, struct ip_set, rcu);
+
+	ip_set_destroy_set(set);
+}
+
 static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			  const struct nlattr * const attr[])
 {
@@ -1193,8 +1201,6 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 	if (unlikely(protocol_min_failed(attr)))
 		return -IPSET_ERR_PROTOCOL;
 
-	/* Must wait for flush to be really finished in list:set */
-	rcu_barrier();
 
 	/* Commands are serialized and references are
 	 * protected by the ip_set_ref_lock.
@@ -1206,8 +1212,10 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 	 * counter, so if it's already zero, we can proceed
 	 * without holding the lock.
 	 */
-	read_lock_bh(&ip_set_ref_lock);
 	if (!attr[IPSET_ATTR_SETNAME]) {
+		/* Must wait for flush to be really finished in list:set */
+		rcu_barrier();
+		read_lock_bh(&ip_set_ref_lock);
 		for (i = 0; i < inst->ip_set_max; i++) {
 			s = ip_set(inst, i);
 			if (s && (s->ref || s->ref_netlink)) {
@@ -1221,6 +1229,8 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			s = ip_set(inst, i);
 			if (s) {
 				ip_set(inst, i) = NULL;
+				/* Must cancel garbage collectors */
+				s->variant->cancel_gc(s);
 				ip_set_destroy_set(s);
 			}
 		}
@@ -1228,6 +1238,9 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 		inst->is_destroyed = false;
 	} else {
 		u32 flags = flag_exist(info->nlh);
+		u16 features = 0;
+
+		read_lock_bh(&ip_set_ref_lock);
 		s = find_set_and_id(inst, nla_data(attr[IPSET_ATTR_SETNAME]),
 				    &i);
 		if (!s) {
@@ -1238,10 +1251,16 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
 			ret = -IPSET_ERR_BUSY;
 			goto out;
 		}
+		features = s->type->features;
 		ip_set(inst, i) = NULL;
 		read_unlock_bh(&ip_set_ref_lock);
-
-		ip_set_destroy_set(s);
+		if (features & IPSET_TYPE_NAME) {
+			/* Must wait for flush to be really finished  */
+			rcu_barrier();
+		}
+		/* Must cancel garbage collectors */
+		s->variant->cancel_gc(s);
+		call_rcu(&s->rcu, ip_set_destroy_set_rcu);
 	}
 	return 0;
 out:
@@ -1394,9 +1413,6 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
-	/* Make sure all readers of the old set pointers are completed. */
-	synchronize_rcu();
-
 	return 0;
 }
 
@@ -2409,8 +2425,11 @@ ip_set_fini(void)
 {
 	nf_unregister_sockopt(&so_set);
 	nfnetlink_subsys_unregister(&ip_set_netlink_subsys);
-
 	unregister_pernet_subsys(&ip_set_net_ops);
+
+	/* Wait for call_rcu() in destroy */
+	rcu_barrier();
+
 	pr_debug("these are the famous last words\n");
 }
 
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 7c2399541771..c62998b46f00 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -221,6 +221,7 @@ static const union nf_inet_addr zeromask = {};
 #undef mtype_gc_do
 #undef mtype_gc
 #undef mtype_gc_init
+#undef mtype_cancel_gc
 #undef mtype_variant
 #undef mtype_data_match
 
@@ -265,6 +266,7 @@ static const union nf_inet_addr zeromask = {};
 #define mtype_gc_do		IPSET_TOKEN(MTYPE, _gc_do)
 #define mtype_gc		IPSET_TOKEN(MTYPE, _gc)
 #define mtype_gc_init		IPSET_TOKEN(MTYPE, _gc_init)
+#define mtype_cancel_gc		IPSET_TOKEN(MTYPE, _cancel_gc)
 #define mtype_variant		IPSET_TOKEN(MTYPE, _variant)
 #define mtype_data_match	IPSET_TOKEN(MTYPE, _data_match)
 
@@ -449,9 +451,6 @@ mtype_destroy(struct ip_set *set)
 	struct htype *h = set->data;
 	struct list_head *l, *lt;
 
-	if (SET_WITH_TIMEOUT(set))
-		cancel_delayed_work_sync(&h->gc.dwork);
-
 	mtype_ahash_destroy(set, ipset_dereference_nfnl(h->table), true);
 	list_for_each_safe(l, lt, &h->ad) {
 		list_del(l);
@@ -598,6 +597,15 @@ mtype_gc_init(struct htable_gc *gc)
 	queue_delayed_work(system_power_efficient_wq, &gc->dwork, HZ);
 }
 
+static void
+mtype_cancel_gc(struct ip_set *set)
+{
+	struct htype *h = set->data;
+
+	if (SET_WITH_TIMEOUT(set))
+		cancel_delayed_work_sync(&h->gc.dwork);
+}
+
 static int
 mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	  struct ip_set_ext *mext, u32 flags);
@@ -1440,6 +1448,7 @@ static const struct ip_set_type_variant mtype_variant = {
 	.uref	= mtype_uref,
 	.resize	= mtype_resize,
 	.same_set = mtype_same_set,
+	.cancel_gc = mtype_cancel_gc,
 	.region_lock = true,
 };
 
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index e162636525cf..6c3f28bc59b3 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -426,9 +426,6 @@ list_set_destroy(struct ip_set *set)
 	struct list_set *map = set->data;
 	struct set_elem *e, *n;
 
-	if (SET_WITH_TIMEOUT(set))
-		timer_shutdown_sync(&map->gc);
-
 	list_for_each_entry_safe(e, n, &map->members, list) {
 		list_del(&e->list);
 		ip_set_put_byindex(map->net, e->id);
@@ -545,6 +542,15 @@ list_set_same_set(const struct ip_set *a, const struct ip_set *b)
 	       a->extensions == b->extensions;
 }
 
+static void
+list_set_cancel_gc(struct ip_set *set)
+{
+	struct list_set *map = set->data;
+
+	if (SET_WITH_TIMEOUT(set))
+		timer_shutdown_sync(&map->gc);
+}
+
 static const struct ip_set_type_variant set_variant = {
 	.kadt	= list_set_kadt,
 	.uadt	= list_set_uadt,
@@ -558,6 +564,7 @@ static const struct ip_set_type_variant set_variant = {
 	.head	= list_set_head,
 	.list	= list_set_list,
 	.same_set = list_set_same_set,
+	.cancel_gc = list_set_cancel_gc,
 };
 
 static void
-- 
2.43.0




