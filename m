Return-Path: <stable+bounces-202886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA32CC9352
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 19:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E076E30D0DBF
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481AD16A395;
	Wed, 17 Dec 2025 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Djocf2Gt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38172602
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994417; cv=none; b=HwWJSa+/UnXjq3CetiEVFEhjgKUhytqNj3XvZUd7vAhaOdy5q/2/8KksNNwuk825bE3WqZrk82SVKZukhKPYYu96UI/vQ86Pd5WiCfStu9Yfy4SiIZXCIANcOAC+6i9viwdamG+4L+L6RYdVHwTYkRN1RMBFZXv/CuuWmNoPf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994417; c=relaxed/simple;
	bh=aSDgHDoj7rp/647g+TSY5tpJOVsrNbcap3sPEIhUKt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFdQLDFZY46USFxSX23jxM6UR5h9T1Ql2Et970Yz9nx1xfnMhB5AmQ/OaiudMxg59JwErAUo8vIHZq40+VZzD/ZSmAFrxCxati7Y3zZ7pGsO84E3ZSgGHdU4ovOt68PjaDot0xtZw+i/TCfBwOet+O7vCrkBgjEUNiOQp4uPBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Djocf2Gt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7277324054so983010066b.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 10:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765994412; x=1766599212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI8ojcN2oq5TmJSCwDPcbxNHaOxOrPwkfMnbA1Em2Y8=;
        b=Djocf2GtE0Y4H2EnFAEg95tW3tBVHbH/IhNIEbNn9P0YU480SLGNwaSV8IZF7bBd9Y
         jfhk33/6/kBkuwiHLFkfBjukEpUaia+scjwnpRxIiWg0By8uvckw8R/nhVE7pTULGcYG
         UbmskqYcBubNkHh/bEz8jDw4fGB+1hTKhOgudKouLFBTi9pVBA7yD3mk4piGY+OIFk1R
         Tl1jlha5MjkVcX9Awr80pLTuIRX+/W0WH0FIBB0AE8BmimRJvwZbCB1lVUx2nnmfb9id
         oEu/MPjfDRxwdY5rsR/hq5Wg+z+AMXxk/7RtYCrY7iiAZE0qIwd/1d/kdUY1fdMi3y8f
         +QTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994412; x=1766599212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI8ojcN2oq5TmJSCwDPcbxNHaOxOrPwkfMnbA1Em2Y8=;
        b=is1qpSEwc4tmM2PFxOoida6jzF5SegMbi3wGHredoOSCGlsprOdYwjXrw6cwCdiXOe
         Vk/9QDXjWwnEc+CaqcgKUi2CdFVjWlr+1Z5cu3XW0RhEUN35N4rrqsYHz8zWy+okitUL
         b5mwAfYfDU6e7V1cOwPXW5QVe+YpqronyE9pNbHoB9OSmDlZa8oqSPOUEWofSTUjQ8Db
         Pe+7DCDwRyLxZUgC4U5HNSvke6UUHURGOHBlDDSyBhteqQ/7eLYQ9OTFZqFib7h2cqio
         Lhkq6pnXTrpTQ5X2OgPS5REOEnxwpITOcjLQQXP2hD5nlVGMB0YaKVxLilVMRpRPDKH7
         SYuw==
X-Gm-Message-State: AOJu0Yy5tyq49n8t5rgx28JpjA8nB3oliihbvlM/Yia+fL557cdQQPvZ
	QTKoFHzpdyB2TZx7GP+fkGqLwzZqqFlhvUn119wCfNmmXUM8n8Ai/TKRVtqNBzFC+0vhy1E9qKe
	WE0Ao
