Return-Path: <stable+bounces-118302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC83A3C489
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 17:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E7173F4C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2F1FE44B;
	Wed, 19 Feb 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="i1L8Bhiq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44C1FDE02
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981283; cv=none; b=L2SCdScr6Zq+bw8Omiupr8oU2rYOPkeO2+LUf3TVp2a7kM0CTuE7AUxb1zjhH/2/3o8hKUoPe4P1GESPabqTatBcXYy3vJJM42pYIlbM5YAXkjeVWb/JKx3W52gHDAkSMP+FxWMGnw7fEKhOlgbfCHkhpGDIK0RcgXQIdAdSPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981283; c=relaxed/simple;
	bh=wc4sN7qLZm+el405nRxJo5bxZYh7t6HvJ1R0u+zhzag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0+6ou2PkxK5zW+sspkWrkAOGdjz0xHFNWKBED8NDzNvTKVksgEVCG8mMyBpdNgWoR3fLL4NK3Xtn0pmUEn+5/weWMPy3dc0hcODCj1tiH0F2FCkJYT/7gTrwU9EieBpBFG6TJtqGAyX1metAT9r/nVbMPtvb/DstH30EITHfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=i1L8Bhiq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so3081436a12.0
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 08:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739981279; x=1740586079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlGt4wExiEL/CIXJbDF0itACKrrgHmIFMrYFUtPey+c=;
        b=i1L8BhiqCbPhgjhqI4Fs0WESgBOn7qro6AnnWert3MTOoZLsj7G3+Mjl1knNKEPU3F
         RyFtGuzwiVsEN0wzECKvdfNoHo4OmYtVY6vBmyEbw2yut+r0f6BuBXFpq6454LhdYMH1
         uVvamrLBEtJ/qIN+mQOtNgbYOaax7IyYSTfioADdnREZ8/5bqw3oZ3HttptNOzcaFU+Q
         yVgK0sgn4AW/9vVfarjUZkz8NPpmbTol5zMuryl7d7MRWVzi23tWpj/ZRm5QuGi5GfZq
         +VGi/mNNMz/Tw2kT+RPv3fu2B/5FQoZGomXomz7B4ckg3xVgpNmZNB+XBoS9QTQhjdof
         FHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981279; x=1740586079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlGt4wExiEL/CIXJbDF0itACKrrgHmIFMrYFUtPey+c=;
        b=M+URsv58PsQ2vK5en7ZX/ZC2lmAR2jPfC2UQRg9NQe6J04ec0q7G+NMe8EO6thxWMl
         XwTLmX4oGTJgnYPrmCzI7xC3IQ7JaBFbvsbg3WhROqES4j0iuQLjp8quAVeHr1qrAH4w
         mIoqiC2LdzXktqsTZeM2KWdN9GbwNSakzgyXe8DgaPNPINWwukgXDDBzTrQEzb+lmpQC
         t3Kti16hrgclhp5KcfBIO5z4ZvsuO6zGmlLviIy93TZwadIf5vWlf38yvQDEtRqCJQv8
         BpkI/0FWYFpmonKj+NtAe7Z7i9I4VkIxhn2bQrmIeLS6KUEtxgbsBXw5k6p+cuLZSzTW
         R/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWe0ZVt7Qkj1VpZaWVkyANAq6iddaYHfG3sIAGXdQSBmUkuMXh3ZTPtnvXRJufZDYEWxnVWR88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPl8Da5LdN+6pME1E3/aWVN5DCeU+wi4RIUSzTUjqKexxE0lK8
	6848Eg8DFDPUKVQaFJbYUDSAU0ynQBeIlmuwK56aRvayGVLn0G382vwn3TXADhM=
X-Gm-Gg: ASbGncvsqdqf8dE9M7lTWtSh/yw8/SXXHDkJfRSFgZai5l3z2pXhNCoGmCfO5TUy7Cn
	/dMVzKAJ6IBo5uTTSmCSIOm5fXMV8KizgJT4O9sAhDJzrZZYk/LmpE1tyd+j1vihJpdfmbN0Wbr
	5chWn6FHVdoKLsXtC7dbCf4fGg56E4lzVXefA1YBn0/Pg3NJkJaiU8XzP5JFIpW4YIFHyBTjnqb
	uqTBxF2BuZC/ROGrlQEhviijoXRGGMa6J9CcY+5hNQqWQGpYIwz9NwSBQr6c+2aAMEjM/BEjZsw
	eP7EYZ4dapOJ4veK1c6EBHcCzyiWdfJJvSu6IPmk1ney
X-Google-Smtp-Source: AGHT+IF44ZngvmvLQTa6/DYd9mBS4nelIO/FTgR44hs+O/p7Fl0s8INvjP10jVJEICLAlDgjE/nKmg==
X-Received: by 2002:a17:907:6d09:b0:ab7:cb84:ecd6 with SMTP id a640c23a62f3a-abb70e0d0ecmr1908734066b.56.1739981279398;
        Wed, 19 Feb 2025 08:07:59 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbc0d0b882sm327791066b.109.2025.02.19.08.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:07:59 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	horms+renesas@verge.net.au,
	fabrizio.castro@bp.renesas.com,
	robh@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RFT 1/5] phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
Date: Wed, 19 Feb 2025 18:07:44 +0200
Message-ID: <20250219160749.1750797-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219160749.1750797-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250219160749.1750797-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 33 ++++++++++--------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 775f4f973a6c..46afba2fe0dc 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -107,7 +107,6 @@ struct rcar_gen3_phy {
 	struct rcar_gen3_chan *ch;
 	u32 int_enable_bits;
 	bool initialized;
-	bool otg_initialized;
 	bool powered;
 };
 
@@ -320,16 +319,15 @@ static bool rcar_gen3_is_any_rphy_initialized(struct rcar_gen3_chan *ch)
 	return false;
 }
 
-static bool rcar_gen3_needs_init_otg(struct rcar_gen3_chan *ch)
+static bool rcar_gen3_is_any_otg_rphy_initialized(struct rcar_gen3_chan *ch)
 {
-	int i;
-
-	for (i = 0; i < NUM_OF_PHYS; i++) {
-		if (ch->rphys[i].otg_initialized)
-			return false;
+	for (enum rcar_gen3_phy_index i = PHY_INDEX_BOTH_HC; i <= PHY_INDEX_EHCI;
+	     i++) {
+		if (ch->rphys[i].initialized)
+			return true;
 	}
 
-	return true;
+	return false;
 }
 
 static bool rcar_gen3_are_all_rphys_power_off(struct rcar_gen3_chan *ch)
@@ -351,7 +349,7 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	if (sysfs_streq(buf, "host"))
@@ -389,7 +387,7 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	return sprintf(buf, "%s\n", rcar_gen3_is_host(ch) ? "host" :
@@ -402,6 +400,9 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	void __iomem *usb2_base = ch->base;
 	u32 val;
 
+	if (!ch->is_otg_channel || rcar_gen3_is_any_otg_rphy_initialized(ch))
+		return;
+
 	/* Should not use functions of read-modify-write a register */
 	val = readl(usb2_base + USB2_LINECTRL1);
 	val = (val & ~USB2_LINECTRL1_DP_RPD) | USB2_LINECTRL1_DPRPD_EN |
@@ -465,12 +466,9 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
 	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
 
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
 
@@ -486,9 +484,6 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 
 	rphy->initialized = false;
 
-	if (channel->is_otg_channel)
-		rphy->otg_initialized = false;
-
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val &= ~rphy->int_enable_bits;
 	if (!rcar_gen3_is_any_rphy_initialized(channel))
-- 
2.43.0


