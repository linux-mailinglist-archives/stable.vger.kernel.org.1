Return-Path: <stable+bounces-189091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B66C007E3
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559CF188BB8F
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D5C30C62E;
	Thu, 23 Oct 2025 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYrAgg0M"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37530C368
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215352; cv=none; b=QxQTptDm/1auq0vPXpRRUYOUr3bP0GG9kpOETErcgzhdwXV9L3PdqwmGSAGhzECiuRQvpdIZHgy+GuipxRM6h2oDastoDLOYFayu00oZr2YxnUql+xExnFIV3WMy5O2EvGjOExpNBwzYllEZypajlyJt8TeB3+eTXTuy0sdQ4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215352; c=relaxed/simple;
	bh=pluT3fe/JrETSIHHgu8mtUlYeIruYoNzHyfoBOUg2eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMiLXX5OQHAIFrFDNrm23fNuM3meXSCIG+sf+z7i0v87lSUsdc/Gv7Ixu3IqijoePYF6AO+GueulC9FxIacgTaMi0xUTcNcm65cmGYHrsNFYENLLD3LZ2QuScD+yvPTUQGR4VFWO2OTQvdU9zvyFNPMwNzxJ/rfHEHoNIcMlAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DYrAgg0M; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-427054641f0so97951f8f.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761215348; x=1761820148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NHJKzwfxsuuIDKuJ2Y7MxCWL8cdo6xWLdj43JgzP38U=;
        b=DYrAgg0MyQHo7Bm7OUT96PTZNeNOtJHh9yLUZauxKO2Lx9kiaZBewwlj+Soa+RP/aK
         6FEfmbW4isiSa2MoIAgv3BvDvTnpH0lQTpjVrmCmPUTgY4wvW7KXRFSSNnbpBFkk8oF9
         s1Y4VXZVZm0nUWMWhJWx5n6v7ETnnC1cdj9tGmlmvYK0Rsp2Ls6kANhX38s7jihLUQPk
         0WuPypPNPWm6Hh/BSPMWGZfW/VLasO4rC+G1iwY1HJGsPa4qoWxmxYmyLA9+mgLQ/zPt
         QKN2fFeJV0QESDqeD8ka9xbTHDjXCwzEGLsVD0PKWgFVbaQIGHOxOISbAiXcOXROh71H
         wN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215348; x=1761820148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHJKzwfxsuuIDKuJ2Y7MxCWL8cdo6xWLdj43JgzP38U=;
        b=qe8PBPsHel92tDcOv/Tx1f/hTf7JbtVbyUHkg9E3jaqOlpYDPTJQ2bliNkYyBDSaIJ
         ZAFM7YH1hGSlQUxyFuq5CLk7dmeLrEsSPblwOgoOYehhd0sVG4Se13dOzO6WaoaKqHxu
         ywzSf4cPPQm8diSI+VFITrs8mJHKwQqQdF3hzEFq1c+7AAKv+6vQmne8HApFJvDjOy/D
         G+TaJzC3BwBbP3jGzEMEF97CJetIA90HAzT+9OjXDL8Y9xlVC6HME60sINeOTQKYKHS4
         DvvhYPjf82BOu7LAo7Din9g4XW17A8zc/I32/XsWebEw46iqijPeCaHlxanpJlTe0UEd
         OlTg==
X-Gm-Message-State: AOJu0YytMfz+HXEQqg5RIkBNshFDNsTl2PuN9QKuFfNFEHowD4h9JnQc
	YLvwEEsAgjZJeWZWNk3GHQW98oIIdXKUDGrzpm5pEc1BG9k/4I8dsdrQpUgYvk/22W8xzZUOY84
	1CIFj
