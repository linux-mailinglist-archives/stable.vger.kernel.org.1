Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD2175CDD3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjGUQPG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjGUQOo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:14:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE02C44AD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADD5361D25
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF26FC433C9;
        Fri, 21 Jul 2023 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956053;
        bh=2N1swfv0yeoWmXRt8o0iDY3CB+DCgec6DsiRr6E1PsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmEqBH92lHl7tEVCYCY9veDE+2FqqFU4y5f8FH8Sp2j+kAVq+YVv12aG01V5Y1qe5
         y+7bCc5Xvxmiywgj4aKc7ezKpEjZ0bOLE77k+9X7E3R+1jxxbBnldCHB/Qa20qvp22
         QWRfL+roVbqrTLbVDk7WwoJxk7tTjZERqsWOzZSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.4 117/292] pinctrl: amd: Detect and mask spurious interrupts
Date:   Fri, 21 Jul 2023 18:03:46 +0200
Message-ID: <20230721160533.855195002@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kornel Dulęba <korneld@chromium.org>

commit 0cf9e48ff22e15f3f0882991f33d23ccc5ae1d01 upstream.

Leverage gpiochip_line_is_irq to check whether a pin has an irq
associated with it. The previous check ("irq == 0") didn't make much
sense. The irq variable refers to the pinctrl irq, and has nothing do to
with an individual pin.

On some systems, during suspend/resume cycle, the firmware leaves
an interrupt enabled on a pin that is not used by the kernel.
Without this patch that caused an interrupt storm.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217315
Signed-off-by: Kornel Dulęba <korneld@chromium.org>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230421120625.3366-4-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -660,21 +660,21 @@ static bool do_amd_gpio_irq_handler(int
 			 * We must read the pin register again, in case the
 			 * value was changed while executing
 			 * generic_handle_domain_irq() above.
-			 * If we didn't find a mapping for the interrupt,
-			 * disable it in order to avoid a system hang caused
-			 * by an interrupt storm.
+			 * If the line is not an irq, disable it in order to
+			 * avoid a system hang caused by an interrupt storm.
 			 */
 			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 			regval = readl(regs + i);
-			if (irq == 0) {
-				regval &= ~BIT(INTERRUPT_ENABLE_OFF);
+			if (!gpiochip_line_is_irq(gc, irqnr + i)) {
+				regval &= ~BIT(INTERRUPT_MASK_OFF);
 				dev_dbg(&gpio_dev->pdev->dev,
 					"Disabling spurious GPIO IRQ %d\n",
 					irqnr + i);
+			} else {
+				ret = true;
 			}
 			writel(regval, regs + i);
 			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-			ret = true;
 		}
 	}
 	/* did not cause wake on resume context for shared IRQ */


