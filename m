Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB62703B0A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbjEOR7H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbjEOR6d (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:58:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675A515ED9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79C1A62FD9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A678C433D2;
        Mon, 15 May 2023 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173311;
        bh=ofkjjsjz3rpRui9XZTf9BTp8n6Ih04+ohXtXNtwKRjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9yFDmwGy3psI9gc+KFuJJnqA8dXsVudlNMivq795MpEFYPlrtqTgTI8tYDtoswzI
         G1s8L7p2RM5f7Bc2XL7qLFtALReR5hShpGeyAHifbk8tWoNYJx8vnXbGBP1RD6E4gf
         a3C4QbAlcw5J7ko/pw9j1vaB+EWsGi1Rlj8aQFws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 054/282] regulator: core: Avoid lockdep reports when resolving supplies
Date:   Mon, 15 May 2023 18:27:12 +0200
Message-Id: <20230515161723.870880486@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit cba6cfdc7c3f1516f0d08ddfb24e689af0932573 ]

An automated bot told me that there was a potential lockdep problem
with regulators. This was on the chromeos-5.15 kernel, but I see
nothing that would be different downstream compared to upstream. The
bot said:
  ============================================
  WARNING: possible recursive locking detected
  5.15.104-lockdep-17461-gc1e499ed6604 #1 Not tainted
  --------------------------------------------
  kworker/u16:4/115 is trying to acquire lock:
  ffffff8083110170 (regulator_ww_class_mutex){+.+.}-{3:3}, at: create_regulator+0x398/0x7ec

  but task is already holding lock:
  ffffff808378e170 (regulator_ww_class_mutex){+.+.}-{3:3}, at: ww_mutex_trylock+0x3c/0x7b8

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(regulator_ww_class_mutex);
    lock(regulator_ww_class_mutex);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  4 locks held by kworker/u16:4/115:
   #0: ffffff808006a948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x520/0x1348
   #1: ffffffc00e0a7cc0 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x55c/0x1348
   #2: ffffff80828a2260 (&dev->mutex){....}-{3:3}, at: __device_attach_async_helper+0xd0/0x2a4
   #3: ffffff808378e170 (regulator_ww_class_mutex){+.+.}-{3:3}, at: ww_mutex_trylock+0x3c/0x7b8

  stack backtrace:
  CPU: 2 PID: 115 Comm: kworker/u16:4 Not tainted 5.15.104-lockdep-17461-gc1e499ed6604 #1 9292e52fa83c0e23762b2b3aa1bacf5787a4d5da
  Hardware name: Google Quackingstick (rev0+) (DT)
  Workqueue: events_unbound async_run_entry_fn
  Call trace:
   dump_backtrace+0x0/0x4ec
   show_stack+0x34/0x50
   dump_stack_lvl+0xdc/0x11c
   dump_stack+0x1c/0x48
   __lock_acquire+0x16d4/0x6c74
   lock_acquire+0x208/0x750
   __mutex_lock_common+0x11c/0x11f8
   ww_mutex_lock+0xc0/0x440
   create_regulator+0x398/0x7ec
   regulator_resolve_supply+0x654/0x7c4
   regulator_register_resolve_supply+0x30/0x120
   class_for_each_device+0x1b8/0x230
   regulator_register+0x17a4/0x1f40
   devm_regulator_register+0x60/0xd0
   reg_fixed_voltage_probe+0x728/0xaec
   platform_probe+0x150/0x1c8
   really_probe+0x274/0xa20
   __driver_probe_device+0x1dc/0x3f4
   driver_probe_device+0x78/0x1c0
   __device_attach_driver+0x1ac/0x2c8
   bus_for_each_drv+0x11c/0x190
   __device_attach_async_helper+0x1e4/0x2a4
   async_run_entry_fn+0xa0/0x3ac
   process_one_work+0x638/0x1348
   worker_thread+0x4a8/0x9c4
   kthread+0x2e4/0x3a0
   ret_from_fork+0x10/0x20

The problem was first reported soon after we made many of the
regulators probe asynchronously, though nothing I've seen implies that
the problems couldn't have also happened even without that.

I haven't personally been able to reproduce the lockdep issue, but the
issue does look somewhat legitimate. Specifically, it looks like in
regulator_resolve_supply() we are holding a "rdev" lock while calling
set_supply() -> create_regulator() which grabs the lock of a
_different_ "rdev" (the one for our supply). This is not necessarily
safe from a lockdep perspective since there is no documented ordering
between these two locks.

In reality, we should always be locking a regulator before the
supplying regulator, so I don't expect there to be any real deadlocks
in practice. However, the regulator framework in general doesn't
express this to lockdep.

Let's fix the issue by simply grabbing the two locks involved in the
same way we grab multiple locks elsewhere in the regulator framework:
using the "wound/wait" mechanisms.

