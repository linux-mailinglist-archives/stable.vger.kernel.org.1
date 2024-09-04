Return-Path: <stable+bounces-73031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D64AC96BAFE
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E989C1C20C84
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156EE1D097A;
	Wed,  4 Sep 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LPO960ak"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8871D0152;
	Wed,  4 Sep 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450099; cv=none; b=kBNMhmboglaLvn/nlom2biBhNT8D+QZ12rOyqC5A/NGbIkH39u/ulcuxkANPpCm8HWrXKxffKRwVTeEo4EbiLFVNVfufew+bzTqRJkZsbl5SA3D2DZkGkyo/lZmCM1SVR3hTCMafAuv0giuQ0Cz8poBrf1DNZcC19ed/tuIgCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450099; c=relaxed/simple;
	bh=RyjUkYEbJzbhjK6TkyyixOKVu75nEwqYA7oE4pHox6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYL5KdnANpeU/gf/QpinfENbIXVg+aOuiElGotsafDWwR/AFxQPFzUHLj0LCZoeVWunbw3PndkV8gjU8U8BZRo/i2lz6kNzhmM8uz8NAQKy93uAI3rpKPnB3MnoyogwI9Qvwncb+32lwU4ffXgQ0RqCUFNn4nsgL8Li1c53rse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LPO960ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ECAC4CEC8;
	Wed,  4 Sep 2024 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725450099;
	bh=RyjUkYEbJzbhjK6TkyyixOKVu75nEwqYA7oE4pHox6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPO960akN1PbbU0xn/JAAFWJg/oeHFWL6upjZNTuGcGPbxM1QaaVAjCrnxrMXqohR
	 hAs8hZlj5WEVB1LGawHhUHyaZ28P43ulVKF2y/qA/87i1KLZZD+UL5jLd6B/pTDYNb
	 EHQE5kG0E7Fa8KWwhGRuB/4AdKi0DqrmkNIREyEQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.321
Date: Wed,  4 Sep 2024 13:41:28 +0200
Message-ID: <2024090427-perpetual-washed-0d24@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024090427-frisbee-album-e019@gregkh>
References: <2024090427-frisbee-album-e019@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index eff48a05be02..723ac1456b14 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 320
+SUBLEVEL = 321
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 4f4f1815e047..dfd5238aa3ca 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -28,7 +28,7 @@
 
 #include <asm/numa.h>
 
