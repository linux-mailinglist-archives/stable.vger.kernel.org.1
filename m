Return-Path: <stable+bounces-233577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFb9C6zs1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 351823ADCDF
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63131300B9D9
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FD3AEF26;
	Tue,  7 Apr 2026 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SijeqIti"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434283AE199
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561893; cv=none; b=XZLlDKPMrywizbC06wecRcKw+8y5pkvWEG/WyutkYjzNVWRWu92TE9nhKEqtaXhMKhVRrmUbuxfnlbXmm4eVqI6TodCU5IrASJF/RtMsBrTMqGqIYk85lzKFncbz08e0eWRaInQ1SDMO0RUDUBPM6Q974i7PhAJ3Ch+rXTNgc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561893; c=relaxed/simple;
	bh=8EYpdYx3HOai4g0zG7pNUpqtrkFzROJ2rSlwtnM3f8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfL3DhgUanBHZfzC6baz2IJdN9O46JnMfhks8YdBfrGbAsp+9ACO7qOLceHgSLAcFLkti7H7HTSqdYolI7yILbeUFOcA8KxCxE7OiCh9eM659hdDsbw6kNgienBMWJlEX9ja/pHWs5Jrzg40VqdN6H+ww/f4MXmk2oyZtJkmAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SijeqIti; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ad135063so18327975e9.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775561890; x=1776166690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCiXRjJD/KxiOWDVUifpQ2QC/c0L/WiO+pqpT5Gi6vQ=;
        b=SijeqIti7jH80OT6Mmbd2GZF6MtS0VSa6vJC4R9TqBk5t0RhREgaEWX91cgza2tz9U
         y0/sv8j8XnFzSak2EOq9k5HiJ7X8KAm7KuYoT4ehw2R3bF3U28jcF956B6bAT9FwXtIb
         KJSL7tQJtNz4YXtP5DwiCz+U5RE4aP17+y6V5RErlfDSEYbGBGIYx7TRjXGHFlyKnCNL
         xwXTsF6etTIww/K4I/J4TlelHA2yrX0AjJqHwYrjboLlc97g6qX6DBsljVNzyQH883jY
         ioBC8R/G3Qq5pZFmUY6H4NO1UPda1LB8vpMH+R6pZdgnfa/NKRRa0r8Zoh6x283SokwE
         J0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561890; x=1776166690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iCiXRjJD/KxiOWDVUifpQ2QC/c0L/WiO+pqpT5Gi6vQ=;
        b=jypIA8OEhCp3XhhqhmhfZBuDHxddS5xbb+OtdyCImmz3RTWOAWkHNaa/i6XNranY4U
         NruBckcoRUHnY6QcPKBhZwLfw9tX1NvjaOv8FVpHCys1CtSdifZ3glmRqyKZuiRdmWQ5
         HrAX4/cmg841FMKLmMjMxEJg5Ntv+7qkLiZCYAb8wh2NBID4rWzYqSaa/dW0n0VRLk+Z
         +2mWN7vR+NlCOeP2GJC94IrumJ7RrkJQFWbIWv5t0rBmLKZYSQXxzxNhiEIJB6/r9oc6
         C4Qh1ofTji5avLMW2YByz/H1LGfCdQyw8UDpGqFlZV9QjErsWLcx60+rEuaIQIqHzMzg
         lrjA==
X-Gm-Message-State: AOJu0YyA/ZOn0G/YRBRB6rV6+A1Juzly5iZvRYpK3JyTkiW7wuxAf+U2
	xqdaHCglmFXXNKpWV9uHoqvSFteRJ9JVAMXPg3RO7HZDAhWyhVS+C5vrWKSYy2uubHse+X+wXwm
	t8sWN
X-Gm-Gg: AeBDiet+bY0sdoawDlYE7Pvla/IpFXaeEK1uMWt0RDiaRl+9gVhxvIvIz1hiFjlmf2c
	gaP2+2iyPe/iH6JQik5YRS/bhpVVAPE76ozRNeUtvgUO6ae2/bATZYjbEQhKdJAPNmpXf53xKAS
	lFaS+dzfH945+jdFX20Cu717PsetPnS3Vvd3EuA318NiuhZG1NOwZEXrErSKhjTfmcu1JxDxbyW
	e8ZVSy411oRkH+rjOKXj98+E+Ma347rOKC8mV0wuaUr+hhA9QIR/PWGWK+c6o5HLxGx5DNoFlx0
	XIdrQxXXFXyBogplXm2+ghgoBNPmo9ghjXwK6zt21l4IbCKM2qqbIhDniYLHrPL8ubCUTUNLzMu
	L7oIYrb1YC24dnDuOExD59vkNillF4d5YN2cxTbrMKY7rwIeyeZCnO4b4utV1sDkfBX1tk/GStC
	KUmq5/7Z/zwnusS6xDlztUJZnHXzjoLiRD/VURVJQROQD8wy32Mgtg
