Return-Path: <stable+bounces-189086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9978DC006F0
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545973AB0CE
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5D03002D0;
	Thu, 23 Oct 2025 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNax37lN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966EA2D8360
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214785; cv=none; b=ZJD8M9VSHx8jqMG5ocZF34qT16S5mObTtSEALdDsLAnFxuszJp2GjHnqF0JM27eaG+lpyhHhI6LlUh2A/1ziprAB8Tp9YG2+D/iUO3g/ggthzndHfPYZe1dESobBV49Aj5X/MsiMB/qIDi4n0kkx+ACROrnhvaxocHx1uBbEwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214785; c=relaxed/simple;
	bh=sP1yFN5X69EjHA1XrQLO6NIRH09PVVmY0gD8350XCKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahmh7hHwfEhx9DZTnzOI2TPNL4gHWgcRh7B7jr451GK/Cy0muFy/BkGJLMo6YjBA9x0xKcvY5LqN5AqAT369AIflKAkeD5GOOEL0iy8rTc+lScBUmIPQqZ4Vyhyw5pYtDMvsZKogh+ITj3NmHpT4XISilMC4NwbUC1W9uzumsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VNax37lN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-427087fce27so97226f8f.2
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761214782; x=1761819582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YHLKzDlOLcS1osErm5kDOBwxCW+aeEx4uEbgTKleyko=;
        b=VNax37lNKW8+UFKTUjmxnZDf5U5C1pWp9yjAH6XcSkGmzGEaKPlHH0Q+x40S5RCQHa
         7n65aGv3SUQCG/zIKhJykbTZnnIevX1ulSQJq6co1OfBJ3wITO8/LXVdMBiuTs5pGZ4i
         JyTO5eE3daSf9/jk0GJ1oamy726Io9QE+44KkE46d5ggTJeGC2FNjn0PJbTgdHFe7siZ
         CCieXtblN9r2nVBKyhaIl0APRfFH+8gSSyvXaPGJ5aQhl5dDqY3Z9SoLcagcBMvB39CT
         AGytT8XsgoMaHnthJtRqg42pmPthKIC9qsHMOqmHRcf5gxlFchVoIUMGHKvE+E9ao3+c
         kvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214782; x=1761819582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHLKzDlOLcS1osErm5kDOBwxCW+aeEx4uEbgTKleyko=;
        b=DrrIGpJvUoUw4rk+KNc3Ojv7bxWxBJvtTTQkSy6gJAmFrvwKaM88Q0KEnMMoWaz2tB
         bEA5fqbw0L6P9oqxWmebocD4rViXoeN6FsZv33SXroJ0w9gMe8cb3RcKwGvAGNGVs9R3
         14taw78k8j9jmLRDJht6hjKJyqXp97atsJNd3rdnfCzJvHdEztsC67EhUwSxmqa3lv1G
         gXdEJ8OGJfv3AixEEmob8i1VKErc6YdTL1XkKlW9LM3Kf0EuyNZWuKsYwoKmSIDpgPBN
         BvhTpPg6aKdS3riF1RXOOkkJFgA7jJobrAqMTwCBBuBRogCCcQI+6ndHsBl5/taL6cko
         Dh4A==
X-Forwarded-Encrypted: i=1; AJvYcCU6UIa0JWxz3oP0eBB/xFq7yQY0hl+twuJ7NZAha/xiD8znUBfWgW+JKbZYllr5bCdGTQxZpcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWuhYRR/GojbkloBSw2NfG8XRRAZvmwlJE11O7ot8/BaVaRrW
	OZ0TeqoOCbG0dvA8h7e3TdHTjSHVWJ+FzS3ZL0F8kDY4LY1E7Qrz3oTLwa4/TYb9ByI=
