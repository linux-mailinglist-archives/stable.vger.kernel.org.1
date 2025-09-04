Return-Path: <stable+bounces-177749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98265B4400C
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D2B7ADE09
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCA030EF6A;
	Thu,  4 Sep 2025 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wAflwX6o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E230E85F;
	Thu,  4 Sep 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998642; cv=none; b=KbdxGtGZssrcdyN+hbvDg+Ae5F/t0s+WRuebe6jJAnJVl65tzkqbyPVkwrjSjWUGQNatQAudF/bl/nPOoYKb+JZuKUXq51DtGgM5nR9wWgRJ9xy9bKiCoidZ13m3SCt05k9D1G7ZXBGfA+I8NvANaZc9IwSZ7tBZU0RvT3cYv4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998642; c=relaxed/simple;
	bh=0ybmBl7kyqBJjO/qsgZGy7HwOKvUOaAtMkEvsWBr6fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQ/O2zhqkJkdtsnR7WHf9qWdbzq3BoB7ESUFbJe6BK35+DtZYPXeLI6NmqqlUa/iifvJZyuCaK56brjQCb+gbx/ALZ+X12kLEmWhSS537rpgzmi7zlxol/+QLXAtunvC2YEOteC7Ex8pzG9UbMi4tiDGdca5gd3bk29cvO1GWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wAflwX6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA38C4CEF0;
	Thu,  4 Sep 2025 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998641;
	bh=0ybmBl7kyqBJjO/qsgZGy7HwOKvUOaAtMkEvsWBr6fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wAflwX6ohtxMZ4xe88QHTpiaNL1bVf+RNPg0xaIhTTs5RN5kaB+8Z4fpm5j46bmjZ
	 KvFbqpQSex/sWm7m1Uap3o3hfZvP4oXhbewPWwvtgJZG4E7FL8d023utbyvkB5JtjX
	 dl7IyTSRQlnhrMNZtARbwuZrEOpOIvhNpnlBv8r4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.191
Date: Thu,  4 Sep 2025 17:10:26 +0200
Message-ID: <2025090426-quiet-hazelnut-aa5c@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090426-lustiness-unsent-2eb1@gregkh>
References: <2025090426-lustiness-unsent-2eb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 9f94303612e4..ea4e8422901d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 190
+SUBLEVEL = 191
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 6568823cf306..5d9d38834507 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -632,19 +632,19 @@ static void __init kvm_check_ins(u32 *inst, u32 features)
 #endif
 	}
 
-	switch (inst_no_rt & ~KVM_MASK_RB) {
 #ifdef CONFIG_PPC_BOOK3S_32
+	switch (inst_no_rt & ~KVM_MASK_RB) {
 	case KVM_INST_MTSRIN:
 		if (features & KVM_MAGIC_FEAT_SR) {
 			u32 inst_rb = _inst & KVM_MASK_RB;
 			kvm_patch_ins_mtsrin(inst, inst_rt, inst_rb);
 		}
 		break;
-#endif
 	}
+#endif
 
-	switch (_inst) {
 #ifdef CONFIG_BOOKE
+	switch (_inst) {
 	case KVM_INST_WRTEEI_0:
 		kvm_patch_ins_wrteei_0(inst);
 		break;
@@ -652,8 +652,8 @@ static void __init kvm_check_ins(u32 *inst, u32 features)
 	case KVM_INST_WRTEEI_1:
 		kvm_patch_ins_wrtee(inst, 0, 1);
 		break;
-#endif
 	}
+#endif
 }
 
 extern u32 kvm_template_start[];
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 8d0eaad7a759..7aea5d691273 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -613,6 +613,8 @@ static int __pv_send_ipi(unsigned long *ipi_bitmap, struct kvm_apic_map *map,
 	if (min > map->max_apic_id)
 		return 0;
 
+	min = array_index_nospec(min, map->max_apic_id + 1);
+
 	for_each_set_bit(i, ipi_bitmap,
 		min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))) {
 		if (map->phys_map[min + i]) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b5bf68c2d2fc..d788d1220a21 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8923,8 +8923,11 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
 	rcu_read_lock();
 	map = rcu_dereference(vcpu->kvm->arch.apic_map);
 
-	if (likely(map) && dest_id <= map->max_apic_id && map->phys_map[dest_id])
-		target = map->phys_map[dest_id]->vcpu;
+	if (likely(map) && dest_id <= map->max_apic_id) {
+		dest_id = array_index_nospec(dest_id, map->max_apic_id + 1);
+		if (map->phys_map[dest_id])
+			target = map->phys_map[dest_id]->vcpu;
+	}
 
 	rcu_read_unlock();
 
diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index ff558908897f..9c83fb29b2f1 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -279,6 +279,19 @@ static struct atm_vcc *find_vcc(struct atm_dev *dev, short vpi, int vci)
         return NULL;
 }
 
