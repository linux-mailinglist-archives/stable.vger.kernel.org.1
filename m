Return-Path: <stable+bounces-175108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC54B366A6
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85619980715
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B29335207F;
	Tue, 26 Aug 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EgttiwZM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A834F496;
	Tue, 26 Aug 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216160; cv=none; b=igzmpgRRIU3HIeeo8vfBLoLYs3aXG/Dyu/Y5DuDluNif1SKpaY/AnInbWb10jyEo86L18W5T/fxhPw3rE6O+Z+HxSiutswIaPSdxMqZ57oBuPoaSUS02BkyD4PkUcQuBFsySGYIG3IzmH9Janpj6yjsknbVVVIsiBjNTl2CFGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216160; c=relaxed/simple;
	bh=EASoxmRhQ5+Ph+34kNVyshJl2HDQ5lXY3RaW2JwsQvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGveWoGWRN2/iwDk3NqRwT3WxDQC5JsF/mFXu1qAc8bBLzx5ERoV2W3r7gavCtHFu8N1DuD5Dp6tvq0VubSDP96x16dpYIV/S1PBqb01ASYT8nisZasXCe6Ipsz7EmnrijrdOYQtWg9PMxkorHB+akjGVSLzkZN2DxWXSUCECyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EgttiwZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE8AC113D0;
	Tue, 26 Aug 2025 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216160;
	bh=EASoxmRhQ5+Ph+34kNVyshJl2HDQ5lXY3RaW2JwsQvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgttiwZMRxBDZKGJTaAfe4F9iIC+0ntjaCznEC87ss8H5OW4jUIpdMHeckHxE8v0r
	 Amcxt7EHuPsXpUFLKt/TKuMmZdk0sFq6N39oCztT08cz42aJKj+CE/rdUYPEAquKTZ
	 oKNWnwvTZ+Z+UL6wtbyJakX36d3Yf4iZTYRSJRIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Collins <david.collins@oss.qualcomm.com>,
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 308/644] thermal/drivers/qcom-spmi-temp-alarm: Enable stage 2 shutdown when required
Date: Tue, 26 Aug 2025 13:06:39 +0200
Message-ID: <20250826110954.016924268@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Collins <david.collins@oss.qualcomm.com>

[ Upstream commit f8e157ff2df46ddabd930815d196895976227831 ]

Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature stage 2
automatic PMIC partial shutdown. This will ensure that in the event of
reaching the hotter stage 3 over-temperature threshold, repeated faults
will be avoided during the automatic PMIC hardware full shutdown.
Modify the stage 2 shutdown control logic to ensure that stage 2
shutdown is enabled on all affected PMICs. Read the digital major
and minor revision registers to identify these PMICs.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250710224555.3047790-2-anjelique.melendez@oss.qualcomm.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 43 ++++++++++++++++-----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 1037de19873a..f466bbfa128d 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/bitops.h>
@@ -17,6 +18,7 @@
 
 #include "../thermal_core.h"
 
+#define QPNP_TM_REG_DIG_MINOR		0x00
 #define QPNP_TM_REG_DIG_MAJOR		0x01
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
@@ -32,7 +34,7 @@
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 #define STATUS_GEN2_STATE_SHIFT		4
 
-#define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
+#define SHUTDOWN_CTRL1_OVERRIDE_STAGE2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
 #define SHUTDOWN_CTRL1_RATE_25HZ	BIT(3)
@@ -80,6 +82,7 @@ struct qpnp_tm_chip {
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
+	bool				require_stage2_shutdown;
 
 	struct iio_channel		*adc;
 	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
@@ -222,13 +225,13 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 {
 	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
 	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
-	bool disable_s2_shutdown = false;
+	bool disable_stage2_shutdown = false;
 	u8 reg;
 
 	WARN_ON(!mutex_is_locked(&chip->lock));
 
 	/*
-	 * Default: S2 and S3 shutdown enabled, thresholds at
+	 * Default: Stage 2 and Stage 3 shutdown enabled, thresholds at
 	 * lowest threshold set, monitoring at 25Hz
 	 */
 	reg = SHUTDOWN_CTRL1_RATE_25HZ;
@@ -243,12 +246,12 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 		chip->thresh = THRESH_MAX -
 			((stage2_threshold_max - temp) /
 			 TEMP_THRESH_STEP);
-		disable_s2_shutdown = true;
+		disable_stage2_shutdown = true;
 	} else {
 		chip->thresh = THRESH_MAX;
 
 		if (chip->adc)
-			disable_s2_shutdown = true;
+			disable_stage2_shutdown = true;
 		else
 			dev_warn(chip->dev,
 				 "No ADC is configured and critical temperature %d mC is above the maximum stage 2 threshold of %ld mC! Configuring stage 2 shutdown at %ld mC.\n",
@@ -257,8 +260,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
 skip:
 	reg |= chip->thresh;
-	if (disable_s2_shutdown)
-		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
+	if (disable_stage2_shutdown && !chip->require_stage2_shutdown)
+		reg |= SHUTDOWN_CTRL1_OVERRIDE_STAGE2;
 
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
@@ -372,8 +375,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
-	u8 type, subtype, dig_major;
-	u32 res;
+	u8 type, subtype, dig_major, dig_minor;
+	u32 res, dig_revision;
 	int ret, irq;
 
 	node = pdev->dev.of_node;
@@ -428,6 +431,11 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not read dig_minor\n");
+
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
@@ -441,6 +449,23 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	else
 		chip->temp_map = &temp_map_gen1;
 
+	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
+		dig_revision = (dig_major << 8) | dig_minor;
+		/*
+		 * Check if stage 2 automatic partial shutdown must remain
+		 * enabled to avoid potential repeated faults upon reaching
+		 * over-temperature stage 3.
+		 */
+		switch (dig_revision) {
+		case 0x0001:
+		case 0x0002:
+		case 0x0100:
+		case 0x0101:
+			chip->require_stage2_shutdown = true;
+			break;
+		}
+	}
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
-- 
2.39.5




