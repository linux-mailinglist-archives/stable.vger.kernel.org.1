Return-Path: <stable+bounces-2156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572BE7F8303
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F0C1C248E5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B3364AE;
	Fri, 24 Nov 2023 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fJeO809G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAF2E64F;
	Fri, 24 Nov 2023 19:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE737C433C7;
	Fri, 24 Nov 2023 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853187;
	bh=fLGzfDhG0jRl9Bh2RN9Ww6ufGxLaxIqh2S6WfteR8Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJeO809Gdi10vyRhAz4Iq75U/1T52ZWMecLPH2bJpxUv/YRyEowgbk3Z4p7gnE8XU
	 CEi2kqi2WZTPAJnydE3+vrD624NMYJk6e81jafICmGxiTMzEIvFbe5ksG6GrLTRBQQ
	 xDROJii5fCN2s6VuDU12cwOShjreMUOW8Rx8vTDI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 089/297] gpio: Dont fiddle with irqchips marked as immutable
Date: Fri, 24 Nov 2023 17:52:11 +0000
Message-ID: <20231124172003.364278246@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 6c846d026d490b2383d395bc8e7b06336219667b ]

In order to move away from gpiolib messing with the internals of
unsuspecting irqchips, add a flag by which irqchips advertise
that they are not to be messed with, and do solemnly swear that
they correctly call into the gpiolib helpers when required.

Also nudge the users into converting their drivers to the
new model.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-2-maz@kernel.org
Stable-dep-of: dc3115e6c5d9 ("hid: cp2112: Fix IRQ shutdown stopping polling for all IRQs on chip")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 7 ++++++-
 include/linux/irq.h    | 2 ++
 kernel/irq/debugfs.c   | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f9fdd117c654c..e572c30a202ad 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1483,6 +1483,11 @@ static void gpiochip_set_irq_hooks(struct gpio_chip *gc)
 {
 	struct irq_chip *irqchip = gc->irq.chip;
 
+	if (irqchip->flags & IRQCHIP_IMMUTABLE)
+		return;
+
+	chip_warn(gc, "not an immutable chip, please consider fixing it!\n");
+
 	if (!irqchip->irq_request_resources &&
 	    !irqchip->irq_release_resources) {
 		irqchip->irq_request_resources = gpiochip_irq_reqres;
@@ -1650,7 +1655,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 		irq_domain_remove(gc->irq.domain);
 	}
 
-	if (irqchip) {
+	if (irqchip && !(irqchip->flags & IRQCHIP_IMMUTABLE)) {
 		if (irqchip->irq_request_resources == gpiochip_irq_reqres) {
 			irqchip->irq_request_resources = NULL;
 			irqchip->irq_release_resources = NULL;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f9e6449fbbbae..296ef3b7d7afa 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -570,6 +570,7 @@ struct irq_chip {
  * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
  *                                    in the suspend path if they are in disabled state
  * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before startup
+ * IRQCHIP_IMMUTABLE:		      Don't ever change anything in this chip
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -583,6 +584,7 @@ enum {
 	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
 	IRQCHIP_AFFINITY_PRE_STARTUP		= (1 << 10),
+	IRQCHIP_IMMUTABLE			= (1 << 11),
 };
 
 #include <linux/irqdesc.h>
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index e4cff358b437e..7ff52d94b42c0 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -58,6 +58,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
 	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
+	BIT_MASK_DESCR(IRQCHIP_IMMUTABLE),
 };
 
 static void
-- 
2.42.0




