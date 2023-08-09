Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7E7758C6
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjHIKzW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjHIKzK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0222B2115
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B91563128
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0BCC433C8;
        Wed,  9 Aug 2023 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578416;
        bh=xjZZ/8jvHpQOh/+80GPkKFhmpOqURT+iRep7SjkPJ0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CN5Yc48pAiHmapDNs2YQIF2KVAvmbwtLbmq4TkZ1+WSHId9ESb2IrQTAyt3jQozNc
         iEWmpP6ZNLVmNUcA21H0Vj0NdIECFb60DRQtLcvPSGkZIyAiHHilAfa2NzO+0898Sx
         RIAXLF4qzQmRTU/b3R7xLAqbcPD9+e3Ikk9qyQ10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Esben Haabendal <esben@geanix.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 052/127] net: ll_temac: fix error checking of irq_of_parse_and_map()
Date:   Wed,  9 Aug 2023 12:40:39 +0200
Message-ID: <20230809103638.404426104@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit ef45e8400f5bb66b03cc949f76c80e2a118447de ]

Most kernel functions return negative error codes but some irq functions
return zero on error.  In this code irq_of_parse_and_map(), returns zero
and platform_get_irq() returns negative error codes.  We need to handle
both cases appropriately.

Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Esben Haabendal <esben@geanix.com>
Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Harini Katakam <harini.katakam@amd.com>
Link: https://lore.kernel.org/r/3d0aef75-06e0-45a5-a2a6-2cc4738d4143@moroto.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 1066420d6a83a..6bf5e341c3c11 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1568,12 +1568,16 @@ static int temac_probe(struct platform_device *pdev)
 	}
 
 	/* Error handle returned DMA RX and TX interrupts */
-	if (lp->rx_irq < 0)
-		return dev_err_probe(&pdev->dev, lp->rx_irq,
+	if (lp->rx_irq <= 0) {
+		rc = lp->rx_irq ?: -EINVAL;
+		return dev_err_probe(&pdev->dev, rc,
 				     "could not get DMA RX irq\n");
-	if (lp->tx_irq < 0)
-		return dev_err_probe(&pdev->dev, lp->tx_irq,
+	}
+	if (lp->tx_irq <= 0) {
+		rc = lp->tx_irq ?: -EINVAL;
+		return dev_err_probe(&pdev->dev, rc,
 				     "could not get DMA TX irq\n");
+	}
 
 	if (temac_np) {
 		/* Retrieve the MAC address */
-- 
2.40.1



