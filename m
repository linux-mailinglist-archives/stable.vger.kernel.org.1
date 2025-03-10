Return-Path: <stable+bounces-121754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58EDA59C1D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C4E16DA3D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2F233705;
	Mon, 10 Mar 2025 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="blnVO5x3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1CA231A37;
	Mon, 10 Mar 2025 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626532; cv=none; b=W6YBTNdrOILxne01P/f+GsUvOUE7gNHSDVH83K7/XQz1TGrUdrHdwFcwqUeC7Ar28kaE9+6x4aY+Sqt3sik6fHBLQSQoJnjKLnbOQy5F7Dyu9e81jQkajLWVTUr7C9mqM2dsRPXjkyd3OsAX8rSh8rnh3ksZx7D8xfmGKVQ+nuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626532; c=relaxed/simple;
	bh=66c44A0hqPNVyVJbkltkByy87vBxiGlyOx9FpKRNRFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQ7NfFprWrSDh7w3Ipxcr1RKijGQAZjo4AOTUTerykleXeodBze4cy0d0xrSsEN6LI19xmlSqeT3vEOrydtAk9UVX3pDMWX/0xnJ2ZdWQJoD69WaQVg4jQ/UDP+X9lI/F2bOcl6DAOqja7nqm2Ur6ZNIWblylrEZapUqlZUtc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=blnVO5x3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9165C4CEE5;
	Mon, 10 Mar 2025 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626532;
	bh=66c44A0hqPNVyVJbkltkByy87vBxiGlyOx9FpKRNRFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blnVO5x3fzJrDbKa211nTor8TNlgBMWmdy+Na2AP/ouIR27IQXbmVK8pp8JZYaZBB
	 Sn4A7GE4DDYp29ILejDdz1usYwljgUm9dWbwXgHFrQUguiUALCVsImY0xEu3HBNBDP
	 MMunfKBAWqY/146s8b7rGHVhp0JRKQSLtKwn2w7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.13 024/207] gpio: rcar: Use raw_spinlock to protect register access
Date: Mon, 10 Mar 2025 18:03:37 +0100
Message-ID: <20250310170448.732933700@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit f02c41f87cfe61440c18bf77d1ef0a884b9ee2b5 upstream.

