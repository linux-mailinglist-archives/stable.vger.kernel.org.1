Return-Path: <stable+bounces-76072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F64978034
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678C81F2315D
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8A1DA104;
	Fri, 13 Sep 2024 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IyfK9tce"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE61D932B
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231085; cv=none; b=JZ22Rt2CSpqqB0stJ/rwu1UjWZl8yeO6ZaEiHdLQBUzwNwS9lSb8BLol2Po9OODKJHYdtTVGDSEtl7PRv2MYRmTfYj5oU/QAupCS0yQonUADEydGR4BioHd75bL4gNlNvYzmKOUzbaALfY+r8oNxeJLWopt1Zd5jvhpomExM308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231085; c=relaxed/simple;
	bh=7vbxFwW+jt2CPDN8Fdxwc8ez7xZgyMHluFh3zi1uEcQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PrGTOxOP+MgQwqhOw1yDjPlv+dpknz5Y/t0c8vFRRPP4JzwFjOyFnPyh5RJambQ/Ql4ZXWqyPeqElgROTIHmRsp1z4s1zjCPtYmxN3jrodjG50KtxW3vL1Bdwh17L8Q71OpjY/opKhgsK7FH3ubIECOwCOm1JPGKa8SQBy8HIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IyfK9tce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1AAC4CEC7;
	Fri, 13 Sep 2024 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726231084;
	bh=7vbxFwW+jt2CPDN8Fdxwc8ez7xZgyMHluFh3zi1uEcQ=;
	h=Subject:To:Cc:From:Date:From;
	b=IyfK9tceZh8Ad1MJEQgtQCsAKzEM5g3fT0Rslaxv2SsQYOPc9mcnpSODDMi7UBwyK
	 k5mbpKDuCZW5DJ+1E9oDK4/DuPsg9ooSCzTe8sZqFx2BVNwbsViDa/qg7wVlIlMUvb
	 sgOIXvdcaHXQ4Zq8L1jgOhtmllCrLZYfIuNXTI0g=
Subject: FAILED: patch "[PATCH] Revert "virtio_net: rx remove premapped failover code"" failed to apply to 6.10-stable tree
To: xuanzhuo@linux.alibaba.com,flintglass@gmail.com,kuba@kernel.org,mst@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:38:01 +0200
Message-ID: <2024091301-suitcase-hazard-0817@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x dc4547fbba874718af76e5c28c815fcef5c13c6c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091301-suitcase-hazard-0817@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

dc4547fbba87 ("Revert "virtio_net: rx remove premapped failover code"")
e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
19a5a7710ee1 ("virtio_net: xsk: support wakeup")
09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc4547fbba874718af76e5c28c815fcef5c13c6c Mon Sep 17 00:00:00 2001
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Fri, 6 Sep 2024 20:31:35 +0800
Subject: [PATCH] Revert "virtio_net: rx remove premapped failover code"

This reverts commit defd28aa5acb0fd7c15adc6bc40a8ac277d04dea.

Recover the code to disable premapped mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Takero Funaki <flintglass@gmail.com>
Link: https://patch.msgid.link/20240906123137.108741-2-xuanzhuo@linux.alibaba.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948092..6fa8aab18484 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -356,6 +356,9 @@ struct receive_queue {
 	struct xdp_rxq_info xsk_rxq_info;
 
 	struct xdp_buff **xsk_buffs;
+
+	/* Do dma by self */
+	bool do_dma;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -885,7 +888,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf)
+	if (buf && rq->do_dma)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -898,6 +901,11 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	u32 offset;
 	void *head;
 
+	if (!rq->do_dma) {
+		sg_init_one(rq->sg, buf, len);
+		return;
+	}
+
 	head = page_address(rq->alloc_frag.page);
 
 	offset = buf - head;
@@ -923,42 +931,44 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
 	head = page_address(alloc_frag->page);
 
-	dma = head;
+	if (rq->do_dma) {
+		dma = head;
 
-	/* new pages */
-	if (!alloc_frag->offset) {
-		if (rq->last_dma) {
-			/* Now, the new page is allocated, the last dma
-			 * will not be used. So the dma can be unmapped
-			 * if the ref is 0.
+		/* new pages */
+		if (!alloc_frag->offset) {
+			if (rq->last_dma) {
+				/* Now, the new page is allocated, the last dma
+				 * will not be used. So the dma can be unmapped
+				 * if the ref is 0.
+				 */
+				virtnet_rq_unmap(rq, rq->last_dma, 0);
+				rq->last_dma = NULL;
+			}
+
+			dma->len = alloc_frag->size - sizeof(*dma);
+
+			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
+							      dma->len, DMA_FROM_DEVICE, 0);
+			if (virtqueue_dma_mapping_error(rq->vq, addr))
+				return NULL;
+
+			dma->addr = addr;
+			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
+
+			/* Add a reference to dma to prevent the entire dma from
+			 * being released during error handling. This reference
+			 * will be freed after the pages are no longer used.
 			 */
-			virtnet_rq_unmap(rq, rq->last_dma, 0);
-			rq->last_dma = NULL;
+			get_page(alloc_frag->page);
+			dma->ref = 1;
+			alloc_frag->offset = sizeof(*dma);
+
+			rq->last_dma = dma;
 		}
 
-		dma->len = alloc_frag->size - sizeof(*dma);
-
-		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
-						      dma->len, DMA_FROM_DEVICE, 0);
-		if (virtqueue_dma_mapping_error(rq->vq, addr))
-			return NULL;
-
-		dma->addr = addr;
-		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
-
-		/* Add a reference to dma to prevent the entire dma from
-		 * being released during error handling. This reference
-		 * will be freed after the pages are no longer used.
-		 */
-		get_page(alloc_frag->page);
-		dma->ref = 1;
-		alloc_frag->offset = sizeof(*dma);
-
-		rq->last_dma = dma;
+		++dma->ref;
 	}
 
-	++dma->ref;
-
 	buf = head + alloc_frag->offset;
 
 	get_page(alloc_frag->page);
@@ -975,9 +985,12 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	if (!vi->mergeable_rx_bufs && vi->big_packets)
 		return;
 
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		/* error should never happen */
-		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
+			continue;
+
+		vi->rq[i].do_dma = true;
+	}
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
@@ -2430,7 +2443,8 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -2544,7 +2558,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -5892,7 +5907,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].last_dma)
+			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
 				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
 		}


