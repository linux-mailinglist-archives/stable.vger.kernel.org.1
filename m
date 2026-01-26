Return-Path: <stable+bounces-211664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NbeANald2lrjwEAu9opvQ
	(envelope-from <stable+bounces-211664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:35:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E298B8B1
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6CD7302E79B
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78334D4C9;
	Mon, 26 Jan 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIhU9zFO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782E2FE595
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448903; cv=none; b=q+w87askacsJnSOrw/kcuBDmNtOZc1EuCD1TwRYCJaTF/pHMgrRpeEc0E70DwEyM+IKoy56JD4ymLFemGX6lWCsQKJ7Ax9A7h4oSYGMVPiO07d+iMi6oB9/TALJH72m8WjGTHyPY7c8ByHwIegwnJWy2Cnr5HIHKON6v06EmbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448903; c=relaxed/simple;
	bh=p5cR6L+r/9DlXjg+WOWfhu5skZgeastUVDPp9EDgrt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7l4MpShPR9yVByd8B9RP5cJiMMuCDZW9Snb9L68YZm9ywpZPdZqQy9lf4Of49ul9Lpurq8upJ+nzZ9WigPlQIoiqCeJK1/EK8OxETg+RqkxO8PDNBYSd7iiIhtRIIhoC1R/xMf6XLREGVQDLshafP0wAfJb4vzxMyuwK0CUfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIhU9zFO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-352f60d6c2fso3115223a91.1
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 09:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769448902; x=1770053702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RffcJHdsTonAwt9Ao2IhaDUDPGQyk+jkPGIUwU57TVM=;
        b=UIhU9zFOkmPOarF0TQTSox+haF5F5Ij+A30UR80iScRd2oDyBz20UEEfBtvOVhzZGS
         Etghy5KyCtvDuxGaGKJdU+Rp05X9yrEQN+m0wSwlZCts0b/VuM6KCcuPQ3mCja25WXO5
         UtVZ/9ZG/CnjVBeXW7+bnGHgKlO+rfT+m2MeNtsNbwgNmk0sue+mDMlM8uFjlFGlJ+2H
         OOvBpkJNgDoHr2D6fbVksHygIXshsqPOpDbVsjarA7EMhakBX3YdMXC1McYLMmnBMLRH
         m9fRXWAqZdrs/0/PWSvXjNdAI0w0NMBkHAtUg3O6+gC7QNJ0n2hHco+1qG/MwTXFLxEa
         VJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448902; x=1770053702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RffcJHdsTonAwt9Ao2IhaDUDPGQyk+jkPGIUwU57TVM=;
        b=XK+4Fa/3vi7ZX7gR18RXmko4wDNDRx94HPJCyOsGUSpWAZR+uMuhVWDguUeZ25+cLQ
         YIr/9W48qcIowHxe6B5tdWQ6VfL1MeCS/uFsM0CqQLb/1LoitVIwuGrt0MqGWdGZWF0f
         uoSrE9OIBDc675KuMbcW7jGjAf6N7UweB45kKGC9k8hbjCbqfx6kX8nLHKzHcyXxX9WM
         G8mL6jxmaf2Vt6zBYUrOJTyvFtAubn3LB7H1ecmjgLja2dSY1B4/ONn8H69f9x+HTkS5
         KXEyDiTDhhPflismI07UURZPSy86NsGY2HJgccatEgssf41rsViBfj8j+scAjsIT1T6V
         Snfg==
X-Forwarded-Encrypted: i=1; AJvYcCVk4knZiuEb8AndQ1MSG7tx4es6r7v/FYQZ4m+xRVbuLB9VqTeUsK+oFwOxGlgM8D5SON77rG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRq5/S2pHsA8Ay7Vcc9HYJWLrabDDxlMXRi1BmD+sJLIlGaSRy
	P3/2Dm7+0TfBKP3ykcmw6Iei6WB6pwmwyu7AYoxu5M2vJQSaVqZLEqEx
X-Gm-Gg: AZuq6aLXpGgM0f6S2cQlbRLzRdJyC04py9ZDb9LdQ47JlMGZ1JCf3t1Yjc4lzYfIx1z
	T9qab0Oo1kB3PmxBntMjNzmzmHTMOGkTJHU3M11GmmGjnhvfQRVBAuQLv29W2TUsNR9Ci+euvlh
	DDRDsl2gMPk2nldrXEE5yz2F7X/Y4Pu50P7yKYq3R46/6VI0yzqX86I7JEezfsc3/Nh1QZeEMBv
	CYvhdJxw1miLPHBibkIPpFlOSd/Dp2Z+rUDsOCiMc4E9f68+k5E5Lwyf2Ff59MlzGLeoSaERHAo
	TDSDzllXyVUb/lfwaehXDxtXp2srGkMh58IoZRMfjfiyzHzGUaMWKaDBQkqpWzSqz0tlO5k9R4v
	Y9UPhBp3KTN+fMWB9apo2qHI8Phve8GuX9soAhSMm1v8cXW+u8ZhyTVq1R+1eKp/xI5qJB/ndZo
	pyh/aNmkcvTj1fWnmUvMutivIPWXQETAchGnlt
X-Received: by 2002:a17:90b:1c01:b0:33e:1acc:1799 with SMTP id 98e67ed59e1d1-353c40c66bbmr4815618a91.14.1769448901662;
        Mon, 26 Jan 2026 09:35:01 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:e23f:af76:8280:9d84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61292bdsm86787a91.6.2026.01.26.09.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:35:01 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	rfoss@kernel.org,
	todor.too@gmail.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org,
	vladimir.zapolskiy@linaro.org,
	hansg@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	stable@vger.kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH v3 2/3] media: i2c: ov02c10: Correct power-on sequence and timing
