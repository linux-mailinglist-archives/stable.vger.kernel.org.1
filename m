Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E5C7ECBA3
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjKOTXd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjKOTXd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62119F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C92CC433C7;
        Wed, 15 Nov 2023 19:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076209;
        bh=s//4TBp6ChHVFfiGA9YLY3zC3Yv/yzB7oY+tSKreP5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKg1Bg/fCDPnnu7viMzbxsN36bH+OiC6ZVeCxKytzC2J2h1iaC9OmHlpAuKpjRh4t
         O9ZT5NDX2scmuwa8isb6BSp+Ctlqgdv4ZChqxFNKr16M4YF4F1ELwgSXYD97b91K/O
         3xXgjJDi4MYAZjxpk1WBB8/bi3Ut+y/cG1KoYJqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 110/550] PM / devfreq: rockchip-dfi: Make pmu regmap mandatory
Date:   Wed, 15 Nov 2023 14:11:34 -0500
Message-ID: <20231115191608.324414472@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit 1e0731c05c985deb68a97fa44c1adcd3305dda90 ]

As a matter of fact the regmap_pmu already is mandatory because
it is used unconditionally in the driver. Bail out gracefully in
probe() rather than crashing later.

Link: https://lore.kernel.org/lkml/20230704093242.583575-2-s.hauer@pengutronix.de/
Fixes: b9d1262bca0af ("PM / devfreq: event: support rockchip dfi controller")
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/event/rockchip-dfi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 39ac069cabc75..74893c06aa087 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -193,14 +193,15 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(data->clk),
 				     "Cannot get the clk pclk_ddr_mon\n");
 
-	/* try to find the optional reference to the pmu syscon */
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
-	if (node) {
-		data->regmap_pmu = syscon_node_to_regmap(node);
-		of_node_put(node);
-		if (IS_ERR(data->regmap_pmu))
-			return PTR_ERR(data->regmap_pmu);
-	}
+	if (!node)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Can't find pmu_grf registers\n");
+
+	data->regmap_pmu = syscon_node_to_regmap(node);
+	of_node_put(node);
+	if (IS_ERR(data->regmap_pmu))
+		return PTR_ERR(data->regmap_pmu);
+
 	data->dev = dev;
 
 	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
-- 
2.42.0



