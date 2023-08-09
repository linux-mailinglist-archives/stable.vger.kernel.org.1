Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE922775783
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjHIKq4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjHIKqy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA191BF0
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23EDF63124
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC9DC433C8;
        Wed,  9 Aug 2023 10:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578012;
        bh=yheo+al2dAj+T1836xwY/C5kA47mT5hsM5VZ8UwTxis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XX7r2A6FqvDklsCpI128Sx2P24rClt19cMeVnAtHrbr3ftlkl8jPpdlOwt4k5IeQ5
         CAVDs2W3Y84eH0uBurSzjbS5mQrPXtM84lfn800wGo4WabISmf5dl35e7JBlOpAWht
         s1CK3/h6Nv3g2T+bOzKhCXPQeplb/FJ2ka6UHgp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Esben Haabendal <esben@geanix.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 075/165] net: ll_temac: fix error checking of irq_of_parse_and_map()
Date:   Wed,  9 Aug 2023 12:40:06 +0200
Message-ID: <20230809103645.254797791@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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
index e0ac1bcd9925c..49f303353ecb0 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1567,12 +1567,16 @@ static int temac_probe(struct platform_device *pdev)
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



