Return-Path: <stable+bounces-178918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC1B491EE
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 16:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DB816244C
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 14:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D609221546;
	Mon,  8 Sep 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Aqm6jvxd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58022F3631
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342578; cv=none; b=t6HTeI0jp9PjQq2hfZoJLanRXbWLrjWezqr2Y6bKilijJpmUPHfonOEOLdaToWTRdISc+aD7lpA4J5A2qu65hX0q5cDASEkhk9MJLxPP6B0nsxdYhlk9NTdUC5JRmX/PYLNprFibQL8s+GOcOXbn9wT/+/2tY460AHmczb2PEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342578; c=relaxed/simple;
	bh=Pef8ZcIRSGjQdN3RhxwI1HY6z7sTeqMIr56CfJQxRck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPlImA1g4aM3V4HHhlPc/QIJf5bt5OxH794FoftTmX9Uf0VhZz1TKHoSUzLEk8TvgqIQd7yXzgTBhhFhTjStZFMio927bFKEVuIU45PCLzOJSnjRSWoRXiNLRBsGHhBuKbgQ5BQjWPEVE1ILL0/tK9ZbPgH4zOWMuZ8aKCYYs6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Aqm6jvxd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3df35a67434so2791946f8f.3
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757342574; x=1757947374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2XT49uZBrmoanoEg2rzPnpC/Ye8Mq5+fec+QKzWs6q0=;
        b=Aqm6jvxdMcyw+GW4Q6WxSg9UPCDFjzKopnMDhj0U/JPc5IuohOVDEyupkiqaawFhdH
         +d1K961rEPcJIygQGuqSLkQSTtFrYGSu3hBQUpn6N/mrMAzq17mn4WpLM59R5phtEFnp
         Vf+fPnLo0ae/2Z2ZmxDub3dOXL9CGswv9RdAUAiZHwqphhpvgHtN9sRqQeLMxSTShYQ2
         jyyATCyqkF+1w5DsWI3TePwi/ZIJ7h/locMyhalRS6lMYmZzQ1WCVqrXFy/6H2QvXwUL
         urUUofXvG0ed5fQixLO0YDsxIULh/be0icANn6B+Eh1Q7SxaqFQ6ws1yjEiVtnqGoUlB
         iQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757342574; x=1757947374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XT49uZBrmoanoEg2rzPnpC/Ye8Mq5+fec+QKzWs6q0=;
        b=cSD00KZoTGcZZICzndQUKyiovPy2VDhxDsE2hRhCzxvazpYJLJY9zsuAhpDrvZSvGX
         p4tTyc7RRkndlYurhBC7GcFWPkGHl0/5p+jU0m/JHtR96tOMLQ9HYi2UoBGfEfdrstyA
         LvDDWXGxbeC3oADw3BnPY91x3pv8FHaikj66dZ7RTqTnFNcKVP/Z0QUE6QMCNxe/VM34
         NTUG1vEW1L1u8Mp6jNgQkJfFqNQ2a0qPnfMLQR53Z0U8LXBiayZEH1sg89pH7af3JSFn
         nsQ/ILJIcy99eQSMFRmyhc2iPyz6e7O5WOA1cXMkKOGsv38l/IeQoQYkGV/qEhO3U8oi
         78FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjIW1x4dT1XWG47MxhpLDzIzBETCbqGvhoTVR/NX8W7Vw0coQlolcnvc8QTOTtEoQddmtamy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/F29lLclOxgav3E41hzkWk5VBAA7v3MgnSOPPVGVkDevvHYw
	DLbrT2lF7Awt5UyLcmRcrQrnRGgIcNWcH41BBllf8HhqdVpqaJ8SvsDmVta3TLn8AnDjk0knALp
	XGHXI
X-Gm-Gg: ASbGncv1wWnO6rOxDQYPY70ePtIYGUzjALel+CuUtaAetOZjMJBo9J/IO0RyoDBsUUH
	EKCGYZEfZC0ou+0cU5L5haloHFd/N6mYD5Bl4oUiWNETqSeuhzfnx5+UOW1baV8tZDhP9Qy7lbn
	CMcsSTTFYj/HZeEP9LjxXEmtKtihdCg3pa+BCxcxzDMZpLw08wLO7o6iZdNDwDePN4VNvIv8/0m
	XDw6Qc1vi8VY/C33MgXw/h/ErgOzCU0ndRNTQK3ig7LX0vx+m5bUaH/FGXpwbAF2uleTMZI/ZNv
	SASTISGiEbJ38FR4KBg+2OEEq46TXL35+2s76ZLVKweP+r1cFAsJNOM6R3IrXIjK+EreX+Ng5TH
	VUjo+xDiLrPbEoWCLRPv5DjR2u3tQVYs=
