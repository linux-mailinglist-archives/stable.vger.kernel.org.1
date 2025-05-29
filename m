Return-Path: <stable+bounces-148055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F711AC7910
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 08:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF7718872D7
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 06:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFA82620C6;
	Thu, 29 May 2025 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4KojXUf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C0257427
	for <stable@vger.kernel.org>; Thu, 29 May 2025 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500429; cv=none; b=kImHDt/Ea8KTT/2CNrhWKIUEebW27cf+0/M2frbbjKnOkd6Qu+hiK0FZs7STjdvbMwmtt1d5S4adWz8q0CLbNfxgBNVA6lqYM/0KuottevBW7esHVI+ldOtrYXwVV3Y3nQvFgLAiZUUfdWAi+X8KMf3dfVSs3bYZMidTfMm1Mzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500429; c=relaxed/simple;
	bh=7b378+3r0+KWEehULfd4J/Tt+ZUTOYUqhTFUYPGmOiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJTVEoaFezHSrzdrJgm7wf8h/CE+n5wGTwbbsMTR6O4W4fhDcLCyeitMiOS8Fuff5UvlAnxuipX9jw499FSwzjiU58W3dlGb1pSuSs9XPQOKX0FHjPNaWkBZ3lFRhleEjYB1nAboTW3IyY4vm9IXFLbrQR5TFS7oA6CPnz0lczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H4KojXUf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad89f717053so4262866b.1
        for <stable@vger.kernel.org>; Wed, 28 May 2025 23:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748500424; x=1749105224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBsN2M5plJXvWWWmLLNmPiCk2P2hllHuLwIt4QtOdi8=;
        b=H4KojXUfNJGZVXgtxOYWz4OqGl4MldNnJo7qsB3SrjeRoFwYc1NcMZ69+IP22yulGd
         mnc3AepzmYrC408YkHLF65LMz0PEynz6QY8abEfFSGUEF0m+APW2sPX+64/BZQJFnczZ
         l4UijyXG6TKl43cg79vRdSceuMAjUqC+f77xunbtZkEXz0Wbi3o/uCkat4Q2mGyiNpy+
         Gbno4tIYnmTWPifVcJqJ4ols4akyCDg2l0dOqA0pAQSJiQUtIqya2r2QlHbPbnjaGgk3
         XZs89onozPEmftOv4O569airGsmJwVxaayPHMxGsfSobd84FwBc1ry07uYWLHkjhTRV5
         znRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748500424; x=1749105224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBsN2M5plJXvWWWmLLNmPiCk2P2hllHuLwIt4QtOdi8=;
        b=Vh7B5Fc7ZsVrdzWarRWpq73OoS/gLpXulqtWNxXNakw+8Dl/RhOFndFomv5UBZzr+A
         lyzgQ+PVREx1XZ3PYkAhcZ8GGfw28rXP4Ut5SUqHS0mEsQYdseIT7U6AWnv8Eah61+jE
         2qb6HnIYi8td7h2lw5qsrx14uScDl2slwB5nhucqdLSc7QwJ5mWTihwkgxN7FaeP/D6I
         roGwQSUHte6CmeCpuDacO6+KYND9KXHdYKcUK250giQhLeFhCyw7rENi/yaVqo10Q5y6
         wCHfMMiqGulYoSoB6HiaLlY/TwNBZm3YvT4bdm9AVeRnpGvrBcpvStdhqAiwCshbb9XM
         Ti+A==
X-Forwarded-Encrypted: i=1; AJvYcCXXaGgsboEg4xLudQ9Kw7c6gzt9dT+fQB3WTUFDWg4DpWirCSuAfmetFsMx9OmMgczk+KkIRcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4W5mFOfhN50/qea7Jm+wLdQsN+euKY4l2CkM8bK6MUsWVGKun
	ASLoxDKp7Z2hsaUaBoDHKmAg0Aeb8Oq9jWz3bJ0AR94x1HOFizjostzmiE7ICGQYmxc=
X-Gm-Gg: ASbGncvUgeQ2hntntkR6fQgxFGN26mWoxDnkT3eF6I8tHZJYO4LYWjPpmGTPNek7+dx
	YLlIQ/KsWdhY7Z8tLSHg2NYeVENVqbBxXAUH5i5UVc76Qewfj0gSUqdHQ3b+mV2v6TxAqhQlpxP
	tdP3Scuk43i/dNxhPal3jbXNBa3zdZaAB/NmEF9FlyxSRN4+ro7vLpMSiS2Gvr4gDuALo/gUS9Y
	QdBnTaSX1N9yHt5q4ORXVGqGzQuxxibZ3V2Nlk43K4afWJLrPrlfJSD6FFn62KRSl1nQhQRzNgd
	A8yFxsjy7PTQ4uzK2rgMMoUVuUtSc8tkXrtqzLPvJ0X0HXFQ803+xMl5wIUvEA==
X-Google-Smtp-Source: AGHT+IG+2/O+2ZJBt/UVY6s6MTq2JMb3gjEh9I1cjlAGWV8qiz6P8CgGN3urpopaSLsBQ3Rzphej4w==
X-Received: by 2002:a17:907:7ba3:b0:ad8:8189:2563 with SMTP id a640c23a62f3a-ad881892688mr429545966b.12.1748500424567;
        Wed, 28 May 2025 23:33:44 -0700 (PDT)
