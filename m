Return-Path: <stable+bounces-166224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F23B19869
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E37318971EB
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CFC1C5D77;
	Mon,  4 Aug 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPVuEHjH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8268B2A1AA;
	Mon,  4 Aug 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267700; cv=none; b=J1BAJJMqG13MZXTS3yeq6OvVEcWKMOL+R6iO8KUrRQT8V/RIzHWjR4koYExIquB/6X0nQP/BIp06qoDXDIh3hLOQO+URPjmgZCyLEgWhghSQ8INiI6xZnAm32C3IAMw9PXHfzAFmd8D3tseaQTBKZ6Ax0lY7N6Dtk9B0Gz9nLQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267700; c=relaxed/simple;
	bh=UVzR6wFM9OFZSmiVdCu/ULLhYVFrnuB8NHu6B1NKGdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UpP8YFyVEOCUkWC718xgcsZBcoi8VX3oM7B/PXib2P3sqNhGrP80w/AW8SKsxXtd2fvOzEGX0YOuJbBkk2JFrmDn1bbAU9l16nIoaolveCR4kZ6h0ofh0O45PjAn7z6nembpPQyfKROJVTtItnQvrD2ao171bnVyKMoeSfDxRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPVuEHjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D14C4CEF8;
	Mon,  4 Aug 2025 00:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267700;
	bh=UVzR6wFM9OFZSmiVdCu/ULLhYVFrnuB8NHu6B1NKGdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPVuEHjH40s4Ng9YqVzkscWX8X+eL2QDDTZXQ/Mm/z1EtaYKf5+WPCmWkoZ1heR7E
	 mxQoFL2C52xXkSb3G7tSdbo6TCLf3/NwXLQgaAmMsjOufUT9avIZ1LgBlg16BIcUpQ
	 GgGQW5Vu+tVvkMBUnWl88rAwfi3ST9VMuVUTbxR+c47RRVj6vxtPIuUxSxXpQakcV/
	 JYWHuw4u9c9y1/4vIfFd/KtDJBfjShoueG832zJtc2y89gM+bbinhyXBvk/NpORfBZ
	 zNcV4RHd/JLbfkPwhVAtNzYgUKTaSXv+Uns3rqiRJxRqRVhYlmILX3eV/VzYzTwffA
	 4voqI+vAXB3dw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: David Collins <david.collins@oss.qualcomm.com>,
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/59] thermal/drivers/qcom-spmi-temp-alarm: Enable stage 2 shutdown when required
Date: Sun,  3 Aug 2025 20:33:33 -0400
Message-Id: <20250804003413.3622950-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003413.3622950-1-sashal@kernel.org>
References: <20250804003413.3622950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
Content-Transfer-Encoding: 8bit

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

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
detailed analysis:

## Key Reasons for Backporting:

### 1. **Fixes a Hardware Safety Issue**
The commit addresses a critical hardware protection mechanism where
certain PMIC peripherals require stage 2 automatic partial shutdown to
prevent "repeated faults" during stage 3 over-temperature events.
Without this fix, affected hardware could experience repeated thermal
faults during critical temperature conditions, potentially leading to
system instability or hardware damage.

### 2. **Targeted Hardware-Specific Fix**
The code changes identify specific PMIC revisions that require this
protection:
```c
switch (dig_revision) {
case 0x0001:
case 0x0002:
case 0x0100:
case 0x0101:
    chip->require_stage2_shutdown = true;
    break;
}
```
This shows it's a targeted fix for known hardware issues, not a general
enhancement.

### 3. **Small and Contained Change**
The fix is minimal and self-contained:
- Adds reading of DIG_MINOR register
- Adds a `require_stage2_shutdown` flag to the chip structure
- Modifies the logic in `qpnp_tm_update_critical_trip_temp()` to respect
  this flag
- Total change is about 30 lines of code with clear boundaries

### 4. **Low Risk of Regression**
- The change only affects specific PMIC revisions (0x0001, 0x0002,
  0x0100, 0x0101)
- For other hardware, behavior remains unchanged
- The modification is purely additive - it doesn't alter existing
  functionality for unaffected devices

### 5. **Prevents Hardware Malfunction**
The commit message explicitly states this fix is needed to "avoid
potential repeated faults upon reaching over-temperature stage 3." This
indicates a real hardware malfunction scenario that users could
encounter without this patch.

### 6. **Follows Stable Tree Rules**
According to stable kernel rules, this qualifies because it:
- Fixes a real bug (hardware protection failure)
- Is not a new feature
- Has minimal changes
- Addresses a specific hardware issue that affects users

### Technical Analysis:
The key change is in the `qpnp_tm_update_critical_trip_temp()` function
where the condition is modified from:
```c
if (disable_s2_shutdown)
    reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
```
to:
```c
if (disable_stage2_shutdown && !chip->require_stage2_shutdown)
    reg |= SHUTDOWN_CTRL1_OVERRIDE_STAGE2;
```

This ensures that for the affected PMIC revisions, stage 2 shutdown is
never disabled, providing the necessary hardware protection against
thermal events.

Given that this fixes a hardware-specific thermal protection issue that
could lead to system instability or damage, and the fix is minimal with
low regression risk, this commit is an excellent candidate for stable
backporting.

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 43 ++++++++++++++++-----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 78c5cfe6a0c0..eeccf905f83e 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/bitops.h>
@@ -16,6 +17,7 @@
 
 #include "../thermal_hwmon.h"
 
+#define QPNP_TM_REG_DIG_MINOR		0x00
 #define QPNP_TM_REG_DIG_MAJOR		0x01
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
@@ -31,7 +33,7 @@
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 #define STATUS_GEN2_STATE_SHIFT		4
 
-#define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
+#define SHUTDOWN_CTRL1_OVERRIDE_STAGE2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
 #define SHUTDOWN_CTRL1_RATE_25HZ	BIT(3)
@@ -79,6 +81,7 @@ struct qpnp_tm_chip {
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
+	bool				require_stage2_shutdown;
 
 	struct iio_channel		*adc;
 	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
@@ -221,13 +224,13 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
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
@@ -242,12 +245,12 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
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
@@ -256,8 +259,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
 skip:
 	reg |= chip->thresh;
-	if (disable_s2_shutdown)
-		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
+	if (disable_stage2_shutdown && !chip->require_stage2_shutdown)
+		reg |= SHUTDOWN_CTRL1_OVERRIDE_STAGE2;
 
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
@@ -371,8 +374,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
-	u8 type, subtype, dig_major;
-	u32 res;
+	u8 type, subtype, dig_major, dig_minor;
+	u32 res, dig_revision;
 	int ret, irq;
 
 	node = pdev->dev.of_node;
@@ -424,6 +427,11 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "could not read dig_major\n");
 
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not read dig_minor\n");
+
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
@@ -437,6 +445,23 @@ static int qpnp_tm_probe(struct platform_device *pdev)
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


