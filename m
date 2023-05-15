Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC87039B9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbjEORpa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244621AbjEORpE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F86A61
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F9A62E49
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BFAC433D2;
        Mon, 15 May 2023 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172568;
        bh=fe7sGE9lyb+RnOuNKcxZYY1n64TPwilUqX94op1b630=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BbqAWb57Jo8cVNF10+CYJ8aPq56wcFv9EZN183p740ur1TA7Vldgo9WnC74eNROh9
         ouBtMzYwsqqz4gom2TYWhQBEiR7jMEEO8UeEsJ8vXHPflqWIiwXB0Lw7NG8oevZgSe
         F5wIukBVP+3p9M6rZMKXG2S2/BVa4/0NR25Ppj1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 167/381] net: ethernet: stmmac: dwmac-rk: fix optional phy regulator handling
Date:   Mon, 15 May 2023 18:26:58 +0200
Message-Id: <20230515161744.352537972@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit db21973263f8c56750cb610f1d5e8bee00a513b9 ]

The usual devm_regulator_get() call already handles "optional"
regulators by returning a valid dummy and printing a warning
that the dummy regulator should be described properly. This
code open coded the same behaviour, but masked any errors that
are not -EPROBE_DEFER and is quite noisy.

This change effectively unmasks and propagates regulators errors
not involving -ENODEV, downgrades the error print to warning level
if no regulator is specified and captures the probe defer message
for /sys/kernel/debug/devices_deferred.

Fixes: 2e12f536635f ("net: stmmac: dwmac-rk: Use standard devicetree property for phy regulator")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index e7fbc9b30bf96..d0d47d91b460c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1194,9 +1194,6 @@ static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 	int ret;
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (!ldo)
-		return 0;
-
 	if (enable) {
 		ret = regulator_enable(ldo);
 		if (ret)
@@ -1227,14 +1224,11 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 	of_get_phy_mode(dev->of_node, &bsp_priv->phy_iface);
 	bsp_priv->ops = ops;
 
-	bsp_priv->regulator = devm_regulator_get_optional(dev, "phy");
+	bsp_priv->regulator = devm_regulator_get(dev, "phy");
 	if (IS_ERR(bsp_priv->regulator)) {
-		if (PTR_ERR(bsp_priv->regulator) == -EPROBE_DEFER) {
-			dev_err(dev, "phy regulator is not available yet, deferred probing\n");
-			return ERR_PTR(-EPROBE_DEFER);
-		}
-		dev_err(dev, "no regulator found\n");
-		bsp_priv->regulator = NULL;
+		ret = PTR_ERR(bsp_priv->regulator);
+		dev_err_probe(dev, ret, "failed to get phy regulator\n");
+		return ERR_PTR(ret);
 	}
 
 	ret = of_property_read_string(dev->of_node, "clock_in_out", &strings);
-- 
2.39.2



