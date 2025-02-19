Return-Path: <stable+bounces-118305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E399A3C48F
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 17:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4C1179E6A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28CA200BA8;
	Wed, 19 Feb 2025 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ehy0sari"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AB1FF5FB
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981288; cv=none; b=VjS0KYkIpgC2/7XqbmyouFp3qjPDf8F8ApkDSTIVTIfDy1OpxeD3Qm9mKOyucsqxmI5/j+CwqrOX4/Mj6dd9cLs8bthiKpmx/olmekdsqBglZFrSoDSLLMt/vug3xJluIa4M8iIVWoCny2fqezlXhZ95V8bWBk2aR37nWkC2BoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981288; c=relaxed/simple;
	bh=Nu+B+aent9gnDnLeup0LX+XZtFmQ3i9h19QHH4qM5Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1MGdbmh1X5aMqqFG7HtNiXmv3W6LjrzonCI1zAXJ8h3d2Y5vWFrCgt2soouMa6MzV3uThiC9MGUwtUg2YxI4+nqX6b2oDTXJ7gsmq2QWSIPoYFWNj93UqHtta8iVf4bK+i4rpYkVHaM9MY9qWXzvGh5eAP/tDunoZ7qsfwx3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ehy0sari; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaec111762bso1600282266b.2
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 08:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739981285; x=1740586085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtGBoe5coeUnXZJpUlOcRLqzBSKuMVRJ9kwi5GgXX1M=;
        b=Ehy0sariCfO4XSF/zqmG1HB8+NOcqx3EyYI89+XO3YwUnm05s+gG6Z8o9zMG9X+13p
         OiBW8ElNlzC3y84Gkc/7SMswqUa6RkS+VH3/Hl6IdWySdOzMflAc5A3cKMGu+0QgiMEu
         RWWbFaUCyL1mtPdcnSXXOJDoeEho21NNwTzIIp3hk90zUiQyB0W/HC+POMOQ45Emgqgx
         Ut1EBEVjIQU4O9V5NIU9EzOBtD+YIydLuhQe5PjZmiAkbpNUQtpXLHNmuCqGBN/3++sb
         R1OiDmJcdaY1oq1g81gOYmhYr6AuNfvKD4XgWc5SNaa9oKilkwY2P5h1FqSHg9GlwnUg
         RyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981285; x=1740586085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtGBoe5coeUnXZJpUlOcRLqzBSKuMVRJ9kwi5GgXX1M=;
        b=o2BNj6m0V3sPThIAUpawRNv4dftuVKUaxsoKonE84Zv1+TYevw7YOqMXwo4tiOlvZg
         S550/jvrIzlWCBwtpKMv7+H9tF425FuzhZkPfhWISWYyXczJNLw6F9d5vjYnEc1hCNpJ
         VTe9Y1F7/z53q0GGTe4HIRZbSnz/AWttuANWyJB/XL+qixUpprGXGo914gzYwYiR7Syq
         LHzSWDIJNQJAfyL5sI+0PBWb/5bVEK0YjLQimfLY6i6afkZq98LMOPBiN7BFpzYnEwUH
         sVJ4AM1ytxVsojs8GPPJlIb09Yy+RjnGCJgueF32+e12Z7JsBNo7IzhAOD7lUXd7afTr
         e9sw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/McnM9PhvUtNPZQZVYTHFlkFT6fkCo6AZ+xW+SrYtL0VC9bca3SqW+kAIsjGcv9+dCRishE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHsq1y5LQS8BXSc5L7SmU4nkSEPOXy6i7bTAQItWOsHAMDTqNu
	7MdHTlVAZu9fZNoKN3Uc4ob15b7AKN21VCFh4J+fuE5Pr3HLmTRXwOpiYVerW5g=
X-Gm-Gg: ASbGncukhD8FBEUw0gfZvl7fCxI1bxwlbsPyYOG1VJ7kIt+2AqXVSwYq752QPdmaWM0
	Ft3G6qrMSahObEMqZ8lpfds7QpSQTaWBMvVPF2vk5OXuPo3mSU6J9xJ89eu11G+JyintCf5EZof
	pDweaKkwKtDfmTzLp1bhKxbMHAHYSFn17Kv13rLYE3YeGrsY08UrxeyR024LK8Q7718jH8bmP/N
	T7EMgrs4qLSR8Kcsk1lYls9JfNQboWp9jHV25pBj6TSFXx05SuxRXQgIPeelueslJC2CuBmDaXu
	0xSuuHaeBpr1FmYzDE930qlqIEliY3HlFMKDPV87PhBT
X-Google-Smtp-Source: AGHT+IHxe5ZyQ3C/l0BujyjIhZwXC57yvWHfxRUBHLFeh5ZxtlbAM5sS46OrKTP8YZUtyZ2rOwWbYQ==
X-Received: by 2002:a17:906:9b4b:b0:ab7:c3c9:2ab1 with SMTP id a640c23a62f3a-abbcd0d1b4emr437963966b.50.1739981285101;
        Wed, 19 Feb 2025 08:08:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbc0d0b882sm327791066b.109.2025.02.19.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:08:04 -0800 (PST)
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
Subject: [PATCH RFT 5/5] phy: renesas: rcar-gen3-usb2: Set timing registers only once
Date: Wed, 19 Feb 2025 18:07:48 +0200
Message-ID: <20250219160749.1750797-6-claudiu.beznea.uj@bp.renesas.com>
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

phy-rcar-gen3-usb2 driver exports 4 PHYs. The timing registers are common
to all PHYs. There is no need to set them every time a PHY is initialized.
Set timing register only when the 1st PHY is initialized.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 087937407b0b..8e57fa8c1cff 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -467,8 +467,11 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
 	writel(val, usb2_base + USB2_INT_ENABLE);
-	writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
-	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
+
+	if (!rcar_gen3_is_any_rphy_initialized(channel)) {
+		writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
+		writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
+	}
 
 	/* Initialize otg part (only if we initialize a PHY with IRQs). */
 	if (rphy->int_enable_bits)
-- 
2.43.0


