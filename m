Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33327555BD
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjGPUoI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjGPUoH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E319D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0E7260E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD980C433C8;
        Sun, 16 Jul 2023 20:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540246;
        bh=M5zZZn2QzNVkJrQXkh4w92BjVIEEf+XuJjwqHCpR7+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/t/TPgvqpMb8/HCk+/FfPCWV/g1TESRPxRiqD1eHHEuRpRtsRl4m2DOlRGY0yYS4
         Z3iGWHFuoa8q0v7NLHRRplRG9RefD6NXPTITxJj0Vmg3F7PLb63gnrsr5hleRhf0Be
         vEPAe0XZSTZFS6C+WDgwsTm8XMxGUx4aIoPxD+ss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Junyan Ye <yejunyan@hust.edu.cn>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 295/591] PCI: ftpci100: Release the clock resources
Date:   Sun, 16 Jul 2023 21:47:14 +0200
Message-ID: <20230716194931.527364959@linuxfoundation.org>
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

From: Junyan Ye <yejunyan@hust.edu.cn>

[ Upstream commit c60738de85f40b0b9f5cb23c21f9246e5a47908c ]

Smatch reported:
1. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe() warn:
'clk' from clk_prepare_enable() not released on lines: 442,451,462,478,512,517.
2. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe() warn:
'p->bus_clk' from clk_prepare_enable() not released on lines: 451,462,478,512,517.

The clock resource is obtained by devm_clk_get(), and then
clk_prepare_enable() makes the clock resource ready for use. After that,
clk_disable_unprepare() should be called to release the clock resource
when it is no longer needed. However, while doing some error handling
in faraday_pci_probe(), clk_disable_unprepare() is not called to release
clk and p->bus_clk before returning. These return lines are exactly 442,
451, 462, 478, 512, 517.

Fix this warning by replacing devm_clk_get() with devm_clk_get_enabled(),
which is equivalent to devm_clk_get() + clk_prepare_enable(). And with
devm_clk_get_enabled(), the clock will automatically be disabled,
unprepared and freed when the device is unbound from the bus.

Link: https://lore.kernel.org/r/20230508043641.23807-1-yejunyan@hust.edu.cn
Fixes: b3c433efb8a3 ("PCI: faraday: Fix wrong pointer passed to PTR_ERR()")
Fixes: 2eeb02b28579 ("PCI: faraday: Add clock handling")
Fixes: 783a862563f7 ("PCI: faraday: Use pci_parse_request_of_pci_ranges()")
Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
Fixes: f1e8bd21e39e ("PCI: faraday: Convert IRQ masking to raw PCI config accessors")
Signed-off-by: Junyan Ye <yejunyan@hust.edu.cn>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-ftpci100.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 0cfd9d5a497c9..f7e61e169d838 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -429,22 +429,12 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	p->dev = dev;
 
 	/* Retrieve and enable optional clocks */
-	clk = devm_clk_get(dev, "PCLK");
+	clk = devm_clk_get_enabled(dev, "PCLK");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "could not prepare PCLK\n");
-		return ret;
-	}
-	p->bus_clk = devm_clk_get(dev, "PCICLK");
+	p->bus_clk = devm_clk_get_enabled(dev, "PCICLK");
 	if (IS_ERR(p->bus_clk))
 		return PTR_ERR(p->bus_clk);
-	ret = clk_prepare_enable(p->bus_clk);
-	if (ret) {
-		dev_err(dev, "could not prepare PCICLK\n");
-		return ret;
-	}
 
 	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
-- 
2.39.2



