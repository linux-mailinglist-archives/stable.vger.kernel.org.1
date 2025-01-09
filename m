Return-Path: <stable+bounces-108099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38638A0763E
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB941652CE
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2FE218AB7;
	Thu,  9 Jan 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k6QnwxGh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933B218837;
	Thu,  9 Jan 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427405; cv=none; b=q4adEU8fJxtbUgbwK+LlPppxufXwenpkrGzx1seFhf/pqx+H5jltEhLkP78ccrMuPIwLf/lEYyehTbKzEe5LWSQJuVGGQWLzQhTlC5IakAMn8wTr1VD2JUPnpCq7sSrBi9461Rp1qrkhz3Z4UPwhk7MwDfm2+u/ZCCx4ea8cTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427405; c=relaxed/simple;
	bh=Q81tsiYOuZhu6LzK3+dNJJ0uBmDjlTdP1unuzI1aEus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHuZHQ942ZL2GXrsuf9/Qiu99w0Uqonl/Mm/s1zRaDPo9mBfNKqnDsVQ06bQxAEOV24bX+4Nz7SLQC+sgXl+Yyyji4nliC4AMehdE/B/Irtpq9C7MJLGMn1409JIWlB4gcJ05KdluM5+fQUmSBpf5VJN1MPPnZ4MCZuGdRd+a+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k6QnwxGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241F0C4CED2;
	Thu,  9 Jan 2025 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736427404;
	bh=Q81tsiYOuZhu6LzK3+dNJJ0uBmDjlTdP1unuzI1aEus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6QnwxGh8wk6guSm1g+D9KS625R40UwglMHC3xSnBkx3OIG6fRVsN5zz2lohBgiwP
	 OnyAypnpNJo8qoRhW1YwjbGoEoTdwpZq5U6xMd+wZHi5h6U5rBKbSOZD86X8GSbHEr
	 IRA/2YEZ6TYoFhXIqwmSCzbEQ2PU7GKonkSUIGnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.233
Date: Thu,  9 Jan 2025 13:56:31 +0100
Message-ID: <2025010931-gumminess-detective-1b75@gregkh>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025010931-goldfish-busily-db8d@gregkh>
References: <2025010931-goldfish-busily-db8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index d7be09303079..120115064c20 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 232
+SUBLEVEL = 233
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 578bdbbb0fa7..18f4b2452074 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -6,7 +6,7 @@
 KBUILD_DEFCONFIG := haps_hs_smp_defconfig
 
 ifeq ($(CROSS_COMPILE),)
-CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
+CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux- arc-linux-gnu-)
 endif
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 001737a8f309..4115c40a3ccc 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -32,11 +32,11 @@ static unsigned long nr_pinned_asids;
 static unsigned long *pinned_asid_map;
 
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
-#define ASID_FIRST_VERSION	(1UL << asid_bits)
+#define ASID_FIRST_VERSION	(1UL << 16)
 
-#define NUM_USER_ASIDS		ASID_FIRST_VERSION
-#define asid2idx(asid)		((asid) & ~ASID_MASK)
-#define idx2asid(idx)		asid2idx(idx)
+#define NUM_USER_ASIDS		(1UL << asid_bits)
+#define ctxid2asid(asid)	((asid) & ~ASID_MASK)
+#define asid2ctxid(asid, genid)	((asid) | (genid))
 
 /* Get the ASIDBits supported by the current CPU */
 static u32 get_cpu_asid_bits(void)
@@ -120,7 +120,7 @@ static void flush_context(void)
 		 */
 		if (asid == 0)
 			asid = per_cpu(reserved_asids, i);
-		__set_bit(asid2idx(asid), asid_map);
+		__set_bit(ctxid2asid(asid), asid_map);
 		per_cpu(reserved_asids, i) = asid;
 	}
 
@@ -162,7 +162,7 @@ static u64 new_context(struct mm_struct *mm)
 	u64 generation = atomic64_read(&asid_generation);
 
 	if (asid != 0) {
-		u64 newasid = generation | (asid & ~ASID_MASK);
+		u64 newasid = asid2ctxid(ctxid2asid(asid), generation);
 
 		/*
 		 * If our current ASID was active during a rollover, we
@@ -183,7 +183,7 @@ static u64 new_context(struct mm_struct *mm)
 		 * We had a valid ASID in a previous life, so try to re-use
 		 * it if possible.
 		 */
-		if (!__test_and_set_bit(asid2idx(asid), asid_map))
+		if (!__test_and_set_bit(ctxid2asid(asid), asid_map))
 			return newasid;
 	}
 
@@ -209,7 +209,7 @@ static u64 new_context(struct mm_struct *mm)
 set_asid:
 	__set_bit(asid, asid_map);
 	cur_idx = asid;
-	return idx2asid(asid) | generation;
+	return asid2ctxid(asid, generation);
 }
 
 void check_and_switch_context(struct mm_struct *mm)
@@ -300,13 +300,13 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 	}
 
 	nr_pinned_asids++;
-	__set_bit(asid2idx(asid), pinned_asid_map);
+	__set_bit(ctxid2asid(asid), pinned_asid_map);
 	refcount_set(&mm->context.pinned, 1);
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
-	asid &= ~ASID_MASK;
+	asid = ctxid2asid(asid);
 
 	/* Set the equivalent of USER_ASID_BIT */
 	if (asid && arm64_kernel_unmapped_at_el0())
@@ -327,7 +327,7 @@ void arm64_mm_context_put(struct mm_struct *mm)
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
 
 	if (refcount_dec_and_test(&mm->context.pinned)) {
-		__clear_bit(asid2idx(asid), pinned_asid_map);
+		__clear_bit(ctxid2asid(asid), pinned_asid_map);
 		nr_pinned_asids--;
 	}
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index acab8018ab44..289fb4b88d0e 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -272,7 +272,7 @@ drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 ifdef CONFIG_64BIT
   ifndef KBUILD_SYM32
     ifeq ($(shell expr $(load-y) \< 0xffffffff80000000), 0)
-      KBUILD_SYM32 = y
+      KBUILD_SYM32 = $(call cc-option-yn, -msym32)
     endif
   endif
 
diff --git a/arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts b/arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts
index c945f8565d54..fb180cb2b8e2 100644
--- a/arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts
+++ b/arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts
@@ -33,6 +33,7 @@ msi: msi-controller@2ff00000 {
 		compatible = "loongson,pch-msi-1.0";
 		reg = <0 0x2ff00000 0 0x8>;
 		interrupt-controller;
+		#interrupt-cells = <1>;
 		msi-controller;
 		loongson,msi-base-vec = <64>;
 		loongson,msi-num-vecs = <192>;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index a91aad434d03..14e5e1d7d0e8 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -163,6 +163,63 @@ static void hv_machine_crash_shutdown(struct pt_regs *regs)
 	hyperv_cleanup();
 }
 #endif /* CONFIG_KEXEC_CORE */
+
+static u64 hv_ref_counter_at_suspend;
+static void (*old_save_sched_clock_state)(void);
+static void (*old_restore_sched_clock_state)(void);
+
+/*
+ * Hyper-V clock counter resets during hibernation. Save and restore clock
+ * offset during suspend/resume, while also considering the time passed
+ * before suspend. This is to make sure that sched_clock using hv tsc page
+ * based clocksource, proceeds from where it left off during suspend and
+ * it shows correct time for the timestamps of kernel messages after resume.
+ */
+static void save_hv_clock_tsc_state(void)
+{
+	hv_ref_counter_at_suspend = hv_read_reference_counter();
+}
+
+static void restore_hv_clock_tsc_state(void)
+{
+	/*
+	 * Adjust the offsets used by hv tsc clocksource to
+	 * account for the time spent before hibernation.
+	 * adjusted value = reference counter (time) at suspend
+	 *                - reference counter (time) now.
+	 */
+	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
+}
+
+/*
+ * Functions to override save_sched_clock_state and restore_sched_clock_state
+ * functions of x86_platform. The Hyper-V clock counter is reset during
+ * suspend-resume and the offset used to measure time needs to be
+ * corrected, post resume.
+ */
+static void hv_save_sched_clock_state(void)
+{
+	old_save_sched_clock_state();
+	save_hv_clock_tsc_state();
+}
+
+static void hv_restore_sched_clock_state(void)
+{
+	restore_hv_clock_tsc_state();
+	old_restore_sched_clock_state();
+}
+
+static void __init x86_setup_ops_for_tsc_pg_clock(void)
+{
+	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
+		return;
+
+	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
+	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
+
+	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
+	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
+}
 #endif /* CONFIG_HYPERV */
 
 static uint32_t  __init ms_hyperv_platform(void)
@@ -380,6 +437,7 @@ static void __init ms_hyperv_init_platform(void)
 
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
+	x86_setup_ops_for_tsc_pg_clock();
 #endif
 	/*
 	 * TSC should be marked as unstable only after Hyper-V
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ccf002c536fb..fb463d19a70a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1115,13 +1115,13 @@ struct regmap *__regmap_init(struct device *dev,
 
 		/* Sanity check */
 		if (range_cfg->range_max < range_cfg->range_min) {
-			dev_err(map->dev, "Invalid range %d: %d < %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u < %u\n", i,
 				range_cfg->range_max, range_cfg->range_min);
 			goto err_range;
 		}
 
 		if (range_cfg->range_max > map->max_register) {
-			dev_err(map->dev, "Invalid range %d: %d > %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u > %u\n", i,
 				range_cfg->range_max, map->max_register);
 			goto err_range;
 		}
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7eae3f373233..28ea9b511fd0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -951,9 +951,12 @@ static void virtblk_remove(struct virtio_device *vdev)
 static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
+	struct request_queue *q = vblk->disk->queue;
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
-	blk_mq_freeze_queue(vblk->disk->queue);
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_unfreeze_queue(q);
 
 	/* Ensure we don't receive any more interrupts */
 	vdev->config->reset(vdev);
@@ -977,8 +980,8 @@ static int virtblk_restore(struct virtio_device *vdev)
 		return ret;
 
 	virtio_device_ready(vdev);
+	blk_mq_unquiesce_queue(vblk->disk->queue);
 
-	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0636df6b67db..16db4fae5145 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -502,6 +502,12 @@ static ssize_t backing_dev_store(struct device *dev,
 	}
 
 	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
+	/* Refuse to use zero sized device (also prevents self reference) */
+	if (!nr_pages) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
 	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
 	if (!bitmap) {
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 7c617d8dff3f..a8875384fb02 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -23,7 +23,8 @@
 #include <asm/mshyperv.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
-static u64 hv_sched_clock_offset __ro_after_init;
+/* Note: offset can hold negative values after hibernation. */
+static u64 hv_sched_clock_offset __read_mostly;
 
 /*
  * If false, we're using the old mechanism for stimer0 interrupts
@@ -370,6 +371,17 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_reference_tsc(tsc_msr);
 }
 
+/*
+ * Called during resume from hibernation, from overridden
+ * x86_platform.restore_sched_clock_state routine. This is to adjust offsets
+ * used to calculate time for hv tsc page based sched_clock, to account for
+ * time spent before hibernation.
+ */
+void hv_adj_sched_clock_offset(u64 offset)
+{
+	hv_sched_clock_offset -= offset;
+}
+
 static int hv_cs_enable(struct clocksource *cs)
 {
 	hv_enable_vdso_clocksource();
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index e359c5c6c4df..14b79458ac7f 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -158,7 +158,7 @@ static const struct dma_buf_ops udmabuf_ops = {
 };
 
 #define SEALS_WANTED (F_SEAL_SHRINK)
-#define SEALS_DENIED (F_SEAL_WRITE)
+#define SEALS_DENIED (F_SEAL_WRITE|F_SEAL_FUTURE_WRITE)
 
 static long udmabuf_create(struct miscdevice *device,
 			   struct udmabuf_create_list *head,
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 861be862a775..8a7c98f093ce 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1220,6 +1220,8 @@ at_xdmac_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 		return NULL;
 
 	desc = at_xdmac_memset_create_desc(chan, atchan, dest, len, value);
+	if (!desc)
+		return NULL;
 	list_add_tail(&desc->desc_node, &desc->descs_list);
 
 	desc->tx_dma_desc.cookie = -EBUSY;
diff --git a/drivers/dma/dw/acpi.c b/drivers/dma/dw/acpi.c
index c510c109d2c3..b6452fffa657 100644
--- a/drivers/dma/dw/acpi.c
+++ b/drivers/dma/dw/acpi.c
@@ -8,13 +8,15 @@
 
 static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
 {
+	struct dw_dma *dw = to_dw_dma(chan->device);
+	struct dw_dma_chip_pdata *data = dev_get_drvdata(dw->dma.dev);
 	struct acpi_dma_spec *dma_spec = param;
 	struct dw_dma_slave slave = {
 		.dma_dev = dma_spec->dev,
 		.src_id = dma_spec->slave_id,
 		.dst_id = dma_spec->slave_id,
-		.m_master = 0,
-		.p_master = 1,
+		.m_master = data->m_master,
+		.p_master = data->p_master,
 	};
 
 	return dw_dma_filter(chan, &slave);
diff --git a/drivers/dma/dw/internal.h b/drivers/dma/dw/internal.h
index 2e1c52eefdeb..8c79a1d015cd 100644
--- a/drivers/dma/dw/internal.h
+++ b/drivers/dma/dw/internal.h
@@ -51,11 +51,15 @@ struct dw_dma_chip_pdata {
 	int (*probe)(struct dw_dma_chip *chip);
 	int (*remove)(struct dw_dma_chip *chip);
 	struct dw_dma_chip *chip;
+	u8 m_master;
+	u8 p_master;
 };
 
 static __maybe_unused const struct dw_dma_chip_pdata dw_dma_chip_pdata = {
 	.probe = dw_dma_probe,
 	.remove = dw_dma_remove,
+	.m_master = 0,
+	.p_master = 1,
 };
 
 static const struct dw_dma_platform_data idma32_pdata = {
@@ -72,6 +76,8 @@ static __maybe_unused const struct dw_dma_chip_pdata idma32_chip_pdata = {
 	.pdata = &idma32_pdata,
 	.probe = idma32_dma_probe,
 	.remove = idma32_dma_remove,
+	.m_master = 0,
+	.p_master = 0,
 };
 
 #endif /* _DMA_DW_INTERNAL_H */
diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index 1142aa6f8c4a..47f0bbe8b1fe 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -60,10 +60,10 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 	if (ret)
 		return ret;
 
-	dw_dma_acpi_controller_register(chip->dw);
-
 	pci_set_drvdata(pdev, data);
 
+	dw_dma_acpi_controller_register(chip->dw);
+
 	return 0;
 }
 
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 00cd1335eeba..65a7db8bb71b 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1393,6 +1393,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 			irq = irq_of_parse_and_map(np, 0);
 			if (!irq) {
 				ret = -ENODEV;
+				of_node_put(np);
 				goto err_channel_add;
 			}
 
@@ -1401,6 +1402,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 			if (IS_ERR(chan)) {
 				ret = PTR_ERR(chan);
 				irq_dispose_mapping(irq);
+				of_node_put(np);
 				goto err_channel_add;
 			}
 
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index f101dd2819b5..0a1ac11e2e4f 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -147,7 +147,16 @@ int adv7511_hdmi_hw_params(struct device *dev, void *data,
 			   ADV7511_AUDIO_CFG3_LEN_MASK, len);
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG,
 			   ADV7511_I2C_FREQ_ID_CFG_RATE_MASK, rate << 4);
-	regmap_write(adv7511->regmap, 0x73, 0x1);
+
+	/* send current Audio infoframe values while updating */
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
+			   BIT(5), BIT(5));
+
+	regmap_write(adv7511->regmap, ADV7511_REG_AUDIO_INFOFRAME(0), 0x1);
+
+	/* use Audio infoframe updated info */
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
+			   BIT(5), 0);
 
 	return 0;
 }
@@ -178,8 +187,9 @@ static int audio_startup(struct device *dev, void *data)
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(0),
 				BIT(7) | BIT(6), BIT(7));
 	/* use Audio infoframe updated info */
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(1),
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
 				BIT(5), 0);
+
 	/* enable SPDIF receiver */
 	if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
 		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index e0bdedf22390..2cade7ae0c0d 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -191,7 +191,7 @@ int adv7533_parse_dt(struct device_node *np, struct adv7511 *adv)
 
 	of_property_read_u32(np, "adi,dsi-lanes", &num_lanes);
 
-	if (num_lanes < 1 || num_lanes > 4)
+	if (num_lanes < 2 || num_lanes > 4)
 		return -EINVAL;
 
 	adv->num_dsi_lanes = num_lanes;
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 27305f339881..0eb2f30c1e3e 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -318,6 +318,9 @@ static bool drm_dp_decode_sideband_msg_hdr(struct drm_dp_sideband_msg_hdr *hdr,
 	hdr->broadcast = (buf[idx] >> 7) & 0x1;
 	hdr->path_msg = (buf[idx] >> 6) & 0x1;
 	hdr->msg_len = buf[idx] & 0x3f;
+	if (hdr->msg_len < 1)		/* min space for body CRC */
+		return false;
+
 	idx++;
 	hdr->somt = (buf[idx] >> 7) & 0x1;
 	hdr->eomt = (buf[idx] >> 6) & 0x1;
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 754d35a25a1c..cbbb3190d85e 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -750,6 +750,12 @@ hv_kvp_init(struct hv_util_service *srv)
 	 */
 	kvp_transaction.state = HVUTIL_DEVICE_INIT;
 
+	return 0;
+}
+
+int
+hv_kvp_init_transport(void)
+{
 	hvt = hvutil_transport_init(kvp_devname, CN_KVP_IDX, CN_KVP_VAL,
 				    kvp_on_msg, kvp_on_reset);
 	if (!hvt)
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 783779e4cc1a..267fc9327702 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -369,6 +369,12 @@ hv_vss_init(struct hv_util_service *srv)
 	 */
 	vss_transaction.state = HVUTIL_DEVICE_INIT;
 
+	return 0;
+}
+
+int
+hv_vss_init_transport(void)
+{
 	hvt = hvutil_transport_init(vss_devname, CN_VSS_IDX, CN_VSS_VAL,
 				    vss_on_msg, vss_on_reset);
 	if (!hvt) {
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 1b914e418e41..2838134f2a67 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -142,6 +142,7 @@ static struct hv_util_service util_heartbeat = {
 static struct hv_util_service util_kvp = {
 	.util_cb = hv_kvp_onchannelcallback,
 	.util_init = hv_kvp_init,
+	.util_init_transport = hv_kvp_init_transport,
 	.util_pre_suspend = hv_kvp_pre_suspend,
 	.util_pre_resume = hv_kvp_pre_resume,
 	.util_deinit = hv_kvp_deinit,
@@ -150,6 +151,7 @@ static struct hv_util_service util_kvp = {
 static struct hv_util_service util_vss = {
 	.util_cb = hv_vss_onchannelcallback,
 	.util_init = hv_vss_init,
+	.util_init_transport = hv_vss_init_transport,
 	.util_pre_suspend = hv_vss_pre_suspend,
 	.util_pre_resume = hv_vss_pre_resume,
 	.util_deinit = hv_vss_deinit,
@@ -539,6 +541,13 @@ static int util_probe(struct hv_device *dev,
 	if (ret)
 		goto error;
 
+	if (srv->util_init_transport) {
+		ret = srv->util_init_transport();
+		if (ret) {
+			vmbus_close(dev->channel);
+			goto error;
+		}
+	}
 	return 0;
 
 error:
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 601660bca5d4..a785d790e0aa 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -357,12 +357,14 @@ void vmbus_on_event(unsigned long data);
 void vmbus_on_msg_dpc(unsigned long data);
 
 int hv_kvp_init(struct hv_util_service *srv);
+int hv_kvp_init_transport(void);
 void hv_kvp_deinit(void);
 int hv_kvp_pre_suspend(void);
 int hv_kvp_pre_resume(void);
 void hv_kvp_onchannelcallback(void *context);
 
 int hv_vss_init(struct hv_util_service *srv);
+int hv_vss_init_transport(void);
 void hv_vss_deinit(void);
 int hv_vss_pre_suspend(void);
 int hv_vss_pre_resume(void);
diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index b9a93ee9c236..497c45d398e2 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -223,7 +223,7 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 	case TMP51X_REMOTE_TEMP_LIMIT_2:
 	case TMP513_REMOTE_TEMP_LIMIT_3:
 		// 1lsb = 0.0625 degrees centigrade
-		*val = sign_extend32(regval, 16) >> TMP51X_TEMP_SHIFT;
+		*val = sign_extend32(regval, 15) >> TMP51X_TEMP_SHIFT;
 		*val = DIV_ROUND_CLOSEST(*val * 625, 10);
 		break;
 	case TMP51X_N_FACTOR_AND_HYST_1:
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index b6b5a65efcbb..5ff9218b4a62 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -95,7 +95,7 @@ enum {
 
 static inline int wait_timeout(struct i2c_pnx_algo_data *data)
 {
-	long timeout = data->timeout;
+	long timeout = jiffies_to_msecs(data->timeout);
 	while (timeout > 0 &&
 			(ioread32(I2C_REG_STS(data)) & mstatus_active)) {
 		mdelay(1);
@@ -106,7 +106,7 @@ static inline int wait_timeout(struct i2c_pnx_algo_data *data)
 
 static inline int wait_reset(struct i2c_pnx_algo_data *data)
 {
-	long timeout = data->timeout;
+	long timeout = jiffies_to_msecs(data->timeout);
 	while (timeout > 0 &&
 			(ioread32(I2C_REG_CTL(data)) & mcntrl_reset)) {
 		mdelay(1);
diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index d8f252c4caf2..b115bb27bbed 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -323,7 +323,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 		if (brl <= (0x1F + 3))
 			break;
 
-		total_ticks /= 2;
+		total_ticks = DIV_ROUND_UP(total_ticks, 2);
 		rate /= 2;
 	}
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 158f9eadc4e9..6658de58b514 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -161,7 +161,7 @@ static const void __user *uverbs_request_next_ptr(struct uverbs_req_iter *iter,
 {
 	const void __user *res = iter->cur;
 
-	if (iter->cur + len > iter->end)
+	if (len > iter->end - iter->cur)
 		return (void __force __user *)ERR_PTR(-ENOSPC);
 	iter->cur += len;
 	return res;
@@ -2004,11 +2004,13 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	ret = uverbs_request_start(attrs, &iter, &cmd, sizeof(cmd));
 	if (ret)
 		return ret;
-	wqes = uverbs_request_next_ptr(&iter, cmd.wqe_size * cmd.wr_count);
+	wqes = uverbs_request_next_ptr(&iter, size_mul(cmd.wqe_size,
+						       cmd.wr_count));
 	if (IS_ERR(wqes))
 		return PTR_ERR(wqes);
-	sgls = uverbs_request_next_ptr(
-		&iter, cmd.sge_count * sizeof(struct ib_uverbs_sge));
+	sgls = uverbs_request_next_ptr(&iter,
+				       size_mul(cmd.sge_count,
+						sizeof(struct ib_uverbs_sge)));
 	if (IS_ERR(sgls))
 		return PTR_ERR(sgls);
 	ret = uverbs_request_finish(&iter);
@@ -2194,11 +2196,11 @@ ib_uverbs_unmarshall_recv(struct uverbs_req_iter *iter, u32 wr_count,
 	if (wqe_size < sizeof (struct ib_uverbs_recv_wr))
 		return ERR_PTR(-EINVAL);
 
-	wqes = uverbs_request_next_ptr(iter, wqe_size * wr_count);
+	wqes = uverbs_request_next_ptr(iter, size_mul(wqe_size, wr_count));
 	if (IS_ERR(wqes))
 		return ERR_CAST(wqes);
-	sgls = uverbs_request_next_ptr(
-		iter, sge_count * sizeof(struct ib_uverbs_sge));
+	sgls = uverbs_request_next_ptr(iter, size_mul(sge_count,
+						      sizeof(struct ib_uverbs_sge)));
 	if (IS_ERR(sgls))
 		return ERR_CAST(sgls);
 	ret = uverbs_request_finish(iter);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9ffd28ab526a..089d7de829a0 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -137,7 +137,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 
 	ib_attr->vendor_id = rdev->en_dev->pdev->vendor;
 	ib_attr->vendor_part_id = rdev->en_dev->pdev->device;
-	ib_attr->hw_ver = rdev->en_dev->pdev->subsystem_device;
+	ib_attr->hw_ver = rdev->en_dev->pdev->revision;
 	ib_attr->max_qp = dev_attr->max_qp;
 	ib_attr->max_qp_wr = dev_attr->max_qp_wqes;
 	ib_attr->device_cap_flags =
@@ -1938,18 +1938,20 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		}
 	}
 
-	if (qp_attr_mask & IB_QP_PATH_MTU) {
-		qp->qplib_qp.modify_flags |=
-				CMDQ_MODIFY_QP_MODIFY_MASK_PATH_MTU;
-		qp->qplib_qp.path_mtu = __from_ib_mtu(qp_attr->path_mtu);
-		qp->qplib_qp.mtu = ib_mtu_enum_to_int(qp_attr->path_mtu);
-	} else if (qp_attr->qp_state == IB_QPS_RTR) {
-		qp->qplib_qp.modify_flags |=
-			CMDQ_MODIFY_QP_MODIFY_MASK_PATH_MTU;
-		qp->qplib_qp.path_mtu =
-			__from_ib_mtu(iboe_get_mtu(rdev->netdev->mtu));
-		qp->qplib_qp.mtu =
-			ib_mtu_enum_to_int(iboe_get_mtu(rdev->netdev->mtu));
+	if (qp_attr->qp_state == IB_QPS_RTR) {
+		enum ib_mtu qpmtu;
+
+		qpmtu = iboe_get_mtu(rdev->netdev->mtu);
+		if (qp_attr_mask & IB_QP_PATH_MTU) {
+			if (ib_mtu_enum_to_int(qp_attr->path_mtu) >
+			    ib_mtu_enum_to_int(qpmtu))
+				return -EINVAL;
+			qpmtu = qp_attr->path_mtu;
+		}
+
+		qp->qplib_qp.modify_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_PATH_MTU;
+		qp->qplib_qp.path_mtu = __from_ib_mtu(qpmtu);
+		qp->qplib_qp.mtu = ib_mtu_enum_to_int(qpmtu);
 	}
 
 	if (qp_attr_mask & IB_QP_TIMEOUT) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 5f79371a1386..4ed78d25b6e9 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1126,9 +1126,11 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		rq->dbinfo.db = qp->dpi->dbr;
 		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
 	}
+	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 	rcfw->qp_tbl[tbl_indx].qp_handle = (void *)qp;
+	spin_unlock_bh(&rcfw->tbl_lock);
 
 	return 0;
 fail:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index f53d94c812ec..f9ceb19dc993 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -118,7 +118,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	 * 128 WQEs needs to be reserved for the HW (8916). Prevent
 	 * reporting the max number
 	 */
-	attr->max_qp_wqes -= BNXT_QPLIB_RESERVED_QP_WRS;
+	attr->max_qp_wqes -= BNXT_QPLIB_RESERVED_QP_WRS + 1;
 	attr->max_qp_sges = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx) ?
 			    6 : sb->max_sge;
 	attr->max_cq = le32_to_cpu(sb->max_cq);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d36436d4277a..1800cea46b2d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3565,7 +3565,8 @@ static int mlx5_ib_init_multiport_master(struct mlx5_ib_dev *dev)
 		list_for_each_entry(mpi, &mlx5_ib_unaffiliated_port_list,
 				    list) {
 			if (dev->sys_image_guid == mpi->sys_image_guid &&
-			    (mlx5_core_native_port_num(mpi->mdev) - 1) == i) {
+			    (mlx5_core_native_port_num(mpi->mdev) - 1) == i &&
+			    mlx5_core_same_coredev_type(dev->mdev, mpi->mdev)) {
 				bound = mlx5_ib_bind_slave_port(dev, mpi);
 			}
 
@@ -4766,7 +4767,8 @@ static void *mlx5_ib_add_slave_port(struct mlx5_core_dev *mdev)
 
 	mutex_lock(&mlx5_ib_multiport_mutex);
 	list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
-		if (dev->sys_image_guid == mpi->sys_image_guid)
+		if (dev->sys_image_guid == mpi->sys_image_guid &&
+		    mlx5_core_same_coredev_type(dev->mdev, mpi->mdev))
 			bound = mlx5_ib_bind_slave_port(dev, mpi);
 
 		if (bound) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index b152a742cd3c..2b315974f478 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -381,6 +381,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	struct rtrs_srv_mr *srv_mr;
 	bool need_inval = false;
 	enum ib_send_flags flags;
+	struct ib_sge list;
 	u32 imm;
 	int err;
 
@@ -431,7 +432,6 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	imm = rtrs_to_io_rsp_imm(id->msg_id, errno, need_inval);
 	imm_wr.wr.next = NULL;
 	if (always_invalidate) {
-		struct ib_sge list;
 		struct rtrs_msg_rkey_rsp *msg;
 
 		srv_mr = &sess->mrs[id->msg_id];
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 205cbd24ff20..8030bdcd008c 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -62,7 +62,7 @@ static void gic_check_cpu_features(void)
 
 union gic_base {
 	void __iomem *common_base;
-	void __percpu * __iomem *percpu_base;
+	void __iomem * __percpu *percpu_base;
 };
 
 struct gic_chip_data {
diff --git a/drivers/media/dvb-frontends/dib3000mb.c b/drivers/media/dvb-frontends/dib3000mb.c
index c598b2a63325..7c452ddd9e40 100644
--- a/drivers/media/dvb-frontends/dib3000mb.c
+++ b/drivers/media/dvb-frontends/dib3000mb.c
@@ -51,7 +51,7 @@ MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=setfe,8=getfe (|-a
 static int dib3000_read_reg(struct dib3000_state *state, u16 reg)
 {
 	u8 wb[] = { ((reg >> 8) | 0x80) & 0xff, reg & 0xff };
-	u8 rb[2];
+	u8 rb[2] = {};
 	struct i2c_msg msg[] = {
 		{ .addr = state->config.demod_address, .flags = 0,        .buf = wb, .len = 2 },
 		{ .addr = state->config.demod_address, .flags = I2C_M_RD, .buf = rb, .len = 2 },
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index d8fd2b5efd38..e5e3f42edfbf 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1379,7 +1379,6 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
-		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_BROKEN_HS200 |
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 09848d13802d..d1ed5878b3b1 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -380,10 +380,8 @@ atmel_pmecc_create_user(struct atmel_pmecc *pmecc,
 	user->delta = user->dmu + req->ecc.strength + 1;
 
 	gf_tables = atmel_pmecc_get_gf_tables(req);
-	if (IS_ERR(gf_tables)) {
-		kfree(user);
+	if (IS_ERR(gf_tables))
 		return ERR_CAST(gf_tables);
-	}
 
 	user->gf_tables = gf_tables;
 
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 9ee7daa6fa3c..9ba9b7df5af5 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1098,7 +1098,7 @@ static inline int __init inftl_partscan(struct mtd_info *mtd, struct mtd_partiti
 		    (i == 0) && (ip->firstUnit > 0)) {
 			parts[0].name = " DiskOnChip IPL / Media Header partition";
 			parts[0].offset = 0;
-			parts[0].size = mtd->erasesize * ip->firstUnit;
+			parts[0].size = (uint64_t)mtd->erasesize * ip->firstUnit;
 			numparts = 1;
 		}
 
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index ae1cf2ead9a9..1c6b7808a100 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1951,7 +1951,11 @@ static int bcm_sysport_open(struct net_device *dev)
 	unsigned int i;
 	int ret;
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		netdev_err(dev, "could not enable priv clock\n");
+		return ret;
+	}
 
 	/* Reset UniMAC */
 	umac_reset(priv);
@@ -2622,7 +2626,11 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 		goto err_deregister_notifier;
 	}
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not enable priv clock\n");
+		goto err_deregister_netdev;
+	}
 
 	priv->rev = topctrl_readl(priv, REV_CNTL) & REV_MASK;
 	dev_info(&pdev->dev,
@@ -2636,6 +2644,8 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_deregister_netdev:
+	unregister_netdev(dev);
 err_deregister_notifier:
 	unregister_dsa_notifier(&priv->dsa_notifier);
 err_deregister_fixed_link:
@@ -2807,7 +2817,12 @@ static int __maybe_unused bcm_sysport_resume(struct device *d)
 	if (!netif_running(dev))
 		return 0;
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		netdev_err(dev, "could not enable priv clock\n");
+		return ret;
+	}
+
 	if (priv->wolopts)
 		clk_disable_unprepare(priv->wol_clk);
 
diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index f37f1c58f368..c2e0bc1326fe 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -171,6 +171,7 @@ static int platform_phy_connect(struct bgmac *bgmac)
 static int bgmac_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct device_node *phy_node;
 	struct bgmac *bgmac;
 	struct resource *regs;
 	const u8 *mac_addr;
@@ -232,7 +233,9 @@ static int bgmac_probe(struct platform_device *pdev)
 	bgmac->cco_ctl_maskset = platform_bgmac_cco_ctl_maskset;
 	bgmac->get_bus_clock = platform_bgmac_get_bus_clock;
 	bgmac->cmn_maskset32 = platform_bgmac_cmn_maskset32;
-	if (of_parse_phandle(np, "phy-handle", 0)) {
+	phy_node = of_parse_phandle(np, "phy-handle", 0);
+	if (phy_node) {
+		of_node_put(phy_node);
 		bgmac->phy_connect = platform_phy_connect;
 	} else {
 		bgmac->phy_connect = bgmac_phy_connect_direct;
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
index 9098b3eed4da..b8ff28929dcd 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
@@ -346,8 +346,9 @@ static struct sk_buff *copy_gl_to_skb_pkt(const struct pkt_gl *gl,
 	 * driver. Once driver synthesizes cpl_pass_accpet_req the skb will go
 	 * through the regular cpl_pass_accept_req processing in TOM.
 	 */
-	skb = alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req)
-			- pktshift, GFP_ATOMIC);
+	skb = alloc_skb(size_add(gl->tot_len,
+				 sizeof(struct cpl_pass_accept_req)) -
+			pktshift, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 	__skb_put(skb, gl->tot_len + sizeof(struct cpl_pass_accept_req)
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 6ec042d48cd1..dd5c96557976 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -173,6 +173,7 @@ static int create_txqs(struct hinic_dev *nic_dev)
 	hinic_sq_dbgfs_uninit(nic_dev);
 
 	devm_kfree(&netdev->dev, nic_dev->txqs);
+	nic_dev->txqs = NULL;
 	return err;
 }
 
@@ -269,6 +270,7 @@ static int create_rxqs(struct hinic_dev *nic_dev)
 	hinic_rq_dbgfs_uninit(nic_dev);
 
 	devm_kfree(&netdev->dev, nic_dev->rxqs);
+	nic_dev->rxqs = NULL;
 	return err;
 }
 
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 25981a7a43b5..7f278cc42dc7 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -130,6 +130,7 @@ static const struct pci_device_id sky2_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x436C) }, /* 88E8072 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x436D) }, /* 88E8055 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4370) }, /* 88E8075 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4373) }, /* 88E8075 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4380) }, /* 88E8057 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4381) }, /* 88E8059 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4382) }, /* 88E8079 */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 8e5b01af85ed..d0a613fac9ff 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -835,8 +835,8 @@ static int ionic_get_module_eeprom(struct net_device *netdev,
 	len = min_t(u32, sizeof(xcvr->sprom), ee->len);
 
 	do {
-		memcpy(data, xcvr->sprom, len);
-		memcpy(tbuf, xcvr->sprom, len);
+		memcpy(data, &xcvr->sprom[ee->offset], len);
+		memcpy(tbuf, &xcvr->sprom[ee->offset], len);
 
 		/* Let's make sure we got a consistent copy */
 		if (!memcmp(data, tbuf, len))
diff --git a/drivers/net/netdevsim/health.c b/drivers/net/netdevsim/health.c
index 21e2974660e7..c9306506b741 100644
--- a/drivers/net/netdevsim/health.c
+++ b/drivers/net/netdevsim/health.c
@@ -235,15 +235,12 @@ static ssize_t nsim_dev_health_break_write(struct file *file,
 	char *break_msg;
 	int err;
 
-	break_msg = kmalloc(count + 1, GFP_KERNEL);
-	if (!break_msg)
-		return -ENOMEM;
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+	break_msg = memdup_user_nul(data, count);
+	if (IS_ERR(break_msg))
+		return PTR_ERR(break_msg);
 
-	if (copy_from_user(break_msg, data, count)) {
-		err = -EFAULT;
-		goto out;
-	}
-	break_msg[count] = '\0';
 	if (break_msg[count - 1] == '\n')
 		break_msg[count - 1] = '\0';
 
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index a6953ac95eec..b271e6da2924 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1306,6 +1306,9 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c0, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c4, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c8, 0)}, /* Telit FE910C04 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
diff --git a/drivers/of/address.c b/drivers/of/address.c
index f686fb5011b8..7e2bfbb22430 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -641,7 +641,7 @@ static struct device_node *__of_get_dma_parent(const struct device_node *np)
 	if (ret < 0)
 		return of_get_parent(np);
 
-	return of_node_get(args.np);
+	return args.np;
 }
 
 static struct device_node *of_get_next_dma_parent(struct device_node *np)
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 0e428880d88b..5182b6229dd9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1621,8 +1621,10 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 			map_len--;
 
 			/* Check if not found */
-			if (!new)
+			if (!new) {
+				ret = -EINVAL;
 				goto put;
+			}
 
 			if (!of_device_is_available(new))
 				match = 0;
@@ -1632,17 +1634,20 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 				goto put;
 
 			/* Check for malformed properties */
-			if (WARN_ON(new_size > MAX_PHANDLE_ARGS))
-				goto put;
-			if (map_len < new_size)
+			if (WARN_ON(new_size > MAX_PHANDLE_ARGS) ||
+			    map_len < new_size) {
+				ret = -EINVAL;
 				goto put;
+			}
 
 			/* Move forward by new node's #<list>-cells amount */
 			map += new_size;
 			map_len -= new_size;
 		}
-		if (!match)
+		if (!match) {
+			ret = -ENOENT;
 			goto put;
+		}
 
 		/* Get the <list>-map-pass-thru property (optional) */
 		pass = of_get_property(cur, pass_name, NULL);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index f59bbcc94430..ddb3ed0483d9 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -298,6 +298,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 		return of_irq_parse_oldworld(device, index, out_irq);
 
 	/* Get the reg property (if any) */
+	addr_len = 0;
 	addr = of_get_property(device, "reg", &addr_len);
 
 	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 6ce34a1deecb..2525bd043261 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -71,10 +71,6 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-	/* Do not reassign resources if probe only */
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d58b02237075..974d56644973 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1373,6 +1373,22 @@ static int aer_probe(struct pcie_device *dev)
 	return 0;
 }
 
+static int aer_suspend(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_disable_rootport(rpc);
+	return 0;
+}
+
+static int aer_resume(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_enable_rootport(rpc);
+	return 0;
+}
+
 /**
  * aer_root_reset - reset Root Port hierarchy or RCEC
  * @dev: pointer to Root Port or RCEC
@@ -1431,6 +1447,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 };
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 02a75f3b5920..b0ac721e047d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3018,20 +3018,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
 	bus = bridge->bus;
 
+	/* If we must preserve the resource configuration, claim now */
+	if (bridge->preserve_config)
+		pci_bus_claim_resources(bus);
+
 	/*
-	 * We insert PCI resources into the iomem_resource and
-	 * ioport_resource trees in either pci_bus_claim_resources()
-	 * or pci_bus_assign_resources().
+	 * Assign whatever was left unassigned. If we didn't claim above,
+	 * this will reassign everything.
 	 */
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_claim_resources(bus);
-	} else {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
+	pci_assign_unassigned_root_bus_resources(bus);
 
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
 	return 0;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 37cc08d70636..7c65513e55c2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4956,6 +4956,10 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_BROADCOM, 0x1750, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1751, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1752, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1760, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1761, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
 	/* Amazon Annapurna Labs */
 	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 71cb10826326..1bcdef37e8aa 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -138,8 +138,10 @@ static struct phy_provider *of_phy_provider_lookup(struct device_node *node)
 			return phy_provider;
 
 		for_each_child_of_node(phy_provider->children, child)
-			if (child == node)
+			if (child == node) {
+				of_node_put(child);
 				return phy_provider;
+			}
 	}
 
 	return ERR_PTR(-EPROBE_DEFER);
@@ -507,8 +509,10 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 		return ERR_PTR(-ENODEV);
 
 	/* This phy type handled by the usb-phy subsystem for now */
-	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
-		return ERR_PTR(-ENODEV);
+	if (of_device_is_compatible(args.np, "usb-nop-xceiv")) {
+		phy = ERR_PTR(-ENODEV);
+		goto out_put_node;
+	}
 
 	mutex_lock(&phy_provider_mutex);
 	phy_provider = of_phy_provider_lookup(args.np);
@@ -530,6 +534,7 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 
 out_unlock:
 	mutex_unlock(&phy_provider_mutex);
+out_put_node:
 	of_node_put(args.np);
 
 	return phy;
@@ -615,7 +620,7 @@ void devm_phy_put(struct device *dev, struct phy *phy)
 	if (!phy)
 		return;
 
-	r = devres_destroy(dev, devm_phy_release, devm_phy_match, phy);
+	r = devres_release(dev, devm_phy_release, devm_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_phy_put);
@@ -986,7 +991,7 @@ void devm_phy_destroy(struct device *dev, struct phy *phy)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_phy_consume, devm_phy_match, phy);
+	r = devres_release(dev, devm_phy_consume, devm_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_phy_destroy);
@@ -1124,12 +1129,12 @@ EXPORT_SYMBOL_GPL(of_phy_provider_unregister);
  * of_phy_provider_unregister to unregister the phy provider.
  */
 void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider)
+				     struct phy_provider *phy_provider)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_phy_provider_release, devm_phy_match,
-		phy_provider);
+	r = devres_release(dev, devm_phy_provider_release, devm_phy_match,
+			   phy_provider);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY provider device resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_provider_unregister);
diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index d0259577934e..8b406f0949ea 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -84,6 +84,7 @@ const struct regmap_config mcp23x08_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(mcp23x08_defaults),
 	.cache_type = REGCACHE_FLAT,
 	.max_register = MCP_OLAT,
+	.disable_locking = true, /* mcp->lock protects the regmap */
 };
 EXPORT_SYMBOL_GPL(mcp23x08_regmap);
 
@@ -130,6 +131,7 @@ const struct regmap_config mcp23x17_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(mcp23x17_defaults),
 	.cache_type = REGCACHE_FLAT,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.disable_locking = true, /* mcp->lock protects the regmap */
 };
 EXPORT_SYMBOL_GPL(mcp23x17_regmap);
 
@@ -227,7 +229,9 @@ static int mcp_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_PULL_UP:
+		mutex_lock(&mcp->lock);
 		ret = mcp_read(mcp, MCP_GPPU, &data);
+		mutex_unlock(&mcp->lock);
 		if (ret < 0)
 			return ret;
 		status = (data & BIT(pin)) ? 1 : 0;
@@ -256,7 +260,9 @@ static int mcp_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_PULL_UP:
+			mutex_lock(&mcp->lock);
 			ret = mcp_set_bit(mcp, MCP_GPPU, pin, arg);
+			mutex_unlock(&mcp->lock);
 			break;
 		default:
 			dev_dbg(mcp->dev, "Invalid config param %04x\n", param);
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 49505939352a..224c1f1c271b 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -574,6 +574,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
+	{ KE_IGNORE, 0xCF, },	/* AC mode */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
 	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
 	{ KE_END, 0},
diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 68212b39785b..6139f736ecbe 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -67,6 +67,14 @@ static int set_charge_current_limit(struct gpio_charger *gpio_charger, int val)
 		if (gpio_charger->current_limit_map[i].limit_ua <= val)
 			break;
 	}
+
+	/*
+	 * If a valid charge current limit isn't found, default to smallest
+	 * current limitation for safety reasons.
+	 */
+	if (i >= gpio_charger->current_limit_map_size)
+		i = gpio_charger->current_limit_map_size - 1;
+
 	mapping = gpio_charger->current_limit_map[i];
 
 	for (i = 0; i < ndescs; i++) {
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 365279d7c982..d709d261d0ad 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -8868,8 +8868,11 @@ megasas_aen_polling(struct work_struct *work)
 						   (ld_target_id / MEGASAS_MAX_DEV_PER_CHANNEL),
 						   (ld_target_id - MEGASAS_MAX_DEV_PER_CHANNEL),
 						   0);
-			if (sdev1)
+			if (sdev1) {
+				mutex_unlock(&instance->reset_mutex);
 				megasas_remove_scsi_device(sdev1);
+				mutex_lock(&instance->reset_mutex);
+			}
 
 			event_type = SCAN_VD_CHANNEL;
 			break;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 53528711dac1..768635de93da 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -6008,11 +6008,12 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 	int i;
 	u8 failed;
 	__le32 *mfp;
+	int ret_val;
 
 	/* make sure doorbell is not in use */
 	if ((ioc->base_readl_ext_retry(&ioc->chip->Doorbell) & MPI2_DOORBELL_USED)) {
 		ioc_err(ioc, "doorbell is in use (line=%d)\n", __LINE__);
-		return -EFAULT;
+		goto doorbell_diag_reset;
 	}
 
 	/* clear pending doorbell interrupts from previous state changes */
@@ -6102,6 +6103,10 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 			    le32_to_cpu(mfp[i]));
 	}
 	return 0;
+
+doorbell_diag_reset:
+	ret_val = _base_diag_reset(ioc);
+	return ret_val;
 }
 
 /**
diff --git a/drivers/scsi/qla1280.h b/drivers/scsi/qla1280.h
index e7820b5bca38..c0a9251b2bed 100644
--- a/drivers/scsi/qla1280.h
+++ b/drivers/scsi/qla1280.h
@@ -117,12 +117,12 @@ struct device_reg {
 	uint16_t id_h;		/* ID high */
 	uint16_t cfg_0;		/* Configuration 0 */
 #define ISP_CFG0_HWMSK   0x000f	/* Hardware revision mask */
-#define ISP_CFG0_1020    BIT_0	/* ISP1020 */
-#define ISP_CFG0_1020A	 BIT_1	/* ISP1020A */
-#define ISP_CFG0_1040	 BIT_2	/* ISP1040 */
-#define ISP_CFG0_1040A	 BIT_3	/* ISP1040A */
-#define ISP_CFG0_1040B	 BIT_4	/* ISP1040B */
-#define ISP_CFG0_1040C	 BIT_5	/* ISP1040C */
+#define ISP_CFG0_1020	 1	/* ISP1020 */
+#define ISP_CFG0_1020A	 2	/* ISP1020A */
+#define ISP_CFG0_1040	 3	/* ISP1040 */
+#define ISP_CFG0_1040A	 4	/* ISP1040A */
+#define ISP_CFG0_1040B	 5	/* ISP1040B */
+#define ISP_CFG0_1040C	 6	/* ISP1040C */
 	uint16_t cfg_1;		/* Configuration 1 */
 #define ISP_CFG1_F128    BIT_6  /* 128-byte FIFO threshold */
 #define ISP_CFG1_F64     BIT_4|BIT_5 /* 128-byte FIFO threshold */
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 37ad5f525647..7dc916ce0c3c 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -155,6 +155,8 @@ static int sense_buffer_size = PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE;
 */
 static int vmstor_proto_version;
 
+static bool hv_dev_is_fc(struct hv_device *hv_dev);
+
 #define STORVSC_LOGGING_NONE	0
 #define STORVSC_LOGGING_ERROR	1
 #define STORVSC_LOGGING_WARN	2
@@ -1153,6 +1155,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	 * not correctly handle:
 	 * INQUIRY command with page code parameter set to 0x80
 	 * MODE_SENSE command with cmd[2] == 0x1c
+	 * MAINTENANCE_IN is not supported by HyperV FC passthrough
 	 *
 	 * Setup srb and scsi status so this won't be fatal.
 	 * We do this so we can distinguish truly fatal failues
@@ -1160,7 +1163,9 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	 */
 
 	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
-	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE)) {
+	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE) ||
+	   (stor_pkt->vm_srb.cdb[0] == MAINTENANCE_IN &&
+	   hv_dev_is_fc(device))) {
 		vstor_packet->vm_srb.scsi_status = 0;
 		vstor_packet->vm_srb.srb_status = SRB_STATUS_SUCCESS;
 	}
diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index d996782a7106..7a73f5e4a1fc 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -295,7 +295,7 @@ int clk_enable(struct clk *clk)
 	int ret;
 
 	if (!clk)
-		return -EINVAL;
+		return 0;
 
 	spin_lock_irqsave(&clock_lock, flags);
 	ret = __clk_enable(clk);
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 90f1d9a53461..51e3ac78c022 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -2290,6 +2290,13 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 	case PCI_DEVICE_ID_INTEL_TGL_NHI1:
 	case PCI_DEVICE_ID_INTEL_TGL_H_NHI0:
 	case PCI_DEVICE_ID_INTEL_TGL_H_NHI1:
+	case PCI_DEVICE_ID_INTEL_ADL_NHI0:
+	case PCI_DEVICE_ID_INTEL_ADL_NHI1:
+	case PCI_DEVICE_ID_INTEL_RPL_NHI0:
+	case PCI_DEVICE_ID_INTEL_RPL_NHI1:
+	case PCI_DEVICE_ID_INTEL_MTL_M_NHI0:
+	case PCI_DEVICE_ID_INTEL_MTL_P_NHI0:
+	case PCI_DEVICE_ID_INTEL_MTL_P_NHI1:
 		icm->is_supported = icm_tgl_is_supported;
 		icm->driver_ready = icm_icl_driver_ready;
 		icm->set_uuid = icm_icl_set_uuid;
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index fd1b59397c70..710c905a62d8 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1349,6 +1349,34 @@ static struct pci_device_id nhi_ids[] = {
 	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TGL_H_NHI1),
 	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL_NHI1),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_RPL_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_RPL_NHI1),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MTL_M_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MTL_P_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MTL_P_NHI1),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_LNL_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_LNL_NHI1),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_PTL_M_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_PTL_M_NHI1),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_PTL_P_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_PTL_P_NHI1),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI) },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI) },
 
 	/* Any USB4 compliant host */
 	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_USB4, ~0) },
diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 7ad6d3f0583b..67ecee94d7b9 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -73,12 +73,27 @@ extern const struct tb_nhi_ops icl_nhi_ops;
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE	0x15ea
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI		0x15eb
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE	0x15ef
+#define PCI_DEVICE_ID_INTEL_ADL_NHI0			0x463e
+#define PCI_DEVICE_ID_INTEL_ADL_NHI1			0x466d
+#define PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI	0x5781
+#define PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI	0x5784
+#define PCI_DEVICE_ID_INTEL_MTL_M_NHI0			0x7eb2
+#define PCI_DEVICE_ID_INTEL_MTL_P_NHI0			0x7ec2
+#define PCI_DEVICE_ID_INTEL_MTL_P_NHI1			0x7ec3
 #define PCI_DEVICE_ID_INTEL_ICL_NHI1			0x8a0d
 #define PCI_DEVICE_ID_INTEL_ICL_NHI0			0x8a17
 #define PCI_DEVICE_ID_INTEL_TGL_NHI0			0x9a1b
 #define PCI_DEVICE_ID_INTEL_TGL_NHI1			0x9a1d
 #define PCI_DEVICE_ID_INTEL_TGL_H_NHI0			0x9a1f
 #define PCI_DEVICE_ID_INTEL_TGL_H_NHI1			0x9a21
+#define PCI_DEVICE_ID_INTEL_RPL_NHI0			0xa73e
+#define PCI_DEVICE_ID_INTEL_RPL_NHI1			0xa76d
+#define PCI_DEVICE_ID_INTEL_LNL_NHI0			0xa833
+#define PCI_DEVICE_ID_INTEL_LNL_NHI1			0xa834
+#define PCI_DEVICE_ID_INTEL_PTL_M_NHI0			0xe333
+#define PCI_DEVICE_ID_INTEL_PTL_M_NHI1			0xe334
+#define PCI_DEVICE_ID_INTEL_PTL_P_NHI0			0xe433
+#define PCI_DEVICE_ID_INTEL_PTL_P_NHI1			0xe434
 
 #define PCI_CLASS_SERIAL_USB_USB4			0x0c0340
 
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 0d87871499ea..1cecc9721423 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -44,6 +44,7 @@ struct cdns3_platform_data {
 			bool suspend, bool wakeup);
 	unsigned long quirks;
 #define CDNS3_DEFAULT_PM_RUNTIME_ALLOW	BIT(0)
+#define CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE	BIT(1)
 };
 
 /**
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 95863d44e3e0..7f33fe02c0ea 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -358,7 +358,7 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 int cdns3_drd_init(struct cdns3 *cdns)
 {
 	void __iomem *regs;
-	u32 state;
+	u32 state, reg;
 	int ret;
 
 	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
@@ -400,6 +400,14 @@ int cdns3_drd_init(struct cdns3 *cdns)
 			cdns->otg_irq_regs = (struct cdns3_otg_irq_regs *)
 					      &cdns->otg_v1_regs->ien;
 			writel(1, &cdns->otg_v1_regs->simulate);
+
+			if (cdns->pdata &&
+			    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
+				reg = readl(&cdns->otg_v1_regs->susp_ctrl);
+				reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
+				writel(reg, &cdns->otg_v1_regs->susp_ctrl);
+			}
+
 			cdns->version  = CDNS3_CONTROLLER_V1;
 		}
 
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index a767b6893938..729374f12cd7 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -190,6 +190,9 @@ struct cdns3_otg_irq_regs {
 /* OTGREFCLK - bitmasks */
 #define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
 
+/* SUPS_CTRL - bitmasks */
+#define SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE	BIT(17)
+
 /* OVERRIDE - bitmasks */
 #define OVERRIDE_IDPULLUP		BIT(0)
 /* Only for CDNS3_CONTROLLER_V0 version */
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index d8b83665581f..af8a0bb5c508 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -886,10 +886,10 @@ static void dwc2_gadget_config_nonisoc_xfer_ddma(struct dwc2_hsotg_ep *hs_ep,
 	}
 
 	/* DMA sg buffer */
-	for_each_sg(ureq->sg, sg, ureq->num_sgs, i) {
+	for_each_sg(ureq->sg, sg, ureq->num_mapped_sgs, i) {
 		dwc2_gadget_fill_nonisoc_xfer_ddma_one(hs_ep, &desc,
 			sg_dma_address(sg) + sg->offset, sg_dma_len(sg),
-			sg_is_last(sg));
+			(i == (ureq->num_mapped_sgs - 1)));
 		desc_count += hs_ep->desc_count;
 	}
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 7ae20070608f..a5802ec8d53f 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -625,6 +625,8 @@ static void option_instat_callback(struct urb *urb);
 #define MEIGSMART_PRODUCT_SRM825L		0x4d22
 /* MeiG Smart SLM320 based on UNISOC UIS8910 */
 #define MEIGSMART_PRODUCT_SLM320		0x4d41
+/* MeiG Smart SLM770A based on ASR1803 */
+#define MEIGSMART_PRODUCT_SLM770A		0x4d57
 
 /* Device flags */
 
@@ -1395,6 +1397,12 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c0, 0xff),	/* Telit FE910C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c4, 0xff),	/* Telit FE910C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c8, 0xff),	/* Telit FE910C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
@@ -2247,6 +2255,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7127, 0xff, 0x00, 0x00),
 	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7129, 0xff, 0x00, 0x00),        /* MediaTek T7XX  */
+	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MEN200) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MPL200),
 	  .driver_info = RSVD(1) | RSVD(4) },
