Return-Path: <stable+bounces-14295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4DE8380A9
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C014EB22929
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54890664DE;
	Tue, 23 Jan 2024 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E7I/cUJo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452365BC5;
	Tue, 23 Jan 2024 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971667; cv=none; b=b+8aENclpkWetg5w8uROGtQFN7DsxrDmlbsiYcPBm9SFMoD7DlZKxZiKFXxTAEuuNNe9hRafYbONrt+A49zLeuQCz7PqDJWb0c6LMuOspBxljz7NpQsDBlm2WlMb7nBHaXKay9ygr9c/VVjKnWb2g4s8WbmgYmKmt4GNKYqTEPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971667; c=relaxed/simple;
	bh=Eu0isBJan6MLYnnbTD0895FCnZ5kWCwMeZEQNRWxNeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSMWOlnibFVuwowj40A+vErIt7CmvCHj40k3r+NQhOEcweapIJ9CnKJD+g3YM3Tb0xMcos7DFuIrq+1b/Qmi6yI2bAg0/yvxIiWibmuSdsD6nx7B9x6RvBII8tJ63EFeywmEO5x11Wkael3iWv+6m6L2ezbdQnsHfy2MS4WplVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E7I/cUJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38FFC433C7;
	Tue, 23 Jan 2024 01:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971666;
	bh=Eu0isBJan6MLYnnbTD0895FCnZ5kWCwMeZEQNRWxNeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7I/cUJovJSdI26tkNvBTQ+FA9Xb3mWfU9XULpzoixIBsbq6t7hZ9XYIVcJbACqJY
	 keLS46LvENf/GCaMUSEA2uFIhRGeB2tEa3JBAl++4yjLJa/JGj6S2Ftutk0Mv2YytL
	 8OdD3JpPgBXK4l9ZpUu/PLOEfWHzbuX43EKw72Pk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 6.1 264/417] usb: cdns3: fix uvc failure work since sg support enabled
Date: Mon, 22 Jan 2024 15:57:12 -0800
Message-ID: <20240122235801.007861341@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Li <Frank.Li@nxp.com>

commit 1b8be5ecff26201bafb0a554c74e91571299fb94 upstream.

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
 drivers/usb/cdns3/cdns3-gadget.c |   51 ++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 11 deletions(-)

--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1117,6 +1117,7 @@ static int cdns3_ep_run_transfer(struct
 	dma_addr_t trb_dma;
 	u32 togle_pcs = 1;
 	int sg_iter = 0;
+	int num_trb_req;
 	int num_trb;
 	int address;
 	u32 control;
@@ -1125,15 +1126,13 @@ static int cdns3_ep_run_transfer(struct
 	struct scatterlist *s = NULL;
 	bool sg_supported = !!(request->num_mapped_sgs);
 
+	num_trb_req = sg_supported ? request->num_mapped_sgs : 1;
+
+	/* ISO transfer require each SOF have a TD, each TD include some TRBs */
 	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
-		num_trb = priv_ep->interval;
+		num_trb = priv_ep->interval * num_trb_req;
 	else
-		num_trb = sg_supported ? request->num_mapped_sgs : 1;
-
-	if (num_trb > priv_ep->free_trbs) {
-		priv_ep->flags |= EP_RING_FULL;
-		return -ENOBUFS;
-	}
+		num_trb = num_trb_req;
 
 	priv_req = to_cdns3_request(request);
 	address = priv_ep->endpoint.desc->bEndpointAddress;
@@ -1182,14 +1181,31 @@ static int cdns3_ep_run_transfer(struct
 
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
@@ -1207,6 +1223,9 @@ static int cdns3_ep_run_transfer(struct
 	do {
 		u32 length;
 
+		if (!(sg_iter % num_trb_req) && sg_supported)
+			s = request->sg;
+
 		/* fill TRB */
 		control |= TRB_TYPE(TRB_NORMAL);
 		if (sg_supported) {
@@ -1248,7 +1267,7 @@ static int cdns3_ep_run_transfer(struct
 		if (sg_supported) {
 			trb->control |= cpu_to_le32(TRB_ISP);
 			/* Don't set chain bit for last TRB */
-			if (sg_iter < num_trb - 1)
+			if ((sg_iter % num_trb_req) < num_trb_req - 1)
 				trb->control |= cpu_to_le32(TRB_CHAIN);
 
 			s = sg_next(s);
@@ -1506,6 +1525,12 @@ static void cdns3_transfer_completed(str
 
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
@@ -1538,6 +1563,10 @@ static void cdns3_transfer_completed(str
 			}
 
 			if (request_handled) {
+				/* TRBs are duplicated by priv_ep->interval time for ISO IN */
+				if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && priv_ep->dir)
+					request->actual /= priv_ep->interval;
+
 				cdns3_gadget_giveback(priv_ep, priv_req, 0);
 				request_handled = false;
 				transfer_end = false;



