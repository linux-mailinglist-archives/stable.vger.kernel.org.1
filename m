Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348DD761438
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjGYLRZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjGYLRK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C141FF2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82D976169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C572C433C7;
        Tue, 25 Jul 2023 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283822;
        bh=lTRDgc2d4PRNeD36Jki3xSHtaQkHwzH9hjaqYaZeKcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0u52hXR5xrRvOv35Lg3Np6ITZiK/aNuPGBODn6RH14br1sM6JZvuvyaYDy4vc2yh
         g/SOum9kDvMIWpHJ4spZvwLFuoN7YDonpv+epC1xeJEhw+2L3jZYKRdEopjBxspk1y
         kGp1YHc2HrR1aZWZUa5R/IJmvTfcTsyuWXa4drME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 135/509] IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidate
Date:   Tue, 25 Jul 2023 12:41:14 +0200
Message-ID: <20230725104559.912354644@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Brendan Cunningham <bcunningham@cornelisnetworks.com>

[ Upstream commit c9358de193ecfb360c3ce75f27ce839ca0b0bc8c ]

The hfi1 user SDMA pinned-page cache will leave a stale cache entry when
the cache-entry's virtual address range is invalidated but that cache
entry is in-use by an outstanding SDMA request.

Subsequent user SDMA requests with buffers in or spanning the virtual
address range of the stale cache entry will result in packets constructed
from the wrong memory, the physical pages pointed to by the stale cache
entry.

To fix this, remove mmu_rb_node cache entries from the mmu_rb_handler
cache independent of the cache entry's refcount. Add 'struct kref
refcount' to struct mmu_rb_node and manage mmu_rb_node lifetime with
kref_get() and kref_put().

mmu_rb_node.refcount makes sdma_mmu_node.refcount redundant. Remove
'atomic_t refcount' from struct sdma_mmu_node and change sdma_mmu_node
code to use mmu_rb_node.refcount.

Move the mmu_rb_handler destructor call after a
wait-for-SDMA-request-completion call so mmu_rb_nodes that need
mmu_rb_handler's workqueue to queue themselves up for destruction from an
interrupt context may do so.

Fixes: f48ad614c100 ("IB/hfi1: Move driver out of staging")
Fixes: 00cbce5cbf88 ("IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests")
Link: https://lore.kernel.org/r/168451393605.3700681.13493776139032178861.stgit@awfm-02.cornelisnetworks.com
Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c   |   4 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c     | 101 ++++++++++-------
 drivers/infiniband/hw/hfi1/mmu_rb.h     |   3 +
 drivers/infiniband/hw/hfi1/sdma.c       |  23 +++-
 drivers/infiniband/hw/hfi1/sdma.h       |  47 +++++---
 drivers/infiniband/hw/hfi1/sdma_txreq.h |   2 +
 drivers/infiniband/hw/hfi1/user_sdma.c  | 137 ++++++++++--------------
 drivers/infiniband/hw/hfi1/user_sdma.h  |   1 -
 drivers/infiniband/hw/hfi1/vnic_sdma.c  |   4 +-
 9 files changed, 177 insertions(+), 145 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 956fc3fd88b99..1880484681357 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -251,11 +251,11 @@ static int hfi1_ipoib_build_ulp_payload(struct ipoib_txreq *tx,
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
 		ret = sdma_txadd_page(dd,
-				      NULL,
 				      txreq,
 				      skb_frag_page(frag),
 				      frag->bv_offset,
-				      skb_frag_size(frag));
+				      skb_frag_size(frag),
+				      NULL, NULL, NULL);
 		if (unlikely(ret))
 			break;
 	}
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index d331184ded308..a501b7a682fca 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -60,8 +60,7 @@ static int mmu_notifier_range_start(struct mmu_notifier *,
 		const struct mmu_notifier_range *);
 static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *,
 					   unsigned long, unsigned long);
