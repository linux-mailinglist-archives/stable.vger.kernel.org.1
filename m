Return-Path: <stable+bounces-111894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320BCA24A7F
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75B31884696
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ECA1C5F0B;
	Sat,  1 Feb 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qfajuiKA"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDFB1C5D68
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428009; cv=none; b=c0tMgoNggeX9ZrouhiOuchDX0OU40X9w1ZVgOpniO0UUYj/MfFXpayP3he7etme1Nu5PvIeUke6rZqTlpMNdRgpSDPjZWVnpqEZetVIM25b7U8aeKh+hMt32xT+EuwGkfBeLn+uTGNcJnziXqh/G5Depym0ZfcDNApdLoToyrao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428009; c=relaxed/simple;
	bh=8rTLcENWnBRsgjeNz/Jux6uBDq7VKxnE2EUiulvJsGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=VUgnwI8Z3wm3qU7czd+xH6X3bRxV2YuSuv7dlrpk0CgRJ0+BQY0W4VYm7k16WL/aekvfUszRB1vpDrW6CX7M652wN/JQicImy8u6XpJXYeo/Yhk7rx2vuoirVjn3Cl9PI0vXS767H1krUElcKR7F0jcPm1NfkzPjzOkD34KXpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qfajuiKA; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250201163958epoutp0230218be779e99d00c516801b25787160~gIw3Ahrne1664116641epoutp02e
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 16:39:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250201163958epoutp0230218be779e99d00c516801b25787160~gIw3Ahrne1664116641epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738427998;
	bh=k0Y+b6rBneZRI8OvJ2IHjdex6m1O58QdnqJYxHcTUSc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=qfajuiKA/Yk4KCGKFKzydmowSakR/AChEB1ylYiryzXnimHMist7C8uZkRLWL0DEQ
	 qHnIArAWTAMPdN/LMWgSzh+nmpBKCLYzhGs8zqUNrLG8lxHHMt5dnMvHaAJHgHUhj2
	 nPAZe7n7r8tpz06WEKjNimld97K6HK1rie/hLs/M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250201163957epcas5p35c838cc9e428b197df7f1f4576b076bd~gIw2CS4Fz1900519005epcas5p3o;
	Sat,  1 Feb 2025 16:39:57 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Yldlb18fjz4x9Pv; Sat,  1 Feb
	2025 16:39:55 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.41.19710.A5E4E976; Sun,  2 Feb 2025 01:39:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250201163953epcas5p10cb7ed0c0090558d4f52c5bef63fb2dc~gIwy7EvPW0378803788epcas5p1l;
	Sat,  1 Feb 2025 16:39:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250201163953epsmtrp15aa8a59f31650f86f4e507f453e947b6~gIwy6UaAz1418614186epsmtrp1V;
	Sat,  1 Feb 2025 16:39:53 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-d5-679e4e5a0e35
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AD.1C.33707.95E4E976; Sun,  2 Feb 2025 01:39:53 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250201163951epsmtip23e2ec84c0b4c818114a4b5a53f4628cc~gIwwfsr5I2329923299epsmtip23;
	Sat,  1 Feb 2025 16:39:51 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, balbi@ti.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: Fix timeout issue during controller
 enter/exit from halt state
