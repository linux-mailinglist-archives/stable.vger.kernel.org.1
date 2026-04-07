Return-Path: <stable+bounces-233573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KV2K5Ls1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:37:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2833ADCBA
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEAAB300AD5E
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489B3AEF33;
	Tue,  7 Apr 2026 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kE1JQ1rB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5533AEF27
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561870; cv=none; b=a1ll8sKMkgZoG508Tl6VoNJW0rZKfZ6WTVrhcOZjQ69d2ePUJ/Ef/mQG6NZj3JwNjl0L/muIR28vOhUkNWVHa6eFkh4QfEeYId2Oo7yuxec7Nxy4TWiP2bC3hI+vAqPDvqI9gLAFm82RNphY5CzvpOpXvRLXCGlC3OjwRhngwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561870; c=relaxed/simple;
	bh=u0+VE18pD2BEcZRlXJ8OLutfuS4K/mP8B9c+AlaEcxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oE5MlKyLM64ZxFNGiUD4F12Bs6kHp6dwb9pVUaoT5X6yiBt3H5faE2JaGzbYUpI/mPBkYLOK+sIpEuGc1JXTSKuCgnENJyfaLiltqawZZ1mncmvfV6O+6y2qSfgt8UHUGCOQZzeKJmsQWjk+oE2s9JmZJ/Y2o4aDQQZFhM0+bsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kE1JQ1rB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so19899335e9.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775561866; x=1776166666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDtEaPK4XC6935Bv8o858XpoD9ImObXKFwdFLPdfXIs=;
        b=kE1JQ1rB/WkEJIeCv7ULQw1kyxCmyN6hp1J6Slh+QhwpD7HXW4o6N7wSI3UX4gVfy6
         6m0dvDTAF41foVg8PvfzTFk8EbdUUi9WJJdZOHCqcoVoRW296bjBpLZV9Ze3gQO9+OEx
         ADVTaIBP4yCDzkxqUNRRSPz+hT0XnpBrck06uY25mlInhB0MSwbL01Z7yVxGRVJ+qawL
         Ma7orKX+pn/fVprO9V3HVrMy34eJjLDLtCKKQhOFMGWpMHKeKqkSfI1lE8XPjiO4877Z
         jtEpgNY835/qawDu5lKEl9jpOEcN3bGe/WcxNh8q3lxbzzQALpyBocMel/6ONsPlm98u
         S7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561866; x=1776166666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TDtEaPK4XC6935Bv8o858XpoD9ImObXKFwdFLPdfXIs=;
        b=szbLXeu/bf/mkXmSpqFeFW7mNNNBoIHMlwlQ3OhgsTcgIkTbZ0mKwg/AFGYpbMrW+D
         wQ6BVz10YN3FaTy2k522AdtNN8sRMQHKQEH9plZuC11xzdwF/kEVOwvgraxjSShIEWAw
         qe/owBuJkanH5zTfEA16oNZaYpS5Vz6adqDhdWJ0BBuX0Q18hCrDh3718EeR39XBL1au
         +d3XeQ3wLsesnlauaeyhVYFEls0EArpWpXMCmG8xp3iGWefCA9TQ2MvLiIjzFelLZvPb
         1U/lCgQlNgMoZJ++BGR5+dqB2wLM2BY68MR1rhnYROtB/kqqCawDIXeclOtM4bgveteO
         GA/A==
X-Gm-Message-State: AOJu0YyZxv6nFC6EUjIYuD9/+ZSyumwodojZrxizlD3i8R6zZ4JFmwvP
	XV7NokvDCHCSs5xkUf/V2je/e6Wv/+AaK9Q6Pzc67vIu9IQvyGqxgrVfn0hHNDRyEiw1ZDd6B44
	kN1ZA
X-Gm-Gg: AeBDieuaT7A/ThUnKQ3gXdAGIkHdSBMI/9W+cJIWdNhHsTw15GI9xaCvlqCrYaZCnpi
	nWEjzJ2Ow5P8JqZwChcX1anB9s89ci+dQWXvzUaTpSp+4ofAXKVsE8H24IcXndkPzzjO2yHwlrv
	/eluDJxV6ZCrLyGldXqoHTR2tgNkunk7nHBJojix0SRgmjBIyXJBFifMmU845XbkjXGqD5sM78X
	vsy51pmGUIqnsdXh628CH9mOr+orl/NEwNHjN0xbwiaC1nILIZYeMLfWqOZzvL116RARMW8u2Nw
	qB9W9p4i9BLTw3dvXMVvgZiPqBRJC5TAryN/VHimYVdSK3OKXq9RsHH+Ik6EsLg3aJHOuuT5q6j
	czj7LDcI6bAohcWI5CV4BVh8/jilMndZ29bLsY+oj42iE+GvviEkDNuTv3tm4zyUpTQMi2WKkPD
	REDKEdfOVgv4gzir3Yk0a0gJe/2ohUtqhzKyhrR0GJcfAlf+/PJL38UcKbWw00hzQ=
X-Received: by 2002:a05:600c:638e:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-488997b23c6mr230364425e9.24.1775561866529;
        Tue, 07 Apr 2026 04:37:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm50527718f8f.3.2026.04.07.04.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:37:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y 2/4] phy: renesas: rcar-gen3-usb2: Move IRQ request in probe
