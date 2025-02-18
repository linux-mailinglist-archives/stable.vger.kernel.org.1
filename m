Return-Path: <stable+bounces-116750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97806A39BB5
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127953A45D9
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3CD2405FE;
	Tue, 18 Feb 2025 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CGOqRVQW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA423FC6A
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880130; cv=none; b=c067Fz7okmlG8MxqkWuQT8FLSRWuewebpvuUygun+9TPm+jM6NcX8DcfL4Ijz/EEgoS5UnrewHoWotWHLMOgqe96UGruvE3aEsEzSHalKbQ68ZmEsSOywSYmP7By8YFYbKk2rPkvOpZoOXrJK1g8mjBW0S99qR0ljHS7ZC1mvY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880130; c=relaxed/simple;
	bh=7fWVopH7EVP3q/soLsW89Qz39Nl1S2xjYI+ThZeKw24=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XI1jr7fpxXRgYMCVkk2SBq+itpnYi8iR7fcX5G6ICphE4Xh7OjnkSO20YhkuHMPCDfb6/a2qV3xILEoK+BDM2d0LijkURBr5/lmcV2RiYz2AqDdgGS8Czm1bNwuEgiJpgDonGc2LoklcWt2JZxmbhpZkFlDeDv6Saxt+QR2BCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CGOqRVQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3541C4CEE2;
	Tue, 18 Feb 2025 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739880130;
	bh=7fWVopH7EVP3q/soLsW89Qz39Nl1S2xjYI+ThZeKw24=;
	h=Subject:To:Cc:From:Date:From;
	b=CGOqRVQWNEQBtn5EGLOXb5b5jm2KrHfnzPgYbJxriugRwcWEV8OU9lk0vlUSRfe2e
	 rZf43MSDmzqB2+U7VNvmE+IkB4wIrl/LYfwD1S+IAOCNntLI/PxtiOpVk8E6W+mZZh
	 Gl7g5YpQo4ZTGNLz2mDqWd7ekxbqKnkutBbozhZk=
Subject: FAILED: patch "[PATCH] Revert "net: skb: introduce and use a single page frag cache"" failed to apply to 6.12-stable tree
To: pabeni@redhat.com,edumazet@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 13:01:59 +0100
Message-ID: <2025021859-renewal-onto-1877@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 011b0335903832facca86cd8ed05d7d8d94c9c76
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021859-renewal-onto-1877@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 011b0335903832facca86cd8ed05d7d8d94c9c76 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 6 Feb 2025 22:28:48 +0100
Subject: [PATCH] Revert "net: skb: introduce and use a single page frag cache"

This reverts commit dbae2b062824 ("net: skb: introduce and use a single
page frag cache"). The intended goal of such change was to counter a
performance regression introduced by commit 3226b158e67c ("net: avoid
32 x truesize under-estimation for tiny skbs").

Unfortunately, the blamed commit introduces another regression for the
virtio_net driver. Such a driver calls napi_alloc_skb() with a tiny
size, so that the whole head frag could fit a 512-byte block.

The single page frag cache uses a 1K fragment for such allocation, and
the additional overhead, under small UDP packets flood, makes the page
allocator a bottleneck.

Thanks to commit bf9f1baa279f ("net: add dedicated kmem_cache for
typical/small skb->head"), this revert does not re-introduce the
original regression. Actually, in the relevant test on top of this
revert, I measure a small but noticeable positive delta, just above
noise level.

The revert itself required some additional mangling due to the
introduction of the SKB_HEAD_ALIGN() helper and local lock infra in the
affected code.

Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: dbae2b062824 ("net: skb: introduce and use a single page frag cache")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Link: https://patch.msgid.link/e649212fde9f0fdee23909ca0d14158d32bb7425.1738877290.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0a86afb85da..365f0e2098d1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4115,7 +4115,6 @@ void netif_receive_skb_list(struct list_head *head);
 gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb);
 void napi_gro_flush(struct napi_struct *napi, bool flush_old);
 struct sk_buff *napi_get_frags(struct napi_struct *napi);
-void napi_get_frags_check(struct napi_struct *napi);
 gro_result_t napi_gro_frags(struct napi_struct *napi);
 
 static inline void napi_free_frags(struct napi_struct *napi)
diff --git a/net/core/dev.c b/net/core/dev.c
index b91658e8aedb..55e356a68db6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6920,6 +6920,23 @@ netif_napi_dev_list_add(struct net_device *dev, struct napi_struct *napi)
 	list_add_rcu(&napi->dev_list, higher); /* adds after higher */
 }
 
+/* Double check that napi_get_frags() allocates skbs with
+ * skb->head being backed by slab, not a page fragment.
+ * This is to make sure bug fixed in 3226b158e67c
+ * ("net: avoid 32 x truesize under-estimation for tiny skbs")
+ * does not accidentally come back.
+ */
+static void napi_get_frags_check(struct napi_struct *napi)
+{
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	skb = napi_get_frags(napi);
+	WARN_ON_ONCE(skb && skb->head_frag);
+	napi_free_frags(napi);
+	local_bh_enable();
+}
+
 void netif_napi_add_weight_locked(struct net_device *dev,
 				  struct napi_struct *napi,
 				  int (*poll)(struct napi_struct *, int),
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..6a99c453397f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -220,67 +220,9 @@ static void skb_under_panic(struct sk_buff *skb, unsigned int sz, void *addr)
 #define NAPI_SKB_CACHE_BULK	16
 #define NAPI_SKB_CACHE_HALF	(NAPI_SKB_CACHE_SIZE / 2)
 
-#if PAGE_SIZE == SZ_4K
-
-#define NAPI_HAS_SMALL_PAGE_FRAG	1
-#define NAPI_SMALL_PAGE_PFMEMALLOC(nc)	((nc).pfmemalloc)
-
-/* specialized page frag allocator using a single order 0 page
- * and slicing it into 1K sized fragment. Constrained to systems
- * with a very limited amount of 1K fragments fitting a single
- * page - to avoid excessive truesize underestimation
- */
-
-struct page_frag_1k {
-	void *va;
-	u16 offset;
-	bool pfmemalloc;
-};
-
-static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp)
-{
-	struct page *page;
-	int offset;
-
-	offset = nc->offset - SZ_1K;
-	if (likely(offset >= 0))
-		goto use_frag;
-
-	page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
-	if (!page)
-		return NULL;
-
-	nc->va = page_address(page);
-	nc->pfmemalloc = page_is_pfmemalloc(page);
-	offset = PAGE_SIZE - SZ_1K;
-	page_ref_add(page, offset / SZ_1K);
-
-use_frag:
-	nc->offset = offset;
-	return nc->va + offset;
-}
-#else
-
-/* the small page is actually unused in this build; add dummy helpers
- * to please the compiler and avoid later preprocessor's conditionals
- */
-#define NAPI_HAS_SMALL_PAGE_FRAG	0
-#define NAPI_SMALL_PAGE_PFMEMALLOC(nc)	false
-
-struct page_frag_1k {
-};
-
-static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp_mask)
-{
-	return NULL;
-}
-
-#endif
-
 struct napi_alloc_cache {
 	local_lock_t bh_lock;
 	struct page_frag_cache page;
-	struct page_frag_1k page_small;
 	unsigned int skb_count;
 	void *skb_cache[NAPI_SKB_CACHE_SIZE];
 };