Date: Mon, 26 Jan 2026 23:04:43 +0530
Message-ID: <20260126173444.10228-3-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126173444.10228-1-bjsaikiran@gmail.com>
References: <20260126173444.10228-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-211664-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92E298B8B1
X-Rspamd-Action: no action

1. Assert XSHUTDOWN (reset) for 10ms (T1 >= 5ms) before enabling power.
2. Enable regulators and wait 20ms for ramp-up stabilization.
3. Enable clock and wait 10ms for stabilization.
4. De-assert XSHUTDOWN.
5. Wait 20ms (T2 >= 20ms) for sensor boot before I2C access.
6. Perform software reset (0x0103) to ensure clean state.

This eliminates potential race conditions and stability issues during cold boot initialization.

Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite)
Fixes: 44f8901 ("media: i2c: add OmniVision OV02C10 sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/media/i2c/ov02c10.c | 57 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index fa7cc48b769a..ba8bbb4f433a 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -22,6 +22,8 @@
 #define OV02C10_CHIP_ID			0x5602
 
 #define OV02C10_REG_STREAM_CONTROL	CCI_REG8(0x0100)
+#define OV02C10_REG_SOFTWARE_RESET	CCI_REG8(0x0103)
+#define OV02C10_SOFTWARE_RESET_TRIGGER	0x01
 
 #define OV02C10_REG_HTS			CCI_REG16(0x380c)
 
@@ -616,6 +618,13 @@ static int ov02c10_enable_streams(struct v4l2_subdev *sd,
 	if (ret)
 		goto out;
 
+	/*
+	 * Delay before streaming:
+	 * Give the sensor time to process all the register writes and internal
+	 * calibration before we assert the STREAM_ON bit.
+	 */
+	usleep_range(2000, 2500);
+
 	ret = cci_write(ov02c10->regmap, OV02C10_REG_STREAM_CONTROL, 1, NULL);
 out:
 	if (ret)
@@ -660,13 +669,13 @@ static int ov02c10_power_off(struct device *dev)
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov02c10 *ov02c10 = to_ov02c10(sd);
 
-	gpiod_set_value_cansleep(ov02c10->reset, 1);
+	if (ov02c10->reset)
+		gpiod_set_value_cansleep(ov02c10->reset, 1);
 
+	clk_disable_unprepare(ov02c10->img_clk);
 	regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
 			       ov02c10->supplies);
 
-	clk_disable_unprepare(ov02c10->img_clk);
-
 	return 0;
 }
 
@@ -676,27 +685,53 @@ static int ov02c10_power_on(struct device *dev)
 	struct ov02c10 *ov02c10 = to_ov02c10(sd);
 	int ret;
 
-	ret = clk_prepare_enable(ov02c10->img_clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable imaging clock: %d", ret);
-		return ret;
+	if (ov02c10->reset) {
+		gpiod_set_value_cansleep(ov02c10->reset, 1);
+		usleep_range(10000, 11000);
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ov02c10_supply_names),
 				    ov02c10->supplies);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable regulators: %d", ret);
-		clk_disable_unprepare(ov02c10->img_clk);
 		return ret;
 	}
 
+	/* Allow PMIC to ramp and stabilize */
+	usleep_range(20000, 22000);
+
+	ret = clk_prepare_enable(ov02c10->img_clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable imaging clock: %d", ret);
+		regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
+				       ov02c10->supplies);
+		return ret;
+	}
+
+	/* Let the clock stabilise */
+	usleep_range(10000, 11000);
+
+	/* Release hardware reset */
 	if (ov02c10->reset) {
-		/* Assert reset for at least 2ms on back to back off-on */
-		usleep_range(2000, 2200);
 		gpiod_set_value_cansleep(ov02c10->reset, 0);
-		usleep_range(5000, 5100);
+		/*
+		 * Wait for sensor microcontroller to stabilize after reset release.
+		 * 20ms prevents black frames during rapid power cycling.
+		 */
+		usleep_range(20000, 22000);
+	}
+
+	/* Perform software reset to ensure clean state */
+	ret = cci_write(ov02c10->regmap, OV02C10_REG_SOFTWARE_RESET,
+			OV02C10_SOFTWARE_RESET_TRIGGER, NULL);
+	if (ret) {
+		dev_err(dev, "failed to send software reset: %d", ret);
+		return ret;
 	}
 
+	/* Wait for software reset to complete */
+	usleep_range(5000, 5500);
+
 	return 0;
 }
 
-- 
2.51.0