Fixes: eaa7995c529b ("regulator: core: avoid regulator_resolve_supply() race condition")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20230329143317.RFC.v2.2.I30d8e1ca10cfbe5403884cdd192253a2e063eb9e@changeid
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 91 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1cdf924c0111b..06da271ad5dd3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -217,6 +217,78 @@ void regulator_unlock(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(regulator_unlock);
 
+/**
+ * regulator_lock_two - lock two regulators
+ * @rdev1:		first regulator
+ * @rdev2:		second regulator
+ * @ww_ctx:		w/w mutex acquire context
+ *
+ * Locks both rdevs using the regulator_ww_class.
+ */
+static void regulator_lock_two(struct regulator_dev *rdev1,
+			       struct regulator_dev *rdev2,
+			       struct ww_acquire_ctx *ww_ctx)
+{
+	struct regulator_dev *tmp;
+	int ret;
+
+	ww_acquire_init(ww_ctx, &regulator_ww_class);
+
+	/* Try to just grab both of them */
+	ret = regulator_lock_nested(rdev1, ww_ctx);
+	WARN_ON(ret);
+	ret = regulator_lock_nested(rdev2, ww_ctx);
+	if (ret != -EDEADLOCK) {
+		WARN_ON(ret);
+		goto exit;
+	}
+
+	while (true) {
+		/*
+		 * Start of loop: rdev1 was locked and rdev2 was contended.
+		 * Need to unlock rdev1, slowly lock rdev2, then try rdev1
+		 * again.
+		 */
+		regulator_unlock(rdev1);
+
+		ww_mutex_lock_slow(&rdev2->mutex, ww_ctx);
+		rdev2->ref_cnt++;
+		rdev2->mutex_owner = current;
+		ret = regulator_lock_nested(rdev1, ww_ctx);
+
+		if (ret == -EDEADLOCK) {
+			/* More contention; swap which needs to be slow */
+			tmp = rdev1;
+			rdev1 = rdev2;
+			rdev2 = tmp;
+		} else {
+			WARN_ON(ret);
+			break;
+		}
+	}
+
+exit:
+	ww_acquire_done(ww_ctx);
+}
+
+/**
+ * regulator_unlock_two - unlock two regulators
+ * @rdev1:		first regulator
+ * @rdev2:		second regulator
+ * @ww_ctx:		w/w mutex acquire context
+ *
+ * The inverse of regulator_lock_two().
+ */
+
+static void regulator_unlock_two(struct regulator_dev *rdev1,
+				 struct regulator_dev *rdev2,
+				 struct ww_acquire_ctx *ww_ctx)
+{
+	regulator_unlock(rdev2);
+	regulator_unlock(rdev1);
+	ww_acquire_fini(ww_ctx);
+}
+
 static bool regulator_supply_is_couple(struct regulator_dev *rdev)
 {
 	struct regulator_dev *c_rdev;
@@ -1419,8 +1491,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 
 /**
  * set_supply - set regulator supply regulator
- * @rdev: regulator name
- * @supply_rdev: supply regulator name
+ * @rdev: regulator (locked)
+ * @supply_rdev: supply regulator (locked))
  *
  * Called by platform initialisation code to set the supply regulator for this
  * regulator. This ensures that a regulators supply will also be enabled by the
@@ -1592,6 +1664,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	struct regulator *regulator;
 	int err = 0;
 
+	lockdep_assert_held_once(&rdev->mutex.base);
+
 	if (dev) {
 		char buf[REG_STR_SIZE];
 		int size;
@@ -1619,9 +1693,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	regulator->rdev = rdev;
 	regulator->supply_name = supply_name;
 
-	regulator_lock(rdev);
 	list_add(&regulator->list, &rdev->consumer_list);
-	regulator_unlock(rdev);
 
 	if (dev) {
 		regulator->dev = dev;
@@ -1787,6 +1859,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
 	struct device *dev = rdev->dev.parent;
+	struct ww_acquire_ctx ww_ctx;
 	int ret = 0;
 
 	/* No supply to resolve? */
@@ -1853,23 +1926,23 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	 * between rdev->supply null check and setting rdev->supply in
 	 * set_supply() from concurrent tasks.
 	 */
-	regulator_lock(rdev);
+	regulator_lock_two(rdev, r, &ww_ctx);
 
 	/* Supply just resolved by a concurrent task? */
 	if (rdev->supply) {
-		regulator_unlock(rdev);
+		regulator_unlock_two(rdev, r, &ww_ctx);
 		put_device(&r->dev);
 		goto out;
 	}
 
 	ret = set_supply(rdev, r);
 	if (ret < 0) {
-		regulator_unlock(rdev);
+		regulator_unlock_two(rdev, r, &ww_ctx);
 		put_device(&r->dev);
 		goto out;
 	}
 
-	regulator_unlock(rdev);
+	regulator_unlock_two(rdev, r, &ww_ctx);
 
 	/*
 	 * In set_machine_constraints() we may have turned this regulator on
@@ -1984,7 +2057,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		return regulator;
 	}
 
+	regulator_lock(rdev);
 	regulator = create_regulator(rdev, dev, id);
+	regulator_unlock(rdev);
 	if (regulator == NULL) {
 		regulator = ERR_PTR(-ENOMEM);
 		module_put(rdev->owner);
-- 
2.39.2