-static void do_remove(struct mmu_rb_handler *handler,
-		      struct list_head *del_list);
+static void release_immediate(struct kref *refcount);
 static void handle_remove(struct work_struct *work);
 
 static const struct mmu_notifier_ops mn_opts = {
@@ -144,7 +143,11 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler)
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	do_remove(handler, &del_list);
+	while (!list_empty(&del_list)) {
+		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
+		list_del(&rbnode->list);
+		kref_put(&rbnode->refcount, release_immediate);
+	}
 
 	/* Now the mm may be freed. */
 	mmdrop(handler->mn.mm);
@@ -172,12 +175,6 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 	}
 	__mmu_int_rb_insert(mnode, &handler->root);
 	list_add_tail(&mnode->list, &handler->lru_list);
-
-	ret = handler->ops->insert(handler->ops_arg, mnode);
-	if (ret) {
-		__mmu_int_rb_remove(mnode, &handler->root);
-		list_del(&mnode->list); /* remove from LRU list */
-	}
 	mnode->handler = handler;
 unlock:
 	spin_unlock_irqrestore(&handler->lock, flags);
@@ -221,6 +218,48 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
 	return node;
 }
 
+/*
+ * Must NOT call while holding mnode->handler->lock.
+ * mnode->handler->ops->remove() may sleep and mnode->handler->lock is a
+ * spinlock.
+ */
+static void release_immediate(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	mnode->handler->ops->remove(mnode->handler->ops_arg, mnode);
+}
+
+/* Caller must hold mnode->handler->lock */
+static void release_nolock(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	list_move(&mnode->list, &mnode->handler->del_list);
+	queue_work(mnode->handler->wq, &mnode->handler->del_work);
+}
+
+/*
+ * struct mmu_rb_node->refcount kref_put() callback.
+ * Adds mmu_rb_node to mmu_rb_node->handler->del_list and queues
+ * handler->del_work on handler->wq.
+ * Does not remove mmu_rb_node from handler->lru_list or handler->rb_root.
+ * Acquires mmu_rb_node->handler->lock; do not call while already holding
+ * handler->lock.
+ */
+void hfi1_mmu_rb_release(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	struct mmu_rb_handler *handler = mnode->handler;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	list_move(&mnode->list, &mnode->handler->del_list);
+	spin_unlock_irqrestore(&handler->lock, flags);
+	queue_work(handler->wq, &handler->del_work);
+}
+
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 {
 	struct mmu_rb_node *rbnode, *ptr;
@@ -235,6 +274,10 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 
 	spin_lock_irqsave(&handler->lock, flags);
 	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
+		/* refcount == 1 implies mmu_rb_handler has only rbnode ref */
+		if (kref_read(&rbnode->refcount) > 1)
+			continue;
+
 		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
 					&stop)) {
 			__mmu_int_rb_remove(rbnode, &handler->root);
@@ -247,7 +290,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	spin_unlock_irqrestore(&handler->lock, flags);
 
 	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
-		handler->ops->remove(handler->ops_arg, rbnode);
+		kref_put(&rbnode->refcount, release_immediate);
 	}
 }
 
