Return-Path: <stable+bounces-61704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C92E93C591
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915B21F25D41
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A6C19D069;
	Thu, 25 Jul 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j2JkpcPl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3013C816;
	Thu, 25 Jul 2024 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919174; cv=none; b=u4J8EnYwVap45QIlTmfUAxEtlZdsUs2uKIn4L6259DBtudxTlZPUnDjUxTVga+pJWjQYM1PU0hunf6B17V3ahTi+bqO4qA4vWw/QEFnpujxV5SaT5AepkAxzPXJbVxv9bWQjgYZoe374qO9AzFF68+2qHs5GyQHo0BhZz8HKvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919174; c=relaxed/simple;
	bh=yfpmAyDUuwNpNHPskAKwC+sRyGpqWyhEJV/SPwsFXOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agiEJ2T03qS144iym10PogGmsHwOxU78h4NA62tgM5lJtkUJZU/58QUqbDyFYJzqdk53hk/VP9cmO0bWW+Thjzyq/BxE/N+h94MCDlIOuettioAlAKoK6CEVHLI6U2nxvZiYUce7/p5Fy0QYVVUVJ4A9Z76GRHpwSXRNniLuxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j2JkpcPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C59EC116B1;
	Thu, 25 Jul 2024 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721919173;
	bh=yfpmAyDUuwNpNHPskAKwC+sRyGpqWyhEJV/SPwsFXOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j2JkpcPl356OCRMUAvhev1FdvVcRILHyD6Q8Lm87ti9xPvExuOlMK79b3Jm+QF2em
	 guUMxpfsf7concQ1c0kVvzmQzM5iKLPSJBW9IAtQzpGZRHY2Fw4AdH1QVQt3TyI1g+
	 ZuK7MGB9I5/OA2/ZFBto/2quhg/YFMtLe8BD/1Mk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Agathe Boutmy <agathe@boutmy.com>,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 47/87] platform/x86: lg-laptop: Use ACPI device handle when evaluating WMAB/WMBB
Date: Thu, 25 Jul 2024 16:37:20 +0200
Message-ID: <20240725142740.208285193@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
References: <20240725142738.422724252@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit b27ea279556121b54d3f45d0529706cf100cdb3a ]

On the LG Gram 16Z90S, the WMAB and WMBB ACPI methods are not mapped
under \XINI, but instead are mapped under \_SB.XINI.

The reason for this is that the LGEX0820 ACPI device used by this
driver is mapped at \_SB.XINI, so the ACPI methods where moved as well
to appear below the LGEX0820 ACPI device.

Fix this by using the ACPI handle from the ACPI device when evaluating
both methods.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218901
Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240606233540.9774-5-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lg-laptop.c | 79 +++++++++++++-------------------
 1 file changed, 33 insertions(+), 46 deletions(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 807bd4283b979..5f9fbea8fc3c2 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -37,8 +37,6 @@ MODULE_LICENSE("GPL");
 #define WMI_METHOD_WMBB "2B4F501A-BD3C-4394-8DCF-00A7D2BC8210"
 #define WMI_EVENT_GUID  WMI_EVENT_GUID0
 
-#define WMAB_METHOD     "\\XINI.WMAB"
-#define WMBB_METHOD     "\\XINI.WMBB"
 #define SB_GGOV_METHOD  "\\_SB.GGOV"
 #define GOV_TLED        0x2020008
 #define WM_GET          1
@@ -73,7 +71,7 @@ static u32 inited;
 
 static int battery_limit_use_wmbb;
 static struct led_classdev kbd_backlight;
-static enum led_brightness get_kbd_backlight_level(void);
+static enum led_brightness get_kbd_backlight_level(struct device *dev);
 
 static const struct key_entry wmi_keymap[] = {
 	{KE_KEY, 0x70, {KEY_F15} },	 /* LG control panel (F1) */
@@ -126,11 +124,10 @@ static int ggov(u32 arg0)
 	return res;
 }
 
-static union acpi_object *lg_wmab(u32 method, u32 arg1, u32 arg2)
+static union acpi_object *lg_wmab(struct device *dev, u32 method, u32 arg1, u32 arg2)
 {
 	union acpi_object args[3];
 	acpi_status status;
-	acpi_handle handle;
 	struct acpi_object_list arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
@@ -141,29 +138,22 @@ static union acpi_object *lg_wmab(u32 method, u32 arg1, u32 arg2)
 	args[2].type = ACPI_TYPE_INTEGER;
 	args[2].integer.value = arg2;
 
-	status = acpi_get_handle(NULL, (acpi_string) WMAB_METHOD, &handle);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Cannot get handle");
-		return NULL;
-	}
-
 	arg.count = 3;
 	arg.pointer = args;
 
-	status = acpi_evaluate_object(handle, NULL, &arg, &buffer);
+	status = acpi_evaluate_object(ACPI_HANDLE(dev), "WMAB", &arg, &buffer);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_err(handle, "WMAB: call failed.\n");
+		dev_err(dev, "WMAB: call failed.\n");
 		return NULL;
 	}
 
 	return buffer.pointer;
 }
 
