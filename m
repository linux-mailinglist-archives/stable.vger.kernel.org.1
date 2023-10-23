Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E907D3229
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjJWLRW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjJWLRW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:17:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A5A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:17:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5C8C433C7;
        Mon, 23 Oct 2023 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059840;
        bh=572KN/TaHGUt7ry0Hj3mLW1R5xRf7uXMeqCy64xxA7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMWYmQg7soQAPgnko7X9dctCcKHN6TdHFJn0VhafDokCee63Io65cVSB3RIx9Jq5v
         gYqZP9KdNp0Fk68QDEsMaOQq/pp56JkmJkGKeXhN8VKeaLcPoe8ZFeBZu/cbdzP8r7
         jyBudTCQ/W7HjwFCjJMeUYQGijrPlCIapDyHbsr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 71/98] gpio: timberdale: Fix potential deadlock on &tgpio->lock
Date:   Mon, 23 Oct 2023 12:57:00 +0200
Message-ID: <20231023104816.079759304@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit 9e8bc2dda5a7a8e2babc9975f4b11c9a6196e490 ]

As timbgpio_irq_enable()/timbgpio_irq_disable() callback could be
executed under irq context, it could introduce double locks on
&tgpio->lock if it preempts other execution units requiring
the same locks.

timbgpio_gpio_set()
--> timbgpio_update_bit()
--> spin_lock(&tgpio->lock)
<interrupt>
   --> timbgpio_irq_disable()
   --> spin_lock_irqsave(&tgpio->lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_irqsave()
on &tgpio->lock inside timbgpio_gpio_set() to prevent the possible
deadlock scenario.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-timberdale.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index 314e300d6ba33..1e6925c27ae29 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -55,9 +55,10 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 	unsigned offset, bool enabled)
 {
 	struct timbgpio *tgpio = gpiochip_get_data(gpio);
+	unsigned long flags;
 	u32 reg;
 
-	spin_lock(&tgpio->lock);
+	spin_lock_irqsave(&tgpio->lock, flags);
 	reg = ioread32(tgpio->membase + offset);
 
 	if (enabled)
@@ -66,7 +67,7 @@ static int timbgpio_update_bit(struct gpio_chip *gpio, unsigned index,
 		reg &= ~(1 << index);
 
 	iowrite32(reg, tgpio->membase + offset);
-	spin_unlock(&tgpio->lock);
+	spin_unlock_irqrestore(&tgpio->lock, flags);
 
 	return 0;
 }
-- 
2.40.1



