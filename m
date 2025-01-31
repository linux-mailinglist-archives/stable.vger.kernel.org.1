Return-Path: <stable+bounces-111799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC1DA23CBD
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 12:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D2516916E
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A041BD9C1;
	Fri, 31 Jan 2025 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N1ui63Cj"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559F1BBBE3
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738321757; cv=none; b=sNKx+AGOzHCbNRWYE5GpAT0GH8rCwMkYgQcJRDQ/dmerYbqbnkEHB03UW16cR+o8Ufs09q1YQacbQKC9a1ttRg6ssdx8OHNt8fIKxQJZWSyHBR42w3mSxYESf78KvlAlkuSLEziYyL/Dh8CenI5qUAjcGmuk9/MYtpuqxUVklc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738321757; c=relaxed/simple;
	bh=8Me/96beICFSRJ+CV9i13yaVWtocv97Dr2ihIhTxUHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=YdtppPoMNGpnrbMBX/fCOfZnDgYdiEU8+stVS+5E39nhPH9GAjkriF1jJ0FqOHiMUkJuNB32fNJrjBaMXn3hwbNSTwQegHORXFEdG3MOfIuxgnPb4Iw6tbg+FPN5GJIqnC23jTTFwGtEZ6mw7pMglmaIgaDsePQOoGu7JGeO97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N1ui63Cj; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250131110912epoutp029f928831052a08b84fa8923f41e42958~fwmyS5lFb2832028320epoutp02O
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 11:09:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250131110912epoutp029f928831052a08b84fa8923f41e42958~fwmyS5lFb2832028320epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738321752;
	bh=DTi0wp41e+JOaWJD1kbZmcZ2rVb/J13X3BcVFTbi2RU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=N1ui63CjQdec0MdbUQrUtGaxBXDnirY0KHep1votclJTz3s5jDJE0rj6d5ApFh3ZC
	 htZXIsEUloHRRsIWWQ41VVMRbi7qniguaX/mALXnglVFw238ICZRI4Cr+eTHIEImfc
	 XOclyc6+5jDHmh76xx/uc6Ff9I7kDP8cmVE/qWZw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250131110911epcas5p17ad7e53d46ecd130966d4fab6b7873cb~fwmxZp7gp0443504435epcas5p12;
	Fri, 31 Jan 2025 11:09:11 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YktSQ3NGKz4x9Pp; Fri, 31 Jan
	2025 11:09:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.24.20052.65FAC976; Fri, 31 Jan 2025 20:09:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250131110910epcas5p25ee5f0ab53949ad3759c0825d11170b3~fwmvvPCIP0496904969epcas5p2P;
	Fri, 31 Jan 2025 11:09:10 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250131110910epsmtrp23c36ad641a31f0759419f7ee4e5a7e5b~fwmvuaPoQ3151931519epsmtrp2e;
	Fri, 31 Jan 2025 11:09:10 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-d0-679caf56e109
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	27.42.23488.55FAC976; Fri, 31 Jan 2025 20:09:09 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250131110907epsmtip1fefbc5e83af06f3fa2db95051ac67681~fwmtk9WBP0199901999epsmtip1J;
	Fri, 31 Jan 2025 11:09:07 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, balbi@ti.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH] usb: dwc3: Fix timeout issue during controller enter/exit
 from halt state
