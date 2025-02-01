Return-Path: <stable+bounces-111905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC71A24B37
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2B93A6C10
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAB1CD1FB;
	Sat,  1 Feb 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EdhPOXM+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B21CD1F1;
	Sat,  1 Feb 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431956; cv=none; b=OoU++SCA6lIfvgiz3bVoBvUDwRTy5DGMENtxtloZ8fXaGRIKiUzxIrgWmpiytqYPtWqVMz97wOsDRq/e1GIA/A3kcRFVklIXo/cgqC1Z35dVph77kalYm7Nlej6tFwg7u/MgVgt6O88rmG8+fBHoSGr/hxjqwKAELuOs1Q6rxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431956; c=relaxed/simple;
	bh=jWLuY46ENpsVqZouhqJpay7dlryaQuhupgwmFaOjNEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZDLpDHtQv2WZMXem1iyud7AMUycYMMIvzQDdutC4BC4hD07TlWFedKtsPuswY2j8QjA11JrUrWA0qzxLX2Xq/XdgZuBEfIfOB4YD6YH9Hzpnw0NvBpgOIuiKlZSuSXO8dwL6zwKWiZibp3q6RJf1SeKMzNOGYV2+LRsZFFlMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EdhPOXM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2E1C4CED3;
	Sat,  1 Feb 2025 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738431956;
	bh=jWLuY46ENpsVqZouhqJpay7dlryaQuhupgwmFaOjNEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdhPOXM+uFjKjMN3oty4bwWAAVSxwstsb4kStwQSSfQhcbmQgmS1MzJjWqylsyuqC
	 Ndt5MUQHdC49tmXbDmxk5e7s8FTDWx07do+kj7UQZbFx4AbhzUnWhXESYTzDR5SFp4
	 RJi1TntnwKfsUPhih1D/NTf8hro10Ae9BL8x4x+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.178
Date: Sat,  1 Feb 2025 18:45:39 +0100
Message-ID: <2025020139-unplowed-issue-b8b1@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025020139-discourse-uncle-d761@gregkh>
References: <2025020139-discourse-uncle-d761@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 85ce552fefca..7f7c67db948c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 177
+SUBLEVEL = 178
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 85d324fd6a87..6d94ad8bf1eb 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -663,6 +663,17 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 }
 EXPORT_SYMBOL_GPL(regmap_attach_dev);
 
