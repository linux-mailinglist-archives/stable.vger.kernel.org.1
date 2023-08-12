Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1491477A127
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHLQx1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 12:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHLQx1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 12:53:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA60A7
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 09:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14F8F61EDB
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 16:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A93FC433C8;
        Sat, 12 Aug 2023 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691859197;
        bh=JsVIYMWGEjwoSnxlTL5J+cxiWJqHPKgkJ4MKmm9kmf0=;
        h=Subject:To:Cc:From:Date:From;
        b=LpaSi9VsG7EuIWjeCHQBhYkP27Fbpa8n3sHUfDJ/HOBsjPhdmzrbANXsgqGeKanU2
         UZC5cK//n6EstvSEX0p68T/F1cTEsN1wTQlYjLQF7gZ7/xKOJ0UQcdbdBMydt3e59w
         fb+M9+kd4L1VXmkN7gFLKAbo/8mobT13Xo3ZxPe8=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: adapt set backend to use GC transaction" failed to apply to 5.10-stable tree
To:     pablo@netfilter.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 18:53:14 +0200
Message-ID: <2023081214-unsteady-tablet-4621@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x f6c383b8c31a93752a52697f8430a71dcbc46adf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081214-unsteady-tablet-4621@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
f718863aca46 ("netfilter: nft_set_rbtree: fix overlap expiration walk")
212ed75dc5fb ("netfilter: nf_tables: integrate pipapo into commit protocol")
61ae320a29b0 ("netfilter: nft_set_rbtree: fix null deref on element insertion")
5d235d6ce75c ("netfilter: nft_set_rbtree: skip elements in transaction from garbage collection")
c9e6978e2725 ("netfilter: nft_set_rbtree: Switch to node list walk for overlap detection")
babc3dc9524f ("netfilter: nft_set_rbtree: overlap detection with element re-addition after deletion")
6fb721cf7818 ("netfilter: nf_tables: honor NLM_F_CREATE and NLM_F_EXCL in event notification")
e189ae161dd7 ("netfilter: nf_tables: add position handle in event notification")
ad9f151e560b ("netfilter: nf_tables: initialize set before expression setup")
aaa31047a6d2 ("netfilter: nftables: add catch-all set element support")
97c976d662fb ("netfilter: nftables: add helper function to validate set element data")
e6ba7cb63b8a ("netfilter: nftables: add helper function to flush set elements")
f8bb7889af58 ("netfilter: nftables: rename set element data activation/deactivation functions")
7dab8ee3b6e7 ("netfilter: nfnetlink: pass struct nfnl_info to batch callbacks")
797d49805ddc ("netfilter: nfnetlink: pass struct nfnl_info to rcu callbacks")
a65553657174 ("netfilter: nfnetlink: add struct nfnl_info and pass it to callbacks")
d59d2f82f984 ("netfilter: nftables: add nft_pernet() helper function")
0854db2aaef3 ("netfilter: nf_tables: use net_generic infra for transaction data")
ebfbe67568a7 ("netfilter: cttimeout: use net_generic infra")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6c383b8c31a93752a52697f8430a71dcbc46adf Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Wed, 9 Aug 2023 14:54:23 +0200
Subject: [PATCH] netfilter: nf_tables: adapt set backend to use GC transaction
 API

Use the GC transaction API to replace the old and buggy gc API and the
busy mark approach.

No set elements are removed from async garbage collection anymore,
instead the _DEAD bit is set on so the set element is not visible from
lookup path anymore. Async GC enqueues transaction work that might be
aborted and retried later.

