Return-Path: <stable+bounces-73838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA8E97052C
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 08:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24968B21EC1
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 06:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5E4964E;
	Sun,  8 Sep 2024 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rPcfnZaW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA34879B;
	Sun,  8 Sep 2024 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725776002; cv=none; b=oKRGYAU/VhhLtyMpxjh3uFT92OISunZfT9uxJ5K/o2ghwHNoQhm/RtD31wvgguvxiBokrbd8lS402SkeUblFcwwzjtcFuMJHE8i0AXpA2gfCk+hKm5an3ulwIIu14WJjK25WOnqX2LOkW6E+2QHekIUV2PcKQq2t+7Bzdplf8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725776002; c=relaxed/simple;
	bh=eCGxsCyhk2viOqfqK69P0ulDLJGq4u6CznAiKNEcs7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/WP4Clx0EM8jKyYTg0r+4YkJsdJQ8Lsrf67MmFuI9nuLIKUHe9tYr0RKF33H4xZcBGuITsoOhviuNDib73OMjjMrzMBTmNjt3XZ3UH6n3vewAywt9fRGnIfP+bL9B4IgUHoQaC6fHPyCY7uDyEUlpT3HkdyoJb4cNW663eBfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rPcfnZaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CD2C4CEC3;
	Sun,  8 Sep 2024 06:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725776001;
	bh=eCGxsCyhk2viOqfqK69P0ulDLJGq4u6CznAiKNEcs7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPcfnZaWJyicbdFUMxhCzPVFFJeUl1nsS8x4zGqOyWqxFXe/qxMiVlQpMqtedc6ba
	 nUHHZdRIFyKdpvrE4yjCfGaLV0DKHDeh13sTRGKOUmU9HrzUX4m4oXiyOrB/0wcQPl
	 xjJFLOcjRnGJY0+luuiAbR6OIIDaYo4qs2JSb4cY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.109
Date: Sun,  8 Sep 2024 08:13:08 +0200
Message-ID: <2024090807-snowboard-blurb-c4f6@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024090806-eleven-cubicle-5cbb@gregkh>
References: <2024090806-eleven-cubicle-5cbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/locking/hwspinlock.rst b/Documentation/locking/hwspinlock.rst
index 6f03713b7003..2ffaa3cbd63f 100644
--- a/Documentation/locking/hwspinlock.rst
+++ b/Documentation/locking/hwspinlock.rst
@@ -85,6 +85,17 @@ is already free).
 
 Should be called from a process context (might sleep).
 
+::
+
+  int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id);
+
+After verifying the owner of the hwspinlock, release a previously acquired
+hwspinlock; returns 0 on success, or an appropriate error code on failure
+(e.g. -EOPNOTSUPP if the bust operation is not defined for the specific
+hwspinlock).
+
+Should be called from a process context (might sleep).
+
 ::
 
   int hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned int timeout);
diff --git a/Makefile b/Makefile
index 4813b751ccb0..59c1ac88c57d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 108
+SUBLEVEL = 109
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 69eed260a823..e2d88611d5bf 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -431,8 +431,6 @@ void blk_integrity_unregister(struct gendisk *disk)
 	if (!bi->profile)
 		return;
 
-	/* ensure all bios are off the integrity workqueue */
-	blk_flush_integrity();
 	blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	memset(bi, 0, sizeof(*bi));
 }
diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 37ab23a9d034..7f14c5ed1e22 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -122,8 +122,7 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
 			return ERR_PTR(-ENOMEM);
 
 		max_msg_size = spi_max_message_size(spi);
-		reg_reserve_size = config->reg_bits / BITS_PER_BYTE
-				 + config->pad_bits / BITS_PER_BYTE;
+		reg_reserve_size = (config->reg_bits + config->pad_bits) / BITS_PER_BYTE;
 		if (max_size + reg_reserve_size > max_msg_size)
 			max_size -= reg_reserve_size;
 
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 028df8a5f537..079940c69ee0 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -62,9 +62,9 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					     unsigned int target_freq)
 {
 	struct scmi_data *priv = policy->driver_data;
+	unsigned long freq = target_freq;
 
-	if (!perf_ops->freq_set(ph, priv->domain_id,
-				target_freq * 1000, true))
+	if (!perf_ops->freq_set(ph, priv->domain_id, freq * 1000, true))
 		return target_freq;
 
 	return 0;
diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 4153c2edb049..711e3756a39a 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -233,7 +233,7 @@ static void msgdma_free_descriptor(struct msgdma_device *mdev,
 	struct msgdma_sw_desc *child, *next;
 
 	mdev->desc_free_cnt++;
-	list_add_tail(&desc->node, &mdev->free_list);
+	list_move_tail(&desc->node, &mdev->free_list);
 	list_for_each_entry_safe(child, next, &desc->tx_list, node) {
 		mdev->desc_free_cnt++;
 		list_move_tail(&child->node, &mdev->free_list);
@@ -583,17 +583,16 @@ static void msgdma_issue_pending(struct dma_chan *chan)
 static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
 {
 	struct msgdma_sw_desc *desc, *next;
+	unsigned long irqflags;
 
 	list_for_each_entry_safe(desc, next, &mdev->done_list, node) {
 		struct dmaengine_desc_callback cb;
 
-		list_del(&desc->node);
-
 		dmaengine_desc_get_callback(&desc->async_tx, &cb);
 		if (dmaengine_desc_callback_valid(&cb)) {
-			spin_unlock(&mdev->lock);
+			spin_unlock_irqrestore(&mdev->lock, irqflags);
 			dmaengine_desc_callback_invoke(&cb, NULL);
-			spin_lock(&mdev->lock);
+			spin_lock_irqsave(&mdev->lock, irqflags);
 		}
 
 		/* Run any dependencies, then free the descriptor */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
index a4d65973bf7c..80771b1480ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
@@ -100,6 +100,7 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock)
 	amdgpu_afmt_calc_cts(clock, &res.cts_32khz, &res.n_32khz, 32000);
 	amdgpu_afmt_calc_cts(clock, &res.cts_44_1khz, &res.n_44_1khz, 44100);
 	amdgpu_afmt_calc_cts(clock, &res.cts_48khz, &res.n_48khz, 48000);
+	res.clock = clock;
 
 	return res;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 9ba4817a9148..816014ea5381 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1476,6 +1476,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 										(u32)le32_to_cpu(*((u32 *)reg_data + j));
 									j++;
 								} else if ((reg_table->mc_reg_address[i].pre_reg_data & LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
+									if (i == 0)
+										continue;
 									reg_table->mc_reg_table_entry[num_ranges].mc_data[i] =
 										reg_table->mc_reg_table_entry[num_ranges].mc_data[i - 1];
 								}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index f1a050379190..682de88cf91f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -213,6 +213,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		struct amdgpu_firmware_info *ucode;
 
 		id = fw_type_convert(cgs_device, type);
+		if (id >= AMDGPU_UCODE_ID_MAXIMUM)
+			return -EINVAL;
+
 		ucode = &adev->firmware.ucode[id];
 		if (ucode->fw == NULL)
 			return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4d1c2eb63090..1d0f6628f1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4560,7 +4560,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 		shadow = vmbo->shadow;
 
 		/* No need to recover an evicted BO */
-		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
+		if (!shadow->tbo.resource ||
+		    shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
 		    shadow->parent->tbo.resource->mem_type != TTM_PL_VRAM)
 			continue;
@@ -5390,7 +5391,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * to put adev in the 1st position.
 	 */
 	INIT_LIST_HEAD(&device_list);
-	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 			if (gpu_reset_for_dev_remove && adev->shutdown)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index d6c4293829aa..3e4912f1f92a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -179,7 +179,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
  * Returns the number of bytes read/written; -errno on error.
  */
 static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
-			      u8 *eeprom_buf, u16 buf_size, bool read)
+			      u8 *eeprom_buf, u32 buf_size, bool read)
 {
 	const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
 	u16 limit;
@@ -226,7 +226,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 
 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 		       u32 eeprom_addr, u8 *eeprom_buf,
-		       u16 bytes)
+		       u32 bytes)
 {
 	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
 				  true);
@@ -234,7 +234,7 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 
 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
 			u32 eeprom_addr, u8 *eeprom_buf,
-			u16 bytes)
+			u32 bytes)
 {
 	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
 				  false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
index 6935adb2be1f..8083b8253ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -28,10 +28,10 @@
 
 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 		       u32 eeprom_addr, u8 *eeprom_buf,
-		       u16 bytes);
+		       u32 bytes);
 
 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
 			u32 eeprom_addr, u8 *eeprom_buf,
-			u16 bytes);
+			u32 bytes);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8764ff7ed97e..f8740ad08af4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1297,6 +1297,9 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
 	uint8_t dst_num_links = node_info.num_links;
 
 	hive = amdgpu_get_xgmi_hive(psp->adev);
