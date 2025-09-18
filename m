Return-Path: <stable+bounces-179874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C430B7E13C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E407B7BC4
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0813233F2;
	Wed, 17 Sep 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vzdjdyxO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991F1F3BA2;
	Wed, 17 Sep 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112677; cv=none; b=RHTVZosIhIzJmUilDHiVlqsKJgzo2FAdXmETp685lpUWIFx0sVCtUTe5a+td7SHK39C0DsQzjcmA+7gBNVYZnuA0GmM8n7KVZaGlSsQTPuA5YyTkBmg+sJZOa3jU1XbuWkjn1N9YvldnNudo+wPq2sLCEnitBwwoW4lFK3knVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112677; c=relaxed/simple;
	bh=x7I5ziHZnk5P3wdtapeU08pbczOXGMYIzVGPN5jOQ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gq26t/OcZcGuFC2xD5zJjZKBnq+UAkxZm6uJBq5gyTlUOY6dpuTIV9qfyE/oLlT5a22WVXtajQ0ysWGnhADdOmXFnE3rqrhf7cZFUzChReB63aRrnGhr9djaJRHkubosPGwnNXXIb4UCZdmJXWrXh2uKE1FpPCD5WXLYavCo/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vzdjdyxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D3CC4CEF0;
	Wed, 17 Sep 2025 12:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112677;
	bh=x7I5ziHZnk5P3wdtapeU08pbczOXGMYIzVGPN5jOQ7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vzdjdyxOuaxJ6CManaKXjiA1LRiYO+bQjcALxdQ9QlF/6TVKFktpq4bQhyP0gCOpD
	 OhBWm7rwFYD3G/FGTYIGEVC88FIUz7Gesdzg6KntxYGUnzLavMArvF1qvSncn0oAov
	 ndvDvag1y8VsGdT1GYCfzAKXdNfIaylN0XkNJ7lw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eryk Kubanski <e.kubanski@partner.samsung.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 042/189] xsk: Fix immature cq descriptor production
Date: Wed, 17 Sep 2025 14:32:32 +0200
Message-ID: <20250917123352.890015907@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit 30f241fcf52aaaef7ac16e66530faa11be78a865 ]

Eryk reported an issue that I have put under Closes: tag, related to
umem addrs being prematurely produced onto pool's completion queue.
Let us make the skb's destructor responsible for producing all addrs
that given skb used.

Commit from fixes tag introduced the buggy behavior, it was not broken
from day 1, but rather when xsk multi-buffer got introduced.

In order to mitigate performance impact as much as possible, mimic the
linear and frag parts within skb by storing the first address from XSK
descriptor at sk_buff::destructor_arg. For fragments, store them at ::cb
via list. The nodes that will go onto list will be allocated via
kmem_cache. xsk_destruct_skb() will consume address stored at
::destructor_arg and optionally go through list from ::cb, if count of
descriptors associated with this particular skb is bigger than 1.

Previous approach where whole array for storing UMEM addresses from XSK
descriptors was pre-allocated during first fragment processing yielded
too big performance regression for 64b traffic. In current approach
impact is much reduced on my tests and for jumbo frames I observed
traffic being slower by at most 9%.

Magnus suggested to have this way of processing special cased for
XDP_SHARED_UMEM, so we would identify this during bind and set different
hooks for 'backpressure mechanism' on CQ and for skb destructor, but
given that results looked promising on my side I decided to have a
single data path for XSK generic Tx. I suppose other auxiliary stuff
would have to land as well in order to make it work.

Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Link: https://lore.kernel.org/r/20250904194907.2342177-1-maciej.fijalkowski@intel.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c       | 113 ++++++++++++++++++++++++++++++++++++++------
 net/xdp/xsk_queue.h |  12 +++++
 2 files changed, 111 insertions(+), 14 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f5..de331541fdb38 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -36,6 +36,20 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
 
+struct xsk_addr_node {
+	u64 addr;
+	struct list_head addr_node;
+};
+
+struct xsk_addr_head {
+	u32 num_descs;
+	struct list_head addrs_list;
+};
+
+static struct kmem_cache *xsk_tx_generic_cache;
+
+#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
+
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -528,24 +542,43 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
+static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	ret = xskq_prod_reserve_addr(pool->cq, addr);
+	ret = xskq_prod_reserve(pool->cq);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 
 	return ret;
 }
 