rbtree and pipapo set backends does not set on the _DEAD bit from the
sync GC path since this runs in control plane path where mutex is held.
In this case, set elements are deactivated, removed and then released
via RCU callback, sync GC never fails.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Fixes: 8d8540c4f5e0 ("netfilter: nft_set_rbtree: add timeout support")
Fixes: 9d0982927e79 ("netfilter: nft_hash: add support for timeouts")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c28bacb9479b..fd4b5da7ac3c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6380,7 +6380,6 @@ static void nft_setelem_activate(struct net *net, struct nft_set *set,
 
 	if (nft_setelem_is_catchall(set, elem)) {
 		nft_set_elem_change_active(net, set, ext);
-		nft_set_elem_clear_busy(ext);
 	} else {
 		set->ops->activate(net, set, elem);
 	}
@@ -6395,8 +6394,7 @@ static int nft_setelem_catchall_deactivate(const struct net *net,
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_is_active(net, ext) ||
-		    nft_set_elem_mark_busy(ext))
+		if (!nft_is_active(net, ext))
 			continue;
 
 		kfree(elem->priv);
@@ -7109,8 +7107,7 @@ static int nft_set_catchall_flush(const struct nft_ctx *ctx,
 
 	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_set_elem_active(ext, genmask) ||
-		    nft_set_elem_mark_busy(ext))
+		if (!nft_set_elem_active(ext, genmask))
 			continue;
 
 		elem.priv = catchall->elem;
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 24caa31fa231..2f067e4596b0 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -59,6 +59,8 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 
 	if (memcmp(nft_set_ext_key(&he->ext), x->key, x->set->klen))
 		return 1;
+	if (nft_set_elem_is_dead(&he->ext))
+		return 1;
 	if (nft_set_elem_expired(&he->ext))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
@@ -188,7 +190,6 @@ static void nft_rhash_activate(const struct net *net, const struct nft_set *set,
 	struct nft_rhash_elem *he = elem->priv;
 
 	nft_set_elem_change_active(net, set, &he->ext);
-	nft_set_elem_clear_busy(&he->ext);
 }
 
 static bool nft_rhash_flush(const struct net *net,
@@ -196,12 +197,9 @@ static bool nft_rhash_flush(const struct net *net,
 {
 	struct nft_rhash_elem *he = priv;
 
-	if (!nft_set_elem_mark_busy(&he->ext) ||
-	    !nft_is_active(net, &he->ext)) {
-		nft_set_elem_change_active(net, set, &he->ext);
-		return true;
-	}
-	return false;
+	nft_set_elem_change_active(net, set, &he->ext);
+
+	return true;
 }
 
 static void *nft_rhash_deactivate(const struct net *net,
@@ -218,9 +216,8 @@ static void *nft_rhash_deactivate(const struct net *net,
 
 	rcu_read_lock();
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
-	if (he != NULL &&
-	    !nft_rhash_flush(net, set, he))
-		he = NULL;
+	if (he)
+		nft_set_elem_change_active(net, set, &he->ext);
 
 	rcu_read_unlock();
 
@@ -312,25 +309,48 @@ static bool nft_rhash_expr_needs_gc_run(const struct nft_set *set,
 
 static void nft_rhash_gc(struct work_struct *work)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_set *set;
 	struct nft_rhash_elem *he;
 	struct nft_rhash *priv;
-	struct nft_set_gc_batch *gcb = NULL;
 	struct rhashtable_iter hti;
+	struct nft_trans_gc *gc;
+	struct net *net;
+	u32 gc_seq;
 
 	priv = container_of(work, struct nft_rhash, gc_work.work);
 	set  = nft_set_container_of(priv);
+	net  = read_pnet(&set->net);
+	nft_net = nft_pernet(net);
+	gc_seq = READ_ONCE(nft_net->gc_seq);
+
+	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	if (!gc)
+		goto done;
 
 	rhashtable_walk_enter(&priv->ht, &hti);
 	rhashtable_walk_start(&hti);
 
 	while ((he = rhashtable_walk_next(&hti))) {
 		if (IS_ERR(he)) {
-			if (PTR_ERR(he) != -EAGAIN)
-				break;
+			if (PTR_ERR(he) != -EAGAIN) {
+				nft_trans_gc_destroy(gc);
+				gc = NULL;
+				goto try_later;
+			}
 			continue;
 		}
 
+		/* Ruleset has been updated, try later. */
+		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
+		}
+
+		if (nft_set_elem_is_dead(&he->ext))
+			goto dead_elem;
+
 		if (nft_set_ext_exists(&he->ext, NFT_SET_EXT_EXPRESSIONS) &&
 		    nft_rhash_expr_needs_gc_run(set, &he->ext))
 			goto needs_gc_run;
@@ -338,26 +358,26 @@ static void nft_rhash_gc(struct work_struct *work)
 		if (!nft_set_elem_expired(&he->ext))
 			continue;
 needs_gc_run:
-		if (nft_set_elem_mark_busy(&he->ext))
-			continue;
+		nft_set_elem_dead(&he->ext);
+dead_elem:
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
 
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (gcb == NULL)
-			break;
-		rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params);
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, he);
+		nft_trans_gc_elem_add(gc, he);
 	}
+
+	gc = nft_trans_gc_catchall(gc, gc_seq);
+
+try_later:
+	/* catchall list iteration requires rcu read side lock. */
 	rhashtable_walk_stop(&hti);
 	rhashtable_walk_exit(&hti);
 
-	he = nft_set_catchall_gc(set);
-	if (he) {
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (gcb)
-			nft_set_gc_batch_add(gcb, he);
-	}
-	nft_set_gc_batch_complete(gcb);
+	if (gc)
+		nft_trans_gc_queue_async_done(gc);
+
+done:
 	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
 			   nft_set_gc_interval(set));
 }
@@ -420,7 +440,6 @@ static void nft_rhash_destroy(const struct nft_ctx *ctx,
 	};
 
 	cancel_delayed_work_sync(&priv->gc_work);
-	rcu_barrier();
 	rhashtable_free_and_destroy(&priv->ht, nft_rhash_elem_destroy,
 				    (void *)&rhash_ctx);
 }
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index d54784ea465b..a5b8301afe4a 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1536,16 +1536,34 @@ static void pipapo_drop(struct nft_pipapo_match *m,
 	}
 }
 
