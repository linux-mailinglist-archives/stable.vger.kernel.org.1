Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9397ECC8B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjKOTbK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjKOTbJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:31:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3F912C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:31:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3F3C433C9;
        Wed, 15 Nov 2023 19:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076665;
        bh=9TtzI1E8ZdjRsIexJ/byIIDE+A4FOM4LIzfcXaZaiMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYQ11kLuxQmG9Y7Im1NicTQ9St9YA0WLMxKloOkpCLfR6DUInJnxmxGlOH6sXRtGy
         wsJPTaY8FZQa1GVdvUIz9bPDiXlMfU9jB+5KupzAGvUb9jc+EbdKUvkUwmot+sHQp4
         WCosLGk9oUnWKUl3nGZcW/uBPJeONT/aXr8ZmrPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 371/550] leds: turris-omnia: Drop unnecessary mutex locking
Date:   Wed, 15 Nov 2023 14:15:55 -0500
Message-ID: <20231115191626.542832751@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 760b6b7925bf09491aafa4727eef74fc6bf738b0 ]

Do not lock driver mutex in the global LED panel brightness sysfs
accessors brightness_show() and brightness_store().

The mutex locking is unnecessary here. The I2C transfers are guarded by
I2C core locking mechanism, and the LED commands itself do not interfere
with other commands.

Fixes: 089381b27abe ("leds: initial support for Turris Omnia LEDs")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230802160748.11208-2-kabel@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 6de283b96b31 ("leds: turris-omnia: Do not use SMBUS calls")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-turris-omnia.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/leds/leds-turris-omnia.c b/drivers/leds/leds-turris-omnia.c
index 64b2d7b6d3f31..bbd610100e418 100644
--- a/drivers/leds/leds-turris-omnia.c
+++ b/drivers/leds/leds-turris-omnia.c
@@ -156,12 +156,9 @@ static ssize_t brightness_show(struct device *dev, struct device_attribute *a,
 			       char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct omnia_leds *leds = i2c_get_clientdata(client);
 	int ret;
 
-	mutex_lock(&leds->lock);
 	ret = i2c_smbus_read_byte_data(client, CMD_LED_GET_BRIGHTNESS);
-	mutex_unlock(&leds->lock);
 
 	if (ret < 0)
 		return ret;
@@ -173,7 +170,6 @@ static ssize_t brightness_store(struct device *dev, struct device_attribute *a,
 				const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct omnia_leds *leds = i2c_get_clientdata(client);
 	unsigned long brightness;
 	int ret;
 
@@ -183,15 +179,10 @@ static ssize_t brightness_store(struct device *dev, struct device_attribute *a,
 	if (brightness > 100)
 		return -EINVAL;
 
-	mutex_lock(&leds->lock);
 	ret = i2c_smbus_write_byte_data(client, CMD_LED_SET_BRIGHTNESS,
 					(u8)brightness);
-	mutex_unlock(&leds->lock);
-
-	if (ret < 0)
-		return ret;
 
-	return count;
+	return ret < 0 ? ret : count;
 }
 static DEVICE_ATTR_RW(brightness);
 
-- 
2.42.0