-static union acpi_object *lg_wmbb(u32 method_id, u32 arg1, u32 arg2)
+static union acpi_object *lg_wmbb(struct device *dev, u32 method_id, u32 arg1, u32 arg2)
 {
 	union acpi_object args[3];
 	acpi_status status;
-	acpi_handle handle;
 	struct acpi_object_list arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	u8 buf[32];
@@ -179,18 +169,12 @@ static union acpi_object *lg_wmbb(u32 method_id, u32 arg1, u32 arg2)
 	args[2].buffer.length = 32;
 	args[2].buffer.pointer = buf;
 
-	status = acpi_get_handle(NULL, (acpi_string)WMBB_METHOD, &handle);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Cannot get handle");
-		return NULL;
-	}
-
 	arg.count = 3;
 	arg.pointer = args;
 
-	status = acpi_evaluate_object(handle, NULL, &arg, &buffer);
+	status = acpi_evaluate_object(ACPI_HANDLE(dev), "WMBB", &arg, &buffer);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_err(handle, "WMAB: call failed.\n");
+		dev_err(dev, "WMBB: call failed.\n");
 		return NULL;
 	}
 
@@ -221,7 +205,7 @@ static void wmi_notify(u32 value, void *context)
 
 		if (eventcode == 0x10000000) {
 			led_classdev_notify_brightness_hw_changed(
-				&kbd_backlight, get_kbd_backlight_level());
+				&kbd_backlight, get_kbd_backlight_level(kbd_backlight.dev->parent));
 		} else {
 			key = sparse_keymap_entry_from_scancode(
 				wmi_input_dev, eventcode);
@@ -286,7 +270,7 @@ static ssize_t fan_mode_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	r = lg_wmab(WM_FAN_MODE, WM_GET, 0);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
 	if (!r)
 		return -EIO;
 
@@ -297,9 +281,9 @@ static ssize_t fan_mode_store(struct device *dev,
 
 	m = r->integer.value;
 	kfree(r);
-	r = lg_wmab(WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
 	kfree(r);
-	r = lg_wmab(WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
 	kfree(r);
 
 	return count;
@@ -311,7 +295,7 @@ static ssize_t fan_mode_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;
 
-	r = lg_wmab(WM_FAN_MODE, WM_GET, 0);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
 	if (!r)
 		return -EIO;
 
@@ -338,7 +322,7 @@ static ssize_t usb_charge_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	r = lg_wmbb(WMBB_USB_CHARGE, WM_SET, value);
+	r = lg_wmbb(dev, WMBB_USB_CHARGE, WM_SET, value);
 	if (!r)
 		return -EIO;
 
@@ -352,7 +336,7 @@ static ssize_t usb_charge_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;
 
-	r = lg_wmbb(WMBB_USB_CHARGE, WM_GET, 0);
+	r = lg_wmbb(dev, WMBB_USB_CHARGE, WM_GET, 0);
 	if (!r)
 		return -EIO;
 
@@ -380,7 +364,7 @@ static ssize_t reader_mode_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	r = lg_wmab(WM_READER_MODE, WM_SET, value);
+	r = lg_wmab(dev, WM_READER_MODE, WM_SET, value);
 	if (!r)
 		return -EIO;
 
@@ -394,7 +378,7 @@ static ssize_t reader_mode_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;
 
-	r = lg_wmab(WM_READER_MODE, WM_GET, 0);
+	r = lg_wmab(dev, WM_READER_MODE, WM_GET, 0);
 	if (!r)
 		return -EIO;
 
@@ -422,7 +406,7 @@ static ssize_t fn_lock_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	r = lg_wmab(WM_FN_LOCK, WM_SET, value);
+	r = lg_wmab(dev, WM_FN_LOCK, WM_SET, value);
 	if (!r)
 		return -EIO;
 
@@ -436,7 +420,7 @@ static ssize_t fn_lock_show(struct device *dev,
 	unsigned int status;
 	union acpi_object *r;
 
-	r = lg_wmab(WM_FN_LOCK, WM_GET, 0);
+	r = lg_wmab(dev, WM_FN_LOCK, WM_GET, 0);
 	if (!r)
 		return -EIO;
 
@@ -466,9 +450,9 @@ static ssize_t battery_care_limit_store(struct device *dev,
 		union acpi_object *r;
 
 		if (battery_limit_use_wmbb)
-			r = lg_wmbb(WMBB_BATT_LIMIT, WM_SET, value);
+			r = lg_wmbb(&pf_device->dev, WMBB_BATT_LIMIT, WM_SET, value);
 		else
-			r = lg_wmab(WM_BATT_LIMIT, WM_SET, value);
+			r = lg_wmab(&pf_device->dev, WM_BATT_LIMIT, WM_SET, value);
 		if (!r)
 			return -EIO;
 
@@ -487,7 +471,7 @@ static ssize_t battery_care_limit_show(struct device *dev,
 	union acpi_object *r;
 
 	if (battery_limit_use_wmbb) {
-		r = lg_wmbb(WMBB_BATT_LIMIT, WM_GET, 0);
+		r = lg_wmbb(&pf_device->dev, WMBB_BATT_LIMIT, WM_GET, 0);
 		if (!r)
 			return -EIO;
 
@@ -498,7 +482,7 @@ static ssize_t battery_care_limit_show(struct device *dev,
 
 		status = r->buffer.pointer[0x10];
 	} else {
-		r = lg_wmab(WM_BATT_LIMIT, WM_GET, 0);
+		r = lg_wmab(&pf_device->dev, WM_BATT_LIMIT, WM_GET, 0);
 		if (!r)
 			return -EIO;
 
@@ -540,7 +524,7 @@ static void tpad_led_set(struct led_classdev *cdev,
 {
 	union acpi_object *r;
 
-	r = lg_wmab(WM_TLED, WM_SET, brightness > LED_OFF);
+	r = lg_wmab(cdev->dev->parent, WM_TLED, WM_SET, brightness > LED_OFF);
 	kfree(r);
 }
 
@@ -562,16 +546,16 @@ static void kbd_backlight_set(struct led_classdev *cdev,
 		val = 0;
 	if (brightness >= LED_FULL)
 		val = 0x24;
-	r = lg_wmab(WM_KEY_LIGHT, WM_SET, val);
+	r = lg_wmab(cdev->dev->parent, WM_KEY_LIGHT, WM_SET, val);
 	kfree(r);
 }
 
-static enum led_brightness get_kbd_backlight_level(void)
+static enum led_brightness get_kbd_backlight_level(struct device *dev)
 {
 	union acpi_object *r;
 	int val;
 
-	r = lg_wmab(WM_KEY_LIGHT, WM_GET, 0);
+	r = lg_wmab(dev, WM_KEY_LIGHT, WM_GET, 0);
 
 	if (!r)
 		return LED_OFF;
@@ -599,7 +583,7 @@ static enum led_brightness get_kbd_backlight_level(void)
 
 static enum led_brightness kbd_backlight_get(struct led_classdev *cdev)
 {
-	return get_kbd_backlight_level();
+	return get_kbd_backlight_level(cdev->dev->parent);
 }
 
 static LED_DEVICE(kbd_backlight, 255, LED_BRIGHT_HW_CHANGED);
@@ -626,6 +610,11 @@ static struct platform_driver pf_driver = {
 
 static int acpi_add(struct acpi_device *device)
 {
+	struct platform_device_info pdev_info = {
+		.fwnode = acpi_fwnode_handle(device),
+		.name = PLATFORM_NAME,
+		.id = PLATFORM_DEVID_NONE,
+	};
 	int ret;
 	const char *product;
 	int year = 2017;
@@ -637,9 +626,7 @@ static int acpi_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
-	pf_device = platform_device_register_simple(PLATFORM_NAME,
-						    PLATFORM_DEVID_NONE,
-						    NULL, 0);
+	pf_device = platform_device_register_full(&pdev_info);
 	if (IS_ERR(pf_device)) {
 		ret = PTR_ERR(pf_device);
 		pf_device = NULL;
-- 
2.43.0




