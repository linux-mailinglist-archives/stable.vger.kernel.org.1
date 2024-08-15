Return-Path: <stable+bounces-69309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FD9954604
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 11:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71133281B2E
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EFF1667E1;
	Fri, 16 Aug 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZNvnTymD"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB45165EFE
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801527; cv=none; b=DDyCsQIAJJdVBtbTLNPs6KYJx8uDJESXsb/iVX/sd3b6rsNqRm0aTv1dfP/+WXOmTDyn8XFYls3OneEfziilb1RPD6T1hzCtwC/RE/qIXvuJnLAy3RECZRGSU6E0dXkjaQxhQmdl1hKdhFusLgqiLiuE7SGKY+7X9gJHg5zcx2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801527; c=relaxed/simple;
	bh=NlqRd+YnQZBm5VFL+HzJ4ijReg9PePdpkBX+nO/ztJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=F21lCGpmHF71OfSOocam8NrKFkaxlIRvYWZlQ5cZsw/qKYAvQ4GfB6GQS+yMlwKQMShRo3UYDPklppT9rCtElLSqhsxdbr9/IXY4+TYd1L2Rcwleyf9C0x+hwY5l5//vtYLOonuzp6mwZl6tipeb1DJDC/sYxkUKEQ/F7G+ed1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZNvnTymD; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240816094522epoutp02db9061f4ec675d36640f7ce7be4f62f9~sLFoHh3AR2329823298epoutp02s
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 09:45:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240816094522epoutp02db9061f4ec675d36640f7ce7be4f62f9~sLFoHh3AR2329823298epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723801522;
	bh=hak/V2qJ7HDVRDcAmIQFiOQebTO2H9ff6Prfs4qNVZY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ZNvnTymDw0SwWCOWe+HbREMYeCpU+OE9N56qCQsL95GH3cMTr5Zxkv1SGtMgiK1kC
	 DJxWwG2p3KWzMSPBGi4yNXbGSa3JqL5yDQ5vVZ2Pn7oSDklnxkVIS19KjM4a0X3v7d
	 +31h5/Yo4ObYHVVrmmiIPdDqoSMc+drG7TJmZ62c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240816094522epcas5p3595f7328b75f5c04a9e33a95ae56c68c~sLFnnHN7E1754617546epcas5p3z;
	Fri, 16 Aug 2024 09:45:22 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WlcYD2Gncz4x9Px; Fri, 16 Aug
	2024 09:45:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	87.06.08855.0BF1FB66; Fri, 16 Aug 2024 18:45:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe~r1CnBfAMC2853628536epcas5p1O;
	Thu, 15 Aug 2024 06:49:18 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240815064918epsmtrp2cc81b8f6a6468629cfbe31c1f0123a4c~r1CnAq4tO2421924219epsmtrp2B;
	Thu, 15 Aug 2024 06:49:18 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-45-66bf1fb0b967
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	35.B1.07567.EE4ADB66; Thu, 15 Aug 2024 15:49:18 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240815064915epsmtip2fa8f4ace9ad84201fcccdb71d46d4e65~r1Ck3ILTv2148721487epsmtip2M;
	Thu, 15 Aug 2024 06:49:15 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
