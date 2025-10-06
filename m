Return-Path: <stable+bounces-183419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F35BBD8A5
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 11:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEE2C4EC590
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 09:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D322192FA;
	Mon,  6 Oct 2025 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DzsYq9x2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A421885A;
	Mon,  6 Oct 2025 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744596; cv=none; b=bDm9NqFXHLrsx6oI//Dd2WDimxPJN/wqZDorX2EGUfDBoCGrR5pZ6IWel92lvrLw1AT4IY1Ml6FFLuE1fS1BTUwdQBn3lYiAmJIZhLq+fWQfSUor1CeDVO9vjXInPueQ/M2Is2C253JwKn7InjBbj71D7yX5hBEGa5wEN50waiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744596; c=relaxed/simple;
	bh=ptwRqn3z9UmLljTkkU9pxoW0NvkW5w6JuHbpnTBpFWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oenah98n2fEAJHKDHlrzC1t/CfLwiC3FeF29D89TtfSo+SzgQzTIGDLxHhn6dj2bgoCyLek/F1iOHmEQKqF4j40qgWSwkKbBv339DbO9uJ407rwJun5vw1Hqd9rTCFRa5LYFzs912LK+dvmKvSmzISMrrKHw9mZKckd8XxcPOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DzsYq9x2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6410C4CEF5;
	Mon,  6 Oct 2025 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759744596;
	bh=ptwRqn3z9UmLljTkkU9pxoW0NvkW5w6JuHbpnTBpFWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzsYq9x2HkHhyNW5sbtWwHlYkO3LFOOwTM/UTVVTp4y6RtGGXAPzE4+Frd7Lx1Xdm
	 h5TcckUDK8TXTyWdune+ep4DHobugMlJ8PNvUZAeWyXD+cyIcaTfEUCS7o6R/MLEEY
	 13dmYHiM7orgYPcWNls7qrDUNfCwq6Gy2ikkmQzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.16.11
Date: Mon,  6 Oct 2025 11:56:26 +0200
Message-ID: <2025100626-oxymoron-mocha-c0d5@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100626-semantic-curtsy-72b0@gregkh>
References: <2025100626-semantic-curtsy-72b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 19856af4819a..0d1e19ef28b9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 16
-SUBLEVEL = 10
+SUBLEVEL = 11
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d880c50629d6..5cffa5668d0c 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -622,6 +622,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 			return -ENOMEM;
 
 		blk_mq_free_map_and_rqs(set, *tagsptr, hctx->queue_num);