X-Gm-Gg: AY/fxX60gL1i5zXi5Z7M1/2bNdQocbD/5RVGSJN27t65ygOQM2roSeSH2lbiVl5JRQd
	F8JQmd227CyA4O7vpxa7KFdarhrT9WgFHRp2J+8KHIODIBtyRmPIhdm0IY+elfHp9lpBQIRnEQA
	RQ2c6pXeqIyuM3j2/wgl0K7LsUc5p/EObT5OF2WYXoqW2ErgtO0uLdO3lJeiWIHQLAZyqptuf7f
	AOr5CTR7rBd3XZ7mI8aMQE8Rgvhv6kA2Myja0SakYQR1rkItqZehh3PsrmuxNrxN/o6ZNjflUna
	N46lM36SJuDby4TbqI+7+meD3Z4xaIUZWsWTqLdyJdp/1xuLBJpRhIVp9IpzzcQTKkznvBQt7dK
	VQQjnMEjCr2ZqtV5qN8pI0jBu3qnFo0L4h1T/AeL6Yi+DHvgO3hxq8HyvqIBuwAbI6xRgHr8y0v
	aF624o6/cgfxW4RqaWNAZca+bUGcLBAiJoQ8z3Ke4=
X-Google-Smtp-Source: AGHT+IGAOEgvKKB6vm73FfiGWc77bejWM2zomYCIj8Yyxt/SPUxTRQEkHgOOYED8tKYH7+eYQsSr3Q==
X-Received: by 2002:a17:907:940d:b0:b76:36ee:376 with SMTP id a640c23a62f3a-b7d23a402f5mr2119373966b.54.1765994411986;
        Wed, 17 Dec 2025 10:00:11 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b802095c11esm12637866b.31.2025.12.17.10.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:00:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.17.y-stable] pinctrl: renesas: rzg2l: Fix ISEL restore on resume
Date: Wed, 17 Dec 2025 20:00:10 +0200
Message-ID: <20251217180010.721533-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 44bf66122c12ef6d3382a9b84b9be1802e5f0e95 upstream.

Commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in
gpio_irq_{en,dis}able*()") dropped the configuration of ISEL from
struct irq_chip::{irq_enable, irq_disable} APIs and moved it to
struct gpio_chip::irq::{child_to_parent_hwirq,
child_irq_domain_ops::free} APIs to fix spurious IRQs.

After commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL
in gpio_irq_{en,dis}able*()"), ISEL was no longer configured properly on
resume. This is because the pinctrl resume code used
struct irq_chip::irq_enable  (called from rzg2l_gpio_irq_restore()) to
reconfigure the wakeup interrupts. Some drivers (e.g. Ethernet) may also
reconfigure non-wakeup interrupts on resume through their own code,
eventually calling struct irq_chip::irq_enable.

Fix this by adding ISEL configuration back into the
struct irq_chip::irq_enable API and on resume path for wakeup interrupts.

As struct irq_chip::irq_enable needs now to lock to update the ISEL,
convert the struct rzg2l_pinctrl::lock to a raw spinlock and replace the
locking API calls with the raw variants. Otherwise the lockdep reports
invalid wait context when probing the adv7511 module on RZ/G2L:

 [ BUG: Invalid wait context ]
 6.17.0-rc5-next-20250911-00001-gfcfac22533c9 #18 Not tainted
 -----------------------------
 (udev-worker)/165 is trying to lock:
 ffff00000e3664a8 (&pctrl->lock){....}-{3:3}, at: rzg2l_gpio_irq_enable+0x38/0x78
 other info that might help us debug this:
 context-{5:5}
 3 locks held by (udev-worker)/165:
 #0: ffff00000e890108 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x90/0x1ac
 #1: ffff000011c07240 (request_class){+.+.}-{4:4}, at: __setup_irq+0xb4/0x6dc
 #2: ffff000011c070c8 (lock_class){....}-{2:2}, at: __setup_irq+0xdc/0x6dc
 stack backtrace:
 CPU: 1 UID: 0 PID: 165 Comm: (udev-worker) Not tainted 6.17.0-rc5-next-20250911-00001-gfcfac22533c9 #18 PREEMPT
 Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
 Call trace:
 show_stack+0x18/0x24 (C)
 dump_stack_lvl+0x90/0xd0
 dump_stack+0x18/0x24
 __lock_acquire+0xa14/0x20b4
 lock_acquire+0x1c8/0x354
 _raw_spin_lock_irqsave+0x60/0x88
 rzg2l_gpio_irq_enable+0x38/0x78
 irq_enable+0x40/0x8c
 __irq_startup+0x78/0xa4
 irq_startup+0x108/0x16c
 __setup_irq+0x3c0/0x6dc
 request_threaded_irq+0xec/0x1ac
 devm_request_threaded_irq+0x80/0x134
 adv7511_probe+0x928/0x9a4 [adv7511]
 i2c_device_probe+0x22c/0x3dc
 really_probe+0xbc/0x2a0
 __driver_probe_device+0x78/0x12c
 driver_probe_device+0x40/0x164
 __driver_attach+0x9c/0x1ac
 bus_for_each_dev+0x74/0xd0
 driver_attach+0x24/0x30
 bus_add_driver+0xe4/0x208
 driver_register+0x60/0x128
 i2c_register_driver+0x48/0xd0
 adv7511_init+0x5c/0x1000 [adv7511]
 do_one_initcall+0x64/0x30c
 do_init_module+0x58/0x23c
 load_module+0x1bcc/0x1d40
 init_module_from_file+0x88/0xc4
 idempotent_init_module+0x188/0x27c
 __arm64_sys_finit_module+0x68/0xac
 invoke_syscall+0x48/0x110
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x4c/0x160
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x198/0x19c

