Return-Path: <stable+bounces-128474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A6A7D7A3
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272C47A26A7
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA67A229B23;
	Mon,  7 Apr 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cmb5ULBo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA6224AFA;
	Mon,  7 Apr 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014106; cv=none; b=mfUUqedWx2YrivwD6UCkvfG6dmnuv4G+tDfoVFADd9VlRlqci/aTU8twHakzBryjYVgsqNubWserFDje0FVrzC0p9igY2RRPzCPKeZ1u8QzLZsMQm/84p8517sdDLncVLOggePoZSQHk3MmgAe5WI92L1wNnzn1uvVLf+b1IrQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014106; c=relaxed/simple;
	bh=gq11TY3FYzygslcnWRHLdACPtbMFhdH0IrI/zbF3//8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daWp1jrST8kTZhMLfODJfZvplda48DJuO2P5sq6G9Z7tjTeSwSnEqS0rAdcXKS1V7kpf+aXvKza2lhhLqHGszzJTTZt4CHhFjHjVp82oqU19aVvTNs0/VCGCgAyU2uJLopNiahtc0GqvDYbwof5pJ/aNqFgL2Ik1Uv6txeTZLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cmb5ULBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97258C4CEDD;
	Mon,  7 Apr 2025 08:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744014106;
	bh=gq11TY3FYzygslcnWRHLdACPtbMFhdH0IrI/zbF3//8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmb5ULBoE5yEQUorX3XvV1CgQf++wOqTGfknRGyKX5ENNdYTGjmmmbvrCowAACR68
	 kV32G7k6UzGj+RPFLXiyNT8Q08sf8/chTjQBmEsAbwjYnmR2vaVDftBP1M20sTTq5x
	 8Rn6emCgzFjpdhEverjdTjgl9gMpwj1reJsty49U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.22
Date: Mon,  7 Apr 2025 10:20:08 +0200
Message-ID: <2025040708-unfounded-mothproof-975b@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025040708-showcase-purifier-a1a7@gregkh>
References: <2025040708-showcase-purifier-a1a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index a646151342b8..f380005d1600 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 21
+SUBLEVEL = 22
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index b3e615cbd2ca..461f57f66631 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -368,6 +368,25 @@ static int mchp_tc_probe(struct platform_device *pdev)
 			channel);
 	}
 
+	/* Disable Quadrature Decoder and position measure */
+	ret = regmap_update_bits(regmap, ATMEL_TC_BMR, ATMEL_TC_QDEN | ATMEL_TC_POSEN, 0);
+	if (ret)
+		return ret;
+
+	/* Setup the period capture mode */
+	ret = regmap_update_bits(regmap, ATMEL_TC_REG(priv->channel[0], CMR),
+				 ATMEL_TC_WAVE | ATMEL_TC_ABETRG | ATMEL_TC_CMR_MASK |
+				 ATMEL_TC_TCCLKS,
+				 ATMEL_TC_CMR_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable clock and trigger counter */
+	ret = regmap_write(regmap, ATMEL_TC_REG(priv->channel[0], CCR),
+			   ATMEL_TC_CLKEN | ATMEL_TC_SWTRG);
+	if (ret)
+		return ret;
+
 	priv->tc_cfg = tcb_config;
 	priv->regmap = regmap;
 	counter->name = dev_name(&pdev->dev);
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 8439755559b2..537fe9b669f3 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -58,37 +58,43 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
 		return 0;
 	}
 
+	ret = clk_enable(priv->clk);
+	if (ret)
+		goto disable_cnt;
+
 	/* LP timer must be enabled before writing CMP & ARR */
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, priv->ceiling);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, 0);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	/* ensure CMP & ARR registers are properly written */
 	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
 				       (val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK,
 				       100, 1000);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
 			   STM32_LPTIM_CMPOKCF_ARROKCF);
 	if (ret)
-		return ret;
+		goto disable_clk;
 
-	ret = clk_enable(priv->clk);
-	if (ret) {
-		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
-		return ret;
-	}
 	priv->enabled = true;
 
 	/* Start LP timer in continuous mode */
 	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
 				  STM32_LPTIM_CNTSTRT, STM32_LPTIM_CNTSTRT);
