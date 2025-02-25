Return-Path: <stable+bounces-119471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A933A43C7C
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF507A9655
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C53267734;
	Tue, 25 Feb 2025 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j36kgmgJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2C2676F1
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481160; cv=none; b=dpKsp+/TbmYWCexMAEJyWRIiZOk4pjr+g/m3EKmFmaHeEYkFlbBuCTkDbWLysxkADNVI6q73evy10fFeTqo1vUdFbdcEptH6H3fs4b0QWXb57VwXVcvPIHoZsHk0TvKELKkZgsHg7C6MKq+6QQvfdiFfRAnSvFPBVj9rk2mxc5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481160; c=relaxed/simple;
	bh=aRLrhUecBs7vYsSHOF02+roIq61av/C2p8cKhrDLy5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJTZ1Zv1RwYYa0LAicbIMPV1G7S5+V5l2LXxGn0YtbIpugr3FT+qdJrwc23KfvZi4SE1grq860e7ggv25i2xn94au+yMdyYVj0PSFcAO2DCKrTOU2lh6BkEmF3pTCrwwDdf307bm3yUI+ppgJdl4u79D6raeY7QNGYFWM9JDxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j36kgmgJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so35724505e9.0
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 02:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740481156; x=1741085956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH7eCOhtqxJ18+f2Lrbq8HST1vCFK6UWg0TuF7cMRvY=;
        b=j36kgmgJ/5DR06t9WgegxnMIDjZrGf3MYCnIGqzQEUG4Sm3gRD3xPDsRS9aaE2oA63
         3qZqayhp4q+hAmHHhksC2TcxE3PLGYTnJhjQsVg/8SsUxW2FyQv87+EPTfRT+BYM4J8T
         yoZfDL5ikvE0L2Y5nEhyl3gPAzE6WqwX/lUvwBg5S9mQaxoIAgnIEOUXh9HyRznmEDkA
         QpIai/tgk3IoNqFSEDRubUSCgjMjS80zZJDvg57a3YVDxKs1jcFVYI/IyFC1p6ucK5d2
         F1SjP5wlHrH7t/arsHBEG3mqYxL/7vhn+eaLWETMz20YBf53TqrkTfQKOYf2jQ3XhLTg
         Fvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481156; x=1741085956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH7eCOhtqxJ18+f2Lrbq8HST1vCFK6UWg0TuF7cMRvY=;
        b=LwKA/XKWUFR6lOLv9d+M8wPBGZVhDdFEGoTEvPgpPqkSdVh343clTLdRVu7yp0CDjZ
         lssQWUltmtUFjli08NyGPz8BOo5UXFlTcw6PImTTv8Y78T9jDHPqfEGd7q5FyVr8Tabi
         gO/zjK9uTNG2F/06DzysRzJNqP8e8NUmhAuotmWaxCOsMLjzOyKkEQnDWQ2Ga07GQoJf
         FgXnbKY7kgFh4/DLURArrurKAmWrW0kh159XQFZyK88FuYGa2Rclx9M6Dhj0y25bM+b1
         Z2gtDpcAajKiz79moByS94kSL0/kGYnJbHJ6kJA4F3UEP6BYZwBv6Kp8yvi4SkdUq0Cl
         3RuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTE5wR5en/z56G4ApH0xREUgX4dOWo9JJS06M9R7lK/FAN8Tnf12Ux21vXwPYr2yHqJO0sLek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV8sfJWDbHKLs3UNwPLJ9e615bPAOW/hdeHby190mlcK+sw0HJ
	VtHvFcuKlHSxW/B7KjoP2TC2SzWkpaoziglBQXx3qQlgb6AAyDcJjvgBPDsRYoE=
X-Gm-Gg: ASbGncuXKs4Tfo0yoYLhOYEAotx73mgkcickvljSP9B2TEWuQGBTZBIkyaBc4fkc0JE
	iI67FauW/6EeLlb7YuNS2sudaW3wnkwSMg7pu+7x1yc44EUOI3c/97JlOGh6d4DaKtValcbARtL
	5yrH5qiYEdIgewBN5Zednlj3mo0KNWC+c0IjGkxryBfqNPZAnm1s6EG/jD0zZCVfLm4wM51qtEG
	8SnN5TPLxVi5c4XV5msZ5eT82bZcB70nGPq9O++QBTZs/q7tBg8+GVMtzGO9pNQE3+uq46nQzA8
	j3KuHFJhMHnsFCoJQs0GBuqIDClmtN7oh2d0JrYSkSq+zcXEFJXCAws=
X-Google-Smtp-Source: AGHT+IFdOUFXqI73ftpxREcI5cD1cyJ6UWKG6ZRltd1AfX3lyAlJrJ3iiVYWT+u+hgxLgX7yWWhCJw==
X-Received: by 2002:a05:600c:4507:b0:439:8e95:795b with SMTP id 5b1f17b1804b1-439aebf38b2mr148209225e9.31.1740481155909;
        Tue, 25 Feb 2025 02:59:15 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c50dcfsm12588815e9.0.2025.02.25.02.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:59:15 -0800 (PST)
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
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
Date: Tue, 25 Feb 2025 12:59:03 +0200
Message-ID: <20250225105907.845347-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225105907.845347-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250225105907.845347-1-claudiu.beznea.uj@bp.renesas.com>
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
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

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