+static int atmtcp_c_pre_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	struct atmtcp_hdr *hdr;
+
+	if (skb->len < sizeof(struct atmtcp_hdr))
+		return -EINVAL;
+
+	hdr = (struct atmtcp_hdr *)skb->data;
+	if (hdr->length == ATMTCP_HDR_MAGIC)
+		return -EINVAL;
+
+	return 0;
+}
 
 static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 {
@@ -288,9 +301,6 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (skb->len < sizeof(struct atmtcp_hdr))
-		goto done;
-
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {
@@ -347,6 +357,7 @@ static const struct atmdev_ops atmtcp_v_dev_ops = {
 
 static const struct atmdev_ops atmtcp_c_dev_ops = {
 	.close		= atmtcp_c_close,
+	.pre_send	= atmtcp_c_pre_send,
 	.send		= atmtcp_c_send
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index f5441ce15373..da21e60bb827 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -93,8 +93,8 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, size,
-			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
-			     AMDGPU_VM_PAGE_EXECUTABLE);
+			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
+			     AMDGPU_PTE_EXECUTABLE);
 
 	if (r) {
 		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index e830e461edd1..b8815e7f5832 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -336,7 +336,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_LANE0_1_STATUS,
+		ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_DPCD_REV,
 					 buffer, 1);
 		if (ret != 1)
 			goto out;
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index e1e62674e82d..f71ff434668c 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -664,6 +664,10 @@ static bool nv50_plane_format_mod_supported(struct drm_plane *plane,
 	struct nouveau_drm *drm = nouveau_drm(plane->dev);
 	uint8_t i;
 
+	/* All chipsets can display all formats in linear layout */
+	if (modifier == DRM_FORMAT_MOD_LINEAR)
+		return true;
+
 	if (drm->client.device.info.chipset < 0xc0) {
 		const struct drm_format_info *info = drm_format_info(format);
 		const uint8_t kind = (modifier >> 12) & 0xff;
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 493814f7f09c..feec0724328f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1135,7 +1135,13 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (!drvdata->input) {
+	/*
+	 * Check that input registration succeeded. Checking that
+	 * HID_CLAIMED_INPUT is set prevents a UAF when all input devices
+	 * were freed during registration due to no usages being mapped,
+	 * leaving drvdata->input pointing to freed memory.
+	 */
+	if (!drvdata->input || !(hdev->claimed & HID_CLAIMED_INPUT)) {
 		hid_err(hdev, "Asus input not registered\n");
 		ret = -ENOMEM;
 		goto err_stop_hw;
diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 560eeec4035a..69076d52dccf 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -44,6 +44,7 @@ enum {
 	MCP2221_I2C_MASK_ADDR_NACK = 0x40,
 	MCP2221_I2C_WRADDRL_SEND = 0x21,
 	MCP2221_I2C_ADDR_NACK = 0x25,
+	MCP2221_I2C_READ_PARTIAL = 0x54,
 	MCP2221_I2C_READ_COMPL = 0x55,
 	MCP2221_ALT_F_NOT_GPIOV = 0xEE,
 	MCP2221_ALT_F_NOT_GPIOD = 0xEF,
@@ -169,6 +170,25 @@ static int mcp_cancel_last_cmd(struct mcp2221 *mcp)
 	return mcp_send_data_req_status(mcp, mcp->txbuf, 8);
 }
 
+/* Check if the last command succeeded or failed and return the result.
+ * If the command did fail, cancel that command which will free the i2c bus.
+ */
+static int mcp_chk_last_cmd_status_free_bus(struct mcp2221 *mcp)
+{
+	int ret;
+
+	ret = mcp_chk_last_cmd_status(mcp);
+	if (ret) {
+		/* The last command was a failure.
+		 * Send a cancel which will also free the bus.
+		 */
+		usleep_range(980, 1000);
+		mcp_cancel_last_cmd(mcp);
+	}
+
+	return ret;
+}
+
 static int mcp_set_i2c_speed(struct mcp2221 *mcp)
 {
 	int ret;
@@ -223,7 +243,7 @@ static int mcp_i2c_write(struct mcp2221 *mcp,
 		usleep_range(980, 1000);
 
 		if (last_status) {
-			ret = mcp_chk_last_cmd_status(mcp);
+			ret = mcp_chk_last_cmd_status_free_bus(mcp);
 			if (ret)
 				return ret;
 		}
@@ -260,6 +280,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 {
 	int ret;
 	u16 total_len;
+	int retries = 0;
 
 	mcp->txbuf[0] = type;
 	if (msg) {
@@ -283,20 +304,31 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 	mcp->rxbuf_idx = 0;
 
 	do {
+		/* Wait for the data to be read by the device */
+		usleep_range(980, 1000);
+
 		memset(mcp->txbuf, 0, 4);
 		mcp->txbuf[0] = MCP2221_I2C_GET_DATA;
 
 		ret = mcp_send_data_req_status(mcp, mcp->txbuf, 1);
-		if (ret)
-			return ret;
-
-		ret = mcp_chk_last_cmd_status(mcp);
-		if (ret)
-			return ret;
-
-		usleep_range(980, 1000);
+		if (ret) {
+			if (retries < 5) {
+				/* The data wasn't ready to read.
+				 * Wait a bit longer and try again.
+				 */
+				usleep_range(90, 100);
+				retries++;
+			} else {
+				return ret;
+			}
+		} else {
+			retries = 0;
+		}
 	} while (mcp->rxbuf_idx < total_len);
 
+	usleep_range(980, 1000);
+	ret = mcp_chk_last_cmd_status_free_bus(mcp);
+
 	return ret;
 }
 
@@ -310,11 +342,6 @@ static int mcp_i2c_xfer(struct i2c_adapter *adapter,
 
 	mutex_lock(&mcp->lock);
 
-	/* Setting speed before every transaction is required for mcp2221 */
-	ret = mcp_set_i2c_speed(mcp);
-	if (ret)
-		goto exit;
-
 	if (num == 1) {
 		if (msgs->flags & I2C_M_RD) {
 			ret = mcp_i2c_smbus_read(mcp, msgs, MCP2221_I2C_RD_DATA,
@@ -399,9 +426,7 @@ static int mcp_smbus_write(struct mcp2221 *mcp, u16 addr,
 	if (last_status) {
 		usleep_range(980, 1000);
 
-		ret = mcp_chk_last_cmd_status(mcp);
-		if (ret)
-			return ret;
+		ret = mcp_chk_last_cmd_status_free_bus(mcp);
 	}
 
 	return ret;
@@ -419,10 +444,6 @@ static int mcp_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 
 	mutex_lock(&mcp->lock);
 
-	ret = mcp_set_i2c_speed(mcp);
-	if (ret)
-		goto exit;
-
 	switch (size) {
 
 	case I2C_SMBUS_QUICK:
@@ -768,7 +789,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 				mcp->status = -EIO;
 				break;
 			}
-			if (data[2] == MCP2221_I2C_READ_COMPL) {
+			if (data[2] == MCP2221_I2C_READ_COMPL ||
+			    data[2] == MCP2221_I2C_READ_PARTIAL) {
 				buf = mcp->rxbuf;
 				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
 				mcp->rxbuf_idx = mcp->rxbuf_idx + data[3];
@@ -870,6 +892,11 @@ static int mcp2221_probe(struct hid_device *hdev,
 	if (i2c_clk_freq < 50)
 		i2c_clk_freq = 50;
 	mcp->cur_i2c_clk_div = (12000000 / (i2c_clk_freq * 1000)) - 3;
+	ret = mcp_set_i2c_speed(mcp);
+	if (ret) {
+		hid_err(hdev, "can't set i2c speed: %d\n", ret);
+		return ret;
+	}
 
 	mcp->adapter.owner = THIS_MODULE;
 	mcp->adapter.class = I2C_CLASS_HWMON;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c12f7cb7e1d9..dc4553fd2e39 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1448,6 +1448,14 @@ static __u8 *mt_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	if (hdev->vendor == I2C_VENDOR_ID_GOODIX &&
 	    (hdev->product == I2C_DEVICE_ID_GOODIX_01E8 ||
 	     hdev->product == I2C_DEVICE_ID_GOODIX_01E9)) {
+		if (*size < 608) {
+			dev_info(
+				&hdev->dev,
+				"GT7868Q fixup: report descriptor is only %u bytes, skipping\n",
+				*size);
+			return rdesc;
+		}
+
 		if (rdesc[607] == 0x15) {
 			rdesc[607] = 0x25;
 			dev_info(
diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index b5d26f03fe6b..a1128c5315ff 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -144,6 +144,9 @@ static void ntrig_report_version(struct hid_device *hdev)
 	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
 	unsigned char *data = kmalloc(8, GFP_KERNEL);
 
+	if (!hid_is_usb(hdev))
+		return;
+
 	if (!data)
 		goto err_free;
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a5e6c16c883d..0ab473f372ad 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -684,6 +684,7 @@ static bool wacom_is_art_pen(int tool_id)
 	case 0x885:	/* Intuos3 Marker Pen */
 	case 0x804:	/* Intuos4/5 13HD/24HD Marker Pen */
 	case 0x10804:	/* Intuos4/5 13HD/24HD Art Pen */
+	case 0x204:     /* Art Pen 2 */
 		is_art_pen = true;
 		break;
 	}
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 09a275eb4448..81395852b4d4 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1095,7 +1095,7 @@ get_stats (struct net_device *dev)
 	dev->stats.rx_bytes += dr32(OctetRcvOk);
 	dev->stats.tx_bytes += dr32(OctetXmtOk);
 
-	dev->stats.multicast = dr32(McstFramesRcvdOk);
+	dev->stats.multicast += dr32(McstFramesRcvdOk);
 	dev->stats.collisions += dr32(SingleColFrames)
 			     +  dr32(MultiColFrames);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index c9d5d8d93994..7899a7230299 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -346,7 +346,6 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 		if (err)
 			return err;
 	}
-	priv->dcbx.xoff = xoff;
 
 	/* Apply the settings */
 	if (update_buffer) {
@@ -355,6 +354,8 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 			return err;
 	}
 
+	priv->dcbx.xoff = xoff;
+
 	if (update_prio2buffer)
 		err = mlx5e_port_set_priority2buffer(priv->mdev, prio2buffer);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
index 80af7a5ac604..a23e3d810f3e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
@@ -63,11 +63,23 @@ struct mlx5e_port_buffer {
 	struct mlx5e_bufferx_reg  buffer[MLX5E_MAX_BUFFER];
 };
 
+#ifdef CONFIG_MLX5_CORE_EN_DCB
 int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 				    u32 change, unsigned int mtu,
 				    struct ieee_pfc *pfc,
 				    u32 *buffer_size,
 				    u8 *prio2buffer);
+#else
+static inline int
+mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
+				u32 change, unsigned int mtu,
+				void *pfc,
+				u32 *buffer_size,
+				u8 *prio2buffer)
+{
+	return 0;
+}
+#endif
 
 int mlx5e_port_query_buffer(struct mlx5e_priv *priv,
 			    struct mlx5e_port_buffer *port_buffer);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 321441e6ad32..cfbc569edfb5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -42,6 +42,7 @@
 #include "eswitch.h"
 #include "en.h"
 #include "en/txrx.h"
+#include "en/port_buffer.h"
 #include "en_tc.h"
 #include "en_rep.h"
 #include "en_accel/ipsec.h"
@@ -103,6 +104,8 @@ void mlx5e_update_carrier(struct mlx5e_priv *priv)
 	if (up) {
 		netdev_info(priv->netdev, "Link up\n");
 		netif_carrier_on(priv->netdev);
+		mlx5e_port_manual_buffer_config(priv, 0, priv->netdev->mtu,
+						NULL, NULL, NULL);
 	} else {
 		netdev_info(priv->netdev, "Link down\n");
 		netif_carrier_off(priv->netdev);
@@ -2242,9 +2245,11 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 	struct mlx5e_params *params = &priv->channels.params;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u16 mtu;
+	u16 mtu, prev_mtu;
 	int err;
 
+	mlx5e_query_mtu(mdev, params, &prev_mtu);
+
 	err = mlx5e_set_mtu(mdev, params, params->sw_mtu);
 	if (err)
 		return err;
@@ -2254,6 +2259,18 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 		netdev_warn(netdev, "%s: VPort MTU %d is different than netdev mtu %d\n",
 			    __func__, mtu, params->sw_mtu);
 
+	if (mtu != prev_mtu && MLX5_BUFFER_SUPPORTED(mdev)) {
+		err = mlx5e_port_manual_buffer_config(priv, 0, mtu,
+						      NULL, NULL, NULL);
+		if (err) {
+			netdev_warn(netdev, "%s: Failed to set Xon/Xoff values with MTU %d (err %d), setting back to previous MTU %d\n",
+				    __func__, mtu, err, prev_mtu);
+
+			mlx5e_set_mtu(mdev, params, prev_mtu);
+			return err;
+		}
+	}
+
 	params->sw_mtu = mtu;
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 5e98355f422b..3e4318d5dcdf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -199,10 +199,6 @@ static void dwxgmac2_dma_rx_mode(void __iomem *ioaddr, int mode,
 	}
 
 	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
-
-	/* Enable MTL RX overflow */
-	value = readl(ioaddr + XGMAC_MTL_QINTEN(channel));
-	writel(value | XGMAC_RXOIE, ioaddr + XGMAC_MTL_QINTEN(channel));
 }
 
 static void dwxgmac2_dma_tx_mode(void __iomem *ioaddr, int mode,
diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 878298304430..fcfbff691b3c 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -474,6 +474,7 @@ static inline void vsc8584_config_macsec_intr(struct phy_device *phydev)
 void vsc85xx_link_change_notify(struct phy_device *phydev);
 void vsc8584_config_ts_intr(struct phy_device *phydev);
 int vsc8584_ptp_init(struct phy_device *phydev);
+void vsc8584_ptp_deinit(struct phy_device *phydev);
 int vsc8584_ptp_probe_once(struct phy_device *phydev);
 int vsc8584_ptp_probe(struct phy_device *phydev);
 irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev);
@@ -488,6 +489,9 @@ static inline int vsc8584_ptp_init(struct phy_device *phydev)
 {
 	return 0;
 }
+static inline void vsc8584_ptp_deinit(struct phy_device *phydev)
+{
+}
 static inline int vsc8584_ptp_probe_once(struct phy_device *phydev)
 {
 	return 0;
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 03aa85ec60df..982e73adf2bc 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2326,9 +2326,7 @@ static int vsc85xx_probe(struct phy_device *phydev)
 
 static void vsc85xx_remove(struct phy_device *phydev)
 {
-	struct vsc8531_private *priv = phydev->priv;
-
-	skb_queue_purge(&priv->rx_skbs_list);
+	vsc8584_ptp_deinit(phydev);
 }
 
 /* Microsemi VSC85xx PHYs */
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index f77bfbee5f20..e30e6ba9da2f 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1294,7 +1294,6 @@ static void vsc8584_set_input_clk_configured(struct phy_device *phydev)
 
 static int __vsc8584_init_ptp(struct phy_device *phydev)
 {
-	struct vsc8531_private *vsc8531 = phydev->priv;
 	static const u32 ltc_seq_e[] = { 0, 400000, 0, 0, 0 };
 	static const u8  ltc_seq_a[] = { 8, 6, 5, 4, 2 };
 	u32 val;
@@ -1511,17 +1510,7 @@ static int __vsc8584_init_ptp(struct phy_device *phydev)
 
 	vsc85xx_ts_eth_cmp1_sig(phydev);
 
-	vsc8531->mii_ts.rxtstamp = vsc85xx_rxtstamp;
-	vsc8531->mii_ts.txtstamp = vsc85xx_txtstamp;
-	vsc8531->mii_ts.hwtstamp = vsc85xx_hwtstamp;
-	vsc8531->mii_ts.ts_info  = vsc85xx_ts_info;
-	phydev->mii_ts = &vsc8531->mii_ts;
-
-	memcpy(&vsc8531->ptp->caps, &vsc85xx_clk_caps, sizeof(vsc85xx_clk_caps));
-
-	vsc8531->ptp->ptp_clock = ptp_clock_register(&vsc8531->ptp->caps,
-						     &phydev->mdio.dev);
-	return PTR_ERR_OR_ZERO(vsc8531->ptp->ptp_clock);
+	return 0;
 }
 
 void vsc8584_config_ts_intr(struct phy_device *phydev)
@@ -1548,6 +1537,16 @@ int vsc8584_ptp_init(struct phy_device *phydev)
 	return 0;
 }
 
+void vsc8584_ptp_deinit(struct phy_device *phydev)
+{
+	struct vsc8531_private *vsc8531 = phydev->priv;
+
+	if (vsc8531->ptp->ptp_clock) {
+		ptp_clock_unregister(vsc8531->ptp->ptp_clock);
+		skb_queue_purge(&vsc8531->rx_skbs_list);
+	}
+}
+
 irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev)
 {
 	struct vsc8531_private *priv = phydev->priv;
@@ -1605,7 +1604,16 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 
 	vsc8531->ptp->phydev = phydev;
 
-	return 0;
+	vsc8531->mii_ts.rxtstamp = vsc85xx_rxtstamp;
+	vsc8531->mii_ts.txtstamp = vsc85xx_txtstamp;
+	vsc8531->mii_ts.hwtstamp = vsc85xx_hwtstamp;
+	vsc8531->mii_ts.ts_info  = vsc85xx_ts_info;
+	phydev->mii_ts = &vsc8531->mii_ts;
+
+	memcpy(&vsc8531->ptp->caps, &vsc85xx_clk_caps, sizeof(vsc85xx_clk_caps));
+	vsc8531->ptp->ptp_clock = ptp_clock_register(&vsc8531->ptp->caps,
+						     &phydev->mdio.dev);
+	return PTR_ERR_OR_ZERO(vsc8531->ptp->ptp_clock);
 }
 
 int vsc8584_ptp_probe_once(struct phy_device *phydev)
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index d21d23f10d42..f574de58c199 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1358,6 +1358,9 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1034, 2)}, /* Telit LE910C4-WWX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1037, 4)}, /* Telit LE910C4-WWX */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1038, 3)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x103a, 0)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1040, 2)},	/* Telit LE922A */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1050, 2)},	/* Telit FN980 */
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 31921108e456..546a8f1bb10b 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -269,6 +269,7 @@ config PINCTRL_STMFX
 	tristate "STMicroelectronics STMFX GPIO expander pinctrl driver"
 	depends on I2C
 	depends on OF_GPIO
+	depends on HAS_IOMEM
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
 	select MFD_STMFX
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 4c72116c8693..7d3cbf4e6bc6 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -265,7 +265,7 @@ show_shost_supported_mode(struct device *dev, struct device_attribute *attr,
 	return show_shost_mode(supported_mode, buf);
 }
 
-static DEVICE_ATTR(supported_mode, S_IRUGO | S_IWUSR, show_shost_supported_mode, NULL);
+static DEVICE_ATTR(supported_mode, S_IRUGO, show_shost_supported_mode, NULL);
 
 static ssize_t
 show_shost_active_mode(struct device *dev,
@@ -279,7 +279,7 @@ show_shost_active_mode(struct device *dev,
 		return show_shost_mode(shost->active_mode, buf);
 }
 
-static DEVICE_ATTR(active_mode, S_IRUGO | S_IWUSR, show_shost_active_mode, NULL);
+static DEVICE_ATTR(active_mode, S_IRUGO, show_shost_active_mode, NULL);
 
 static int check_reset_type(const char *str)
 {
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 00f10d340259..7a6892cfa3c5 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -95,6 +95,7 @@ struct vhost_net_ubuf_ref {
 	atomic_t refcount;
 	wait_queue_head_t wait;
 	struct vhost_virtqueue *vq;
+	struct rcu_head rcu;
 };
 
 #define VHOST_NET_BATCH 64
@@ -248,9 +249,13 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
 
 static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
 {
-	int r = atomic_sub_return(1, &ubufs->refcount);
+	int r;
+
+	rcu_read_lock();
+	r = atomic_sub_return(1, &ubufs->refcount);
 	if (unlikely(!r))
 		wake_up(&ubufs->wait);
+	rcu_read_unlock();
 	return r;
 }
 
@@ -263,7 +268,7 @@ static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs)
 static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
 {
 	vhost_net_ubuf_put_and_wait(ubufs);
-	kfree(ubufs);
+	kfree_rcu(ubufs, rcu);
 }
 
 static void vhost_net_clear_ubuf_info(struct vhost_net *n)
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 99d002438008..124db520b2bd 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -47,6 +47,10 @@ static int efivarfs_d_compare(const struct dentry *dentry,
 {
 	int guid = len - EFI_VARIABLE_GUID_LEN;
 
+	/* Parallel lookups may produce a temporary invalid filename */
+	if (guid <= 0)
+		return 1;
+
 	if (name->len != len)
 		return 1;
 
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index fdecf729fa92..d6b18100a4cf 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -167,83 +167,6 @@ nfs_page_group_lock_head(struct nfs_page *req)
 	return head;
 }
 
-/*
- * nfs_unroll_locks -  unlock all newly locked reqs and wait on @req
- * @head: head request of page group, must be holding head lock
- * @req: request that couldn't lock and needs to wait on the req bit lock
- *
- * This is a helper function for nfs_lock_and_join_requests
- * returns 0 on success, < 0 on error.
- */
-static void
-nfs_unroll_locks(struct nfs_page *head, struct nfs_page *req)
-{
-	struct nfs_page *tmp;
-
-	/* relinquish all the locks successfully grabbed this run */
-	for (tmp = head->wb_this_page ; tmp != req; tmp = tmp->wb_this_page) {
-		if (!kref_read(&tmp->wb_kref))
-			continue;
-		nfs_unlock_and_release_request(tmp);
-	}
-}
-
-/*
- * nfs_page_group_lock_subreq -  try to lock a subrequest
- * @head: head request of page group
- * @subreq: request to lock
- *
- * This is a helper function for nfs_lock_and_join_requests which
- * must be called with the head request and page group both locked.
- * On error, it returns with the page group unlocked.
- */
-static int
-nfs_page_group_lock_subreq(struct nfs_page *head, struct nfs_page *subreq)
-{
-	int ret;
-
-	if (!kref_get_unless_zero(&subreq->wb_kref))
-		return 0;
-	while (!nfs_lock_request(subreq)) {
-		nfs_page_group_unlock(head);
-		ret = nfs_wait_on_request(subreq);
-		if (!ret)
-			ret = nfs_page_group_lock(head);
-		if (ret < 0) {
-			nfs_unroll_locks(head, subreq);
-			nfs_release_request(subreq);
-			return ret;
-		}
-	}
-	return 0;
-}
-
-/*
- * nfs_page_group_lock_subrequests -  try to lock the subrequests
- * @head: head request of page group
- *
- * This is a helper function for nfs_lock_and_join_requests which
- * must be called with the head request locked.
- */
-int nfs_page_group_lock_subrequests(struct nfs_page *head)
-{
-	struct nfs_page *subreq;
-	int ret;
-
-	ret = nfs_page_group_lock(head);
-	if (ret < 0)
-		return ret;
-	/* lock each request in the page group */
-	for (subreq = head->wb_this_page; subreq != head;
-			subreq = subreq->wb_this_page) {
-		ret = nfs_page_group_lock_subreq(head, subreq);
-		if (ret < 0)
-			return ret;
-	}
-	nfs_page_group_unlock(head);
-	return 0;
-}
-
 /*
  * nfs_page_set_headlock - set the request PG_HEADLOCK
  * @req: request that is to be locked
@@ -311,13 +234,14 @@ nfs_page_group_unlock(struct nfs_page *req)
 	nfs_page_clear_headlock(req);
 }
 
-/*
- * nfs_page_group_sync_on_bit_locked
+/**
+ * nfs_page_group_sync_on_bit_locked - Test if all requests have @bit set
+ * @req: request in page group
+ * @bit: PG_* bit that is used to sync page group
  *
  * must be called with page group lock held
  */
-static bool
-nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
+bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
 {
 	struct nfs_page *head = req->wb_head;
 	struct nfs_page *tmp;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bb401d37fe26..9323631f4889 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -155,20 +155,10 @@ nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
 	}
 }
 
-static int
-nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
+static void nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
 {
-	int ret;
-
-	if (!test_bit(PG_REMOVE, &req->wb_flags))
-		return 0;
-	ret = nfs_page_group_lock(req);
-	if (ret)
-		return ret;
 	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
 		nfs_page_set_inode_ref(req, inode);
-	nfs_page_group_unlock(req);
-	return 0;
 }
 
 static struct nfs_page *
@@ -240,36 +230,6 @@ static struct nfs_page *nfs_page_find_head_request(struct page *page)
 	return req;
 }
 
-static struct nfs_page *nfs_find_and_lock_page_request(struct page *page)
-{
-	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_page *req, *head;
-	int ret;
-
-	for (;;) {
-		req = nfs_page_find_head_request(page);
-		if (!req)
-			return req;
-		head = nfs_page_group_lock_head(req);
-		if (head != req)
-			nfs_release_request(req);
-		if (IS_ERR(head))
-			return head;
-		ret = nfs_cancel_remove_inode(head, inode);
-		if (ret < 0) {
-			nfs_unlock_and_release_request(head);
-			return ERR_PTR(ret);
-		}
-		/* Ensure that nobody removed the request before we locked it */
-		if (head == nfs_page_private_request(page))
-			break;
-		if (PageSwapCache(page))
-			break;
-		nfs_unlock_and_release_request(head);
-	}
-	return head;
-}
-
 /* Adjust the file length if we're writing beyond the end */
 static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int count)
 {
@@ -546,6 +506,57 @@ void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
 	nfs_destroy_unlinked_subrequests(destroy_list, head, inode);
 }
 
+/*
+ * nfs_unroll_locks -  unlock all newly locked reqs and wait on @req
+ * @head: head request of page group, must be holding head lock
+ * @req: request that couldn't lock and needs to wait on the req bit lock
+ *
+ * This is a helper function for nfs_lock_and_join_requests
+ * returns 0 on success, < 0 on error.
+ */
+static void
+nfs_unroll_locks(struct nfs_page *head, struct nfs_page *req)
+{
+	struct nfs_page *tmp;
+
+	/* relinquish all the locks successfully grabbed this run */
+	for (tmp = head->wb_this_page ; tmp != req; tmp = tmp->wb_this_page) {
+		if (!kref_read(&tmp->wb_kref))
+			continue;
+		nfs_unlock_and_release_request(tmp);
+	}
+}
+
+/*
+ * nfs_page_group_lock_subreq -  try to lock a subrequest
+ * @head: head request of page group
+ * @subreq: request to lock
+ *
+ * This is a helper function for nfs_lock_and_join_requests which
+ * must be called with the head request and page group both locked.
+ * On error, it returns with the page group unlocked.
+ */
+static int
+nfs_page_group_lock_subreq(struct nfs_page *head, struct nfs_page *subreq)
+{
+	int ret;
+
+	if (!kref_get_unless_zero(&subreq->wb_kref))
+		return 0;
+	while (!nfs_lock_request(subreq)) {
+		nfs_page_group_unlock(head);
+		ret = nfs_wait_on_request(subreq);
+		if (!ret)
+			ret = nfs_page_group_lock(head);
+		if (ret < 0) {
+			nfs_unroll_locks(head, subreq);
+			nfs_release_request(subreq);
+			return ret;
+		}
+	}
+	return 0;
+}
+
 /*
  * nfs_lock_and_join_requests - join all subreqs to the head req
  * @page: the page used to lookup the "page group" of nfs_page structures
@@ -565,7 +576,7 @@ static struct nfs_page *
 nfs_lock_and_join_requests(struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_page *head;
+	struct nfs_page *head, *subreq;
 	struct nfs_commit_info cinfo;
 	int ret;
 
@@ -575,20 +586,49 @@ nfs_lock_and_join_requests(struct page *page)
 	 * reference to the whole page group - the group will not be destroyed
 	 * until the head reference is released.
 	 */
-	head = nfs_find_and_lock_page_request(page);
+retry:
+	head = nfs_page_find_head_request(page);
 	if (IS_ERR_OR_NULL(head))
 		return head;
 
-	/* lock each request in the page group */
-	ret = nfs_page_group_lock_subrequests(head);
-	if (ret < 0) {
+	while (!nfs_lock_request(head)) {
+		ret = nfs_wait_on_request(head);
+		if (ret < 0) {
+			nfs_release_request(head);
+			return ERR_PTR(ret);
+		}
+	}
+
+	ret = nfs_page_group_lock(head);
+	if (ret < 0)
+		goto out_unlock;
+
+	/* Ensure that nobody removed the request before we locked it */
+	if (head != nfs_page_private_request(page) && !PageSwapCache(page)) {
+		nfs_page_group_unlock(head);
 		nfs_unlock_and_release_request(head);
-		return ERR_PTR(ret);
+		goto retry;
 	}
 
-	nfs_join_page_group(head, &cinfo, inode);
+	nfs_cancel_remove_inode(head, inode);
 
+	/* lock each request in the page group */
+	for (subreq = head->wb_this_page;
+	     subreq != head;
+	     subreq = subreq->wb_this_page) {
+		ret = nfs_page_group_lock_subreq(head, subreq);
+		if (ret < 0)
+			goto out_unlock;
+	}
+
+	nfs_page_group_unlock(head);
+
+	nfs_join_page_group(head, &cinfo, inode);
 	return head;
+
+out_unlock:
+	nfs_unlock_and_release_request(head);
+	return ERR_PTR(ret);
 }
 
 static void nfs_write_error(struct nfs_page *req, int error)
@@ -781,7 +821,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_page *head;
 
-	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
+	nfs_page_group_lock(req);
+	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
 		head = req->wb_head;
 
 		spin_lock(&mapping->private_lock);
@@ -792,6 +833,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 		}
 		spin_unlock(&mapping->private_lock);
 	}
+	nfs_page_group_unlock(req);
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		nfs_release_request(req);
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 4f6c7b546bea..2a398f619b7d 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -171,7 +171,7 @@ static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
 static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
 {
 	iter->loffset++;
-	if (iter->loffset < iter->elen >> iter->dir->i_blkbits)
+	if (iter->loffset < DIV_ROUND_UP(iter->elen, 1<<iter->dir->i_blkbits))
 		return 0;
 
 	iter->loffset = 0;
diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 83b95be9ded8..0ca4ab5ef119 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -418,6 +418,13 @@ xfs_attr_rmtval_get(
 			dblkcnt = XFS_FSB_TO_BB(mp, map[i].br_blockcount);
 			error = xfs_buf_read(mp->m_ddev_targp, dblkno, dblkcnt,
 					0, &bp, &xfs_attr3_rmt_buf_ops);
+			/*
+			 * ENODATA from disk implies a disk medium failure;
+			 * ENODATA for xattrs means attribute not found, so
+			 * disambiguate that here.
+			 */
+			if (error == -ENODATA)
+				error = -EIO;
 			if (error)
 				return error;
 
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index c062e2c85178..9ac99912e7a5 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2639,6 +2639,12 @@ xfs_da_read_buf(
 
 	error = xfs_trans_read_buf_map(mp, tp, mp->m_ddev_targp, mapp, nmap, 0,
 			&bp, ops);
+	/*
+	 * ENODATA from disk implies a disk medium failure; ENODATA for
+	 * xattrs means attribute not found, so disambiguate that here.
+	 */
+	if (error == -ENODATA && whichfork == XFS_ATTR_FORK)
+		error = -EIO;
 	if (error)
 		goto out_free;
 
diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 45f2f278b50a..70807c679f1a 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -185,6 +185,7 @@ struct atmdev_ops { /* only send is required */
 	int (*compat_ioctl)(struct atm_dev *dev,unsigned int cmd,
 			    void __user *arg);
 #endif
+	int (*pre_send)(struct atm_vcc *vcc, struct sk_buff *skb);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	int (*send_bh)(struct atm_vcc *vcc, struct sk_buff *skb);
 	int (*send_oam)(struct atm_vcc *vcc,void *cell,int flags);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 40aa09a21f75..137b790ea1a4 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -144,13 +144,13 @@ extern  int nfs_wait_on_request(struct nfs_page *);
 extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
-extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
 extern void nfs_join_page_group(struct nfs_page *head,
 				struct nfs_commit_info *cinfo,
 				struct inode *inode);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
+extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *, unsigned int);
 extern	int nfs_page_set_headlock(struct nfs_page *req);
 extern void nfs_page_clear_headlock(struct nfs_page *req);
 extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_context *);
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 4d40dcce7604..37d3ddd36ae5 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -102,8 +102,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	addr = dma_common_contiguous_remap(page, pool_size,
-					   pgprot_dmacoherent(PAGE_KERNEL),
-					   __builtin_return_address(0));
+			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
+			__builtin_return_address(0));
 	if (!addr)
 		goto free_page;
 #else
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 23f6a9941be1..7af8bbc57531 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10122,10 +10122,10 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 			ret = print_trace_line(&iter);
 			if (ret != TRACE_TYPE_NO_CONSUME)
 				trace_consume(&iter);
+
+			trace_printk_seq(&iter.seq);
 		}
 		touch_nmi_watchdog();
-
-		trace_printk_seq(&iter.seq);
 	}
 
 	if (!cnt)
diff --git a/net/atm/common.c b/net/atm/common.c
index 930eb302cd10..38ed7b985f65 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -635,18 +635,27 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 
 	skb->dev = NULL; /* for paths shared with net_device interfaces */
 	if (!copy_from_iter_full(skb_put(skb, size), size, &m->msg_iter)) {
-		atm_return_tx(vcc, skb);
-		kfree_skb(skb);
 		error = -EFAULT;
-		goto out;
+		goto free_skb;
 	}
 	if (eff != size)
 		memset(skb->data + size, 0, eff-size);
+
+	if (vcc->dev->ops->pre_send) {
+		error = vcc->dev->ops->pre_send(vcc, skb);
+		if (error)
+			goto free_skb;
+	}
+
 	error = vcc->dev->ops->send(vcc, skb);
 	error = error ? error : size;
 out:
 	release_sock(sk);
 	return error;
+free_skb:
+	atm_return_tx(vcc, skb);
+	kfree_skb(skb);
+	goto out;
 }
 
 __poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 84b07b27b3cf..cfdaaecf7860 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3919,7 +3919,17 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (!conn)
 			continue;
 
-		conn->sent -= count;
+		/* Check if there is really enough packets outstanding before
+		 * attempting to decrease the sent counter otherwise it could
+		 * underflow..
+		 */
+		if (conn->sent >= count) {
+			conn->sent -= count;
+		} else {
+			bt_dev_warn(hdev, "hcon %p sent %u < count %u",
+				    conn, conn->sent, count);
+			conn->sent = 0;
+		}
 
 		switch (conn->type) {
 		case ACL_LINK:
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index df4cbf9ba288..b24de1c67d0c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2552,12 +2552,16 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 		    !netif_is_l3_master(dev_out))
 			return ERR_PTR(-EINVAL);
 
-	if (ipv4_is_lbcast(fl4->daddr))
+	if (ipv4_is_lbcast(fl4->daddr)) {
 		type = RTN_BROADCAST;
-	else if (ipv4_is_multicast(fl4->daddr))
+
+		/* reset fi to prevent gateway resolution */
+		fi = NULL;
+	} else if (ipv4_is_multicast(fl4->daddr)) {
 		type = RTN_MULTICAST;
-	else if (ipv4_is_zeronet(fl4->daddr))
+	} else if (ipv4_is_zeronet(fl4->daddr)) {
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (dev_out->flags & IFF_LOOPBACK)
 		flags |= RTCF_LOCAL;
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 470dbdc27d58..107255d92037 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -547,7 +547,9 @@ static void sctp_v6_from_sk(union sctp_addr *addr, struct sock *sk)
 {
 	addr->v6.sin6_family = AF_INET6;
 	addr->v6.sin6_port = 0;
+	addr->v6.sin6_flowinfo = 0;
 	addr->v6.sin6_addr = sk->sk_v6_rcv_saddr;
+	addr->v6.sin6_scope_id = 0;
 }
 
 /* Initialize sk->sk_rcv_saddr from sctp_addr. */
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 4377e91733b8..095c6dc56446 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1782,7 +1782,7 @@ static int tx_macro_register_mclk_output(struct tx_macro *tx)
 }
 
 static const struct snd_soc_component_driver tx_macro_component_drv = {
-	.name = "RX-MACRO",
+	.name = "TX-MACRO",
 	.probe = tx_macro_component_probe,
 	.controls = tx_macro_snd_controls,
 	.num_controls = ARRAY_SIZE(tx_macro_snd_controls),