X-Received: by 2002:a05:600c:3f0a:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-488996a206dmr251504265e9.1.1775561890340;
        Tue, 07 Apr 2026 04:38:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b739e00bsm142181705e9.10.2026.04.07.04.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:38:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.15.y 1/4] phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
Date: Tue,  7 Apr 2026 14:38:04 +0300
Message-ID: <20260407113807.860482-2-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-233577-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 351823ADCDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 54c4c58713aaff76c2422ff5750e557ab3b100d7 upstream.

It has been observed on the Renesas RZ/G3S SoC that unbinding and binding
the PHY driver leads to role autodetection failures. This issue occurs when
PHY 3 is the first initialized PHY. PHY 3 does not have an interrupt
associated with the USB2_INT_ENABLE register (as
rcar_gen3_int_enable[3] = 0). As a result, rcar_gen3_init_otg() is called
to initialize OTG without enabling PHY interrupts.

To resolve this, add rcar_gen3_is_any_otg_rphy_initialized() and call it in
role_store(), role_show(), and rcar_gen3_init_otg(). At the same time,
rcar_gen3_init_otg() is only called when initialization for a PHY with
interrupt bits is in progress. As a result, the
struct rcar_gen3_phy::otg_initialized is no longer needed.

Fixes: 549b6b55b005 ("phy: renesas: rcar-gen3-usb2: enable/disable independent irqs")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250507125032.565017-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: declare the i iterrator from
 rcar_gen3_is_any_otg_rphy_initialized() outside of for loop]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 32 +++++++++++-------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 670514d44fe3..8c03b683ba1c 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -103,7 +103,6 @@ struct rcar_gen3_phy {
 	struct rcar_gen3_chan *ch;
 	u32 int_enable_bits;
 	bool initialized;
-	bool otg_initialized;
 	bool powered;
 };
 
@@ -311,16 +310,16 @@ static bool rcar_gen3_is_any_rphy_initialized(struct rcar_gen3_chan *ch)
 	return false;
 }
 
-static bool rcar_gen3_needs_init_otg(struct rcar_gen3_chan *ch)
+static bool rcar_gen3_is_any_otg_rphy_initialized(struct rcar_gen3_chan *ch)
 {
-	int i;
+	enum rcar_gen3_phy_index i;
 
-	for (i = 0; i < NUM_OF_PHYS; i++) {
-		if (ch->rphys[i].otg_initialized)
-			return false;
+	for (i = PHY_INDEX_BOTH_HC; i <= PHY_INDEX_EHCI; i++) {
+		if (ch->rphys[i].initialized)
+			return true;
 	}
 
-	return true;
+	return false;
 }
 
 static bool rcar_gen3_are_all_rphys_power_off(struct rcar_gen3_chan *ch)
@@ -342,7 +341,7 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	if (sysfs_streq(buf, "host"))
@@ -380,7 +379,7 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	return sprintf(buf, "%s\n", rcar_gen3_is_host(ch) ? "host" :
@@ -393,6 +392,9 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	void __iomem *usb2_base = ch->base;
 	u32 val;
 
+	if (!ch->is_otg_channel || rcar_gen3_is_any_otg_rphy_initialized(ch))
+		return;
+
 	/* Should not use functions of read-modify-write a register */
 	val = readl(usb2_base + USB2_LINECTRL1);
 	val = (val & ~USB2_LINECTRL1_DP_RPD) | USB2_LINECTRL1_DPRPD_EN |
@@ -459,12 +461,9 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 		writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
 	}
 
-	/* Initialize otg part */
-	if (channel->is_otg_channel) {
-		if (rcar_gen3_needs_init_otg(channel))
-			rcar_gen3_init_otg(channel);
-		rphy->otg_initialized = true;
-	}
+	/* Initialize otg part (only if we initialize a PHY with IRQs). */
+	if (rphy->int_enable_bits)
+		rcar_gen3_init_otg(channel);
 
 	rphy->initialized = true;
 
@@ -480,9 +479,6 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 
 	rphy->initialized = false;
 
-	if (channel->is_otg_channel)
-		rphy->otg_initialized = false;
-
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val &= ~rphy->int_enable_bits;
 	if (!rcar_gen3_is_any_rphy_initialized(channel))
-- 
2.43.0


