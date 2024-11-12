Return-Path: <stable+bounces-92196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 361FF9C4DE7
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 05:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A29AB26508
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 04:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4702207A17;
	Tue, 12 Nov 2024 04:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="csVk/iTK"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D91F81B5
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 04:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731386971; cv=none; b=tluIxiFJ60kc7EmDMXe0Bnrn/1yGI9B3pqNdbY+k7XWCFheMdp+V4G8jjaMQn8EokE2EOMq1RnVKueBNwOY/3IVjTjeKdn2DjHaDoGJQ7lpr69ZZf8NdjNAKQnLNqaL56GwIKJ2GP56m9zrYQRgaxnW2xcuijx5Y6NdbkBBfYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731386971; c=relaxed/simple;
	bh=hzlx0r+BPiyBMAWemg9/s2nEEW0rNzF6HfmzUnnCr3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=eZAYLmR2qFrGtQ4NTVuCKrCHgMEaESp5Nl3uCKqh70gL2RjrmkaiZFEOUBZpSpBW9VkILQUNnF0sM6IkTQyaPM7Fylom7O166u9LVikJlWJwznkXnVsp798xk1g04084fTuNBoOpteIz4mfm0yqcDhV3Kw382pc0XhFONXcn64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=csVk/iTK; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241112044921epoutp04a82912990a50aaffff4fd874d68e8774~HH0SfXT1R3110231102epoutp04D
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 04:49:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241112044921epoutp04a82912990a50aaffff4fd874d68e8774~HH0SfXT1R3110231102epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731386961;
	bh=AUlIJmCgvQ17KMTVrciEg97C52EGYQL/lVWfAmojbFQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=csVk/iTKPDvibGOeu/MBweXo+PKxcY+nnNaTnwnQ1/d1s+RnDwKGhMtNtwhn9Eke+
	 ULfLnhy1LEzKOou+Ts6JtTKOk0C5BDDnk0PPrfr5aIWIyZb7A8h4jHcdxp5cecOF+J
	 9nWlhM2TOj7NbQM583Wir3LWWbeGWluY3Vi+K8xg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241112044920epcas5p306a13edf42e25eba1dcd31f47a03e886~HH0SIJx-Y1756517565epcas5p3U;
	Tue, 12 Nov 2024 04:49:20 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XnYq274R3z4x9QG; Tue, 12 Nov
	2024 04:49:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.39.08574.E4ED2376; Tue, 12 Nov 2024 13:49:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241112044918epcas5p448b475256fc5232bcb34b67f564088b9~HH0PzKiDJ2466524665epcas5p4y;
	Tue, 12 Nov 2024 04:49:18 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241112044918epsmtrp2030aacc80eff3679e80645ee8ebc2f86~HH0Pw7oWt0825008250epsmtrp2N;
	Tue, 12 Nov 2024 04:49:18 +0000 (GMT)
X-AuditID: b6c32a44-93ffa7000000217e-92-6732de4e3e07
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FD.7C.18937.E4ED2376; Tue, 12 Nov 2024 13:49:18 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241112044915epsmtip2449b0c626e7b422ec3ab6e53aa23894f~HH0NOjMxj2584225842epsmtip2H;
	Tue, 12 Nov 2024 04:49:15 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	quic_akakum@quicinc.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stern@rowland.harvard.edu
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, Selvarasu Ganesan <selvarasu.g@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: gadget: Add missing check for single port RAM
 in TxFIFO resizing logic
