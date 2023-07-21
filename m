Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D20475D478
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjGUTVf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjGUTVd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3278B30F1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA2261B24
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21B8C433C8;
        Fri, 21 Jul 2023 19:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967284;
        bh=ZuR7ks4lBmY8dy1kOwpq48U15G2f5gp7Ivorv0FyQdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iioqHh3cnzWyhribbSc1gUcOJGQYGUUouywMIeHtzxL17D4pYkULAK6R4t3WsuNF5
         e1rpm2XRN4KwElem4+TG4nhuuiAyQlUegynByUEmYxUgthKYop+DjfuM3kxWm1qWW1
         0UXhccD406xmBpOrcJcndgP1ucO8opTmgMVm5z1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.1 080/223] pinctrl: amd: Detect internal GPIO0 debounce handling
Date:   Fri, 21 Jul 2023 18:05:33 +0200
Message-ID: <20230721160524.273614461@linuxfoundation.org>
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

commit 968ab9261627fa305307e3935ca1a32fcddd36cb upstream.

commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe")
had a mistake in loop iteration 63 that it would clear offset 0xFC instead
of 0x100.  Offset 0xFC is actually `WAKE_INT_MASTER_REG`.  This was
clearing bits 13 and 15 from the register which significantly changed the
expected handling for some platforms for GPIO0.

commit b26cd9325be4 ("pinctrl: amd: Disable and mask interrupts on resume")
actually fixed this bug, but lead to regressions on Lenovo Z13 and some
other systems.  This is because there was no handling in the driver for bit
15 debounce behavior.

Quoting a public BKDG:
```
EnWinBlueBtn. Read-write. Reset: 0. 0=GPIO0 detect debounced power button;
Power button override is 4 seconds. 1=GPIO0 detect debounced power button
in S3/S5/S0i3, and detect "pressed less than 2 seconds" and "pressed 2~10
seconds" in S0; Power button override is 10 seconds
```

Cross referencing the same master register in Windows it's obvious that
Windows doesn't use debounce values in this configuration.  So align the
Linux driver to do this as well.  This fixes wake on lid when
WAKE_INT_MASTER_REG is properly programmed.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217315
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230421120625.3366-2-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |    7 +++++++
 drivers/pinctrl/pinctrl-amd.h |    1 +
 2 files changed, 8 insertions(+)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -125,6 +125,12 @@ static int amd_gpio_set_debounce(struct
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
 
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+
+	/* Use special handling for Pin0 debounce */
+	pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
+	if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
+		debounce = 0;
+
 	pin_reg = readl(gpio_dev->base + offset * 4);
 
 	if (debounce) {
@@ -219,6 +225,7 @@ static void amd_gpio_dbg_show(struct seq
 	char *debounce_enable;
 	char *wake_cntrlz;
 
+	seq_printf(s, "WAKE_INT_MASTER_REG: 0x%08x\n", readl(gpio_dev->base + WAKE_INT_MASTER_REG));
 	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
 		unsigned int time = 0;
 		unsigned int unit = 0;
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -17,6 +17,7 @@
 #define AMD_GPIO_PINS_BANK3     32
 
 #define WAKE_INT_MASTER_REG 0xfc
+#define INTERNAL_GPIO0_DEBOUNCE (1 << 15)
 #define EOI_MASK (1 << 29)
 
 #define WAKE_INT_STATUS_REG0 0x2f8


