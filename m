Return-Path: <stable+bounces-38514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182AB8A0EFE
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D9C1C216F4
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76314601D;
	Thu, 11 Apr 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y4YXJ1JD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B9140E3D;
	Thu, 11 Apr 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830797; cv=none; b=lVYuHzs5D9CUrAPsqRj/FZxWV4ReWEPJgZ4+FodjbmY0DaxdAXeQ37fll2h7nwzL4cA8sGoqtUhNbr5p1VFumPt+lZWaoft6Tkn6Gj3t6uvyLWsQTs4aBjeRd2dDCeEbHYLMgLOMT9nARCGaHJ/Ql0CJo9wq2V3Y+NvcBv0FNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830797; c=relaxed/simple;
	bh=qjI1HrrXApLu9OqAodoqjYyMWD7OYkxTCPQAd+Y8zrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWibU4qB6UIRNHy19fopH5ERCPa6pTDkTvatG3jvJ5aY5HL85lJhSXx+de6U965FLXVz1+56m05gFnUQy3rCPvMoa4G/lXX0rd0btd+i5Pw9/YTSg7SKDI+Jw8D4V6qFgqu4EUfjzj0Lw+rlz1lYF3XJif4Jc37BmbHh50yFicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y4YXJ1JD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92F9C433C7;
	Thu, 11 Apr 2024 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830797;
	bh=qjI1HrrXApLu9OqAodoqjYyMWD7OYkxTCPQAd+Y8zrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y4YXJ1JDPX6SZ6KCwhi/zRwlblp5htKyAs9S46Xv8PMN+mU6IHmjUhKdGNbawk120
	 gxY4CeCwqh6t4F2XBVYoED+li/PRrZ65zp6jHbiChipLdF52R4OeuB0nFvzpMvaEgj
	 nspzSX/6dmwh7gW6OvS96zIlym0dHgrK7jzLQatE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Subject: [PATCH 5.4 122/215] usb: dwc2: host: Fix ISOC flow in DDMA mode
Date: Thu, 11 Apr 2024 11:55:31 +0200
Message-ID: <20240411095428.568150002@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>

commit b258e42688501cadb1a6dd658d6f015df9f32d8f upstream.

Fixed ISOC completion flow in DDMA mode. Added isoc
descriptor actual length value and update urb's start_frame
value.
Fixed initialization of ISOC DMA descriptors flow.

Fixes: 56f5b1cff22a ("staging: Core files for the DWC2 driver")
Fixes: 20f2eb9c4cf8 ("staging: dwc2: add microframe scheduler from downstream Pi kernel")
Fixes: c17b337c1ea4 ("usb: dwc2: host: program descriptor for next frame")
Fixes: dc4c76e7b22c ("staging: HCD descriptor DMA support for the DWC2 driver")
Fixes: 762d3a1a9cd7 ("usb: dwc2: host: process all completed urbs")
CC: stable@vger.kernel.org
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Link: https://lore.kernel.org/r/a8b1e1711cc6cabfb45d92ede12e35445c66f06c.1708944698.git.Minas.Harutyunyan@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c      |   12 ++++++++++--
 drivers/usb/dwc2/hcd_ddma.c |   17 +++++++++++------
 drivers/usb/dwc2/hw.h       |    2 +-
 3 files changed, 22 insertions(+), 9 deletions(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2736,8 +2736,11 @@ enum dwc2_transaction_type dwc2_hcd_sele
 			hsotg->available_host_channels--;
 		}
 		qh = list_entry(qh_ptr, struct dwc2_qh, qh_list_entry);
