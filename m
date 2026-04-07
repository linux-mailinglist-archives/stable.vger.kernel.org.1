Return-Path: <stable+bounces-233578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLAUDqrs1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C20863ADCD1
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B040300D1DC
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8FD3AE199;
	Tue,  7 Apr 2026 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="O3Ad1zF0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F563AE71B
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561894; cv=none; b=kZh7aOgQlkdvbLfbzrFd/DuhV26hpE6l+tFk+0MYcHJbT5hiXpwTXPkA4kQnjPfzEqKKZcV3X2B6997KGxc4MVbDcdNFtCv5N4pv9tiy8U6ExsidGrY4VEK7AV6uDU58L/Sl8ftP2x8sOUTF7rcsXWOdao/jQZI+EtXduQgBBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561894; c=relaxed/simple;
	bh=xH825UMsLzYJfXHfhQCrTD6cOWA3QYb2b4AqVUUB1Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkdPnG+2owBiVP/oEhPCIEf5PvLCUAWy35JDgkTjXSVFs5TpTCWeOliOWod1Imm00CS2896h6OV2r6NcN6vFlZZ4ntVN/HlQtmyog24FcYxhNpeDi4xiujtanPPRJA2EUI2s0un2UShvR+S2H9NkhZ/lcqDAWRBUhvxlOedwvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=O3Ad1zF0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488c2690057so1835215e9.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775561891; x=1776166691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7HJR4olU09DM/fE4vkimIOJPb5/sfgX9Z+5bcQJ80k=;
        b=O3Ad1zF0CgeghWRBChlPsh7c9JqOC2vd+gtsM7KDrU7LhNINzFPmNCl9vD/rODodQW
         Vt2aTRy/eNHoe5X1EPX7V6wm8qMSOBUl5fu1kH54xFM7CbuOIOzEyf+LQ5ACF7lkEdWm
         Rb0MCU1HPPBnHPCVI9vNBRWjDxlhqIEtF0kzaBi+l4AyAIWbIJxuT/Np55yRX5Bx6G9b
         UJQov2y4yp/dYoaNjKz9AGyIr0s+KsY3qw3f1KkGhijyUbl9+DdWGQZmc7PLXS1/dXO4
         VsngAkjgPF1dU+lM6d4vepgLCJP61TsiGkTbouCjNOTJbVQaRx857ljpZxVlYIruAI89
         8cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561891; x=1776166691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7HJR4olU09DM/fE4vkimIOJPb5/sfgX9Z+5bcQJ80k=;
        b=Qoi7bE7MV/s8JeWHq56fWSAAiNnay4z7eQ0/JknOiQc+UCFOxLyHLsbriv41WQ8yDZ
         2KO+l4MvCeZiVhIFUdttf6hDaPysQ2/PbULtO1WRKOfRZ897QwHdzJPoVgKVDuwXx1xb
         KOILxjp6sWiwOwUDqu0Tkl8z/TW1jFwVFHpzXHDiELcLSfFZlPCY+FpIcsucJdyv8CiH
         OQKmxUgjvYZe/YmIc+SPzw4cnCKLm9P66shA2kkw/GkYPCkB3bqW9wHOJmi0iqoQMsST
         NCAQiVh4Fev2ODLyq406TjetIp+QlJwcZKrOf8IZcVlRYBca5Uvc4rSo/RmJ/uG3embN
         89jg==
X-Gm-Message-State: AOJu0YzI7Qk5iU9Gl0w19fx7aUku8+1A+e55CdS2FdjSRm6SjkdxIILe
	IcOIBn4Jw3J/HQTs4eYfwjAtK5F+DpLWd2jtnDmVSiPFG1ZWgISkib73dGnQFfuV6thU52oSJgt
	DDALF
