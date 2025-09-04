Return-Path: <stable+bounces-177747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A15B4400A
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F598488026
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E36230AAAE;
	Thu,  4 Sep 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="biBHn6Th"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F33303C9E;
	Thu,  4 Sep 2025 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998635; cv=none; b=RwSx3AO+/1xaqabiw2PfEXVrazDziPNk0oWRFkgL/ywGucKercscbnoMDX6sGl1wG5YNjzhqYsRgCkepaIs9VQq92Ie16OM9byykxo8VcH/8iexKCJO4KkXST+OWr70ttPE3S6eKAD5M2Yhth+kQiRFk96mvUhM8WGZ5W0RolXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998635; c=relaxed/simple;
	bh=EdjkcVgz+HFcAXCnZpca8VUNbo5B+e+G+Y4lD5z6/TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zbma5afHOd48VlJsbYgRMYa4KS6oD9WNF0Fil0qaYDJ71WQH58MkzpkJoGqWLpRHUdHo47bxxdEKP6eE/f0FceYHJ+eVq8sOKmLz0f3eJQYYE38XTS7Kp6eQXEFoC/kOus37mewUYmdYVw7SCTPM5KF4ABYm/EBbk+Hm3LSD44M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=biBHn6Th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DB1C4CEF1;
	Thu,  4 Sep 2025 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998634;
	bh=EdjkcVgz+HFcAXCnZpca8VUNbo5B+e+G+Y4lD5z6/TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biBHn6ThiHC8AG010iHsfdUuwWngJXsn6F/0ZDAZ34an5eHAKLDDdmVgMPEppsnj5
	 0WwBetX4gAfHf04hNcRsWWyCh91i/lKayK0lYI6UbMHuMWXzKSRAfNwlJh/KZBI3z3
	 +naVcLtX4311DFByvTJ2awUt/kw0QKP8KEVaYcWA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.242
Date: Thu,  4 Sep 2025 17:10:20 +0200
Message-ID: <2025090420-vagrancy-earthworm-e46e@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090420-grunt-purity-99f1@gregkh>
References: <2025090420-grunt-purity-99f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 3f7fa3e35285..f56b147e24e0 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 241
+SUBLEVEL = 242
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index d89cf802d9aa..8067641561a4 100644
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
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index b49f662f6871..531d2fc049b5 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -17,6 +17,7 @@
 #ifdef CONFIG_X86_64
 # include <asm/set_memory.h>
 #endif
+#include <asm/resctrl.h>
 
 #include "cpu.h"
 
@@ -259,6 +260,8 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << 10;
 		}
 	}
