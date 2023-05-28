Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06944713E9B
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjE1ThJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjE1ThI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F53A8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC04D61E58
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C944BC4339B;
        Sun, 28 May 2023 19:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302626;
        bh=YpxgzA2nDCa17xlGgPwPHpQqZz5aHUuztlKSkLRVZqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZXLTeojZWkBoLcimZ2bTkJI+cmuPTRf3FJCgZ3f2q7roiChT6s/3r3wtpGtwvwb9
         KuERlgMiuwJd3MQ4nLVKCpigaHyq7OcfiDNLL0lIiVOc7pclZSvuwx+BRTx/zPtJcK
         TIS7oiw1SA9BBqHcDM38Jm+bCD4i9h+Em/uJUtTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.1 080/119] power: supply: bq27xxx: Ensure power_supply_changed() is called on current sign changes
Date:   Sun, 28 May 2023 20:11:20 +0100
Message-Id: <20230528190838.187922396@linuxfoundation.org>
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

commit 939a116142012926e25de0ea6b7e2f8d86a5f1b6 upstream.

On gauges where the current register is signed, there is no charging
flag in the flags register. So only checking flags will not result
in power_supply_changed() getting called when e.g. a charger is plugged
in and the current sign changes from negative (discharging) to
positive (charging).

This causes userspace's notion of the status to lag until userspace
does a poll.

And when a power_supply_leds.c LED trigger is used to indicate charging
status with a LED, this LED will lag until the capacity percentage
changes, which may take many minutes (because the LED trigger only is
updated on power_supply_changed() calls).

Fix this by calling bq27xxx_battery_current_and_status() on gauges with
a signed current register and checking if the status has changed.

Fixes: 297a533b3e62 ("bq27x00: Cache battery registers")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/bq27xxx_battery.c |   13 ++++++++++++-
 include/linux/power/bq27xxx_battery.h  |    3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1836,6 +1836,7 @@ static int bq27xxx_battery_current_and_s
 
 static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 {
+	union power_supply_propval status = di->last_status;
 	struct bq27xxx_reg_cache cache = {0, };
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
 
@@ -1860,14 +1861,24 @@ static void bq27xxx_battery_update_unloc
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
 			cache.cycle_count = bq27xxx_battery_read_cyct(di);
 
+		/*
+		 * On gauges with signed current reporting the current must be
+		 * checked to detect charging <-> discharging status changes.
+		 */
+		if (!(di->opts & BQ27XXX_O_ZERO))
+			bq27xxx_battery_current_and_status(di, NULL, &status, &cache);
+
 		/* We only have to read charge design full once */
 		if (di->charge_design_full <= 0)
 			di->charge_design_full = bq27xxx_battery_read_dcap(di);
 	}
 
 	if ((di->cache.capacity != cache.capacity) ||
-	    (di->cache.flags != cache.flags))
+	    (di->cache.flags != cache.flags) ||
+	    (di->last_status.intval != status.intval)) {
+		di->last_status.intval = status.intval;
 		power_supply_changed(di->bat);
+	}
 
 	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
 		di->cache = cache;
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_BQ27X00_BATTERY_H__
 #define __LINUX_BQ27X00_BATTERY_H__
 
+#include <linux/power_supply.h>
+
 enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
@@ -70,6 +72,7 @@ struct bq27xxx_device_info {
 	int charge_design_full;
 	bool removed;
 	unsigned long last_update;
+	union power_supply_propval last_status;
 	struct delayed_work work;
 	struct power_supply *bat;
 	struct list_head list;