@@ -2375,6 +2385,18 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Golbal EDU */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010a, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WRD for WWAN Ready */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010a, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010a, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010b, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for WWAN Ready */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010b, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010b, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010c, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WRD for WWAN Ready */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010c, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010c, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010d, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for WWAN Ready */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010d, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010d, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
@@ -2382,9 +2404,14 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM770A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
+	  .driver_info = NCTRL(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */
+	  .driver_info = NCTRL(3) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 6340ca058f89..da9e24e4a8b6 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -20,6 +20,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bits.h>
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -40,6 +42,7 @@
 #define VAL		0x2f
 
 /* Logical device Numbers LDN */
+#define EC		0x04
 #define GPIO		0x07
 
 /* Configuration Registers and Functions */
@@ -71,6 +74,12 @@
 #define IT8784_ID	0x8784
 #define IT8786_ID	0x8786
 
+/* Environment Controller Configuration Registers LDN=0x04 */
+#define SCR1		0xfa
+
+/* Environment Controller Bits SCR1 */
+#define WDT_PWRGD	0x20
+
 /* GPIO Configuration Registers LDN=0x07 */
 #define WDTCTRL		0x71
 #define WDTCFG		0x72
@@ -241,6 +250,21 @@ static int wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
 	return ret;
 }
 
+enum {
+	IT87_WDT_OUTPUT_THROUGH_PWRGD	= BIT(0),
+};
+
+static const struct dmi_system_id it87_quirks[] = {
+	{
+		/* Qotom Q30900P (IT8786) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "QCML04"),
+		},
+		.driver_data = (void *)IT87_WDT_OUTPUT_THROUGH_PWRGD,
+	},
+	{}
+};
+
 static const struct watchdog_info ident = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.firmware_version = 1,
@@ -262,8 +286,10 @@ static struct watchdog_device wdt_dev = {
 
 static int __init it87_wdt_init(void)
 {
+	const struct dmi_system_id *dmi_id;
 	u8  chip_rev;
 	u8 ctrl;
+	int quirks = 0;
 	int rc;
 
 	rc = superio_enter();
@@ -274,6 +300,10 @@ static int __init it87_wdt_init(void)
 	chip_rev  = superio_inb(CHIPREV) & 0x0f;
 	superio_exit();
 
+	dmi_id = dmi_first_match(it87_quirks);
+	if (dmi_id)
+		quirks = (long)dmi_id->driver_data;
+
 	switch (chip_type) {
 	case IT8702_ID:
 		max_units = 255;
@@ -334,6 +364,15 @@ static int __init it87_wdt_init(void)
 		superio_outb(0x00, WDTCTRL);
 	}
 
+	if (quirks & IT87_WDT_OUTPUT_THROUGH_PWRGD) {
+		superio_select(EC);
+		ctrl = superio_inb(SCR1);
+		if (!(ctrl & WDT_PWRGD)) {
+			ctrl |= WDT_PWRGD;
+			superio_outb(ctrl, SCR1);
+		}
+	}
+
 	superio_exit();
 
 	if (timeout < 1 || timeout > max_units * 60) {
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f1731eeb86a7..e68970674344 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1382,14 +1382,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 					goto out;
 				}
 
-				if (!path->skip_locking) {
+				if (!path->skip_locking)
 					btrfs_tree_read_lock(eb);
-					btrfs_set_lock_blocking_read(eb);
-				}
 				ret = find_extent_in_eb(eb, bytenr,
 							*extent_item_pos, &eie, ignore_offset);
 				if (!path->skip_locking)
-					btrfs_tree_read_unlock_blocking(eb);
+					btrfs_tree_read_unlock(eb);
 				free_extent_buffer(eb);
 				if (ret < 0)
 					goto out;
@@ -1732,7 +1730,7 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 					   name_off, name_len);
 		if (eb != eb_in) {
 			if (!path->skip_locking)
-				btrfs_tree_read_unlock_blocking(eb);
+				btrfs_tree_read_unlock(eb);
 			free_extent_buffer(eb);
 		}
 		ret = btrfs_find_item(fs_root, path, parent, 0,
@@ -1752,8 +1750,6 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 		eb = path->nodes[0];
 		/* make sure we can use eb after releasing the path */
 		if (eb != eb_in) {
-			if (!path->skip_locking)
-				btrfs_set_lock_blocking_read(eb);
 			path->nodes[0] = NULL;
 			path->locks[0] = 0;
 		}
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 814f2f07e74c..5db0e078f68a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1009,13 +1009,13 @@ static struct extent_buffer *alloc_tree_block_no_bg_flush(
  * bytes the allocator should try to find free next to the block it returns.
  * This is just a hint and may be ignored by the allocator.
  */
-static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root,
-			     struct extent_buffer *buf,
-			     struct extent_buffer *parent, int parent_slot,
-			     struct extent_buffer **cow_ret,
-			     u64 search_start, u64 empty_size,
-			     enum btrfs_lock_nesting nest)
+int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root,
+			  struct extent_buffer *buf,
+			  struct extent_buffer *parent, int parent_slot,
+			  struct extent_buffer **cow_ret,
+			  u64 search_start, u64 empty_size,
+			  enum btrfs_lock_nesting nest)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_disk_key disk_key;
@@ -1119,6 +1119,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		btrfs_free_tree_block(trans, root, buf, parent_start,
 				      last_ref);
 	}
+
+	trace_btrfs_cow_block(root, buf, cow);
 	if (unlock_orig)
 		btrfs_tree_unlock(buf);
 	free_extent_buffer_stale(buf);
@@ -1281,14 +1283,11 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	if (!tm)
 		return eb;
 
-	btrfs_set_path_blocking(path);
-	btrfs_set_lock_blocking_read(eb);
-
 	if (tm->op == MOD_LOG_KEY_REMOVE_WHILE_FREEING) {
 		BUG_ON(tm->slot != 0);
 		eb_rewin = alloc_dummy_extent_buffer(fs_info, eb->start);
 		if (!eb_rewin) {
-			btrfs_tree_read_unlock_blocking(eb);
+			btrfs_tree_read_unlock(eb);
 			free_extent_buffer(eb);
 			return NULL;
 		}
@@ -1300,13 +1299,13 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	} else {
 		eb_rewin = btrfs_clone_extent_buffer(eb);
 		if (!eb_rewin) {
-			btrfs_tree_read_unlock_blocking(eb);
+			btrfs_tree_read_unlock(eb);
 			free_extent_buffer(eb);
 			return NULL;
 		}
 	}
 
-	btrfs_tree_read_unlock_blocking(eb);
+	btrfs_tree_read_unlock(eb);
 	free_extent_buffer(eb);
 
 	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb_rewin),
@@ -1398,9 +1397,8 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 		free_extent_buffer(eb_root);
 		eb = alloc_dummy_extent_buffer(fs_info, logical);
 	} else {
-		btrfs_set_lock_blocking_read(eb_root);
 		eb = btrfs_clone_extent_buffer(eb_root);
-		btrfs_tree_read_unlock_blocking(eb_root);
+		btrfs_tree_read_unlock(eb_root);
 		free_extent_buffer(eb_root);
 	}
 
@@ -1473,7 +1471,7 @@ static inline int should_cow_block(struct btrfs_trans_handle *trans,
 }
 
 /*
- * cows a single block, see __btrfs_cow_block for the real work.
+ * COWs a single block, see btrfs_force_cow_block() for the real work.
  * This version of it has extra checks so that a block isn't COWed more than
  * once per transaction, as long as it hasn't been written yet
  */
@@ -1485,7 +1483,6 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 search_start;
-	int ret;
 
 	if (test_bit(BTRFS_ROOT_DELETING, &root->state))
 		btrfs_err(fs_info,
@@ -1508,10 +1505,6 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	search_start = buf->start & ~((u64)SZ_1G - 1);
 
-	if (parent)
-		btrfs_set_lock_blocking_write(parent);
-	btrfs_set_lock_blocking_write(buf);
-
 	/*
 	 * Before CoWing this block for later modification, check if it's
 	 * the subtree root and do the delayed subtree trace if needed.
@@ -1519,12 +1512,8 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	 * Also We don't care about the error, as it's handled internally.
 	 */
 	btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
-	ret = __btrfs_cow_block(trans, root, buf, parent,
-				 parent_slot, cow_ret, search_start, 0, nest);
-
-	trace_btrfs_cow_block(root, buf, *cow_ret);
-
-	return ret;
+	return btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
+				     cow_ret, search_start, 0, nest);
 }
 
 /*
@@ -1629,8 +1618,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	if (parent_nritems <= 1)
 		return 0;
 
-	btrfs_set_lock_blocking_write(parent);
-
 	for (i = start_slot; i <= end_slot; i++) {
 		struct btrfs_key first_key;
 		int close = 1;
@@ -1688,12 +1675,11 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 			search_start = last_block;
 
 		btrfs_tree_lock(cur);
-		btrfs_set_lock_blocking_write(cur);
-		err = __btrfs_cow_block(trans, root, cur, parent, i,
-					&cur, search_start,
-					min(16 * blocksize,
-					    (end_slot - i) * blocksize),
-					BTRFS_NESTING_COW);
+		err = btrfs_force_cow_block(trans, root, cur, parent, i,
+					    &cur, search_start,
+					    min(16 * blocksize,
+						(end_slot - i) * blocksize),
+					    BTRFS_NESTING_COW);
 		if (err) {
 			btrfs_tree_unlock(cur);
 			free_extent_buffer(cur);
@@ -1860,8 +1846,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 	mid = path->nodes[level];
 
-	WARN_ON(path->locks[level] != BTRFS_WRITE_LOCK &&
-		path->locks[level] != BTRFS_WRITE_LOCK_BLOCKING);
+	WARN_ON(path->locks[level] != BTRFS_WRITE_LOCK);
 	WARN_ON(btrfs_header_generation(mid) != trans->transid);
 
 	orig_ptr = btrfs_node_blockptr(mid, orig_slot);
@@ -1890,7 +1875,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_tree_lock(child);
-		btrfs_set_lock_blocking_write(child);
 		ret = btrfs_cow_block(trans, root, child, mid, 0, &child,
 				      BTRFS_NESTING_COW);
 		if (ret) {
@@ -1929,7 +1913,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 	if (left) {
 		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
-		btrfs_set_lock_blocking_write(left);
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left,
 				       BTRFS_NESTING_LEFT_COW);
@@ -1945,7 +1928,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 	if (right) {
 		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
-		btrfs_set_lock_blocking_write(right);
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right,
 				       BTRFS_NESTING_RIGHT_COW);
@@ -2109,7 +2091,6 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		u32 left_nr;
 
 		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
-		btrfs_set_lock_blocking_write(left);
 
 		left_nr = btrfs_header_nritems(left);
 		if (left_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
@@ -2164,7 +2145,6 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		u32 right_nr;
 
 		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
-		btrfs_set_lock_blocking_write(right);
 
 		right_nr = btrfs_header_nritems(right);
 		if (right_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
@@ -2424,14 +2404,6 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			return 0;
 		}
 
-		/* the pages were up to date, but we failed
-		 * the generation number check.  Do a full
-		 * read for the generation number that is correct.
-		 * We must do this without dropping locks so
-		 * we can trust our generation number
-		 */
-		btrfs_set_path_blocking(p);
-
 		/* now we're allowed to do a blocking uptodate check */
 		ret = btrfs_read_buffer(tmp, gen, parent_level - 1, &first_key);
 		if (!ret) {
@@ -2451,7 +2423,6 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	 * out which blocks to read.
 	 */
 	btrfs_unlock_up_safe(p, level + 1);
-	btrfs_set_path_blocking(p);
 
 	if (p->reada != READA_NONE)
 		reada_for_search(fs_info, p, level, slot, key->objectid);
@@ -2505,7 +2476,6 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 			goto again;
 		}
 
-		btrfs_set_path_blocking(p);
 		reada_for_balance(fs_info, p, level);
 		sret = split_node(trans, root, p, level);
 
@@ -2525,7 +2495,6 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 			goto again;
 		}
 
-		btrfs_set_path_blocking(p);
 		reada_for_balance(fs_info, p, level);
 		sret = balance_level(trans, root, p, level);
 
@@ -2788,7 +2757,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				goto again;
 			}
 
-			btrfs_set_path_blocking(p);
 			if (last_level)
 				err = btrfs_cow_block(trans, root, b, NULL, 0,
 						      &b,
@@ -2858,7 +2826,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 					goto again;
 				}
 
-				btrfs_set_path_blocking(p);
 				err = split_leaf(trans, root, key,
 						 p, ins_len, ret == 0);
 
@@ -2920,17 +2887,11 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (!p->skip_locking) {
 			level = btrfs_header_level(b);
 			if (level <= write_lock_level) {
-				if (!btrfs_try_tree_write_lock(b)) {
-					btrfs_set_path_blocking(p);
-					btrfs_tree_lock(b);
-				}
+				btrfs_tree_lock(b);
 				p->locks[level] = BTRFS_WRITE_LOCK;
 			} else {
-				if (!btrfs_tree_read_lock_atomic(b)) {
-					btrfs_set_path_blocking(p);
-					__btrfs_tree_read_lock(b, BTRFS_NESTING_NORMAL,
-							       p->recurse);
-				}
+				__btrfs_tree_read_lock(b, BTRFS_NESTING_NORMAL,
+						       p->recurse);
 				p->locks[level] = BTRFS_READ_LOCK;
 			}
 			p->nodes[level] = b;
@@ -2938,12 +2899,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	}
 	ret = 1;
 done:
-	/*
-	 * we don't really know what they plan on doing with the path
-	 * from here on, so for now just mark it as blocking
-	 */
-	if (!p->leave_spinning)
-		btrfs_set_path_blocking(p);
 	if (ret < 0 && !p->skip_release_on_error)
 		btrfs_release_path(p);
 	return ret;
@@ -3035,10 +2990,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 		}
 
 		level = btrfs_header_level(b);
-		if (!btrfs_tree_read_lock_atomic(b)) {
-			btrfs_set_path_blocking(p);
-			btrfs_tree_read_lock(b);
-		}
+		btrfs_tree_read_lock(b);
 		b = tree_mod_log_rewind(fs_info, p, b, time_seq);
 		if (!b) {
 			ret = -ENOMEM;
@@ -3049,8 +3001,6 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 	}
 	ret = 1;
 done:
-	if (!p->leave_spinning)
-		btrfs_set_path_blocking(p);
 	if (ret < 0)
 		btrfs_release_path(p);
 
@@ -3477,7 +3427,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	add_root_to_dirty_list(root);
 	atomic_inc(&c->refs);
 	path->nodes[level] = c;
-	path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_WRITE_LOCK;
 	path->slots[level] = 0;
 	return 0;
 }
@@ -3852,7 +3802,6 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 		return 1;
 
 	__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
-	btrfs_set_lock_blocking_write(right);
 
 	free_space = btrfs_leaf_free_space(right);
 	if (free_space < data_size)
@@ -4092,7 +4041,6 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		return 1;
 
 	__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
-	btrfs_set_lock_blocking_write(left);
 
 	free_space = btrfs_leaf_free_space(left);
 	if (free_space < data_size) {
@@ -4488,7 +4436,6 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 			goto err;
 	}
 
-	btrfs_set_path_blocking(path);
 	ret = split_leaf(trans, root, &key, path, ins_len, 1);
 	if (ret)
 		goto err;
@@ -4518,8 +4465,6 @@ static noinline int split_item(struct btrfs_path *path,
 	leaf = path->nodes[0];
 	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
 
-	btrfs_set_path_blocking(path);
-
 	item = btrfs_item_nr(path->slots[0]);
 	orig_offset = btrfs_item_offset(leaf, item);
 	item_size = btrfs_item_size(leaf, item);
@@ -5095,7 +5040,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (leaf == root->node) {
 			btrfs_set_header_level(leaf, 0);
 		} else {
-			btrfs_set_path_blocking(path);
 			btrfs_clean_tree_block(leaf);
 			btrfs_del_leaf(trans, root, path, leaf);
 		}
@@ -5117,7 +5061,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			slot = path->slots[1];
 			atomic_inc(&leaf->refs);
 
-			btrfs_set_path_blocking(path);
 			wret = push_leaf_left(trans, root, path, 1, 1,
 					      1, (u32)-1);
 			if (wret < 0 && wret != -ENOSPC)
@@ -5318,7 +5261,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 		 */
 		if (slot >= nritems) {
 			path->slots[level] = slot;
-			btrfs_set_path_blocking(path);
 			sret = btrfs_find_next_key(root, path, min_key, level,
 						  min_trans);
 			if (sret == 0) {
@@ -5335,7 +5277,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			ret = 0;
 			goto out;
 		}
-		btrfs_set_path_blocking(path);
 		cur = btrfs_read_node_slot(cur, slot);
 		if (IS_ERR(cur)) {
 			ret = PTR_ERR(cur);
@@ -5352,7 +5293,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 	path->keep_locks = keep_locks;
 	if (ret == 0) {
 		btrfs_unlock_up_safe(path, path->lowest_level + 1);
-		btrfs_set_path_blocking(path);
 		memcpy(min_key, &found_key, sizeof(found_key));
 	}
 	return ret;
@@ -5562,7 +5502,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 				goto again;
 			}
 			if (!ret) {
-				btrfs_set_path_blocking(path);
 				__btrfs_tree_read_lock(next,
 						       BTRFS_NESTING_RIGHT,
 						       path->recurse);
@@ -5597,13 +5536,8 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		if (!path->skip_locking) {
-			ret = btrfs_try_tree_read_lock(next);
-			if (!ret) {
-				btrfs_set_path_blocking(path);
-				__btrfs_tree_read_lock(next,
-						       BTRFS_NESTING_RIGHT,
-						       path->recurse);
-			}
+			__btrfs_tree_read_lock(next, BTRFS_NESTING_RIGHT,
+					       path->recurse);
 			next_rw_lock = BTRFS_READ_LOCK;
 		}
 	}
@@ -5611,8 +5545,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 done:
 	unlock_up(path, 0, 1, 0, NULL);
 	path->leave_spinning = old_spinning;
-	if (!old_spinning)
-		btrfs_set_path_blocking(path);
 
 	return ret;
 }
@@ -5634,7 +5566,6 @@ int btrfs_previous_item(struct btrfs_root *root,
 
 	while (1) {
 		if (path->slots[0] == 0) {
-			btrfs_set_path_blocking(path);
 			ret = btrfs_prev_leaf(root, path);
 			if (ret != 0)
 				return ret;
@@ -5676,7 +5607,6 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 
 	while (1) {
 		if (path->slots[0] == 0) {
-			btrfs_set_path_blocking(path);
 			ret = btrfs_prev_leaf(root, path);
 			if (ret != 0)
 				return ret;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3ddb09f2b168..7ad3091db571 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2713,6 +2713,13 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct extent_buffer *parent, int parent_slot,
 		    struct extent_buffer **cow_ret,
 		    enum btrfs_lock_nesting nest);
+int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root,
+			  struct extent_buffer *buf,
+			  struct extent_buffer *parent, int parent_slot,
+			  struct extent_buffer **cow_ret,
+			  u64 search_start, u64 empty_size,
+			  enum btrfs_lock_nesting nest);
 int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e2afaa70ae5e..cbc05bd8452e 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -741,13 +741,6 @@ static int btrfs_batch_insert_items(struct btrfs_root *root,
 		goto out;
 	}
 
-	/*
-	 * we need allocate some memory space, but it might cause the task
-	 * to sleep, so we set all locked nodes in the path to blocking locks
-	 * first.
-	 */
-	btrfs_set_path_blocking(path);
-
 	keys = kmalloc_array(nitems, sizeof(struct btrfs_key), GFP_NOFS);
 	if (!keys) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 104c86784796..91475cb7d568 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -248,10 +248,8 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	if (atomic)
 		return -EAGAIN;
 
-	if (need_lock) {
+	if (need_lock)
 		btrfs_tree_read_lock(eb);
-		btrfs_set_lock_blocking_read(eb);
-	}
 
 	lock_extent_bits(io_tree, eb->start, eb->start + eb->len - 1,
 			 &cached_state);
@@ -280,7 +278,7 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	unlock_extent_cached(io_tree, eb->start, eb->start + eb->len - 1,
 			     &cached_state);
 	if (need_lock)
-		btrfs_tree_read_unlock_blocking(eb);
+		btrfs_tree_read_unlock(eb);
 	return ret;
 }
 
@@ -1012,8 +1010,6 @@ void btrfs_clean_tree_block(struct extent_buffer *buf)
 			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 						 -buf->len,
 						 fs_info->dirty_metadata_batch);
-			/* ugh, clear_extent_buffer_dirty needs to lock the page */
-			btrfs_set_lock_blocking_write(buf);
 			clear_extent_buffer_dirty(buf);
 		}
 	}
