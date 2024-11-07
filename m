Return-Path: <stable+bounces-91784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C299C02AA
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270C71F23AF5
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7B1EF0A7;
	Thu,  7 Nov 2024 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FvDZ6rW+"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977711EE034
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976194; cv=none; b=qFKj138f1FdFGwgDCHQNyBcQBoNOnqMKhIjP5yP/K8AwmtstNjSOd/SX/Kjos1XpFDjSXfn62B5sjYasARchwEolHJ2uXjBuEi43o4HRPjwD929Vqf0Qbjq6VCrk/DPUR+ihkpLClFEYg6WeLP8vzRJpeo2X1cMPXdXmegjTtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976194; c=relaxed/simple;
	bh=6yUva44wOz2QnXUgFEN8GYdCcWOGCHhMm0Me1rwpUKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=sJ2QWRPXu25g5E6Rfa/SahD60Vo6v5JQRgt9IF7RUmk+m/ikHhUxwPJG5vsQDGAut/LX4SDYNCAKUarwD4N314UVp83HvVm3QUh4DAMPzsrVOUDG4iyoP6QlXHb9SseI6lSUCapewxMTUKumYVJM/LGO2lP3XoHodoLh86uRdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FvDZ6rW+; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241107104309epoutp02e57094fccbedd27698f0aa464e4d8000~FqaxMnsBf0748307483epoutp02E
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 10:43:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241107104309epoutp02e57094fccbedd27698f0aa464e4d8000~FqaxMnsBf0748307483epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730976189;
	bh=i/nto/EFjsbi80AnBzWHwrshWpst7RUnTbbo1TyJalc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=FvDZ6rW+2zMaq967TvFkU7tXObJlm0BZlnoCkBXFhzXQB9gGLANHeceXzkv6nk3yT
	 BVdXFUmqM5ySPLgdJsFCNdymXDXSAOoOrNA3BSx7yJXlYI+d20Znp6ZQCS86/cYthz
	 B8O4+w732Qlx9s43GI+HlgwLAphiiqYjNm/DvpEM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241107104308epcas5p392842ae5725da2ef3500c942fbd81f4c~FqawT3VQG0246702467epcas5p3a;
	Thu,  7 Nov 2024 10:43:08 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Xkdvb0ywxz4x9Q1; Thu,  7 Nov
	2024 10:43:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.FA.08574.AB99C276; Thu,  7 Nov 2024 19:43:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241107104306epcas5p136bea5d14a1bb3fe9ba1a7830bf366c6~Fqauv4CTs1298512985epcas5p1F;
	Thu,  7 Nov 2024 10:43:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241107104306epsmtrp2682304394b1964b08d9007c0cbc78fd2~Fqauu9-Wa3199131991epsmtrp2F;
	Thu,  7 Nov 2024 10:43:06 +0000 (GMT)
X-AuditID: b6c32a44-93ffa7000000217e-d2-672c99ba09fe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.72.08227.AB99C276; Thu,  7 Nov 2024 19:43:06 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241107104304epsmtip23020754976b1b194a62d731110ca25a8~FqaskUF9i2599225992epsmtip2T;
	Thu,  7 Nov 2024 10:43:04 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	quic_akakum@quicinc.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH] usb: dwc3: gadget: Add TxFIFO resizing supports for single
 port RAM
