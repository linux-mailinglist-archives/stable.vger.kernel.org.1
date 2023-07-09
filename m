Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA7F74C2ED
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjGIL0Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjGIL0W (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDF9E58
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1EB160B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12B2C433C7;
        Sun,  9 Jul 2023 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901973;
        bh=pVM7GPptxHFQxGTx/Wgytsm2f/3PDluteTRb/IrAYEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohTwkWS2lT11HObSdi5zdxfzy2s8fKDzFqmpUXLooWvY0CwDjHsAsNS71snO64Qhs
         LU+VFGs+jIsWEXDmZWhrpbJDbWhf3IBi6ApnxnB/xqroSRdeNzY+f7IzZRd7uyz54U
         LqDs8L2WXwSp21crpiDvJDmQ0HPOcpUEJUtf2vos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 183/431] clk: rs9: Support device specific dif bit calculation
Date:   Sun,  9 Jul 2023 13:12:11 +0200
Message-ID: <20230709111455.469722012@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 603df193ec5174ff81c32cf1a78b7819ce984b8c ]

The calculation DIFx is BIT(n) +1 is only true for 9FGV0241. With
additional devices this is getting more complicated.
Support a base bit for the DIF calculation, currently only devices
with consecutive bits are supported, e.g. the 6-channel device needs
additional logic.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Link: https://lore.kernel.org/r/20230310075535.3476580-3-alexander.stein@ew.tq-group.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: ad527ca87e4e ("clk: rs9: Fix .driver_data content in i2c_device_id")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-renesas-pcie.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index f4e9f70f412af..0710362b2545b 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -18,7 +18,6 @@
 #include <linux/regmap.h>
 
 #define RS9_REG_OE				0x0
-#define RS9_REG_OE_DIF_OE(n)			BIT((n) + 1)
 #define RS9_REG_SS				0x1
 #define RS9_REG_SS_AMP_0V6			0x0
 #define RS9_REG_SS_AMP_0V7			0x1
@@ -31,9 +30,6 @@
 #define RS9_REG_SS_SSC_MASK			(3 << 3)
 #define RS9_REG_SS_SSC_LOCK			BIT(5)
 #define RS9_REG_SR				0x2
-#define RS9_REG_SR_2V0_DIF(n)			0
-#define RS9_REG_SR_3V0_DIF(n)			BIT((n) + 1)
-#define RS9_REG_SR_DIF_MASK(n)		BIT((n) + 1)
 #define RS9_REG_REF				0x3
 #define RS9_REG_REF_OE				BIT(4)
 #define RS9_REG_REF_OD				BIT(5)
@@ -160,17 +156,27 @@ static const struct regmap_config rs9_regmap_config = {
 	.reg_read = rs9_regmap_i2c_read,
 };
 
+static u8 rs9_calc_dif(const struct rs9_driver_data *rs9, int idx)
+{
+	enum rs9_model model = rs9->chip_info->model;
+
+	if (model == RENESAS_9FGV0241)
+		return BIT(idx) + 1;
+
+	return 0;
+}
+
 static int rs9_get_output_config(struct rs9_driver_data *rs9, int idx)
 {
 	struct i2c_client *client = rs9->client;
+	u8 dif = rs9_calc_dif(rs9, idx);
 	unsigned char name[5] = "DIF0";
 	struct device_node *np;
 	int ret;
 	u32 sr;
 
 	/* Set defaults */
-	rs9->clk_dif_sr &= ~RS9_REG_SR_DIF_MASK(idx);
-	rs9->clk_dif_sr |= RS9_REG_SR_3V0_DIF(idx);
+	rs9->clk_dif_sr |= dif;
 
 	snprintf(name, 5, "DIF%d", idx);
 	np = of_get_child_by_name(client->dev.of_node, name);
@@ -182,11 +188,9 @@ static int rs9_get_output_config(struct rs9_driver_data *rs9, int idx)
 	of_node_put(np);
 	if (!ret) {
 		if (sr == 2000000) {		/* 2V/ns */
-			rs9->clk_dif_sr &= ~RS9_REG_SR_DIF_MASK(idx);
-			rs9->clk_dif_sr |= RS9_REG_SR_2V0_DIF(idx);
+			rs9->clk_dif_sr &= ~dif;
 		} else if (sr == 3000000) {	/* 3V/ns (default) */
-			rs9->clk_dif_sr &= ~RS9_REG_SR_DIF_MASK(idx);
-			rs9->clk_dif_sr |= RS9_REG_SR_3V0_DIF(idx);
+			rs9->clk_dif_sr |= dif;
 		} else
 			ret = dev_err_probe(&client->dev, -EINVAL,
 					    "Invalid renesas,slew-rate value\n");
@@ -257,11 +261,13 @@ static void rs9_update_config(struct rs9_driver_data *rs9)
 	}
 
 	for (i = 0; i < rs9->chip_info->num_clks; i++) {
-		if (rs9->clk_dif_sr & RS9_REG_SR_3V0_DIF(i))
+		u8 dif = rs9_calc_dif(rs9, i);
+
+		if (rs9->clk_dif_sr & dif)
 			continue;
 
-		regmap_update_bits(rs9->regmap, RS9_REG_SR, RS9_REG_SR_3V0_DIF(i),
-				   rs9->clk_dif_sr & RS9_REG_SR_3V0_DIF(i));
+		regmap_update_bits(rs9->regmap, RS9_REG_SR, dif,
+				   rs9->clk_dif_sr & dif);
 	}
 }
 
-- 
2.39.2