+	if (WARN_ON(!hive))
+		return;
+
 	list_for_each_entry(mirror_adev, &hive->device_list, gmc.xgmi.head) {
 		struct psp_xgmi_topology_info *mirror_top_info;
 		int j;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 296b2d5976af..cb73d06e1d38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -324,7 +324,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->max_dw = max_dw;
 	ring->hw_prio = hw_prio;
 
-	if (!ring->no_scheduler) {
+	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
@@ -434,8 +434,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	int r, i;
 	uint32_t value, result, early[3];
+	loff_t i;
+	int r;
 
 	if (*pos & 3 || size & 3)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 5ee9211c503c..af50e6ce39e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -604,7 +604,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->dummy_page_addr = (uint64_t)adev->dummy_page_addr;
 	vf2pf_info->checksum =
 		amd_sriov_msg_checksum(
-		vf2pf_info, vf2pf_info->header.size, 0, 0);
+		vf2pf_info, sizeof(*vf2pf_info), 0, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
index b991609f46c1..d4909ee97cd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -70,6 +70,8 @@ static u32 df_v1_7_get_hbm_channel_number(struct amdgpu_device *adev)
 	int fb_channel_number;
 
 	fb_channel_number = adev->df.funcs->get_fb_channel_number(adev);
+	if (fb_channel_number >= ARRAY_SIZE(df_v1_7_channel_number))
+		fb_channel_number = 0;
 
 	return df_v1_7_channel_number[fb_channel_number];
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 19455a725939..7679a4cd55c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -384,7 +384,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		else
 			WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
 
-		if (!ras->disable_ras_err_cnt_harvest) {
+		if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
 			/*
 			 * clear error status after ras_controller_intr
 			 * according to hw team and count ue number
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index a8671061a175..bf90a6479867 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -43,8 +43,6 @@
 #define CRAT_OEMTABLEID_LENGTH	8
 #define CRAT_RESERVED_LENGTH	6
 
-#define CRAT_OEMID_64BIT_MASK ((1ULL << (CRAT_OEMID_LENGTH * 8)) - 1)
-
 /* Compute Unit flags */
 #define COMPUTE_UNIT_CPU	(1 << 0)  /* Create Virtual CRAT for CPU */
 #define COMPUTE_UNIT_GPU	(1 << 1)  /* Create Virtual CRAT for GPU */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 029916971bf6..d841200a405b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -972,8 +972,7 @@ static void kfd_update_system_properties(void)
 	dev = list_last_entry(&topology_device_list,
 			struct kfd_topology_device, list);
 	if (dev) {
-		sys_props.platform_id =
-			(*((uint64_t *)dev->oem_id)) & CRAT_OEMID_64BIT_MASK;
+		sys_props.platform_id = dev->oem_id64;
 		sys_props.platform_oem = *((uint64_t *)dev->oem_table_id);
 		sys_props.platform_rev = dev->oem_revision;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 19283b8b1688..00a78c2ce686 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -146,7 +146,10 @@ struct kfd_topology_device {
 	struct attribute		attr_gpuid;
 	struct attribute		attr_name;
 	struct attribute		attr_props;
-	uint8_t				oem_id[CRAT_OEMID_LENGTH];
+	union {
+		uint8_t				oem_id[CRAT_OEMID_LENGTH];
+		uint64_t			oem_id64;
+	};
 	uint8_t				oem_table_id[CRAT_OEMTABLEID_LENGTH];
 	uint32_t			oem_revision;
 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6189685af1fd..0be1a1149a3f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4359,7 +4359,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	/* There is one primary plane per CRTC */
 	primary_planes = dm->dc->caps.max_streams;
-	ASSERT(primary_planes <= AMDGPU_MAX_PLANES);
+	if (primary_planes > AMDGPU_MAX_PLANES) {
+		DRM_ERROR("DM: Plane nums out of 6 planes\n");
+		return -EINVAL;
+	}
 
 	/*
 	 * Initialize primary planes, implicit planes for legacy IOCTLS.
@@ -8052,15 +8055,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				bundle->stream_update.vrr_infopacket =
 					&acrtc_state->stream->vrr_infopacket;
 		}
-	} else if (cursor_update && acrtc_state->active_planes > 0 &&
-		   acrtc_attach->base.state->event) {
-		drm_crtc_vblank_get(pcrtc);
-
+	} else if (cursor_update && acrtc_state->active_planes > 0) {
 		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
-
-		acrtc_attach->event = acrtc_attach->base.state->event;
-		acrtc_attach->base.state->event = NULL;
-
+		if (acrtc_attach->base.state->event) {
+			drm_crtc_vblank_get(pcrtc);
+			acrtc_attach->event = acrtc_attach->base.state->event;
+			acrtc_attach->base.state->event = NULL;
+		}
 		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2c9a33c80c81..df18b4df1f2c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -49,7 +49,7 @@
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
 
-#define AMDGPU_DMUB_NOTIFICATION_MAX 5
+#define AMDGPU_DMUB_NOTIFICATION_MAX 6
 
 /*
 #include "include/amdgpu_dal_power_if.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index ca6dfd2d7561..35386011c56c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -484,7 +484,8 @@ static void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_sm
 			ranges->reader_wm_sets[num_valid_sets].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 
 			/* Modify previous watermark range to cover up to max */
-			ranges->reader_wm_sets[num_valid_sets - 1].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
+			if (num_valid_sets > 0)
+				ranges->reader_wm_sets[num_valid_sets - 1].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 		}
 		num_valid_sets++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f415733f1a97..d7bca680805d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1265,6 +1265,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 		return NULL;
 
 	if (init_params->dce_environment == DCE_ENV_VIRTUAL_HW) {
+		dc->caps.linear_pitch_alignment = 64;
 		if (!dc_construct_ctx(dc, init_params))
 			goto destruct_dc;
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 83898e46bcad..29400db42bb2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3629,6 +3629,9 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 
 enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream)
 {
+	if (dc == NULL || stream == NULL)
+		return DC_ERROR_UNEXPECTED;
+
 	struct dc_link *link = stream->link;
 	struct timing_generator *tg = dc->res_pool->timing_generators[0];
 	enum dc_status res = DC_OK;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
index 994fb732a7cb..a0d437f0ce2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
@@ -690,6 +690,9 @@ static void wbscl_set_scaler_filter(
 	int pair;
 	uint16_t odd_coef, even_coef;
 
+	if (!filter)
+		return;
+
 	for (phase = 0; phase < (NUM_PHASES / 2 + 1); phase++) {
 		for (pair = 0; pair < tap_pairs; pair++) {
 			even_coef = filter[phase * taps + 2 * pair];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index e73f089c84bb..ebd7ed1b9a3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -1453,10 +1453,9 @@ void dcn_bw_update_from_pplib_fclks(
 	ASSERT(fclks->num_levels);
 
 	vmin0p65_idx = 0;
-	vmid0p72_idx = fclks->num_levels -
-		(fclks->num_levels > 2 ? 3 : (fclks->num_levels > 1 ? 2 : 1));
-	vnom0p8_idx = fclks->num_levels - (fclks->num_levels > 1 ? 2 : 1);
-	vmax0p9_idx = fclks->num_levels - 1;
+	vmid0p72_idx = fclks->num_levels > 2 ? fclks->num_levels - 3 : 0;
+	vnom0p8_idx = fclks->num_levels > 1 ? fclks->num_levels - 2 : 0;
+	vmax0p9_idx = fclks->num_levels > 0 ? fclks->num_levels - 1 : 0;
 
 	dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 =
 		32 * (fclks->data[vmin0p65_idx].clocks_in_khz / 1000.0) / 1000.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 1070cf870196..b2ad56c459ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -1099,8 +1099,13 @@ void ModeSupportAndSystemConfiguration(struct display_mode_lib *mode_lib)
 
 	// Total Available Pipes Support Check
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-		total_pipes += mode_lib->vba.DPPPerPlane[k];
 		pipe_idx = get_pipe_idx(mode_lib, k);
+		if (pipe_idx == -1) {
+			ASSERT(0);
+			continue; // skip inactive planes
+		}
+		total_pipes += mode_lib->vba.DPPPerPlane[k];
+
 		if (mode_lib->vba.cache_pipes[pipe_idx].clks_cfg.dppclk_mhz > 0.0)
 			mode_lib->vba.DPPCLK[k] = mode_lib->vba.cache_pipes[pipe_idx].clks_cfg.dppclk_mhz;
 		else
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 3ede6e02c3a7..f2037d78f71a 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -56,7 +56,7 @@ struct gpio_service *dal_gpio_service_create(
 	struct dc_context *ctx)
 {
 	struct gpio_service *service;
-	uint32_t index_of_id;
+	int32_t index_of_id;
 
 	service = kzalloc(sizeof(struct gpio_service), GFP_KERNEL);
 
@@ -112,7 +112,7 @@ struct gpio_service *dal_gpio_service_create(
 	return service;
 
 failure_2:
-	while (index_of_id) {
+	while (index_of_id > 0) {
 		--index_of_id;
 		kfree(service->busyness[index_of_id]);
 	}
@@ -239,6 +239,9 @@ static bool is_pin_busy(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return false;
+
 	return service->busyness[id][en];
 }
 
@@ -247,6 +250,9 @@ static void set_pin_busy(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return;
+
 	service->busyness[id][en] = true;
 }
 
@@ -255,6 +261,9 @@ static void set_pin_free(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return;
+
 	service->busyness[id][en] = false;
 }
 
@@ -263,7 +272,7 @@ enum gpio_result dal_gpio_service_lock(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if (!service->busyness[id]) {
+	if (id != GPIO_ID_UNKNOWN && !service->busyness[id]) {
 		ASSERT_CRITICAL(false);
 		return GPIO_RESULT_OPEN_FAILED;
 	}
@@ -277,7 +286,7 @@ enum gpio_result dal_gpio_service_unlock(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if (!service->busyness[id]) {
+	if (id != GPIO_ID_UNKNOWN && !service->busyness[id]) {
 		ASSERT_CRITICAL(false);
 		return GPIO_RESULT_OPEN_FAILED;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 4233955e3c47..c9851492ec84 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -131,13 +131,21 @@ static bool hdmi_14_process_transaction(
 	const uint8_t hdcp_i2c_addr_link_primary = 0x3a; /* 0x74 >> 1*/
 	const uint8_t hdcp_i2c_addr_link_secondary = 0x3b; /* 0x76 >> 1*/
 	struct i2c_command i2c_command;
-	uint8_t offset = hdcp_i2c_offsets[message_info->msg_id];
+	uint8_t offset;
 	struct i2c_payload i2c_payloads[] = {
-		{ true, 0, 1, &offset },
+		{ true, 0, 1, 0 },
 		/* actual hdcp payload, will be filled later, zeroed for now*/
 		{ 0 }
 	};
 
+	if (message_info->msg_id == HDCP_MESSAGE_ID_INVALID) {
+		DC_LOG_ERROR("%s: Invalid message_info msg_id - %d\n", __func__, message_info->msg_id);
+		return false;
+	}
+
+	offset = hdcp_i2c_offsets[message_info->msg_id];
+	i2c_payloads[0].data = &offset;
+
 	switch (message_info->link) {
 	case HDCP_LINK_SECONDARY:
 		i2c_payloads[0].address = hdcp_i2c_addr_link_secondary;
@@ -311,6 +319,11 @@ static bool dp_11_process_transaction(
 	struct dc_link *link,
 	struct hdcp_protection_message *message_info)
 {
+	if (message_info->msg_id == HDCP_MESSAGE_ID_INVALID) {
+		DC_LOG_ERROR("%s: Invalid message_info msg_id - %d\n", __func__, message_info->msg_id);
+		return false;
+	}
+
 	return dpcd_access_helper(
 		link,
 		message_info->length,
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 8e9caae7c955..1b2df97226a3 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -156,11 +156,16 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
-	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID ||
+		msg_id >= MOD_HDCP_MESSAGE_ID_MAX)
 		return MOD_HDCP_STATUS_DDC_FAILURE;
-	}
 
 	if (is_dp_hdcp(hdcp)) {
+		int num_dpcd_addrs = sizeof(hdcp_dpcd_addrs) /
+			sizeof(hdcp_dpcd_addrs[0]);
+		if (msg_id >= num_dpcd_addrs)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
 			success = hdcp->config.ddc.funcs.read_dpcd(hdcp->config.ddc.handle,
@@ -175,6 +180,11 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 			data_offset += cur_size;
 		}
 	} else {
+		int num_i2c_offsets = sizeof(hdcp_i2c_offsets) /
+			sizeof(hdcp_i2c_offsets[0]);
+		if (msg_id >= num_i2c_offsets)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		success = hdcp->config.ddc.funcs.read_i2c(
 				hdcp->config.ddc.handle,
 				HDCP_I2C_ADDR,
@@ -219,11 +229,16 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
-	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID ||
+		msg_id >= MOD_HDCP_MESSAGE_ID_MAX)
 		return MOD_HDCP_STATUS_DDC_FAILURE;
-	}
 
 	if (is_dp_hdcp(hdcp)) {
+		int num_dpcd_addrs = sizeof(hdcp_dpcd_addrs) /
+			sizeof(hdcp_dpcd_addrs[0]);
+		if (msg_id >= num_dpcd_addrs)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
 			success = hdcp->config.ddc.funcs.write_dpcd(
@@ -239,6 +254,11 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 			data_offset += cur_size;
 		}
 	} else {
+		int num_i2c_offsets = sizeof(hdcp_i2c_offsets) /
+			sizeof(hdcp_i2c_offsets[0]);
+		if (msg_id >= num_i2c_offsets)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		hdcp->buf[0] = hdcp_i2c_offsets[msg_id];
 		memmove(&hdcp->buf[1], buf, buf_len);
 		success = hdcp->config.ddc.funcs.write_i2c(
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index f3668911a88f..eae4b4826f04 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -99,7 +99,7 @@ static void pp_swctf_delayed_work_handler(struct work_struct *work)
 	struct amdgpu_device *adev = hwmgr->adev;
 	struct amdgpu_dpm_thermal *range =
 				&adev->pm.dpm.thermal;
-	uint32_t gpu_temperature, size;
+	uint32_t gpu_temperature, size = sizeof(gpu_temperature);
 	int ret;
 
 	/*
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index f4bd8e9357e2..18f00038d844 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -30,9 +30,8 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 {
 	int result;
 	unsigned int i;
-	unsigned int table_entries;
 	struct pp_power_state *state;
-	int size;
+	int size, table_entries;
 
 	if (hwmgr->hwmgr_func->get_num_of_pp_table_entries == NULL)
 		return 0;
@@ -40,15 +39,19 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 	if (hwmgr->hwmgr_func->get_power_state_size == NULL)
 		return 0;
 
-	hwmgr->num_ps = table_entries = hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
+	table_entries = hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
 
-	hwmgr->ps_size = size = hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
+	size = hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
 					  sizeof(struct pp_power_state);
 
-	if (table_entries == 0 || size == 0) {
+	if (table_entries <= 0 || size == 0) {
 		pr_warn("Please check whether power state management is supported on this asic\n");
+		hwmgr->num_ps = 0;
+		hwmgr->ps_size = 0;
 		return 0;
 	}
+	hwmgr->num_ps = table_entries;
+	hwmgr->ps_size = size;
 
 	hwmgr->ps = kcalloc(table_entries, size, GFP_KERNEL);
 	if (hwmgr->ps == NULL)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index f503e61faa60..cc3b62f73394 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -73,8 +73,9 @@ static int atomctrl_retrieve_ac_timing(
 					j++;
 				} else if ((table->mc_reg_address[i].uc_pre_reg_data &
 							LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
-					table->mc_reg_table_entry[num_ranges].mc_data[i] =
-						table->mc_reg_table_entry[num_ranges].mc_data[i-1];
+					if (i)
+						table->mc_reg_table_entry[num_ranges].mc_data[i] =
+							table->mc_reg_table_entry[num_ranges].mc_data[i-1];
 				}
 			}
 			num_ranges++;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 86d6e88c7386..4f3488f4e0d0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1036,7 +1036,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	switch (type) {
 	case PP_SCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
+		if (ret)
+			return ret;
 
 	/* driver only know min/max gfx_clk, Add level 1 for all other gfx clks */
 		if (now == data->gfx_max_freq_limit/100)
@@ -1057,7 +1059,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 					i == 2 ? "*" : "");
 		break;
 	case PP_MCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
+		if (ret)
+			return ret;
 
 		for (i = 0; i < mclk_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
@@ -1550,7 +1554,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 		}
 
 		if (input[0] == 0) {
-			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+			ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+			if (ret)
+				return ret;
+
 			if (input[1] < min_freq) {
 				pr_err("Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
 					input[1], min_freq);
@@ -1558,7 +1565,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 			}
 			smu10_data->gfx_actual_soft_min_freq = input[1];
 		} else if (input[0] == 1) {
-			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+			ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+			if (ret)
+				return ret;
+
 			if (input[1] > max_freq) {
 				pr_err("Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
 					input[1], max_freq);
@@ -1573,10 +1583,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 			pr_err("Input parameter number not correct\n");
 			return -EINVAL;
 		}
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
-
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+		if (ret)
+			return ret;
 		smu10_data->gfx_actual_soft_min_freq = min_freq;
+
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+		if (ret)
+			return ret;
+
 		smu10_data->gfx_actual_soft_max_freq = max_freq;
 	} else if (type == PP_OD_COMMIT_DPM_TABLE) {
 		if (size != 0) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 750b7527bdf8..530888c475be 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5639,7 +5639,7 @@ static int smu7_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, uint
 	mode = input[size];
 	switch (mode) {
 	case PP_SMC_POWER_PROFILE_CUSTOM:
-		if (size < 8 && size != 0)
+		if (size != 8 && size != 0)
 			return -EINVAL;
 		/* If only CUSTOM is passed in, use the saved values. Check
 		 * that we actually have a CUSTOM profile by ensuring that
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index eb744401e056..7e1197420873 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -584,6 +584,7 @@ static int smu8_init_uvd_limit(struct pp_hwmgr *hwmgr)
 				hwmgr->dyn_state.uvd_clock_voltage_dependency_table;
 	unsigned long clock = 0;
 	uint32_t level;
+	int ret;
 
 	if (NULL == table || table->count <= 0)
 		return -EINVAL;
@@ -591,7 +592,9 @@ static int smu8_init_uvd_limit(struct pp_hwmgr *hwmgr)
 	data->uvd_dpm.soft_min_clk = 0;
 	data->uvd_dpm.hard_min_clk = 0;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxUvdLevel, &level);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxUvdLevel, &level);
+	if (ret)
+		return ret;
 
 	if (level < table->count)
 		clock = table->entries[level].vclk;
@@ -611,6 +614,7 @@ static int smu8_init_vce_limit(struct pp_hwmgr *hwmgr)
 				hwmgr->dyn_state.vce_clock_voltage_dependency_table;
 	unsigned long clock = 0;
 	uint32_t level;
+	int ret;
 
 	if (NULL == table || table->count <= 0)
 		return -EINVAL;
@@ -618,7 +622,9 @@ static int smu8_init_vce_limit(struct pp_hwmgr *hwmgr)
 	data->vce_dpm.soft_min_clk = 0;
 	data->vce_dpm.hard_min_clk = 0;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxEclkLevel, &level);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxEclkLevel, &level);
+	if (ret)
+		return ret;
 
 	if (level < table->count)
 		clock = table->entries[level].ecclk;
@@ -638,6 +644,7 @@ static int smu8_init_acp_limit(struct pp_hwmgr *hwmgr)
 				hwmgr->dyn_state.acp_clock_voltage_dependency_table;
 	unsigned long clock = 0;
 	uint32_t level;
+	int ret;
 
 	if (NULL == table || table->count <= 0)
 		return -EINVAL;
@@ -645,7 +652,9 @@ static int smu8_init_acp_limit(struct pp_hwmgr *hwmgr)
 	data->acp_dpm.soft_min_clk = 0;
 	data->acp_dpm.hard_min_clk = 0;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxAclkLevel, &level);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxAclkLevel, &level);
+	if (ret)
+		return ret;
 
 	if (level < table->count)
 		clock = table->entries[level].acpclk;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index f8333410cc3e..c4d81c0aa18e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -355,13 +355,13 @@ static int vega10_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
-	int i;
 	uint32_t sub_vendor_id, hw_revision;
 	uint32_t top32, bottom32;
 	struct amdgpu_device *adev = hwmgr->adev;
+	int ret, i;
 
 	vega10_initialize_power_tune_defaults(hwmgr);
 
@@ -486,9 +486,12 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	if (data->registry_data.vr0hot_enabled)
 		data->smu_features[GNLD_VR0HOT].supported = true;
 
-	smum_send_msg_to_smc(hwmgr,
+	ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetSmuVersion,
 			&hwmgr->smu_version);
+	if (ret)
+		return ret;
+
 		/* ACG firmware has major version 5 */
 	if ((hwmgr->smu_version & 0xff000000) == 0x5000000)
 		data->smu_features[GNLD_ACG].supported = true;
@@ -506,10 +509,16 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 		data->smu_features[GNLD_PCC_LIMIT].supported = true;
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (ret)
+		return ret;
+
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (ret)
+		return ret;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+	return 0;
 }
 
 #ifdef PPLIB_VEGA10_EVV_SUPPORT
@@ -883,7 +892,9 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	vega10_set_features_platform_caps(hwmgr);
 
-	vega10_init_dpm_defaults(hwmgr);
+	result = vega10_init_dpm_defaults(hwmgr);
+	if (result)
+		return result;
 
 #ifdef PPLIB_VEGA10_EVV_SUPPORT
 	/* Get leakage voltage based on leakage ID. */
@@ -2354,15 +2365,20 @@ static int vega10_acg_enable(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 	uint32_t agc_btc_response;
+	int ret;
 
 	if (data->smu_features[GNLD_ACG].supported) {
 		if (0 == vega10_enable_smc_features(hwmgr, true,
 					data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_bitmap))
 			data->smu_features[GNLD_DPM_PREFETCHER].enabled = true;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitializeAcg, NULL);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitializeAcg, NULL);
+		if (ret)
+			return ret;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunAcgBtc, &agc_btc_response);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunAcgBtc, &agc_btc_response);
+		if (ret)
+			agc_btc_response = 0;
 
 		if (1 == agc_btc_response) {
 			if (1 == data->acg_loop_state)
@@ -2575,8 +2591,11 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwmgr)
 		}
 	}
 
-	pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
+	result = pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
 			VOLTAGE_OBJ_SVID2,  &voltage_table);
+	PP_ASSERT_WITH_CODE(!result,
+			"Failed to get voltage table!",
+			return result);
 	pp_table->MaxVidStep = voltage_table.max_vid_step;
 
 	pp_table->GfxDpmVoltageMode =
@@ -3914,11 +3933,14 @@ static int vega10_get_gpu_power(struct pp_hwmgr *hwmgr,
 		uint32_t *query)
 {
 	uint32_t value;
+	int ret;
 
 	if (!query)
 		return -EINVAL;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr, &value);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr, &value);
+	if (ret)
+		return ret;
 
 	/* SMC returning actual watts, keep consistent with legacy asics, low 8 bit as 8 fractional bits */
 	*query = value << 8;
@@ -4814,14 +4836,16 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
 	PPTable_t *pptable = &(data->smc_state_table.pp_table);
 
-	int i, now, size = 0, count = 0;
+	int i, ret, now,  size = 0, count = 0;
 
 	switch (type) {
 	case PP_SCLK:
 		if (data->registry_data.sclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentGfxclkIndex, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentGfxclkIndex, &now);
+		if (ret)
+			break;
 
 		if (hwmgr->pp_one_vf &&
 		    (hwmgr->dpm_level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK))
@@ -4837,7 +4861,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		if (data->registry_data.mclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
+		if (ret)
+			break;
 
 		for (i = 0; i < mclk_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
@@ -4848,7 +4874,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		if (data->registry_data.socclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
+		if (ret)
+			break;
 
 		for (i = 0; i < soc_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
@@ -4859,8 +4887,10 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		if (data->registry_data.dcefclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc_with_parameter(hwmgr,
+		ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_GetClockFreqMHz, CLK_DCEFCLK, &now);
+		if (ret)
+			break;
 
 		for (i = 0; i < dcef_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 1069eaaae2f8..e4948a118475 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -294,12 +294,12 @@ static int vega12_set_features_platform_caps(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-static void vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct vega12_hwmgr *data = (struct vega12_hwmgr *)(hwmgr->backend);
 	struct amdgpu_device *adev = hwmgr->adev;
 	uint32_t top32, bottom32;
-	int i;
+	int i, ret;
 
 	data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_id =
 			FEATURE_DPM_PREFETCHER_BIT;
@@ -365,10 +365,16 @@ static void vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	}
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (ret)
+		return ret;
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (ret)
+		return ret;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+
+	return 0;
 }
 
 static int vega12_set_private_data_based_on_pptable(struct pp_hwmgr *hwmgr)
@@ -411,7 +417,11 @@ static int vega12_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	vega12_set_features_platform_caps(hwmgr);
 
-	vega12_init_dpm_defaults(hwmgr);
+	result = vega12_init_dpm_defaults(hwmgr);
+	if (result) {
+		pr_err("%s failed\n", __func__);
+		return result;
+	}
 
 	/* Parse pptable data read from VBIOS */
 	vega12_set_private_data_based_on_pptable(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index ff77a3683efd..89f1ed7d08c2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -329,12 +329,12 @@ static int vega20_set_features_platform_caps(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-static void vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data = (struct vega20_hwmgr *)(hwmgr->backend);
 	struct amdgpu_device *adev = hwmgr->adev;
 	uint32_t top32, bottom32;
-	int i;
+	int i, ret;
 
 	data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_id =
 			FEATURE_DPM_PREFETCHER_BIT;
@@ -405,10 +405,17 @@ static void vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	}
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (ret)
+		return ret;
+
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (ret)
+		return ret;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+
+	return 0;
 }
 
 static int vega20_set_private_data_based_on_pptable(struct pp_hwmgr *hwmgr)
@@ -428,6 +435,7 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data;
 	struct amdgpu_device *adev = hwmgr->adev;
+	int result;
 
 	data = kzalloc(sizeof(struct vega20_hwmgr), GFP_KERNEL);
 	if (data == NULL)
@@ -453,8 +461,11 @@ static int vega20_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	vega20_set_features_platform_caps(hwmgr);
 
-	vega20_init_dpm_defaults(hwmgr);
-
+	result = vega20_init_dpm_defaults(hwmgr);
+	if (result) {
+		pr_err("%s failed\n", __func__);
+		return result;
+	}
 	/* Parse pptable data read from VBIOS */
 	vega20_set_private_data_based_on_pptable(hwmgr);
 
@@ -4084,9 +4095,11 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 	if (power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-		if (size == 0 && !data->is_custom_profile_set)
+
+		if (size != 10 && size != 0)
 			return -EINVAL;
-		if (size < 10 && size != 0)
+
+		if (size == 0 && !data->is_custom_profile_set)
 			return -EINVAL;
 
 		result = vega20_get_activity_monitor_coeff(hwmgr,
@@ -4148,6 +4161,8 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 			activity_monitor.Fclk_PD_Data_error_coeff = input[8];
 			activity_monitor.Fclk_PD_Data_error_rate_coeff = input[9];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		result = vega20_set_activity_monitor_coeff(hwmgr,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index a70d73896649..f9c0f117725d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -130,13 +130,17 @@ int vega10_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
 			    uint64_t *features_enabled)
 {
 	uint32_t enabled_features;
+	int ret;
 
 	if (features_enabled == NULL)
 		return -EINVAL;
 
-	smum_send_msg_to_smc(hwmgr,
+	ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeatures,
 			&enabled_features);
+	if (ret)
+		return ret;
+
 	*features_enabled = enabled_features;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ed2112efc6c6..286f4f9bfa35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1215,19 +1215,22 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 					   value);
 }
 
-static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static int navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	DpmDescriptor_t *dpm_desc = NULL;
-	uint32_t clk_index = 0;
+	int clk_index = 0;
 
 	clk_index = smu_cmn_to_asic_specific_index(smu,
 						   CMN2ASIC_MAPPING_CLK,
 						   clk_type);
+	if (clk_index < 0)
+		return clk_index;
+
 	dpm_desc = &pptable->DpmDescriptor[clk_index];
 
 	/* 0 - Fine grained DPM, 1 - Discrete DPM */
-	return dpm_desc->SnapToDiscrete == 0;
+	return dpm_desc->SnapToDiscrete == 0 ? 1 : 0;
 }
 
 static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap)
@@ -1283,7 +1286,11 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (!ret) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu,
 								      clk_type, i, &value);
@@ -1492,7 +1499,11 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (!ret) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1661,7 +1672,11 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (ret) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 1b731a9c92d9..c9c0aa6376e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1003,6 +1003,18 @@ static int vangogh_get_dpm_ultimate_freq(struct smu_context *smu,
 		}
 	}
 	if (min) {
+		ret = vangogh_get_profiling_clk_mask(smu,
+						     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK,
+						     NULL,
+						     NULL,
+						     &mclk_mask,
+						     &fclk_mask,
+						     &soc_mask);
+		if (ret)
+			goto failed;
+
+		vclk_mask = dclk_mask = 0;
+
 		switch (clk_type) {
 		case SMU_UCLK:
 		case SMU_MCLK:
@@ -2363,6 +2375,8 @@ static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool start)
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LogGfxOffResidency,
 					      start, &residency);
+	if (ret)
+		return ret;
 
 	if (!start)
 		adev->gfx.gfx_off_residency = residency;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index cd8b0ab0112a..c79bff02a31a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1939,7 +1939,8 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 						SMU_MSG_GfxDeviceDriverReset);
-
+	if (index < 0 )
+		return -EINVAL;
 	mutex_lock(&smu->message_lock);
 	if (smu_version >= 0x00441400) {
 		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 926ab5c3c31a..0af2bd8706e4 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1841,7 +1841,7 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 		dev_err(tc->dev, "syserr %x\n", stat);
 	}
 
-	if (tc->hpd_pin >= 0 && tc->bridge.dev) {
+	if (tc->hpd_pin >= 0 && tc->bridge.dev && tc->aux.drm_dev) {
 		/*
 		 * H is triggered when the GPIO goes high.
 		 *
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 5db52d6c5c35..039da0d1a613 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -414,6 +414,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OrangePi Neo */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NEO-01"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Samsung GalaxyBook 10.6 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 815dfe30492b..b43ac61201f3 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -534,6 +534,7 @@ int meson_plane_create(struct meson_drm *priv)
 	struct meson_plane *meson_plane;
 	struct drm_plane *plane;
 	const uint64_t *format_modifiers = format_modifiers_default;
+	int ret;
 
 	meson_plane = devm_kzalloc(priv->drm->dev, sizeof(*meson_plane),
 				   GFP_KERNEL);
@@ -548,12 +549,16 @@ int meson_plane_create(struct meson_drm *priv)
 	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
 		format_modifiers = format_modifiers_afbc_g12a;
 
-	drm_universal_plane_init(priv->drm, plane, 0xFF,
-				 &meson_plane_funcs,
-				 supported_drm_formats,
-				 ARRAY_SIZE(supported_drm_formats),
-				 format_modifiers,
-				 DRM_PLANE_TYPE_PRIMARY, "meson_primary_plane");
+	ret = drm_universal_plane_init(priv->drm, plane, 0xFF,
+					&meson_plane_funcs,
+					supported_drm_formats,
+					ARRAY_SIZE(supported_drm_formats),
+					format_modifiers,
+					DRM_PLANE_TYPE_PRIMARY, "meson_primary_plane");
+	if (ret) {
+		devm_kfree(priv->drm->dev, meson_plane);
+		return ret;
+	}
 
 	drm_plane_helper_add(plane, &meson_plane_helper_funcs);
 
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 43aa955ec120..74a490164034 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -153,8 +153,9 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 
 static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 {
-	amd_smn_read(amd_pci_dev_to_node_id(pdev),
-		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
+	if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
+			 ZEN_REPORTED_TEMP_CTRL_BASE, regval))
+		*regval = 0;
 }
 
 static long get_raw_temp(struct k10temp_data *data)
@@ -205,6 +206,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			     long *val)
 {
 	struct k10temp_data *data = dev_get_drvdata(dev);
+	int ret = -EOPNOTSUPP;
 	u32 regval;
 
 	switch (attr) {
@@ -221,13 +223,17 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
-			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
-						  &regval);
+			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+					   ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
+					   &regval);
+
+			if (ret)
+				return ret;
+
 			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
 			break;
 		default:
-			return -EOPNOTSUPP;
+			return ret;
 		}
 		break;
 	case hwmon_temp_max:
@@ -243,7 +249,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			- ((regval >> 24) & 0xf)) * 500 + 52000;
 		break;
 	default:
-		return -EOPNOTSUPP;
+		return ret;
 	}
 	return 0;
 }
@@ -381,8 +387,20 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 	int i;
 
 	for (i = 0; i < limit; i++) {
-		amd_smn_read(amd_pci_dev_to_node_id(pdev),
-			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
+		/*
+		 * Ignore inaccessible CCDs.
+		 *
+		 * Some systems will return a register value of 0, and the TEMP_VALID
+		 * bit check below will naturally fail.
+		 *
+		 * Other systems will return a PCI_ERROR_RESPONSE (0xFFFFFFFF) for
+		 * the register value. And this will incorrectly pass the TEMP_VALID
+		 * bit check.
+		 */
+		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
+				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
+			continue;
+
 		if (regval & ZEN_CCD_TEMP_VALID)
 			data->show_temp |= BIT(TCCD_BIT(i));
 	}
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index fd5f5c5a5244..425597151dd3 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -302,6 +302,34 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 }
 EXPORT_SYMBOL_GPL(__hwspin_unlock);
 
+/**
+ * hwspin_lock_bust() - bust a specific hwspinlock
+ * @hwlock: a previously-acquired hwspinlock which we want to bust
+ * @id: identifier of the remote lock holder, if applicable
+ *
+ * This function will bust a hwspinlock that was previously acquired as
+ * long as the current owner of the lock matches the id given by the caller.
+ *
+ * Context: Process context.
+ *
+ * Returns: 0 on success, or -EINVAL if the hwspinlock does not exist, or
+ * the bust operation fails, and -EOPNOTSUPP if the bust operation is not
+ * defined for the hwspinlock.
+ */
+int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id)
+{
+	if (WARN_ON(!hwlock))
+		return -EINVAL;
+
+	if (!hwlock->bank->ops->bust) {
+		pr_err("bust operation not defined\n");
+		return -EOPNOTSUPP;
+	}
+
+	return hwlock->bank->ops->bust(hwlock, id);
+}
+EXPORT_SYMBOL_GPL(hwspin_lock_bust);
+
 /**
  * of_hwspin_lock_simple_xlate - translate hwlock_spec to return a lock id
  * @bank: the hwspinlock device bank
diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
index 29892767bb7a..f298fc0ee5ad 100644
--- a/drivers/hwspinlock/hwspinlock_internal.h
+++ b/drivers/hwspinlock/hwspinlock_internal.h
@@ -21,6 +21,8 @@ struct hwspinlock_device;
  * @trylock: make a single attempt to take the lock. returns 0 on
  *	     failure and true on success. may _not_ sleep.
  * @unlock:  release the lock. always succeed. may _not_ sleep.
+ * @bust:    optional, platform-specific bust handler, called by hwspinlock
+ *	     core to bust a specific lock.
  * @relax:   optional, platform-specific relax handler, called by hwspinlock
  *	     core while spinning on a lock, between two successive
  *	     invocations of @trylock. may _not_ sleep.
@@ -28,6 +30,7 @@ struct hwspinlock_device;
 struct hwspinlock_ops {
 	int (*trylock)(struct hwspinlock *lock);
 	void (*unlock)(struct hwspinlock *lock);
+	int (*bust)(struct hwspinlock *lock, unsigned int id);
 	void (*relax)(struct hwspinlock *lock);
 };
 
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 135a86fc9453..162845543efe 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -767,9 +767,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
 							INDIO_MAX_RAW_ELEMENTS,
 							vals, &val_len,
 							this_attr->address);
-	else
+	else if (indio_dev->info->read_raw)
 		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
 				    &vals[0], &vals[1], this_attr->address);
+	else
+		return -EINVAL;
 
 	if (ret < 0)
 		return ret;
@@ -851,6 +853,9 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 	int length;
 	int type;
 
+	if (!indio_dev->info->read_avail)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_avail(indio_dev, this_attr->c,
 					  &vals, &type, &length,
 					  this_attr->address);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 727e2ef66aa4..14658b41c9bc 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -283,6 +283,9 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (!indio_dev->info->write_event_config)
+		return -EINVAL;
+
 	ret = indio_dev->info->write_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), val);
@@ -298,6 +301,9 @@ static ssize_t iio_ev_state_show(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val;
 
+	if (!indio_dev->info->read_event_config)
+		return -EINVAL;
+
 	val = indio_dev->info->read_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr));
@@ -316,6 +322,9 @@ static ssize_t iio_ev_value_show(struct device *dev,
 	int val, val2, val_arr[2];
 	int ret;
 
+	if (!indio_dev->info->read_event_value)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_event_value(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 872fd5c24147..bd854e92c6f8 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -561,6 +561,7 @@ EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
 static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 			    enum iio_chan_info_enum info)
 {
+	const struct iio_info *iio_info = chan->indio_dev->info;
 	int unused;
 	int vals[INDIO_MAX_RAW_ELEMENTS];
 	int ret;
@@ -572,15 +573,18 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 	if (!iio_channel_has_info(chan->channel, info))
 		return -EINVAL;
 
-	if (chan->indio_dev->info->read_raw_multi) {
-		ret = chan->indio_dev->info->read_raw_multi(chan->indio_dev,
-					chan->channel, INDIO_MAX_RAW_ELEMENTS,
-					vals, &val_len, info);
+	if (iio_info->read_raw_multi) {
+		ret = iio_info->read_raw_multi(chan->indio_dev,
+					       chan->channel,
+					       INDIO_MAX_RAW_ELEMENTS,
+					       vals, &val_len, info);
 		*val = vals[0];
 		*val2 = vals[1];
+	} else if (iio_info->read_raw) {
+		ret = iio_info->read_raw(chan->indio_dev,
+					 chan->channel, val, val2, info);
 	} else {
-		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
-					chan->channel, val, val2, info);
+		return -EINVAL;
 	}
 
 	return ret;
@@ -800,11 +804,15 @@ static int iio_channel_read_avail(struct iio_channel *chan,
 				  const int **vals, int *type, int *length,
 				  enum iio_chan_info_enum info)
 {
+	const struct iio_info *iio_info = chan->indio_dev->info;
+
 	if (!iio_channel_has_available(chan->channel, info))
 		return -EINVAL;
 
-	return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
-						 vals, type, length, info);
+	if (iio_info->read_avail)
+		return iio_info->read_avail(chan->indio_dev, chan->channel,
+					    vals, type, length, info);
+	return -EINVAL;
 }
 
 int iio_read_avail_channel_attribute(struct iio_channel *chan,
@@ -935,8 +943,12 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
 static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 			     enum iio_chan_info_enum info)
 {
-	return chan->indio_dev->info->write_raw(chan->indio_dev,
-						chan->channel, val, val2, info);
+	const struct iio_info *iio_info = chan->indio_dev->info;
+
+	if (iio_info->write_raw)
+		return iio_info->write_raw(chan->indio_dev,
+					   chan->channel, val, val2, info);
+	return -EINVAL;
 }
 
 int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 16a24a05fc2a..bafd210dd43e 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -406,8 +406,8 @@ static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com_admin_queue
 	return comp_ctx;
 }
 
-static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq,
-						   struct efa_admin_acq_entry *cqe)
+static int efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq,
+						  struct efa_admin_acq_entry *cqe)
 {
 	struct efa_comp_ctx *comp_ctx;
 	u16 cmd_id;
@@ -416,11 +416,11 @@ static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *a
 			 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
 
 	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, false);
-	if (!comp_ctx) {
+	if (comp_ctx->status != EFA_CMD_SUBMITTED) {
 		ibdev_err(aq->efa_dev,
-			  "comp_ctx is NULL. Changing the admin queue running state\n");
-		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
-		return;
+			  "Received completion with unexpected command id[%d], sq producer: %d, sq consumer: %d, cq consumer: %d\n",
+			  cmd_id, aq->sq.pc, aq->sq.cc, aq->cq.cc);
+		return -EINVAL;
 	}
 
 	comp_ctx->status = EFA_CMD_COMPLETED;
@@ -428,14 +428,17 @@ static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *a
 
 	if (!test_bit(EFA_AQ_STATE_POLLING_BIT, &aq->state))
 		complete(&comp_ctx->wait_event);
+
+	return 0;
 }
 
 static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
 {
 	struct efa_admin_acq_entry *cqe;
 	u16 queue_size_mask;
-	u16 comp_num = 0;
+	u16 comp_cmds = 0;
 	u8 phase;
+	int err;
 	u16 ci;
 
 	queue_size_mask = aq->depth - 1;
@@ -453,10 +456,12 @@ static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
 		 * phase bit was validated
 		 */
 		dma_rmb();
-		efa_com_handle_single_admin_completion(aq, cqe);
+		err = efa_com_handle_single_admin_completion(aq, cqe);
+		if (!err)
+			comp_cmds++;
 
+		aq->cq.cc++;
 		ci++;
-		comp_num++;
 		if (ci == aq->depth) {
 			ci = 0;
 			phase = !phase;
@@ -465,10 +470,9 @@ static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
 		cqe = &aq->cq.entries[ci];
 	}
 
-	aq->cq.cc += comp_num;
 	aq->cq.phase = phase;
-	aq->sq.cc += comp_num;
-	atomic64_add(comp_num, &aq->stats.completed_cmd);
+	aq->sq.cc += comp_cmds;
+	atomic64_add(comp_cmds, &aq->stats.completed_cmd);
 }
 
 static int efa_com_comp_status_to_errno(u8 comp_status)
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 191db831d760..004511d918c6 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -666,16 +666,26 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 		goto error;
 	}
 
-	size = nformats * sizeof(*format) + nframes * sizeof(*frame)
+	/*
+	 * Allocate memory for the formats, the frames and the intervals,
+	 * plus any required padding to guarantee that everything has the
+	 * correct alignment.
+	 */
+	size = nformats * sizeof(*format);
+	size = ALIGN(size, __alignof__(*frame)) + nframes * sizeof(*frame);
+	size = ALIGN(size, __alignof__(*interval))
 	     + nintervals * sizeof(*interval);
+
 	format = kzalloc(size, GFP_KERNEL);
-	if (format == NULL) {
+	if (!format) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	frame = (struct uvc_frame *)&format[nformats];
-	interval = (u32 *)&frame[nframes];
+	frame = (void *)format + nformats * sizeof(*format);
+	frame = PTR_ALIGN(frame, __alignof__(*frame));
+	interval = (void *)frame + nframes * sizeof(*frame);
+	interval = PTR_ALIGN(interval, __alignof__(*interval));
 
 	streaming->format = format;
 	streaming->nformats = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 97d1cfec4ec0..ccddfa49e96c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2141,7 +2141,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	if (flush)
 		mlx5e_shampo_flush_skb(rq, cqe, match);
 free_hd_entry:
-	mlx5e_free_rx_shampo_hd_entry(rq, header_index);
+	if (likely(head_size))
+		mlx5e_free_rx_shampo_hd_entry(rq, header_index);
 mpwrq_cqe_out:
 	if (likely(wi->consumed_strides < rq->mpwqe.num_strides))
 		return;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index d34aea85f8a6..14865fc245da 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -230,7 +230,7 @@ static int ionic_request_irq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 		name = dev_name(dev);
 
 	snprintf(intr->name, sizeof(intr->name),
-		 "%s-%s-%s", IONIC_DRV_NAME, name, q->name);
+		 "%.5s-%.16s-%.8s", IONIC_DRV_NAME, name, q->name);
 
 	return devm_request_irq(dev, intr->vector, ionic_isr,
 				0, intr->name, &qcq->napi);
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index ee0ea3d0f50e..72a2c41b9dbf 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1436,6 +1436,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
 	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
+	{QMI_FIXED_INTF(0x2dee, 0x4d22, 5)},    /* MeiG Smart SRM825L */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61cc0ed1ddc1..e3e5107adaca 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1638,7 +1638,7 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 		return false;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -1656,7 +1656,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit_skbs(sq, true);
+			free_old_xmit_skbs(sq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
@@ -1675,7 +1675,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -1778,7 +1778,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 01b02c03fa89..764cd320c6c1 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2293,7 +2293,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 	struct qmi_txn txn;
 	const u8 *temp = data;
 	void __iomem *bdf_addr = NULL;
-	int ret;
+	int ret = 0;
 	u32 remaining = len;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 7d4340c56628..51bb54485351 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -252,8 +252,7 @@ static ssize_t iwl_dbgfs_send_hcmd_write(struct iwl_fw_runtime *fwrt, char *buf,
 		.data = { NULL, },
 	};
 
-	if (fwrt->ops && fwrt->ops->fw_running &&
-	    !fwrt->ops->fw_running(fwrt->ops_ctx))
+	if (!iwl_trans_fw_running(fwrt->trans))
 		return -EIO;
 
 	if (count < header_size + 1 || count > 1024 * 4)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index d3cb1ae68a96..7b7bf3aecc14 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -18,7 +18,6 @@
 struct iwl_fw_runtime_ops {
 	void (*dump_start)(void *ctx);
 	void (*dump_end)(void *ctx);
-	bool (*fw_running)(void *ctx);
 	int (*send_hcmd)(void *ctx, struct iwl_host_cmd *host_cmd);
 	bool (*d3_debug_enable)(void *ctx);
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 864f5fb26040..88b6d4e566c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -670,11 +670,6 @@ static void iwl_mvm_fwrt_dump_end(void *ctx)
 	mutex_unlock(&mvm->mutex);
 }
 
-static bool iwl_mvm_fwrt_fw_running(void *ctx)
-{
-	return iwl_mvm_firmware_running(ctx);
-}
-
 static int iwl_mvm_fwrt_send_hcmd(void *ctx, struct iwl_host_cmd *host_cmd)
 {
 	struct iwl_mvm *mvm = (struct iwl_mvm *)ctx;
@@ -695,7 +690,6 @@ static bool iwl_mvm_d3_debug_enable(void *ctx)
 static const struct iwl_fw_runtime_ops iwl_mvm_fwrt_ops = {
 	.dump_start = iwl_mvm_fwrt_dump_start,
 	.dump_end = iwl_mvm_fwrt_dump_end,
-	.fw_running = iwl_mvm_fwrt_fw_running,
 	.send_hcmd = iwl_mvm_fwrt_send_hcmd,
 	.d3_debug_enable = iwl_mvm_d3_debug_enable,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index c1a4bc1c64d1..afb1b41e1a9a 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -304,9 +304,13 @@ static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 static void ser_sta_deinit_cam_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)data;
-	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_vif *target_rtwvif = (struct rtw89_vif *)data;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+
+	if (rtwvif != target_rtwvif)
+		return;
 
 	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE || sta->tdls)
 		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index b8cb77c9c4bd..3132b27bc006 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -242,18 +242,24 @@ static struct pci_ops al_child_pci_ops = {
 	.write = pci_generic_config_write,
 };
 
-static void al_pcie_config_prepare(struct al_pcie *pcie)
+static int al_pcie_config_prepare(struct al_pcie *pcie)
 {
 	struct al_pcie_target_bus_cfg *target_bus_cfg;
 	struct dw_pcie_rp *pp = &pcie->pci->pp;
 	unsigned int ecam_bus_mask;
+	struct resource_entry *ft;
 	u32 cfg_control_offset;
+	struct resource *bus;
 	u8 subordinate_bus;
 	u8 secondary_bus;
 	u32 cfg_control;
 	u32 reg;
-	struct resource *bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
 
+	ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+	if (!ft)
+		return -ENODEV;
+
+	bus = ft->res;
 	target_bus_cfg = &pcie->target_bus_cfg;
 
 	ecam_bus_mask = (pcie->ecam_size >> PCIE_ECAM_BUS_SHIFT) - 1;
@@ -287,6 +293,8 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 	       FIELD_PREP(CFG_CONTROL_SEC_BUS_MASK, secondary_bus);
 
 	al_pcie_controller_writel(pcie, cfg_control_offset, reg);
+
+	return 0;
 }
 
 static int al_pcie_host_init(struct dw_pcie_rp *pp)
@@ -305,7 +313,9 @@ static int al_pcie_host_init(struct dw_pcie_rp *pp)
 	if (rc)
 		return rc;
 
-	al_pcie_config_prepare(pcie);
+	rc = al_pcie_config_prepare(pcie);
+	if (rc)
+		return rc;
 
 	return 0;
 }
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index fdd2ec09651e..c5cc3e453fd0 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -431,7 +431,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks = NULL;
-	struct msi_desc *entry;
+	struct msi_desc *entry, desc;
 	int ret;
 
 	/*
@@ -452,6 +452,12 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	/* All MSIs are unmasked by default; mask them all */
 	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
 	pci_msi_mask(entry, msi_multi_mask(entry));
+	/*
+	 * Copy the MSI descriptor for the error path because
+	 * pci_msi_setup_msi_irqs() will free it for the hierarchical
+	 * interrupt domain case.
+	 */
+	memcpy(&desc, entry, sizeof(desc));
 
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
@@ -471,7 +477,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	goto unlock;
 
 err:
-	pci_msi_unmask(entry, msi_multi_mask(entry));
+	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	free_msi_irqs(dev);
 fail:
 	dev->msi_enabled = 0;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bfed5d36fa2e..d528ee0092bd 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6307,7 +6307,8 @@ static void ufshcd_err_handler(struct work_struct *work)
 	if (ufshcd_err_handling_should_stop(hba))
 		goto skip_err_handling;
 
-	if (hba->dev_quirks & UFS_DEVICE_QUIRK_RECOVERY_FROM_DL_NAC_ERRORS) {
+	if ((hba->dev_quirks & UFS_DEVICE_QUIRK_RECOVERY_FROM_DL_NAC_ERRORS) &&
+	    !hba->force_reset) {
 		bool ret;
 
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index dbb10cb310d4..4a1a86e37fd5 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -373,7 +373,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return typec_port_register_altmode(con->port, desc);
 }
 
 static inline void
diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index fc01b31bbb87..6338d818bc8b 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -144,53 +144,62 @@ static int tweak_set_configuration_cmd(struct urb *urb)
 	if (err && err != -ENODEV)
 		dev_err(&sdev->udev->dev, "can't set config #%d, error %d\n",
 			config, err);
-	return 0;
+	return err;
 }
 
 static int tweak_reset_device_cmd(struct urb *urb)
 {
 	struct stub_priv *priv = (struct stub_priv *) urb->context;
 	struct stub_device *sdev = priv->sdev;
+	int err;
 
 	dev_info(&urb->dev->dev, "usb_queue_reset_device\n");
 
-	if (usb_lock_device_for_reset(sdev->udev, NULL) < 0) {
+	err = usb_lock_device_for_reset(sdev->udev, NULL);
+	if (err < 0) {
 		dev_err(&urb->dev->dev, "could not obtain lock to reset device\n");
-		return 0;
+		return err;
 	}
-	usb_reset_device(sdev->udev);
+	err = usb_reset_device(sdev->udev);
 	usb_unlock_device(sdev->udev);
 
-	return 0;
+	return err;
 }
 
 /*
  * clear_halt, set_interface, and set_configuration require special tricks.
+ * Returns 1 if request was tweaked, 0 otherwise.
  */
-static void tweak_special_requests(struct urb *urb)
+static int tweak_special_requests(struct urb *urb)
 {
+	int err;
+
 	if (!urb || !urb->setup_packet)
-		return;
+		return 0;
 
 	if (usb_pipetype(urb->pipe) != PIPE_CONTROL)
-		return;
+		return 0;
 
 	if (is_clear_halt_cmd(urb))
 		/* tweak clear_halt */
-		 tweak_clear_halt_cmd(urb);
+		err = tweak_clear_halt_cmd(urb);
 
 	else if (is_set_interface_cmd(urb))
 		/* tweak set_interface */
-		tweak_set_interface_cmd(urb);
+		err = tweak_set_interface_cmd(urb);
 
 	else if (is_set_configuration_cmd(urb))
 		/* tweak set_configuration */
-		tweak_set_configuration_cmd(urb);
+		err = tweak_set_configuration_cmd(urb);
 
 	else if (is_reset_device_cmd(urb))
-		tweak_reset_device_cmd(urb);
-	else
+		err = tweak_reset_device_cmd(urb);
+	else {
 		usbip_dbg_stub_rx("no need to tweak\n");
+		return 0;
+	}
+
+	return !err;
 }
 
 /*
@@ -468,6 +477,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	int support_sg = 1;
 	int np = 0;
 	int ret, i;
+	int is_tweaked;
 
 	if (pipe == -1)
 		return;
@@ -580,8 +590,11 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 		priv->urbs[i]->pipe = pipe;
 		priv->urbs[i]->complete = stub_complete;
 
-		/* no need to submit an intercepted request, but harmless? */
-		tweak_special_requests(priv->urbs[i]);
+		/*
+		 * all URBs belong to a single PDU, so a global is_tweaked flag is
+		 * enough
+		 */
+		is_tweaked = tweak_special_requests(priv->urbs[i]);
 
 		masking_bogus_flags(priv->urbs[i]);
 	}
@@ -594,22 +607,32 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 
 	/* urb is now ready to submit */
 	for (i = 0; i < priv->num_urbs; i++) {
-		ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
+		if (!is_tweaked) {
+			ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
 
-		if (ret == 0)
-			usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
-					pdu->base.seqnum);
-		else {
-			dev_err(&udev->dev, "submit_urb error, %d\n", ret);
-			usbip_dump_header(pdu);
-			usbip_dump_urb(priv->urbs[i]);
+			if (ret == 0)
+				usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
+						pdu->base.seqnum);
+			else {
+				dev_err(&udev->dev, "submit_urb error, %d\n", ret);
+				usbip_dump_header(pdu);
+				usbip_dump_urb(priv->urbs[i]);
 
+				/*
+				 * Pessimistic.
+				 * This connection will be discarded.
+				 */
+				usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
+				break;
+			}
+		} else {
 			/*
-			 * Pessimistic.
-			 * This connection will be discarded.
+			 * An identical URB was already submitted in
+			 * tweak_special_requests(). Skip submitting this URB to not
+			 * duplicate the request.
 			 */
-			usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
-			break;
+			priv->urbs[i]->status = 0;
+			stub_complete(priv->urbs[i]);
 		}
 	}
 
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92b540754799..e8ee1ccd9a11 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3229,7 +3229,7 @@ static int ext4_split_extent_at(handle_t *handle,
 		ext4_ext_mark_unwritten(ex2);
 
 	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-	if (err != -ENOSPC && err != -EDQUOT)
+	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
 		goto out;
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 93a1c22048de..7aa0a8873398 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5101,9 +5101,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 				 "iget: bogus i_mode (%o)", inode->i_mode);
 		goto bad_inode;
 	}
-	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
+	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb)) {
 		ext4_error_inode(inode, function, line, 0,
 				 "casefold flag without casefold feature");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
 	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
 		ext4_error_inode(inode, function, line, 0, err_str);
 		ret = -EFSCORRUPTED;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index d0302b66c215..d9d9650a7281 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -484,6 +484,13 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			/* A hole? We can safely clear the dirty bit */
 			if (!buffer_mapped(bh))
 				clear_buffer_dirty(bh);
+			/*
+			 * Keeping dirty some buffer we cannot write? Make
+			 * sure to redirty the page. This happens e.g. when
+			 * doing writeout for transaction commit.
+			 */
+			if (buffer_dirty(bh) && !PageDirty(page))
+				redirty_page_for_writepage(wbc, page);
 			if (io->io_bio)
 				ext4_io_submit(io);
 			continue;
@@ -491,6 +498,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		if (buffer_new(bh))
 			clear_buffer_new(bh);
 		set_buffer_async_write(bh);
+		clear_buffer_dirty(bh);
 		nr_to_submit++;
 	} while ((bh = bh->b_this_page) != head);
 
@@ -534,7 +542,10 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
 			redirty_page_for_writepage(wbc, page);
 			do {
-				clear_buffer_async_write(bh);
+				if (buffer_async_write(bh)) {
+					clear_buffer_async_write(bh);
+					set_buffer_dirty(bh);
+				}
 				bh = bh->b_this_page;
 			} while (bh != head);
 			goto unlock;
@@ -547,7 +558,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 			continue;
 		io_submit_add_bh(io, inode, page, bounce_page, bh);
 		nr_submitted++;
-		clear_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
 
 unlock:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a02c74875316..2b540d87859e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -788,6 +788,7 @@ enum {
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
 	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
+	FI_OPENED_FILE,         /* indicate file has been opened */
 	FI_MAX,			/* max flag, never be used */
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c6fb179f9d4a..62f2521cd955 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -538,6 +538,42 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int finish_preallocate_blocks(struct inode *inode)
+{
+	int ret;
+
+	inode_lock(inode);
+	if (is_inode_flag_set(inode, FI_OPENED_FILE)) {
+		inode_unlock(inode);
+		return 0;
+	}
+
+	if (!file_should_truncate(inode)) {
+		set_inode_flag(inode, FI_OPENED_FILE);
+		inode_unlock(inode);
+		return 0;
+	}
+
+	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	filemap_invalidate_lock(inode->i_mapping);
+
+	truncate_setsize(inode, i_size_read(inode));
+	ret = f2fs_truncate(inode);
+
+	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+
+	if (!ret)
+		set_inode_flag(inode, FI_OPENED_FILE);
+
+	inode_unlock(inode);
+	if (ret)
+		return ret;
+
+	file_dont_truncate(inode);
+	return 0;
+}
+
 static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
 	int err = fscrypt_file_open(inode, filp);
@@ -554,7 +590,11 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 
 	filp->f_mode |= FMODE_NOWAIT;
 
-	return dquot_file_open(inode, filp);
+	err = dquot_file_open(inode, filp);
+	if (err)
+		return err;
+
+	return finish_preallocate_blocks(inode);
 }
 
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ff4a4e92a40c..5b672df194a9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -549,14 +549,6 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	}
 	f2fs_set_inode_flags(inode);
 
-	if (file_should_truncate(inode) &&
-			!is_sbi_flag_set(sbi, SBI_POR_DOING)) {
-		ret = f2fs_truncate(inode);
-		if (ret)
-			goto bad_inode;
-		file_dont_truncate(inode);
-	}
-
 	unlock_new_inode(inode);
 	trace_f2fs_iget(inode);
 	return inode;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7974e91ffe13..b5d8f238fce4 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -103,17 +103,13 @@ void fsnotify_sb_delete(struct super_block *sb)
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
  */
-void __fsnotify_update_child_dentry_flags(struct inode *inode)
+void fsnotify_set_children_dentry_flags(struct inode *inode)
 {
 	struct dentry *alias;
-	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
 
-	/* determine if the children should tell inode about their events */
-	watched = fsnotify_inode_watches_children(inode);
-
 	spin_lock(&inode->i_lock);
 	/* run all of the dentries associated with this inode.  Since this is a
 	 * directory, there damn well better only be one item on this list */
@@ -129,10 +125,7 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 				continue;
 
 			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
-			if (watched)
-				child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-			else
-				child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
 			spin_unlock(&child->d_lock);
 		}
 		spin_unlock(&alias->d_lock);
@@ -140,6 +133,24 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
+/*
+ * Lazily clear false positive PARENT_WATCHED flag for child whose parent had
+ * stopped watching children.
+ */
+static void fsnotify_clear_child_dentry_flag(struct inode *pinode,
+					     struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	/*
+	 * d_lock is a sufficient barrier to prevent observing a non-watched
+	 * parent state from before the fsnotify_set_children_dentry_flags()
+	 * or fsnotify_update_flags() call that had set PARENT_WATCHED.
+	 */
+	if (!fsnotify_inode_watches_children(pinode))
+		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+	spin_unlock(&dentry->d_lock);
+}
+
 /* Are inode/sb/mount interested in parent and name info with this event? */
 static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
 					__u32 mask)
@@ -208,7 +219,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	p_inode = parent->d_inode;
 	p_mask = fsnotify_inode_watches_children(p_inode);
 	if (unlikely(parent_watched && !p_mask))
-		__fsnotify_update_child_dentry_flags(p_inode);
+		fsnotify_clear_child_dentry_flag(p_inode, dentry);
 
 	/*
 	 * Include parent/name in notification either if some notification
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index fde74eb333cc..2b4267de86e6 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -74,7 +74,7 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
  */
-extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
+extern void fsnotify_set_children_dentry_flags(struct inode *inode);
 
 extern struct kmem_cache *fsnotify_mark_connector_cachep;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c74ef947447d..4be6e883d492 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -176,6 +176,24 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	return fsnotify_update_iref(conn, want_iref);
 }
 
+static bool fsnotify_conn_watches_children(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return false;
+
+	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
+}
+
+static void fsnotify_conn_set_children_dentry_flags(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return;
+
+	fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
+}
+
 /*
  * Calculate mask of events for a list of marks. The caller must make sure
  * connector and connector->obj cannot disappear under us.  Callers achieve
@@ -184,15 +202,23 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
  */
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
+	bool update_children;
+
 	if (!conn)
 		return;
 
 	spin_lock(&conn->lock);
+	update_children = !fsnotify_conn_watches_children(conn);
 	__fsnotify_recalc_mask(conn);
+	update_children &= fsnotify_conn_watches_children(conn);
 	spin_unlock(&conn->lock);
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
-		__fsnotify_update_child_dentry_flags(
-					fsnotify_conn_inode(conn));
+	/*
+	 * Set children's PARENT_WATCHED flags only if parent started watching.
+	 * When parent stops watching, we clear false positive PARENT_WATCHED
+	 * flags lazily in __fsnotify_parent().
+	 */
+	if (update_children)
+		fsnotify_conn_set_children_dentry_flags(conn);
 }
 
 /* Free all connectors queued for freeing once SRCU period ends */
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 65fbc60a88e4..3b6419f29a4c 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -86,6 +86,13 @@ enum {
 #define UDF_MAX_LVID_NESTING 1000
 
 enum { UDF_MAX_LINKS = 0xffff };
+/*
+ * We limit filesize to 4TB. This is arbitrary as the on-disk format supports
+ * more but because the file space is described by a linked list of extents,
+ * each of which can have at most 1GB, the creation and handling of extents
+ * gets unusably slow beyond certain point...
+ */
+#define UDF_MAX_FILESIZE (1ULL << 42)
 
 /* These are the "meat" - everything else is stuffing */
 static int udf_fill_super(struct super_block *, void *, int);
@@ -2299,7 +2306,7 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 		ret = -ENOMEM;
 		goto error_out;
 	}
-	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_maxbytes = UDF_MAX_FILESIZE;
 	sb->s_max_links = UDF_MAX_LINKS;
 	return 0;
 
diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
index c0f56fe6d22a..d116f18de899 100644
--- a/include/clocksource/timer-xilinx.h
+++ b/include/clocksource/timer-xilinx.h
@@ -41,7 +41,7 @@ struct regmap;
 struct xilinx_timer_priv {
 	struct regmap *map;
 	struct clk *clk;
-	u32 max;
+	u64 max;
 };
 
 /**
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d7d96c806bff..096b79e4373f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -563,12 +563,14 @@ static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
 
 static inline int fsnotify_inode_watches_children(struct inode *inode)
 {
+	__u32 parent_mask = READ_ONCE(inode->i_fsnotify_mask);
+
 	/* FS_EVENT_ON_CHILD is set if the inode may care */
-	if (!(inode->i_fsnotify_mask & FS_EVENT_ON_CHILD))
+	if (!(parent_mask & FS_EVENT_ON_CHILD))
 		return 0;
 	/* this inode might care about child events, does it care about the
 	 * specific set of events that can happen on a child? */
-	return inode->i_fsnotify_mask & FS_EVENTS_POSS_ON_CHILD;
+	return parent_mask & FS_EVENTS_POSS_ON_CHILD;
 }
 
 /*
@@ -582,7 +584,7 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 	/*
 	 * Serialisation of setting PARENT_WATCHED on the dentries is provided
 	 * by d_lock. If inotify_inode_watched changes after we have taken
-	 * d_lock, the following __fsnotify_update_child_dentry_flags call will
+	 * d_lock, the following fsnotify_set_children_dentry_flags call will
 	 * find our entry, so it will spin until we complete here, and update
 	 * us with the new state.
 	 */
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index bfe7c1f1ac6d..f0231dbc4777 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -68,6 +68,7 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
 int __hwspin_trylock(struct hwspinlock *, int, unsigned long *);
 void __hwspin_unlock(struct hwspinlock *, int, unsigned long *);
 int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name);
