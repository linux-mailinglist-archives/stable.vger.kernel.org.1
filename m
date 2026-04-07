Return-Path: <stable+bounces-233579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMN0ErHs1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 845133ADCF4
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0983301069C
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03CE3AE6F7;
	Tue,  7 Apr 2026 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MSGnepGJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB689399359
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561896; cv=none; b=BSjFdUQHdARKs0O5R1vjlcStLzc9hjMpxw8i29whjbvKk4WwosHLDC9aVgb+hY6eCd2a7F0KsgBZBALaJQ44QlVHfqD88/6b/kqkmvcq04OqWTjITycEV9mcLpfxIBTXzwx4sxKSNUUjl2Sd9sF+RwT0Qul2H2NDBfzgQKDHnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561896; c=relaxed/simple;
	bh=mdasbA9Qwh7Hj0zZSunLB3ptajm+1ivCs0GOq1t1XPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eo0bzEK3NsZcGj/88AtADVxpk2eNkr9TIF4Eslsx4sRgO5sPkR+F/39fd+f0vcXehaMw7BRhMp0ga4QqnE+8fFwO+uU6lS9Z8TxRiY81JQaoK1k6D7hjk9v2Ieut61sDnrU51csgdsntAkCVWFKjnyWirXAzZf5shdG6w587o2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MSGnepGJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso35356435e9.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775561893; x=1776166693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ovli3a/tWGFW3WdVzaw2IuMWqm8TaiU+j5wx0APflQ=;
        b=MSGnepGJtMLUN3zEL7uLIz7ZgfL4PtO/yK4tRo/IxLyAo/7IPTeloUq3yZQrbIJnw2
         itWEt6V7n3R4XIO0jaKsJdG/LDhes6rXIXWPo44YzDZWb5/Ab/BAOorZGQdqKF5fpwsF
         tL1HUOOn1e2VsvV46XNqTr3UUBWRwdO2EE2wlkEa9S5sdcwxIirlQYvEctYWA2thA8es
         GwjXI2G/dmG+pGRQl9HUlpLT++ROeOEOICAEVWKJKQuNSSleUydFZTqKjtHPvAJSDT8D
         +kdujA0O859CN6+benHpcV6o88aREYfWgMkkheAt9ZEBEsuMsxSBqDwdNOQNjJT6PmV8
         rWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561893; x=1776166693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Ovli3a/tWGFW3WdVzaw2IuMWqm8TaiU+j5wx0APflQ=;
        b=Osc8V5P04dG9pMcHel5eZbkcm6OiTwO2y78kt6h71cs/z+UNUgMdj1CiHWjzqeQGVL
         zo/R41ZuLBi/StzWxu9ZCd0NlO1GbmKuGK6Ang+Tl6GSjo6lbiSlr3H/0fbAZmXGJcj1
         0Zuq258Y0PMy0iQUxdzDGwKKHSgbIZvBI7uFjy0aXb66iR8O563ovS+GShLjm4hM5tUs
         crTloYjE2Ws+vYen8fQ1ZBcbBaxZWAdPs1Fy6TCLLitKInFjBomowFnR2nNaKDu+DEhX
         T97U9fClb9sHnrux42C41XGoprALpV3aqADQga3qD6+zEqKW6EoYqKRO639wWnBJhziX
         H7jw==
X-Gm-Message-State: AOJu0Yzenmd+mfhIR+5/xIj5AAToxPIFrrFonv9EmH7Mj/vb6TQKbmBw
	CfDGeXkbjclY71wvI3EP06Iba4FW9k2tU/vIoOW4fjc2JbSlrtEgqOEDg2xBReYHDtDhg4zl7rx
	2C04V
