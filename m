Return-Path: <stable+bounces-4991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE51E809DD4
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 09:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DC11C209E7
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85BF10964;
	Fri,  8 Dec 2023 08:03:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC5A4;
	Fri,  8 Dec 2023 00:03:09 -0800 (PST)
X-QQ-mid: bizesmtp90t1702022541tonirn3a
Received: from dsp-duanqiangwen.trustnetic.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 Dec 2023 16:02:19 +0800 (CST)
X-QQ-SSF: 01400000000000D0E000000A0000000
X-QQ-FEAT: C46Rb8GPIEeVb30oRnYgzzzVLJ5NE130+uMrOQIe2NDtC6AKvl2Dk94WyO9k3
	VxPvRLWUHKab4ZA66I79F5axwKeT7kvdmFPPk7TxRosej48L17eeAwnYZvOTkzJNn0Y757C
	xwsQRiRyLk85nhPDAdM/YfAexo+wT3zWPWdxW25DGTPofa2wqROu0qpP8eFAagimngbIJF/
	NV1GhO4EWUDky957CWEu1rF3TUL0jSNoQputctUU2r/3BiZdtdinwtDlMyIrgk/vyFfaByk
	PUc/9WKe7/sX6JXPD3bz/3fjL+BcV5x53mKVlH2UIUuB+cSoBB1lvjTLd4nXMYpae0zoOGg
	dN2LkmFM2aot62xCJa5DMfpzB+I2aqtIzlGUtv8WtBPdkR/Fhp/63dQ2OJ3/WOMO1ByTdis
	I6JP+kt9MS+pjmid157bqQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8323590272720038665
From: duanqiangwen <duanqiangwen@net-swift.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	yang.lee@linux.alibaba.com,
	shaozhengchao@huawei.com,
	error27@gmail.com,
	andrew@lunn.ch,
	stable@vger.kernel.org
Cc: duanqiangwen <duanqiangwen@net-swift.com>
Subject: [PATCH net v2] net: libwx: fix memory leak on free page
Date: Fri,  8 Dec 2023 16:02:16 +0800
Message-Id: <20231208080216.20176-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.12.2.windows.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

ifconfig ethx up, will set page->refcount larger than 1,
and then ifconfig ethx down, calling __page_frag_cache_drain()
to free pages, it is not compatible with page pool.
So deleting codes which changing page->refcount.

Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")

Signed-off-by: duanqiangwen <duanqiangwen@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 82 ++--------------------------
 drivers/net/ethernet/wangxun/libwx/wx_type.h |  1 -
 2 files changed, 6 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index a5a50b5a8816..11b94f7cb703 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -160,60 +160,6 @@ static __le32 wx_test_staterr(union wx_rx_desc *rx_desc,
 	return rx_desc->wb.upper.status_error & cpu_to_le32(stat_err_bits);
 }
 
-static bool wx_can_reuse_rx_page(struct wx_rx_buffer *rx_buffer,
-				 int rx_buffer_pgcnt)
-{
-	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias;
-	struct page *page = rx_buffer->page;
-
-	/* avoid re-using remote and pfmemalloc pages */
-	if (!dev_page_is_reusable(page))
-		return false;
-
-#if (PAGE_SIZE < 8192)
-	/* if we are only owner of page we can reuse it */
-	if (unlikely((rx_buffer_pgcnt - pagecnt_bias) > 1))
-		return false;
-#endif
-
-	/* If we have drained the page fragment pool we need to update
-	 * the pagecnt_bias and page count so that we fully restock the
-	 * number of references the driver holds.
-	 */
-	if (unlikely(pagecnt_bias == 1)) {
-		page_ref_add(page, USHRT_MAX - 1);
-		rx_buffer->pagecnt_bias = USHRT_MAX;
-	}
-
-	return true;
-}
-
-/**
- * wx_reuse_rx_page - page flip buffer and store it back on the ring
- * @rx_ring: rx descriptor ring to store buffers on
- * @old_buff: donor buffer to have page reused
- *
- * Synchronizes page for reuse by the adapter
- **/
-static void wx_reuse_rx_page(struct wx_ring *rx_ring,
-			     struct wx_rx_buffer *old_buff)
-{
-	u16 nta = rx_ring->next_to_alloc;
-	struct wx_rx_buffer *new_buff;
-
-	new_buff = &rx_ring->rx_buffer_info[nta];
-
-	/* update, and store next to alloc */
-	nta++;
-	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
-
-	/* transfer page from old buffer to new buffer */
-	new_buff->page = old_buff->page;
-	new_buff->page_dma = old_buff->page_dma;
-	new_buff->page_offset = old_buff->page_offset;
-	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
-}
-
 static void wx_dma_sync_frag(struct wx_ring *rx_ring,
 			     struct wx_rx_buffer *rx_buffer)
 {
@@ -270,8 +216,6 @@ static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
 				      size,
 				      DMA_FROM_DEVICE);
 skip_sync:
-	rx_buffer->pagecnt_bias--;
-
 	return rx_buffer;
 }
 
@@ -280,19 +224,9 @@ static void wx_put_rx_buffer(struct wx_ring *rx_ring,
 			     struct sk_buff *skb,
 			     int rx_buffer_pgcnt)
 {
-	if (wx_can_reuse_rx_page(rx_buffer, rx_buffer_pgcnt)) {
-		/* hand second half of page back to the ring */
-		wx_reuse_rx_page(rx_ring, rx_buffer);
-	} else {
-		if (!IS_ERR(skb) && WX_CB(skb)->dma == rx_buffer->dma)
-			/* the page has been released from the ring */
-			WX_CB(skb)->page_released = true;
-		else
-			page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
-
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
-	}
+	if (!IS_ERR(skb) && WX_CB(skb)->dma == rx_buffer->dma)
+		/* the page has been released from the ring */
+		WX_CB(skb)->page_released = true;
 
 	/* clear contents of rx_buffer */
 	rx_buffer->page = NULL;
@@ -335,11 +269,12 @@ static struct sk_buff *wx_build_skb(struct wx_ring *rx_ring,
 		if (size <= WX_RXBUFFER_256) {
 			memcpy(__skb_put(skb, size), page_addr,
 			       ALIGN(size, sizeof(long)));
-			rx_buffer->pagecnt_bias++;
-
+			page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
 			return skb;
 		}
 
+		skb_mark_for_recycle(skb);
+
 		if (!wx_test_staterr(rx_desc, WX_RXD_STAT_EOP))
 			WX_CB(skb)->dma = rx_buffer->dma;
 
@@ -382,8 +317,6 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
 	bi->page_dma = dma;
 	bi->page = page;
 	bi->page_offset = 0;
-	page_ref_add(page, USHRT_MAX - 1);
-	bi->pagecnt_bias = USHRT_MAX;
 
 	return true;
 }
@@ -723,7 +656,6 @@ static int wx_clean_rx_irq(struct wx_q_vector *q_vector,
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
-			rx_buffer->pagecnt_bias++;
 			break;
 		}
 
@@ -2248,8 +2180,6 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
 
 		/* free resources associated with mapping */
 		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
 
 		i++;
 		rx_buffer++;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 165e82de772e..83f9bb7b3c22 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -787,7 +787,6 @@ struct wx_rx_buffer {
 	dma_addr_t page_dma;
 	struct page *page;
 	unsigned int page_offset;
-	u16 pagecnt_bias;
 };
 
 struct wx_queue_stats {
-- 
2.12.2.windows.1