+int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id);
 int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock);
 struct hwspinlock *devm_hwspin_lock_request(struct device *dev);
 struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
@@ -127,6 +128,11 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 {
 }
 
+static inline int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id)
+{
+	return 0;
+}
+
 static inline int of_hwspin_lock_get_id(struct device_node *np, int index)
 {
 	return 0;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index cfc59c3371cb..35e296d9e1c5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -1035,7 +1035,7 @@ static inline int of_i2c_get_board_info(struct device *dev,
 struct acpi_resource;
 struct acpi_resource_i2c_serialbus;
 
-#if IS_ENABLED(CONFIG_ACPI)
+#if IS_REACHABLE(CONFIG_ACPI) && IS_REACHABLE(CONFIG_I2C)
 bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
 			       struct acpi_resource_i2c_serialbus **i2c);
 int i2c_acpi_client_count(struct acpi_device *adev);
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 3ff7089d11a9..de02c0808fb8 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -445,8 +445,11 @@ void debug_dma_dump_mappings(struct device *dev)
  * dma_active_cacheline entry to track per event.  dma_map_sg(), on the
  * other hand, consumes a single dma_debug_entry, but inserts 'nents'
  * entries into the tree.
+ *
+ * Use __GFP_NOWARN because the printk from an OOM, to netconsole, could end
+ * up right back in the DMA debugging code, leading to a deadlock.
  */
-static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC);
+static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC | __GFP_NOWARN);
 static DEFINE_SPINLOCK(radix_lock);
 #define ACTIVE_CACHELINE_MAX_OVERLAP ((1 << RADIX_TREE_MAX_TAGS) - 1)
 #define CACHELINE_PER_PAGE_SHIFT (PAGE_SHIFT - L1_CACHE_SHIFT)
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7b702220d81c..aa16d3cd62ba 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -207,7 +207,6 @@ struct rcu_data {
 	struct swait_queue_head nocb_state_wq; /* For offloading state changes */
 	struct task_struct *nocb_gp_kthread;
 	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
-	atomic_t nocb_lock_contended;	/* Contention experienced. */
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0a5f0ef41484..6499eefa0660 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -91,8 +91,7 @@ module_param(nocb_nobypass_lim_per_jiffy, int, 0);
 
 /*
  * Acquire the specified rcu_data structure's ->nocb_bypass_lock.  If the
- * lock isn't immediately available, increment ->nocb_lock_contended to
- * flag the contention.
+ * lock isn't immediately available, perform minimal sanity check.
  */
 static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
 	__acquires(&rdp->nocb_bypass_lock)
@@ -100,29 +99,12 @@ static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
 	lockdep_assert_irqs_disabled();
 	if (raw_spin_trylock(&rdp->nocb_bypass_lock))
 		return;
-	atomic_inc(&rdp->nocb_lock_contended);
+	/*
+	 * Contention expected only when local enqueue collide with
+	 * remote flush from kthreads.
+	 */
 	WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
-	smp_mb__after_atomic(); /* atomic_inc() before lock. */
 	raw_spin_lock(&rdp->nocb_bypass_lock);
-	smp_mb__before_atomic(); /* atomic_dec() after lock. */
-	atomic_dec(&rdp->nocb_lock_contended);
-}
-
-/*
- * Spinwait until the specified rcu_data structure's ->nocb_lock is
- * not contended.  Please note that this is extremely special-purpose,
- * relying on the fact that at most two kthreads and one CPU contend for
- * this lock, and also that the two kthreads are guaranteed to have frequent
- * grace-period-duration time intervals between successive acquisitions
- * of the lock.  This allows us to use an extremely simple throttling
- * mechanism, and further to apply it only to the CPU doing floods of
- * call_rcu() invocations.  Don't try this at home!
- */
-static void rcu_nocb_wait_contended(struct rcu_data *rdp)
-{
-	WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
-	while (WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended)))
-		cpu_relax();
 }
 
 /*
@@ -452,7 +434,6 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	}
 
 	// We need to use the bypass.
-	rcu_nocb_wait_contended(rdp);
 	rcu_nocb_bypass_lock(rdp);
 	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
@@ -1476,12 +1457,11 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 
 	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
 	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
-	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
+	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
 		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
 		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
-		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
 		"lL"[raw_spin_is_locked(&rdp->nocb_lock)],
 		"sS"[!!rdp->nocb_cb_sleep],
 		".W"[swait_active(&rdp->nocb_cb_wq)],
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index a3bbe04b1138..92ea01f9def3 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -130,8 +130,11 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	struct hci_dev *hdev = hcon->hdev;
 	struct sco_conn *conn = hcon->sco_data;
 
-	if (conn)
+	if (conn) {
+		if (!conn->hcon)
+			conn->hcon = hcon;
 		return conn;
+	}
 
 	conn = kzalloc(sizeof(struct sco_conn), GFP_KERNEL);
 	if (!conn)
@@ -239,40 +242,56 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	return err;
 }
 
-static int sco_connect(struct hci_dev *hdev, struct sock *sk)
+static int sco_connect(struct sock *sk)
 {
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
+	struct hci_dev  *hdev;
 	int err, type;
 
 	BT_DBG("%pMR -> %pMR", &sco_pi(sk)->src, &sco_pi(sk)->dst);
 
+	hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+	if (!hdev)
+		return -EHOSTUNREACH;
+
+	hci_dev_lock(hdev);
+
 	if (lmp_esco_capable(hdev) && !disable_esco)
 		type = ESCO_LINK;
 	else
 		type = SCO_LINK;
 
 	if (sco_pi(sk)->setting == BT_VOICE_TRANSPARENT &&
-	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev)))
-		return -EOPNOTSUPP;
+	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
 			       sco_pi(sk)->setting, &sco_pi(sk)->codec);
-	if (IS_ERR(hcon))
-		return PTR_ERR(hcon);
+	if (IS_ERR(hcon)) {
+		err = PTR_ERR(hcon);
+		goto unlock;
+	}
 
 	conn = sco_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto unlock;
 	}
 
-	/* Update source addr of the socket */
-	bacpy(&sco_pi(sk)->src, &hcon->src);
+	lock_sock(sk);
 
 	err = sco_chan_add(conn, sk, NULL);