Use raw_spinlock in order to fix spurious messages about invalid context
when spinlock debugging is enabled. The lock is only used to serialize
register access.

    [    4.239592] =============================
    [    4.239595] [ BUG: Invalid wait context ]
    [    4.239599] 6.13.0-rc7-arm64-renesas-05496-gd088502a519f #35 Not tainted
    [    4.239603] -----------------------------
    [    4.239606] kworker/u8:5/76 is trying to lock:
    [    4.239609] ffff0000091898a0 (&p->lock){....}-{3:3}, at: gpio_rcar_config_interrupt_input_mode+0x34/0x164
    [    4.239641] other info that might help us debug this:
    [    4.239643] context-{5:5}
    [    4.239646] 5 locks held by kworker/u8:5/76:
    [    4.239651]  #0: ffff0000080fb148 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0x190/0x62c
    [    4.250180] OF: /soc/sound@ec500000/ports/port@0/endpoint: Read of boolean property 'frame-master' with a value.
    [    4.254094]  #1: ffff80008299bd80 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x1b8/0x62c
    [    4.254109]  #2: ffff00000920c8f8
    [    4.258345] OF: /soc/sound@ec500000/ports/port@1/endpoint: Read of boolean property 'bitclock-master' with a value.
    [    4.264803]  (&dev->mutex){....}-{4:4}, at: __device_attach_async_helper+0x3c/0xdc
    [    4.264820]  #3: ffff00000a50ca40 (request_class#2){+.+.}-{4:4}, at: __setup_irq+0xa0/0x690
    [    4.264840]  #4:
    [    4.268872] OF: /soc/sound@ec500000/ports/port@1/endpoint: Read of boolean property 'frame-master' with a value.
    [    4.273275] ffff00000a50c8c8 (lock_class){....}-{2:2}, at: __setup_irq+0xc4/0x690
    [    4.296130] renesas_sdhi_internal_dmac ee100000.mmc: mmc1 base at 0x00000000ee100000, max clock rate 200 MHz
    [    4.304082] stack backtrace:
    [    4.304086] CPU: 1 UID: 0 PID: 76 Comm: kworker/u8:5 Not tainted 6.13.0-rc7-arm64-renesas-05496-gd088502a519f #35
    [    4.304092] Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
    [    4.304097] Workqueue: async async_run_entry_fn
    [    4.304106] Call trace:
    [    4.304110]  show_stack+0x14/0x20 (C)
    [    4.304122]  dump_stack_lvl+0x6c/0x90
    [    4.304131]  dump_stack+0x14/0x1c
    [    4.304138]  __lock_acquire+0xdfc/0x1584
    [    4.426274]  lock_acquire+0x1c4/0x33c
    [    4.429942]  _raw_spin_lock_irqsave+0x5c/0x80
    [    4.434307]  gpio_rcar_config_interrupt_input_mode+0x34/0x164
    [    4.440061]  gpio_rcar_irq_set_type+0xd4/0xd8
    [    4.444422]  __irq_set_trigger+0x5c/0x178
    [    4.448435]  __setup_irq+0x2e4/0x690
    [    4.452012]  request_threaded_irq+0xc4/0x190
    [    4.456285]  devm_request_threaded_irq+0x7c/0xf4
    [    4.459398] ata1: link resume succeeded after 1 retries
    [    4.460902]  mmc_gpiod_request_cd_irq+0x68/0xe0
    [    4.470660]  mmc_start_host+0x50/0xac
    [    4.474327]  mmc_add_host+0x80/0xe4
    [    4.477817]  tmio_mmc_host_probe+0x2b0/0x440
    [    4.482094]  renesas_sdhi_probe+0x488/0x6f4
    [    4.486281]  renesas_sdhi_internal_dmac_probe+0x60/0x78
    [    4.491509]  platform_probe+0x64/0xd8
    [    4.495178]  really_probe+0xb8/0x2a8
    [    4.498756]  __driver_probe_device+0x74/0x118
    [    4.503116]  driver_probe_device+0x3c/0x154
    [    4.507303]  __device_attach_driver+0xd4/0x160
    [    4.511750]  bus_for_each_drv+0x84/0xe0
    [    4.515588]  __device_attach_async_helper+0xb0/0xdc
    [    4.520470]  async_run_entry_fn+0x30/0xd8
    [    4.524481]  process_one_work+0x210/0x62c
    [    4.528494]  worker_thread+0x1ac/0x340
    [    4.532245]  kthread+0x10c/0x110
    [    4.535476]  ret_from_fork+0x10/0x20

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250121135833.3769310-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-rcar.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -40,7 +40,7 @@ struct gpio_rcar_info {
 
 struct gpio_rcar_priv {
 	void __iomem *base;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct device *dev;
 	struct gpio_chip gpio_chip;
 	unsigned int irq_parent;
@@ -123,7 +123,7 @@ static void gpio_rcar_config_interrupt_i
 	 * "Setting Level-Sensitive Interrupt Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure positive or negative logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, hwirq, !active_high_rising_edge);
@@ -142,7 +142,7 @@ static void gpio_rcar_config_interrupt_i
 	if (!level_trigger)
 		gpio_rcar_write(p, INTCLR, BIT(hwirq));
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
@@ -246,7 +246,7 @@ static void gpio_rcar_config_general_inp
 	 * "Setting General Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure positive logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, gpio, false);
@@ -261,7 +261,7 @@ static void gpio_rcar_config_general_inp
 	if (p->info.has_outdtsel && output)
 		gpio_rcar_modify_bit(p, OUTDTSEL, gpio, false);
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
@@ -347,7 +347,7 @@ static int gpio_rcar_get_multiple(struct
 		return 0;
 	}
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	outputs = gpio_rcar_read(p, INOUTSEL);
 	m = outputs & bankmask;
 	if (m)
@@ -356,7 +356,7 @@ static int gpio_rcar_get_multiple(struct
 	m = ~outputs & bankmask;
 	if (m)
 		val |= gpio_rcar_read(p, INDT) & m;
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 
 	bits[0] = val;
 	return 0;
@@ -367,9 +367,9 @@ static void gpio_rcar_set(struct gpio_ch
 	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	gpio_rcar_modify_bit(p, OUTDT, offset, value);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -386,12 +386,12 @@ static void gpio_rcar_set_multiple(struc
 	if (!bankmask)
 		return;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	val = gpio_rcar_read(p, OUTDT);
 	val &= ~bankmask;
 	val |= (bankmask & bits[0]);
 	gpio_rcar_write(p, OUTDT, val);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
@@ -505,7 +505,7 @@ static int gpio_rcar_probe(struct platfo
 		return -ENOMEM;
 
 	p->dev = dev;
-	spin_lock_init(&p->lock);
+	raw_spin_lock_init(&p->lock);
 
 	/* Get device configuration from DT node */
 	ret = gpio_rcar_parse_dt(p, &npins);



