Return-Path: <stable+bounces-101460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F19EEC8C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B73162C0F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA6B6F2FE;
	Thu, 12 Dec 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z4MdYrfc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09C21764F;
	Thu, 12 Dec 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017625; cv=none; b=AEvJz9YP18jcMI51wlOXM4ecajEWg+S0xPic8DpgCgGJI9ymSR1qMaVU9+nHHMWjpgqK6q2YVDFQEcx3gJGpERAYvHwlzN1wj3aA1E6EZkS66u7nvpqqE220RreTAE6m1TP/1mTKW+yOvzSDH+nJWVIxZd21YpJz/FflUt80PvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017625; c=relaxed/simple;
	bh=K5ba2l518bZ+xC1O14ikLGnT0s2chGczgkB96ngi4e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8Y5w+ubr7HqbjocM8tPYmCT/3KyqfZwpt1cEoAFpRHnnhbn4yrt9lp7rvNqi9dTdleyZjkwIKeaF5wmlUei8aPNMAn+rOjjUwK/bcDG3/EF3RIyTNiXA+MWLFJQyInO6ETRWFIUlt+zD3h47gcFkRmK8kjkS2VlUM99BcSjRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z4MdYrfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD84C4CECE;
	Thu, 12 Dec 2024 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017625;
	bh=K5ba2l518bZ+xC1O14ikLGnT0s2chGczgkB96ngi4e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4MdYrfcH5Ie0JE+9QtYNxf7xj7Nv8t0mpG+5fR7YeuUDHu/QLLo2MmC4G8F0cVGf
	 UpA3MzPsJ9VVUJhOqVWoeUWrLkmFRRRM1K0n1cq8VUV/3N/C+anqAgdlZw6dNSpGgw
	 DUeMQipMhV6b32F53ea+sz2Sh/MuiwbskUaS4ly0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Luke D. Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 026/356] platform/x86: asus-wmi: add support for vivobook fan profiles
Date: Thu, 12 Dec 2024 15:55:45 +0100
Message-ID: <20241212144245.663686926@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>

[ Upstream commit bcbfcebda2cbc6a10a347d726e4a4f69e43a864e ]

Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
to adjust power limits.

These fan profiles have a different device id than the ROG series
and different order. This reorders the existing modes.

As part of keeping the patch clean the throttle_thermal_policy_available
boolean stored in the driver struct is removed and
throttle_thermal_policy_dev is used in place (as on init it is zeroed).

Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Reviewed-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/20240609144849.2532-2-mohamed.ghanmi@supcom.tn
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 25fb5f47f34d ("platform/x86: asus-wmi: Ignore return value when writing thermal policy")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c            | 120 ++++++++++++---------
 include/linux/platform_data/x86/asus-wmi.h |   1 +
 2 files changed, 71 insertions(+), 50 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9c6321c2fc3c5..d0ba8bd83fc3d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -95,6 +95,12 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
 