Date: Thu,  7 Nov 2024 16:10:35 +0530
Message-ID: <20241107104040.502-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmuu7umTrpBu8+MVm8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7W4/Wcvq8WqzjksFkeWf2Sy
	uPx9J7PFgo2PGC0mHRS1WLXgALuDgMf+uWvYPSbuqfPo27KK0WPL/s+MHp83yQWwRmXbZKQm
	pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdrKRQlphTChQK
	SCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzlj2/AhL
	wQ6Niql7hRsYPyp0MXJySAiYSLR0dDF1MXJxCAnsZpSY9XMrK4TziVHi2sM5UJlvjBIL135m
	gmn5v3UPC0RiL6PE3rZuZgjnO6PEpglbgKo4ONgEDCWenbABiYsI9DNKPF/0lBmkm1lgAZNE
	62xtEFtYIEziwbWXYHEWAVWJO/fesYPYvAJWEtvOP2eF2KYpsXbvHiaIuKDEyZlPWCDmyEs0
	b50NtlhCYCqHRGfzSxaQxRICLhJTbihB9ApLvDq+hR3ClpL4/G4vG4SdLLFn0heoeIbEoVWH
	mCFse4nVC86wgoxhBtq7fpc+xCo+id7fT5ggpvNKdLQJQVSrSpxqvAw1UVri3pJrUBd7SBzZ
	ewpsupBArMSPSbsZJzDKzULywCwkD8xCWLaAkXkVo2RqQXFuemqyaYFhXmo5PCqT83M3MYKT
	qpbLDsYb8//pHWJk4mA8xCjBwawkwusfpZ0uxJuSWFmVWpQfX1Sak1p8iNEUGKoTmaVEk/OB
	aT2vJN7QxNLAxMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQamI43/ryzcNrfo
	3ym2/1esf16d9EKiyOxdb63mHLG9Kjy6OU/U2xbO0bo/Y8sLwclsXNrKE+LXxEY4Gr+2u3pn
	nVjaimM7Jlvmy+1aXZpvLhq4tELsr3nT23k5IfkP3uU47vx3KWypZfnkrwlbLwUvZcu1uPzQ
	SXR37rdTpfsi/66bEiT2M3+eR8b1n7yOC177nf+XmRLJVCHzJ/agp9Tk/wzddy8nTf/qYaRw
	TfRzzfPe92+UTh5e8+2pWWbNg3r71C33tCYsZ9l0dVH+7dkfLTc/sF0zIVs2hvnoqn+bpmr9
	nqi/9Xew5Son/toSs0yd7b914kydko/VB4deCQxoK4y2sUtIXeq3I+Tx2s1nPyuxFGckGmox
	FxUnAgCjjNssMwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvO6umTrpBpseK1m8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7W4/Wcvq8WqzjksFkeWf2Sy
	uPx9J7PFgo2PGC0mHRS1WLXgALuDgMf+uWvYPSbuqfPo27KK0WPL/s+MHp83yQWwRnHZpKTm
	ZJalFunbJXBlLHt+hKVgh0bF1L3CDYwfFboYOTkkBEwk/m/dw9LFyMUhJLCbUeLGoxVsEAlp
	idezuhghbGGJlf+es0MUfWWUeNh3HaiDg4NNwFDi2QkbkLiIwGRGiclHz4EVMQusY5KYffwJ
	M0i3sECIxN3Ts1lAbBYBVYk7996xg9i8AlYS284/Z4XYoCmxdu8eJoi4oMTJmU/A6pkF5CWa
	t85mnsDINwtJahaS1AJGplWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMHBr6W1g3HP
	qg96hxiZOBgPMUpwMCuJ8PpHaacL8aYkVlalFuXHF5XmpBYfYpTmYFES5/32ujdFSCA9sSQ1
	OzW1ILUIJsvEwSnVwJQsETZ5fbbGmY+FvtqpayaamRgZTHvqL3j/8cWJy+Iv+yjxqgj47f36
	oeKF1PrA7UFsGyuDP0xeuzF+utruHR3vo0MOmjBunVbz2GPBz53TFXSmOZ4M/6Iu06SzeKvd
	hw920i1fT4reks5ba2+emGi6+unFGpvpNq9MeLit2afN8OffectZ94PveWV52a/vbke9uhd2
	xjEsqtBulnvrySvRPuuLq5Ydqty4nj+ixG1dr+GW+YnibHq5F1RMTuy33zfxcdydQ7de2QiI
	TdX5VvE3cr6itFb7zbUNOSWPGkU8WYstm51sDXSVd2yLM96ceuyQbynXBZXlpZbmvHrvDth+
	PPLN/2naG/FAwSlXfimxFGckGmoxFxUnAgDQAzFd7QIAAA==
X-CMS-MailID: 20241107104306epcas5p136bea5d14a1bb3fe9ba1a7830bf366c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241107104306epcas5p136bea5d14a1bb3fe9ba1a7830bf366c6
References: <CGME20241107104306epcas5p136bea5d14a1bb3fe9ba1a7830bf366c6@epcas5p1.samsung.com>

This commit adds support for resizing the TxFIFO in USB2.0-only mode
where using single port RAM, and limit the use of extra FIFOs for bulk
transfers in non-SS mode. It prevents the issue of limited RAM size
usage.

