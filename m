Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CEF713EB9
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjE1TiN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjE1TiM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2794FAB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B217461E6F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D035BC4339B;
        Sun, 28 May 2023 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302690;
        bh=ACnsGrDB10fBpebDRNKrCyNxB08zK3w7CiMEPv7FCJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCR4wCvUVEt6IsvcOiNEyiNlV82eYfHR8RMrR+zEDvnmchGFCXNcRTt44ZRtYZXGh
         hXmnSdh6ImJYzidvv2qho3/agJqT0xqmu/4P7PabFqPrXCIVbXZsuJtezPoC1fpBTO
         TVq8ovKlu8RxJJAOv13BVwyCpEbt71D+2Zlx3V3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.1 078/119] power: supply: bq27xxx: Add cache parameter to bq27xxx_battery_current_and_status()
Date:   Sun, 28 May 2023 20:11:18 +0100
Message-Id: <20230528190838.113093162@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
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

commit 35092c5819f8c5acc7bafe3fdbb13d6307c4f5e1 upstream.

Add a cache parameter to bq27xxx_battery_current_and_status() so that
it can optionally use cached flags instead of re-reading them itself.

This is a preparation patch for making bq27xxx_battery_update() check
the status and have it call power_supply_changed() on status changes.

Fixes: 297a533b3e62 ("bq27x00: Cache battery registers")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/bq27xxx_battery.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1840,7 +1840,8 @@ static bool bq27xxx_battery_is_full(stru
 static int bq27xxx_battery_current_and_status(
 	struct bq27xxx_device_info *di,
 	union power_supply_propval *val_curr,
-	union power_supply_propval *val_status)
+	union power_supply_propval *val_status,
+	struct bq27xxx_reg_cache *cache)
 {
 	bool single_flags = (di->opts & BQ27XXX_O_ZERO);
 	int curr;
@@ -1852,10 +1853,14 @@ static int bq27xxx_battery_current_and_s
 		return curr;
 	}
 
-	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
-	if (flags < 0) {
-		dev_err(di->dev, "error reading flags\n");
-		return flags;
+	if (cache) {
+		flags = cache->flags;
+	} else {
+		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
+		if (flags < 0) {
+			dev_err(di->dev, "error reading flags\n");
+			return flags;
+		}
 	}
 
 	if (di->opts & BQ27XXX_O_ZERO) {
@@ -2001,7 +2006,7 @@ static int bq27xxx_battery_get_property(
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret = bq27xxx_battery_current_and_status(di, NULL, val);
+		ret = bq27xxx_battery_current_and_status(di, NULL, val, NULL);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = bq27xxx_battery_voltage(di, val);
@@ -2010,7 +2015,7 @@ static int bq27xxx_battery_get_property(
 		val->intval = di->cache.flags < 0 ? 0 : 1;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = bq27xxx_battery_current_and_status(di, val, NULL);
+		ret = bq27xxx_battery_current_and_status(di, val, NULL, NULL);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = bq27xxx_simple_value(di->cache.capacity, val);


