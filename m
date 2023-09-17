Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE587A3D03
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbjIQUh4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbjIQUhv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:37:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3219610F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:37:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEC0C433C7;
        Sun, 17 Sep 2023 20:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983065;
        bh=bWbGOWnwMxCZIb+zq10IDmggmwnu1P7AzNrBcbhkYl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5+0WXVNQtIjZsxASvBTa3yrVxly7/QS+D531yjGsLDCRhWSCKVWLm2x6hfg65g9V
         F7TPU+XrwEZYLHmOoNO3KaLiRuRqWAF8y1PU/ECGEnUOPtJ7Cgg+03w8T5LdIiSsOq
         Cpv2PyV7m5FzM/Y8WCXSgSNEy8GINzfeFypiZs1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 417/511] Input: tca6416-keypad - always expect proper IRQ number in i2c client
Date:   Sun, 17 Sep 2023 21:14:04 +0200
Message-ID: <20230917191123.849175167@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 687fe7dfb736b03ab820d172ea5dbfc1ec447135 ]

Remove option having i2c client contain raw gpio number instead of proper
IRQ number. There are no users of this facility in mainline and it will
allow cleaning up the driver code with regard to wakeup handling, etc.

Link: https://lore.kernel.org/r/20230724053024.352054-1-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: cc141c35af87 ("Input: tca6416-keypad - fix interrupt enable disbalance")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/tca6416-keypad.c | 27 +++++++++----------------
 include/linux/tca6416_keypad.h          |  1 -
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 2a97559100652..d65afa25c2405 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -148,7 +148,7 @@ static int tca6416_keys_open(struct input_dev *dev)
 	if (chip->use_polling)
 		schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
 	else
-		enable_irq(chip->irqnum);
+		enable_irq(chip->client->irq);
 
 	return 0;
 }
@@ -160,7 +160,7 @@ static void tca6416_keys_close(struct input_dev *dev)
 	if (chip->use_polling)
 		cancel_delayed_work_sync(&chip->dwork);
 	else
-		disable_irq(chip->irqnum);
+		disable_irq(chip->client->irq);
 }
 
 static int tca6416_setup_registers(struct tca6416_keypad_chip *chip)
@@ -266,12 +266,7 @@ static int tca6416_keypad_probe(struct i2c_client *client,
 		goto fail1;
 
 	if (!chip->use_polling) {
-		if (pdata->irq_is_gpio)
-			chip->irqnum = gpio_to_irq(client->irq);
-		else
-			chip->irqnum = client->irq;
-
-		error = request_threaded_irq(chip->irqnum, NULL,
+		error = request_threaded_irq(client->irq, NULL,
 					     tca6416_keys_isr,
 					     IRQF_TRIGGER_FALLING |
 					     IRQF_ONESHOT | IRQF_NO_AUTOEN,
@@ -279,7 +274,7 @@ static int tca6416_keypad_probe(struct i2c_client *client,
 		if (error) {
 			dev_dbg(&client->dev,
 				"Unable to claim irq %d; error %d\n",
-				chip->irqnum, error);
+				client->irq, error);
 			goto fail1;
 		}
 	}
@@ -298,8 +293,8 @@ static int tca6416_keypad_probe(struct i2c_client *client,
 
 fail2:
 	if (!chip->use_polling) {
-		free_irq(chip->irqnum, chip);
-		enable_irq(chip->irqnum);
+		free_irq(client->irq, chip);
+		enable_irq(client->irq);
 	}
 fail1:
 	input_free_device(input);
@@ -312,8 +307,8 @@ static int tca6416_keypad_remove(struct i2c_client *client)
 	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
 	if (!chip->use_polling) {
-		free_irq(chip->irqnum, chip);
-		enable_irq(chip->irqnum);
+		free_irq(client->irq, chip);
+		enable_irq(client->irq);
 	}
 
 	input_unregister_device(chip->input);
@@ -326,10 +321,9 @@ static int tca6416_keypad_remove(struct i2c_client *client)
 static int tca6416_keypad_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(dev))
-		enable_irq_wake(chip->irqnum);
+		enable_irq_wake(client->irq);
 
 	return 0;
 }
@@ -337,10 +331,9 @@ static int tca6416_keypad_suspend(struct device *dev)
 static int tca6416_keypad_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(dev))
-		disable_irq_wake(chip->irqnum);
+		disable_irq_wake(client->irq);
 
 	return 0;
 }
diff --git a/include/linux/tca6416_keypad.h b/include/linux/tca6416_keypad.h
index b0d36a9934ccd..5cf6f6f82aa70 100644
--- a/include/linux/tca6416_keypad.h
+++ b/include/linux/tca6416_keypad.h
@@ -25,7 +25,6 @@ struct tca6416_keys_platform_data {
 	unsigned int rep:1;	/* enable input subsystem auto repeat */
 	uint16_t pinmask;
 	uint16_t invert;
-	int irq_is_gpio;
 	int use_polling;	/* use polling if Interrupt is not connected*/
 };
 #endif
-- 
2.40.1



