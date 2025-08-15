Return-Path: <stable+bounces-169814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081DB28672
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 21:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE737BCFD5
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56D1DEFF5;
	Fri, 15 Aug 2025 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZh+I3nD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1182A926
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286295; cv=none; b=NDVr8ti+i+R8ydawLVTiLbDN7tL3FyHwydUB62g82/G9puvkeZxo7ByaqR8oPdzVJ/sxPTeRDtHHlwKIQDTMDRt/q5gAwU23cYAoIIl3CXvDwlB5odfnyrivv5xoc3QoCWV6K5IK2BKDfLGvjShqqV9JHde1IiR5Jjgep0wTfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286295; c=relaxed/simple;
	bh=LW6okkOBGaKq9AL9QzRdBW/oDbtNy1upSDXPZv70do0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2pN1DQ8J8ys2Gu4vOLn6ac0yFO0VA+A5BfjDcpXVlRH+KlXbVCCNo2ld15Xa0kD30oShh3UfTvRkjPRheScOYm+wN8mx30YCb2BygtCzpBns0UKAS2xbKMtgM64D1T9iMxNVD2AZd27Y4pYBrk8ggeeBWloEG9iiBfu3IsMUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZh+I3nD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DF1C4CEEB;
	Fri, 15 Aug 2025 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755286295;
	bh=LW6okkOBGaKq9AL9QzRdBW/oDbtNy1upSDXPZv70do0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZh+I3nDC+I/xajioOCyt6yTl+tpK/GzG/Hdcdd+JsYLHCLpr5Ouh4qpHZB/q05Js
	 4DLwdp4zalgpk7FKjZ8c7FUNkvDYiB72J6C3VU2Ks43sU62wXjTsyuHMhbA93yrzY6
	 2CneHT9LM54JXCgWSVMZiHdU2n7ofvXeZ9ENuuD0MxBGy2pakxDEJkTeL4F2k+sauW
	 oilZAUwQcbRrkR9IKzoiX5x51SIqmibEESfn1h4dw7vBq0g34+g7Zvrqthz/L9rBLC
	 U8yl8Q+UYpXDZOWoEeffW3ejx6jnEiIW+I2QFe3Nj8SwwjpDj+SxtHcvbcUBalQMl1
	 c1J3hPDRCKkOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fenglin Wu <quic_fenglinw@quicinc.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] leds: flash: leds-qcom-flash: Limit LED current based on thermal condition
Date: Fri, 15 Aug 2025 15:31:26 -0400
Message-ID: <20250815193127.192775-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081544-skillet-cofounder-e278@gregkh>
References: <2025081544-skillet-cofounder-e278@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fenglin Wu <quic_fenglinw@quicinc.com>

[ Upstream commit a0864cf32044233e56247fa0eed3ac660f15db9e ]

