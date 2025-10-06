Return-Path: <stable+bounces-183415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC6BBD88A
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 11:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 231B74EB162
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD1216E24;
	Mon,  6 Oct 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NWe/0aLN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8F02F2D;
	Mon,  6 Oct 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744582; cv=none; b=TC+twiK/ok/5+kUEQUZkjxYRXKUIVuxa70jwjdDfzD82rWC+GykBgA85/tceR6NAlu5OsklpylXlvm5u5KumMCq2sRWMSaGFSpfUIRVw31YI8BF9xQuHsrd9ss7L7ktdSDGu70KVi4Aj5YBotqlHXrU7su9qjyb2BIGLzsAvASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744582; c=relaxed/simple;
	bh=h5c0yPZN4Rn9kA9IrFzCL3YfekPH4ceRHAPR5PlwaHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcbAri1W3OmeB84+U0mDoswYdoFUBvA5v04CN4RgxdF+8bmebhvaUvrg9I1ExuQdMtt9Itlg5lvyeAIWLP1YdkdUp3BwBtFkZCd+kgEuIuw1+QMorcyQSZMA5WACTPZSjv4S72zpKessqMftiJ5Js+oHJQ8DuwDXLqu0kfNhhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NWe/0aLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6B2C4CEF5;
	Mon,  6 Oct 2025 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759744582;
	bh=h5c0yPZN4Rn9kA9IrFzCL3YfekPH4ceRHAPR5PlwaHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWe/0aLNFXbRSeO6udQZaRIXqlRO3XrlnHNbumS1NME16faViiDtnRTYgBk7IPDIk
	 Wq0pi8YsFFNC+InKhfLB3GJJKoj2+cRVd2hNBOLg0GrPuzAyZVGIebiiDZqOrYfFx4
	 ba6w2OijAWLaXYSvit2fJ4TZBqaSgoeUTecCKrZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.110
Date: Mon,  6 Oct 2025 11:56:12 +0200
Message-ID: <2025100611-unissued-until-54f4@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100611-exes-monoxide-33ef@gregkh>
References: <2025100611-exes-monoxide-33ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index afeacf5efc95..196343089737 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 109
+SUBLEVEL = 110
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/drivers/media/pci/b2c2/flexcop-pci.c b/drivers/media/pci/b2c2/flexcop-pci.c
index 486c8ec0fa60..ab53c5b02c48 100644
--- a/drivers/media/pci/b2c2/flexcop-pci.c
+++ b/drivers/media/pci/b2c2/flexcop-pci.c
@@ -411,7 +411,7 @@ static void flexcop_pci_remove(struct pci_dev *pdev)
 	struct flexcop_pci *fc_pci = pci_get_drvdata(pdev);
 
 	if (irq_chk_intv > 0)
-		cancel_delayed_work(&fc_pci->irq_check_work);
+		cancel_delayed_work_sync(&fc_pci->irq_check_work);
 
 	flexcop_pci_dma_exit(fc_pci);
 	flexcop_device_exit(fc_pci->fc_dev);
diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index e5590a708f1c..f4deca8894e0 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -536,7 +536,9 @@ static int display_open(struct inode *inode, struct file *file)
 
 	mutex_lock(&ictx->lock);
 