X-Gm-Gg: AeBDieuzGzlCTQDu1PPLkxrDV1HSPC/+mqEy3rE2u8qJgLG3J9faR360/syfGhtWoVF
	NInQ8Kq/vOC7erfoujIG4ix+So0poXHsn7xjzTRXJUl31tlSwKbqDJmthcvqXuJlefRh1awD7GH
	ab9plWjFf9BwJeJtHhhJlQDKNd+aLagvaEecgZQSKJgUka8EWtDkmuKO2KSUJZq1ikAOT22O2k3
	17oPEb+lnA6XUqZVu/dKN5rtiMyiG4B0VbHrqWEGRI3dZZLaBQcBM1g0aTX+Qi0wROmTxxinxzD
	FccocjHEt/7xIZ4Sylyo/lm+SXYf64W4FD2/EUCroihOO3yNymJKnnYXtKFJ/BEty3XQ7cD6dXB
	N73mWeIwc06E4eKiMoSZO8J2+UT3XP2Z5blG5J/IcRaDhHqmxmn7DR0aFggB4M6WWpOxJgZiQ4f
	pWTOYxUbN2SPt+fTkmmovNbAUsJcp1fyVbm0sGP78+Yk7I8XJGhkOl
X-Received: by 2002:a05:600c:3b18:b0:488:90ac:8f71 with SMTP id 5b1f17b1804b1-488997152camr217830995e9.5.1775561892585;
        Tue, 07 Apr 2026 04:38:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b739e00bsm142181705e9.10.2026.04.07.04.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:38:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.15.y 3/4] phy: renesas: rcar-gen3-usb2: Lock around hardware registers and driver data
Date: Tue,  7 Apr 2026 14:38:06 +0300
Message-ID: <20260407113807.860482-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407113807.860482-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407113807.860482-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-233579-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 845133ADCF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 55a387ebb9219cbe4edfa8ba9996ccb0e7ad4932 upstream.

The phy-rcar-gen3-usb2 driver exposes four individual PHYs that are
requested and configured by PHY users. The struct phy_ops APIs access the
same set of registers to configure all PHYs. Additionally, PHY settings can
be modified through sysfs or an IRQ handler. While some struct phy_ops APIs
are protected by a driver-wide mutex, others rely on individual
PHY-specific mutexes.

This approach can lead to various issues, including:
1/ the IRQ handler may interrupt PHY settings in progress, racing with
   hardware configuration protected by a mutex lock
2/ due to msleep(20) in rcar_gen3_init_otg(), while a configuration thread
   suspends to wait for the delay, another thread may try to configure
   another PHY (with phy_init() + phy_power_on()); re-running the
   phy_init() goes to the exact same configuration code, re-running the
   same hardware configuration on the same set of registers (and bits)
   which might impact the result of the msleep for the 1st configuring
   thread
3/ sysfs can configure the hardware (though role_store()) and it can
   still race with the phy_init()/phy_power_on() APIs calling into the
   drivers struct phy_ops

To address these issues, add a spinlock to protect hardware register access
and driver private data structures (e.g., calls to
rcar_gen3_is_any_rphy_initialized()). Checking driver-specific data remains
necessary as all PHY instances share common settings. With this change,
the existing mutex protection is removed and the cleanup.h helpers are
used.

While at it, to keep the code simpler, do not skip
regulator_enable()/regulator_disable() APIs in
rcar_gen3_phy_usb2_power_on()/rcar_gen3_phy_usb2_power_off() as the
regulators enable/disable operations are reference counted anyway.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250507125032.565017-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea:
 - in rcar_gen3_phy_usb2_irq() and rcar_gen3_phy_usb2_power_off() replaced
   scoped_guard() with spin_lock()/spin_unlock(), since scoped_guard() is
   not available in v5.15
 - in rcar_gen3_phy_usb2_power_on() used spin_lock_irqsave()/
   spin_unlock_irqrestore() instead of guard() to avoid compilation warning
   "ISO C90 forbids mixed declarations and code"]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 42 +++++++++++++++---------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index d873c49500cd..0626e00ccea7 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2014 Cogent Embedded, Inc.
  */
 
