Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766B66FA5CD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjEHKNP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjEHKNG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:13:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8373AA22
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E6660F91
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2F8C433D2;
        Mon,  8 May 2023 10:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540781;
        bh=xi6wciFx64RggHB0/a7kvQb0JXUQD3l5LR4uLBbKqow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKfdEg9G3I//xiqDk+sVOZ6gacPz+eZxETflMe58qR1a23pzbkVEIC4wOlWvAK7vE
         gVG+MQUJBb5tiTvPI6nMJQ1cv8iLWf5cFJi5JzznO6nHpPb67KlSq10vcNcHB0oOHe
         NOQy5y122okQ8NLX57IjABan3VGhQSfXZbIQtfGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 496/611] power: supply: rk817: Fix low SOC bugs
Date:   Mon,  8 May 2023 11:45:38 +0200
Message-Id: <20230508094438.178080335@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit baba1315a74d12772d4940a05d58dc03e6ec0635 ]

When the SOC approaches zero, an integer overflows in the columb
counter causing the driver to react poorly. This makes the driver
think it's at (above) the fully charged capacity when in fact it's
zero. It would then write this full capacity to NVRAM which would be
used on boot if the device remained off for less than 5 hours and
not plugged in.

This can be fixed and guarded against by doing the following:
 - Changing the type of tmp in rk817_read_or_set_full_charge_on_boot()
   to be an int instead of a u32. That way we can account for negative
   numbers.
 - Guard against negative values for the full charge on boot by setting
   the charge to 0 if the system charge reports less than 0.
 - Catch scenarios where the battery voltage is below the design
   minimum voltage and set the system SOC to 0 at that time and update
   the columb counter with a charge level of 0.
 - Change the off time value from 5 hours to 30 minutes before we
   recalculate the current capacity based on the OCV tables.

These changes allow the driver to operate better at low voltage/low
capacity conditions.

Fixes: 3268a4d9b0b8 ("power: supply: rk817: Fix unsigned comparison with less than zero")
Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/rk817_charger.c | 33 ++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 36f807b5ec442..f1b431aa0e4f2 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -335,6 +335,20 @@ static int rk817_bat_calib_cap(struct rk817_charger *charger)
 			charger->fcc_mah * 1000);
 	}
 
+	/*
+	 * Set the SOC to 0 if we are below the minimum system voltage.
+	 */
+	if (volt_avg <= charger->bat_voltage_min_design_uv) {
+		charger->soc = 0;
+		charge_now_adc = CHARGE_TO_ADC(0, charger->res_div);
+		put_unaligned_be32(charge_now_adc, bulk_reg);
+		regmap_bulk_write(rk808->regmap,
+				  RK817_GAS_GAUGE_Q_INIT_H3, bulk_reg, 4);
+		dev_warn(charger->dev,
+			 "Battery voltage %d below minimum voltage %d\n",
+			 volt_avg, charger->bat_voltage_min_design_uv);
+		}
+
 	rk817_record_battery_nvram_values(charger);
 
 	return 0;
@@ -710,9 +724,10 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 
 	/*
 	 * Read the nvram for state of charge. Sanity check for values greater
-	 * than 100 (10000). If the value is off it should get corrected
-	 * automatically when the voltage drops to the min (soc is 0) or when
-	 * the battery is full (soc is 100).
+	 * than 100 (10000) or less than 0, because other things (BSP kernels,
+	 * U-Boot, or even i2cset) can write to this register. If the value is
+	 * off it should get corrected automatically when the voltage drops to
+	 * the min (soc is 0) or when the battery is full (soc is 100).
 	 */
 	ret = regmap_bulk_read(charger->rk808->regmap,
 			       RK817_GAS_GAUGE_BAT_R1, bulk_reg, 3);
@@ -721,6 +736,8 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 	charger->soc = get_unaligned_le24(bulk_reg);
 	if (charger->soc > 10000)
 		charger->soc = 10000;
+	if (charger->soc < 0)
+		charger->soc = 0;
 
 	return 0;
 }
@@ -731,8 +748,8 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 {
 	struct rk808 *rk808 = charger->rk808;
 	u8 bulk_reg[4];
-	u32 boot_voltage, boot_charge_mah, tmp;
-	int ret, reg, off_time;
+	u32 boot_voltage, boot_charge_mah;
+	int ret, reg, off_time, tmp;
 	bool first_boot;
 
 	/*
@@ -785,10 +802,12 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
 				 bulk_reg, 4);
 		tmp = get_unaligned_be32(bulk_reg);
+		if (tmp < 0)
+			tmp = 0;
 		boot_charge_mah = ADC_TO_CHARGE_UAH(tmp,
 						    charger->res_div) / 1000;
 		/*
-		 * Check if the columb counter has been off for more than 300
+		 * Check if the columb counter has been off for more than 30
 		 * minutes as it tends to drift downward. If so, re-init soc
 		 * with the boot voltage instead. Note the unit values for the
 		 * OFF_CNT register appear to be in decaminutes and stops
@@ -799,7 +818,7 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 		 * than 0 on a reboot anyway.
 		 */
 		regmap_read(rk808->regmap, RK817_GAS_GAUGE_OFF_CNT, &off_time);
-		if (off_time >= 30) {
+		if (off_time >= 3) {
 			regmap_bulk_read(rk808->regmap,
 					 RK817_GAS_GAUGE_PWRON_VOL_H,
 					 bulk_reg, 2);
-- 
2.39.2



