Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B7675D47C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjGUTVl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjGUTVk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB92FED
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C3E61B24
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61797C433CA;
        Fri, 21 Jul 2023 19:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967298;
        bh=gF0PcjPSqRyyjOKZmcaYmDOIQbXy0FrBULCVutAziTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vcV+hDaufWLUD18SpavjXgeeWEBHV1AKcvlYeJta6Kp8DnCSZQGcE9l6pxs9oWfws
         Nuvf3LQkHv5frkthlksvJ2RZXXt+sAFbjjOxQADRKf/bWiLTxV90EPhUo0E8dGEVSx
         rtMOiReWaBhLidw97BwlPwuPr1xn8mReybyrJRTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nik P <npliashechnikov@gmail.com>,
        Nathan Schulte <nmschulte@gmail.com>,
        Friedrich Vock <friedrich.vock@gmx.de>, dridri85@gmail.com,
        Jan Visser <starquake@linuxeverywhere.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.1 085/223] pinctrl: amd: Use amd_pinconf_set() for all config options
Date:   Fri, 21 Jul 2023 18:05:38 +0200
Message-ID: <20230721160524.486584520@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 635a750d958e158e17af0f524bedc484b27fbb93 upstream.

On ASUS TUF A16 it is reported that the ITE5570 ACPI device connected to
GPIO 7 is causing an interrupt storm.  This issue doesn't happen on
Windows.

Comparing the GPIO register configuration between Windows and Linux
bit 20 has been configured as a pull up on Windows, but not on Linux.
Checking GPIO declaration from the firmware it is clear it *should* have
been a pull up on Linux as well.

```
GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
	 "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
{   // Pin list
0x0007
}
```

On Linux amd_gpio_set_config() is currently only used for programming
the debounce. Actually the GPIO core calls it with all the arguments
that are supported by a GPIO, pinctrl-amd just responds `-ENOTSUPP`.

To solve this issue expand amd_gpio_set_config() to support the other
arguments amd_pinconf_set() supports, namely `PIN_CONFIG_BIAS_PULL_DOWN`,
`PIN_CONFIG_BIAS_PULL_UP`, and `PIN_CONFIG_DRIVE_STRENGTH`.

Reported-by: Nik P <npliashechnikov@gmail.com>
Reported-by: Nathan Schulte <nmschulte@gmail.com>
Reported-by: Friedrich Vock <friedrich.vock@gmx.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217336
Reported-by: dridri85@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217493
Link: https://lore.kernel.org/linux-input/20230530154058.17594-1-friedrich.vock@gmx.de/
Tested-by: Jan Visser <starquake@linuxeverywhere.org>
Fixes: 2956b5d94a76 ("pinctrl / gpio: Introduce .set_config() callback for GPIO chips")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230705133005.577-3-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -188,18 +188,6 @@ static int amd_gpio_set_debounce(struct
 	return ret;
 }
 
-static int amd_gpio_set_config(struct gpio_chip *gc, unsigned offset,
-			       unsigned long config)
-{
-	u32 debounce;
-
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
-	debounce = pinconf_to_config_argument(config);
-	return amd_gpio_set_debounce(gc, offset, debounce);
-}
-
 #ifdef CONFIG_DEBUG_FS
 static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 {
@@ -782,7 +770,7 @@ static int amd_pinconf_get(struct pinctr
 }
 
 static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-				unsigned long *configs, unsigned num_configs)
+			   unsigned long *configs, unsigned int num_configs)
 {
 	int i;
 	u32 arg;
@@ -872,6 +860,20 @@ static int amd_pinconf_group_set(struct
 	return 0;
 }
 
+static int amd_gpio_set_config(struct gpio_chip *gc, unsigned int pin,
+			       unsigned long config)
+{
+	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
+
+	if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
+		u32 debounce = pinconf_to_config_argument(config);
+
+		return amd_gpio_set_debounce(gc, pin, debounce);
+	}
+
+	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
+}
+
 static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_get		= amd_pinconf_get,
 	.pin_config_set		= amd_pinconf_set,


