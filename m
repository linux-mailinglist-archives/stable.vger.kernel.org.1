Return-Path: <stable+bounces-152437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034BAD5909
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD451882680
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E102BDC25;
	Wed, 11 Jun 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VSVjXMwp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2762BDC06
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652766; cv=none; b=tywGDomWvMle36pgMAEiDfsySe7e8GUReL1aoBe9NPcffmk61LswJdBVlHci4+o2lLDtCsXyGmAVtpGvtsZIJ5Nkkcnwhq7AdipUZHARWbsvnDz7UuBMWp1KS7Qmc3EZTPBRIvIqUm7x0LeLAPjj+QehsvVtcIvFRSRZLOtmiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652766; c=relaxed/simple;
	bh=H8gsYADbFcrqyC2iiieOy0OPyzJacy+R+vXTaFgq3kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xlufz0tOG/7ujztH3fXwQ4Ub+puDfwYimc9kCCKVYN0nUGlDTpInA/nrGw/8x+0joO9+g8EHx8JIJV6+FQIqsE6OpLKAthnH6ee0/DHYpGjsshgasCX59CrIx9UPmKy0zBHOSUA3r42DmL7LjKreVLRJ15hdr3L0O5Y+I+xE3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VSVjXMwp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so84303225e9.1
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749652762; x=1750257562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMuC13ZuL2H9XthVI7VqSTJSYoQbIcVMKBT1sR6CtOo=;
        b=VSVjXMwpkeJU7215LtcMMaTzi5Z+d5K3YEkrrATUO4admLGqn21cZewxFIF40uiV5S
         PRaltWSLn6RYfsvqugcHHuNeBWx7fES61f4NuKKsPhECJszwAd0YI50kLPa7kGX9Qt31
         WMJmTvdpBPzM3yavw2P4w6b0g1Fk7xq13/ZSAU56AQQ33obmmMPW/QNLBCfpfDa+yNkU
         LSlLKOTkDCU7fR0b6ONQ0EEnW2T/OUTZxzXHDTAgvGTdH735DQFTDOYMcR0T71aNlYa8
         RFyjrrFj+TKCxbzMc/8gOtHoP3fbhaWk+UTBpC9bStjhEUOWicDbg7J95q080/7eWcgo
         mKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652762; x=1750257562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMuC13ZuL2H9XthVI7VqSTJSYoQbIcVMKBT1sR6CtOo=;
        b=j+C1yNDi+IiHIn12dKp/RjHbTfW05eJeFXeeqcdMzRAOOxVl/vC/LK7Amt8zExKWc+
         6tmV9tvJktdGD0XoES7DhnRn0viI65oJwmUTs+lD2+ETvWY1xkkhATnQDDoiDO54Jo9O
         fsr7D/e8MFra9/7qU9C96jHIdnXCniaAHuExZxBTigv43/y7ihsMtgdO3ucR4exGMqHf
         TCI4lbA4Inl5zFmorB1S2r/fqw31Ix4VAM8AoigHM6tv/jrz/AefHyWGgIn+Lvmu/Hp+
         Va4e1zvKUfGUh5FLDcvxrQsAddzs1dZzZv6zzOqbPXrChF4f3WO0qsJzc4plBmFiwTO8
         4sPA==
X-Forwarded-Encrypted: i=1; AJvYcCWFQdFKfQ0E12VninJnJ5JAyeePrKjElfr0rJSY+tSjWbYoGsbD5vBMCKB9P2srOfKUCfGa5k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvG9rszZOvoHAoENcqH7zN1Oi8GP9XCpTJcq6DJDyoAU4cU15s
	oBnsXGeJF1N8PWCNAro0HvQTjgaqyVRGkftQMUQRmPNeg6/kP25WieLWC9G6NPhnjfI=
X-Gm-Gg: ASbGncuFp/bPJdL/+S14EjX5vYqXJ5wcxmtCFntjfbzsdstBk7WYvNu611Kf4hS2NSM
	nDxlEi5G4jQka+9/7wxO/1Kk9TVqVYvLpnSryR/lfYQ5hDu0LK3zQQ+UblZ3w3o5lJ2liTsE3Nd
	lT24EwWsaHFJjK0eL8t/smYRZIK3fxSy+qK6D5iWxDDrhNVdQPMFQnWg70EyZSIE4uxwhPf5kgG
	MEKuSENoOa6fVwtw/qM9zx6t9WAzX+qxbwLHD58yFelvJvlQs5gG4MRglmcjABWMSA2mMC6P8Gp
	oaG89heGLrphzdFla6v246vld8WuI0bDWOQmRV4gsuvLY3jgToCtbbIk7NjXtvOTQC53yjyClg=
	=
X-Google-Smtp-Source: AGHT+IFgabml/oB/zap3gijznKuefYyLzl72L15Zdx3U7B8qLlQYx/5lfGPCZwHGnJ1ITnCk8LVHwQ==
X-Received: by 2002:a05:600c:1d87:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-453248c08e4mr33894775e9.17.1749652761663;
        Wed, 11 Jun 2025 07:39:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3994:acce:fbc8:2f34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45325141245sm23208905e9.5.2025.06.11.07.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:39:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: msm: mark certain pins as invalid for interrupts
Date: Wed, 11 Jun 2025 16:39:11 +0200
Message-ID: <20250611143911.48501-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When requesting pins whose intr_detection_width setting is not 1 or 2
for interrupts (for example by running `gpiomon -c 0 113` on RB2), we'll
hit a BUG() in msm_gpio_irq_set_type(). Potentially crashing the kernel
due to an invalid request from user-space is not optimal, so let's go
through the pins and mark those that would fail the check as invalid for
the irq chip as we should not even register them as available irqs.

This function can be extended if we determine that there are more
corner-cases like this.

Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index f012ea88aa22c..77e0c2f023455 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1038,6 +1038,24 @@ static bool msm_gpio_needs_dual_edge_parent_workaround(struct irq_data *d,
 	       test_bit(d->hwirq, pctrl->skip_wake_irqs);
 }
 
+static void msm_gpio_irq_init_valid_mask(struct gpio_chip *gc,
+					 unsigned long *valid_mask,
+					 unsigned int ngpios)
+{
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	const struct msm_pingroup *g;
+	int i;
+
+	bitmap_fill(valid_mask, ngpios);
+
+	for (i = 0; i < ngpios; i++) {
+		g = &pctrl->soc->groups[i];
+		if (g->intr_detection_width != 1 &&
+		    g->intr_detection_width != 2)
+			clear_bit(i, valid_mask);
+	}
+}
+
 static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -1441,6 +1459,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_bad_irq;
 	girq->parents[0] = pctrl->irq;
+	girq->init_valid_mask = msm_gpio_irq_init_valid_mask;
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
-- 
2.48.1