-	if (err)
-		return err;
+	if (err) {
+		release_sock(sk);
+		goto unlock;
+	}
+
+	/* Update source addr of the socket */
+	bacpy(&sco_pi(sk)->src, &hcon->src);
 
 	if (hcon->state == BT_CONNECTED) {
 		sco_sock_clear_timer(sk);
@@ -282,6 +301,11 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 		sco_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
+	release_sock(sk);
+
+unlock:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 	return err;
 }
 
@@ -561,7 +585,6 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
-	struct hci_dev  *hdev;
 	int err;
 
 	BT_DBG("sk %p", sk);
@@ -570,37 +593,26 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	lock_sock(sk);
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
-		err = -EBADFD;
-		goto done;
-	}
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
+		return -EBADFD;
 
-	if (sk->sk_type != SOCK_SEQPACKET) {
+	if (sk->sk_type != SOCK_SEQPACKET)
 		err = -EINVAL;
-		goto done;
-	}
-
-	hdev = hci_get_route(&sa->sco_bdaddr, &sco_pi(sk)->src, BDADDR_BREDR);
-	if (!hdev) {
-		err = -EHOSTUNREACH;
-		goto done;
-	}
-	hci_dev_lock(hdev);
 
+	lock_sock(sk);
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
+	release_sock(sk);
 