+#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO	0
+#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO	1
+#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
+
+#define PLATFORM_PROFILE_MAX 2
+
 #define USB_INTEL_XUSB2PR		0xD0
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
@@ -269,8 +275,8 @@ struct asus_wmi {
 	bool kbd_rgb_mode_available;
 	bool kbd_rgb_state_available;
 
-	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
+	u32 throttle_thermal_policy_dev;
 
 	bool cpu_fan_curve_available;
 	bool gpu_fan_curve_available;
@@ -2912,7 +2918,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
 	int err, fan_idx;
 	u8 mode = 0;
 
-	if (asus->throttle_thermal_policy_available)
+	if (asus->throttle_thermal_policy_dev)
 		mode = asus->throttle_thermal_policy_mode;
 	/* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
 	if (mode == 2)
@@ -3119,7 +3125,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
 		 * For machines with throttle this is the only way to reset fans
 		 * to default mode of operation (does not erase curve data).
 		 */
-		if (asus->throttle_thermal_policy_available) {
+		if (asus->throttle_thermal_policy_dev) {
 			err = throttle_thermal_policy_write(asus);
 			if (err)
 				return err;
@@ -3336,8 +3342,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
 __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
 
 /*
- * Must be initialised after throttle_thermal_policy_check_present() as
- * we check the status of throttle_thermal_policy_available during init.
+ * Must be initialised after throttle_thermal_policy_dev is set as
+ * we check the status of throttle_thermal_policy_dev during init.
  */
 static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 {
@@ -3378,38 +3384,13 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 }
 
 /* Throttle thermal policy ****************************************************/
-
-static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
-{
-	u32 result;
-	int err;
-
-	asus->throttle_thermal_policy_available = false;
-
-	err = asus_wmi_get_devstate(asus,
-				    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
-				    &result);
-	if (err) {
-		if (err == -ENODEV)
-			return 0;
-		return err;
-	}
-
-	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
-		asus->throttle_thermal_policy_available = true;
-
-	return 0;
-}
-
 static int throttle_thermal_policy_write(struct asus_wmi *asus)
 {
-	int err;
-	u8 value;
+	u8 value = asus->throttle_thermal_policy_mode;
 	u32 retval;
+	int err;
 
-	value = asus->throttle_thermal_policy_mode;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
 				    value, &retval);
 
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
@@ -3439,7 +3420,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 
 static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 {
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
@@ -3451,7 +3432,7 @@ static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
 	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
 	int err;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	if (new_mode > PLATFORM_PROFILE_MAX)
 		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3490,7 +3471,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	if (result < 0)
 		return result;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	if (new_mode > PLATFORM_PROFILE_MAX)
 		return -EINVAL;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3507,10 +3488,52 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	return count;
 }
 
-// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+/*
+ * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+ */
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
 /* Platform profile ***********************************************************/
+static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus, int mode)
+{
+	bool vivo;
+
+	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+
+	if (vivo) {
+		switch (mode) {
+		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
+			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
+		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
+			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
+		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
+			return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
+		}
+	}
+
+	return mode;
+}
+
+static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus, int mode)
+{
+	bool vivo;
+
+	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+
+	if (vivo) {
+		switch (mode) {
+		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
+			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
+		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
+			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
+		case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
+			return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
+		}
+	}
+
+	return mode;
+}
+
 static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 					enum platform_profile_option *profile)
 {
@@ -3518,10 +3541,9 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	int tp;
 
 	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
-
 	tp = asus->throttle_thermal_policy_mode;
 
-	switch (tp) {
+	switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
 	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
 		*profile = PLATFORM_PROFILE_BALANCED;
 		break;
@@ -3560,7 +3582,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 		return -EOPNOTSUPP;
 	}
 
-	asus->throttle_thermal_policy_mode = tp;
+	asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
 	return throttle_thermal_policy_write(asus);
 }
 
@@ -3573,7 +3595,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	 * Not an error if a component platform_profile relies on is unavailable
 	 * so early return, skipping the setup of platform_profile.
 	 */
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
@@ -3870,7 +3892,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 	if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
 		if (asus->fan_boost_mode_available)
 			fan_boost_mode_switch_next(asus);
-		if (asus->throttle_thermal_policy_available)
+		if (asus->throttle_thermal_policy_dev)
 			throttle_thermal_policy_switch_next(asus);
 		return;
 
@@ -4075,7 +4097,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
-		ok = asus->throttle_thermal_policy_available;
+		ok = asus->throttle_thermal_policy_dev != 0;
 	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
 		ok = asus->ppt_pl2_sppt_available;
 	else if (attr == &dev_attr_ppt_pl1_spl.attr)
@@ -4365,16 +4387,15 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
 	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
+		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
+		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
 
-	err = throttle_thermal_policy_check_present(asus);
-	if (err)
-		goto fail_throttle_thermal_policy;
-	else
-		throttle_thermal_policy_set_default(asus);
-
 	err = platform_profile_setup(asus);
 	if (err)
 		goto fail_platform_profile_setup;
@@ -4461,7 +4482,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_input:
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
-fail_throttle_thermal_policy:
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 16e99a1c37fc4..8e48bdeb55493 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -60,6 +60,7 @@
 #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
+#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
 
 /* Misc */
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
-- 
2.43.0




