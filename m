Return-Path: <stable+bounces-90084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5509BE0AA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 09:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B691C2089D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542A1DEFE7;
	Wed,  6 Nov 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jowW9uYA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38B1DEFE0
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881206; cv=none; b=piqQLxrkyqmeCk5w07mQj3zEwMc4Ar7JOkxuGQqEiKDkd+Jwlby94uAUDq5Xhvu+M/JnFFdx+aswgCHPp78d74zkEN9hdO6g1MT6Nnl000zTcf9Uw4fZpLz84Vtm5r3/NaoygbEc4yr7eR20Ewlx3hiVbi5KJg3N1ciUfKOc664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881206; c=relaxed/simple;
	bh=PKvcYPeeVo6MZqcIj1y/OK2GcBrp7x8aZ87uUaLEPCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kVA6vKIJmXP7f8zMAOJv+gh7/9KLCRP0AmzQB+UTTK1grVFkU+jblJhDxuVQ/f++ZHX+mH+CA8r5B3fJ/4/2LQK1VEhIm7fAhL3mFleTV4vI+QL9lVVXsJExNtQvB2T3JVFcggeruivMk8VZBrrqE/n1uRu+6vEu7HQy+h/Pk+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jowW9uYA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a16b310f5so1003337666b.0
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 00:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730881203; x=1731486003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMwxZ/wNh3EItJe4u6OrzzTY0ND8WF+5jNZAaFXL5oo=;
        b=jowW9uYA/ceVMsfp8/IdB6OfrLRtnPCjSMMpF+B2CpvUm2aDf2aYDPTdIIZeRo6IRi
         lDM8nlDhGEzWb+NmV4GpCWnKEx6M+2CkKSQfXOsXZQ35L5CqVOgZ+6szBBhGbdaIBTvg
         LMFMnqQmLyuq0GNEK1FXYmyeu+xvoJ+e9ODSnsiJyM9h0axiFnfdRZfUGFIRMSE8wrG8
         mdChC5CwCbDsnvVh+sUIVmmZ0o9I/vqWCODDPHTxQt0a/yJNns5qygZsn6aMfaeNLQuV
         m9JTWrlCugiqii88QL/73wmRXkPqLOz6sUKJn+S1+PH6lRFi/AoO0dVl3rtxujq9ojTu
         RMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730881203; x=1731486003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMwxZ/wNh3EItJe4u6OrzzTY0ND8WF+5jNZAaFXL5oo=;
        b=SmDwTM5crylb2EJiNJMbe3AUxvZiuwe+wcrQCP6D4LfwH1+Spt99FtnlGjuLkPiImG
         o1Dth414y61s7UW+kwJapChnw4zxp3PJFCKZHtuUnW328Pg5vQzrS6iTbcf3GLstkjGL
         Ad6nPXfP52TNlLJaHyFWXFObsI5K2bZ/QARFo4+zJ+YNd1J07bsTxklZC8LV7T8Z6JF1
         JH563W82qKDDg+y+lKcoPPCZcr/R1bvLJFgpP0p2t68NYe0S311l7aQcceuLKe6KpiWw
         MORrv4Eu0HRuvJW1BzDGNxtPBBsi2TDid3v9ZdDmxf2NDlodmpMk/SdDBJujB4QTmxB2
         aBBw==
X-Forwarded-Encrypted: i=1; AJvYcCU8X/Gs1ZM42oaTugpze+E+nCVWLjARWQLOaYsYskni1ngUswR+7jYRpaAwHmuhGZlksjXEGb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HoVVHIv89KmlMu9NHqZ4Rhec/uWhrPOrHEwpdLAiWFwkgmam
	6isde+h/nTnB1FWUrlaEP9U9oSVEusHeHDS6zVT5rMwvZh8HE39sLPEm7CmmnW4=
X-Google-Smtp-Source: AGHT+IHza8wl50NzRTeIeafrsDLwtKSivG4FoOXk+uiSCYbSLBGMXVLloOn37+ovKQ5qgLhSm+JC7A==
X-Received: by 2002:a17:907:783:b0:a9e:b67f:cdf6 with SMTP id a640c23a62f3a-a9eb67fd1e7mr460745966b.38.1730881202577;
        Wed, 06 Nov 2024 00:20:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a2dbcsm241369766b.40.2024.11.06.00.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:20:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	linus.walleij@linaro.org,
	support.opensource@diasemi.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	Adam.Thomson.Opensource@diasemi.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 22/31] ASoC: da7213: Populate max_register to regmap_config
Date: Wed,  6 Nov 2024 10:18:17 +0200
Message-Id: <20241106081826.1211088-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106081826.1211088-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241106081826.1211088-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On the Renesas RZ/G3S SMARC Carrier II board having a DA7212 codec (using
da7213 driver) connected to one SSIF-2 available on the Renesas RZ/G3S SoC
it has been discovered that using the runtime PM API for suspend/resume
(as will be proposed in the following commits) leads to the codec not
being propertly initialized after resume. This is because w/o
max_register populated to regmap_config the regcache_rbtree_sync()
breaks on base_reg > max condition and the regcache_sync_block() call is
skipped.

Fixes: ef5c2eba2412 ("ASoC: codecs: Add da7213 codec")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index f3ef6fb55304..486db60bf2dd 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2136,6 +2136,7 @@ static const struct regmap_config da7213_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
+	.max_register = DA7213_TONE_GEN_OFF_PER,
 	.reg_defaults = da7213_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(da7213_reg_defaults),
 	.volatile_reg = da7213_volatile_register,
-- 
2.39.2


