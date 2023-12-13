Return-Path: <stable+bounces-5856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7817480D781
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35E1B20DC4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F11A5380F;
	Mon, 11 Dec 2023 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Bw3eFtr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322D52F8D;
	Mon, 11 Dec 2023 18:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DDFC433C8;
	Mon, 11 Dec 2023 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319850;
	bh=1dVttS8F9y0ly3VuEC0h6KhHnuqwlUt0enhkX5zED0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Bw3eFtrMUHjE53ms/CjOTLaTcE7KA2abHmABIS5W+wJ2/MqrTyW/pDm2oMb8aoFA
	 226supKTpSUvTiv9Of8g1aQfrlXJW4VEGpfUfwxidJdpqEAs3Q5/p9hlAA/nM+756v
	 TyLKSWdHPPFZQDD9Vl0bT91PVLXyivUBArHbSuqo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 12/97] platform/x86: asus-wmi: Adjust tablet/lidflip handling to use enum
Date: Mon, 11 Dec 2023 19:21:15 +0100
Message-ID: <20231211182020.343937325@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luke D. Jones <luke@ljones.dev>

[ Upstream commit 00aa846955fbfb04f7bc0c26c49febfe5395eca1 ]

Due to multiple types of tablet/lidflip, the existing code for
handling these events is refactored to use an enum for each type.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/20220813092753.6635-1-luke@ljones.dev
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: b52cbca22cbf ("platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi code")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +++-----
 drivers/platform/x86/asus-wmi.c    | 49 +++++++++++++++++++++---------
 drivers/platform/x86/asus-wmi.h    |  9 ++++--
 3 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 59ca3dab59e10..f723af0106a1f 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -115,12 +115,12 @@ static struct quirk_entry quirk_asus_forceals = {
 };
 
 static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
-	.use_kbd_dock_devid = true,
+	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
 };
 
 static struct quirk_entry quirk_asus_use_lid_flip_devid = {
 	.wmi_backlight_set_devstate = true,
-	.use_lid_flip_devid = true,
+	.tablet_switch_mode = asus_wmi_lid_flip_devid,
 };
 
 static int dmi_matched(const struct dmi_system_id *dmi)
