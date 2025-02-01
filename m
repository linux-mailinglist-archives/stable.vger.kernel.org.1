Return-Path: <stable+bounces-111909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5347AA24B41
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919FB7A3734
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629371D5AB5;
	Sat,  1 Feb 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VeCmcONr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E01CB51B;
	Sat,  1 Feb 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431971; cv=none; b=KguFQFnmflIT+Xqn1ZMSnD7jfFDSUudX43nbZy0Cm7plOSGfxHCkqBhYTVQUNnIiww+QBTTi/AZ6baLIhJwzJ9eFRNz7miGzBlWkU0SuQDww4Th0sAQbOVqq9dcBoTO36NUUjbNb9NJcsNEbP9Y+Ha0W/UYb/h9YW3qJL8s3PiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431971; c=relaxed/simple;
	bh=xFv8oLX1FvxEvOzfURO7vKNjyhB8y6e7aiP8Qn+R3SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOQSQdHvPq29EMw7Dec+OOZsYc3zDlKi//05CEBLaQtG40SZJsFfP134JWt92FpZCWfSxUo2b8dbYb3/LGM3a4i14mISUnekNHbu7QLnhsL8AmujDWiBhkiSratR3tZUiCkzt+EknAxTp69m5EHM9XlFpCYyfEutDnKQPjgMHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VeCmcONr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F3FC4CED3;
	Sat,  1 Feb 2025 17:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738431970;
	bh=xFv8oLX1FvxEvOzfURO7vKNjyhB8y6e7aiP8Qn+R3SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VeCmcONr1BB/c0T2Jz+D0LzaZvhbF61emmzPHEePrgVxxXgasN/JSWrV4arOMjl/T
	 QJIDTwK0/ggmHtadi3Jk6pmyWKGA3Vs3HhF7T9PAGu8+v+2Ns1xKiLMKl9AHv+PuXk
	 8dMMpU5kG8g1PkUH37LZAYSrTZO2NlJlObdKjmWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.12
