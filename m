Return-Path: <stable+bounces-116805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5801DA3A251
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 17:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D5B1602D2
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8B26A1A5;
	Tue, 18 Feb 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="QLCh3O+x"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5326E171
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895183; cv=none; b=WoIO61woQB5fCBHyl6xnP9EKHWhR1/vrmN/gTh202G7WNiUKbA0UlvLwRXBTUEQOcETw+zKAqwirEuiRYuMPZl8cuUEALAHEmSrPvn/RATOSa0sKyDawBYHk3OrBrU+nIuS5UtDRdJzUTcZWv8WWAYfMa/FvvEJUfdgJwsHjaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895183; c=relaxed/simple;
	bh=MZsC6p+DuQoF77t9MqtPjEbSK4PQZAOdC5fy5dbfOkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LOqTv8wngtYcgWvlxvLh3aIXz2i1zovom62ZQo85oHtef4WRA4pLksWvfUI9UfOP4pKM5mIMRJTMqLhZy5MzNBaUP/E343t6inppGJPo7CrY7MOsQi/6qYZa+KDfRRhrCIF/UPcrWeBD09m4A6NpYuLR/nk6Dwdw06u359zVB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QLCh3O+x; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739895066;
	bh=LDizJ8HCZMIjULEjvKp8wi7TWoxWAJJVvcwTivSDvOE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=QLCh3O+xPVQVQ+uq2mREu2KUlYXNtSnECGkb4AUKewygp2kB6rkWLZUpMYE3dQ7rJ
	 vdeL8VgSnhQXn0B0mMN/owBS0EiRWxdbIiwVt/I+eHXbgN8FD8ao8pseafvo3b76T6
	 iF/daqhj3B/o2jZB6Ra7glJCqU3JK4P/QqE3RmOo=
X-QQ-mid: bizesmtp87t1739895050t57nnqcy
X-QQ-Originating-IP: yFvZe/hju1XyxUtbNHS1ZDXIT3O2xTI9sVVraHS9ogI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 19 Feb 2025 00:10:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16400572080925857428
From: Wentao Guan <guanwentao@uniontech.com>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.12.y] Revert "net: skb: introduce and use a single page frag cache"
Date: Wed, 19 Feb 2025 00:10:36 +0800
Message-Id: <20250218161035.25064-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2025021859-renewal-onto-1877@gregkh>
References: <2025021859-renewal-onto-1877@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NSQm2ODd9qLZCILRfoIVyGQNR++x4BkSY0wWL3cfurKxWqQzpV3BKZSh
	mH+33TJaJH7n09Vj6eRt1p7VRGNm+jGLB0g8bout4/cAjBGzZfKI2+ZIe3hTutfuUpayfKI
	S/dW0usKvzm+CYBvrIv9AXVaevw/OcAI5A8teZZB8b1hYuOugPZPZleElEy/Sc65kGJH0EP
	hFlOt2xKXF/mL3u4P7wqFaMSJD6NQZ9G2XLytZzKdM7tUdSylOmAjRV32SewyXk0E5UibtF
	a5mQfzwvId5JOfMsh8W25o+CjVSyxWt1//N8pU00ZVXDK4QUXQxyYXEc3/hBO07YxFJUoEu
	5bhgRhtpdiSt6szsZp/HBxt8o3uKKRe8uldL54tdZ+TjBmrnvDQ87Gexe7dvyd19TO/70ML
	x71fHxlp3mJnkh9vxh217Erjuk4e1KE8vaRoGGAonMuv4kHhpLkg/2BJ+jDw4ffdKiZ4sGJ
	CgxwODzH/IzKYeYlcvJfed5fEqcxJwZ02mjyzhRwSPtyHwieEP+23y59vcT4c6W8nNX9LAL
	WHyrLD+GMTnlg4u1HFltELISu/HhofSHPZsumSBmwL223t55QrnIW2tQotNKv1XdGP8lEY/
	fi90WfKDNAPp4VYD1moiiG1q/s0qRMr6S28+E1W1NSjP7QiEgneMYFT0hBfFdlZyYqUEH9V
	cVBrHXKqch5l/CAp55N7HZppWFFsT2B560CO4DCKyWYWnQZJJ5sjB+cy9WqNWq4aJsZrF49
	IA5Y7b+aMzYfgbrKd/BPfKKpue7/uaUm40T99xmPAk+pzRtKIuZzHLbCZVVZGeHaFZpIz5n
	9Ut+6MUmY1/ehsn2NKSDHIrFrxIQmS2uZWrlbZBSbI0ISccsZovZOFL9t3z5Vb7cFFDo8W6
	DR3Fq5NmC+oDc5AXkWp6YCmqL6RvS/LNrIQcX+kc/9xqoLikvFU++b6N+dv1CBrSZh3yz8m
	ZBq0/pa1qMMJXxjDOvZWvyXCG6HkIlVKhhzB/zxXtkevp9Q==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

From: Paolo Abeni <pabeni@redhat.com>

commit 011b0335903832facca86cd8ed05d7d8d94c9c76 upstream.

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
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/linux/netdevice.h |   1 -
 net/core/dev.c            |  17 +++++++
 net/core/skbuff.c         | 103 ++------------------------------------
 3 files changed, 22 insertions(+), 99 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 02d3bafebbe77..277f9c413fcfc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3897,7 +3897,6 @@ void netif_receive_skb_list(struct list_head *head);
 gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb);
 void napi_gro_flush(struct napi_struct *napi, bool flush_old);
 struct sk_buff *napi_get_frags(struct napi_struct *napi);
-void napi_get_frags_check(struct napi_struct *napi);
 gro_result_t napi_gro_frags(struct napi_struct *napi);
 
 static inline void napi_free_frags(struct napi_struct *napi)
diff --git a/net/core/dev.c b/net/core/dev.c
index 2e0fe38d0e877..bb64809f01b33 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6669,6 +6669,23 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 }
 EXPORT_SYMBOL(netif_queue_set_napi);
 
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
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 			   int (*poll)(struct napi_struct *, int), int weight)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74149dc4ee318..b5ad21ee52a96 100644
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
-		pfmemalloc = nc->page.pfmemalloc;
-	}
+	data = page_frag_alloc(&nc->page, len, gfp_mask);
+	pfmemalloc = nc->page.pfmemalloc;
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 
 	if (unlikely(!data))
-- 
2.20.1