-	if (!ictx->display_supported) {
+	if (ictx->disconnected) {
+		retval = -ENODEV;
+	} else if (!ictx->display_supported) {
 		pr_err("display not supported by device\n");
 		retval = -ENODEV;
 	} else if (ictx->display_isopen) {
@@ -598,6 +600,9 @@ static int send_packet(struct imon_context *ictx)
 	int retval = 0;
 	struct usb_ctrlrequest *control_req = NULL;
 
+	if (ictx->disconnected)
+		return -ENODEV;
+
 	/* Check if we need to use control or interrupt urb */
 	if (!ictx->tx_control) {
 		pipe = usb_sndintpipe(ictx->usbdev_intf0,
@@ -949,12 +954,14 @@ static ssize_t vfd_write(struct file *file, const char __user *buf,
 	static const unsigned char vfd_packet6[] = {
 		0x01, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF };
 
-	if (ictx->disconnected)
-		return -ENODEV;
-
 	if (mutex_lock_interruptible(&ictx->lock))
 		return -ERESTARTSYS;
 
+	if (ictx->disconnected) {
+		retval = -ENODEV;
+		goto exit;
+	}
+
 	if (!ictx->dev_present_intf0) {
 		pr_err_ratelimited("no iMON device present\n");
 		retval = -ENODEV;
@@ -1029,11 +1036,13 @@ static ssize_t lcd_write(struct file *file, const char __user *buf,
 	int retval = 0;
 	struct imon_context *ictx = file->private_data;
 
-	if (ictx->disconnected)
-		return -ENODEV;
-
 	mutex_lock(&ictx->lock);
 
+	if (ictx->disconnected) {
+		retval = -ENODEV;
+		goto exit;
+	}
+
 	if (!ictx->display_supported) {
 		pr_err_ratelimited("no iMON display present\n");
 		retval = -ENODEV;
@@ -2499,7 +2508,11 @@ static void imon_disconnect(struct usb_interface *interface)
 	int ifnum;
 
 	ictx = usb_get_intfdata(interface);
+
+	mutex_lock(&ictx->lock);
 	ictx->disconnected = true;
+	mutex_unlock(&ictx->lock);
+
 	dev = ictx->dev;
 	ifnum = interface->cur_altsetting->desc.bInterfaceNumber;
 
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 09753993068a..c7cee6b18526 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -135,6 +135,9 @@ struct uvc_entity *uvc_entity_by_id(struct uvc_device *dev, int id)
 {
 	struct uvc_entity *entity;
 
+	if (id == UVC_INVALID_ENTITY_ID)
+		return NULL;
+
 	list_for_each_entry(entity, &dev->entities, list) {
 		if (entity->id == id)
 			return entity;
@@ -778,14 +781,27 @@ static const u8 uvc_media_transport_input_guid[16] =
 	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
 static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
 
-static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
-		unsigned int num_pads, unsigned int extra_size)
+static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
+					       u16 id, unsigned int num_pads,
+					       unsigned int extra_size)
 {
 	struct uvc_entity *entity;
 	unsigned int num_inputs;
 	unsigned int size;
 	unsigned int i;
 
+	/* Per UVC 1.1+ spec 3.7.2, the ID should be non-zero. */
+	if (id == 0) {
+		dev_err(&dev->intf->dev, "Found Unit with invalid ID 0\n");
+		id = UVC_INVALID_ENTITY_ID;
+	}
+
+	/* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
+	if (uvc_entity_by_id(dev, id)) {
+		dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n", id);
+		id = UVC_INVALID_ENTITY_ID;
+	}
+
 	extra_size = roundup(extra_size, sizeof(*entity->pads));
 	if (num_pads)
 		num_inputs = type & UVC_TERM_OUTPUT ? num_pads : num_pads - 1;
@@ -795,7 +811,7 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
 	     + num_inputs;
 	entity = kzalloc(size, GFP_KERNEL);
 	if (entity == NULL)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	entity->id = id;
 	entity->type = type;
@@ -907,10 +923,10 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
 			break;
 		}
 
-		unit = uvc_alloc_entity(UVC_VC_EXTENSION_UNIT, buffer[3],
-					p + 1, 2*n);
-		if (unit == NULL)
-			return -ENOMEM;
+		unit = uvc_alloc_new_entity(dev, UVC_VC_EXTENSION_UNIT,
+					    buffer[3], p + 1, 2 * n);
+		if (IS_ERR(unit))
+			return PTR_ERR(unit);
 
 		memcpy(unit->guid, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
@@ -1019,10 +1035,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		term = uvc_alloc_entity(type | UVC_TERM_INPUT, buffer[3],
-					1, n + p);
-		if (term == NULL)
-			return -ENOMEM;
+		term = uvc_alloc_new_entity(dev, type | UVC_TERM_INPUT,
+					    buffer[3], 1, n + p);
+		if (IS_ERR(term))
+			return PTR_ERR(term);
 
 		if (UVC_ENTITY_TYPE(term) == UVC_ITT_CAMERA) {
 			term->camera.bControlSize = n;
@@ -1078,10 +1094,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return 0;
 		}
 
-		term = uvc_alloc_entity(type | UVC_TERM_OUTPUT, buffer[3],
-					1, 0);
-		if (term == NULL)
-			return -ENOMEM;
+		term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
+					    buffer[3], 1, 0);
+		if (IS_ERR(term))
+			return PTR_ERR(term);
 
 		memcpy(term->baSourceID, &buffer[7], 1);
 
@@ -1100,9 +1116,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_entity(buffer[2], buffer[3], p + 1, 0);
-		if (unit == NULL)
-			return -ENOMEM;
+		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3],
+					    p + 1, 0);
+		if (IS_ERR(unit))
+			return PTR_ERR(unit);
 
 		memcpy(unit->baSourceID, &buffer[5], p);
 
@@ -1122,9 +1139,9 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_entity(buffer[2], buffer[3], 2, n);
-		if (unit == NULL)
-			return -ENOMEM;
+		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3], 2, n);
+		if (IS_ERR(unit))
+			return PTR_ERR(unit);
 
 		memcpy(unit->baSourceID, &buffer[4], 1);
 		unit->processing.wMaxMultiplier =
@@ -1151,9 +1168,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return -EINVAL;
 		}
 
-		unit = uvc_alloc_entity(buffer[2], buffer[3], p + 1, n);
-		if (unit == NULL)
-			return -ENOMEM;
+		unit = uvc_alloc_new_entity(dev, buffer[2], buffer[3],
+					    p + 1, n);
+		if (IS_ERR(unit))
+			return PTR_ERR(unit);
 
 		memcpy(unit->guid, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
@@ -1293,9 +1311,10 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 		return dev_err_probe(&dev->intf->dev, irq,
 				     "No IRQ for privacy GPIO\n");
 
-	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
-	if (!unit)
-		return -ENOMEM;
+	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
+				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
+	if (IS_ERR(unit))
+		return PTR_ERR(unit);
 
 	unit->gpio.gpio_privacy = gpio_privacy;
 	unit->gpio.irq = irq;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index e99bfaa62266..cbb5ce963cd0 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -41,6 +41,8 @@
 #define UVC_EXT_GPIO_UNIT		0x7ffe
 #define UVC_EXT_GPIO_UNIT_ID		0x100
 
+#define UVC_INVALID_ENTITY_ID          0xffff
+
 /* ------------------------------------------------------------------------
  * Driver specific constants.
  */
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 9a88774836c9..eddcfd09c05b 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -2738,7 +2738,7 @@ static ssize_t target_lu_gp_members_show(struct config_item *item, char *page)
 			config_item_name(&dev->dev_group.cg_item));
 		cur_len++; /* Extra byte for NULL terminator */
 
-		if ((cur_len + len) > PAGE_SIZE) {
+		if ((cur_len + len) > PAGE_SIZE || cur_len > LU_GROUP_NAME_BUF) {
 			pr_warn("Ran out of lu_gp_show_attr"
 				"_members buffer\n");
 			break;
diff --git a/include/crypto/sha256_base.h b/include/crypto/sha256_base.h
index ab904d82236f..0f5f3a6f79f0 100644
--- a/include/crypto/sha256_base.h
+++ b/include/crypto/sha256_base.h
@@ -44,7 +44,7 @@ static inline int lib_sha256_base_do_update(struct sha256_state *sctx,
 	sctx->count += len;
 
 	if (unlikely((partial + len) >= SHA256_BLOCK_SIZE)) {
-		int blocks;
+		unsigned int blocks;
 
 		if (partial) {
 			int p = SHA256_BLOCK_SIZE - partial;
diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 90e83d62adb5..de1e4c927cbc 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -196,10 +196,17 @@ inline bool is_a_helper<const gassign *>::test(const_gimple gs)
 }
 #endif
 
+#if BUILDING_GCC_VERSION < 16000
 #define TODO_verify_ssa TODO_verify_il
 #define TODO_verify_flow TODO_verify_il
 #define TODO_verify_stmts TODO_verify_il
 #define TODO_verify_rtl_sharing TODO_verify_il
+#else
+#define TODO_verify_ssa 0
+#define TODO_verify_flow 0
+#define TODO_verify_stmts 0
+#define TODO_verify_rtl_sharing 0
+#endif
 
 #define INSN_DELETED_P(insn) (insn)->deleted()
 
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 70572c83e101..d4c3bc85fb35 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -586,8 +586,8 @@ static int audioreach_widget_load_module_common(struct snd_soc_component *compon
 		return PTR_ERR(cont);
 
 	mod = audioreach_parse_common_tokens(apm, cont, &tplg_w->priv, w);
-	if (IS_ERR(mod))
-		return PTR_ERR(mod);
+	if (IS_ERR_OR_NULL(mod))
+		return mod ? PTR_ERR(mod) : -ENODEV;
 
 	dobj = &w->dobj;
 	dobj->private = mod;