Date: Sat,  1 Feb 2025 18:45:54 +0100
Message-ID: <2025020154-wisplike-symphonic-f823@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025020154-tribunal-bonnet-9db4@gregkh>
References: <2025020154-tribunal-bonnet-9db4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 7cf8f11975f8..9e6246e733eb 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 11
+SUBLEVEL = 12
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index bf636b28e3e1..5bb8b78bf250 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -63,7 +63,8 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 
 bool should_use_dmub_lock(struct dc_link *link)
 {
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 ||
+	    link->psr_settings.psr_version == DC_PSR_VERSION_1)
 		return true;
 
 	if (link->replay_settings.replay_feature_enabled)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 3ea54fd52e46..e2a3764d9d18 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -578,8 +578,8 @@ static void CalculateBytePerPixelAndBlockSizes(
 {
 	*BytePerPixelDETY = 0;
 	*BytePerPixelDETC = 0;
-	*BytePerPixelY = 0;
-	*BytePerPixelC = 0;
+	*BytePerPixelY = 1;
+	*BytePerPixelC = 1;
 
 	if (SourcePixelFormat == dml2_444_64) {
 		*BytePerPixelDETY = 8;
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index fc35f47e2849..ca7f43c8d6f1 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -507,6 +507,9 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	if (!supported_formats || !(supported_formats & BIT(HDMI_COLORSPACE_RGB)))
 		return -EINVAL;
 
+	if (connector->ycbcr_420_allowed != !!(supported_formats & BIT(HDMI_COLORSPACE_YUV420)))
+		return -EINVAL;
+
 	if (!(max_bpc == 8 || max_bpc == 10 || max_bpc == 12))
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index da203045df9b..72b6a119412f 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -107,8 +107,10 @@ v3d_irq(int irq, void *arg)
 
 		v3d_job_update_stats(&v3d->bin_job->base, V3D_BIN);
 		trace_v3d_bcl_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->bin_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -118,8 +120,10 @@ v3d_irq(int irq, void *arg)
 
 		v3d_job_update_stats(&v3d->render_job->base, V3D_RENDER);
 		trace_v3d_rcl_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->render_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -129,8 +133,10 @@ v3d_irq(int irq, void *arg)
 
 		v3d_job_update_stats(&v3d->csd_job->base, V3D_CSD);
 		trace_v3d_csd_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->csd_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -167,8 +173,10 @@ v3d_hub_irq(int irq, void *arg)
 
 		v3d_job_update_stats(&v3d->tfu_job->base, V3D_TFU);
 		trace_v3d_tfu_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->tfu_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0f23be98c56e..ceb3b1a72e23 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -506,7 +506,6 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
 #define I2C_VENDOR_ID_GOODIX		0x27c6
-#define I2C_DEVICE_ID_GOODIX_01E0	0x01e0
 #define I2C_DEVICE_ID_GOODIX_01E8	0x01e8
 #define I2C_DEVICE_ID_GOODIX_01E9	0x01e9
 #define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index e936019d21fe..d1b7ccfb3e05 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1452,8 +1452,7 @@ static const __u8 *mt_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 {
 	if (hdev->vendor == I2C_VENDOR_ID_GOODIX &&
 	    (hdev->product == I2C_DEVICE_ID_GOODIX_01E8 ||
-	     hdev->product == I2C_DEVICE_ID_GOODIX_01E9 ||
-		 hdev->product == I2C_DEVICE_ID_GOODIX_01E0)) {
+	     hdev->product == I2C_DEVICE_ID_GOODIX_01E9)) {
 		if (rdesc[607] == 0x15) {
 			rdesc[607] = 0x25;
 			dev_info(
@@ -2079,10 +2078,7 @@ static const struct hid_device_id mt_devices[] = {
 		     I2C_DEVICE_ID_GOODIX_01E8) },
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
 	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
-		     I2C_DEVICE_ID_GOODIX_01E9) },
-	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
-	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
-		     I2C_DEVICE_ID_GOODIX_01E0) },
+		     I2C_DEVICE_ID_GOODIX_01E8) },
 
 	/* GoodTouch panels */
 	{ .driver_data = MT_CLS_NSMU,
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 9843b52bd017..34428349fa31 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1370,17 +1370,6 @@ static int wacom_led_register_one(struct device *dev, struct wacom *wacom,
 	if (!name)
 		return -ENOMEM;
 
-	if (!read_only) {
-		led->trigger.name = name;
-		error = devm_led_trigger_register(dev, &led->trigger);
-		if (error) {
-			hid_err(wacom->hdev,
-				"failed to register LED trigger %s: %d\n",
-				led->cdev.name, error);
-			return error;
-		}
-	}
-
 	led->group = group;
 	led->id = id;
 	led->wacom = wacom;
@@ -1397,6 +1386,19 @@ static int wacom_led_register_one(struct device *dev, struct wacom *wacom,
 		led->cdev.brightness_set = wacom_led_readonly_brightness_set;
 	}
 
+	if (!read_only) {
+		led->trigger.name = name;
+		if (id == wacom->led.groups[group].select)
+			led->trigger.brightness = wacom_leds_brightness_get(led);
+		error = devm_led_trigger_register(dev, &led->trigger);
+		if (error) {
+			hid_err(wacom->hdev,
+				"failed to register LED trigger %s: %d\n",
+				led->cdev.name, error);
+			return error;
+		}
+	}
+
 	error = devm_led_classdev_register(dev, &led->cdev);
 	if (error) {
 		hid_err(wacom->hdev,
diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 2a4ec55ddb47..291d91f68646 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -194,7 +194,7 @@ static int drivetemp_scsi_command(struct drivetemp_data *st,
 	scsi_cmd[14] = ata_command;
 
 	err = scsi_execute_cmd(st->sdev, scsi_cmd, op, st->smartdata,
-			       ATA_SECT_SIZE, HZ, 5, NULL);
+			       ATA_SECT_SIZE, 10 * HZ, 5, NULL);
 	if (err > 0)
 		err = -EIO;
 	return err;
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 22ea58bf76cb..77fddab9d950 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -150,6 +150,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x028f, "Microsoft X-Box 360 pad v2", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
+	{ 0x045e, 0x02a9, "Xbox 360 Wireless Receiver (Unofficial)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", MAP_PADDLES, XTYPE_XBOXONE },
@@ -305,6 +306,7 @@ static const struct xpad_device {
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x17ef, 0x6182, "Lenovo Legion Controller for Windows", 0, XTYPE_XBOX360 },
 	{ 0x1949, 0x041a, "Amazon Game Controller", 0, XTYPE_XBOX360 },
+	{ 0x1a86, 0xe310, "QH Electronics Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0130, "Ion Drum Rocker", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
@@ -373,16 +375,19 @@ static const struct xpad_device {
 	{ 0x294b, 0x3303, "Snakebyte GAMEPAD BASE X", 0, XTYPE_XBOXONE },
 	{ 0x294b, 0x3404, "Snakebyte GAMEPAD RGB X", 0, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x2000, "8BitDo Pro 2 Wired Controller fox Xbox", 0, XTYPE_XBOXONE },
-	{ 0x2dc8, 0x3106, "8BitDo Pro 2 Wired Controller", 0, XTYPE_XBOX360 },
+	{ 0x2dc8, 0x3106, "8BitDo Ultimate Wireless / Pro 2 Wired Controller", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x310a, "8BitDo Ultimate 2C Wireless Controller", 0, XTYPE_XBOX360 },
 	{ 0x2e24, 0x0652, "Hyperkin Duke X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x31e3, 0x1100, "Wooting One", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1200, "Wooting Two", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1210, "Wooting Lekker", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1220, "Wooting Two HE", 0, XTYPE_XBOX360 },
+	{ 0x31e3, 0x1230, "Wooting Two HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1300, "Wooting 60HE (AVR)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1310, "Wooting 60HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x3285, 0x0607, "Nacon GC-100", 0, XTYPE_XBOX360 },
+	{ 0x3285, 0x0646, "Nacon Pro Compact", 0, XTYPE_XBOXONE },
+	{ 0x3285, 0x0663, "Nacon Evol-X", 0, XTYPE_XBOXONE },
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
@@ -514,6 +519,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
 	XPAD_XBOX360_VENDOR(0x17ef),		/* Lenovo */
 	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
+	XPAD_XBOX360_VENDOR(0x1a86),		/* QH Electronics */
 	XPAD_XBOX360_VENDOR(0x1bad),		/* Harmonix Rock Band guitar and drums */
 	XPAD_XBOX360_VENDOR(0x20d6),		/* PowerA controllers */
 	XPAD_XBOXONE_VENDOR(0x20d6),		/* PowerA controllers */
@@ -530,6 +536,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x2f24),		/* GameSir controllers */
 	XPAD_XBOX360_VENDOR(0x31e3),		/* Wooting Keyboards */
 	XPAD_XBOX360_VENDOR(0x3285),		/* Nacon GC-100 */
+	XPAD_XBOXONE_VENDOR(0x3285),		/* Nacon Evol-X */
 	XPAD_XBOX360_VENDOR(0x3537),		/* GameSir Controllers */
 	XPAD_XBOXONE_VENDOR(0x3537),		/* GameSir Controllers */
 	{ }
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 5855d4fc6e6a..f7b08b359c9c 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -89,7 +89,7 @@ static const unsigned short atkbd_set2_keycode[ATKBD_KEYMAP_SIZE] = {
 	  0, 46, 45, 32, 18,  5,  4, 95,  0, 57, 47, 33, 20, 19,  6,183,
 	  0, 49, 48, 35, 34, 21,  7,184,  0,  0, 50, 36, 22,  8,  9,185,
 	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
-	  0, 89, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0, 85,
+	  0, 89, 40,  0, 26, 13,  0,193, 58, 54, 28, 27,  0, 43,  0, 85,
 	  0, 86, 91, 90, 92,  0, 14, 94,  0, 79,124, 75, 71,121,  0,  0,
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
 
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index bb92fd85e975..0b4312152024 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -186,7 +186,8 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[0].chip.irq_unmask	= irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_eoi		= irq_gc_ack_set_bit;
 	gc->chip_types[0].chip.irq_set_type	= sunxi_sc_nmi_set_type;
-	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED;
+	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
+						  IRQCHIP_SKIP_SET_WAKE;
 	gc->chip_types[0].regs.ack		= reg_offs->pend;
 	gc->chip_types[0].regs.mask		= reg_offs->enable;
 	gc->chip_types[0].regs.type		= reg_offs->ctrl;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index f95898f68d68..4ce0c05c5129 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -8147,6 +8147,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x817e, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8186, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818a, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x317f, 0xff, 0xff, 0xff),
@@ -8157,12 +8159,18 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x050d, 0x1102, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x050d, 0x11f2, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe033, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8188, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8189, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9041, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9043, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x17ba, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x1e1e, 0xff, 0xff, 0xff),
@@ -8179,6 +8187,10 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x13d3, 0x3357, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x13d3, 0x3358, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x13d3, 0x3359, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330b, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x2019, 0x4902, 0xff, 0xff, 0xff),
@@ -8193,6 +8205,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x4856, 0x0091, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x9846, 0x9041, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0xcdab, 0x8010, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x04f2, 0xaff7, 0xff, 0xff, 0xff),
@@ -8218,6 +8232,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0586, 0x341f, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe033, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe035, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x17ab, 0xff, 0xff, 0xff),
@@ -8226,6 +8242,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0df6, 0x0070, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x0df6, 0x0077, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x0789, 0x016d, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x07aa, 0x0056, 0xff, 0xff, 0xff),
@@ -8248,6 +8266,8 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330a, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330d, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x2019, 0xab2b, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x624d, 0xff, 0xff, 0xff),
diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
index fa39611071b3..cd310b26b50c 100644
--- a/drivers/of/unittest-data/tests-platform.dtsi
+++ b/drivers/of/unittest-data/tests-platform.dtsi
@@ -34,5 +34,18 @@ dev@100 {
 				};
 			};
 		};
