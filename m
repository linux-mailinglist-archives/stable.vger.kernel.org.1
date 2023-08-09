Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A877593F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjHIK6w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjHIK6w (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:58:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1632106
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E5FB62DC8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432F9C433C7;
        Wed,  9 Aug 2023 10:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578730;
        bh=pgjFsfYEuytySKKJNCu/JFmZeJEODP2OP4MBeb4/C58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/lWFzl0u946UgnpGaOHjr0UIwFFbLGtuD26rjVMDi4kjVNCUMt/8HR2vVm8X268Z
         g4zZUX6rr79IKNEOFoYFiAV8R5lCySkjGRr59a3wdj+W6ld6sceInFRZ9RDvZ3VUra
         6FMw3qWyOzVGkt6l4m6NOWk+h5Jwa2oYj1BzEFHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 37/92] net: ll_temac: Switch to use dev_err_probe() helper
Date:   Wed,  9 Aug 2023 12:41:13 +0200
Message-ID: <20230809103634.904124590@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 2ab29efa6b6e4..303de9293fc71 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1556,16 +1556,12 @@ static int temac_probe(struct platform_device *pdev)
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



