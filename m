Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E18719D8F
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjFANYO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjFANYL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:24:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5111AD
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC39364472
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C3CC4339B;
        Thu,  1 Jun 2023 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625838;
        bh=BvkoDVpI+K4Ov/GcRbDmWWgBYi4fPCl/flUv0npKG1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovctPCzbgogNp0slIMe+FSB3/BbFyKgCTSIs2jhA6lZVjlcUWu5SnXWVS+MfwGd41
         cgIaBT8RhiQwHF270hVPdzYNeIc/zcbg7Z4NXqQkhkkBe/Hq043jeiupxek+F2eCXg
         rGQU6NVei74EkmzEtaggIJIjreaV5AiPMNAwnnlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 05/42] power: supply: core: Refactor power_supply_set_input_current_limit_from_supplier()
Date:   Thu,  1 Jun 2023 14:20:52 +0100
Message-Id: <20230601131936.936055721@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 2220af8ca61ae67de4ec3deec1c6395a2f65b9fd ]

Some (USB) charger ICs have variants with USB D+ and D- pins to do their
own builtin charger-type detection, like e.g. the bq24190 and bq25890 and
also variants which lack this functionality, e.g. the bq24192 and bq25892.

In case the charger-type; and thus the input-current-limit detection is
done outside the charger IC then we need some way to communicate this to
the charger IC. In the past extcon was used for this, but if the external
detection does e.g. full USB PD negotiation then the extcon cable-types do
not convey enough information.

For these setups it was decided to model the external charging "brick"
and the parameters negotiated with it as a power_supply class-device
itself; and power_supply_set_input_current_limit_from_supplier() was
introduced to allow drivers to get the input-current-limit this way.

But in some cases psy drivers may want to know other properties, e.g. the
bq25892 can do "quick-charge" negotiation by pulsing its current draw,
but this should only be done if the usb_type psy-property of its supplier
is set to DCP (and device-properties indicate the board allows higher
voltages).

Instead of adding extra helper functions for each property which
a psy-driver wants to query from its supplier, refactor
power_supply_set_input_current_limit_from_supplier() into a
more generic power_supply_get_property_from_supplier() function.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 77c2a3097d70 ("power: supply: bq24190: Call power_supply_changed() after updating input current")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq24190_charger.c   | 12 ++++-
 drivers/power/supply/power_supply_core.c | 57 +++++++++++++-----------
 include/linux/power_supply.h             |  5 ++-
 3 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index ebb5ba7f8bb63..19537bd75013d 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1201,8 +1201,18 @@ static void bq24190_input_current_limit_work(struct work_struct *work)
 	struct bq24190_dev_info *bdi =
 		container_of(work, struct bq24190_dev_info,
 			     input_current_limit_work.work);
+	union power_supply_propval val;
+	int ret;
+
+	ret = power_supply_get_property_from_supplier(bdi->charger,
+						      POWER_SUPPLY_PROP_CURRENT_MAX,
+						      &val);
+	if (ret)
+		return;
 
-	power_supply_set_input_current_limit_from_supplier(bdi->charger);
+	bq24190_charger_set_property(bdi->charger,
+				     POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+				     &val);
 }
 
 /* Sync the input-current-limit with our parent supply (if we have one) */
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 8161fad081a96..daf76d7885c05 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -375,46 +375,49 @@ int power_supply_is_system_supplied(void)
 }
 EXPORT_SYMBOL_GPL(power_supply_is_system_supplied);
 
-static int __power_supply_get_supplier_max_current(struct device *dev,
-						   void *data)
+struct psy_get_supplier_prop_data {
+	struct power_supply *psy;
+	enum power_supply_property psp;
+	union power_supply_propval *val;
+};
+
+static int __power_supply_get_supplier_property(struct device *dev, void *_data)
 {
-	union power_supply_propval ret = {0,};
 	struct power_supply *epsy = dev_get_drvdata(dev);
-	struct power_supply *psy = data;
+	struct psy_get_supplier_prop_data *data = _data;
 
-	if (__power_supply_is_supplied_by(epsy, psy))
-		if (!epsy->desc->get_property(epsy,
-					      POWER_SUPPLY_PROP_CURRENT_MAX,
-					      &ret))
-			return ret.intval;
+	if (__power_supply_is_supplied_by(epsy, data->psy))
+		if (!epsy->desc->get_property(epsy, data->psp, data->val))
+			return 1; /* Success */
 
-	return 0;
+	return 0; /* Continue iterating */
 }
 
-int power_supply_set_input_current_limit_from_supplier(struct power_supply *psy)
+int power_supply_get_property_from_supplier(struct power_supply *psy,
+					    enum power_supply_property psp,
+					    union power_supply_propval *val)
 {
-	union power_supply_propval val = {0,};
-	int curr;
-
-	if (!psy->desc->set_property)
-		return -EINVAL;
+	struct psy_get_supplier_prop_data data = {
+		.psy = psy,
+		.psp = psp,
+		.val = val,
+	};
+	int ret;
 
 	/*
 	 * This function is not intended for use with a supply with multiple
-	 * suppliers, we simply pick the first supply to report a non 0
-	 * max-current.
+	 * suppliers, we simply pick the first supply to report the psp.
 	 */
-	curr = class_for_each_device(power_supply_class, NULL, psy,
-				      __power_supply_get_supplier_max_current);
-	if (curr <= 0)
-		return (curr == 0) ? -ENODEV : curr;
-
-	val.intval = curr;
+	ret = class_for_each_device(power_supply_class, NULL, &data,
+				    __power_supply_get_supplier_property);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return -ENODEV;
 
-	return psy->desc->set_property(psy,
-				POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(power_supply_set_input_current_limit_from_supplier);
+EXPORT_SYMBOL_GPL(power_supply_get_property_from_supplier);
 
 int power_supply_set_battery_charged(struct power_supply *psy)
 {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a2117..0735b8963e0af 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -420,8 +420,9 @@ power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table
 				int table_len, int temp);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
-extern int power_supply_set_input_current_limit_from_supplier(
-					 struct power_supply *psy);
+int power_supply_get_property_from_supplier(struct power_supply *psy,
+					    enum power_supply_property psp,
+					    union power_supply_propval *val);
 extern int power_supply_set_battery_charged(struct power_supply *psy);
 
 #ifdef CONFIG_POWER_SUPPLY
-- 
2.39.2



