Return-Path: <stable+bounces-235576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB2KOvag2GnegAgAu9opvQ
	(envelope-from <stable+bounces-235576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 09:04:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960E3D30DF
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 09:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F174F300A618
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260738A707;
	Fri, 10 Apr 2026 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l+Yx/GS4"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9B2F5491
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775804574; cv=none; b=Hdo0FTh+mwrg7qwUo95JDSigl26sdvjWEDYUxlDLD0dm2EuH0H/lrCuJY04Pj/TLixPWh33te40UiMk6dM7itdIxBRpnrLVzJQV6BmqS5C4ryQCJ7cbYOQTyMHe25dGgXtCOgclYDetdIm5uL7tZ2GfysY6QxAUXDw5S95I0EDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775804574; c=relaxed/simple;
	bh=K3hQ5jm8t2fkVfIGCGJVlfspJl1D3BTnooCoyYx0Wvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=ZCmEkAwQPiSjsPNkQ7S9dbES9DteNsKnA8xFQaK9+V8VNjHI5Johqa2MA57G/USt0Hc/beXRU3gR0RkqEka7BLPDcXoEEe1ahOOuNvnqjAsDykxWrEHkuI621zNK+Wwm+ODNBSYySeU3dQU+0RaU5O8Rfh2ecWWoJPHjmkrkZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l+Yx/GS4; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260410070248epoutp04060aa59b4a31137c11cc8ed779f19794~k7NixwMt40346003460epoutp041
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 07:02:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260410070248epoutp04060aa59b4a31137c11cc8ed779f19794~k7NixwMt40346003460epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1775804568;
	bh=Ly11Qb8xbXT7ta5nbljznCsqDDGBC9Gx+vpX8sP8kH4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=l+Yx/GS4mMC2KOyLe2mRIlEDvEHBhGbzC2VvjBLB3WF4PtNC+6h7kssmpUifPNRSz
	 bpnVxixXadFQLcxJ7dVRjheol6fd3MSGKlVtT7KgnKmE2gEqPVQ1yyFtM5g9rcQzA4
	 gJo0bchFUTrwft+vjZy/8FtrTDdd4FhuKIGbSwuM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260410070246epcas5p42824d616f378776a04d39990334c5103~k7NhBXniQ0059900599epcas5p4Q;
	Fri, 10 Apr 2026 07:02:46 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fsSRn6nl5z6B9mR; Fri, 10 Apr
	2026 07:02:45 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec~k7Nf5nw3I0059900599epcas5p4M;
	Fri, 10 Apr 2026 07:02:45 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260410070243epsmtip1db18ff3b1c3a232910599fcdb8087852~k7Ndsb-eF3258032580epsmtip14;
	Fri, 10 Apr 2026 07:02:42 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	paulz@synopsys.com, balbi@ti.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, akash.m5@samsung.com, h10.kim@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, muhammed.ali@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>, stable@vger.kernel.org, Pritam
	Manohar Sutar <pritam.sutar@samsung.com>
Subject: [PATCH] usb: dwc3: Fix GUID register programming order
Date: Fri, 10 Apr 2026 12:17:32 +0530
Message-ID: <20260410064735.515-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec
References: <CGME20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec@epcas5p4.samsung.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235576-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:dkim,samsung.com:email,samsung.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvarasu.g@samsung.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4960E3D30DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Linux Version Code is currently written to the GUID register before
dwc3_core_soft_reset() is executed. Since the core soft reset clears the
GUID register back to its default value, the version information is
subsequently lost.

Move the GUID register programming to occur after the core soft reset
has completed to ensure the value persists.

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