+
+disable_clk:
+	clk_disable(priv->clk);
+disable_cnt:
+	regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
+
+	return ret;
 }
 
 static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d9a3917d207e..c4c6538eabae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3231,8 +3231,7 @@ static int dm_resume(void *handle)
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
-	int i, r, j, ret;
-	bool need_hotplug = false;
+	int i, r, j;
 	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
@@ -3427,23 +3426,16 @@ static int dm_resume(void *handle)
 		    aconnector->mst_root)
 			continue;
 
-		ret = drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr, true);
-
-		if (ret < 0) {
-			dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
-					aconnector->dc_link);
-			need_hotplug = true;
-		}
+		drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
 	}
 	drm_connector_list_iter_end(&iter);
 
-	if (need_hotplug)
-		drm_kms_helper_hotplug_event(ddev);
-
 	amdgpu_dm_irq_resume_late(adev);
 
 	amdgpu_dm_smu_write_watermarks_table(adev);
 
+	drm_kms_helper_hotplug_event(ddev);
+
 	return 0;
 }
 
diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
index 25cfd964dc25..acb9eb18f7cc 100644
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
@@ -58,34 +53,43 @@ static int plantronics_input_mapping(struct hid_device *hdev,
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
@@ -95,8 +99,11 @@ static int plantronics_input_mapping(struct hid_device *hdev,
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
@@ -105,6 +112,8 @@ static int plantronics_input_mapping(struct hid_device *hdev,
  */
 
 ignored:
+	hid_dbg(hdev, "usage: %08x (appl: %08x) - ignored\n",
+		usage->hid, field->application);
 	return -1;
 
 defaulted:
@@ -123,38 +132,26 @@ static int plantronics_event(struct hid_device *hdev, struct hid_field *field,
 			     struct hid_usage *usage, __s32 value)
 {
 	struct plt_drv_data *drv_data = hid_get_drvdata(hdev);
+	unsigned long prev_tsto, cur_ts;
+	__u16 prev_key, cur_key;
 
-	if (drv_data->quirks & PLT_QUIRK_DOUBLE_VOLUME_KEYS) {
-		unsigned long prev_ts, cur_ts;
+	/* Usages are filtered in plantronics_usages. */
 
-		/* Usages are filtered in plantronics_usages. */
+	/* HZ too low for ms resolution - double key detection disabled */
+	/* or it is a key release - handle key presses only. */
+	if (!drv_data->double_key_to || !value)
+		return 0;
 
-		if (!value) /* Handle key presses only. */
-			return 0;
+	prev_tsto = drv_data->last_key_ts + drv_data->double_key_to;
+	cur_ts = drv_data->last_key_ts = jiffies;
+	prev_key = drv_data->last_key;
+	cur_key = drv_data->last_key = usage->code;
 
-		prev_ts = drv_data->last_volume_key_ts;
-		cur_ts = jiffies;
-		if (jiffies_to_msecs(cur_ts - prev_ts) <= PLT_DOUBLE_KEY_TIMEOUT)
-			return 1; /* Ignore the repeated key. */
-
-		drv_data->last_volume_key_ts = cur_ts;
+	/* If the same key occurs in <= double_key_to -- ignore it */
+	if (prev_key == cur_key && time_before_eq(cur_ts, prev_tsto)) {
+		hid_dbg(hdev, "double key %d ignored\n", cur_key);
+		return 1; /* Ignore the repeated key. */
 	}
-	if (drv_data->quirks & PLT_QUIRK_FOLLOWED_OPPOSITE_VOLUME_KEYS) {
-		unsigned long prev_ts, cur_ts;
-
-		/* Usages are filtered in plantronics_usages. */
-
-		if (!value) /* Handle key presses only. */
-			return 0;
-
-		prev_ts = drv_data->last_volume_key_ts;
-		cur_ts = jiffies;
-		if (jiffies_to_msecs(cur_ts - prev_ts) <= PLT_FOLLOWED_OPPOSITE_KEY_TIMEOUT)
-			return 1; /* Ignore the followed opposite volume key. */
-
-		drv_data->last_volume_key_ts = cur_ts;
-	}
-
 	return 0;
 }
 
@@ -196,12 +193,16 @@ static int plantronics_probe(struct hid_device *hdev,
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
 
@@ -210,29 +211,10 @@ static int plantronics_probe(struct hid_device *hdev,
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
@@ -241,6 +223,14 @@ MODULE_DEVICE_TABLE(hid, plantronics_devices);
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
 
diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index ffdd8de9ec5d..d99f8922d4ad 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -813,6 +813,7 @@ static void rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 
 	host->eject = true;
 	cancel_work_sync(&host->handle_req);
+	cancel_delayed_work_sync(&host->poll_card);
 
 	mutex_lock(&host->host_mutex);
 	if (host->req) {
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 9fe7f704a2f7..944a33361dae 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1365,9 +1365,11 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10b0, 0)}, /* Telit FE990B */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c0, 0)}, /* Telit FE910C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c4, 0)}, /* Telit FE910C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c8, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10d0, 0)}, /* Telit FN990B */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 44179f4e807f..aeab2308b150 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -178,6 +178,17 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 }
 EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
 
+static bool usbnet_needs_usb_name_format(struct usbnet *dev, struct net_device *net)
+{
+	/* Point to point devices which don't have a real MAC address
+	 * (or report a fake local one) have historically used the usb%d
+	 * naming. Preserve this..
+	 */
+	return (dev->driver_info->flags & FLAG_POINTTOPOINT) != 0 &&
+		(is_zero_ether_addr(net->dev_addr) ||
+		 is_local_ether_addr(net->dev_addr));
+}
+
 static void intr_complete (struct urb *urb)
 {
 	struct usbnet	*dev = urb->context;
@@ -1762,13 +1773,11 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		if (status < 0)
 			goto out1;
 
-		// heuristic:  "usb%d" for links we know are two-host,
-		// else "eth%d" when there's reasonable doubt.  userspace
-		// can rename the link if it knows better.
+		/* heuristic: rename to "eth%d" if we are not sure this link
+		 * is two-host (these links keep "usb%d")
+		 */
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
-		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     /* somebody touched it*/
-		     !is_zero_ether_addr(net->dev_addr)))
+		    !usbnet_needs_usb_name_format(dev, net))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index f245a84f4a50..bdd26c9f34bd 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -162,7 +162,7 @@ void serial8250_tx_dma_flush(struct uart_8250_port *p)
 	 */
 	dma->tx_size = 0;
 
