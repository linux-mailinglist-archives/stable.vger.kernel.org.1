Return-Path: <stable+bounces-66382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794AA94E214
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6941C20AD5
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0EF14C5A7;
	Sun, 11 Aug 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E7RECYR7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95114C59C
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391870; cv=none; b=QiYcUvhzOqF3b38rNf5OYNW4QJUrgE0FcPx2np7oaA5anj3EIYO3dmIVynzzDXfc2iuNWHn/t95HVkMEPvlGOAUE9S9U+Uy16WLjDojg0FQ7xjHcBC0gGV7xAj0LGcevb9KZaxVdi85zWfXeDe9p5qfv/z5dPuR75CiKwhSzJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391870; c=relaxed/simple;
	bh=whRiDwfOswvV8JEWztd2mk5H/HMdSFKg1DZVTTjCs+A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lFv5NbGVlNl1CyxJmYV8zZu+VWLdUyKaEQLCzFWODWI8P2cLkPnVt0Hk4puVuafko16q1mRchN/nw/UMirqoPbjqsduAmlKMqWZkujApKiW++s3MrvuQPQG+cUEMtvSPJ+XavWSEcOSfayMnTlLCMTMTjmvQoW2uklWITIQDB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E7RECYR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F22C32786;
	Sun, 11 Aug 2024 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723391870;
	bh=whRiDwfOswvV8JEWztd2mk5H/HMdSFKg1DZVTTjCs+A=;
	h=Subject:To:Cc:From:Date:From;
	b=E7RECYR7XsDxs2N1RN1bz9PLMTRTrGEgH0sNFylkSyxsm3PEv1wjhzrzoSwMhFVHN
	 ieMpADAy2n6m8oYseLPAVeA3PLQUrjMypJv/6zX1L/1tJG506stjzOCapKAdgaSUU6
	 UZ9RhT2Ooj5mtpBmr1jQ8SgcSvdRLtFVXcwwrsfw=
Subject: FAILED: patch "[PATCH] irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock" failed to apply to 5.15-stable tree
To: avkrasnov@salutedevices.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 11 Aug 2024 17:57:47 +0200
Message-ID: <2024081146-whacking-skirt-ec12@gregkh>
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
git cherry-pick -x f872d4af79fe8c71ae291ce8875b477e1669a6c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081146-whacking-skirt-ec12@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f872d4af79fe ("irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock to 'raw_spinlock_t'")
cc311074f681 ("irqchip/meson-gpio: support more than 8 channels gpio irq")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f872d4af79fe8c71ae291ce8875b477e1669a6c7 Mon Sep 17 00:00:00 2001
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date: Mon, 29 Jul 2024 16:18:50 +0300
Subject: [PATCH] irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock
 to 'raw_spinlock_t'

This lock is acquired under irq_desc::lock with interrupts disabled.

When PREEMPT_RT is enabled, 'spinlock_t' becomes preemptible, which results
in invalid lock acquire context;

  [ BUG: Invalid wait context ]
  swapper/0/1 is trying to lock:
  ffff0000008fed30 (&ctl->lock){....}-{3:3}, at: meson_gpio_irq_update_bits0
  other info that might help us debug this:
  context-{5:5}
  3 locks held by swapper/0/1:
   #0: ffff0000003cd0f8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x90c
   #1: ffff000004714650 (&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq0
   #2: ffff0000047144c8 (&irq_desc_lock_class){-.-.}-{2:2}, at: __setup_irq0
  stack backtrace:
  CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.9-sdkernel #1
  Call trace:
   _raw_spin_lock_irqsave+0x60/0x88
   meson_gpio_irq_update_bits+0x34/0x70
   meson8_gpio_irq_set_type+0x78/0xc4
   meson_gpio_irq_set_type+0x30/0x60
   __irq_set_trigger+0x60/0x180
   __setup_irq+0x30c/0x6e0
   request_threaded_irq+0xec/0x1a4

Fixes: 215f4cc0fb20 ("irqchip/meson: Add support for gpio interrupt controller")
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240729131850.3015508-1-avkrasnov@salutedevices.com

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 27e30ce41db3..cd789fa51519 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -178,7 +178,7 @@ struct meson_gpio_irq_controller {
 	void __iomem *base;
 	u32 channel_irqs[MAX_NUM_CHANNEL];
 	DECLARE_BITMAP(channel_map, MAX_NUM_CHANNEL);
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller *ctl,
@@ -187,14 +187,14 @@ static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller *ctl,
 	unsigned long flags;
 	u32 tmp;
 
-	spin_lock_irqsave(&ctl->lock, flags);
+	raw_spin_lock_irqsave(&ctl->lock, flags);
 
 	tmp = readl_relaxed(ctl->base + reg);
 	tmp &= ~mask;
 	tmp |= val;
 	writel_relaxed(tmp, ctl->base + reg);
 
-	spin_unlock_irqrestore(&ctl->lock, flags);
+	raw_spin_unlock_irqrestore(&ctl->lock, flags);
 }
 
 static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl)
@@ -244,12 +244,12 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	unsigned long flags;
 	unsigned int idx;
 
-	spin_lock_irqsave(&ctl->lock, flags);
+	raw_spin_lock_irqsave(&ctl->lock, flags);
 
 	/* Find a free channel */
 	idx = find_first_zero_bit(ctl->channel_map, ctl->params->nr_channels);
 	if (idx >= ctl->params->nr_channels) {
-		spin_unlock_irqrestore(&ctl->lock, flags);
+		raw_spin_unlock_irqrestore(&ctl->lock, flags);
 		pr_err("No channel available\n");
 		return -ENOSPC;
 	}
@@ -257,7 +257,7 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	/* Mark the channel as used */
 	set_bit(idx, ctl->channel_map);
 
-	spin_unlock_irqrestore(&ctl->lock, flags);
+	raw_spin_unlock_irqrestore(&ctl->lock, flags);
 
 	/*
 	 * Setup the mux of the channel to route the signal of the pad
@@ -567,7 +567,7 @@ static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *
 	if (!ctl)
 		return -ENOMEM;
 
-	spin_lock_init(&ctl->lock);
+	raw_spin_lock_init(&ctl->lock);
 
 	ctl->base = of_iomap(node, 0);
 	if (!ctl->base) {


