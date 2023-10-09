Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41BC7BDFE7
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377162AbjJINfV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377174AbjJINfV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:35:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAECAB
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:35:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC342C433C8;
        Mon,  9 Oct 2023 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858519;
        bh=2+3zaqiU20S13BDdC0UaIG8wUP1OdJn9RGBmBNWJCKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2wA3+Z9tbdi2dF1aIOs+avPga32AdvheCxIXc8JqedRKRkZkciuAutDD6P+bxIU3l
         SevCvJUsE7+17vDtXWZcmDGJuEJdgVlaxfWdIc//bub+jqWFIkkqz1aIQ4ApA2zIaK
         Ia4DK0UR49eMT5k9/9N+sKgHRZrMDdmngsqCeQ5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 016/226] netfilter: nf_tables: integrate pipapo into commit protocol
Date:   Mon,  9 Oct 2023 14:59:37 +0200
Message-ID: <20231009130127.156288812@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 212ed75dc5fb9d1423b3942c8f872a868cda3466 upstream.

The pipapo set backend follows copy-on-update approach, maintaining one
clone of the existing datastructure that is being updated. The clone
and current datastructures are swapped via rcu from the commit step.

The existing integration with the commit protocol is flawed because
there is no operation to clean up the clone if the transaction is
aborted. Moreover, the datastructure swap happens on set element
activation.

This patch adds two new operations for sets: commit and abort, these new
operations are invoked from the commit and abort steps, after the
transactions have been digested, and it updates the pipapo set backend
to use it.

This patch adds a new ->pending_update field to sets to maintain a list
of sets that require this new commit and abort operations.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  4 ++-
 net/netfilter/nf_tables_api.c     | 56 +++++++++++++++++++++++++++++++
 net/netfilter/nft_set_pipapo.c    | 55 +++++++++++++++++++++---------
 3 files changed, 99 insertions(+), 16 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index eec29dd6681ca..a3068ed0f3169 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -373,7 +373,8 @@ struct nft_set_ops {
 					       const struct nft_set *set,
 					       const struct nft_set_elem *elem,
 					       unsigned int flags);
-
+	void				(*commit)(const struct nft_set *set);
+	void				(*abort)(const struct nft_set *set);
 	u64				(*privsize)(const struct nlattr * const nla[],
 						    const struct nft_set_desc *desc);
 	bool				(*estimate)(const struct nft_set_desc *desc,
@@ -454,6 +455,7 @@ struct nft_set {
 	u16				udlen;
 	unsigned char			*udata;
 	struct nft_expr			*expr;
+	struct list_head		pending_update;
 	/* runtime data below here */
 	const struct nft_set_ops	*ops ____cacheline_aligned;
 	u16				flags:14,
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2669999d1bc9c..430dcd0f6c3b2 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4509,6 +4509,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	}
 
 	set->handle = nf_tables_alloc_handle(table);
+	INIT_LIST_HEAD(&set->pending_update);
 
 	err = nft_trans_set_add(&ctx, NFT_MSG_NEWSET, set);
 	if (err < 0)
@@ -8141,10 +8142,25 @@ static void nf_tables_commit_audit_log(struct list_head *adl, u32 generation)
 	}
 }
 
+static void nft_set_commit_update(struct list_head *set_update_list)
+{
+	struct nft_set *set, *next;
+
+	list_for_each_entry_safe(set, next, set_update_list, pending_update) {
+		list_del_init(&set->pending_update);
+
+		if (!set->ops->commit)
+			continue;
+
+		set->ops->commit(set);
+	}
+}
+
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
+	LIST_HEAD(set_update_list);
 	struct nft_trans_elem *te;
 	struct nft_chain *chain;
 	struct nft_table *table;
@@ -8310,6 +8326,11 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			nf_tables_setelem_notify(&trans->ctx, te->set,
 						 &te->elem,
 						 NFT_MSG_NEWSETELEM, 0);
+			if (te->set->ops->commit &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_DELSETELEM:
@@ -8321,6 +8342,11 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			te->set->ops->remove(net, te->set, &te->elem);
 			atomic_dec(&te->set->nelems);
 			te->set->ndeact--;
+			if (te->set->ops->commit &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			break;
 		case NFT_MSG_NEWOBJ:
 			if (nft_trans_obj_update(trans)) {
@@ -8381,6 +8407,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 		}
 	}
 
+	nft_set_commit_update(&set_update_list);
+
 	nft_commit_notify(net, NETLINK_CB(skb).portid);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
 	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
@@ -8437,10 +8465,25 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 	kfree(trans);
 }
 
+static void nft_set_abort_update(struct list_head *set_update_list)
+{
+	struct nft_set *set, *next;
+
+	list_for_each_entry_safe(set, next, set_update_list, pending_update) {
+		list_del_init(&set->pending_update);
+
+		if (!set->ops->abort)
+			continue;
+
+		set->ops->abort(set);
+	}
+}
+
 static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