-	dmaengine_terminate_async(dma->rxchan);
+	dmaengine_terminate_async(dma->txchan);
 }
 
 int serial8250_rx_dma(struct uart_8250_port *p)
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index de6d90bf0d70..b3c19ba777c6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2687,6 +2687,22 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init		= pci_oxsemi_tornado_init,
 		.setup		= pci_oxsemi_tornado_setup,
 	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4026,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4021,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8811,
@@ -5213,6 +5229,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-235/246
 	 */
@@ -5333,6 +5357,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C42,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C43,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	/*
 	 * Brainboxes UC-420
 	 */
@@ -5559,6 +5591,20 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_oxsemi_1_15625000 },
+	/*
+	 * Brainboxes XC-235
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4026,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * Brainboxes XC-475
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4021,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
 
 	/*
 	 * Perle PCI-RAS cards
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 77efa7ee6eda..9f9fc733eb2c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1483,6 +1483,19 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 
 	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
 				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
+	u32 ctrl;
+
+	/* TXRTSE and TXRTSPOL only can be changed when transmitter is disabled. */
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	if (ctrl & UARTCTRL_TE) {
+		/* wait for the transmit engine to complete */
+		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
+		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE, UARTCTRL);
+
+		while (lpuart32_read(&sport->port, UARTCTRL) & UARTCTRL_TE)
+			cpu_relax();
+	}
+
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
@@ -1502,6 +1515,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 	}
 
 	lpuart32_write(&sport->port, modem, UARTMODIR);
+
+	if (ctrl & UARTCTRL_TE)
+		lpuart32_write(&sport->port, ctrl, UARTCTRL);
+
 	return 0;
 }
 
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index f5199fdecff2..9b9981352b1e 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -965,10 +965,8 @@ static void stm32_usart_start_tx(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
 
-	if (kfifo_is_empty(&tport->xmit_fifo) && !port->x_char) {
-		stm32_usart_rs485_rts_disable(port);
+	if (kfifo_is_empty(&tport->xmit_fifo) && !port->x_char)
 		return;
-	}
 
 	stm32_usart_rs485_rts_enable(port);
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4384b86ea7b6..2fad9563dca4 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2866,6 +2866,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		if (!ep_seg) {
 
 			if (ep->skip && usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
+				/* this event is unlikely to match any TD, don't skip them all */
+				if (trb_comp_code == COMP_STOPPED_LENGTH_INVALID)
+					return 0;
+
 				skip_isoc_td(xhci, td, ep, status);
 				if (!list_empty(&ep_ring->td_list))
 					continue;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 439767d242fa..71588e4db0e3 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1748,11 +1748,20 @@ static inline void xhci_write_64(struct xhci_hcd *xhci,
 }
 
 
-/* Link TRB chain should always be set on 0.95 hosts, and AMD 0.96 ISOC rings */
+/*
+ * Reportedly, some chapters of v0.95 spec said that Link TRB always has its chain bit set.
+ * Other chapters and later specs say that it should only be set if the link is inside a TD
+ * which continues from the end of one segment to the next segment.
+ *
+ * Some 0.95 hardware was found to misbehave if any link TRB doesn't have the chain bit set.
+ *
+ * 0.96 hardware from AMD and NEC was found to ignore unchained isochronous link TRBs when
+ * "resynchronizing the pipe" after a Missed Service Error.
+ */
 static inline bool xhci_link_chain_quirk(struct xhci_hcd *xhci, enum xhci_ring_type type)
 {
 	return (xhci->quirks & XHCI_LINK_TRB_QUIRK) ||
-	       (type == TYPE_ISOC && (xhci->quirks & XHCI_AMD_0x96_HOST));
+	       (type == TYPE_ISOC && (xhci->quirks & (XHCI_AMD_0x96_HOST | XHCI_NEC_HOST)));
 }
 
 /* xHCI debugging */
diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
index 405cf08bda34..e599d5ac6e4d 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -520,10 +520,12 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
 		ret = -ENOENT;
 		goto err;
 	}
-	ret = __bch2_unlink(dir, victim, true);
+
+	ret =   inode_permission(file_mnt_idmap(filp), d_inode(victim), MAY_WRITE) ?:
+		__bch2_unlink(dir, victim, true);
 	if (!ret) {
 		fsnotify_rmdir(dir, victim);
-		d_delete(victim);
+		d_invalidate(victim);
 	}
 err:
 	inode_unlock(dir);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 4a765555bf84..1c8fcb04b3cd 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -2052,7 +2052,6 @@ static inline int check_for_legacy_methods(int status, struct net *net)
 		path_put(&path);
 		if (status)
 			return -ENOTDIR;
-		status = nn->client_tracking_ops->init(net);
 	}
 	return status;
 }
diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 324e3ab96bb3..12da0269275c 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -1314,6 +1314,8 @@ static void MPOA_cache_impos_rcvd(struct k_message *msg,
 	holding_time = msg->content.eg_info.holding_time;
 	dprintk("(%s) entry = %p, holding_time = %u\n",
 		mpc->dev->name, entry, holding_time);
+	if (entry == NULL && !holding_time)
+		return;
 	if (entry == NULL && holding_time) {
 		entry = mpc->eg_ops->add_entry(msg, mpc);
 		mpc->eg_ops->put(entry);
diff --git a/net/ipv6/netfilter/nf_socket_ipv6.c b/net/ipv6/netfilter/nf_socket_ipv6.c
index a7690ec62325..9ea5ef56cb27 100644
--- a/net/ipv6/netfilter/nf_socket_ipv6.c
+++ b/net/ipv6/netfilter/nf_socket_ipv6.c
@@ -103,6 +103,10 @@ struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
 	struct sk_buff *data_skb = NULL;
 	int doff = 0;
 	int thoff = 0, tproto;
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn const *ct;
+#endif
 
 	tproto = ipv6_find_hdr(skb, &thoff, -1, NULL, NULL);
 	if (tproto < 0) {
@@ -136,6 +140,25 @@ struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
 		return NULL;
 	}
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+	/* Do the lookup with the original socket address in
+	 * case this is a reply packet of an established
+	 * SNAT-ted connection.
+	 */
+	ct = nf_ct_get(skb, &ctinfo);
+	if (ct &&
+	    ((tproto != IPPROTO_ICMPV6 &&
+	      ctinfo == IP_CT_ESTABLISHED_REPLY) ||
+	     (tproto == IPPROTO_ICMPV6 &&
+	      ctinfo == IP_CT_RELATED_REPLY)) &&
+	    (ct->status & IPS_SRC_NAT_DONE)) {
+		daddr = &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.u3.in6;
+		dport = (tproto == IPPROTO_TCP) ?
+			ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.u.tcp.port :
+			ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.u.udp.port;
+	}
+#endif
+
 	return nf_socket_get_sock_v6(net, data_skb, doff, tproto, saddr, daddr,
 				     sport, dport, indev);
 }
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3949e2614a66..8c7da13a804c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10441,6 +10441,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8812, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x881d, "HP 250 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x881e, "HP Laptop 15s-du3xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index a95ebcf4e46e..1e7192cb4693 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4156,6 +4156,52 @@ static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
 	}
 }
 
+/*
+ * Some Plantronics headsets have control names that don't meet ALSA naming
+ * standards. This function fixes nonstandard source names. By the time
+ * this function is called the control name should look like one of these:
+ * "source names Playback Volume"
+ * "source names Playback Switch"
+ * "source names Capture Volume"
+ * "source names Capture Switch"
+ * If any of the trigger words are found in the name then the name will
+ * be changed to:
+ * "Headset Playback Volume"
+ * "Headset Playback Switch"
+ * "Headset Capture Volume"
+ * "Headset Capture Switch"
+ * depending on the current suffix.
+ */
+static void snd_fix_plt_name(struct snd_usb_audio *chip,
+			     struct snd_ctl_elem_id *id)
+{
+	/* no variant of "Sidetone" should be added to this list */
+	static const char * const trigger[] = {
+		"Earphone", "Microphone", "Receive", "Transmit"
+	};
+	static const char * const suffix[] = {
+		" Playback Volume", " Playback Switch",
+		" Capture Volume", " Capture Switch"
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(trigger); i++)
+		if (strstr(id->name, trigger[i]))
+			goto triggered;
+	usb_audio_dbg(chip, "no change in %s\n", id->name);
+	return;
+
+triggered:
+	for (i = 0; i < ARRAY_SIZE(suffix); i++)
+		if (strstr(id->name, suffix[i])) {
+			usb_audio_dbg(chip, "fixing kctl name %s\n", id->name);
+			snprintf(id->name, sizeof(id->name), "Headset%s",
+				 suffix[i]);
+			return;
+		}
+	usb_audio_dbg(chip, "something wrong in kctl name %s\n", id->name);
+}
+
 void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 				  struct usb_mixer_elem_info *cval, int unitid,
 				  struct snd_kcontrol *kctl)
@@ -4173,5 +4219,10 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 			cval->min_mute = 1;
 		break;
 	}
+
+	/* ALSA-ify some Plantronics headset control names */
+	if (USB_ID_VENDOR(mixer->chip->usb_id) == 0x047f &&
+	    (cval->control == UAC_FU_MUTE || cval->control == UAC_FU_VOLUME))
+		snd_fix_plt_name(mixer->chip, &kctl->id);
 }
 
diff --git a/tools/perf/Documentation/intel-hybrid.txt b/tools/perf/Documentation/intel-hybrid.txt
index e7a776ad25d7..0379903673a4 100644
--- a/tools/perf/Documentation/intel-hybrid.txt
+++ b/tools/perf/Documentation/intel-hybrid.txt
@@ -8,15 +8,15 @@ Part of events are available on core cpu, part of events are available
 on atom cpu and even part of events are available on both.
 
 Kernel exports two new cpu pmus via sysfs:
-/sys/devices/cpu_core
-/sys/devices/cpu_atom
+/sys/bus/event_source/devices/cpu_core
+/sys/bus/event_source/devices/cpu_atom
 
 The 'cpus' files are created under the directories. For example,
 
-cat /sys/devices/cpu_core/cpus
+cat /sys/bus/event_source/devices/cpu_core/cpus
 0-15
 
-cat /sys/devices/cpu_atom/cpus
+cat /sys/bus/event_source/devices/cpu_atom/cpus
 16-23
 
 It indicates cpu0-cpu15 are core cpus and cpu16-cpu23 are atom cpus.
@@ -60,8 +60,8 @@ can't carry pmu information. So now this type is extended to be PMU aware
 type. The PMU type ID is stored at attr.config[63:32].
 
 PMU type ID is retrieved from sysfs.
-/sys/devices/cpu_atom/type
-/sys/devices/cpu_core/type
+/sys/bus/event_source/devices/cpu_atom/type
+/sys/bus/event_source/devices/cpu_core/type
 
 The new attr.config layout for PERF_TYPE_HARDWARE:
 
diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index dea005410ec0..ee5d333e2ca9 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -188,7 +188,7 @@ in the CPU vendor specific documentation.
 
 The available PMUs and their raw parameters can be listed with
 
-  ls /sys/devices/*/format
+  ls /sys/bus/event_source/devices/*/format
 
 For example the raw event "LSD.UOPS" core pmu event above could
 be specified as
diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index df7b5dfcc26a..7ea882ef293a 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -32,7 +32,7 @@
 #define MAX_PATH 1024
 #endif
 
-#define UNCORE_IIO_PMU_PATH	"devices/uncore_iio_%d"
+#define UNCORE_IIO_PMU_PATH	"bus/event_source/devices/uncore_iio_%d"
 #define SYSFS_UNCORE_PMU_PATH	"%s/"UNCORE_IIO_PMU_PATH
 #define PLATFORM_MAPPING_PATH	UNCORE_IIO_PMU_PATH"/die%d"
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4933efdfee76..628c61397d2d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -96,7 +96,7 @@
 #include <internal/threadmap.h>
 
 #define DEFAULT_SEPARATOR	" "
-#define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
+#define FREEZE_ON_SMI_PATH	"bus/event_source/devices/cpu/freeze_on_smi"
 
 static void print_counters(struct timespec *ts, int argc, const char **argv);
 
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index bf5090f5220b..9c4adfb45f62 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -189,7 +189,7 @@ static bool perf_pmu__mem_events_supported(const char *mnt, struct perf_pmu *pmu
 	if (!e->event_name)
 		return true;
 
-	scnprintf(path, PATH_MAX, "%s/devices/%s/events/%s", mnt, pmu->name, e->event_name);
+	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/events/%s", mnt, pmu->name, e->event_name);
 
 	return !stat(path, &st);
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 61bdda01a05a..ed893c3c6ad9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -33,12 +33,12 @@
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
 enum event_source {
-	/* An event loaded from /sys/devices/<pmu>/events. */
+	/* An event loaded from /sys/bus/event_source/devices/<pmu>/events. */
 	EVENT_SRC_SYSFS,
 	/* An event loaded from a CPUID matched json file. */
 	EVENT_SRC_CPU_JSON,
 	/*
-	 * An event loaded from a /sys/devices/<pmu>/identifier matched json
+	 * An event loaded from a /sys/bus/event_source/devices/<pmu>/identifier matched json
 	 * file.
 	 */
 	EVENT_SRC_SYS_JSON,