@@ -259,7 +302,6 @@ static int mmu_notifier_range_start(struct mmu_notifier *mn,
 	struct rb_root_cached *root = &handler->root;
 	struct mmu_rb_node *node, *ptr = NULL;
 	unsigned long flags;
-	bool added = false;
 
 	spin_lock_irqsave(&handler->lock, flags);
 	for (node = __mmu_int_rb_iter_first(root, range->start, range->end-1);
@@ -268,38 +310,16 @@ static int mmu_notifier_range_start(struct mmu_notifier *mn,
 		ptr = __mmu_int_rb_iter_next(node, range->start,
 					     range->end - 1);
 		trace_hfi1_mmu_mem_invalidate(node->addr, node->len);
-		if (handler->ops->invalidate(handler->ops_arg, node)) {
-			__mmu_int_rb_remove(node, root);
-			/* move from LRU list to delete list */
-			list_move(&node->list, &handler->del_list);
-			added = true;
-		}
+		/* Remove from rb tree and lru_list. */
+		__mmu_int_rb_remove(node, root);
+		list_del_init(&node->list);
+		kref_put(&node->refcount, release_nolock);
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	if (added)
-		queue_work(handler->wq, &handler->del_work);
-
 	return 0;
 }
 
-/*
- * Call the remove function for the given handler and the list.  This
- * is expected to be called with a delete list extracted from handler.
- * The caller should not be holding the handler lock.
- */
-static void do_remove(struct mmu_rb_handler *handler,
-		      struct list_head *del_list)
-{
-	struct mmu_rb_node *node;
-
-	while (!list_empty(del_list)) {
-		node = list_first_entry(del_list, struct mmu_rb_node, list);
-		list_del(&node->list);
-		handler->ops->remove(handler->ops_arg, node);
-	}
-}
-
 /*
  * Work queue function to remove all nodes that have been queued up to
  * be removed.  The key feature is that mm->mmap_lock is not being held
@@ -312,11 +332,16 @@ static void handle_remove(struct work_struct *work)
 						del_work);
 	struct list_head del_list;
 	unsigned long flags;
+	struct mmu_rb_node *node;
 
 	/* remove anything that is queued to get removed */
 	spin_lock_irqsave(&handler->lock, flags);
 	list_replace_init(&handler->del_list, &del_list);
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	do_remove(handler, &del_list);
+	while (!list_empty(&del_list)) {
+		node = list_first_entry(&del_list, struct mmu_rb_node, list);
+		list_del(&node->list);
+		handler->ops->remove(handler->ops_arg, node);
+	}
 }
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
index 0265d81c62061..be85537d23267 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -57,6 +57,7 @@ struct mmu_rb_node {
 	struct rb_node node;
 	struct mmu_rb_handler *handler;
 	struct list_head list;
+	struct kref refcount;
 };
 
 /*
@@ -92,6 +93,8 @@ int hfi1_mmu_rb_register(void *ops_arg,
 void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler);
 int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 		       struct mmu_rb_node *mnode);
+void hfi1_mmu_rb_release(struct kref *refcount);
+
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg);
 struct mmu_rb_node *hfi1_mmu_rb_get_first(struct mmu_rb_handler *handler,
 					  unsigned long addr,
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 728bf122ee0a7..2dc97de434a5e 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1635,7 +1635,20 @@ static inline void sdma_unmap_desc(
 	struct hfi1_devdata *dd,
 	struct sdma_desc *descp)
 {
-	system_descriptor_complete(dd, descp);
+	switch (sdma_mapping_type(descp)) {
+	case SDMA_MAP_SINGLE:
+		dma_unmap_single(&dd->pcidev->dev, sdma_mapping_addr(descp),
+				 sdma_mapping_len(descp), DMA_TO_DEVICE);
+		break;
+	case SDMA_MAP_PAGE:
+		dma_unmap_page(&dd->pcidev->dev, sdma_mapping_addr(descp),
+			       sdma_mapping_len(descp), DMA_TO_DEVICE);
+		break;
+	}
+
+	if (descp->pinning_ctx && descp->ctx_put)
+		descp->ctx_put(descp->pinning_ctx);
+	descp->pinning_ctx = NULL;
 }
 
 /*
@@ -3155,8 +3168,8 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 
 		/* Add descriptor for coalesce buffer */
 		tx->desc_limit = MAX_DESC;
-		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx,
-					 addr, tx->tlen);
+		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx,
+					 addr, tx->tlen, NULL, NULL, NULL);
 	}
 
 	return 1;