+#include <linux/cleanup.h>
 #include <linux/extcon-provider.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -113,7 +114,7 @@ struct rcar_gen3_chan {
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
 	struct work_struct work;
-	struct mutex lock;	/* protects rphys[...].powered */
+	spinlock_t lock;	/* protects access to hardware and driver data structure. */
 	enum usb_dr_mode dr_mode;
 	u32 obint_enable_bits;
 	bool extcon_host;
@@ -340,6 +341,8 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
+	guard(spinlock_irqsave)(&ch->lock);
+
 	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
@@ -407,7 +410,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 		val = readl(usb2_base + USB2_ADPCTRL);
 		writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
 	}
-	msleep(20);
+	mdelay(20);
 
 	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
 	writel(ch->obint_enable_bits, usb2_base + USB2_OBINTEN);
@@ -428,6 +431,8 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 	if (pm_runtime_suspended(dev))
 		goto rpm_put;
 
+	spin_lock(&ch->lock);
+
 	status = readl(usb2_base + USB2_OBINTSTA);
 	if (status & ch->obint_enable_bits) {
 		dev_vdbg(dev, "%s: %08x\n", __func__, status);
@@ -436,6 +441,8 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 		ret = IRQ_HANDLED;
 	}
 
+	spin_unlock(&ch->lock);
+
 rpm_put:
 	pm_runtime_put_noidle(dev);
 	return ret;
@@ -448,6 +455,8 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	void __iomem *usb2_base = channel->base;
 	u32 val;
 
+	guard(spinlock_irqsave)(&channel->lock);
+
 	/* Initialize USB2 part */
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
@@ -474,6 +483,8 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 	void __iomem *usb2_base = channel->base;
 	u32 val;
 
+	guard(spinlock_irqsave)(&channel->lock);
+
 	rphy->initialized = false;
 
 	val = readl(usb2_base + USB2_INT_ENABLE);
@@ -490,19 +501,21 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
 	struct rcar_gen3_chan *channel = rphy->ch;
 	void __iomem *usb2_base = channel->base;
+	unsigned long flags;
 	u32 val;
 	int ret = 0;
 
-	mutex_lock(&channel->lock);
-	if (!rcar_gen3_are_all_rphys_power_off(channel))
-		goto out;
-
 	if (channel->vbus) {
 		ret = regulator_enable(channel->vbus);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
+	spin_lock_irqsave(&channel->lock, flags);
+
+	if (!rcar_gen3_are_all_rphys_power_off(channel))
+		goto out;
+
 	val = readl(usb2_base + USB2_USBCTR);
 	val |= USB2_USBCTR_PLL_RST;
 	writel(val, usb2_base + USB2_USBCTR);
@@ -512,7 +525,8 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 out:
 	/* The powered flag should be set for any other phys anyway */
 	rphy->powered = true;
-	mutex_unlock(&channel->lock);
+
+	spin_unlock_irqrestore(&channel->lock, flags);
 
 	return 0;
 }
@@ -521,20 +535,16 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 {
 	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
 	struct rcar_gen3_chan *channel = rphy->ch;
+	unsigned long flags;
 	int ret = 0;
 
-	mutex_lock(&channel->lock);
+	spin_lock_irqsave(&channel->lock, flags);
 	rphy->powered = false;
-
-	if (!rcar_gen3_are_all_rphys_power_off(channel))
-		goto out;
+	spin_unlock_irqrestore(&channel->lock, flags);
 
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
-out:
-	mutex_unlock(&channel->lock);
-
 	return ret;
 }
 
@@ -697,7 +707,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (phy_data->no_adp_ctrl)
 		channel->obint_enable_bits = USB2_OBINT_IDCHG_EN;
 
-	mutex_init(&channel->lock);
+	spin_lock_init(&channel->lock);
 	for (i = 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy = devm_phy_create(dev, NULL,
 							phy_data->phy_usb2_ops);
-- 
2.43.0


