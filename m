Return-Path: <stable+bounces-117291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D6BA3B5D3
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4825E3BDD8A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A271F5854;
	Wed, 19 Feb 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q+gIRyyx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602461C7B62;
	Wed, 19 Feb 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954810; cv=none; b=ePiu4reh/9j1/1KUd+ZmSFwM7aY/BnqjU7OMl76XOO3P9lc+g2A1RTa0m72e3fM9ctM1EpUdaV1R+E7625mK67AiqRIe0kH8k40+DpnZ13DN7g7+sG5ET5vMM2VESx3vNC7qd7h/1VUfoQXtmHuY2X6OQHRIGqpzB58rl6NZsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954810; c=relaxed/simple;
	bh=z7FJkTHwwAEG49aXTgTeVnpDTUlsOb5NLTNgImVa0ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDxkmOFYW5IsJHLRNBssBCbj2idRiy1t+52j9Po+XJVuOyZxccs+/SPLk8MhR9+xDGr2v/U1o5rGw+dtNkI+7bbN/WzbZ+k+qzjDA9+XW8MeM0FzJ8ZelufEPhdv99XEz7hGLv+G0j/MadQDiT70gnxt//Ut4N0qK0vdH8YANlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q+gIRyyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2259C4CED1;
	Wed, 19 Feb 2025 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954810;
	bh=z7FJkTHwwAEG49aXTgTeVnpDTUlsOb5NLTNgImVa0ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q+gIRyyxsFsjho5WmDJY8QLrvDjEm/lqcx9cLTTnVAq+SRXEZnBxRWP/roLzNfsDJ
	 TfVcVZJOGRTaQ89J1cMqG7nsPUCkdlAL+00IZ5TNFComRj6Oe79KqJF7UT4q+3eBI7
	 6LhiozA3h3OKLgun0ihSZgAXqBYqelFRmUgMGMvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Artur Weber <aweber.kernel@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 043/230] gpio: bcm-kona: Make sure GPIO bits are unlocked when requesting IRQ
Date: Wed, 19 Feb 2025 09:26:00 +0100
Message-ID: <20250219082603.395739689@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artur Weber <aweber.kernel@gmail.com>

[ Upstream commit 57f5db77a915cc29461a679a6bcae7097967be1a ]

The settings for all GPIOs are locked by default in bcm_kona_gpio_reset.
The settings for a GPIO are unlocked when requesting it as a GPIO, but
not when requesting it as an interrupt, causing the IRQ settings to not
get applied.

Fix this by making sure to unlock the right bits when an IRQ is requested.
To avoid a situation where an IRQ being released causes a lock despite
the same GPIO being used by a GPIO request or vice versa, add an unlock
counter and only lock if it reaches 0.