Received: from kuoka.. ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82d97csm83083966b.60.2025.05.28.23.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 23:33:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Fenglin Wu <quic_fenglinw@quicinc.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] leds: flash: leds-qcom-flash: Fix registry access after re-bind
Date: Thu, 29 May 2025 08:33:36 +0200
Message-ID: <20250529063335.8785-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2887; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=7b378+3r0+KWEehULfd4J/Tt+ZUTOYUqhTFUYPGmOiI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoN/+/tDqCl4lA2lvhDWUP21ndaCSqzhLp82GTZ
 /yRK3QzeOOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDf/vwAKCRDBN2bmhouD
 1wwyD/46PZAK5YWqFkYuY2KPmKMDVO2FnM6uM/TnbjMZJmvWS8VyyaXctFifhG4+l82SSZduf9R
 30A+GCAuN27v+wRjjZ2uYlz1876muO8PzIh0mATcjS4VABBwMP7uXDe5aiP8XNUSni9gI9h/g6J
 gL2X0PrryiluyeiOB5yMioUYpRAqqRVEW0NYqvceCVQA3Q6+bY1czWNfEQJXV1QiE3W3xHF661W
 hi2saekDSqiReXzSfPsIPUIbfkux+wi4R+oymfpCa4/zFF54lclu+5uXqVkXvNhYRDksiyBVAdS
 3EgQdFg8EP9SJdWLf6lnPNmxD3rrwiQxAWD4mR2Xe1oozLvcPysAmU5Cj2r3Ix9rhAxYp4dp9j7
 IWsxGp7NvqDuTgLnvnbdSciUaKPYfrapVOa2atkbC8zVQlOQNBI+MvulyuU3nQK5i9wvloDChti
 RZ2Fd0aZhB7aBfEOZCz9v/HcAX8C4XS+Vm1ifT0c1SYIvqwuc0qVCvlreZMX2AbpZ+wedt6dXwy
 zyEHXL0bVXqqWA79RE/Em26mFnkNMkvnineYjFDjkDVtyQUAzY/OPtJvg5KCDZh4Swu1+uX5fsi
 yVOIcrXbrC5kzGJh2o2dZ1KhoBKqUJ9EGfMAEbIi2GpebPHWDvYdLaZZGmu3e593iNvlhfsqf2x jJA2Dx7qO5CSv+A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Driver in probe() updates each of 'reg_field' with 'reg_base':

	for (i = 0; i < REG_MAX_COUNT; i++)
		regs[i].reg += reg_base;

'reg_field' array (under variable 'regs' above) is statically allocated,
thus each re-bind would add another 'reg_base' leading to bogus
register addresses.  Constify the local 'reg_field' array and duplicate
it in probe to solve this.

Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Fix sizeof() argument (Fenglin Wu)

This is a nice example why constifying static memory is useful.
---
 drivers/leds/flash/leds-qcom-flash.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index b4c19be51c4d..89cf5120f5d5 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -117,7 +117,7 @@ enum {
 	REG_MAX_COUNT,
 };
 
-static struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
+static const struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
 	REG_FIELD(0x08, 0, 7),			/* status1	*/
 	REG_FIELD(0x09, 0, 7),                  /* status2	*/
 	REG_FIELD(0x0a, 0, 7),                  /* status3	*/
@@ -132,7 +132,7 @@ static struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
 	REG_FIELD(0x58, 0, 2),			/* therm_thrsh3 */
 };
 
-static struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
+static const struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
 	REG_FIELD(0x06, 0, 7),			/* status1	*/
 	REG_FIELD(0x07, 0, 6),			/* status2	*/
 	REG_FIELD(0x09, 0, 7),			/* status3	*/
@@ -854,11 +854,17 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 	if (val == FLASH_SUBTYPE_3CH_PM8150_VAL || val == FLASH_SUBTYPE_3CH_PMI8998_VAL) {
 		flash_data->hw_type = QCOM_MVFLASH_3CH;
 		flash_data->max_channels = 3;
-		regs = mvflash_3ch_regs;
+		regs = devm_kmemdup(dev, mvflash_3ch_regs, sizeof(mvflash_3ch_regs),
+				    GFP_KERNEL);
+		if (!regs)
+			return -ENOMEM;
 	} else if (val == FLASH_SUBTYPE_4CH_VAL) {
 		flash_data->hw_type = QCOM_MVFLASH_4CH;
 		flash_data->max_channels = 4;
-		regs = mvflash_4ch_regs;
+		regs = devm_kmemdup(dev, mvflash_4ch_regs, sizeof(mvflash_4ch_regs),
+				    GFP_KERNEL);
+		if (!regs)
+			return -ENOMEM;
 
 		rc = regmap_read(regmap, reg_base + FLASH_REVISION_REG, &val);
 		if (rc < 0) {
@@ -880,6 +886,7 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to allocate regmap field, rc=%d\n", rc);
 		return rc;
 	}
+	devm_kfree(dev, regs); /* devm_regmap_field_bulk_alloc() makes copies */
 
 	platform_set_drvdata(pdev, flash_data);
 	mutex_init(&flash_data->lock);
-- 
2.45.2


