Return-Path: <stable+bounces-66033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A29D94BCF2
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2BB28434C
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 12:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A318C922;
	Thu,  8 Aug 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IeD2TShI"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D418C32C
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118856; cv=none; b=CA3MUzu+7zEBpBRpIWA/PBkJJ7LTTfY7xlTMuzOU0y9ebTQpvvvLxYRH3yVsaMVdsPIEsSjcgP0caoNg3O8EEgHEevyjf7AD4/DQyCKlNuKYqTzKT5HkTNWUecvg8jD281wJ0N6OLl+pjlUCfzEzIUlL8Cwtl61ZpbynzcN43Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118856; c=relaxed/simple;
	bh=GPoH9DrEvJJkBRbLypO1BoTrLkYATwtK4lkVCAmHKao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=UC+pY/lwkBd5YllyUmQQaYAbqwzufH4YPH5YLbpnV48XWzRSEENSdiRaydJoxpFAj+IG4K3LTugsd5Ha1kPDqBDMHtdNzF6tOneo73TBC9c4ZfMCihurDz8LI3JM1wEgP5ggWO8TG8xbO9t329zLgR15zOGCEjkxunWYjgzGaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IeD2TShI; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240808120730epoutp020f31a710ae306ec9bf8d67bd79e7e717~pv3b7H-bw2492124921epoutp02k
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 12:07:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240808120730epoutp020f31a710ae306ec9bf8d67bd79e7e717~pv3b7H-bw2492124921epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723118850;
	bh=MtXYPI4mQZd1Tp5Ox2GWQR/JnFmzvS/8G1dBgDJiNRM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IeD2TShI1PdtpwNNzbmPK6yZuEUXMnmEWlmTDZg3G8DtEyRmPhhFfMzI9MwXjXfBN
	 u9ssRIpp9pdFteRKVOj9yv8TujjU7uk98c/k/YsYWLOV2kj4RuBHaQZ9OSVNdrhW+c
	 ZBX93XVPOSsYTtE/Oyxt7bH3h5Ml2jnPo9RUIAYg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240808120729epcas5p2bc47b38e3d698813aae29128a2e23cee~pv3bDj9cY2058320583epcas5p2I;
	Thu,  8 Aug 2024 12:07:29 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wfm4v4vQrz4x9Py; Thu,  8 Aug
	2024 12:07:27 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	27.E4.09743.FF4B4B66; Thu,  8 Aug 2024 21:07:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd~pv2M3n2iV0648506485epcas5p2q;
	Thu,  8 Aug 2024 12:06:05 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240808120605epsmtrp2d0d5372bfa76ca40110967dfd4a74035~pv2MwvB4-1966219662epsmtrp2Y;
	Thu,  8 Aug 2024 12:06:05 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-4b-66b4b4ff3edb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.89.07567.DA4B4B66; Thu,  8 Aug 2024 21:06:05 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240808120602epsmtip18cad4a34d2aa2ad385f9caed9c4185a4~pv2KrfUlE0969009690epsmtip1g;
	Thu,  8 Aug 2024 12:06:02 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
