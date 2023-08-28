Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8456C78AAA1
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjH1KXw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjH1KXY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:23:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AFEC6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 801E163989
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D15C433C7;
        Mon, 28 Aug 2023 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218201;
        bh=JYasjmn6ea2/yAzlN9xhTVK7asF3Xtx7/5zimhyptM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQyKE7+jg/E8Ly8z8Fv6NMrPAoB1DK8GlhrQeQhDgN5psnzUzpB1m7Aq63j2jP5OU
         z6Vo6PFlCWa9QB6b29qDLnlIMXUrJDmxgMTtgHEZLA1MqXl8uWaDez1i8okuDa5lQN
         RsKs5DV8yEE5Iev/E8rUxvd1hLRefEydPiernE5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sachi King <nakato@nakato.io>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Shubhra Prakash Nandi <email2shubhra@gmail.com>,
        Carsten Hatger <xmb8dsv4@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.4 105/129] pinctrl: amd: Mask wake bits on probe again
Date:   Mon, 28 Aug 2023 12:13:04 +0200
Message-ID: <20230828101200.855541246@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 6bc3462a0f5ecaa376a0b3d76dafc55796799e17 upstream.

Shubhra reports that their laptop is heating up over s2idle. Even though
it's getting into the deepest state, it appears to be having spurious
wakeup events.

While debugging a tangential issue with the RTC Carsten reports that recent
6.1.y based kernel face a similar problem.

Looking at acpidump and GPIO register comparisons these spurious wakeup
events are from the GPIO associated with the I2C touchpad on both laptops
and occur even when the touchpad is not marked as a wake source by the
kernel.

This means that the boot firmware has programmed these bits and because
Linux didn't touch them lead to spurious wakeup events from that GPIO.

To fix this issue, restore most of the code that previously would clear all
the bits associated with wakeup sources. This will allow the kernel to only
program the wake up sources that are necessary.

This is similar to what was done previously; but only the wake bits are
cleared by default instead of interrupts and wake bits.  If any other
problems are reported then it may make sense to clear interrupts again too.

Cc: Sachi King <nakato@nakato.io>
Cc: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Fixes: 65f6c7c91cb2 ("pinctrl: amd: Revert "pinctrl: amd: disable and mask interrupts on probe"")
Reported-by: Shubhra Prakash Nandi <email2shubhra@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217754
Reported-by: Carsten Hatger <xmb8dsv4@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217626#c28
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230818144850.1439-1-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -862,6 +862,33 @@ static const struct pinconf_ops amd_pinc
 	.pin_config_group_set = amd_pinconf_group_set,
 };
 
+static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
+{
+	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	unsigned long flags;
+	u32 pin_reg, mask;
+	int i;
+
+	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3) |
+		BIT(WAKE_CNTRL_OFF_S4);
+
+	for (i = 0; i < desc->npins; i++) {
+		int pin = desc->pins[i].number;
+		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
+
+		if (!pd)
+			continue;
+
+		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+
+		pin_reg = readl(gpio_dev->base + pin * 4);
+		pin_reg &= ~mask;
+		writel(pin_reg, gpio_dev->base + pin * 4);
+
+		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+	}
+}
+
 #ifdef CONFIG_PM_SLEEP
 static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 {
@@ -1099,6 +1126,9 @@ static int amd_gpio_probe(struct platfor
 		return PTR_ERR(gpio_dev->pctrl);
 	}
 
+	/* Disable and mask interrupts */
+	amd_gpio_irq_init(gpio_dev);
+
 	girq = &gpio_dev->gc.irq;
 	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
 	/* This will let us handle the parent IRQ in the driver */


