Return-Path: <stable+bounces-105543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA189FA47D
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789961651D9
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 07:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE32156960;
	Sun, 22 Dec 2024 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fMaU5nWA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA82156243
	for <stable@vger.kernel.org>; Sun, 22 Dec 2024 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734851930; cv=none; b=bVFMEMRLjVVicKo8H9h1GHs8xLUlnf82b1IYe2P9T3+geRl91QtToczJawoZCSYy2VJIcl5p7feq4yjsTCmDDRR6nEaJzlWLDN0KsJhdS9mzo2l0mGe02tQ8GabLW+mq2xM9XpjwSOeAHVlla425svfEgMzdcaETTQrJXfyxAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734851930; c=relaxed/simple;
	bh=69XJpEZ4Fum/+oylUTIMa80iKYzI2JLG1gPJhF+M49s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Co7aa+ueg31I7fhB+YNinrMZ2wuv9DSubpUpXIJAIuImDrHmTE2+ko7LmlE2gkWOhz7FCN1OppglrRmzkYGpDTveclcflkC1k4Mc5uRH0/jabAnS88cD+1yVecjizBFDVZCszHpRCJxjQAO85CjgLXD9qJhO8PIoyaI9mn9ujtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fMaU5nWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC18C4CECD;
	Sun, 22 Dec 2024 07:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734851930;
	bh=69XJpEZ4Fum/+oylUTIMa80iKYzI2JLG1gPJhF+M49s=;
	h=Subject:To:Cc:From:Date:From;
	b=fMaU5nWAWRy/wf8lk+WCODGPKOyBWuScqRbDtT1rEpXSqsuSWmyg9U1K2ayb8ALfM
	 yfW31t7rj6QT4gM6LKSyS+YqgGmfRYpAdb0S5UrOSMX8vTeX+hO7BjWpij1nKuu0X1
	 o74CGUhz2x7LiSftl76pdp0eqRuW4FFovZ46Bo50=
Subject: FAILED: patch "[PATCH] mmc: mtk-sd: disable wakeup in .remove() and in the error" failed to apply to 6.1-stable tree
To: joe@pf.is.s.u-tokyo.ac.jp,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 22 Dec 2024 08:18:46 +0100
Message-ID: <2024122246-resend-agonize-69e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f3d87abe11ed04d1b23a474a212f0e5deeb50892
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122246-resend-agonize-69e0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f3d87abe11ed04d1b23a474a212f0e5deeb50892 Mon Sep 17 00:00:00 2001
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Date: Tue, 3 Dec 2024 11:34:42 +0900
Subject: [PATCH] mmc: mtk-sd: disable wakeup in .remove() and in the error
 path of .probe()

Current implementation leaves pdev->dev as a wakeup source. Add a
device_init_wakeup(&pdev->dev, false) call in the .remove() function and
in the error path of the .probe() function.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Fixes: 527f36f5efa4 ("mmc: mediatek: add support for SDIO eint wakup IRQ")
Cc: stable@vger.kernel.org
Message-ID: <20241203023442.2434018-1-joe@pf.is.s.u-tokyo.ac.jp>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index efb0d2d5716b..af445d3f8e2a 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -3070,6 +3070,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	msdc_gate_clock(host);
 	platform_set_drvdata(pdev, NULL);
 release_mem:
+	device_init_wakeup(&pdev->dev, false);
 	if (host->dma.gpd)
 		dma_free_coherent(&pdev->dev,
 			2 * sizeof(struct mt_gpdma_desc),
@@ -3103,6 +3104,7 @@ static void msdc_drv_remove(struct platform_device *pdev)
 			host->dma.gpd, host->dma.gpd_addr);
 	dma_free_coherent(&pdev->dev, MAX_BD_NUM * sizeof(struct mt_bdma_desc),
 			  host->dma.bd, host->dma.bd_addr);
+	device_init_wakeup(&pdev->dev, false);
 }
 
 static void msdc_save_reg(struct msdc_host *host)


