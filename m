Return-Path: <stable+bounces-71459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5A963B28
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 08:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916BC1F210F4
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 06:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E87515C13B;
	Thu, 29 Aug 2024 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ebrsS3p+"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBAA158DBA
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912332; cv=none; b=A+CTCVAj5QVw3pzQcxtochhWi2/c9j765LTCkEcSsiqmttyn6mUlfr2VbN6C8hIzL+ymVKVdYbA4T7aSwGpOt5SlLICNTXc6UjirrpJtc+p8eRrsNeiJc1Vy6CSQ+XPiCpGX8fT7Tqta4xi845mZDNqmk7iLdd2vx7UNCePwSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912332; c=relaxed/simple;
	bh=ON2KdJqCjfOJ6h/0KCc/uwlLMP9C6/PHlN3zCR1uQbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=ei23td6FXkP6R4lx0hVwS15tpZmqabnOf0j2i0FyGgjUEapoBo+M3ZwXyC//di7ixDgFi2DU1A8tO32ybB+toTXEHMIj2algmHG90VhA8kOWyzK1YEelDjDbCvh6wwBGTKRwm55YiHTqRanYFyX3HvMaUB+FrLineyCO/hJN5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ebrsS3p+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240829061842epoutp03a2ab6ec5f855806eddf9318a06740fcd~wHp44m71t2939729397epoutp03f
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 06:18:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240829061842epoutp03a2ab6ec5f855806eddf9318a06740fcd~wHp44m71t2939729397epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724912322;
	bh=wzxQZoT4E2amf/9RHfF7VilfQ3lQHIJbyWrsBbwl7K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebrsS3p+gn3wXivxoxQlzqKcuZ9z5uMOt2NFZtH8BhGNnI6aWLcIo1uk9p1r9KgfI
	 1bY8avBS2wF8Mahvnjc6qIGq6JD1vs2B9PLWLOi1LK89yrMmZEMfBBGyRTfnZhroUt
	 lSwuSjG7z6jhdlTLvqheuf4sS1Bc9W1OHhi7m2NU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240829061841epcas1p46c8a01a709b940ec49c39116267058ae~wHp4SCFrU0905209052epcas1p4o;
	Thu, 29 Aug 2024 06:18:41 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.241]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WvWLn18Ysz4x9Q6; Thu, 29 Aug
	2024 06:18:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.DA.19509.1C210D66; Thu, 29 Aug 2024 15:18:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240829061840epcas1p4ceeaea9b00a34cae0c2e82652be0d0ee~wHp3eZAvj1419814198epcas1p4a;
	Thu, 29 Aug 2024 06:18:40 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240829061840epsmtrp1299267cdd5240786f5fce0c3e413f8be~wHp3da2ei0803708037epsmtrp11;
	Thu, 29 Aug 2024 06:18:40 +0000 (GMT)
X-AuditID: b6c32a4c-17bc070000004c35-b7-66d012c17f0a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.05.07567.0C210D66; Thu, 29 Aug 2024 15:18:40 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.171]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240829061840epsmtip247e5235c17c6704249fee056562bc10c~wHp3Nc-a42307423074epsmtip2J;
	Thu, 29 Aug 2024 06:18:40 +0000 (GMT)
From: Seunghwan Baek <sh8267.baek@samsung.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org, ritesh.list@gmail.com, quic_asutoshd@quicinc.com,
	adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
	cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] mmc: cqhci: Fix checking of CQHCI_HALT state
