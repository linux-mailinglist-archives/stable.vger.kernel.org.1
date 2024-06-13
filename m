Return-Path: <stable+bounces-50682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D896F906BE6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDD428386B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFF1144D0A;
	Thu, 13 Jun 2024 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UCGfsGn1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B8143C6C;
	Thu, 13 Jun 2024 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279079; cv=none; b=SD11HpmPFJwgjd8OEjVB+Np7cxfUTbrRa63cdLayGI4ODgiqwFMkX89m6oSB5TTsbk/VCtX4UP1MeSgUfLZIPPUgovT6psoDhoLTQH0MfoXniDTdCXMevcZ+atEKih/y8rVcLc7ZPr6RH28wy0If9BfJRWfspQ9zzVm2eQHVsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279079; c=relaxed/simple;
	bh=185XKVECyi+GQcWL6baiD2W2qMDUESTxbLwiWryjsOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeDNZJcT0qCMZqTOiLxkn4blLhynis5GmbpGlL1A0WjCcnQFU4SzFCW+LbaOumLnRva75goFuqhWA0fmmU7M/xkefa6bXosKKp5Io2Xe+8n8+MdoSt+V8AewXPgu9QTZRNnQOYuCj8vvP81D5tD2RGJMvAb/YpRUFVg2cUptpDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UCGfsGn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23063C2BBFC;
	Thu, 13 Jun 2024 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279079;
	bh=185XKVECyi+GQcWL6baiD2W2qMDUESTxbLwiWryjsOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCGfsGn14v2NUKFuirH3hEjc8WFFokaZkVsOp93oJYNoigqf1+KGczV+xK0DJRh17
	 OT3qm93rpYK9GUBvh0o4TPHTCEIUUjk8Sp4IDKa5CKea0jNhmUdgbHkhQpIJ/l9yNZ
	 2+EPUWho5OwmLEctzu8rm8/UGsitL+l/uA60TSbk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 168/213] netfilter: nf_tables: GC transaction API to avoid race with control plane
Date: Thu, 13 Jun 2024 13:33:36 +0200
Message-ID: <20240613113234.464096393@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 5f68718b34a531a556f2f50300ead2862278da26 upstream.

[ this includes
  8357bc946a2a ("netfilter: nf_tables: use correct lock to protect gc_list") ]

The set types rhashtable and rbtree use a GC worker to reclaim memory.
>From system work queue, in periodic intervals, a scan of the table is
done.

The major caveat here is that the nft transaction mutex is not held.
This causes a race between control plane and GC when they attempt to
delete the same element.