Date: Thu, 15 Aug 2024 12:18:31 +0530
Message-ID: <20240815064836.1491-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmlu4G+f1pBmvmcVu8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TmHxeLI8o9MFpe/72S2
	WLDxEaPFpIOiFqsWHGB34PfYP3cNu0ffllWMHlv2f2b0+LxJLoAlKtsmIzUxJbVIITUvOT8l
	My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hQJYWyxJxSoFBAYnGxkr6dTVF+
	aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xu7HX1kK5glW3Fuwk62B
	8SFvFyMnh4SAicSZHc+Yuhi5OIQEdjNK3Nv1kxnC+cQocbPxFFTmG6PEtpVb2GFaLt3dww6R
	2MsocffOdkYI5zujxM8Ju9m6GDk42AQMJZ6dsAFpEBEokbj0diMTiM0ssIBJonW2NogtLBAt
	MbGniw3EZhFQlbhzbBMriM0rYC2xoreJDWKZpsTavXuYIOKCEidnPmGBmCMv0bx1NtipEgKt
	HBK9t88wg+yVEHCR+LVSFqJXWOLVcZijpSQ+v9sLNbNaYvWdj2wQvS2MEoeffIMqspd4fPQR
	2BxmoMXrd+lDhGUlpp5aB3U/n0Tv7ydMEHFeiR3zYGxViVONl6HmS0vcW3KNFcL2kJj8Ygsz
	iC0kECux9OIRpgmM8rOQvDMLyTuzEDYvYGRexSiZWlCcm56abFpgmJdaDo/Y5PzcTYzg9Krl
	soPxxvx/eocYmTgYDzFKcDArifA+/bI3TYg3JbGyKrUoP76oNCe1+BCjKTCMJzJLiSbnAxN8
	Xkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTDNOr9mz+ITYH+Wl
	1t2sk1rW/zdXOn8173NFwMtPTdLvPLsZfqe8j/vq0ixbuOF1l4Zm6+rHpXpx6/sazV5ZVn9M
	2sJ82O+fZkxIoPkK7fNaKXNf10vLlH664+3SfEyEITZ61qzVdhElVw+buLSdf9QmeTHv2bsf
	rMs5uNY/zJ38c2LcUtszrPcYZz8UXeSk8j8g+FRLxu+1BfmR7lr/JmeVxhTqzpJx2cR8p/ry
	Xr/rwqeereH4uDA+ZbXH1a77hZ2RqkdTfXi7d2/y3XR62T+BlNtBcUXyxtaa3FtL2u/PNr5/
	bfI6PjWGn8X/z3wPNA4TvlN4J7oq1MFn2Vm3q22fJ2y+U3D0XYLhRwWzKUosxRmJhlrMRcWJ
	AKInNfY4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvO67JXvTDH48ZLd4c3UVq8WdBdOY
	LE4tX8hk0bx4PZvFpD1bWSzuPvzBYnF51xw2i0XLWpktPh39z2qxqnMOi8WR5R+ZLC5/38ls
	sWDjI0aLSQdFLVYtOMDuwO+xf+4ado++LasYPbbs/8zo8XmTXABLFJdNSmpOZllqkb5dAlfG
	7sdfWQrmCVbcW7CTrYHxIW8XIyeHhICJxKW7e9hBbCGB3YwS5055QcSlJV7P6mKEsIUlVv57
	DlTDBVTzlVHi08rXLF2MHBxsAoYSz07YgNSICFRIPF44gwWkhllgHZPE7ONPmEESwgKREtNO
	fQKzWQRUJe4c28QKYvMKWEus6G1ig1igKbF27x4miLigxMmZT1hAbGYBeYnmrbOZJzDyzUKS
	moUktYCRaRWjZGpBcW56brJhgWFearlecWJucWleul5yfu4mRnCga2nsYLw3/5/eIUYmDsZD
	jBIczEoivIEmu9KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrOmJ0iJJCeWJKanZpakFoEk2Xi
	4JRqYEp8GKrxKEncQ5XVVW3FrTrmpPZXyuGnnAV71ravW+PdsqqjWPKC0HstX6UIly2/n6xt
	YlM+vnf76jNcE+z5O8PsVuX/Fv9+ifG7c1+Q1j+d6MQFB/5NPhhixZRxnPHTBaZ5wv0d/9mk
	Z74P//kkSMtlc1jrk/Caw4eXXti2VfhG+57Ls5MPdu9Z2OLZUrHl5Fl/b73ALVM/3Vvd97Lr
	b84P5uQagV06py73FQYzCWl2HTf4zn/1/f4s56tZv5YJKB4N+sH7dYLctOoNPFpccVe/cOtE
	vZ4ZP0mHef//pOyqxZ/lZ3AbZVw3lnvC6v1I4+v1RQwPlngxyUYIMAvUB3Oe/P1XbUKSkW78
	MdeLa5RYijMSDbWYi4oTAblUv1zjAgAA
X-CMS-MailID: 20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe
References: <CGME20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe@epcas5p1.samsung.com>

This commit addresses an issue where the USB core could access an
invalid event buffer address during runtime suspend, potentially causing
SMMU faults and other memory issues in Exynos platforms. The problem
arises from the following sequence.
        1. In dwc3_gadget_suspend, there is a chance of a timeout when
        moving the USB core to the halt state after clearing the
        run/stop bit by software.
        2. In dwc3_core_exit, the event buffer is cleared regardless of
        the USB core's status, which may lead to an SMMU faults and
        other memory issues. if the USB core tries to access the event
        buffer address.

To prevent this hardware quirk on Exynos platforms, this commit ensures
that the event buffer address is not cleared by software  when the USB
core is active during runtime suspend by checking its status before
clearing the buffer address.

Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---

Changes in v3:
- Added comment on why we need this fix.
- Included platform name in commit message.
- Removed Fixes tag as no issue on the previous commits, and updated Cc tag.
- Link to v2: https://lore.kernel.org/lkml/20240808120507.1464-1-selvarasu.g@samsung.com/

Changes in v2:
- Added separate check for USB controller status before cleaning the
  event buffer.
- Link to v1: https://lore.kernel.org/lkml/20240722145617.537-1-selvarasu.g@samsung.com/
---
 drivers/usb/dwc3/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 734de2a8bd21..ccc3895dbd7f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -564,9 +564,17 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
 	if (!dwc->ev_buf)
 		return;
+	/*
+	 * Exynos platforms may not be able to access event buffer if the
+	 * controller failed to halt on dwc3_core_exit().
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	if (!(reg & DWC3_DSTS_DEVCTRLHLT))
+		return;
 
 	evt = dwc->ev_buf;
 
-- 
2.17.1


