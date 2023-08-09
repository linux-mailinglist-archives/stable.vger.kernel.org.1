Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35B3775DB8
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjHILkk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjHILkj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33447173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE44C63640
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97C2C433C8;
        Wed,  9 Aug 2023 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581238;
        bh=B1WOSczFHeH2f30aoTe5LYVk44V9qyRZXq/YNlwjKfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xd86mJeZ6A1SzpIlgOCTKIAWfCuhbyX/iwnBnjHeQKJiWaJ/toKOECKVlbrdBhxK7
         A2sZsd6n5Y4rbjOFFwEEmEpdKx/WYlIik+9hUVa+3XaHaLjoU3PAsmUrcDta1E2kA0
         IE8qEyfhD2iA89t7J3pwPrAWJsKYe6Kibrjon+/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 147/201] net: ll_temac: Switch to use dev_err_probe() helper
Date:   Wed,  9 Aug 2023 12:42:29 +0200
Message-ID: <20230809103648.635674604@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 75ae8c284c00dc3584b7c173f6fcf96ee15bd02c ]

dev_err() can be replace with dev_err_probe() which will check if error
code is -EPROBE_DEFER.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: ef45e8400f5b ("net: ll_temac: fix error checking of irq_of_parse_and_map()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 130f4b707bdc4..2f27e93370c6c 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1550,16 +1550,12 @@ static int temac_probe(struct platform_device *pdev)
 	}
 
 	/* Error handle returned DMA RX and TX interrupts */
-	if (lp->rx_irq < 0) {
-		if (lp->rx_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "could not get DMA RX irq\n");
-		return lp->rx_irq;
-	}
-	if (lp->tx_irq < 0) {
-		if (lp->tx_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "could not get DMA TX irq\n");
-		return lp->tx_irq;
-	}
+	if (lp->rx_irq < 0)
+		return dev_err_probe(&pdev->dev, lp->rx_irq,
+				     "could not get DMA RX irq\n");
+	if (lp->tx_irq < 0)
+		return dev_err_probe(&pdev->dev, lp->tx_irq,
+				     "could not get DMA TX irq\n");
 
 	if (temac_np) {
 		/* Retrieve the MAC address */
-- 
2.40.1