Date: Fri, 31 Jan 2025 16:38:30 +0530
Message-ID: <20250131110832.438-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmpm7Y+jnpBi29YhZvrq5itXgwbxub
	xcH79RZ3Fkxjsji1fCGTRfPi9WwWf29fZLW4+/AHi8XlXXPYLBYta2W2+HT0P6vFkeUfmSwW
	bHzEaLGiGSi2asEBdgd+j/1z17B79G1ZxeixZf9nRo/jN7YzeXzeJBfAGpVtk5GamJJapJCa
	l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rZJCWWJOKVAoILG4WEnf
	zqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PNtlvMBW+EKh4/
	3czYwHiRv4uRk0NCwERi/d6fzF2MXBxCArsZJVbPfM8I4XxilDh8cA47hPONUeLQ918sXYwc
	YC0zlihBxPcySpy9fBGq4zujxOMX+5hAitgEDCWenbABiYsINDFKtN+7xQriMAs0MUksmNbL
	BLJcWCBG4vDhHywgNouAqsTDHQeZQWxeASuJRSuaWCEO1JRYu3cPE0RcUOLkzCdg9cwC8hLN
	W2eDHS4hMJdD4v7k+4wQDS4SL1dPgbKFJV4d38IOYUtJfH63lw3CTpbYM+kLVDxD4tCqQ8wQ
	tr3E6gVnWEE+YAZavH6XPsQuPone30+YIL7nlehoE4KoVpU41XgZaqK0xL0l16BO9pD4tusZ
	WFxIIFbi3ZSNTBMY5WYh+WAWkg9mISxbwMi8ilEytaA4Nz212LTAMC+1HB6Zyfm5mxjBCVXL
	cwfj3Qcf9A4xMnEwHmKU4GBWEuGNPTcjXYg3JbGyKrUoP76oNCe1+BCjKTBYJzJLiSbnA1N6
	Xkm8oYmlgYmZmZmJpbGZoZI4b/POlnQhgfTEktTs1NSC1CKYPiYOTqkGJq93x/bkPTneavv8
	TuEylmcXVgo4Myh4c3z9d3O97d7Xiwwqi73j9RkUXq6xdJfvupVY+ctwR/v/K8ymDyYEB+35
	d+aF49zPs5QiuDZcesufsYnnyX5G3mbls++tDcsuXJ+kt1gqw3HDnO4jf22r+6aKGHnteMWb
	/lFYeIdL5Nq10veZ42tiTqjM+9W0hEVwh41y46UqBdWksj97++cstn12j8coKdbylYD/woLE
	7n6Gdc99/Ys7zkQvDzldEi3aP2uB2ttmKfG7byqyFzyZHRuY2TjZZcL2hQtn1GVEOhiJ/5i2
	auOmtKyLF+IZ5+20+mZSdnHVA74Zsl9DNL9afo/ZWTn9Qd+kWSqT2mOV6pRYijMSDbWYi4oT
	Ae+iOLQxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnG7o+jnpBn/eG1m8ubqK1eLBvG1s
	Fgfv11vcWTCNyeLU8oVMFs2L17NZ/L19kdXi7sMfLBaXd81hs1i0rJXZ4tPR/6wWR5Z/ZLJY
	sPERo8WKZqDYqgUH2B34PfbPXcPu0bdlFaPHlv2fGT2O39jO5PF5k1wAaxSXTUpqTmZZapG+
	XQJXxpttt5gL3ghVPH66mbGB8SJ/FyMHh4SAicSMJUpdjFwcQgK7GSWmnFnL1MXICRSXlng9
	q4sRwhaWWPnvOTtE0VdGie5de9lBmtkEDCWenbABiYsIdDBKbOudyQziMAv0MUm0nDnEAtIt
	LBAlcWXDRrBJLAKqEg93HGQGsXkFrCQWrWhihdigKbF27x4miLigxMmZT1hAFjALqEusnycE
	EmYWkJdo3jqbeQIj/ywkVbMQqmYhqVrAyLyKUTK1oDg3PTfZsMAwL7Vcrzgxt7g0L10vOT93
	EyM4QrQ0djC++9akf4iRiYPxEKMEB7OSCG/suRnpQrwpiZVVqUX58UWlOanFhxilOViUxHlX
	GkakCwmkJ5akZqemFqQWwWSZODilGpgEc4K4Zlj5nfNf0NDGExzTdO13OWv+Ay493VTZA5sl
	Py3eWnJfMP6oi7NKxcWTskGTg1bkrPmhmrX4zezdUYucZqizvrFK4I1VmRys8mpq8bltRXp/
	pDMbvbbMLpgtpzZrU/Gbjatcu36f/CRyq08y69NT00lCrHH8nk9uXz2r3F3+SkDbpXL7nPI/
	CuwdaecbbzVZ/5nTtT1NV7SCY37kPJP99hNWL+FhvXPcUmXOfsl3s03YHj5el6G6z1u2+3/A
	15mTNhlu0Jok2dt4U+iweYzvdp9lFW0x3az3H2spNnpk1zA22uw8W520I61STsheeP4Oaym7
	qe7nGjX6pOWc7ybIHIrLPThfcv/OY0osxRmJhlrMRcWJABrcYNr/AgAA
X-CMS-MailID: 20250131110910epcas5p25ee5f0ab53949ad3759c0825d11170b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250131110910epcas5p25ee5f0ab53949ad3759c0825d11170b3
References: <CGME20250131110910epcas5p25ee5f0ab53949ad3759c0825d11170b3@epcas5p2.samsung.com>

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
 drivers/usb/dwc3/gadget.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d27af65eb08a..4a158f703d64 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2629,10 +2629,25 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 2000;
+	u32			saved_config = 0;
 
 	if (pm_runtime_suspended(dwc->dev))
 		return 0;
 
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
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
@@ -2660,6 +2675,12 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
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