Date: Tue,  7 Apr 2026 14:37:40 +0300
Message-ID: <20260407113742.860378-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407113742.860378-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407113742.860378-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-233573-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,tuxon.dev:dkim,renesas.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC2833ADCBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit de76809f60cc938d3580bbbd5b04b7d12af6ce3a upstream.

Commit 08b0ad375ca6 ("phy: renesas: rcar-gen3-usb2: move IRQ registration
to init") moved the IRQ request operation from probe to
struct phy_ops::phy_init API to avoid triggering interrupts (which lead to
register accesses) while the PHY clocks (enabled through runtime PM APIs)
are not active. If this happens, it results in a synchronous abort.

One way to reproduce this issue is by enabling CONFIG_DEBUG_SHIRQ, which
calls free_irq() on driver removal.

Move the IRQ request and free operations back to probe, and take the
runtime PM state into account in IRQ handler. This commit is preparatory
for the subsequent fixes in this series.

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250507125032.565017-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflicts by:
 - dropping irq and obint_enable_bits members of rcar_gen3_chan
 - using USB2_OBINT_BITS marco in rcar_gen3_phy_usb2_irq()
 - keeping irq local variable in rcar_gen3_phy_usb2_probe()
 - dropping channel->irq and channel->obint_enable_bits asssignement from
   probe
 - keeping platform_set_drvdata() and channel->dev assignment in probe]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 46 +++++++++++++-----------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 646a5140b30e..f66e0daa2364 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -110,7 +110,6 @@ struct rcar_gen3_chan {
 	struct work_struct work;
 	struct mutex lock;	/* protects rphys[...].powered */
 	enum usb_dr_mode dr_mode;
-	int irq;
 	bool extcon_host;
 	bool is_otg_channel;
 	bool uses_otg_pins;
@@ -396,16 +395,25 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 {
 	struct rcar_gen3_chan *ch = _ch;
 	void __iomem *usb2_base = ch->base;
-	u32 status = readl(usb2_base + USB2_OBINTSTA);
+	struct device *dev = ch->dev;
 	irqreturn_t ret = IRQ_NONE;
+	u32 status;
 
+	pm_runtime_get_noresume(dev);
+
+	if (pm_runtime_suspended(dev))
+		goto rpm_put;
+
+	status = readl(usb2_base + USB2_OBINTSTA);
 	if (status & USB2_OBINT_BITS) {
-		dev_vdbg(ch->dev, "%s: %08x\n", __func__, status);
+		dev_vdbg(dev, "%s: %08x\n", __func__, status);
 		writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
 		rcar_gen3_device_recognition(ch);
 		ret = IRQ_HANDLED;
 	}
 
+rpm_put:
+	pm_runtime_put_noidle(dev);
 	return ret;
 }
 
@@ -415,17 +423,6 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	struct rcar_gen3_chan *channel = rphy->ch;
 	void __iomem *usb2_base = channel->base;
 	u32 val;
-	int ret;
-
-	if (!rcar_gen3_is_any_rphy_initialized(channel) && channel->irq >= 0) {
-		INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
-		ret = request_irq(channel->irq, rcar_gen3_phy_usb2_irq,
-				  IRQF_SHARED, dev_name(channel->dev), channel);
-		if (ret < 0) {
-			dev_err(channel->dev, "No irq handler (%d)\n", channel->irq);
-			return ret;
-		}
-	}
 
 	/* Initialize USB2 part */
 	val = readl(usb2_base + USB2_INT_ENABLE);
@@ -461,9 +458,6 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 		val &= ~USB2_INT_ENABLE_UCOM_INTEN;
 	writel(val, usb2_base + USB2_INT_ENABLE);
 
-	if (channel->irq >= 0 && !rcar_gen3_is_any_rphy_initialized(channel))
-		free_irq(channel->irq, channel);
-
 	return 0;
 }
 
@@ -612,7 +606,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	struct phy_provider *provider;
 	struct resource *res;
 	const struct phy_ops *phy_usb2_ops;
-	int ret = 0, i;
+	int ret = 0, i, irq;
 
 	if (!dev->of_node) {
 		dev_err(dev, "This driver needs device tree\n");
@@ -628,8 +622,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (IS_ERR(channel->base))
 		return PTR_ERR(channel->base);
 
-	/* get irq number here and request_irq for OTG in phy_init */
-	channel->irq = platform_get_irq_optional(pdev, 0);
 	channel->dr_mode = rcar_gen3_get_dr_mode(dev->of_node);
 	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
 		channel->is_otg_channel = true;
@@ -683,6 +675,20 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, channel);
 	channel->dev = dev;
+	
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO) {
+		ret = irq;
+		goto error;
+	} else if (irq > 0) {
+		INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
+		ret = devm_request_irq(dev, irq, rcar_gen3_phy_usb2_irq,
+				       IRQF_SHARED, dev_name(dev), channel);
+		if (ret < 0) {
+			dev_err(dev, "Failed to request irq (%d)\n", irq);
+			goto error;
+		}
+	}
 
 	provider = devm_of_phy_provider_register(dev, rcar_gen3_phy_usb2_xlate);
 	if (IS_ERR(provider)) {
-- 
2.43.0


