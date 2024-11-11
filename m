Return-Path: <stable+bounces-92136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433629C40C8
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84280B225D7
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6211B1A254E;
	Mon, 11 Nov 2024 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hyzcif3q"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C81A0BE0
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334904; cv=none; b=fnXB0zoom6NaVtO4mT0x/1bYz9PW/6l0DJKQU9NaD5pyzX4991ffyaFQ+iU2mOUhg0KIMz7Hn/dM/oOznbuar04LXdkvtek4IOejLUNXnypsfxR6WlOWl+M9vW+/qza1gKEid1LY0G7A7RnHzSPiHfBItQ3+oPzbLNAJe41lZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334904; c=relaxed/simple;
	bh=Fc5wcY/VuB7wFm97v0b2wS8Xt7up11e+n7HfYlCY+EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=h4KIBB6nRuDqke7Ovro2jkM2teMscJVIF3kQMQEPyl3x2K6o9M1Jph2ip+g+CF6OOJWWM6Rj+5o/mtv9lS/YqvtCQ7mEqKivOIgeFEaMYutv7y8J+Q4a4NV9IA5aGjk5PdbqUUogkUALTW9RzBACGQFM8s4xfvzbx/eIlKg2er4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hyzcif3q; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241111142138epoutp018243f42ea0444180419d387cdde2d729~G7_redY9g1619416194epoutp01e
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 14:21:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241111142138epoutp018243f42ea0444180419d387cdde2d729~G7_redY9g1619416194epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731334898;
	bh=YtMkhK1mMby1HD4D2098ozt1HxtvIBpd+MIJB+W7aFk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hyzcif3qUUyO6Ge/Lf3vOg2nYhYvdfaCkRTmagF5oHiiFca3I1gJ4wsxVofDT/rvU
	 AuuBenqNmI8A5M/HXTPOw5IdTp6zwig7IY3D/J/tLqn6+GHQPhpTo0E/XbCKMQnYpA
	 4ptHyUG3vStU3EUiBbKZpZN6EIr8HHdSmC+xWBOw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241111142138epcas5p296593bcba6a0ed67984530ac98ba6f41~G7_q2HZ5V2767227672epcas5p27;
	Mon, 11 Nov 2024 14:21:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XnBYq6DZTz4x9Px; Mon, 11 Nov
	2024 14:21:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A1.60.09770.FE212376; Mon, 11 Nov 2024 23:21:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241111142135epcas5p32c01b213f497f644b304782876118903~G7_oEUOCI1488814888epcas5p3U;
	Mon, 11 Nov 2024 14:21:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241111142135epsmtrp1ff8bf362c3252488bfb1e7463e6551e5~G7_oDY86b1274612746epsmtrp1b;
	Mon, 11 Nov 2024 14:21:35 +0000 (GMT)