+static void nft_pipapo_gc_deactivate(struct net *net, struct nft_set *set,
+				     struct nft_pipapo_elem *e)
+
+{
+	struct nft_set_elem elem = {
+		.priv	= e,
+	};
+
+	nft_setelem_data_deactivate(net, set, &elem);
+}
+
 /**
  * pipapo_gc() - Drop expired entries from set, destroy start and end elements
  * @set:	nftables API set representation
  * @m:		Matching data
  */
-static void pipapo_gc(const struct nft_set *set, struct nft_pipapo_match *m)
+static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 {
+	struct nft_set *set = (struct nft_set *) _set;
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct net *net = read_pnet(&set->net);
 	int rules_f0, first_rule = 0;
 	struct nft_pipapo_elem *e;
+	struct nft_trans_gc *gc;
+
+	gc = nft_trans_gc_alloc(set, 0, GFP_KERNEL);
+	if (!gc)
+		return;
 
 	while ((rules_f0 = pipapo_rules_same_key(m->f, first_rule))) {
 		union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
@@ -1569,13 +1587,20 @@ static void pipapo_gc(const struct nft_set *set, struct nft_pipapo_match *m)
 		f--;
 		i--;
 		e = f->mt[rulemap[i].to].e;
-		if (nft_set_elem_expired(&e->ext) &&
-		    !nft_set_elem_mark_busy(&e->ext)) {
-			priv->dirty = true;
-			pipapo_drop(m, rulemap);
 
-			rcu_barrier();
-			nft_set_elem_destroy(set, e, true);
+		/* synchronous gc never fails, there is no need to set on
+		 * NFT_SET_ELEM_DEAD_BIT.
+		 */
+		if (nft_set_elem_expired(&e->ext)) {
+			priv->dirty = true;
+
+			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+			if (!gc)
+				break;
+
+			nft_pipapo_gc_deactivate(net, set, e);
+			pipapo_drop(m, rulemap);
+			nft_trans_gc_elem_add(gc, e);
 
 			/* And check again current first rule, which is now the
 			 * first we haven't checked.
@@ -1585,11 +1610,11 @@ static void pipapo_gc(const struct nft_set *set, struct nft_pipapo_match *m)
 		}
 	}
 
-	e = nft_set_catchall_gc(set);
-	if (e)
-		nft_set_elem_destroy(set, e, true);
-
-	priv->last_gc = jiffies;
+	gc = nft_trans_gc_catchall(gc, 0);
+	if (gc) {
+		nft_trans_gc_queue_sync_done(gc);
+		priv->last_gc = jiffies;
+	}
 }
 
 /**
@@ -1714,7 +1739,6 @@ static void nft_pipapo_activate(const struct net *net,
 		return;
 
 	nft_set_elem_change_active(net, set, &e->ext);
-	nft_set_elem_clear_busy(&e->ext);
 }
 
 /**
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 39956e5341c9..f9d4c8fcbbf8 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -46,6 +46,12 @@ static int nft_rbtree_cmp(const struct nft_set *set,
 		      set->klen);
 }
 
+static bool nft_rbtree_elem_expired(const struct nft_rbtree_elem *rbe)
+{
+	return nft_set_elem_expired(&rbe->ext) ||
+	       nft_set_elem_is_dead(&rbe->ext);
+}
+
 static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
 				const u32 *key, const struct nft_set_ext **ext,
 				unsigned int seq)
@@ -80,7 +86,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 				continue;
 			}
 
-			if (nft_set_elem_expired(&rbe->ext))
+			if (nft_rbtree_elem_expired(rbe))
 				return false;
 
 			if (nft_rbtree_interval_end(rbe)) {
@@ -98,7 +104,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 
 	if (set->flags & NFT_SET_INTERVAL && interval != NULL &&
 	    nft_set_elem_active(&interval->ext, genmask) &&
-	    !nft_set_elem_expired(&interval->ext) &&
+	    !nft_rbtree_elem_expired(interval) &&
 	    nft_rbtree_interval_start(interval)) {
 		*ext = &interval->ext;
 		return true;
@@ -215,6 +221,18 @@ static void *nft_rbtree_get(const struct net *net, const struct nft_set *set,
 	return rbe;
 }
 
+static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
+				 struct nft_rbtree *priv,
+				 struct nft_rbtree_elem *rbe)
+{
+	struct nft_set_elem elem = {
+		.priv	= rbe,
+	};
+
+	nft_setelem_data_deactivate(net, set, &elem);
+	rb_erase(&rbe->node, &priv->root);
+}
+
 static int nft_rbtree_gc_elem(const struct nft_set *__set,
 			      struct nft_rbtree *priv,
 			      struct nft_rbtree_elem *rbe,
@@ -222,11 +240,12 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
+	struct net *net = read_pnet(&set->net);
 	struct nft_rbtree_elem *rbe_prev;
-	struct nft_set_gc_batch *gcb;
+	struct nft_trans_gc *gc;
 
-	gcb = nft_set_gc_batch_check(set, NULL, GFP_ATOMIC);
-	if (!gcb)
+	gc = nft_trans_gc_alloc(set, 0, GFP_ATOMIC);
+	if (!gc)
 		return -ENOMEM;
 
 	/* search for end interval coming before this element.
@@ -244,17 +263,28 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
 
 	if (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
+		nft_rbtree_gc_remove(net, set, priv, rbe_prev);
 
-		rb_erase(&rbe_prev->node, &priv->root);
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, rbe_prev);
+		/* There is always room in this trans gc for this element,
+		 * memory allocation never actually happens, hence, the warning
+		 * splat in such case. No need to set NFT_SET_ELEM_DEAD_BIT,
+		 * this is synchronous gc which never fails.
+		 */
+		gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+		if (WARN_ON_ONCE(!gc))
+			return -ENOMEM;
+
+		nft_trans_gc_elem_add(gc, rbe_prev);
 	}
 
-	rb_erase(&rbe->node, &priv->root);
-	atomic_dec(&set->nelems);
+	nft_rbtree_gc_remove(net, set, priv, rbe);
+	gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+	if (WARN_ON_ONCE(!gc))
+		return -ENOMEM;
 
-	nft_set_gc_batch_add(gcb, rbe);
-	nft_set_gc_batch_complete(gcb);
+	nft_trans_gc_elem_add(gc, rbe);
+
+	nft_trans_gc_queue_sync_done(gc);
 
 	return 0;
 }
@@ -482,7 +512,6 @@ static void nft_rbtree_activate(const struct net *net,
 	struct nft_rbtree_elem *rbe = elem->priv;
 
 	nft_set_elem_change_active(net, set, &rbe->ext);
-	nft_set_elem_clear_busy(&rbe->ext);
 }
 
 static bool nft_rbtree_flush(const struct net *net,
@@ -490,12 +519,9 @@ static bool nft_rbtree_flush(const struct net *net,
 {
 	struct nft_rbtree_elem *rbe = priv;
 
-	if (!nft_set_elem_mark_busy(&rbe->ext) ||
-	    !nft_is_active(net, &rbe->ext)) {
-		nft_set_elem_change_active(net, set, &rbe->ext);
-		return true;
-	}
-	return false;
+	nft_set_elem_change_active(net, set, &rbe->ext);
+
+	return true;
 }
 
 static void *nft_rbtree_deactivate(const struct net *net,
@@ -570,26 +596,40 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 static void nft_rbtree_gc(struct work_struct *work)
 {
-	struct nft_rbtree_elem *rbe, *rbe_end = NULL, *rbe_prev = NULL;
-	struct nft_set_gc_batch *gcb = NULL;
+	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
+	struct nftables_pernet *nft_net;
 	struct nft_rbtree *priv;
+	struct nft_trans_gc *gc;
 	struct rb_node *node;
 	struct nft_set *set;
+	unsigned int gc_seq;
 	struct net *net;
-	u8 genmask;
 
 	priv = container_of(work, struct nft_rbtree, gc_work.work);
 	set  = nft_set_container_of(priv);
 	net  = read_pnet(&set->net);
-	genmask = nft_genmask_cur(net);
+	nft_net = nft_pernet(net);
+	gc_seq  = READ_ONCE(nft_net->gc_seq);
+
+	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	if (!gc)
+		goto done;
 
 	write_lock_bh(&priv->lock);
 	write_seqcount_begin(&priv->count);
 	for (node = rb_first(&priv->root); node != NULL; node = rb_next(node)) {
+
+		/* Ruleset has been updated, try later. */
+		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
+		}
+
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
 
-		if (!nft_set_elem_active(&rbe->ext, genmask))
-			continue;
+		if (nft_set_elem_is_dead(&rbe->ext))
+			goto dead_elem;
 
 		/* elements are reversed in the rbtree for historical reasons,
 		 * from highest to lowest value, that is why end element is
@@ -602,46 +642,36 @@ static void nft_rbtree_gc(struct work_struct *work)
 		if (!nft_set_elem_expired(&rbe->ext))
 			continue;
 
-		if (nft_set_elem_mark_busy(&rbe->ext)) {
-			rbe_end = NULL;
+		nft_set_elem_dead(&rbe->ext);
+
+		if (!rbe_end)
 			continue;
-		}
 
-		if (rbe_prev) {
-			rb_erase(&rbe_prev->node, &priv->root);
-			rbe_prev = NULL;
-		}
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (!gcb)
-			break;
+		nft_set_elem_dead(&rbe_end->ext);
 
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, rbe);
-		rbe_prev = rbe;
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
 
-		if (rbe_end) {
-			atomic_dec(&set->nelems);
-			nft_set_gc_batch_add(gcb, rbe_end);
-			rb_erase(&rbe_end->node, &priv->root);
-			rbe_end = NULL;
-		}
-		node = rb_next(node);
-		if (!node)
-			break;
+		nft_trans_gc_elem_add(gc, rbe_end);
+		rbe_end = NULL;
+dead_elem:
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
+
+		nft_trans_gc_elem_add(gc, rbe);
 	}
-	if (rbe_prev)
-		rb_erase(&rbe_prev->node, &priv->root);
+
+	gc = nft_trans_gc_catchall(gc, gc_seq);
+
+try_later:
 	write_seqcount_end(&priv->count);
 	write_unlock_bh(&priv->lock);
 
-	rbe = nft_set_catchall_gc(set);
-	if (rbe) {
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (gcb)
-			nft_set_gc_batch_add(gcb, rbe);
-	}
-	nft_set_gc_batch_complete(gcb);
-
+	if (gc)
+		nft_trans_gc_queue_async_done(gc);
+done:
 	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
 			   nft_set_gc_interval(set));
 }