We cannot grab the netlink mutex from the work queue, because the
control plane has to wait for the GC work queue in case the set is to be
removed, so we get following deadlock:

   cpu 1                                cpu2
     GC work                            transaction comes in , lock nft mutex
       `acquire nft mutex // BLOCKS
                                        transaction asks to remove the set
                                        set destruction calls cancel_work_sync()

cancel_work_sync will now block forever, because it is waiting for the
mutex the caller already owns.

This patch adds a new API that deals with garbage collection in two
steps:

1) Lockless GC of expired elements sets on the NFT_SET_ELEM_DEAD_BIT
   so they are not visible via lookup. Annotate current GC sequence in
   the GC transaction. Enqueue GC transaction work as soon as it is
   full. If ruleset is updated, then GC transaction is aborted and
   retried later.

2) GC work grabs the mutex. If GC sequence has changed then this GC
   transaction lost race with control plane, abort it as it contains
   stale references to objects and let GC try again later. If the
   ruleset is intact, then this GC transaction deactivates and removes
   the elements and it uses call_rcu() to destroy elements.

Note that no elements are removed from GC lockless path, the _DEAD bit
is set and pointers are collected. GC catchall does not remove the
elements anymore too. There is a new set->dead flag that is set on to
abort the GC transaction to deal with set->ops->destroy() path which
removes the remaining elements in the set from commit_release, where no
mutex is held.

To deal with GC when mutex is held, which allows safe deactivate and
removal, add sync GC API which releases the set element object via
call_rcu(). This is used by rbtree and pipapo backends which also
perform garbage collection from control plane path.

Since element removal from sets can happen from control plane and
element garbage collection/timeout, it is necessary to keep the set
structure alive until all elements have been deactivated and destroyed.

We cannot do a cancel_work_sync or flush_work in nft_set_destroy because
its called with the transaction mutex held, but the aforementioned async
work queue might be blocked on the very mutex that nft_set_destroy()
callchain is sitting on.

This gives us the choice of ABBA deadlock or UaF.

To avoid both, add set->refs refcount_t member. The GC API can then
increment the set refcount and release it once the elements have been
free'd.

Set backends are adapted to use the GC transaction API in a follow up
patch entitled:

  ("netfilter: nf_tables: use gc transaction API in set backends")

This is joint work with Florian Westphal.

Fixes: cfed7e1b1f8e ("netfilter: nf_tables: add set garbage collection helpers")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_tables.h |   61 ++++++++++
 net/netfilter/nf_tables_api.c     |  225 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 276 insertions(+), 10 deletions(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -380,6 +380,7 @@ void nft_unregister_set(struct nft_set_t
  *
  *	@list: table set list node
  *	@bindings: list of set bindings
+ *	@refs: internal refcounting for async set destruction
  *	@table: table this set belongs to
  *	@net: netnamespace this set belongs to
  * 	@name: name of the set
@@ -406,6 +407,7 @@ void nft_unregister_set(struct nft_set_t
 struct nft_set {
 	struct list_head		list;
 	struct list_head		bindings;
+	refcount_t			refs;
 	struct nft_table		*table;
 	possible_net_t			net;
 	char				*name;
@@ -424,7 +426,8 @@ struct nft_set {
 	unsigned char			*udata;
 	/* runtime data below here */
 	const struct nft_set_ops	*ops ____cacheline_aligned;
-	u16				flags:14,
+	u16				flags:13,
+					dead:1,
 					genmask:2;
 	u8				klen;
 	u8				dlen;
@@ -1346,6 +1349,32 @@ static inline void nft_set_elem_clear_bu
 	clear_bit(NFT_SET_ELEM_BUSY_BIT, word);
 }
 
+#define NFT_SET_ELEM_DEAD_MASK (1 << 3)
+
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+#define NFT_SET_ELEM_DEAD_BIT	3
+#elif defined(__BIG_ENDIAN_BITFIELD)
+#define NFT_SET_ELEM_DEAD_BIT	(BITS_PER_LONG - BITS_PER_BYTE + 3)
+#else
+#error
+#endif
+
+static inline void nft_set_elem_dead(struct nft_set_ext *ext)
+{
+	unsigned long *word = (unsigned long *)ext;
+
+	BUILD_BUG_ON(offsetof(struct nft_set_ext, genmask) != 0);
+	set_bit(NFT_SET_ELEM_DEAD_BIT, word);
+}
+
+static inline int nft_set_elem_is_dead(const struct nft_set_ext *ext)
+{
+	unsigned long *word = (unsigned long *)ext;
+
+	BUILD_BUG_ON(offsetof(struct nft_set_ext, genmask) != 0);
+	return test_bit(NFT_SET_ELEM_DEAD_BIT, word);
+}
+
 /**
  *	struct nft_trans - nf_tables object update in transaction
  *
@@ -1439,6 +1468,35 @@ struct nft_trans_flowtable {
 #define nft_trans_flowtable(trans)	\
 	(((struct nft_trans_flowtable *)trans->data)->flowtable)
 
+#define NFT_TRANS_GC_BATCHCOUNT                256
+
+struct nft_trans_gc {
+	struct list_head	list;
+	struct net		*net;
+	struct nft_set		*set;
+	u32			seq;
+	u8			count;
+	void			*priv[NFT_TRANS_GC_BATCHCOUNT];
+	struct rcu_head		rcu;
+};
+
+struct nft_trans_gc *nft_trans_gc_alloc(struct nft_set *set,
+					unsigned int gc_seq, gfp_t gfp);
+void nft_trans_gc_destroy(struct nft_trans_gc *trans);
+
+struct nft_trans_gc *nft_trans_gc_queue_async(struct nft_trans_gc *gc,
+					      unsigned int gc_seq, gfp_t gfp);
+void nft_trans_gc_queue_async_done(struct nft_trans_gc *gc);
+
+struct nft_trans_gc *nft_trans_gc_queue_sync(struct nft_trans_gc *gc, gfp_t gfp);
+void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans);
+
+void nft_trans_gc_elem_add(struct nft_trans_gc *gc, void *priv);
+
+void nft_setelem_data_deactivate(const struct net *net,
+				 const struct nft_set *set,
+				 struct nft_set_elem *elem);
+
 int __init nft_chain_filter_init(void);
 void nft_chain_filter_fini(void);
 
@@ -1451,6 +1509,7 @@ struct nftables_pernet {
 	struct mutex		commit_mutex;
 	unsigned int		base_seq;
 	u8			validate_state;
+	unsigned int		gc_seq;
 };
 
 #endif /* _NET_NF_TABLES_H */
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -29,10 +29,13 @@
 #define NFT_SET_MAX_ANONLEN 16
 
 unsigned int nf_tables_net_id __read_mostly;
+EXPORT_SYMBOL_GPL(nf_tables_net_id);
 
 static LIST_HEAD(nf_tables_expressions);
 static LIST_HEAD(nf_tables_objects);
 static LIST_HEAD(nf_tables_flowtables);
+static LIST_HEAD(nf_tables_gc_list);
+static DEFINE_SPINLOCK(nf_tables_gc_list_lock);
 static u64 table_handle;
 
 enum {
@@ -73,6 +76,9 @@ static void nft_validate_state_update(st
 	nft_net->validate_state = new_validate_state;
 }
 
+static void nft_trans_gc_work(struct work_struct *work);
+static DECLARE_WORK(trans_gc_work, nft_trans_gc_work);
+
 static void nft_ctx_init(struct nft_ctx *ctx,
 			 struct net *net,
 			 const struct sk_buff *skb,
@@ -388,10 +394,6 @@ static int nft_trans_set_add(const struc
 	return 0;
 }
 
-static void nft_setelem_data_deactivate(const struct net *net,
-					const struct nft_set *set,
-					struct nft_set_elem *elem);
-
 static int nft_mapelem_deactivate(const struct nft_ctx *ctx,
 				  struct nft_set *set,
 				  const struct nft_set_iter *iter,
@@ -3739,6 +3741,7 @@ static int nf_tables_newset(struct net *
 	}
 
 	INIT_LIST_HEAD(&set->bindings);
+	refcount_set(&set->refs, 1);
 	set->table = table;
 	write_pnet(&set->net, net);
 	set->ops   = ops;
@@ -3781,6 +3784,14 @@ err1:
 	return err;
 }
 
+static void nft_set_put(struct nft_set *set)
+{
+	if (refcount_dec_and_test(&set->refs)) {
+		kfree(set->name);
+		kvfree(set);
+	}
+}
+
 static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	if (WARN_ON(set->use > 0))
@@ -3788,8 +3799,7 @@ static void nft_set_destroy(const struct
 
 	set->ops->destroy(ctx, set);
 	module_put(to_set_type(set->ops)->owner);
-	kfree(set->name);
-	kvfree(set);
+	nft_set_put(set);
 }
 
 static int nf_tables_delset(struct net *net, struct sock *nlsk,
@@ -4888,9 +4898,9 @@ static void nft_setelem_data_activate(co
 		nft_use_inc_restore(&(*nft_set_ext_obj(ext))->use);
 }
 
-static void nft_setelem_data_deactivate(const struct net *net,
-					const struct nft_set *set,
-					struct nft_set_elem *elem)
+void nft_setelem_data_deactivate(const struct net *net,
+				 const struct nft_set *set,
+				 struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 
@@ -4899,6 +4909,7 @@ static void nft_setelem_data_deactivate(
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
 		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 }
+EXPORT_SYMBOL_GPL(nft_setelem_data_deactivate);
 
 static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 			   const struct nlattr *attr)
@@ -6732,6 +6743,186 @@ static void nft_chain_del(struct nft_cha
 	list_del_rcu(&chain->list);
 }
 
+static void nft_trans_gc_setelem_remove(struct nft_ctx *ctx,
+					struct nft_trans_gc *trans)
+{
+	void **priv = trans->priv;
+	unsigned int i;
+
+	for (i = 0; i < trans->count; i++) {
+		struct nft_set_elem elem = {
+			.priv = priv[i],
+		};
+
+		nft_setelem_data_deactivate(ctx->net, trans->set, &elem);
+		trans->set->ops->remove(trans->net, trans->set, &elem);
+	}
+}
+
+void nft_trans_gc_destroy(struct nft_trans_gc *trans)
+{
+	nft_set_put(trans->set);
+	put_net(trans->net);
+	kfree(trans);
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_destroy);
+
+static void nft_trans_gc_trans_free(struct rcu_head *rcu)
+{
+	struct nft_set_elem elem = {};
+	struct nft_trans_gc *trans;
+	struct nft_ctx ctx = {};
+	unsigned int i;
+
+	trans = container_of(rcu, struct nft_trans_gc, rcu);
+	ctx.net = read_pnet(&trans->set->net);
+
+	for (i = 0; i < trans->count; i++) {
+		elem.priv = trans->priv[i];
+		atomic_dec(&trans->set->nelems);
+
+		nf_tables_set_elem_destroy(&ctx, trans->set, elem.priv);
+       }
+
+	nft_trans_gc_destroy(trans);
+}
+
+static bool nft_trans_gc_work_done(struct nft_trans_gc *trans)
+{
+	struct nftables_pernet *nft_net;
+	struct nft_ctx ctx = {};
+
+	nft_net = net_generic(trans->net, nf_tables_net_id);
+
+	mutex_lock(&nft_net->commit_mutex);
+
+	/* Check for race with transaction, otherwise this batch refers to
+	 * stale objects that might not be there anymore. Skip transaction if
+	 * set has been destroyed from control plane transaction in case gc
+	 * worker loses race.
+	 */
+	if (READ_ONCE(nft_net->gc_seq) != trans->seq || trans->set->dead) {
+		mutex_unlock(&nft_net->commit_mutex);
+		return false;
+	}
+
+	ctx.net = trans->net;
+	ctx.table = trans->set->table;
+
+	nft_trans_gc_setelem_remove(&ctx, trans);
+	mutex_unlock(&nft_net->commit_mutex);
+
+	return true;
+}
+
+static void nft_trans_gc_work(struct work_struct *work)
+{
+	struct nft_trans_gc *trans, *next;
+	LIST_HEAD(trans_gc_list);
+
+	spin_lock(&nf_tables_gc_list_lock);
+	list_splice_init(&nf_tables_gc_list, &trans_gc_list);
+	spin_unlock(&nf_tables_gc_list_lock);
+
+	list_for_each_entry_safe(trans, next, &trans_gc_list, list) {
+		list_del(&trans->list);
+		if (!nft_trans_gc_work_done(trans)) {
+			nft_trans_gc_destroy(trans);
+			continue;
+		}
+		call_rcu(&trans->rcu, nft_trans_gc_trans_free);
+	}
+}
+
+struct nft_trans_gc *nft_trans_gc_alloc(struct nft_set *set,
+					unsigned int gc_seq, gfp_t gfp)
+{
+	struct net *net = read_pnet(&set->net);
+	struct nft_trans_gc *trans;
+
+	trans = kzalloc(sizeof(*trans), gfp);
+	if (!trans)
+		return NULL;
+
+	refcount_inc(&set->refs);
+	trans->set = set;
+	trans->net = get_net(net);
+	trans->seq = gc_seq;
+
+	return trans;
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_alloc);
+
+void nft_trans_gc_elem_add(struct nft_trans_gc *trans, void *priv)
+{
+	trans->priv[trans->count++] = priv;
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_elem_add);
+
+static void nft_trans_gc_queue_work(struct nft_trans_gc *trans)
+{
+	spin_lock(&nf_tables_gc_list_lock);
+	list_add_tail(&trans->list, &nf_tables_gc_list);
+	spin_unlock(&nf_tables_gc_list_lock);
+
+	schedule_work(&trans_gc_work);
+}
+
+static int nft_trans_gc_space(struct nft_trans_gc *trans)
+{
+	return NFT_TRANS_GC_BATCHCOUNT - trans->count;
+}
+
+struct nft_trans_gc *nft_trans_gc_queue_async(struct nft_trans_gc *gc,
+					      unsigned int gc_seq, gfp_t gfp)
+{
+	if (nft_trans_gc_space(gc))
+		return gc;
+
+	nft_trans_gc_queue_work(gc);
+
+	return nft_trans_gc_alloc(gc->set, gc_seq, gfp);
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_queue_async);
+
+void nft_trans_gc_queue_async_done(struct nft_trans_gc *trans)
+{
+	if (trans->count == 0) {
+		nft_trans_gc_destroy(trans);
+		return;
+	}
+
+	nft_trans_gc_queue_work(trans);
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_queue_async_done);
+
+struct nft_trans_gc *nft_trans_gc_queue_sync(struct nft_trans_gc *gc, gfp_t gfp)
+{
+	if (WARN_ON_ONCE(!lockdep_commit_lock_is_held(gc->net)))
+		return NULL;
+
+	if (nft_trans_gc_space(gc))
+		return gc;
+
+	call_rcu(&gc->rcu, nft_trans_gc_trans_free);
+
+	return nft_trans_gc_alloc(gc->set, 0, gfp);
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_queue_sync);
+
+void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans)
+{
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(trans->net));
+
+	if (trans->count == 0) {
+		nft_trans_gc_destroy(trans);
+		return;
+	}
+
+	call_rcu(&trans->rcu, nft_trans_gc_trans_free);
+}
+EXPORT_SYMBOL_GPL(nft_trans_gc_queue_sync_done);
+
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
@@ -6739,6 +6930,7 @@ static int nf_tables_commit(struct net *
 	struct nft_trans_elem *te;
 	struct nft_chain *chain;
 	struct nft_table *table;
+	unsigned int gc_seq;
 
 	list_for_each_entry(trans, &nft_net->binding_list, binding_list) {
 		switch (trans->msg_type) {
@@ -6785,6 +6977,10 @@ static int nf_tables_commit(struct net *
 	while (++nft_net->base_seq == 0)
 		;
 
+	/* Bump gc counter, it becomes odd, this is the busy mark. */
+	gc_seq = READ_ONCE(nft_net->gc_seq);
+	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+
 	/* step 3. Start new generation, rules_gen_X now in use. */
 	net->nft.gencursor = nft_gencursor_next(net);
 
@@ -6855,6 +7051,7 @@ static int nf_tables_commit(struct net *
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_DELSET:
+			nft_trans_set(trans)->dead = 1;
 			list_del_rcu(&nft_trans_set(trans)->list);
 			nf_tables_set_notify(&trans->ctx, nft_trans_set(trans),
 					     NFT_MSG_DELSET, GFP_KERNEL);
@@ -6909,6 +7106,8 @@ static int nf_tables_commit(struct net *
 
 	nf_tables_commit_release(net);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
+
+	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return 0;
@@ -7715,6 +7914,7 @@ static int __net_init nf_tables_init_net
 	mutex_init(&nft_net->commit_mutex);
 	nft_net->base_seq = 1;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
+	nft_net->gc_seq = 0;
 
 	return 0;
 }
@@ -7731,9 +7931,15 @@ static void __net_exit nf_tables_exit_ne
 	WARN_ON_ONCE(!list_empty(&nft_net->tables));
 }
 
+static void nf_tables_exit_batch(struct list_head *net_exit_list)
+{
+	flush_work(&trans_gc_work);
+}
+
 static struct pernet_operations nf_tables_net_ops = {
 	.init	= nf_tables_init_net,
 	.exit	= nf_tables_exit_net,
+	.exit_batch = nf_tables_exit_batch,
 	.id	= &nf_tables_net_id,
 	.size	= sizeof(struct nftables_pernet),
 };
@@ -7781,6 +7987,7 @@ static void __exit nf_tables_module_exit
 	unregister_netdevice_notifier(&nf_tables_flowtable_notifier);
 	nft_chain_filter_fini();
 	unregister_pernet_subsys(&nf_tables_net_ops);
+	cancel_work_sync(&trans_gc_work);
 	rcu_barrier();
 	nf_tables_core_module_exit();
 }