@@ -4141,6 +4137,15 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 * already the cleaner, but below we run all pending delayed iputs.
 	 */
 	btrfs_flush_workqueue(fs_info->fixup_workers);
+	/*
+	 * Similar case here, we have to wait for delalloc workers before we
+	 * proceed below and stop the cleaner kthread, otherwise we trigger a
+	 * use-after-tree on the cleaner kthread task_struct when a delalloc
+	 * worker running submit_compressed_extents() adds a delayed iput, which
+	 * does a wake up on the cleaner kthread, which was already freed below
+	 * when we call kthread_stop().
+	 */
+	btrfs_flush_workqueue(fs_info->delalloc_workers);
 
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d8a1bec69fb8..a8089bf2be98 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4608,7 +4608,6 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
 
-	btrfs_set_lock_blocking_write(buf);
 	set_extent_buffer_uptodate(buf);
 
 	memzero_extent_buffer(buf, 0, sizeof(struct btrfs_header));
@@ -5008,7 +5007,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		reada = 1;
 	}
 	btrfs_tree_lock(next);
-	btrfs_set_lock_blocking_write(next);
 
 	ret = btrfs_lookup_extent_info(trans, fs_info, bytenr, level - 1, 1,
 				       &wc->refs[level - 1],
@@ -5069,7 +5067,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			return -EIO;
 		}
 		btrfs_tree_lock(next);
-		btrfs_set_lock_blocking_write(next);
 	}
 
 	level--;
@@ -5081,7 +5078,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	}
 	path->nodes[level] = next;
 	path->slots[level] = 0;
-	path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_WRITE_LOCK;
 	wc->level = level;
 	if (wc->level == 1)
 		wc->reada_slot = 0;
@@ -5209,8 +5206,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 		if (!path->locks[level]) {
 			BUG_ON(level == 0);
 			btrfs_tree_lock(eb);
-			btrfs_set_lock_blocking_write(eb);
-			path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_WRITE_LOCK;
 
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						       eb->start, level, 1,
@@ -5258,8 +5254,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 		if (!path->locks[level] &&
 		    btrfs_header_generation(eb) == trans->transid) {
 			btrfs_tree_lock(eb);
-			btrfs_set_lock_blocking_write(eb);
-			path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_WRITE_LOCK;
 		}
 		btrfs_clean_tree_block(eb);
 	}
@@ -5427,9 +5422,8 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	if (btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		level = btrfs_header_level(root->node);
 		path->nodes[level] = btrfs_lock_root_node(root);
-		btrfs_set_lock_blocking_write(path->nodes[level]);
 		path->slots[level] = 0;
-		path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+		path->locks[level] = BTRFS_WRITE_LOCK;
 		memset(&wc->update_progress, 0,
 		       sizeof(wc->update_progress));
 	} else {
@@ -5457,8 +5451,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		level = btrfs_header_level(root->node);
 		while (1) {
 			btrfs_tree_lock(path->nodes[level]);
-			btrfs_set_lock_blocking_write(path->nodes[level]);
-			path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_WRITE_LOCK;
 
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						path->nodes[level]->start,
@@ -5653,7 +5646,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	level = btrfs_header_level(node);
 	path->nodes[level] = node;
 	path->slots[level] = 0;
-	path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_WRITE_LOCK;
 
 	wc->refs[parent_level] = 1;
 	wc->flags[parent_level] = BTRFS_BLOCK_FLAG_FULL_BACKREF;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 685a375bb6af..9cef930c4ecf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4960,12 +4960,8 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	eb->len = len;
 	eb->fs_info = fs_info;
 	eb->bflags = 0;
-	rwlock_init(&eb->lock);
-	atomic_set(&eb->blocking_readers, 0);
-	eb->blocking_writers = 0;
+	init_rwsem(&eb->lock);
 	eb->lock_recursed = false;
-	init_waitqueue_head(&eb->write_lock_wq);
-	init_waitqueue_head(&eb->read_lock_wq);
 
 	btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
 			     &fs_info->allocated_ebs);
@@ -4981,13 +4977,6 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 		> MAX_INLINE_EXTENT_BUFFER_SIZE);
 	BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
 
-#ifdef CONFIG_BTRFS_DEBUG
-	eb->spinning_writers = 0;
-	atomic_set(&eb->spinning_readers, 0);
-	atomic_set(&eb->read_locks, 0);
-	eb->write_locks = 0;
-#endif
-
 	return eb;
 }
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 16f44bc481ab..e8ab48e5f282 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -87,31 +87,14 @@ struct extent_buffer {
 	int read_mirror;
 	struct rcu_head rcu_head;
 	pid_t lock_owner;
-
-	int blocking_writers;
-	atomic_t blocking_readers;
 	bool lock_recursed;
+	struct rw_semaphore lock;
+
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	short log_index;
 
-	/* protects write locks */
-	rwlock_t lock;
-
-	/* readers use lock_wq while they wait for the write
-	 * lock holders to unlock
-	 */
-	wait_queue_head_t write_lock_wq;
-
-	/* writers use read_lock_wq while they wait for readers
-	 * to unlock
-	 */
-	wait_queue_head_t read_lock_wq;
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
 #ifdef CONFIG_BTRFS_DEBUG
-	int spinning_writers;
-	atomic_t spinning_readers;
-	atomic_t read_locks;
-	int write_locks;
 	struct list_head leak_list;
 #endif
 };
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 416a1b753ff6..53a3c32a0f8c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -984,8 +984,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	 * write lock.
 	 */
 	if (!ret && replace_extent && leafs_visited == 1 &&
-	    (path->locks[0] == BTRFS_WRITE_LOCK_BLOCKING ||
-	     path->locks[0] == BTRFS_WRITE_LOCK) &&
+	    path->locks[0] == BTRFS_WRITE_LOCK &&
 	    btrfs_leaf_free_space(leaf) >=
 	    sizeof(struct btrfs_item) + extent_item_size) {
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eba87f2936d2..560c4f2a1833 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6752,7 +6752,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		em->orig_start = em->start;
 		ptr = btrfs_file_extent_inline_start(item) + extent_offset;
 
-		btrfs_set_path_blocking(path);
 		if (!PageUptodate(page)) {
 			if (btrfs_file_extent_compression(leaf, item) !=
 			    BTRFS_COMPRESS_NONE) {
@@ -7128,6 +7127,8 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			ret = -EAGAIN;
 			goto out;
 		}
+
+		cond_resched();
 	}
 
 	btrfs_release_path(path);
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 66e02ebdd340..3d177ef92ab6 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -17,232 +17,26 @@
  * Extent buffer locking
  * =====================
  *
- * The locks use a custom scheme that allows to do more operations than are
- * available fromt current locking primitives. The building blocks are still
- * rwlock and wait queues.
- *
- * Required semantics:
+ * We use a rw_semaphore for tree locking, and the semantics are exactly the
+ * same:
  *
  * - reader/writer exclusion
  * - writer/writer exclusion
  * - reader/reader sharing
- * - spinning lock semantics
- * - blocking lock semantics
  * - try-lock semantics for readers and writers
- * - one level nesting, allowing read lock to be taken by the same thread that
- *   already has write lock
- *
- * The extent buffer locks (also called tree locks) manage access to eb data
- * related to the storage in the b-tree (keys, items, but not the individual
- * members of eb).
- * We want concurrency of many readers and safe updates. The underlying locking
- * is done by read-write spinlock and the blocking part is implemented using
- * counters and wait queues.
- *
- * spinning semantics - the low-level rwlock is held so all other threads that
- *                      want to take it are spinning on it.
- *
- * blocking semantics - the low-level rwlock is not held but the counter
- *                      denotes how many times the blocking lock was held;
- *                      sleeping is possible
- *
- * Write lock always allows only one thread to access the data.
- *
- *
- * Debugging
- * ---------
- *
- * There are additional state counters that are asserted in various contexts,
- * removed from non-debug build to reduce extent_buffer size and for
- * performance reasons.
- *
- *
- * Lock recursion
- * --------------
- *
- * A write operation on a tree might indirectly start a look up on the same
- * tree.  This can happen when btrfs_cow_block locks the tree and needs to
- * lookup free extents.
- *
- * btrfs_cow_block
- *   ..
- *   alloc_tree_block_no_bg_flush
- *     btrfs_alloc_tree_block
- *       btrfs_reserve_extent
- *         ..
- *         load_free_space_cache
- *           ..
- *           btrfs_lookup_file_extent
- *             btrfs_search_slot
- *
- *
- * Locking pattern - spinning
- * --------------------------
- *
- * The simple locking scenario, the +--+ denotes the spinning section.
- *
- * +- btrfs_tree_lock
- * | - extent_buffer::rwlock is held
- * | - no heavy operations should happen, eg. IO, memory allocations, large
- * |   structure traversals
- * +- btrfs_tree_unock
-*
-*
- * Locking pattern - blocking
- * --------------------------
- *
- * The blocking write uses the following scheme.  The +--+ denotes the spinning
- * section.
- *
- * +- btrfs_tree_lock
- * |
- * +- btrfs_set_lock_blocking_write
- *
- *   - allowed: IO, memory allocations, etc.
- *
- * -- btrfs_tree_unlock - note, no explicit unblocking necessary
- *
- *
- * Blocking read is similar.
- *
- * +- btrfs_tree_read_lock
- * |
- * +- btrfs_set_lock_blocking_read
- *
- *  - heavy operations allowed
- *
- * +- btrfs_tree_read_unlock_blocking
- * |
- * +- btrfs_tree_read_unlock
- *
- */
-
-#ifdef CONFIG_BTRFS_DEBUG
-static inline void btrfs_assert_spinning_writers_get(struct extent_buffer *eb)
-{
-	WARN_ON(eb->spinning_writers);
-	eb->spinning_writers++;
-}
-
-static inline void btrfs_assert_spinning_writers_put(struct extent_buffer *eb)
-{
-	WARN_ON(eb->spinning_writers != 1);
-	eb->spinning_writers--;
-}
-
-static inline void btrfs_assert_no_spinning_writers(struct extent_buffer *eb)
-{
-	WARN_ON(eb->spinning_writers);
-}
-
-static inline void btrfs_assert_spinning_readers_get(struct extent_buffer *eb)
-{
-	atomic_inc(&eb->spinning_readers);
-}
-
-static inline void btrfs_assert_spinning_readers_put(struct extent_buffer *eb)
-{
-	WARN_ON(atomic_read(&eb->spinning_readers) == 0);
-	atomic_dec(&eb->spinning_readers);
-}
-
-static inline void btrfs_assert_tree_read_locks_get(struct extent_buffer *eb)
-{
-	atomic_inc(&eb->read_locks);
-}
-
-static inline void btrfs_assert_tree_read_locks_put(struct extent_buffer *eb)
-{
-	atomic_dec(&eb->read_locks);
-}
-
-static inline void btrfs_assert_tree_read_locked(struct extent_buffer *eb)
-{
-	BUG_ON(!atomic_read(&eb->read_locks));
-}
-
-static inline void btrfs_assert_tree_write_locks_get(struct extent_buffer *eb)
-{
-	eb->write_locks++;
-}
-
-static inline void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb)
-{
-	eb->write_locks--;
-}
-
-#else
-static void btrfs_assert_spinning_writers_get(struct extent_buffer *eb) { }
-static void btrfs_assert_spinning_writers_put(struct extent_buffer *eb) { }
-static void btrfs_assert_no_spinning_writers(struct extent_buffer *eb) { }
-static void btrfs_assert_spinning_readers_put(struct extent_buffer *eb) { }
-static void btrfs_assert_spinning_readers_get(struct extent_buffer *eb) { }
-static void btrfs_assert_tree_read_locked(struct extent_buffer *eb) { }
-static void btrfs_assert_tree_read_locks_get(struct extent_buffer *eb) { }
-static void btrfs_assert_tree_read_locks_put(struct extent_buffer *eb) { }
-static void btrfs_assert_tree_write_locks_get(struct extent_buffer *eb) { }
-static void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb) { }
-#endif
-
-/*
- * Mark already held read lock as blocking. Can be nested in write lock by the
- * same thread.
- *
- * Use when there are potentially long operations ahead so other thread waiting
- * on the lock will not actively spin but sleep instead.
- *
- * The rwlock is released and blocking reader counter is increased.
- */
-void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
-{
-	trace_btrfs_set_lock_blocking_read(eb);
-	/*
-	 * No lock is required.  The lock owner may change if we have a read
-	 * lock, but it won't change to or away from us.  If we have the write
-	 * lock, we are the owner and it'll never change.
-	 */
-	if (eb->lock_recursed && current->pid == eb->lock_owner)
-		return;
-	btrfs_assert_tree_read_locked(eb);
-	atomic_inc(&eb->blocking_readers);
-	btrfs_assert_spinning_readers_put(eb);
-	read_unlock(&eb->lock);
-}
-
-/*
- * Mark already held write lock as blocking.
  *
- * Use when there are potentially long operations ahead so other threads
- * waiting on the lock will not actively spin but sleep instead.
- *
- * The rwlock is released and blocking writers is set.
+ * The rwsem implementation does opportunistic spinning which reduces number of
+ * times the locking task needs to sleep.
  */
-void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
-{
-	trace_btrfs_set_lock_blocking_write(eb);
-	/*
-	 * No lock is required.  The lock owner may change if we have a read
-	 * lock, but it won't change to or away from us.  If we have the write
-	 * lock, we are the owner and it'll never change.
-	 */
-	if (eb->lock_recursed && current->pid == eb->lock_owner)
-		return;
-	if (eb->blocking_writers == 0) {
-		btrfs_assert_spinning_writers_put(eb);
-		btrfs_assert_tree_locked(eb);
-		WRITE_ONCE(eb->blocking_writers, 1);
-		write_unlock(&eb->lock);
-	}
-}
 
 /*
- * Lock the extent buffer for read. Wait for any writers (spinning or blocking).
- * Can be nested in write lock by the same thread.
- *
- * Use when the locked section does only lightweight actions and busy waiting
- * would be cheaper than making other threads do the wait/wake loop.
+ * __btrfs_tree_read_lock - lock extent buffer for read
+ * @eb:		the eb to be locked
+ * @nest:	the nesting level to be used for lockdep
+ * @recurse:	unused
  *
- * The rwlock is held upon exit.
+ * This takes the read lock on the extent buffer, using the specified nesting
+ * level for lockdep purposes.
  */
 void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest,
 			    bool recurse)
@@ -251,33 +45,8 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
 
 	if (trace_btrfs_tree_read_lock_enabled())
 		start_ns = ktime_get_ns();
-again:
-	read_lock(&eb->lock);
-	BUG_ON(eb->blocking_writers == 0 &&
-	       current->pid == eb->lock_owner);
-	if (eb->blocking_writers) {
-		if (current->pid == eb->lock_owner) {
-			/*
-			 * This extent is already write-locked by our thread.
-			 * We allow an additional read lock to be added because
-			 * it's for the same thread. btrfs_find_all_roots()
-			 * depends on this as it may be called on a partly
-			 * (write-)locked tree.
-			 */
-			WARN_ON(!recurse);
-			BUG_ON(eb->lock_recursed);
-			eb->lock_recursed = true;
-			read_unlock(&eb->lock);
-			trace_btrfs_tree_read_lock(eb, start_ns);
-			return;
-		}
-		read_unlock(&eb->lock);
-		wait_event(eb->write_lock_wq,
-			   READ_ONCE(eb->blocking_writers) == 0);
-		goto again;
-	}
-	btrfs_assert_tree_read_locks_get(eb);
-	btrfs_assert_spinning_readers_get(eb);
+
+	down_read_nested(&eb->lock, nest);
 	trace_btrfs_tree_read_lock(eb, start_ns);
 }
 
