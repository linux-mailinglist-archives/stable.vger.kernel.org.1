Return-Path: <stable+bounces-9766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78658250C8
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 10:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575751F26B3A
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66BE22F13;
	Fri,  5 Jan 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YsHRQdjq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1393C3F
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 09:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12504C433C8;
	Fri,  5 Jan 2024 09:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704446608;
	bh=lJf/FWbbXL9I1DA7Q6Xr0cdynUYRe8ZFjvM1csde0TI=;
	h=Subject:To:From:Date:From;
	b=YsHRQdjqDRK2ryV/svSeJlMFJCLhSlKU6zX8f+ZlVUXVgbROEpd/zX0qWeh6AHlmm
	 Tz3q4dY/bsVtkAI8Yhvi3ZoNB5lD/EqdSrmGwWizmShN9JQs9cOkexC/3yN3AsfPnv
	 0UC3mo7vL0FKnvznFYwcp4nhBUw2np6t3syRYQAg=
Subject: patch "usb: cdns3: fix uvc failure work since sg support enabled" added to usb-next
To: Frank.Li@nxp.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:21:59 +0100
Message-ID: <2024010559-algebra-improvise-cf01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    usb: cdns3: fix uvc failure work since sg support enabled

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 1b8be5ecff26201bafb0a554c74e91571299fb94 Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Sun, 24 Dec 2023 10:38:13 -0500
Subject: usb: cdns3: fix uvc failure work since sg support enabled

When IP version >= DEV_VER_V2, gadget:sg_supported is true. So uvc gadget
function driver will use sg to equeue data, first is 8bytes header, the
second is 1016bytes data.

    cdns3_prepare_trb: ep2in: trb 0000000000ac755f, dma buf: 0xbf455000, size: 8, burst: 128 ctrl: 0x00000415 (C=1, T=0, ISP, CHAIN, Normal)
    cdns3_prepare_trb: ep2in: trb 00000000a574e693, dma buf: 0xc0200fe0, size: 1016, burst: 128 ctrl: 0x00000405 (C=1, T=0, ISP, Normal)

But cdns3_ep_run_transfer() can't correctly handle this case, which only
support one TRB for ISO transfer.

The controller requires duplicate the TD for each SOF if priv_ep->interval
is not 1. DMA will read data from DDR to internal FIFO when get SOF. Send
data to bus when receive IN token. DMA always refill FIFO when get SOF
regardless host send IN token or not. If host send IN token later, some
frames data will be lost.

Fixed it by below major steps:

1. Calculate numembers of TRB base on sg_nums and priv_ep->interval.
2. Remove CHAIN flags for each end TRB of TD when duplicate TD.
3. The controller requires LINK TRB must be first TRB of TD. When check
there are not enough TRBs lefts, just fill LINK TRB for left TRBs.

.... CHAIN_TRB DATA_TRB, CHAIN_TRB DATA_TRB,  LINK_TRB ... LINK_TRB
                                                           ^End of TRB List

Cc:  <stable@vger.kernel.org>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20231224153816.1664687-2-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdns3-gadget.c | 53 ++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 15463b7cddd2..22a31ffa6942 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1119,6 +1119,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	dma_addr_t trb_dma;
 	u32 togle_pcs = 1;
 	int sg_iter = 0;
+	int num_trb_req;
 	int num_trb;
 	int address;
 	u32 control;
@@ -1128,15 +1129,13 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	bool sg_supported = !!(request->num_mapped_sgs);
 	u32 ioc = request->no_interrupt ? 0 : TRB_IOC;
 
-	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
-		num_trb = priv_ep->interval;
-	else
-		num_trb = sg_supported ? request->num_mapped_sgs : 1;
+	num_trb_req = sg_supported ? request->num_mapped_sgs : 1;
 
-	if (num_trb > priv_ep->free_trbs) {
-		priv_ep->flags |= EP_RING_FULL;
-		return -ENOBUFS;
-	}
+	/* ISO transfer require each SOF have a TD, each TD include some TRBs */
+	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
+		num_trb = priv_ep->interval * num_trb_req;
+	else
+		num_trb = num_trb_req;
 
 	priv_req = to_cdns3_request(request);
 	address = priv_ep->endpoint.desc->bEndpointAddress;
@@ -1185,14 +1184,31 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 
 		link_trb->control = cpu_to_le32(((priv_ep->pcs) ? TRB_CYCLE : 0) |
 				    TRB_TYPE(TRB_LINK) | TRB_TOGGLE | ch_bit);
+
+		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
+			/*
+			 * ISO require LINK TRB must be first one of TD.
+			 * Fill LINK TRBs for left trb space to simply software process logic.
+			 */
+			while (priv_ep->enqueue) {
+				*trb = *link_trb;
+				trace_cdns3_prepare_trb(priv_ep, trb);
+
+				cdns3_ep_inc_enq(priv_ep);
+				trb = priv_ep->trb_pool + priv_ep->enqueue;
+				priv_req->trb = trb;
+			}
+		}
+	}
+
+	if (num_trb > priv_ep->free_trbs) {
+		priv_ep->flags |= EP_RING_FULL;
+		return -ENOBUFS;
 	}
 
 	if (priv_dev->dev_ver <= DEV_VER_V2)
 		togle_pcs = cdns3_wa1_update_guard(priv_ep, trb);
 
-	if (sg_supported)
-		s = request->sg;
-
 	/* set incorrect Cycle Bit for first trb*/
 	control = priv_ep->pcs ? 0 : TRB_CYCLE;
 	trb->length = 0;
@@ -1210,6 +1226,9 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	do {
 		u32 length;
 
+		if (!(sg_iter % num_trb_req) && sg_supported)
+			s = request->sg;
+
 		/* fill TRB */
 		control |= TRB_TYPE(TRB_NORMAL);
 		if (sg_supported) {
@@ -1251,7 +1270,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 		if (sg_supported) {
 			trb->control |= cpu_to_le32(TRB_ISP);
 			/* Don't set chain bit for last TRB */
-			if (sg_iter < num_trb - 1)
+			if ((sg_iter % num_trb_req) < num_trb_req - 1)
 				trb->control |= cpu_to_le32(TRB_CHAIN);
 
 			s = sg_next(s);
@@ -1509,6 +1528,12 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 
 		/* The TRB was changed as link TRB, and the request was handled at ep_dequeue */
 		while (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
+
+			/* ISO ep_traddr may stop at LINK TRB */
+			if (priv_ep->dequeue == cdns3_get_dma_pos(priv_dev, priv_ep) &&
+			    priv_ep->type == USB_ENDPOINT_XFER_ISOC)
+				break;
+
 			trace_cdns3_complete_trb(priv_ep, trb);
 			cdns3_ep_inc_deq(priv_ep);
 			trb = priv_ep->trb_pool + priv_ep->dequeue;
@@ -1541,6 +1566,10 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 			}
 
 			if (request_handled) {
+				/* TRBs are duplicated by priv_ep->interval time for ISO IN */
+				if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && priv_ep->dir)
+					request->actual /= priv_ep->interval;
+
 				cdns3_gadget_giveback(priv_ep, priv_req, 0);
 				request_handled = false;
 				transfer_end = false;
-- 
2.43.0



