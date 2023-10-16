Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512297CA2D8
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjJPIzr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjJPIzq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:55:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4C4DE
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:55:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DD0C433C7;
        Mon, 16 Oct 2023 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446543;
        bh=ChXtLErRlVRgVJ8YSAI2dgr7DdVA9YiDGAZ09Iyy6gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VjTz+5RxtrjLZvX6IL/ZfJC9opP1WPrUEVRbRG852xEgQkPB1pXt/jB0MREFeMtqt
         qWurP1yQhBd48jV1rBrM84tU/kQV0uzBhz07g+W0qPkq5fxuGQ9mfogRdgg3WFEFTQ
         RREIE8INBlxOHGNxB7XB6evfU1NAtVSW5eJL5Y0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 048/131] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
Date:   Mon, 16 Oct 2023 10:40:31 +0200
Message-ID: <20231016084001.267991955@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index d0b5129439ed6..c2201e0adc46c 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2740,7 +2740,6 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 	struct device_node *np = spi->dev.of_node;
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 	struct ca8210_platform_data *pdata = spi->dev.platform_data;
-	int ret = 0;
 
 	if (!np)
 		return -EFAULT;
@@ -2757,18 +2756,8 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
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
@@ -2780,8 +2769,8 @@ static void ca8210_unregister_ext_clock(struct spi_device *spi)
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



