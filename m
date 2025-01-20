Return-Path: <stable+bounces-109529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79CCA16DA5
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B6B3A7A75
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CD61E2308;
	Mon, 20 Jan 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k6zdT60G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC91E1C29
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380679; cv=none; b=SLPxUBo5I7tdzCtaqvJ+FihPOQ2BYBZAQQCik6gKqEt/k/3tCEyom7vEQ6LzD5MSYlbntaegH+ZItsfL9cV1kLrnFyZXctqcjjeyQE/xrB2mI6aI8oxQ8rY0CnJF+GVUnfqkxxbDyf5WaCG/TS9JVXxSdc4qltk6bIl0OGueGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380679; c=relaxed/simple;
	bh=gSpl4cJpM5ZjdYGwX/cm/vONCuCPWO4YvYUx3phK3hc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KaaPdW4/kKXjNhNEAWA8FpyuJOJ5wdukf6GgQJH48+NBu12U9K0H1c6fRLQ4E2d2rPk7HnksCwnFdXIjSUzx6PQbVPmWnR3/70gNPgqKt2Cm+Ecog4qUutyi65zFBvhBJbit9rS8Yq+ZbmkRPi20nVBeHRHUm2Po6m2GorlOeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k6zdT60G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD63C4CEDD;
	Mon, 20 Jan 2025 13:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737380679;
	bh=gSpl4cJpM5ZjdYGwX/cm/vONCuCPWO4YvYUx3phK3hc=;
	h=Subject:To:Cc:From:Date:From;
	b=k6zdT60Gq7S1YCXpPHVJxY6lpByBgjQpuoqW0sm3PvWgyfTYi/8xaaj5Y6R3uxR2F
	 jWhDWLLxqJbzZfNgcx6ztiLDnMEDZOxZ8734J0Y04IJUsc6L6PlFer+BZqiiFT8Odg
	 zdleIoad9z7IfQHyml5NPQV9+RsBC02t0JRYWGds=
Subject: FAILED: patch "[PATCH] gpio: xilinx: Convert gpio_lock to raw spinlock" failed to apply to 5.15-stable tree
To: sean.anderson@linux.dev,bartosz.golaszewski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:44:28 +0100
Message-ID: <2025012028-scouts-gravy-4433@gregkh>
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
git cherry-pick -x 9860370c2172704b6b4f0075a0c2a29fd84af96a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012028-scouts-gravy-4433@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9860370c2172704b6b4f0075a0c2a29fd84af96a Mon Sep 17 00:00:00 2001
From: Sean Anderson <sean.anderson@linux.dev>
Date: Fri, 10 Jan 2025 11:33:54 -0500
Subject: [PATCH] gpio: xilinx: Convert gpio_lock to raw spinlock

irq_chip functions may be called in raw spinlock context. Therefore, we
must also use a raw spinlock for our own internal locking.

This fixes the following lockdep splat:

[    5.349336] =============================
[    5.353349] [ BUG: Invalid wait context ]
[    5.357361] 6.13.0-rc5+ #69 Tainted: G        W
[    5.363031] -----------------------------
[    5.367045] kworker/u17:1/44 is trying to lock:
[    5.371587] ffffff88018b02c0 (&chip->gpio_lock){....}-{3:3}, at: xgpio_irq_unmask (drivers/gpio/gpio-xilinx.c:433 (discriminator 8))
[    5.380079] other info that might help us debug this:
[    5.385138] context-{5:5}
[    5.387762] 5 locks held by kworker/u17:1/44:
[    5.392123] #0: ffffff8800014958 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3204)
[    5.402260] #1: ffffffc082fcbdd8 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3205)
[    5.411528] #2: ffffff880172c900 (&dev->mutex){....}-{4:4}, at: __device_attach (drivers/base/dd.c:1006)
[    5.419929] #3: ffffff88039c8268 (request_class#2){+.+.}-{4:4}, at: __setup_irq (kernel/irq/internals.h:156 kernel/irq/manage.c:1596)
[    5.428331] #4: ffffff88039c80c8 (lock_class#2){....}-{2:2}, at: __setup_irq (kernel/irq/manage.c:1614)
[    5.436472] stack backtrace:
[    5.439359] CPU: 2 UID: 0 PID: 44 Comm: kworker/u17:1 Tainted: G        W          6.13.0-rc5+ #69
[    5.448690] Tainted: [W]=WARN
[    5.451656] Hardware name: xlnx,zynqmp (DT)
[    5.455845] Workqueue: events_unbound deferred_probe_work_func
[    5.461699] Call trace:
[    5.464147] show_stack+0x18/0x24 C
[    5.467821] dump_stack_lvl (lib/dump_stack.c:123)
[    5.471501] dump_stack (lib/dump_stack.c:130)
[    5.474824] __lock_acquire (kernel/locking/lockdep.c:4828 kernel/locking/lockdep.c:4898 kernel/locking/lockdep.c:5176)
[    5.478758] lock_acquire (arch/arm64/include/asm/percpu.h:40 kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
[    5.482429] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[    5.486797] xgpio_irq_unmask (drivers/gpio/gpio-xilinx.c:433 (discriminator 8))
[    5.490737] irq_enable (kernel/irq/internals.h:236 kernel/irq/chip.c:170 kernel/irq/chip.c:439 kernel/irq/chip.c:432 kernel/irq/chip.c:345)
[    5.494060] __irq_startup (kernel/irq/internals.h:241 kernel/irq/chip.c:180 kernel/irq/chip.c:250)
[    5.497645] irq_startup (kernel/irq/chip.c:270)
[    5.501143] __setup_irq (kernel/irq/manage.c:1807)
[    5.504728] request_threaded_irq (kernel/irq/manage.c:2208)

Fixes: a32c7caea292 ("gpio: gpio-xilinx: Add interrupt support")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250110163354.2012654-1-sean.anderson@linux.dev
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index c6a8f2c82680..792d94c49077 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -65,7 +65,7 @@ struct xgpio_instance {
 	DECLARE_BITMAP(state, 64);
 	DECLARE_BITMAP(last_irq_read, 64);
 	DECLARE_BITMAP(dir, 64);
-	spinlock_t gpio_lock;	/* For serializing operations */
+	raw_spinlock_t gpio_lock;	/* For serializing operations */
 	int irq;
 	DECLARE_BITMAP(enable, 64);
 	DECLARE_BITMAP(rising_edge, 64);
@@ -179,14 +179,14 @@ static void xgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 	int bit = xgpio_to_bit(chip, gpio);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	/* Write to GPIO signal and set its direction to output */
 	__assign_bit(bit, chip->state, val);
 
 	xgpio_write_ch(chip, XGPIO_DATA_OFFSET, bit, chip->state);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -210,7 +210,7 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	bitmap_remap(hw_mask, mask, chip->sw_map, chip->hw_map, 64);
 	bitmap_remap(hw_bits, bits, chip->sw_map, chip->hw_map, 64);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	bitmap_replace(state, chip->state, hw_bits, hw_mask, 64);
 
@@ -218,7 +218,7 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 
 	bitmap_copy(chip->state, state, 64);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -236,13 +236,13 @@ static int xgpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 	int bit = xgpio_to_bit(chip, gpio);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	/* Set the GPIO bit in shadow register and set direction as input */
 	__set_bit(bit, chip->dir);
 	xgpio_write_ch(chip, XGPIO_TRI_OFFSET, bit, chip->dir);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 
 	return 0;
 }
@@ -265,7 +265,7 @@ static int xgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 	int bit = xgpio_to_bit(chip, gpio);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	/* Write state of GPIO signal */
 	__assign_bit(bit, chip->state, val);
@@ -275,7 +275,7 @@ static int xgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	__clear_bit(bit, chip->dir);
 	xgpio_write_ch(chip, XGPIO_TRI_OFFSET, bit, chip->dir);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 
 	return 0;
 }
@@ -398,7 +398,7 @@ static void xgpio_irq_mask(struct irq_data *irq_data)
 	int bit = xgpio_to_bit(chip, irq_offset);
 	u32 mask = BIT(bit / 32), temp;
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	__clear_bit(bit, chip->enable);
 
@@ -408,7 +408,7 @@ static void xgpio_irq_mask(struct irq_data *irq_data)
 		temp &= ~mask;
 		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, temp);
 	}
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 
 	gpiochip_disable_irq(&chip->gc, irq_offset);
 }
@@ -428,7 +428,7 @@ static void xgpio_irq_unmask(struct irq_data *irq_data)
 
 	gpiochip_enable_irq(&chip->gc, irq_offset);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	__set_bit(bit, chip->enable);
 
@@ -447,7 +447,7 @@ static void xgpio_irq_unmask(struct irq_data *irq_data)
 		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, val);
 	}
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -512,7 +512,7 @@ static void xgpio_irqhandler(struct irq_desc *desc)
 
 	chained_irq_enter(irqchip, desc);
 
-	spin_lock(&chip->gpio_lock);
+	raw_spin_lock(&chip->gpio_lock);
 
 	xgpio_read_ch_all(chip, XGPIO_DATA_OFFSET, all);
 
@@ -529,7 +529,7 @@ static void xgpio_irqhandler(struct irq_desc *desc)
 	bitmap_copy(chip->last_irq_read, all, 64);
 	bitmap_or(all, rising, falling, 64);
 
-	spin_unlock(&chip->gpio_lock);
+	raw_spin_unlock(&chip->gpio_lock);
 
 	dev_dbg(gc->parent, "IRQ rising %*pb falling %*pb\n", 64, rising, 64, falling);
 
@@ -620,7 +620,7 @@ static int xgpio_probe(struct platform_device *pdev)
 	bitmap_set(chip->hw_map,  0, width[0]);
 	bitmap_set(chip->hw_map, 32, width[1]);
 
-	spin_lock_init(&chip->gpio_lock);
+	raw_spin_lock_init(&chip->gpio_lock);
 
 	chip->gc.base = -1;
 	chip->gc.ngpio = bitmap_weight(chip->hw_map, 64);