X-AuditID: b6c32a4a-e25fa7000000262a-4c-673212ef5821
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.3B.35203.EE212376; Mon, 11 Nov 2024 23:21:34 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241111142132epsmtip29ddaa720366e080ce6ec5dc49c9c8787~G7_llLVo71973719737epsmtip2w;
	Mon, 11 Nov 2024 14:21:32 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	quic_akakum@quicinc.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stern@rowland.harvard.edu
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, Selvarasu Ganesan <selvarasu.g@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
Date: Mon, 11 Nov 2024 19:50:45 +0530
Message-ID: <20241111142049.604-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmhu57IaN0g6cHdS3eXF3FavFg3jY2
	izsLpjFZnFq+kMmiefF6NotJe7ayWNx9+IPF4vKuOWwWi5a1Mlt8Ovqf1eL2n72sFqs657BY
	HFn+kcni8vedzBYLNj5itJjw+wJQ20FRi1ULDrA7CHnsn7uG3WPinjqP2Xd/MHr0bVnF6LFl
	/2dGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwC
	dN0yc4AeUFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZY
	GRoYGJkCFSZkZzxZUFFwQrPi55EtjA2M3xS7GDk5JARMJFbuWMvcxcjFISSwm1Hi2s3rzCAJ
	IYFPjBKrWyogEt8YJbYt6GCF6fh6/jITRGIvo8T39yfYIZzvQO2TL7N1MXJwsAkYSjw7YQMS
	FxFYxSjx72gTK4jDLLCbSWLVg/vsIEXCApES89aYgExlEVCVmNdziA3E5hWwkthxaxojxDZN
	ibV79zBBxAUlTs58wgJiMwvISzRvnQ12t4TADg6Ju7u/sEE0uEjsW/aXHcIWlnh1fAuULSXx
	sr8Nyk6W2DPpC5SdIXFo1SFmCNteYvWCM6wgtzEDLV6/Sx9iF59E7+8nTCBhCQFeiY42IYhq
	VYlTjZehtkpL3FtyDRpAHhKt/W8YIaEYKzF7+hnGCYxys5B8MAvJB7MQli1gZF7FKJlaUJyb
	nlpsWmCUl1oOj8rk/NxNjOCUq+W1g/Hhgw96hxiZOBgPMUpwMCuJ8Gr466cL8aYkVlalFuXH
	F5XmpBYfYjQFButEZinR5Hxg0s8riTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1
	CKaPiYNTqoGpbaOMglCygLBjypXEycwld+ort+V2ib3jkDq+r8O8Pv2ugciHzq1yTo8Wsmb+
	Fiu/kb7y2sMrNgasTFdkXasfidTvOnBLwj7paI7iQuEP6QX2J409+60lD7u+Xv0xSOGQ1jev
	yJyLgYG1Xgu0T6cu0I8VL54RyxgT+Ijfqz/yuEtaT+MpuQtX61eo/Pxp9GR2agrbVaXA0u3X
	+tf6L0q7+OFq6cG+x1t3awEDqOyxaGtuyePCDF3B1RqPJ3cV91uEX5qxavckj19J12rebBQ5
	/dzB+cv2Z4XrReapMno2vZ6lf6VJWPRFy+WFcpmKplMymB9eELx8t3Jit+7ursuph+coVMmJ
	Py5TMSl8rsRSnJFoqMVcVJwIAJaSYUxCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvO57IaN0g3+6Fm+urmK1eDBvG5vF
	nQXTmCxOLV/IZNG8eD2bxaQ9W1ks7j78wWJxedccNotFy1qZLT4d/c9qcfvPXlaLVZ1zWCyO
	LP/IZHH5+05miwUbHzFaTPh9AajtoKjFqgUH2B2EPPbPXcPuMXFPncfsuz8YPfq2rGL02LL/
	M6PH501yAWxRXDYpqTmZZalF+nYJXBlPFlQUnNCs+HlkC2MD4zfFLkZODgkBE4mv5y8zgdhC
	ArsZJTauNoSIS0u8ntXFCGELS6z895y9i5ELqOYro8S2Bw9Yuxg5ONgEDCWenbABiYsIbGCU
	eHr5EhuIwyxwkkmi+esjFpBuYYFwidVPm9lAbBYBVYl5PYfAbF4BK4kdt6ZBbdCUWLt3DxNE
	XFDi5MwnLCALmAXUJdbPEwIJMwvISzRvnc08gZF/FpKqWQhVs5BULWBkXsUomVpQnJueW2xY
	YJiXWq5XnJhbXJqXrpecn7uJERxDWpo7GLev+qB3iJGJg/EQowQHs5IIr4a/froQb0piZVVq
	UX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUwWSYOTqkGpqZ+iWN1U6q6Xpydevzd
	3EnLstNsOJ10U6dOWLX8t76h4YPrm9Zqyl549dBalfHz5rUFnHed+zb4lR34GFebc0HDmfGV
	vO07U4P8mOn/gmd9W3QuU2Z5t/mzValm9+qMkqrbOZLmBdSLubrMFGx+VOK39lvmWr6sdt6C
	B7pdQr8syxMj1Tgt/jsf+JEq9jcvdELPo0WsYumSu4Uq1djeO1h29/9eUXrHRmZDVv4jIb7V
	M7t4pI0+dvo0u/U8OVxyQUD//AkLvuR7n2593iQ+JXZRpdF8vnn8y1TENcWuT0jZNSvPVljy
	UeHc7CUl21R5T/CoLl59klWwJF/FLf78y2tNLqlbbmxqfr9fNO+oEktxRqKhFnNRcSIA47XH
	0xADAAA=
X-CMS-MailID: 20241111142135epcas5p32c01b213f497f644b304782876118903
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241111142135epcas5p32c01b213f497f644b304782876118903
References: <CGME20241111142135epcas5p32c01b213f497f644b304782876118903@epcas5p3.samsung.com>

The existing implementation of the TxFIFO resizing logic only supports
scenarios where more than one port RAM is used. However, there is a need
to resize the TxFIFO in USB2.0-only mode where only a single port RAM is
available. This commit introduces the necessary changes to support
TxFIFO resizing in such scenarios.

Cc: stable@vger.kernel.org # 6.12.x: fad16c82: usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---

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
index 2fed2aa01407..4f2e063c9091 100644
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
+	int tmp;
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
+
+	/*
+	 * In a single port RAM configuration, the available RAM is shared
+	 * between the RX and TX FIFOs. This means that the txfifo can begin
+	 * at a non-zero address.
+	 */
+	if (is_single_port_ram) {
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