-		if (dwc2_assign_and_init_hc(hsotg, qh))
+		if (dwc2_assign_and_init_hc(hsotg, qh)) {
+			if (hsotg->params.uframe_sched)
+				hsotg->available_host_channels++;
 			break;
+		}
 
 		/*
 		 * Move the QH from the periodic ready schedule to the
@@ -2770,8 +2773,11 @@ enum dwc2_transaction_type dwc2_hcd_sele
 			hsotg->available_host_channels--;
 		}
 
-		if (dwc2_assign_and_init_hc(hsotg, qh))
+		if (dwc2_assign_and_init_hc(hsotg, qh)) {
+			if (hsotg->params.uframe_sched)
+				hsotg->available_host_channels++;
 			break;
+		}
 
 		/*
 		 * Move the QH from the non-periodic inactive schedule to the
@@ -4125,6 +4131,8 @@ void dwc2_host_complete(struct dwc2_hsot
 			 urb->actual_length);
 
 	if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
+		if (!hsotg->params.dma_desc_enable)
+			urb->start_frame = qtd->qh->start_active_frame;
 		urb->error_count = dwc2_hcd_urb_get_error_count(qtd->urb);
 		for (i = 0; i < urb->number_of_packets; ++i) {
 			urb->iso_frame_desc[i].actual_length =
--- a/drivers/usb/dwc2/hcd_ddma.c
+++ b/drivers/usb/dwc2/hcd_ddma.c
@@ -589,7 +589,7 @@ static void dwc2_init_isoc_dma_desc(stru
 	idx = qh->td_last;
 	inc = qh->host_interval;
 	hsotg->frame_number = dwc2_hcd_get_frame_number(hsotg);
-	cur_idx = dwc2_frame_list_idx(hsotg->frame_number);
+	cur_idx = idx;
 	next_idx = dwc2_desclist_idx_inc(qh->td_last, inc, qh->dev_speed);
 
 	/*
@@ -896,6 +896,8 @@ static int dwc2_cmpl_host_isoc_dma_desc(
 {
 	struct dwc2_dma_desc *dma_desc;
 	struct dwc2_hcd_iso_packet_desc *frame_desc;
+	u16 frame_desc_idx;
+	struct urb *usb_urb = qtd->urb->priv;
 	u16 remain = 0;
 	int rc = 0;
 
@@ -908,8 +910,11 @@ static int dwc2_cmpl_host_isoc_dma_desc(
 				DMA_FROM_DEVICE);
 
 	dma_desc = &qh->desc_list[idx];
+	frame_desc_idx = (idx - qtd->isoc_td_first) & (usb_urb->number_of_packets - 1);
 
-	frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index_last];
+	frame_desc = &qtd->urb->iso_descs[frame_desc_idx];
+	if (idx == qtd->isoc_td_first)
+		usb_urb->start_frame = dwc2_hcd_get_frame_number(hsotg);
 	dma_desc->buf = (u32)(qtd->urb->dma + frame_desc->offset);
 	if (chan->ep_is_in)
 		remain = (dma_desc->status & HOST_DMA_ISOC_NBYTES_MASK) >>
@@ -930,7 +935,7 @@ static int dwc2_cmpl_host_isoc_dma_desc(
 		frame_desc->status = 0;
 	}
 
-	if (++qtd->isoc_frame_index == qtd->urb->packet_count) {
+	if (++qtd->isoc_frame_index == usb_urb->number_of_packets) {
 		/*
 		 * urb->status is not used for isoc transfers here. The
 		 * individual frame_desc status are used instead.
@@ -1035,11 +1040,11 @@ static void dwc2_complete_isoc_xfer_ddma
 				return;
 			idx = dwc2_desclist_idx_inc(idx, qh->host_interval,
 						    chan->speed);
-			if (!rc)
+			if (rc == 0)
 				continue;
 
-			if (rc == DWC2_CMPL_DONE)
-				break;
+			if (rc == DWC2_CMPL_DONE || rc == DWC2_CMPL_STOP)
+				goto stop_scan;
 
 			/* rc == DWC2_CMPL_STOP */
 
--- a/drivers/usb/dwc2/hw.h
+++ b/drivers/usb/dwc2/hw.h
@@ -718,7 +718,7 @@
 #define TXSTS_QTOP_TOKEN_MASK		(0x3 << 25)
 #define TXSTS_QTOP_TOKEN_SHIFT		25
 #define TXSTS_QTOP_TERMINATE		BIT(24)
-#define TXSTS_QSPCAVAIL_MASK		(0xff << 16)
+#define TXSTS_QSPCAVAIL_MASK		(0x7f << 16)
 #define TXSTS_QSPCAVAIL_SHIFT		16
 #define TXSTS_FSPCAVAIL_MASK		(0xffff << 0)
 #define TXSTS_FSPCAVAIL_SHIFT		0