X-Gm-Gg: ASbGncusbOz4n3MvQodCMAC8u2viDZFyKEvpiTo1cScc5rNWmksLf8c6YQONins7BVz
	ZIfwxqNT12pNQWspvxR85BfON3olIsxwKriEf5Ei4qVClyyr24W9KYX5ExeULOT1R0zuNdp0t1z
	pAl1oY7BX8kMrIhx5z8c5+T8ARgxAfWoIB6UVnUAs/meJv81JxPFzOBEmjBMeXyhAVe+8/DVFmq
	6Mc+86FBk/Gp0Ed9QB6TJJCX9QmwGAEiX+OPYwyvy0NAruZrn89WgG9RdKwaWk73H2vBcXCdxNx
	4F5KooKmyOsriWRdgFGui5uAf+BvB8RKh2ej9KcW50k6zw1Pg7b9pQNAJMf1DUsQfRyp+Pbha9Y
	m/bRvVLu231ZZxjj7obOXmUb8Zf82zkayU+T84/8PfELrMVEEvNceVADpiI2OfFXi9CG85H+HuX
	TOYh+hrUWZgfcCieET10wWGg==
X-Google-Smtp-Source: AGHT+IHj7IggOZbvGodn+nW38DF7QGidxY4FbIRHzT1uITsjCrIDo/bUdySa+7xP5mlr//VmMJpJdA==
X-Received: by 2002:a05:6000:1863:b0:3fc:854:8b84 with SMTP id ffacd0b85a97d-4284e54a7fbmr3485801f8f.3.1761214781926;
        Thu, 23 Oct 2025 03:19:41 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f57efsm3149173f8f.18.2025.10.23.03.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:19:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [RFT PATCH] mfd: max77620: Fix potential IRQ chip conflict when probing two devices
Date: Thu, 23 Oct 2025 12:19:40 +0200
Message-ID: <20251023101939.67991-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MAX77620 is most likely always a single device on the board, however
nothing stops board designers to have two of them, thus same device
driver could probe twice. Or user could manually try to probing second
time.

Device driver is not ready for that case, because it allocates
statically 'struct regmap_irq_chip' as non-const and stores during
probe in 'irq_drv_data' member a pointer to per-probe state
container ('struct max77620_chip').  devm_regmap_add_irq_chip() does not
make a copy of 'struct regmap_irq_chip' but store the pointer.

Second probe - either successful or failure - would overwrite the
'irq_drv_data' from previous device probe, so interrupts would be
executed in a wrong context.

Fixes: 3df140d11c6d ("mfd: max77620: Mask/unmask interrupt before/after servicing it")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware
---
 drivers/mfd/max77620.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 21d2ab3db254..3af2974b3023 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -254,7 +254,7 @@ static int max77620_irq_global_unmask(void *irq_drv_data)
 	return ret;
 }
 
-static struct regmap_irq_chip max77620_top_irq_chip = {
+static const struct regmap_irq_chip max77620_top_irq_chip = {
 	.name = "max77620-top",
 	.irqs = max77620_top_irqs,
 	.num_irqs = ARRAY_SIZE(max77620_top_irqs),
@@ -498,6 +498,7 @@ static int max77620_probe(struct i2c_client *client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	const struct regmap_config *rmap_config;
 	struct max77620_chip *chip;
+	struct regmap_irq_chip *chip_desc;
 	const struct mfd_cell *mfd_cells;
 	int n_mfd_cells;
 	bool pm_off;
@@ -508,6 +509,14 @@ static int max77620_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, chip);
+
+	chip_desc = devm_kmemdup(&client->dev, &max77620_top_irq_chip,
+				 sizeof(max77620_top_irq_chip),
+				 GFP_KERNEL);
+	if (!chip_desc)
+		return -ENOMEM;
+	chip_desc->irq_drv_data = chip;
+
 	chip->dev = &client->dev;
 	chip->chip_irq = client->irq;
 	chip->chip_id = (enum max77620_chip_id)id->driver_data;
@@ -544,11 +553,9 @@ static int max77620_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	max77620_top_irq_chip.irq_drv_data = chip;
 	ret = devm_regmap_add_irq_chip(chip->dev, chip->rmap, client->irq,
 				       IRQF_ONESHOT | IRQF_SHARED, 0,
-				       &max77620_top_irq_chip,
-				       &chip->top_irq_data);
+				       chip_desc, &chip->top_irq_data);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to add regmap irq: %d\n", ret);
 		return ret;
-- 
2.48.1


