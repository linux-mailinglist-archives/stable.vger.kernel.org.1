Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58CE755256
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGPUGp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjGPUGo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C71E71
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF70260EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED77BC433C7;
        Sun, 16 Jul 2023 20:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537997;
        bh=LIcEAnNH69o9qLl0PIVTrlKQQJQ+EothrVxaTcUAPT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFXF9Ggn+dy/b1M1lW5/ZEe921NlaR3JWAJc0Zl/tdcTZA8Rrv6BPhQdIuh8yfgW1
         dBzLeNjpDQWOs0YVn+aYLXmM9H61lAS8G3bUT49duAQAN7k/z8YF0EVwLgd8GVg73r
         plRAT6gn0conxDYxIUgFSA5sPLN6siAoDLD1/eXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 295/800] ARM: omap2: Get USB hub reset GPIO from descriptor
Date:   Sun, 16 Jul 2023 21:42:28 +0200
Message-ID: <20230716194955.934271857@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 94075d16beefc2304e756e3b23d8ecf0f36eecd7 ]

This switches the USB hub GPIO reset line handling in the
OMAP2 pdata quirks over to using GPIO descriptors to avoid using
the global GPIO numberspace.

Since the GPIOs are exported and assumedly used by some kind
of userspace we cannot simply use hogs in the device tree.

Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/pdata-quirks.c | 50 ++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index c363ad8d6a06c..3264c4e77a8aa 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -98,31 +98,43 @@ static struct iommu_platform_data omap3_iommu_isp_pdata = {
 };
 #endif
 
-static void __init omap3_sbc_t3x_usb_hub_init(int gpio, char *hub_name)
+static void __init omap3_sbc_t3x_usb_hub_init(char *hub_name, int idx)
 {
-	int err = gpio_request_one(gpio, GPIOF_OUT_INIT_LOW, hub_name);
+	struct gpio_desc *d;
 
-	if (err) {
-		pr_err("SBC-T3x: %s reset gpio request failed: %d\n",
-			hub_name, err);
+	/* This asserts the RESET line (reverse polarity) */
+	d = gpiod_get_index(NULL, "reset", idx, GPIOD_OUT_HIGH);
+	if (IS_ERR(d)) {
+		pr_err("Unable to get T3x USB reset GPIO descriptor\n");
 		return;
 	}
-
-	gpiod_export(gpio_to_desc(gpio), 0);
-
+	gpiod_set_consumer_name(d, hub_name);
+	gpiod_export(d, 0);
 	udelay(10);
-	gpio_set_value(gpio, 1);
+	/* De-assert RESET */
+	gpiod_set_value(d, 0);
 	msleep(1);
 }
 
+static struct gpiod_lookup_table omap3_sbc_t3x_usb_gpio_table = {
+	.dev_id = NULL,
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-160-175", 7, "reset", 0,
+				GPIO_ACTIVE_LOW),
+		{ }
+	},
+};
+
 static void __init omap3_sbc_t3730_legacy_init(void)
 {
-	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
+	gpiod_add_lookup_table(&omap3_sbc_t3x_usb_gpio_table);
+	omap3_sbc_t3x_usb_hub_init("sb-t35 usb hub", 0);
 }
 
 static void __init omap3_sbc_t3530_legacy_init(void)
 {
-	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
+	gpiod_add_lookup_table(&omap3_sbc_t3x_usb_gpio_table);
+	omap3_sbc_t3x_usb_hub_init("sb-t35 usb hub", 0);
 }
 
 static void __init omap3_evm_legacy_init(void)
@@ -187,10 +199,22 @@ static void __init omap3_sbc_t3517_wifi_init(void)
 	gpio_set_value(cm_t3517_wlan_gpios[1].gpio, 0);
 }
 
+static struct gpiod_lookup_table omap3_sbc_t3517_usb_gpio_table = {
+	.dev_id = NULL,
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-144-159", 8, "reset", 0,
+				GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-96-111", 2, "reset", 1,
+				GPIO_ACTIVE_LOW),
+		{ }
+	},
+};
+
 static void __init omap3_sbc_t3517_legacy_init(void)
 {
-	omap3_sbc_t3x_usb_hub_init(152, "cm-t3517 usb hub");
-	omap3_sbc_t3x_usb_hub_init(98, "sb-t35 usb hub");
+	gpiod_add_lookup_table(&omap3_sbc_t3517_usb_gpio_table);
+	omap3_sbc_t3x_usb_hub_init("cm-t3517 usb hub", 0);
+	omap3_sbc_t3x_usb_hub_init("sb-t35 usb hub", 1);
 	am35xx_emac_reset();
 	hsmmc2_internal_input_clk();
 	omap3_sbc_t3517_wifi_init();
-- 
2.39.2



