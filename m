Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A2719D71
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjFANXN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjFANXG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:23:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B036B18C
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA846445C
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39372C4339B;
        Thu,  1 Jun 2023 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625783;
        bh=Ua7VCcvtBIcjbScxY02FS40vZZUQn7jVn1/jegwVo30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkRooWG1NBStYNAVZgfMakh5+jwwyz8ULunIQbTJcPkkhKFmYeaXVZdVQz7cx2rym
         o/HWYJpUwiYjEN7V0QvjVEsum1gyT5+OEhV0lp3wD00YiDe1yfZLAe8R/X29/03FvW
         U+DamxQLg4i99PnP84zhnxT16j99i4VwAnIAX7tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Axel Lin <axel.lin@ingics.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 14/22] regulator: pca9450: Convert to use regulator_set_ramp_delay_regmap
Date:   Thu,  1 Jun 2023 14:21:12 +0100
Message-Id: <20230601131934.416160844@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131933.727832920@linuxfoundation.org>
References: <20230601131933.727832920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit 4c4fce171c4ca08cd98be7db350e6950630b046a ]

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20210526122408.78156-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: d67dada3e252 ("regulator: pca9450: Fix BUCK2 enable_mask")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pca9450-regulator.c | 51 +++++++++++++--------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index d38109cc3a011..fd184c6c7c78a 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -65,32 +65,9 @@ static const struct regmap_config pca9450_regmap_config = {
  * 10: 25mV/4usec
  * 11: 25mV/8usec
  */
-static int pca9450_dvs_set_ramp_delay(struct regulator_dev *rdev,
-				      int ramp_delay)
-{
-	int id = rdev_get_id(rdev);
-	unsigned int ramp_value;
-
-	switch (ramp_delay) {
-	case 1 ... 3125:
-		ramp_value = BUCK1_RAMP_3P125MV;
-		break;
-	case 3126 ... 6250:
-		ramp_value = BUCK1_RAMP_6P25MV;
-		break;
-	case 6251 ... 12500:
-		ramp_value = BUCK1_RAMP_12P5MV;
-		break;
-	case 12501 ... 25000:
-		ramp_value = BUCK1_RAMP_25MV;
-		break;
-	default:
-		ramp_value = BUCK1_RAMP_25MV;
-	}
-
-	return regmap_update_bits(rdev->regmap, PCA9450_REG_BUCK1CTRL + id * 3,
-				  BUCK1_RAMP_MASK, ramp_value << 6);
-}
+static const unsigned int pca9450_dvs_buck_ramp_table[] = {
+	25000, 12500, 6250, 3125
+};
 
 static const struct regulator_ops pca9450_dvs_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
@@ -100,7 +77,7 @@ static const struct regulator_ops pca9450_dvs_buck_regulator_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-	.set_ramp_delay = pca9450_dvs_set_ramp_delay,
+	.set_ramp_delay	= regulator_set_ramp_delay_regmap,
 };
 
 static const struct regulator_ops pca9450_buck_regulator_ops = {
@@ -251,6 +228,10 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK1OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK1CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK1CTRL,
+			.ramp_mask = BUCK1_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -276,6 +257,10 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -301,6 +286,10 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK3OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK3CTRL,
 			.enable_mask = BUCK3_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK3CTRL,
+			.ramp_mask = BUCK3_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -477,6 +466,10 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK1OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK1CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK1CTRL,
+			.ramp_mask = BUCK1_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -502,6 +495,10 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
-- 
2.39.2