Date: Sat,  1 Feb 2025 22:09:02 +0530
Message-ID: <20250201163903.459-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmlm6037x0g+e7mCzeXF3FavFg3jY2
	i4P36y3uLJjGZHFq+UImi+bF69ks/t6+yGpx9+EPFovLu+awWSxa1sps8enof1aLI8s/Mlks
	2PiI0WJFM1Bs1YID7A78HvvnrmH36NuyitFjy/7PjB7Hb2xn8vi8SS6ANSrbJiM1MSW1SCE1
	Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWiWFssScUqBQQGJxsZK+
	nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsanRw/YCiZJVszb
	/IulgfG6SBcjJ4eEgInEkb3P2LsYuTiEBHYzSjxZ+AnK+cQo0dVxmBXOeftyMyNMS/uDhUwQ
	iZ2MEs1fDjKDJIQEvjNKfHqe38XIwcEmYCjx7IQNSI2IQBOjRPu9W2CTmAWamCQWTOtlAmkQ
	FoiX2HB+KdhUFgFViY33d4EN4hWwkpjxdi0bxDZNibV79zBBxAUlTs58wgJiMwvISzRvnc0M
	MlRCYCaHxJo3v6AaXCR+/bsOZQtLvDq+hR3ClpJ42d8GZSdL7Jn0BcrOkDi06hAzhG0vsXrB
	GVaQD5iBFq/fpQ+xi0+i9/cTJpCwhACvREebEES1qsSpxstQm6Ql7i25xgphe0i8u9QODZNY
	iR0P3zFNYJSbheSDWUg+mIWwbAEj8ypGydSC4tz01GTTAsO81HJ4ZCbn525iBCdULZcdjDfm
	/9M7xMjEwXiIUYKDWUmEl+PwnHQh3pTEyqrUovz4otKc1OJDjKbAYJ3ILCWanA9M6Xkl8YYm
	lgYmZmZmJpbGZoZK4rzNO1vShQTSE0tSs1NTC1KLYPqYODilGpgEMjYly0rfPHtvgv4x4Rwn
	YccJh61cfVt/Vu+35bk74cJ1i5+msguSbYPSexflnlnunLPgZtsjY5kp28QFzr3LflNzwypD
	9fnCU3YzVrG1Gy/fM8XiYdOnWNeob++c7pawfZppovVZMeZVrOiRlRdXM3OwdlY+EAiVsrku
	IRZ48Fu7784HnOd+zD6kp/yd1ShY4lV/zJPC869VFqxb9O9JoIm/RfKvqQFPlmsKmq9udTka
	vHa/Y9jTv9r73IKMXcuiHL6bsR9pPKB/sPFXrod60M49KQxtps5HL3l9+XLb0U5TrVE4+XP+
	TIPKnwe5S8+lBRraT/9a+E7t47zMUr+16VlnhVaXF99LkHlUfVOJpTgj0VCLuag4EQCxcpgZ
	MQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSvG6k37x0g+Ov1C3eXF3FavFg3jY2
	i4P36y3uLJjGZHFq+UImi+bF69ks/t6+yGpx9+EPFovLu+awWSxa1sps8enof1aLI8s/Mlks
	2PiI0WJFM1Bs1YID7A78HvvnrmH36NuyitFjy/7PjB7Hb2xn8vi8SS6ANYrLJiU1J7MstUjf
	LoEr49OjB2wFkyQr5m3+xdLAeF2ki5GTQ0LARKL9wUImEFtIYDujxKEXxRBxaYnXs7oYIWxh
	iZX/nrND1HxllPjYr9LFyMHBJmAo8eyETRcjF4eIQAejxLbemcwgDrNAH5NEy5lDLCANwgKx
	Eqt6e8EWsAioSmy8v4sZxOYVsJKY8XYtG8QCTYm1e/cwQcQFJU7OfMICsoBZQF1i/TwhkDCz
	gLxE89bZzBMY+WchqZqFUDULSdUCRuZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ+bmbGMFxoRW0
	g3HZ+r96hxiZOBgPMUpwMCuJ8HIcnpMuxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9
	sSQ1OzW1ILUIJsvEwSnVwLR2zt9Pr68ePhGg3/DkAvfbDO+ve+X+PuSe/U0p78+bieKLV3Tu
	Wia0V2fy0azZ0ZtWa7afS2D9KjFdsCKudn3oqh/z9uZk7oiV1WGcY9dhNX/t3xnHKp0cN0c3
	buCd5bvk+sOPe6QXd3980l72yupTqtH8lgBu+00nvA8JxGfZF269YesreHG1u0iwk4FZ/dIy
	1zSTdXLrJhvW79nDvv7kbvmz1baaXp2zrW7Wunu+tuZwvKA3kdPyS1fKwt3vuDXKuLtPLglU
	mbxv8jSXKRc/Pv3Cce1P0jdRFptdUVPy00MD7t+a3Xda4chN6/RDq7kPFk+ePnPriZ3hsYLz
	r3pVTbrG1D17PverLQahEbxpSizFGYmGWsxFxYkAWb2wvfoCAAA=
X-CMS-MailID: 20250201163953epcas5p10cb7ed0c0090558d4f52c5bef63fb2dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250201163953epcas5p10cb7ed0c0090558d4f52c5bef63fb2dc
References: <CGME20250201163953epcas5p10cb7ed0c0090558d4f52c5bef63fb2dc@epcas5p1.samsung.com>

There is a frequent timeout during controller enter/exit from halt state
after toggling the run_stop bit by SW. This timeout occurs when
performing frequent role switches between host and device, causing
device enumeration issues due to the timeout. This issue was not present
when USB2 suspend PHY was disabled by passing the SNPS quirks
(snps,dis_u2_susphy_quirk and snps,dis_enblslpm_quirk) from the DTS.
However, there is a requirement to enable USB2 suspend PHY by setting of
GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY bits when controller starts
in gadget or host mode results in the timeout issue.

This commit addresses this timeout issue by ensuring that the bits
GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY are cleared before starting
the dwc3_gadget_run_stop sequence and restoring them after the
dwc3_gadget_run_stop sequence is completed.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---

Changes in v2:
 - Added some comments before the changes.
 - And removed "unlikely" in the condition check.
 - Link to v1: https://lore.kernel.org/linux-usb/20250131110832.438-1-selvarasu.g@samsung.com/
---
 drivers/usb/dwc3/gadget.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d27af65eb08a..ddd6b2ce5710 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2629,10 +2629,38 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 2000;
+	u32			saved_config = 0;
 
 	if (pm_runtime_suspended(dwc->dev))
 		return 0;
 
+	/*
+	 * When operating in USB 2.0 speeds (HS/FS), ensure that
+	 * GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY are cleared before starting
+	 * or stopping the controller. This resolves timeout issues that occur
+	 * during frequent role switches between host and device modes.
+	 *
+	 * Save and clear these settings, then restore them after completing the
+	 * controller start or stop sequence.
+	 *
+	 * This solution was discovered through experimentation as it is not
+	 * mentioned in the dwc3 programming guide. It has been tested on an
+	 * Exynos platforms.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (reg & DWC3_GUSB2PHYCFG_SUSPHY) {
+		saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	}
+
+	if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
+		saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
+		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+	}
+
+	if (saved_config)
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
 		if (DWC3_VER_IS_WITHIN(DWC3, ANY, 187A)) {
@@ -2660,6 +2688,12 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 		reg &= DWC3_DSTS_DEVCTRLHLT;
 	} while (--timeout && !(!is_on ^ !reg));
 
+	if (saved_config) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		reg |= saved_config;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	}
+
 	if (!timeout)
 		return -ETIMEDOUT;
 
-- 
2.17.1