-	err = sco_connect(hdev, sk);
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	err = sco_connect(sk);
 	if (err)
-		goto done;
+		return err;
+
+	lock_sock(sk);
 
 	err = bt_sock_wait_state(sk, BT_CONNECTED,
 				 sock_sndtimeo(sk, flags & O_NONBLOCK));
 
-done:
 	release_sock(sk);
 	return err;
 }
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d469ad6c6a0b..517bbfe5f626 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -112,7 +112,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 			ptr += 2;
 		}
-		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u",
+		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",
 			 version, flags, opsize, mp_opt->sndr_key,
 			 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);
 		break;
@@ -126,7 +126,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 4;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->token, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_SYNACK) {
@@ -137,19 +137,19 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 8;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, thmac=%llu, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->thmac, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_ACK) {
 			mp_opt->suboptions |= OPTION_MPTCP_MPJ_ACK;
 			ptr += 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
-			pr_debug("MP_JOIN hmac");
+			pr_debug("MP_JOIN hmac\n");
 		}
 		break;
 
 	case MPTCPOPT_DSS:
-		pr_debug("DSS");
+		pr_debug("DSS\n");
 		ptr++;
 
 		/* we must clear 'mpc_map' be able to detect MP_CAPABLE
@@ -164,7 +164,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d",
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
 			 mp_opt->data_fin, mp_opt->dsn64,
 			 mp_opt->use_map, mp_opt->ack64,
 			 mp_opt->use_ack);
@@ -202,7 +202,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				ptr += 4;
 			}
 
-			pr_debug("data_ack=%llu", mp_opt->data_ack);
+			pr_debug("data_ack=%llu\n", mp_opt->data_ack);
 		}
 
 		if (mp_opt->use_map) {
@@ -226,7 +226,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				ptr += 2;
 			}
 
-			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
+			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
 				 mp_opt->data_len, !!(mp_opt->suboptions & OPTION_MPTCP_CSUMREQD),
 				 mp_opt->csum);
@@ -288,7 +288,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->ahmac = get_unaligned_be64(ptr);
 			ptr += 8;
 		}
-		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d",
+		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d\n",
 			 (mp_opt->addr.family == AF_INET6) ? "6" : "",
 			 mp_opt->addr.id, mp_opt->ahmac, mp_opt->echo, ntohs(mp_opt->addr.port));
 		break;
@@ -304,7 +304,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->rm_list.nr = opsize - TCPOLEN_MPTCP_RM_ADDR_BASE;
 		for (i = 0; i < mp_opt->rm_list.nr; i++)
 			mp_opt->rm_list.ids[i] = *ptr++;
-		pr_debug("RM_ADDR: rm_list_nr=%d", mp_opt->rm_list.nr);
+		pr_debug("RM_ADDR: rm_list_nr=%d\n", mp_opt->rm_list.nr);
 		break;
 
 	case MPTCPOPT_MP_PRIO:
@@ -313,7 +313,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->suboptions |= OPTION_MPTCP_PRIO;
 		mp_opt->backup = *ptr++ & MPTCP_PRIO_BKUP;
-		pr_debug("MP_PRIO: prio=%d", mp_opt->backup);
+		pr_debug("MP_PRIO: prio=%d\n", mp_opt->backup);
 		break;
 
 	case MPTCPOPT_MP_FASTCLOSE:
@@ -324,7 +324,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->rcvr_key = get_unaligned_be64(ptr);
 		ptr += 8;
 		mp_opt->suboptions |= OPTION_MPTCP_FASTCLOSE;
-		pr_debug("MP_FASTCLOSE: recv_key=%llu", mp_opt->rcvr_key);
+		pr_debug("MP_FASTCLOSE: recv_key=%llu\n", mp_opt->rcvr_key);
 		break;
 
 	case MPTCPOPT_RST:
@@ -338,7 +338,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		flags = *ptr++;
 		mp_opt->reset_transient = flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason = *ptr;
-		pr_debug("MP_RST: transient=%u reason=%u",
+		pr_debug("MP_RST: transient=%u reason=%u\n",
 			 mp_opt->reset_transient, mp_opt->reset_reason);
 		break;
 
@@ -349,7 +349,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr += 2;
 		mp_opt->suboptions |= OPTION_MPTCP_FAIL;
 		mp_opt->fail_seq = get_unaligned_be64(ptr);
-		pr_debug("MP_FAIL: data_seq=%llu", mp_opt->fail_seq);
+		pr_debug("MP_FAIL: data_seq=%llu\n", mp_opt->fail_seq);
 		break;
 
 	default:
@@ -412,7 +412,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
-		pr_debug("remote_token=%u, nonce=%u", subflow->remote_token,
+		pr_debug("remote_token=%u, nonce=%u\n", subflow->remote_token,
 			 subflow->local_nonce);
 		opts->suboptions = OPTION_MPTCP_MPJ_SYN;
 		opts->join_id = subflow->local_id;
@@ -496,7 +496,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 			*size = TCPOLEN_MPTCP_MPC_ACK;
 		}
 
-		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d",
+		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d\n",
 			 subflow, subflow->local_key, subflow->remote_key,
 			 data_len);
 
@@ -505,7 +505,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->suboptions = OPTION_MPTCP_MPJ_ACK;
 		memcpy(opts->hmac, subflow->hmac, MPTCPOPT_HMAC_LEN);
 		*size = TCPOLEN_MPTCP_MPJ_ACK;
-		pr_debug("subflow=%p", subflow);
+		pr_debug("subflow=%p\n", subflow);
 
 		/* we can use the full delegate action helper only from BH context
 		 * If we are in process context - sk is flushing the backlog at
@@ -673,7 +673,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 
 	*size = len;
 	if (drop_other_suboptions) {
-		pr_debug("drop other suboptions");
+		pr_debug("drop other suboptions\n");
 		opts->suboptions = 0;
 
 		/* note that e.g. DSS could have written into the memory
@@ -690,7 +690,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 						     msk->remote_key,
 						     &opts->addr);
 	}
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
+	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d\n",
 		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
 
 	return true;
@@ -721,7 +721,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	opts->rm_list = rm_list;
 
 	for (i = 0; i < opts->rm_list.nr; i++)
-		pr_debug("rm_list_ids[%d]=%d", i, opts->rm_list.ids[i]);
+		pr_debug("rm_list_ids[%d]=%d\n", i, opts->rm_list.ids[i]);
 
 	return true;
 }
@@ -747,7 +747,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_PRIO;
 	opts->backup = subflow->request_bkup;
 
-	pr_debug("prio=%d", opts->backup);
+	pr_debug("prio=%d\n", opts->backup);
 
 	return true;
 }
@@ -789,7 +789,7 @@ static bool mptcp_established_options_fastclose(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_FASTCLOSE;
 	opts->rcvr_key = msk->remote_key;
 
-	pr_debug("FASTCLOSE key=%llu", opts->rcvr_key);
+	pr_debug("FASTCLOSE key=%llu\n", opts->rcvr_key);
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
 	return true;
 }
@@ -811,7 +811,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_FAIL;
 	opts->fail_seq = subflow->map_seq;
 
-	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+	pr_debug("MP_FAIL fail_seq=%llu\n", opts->fail_seq);
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 
 	return true;
@@ -899,7 +899,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->csum_reqd = subflow_req->csum_reqd;
 		opts->allow_join_id0 = subflow_req->allow_join_id0;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
-		pr_debug("subflow_req=%p, local_key=%llu",
+		pr_debug("subflow_req=%p, local_key=%llu\n",
 			 subflow_req, subflow_req->local_key);
 		return true;
 	} else if (subflow_req->mp_join) {
@@ -908,7 +908,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
-		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u",
+		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 			 subflow_req, opts->backup, opts->join_id,
 			 opts->thmac, opts->nonce);
 		*size = TCPOLEN_MPTCP_MPJ_SYNACK;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5646c7275a92..34120694ad49 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -20,7 +20,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 {
 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, local_id=%d, echo=%d", msk, addr->id, echo);
+	pr_debug("msk=%p, local_id=%d, echo=%d\n", msk, addr->id, echo);
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -45,7 +45,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 {
 	u8 rm_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p, rm_list_nr=%d\n", msk, rm_list->nr);
 
 	if (rm_addr) {
 		pr_warn("addr_signal error, rm_addr=%d", rm_addr);
@@ -65,7 +65,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p, token=%u side=%d", msk, msk->token, server_side);
+	pr_debug("msk=%p, token=%u side=%d\n", msk, msk->token, server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
@@ -89,7 +89,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
+	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
 		 subflows_max, READ_ONCE(pm->accept_subflow));
 
 	/* try to avoid acquiring the lock below */
