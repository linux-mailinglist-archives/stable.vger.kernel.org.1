Return-Path: <stable+bounces-12742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9973E8371BE
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC401C2A3C3
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051455B5D6;
	Mon, 22 Jan 2024 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J51TwgrN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AB56777
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949082; cv=none; b=JJhZ+kbPlHvOwFa8mJQ8Ng0cqoSX0FPVSnBH5ad12NkbjgWHYfJXbGXPTTb/G7XOujdWSdzpgFGgTHB7400TXvoHEv3BeopAMbt2trwzZmBxw6nXqcFp2eZQPYkiQrFQloFabfEevIuhjk7/7qW5o9rIJkGvRnA/7dQY5R5qouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949082; c=relaxed/simple;
	bh=Lyd0Ch92oIkU0R1Ss3F2mIKuIR6M2b1epF0gJcebrPw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZmJuulsr5AK6zWqYIJTJ/q4hfjgRMP03ihjsxWtXDDypjsU03VEzoY5fJzWI0H0qxiX6xnk8cIcwcUj3wgX+ufpjHTHOEWmH/bjDPLB7gR3LvEKq5PGs9/VSYVat5wj0SmeKb9FdJm9VuzINgzTF/as45PMC4nv8rjVx5S9j/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J51TwgrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5F8C43390;
	Mon, 22 Jan 2024 18:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705949082;
	bh=Lyd0Ch92oIkU0R1Ss3F2mIKuIR6M2b1epF0gJcebrPw=;
	h=Subject:To:Cc:From:Date:From;
	b=J51TwgrN54p7bHxezhMEqf+nvdqeKbrMFYdTd2SFhygz6AxcmYw0boQbWciV3KtL6
	 0SKazKlfisvy+rKZh0xrIafoTcNFaUeO86+zy0tbRX6WHxceK4qbjm0p0W564gtRbF
	 tMjJShlY6cu9vxeAnqOEUVtKZJNXt7wbQR5l3WRs=
Subject: FAILED: patch "[PATCH] usb: cdns3: fix uvc failure work since sg support enabled" failed to apply to 5.4-stable tree
To: Frank.Li@nxp.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:44:40 -0800
Message-ID: <2024012239-crusader-abrasive-5405@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1b8be5ecff26201bafb0a554c74e91571299fb94
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012239-crusader-abrasive-5405@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

1b8be5ecff26 ("usb: cdns3: fix uvc failure work since sg support enabled")
387c2b6ba197 ("usb: cdns3: gadget: fix new urb never complete if ep cancel previous requests")
fba8701baed7 ("usb: cdns3: Fixes for sparse warnings")
64b558f597d1 ("usb: cdns3: Change file names for cdns3 driver.")
118b2a3237cf ("usb: cdnsp: Add tracepoints for CDNSP driver")
3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
e93e58d27402 ("usb: cdnsp: Device side header file for CDNSP driver")
0b490046d8d7 ("usb: cdns3: Refactoring names in reusable code")
394c3a144de8 ("usb: cdns3: Moves reusable code to separate module")
f738957277ba ("usb: cdns3: Split core.c into cdns3-plat and core.c file")
db8892bb1bb6 ("usb: cdns3: Add support for DRD CDNSP")
d2a968dddf98 ("Merge tag 'usb-v5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b8be5ecff26201bafb0a554c74e91571299fb94 Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Sun, 24 Dec 2023 10:38:13 -0500
Subject: [PATCH] usb: cdns3: fix uvc failure work since sg support enabled

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