@@ -3199,9 +3212,9 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 	make_tx_sdma_desc(
 		tx,
 		SDMA_MAP_NONE,
-		NULL,
 		dd->sdma_pad_phys,
-		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
+		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)),
+		NULL, NULL, NULL);
 	tx->num_desc++;
 	_sdma_close_tx(dd, tx);
 	return rval;
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index 5a372ca1f6acf..7611f09d78dca 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -635,9 +635,11 @@ static inline dma_addr_t sdma_mapping_addr(struct sdma_desc *d)
 static inline void make_tx_sdma_desc(
 	struct sdma_txreq *tx,
 	int type,
-	void *pinning_ctx,
 	dma_addr_t addr,
-	size_t len)
+	size_t len,
+	void *pinning_ctx,
+	void (*ctx_get)(void *),
+	void (*ctx_put)(void *))
 {
 	struct sdma_desc *desc = &tx->descp[tx->num_desc];
 
@@ -654,7 +656,11 @@ static inline void make_tx_sdma_desc(
 				<< SDMA_DESC0_PHY_ADDR_SHIFT) |
 			(((u64)len & SDMA_DESC0_BYTE_COUNT_MASK)
 				<< SDMA_DESC0_BYTE_COUNT_SHIFT);
+
 	desc->pinning_ctx = pinning_ctx;
+	desc->ctx_put = ctx_put;
+	if (pinning_ctx && ctx_get)
+		ctx_get(pinning_ctx);
 }
 
 /* helper to extend txreq */
@@ -686,18 +692,20 @@ static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 static inline int _sdma_txadd_daddr(
 	struct hfi1_devdata *dd,
 	int type,
-	void *pinning_ctx,
 	struct sdma_txreq *tx,
 	dma_addr_t addr,
-	u16 len)
+	u16 len,
+	void *pinning_ctx,
+	void (*ctx_get)(void *),
+	void (*ctx_put)(void *))
 {
 	int rval = 0;
 
 	make_tx_sdma_desc(
 		tx,
 		type,
-		pinning_ctx,
-		addr, len);
+		addr, len,
+		pinning_ctx, ctx_get, ctx_put);
 	WARN_ON(len > tx->tlen);
 	tx->num_desc++;
 	tx->tlen -= len;
@@ -717,11 +725,18 @@ static inline int _sdma_txadd_daddr(
 /**
  * sdma_txadd_page() - add a page to the sdma_txreq
  * @dd: the device to use for mapping
- * @pinning_ctx: context to be released at descriptor retirement
  * @tx: tx request to which the page is added
  * @page: page to map
  * @offset: offset within the page
  * @len: length in bytes
+ * @pinning_ctx: context to be stored on struct sdma_desc .pinning_ctx. Not
+ *               added if coalesce buffer is used. E.g. pointer to pinned-page
+ *               cache entry for the sdma_desc.
+ * @ctx_get: optional function to take reference to @pinning_ctx. Not called if
+ *           @pinning_ctx is NULL.
+ * @ctx_put: optional function to release reference to @pinning_ctx after
+ *           sdma_desc completes. May be called in interrupt context so must
+ *           not sleep. Not called if @pinning_ctx is NULL.
  *
  * This is used to add a page/offset/length descriptor.
  *
@@ -733,11 +748,13 @@ static inline int _sdma_txadd_daddr(
  */
 static inline int sdma_txadd_page(
 	struct hfi1_devdata *dd,
-	void *pinning_ctx,
 	struct sdma_txreq *tx,
 	struct page *page,
 	unsigned long offset,
-	u16 len)
+	u16 len,
+	void *pinning_ctx,
+	void (*ctx_get)(void *),
+	void (*ctx_put)(void *))
 {
 	dma_addr_t addr;
 	int rval;
@@ -761,7 +778,8 @@ static inline int sdma_txadd_page(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, pinning_ctx, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, tx, addr, len,
+				 pinning_ctx, ctx_get, ctx_put);
 }
 
 /**
@@ -795,8 +813,8 @@ static inline int sdma_txadd_daddr(
 			return rval;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, NULL, tx,
-				 addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, tx, addr, len,
+				 NULL, NULL, NULL);
 }
 
 /**
@@ -842,7 +860,8 @@ static inline int sdma_txadd_kvaddr(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx, addr, len,
+				 NULL, NULL, NULL);
 }
 
 struct iowait_work;
@@ -1093,6 +1112,4 @@ u16 sdma_get_descq_cnt(void);
 extern uint mod_num_sdma;
 
 void sdma_update_lmc(struct hfi1_devdata *dd, u64 mask, u32 lid);
-
-void system_descriptor_complete(struct hfi1_devdata *dd, struct sdma_desc *descp);
 #endif
diff --git a/drivers/infiniband/hw/hfi1/sdma_txreq.h b/drivers/infiniband/hw/hfi1/sdma_txreq.h
index 4204650cebc29..fb091b5834b5d 100644
--- a/drivers/infiniband/hw/hfi1/sdma_txreq.h
+++ b/drivers/infiniband/hw/hfi1/sdma_txreq.h
@@ -62,6 +62,8 @@ struct sdma_desc {
 	/* private:  don't use directly */
 	u64 qw[2];
 	void *pinning_ctx;
