Return-Path: <stable+bounces-98657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14C9E49AE
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8131883578
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D825A219A75;
	Wed,  4 Dec 2024 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyAqvWmT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AE20FA96;
	Wed,  4 Dec 2024 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355046; cv=none; b=AxoG5zWmmBH+jjfeDli8xBw+qaw4fVIF/thDjqF5CmjZbaOQJMs1UnwaehIvcBGx9XfGcBwYpKJoC80P3xhRtG76u3pEO1vcJnFoO4YPPTmLFoorW156fmPhh7x/3VkTxnMl8xVBZZRQIMrMEGJB4sUJfChOYpOcTqMc844QyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355046; c=relaxed/simple;
	bh=bZoCZcmdEf6f8OdQcdxHgAIXfFBH0zpd0reQdIhh62A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMkniQb42UFqRSwitFtBufKEI6zSNDsCzRIsKeuDJ5MQmQQ+nSx5hQV8d4JzlYeh6Qd9JLmeJ57FUEK73M9mTzfTQvk1PJAspR1jl9oSH6qXFUFnZCOmm2pCsea1OIwzVdpYQpHgnhlzGpL2t2mpdP/PjMj4J1Z/j+vtJRT6cDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyAqvWmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48CCC4CECD;
	Wed,  4 Dec 2024 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355046;
	bh=bZoCZcmdEf6f8OdQcdxHgAIXfFBH0zpd0reQdIhh62A=;
	h=From:To:Cc:Subject:Date:From;
	b=fyAqvWmT/3/tfEbR1SnofWtnQutqkkdyqvTLuw8Hzs2M3lyKSAO6WNE7+cFWK05Ii
	 +kYhF1F9nUl7dM5A8npBqDZxjDdZpROITCo4KSQIiaEF+8kg4XXdQIqpm32g2YLYcq
	 iubE6jXUI/YxJRlSUhOg93Sc9sA4o7Q9aK8OrrxqQwDeRb7IApBsVlBBWw52Dqhnpq
	 qdtmSIOv3zEoLXjIyF40bnEUCqS7eovCLjr6y5ECWBVLoST86dISq63TikXBlvZE1v
	 zjuAs6ub6i9dun4g6e46P8yy6UjxG+Vd1nQ4QHKx1LETamCyJ0QLUQfplIla9q315I
	 AnFJCEA2psVJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.chen@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/5] usb: chipidea: udc: create bounce buffer for problem sglist entries if possible
Date: Wed,  4 Dec 2024 17:19:17 -0500
Message-ID: <20241204221925.2248843-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit edfcc455c85ccc5855f0c329ca5a2d85cc9fc6c6 ]

The chipidea controller doesn't fully support sglist, such as it can not
transfer data spanned more dTDs to form a bus packet, so it can only work
on very limited cases.

The limitations as below:
1. the end address of the first sg buffer must be 4KB aligned.
2. the start and end address of the middle sg buffer must be 4KB aligned.
3. the start address of the first sg buffer must be 4KB aligned.

However, not all the use cases violate these limitations. To make the
controller compatible with most of the cases, this will try to bounce the
problem sglist entries which can be found by sglist_get_invalid_entry().
Then a bounced line buffer (the size will roundup to page size) will be
allocated to replace the remaining problem sg entries. The data will be
copied between problem sg entries and bounce buffer according to the
transfer direction. The bounce buffer will be freed when the request
completed.

Acked-by: Peter Chen <peter.chen@kernel.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20240923081203.2851768-3-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/udc.c | 148 +++++++++++++++++++++++++++++++++++++
 drivers/usb/chipidea/udc.h |   2 +
 2 files changed, 150 insertions(+)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 8b6745b7588c7..d3be658768a9a 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmapool.h>
+#include <linux/dma-direct.h>
 #include <linux/err.h>
 #include <linux/irqreturn.h>
 #include <linux/kernel.h>
@@ -538,6 +539,126 @@ static int prepare_td_for_sg(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 	return ret;
 }
 
