Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2594676146E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjGYLTS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjGYLTR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:19:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47E99
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1CE8615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E76C433C8;
        Tue, 25 Jul 2023 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283955;
        bh=pi8BDwKLTZ3/033Mp6Q38iWdyQ4/QOwsfVWhJwKlrWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhMcwI4w1H1Op2rMIURaFP+1wv2t7zQ4wkz3j6RQfzWexFXvEpST0Cqg5L1Jiavu1
         P8csvxd0dBTBxtIPBNXHDSjT6h1GrlXUzsPNUXxSwx4ckWENRTInhQzFD4Q2Ab9WrY
         d9GySTMjeQw6k3w0YnteDa6cPcS7oBfNh3MdszaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Junyan Ye <yejunyan@hust.edu.cn>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 181/509] PCI: ftpci100: Release the clock resources
Date:   Tue, 25 Jul 2023 12:42:00 +0200
Message-ID: <20230725104601.990447557@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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
index aefef1986201a..80cfea5d9f122 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -442,22 +442,12 @@ static int faraday_pci_probe(struct platform_device *pdev)
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



