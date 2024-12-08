Return-Path: <stable+bounces-100059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9069E8435
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 09:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54D718849BB
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559E342AA1;
	Sun,  8 Dec 2024 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eNLLheG7"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E099EEB2
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733646756; cv=none; b=YlkS88DZkhOeJptNw58juOjEqDLwj4lTj2kKAWn6TNL4BuSca24d3HwAB0DhfgzQK4MCA4hy/4sbWXeHhUaehH0LlkX4vHSHmDhRpRSmQfnqPCvgFiJG/MIYF+kEzXvpf/Oe0thQKGxVFBTx8zkWMsaUoU4ZrtWGPGQ6GGm4sJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733646756; c=relaxed/simple;
	bh=kTUUO97zyKUTWqjnPoA8QQ1mpsqxso5e5jXLTYCuADI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcAWVTKe3tAeuqp/GvodrKHEdbLXcKSCj/Sfq3PbTGOKWrTnFctSQ74hcin+032XDIBuMiMgjLQSnGhhKvVtAulGaOwrIWhdMMBivToKHIVo+jZd2RrmYHLWEQDrn58e3+D4U3zZJHpTK/iny9DiqbNlAsVA+ml3E74tSlTQJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eNLLheG7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f6301daeb53e11ef99858b75a2457dd9-20241208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uw+tFoFu0LWU0tU93xwzdYSeQxaRUDJ7+8qf9ewiCdQ=;
	b=eNLLheG7D1AxaAveibwut9MnlprDyxSIaAahgzJ+MxQWmJAtBNFzN854ioNJtlksFWupcnuLnPfgEiOEjIccUda7HoO98Hhn3Hb1zn2BSyFxRAAUZgQlA13XLmhNfRP9lrmfWrtCEkBTKZzUOnzj+UUIjAjXgSTUm4sVNo78F8s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5a8b824c-f670-4277-92f1-695ad6668c79,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:a96086a4-c699-437d-b877-50282f19c2c6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f6301daeb53e11ef99858b75a2457dd9-20241208
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 684048131; Sun, 08 Dec 2024 16:32:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 8 Dec 2024 16:32:24 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 8 Dec 2024 16:32:24 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <stable@vger.kernel.org>
CC: Andy-ld Lu <andy-ld.lu@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.12.y] mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
Date: Sun, 8 Dec 2024 16:31:45 +0800
Message-ID: <20241208083221.21514-1-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024120601-faculty-facelift-caf7@gregkh>
References: <2024120601-faculty-facelift-caf7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.468300-8.000000
X-TMASE-MatchedRID: 0sQiHSPfQFAm4SY1UdFN+XQEQEU5OIefoA9Le8XJpbpMOjKUxCZwr7iN
	d7CXjOinsC7QIHAmtIR/zjwurOOmjPZyTDo2IZ6U2PArUpVkoPxCX8V1FiRRkt9RlPzeVuQQkmi
	3zE7HIvlX6UIPOG+iLR2NwlAFp+i1HxPMjOKY7A8LbigRnpKlKZx+7GyJjhAUllG0Q8OaxMMhO0
	h5snjNQ0WmnY5NsOWhA/kgKW4lrtywvUW7QqN4yX4DkOCxlyss3CL9Aemx0rnng+PccmkOxZZDO
	vRoxQje8jae4OD13tAV7Mc+rowcVKtX/F0pBwVJjSV5hDFby7aUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.468300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E7D83E68B9BF1A4C2DFCB1B491BBA689CB87BD2190BF6B6C72601EEC83FDE73D2000:8

Currently, the MMC_CAP2_CRYPTO flag is set by default for eMMC hosts.
However, this flag should not be set for hosts that do not support inline
encryption.

The 'crypto' clock, as described in the documentation, is used for data
encryption and decryption. Therefore, only hosts that are configured with
this 'crypto' clock should have the MMC_CAP2_CRYPTO flag set.

Fixes: 7b438d0377fb ("mmc: mtk-sd: add Inline Crypto Engine clock control")
Fixes: ed299eda8fbb ("mmc: mtk-sd: fix devm_clk_get_optional usage")
Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: stable@vger.kernel.org
Message-ID: <20241111085039.26527-1-andy-ld.lu@mediatek.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 2508925fb346661bad9f50b497d7ac7d0b6085d0)
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 89018b6c97b9..cb593e379ab0 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2778,7 +2778,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		host->crypto_clk = devm_clk_get_optional(&pdev->dev, "crypto");
 		if (IS_ERR(host->crypto_clk))
 			host->crypto_clk = NULL;
-		else
+		else if (host->crypto_clk)
 			mmc->caps2 |= MMC_CAP2_CRYPTO;
 	}
 
-- 
2.46.0