@@ -492,16 +492,13 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 
 	switch (tablet_mode_sw) {
 	case 0:
-		quirks->use_kbd_dock_devid = false;
-		quirks->use_lid_flip_devid = false;
+		quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
 		break;
 	case 1:
-		quirks->use_kbd_dock_devid = true;
-		quirks->use_lid_flip_devid = false;
+		quirks->tablet_switch_mode = asus_wmi_kbd_dock_devid;
 		break;
 	case 2:
-		quirks->use_kbd_dock_devid = false;
-		quirks->use_lid_flip_devid = true;
+		quirks->tablet_switch_mode = asus_wmi_lid_flip_devid;
 		break;
 	}
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 93b4c61130837..80a442a392cb2 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -353,8 +353,11 @@ static bool asus_wmi_dev_is_present(struct asus_wmi *asus, u32 dev_id)
 
 static int asus_wmi_input_init(struct asus_wmi *asus)
 {
+	struct device *dev;
 	int err, result;
 
+	dev = &asus->platform_device->dev;
+
 	asus->inputdev = input_allocate_device();
 	if (!asus->inputdev)
 		return -ENOMEM;
@@ -362,35 +365,38 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
 	asus->inputdev->name = asus->driver->input_name;
 	asus->inputdev->phys = asus->driver->input_phys;
 	asus->inputdev->id.bustype = BUS_HOST;
-	asus->inputdev->dev.parent = &asus->platform_device->dev;
+	asus->inputdev->dev.parent = dev;
 	set_bit(EV_REP, asus->inputdev->evbit);
 
 	err = sparse_keymap_setup(asus->inputdev, asus->driver->keymap, NULL);
 	if (err)
 		goto err_free_dev;
 
-	if (asus->driver->quirks->use_kbd_dock_devid) {
+	switch (asus->driver->quirks->tablet_switch_mode) {
+	case asus_wmi_no_tablet_switch:
+		break;
+	case asus_wmi_kbd_dock_devid:
 		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
 		if (result >= 0) {
 			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
 			input_report_switch(asus->inputdev, SW_TABLET_MODE, !result);
 		} else if (result != -ENODEV) {
-			pr_err("Error checking for keyboard-dock: %d\n", result);
+			dev_err(dev, "Error checking for keyboard-dock: %d\n", result);
 		}
-	}
-
-	if (asus->driver->quirks->use_lid_flip_devid) {
+		break;
+	case asus_wmi_lid_flip_devid:
 		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
 		if (result < 0)
-			asus->driver->quirks->use_lid_flip_devid = 0;
+			asus->driver->quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
 		if (result >= 0) {
 			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
 			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
 		} else if (result == -ENODEV) {
-			pr_err("This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
+			dev_err(dev, "This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
 		} else {
-			pr_err("Error checking for lid-flip: %d\n", result);
+			dev_err(dev, "Error checking for lid-flip: %d\n", result);
 		}
+		break;
 	}
 
 	err = input_register_device(asus->inputdev);
@@ -416,8 +422,9 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 
 static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
 {
-	int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
+	int result;
 
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
 	if (result >= 0) {
 		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
 		input_sync(asus->inputdev);
@@ -2236,7 +2243,8 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
-	if (asus->driver->quirks->use_kbd_dock_devid && code == NOTIFY_KBD_DOCK_CHANGE) {
+	if (asus->driver->quirks->tablet_switch_mode == asus_wmi_kbd_dock_devid &&
+	    code == NOTIFY_KBD_DOCK_CHANGE) {
 		result = asus_wmi_get_devstate_simple(asus,
 						      ASUS_WMI_DEVID_KBD_DOCK);
 		if (result >= 0) {
@@ -2247,7 +2255,8 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
-	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
+	if (asus->driver->quirks->tablet_switch_mode == asus_wmi_lid_flip_devid &&
+	    code == NOTIFY_LID_FLIP) {
 		lid_flip_tablet_mode_get_state(asus);
 		return;
 	}
@@ -2852,8 +2861,14 @@ static int asus_hotk_resume(struct device *device)
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
 
-	if (asus->driver->quirks->use_lid_flip_devid)
+	switch (asus->driver->quirks->tablet_switch_mode) {
+	case asus_wmi_no_tablet_switch:
+	case asus_wmi_kbd_dock_devid:
+		break;
+	case asus_wmi_lid_flip_devid:
 		lid_flip_tablet_mode_get_state(asus);
+		break;
+	}
 
 	return 0;
 }
@@ -2894,8 +2909,14 @@ static int asus_hotk_restore(struct device *device)
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
 
-	if (asus->driver->quirks->use_lid_flip_devid)
+	switch (asus->driver->quirks->tablet_switch_mode) {
+	case asus_wmi_no_tablet_switch:
+	case asus_wmi_kbd_dock_devid:
+		break;
+	case asus_wmi_lid_flip_devid:
 		lid_flip_tablet_mode_get_state(asus);
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 49f2b8f8ad3eb..f0302a51c5196 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -25,6 +25,12 @@ struct module;
 struct key_entry;
 struct asus_wmi;
 
+enum asus_wmi_tablet_switch_mode {
+	asus_wmi_no_tablet_switch,
+	asus_wmi_kbd_dock_devid,
+	asus_wmi_lid_flip_devid,
+};
+
 struct quirk_entry {
 	bool hotplug_wireless;
 	bool scalar_panel_brightness;
@@ -33,8 +39,7 @@ struct quirk_entry {
 	bool wmi_backlight_native;
 	bool wmi_backlight_set_devstate;
 	bool wmi_force_als_set;
-	bool use_kbd_dock_devid;
-	bool use_lid_flip_devid;
+	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;
 	/*
 	 * For machines with AMD graphic chips, it will send out WMI event
-- 
2.42.0




