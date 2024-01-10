Return-Path: <stable+bounces-10138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0BF82729F
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325C3B22651
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780B34C3C9;
	Mon,  8 Jan 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vgqYTj/1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96B6D6DC;
	Mon,  8 Jan 2024 15:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D8FC43397;
	Mon,  8 Jan 2024 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726880;
	bh=IW2ZOB6rHrdVivdNL0MDPwQorPOLYVJU1V/M2c2gVr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vgqYTj/1VmkJsAiRRm5ZnKiYm00BwN06IC6xZHBkn0e09g8F6EAqOebyRDFD5a1pP
	 8I2lYqqGh2XdYhARjbGk7MO+K+yEOp9aNu48l8W4UN5oUh5zA7iQ2ttkiRhwflcEvu
	 5wRLPl3lpFt4XFhP4ELXvkUHGnTYag4i3FmvZ+6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	duanqiangwen <duanqiangwen@net-swift.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 107/124] net: libwx: fix memory leak on free page
Date: Mon,  8 Jan 2024 16:08:53 +0100
Message-ID: <20240108150607.896561504@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

From: duanqiangwen <duanqiangwen@net-swift.com>

[ Upstream commit 738b54b9b6236f573eed2453c4cbfa77326793e2 ]

ifconfig ethx up, will set page->refcount larger than 1,
and then ifconfig ethx down, calling __page_frag_cache_drain()
to free pages, it is not compatible with page pool.
So deleting codes which changing page->refcount.

Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
Signed-off-by: duanqiangwen <duanqiangwen@net-swift.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 82 ++------------------
 drivers/net/ethernet/wangxun/libwx/wx_type.h |  1 -
 2 files changed, 6 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 21505920136c6..e078f4071dc23 100644
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
+			page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, true);
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
@@ -721,7 +654,6 @@ static int wx_clean_rx_irq(struct wx_q_vector *q_vector,
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
-			rx_buffer->pagecnt_bias++;
 			break;
 		}
 
@@ -2241,8 +2173,6 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
 
 		/* free resources associated with mapping */
 		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
 
 		i++;
 		rx_buffer++;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c5cbd177ef627..c555af9ed51b2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -759,7 +759,6 @@ struct wx_rx_buffer {
 	dma_addr_t page_dma;
 	struct page *page;
 	unsigned int page_offset;
-	u16 pagecnt_bias;
 };
 
 struct wx_queue_stats {
-- 
2.43.0




