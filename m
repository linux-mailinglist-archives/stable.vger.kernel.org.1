Return-Path: <stable+bounces-192060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C934C2906D
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 15:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54679188DA0F
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744901D9A54;
	Sun,  2 Nov 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIQVbrWG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C313635C
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762094118; cv=none; b=rr427dRFtBhC4C9VYVhEKeRYLwoAyg6Sva5sQZ0+ggiD8OrGRG8FbFG8AD4ygS/0s0tDCZ+xQTuwGdQKl45NJkWAO9rvITtVdkXenXRJ1gGDwC30DO0n11jZaM1xiayZozhFDnoUWf2LCGwRJhxdn6k7ll8+5myiX/UIR9z6gTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762094118; c=relaxed/simple;
	bh=0mLUVTFbEE2vzD0Z7Bi+R65cBgSO9WYyo5dcoBfKGbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j352OVgreO33KPRTOwBcNVxTqcJgV+OrDWTYUOnR8N/JFx3V1ntxW6/qMmHFdSWvJEOuP3kXpFe0+DO6xBjZGAkEzvVKz8hUFcaM6k9EtytCOnLZTUepzh9h5Bi66CjCOGv0On1cX4rk7CsNhVo1UE+4GsZsA9bk1Xwq8WaGV20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIQVbrWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584A9C4CEF7;
	Sun,  2 Nov 2025 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762094117;
	bh=0mLUVTFbEE2vzD0Z7Bi+R65cBgSO9WYyo5dcoBfKGbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIQVbrWGrym3ijJijLEvVab80YAlz6qC9pxc17xCUtXJO0NOhWQytSBr7KXYBF2jN
	 CSZaVk5jSzpDrywv+YNtxrIiYRmGon7yfP3ue9CndyjxjfHKkIODiR/rehfFONEE3E
	 7Pvz1etElEXGEfr7yiW4Qel6rGk2UI9NSGXFvNUslE7L2ougoAyk6s3aPu0xcr11mz
	 ui/fdSWJ8HRAhQVuWzglJumW6n3ZLDyXH1Xze09tIaGKRwP4d/CuSXR95DXa7dFpBA
	 nc2nxZtwzFx1COcxjGY606iN1FmV6JwyY/vcCBqcojQcy7EWM8B4LijD/gvY0b5QfT
	 8TQOtORKz5D6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joshua Grisham <josh@joshuagrisham.com>,
	Armin Wolf <W_Armin@gmx.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ACPI: fan: Add fan speed reporting for fans with only _FST
Date: Sun,  2 Nov 2025 09:35:13 -0500
Message-ID: <20251102143514.3449278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110248-reflex-facebook-1ab2@gregkh>
References: <2025110248-reflex-facebook-1ab2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Grisham <josh@joshuagrisham.com>

[ Upstream commit 6c00f29f74cb2c063b6f31a0b6d73f9db132b9ac ]

Add support for ACPI fans with _FST to report their speed even if they do
not support fan control.

As suggested by Armin Wolf [1] and per the Windows Thermal Management
Design Guide [2], Samsung Galaxy Book series devices (and possibly many
more devices where the Windows guide was strictly followed) only implement
the _FST method and do not support ACPI-based fan control.

Currently, these fans are not supported by the kernel driver but this patch
will make some very small adjustments to allow them to be supported.

This patch is tested and working for me on a Samsung Galaxy Book2 Pro whose
DSDT (and several other Samsung Galaxy Book series notebooks which
currently have the same issue) can be found at [3].

Link: https://lore.kernel.org/platform-driver-x86/53c5075b-1967-45d0-937f-463912dd966d@gmx.de [1]
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/design-guide [2]
Link: https://github.com/joshuagrisham/samsung-galaxybook-extras/tree/8e3087a06b8bdcdfdd081367af4b744a56cc4ee9/dsdt [3]

Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Link: https://patch.msgid.link/20250222094407.9753-1-josh@joshuagrisham.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: d91a1d129b63 ("ACPI: fan: Use platform device for devres-related actions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/fan.h       |  1 +
 drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
 drivers/acpi/fan_core.c  | 25 ++++++++++++++++++-------
 drivers/acpi/fan_hwmon.c |  8 ++++++++
 4 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index db25a3898af71..a7e39a29d4c89 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -48,6 +48,7 @@ struct acpi_fan_fst {
 
 struct acpi_fan {
 	bool acpi4;
+	bool has_fst;
 	struct acpi_fan_fif fif;
 	struct acpi_fan_fps *fps;
 	int fps_count;
diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index f4f6e2381f1d3..22d29ac2447cc 100644
--- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -75,15 +75,6 @@ int acpi_fan_create_attributes(struct acpi_device *device)
 	struct acpi_fan *fan = acpi_driver_data(device);
 	int i, status;
 
-	sysfs_attr_init(&fan->fine_grain_control.attr);
-	fan->fine_grain_control.show = show_fine_grain_control;
-	fan->fine_grain_control.store = NULL;
-	fan->fine_grain_control.attr.name = "fine_grain_control";
-	fan->fine_grain_control.attr.mode = 0444;
-	status = sysfs_create_file(&device->dev.kobj, &fan->fine_grain_control.attr);
-	if (status)
-		return status;
-
 	/* _FST is present if we are here */
 	sysfs_attr_init(&fan->fst_speed.attr);
 	fan->fst_speed.show = show_fan_speed;
@@ -92,7 +83,19 @@ int acpi_fan_create_attributes(struct acpi_device *device)
 	fan->fst_speed.attr.mode = 0444;
 	status = sysfs_create_file(&device->dev.kobj, &fan->fst_speed.attr);
 	if (status)
-		goto rem_fine_grain_attr;
+		return status;
+
+	if (!fan->acpi4)
+		return 0;
+
+	sysfs_attr_init(&fan->fine_grain_control.attr);
+	fan->fine_grain_control.show = show_fine_grain_control;
+	fan->fine_grain_control.store = NULL;
+	fan->fine_grain_control.attr.name = "fine_grain_control";
+	fan->fine_grain_control.attr.mode = 0444;
+	status = sysfs_create_file(&device->dev.kobj, &fan->fine_grain_control.attr);
+	if (status)
+		goto rem_fst_attr;
 
 	for (i = 0; i < fan->fps_count; ++i) {
 		struct acpi_fan_fps *fps = &fan->fps[i];
@@ -109,18 +112,18 @@ int acpi_fan_create_attributes(struct acpi_device *device)
 
 			for (j = 0; j < i; ++j)
 				sysfs_remove_file(&device->dev.kobj, &fan->fps[j].dev_attr.attr);
-			goto rem_fst_attr;
+			goto rem_fine_grain_attr;
 		}
 	}
 
 	return 0;
 
-rem_fst_attr:
-	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
-
 rem_fine_grain_attr:
 	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
 
+rem_fst_attr:
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
+
 	return status;
 }
 
