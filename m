Return-Path: <stable+bounces-98973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF039E6B58
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD12280CDC
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43A21EE016;
	Fri,  6 Dec 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9zhi12N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D491AD9F9
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479865; cv=none; b=IaIZbH2GJteSnJtjyT7YH685ef4u+hAbojktsT4Z81fLtQsQRv/fUPUMZVDf3WqbO2RBgXJnpQs5sqi5W4kmzGk4CDDf2IvF2W1l+AwP4BbwXefNNOdgTT7dpSrZG/+fJOmpuQpHHsf2a/tf4mhyJZt4YUzkrc7RUEZNbGftr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479865; c=relaxed/simple;
	bh=v0KpIcRh6o6t8BA3dz8kQ7CNKpFRBaG8UFJ+ByDZoAk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IwpKUMnDAYDetBOvRwNhk/iz3YyozLYGK9+hBdZ8d7s5chmLEeuzNOsDjr/uIKu/eIXLDEuplAQISdYD056r8WJFkk8wFq2wCOBiLIoUdq1+Dt/FhIT2e6v5suPsXlzVMmac5IiQsEBmFx4l8kSredx5CT5XeJyJgsr/GgCGmRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L9zhi12N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79759C4CEDD;
	Fri,  6 Dec 2024 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733479864;
	bh=v0KpIcRh6o6t8BA3dz8kQ7CNKpFRBaG8UFJ+ByDZoAk=;
	h=Subject:To:Cc:From:Date:From;
	b=L9zhi12NQ1QNHiSjF6H50rcBJ5FEPJiDwcLV3vMs+TlgOIUVyZzTGWoLCiCcpjcJh
	 P+OHjKe+w3ibCKL97sptFYJ09iOPsQAq2ZRfdKAQ2GujH7nwpkoWeHQG8PSL/eD3XM
	 1dzrKwocyzotWXU+bsaK+L1ZeQ6qSnE04rEDCReA=
Subject: FAILED: patch "[PATCH] mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting" failed to apply to 6.12-stable tree
To: andy-ld.lu@mediatek.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:11:01 +0100
Message-ID: <2024120601-faculty-facelift-caf7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2508925fb346661bad9f50b497d7ac7d0b6085d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120601-faculty-facelift-caf7@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2508925fb346661bad9f50b497d7ac7d0b6085d0 Mon Sep 17 00:00:00 2001
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
Date: Mon, 11 Nov 2024 16:49:31 +0800
Subject: [PATCH] mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting

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

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 022526a1f754..efb0d2d5716b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2907,7 +2907,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		host->crypto_clk = devm_clk_get_optional(&pdev->dev, "crypto");
 		if (IS_ERR(host->crypto_clk))
 			return PTR_ERR(host->crypto_clk);
-		mmc->caps2 |= MMC_CAP2_CRYPTO;
+		else if (host->crypto_clk)
+			mmc->caps2 |= MMC_CAP2_CRYPTO;
 	}
 
 	host->irq = platform_get_irq(pdev, 0);


