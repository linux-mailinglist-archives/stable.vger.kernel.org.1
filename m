Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED659761670
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjGYLjX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjGYLjQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2971FE6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410A9616B0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AC3C433C8;
        Tue, 25 Jul 2023 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285141;
        bh=8xS0j5gb6eH42LLrPx79pWc+wwLMO+bNlp+6XHqL2O8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7DiOZ53fRDQ3URWmWD4zzOT/0z5AHqtUdbS07RgYOM8kYHfPI0gGeXC9Gqgav6EN
         tFU2AxqgnJWY1Lx5cdP8TsU6FwP5rZWAcYl+hkcCykXlmiMi7V1Npr/K8gBagyFXmX
         HaDMJ0mw/UD0/1t59rhqm6MRDWapnz38z2m/6Sys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Junyan Ye <yejunyan@hust.edu.cn>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 099/313] PCI: ftpci100: Release the clock resources
Date:   Tue, 25 Jul 2023 12:44:12 +0200
Message-ID: <20230725104525.247766772@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index bf5ece5d9291f..88983fd0c1bdd 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -458,22 +458,12 @@ static int faraday_pci_probe(struct platform_device *pdev)
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
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	p->base = devm_ioremap_resource(dev, regs);
-- 
2.39.2



