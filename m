Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB35C713DB0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjE1T17 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjE1T16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C124CB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4891D61C4A
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64655C433D2;
        Sun, 28 May 2023 19:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302074;
        bh=FsWroIyK0i5xJGyka44Isj5pcezDiajg9dLIb3W+pfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XC+CGVZWY9XAkLdW1GeP9dECfRbbaWBPaznNsupF1U5URVKyI+H5Y9o0mnw35CQFZ
         jl4uZRDt6P+km6VL3g6sqpKQd6SX7mzxBOhFOYAR6NMUNK7upJ88lqIgWVWNflRgkA
         ADJZOaTjVOdvsisEVorqNldaTPwj9EgBUvXj5Y9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.4 150/161] power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
Date:   Sun, 28 May 2023 20:11:14 +0100
Message-Id: <20230528190841.649471657@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
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

commit 5c34c0aef185dcd10881847b9ebf20046aa77cb4 upstream.

bq27xxx_battery_update() assumes / requires that it is only run once,
not multiple times at the same time. But there are 3 possible callers:

1. bq27xxx_battery_poll() delayed_work item handler
2. bq27xxx_battery_irq_handler_thread() I2C IRQ handler
3. bq27xxx_battery_setup()

And there is no protection against these racing with each other,
fix this race condition by making all callers take di->lock:

- Rename bq27xxx_battery_update() to bq27xxx_battery_update_unlocked()

- Add new bq27xxx_battery_update() which takes di->lock and then calls
  bq27xxx_battery_update_unlocked()

- Make stale cache check code in bq27xxx_battery_get_property(), which
  already takes di->lock directly to check the jiffies, call
  bq27xxx_battery_update_unlocked() instead of messing with
  the delayed_work item

- Make bq27xxx_battery_update_unlocked() mod the delayed-work item
  so that the next poll is delayed to poll_interval milliseconds after
  the last update independent of the source of the update

Fixes: 740b755a3b34 ("bq27x00: Poll battery state")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/bq27xxx_battery.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1547,7 +1547,7 @@ static int bq27xxx_battery_read_health(s
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
-void bq27xxx_battery_update(struct bq27xxx_device_info *di)
+static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 {
 	struct bq27xxx_reg_cache cache = {0, };
 	bool has_ci_flag = di->opts & BQ27XXX_O_ZERO;
@@ -1597,6 +1597,16 @@ void bq27xxx_battery_update(struct bq27x
 		di->cache = cache;
 
 	di->last_update = jiffies;
+
+	if (poll_interval > 0)
+		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
+}
+
+void bq27xxx_battery_update(struct bq27xxx_device_info *di)
+{
+	mutex_lock(&di->lock);
+	bq27xxx_battery_update_unlocked(di);
+	mutex_unlock(&di->lock);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
 
@@ -1607,9 +1617,6 @@ static void bq27xxx_battery_poll(struct
 				     work.work);
 
 	bq27xxx_battery_update(di);
-
-	if (poll_interval > 0)
-		schedule_delayed_work(&di->work, poll_interval * HZ);
 }
 
 /*
@@ -1770,10 +1777,8 @@ static int bq27xxx_battery_get_property(
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
 	mutex_lock(&di->lock);
-	if (time_is_before_jiffies(di->last_update + 5 * HZ)) {
-		cancel_delayed_work_sync(&di->work);
-		bq27xxx_battery_poll(&di->work.work);
-	}
+	if (time_is_before_jiffies(di->last_update + 5 * HZ))
+		bq27xxx_battery_update_unlocked(di);
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)