@@ -113,7 +113,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 				   enum mptcp_pm_status new_status)
 {
-	pr_debug("msk=%p status=%x new=%lx", msk, msk->pm.status,
+	pr_debug("msk=%p status=%x new=%lx\n", msk, msk->pm.status,
 		 BIT(new_status));
 	if (msk->pm.status & BIT(new_status))
 		return false;
@@ -128,7 +128,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool announce = false;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&pm->lock);
 
@@ -152,14 +152,14 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 {
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 }
 
 void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!READ_ONCE(pm->work_pending))
 		return;
@@ -211,7 +211,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p remote_id=%d accept=%d", msk, addr->id,
+	pr_debug("msk=%p remote_id=%d accept=%d\n", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 
 	mptcp_event_addr_announced(ssk, addr);
@@ -244,7 +244,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&pm->lock);
 
@@ -268,7 +268,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	u8 i;
 
-	pr_debug("msk=%p remote_ids_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p remote_ids_nr=%d\n", msk, rm_list->nr);
 
 	for (i = 0; i < rm_list->nr; i++)
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
@@ -307,19 +307,19 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 
-	pr_debug("fail_seq=%llu", fail_seq);
+	pr_debug("fail_seq=%llu\n", fail_seq);
 
 	if (!READ_ONCE(msk->allow_infinite_fallback))
 		return;
 
 	if (!subflow->fail_tout) {
-		pr_debug("send MP_FAIL response and infinite map");
+		pr_debug("send MP_FAIL response and infinite map\n");
 
 		subflow->send_mp_fail = 1;
 		subflow->send_infinite_map = 1;
 		tcp_send_ack(sk);
 	} else {
-		pr_debug("MP_FAIL response received");
+		pr_debug("MP_FAIL response received\n");
 		WRITE_ONCE(subflow->fail_tout, 0);
 	}
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9e16ae1b23fc..f001e1547402 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -150,12 +150,14 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 	return false;
 }
 
