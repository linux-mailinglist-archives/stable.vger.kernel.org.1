Return-Path: <stable+bounces-120226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0BDA4DB4A
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 11:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FA81637F9
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 10:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F201FF617;
	Tue,  4 Mar 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Pw0w+0nS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9C1FF1C6
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085319; cv=none; b=B3lRi+j3H5/LgJ39S/X+wPKezecUB7oJQLdrd4p0+BMbvdVfyhvwFZ4zJd0A1TE0al/8Td6W/kVdB+2ihzLE2tMyjMpUC0BnteZNWd0ojaoZ2+/BFzhtOpQnTggbCzDVL0w+kv9udjgAarjYLTU0ixN8kkwve4ayl2zdhpqscnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085319; c=relaxed/simple;
	bh=bLz2dLr/cGG8RPcAaUZ6uYH3MnmoIVfXAgqhQmzHmFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKJeJnvLuc5iRa15VWet+n/J9y/UZ5+cx63Tz3lHiNo7QYQ73HHsGemP52z3YI+/SSTrPX62kE1Z8Xte7CX7NvlIHHJHGsOG2bVdfzAEqh/SnqIgUW2JLTfwi36DV/sUgNs/s+lOLbHt0WXzN9UDoXRxnU5iAaR0jPi7fnXf1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Pw0w+0nS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so3199294f8f.2
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 02:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1741085315; x=1741690115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+HBRuptPWMkY7eoCKW8pYKKAMIwOR9RHunbpfasXUQ=;
        b=Pw0w+0nS6QxX2+8DTM60kOU2pzbRXjZH61VyRg7IcSB0Mr6XjswImCaOjKlfTTkRhS
         M1wKdpZ2gUtd/eUWgUB5aLKhZol7TW+DgaZHySwzxb1Ciiq1kODClwtpjl8yK0J+Fu8j
         cm9RSUB9iFpmccDuMP+4dKqkb6/4tT6HCl+FMkQA/vCbbfR6FlPtNLM6RfVTj25KZwB6
         1CPzrqXMEF/xMByI8Sumxo7WhEORJmHyqLM74Ub+WtlHzzvND2/quBy8HlNtvWPeAWoc
         avaDAMvWKGIodHIkZTYKynYmrk25CV3LHCf5dVzM04Ufbw72F1mX0Uhs1LbWvOipKxdv
         beOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085315; x=1741690115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+HBRuptPWMkY7eoCKW8pYKKAMIwOR9RHunbpfasXUQ=;
        b=EG9EtSpHfMgaChcPfojlsrQo72TsuIJ266HSwAeyrupcOTNHNGJYh0k+4w6DRrtbx6
         EAmjr8MrtzqNVLuWO5JCibH9FNyPg/FHjyJ/alCUf1B2ANZ6YUQIjknXzj8Dq1v41UCY
         GtTl7qGOGH09xmqvNGo5J9TUOPlShKeU6w88Tg3Fie/m/XOEtqQ7rebz0JZe8cl47kfd
         SO3Hau/aRYjLgw45C4ylk+2FGJWwoyML1+JA5Ba370XjmuK/ecVG11yQv8IEDdafI2JO
         sgKcLsSjAsiCfwpDzfwoSKJ/B649RKejgnpbIgrKFOoLjar5LC+6+9ineBCHvnJAfIWG
         dZqg==
X-Forwarded-Encrypted: i=1; AJvYcCWRpQOAbbyN/f6Bcy/BmQ6yVouCVVRopy9ViHbgbLjF8HJ+54hpBKJZSjDw6G71NCTxGbmPuOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz338Htc1ylXm+RPDYD0NtBHl1SAJL4ro5QbDHkyB9e/xp2OV6n
	+zNwrMHKFql4maZG7/CHDKN+gi/VlqbOjCjbZ25hxL+s532FXMgg6rw8J+dCnbk=
X-Gm-Gg: ASbGncsSd7GrNAzDwre59VjLFOXXeb1FGu0HsBLsbNqwfhrfScCp+nFmXsgUNKm4YJz
	mH2wfPTSYFJLceWuwL6K+JEYGbEyYD28oHovEd7Pm9UmPD9k6HGb6OCwWMPdfp7Q6YKLa24VjdC
	/AqK/JWPfulEehduR+lFT9f5tP/31ULg7olcRdkff2vg7eG9eKQl1DXUynfDrPqTzfSq+Y5gl94
	wLFaTnWUfkNlVWS/A5rys9jsfdZbj76wbFJSN4xdPbBERhDvUngH0zBiHQfpfrnB2fVgMY9/lWo
	zOWqV9joXDgLlQIDSDHUWNHyPT5MmenRN77nBHLPPkFO0mmspVSPbmF87T2PfC9DUq2Ht0zWR6Q
	=