+	/* Release reference to @pinning_ctx. May be called in interrupt context. Must not sleep. */
+	void (*ctx_put)(void *ctx);
 };
 
 /**
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 3f49633bf9855..a67791187d46d 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -103,18 +103,14 @@ static int defer_packet_queue(
 static void activate_packet_queue(struct iowait *wait, int reason);
 static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
 			   unsigned long len);
-static int sdma_rb_insert(void *arg, struct mmu_rb_node *mnode);
 static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
 			 void *arg2, bool *stop);
 static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode);
-static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode);
 
 static struct mmu_rb_ops sdma_rb_ops = {
 	.filter = sdma_rb_filter,
-	.insert = sdma_rb_insert,
 	.evict = sdma_rb_evict,
 	.remove = sdma_rb_remove,
-	.invalidate = sdma_rb_invalidate
 };
 
 static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
@@ -288,14 +284,14 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 		spin_unlock(&fd->pq_rcu_lock);
 		synchronize_srcu(&fd->pq_srcu);
 		/* at this point there can be no more new requests */
-		if (pq->handler)
-			hfi1_mmu_rb_unregister(pq->handler);
 		iowait_sdma_drain(&pq->busy);
 		/* Wait until all requests have been freed. */
 		wait_event_interruptible(
 			pq->wait,
 			!atomic_read(&pq->n_reqs));
 		kfree(pq->reqs);
+		if (pq->handler)
+			hfi1_mmu_rb_unregister(pq->handler);
 		bitmap_free(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
 		flush_pq_iowait(pq);
@@ -1316,25 +1312,17 @@ static void free_system_node(struct sdma_mmu_node *node)
 	kfree(node);
 }
 
-static inline void acquire_node(struct sdma_mmu_node *node)
-{
-	atomic_inc(&node->refcount);
-	WARN_ON(atomic_read(&node->refcount) < 0);
-}
-
-static inline void release_node(struct mmu_rb_handler *handler,
-				struct sdma_mmu_node *node)
-{
-	atomic_dec(&node->refcount);
-	WARN_ON(atomic_read(&node->refcount) < 0);
-}
-
+/*
+ * kref_get()'s an additional kref on the returned rb_node to prevent rb_node
+ * from being released until after rb_node is assigned to an SDMA descriptor
+ * (struct sdma_desc) under add_system_iovec_to_sdma_packet(), even if the
+ * virtual address range for rb_node is invalidated between now and then.
+ */
 static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
 					      unsigned long start,
 					      unsigned long end)
 {
 	struct mmu_rb_node *rb_node;
-	struct sdma_mmu_node *node;
 	unsigned long flags;
 
 	spin_lock_irqsave(&handler->lock, flags);
@@ -1343,11 +1331,12 @@ static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
 		spin_unlock_irqrestore(&handler->lock, flags);
 		return NULL;
 	}
