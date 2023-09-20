Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56C37A7F32
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbjITMZX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbjITMYx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:24:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3305D93
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:24:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA96C433C8;
        Wed, 20 Sep 2023 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212686;
        bh=NGekS0xDnCyQl7wxL31Ke9ZgaDVvt4Zmkr04yauabig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOk4LlI1oHq4YHDGH7KVoKRWn1yaUxfklI5WLxxhX8JdP9KjCbC6/+02EAh0uHcXv
         aW9BBA6CbD8absx3MPvvbihB07oRhn97psf2cvDIVhcWoXn8oOUI6bGBZx6mqd17IX
         m5zGg97sR8yXYWvDoUOfOn2FKfKIqFQ4WNq05NCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5.4 002/367] ARM: pxa: remove use of symbol_get()
Date:   Wed, 20 Sep 2023 13:26:19 +0200
Message-ID: <20230920112858.545327597@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 0faa29c4207e6e29cfc81b427df60e326c37083a upstream.

The spitz board file uses the obscure symbol_get() function
to optionally call a function from sharpsl_pm.c if that is
built. However, the two files are always built together
these days, and have been for a long time, so this can
be changed to a normal function call.

Link: https://lore.kernel.org/lkml/20230731162639.GA9441@lst.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-pxa/sharpsl_pm.c |    2 --
 arch/arm/mach-pxa/spitz.c      |   14 +-------------
 2 files changed, 1 insertion(+), 15 deletions(-)

--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -220,8 +220,6 @@ void sharpsl_battery_kick(void)
 {
 	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(125));
 }
-EXPORT_SYMBOL(sharpsl_battery_kick);
-
 
 static void sharpsl_battery_thread(struct work_struct *private_)
 {
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>	/* symbol_get ; symbol_put */
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio_keys.h>
@@ -514,17 +513,6 @@ static struct pxa2xx_spi_chip spitz_ads7
 	.gpio_cs		= SPITZ_GPIO_ADS7846_CS,
 };
 
-static void spitz_bl_kick_battery(void)
-{
-	void (*kick_batt)(void);
-
-	kick_batt = symbol_get(sharpsl_battery_kick);
-	if (kick_batt) {
-		kick_batt();
-		symbol_put(sharpsl_battery_kick);
-	}
-}
-
 static struct corgi_lcd_platform_data spitz_lcdcon_info = {
 	.init_mode		= CORGI_LCD_MODE_VGA,
 	.max_intensity		= 0x2f,
@@ -532,7 +520,7 @@ static struct corgi_lcd_platform_data sp
 	.limit_mask		= 0x0b,
 	.gpio_backlight_cont	= SPITZ_GPIO_BACKLIGHT_CONT,
 	.gpio_backlight_on	= SPITZ_GPIO_BACKLIGHT_ON,
-	.kick_battery		= spitz_bl_kick_battery,
+	.kick_battery		= sharpsl_battery_kick,
 };
 
 static struct pxa2xx_spi_chip spitz_lcdcon_chip = {


