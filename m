Return-Path: <stable+bounces-100058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BCF9E8406
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 07:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B52716378E
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 06:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF7470827;
	Sun,  8 Dec 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JfALoYBU"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52628371
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639663; cv=none; b=B1urYLl7/9ZBp9OdPBQSAiWrOwLwm5oDgZA7tsjZtwlYM3MdClm0Dak1NxyJpcqpb6N4DNOn2034q7Ma3qPjAhObtaNtU9iwyS44EGU1eAYODYIudLRHvIhxpnfF8WWYRXdqh02CizJ4/TF15/m8nabGkZLtWPMQCeHEH/cHA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639663; c=relaxed/simple;
	bh=KYdkAMkTisbThaWMSIg+t8YGrBorlLFijPZSS2zHEw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hex9I/Kt+PM3dBIlpTXOogx6ppBlgDqrsU7snQEBgvlZHxj0MUs+uFiuoYZAIq0SeB5NrfeUwzp4n9v3AxbXSAbM9D+SnZyIzWP7npvtud048bB/CKFlxImSqfpPjTY48gCrz1nEEUQUKVYSZt/OjZ+mRxNLTVLhHJy9NkHlwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JfALoYBU; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6fa66d20b52e11ef99858b75a2457dd9-20241208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6p8Q7wp9pNPZ8yq+piwjsd6C9I80sdt01HyRrp5A49s=;
	b=JfALoYBUxWbQF7T1yVy35F6VW3Adj8nOpm2bKjYZ58ikmTRixhXmwdmSGHqppAw88MImPg8tSUdNQQe9wx8uO55AAociCjtBg/oG5C4r4EIgBj2MTsPkTMa8fAMWOBESiNtS8Mh9TMfyeTK0qWLV0WL/bJcybpqtry6if/Hw/N4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:efbce4fb-24dc-4cb0-be9b-8abd25906f12,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:968f9b3b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6fa66d20b52e11ef99858b75a2457dd9-20241208
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1324102677; Sun, 08 Dec 2024 14:34:11 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 8 Dec 2024 14:34:10 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 8 Dec 2024 14:34:10 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <stable@vger.kernel.org>
CC: Andy-ld Lu <andy-ld.lu@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
Subject: [PATCH 6.12.y] mmc: mtk-sd: Fix error handle of probe function
Date: Sun, 8 Dec 2024 14:31:55 +0800
Message-ID: <20241208063407.19633-1-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024120624-qualified-region-9a31@gregkh>
References: <2024120624-qualified-region-9a31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In the probe function, it goes to 'release_mem' label and returns after
some procedure failure. But if the clocks (partial or all) have been
enabled previously, they would not be disabled in msdc_runtime_suspend,
since runtime PM is not yet enabled for this case.

That cause mmc related clocks always on during system suspend and block
suspend flow. Below log is from a SDCard issue of MT8196 chromebook, it
returns -ETIMEOUT while polling clock stable in the msdc_ungate_clock()
and probe failed, but the enabled clocks could not be disabled anyway.

[  129.059253] clk_chk_dev_pm_suspend()
[  129.350119] suspend warning: msdcpll is on
[  129.354494] [ck_msdc30_1_sel : enabled, 1, 1, 191999939,   ck_msdcpll_d2]
[  129.362787] [ck_msdcpll_d2   : enabled, 1, 1, 191999939,         msdcpll]
[  129.371041] [ck_msdc30_1_ck  : enabled, 1, 1, 191999939, ck_msdc30_1_sel]
[  129.379295] [msdcpll         : enabled, 1, 1, 383999878,          clk26m]

Add a new 'release_clk' label and reorder the error handle functions to
make sure the clocks be disabled after probe failure.

Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling")
Fixes: 7a2fa8eed936 ("mmc: mtk-sd: use devm_mmc_alloc_host")
Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: stable@vger.kernel.org
Message-ID: <20241107121215.5201-1-andy-ld.lu@mediatek.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 291220451c775a054cedc4fab4578a1419eb6256)
---
 drivers/mmc/host/mtk-sd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 89018b6c97b9..9409b6346aaa 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2885,7 +2885,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	ret = msdc_ungate_clock(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot ungate clocks!\n");
-		goto release_mem;
+		goto release_clk;
 	}
 	msdc_init_hw(host);
 
@@ -2895,14 +2895,14 @@ static int msdc_drv_probe(struct platform_device *pdev)
 					     GFP_KERNEL);
 		if (!host->cq_host) {
 			ret = -ENOMEM;
-			goto host_free;
+			goto release;
 		}
 		host->cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
 		host->cq_host->mmio = host->base + 0x800;
 		host->cq_host->ops = &msdc_cmdq_ops;
 		ret = cqhci_init(host->cq_host, mmc, true);
 		if (ret)
-			goto host_free;
+			goto release;
 		mmc->max_segs = 128;
 		/* cqhci 16bit length */
 		/* 0 size, means 65536 so we don't have to -1 here */
@@ -2929,9 +2929,10 @@ static int msdc_drv_probe(struct platform_device *pdev)
 end:
 	pm_runtime_disable(host->dev);
 release:
-	platform_set_drvdata(pdev, NULL);
 	msdc_deinit_hw(host);
+release_clk:
 	msdc_gate_clock(host);
+	platform_set_drvdata(pdev, NULL);
 release_mem:
 	if (host->dma.gpd)
 		dma_free_coherent(&pdev->dev,
-- 
2.46.0