@@ -287,134 +56,49 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 }
 
 /*
- * Lock extent buffer for read, optimistically expecting that there are no
- * contending blocking writers. If there are, don't wait.
- *
- * Return 1 if the rwlock has been taken, 0 otherwise
- */
-int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
-{
-	if (READ_ONCE(eb->blocking_writers))
-		return 0;
-
-	read_lock(&eb->lock);
-	/* Refetch value after lock */
-	if (READ_ONCE(eb->blocking_writers)) {
-		read_unlock(&eb->lock);
-		return 0;
-	}
-	btrfs_assert_tree_read_locks_get(eb);
-	btrfs_assert_spinning_readers_get(eb);
-	trace_btrfs_tree_read_lock_atomic(eb);
-	return 1;
-}
-
-/*
- * Try-lock for read. Don't block or wait for contending writers.
+ * Try-lock for read.
  *
  * Retrun 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 {
-	if (READ_ONCE(eb->blocking_writers))
-		return 0;
-
-	if (!read_trylock(&eb->lock))
-		return 0;
-
-	/* Refetch value after lock */
-	if (READ_ONCE(eb->blocking_writers)) {
-		read_unlock(&eb->lock);
-		return 0;
+	if (down_read_trylock(&eb->lock)) {
+		trace_btrfs_try_tree_read_lock(eb);
+		return 1;
 	}
-	btrfs_assert_tree_read_locks_get(eb);
-	btrfs_assert_spinning_readers_get(eb);
-	trace_btrfs_try_tree_read_lock(eb);
-	return 1;
+	return 0;
 }
 
 /*
- * Try-lock for write. May block until the lock is uncontended, but does not
- * wait until it is free.
+ * Try-lock for write.
  *
  * Retrun 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 {
-	if (READ_ONCE(eb->blocking_writers) || atomic_read(&eb->blocking_readers))
-		return 0;
-
-	write_lock(&eb->lock);
-	/* Refetch value after lock */
-	if (READ_ONCE(eb->blocking_writers) || atomic_read(&eb->blocking_readers)) {
-		write_unlock(&eb->lock);
-		return 0;
+	if (down_write_trylock(&eb->lock)) {
+		eb->lock_owner = current->pid;
+		trace_btrfs_try_tree_write_lock(eb);
+		return 1;
 	}
-	btrfs_assert_tree_write_locks_get(eb);
-	btrfs_assert_spinning_writers_get(eb);
-	eb->lock_owner = current->pid;
-	trace_btrfs_try_tree_write_lock(eb);
-	return 1;
+	return 0;
 }
 
 /*
- * Release read lock. Must be used only if the lock is in spinning mode.  If
- * the read lock is nested, must pair with read lock before the write unlock.
- *
- * The rwlock is not held upon exit.
+ * Release read lock.
  */
 void btrfs_tree_read_unlock(struct extent_buffer *eb)
 {
 	trace_btrfs_tree_read_unlock(eb);
-	/*
-	 * if we're nested, we have the write lock.  No new locking
-	 * is needed as long as we are the lock owner.
-	 * The write unlock will do a barrier for us, and the lock_recursed
-	 * field only matters to the lock owner.
-	 */
-	if (eb->lock_recursed && current->pid == eb->lock_owner) {
-		eb->lock_recursed = false;
-		return;
-	}
-	btrfs_assert_tree_read_locked(eb);
-	btrfs_assert_spinning_readers_put(eb);
-	btrfs_assert_tree_read_locks_put(eb);
-	read_unlock(&eb->lock);
-}
-
-/*
- * Release read lock, previously set to blocking by a pairing call to
- * btrfs_set_lock_blocking_read(). Can be nested in write lock by the same
- * thread.
- *
- * State of rwlock is unchanged, last reader wakes waiting threads.
- */
-void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
-{
-	trace_btrfs_tree_read_unlock_blocking(eb);
-	/*
-	 * if we're nested, we have the write lock.  No new locking
-	 * is needed as long as we are the lock owner.
-	 * The write unlock will do a barrier for us, and the lock_recursed
-	 * field only matters to the lock owner.
-	 */
-	if (eb->lock_recursed && current->pid == eb->lock_owner) {
-		eb->lock_recursed = false;
-		return;
-	}
-	btrfs_assert_tree_read_locked(eb);
-	WARN_ON(atomic_read(&eb->blocking_readers) == 0);
-	/* atomic_dec_and_test implies a barrier */
-	if (atomic_dec_and_test(&eb->blocking_readers))
-		cond_wake_up_nomb(&eb->read_lock_wq);
-	btrfs_assert_tree_read_locks_put(eb);
+	up_read(&eb->lock);
 }
 
 /*
- * Lock for write. Wait for all blocking and spinning readers and writers. This
- * starts context where reader lock could be nested by the same thread.
+ * __btrfs_tree_lock - lock eb for write
+ * @eb:		the eb to lock
+ * @nest:	the nesting to use for the lock
  *
- * The rwlock is held for write upon exit.
+ * Returns with the eb->lock write locked.
  */
 void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
 	__acquires(&eb->lock)
@@ -424,19 +108,7 @@ void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
 	if (trace_btrfs_tree_lock_enabled())
 		start_ns = ktime_get_ns();
 
-	WARN_ON(eb->lock_owner == current->pid);
-again:
-	wait_event(eb->read_lock_wq, atomic_read(&eb->blocking_readers) == 0);
-	wait_event(eb->write_lock_wq, READ_ONCE(eb->blocking_writers) == 0);
-	write_lock(&eb->lock);
-	/* Refetch value after lock */
-	if (atomic_read(&eb->blocking_readers) ||
-	    READ_ONCE(eb->blocking_writers)) {
-		write_unlock(&eb->lock);
-		goto again;
-	}
-	btrfs_assert_spinning_writers_get(eb);
-	btrfs_assert_tree_write_locks_get(eb);
+	down_write_nested(&eb->lock, nest);
 	eb->lock_owner = current->pid;
 	trace_btrfs_tree_lock(eb, start_ns);
 }
@@ -447,68 +119,13 @@ void btrfs_tree_lock(struct extent_buffer *eb)
 }
 
 /*
- * Release the write lock, either blocking or spinning (ie. there's no need
- * for an explicit blocking unlock, like btrfs_tree_read_unlock_blocking).
- * This also ends the context for nesting, the read lock must have been
- * released already.
- *
- * Tasks blocked and waiting are woken, rwlock is not held upon exit.
+ * Release the write lock.
  */
 void btrfs_tree_unlock(struct extent_buffer *eb)
 {
-	/*
-	 * This is read both locked and unlocked but always by the same thread
-	 * that already owns the lock so we don't need to use READ_ONCE
-	 */
-	int blockers = eb->blocking_writers;
-
-	BUG_ON(blockers > 1);
-
-	btrfs_assert_tree_locked(eb);
 	trace_btrfs_tree_unlock(eb);
 	eb->lock_owner = 0;
-	btrfs_assert_tree_write_locks_put(eb);
-
-	if (blockers) {
-		btrfs_assert_no_spinning_writers(eb);
-		/* Unlocked write */
-		WRITE_ONCE(eb->blocking_writers, 0);
-		/*
-		 * We need to order modifying blocking_writers above with
-		 * actually waking up the sleepers to ensure they see the
-		 * updated value of blocking_writers
-		 */
-		cond_wake_up(&eb->write_lock_wq);
-	} else {
-		btrfs_assert_spinning_writers_put(eb);
-		write_unlock(&eb->lock);
-	}
-}
-
-/*
- * Set all locked nodes in the path to blocking locks.  This should be done
- * before scheduling
- */
-void btrfs_set_path_blocking(struct btrfs_path *p)
-{
-	int i;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
-		if (!p->nodes[i] || !p->locks[i])
-			continue;
-		/*
-		 * If we currently have a spinning reader or writer lock this
-		 * will bump the count of blocking holders and drop the
-		 * spinlock.
-		 */
-		if (p->locks[i] == BTRFS_READ_LOCK) {
-			btrfs_set_lock_blocking_read(p->nodes[i]);
-			p->locks[i] = BTRFS_READ_LOCK_BLOCKING;
-		} else if (p->locks[i] == BTRFS_WRITE_LOCK) {
-			btrfs_set_lock_blocking_write(p->nodes[i]);
-			p->locks[i] = BTRFS_WRITE_LOCK_BLOCKING;
-		}
-	}
+	up_write(&eb->lock);
 }
 
 /*
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 3ea81ed3320b..f8f2fd835582 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -13,8 +13,6 @@
 
 #define BTRFS_WRITE_LOCK 1
 #define BTRFS_READ_LOCK 2
-#define BTRFS_WRITE_LOCK_BLOCKING 3
-#define BTRFS_READ_LOCK_BLOCKING 4
 
 /*
  * We are limited in number of subclasses by MAX_LOCKDEP_SUBCLASSES, which at
@@ -93,12 +91,8 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
 			    bool recurse);
 void btrfs_tree_read_lock(struct extent_buffer *eb);
 void btrfs_tree_read_unlock(struct extent_buffer *eb);
-void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb);
-void btrfs_set_lock_blocking_read(struct extent_buffer *eb);
-void btrfs_set_lock_blocking_write(struct extent_buffer *eb);
 int btrfs_try_tree_read_lock(struct extent_buffer *eb);
 int btrfs_try_tree_write_lock(struct extent_buffer *eb);
-int btrfs_tree_read_lock_atomic(struct extent_buffer *eb);
 struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
 struct extent_buffer *__btrfs_read_lock_root_node(struct btrfs_root *root,
 						  bool recurse);
@@ -110,21 +104,18 @@ static inline struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root
 
 #ifdef CONFIG_BTRFS_DEBUG
 static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) {
-	BUG_ON(!eb->write_locks);
+	lockdep_assert_held(&eb->lock);
 }
 #else
 static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) { }
 #endif
 
-void btrfs_set_path_blocking(struct btrfs_path *p);
 void btrfs_unlock_up_safe(struct btrfs_path *path, int level);
 
 static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
 {
-	if (rw == BTRFS_WRITE_LOCK || rw == BTRFS_WRITE_LOCK_BLOCKING)
+	if (rw == BTRFS_WRITE_LOCK)
 		btrfs_tree_unlock(eb);
-	else if (rw == BTRFS_READ_LOCK_BLOCKING)
-		btrfs_tree_read_unlock_blocking(eb);
 	else if (rw == BTRFS_READ_LOCK)
 		btrfs_tree_read_unlock(eb);
 	else
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index e98ba4e091b3..70feac4bdf3c 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -191,15 +191,8 @@ static void print_uuid_item(struct extent_buffer *l, unsigned long offset,
 static void print_eb_refs_lock(struct extent_buffer *eb)
 {
 #ifdef CONFIG_BTRFS_DEBUG
-	btrfs_info(eb->fs_info,
-"refs %u lock (w:%d r:%d bw:%d br:%d sw:%d sr:%d) lock_owner %u current %u",
-		   atomic_read(&eb->refs), eb->write_locks,
-		   atomic_read(&eb->read_locks),
-		   eb->blocking_writers,
-		   atomic_read(&eb->blocking_readers),
-		   eb->spinning_writers,
-		   atomic_read(&eb->spinning_readers),
-		   eb->lock_owner, current->pid);
+	btrfs_info(eb->fs_info, "refs %u lock_owner %u current %u",
+		   atomic_read(&eb->refs), eb->lock_owner, current->pid);
 #endif
 }
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 7518ab3b409c..95a39d535a82 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2061,8 +2061,7 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 			src_path->nodes[cur_level] = eb;
 
 			btrfs_tree_read_lock(eb);
-			btrfs_set_lock_blocking_read(eb);
-			src_path->locks[cur_level] = BTRFS_READ_LOCK_BLOCKING;
+			src_path->locks[cur_level] = BTRFS_READ_LOCK;
 		}
 
 		src_path->slots[cur_level] = dst_path->slots[cur_level];
@@ -2202,8 +2201,7 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 		dst_path->slots[cur_level] = 0;
 
 		btrfs_tree_read_lock(eb);
-		btrfs_set_lock_blocking_read(eb);
-		dst_path->locks[cur_level] = BTRFS_READ_LOCK_BLOCKING;
+		dst_path->locks[cur_level] = BTRFS_READ_LOCK;
 		need_cleanup = true;
 	}
 
@@ -2377,8 +2375,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			path->slots[level] = 0;
 
 			btrfs_tree_read_lock(eb);
-			btrfs_set_lock_blocking_read(eb);
-			path->locks[level] = BTRFS_READ_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_READ_LOCK;
 
 			ret = btrfs_qgroup_trace_extent(trans, child_bytenr,
 							fs_info->nodesize,
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 38e1ed4dc2a9..4755bccee9aa 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -575,10 +575,9 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 				return -EIO;
 			}
 			btrfs_tree_read_lock(eb);
-			btrfs_set_lock_blocking_read(eb);
 			path->nodes[level-1] = eb;
 			path->slots[level-1] = 0;
-			path->locks[level-1] = BTRFS_READ_LOCK_BLOCKING;
+			path->locks[level-1] = BTRFS_READ_LOCK;
 		} else {
 			ret = process_leaf(root, path, bytenr, num_bytes);
 			if (ret)
@@ -1006,11 +1005,10 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		return -ENOMEM;
 
 	eb = btrfs_read_lock_root_node(fs_info->extent_root);
-	btrfs_set_lock_blocking_read(eb);
 	level = btrfs_header_level(eb);
 	path->nodes[level] = eb;
 	path->slots[level] = 0;
-	path->locks[level] = BTRFS_READ_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_READ_LOCK;
 
 	while (1) {
 		/*
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index cdd16583b2ff..98e3b3749ec1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1214,7 +1214,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	btrfs_node_key_to_cpu(path->nodes[lowest_level], &key, slot);
 
 	eb = btrfs_lock_root_node(dest);
-	btrfs_set_lock_blocking_write(eb);
 	level = btrfs_header_level(eb);
 
 	if (level < lowest_level) {
@@ -1228,7 +1227,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				      BTRFS_NESTING_COW);
 		BUG_ON(ret);
 	}
-	btrfs_set_lock_blocking_write(eb);
 
 	if (next_key) {
 		next_key->objectid = (u64)-1;
@@ -1297,7 +1295,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 						      BTRFS_NESTING_COW);
 				BUG_ON(ret);
 			}
-			btrfs_set_lock_blocking_write(eb);
 
 			btrfs_tree_unlock(parent);
 			free_extent_buffer(parent);
@@ -2327,7 +2324,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			goto next;
 		}
 		btrfs_tree_lock(eb);
-		btrfs_set_lock_blocking_write(eb);
 
 		if (!node->eb) {
 			ret = btrfs_cow_block(trans, root, eb, upper->eb,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8878aa7cbdc5..d1f010022f68 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1648,8 +1648,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	btrfs_set_lock_blocking_write(old);
-
 	ret = btrfs_copy_root(trans, root, old, &tmp, objectid);
 	/* clean up in any case */
 	btrfs_tree_unlock(old);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 2b0fc0c30f36..35b94fe5e78e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1367,6 +1367,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 					   dref_offset, fs_info->sectorsize);
 				return -EUCLEAN;
 			}
+			if (unlikely(btrfs_extent_data_ref_count(leaf, dref) == 0)) {
+				extent_err(leaf, slot,
+			"invalid data ref count, should have non-zero value");
+				return -EUCLEAN;
+			}
 			inline_refs += btrfs_extent_data_ref_count(leaf, dref);
 			break;
 		/* Contains parent bytenr and ref count */
@@ -1378,6 +1383,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 					   inline_offset, fs_info->sectorsize);
 				return -EUCLEAN;
 			}
+			if (unlikely(btrfs_shared_data_ref_count(leaf, sref) == 0)) {
+				extent_err(leaf, slot,
+			"invalid shared data ref count, should have non-zero value");
+				return -EUCLEAN;
+			}
 			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
 			break;
 		default:
@@ -1429,8 +1439,18 @@ static int check_simple_keyed_refs(struct extent_buffer *leaf,
 {
 	u32 expect_item_size = 0;
 
-	if (key->type == BTRFS_SHARED_DATA_REF_KEY)
+	if (key->type == BTRFS_SHARED_DATA_REF_KEY) {
+		struct btrfs_shared_data_ref *sref;
+
+		sref = btrfs_item_ptr(leaf, slot, struct btrfs_shared_data_ref);
+		if (unlikely(btrfs_shared_data_ref_count(leaf, sref) == 0)) {
+			extent_err(leaf, slot,
+		"invalid shared data backref count, should have non-zero value");
+			return -EUCLEAN;
+		}
+
 		expect_item_size = sizeof(struct btrfs_shared_data_ref);
+	}
 
 	if (btrfs_item_size_nr(leaf, slot) != expect_item_size) {
 		generic_err(leaf, slot,
@@ -1490,6 +1510,11 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 				   offset, leaf->fs_info->sectorsize);
 			return -EUCLEAN;
 		}
+		if (unlikely(btrfs_extent_data_ref_count(leaf, dref) == 0)) {
+			extent_err(leaf, slot,
+	"invalid extent data backref count, should have non-zero value");
+			return -EUCLEAN;
+		}
 	}
 	return 0;
 }
diff --git a/fs/btrfs/tree-defrag.c b/fs/btrfs/tree-defrag.c
index d3f28b8f4ff9..7c45d960b53c 100644
--- a/fs/btrfs/tree-defrag.c
+++ b/fs/btrfs/tree-defrag.c
@@ -52,7 +52,6 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 		u32 nritems;
 
 		root_node = btrfs_lock_root_node(root);
