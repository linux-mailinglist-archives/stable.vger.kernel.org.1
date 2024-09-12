Return-Path: <stable+bounces-75983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C097681C
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F3F283109
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198171A0BD3;
	Thu, 12 Sep 2024 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y2s+Ticc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE49185B5C;
	Thu, 12 Sep 2024 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141700; cv=none; b=ftzIuw7SlrfFTJQtH6E9KvynuqMOMjPNxrVsvy9JJevmcVcF258aR2113iCHPycQpaZ8Vf8abWMNwnFQX3ztTrVelzkkzNEofTaVPcHPGR8fNVDTgHb/ofYA9HdZlmvvc5lAP8uwpaqpGviyppHX4Tmk6ygBkkWTGdjh9+RKxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141700; c=relaxed/simple;
	bh=LbnNMLXJsL+NkDdcEWBBeEdshb8VKaQW1SMAqysAL3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDTt3Em8mADbGvnKAMByLegw//g8pP3gMajHW9mWgA3H8QLurSIDz5ba2t/J6yVln7QJm4kyNJz+6HlqWDtdtKqR9gd9tXFxSnKvTCsNOPHnPQv+jGjYaqAdcDFW3uKpXSxlGW7z0EUkACHGbM/FGXzFtvg4W2FQ5jgG3pDg1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y2s+Ticc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070D1C4CEC3;
	Thu, 12 Sep 2024 11:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726141700;
	bh=LbnNMLXJsL+NkDdcEWBBeEdshb8VKaQW1SMAqysAL3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y2s+Ticc1mWs54X1uRW6WfQCmY2UizhZRDLBhmcqhbTC/nmi49DWk7HuGtHTW6zum
	 cEyUN2OGRd9lZWSryDXOXzAmqfo6KmfSxW8NlRvjquMush/mUBuNhtusCSsTavtE9C
	 4TdBYfB9ueod3GeAJZ7UqGoGl2AUpq3htdmOuwhA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.322
Date: Thu, 12 Sep 2024 13:48:07 +0200
Message-ID: <2024091207-mounted-daytime-e888@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024091207-muster-slapping-175b@gregkh>
References: <2024091207-muster-slapping-175b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 723ac1456b14..64cc724be113 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 321
+SUBLEVEL = 322
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 6b20a0a11913..11c1505775f8 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -524,7 +524,7 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 
 	old_regs = set_irq_regs(regs);
 	local_irq_disable();
-	irq_enter_rcu();
+	irq_enter();
 
 	eirr_val = mfctl(23) & cpu_eiem & per_cpu(local_ack_eiem, cpu);
 	if (!eirr_val)
@@ -559,7 +559,7 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 #endif /* CONFIG_IRQSTACKS */
 
  out:
-	irq_exit_rcu();
+	irq_exit();
 	set_irq_regs(old_regs);
 	return;
 
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 71e26488dfde..b5c3bc0e6bce 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -391,6 +391,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -414,6 +415,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 469e30a6d3cd..c82b558207d3 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -227,6 +227,7 @@ bool bio_integrity_prep(struct bio *bio)
 	unsigned int bytes, offset, i;
 	unsigned int intervals;
 	blk_status_t status;
+	gfp_t gfp = GFP_NOIO;
 
 	if (!bi)
 		return true;
@@ -249,12 +250,20 @@ bool bio_integrity_prep(struct bio *bio)
 		if (!bi->profile->generate_fn ||
 		    !(bi->flags & BLK_INTEGRITY_GENERATE))
 			return true;
+
+		/*
+		 * Zero the memory allocated to not leak uninitialized kernel
+		 * memory to disk.  For PI this only affects the app tag, but
+		 * for non-integrity metadata it affects the entire metadata
+		 * buffer.
+		 */
+		gfp |= __GFP_ZERO;
 	}
 	intervals = bio_integrity_intervals(bi, bio_sectors(bio));
 
 	/* Allocate kernel buffer for protection data */
 	len = intervals * bi->tuple_size;
-	buf = kmalloc(len, GFP_NOIO | q->bounce_gfp);
+	buf = kmalloc(len, gfp | q->bounce_gfp);
 	status = BLK_STS_RESOURCE;
 	if (unlikely(buf == NULL)) {
 		printk(KERN_ERR "could not allocate integrity buffer\n");
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index a448cdf56718..925ceb0eddaf 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -391,7 +391,7 @@ static int acpi_processor_add(struct acpi_device *device,
 
 	result = acpi_processor_get_info(device);
 	if (result) /* Processor is not physically present or unavailable */
-		return 0;
+		goto err_clear_driver_data;
 
 	BUG_ON(pr->id >= nr_cpu_ids);
 
@@ -406,7 +406,7 @@ static int acpi_processor_add(struct acpi_device *device,
 			"BIOS reported wrong ACPI id %d for the processor\n",
 			pr->id);
 		/* Give up, but do not abort the namespace scan. */
-		goto err;
+		goto err_clear_driver_data;
 	}
 	/*
 	 * processor_device_array is not cleared on errors to allow buggy BIOS
@@ -418,12 +418,12 @@ static int acpi_processor_add(struct acpi_device *device,
 	dev = get_cpu_device(pr->id);
 	if (!dev) {
 		result = -ENODEV;
-		goto err;
+		goto err_clear_per_cpu;
 	}
 
 	result = acpi_bind_one(dev, device);
 	if (result)
-		goto err;
+		goto err_clear_per_cpu;
 
 	pr->dev = dev;
 
@@ -434,10 +434,11 @@ static int acpi_processor_add(struct acpi_device *device,
 	dev_err(dev, "Processor driver could not be attached\n");
 	acpi_unbind_one(dev);
 
- err:
-	free_cpumask_var(pr->throttling.shared_cpu_map);
-	device->driver_data = NULL;
+ err_clear_per_cpu:
 	per_cpu(processors, pr->id) = NULL;
+ err_clear_driver_data:
+	device->driver_data = NULL;
+	free_cpumask_var(pr->throttling.shared_cpu_map);
  err_free_pr:
 	kfree(pr);
 	return result;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5d931409c21e..e9ad4466bec1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6221,8 +6221,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	}
 
 	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
-	if (!dr)
+	if (!dr) {
+		kfree(host);
 		goto err_out;
+	}
 
 	devres_add(dev, dr);
 	dev_set_drvdata(dev, host);
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 765b99319d3c..7beb5dd9ff87 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -537,7 +537,8 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
 
 		while (sg_len) {
 			/* table overflow should never happen */
-			BUG_ON (pi++ >= MAX_DCMDS);
+			if (WARN_ON_ONCE(pi >= MAX_DCMDS))
+				return AC_ERR_SYSTEM;
 
 			len = (sg_len < MAX_DBDMA_SEG) ? sg_len : MAX_DBDMA_SEG;
 			table->command = cpu_to_le16(write ? OUTPUT_MORE: INPUT_MORE);
@@ -549,11 +550,13 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
 			addr += len;
 			sg_len -= len;
 			++table;
+			++pi;
 		}
 	}
 
 	/* Should never happen according to Tejun */
-	BUG_ON(!pi);
+	if (WARN_ON_ONCE(!pi))
+		return AC_ERR_SYSTEM;
 
 	/* Convert the last command to an input/output */
 	table--;
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index a64f70a62e28..f9e5deb72db6 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -559,6 +559,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index a91d97cecbad..dc2d34602968 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -37,7 +37,7 @@
 
 #define PLL_USER_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_USER_CTL])
 # define PLL_POST_DIV_SHIFT	8
-# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width, 0)
+# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width - 1, 0)
 # define PLL_ALPHA_EN		BIT(24)
 # define PLL_ALPHA_MODE		BIT(25)
 # define PLL_VCO_SHIFT		20
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index b7aa2b817078..83b136324e8b 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -96,20 +96,28 @@ static int __init tpm_clocksource_init(unsigned long rate)
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
-	unsigned long next, now;
+	unsigned long next, prev, now;
 
-	next = tpm_read_counter();
-	next += delta;
+	prev = tpm_read_counter();
+	next = prev + delta;
 	writel(next, timer_base + TPM_C0V);
 	now = tpm_read_counter();
 
+	/*
+	 * Need to wait CNT increase at least 1 cycle to make sure
+	 * the C0V has been updated into HW.
+	 */
+	if ((next & 0xffffffff) != readl(timer_base + TPM_C0V))
+		while (now == tpm_read_counter())
+			;
+
 	/*
 	 * NOTE: We observed in a very small probability, the bus fabric
 	 * contention between GPU and A7 may results a few cycles delay
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)(next - now) <= 0 ? -ETIME : 0;
+	return (now - prev) >= delta ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
index 3889486f71fe..5272cf1708cd 100644
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
index 95f7bb22402f..fe01df99445d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1625,6 +1625,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 										(u32)le32_to_cpu(*((u32 *)reg_data + j));
 									j++;
 								} else if ((reg_table->mc_reg_address[i].pre_reg_data & LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
+									if (i == 0)
+										continue;
 									reg_table->mc_reg_table_entry[num_ranges].mc_data[i] =
 										reg_table->mc_reg_table_entry[num_ranges].mc_data[i - 1];
 								}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 387f1cf1dc20..9e768ff392fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -212,6 +212,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		struct amdgpu_firmware_info *ucode;
 
 		id = fw_type_convert(cgs_device, type);
+		if (id >= AMDGPU_UCODE_ID_MAXIMUM)
+			return -EINVAL;
+
 		ucode = &adev->firmware.ucode[id];
 		if (ucode->fw == NULL)
 			return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 93794a85f83d..d1efab227034 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -497,8 +497,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	int r, i;
 	uint32_t value, result, early[3];
+	loff_t i;
+	int r;
 
 	if (*pos & 3 || size & 3)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index b5cd182b9edd..037539c0b63f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -42,8 +42,6 @@
 #define CRAT_OEMTABLEID_LENGTH	8
 #define CRAT_RESERVED_LENGTH	6
 
-#define CRAT_OEMID_64BIT_MASK ((1ULL << (CRAT_OEMID_LENGTH * 8)) - 1)
-
 /* Compute Unit flags */
 #define COMPUTE_UNIT_CPU	(1 << 0)  /* Create Virtual CRAT for CPU */
 #define COMPUTE_UNIT_GPU	(1 << 1)  /* Create Virtual CRAT for GPU */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 5cf499a07806..407201315292 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -863,8 +863,7 @@ static void kfd_update_system_properties(void)
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
index 7d9c3f948dff..e47c0267f206 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -164,7 +164,10 @@ struct kfd_topology_device {
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
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index 1de5173e53a2..bcc997d217c2 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -41,7 +41,7 @@ static inline void debug_fence_init(struct i915_sw_fence *fence)
 	debug_object_init(fence, &i915_sw_fence_debug_descr);
 }
 
-static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_init_onstack(struct i915_sw_fence *fence)
 {
 	debug_object_init_on_stack(fence, &i915_sw_fence_debug_descr);
 }
@@ -67,7 +67,7 @@ static inline void debug_fence_destroy(struct i915_sw_fence *fence)
 	debug_object_destroy(fence, &i915_sw_fence_debug_descr);
 }
 
-static inline void debug_fence_free(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_free(struct i915_sw_fence *fence)
 {
 	debug_object_free(fence, &i915_sw_fence_debug_descr);
 	smp_wmb(); /* flush the change in state before reallocation */
@@ -84,7 +84,7 @@ static inline void debug_fence_init(struct i915_sw_fence *fence)
 {
 }
 
-static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_init_onstack(struct i915_sw_fence *fence)
 {
 }
 
@@ -105,7 +105,7 @@ static inline void debug_fence_destroy(struct i915_sw_fence *fence)
 {
 }
 
-static inline void debug_fence_free(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_free(struct i915_sw_fence *fence)
 {
 }
 
diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index ad2e87de7dc5..d58a108a96c0 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -104,7 +104,7 @@ static void cougar_fix_g6_mapping(struct hid_device *hdev)
 static __u8 *cougar_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				 unsigned int *rsize)
 {
-	if (rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
+	if (*rsize >= 117 && rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
 	    (rdesc[115] | rdesc[116] << 8) >= HID_MAX_USAGES) {
 		hid_info(hdev,
 			"usage count exceeds max: fixing up report descriptor\n");
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a2a304e7d10c..3f4221a69b3d 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1973,6 +1973,7 @@ static int vmbus_acpi_add(struct acpi_device *device)
 		vmbus_acpi_remove(device);
 	return ret_val;
 }
+EXPORT_SYMBOL_GPL(vmbus_device_unregister);
 
 static const struct acpi_device_id vmbus_acpi_device_ids[] = {
 	{"VMBUS", 0},
diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index bd2ca315c9d8..5abb28cd81bf 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -184,7 +184,7 @@ static ssize_t adc128_set_in(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	/* 10 mV LSB on limit registers */
-	regval = clamp_val(DIV_ROUND_CLOSEST(val, 10), 0, 255);
+	regval = DIV_ROUND_CLOSEST(clamp_val(val, 0, 2550), 10);
 	data->in[index][nr] = regval << 4;
 	reg = index == 1 ? ADC128_REG_IN_MIN(nr) : ADC128_REG_IN_MAX(nr);
 	i2c_smbus_write_byte_data(data->client, reg, regval);
@@ -222,7 +222,7 @@ static ssize_t adc128_set_temp(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	regval = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+	regval = DIV_ROUND_CLOSEST(clamp_val(val, -128000, 127000), 1000);
 	data->temp[index] = regval << 1;
 	i2c_smbus_write_byte_data(data->client,
 				  index == 1 ? ADC128_REG_TEMP_MAX
diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
index c7fcc9e7f57a..13912ac7c69f 100644
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -310,7 +310,8 @@ static ssize_t set_tcrit2(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, index ? 255 : 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, (index ? 255 : 127) * 1000),
+				1000);
 
 	mutex_lock(&data->update_lock);
 	data->tcrit2[index] = val;
@@ -359,7 +360,7 @@ static ssize_t set_tcrit1(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 255000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->tcrit1[index] = val;
@@ -400,7 +401,7 @@ static ssize_t set_tcrit1_hyst(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	val = DIV_ROUND_CLOSEST(val, 1000);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -255000, 255000), 1000);
 	val = clamp_val((int)data->tcrit1[index] - val, 0, 31);
 
 	mutex_lock(&data->update_lock);
@@ -440,7 +441,7 @@ static ssize_t set_offset(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	/* Accuracy is 1/2 degrees C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 500), -128, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -64000, 63500), 500);
 
 	mutex_lock(&data->update_lock);
 	data->toffset[index] = val;
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 559101a1c136..23581dc62246 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -2264,7 +2264,7 @@ store_temp_offset(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -128000, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = val;
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index ad68b6d9ff17..8da5f77b8987 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1519,7 +1519,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -1545,7 +1545,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit the temp to 0C - 15C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 15);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 15000), 1000);
 
 	mutex_lock(&data->update_lock);
 	if (sio_data->kind == nct6775 || sio_data->kind == nct6776) {
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 2b5a320f42c5..be58e5ddbf02 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -159,7 +159,7 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	ret = dma_get_slave_caps(chan, &caps);
 	if (ret < 0)
-		goto err_free;
+		goto err_release;
 
 	/* Needs to be aligned to the maximum of the minimums */
 	if (caps.src_addr_widths)
@@ -184,6 +184,8 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	return &dmaengine_buffer->queue.buffer;
 
+err_release:
+	dma_release_channel(chan);
 err_free:
 	kfree(dmaengine_buffer);
 	return ERR_PTR(ret);
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 5108b0504616..af0393247738 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -640,17 +640,17 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000LL);
 		break;
 	case IIO_VAL_INT_PLUS_NANO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000000LL);
 		break;
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index e746920872a4..50839c902518 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -429,6 +429,20 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 		return -EINVAL;
 	}
 
+	/*
+	 * Limit number of contacts to a reasonable value (100). This
+	 * ensures that we need less than 2 pages for struct input_mt
+	 * (we are not using in-kernel slot assignment so not going to
+	 * allocate memory for the "red" table), and we should have no
+	 * trouble getting this much memory.
+	 */
+	if (code == ABS_MT_SLOT && max > 99) {
+		printk(KERN_DEBUG
+		       "%s: unreasonably large number of slots requested: %d\n",
+		       UINPUT_NAME, max);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 3ea851583724..865847546f8e 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1292,7 +1292,7 @@ int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
 	 */
 	writel(qi->free_head << DMAR_IQ_SHIFT, iommu->reg + DMAR_IQT_REG);
 
-	while (qi->desc_status[wait_index] != QI_DONE) {
+	while (READ_ONCE(qi->desc_status[wait_index]) != QI_DONE) {
 		/*
 		 * We will leave the interrupts disabled, to prevent interrupt
 		 * context to queue another cmd while a cmd is already submitted
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 0fd428db3aa4..73c386aba368 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -346,6 +346,10 @@ static struct irq_chip armada_370_xp_irq_chip = {
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
+	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
+	if (hw <= 1)
+		return -EINVAL;
+
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	if (!is_percpu_irq(hw))
 		writel(hw, per_cpu_int_base +
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 669615fff6a0..0fc7951640e2 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -431,8 +431,11 @@ static int camss_of_parse_endpoint_node(struct device *dev,
 	struct v4l2_fwnode_bus_mipi_csi2 *mipi_csi2;
 	struct v4l2_fwnode_endpoint vep = { { 0 } };
 	unsigned int i;
+	int ret;
 
-	v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+	if (ret)
+		return ret;
 
 	csd->interface.csiphy_id = vep.base.port;
 
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 775d67720648..6367ee9c0066 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -860,16 +860,26 @@ static int uvc_parse_streaming(struct uvc_device *dev,
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
 	streaming->nformats = nformats;
diff --git a/drivers/misc/vmw_vmci/vmci_resource.c b/drivers/misc/vmw_vmci/vmci_resource.c
index da1ee2e1ba99..2779704e128a 100644
--- a/drivers/misc/vmw_vmci/vmci_resource.c
+++ b/drivers/misc/vmw_vmci/vmci_resource.c
@@ -152,7 +152,8 @@ void vmci_resource_remove(struct vmci_resource *resource)
 	spin_lock(&vmci_resource_table.lock);
 
 	hlist_for_each_entry(r, &vmci_resource_table.entries[idx], node) {
-		if (vmci_handle_is_equal(r->handle, resource->handle)) {
+		if (vmci_handle_is_equal(r->handle, resource->handle) &&
+		    resource->type == r->type) {
 			hlist_del_init_rcu(&r->node);
 			break;
 		}
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 75355abe03c9..a35526ae7a25 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2857,8 +2857,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	if (host->use_dma == TRANS_MODE_IDMAC) {
 		mmc->max_segs = host->ring_size;
 		mmc->max_blk_size = 65535;
-		mmc->max_seg_size = 0x1000;
-		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
+		mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
+		mmc->max_seg_size = mmc->max_req_size;
 		mmc->max_blk_count = mmc->max_req_size / 512;
 	} else if (host->use_dma == TRANS_MODE_EDMAC) {
 		mmc->max_segs = 64;
diff --git a/drivers/net/dsa/vitesse-vsc73xx.c b/drivers/net/dsa/vitesse-vsc73xx.c
index eaafb1c30c91..c91f989165ad 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.c
+++ b/drivers/net/dsa/vitesse-vsc73xx.c
@@ -38,7 +38,7 @@
 #define VSC73XX_BLOCK_ANALYZER	0x2 /* Only subblock 0 */
 #define VSC73XX_BLOCK_MII	0x3 /* Subblocks 0 and 1 */
 #define VSC73XX_BLOCK_MEMINIT	0x3 /* Only subblock 2 */
-#define VSC73XX_BLOCK_CAPTURE	0x4 /* Only subblock 2 */
+#define VSC73XX_BLOCK_CAPTURE	0x4 /* Subblocks 0-4, 6, 7 */
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
@@ -385,13 +385,19 @@ static int vsc73xx_is_addr_valid(u8 block, u8 subblock)
 		break;
 
 	case VSC73XX_BLOCK_MII:
-	case VSC73XX_BLOCK_CAPTURE:
 	case VSC73XX_BLOCK_ARBITER:
 		switch (subblock) {
 		case 0 ... 1:
 			return 1;
 		}
 		break;
+	case VSC73XX_BLOCK_CAPTURE:
+		switch (subblock) {
+		case 0 ... 4:
+		case 6 ... 7:
+			return 1;
+		}
+		break;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5d8d5915bc27..01138fc93ea1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6554,10 +6554,20 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
+	const u32 mask = (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
+			  TSINTR_TT0 | TSINTR_TT1 |
+			  TSINTR_AUTT0 | TSINTR_AUTT1);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
 
+	if (hw->mac.type == e1000_82580) {
+		/* 82580 has a hardware bug that requires an explicit
+		 * write to clear the TimeSync interrupt cause.
+		 */
+		wr32(E1000_TSICR, tsicr & mask);
+	}
+
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 8d556eb37b7a..c0c73b76f6c7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2072,12 +2072,13 @@ void mlxsw_sp_port_bridge_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 static void
 mlxsw_sp_fdb_call_notifiers(enum switchdev_notifier_type type,
 			    const char *mac, u16 vid,
-			    struct net_device *dev)
+			    struct net_device *dev, bool offloaded)
 {
 	struct switchdev_notifier_fdb_info info;
 
 	info.addr = mac;
 	info.vid = vid;
+	info.offloaded = offloaded;
 	call_switchdev_notifiers(type, dev, &info.info);
 }
 
@@ -2129,7 +2130,7 @@ static void mlxsw_sp_fdb_notify_mac_process(struct mlxsw_sp *mlxsw_sp,
 	if (!do_notification)
 		return;
 	type = adding ? SWITCHDEV_FDB_ADD_TO_BRIDGE : SWITCHDEV_FDB_DEL_TO_BRIDGE;
-	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev);
+	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev, adding);
 
 	return;
 
@@ -2189,7 +2190,7 @@ static void mlxsw_sp_fdb_notify_mac_lag_process(struct mlxsw_sp *mlxsw_sp,
 	if (!do_notification)
 		return;
 	type = adding ? SWITCHDEV_FDB_ADD_TO_BRIDGE : SWITCHDEV_FDB_DEL_TO_BRIDGE;
-	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev);
+	mlxsw_sp_fdb_call_notifiers(type, mac, vid, bridge_port->dev, adding);
 
 	return;
 
@@ -2294,7 +2295,7 @@ static void mlxsw_sp_switchdev_event_work(struct work_struct *work)
 			break;
 		mlxsw_sp_fdb_call_notifiers(SWITCHDEV_FDB_OFFLOADED,
 					    fdb_info->addr,
-					    fdb_info->vid, dev);
+					    fdb_info->vid, dev, true);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		fdb_info = &switchdev_work->fdb_info;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index b13ab4eee4c7..7d81de57b6f4 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2728,6 +2728,7 @@ rocker_fdb_offload_notify(struct rocker_port *rocker_port,
 
 	info.addr = recv_info->addr;
 	info.vid = recv_info->vid;
+	info.offloaded = true;
 	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
 				 rocker_port->dev, &info.info);
 }
diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index 9df3c1ffff35..6ed8da85b081 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -338,6 +338,7 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int retval = 0;
 	unsigned char data[2];
+	u8 addr[ETH_ALEN];
 
 	retval = usbnet_get_endpoints(dev, intf);
 	if (retval)
@@ -385,7 +386,8 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_CTRL, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
 
-	retval = get_mac_address(dev, dev->net->dev_addr);
+	retval = get_mac_address(dev, addr);
+	eth_hw_addr_set(dev->net, addr);
 
 	return retval;
 }
diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
index dfbdea22fbad..569d52b63f64 100644
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -52,6 +52,11 @@ enum cx82310_status {
 #define CX82310_MTU	1514
 #define CMD_EP		0x01
 
+struct cx82310_priv {
+	struct work_struct reenable_work;
+	struct usbnet *dev;
+};
+
 /*
  * execute control command
  *  - optionally send some data (command parameters)
@@ -127,6 +132,23 @@ static int cx82310_cmd(struct usbnet *dev, enum cx82310_cmd cmd, bool reply,
 	return ret;
 }
 
+static int cx82310_enable_ethernet(struct usbnet *dev)
+{
+	int ret = cx82310_cmd(dev, CMD_ETHERNET_MODE, true, "\x01", 1, NULL, 0);
+
+	if (ret)
+		netdev_err(dev->net, "unable to enable ethernet mode: %d\n",
+			   ret);
+	return ret;
+}
+
+static void cx82310_reenable_work(struct work_struct *work)
+{
+	struct cx82310_priv *priv = container_of(work, struct cx82310_priv,
+						 reenable_work);
+	cx82310_enable_ethernet(priv->dev);
+}
+
 #define partial_len	data[0]		/* length of partial packet data */
 #define partial_rem	data[1]		/* remaining (missing) data length */
 #define partial_data	data[2]		/* partial packet data */
@@ -138,6 +160,8 @@ static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct usb_device *udev = dev->udev;
 	u8 link[3];
 	int timeout = 50;
+	struct cx82310_priv *priv;
+	u8 addr[ETH_ALEN];
 
 	/* avoid ADSL modems - continue only if iProduct is "USB NET CARD" */
 	if (usb_string(udev, udev->descriptor.iProduct, buf, sizeof(buf)) > 0
@@ -164,6 +188,15 @@ static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 	if (!dev->partial_data)
 		return -ENOMEM;
 
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_partial;
+	}
+	dev->driver_priv = priv;
+	INIT_WORK(&priv->reenable_work, cx82310_reenable_work);
+	priv->dev = dev;
+
 	/* wait for firmware to become ready (indicated by the link being up) */
 	while (--timeout) {
 		ret = cx82310_cmd(dev, CMD_GET_LINK_STATUS, true, NULL, 0,
@@ -180,20 +213,17 @@ static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 	}
 
 	/* enable ethernet mode (?) */
-	ret = cx82310_cmd(dev, CMD_ETHERNET_MODE, true, "\x01", 1, NULL, 0);
-	if (ret) {
-		dev_err(&udev->dev, "unable to enable ethernet mode: %d\n",
-			ret);
+	ret = cx82310_enable_ethernet(dev);
+	if (ret)
 		goto err;
-	}
 
 	/* get the MAC address */
-	ret = cx82310_cmd(dev, CMD_GET_MAC_ADDR, true, NULL, 0,
-			  dev->net->dev_addr, ETH_ALEN);
+	ret = cx82310_cmd(dev, CMD_GET_MAC_ADDR, true, NULL, 0, addr, ETH_ALEN);
 	if (ret) {
 		dev_err(&udev->dev, "unable to read MAC address: %d\n", ret);
 		goto err;
 	}
+	eth_hw_addr_set(dev->net, addr);
 
 	/* start (does not seem to have any effect?) */
 	ret = cx82310_cmd(dev, CMD_START, false, NULL, 0, NULL, 0);
@@ -202,13 +232,19 @@ static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	return 0;
 err:
+	kfree(dev->driver_priv);
+err_partial:
 	kfree((void *)dev->partial_data);
 	return ret;
 }
 
 static void cx82310_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
+	struct cx82310_priv *priv = dev->driver_priv;
+
 	kfree((void *)dev->partial_data);
+	cancel_work_sync(&priv->reenable_work);
+	kfree(dev->driver_priv);
 }
 
 /*
@@ -223,6 +259,7 @@ static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
 	int len;
 	struct sk_buff *skb2;
+	struct cx82310_priv *priv = dev->driver_priv;
 
 	/*
 	 * If the last skb ended with an incomplete packet, this skb contains
@@ -257,7 +294,10 @@ static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			break;
 		}
 
-		if (len > CX82310_MTU) {
+		if (len == 0xffff) {
+			netdev_info(dev->net, "router was rebooted, re-enabling ethernet mode");
+			schedule_work(&priv->reenable_work);
+		} else if (len > CX82310_MTU) {
 			dev_err(&dev->udev->dev, "RX packet too long: %d B\n",
 				len);
 			return 0;
diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index cea005cc7b2a..0a86ba028c4d 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -407,8 +407,8 @@ static int ipheth_close(struct net_device *net)
 {
 	struct ipheth_device *dev = netdev_priv(net);
 
-	cancel_delayed_work_sync(&dev->carrier_work);
 	netif_stop_queue(net);
+	cancel_delayed_work_sync(&dev->carrier_work);
 	return 0;
 }
 
@@ -497,7 +497,7 @@ static int ipheth_probe(struct usb_interface *intf,
 
 	netdev->netdev_ops = &ipheth_netdev_ops;
 	netdev->watchdog_timeo = IPHETH_TX_TIMEOUT;
-	strcpy(netdev->name, "eth%d");
+	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
 
 	dev = netdev_priv(netdev);
 	dev->udev = udev;
diff --git a/drivers/net/usb/kaweth.c b/drivers/net/usb/kaweth.c
index 913e50bab0a2..b05154fad3ce 100644
--- a/drivers/net/usb/kaweth.c
+++ b/drivers/net/usb/kaweth.c
@@ -1139,8 +1139,7 @@ static int kaweth_probe(
 		goto err_all_but_rxbuf;
 
 	memcpy(netdev->broadcast, &bcast_addr, sizeof(bcast_addr));
-	memcpy(netdev->dev_addr, &kaweth->configuration.hw_addr,
-               sizeof(kaweth->configuration.hw_addr));
+	eth_hw_addr_set(netdev, (u8 *)&kaweth->configuration.hw_addr);
 
 	netdev->netdev_ops = &kaweth_netdev_ops;
 	netdev->watchdog_timeo = KAWETH_TX_TIMEOUT;
diff --git a/drivers/net/usb/mcs7830.c b/drivers/net/usb/mcs7830.c
index c0f52a622964..c304ce4abaa4 100644
--- a/drivers/net/usb/mcs7830.c
+++ b/drivers/net/usb/mcs7830.c
@@ -493,17 +493,19 @@ static const struct net_device_ops mcs7830_netdev_ops = {
 static int mcs7830_bind(struct usbnet *dev, struct usb_interface *udev)
 {
 	struct net_device *net = dev->net;
+	u8 addr[ETH_ALEN];
 	int ret;
 	int retry;
 
 	/* Initial startup: Gather MAC address setting from EEPROM */
 	ret = -EINVAL;
 	for (retry = 0; retry < 5 && ret; retry++)
-		ret = mcs7830_hif_get_mac_address(dev, net->dev_addr);
+		ret = mcs7830_hif_get_mac_address(dev, addr);
 	if (ret) {
 		dev_warn(&dev->udev->dev, "Cannot read MAC address\n");
 		goto out;
 	}
+	eth_hw_addr_set(net, addr);
 
 	mcs7830_data_set_multicast(net);
 
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 881240d93956..bbd5183e5e63 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1390,6 +1390,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
 	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
+	{QMI_FIXED_INTF(0x2dee, 0x4d22, 5)},    /* MeiG Smart SRM825L */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index c43087e06696..4226ad0f11f3 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -686,6 +686,7 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 		0x00, 0x00, SIERRA_NET_HIP_MSYNC_ID, 0x00};
 	static const u8 shdwn_tmplate[sizeof(priv->shdwn_msg)] = {
 		0x00, 0x00, SIERRA_NET_HIP_SHUTD_ID, 0x00};
+	u8 mod[2];
 
 	dev_dbg(&dev->udev->dev, "%s", __func__);
 
@@ -715,8 +716,9 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 	dev->net->netdev_ops = &sierra_net_device_ops;
 
 	/* change MAC addr to include, ifacenum, and to be unique */
-	dev->net->dev_addr[ETH_ALEN-2] = atomic_inc_return(&iface_counter);
-	dev->net->dev_addr[ETH_ALEN-1] = ifacenum;
+	mod[0] = atomic_inc_return(&iface_counter);
+	mod[1] = ifacenum;
+	dev_addr_mod(dev->net, ETH_ALEN - 2, mod, 2);
 
 	/* prepare shutdown message template */
 	memcpy(priv->shdwn_msg, shdwn_tmplate, sizeof(priv->shdwn_msg));
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 1f11c56ccd5c..1f4b2fabb5e6 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -326,6 +326,7 @@ static int sr9700_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct net_device *netdev;
 	struct mii_if_info *mii;
+	u8 addr[ETH_ALEN];
 	int ret;
 
 	ret = usbnet_get_endpoints(dev, intf);
@@ -356,11 +357,12 @@ static int sr9700_bind(struct usbnet *dev, struct usb_interface *intf)
 	 * EEPROM automatically to PAR. In case there is no EEPROM externally,
 	 * a default MAC address is stored in PAR for making chip work properly.
 	 */
-	if (sr_read(dev, SR_PAR, ETH_ALEN, netdev->dev_addr) < 0) {
+	if (sr_read(dev, SR_PAR, ETH_ALEN, addr) < 0) {
 		netdev_err(netdev, "Error reading MAC address\n");
 		ret = -ENODEV;
 		goto out;
 	}
+	eth_hw_addr_set(netdev, addr);
 
 	/* power up and reset phy */
 	sr_write_reg(dev, SR_PRR, PRR_PHY_RST);
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index a5ff7df10505..485a50d9f281 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -732,6 +732,7 @@ static int sr9800_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct sr_data *data = (struct sr_data *)&dev->data;
 	u16 led01_mux, led23_mux;
 	int ret, embd_phy;
+	u8 addr[ETH_ALEN];
 	u32 phyid;
 	u16 rx_ctl;
 
@@ -757,12 +758,12 @@ static int sr9800_bind(struct usbnet *dev, struct usb_interface *intf)
 	}
 
 	/* Get the MAC address */
-	ret = sr_read_cmd(dev, SR_CMD_READ_NODE_ID, 0, 0, ETH_ALEN,
-			  dev->net->dev_addr);
+	ret = sr_read_cmd(dev, SR_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, addr);
 	if (ret < 0) {
 		netdev_dbg(dev->net, "Failed to read MAC address: %d\n", ret);
 		return ret;
 	}
+	eth_hw_addr_set(dev->net, addr);
 	netdev_dbg(dev->net, "mac addr : %pM\n", dev->net->dev_addr);
 
 	/* Initialize MII structure */
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index f7f037b399a7..938335f4738d 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -79,9 +79,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-// randomly generated ethernet address
-static u8	node_id [ETH_ALEN];
-
 /* use ethtool to change the level for any given device */
 static int msg_level = -1;
 module_param (msg_level, int, 0);
@@ -163,12 +160,13 @@ EXPORT_SYMBOL_GPL(usbnet_get_endpoints);
 
 int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 {
+	u8		addr[ETH_ALEN];
 	int 		tmp = -1, ret;
 	unsigned char	buf [13];
 
 	ret = usb_string(dev->udev, iMACAddress, buf, sizeof buf);
 	if (ret == 12)
-		tmp = hex2bin(dev->net->dev_addr, buf, 6);
+		tmp = hex2bin(addr, buf, 6);
 	if (tmp < 0) {
 		dev_dbg(&dev->udev->dev,
 			"bad MAC string %d fetch, %d\n", iMACAddress, tmp);
@@ -176,6 +174,7 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 			ret = -EINVAL;
 		return ret;
 	}
+	eth_hw_addr_set(dev->net, addr);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
@@ -1722,8 +1721,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	dev->interrupt_count = 0;
 
 	dev->net = net;
-	strcpy (net->name, "usb%d");
-	memcpy (net->dev_addr, node_id, sizeof node_id);
+	strscpy(net->name, "usb%d", sizeof(net->name));
 
 	/* rx and tx sides can use different message sizes;
 	 * bind() should set rx_urb_size in that case.
@@ -1749,13 +1747,13 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
 		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
 		     (net->dev_addr [0] & 0x02) == 0))
-			strcpy (net->name, "eth%d");
+			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
-			strcpy(net->name, "wlan%d");
+			strscpy(net->name, "wlan%d", sizeof(net->name));
 		/* WWAN devices should always be named "wwan%d" */
 		if ((dev->driver_info->flags & FLAG_WWAN) != 0)
-			strcpy(net->name, "wwan%d");
+			strscpy(net->name, "wwan%d", sizeof(net->name));
 
 		/* devices that cannot do ARP */
 		if ((dev->driver_info->flags & FLAG_NOARP) != 0)
@@ -1797,9 +1795,9 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		goto out4;
 	}
 
-	/* let userspace know we have a random address */
-	if (ether_addr_equal(net->dev_addr, node_id))
-		net->addr_assign_type = NET_ADDR_RANDOM;
+	/* this flags the device for user space */
+	if (!is_valid_ether_addr(net->dev_addr))
+		eth_hw_addr_random(net);
 
 	if ((dev->driver_info->flags & FLAG_WLAN) != 0)
 		SET_NETDEV_DEVTYPE(net, &wlan_type);
@@ -2209,7 +2207,6 @@ static int __init usbnet_init(void)
 	BUILD_BUG_ON(
 		FIELD_SIZEOF(struct sk_buff, cb) < sizeof(struct skb_data));
 
-	eth_random_addr(node_id);
 	return 0;
 }
 module_init(usbnet_init);
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8d4fa3eef28d..4d576ad5a008 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1428,7 +1428,7 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 		return false;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -1439,7 +1439,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
-		free_old_xmit_skbs(sq, true);
+		free_old_xmit_skbs(sq, !!budget);
 		__netif_tx_unlock(txq);
 	}
 
@@ -1456,7 +1456,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -1526,7 +1526,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 288d4d4d4454..eb735b054790 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -1091,6 +1091,7 @@ static int ieee_hw_init(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 	ieee80211_hw_set(hw, SIGNAL_DBM);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
 
 	hw->extra_tx_headroom = brcms_c_get_header_len();
 	hw->queues = N_TX_QUEUES;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 7e526014b638..89774e0316bd 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1306,6 +1306,9 @@ mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		if (adapter->priv[i]) {
+			if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
+				continue;
+
 			if ((adapter->priv[i]->bss_num == bss_num) &&
 			    (adapter->priv[i]->bss_type == bss_type))
 				break;
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2e77d49c2657..07f49c93e9b8 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -794,13 +794,13 @@ void nvmem_device_put(struct nvmem_device *nvmem)
 EXPORT_SYMBOL_GPL(nvmem_device_put);
 
 /**
- * devm_nvmem_device_get() - Get nvmem cell of device form a given id
+ * devm_nvmem_device_get() - Get nvmem device of device form a given id
  *
  * @dev: Device that requests the nvmem device.
  * @id: name id for the requested nvmem device.
  *
- * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_cell
- * on success.  The nvmem_cell will be freed by the automatically once the
+ * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_device
+ * on success.  The nvmem_device will be freed by the automatically once the
  * device is freed.
  */
 struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 02ad93a304a4..f06c9df60e34 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -289,7 +289,8 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	struct device_node *p;
 	const __be32 *addr;
 	u32 intsize;
-	int i, res;
+	int i, res, addr_len;
+	__be32 addr_buf[3] = { 0 };
 
 	pr_debug("of_irq_parse_one: dev=%pOF, index=%d\n", device, index);
 
@@ -298,13 +299,19 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 		return of_irq_parse_oldworld(device, index, out_irq);
 
 	/* Get the reg property (if any) */
-	addr = of_get_property(device, "reg", NULL);
+	addr = of_get_property(device, "reg", &addr_len);
+
+	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
+	if (addr_len > (3 * sizeof(__be32)))
+		addr_len = 3 * sizeof(__be32);
+	if (addr)
+		memcpy(addr_buf, addr, addr_len);
 
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
 	if (!res)
-		return of_irq_parse_raw(addr, out_irq);
+		return of_irq_parse_raw(addr_buf, out_irq);
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);
@@ -334,7 +341,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr, out_irq);
+	res = of_irq_parse_raw(addr_buf, out_irq);
  out:
 	of_node_put(p);
 	return res;
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 3276a5e4c430..486fad430958 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -35,7 +35,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 				bool disable_device)
 {
 	struct pci_dev *pdev = php_slot->pdev;
-	int irq = php_slot->irq;
 	u16 ctrl;
 
 	if (php_slot->irq > 0) {
@@ -54,7 +53,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 		php_slot->wq = NULL;
 	}
 
-	if (disable_device || irq > 0) {
+	if (disable_device) {
 		if (pdev->msix_enabled)
 			pci_disable_msix(pdev);
 		else if (pdev->msi_enabled)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4f229cb5d2a9..aa2be8d81504 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4957,10 +4957,12 @@ static void pci_bus_lock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
 
@@ -4972,8 +4974,10 @@ static void pci_bus_unlock(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 }
 
 /* Return 1 on successful lock, 0 on contention */
@@ -4981,15 +4985,15 @@ static int pci_bus_trylock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	if (!pci_dev_trylock(bus->self))
+		return 0;
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!pci_dev_trylock(dev))
-			goto unlock;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
-		}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
 	}
 	return 1;
 
@@ -4997,8 +5001,10 @@ static int pci_bus_trylock(struct pci_bus *bus)
 	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 	return 0;
 }
 
@@ -5030,9 +5036,10 @@ static void pci_slot_lock(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
 
@@ -5058,14 +5065,13 @@ static int pci_slot_trylock(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		if (!pci_dev_trylock(dev))
-			goto unlock;
 		if (dev->subordinate) {
 			if (!pci_bus_trylock(dev->subordinate)) {
 				pci_dev_unlock(dev);
 				goto unlock;
 			}
-		}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
 	}
 	return 1;
 
@@ -5076,7 +5082,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 	return 0;
 }
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index ac6a3f46b1e6..738660002ef3 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -636,11 +636,11 @@ static int yenta_search_one_res(struct resource *root, struct resource *res,
 		start = PCIBIOS_MIN_CARDBUS_IO;
 		end = ~0U;
 	} else {
-		unsigned long avail = root->end - root->start;
+		unsigned long avail = resource_size(root);
 		int i;
 		size = BRIDGE_MEM_MAX;
-		if (size > avail/8) {
-			size = (avail+1)/8;
+		if (size > (avail - 1) / 8) {
+			size = avail / 8;
 			/* round size down to next power of 2 */
 			i = 0;
 			while ((size /= 2) != 0)
diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index 9e9fc5155789..f5299edb83f5 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -613,7 +613,10 @@ static int __init dell_smbios_init(void)
 	return 0;
 
 fail_sysfs:
-	free_group(platform_device);
+	if (!wmi)
+		exit_dell_smbios_wmi();
+	if (!smm)
+		exit_dell_smbios_smm();
 
 fail_create_group:
 	platform_device_del(platform_device);
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 170fa1f8f00e..d2e81d0ce9a4 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -104,10 +104,11 @@ static void hv_uio_channel_cb(void *context)
 
 /*
  * Callback from vmbus_event when channel is rescinded.
+ * It is meant for rescind of primary channels only.
  */
 static void hv_uio_rescind(struct vmbus_channel *channel)
 {
-	struct hv_device *hv_dev = channel->primary_channel->device_obj;
+	struct hv_device *hv_dev = channel->device_obj;
 	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
 
 	/*
@@ -118,6 +119,14 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
 
 	/* Wake up reader */
 	uio_event_notify(&pdata->info);
+
+	/*
+	 * With rescind callback registered, rescind path will not unregister the device
+	 * from vmbus when the primary channel is rescinded.
+	 * Without it, rescind handling is incomplete and next onoffer msg does not come.
+	 * Unregister the device from vmbus here.
+	 */
+	vmbus_device_unregister(channel->device_obj);
 }
 
 /* Sysfs API to allow mmap of the ring buffers
diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 6127505770ce..d355c784f1f1 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -252,24 +252,25 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	if (!child) {
 		dev_err(&pdev->dev, "failed to find dwc3 core node\n");
 		ret = -ENODEV;
-		goto undo_softreset;
+		goto err_node_put;
 	}
 
 	/* Allocate and initialize the core */
 	ret = of_platform_populate(node, NULL, NULL, dev);
 	if (ret) {
 		dev_err(dev, "failed to add dwc3 core\n");
-		goto undo_softreset;
+		goto err_node_put;
 	}
 
 	child_pdev = of_find_device_by_node(child);
 	if (!child_pdev) {
 		dev_err(dev, "failed to find dwc3 core device\n");
 		ret = -ENODEV;
-		goto undo_softreset;
+		goto depopulate;
 	}
 
 	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
+	of_node_put(child);
 
 	/*
 	 * Configure the USB port as device or host according to the static
@@ -280,6 +281,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	ret = st_dwc3_drd_init(dwc3_data);
 	if (ret) {
 		dev_err(dev, "drd initialisation failed\n");
+		of_platform_depopulate(dev);
 		goto undo_softreset;
 	}
 
@@ -289,6 +291,10 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dwc3_data);
 	return 0;
 
+depopulate:
+	of_platform_depopulate(dev);
+err_node_put:
+	of_node_put(child);
 undo_softreset:
 	reset_control_assert(dwc3_data->rstc_rst);
 undo_powerdown:
diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index b88eeaee637a..72501198be45 100644
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
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 51f21cd61422..6b8ece5175ef 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8409,7 +8409,15 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 		/* We don't care about errors in readahead. */
 		if (ret < 0)
 			continue;
-		BUG_ON(refs == 0);
+
+		/*
+		 * This could be racey, it's conceivable that we raced and end
+		 * up with a bogus refs count, if that's the case just skip, if
+		 * we are actually corrupt we will notice when we look up
+		 * everything again with our locks.
+		 */
+		if (refs == 0)
+			continue;
 
 		if (wc->stage == DROP_REFERENCE) {
 			if (refs == 1)
@@ -8468,7 +8476,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (lookup_info &&
 	    ((wc->stage == DROP_REFERENCE && wc->refs[level] != 1) ||
 	     (wc->stage == UPDATE_BACKREF && !(wc->flags[level] & flag)))) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_lookup_extent_info(trans, fs_info,
 					       eb->start, level, 1,
 					       &wc->refs[level],
@@ -8476,7 +8484,11 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 		BUG_ON(ret == -ENOMEM);
 		if (ret)
 			return ret;
-		BUG_ON(wc->refs[level] == 0);
+		if (unlikely(wc->refs[level] == 0)) {
+			btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+				  eb->start);
+			return -EUCLEAN;
+		}
 	}
 
 	if (wc->stage == DROP_REFERENCE) {
@@ -8492,7 +8504,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 
 	/* wc->stage == UPDATE_BACKREF */
 	if (!(wc->flags[level] & flag)) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
 		BUG_ON(ret); /* -ENOMEM */
 		ret = btrfs_dec_ref(trans, root, eb, 0);
@@ -8584,8 +8596,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		goto out_unlock;
 
 	if (unlikely(wc->refs[level - 1] == 0)) {
-		btrfs_err(fs_info, "Missing references.");
-		ret = -EIO;
+		btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+			  bytenr);
+		ret = -EUCLEAN;
 		goto out_unlock;
 	}
 	*lookup_info = 0;
@@ -8753,7 +8766,12 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				path->locks[level] = 0;
 				return ret;
 			}
-			BUG_ON(wc->refs[level] == 0);
+			if (unlikely(wc->refs[level] == 0)) {
+				btrfs_tree_unlock_rw(eb, path->locks[level]);
+				btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+					  eb->start);
+				return -EUCLEAN;
+			}
 			if (wc->refs[level] == 1) {
 				btrfs_tree_unlock_rw(eb, path->locks[level]);
 				path->locks[level] = 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 15ebebed4005..22059aa5eb26 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5869,7 +5869,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	struct inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *sub_root = root;
-	struct btrfs_key location;
+	struct btrfs_key location = { 0 };
 	u8 di_type = 0;
 	int index;
 	int ret = 0;
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index a4b65374bced..b2c567adcf66 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -79,7 +79,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 	}
 	ret = fuse_simple_request(fc, &args);
 	if (!ret && !size)
-		ret = min_t(ssize_t, outarg.size, XATTR_SIZE_MAX);
+		ret = min_t(size_t, outarg.size, XATTR_SIZE_MAX);
 	if (ret == -ENOSYS) {
 		fc->no_getxattr = 1;
 		ret = -EOPNOTSUPP;
@@ -141,7 +141,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	}
 	ret = fuse_simple_request(fc, &args);
 	if (!ret && !size)
-		ret = min_t(ssize_t, outarg.size, XATTR_LIST_MAX);
+		ret = min_t(size_t, outarg.size, XATTR_LIST_MAX);
 	if (ret > 0 && size)
 		ret = fuse_verify_xattr_list(list, ret);
 	if (ret == -ENOSYS) {
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 0923231e9e60..f9390e5a7fce 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -708,6 +708,33 @@ static void nilfs_finish_roll_forward(struct the_nilfs *nilfs,
 	brelse(bh);
 }
 
+/**
+ * nilfs_abort_roll_forward - cleaning up after a failed rollforward recovery
+ * @nilfs: nilfs object
+ */
+static void nilfs_abort_roll_forward(struct the_nilfs *nilfs)
+{
+	struct nilfs_inode_info *ii, *n;
+	LIST_HEAD(head);
+
+	/* Abandon inodes that have read recovery data */
+	spin_lock(&nilfs->ns_inode_lock);
+	list_splice_init(&nilfs->ns_dirty_files, &head);
+	spin_unlock(&nilfs->ns_inode_lock);
+	if (list_empty(&head))
+		return;
+
+	set_nilfs_purging(nilfs);
+	list_for_each_entry_safe(ii, n, &head, i_dirty) {
+		spin_lock(&nilfs->ns_inode_lock);
+		list_del_init(&ii->i_dirty);
+		spin_unlock(&nilfs->ns_inode_lock);
+
+		iput(&ii->vfs_inode);
+	}
+	clear_nilfs_purging(nilfs);
+}
+
 /**
  * nilfs_salvage_orphan_logs - salvage logs written after the latest checkpoint
  * @nilfs: nilfs object
@@ -766,15 +793,19 @@ int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
 		if (unlikely(err)) {
 			nilfs_err(sb, "error %d writing segment for recovery",
 				  err);
-			goto failed;
+			goto put_root;
 		}
 
 		nilfs_finish_roll_forward(nilfs, ri);
 	}
 
- failed:
+put_root:
 	nilfs_put_root(root);
 	return err;
+
+failed:
+	nilfs_abort_roll_forward(nilfs);
+	goto put_root;
 }
 
 /**
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 3c4272762779..9a5dd4106c3d 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1828,6 +1828,9 @@ static void nilfs_segctor_abort_construction(struct nilfs_sc_info *sci,
 	nilfs_abort_logs(&logs, ret ? : err);
 
 	list_splice_tail_init(&sci->sc_segbufs, &logs);
+	if (list_empty(&logs))
+		return; /* if the first segment buffer preparation failed */
+
 	nilfs_cancel_segusage(&logs, nilfs->ns_sufile);
 	nilfs_free_incomplete_logs(&logs, nilfs);
 
@@ -2072,7 +2075,7 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 
 		err = nilfs_segctor_begin_construction(sci, nilfs);
 		if (unlikely(err))
-			goto out;
+			goto failed;
 
 		/* Update time stamp */
 		sci->sc_seg_ctime = ktime_get_real_seconds();
@@ -2135,10 +2138,9 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 	return err;
 
  failed_to_write:
-	if (sci->sc_stage.flags & NILFS_CF_IFILE_STARTED)
-		nilfs_redirty_inodes(&sci->sc_dirty_files);
-
  failed:
+	if (mode == SC_LSEG_SR && nilfs_sc_cstage_get(sci) >= NILFS_ST_IFILE)
+		nilfs_redirty_inodes(&sci->sc_dirty_files);
 	if (nilfs_doing_gc())
 		nilfs_redirty_inodes(&sci->sc_gc_inodes);
 	nilfs_segctor_abort_construction(sci, nilfs, err);
diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 57afd06db62d..64ea44be0a64 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -108,7 +108,7 @@ static ssize_t
 nilfs_snapshot_inodes_count_show(struct nilfs_snapshot_attr *attr,
 				 struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)atomic64_read(&root->inodes_count));
 }
 
@@ -116,7 +116,7 @@ static ssize_t
 nilfs_snapshot_blocks_count_show(struct nilfs_snapshot_attr *attr,
 				 struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)atomic64_read(&root->blocks_count));
 }
 
@@ -129,7 +129,7 @@ static ssize_t
 nilfs_snapshot_README_show(struct nilfs_snapshot_attr *attr,
 			    struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, snapshot_readme_str);
+	return sysfs_emit(buf, snapshot_readme_str);
 }
 
 NILFS_SNAPSHOT_RO_ATTR(inodes_count);
@@ -230,7 +230,7 @@ static ssize_t
 nilfs_mounted_snapshots_README_show(struct nilfs_mounted_snapshots_attr *attr,
 				    struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, mounted_snapshots_readme_str);
+	return sysfs_emit(buf, mounted_snapshots_readme_str);
 }
 
 NILFS_MOUNTED_SNAPSHOTS_RO_ATTR(README);
@@ -268,7 +268,7 @@ nilfs_checkpoints_checkpoints_number_show(struct nilfs_checkpoints_attr *attr,
 
 	ncheckpoints = cpstat.cs_ncps;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", ncheckpoints);
+	return sysfs_emit(buf, "%llu\n", ncheckpoints);
 }
 
 static ssize_t
@@ -291,7 +291,7 @@ nilfs_checkpoints_snapshots_number_show(struct nilfs_checkpoints_attr *attr,
 
 	nsnapshots = cpstat.cs_nsss;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nsnapshots);
+	return sysfs_emit(buf, "%llu\n", nsnapshots);
 }
 
 static ssize_t
@@ -305,7 +305,7 @@ nilfs_checkpoints_last_seg_checkpoint_show(struct nilfs_checkpoints_attr *attr,
 	last_cno = nilfs->ns_last_cno;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
+	return sysfs_emit(buf, "%llu\n", last_cno);
 }
 
 static ssize_t
@@ -319,7 +319,7 @@ nilfs_checkpoints_next_checkpoint_show(struct nilfs_checkpoints_attr *attr,
 	cno = nilfs->ns_cno;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
+	return sysfs_emit(buf, "%llu\n", cno);
 }
 
 static const char checkpoints_readme_str[] =
@@ -335,7 +335,7 @@ static ssize_t
 nilfs_checkpoints_README_show(struct nilfs_checkpoints_attr *attr,
 				struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, checkpoints_readme_str);
+	return sysfs_emit(buf, checkpoints_readme_str);
 }
 
 NILFS_CHECKPOINTS_RO_ATTR(checkpoints_number);
@@ -366,7 +366,7 @@ nilfs_segments_segments_number_show(struct nilfs_segments_attr *attr,
 				     struct the_nilfs *nilfs,
 				     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_nsegments);
+	return sysfs_emit(buf, "%lu\n", nilfs->ns_nsegments);
 }
 
 static ssize_t
@@ -374,7 +374,7 @@ nilfs_segments_blocks_per_segment_show(struct nilfs_segments_attr *attr,
 					struct the_nilfs *nilfs,
 					char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_blocks_per_segment);
+	return sysfs_emit(buf, "%lu\n", nilfs->ns_blocks_per_segment);
 }
 
 static ssize_t
@@ -388,7 +388,7 @@ nilfs_segments_clean_segments_show(struct nilfs_segments_attr *attr,
 	ncleansegs = nilfs_sufile_get_ncleansegs(nilfs->ns_sufile);
 	up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", ncleansegs);
+	return sysfs_emit(buf, "%lu\n", ncleansegs);
 }
 
 static ssize_t
@@ -408,7 +408,7 @@ nilfs_segments_dirty_segments_show(struct nilfs_segments_attr *attr,
 		return err;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", sustat.ss_ndirtysegs);
+	return sysfs_emit(buf, "%llu\n", sustat.ss_ndirtysegs);
 }
 
 static const char segments_readme_str[] =
@@ -424,7 +424,7 @@ nilfs_segments_README_show(struct nilfs_segments_attr *attr,
 			    struct the_nilfs *nilfs,
 			    char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, segments_readme_str);
+	return sysfs_emit(buf, segments_readme_str);
 }
 
 NILFS_SEGMENTS_RO_ATTR(segments_number);
@@ -461,7 +461,7 @@ nilfs_segctor_last_pseg_block_show(struct nilfs_segctor_attr *attr,
 	last_pseg = nilfs->ns_last_pseg;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)last_pseg);
 }
 
@@ -476,7 +476,7 @@ nilfs_segctor_last_seg_sequence_show(struct nilfs_segctor_attr *attr,
 	last_seq = nilfs->ns_last_seq;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_seq);
+	return sysfs_emit(buf, "%llu\n", last_seq);
 }
 
 static ssize_t
@@ -490,7 +490,7 @@ nilfs_segctor_last_seg_checkpoint_show(struct nilfs_segctor_attr *attr,
 	last_cno = nilfs->ns_last_cno;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
+	return sysfs_emit(buf, "%llu\n", last_cno);
 }
 
 static ssize_t
@@ -504,7 +504,7 @@ nilfs_segctor_current_seg_sequence_show(struct nilfs_segctor_attr *attr,
 	seg_seq = nilfs->ns_seg_seq;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", seg_seq);
+	return sysfs_emit(buf, "%llu\n", seg_seq);
 }
 
 static ssize_t
@@ -518,7 +518,7 @@ nilfs_segctor_current_last_full_seg_show(struct nilfs_segctor_attr *attr,
 	segnum = nilfs->ns_segnum;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", segnum);
+	return sysfs_emit(buf, "%llu\n", segnum);
 }
 
 static ssize_t
@@ -532,7 +532,7 @@ nilfs_segctor_next_full_seg_show(struct nilfs_segctor_attr *attr,
 	nextnum = nilfs->ns_nextnum;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nextnum);
+	return sysfs_emit(buf, "%llu\n", nextnum);
 }
 
 static ssize_t
@@ -546,7 +546,7 @@ nilfs_segctor_next_pseg_offset_show(struct nilfs_segctor_attr *attr,
 	pseg_offset = nilfs->ns_pseg_offset;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", pseg_offset);
+	return sysfs_emit(buf, "%lu\n", pseg_offset);
 }
 
 static ssize_t
@@ -560,7 +560,7 @@ nilfs_segctor_next_checkpoint_show(struct nilfs_segctor_attr *attr,
 	cno = nilfs->ns_cno;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
+	return sysfs_emit(buf, "%llu\n", cno);
 }
 
 static ssize_t
@@ -588,7 +588,7 @@ nilfs_segctor_last_seg_write_time_secs_show(struct nilfs_segctor_attr *attr,
 	ctime = nilfs->ns_ctime;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", ctime);
+	return sysfs_emit(buf, "%llu\n", ctime);
 }
 
 static ssize_t
@@ -616,7 +616,7 @@ nilfs_segctor_last_nongc_write_time_secs_show(struct nilfs_segctor_attr *attr,
 	nongc_ctime = nilfs->ns_nongc_ctime;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nongc_ctime);
+	return sysfs_emit(buf, "%llu\n", nongc_ctime);
 }
 
 static ssize_t
@@ -630,7 +630,7 @@ nilfs_segctor_dirty_data_blocks_count_show(struct nilfs_segctor_attr *attr,
 	ndirtyblks = atomic_read(&nilfs->ns_ndirtyblks);
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", ndirtyblks);
+	return sysfs_emit(buf, "%u\n", ndirtyblks);
 }
 
 static const char segctor_readme_str[] =
@@ -667,7 +667,7 @@ static ssize_t
 nilfs_segctor_README_show(struct nilfs_segctor_attr *attr,
 			  struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, segctor_readme_str);
+	return sysfs_emit(buf, segctor_readme_str);
 }
 
 NILFS_SEGCTOR_RO_ATTR(last_pseg_block);
@@ -736,7 +736,7 @@ nilfs_superblock_sb_write_time_secs_show(struct nilfs_superblock_attr *attr,
 	sbwtime = nilfs->ns_sbwtime;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", sbwtime);
+	return sysfs_emit(buf, "%llu\n", sbwtime);
 }
 
 static ssize_t
@@ -750,7 +750,7 @@ nilfs_superblock_sb_write_count_show(struct nilfs_superblock_attr *attr,
 	sbwcount = nilfs->ns_sbwcount;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", sbwcount);
+	return sysfs_emit(buf, "%u\n", sbwcount);
 }
 
 static ssize_t
@@ -764,7 +764,7 @@ nilfs_superblock_sb_update_frequency_show(struct nilfs_superblock_attr *attr,
 	sb_update_freq = nilfs->ns_sb_update_freq;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", sb_update_freq);
+	return sysfs_emit(buf, "%u\n", sb_update_freq);
 }
 
 static ssize_t
@@ -812,7 +812,7 @@ static ssize_t
 nilfs_superblock_README_show(struct nilfs_superblock_attr *attr,
 				struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, sb_readme_str);
+	return sysfs_emit(buf, sb_readme_str);
 }
 
 NILFS_SUPERBLOCK_RO_ATTR(sb_write_time);
@@ -843,11 +843,17 @@ ssize_t nilfs_dev_revision_show(struct nilfs_dev_attr *attr,
 				struct the_nilfs *nilfs,
 				char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
-	u32 major = le32_to_cpu(sbp[0]->s_rev_level);
-	u16 minor = le16_to_cpu(sbp[0]->s_minor_rev_level);
+	struct nilfs_super_block *raw_sb;
+	u32 major;
+	u16 minor;
 
-	return snprintf(buf, PAGE_SIZE, "%d.%d\n", major, minor);
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	major = le32_to_cpu(raw_sb->s_rev_level);
+	minor = le16_to_cpu(raw_sb->s_minor_rev_level);
+	up_read(&nilfs->ns_sem);
+
+	return sysfs_emit(buf, "%d.%d\n", major, minor);
 }
 
 static
@@ -855,7 +861,7 @@ ssize_t nilfs_dev_blocksize_show(struct nilfs_dev_attr *attr,
 				 struct the_nilfs *nilfs,
 				 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", nilfs->ns_blocksize);
+	return sysfs_emit(buf, "%u\n", nilfs->ns_blocksize);
 }
 
 static
@@ -863,10 +869,15 @@ ssize_t nilfs_dev_device_size_show(struct nilfs_dev_attr *attr,
 				    struct the_nilfs *nilfs,
 				    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
-	u64 dev_size = le64_to_cpu(sbp[0]->s_dev_size);
+	struct nilfs_super_block *raw_sb;
+	u64 dev_size;
+
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	dev_size = le64_to_cpu(raw_sb->s_dev_size);
+	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", dev_size);
+	return sysfs_emit(buf, "%llu\n", dev_size);
 }
 
 static
@@ -877,7 +888,7 @@ ssize_t nilfs_dev_free_blocks_show(struct nilfs_dev_attr *attr,
 	sector_t free_blocks = 0;
 
 	nilfs_count_free_blocks(nilfs, &free_blocks);
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)free_blocks);
 }
 
@@ -886,9 +897,15 @@ ssize_t nilfs_dev_uuid_show(struct nilfs_dev_attr *attr,
 			    struct the_nilfs *nilfs,
 			    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
+	struct nilfs_super_block *raw_sb;
+	ssize_t len;
 
-	return snprintf(buf, PAGE_SIZE, "%pUb\n", sbp[0]->s_uuid);
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	len = sysfs_emit(buf, "%pUb\n", raw_sb->s_uuid);
+	up_read(&nilfs->ns_sem);
+
+	return len;
 }
 
 static
@@ -896,10 +913,16 @@ ssize_t nilfs_dev_volume_name_show(struct nilfs_dev_attr *attr,
 				    struct the_nilfs *nilfs,
 				    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
+	struct nilfs_super_block *raw_sb;
+	ssize_t len;
+
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	len = scnprintf(buf, sizeof(raw_sb->s_volume_name), "%s\n",
+			raw_sb->s_volume_name);
+	up_read(&nilfs->ns_sem);
 
-	return scnprintf(buf, sizeof(sbp[0]->s_volume_name), "%s\n",
-			 sbp[0]->s_volume_name);
+	return len;
 }
 
 static const char dev_readme_str[] =
@@ -916,7 +939,7 @@ static ssize_t nilfs_dev_README_show(struct nilfs_dev_attr *attr,
 				     struct the_nilfs *nilfs,
 				     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, dev_readme_str);
+	return sysfs_emit(buf, dev_readme_str);
 }
 
 NILFS_DEV_RO_ATTR(revision);
@@ -1060,7 +1083,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
 static ssize_t nilfs_feature_revision_show(struct kobject *kobj,
 					    struct attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d.%d\n",
+	return sysfs_emit(buf, "%d.%d\n",
 			NILFS_CURRENT_REV, NILFS_MINOR_REV);
 }
 
@@ -1073,7 +1096,7 @@ static ssize_t nilfs_feature_README_show(struct kobject *kobj,
 					 struct attribute *attr,
 					 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, features_readme_str);
+	return sysfs_emit(buf, features_readme_str);
 }
 
 NILFS_FEATURE_RO_ATTR(revision);
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index e9793b1e49a5..89ac1c6de97b 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -289,8 +289,13 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
-		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_size = le32_to_cpu(sqsh_ino->symlink_size);
+		if (inode->i_size > PAGE_SIZE) {
+			ERROR("Corrupted symlink\n");
+			return -EINVAL;
+		}
+
+		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_op = &squashfs_symlink_inode_ops;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &squashfs_symlink_aops;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index bce48a07790c..22c76a33f6f3 100644
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
@@ -1047,12 +1054,19 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 	struct udf_part_map *map;
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct partitionHeaderDesc *phd;
+	u32 sum;
 	int err;
 
 	map = &sbi->s_partmaps[p_index];
 
 	map->s_partition_len = le32_to_cpu(p->partitionLength); /* blocks */
 	map->s_partition_root = le32_to_cpu(p->partitionStartingLocation);
+	if (check_add_overflow(map->s_partition_root, map->s_partition_len,
+			       &sum)) {
+		udf_err(sb, "Partition %d has invalid location %u + %u\n",
+			p_index, map->s_partition_root, map->s_partition_len);
+		return -EFSCORRUPTED;
+	}
 
 	if (p->accessType == cpu_to_le32(PD_ACCESS_TYPE_READ_ONLY))
 		map->s_partition_flags |= UDF_PART_FLAG_READ_ONLY;
@@ -1108,6 +1122,14 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 		bitmap->s_extPosition = le32_to_cpu(
 				phd->unallocSpaceBitmap.extPosition);
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_BITMAP;
+		/* Check whether math over bitmap won't overflow. */
+		if (check_add_overflow(map->s_partition_len,
+				       sizeof(struct spaceBitmapDesc) << 3,
+				       &sum)) {
+			udf_err(sb, "Partition %d is too long (%u)\n", p_index,
+				map->s_partition_len);
+			return -EFSCORRUPTED;
+		}
 		udf_debug("unallocSpaceBitmap (part %d) @ %u\n",
 			  p_index, bitmap->s_extPosition);
 	}
@@ -2307,7 +2329,7 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 		ret = -ENOMEM;
 		goto error_out;
 	}
-	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_maxbytes = UDF_MAX_FILESIZE;
 	sb->s_max_links = UDF_MAX_LINKS;
 	return 0;
 
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 941bfd9b3c89..7c5b217347b3 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -135,8 +135,7 @@ void ring_buffer_read_finish(struct ring_buffer_iter *iter);
 
 struct ring_buffer_event *
 ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts);
-struct ring_buffer_event *
-ring_buffer_read(struct ring_buffer_iter *iter, u64 *ts);
+void ring_buffer_iter_advance(struct ring_buffer_iter *iter);
 void ring_buffer_iter_reset(struct ring_buffer_iter *iter);
 int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
 
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index bc88ac6c2e1d..4c7c6ad382da 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -353,8 +353,13 @@ struct pernet_operations {
 	 * synchronize_rcu() related to these pernet_operations,
 	 * instead of separate synchronize_rcu() for every net.
 	 * Please, avoid synchronize_rcu() at all, where it's possible.
+	 *
+	 * Note that a combination of pre_exit() and exit() can
+	 * be used, since a synchronize_rcu() is guaranteed between
+	 * the calls.
 	 */
 	int (*init)(struct net *net);
+	void (*pre_exit)(struct net *net);
 	void (*exit)(struct net *net);
 	void (*exit_batch)(struct list_head *net_exit_list);
 	unsigned int *id;
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index d574ce63bf22..435bb79925b2 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -155,7 +155,8 @@ struct switchdev_notifier_fdb_info {
 	struct switchdev_notifier_info info; /* must be first */
 	const unsigned char *addr;
 	u16 vid;
-	bool added_by_user;
+	u8 added_by_user:1,
+	   offloaded:1;
 };
 
 static inline struct net_device *
diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index 904db6148476..998155444e0d 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -43,6 +43,7 @@ enum {
 #define NTF_PROXY	0x08	/* == ATF_PUBL */
 #define NTF_EXT_LEARNED	0x10
 #define NTF_OFFLOADED   0x20
+#define NTF_STICKY	0x40
 #define NTF_ROUTER	0x80
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6322b56529e9..30c058806702 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1712,9 +1712,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		RCU_INIT_POINTER(scgrp->subsys[ssid], NULL);
 		rcu_assign_pointer(dcgrp->subsys[ssid], css);
 		ss->root = dst_root;
-		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
+		css->cgroup = dcgrp;
 		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
 		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
 					 e_cset_node[ss->id]) {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 72ae05d65066..3361da45e1db 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1187,7 +1187,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 	struct xol_area *area;
 
-	area = kmalloc(sizeof(*area), GFP_KERNEL);
+	area = kzalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
 		goto out;
 
@@ -1197,7 +1197,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		goto free_area;
 
 	area->xol_mapping.name = "[uprobes]";
-	area->xol_mapping.fault = NULL;
 	area->xol_mapping.pages = area->pages;
 	area->pages[0] = alloc_page(GFP_HIGHUSER);
 	if (!area->pages[0])
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index a5ec4f68527e..c552fb0b54bc 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1205,6 +1205,7 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 }
 
 static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
+				     struct rt_mutex *lock,
 				     struct rt_mutex_waiter *w)
 {
 	/*
@@ -1214,6 +1215,7 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	if (res != -EDEADLOCK || detect_deadlock)
 		return;
 
+	raw_spin_unlock_irq(&lock->wait_lock);
 	/*
 	 * Yell lowdly and stop the task right here.
 	 */
@@ -1269,7 +1271,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	if (unlikely(ret)) {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, lock, &waiter);
 	}
 
 	/*
diff --git a/kernel/smp.c b/kernel/smp.c
index 9fa2fe6c0c05..c5f333258ecf 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -791,6 +791,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 
 	queue_work_on(cpu, system_wq, &sscs.work);
 	wait_for_completion(&sscs.done);
+	destroy_work_on_stack(&sscs.work);
 
 	return sscs.ret;
 }
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index aee6eab9bb8f..6cd50fb1b8fd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4379,35 +4379,24 @@ ring_buffer_read_finish(struct ring_buffer_iter *iter)
 EXPORT_SYMBOL_GPL(ring_buffer_read_finish);
 
 /**
- * ring_buffer_read - read the next item in the ring buffer by the iterator
+ * ring_buffer_iter_advance - advance the iterator to the next location
  * @iter: The ring buffer iterator
- * @ts: The time stamp of the event read.
  *
- * This reads the next event in the ring buffer and increments the iterator.
+ * Move the location of the iterator such that the next read will
+ * be the next location of the iterator.
  */
-struct ring_buffer_event *
-ring_buffer_read(struct ring_buffer_iter *iter, u64 *ts)
+void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
 {
-	struct ring_buffer_event *event;
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
- again:
-	event = rb_iter_peek(iter, ts);
-	if (!event)
-		goto out;
-
-	if (event->type_len == RINGBUF_TYPE_PADDING)
-		goto again;
 
 	rb_advance_iter(iter);
- out:
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-	return event;
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 }
-EXPORT_SYMBOL_GPL(ring_buffer_read);
+EXPORT_SYMBOL_GPL(ring_buffer_iter_advance);
 
 /**
  * ring_buffer_size - return the size of the ring buffer (in bytes)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8292c7441e23..63c3c17d406c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3090,7 +3090,7 @@ static void trace_iterator_increment(struct trace_iterator *iter)
 
 	iter->idx++;
 	if (buf_iter)
-		ring_buffer_read(buf_iter, NULL);
+		ring_buffer_iter_advance(buf_iter);
 }
 
 static struct trace_entry *
@@ -3250,7 +3250,9 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 		if (ts >= iter->trace_buffer->time_start)
 			break;
 		entries++;
-		ring_buffer_read(buf_iter, NULL);
+		ring_buffer_iter_advance(buf_iter);
+		/* This could be a big loop */
+		cond_resched();
 	}
 
 	per_cpu_ptr(iter->trace_buffer->data, cpu)->skipped_entries = entries;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 086af4f5c3e8..7add1f3ee2dd 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -726,7 +726,7 @@ get_return_for_leaf(struct trace_iterator *iter,
 
 	/* this is a leaf, now advance the iterator */
 	if (ring_iter)
-		ring_buffer_read(ring_iter, NULL);
+		ring_buffer_iter_advance(ring_iter);
 
 	return next;
 }
diff --git a/net/bridge/br.c b/net/bridge/br.c
index b0a0b82e2d91..a175f5557873 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -151,7 +151,7 @@ static int br_switchdev_event(struct notifier_block *unused,
 			break;
 		}
 		br_fdb_offloaded_set(br, p, fdb_info->addr,
-				     fdb_info->vid);
+				     fdb_info->vid, true);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_BRIDGE:
 		fdb_info = ptr;
@@ -163,7 +163,7 @@ static int br_switchdev_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_OFFLOADED:
 		fdb_info = ptr;
 		br_fdb_offloaded_set(br, p, fdb_info->addr,
-				     fdb_info->vid);
+				     fdb_info->vid, fdb_info->offloaded);
 		break;
 	}
 
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 4d4b9b5ea1c1..a6e4901909e3 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -80,8 +80,9 @@ static inline unsigned long hold_time(const struct net_bridge *br)
 static inline int has_expired(const struct net_bridge *br,
 				  const struct net_bridge_fdb_entry *fdb)
 {
-	return !fdb->is_static && !fdb->added_by_external_learn &&
-		time_before_eq(fdb->updated + hold_time(br), jiffies);
+	return !test_bit(BR_FDB_STATIC, &fdb->flags) &&
+	       !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags) &&
+	       time_before_eq(fdb->updated + hold_time(br), jiffies);
 }
 
 static void fdb_rcu_free(struct rcu_head *head)
@@ -202,7 +203,7 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
 {
 	trace_fdb_delete(br, f);
 
-	if (f->is_static)
+	if (test_bit(BR_FDB_STATIC, &f->flags))
 		fdb_del_hw_addr(br, f->key.addr.addr);
 
 	hlist_del_init_rcu(&f->fdb_node);
@@ -229,7 +230,7 @@ static void fdb_delete_local(struct net_bridge *br,
 		if (op != p && ether_addr_equal(op->dev->dev_addr, addr) &&
 		    (!vid || br_vlan_find(vg, vid))) {
 			f->dst = op;
-			f->added_by_user = 0;
+			clear_bit(BR_FDB_ADDED_BY_USER, &f->flags);
 			return;
 		}
 	}
@@ -240,7 +241,7 @@ static void fdb_delete_local(struct net_bridge *br,
 	if (p && ether_addr_equal(br->dev->dev_addr, addr) &&
 	    (!vid || (v && br_vlan_should_use(v)))) {
 		f->dst = NULL;
-		f->added_by_user = 0;
+		clear_bit(BR_FDB_ADDED_BY_USER, &f->flags);
 		return;
 	}
 
@@ -255,7 +256,8 @@ void br_fdb_find_delete_local(struct net_bridge *br,
 
 	spin_lock_bh(&br->hash_lock);
 	f = br_fdb_find(br, addr, vid);
-	if (f && f->is_local && !f->added_by_user && f->dst == p)
+	if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
+	    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags) && f->dst == p)
 		fdb_delete_local(br, p, f);
 	spin_unlock_bh(&br->hash_lock);
 }
@@ -270,7 +272,8 @@ void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
 	spin_lock_bh(&br->hash_lock);
 	vg = nbp_vlan_group(p);
 	hlist_for_each_entry(f, &br->fdb_list, fdb_node) {
-		if (f->dst == p && f->is_local && !f->added_by_user) {
+		if (f->dst == p && test_bit(BR_FDB_LOCAL, &f->flags) &&
+		    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags)) {
 			/* delete old one */
 			fdb_delete_local(br, p, f);
 
@@ -311,7 +314,8 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 
 	/* If old entry was unassociated with any port, then delete it. */
 	f = br_fdb_find(br, br->dev->dev_addr, 0);
-	if (f && f->is_local && !f->dst && !f->added_by_user)
+	if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
+	    !f->dst && !test_bit(BR_FDB_ADDED_BY_USER, &f->flags))
 		fdb_delete_local(br, NULL, f);
 
 	fdb_insert(br, NULL, newaddr, 0);
@@ -326,7 +330,8 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 		if (!br_vlan_should_use(v))
 			continue;
 		f = br_fdb_find(br, br->dev->dev_addr, v->vid);
-		if (f && f->is_local && !f->dst && !f->added_by_user)
+		if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
+		    !f->dst && !test_bit(BR_FDB_ADDED_BY_USER, &f->flags))
 			fdb_delete_local(br, NULL, f);
 		fdb_insert(br, NULL, newaddr, v->vid);
 	}
@@ -351,7 +356,8 @@ void br_fdb_cleanup(struct work_struct *work)
 	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
 		unsigned long this_timer;
 
-		if (f->is_static || f->added_by_external_learn)
+		if (test_bit(BR_FDB_STATIC, &f->flags) ||
+		    test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags))
 			continue;
 		this_timer = f->updated + delay;
 		if (time_after(this_timer, now)) {
@@ -378,7 +384,7 @@ void br_fdb_flush(struct net_bridge *br)
 
 	spin_lock_bh(&br->hash_lock);
 	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
-		if (!f->is_static)
+		if (!test_bit(BR_FDB_STATIC, &f->flags))
 			fdb_delete(br, f, true);
 	}
 	spin_unlock_bh(&br->hash_lock);
@@ -402,10 +408,11 @@ void br_fdb_delete_by_port(struct net_bridge *br,
 			continue;
 
 		if (!do_all)
-			if (f->is_static || (vid && f->key.vlan_id != vid))
+			if (test_bit(BR_FDB_STATIC, &f->flags) ||
+			    (vid && f->key.vlan_id != vid))
 				continue;
 
-		if (f->is_local)
+		if (test_bit(BR_FDB_LOCAL, &f->flags))
 			fdb_delete_local(br, p, f);
 		else
 			fdb_delete(br, f, true);
@@ -474,8 +481,8 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		fe->port_no = f->dst->port_no;
 		fe->port_hi = f->dst->port_no >> 8;
 
-		fe->is_local = f->is_local;
-		if (!f->is_static)
+		fe->is_local = test_bit(BR_FDB_LOCAL, &f->flags);
+		if (!test_bit(BR_FDB_STATIC, &f->flags))
 			fe->ageing_timer_value = jiffies_delta_to_clock_t(jiffies - f->updated);
 		++fe;
 		++num;
@@ -499,10 +506,11 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
 		memcpy(fdb->key.addr.addr, addr, ETH_ALEN);
 		fdb->dst = source;
 		fdb->key.vlan_id = vid;
-		fdb->is_local = is_local;
-		fdb->is_static = is_static;
-		fdb->added_by_user = 0;
-		fdb->added_by_external_learn = 0;
+		fdb->flags = 0;
+		if (is_local)
+			set_bit(BR_FDB_LOCAL, &fdb->flags);
+		if (is_static)
+			set_bit(BR_FDB_STATIC, &fdb->flags);
 		fdb->offloaded = 0;
 		fdb->updated = fdb->used = jiffies;
 		if (rhashtable_lookup_insert_fast(&br->fdb_hash_tbl,
@@ -530,7 +538,7 @@ static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 		/* it is okay to have multiple ports with same
 		 * address, just use the first one.
 		 */
-		if (fdb->is_local)
+		if (test_bit(BR_FDB_LOCAL, &fdb->flags))
 			return 0;
 		br_warn(br, "adding interface %s with same address as a received packet (addr:%pM, vlan:%u)\n",
 		       source ? source->dev->name : br->dev->name, addr, vid);
@@ -576,7 +584,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 	if (likely(fdb)) {
 		/* attempt to update an entry for a local interface */
-		if (unlikely(fdb->is_local)) {
+		if (unlikely(test_bit(BR_FDB_LOCAL, &fdb->flags))) {
 			if (net_ratelimit())
 				br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
 					source->dev->name, addr, vid);
@@ -584,17 +592,18 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			unsigned long now = jiffies;
 
 			/* fastpath: update of existing entry */
-			if (unlikely(source != fdb->dst)) {
+			if (unlikely(source != fdb->dst &&
+				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
 				fdb->dst = source;
 				fdb_modified = true;
 				/* Take over HW learned entry */
-				if (unlikely(fdb->added_by_external_learn))
-					fdb->added_by_external_learn = 0;
+				test_and_clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
+						   &fdb->flags);
 			}
 			if (now != fdb->updated)
 				fdb->updated = now;
 			if (unlikely(added_by_user))
-				fdb->added_by_user = 1;
+				set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 			if (unlikely(fdb_modified)) {
 				trace_br_fdb_update(br, source, addr, vid, added_by_user);
 				fdb_notify(br, fdb, RTM_NEWNEIGH, true);
@@ -605,7 +614,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 		fdb = fdb_create(br, source, addr, vid, 0, 0);
 		if (fdb) {
 			if (unlikely(added_by_user))
-				fdb->added_by_user = 1;
+				set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 			trace_br_fdb_update(br, source, addr, vid,
 					    added_by_user);
 			fdb_notify(br, fdb, RTM_NEWNEIGH, true);
@@ -620,9 +629,9 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 static int fdb_to_nud(const struct net_bridge *br,
 		      const struct net_bridge_fdb_entry *fdb)
 {
-	if (fdb->is_local)
+	if (test_bit(BR_FDB_LOCAL, &fdb->flags))
 		return NUD_PERMANENT;
-	else if (fdb->is_static)
+	else if (test_bit(BR_FDB_STATIC, &fdb->flags))
 		return NUD_NOARP;
 	else if (has_expired(br, fdb))
 		return NUD_STALE;
@@ -654,8 +663,10 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
 
 	if (fdb->offloaded)
 		ndm->ndm_flags |= NTF_OFFLOADED;
-	if (fdb->added_by_external_learn)
+	if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
 		ndm->ndm_flags |= NTF_EXT_LEARNED;
+	if (test_bit(BR_FDB_STICKY, &fdb->flags))
+		ndm->ndm_flags |= NTF_STICKY;
 
 	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.addr))
 		goto nla_put_failure;
@@ -772,8 +783,10 @@ int br_fdb_dump(struct sk_buff *skb,
 
 /* Update (create or replace) forwarding database entry */
 static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
-			 const __u8 *addr, __u16 state, __u16 flags, __u16 vid)
+			 const u8 *addr, u16 state, u16 flags, u16 vid,
+			 u8 ndm_flags)
 {
+	bool is_sticky = !!(ndm_flags & NTF_STICKY);
 	struct net_bridge_fdb_entry *fdb;
 	bool modified = false;
 
@@ -789,6 +802,9 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		return -EINVAL;
 	}
 
+	if (is_sticky && (state & NUD_PERMANENT))
+		return -EINVAL;
+
 	fdb = br_fdb_find(br, addr, vid);
 	if (fdb == NULL) {
 		if (!(flags & NLM_F_CREATE))
@@ -811,28 +827,28 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 
 	if (fdb_to_nud(br, fdb) != state) {
 		if (state & NUD_PERMANENT) {
-			fdb->is_local = 1;
-			if (!fdb->is_static) {
-				fdb->is_static = 1;
+			set_bit(BR_FDB_LOCAL, &fdb->flags);
+			if (!test_and_set_bit(BR_FDB_STATIC, &fdb->flags))
 				fdb_add_hw_addr(br, addr);
-			}
 		} else if (state & NUD_NOARP) {
-			fdb->is_local = 0;
-			if (!fdb->is_static) {
-				fdb->is_static = 1;
+			clear_bit(BR_FDB_LOCAL, &fdb->flags);
+			if (!test_and_set_bit(BR_FDB_STATIC, &fdb->flags))
 				fdb_add_hw_addr(br, addr);
-			}
 		} else {
-			fdb->is_local = 0;
-			if (fdb->is_static) {
-				fdb->is_static = 0;
+			clear_bit(BR_FDB_LOCAL, &fdb->flags);
+			if (test_and_clear_bit(BR_FDB_STATIC, &fdb->flags))
 				fdb_del_hw_addr(br, addr);
-			}
 		}
 
 		modified = true;
 	}
-	fdb->added_by_user = 1;
+
+	if (is_sticky != test_bit(BR_FDB_STICKY, &fdb->flags)) {
+		change_bit(BR_FDB_STICKY, &fdb->flags);
+		modified = true;
+	}
+
+	set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 
 	fdb->used = jiffies;
 	if (modified) {
@@ -865,7 +881,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 	} else {
 		spin_lock_bh(&br->hash_lock);
 		err = fdb_add_entry(br, p, addr, ndm->ndm_state,
-				    nlh_flags, vid);
+				    nlh_flags, vid, ndm->ndm_flags);
 		spin_unlock_bh(&br->hash_lock);
 	}
 
@@ -1028,7 +1044,7 @@ int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p)
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
 		/* We only care for static entries */
-		if (!f->is_static)
+		if (!test_bit(BR_FDB_STATIC, &f->flags))
 			continue;
 		err = dev_uc_add(p->dev, f->key.addr.addr);
 		if (err)
@@ -1042,7 +1058,7 @@ int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p)
 rollback:
 	hlist_for_each_entry_rcu(tmp, &br->fdb_list, fdb_node) {
 		/* We only care for static entries */
-		if (!tmp->is_static)
+		if (!test_bit(BR_FDB_STATIC, &tmp->flags))
 			continue;
 		if (tmp == f)
 			break;
@@ -1061,7 +1077,7 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
 		/* We only care for static entries */
-		if (!f->is_static)
+		if (!test_bit(BR_FDB_STATIC, &f->flags))
 			continue;
 
 		dev_uc_del(p->dev, f->key.addr.addr);
@@ -1089,8 +1105,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			goto err_unlock;
 		}
 		if (swdev_notify)
-			fdb->added_by_user = 1;
-		fdb->added_by_external_learn = 1;
+			set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
+		set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
 		fdb->updated = jiffies;
@@ -1100,17 +1116,15 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			modified = true;
 		}
 
-		if (fdb->added_by_external_learn) {
+		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
 			fdb->used = jiffies;
-		} else if (!fdb->added_by_user) {
-			/* Take over SW learned entry */
-			fdb->added_by_external_learn = 1;
+		} else {
 			modified = true;
 		}
 
 		if (swdev_notify)
-			fdb->added_by_user = 1;
+			set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 
 		if (modified)
 			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
@@ -1132,7 +1146,7 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 	spin_lock_bh(&br->hash_lock);
 
 	fdb = br_fdb_find(br, addr, vid);
-	if (fdb && fdb->added_by_external_learn)
+	if (fdb && test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
 		fdb_delete(br, fdb, swdev_notify);
 	else
 		err = -ENOENT;
@@ -1143,7 +1157,7 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 }
 
 void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
-			  const unsigned char *addr, u16 vid)
+			  const unsigned char *addr, u16 vid, bool offloaded)
 {
 	struct net_bridge_fdb_entry *fdb;
 
@@ -1151,7 +1165,7 @@ void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
 
 	fdb = br_fdb_find(br, addr, vid);
 	if (fdb)
-		fdb->offloaded = 1;
+		fdb->offloaded = offloaded;
 
 	spin_unlock_bh(&br->hash_lock);
 }
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index f3938337ff87..e126ba0bd486 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -163,7 +163,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (dst) {
 		unsigned long now = jiffies;
 
-		if (dst->is_local)
+		if (test_bit(BR_FDB_LOCAL, &dst->flags))
 			return br_pass_frame_up(skb);
 
 		if (now != dst->used)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 7ca3b469242e..4ff5e3c96e57 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -168,6 +168,15 @@ struct net_bridge_vlan_group {
 	u16				pvid;
 };
 
+/* bridge fdb flags */
+enum {
+	BR_FDB_LOCAL,
+	BR_FDB_STATIC,
+	BR_FDB_STICKY,
+	BR_FDB_ADDED_BY_USER,
+	BR_FDB_ADDED_BY_EXT_LEARN,
+};
+
 struct net_bridge_fdb_key {
 	mac_addr addr;
 	u16 vlan_id;
@@ -179,11 +188,8 @@ struct net_bridge_fdb_entry {
 
 	struct net_bridge_fdb_key	key;
 	struct hlist_node		fdb_node;
-	unsigned char			is_local:1,
-					is_static:1,
-					added_by_user:1,
-					added_by_external_learn:1,
-					offloaded:1;
+	unsigned long			flags;
+	unsigned char			offloaded:1;
 
 	/* write-heavy members should not affect lookups */
 	unsigned long			updated ____cacheline_aligned_in_smp;
@@ -564,7 +570,7 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
 			      bool swdev_notify);
 void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
-			  const unsigned char *addr, u16 vid);
+			  const unsigned char *addr, u16 vid, bool offloaded);
 
 /* br_forward.c */
 enum br_pkt_type {
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index d77f807420c4..e8948d49e5fc 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -103,7 +103,7 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 static void
 br_switchdev_fdb_call_notifiers(bool adding, const unsigned char *mac,
 				u16 vid, struct net_device *dev,
-				bool added_by_user)
+				bool added_by_user, bool offloaded)
 {
 	struct switchdev_notifier_fdb_info info;
 	unsigned long notifier_type;
@@ -111,6 +111,7 @@ br_switchdev_fdb_call_notifiers(bool adding, const unsigned char *mac,
 	info.addr = mac;
 	info.vid = vid;
 	info.added_by_user = added_by_user;
+	info.offloaded = offloaded;
 	notifier_type = adding ? SWITCHDEV_FDB_ADD_TO_DEVICE : SWITCHDEV_FDB_DEL_TO_DEVICE;
 	call_switchdev_notifiers(notifier_type, dev, &info.info);
 }
@@ -126,13 +127,17 @@ br_switchdev_fdb_notify(const struct net_bridge_fdb_entry *fdb, int type)
 		br_switchdev_fdb_call_notifiers(false, fdb->key.addr.addr,
 						fdb->key.vlan_id,
 						fdb->dst->dev,
-						fdb->added_by_user);
+						test_bit(BR_FDB_ADDED_BY_USER,
+							 &fdb->flags),
+						fdb->offloaded);
 		break;
 	case RTM_NEWNEIGH:
 		br_switchdev_fdb_call_notifiers(true, fdb->key.addr.addr,
 						fdb->key.vlan_id,
 						fdb->dst->dev,
-						fdb->added_by_user);
+						test_bit(BR_FDB_ADDED_BY_USER,
+							 &fdb->flags),
+						fdb->offloaded);
 		break;
 	}
 }
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 1c9953c68f09..095f68536c14 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1422,6 +1422,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
+#if IS_ENABLED(CONFIG_PROC_FS)
+			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read)
+				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
+#endif
 			bo->bound   = 0;
 			bo->ifindex = 0;
 			notify_enodev = 1;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index baf00a808d74..a7105645ccfc 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -154,6 +154,17 @@ static void ops_free(const struct pernet_operations *ops, struct net *net)
 	}
 }
 
+static void ops_pre_exit_list(const struct pernet_operations *ops,
+			      struct list_head *net_exit_list)
+{
+	struct net *net;
+
+	if (ops->pre_exit) {
+		list_for_each_entry(net, net_exit_list, exit_list)
+			ops->pre_exit(net);
+	}
+}
+
 static void ops_exit_list(const struct pernet_operations *ops,
 			  struct list_head *net_exit_list)
 {
@@ -341,6 +352,12 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 	 */
 	list_add(&net->exit_list, &net_exit_list);
 	saved_ops = ops;
+	list_for_each_entry_continue_reverse(ops, &pernet_list, list)
+		ops_pre_exit_list(ops, &net_exit_list);
+
+	synchronize_rcu();
+
+	ops = saved_ops;
 	list_for_each_entry_continue_reverse(ops, &pernet_list, list)
 		ops_exit_list(ops, &net_exit_list);
 
@@ -554,10 +571,15 @@ static void cleanup_net(struct work_struct *work)
 		list_add_tail(&net->exit_list, &net_exit_list);
 	}
 
+	/* Run all of the network namespace pre_exit methods */
+	list_for_each_entry_reverse(ops, &pernet_list, list)
+		ops_pre_exit_list(ops, &net_exit_list);
+
 	/*
 	 * Another CPU might be rcu-iterating the list, wait for it.
 	 * This needs to be before calling the exit() notifiers, so
 	 * the rcu_barrier() below isn't sufficient alone.
+	 * Also the pre_exit() and exit() methods need this barrier.
 	 */
 	synchronize_rcu();
 
@@ -977,6 +999,8 @@ static int __register_pernet_operations(struct list_head *list,
 out_undo:
 	/* If I have an error cleanup all namespaces I initialized */
 	list_del(&ops->list);
+	ops_pre_exit_list(ops, &net_exit_list);
+	synchronize_rcu();
 	ops_exit_list(ops, &net_exit_list);
 	ops_free_list(ops, &net_exit_list);
 	return error;
@@ -991,6 +1015,8 @@ static void __unregister_pernet_operations(struct pernet_operations *ops)
 	/* See comment in __register_pernet_operations() */
 	for_each_net(net)
 		list_add_tail(&net->exit_list, &net_exit_list);
+	ops_pre_exit_list(ops, &net_exit_list);
+	synchronize_rcu();
 	ops_exit_list(ops, &net_exit_list);
 	ops_free_list(ops, &net_exit_list);
 }
@@ -1015,6 +1041,8 @@ static void __unregister_pernet_operations(struct pernet_operations *ops)
 	} else {
 		LIST_HEAD(net_exit_list);
 		list_add(&init_net.exit_list, &net_exit_list);
+		ops_pre_exit_list(ops, &net_exit_list);
+		synchronize_rcu();
 		ops_exit_list(ops, &net_exit_list);
 		ops_free_list(ops, &net_exit_list);
 	}
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index f7c122357a96..9b74e439809f 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1464,6 +1464,7 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 			netdev_dbg(dev, "fdb add failed err=%d\n", err);
 			break;
 		}
+		fdb_info->offloaded = true;
 		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, dev,
 					 &fdb_info->info);
 		break;
diff --git a/net/ipv6/ila/ila.h b/net/ipv6/ila/ila.h
index 1f747bcbec29..1d13adaebb69 100644
--- a/net/ipv6/ila/ila.h
+++ b/net/ipv6/ila/ila.h
@@ -118,6 +118,7 @@ int ila_lwt_init(void);
 void ila_lwt_fini(void);
 
 int ila_xlat_init_net(struct net *net);
+void ila_xlat_pre_exit_net(struct net *net);
 void ila_xlat_exit_net(struct net *net);
 
 int ila_xlat_nl_cmd_add_mapping(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ipv6/ila/ila_main.c b/net/ipv6/ila/ila_main.c
index 18fac76b9520..6189a630461c 100644
--- a/net/ipv6/ila/ila_main.c
+++ b/net/ipv6/ila/ila_main.c
@@ -70,6 +70,11 @@ static __net_init int ila_init_net(struct net *net)
 	return err;
 }
 
+static __net_exit void ila_pre_exit_net(struct net *net)
+{
+	ila_xlat_pre_exit_net(net);
+}
+
 static __net_exit void ila_exit_net(struct net *net)
 {
 	ila_xlat_exit_net(net);
@@ -77,6 +82,7 @@ static __net_exit void ila_exit_net(struct net *net)
 
 static struct pernet_operations ila_net_ops = {
 	.init = ila_init_net,
+	.pre_exit = ila_pre_exit_net,
 	.exit = ila_exit_net,
 	.id   = &ila_net_id,
 	.size = sizeof(struct ila_net),
diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 87744eb8d0c4..7634556710fd 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -627,6 +627,15 @@ int ila_xlat_init_net(struct net *net)
 	return 0;
 }
 
+void ila_xlat_pre_exit_net(struct net *net)
+{
+	struct ila_net *ilan = net_generic(net, ila_net_id);
+
+	if (ilan->xlat.hooks_registered)
+		nf_unregister_net_hooks(net, ila_nf_hook_ops,
+					ARRAY_SIZE(ila_nf_hook_ops));
+}
+
 void ila_xlat_exit_net(struct net *net)
 {
 	struct ila_net *ilan = net_generic(net, ila_net_id);
@@ -634,10 +643,6 @@ void ila_xlat_exit_net(struct net *net)
 	rhashtable_free_and_destroy(&ilan->xlat.rhash_table, ila_free_cb, NULL);
 
 	free_bucket_spinlocks(ilan->xlat.locks);
-
-	if (ilan->xlat.hooks_registered)
-		nf_unregister_net_hooks(net, ila_nf_hook_ops,
-					ARRAY_SIZE(ila_nf_hook_ops));
 }
 
 static int ila_xlat_addr(struct sk_buff *skb, bool sir2ila)
diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 7554c56b2e63..d189ca7c2c02 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -309,7 +309,6 @@ insert_tree(struct net *net,
 	struct nf_conncount_rb *rbconn;
 	struct nf_conncount_tuple *conn;
 	unsigned int count = 0, gc_count = 0;
-	u8 keylen = data->keylen;
 	bool do_gc = true;
 
 	spin_lock_bh(&nf_conncount_locks[hash]);
@@ -321,7 +320,7 @@ insert_tree(struct net *net,
 		rbconn = rb_entry(*rbnode, struct nf_conncount_rb, node);
 
 		parent = *rbnode;
-		diff = key_diff(key, rbconn->key, keylen);
+		diff = key_diff(key, rbconn->key, data->keylen);
 		if (diff < 0) {
 			rbnode = &((*rbnode)->rb_left);
 		} else if (diff > 0) {
@@ -366,7 +365,7 @@ insert_tree(struct net *net,
 
 	conn->tuple = *tuple;
 	conn->zone = *zone;
-	memcpy(rbconn->key, key, sizeof(u32) * keylen);
+	memcpy(rbconn->key, key, sizeof(u32) * data->keylen);
 
 	nf_conncount_list_init(&rbconn->list);
 	list_add(&conn->node, &rbconn->list.head);
@@ -391,7 +390,6 @@ count_tree(struct net *net,
 	struct rb_node *parent;
 	struct nf_conncount_rb *rbconn;
 	unsigned int hash;
-	u8 keylen = data->keylen;
 
 	hash = jhash2(key, data->keylen, conncount_rnd) % CONNCOUNT_SLOTS;
 	root = &data->root[hash];
@@ -402,7 +400,7 @@ count_tree(struct net *net,
 
 		rbconn = rb_entry(parent, struct nf_conncount_rb, node);
 
-		diff = key_diff(key, rbconn->key, keylen);
+		diff = key_diff(key, rbconn->key, data->keylen);
 		if (diff < 0) {
 			parent = rcu_dereference_raw(parent->rb_left);
 		} else if (diff > 0) {
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index d6467cbf5c4f..d138a2123d70 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -510,8 +510,8 @@ void rfkill_remove_epo_lock(void)
 /**
  * rfkill_is_epo_lock_active - returns true EPO is active
  *
- * Returns 0 (false) if there is NOT an active EPO contidion,
- * and 1 (true) if there is an active EPO contition, which
+ * Returns 0 (false) if there is NOT an active EPO condition,
+ * and 1 (true) if there is an active EPO condition, which
  * locks all radios in one of the BLOCKED states.
  *
  * Can be called in atomic context.
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index cf93dbe3d040..b13a670c5c63 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -697,11 +697,10 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 
 				err = qdisc_enqueue(skb, q->qdisc, &to_free);
 				kfree_skb_list(to_free);
-				if (err != NET_XMIT_SUCCESS &&
-				    net_xmit_drop_count(err)) {
-					qdisc_qstats_drop(sch);
-					qdisc_tree_reduce_backlog(sch, 1,
-								  pkt_len);
+				if (err != NET_XMIT_SUCCESS) {
+					if (net_xmit_drop_count(err))
+						qdisc_qstats_drop(sch);
+					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
 				goto tfifo_dequeue;
 			}
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 938c649c5c9f..625b5f69d3ca 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2466,6 +2466,13 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	case -EALREADY:
 		xprt_unlock_connect(xprt, transport);
 		return;
+	case -EPERM:
+		/* Happens, for instance, if a BPF program is preventing
+		 * the connect. Remap the error so upper layers can better
+		 * deal with it.
+		 */
+		status = -ECONNREFUSED;
+		/* fall through */
 	case -EINVAL:
 		/* Happens, for instance, if the user specified a link
 		 * local IPv6 address without a scope-id.
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index dfcafbb8cd0e..24fb6f00f597 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -610,9 +610,6 @@ static void init_peercred(struct sock *sk)
 
 static void copy_peercred(struct sock *sk, struct sock *peersk)
 {
-	const struct cred *old_cred;
-	struct pid *old_pid;
-
 	if (sk < peersk) {
 		spin_lock(&sk->sk_peer_lock);
 		spin_lock_nested(&peersk->sk_peer_lock, SINGLE_DEPTH_NESTING);
@@ -620,16 +617,12 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 		spin_lock(&peersk->sk_peer_lock);
 		spin_lock_nested(&sk->sk_peer_lock, SINGLE_DEPTH_NESTING);
 	}
-	old_pid = sk->sk_peer_pid;
-	old_cred = sk->sk_peer_cred;
+
 	sk->sk_peer_pid  = get_pid(peersk->sk_peer_pid);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
 
 	spin_unlock(&sk->sk_peer_lock);
 	spin_unlock(&peersk->sk_peer_lock);
-
-	put_pid(old_pid);
-	put_cred(old_cred);
 }
 
 static int unix_listen(struct socket *sock, int backlog)
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 80012d21f038..1223b2648a54 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1593,6 +1593,10 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
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
index d9bff4ba7f2e..00d8e1b53b2a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3745,12 +3745,18 @@ static int smack_unix_stream_connect(struct sock *sock,
 		}
 	}
 
-	/*
-	 * Cross reference the peer labels for SO_PEERSEC.
-	 */
 	if (rc == 0) {
+		/*
+		 * Cross reference the peer labels for SO_PEERSEC.
+		 */
 		nsp->smk_packet = ssp->smk_out;
 		ssp->smk_packet = osp->smk_out;
+
+		/*
+		 * new/child/established socket must inherit listening socket labels
+		 */
+		nsp->smk_out = osp->smk_out;
+		nsp->smk_in  = osp->smk_in;
 	}
 
 	return rc;
@@ -4291,7 +4297,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	rcu_read_unlock();
 
 	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
+		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
 	else
 		netlbl_req_delattr(req);
 
diff --git a/sound/hda/hdmi_chmap.c b/sound/hda/hdmi_chmap.c
index acbe61b8db7b..4463992d2102 100644
--- a/sound/hda/hdmi_chmap.c
+++ b/sound/hda/hdmi_chmap.c
@@ -752,6 +752,20 @@ static int hdmi_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+/* a simple sanity check for input values to chmap kcontrol */
+static int chmap_value_check(struct hdac_chmap *hchmap,
+			     const struct snd_ctl_elem_value *ucontrol)
+{
+	int i;
+
+	for (i = 0; i < hchmap->channels_max; i++) {
+		if (ucontrol->value.integer.value[i] < 0 ||
+		    ucontrol->value.integer.value[i] > SNDRV_CHMAP_LAST)
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
@@ -763,6 +777,10 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	unsigned char chmap[8], per_pin_chmap[8];
 	int i, err, ca, prepared = 0;
 
+	err = chmap_value_check(hchmap, ucontrol);
+	if (err < 0)
+		return err;
+
 	/* No monitor is connected in dyn_pcm_assign.
 	 * It's invalid to setup the chmap
 	 */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index d97d4286c9d7..1d95977b4a91 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -230,6 +230,7 @@ enum {
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
+	CXT_PINCFG_TOP_SPEAKER,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -884,6 +885,13 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
+	[CXT_PINCFG_TOP_SPEAKER] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1d, 0x82170111 },
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -978,6 +986,8 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
+	SND_PCI_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
+	SND_PCI_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
 	{}
 };
 
@@ -996,6 +1006,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_FIXUP_HP_MIC_NO_PRESENCE, .name = "hp-mic-fix" },
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
 	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
+	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
 	{}
 };
 
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index 7712e2b84183..029489b490ca 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -76,6 +76,20 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype
 	return NULL;
 }
 
+/* check the validity of pipe and EP types */
+int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe)
+{
+	static const int pipetypes[4] = {
+		PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
+	};
+	struct usb_host_endpoint *ep;
+
+	ep = usb_pipe_endpoint(dev, pipe);
+	if (!ep || usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+		return -EINVAL;
+	return 0;
+}
+
 /*
  * Wrapper for usb_control_msg().
  * Allocates a temp buffer to prevent dmaing from/to the stack.
@@ -88,6 +102,9 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 	void *buf = NULL;
 	int timeout;
 
+	if (snd_usb_pipe_sanity_check(dev, pipe))
+		return -EINVAL;
+
 	if (size > 0) {
 		buf = kmemdup(data, size, GFP_KERNEL);
 		if (!buf)
diff --git a/sound/usb/helper.h b/sound/usb/helper.h
index f5b4c6647e4d..5e8a18b4e7b9 100644
--- a/sound/usb/helper.h
+++ b/sound/usb/helper.h
@@ -7,6 +7,7 @@ unsigned int snd_usb_combine_bytes(unsigned char *bytes, int size);
 void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype);
 void *snd_usb_find_csint_desc(void *descstart, int desclen, void *after, u8 dsubtype);
 
+int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe);
 int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe,
 		    __u8 request, __u8 requesttype, __u16 value, __u16 index,
 		    void *data, __u16 size);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 43cbaaff163f..087eef5e249d 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -743,11 +743,13 @@ static int snd_usb_novation_boot_quirk(struct usb_device *dev)
 static int snd_usb_accessmusic_boot_quirk(struct usb_device *dev)
 {
 	int err, actual_length;
-
 	/* "midi send" enable */
 	static const u8 seq[] = { 0x4e, 0x73, 0x52, 0x01 };
+	void *buf;
 
-	void *buf = kmemdup(seq, ARRAY_SIZE(seq), GFP_KERNEL);
+	if (snd_usb_pipe_sanity_check(dev, usb_sndintpipe(dev, 0x05)))
+		return -EINVAL;
+	buf = kmemdup(seq, ARRAY_SIZE(seq), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	err = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x05), buf,
@@ -772,7 +774,11 @@ static int snd_usb_accessmusic_boot_quirk(struct usb_device *dev)
 
 static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
 {
-	int ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+	int ret;
+
+	if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
+		return -EINVAL;
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 				  0xaf, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				  1, 0, NULL, 0, 1000);
 
@@ -879,6 +885,8 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "Waiting for Axe-Fx III to boot up...\n");
 
+	if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
+		return -EINVAL;
 	/* If the Axe-Fx III has not fully booted, it will timeout when trying
 	 * to enable the audio streaming interface. A more generous timeout is
 	 * used here to detect when the Axe-Fx III has finished booting as the

