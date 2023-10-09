Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94937BDDA4
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376789AbjJINL4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377027AbjJINLd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:11:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0CF10EA
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:10:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A32C433C7;
        Mon,  9 Oct 2023 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857042;
        bh=kUc/uQ/J43F8NyWjwUJsXBHP6dtFQEx3vRdJyOKcxRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQPrQpW2OfSohAcY3FSh6iarzS9R0gj67wt2LmVtIwDDLwB2ay38J1/QHM94qJZ+z
         kivxx2f4LneYGs9HQt7ReeuDqJ1s9VaBI6lP4pewmiPqg5kcY9348kNInbNfNWMql6
         OPaTCUqetKT+iJevmUFss2343QqFrrkVXgJzIWzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 077/163] regulator: mt6358: split ops for buck and linear range LDO regulators
Date:   Mon,  9 Oct 2023 15:00:41 +0200
Message-ID: <20231009130126.181107099@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 7e37c851374eca2d1f6128de03195c9f7b4baaf2 ]

The buck and linear range LDO (VSRAM_*) regulators share one set of ops.
This set includes support for get/set mode. However this only makes
sense for buck regulators, not LDOs. The callbacks were not checking
whether the register offset and/or mask for mode setting was valid or
not. This ends up making the kernel report "normal" mode operation for
the LDOs.

Create a new set of ops without the get/set mode callbacks for the
linear range LDO regulators.

Fixes: f67ff1bd58f0 ("regulator: mt6358: Add support for MT6358 regulator")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/20230920085336.136238-1-wenst@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/mt6358-regulator.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index b9cda2210c330..65fbd95f1dbb0 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -43,7 +43,7 @@ struct mt6358_regulator_info {
 	.desc = {	\
 		.name = #vreg,	\
 		.of_match = of_match_ptr(match),	\
-		.ops = &mt6358_volt_range_ops,	\
+		.ops = &mt6358_buck_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6358_ID_##vreg,		\
 		.owner = THIS_MODULE,		\
@@ -139,7 +139,7 @@ struct mt6358_regulator_info {
 	.desc = {	\
 		.name = #vreg,	\
 		.of_match = of_match_ptr(match),	\
-		.ops = &mt6358_volt_range_ops,	\
+		.ops = &mt6358_buck_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6366_ID_##vreg,		\
 		.owner = THIS_MODULE,		\
@@ -450,7 +450,7 @@ static unsigned int mt6358_regulator_get_mode(struct regulator_dev *rdev)
 	}
 }
 
-static const struct regulator_ops mt6358_volt_range_ops = {
+static const struct regulator_ops mt6358_buck_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.map_voltage = regulator_map_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
@@ -464,6 +464,18 @@ static const struct regulator_ops mt6358_volt_range_ops = {
 	.get_mode = mt6358_regulator_get_mode,
 };
 
+static const struct regulator_ops mt6358_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = mt6358_get_buck_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6358_get_status,
+};
+
 static const struct regulator_ops mt6358_volt_table_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_iterate,
-- 
2.40.1



