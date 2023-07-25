Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21A8761367
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjGYLKj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjGYLKP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36711FDE
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D8C615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF13C433C8;
        Tue, 25 Jul 2023 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283338;
        bh=j8cIg2zuCMp5vEDPceWHifQgVfsvXLI+m8rZq9GawUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmuokPg81xhiCxdEYXB7BxGgebivbMSg9oMGem1+l7kVFjNCG3MkJE5j0TEkJiLgV
         tPfoPGLwAtMZKFyHmvrxTVDhRuOrppQu3T3s8rJDPsYrvq/25y7iTlLguH7m+tTDKO
         TQaRtci6PpJV3SlL6aDjqx0YzLTtFUjrUk2QzEZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nik P <npliashechnikov@gmail.com>,
        Nathan Schulte <nmschulte@gmail.com>,
        Friedrich Vock <friedrich.vock@gmx.de>, dridri85@gmail.com,
        Jan Visser <starquake@linuxeverywhere.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 41/78] pinctrl: amd: Use amd_pinconf_set() for all config options
Date:   Tue, 25 Jul 2023 12:46:32 +0200
Message-ID: <20230725104452.893694917@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 635a750d958e158e17af0f524bedc484b27fbb93 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-amd.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 9dff866614d40..384d93146e1f5 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -189,18 +189,6 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
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
@@ -775,7 +763,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 }
 
 static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-				unsigned long *configs, unsigned num_configs)
+			   unsigned long *configs, unsigned int num_configs)
 {
 	int i;
 	u32 arg;
@@ -865,6 +853,20 @@ static int amd_pinconf_group_set(struct pinctrl_dev *pctldev,
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
-- 
2.39.2