+/*
+ * Verify if the scatterlist is valid by iterating each sg entry.
+ * Return invalid sg entry index which is less than num_sgs.
+ */
+static int sglist_get_invalid_entry(struct device *dma_dev, u8 dir,
+			struct usb_request *req)
+{
+	int i;
+	struct scatterlist *s = req->sg;
+
+	if (req->num_sgs == 1)
+		return 1;
+
+	dir = dir ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+
+	for (i = 0; i < req->num_sgs; i++, s = sg_next(s)) {
+		/* Only small sg (generally last sg) may be bounced. If
+		 * that happens. we can't ensure the addr is page-aligned
+		 * after dma map.
+		 */
+		if (dma_kmalloc_needs_bounce(dma_dev, s->length, dir))
+			break;
+
+		/* Make sure each sg start address (except first sg) is
+		 * page-aligned and end address (except last sg) is also
+		 * page-aligned.
+		 */
+		if (i == 0) {
+			if (!IS_ALIGNED(s->offset + s->length,
+						CI_HDRC_PAGE_SIZE))
+				break;
+		} else {
+			if (s->offset)
+				break;
+			if (!sg_is_last(s) && !IS_ALIGNED(s->length,
+						CI_HDRC_PAGE_SIZE))
+				break;
+		}
+	}
+
+	return i;
+}
+
+static int sglist_do_bounce(struct ci_hw_req *hwreq, int index,
+			bool copy, unsigned int *bounced)
+{
+	void *buf;
+	int i, ret, nents, num_sgs;
+	unsigned int rest, rounded;
+	struct scatterlist *sg, *src, *dst;
+
+	nents = index + 1;
+	ret = sg_alloc_table(&hwreq->sgt, nents, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	sg = src = hwreq->req.sg;
+	num_sgs = hwreq->req.num_sgs;
+	rest = hwreq->req.length;
+	dst = hwreq->sgt.sgl;
+
+	for (i = 0; i < index; i++) {
+		memcpy(dst, src, sizeof(*src));
+		rest -= src->length;
+		src = sg_next(src);
+		dst = sg_next(dst);
+	}
+
+	/* create one bounce buffer */
+	rounded = round_up(rest, CI_HDRC_PAGE_SIZE);
+	buf = kmalloc(rounded, GFP_KERNEL);
+	if (!buf) {
+		sg_free_table(&hwreq->sgt);
+		return -ENOMEM;
+	}
+
+	sg_set_buf(dst, buf, rounded);
+
+	hwreq->req.sg = hwreq->sgt.sgl;
+	hwreq->req.num_sgs = nents;
+	hwreq->sgt.sgl = sg;
+	hwreq->sgt.nents = num_sgs;
+
+	if (copy)
+		sg_copy_to_buffer(src, num_sgs - index, buf, rest);
+
+	*bounced = rest;
+
+	return 0;
+}
+
+static void sglist_do_debounce(struct ci_hw_req *hwreq, bool copy)
+{
+	void *buf;
+	int i, nents, num_sgs;
+	struct scatterlist *sg, *src, *dst;
+
+	sg = hwreq->req.sg;
+	num_sgs = hwreq->req.num_sgs;
+	src = sg_last(sg, num_sgs);
+	buf = sg_virt(src);
+
+	if (copy) {
+		dst = hwreq->sgt.sgl;
+		for (i = 0; i < num_sgs - 1; i++)
+			dst = sg_next(dst);
+
+		nents = hwreq->sgt.nents - num_sgs + 1;
+		sg_copy_from_buffer(dst, nents, buf, sg_dma_len(src));
+	}
+
+	hwreq->req.sg = hwreq->sgt.sgl;
+	hwreq->req.num_sgs = hwreq->sgt.nents;
+	hwreq->sgt.sgl = sg;
+	hwreq->sgt.nents = num_sgs;
+
+	kfree(buf);
+	sg_free_table(&hwreq->sgt);
+}
+
 /**
  * _hardware_enqueue: configures a request at hardware level
  * @hwep:   endpoint
@@ -550,6 +671,8 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 	struct ci_hdrc *ci = hwep->ci;
 	int ret = 0;
 	struct td_node *firstnode, *lastnode;
+	unsigned int bounced_size;
+	struct scatterlist *sg;
 
 	/* don't queue twice */
 	if (hwreq->req.status == -EALREADY)
@@ -557,11 +680,29 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 
 	hwreq->req.status = -EALREADY;
 
+	if (hwreq->req.num_sgs && hwreq->req.length &&
+		ci->has_short_pkt_limit) {
+		ret = sglist_get_invalid_entry(ci->dev->parent, hwep->dir,
+					&hwreq->req);
+		if (ret < hwreq->req.num_sgs) {
+			ret = sglist_do_bounce(hwreq, ret, hwep->dir == TX,
+					&bounced_size);
+			if (ret)
+				return ret;
+		}
+	}
+
 	ret = usb_gadget_map_request_by_dev(ci->dev->parent,
 					    &hwreq->req, hwep->dir);
 	if (ret)
 		return ret;
 
+	if (hwreq->sgt.sgl) {
+		/* We've mapped a bigger buffer, now recover the actual size */
+		sg = sg_last(hwreq->req.sg, hwreq->req.num_sgs);
+		sg_dma_len(sg) = min(sg_dma_len(sg), bounced_size);
+	}
+
 	if (hwreq->req.num_mapped_sgs)
 		ret = prepare_td_for_sg(hwep, hwreq);
 	else
@@ -724,6 +865,10 @@ static int _hardware_dequeue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 	usb_gadget_unmap_request_by_dev(hwep->ci->dev->parent,
 					&hwreq->req, hwep->dir);
 
+	/* sglist bounced */
+	if (hwreq->sgt.sgl)
+		sglist_do_debounce(hwreq, hwep->dir == RX);
+
 	hwreq->req.actual += actual;
 
 	if (hwreq->req.status)
@@ -1565,6 +1710,9 @@ static int ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 
 	usb_gadget_unmap_request(&hwep->ci->gadget, req, hwep->dir);
 
+	if (hwreq->sgt.sgl)
+		sglist_do_debounce(hwreq, false);
+
 	req->status = -ECONNRESET;
 
 	if (hwreq->req.complete != NULL) {
diff --git a/drivers/usb/chipidea/udc.h b/drivers/usb/chipidea/udc.h
index 5193df1e18c75..c8a47389a46bb 100644
--- a/drivers/usb/chipidea/udc.h
+++ b/drivers/usb/chipidea/udc.h
@@ -69,11 +69,13 @@ struct td_node {
  * @req: request structure for gadget drivers
  * @queue: link to QH list
  * @tds: link to TD list
+ * @sgt: hold original sglist when bounce sglist
  */
 struct ci_hw_req {
 	struct usb_request	req;
 	struct list_head	queue;
 	struct list_head	tds;
+	struct sg_table		sgt;
 };
 
 #ifdef CONFIG_USB_CHIPIDEA_UDC
-- 
2.43.0


