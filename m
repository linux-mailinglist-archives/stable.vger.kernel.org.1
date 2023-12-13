Return-Path: <stable+bounces-6218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9620280D975
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409321F20C73
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA53C51C5E;
	Mon, 11 Dec 2023 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y2Oa8oH4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2951C46;
	Mon, 11 Dec 2023 18:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C08C433C8;
	Mon, 11 Dec 2023 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320830;
	bh=bOR404YXQCZ0fVAV4v4+H49uOvI0BHK5CEogHC8cpe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2Oa8oH42diGoT53XdQIwsdNDkk4v3O4FZZiszgSFUgc8iSn16ibsTrzXumwYcvSp
	 qDAe0OJgJGa0cueDm6DeMCU4yPc1nZKp/Q1jDnD4O0CKFJy/qREiA+5NMY/yb4Hg2+
	 NBD1cOmgz2ykL1scDuav8K/k90YEfsop9cpYYTHo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 012/141] platform/x86: asus-wmi: Simplify tablet-mode-switch handling
Date: Mon, 11 Dec 2023 19:21:11 +0100
Message-ID: <20231211182027.025795067@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1ea0d3b46798afc35c3185f6058b8bc08525d56c ]

Simplify tablet-mode-switch handling:
1. The code is the same for all variants, the only difference is the
   dev_id and notify event code. Store the dev_id + code in struct asus_wmi
   and unify the handling
2. Make the new unified asus_wmi_tablet_mode_get_state() check dev_id has
   been set and make it a no-op when not set. This allows calling it
   unconditionally at resume/restore time
3. Simplify the tablet_mode_sw module-param handling, this also allows
   selecting the new lid-flip-rog type through the module-param.

Cc: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20220824151145.1448010-2-hdegoede@redhat.com
Stable-dep-of: b52cbca22cbf ("platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi code")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +----
 drivers/platform/x86/asus-wmi.c    | 76 ++++++------------------------
 2 files changed, 16 insertions(+), 73 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 2857678efa2eb..7b8942fee76dd 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -504,17 +504,8 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 	else
 		wapf = quirks->wapf;
 
-	switch (tablet_mode_sw) {
-	case 0:
-		quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
-		break;
-	case 1:
-		quirks->tablet_switch_mode = asus_wmi_kbd_dock_devid;
-		break;
-	case 2:
-		quirks->tablet_switch_mode = asus_wmi_lid_flip_devid;
-		break;
-	}
+	if (tablet_mode_sw != -1)
+		quirks->tablet_switch_mode = tablet_mode_sw;
 
 	if (quirks->i8042_filter) {
 		ret = i8042_install_filter(quirks->i8042_filter);
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 35b2fbb466b45..e7a01accf4ff1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -204,6 +204,9 @@ struct asus_wmi {
 	struct asus_rfkill gps;
 	struct asus_rfkill uwb;
 
+	int tablet_switch_event_code;
+	u32 tablet_switch_dev_id;
+
 	enum fan_type fan_type;
 	int fan_pwm_mode;
 	int agfn_pwm;
@@ -370,11 +373,11 @@ static void asus_wmi_tablet_sw_init(struct asus_wmi *asus, u32 dev_id, int event
 	int result;
 
 	result = asus_wmi_get_devstate_simple(asus, dev_id);
-	if (result < 0)
-		asus->driver->quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
 	if (result >= 0) {
 		input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
 		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
+		asus->tablet_switch_dev_id = dev_id;
+		asus->tablet_switch_event_code = event_code;
 	} else if (result == -ENODEV) {
 		dev_err(dev, "This device has tablet-mode-switch quirk but got ENODEV checking it. This is a bug.");
 	} else {
@@ -436,22 +439,14 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 
 /* Tablet mode ****************************************************************/
 
-static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
+static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
 {
 	int result;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
-	if (result >= 0) {
-		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
-		input_sync(asus->inputdev);
-	}
-}
-
-static void lid_flip_rog_tablet_mode_get_state(struct asus_wmi *asus)
-{
-	int result;
+	if (!asus->tablet_switch_dev_id)
+		return;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP_ROG);
+	result = asus_wmi_get_devstate_simple(asus, asus->tablet_switch_dev_id);
 	if (result >= 0) {
 		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
 		input_sync(asus->inputdev);
@@ -2507,9 +2502,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 {
 	unsigned int key_value = 1;
 	bool autorelease = 1;
-	int result, orig_code;
-
-	orig_code = code;
+	int orig_code = code;
 
 	if (asus->driver->key_filter) {
 		asus->driver->key_filter(asus->driver, &code, &key_value,
@@ -2552,27 +2545,8 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
-	if (asus->driver->quirks->tablet_switch_mode == asus_wmi_kbd_dock_devid &&
-	    code == NOTIFY_KBD_DOCK_CHANGE) {
-		result = asus_wmi_get_devstate_simple(asus,
-						      ASUS_WMI_DEVID_KBD_DOCK);
-		if (result >= 0) {
-			input_report_switch(asus->inputdev, SW_TABLET_MODE,
-					    !result);
-			input_sync(asus->inputdev);
-		}
-		return;
-	}
-
-	if (asus->driver->quirks->tablet_switch_mode == asus_wmi_lid_flip_devid &&
-	    code == NOTIFY_LID_FLIP) {
-		lid_flip_tablet_mode_get_state(asus);
-		return;
-	}
-
-	if (asus->driver->quirks->tablet_switch_mode == asus_wmi_lid_flip_rog_devid &&
-	    code == NOTIFY_LID_FLIP_ROG) {
-		lid_flip_rog_tablet_mode_get_state(asus);
+	if (code == asus->tablet_switch_event_code) {
+		asus_wmi_tablet_mode_get_state(asus);
 		return;
 	}
 
@@ -3202,18 +3176,7 @@ static int asus_hotk_resume(struct device *device)
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
 
-	switch (asus->driver->quirks->tablet_switch_mode) {
-	case asus_wmi_no_tablet_switch:
-	case asus_wmi_kbd_dock_devid:
-		break;
-	case asus_wmi_lid_flip_devid:
-		lid_flip_tablet_mode_get_state(asus);
-		break;
-	case asus_wmi_lid_flip_rog_devid:
-		lid_flip_rog_tablet_mode_get_state(asus);
-		break;
-	}
-
+	asus_wmi_tablet_mode_get_state(asus);
 	return 0;
 }
 
@@ -3253,18 +3216,7 @@ static int asus_hotk_restore(struct device *device)
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
 
-	switch (asus->driver->quirks->tablet_switch_mode) {
-	case asus_wmi_no_tablet_switch:
-	case asus_wmi_kbd_dock_devid:
-		break;
-	case asus_wmi_lid_flip_devid:
-		lid_flip_tablet_mode_get_state(asus);
-		break;
-	case asus_wmi_lid_flip_rog_devid:
-		lid_flip_rog_tablet_mode_get_state(asus);
-		break;
-	}
-
+	asus_wmi_tablet_mode_get_state(asus);
 	return 0;
 }
 
-- 
2.42.0




