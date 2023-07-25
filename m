Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A002761722
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjGYLpL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjGYLpD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5518A113
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDDFF616A2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4E7C433C8;
        Tue, 25 Jul 2023 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285501;
        bh=noq6MioyBZswbohKMadunN4wbOs+A6HrgOxPb4zLcU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rp7OSWYCmMBTVimdAPRN56hG2LyrVieV+NQ72MO5OQWnnvZ5XW4j/2o7OvyS9BCh1
         bOy/6NHTBBAb+nWVO4uwdv6yEelrRPlcwtlmc/6sLRGzEGDJua0qSB5Cc+BkXw+zzC
         Y9+n4l0OjSb6Bph92F4KgXK88vmMX9VrXCd8V5E8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.4 228/313] pinctrl: amd: Detect internal GPIO0 debounce handling
Date:   Tue, 25 Jul 2023 12:46:21 +0200
Message-ID: <20230725104530.914774971@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
@@ -123,6 +123,12 @@ static int amd_gpio_set_debounce(struct
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
@@ -212,6 +218,7 @@ static void amd_gpio_dbg_show(struct seq
 	char *output_value;
 	char *output_enable;
 
+	seq_printf(s, "WAKE_INT_MASTER_REG: 0x%08x\n", readl(gpio_dev->base + WAKE_INT_MASTER_REG));
 	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
 		seq_printf(s, "GPIO bank%d\t", bank);
 
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -17,6 +17,7 @@
 #define AMD_GPIO_PINS_BANK3     32
 
 #define WAKE_INT_MASTER_REG 0xfc
+#define INTERNAL_GPIO0_DEBOUNCE (1 << 15)
 #define EOI_MASK (1 << 29)
 
 #define WAKE_INT_STATUS_REG0 0x2f8