+
+		platform-tests-2 {
+			// No #address-cells or #size-cells
+			node {
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				test-device@100 {
+					compatible = "test-sub-device";
+					reg = <0x100 1>;
+				};
+			};
+		};
 	};
 };
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index daf9a2dddd7e..576e9beefc7c 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1342,6 +1342,7 @@ static void __init of_unittest_bus_3cell_ranges(void)
 static void __init of_unittest_reg(void)
 {
 	struct device_node *np;
+	struct resource res;
 	int ret;
 	u64 addr, size;
 
@@ -1358,6 +1359,19 @@ static void __init of_unittest_reg(void)
 		np, addr);
 
 	of_node_put(np);
+
+	np = of_find_node_by_path("/testcase-data/platform-tests-2/node/test-device@100");
+	if (!np) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	ret = of_address_to_resource(np, 0, &res);
+	unittest(ret == -EINVAL, "of_address_to_resource(%pOF) expected error on untranslatable address\n",
+		 np);
+
+	of_node_put(np);
+
 }
 
 struct of_unittest_expected_res {
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index fde7de3b1e55..9b47f91c5b97 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -4104,7 +4104,7 @@ iscsi_if_rx(struct sk_buff *skb)
 		}
 		do {
 			/*
-			 * special case for GET_STATS:
+			 * special case for GET_STATS, GET_CHAP and GET_HOST_STATS:
 			 * on success - sending reply and stats from
 			 * inside of if_recv_msg(),
 			 * on error - fall through.
@@ -4113,6 +4113,8 @@ iscsi_if_rx(struct sk_buff *skb)
 				break;
 			if (ev->type == ISCSI_UEVENT_GET_CHAP && !err)
 				break;
+			if (ev->type == ISCSI_UEVENT_GET_HOST_STATS && !err)
+				break;
 			err = iscsi_if_send_reply(portid, nlh->nlmsg_type,
 						  ev, sizeof(*ev));
 			if (err == -EAGAIN && --retries < 0) {
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d0b55c1fa908..b3c588b102d9 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -171,6 +171,12 @@ do {								\
 		dev_warn(&(dev)->device, fmt, ##__VA_ARGS__);	\
 } while (0)
 
+#define storvsc_log_ratelimited(dev, level, fmt, ...)				\
+do {										\
+	if (do_logging(level))							\
+		dev_warn_ratelimited(&(dev)->device, fmt, ##__VA_ARGS__);	\
+} while (0)
+
 struct vmscsi_request {
 	u16 length;
 	u8 srb_status;
@@ -1177,7 +1183,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 		int loglevel = (stor_pkt->vm_srb.cdb[0] == TEST_UNIT_READY) ?
 			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
 
-		storvsc_log(device, loglevel,
+		storvsc_log_ratelimited(device, loglevel,
 			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
 			scsi_cmd_to_rq(request->cmd)->tag,
 			stor_pkt->vm_srb.cdb[0],
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index bc143a86c2dd..53d9fc41acc5 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1420,10 +1420,6 @@ void gserial_disconnect(struct gserial *gser)
 	/* REVISIT as above: how best to track this? */
 	port->port_line_coding = gser->port_line_coding;
 
-	/* disable endpoints, aborting down any active I/O */
-	usb_ep_disable(gser->out);
-	usb_ep_disable(gser->in);
-
 	port->port_usb = NULL;
 	gser->ioport = NULL;
 	if (port->port.count > 0) {
@@ -1435,6 +1431,10 @@ void gserial_disconnect(struct gserial *gser)
 	spin_unlock(&port->port_lock);
 	spin_unlock_irqrestore(&serial_port_lock, flags);
 
+	/* disable endpoints, aborting down any active I/O */
+	usb_ep_disable(gser->out);
+	usb_ep_disable(gser->in);
+
 	/* finally, free any unused/unusable I/O buffers */
 	spin_lock_irqsave(&port->port_lock, flags);
 	if (port->port.count == 0)
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index a317bdbd00ad..72fe83a6c978 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -503,7 +503,7 @@ static void qt2_process_read_urb(struct urb *urb)
 
 				newport = *(ch + 3);
 
-				if (newport > serial->num_ports) {
+				if (newport >= serial->num_ports) {
 					dev_err(&port->dev,
 						"%s - port change to invalid port: %i\n",
 						__func__, newport);
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index e53757d1d095..3bf1043cd795 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -388,6 +388,11 @@ static ssize_t vfio_platform_read_mmio(struct vfio_platform_region *reg,
 {
 	unsigned int done = 0;
 
+	if (off >= reg->size)
+		return -EINVAL;
+
+	count = min_t(size_t, count, reg->size - off);
+
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap(reg->addr, reg->size);
@@ -467,6 +472,11 @@ static ssize_t vfio_platform_write_mmio(struct vfio_platform_region *reg,
 {
 	unsigned int done = 0;
 
+	if (off >= reg->size)
+		return -EINVAL;
+
+	count = min_t(size_t, count, reg->size - off);
+
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap(reg->addr, reg->size);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index f7dd64856c9b..ac6f50167076 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -251,6 +251,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 		error = filemap_fdatawait(inode->i_mapping);
 		if (error)
 			goto out;
+		truncate_inode_pages(inode->i_mapping, 0);
 		if (new_flags & GFS2_DIF_JDATA)
 			gfs2_ordered_del_inode(ip);
 	}
diff --git a/fs/libfs.c b/fs/libfs.c
index 46966fd8bcf9..b0f262223b53 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -241,9 +241,16 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
-/* 0 is '.', 1 is '..', so always start with offset 2 or more */
+/* simple_offset_add() never assigns these to a dentry */
 enum {
-	DIR_OFFSET_MIN	= 2,
+	DIR_OFFSET_FIRST	= 2,		/* Find first real entry */
+	DIR_OFFSET_EOD		= S32_MAX,
+};
+
+/* simple_offset_add() allocation range */
+enum {
+	DIR_OFFSET_MIN		= DIR_OFFSET_FIRST + 1,
+	DIR_OFFSET_MAX		= DIR_OFFSET_EOD - 1,
 };
 
 static void offset_set(struct dentry *dentry, long offset)
@@ -287,9 +294,10 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 		return -EBUSY;
 
 	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
-				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
-	if (ret < 0)
-		return ret;
+				 DIR_OFFSET_MAX, &octx->next_offset,
+				 GFP_KERNEL);
+	if (unlikely(ret < 0))
+		return ret == -EBUSY ? -ENOSPC : ret;
 
 	offset_set(dentry, offset);
 	return 0;
@@ -325,38 +333,6 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 	offset_set(dentry, 0);
 }
 
-/**
- * simple_offset_empty - Check if a dentry can be unlinked
- * @dentry: dentry to be tested
- *
- * Returns 0 if @dentry is a non-empty directory; otherwise returns 1.
- */
-int simple_offset_empty(struct dentry *dentry)
-{
-	struct inode *inode = d_inode(dentry);
-	struct offset_ctx *octx;
-	struct dentry *child;
-	unsigned long index;
-	int ret = 1;
-
-	if (!inode || !S_ISDIR(inode->i_mode))
-		return ret;
-
-	index = DIR_OFFSET_MIN;
-	octx = inode->i_op->get_offset_ctx(inode);
-	mt_for_each(&octx->mt, child, index, LONG_MAX) {
-		spin_lock(&child->d_lock);
-		if (simple_positive(child)) {
-			spin_unlock(&child->d_lock);
-			ret = 0;
-			break;
-		}
-		spin_unlock(&child->d_lock);
-	}
-
-	return ret;
-}
-
 /**
  * simple_offset_rename - handle directory offsets for rename
  * @old_dir: parent directory of source entry
@@ -450,14 +426,6 @@ void simple_offset_destroy(struct offset_ctx *octx)
 	mtree_destroy(&octx->mt);
 }
 
-static int offset_dir_open(struct inode *inode, struct file *file)
-{
-	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
-
-	file->private_data = (void *)ctx->next_offset;
-	return 0;
-}
-
 /**
  * offset_dir_llseek - Advance the read position of a directory descriptor
  * @file: an open directory whose position is to be updated
@@ -471,9 +439,6 @@ static int offset_dir_open(struct inode *inode, struct file *file)
  */
 static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 {
-	struct inode *inode = file->f_inode;
-	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
-
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
@@ -486,62 +451,89 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 		return -EINVAL;
 	}
 
-	/* In this case, ->private_data is protected by f_pos_lock */
-	if (!offset)
-		file->private_data = (void *)ctx->next_offset;
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
-static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
+static struct dentry *find_positive_dentry(struct dentry *parent,
+					   struct dentry *dentry,
+					   bool next)
 {
-	MA_STATE(mas, &octx->mt, offset, offset);
+	struct dentry *found = NULL;
+
+	spin_lock(&parent->d_lock);
+	if (next)
+		dentry = d_next_sibling(dentry);
+	else if (!dentry)
+		dentry = d_first_child(parent);
+	hlist_for_each_entry_from(dentry, d_sib) {
+		if (!simple_positive(dentry))
+			continue;
+		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+		if (simple_positive(dentry))
+			found = dget_dlock(dentry);
+		spin_unlock(&dentry->d_lock);
+		if (likely(found))
+			break;
+	}
+	spin_unlock(&parent->d_lock);
+	return found;
+}
+
+static noinline_for_stack struct dentry *
+offset_dir_lookup(struct dentry *parent, loff_t offset)
+{
+	struct inode *inode = d_inode(parent);
+	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *child, *found = NULL;
 
-	rcu_read_lock();
-	child = mas_find(&mas, LONG_MAX);
-	if (!child)
-		goto out;
-	spin_lock(&child->d_lock);
-	if (simple_positive(child))
-		found = dget_dlock(child);
-	spin_unlock(&child->d_lock);
-out:
-	rcu_read_unlock();
+	MA_STATE(mas, &octx->mt, offset, offset);
+
+	if (offset == DIR_OFFSET_FIRST)
+		found = find_positive_dentry(parent, NULL, false);
+	else {
+		rcu_read_lock();
+		child = mas_find(&mas, DIR_OFFSET_MAX);
+		found = find_positive_dentry(parent, child, false);
+		rcu_read_unlock();
+	}
 	return found;
 }
 
 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	long offset = dentry2offset(dentry);
 
-	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
-			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
+	return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
+			inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
+static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
 {
-	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
+	struct dentry *dir = file->f_path.dentry;
 	struct dentry *dentry;
 
+	dentry = offset_dir_lookup(dir, ctx->pos);
+	if (!dentry)
+		goto out_eod;
 	while (true) {
-		dentry = offset_find_next(octx, ctx->pos);
-		if (!dentry)
-			return;
-
-		if (dentry2offset(dentry) >= last_index) {
-			dput(dentry);
-			return;
-		}
+		struct dentry *next;
 
-		if (!offset_dir_emit(ctx, dentry)) {
-			dput(dentry);
-			return;
-		}
+		ctx->pos = dentry2offset(dentry);
+		if (!offset_dir_emit(ctx, dentry))
+			break;
 
-		ctx->pos = dentry2offset(dentry) + 1;
+		next = find_positive_dentry(dir, dentry, true);
 		dput(dentry);
+
+		if (!next)
+			goto out_eod;
+		dentry = next;
 	}
+	dput(dentry);
+	return;
+
+out_eod:
+	ctx->pos = DIR_OFFSET_EOD;
 }
 
 /**
@@ -561,6 +553,8 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
  *
  * On return, @ctx->pos contains an offset that will read the next entry
  * in this directory when offset_readdir() is called again with @ctx.
+ * Caller places this value in the d_off field of the last entry in the
+ * user's buffer.
  *
  * Return values:
  *   %0 - Complete
@@ -568,19 +562,17 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
 static int offset_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry *dir = file->f_path.dentry;
-	long last_index = (long)file->private_data;
 
 	lockdep_assert_held(&d_inode(dir)->i_rwsem);
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-
-	offset_iterate_dir(d_inode(dir), ctx, last_index);
+	if (ctx->pos != DIR_OFFSET_EOD)
+		offset_iterate_dir(file, ctx);
 	return 0;
 }
 
 const struct file_operations simple_offset_dir_operations = {
-	.open		= offset_dir_open,
 	.llseek		= offset_dir_llseek,
 	.iterate_shared	= offset_readdir,
 	.read		= generic_read_dir,
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index a55f0044d30b..b935c1a62d10 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -176,27 +176,27 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			    struct kvec *out_iov, int *out_buftype, struct dentry *dentry)
 {
 
-	struct reparse_data_buffer *rbuf;
+	struct smb2_query_info_rsp *qi_rsp = NULL;
 	struct smb2_compound_vars *vars = NULL;
-	struct kvec *rsp_iov, *iov;
-	struct smb_rqst *rqst;
-	int rc;
-	__le16 *utf16_path = NULL;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
-	struct cifs_fid fid;
+	struct cifs_open_info_data *idata;
 	struct cifs_ses *ses = tcon->ses;
+	struct reparse_data_buffer *rbuf;
 	struct TCP_Server_Info *server;
-	int num_rqst = 0, i;
 	int resp_buftype[MAX_COMPOUND];
-	struct smb2_query_info_rsp *qi_rsp = NULL;
-	struct cifs_open_info_data *idata;
+	int retries = 0, cur_sleep = 1;
+	__u8 delete_pending[8] = {1,};
+	struct kvec *rsp_iov, *iov;
 	struct inode *inode = NULL;
-	int flags = 0;
-	__u8 delete_pending[8] = {1, 0, 0, 0, 0, 0, 0, 0};
+	__le16 *utf16_path = NULL;
+	struct smb_rqst *rqst;
 	unsigned int size[2];
-	void *data[2];
+	struct cifs_fid fid;
+	int num_rqst = 0, i;
 	unsigned int len;
-	int retries = 0, cur_sleep = 1;
+	int tmp_rc, rc;
+	int flags = 0;
+	void *data[2];
 
 replay_again:
 	/* reinitialize for possible replay */
@@ -637,7 +637,14 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		tcon->need_reconnect = true;
 	}
 
+	tmp_rc = rc;
 	for (i = 0; i < num_cmds; i++) {
+		char *buf = rsp_iov[i + i].iov_base;
+
+		if (buf && resp_buftype[i + 1] != CIFS_NO_BUFFER)
+			rc = server->ops->map_error(buf, false);
+		else
+			rc = tmp_rc;
 		switch (cmds[i]) {
 		case SMB2_OP_QUERY_INFO:
 			idata = in_iov[i].iov_base;
@@ -803,6 +810,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		}
 	}
 	SMB2_close_free(&rqst[num_rqst]);
+	rc = tmp_rc;
 
 	num_cmds += 2;
 	if (out_iov && out_buftype) {
@@ -858,22 +866,52 @@ static int parse_create_response(struct cifs_open_info_data *data,
 	return rc;
 }
 
+/* Check only if SMB2_OP_QUERY_WSL_EA command failed in the compound chain */
+static bool ea_unsupported(int *cmds, int num_cmds,
+			   struct kvec *out_iov, int *out_buftype)
+{
+	int i;
+
+	if (cmds[num_cmds - 1] != SMB2_OP_QUERY_WSL_EA)
+		return false;
+
+	for (i = 1; i < num_cmds - 1; i++) {
+		struct smb2_hdr *hdr = out_iov[i].iov_base;
+
+		if (out_buftype[i] == CIFS_NO_BUFFER || !hdr ||
+		    hdr->Status != STATUS_SUCCESS)
+			return false;
+	}
+	return true;
+}
+
+static inline void free_rsp_iov(struct kvec *iovs, int *buftype, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		free_rsp_buf(buftype[i], iovs[i].iov_base);
+		memset(&iovs[i], 0, sizeof(*iovs));
+		buftype[i] = CIFS_NO_BUFFER;
+	}
+}
+
 int smb2_query_path_info(const unsigned int xid,
 			 struct cifs_tcon *tcon,
 			 struct cifs_sb_info *cifs_sb,
 			 const char *full_path,
 			 struct cifs_open_info_data *data)
 {
+	struct kvec in_iov[3], out_iov[5] = {};
+	struct cached_fid *cfid = NULL;
 	struct cifs_open_parms oparms;
-	__u32 create_options = 0;
 	struct cifsFileInfo *cfile;
-	struct cached_fid *cfid = NULL;
+	__u32 create_options = 0;
+	int out_buftype[5] = {};
 	struct smb2_hdr *hdr;
-	struct kvec in_iov[3], out_iov[3] = {};
-	int out_buftype[3] = {};
+	int num_cmds = 0;
 	int cmds[3];
 	bool islink;
-	int i, num_cmds = 0;
 	int rc, rc2;
 
 	data->adjust_tz = false;
@@ -943,14 +981,14 @@ int smb2_query_path_info(const unsigned int xid,
 		if (rc || !data->reparse_point)
 			goto out;
 
-		if (!tcon->posix_extensions)
-			cmds[num_cmds++] = SMB2_OP_QUERY_WSL_EA;
 		/*
 		 * Skip SMB2_OP_GET_REPARSE if symlink already parsed in create
 		 * response.
 		 */
 		if (data->reparse.tag != IO_REPARSE_TAG_SYMLINK)
 			cmds[num_cmds++] = SMB2_OP_GET_REPARSE;
+		if (!tcon->posix_extensions)
+			cmds[num_cmds++] = SMB2_OP_QUERY_WSL_EA;
 
 		oparms = CIFS_OPARMS(cifs_sb, tcon, full_path,
 				     FILE_READ_ATTRIBUTES |
@@ -958,9 +996,18 @@ int smb2_query_path_info(const unsigned int xid,
 				     FILE_OPEN, create_options |
 				     OPEN_REPARSE_POINT, ACL_NO_MODE);
 		cifs_get_readable_path(tcon, full_path, &cfile);
+		free_rsp_iov(out_iov, out_buftype, ARRAY_SIZE(out_iov));
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      &oparms, in_iov, cmds, num_cmds,
-				      cfile, NULL, NULL, NULL);
+				      cfile, out_iov, out_buftype, NULL);
+		if (rc && ea_unsupported(cmds, num_cmds,
+					 out_iov, out_buftype)) {
+			if (data->reparse.tag != IO_REPARSE_TAG_LX_BLK &&
+			    data->reparse.tag != IO_REPARSE_TAG_LX_CHR)
+				rc = 0;
+			else
+				rc = -EOPNOTSUPP;
+		}
 		break;
 	case -EREMOTE:
 		break;
@@ -978,8 +1025,7 @@ int smb2_query_path_info(const unsigned int xid,
 	}
 
 out:
-	for (i = 0; i < ARRAY_SIZE(out_buftype); i++)
-		free_rsp_buf(out_buftype[i], out_iov[i].iov_base);
+	free_rsp_iov(out_iov, out_buftype, ARRAY_SIZE(out_iov));
 	return rc;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4b5cad44a126..fc3de42d9d76 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3434,7 +3434,6 @@ struct offset_ctx {
 void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
-int simple_offset_empty(struct dentry *dentry);
 int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
 			 struct inode *new_dir, struct dentry *new_dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 709ad84809e1..8934c7da47f4 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -50,10 +50,10 @@ struct seccomp_data;
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 static inline int secure_computing(void) { return 0; }
-static inline int __secure_computing(const struct seccomp_data *sd) { return 0; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif
+static inline int __secure_computing(const struct seccomp_data *sd) { return 0; }
 
 static inline long prctl_get_seccomp(void)
 {
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 6f3b6de230bd..a67bae350416 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1153,6 +1153,13 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 	struct io_rsrc_data *data;
 	int i, ret, nbufs;
 
+	/*
+	 * Accounting state is shared between the two rings; that only works if
+	 * both rings are accounted towards the same counters.
+	 */
+	if (ctx->user != src_ctx->user || ctx->mm_account != src_ctx->mm_account)
+		return -EINVAL;
+
 	/*
 	 * Drop our own lock here. We'll setup the data we need and reference
 	 * the source buffers, then re-grab, check, and assign at the end.
diff --git a/mm/filemap.c b/mm/filemap.c
index dc83baab85a1..05adf0392625 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4383,6 +4383,20 @@ static void filemap_cachestat(struct address_space *mapping,
 	rcu_read_unlock();
 }
 
+/*
+ * See mincore: reveal pagecache information only for files
+ * that the calling process has write access to, or could (if
+ * tried) open for writing.
+ */
+static inline bool can_do_cachestat(struct file *f)
+{
+	if (f->f_mode & FMODE_WRITE)
+		return true;
+	if (inode_owner_or_capable(file_mnt_idmap(f), file_inode(f)))
+		return true;
+	return file_permission(f, MAY_WRITE) == 0;
+}
+
 /*
  * The cachestat(2) system call.
  *
@@ -4442,6 +4456,11 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 		return -EOPNOTSUPP;
 	}
 
+	if (!can_do_cachestat(fd_file(f))) {
+		fdput(f);
+		return -EPERM;
+	}
+
 	if (flags != 0) {
 		fdput(f);
 		return -EINVAL;
diff --git a/mm/shmem.c b/mm/shmem.c
index dd4eb11c84b5..5960e5035f98 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3700,7 +3700,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!simple_offset_empty(dentry))
+	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
 	drop_nlink(d_inode(dentry));
@@ -3757,7 +3757,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		return simple_offset_rename_exchange(old_dir, old_dentry,
 						     new_dir, new_dentry);
 
-	if (!simple_offset_empty(new_dentry))
+	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {
diff --git a/mm/zswap.c b/mm/zswap.c
index 0030ce8fecfc..7fefb2eb3fcd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -251,7 +251,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	struct zswap_pool *pool;
 	char name[38]; /* 'zswap' + 32 char (max) num + \0 */
 	gfp_t gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
-	int ret;
+	int ret, cpu;
 
 	if (!zswap_has_pool) {
 		/* if either are unset, pool initialization failed, and we
@@ -285,6 +285,9 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 		goto error;
 	}
 
+	for_each_possible_cpu(cpu)
+		mutex_init(&per_cpu_ptr(pool->acomp_ctx, cpu)->mutex);
+
 	ret = cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
 				       &pool->node);
 	if (ret)
@@ -812,36 +815,41 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
-	struct crypto_acomp *acomp;
-	struct acomp_req *req;
+	struct crypto_acomp *acomp = NULL;
+	struct acomp_req *req = NULL;
+	u8 *buffer = NULL;
 	int ret;
 
-	mutex_init(&acomp_ctx->mutex);
-
-	acomp_ctx->buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
-	if (!acomp_ctx->buffer)
-		return -ENOMEM;
+	buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
 	if (IS_ERR(acomp)) {
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 				pool->tfm_name, PTR_ERR(acomp));
 		ret = PTR_ERR(acomp);
-		goto acomp_fail;
+		goto fail;
 	}
-	acomp_ctx->acomp = acomp;
-	acomp_ctx->is_sleepable = acomp_is_async(acomp);
 
-	req = acomp_request_alloc(acomp_ctx->acomp);
+	req = acomp_request_alloc(acomp);
 	if (!req) {
 		pr_err("could not alloc crypto acomp_request %s\n",
 		       pool->tfm_name);
 		ret = -ENOMEM;
-		goto req_fail;
+		goto fail;
 	}
-	acomp_ctx->req = req;
 
+	/*
+	 * Only hold the mutex after completing allocations, otherwise we may
+	 * recurse into zswap through reclaim and attempt to hold the mutex
+	 * again resulting in a deadlock.
+	 */
+	mutex_lock(&acomp_ctx->mutex);
 	crypto_init_wait(&acomp_ctx->wait);
+
 	/*
 	 * if the backend of acomp is async zip, crypto_req_done() will wakeup
 	 * crypto_wait_req(); if the backend of acomp is scomp, the callback
@@ -850,12 +858,17 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &acomp_ctx->wait);
 
+	acomp_ctx->buffer = buffer;
+	acomp_ctx->acomp = acomp;
+	acomp_ctx->is_sleepable = acomp_is_async(acomp);
+	acomp_ctx->req = req;
+	mutex_unlock(&acomp_ctx->mutex);
 	return 0;
 
-req_fail:
-	crypto_free_acomp(acomp_ctx->acomp);
-acomp_fail:
-	kfree(acomp_ctx->buffer);
+fail:
+	if (acomp)
+		crypto_free_acomp(acomp);
+	kfree(buffer);
 	return ret;
 }
 
@@ -864,17 +877,45 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
 
+	mutex_lock(&acomp_ctx->mutex);
 	if (!IS_ERR_OR_NULL(acomp_ctx)) {
 		if (!IS_ERR_OR_NULL(acomp_ctx->req))
 			acomp_request_free(acomp_ctx->req);
+		acomp_ctx->req = NULL;
 		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
 			crypto_free_acomp(acomp_ctx->acomp);
 		kfree(acomp_ctx->buffer);
 	}
+	mutex_unlock(&acomp_ctx->mutex);
 
 	return 0;
 }
 
+static struct crypto_acomp_ctx *acomp_ctx_get_cpu_lock(struct zswap_pool *pool)
+{
+	struct crypto_acomp_ctx *acomp_ctx;
+
+	for (;;) {
+		acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
+		mutex_lock(&acomp_ctx->mutex);
+		if (likely(acomp_ctx->req))
+			return acomp_ctx;
+		/*
+		 * It is possible that we were migrated to a different CPU after
+		 * getting the per-CPU ctx but before the mutex was acquired. If
+		 * the old CPU got offlined, zswap_cpu_comp_dead() could have
+		 * already freed ctx->req (among other things) and set it to
+		 * NULL. Just try again on the new CPU that we ended up on.
+		 */
+		mutex_unlock(&acomp_ctx->mutex);
+	}
+}
+
+static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
+{
+	mutex_unlock(&acomp_ctx->mutex);
+}
+
 static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
@@ -887,10 +928,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	gfp_t gfp;
 	u8 *dst;
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-
-	mutex_lock(&acomp_ctx->mutex);
-
+	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
 	dst = acomp_ctx->buffer;
 	sg_init_table(&input, 1);
 	sg_set_folio(&input, folio, PAGE_SIZE, 0);
@@ -943,7 +981,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	else if (alloc_ret)
 		zswap_reject_alloc_fail++;
 
-	mutex_unlock(&acomp_ctx->mutex);
+	acomp_ctx_put_unlock(acomp_ctx);
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
@@ -954,9 +992,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(&acomp_ctx->mutex);
-
+	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
 	/*
 	 * If zpool_map_handle is atomic, we cannot reliably utilize its mapped buffer
@@ -980,10 +1016,10 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
-	mutex_unlock(&acomp_ctx->mutex);
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
+	acomp_ctx_put_unlock(acomp_ctx);
 }
 
 /*********************************
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index f80bc05d4c5a..516038a44163 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
 {
 	struct ets_sched *q = qdisc_priv(sch);
 
+	if (arg == 0 || arg > q->nbands)
+		return NULL;
 	return &q->classes[arg - 1];
 }
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a9f6138b59b0..8c4de5a253ad 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10916,8 +10916,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38e0, "Yoga Y990 Intel VECO Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38f8, "Yoga Book 9i", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38df, "Y990 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
-	SND_PCI_QUIRK(0x17aa, 0x38f9, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x38fa, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38f9, "Thinkbook 16P Gen5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x38fa, "Thinkbook 16P Gen5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38fd, "ThinkBook plus Gen5 Hybrid", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7092842480ef..0d9d1d250f2b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2397,6 +2397,7 @@ config SND_SOC_WM8993
 
 config SND_SOC_WM8994
 	tristate
+	depends on MFD_WM8994
 
 config SND_SOC_WM8995
 	tristate
diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index d0098b4558b5..8ec4083cd3b8 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2446,6 +2446,7 @@ static const struct dev_pm_ops cs42l43_codec_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(cs42l43_codec_suspend, cs42l43_codec_resume)
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs42l43_codec_suspend_noirq, cs42l43_codec_resume_noirq)
 	RUNTIME_PM_OPS(NULL, cs42l43_codec_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static const struct platform_device_id cs42l43_codec_id_table[] = {
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 61729e5b50a8..f508df01145b 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -39,7 +39,9 @@ struct es8316_priv {
 	struct snd_soc_jack *jack;
 	int irq;
 	unsigned int sysclk;
-	unsigned int allowed_rates[ARRAY_SIZE(supported_mclk_lrck_ratios)];
+	/* ES83xx supports halving the MCLK so it supports twice as many rates
+	 */
+	unsigned int allowed_rates[ARRAY_SIZE(supported_mclk_lrck_ratios) * 2];
 	struct snd_pcm_hw_constraint_list sysclk_constraints;
 	bool jd_inverted;
 };
@@ -386,6 +388,12 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 		if (freq % ratio == 0)
 			es8316->allowed_rates[count++] = freq / ratio;
+
+		/* We also check if the halved MCLK produces a valid rate
+		 * since the codec supports halving the MCLK.
+		 */
+		if ((freq / ratio) % 2 == 0)
+			es8316->allowed_rates[count++] = freq / ratio / 2;
 	}
 
 	if (count) {
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 4b1ea7b2c796..60b4b7b75215 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -127,8 +127,9 @@ config SND_SOC_SAMSUNG_TM2_WM5110
 
 config SND_SOC_SAMSUNG_ARIES_WM8994
 	tristate "SoC I2S Audio support for WM8994 on Aries"
-	depends on SND_SOC_SAMSUNG && MFD_WM8994 && IIO && EXTCON
+	depends on SND_SOC_SAMSUNG && I2C && IIO && EXTCON
 	select SND_SOC_BT_SCO
+	select MFD_WM8994
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_I2S
 	help
@@ -140,8 +141,9 @@ config SND_SOC_SAMSUNG_ARIES_WM8994
 
 config SND_SOC_SAMSUNG_MIDAS_WM1811
 	tristate "SoC I2S Audio support for Midas boards"
-	depends on SND_SOC_SAMSUNG && IIO
+	depends on SND_SOC_SAMSUNG && I2C && IIO
 	select SND_SAMSUNG_I2S
+	select MFD_WM8994
 	select SND_SOC_WM8994
 	help
 	  Say Y if you want to add support for SoC audio on the Midas boards.
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 8ba0aff8be2e..7968d6a2f592 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2239,6 +2239,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */

