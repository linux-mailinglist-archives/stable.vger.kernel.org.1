Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65556713DB2
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjE1T2C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjE1T2B (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE0AA7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 291FD61C4A
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465C6C433EF;
        Sun, 28 May 2023 19:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302079;
        bh=cOTnS9nq4eOAnN7qp8Mv/l2LLyyC1cV9OYHRXpCJ7Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQuVu/M6SiqlB2lUM9FQ8mPIjV+Cz7D9sAHE3NdGfACdVUZTT0FQkOhzapbkdc0Up
         amnvTPgeqdoqvBzTJHt4b9GKdV44oV3sHrs7nay52vrgA0dWTr+6K7hmgtIMuobX/B
         tIzgxtFPBTVP2Xt4tGNvvM54wjo0dT+7pdNkDI5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.4 152/161] power: supply: bq27xxx: Fix poll_interval handling and races on remove
Date:   Sun, 28 May 2023 20:11:16 +0100
Message-Id: <20230528190841.699000007@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit c00bc80462afc7963f449d7f21d896d2f629cacc upstream.

Before this patch bq27xxx_battery_teardown() was setting poll_interval = 0
to avoid bq27xxx_battery_update() requeuing the delayed_work item.

There are 2 problems with this:

1. If the driver is unbound through sysfs, rather then the module being
   rmmod-ed, this changes poll_interval unexpectedly

2. This is racy, after it being set poll_interval could be changed
   before bq27xxx_battery_update() checks it through
   /sys/module/bq27xxx_battery/parameters/poll_interval

Fix this by added a removed attribute to struct bq27xxx_device_info and
using that instead of setting poll_interval to 0.

There also is another poll_interval related race on remove(), writing
/sys/module/bq27xxx_battery/parameters/poll_interval will requeue
the delayed_work item for all devices on the bq27xxx_battery_devices
list and the device being removed was only removed from that list
after cancelling the delayed_work item.

Fix this by moving the removal from the bq27xxx_battery_devices list
to before cancelling the delayed_work item.

Fixes: 8cfaaa811894 ("bq27x00_battery: Fix OOPS caused by unregistring bq27x00 driver")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/bq27xxx_battery.c |   22 +++++++++-------------
 include/linux/power/bq27xxx_battery.h  |    1 +
 2 files changed, 10 insertions(+), 13 deletions(-)

--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1598,7 +1598,7 @@ static void bq27xxx_battery_update_unloc
 
 	di->last_update = jiffies;
 
-	if (poll_interval > 0)
+	if (!di->removed && poll_interval > 0)
 		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
 }
 
@@ -1915,22 +1915,18 @@ EXPORT_SYMBOL_GPL(bq27xxx_battery_setup)
 
 void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 {
-	/*
-	 * power_supply_unregister call bq27xxx_battery_get_property which
-	 * call bq27xxx_battery_poll.
-	 * Make sure that bq27xxx_battery_poll will not call
-	 * schedule_delayed_work again after unregister (which cause OOPS).
-	 */
-	poll_interval = 0;
-
-	cancel_delayed_work_sync(&di->work);
-
-	power_supply_unregister(di->bat);
-
 	mutex_lock(&bq27xxx_list_lock);
 	list_del(&di->list);
 	mutex_unlock(&bq27xxx_list_lock);
 
+	/* Set removed to avoid bq27xxx_battery_update() re-queuing the work */
+	mutex_lock(&di->lock);
+	di->removed = true;
+	mutex_unlock(&di->lock);
+
+	cancel_delayed_work_sync(&di->work);
+
+	power_supply_unregister(di->bat);
 	mutex_destroy(&di->lock);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -64,6 +64,7 @@ struct bq27xxx_device_info {
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
 	int charge_design_full;
+	bool removed;
 	unsigned long last_update;
 	struct delayed_work work;
 	struct power_supply *bat;