X-Gm-Gg: ASbGncts1Oc0EMABoXWS5wXBJOQ3jDp0RR0cEomBI74zFwCa2U0JDNXPq4c/DKN1hPR
	9JFLNTE4IP82A7weOvesVrpptlwTO2JS31LJt16FvxW9tVOe3swy7W9eTRC4TLV/6s9bXvjC6+l
	tsd8W2ZKdpGSKS8y2KfBG8RH8bpWUkbrEpTxxldphWrLtQfvuujlXVCw3a9fseIGPElJIp4/4XN
	Ci+asSWO5vPDrVpj7n947yyvZjYVXNagMQZS4LlxdNUD/O86wC6e1/YdZ9tkGYDqsAakLRBoxCa
	BFKJV68kwQDeSNrwPPN3Xr0DXvvo0Do9+q/mVgmGFJyj9Y0fkbiosJCsMaHZqRxYfnS/ipN7xUn
	IvK0re2AdfYqSzNOGAh9cYgBUO4QNIrq+xlqCCJOTVTsjfd3KzypXj7DaMYSFWw/H6Z9rSXWjaZ
	Me77OvNtbYyrM=
X-Google-Smtp-Source: AGHT+IEpZ5MhhD+4VmCipbsuMXBPQNWZTP9mAos6+Z9IvudfJzgjQzAoyUcSmbnGkZ8yQ+8VCn1FXQ==
X-Received: by 2002:a05:600c:1ca9:b0:46e:2562:ed71 with SMTP id 5b1f17b1804b1-47494260568mr52916995e9.1.1761215348549;
        Thu, 23 Oct 2025 03:29:08 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898cc930sm3816280f8f.33.2025.10.23.03.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:29:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] power: supply: max77705: Fix potential IRQ chip conflict when probing two devices
Date: Thu, 23 Oct 2025 12:29:06 +0200
Message-ID: <20251023102905.71535-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MAX77705 charger is most likely always a single device on the board,
however nothing stops board designers to have two of them, thus same
device driver could probe twice. Or user could manually try to probing
second time.

Device driver is not ready for that case, because it allocates
statically 'struct regmap_irq_chip' as non-const and stores during
probe in 'irq_drv_data' member a pointer to per-probe state
container ('struct max77705_charger_data').  devm_regmap_add_irq_chip()
does not make a copy of 'struct regmap_irq_chip' but stores the pointer.

Second probe - either successful or failure - would overwrite the
'irq_drv_data' from previous device probe, so interrupts would be
executed in a wrong context.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware
---
 drivers/power/supply/max77705_charger.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index b1a227bf72e2..1044bf58aeac 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -60,7 +60,7 @@ static const struct regmap_irq max77705_charger_irqs[] = {
 	REGMAP_IRQ_REG_LINE(MAX77705_AICL_I, BITS_PER_BYTE),
 };
 
-static struct regmap_irq_chip max77705_charger_irq_chip = {
+static const struct regmap_irq_chip max77705_charger_irq_chip = {
 	.name			= "max77705-charger",
 	.status_base		= MAX77705_CHG_REG_INT,
 	.mask_base		= MAX77705_CHG_REG_INT_MASK,
@@ -567,6 +567,7 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 {
 	struct power_supply_config pscfg = {};
 	struct max77705_charger_data *chg;
+	struct regmap_irq_chip *chip_desc;
 	struct device *dev;
 	struct regmap_irq_chip_data *irq_data;
 	int ret;
@@ -580,6 +581,13 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 	chg->dev = dev;
 	i2c_set_clientdata(i2c, chg);
 
+	chip_desc = devm_kmemdup(dev, &max77705_charger_irq_chip,
+				 sizeof(max77705_charger_irq_chip),
+				 GFP_KERNEL);
+	if (!chip_desc)
+		return -ENOMEM;
+	chip_desc->irq_drv_data = chg;
+
 	chg->regmap = devm_regmap_init_i2c(i2c, &max77705_chg_regmap_config);
 	if (IS_ERR(chg->regmap))
 		return PTR_ERR(chg->regmap);
@@ -599,11 +607,9 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 	if (IS_ERR(chg->psy_chg))
 		return PTR_ERR(chg->psy_chg);
 
-	max77705_charger_irq_chip.irq_drv_data = chg;
 	ret = devm_regmap_add_irq_chip(chg->dev, chg->regmap, i2c->irq,
 					IRQF_ONESHOT, 0,
-					&max77705_charger_irq_chip,
-					&irq_data);
+					chip_desc, &irq_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add irq chip\n");
 
-- 
2.48.1


