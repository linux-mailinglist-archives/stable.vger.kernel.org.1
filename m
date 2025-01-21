Return-Path: <stable+bounces-109806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E2A183FF
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789F9188CFA8
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD8F1F668A;
	Tue, 21 Jan 2025 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZ2ziqJd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D71F470A;
	Tue, 21 Jan 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482492; cv=none; b=bZvzlbTGRhwjIYDFwroip+J8kvRuaOHD+9tKHjLE5WahxjlbQt+s5onS6SKNArHR78MVXF5WmWjeueeOxlWtMXLnIkCY0jzEPBWHffPMzOFGtaKtifjQiMoQeQuRvly8sI94fPo5lC08lOc6tbcVEldujNzxC6d1Nm11mg0A0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482492; c=relaxed/simple;
	bh=MwnNgOomN7suKITmtcHt7wQHLsQqtg3eEwoc9Yc0pW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6tZeSs9JhAJxmL+6xx5SkSIkDbyaZFi4dHButLYFXE3mExCDhSaq4KJzlCoYEyUCxmEMYo3+WT6SVsiDzb6CbcxC02hUOauvhkri4tXaANcuA35EhXhKdecxZ7gz/GrRbdxKtPWn642vVSuqib9nvrpVaw5VsXT5sdNDrSqRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZ2ziqJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2A4C4CEDF;
	Tue, 21 Jan 2025 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482492;
	bh=MwnNgOomN7suKITmtcHt7wQHLsQqtg3eEwoc9Yc0pW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZ2ziqJdiawkKpzOiUiybxbDRvyzoIPcOWeppda+xz4Kd6bj9celIFBoDMpDyVag5
	 J+AQHxNFuqrpevWeV4Jg+ymjM1xMvp1Gzrh2W9a0ZfOgyD5QQpq/ISjsyDAE34LsDp
	 QiBZwZGU1kuMiySi++9gTWCGJdLEhg9NPPoFeiFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Anderson <sean.anderson@linux.dev>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.12 094/122] gpio: xilinx: Convert gpio_lock to raw spinlock
Date: Tue, 21 Jan 2025 18:52:22 +0100
Message-ID: <20250121174536.648642765@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
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

From: Sean Anderson <sean.anderson@linux.dev>

commit 9860370c2172704b6b4f0075a0c2a29fd84af96a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-xilinx.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

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
@@ -179,14 +179,14 @@ static void xgpio_set(struct gpio_chip *
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
@@ -210,7 +210,7 @@ static void xgpio_set_multiple(struct gp
 	bitmap_remap(hw_mask, mask, chip->sw_map, chip->hw_map, 64);
 	bitmap_remap(hw_bits, bits, chip->sw_map, chip->hw_map, 64);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	bitmap_replace(state, chip->state, hw_bits, hw_mask, 64);
 
@@ -218,7 +218,7 @@ static void xgpio_set_multiple(struct gp
 
 	bitmap_copy(chip->state, state, 64);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -236,13 +236,13 @@ static int xgpio_dir_in(struct gpio_chip
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
@@ -265,7 +265,7 @@ static int xgpio_dir_out(struct gpio_chi
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 	int bit = xgpio_to_bit(chip, gpio);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	/* Write state of GPIO signal */
 	__assign_bit(bit, chip->state, val);
@@ -275,7 +275,7 @@ static int xgpio_dir_out(struct gpio_chi
 	__clear_bit(bit, chip->dir);
 	xgpio_write_ch(chip, XGPIO_TRI_OFFSET, bit, chip->dir);
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 
 	return 0;
 }
@@ -398,7 +398,7 @@ static void xgpio_irq_mask(struct irq_da
 	int bit = xgpio_to_bit(chip, irq_offset);
 	u32 mask = BIT(bit / 32), temp;
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	__clear_bit(bit, chip->enable);
 
@@ -408,7 +408,7 @@ static void xgpio_irq_mask(struct irq_da
 		temp &= ~mask;
 		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, temp);
 	}
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 
 	gpiochip_disable_irq(&chip->gc, irq_offset);
 }
@@ -428,7 +428,7 @@ static void xgpio_irq_unmask(struct irq_
 
 	gpiochip_enable_irq(&chip->gc, irq_offset);
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gpio_lock, flags);
 
 	__set_bit(bit, chip->enable);
 
@@ -447,7 +447,7 @@ static void xgpio_irq_unmask(struct irq_
 		xgpio_writereg(chip->regs + XGPIO_IPIER_OFFSET, val);
 	}
 
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
@@ -512,7 +512,7 @@ static void xgpio_irqhandler(struct irq_
 
 	chained_irq_enter(irqchip, desc);
 
-	spin_lock(&chip->gpio_lock);
+	raw_spin_lock(&chip->gpio_lock);
 
 	xgpio_read_ch_all(chip, XGPIO_DATA_OFFSET, all);
 
@@ -529,7 +529,7 @@ static void xgpio_irqhandler(struct irq_
 	bitmap_copy(chip->last_irq_read, all, 64);
 	bitmap_or(all, rising, falling, 64);
 
-	spin_unlock(&chip->gpio_lock);
+	raw_spin_unlock(&chip->gpio_lock);
 
 	dev_dbg(gc->parent, "IRQ rising %*pb falling %*pb\n", 64, rising, 64, falling);
 
@@ -620,7 +620,7 @@ static int xgpio_probe(struct platform_d
 	bitmap_set(chip->hw_map,  0, width[0]);
 	bitmap_set(chip->hw_map, 32, width[1]);
 
-	spin_lock_init(&chip->gpio_lock);
+	raw_spin_lock_init(&chip->gpio_lock);
 
 	chip->gc.base = -1;
 	chip->gc.ngpio = bitmap_weight(chip->hw_map, 64);