Having ISEL configuration back into the struct irq_chip::irq_enable API
should be safe with respect to spurious IRQs, as in the probe case IRQs
are enabled anyway in struct gpio_chip::irq::child_to_parent_hwirq. No
spurious IRQs were detected on suspend/resume, boot, ethernet link
insert/remove tests (executed on RZ/G3S). Boot, ethernet link
insert/remove tests were also executed successfully on RZ/G2L.

Fixes: 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in gpio_irq_{en,dis}able*(")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250912095308.3603704-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea:
 - in rzg2l_write_oen() kept v6.17 code and use
   raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore
 - in rzg2l_pinctrl_resume_noirq() kept v6.17 code
 - manually adjust rzg3s_oen_write(), rzv2h_oen_write() to use
   raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

test

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 75 +++++++++++++++----------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 289917a0e872..c447526e886b 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -358,7 +358,7 @@ struct rzg2l_pinctrl {
 	spinlock_t			bitmap_lock; /* protect tint_slot bitmap */
 	unsigned int			hwirq[RZG2L_TINT_MAX_INTERRUPT];
 
-	spinlock_t			lock; /* lock read/write registers */
+	raw_spinlock_t			lock; /* lock read/write registers */
 	struct mutex			mutex; /* serialize adding groups and functions */
 
 	struct rzg2l_pinctrl_pin_settings *settings;
@@ -518,7 +518,7 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Set pin to 'Non-use (Hi-Z input protection)'  */
 	reg = readw(pctrl->base + PM(off));
@@ -542,7 +542,7 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 
 	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 };
 
 static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
@@ -857,10 +857,10 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
 		addr += 4;
 	}
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	reg = readl(addr) & ~(mask << (bit * 8));
 	writel(reg | (val << (bit * 8)), addr);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *regs, u32 caps)
