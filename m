Return-Path: <stable+bounces-233574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNV6Cars1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A86743ADCD0
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD63302F260
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645A2399359;
	Tue,  7 Apr 2026 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WD2rH8qs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEF3AEF21
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561871; cv=none; b=pwX0H3zAf45ThAceWywTv1BCLsBNern38IQ0fWyrhrC3cfUN1Op4rBjvN02jo975Ny5RQCg1XInRCPYTvy8aSfP52iwMJpNX3ETSFIsb6ICmPXtgEKot5F0bbBmdIEjsbh8xJooggQOjH7pff/MKMleqSPdbNNKcWFgMQVwnvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561871; c=relaxed/simple;
	bh=RMDumMaz/xJNP3g7LLNKKV0ourw1QMQNe8PUEOdCOBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HarrlylvpyStrZYKl4r9+Nvdk9BO08Be2wGQR+E1+VLsSXFe6H+jQaYD13t0p0nAXQmy0DCk6pzAzd2Jzq7vBp5B1iqr25XqfJHoa9yczEyo7+eztSvUJWEPrqQZ8rO50gxLxhSlrQ/wqxm56w4Eg9c7AFK+rRi5hAF4VUMj/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WD2rH8qs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cfa33a983so2937551f8f.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775561868; x=1776166668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zA+TEws1itLcSO8y7yT7aDXOsysRhqtv1wCLiCEpvQ=;
        b=WD2rH8qsFJeCT+k0wRLwCOMvbN/5z0ShdWwpMVTkzqArZX4nwPj8MjEX0MZTD9kPKu
         Q84849n0rJmxJvmuxiH4GxQtSdQRg4/J4o17WSRBPJmXboXXq+B4W6CTQbOCZ9pACgyo
         6h/yG7ZW9flmED+t5kGPdrdAzJsLD9PUgbHEIHjx9ugX2QydIvUW7lJWzZ+IBdBVgQtt
         7WOuYMrsi3Gnxbey+EhS22gg2aqq+KwVK1unZhmCAHuNXNQ0VT2SiS1vMfivhnSm+E2A
         RfJ7Q9kItPfeZPK3hQdLy9pbtU12i9Sea8ZhL4miIHsjD2CwJSt+gAEhBnzd8cdtcWN0
         AFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561868; x=1776166668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8zA+TEws1itLcSO8y7yT7aDXOsysRhqtv1wCLiCEpvQ=;
        b=LebX3nEI4on6d7eZNHGwfB7zcz5Wto6P5HnOi6GlQPAxkgOwOVFPpqytLHwfassuE1
         g4x7fCgd+xoc2KQLOAMO/S9czTVpunX1wjEW25lKMVOld6OSHh1iZbFKBRuS3dDXD/JH
         7rCDrXcwUZS/PnT098tzeFEVvGdsgohLMQM0mU1BeptrYoLIccfWeGIDdq8ZJTTSdKrT
         Xip0F2QStoEafYOFVZ5esUSBK9Xtd+v+3pSqOoM9Q30XkN6h4hLkZN2+ARXi472iYj1z
         Q2H/x2oQKycP3Eedkfmd9oN5PucbUYYdEj4egXnuarmh6oCq2nUsnaVn743pjxxkgkpB
         CO7w==
X-Gm-Message-State: AOJu0Yw5iHyo+L5FDhFq7orD2kDWIG9ZO0Lmt39z/RqJB40nlhuQUAEd
	E4D+Y9UX7rZBzjrbJOE2vB9uc8XNSpQT+FhKxNdcIb6SjgtORfbulze16c9SCC8IKs5abZUk8Pw
	UPYGL
