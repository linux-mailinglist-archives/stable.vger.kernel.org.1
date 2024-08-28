Return-Path: <stable+bounces-71367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B999961D96
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 06:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B215A1F24009
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 04:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71851420D8;
	Wed, 28 Aug 2024 04:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ekStRBF/"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4E7433AD
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 04:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819220; cv=none; b=iBUZFV+zUU1IXcSa8ue5y16Jk+byMGduJ5pqcWJyUS0fcQYCJfyg9kEGOx3D4PBzNmxkwIgrKWOeltKNTqnndHLPWnpAIc0U5Oj/GIcdUSYifcRg2JurkWj4OFX2mhMfzICRxIH6RulZYJiHld+SuNphcBe4zmmrPl5oIx9yHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819220; c=relaxed/simple;
	bh=4yNbuHfPFx9yC5Kq8l/0Rbb3a50finI0l3Ew6S2evlk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=OcBZD74Zp9ayEzS0L12ojyyRt4rfdmQDrzWeTNT9FkG02mH1I/vSKBupEYyDTC1nmmml9awlgAAhHZAgUFww/xcV/rOuZKIOHqCvV3+kTJiWH14U0pzMqEWOcZDn9xbELumeFTNY+KA60HmoRC3CBu/5iYPTHe8fJksk6mbbnPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ekStRBF/; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240828042655epoutp03b67025f320f066bad586d569079ac84c~vyfAQTIfG2967129671epoutp03a
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 04:26:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240828042655epoutp03b67025f320f066bad586d569079ac84c~vyfAQTIfG2967129671epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724819215;
	bh=GxDHy9aOJCuxndcthX9NL1gbw91QpYlLzFOGWMj6i7Y=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ekStRBF/TFGcCoLLwUINUwtFycjB9Vl1P110w0wD6hN/kjFtHpQ1kWLC9d5nbYTUv
	 uwanRp0zZC5bcAu7wLttXJAYTVSq5I2N4JcJF1vSqk/XBKgUasahGtXpRMtf3wfKqz
	 qzRJoZXcZwJ7hJO43wBWaXSQpXbjB2t8Rx9Lam54=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240828042654epcas1p43a24230643f26461007795add564c9bb~vye-hpVo60720607206epcas1p4V;
	Wed, 28 Aug 2024 04:26:54 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.226]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WtrwF6mDPz4x9Q7; Wed, 28 Aug
	2024 04:26:53 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.5F.08992.D07AEC66; Wed, 28 Aug 2024 13:26:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240828042653epcas1p1952b6cee9484b53d86727dd0e041a0b5~vye_s5bX43151631516epcas1p1x;
	Wed, 28 Aug 2024 04:26:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240828042653epsmtrp1143289d2cfb4e95c35b346e6fff7436f~vye_sFaOE3230832308epsmtrp18;
	Wed, 28 Aug 2024 04:26:53 +0000 (GMT)
X-AuditID: b6c32a33-faa0ca8000002320-9a-66cea70dfc2b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AD.60.19367.D07AEC66; Wed, 28 Aug 2024 13:26:53 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.171]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240828042653epsmtip1b9d482a9282de689e40f58c0d7bf3a21~vye_eRIu90300603006epsmtip1b;
	Wed, 28 Aug 2024 04:26:53 +0000 (GMT)
From: Seunghwan Baek <sh8267.baek@samsung.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org, ritesh.list@gmail.com, quic_asutoshd@quicinc.com,
	adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
	cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com,
	stable@vger.kernel.org
