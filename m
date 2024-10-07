Return-Path: <stable+bounces-81237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3095E99281B
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7596B23022
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AB818E059;
	Mon,  7 Oct 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G5BhgDQZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A41741E0
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293380; cv=none; b=Kel3W1c+c6ZR6rszSAsxOPzKShIKxiHpvpTO8NFbIzGtP0WqEn2VrqqY0pDzQB3Jum2E4/ipnGKg+7J6JktD0UdgMmlfL2UE57cvTICmw0n3d7e+OV4aGOp5obq4OzWL653Ldaz4myf8FOC1DGjYQvH03VpuWxjkFCTprmBbrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293380; c=relaxed/simple;
	bh=xWwn8nkv6sOmRVMI7+RohgpuJB6juzCTf26xVHRqKnI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ooNg22s5xj7h1n5wbX5B0jX3y4hZask/xPMRURPr4zQAz61c9BPrxDISUyUDjlQ3AqUDZvnbJmUXPZnjeIo/iNWI512ShSSJGG1SFUNsxDLIA0v5pILpvh2m7jvwlTUYjbPpyzHe/fn74wYDQ2XEkDSS3yw1/AFEdkwghSMKGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G5BhgDQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D734C4CEC6;
	Mon,  7 Oct 2024 09:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728293379;
	bh=xWwn8nkv6sOmRVMI7+RohgpuJB6juzCTf26xVHRqKnI=;
	h=Subject:To:Cc:From:Date:From;
	b=G5BhgDQZ5WNHXOT2dJWoW08L4K+2RhXCRAmVbiaayZtliGp15OJq0s0P9li3cxl9h
	 l2s2ETBu7USwUEZtvmetUblmMOOHYHv8PfDMKaJrZLow9CyymILo1KcpGBPAbLa1Be
	 OpqujUqwJ5a1X98rS4ssaWLlFGFYTGJJRqRNzvmA=
Subject: FAILED: patch "[PATCH] spi: bcm63xx: Fix missing pm_runtime_disable()" failed to apply to 5.15-stable tree
To: ruanjinjie@huawei.com,broonie@kernel.org,jonas.gorski@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 11:29:28 +0200
Message-ID: <2024100728-ebony-lemon-83b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 265697288ec2160ca84707565d6641d46f69b0ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100728-ebony-lemon-83b7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

265697288ec2 ("spi: bcm63xx: Fix missing pm_runtime_disable()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 265697288ec2160ca84707565d6641d46f69b0ff Mon Sep 17 00:00:00 2001
From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Mon, 19 Aug 2024 20:33:49 +0800
Subject: [PATCH] spi: bcm63xx: Fix missing pm_runtime_disable()

The pm_runtime_disable() is missing in the remove function, fix it
by using devm_pm_runtime_enable(), so the pm_runtime_disable() in
the probe error path can also be removed.

Fixes: 2d13f2ff6073 ("spi: bcm63xx-spi: fix pm_runtime")
Cc: stable@vger.kernel.org # v5.13+
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://patch.msgid.link/20240819123349.4020472-3-ruanjinjie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 289f8a94980b..2fb79701a525 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -583,13 +583,15 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		goto out_clk_disable;
 
 	/* register and we are done */
 	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
 		dev_err(dev, "spi register failed\n");
-		goto out_pm_disable;
+		goto out_clk_disable;
 	}
 
 	dev_info(dev, "at %pr (irq %d, FIFOs size %d)\n",
@@ -597,8 +599,6 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_pm_disable:
-	pm_runtime_disable(&pdev->dev);
 out_clk_disable:
 	clk_disable_unprepare(clk);
 out_err:


