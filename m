Return-Path: <stable+bounces-127666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80085A7A6E8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F0C17A48A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0966A24337D;
	Thu,  3 Apr 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uttnrhyb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C924EF7A;
	Thu,  3 Apr 2025 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693999; cv=none; b=bKWv5ojm9GpZT5tyCBW62neP+2Az23aav0Hf17xOigr4X43pSl0bpjM1LNvqCC2F5ti1gx8Z4u0fa/H86K60fx897qeSZm7TrJh6g6jEiRcdXCc/6mcF/94a1BmluEPVUq2Ylfqzzip+kb3O3mMIUuZr9WR1pQp5kYtxPHXwoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693999; c=relaxed/simple;
	bh=GJ1KB3HA9wTP2OfPhWImyyZZ9S4vkw/H449styf6YaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdnbiEzqPvwjL3angMoeIUv1o3+WsBZxO4xIzjAzM80qDN1pfJPLetTWN2ssjnhmAD9Dve2aQNo4DSbDbhJeyRb+IzW0rRblJWY1UnbL57MyXev6slW6E+JyHWC61Vbcua1GOzyVsLa0MxsMDMaTOmSKatKKRShfmpjv2NNv6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uttnrhyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1CEC4CEE3;
	Thu,  3 Apr 2025 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743693999;
	bh=GJ1KB3HA9wTP2OfPhWImyyZZ9S4vkw/H449styf6YaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uttnrhyb6gvVoQ3xJLaytaYdTlJ/Z69QRJA7RaLhp099zeGAJDjf1Ros0f9a834ew
	 Xk0eRqaL4ZudYBeJnbO1X0x+wphIOu6r7WG92077hgYmlvoMM62W0KNXhzZGNwL7Uk
	 3wG/7hEIW2HmUzKqy1CA/avqqW1Uw07x132YK6bU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Terry Junge <linuxhid@cosmicgizmosystems.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.6 02/26] HID: hid-plantronics: Add mic mute mapping and generalize quirks
Date: Thu,  3 Apr 2025 16:20:23 +0100
Message-ID: <20250403151622.485985043@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403151622.415201055@linuxfoundation.org>
References: <20250403151622.415201055@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Terry Junge <linuxhid@cosmicgizmosystems.com>

commit 9821709af892be9fbf4ee9a50b2f3e0604295ce0 upstream.

Add mapping for headset mute key events.

Remove PLT_QUIRK_DOUBLE_VOLUME_KEYS quirk and made it generic.
The quirk logic did not keep track of the actual previous key
so any key event occurring in less than or equal to 5ms was ignored.

Remove PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS quirk.
It had the same logic issue as the double key quirk and was actually
masking the as designed behavior of most of the headsets.
It's occurrence should be minimized with the ALSA control naming
quirk that is part of the patch set.

Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-plantronics.c |  148 +++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 79 deletions(-)

--- a/drivers/hid/hid-plantronics.c
+++ b/drivers/hid/hid-plantronics.c
@@ -6,9 +6,6 @@
  *  Copyright (c) 2015-2018 Terry Junge <terry.junge@plantronics.com>
  */
 
-/*
- */
-
 #include "hid-ids.h"
 
 #include <linux/hid.h>
@@ -23,30 +20,28 @@
 
 #define PLT_VOL_UP		0x00b1
 #define PLT_VOL_DOWN		0x00b2
+#define PLT_MIC_MUTE		0x00b5
 
 #define PLT1_VOL_UP		(PLT_HID_1_0_PAGE | PLT_VOL_UP)
 #define PLT1_VOL_DOWN		(PLT_HID_1_0_PAGE | PLT_VOL_DOWN)
+#define PLT1_MIC_MUTE		(PLT_HID_1_0_PAGE | PLT_MIC_MUTE)
 #define PLT2_VOL_UP		(PLT_HID_2_0_PAGE | PLT_VOL_UP)
 #define PLT2_VOL_DOWN		(PLT_HID_2_0_PAGE | PLT_VOL_DOWN)
+#define PLT2_MIC_MUTE		(PLT_HID_2_0_PAGE | PLT_MIC_MUTE)
+#define HID_TELEPHONY_MUTE	(HID_UP_TELEPHONY | 0x2f)
+#define HID_CONSUMER_MUTE	(HID_UP_CONSUMER | 0xe2)
 
 #define PLT_DA60		0xda60
 #define PLT_BT300_MIN		0x0413
 #define PLT_BT300_MAX		0x0418
 
-
-#define PLT_ALLOW_CONSUMER (field->application == HID_CP_CONSUMERCONTROL && \
-			    (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER)
-
-#define PLT_QUIRK_DOUBLE_VOLUME_KEYS BIT(0)
-#define PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS BIT(1)
-
 #define PLT_DOUBLE_KEY_TIMEOUT 5 /* ms */
-#define PLT_FOLLOWED_OPPOSITE_KEY_TIMEOUT 220 /* ms */
 
 struct plt_drv_data {
 	unsigned long device_type;
-	unsigned long last_volume_key_ts;
-	u32 quirks;
+	unsigned long last_key_ts;
+	unsigned long double_key_to;
+	__u16 last_key;
 };
 
 static int plantronics_input_mapping(struct hid_device *hdev,
@@ -58,34 +53,43 @@ static int plantronics_input_mapping(str
 	unsigned short mapped_key;
 	struct plt_drv_data *drv_data = hid_get_drvdata(hdev);
 	unsigned long plt_type = drv_data->device_type;
+	int allow_mute = usage->hid == HID_TELEPHONY_MUTE;
+	int allow_consumer = field->application == HID_CP_CONSUMERCONTROL &&
+			(usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER &&
+			usage->hid != HID_CONSUMER_MUTE;
 
 	/* special case for PTT products */
 	if (field->application == HID_GD_JOYSTICK)
 		goto defaulted;
 
-	/* handle volume up/down mapping */
 	/* non-standard types or multi-HID interfaces - plt_type is PID */
 	if (!(plt_type & HID_USAGE_PAGE)) {
 		switch (plt_type) {
 		case PLT_DA60:
-			if (PLT_ALLOW_CONSUMER)
+			if (allow_consumer)
 				goto defaulted;
-			goto ignored;
+			if (usage->hid == HID_CONSUMER_MUTE) {
+				mapped_key = KEY_MICMUTE;
+				goto mapped;
+			}
+			break;
 		default:
-			if (PLT_ALLOW_CONSUMER)
+			if (allow_consumer || allow_mute)
 				goto defaulted;
 		}
+		goto ignored;
 	}
-	/* handle standard types - plt_type is 0xffa0uuuu or 0xffa2uuuu */
-	/* 'basic telephony compliant' - allow default consumer page map */
-	else if ((plt_type & HID_USAGE) >= PLT_BASIC_TELEPHONY &&
-		 (plt_type & HID_USAGE) != PLT_BASIC_EXCEPTION) {
-		if (PLT_ALLOW_CONSUMER)
-			goto defaulted;
-	}
-	/* not 'basic telephony' - apply legacy mapping */
-	/* only map if the field is in the device's primary vendor page */
-	else if (!((field->application ^ plt_type) & HID_USAGE_PAGE)) {
+
+	/* handle standard consumer control mapping */
+	/* and standard telephony mic mute mapping */
+	if (allow_consumer || allow_mute)
+		goto defaulted;
+
+	/* handle vendor unique types - plt_type is 0xffa0uuuu or 0xffa2uuuu */
+	/* if not 'basic telephony compliant' - map vendor unique controls */
+	if (!((plt_type & HID_USAGE) >= PLT_BASIC_TELEPHONY &&
+	      (plt_type & HID_USAGE) != PLT_BASIC_EXCEPTION) &&
+	      !((field->application ^ plt_type) & HID_USAGE_PAGE))
 		switch (usage->hid) {
 		case PLT1_VOL_UP:
 		case PLT2_VOL_UP:
@@ -95,8 +99,11 @@ static int plantronics_input_mapping(str
 		case PLT2_VOL_DOWN:
 			mapped_key = KEY_VOLUMEDOWN;
 			goto mapped;
+		case PLT1_MIC_MUTE:
+		case PLT2_MIC_MUTE:
+			mapped_key = KEY_MICMUTE;
+			goto mapped;
 		}
-	}
 
 /*
  * Future mapping of call control or other usages,
@@ -105,6 +112,8 @@ static int plantronics_input_mapping(str
  */
 
 ignored:
+	hid_dbg(hdev, "usage: %08x (appl: %08x) - ignored\n",
+		usage->hid, field->application);
 	return -1;
 
 defaulted:
@@ -123,38 +132,26 @@ static int plantronics_event(struct hid_
 			     struct hid_usage *usage, __s32 value)
 {
 	struct plt_drv_data *drv_data = hid_get_drvdata(hdev);
+	unsigned long prev_tsto, cur_ts;
+	__u16 prev_key, cur_key;
 
-	if (drv_data->quirks & PLT_QUIRK_DOUBLE_VOLUME_KEYS) {
-		unsigned long prev_ts, cur_ts;
-
-		/* Usages are filtered in plantronics_usages. */
-
-		if (!value) /* Handle key presses only. */
-			return 0;
-
-		prev_ts = drv_data->last_volume_key_ts;
-		cur_ts = jiffies;
-		if (jiffies_to_msecs(cur_ts - prev_ts) <= PLT_DOUBLE_KEY_TIMEOUT)
-			return 1; /* Ignore the repeated key. */
-
-		drv_data->last_volume_key_ts = cur_ts;
-	}
-	if (drv_data->quirks & PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS) {
-		unsigned long prev_ts, cur_ts;
-
-		/* Usages are filtered in plantronics_usages. */
-
-		if (!value) /* Handle key presses only. */
-			return 0;
+	/* Usages are filtered in plantronics_usages. */
 
-		prev_ts = drv_data->last_volume_key_ts;
-		cur_ts = jiffies;
-		if (jiffies_to_msecs(cur_ts - prev_ts) <= PLT_FOLLOWED_OPPOSITE_KEY_TIMEOUT)
-			return 1; /* Ignore the followed opposite volume key. */
-
-		drv_data->last_volume_key_ts = cur_ts;
+	/* HZ too low for ms resolution - double key detection disabled */
+	/* or it is a key release - handle key presses only. */
+	if (!drv_data->double_key_to || !value)
+		return 0;
+
+	prev_tsto = drv_data->last_key_ts + drv_data->double_key_to;
+	cur_ts = drv_data->last_key_ts = jiffies;
+	prev_key = drv_data->last_key;
+	cur_key = drv_data->last_key = usage->code;
+
+	/* If the same key occurs in <= double_key_to -- ignore it */
+	if (prev_key == cur_key && time_before_eq(cur_ts, prev_tsto)) {
+		hid_dbg(hdev, "double key %d ignored\n", cur_key);
+		return 1; /* Ignore the repeated key. */
 	}
-
 	return 0;
 }
 
@@ -196,12 +193,16 @@ static int plantronics_probe(struct hid_
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
-		goto err;
+		return ret;
 	}
 
 	drv_data->device_type = plantronics_device_type(hdev);
-	drv_data->quirks = id->driver_data;
-	drv_data->last_volume_key_ts = jiffies - msecs_to_jiffies(PLT_DOUBLE_KEY_TIMEOUT);
+	drv_data->double_key_to = msecs_to_jiffies(PLT_DOUBLE_KEY_TIMEOUT);
+	drv_data->last_key_ts = jiffies - drv_data->double_key_to;
+
+	/* if HZ does not allow ms resolution - disable double key detection */
+	if (drv_data->double_key_to < PLT_DOUBLE_KEY_TIMEOUT)
+		drv_data->double_key_to = 0;
 
 	hid_set_drvdata(hdev, drv_data);
 
@@ -210,29 +211,10 @@ static int plantronics_probe(struct hid_
 	if (ret)
 		hid_err(hdev, "hw start failed\n");
 
-err:
 	return ret;
 }
 
 static const struct hid_device_id plantronics_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3210_SERIES),
-		.driver_data = PLT_QUIRK_DOUBLE_VOLUME_KEYS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3220_SERIES),
-		.driver_data = PLT_QUIRK_DOUBLE_VOLUME_KEYS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3215_SERIES),
-		.driver_data = PLT_QUIRK_DOUBLE_VOLUME_KEYS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3225_SERIES),
-		.driver_data = PLT_QUIRK_DOUBLE_VOLUME_KEYS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_BLACKWIRE_3325_SERIES),
-		.driver_data = PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS,
-					 USB_DEVICE_ID_PLANTRONICS_ENCOREPRO_500_SERIES),
-		.driver_data = PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
 	{ }
 };
@@ -241,6 +223,14 @@ MODULE_DEVICE_TABLE(hid, plantronics_dev
 static const struct hid_usage_id plantronics_usages[] = {
 	{ HID_CP_VOLUMEUP, EV_KEY, HID_ANY_ID },
 	{ HID_CP_VOLUMEDOWN, EV_KEY, HID_ANY_ID },
+	{ HID_TELEPHONY_MUTE, EV_KEY, HID_ANY_ID },
+	{ HID_CONSUMER_MUTE, EV_KEY, HID_ANY_ID },
+	{ PLT2_VOL_UP, EV_KEY, HID_ANY_ID },
+	{ PLT2_VOL_DOWN, EV_KEY, HID_ANY_ID },
+	{ PLT2_MIC_MUTE, EV_KEY, HID_ANY_ID },
+	{ PLT1_VOL_UP, EV_KEY, HID_ANY_ID },
+	{ PLT1_VOL_DOWN, EV_KEY, HID_ANY_ID },
+	{ PLT1_MIC_MUTE, EV_KEY, HID_ANY_ID },
 	{ HID_TERMINATOR, HID_TERMINATOR, HID_TERMINATOR }
 };
 