-static struct mptcp_pm_addr_entry *
+static bool
 select_local_address(const struct pm_nl_pernet *pernet,
-		     const struct mptcp_sock *msk)
+		     const struct mptcp_sock *msk,
+		     struct mptcp_pm_addr_entry *new_entry)
 {
 	const struct sock *sk = (const struct sock *)msk;
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	msk_owned_by_me(msk);
 
@@ -177,17 +179,21 @@ select_local_address(const struct pm_nl_pernet *pernet,
 				continue;
 		}
 
-		ret = entry;
+		*new_entry = *entry;
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
-static struct mptcp_pm_addr_entry *
-select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
+static bool
+select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
+		      struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	rcu_read_lock();
 	/* do not keep any additional per socket state, just signal
@@ -202,11 +208,13 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 
-		ret = entry;
+		*new_entry = *entry;
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
@@ -297,7 +305,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!msk)
 		return;
@@ -316,7 +324,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
-		pr_debug("retransmit ADD_ADDR id=%d", entry->addr.id);
+		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
 		entry->retrans_times++;
@@ -397,7 +405,7 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_splice_init(&msk->pm.anno_list, &free_list);
@@ -474,7 +482,7 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 	bool slow;
 
-	pr_debug("send ack for %s",
+	pr_debug("send ack for %s\n",
 		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
 
 	slow = lock_sock_fast(ssk);
@@ -527,9 +535,10 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
+	bool signal_and_subflow = false;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
@@ -580,23 +589,27 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		local = select_signal_address(pernet, msk);
-		if (!local)
+		if (!select_signal_address(pernet, msk, &local))
 			goto subflow;
 
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
 			return;
 
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
-		mptcp_pm_announce_addr(msk, &local->addr, false);
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
+		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
-		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
-			signal_and_subflow = local;
+		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = true;
 	}
 
 subflow:
@@ -607,24 +620,28 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		if (signal_and_subflow) {
-			local = signal_and_subflow;
-			signal_and_subflow = NULL;
-		} else {
-			local = select_local_address(pernet, msk);
-			if (!local)
-				break;
-		}
+		if (signal_and_subflow)
+			signal_and_subflow = false;
+		else if (!select_local_address(pernet, msk, &local))
+			break;
+
+		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 
-		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+		else /* local_addr_used is not decr for ID 0 */
+			msk->pm.local_addr_used++;
+
+		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
+		if (nr == 0)
+			continue;
 
-		msk->pm.local_addr_used++;
-		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
-		if (nr)
-			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -648,7 +665,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info local;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -656,6 +673,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
@@ -673,7 +692,13 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct ID */
+			if (mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();
@@ -682,6 +707,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
+		struct mptcp_addr_info local;
+
 		memset(&local, 0, sizeof(local));
 		local.family = msk->pm.remote.family;
 
@@ -705,7 +732,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("accepted %d:%d remote family %d",
+	pr_debug("accepted %d:%d remote family %d\n",
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
 		 msk->pm.remote.family);
 
@@ -732,7 +759,9 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (sf_created) {
-		msk->pm.add_addr_accepted++;
+		/* add_addr_accepted is not decr for ID 0 */
+		if (remote.id)
+			msk->pm.add_addr_accepted++;
 		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
 		    msk->pm.subflows >= subflows_max)
 			WRITE_ONCE(msk->pm.accept_addr, false);
@@ -774,7 +803,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 {
 	struct mptcp_subflow_context *subflow;
 
-	pr_debug("bkup=%d", bkup);
+	pr_debug("bkup=%d\n", bkup);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -797,11 +826,6 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
-static bool mptcp_local_id_match(const struct mptcp_sock *msk, u8 local_id, u8 id)
-{
-	return local_id == id || (!local_id && msk->mpc_endpoint_id == id);
-}
-
 static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 					   const struct mptcp_rm_list *rm_list,
 					   enum linux_mptcp_mib_field rm_type)
@@ -810,7 +834,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 	u8 i;
 
-	pr_debug("%s rm_list_nr %d",
+	pr_debug("%s rm_list_nr %d\n",
 		 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow", rm_list->nr);
 
 	msk_owned_by_me(msk);
@@ -838,10 +862,10 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 				continue;
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
-			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
+			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
 				continue;
 
-			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
+			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u\n",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
 				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
@@ -898,7 +922,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	pr_debug("msk=%p status=%x", msk, pm->status);
+	pr_debug("msk=%p status=%x\n", msk, pm->status);
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
@@ -1472,6 +1496,12 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 	return false;
 }
 
+static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr)
+{
+	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
+}
+
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
@@ -1479,7 +1509,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	struct mptcp_rm_list list = { .nr = 0 };
 	bool ret;
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
@@ -1506,13 +1536,11 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   const struct mptcp_pm_addr_entry *entry)
 {
 	const struct mptcp_addr_info *addr = &entry->addr;
-	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_rm_list list = { .nr = 1 };
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
-	pr_debug("remove_id=%d", addr->id);
-
-	list.ids[list.nr++] = addr->id;
+	pr_debug("remove_id=%d\n", addr->id);
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
@@ -1531,6 +1559,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
+		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 		if (remove_subflow) {
 			spin_lock_bh(&msk->pm.lock);
 			mptcp_pm_nl_rm_subflow_received(msk, &list);
@@ -1639,6 +1668,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+/* Called from the userspace PM only */
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
@@ -1667,8 +1697,9 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list)
+/* Called from the in-kernel PM only */
+static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
+					       struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
@@ -1676,11 +1707,11 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	list_for_each_entry(entry, rm_list, list) {
 		if (slist.nr < MPTCP_RM_IDS_MAX &&
 		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
-			slist.ids[slist.nr++] = entry->addr.id;
+			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
 		    remove_anno_list_by_saddr(msk, &entry->addr))
-			alist.ids[alist.nr++] = entry->addr.id;
+			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
 	spin_lock_bh(&msk->pm.lock);
@@ -1968,7 +1999,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 258dbfe9fad3..62a2da0f2b54 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -152,7 +152,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx",
+	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -230,7 +230,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d", msk, seq, max_seq,
+	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	if (after64(end_seq, max_seq)) {
 		/* out of window */
@@ -653,7 +653,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		}
 	}
 
-	pr_debug("msk=%p ssk=%p", msk, ssk);
+	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
 	do {
 		u32 map_remaining, offset;
@@ -732,7 +732,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
-	pr_debug("msk=%p empty=%d", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
+	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
 		skb = rb_to_skb(p);
 		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
@@ -754,7 +754,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d",
+			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
 				 delta);
 			MPTCP_SKB_CB(skb)->offset += delta;
@@ -1292,7 +1292,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	size_t copy;
 	int i;
 
-	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
+	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u\n",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
 	if (WARN_ON_ONCE(info->sent > info->limit ||
@@ -1393,7 +1393,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	mpext->use_map = 1;
 	mpext->dsn64 = 1;
 
-	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d",
+	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d\n",
 		 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 		 mpext->dsn64);
 
@@ -1870,7 +1870,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
 		}
-		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
+		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
 
@@ -2226,7 +2226,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			}
 		}
 
-		pr_debug("block timeout %ld", timeo);
+		pr_debug("block timeout %ld\n", timeo);
 		sk_wait_data(sk, &timeo, NULL);
 	}
 
@@ -2242,7 +2242,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 	}
 
-	pr_debug("msk=%p rx queue empty=%d:%d copied=%d",
+	pr_debug("msk=%p rx queue empty=%d:%d copied=%d\n",
 		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
 		 skb_queue_empty(&msk->receive_queue), copied);
 	if (!(flags & MSG_PEEK))
@@ -2503,6 +2503,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->close_event_done)
+		return;
+
+	subflow->close_event_done = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
@@ -2697,7 +2703,7 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	if (!ssk)
 		return;
 
-	pr_debug("MP_FAIL doesn't respond, reset the subflow");
+	pr_debug("MP_FAIL doesn't respond, reset the subflow\n");
 
 	slow = lock_sock_fast(ssk);
 	mptcp_subflow_reset(ssk);
@@ -2869,7 +2875,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		break;
 	default:
 		if (__mptcp_check_fallback(mptcp_sk(sk))) {
-			pr_debug("Fallback");
+			pr_debug("Fallback\n");
 			ssk->sk_shutdown |= how;
 			tcp_shutdown(ssk, how);
 
@@ -2879,7 +2885,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			WRITE_ONCE(mptcp_sk(sk)->snd_una, mptcp_sk(sk)->snd_nxt);
 			mptcp_schedule_work(sk);
 		} else {
-			pr_debug("Sending DATA_FIN on subflow %p", ssk);
+			pr_debug("Sending DATA_FIN on subflow %p\n", ssk);
 			tcp_send_ack(ssk);
 			if (!mptcp_rtx_timer_pending(sk))
 				mptcp_reset_rtx_timer(sk);
@@ -2922,7 +2928,7 @@ static void mptcp_check_send_data_fin(struct sock *sk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu",
+	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu\n",
 		 msk, msk->snd_data_fin_enable, !!mptcp_send_head(sk),
 		 msk->snd_nxt, msk->write_seq);
 
@@ -2946,7 +2952,7 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p snd_data_fin_enable=%d shutdown=%x state=%d pending=%d",
+	pr_debug("msk=%p snd_data_fin_enable=%d shutdown=%x state=%d pending=%d\n",
 		 msk, msk->snd_data_fin_enable, sk->sk_shutdown, sk->sk_state,
 		 !!mptcp_send_head(sk));
 
@@ -2961,7 +2967,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	might_sleep();
 
@@ -3073,7 +3079,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		inet_sk_state_store(sk, TCP_CLOSE);
 
 	sock_hold(sk);
-	pr_debug("msk=%p state=%d", sk, sk->sk_state);
+	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
@@ -3331,12 +3337,12 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 		return NULL;
 	}
 
-	pr_debug("msk=%p, listener=%p", msk, mptcp_subflow_ctx(listener->sk));
+	pr_debug("msk=%p, listener=%p\n", msk, mptcp_subflow_ctx(listener->sk));
 	newsk = inet_csk_accept(listener->sk, flags, err, kern);
 	if (!newsk)
 		return NULL;
 
-	pr_debug("msk=%p, subflow is mptcp=%d", msk, sk_is_mptcp(newsk));
+	pr_debug("msk=%p, subflow is mptcp=%d\n", msk, sk_is_mptcp(newsk));
 	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
@@ -3550,7 +3556,7 @@ static int mptcp_get_port(struct sock *sk, unsigned short snum)
 	struct socket *ssock;
 
 	ssock = msk->subflow;
-	pr_debug("msk=%p, subflow=%p", msk, ssock);
+	pr_debug("msk=%p, subflow=%p\n", msk, ssock);
 	if (WARN_ON_ONCE(!ssock))
 		return -EINVAL;
 
@@ -3568,7 +3574,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	sk = subflow->conn;
 	msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p, token=%u", sk, subflow->token);
+	pr_debug("msk=%p, token=%u\n", sk, subflow->token);
 
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
 	ack_seq++;
@@ -3608,7 +3614,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	struct sock *parent = (void *)msk;
 	bool ret = true;
 
-	pr_debug("msk=%p, subflow=%p", msk, subflow);
+	pr_debug("msk=%p, subflow=%p\n", msk, subflow);
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
@@ -3653,7 +3659,7 @@ bool mptcp_finish_join(struct sock *ssk)
 
 static void mptcp_shutdown(struct sock *sk, int how)
 {
-	pr_debug("sk=%p, how=%d", sk, how);
+	pr_debug("sk=%p, how=%d\n", sk, how);
 
 	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
 		__mptcp_wr_shutdown(sk);
@@ -3854,7 +3860,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct socket *ssock;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	lock_sock(sk);
 
@@ -3889,7 +3895,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	struct socket *ssock;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	/* Buggy applications can call accept on socket states other then LISTEN
 	 * but no need to allocate the first subflow just to error out.
@@ -3963,7 +3969,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	sock_poll_wait(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
-	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
+	pr_debug("msk=%p state=%d flags=%lx\n", msk, state, msk->flags);
 	if (state == TCP_LISTEN) {
 		struct socket *ssock = READ_ONCE(msk->subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c3cd68edab77..ee3974b10ef0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -479,7 +479,9 @@ struct mptcp_subflow_context {
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
-		valid_csum_seen : 1;        /* at least one csum validated */
+		valid_csum_seen : 1,        /* at least one csum validated */
+		close_event_done : 1,       /* has done the post-closed part */
+		__unused : 9;
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
@@ -837,8 +839,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
@@ -975,7 +975,7 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 {
 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
-		pr_debug("TCP fallback already done (msk=%p)", msk);
+		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
@@ -1002,7 +1002,7 @@ static inline void mptcp_do_fallback(struct sock *ssk)
 	}
 }
 
