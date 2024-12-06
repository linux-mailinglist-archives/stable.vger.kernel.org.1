Return-Path: <stable+bounces-98892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294739E6296
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B911884DAE
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D80B12F5B1;
	Fri,  6 Dec 2024 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="b+yW8+sX"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CD80054
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446413; cv=none; b=ZBZj7dU40boRtob8pWimvDlFg4Yx55TTXZHBoyhgt6cpuYIwTiCT+Lga758QJ6+SsbLCs7ET50e382Z+SrG5cway9VCNoNZfmQcKZjj8x68l4p2UFb89WBpXUU5sde8sBG/vzXjfjkqcmHdh01beWK9/GUIBhSlgD2yiJL5U//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446413; c=relaxed/simple;
	bh=FaRMEIV+exE3InCIiV8aqHdt9GbcDCRX0xauLBCBB1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0Dd+nmcRe4obnXvJ7WQSg65I9mA6bXFxEgDr6Y6fe2EdPMcG8Z3sXhUn4utzWbmU5x+KYHHonsqqBXOEav0HAzlLEBZkORw+zkZn6DHqKaqeg4mcBfFZezeDksR+Jiu6k3uqTMtRln2uKt4U+Gpk3zvycVuOY2SzqHxvi4zixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=b+yW8+sX; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446412;
	bh=SO+YgkHSdNXANbZ5T5jcpT8WEiFa/mZr6j+65qv6KYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=b+yW8+sXHX+kntqg1oF8Ua+6ejCxKtpfcYTUin21jsKCANSUKkBL51EBFuOOGTMgs
	 nH2CYsvfkrp9o1HMVNKoFNtEG8C3qSPkMT9t5PtYekjXy7hth33T/9iu0TD8PaZgVJ
	 F3vhQtA3JP+4/u8U6IA55PClX+LjdYrzJ0lnrDJN2hTPKH3ZbMyMbXOsX74DEp4KDY
	 VC/lz1m6eyYP5wRmN2irCA3GRgND6lOo/YqEkepN9DgKK1BPAq2RYXJoWcBQ05dNrG
	 GRHq8HT26NWc7yekv0f3qToW8Ttvhs/YsYFLz3MnicW7stOX6u2mElPbR1grOE/y4J
	 UxC1KeDWzz5xQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 57FDCA028F;
	Fri,  6 Dec 2024 00:53:24 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 06 Dec 2024 08:52:30 +0800
Subject: [PATCH 04/10] of: Fix refcount leakage for OF node returned by
 __of_get_dma_parent()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-of_core_fix-v1-4-dc28ed56bec3@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Leif Lindholm <leif.lindholm@linaro.org>, 
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: oPvYCtz1VfHG2AZPba9aShtEj8EUGgiZ
X-Proofpoint-ORIG-GUID: oPvYCtz1VfHG2AZPba9aShtEj8EUGgiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=855
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

__of_get_dma_parent() returns OF device node @args.np, but the node's
refcount is increased twice, by both of_parse_phandle_with_args() and
of_node_get(), so causes refcount leakage for the node.

Fix by directly returning the node got by of_parse_phandle_with_args().

Fixes: f83a6e5dea6c ("of: address: Add support for the parent DMA bus")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/address.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index c5b925ac469f16b8ae4b8275b60210a2d583ff83..cda1cbb82eabdcd39d32446023fbb105b69bc99d 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -619,7 +619,7 @@ struct device_node *__of_get_dma_parent(const struct device_node *np)
 	if (ret < 0)
 		return of_get_parent(np);
 
-	return of_node_get(args.np);
+	return args.np;
 }
 #endif
 

-- 
2.34.1