Date: Tue, 12 Nov 2024 10:18:02 +0530
Message-ID: <20241112044807.623-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmhq7fPaN0g21zzS3eXF3FavFg3jY2
	izsLpjFZnFq+kMmiefF6NotJe7ayWNx9+IPF4vKuOWwWi5a1Mlt8Ovqf1eL2n72sFqs657BY
	HFn+kcni8vedzBYLNj5itJjw+wJQ20FRi1ULDrA7CHnsn7uG3WPinjqP2Xd/MHr0bVnF6LFl
	/2dGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwC
	dN0yc4AeUFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZY
	GRoYGJkCFSZkZ8yc8Yel4KNexaETRxgbGFepdTFyckgImEhcvHyTvYuRi0NIYDejxMTJp1kg
	nE+MEot2fGSEc46dv8wE0/JuyQ02iMRORok9HxdB9X8HclY9AHI4ONgEDCWenbABiYsIrGKU
	+He0iRXEYRbYzSSx6sF9dpBRwgLpEhce/GYFsVkEVCUWv5/GCGLzClhJPP5+nB1inabE2r17
	mCDighInZz5hAbGZBeQlmrfOZgYZKiGwhUPixYYNzCCbJQRcJJY88oDoFZZ4dXwL1Bwpic/v
	9rJB2MkSeyZ9gYpnSBxadYgZwraXWL3gDCvIGGagvet36UOs4pPo/f2ECWI6r0RHmxBEtarE
	qcbLUBOlJe4tucYKYXtIzH7TC2YLCcRKvPh6mHUCo9wsJA/MQvLALIRlCxiZVzFKphYU56an
	JpsWGOallsMjMzk/dxMjOO1quexgvDH/n94hRiYOxkOMEhzMSiK8Gv766UK8KYmVValF+fFF
	pTmpxYcYTYGhOpFZSjQ5H5j480riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C
	6WPi4JRqYDLy9DlTMzN8/4Lvl/Z++R2zaj5rW+/mGP6PUf5OMx6v/v/4/c+J366Wzzjzc0/W
	m0czRXlXCLZu2JQvttTjvbfvn/4zB148EP8pEGbRpavLcpF3bnDmpw1hDlEx08WO9cQX7FeZ
	Xy67a++VxbkPrexflVzoSD4Y+krSJs7agO2Zg996Zc3Vbppi8SdCjWzlP2hf0r5YJzpvzpbf
	HnqRs9f0tl5zMqn4uJNJIHfH9LXV77cZ8Qvc8bpQIBFcbzP7/46cjB8+89i3Ja/TUQ91idni
	KXW7UdNJUsbyRhZHqjrvD4G631MWevryavF4nrj944elp8ai2V/vLmSpuKp8/FqspJbCHY1Z
	b6rL5ZhsvimxFGckGmoxFxUnAgAa+sLNRAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvK7fPaN0g46dwhZvrq5itXgwbxub
	xZ0F05gsTi1fyGTRvHg9m8WkPVtZLO4+/MFicXnXHDaLRctamS0+Hf3PanH7z15Wi1Wdc1gs
	jiz/yGRx+ftOZosFGx8xWkz4fQGo7aCoxaoFB9gdhDz2z13D7jFxT53H7Ls/GD36tqxi9Niy
	/zOjx+dNcgFsUVw2Kak5mWWpRfp2CVwZM2f8YSn4qFdx6MQRxgbGVWpdjJwcEgImEu+W3GDr
	YuTiEBLYzihx7O59FoiEtMTrWV2MELawxMp/z9khir4ySvz58p+5i5GDg03AUOLZCRuQuIjA
	BkaJp5cvgU1iFjjJJNH89RHYJGGBVImP/c+YQGwWAVWJxe+ngU3lFbCSePz9ODvEBk2JtXv3
	MEHEBSVOznzCArKAWUBdYv08IZAws4C8RPPW2cwTGPlnIamahVA1C0nVAkbmVYyiqQXFuem5
	yQWGesWJucWleel6yfm5mxjBEaQVtINx2fq/eocYmTgYDzFKcDArifBq+OunC/GmJFZWpRbl
	xxeV5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgtgskycXBKNTAxPj1yxc4qmsUowik/d8f+
	JJ89dQ9tq621Y/4L7VGYmePXwJVSsNr5kb/8+s1P9WtFDl0MuFt+fvPjdYsNvx00i/8itYe1
	K7NH5aHSU/WKXsEJ07ISH5StcOWftNZ3smiR/KylYfkm3lKVCy8422nVrAh7VV3nuOKM4JUF
	J2ex+v+w/9bR+fVhEZ90yKvbKxQSL1yWiDJbLTVD/yW/2EXt6axfb5adOnp12Vkrd6cm33j1
	NZ9n5XXt7249FR/q+OxRrUjoSeWF8YnMbZOY5hnIBSYrnZZYM+U+J2Nk7K2athzvhvjN8Rl+
	MiYCMiZmPpOVl0+NZrwxY+1ft1AWFZO5taaPs17eO+yvszPvmBJLcUaioRZzUXEiANtS1v4P
	AwAA