Fixes: fad16c823e66 ("usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs")
Cc: stable@vger.kernel.org # 6.12.x: fad16c82: usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/dwc3/core.h   |  4 +++
 drivers/usb/dwc3/gadget.c | 56 ++++++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eaa55c0cf62f..8306b39e5c64 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -915,6 +915,7 @@ struct dwc3_hwparams {
 #define DWC3_MODE(n)		((n) & 0x7)
 
 /* HWPARAMS1 */
+#define DWC3_SPRAM_TYPE(n)	(((n) >> 23) & 1)
 #define DWC3_NUM_INT(n)		(((n) & (0x3f << 15)) >> 15)
 
 /* HWPARAMS3 */
@@ -925,6 +926,9 @@ struct dwc3_hwparams {
 #define DWC3_NUM_IN_EPS(p)	(((p)->hwparams3 &		\
 			(DWC3_NUM_IN_EPS_MASK)) >> 18)
 
+/* HWPARAMS6 */
+#define DWC3_RAM0_DEPTH(n)	(((n) & (0xffff0000)) >> 16)
+
 /* HWPARAMS7 */
 #define DWC3_RAM1_DEPTH(n)	((n) & 0xffff)
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2fed2aa01407..d3e25f7d7cd0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -687,6 +687,42 @@ static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
 	return fifo_size;
 }
 
+/**
+ * dwc3_gadget_calc_ram_depth - calculates the ram depth for txfifo
+ * @dwc: pointer to the DWC3 context
+ */
+static int dwc3_gadget_calc_ram_depth(struct dwc3 *dwc)
+{
+	int ram_depth;
+	int fifo_0_start;
+	bool spram_type;
+	int tmp;
+
+	/* Check supporting RAM type by HW */
+	spram_type = DWC3_SPRAM_TYPE(dwc->hwparams.hwparams1);
+
+	/* If a single port RAM is utilized, then allocate TxFIFOs from
+	 * RAM0. otherwise, allocate them from RAM1.
+	 */
+	ram_depth = spram_type ? DWC3_RAM0_DEPTH(dwc->hwparams.hwparams6) :
+			DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+
+
+	/* In a single port RAM configuration, the available RAM is shared
+	 * between the RX and TX FIFOs. This means that the txfifo can begin
+	 * at a non-zero address.
+	 */
+	if (spram_type) {
+		/* Check if TXFIFOs start at non-zero addr */
+		tmp = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+		fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(tmp);
+
+		ram_depth -= (fifo_0_start >> 16);
+	}
+
+	return ram_depth;
+}
+
 /**
  * dwc3_gadget_clear_tx_fifos - Clears txfifo allocation
  * @dwc: pointer to the DWC3 context
@@ -753,7 +789,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
 	int fifo_0_start;
-	int ram1_depth;
+	int ram_depth;
 	int fifo_size;
 	int min_depth;
 	int num_in_ep;
@@ -773,7 +809,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
 		return 0;
 
-	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
 
 	switch (dwc->gadget->speed) {
 	case USB_SPEED_SUPER_PLUS:
@@ -792,10 +828,6 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 			break;
 		}
 		fallthrough;
-	case USB_SPEED_FULL:
-		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
-			num_fifos = 2;
-		break;
 	default:
 		break;
 	}
@@ -809,7 +841,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	/* Reserve at least one FIFO for the number of IN EPs */
 	min_depth = num_in_ep * (fifo + 1);
-	remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
+	remaining = ram_depth - min_depth - dwc->last_fifo_depth;
 	remaining = max_t(int, 0, remaining);
 	/*
 	 * We've already reserved 1 FIFO per EP, so check what we can fit in
@@ -835,9 +867,9 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 		dwc->last_fifo_depth += DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
 
 	/* Check fifo size allocation doesn't exceed available RAM size. */
-	if (dwc->last_fifo_depth >= ram1_depth) {
+	if (dwc->last_fifo_depth >= ram_depth) {
 		dev_err(dwc->dev, "Fifosize(%d) > RAM size(%d) %s depth:%d\n",
-			dwc->last_fifo_depth, ram1_depth,
+			dwc->last_fifo_depth, ram_depth,
 			dep->endpoint.name, fifo_size);
 		if (DWC3_IP_IS(DWC3))
 			fifo_size = DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
@@ -3090,7 +3122,7 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
 	struct dwc3 *dwc = gadget_to_dwc(g);
 	struct usb_ep *ep;
 	int fifo_size = 0;
-	int ram1_depth;
+	int ram_depth;
 	int ep_num = 0;
 
 	if (!dwc->do_fifo_resize)
@@ -3113,8 +3145,8 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
 	fifo_size += dwc->max_cfg_eps;
 
 	/* Check if we can fit a single fifo per endpoint */
-	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
-	if (fifo_size > ram1_depth)
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
+	if (fifo_size > ram_depth)
 		return -ENOMEM;
 
 	return 0;
-- 
2.17.1