@@ -290,23 +232,6 @@ static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache) = {
 	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
 };
 
-/* Double check that napi_get_frags() allocates skbs with
- * skb->head being backed by slab, not a page fragment.
- * This is to make sure bug fixed in 3226b158e67c
- * ("net: avoid 32 x truesize under-estimation for tiny skbs")
- * does not accidentally come back.
- */
-void napi_get_frags_check(struct napi_struct *napi)
-{
-	struct sk_buff *skb;
-
-	local_bh_disable();
-	skb = napi_get_frags(napi);
-	WARN_ON_ONCE(!NAPI_HAS_SMALL_PAGE_FRAG && skb && skb->head_frag);
-	napi_free_frags(napi);
-	local_bh_enable();
-}
-
 void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
@@ -813,10 +738,8 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 
 	/* If requested length is either too small or too big,
 	 * we use kmalloc() for skb->head allocation.
-	 * When the small frag allocator is available, prefer it over kmalloc
-	 * for small fragments
 	 */
-	if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) ||
+	if (len <= SKB_WITH_OVERHEAD(1024) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC_NAPI,
@@ -826,32 +749,16 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 		goto skb_success;
 	}
 
+	len = SKB_HEAD_ALIGN(len);
+
 	if (sk_memalloc_socks())
 		gfp_mask |= __GFP_MEMALLOC;
 
 	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 	nc = this_cpu_ptr(&napi_alloc_cache);
-	if (NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) {
-		/* we are artificially inflating the allocation size, but
-		 * that is not as bad as it may look like, as:
-		 * - 'len' less than GRO_MAX_HEAD makes little sense
-		 * - On most systems, larger 'len' values lead to fragment
-		 *   size above 512 bytes
-		 * - kmalloc would use the kmalloc-1k slab for such values
-		 * - Builds with smaller GRO_MAX_HEAD will very likely do
-		 *   little networking, as that implies no WiFi and no
-		 *   tunnels support, and 32 bits arches.
-		 */
-		len = SZ_1K;
 
-		data = page_frag_alloc_1k(&nc->page_small, gfp_mask);
-		pfmemalloc = NAPI_SMALL_PAGE_PFMEMALLOC(nc->page_small);
-	} else {
-		len = SKB_HEAD_ALIGN(len);
-
-		data = page_frag_alloc(&nc->page, len, gfp_mask);
-		pfmemalloc = page_frag_cache_is_pfmemalloc(&nc->page);
-	}
+	data = page_frag_alloc(&nc->page, len, gfp_mask);
+	pfmemalloc = page_frag_cache_is_pfmemalloc(&nc->page);
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 
 	if (unlikely(!data))