Date: Thu,  8 Aug 2024 17:35:04 +0530
Message-ID: <20240808120507.1464-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmpu7/LVvSDBrvK1q8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TmHxeLI8o9MFpe/72S2
	WLDxEaPFpIOiFqsWHGB34PfYP3cNu0ffllWMHlv2f2b0+LxJLoAlKtsmIzUxJbVIITUvOT8l
	My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hQJYWyxJxSoFBAYnGxkr6dTVF+
	aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xuTtL9kL9vJVzJ+0mK2B
	8TB3FyMHh4SAicTDWf5djJwcQgK7GSU+LODoYuQCsj8xSrw6f5UJwvnGKNHRcY0RpAqkYd/C
	6cwQib2MEuc/n2SBaP/OKNF/pQRkKpuAocSzEzYgYRGBEolLbzcygdjMAguYJFpna4PYwgLR
	Es/ObGMDsVkEVCWamyaB1fAKWEs8+3+MGWKXpsTavXug4oISJ2c+YYGYIy/RvHU22A0SAo0c
	Eh/mTYVqcJG4ufo8lC0s8er4FnYIW0ri87u9bBB2tcTqOx/ZIJpbGCUOP/kGVWQv8fjoI2aQ
	B5iBNq/fpQ8RlpWYemod1AN8Er2/nzBBxHkldsyDsVUlTjVehpovLXFvyTVWSOh6SOxb7A5i
	CgnESrxd4zeBUX4Wkm9mIflmFsLeBYzMqxglUwuKc9NTi00LjPJSy+GRmpyfu4kRnFa1vHYw
	PnzwQe8QIxMH4yFGCQ5mJRHe5vBNaUK8KYmVValF+fFFpTmpxYcYTYFBPJFZSjQ5H5jY80ri
	DU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYLLbcnin8LUVDy94/rfM
	cf3mkxAjv2jqWsvmPcmF24LC4/2sW6Zlhm/MusnwWy959x+pdvuj4jeSApSsBA503zy0Ii4u
	PcHh/o8bjo1BeqzhH/e9uMP67dnipeukZ0VKRvysS1T1OXB63zv/dVJcjb/7+j7YSe9dJR25
	831KmeqTsJ0/D+RzOGkzvM09z/E5gGX/IakTwUb2i1dfEqt7dUnrPcuTO13v9AqV1txZ+sni
	IF/fpOfflRwDzt1/0qW8ZOeip3zBW/1btjoKcZtyyyVJ/Ds3zXDW3P+3b0yUVVHbtKb90sfy
	K1vEM01k1RMOlhsm8cobWd9YK+CVY/PH+E2KUJDygdDDx777fvE/ba7EUpyRaKjFXFScCABG
	a4bbNAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnO7aLVvSDH42slm8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TmHxeLI8o9MFpe/72S2
	WLDxEaPFpIOiFqsWHGB34PfYP3cNu0ffllWMHlv2f2b0+LxJLoAlissmJTUnsyy1SN8ugStj
	8vaX7AV7+SrmT1rM1sB4mLuLkZNDQsBEYt/C6cxdjFwcQgK7GSX2f5zGCJGQlng9qwvKFpZY
	+e85O0TRV0aJmQu3AjkcHGwChhLPTtiA1IgIVEg8XjiDBaSGWWAdk8Ts40+YQRLCApES93/f
	YAKxWQRUJZqbJoHZvALWEs/+H2OGWKApsXbvHqi4oMTJmU9YQGxmAXmJ5q2zmScw8s1CkpqF
	JLWAkWkVo2RqQXFuem6yYYFhXmq5XnFibnFpXrpecn7uJkZwqGtp7GC8N/+f3iFGJg7GQ4wS
	HMxKIrzN4ZvShHhTEiurUovy44tKc1KLDzFKc7AoifMazpidIiSQnliSmp2aWpBaBJNl4uCU
	amAKvNfy6flj7mO9wtpsJZf8Y2N8ly+WNmiJXiazXVZy7Tfv19FvMxf4Jm5XdMvfJxb0zD77
	9YOEnTN1+6/LLev8Gvt41jkvGb/Fzf6LrktqZt/fsNfgn3Pi9vUzDe2s5LrilLKuLXDOnbzy
	s2nDbEf9H/6fTA/Muma4voP39wHf37+UbZiuuTAuCIhXz5HcVbTlwanN8eZWl+YaLjobVlD+
	U/DJlJK6M3ENtowZBVN4I03sEt0V3HkulDBaNAvdO7en/MKkqosyok8jzvnv9isUq0oyflE5
	vfjTMQ2NqlyBgqhHE3kay1X5k8JazH7mXhazE2OomfL/bPCjrF19tnZHq2wyLr7r5G/kf/rl
	nBJLcUaioRZzUXEiAMqZOcrkAgAA
X-CMS-MailID: 20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd
References: <CGME20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd@epcas5p2.samsung.com>

This commit addresses an issue where the USB core could access an
invalid event buffer address during runtime suspend, potentially causing
SMMU faults and other memory issues. The problem arises from the
following sequence.
        1. In dwc3_gadget_suspend, there is a chance of a timeout when
        moving the USB core to the halt state after clearing the
        run/stop bit by software.
        2. In dwc3_core_exit, the event buffer is cleared regardless of
        the USB core's status, which may lead to an SMMU faults and
        other memory issues. if the USB core tries to access the event
        buffer address.

To prevent this issue, this commit ensures that the event buffer address
is not cleared by software  when the USB core is active during runtime
suspend by checking its status before clearing the buffer address.

Cc: stable@vger.kernel.org
Fixes: 89d7f9629946 ("usb: dwc3: core: Skip setting event buffers for host only controllers")
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---

Changes in v2:
- Added separate check for USB controller status before cleaning the
  event buffer.
- Link to v1: https://lore.kernel.org/lkml/20240722145617.537-1-selvarasu.g@samsung.com/
---
 drivers/usb/dwc3/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 734de2a8bd21..5b67d9bca71b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -564,10 +564,15 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
 	if (!dwc->ev_buf)
 		return;
 
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	if (!(reg & DWC3_DSTS_DEVCTRLHLT))
+		return;
+
 	evt = dwc->ev_buf;
 
 	evt->lpos = 0;
-- 
2.17.1


