Return-Path: <stable+bounces-100065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0759E8460
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 10:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE29316539D
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5EF74C14;
	Sun,  8 Dec 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gCQSgBGX"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A642A93
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733648643; cv=none; b=LXy7mOiq8TzdIs+pWmMEjh2Iybe4bMGpuUswc1T/8lh8Kozy4d/6Y7GIOfxF0IHPedzoa1sRpP5ALnY3AKNVtjiGfXlDig/bG97KbK1Bg/Qcnu9He4jLn5Yiovjzi4IqTOfRoO9ezOwsJKZ2ug+SJlKSBHIN7uj58d/6pzKz64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733648643; c=relaxed/simple;
	bh=Vz6Y/t2yoNn6jTJzeR3bODl34tEbCM5gfxP1AEh7d+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZXNQ2hGxwALGsm1lOw3icBr8NjE4UJLP2uBnZqwnZNMtJUGKIkZZcHOgCae4BTaznjRWuBIxHG7av5vUdXVq7D7fYSaWV3XNnESFJ9LupZORW4uzEMadjP3MyJ2lwMeXmaBBGlSB/PCusoa60mJBntJr3X3cNNg9/QMSfJQVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gCQSgBGX; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 574aac72b54311efbd192953cf12861f-20241208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jRmhD78hjC4+izE2IO4tJu/muHliQNkPH5t9kX4cVIU=;
	b=gCQSgBGXKoLQGWddHjhq1EH6h5AcAI3Q+EYI9D6EwxdgIgSoNw2UWyYb3K1btXSakVRZiG9lQOXg+d3BJhh+VcO5UnTYp6nC1YpNaNmq5UbHQKUflyCCyt7EVAbuteJoj49SpRFsCASOY2Bk5xsaYOGLuiVNisWm9xqgh9nu3/8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:4740ba12-3dd6-4030-9d44-f2d96d9c05ce,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:6ffe5f04-b3ca-4202-ba41-09fe265db19f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 574aac72b54311efbd192953cf12861f-20241208
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1969621337; Sun, 08 Dec 2024 17:03:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 8 Dec 2024 17:03:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 8 Dec 2024 17:03:48 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <stable@vger.kernel.org>
CC: Andy-ld Lu <andy-ld.lu@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6.y] mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
Date: Sun, 8 Dec 2024 17:03:28 +0800
Message-ID: <20241208090347.22418-1-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024120602-neon-retold-51bb@gregkh>
References: <2024120602-neon-retold-51bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Currently, the MMC_CAP2_CRYPTO flag is set by default for eMMC hosts.
However, this flag should not be set for hosts that do not support inline
encryption.

The 'crypto' clock, as described in the documentation, is used for data
encryption and decryption. Therefore, only hosts that are configured with
this 'crypto' clock should have the MMC_CAP2_CRYPTO flag set.

Fixes: 7b438d0377fb ("mmc: mtk-sd: add Inline Crypto Engine clock control")
Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: stable@vger.kernel.org
Message-ID: <20241111085039.26527-1-andy-ld.lu@mediatek.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 2508925fb346661bad9f50b497d7ac7d0b6085d0)
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 8b755f162732..9526aa1b4fa9 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2716,7 +2716,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		host->crypto_clk = devm_clk_get_optional(&pdev->dev, "crypto");
 		if (IS_ERR(host->crypto_clk))
 			host->crypto_clk = NULL;
-		else
+		else if (host->crypto_clk)
 			mmc->caps2 |= MMC_CAP2_CRYPTO;
 	}
 
-- 
2.46.0


