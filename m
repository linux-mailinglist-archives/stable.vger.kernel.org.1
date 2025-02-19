Return-Path: <stable+bounces-118304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B06A3C482
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 17:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB2188EF82
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9D21FF7D3;
	Wed, 19 Feb 2025 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="K+pTgZIm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF571FF1BE
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981287; cv=none; b=mKfOi46yQ+kWfxUUmZqw62CovxTPReu4uqJRQhsDI+/nA++/xhtYYxs9+SdcWpTrxjNsbnEe+S7Wkf4fhmpz/z1WVX8XxwjffQcnb3llTFMSjzmITDHPnYnuv5hPPM+Jt4wY3mEW/ss2ARBQtfxYutkdQiEc4Hppt1gxTna6UXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981287; c=relaxed/simple;
	bh=LCck8XOmhlRfZGYdLsspO9mn2Js7FYYo/njobjx69Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/xBOPf3z2D/vnDKPqAzimXd8aEw10ZDdw2oxTozbdPEh11fZHjy88jAKPePJwyrA1KKjy8ZUjZD6lMJcKTeq3DmJibXXqh7gQVjf8278+qMTmlcXeG+RlGyFrPpkCeTfT7omZrIWn2NMm7TlZP4Bb1HAib+c8s3zvnFi7C6jVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=K+pTgZIm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso1061609666b.1
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 08:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739981284; x=1740586084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQx5Obkxi7fOoCAjVu48dboJVNwAQ7ZZpMFYowfx0L4=;
        b=K+pTgZImwgpkYfDotOZYk/NkIuq2NByOssW7AWpDG2EkaLYN1nP8HvZ/jbNLAU78uj
         /nV8DCbswwktKNrxAX/aO/61oE3NimNyXM756BKG80MGQMLJfsBiql2tcvanqcqrHqSe
         n4kIgciNl2IsKt5DxUR054jI5prP3C4j3RWvO2SCh80KRG31Hq3unFSDDWkwJ9xOw2tl
         TIPkUlflWx8THpyo7yfuASl0jg21K2Nu1uHF+NMOowcSeUZ9WgomP0+exX07UxPuhEtU
         /gyoCroFh+6h9Fag71Er3Ev+g5nV79oULKEp2T3BoakK6RcAtzUyziNPcdldnRuO2rhC
         XpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981284; x=1740586084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQx5Obkxi7fOoCAjVu48dboJVNwAQ7ZZpMFYowfx0L4=;
        b=Ef0LYq/qzwm1XfjSHbiOVIA5a99LdIHJIWKj/E3kZBn2cXCmDsxfggesSaBM/r525I
         FH/puca/mmOxexBoGKkujTTyhnZjTVAhrL8qW3fmLZU0gWgSO8dun5FginbRd6wPYWKO
         eBNFZm/YXdUP9DTdEVRIv1EwHHo5mQym6n2UXCTkUkNIE7Ut4+IqH31B0Nv6b1xtrO5e
         er0jsimEtlj26lKNoQBjwxVV08Fy8ibX3k9vIqBwT5JyuOHwCq3O/0BotT+8Y5Ayufp+
         oHHqM+bQjoYtnznHL4uXl1gyg2kuqHaDjFCNCZ5Sjqz+V0sQQ86KzP5Gf8qOmEYGqS3O
         FY3g==
X-Forwarded-Encrypted: i=1; AJvYcCWfQLRIir2fz0pfV1MKV+rDJfWyijH2EjQbiDeLp/oHcRSibNg8+3aSWnlWQ1H81o9xh5ta7fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PDXeNJdg383yc/ChbP7VOiYKdBp3g5BWzghumtSuuhnEpz2Y
	WSCL5tb0q1YLzXRp4pH8cD+Gib5APN+snZppENpxlRFkixaUitqxuEcIuLOJ7jM=
X-Gm-Gg: ASbGncuICB6G0MGgwpGwCqAoy91k+cl7DKg615I0l7f5xG4ljwpBAnyGonT7X9DgQWv
	N6IMREi2mwE8NOJ2HUzeh5jsq3kD2wGZHW4Wtpkv6PsbYz4o4gm+h3c6BEsSXh7eOpRmHBlQvOr
	tsXxaAdkaQnpy693RohI8AxzuDCFsbL3Fhs1rkeWcvI4y50GckOk1LONKvEwMP3WUBkmcneInvd
	E8ippK2F+dzF7bqD89+SEePbbI+ZqYZ4rmM4FLR9xLqieTTeFSIrZ2aivnuf2mP+Dk5nQ9IUBXl
	W+TkStKaWYrhKiGLXQpK0K/f7gkZ9hrlVV1/jB7pX063
X-Google-Smtp-Source: AGHT+IEyYVLE9+celNxGo86663B2wzUsZfpExbxct9DCQIl++bGSTCDjXotnzuNdpB6wYwo2U02c/A==
X-Received: by 2002:a17:907:34c7:b0:abb:cdca:1c08 with SMTP id a640c23a62f3a-abbcdca498fmr312301666b.16.1739981283761;
        Wed, 19 Feb 2025 08:08:03 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbc0d0b882sm327791066b.109.2025.02.19.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:08:03 -0800 (PST)
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
Subject: [PATCH RFT 4/5] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off
Date: Wed, 19 Feb 2025 18:07:47 +0200
Message-ID: <20250219160749.1750797-5-claudiu.beznea.uj@bp.renesas.com>
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

Assert PLL reset on PHY power off. This saves power.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 5c0ceba09b67..087937407b0b 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -537,9 +537,16 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 	struct rcar_gen3_chan *channel = rphy->ch;
 	int ret = 0;
 
-	scoped_guard(spinlock_irqsave, &channel->lock)
+	scoped_guard(spinlock_irqsave, &channel->lock) {
 		rphy->powered = false;
 
+		if (rcar_gen3_are_all_rphys_power_off(channel)) {
+			u32 val = readl(channel->base + USB2_USBCTR);
+			val |= USB2_USBCTR_PLL_RST;
+			writel(val, channel->base + USB2_USBCTR);
+		}
+	}
+
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
-- 
2.43.0