-static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
+static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
+				      struct sk_buff *skb)
 {
+	struct xsk_addr_node *pos, *tmp;
+	u32 descs_processed = 0;
 	unsigned long flags;
+	u32 idx;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
-	xskq_prod_submit_n(pool->cq, n);
+	idx = xskq_get_prod(pool->cq);
+
+	xskq_prod_write_addr(pool->cq, idx,
+			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
+	descs_processed++;
+
+	if (unlikely(XSKCB(skb)->num_descs > 1)) {
+		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+			xskq_prod_write_addr(pool->cq, idx + descs_processed,
+					     pos->addr);
+			descs_processed++;
+			list_del(&pos->addr_node);
+			kmem_cache_free(xsk_tx_generic_cache, pos);
+		}
+	}
+	xskq_prod_submit_n(pool->cq, descs_processed);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
@@ -558,9 +591,14 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
+static void xsk_inc_num_desc(struct sk_buff *skb)
+{
+	XSKCB(skb)->num_descs++;
+}
+
 static u32 xsk_get_num_desc(struct sk_buff *skb)
 {
-	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
+	return XSKCB(skb)->num_descs;
 }
 
 static void xsk_destruct_skb(struct sk_buff *skb)
@@ -572,23 +610,33 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
+	xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
 	sock_wfree(skb);
 }
 
-static void xsk_set_destructor_arg(struct sk_buff *skb)
+static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
 {
-	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
-
-	skb_shinfo(skb)->destructor_arg = (void *)num;
+	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
+	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
+	XSKCB(skb)->num_descs = 0;
+	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
 {
 	struct xdp_sock *xs = xdp_sk(skb->sk);
+	u32 num_descs = xsk_get_num_desc(skb);
+	struct xsk_addr_node *pos, *tmp;
+
+	if (unlikely(num_descs > 1)) {
+		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+			list_del(&pos->addr_node);
+			kmem_cache_free(xsk_tx_generic_cache, pos);
+		}
+	}
 
 	skb->destructor = sock_wfree;
-	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
+	xsk_cq_cancel_locked(xs->pool, num_descs);
 	/* Free skb without triggering the perf drop trace */
 	consume_skb(skb);
 	xs->skb = NULL;
@@ -605,6 +653,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
+	struct xsk_addr_node *xsk_addr;
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
@@ -619,6 +668,19 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
+
+		xsk_set_destructor_arg(skb, desc->addr);
+	} else {
+		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+		if (!xsk_addr)
+			return ERR_PTR(-ENOMEM);
+
+		/* in case of -EOVERFLOW that could happen below,
+		 * xsk_consume_skb() will release this node as whole skb
+		 * would be dropped, which implies freeing all list elements
+		 */
+		xsk_addr->addr = desc->addr;
+		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 	}
 
 	addr = desc->addr;
@@ -690,8 +752,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			err = skb_store_bits(skb, 0, buffer, len);
 			if (unlikely(err))
 				goto free_err;
+
+			xsk_set_destructor_arg(skb, desc->addr);
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
+			struct xsk_addr_node *xsk_addr;
 			struct page *page;
 			u8 *vaddr;
 
@@ -706,12 +771,22 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
+			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+			if (!xsk_addr) {
+				__free_page(page);
+				err = -ENOMEM;
+				goto free_err;
+			}
+
 			vaddr = kmap_local_page(page);
 			memcpy(vaddr, buffer, len);
 			kunmap_local(vaddr);
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
+
+			xsk_addr->addr = desc->addr;
+			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 		}
 
 		if (first_frag && desc->options & XDP_TX_METADATA) {
@@ -755,7 +830,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
-	xsk_set_destructor_arg(skb);
+	xsk_inc_num_desc(skb);
 
 	return skb;
 
@@ -765,7 +840,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_set_destructor_arg(xs->skb);
+		xsk_inc_num_desc(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
@@ -807,7 +882,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+		err = xsk_cq_reserve_locked(xs->pool);
 		if (err) {
 			err = -EAGAIN;
 			goto out;
@@ -1795,8 +1870,18 @@ static int __init xsk_init(void)
 	if (err)
 		goto out_pernet;
 
+	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
+						 sizeof(struct xsk_addr_node),
+						 0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!xsk_tx_generic_cache) {
+		err = -ENOMEM;
+		goto out_unreg_notif;
+	}
+
 	return 0;
 
+out_unreg_notif:
+	unregister_netdevice_notifier(&xsk_netdev_notifier);
 out_pernet:
 	unregister_pernet_subsys(&xsk_net_ops);
 out_sk:
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 46d87e961ad6d..f16f390370dc4 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -344,6 +344,11 @@ static inline u32 xskq_cons_present_entries(struct xsk_queue *q)
 
 /* Functions for producers */
 
+static inline u32 xskq_get_prod(struct xsk_queue *q)
+{
+	return READ_ONCE(q->ring->producer);
+}
+
 static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
 {
 	u32 free_entries = q->nentries - (q->cached_prod - q->cached_cons);
@@ -390,6 +395,13 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
 	return 0;
 }
 
+static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx, u64 addr)
+{
+	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
+
+	ring->desc[idx & q->ring_mask] = addr;
+}
+
 static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
 					      u32 nb_entries)
 {
-- 
2.51.0




