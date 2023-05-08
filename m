Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B26FA82D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjEHKi3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjEHKiG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A776428A98
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E8E461D4B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22539C4339B;
        Mon,  8 May 2023 10:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542279;
        bh=fOWDpCswFzW+wd0Dj2tTRTDC9MubYwgUwVi4PUVrEPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzANQSI47uqRogARiVcSrD6oCbsJ0A6JYuv7yc0woTffDTEXaoe3837v+aOgYkwYE
         uoiAnQz01fpow7Orj/gYlZ5gWEzqqgo+AWXgsb9EbNc6/0g86FOOzL6Qi/YOtcqyWM
         Ha9fsMZZ/suHHhHADos56N3YdFRIkJKG4aa5ypzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 352/663] net: ethernet: stmmac: dwmac-rk: fix optional phy regulator handling
Date:   Mon,  8 May 2023 11:42:58 +0200
Message-Id: <20230508094439.568166509@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 21954b3d825c6..cf682a9e3fff2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1586,9 +1586,6 @@ static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 	int ret;
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (!ldo)
-		return 0;
-
 	if (enable) {
 		ret = regulator_enable(ldo);
 		if (ret)
@@ -1636,14 +1633,11 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 		}
 	}
 
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