-#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
+#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
 static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
 {
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ff82fc062ae7..766797ace942 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -881,7 +881,7 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (level == SOL_SOCKET)
 		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
@@ -1292,7 +1292,7 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not yet defined. It is up to the
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1a92c8edd0a0..dc3666298bef 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -39,7 +39,7 @@ static void subflow_req_destructor(struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 
-	pr_debug("subflow_req=%p", subflow_req);
+	pr_debug("subflow_req=%p\n", subflow_req);
 
 	if (subflow_req->msk)
 		sock_put((struct sock *)subflow_req->msk);
@@ -145,7 +145,7 @@ static int subflow_check_req(struct request_sock *req,
 	struct mptcp_options_received mp_opt;
 	bool opt_mp_capable, opt_mp_join;
 
-	pr_debug("subflow_req=%p, listener=%p", subflow_req, listener);
+	pr_debug("subflow_req=%p, listener=%p\n", subflow_req, listener);
 
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -218,7 +218,7 @@ static int subflow_check_req(struct request_sock *req,
 		}
 
 		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
-			pr_debug("syn inet_sport=%d %d",
+			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
 			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
@@ -237,7 +237,7 @@ static int subflow_check_req(struct request_sock *req,
 				return -EPERM;
 		}
 
-		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
+		pr_debug("token=%u, remote_nonce=%u msk=%p\n", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
 	}
 
@@ -415,7 +415,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
-	pr_debug("subflow=%p synack seq=%x", subflow, subflow->ssn_offset);
+	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
@@ -434,7 +434,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
-		pr_debug("subflow=%p, remote_key=%llu", subflow,
+		pr_debug("subflow=%p, remote_key=%llu\n", subflow,
 			 subflow->remote_key);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
@@ -451,7 +451,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
 		WRITE_ONCE(subflow->remote_id, mp_opt.join_id);
-		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
+		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d\n",
 			 subflow, subflow->thmac, subflow->remote_nonce,
 			 subflow->backup);
 
@@ -477,7 +477,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
 
 		if (subflow_use_different_dport(mptcp_sk(parent), sk)) {
-			pr_debug("synack inet_dport=%d %d",
+			pr_debug("synack inet_dport=%d %d\n",
 				 ntohs(inet_sk(sk)->inet_dport),
 				 ntohs(inet_sk(parent)->inet_dport));
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINPORTSYNACKRX);
@@ -548,7 +548,7 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	/* Never answer to SYNs sent to broadcast or multicast */
 	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -579,7 +579,7 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return subflow_v4_conn_request(sk, skb);
@@ -697,7 +697,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct mptcp_sock *owner;
 	struct sock *child;
 
-	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
+	pr_debug("listener=%p, req=%p, conn=%p\n", listener, req, listener->conn);
 
 	/* After child creation we must look for MPC even when options
 	 * are not parsed
@@ -788,7 +788,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			ctx->conn = (struct sock *)owner;
 
 			if (subflow_use_different_sport(owner, sk)) {
-				pr_debug("ack inet_sport=%d %d",
+				pr_debug("ack inet_sport=%d %d\n",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
@@ -845,7 +845,7 @@ enum mapping_status {
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
 {
-	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
+	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d\n",
 		 ssn, subflow->map_subflow_seq, subflow->map_data_len);
 }
 
@@ -1005,7 +1005,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 
 	data_len = mpext->data_len;
 	if (data_len == 0) {
-		pr_debug("infinite mapping received");
+		pr_debug("infinite mapping received\n");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len = 0;
 		return MAPPING_INVALID;
@@ -1015,7 +1015,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		if (data_len == 1) {
 			bool updated = mptcp_update_rcv_data_fin(msk, mpext->data_seq,
 								 mpext->dsn64);
-			pr_debug("DATA_FIN with no payload seq=%llu", mpext->data_seq);
+			pr_debug("DATA_FIN with no payload seq=%llu\n", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
 				 * option before the previous mapping
@@ -1040,7 +1040,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 				data_fin_seq &= GENMASK_ULL(31, 0);
 
 			mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
-			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d",
+			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d\n",
 				 data_fin_seq, mpext->dsn64);
 		}
 
@@ -1087,7 +1087,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (unlikely(subflow->map_csum_reqd != csum_reqd))
 		return MAPPING_INVALID;
 
-	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
+	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 		 subflow->map_seq, subflow->map_subflow_seq,
 		 subflow->map_data_len, subflow->map_csum_reqd,
 		 subflow->map_data_csum);
@@ -1122,7 +1122,7 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 	avail_len = skb->len - offset;
 	incr = limit >= avail_len ? avail_len + fin : limit;
 
-	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
+	pr_debug("discarding=%d len=%d offset=%d seq=%d\n", incr, skb->len,
 		 offset, subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq += incr;
@@ -1231,7 +1231,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 		old_ack = READ_ONCE(msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
-		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx", old_ack,
+		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx\n", old_ack,
 			 ack_seq);
 		if (unlikely(before64(ack_seq, old_ack))) {
 			mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
@@ -1303,7 +1303,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 		subflow->map_valid = 0;
 		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 
-		pr_debug("Done with mapping: seq=%u data_len=%u",
+		pr_debug("Done with mapping: seq=%u data_len=%u\n",
 			 subflow->map_subflow_seq,
 			 subflow->map_data_len);
 	}
@@ -1403,7 +1403,7 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapped)
 
 	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
 
-	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d",
+	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d\n",
 		 subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
 
 	if (likely(icsk->icsk_af_ops == target))
@@ -1497,7 +1497,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		goto failed;
 
 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
-	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
+	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d\n", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
 	WRITE_ONCE(subflow->remote_id, remote_id);
@@ -1626,7 +1626,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	SOCK_INODE(sf)->i_gid = SOCK_INODE(sk->sk_socket)->i_gid;
 
 	subflow = mptcp_subflow_ctx(sf->sk);
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	*new_sock = sf;
 	sock_hold(sk);
@@ -1650,7 +1650,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 	INIT_LIST_HEAD(&ctx->node);
 	INIT_LIST_HEAD(&ctx->delegated_node);
 
-	pr_debug("subflow=%p", ctx);
+	pr_debug("subflow=%p\n", ctx);
 
 	ctx->tcp_sock = sk;
 	WRITE_ONCE(ctx->local_id, -1);
@@ -1803,7 +1803,7 @@ static int subflow_ulp_init(struct sock *sk)
 		goto out;
 	}
 
-	pr_debug("subflow=%p, family=%d", ctx, sk->sk_family);
+	pr_debug("subflow=%p, family=%d\n", ctx, sk->sk_family);
 
 	tp->is_mptcp = 1;
 	ctx->icsk_af_ops = icsk->icsk_af_ops;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 3cd162e53173..d18716e5b2cc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1534,7 +1534,7 @@ struct cfg80211_bss *cfg80211_get_bss(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_get_bss);
 
-static void rb_insert_bss(struct cfg80211_registered_device *rdev,
+static bool rb_insert_bss(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_internal_bss *bss)
 {
 	struct rb_node **p = &rdev->bss_tree.rb_node;
@@ -1550,7 +1550,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 		if (WARN_ON(!cmp)) {
 			/* will sort of leak this BSS */
-			return;
+			return false;
 		}
 
 		if (cmp < 0)
@@ -1561,6 +1561,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 	rb_link_node(&bss->rbn, parent, p);
 	rb_insert_color(&bss->rbn, &rdev->bss_tree);
+	return true;
 }
 
 static struct cfg80211_internal_bss *
@@ -1587,6 +1588,34 @@ rb_find_bss(struct cfg80211_registered_device *rdev,
 	return NULL;
 }
 
+static void cfg80211_insert_bss(struct cfg80211_registered_device *rdev,
+				struct cfg80211_internal_bss *bss)
+{
+	lockdep_assert_held(&rdev->bss_lock);
+
+	if (!rb_insert_bss(rdev, bss))
+		return;
+	list_add_tail(&bss->list, &rdev->bss_list);
+	rdev->bss_entries++;
+}
+
+static void cfg80211_rehash_bss(struct cfg80211_registered_device *rdev,
+                                struct cfg80211_internal_bss *bss)
+{
+	lockdep_assert_held(&rdev->bss_lock);
+
+	rb_erase(&bss->rbn, &rdev->bss_tree);
+	if (!rb_insert_bss(rdev, bss)) {
+		list_del(&bss->list);
+		if (!list_empty(&bss->hidden_list))
+			list_del_init(&bss->hidden_list);
+		if (!list_empty(&bss->pub.nontrans_list))
+			list_del_init(&bss->pub.nontrans_list);
+		rdev->bss_entries--;
+	}
+	rdev->bss_generation++;
+}
+
 static bool cfg80211_combine_bsses(struct cfg80211_registered_device *rdev,
 				   struct cfg80211_internal_bss *new)
 {
@@ -1862,9 +1891,7 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 			bss_ref_get(rdev, pbss);
 		}
 
-		list_add_tail(&new->list, &rdev->bss_list);
-		rdev->bss_entries++;
-		rb_insert_bss(rdev, new);
+		cfg80211_insert_bss(rdev, new);
 		found = new;
 	}
 
@@ -2651,10 +2678,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 		if (!WARN_ON(!__cfg80211_unlink_bss(rdev, new)))
 			rdev->bss_generation++;
 	}
-
-	rb_erase(&cbss->rbn, &rdev->bss_tree);
-	rb_insert_bss(rdev, cbss);
-	rdev->bss_generation++;
+	cfg80211_rehash_bss(rdev, cbss);
 
 	list_for_each_entry_safe(nontrans_bss, tmp,
 				 &cbss->pub.nontrans_list,
@@ -2662,9 +2686,7 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 		bss = container_of(nontrans_bss,
 				   struct cfg80211_internal_bss, pub);
 		bss->pub.channel = chan;
-		rb_erase(&bss->rbn, &rdev->bss_tree);
-		rb_insert_bss(rdev, bss);
-		rdev->bss_generation++;
+		cfg80211_rehash_bss(rdev, bss);
 	}
 
 done:
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 7160e7aa58b9..ce7b2f43c319 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1687,6 +1687,10 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 		struct aa_profile *p;
 		p = aa_deref_parent(profile);
 		dent = prof_dir(p);
+		if (!dent) {
+			error = -ENOENT;
+			goto fail2;
+		}
 		/* adding to parent that previously didn't have children */
 		dent = aafs_create_dir("profiles", dent);
 		if (IS_ERR(dent))
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b0a483e40c82..75b3e91d5a5f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4290,7 +4290,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	rcu_read_unlock();
 
 	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
+		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
 	else
 		netlbl_req_delattr(req);
 
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index dbf7aa88e0e3..992cf82da102 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4952,6 +4952,69 @@ void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on)
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_stream_pm);
 
+/* forcibly mute the speaker output without caching; return true if updated */
+static bool force_mute_output_path(struct hda_codec *codec, hda_nid_t nid)
+{
+	if (!nid)
+		return false;
+	if (!nid_has_mute(codec, nid, HDA_OUTPUT))
+		return false; /* no mute, skip */
+	if (snd_hda_codec_amp_read(codec, nid, 0, HDA_OUTPUT, 0) &
+	    snd_hda_codec_amp_read(codec, nid, 1, HDA_OUTPUT, 0) &
+	    HDA_AMP_MUTE)
+		return false; /* both channels already muted, skip */
+
+	/* direct amp update without caching */
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
+			    AC_AMP_SET_OUTPUT | AC_AMP_SET_LEFT |
+			    AC_AMP_SET_RIGHT | HDA_AMP_MUTE);
+	return true;
+}
+
+/**
+ * snd_hda_gen_shutup_speakers - Forcibly mute the speaker outputs
+ * @codec: the HDA codec
+ *
+ * Forcibly mute the speaker outputs, to be called at suspend or shutdown.
+ *
+ * The mute state done by this function isn't cached, hence the original state
+ * will be restored at resume.
+ *
+ * Return true if the mute state has been changed.
+ */
+bool snd_hda_gen_shutup_speakers(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	const int *paths;
+	const struct nid_path *path;
+	int i, p, num_paths;
+	bool updated = false;
+
+	/* if already powered off, do nothing */
+	if (!snd_hdac_is_power_on(&codec->core))
+		return false;
+
+	if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT) {
+		paths = spec->out_paths;
+		num_paths = spec->autocfg.line_outs;
+	} else {
+		paths = spec->speaker_paths;
+		num_paths = spec->autocfg.speaker_outs;
+	}
+
+	for (i = 0; i < num_paths; i++) {
+		path = snd_hda_get_path_from_idx(codec, paths[i]);
+		if (!path)
+			continue;
+		for (p = 0; p < path->depth; p++)
+			if (force_mute_output_path(codec, path->path[p]))
+				updated = true;
+	}
+
+	return updated;
+}
+EXPORT_SYMBOL_GPL(snd_hda_gen_shutup_speakers);
+
 /**
  * snd_hda_gen_parse_auto_config - Parse the given BIOS configuration and
  * set up the hda_gen_spec
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 34eba40cc6e6..fb3ce68e2d71 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -352,5 +352,6 @@ int snd_hda_gen_add_mute_led_cdev(struct hda_codec *codec,
 int snd_hda_gen_add_micmute_led_cdev(struct hda_codec *codec,
 				     int (*callback)(struct led_classdev *,
 						     enum led_brightness));
+bool snd_hda_gen_shutup_speakers(struct hda_codec *codec);
 
 #endif /* __SOUND_HDA_GENERIC_H */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index af921364195e..8396d1d93668 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -205,6 +205,8 @@ static void cx_auto_shutdown(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
 
+	snd_hda_gen_shutup_speakers(codec);
+
 	/* Turn the problematic codec into D3 to avoid spurious noises
 	   from the internal speaker during (and after) reboot */
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index b4a40a880035..de655f687dd7 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -220,6 +220,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a73358d753aa..33c002c26604 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -402,9 +402,10 @@ reset_with_tcp_filter()
 	local ns="${!1}"
 	local src="${2}"
 	local target="${3}"
+	local chain="${4:-INPUT}"
 
 	if ! ip netns exec "${ns}" ${iptables} \
-			-A INPUT \
+			-A "${chain}" \
 			-s "${src}" \
 			-p tcp \
 			-j "${target}"; then
@@ -956,8 +957,6 @@ do_transfer()
 				dp=$(grep "type:10" "$evts_ns1" |
 				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "$addr" \
-							lport $sp rip $da rport $dp token $tk
 			fi
 
 			counter=$((counter + 1))
@@ -1023,7 +1022,6 @@ do_transfer()
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
 			fi
@@ -1251,13 +1249,13 @@ chk_csum_nr()
 
 	printf "%-${nr_blank}s %s" " " "sum"
 	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns1" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
 		extra_msg="$extra_msg ns1=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		fail_test
 		dump_stats=1
@@ -1266,13 +1264,13 @@ chk_csum_nr()
 	fi
 	echo -n " - csum  "
 	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns2" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
 		extra_msg="$extra_msg ns2=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
 		dump_stats=1
@@ -1314,13 +1312,13 @@ chk_fail_nr()
 
 	printf "%-${nr_blank}s %s" " " "ftx"
 	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
-	if [ "$count" != "$fail_tx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
 		dump_stats=1
@@ -1330,13 +1328,13 @@ chk_fail_nr()
 
 	echo -n " - failrx"
 	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
-	if [ "$count" != "$fail_rx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
 		dump_stats=1
@@ -3023,6 +3021,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
 		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
@@ -3225,7 +3224,7 @@ userspace_tests()
 		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_rm_nr 1 1 invert
+		chk_rm_nr 1 0 invert
 	fi
 
 	# userspace pm create destroy subflow
@@ -3235,7 +3234,76 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 1 1
+		chk_rm_nr 0 1
+	fi
+
+	# remove and re-add
+	if reset "delete re-add signal" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 3 3
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+
+		wait_mpj $ns2
+		chk_subflow_nr needtitle "before delete" 2
+
+		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete" 1
+
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 3
+
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete ID 0" 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 3
+		kill_tests_wait
+
+		chk_join_nr 4 4 4
+		chk_add_nr 5 5
+		chk_rm_nr 3 2 invert
+	fi
+
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr needtitle "before flush" 1
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		kill_wait "${tests_pid}"
+		kill_tests_wait
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
 	fi
 }
 
@@ -3264,22 +3332,48 @@ endpoint_tests()
 		kill_tests_wait
 	fi
 
-	if reset "delete and re-add" &&
+	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 0 3
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
-		chk_subflow_nr needtitle "after delete" 1
+		chk_subflow_nr needtitle "after delete id 2" 1
 
-		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 2
+		chk_subflow_nr "" "after re-add id 2" 2
+
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_attempt_fail $ns2
+		chk_subflow_nr "" "after new reject" 2
+
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "" "after no reject" 3
+
+		local i
+		for i in $(seq 3); do
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			sleep 0.5
+			chk_subflow_nr "" "after delete id 0 ($i)" 2
+
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+			wait_mpj $ns2
+			chk_subflow_nr "" "after re-add id 0 ($i)" 3
+		done
+
 		kill_tests_wait
+
+		chk_join_nr 6 6 6
+		chk_rm_nr 4 4
 	fi
 }
 

