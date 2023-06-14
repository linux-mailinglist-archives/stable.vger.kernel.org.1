Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36AF719D88
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjFANYC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjFANXz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E37124
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:23:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E1F61627
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32149C433EF;
        Thu,  1 Jun 2023 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625828;
        bh=8COC0BuCbT5HYoj6R94AO+/7obDR1Opyoz7hIHqA43I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLmjHJfz9v2y+9a8bdznX35E9OoIEH/TM6BtHfmNfCgoWXPL/W/706IeeSzaFRMBL
         uwtSJuh0ijk2ZU4cC/SfvS053fqd3cOS+av0RgWzDcEmx0Tc9W7/NzJDRf0b1nLBJx
         Vozy/3BuFGvMqOwPaeasucrvi8JSgJHXK62OtvGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 01/42] power: supply: bq27xxx: expose battery data when CI=1
Date:   Thu,  1 Jun 2023 14:20:48 +0100
Message-Id: <20230601131936.765376822@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

From: Sicelo A. Mhlongo <absicsz@gmail.com>

[ Upstream commit 68fdbe090c362e8be23890a7333d156e18c27781 ]

When the Capacity Inaccurate flag is set, the chip still provides data
about the battery, albeit inaccurate. Instead of discarding capacity
values for CI=1, expose the stale data and use the
POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED property to indicate that the
values should be used with care.

Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: ff4c4a2a4437 ("power: supply: bq27xxx: Move bq27xxx_battery_update() down")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 60 ++++++++++++--------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7334a8b8007e5..66199f1c1c5d1 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1572,14 +1572,6 @@ static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di, u8 reg)
  */
 static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *di)
 {
-	int flags;
-
-	if (di->opts & BQ27XXX_O_ZERO) {
-		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
-		if (flags >= 0 && (flags & BQ27000_FLAG_CI))
-			return -ENODATA;
-	}
-
 	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);
 }
 
@@ -1742,6 +1734,18 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
 		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
 }
 
+/*
+ * Returns true if reported battery capacity is inaccurate
+ */
+static bool bq27xxx_battery_capacity_inaccurate(struct bq27xxx_device_info *di,
+						 u16 flags)
+{
+	if (di->opts & BQ27XXX_O_HAS_CI)
+		return (flags & BQ27000_FLAG_CI);
+	else
+		return false;
+}
+
 static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 {
 	/* Unlikely but important to return first */
@@ -1751,6 +1755,8 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 		return POWER_SUPPLY_HEALTH_COLD;
 	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
 		return POWER_SUPPLY_HEALTH_DEAD;
+	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, di->cache.flags)))
+		return POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
 
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
@@ -1758,7 +1764,6 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 {
 	struct bq27xxx_reg_cache cache = {0, };
-	bool has_ci_flag = di->opts & BQ27XXX_O_HAS_CI;
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
 
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
@@ -1766,30 +1771,19 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
 		cache.temperature = bq27xxx_battery_read_temperature(di);
-		if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
-			dev_info_once(di->dev, "battery is not calibrated! ignoring capacity values\n");
-			cache.capacity = -ENODATA;
-			cache.energy = -ENODATA;
-			cache.time_to_empty = -ENODATA;
-			cache.time_to_empty_avg = -ENODATA;
-			cache.time_to_full = -ENODATA;
-			cache.charge_full = -ENODATA;
-			cache.health = -ENODATA;
-		} else {
-			if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
-				cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
-			if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
-				cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
-			if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
-				cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
-
-			cache.charge_full = bq27xxx_battery_read_fcc(di);
-			cache.capacity = bq27xxx_battery_read_soc(di);
-			if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
-				cache.energy = bq27xxx_battery_read_energy(di);
-			di->cache.flags = cache.flags;
-			cache.health = bq27xxx_battery_read_health(di);
-		}
+		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
+			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
+		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
+			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
+		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
+			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
+
+		cache.charge_full = bq27xxx_battery_read_fcc(di);
+		cache.capacity = bq27xxx_battery_read_soc(di);
+		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
+			cache.energy = bq27xxx_battery_read_energy(di);
+		di->cache.flags = cache.flags;
+		cache.health = bq27xxx_battery_read_health(di);
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
 			cache.cycle_count = bq27xxx_battery_read_cyct(di);
 
-- 
2.39.2