@@ -129,9 +132,13 @@ void acpi_fan_delete_attributes(struct acpi_device *device)
 	struct acpi_fan *fan = acpi_driver_data(device);
 	int i;
 
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
+
+	if (!fan->acpi4)
+		return;
+
 	for (i = 0; i < fan->fps_count; ++i)
 		sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
 
-	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
 	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
 }
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 300e5d9199864..f5f3091d5ca84 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -203,12 +203,16 @@ static const struct thermal_cooling_device_ops fan_cooling_ops = {
  * --------------------------------------------------------------------------
 */
 
+static bool acpi_fan_has_fst(struct acpi_device *device)
+{
+	return acpi_has_method(device->handle, "_FST");
+}
+
 static bool acpi_fan_is_acpi4(struct acpi_device *device)
 {
 	return acpi_has_method(device->handle, "_FIF") &&
 	       acpi_has_method(device->handle, "_FPS") &&
-	       acpi_has_method(device->handle, "_FSL") &&
-	       acpi_has_method(device->handle, "_FST");
+	       acpi_has_method(device->handle, "_FSL");
 }
 
 static int acpi_fan_get_fif(struct acpi_device *device)
@@ -327,7 +331,12 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	device->driver_data = fan;
 	platform_set_drvdata(pdev, fan);
 
-	if (acpi_fan_is_acpi4(device)) {
+	if (acpi_fan_has_fst(device)) {
+		fan->has_fst = true;
+		fan->acpi4 = acpi_fan_is_acpi4(device);
+	}
+
+	if (fan->acpi4) {
 		result = acpi_fan_get_fif(device);
 		if (result)
 			return result;
@@ -335,7 +344,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		result = acpi_fan_get_fps(device);
 		if (result)
 			return result;
+	}
 
+	if (fan->has_fst) {
 		result = devm_acpi_fan_create_hwmon(device);
 		if (result)
 			return result;
@@ -343,9 +354,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		result = acpi_fan_create_attributes(device);
 		if (result)
 			return result;
+	}
 
-		fan->acpi4 = true;
-	} else {
+	if (!fan->acpi4) {
 		result = acpi_device_update_power(device, NULL);
 		if (result) {
 			dev_err(&device->dev, "Failed to set initial power state\n");
@@ -391,7 +402,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 err_unregister:
 	thermal_cooling_device_unregister(cdev);
 err_end:
-	if (fan->acpi4)
+	if (fan->has_fst)
 		acpi_fan_delete_attributes(device);
 
 	return result;
@@ -401,7 +412,7 @@ static void acpi_fan_remove(struct platform_device *pdev)
 {
 	struct acpi_fan *fan = platform_get_drvdata(pdev);
 
-	if (fan->acpi4) {
+	if (fan->has_fst) {
 		struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
 		acpi_fan_delete_attributes(device);
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index bd0d31a398fa5..e8d90605106ef 100644
--- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -43,6 +43,10 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
 		case hwmon_fan_input:
 			return 0444;
 		case hwmon_fan_target:
+			/* Only acpi4 fans support fan control. */
+			if (!fan->acpi4)
+				return 0;
+
 			/*
 			 * When in fine grain control mode, not every fan control value
 			 * has an associated fan performance state.
@@ -57,6 +61,10 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
 	case hwmon_power:
 		switch (attr) {
 		case hwmon_power_input:
+			/* Only acpi4 fans support fan control. */
+			if (!fan->acpi4)
+				return 0;
+
 			/*
 			 * When in fine grain control mode, not every fan control value
 			 * has an associated fan performance state.
-- 
2.51.0