Date: Thu, 29 Aug 2024 15:18:22 +0900
Message-Id: <20240829061823.3718-2-sh8267.baek@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240829061823.3718-1-sh8267.baek@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTX/eg0IU0gxOrWCxOPlnDZjHjVBur
	xb5rJ9ktfv1dz27RsXUyk8WO52fYLXb9bWayuLxrDpvFkf/9jBYLO+ayWBw81cFu0fRnH4vF
	tTMnWC0WbHzEaHF8bbjF5kvfWBwEPHbOusvusXjPSyaPO9f2sHlM3FPn0bdlFaPH501yAWxR
	2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
	5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
	TlzZylTwg72i5c5MxgbGE2xdjJwcEgImEgc+LmLqYuTiEBLYwyix5eg3VgjnE6PE4kdboZxv
	jBJfTj9lgWk5sucZI0RiL6PE029LmCGcz4wSS8+1MIFUsQnoSbxqP8wGkhARWMQosffHHbAq
	ZoGfjBLvrx9kB6kSFnCR2Dr/OjOIzSKgKvF22RGwbl4Ba4mZdzezQuyTl1i94QBYDaeAjURD
	azPYVAmBiRwS01oWMkIUuUjMmDyXCcIWlnh1fAs7hC0l8bK/Dcoulli4cRILRHMLo8T15X+g
	mu0lmsGmcgCdpymxfpc+SJhZgE/i3dceVpCwhACvREebEES1qsSpDVuhOqUlrjc3QN3pIXHp
	eQ/YCUIC/YwSF3/nTmCUnYUwdAEj4ypGqdSC4tz01GTDAkPdvNRyeGQl5+duYgSnSC2fHYzf
	1//VO8TIxMF4iFGCg1lJhPfE8bNpQrwpiZVVqUX58UWlOanFhxhNgYE2kVlKNDkfmKTzSuIN
	TSwNTMyMTCyMLY3NlMR5z1wpSxUSSE8sSc1OTS1ILYLpY+LglGpgqnThuq7rP+dmRPORtW+D
	KtyurT914jmXlGKYyfNWBbUliUdaPhoen72pL8qNmf2C1rZfl020j9icKVY16+JLPFWTsVQ7
	SC4jTy1ga1jj5uZiWyXdm3FfJ8U4S5fe/+E9R6r1Xp2768283JaHF1Qa0l1rFiw1q/8Zc+Cf
	aqF6n++H2vzOPdUZlp5iKbsva1+YefGeWd0h2fVMe/nnG3rMm2aS3xCfuKtnSe0p35WNgnM4
	n6+R+iqrmym94qPL2fQ1s6R3n+y5G3Wgc4l4zf7LqVPXl0ye9ey7zNFnYWEHiwTUi3qs8x89
	X3p10ud29xr72CLG3g8X9z55eeWlktH7rK1Z9uc73d+5fy39um63EktxRqKhFnNRcSIAJ3pB
	nRoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvO4BoQtpBtu2KlmcfLKGzWLGqTZW
	i33XTrJb/Pq7nt2iY+tkJosdz8+wW+z628xkcXnXHDaLI//7GS0WdsxlsTh4qoPdounPPhaL
	a2dOsFos2PiI0eL42nCLzZe+sTgIeOycdZfdY/Gel0wed67tYfOYuKfOo2/LKkaPz5vkAtii
	uGxSUnMyy1KL9O0SuDJOXNnKVPCDvaLlzkzGBsYTbF2MnBwSAiYSR/Y8Y+xi5OIQEtjNKLHj
	31EmiIS0xOMDL4ESHEC2sMThw8UQNR8ZJV6susoOUsMmoCfxqv0wG0hCRGAFo8TM5VOZQRxm
	gVYmiXNb28AmCQu4SGydf50ZxGYRUJV4u+wIWJxXwFpi5t3NrBDb5CVWbzgAVsMpYCPR0NoM
	dp4QUM2nFSfZJzDyLWBkWMUomVpQnJuem2xYYJiXWq5XnJhbXJqXrpecn7uJERzYWho7GO/N
	/6d3iJGJg/EQowQHs5II74njZ9OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrOmJ0iJJCeWJKa
	nZpakFoEk2Xi4JRqYIr2/RES9bp81oT5PSnn2Jx1g+7sLP5cVVrJ55f3SHpquJzg27N9gqGf
	dcXEVPSWPYlzWH1YvIFX44qvj6/A110zN2y54Pjp3jfWt4s1uk6UH5WQqG4PV7HjC9APc6pd
	UrCw3Gm1w4zvWRqxluLZMzezhuqt80nMylSYfWbdNo5Npv8fhjydmLTuja1u6MUun9Ckbk8B
	SzHlg/dvHwnTWTAngneiyPbk+CvZTQGzrpqenvfg22elD41qMf/sb7wLMpZpCRYWdM97Zrzr
	BXfW/xNFRSYtfKmOzvXtXQ2iUWeXmiYo2/iIbXBYe6xhhn/p6a0b+O0qMk9dzfbaq3ZwiRJD
	5NElSzZO7tktfGCiEktxRqKhFnNRcSIAmDF9H9sCAAA=
X-CMS-MailID: 20240829061840epcas1p4ceeaea9b00a34cae0c2e82652be0d0ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240829061840epcas1p4ceeaea9b00a34cae0c2e82652be0d0ee
References: <20240829061823.3718-1-sh8267.baek@samsung.com>
	<CGME20240829061840epcas1p4ceeaea9b00a34cae0c2e82652be0d0ee@epcas1p4.samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
bit. At this time, we need to check with &, not &&.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
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