X-Google-Smtp-Source: AGHT+IF9/8llLwlKLJv4R6tkEHSQztdJzVM+800HKQOjt9Km4g2NNYfuA8atR483A4u0BuM7XJAbYQ==
X-Received: by 2002:a5d:6489:0:b0:390:f641:d8bb with SMTP id ffacd0b85a97d-390f641d990mr11217312f8f.36.1741085315383;
        Tue, 04 Mar 2025 02:48:35 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a38sm17445161f8f.75.2025.03.04.02.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:48:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	horms+renesas@verge.net.au,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 3/5] phy: renesas: rcar-gen3-usb2: Lock around hardware registers and driver data
Date: Tue,  4 Mar 2025 12:48:24 +0200
Message-ID: <20250304104826.4173394-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304104826.4173394-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250304104826.4173394-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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
---

Changes in v3:
- collected tags

Changes in v2:
- collected tags

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 49 +++++++++++++-----------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index aa9f301b5acb..39c73399b039 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2014 Cogent Embedded, Inc.
  */
 
+#include <linux/cleanup.h>
 #include <linux/extcon-provider.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -118,7 +119,7 @@ struct rcar_gen3_chan {
 	struct regulator *vbus;
 	struct reset_control *rstc;
 	struct work_struct work;
-	struct mutex lock;	/* protects rphys[...].powered */
+	spinlock_t lock;	/* protects access to hardware and driver data structure. */
 	enum usb_dr_mode dr_mode;
 	u32 obint_enable_bits;
 	bool extcon_host;
@@ -348,6 +349,8 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
+	guard(spinlock_irqsave)(&ch->lock);
+
 	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
@@ -415,7 +418,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 		val = readl(usb2_base + USB2_ADPCTRL);
 		writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
 	}
-	msleep(20);
+	mdelay(20);
 
 	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
 	writel(ch->obint_enable_bits, usb2_base + USB2_OBINTEN);
@@ -436,12 +439,14 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 	if (pm_runtime_suspended(dev))
 		goto rpm_put;
 
-	status = readl(usb2_base + USB2_OBINTSTA);
-	if (status & ch->obint_enable_bits) {
-		dev_vdbg(dev, "%s: %08x\n", __func__, status);
-		writel(ch->obint_enable_bits, usb2_base + USB2_OBINTSTA);
-		rcar_gen3_device_recognition(ch);
-		ret = IRQ_HANDLED;
+	scoped_guard(spinlock, &ch->lock) {
+		status = readl(usb2_base + USB2_OBINTSTA);
+		if (status & ch->obint_enable_bits) {
+			dev_vdbg(dev, "%s: %08x\n", __func__, status);
+			writel(ch->obint_enable_bits, usb2_base + USB2_OBINTSTA);
+			rcar_gen3_device_recognition(ch);
+			ret = IRQ_HANDLED;
+		}
 	}
 
 rpm_put:
@@ -456,6 +461,8 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	void __iomem *usb2_base = channel->base;
 	u32 val;
 
+	guard(spinlock_irqsave)(&channel->lock);
+
 	/* Initialize USB2 part */
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
@@ -479,6 +486,8 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 	void __iomem *usb2_base = channel->base;
 	u32 val;
 
+	guard(spinlock_irqsave)(&channel->lock);
+
 	rphy->initialized = false;
 
 	val = readl(usb2_base + USB2_INT_ENABLE);
@@ -498,16 +507,17 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
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
 
+	guard(spinlock_irqsave)(&channel->lock);
+
+	if (!rcar_gen3_are_all_rphys_power_off(channel))
+		goto out;
+
 	val = readl(usb2_base + USB2_USBCTR);
 	val |= USB2_USBCTR_PLL_RST;
 	writel(val, usb2_base + USB2_USBCTR);
@@ -517,7 +527,6 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 out:
 	/* The powered flag should be set for any other phys anyway */
 	rphy->powered = true;
-	mutex_unlock(&channel->lock);
 
 	return 0;
 }
@@ -528,18 +537,12 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 	struct rcar_gen3_chan *channel = rphy->ch;
 	int ret = 0;
 
-	mutex_lock(&channel->lock);
-	rphy->powered = false;
-
-	if (!rcar_gen3_are_all_rphys_power_off(channel))
-		goto out;
+	scoped_guard(spinlock_irqsave, &channel->lock)
+		rphy->powered = false;
 
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
-out:
-	mutex_unlock(&channel->lock);
-
 	return ret;
 }
 
@@ -750,7 +753,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (phy_data->no_adp_ctrl)
 		channel->obint_enable_bits = USB2_OBINT_IDCHG_EN;
 
-	mutex_init(&channel->lock);
+	spin_lock_init(&channel->lock);
 	for (i = 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy = devm_phy_create(dev, NULL,
 							phy_data->phy_usb2_ops);
-- 
2.43.0


