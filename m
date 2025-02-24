Return-Path: <stable+bounces-118756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B7A41B00
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB78716D804
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F2324E4A8;
	Mon, 24 Feb 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nYRfLuVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837719DF66
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392922; cv=none; b=nfx5D1eyRv7AaFB0LBgBOAHzr+P/MNsqwRyOUOROialKXOH6WAUb+JZvBBF/J0CpzS3rdHD/ODBNnDPNeChUn6wvI4sf6VAf6d19JGYtkd4ORp/xE3xKY20q7bbHQqdok4sfbytbqZJif1eRxJkbmpe248pBC/1ILEPoacgGuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392922; c=relaxed/simple;
	bh=86RK88TKlFQ7P8tEC4a5s/VEFCRbWmX2aX49AKq0Vog=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PdEua5cE5VgUy0Q9ONYSl74rkLoShXkXTJ3Z8tALjimMFfESa+F1tpmo+OQyllXpN67tC98xLQF9V1byH3B2b3hSoH8priUrQxoSIkhYc1h5Cn0gF6uiLxofohpCZzr272MBxNUkChagRN4zPjLVepAUZgYAL7ZT6wPaMYOVEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nYRfLuVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10B6C4CED6;
	Mon, 24 Feb 2025 10:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392921;
	bh=86RK88TKlFQ7P8tEC4a5s/VEFCRbWmX2aX49AKq0Vog=;
	h=Subject:To:Cc:From:Date:From;
	b=nYRfLuViLAJHoGrEfVE0EKQKpHk4Ot14dx4m5VTsrnzFRUEThKwmJXm2rkv9pqyai
	 RvkZl6T9rbMyPViuW294gbc43/LVSXqlSTTJuTKfOuuzSdUtCLjDQvumjOLZ1alNHX
	 m33mjaXNr8GvUq0hasHZcqI0RPHayKn7Tua7L+wg=
Subject: FAILED: patch "[PATCH] gpio: vf610: add locking to gpio direction functions" failed to apply to 5.15-stable tree
To: johan.korsnes@remarkable.no,bartosz.golaszewski@linaro.org,brgl@bgdev.pl,haibo.chen@nxp.com,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:28:11 +0100
Message-ID: <2025022411-swung-daisy-6fbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4e667a1968099c6deadee2313ecd648f8f0a8956
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022411-swung-daisy-6fbb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e667a1968099c6deadee2313ecd648f8f0a8956 Mon Sep 17 00:00:00 2001
From: Johan Korsnes <johan.korsnes@remarkable.no>
Date: Mon, 17 Feb 2025 10:16:43 +0100
Subject: [PATCH] gpio: vf610: add locking to gpio direction functions

Add locking to `vf610_gpio_direction_input|output()` functions. Without
this locking, a race condition exists between concurrent calls to these
functions, potentially leading to incorrect GPIO direction settings.

To verify the correctness of this fix, a `trylock` patch was applied,
where after a couple of reboots the race was confirmed. I.e., one user
had to wait before acquiring the lock. With this patch the race has not
been encountered. It's worth mentioning that any type of debugging
(printing, tracing, etc.) would "resolve"/hide the issue.

Fixes: 659d8a62311f ("gpio: vf610: add imx7ulp support")
Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250217091643.679644-1-johan.korsnes@remarkable.no
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index c4f34a347cb6..c36a9dbccd4d 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -36,6 +36,7 @@ struct vf610_gpio_port {
 	struct clk *clk_port;
 	struct clk *clk_gpio;
 	int irq;
+	spinlock_t lock; /* protect gpio direction registers */
 };
 
 #define GPIO_PDOR		0x00
@@ -124,6 +125,7 @@ static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
 	u32 val;
 
 	if (port->sdata->have_paddr) {
+		guard(spinlock_irqsave)(&port->lock);
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val &= ~mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -142,6 +144,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio
 	vf610_gpio_set(chip, gpio, value);
 
 	if (port->sdata->have_paddr) {
+		guard(spinlock_irqsave)(&port->lock);
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val |= mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
@@ -297,6 +300,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	port->sdata = device_get_match_data(dev);
+	spin_lock_init(&port->lock);
 
 	dual_base = port->sdata->have_dual_base;
 