-	node = container_of(rb_node, struct sdma_mmu_node, rb);
-	acquire_node(node);
+
+	/* "safety" kref to prevent release before add_system_iovec_to_sdma_packet() */
+	kref_get(&rb_node->refcount);
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	return node;
+	return container_of(rb_node, struct sdma_mmu_node, rb);
 }
 
 static int pin_system_pages(struct user_sdma_request *req,
@@ -1396,6 +1385,13 @@ static int pin_system_pages(struct user_sdma_request *req,
 	return 0;
 }
 
+/*
+ * kref refcount on *node_p will be 2 on successful addition: one kref from
+ * kref_init() for mmu_rb_handler and one kref to prevent *node_p from being
+ * released until after *node_p is assigned to an SDMA descriptor (struct
+ * sdma_desc) under add_system_iovec_to_sdma_packet(), even if the virtual
+ * address range for *node_p is invalidated between now and then.
+ */
 static int add_system_pinning(struct user_sdma_request *req,
 			      struct sdma_mmu_node **node_p,
 			      unsigned long start, unsigned long len)
@@ -1409,6 +1405,12 @@ static int add_system_pinning(struct user_sdma_request *req,
 	if (!node)
 		return -ENOMEM;
 
+	/* First kref "moves" to mmu_rb_handler */
+	kref_init(&node->rb.refcount);
+
+	/* "safety" kref to prevent release before add_system_iovec_to_sdma_packet() */
+	kref_get(&node->rb.refcount);
+
 	node->pq = pq;
 	ret = pin_system_pages(req, start, len, node, PFN_DOWN(len));
 	if (ret == 0) {
@@ -1472,15 +1474,15 @@ static int get_system_cache_entry(struct user_sdma_request *req,
 			return 0;
 		}
 
-		SDMA_DBG(req, "prepend: node->rb.addr %lx, node->refcount %d",
-			 node->rb.addr, atomic_read(&node->refcount));
+		SDMA_DBG(req, "prepend: node->rb.addr %lx, node->rb.refcount %d",
+			 node->rb.addr, kref_read(&node->rb.refcount));
 		prepend_len = node->rb.addr - start;
 
 		/*
 		 * This node will not be returned, instead a new node
 		 * will be. So release the reference.
 		 */
-		release_node(handler, node);
+		kref_put(&node->rb.refcount, hfi1_mmu_rb_release);
 
 		/* Prepend a node to cover the beginning of the allocation */
 		ret = add_system_pinning(req, node_p, start, prepend_len);
@@ -1492,6 +1494,20 @@ static int get_system_cache_entry(struct user_sdma_request *req,
 	}
 }
 
+static void sdma_mmu_rb_node_get(void *ctx)
+{
+	struct mmu_rb_node *node = ctx;
+
+	kref_get(&node->refcount);
+}
+
+static void sdma_mmu_rb_node_put(void *ctx)
+{
+	struct sdma_mmu_node *node = ctx;
+
+	kref_put(&node->rb.refcount, hfi1_mmu_rb_release);
+}
+
 static int add_mapping_to_sdma_packet(struct user_sdma_request *req,
 				      struct user_sdma_txreq *tx,
 				      struct sdma_mmu_node *cache_entry,
@@ -1535,9 +1551,12 @@ static int add_mapping_to_sdma_packet(struct user_sdma_request *req,
 			ctx = cache_entry;
 		}
 
-		ret = sdma_txadd_page(pq->dd, ctx, &tx->txreq,
+		ret = sdma_txadd_page(pq->dd, &tx->txreq,
 				      cache_entry->pages[page_index],
-				      page_offset, from_this_page);
+				      page_offset, from_this_page,
+				      ctx,
+				      sdma_mmu_rb_node_get,
+				      sdma_mmu_rb_node_put);
 		if (ret) {
 			/*
 			 * When there's a failure, the entire request is freed by
@@ -1559,8 +1578,6 @@ static int add_system_iovec_to_sdma_packet(struct user_sdma_request *req,
 					   struct user_sdma_iovec *iovec,
 					   size_t from_this_iovec)
 {
-	struct mmu_rb_handler *handler = req->pq->handler;
-
 	while (from_this_iovec > 0) {
 		struct sdma_mmu_node *cache_entry;
 		size_t from_this_cache_entry;
@@ -1581,15 +1598,15 @@ static int add_system_iovec_to_sdma_packet(struct user_sdma_request *req,
 
 		ret = add_mapping_to_sdma_packet(req, tx, cache_entry, start,
 						 from_this_cache_entry);
+
+		/*
+		 * Done adding cache_entry to zero or more sdma_desc. Can
+		 * kref_put() the "safety" kref taken under
+		 * get_system_cache_entry().
+		 */
+		kref_put(&cache_entry->rb.refcount, hfi1_mmu_rb_release);
+
 		if (ret) {
-			/*
-			 * We're guaranteed that there will be no descriptor
-			 * completion callback that releases this node
-			 * because only the last descriptor referencing it
-			 * has a context attached, and a failure means the
-			 * last descriptor was never added.
-			 */
-			release_node(handler, cache_entry);
 			SDMA_DBG(req, "add system segment failed %d", ret);
 			return ret;
 		}
@@ -1640,42 +1657,12 @@ static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
 	return 0;
 }
 
-void system_descriptor_complete(struct hfi1_devdata *dd,
-				struct sdma_desc *descp)
-{
-	switch (sdma_mapping_type(descp)) {
-	case SDMA_MAP_SINGLE:
-		dma_unmap_single(&dd->pcidev->dev, sdma_mapping_addr(descp),
-				 sdma_mapping_len(descp), DMA_TO_DEVICE);
-		break;
-	case SDMA_MAP_PAGE:
-		dma_unmap_page(&dd->pcidev->dev, sdma_mapping_addr(descp),
-			       sdma_mapping_len(descp), DMA_TO_DEVICE);
-		break;
-	}
-
-	if (descp->pinning_ctx) {
-		struct sdma_mmu_node *node = descp->pinning_ctx;
-
-		release_node(node->rb.handler, node);
-	}
-}
-
 static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
 			   unsigned long len)
 {
 	return (bool)(node->addr == addr);
 }
 
-static int sdma_rb_insert(void *arg, struct mmu_rb_node *mnode)
-{
-	struct sdma_mmu_node *node =
-		container_of(mnode, struct sdma_mmu_node, rb);
-
-	atomic_inc(&node->refcount);
-	return 0;
-}
-
 /*
  * Return 1 to remove the node from the rb tree and call the remove op.
  *
@@ -1688,10 +1675,6 @@ static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
 		container_of(mnode, struct sdma_mmu_node, rb);
 	struct evict_data *evict_data = evict_arg;
 
-	/* is this node still being used? */
-	if (atomic_read(&node->refcount))
-		return 0; /* keep this node */
-
 	/* this node will be evicted, add its pages to our count */
 	evict_data->cleared += node->npages;
 
@@ -1709,13 +1692,3 @@ static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode)
 
 	free_system_node(node);
 }