X-CMS-MailID: 20241112044918epcas5p448b475256fc5232bcb34b67f564088b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241112044918epcas5p448b475256fc5232bcb34b67f564088b9
References: <CGME20241112044918epcas5p448b475256fc5232bcb34b67f564088b9@epcas5p4.samsung.com>

The existing implementation of the TxFIFO resizing logic only supports
scenarios where more than one port RAM is used. However, there is a need
to resize the TxFIFO in USB2.0-only mode where only a single port RAM is
available. This commit introduces the necessary changes to support
TxFIFO resizing in such scenarios by adding a missing check for single
port RAM.

This fix addresses certain platform configurations where the existing
TxFIFO resizing logic does not work properly due to the absence of
support for single port RAM. By adding this missing check, we ensure
that the TxFIFO resizing logic works correctly in all scenarios,
including those with a single port RAM.

Fixes: 9f607a309fbe ("usb: dwc3: Resize TX FIFOs to meet EP bursting requirements")
Cc: stable@vger.kernel.org # 6.12.x: fad16c82: usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---

Changes in v3:
 - Updated the $subject and commit message.
 - Added Fixes tag, and addressed some minor comments from reviewer .
 - Link to v2: https://lore.kernel.org/linux-usb/20241111142049.604-1-selvarasu.g@samsung.com/

Changes in v2:
 - Removed the code change that limits the number of FIFOs for bulk EP,
   as plan to address this issue in a separate patch.
 - Renamed the variable spram_type to is_single_port_ram for better
   understanding.
 - Link to v1: https://lore.kernel.org/lkml/20241107104040.502-1-selvarasu.g@samsung.com/
---
 drivers/usb/dwc3/core.h   |  4 +++
 drivers/usb/dwc3/gadget.c | 54 +++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 8 deletions(-)

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
index 2fed2aa01407..6101e5467b08 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -687,6 +687,44 @@ static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
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
+	bool is_single_port_ram;
+
+	/* Check supporting RAM type by HW */
+	is_single_port_ram = DWC3_SPRAM_TYPE(dwc->hwparams.hwparams1);
+
+	/*
+	 * If a single port RAM is utilized, then allocate TxFIFOs from
+	 * RAM0. otherwise, allocate them from RAM1.
+	 */
+	ram_depth = is_single_port_ram ? DWC3_RAM0_DEPTH(dwc->hwparams.hwparams6) :
+			DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+
+	/*
+	 * In a single port RAM configuration, the available RAM is shared
+	 * between the RX and TX FIFOs. This means that the txfifo can begin
+	 * at a non-zero address.
+	 */
+	if (is_single_port_ram) {
+		u32 reg;
+
+		/* Check if TXFIFOs start at non-zero addr */
+		reg = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+		fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(reg);
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
@@ -753,7 +791,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
 	int fifo_0_start;
-	int ram1_depth;
+	int ram_depth;
 	int fifo_size;
 	int min_depth;
 	int num_in_ep;
@@ -773,7 +811,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
 		return 0;
 
-	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
 
 	switch (dwc->gadget->speed) {
 	case USB_SPEED_SUPER_PLUS:
@@ -809,7 +847,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	/* Reserve at least one FIFO for the number of IN EPs */
 	min_depth = num_in_ep * (fifo + 1);
-	remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
+	remaining = ram_depth - min_depth - dwc->last_fifo_depth;
 	remaining = max_t(int, 0, remaining);
 	/*
 	 * We've already reserved 1 FIFO per EP, so check what we can fit in
@@ -835,9 +873,9 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
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
@@ -3090,7 +3128,7 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
 	struct dwc3 *dwc = gadget_to_dwc(g);
 	struct usb_ep *ep;
 	int fifo_size = 0;
-	int ram1_depth;
+	int ram_depth;
 	int ep_num = 0;
 
 	if (!dwc->do_fifo_resize)
@@ -3113,8 +3151,8 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
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


