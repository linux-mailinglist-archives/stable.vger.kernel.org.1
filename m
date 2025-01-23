Return-Path: <stable+bounces-110305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC382A1A89B
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61D23B0467
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFECF14C5AE;
	Thu, 23 Jan 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jyUOu14c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086714B97E;
	Thu, 23 Jan 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652198; cv=none; b=HOOq51eSHvHEHZDyIngyzmuMnHOs/yB1DeJgpEB8fq5J4H/gDqwGcryrihgfA0Q3iPcZ29h2WZVqWzxFrhbe99x6H9HCxuD2bICbWqvcxAzwAaUwCnXI2+LHD9EuvhPLiFYCSCWDBVJCiN2D9cyAB8QunSgW9KFx4ob43UaGbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652198; c=relaxed/simple;
	bh=yPjTGWtqax9llgFXaPCsdQDJVKGkZlr3XZEgY4OmB7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iC1q6on28PDATC0nsmE0+WmJ7cn5HEAXB/sazbOLoxoxO27fskL12oMbFdHpTN0wFcj7Ofxa83T7iNveJle0lnrjYuwjbufqJDAh38ztiQ+UYUIqZox8h4zlfTwl39CA7XmA+uZZ2SNG9poTIi03JgGoe6V76BAMNixf8GKfC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jyUOu14c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100B7C4CEE1;
	Thu, 23 Jan 2025 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737652197;
	bh=yPjTGWtqax9llgFXaPCsdQDJVKGkZlr3XZEgY4OmB7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyUOu14cojYXsevq5wnba2jszLcyqW0DqtYHiDTzY6bBjBldnaz3sJznt1Xy2oR/P
	 ByoXtqV2qLqLcatb8IwraAD3GfoOKvzTiac8pvX2vcUkjV0KNUnz803dq35meoVdUE
	 fUzra3eP98Q+DsaF67he3tlUwaa3j9zlkZxV0WWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.127
Date: Thu, 23 Jan 2025 18:09:45 +0100
Message-ID: <2025012345-tycoon-postcard-de6f@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025012345-prize-despise-fe89@gregkh>
References: <2025012345-prize-despise-fe89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 916ed3b66536..9c703cff00bb 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 126
+SUBLEVEL = 127
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index c2e322189f85..373aed0f1422 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -225,7 +225,7 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
-static inline void serialize(void)
+static __always_inline void serialize(void)
 {
 	/* Instruction opcode for SERIALIZE; supported in binutils >= 2.35. */
 	asm volatile(".byte 0xf, 0x1, 0xe8" ::: "memory");
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index aa2676a7e2a4..a9b878fd6ee0 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -221,7 +221,7 @@ SYM_CODE_END(xen_early_idt_handler_array)
 	push %rax
 	mov  $__HYPERVISOR_iret, %eax
 	syscall		/* Do the IRET. */
-#ifdef CONFIG_MITIGATION_SLS
+#ifdef CONFIG_SLS
 	int3
 #endif
 .endm
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a82bdec923b2..c74e8273511a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -858,10 +858,8 @@ int blk_register_queue(struct gendisk *disk)
 	 * faster to shut down and is made fully functional here as
 	 * request_queues for non-existent devices never get registered.
 	 */
-	if (!blk_queue_init_done(q)) {
-		blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
-		percpu_ref_switch_to_percpu(&q->q_usage_counter);
-	}
+	blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
+	percpu_ref_switch_to_percpu(&q->q_usage_counter);
 
 	return ret;
 
diff --git a/block/genhd.c b/block/genhd.c
index 146ce13b192b..8256e11f85b7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -685,13 +685,10 @@ void del_gendisk(struct gendisk *disk)
 	 * If the disk does not own the queue, allow using passthrough requests
 	 * again.  Else leave the queue frozen to fail all I/O.
 	 */
-	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
-		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
+	if (!test_bit(GD_OWNS_QUEUE, &disk->state))
 		__blk_mq_unfreeze_queue(q, true);
-	} else {
-		if (queue_is_mq(q))
-			blk_mq_exit_queue(q);
-	}
+	else if (queue_is_mq(q))
+		blk_mq_exit_queue(q);
 }
 EXPORT_SYMBOL(del_gendisk);
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 6e041d40cad5..34cb7894e54e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -663,11 +663,11 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 	for (i = 0; i < ARRAY_SIZE(override_table); i++) {
 		const struct irq_override_cmp *entry = &override_table[i];
 
-		if (dmi_check_system(entry->system) &&
-		    entry->irq == gsi &&
+		if (entry->irq == gsi &&
 		    entry->triggering == triggering &&
 		    entry->polarity == polarity &&
-		    entry->shareable == shareable)
+		    entry->shareable == shareable &&
+		    dmi_check_system(entry->system))
 			return entry->override;
 	}
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 8748cea3bc38..15b37a4163d3 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -652,17 +652,6 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 }
 EXPORT_SYMBOL_GPL(regmap_attach_dev);
 
-static int dev_get_regmap_match(struct device *dev, void *res, void *data);
-
-static int regmap_detach_dev(struct device *dev, struct regmap *map)
-{
-	if (!dev)
-		return 0;
-
-	return devres_release(dev, dev_get_regmap_release,
-			      dev_get_regmap_match, (void *)map->name);
-}
-
 static enum regmap_endian regmap_get_reg_endian(const struct regmap_bus *bus,
 					const struct regmap_config *config)
 {
@@ -1513,7 +1502,6 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 {
 	int ret;
 
-	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 	regmap_debugfs_exit(map);
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b4133258e1bf..bef5388e4e28 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1192,6 +1192,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
 	if (!zram->mem_pool) {
 		vfree(zram->table);
+		zram->table = NULL;
 		return false;
 	}
 
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 55f640ef3fee..897d20996a8c 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2860,9 +2860,9 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_device *gdev = cdev->gdev;
 
-	bitmap_free(cdev->watched_lines);
 	blocking_notifier_chain_unregister(&gdev->notifier,
 					   &cdev->lineinfo_changed_nb);
+	bitmap_free(cdev->watched_lines);
 	put_device(&gdev->dev);
 	kfree(cdev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0b2a27806bec..c4e548d32504 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3242,7 +3242,7 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  *
- * Second resume function for hardware IPs.  The list of all the hardware
+ * First resume function for hardware IPs.  The list of all the hardware
  * IPs that make up the asic is walked and the resume callbacks are run for
  * all blocks except COMMON, GMC, and IH.  resume puts the hardware into a
  * functional state after a suspend and updates the software state as
@@ -3260,7 +3260,6 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->resume(adev);
@@ -3284,36 +3283,6 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * amdgpu_device_ip_resume_phase3 - run resume for hardware IPs
- *
- * @adev: amdgpu_device pointer
- *
- * Third resume function for hardware IPs.  The list of all the hardware
- * IPs that make up the asic is walked and the resume callbacks are run for
- * all DCE.  resume puts the hardware into a functional state after a suspend
- * and updates the software state as necessary.  This function is also used
- * for restoring the GPU after a GPU reset.
- *
- * Returns 0 on success, negative error code on failure.
- */
-static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
-{
-	int i, r;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
-			continue;
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
-			r = adev->ip_blocks[i].version->funcs->resume(adev);
-			if (r)
-				return r;
-		}
-	}
-
-	return 0;
-}
-
 /**
  * amdgpu_device_ip_resume - run resume for hardware IPs
  *
@@ -3344,13 +3313,6 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 
 	r = amdgpu_device_ip_resume_phase2(adev);
 
-	if (r)
-		return r;
-
-	amdgpu_fence_driver_hw_init(adev);
-
-	r = amdgpu_device_ip_resume_phase3(adev);
-
 	return r;
 }
 
@@ -4131,8 +4093,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	int idx;
 	bool px;
 
-	amdgpu_fence_driver_sw_fini(adev);
 	amdgpu_device_ip_fini(adev);
+	amdgpu_fence_driver_sw_fini(adev);
 	release_firmware(adev->firmware.gpu_info_fw);
 	adev->firmware.gpu_info_fw = NULL;
 	adev->accel_working = false;
@@ -4349,6 +4311,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
 		return r;
 	}
+	amdgpu_fence_driver_hw_init(adev);
 
 	r = amdgpu_device_ip_late_init(adev);
 	if (r)
@@ -5102,10 +5065,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				if (r)
 					goto out;
 
-				r = amdgpu_device_ip_resume_phase3(tmp_adev);
-				if (r)
-					goto out;
-
 				if (vram_lost)
 					amdgpu_device_fill_reset_magic(tmp_adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index bc030588cd22..251416ad4652 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -220,15 +220,15 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
 
 	drm_sched_entity_destroy(&adev->vce.entity);
 
-	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
-		(void **)&adev->vce.cpu_addr);
-
 	for (i = 0; i < adev->vce.num_rings; i++)
 		amdgpu_ring_fini(&adev->vce.ring[i]);
 
 	release_firmware(adev->vce.fw);
 	mutex_destroy(&adev->vce.idle_mutex);
 
+	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
+		(void **)&adev->vce.cpu_addr);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index ce6c70e25703..dd71ea2568e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1340,7 +1340,7 @@ static struct link_encoder *dcn21_link_encoder_create(
 		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc21)
+	if (!enc21 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index c69a638796c6..32e43ea5a422 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -1571,7 +1571,7 @@ int intel_fill_fb_info(struct drm_i915_private *i915, struct intel_framebuffer *
 		 * arithmetic related to alignment and offset calculation.
 		 */
 		if (is_gen12_ccs_cc_plane(&fb->base, i)) {
-			if (IS_ALIGNED(fb->base.offsets[i], PAGE_SIZE))
+			if (IS_ALIGNED(fb->base.offsets[i], 64))
 				continue;
 			else
 				return -EINVAL;
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index e714d5318f30..76806039691a 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -103,6 +103,7 @@ v3d_irq(int irq, void *arg)
 
 		trace_v3d_bcl_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
+		v3d->bin_job = NULL;
 		status = IRQ_HANDLED;
 	}
 
@@ -112,6 +113,7 @@ v3d_irq(int irq, void *arg)
 
 		trace_v3d_rcl_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
+		v3d->render_job = NULL;
 		status = IRQ_HANDLED;
 	}
 
