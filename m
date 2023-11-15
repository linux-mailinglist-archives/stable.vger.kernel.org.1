Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A187ED113
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344000AbjKOT7S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjKOT7Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:59:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C032AB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:59:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40471C433CA;
        Wed, 15 Nov 2023 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078353;
        bh=p6UImNN3o0sv0NpFpPjnyORToN15vbP/A7ST6iFyTYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLAk/reA8FtKzEUen5kt5TLJDea4DGwRNrGQ8nMX5ndPgLoCZ2uNtRrMJUlStKrzK
         psIfk9MqkoxeL5i3FlCcsoV/HpTUABa0wG5gEx9y+82npwM9jl97RsA3gcd5Jw+Vat
         NaLTHHmzODkgdGMRW2R0klyVVrs3f3hCG3wFD1bM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 246/379] leds: turris-omnia: Drop unnecessary mutex locking
Date:   Wed, 15 Nov 2023 14:25:21 -0500
Message-ID: <20231115192659.687857179@linuxfoundation.org>
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
index c7c9851c894a9..b86ddab33eece 100644
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