X-Gm-Gg: AeBDietNlQLdtvkTh8zp0W5MW5DbgdenKgEkqFpP0ibGQhmDZjpobYQBX8tMhoSbvhC
	bOPl4xmz2FH2ixjRuCj0P1aOChKsTSHLs5TdAg+VLYmU7P5WHfO+3eCy2tBYg7l26C0A6VDJ4GY
	doHd0W/GHMWdLRqvH8h7hesxFmWJUAKkuu/pfGGpmOCQIbjhDoIsrE+BZO8ZE/oM/Mf47B8BcCG
	30sqdNQQ+VnKqz+4q+1Up18wkY27DFqnW7oSmf6NB2mJbvbdyH0udioEhjxdRavMNHlS1GSW9ci
	CeyHeJQLjLXBlFuV6QaYA9cmvxtx+IsQs8f89D23VIC5ErsGMMZBNhOViL2N9PfMKLI0CX2FFcP
	uthrGDLCxynE5djbtM5e0+DIoujqLb3df0RPzUjUznMug9ThiQ/yi3O+BbiDzQrB1eeA0L7ymUo
	oIBKkWQJwdtAL2iNUM2NsnVb6kAt2skkn85YsHghyAzSgrQiJ885RW
X-Received: by 2002:a05:600c:1d1d:b0:488:7ebd:78 with SMTP id 5b1f17b1804b1-4889977cbb7mr226340105e9.14.1775561891505;
        Tue, 07 Apr 2026 04:38:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b739e00bsm142181705e9.10.2026.04.07.04.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:38:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.15.y 2/4] phy: renesas: rcar-gen3-usb2: Move IRQ request in probe
Date: Tue,  7 Apr 2026 14:38:05 +0300
Message-ID: <20260407113807.860482-3-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-233578-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tuxon.dev:dkim,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: C20863ADCD1
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
[claudiu.beznea: fixed conflict in probe b/w IRQ request probe and
 platform_set_drvdata() by keeping platform_set_drvdata() code before
 IRQ request code]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 46 +++++++++++++-----------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 8c03b683ba1c..d873c49500cd 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -115,7 +115,6 @@ struct rcar_gen3_chan {
 	struct work_struct work;
 	struct mutex lock;	/* protects rphys[...].powered */
 	enum usb_dr_mode dr_mode;
-	int irq;
 	u32 obint_enable_bits;
 	bool extcon_host;
 	bool is_otg_channel;
@@ -420,16 +419,25 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
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
 	if (status & ch->obint_enable_bits) {
-		dev_vdbg(ch->dev, "%s: %08x\n", __func__, status);
+		dev_vdbg(dev, "%s: %08x\n", __func__, status);
 		writel(ch->obint_enable_bits, usb2_base + USB2_OBINTSTA);
 		rcar_gen3_device_recognition(ch);
 		ret = IRQ_HANDLED;
 	}
 
+rpm_put:
+	pm_runtime_put_noidle(dev);
 	return ret;
 }
 
@@ -439,17 +447,6 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
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
@@ -485,9 +482,6 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 		val &= ~USB2_INT_ENABLE_UCOM_INTEN;
 	writel(val, usb2_base + USB2_INT_ENABLE);
 
-	if (channel->irq >= 0 && !rcar_gen3_is_any_rphy_initialized(channel))
-		free_irq(channel->irq, channel);
-
 	return 0;
 }
 
@@ -654,7 +648,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rcar_gen3_chan *channel;
 	struct phy_provider *provider;
-	int ret = 0, i;
+	int ret = 0, i, irq;
 
 	if (!dev->of_node) {
 		dev_err(dev, "This driver needs device tree\n");
@@ -670,8 +664,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		return PTR_ERR(channel->base);
 
 	channel->obint_enable_bits = USB2_OBINT_BITS;
-	/* get irq number here and request_irq for OTG in phy_init */
-	channel->irq = platform_get_irq_optional(pdev, 0);
 	channel->dr_mode = rcar_gen3_get_dr_mode(dev->of_node);
 	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
 		channel->is_otg_channel = true;
@@ -731,6 +723,20 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, channel);
 	channel->dev = dev;
 
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
+
 	provider = devm_of_phy_provider_register(dev, rcar_gen3_phy_usb2_xlate);
 	if (IS_ERR(provider)) {
 		dev_err(dev, "Failed to register PHY provider\n");
-- 
2.43.0


