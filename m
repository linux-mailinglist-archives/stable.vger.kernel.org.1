Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6F7352A9
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjFSKhM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjFSKgr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3DAB3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD79B60B7C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF34CC433C0;
        Mon, 19 Jun 2023 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171005;
        bh=anUzBBOIbz2JiiQICOs/IDtjG3ajeIQEzgc4rbDdpKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwpwV3rIEIpOEYyU7EeOgJz4tyx6ULGTsH0aEWNPTQfiswGmU73r666Q0RZbJF3vC
         /4xA2C1zZ6p+m6mud712DNGX7mKo7Hi8KjVgMmBb7ppYF0M3qHJe9L4k/xGYiZQwMb
         Wt3capo0CudY/55xQBuH/9yHnWDqDmm24zs4xPlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 113/187] spi: cadence-quadspi: Add missing check for dma_set_mask
Date:   Mon, 19 Jun 2023 12:28:51 +0200
Message-ID: <20230619102203.040039640@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 947c70a213769f60e9d5aca2bc88b50a1cfaf5a6 ]

Add check for dma_set_mask() and return the error if it fails.

Fixes: 1a6f854f7daa ("spi: cadence-quadspi: Add Xilinx Versal external DMA support")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Link: https://lore.kernel.org/r/20230606093859.27818-1-jiasheng@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8f36e1306e169..3fb85607fa4fa 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1736,8 +1736,11 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->slow_sram = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
-					    "xlnx,versal-ospi-1.0"))
-			dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+					    "xlnx,versal-ospi-1.0")) {
+			ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+			if (ret)
+				goto probe_reset_failed;
+		}
 	}
 
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
-- 
2.39.2



