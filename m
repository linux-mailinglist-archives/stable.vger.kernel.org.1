Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26CD7A3C91
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbjIQUdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbjIQUch (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:32:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0166F116
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:32:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9974C43397;
        Sun, 17 Sep 2023 20:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982731;
        bh=+NCsc/jLzTdVd9HBKtyxGMjKBIi1rg3gPnT4vbch1Fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/wqHNOT8Cf+k8t6I8/0ft9DF15qfVUl7rECYAFY111dfzh/nM95vwZmXBozeOGKq
         KUIWPRuUqBixJZSVr+FXEXf3ifORhJLb+WkKYs4hRBbMyaPbPUaLjIdKncrbZtYgYw
         lpWmCZeWnaSIi26yroXjG+8DcpMT4PSvQFnfBu1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 309/511] leds: trigger: tty: Do not use LED_ON/OFF constants, use led_blink_set_oneshot instead
Date:   Sun, 17 Sep 2023 21:12:16 +0200
Message-ID: <20230917191121.287912094@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 730094577e0c37e1bc40be37cbd41f71b0a8a2a4 ]

The tty LED trigger uses the obsolete LED_ON & LED_OFF constants when
setting LED brightness. This is bad because the LED_ON constant is equal
to 1, and so when activating the tty LED trigger on a LED class device
with max_brightness greater than 1, the LED is dimmer than it can be
(when max_brightness is 255, the LED is very dimm indeed; some devices
translate 1/255 to 0, so the LED is OFF all the time).

Instead of directly setting brightness to a specific value, use the
led_blink_set_oneshot() function from LED core to configure the blink.
This function takes the current configured brightness as blink
brightness if not zero, and max brightness otherwise.

This also changes the behavior of the TTY LED trigger. Previously if
rx/tx stats kept changing, the LED was ON all the time they kept
changing. With this patch the LED will blink on TTY activity.

Fixes: fd4a641ac88f ("leds: trigger: implement a tty trigger")
Signed-off-by: Marek Behún <kabel@kernel.org>
Link: https://lore.kernel.org/r/20230802090753.13611-1-kabel@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/trigger/ledtrig-tty.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
index f62db7e520b52..8ae0d2d284aff 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -7,6 +7,8 @@
 #include <linux/tty.h>
 #include <uapi/linux/serial.h>
 
+#define LEDTRIG_TTY_INTERVAL	50
+
 struct ledtrig_tty_data {
 	struct led_classdev *led_cdev;
 	struct delayed_work dwork;
@@ -122,17 +124,19 @@ static void ledtrig_tty_work(struct work_struct *work)
 
 	if (icount.rx != trigger_data->rx ||
 	    icount.tx != trigger_data->tx) {
-		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
+		unsigned long interval = LEDTRIG_TTY_INTERVAL;
+
+		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
+				      &interval, 0);
 
 		trigger_data->rx = icount.rx;
 		trigger_data->tx = icount.tx;
-	} else {
-		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
 	}
 
 out:
 	mutex_unlock(&trigger_data->mutex);
-	schedule_delayed_work(&trigger_data->dwork, msecs_to_jiffies(100));
+	schedule_delayed_work(&trigger_data->dwork,
+			      msecs_to_jiffies(LEDTRIG_TTY_INTERVAL * 2));
 }
 
 static struct attribute *ledtrig_tty_attrs[] = {
-- 
2.40.1



