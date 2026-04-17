Return-Path: <stable+bounces-238427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJgZFaXU4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:35:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A07E417753
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABFDE300B509
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DA732AAA8;
	Fri, 17 Apr 2026 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ESNzGXNj"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394443321C1
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407710; cv=none; b=STPmf/D9t4sjzcAZzr3gNDUBJ4rH32GbmnPHHQEMhnPDaTKmxKLt+FRhzV8JsSe9GTRr54jgMFuFWfdWG0J0enb8PISiACZa4Yvt7DWfTEQcxgnux8YDHhbQ6s65a2549n1e8o9cBX6zxkssg0lgULpufngrjNzgOQX76dLjH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407710; c=relaxed/simple;
	bh=W3f3QPjWzyHt+IqnFm5wz1nKD/zeDiylTNwZCBWCqQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=JX8SjEsn/Op4pfgyBD1rhDk2uJW6zvFRObev36GRFhmvy1vye+YoNKoYrc6h26yRLm6uTOX6K2JypSoicPlx8O0vDt6/uyJ689JVi2fg/Ds/9h6vSsB4QruJf0cemL8Nj9iMxk/W0NCHNSVqHDUH/eE6BE4737spF76pvg6qzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ESNzGXNj; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260417063504epoutp011547feff84b61b719119f8a66fcccf21~nEWVG3Hk01925119251epoutp01N
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:35:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260417063504epoutp011547feff84b61b719119f8a66fcccf21~nEWVG3Hk01925119251epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776407704;
	bh=Lpbhl2216kBv9raG5ut84Dg7CXhWy06hp8E7nL8IRwA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ESNzGXNjmCkk6x/jGml3+04vzkhFaUWsfcTcnMEM8/wlUbA2idZq0xM6yOekFnm5P
	 bYqdk+/08oY/7P5YXYW28cELTjS+m4hUSkndVmnZXjCkqeN9TySsSPsi8eg3PmyrFJ
	 PcW6UMDAjWdo7MI0w1x02Ao3T1tlYTj/DtpDcdSQ=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260417063504epcas5p18a1807b16f633b8c3085b2b030ffc2d5~nEWUrS6aT2717727177epcas5p1t;
	Fri, 17 Apr 2026 06:35:04 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fxlVb1dQDz6B9mG; Fri, 17 Apr
	2026 06:35:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260417063502epcas5p4f8f7fefb697e6d130ef7e9a78581ed84~nEWTRLC_w1182311823epcas5p45;
	Fri, 17 Apr 2026 06:35:02 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260417063456epsmtip1d808da0beed8e4e1ede0b1e3ca08f119~nEWNgGJT90046800468epsmtip1U;
	Fri, 17 Apr 2026 06:34:56 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	paulz@synopsys.com, balbi@ti.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, akash.m5@samsung.com, h10.kim@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, muhammed.ali@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>, stable@vger.kernel.org, Pritam
	Manohar Sutar <pritam.sutar@samsung.com>
Subject: [PATCH v2] usb: dwc3: Move GUID programming after PHY
 initialization
Date: Fri, 17 Apr 2026 12:03:11 +0530
Message-ID: <20260417063314.2359-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260417063502epcas5p4f8f7fefb697e6d130ef7e9a78581ed84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260417063502epcas5p4f8f7fefb697e6d130ef7e9a78581ed84
References: <CGME20260417063502epcas5p4f8f7fefb697e6d130ef7e9a78581ed84@epcas5p4.samsung.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238427-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samsung.com:email,samsung.com:dkim,samsung.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvarasu.g@samsung.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5A07E417753
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Linux Version Code is currently written to the GUID register before
PHY initialization. Certain PHY implementations (such as Synopsys eUSB
PHY performing link_sw_reset) clear the GUID register to its default
value during initialization, causing the kernel version information to
be lost.

Move the GUID register programming to occur after PHY initialization
completes to ensure the Linux version information persists.

Fixes: fa0ea13e9f1c ("usb: dwc3: core: write LINUX_VERSION_CODE to our GUID register")
Cc: stable@vger.kernel.org
Reported-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/dwc3/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 161a4d58b2cec..0d3c7e7b2262f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1341,12 +1341,6 @@ int dwc3_core_init(struct dwc3 *dwc)
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
-	/*
-	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
-	 */
-	dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
-
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		return ret;
@@ -1378,6 +1372,12 @@ int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err_exit_phy;
 
+	/*
+	 * Write Linux Version Code to our GUID register so it's easy to figure
+	 * out which kernel version a bug was found.
+	 */
+	dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
+
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
-- 
2.34.1