-		btrfs_set_lock_blocking_write(root_node);
 		nritems = btrfs_header_nritems(root_node);
 		root->defrag_max.objectid = 0;
 		/* from above we know this is not a leaf */
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 34e9eb5010cd..4ee681429327 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2774,7 +2774,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 				if (trans) {
 					btrfs_tree_lock(next);
-					btrfs_set_lock_blocking_write(next);
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
@@ -2843,7 +2842,6 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 
 				if (trans) {
 					btrfs_tree_lock(next);
-					btrfs_set_lock_blocking_write(next);
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
@@ -2925,7 +2923,6 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 			if (trans) {
 				btrfs_tree_lock(next);
-				btrfs_set_lock_blocking_write(next);
 				btrfs_clean_tree_block(next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 4e09d8e06647..3ef197742430 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -301,6 +301,8 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 
 	switch (token) {
 	case Opt_snapdirname:
+		if (strlen(param->string) > NAME_MAX)
+			return invalfc(fc, "snapdirname too long");
 		kfree(fsopt->snapdir_name);
 		fsopt->snapdir_name = param->string;
 		param->string = NULL;
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 0297ad95eb5c..d022de1ce2c2 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -43,7 +43,7 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
  *
  *	VariableName-12345678-1234-1234-1234-1234567891bc
  */
-bool efivarfs_valid_name(const char *str, int len)
+static bool efivarfs_valid_name(const char *str, int len)
 {
 	const char *s = str + len - EFI_VARIABLE_GUID_LEN;
 
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 30ae44cb7453..16cbc73b6f37 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -10,7 +10,6 @@
 
 extern const struct file_operations efivarfs_file_operations;
 extern const struct inode_operations efivarfs_dir_inode_operations;
-extern bool efivarfs_valid_name(const char *str, int len);
 extern struct inode *efivarfs_get_inode(struct super_block *sb,
 			const struct inode *dir, int mode, dev_t dev,
 			bool is_removable);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 3626816b174a..99d002438008 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -64,9 +64,6 @@ static int efivarfs_d_hash(const struct dentry *dentry, struct qstr *qstr)
 	const unsigned char *s = qstr->name;
 	unsigned int len = qstr->len;
 
-	if (!efivarfs_valid_name(s, len))
-		return -EINVAL;
-
 	while (len-- > EFI_VARIABLE_GUID_LEN)
 		hash = partial_name_hash(*s++, hash);
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 0a94a52a119f..60b4c4326dae 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -198,11 +198,14 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
+	loff_t off;
 	char *lnk;
 
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= PAGE_SIZE) {
+	m_pofs += vi->xattr_isize;
+	/* check if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
+	    check_add_overflow((loff_t)m_pofs, inode->i_size, &off) ||
+	    off > i_blocksize(inode)) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -211,17 +214,6 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 	if (!lnk)
 		return -ENOMEM;
 
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross page boundary as well */
-	if (m_pofs + inode->i_size > PAGE_SIZE) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-
 	memcpy(lnk, data + m_pofs, inode->i_size);
 	lnk[inode->i_size] = '\0';
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 5ce1ea1f452b..8962ac6eeef4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1276,7 +1276,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 				break;
 			}
 		}
-		wake_up(&ep->wq);
+		if (sync)
+			wake_up_sync(&ep->wq);
+		else
+			wake_up(&ep->wq);
 	}
 	if (waitqueue_active(&ep->poll_wait))
 		pwake++;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index f2da20ce6875..39ac4824b97d 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1199,7 +1199,7 @@ pnfs_prepare_layoutreturn(struct pnfs_layout_hdr *lo,
 		enum pnfs_iomode *iomode)
 {
 	/* Serialise LAYOUTGET/LAYOUTRETURN */
-	if (atomic_read(&lo->plh_outstanding) != 0)
+	if (atomic_read(&lo->plh_outstanding) != 0 && lo->plh_return_seq == 0)
 		return false;
 	if (test_and_set_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags))
 		return false;
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index a6dc8c479a4b..d2885dd4822d 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -986,7 +986,7 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		args.authflavor = clp->cl_cred.cr_flavor;
 		clp->cl_cb_ident = conn->cb_ident;
 	} else {
-		if (!conn->cb_xprt)
+		if (!conn->cb_xprt || !ses)
 			return -EINVAL;
 		clp->cl_cb_session = ses;
 		args.bc_xprt = conn->cb_xprt;
@@ -1379,8 +1379,6 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 		ses = c->cn_session;
 	}
 	spin_unlock(&clp->cl_lock);
-	if (!c)
-		return;
 
 	err = setup_callback_client(clp, &conn, ses);
 	if (err) {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index cda958309b6c..5543ea891398 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8220,7 +8220,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	unregister_shrinker(&nn->nfsd_client_shrinker);
-	cancel_work(&nn->nfsd_shrinker_work);
+	cancel_work_sync(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 06f4deb550c9..fe3f005d5d55 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -618,8 +618,14 @@ struct inode *nilfs_iget(struct super_block *sb, struct nilfs_root *root,
 	inode = nilfs_iget_locked(sb, root, ino);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+
+	if (!(inode->i_state & I_NEW)) {
+		if (!inode->i_nlink) {
+			iput(inode);
+			return ERR_PTR(-ESTALE);
+		}
 		return inode;
+	}
 
 	err = __nilfs_read_inode(sb, root, ino, inode);
 	if (unlikely(err)) {
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index eeccd69cd797..446af9c21a29 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -67,6 +67,11 @@ nilfs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 		inode = NULL;
 	} else {
 		inode = nilfs_iget(dir->i_sb, NILFS_I(dir)->i_root, ino);
+		if (inode == ERR_PTR(-ESTALE)) {
+			nilfs_error(dir->i_sb,
+					"deleted inode referenced: %lu", ino);
+			return ERR_PTR(-EIO);
+		}
 	}
 
 	return d_splice_alias(inode, dentry);
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 34eef083c988..7659942f7283 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -35,6 +35,8 @@ extern void hv_init_clocksource(void);
 
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
+extern void hv_adj_sched_clock_offset(u64 offset);
+
 static inline notrace u64
 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
 {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index b606a203de88..5e019d26b5b7 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1510,6 +1510,7 @@ struct hv_util_service {
 	void *channel;
 	void (*util_cb)(void *);
 	int (*util_init)(struct hv_util_service *);
+	int (*util_init_transport)(void);
 	void (*util_deinit)(void);
 	int (*util_pre_suspend)(void);
 	int (*util_pre_resume)(void);
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index ce6714bec65f..64cfe7cd292c 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -582,13 +582,16 @@ static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
  * vlan_get_protocol - get protocol EtherType.
  * @skb: skbuff to query
  * @type: first vlan protocol
+ * @mac_offset: MAC offset
  * @depth: buffer to store length of eth and vlan tags in bytes
  *
  * Returns the EtherType of the packet, regardless of whether it is
  * vlan encapsulated (normal or hardware accelerated) or not.
  */
-static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
-					 int *depth)
+static inline __be16 __vlan_get_protocol_offset(const struct sk_buff *skb,
+						__be16 type,
+						int mac_offset,
+						int *depth)
 {
 	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
 
@@ -607,7 +610,8 @@ static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 		do {
 			struct vlan_hdr vhdr, *vh;
 
-			vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
+			vh = skb_header_pointer(skb, mac_offset + vlan_depth,
+						sizeof(vhdr), &vhdr);
 			if (unlikely(!vh || !--parse_depth))
 				return 0;
 
@@ -622,6 +626,12 @@ static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 	return type;
 }
 
+static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
+					 int *depth)
+{
+	return __vlan_get_protocol_offset(skb, type, 0, depth);
+}
+
 /**
  * vlan_get_protocol - get protocol EtherType.
  * @skb: skbuff to query
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 2cd89af4dbf6..68a12caf5eb1 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1142,7 +1142,13 @@ static inline bool mlx5_core_is_vf(const struct mlx5_core_dev *dev)
 	return dev->coredev_type == MLX5_COREDEV_VF;
 }
 
-static inline bool mlx5_core_is_ecpf(struct mlx5_core_dev *dev)
+static inline bool mlx5_core_same_coredev_type(const struct mlx5_core_dev *dev1,
+					       const struct mlx5_core_dev *dev2)
+{
+	return dev1->coredev_type == dev2->coredev_type;
+}
+
+static inline bool mlx5_core_is_ecpf(const struct mlx5_core_dev *dev)
 {
 	return dev->caps.embedded_cpu;
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 31ae4b74d435..3248e4aeec03 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1166,6 +1166,7 @@ static inline struct sk_buff *__pskb_copy(struct sk_buff *skb, int headroom,
 int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail, gfp_t gfp_mask);
 struct sk_buff *skb_realloc_headroom(struct sk_buff *skb,
 				     unsigned int headroom);
+struct sk_buff *skb_expand_head(struct sk_buff *skb, unsigned int headroom);
 struct sk_buff *skb_copy_expand(const struct sk_buff *skb, int newheadroom,
 				int newtailroom, gfp_t priority);
 int __must_check skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 64af1e11ea13..5af2acb9fb7d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -283,7 +283,7 @@ struct trace_event_call {
 	struct list_head	list;
 	struct trace_event_class *class;
 	union {
-		char			*name;
+		const char		*name;
 		/* Set TRACE_EVENT_FL_TRACEPOINT flag when using "tp" */
 		struct tracepoint	*tp;
 	};
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 322dcbfcc933..1ca120344b00 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -428,7 +428,7 @@ static inline const char *node_stat_name(enum node_stat_item item)
 
 static inline const char *lru_list_name(enum lru_list lru)
 {
-	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
+	return node_stat_name(NR_LRU_BASE + (enum node_stat_item)lru) + 3; // skip "nr_"
 }
 
 static inline const char *writeback_stat_name(enum writeback_stat_item item)
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 1663e47681a3..aea01f678b82 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -214,6 +214,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
 #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
 #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
+#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
 
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 484f9cdf2dd0..31edeafeda77 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -609,15 +609,18 @@ struct nft_set_ext_tmpl {
 /**
  *	struct nft_set_ext - set extensions
  *
- *	@genmask: generation mask
+ *	@genmask: generation mask, but also flags (see NFT_SET_ELEM_DEAD_BIT)
  *	@offset: offsets of individual extension types
  *	@data: beginning of extension data
+ *
+ *	This structure must be aligned to word size, otherwise atomic bitops
+ *	on genmask field can cause alignment failure on some archs.
  */
 struct nft_set_ext {
 	u8	genmask;
 	u8	offset[NFT_SET_EXT_NUM];
 	char	data[];
-};
+} __aligned(BITS_PER_LONG / 8);
 
 static inline void nft_set_ext_prepare(struct nft_set_ext_tmpl *tmpl)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index c45958a68978..548f9aab9aa1 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1525,7 +1525,7 @@ static inline bool sk_wmem_schedule(struct sock *sk, int size)
 }
 
 static inline bool
-sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+__sk_rmem_schedule(struct sock *sk, int size, bool pfmemalloc)
 {
 	int delta;
 
@@ -1533,7 +1533,13 @@ sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
 		return true;
 	delta = size - sk->sk_forward_alloc;
 	return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV) ||
-		skb_pfmemalloc(skb);
+	       pfmemalloc;
+}
+
+static inline bool
+sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+{
+	return __sk_rmem_schedule(sk, size, skb_pfmemalloc(skb));
 }
 
 static inline void sk_mem_reclaim(struct sock *sk)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 33ea6ab12f47..db613a97ee5f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -501,6 +501,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -508,7 +510,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 		sizeof(struct bpf_insn) * (prog->len - off - cnt));
 	prog->len -= cnt;
 
-	return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
+	err = bpf_adj_branches(prog, off, off + cnt, off, false);
+	WARN_ON_ONCE(err);
+	return err;
 }
 
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fbe7f8e2b022..b5d9bba73834 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2427,16 +2427,21 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	const struct bpf_link *link = filp->private_data;
 	const struct bpf_prog *prog = link->prog;
+	enum bpf_link_type type = link->type;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 
+	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
+		seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
+	} else {
+		WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u\n", type);
+		seq_printf(m, "link_type:\t<%u>\n", type);
+	}
+	seq_printf(m, "link_id:\t%u\n", link->id);
+
 	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 	seq_printf(m,
-		   "link_type:\t%s\n"
-		   "link_id:\t%u\n"
 		   "prog_tag:\t%s\n"
 		   "prog_id:\t%u\n",
-		   bpf_link_type_strs[link->type],
-		   link->id,
 		   prog_tag,
 		   prog->aux->id);
 	if (link->ops->show_fdinfo)
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 72513ed2a5fc..0df62a3a1f37 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -144,7 +144,7 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
 		return -EIO;
 
-	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
 	if (type)
@@ -238,7 +238,7 @@ static ssize_t default_affinity_write(struct file *file,
 	cpumask_var_t new_value;
 	int err;
 
-	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
 	err = cpumask_parse_user(buffer, count, new_value);
diff --git a/kernel/profile.c b/kernel/profile.c
index 737b1c704aa8..0db1122855c0 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -438,7 +438,7 @@ static ssize_t prof_cpu_mask_proc_write(struct file *file,
 	cpumask_var_t new_value;
 	int err;
 
-	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
 	err = cpumask_parse_user(buffer, count, new_value);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9f5b9036f001..ca39a647f2ef 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4910,7 +4910,10 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	cpumask_var_t tracing_cpumask_new;
 	int err;
 
-	if (!alloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
+	if (count == 0 || count > KMALLOC_MAX_SIZE)
+		return -EINVAL;
+
+	if (!zalloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
 
 	err = cpumask_parse_user(ubuf, count, tracing_cpumask_new);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 164779c6d133..646109d389e9 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -704,7 +704,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 
 static struct notifier_block trace_kprobe_module_nb = {
 	.notifier_call = trace_kprobe_module_callback,
-	.priority = 1	/* Invoked after kprobe module callback */
+	.priority = 2	/* Invoked after kprobe and jump_label module callback */
 };
 
 /* Convert certain expected symbols into '_' when generating event names */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e2b8cee1dbc3..7b05304e5854 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -305,7 +305,14 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
 	if (get_nr_swap_pages() > 0)
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
-
+	/*
+	 * If there are no reclaimable file-backed or anonymous pages,
+	 * ensure zones with sufficient free pages are not skipped.
+	 * This prevents zones like DMA32 from being ignored in reclaim
+	 * scenarios where they can still help alleviate memory pressure.
+	 */
+	if (nr == 0)
+		nr = zone_page_state_snapshot(zone, NR_FREE_PAGES);
 	return nr;
 }
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 0b61575df86e..b80203274d3f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3710,13 +3710,22 @@ static const struct bpf_func_proto bpf_skb_adjust_room_proto = {
 
 static u32 __bpf_skb_min_len(const struct sk_buff *skb)
 {
-	u32 min_len = skb_network_offset(skb);
+	int offset = skb_network_offset(skb);
+	u32 min_len = 0;
 
-	if (skb_transport_header_was_set(skb))
-		min_len = skb_transport_offset(skb);
-	if (skb->ip_summed == CHECKSUM_PARTIAL)
-		min_len = skb_checksum_start_offset(skb) +
-			  skb->csum_offset + sizeof(__sum16);
+	if (offset > 0)
+		min_len = offset;
+	if (skb_transport_header_was_set(skb)) {
+		offset = skb_transport_offset(skb);
+		if (offset > 0)
+			min_len = offset;
+	}
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		offset = skb_checksum_start_offset(skb) +
+			 skb->csum_offset + sizeof(__sum16);
+		if (offset > 0)
+			min_len = offset;
+	}
 	return min_len;
 }
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b0c2d6f01800..754dc7029310 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -79,6 +79,7 @@
 #include <linux/indirect_call_wrapper.h>
 
 #include "datagram.h"
+#include "sock_destructor.h"
 
 struct kmem_cache *skbuff_head_cache __ro_after_init;
 static struct kmem_cache *skbuff_fclone_cache __ro_after_init;
@@ -1732,6 +1733,57 @@ struct sk_buff *skb_realloc_headroom(struct sk_buff *skb, unsigned int headroom)
 }
 EXPORT_SYMBOL(skb_realloc_headroom);
 
+/**
+ *	skb_expand_head - reallocate header of &sk_buff
+ *	@skb: buffer to reallocate
+ *	@headroom: needed headroom
+ *
+ *	Unlike skb_realloc_headroom, this one does not allocate a new skb
+ *	if possible; copies skb->sk to new skb as needed
+ *	and frees original skb in case of failures.
+ *
+ *	It expect increased headroom and generates warning otherwise.
+ */
+
+struct sk_buff *skb_expand_head(struct sk_buff *skb, unsigned int headroom)
+{
+	int delta = headroom - skb_headroom(skb);
+	int osize = skb_end_offset(skb);
+	struct sock *sk = skb->sk;
+
+	if (WARN_ONCE(delta <= 0,
+		      "%s is expecting an increase in the headroom", __func__))
+		return skb;
+
+	delta = SKB_DATA_ALIGN(delta);
+	/* pskb_expand_head() might crash, if skb is shared. */
+	if (skb_shared(skb) || !is_skb_wmem(skb)) {
+		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+
+		if (unlikely(!nskb))
+			goto fail;
+
+		if (sk)
+			skb_set_owner_w(nskb, sk);
+		consume_skb(skb);
+		skb = nskb;
+	}
+	if (pskb_expand_head(skb, delta, 0, GFP_ATOMIC))
+		goto fail;
+
+	if (sk && is_skb_wmem(skb)) {
+		delta = skb_end_offset(skb) - osize;
+		refcount_add(delta, &sk->sk_wmem_alloc);
+		skb->truesize += delta;
+	}
+	return skb;
+
+fail:
+	kfree_skb(skb);
+	return NULL;
+}
+EXPORT_SYMBOL(skb_expand_head);
+
 /**
  *	skb_copy_expand	-	copy and expand sk_buff
  *	@skb: buffer to copy
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 51792dda1b73..890e16bbc072 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -940,9 +940,9 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 		if (tls_sw_has_ctx_rx(sk)) {
 			psock->parser.saved_data_ready(sk);
 		} else {
-			write_lock_bh(&sk->sk_callback_lock);
+			read_lock_bh(&sk->sk_callback_lock);
 			strp_data_ready(&psock->parser.strp);
-			write_unlock_bh(&sk->sk_callback_lock);
+			read_unlock_bh(&sk->sk_callback_lock);
 		}
 	}
 	rcu_read_unlock();
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 85ae2c310148..804464beb343 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -111,7 +111,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		sge = sk_msg_elem(msg, i);
 		size = (apply && apply_bytes < sge->length) ?
 			apply_bytes : sge->length;
-		if (!sk_wmem_schedule(sk, size)) {
+		if (!__sk_rmem_schedule(sk, size, false)) {
 			if (!copied)
 				ret = -ENOMEM;
 			break;
diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 1f7b674b7c58..31ad5ac74ee7 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -201,6 +201,8 @@ static const struct nf_hook_ops ila_nf_hook_ops[] = {
 	},
 };
 
+static DEFINE_MUTEX(ila_mutex);
+
 static int ila_add_mapping(struct net *net, struct ila_xlat_params *xp)
 {
 	struct ila_net *ilan = net_generic(net, ila_net_id);
@@ -208,16 +210,20 @@ static int ila_add_mapping(struct net *net, struct ila_xlat_params *xp)
 	spinlock_t *lock = ila_get_lock(ilan, xp->ip.locator_match);
 	int err = 0, order;
 
-	if (!ilan->xlat.hooks_registered) {
+	if (!READ_ONCE(ilan->xlat.hooks_registered)) {
 		/* We defer registering net hooks in the namespace until the
 		 * first mapping is added.
 		 */
-		err = nf_register_net_hooks(net, ila_nf_hook_ops,
-					    ARRAY_SIZE(ila_nf_hook_ops));
+		mutex_lock(&ila_mutex);
+		if (!ilan->xlat.hooks_registered) {
+			err = nf_register_net_hooks(net, ila_nf_hook_ops,
+						ARRAY_SIZE(ila_nf_hook_ops));
+			if (!err)
+				WRITE_ONCE(ilan->xlat.hooks_registered, true);
+		}
+		mutex_unlock(&ila_mutex);
 		if (err)
 			return err;
-
-		ilan->xlat.hooks_registered = true;
 	}
 
 	ila = kzalloc(sizeof(*ila), GFP_KERNEL);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 26d8105981e9..4da3238836b7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -60,46 +60,33 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct net_device *dev = dst->dev;
+	struct inet6_dev *idev = ip6_dst_idev(dst);
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
-	int delta = hh_len - skb_headroom(skb);
-	const struct in6_addr *nexthop;
+	const struct in6_addr *daddr, *nexthop;
+	struct ipv6hdr *hdr;
 	struct neighbour *neigh;
 	int ret;
 
 	/* Be paranoid, rather than too clever. */
-	if (unlikely(delta > 0) && dev->header_ops) {
-		/* pskb_expand_head() might crash, if skb is shared */
-		if (skb_shared(skb)) {
-			struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
-
-			if (likely(nskb)) {
-				if (skb->sk)
-					skb_set_owner_w(nskb, skb->sk);
-				consume_skb(skb);
-			} else {
-				kfree_skb(skb);
-			}
-			skb = nskb;
-		}
-		if (skb &&
-		    pskb_expand_head(skb, SKB_DATA_ALIGN(delta), 0, GFP_ATOMIC)) {
-			kfree_skb(skb);
-			skb = NULL;
-		}
+	if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
+		/* Make sure idev stays alive */
+		rcu_read_lock();
+		skb = skb_expand_head(skb, hh_len);
 		if (!skb) {
-			IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTDISCARDS);
+			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+			rcu_read_unlock();
 			return -ENOMEM;
 		}
+		rcu_read_unlock();
 	}
 
-	if (ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr)) {
-		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
-
+	hdr = ipv6_hdr(skb);
+	daddr = &hdr->daddr;
+	if (ipv6_addr_is_multicast(daddr)) {
 		if (!(dev->flags & IFF_LOOPBACK) && sk_mc_loop(sk) &&
 		    ((mroute6_is_socket(net, skb) &&
 		     !(IP6CB(skb)->flags & IP6SKB_FORWARDED)) ||
-		     ipv6_chk_mcast_addr(dev, &ipv6_hdr(skb)->daddr,
-					 &ipv6_hdr(skb)->saddr))) {
+		     ipv6_chk_mcast_addr(dev, daddr, &hdr->saddr))) {
 			struct sk_buff *newskb = skb_clone(skb, GFP_ATOMIC);
 
 			/* Do not check for IFF_ALLMULTI; multicast routing
@@ -110,7 +97,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 					net, sk, newskb, NULL, newskb->dev,
 					dev_loopback_xmit);
 
-			if (ipv6_hdr(skb)->hop_limit == 0) {
+			if (hdr->hop_limit == 0) {
 				IP6_INC_STATS(net, idev,
 					      IPSTATS_MIB_OUTDISCARDS);
 				kfree_skb(skb);
@@ -119,9 +106,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 		}
 
 		IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUTMCAST, skb->len);
-
-		if (IPV6_ADDR_MC_SCOPE(&ipv6_hdr(skb)->daddr) <=
-		    IPV6_ADDR_SCOPE_NODELOCAL &&
+		if (IPV6_ADDR_MC_SCOPE(daddr) <= IPV6_ADDR_SCOPE_NODELOCAL &&
 		    !(dev->flags & IFF_LOOPBACK)) {
 			kfree_skb(skb);
 			return 0;
@@ -136,10 +121,10 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	}
 
 	rcu_read_lock_bh();
-	nexthop = rt6_nexthop((struct rt6_info *)dst, &ipv6_hdr(skb)->daddr);
-	neigh = __ipv6_neigh_lookup_noref(dst->dev, nexthop);
+	nexthop = rt6_nexthop((struct rt6_info *)dst, daddr);
+	neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
 	if (unlikely(!neigh))
-		neigh = __neigh_create(&nd_tbl, nexthop, dst->dev, false);
+		neigh = __neigh_create(&nd_tbl, nexthop, dev, false);
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb, false);
@@ -148,7 +133,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	}
 	rcu_read_unlock_bh();
 
-	IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTNOROUTES);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTNOROUTES);
 	kfree_skb(skb);
 	return -EINVAL;
 }
@@ -273,6 +258,8 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev = dst->dev;
+	struct inet6_dev *idev = ip6_dst_idev(dst);
 	unsigned int head_room;
 	struct ipv6hdr *hdr;
 	u8  proto = fl6->flowi6_proto;
@@ -280,22 +267,20 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	int hlimit = -1;
 	u32 mtu;
 
-	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dst->dev);
+	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
-	if (unlikely(skb_headroom(skb) < head_room)) {
-		struct sk_buff *skb2 = skb_realloc_headroom(skb, head_room);
-		if (!skb2) {
-			IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-				      IPSTATS_MIB_OUTDISCARDS);
-			kfree_skb(skb);
+	if (unlikely(head_room > skb_headroom(skb))) {
+		/* Make sure idev stays alive */
+		rcu_read_lock();
+		skb = skb_expand_head(skb, head_room);
+		if (!skb) {
+			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+			rcu_read_unlock();
 			return -ENOBUFS;
 		}
-		if (skb->sk)
-			skb_set_owner_w(skb2, skb->sk);
-		consume_skb(skb);
-		skb = skb2;
+		rcu_read_unlock();
 	}
 
 	if (opt) {
@@ -337,8 +322,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	mtu = dst_mtu(dst);
 	if ((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)) {
-		IP6_UPD_PO_STATS(net, ip6_dst_idev(skb_dst(skb)),
-			      IPSTATS_MIB_OUT, skb->len);
+		IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
 
 		/* if egress device is enslaved to an L3 master device pass the
 		 * skb to its handler for processing
@@ -351,17 +335,17 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		 * we promote our socket to non const
 		 */
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-			       net, (struct sock *)sk, skb, NULL, dst->dev,
+			       net, (struct sock *)sk, skb, NULL, dev,
 			       dst_output);
 	}
 
-	skb->dev = dst->dev;
+	skb->dev = dev;
 	/* ipv6_local_error() does not require socket lock,
 	 * we promote our socket to non const
 	 */
 	ipv6_local_error((struct sock *)sk, EMSGSIZE, fl6, mtu);
 
-	IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_FRAGFAILS);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
 	kfree_skb(skb);
 	return -EMSGSIZE;
 }
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 51bccfb00a9c..61b0159b2fbe 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -124,8 +124,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 	if (unlikely(!pskb_may_pull(skb, llc_len)))
 		return 0;
 
-	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
+	skb_reset_transport_header(skb);
 	if (skb->protocol == htons(ETH_P_802_2)) {
 		__be16 pdulen;
 		s32 data_size;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index e49355cbb1ce..0da845d9d486 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2351,6 +2351,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			WARN(1, "Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.\n");
 		else
 			WARN(1, "Hardware became unavailable during restart.\n");
+		ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
+						IEEE80211_QUEUE_STOP_REASON_SUSPEND,
+						false);
 		ieee80211_handle_reconfig_failure(local);
 		return res;
 	}
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 902ff2f3bc72..5cc35b553a04 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -611,6 +611,8 @@ init_list_set(struct net *net, struct ip_set *set, u32 size)
 	return true;
 }
 
+static struct lock_class_key list_set_lockdep_key;
+
 static int
 list_set_create(struct net *net, struct ip_set *set, struct nlattr *tb[],
 		u32 flags)
@@ -627,6 +629,7 @@ list_set_create(struct net *net, struct ip_set *set, struct nlattr *tb[],
 	if (size < IP_SET_LIST_MIN_SIZE)
 		size = IP_SET_LIST_MIN_SIZE;
 
+	lockdep_set_class(&set->lock, &list_set_lockdep_key);
 	set->variant = &set_variant;
 	set->dsize = ip_set_elem_len(set, tb, sizeof(struct set_elem),
 				     __alignof__(struct set_elem));
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 9269b5e69b9a..8e15a0c96614 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -751,6 +751,12 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	int ret;
 	struct sk_buff *skbn;
 
+	/*
+	 * Reject malformed packets early. Check that it contains at least 2
+	 * addresses and 1 byte more for Time-To-Live
+	 */
+	if (skb->len < 2 * sizeof(ax25_address) + 1)
+		return 0;
 
 	nr_src  = (ax25_address *)(skb->data + 0);
 	nr_dest = (ax25_address *)(skb->data + 7);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 01a191c8194b..2f69cf5270db 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -503,10 +503,8 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
-static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+static u16 vlan_get_tci(const struct sk_buff *skb, struct net_device *dev)
 {
-	u8 *skb_orig_data = skb->data;
-	int skb_orig_len = skb->len;
 	struct vlan_hdr vhdr, *vh;
 	unsigned int header_len;
 
@@ -527,33 +525,21 @@ static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
 	else
 		return 0;
 
-	skb_push(skb, skb->data - skb_mac_header(skb));
-	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
-	if (skb_orig_data != skb->data) {
-		skb->data = skb_orig_data;
-		skb->len = skb_orig_len;
-	}
+	vh = skb_header_pointer(skb, skb_mac_offset(skb) + header_len,
+				sizeof(vhdr), &vhdr);
 	if (unlikely(!vh))
 		return 0;
 
 	return ntohs(vh->h_vlan_TCI);
 }
 
-static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
+static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
 {
 	__be16 proto = skb->protocol;
 
-	if (unlikely(eth_type_vlan(proto))) {
-		u8 *skb_orig_data = skb->data;
-		int skb_orig_len = skb->len;
-
-		skb_push(skb, skb->data - skb_mac_header(skb));
-		proto = __vlan_get_protocol(skb, proto, NULL);
-		if (skb_orig_data != skb->data) {
-			skb->data = skb_orig_data;
-			skb->len = skb_orig_len;
-		}
-	}
+	if (unlikely(eth_type_vlan(proto)))
+		proto = __vlan_get_protocol_offset(skb, proto,
+						   skb_mac_offset(skb), NULL);
 
 	return proto;
 }
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 4ddb43a6644a..8d9c0b98a747 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1541,7 +1541,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	b->backlogs[idx]    -= len;
 	b->tin_backlog      -= len;
 	sch->qstats.backlog -= len;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	flow->dropped++;
 	b->tin_dropped++;
@@ -1552,6 +1551,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	__qdisc_drop(skb, to_free);
 	sch->q.qlen--;
+	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 25d2daaa8122..f3805bee995b 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -124,10 +124,10 @@ static void choke_drop_by_idx(struct Qdisc *sch, unsigned int idx,
 	if (idx == q->tail)
 		choke_zap_tail_holes(q);
 
+	--sch->q.qlen;
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 	qdisc_drop(skb, sch, to_free);
-	--sch->q.qlen;
 }
 
 struct choke_skb_cb {
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 765eb617776b..c333a63c3465 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -134,7 +134,8 @@ static struct sctp_association *sctp_association_init(
 		= 5 * asoc->rto_max;
 
 	asoc->timeouts[SCTP_EVENT_TIMEOUT_SACK] = asoc->sackdelay;
-	asoc->timeouts[SCTP_EVENT_TIMEOUT_AUTOCLOSE] = sp->autoclose * HZ;
+	asoc->timeouts[SCTP_EVENT_TIMEOUT_AUTOCLOSE] =
+		(unsigned long)sp->autoclose * HZ;
 
 	/* Initializes the timers */
 	for (i = SCTP_EVENT_TIMEOUT_NONE; i < SCTP_NUM_TIMEOUT_TYPES; ++i)
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 664ddf5641de..0e0a12f4bb61 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1422,6 +1422,8 @@ static int smc_listen_prfx_check(struct smc_sock *new_smc,
 	if (pclc->hdr.typev1 == SMC_TYPE_N)
 		return 0;
 	pclc_prfx = smc_clc_proposal_get_prefix(pclc);
+	if (!pclc_prfx)
+		return -EPROTO;
 	if (smc_clc_prfx_match(newclcsock, pclc_prfx))
 		return SMC_CLC_DECL_DIFFPREFIX;
 
@@ -1578,7 +1580,9 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
 	struct smc_clc_msg_smcd *pclc_smcd = smc_get_clc_msg_smcd(pclc);
 
 	/* check if ISM V1 is available */
-	if (!(ini->smcd_version & SMC_V1) || !smcd_indicated(ini->smc_type_v1))
+	if (!(ini->smcd_version & SMC_V1) ||
+	    !smcd_indicated(ini->smc_type_v1) ||
+	    !pclc_smcd)
 		goto not_found;
 	ini->is_smcd = true; /* prepare ISM check */
 	ini->ism_peer_gid[0] = ntohll(pclc_smcd->ism.gid);
@@ -2110,6 +2114,13 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 			} else {
 				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 				set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+
+				if (sk->sk_state != SMC_INIT) {
+					/* Race breaker the same way as tcp_poll(). */
+					smp_mb__after_atomic();
+					if (atomic_read(&smc->conn.sndbuf_space))
+						mask |= EPOLLOUT | EPOLLWRNORM;
+				}
 			}
 			if (atomic_read(&smc->conn.bytes_to_rcv))
 				mask |= EPOLLIN | EPOLLRDNORM;
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 5ee5b2ce29a6..2aa69e29fa1d 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -49,6 +49,10 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
 
 	v2_ext = smc_get_clc_v2_ext(pclc);
 	pclc_prfx = smc_clc_proposal_get_prefix(pclc);
+	if (!pclc_prfx ||
+	    pclc_prfx->ipv6_prefixes_cnt > SMC_CLC_MAX_V6_PREFIX)
+		return false;
+
 	if (hdr->version == SMC_V1) {
 		if (hdr->typev1 == SMC_TYPE_N)
 			return false;
@@ -423,6 +427,11 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 						SMC_CLC_RECV_BUF_LEN : datlen;
 		iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, recvlen);
 		len = sock_recvmsg(smc->clcsock, &msg, krflags);
+		if (len < recvlen) {
+			smc->sk.sk_err = EPROTO;
+			reason_code = -EPROTO;
+			goto out;
+		}
 		datlen -= len;
 	}
 	if (clcm->type == SMC_CLC_DECLINE) {
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index c579d1d5995a..a57a3489df4a 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -259,8 +259,12 @@ struct smc_clc_msg_decline {	/* clc decline message */
 static inline struct smc_clc_msg_proposal_prefix *
 smc_clc_proposal_get_prefix(struct smc_clc_msg_proposal *pclc)
 {
+	u16 offset = ntohs(pclc->iparea_offset);
+
+	if (offset > sizeof(struct smc_clc_msg_smcd))
+		return NULL;
 	return (struct smc_clc_msg_proposal_prefix *)
-	       ((u8 *)pclc + sizeof(*pclc) + ntohs(pclc->iparea_offset));
+	       ((u8 *)pclc + sizeof(*pclc) + offset);
 }
 
 static inline bool smcr_indicated(int smc_type)
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 1c9c33f491e6..92b9b9e8bf10 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -719,8 +719,8 @@ static void do_input(char *alias,
 
 	for (i = min / BITS_PER_LONG; i < max / BITS_PER_LONG + 1; i++)
 		arr[i] = TO_NATIVE(arr[i]);
-	for (i = min; i < max; i++)
-		if (arr[i / BITS_PER_LONG] & (1L << (i%BITS_PER_LONG)))
+	for (i = min; i <= max; i++)
+		if (arr[i / BITS_PER_LONG] & (1ULL << (i%BITS_PER_LONG)))
 			sprintf(alias + strlen(alias), "%X,*", i);
 }
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a01e768337cd..69db4720e2a9 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -970,7 +970,10 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 					xpermd->driver))
 			return;
 	} else {
-		BUG();
+		pr_warn_once(
+			"SELinux: unknown extended permission (%u) will be ignored\n",
+			node->datum.u.xperms->specified);
+		return;
 	}
 
 	if (node->key.specified == AVTAB_XPERMS_ALLOWED) {
@@ -1007,7 +1010,8 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 					node->datum.u.xperms->perms.p[i];
 		}
 	} else {
-		BUG();
+		pr_warn_once("SELinux: unknown specified key (%u)\n",
+			     node->key.specified);
 	}
 }
 
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 30025716164a..40853b26a1c3 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -238,6 +238,7 @@ enum {
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
 	CXT_PINCFG_TOP_SPEAKER,
+	CXT_FIXUP_HP_A_U,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -705,6 +706,18 @@ static void cxt_setup_mute_led(struct hda_codec *codec,
 	}
 }
 
+static void cxt_setup_gpio_unmute(struct hda_codec *codec,
+				  unsigned int gpio_mute_mask)
+{
+	if (gpio_mute_mask) {
+		// set gpio data to 0.
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK, gpio_mute_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION, gpio_mute_mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_STICKY_MASK, 0);
+	}
+}
+
 static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -719,6 +732,15 @@ static void cxt_fixup_hp_zbook_mute_led(struct hda_codec *codec,
 		cxt_setup_mute_led(codec, 0x10, 0x20);
 }
 
+static void cxt_fixup_hp_a_u(struct hda_codec *codec,
+			     const struct hda_fixup *fix, int action)
+{
+	// Init vers in BIOS mute the spk/hp by set gpio high to avoid pop noise,
+	// so need to unmute once by clearing the gpio data when runs into the system.
+	if (action == HDA_FIXUP_ACT_INIT)
+		cxt_setup_gpio_unmute(codec, 0x2);
+}
+
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
 	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
@@ -943,6 +965,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_sirius_top_speaker,
 	},
+	[CXT_FIXUP_HP_A_U] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_hp_a_u,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -1017,6 +1043,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8457, "HP Z2 G4 mini", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8458, "HP Z2 G4 mini premium", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
+	SND_PCI_QUIRK(0x14f1, 0x0252, "MBX-Z60MR100", CXT_FIXUP_HP_A_U),
 	SND_PCI_QUIRK(0x14f1, 0x0265, "SWS JS201D", CXT_PINCFG_SWS_JS201D),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
@@ -1062,6 +1089,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
 	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
 	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
+	{ .id = CXT_FIXUP_HP_A_U, .name = "HP-U-support" },
 	{}
 };
 
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 29ed301c6f06..552094012c49 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -61,6 +61,8 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
 			/* flag potentially raw DSD capable altsettings */
 			fp->dsd_raw = true;
+			/* clear special format bit to avoid "unsupported format" msg below */
+			format &= ~UAC2_FORMAT_TYPE_I_RAW_DATA;
 		}
 
 		format <<= 1;
@@ -72,8 +74,11 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		sample_width = as->bBitResolution;
 		sample_bytes = as->bSubslotSize;
 
-		if (format & UAC3_FORMAT_TYPE_I_RAW_DATA)
+		if (format & UAC3_FORMAT_TYPE_I_RAW_DATA) {
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
+			/* clear special format bit to avoid "unsupported format" msg below */
+			format &= ~UAC3_FORMAT_TYPE_I_RAW_DATA;
+		}
 
 		format <<= 1;
 		break;
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index b598f8f0d06e..8826a588f5ab 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1932,6 +1932,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 		bmaControls = ftr->bmaControls;
 	}
 
+	if (channels > 32) {
+		usb_audio_info(state->chip,
+			       "usbmixer: too many channels (%d) in unit %d\n",
+			       channels, unitid);
+		return -EINVAL;
+	}
+
 	/* parse the source unit */
 	err = parse_audio_unit(state, hdr->bSourceID);
 	if (err < 0)
diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index bd63a9ce6a70..3959bbad0c4f 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -687,7 +687,7 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 	struct usb_mixer_elem_info *elem = kcontrol->private_data;
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_meter_store *store = elem->private_data;
-	u8 meter_urb[64];
+	u8 meter_urb[64] = {0};
 
 	switch (kcontrol->private_value) {
 	case 0: {