@@ -121,6 +123,7 @@ v3d_irq(int irq, void *arg)
 
 		trace_v3d_csd_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
+		v3d->csd_job = NULL;
 		status = IRQ_HANDLED;
 	}
 
@@ -157,6 +160,7 @@ v3d_hub_irq(int irq, void *arg)
 
 		trace_v3d_tfu_irq(&v3d->drm, fence->seqno);
 		dma_fence_signal(&fence->base);
+		v3d->tfu_job = NULL;
 		status = IRQ_HANDLED;
 	}
 
diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index aaba9521ebef..cbe29c8a9b18 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -203,7 +203,8 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 		*val = sign_extend32(regval,
 				     reg == TMP51X_SHUNT_CURRENT_RESULT ?
 				     16 - tmp51x_get_pga_shift(data) : 15);
-		*val = DIV_ROUND_CLOSEST(*val * 10 * MILLI, data->shunt_uohms);
+		*val = DIV_ROUND_CLOSEST(*val * 10 * (long)MILLI, (long)data->shunt_uohms);
+
 		break;
 	case TMP51X_BUS_VOLTAGE_RESULT:
 	case TMP51X_BUS_VOLTAGE_H_LIMIT:
@@ -219,7 +220,7 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 	case TMP51X_BUS_CURRENT_RESULT:
 		// Current = (ShuntVoltage * CalibrationRegister) / 4096
 		*val = sign_extend32(regval, 15) * (long)data->curr_lsb_ua;
-		*val = DIV_ROUND_CLOSEST(*val, MILLI);
+		*val = DIV_ROUND_CLOSEST(*val, (long)MILLI);
 		break;
 	case TMP51X_LOCAL_TEMP_RESULT:
 	case TMP51X_REMOTE_TEMP_RESULT_1:
@@ -259,7 +260,7 @@ static int tmp51x_set_value(struct tmp51x_data *data, u8 reg, long val)
 		 * The user enter current value and we convert it to
 		 * voltage. 1lsb = 10uV
 		 */
-		val = DIV_ROUND_CLOSEST(val * data->shunt_uohms, 10 * MILLI);
+		val = DIV_ROUND_CLOSEST(val * (long)data->shunt_uohms, 10 * (long)MILLI);
 		max_val = U16_MAX >> tmp51x_get_pga_shift(data);
 		regval = clamp_val(val, -max_val, max_val);
 		break;
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d0098e342ba2..c7f2a9d8bcd5 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -110,6 +110,8 @@
 #define ID_P_PM_BLOCKED		BIT(31)
 #define ID_P_MASK		GENMASK(31, 28)
 
+#define ID_SLAVE_NACK		BIT(0)
+
 enum rcar_i2c_type {
 	I2C_RCAR_GEN1,
 	I2C_RCAR_GEN2,
@@ -143,6 +145,7 @@ struct rcar_i2c_priv {
 	int irq;
 
 	struct i2c_client *host_notify_client;
+	u8 slave_flags;
 };
 
 #define rcar_i2c_priv_to_dev(p)		((p)->adap.dev.parent)
@@ -597,6 +600,7 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 {
 	u32 ssr_raw, ssr_filtered;
 	u8 value;
+	int ret;
 
 	ssr_raw = rcar_i2c_read(priv, ICSSR) & 0xff;
 	ssr_filtered = ssr_raw & rcar_i2c_read(priv, ICSIER);
@@ -612,7 +616,10 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 			rcar_i2c_write(priv, ICRXTX, value);
 			rcar_i2c_write(priv, ICSIER, SDE | SSR | SAR);
 		} else {
-			i2c_slave_event(priv->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
+			ret = i2c_slave_event(priv->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
+			if (ret)
+				priv->slave_flags |= ID_SLAVE_NACK;
+
 			rcar_i2c_read(priv, ICRXTX);	/* dummy read */
 			rcar_i2c_write(priv, ICSIER, SDR | SSR | SAR);
 		}
@@ -625,18 +632,21 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 	if (ssr_filtered & SSR) {
 		i2c_slave_event(priv->slave, I2C_SLAVE_STOP, &value);
 		rcar_i2c_write(priv, ICSCR, SIE | SDBS); /* clear our NACK */
+		priv->slave_flags &= ~ID_SLAVE_NACK;
 		rcar_i2c_write(priv, ICSIER, SAR);
 		rcar_i2c_write(priv, ICSSR, ~SSR & 0xff);
 	}
 
 	/* master wants to write to us */
 	if (ssr_filtered & SDR) {
-		int ret;
-
 		value = rcar_i2c_read(priv, ICRXTX);
 		ret = i2c_slave_event(priv->slave, I2C_SLAVE_WRITE_RECEIVED, &value);
-		/* Send NACK in case of error */
-		rcar_i2c_write(priv, ICSCR, SIE | SDBS | (ret < 0 ? FNA : 0));
+		if (ret)
+			priv->slave_flags |= ID_SLAVE_NACK;
+
+		/* Send NACK in case of error, but it will come 1 byte late :( */
+		rcar_i2c_write(priv, ICSCR, SIE | SDBS |
+			       (priv->slave_flags & ID_SLAVE_NACK ? FNA : 0));
 		rcar_i2c_write(priv, ICSSR, ~SDR & 0xff);
 	}
 
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 45a3f7e7b3f6..cea057704c00 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -261,7 +261,9 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 	pm_runtime_no_callbacks(&pdev->dev);
 
 	/* switch to first parent as active master */
-	i2c_demux_activate_master(priv, 0);
+	err = i2c_demux_activate_master(priv, 0);
+	if (err)
+		goto err_rollback;
 
 	err = device_create_file(&pdev->dev, &dev_attr_available_masters);
 	if (err)
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index b87ea7148b58..0861885fa2a5 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -270,6 +270,8 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 	int ret;
 	int i, j = 0;
 
+	memset(&data, 0, sizeof(data));
+
 	mutex_lock(&i_dev->mlock);
 
 	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 3d91469beccb..20fb1c33b90a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -360,6 +360,7 @@ struct inv_icm42600_state {
 typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 
 extern const struct regmap_config inv_icm42600_regmap_config;
+extern const struct regmap_config inv_icm42600_spi_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index ca85fccc9839..9dec4ad38c0d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -43,6 +43,17 @@ const struct regmap_config inv_icm42600_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);
 
+/* define specific regmap for SPI not supporting burst write */
+const struct regmap_config inv_icm42600_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x4FFF,
+	.ranges = inv_icm42600_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
+	.use_single_write = true,
+};
+EXPORT_SYMBOL_GPL(inv_icm42600_spi_regmap_config);
+
 struct inv_icm42600_hw {
 	uint8_t whoami;
 	const char *name;
@@ -709,6 +720,8 @@ static int __maybe_unused inv_icm42600_suspend(struct device *dev)
 static int __maybe_unused inv_icm42600_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	struct inv_icm42600_timestamp *gyro_ts = iio_priv(st->indio_gyro);
+	struct inv_icm42600_timestamp *accel_ts = iio_priv(st->indio_accel);
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -729,9 +742,12 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 		goto out_unlock;
 
 	/* restore FIFO data streaming */
-	if (st->fifo.on)
+	if (st->fifo.on) {
+		inv_icm42600_timestamp_reset(gyro_ts);
+		inv_icm42600_timestamp_reset(accel_ts);
 		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 				   INV_ICM42600_FIFO_CONFIG_STREAM);
+	}
 
 out_unlock:
 	mutex_unlock(&st->lock);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index e6305e5fa975..4441c3bb9601 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -59,7 +59,8 @@ static int inv_icm42600_probe(struct spi_device *spi)
 		return -EINVAL;
 	chip = (uintptr_t)match;
 
-	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
+	/* use SPI specific regmap */
+	regmap = devm_regmap_init_spi(spi, &inv_icm42600_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 35768fdbd5b7..1ef5819e75ff 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -643,13 +643,15 @@ int rxe_requester(void *arg)
 
 	if (unlikely(qp->req.state == QP_STATE_ERROR)) {
 		wqe = req_next_wqe(qp);
-		if (wqe)
+		if (wqe) {
 			/*
 			 * Generate an error completion for error qp state
 			 */
+			wqe->status = IB_WC_WR_FLUSH_ERR;
 			goto err;
-		else
+		} else {
 			goto exit;
+		}
 	}
 
 	if (unlikely(qp->req.state == QP_STATE_RESET)) {
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 30e60bcc3b4e..4f8512385870 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1967,7 +1967,7 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
-	guard(raw_spinlock_irq)(&its_dev->event_map.vlpi_lock);
+	guard(raw_spinlock)(&its_dev->event_map.vlpi_lock);
 
 	/* Unmap request? */
 	if (!info)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 96d04b5c9d76..6ef0be2c0ab8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1424,7 +1424,7 @@ static int gic_retrigger(struct irq_data *data)
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
-	if (cmd == CPU_PM_EXIT) {
+	if (cmd == CPU_PM_EXIT || cmd == CPU_PM_ENTER_FAILED) {
 		if (gic_dist_security_disabled())
 			gic_enable_redist(true);
 		gic_cpu_sys_reg_init();
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 7899607fbee8..66e5163a3444 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -35,11 +35,10 @@ void __init irqchip_init(void)
 int platform_irqchip_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *par_np = of_irq_find_parent(np);
+	struct device_node *par_np __free(device_node) = of_irq_find_parent(np);
 	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
 
 	if (!irq_init_cb) {
-		of_node_put(par_np);
 		return -EINVAL;
 	}
 
@@ -55,7 +54,6 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	 * interrupt controller can check for specific domains as necessary.
 	 */
 	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY)) {
-		of_node_put(par_np);
 		return -EPROBE_DEFER;
 	}
 
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index e82ed9d5c656..a9000b0ebe69 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -90,7 +90,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->dummy.nbytes)
-		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
+		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index c731a04731f8..ff3751a0345c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -856,7 +856,6 @@ static void xgbe_phy_free_phy_device(struct xgbe_prv_data *pdata)
 
 static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
 	unsigned int phy_id = phy_data->phydev->phy_id;
 
@@ -878,14 +877,7 @@ static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 	phy_write(phy_data->phydev, 0x04, 0x0d01);
 	phy_write(phy_data->phydev, 0x00, 0x9140);
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       supported);
-	linkmode_set_bit_array(phy_gbit_features_array,
-			       ARRAY_SIZE(phy_gbit_features_array),
-			       supported);
-
-	linkmode_copy(phy_data->phydev->supported, supported);
+	linkmode_copy(phy_data->phydev->supported, PHY_GBIT_FEATURES);
 
 	phy_support_asym_pause(phy_data->phydev);
 
@@ -897,7 +889,6 @@ static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 
 static bool xgbe_phy_belfuse_phy_quirks(struct xgbe_prv_data *pdata)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
 	struct xgbe_sfp_eeprom *sfp_eeprom = &phy_data->sfp_eeprom;
 	unsigned int phy_id = phy_data->phydev->phy_id;
@@ -961,13 +952,7 @@ static bool xgbe_phy_belfuse_phy_quirks(struct xgbe_prv_data *pdata)
 	reg = phy_read(phy_data->phydev, 0x00);
 	phy_write(phy_data->phydev, 0x00, reg & ~0x00800);
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       supported);
-	linkmode_set_bit_array(phy_gbit_features_array,
-			       ARRAY_SIZE(phy_gbit_features_array),
-			       supported);
-	linkmode_copy(phy_data->phydev->supported, supported);
+	linkmode_copy(phy_data->phydev->supported, PHY_GBIT_FEATURES);
 	phy_support_asym_pause(phy_data->phydev);
 
 	netif_dbg(pdata, drv, pdata->netdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 50fdc3cbb778..2717450e9666 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2421,6 +2421,7 @@ struct mlx5_flow_namespace *mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_TX:
 		root_ns = steering->rdma_tx_root_ns;
+		prio = RDMA_TX_BYPASS_PRIO;
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS:
 		root_ns = steering->rdma_rx_root_ns;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index 005661248c7e..9faa9ef863a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -540,7 +540,7 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
 	set_tt_map(port_sel, hash_type);
 	err = mlx5_lag_create_definers(ldev, hash_type, ports);
 	if (err)
-		return err;
+		goto clear_port_sel;
 
 	if (port_sel->tunnel) {
 		err = mlx5_lag_create_inner_ttc_table(ldev);
@@ -559,6 +559,8 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
 		mlx5_destroy_ttc_table(port_sel->inner.ttc);
 destroy_definers:
 	mlx5_lag_destroy_definers(ldev);
+clear_port_sel:
+	memset(port_sel, 0, sizeof(*port_sel));
 	return err;
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/offload.c b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
index 9d97cd281f18..c03558adda91 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
@@ -458,7 +458,8 @@ int nfp_bpf_event_output(struct nfp_app_bpf *bpf, const void *data,
 	map_id_full = be64_to_cpu(cbe->map_ptr);
 	map_id = map_id_full;
 
-	if (len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
+	if (size_add(pkt_size, data_size) > INT_MAX ||
+	    len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
 		return -EINVAL;
 	if (cbe->hdr.ver != NFP_CCM_ABI_VERSION)
 		return -EINVAL;
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 2647c18d40d9..3d42ca15e877 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -106,15 +106,15 @@ struct cpsw_ale_dev_id {
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx, idx2;
+	int idx, idx2, index;
 	u32 hi_val = 0;
 
 	idx    = start / 32;
 	idx2 = (start + bits - 1) / 32;
 	/* Check if bits to be fetched exceed a word */
 	if (idx != idx2) {
-		idx2 = 2 - idx2; /* flip */
-		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+		index = 2 - idx2; /* flip */
+		hi_val = ale_entry[index] << ((idx2 * 32) - start);
 	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
@@ -124,16 +124,16 @@ static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx, idx2;
+	int idx, idx2, index;
 
 	value &= BITMASK(bits);
 	idx = start / 32;
 	idx2 = (start + bits - 1) / 32;
 	/* Check if bits to be set exceed a word */
 	if (idx != idx2) {
-		idx2 = 2 - idx2; /* flip */
-		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
-		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+		index = 2 - idx2; /* flip */
+		ale_entry[index] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[index] |= (value >> ((idx2 * 32) - start));
 	}
 	start -= idx * 32;
 	idx = 2 - idx; /* flip */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index ce0dd78826af..a95772158176 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1570,6 +1570,12 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EFAULT;
 	}
 
+	if (ecoalesce->rx_max_coalesced_frames > 255 ||
+	    ecoalesce->tx_max_coalesced_frames > 255) {
+		NL_SET_ERR_MSG(extack, "frames must be less than 256");
+		return -EINVAL;
+	}
+
 	if (ecoalesce->rx_max_coalesced_frames)
 		lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
 	if (ecoalesce->rx_coalesce_usecs)
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 5e0332c9d0d7..0de3dcd07cb7 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1094,8 +1094,8 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 		goto out_encap;
 	}
 
-	gn = net_generic(dev_net(dev), gtp_net_id);
-	list_add_rcu(&gtp->list, &gn->gtp_dev_list);
+	gn = net_generic(src_net, gtp_net_id);
+	list_add(&gtp->list, &gn->gtp_dev_list);
 	dev->priv_destructor = gtp_destructor;
 
 	netdev_dbg(dev, "registered new GTP interface\n");
@@ -1121,7 +1121,7 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
 
-	list_del_rcu(&gtp->list);
+	list_del(&gtp->list);
 	unregister_netdevice_queue(dev, head);
 }
 
@@ -1689,16 +1689,19 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 	struct gtp_dev *last_gtp = (struct gtp_dev *)cb->args[2], *gtp;
 	int i, j, bucket = cb->args[0], skip = cb->args[1];
 	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
 	struct pdp_ctx *pctx;
-	struct gtp_net *gn;
-
-	gn = net_generic(net, gtp_net_id);
 
 	if (cb->args[4])
 		return 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(gtp, &gn->gtp_dev_list, list) {
+	for_each_netdev_rcu(net, dev) {
+		if (dev->rtnl_link_ops != &gtp_link_ops)
+			continue;
+
+		gtp = netdev_priv(dev);
+
 		if (last_gtp && last_gtp != gtp)
 			continue;
 		else
@@ -1883,23 +1886,28 @@ static int __net_init gtp_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit gtp_net_exit(struct net *net)
+static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_to_kill)
 {
-	struct gtp_net *gn = net_generic(net, gtp_net_id);
-	struct gtp_dev *gtp;
-	LIST_HEAD(list);
+	struct net *net;
 
-	rtnl_lock();
-	list_for_each_entry(gtp, &gn->gtp_dev_list, list)
-		gtp_dellink(gtp->dev, &list);
+	list_for_each_entry(net, net_list, exit_list) {
+		struct gtp_net *gn = net_generic(net, gtp_net_id);
+		struct gtp_dev *gtp, *gtp_next;
+		struct net_device *dev;
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		for_each_netdev(net, dev)
+			if (dev->rtnl_link_ops == &gtp_link_ops)
+				gtp_dellink(dev, dev_to_kill);
+
+		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
+			gtp_dellink(gtp->dev, dev_to_kill);
+	}
 }
 
 static struct pernet_operations gtp_net_ops = {
 	.init	= gtp_net_init,
-	.exit	= gtp_net_exit,
+	.exit_batch_rtnl = gtp_net_exit_batch_rtnl,
 	.id	= &gtp_net_id,
 	.size	= sizeof(struct gtp_net),
 };
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 79e09c7a82b3..d0705f2f4656 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2647,9 +2647,9 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 
 	netif_napi_del(&ar->napi);
 
-	ath10k_core_destroy(ar);
-
 	destroy_workqueue(ar_sdio->workqueue);
+
+	ath10k_core_destroy(ar);
 }
 
 static const struct sdio_device_id ath10k_sdio_devices[] = {
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c2d6cea0236b..ada58a4d0d0c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index fd3020a399cf..d3924a44db02 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -73,6 +73,10 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
+	/* Do not reassign resources if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index fbb47954a96c..5c1ab9ee65eb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3082,18 +3082,20 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
 	bus = bridge->bus;
 
-	/* If we must preserve the resource configuration, claim now */
-	if (bridge->preserve_config)
-		pci_bus_claim_resources(bus);
-
 	/*
-	 * Assign whatever was left unassigned. If we didn't claim above,
-	 * this will reassign everything.
+	 * We insert PCI resources into the iomem_resource and
+	 * ioport_resource trees in either pci_bus_claim_resources()
+	 * or pci_bus_assign_resources().
 	 */
-	pci_assign_unassigned_root_bus_resources(bus);
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_claim_resources(bus);
+	} else {
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
 
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
 
 	pci_bus_add_devices(bus);
 	return 0;
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 12344be14232..1946cc96c172 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -390,7 +390,6 @@ sg_release(struct inode *inode, struct file *filp)
 
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
-	kref_put(&sfp->f_ref, sg_remove_sfp);
 	sdp->open_cnt--;
 
 	/* possibly many open()s waiting on exlude clearing, start many;
@@ -402,6 +401,7 @@ sg_release(struct inode *inode, struct file *filp)
 		wake_up_interruptible(&sdp->open_wait);
 	}
 	mutex_unlock(&sdp->open_rel_lock);
+	kref_put(&sfp->f_ref, sg_remove_sfp);
 	return 0;
 }
 
diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 0f13853901df..9bc536ee1395 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -659,7 +659,7 @@ static int imx8mp_blk_ctrl_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(pdev->dev.of_node);
 
-	for (i = 0; bc->onecell_data.num_domains; i++) {
+	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1ea7ae78fca2..c5115f6adbdc 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9879,14 +9879,17 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	}
 
 	/*
-	 * Set the default power management level for runtime and system PM.
+	 * Set the default power management level for runtime and system PM if
+	 * not set by the host controller drivers.
 	 * Default power saving mode is to keep UFS link in Hibern8 state
 	 * and UFS device in sleep state.
 	 */
-	hba->rpm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
+	if (!hba->rpm_lvl)
+		hba->rpm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
 						UFS_SLEEP_PWR_MODE,
 						UIC_LINK_HIBERN8_STATE);
-	hba->spm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
+	if (!hba->spm_lvl)
+		hba->spm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
 						UFS_SLEEP_PWR_MODE,
 						UIC_LINK_HIBERN8_STATE);
 
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 89b11336a836..1806bff8e59b 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -15,6 +15,7 @@
 #include <linux/namei.h>
 #include <linux/poll.h>
 #include <linux/mount.h>
+#include <linux/security.h>
 #include <linux/statfs.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
@@ -576,7 +577,7 @@ static int cachefiles_daemon_dir(struct cachefiles_cache *cache, char *args)
  */
 static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 {
-	char *secctx;
+	int err;
 
 	_enter(",%s", args);
 
@@ -585,16 +586,16 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 		return -EINVAL;
 	}
 
-	if (cache->secctx) {
+	if (cache->have_secid) {
 		pr_err("Second security context specified\n");
 		return -EINVAL;
 	}
 
-	secctx = kstrdup(args, GFP_KERNEL);
-	if (!secctx)
-		return -ENOMEM;
+	err = security_secctx_to_secid(args, strlen(args), &cache->secid);
+	if (err)
+		return err;
 
-	cache->secctx = secctx;
+	cache->have_secid = true;
 	return 0;
 }
 
@@ -820,7 +821,6 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
-	kfree(cache->secctx);
 	kfree(cache->tag);
 
 	_leave("");
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 111ad6ecd4ba..4421a12960a6 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -122,7 +122,6 @@ struct cachefiles_cache {
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
 #define CACHEFILES_ONDEMAND_MODE	4	/* T if in on-demand read mode */
 	char				*rootdirname;	/* name of cache root directory */
-	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
 	refcount_t			unbind_pincount;/* refcount to do daemon unbind */
 	struct xarray			reqs;		/* xarray of pending on-demand requests */
@@ -130,6 +129,8 @@ struct cachefiles_cache {
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
 	u32				msg_id_next;
+	u32				secid;		/* LSM security id */
+	bool				have_secid;	/* whether "secid" was set */
 };
 
 static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
diff --git a/fs/cachefiles/security.c b/fs/cachefiles/security.c
index fe777164f1d8..fc6611886b3b 100644
--- a/fs/cachefiles/security.c
+++ b/fs/cachefiles/security.c
@@ -18,7 +18,7 @@ int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 	struct cred *new;
 	int ret;
 
-	_enter("{%s}", cache->secctx);
+	_enter("{%u}", cache->have_secid ? cache->secid : 0);
 
 	new = prepare_kernel_cred(current);
 	if (!new) {
@@ -26,8 +26,8 @@ int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 		goto error;
 	}
 
-	if (cache->secctx) {
-		ret = set_security_override_from_ctx(new, cache->secctx);
+	if (cache->have_secid) {
+		ret = set_security_override(new, cache->secid);
 		if (ret < 0) {
 			put_cred(new);
 			pr_err("Security denies permission to nominate security context: error %d\n",
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 44876a97cabd..1a4a614895c6 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -82,32 +82,27 @@ struct erofs_super_block {
 };
 
 /*
- * erofs inode datalayout (i_format in on-disk inode):
+ * EROFS inode datalayout (i_format in on-disk inode):
  * 0 - uncompressed flat inode without tail-packing inline data:
- * inode, [xattrs], ... | ... | no-holed data
  * 1 - compressed inode with non-compact indexes:
- * inode, [xattrs], [map_header], extents ... | ...
  * 2 - uncompressed flat inode with tail-packing inline data:
- * inode, [xattrs], tailpacking data, ... | ... | no-holed data
  * 3 - compressed inode with compact indexes:
- * inode, [xattrs], map_header, extents ... | ...
  * 4 - chunk-based inode with (optional) multi-device support:
- * inode, [xattrs], chunk indexes ... | ...
  * 5~7 - reserved
  */
 enum {
 	EROFS_INODE_FLAT_PLAIN			= 0,
-	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
+	EROFS_INODE_COMPRESSED_FULL		= 1,
 	EROFS_INODE_FLAT_INLINE			= 2,
-	EROFS_INODE_FLAT_COMPRESSION		= 3,
+	EROFS_INODE_COMPRESSED_COMPACT		= 3,
 	EROFS_INODE_CHUNK_BASED			= 4,
 	EROFS_INODE_DATALAYOUT_MAX
 };
 
 static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 {
-	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
-		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+	return datamode == EROFS_INODE_COMPRESSED_COMPACT ||
+		datamode == EROFS_INODE_COMPRESSED_FULL;
 }
 
 /* bit definitions of inode i_format */
@@ -128,11 +123,30 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_CHUNK_FORMAT_ALL	\
 	(EROFS_CHUNK_FORMAT_BLKBITS_MASK | EROFS_CHUNK_FORMAT_INDEXES)
 
+/* 32-byte on-disk inode */
+#define EROFS_INODE_LAYOUT_COMPACT	0
+/* 64-byte on-disk inode */
+#define EROFS_INODE_LAYOUT_EXTENDED	1
+
 struct erofs_inode_chunk_info {
 	__le16 format;		/* chunk blkbits, etc. */
 	__le16 reserved;
 };
 
+union erofs_inode_i_u {
+	/* total compressed blocks for compressed inodes */
+	__le32 compressed_blocks;
+
+	/* block address for uncompressed flat inodes */
+	__le32 raw_blkaddr;
+
+	/* for device files, used to indicate old/new device # */
+	__le32 rdev;
+
+	/* for chunk-based files, it contains the summary info */
+	struct erofs_inode_chunk_info c;
+};
+
 /* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_compact {
 	__le16 i_format;	/* inode format hints */
@@ -143,29 +157,14 @@ struct erofs_inode_compact {
 	__le16 i_nlink;
 	__le32 i_size;
 	__le32 i_reserved;
-	union {
-		/* total compressed blocks for compressed inodes */
-		__le32 compressed_blocks;
-		/* block address for uncompressed flat inodes */
-		__le32 raw_blkaddr;
-
-		/* for device files, used to indicate old/new device # */
-		__le32 rdev;
-
-		/* for chunk-based files, it contains the summary info */
-		struct erofs_inode_chunk_info c;
-	} i_u;
-	__le32 i_ino;           /* only used for 32-bit stat compatibility */
+	union erofs_inode_i_u i_u;
+
+	__le32 i_ino;		/* only used for 32-bit stat compatibility */
 	__le16 i_uid;
 	__le16 i_gid;
 	__le32 i_reserved2;
 };
 
-/* 32-byte on-disk inode */
-#define EROFS_INODE_LAYOUT_COMPACT	0
-/* 64-byte on-disk inode */
-#define EROFS_INODE_LAYOUT_EXTENDED	1
-
 /* 64-byte complete form of an ondisk inode */
 struct erofs_inode_extended {
 	__le16 i_format;	/* inode format hints */
@@ -175,22 +174,9 @@ struct erofs_inode_extended {
 	__le16 i_mode;
 	__le16 i_reserved;
 	__le64 i_size;
-	union {
-		/* total compressed blocks for compressed inodes */
-		__le32 compressed_blocks;
-		/* block address for uncompressed flat inodes */
-		__le32 raw_blkaddr;
-
-		/* for device files, used to indicate old/new device # */
-		__le32 rdev;
-
-		/* for chunk-based files, it contains the summary info */
-		struct erofs_inode_chunk_info c;
-	} i_u;
-
-	/* only used for 32-bit stat compatibility */
-	__le32 i_ino;
+	union erofs_inode_i_u i_u;
 
+	__le32 i_ino;		/* only used for 32-bit stat compatibility */
 	__le32 i_uid;
 	__le32 i_gid;
 	__le64 i_mtime;
@@ -199,10 +185,6 @@ struct erofs_inode_extended {
 	__u8   i_reserved2[16];
 };
 
-#define EROFS_MAX_SHARED_XATTRS         (128)
-/* h_shared_count between 129 ... 255 are special # */
-#define EROFS_SHARED_XATTR_EXTENT       (255)
-
 /*
  * inline xattrs (n == i_xattr_icount):
  * erofs_xattr_ibody_header(1) + (n - 1) * 4 bytes
@@ -268,6 +250,22 @@ struct erofs_inode_chunk_index {
 	__le32 blkaddr;		/* start block address of this inode chunk */
 };
 
+/* dirent sorts in alphabet order, thus we can do binary search */
+struct erofs_dirent {
+	__le64 nid;     /* node number */
+	__le16 nameoff; /* start offset of file name */
+	__u8 file_type; /* file type */
+	__u8 reserved;  /* reserved */
+} __packed;
+
+/*
+ * EROFS file types should match generic FT_* types and
+ * it seems no need to add BUILD_BUG_ONs since potential
+ * unmatchness will break other fses as well...
+ */
+
+#define EROFS_NAME_LEN      255
+
 /* maximum supported size of a physical compression cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
 
@@ -337,10 +335,8 @@ struct z_erofs_map_header {
 	__u8	h_clusterbits;
 };
 
-#define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
-
 /*
- * Fixed-sized output compression on-disk logical cluster type:
+ * On-disk logical cluster type:
  *    0   - literal (uncompressed) lcluster
  *    1,3 - compressed lcluster (for HEAD lclusters)
  *    2   - compressed lcluster (for NONHEAD lclusters)
@@ -364,27 +360,27 @@ struct z_erofs_map_header {
  *        di_u.delta[1] = distance to the next HEAD lcluster
  */
 enum {
-	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD1		= 1,
-	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD2		= 3,
-	Z_EROFS_VLE_CLUSTER_TYPE_MAX
+	Z_EROFS_LCLUSTER_TYPE_PLAIN	= 0,
+	Z_EROFS_LCLUSTER_TYPE_HEAD1	= 1,
+	Z_EROFS_LCLUSTER_TYPE_NONHEAD	= 2,
+	Z_EROFS_LCLUSTER_TYPE_HEAD2	= 3,
+	Z_EROFS_LCLUSTER_TYPE_MAX
 };
 
-#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
-#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
+#define Z_EROFS_LI_LCLUSTER_TYPE_BITS        2
+#define Z_EROFS_LI_LCLUSTER_TYPE_BIT         0
 
 /* (noncompact only, HEAD) This pcluster refers to partial decompressed data */
-#define Z_EROFS_VLE_DI_PARTIAL_REF		(1 << 15)
+#define Z_EROFS_LI_PARTIAL_REF		(1 << 15)
 
 /*
  * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
  * compressed block count of a compressed extent (in logical clusters, aka.
  * block count of a pcluster).
  */
-#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1 << 11)
+#define Z_EROFS_LI_D0_CBLKCNT		(1 << 11)
 
-struct z_erofs_vle_decompressed_index {
+struct z_erofs_lcluster_index {
 	__le16 di_advise;
 	/* where to decompress in the head lcluster */
 	__le16 di_clusterofs;
@@ -401,25 +397,8 @@ struct z_erofs_vle_decompressed_index {
 	} di_u;
 };
 
-#define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
-	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
-	 sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
-
-/* dirent sorts in alphabet order, thus we can do binary search */
-struct erofs_dirent {
-	__le64 nid;     /* node number */
-	__le16 nameoff; /* start offset of file name */
-	__u8 file_type; /* file type */
-	__u8 reserved;  /* reserved */
-} __packed;
-
-/*
- * EROFS file types should match generic FT_* types and
- * it seems no need to add BUILD_BUG_ONs since potential
- * unmatchness will break other fses as well...
- */
-
-#define EROFS_NAME_LEN      255
+#define Z_EROFS_FULL_INDEX_ALIGN(end)	\
+	(ALIGN(end, 8) + sizeof(struct z_erofs_map_header) + 8)
 
 /* check the EROFS on-disk layout strictly at compile time */
 static inline void erofs_check_ondisk_layout_definitions(void)
@@ -436,15 +415,15 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_info) != 4);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) != 8);
 	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
-	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
+	BUILD_BUG_ON(sizeof(struct z_erofs_lcluster_index) != 8);
 	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
 	/* keep in sync between 2 index structures for better extendibility */
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) !=
-		     sizeof(struct z_erofs_vle_decompressed_index));
+		     sizeof(struct z_erofs_lcluster_index));
 	BUILD_BUG_ON(sizeof(struct erofs_deviceslot) != 128);
 
-	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
-		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
+	BUILD_BUG_ON(BIT(Z_EROFS_LI_LCLUSTER_TYPE_BITS) <
+		     Z_EROFS_LCLUSTER_TYPE_MAX - 1);
 	/* exclude old compiler versions like gcc 7.5.0 */
 	BUILD_BUG_ON(__builtin_constant_p(fmh) ?
 		     fmh != cpu_to_le64(1ULL << 63) : 0);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 183e7a4b8259..2cd70cf4c8b2 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -14,7 +14,7 @@ int z_erofs_fill_inode(struct inode *inode)
 
 	if (!erofs_sb_has_big_pcluster(sbi) &&
 	    !erofs_sb_has_ztailpacking(sbi) && !erofs_sb_has_fragments(sbi) &&
-	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+	    vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
@@ -45,11 +45,10 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t pos =
-		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(erofs_iloc(inode) +
-				vi->inode_isize + vi->xattr_isize) +
-		lcn * sizeof(struct z_erofs_vle_decompressed_index);
-	struct z_erofs_vle_decompressed_index *di;
+	const erofs_off_t pos = Z_EROFS_FULL_INDEX_ALIGN(erofs_iloc(inode) +
+			vi->inode_isize + vi->xattr_isize) +
+			lcn * sizeof(struct z_erofs_lcluster_index);
+	struct z_erofs_lcluster_index *di;
 	unsigned int advise, type;
 
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
@@ -57,33 +56,33 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (IS_ERR(m->kaddr))
 		return PTR_ERR(m->kaddr);
 
-	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
+	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 	m->lcn = lcn;
 	di = m->kaddr + erofs_blkoff(inode->i_sb, pos);
 
 	advise = le16_to_cpu(di->di_advise);
-	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
-		((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
+	type = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
+		((1 << Z_EROFS_LI_LCLUSTER_TYPE_BITS) - 1);
 	switch (type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
-		if (m->delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!(vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
 					Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
 			m->compressedblks = m->delta[0] &
-				~Z_EROFS_VLE_DI_D0_CBLKCNT;
+				~Z_EROFS_LI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
 		break;
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
-		if (advise & Z_EROFS_VLE_DI_PARTIAL_REF)
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+		if (advise & Z_EROFS_LI_PARTIAL_REF)
 			m->partialref = true;
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
@@ -125,13 +124,13 @@ static int get_compacted_la_distance(unsigned int lclusterbits,
 		lo = decode_compactedbits(lclusterbits, lomask,
 					  in, encodebits * i, &type);
 
-		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 			return d1;
 		++d1;
 	} while (++i < vcnt);
 
-	/* vcnt - 1 (Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) item */
-	if (!(lo & Z_EROFS_VLE_DI_D0_CBLKCNT))
+	/* vcnt - 1 (Z_EROFS_LCLUSTER_TYPE_NONHEAD) item */
+	if (!(lo & Z_EROFS_LI_D0_CBLKCNT))
 		d1 += lo - 1;
 	return d1;
 }
@@ -169,19 +168,19 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	lo = decode_compactedbits(lclusterbits, lomask,
 				  in, encodebits * i, &type);
 	m->type = type;
-	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+	if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << lclusterbits;
 
 		/* figure out lookahead_distance: delta[1] if needed */
 		if (lookahead)
 			m->delta[1] = get_compacted_la_distance(lclusterbits,
 						encodebits, vcnt, in, i);
-		if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+		if (lo & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!big_pcluster) {
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedblks = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->compressedblks = lo & ~Z_EROFS_LI_D0_CBLKCNT;
 			m->delta[0] = 1;
 			return 0;
 		} else if (i + 1 != (int)vcnt) {
@@ -195,9 +194,9 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 		 */
 		lo = decode_compactedbits(lclusterbits, lomask,
 					  in, encodebits * (i - 1), &type);
-		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 			lo = 0;
-		else if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT)
+		else if (lo & Z_EROFS_LI_D0_CBLKCNT)
 			lo = 1;
 		m->delta[0] = lo + 1;
 		return 0;
@@ -211,7 +210,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 			--i;
 			lo = decode_compactedbits(lclusterbits, lomask,
 						  in, encodebits * i, &type);
-			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 				i -= lo;
 
 			if (i >= 0)
@@ -223,10 +222,10 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 			--i;
 			lo = decode_compactedbits(lclusterbits, lomask,
 						  in, encodebits * i, &type);
-			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
-				if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+				if (lo & Z_EROFS_LI_D0_CBLKCNT) {
 					--i;
-					nblk += lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+					nblk += lo & ~Z_EROFS_LI_D0_CBLKCNT;
 					continue;
 				}
 				/* bigpcluster shouldn't have plain d0 == 1 */
@@ -257,7 +256,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	unsigned int amortizedshift;
 	erofs_off_t pos;
 
-	if (lcn >= totalidx)
+	if (lcn >= totalidx || vi->z_logical_clusterbits > 14)
 		return -EINVAL;
 
 	m->lcn = lcn;
@@ -301,10 +300,10 @@ static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	const unsigned int datamode = EROFS_I(m->inode)->datalayout;
 
-	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+	if (datamode == EROFS_INODE_COMPRESSED_FULL)
 		return legacy_load_cluster_from_disk(m, lcn);
 
-	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+	if (datamode == EROFS_INODE_COMPRESSED_COMPACT)
 		return compacted_load_cluster_from_disk(m, lcn, lookahead);
 
 	return -EINVAL;
@@ -326,7 +325,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			return err;
 
 		switch (m->type) {
-		case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 			if (!m->delta[0]) {
 				erofs_err(m->inode->i_sb,
 					  "invalid lookback distance 0 @ nid %llu",
@@ -336,9 +335,9 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			}
 			lookback_distance = m->delta[0];
 			continue;
-		case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+		case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 			m->headtype = m->type;
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
@@ -367,15 +366,15 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	unsigned long lcn;
 	int err;
 
-	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
-		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 &&
-		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD2);
+	DBG_BUGON(m->type != Z_EROFS_LCLUSTER_TYPE_PLAIN &&
+		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD1 &&
+		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD2);
 	DBG_BUGON(m->type != m->headtype);
 
-	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1) &&
+	if (m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1) &&
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
-	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) &&
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) &&
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 		map->m_plen = 1ULL << lclusterbits;
 		return 0;
@@ -397,19 +396,19 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	 * BUG_ON in the debugging mode only for developers to notice that.
 	 */
 	DBG_BUGON(lcn == initial_lcn &&
-		  m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD);
+		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 
 	switch (m->type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
 		 */
 		m->compressedblks = 1 << (lclusterbits - sb->s_blocksize_bits);
 		break;
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
 			goto err_bonus_cblkcnt;
 		if (m->compressedblks)
@@ -442,7 +441,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
 	int err;
 
-	do {
+	while (1) {
 		/* handle the last EOF pcluster (no next HEAD lcluster) */
 		if ((lcn << lclusterbits) >= inode->i_size) {
 			map->m_llen = inode->i_size - map->m_la;
@@ -453,15 +452,17 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 		if (err)
 			return err;
 
-		if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
-			DBG_BUGON(!m->delta[1] &&
-				  m->clusterofs != 1 << lclusterbits);
-		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 ||
-			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
-			/* go on until the next HEAD lcluster */
+		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+			/* work around invalid d1 generated by pre-1.0 mkfs */
+			if (unlikely(!m->delta[1])) {
+				m->delta[1] = 1;
+				DBG_BUGON(1);
+			}
+		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
+			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
 			if (lcn != headlcn)
-				break;
+				break;	/* ends at the next HEAD lcluster */
 			m->delta[1] = 1;
 		} else {
 			erofs_err(inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
@@ -470,15 +471,13 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			return -EOPNOTSUPP;
 		}
 		lcn += m->delta[1];
-	} while (m->delta[1]);
-
+	}
 	map->m_llen = (lcn << lclusterbits) + m->clusterofs - map->m_la;
 	return 0;
 }
 
 static int z_erofs_do_map_blocks(struct inode *inode,
-				 struct erofs_map_blocks *map,
-				 int flags)
+				 struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
@@ -508,9 +507,9 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	end = (m.lcn + 1ULL) << lclusterbits;
 
 	switch (m.type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
@@ -535,7 +534,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
 		fallthrough;
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
 		if (err)
@@ -556,7 +555,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		vi->z_tailextent_headlcn = m.lcn;
 		/* for non-compact indexes, fragmentoff is 64 bits */
 		if (fragment &&
-		    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		    vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
 			vi->z_fragmentoff |= (u64)m.pblk << 32;
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
@@ -572,7 +571,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 	}
 
-	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
+	if (m.headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN) {
 		if (map->m_llen > map->m_plen) {
 			DBG_BUGON(1);
 			err = -EFSCORRUPTED;
@@ -582,7 +581,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			Z_EROFS_COMPRESSION_INTERLACED :
 			Z_EROFS_COMPRESSION_SHIFTED;
 	} else {
-		afmt = m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2 ?
+		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
 			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
 		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
 			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
@@ -676,7 +675,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		err = -EFSCORRUPTED;
 		goto out_put_metabuf;
 	}
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
 		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
diff --git a/fs/file.c b/fs/file.c
index 48f0b28da524..bc0c087b31bb 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/close_range.h>
 #include <net/sock.h>
+#include <linux/init_task.h>
 
 #include "internal.h"
 
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 6764afa98a6f..431bdc65f723 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -418,11 +418,13 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 		goto bail_no_root;
 	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
 	if (!res) {
-		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) {
+		if (fd.entrylength != sizeof(rec.dir)) {
 			res =  -EIO;
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
+		if (rec.type != HFS_CDR_DIR)
+			res = -EIO;
 	}
 	if (res)
 		goto bail_hfs_find;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 47f44b02c17d..70e246f7e8fe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -907,7 +907,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 		}
 
 		/* move offset to start of next folio in range */
-		start_byte = folio_next_index(folio) << PAGE_SHIFT;
+		start_byte = folio_pos(folio) + folio_size(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 	}
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index c9393c732889..46eb06e32f0c 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -219,6 +219,7 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 		return NULL;
 
 	INIT_LIST_HEAD(&nf->nf_lru);
+	INIT_LIST_HEAD(&nf->nf_gc);
 	nf->nf_birthtime = ktime_get();
 	nf->nf_file = NULL;
 	nf->nf_cred = get_current_cred();
@@ -396,8 +397,8 @@ nfsd_file_dispose_list(struct list_head *dispose)
 	struct nfsd_file *nf;
 
 	while (!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
+		nf = list_first_entry(dispose, struct nfsd_file, nf_gc);
+		list_del_init(&nf->nf_gc);
 		nfsd_file_free(nf);
 	}
 }
@@ -414,12 +415,12 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
 	while(!list_empty(dispose)) {
 		struct nfsd_file *nf = list_first_entry(dispose,
-						struct nfsd_file, nf_lru);
+						struct nfsd_file, nf_gc);
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
 		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
 		spin_lock(&l->lock);
-		list_move_tail(&nf->nf_lru, &l->freeme);
+		list_move_tail(&nf->nf_gc, &l->freeme);
 		spin_unlock(&l->lock);
 		queue_work(nfsd_filecache_wq, &l->work);
 	}
@@ -476,7 +477,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 
 	/* Refcount went to zero. Unhash it and queue it to the dispose list */
 	nfsd_file_unhash(nf);
-	list_lru_isolate_move(lru, &nf->nf_lru, head);
+	list_lru_isolate(lru, &nf->nf_lru);
+	list_add(&nf->nf_gc, head);
 	this_cpu_inc(nfsd_file_evictions);
 	trace_nfsd_file_gc_disposed(nf);
 	return LRU_REMOVED;
@@ -555,7 +557,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose)
 
 	/* If refcount goes to 0, then put on the dispose list */
 	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
-		list_add(&nf->nf_lru, dispose);
+		list_add(&nf->nf_gc, dispose);
 		trace_nfsd_file_closing(nf);
 	}
 }
@@ -631,8 +633,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
 
 	nfsd_file_queue_for_close(inode, &dispose);
 	while (!list_empty(&dispose)) {
-		nf = list_first_entry(&dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
+		nf = list_first_entry(&dispose, struct nfsd_file, nf_gc);
+		list_del_init(&nf->nf_gc);
 		nfsd_file_free(nf);
 	}
 	flush_delayed_fput();
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index e54165a3224f..bf7a630f1a45 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -44,6 +44,7 @@ struct nfsd_file {
 
 	struct nfsd_file_mark	*nf_mark;
 	struct list_head	nf_lru;
+	struct list_head	nf_gc;
 	struct rcu_head		nf_rcu;
 	ktime_t			nf_birthtime;
 };
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 147cc771d5a6..3f5a4a5e1a82 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -404,6 +404,8 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 			if (!iov_iter_count(iter))
 				return acc;
 		}
+
+		cond_resched();
 	}
 
 	return acc;
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 254d4a898179..8f77bb0f4ae0 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -532,6 +532,7 @@ extern void __init hrtimers_init(void);
 extern void sysrq_timer_list_show(void);
 
 int hrtimers_prepare_cpu(unsigned int cpu);
+int hrtimers_cpu_starting(unsigned int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 int hrtimers_cpu_dying(unsigned int cpu);
 #else
diff --git a/include/linux/poll.h b/include/linux/poll.h
index d1ea4f3714a8..fc641b50f129 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -41,8 +41,16 @@ typedef struct poll_table_struct {
 
 static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
-	if (p && p->_qproc && wait_address)
+	if (p && p->_qproc && wait_address) {
 		p->_qproc(filp, wait_address, p);
+		/*
+		 * This memory barrier is paired in the wq_has_sleeper().
+		 * See the comment above prepare_to_wait(), we need to
+		 * ensure that subsequent tests in this thread can't be
+		 * reordered with __add_wait_queue() in _qproc() paths.
+		 */
+		smp_mb();
+	}
 }
 
 /*
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 7ca4b7af57ca..17c7a8841834 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -426,6 +426,9 @@ struct pernet_operations {
 	void (*pre_exit)(struct net *net);
 	void (*exit)(struct net *net);
 	void (*exit_batch)(struct list_head *net_exit_list);
+	/* Following method is called with RTNL held. */
+	void (*exit_batch_rtnl)(struct list_head *net_exit_list,
+				struct list_head *dev_kill_list);
 	unsigned int *id;
 	size_t size;
 };
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4044e4d80cbb..900e45f5dd0e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1824,7 +1824,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	},
 	[CPUHP_AP_HRTIMERS_DYING] = {
 		.name			= "hrtimers:dying",
-		.startup.single		= NULL,
+		.startup.single		= hrtimers_cpu_starting,
 		.teardown.single	= hrtimers_cpu_dying,
 	},
 
diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 12bcd08fe79d..5d506c6e8c0e 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -82,6 +82,7 @@ find $cpio_dir -type f -print0 |
 
 # Create archive and try to normalize metadata for reproducibility.
 tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+    --exclude=".__afs*" --exclude=".nfs*" \
     --owner=0 --group=0 --sort=name --numeric-owner --mode=u=rw,go=r,a+X \
     -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f62cc13b5f14..8db65e2db14c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2177,6 +2177,15 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	}
 
 	cpu_base->cpu = cpu;
+	hrtimer_cpu_base_init_expiry_lock(cpu_base);
+	return 0;
+}
+
+int hrtimers_cpu_starting(unsigned int cpu)
+{
+	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
+
+	/* Clear out any left over state from a CPU down operation */
 	cpu_base->active_bases = 0;
 	cpu_base->hres_active = 0;
 	cpu_base->hang_detected = 0;
@@ -2185,7 +2194,6 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
 	cpu_base->online = 1;
-	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
 
@@ -2263,6 +2271,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 void __init hrtimers_init(void)
 {
 	hrtimers_prepare_cpu(smp_processor_id());
+	hrtimers_cpu_starting(smp_processor_id());
 	open_softirq(HRTIMER_SOFTIRQ, hrtimer_run_softirq);
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index dc23b1336a8b..78bf403473fb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2938,7 +2938,7 @@ static inline loff_t folio_seek_hole_data(struct xa_state *xas,
 		if (ops->is_partially_uptodate(folio, offset, bsz) ==
 							seek_data)
 			break;
-		start = (start + bsz) & ~(bsz - 1);
+		start = (start + bsz) & ~((u64)bsz - 1);
 		offset += bsz;
 	} while (offset < folio_size(folio));
 unlock:
diff --git a/net/core/filter.c b/net/core/filter.c
index 7f9d703b00e7..b35615c469e2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11109,6 +11109,7 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 	bool is_sockarray = map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY;
 	struct sock_reuseport *reuse;
 	struct sock *selected_sk;
+	int err;
 
 	selected_sk = map->ops->map_lookup_elem(map, key);
 	if (!selected_sk)
@@ -11116,10 +11117,6 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 
 	reuse = rcu_dereference(selected_sk->sk_reuseport_cb);
 	if (!reuse) {
-		/* Lookup in sock_map can return TCP ESTABLISHED sockets. */
-		if (sk_is_refcounted(selected_sk))
-			sock_put(selected_sk);
-
 		/* reuseport_array has only sk with non NULL sk_reuseport_cb.
 		 * The only (!reuse) case here is - the sk has already been
 		 * unhashed (e.g. by close()), so treat it as -ENOENT.
@@ -11127,24 +11124,33 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 		 * Other maps (e.g. sock_map) do not provide this guarantee and
 		 * the sk may never be in the reuseport group to begin with.
 		 */
-		return is_sockarray ? -ENOENT : -EINVAL;
+		err = is_sockarray ? -ENOENT : -EINVAL;
+		goto error;
 	}
 
 	if (unlikely(reuse->reuseport_id != reuse_kern->reuseport_id)) {
 		struct sock *sk = reuse_kern->sk;
 
-		if (sk->sk_protocol != selected_sk->sk_protocol)
-			return -EPROTOTYPE;
-		else if (sk->sk_family != selected_sk->sk_family)
-			return -EAFNOSUPPORT;
-
-		/* Catch all. Likely bound to a different sockaddr. */
-		return -EBADFD;
+		if (sk->sk_protocol != selected_sk->sk_protocol) {
+			err = -EPROTOTYPE;
+		} else if (sk->sk_family != selected_sk->sk_family) {
+			err = -EAFNOSUPPORT;
+		} else {
+			/* Catch all. Likely bound to a different sockaddr. */
+			err = -EBADFD;
+		}
+		goto error;
 	}
 
 	reuse_kern->selected_sk = selected_sk;
 
 	return 0;
+error:
+	/* Lookup in sock_map can return TCP ESTABLISHED sockets. */
+	if (sk_is_refcounted(selected_sk))
+		sock_put(selected_sk);
+
+	return err;
 }
 
 static const struct bpf_func_proto sk_select_reuseport_proto = {
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 6c6d2a785c00..abf1e1751d6c 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -314,8 +314,9 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 {
 	/* Must be called with pernet_ops_rwsem held */
 	const struct pernet_operations *ops, *saved_ops;
-	int error = 0;
 	LIST_HEAD(net_exit_list);
+	LIST_HEAD(dev_kill_list);
+	int error = 0;
 
 	refcount_set(&net->ns.count, 1);
 	ref_tracker_dir_init(&net->refcnt_tracker, 128);
@@ -353,6 +354,15 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 
 	synchronize_rcu();
 
+	ops = saved_ops;
+	rtnl_lock();
+	list_for_each_entry_continue_reverse(ops, &pernet_list, list) {
+		if (ops->exit_batch_rtnl)
+			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
+	}
+	unregister_netdevice_many(&dev_kill_list);
+	rtnl_unlock();
+
 	ops = saved_ops;
 	list_for_each_entry_continue_reverse(ops, &pernet_list, list)
 		ops_exit_list(ops, &net_exit_list);
@@ -576,6 +586,7 @@ static void cleanup_net(struct work_struct *work)
 	struct net *net, *tmp, *last;
 	struct llist_node *net_kill_list;
 	LIST_HEAD(net_exit_list);
+	LIST_HEAD(dev_kill_list);
 
 	/* Atomically snapshot the list of namespaces to cleanup */
 	net_kill_list = llist_del_all(&cleanup_list);
@@ -616,6 +627,14 @@ static void cleanup_net(struct work_struct *work)
 	 */
 	synchronize_rcu();
 
+	rtnl_lock();
+	list_for_each_entry_reverse(ops, &pernet_list, list) {
+		if (ops->exit_batch_rtnl)
+			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
+	}
+	unregister_netdevice_many(&dev_kill_list);
+	rtnl_unlock();
+
 	/* Run all of the network namespace exit methods */
 	list_for_each_entry_reverse(ops, &pernet_list, list)
 		ops_exit_list(ops, &net_exit_list);
@@ -1159,7 +1178,17 @@ static void free_exit_list(struct pernet_operations *ops, struct list_head *net_
 {
 	ops_pre_exit_list(ops, net_exit_list);
 	synchronize_rcu();
+
+	if (ops->exit_batch_rtnl) {
+		LIST_HEAD(dev_kill_list);
+
+		rtnl_lock();
+		ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
+		unregister_netdevice_many(&dev_kill_list);
+		rtnl_unlock();
+	}
 	ops_exit_list(ops, net_exit_list);
+
 	ops_free_list(ops, net_exit_list);
 }
 
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 471d4effa8b4..a2fb951996b8 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -850,6 +850,9 @@ static ssize_t get_imix_entries(const char __user *buffer,
 		unsigned long weight;
 		unsigned long size;
 
+		if (pkt_dev->n_imix_entries >= MAX_IMIX_ENTRIES)
+			return -E2BIG;
+
 		len = num_arg(&buffer[i], max_digits, &size);
 		if (len < 0)
 			return len;
@@ -879,9 +882,6 @@ static ssize_t get_imix_entries(const char __user *buffer,
 
 		i++;
 		pkt_dev->n_imix_entries++;
-
-		if (pkt_dev->n_imix_entries > MAX_IMIX_ENTRIES)
-			return -E2BIG;
 	} while (c == ' ');
 
 	return i;
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index d90bb941f2ad..8f5f56b1e5f8 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -615,7 +615,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all && sk->sk_state != DCCP_LISTEN)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	if (sk->sk_state == DCCP_OPEN) { /* Fast path */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 06b4acbfd314..0ccaa78f6ff3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1463,7 +1463,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all)
+	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
@@ -1502,8 +1502,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb))
 				goto reset;
-			if (opt_skb)
-				__kfree_skb(opt_skb);
 			return 0;
 		}
 	} else
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 7e2065e72915..0233929502ec 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -689,6 +689,10 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 	ASSERT_RTNL();
 
 	mutex_lock(&sdata->local->iflist_mtx);
+	if (list_empty(&sdata->local->interfaces)) {
+		mutex_unlock(&sdata->local->iflist_mtx);
+		return;
+	}
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e8224e1eb72a..c4aa1b85bc61 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -605,7 +605,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	}
 	opts->ext_copy.use_ack = 1;
 	opts->suboptions = OPTION_MPTCP_DSS;
