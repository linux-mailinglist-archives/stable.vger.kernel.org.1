Return-Path: <stable+bounces-172203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3A5B300AA
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D315EAE18CB
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C02E7170;
	Thu, 21 Aug 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8qEAhmG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B02E7622;
	Thu, 21 Aug 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795565; cv=none; b=DNXyT6EvV73HJmqYt6iT4SJX8imbe2zcwJhQr5Z4mflifwhrwEWubzrdGBIXQWhluzGYK5uKzPDlSm+6lM9OS/YjGZm1tCnspHsck3UT4lE+RXDao2L0iOiOLXRIvHsdD57p3RTePSl5ToZxrZNth2Odh08NsRrfRhfRSAP+Xik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795565; c=relaxed/simple;
	bh=UdF//O7XlsnTgJa4T2coHk8X0C4twb6zPAGfs24MW6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VhrMB9QRuxT5HYyNNzly55Fl29kMSLLeEMow9dOkAbshf8l7CDoCfwW6MXQXfuw3/MkEDvoqx2eKDPY0myJ4lDsWALeJXx2DozwPq22scib99rPxP90SvENAWAFnKS/RYpuJ32pkxNufj73DWndSBGG2n42oqnoPUpviY2+JoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8qEAhmG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so8280805e9.0;
        Thu, 21 Aug 2025 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755795561; x=1756400361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g4b40+kGe+PEZVO1bYQkPJai2FR2h46IoQZaQWXRcoA=;
        b=H8qEAhmG2EblxwG3MtqiCrE7KUScd5XJfhWQywkqEedPFH70E7k0qEkpwyZqku+0up
         JzAmI3CEXTvhGu6dMTue928BSq+RUqERC5GXVaavTgMX/+3ZjQ3LuRtoo7hpz5dbyvbR
         s52AUD1AyqKDef659ELMEj3s4RuDSc4KA0OmUOxHrZ8YNZw7KVwjUdM7F1++MnDJRcvp
         drMsPoj+VbuyWq1ryC5H061eUCApKWzAD4cLeKjbdWgFERz7O2Pes26lc5P81Bx6/aRW
         Zo3dYoV/4surGDYKb9CNiL3JLALRLUkqM0/dRBInxbiBTo8KSbf2aoknypH02hQHsAFp
         yjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755795561; x=1756400361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4b40+kGe+PEZVO1bYQkPJai2FR2h46IoQZaQWXRcoA=;
        b=reI0n8oeeSo8ExR6RshlRnz8e0m16HoA1HVUHT9Uogka+4W4SAdAPFR1nmWr6llssX
         yMOuwqOEpZBP/msmx+/rUYn0HHlZtUPpD6WZQheN1viMHhBR66Qac2v/JpOWwtXVe1LV
         EIHveNGyWE8Oq9mhNfa9oK84V0aGDa5ranSznfQWGq4Sl9yvjlKEB7Clo5/MzzFpsjN3
         xkSLlZGMObMcipJ7vxPOleZX0JCF2JfcAq/t2TyVIRrK7rQRfMyhcadbF4J5UKkITHTC
         f7eHryKrVMvIG3++jvd/Xinkum0wHaqniWypNwne4yS4BQ3qU86gel0ZGiQ9P7dv/rYb
         1eKw==
X-Gm-Message-State: AOJu0YwJlG22QiwgoXVkNbfiWZJcGaC9owHc0W/ohwfGxaE9wDwgHKcc
	iCq8fxmyAd8QVsIpijQczRDAbWWlIf9rXqMC2UAkbrHiP2v9WBYLUWlw7Zxztw==
X-Gm-Gg: ASbGnctfXBFKXd67M13d3PWCzmTY87kAZ0nmZVop/hKCk1A1FvrWqzNDSHbSyN0E6A4
	JTUPb1KIwe4fsDq6udF6Neq0bC3VtZvmUCzPwpQRr5t2lCmEur5DkeIpnqYwETlPLGRmznynwnT
	4IT7Kgspkd1+ygeKPBCsSTdP9HxFg76T3ZNkcU1eH3VShwUmmZuLFLPKFJQXyC0qFpgV6ZkKrRD
	JP+MKetYPyP/QjRDuenTHKHBAeArmFYEn6b+uSZpPOmxgG7tthgv1E4nxp5sdFog/qCynPjQNXv
	PggikDltpGVb3k8moOoM/AE7nUNHhQnCDkJJWQ4PvXzXceewHeZvt7ofv6qx6fNyVxQWTX1OMnP
	VYrSKZTkFGLRG2u3S2bo5fNBwTIQWtQzpxhgivgrl19Gc9Q==
X-Google-Smtp-Source: AGHT+IHLzDoW33SSuJktP1LOS+YROMJ8T/ZI7it6WIKc/IYxyBMyMPfNTiBLskvV8NBHU5xpe5HFjQ==
X-Received: by 2002:a05:600c:16c8:b0:459:d3e2:d743 with SMTP id 5b1f17b1804b1-45b4d7b46e9mr21412935e9.8.1755795561304;
        Thu, 21 Aug 2025 09:59:21 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:9ed2:95cd:69a:8d10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4f7318af0sm2532142f8f.0.2025.08.21.09.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:59:20 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@denx.de>,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y] gpio: rcar: Use raw_spinlock to protect register access
Date: Thu, 21 Aug 2025 17:59:20 +0100
Message-ID: <20250821165920.1145912-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
[PL: manullay applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Pavel Machek <pavel@denx.de> # for 5.10-stable
---
Hi all,

Sending this patch to stable linux-5.10.y as requested by Pavel [0],
so that this can be included into CIP kernel. Ive added a
reviewed-by tag for Pavel which was provided here [0].

Similar patch is already present in linux-6.1.y and later:
 - https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpio/gpio-rcar.c?h=linux-6.1.y&id=3e300913c42041e81c5b17a970c4e078086ff2d1
 - https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpio/gpio-rcar.c?h=linux-6.12.y&id=b42c84f9e4ec5bc2885e7fd80c79ec0352f5d2af

[0] https://lore.kernel.org/all/aKb38+2Q49y8kzBl@duo.ucw.cz/

Cheers, Prabhakar
---
 drivers/gpio/gpio-rcar.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 80bf2a84f296..d5db55d78304 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -34,7 +34,7 @@ struct gpio_rcar_bank_info {
 
 struct gpio_rcar_priv {
 	void __iomem *base;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct device *dev;
 	struct gpio_chip gpio_chip;
 	struct irq_chip irq_chip;
@@ -114,7 +114,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	 * "Setting Level-Sensitive Interrupt Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure positive or negative logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, hwirq, !active_high_rising_edge);
@@ -133,7 +133,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	if (!level_trigger)
 		gpio_rcar_write(p, INTCLR, BIT(hwirq));
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
@@ -226,7 +226,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	 * "Setting General Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure positive logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, gpio, false);
@@ -241,7 +241,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	if (p->has_outdtsel && output)
 		gpio_rcar_modify_bit(p, OUTDTSEL, gpio, false);
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
@@ -310,9 +310,9 @@ static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int value)
 	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	gpio_rcar_modify_bit(p, OUTDT, offset, value);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -329,12 +329,12 @@ static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
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
@@ -454,7 +454,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	p->dev = dev;
-	spin_lock_init(&p->lock);
+	raw_spin_lock_init(&p->lock);
 
 	/* Get device configuration from DT node */
 	ret = gpio_rcar_parse_dt(p, &npins);
-- 
2.51.0