+static int dev_get_regmap_match(struct device *dev, void *res, void *data);
+
+static int regmap_detach_dev(struct device *dev, struct regmap *map)
+{
+	if (!dev)
+		return 0;
+
+	return devres_release(dev, dev_get_regmap_release,
+			      dev_get_regmap_match, (void *)map->name);
+}
+
 static enum regmap_endian regmap_get_reg_endian(const struct regmap_bus *bus,
 					const struct regmap_config *config)
 {
@@ -1531,6 +1542,7 @@ void regmap_exit(struct regmap *map)
 {
 	struct regmap_async *async;
 
+	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 	regmap_debugfs_exit(map);
 	regmap_range_exit(map);
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 76806039691a..b2d59a168697 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -102,8 +102,10 @@ v3d_irq(int irq, void *arg)
 			to_v3d_fence(v3d->bin_job->base.irq_fence);
 
 		trace_v3d_bcl_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->bin_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -112,8 +114,10 @@ v3d_irq(int irq, void *arg)
 			to_v3d_fence(v3d->render_job->base.irq_fence);
 
 		trace_v3d_rcl_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->render_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -122,8 +126,10 @@ v3d_irq(int irq, void *arg)
 			to_v3d_fence(v3d->csd_job->base.irq_fence);
 
 		trace_v3d_csd_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->csd_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
@@ -159,8 +165,10 @@ v3d_hub_irq(int irq, void *arg)
 			to_v3d_fence(v3d->tfu_job->base.irq_fence);
 
 		trace_v3d_tfu_irq(&v3d->drm, fence->seqno);
-		dma_fence_signal(&fence->base);
+
 		v3d->tfu_job = NULL;
+		dma_fence_signal(&fence->base);
+
 		status = IRQ_HANDLED;
 	}
 
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f0b1dac93822..98397c2c6bfa 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -129,6 +129,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x028f, "Microsoft X-Box 360 pad v2", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
+	{ 0x045e, 0x02a9, "Xbox 360 Wireless Receiver (Unofficial)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
@@ -348,6 +349,7 @@ static const struct xpad_device {
 	{ 0x31e3, 0x1200, "Wooting Two", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1210, "Wooting Lekker", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1220, "Wooting Two HE", 0, XTYPE_XBOX360 },
+	{ 0x31e3, 0x1230, "Wooting Two HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1300, "Wooting 60HE (AVR)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1310, "Wooting 60HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x3285, 0x0607, "Nacon GC-100", 0, XTYPE_XBOX360 },
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index df04fbba449a..e8e9947e2f5c 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -90,7 +90,7 @@ static const unsigned short atkbd_set2_keycode[ATKBD_KEYMAP_SIZE] = {
 	  0, 46, 45, 32, 18,  5,  4, 95,  0, 57, 47, 33, 20, 19,  6,183,
 	  0, 49, 48, 35, 34, 21,  7,184,  0,  0, 50, 36, 22,  8,  9,185,
 	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
-	  0, 89, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0, 85,
+	  0, 89, 40,  0, 26, 13,  0,193, 58, 54, 28, 27,  0, 43,  0, 85,
 	  0, 86, 91, 90, 92,  0, 14, 94,  0, 79,124, 75, 71,121,  0,  0,
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
 
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 21d49791f855..83c7417611fa 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -187,7 +187,8 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[0].chip.irq_unmask	= irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_eoi		= irq_gc_ack_set_bit;
 	gc->chip_types[0].chip.irq_set_type	= sunxi_sc_nmi_set_type;
-	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED;
+	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
+						  IRQCHIP_SKIP_SET_WAKE;
 	gc->chip_types[0].regs.ack		= reg_offs->pend;
 	gc->chip_types[0].regs.mask		= reg_offs->enable;
 	gc->chip_types[0].regs.type		= reg_offs->ctrl;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 548540dd0c0f..958bfc38d390 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -130,7 +130,7 @@ static int iwl_hwrate_to_plcp_idx(u32 rate_n_flags)
 				return idx;
 	}
 
-	return -1;
+	return IWL_RATE_INVALID;
 }
 
 static void rs_rate_scale_perform(struct iwl_priv *priv,
@@ -3151,7 +3151,10 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 	for (i = 0; i < LINK_QUAL_MAX_RETRY_NUM; i++) {
 		index = iwl_hwrate_to_plcp_idx(
 			le32_to_cpu(lq_sta->lq.rs_table[i].rate_n_flags));
-		if (is_legacy(tbl->lq_type)) {
+		if (index == IWL_RATE_INVALID) {
+			desc += sprintf(buff + desc, " rate[%d] 0x%X invalid rate\n",
+				i, le32_to_cpu(lq_sta->lq.rs_table[i].rate_n_flags));
+		} else if (is_legacy(tbl->lq_type)) {
 			desc += sprintf(buff+desc, " rate[%d] 0x%X %smbps\n",
 				i, le32_to_cpu(lq_sta->lq.rs_table[i].rate_n_flags),
 				iwl_rate_mcs[index].mbps);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index b97708cb869d..9f4422e155d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1119,10 +1119,13 @@ static void rs_get_lower_rate_down_column(struct iwl_lq_sta *lq_sta,
 
 		rate->bw = RATE_MCS_CHAN_WIDTH_20;
 
-		WARN_ON_ONCE(rate->index < IWL_RATE_MCS_0_INDEX ||
-			     rate->index > IWL_RATE_MCS_9_INDEX);
+		if (WARN_ON_ONCE(rate->index < IWL_RATE_MCS_0_INDEX))
+			rate->index = rs_ht_to_legacy[IWL_RATE_MCS_0_INDEX];
+		else if (WARN_ON_ONCE(rate->index > IWL_RATE_MCS_9_INDEX))
+			rate->index = rs_ht_to_legacy[IWL_RATE_MCS_9_INDEX];
+		else
+			rate->index = rs_ht_to_legacy[rate->index];
 
-		rate->index = rs_ht_to_legacy[rate->index];
 		rate->ldpc = false;
 	} else {
 		/* Downgrade to SISO with same MCS if in MIMO  */
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2b8bef0d7ee5..c065963b9a42 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1123,6 +1123,9 @@ static int cros_typec_probe(struct platform_device *pdev)
 	}
 
 	ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
+	if (!ec_dev)
+		return -EPROBE_DEFER;
+
 	typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
 	typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
 							EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index e044b65ee0d0..f839e8e497be 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -4124,7 +4124,7 @@ iscsi_if_rx(struct sk_buff *skb)
 		}
 		do {
 			/*
-			 * special case for GET_STATS:
+			 * special case for GET_STATS, GET_CHAP and GET_HOST_STATS:
 			 * on success - sending reply and stats from
 			 * inside of if_recv_msg(),
 			 * on error - fall through.
@@ -4133,6 +4133,8 @@ iscsi_if_rx(struct sk_buff *skb)
 				break;
 			if (ev->type == ISCSI_UEVENT_GET_CHAP && !err)
 				break;
+			if (ev->type == ISCSI_UEVENT_GET_HOST_STATS && !err)
+				break;
 			err = iscsi_if_send_reply(portid, nlh->nlmsg_type,
 						  ev, sizeof(*ev));
 			if (err == -EAGAIN && --retries < 0) {
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ff1735e3127d..6a628a6b5a6d 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -189,6 +189,12 @@ struct vmscsi_win8_extension {
 	u32 queue_sort_ey;
 } __packed;
 
+#define storvsc_log_ratelimited(dev, level, fmt, ...)				\
+do {										\
+	if (do_logging(level))							\
+		dev_warn_ratelimited(&(dev)->device, fmt, ##__VA_ARGS__);	\
+} while (0)
+
 struct vmscsi_request {
 	u16 length;
 	u8 srb_status;
@@ -1231,7 +1237,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 		int loglevel = (stor_pkt->vm_srb.cdb[0] == TEST_UNIT_READY) ?
 			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
 
-		storvsc_log(device, loglevel,
+		storvsc_log_ratelimited(device, loglevel,
 			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
 			scsi_cmd_to_rq(request->cmd)->tag,
 			stor_pkt->vm_srb.cdb[0],
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 8481b8807494..37ba396d5473 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1393,10 +1393,6 @@ void gserial_disconnect(struct gserial *gser)
 	/* REVISIT as above: how best to track this? */
 	port->port_line_coding = gser->port_line_coding;
 
-	/* disable endpoints, aborting down any active I/O */
-	usb_ep_disable(gser->out);
-	usb_ep_disable(gser->in);
-
 	port->port_usb = NULL;
 	gser->ioport = NULL;
 	if (port->port.count > 0) {
@@ -1408,6 +1404,10 @@ void gserial_disconnect(struct gserial *gser)
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
index 971907f083a3..0207ab7ce099 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -525,7 +525,7 @@ static void qt2_process_read_urb(struct urb *urb)
 
 				newport = *(ch + 3);
 
-				if (newport > serial->num_ports) {
+				if (newport >= serial->num_ports) {
 					dev_err(&port->dev,
 						"%s - port change to invalid port: %i\n",
 						__func__, newport);
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 701bd99a8719..5c5f944ca31e 100644
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
@@ -466,6 +471,11 @@ static ssize_t vfio_platform_write_mmio(struct vfio_platform_region *reg,
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
index e93185d804e0..744eb526254e 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -257,6 +257,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask,
 		error = filemap_fdatawait(inode->i_mapping);
 		if (error)
 			goto out;
+		truncate_inode_pages(inode->i_mapping, 0);
 		if (new_flags & GFS2_DIF_JDATA)
 			gfs2_ordered_del_inode(ip);
 	}
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index af7e13806462..2d5d234a4533 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1192,8 +1192,16 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	int err = 0;
 
 	/* If we are last writer on the inode, drop the block reservation. */
-	if (sbi->options->prealloc && ((file->f_mode & FMODE_WRITE) &&
-				      atomic_read(&inode->i_writecount) == 1)) {
+	if (sbi->options->prealloc &&
+	    ((file->f_mode & FMODE_WRITE) &&
+	     atomic_read(&inode->i_writecount) == 1)
+	   /*
+	    * The only file when inode->i_fop = &ntfs_file_operations and
+	    * init_rwsem(&ni->file.run_lock) is not called explicitly is MFT.
+	    *
+	    * Add additional check here.
+	    */
+	    && inode->i_ino != MFT_REC_MFT) {
 		ni_lock(ni);
 		down_write(&ni->file.run_lock);
 
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 0c564e5d40ff..15dee3991f11 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -68,10 +68,10 @@ struct seccomp_data;
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 static inline int secure_computing(void) { return 0; }
-static inline int __secure_computing(const struct seccomp_data *sd) { return 0; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif
+static inline int __secure_computing(const struct seccomp_data *sd) { return 0; }
 
 static inline long prctl_get_seccomp(void)
 {
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 355835639ae5..7d2bd562da4b 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -487,6 +487,15 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 	return skb;
 }
 
+static inline int bt_copy_from_sockptr(void *dst, size_t dst_size,
+				       sockptr_t src, size_t src_size)
+{
+	if (dst_size > src_size)
+		return -EINVAL;
+
+	return copy_from_sockptr(dst, src, dst_size);
+}
+
 int bt_to_errno(u16 code);
 
 void hci_sock_set_flag(struct sock *sk, int nr);
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index e165ef233875..d1f2c936a8a8 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -636,7 +636,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
 			err = -EFAULT;
 			break;
 		}
@@ -671,7 +671,6 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
 	int err = 0;
-	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -693,11 +692,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_sockptr(&sec, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (sec.level > BT_SECURITY_HIGH) {
 			err = -EINVAL;
@@ -713,10 +710,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 431e09cac178..f5192116922d 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -829,7 +829,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int err = 0;
 	struct bt_voice voice;
 	u32 opt;
 
@@ -845,10 +845,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
@@ -865,11 +864,10 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		voice.setting = sco_pi(sk)->setting;
 
-		len = min_t(unsigned int, sizeof(voice), optlen);
-		if (copy_from_sockptr(&voice, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&voice, sizeof(voice), optval,
+					   optlen);
+		if (err)
 			break;
-		}
 
 		/* Explicitly check for these values */
 		if (voice.setting != BT_VOICE_TRANSPARENT &&
@@ -882,10 +880,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			sco_pi(sk)->cmsg_mask |= SCO_CMSG_PKT_STATUS;
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 2906b4329c23..9f9b7768cd19 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -218,7 +218,7 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 	struct ip_tunnel *t = NULL;
 	struct hlist_head *head = ip_bucket(itn, parms);
 
-	hlist_for_each_entry_rcu(t, head, hash_node) {
+	hlist_for_each_entry_rcu(t, head, hash_node, lockdep_rtnl_is_held()) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
 		    link == t->parms.link &&
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bcbb1f92ce24..f337dd3323a0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -462,13 +462,13 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 		mptcp_subflow_send_ack(mptcp_subflow_tcp_sock(subflow));
 }
 
-static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
+static void mptcp_subflow_cleanup_rbuf(struct sock *ssk, int copied)
 {
 	bool slow;
 
 	slow = lock_sock_fast(ssk);
 	if (tcp_can_send_ack(ssk))
-		tcp_cleanup_rbuf(ssk, 1);
+		tcp_cleanup_rbuf(ssk, copied);
 	unlock_sock_fast(ssk, slow);
 }
 
@@ -485,7 +485,7 @@ static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
 			      (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
 }
 
-static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
+static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 {
 	int old_space = READ_ONCE(msk->old_wspace);
 	struct mptcp_subflow_context *subflow;
@@ -493,14 +493,14 @@ static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
 	int space =  __mptcp_space(sk);
 	bool cleanup, rx_empty;
 
-	cleanup = (space > 0) && (space >= (old_space << 1));
-	rx_empty = !__mptcp_rmem(sk);
+	cleanup = (space > 0) && (space >= (old_space << 1)) && copied;
+	rx_empty = !__mptcp_rmem(sk) && copied;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (cleanup || mptcp_subflow_could_cleanup(ssk, rx_empty))
-			mptcp_subflow_cleanup_rbuf(ssk);
+			mptcp_subflow_cleanup_rbuf(ssk, copied);
 	}
 }
 
@@ -2098,9 +2098,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		/* be sure to advertise window change */
-		mptcp_cleanup_rbuf(msk);
-
 		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
 			continue;
 
@@ -2152,9 +2149,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
+		mptcp_cleanup_rbuf(msk, copied);
 		sk_wait_data(sk, &timeo, NULL);
 	}
 
+	mptcp_cleanup_rbuf(msk, copied);
+
 out_err:
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 175e07b3d25c..d686ea7e8db4 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
 {
 	struct ets_sched *q = qdisc_priv(sch);
 
+	if (arg == 0 || arg > q->nbands)
+		return NULL;
 	return &q->classes[arg - 1];
 }
 
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1750cc888bbe..5aeec2ef14b4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1776,6 +1776,7 @@ config SND_SOC_WM8993
 
 config SND_SOC_WM8994
 	tristate
+	depends on MFD_WM8994
 
 config SND_SOC_WM8995
 	tristate
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index a2221ebb1b6a..c04c38d58804 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -214,8 +214,9 @@ config SND_SOC_SAMSUNG_TM2_WM5110
 
 config SND_SOC_SAMSUNG_ARIES_WM8994
 	tristate "SoC I2S Audio support for WM8994 on Aries"
-	depends on SND_SOC_SAMSUNG && MFD_WM8994 && IIO && EXTCON
+	depends on SND_SOC_SAMSUNG && I2C && IIO && EXTCON
 	select SND_SOC_BT_SCO
+	select MFD_WM8994
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_I2S
 	help
@@ -227,8 +228,9 @@ config SND_SOC_SAMSUNG_ARIES_WM8994
 
 config SND_SOC_SAMSUNG_MIDAS_WM1811
 	tristate "SoC I2S Audio support for Midas boards"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && I2C
 	select SND_SAMSUNG_I2S
+	select MFD_WM8994
 	select SND_SOC_WM8994
 	help
 	  Say Y if you want to add support for SoC audio on the Midas boards.
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 8661399e60d5..1c13d5275fa3 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1836,6 +1836,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */

