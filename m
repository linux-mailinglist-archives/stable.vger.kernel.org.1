Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34C07D1F75
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 22:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJUUUz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 16:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjJUUUz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 16:20:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37E8D5D
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 13:20:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292D8C433C9;
        Sat, 21 Oct 2023 20:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697919649;
        bh=DA9JoFrD9D5wnhRsBjMTyl5HXGAEUWDCJYVufddMy8k=;
        h=Subject:To:Cc:From:Date:From;
        b=gAL2oUPoqioeGwFbTQyZ94xsp+4ggQE7VDqmrT3nOVjvlgmQoc9kz4qRN0PyUBtBw
         Lp3S+nqw2bJfNzSupL+BNjqNuiHvJaE/R/F/H4FxZ/Mwv+CUgCksiRJLL3Uwi0ppGs
         1c/QDNq8OnloMAn9YCYIfQeW6CYA2poBw0hf2Yrw=
Subject: FAILED: patch "[PATCH] gpio: vf610: mask the gpio irq in system suspend and support" failed to apply to 4.14-stable tree
To:     haibo.chen@nxp.com, bartosz.golaszewski@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 21 Oct 2023 22:20:36 +0200
Message-ID: <2023102136-charity-deplored-163e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 430232619791e7de95191f2cd8ebaa4c380d17d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102136-charity-deplored-163e@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 430232619791e7de95191f2cd8ebaa4c380d17d0 Mon Sep 17 00:00:00 2001
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 17 Oct 2023 18:42:36 +0800
Subject: [PATCH] gpio: vf610: mask the gpio irq in system suspend and support
 wakeup

Add flag IRQCHIP_MASK_ON_SUSPEND to make sure gpio irq is masked on
suspend, if lack this flag, current irq arctitecture will not mask
the irq, and these unmasked gpio irq will wrongly wakeup the system
even they are not config as wakeup source.

Also add flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND to make sure the gpio
irq which is configed as wakeup source can work as expect.

Fixes: 7f2691a19627 ("gpio: vf610: add gpiolib/IRQ chip driver for Vybrid")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index dbc7ba0ee72c..d1f05810340f 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -246,7 +246,8 @@ static const struct irq_chip vf610_irqchip = {
 	.irq_unmask = vf610_gpio_irq_unmask,
 	.irq_set_type = vf610_gpio_irq_set_type,
 	.irq_set_wake = vf610_gpio_irq_set_wake,
-	.flags = IRQCHIP_IMMUTABLE,
+	.flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
+			| IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 

