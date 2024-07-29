Return-Path: <stable+bounces-62562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9648F93F6FF
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 15:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE792812EC
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 13:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F7149C54;
	Mon, 29 Jul 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvYJH/v+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h6KcEOre"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3881E515;
	Mon, 29 Jul 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260993; cv=none; b=cgT/G3VlaqFN72I4bOHGPqCfK0Xan0KBZ8SEjly5FzwRu0YM0W2xacIn0rlioEnpUVBQLYCFRq79jjg8G0SwksqIXtrnOgnCRVzHIgHHHIGvOMhtTukaYJIoRcmh2Mao/8zJLx3XT8+ZOyRzpCUFugRstYnQhOPAaCS1BukBrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260993; c=relaxed/simple;
	bh=InQUFpstovCC9+CozNMQpL1aofE4McWvzqEyAI9oFNM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Uzk/gi3pNph7/AoHMJnzjN6LFVMC/ltH0d5PdkTlPDEccGaokWlLIxv8LoLqfd4CBUiRaSvAfbpgst/X757WWl/MqZPLS/lajvjc65uTH5ee2tyjg+TBPUfrvTQfL9pvB+96ZJ/FU92FY8Cp56OKi0WH+yCvUxeu73AJMmxQq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvYJH/v+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h6KcEOre; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 13:49:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722260989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIB7jSreWeng1mkbqwds0aQJSGOn6JmUe1ENkpT7nRA=;
	b=jvYJH/v+dAdS6MMVNmU8SLJGqpYkFfC2UfZGrEi55e5/2upLp16AA5Sm0SAqC6oGZwl3ZH
	/vyMLEkEdzKeu7AwEz/qvGK56vUDdKn85AgsE6rypUj1CoI/iHOxbkyOOuvxO6XrVDrWCS
	vEz6EP4ezQ5kqdHM/uSBVAEVU7XUN1M6YVw42iRtSHiT9lctLtQVfKGF7K6MFK4dBfNCnL
	R7I5xbyrY20K6LzkGIAnmioah6mI1UlAnLYmLYwJQKP0/tLr8jDZ2z4sOdva/304RYZy4d
	OychblfsJ3mXmTT8/3ZpRYvhICU4lE0y7IVRPDaBM9wNCLmrU8T0FT4AJT8CpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722260989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIB7jSreWeng1mkbqwds0aQJSGOn6JmUe1ENkpT7nRA=;
	b=h6KcEOreUG073VtYPPlvLqabP4a5P26LyOkrOMrn1hrOiwJ+Q/1iryDUlysA1XYUFyKeSi
	vUJr7p2UKoCCkFAA==
From: "tip-bot2 for Arseniy Krasnov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/meson-gpio: Convert
 meson_gpio_irq_controller::lock to 'raw_spinlock_t'
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240729131850.3015508-1-avkrasnov@salutedevices.com>
References: <20240729131850.3015508-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172226098842.2215.14904545855987442510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f872d4af79fe8c71ae291ce8875b477e1669a6c7
Gitweb:        https://git.kernel.org/tip/f872d4af79fe8c71ae291ce8875b477e1669a6c7
Author:        Arseniy Krasnov <avkrasnov@salutedevices.com>
AuthorDate:    Mon, 29 Jul 2024 16:18:50 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 15:43:50 +02:00

irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock to 'raw_spinlock_t'

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
---
 drivers/irqchip/irq-meson-gpio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 27e30ce..cd789fa 100644
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