+
+	resctrl_cpu_detect(c);
 }
 
 static void early_init_hygon(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a40408895e23..fdbca15ecb44 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -610,6 +610,8 @@ static int __pv_send_ipi(unsigned long *ipi_bitmap, struct kvm_apic_map *map,
 	if (min > map->max_apic_id)
 		return 0;
 
+	min = array_index_nospec(min, map->max_apic_id + 1);
+
 	for_each_set_bit(i, ipi_bitmap,
 		min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))) {
 		if (map->phys_map[min + i]) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b61f697479a3..63df6c33e3a4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8359,8 +8359,11 @@ static void kvm_sched_yield(struct kvm *kvm, unsigned long dest_id)
 	rcu_read_lock();
 	map = rcu_dereference(kvm->arch.apic_map);
 
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
index 2df9e81e2b49..08047bc4d588 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -94,8 +94,8 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, size,
-			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
-			     AMDGPU_VM_PAGE_EXECUTABLE);
+			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
+			     AMDGPU_PTE_EXECUTABLE);
 
 	if (r) {
 		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index ba8ab1dc4912..6ba16db77500 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -299,7 +299,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_LANE0_1_STATUS,
+		ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_DPCD_REV,
 					 buffer, 1);
 		if (ret != 1)
 			goto out;
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index 831125b4453d..4ae04a728bd0 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -660,6 +660,10 @@ static bool nv50_plane_format_mod_supported(struct drm_plane *plane,
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
index b46fb92d28e5..2f82946fb36a 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1027,7 +1027,13 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
index 0ad3924324ae..2a7cd5be8744 100644
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
index b7f992103da3..af1e96e0209f 100644
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
index c3ff1fc577a7..cc93c503984a 100644
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
@@ -140,6 +141,8 @@ void mlx5e_update_carrier(struct mlx5e_priv *priv)
 	if (port_state == VPORT_STATE_UP) {
 		netdev_info(priv->netdev, "Link up\n");
 		netif_carrier_on(priv->netdev);
+		mlx5e_port_manual_buffer_config(priv, 0, priv->netdev->mtu,
+						NULL, NULL, NULL);
 	} else {
 		netdev_info(priv->netdev, "Link down\n");
 		netif_carrier_off(priv->netdev);
@@ -2874,9 +2877,11 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
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
@@ -2886,6 +2891,18 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
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
index a5583d706b9f..e30bbe1933ec 100644
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
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 9f493d504d20..84f949d8c8c9 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1297,6 +1297,9 @@ static const struct usb_device_id products[] = {
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
index 815095326e2d..72c27181a427 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -268,6 +268,7 @@ config PINCTRL_STMFX
 	tristate "STMicroelectronics STMFX GPIO expander pinctrl driver"
 	depends on I2C
 	depends on OF_GPIO
+	depends on HAS_IOMEM
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
 	select MFD_STMFX
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index bb37d698da1a..4992027f125e 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -264,7 +264,7 @@ show_shost_supported_mode(struct device *dev, struct device_attribute *attr,
 	return show_shost_mode(supported_mode, buf);
 }
 
-static DEVICE_ATTR(supported_mode, S_IRUGO | S_IWUSR, show_shost_supported_mode, NULL);
+static DEVICE_ATTR(supported_mode, S_IRUGO, show_shost_supported_mode, NULL);
 
 static ssize_t
 show_shost_active_mode(struct device *dev,
@@ -278,7 +278,7 @@ show_shost_active_mode(struct device *dev,
 		return show_shost_mode(shost->active_mode, buf);
 }
 
-static DEVICE_ATTR(active_mode, S_IRUGO | S_IWUSR, show_shost_active_mode, NULL);
+static DEVICE_ATTR(active_mode, S_IRUGO, show_shost_active_mode, NULL);
 
 static int check_reset_type(const char *str)
 {
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b9c8e4025214..c9f30aa50879 100644
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
index d79a3b6cb070..41f755365a61 100644
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
index 2bde35921f2b..0b05a40a21f3 100644
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
@@ -780,7 +820,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_page *head;
 
-	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
+	nfs_page_group_lock(req);
+	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
 		head = req->wb_head;
 
 		spin_lock(&mapping->private_lock);
@@ -791,6 +832,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 		}
 		spin_unlock(&mapping->private_lock);
 	}
+	nfs_page_group_unlock(req);
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		nfs_release_request(req);
diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 48d8e9caf86f..09a9fd9a4e72 100644
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
index e46bc03365db..08871fa84419 100644
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
index bc24d19ec2b3..8cbb992f6293 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -185,6 +185,7 @@ struct atmdev_ops { /* only send is required */
 	int (*compat_ioctl)(struct atm_dev *dev,unsigned int cmd,
 			    void __user *arg);
 #endif
+	int (*pre_send)(struct atm_vcc *vcc, struct sk_buff *skb);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	int (*send_oam)(struct atm_vcc *vcc,void *cell,int flags);
 	void (*phy_put)(struct atm_dev *dev,unsigned char value,
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
index b9082b572e0f..8396a2c5fb9a 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -105,8 +105,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 
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
index 0c7aa47fb4d3..d08320c47a15 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9617,10 +9617,10 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
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
index 7f26c1aab9a0..c6dbb4aebfbc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3811,7 +3811,17 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
index 7c4479adbf32..fbaed08600f0 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2452,12 +2452,16 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
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
index d594b949ae82..a9cfe4d62df8 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -499,7 +499,9 @@ static void sctp_v6_from_sk(union sctp_addr *addr, struct sock *sk)
 {
 	addr->v6.sin6_family = AF_INET6;
 	addr->v6.sin6_port = 0;
+	addr->v6.sin6_flowinfo = 0;
 	addr->v6.sin6_addr = sk->sk_v6_rcv_saddr;
+	addr->v6.sin6_scope_id = 0;
 }
 
 /* Initialize sk->sk_rcv_saddr from sctp_addr. */
diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 1a24c44db6dd..85738fd20b22 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -840,9 +840,9 @@ static int broxton_audio_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id bxt_board_ids[] = {
-	{ .name = "bxt_da7219_max98357a" },
-	{ .name = "glk_da7219_max98357a" },
-	{ .name = "cml_da7219_max98357a" },
+	{ .name = "bxt_da7219_mx98357a" },
+	{ .name = "glk_da7219_mx98357a" },
+	{ .name = "cml_da7219_mx98357a" },
 	{ }
 };
 
@@ -866,6 +866,6 @@ MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
 MODULE_AUTHOR("Mac Chiang <mac.chiang@intel.com>");
 MODULE_AUTHOR("Brent Lu <brent.lu@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:bxt_da7219_max98357a");
-MODULE_ALIAS("platform:glk_da7219_max98357a");
-MODULE_ALIAS("platform:cml_da7219_max98357a");
+MODULE_ALIAS("platform:bxt_da7219_mx98357a");
+MODULE_ALIAS("platform:glk_da7219_mx98357a");
+MODULE_ALIAS("platform:cml_da7219_mx98357a");
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index c1b789ac6d50..005bd96175cf 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -621,7 +621,7 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 
 static const struct platform_device_id glk_board_ids[] = {
 	{
-		.name = "glk_rt5682_max98357a",
+		.name = "glk_rt5682_mx98357a",
 		.driver_data =
 			(kernel_ulong_t)&glk_audio_card_rt5682_m98357a,
 	},
@@ -643,4 +643,4 @@ MODULE_DESCRIPTION("Geminilake Audio Machine driver-RT5682 & MAX98357A in I2S mo
 MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
 MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:glk_rt5682_max98357a");
+MODULE_ALIAS("platform:glk_rt5682_mx98357a");
diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index 8d1ad892e86b..16930cab4e28 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -404,7 +404,7 @@ static int audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* By default dais[0] is configured for max98373 */
-	if (!strcmp(pdev->name, "sof_da7219_max98360a")) {
+	if (!strcmp(pdev->name, "sof_da7219_mx98360a")) {
 		dais[0] = (struct snd_soc_dai_link) {
 			.name = "SSP1-Codec",
 			.id = 0,
@@ -431,11 +431,11 @@ static int audio_probe(struct platform_device *pdev)
 
 static const struct platform_device_id board_ids[] = {
 	{
-		.name = "sof_da7219_max98373",
+		.name = "sof_da7219_mx98373",
 		.driver_data = (kernel_ulong_t)&card_da7219_m98373,
 	},
 	{
-		.name = "sof_da7219_max98360a",
+		.name = "sof_da7219_mx98360a",
 		.driver_data = (kernel_ulong_t)&card_da7219_m98360a,
 	},
 	{ }
@@ -456,5 +456,5 @@ module_platform_driver(audio)
 MODULE_DESCRIPTION("ASoC Intel(R) SOF Machine driver");
 MODULE_AUTHOR("Yong Zhi <yong.zhi@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:sof_da7219_max98360a");
-MODULE_ALIAS("platform:sof_da7219_max98373");
+MODULE_ALIAS("platform:sof_da7219_mx98360a");
+MODULE_ALIAS("platform:sof_da7219_mx98373");
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 5883d1fa3b7e..414dc594014d 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -844,7 +844,7 @@ static const struct platform_device_id board_ids[] = {
 		.name = "sof_rt5682",
 	},
 	{
-		.name = "tgl_max98357a_rt5682",
+		.name = "tgl_mx98357a_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
@@ -861,7 +861,7 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(1)),
 	},
 	{
-		.name = "tgl_max98373_rt5682",
+		.name = "tgl_mx98373_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_SSP_CODEC(0) |
 					SOF_SPEAKER_AMP_PRESENT |
@@ -870,7 +870,7 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
 	{
-		.name = "jsl_rt5682_max98360a",
+		.name = "jsl_rt5682_mx98360a",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_MCLK_24MHZ |
 					SOF_RT5682_SSP_CODEC(0) |
@@ -898,7 +898,7 @@ MODULE_AUTHOR("Bard Liao <bard.liao@intel.com>");
 MODULE_AUTHOR("Sathya Prakash M R <sathya.prakash.m.r@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:sof_rt5682");
-MODULE_ALIAS("platform:tgl_max98357a_rt5682");
+MODULE_ALIAS("platform:tgl_mx98357a_rt5682");
 MODULE_ALIAS("platform:jsl_rt5682_rt1015");
-MODULE_ALIAS("platform:tgl_max98373_rt5682");
-MODULE_ALIAS("platform:jsl_rt5682_max98360a");
+MODULE_ALIAS("platform:tgl_mx98373_rt5682");
+MODULE_ALIAS("platform:jsl_rt5682_mx98360a");
diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 32f77e29c2ff..d467663f6757 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -56,7 +56,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "bxt_da7219_max98357a",
+		.drv_name = "bxt_da7219_mx98357a",
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &bxt_codecs,
diff --git a/sound/soc/intel/common/soc-acpi-intel-cml-match.c b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
index 9b85811ffd51..43bba5670ab1 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cml-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
@@ -54,7 +54,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cml_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "cml_da7219_max98357a",
+		.drv_name = "cml_da7219_mx98357a",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &max98357a_spk_codecs,
 		.sof_fw_filename = "sof-cml.ri",
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 26cb3b16cdd3..e05db22d860c 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -24,7 +24,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "glk_da7219_max98357a",
+		.drv_name = "glk_da7219_mx98357a",
 		.fw_filename = "intel/dsp_fw_glk.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &glk_codecs,
@@ -33,7 +33,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 	},
 	{
 		.id = "10EC5682",
-		.drv_name = "glk_rt5682_max98357a",
+		.drv_name = "glk_rt5682_mx98357a",
 		.fw_filename = "intel/dsp_fw_glk.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &glk_codecs,
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
index 34f5fcad5701..6695168e01f6 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -32,7 +32,7 @@ static struct snd_soc_acpi_codecs mx98360a_spk = {
 struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 	{
 		.id = "DLGS7219",
-		.drv_name = "sof_da7219_max98373",
+		.drv_name = "sof_da7219_mx98373",
 		.sof_fw_filename = "sof-jsl.ri",
 		.sof_tplg_filename = "sof-jsl-da7219.tplg",
 		.machine_quirk = snd_soc_acpi_codec_list,
@@ -40,7 +40,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "sof_da7219_max98360a",
+		.drv_name = "sof_da7219_mx98360a",
 		.sof_fw_filename = "sof-jsl.ri",
 		.sof_tplg_filename = "sof-jsl-da7219-mx98360a.tplg",
 	},
@@ -54,7 +54,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
-		.drv_name = "jsl_rt5682_max98360a",
+		.drv_name = "jsl_rt5682_mx98360a",
 		.sof_fw_filename = "sof-jsl.ri",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &mx98360a_spk,
diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index 15d862cdcd2f..f7c491eba1e7 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -321,7 +321,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
-		.drv_name = "tgl_max98357a_rt5682",
+		.drv_name = "tgl_mx98357a_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_codecs,
 		.sof_fw_filename = "sof-tgl.ri",
@@ -329,7 +329,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	},
 	{
 		.id = "10EC5682",
-		.drv_name = "tgl_max98373_rt5682",
+		.drv_name = "tgl_mx98373_rt5682",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &tgl_max98373_amp,
 		.sof_fw_filename = "sof-tgl.ri",