-	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
 
 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size == 0)
@@ -1265,7 +1264,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 			}
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
 		}
-		return;
+		goto update_wspace;
 	}
 
 	if (rcv_wnd_new != rcv_wnd_old) {
@@ -1290,6 +1289,9 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 		th->window = htons(new_win);
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDSHARED);
 	}
+
+update_wspace:
+	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
 }
 
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 21102ffe4470..18d360aaf09b 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -913,7 +913,9 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 {
 	struct vport *vport = ovs_vport_rcu(dp, out_port);
 
-	if (likely(vport && netif_carrier_ok(vport->dev))) {
+	if (likely(vport &&
+		   netif_running(vport->dev) &&
+		   netif_carrier_ok(vport->dev))) {
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 84471745c082..88b5702a0a47 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -485,6 +485,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		 */
 		vsk->transport->release(vsk);
 		vsock_deassign_transport(vsk);
+
+		/* transport's release() and destruct() can touch some socket
+		 * state, since we are reassigning the socket to a new transport
+		 * during vsock_connect(), let's reset these fields to have a
+		 * clean state.
+		 */
+		sock_reset_flag(sk, SOCK_DONE);
+		sk->sk_state = TCP_CLOSE;
+		vsk->peer_shutdown = 0;
 	}
 
 	/* We increase the module refcnt to prevent the transport unloading
@@ -864,6 +873,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
 
 s64 vsock_stream_has_data(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_data(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_data);
@@ -872,6 +884,9 @@ static s64 vsock_connectible_has_data(struct vsock_sock *vsk)
 {
 	struct sock *sk = sk_vsock(vsk);
 
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	if (sk->sk_type == SOCK_SEQPACKET)
 		return vsk->transport->seqpacket_has_data(vsk);
 	else
@@ -880,6 +895,9 @@ static s64 vsock_connectible_has_data(struct vsock_sock *vsk)
 
 s64 vsock_stream_has_space(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_space(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_space);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 3bc573cbf8a6..a65da57fe26f 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -26,6 +26,9 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout);
+
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
 {
@@ -826,6 +829,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
 
+	virtio_transport_cancel_close_work(vsk, true);
+
 	kfree(vvs);
 	vsk->trans = NULL;
 }
@@ -910,17 +915,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
 	}
 }
 
-static void virtio_transport_do_close(struct vsock_sock *vsk,
-				      bool cancel_timeout)
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout)
 {
 	struct sock *sk = sk_vsock(vsk);
 
-	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
-	if (vsock_stream_has_data(vsk) <= 0)
-		sk->sk_state = TCP_CLOSING;
-	sk->sk_state_change(sk);
-
 	if (vsk->close_work_scheduled &&
 	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
 		vsk->close_work_scheduled = false;
@@ -932,6 +931,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
 	}
 }
 
+static void virtio_transport_do_close(struct vsock_sock *vsk,
+				      bool cancel_timeout)
+{
+	struct sock *sk = sk_vsock(vsk);
+
+	sock_set_flag(sk, SOCK_DONE);
+	vsk->peer_shutdown = SHUTDOWN_MASK;
+	if (vsock_stream_has_data(vsk) <= 0)
+		sk->sk_state = TCP_CLOSING;
+	sk->sk_state_change(sk);
+
+	virtio_transport_cancel_close_work(vsk, cancel_timeout);
+}
+
 static void virtio_transport_close_timeout(struct work_struct *work)
 {
 	struct vsock_sock *vsk =
@@ -1334,8 +1347,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed before lock_sock */
-	if (sock_flag(sk, SOCK_DONE)) {
+	/* Check if sk has been closed or assigned to another transport before
+	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d124a10ab619..eec488aa7890 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10242,6 +10242,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b6b9f41dbc29..b9b947b30772 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -25,6 +25,8 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 
+#include <arpa/inet.h>
+
 #include <netdb.h>
 #include <netinet/in.h>
 
@@ -1131,23 +1133,42 @@ static void parse_setsock_options(const char *name)
 	exit(1);
 }
 
-void xdisconnect(int fd, int addrlen)
+void xdisconnect(int fd)
 {
-	struct sockaddr_storage empty;
+	socklen_t addrlen = sizeof(struct sockaddr_storage);
+	struct sockaddr_storage addr, empty;
 	int msec_sleep = 10;
-	int queued = 1;
-	int i;
+	void *raw_addr;
+	int i, cmdlen;
+	char cmd[128];
+
+	/* get the local address and convert it to string */
+	if (getsockname(fd, (struct sockaddr *)&addr, &addrlen) < 0)
+		xerror("getsockname");
+
+	if (addr.ss_family == AF_INET)
+		raw_addr = &(((struct sockaddr_in *)&addr)->sin_addr);
+	else if (addr.ss_family == AF_INET6)
+		raw_addr = &(((struct sockaddr_in6 *)&addr)->sin6_addr);
+	else
+		xerror("bad family");
+
+	strcpy(cmd, "ss -M | grep -q ");
+	cmdlen = strlen(cmd);
+	if (!inet_ntop(addr.ss_family, raw_addr, &cmd[cmdlen],
+		       sizeof(cmd) - cmdlen))
+		xerror("inet_ntop");
 
 	shutdown(fd, SHUT_WR);
 
-	/* while until the pending data is completely flushed, the later
+	/*
+	 * wait until the pending data is completely flushed and all
+	 * the MPTCP sockets reached the closed status.
 	 * disconnect will bypass/ignore/drop any pending data.
 	 */
 	for (i = 0; ; i += msec_sleep) {
-		if (ioctl(fd, SIOCOUTQ, &queued) < 0)
-			xerror("can't query out socket queue: %d", errno);
-
-		if (!queued)
+		/* closed socket are not listed by 'ss' */
+		if (system(cmd) != 0)
 			break;
 
 		if (i > poll_timeout)
@@ -1195,9 +1216,9 @@ int main_loop(void)
 		return ret;
 
 	if (cfg_truncate > 0) {
-		xdisconnect(fd, peer->ai_addrlen);
+		xdisconnect(fd);
 	} else if (--cfg_repeat > 0) {
-		xdisconnect(fd, peer->ai_addrlen);
+		xdisconnect(fd);
 
 		/* the socket could be unblocking at this point, we need the
 		 * connect to be blocking
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
index 58189327f644..383fbda07245 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
@@ -78,10 +78,10 @@
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
-        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 protocol ip flow map key dst rshift 0xff",
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 protocol ip flow map key dst rshift 0x1f",
         "expExitCode": "0",
         "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 protocol ip prio 1 flow",
-        "matchPattern": "filter parent ffff: protocol ip pref 1 flow chain [0-9]+ handle 0x1 map keys dst rshift 255 baseclass",
+        "matchPattern": "filter parent ffff: protocol ip pref 1 flow chain [0-9]+ handle 0x1 map keys dst rshift 31 baseclass",
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"