Subject: [PATCH] mmc : fix for check cqe halt.
Date: Wed, 28 Aug 2024 13:26:47 +0900
Message-Id: <20240828042647.18983-1-sh8267.baek@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmri7v8nNpBjPbTSxOPlnDZjHjVBur
	xb5rJ9ktfv1dz27RsXUyk8WO52fYLXb9bWayuLxrDpvFkf/9jBYLO+ayWBw81cFu0fRnH4vF
	tTMnWC0WbHzEaHF8bbjF5kvfWBwEPHbOusvusXjPSyaPO9f2sHlM3FPn0bdlFaPH501yAWxR
	2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
	5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
	/i/uZS74wF4x/cRD5gbGQ2xdjBwcEgImEs+eGXcxcnEICexglDh76hQrhPOJUeLF84sIzpv/
	s9i7GDnBOhbtvc4OkdjJKPH/0Q0mCOczo8TvWXOZQKrYBPQkXrUfZgNJiAgsYpTY++MOM4jD
	LPCTUeL99YNgs4SBqvYdaGABsVkEVCWutd9gBbF5BWwkLk55A7VPXmL1hgNgzRICX9klPnRv
	YYZIuEhcXLaLFcIWlnh1fAtUg5TEy/42KLtYYuHGSSwQzS2MEteX/2GESNhLNLc2g8OAWUBT
	Yv0ufZAwswCfxLuvPayQoOGV6GgTgqhWlTi1YStUp7TE9eYGqLUeEn8vnwWLCwnESsyZvphp
	AqPMLIShCxgZVzGKpRYU56anJhsWGMLjJjk/dxMjOAFqGe9gvDz/n94hRiYOxkOMEhzMSiK8
	J46fTRPiTUmsrEotyo8vKs1JLT7EaAoMpInMUqLJ+cAUnFcSb2hiaWBiZmRiYWxpbKYkznvm
	SlmqkEB6YklqdmpqQWoRTB8TB6dUAxPzp+z1MY92vv+gnbnspeqPrqCJC7J7nlzu+OI7d42u
	a4FB2DuHWZ6mNlrzsxr/CnU//rX44rtT2okTPBd8jjsst+khy9stzz3F7Xqb0kI9gqbV5b7f
	vHrm447py3rLd0TmNraFqy+x8HF++l+dV9fui1RPwKua/1L/RJm2y59ndG580rTqIH/dKqVc
	H9eVXs757zbE7hJ0vBS3b+aHRq89nwu2b0/d5vvgs4Jnk8djr/SSeXkvZeoLAxVzt19IVvru
	aRqf/Cbup/ztx+uucB4QuLGi8NLban6enp1LTqQy3Il4l9F3OvDjRYfgaT8d6j8z2Z3gTrnW
	ELzLbc8/wR1vU4ve/zHhN99U9Wvb/wwlluKMREMt5qLiRADu2PMECQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnC7v8nNpBlNny1icfLKGzWLGqTZW
	i33XTrJb/Pq7nt2iY+tkJosdz8+wW+z628xkcXnXHDaLI//7GS0WdsxlsTh4qoPdounPPhaL
	a2dOsFos2PiI0eL42nCLzZe+sTgIeOycdZfdY/Gel0wed67tYfOYuKfOo2/LKkaPz5vkAtii
	uGxSUnMyy1KL9O0SuDL+L+5lLvjAXjH9xEPmBsZDbF2MnBwSAiYSi/ZeZ+9i5OIQEtjOKPFn
	4W5miIS0xOMDLxm7GDmAbGGJw4eLIWo+MkqcXL2WFaSGTUBP4lX7YTaQhIjACkaJmcunMoM4
	zAKtTBLntrYxgVQJA1XtO9DAAmKzCKhKXGu/AdbNK2AjcXHKG3aIbfISqzccYJ7AyLOAkWEV
	o2hqQXFuem5ygaFecWJucWleul5yfu4mRnCAagXtYFy2/q/eIUYmDsZDjBIczEoivCeOn00T
	4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRqYIpr9V7jvPp0
	57K4Cy/W1y4Kq321ZvlZyfWcf2Pm9mvW73QR7op5WvhvnuHEC2JWN2Z4droXsV0/xxZ65FBD
	r7/dKs/yxJLds5XmuKRGHpwj2mF/2JElvEukfr8Fq0D9Ss+iBSs61K9lNOUJcp7RZe+bXPbn
	dcKz5i1J97btmpf5Mqu1Qn5HuvVZjZnVLiJ/H3PsP1wh1VQQcl43Sn3HfO8uzWNe9sJbnh2U
	fXfN61WhzBWlyRe+vZyy26/Fz+Eo8xHBeFsHrYrFkia5bVPcj4ZsyVV48iDFfu2d3skKOtEr
	507fwSqe3mydfOCCqLLkupbleg8qz129sTsyKmX2RDONXunIRXnG2v27PblMlFiKMxINtZiL
	ihMBnWYr4L8CAAA=
X-CMS-MailID: 20240828042653epcas1p1952b6cee9484b53d86727dd0e041a0b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240828042653epcas1p1952b6cee9484b53d86727dd0e041a0b5
References: <CGME20240828042653epcas1p1952b6cee9484b53d86727dd0e041a0b5@epcas1p1.samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
bit. At this time, we need to check with &, not &&.

Fixes: 0653300224a6 ("mmc: cqhci: rename cqhci.c to cqhci-core.c")
Cc: stable@vger.kernel.org
Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
---
 drivers/mmc/host/cqhci-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index c14d7251d0bb..a02da26a1efd 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
+		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
-- 
2.17.1


