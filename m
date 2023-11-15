Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14F17ED114
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbjKOT7T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbjKOT7S (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:59:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6B6B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:59:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6F0C433C9;
        Wed, 15 Nov 2023 19:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078354;
        bh=dRNJXJ5Z75x6YYtQWgIvptLoj7D5k2Et7qCQ/NL6O1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLgLtmVSL78TMHEoAdKRQWuXSdVH1u8WyL648tx8jxb4RI3KIBhxSASlw3BfEPrxu
         VuwPRhhx0+/PuKd9MY7im8pnMskKiaGqLpHmxx/4ivI9D3LkenplIvAbY6Zp7eJKKD
         oPOw8rNG9NybvgpacCrupcOUXAzvqq5/4PR8kHrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 247/379] leds: turris-omnia: Do not use SMBUS calls
Date:   Wed, 15 Nov 2023 14:25:22 -0500
Message-ID: <20231115192659.743986940@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 6de283b96b31b4890e3ee8c86caca2a3a30d1011 ]

The leds-turris-omnia driver uses three function for I2C access:
- i2c_smbus_write_byte_data() and i2c_smbus_read_byte_data(), which
  cause an emulated SMBUS transfer,
- i2c_master_send(), which causes an ordinary I2C transfer.

The Turris Omnia MCU LED controller is not semantically SMBUS, it
operates as a simple I2C bus. It does not implement any of the SMBUS
specific features, like PEC, or procedure calls, or anything. Moreover
the I2C controller driver also does not implement SMBUS, and so the
emulated SMBUS procedure from drivers/i2c/i2c-core-smbus.c is used for
the SMBUS calls, which gives an unnecessary overhead.

When I first wrote the driver, I was unaware of these facts, and I
simply used the first function that worked.

Drop the I2C SMBUS calls and instead use simple I2C transfers.

Fixes: 089381b27abe ("leds: initial support for Turris Omnia LEDs")
Signed-off-by: Marek Behún <kabel@kernel.org>
Link: https://lore.kernel.org/r/20230918161104.20860-2-kabel@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-turris-omnia.c | 54 +++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-turris-omnia.c b/drivers/leds/leds-turris-omnia.c
index b86ddab33eece..179eb243da2f6 100644
--- a/drivers/leds/leds-turris-omnia.c
+++ b/drivers/leds/leds-turris-omnia.c
@@ -2,7 +2,7 @@
 /*
  * CZ.NIC's Turris Omnia LEDs driver
  *
- * 2020 by Marek Behún <kabel@kernel.org>
+ * 2020, 2023 by Marek Behún <kabel@kernel.org>
  */
 
 #include <linux/i2c.h>
@@ -41,6 +41,37 @@ struct omnia_leds {
 	struct omnia_led leds[];
 };
 
+static int omnia_cmd_write_u8(const struct i2c_client *client, u8 cmd, u8 val)
+{
+	u8 buf[2] = { cmd, val };
+
+	return i2c_master_send(client, buf, sizeof(buf));
+}
+
+static int omnia_cmd_read_u8(const struct i2c_client *client, u8 cmd)
+{
+	struct i2c_msg msgs[2];
+	u8 reply;
+	int ret;
+
+	msgs[0].addr = client->addr;
+	msgs[0].flags = 0;
+	msgs[0].len = 1;
+	msgs[0].buf = &cmd;
+	msgs[1].addr = client->addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = 1;
+	msgs[1].buf = &reply;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (likely(ret == ARRAY_SIZE(msgs)))
+		return reply;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
 static int omnia_led_brightness_set_blocking(struct led_classdev *cdev,
 					     enum led_brightness brightness)
 {
@@ -64,7 +95,7 @@ static int omnia_led_brightness_set_blocking(struct led_classdev *cdev,
 	if (buf[2] || buf[3] || buf[4])
 		state |= CMD_LED_STATE_ON;
 
-	ret = i2c_smbus_write_byte_data(leds->client, CMD_LED_STATE, state);
+	ret = omnia_cmd_write_u8(leds->client, CMD_LED_STATE, state);
 	if (ret >= 0 && (state & CMD_LED_STATE_ON))
 		ret = i2c_master_send(leds->client, buf, 5);
 
@@ -114,9 +145,9 @@ static int omnia_led_register(struct i2c_client *client, struct omnia_led *led,
 	cdev->brightness_set_blocking = omnia_led_brightness_set_blocking;
 
 	/* put the LED into software mode */
-	ret = i2c_smbus_write_byte_data(client, CMD_LED_MODE,
-					CMD_LED_MODE_LED(led->reg) |
-					CMD_LED_MODE_USER);
+	ret = omnia_cmd_write_u8(client, CMD_LED_MODE,
+				 CMD_LED_MODE_LED(led->reg) |
+				 CMD_LED_MODE_USER);
 	if (ret < 0) {
 		dev_err(dev, "Cannot set LED %pOF to software mode: %i\n", np,
 			ret);
@@ -124,8 +155,8 @@ static int omnia_led_register(struct i2c_client *client, struct omnia_led *led,
 	}
 
 	/* disable the LED */
-	ret = i2c_smbus_write_byte_data(client, CMD_LED_STATE,
-					CMD_LED_STATE_LED(led->reg));
+	ret = omnia_cmd_write_u8(client, CMD_LED_STATE,
+				 CMD_LED_STATE_LED(led->reg));
 	if (ret < 0) {
 		dev_err(dev, "Cannot set LED %pOF brightness: %i\n", np, ret);
 		return ret;
@@ -158,7 +189,7 @@ static ssize_t brightness_show(struct device *dev, struct device_attribute *a,
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(client, CMD_LED_GET_BRIGHTNESS);
+	ret = omnia_cmd_read_u8(client, CMD_LED_GET_BRIGHTNESS);
 
 	if (ret < 0)
 		return ret;
@@ -179,8 +210,7 @@ static ssize_t brightness_store(struct device *dev, struct device_attribute *a,
 	if (brightness > 100)
 		return -EINVAL;
 
-	ret = i2c_smbus_write_byte_data(client, CMD_LED_SET_BRIGHTNESS,
-					(u8)brightness);
+	ret = omnia_cmd_write_u8(client, CMD_LED_SET_BRIGHTNESS, brightness);
 
 	return ret < 0 ? ret : count;
 }
@@ -238,8 +268,8 @@ static void omnia_leds_remove(struct i2c_client *client)
 	u8 buf[5];
 
 	/* put all LEDs into default (HW triggered) mode */
-	i2c_smbus_write_byte_data(client, CMD_LED_MODE,
-				  CMD_LED_MODE_LED(OMNIA_BOARD_LEDS));
+	omnia_cmd_write_u8(client, CMD_LED_MODE,
+			   CMD_LED_MODE_LED(OMNIA_BOARD_LEDS));
 
 	/* set all LEDs color to [255, 255, 255] */
 	buf[0] = CMD_LED_COLOR;
-- 
2.42.0