X-Gm-Gg: AeBDies5RGGqd7Qck2YJ3PPVrRTcbrHp+Z104U4u6GAZQOzfzehuPptrREvZOpecopj
	bocEMj2Ho03APPYFdyaZ1RL0CliZ9h0KkVnzEwgdXX2aArqJxfqsAnNeKxcPwqzFa6Yn77V9aY4
	MALzd6kozRV6IsDt+zkJfoiaNPFsY4SVaD2A1IJHbvy3r6uOMhpgpi59tsia8McHuRxObij+nip
	ag7jWpLK7IqRWzjzCWrEs6T0MgMAVufp09SjB5KFhQdqI3us1QPviiBtQFtrzLEkJxOyk41bk3r
	JkJKXBK9j/485rnaltPhRBpPLp1iZEY0sL9K3McQ+UAHy3qUbrNXfoH/9CDbvCVlYi2H4KkRZIn
	2fOEnBmHGJ73oH8U/AhZ1Y9KptfMsyIprRhBdvlKsEEHT8L30J1FX72FsGvBQOimxdloKn0Z7M4
	OpJNWa6pctq1T3CHlPP0N6ZaEkgNlXOgGUZPUIt8qgySEZ6rXijxi+
X-Received: by 2002:a5d:6708:0:b0:43d:2f69:29dd with SMTP id ffacd0b85a97d-43d2f692b1amr15750400f8f.5.1775561867602;
        Tue, 07 Apr 2026 04:37:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm50527718f8f.3.2026.04.07.04.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:37:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y 3/4] phy: renesas: rcar-gen3-usb2: Lock around hardware registers and driver data
Date: Tue,  7 Apr 2026 14:37:41 +0300
Message-ID: <20260407113742.860378-4-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-233574-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,tuxon.dev:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A86743ADCD0
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
 - in rcar_gen3_init_otg(): fixed conflict by droppping ch->soc_no_adp_ctrl check
 - in rcar_gen3_phy_usb2_irq() use spin_lock()/spin_unlock() as scoped_guard()
   is not avaialable in v5.10
 - in probe(): replace mutex_init() with spin_lock_init()
 - rcar_gen3_phy_usb2_power_off() replaced scoped_guard() as it is not
   available in v5.10
 - in rcar_gen3_phy_usb2_power_on() droppped guard to avoid compilation
   warning "ISO C90 forbids mixed declarations and code"]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 41 +++++++++++++++---------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index f66e0daa2364..558c07512c05 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2014 Cogent Embedded, Inc.
  */
 
+#include <linux/cleanup.h>
 #include <linux/extcon-provider.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -108,7 +109,7 @@ struct rcar_gen3_chan {
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
 	struct work_struct work;
-	struct mutex lock;	/* protects rphys[...].powered */
+	spinlock_t lock;	/* protects access to hardware and driver data structure. */
 	enum usb_dr_mode dr_mode;
 	bool extcon_host;
 	bool is_otg_channel;
@@ -317,6 +318,8 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
+	guard(spinlock_irqsave)(&ch->lock);
+
 	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
@@ -404,6 +407,8 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 	if (pm_runtime_suspended(dev))
 		goto rpm_put;
 
+	spin_lock(&ch->lock);
+
 	status = readl(usb2_base + USB2_OBINTSTA);
 	if (status & USB2_OBINT_BITS) {
 		dev_vdbg(dev, "%s: %08x\n", __func__, status);
@@ -412,6 +417,8 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 		ret = IRQ_HANDLED;
 	}
 
+	spin_unlock(&ch->lock);
+
 rpm_put:
 	pm_runtime_put_noidle(dev);
 	return ret;
@@ -424,6 +431,8 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	void __iomem *usb2_base = channel->base;
 	u32 val;
 
+	guard(spinlock_irqsave)(&channel->lock);
+
 	/* Initialize USB2 part */
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
@@ -450,6 +459,8 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 	void __iomem *usb2_base = channel->base;
 	u32 val;
 
+	guard(spinlock_irqsave)(&channel->lock);
+
 	rphy->initialized = false;
 
 	val = readl(usb2_base + USB2_INT_ENABLE);
@@ -466,19 +477,21 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
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
@@ -488,7 +501,8 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 out:
 	/* The powered flag should be set for any other phys anyway */
 	rphy->powered = true;
-	mutex_unlock(&channel->lock);
+
+	spin_unlock_irqrestore(&channel->lock, flags);
 
 	return 0;
 }
@@ -497,20 +511,16 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
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
 
@@ -650,7 +660,8 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	mutex_init(&channel->lock);
+	spin_lock_init(&channel->lock);
+	
 	for (i = 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy = devm_phy_create(dev, NULL,
 							phy_usb2_ops);
-- 
2.43.0