-
-static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode)
-{
-	struct sdma_mmu_node *node =
-		container_of(mnode, struct sdma_mmu_node, rb);
-
-	if (!atomic_read(&node->refcount))
-		return 1;
-	return 0;
-}
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index 9d417aacfa8b7..b2b26b71fcef0 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -145,7 +145,6 @@ struct hfi1_user_sdma_comp_q {
 struct sdma_mmu_node {
 	struct mmu_rb_node rb;
 	struct hfi1_user_sdma_pkt_q *pq;
-	atomic_t refcount;
 	struct page **pages;
 	unsigned int npages;
 };
diff --git a/drivers/infiniband/hw/hfi1/vnic_sdma.c b/drivers/infiniband/hw/hfi1/vnic_sdma.c
index 7658c620a125c..ab8bcdf104475 100644
--- a/drivers/infiniband/hw/hfi1/vnic_sdma.c
+++ b/drivers/infiniband/hw/hfi1/vnic_sdma.c
@@ -106,11 +106,11 @@ static noinline int build_vnic_ulp_payload(struct sdma_engine *sde,
 
 		/* combine physically continuous fragments later? */
 		ret = sdma_txadd_page(sde->dd,
-				      NULL,
 				      &tx->txreq,
 				      skb_frag_page(frag),
 				      skb_frag_off(frag),
-				      skb_frag_size(frag));
+				      skb_frag_size(frag),
+				      NULL, NULL, NULL);
 		if (unlikely(ret))
 			goto bail_txadd;
 	}
-- 
2.39.2



