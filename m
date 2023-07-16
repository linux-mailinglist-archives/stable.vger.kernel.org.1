Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DEF7556FE
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjGPU4I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjGPU4I (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:56:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F40EE9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1F8260EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDFFC433C8;
        Sun, 16 Jul 2023 20:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540966;
        bh=o3GiozvMaLRwUcURm6vN3RZNKEP/QS8IXHFwUDfGDTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixWm0asd2aDfNVIIlt57Owo0QjMMz8lqHJci6bJaLs5xPmxwJDxlni4s58FCxwylW
         ZehODvDdQWHDI06hmE65UBInpkul96URh5Q/np6X7In0fm0cNK6gd1DwjX+66VnjxY
         1TyLwkeMGZyV11AI1EX0lgly4H0x+TjD1VpuQKXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shuai Jiang <d202180596@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 6.1 524/591] i2c: qup: Add missing unwind goto in qup_i2c_probe()
Date:   Sun, 16 Jul 2023 21:51:03 +0200
Message-ID: <20230716194937.429178799@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shuai Jiang <d202180596@hust.edu.cn>

commit cd9489623c29aa2f8cc07088168afb6e0d5ef06d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-qup.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1752,16 +1752,21 @@ nodma:
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
@@ -1775,13 +1780,15 @@ nodma:
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


