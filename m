Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9E47D3373
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjJWLa0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjJWLaZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:30:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6552C1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:30:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8B6C433C8;
        Mon, 23 Oct 2023 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060623;
        bh=r3awI7cMI+YsGSVGbkp/IsZOO3Yyn72ZTCKE1+UEkW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBKdZ8cU1mi6BJFvHQj+xu2KUua0u21M/MzZhEC77gToOmczVuwn/BrxHylNx2AYe
         GBDzkVj6Gr+zW2feP5z4uoyRfsjrK3q407ru60/zpBf3B+yIaYG2l5HXIwYZ1NfUo9
         FYFxLA9kzo5Bh2/THmTPhRV5MsrFAc797/oDheIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 011/123] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
Date:   Mon, 23 Oct 2023 12:56:09 +0200
Message-ID: <20231023104818.118153707@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit f990874b1c98fe8e57ee9385669f501822979258 ]

If of_clk_add_provider() fails in ca8210_register_ext_clock(),
it calls clk_unregister() to release priv->clk and returns an
error. However, the caller ca8210_probe() then calls ca8210_remove(),
where priv->clk is freed again in ca8210_unregister_ext_clock(). In
this case, a use-after-free may happen in the second time we call
clk_unregister().

Fix this by removing the first clk_unregister(). Also, priv->clk could
be an error code on failure of clk_register_fixed_rate(). Use
IS_ERR_OR_NULL to catch this case in ca8210_unregister_ext_clock().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Message-ID: <20231007033049.22353-1-dinghao.liu@zju.edu.cn>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/ca8210.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index fb57e561d3e61..fdbdc22fe4e5c 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2782,7 +2782,6 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 	struct device_node *np = spi->dev.of_node;
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 	struct ca8210_platform_data *pdata = spi->dev.platform_data;
-	int ret = 0;
 
 	if (!np)
 		return -EFAULT;
@@ -2799,18 +2798,8 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 		dev_crit(&spi->dev, "Failed to register external clk\n");
 		return PTR_ERR(priv->clk);
 	}
-	ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
-	if (ret) {
-		clk_unregister(priv->clk);
-		dev_crit(
-			&spi->dev,
-			"Failed to register external clock as clock provider\n"
-		);
-	} else {
-		dev_info(&spi->dev, "External clock set as clock provider\n");
-	}
 
-	return ret;
+	return of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
 }
 
 /**
@@ -2822,8 +2811,8 @@ static void ca8210_unregister_ext_clock(struct spi_device *spi)
 {
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 
-	if (!priv->clk)
-		return
+	if (IS_ERR_OR_NULL(priv->clk))
+		return;
 
 	of_clk_del_provider(spi->dev.of_node);
 	clk_unregister(priv->clk);
-- 
2.40.1