+	LIST_HEAD(set_update_list);
 	struct nft_trans_elem *te;
 
 	if (action == NFNL_ABORT_VALIDATE &&
@@ -8529,6 +8572,12 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			te = (struct nft_trans_elem *)trans->data;
 			te->set->ops->remove(net, te->set, &te->elem);
 			atomic_dec(&te->set->nelems);
+
+			if (te->set->ops->abort &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			break;
 		case NFT_MSG_DELSETELEM:
 			te = (struct nft_trans_elem *)trans->data;
@@ -8537,6 +8586,11 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			te->set->ops->activate(net, te->set, &te->elem);
 			te->set->ndeact--;
 
+			if (te->set->ops->abort &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWOBJ:
@@ -8577,6 +8631,8 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		}
 	}
 
+	nft_set_abort_update(&set_update_list);
+
 	synchronize_rcu();
 
 	list_for_each_entry_safe_reverse(trans, next,
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 50f840e312b03..ce6c07ea7244b 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1603,17 +1603,10 @@ static void pipapo_free_fields(struct nft_pipapo_match *m)
 	}
 }
 
-/**
- * pipapo_reclaim_match - RCU callback to free fields from old matching data
- * @rcu:	RCU head
- */
-static void pipapo_reclaim_match(struct rcu_head *rcu)
+static void pipapo_free_match(struct nft_pipapo_match *m)
 {
-	struct nft_pipapo_match *m;
 	int i;
 
-	m = container_of(rcu, struct nft_pipapo_match, rcu);
-
 	for_each_possible_cpu(i)
 		kfree(*per_cpu_ptr(m->scratch, i));
 
@@ -1628,7 +1621,19 @@ static void pipapo_reclaim_match(struct rcu_head *rcu)
 }
 
 /**
- * pipapo_commit() - Replace lookup data with current working copy
+ * pipapo_reclaim_match - RCU callback to free fields from old matching data
+ * @rcu:	RCU head
+ */
+static void pipapo_reclaim_match(struct rcu_head *rcu)
+{
+	struct nft_pipapo_match *m;
+
+	m = container_of(rcu, struct nft_pipapo_match, rcu);
+	pipapo_free_match(m);
+}
+
+/**
+ * nft_pipapo_commit() - Replace lookup data with current working copy
  * @set:	nftables API set representation
  *
  * While at it, check if we should perform garbage collection on the working
@@ -1638,7 +1643,7 @@ static void pipapo_reclaim_match(struct rcu_head *rcu)
  * We also need to create a new working copy for subsequent insertions and
  * deletions.
  */
-static void pipapo_commit(const struct nft_set *set)
+static void nft_pipapo_commit(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_match *new_clone, *old;
@@ -1663,6 +1668,26 @@ static void pipapo_commit(const struct nft_set *set)
 	priv->clone = new_clone;
 }
 
+static void nft_pipapo_abort(const struct nft_set *set)
+{
+	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_match *new_clone, *m;
+
+	if (!priv->dirty)
+		return;
+
+	m = rcu_dereference(priv->match);
+
+	new_clone = pipapo_clone(m);
+	if (IS_ERR(new_clone))
+		return;
+
+	priv->dirty = false;
+
+	pipapo_free_match(priv->clone);
+	priv->clone = new_clone;
+}
+
 /**
  * nft_pipapo_activate() - Mark element reference as active given key, commit
  * @net:	Network namespace
@@ -1670,8 +1695,7 @@ static void pipapo_commit(const struct nft_set *set)
  * @elem:	nftables API element representation containing key data
  *
  * On insertion, elements are added to a copy of the matching data currently
- * in use for lookups, and not directly inserted into current lookup data, so
- * we'll take care of that by calling pipapo_commit() here. Both
+ * in use for lookups, and not directly inserted into current lookup data. Both
  * nft_pipapo_insert() and nft_pipapo_activate() are called once for each
  * element, hence we can't purpose either one as a real commit operation.
  */
@@ -1687,8 +1711,6 @@ static void nft_pipapo_activate(const struct net *net,
 
 	nft_set_elem_change_active(net, set, &e->ext);
 	nft_set_elem_clear_busy(&e->ext);
-
-	pipapo_commit(set);
 }
 
 /**
@@ -1938,7 +1960,6 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 		if (i == m->field_count) {
 			priv->dirty = true;
 			pipapo_drop(m, rulemap);
-			pipapo_commit(set);
 			return;
 		}
 
@@ -2245,6 +2266,8 @@ const struct nft_set_type nft_set_pipapo_type = {
 		.init		= nft_pipapo_init,
 		.destroy	= nft_pipapo_destroy,
 		.gc_init	= nft_pipapo_gc_init,
+		.commit		= nft_pipapo_commit,
+		.abort		= nft_pipapo_abort,
 		.elemsize	= offsetof(struct nft_pipapo_elem, ext),
 	},
 };
@@ -2267,6 +2290,8 @@ const struct nft_set_type nft_set_pipapo_avx2_type = {
 		.init		= nft_pipapo_init,
 		.destroy	= nft_pipapo_destroy,
 		.gc_init	= nft_pipapo_gc_init,
+		.commit		= nft_pipapo_commit,
+		.abort		= nft_pipapo_abort,
 		.elemsize	= offsetof(struct nft_pipapo_elem, ext),
 	},
 };
-- 
2.40.1