The flash module has status bits to indicate different thermal
conditions which are called as OTSTx. For each OTSTx status,
there is a recommended total flash current for all channels to
prevent the flash module entering into higher thermal level.
For example, the total flash current should be limited to 1000mA/500mA
respectively when the HW reaches the OTST1/OTST2 thermal level.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
Link: https://lore.kernel.org/r/20240705-qcom_flash_thermal_derating-v3-1-8e2e2783e3a6@quicinc.com
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: fab15f57360b ("leds: flash: leds-qcom-flash: Fix registry access after re-bind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/flash/leds-qcom-flash.c | 163 ++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index 17391aefeb94..7df4e8426528 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/bitfield.h>
@@ -14,6 +14,9 @@
 #include <media/v4l2-flash-led-class.h>
 
 /* registers definitions */
+#define FLASH_REVISION_REG		0x00
+#define FLASH_4CH_REVISION_V0P1		0x01
+
 #define FLASH_TYPE_REG			0x04
 #define FLASH_TYPE_VAL			0x18
 
@@ -73,6 +76,16 @@
 
 #define UA_PER_MA			1000
 
+/* thermal threshold constants */
+#define OTST_3CH_MIN_VAL		3
+#define OTST1_4CH_MIN_VAL		0
+#define OTST1_4CH_V0P1_MIN_VAL		3
+#define OTST2_4CH_MIN_VAL		0
+
+#define OTST1_MAX_CURRENT_MA		1000
+#define OTST2_MAX_CURRENT_MA		500
+#define OTST3_MAX_CURRENT_MA		200
+
 enum hw_type {
 	QCOM_MVFLASH_3CH,
 	QCOM_MVFLASH_4CH,
@@ -98,6 +111,9 @@ enum {
 	REG_IRESOLUTION,
 	REG_CHAN_STROBE,
 	REG_CHAN_EN,
+	REG_THERM_THRSH1,
+	REG_THERM_THRSH2,
+	REG_THERM_THRSH3,
 	REG_MAX_COUNT,
 };
 
@@ -111,6 +127,9 @@ static struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
 	REG_FIELD(0x47, 0, 5),                  /* iresolution	*/
 	REG_FIELD_ID(0x49, 0, 2, 3, 1),         /* chan_strobe	*/
 	REG_FIELD(0x4c, 0, 2),                  /* chan_en	*/
+	REG_FIELD(0x56, 0, 2),			/* therm_thrsh1 */
+	REG_FIELD(0x57, 0, 2),			/* therm_thrsh2 */
+	REG_FIELD(0x58, 0, 2),			/* therm_thrsh3 */
 };
 
 static struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
@@ -123,6 +142,8 @@ static struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
 	REG_FIELD(0x49, 0, 3),			/* iresolution	*/
 	REG_FIELD_ID(0x4a, 0, 6, 4, 1),		/* chan_strobe	*/
 	REG_FIELD(0x4e, 0, 3),			/* chan_en	*/
+	REG_FIELD(0x7a, 0, 2),			/* therm_thrsh1 */
+	REG_FIELD(0x78, 0, 2),			/* therm_thrsh2 */
 };
 
 struct qcom_flash_data {
@@ -130,9 +151,11 @@ struct qcom_flash_data {
 	struct regmap_field     *r_fields[REG_MAX_COUNT];
 	struct mutex		lock;
 	enum hw_type		hw_type;
+	u32			total_ma;
 	u8			leds_count;
 	u8			max_channels;
 	u8			chan_en_bits;
+	u8			revision;
 };
 
 struct qcom_flash_led {
@@ -143,6 +166,7 @@ struct qcom_flash_led {
 	u32				max_timeout_ms;
 	u32				flash_current_ma;
 	u32				flash_timeout_ms;
+	u32				current_in_use_ma;
 	u8				*chan_id;
 	u8				chan_count;
 	bool				enabled;
@@ -172,6 +196,127 @@ static int set_flash_module_en(struct qcom_flash_led *led, bool en)
 	return rc;
 }
 
+static int update_allowed_flash_current(struct qcom_flash_led *led, u32 *current_ma, bool strobe)
+{
+	struct qcom_flash_data *flash_data = led->flash_data;
+	u32 therm_ma, avail_ma, thrsh[3], min_thrsh, sts;
+	int rc = 0;
+
+	mutex_lock(&flash_data->lock);
+	/*
+	 * Put previously allocated current into allowed budget in either of these two cases:
+	 * 1) LED is disabled;
+	 * 2) LED is enabled repeatedly
+	 */
+	if (!strobe || led->current_in_use_ma != 0) {
+		if (flash_data->total_ma >= led->current_in_use_ma)
+			flash_data->total_ma -= led->current_in_use_ma;
+		else
+			flash_data->total_ma = 0;
+
+		led->current_in_use_ma = 0;
+		if (!strobe)
+			goto unlock;
+	}
+
+	/*
+	 * Cache the default thermal threshold settings, and set them to the lowest levels before
+	 * reading over-temp real time status. If over-temp has been triggered at the lowest
+	 * threshold, it's very likely that it would be triggered at a higher (default) threshold
+	 * when more flash current is requested. Prevent device from triggering over-temp condition
+	 * by limiting the flash current for the new request.
+	 */
+	rc = regmap_field_read(flash_data->r_fields[REG_THERM_THRSH1], &thrsh[0]);
+	if (rc < 0)
+		goto unlock;
+
+	rc = regmap_field_read(flash_data->r_fields[REG_THERM_THRSH2], &thrsh[1]);
+	if (rc < 0)
+		goto unlock;
+
+	if (flash_data->hw_type == QCOM_MVFLASH_3CH) {
+		rc = regmap_field_read(flash_data->r_fields[REG_THERM_THRSH3], &thrsh[2]);
+		if (rc < 0)
+			goto unlock;
+	}
+
+	min_thrsh = OTST_3CH_MIN_VAL;
+	if (flash_data->hw_type == QCOM_MVFLASH_4CH)
+		min_thrsh = (flash_data->revision == FLASH_4CH_REVISION_V0P1) ?
+			OTST1_4CH_V0P1_MIN_VAL : OTST1_4CH_MIN_VAL;
+
+	rc = regmap_field_write(flash_data->r_fields[REG_THERM_THRSH1], min_thrsh);
+	if (rc < 0)
+		goto unlock;
+
+	if (flash_data->hw_type == QCOM_MVFLASH_4CH)
+		min_thrsh = OTST2_4CH_MIN_VAL;
+
+	/*
+	 * The default thermal threshold settings have been updated hence
+	 * restore them if any fault happens starting from here.
+	 */
+	rc = regmap_field_write(flash_data->r_fields[REG_THERM_THRSH2], min_thrsh);
+	if (rc < 0)
+		goto restore;
+
+	if (flash_data->hw_type == QCOM_MVFLASH_3CH) {
+		rc = regmap_field_write(flash_data->r_fields[REG_THERM_THRSH3], min_thrsh);
+		if (rc < 0)
+			goto restore;
+	}
+
+	/* Read thermal level status to get corresponding derating flash current */
+	rc = regmap_field_read(flash_data->r_fields[REG_STATUS2], &sts);
+	if (rc)
+		goto restore;
+
+	therm_ma = FLASH_TOTAL_CURRENT_MAX_UA / 1000;
+	if (flash_data->hw_type == QCOM_MVFLASH_3CH) {
+		if (sts & FLASH_STS_3CH_OTST3)
+			therm_ma = OTST3_MAX_CURRENT_MA;
+		else if (sts & FLASH_STS_3CH_OTST2)
+			therm_ma = OTST2_MAX_CURRENT_MA;
+		else if (sts & FLASH_STS_3CH_OTST1)
+			therm_ma = OTST1_MAX_CURRENT_MA;
+	} else {
+		if (sts & FLASH_STS_4CH_OTST2)
+			therm_ma = OTST2_MAX_CURRENT_MA;
+		else if (sts & FLASH_STS_4CH_OTST1)
+			therm_ma = OTST1_MAX_CURRENT_MA;
+	}
+
+	/* Calculate the allowed flash current for the request */
+	if (therm_ma <= flash_data->total_ma)
+		avail_ma = 0;
+	else
+		avail_ma = therm_ma - flash_data->total_ma;
+
+	*current_ma = min_t(u32, *current_ma, avail_ma);
+	led->current_in_use_ma = *current_ma;
+	flash_data->total_ma += led->current_in_use_ma;
+
+	dev_dbg(led->flash.led_cdev.dev, "allowed flash current: %dmA, total current: %dmA\n",
+					led->current_in_use_ma, flash_data->total_ma);
+
+restore:
+	/* Restore to default thermal threshold settings */
+	rc = regmap_field_write(flash_data->r_fields[REG_THERM_THRSH1], thrsh[0]);
+	if (rc < 0)
+		goto unlock;
+
+	rc = regmap_field_write(flash_data->r_fields[REG_THERM_THRSH2], thrsh[1]);
+	if (rc < 0)
+		goto unlock;
+
+	if (flash_data->hw_type == QCOM_MVFLASH_3CH)
+		rc = regmap_field_write(flash_data->r_fields[REG_THERM_THRSH3], thrsh[2]);
+
+unlock:
+	mutex_unlock(&flash_data->lock);
+	return rc;
+}
+
 static int set_flash_current(struct qcom_flash_led *led, u32 current_ma, enum led_mode mode)
 {
 	struct qcom_flash_data *flash_data = led->flash_data;
@@ -313,6 +458,10 @@ static int qcom_flash_strobe_set(struct led_classdev_flash *fled_cdev, bool stat
 	if (rc)
 		return rc;
 
+	rc = update_allowed_flash_current(led, &led->flash_current_ma, state);
+	if (rc < 0)
+		return rc;
+
 	rc = set_flash_current(led, led->flash_current_ma, FLASH_MODE);
 	if (rc)
 		return rc;
@@ -429,6 +578,10 @@ static int qcom_flash_led_brightness_set(struct led_classdev *led_cdev,
 	if (rc)
 		return rc;
 
+	rc = update_allowed_flash_current(led, &current_ma, enable);
+	if (rc < 0)
+		return rc;
+
 	rc = set_flash_current(led, current_ma, TORCH_MODE);
 	if (rc)
 		return rc;
@@ -707,6 +860,14 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 		flash_data->hw_type = QCOM_MVFLASH_4CH;
 		flash_data->max_channels = 4;
 		regs = mvflash_4ch_regs;
+
+		rc = regmap_read(regmap, reg_base + FLASH_REVISION_REG, &val);
+		if (rc < 0) {
+			dev_err(dev, "Failed to read flash LED module revision, rc=%d\n", rc);
+			return rc;
+		}
+
+		flash_data->revision = val;
 	} else {
 		dev_err(dev, "flash LED subtype %#x is not yet supported\n", val);
 		return -ENODEV;
-- 
2.50.1