Fixes: 757651e3d60e ("gpio: bcm281xx: Add GPIO driver")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20250206-kona-gpio-fixes-v2-2-409135eab780@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-bcm-kona.c | 67 +++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 77bd4ec93a231..17f3f210fee9d 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -69,6 +69,22 @@ struct bcm_kona_gpio {
 struct bcm_kona_gpio_bank {
 	int id;
 	int irq;
+	/*
+	 * Used to keep track of lock/unlock operations for each GPIO in the
+	 * bank.
+	 *
+	 * All GPIOs are locked by default (see bcm_kona_gpio_reset), and the
+	 * unlock count for all GPIOs is 0 by default. Each unlock increments
+	 * the counter, and each lock decrements the counter.
+	 *
+	 * The lock function only locks the GPIO once its unlock counter is
+	 * down to 0. This is necessary because the GPIO is unlocked in two
+	 * places in this driver: once for requested GPIOs, and once for
+	 * requested IRQs. Since it is possible for a GPIO to be requested
+	 * as both a GPIO and an IRQ, we need to ensure that we don't lock it
+	 * too early.
+	 */
+	u8 gpio_unlock_count[GPIO_PER_BANK];
 	/* Used in the interrupt handler */
 	struct bcm_kona_gpio *kona_gpio;
 };
@@ -87,14 +103,23 @@ static void bcm_kona_gpio_lock_gpio(struct bcm_kona_gpio *kona_gpio,
 	unsigned long flags;
 	int bank_id = GPIO_BANK(gpio);
 	int bit = GPIO_BIT(gpio);
+	struct bcm_kona_gpio_bank *bank = &kona_gpio->banks[bank_id];
 
-	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
+	if (bank->gpio_unlock_count[bit] == 0) {
+		dev_err(kona_gpio->gpio_chip.parent,
+			"Unbalanced locks for GPIO %u\n", gpio);
+		return;
+	}
 
-	val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
-	val |= BIT(bit);
-	bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
+	if (--bank->gpio_unlock_count[bit] == 0) {
+		raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
-	raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+		val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
+		val |= BIT(bit);
+		bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
+
+		raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+	}
 }
 
 static void bcm_kona_gpio_unlock_gpio(struct bcm_kona_gpio *kona_gpio,
@@ -104,14 +129,19 @@ static void bcm_kona_gpio_unlock_gpio(struct bcm_kona_gpio *kona_gpio,
 	unsigned long flags;
 	int bank_id = GPIO_BANK(gpio);
 	int bit = GPIO_BIT(gpio);
+	struct bcm_kona_gpio_bank *bank = &kona_gpio->banks[bank_id];
 
-	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
+	if (bank->gpio_unlock_count[bit] == 0) {
+		raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
-	val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
-	val &= ~BIT(bit);
-	bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
+		val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
+		val &= ~BIT(bit);
+		bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
 
-	raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+		raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+	}
+
+	++bank->gpio_unlock_count[bit];
 }
 
 static int bcm_kona_gpio_get_dir(struct gpio_chip *chip, unsigned gpio)
@@ -362,6 +392,7 @@ static void bcm_kona_gpio_irq_mask(struct irq_data *d)
 
 	kona_gpio = irq_data_get_irq_chip_data(d);
 	reg_base = kona_gpio->reg_base;
+
 	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
 	val = readl(reg_base + GPIO_INT_MASK(bank_id));
@@ -384,6 +415,7 @@ static void bcm_kona_gpio_irq_unmask(struct irq_data *d)
 
 	kona_gpio = irq_data_get_irq_chip_data(d);
 	reg_base = kona_gpio->reg_base;
+
 	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
 	val = readl(reg_base + GPIO_INT_MSKCLR(bank_id));
@@ -479,15 +511,26 @@ static void bcm_kona_gpio_irq_handler(struct irq_desc *desc)
 static int bcm_kona_gpio_irq_reqres(struct irq_data *d)
 {
 	struct bcm_kona_gpio *kona_gpio = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = d->hwirq;
+
+	/*
+	 * We need to unlock the GPIO before any other operations are performed
+	 * on the relevant GPIO configuration registers
+	 */
+	bcm_kona_gpio_unlock_gpio(kona_gpio, gpio);
 
-	return gpiochip_reqres_irq(&kona_gpio->gpio_chip, d->hwirq);
+	return gpiochip_reqres_irq(&kona_gpio->gpio_chip, gpio);
 }
 
 static void bcm_kona_gpio_irq_relres(struct irq_data *d)
 {
 	struct bcm_kona_gpio *kona_gpio = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = d->hwirq;
+
+	/* Once we no longer use it, lock the GPIO again */
+	bcm_kona_gpio_lock_gpio(kona_gpio, gpio);
 
-	gpiochip_relres_irq(&kona_gpio->gpio_chip, d->hwirq);
+	gpiochip_relres_irq(&kona_gpio->gpio_chip, gpio);
 }
 
 static struct irq_chip bcm_gpio_irq_chip = {
-- 
2.39.5




