Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84974C2EF
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjGIL0a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjGIL03 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:26:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B890
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85CC160C0F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9683FC433C8;
        Sun,  9 Jul 2023 11:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901979;
        bh=vronaeFrYtiLz/m9kXnMq07YP/0yhr3afYTjpxAZqOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTE7oO6n0xOoJceVofObivS50CWjlHvRu0e0X0Lc9UNX9C+v8yauShAP8xUcycQXz
         QA90uq+bEY3r9KqTFlsWmfSCf5svENmpBUPwg4Ts7zVLTrphkrcHJeRtRcowgFcQLl
         rE36jeSMLOyc4uFV1ISU7Zd74mNJ22h308Hch4r0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 184/431] clk: rs9: Add support for 9FGV0441
Date:   Sun,  9 Jul 2023 13:12:12 +0200
Message-ID: <20230709111455.492472504@linuxfoundation.org>
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

[ Upstream commit e44fdd114cc3c872aa5157c6b3a190bcf92a9ffb ]

This model is similar to 9FGV0241, but the DIFx bits start at bit 0.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Link: https://lore.kernel.org/r/20230310075535.3476580-4-alexander.stein@ew.tq-group.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: ad527ca87e4e ("clk: rs9: Fix .driver_data content in i2c_device_id")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-renesas-pcie.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index 0710362b2545b..10d31c222a1cb 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -6,6 +6,7 @@
  *   - 9FGV/9DBV/9DMV/9FGL/9DML/9QXL/9SQ
  * Currently supported:
  *   - 9FGV0241
+ *   - 9FGV0441
  *
  * Copyright (C) 2022 Marek Vasut <marex@denx.de>
  */
@@ -51,6 +52,7 @@
 /* Supported Renesas 9-series models. */
 enum rs9_model {
 	RENESAS_9FGV0241,
+	RENESAS_9FGV0441,
 };
 
 /* Structure to describe features of a particular 9-series model */
@@ -64,7 +66,7 @@ struct rs9_driver_data {
 	struct i2c_client	*client;
 	struct regmap		*regmap;
 	const struct rs9_chip_info *chip_info;
-	struct clk_hw		*clk_dif[2];
+	struct clk_hw		*clk_dif[4];
 	u8			pll_amplitude;
 	u8			pll_ssc;
 	u8			clk_dif_sr;
@@ -162,6 +164,8 @@ static u8 rs9_calc_dif(const struct rs9_driver_data *rs9, int idx)
 
 	if (model == RENESAS_9FGV0241)
 		return BIT(idx) + 1;
+	else if (model == RENESAS_9FGV0441)
+		return BIT(idx);
 
 	return 0;
 }
@@ -381,14 +385,22 @@ static const struct rs9_chip_info renesas_9fgv0241_info = {
 	.did		= RS9_REG_DID_TYPE_FGV | 0x02,
 };
 
+static const struct rs9_chip_info renesas_9fgv0441_info = {
+	.model		= RENESAS_9FGV0441,
+	.num_clks	= 4,
+	.did		= RS9_REG_DID_TYPE_FGV | 0x04,
+};
+
 static const struct i2c_device_id rs9_id[] = {
 	{ "9fgv0241", .driver_data = RENESAS_9FGV0241 },
+	{ "9fgv0441", .driver_data = RENESAS_9FGV0441 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rs9_id);
 
 static const struct of_device_id clk_rs9_of_match[] = {
 	{ .compatible = "renesas,9fgv0241", .data = &renesas_9fgv0241_info },
+	{ .compatible = "renesas,9fgv0441", .data = &renesas_9fgv0441_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clk_rs9_of_match);
-- 
2.39.2



