Return-Path: <stable+bounces-98974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228BA9E6B5A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD831884AC1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715391F7592;
	Fri,  6 Dec 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q3nTbRHe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBFE1F6662
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479874; cv=none; b=B485kTx1NZDV8TMSZX5wRCNQqyDOLRFBb72+ccYUnncroxB5LgwZS0GNfdmONf+A9aftaBNcTiFIUSg7YGcGZVEQnwlhYvOekXI3CH2TvsIJ1/bIz+FEcOapEsMY0yXPFk5QsqWmvOORmcsSmQDZKKMuY9hxK+mCzPKHZmAA7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479874; c=relaxed/simple;
	bh=FZCmwt0sizEdDCIK4t6TLc/rKUpsKyZraL60wr2oAG8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W2h46y3JiLML0n+UtgL13MghfFY4xc0aAq1rGcYRtaUeYwfiicXdExrBQnDjdLSo5UfQ/Or0onCiiwT2QXmcVbGKtnPiNLV66C+85D+/2IYgVsB+jeMAg/wj0S6REcU/nNGdYD1xexINk2fW0u8g8CTVPsDgp3FjQ5BzdH7L3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q3nTbRHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE60C4CEDD;
	Fri,  6 Dec 2024 10:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733479873;
	bh=FZCmwt0sizEdDCIK4t6TLc/rKUpsKyZraL60wr2oAG8=;
	h=Subject:To:Cc:From:Date:From;
	b=q3nTbRHe8Dj2Mias1BqOSopMLqJy0U+ekZ6+9RC1a2+29fNdKntHJJtOT03tI/EDa
	 i519gnwPWrqhMwDRvggucADrynwJtqbQf8uTrFhTyAGgNRj4DMHUBv6FRLPKcpmgQC
	 YOr0HCPq9G6raDi5QraI8fegxOAJAngxRfLqlkvI=
Subject: FAILED: patch "[PATCH] mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting" failed to apply to 6.6-stable tree
To: andy-ld.lu@mediatek.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:11:02 +0100
Message-ID: <2024120602-neon-retold-51bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2508925fb346661bad9f50b497d7ac7d0b6085d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120602-neon-retold-51bb@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