+		hctx->queue->elevator->et->tags[hctx->queue_num] = new;
 		*tagsptr = new;
 	} else {
 		/*
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 1c7546d2ada4..87130ccd2fbe 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2225,10 +2225,10 @@ static int tc358743_probe(struct i2c_client *client)
 err_work_queues:
 	cec_unregister_adapter(state->cec_adap);
 	if (!state->i2c_client->irq) {
-		timer_delete(&state->timer);
+		timer_delete_sync(&state->timer);
 		flush_work(&state->work_i2c_poll);
 	}
-	cancel_delayed_work(&state->delayed_work_enable_hotplug);
+	cancel_delayed_work_sync(&state->delayed_work_enable_hotplug);
 	mutex_destroy(&state->confctl_mutex);
 err_hdl:
 	media_entity_cleanup(&sd->entity);
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
diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index 018334512bae..5e6c34c6b080 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -410,6 +410,16 @@ static int iris_destroy_internal_buffers(struct iris_inst *inst, u32 plane, bool
 		}
 	}
 
+	if (force) {
+		buffers = &inst->buffers[BUF_PERSIST];
+
+		list_for_each_entry_safe(buf, next, &buffers->list, list) {
+			ret = iris_destroy_internal_buffer(inst, buf);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/st/stm32/stm32-csi.c b/drivers/media/platform/st/stm32/stm32-csi.c
index b69048144cc1..fd2b6dfbd44c 100644
--- a/drivers/media/platform/st/stm32/stm32-csi.c
+++ b/drivers/media/platform/st/stm32/stm32-csi.c
@@ -443,8 +443,7 @@ static void stm32_csi_phy_reg_write(struct stm32_csi_dev *csidev,
 static int stm32_csi_start(struct stm32_csi_dev *csidev,
 			   struct v4l2_subdev_state *state)
 {
-	struct media_pad *src_pad =
-		&csidev->s_subdev->entity.pads[csidev->s_subdev_pad_nb];
+	struct media_pad *src_pad;
 	const struct stm32_csi_mbps_phy_reg *phy_regs = NULL;
 	struct v4l2_mbus_framefmt *sink_fmt;
 	const struct stm32_csi_fmts *fmt;
@@ -466,6 +465,7 @@ static int stm32_csi_start(struct stm32_csi_dev *csidev,
 	if (!csidev->s_subdev)
 		return -EIO;
 
+	src_pad = &csidev->s_subdev->entity.pads[csidev->s_subdev_pad_nb];
 	link_freq = v4l2_get_link_freq(src_pad,
 				       fmt->bpp, 2 * csidev->num_lanes);
 	if (link_freq < 0)
diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index f5221b018808..cf3e6e43c0c7 100644
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
 
diff --git a/drivers/media/tuners/xc5000.c b/drivers/media/tuners/xc5000.c
index 30aa4ee958bd..ec9a3cd4784e 100644
--- a/drivers/media/tuners/xc5000.c
+++ b/drivers/media/tuners/xc5000.c
@@ -1304,7 +1304,7 @@ static void xc5000_release(struct dvb_frontend *fe)
 	mutex_lock(&xc5000_list_mutex);
 
 	if (priv) {
-		cancel_delayed_work(&priv->timer_sleep);
+		cancel_delayed_work_sync(&priv->timer_sleep);
 		hybrid_tuner_release_state(priv);
 	}
 
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 5c7bf142fb21..56a77a05efc1 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -137,6 +137,9 @@ struct uvc_entity *uvc_entity_by_id(struct uvc_device *dev, int id)
 {
 	struct uvc_entity *entity;
 
+	if (id == UVC_INVALID_ENTITY_ID)
+		return NULL;
+
 	list_for_each_entry(entity, &dev->entities, list) {
 		if (entity->id == id)
 			return entity;
@@ -795,14 +798,27 @@ static const u8 uvc_media_transport_input_guid[16] =
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
@@ -812,7 +828,7 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
 	     + num_inputs;
 	entity = kzalloc(size, GFP_KERNEL);
 	if (entity == NULL)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	entity->id = id;
 	entity->type = type;
@@ -924,10 +940,10 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
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
@@ -1036,10 +1052,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
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
@@ -1095,10 +1111,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
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
 
@@ -1117,9 +1133,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
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
 
@@ -1139,9 +1156,9 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
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
@@ -1168,9 +1185,10 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
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
@@ -1315,9 +1333,10 @@ static int uvc_gpio_parse(struct uvc_device *dev)
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
index 11d6e3c2ebdf..63b87c5ff919 100644
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
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 2782f4723e41..6a2600054a1f 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2555,7 +2555,7 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
 					   GFP_KERNEL);
 	if (!m3_mem->vaddr) {
 		ath11k_err(ab, "failed to allocate memory for M3 with size %zu\n",
-			   fw->size);
+			   m3_len);
 		ret = -ENOMEM;
 		goto out;
 	}
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 0904ecae253a..b19acd662726 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -2774,7 +2774,7 @@ static ssize_t target_lu_gp_members_show(struct config_item *item, char *page)
 			config_item_name(&dev->dev_group.cg_item));
 		cur_len++; /* Extra byte for NULL terminator */
 
-		if ((cur_len + len) > PAGE_SIZE) {
+		if ((cur_len + len) > PAGE_SIZE || cur_len > LU_GROUP_NAME_BUF) {
 			pr_warn("Ran out of lu_gp_show_attr"
 				"_members buffer\n");
 			break;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4f47ec9118f8..671d17b7b0e8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2244,6 +2244,8 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 	VMA_ITERATOR(vmi, mm, 0);
 
 	mmap_read_lock(mm);
+	if (check_stable_address_space(mm))
+		goto unlock;
 	for_each_vma(vmi, vma) {
 		if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
 			ret = unuse_vma(vma, type);
@@ -2253,6 +2255,7 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 
 		cond_resched();
 	}
+unlock:
 	mmap_read_unlock(mm);
 	return ret;
 }
diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 6cb6d1051815..8f1b3500f8e2 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -173,10 +173,17 @@ static inline opt_pass *get_pass_for_id(int id)
 	return g->get_passes()->get_pass_for_id(id);
 }
 
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
index 83319a928f29..01bb1bdee5ce 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -587,8 +587,8 @@ static int audioreach_widget_load_module_common(struct snd_soc_component *compon
 		return PTR_ERR(cont);
 
 	mod = audioreach_parse_common_tokens(apm, cont, &tplg_w->priv, w);
-	if (IS_ERR(mod))
-		return PTR_ERR(mod);
+	if (IS_ERR_OR_NULL(mod))
+		return mod ? PTR_ERR(mod) : -ENODEV;
 
 	dobj = &w->dobj;
 	dobj->private = mod;
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 866e613fee4f..bcfdb75e5757 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1522,15 +1522,14 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 {
 	int i;
 
+	if (!umidi->disconnected)
+		snd_usbmidi_disconnect(&umidi->list);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
-		if (ep->out)
-			snd_usbmidi_out_endpoint_delete(ep->out);
-		if (ep->in)
-			snd_usbmidi_in_endpoint_delete(ep->in);
+		kfree(ep->out);
 	}
 	mutex_destroy(&umidi->mutex);
-	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 

