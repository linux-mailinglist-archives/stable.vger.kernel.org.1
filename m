Return-Path: <stable+bounces-113582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC53A292FF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E163AD898
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5071D18A93F;
	Wed,  5 Feb 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SqfNCNVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068EADF59;
	Wed,  5 Feb 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767453; cv=none; b=ARZ12KzHtuqYLv/oZlXmwIH08TRRV2+J5XR090R8FdyIQpSflmo/j99ITttuYmOHNUfkUimEwF2LYQW/f4ORPvDBC7LEQGh5JdsNbU2u+Vnxmurj/YsPIDe5VZNs3guCf7PqsJJYBSyaY3+1hrsQK+YimMVPkOQNqJwKdRsnjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767453; c=relaxed/simple;
	bh=pKdF255n6l3nuj/Hf7uEgNgS8CTv2cgznkYkMWKU1zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfV1u8hqjW9CqPvz+qa1UlWWbrWdWIufqSQn5voWIu4ZX5v4P84ZS7c+vOQMzUJ3BTIkqL8533Oo/9kTqFV5+ZeM62/XIvFcaMoclLMSbwNLSovrst6UOCYsmPn/d/yEalWDS23y/sr21YvkjD4qdIO3+AbkxzFFLF9FuZf4u0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SqfNCNVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6105CC4CED1;
	Wed,  5 Feb 2025 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767452;
	bh=pKdF255n6l3nuj/Hf7uEgNgS8CTv2cgznkYkMWKU1zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqfNCNVtXHstsFgzA5WyXK4owQjr8jJiQ5d1VlYpP2zE5RvKTu0AayeUwYtxQgsNk
	 bwRARqOCRjCZNjMT7CLEPCTWV6/r/XzqKMkKZKPHqtGHIRa+QzFhBjEJZUIDt+rUP5
	 jqAdlt+7b3hUQJy4a7dice4UDHBhN+TtulrZpJPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 459/590] xfrm: Cache used outbound xfrm states at the policy.
Date: Wed,  5 Feb 2025 14:43:34 +0100
Message-ID: <20250205134512.823877082@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit 0045e3d80613cc7174dc15f189ee6fc4e73b9365 ]

Now that we can have percpu xfrm states, the number of active
states might increase. To get a better lookup performance,
we cache the used xfrm states at the policy for outbound
IPsec traffic.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Tested-by: Antony Antony <antony.antony@secunet.com>
Tested-by: Tobias Brunner <tobias@strongswan.org>
Stable-dep-of: e952837f3ddb ("xfrm: state: fix out-of-bounds read during lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h     |  4 +++
 net/xfrm/xfrm_policy.c | 12 +++++++++
 net/xfrm/xfrm_state.c  | 55 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index f5275618e744e..0b394c5fb5f3a 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -184,6 +184,7 @@ struct xfrm_state {
 	};
 	struct hlist_node	byspi;
 	struct hlist_node	byseq;
+	struct hlist_node	state_cache;
 
 	refcount_t		refcnt;
 	spinlock_t		lock;
@@ -537,6 +538,7 @@ struct xfrm_policy_queue {
  *	@xp_net: network namespace the policy lives in
  *	@bydst: hlist node for SPD hash table or rbtree list
  *	@byidx: hlist node for index hash table
+ *	@state_cache_list: hlist head for policy cached xfrm states
  *	@lock: serialize changes to policy structure members
  *	@refcnt: reference count, freed once it reaches 0
  *	@pos: kernel internal tie-breaker to determine age of policy
@@ -567,6 +569,8 @@ struct xfrm_policy {
 	struct hlist_node	bydst;
 	struct hlist_node	byidx;
 
+	struct hlist_head	state_cache_list;
+
 	/* This lock only affects elements except for entry. */
 	rwlock_t		lock;
 	refcount_t		refcnt;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index a2ea9dbac90b3..8a1b83191a6cd 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -434,6 +434,7 @@ struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp)
 	if (policy) {
 		write_pnet(&policy->xp_net, net);
 		INIT_LIST_HEAD(&policy->walk.all);
+		INIT_HLIST_HEAD(&policy->state_cache_list);
 		INIT_HLIST_NODE(&policy->bydst);
 		INIT_HLIST_NODE(&policy->byidx);
 		rwlock_init(&policy->lock);
@@ -475,6 +476,9 @@ EXPORT_SYMBOL(xfrm_policy_destroy);
 
 static void xfrm_policy_kill(struct xfrm_policy *policy)
 {
+	struct net *net = xp_net(policy);
+	struct xfrm_state *x;
+
 	xfrm_dev_policy_delete(policy);
 
 	write_lock_bh(&policy->lock);
@@ -490,6 +494,13 @@ static void xfrm_policy_kill(struct xfrm_policy *policy)
 	if (del_timer(&policy->timer))
 		xfrm_pol_put(policy);
 
+	/* XXX: Flush state cache */
+	spin_lock_bh(&net->xfrm.xfrm_state_lock);
+	hlist_for_each_entry_rcu(x, &policy->state_cache_list, state_cache) {
+		hlist_del_init_rcu(&x->state_cache);
+	}
+	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+
 	xfrm_pol_put(policy);
 }
 
@@ -3275,6 +3286,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 		dst_release(dst);
 		dst = dst_orig;
 	}
+
 ok:
 	xfrm_pols_put(pols, drop_pols);
 	if (dst && dst->xfrm &&
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ebef07b80afad..a2047825f6c88 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -665,6 +665,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		refcount_set(&x->refcnt, 1);
 		atomic_set(&x->tunnel_users, 0);
 		INIT_LIST_HEAD(&x->km.all);
+		INIT_HLIST_NODE(&x->state_cache);
 		INIT_HLIST_NODE(&x->bydst);
 		INIT_HLIST_NODE(&x->bysrc);
 		INIT_HLIST_NODE(&x->byspi);
@@ -744,12 +745,15 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
 	if (x->km.state != XFRM_STATE_DEAD) {
 		x->km.state = XFRM_STATE_DEAD;
+
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		list_del(&x->km.all);
 		hlist_del_rcu(&x->bydst);
 		hlist_del_rcu(&x->bysrc);
 		if (x->km.seq)
 			hlist_del_rcu(&x->byseq);
+		if (!hlist_unhashed(&x->state_cache))
+			hlist_del_rcu(&x->state_cache);
 		if (x->id.spi)
 			hlist_del_rcu(&x->byspi);
 		net->xfrm.state_num--;
@@ -1222,6 +1226,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	unsigned int sequence;
 	struct km_event c;
 	unsigned int pcpu_id;
+	bool cached = false;
 
 	/* We need the cpu id just as a lookup key,
 	 * we don't require it to be stable.
@@ -1234,6 +1239,46 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	sequence = read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
 
 	rcu_read_lock();
+	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
+		if (x->props.family == encap_family &&
+		    x->props.reqid == tmpl->reqid &&
+		    (mark & x->mark.m) == x->mark.v &&
+		    x->if_id == if_id &&
+		    !(x->props.flags & XFRM_STATE_WILDRECV) &&
+		    xfrm_state_addr_check(x, daddr, saddr, encap_family) &&
+		    tmpl->mode == x->props.mode &&
+		    tmpl->id.proto == x->id.proto &&
+		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
+			xfrm_state_look_at(pol, x, fl, encap_family,
+					   &best, &acquire_in_progress, &error);
+	}
+
+	if (best)
+		goto cached;
+
+	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
+		if (x->props.family == encap_family &&
+		    x->props.reqid == tmpl->reqid &&
+		    (mark & x->mark.m) == x->mark.v &&
+		    x->if_id == if_id &&
+		    !(x->props.flags & XFRM_STATE_WILDRECV) &&
+		    xfrm_addr_equal(&x->id.daddr, daddr, encap_family) &&
+		    tmpl->mode == x->props.mode &&
+		    tmpl->id.proto == x->id.proto &&
+		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
+			xfrm_state_look_at(pol, x, fl, family,
+					   &best, &acquire_in_progress, &error);
+	}
+
+cached:
+	cached = true;
+	if (best)
+		goto found;
+	else if (error)
+		best = NULL;
+	else if (acquire_in_progress) /* XXX: acquire_in_progress should not happen */
+		WARN_ON(1);
+
 	h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
 	hlist_for_each_entry_rcu(x, net->xfrm.state_bydst + h, bydst) {
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -1383,6 +1428,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			XFRM_STATE_INSERT(bysrc, &x->bysrc,
 					  net->xfrm.state_bysrc + h,
 					  x->xso.type);
+			INIT_HLIST_NODE(&x->state_cache);
 			if (x->id.spi) {
 				h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
 				XFRM_STATE_INSERT(byspi, &x->byspi,
@@ -1431,6 +1477,15 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	} else {
 		*err = acquire_in_progress ? -EAGAIN : error;
 	}
+
+	if (x && x->km.state == XFRM_STATE_VALID && !cached &&
+	    (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
+		spin_lock_bh(&net->xfrm.xfrm_state_lock);
+		if (hlist_unhashed(&x->state_cache))
+			hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
+		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+	}
+
 	rcu_read_unlock();
 	if (to_put)
 		xfrm_state_put(to_put);
-- 
2.39.5