@@ -1088,14 +1088,14 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 	if (bit < 0)
 		return bit;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	val = readb(pctrl->base + ETH_MODE);
 	if (oen)
 		val &= ~BIT(bit);
 	else
 		val |= BIT(bit);
 	writeb(val, pctrl->base + ETH_MODE);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -1141,14 +1141,14 @@ static int rzg3s_oen_write(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 	if (bit < 0)
 		return bit;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	val = readb(pctrl->base + ETH_MODE);
 	if (oen)
 		val &= ~BIT(bit);
 	else
 		val |= BIT(bit);
 	writeb(val, pctrl->base + ETH_MODE);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -1253,7 +1253,7 @@ static int rzv2h_oen_write(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 	u8 pwpr;
 
 	bit = rzv2h_pin_to_oen_bit(pctrl, _pin);
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	val = readb(pctrl->base + PFC_OEN);
 	if (oen)
 		val &= ~BIT(bit);
@@ -1264,7 +1264,7 @@ static int rzv2h_oen_write(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 	writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
 	writeb(val, pctrl->base + PFC_OEN);
 	writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -1702,14 +1702,14 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Select GPIO mode in PMC Register */
 	reg8 = readb(pctrl->base + PMC(off));
 	reg8 &= ~BIT(bit);
 	pctrl->data->pmc_writeb(pctrl, reg8, PMC(off));
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -1724,7 +1724,7 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
 	unsigned long flags;
 	u16 reg16;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	reg16 = readw(pctrl->base + PM(off));
 	reg16 &= ~(PM_MASK << (bit * 2));
@@ -1732,7 +1732,7 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
 	reg16 |= (output ? PM_OUTPUT : PM_INPUT) << (bit * 2);
 	writew(reg16, pctrl->base + PM(off));
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int rzg2l_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -1776,7 +1776,7 @@ static int rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	unsigned long flags;
 	u8 reg8;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	reg8 = readb(pctrl->base + P(off));
 
@@ -1785,7 +1785,7 @@ static int rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		writeb(reg8 & ~BIT(bit), pctrl->base + P(off));
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -2444,14 +2444,13 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl
 	return gpioint;
 }
 
-static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
-				     unsigned int hwirq, bool enable)
+static void __rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
+				       unsigned int hwirq, bool enable)
 {
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
 	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
-	unsigned long flags;
 	void __iomem *addr;
 
 	addr = pctrl->base + ISEL(off);
@@ -2460,12 +2459,20 @@ static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
 		addr += 4;
 	}
 
-	spin_lock_irqsave(&pctrl->lock, flags);
 	if (enable)
 		writel(readl(addr) | BIT(bit * 8), addr);
 	else
 		writel(readl(addr) & ~BIT(bit * 8), addr);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
+static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
+				     unsigned int hwirq, bool enable)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	__rzg2l_gpio_irq_endisable(pctrl, hwirq, enable);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void rzg2l_gpio_irq_disable(struct irq_data *d)
@@ -2477,15 +2484,25 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	gpiochip_disable_irq(gc, hwirq);
 }
 
-static void rzg2l_gpio_irq_enable(struct irq_data *d)
+static void __rzg2l_gpio_irq_enable(struct irq_data *d, bool lock)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
 	gpiochip_enable_irq(gc, hwirq);
+	if (lock)
+		rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
+	else
+		__rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
 	irq_chip_enable_parent(d);
 }
 
+static void rzg2l_gpio_irq_enable(struct irq_data *d)
+{
+	__rzg2l_gpio_irq_enable(d, true);
+}
+
 static int rzg2l_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	return irq_chip_set_type_parent(d, type);
@@ -2631,11 +2648,11 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 		 * This has to be atomically executed to protect against a concurrent
 		 * interrupt.
 		 */
-		spin_lock_irqsave(&pctrl->lock, flags);
+		raw_spin_lock_irqsave(&pctrl->lock, flags);
 		ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
 		if (!ret && !irqd_irq_disabled(data))
-			rzg2l_gpio_irq_enable(data);
-		spin_unlock_irqrestore(&pctrl->lock, flags);
+			__rzg2l_gpio_irq_enable(data, false);
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 		if (ret)
 			dev_crit(pctrl->dev, "Failed to set IRQ type for virq=%u\n", virq);
@@ -2965,7 +2982,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 				     "failed to enable GPIO clk\n");
 	}
 
-	spin_lock_init(&pctrl->lock);
+	raw_spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
 	mutex_init(&pctrl->mutex);
 	atomic_set(&pctrl->wakeup_path, 0);
@@ -3108,7 +3125,7 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
 	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	pctrl->data->pwpr_pfc_lock_unlock(pctrl, false);
 
 	/* Restore port registers. */
@@ -3153,7 +3170,7 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
 	}
 
 	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
-- 
2.43.0