-static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
+static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
 
 int __init acpi_numa_get_nid(unsigned int cpu)
 {
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index f3a7375ac3cd..f306816c98cb 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -287,6 +287,9 @@ void calibrate_delay(void)
 
 void __init setup_arch(char **cmdline_p)
 {
+	/* setup memblock allocator */
+	setup_memory();
+
 	unflatten_and_copy_device_tree();
 
 	setup_cpuinfo();
@@ -311,9 +314,6 @@ void __init setup_arch(char **cmdline_p)
 	initrd_below_start_ok = 1;
 #endif
 
-	/* setup memblock allocator */
-	setup_memory();
-
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
 
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 11c1505775f8..6b20a0a11913 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -524,7 +524,7 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 
 	old_regs = set_irq_regs(regs);
 	local_irq_disable();
-	irq_enter();
+	irq_enter_rcu();
 
 	eirr_val = mfctl(23) & cpu_eiem & per_cpu(local_ack_eiem, cpu);
 	if (!eirr_val)
@@ -559,7 +559,7 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 #endif /* CONFIG_IRQSTACKS */
 
  out:
-	irq_exit();
+	irq_exit_rcu();
 	set_irq_regs(old_regs);
 	return;
 
diff --git a/arch/powerpc/boot/simple_alloc.c b/arch/powerpc/boot/simple_alloc.c
index 65ec135d0157..bc99f75b8582 100644
--- a/arch/powerpc/boot/simple_alloc.c
+++ b/arch/powerpc/boot/simple_alloc.c
@@ -114,8 +114,11 @@ static void *simple_realloc(void *ptr, unsigned long size)
 		return ptr;
 
 	new = simple_malloc(size);
-	memcpy(new, ptr, p->size);
-	simple_free(ptr);
+	if (new) {
+		memcpy(new, ptr, p->size);
+		simple_free(ptr);
+	}
+
 	return new;
 }
 
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 340de58a15bd..71278d554715 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -240,6 +240,8 @@ static int __init icp_native_map_one_cpu(int hw_id, unsigned long addr,
 	rname = kasprintf(GFP_KERNEL, "CPU %d [0x%x] Interrupt Presentation",
 			  cpu, hw_id);
 
+	if (!rname)
+		return -ENOMEM;
 	if (!request_mem_region(addr, size, rname)) {
 		pr_warn("icp_native: Could not reserve ICP MMIO for CPU %d, interrupt server #0x%x\n",
 			cpu, hw_id);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 00b15aa57c0e..5d931409c21e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6159,6 +6159,9 @@ static void ata_host_release(struct kref *kref)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
+		if (!ap)
+			continue;
+
 		kfree(ap->pmp_link);
 		kfree(ap->slave_link);
 		kfree(ap);
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 36629633ae52..c76792a47135 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -1117,8 +1117,8 @@ dequeue_rx(struct idt77252_dev *card, struct rsq_entry *rsqe)
 	rpp->len += skb->len;
 
 	if (stat & SAR_RSQE_EPDU) {
+		unsigned int len, truesize;
 		unsigned char *l1l2;
-		unsigned int len;
 
 		l1l2 = (unsigned char *) ((unsigned long) skb->data + skb->len - 6);
 
@@ -1188,14 +1188,15 @@ dequeue_rx(struct idt77252_dev *card, struct rsq_entry *rsqe)
 		ATM_SKB(skb)->vcc = vcc;
 		__net_timestamp(skb);
 
+		truesize = skb->truesize;
 		vcc->push(vcc, skb);
 		atomic_inc(&vcc->stats->rx);
 
-		if (skb->truesize > SAR_FB_SIZE_3)
+		if (truesize > SAR_FB_SIZE_3)
 			add_rx_skb(card, 3, SAR_FB_SIZE_3, 1);
-		else if (skb->truesize > SAR_FB_SIZE_2)
+		else if (truesize > SAR_FB_SIZE_2)
 			add_rx_skb(card, 2, SAR_FB_SIZE_2, 1);
-		else if (skb->truesize > SAR_FB_SIZE_1)
+		else if (truesize > SAR_FB_SIZE_1)
 			add_rx_skb(card, 1, SAR_FB_SIZE_1, 1);
 		else
 			add_rx_skb(card, 0, SAR_FB_SIZE_0, 1);
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 48560e646e53..ee57848e20cb 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -773,7 +773,8 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 		break;
 
 	case HCIUARTGETPROTO:
-		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+		if (test_bit(HCI_UART_PROTO_SET, &hu->flags) &&
+		    test_bit(HCI_UART_PROTO_READY, &hu->flags))
 			err = hu->proto->id;
 		else
 			err = -EUNATCH;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index df6965761046..3bd990e11844 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -288,16 +288,24 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 
 	switch (args->in.op) {
 	case AMDGPU_CTX_OP_ALLOC_CTX:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_alloc(adev, fpriv, filp, priority, &id);
 		args->out.alloc.ctx_id = id;
 		break;
 	case AMDGPU_CTX_OP_FREE_CTX:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_free(fpriv, id);
 		break;
 	case AMDGPU_CTX_OP_QUERY_STATE:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_query(adev, fpriv, id, &args->out);
 		break;
 	case AMDGPU_CTX_OP_QUERY_STATE2:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_query2(adev, fpriv, id, &args->out);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 17862b9ecccd..9c8ce75c760a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -714,7 +714,8 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 	uint32_t created = 0;
 	uint32_t allocated = 0;
 	uint32_t tmp, handle = 0;
-	uint32_t *size = &tmp;
+	uint32_t dummy = 0xffffffff;
+	uint32_t *size = &dummy;
 	unsigned idx;
 	int i, r = 0;
 
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index ee6801fa36ad..f8c8513de271 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1713,6 +1713,9 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
+	var->xres_virtual = fb->width;
+	var->yres_virtual = fb->height;
+
 	/*
 	 * Workaround for SDL 1.2, which is known to be setting all pixel format
 	 * fields values to zero in some cases. We treat this situation as a
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 56ae888e18fc..2023cb0d21a8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -41,24 +41,14 @@
  * @fmt: Pointer to format string
  */
 #define DPU_DEBUG(fmt, ...)                                                \
-	do {                                                               \
-		if (unlikely(drm_debug & DRM_UT_KMS))                      \
-			DRM_DEBUG(fmt, ##__VA_ARGS__); \
-		else                                                       \
-			pr_debug(fmt, ##__VA_ARGS__);                      \
-	} while (0)
+	DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
 
 /**
  * DPU_DEBUG_DRIVER - macro for hardware driver logging
  * @fmt: Pointer to format string
  */
 #define DPU_DEBUG_DRIVER(fmt, ...)                                         \
-	do {                                                               \
-		if (unlikely(drm_debug & DRM_UT_DRIVER))                   \
-			DRM_ERROR(fmt, ##__VA_ARGS__); \
-		else                                                       \
-			pr_debug(fmt, ##__VA_ARGS__);                      \
-	} while (0)
+	DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
 
 #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
 #define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error]" fmt, ##__VA_ARGS__)
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 46dd5a93a375..fe4051024db3 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1830,12 +1830,14 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int resolution_code = code;
-	int resolution = hidinput_calc_abs_res(field, resolution_code);
+	int resolution;
 
 	if (equivalent_usage == HID_DG_TWIST) {
 		resolution_code = ABS_RZ;
 	}
 
+	resolution = hidinput_calc_abs_res(field, resolution_code);
+
 	if (equivalent_usage == HID_GD_X) {
 		fmin += features->offset_left;
 		fmax -= features->offset_right;
diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index e6f351c92c02..82ffa8eecec8 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -315,7 +315,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	 * frequency with only 62 clock ticks max (31 high, 31 low).
 	 * Aim for a duty of 60% LOW, 40% HIGH.
 	 */
-	total_ticks = DIV_ROUND_UP(rate, t->bus_freq_hz);
+	total_ticks = DIV_ROUND_UP(rate, t->bus_freq_hz ?: 1);
 
 	for (cks = 0; cks < 7; cks++) {
 		/*
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 6c7326c93721..fd01c9306e66 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -48,6 +48,9 @@ int input_mt_init_slots(struct input_dev *dev, unsigned int num_slots,
 		return 0;
 	if (mt)
 		return mt->num_slots != num_slots ? -EINVAL : 0;
+	/* Arbitrary limit for avoiding too large memory allocation. */
+	if (num_slots > 1024)
+		return -EINVAL;
 
 	mt = kzalloc(struct_size(mt, slots, num_slots), GFP_KERNEL);
 	if (!mt)
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6b58194c1e34..2e0478e8be74 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2958,8 +2958,6 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	struct page *vprop_page;
 	int base, nr_ids, i, err = 0;
 
-	BUG_ON(!vm);
-
 	bitmap = its_lpi_alloc(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
 	if (!bitmap)
 		return -ENOMEM;
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 70929ff79eec..4c375cf9ef17 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1039,8 +1039,26 @@ static int do_resume(struct dm_ioctl *param)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
-		if (!dm_suspended_md(md))
-			dm_suspend(md, suspend_flags);
+		if (!dm_suspended_md(md)) {
+			r = dm_suspend(md, suspend_flags);
+			if (r) {
+				down_write(&_hash_lock);
+				hc = dm_get_mdptr(md);
+				if (hc && !hc->new_map) {
+					hc->new_map = new_map;
+					new_map = NULL;
+				} else {
+					r = -ENXIO;
+				}
+				up_write(&_hash_lock);
+				if (new_map) {
+					dm_sync_table(md);
+					dm_table_destroy(new_map);
+				}
+				dm_put(md);
+				return r;
+			}
+		}
 
 		old_map = dm_swap_table(md, new_map);
 		if (IS_ERR(old_map)) {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 50dcda27144e..67d2c802f698 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2468,7 +2468,7 @@ static int dm_wait_for_completion(struct mapped_device *md, long task_state)
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 68eb3220be1c..6f463eec60b4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7245,11 +7245,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 
 	mddev = bdev->bd_disk->private_data;
 
-	if (!mddev) {
-		BUG();
-		goto out;
-	}
-
 	/* Some actions do not requires the mutex */
 	switch (cmd) {
 	case GET_ARRAY_INFO:
diff --git a/drivers/md/persistent-data/dm-space-map-metadata.c b/drivers/md/persistent-data/dm-space-map-metadata.c
index da439ac85796..25ce7fb7fd9d 100644
--- a/drivers/md/persistent-data/dm-space-map-metadata.c
+++ b/drivers/md/persistent-data/dm-space-map-metadata.c
@@ -275,7 +275,7 @@ static void sm_metadata_destroy(struct dm_space_map *sm)
 {
 	struct sm_metadata *smm = container_of(sm, struct sm_metadata, sm);
 
-	kfree(smm);
+	kvfree(smm);
 }
 
 static int sm_metadata_get_nr_blocks(struct dm_space_map *sm, dm_block_t *count)
@@ -759,7 +759,7 @@ struct dm_space_map *dm_sm_metadata_init(void)
 {
 	struct sm_metadata *smm;
 
-	smm = kmalloc(sizeof(*smm), GFP_KERNEL);
+	smm = kvmalloc(sizeof(*smm), GFP_KERNEL);
 	if (!smm)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index 16564899f114..435a3c1c7e65 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -1297,6 +1297,10 @@ int cx23885_video_register(struct cx23885_dev *dev)
 	/* register Video device */
 	dev->video_dev = cx23885_vdev_init(dev, dev->pci,
 		&cx23885_video_template, "video");
+	if (!dev->video_dev) {
+		err = -ENOMEM;
+		goto fail_unreg;
+	}
 	dev->video_dev->queue = &dev->vb2_vidq;
 	err = video_register_device(dev->video_dev, VFL_TYPE_GRABBER,
 				    video_nr[dev->nr]);
@@ -1311,6 +1315,10 @@ int cx23885_video_register(struct cx23885_dev *dev)
 	/* register VBI device */
 	dev->vbi_dev = cx23885_vdev_init(dev, dev->pci,
 		&cx23885_vbi_template, "vbi");
+	if (!dev->vbi_dev) {
+		err = -ENOMEM;
+		goto fail_unreg;
+	}
 	dev->vbi_dev->queue = &dev->vb2_vbiq;
 	err = video_register_device(dev->vbi_dev, VFL_TYPE_VBI,
 				    vbi_nr[dev->nr]);
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 3f0796141545..ac47d05fb8f5 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -728,11 +728,11 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	unsigned long flags;
 	u64 timestamp;
 	u32 delta_stc;
-	u32 y1, y2;
+	u32 y1;
 	u32 x1, x2;
 	u32 mean;
 	u32 sof;
-	u64 y;
+	u64 y, y2;
 
 	if (!uvc_hw_timestamps_param)
 		return;
@@ -772,7 +772,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	sof = y;
 
 	uvc_trace(UVC_TRACE_CLOCK, "%s: PTS %u y %llu.%06llu SOF %u.%06llu "
-		  "(x1 %u x2 %u y1 %u y2 %u SOF offset %u)\n",
+		  "(x1 %u x2 %u y1 %u y2 %llu SOF offset %u)\n",
 		  stream->dev->name, buf->pts,
 		  y >> 16, div_u64((y & 0xffff) * 1000000, 65536),
 		  sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
@@ -787,7 +787,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 		goto done;
 
 	y1 = NSEC_PER_SEC;
-	y2 = (u32)ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
+	y2 = ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
 
 	/* Interpolated and host SOF timestamps can wrap around at slightly
 	 * different times. Handle this by adding or removing 2048 to or from
@@ -807,7 +807,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	timestamp = ktime_to_ns(first->host_time) + y - y1;
 
 	uvc_trace(UVC_TRACE_CLOCK, "%s: SOF %u.%06llu y %llu ts %llu "
-		  "buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %u)\n",
+		  "buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %llu)\n",
 		  stream->dev->name,
 		  sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
 		  y, timestamp, vbuf->vb2_buf.timestamp,
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index ef18daeaa4cc..164b4e43050e 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3101,13 +3101,13 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 	test->buffer = kzalloc(BUFFER_SIZE, GFP_KERNEL);
 #ifdef CONFIG_HIGHMEM
 	test->highmem = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, BUFFER_ORDER);
+	if (!test->highmem) {
+		count = -ENOMEM;
+		goto free_test_buffer;
+	}
 #endif
 
-#ifdef CONFIG_HIGHMEM
-	if (test->buffer && test->highmem) {
-#else
 	if (test->buffer) {
-#endif
 		mutex_lock(&mmc_test_lock);
 		mmc_test_run(test, testcase);
 		mutex_unlock(&mmc_test_lock);
@@ -3115,6 +3115,7 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 
 #ifdef CONFIG_HIGHMEM
 	__free_pages(test->highmem, BUFFER_ORDER);
+free_test_buffer:
 #endif
 	kfree(test->buffer);
 	kfree(test);
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 8570068c2be4..75355abe03c9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3205,6 +3205,10 @@ int dw_mci_probe(struct dw_mci *host)
 	host->biu_clk = devm_clk_get(host->dev, "biu");
 	if (IS_ERR(host->biu_clk)) {
 		dev_dbg(host->dev, "biu clock not available\n");
+		ret = PTR_ERR(host->biu_clk);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
 	} else {
 		ret = clk_prepare_enable(host->biu_clk);
 		if (ret) {
@@ -3216,6 +3220,10 @@ int dw_mci_probe(struct dw_mci *host)
 	host->ciu_clk = devm_clk_get(host->dev, "ciu");
 	if (IS_ERR(host->ciu_clk)) {
 		dev_dbg(host->dev, "ciu clock not available\n");
+		ret = PTR_ERR(host->ciu_clk);
+		if (ret == -EPROBE_DEFER)
+			goto err_clk_biu;
+
 		host->bus_hz = host->pdata->bus_hz;
 	} else {
 		ret = clk_prepare_enable(host->ciu_clk);
diff --git a/drivers/net/dsa/vitesse-vsc73xx.c b/drivers/net/dsa/vitesse-vsc73xx.c
index 34fefa015fd7..eaafb1c30c91 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.c
+++ b/drivers/net/dsa/vitesse-vsc73xx.c
@@ -649,7 +649,7 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 		return 0;
 	}
 
-	cmd = (phy << 21) | (regnum << 16);
+	cmd = (phy << 21) | (regnum << 16) | val;
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
 		return ret;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 9160b44c68bb..8a845f316a45 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -940,7 +940,8 @@ static u64 hash_filter_ntuple(struct ch_filter_specification *fs,
 	 * in the Compressed Filter Tuple.
 	 */
 	if (tp->vlan_shift >= 0 && fs->mask.ivlan)
-		ntuple |= (FT_VLAN_VLD_F | fs->val.ivlan) << tp->vlan_shift;
+		ntuple |= (u64)(FT_VLAN_VLD_F |
+				fs->val.ivlan) << tp->vlan_shift;
 
 	if (tp->port_shift >= 0 && fs->mask.iport)
 		ntuple |= (u64)fs->val.iport << tp->port_shift;
diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 1a86184d44c0..e0c9fee4e1e6 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -990,7 +990,7 @@ static void sun3_82586_timeout(struct net_device *dev)
 	{
 #ifdef DEBUG
 		printk("%s: xmitter timed out, try to restart! stat: %02x\n",dev->name,p->scb->cus);
-		printk("%s: command-stats: %04x %04x\n",dev->name,swab16(p->xmit_cmds[0]->cmd_status),swab16(p->xmit_cmds[1]->cmd_status));
+		printk("%s: command-stats: %04x\n", dev->name, swab16(p->xmit_cmds[0]->cmd_status));
 		printk("%s: check, whether you set the right interrupt number!\n",dev->name);
 #endif
 		sun3_82586_close(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index 41cde926cdab..48ae9c201af4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -689,7 +689,7 @@ mlx5e_ethtool_flow_replace(struct mlx5e_priv *priv,
 	if (num_tuples <= 0) {
 		netdev_warn(priv->netdev, "%s: flow is not valid %d\n",
 			    __func__, num_tuples);
-		return num_tuples;
+		return num_tuples < 0 ? num_tuples : -EINVAL;
 	}
 
 	eth_ft = get_flow_table(priv, fs, num_tuples);
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 299162a74939..71593b1a90e8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -375,6 +375,10 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
 
+		reg = axienet_ior(lp, XAE_FMI_OFFSET);
+		reg &= ~XAE_FMI_PM_MASK;
+		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+
 		i = 0;
 		netdev_for_each_mc_addr(ha, ndev) {
 			if (i >= XAE_MULTICAST_CAM_TABLE_NUM)
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index db97f2fa203c..733cafb0888f 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -577,6 +577,9 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_cow_head(skb, dev->needed_headroom))
 		goto tx_err;
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	skb_reset_inner_headers(skb);
 
 	/* PDP context lookups in gtp_build_skb_*() need rcu read-side lock. */
@@ -809,7 +812,7 @@ static struct sock *gtp_encap_enable_socket(int fd, int type,
 	sock = sockfd_lookup(fd, &err);
 	if (!sock) {
 		pr_debug("gtp socket fd=%d not found\n", fd);
-		return NULL;
+		return ERR_PTR(err);
 	}
 
 	sk = sock->sk;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 16b614cc16ab..eb2d235e9dc5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1993,7 +1993,7 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 	if (!(mvm->scan_status & type))
 		return 0;
 
-	if (iwl_mvm_is_radio_killed(mvm)) {
+	if (!test_bit(STATUS_DEVICE_ENABLED, &mvm->trans->status)) {
 		ret = 0;
 		goto out;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 52e186f945b0..0dbc0a14931f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4294,11 +4294,27 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
 		wiphy->interface_modes |= BIT(NL80211_IFTYPE_ADHOC);
 
-	wiphy->bands[NL80211_BAND_2GHZ] = &mwifiex_band_2ghz;
-	if (adapter->config_bands & BAND_A)
-		wiphy->bands[NL80211_BAND_5GHZ] = &mwifiex_band_5ghz;
-	else
+	wiphy->bands[NL80211_BAND_2GHZ] = devm_kmemdup(adapter->dev,
+						       &mwifiex_band_2ghz,
+						       sizeof(mwifiex_band_2ghz),
+						       GFP_KERNEL);
+	if (!wiphy->bands[NL80211_BAND_2GHZ]) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	if (adapter->config_bands & BAND_A) {
+		wiphy->bands[NL80211_BAND_5GHZ] = devm_kmemdup(adapter->dev,
+							       &mwifiex_band_5ghz,
+							       sizeof(mwifiex_band_5ghz),
+							       GFP_KERNEL);
+		if (!wiphy->bands[NL80211_BAND_5GHZ]) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	} else {
 		wiphy->bands[NL80211_BAND_5GHZ] = NULL;
+	}
 
 	if (adapter->drcs_enabled && ISSUPP_DRCS_ENABLED(adapter->fw_cap_info))
 		wiphy->iface_combinations = &mwifiex_iface_comb_ap_sta_drcs;
@@ -4386,8 +4402,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	if (ret < 0) {
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: wiphy_register failed: %d\n", __func__, ret);
-		wiphy_free(wiphy);
-		return ret;
+		goto err;
 	}
 
 	if (!adapter->regd) {
@@ -4429,4 +4444,9 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 
 	adapter->wiphy = wiphy;
 	return ret;
+
+err:
+	wiphy_free(wiphy);
+
+	return ret;
 }
diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index f7b1b0062db3..3ccb3a134599 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -1173,7 +1173,7 @@ void cw1200_rx_cb(struct cw1200_common *priv,
 		size_t ies_len = skb->len - (ies - (u8 *)(skb->data));
 
 		tim_ie = cfg80211_find_ie(WLAN_EID_TIM, ies, ies_len);
-		if (tim_ie) {
+		if (tim_ie && tim_ie[1] >= sizeof(struct ieee80211_tim_ie)) {
 			struct ieee80211_tim_ie *tim =
 				(struct ieee80211_tim_ie *)&tim_ie[2];
 
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index cfd26437aeae..7889a55156f4 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -435,12 +435,8 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
 	return 0;
 
 out_free:
-	while (--i >= 0) {
-		struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
-
-		list_del(&rsp->free_list);
-		nvmet_rdma_free_rsp(ndev, rsp);
-	}
+	while (--i >= 0)
+		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
 	kfree(queue->rsps);
 out:
 	return ret;
@@ -451,12 +447,8 @@ static void nvmet_rdma_free_rsps(struct nvmet_rdma_queue *queue)
 	struct nvmet_rdma_device *ndev = queue->dev;
 	int i, nr_rsps = queue->recv_queue_size * 2;
 
-	for (i = 0; i < nr_rsps; i++) {
-		struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
-
-		list_del(&rsp->free_list);
-		nvmet_rdma_free_rsp(ndev, rsp);
-	}
+	for (i = 0; i < nr_rsps; i++)
+		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
 	kfree(queue->rsps);
 }
 
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 3699843e9a6e..86691841efc0 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -323,6 +323,8 @@ static int pcs_get_function(struct pinctrl_dev *pctldev, unsigned pin,
 		return -ENOTSUPP;
 	fselector = setting->func;
 	function = pinmux_generic_get_function(pctldev, fselector);
+	if (!function)
+		return -EINVAL;
 	*func = function->data;
 	if (!(*func)) {
 		dev_err(pcs->dev, "%s could not find function%i\n",
diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index 835de44dbbcc..b98526d3ddfd 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -16,20 +16,21 @@ struct idset {
 	unsigned long bitmap[0];
 };
 
-static inline unsigned long bitmap_size(int num_ssid, int num_id)
+static inline unsigned long idset_bitmap_size(int num_ssid, int num_id)
 {
-	return BITS_TO_LONGS(num_ssid * num_id) * sizeof(unsigned long);
+	return bitmap_size(size_mul(num_ssid, num_id));
 }
 
 static struct idset *idset_new(int num_ssid, int num_id)
 {
 	struct idset *set;
 
-	set = vmalloc(sizeof(struct idset) + bitmap_size(num_ssid, num_id));
+	set = vmalloc(sizeof(struct idset) +
+		      idset_bitmap_size(num_ssid, num_id));
 	if (set) {
 		set->num_ssid = num_ssid;
 		set->num_id = num_id;
-		memset(set->bitmap, 0, bitmap_size(num_ssid, num_id));
+		memset(set->bitmap, 0, idset_bitmap_size(num_ssid, num_id));
 	}
 	return set;
 }
@@ -41,7 +42,8 @@ void idset_free(struct idset *set)
 
 void idset_fill(struct idset *set)
 {
-	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
+	memset(set->bitmap, 0xff,
+	       idset_bitmap_size(set->num_ssid, set->num_id));
 }
 
 static inline void idset_add(struct idset *set, int ssid, int id)
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 0dc7b5a4fea2..0378fd3eb039 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -652,6 +652,7 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
 
 	if (aac_comm_init(dev)<0){
 		kfree(dev->queues);
+		dev->queues = NULL;
 		return NULL;
 	}
 	/*
@@ -659,6 +660,7 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
 	 */
 	if (aac_fib_setup(dev) < 0) {
 		kfree(dev->queues);
+		dev->queues = NULL;
 		return NULL;
 	}
 		
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index e72fc88aeb40..9da9d5ee0b8e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -6597,7 +6597,7 @@ lpfc_sli4_repost_sgl_list(struct lpfc_hba *phba,
 	struct lpfc_sglq *sglq_entry = NULL;
 	struct lpfc_sglq *sglq_entry_next = NULL;
 	struct lpfc_sglq *sglq_entry_first = NULL;
-	int status, total_cnt;
+	int status = 0, total_cnt;
 	int post_cnt = 0, num_posted = 0, block_cnt = 0;
 	int last_xritag = NO_XRI;
 	LIST_HEAD(prep_sgl_list);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index b4495023edb7..cbe10d9a8ae1 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2221,6 +2221,22 @@ _base_build_zero_len_sge_ieee(struct MPT3SAS_ADAPTER *ioc, void *paddr)
 	_base_add_sg_single_ieee(paddr, sgl_flags, 0, 0, -1);
 }
 
+static inline int _base_scsi_dma_map(struct scsi_cmnd *cmd)
+{
+	/*
+	 * Some firmware versions byte-swap the REPORT ZONES command reply from
+	 * ATA-ZAC devices by directly accessing in the host buffer. This does
+	 * not respect the default command DMA direction and causes IOMMU page
+	 * faults on some architectures with an IOMMU enforcing write mappings
+	 * (e.g. AMD hosts). Avoid such issue by making the report zones buffer
+	 * mapping bi-directional.
+	 */
+	if (cmd->cmnd[0] == ZBC_IN && cmd->cmnd[1] == ZI_REPORT_ZONES)
+		cmd->sc_data_direction = DMA_BIDIRECTIONAL;
+
+	return scsi_dma_map(cmd);
+}
+
 /**
  * _base_build_sg_scmd - main sg creation routine
  *		pcie_device is unused here!
@@ -2267,7 +2283,7 @@ _base_build_sg_scmd(struct MPT3SAS_ADAPTER *ioc,
 	sgl_flags = sgl_flags << MPI2_SGE_FLAGS_SHIFT;
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0) {
 		sdev_printk(KERN_ERR, scmd->device,
 		 "pci_map_sg failed: request for %d bytes!\n",
@@ -2415,7 +2431,7 @@ _base_build_sg_scmd_ieee(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0) {
 		sdev_printk(KERN_ERR, scmd->device,
 			"pci_map_sg failed: request for %d bytes!\n",
diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index efb9c3d90213..adbe9b07f3d0 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -690,10 +690,10 @@ spi_dv_device_echo_buffer(struct scsi_device *sdev, u8 *buffer,
 	for (r = 0; r < retries; r++) {
 		result = spi_execute(sdev, spi_write_buffer, DMA_TO_DEVICE,
 				     buffer, len, &sshdr);
-		if(result || !scsi_device_online(sdev)) {
+		if (result || !scsi_device_online(sdev)) {
 
 			scsi_device_set_state(sdev, SDEV_QUIESCE);
-			if (scsi_sense_valid(&sshdr)
+			if (result > 0 && scsi_sense_valid(&sshdr)
 			    && sshdr.sense_key == ILLEGAL_REQUEST
 			    /* INVALID FIELD IN CDB */
 			    && sshdr.asc == 0x24 && sshdr.ascq == 0x00)
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 42bc701e2304..7c08385acab1 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1232,18 +1232,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 				unsigned int port_num)
 {
 	struct sdw_dpn_prop *dpn_prop;
-	u8 num_ports;
+	unsigned long mask;
 	int i;
 
 	if (direction == SDW_DATA_DIR_TX) {
-		num_ports = hweight32(slave->prop.source_ports);
+		mask = slave->prop.source_ports;
 		dpn_prop = slave->prop.src_dpn_prop;
 	} else {
-		num_ports = hweight32(slave->prop.sink_ports);
+		mask = slave->prop.sink_ports;
 		dpn_prop = slave->prop.sink_dpn_prop;
 	}
 
-	for (i = 0; i < num_ports; i++) {
+	for_each_set_bit(i, &mask, 32) {
 		if (dpn_prop[i].num == port_num)
 			return &dpn_prop[i];
 	}
diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 0a26984acb2c..9e54bc7eec66 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -835,7 +835,7 @@ static u32 clkfactor_f6_resolve(u32 v)
 	case SSB_CHIPCO_CLK_F6_7:
 		return 7;
 	}
-	return 0;
+	return 1;
 }
 
 /* Calculate the speed the backplane would run at a given set of clockcontrol values */
diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 79d0513bd282..85c4e27f571b 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -395,9 +395,9 @@ int ks_wlan_hw_tx(struct ks_wlan_private *priv, void *p, unsigned long size,
 	priv->hostt.buff[priv->hostt.qtail] = le16_to_cpu(hdr->event);
 	priv->hostt.qtail = (priv->hostt.qtail + 1) % SME_EVENT_BUFF_SIZE;
 
-	spin_lock(&priv->tx_dev.tx_dev_lock);
+	spin_lock_bh(&priv->tx_dev.tx_dev_lock);
 	result = enqueue_txdev(priv, p, size, complete_handler, skb);
-	spin_unlock(&priv->tx_dev.tx_dev_lock);
+	spin_unlock_bh(&priv->tx_dev.tx_dev_lock);
 
 	if (txq_has_space(priv))
 		queue_delayed_work(priv->wq, &priv->rw_dwork, 0);
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index e927631c79c6..544d4647d918 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1807,6 +1807,9 @@ static const struct usb_device_id acm_ids[] = {
 	{ USB_DEVICE(0x11ca, 0x0201), /* VeriFone Mx870 Gadget Serial */
 	.driver_info = SINGLE_RX_URB,
 	},
+	{ USB_DEVICE(0x1901, 0x0006), /* GE Healthcare Patient Monitor UI Controller */
+	.driver_info = DISABLE_ECHO, /* DISABLE ECHO in termios flag */
+	},
 	{ USB_DEVICE(0x1965, 0x0018), /* Uniden UBC125XLT */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 314f2d996c56..01fa04d470fd 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -689,6 +689,7 @@ static int add_power_attributes(struct device *dev)
 
 static void remove_power_attributes(struct device *dev)
 {
+	sysfs_unmerge_group(&dev->kobj, &usb3_hardware_lpm_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &usb2_hardware_lpm_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &power_attr_group);
 }
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index fd82904e1465..4002c6790be6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -372,6 +372,13 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
 static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
 {
 	struct dwc3_event_buffer *evt;
+	unsigned int hw_mode;
+
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		dwc->ev_buf = NULL;
+		return 0;
+	}
 
 	evt = dwc3_alloc_one_event_buffer(dwc, length);
 	if (IS_ERR(evt)) {
@@ -393,6 +400,9 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
+	if (!dwc->ev_buf)
+		return 0;
+
 	evt = dwc->ev_buf;
 	evt->lpos = 0;
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
@@ -409,6 +419,17 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
+
+	if (!dwc->ev_buf)
+		return;
+	/*
+	 * Exynos platforms may not be able to access event buffer if the
+	 * controller failed to halt on dwc3_core_exit().
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	if (!(reg & DWC3_DSTS_DEVCTRLHLT))
+		return;
 
 	evt = dwc->ev_buf;
 
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 0b800bc6150d..340868fabaff 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -526,11 +526,13 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n",
 			omap->irq, ret);
-		goto err1;
+		goto err2;
 	}
 	dwc3_omap_enable_irqs(omap);
 	return 0;
 
+err2:
+	of_platform_depopulate(dev);
 err1:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 16081383c401..6127505770ce 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -219,10 +219,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	dwc3_data->regmap = regmap;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "syscfg-reg");
-	if (!res) {
-		ret = -ENXIO;
-		goto undo_platform_dev_alloc;
-	}
+	if (!res)
+		return -ENXIO;
 
 	dwc3_data->syscfg_reg_off = res->start;
 
@@ -233,8 +231,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 		devm_reset_control_get_exclusive(dev, "powerdown");
 	if (IS_ERR(dwc3_data->rstc_pwrdn)) {
 		dev_err(&pdev->dev, "could not get power controller\n");
-		ret = PTR_ERR(dwc3_data->rstc_pwrdn);
-		goto undo_platform_dev_alloc;
+		return PTR_ERR(dwc3_data->rstc_pwrdn);
 	}
 
 	/* Manage PowerDown */
@@ -296,8 +293,6 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	reset_control_assert(dwc3_data->rstc_rst);
 undo_powerdown:
 	reset_control_assert(dwc3_data->rstc_pwrdn);
-undo_platform_dev_alloc:
-	platform_device_put(pdev);
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 367697144cda..b86f86902f55 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2501,7 +2501,7 @@ static int fsl_udc_probe(struct platform_device *pdev)
 	/* setup the udc->eps[] for non-control endpoints and link
 	 * to gadget.ep_list */
 	for (i = 1; i < (int)(udc_controller->max_ep / 2); i++) {
-		char name[14];
+		char name[16];
 
 		sprintf(name, "ep%dout", i);
 		struct_ep_setup(udc_controller, i * 2, name, 1);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 13c10ebde296..a4afd9922577 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2790,7 +2790,7 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
 				xhci->num_active_eps);
 		return -ENOMEM;
 	}
-	if ((xhci->quirks & XHCI_SW_BW_CHECKING) &&
+	if ((xhci->quirks & XHCI_SW_BW_CHECKING) && !ctx_change &&
 	    xhci_reserve_bandwidth(xhci, virt_dev, command->in_ctx)) {
 		if ((xhci->quirks & XHCI_EP_LIMIT_QUIRK))
 			xhci_free_host_resources(xhci, ctrl_ctx);
@@ -4145,8 +4145,10 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 		mutex_unlock(&xhci->mutex);
 		ret = xhci_disable_slot(xhci, udev->slot_id);
 		xhci_free_virt_device(xhci, udev->slot_id);
-		if (!ret)
-			xhci_alloc_dev(hcd, udev);
+		if (!ret) {
+			if (xhci_alloc_dev(hcd, udev) == 1)
+				xhci_setup_addressable_virt_dev(xhci, udev);
+		}
 		kfree(command->completion);
 		kfree(command);
 		return -EPROTO;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 1263c82259ec..0a284bf9f0dc 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -619,6 +619,8 @@ static void option_instat_callback(struct urb *urb);
 
 /* MeiG Smart Technology products */
 #define MEIGSMART_VENDOR_ID			0x2dee
+/* MeiG Smart SRM825L based on Qualcomm 315 */
+#define MEIGSMART_PRODUCT_SRM825L		0x4d22
 /* MeiG Smart SLM320 based on UNISOC UIS8910 */
 #define MEIGSMART_PRODUCT_SLM320		0x4d41
 
@@ -2366,6 +2368,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index dea5275254ef..402020776a3c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2734,6 +2734,34 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 		fbcon_modechanged(info);
 }
 
+/* let fbcon check if it supports a new screen resolution */
+int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *var)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+	struct vc_data *vc;
+	unsigned int i;
+
+	WARN_CONSOLE_UNLOCKED();
+
+	if (!ops)
+		return 0;
+
+	/* prevent setting a screen size which is smaller than font size */
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
+		vc = vc_cons[i].d;
+		if (!vc || vc->vc_mode != KD_TEXT ||
+			   registered_fb[con2fb_map[i]] != info)
+			continue;
+
+		if (vc->vc_font.width  > FBCON_SWAP(var->rotate, var->xres, var->yres) ||
+		    vc->vc_font.height > FBCON_SWAP(var->rotate, var->yres, var->xres))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fbcon_modechange_possible);
+
 static int fbcon_mode_deleted(struct fb_info *info,
 			      struct fb_videomode *mode)
 {
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 2297dfb494d6..114a8c534406 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1006,6 +1006,17 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 		if (ret)
 			goto done;
 
+		/* verify that virtual resolution >= physical resolution */
+		if (var->xres_virtual < var->xres ||
+		    var->yres_virtual < var->yres) {
+			pr_warn("WARNING: fbcon: Driver '%s' missed to adjust virtual screen size (%ux%u vs. %ux%u)\n",
+				info->fix.id,
+				var->xres_virtual, var->yres_virtual,
+				var->xres, var->yres);
+			ret = -EINVAL;
+			goto done;
+		}
+
 		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
 			struct fb_var_screeninfo old_var;
 			struct fb_videomode mode;
@@ -1121,9 +1132,12 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			console_unlock();
 			return -ENODEV;
 		}
-		info->flags |= FBINFO_MISC_USEREVENT;
-		ret = fb_set_var(info, &var);
-		info->flags &= ~FBINFO_MISC_USEREVENT;
+		ret = fbcon_modechange_possible(info, &var);
+		if (!ret) {
+			info->flags |= FBINFO_MISC_USEREVENT;
+			ret = fb_set_var(info, &var);
+			info->flags &= ~FBINFO_MISC_USEREVENT;
+		}
 		unlock_fb_info(info);
 		console_unlock();
 		if (!ret && copy_to_user(argp, &var, sizeof(var)))
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a7c2efcd0a4a..0dbbb3a21e6c 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -324,7 +324,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	else
 		executable_stack = EXSTACK_DEFAULT;
 
-	if (stack_size == 0) {
+	if (stack_size == 0 && interp_params.flags & ELF_FDPIC_FLAG_PRESENT) {
 		stack_size = interp_params.stack_size;
 		if (interp_params.flags & ELF_FDPIC_FLAG_EXEC_STACK)
 			executable_stack = EXSTACK_ENABLE_X;
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 8fe7edd2b001..2df8d2bd1153 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -58,12 +58,11 @@ typedef struct {
 	char *name;
 	struct dentry *dentry;
 	struct file *interp_file;
+	refcount_t users;		/* sync removal with load_misc_binary() */
 } Node;
 
 static DEFINE_RWLOCK(entries_lock);
 static struct file_system_type bm_fs_type;
-static struct vfsmount *bm_mnt;
-static int entry_count;
 
 /*
  * Max length of the register string.  Determined by:
@@ -80,19 +79,23 @@ static int entry_count;
  */
 #define MAX_REGISTER_LENGTH 1920
 
-/*
- * Check if we support the binfmt
- * if we do, return the node, else NULL
- * locking is done in load_misc_binary
+/**
+ * search_binfmt_handler - search for a binary handler for @bprm
+ * @misc: handle to binfmt_misc instance
+ * @bprm: binary for which we are looking for a handler
+ *
+ * Search for a binary type handler for @bprm in the list of registered binary
+ * type handlers.
+ *
+ * Return: binary type list entry on success, NULL on failure
  */
-static Node *check_file(struct linux_binprm *bprm)
+static Node *search_binfmt_handler(struct linux_binprm *bprm)
 {
 	char *p = strrchr(bprm->interp, '.');
-	struct list_head *l;
+	Node *e;
 
 	/* Walk all the registered handlers. */
-	list_for_each(l, &entries) {
-		Node *e = list_entry(l, Node, list);
+	list_for_each_entry(e, &entries, list) {
 		char *s;
 		int j;
 
@@ -121,9 +124,49 @@ static Node *check_file(struct linux_binprm *bprm)
 		if (j == e->size)
 			return e;
 	}
+
 	return NULL;
 }
 
+/**
+ * get_binfmt_handler - try to find a binary type handler
+ * @misc: handle to binfmt_misc instance
+ * @bprm: binary for which we are looking for a handler
+ *
+ * Try to find a binfmt handler for the binary type. If one is found take a
+ * reference to protect against removal via bm_{entry,status}_write().
+ *
+ * Return: binary type list entry on success, NULL on failure
+ */
+static Node *get_binfmt_handler(struct linux_binprm *bprm)
+{
+	Node *e;
+
+	read_lock(&entries_lock);
+	e = search_binfmt_handler(bprm);
+	if (e)
+		refcount_inc(&e->users);
+	read_unlock(&entries_lock);
+	return e;
+}
+
+/**
+ * put_binfmt_handler - put binary handler node
+ * @e: node to put
+ *
+ * Free node syncing with load_misc_binary() and defer final free to
+ * load_misc_binary() in case it is using the binary type handler we were
+ * requested to remove.
+ */
+static void put_binfmt_handler(Node *e)
+{
+	if (refcount_dec_and_test(&e->users)) {
+		if (e->flags & MISC_FMT_OPEN_FILE)
+			filp_close(e->interp_file, NULL);
+		kfree(e);
+	}
+}
+
 /*
  * the loader itself
  */
@@ -138,12 +181,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (!enabled)
 		return retval;
 
-	/* to keep locking time low, we copy the interpreter string */
-	read_lock(&entries_lock);
-	fmt = check_file(bprm);
-	if (fmt)
-		dget(fmt->dentry);
-	read_unlock(&entries_lock);
+	fmt = get_binfmt_handler(bprm);
 	if (!fmt)
 		return retval;
 
@@ -237,7 +275,16 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		goto error;
 
 ret:
-	dput(fmt->dentry);
+
+	/*
+	 * If we actually put the node here all concurrent calls to
+	 * load_misc_binary() will have finished. We also know
+	 * that for the refcount to be zero ->evict_inode() must have removed
+	 * the node to be deleted from the list. All that is left for us is to
+	 * close and free.
+	 */
+	put_binfmt_handler(fmt);
+
 	return retval;
 error:
 	if (fd_binary > 0)
@@ -598,30 +645,90 @@ static struct inode *bm_get_inode(struct super_block *sb, int mode)
 	return inode;
 }
 
+/**
+ * bm_evict_inode - cleanup data associated with @inode
+ * @inode: inode to which the data is attached
+ *
+ * Cleanup the binary type handler data associated with @inode if a binary type
+ * entry is removed or the filesystem is unmounted and the super block is
+ * shutdown.
+ *
+ * If the ->evict call was not caused by a super block shutdown but by a write
+ * to remove the entry or all entries via bm_{entry,status}_write() the entry
+ * will have already been removed from the list. We keep the list_empty() check
+ * to make that explicit.
+*/
 static void bm_evict_inode(struct inode *inode)
 {
 	Node *e = inode->i_private;
 
-	if (e && e->flags & MISC_FMT_OPEN_FILE)
-		filp_close(e->interp_file, NULL);
-
 	clear_inode(inode);
-	kfree(e);
+
+	if (e) {
+		write_lock(&entries_lock);
+		if (!list_empty(&e->list))
+			list_del_init(&e->list);
+		write_unlock(&entries_lock);
+		put_binfmt_handler(e);
+	}
 }
 
-static void kill_node(Node *e)
+/**
+ * unlink_binfmt_dentry - remove the dentry for the binary type handler
+ * @dentry: dentry associated with the binary type handler
+ *
+ * Do the actual filesystem work to remove a dentry for a registered binary
+ * type handler. Since binfmt_misc only allows simple files to be created
+ * directly under the root dentry of the filesystem we ensure that we are
+ * indeed passed a dentry directly beneath the root dentry, that the inode
+ * associated with the root dentry is locked, and that it is a regular file we
+ * are asked to remove.
+ */
+static void unlink_binfmt_dentry(struct dentry *dentry)
 {
-	struct dentry *dentry;
+	struct dentry *parent = dentry->d_parent;
+	struct inode *inode, *parent_inode;
+
+	/* All entries are immediate descendants of the root dentry. */
+	if (WARN_ON_ONCE(dentry->d_sb->s_root != parent))
+		return;
 
+	/* We only expect to be called on regular files. */
+	inode = d_inode(dentry);
+	if (WARN_ON_ONCE(!S_ISREG(inode->i_mode)))
+		return;
+
+	/* The parent inode must be locked. */
+	parent_inode = d_inode(parent);
+	if (WARN_ON_ONCE(!inode_is_locked(parent_inode)))
+		return;
+
+	if (simple_positive(dentry)) {
+		dget(dentry);
+		simple_unlink(parent_inode, dentry);
+		d_delete(dentry);
+		dput(dentry);
+	}
+}
+
+/**
+ * remove_binfmt_handler - remove a binary type handler
+ * @misc: handle to binfmt_misc instance
+ * @e: binary type handler to remove
+ *
+ * Remove a binary type handler from the list of binary type handlers and
+ * remove its associated dentry. This is called from
+ * binfmt_{entry,status}_write(). In the future, we might want to think about
+ * adding a proper ->unlink() method to binfmt_misc instead of forcing caller's
+ * to use writes to files in order to delete binary type handlers. But it has
+ * worked for so long that it's not a pressing issue.
+ */
+static void remove_binfmt_handler(Node *e)
+{
 	write_lock(&entries_lock);
 	list_del_init(&e->list);
 	write_unlock(&entries_lock);
-
-	dentry = e->dentry;
-	drop_nlink(d_inode(dentry));
-	d_drop(dentry);
-	dput(dentry);
-	simple_release_fs(&bm_mnt, &entry_count);
+	unlink_binfmt_dentry(e->dentry);
 }
 
 /* /<entry> */
@@ -648,8 +755,8 @@ bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
 {
-	struct dentry *root;
-	Node *e = file_inode(file)->i_private;
+	struct inode *inode = file_inode(file);
+	Node *e = inode->i_private;
 	int res = parse_command(buffer, count);
 
 	switch (res) {
@@ -663,13 +770,22 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 		break;
 	case 3:
 		/* Delete this handler. */
-		root = file_inode(file)->i_sb->s_root;
-		inode_lock(d_inode(root));
+		inode = d_inode(inode->i_sb->s_root);
+		inode_lock(inode);
 
+		/*
+		 * In order to add new element or remove elements from the list
+		 * via bm_{entry,register,status}_write() inode_lock() on the
+		 * root inode must be held.
+		 * The lock is exclusive ensuring that the list can't be
+		 * modified. Only load_misc_binary() can access but does so
+		 * read-only. So we only need to take the write lock when we
+		 * actually remove the entry from the list.
+		 */
 		if (!list_empty(&e->list))
-			kill_node(e);
+			remove_binfmt_handler(e);
 
-		inode_unlock(d_inode(root));
+		inode_unlock(inode);
 		break;
 	default:
 		return res;
@@ -728,13 +844,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	if (!inode)
 		goto out2;
 
-	err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
-	if (err) {
-		iput(inode);
-		inode = NULL;
-		goto out2;
-	}
-
+	refcount_set(&e->users, 1);
 	e->dentry = dget(dentry);
 	inode->i_private = e;
 	inode->i_fop = &bm_entry_operations;
@@ -778,7 +888,8 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		size_t count, loff_t *ppos)
 {
 	int res = parse_command(buffer, count);
-	struct dentry *root;
+	Node *e, *next;
+	struct inode *inode;
 
 	switch (res) {
 	case 1:
@@ -791,13 +902,22 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		break;
 	case 3:
 		/* Delete all handlers. */
-		root = file_inode(file)->i_sb->s_root;
-		inode_lock(d_inode(root));
+		inode = d_inode(file_inode(file)->i_sb->s_root);
+		inode_lock(inode);
 
-		while (!list_empty(&entries))
-			kill_node(list_first_entry(&entries, Node, list));
+		/*
+		 * In order to add new element or remove elements from the list
+		 * via bm_{entry,register,status}_write() inode_lock() on the
+		 * root inode must be held.
+		 * The lock is exclusive ensuring that the list can't be
+		 * modified. Only load_misc_binary() can access but does so
+		 * read-only. So we only need to take the write lock when we
+		 * actually remove the entry from the list.
+		 */
+		list_for_each_entry_safe(e, next, &entries, list)
+			remove_binfmt_handler(e);
 
-		inode_unlock(d_inode(root));
+		inode_unlock(inode);
 		break;
 	default:
 		return res;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index fec62782fc86..fa8f359d8999 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -984,7 +984,7 @@ static void btrfs_release_delayed_inode(struct btrfs_delayed_node *delayed_node)
 
 	if (delayed_node &&
 	    test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
-		BUG_ON(!delayed_node->root);
+		ASSERT(delayed_node->root);
 		clear_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags);
 		delayed_node->count--;
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 88f577579259..e383c75b67a6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1732,9 +1732,9 @@ static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 	ctl->free_space -= bytes;
 }
 
-static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
-			    struct btrfs_free_space *info, u64 offset,
-			    u64 bytes)
+static void btrfs_bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
+				  struct btrfs_free_space *info, u64 offset,
+				  u64 bytes)
 {
 	unsigned long start, count;
 
@@ -1991,7 +1991,7 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 
 	bytes_to_set = min(end - offset, bytes);
 
-	bitmap_set_bits(ctl, info, offset, bytes_to_set);
+	btrfs_bitmap_set_bits(ctl, info, offset, bytes_to_set);
 
 	/*
 	 * We set some bytes, we have no idea what the max extent size is
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7f675862ffb0..15ebebed4005 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4296,7 +4296,14 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
-	BUG_ON(ret == 0);
+	if (ret == 0) {
+		/*
+		 * Key with offset -1 found, there would have to exist a root
+		 * with such id, but this is out of valid range.
+		 */
+		ret = -EUCLEAN;
+		goto out;
+	}
 
 	ret = 0;
 	if (path->slots[0] > 0) {
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ef95525fa6cd..770e6f652a1e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2095,8 +2095,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (nr_old_roots == 0 && nr_new_roots == 0)
 		goto out_free;
 
-	BUG_ON(!fs_info->quota_root);
-
 	trace_btrfs_qgroup_account_extent(fs_info, trans->transid, bytenr,
 					num_bytes, nr_old_roots, nr_new_roots);
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e3b6ca9176af..2840abf2037b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -677,7 +677,12 @@ static int begin_cmd(struct send_ctx *sctx, int cmd)
 	if (WARN_ON(!sctx->send_buf))
 		return -EINVAL;
 
-	BUG_ON(sctx->send_size);
+	if (unlikely(sctx->send_size != 0)) {
+		btrfs_err(sctx->send_root->fs_info,
+			  "send: command header buffer not empty cmd %d offset %llu",
+			  cmd, sctx->send_off);
+		return -EINVAL;
+	}
 
 	sctx->send_size += sizeof(*hdr);
 	hdr = (struct btrfs_cmd_header *)sctx->send_buf;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d931252b7d0d..d162cc059053 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3445,9 +3445,10 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	struct ext4_extent *ex, *abut_ex;
 	ext4_lblk_t ee_block, eof_block;
 	unsigned int ee_len, depth, map_len = map->m_len;
-	int allocated = 0, max_zeroout = 0;
 	int err = 0;
 	int split_flag = EXT4_EXT_DATA_VALID2;
+	int allocated = 0;
+	unsigned int max_zeroout = 0;
 
 	ext_debug("ext4_ext_convert_to_initialized: inode %lu, logical"
 		"block %llu, max_blocks %u\n", inode->i_ino,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5dcc3cad5c7d..75dbe40ed8f7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5219,6 +5219,9 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 	bool set_trimmed = false;
 	void *bitmap;
 
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		return 0;
+
 	last = ext4_last_grp_cluster(sb, e4b->bd_group);
 	bitmap = e4b->bd_bitmap;
 	if (start == 0 && max >= last)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 34090edc8ce2..6750cda692cc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2018,6 +2018,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 #endif
 
 	segno = GET_SEGNO(sbi, blkaddr);
+	if (segno == NULL_SEGNO)
+		return;
 
 	se = get_seg_entry(sbi, segno);
 	new_vblocks = se->valid_blocks + del;
@@ -2935,8 +2937,7 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	 * since SSR needs latest valid block information.
 	 */
 	update_sit_entry(sbi, *new_blkaddr, 1);
-	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
-		update_sit_entry(sbi, old_blkaddr, -1);
+	update_sit_entry(sbi, old_blkaddr, -1);
 
 	if (!__has_curseg_space(sbi, type))
 		sit_i->s_ops->allocate_segment(sbi, type, false);
diff --git a/fs/file.c b/fs/file.c
index dab2d6bfb7cb..64faefe4e082 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -41,27 +41,23 @@ static void free_fdtable_rcu(struct rcu_head *rcu)
 #define BITBIT_NR(nr)	BITS_TO_LONGS(BITS_TO_LONGS(nr))
 #define BITBIT_SIZE(nr)	(BITBIT_NR(nr) * sizeof(long))
 
+#define fdt_words(fdt) ((fdt)->max_fds / BITS_PER_LONG) // words in ->open_fds
 /*
  * Copy 'count' fd bits from the old table to the new table and clear the extra
  * space if any.  This does not copy the file pointers.  Called with the files
  * spinlock held for write.
  */
-static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
-			    unsigned int count)
+static inline void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
+			    unsigned int copy_words)
 {
-	unsigned int cpy, set;
-
-	cpy = count / BITS_PER_BYTE;
-	set = (nfdt->max_fds - count) / BITS_PER_BYTE;
-	memcpy(nfdt->open_fds, ofdt->open_fds, cpy);
-	memset((char *)nfdt->open_fds + cpy, 0, set);
-	memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
-	memset((char *)nfdt->close_on_exec + cpy, 0, set);
-
-	cpy = BITBIT_SIZE(count);
-	set = BITBIT_SIZE(nfdt->max_fds) - cpy;
-	memcpy(nfdt->full_fds_bits, ofdt->full_fds_bits, cpy);
-	memset((char *)nfdt->full_fds_bits + cpy, 0, set);
+	unsigned int nwords = fdt_words(nfdt);
+
+	bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->close_on_exec, ofdt->close_on_exec,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
+			copy_words, nwords);
 }
 
 /*
@@ -79,7 +75,7 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
 	memcpy(nfdt->fd, ofdt->fd, cpy);
 	memset((char *)nfdt->fd + cpy, 0, set);
 
-	copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds);
+	copy_fd_bitmaps(nfdt, ofdt, fdt_words(ofdt));
 }
 
 static struct fdtable * alloc_fdtable(unsigned int nr)
@@ -330,7 +326,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 		open_files = count_open_files(old_fdt);
 	}
 
-	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
+	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
 
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index a5144ecd5bab..6188ac11877e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1671,9 +1671,11 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
 		err = fuse_copy_page(cs, &page, offset, this_num, 0);
-		if (!err && offset == 0 &&
-		    (this_num == PAGE_SIZE || file_size == end))
+		if (!PageUptodate(page) && !err && offset == 0 &&
+		    (this_num == PAGE_SIZE || file_size == end)) {
+			zero_user_segment(page, this_num, PAGE_SIZE);
 			SetPageUptodate(page);
+		}
 		unlock_page(page);
 		put_page(page);
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index a52b8b0dceeb..16febedaa4a5 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1847,7 +1847,7 @@ static int setattr_chown(struct inode *inode, struct iattr *attr)
 	kuid_t ouid, nuid;
 	kgid_t ogid, ngid;
 	int error;
-	struct gfs2_alloc_parms ap;
+	struct gfs2_alloc_parms ap = {};
 
 	ouid = inode->i_uid;
 	ogid = inode->i_gid;
diff --git a/fs/locks.c b/fs/locks.c
index 234ebfa8c070..b1201b01867a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2313,7 +2313,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = fcheck(fd);
 		spin_unlock(&current->files->file_lock);
 		if (f != filp) {
-			locks_remove_posix(filp, &current->files);
+			locks_remove_posix(filp, current->files);
 			error = -EBADF;
 		}
 	}
@@ -2443,7 +2443,7 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = fcheck(fd);
 		spin_unlock(&current->files->file_lock);
 		if (f != filp) {
-			locks_remove_posix(filp, &current->files);
+			locks_remove_posix(filp, current->files);
 			error = -EBADF;
 		}
 	}
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index cfb1fe5dfb1e..7a0d9a1e6d13 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1889,6 +1889,14 @@ pnfs_update_layout(struct inode *ino,
 	}
 
 lookup_again:
+	if (!nfs4_valid_open_stateid(ctx->state)) {
+		trace_pnfs_update_layout(ino, pos, count,
+					 iomode, lo, lseg,
+					 PNFS_UPDATE_LAYOUT_INVALID_OPEN);
+		lseg = ERR_PTR(-EIO);
+		goto out;
+	}
+
 	lseg = ERR_PTR(nfs4_client_recover_expired_lease(clp));
 	if (IS_ERR(lseg))
 		goto out;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6bdb44fb07a7..a470bb4e00f1 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -985,9 +985,8 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 	 * smp_mb__before_atomic() in dquot_acquire().
 	 */
 	smp_rmb();
-#ifdef CONFIG_QUOTA_DEBUG
-	BUG_ON(!dquot->dq_sb);	/* Has somebody invalidated entry under us? */
-#endif
+	/* Has somebody invalidated entry under us? */
+	WARN_ON_ONCE(hlist_unhashed(&dquot->dq_hash));
 out:
 	if (empty)
 		do_destroy_dquot(empty);
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index b71a033c781e..3c942d9a8639 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -212,12 +212,14 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
 #define small_const_nbits(nbits) \
 	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
 
+#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
+
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = 0UL;
 	else {
-		unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+		unsigned int len = bitmap_size(nbits);
 		memset(dst, 0, len);
 	}
 }
@@ -227,7 +229,7 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 	if (small_const_nbits(nbits))
 		*dst = ~0UL;
 	else {
-		unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+		unsigned int len = bitmap_size(nbits);
 		memset(dst, 0xff, len);
 	}
 }
@@ -238,7 +240,7 @@ static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 	if (small_const_nbits(nbits))
 		*dst = *src;
 	else {
-		unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+		unsigned int len = bitmap_size(nbits);
 		memcpy(dst, src, len);
 	}
 }
@@ -254,6 +256,18 @@ static inline void bitmap_copy_clear_tail(unsigned long *dst,
 		dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
 }
 
+static inline void bitmap_copy_and_extend(unsigned long *to,
+					  const unsigned long *from,
+					  unsigned int count, unsigned int size)
+{
+	unsigned int copy = BITS_TO_LONGS(count);
+
+	memcpy(to, from, copy * sizeof(long));
+	if (count % BITS_PER_LONG)
+		to[copy - 1] &= BITMAP_LAST_WORD_MASK(count);
+	memset(to + copy, 0, bitmap_size(size) - copy * sizeof(long));
+}
+
 /*
  * On 32-bit systems bitmaps are represented as u32 arrays internally, and
  * therefore conversion is not needed when copying data from/to arrays of u32.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8f0aafae09d9..d76682d2f9dc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -56,7 +56,7 @@ struct blk_stat_callback;
  */
 #define BLKCG_MAX_POLS		5
 
-static inline int blk_validate_block_size(unsigned int bsize)
+static inline int blk_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 147bdec42215..e4467240eb86 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -656,7 +656,7 @@ static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
  */
 static inline unsigned int cpumask_size(void)
 {
-	return BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long);
+	return bitmap_size(nr_cpumask_bits);
 }
 
 /*
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index f68a7db14165..39939d55c834 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -4,9 +4,13 @@
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
 void __init fb_console_init(void);
 void __exit fb_console_exit(void);
+int  fbcon_modechange_possible(struct fb_info *info,
+			       struct fb_var_screeninfo *var);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
+static inline int  fbcon_modechange_possible(struct fb_info *info,
+				struct fb_var_screeninfo *var) { return 0; }
 #endif
 
 #endif /* _LINUX_FBCON_H */
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 4564a175e681..63e7c77ba942 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -241,76 +241,125 @@
 })
 
 /**
- * array_size() - Calculate size of 2-dimensional array.
+ * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
  *
- * @a: dimension one
- * @b: dimension two
+ * @factor1: first factor
+ * @factor2: second factor
  *
- * Calculates size of 2-dimensional array: @a * @b.
- *
- * Returns: number of bytes needed to represent the array or SIZE_MAX on
- * overflow.
+ * Returns: calculate @factor1 * @factor2, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. The
+ * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline __must_check size_t array_size(size_t a, size_t b)
+static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(a, b, &bytes))
+	if (check_mul_overflow(factor1, factor2, &bytes))
 		return SIZE_MAX;
 
 	return bytes;
 }
 
 /**
- * array3_size() - Calculate size of 3-dimensional array.
+ * size_add() - Calculate size_t addition with saturation at SIZE_MAX
  *
- * @a: dimension one
- * @b: dimension two
- * @c: dimension three
+ * @addend1: first addend
+ * @addend2: second addend
  *
- * Calculates size of 3-dimensional array: @a * @b * @c.
- *
- * Returns: number of bytes needed to represent the array or SIZE_MAX on
- * overflow.
+ * Returns: calculate @addend1 + @addend2, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. The
+ * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline __must_check size_t array3_size(size_t a, size_t b, size_t c)
+static inline size_t __must_check size_add(size_t addend1, size_t addend2)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(a, b, &bytes))
-		return SIZE_MAX;
-	if (check_mul_overflow(bytes, c, &bytes))
+	if (check_add_overflow(addend1, addend2, &bytes))
 		return SIZE_MAX;
 
 	return bytes;
 }
 
-static inline __must_check size_t __ab_c_size(size_t n, size_t size, size_t c)
+/**
+ * size_sub() - Calculate size_t subtraction with saturation at SIZE_MAX
+ *
+ * @minuend: value to subtract from
+ * @subtrahend: value to subtract from @minuend
+ *
+ * Returns: calculate @minuend - @subtrahend, both promoted to size_t,
+ * with any overflow causing the return value to be SIZE_MAX. For
+ * composition with the size_add() and size_mul() helpers, neither
+ * argument may be SIZE_MAX (or the result with be forced to SIZE_MAX).
+ * The lvalue must be size_t to avoid implicit type conversion.
+ */
+static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(n, size, &bytes))
-		return SIZE_MAX;
-	if (check_add_overflow(bytes, c, &bytes))
+	if (minuend == SIZE_MAX || subtrahend == SIZE_MAX ||
+	    check_sub_overflow(minuend, subtrahend, &bytes))
 		return SIZE_MAX;
 
 	return bytes;
 }
 
 /**
- * struct_size() - Calculate size of structure with trailing array.
+ * array_size() - Calculate size of 2-dimensional array.
+ *
+ * @a: dimension one
+ * @b: dimension two
+ *
+ * Calculates size of 2-dimensional array: @a * @b.
+ *
+ * Returns: number of bytes needed to represent the array or SIZE_MAX on
+ * overflow.
+ */
+#define array_size(a, b)	size_mul(a, b)
+
+/**
+ * array3_size() - Calculate size of 3-dimensional array.
+ *
+ * @a: dimension one
+ * @b: dimension two
+ * @c: dimension three
+ *
+ * Calculates size of 3-dimensional array: @a * @b * @c.
+ *
+ * Returns: number of bytes needed to represent the array or SIZE_MAX on
+ * overflow.
+ */
+#define array3_size(a, b, c)	size_mul(size_mul(a, b), c)
+
+/**
+ * flex_array_size() - Calculate size of a flexible array member
+ *                     within an enclosing structure.
+ *
+ * @p: Pointer to the structure.
+ * @member: Name of the flexible array member.
+ * @count: Number of elements in the array.
+ *
+ * Calculates size of a flexible array of @count number of @member
+ * elements, at the end of structure @p.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define flex_array_size(p, member, count)				\
+	size_mul(count,							\
+		 sizeof(*(p)->member) + __must_be_array((p)->member))
+
+/**
+ * struct_size() - Calculate size of structure with trailing flexible array.
+ *
  * @p: Pointer to the structure.
  * @member: Name of the array member.
- * @n: Number of elements in the array.
+ * @count: Number of elements in the array.
  *
  * Calculates size of memory needed for structure @p followed by an
- * array of @n @member elements.
+ * array of @count number of @member elements.
  *
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
-#define struct_size(p, member, n)					\
-	__ab_c_size(n,							\
-		    sizeof(*(p)->member) + __must_be_array((p)->member),\
-		    sizeof(*(p)))
+#define struct_size(p, member, count)					\
+	size_add(sizeof(*(p)), flex_array_size(p, member, count))
 
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 8f42f6f3af86..c45253ee08c9 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -73,7 +73,7 @@ static inline bool sk_can_busy_loop(struct sock *sk)
 static inline unsigned long busy_loop_current_time(void)
 {
 #ifdef CONFIG_NET_RX_BUSY_POLL
-	return (unsigned long)(local_clock() >> 10);
+	return (unsigned long)(ktime_get_ns() >> 10);
 #else
 	return 0;
 #endif
diff --git a/include/net/kcm.h b/include/net/kcm.h
index 2a8965819db0..2dc5e926dd3f 100644
--- a/include/net/kcm.h
+++ b/include/net/kcm.h
@@ -73,6 +73,7 @@ struct kcm_sock {
 	struct work_struct tx_work;
 	struct list_head wait_psock_list;
 	struct sk_buff *seq_skb;
+	struct mutex tx_mutex;
 	u32 tx_stopped : 1;
 
 	/* Don't use bit fields here, these are set under different locks */
diff --git a/ipc/msg.c b/ipc/msg.c
index ac4de3f67261..9a1ff5669cfb 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -137,7 +137,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	key_t key = params->key;
 	int msgflg = params->flg;
 
-	msq = kvmalloc(sizeof(*msq), GFP_KERNEL);
+	msq = kvmalloc(sizeof(*msq), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!msq))
 		return -ENOMEM;
 
diff --git a/ipc/sem.c b/ipc/sem.c
index cc6af85d1b15..d84f42196e52 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -494,7 +494,7 @@ static struct sem_array *sem_alloc(size_t nsems)
 		return NULL;
 
 	size = sizeof(*sma) + nsems * sizeof(sma->sems[0]);
-	sma = kvmalloc(size, GFP_KERNEL);
+	sma = kvmalloc(size, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!sma))
 		return NULL;
 
@@ -1813,7 +1813,7 @@ static inline int get_undo_list(struct sem_undo_list **undo_listp)
 
 	undo_list = current->sysvsem.undo_list;
 	if (!undo_list) {
-		undo_list = kzalloc(sizeof(*undo_list), GFP_KERNEL);
+		undo_list = kzalloc(sizeof(*undo_list), GFP_KERNEL_ACCOUNT);
 		if (undo_list == NULL)
 			return -ENOMEM;
 		spin_lock_init(&undo_list->lock);
@@ -1897,7 +1897,8 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	rcu_read_unlock();
 
 	/* step 2: allocate new undo structure */
-	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
+	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems,
+		      GFP_KERNEL_ACCOUNT);
 	if (!new) {
 		ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
 		return ERR_PTR(-ENOMEM);
diff --git a/ipc/shm.c b/ipc/shm.c
index ba99f48c6e2b..0a5053f5726f 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -711,7 +711,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 			ns->shm_tot + numpages > ns->shm_ctlall)
 		return -ENOSPC;
 
-	shp = kvmalloc(sizeof(*shp), GFP_KERNEL);
+	shp = kvmalloc(sizeof(*shp), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!shp))
 		return -ENOMEM;
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index af749e265ead..e208d2617179 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -22,6 +22,7 @@
  *  distribution for more details.
  */
 
+#include "cgroup-internal.h"
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cpuset.h>
@@ -2758,10 +2759,14 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 	if (!buf)
 		goto out;
 
-	css = task_get_css(tsk, cpuset_cgrp_id);
-	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
-				current->nsproxy->cgroup_ns);
-	css_put(css);
+	rcu_read_lock();
+	spin_lock_irq(&css_set_lock);
+	css = task_css(tsk, cpuset_cgrp_id);
+	retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
+				       current->nsproxy->cgroup_ns);
+	spin_unlock_irq(&css_set_lock);
+	rcu_read_unlock();
+
 	if (retval >= PATH_MAX)
 		retval = -ENAMETOOLONG;
 	if (retval < 0)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0eb5b6cc6d93..b600dc1290d7 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1172,6 +1172,8 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(!timer->function))
+		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match.
diff --git a/lib/idr.c b/lib/idr.c
index 432a985bf772..3e4035fa89dd 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -471,7 +471,7 @@ static void ida_remove(struct ida *ida, int id)
 	} else {
 		btmp = bitmap->bitmap;
 	}
-	if (!test_bit(offset, btmp))
+	if (!bitmap || !test_bit(offset, btmp))
 		goto err;
 
 	__clear_bit(offset, btmp);
diff --git a/lib/test_ida.c b/lib/test_ida.c
index b06880625961..55105baa19da 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -150,6 +150,45 @@ static void ida_check_conv(struct ida *ida)
 	IDA_BUG_ON(ida, !ida_is_empty(ida));
 }
 
+/*
+ * Check various situations where we attempt to free an ID we don't own.
+ */
+static void ida_check_bad_free(struct ida *ida)
+{
+	unsigned long i;
+
+	printk("vvv Ignore \"not allocated\" warnings\n");
+	/* IDA is empty; all of these will fail */
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a single value entry */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 3, GFP_KERNEL) != 3);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a single bitmap */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 1023, GFP_KERNEL) != 1023);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a tree */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, (1 << 20) - 1, GFP_KERNEL) != (1 << 20) - 1);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+	printk("^^^ \"not allocated\" warnings over\n");
+
+	ida_free(ida, 3);
+	ida_free(ida, 1023);
+	ida_free(ida, (1 << 20) - 1);
+
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+}
+
 static DEFINE_IDA(ida);
 
 static int ida_checks(void)
@@ -162,6 +201,7 @@ static int ida_checks(void)
 	ida_check_leaf(&ida, 1024 * 64);
 	ida_check_max(&ida);
 	ida_check_conv(&ida);
+	ida_check_bad_free(&ida);
 
 	printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index 7a4b6f6c5473..7a5a5738d2d2 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -588,12 +588,110 @@ static int __init test_overflow_allocation(void)
 	return err;
 }
 
+struct __test_flex_array {
+	unsigned long flags;
+	size_t count;
+	unsigned long data[];
+};
+
+static int __init test_overflow_size_helpers(void)
+{
+	struct __test_flex_array *obj;
+	int count = 0;
+	int err = 0;
+	int var;
+
+#define check_one_size_helper(expected, func, args...)	({	\
+	bool __failure = false;					\
+	size_t _r;						\
+								\
+	_r = func(args);					\
+	if (_r != (expected)) {					\
+		pr_warn("expected " #func "(" #args ") "	\
+			"to return %zu but got %zu instead\n",	\
+			(size_t)(expected), _r);		\
+		__failure = true;				\
+	}							\
+	count++;						\
+	__failure;						\
+})
+
+	var = 4;
+	err |= check_one_size_helper(20,       size_mul, var++, 5);
+	err |= check_one_size_helper(20,       size_mul, 4, var++);
+	err |= check_one_size_helper(0,	       size_mul, 0, 3);
+	err |= check_one_size_helper(0,	       size_mul, 3, 0);
+	err |= check_one_size_helper(6,	       size_mul, 2, 3);
+	err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  1);
+	err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX,  3);
+	err |= check_one_size_helper(SIZE_MAX, size_mul, SIZE_MAX, -3);
+
+	var = 4;
+	err |= check_one_size_helper(9,        size_add, var++, 5);
+	err |= check_one_size_helper(9,        size_add, 4, var++);
+	err |= check_one_size_helper(9,	       size_add, 9, 0);
+	err |= check_one_size_helper(9,	       size_add, 0, 9);
+	err |= check_one_size_helper(5,	       size_add, 2, 3);
+	err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  1);
+	err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  3);
+	err |= check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX, -3);
+
+	var = 4;
+	err |= check_one_size_helper(1,        size_sub, var--, 3);
+	err |= check_one_size_helper(1,        size_sub, 4, var--);
+	err |= check_one_size_helper(1,        size_sub, 3, 2);
+	err |= check_one_size_helper(9,	       size_sub, 9, 0);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, 9, -3);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, 0, 9);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, 2, 3);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, SIZE_MAX,  0);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, SIZE_MAX, 10);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, 0,  SIZE_MAX);
+	err |= check_one_size_helper(SIZE_MAX, size_sub, 14, SIZE_MAX);
+	err |= check_one_size_helper(SIZE_MAX - 2, size_sub, SIZE_MAX - 1,  1);
+	err |= check_one_size_helper(SIZE_MAX - 4, size_sub, SIZE_MAX - 1,  3);
+	err |= check_one_size_helper(1,		size_sub, SIZE_MAX - 1, -3);
+
+	var = 4;
+	err |= check_one_size_helper(4 * sizeof(*obj->data),
+				     flex_array_size, obj, data, var++);
+	err |= check_one_size_helper(5 * sizeof(*obj->data),
+				     flex_array_size, obj, data, var++);
+	err |= check_one_size_helper(0, flex_array_size, obj, data, 0);
+	err |= check_one_size_helper(sizeof(*obj->data),
+				     flex_array_size, obj, data, 1);
+	err |= check_one_size_helper(7 * sizeof(*obj->data),
+				     flex_array_size, obj, data, 7);
+	err |= check_one_size_helper(SIZE_MAX,
+				     flex_array_size, obj, data, -1);
+	err |= check_one_size_helper(SIZE_MAX,
+				     flex_array_size, obj, data, SIZE_MAX - 4);
+
+	var = 4;
+	err |= check_one_size_helper(sizeof(*obj) + (4 * sizeof(*obj->data)),
+				     struct_size, obj, data, var++);
+	err |= check_one_size_helper(sizeof(*obj) + (5 * sizeof(*obj->data)),
+				     struct_size, obj, data, var++);
+	err |= check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0);
+	err |= check_one_size_helper(sizeof(*obj) + sizeof(*obj->data),
+				     struct_size, obj, data, 1);
+	err |= check_one_size_helper(SIZE_MAX,
+				     struct_size, obj, data, -3);
+	err |= check_one_size_helper(SIZE_MAX,
+				     struct_size, obj, data, SIZE_MAX - 3);
+
+	pr_info("%d overflow size helper tests finished\n", count);
+
+	return err;
+}
+
 static int __init test_module_init(void)
 {
 	int err = 0;
 
 	err |= test_overflow_calculation();
 	err |= test_overflow_shift();
+	err |= test_overflow_size_helpers();
 	err |= test_overflow_allocation();
 
 	if (err) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d187bfb43b1f..e53d57990691 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4140,9 +4140,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	buf = endp + 1;
 
 	cfd = simple_strtoul(buf, &endp, 10);
-	if ((*endp != ' ') && (*endp != '\0'))
+	if (*endp == '\0')
+		buf = endp;
+	else if (*endp == ' ')
+		buf = endp + 1;
+	else
 		return -EINVAL;
-	buf = endp + 1;
 
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event)
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 7b3965861013..a16d584a6c0d 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -385,7 +385,8 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 	case BNEP_COMPRESSED_DST_ONLY:
 		__skb_put_data(nskb, skb_mac_header(skb), ETH_ALEN);
-		__skb_put_data(nskb, s->eh.h_source, ETH_ALEN + 2);
+		__skb_put_data(nskb, s->eh.h_source, ETH_ALEN);
+		put_unaligned(s->eh.h_proto, (__be16 *)__skb_put(nskb, 2));
 		break;
 
 	case BNEP_GENERAL:
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 504f6aa4e95d..bb89ca37decb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3931,15 +3931,27 @@ static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
 	return DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE, hdev->block_len);
 }
 
-static void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
+static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
 {
-	if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
-		/* ACL tx timeout must be longer than maximum
-		 * link supervision timeout (40.9 seconds) */
-		if (!cnt && time_after(jiffies, hdev->acl_last_tx +
-				       HCI_ACL_TX_TIMEOUT))
-			hci_link_tx_to(hdev, ACL_LINK);
+	unsigned long last_tx;
+
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
+		return;
+
+	switch (type) {
+	case LE_LINK:
+		last_tx = hdev->le_last_tx;
+		break;
+	default:
+		last_tx = hdev->acl_last_tx;
+		break;
 	}
+
+	/* tx timeout must be longer than maximum link supervision timeout
+	 * (40.9 seconds)
+	 */
+	if (!cnt && time_after(jiffies, last_tx + HCI_ACL_TX_TIMEOUT))
+		hci_link_tx_to(hdev, type);
 }
 
 static void hci_sched_acl_pkt(struct hci_dev *hdev)
@@ -3949,7 +3961,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int quote;
 
-	__check_timeout(hdev, cnt);
+	__check_timeout(hdev, cnt, ACL_LINK);
 
 	while (hdev->acl_cnt &&
 	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
@@ -3988,8 +4000,6 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 	int quote;
 	u8 type;
 
-	__check_timeout(hdev, cnt);
-
 	BT_DBG("%s", hdev->name);
 
 	if (hdev->dev_type == HCI_AMP)
@@ -3997,6 +4007,8 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 	else
 		type = ACL_LINK;
 
+	__check_timeout(hdev, cnt, type);
+
 	while (hdev->block_cnt > 0 &&
 	       (chan = hci_chan_sent(hdev, type, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
@@ -4109,24 +4121,19 @@ static void hci_sched_le(struct hci_dev *hdev)
 {
 	struct hci_chan *chan;
 	struct sk_buff *skb;
-	int quote, cnt, tmp;
+	int quote, *cnt, tmp;
 
 	BT_DBG("%s", hdev->name);
 
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
-		/* LE tx timeout must be longer than maximum
-		 * link supervision timeout (40.9 seconds) */
-		if (!hdev->le_cnt && hdev->le_pkts &&
-		    time_after(jiffies, hdev->le_last_tx + HZ * 45))
-			hci_link_tx_to(hdev, LE_LINK);
-	}
+	cnt = hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
 
-	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
-	tmp = cnt;
-	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
+	__check_timeout(hdev, *cnt, LE_LINK);
+
+	tmp = *cnt;
+	while (*cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
@@ -4141,18 +4148,13 @@ static void hci_sched_le(struct hci_dev *hdev)
 			hci_send_frame(hdev, skb);
 			hdev->le_last_tx = jiffies;
 
-			cnt--;
+			(*cnt)--;
 			chan->sent++;
 			chan->conn->sent++;
 		}
 	}
 
-	if (hdev->le_pkts)
-		hdev->le_cnt = cnt;
-	else
-		hdev->acl_cnt = cnt;
-
-	if (cnt != tmp)
+	if (*cnt != tmp)
 		hci_prio_recalculate(hdev, LE_LINK);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d0ec0e336909..6473c0cd6da8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2913,6 +2913,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * will be kept and this function does nothing.
 		 */
 		p = hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
+		if (!p) {
+			err = -EIO;
+			goto unlock;
+		}
 
 		if (p->auto_connect == HCI_AUTO_CONN_EXPLICIT)
 			p->auto_connect = HCI_AUTO_CONN_DISABLED;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e03cd719b86b..69081cdfab43 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3625,8 +3625,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		/* GSO partial only requires that we trim off any excess that
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
+		 * Cap len to not accidentally hit GSO_BY_FRAGS.
 		 */
-		partial_segs = len / mss;
+		partial_segs = min(len, (unsigned int)(GSO_BY_FRAGS - 1)) / mss;
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 0872df066a4e..52f0ddb3835b 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1757,6 +1757,7 @@ int ip6_send_skb(struct sk_buff *skb)
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	int err;
 
+	rcu_read_lock();
 	err = ip6_local_out(net, skb->sk, skb);
 	if (err) {
 		if (err > 0)
@@ -1766,6 +1767,7 @@ int ip6_send_skb(struct sk_buff *skb)
 				      IPSTATS_MIB_OUTDISCARDS);
 	}
 
+	rcu_read_unlock();
 	return err;
 }
 
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 2f82a6f0992e..b1ecf008fa50 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -1149,8 +1149,7 @@ static int iucv_message_receive_iprmdata(struct iucv_path *path,
 		size = (size < 8) ? size : 8;
 		for (array = buffer; size > 0; array++) {
 			copy = min_t(size_t, size, array->length);
-			memcpy((u8 *)(addr_t) array->address,
-				rmmsg, copy);
+			memcpy(phys_to_virt(array->address), rmmsg, copy);
 			rmmsg += copy;
 			size -= copy;
 		}
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 45450f0fd9ac..b8b2b2cb6bdb 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -912,6 +912,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		  !(msg->msg_flags & MSG_MORE) : !!(msg->msg_flags & MSG_EOR);
 	int err = -EPIPE;
 
+	mutex_lock(&kcm->tx_mutex);
 	lock_sock(sk);
 
 	/* Per tcp_sendmsg this should be in poll */
@@ -1060,6 +1061,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	KCM_STATS_ADD(kcm->stats.tx_bytes, copied);
 
 	release_sock(sk);
+	mutex_unlock(&kcm->tx_mutex);
 	return copied;
 
 out_error:
@@ -1085,6 +1087,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		sk->sk_write_space(sk);
 
 	release_sock(sk);
+	mutex_unlock(&kcm->tx_mutex);
 	return err;
 }
 
@@ -1327,6 +1330,7 @@ static void init_kcm_sock(struct kcm_sock *kcm, struct kcm_mux *mux)
 	spin_unlock_bh(&mux->lock);
 
 	INIT_WORK(&kcm->tx_work, kcm_tx_work);
+	mutex_init(&kcm->tx_mutex);
 
 	spin_lock_bh(&mux->rx_lock);
 	kcm_rcv_ready(kcm);
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index a61d7edfc290..b4a4ed00506f 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -108,11 +108,16 @@ static void nft_counter_reset(struct nft_counter_percpu_priv __percpu *priv,
 			      struct nft_counter *total)
 {
 	struct nft_counter *this_cpu;
+	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
+	myseq = this_cpu_ptr(&nft_counter_seq);
+
+	write_seqcount_begin(myseq);
 	this_cpu->packets -= total->packets;
 	this_cpu->bytes -= total->bytes;
+	write_seqcount_end(myseq);
 	local_bh_enable();
 }
 
diff --git a/net/rds/recv.c b/net/rds/recv.c
index ccf0bf283002..0b35a11fcf46 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -429,6 +429,7 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 	struct sock *sk = rds_rs_to_sk(rs);
 	int ret = 0;
 	unsigned long flags;
+	struct rds_incoming *to_drop = NULL;
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	if (!list_empty(&inc->i_item)) {
@@ -439,11 +440,14 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 					      -be32_to_cpu(inc->i_hdr.h_len),
 					      inc->i_hdr.h_dport);
 			list_del_init(&inc->i_item);
-			rds_inc_put(inc);
+			to_drop = inc;
 		}
 	}
 	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 
+	if (to_drop)
+		rds_inc_put(to_drop);
+
 	rdsdebug("inc %p rs %p still %d dropped %d\n", inc, rs, ret, drop);
 	return ret;
 }
@@ -752,16 +756,21 @@ void rds_clear_recv_queue(struct rds_sock *rs)
 	struct sock *sk = rds_rs_to_sk(rs);
 	struct rds_incoming *inc, *tmp;
 	unsigned long flags;
+	LIST_HEAD(to_drop);
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	list_for_each_entry_safe(inc, tmp, &rs->rs_recv_queue, i_item) {
 		rds_recv_rcvbuf_delta(rs, sk, inc->i_conn->c_lcong,
 				      -be32_to_cpu(inc->i_hdr.h_len),
 				      inc->i_hdr.h_dport);
+		list_move(&inc->i_item, &to_drop);
+	}
+	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
+
+	list_for_each_entry_safe(inc, tmp, &to_drop, i_item) {
 		list_del_init(&inc->i_item);
 		rds_inc_put(inc);
 	}
-	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 }
 
 /*
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 717a4be771ab..f1843226e906 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -401,12 +401,12 @@ static int avc_add_xperms_decision(struct avc_node *node,
 {
 	struct avc_xperms_decision_node *dest_xpd;
 
-	node->ae.xp_node->xp.len++;
 	dest_xpd = avc_xperms_decision_alloc(src->used);
 	if (!dest_xpd)
 		return -ENOMEM;
 	avc_copy_xperms_decision(&dest_xpd->xpd, src);
 	list_add(&dest_xpd->xpd_list, &node->ae.xp_node->xpd_head);
+	node->ae.xp_node->xp.len++;
 	return 0;
 }
 
diff --git a/sound/core/timer.c b/sound/core/timer.c
index d053d70c8d35..b38601771b32 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -532,7 +532,7 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
 	/* check the actual time for the start tick;
 	 * bail out as error if it's way too low (< 100us)
 	 */
-	if (start) {
+	if (start && !(timer->hw.flags & SNDRV_TIMER_HW_SLAVE)) {
 		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000) {
 			result = -EINVAL;
 			goto unlock;
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 6c546f520f99..50fddefbd3cc 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -352,6 +352,7 @@ YAMAHA_DEVICE(0x105a, NULL),
 YAMAHA_DEVICE(0x105b, NULL),
 YAMAHA_DEVICE(0x105c, NULL),
 YAMAHA_DEVICE(0x105d, NULL),
+YAMAHA_DEVICE(0x1718, "P-125"),
 {
 	USB_DEVICE(0x0499, 0x1503),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
new file mode 100644
index 000000000000..a27bc1edf6e5
--- /dev/null
+++ b/tools/include/linux/align.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TOOLS_LINUX_ALIGN_H
+#define _TOOLS_LINUX_ALIGN_H
+
+#include <linux/const.h>
+
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif /* _TOOLS_LINUX_ALIGN_H */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index e63662db131b..b5abe59bad40 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -3,6 +3,7 @@
 #define _PERF_BITOPS_H
 
 #include <string.h>
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <stdlib.h>
 #include <linux/kernel.h>
@@ -27,13 +28,14 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 #define small_const_nbits(nbits) \
 	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
 
+#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
+
 static inline void bitmap_zero(unsigned long *dst, int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = 0UL;
 	else {
-		int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-		memset(dst, 0, len);
+		memset(dst, 0, bitmap_size(nbits));
 	}
 }
 
@@ -119,7 +121,7 @@ static inline int test_and_clear_bit(int nr, unsigned long *addr)
  */
 static inline unsigned long *bitmap_alloc(int nbits)
 {
-	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
+	return calloc(1, bitmap_size(nbits));
 }
 
 /*