X-Google-Smtp-Source: AGHT+IEOxn2MkD1hAjHpmR6MdeAdLkCUCAnBGHQm7CrSlP/CiF2CFQfIFjgfSaAHRzVDFcv4n5/zhg==
X-Received: by 2002:a05:6000:2210:b0:3de:e787:5d7b with SMTP id ffacd0b85a97d-3e643eff2f6mr6483640f8f.46.1757342574139;
        Mon, 08 Sep 2025 07:42:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e115c4f755sm17086101f8f.39.2025.09.08.07.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:42:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com
To: geert+renesas@glider.be,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: renesas: rzg2l: Fix ISEL restore on resume
Date: Mon,  8 Sep 2025 17:42:50 +0300
Message-ID: <20250908144250.1269294-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in
gpio_irq_{en,dis}able*()") dropped the configuration of ISEL from
rzg2l_gpio_irq_enable()/rzg2l_gpio_irq_disable() and moved it to
rzg2l_gpio_child_to_parent_hwirq()/rzg2l_gpio_irq_domain_free() to fix
spurious IRQs.

The resume code used rzg2l_gpio_irq_enable() (called from
rzg2l_gpio_irq_restore()) to reconfigure the wakeup interrupts. Some
drivers (e.g. Ethernet) may also reconfigure interrupts in their own code,
eventually calling rzg2l_gpio_irq_enable(), when these are not wakeup
interrupts.

After commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL
in gpio_irq_{en,dis}able*()"), ISEL was no longer configured properly after
resume.

Fix this by adding rzg2l_gpio_irq_endisable() back into
rzg2l_gpio_irq_enable(), and by using its unlocked variant in
rzg2l_gpio_irq_restore(). Having IRQs enable in rzg2l_gpio_irq_enable()
should be safe with respect to spurious IRQs, as in the probe case IRQs are
enabled anyway in rzg2l_gpio_child_to_parent_hwirq(). No spurious IRQs
were detected on suspend/resume tests (executed on RZ/G3S).

Fixes: 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in gpio_irq_{en,dis}able*(")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index b182b3b8a542..6ae1ee3ffc81 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2428,7 +2428,7 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl
 }
 
 static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
-				     unsigned int hwirq, bool enable)
+				     unsigned int hwirq, bool enable, bool lock)
 {
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
 	u64 *pin_data = pin_desc->drv_data;
@@ -2443,12 +2443,16 @@ static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
 		addr += 4;
 	}
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	if (lock)
+		spin_lock_irqsave(&pctrl->lock, flags);
+
 	if (enable)
 		writel(readl(addr) | BIT(bit * 8), addr);
 	else
 		writel(readl(addr) & ~BIT(bit * 8), addr);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	if (lock)
+		spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void rzg2l_gpio_irq_disable(struct irq_data *d)
@@ -2460,15 +2464,22 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	gpiochip_disable_irq(gc, hwirq);
 }
 
-static void rzg2l_gpio_irq_enable(struct irq_data *d)
+static void rzg2l_gpio_irq_enable_helper(struct irq_data *d, bool lock)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
 	gpiochip_enable_irq(gc, hwirq);
+	rzg2l_gpio_irq_endisable(pctrl, hwirq, true, lock);
 	irq_chip_enable_parent(d);
 }
 
+static void rzg2l_gpio_irq_enable(struct irq_data *d)
+{
+	rzg2l_gpio_irq_enable_helper(d, true);
+}
+
 static int rzg2l_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	return irq_chip_set_type_parent(d, type);
@@ -2570,7 +2581,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 		goto err;
 	}
 
-	rzg2l_gpio_irq_endisable(pctrl, child, true);
+	rzg2l_gpio_irq_endisable(pctrl, child, true, true);
 	pctrl->hwirq[irq] = child;
 	irq += pctrl->data->hwcfg->tint_start_index;
 
@@ -2617,7 +2628,7 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 		spin_lock_irqsave(&pctrl->lock, flags);
 		ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
 		if (!ret && !irqd_irq_disabled(data))
-			rzg2l_gpio_irq_enable(data);
+			rzg2l_gpio_irq_enable_helper(data, false);
 		spin_unlock_irqrestore(&pctrl->lock, flags);
 
 		if (ret)
@@ -2640,7 +2651,7 @@ static void rzg2l_gpio_irq_domain_free(struct irq_domain *domain, unsigned int v
 
 		for (i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
 			if (pctrl->hwirq[i] == hwirq) {
-				rzg2l_gpio_irq_endisable(pctrl, hwirq, false);
+				rzg2l_gpio_irq_endisable(pctrl, hwirq, false, true);
 				rzg2l_gpio_free(gc, hwirq);
 				spin_lock_irqsave(&pctrl->bitmap_lock, flags);
 				bitmap_release_region(pctrl->tint_slot, i, get_order(1));
-- 
2.43.0


