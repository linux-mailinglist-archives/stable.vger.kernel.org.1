Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE120754DDB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 10:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGPIp3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 04:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGPIp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 04:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F910FA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 01:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF26460BDC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 08:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EBCC433C7;
        Sun, 16 Jul 2023 08:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689497127;
        bh=ZySM0/psFZjHW4f5s/pPmJhID5LXOsTLesMb10jZvew=;
        h=Subject:To:Cc:From:Date:From;
        b=ZcVdan7QJiCRkPk6WJbuolu67vy34em2A1HxsME2pcY9qtwDorBpOHf/wTEQAkXIC
         dTs8eI3vojkP5oHxJ5dO/YoNRnhFZPvaWBqoMdboP9Ijv2c6yPKVNJBTMDKGZN8tjv
         ZTqqjcklwtdO16PfKS7kjr1ucWrMk1EBkL5cwJCc=
Subject: FAILED: patch "[PATCH] i2c: qup: Add missing unwind goto in qup_i2c_probe()" failed to apply to 4.19-stable tree
To:     d202180596@hust.edu.cn, andi.shyti@kernel.org, dzm91@hust.edu.cn,
        stable@vger.kernel.org, wsa@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 10:45:24 +0200
Message-ID: <2023071624-swimwear-finisher-6443@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x cd9489623c29aa2f8cc07088168afb6e0d5ef06d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071624-swimwear-finisher-6443@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

cd9489623c29 ("i2c: qup: Add missing unwind goto in qup_i2c_probe()")
e42688ed5cf5 ("i2c: busses: remove duplicate dev_err()")
e0442d762139 ("i2c: busses: convert to devm_platform_ioremap_resource")
90224e6468e1 ("i2c: drivers: Use generic definitions for bus frequencies")
351c8a09b00b ("Merge branch 'i2c/for-5.4' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd9489623c29aa2f8cc07088168afb6e0d5ef06d Mon Sep 17 00:00:00 2001
From: Shuai Jiang <d202180596@hust.edu.cn>
Date: Tue, 18 Apr 2023 21:56:12 +0800
Subject: [PATCH] i2c: qup: Add missing unwind goto in qup_i2c_probe()

Smatch Warns:
	drivers/i2c/busses/i2c-qup.c:1784 qup_i2c_probe()
	warn: missing unwind goto?

The goto label "fail_runtime" and "fail" will disable qup->pclk,
but here qup->pclk failed to obtain, in order to be consistent,
change the direct return to goto label "fail_dma".

Fixes: 9cedf3b2f099 ("i2c: qup: Add bam dma capabilities")
Signed-off-by: Shuai Jiang <d202180596@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Cc: <stable@vger.kernel.org> # v4.6+

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 2e153f2f71b6..78682388e02e 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1752,16 +1752,21 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	if (!clk_freq || clk_freq > I2C_MAX_FAST_MODE_PLUS_FREQ) {
 		dev_err(qup->dev, "clock frequency not supported %d\n",
 			clk_freq);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail_dma;
 	}
 
 	qup->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(qup->base))
-		return PTR_ERR(qup->base);
+	if (IS_ERR(qup->base)) {
+		ret = PTR_ERR(qup->base);
+		goto fail_dma;
+	}
 
 	qup->irq = platform_get_irq(pdev, 0);
-	if (qup->irq < 0)
-		return qup->irq;
+	if (qup->irq < 0) {
+		ret = qup->irq;
+		goto fail_dma;
+	}
 
 	if (has_acpi_companion(qup->dev)) {
 		ret = device_property_read_u32(qup->dev,
@@ -1775,13 +1780,15 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		qup->clk = devm_clk_get(qup->dev, "core");
 		if (IS_ERR(qup->clk)) {
 			dev_err(qup->dev, "Could not get core clock\n");
-			return PTR_ERR(qup->clk);
+			ret = PTR_ERR(qup->clk);
+			goto fail_dma;
 		}
 
 		qup->pclk = devm_clk_get(qup->dev, "iface");
 		if (IS_ERR(qup->pclk)) {
 			dev_err(qup->dev, "Could not get iface clock\n");
-			return PTR_ERR(qup->pclk);
+			ret = PTR_ERR(qup->pclk);
+			goto fail_dma;
 		}
 		qup_i2c_enable_clocks(qup);
 		src_clk_freq = clk_get_rate(qup->clk);

