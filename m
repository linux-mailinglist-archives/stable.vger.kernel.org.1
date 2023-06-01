Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE64719D86
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjFANXr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjFANXd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956C01A6
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0CEE64468
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0776CC433D2;
        Thu,  1 Jun 2023 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625808;
        bh=feCKFR2RM7d3rqsRjWlWAbPkR4XQIY3q1oRAvTb9JMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SwcmfSNyJsJO8CSSnNQVvc1ru0hia7h0owqvAFY5Yz7gQPc1yIC17/IVY/1Q9F5W6
         eUDubsKg+ln6fgM6gaOLo09RkPdqfUVdhqLx+sxjkRCvswbNpnp15UhI45yohKYgBG
         UYCEPhH3CUe3GimJy6UZ4uohZBnotY3NCEJKlzpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 05/22] power: supply: bq27xxx: make status more robust
Date:   Thu,  1 Jun 2023 14:21:03 +0100
Message-Id: <20230601131933.968973306@linuxfoundation.org>
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

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

[ Upstream commit c3a6d6a1dfc8a9bf12d79a0b1a30cb24c92a2ddf ]

There are multiple issues in bq27xxx_battery_status():

- On BQ28Q610 is was observed that the "full" flag may be set even while
  the battery is charging or discharging. With the current logic to make
  "full" override everything else, it look a very long time (>20min) for
  the status to change from "full" to "discharging" after unplugging the
  supply on a device with low power consumption
- The POWER_SUPPLY_STATUS_NOT_CHARGING check depends on
  power_supply_am_i_supplied(), which will not work when the supply
  doesn't exist as a separate device known to Linux

We can solve both issues by deriving the status from the current instead
of the flags field. The flags are now only used to distinguish "full"
from "not charging", and to determine the sign of the current on
BQ27XXX_O_ZERO devices.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 35092c5819f8 ("power: supply: bq27xxx: Add cache parameter to bq27xxx_battery_current_and_status()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 88 +++++++++++++-------------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index d34f1fceadbb4..681fa81f4dbde 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1754,14 +1754,27 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 	bq27xxx_battery_update(di);
 }
 
+static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int flags)
+{
+	if (di->opts & BQ27XXX_O_ZERO)
+		return (flags & BQ27000_FLAG_FC);
+	else if (di->opts & BQ27Z561_O_BITS)
+		return (flags & BQ27Z561_FLAG_FC);
+	else
+		return (flags & BQ27XXX_FLAG_FC);
+}
+
 /*
- * Return the battery average current in µA
+ * Return the battery average current in µA and the status
  * Note that current can be negative signed as well
  * Or 0 if something fails.
  */
-static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
-				   union power_supply_propval *val)
+static int bq27xxx_battery_current_and_status(
+	struct bq27xxx_device_info *di,
+	union power_supply_propval *val_curr,
+	union power_supply_propval *val_status)
 {
+	bool single_flags = (di->opts & BQ27XXX_O_ZERO);
 	int curr;
 	int flags;
 
@@ -1771,17 +1784,39 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
 		return curr;
 	}
 
+	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
+	if (flags < 0) {
+		dev_err(di->dev, "error reading flags\n");
+		return flags;
+	}
+
 	if (di->opts & BQ27XXX_O_ZERO) {
-		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
 		if (!(flags & BQ27000_FLAG_CHGS)) {
 			dev_dbg(di->dev, "negative current!\n");
 			curr = -curr;
 		}
 
-		val->intval = curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
+		curr = curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
 	} else {
 		/* Other gauges return signed value */
-		val->intval = (int)((s16)curr) * 1000;
+		curr = (int)((s16)curr) * 1000;
+	}
+
+	if (val_curr)
+		val_curr->intval = curr;
+
+	if (val_status) {
+		if (curr > 0) {
+			val_status->intval = POWER_SUPPLY_STATUS_CHARGING;
+		} else if (curr < 0) {
+			val_status->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		} else {
+			if (bq27xxx_battery_is_full(di, flags))
+				val_status->intval = POWER_SUPPLY_STATUS_FULL;
+			else
+				val_status->intval =
+					POWER_SUPPLY_STATUS_NOT_CHARGING;
+		}
 	}
 
 	return 0;
@@ -1813,43 +1848,6 @@ static int bq27xxx_battery_pwr_avg(struct bq27xxx_device_info *di,
 	return 0;
 }
 
-static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
-				  union power_supply_propval *val)
-{
-	int status;
-
-	if (di->opts & BQ27XXX_O_ZERO) {
-		if (di->cache.flags & BQ27000_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27000_FLAG_CHGS)
-			status = POWER_SUPPLY_STATUS_CHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-	} else if (di->opts & BQ27Z561_O_BITS) {
-		if (di->cache.flags & BQ27Z561_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27Z561_FLAG_DIS_CH)
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_CHARGING;
-	} else {
-		if (di->cache.flags & BQ27XXX_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27XXX_FLAG_DSC)
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_CHARGING;
-	}
-
-	if ((status == POWER_SUPPLY_STATUS_DISCHARGING) &&
-	    (power_supply_am_i_supplied(di->bat) > 0))
-		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-
-	val->intval = status;
-
-	return 0;
-}
-
 static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
 					  union power_supply_propval *val)
 {
@@ -1935,7 +1933,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret = bq27xxx_battery_status(di, val);
+		ret = bq27xxx_battery_current_and_status(di, NULL, val);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = bq27xxx_battery_voltage(di, val);
@@ -1944,7 +1942,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		val->intval = di->cache.flags < 0 ? 0 : 1;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = bq27xxx_battery_current(di, val);
+		ret = bq27xxx_battery_current_and_status(di, val, NULL);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = bq27xxx_simple_value(di->cache.capacity, val);
-- 
2.39.2



