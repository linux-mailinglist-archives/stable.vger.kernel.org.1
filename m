Return-Path: <stable+bounces-163278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E8AB09294
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852303AF1BE
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6202F8C34;
	Thu, 17 Jul 2025 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fljji3t4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A112F8C31;
	Thu, 17 Jul 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771824; cv=none; b=CIPd8Pnxx7FHtY9H3OSXCGXtoey8RPxqqZx9dsQXsWml/jeSf4/E5ehKCPZ3J51KWBsCgX42kzIS8vWP0MprVxpsuYL0PNdWhGfUQF8wCpKFn425Vx3SE3Z6BVUzYjzx331gfvMFHOPprkCaAgqM4y56YR5zYmPODWI56o3G0Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771824; c=relaxed/simple;
	bh=zFiKKX3gaRTDw2hLDbiRGwT/KYbAWDwe9EOUILvmZqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kl02SKT/w1ANk63TqH4z/Vg3gR9jOSH7PsXx86MiYOX9hyoDbtu4hDRwUi+QQQmY9uCNtzQvwFZ5rnZ17Y09LV3KA4mo9JaLCEYWJBvvoCpGG+np/j1UASCbjXJGUlOWcOvhl/o0i790tC2hgtrLnvo0g9Hs0nmPMb8318XPfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fljji3t4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD5BC4CEE3;
	Thu, 17 Jul 2025 17:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771823;
	bh=zFiKKX3gaRTDw2hLDbiRGwT/KYbAWDwe9EOUILvmZqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fljji3t4miLiWk1vOJVhXH+VzwqKQlBzqPmAm/MHeI9Vu9U82EnUxd6bXtiJiQ8Qx
	 SM+XpVjnwVhcw/kmmhusRGgpRHZnf6dnmIN3XJ0RwH8jsMkALQT7O3luxLC0yo1ill
	 3QP4eKpm6+lWYfFOnKnqrD1YMeYqJMzMaYqximLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.296
Date: Thu, 17 Jul 2025 19:03:31 +0200
Message-ID: <2025071731-deputy-sandbank-f79b@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071731-commute-punisher-1648@gregkh>
References: <2025071731-commute-punisher-1648@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 016724ec26d5..7318565d68f5 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -589,7 +589,7 @@ Description:	This file shows the thin provisioning type. This is one of
 		about the descriptor could be found at UFS specifications 2.1.
 		The file is read only.
 
-What:		/sys/class/scsi_device/*/device/unit_descriptor/physical_memory_resourse_count
+What:		/sys/class/scsi_device/*/device/unit_descriptor/physical_memory_resource_count
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the total physical memory resources. This is
diff --git a/Makefile b/Makefile
index 730f498dd1ef..f65e282f4a3f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 295
+SUBLEVEL = 296
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8e934bb44f12..ef94bf75b433 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1041,7 +1041,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	next = addr;
 	end = addr + PUD_SIZE;
 	do {
-		pmd_free_pte_page(pmdp, next);
+		if (pmd_present(READ_ONCE(*pmdp)))
+			pmd_free_pte_page(pmdp, next);
 	} while (pmdp++, next += PMD_SIZE, next != end);
 
 	pud_clear(pudp);
diff --git a/arch/powerpc/include/uapi/asm/ioctls.h b/arch/powerpc/include/uapi/asm/ioctls.h
index 2c145da3b774..b5211e413829 100644
--- a/arch/powerpc/include/uapi/asm/ioctls.h
+++ b/arch/powerpc/include/uapi/asm/ioctls.h
@@ -23,10 +23,10 @@
 #define TCSETSW		_IOW('t', 21, struct termios)
 #define TCSETSF		_IOW('t', 22, struct termios)
 
-#define TCGETA		_IOR('t', 23, struct termio)
-#define TCSETA		_IOW('t', 24, struct termio)
-#define TCSETAW		_IOW('t', 25, struct termio)
-#define TCSETAF		_IOW('t', 28, struct termio)
+#define TCGETA		0x40147417 /* _IOR('t', 23, struct termio) */
+#define TCSETA		0x80147418 /* _IOW('t', 24, struct termio) */
+#define TCSETAW		0x80147419 /* _IOW('t', 25, struct termio) */
+#define TCSETAF		0x8014741c /* _IOW('t', 28, struct termio) */
 
 #define TCSBRK		_IO('t', 29)
 #define TCXONC		_IO('t', 30)
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 71e3d7c0b870..22dc393b5a83 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -23,7 +23,7 @@ endif
 aflags_dwarf	:= -Wa,-gdwarf-2
 KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -std=gnu11
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 9de56065f28c..2f4d8422bdfb 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -20,7 +20,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index a1afe414ce48..fb5b1e7c133d 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -41,7 +41,7 @@ int start_io_thread(unsigned long sp, int *fd_out)
 	*fd_out = fds[1];
 
 	err = os_set_fd_block(*fd_out, 0);
-	err = os_set_fd_block(kernel_fd, 0);
+	err |= os_set_fd_block(kernel_fd, 0);
 	if (err) {
 		printk("start_io_thread - failed to set nonblocking I/O.\n");
 		goto out_close;
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e92b5eb57acd..30e1b61bc10a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -95,7 +95,7 @@ config X86
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
-	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select BUILDTIME_EXTABLE_SORT
 	select CLKEVT_I8253
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1cf34fcc3a8e..816b3d0512ba 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -290,7 +290,6 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 struct thresh_restart {
 	struct threshold_block	*b;
-	int			reset;
 	int			set_lvt_off;
 	int			lvt_off;
 	u16			old_limit;
@@ -381,13 +380,13 @@ static void threshold_restart_bank(void *_tr)
 
 	rdmsr(tr->b->address, lo, hi);
 
-	if (tr->b->threshold_limit < (hi & THRESHOLD_MAX))
-		tr->reset = 1;	/* limit cannot be lower than err count */
-
-	if (tr->reset) {		/* reset err count and overflow bit */
-		hi =
-		    (hi & ~(MASK_ERR_COUNT_HI | MASK_OVERFLOW_HI)) |
-		    (THRESHOLD_MAX - tr->b->threshold_limit);
+	/*
+	 * Reset error count and overflow bit.
+	 * This is done during init or after handling an interrupt.
+	 */
+	if (hi & MASK_OVERFLOW_HI || tr->set_lvt_off) {
+		hi &= ~(MASK_ERR_COUNT_HI | MASK_OVERFLOW_HI);
+		hi |= THRESHOLD_MAX - tr->b->threshold_limit;
 	} else if (tr->old_limit) {	/* change limit w/o reset */
 		int new_count = (hi & THRESHOLD_MAX) +
 		    (tr->old_limit - tr->b->threshold_limit);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f7e0c9549bb9..504106361bc3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2464,15 +2464,9 @@ static int mce_cpu_dead(unsigned int cpu)
 static int mce_cpu_online(unsigned int cpu)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
-	int ret;
 
 	mce_device_create(cpu);
-
-	ret = mce_threshold_create_device(cpu);
-	if (ret) {
-		mce_device_remove(cpu);
-		return ret;
-	}
+	mce_threshold_create_device(cpu);
 	mce_reenable_cpu();
 	mce_start_timer(t);
 	return 0;
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index f2350967a898..4e893e583009 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -516,4 +516,5 @@ void mce_intel_feature_init(struct cpuinfo_x86 *c)
 void mce_intel_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
+	cmci_clear();
 }
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 35de23ff50d6..3e7e28b7947e 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -128,8 +128,11 @@ static void round_robin_cpu(unsigned int tsk_index)
 static void exit_round_robin(unsigned int tsk_index)
 {
 	struct cpumask *pad_busy_cpus = to_cpumask(pad_busy_cpus_bits);
-	cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
-	tsk_in_cpu[tsk_index] = -1;
+
+	if (tsk_in_cpu[tsk_index] != -1) {
+		cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
+		tsk_in_cpu[tsk_index] = -1;
+	}
 }
 
 static unsigned int idle_pct = 5; /* percentage */
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 603483f8332b..203e9ee47fdb 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -483,6 +483,13 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 		return_ACPI_STATUS(AE_NULL_OBJECT);
 	}
 
+	if (this_walk_state->num_operands < obj_desc->method.param_count) {
+		ACPI_ERROR((AE_INFO, "Missing argument for method [%4.4s]",
+			    acpi_ut_get_node_name(method_node)));
+
+		return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
+	}
+
 	/* Init for new method, possibly wait on method mutex */
 
 	status =
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index a5e120eca7f3..cf853e985d6d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -266,23 +266,10 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN) {
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
 			ret = -ENODEV;
-			break;
-		}
-
-		val->intval = battery->rate_now * 1000;
-		/*
-		 * When discharging, the current should be reported as a
-		 * negative number as per the power supply class interface
-		 * definition.
-		 */
-		if (psp == POWER_SUPPLY_PROP_CURRENT_NOW &&
-		    (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
-		    acpi_battery_handle_discharging(battery)
-				== POWER_SUPPLY_STATUS_DISCHARGING)
-			val->intval = -val->intval;
-
+		else
+			val->intval = battery->rate_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 760ac6e65216..3737d1bf1539 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -27,7 +27,7 @@
 #include <scsi/scsi_host.h>
 #include <linux/dmi.h>
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86) && defined(CONFIG_X86_32)
 #include <asm/msr.h>
 static int use_msr;
 module_param_named(msr, use_msr, int, 0644);
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 06e2fea1ffa9..03b3b9c7c8b5 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -849,6 +849,8 @@ queue_skb(struct idt77252_dev *card, struct vc_map *vc,
 
 	IDT77252_PRV_PADDR(skb) = dma_map_single(&card->pcidev->dev, skb->data,
 						 skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(&card->pcidev->dev, IDT77252_PRV_PADDR(skb)))
+		return -ENOMEM;
 
 	error = -EINVAL;
 
@@ -1862,6 +1864,8 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 		paddr = dma_map_single(&card->pcidev->dev, skb->data,
 				       skb_end_pointer(skb) - skb->data,
 				       DMA_FROM_DEVICE);
+		if (dma_mapping_error(&card->pcidev->dev, paddr))
+			goto outpoolrm;
 		IDT77252_PRV_PADDR(skb) = paddr;
 
 		if (push_rx_skb(card, skb, queue)) {
@@ -1876,6 +1880,7 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 	dma_unmap_single(&card->pcidev->dev, IDT77252_PRV_PADDR(skb),
 			 skb_end_pointer(skb) - skb->data, DMA_FROM_DEVICE);
 
+outpoolrm:
 	handle = IDT77252_PRV_POOL(skb);
 	card->sbpool[POOL_QUEUE(handle)].skb[POOL_INDEX(handle)] = NULL;
 
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 242a9ec295cf..f00ecbaa7868 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -558,10 +558,13 @@ long dma_resv_wait_timeout_rcu(struct dma_resv *obj,
 			goto retry;
 		}
 
-		ret = dma_fence_wait_timeout(fence, intr, ret);
+		ret = dma_fence_wait_timeout(fence, intr, timeout);
 		dma_fence_put(fence);
 		if (ret > 0 && wait_all && (i + 1 < shared_count))
 			goto retry;
+		/* Even for zero timeout the return value is 1 */
+		if (ret > 0 && timeout == 0)
+			ret = 1;
 	}
 	return ret;
 
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index be44c86a1e03..5b5cbea997ff 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2490,6 +2490,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		return -EINVAL;
 	}
 
+	xdev->common.directions |= chan->direction;
+
 	/* Request the interrupt */
 	chan->irq = irq_of_parse_and_map(node, 0);
 	err = request_irq(chan->irq, xilinx_dma_irq_handler, IRQF_SHARED,
diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index 9c3f9110895e..a62e1633d095 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -609,15 +609,18 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
 	unsigned long dsi_hss_hsa_hse_hbp;
 	unsigned int nlanes = output->dev->lanes;
+	int mode_clock = (mode_valid_check ? mode->clock : mode->crtc_clock);
 	int ret;
 
 	ret = cdns_dsi_mode2cfg(dsi, mode, dsi_cfg, mode_valid_check);
 	if (ret)
 		return ret;
 
-	phy_mipi_dphy_get_default_config(mode->crtc_clock * 1000,
-					 mipi_dsi_pixel_format_to_bpp(output->dev->format),
-					 nlanes, phy_cfg);
+	ret = phy_mipi_dphy_get_default_config(mode_clock * 1000,
+					       mipi_dsi_pixel_format_to_bpp(output->dev->format),
+					       nlanes, phy_cfg);
+	if (ret)
+		return ret;
 
 	ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, mode, mode_valid_check);
 	if (ret)
@@ -958,7 +961,7 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
 	if (!IS_ERR(panel)) {
 		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_DSI);
 	} else {
-		bridge = of_drm_find_bridge(dev->dev.of_node);
+		bridge = of_drm_find_bridge(np);
 		if (!bridge)
 			bridge = ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index afca5fc46020..a0049ee129ed 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -595,6 +595,10 @@ static irqreturn_t decon_irq_handler(int irq, void *dev_id)
 	if (!ctx->drm_dev)
 		goto out;
 
+	/* check if crtc and vblank have been initialized properly */
+	if (!drm_dev_has_vblank(ctx->drm_dev))
+		goto out;
+
 	if (!ctx->i80_if) {
 		drm_crtc_handle_vblank(&ctx->crtc->base);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 4fe4ca41665b..1978491d3f84 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -182,6 +182,7 @@ struct fimd_context {
 	u32				i80ifcon;
 	bool				i80_if;
 	bool				suspended;
+	bool				dp_clk_enabled;
 	wait_queue_head_t		wait_vsync_queue;
 	atomic_t			wait_vsync_event;
 	atomic_t			win_updated;
@@ -1003,7 +1004,18 @@ static void fimd_dp_clock_enable(struct exynos_drm_clk *clk, bool enable)
 	struct fimd_context *ctx = container_of(clk, struct fimd_context,
 						dp_clk);
 	u32 val = enable ? DP_MIE_CLK_DP_ENABLE : DP_MIE_CLK_DISABLE;
+
+	if (enable == ctx->dp_clk_enabled)
+		return;
+
+	if (enable)
+		pm_runtime_resume_and_get(ctx->dev);
+
+	ctx->dp_clk_enabled = enable;
 	writel(val, ctx->regs + DP_MIE_CLKCON);
+
+	if (!enable)
+		pm_runtime_put(ctx->dev);
 }
 
 static const struct exynos_drm_crtc_ops fimd_crtc_ops = {
diff --git a/drivers/gpu/drm/i915/gt/intel_ringbuffer.c b/drivers/gpu/drm/i915/gt/intel_ringbuffer.c
index 125f7bb67bee..57593600a8cc 100644
--- a/drivers/gpu/drm/i915/gt/intel_ringbuffer.c
+++ b/drivers/gpu/drm/i915/gt/intel_ringbuffer.c
@@ -1475,7 +1475,6 @@ static int ring_context_alloc(struct intel_context *ce)
 	/* One ringbuffer to rule them all */
 	GEM_BUG_ON(!engine->legacy.ring);
 	ce->ring = engine->legacy.ring;
-	ce->timeline = intel_timeline_get(engine->legacy.timeline);
 
 	GEM_BUG_ON(ce->state);
 	if (engine->context_size) {
@@ -1488,6 +1487,8 @@ static int ring_context_alloc(struct intel_context *ce)
 		ce->state = vma;
 	}
 
+	ce->timeline = intel_timeline_get(engine->legacy.timeline);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index b3688543ed7d..6ee24f206161 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -47,8 +47,10 @@ static int igt_add_request(void *arg)
 
 	mutex_lock(&i915->drm.struct_mutex);
 	request = mock_request(i915->engine[RCS0]->kernel_context, HZ / 10);
-	if (!request)
+	if (IS_ERR(request)) {
+		err = PTR_ERR(request);
 		goto out_unlock;
+	}
 
 	i915_request_add(request);
 
@@ -69,8 +71,8 @@ static int igt_wait_request(void *arg)
 
 	mutex_lock(&i915->drm.struct_mutex);
 	request = mock_request(i915->engine[RCS0]->kernel_context, T);
-	if (!request) {
-		err = -ENOMEM;
+	if (IS_ERR(request)) {
+		err = PTR_ERR(request);
 		goto out_unlock;
 	}
 	i915_request_get(request);
@@ -142,8 +144,8 @@ static int igt_fence_wait(void *arg)
 
 	mutex_lock(&i915->drm.struct_mutex);
 	request = mock_request(i915->engine[RCS0]->kernel_context, T);
-	if (!request) {
-		err = -ENOMEM;
+	if (IS_ERR(request)) {
+		err = PTR_ERR(request);
 		goto out_locked;
 	}
 
@@ -203,8 +205,8 @@ static int igt_request_rewind(void *arg)
 	GEM_BUG_ON(IS_ERR(ce));
 	request = mock_request(ce, 2 * HZ);
 	intel_context_put(ce);
-	if (!request) {
-		err = -ENOMEM;
+	if (IS_ERR(request)) {
+		err = PTR_ERR(request);
 		goto err_context_0;
 	}
 
@@ -216,8 +218,8 @@ static int igt_request_rewind(void *arg)
 	GEM_BUG_ON(IS_ERR(ce));
 	vip = mock_request(ce, 0);
 	intel_context_put(ce);
-	if (!vip) {
-		err = -ENOMEM;
+	if (IS_ERR(vip)) {
+		err = PTR_ERR(vip);
 		goto err_context_1;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_request.c b/drivers/gpu/drm/i915/selftests/mock_request.c
index 09f747228dff..1b0cf073e964 100644
--- a/drivers/gpu/drm/i915/selftests/mock_request.c
+++ b/drivers/gpu/drm/i915/selftests/mock_request.c
@@ -35,7 +35,7 @@ mock_request(struct intel_context *ce, unsigned long delay)
 	/* NB the i915->requests slab cache is enlarged to fit mock_request */
 	request = intel_context_create_request(ce);
 	if (IS_ERR(request))
-		return NULL;
+		return request;
 
 	request->mock.delay = delay;
 	return request;
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 923899b95c88..ebc0cd4d7862 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1103,10 +1103,16 @@ static struct drm_plane *tegra_dc_add_shared_planes(struct drm_device *drm,
 		if (wgrp->dc == dc->pipe) {
 			for (j = 0; j < wgrp->num_windows; j++) {
 				unsigned int index = wgrp->windows[j];
+				enum drm_plane_type type;
+
+				if (primary)
+					type = DRM_PLANE_TYPE_OVERLAY;
+				else
+					type = DRM_PLANE_TYPE_PRIMARY;
 
 				plane = tegra_shared_plane_create(drm, dc,
 								  wgrp->index,
-								  index);
+								  index, type);
 				if (IS_ERR(plane))
 					return plane;
 
@@ -1114,10 +1120,8 @@ static struct drm_plane *tegra_dc_add_shared_planes(struct drm_device *drm,
 				 * Choose the first shared plane owned by this
 				 * head as the primary plane.
 				 */
-				if (!primary) {
-					plane->type = DRM_PLANE_TYPE_PRIMARY;
+				if (!primary)
 					primary = plane;
-				}
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 767fb440a79d..11307a80d575 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -533,9 +533,9 @@ static const struct drm_plane_helper_funcs tegra_shared_plane_helper_funcs = {
 struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
 					    struct tegra_dc *dc,
 					    unsigned int wgrp,
-					    unsigned int index)
+					    unsigned int index,
+					    enum drm_plane_type type)
 {
-	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
 	struct tegra_drm *tegra = drm->dev_private;
 	struct tegra_display_hub *hub = tegra->hub;
 	/* planes can be assigned to arbitrary CRTCs */
diff --git a/drivers/gpu/drm/tegra/hub.h b/drivers/gpu/drm/tegra/hub.h
index 767a60d9313c..646d6a57c0ae 100644
--- a/drivers/gpu/drm/tegra/hub.h
+++ b/drivers/gpu/drm/tegra/hub.h
@@ -81,7 +81,8 @@ void tegra_display_hub_cleanup(struct tegra_display_hub *hub);
 struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
 					    struct tegra_dc *dc,
 					    unsigned int wgrp,
-					    unsigned int index);
+					    unsigned int index,
+					    enum drm_plane_type type);
 
 int tegra_display_hub_atomic_check(struct drm_device *drm,
 				   struct drm_atomic_state *state);
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 9a35c555ec52..6236e0446b30 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -38,6 +38,12 @@ struct v3d_queue_state {
 	u64 emit_seqno;
 };
 
+enum v3d_irq {
+	V3D_CORE_IRQ,
+	V3D_HUB_IRQ,
+	V3D_MAX_IRQS,
+};
+
 struct v3d_dev {
 	struct drm_device drm;
 
@@ -49,6 +55,9 @@ struct v3d_dev {
 
 	struct device *dev;
 	struct platform_device *pdev;
+
+	int irq[V3D_MAX_IRQS];
+
 	void __iomem *hub_regs;
 	void __iomem *core_regs[3];
 	void __iomem *bridge_regs;
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 1609a85429ce..d994e3ce20d2 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -120,6 +120,8 @@ v3d_reset(struct v3d_dev *v3d)
 	if (false)
 		v3d_idle_axi(v3d, 0);
 
+	v3d_irq_disable(v3d);
+
 	v3d_idle_gca(v3d);
 	v3d_reset_v3d(v3d);
 
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 41705436a748..f0a9310cefc1 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -218,7 +218,7 @@ v3d_hub_irq(int irq, void *arg)
 int
 v3d_irq_init(struct v3d_dev *v3d)
 {
-	int irq1, ret, core;
+	int irq, ret, core;
 
 	INIT_WORK(&v3d->overflow_mem_work, v3d_overflow_mem_work);
 
@@ -229,16 +229,24 @@ v3d_irq_init(struct v3d_dev *v3d)
 		V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS);
 	V3D_WRITE(V3D_HUB_INT_CLR, V3D_HUB_IRQS);
 
-	irq1 = platform_get_irq(v3d->pdev, 1);
-	if (irq1 == -EPROBE_DEFER)
-		return irq1;
-	if (irq1 > 0) {
-		ret = devm_request_irq(v3d->dev, irq1,
+	irq = platform_get_irq(v3d->pdev, 1);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+	if (irq > 0) {
+		v3d->irq[V3D_CORE_IRQ] = irq;
+
+		ret = devm_request_irq(v3d->dev, v3d->irq[V3D_CORE_IRQ],
 				       v3d_irq, IRQF_SHARED,
 				       "v3d_core0", v3d);
 		if (ret)
 			goto fail;
-		ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
+
+		irq = platform_get_irq(v3d->pdev, 0);
+		if (irq < 0)
+			return irq;
+		v3d->irq[V3D_HUB_IRQ] = irq;
+
+		ret = devm_request_irq(v3d->dev, v3d->irq[V3D_HUB_IRQ],
 				       v3d_hub_irq, IRQF_SHARED,
 				       "v3d_hub", v3d);
 		if (ret)
@@ -246,7 +254,12 @@ v3d_irq_init(struct v3d_dev *v3d)
 	} else {
 		v3d->single_irq_line = true;
 
-		ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
+		irq = platform_get_irq(v3d->pdev, 0);
+		if (irq < 0)
+			return irq;
+		v3d->irq[V3D_CORE_IRQ] = irq;
+
+		ret = devm_request_irq(v3d->dev, v3d->irq[V3D_CORE_IRQ],
 				       v3d_irq, IRQF_SHARED,
 				       "v3d", v3d);
 		if (ret)
@@ -281,12 +294,19 @@ void
 v3d_irq_disable(struct v3d_dev *v3d)
 {
 	int core;
+	int i;
 
 	/* Disable all interrupts. */
 	for (core = 0; core < v3d->cores; core++)
 		V3D_CORE_WRITE(core, V3D_CTL_INT_MSK_SET, ~0);
 	V3D_WRITE(V3D_HUB_INT_MSK_SET, ~0);
 
+	/* Finish any interrupt handler still in flight. */
+	for (i = 0; i < V3D_MAX_IRQS; i++) {
+		if (v3d->irq[i])
+			synchronize_irq(v3d->irq[i]);
+	}
+
 	/* Clear any pending interrupts we might have left. */
 	for (core = 0; core < v3d->cores; core++)
 		V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 356916608cc4..d2e355a9744a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -280,6 +280,8 @@
 #define USB_DEVICE_ID_ASUS_AK1D		0x1125
 #define USB_DEVICE_ID_CHICONY_TOSHIBA_WT10A	0x1408
 #define USB_DEVICE_ID_CHICONY_ACER_SWITCH12	0x1421
+#define USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA	0xb824
+#define USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA2	0xb82c
 
 #define USB_VENDOR_ID_CHUNGHWAT		0x2247
 #define USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH	0x0001
@@ -1347,4 +1349,7 @@
 #define USB_VENDOR_ID_SIGNOTEC			0x2133
 #define USB_DEVICE_ID_SIGNOTEC_VIEWSONIC_PD1011	0x0018
 
+#define USB_VENDOR_ID_SMARTLINKTECHNOLOGY              0x4c4a
+#define USB_DEVICE_ID_SMARTLINKTECHNOLOGY_4155         0x4155
+
 #endif
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index ff1a9d142cdd..d1cfd45f2585 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -732,6 +732,8 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, USB_DEVICE_ID_AVER_FM_MR800) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AXENTIA, USB_DEVICE_ID_AXENTIA_FM_RADIO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_HP_5MP_CAMERA2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CIDC, 0x0103) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI470X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI4713) },
@@ -879,6 +881,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SMARTLINKTECHNOLOGY, USB_DEVICE_ID_SMARTLINKTECHNOLOGY_4155) },
 	{ }
 };
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0f1c7a2f5185..abbfb53bb7dc 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2020,14 +2020,18 @@ static int wacom_initialize_remotes(struct wacom *wacom)
 
 	remote->remote_dir = kobject_create_and_add("wacom_remote",
 						    &wacom->hdev->dev.kobj);
-	if (!remote->remote_dir)
+	if (!remote->remote_dir) {
+		kfifo_free(&remote->remote_fifo);
 		return -ENOMEM;
+	}
 
 	error = sysfs_create_files(remote->remote_dir, remote_unpair_attrs);
 
 	if (error) {
 		hid_err(wacom->hdev,
 			"cannot create sysfs group err: %d\n", error);
+		kfifo_free(&remote->remote_fifo);
+		kobject_put(remote->remote_dir);
 		return error;
 	}
 
diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index 66dfa211e736..8e4cf9028b23 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -111,6 +111,11 @@ static u32 osif_func(struct i2c_adapter *adapter)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
+/* prevent invalid 0-length usb_control_msg */
+static const struct i2c_adapter_quirks osif_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+};
+
 static const struct i2c_algorithm osif_algorithm = {
 	.master_xfer	= osif_xfer,
 	.functionality	= osif_func,
@@ -143,6 +148,7 @@ static int osif_probe(struct usb_interface *interface,
 
 	priv->adapter.owner = THIS_MODULE;
 	priv->adapter.class = I2C_CLASS_HWMON;
+	priv->adapter.quirks = &osif_quirks;
 	priv->adapter.algo = &osif_algorithm;
 	priv->adapter.algo_data = priv;
 	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 43e3603489ee..5671f5115360 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -140,6 +140,11 @@ static u32 usb_func(struct i2c_adapter *adapter)
 	return ret;
 }
 
+/* prevent invalid 0-length usb_control_msg */
+static const struct i2c_adapter_quirks usb_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+};
+
 /* This is the actual algorithm we define */
 static const struct i2c_algorithm usb_algorithm = {
 	.master_xfer	= usb_xfer,
@@ -246,6 +251,7 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	/* setup i2c adapter description */
 	dev->adapter.owner = THIS_MODULE;
 	dev->adapter.class = I2C_CLASS_HWMON;
+	dev->adapter.quirks = &usb_quirks;
 	dev->adapter.algo = &usb_algorithm;
 	dev->adapter.algo_data = dev;
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name),
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index df60b3d91dad..85ca48f2fe66 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -581,7 +581,7 @@ static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
 	struct {
 		u32 pressure;
 		u16 temperature;
-		u64 timestamp;
+		aligned_s64 timestamp;
 	}   sample;
 	int err;
 
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c46d68e6ccd0..cf3c0d6928ac 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2683,6 +2683,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, unmap_fmr);
 
 	SET_OBJ_SIZE(dev_ops, ib_ah);
+	SET_OBJ_SIZE(dev_ops, ib_counters);
 	SET_OBJ_SIZE(dev_ops, ib_cq);
 	SET_OBJ_SIZE(dev_ops, ib_pd);
 	SET_OBJ_SIZE(dev_ops, ib_srq);
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 44362f693df9..ce41f235af25 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -211,8 +211,7 @@ static void free_cm_id(struct iwcm_id_private *cm_id_priv)
  */
 static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
 {
-	BUG_ON(atomic_read(&cm_id_priv->refcount)==0);
-	if (atomic_dec_and_test(&cm_id_priv->refcount)) {
+	if (refcount_dec_and_test(&cm_id_priv->refcount)) {
 		BUG_ON(!list_empty(&cm_id_priv->work_list));
 		free_cm_id(cm_id_priv);
 		return 1;
@@ -225,7 +224,7 @@ static void add_ref(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
 	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
-	atomic_inc(&cm_id_priv->refcount);
+	refcount_inc(&cm_id_priv->refcount);
 }
 
 static void rem_ref(struct iw_cm_id *cm_id)
@@ -257,7 +256,7 @@ struct iw_cm_id *iw_create_cm_id(struct ib_device *device,
 	cm_id_priv->id.add_ref = add_ref;
 	cm_id_priv->id.rem_ref = rem_ref;
 	spin_lock_init(&cm_id_priv->lock);
-	atomic_set(&cm_id_priv->refcount, 1);
+	refcount_set(&cm_id_priv->refcount, 1);
 	init_waitqueue_head(&cm_id_priv->connect_wait);
 	init_completion(&cm_id_priv->destroy_comp);
 	INIT_LIST_HEAD(&cm_id_priv->work_list);
@@ -368,12 +367,9 @@ EXPORT_SYMBOL(iw_cm_disconnect);
 /*
  * CM_ID <-- DESTROYING
  *
- * Clean up all resources associated with the connection and release
- * the initial reference taken by iw_create_cm_id.
- *
- * Returns true if and only if the last cm_id_priv reference has been dropped.
+ * Clean up all resources associated with the connection.
  */
-static bool destroy_cm_id(struct iw_cm_id *cm_id)
+static void destroy_cm_id(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
 	struct ib_qp *qp;
@@ -442,20 +438,22 @@ static bool destroy_cm_id(struct iw_cm_id *cm_id)
 		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
 		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
 	}
-
-	return iwcm_deref_id(cm_id_priv);
 }
 
 /*
- * This function is only called by the application thread and cannot
- * be called by the event thread. The function will wait for all
- * references to be released on the cm_id and then kfree the cm_id
- * object.
+ * Destroy cm_id. If the cm_id still has other references, wait for all
+ * references to be released on the cm_id and then release the initial
+ * reference taken by iw_create_cm_id.
  */
 void iw_destroy_cm_id(struct iw_cm_id *cm_id)
 {
-	if (!destroy_cm_id(cm_id))
+	struct iwcm_id_private *cm_id_priv;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	destroy_cm_id(cm_id);
+	if (refcount_read(&cm_id_priv->refcount) > 1)
 		flush_workqueue(iwcm_wq);
+	iwcm_deref_id(cm_id_priv);
 }
 EXPORT_SYMBOL(iw_destroy_cm_id);
 
@@ -1038,8 +1036,10 @@ static void cm_work_handler(struct work_struct *_work)
 
 		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
 			ret = process_event(cm_id_priv, &levent);
-			if (ret)
-				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
+			if (ret) {
+				destroy_cm_id(&cm_id_priv->id);
+				WARN_ON_ONCE(iwcm_deref_id(cm_id_priv));
+			}
 		} else
 			pr_debug("dropping event %d\n", levent.event);
 		if (iwcm_deref_id(cm_id_priv))
@@ -1097,7 +1097,7 @@ static int cm_event_handler(struct iw_cm_id *cm_id,
 		}
 	}
 
-	atomic_inc(&cm_id_priv->refcount);
+	refcount_inc(&cm_id_priv->refcount);
 	if (list_empty(&cm_id_priv->work_list)) {
 		list_add_tail(&work->list, &cm_id_priv->work_list);
 		queue_work(iwcm_wq, &work->work);
diff --git a/drivers/infiniband/core/iwcm.h b/drivers/infiniband/core/iwcm.h
index 82c2cd1b0a80..bf74639be128 100644
--- a/drivers/infiniband/core/iwcm.h
+++ b/drivers/infiniband/core/iwcm.h
@@ -52,7 +52,7 @@ struct iwcm_id_private {
 	wait_queue_head_t connect_wait;
 	struct list_head work_list;
 	spinlock_t lock;
-	atomic_t refcount;
+	refcount_t refcount;
 	struct list_head work_free_list;
 };
 
diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
index 35e41c5ca1bb..95b66ce4943b 100644
--- a/drivers/infiniband/core/uverbs_std_types_counters.c
+++ b/drivers/infiniband/core/uverbs_std_types_counters.c
@@ -46,7 +46,9 @@ static int uverbs_free_counters(struct ib_uobject *uobject,
 	if (ret)
 		return ret;
 
-	return counters->device->ops.destroy_counters(counters);
+	counters->device->ops.destroy_counters(counters);
+	kfree(counters);
+	return 0;
 }
 
 static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
@@ -66,20 +68,19 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
 	if (!ib_dev->ops.create_counters)
 		return -EOPNOTSUPP;
 
-	counters = ib_dev->ops.create_counters(ib_dev, attrs);
-	if (IS_ERR(counters)) {
-		ret = PTR_ERR(counters);
-		goto err_create_counters;
-	}
+	counters = rdma_zalloc_drv_obj(ib_dev, ib_counters);
+	if (!counters)
+		return -ENOMEM;
 
 	counters->device = ib_dev;
 	counters->uobject = uobj;
 	uobj->object = counters;
 	atomic_set(&counters->usecnt, 0);
 
-	return 0;
+	ret = ib_dev->ops.create_counters(counters, attrs);
+	if (ret)
+		kfree(counters);
 
-err_create_counters:
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 7a3b56c15079..ad8057bfd0c8 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1840,6 +1840,7 @@ subscribe_event_xa_alloc(struct mlx5_devx_event_table *devx_event_table,
 			/* Level1 is valid for future use, no need to free */
 			return -ENOMEM;
 
+		INIT_LIST_HEAD(&obj_event->obj_sub_list);
 		err = xa_insert(&event->object_ids,
 				key_level2,
 				obj_event,
@@ -1848,7 +1849,6 @@ subscribe_event_xa_alloc(struct mlx5_devx_event_table *devx_event_table,
 			kfree(obj_event);
 			return err;
 		}
-		INIT_LIST_HEAD(&obj_event->obj_sub_list);
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index fb5a1b4abcbc..84b8588f6dad 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1686,6 +1686,33 @@ static void deallocate_uars(struct mlx5_ib_dev *dev,
 			mlx5_cmd_free_uar(dev->mdev, bfregi->sys_pages[i]);
 }
 
+static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
+				struct mlx5_core_dev *slave)
+{
+	int err;
+
+	err = mlx5_nic_vport_update_local_lb(master, true);
+	if (err)
+		return err;
+
+	err = mlx5_nic_vport_update_local_lb(slave, true);
+	if (err)
+		goto out;
+
+	return 0;
+
+out:
+	mlx5_nic_vport_update_local_lb(master, false);
+	return err;
+}
+
+static void mlx5_ib_disable_lb_mp(struct mlx5_core_dev *master,
+				  struct mlx5_core_dev *slave)
+{
+	mlx5_nic_vport_update_local_lb(slave, false);
+	mlx5_nic_vport_update_local_lb(master, false);
+}
+
 int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
 	int err = 0;
@@ -5615,7 +5642,7 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
 			 */
 			goto done;
 		}
-		ret = mlx5_lag_query_cong_counters(dev->mdev,
+		ret = mlx5_lag_query_cong_counters(mdev,
 						   stats->value +
 						   cnts->num_q_counters,
 						   cnts->num_cong_counters,
@@ -5839,6 +5866,8 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	lockdep_assert_held(&mlx5_ib_multiport_mutex);
 
+	mlx5_ib_disable_lb_mp(ibdev->mdev, mpi->mdev);
+
 	mlx5_ib_cleanup_cong_debugfs(ibdev, port_num);
 
 	spin_lock(&port->mp.mpi_lock);
@@ -5927,6 +5956,10 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	mlx5_ib_init_cong_debugfs(ibdev, port_num);
 
+	err = mlx5_ib_enable_lb_mp(ibdev->mdev, mpi->mdev);
+	if (err)
+		goto unbind;
+
 	return true;
 
 unbind:
@@ -6113,7 +6146,7 @@ static int mlx5_ib_read_counters(struct ib_counters *counters,
 	return ret;
 }
 
-static int mlx5_ib_destroy_counters(struct ib_counters *counters)
+static void mlx5_ib_destroy_counters(struct ib_counters *counters)
 {
 	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
 
@@ -6121,24 +6154,15 @@ static int mlx5_ib_destroy_counters(struct ib_counters *counters)
 	if (mcounters->hw_cntrs_hndl)
 		mlx5_fc_destroy(to_mdev(counters->device)->mdev,
 				mcounters->hw_cntrs_hndl);
-
-	kfree(mcounters);
-
-	return 0;
 }
 
-static struct ib_counters *mlx5_ib_create_counters(struct ib_device *device,
-						   struct uverbs_attr_bundle *attrs)
+static int mlx5_ib_create_counters(struct ib_counters *counters,
+				   struct uverbs_attr_bundle *attrs)
 {
-	struct mlx5_ib_mcounters *mcounters;
-
-	mcounters = kzalloc(sizeof(*mcounters), GFP_KERNEL);
-	if (!mcounters)
-		return ERR_PTR(-ENOMEM);
+	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
 
 	mutex_init(&mcounters->mcntrs_mutex);
-
-	return &mcounters->ibcntrs;
+	return 0;
 }
 
 static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
@@ -6296,6 +6320,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.resize_cq = mlx5_ib_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_counters, mlx5_ib_mcounters, ibcntrs),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mlx5_ib_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, mlx5_ib_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, mlx5_ib_srq, ibsrq),
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 00b973e0f79f..a0362201b5d3 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -147,6 +147,7 @@ static const struct xpad_device {
 	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", 0, XTYPE_XBOX },
 	{ 0x05fe, 0x3030, "Chic Controller", 0, XTYPE_XBOX },
 	{ 0x05fe, 0x3031, "Chic Controller", 0, XTYPE_XBOX },
+	{ 0x0502, 0x1305, "Acer NGR200", 0, XTYPE_XBOX },
 	{ 0x062a, 0x0020, "Logic3 Xbox GamePad", 0, XTYPE_XBOX },
 	{ 0x062a, 0x0033, "Competition Pro Steering Wheel", 0, XTYPE_XBOX },
 	{ 0x06a3, 0x0200, "Saitek Racing Wheel", 0, XTYPE_XBOX },
@@ -275,6 +276,7 @@ static const struct xpad_device {
 	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x1949, 0x041a, "Amazon Game Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0130, "Ion Drum Rocker", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
@@ -439,6 +441,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
+	XPAD_XBOX360_VENDOR(0x0502),		/* Acer Inc. Xbox 360 style controllers */
 	XPAD_XBOX360_VENDOR(0x056e),		/* Elecom JC-U3613M */
 	XPAD_XBOX360_VENDOR(0x06a3),		/* Saitek P3600 */
 	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz X-Box 360 controllers */
@@ -451,6 +454,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries Controllers */
+	XPAD_XBOXONE_VENDOR(0x10f5),		/* Turtle Beach Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
 	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
@@ -462,6 +466,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
+	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
 	XPAD_XBOX360_VENDOR(0x1bad),		/* Harminix Rock Band Guitar and Drums */
 	XPAD_XBOX360_VENDOR(0x20d6),		/* PowerA Controllers */
 	XPAD_XBOXONE_VENDOR(0x20d6),		/* PowerA Controllers */
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c22ef6483c40..2ab22c567576 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -776,7 +776,7 @@ static int atkbd_probe(struct atkbd *atkbd)
 
 	if (atkbd_skip_getid(atkbd)) {
 		atkbd->id = 0xab83;
-		return 0;
+		goto deactivate_kbd;
 	}
 
 /*
@@ -813,6 +813,7 @@ static int atkbd_probe(struct atkbd *atkbd)
 		return -1;
 	}
 
+deactivate_kbd:
 /*
  * Make sure nothing is coming from the keyboard and disturbs our
  * internal state.
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 6f54501dc776..cb31ad917b35 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -459,8 +459,8 @@ void mbox_free_channel(struct mbox_chan *chan)
 	if (chan->txdone_method == TXDONE_BY_ACK)
 		chan->txdone_method = TXDONE_BY_POLL;
 
-	module_put(chan->mbox->dev->driver->owner);
 	spin_unlock_irqrestore(&chan->lock, flags);
+	module_put(chan->mbox->dev->driver->owner);
 }
 EXPORT_SYMBOL_GPL(mbox_free_channel);
 
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 25eecb92f5f3..c41e4fea071f 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2406,7 +2406,7 @@ static int super_init_validation(struct raid_set *rs, struct md_rdev *rdev)
 	 */
 	sb_retrieve_failed_devices(sb, failed_devices);
 	rdev_for_each(r, mddev) {
-		if (test_bit(Journal, &rdev->flags) ||
+		if (test_bit(Journal, &r->flags) ||
 		    !r->sb_page)
 			continue;
 		sb2 = page_address(r->sb_page);
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 8fc85b6251e4..feff5b29d098 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -549,7 +549,7 @@ static int md_bitmap_new_disk_sb(struct bitmap *bitmap)
 	 * is a good choice?  We choose COUNTER_MAX / 2 arbitrarily.
 	 */
 	write_behind = bitmap->mddev->bitmap_info.max_write_behind;
-	if (write_behind > COUNTER_MAX)
+	if (write_behind > COUNTER_MAX / 2)
 		write_behind = COUNTER_MAX / 2;
 	sb->write_behind = cpu_to_le32(write_behind);
 	bitmap->mddev->bitmap_info.max_write_behind = write_behind;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 395a279e2c88..dccf62e5b497 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3307,6 +3307,7 @@ static int raid1_reshape(struct mddev *mddev)
 	/* ok, everything is stopped */
 	oldpool = conf->r1bio_pool;
 	conf->r1bio_pool = newpool;
+	init_waitqueue_head(&conf->r1bio_pool.wait);
 
 	for (d = d2 = 0; d < conf->raid_disks; d++) {
 		struct md_rdev *rdev = conf->mirrors[d].rdev;
diff --git a/drivers/media/platform/omap3isp/ispccdc.c b/drivers/media/platform/omap3isp/ispccdc.c
index e2f336c715a4..90fda694e0d3 100644
--- a/drivers/media/platform/omap3isp/ispccdc.c
+++ b/drivers/media/platform/omap3isp/ispccdc.c
@@ -446,8 +446,8 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 		if (ret < 0)
 			goto done;
 
-		dma_sync_sg_for_cpu(isp->dev, req->table.sgt.sgl,
-				    req->table.sgt.nents, DMA_TO_DEVICE);
+		dma_sync_sgtable_for_cpu(isp->dev, &req->table.sgt,
+					 DMA_TO_DEVICE);
 
 		if (copy_from_user(req->table.addr, config->lsc,
 				   req->config.size)) {
@@ -455,8 +455,8 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 			goto done;
 		}
 
-		dma_sync_sg_for_device(isp->dev, req->table.sgt.sgl,
-				       req->table.sgt.nents, DMA_TO_DEVICE);
+		dma_sync_sgtable_for_device(isp->dev, &req->table.sgt,
+					    DMA_TO_DEVICE);
 	}
 
 	spin_lock_irqsave(&ccdc->lsc.req_lock, flags);
diff --git a/drivers/media/platform/omap3isp/ispstat.c b/drivers/media/platform/omap3isp/ispstat.c
index 5b9b57f4d9bf..e8a1837b1b74 100644
--- a/drivers/media/platform/omap3isp/ispstat.c
+++ b/drivers/media/platform/omap3isp/ispstat.c
@@ -161,8 +161,7 @@ static void isp_stat_buf_sync_for_device(struct ispstat *stat,
 	if (ISP_STAT_USES_DMAENGINE(stat))
 		return;
 
-	dma_sync_sg_for_device(stat->isp->dev, buf->sgt.sgl,
-			       buf->sgt.nents, DMA_FROM_DEVICE);
+	dma_sync_sgtable_for_device(stat->isp->dev, &buf->sgt, DMA_FROM_DEVICE);
 }
 
 static void isp_stat_buf_sync_for_cpu(struct ispstat *stat,
@@ -171,8 +170,7 @@ static void isp_stat_buf_sync_for_cpu(struct ispstat *stat,
 	if (ISP_STAT_USES_DMAENGINE(stat))
 		return;
 
-	dma_sync_sg_for_cpu(stat->isp->dev, buf->sgt.sgl,
-			    buf->sgt.nents, DMA_FROM_DEVICE);
+	dma_sync_sgtable_for_cpu(stat->isp->dev, &buf->sgt, DMA_FROM_DEVICE);
 }
 
 static void isp_stat_buf_clear(struct ispstat *stat)
diff --git a/drivers/media/platform/vivid/vivid-vid-cap.c b/drivers/media/platform/vivid/vivid-vid-cap.c
index 842ebfe9b117..00935d600db0 100644
--- a/drivers/media/platform/vivid/vivid-vid-cap.c
+++ b/drivers/media/platform/vivid/vivid-vid-cap.c
@@ -935,8 +935,8 @@ int vivid_vid_cap_s_selection(struct file *file, void *fh, struct v4l2_selection
 			if (dev->has_compose_cap) {
 				v4l2_rect_set_min_size(compose, &min_rect);
 				v4l2_rect_set_max_size(compose, &max_rect);
-				v4l2_rect_map_inside(compose, &fmt);
 			}
+			v4l2_rect_map_inside(compose, &fmt);
 			dev->fmt_cap_rect = fmt;
 			tpg_s_buf_height(&dev->tpg, fmt.height);
 		} else if (dev->has_compose_cap) {
diff --git a/drivers/media/usb/dvb-usb/cxusb.c b/drivers/media/usb/dvb-usb/cxusb.c
index 06bd827ef461..6beed13702d3 100644
--- a/drivers/media/usb/dvb-usb/cxusb.c
+++ b/drivers/media/usb/dvb-usb/cxusb.c
@@ -54,9 +54,6 @@ MODULE_PARM_DESC(debug, "set debugging level (see cxusb.h)."
 
 DVB_DEFINE_MOD_OPT_ADAPTER_NR(adapter_nr);
 
-#define deb_info(args...)   dprintk(dvb_usb_cxusb_debug, CXUSB_DBG_MISC, args)
-#define deb_i2c(args...)    dprintk(dvb_usb_cxusb_debug, CXUSB_DBG_I2C, args)
-
 enum cxusb_table_index {
 	MEDION_MD95700,
 	DVICO_BLUEBIRD_LG064F_COLD,
@@ -122,10 +119,9 @@ static void cxusb_gpio_tuner(struct dvb_usb_device *d, int onoff)
 
 	o[0] = GPIO_TUNER;
 	o[1] = onoff;
-	cxusb_ctrl_msg(d, CMD_GPIO_WRITE, o, 2, &i, 1);
 
-	if (i != 0x01)
-		deb_info("gpio_write failed.\n");
+	if (!cxusb_ctrl_msg(d, CMD_GPIO_WRITE, o, 2, &i, 1) && i != 0x01)
+		dev_info(&d->udev->dev, "gpio_write failed.\n");
 
 	st->gpio_write_state[GPIO_TUNER] = onoff;
 	st->gpio_write_refresh[GPIO_TUNER] = false;
@@ -142,7 +138,7 @@ static int cxusb_bluebird_gpio_rw(struct dvb_usb_device *d, u8 changemask,
 
 	rc = cxusb_ctrl_msg(d, CMD_BLUEBIRD_GPIO_RW, o, 2, &gpio_state, 1);
 	if (rc < 0 || (gpio_state & changemask) != (newval & changemask))
-		deb_info("bluebird_gpio_write failed.\n");
+		dev_info(&d->udev->dev, "bluebird_gpio_write failed.\n");
 
 	return rc < 0 ? rc : gpio_state;
 }
@@ -174,7 +170,7 @@ static int cxusb_d680_dmb_gpio_tuner(struct dvb_usb_device *d,
 	if (i == 0x01)
 		return 0;
 
-	deb_info("gpio_write failed.\n");
+	dev_info(&d->udev->dev, "gpio_write failed.\n");
 	return -EIO;
 }
 
@@ -248,7 +244,7 @@ static int cxusb_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				break;
 
 			if (ibuf[0] != 0x08)
-				deb_i2c("i2c read may have failed\n");
+				dev_info(&d->udev->dev, "i2c read may have failed\n");
 
 			memcpy(msg[i + 1].buf, &ibuf[1], msg[i + 1].len);
 
@@ -271,7 +267,7 @@ static int cxusb_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 					   2 + msg[i].len, &ibuf, 1) < 0)
 				break;
 			if (ibuf != 0x08)
-				deb_i2c("i2c write may have failed\n");
+				dev_info(&d->udev->dev, "i2c write may have failed\n");
 		}
 	}
 
@@ -299,7 +295,7 @@ static int _cxusb_power_ctrl(struct dvb_usb_device *d, int onoff)
 {
 	u8 b = 0;
 
-	deb_info("setting power %s\n", onoff ? "ON" : "OFF");
+	dev_info(&d->udev->dev, "setting power %s\n", onoff ? "ON" : "OFF");
 
 	if (onoff)
 		return cxusb_ctrl_msg(d, CMD_POWER_ON, &b, 1, NULL, 0);
@@ -318,7 +314,7 @@ static int cxusb_power_ctrl(struct dvb_usb_device *d, int onoff)
 		mutex_lock(&cxdev->open_lock);
 
 		if (cxdev->open_type == CXUSB_OPEN_ANALOG) {
-			deb_info("preventing DVB core from setting power OFF while we are in analog mode\n");
+			dev_info(&d->udev->dev, "preventing DVB core from setting power OFF while we are in analog mode\n");
 			ret = -EBUSY;
 			goto ret_unlock;
 		}
@@ -754,16 +750,16 @@ static int dvico_bluebird_xc2028_callback(void *ptr, int component,
 
 	switch (command) {
 	case XC2028_TUNER_RESET:
-		deb_info("%s: XC2028_TUNER_RESET %d\n", __func__, arg);
+		dev_info(&d->udev->dev, "XC2028_TUNER_RESET %d\n", arg);
 		cxusb_bluebird_gpio_pulse(d, 0x01, 1);
 		break;
 	case XC2028_RESET_CLK:
-		deb_info("%s: XC2028_RESET_CLK %d\n", __func__, arg);
+		dev_info(&d->udev->dev, "XC2028_RESET_CLK %d\n", arg);
 		break;
 	case XC2028_I2C_FLUSH:
 		break;
 	default:
-		deb_info("%s: unknown command %d, arg %d\n", __func__,
+		dev_info(&d->udev->dev, "unknown command %d, arg %d\n",
 			 command, arg);
 		return -EINVAL;
 	}
@@ -1444,7 +1440,7 @@ int cxusb_medion_get(struct dvb_usb_device *dvbdev,
 
 	if (cxdev->open_ctr == 0) {
 		if (cxdev->open_type != open_type) {
-			deb_info("will acquire and switch to %s\n",
+			dev_info(&dvbdev->udev->dev, "will acquire and switch to %s\n",
 				 open_type == CXUSB_OPEN_ANALOG ?
 				 "analog" : "digital");
 
@@ -1476,7 +1472,7 @@ int cxusb_medion_get(struct dvb_usb_device *dvbdev,
 
 			cxdev->open_type = open_type;
 		} else {
-			deb_info("reacquired idle %s\n",
+			dev_info(&dvbdev->udev->dev, "reacquired idle %s\n",
 				 open_type == CXUSB_OPEN_ANALOG ?
 				 "analog" : "digital");
 		}
@@ -1484,8 +1480,8 @@ int cxusb_medion_get(struct dvb_usb_device *dvbdev,
 		cxdev->open_ctr = 1;
 	} else if (cxdev->open_type == open_type) {
 		cxdev->open_ctr++;
-		deb_info("acquired %s\n", open_type == CXUSB_OPEN_ANALOG ?
-			 "analog" : "digital");
+		dev_info(&dvbdev->udev->dev, "acquired %s\n",
+			 open_type == CXUSB_OPEN_ANALOG ? "analog" : "digital");
 	} else {
 		ret = -EBUSY;
 	}
@@ -1511,7 +1507,7 @@ void cxusb_medion_put(struct dvb_usb_device *dvbdev)
 	if (!WARN_ON(cxdev->open_ctr < 1)) {
 		cxdev->open_ctr--;
 
-		deb_info("release %s\n",
+		dev_info(&dvbdev->udev->dev, "release %s\n",
 			 cxdev->open_type == CXUSB_OPEN_ANALOG ?
 			 "analog" : "digital");
 	}
diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 923494567d89..c9e5a74e0f0d 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1429,7 +1429,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1440,6 +1442,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1560,14 +1565,19 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 	return mutex_lock_interruptible(&chain->ctrl_mutex) ? -ERESTARTSYS : 0;
 }
 
+/*
+ * Returns the number of uvc controls that have been correctly set, or a
+ * negative number if there has been an error.
+ */
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				  struct uvc_fh *handle,
 				  struct uvc_entity *entity,
 				  int rollback)
 {
+	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -1595,8 +1605,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
+
+		if (!ret)
+			processed_ctrls++;
 
 		if (rollback || ret < 0)
 			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
@@ -1605,15 +1616,23 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		ctrl->dirty = 0;
 
-		if (ret < 0)
-			return ret;
-
-		if (!rollback && handle &&
+		if (!rollback && handle && !ret &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			uvc_ctrl_set_handle(handle, ctrl, handle);
+
+		if (ret < 0 && !rollback) {
+			/*
+			 * If we fail to set a control, we need to rollback
+			 * the next ones.
+			 */
+			rollback = 1;
+		}
 	}
 
-	return 0;
+	if (ret)
+		return ret;
+
+	return processed_ctrls;
 }
 
 int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
@@ -1622,21 +1641,31 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 {
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
 		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
 					     rollback);
-		if (ret < 0)
-			goto done;
+		if (ret < 0) {
+			/*
+			 * When we fail to commit an entity, we need to
+			 * restore the UVC_CTRL_DATA_BACKUP for all the
+			 * controls in the other entities, otherwise our cache
+			 * and the hardware will be out of sync.
+			 */
+			rollback = 1;
+
+			ret_out = ret;
+		} else if (ret > 0 && !rollback) {
+			uvc_ctrl_send_events(handle, entity, xctrls,
+					     xctrls_count);
+		}
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, xctrls, xctrls_count);
-done:
 	mutex_unlock(&chain->ctrl_mutex);
-	return ret;
+	return ret_out;
 }
 
 int uvc_ctrl_get(struct uvc_video_chain *chain,
diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index fd8864cafd25..4d87b429a7ba 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -467,6 +467,7 @@ static int max14577_i2c_remove(struct i2c_client *i2c)
 {
 	struct max14577 *max14577 = i2c_get_clientdata(i2c);
 
+	device_init_wakeup(max14577->dev, false);
 	mfd_remove_devices(max14577->dev);
 	regmap_del_irq_chip(max14577->irq, max14577->irq_data);
 	if (max14577->dev_type == MAXIM_DEVICE_TYPE_MAX77836)
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 8ff8d649d9b3..6eddb805642e 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -222,6 +222,7 @@ static int drv_cp_harray_to_user(void __user *user_buf_uva,
 static int vmci_host_setup_notify(struct vmci_ctx *context,
 				  unsigned long uva)
 {
+	struct page *page;
 	int retval;
 
 	if (context->notify_page) {
@@ -240,11 +241,11 @@ static int vmci_host_setup_notify(struct vmci_ctx *context,
 	/*
 	 * Lock physical page backing a given user VA.
 	 */
-	retval = get_user_pages_fast(uva, 1, FOLL_WRITE, &context->notify_page);
-	if (retval != 1) {
-		context->notify_page = NULL;
+	retval = get_user_pages_fast(uva, 1, FOLL_WRITE, &page);
+	if (retval != 1)
 		return VMCI_ERROR_GENERIC;
-	}
+
+	context->notify_page = page;
 
 	/*
 	 * Map the locked page and set up notify pointer.
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 2673890c7690..c374cf40d955 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -676,21 +676,23 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 	writel(lower_32_bits(dma->gpd_addr), host->base + MSDC_DMA_SA);
 }
 
-static void msdc_prepare_data(struct msdc_host *host, struct mmc_request *mrq)
+static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
 {
-	struct mmc_data *data = mrq->data;
-
 	if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
-		data->host_cookie |= MSDC_PREPARE_FLAG;
 		data->sg_count = dma_map_sg(host->dev, data->sg, data->sg_len,
 					    mmc_get_dma_dir(data));
+		if (data->sg_count)
+			data->host_cookie |= MSDC_PREPARE_FLAG;
 	}
 }
 
-static void msdc_unprepare_data(struct msdc_host *host, struct mmc_request *mrq)
+static bool msdc_data_prepared(struct mmc_data *data)
 {
-	struct mmc_data *data = mrq->data;
+	return data->host_cookie & MSDC_PREPARE_FLAG;
+}
 
+static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
+{
 	if (data->host_cookie & MSDC_ASYNC_FLAG)
 		return;
 
@@ -1033,7 +1035,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 
 	msdc_track_cmd_data(host, mrq->cmd, mrq->data);
 	if (mrq->data)
-		msdc_unprepare_data(host, mrq);
+		msdc_unprepare_data(host, mrq->data);
 	if (host->error)
 		msdc_reset_hw(host);
 	mmc_request_done(host->mmc, mrq);
@@ -1201,8 +1203,19 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(host->mrq);
 	host->mrq = mrq;
 
-	if (mrq->data)
-		msdc_prepare_data(host, mrq);
+	if (mrq->data) {
+		msdc_prepare_data(host, mrq->data);
+		if (!msdc_data_prepared(mrq->data)) {
+			host->mrq = NULL;
+			/*
+			 * Failed to prepare DMA area, fail fast before
+			 * starting any commands.
+			 */
+			mrq->cmd->error = -ENOSPC;
+			mmc_request_done(mmc_from_priv(host), mrq);
+			return;
+		}
+	}
 
 	/* if SBC is required, we have HW option and SW option.
 	 * if HW option is enabled, and SBC does not have "special" flags,
@@ -1223,7 +1236,7 @@ static void msdc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (!data)
 		return;
 
-	msdc_prepare_data(host, mrq);
+	msdc_prepare_data(host, data);
 	data->host_cookie |= MSDC_ASYNC_FLAG;
 }
 
@@ -1231,14 +1244,14 @@ static void msdc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 		int err)
 {
 	struct msdc_host *host = mmc_priv(mmc);
-	struct mmc_data *data;
+	struct mmc_data *data = mrq->data;
 
-	data = mrq->data;
 	if (!data)
 		return;
+
 	if (data->host_cookie) {
 		data->host_cookie &= ~MSDC_ASYNC_FLAG;
-		msdc_unprepare_data(host, mrq);
+		msdc_unprepare_data(host, data);
 	}
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f8d0a0e49abe..4004e4e7b622 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1708,15 +1708,10 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if (clk & SDHCI_CLOCK_CARD_EN)
-		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
-			SDHCI_CLOCK_CONTROL);
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0) {
-		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	if (clock == 0)
 		return;
-	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_enable_clk(host, clk);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 00df46a75be5..96ed7333ab73 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -801,4 +801,20 @@ void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode);
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+#define SDHCI_DBG_ANYWAY 0
+#elif defined(DEBUG)
+#define SDHCI_DBG_ANYWAY 1
+#else
+#define SDHCI_DBG_ANYWAY 0
+#endif
+
+#define sdhci_dbg_dumpregs(host, fmt)					\
+do {									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) ||	SDHCI_DBG_ANYWAY)	\
+		sdhci_dumpregs(host);					\
+} while (0)
+
 #endif /* __SDHCI_HW_H */
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 26f721664e76..123c87196a36 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -520,7 +520,7 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	struct sk_buff *skb;
 	struct can_frame *frame;
 
-	netdev_err(dev, "msg lost in rxf0\n");
+	netdev_dbg(dev, "msg lost in rxf0\n");
 
 	stats->rx_errors++;
 	stats->rx_over_errors++;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 533b8519ec35..c5dc23906a78 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -1355,6 +1355,8 @@
 #define MDIO_VEND2_CTRL1_SS13		BIT(13)
 #endif
 
+#define XGBE_VEND2_MAC_AUTO_SW		BIT(9)
+
 /* MDIO mask values */
 #define XGBE_AN_CL73_INT_CMPLT		BIT(0)
 #define XGBE_AN_CL73_INC_LINK		BIT(1)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 0e552022e659..3819b23c927d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -363,6 +363,10 @@ static void xgbe_an37_set(struct xgbe_prv_data *pdata, bool enable,
 		reg |= MDIO_VEND2_CTRL1_AN_RESTART;
 
 	XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_CTRL1, reg);
+
+	reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
+	reg |= XGBE_VEND2_MAC_AUTO_SW;
+	XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
 }
 
 static void xgbe_an37_restart(struct xgbe_prv_data *pdata)
@@ -991,6 +995,11 @@ static void xgbe_an37_init(struct xgbe_prv_data *pdata)
 
 	netif_dbg(pdata, link, pdata->netdev, "CL37 AN (%s) initialized\n",
 		  (pdata->an_mode == XGBE_AN_MODE_CL37) ? "BaseX" : "SGMII");
+
+	reg = XMDIO_READ(pdata, MDIO_MMD_AN, MDIO_CTRL1);
+	reg &= ~MDIO_AN_CTRL1_ENABLE;
+	XMDIO_WRITE(pdata, MDIO_MMD_AN, MDIO_CTRL1, reg);
+
 }
 
 static void xgbe_an73_init(struct xgbe_prv_data *pdata)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index a27979ef7b1c..536c8495d6af 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -292,11 +292,11 @@
 #define XGBE_LINK_TIMEOUT		5
 #define XGBE_KR_TRAINING_WAIT_ITER	50
 
-#define XGBE_SGMII_AN_LINK_STATUS	BIT(1)
+#define XGBE_SGMII_AN_LINK_DUPLEX	BIT(1)
 #define XGBE_SGMII_AN_LINK_SPEED	(BIT(2) | BIT(3))
 #define XGBE_SGMII_AN_LINK_SPEED_100	0x04
 #define XGBE_SGMII_AN_LINK_SPEED_1000	0x08
-#define XGBE_SGMII_AN_LINK_DUPLEX	BIT(4)
+#define XGBE_SGMII_AN_LINK_STATUS	BIT(4)
 
 /* ECC correctable error notification window (seconds) */
 #define XGBE_ECC_LIMIT			60
diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index b498fd6a47d0..3e80b9659e3b 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -1863,14 +1863,21 @@ static u16 atl1_alloc_rx_buffers(struct atl1_adapter *adapter)
 			break;
 		}
 
-		buffer_info->alloced = 1;
-		buffer_info->skb = skb;
-		buffer_info->length = (u16) adapter->rx_buffer_len;
 		page = virt_to_page(skb->data);
 		offset = offset_in_page(skb->data);
 		buffer_info->dma = pci_map_page(pdev, page, offset,
 						adapter->rx_buffer_len,
 						PCI_DMA_FROMDEVICE);
+		if (pci_dma_mapping_error(pdev, buffer_info->dma)) {
+			kfree_skb(skb);
+			adapter->soft_stats.rx_dropped++;
+			break;
+		}
+
+		buffer_info->alloced = 1;
+		buffer_info->skb = skb;
+		buffer_info->length = (u16)adapter->rx_buffer_len;
+
 		rfd_desc->buffer_addr = cpu_to_le64(buffer_info->dma);
 		rfd_desc->buf_len = cpu_to_le16(adapter->rx_buffer_len);
 		rfd_desc->coalese = 0;
@@ -2182,8 +2189,8 @@ static int atl1_tx_csum(struct atl1_adapter *adapter, struct sk_buff *skb,
 	return 0;
 }
 
-static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
-	struct tx_packet_desc *ptpd)
+static bool atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
+			struct tx_packet_desc *ptpd)
 {
 	struct atl1_tpd_ring *tpd_ring = &adapter->tpd_ring;
 	struct atl1_buffer *buffer_info;
@@ -2193,6 +2200,7 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	unsigned int nr_frags;
 	unsigned int f;
 	int retval;
+	u16 first_mapped;
 	u16 next_to_use;
 	u16 data_len;
 	u8 hdr_len;
@@ -2200,6 +2208,7 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	buf_len -= skb->data_len;
 	nr_frags = skb_shinfo(skb)->nr_frags;
 	next_to_use = atomic_read(&tpd_ring->next_to_use);
+	first_mapped = next_to_use;
 	buffer_info = &tpd_ring->buffer_info[next_to_use];
 	BUG_ON(buffer_info->skb);
 	/* put skb in last TPD */
@@ -2215,6 +2224,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = pci_map_page(adapter->pdev, page,
 						offset, hdr_len,
 						PCI_DMA_TODEVICE);
+		if (pci_dma_mapping_error(adapter->pdev, buffer_info->dma))
+			goto dma_err;
 
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
@@ -2240,6 +2251,9 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 				buffer_info->dma = pci_map_page(adapter->pdev,
 					page, offset, buffer_info->length,
 					PCI_DMA_TODEVICE);
+				if (pci_dma_mapping_error(adapter->pdev,
+						      buffer_info->dma))
+					goto dma_err;
 				if (++next_to_use == tpd_ring->count)
 					next_to_use = 0;
 			}
@@ -2251,6 +2265,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		offset = offset_in_page(skb->data);
 		buffer_info->dma = pci_map_page(adapter->pdev, page,
 			offset, buf_len, PCI_DMA_TODEVICE);
+		if (pci_dma_mapping_error(adapter->pdev, buffer_info->dma))
+			goto dma_err;
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
 	}
@@ -2274,6 +2290,9 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 			buffer_info->dma = skb_frag_dma_map(&adapter->pdev->dev,
 				frag, i * ATL1_MAX_TX_BUF_LEN,
 				buffer_info->length, DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev,
+					      buffer_info->dma))
+				goto dma_err;
 
 			if (++next_to_use == tpd_ring->count)
 				next_to_use = 0;
@@ -2282,6 +2301,22 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 
 	/* last tpd's buffer-info */
 	buffer_info->skb = skb;
+
+	return true;
+
+ dma_err:
+	while (first_mapped != next_to_use) {
+		buffer_info = &tpd_ring->buffer_info[first_mapped];
+		pci_unmap_page(adapter->pdev,
+			       buffer_info->dma,
+			       buffer_info->length,
+			       PCI_DMA_TODEVICE);
+		buffer_info->dma = 0;
+
+		if (++first_mapped == tpd_ring->count)
+			first_mapped = 0;
+	}
+	return false;
 }
 
 static void atl1_tx_queue(struct atl1_adapter *adapter, u16 count,
@@ -2352,10 +2387,8 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 
 	len = skb_headlen(skb);
 
-	if (unlikely(skb->len <= 0)) {
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
+	if (unlikely(skb->len <= 0))
+		goto drop_packet;
 
 	nr_frags = skb_shinfo(skb)->nr_frags;
 	for (f = 0; f < nr_frags; f++) {
@@ -2369,10 +2402,8 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 		if (skb->protocol == htons(ETH_P_IP)) {
 			proto_hdr_len = (skb_transport_offset(skb) +
 					 tcp_hdrlen(skb));
-			if (unlikely(proto_hdr_len > len)) {
-				dev_kfree_skb_any(skb);
-				return NETDEV_TX_OK;
-			}
+			if (unlikely(proto_hdr_len > len))
+				goto drop_packet;
 			/* need additional TPD ? */
 			if (proto_hdr_len != len)
 				count += (len - proto_hdr_len +
@@ -2404,23 +2435,26 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 	}
 
 	tso = atl1_tso(adapter, skb, ptpd);
-	if (tso < 0) {
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
+	if (tso < 0)
+		goto drop_packet;
 
 	if (!tso) {
 		ret_val = atl1_tx_csum(adapter, skb, ptpd);
-		if (ret_val < 0) {
-			dev_kfree_skb_any(skb);
-			return NETDEV_TX_OK;
-		}
+		if (ret_val < 0)
+			goto drop_packet;
 	}
 
-	atl1_tx_map(adapter, skb, ptpd);
+	if (!atl1_tx_map(adapter, skb, ptpd))
+		goto drop_packet;
+
 	atl1_tx_queue(adapter, count, ptpd);
 	atl1_update_mailbox(adapter);
 	return NETDEV_TX_OK;
+
+drop_packet:
+	adapter->soft_stats.tx_errors++;
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
 }
 
 static int atl1_rings_clean(struct napi_struct *napi, int budget)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index b1511bcffb1b..5e6305f8220f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -454,7 +454,9 @@ static int bnxt_ets_validate(struct bnxt *bp, struct ieee_ets *ets, u8 *tc)
 
 		if ((ets->tc_tx_bw[i] || ets->tc_tsa[i]) && i > bp->max_tc)
 			return -EINVAL;
+	}
 
+	for (i = 0; i < max_tc; i++) {
 		switch (ets->tc_tsa[i]) {
 		case IEEE_8021QAZ_TSA_STRICT:
 			break;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index c6f6f2033880..837d292c06fa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -65,7 +65,7 @@ static void __bnxt_xmit_xdp_redirect(struct bnxt *bp,
 	tx_buf->action = XDP_REDIRECT;
 	tx_buf->xdpf = xdpf;
 	dma_unmap_addr_set(tx_buf, mapping, mapping);
-	dma_unmap_len_set(tx_buf, len, 0);
+	dma_unmap_len_set(tx_buf, len, len);
 }
 
 void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 892c4b5ff303..1101f1416d07 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2093,10 +2093,10 @@ static int enic_change_mtu(struct net_device *netdev, int new_mtu)
 	if (enic_is_dynamic(enic) || enic_is_sriov_vf(enic))
 		return -EOPNOTSUPP;
 
-	if (netdev->mtu > enic->port_mtu)
+	if (new_mtu > enic->port_mtu)
 		netdev_warn(netdev,
 			    "interface MTU (%d) set higher than port MTU (%d)\n",
-			    netdev->mtu, enic->port_mtu);
+			    new_mtu, enic->port_mtu);
 
 	return _enic_change_mtu(netdev, new_mtu);
 }
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 5f5766b1f3b7..8649578b54c1 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2725,6 +2725,7 @@ static int setup_rx_flow(struct dpaa2_eth_priv *priv,
 					 MEM_TYPE_PAGE_ORDER0, NULL);
 	if (err) {
 		dev_err(dev, "xdp_rxq_info_reg_mem_model failed\n");
+		xdp_rxq_info_unreg(&fq->channel->xdp_rxq);
 		return err;
 	}
 
@@ -3153,17 +3154,25 @@ static int bind_dpni(struct dpaa2_eth_priv *priv)
 			return -EINVAL;
 		}
 		if (err)
-			return err;
+			goto out;
 	}
 
 	err = dpni_get_qdid(priv->mc_io, 0, priv->mc_token,
 			    DPNI_QUEUE_TX, &priv->tx_qdid);
 	if (err) {
 		dev_err(dev, "dpni_get_qdid() failed\n");
-		return err;
+		goto out;
 	}
 
 	return 0;
+
+out:
+	while (i--) {
+		if (priv->fq[i].type == DPAA2_RX_FQ &&
+		    xdp_rxq_info_is_reg(&priv->fq[i].channel->xdp_rxq))
+			xdp_rxq_info_unreg(&priv->fq[i].channel->xdp_rxq);
+	}
+	return err;
 }
 
 /* Allocate rings for storing incoming frame descriptors */
@@ -3445,6 +3454,17 @@ static void del_ch_napi(struct dpaa2_eth_priv *priv)
 	}
 }
 
+static void dpaa2_eth_free_rx_xdp_rxq(struct dpaa2_eth_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->num_fqs; i++) {
+		if (priv->fq[i].type == DPAA2_RX_FQ &&
+		    xdp_rxq_info_is_reg(&priv->fq[i].channel->xdp_rxq))
+			xdp_rxq_info_unreg(&priv->fq[i].channel->xdp_rxq);
+	}
+}
+
 static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 {
 	struct device *dev;
@@ -3574,6 +3594,7 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	free_percpu(priv->percpu_stats);
 err_alloc_percpu_stats:
 	del_ch_napi(priv);
+	dpaa2_eth_free_rx_xdp_rxq(priv);
 err_bind:
 	free_dpbp(priv);
 err_dpbp_setup:
@@ -3614,6 +3635,7 @@ static int dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 	free_percpu(priv->percpu_extras);
 
 	del_ch_napi(priv);
+	dpaa2_eth_free_rx_xdp_rxq(priv);
 	free_dpbp(priv);
 	free_dpio(priv);
 	free_dpni(priv);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index fac80831d532..e99546b6a356 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -319,7 +319,7 @@ static inline u64 enetc_rd_reg64(void __iomem *reg)
 		tmp = ioread32(reg + 4);
 	} while (high != tmp);
 
-	return le64_to_cpu((__le64)high << 32 | low);
+	return (u64)high << 32 | low;
 }
 #endif
 
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index e659415c62bd..ca991bcb2e51 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3317,7 +3317,7 @@ static int niu_rbr_add_page(struct niu *np, struct rx_ring_info *rp,
 
 	addr = np->ops->map_page(np->device, page, 0,
 				 PAGE_SIZE, DMA_FROM_DEVICE);
-	if (!addr) {
+	if (np->ops->mapping_error(np->device, addr)) {
 		__free_page(page);
 		return -ENOMEM;
 	}
@@ -6654,6 +6654,8 @@ static netdev_tx_t niu_start_xmit(struct sk_buff *skb,
 	len = skb_headlen(skb);
 	mapping = np->ops->map_single(np->device, skb->data,
 				      len, DMA_TO_DEVICE);
+	if (np->ops->mapping_error(np->device, mapping))
+		goto out_drop;
 
 	prod = rp->prod;
 
@@ -6695,6 +6697,8 @@ static netdev_tx_t niu_start_xmit(struct sk_buff *skb,
 		mapping = np->ops->map_page(np->device, skb_frag_page(frag),
 					    skb_frag_off(frag), len,
 					    DMA_TO_DEVICE);
+		if (np->ops->mapping_error(np->device, mapping))
+			goto out_unmap;
 
 		rp->tx_buffs[prod].skb = NULL;
 		rp->tx_buffs[prod].mapping = mapping;
@@ -6719,6 +6723,19 @@ static netdev_tx_t niu_start_xmit(struct sk_buff *skb,
 out:
 	return NETDEV_TX_OK;
 
+out_unmap:
+	while (i--) {
+		const skb_frag_t *frag;
+
+		prod = PREVIOUS_TX(rp, prod);
+		frag = &skb_shinfo(skb)->frags[i];
+		np->ops->unmap_page(np->device, rp->tx_buffs[prod].mapping,
+				    skb_frag_size(frag), DMA_TO_DEVICE);
+	}
+
+	np->ops->unmap_single(np->device, rp->tx_buffs[rp->prod].mapping,
+			      skb_headlen(skb), DMA_TO_DEVICE);
+
 out_drop:
 	rp->tx_errors++;
 	kfree_skb(skb);
@@ -9612,6 +9629,11 @@ static void niu_pci_unmap_single(struct device *dev, u64 dma_address,
 	dma_unmap_single(dev, dma_address, size, direction);
 }
 
+static int niu_pci_mapping_error(struct device *dev, u64 addr)
+{
+	return dma_mapping_error(dev, addr);
+}
+
 static const struct niu_ops niu_pci_ops = {
 	.alloc_coherent	= niu_pci_alloc_coherent,
 	.free_coherent	= niu_pci_free_coherent,
@@ -9619,6 +9641,7 @@ static const struct niu_ops niu_pci_ops = {
 	.unmap_page	= niu_pci_unmap_page,
 	.map_single	= niu_pci_map_single,
 	.unmap_single	= niu_pci_unmap_single,
+	.mapping_error	= niu_pci_mapping_error,
 };
 
 static void niu_driver_version(void)
@@ -9996,6 +10019,11 @@ static void niu_phys_unmap_single(struct device *dev, u64 dma_address,
 	/* Nothing to do.  */
 }
 
+static int niu_phys_mapping_error(struct device *dev, u64 dma_address)
+{
+	return false;
+}
+
 static const struct niu_ops niu_phys_ops = {
 	.alloc_coherent	= niu_phys_alloc_coherent,
 	.free_coherent	= niu_phys_free_coherent,
@@ -10003,6 +10031,7 @@ static const struct niu_ops niu_phys_ops = {
 	.unmap_page	= niu_phys_unmap_page,
 	.map_single	= niu_phys_map_single,
 	.unmap_single	= niu_phys_unmap_single,
+	.mapping_error	= niu_phys_mapping_error,
 };
 
 static int niu_of_probe(struct platform_device *op)
diff --git a/drivers/net/ethernet/sun/niu.h b/drivers/net/ethernet/sun/niu.h
index 04c215f91fc0..0b169c08b0f2 100644
--- a/drivers/net/ethernet/sun/niu.h
+++ b/drivers/net/ethernet/sun/niu.h
@@ -2879,6 +2879,9 @@ struct tx_ring_info {
 #define NEXT_TX(tp, index) \
 	(((index) + 1) < (tp)->pending ? ((index) + 1) : 0)
 
+#define PREVIOUS_TX(tp, index) \
+	(((index) - 1) >= 0 ? ((index) - 1) : (((tp)->pending) - 1))
+
 static inline u32 niu_tx_avail(struct tx_ring_info *tp)
 {
 	return (tp->pending -
@@ -3140,6 +3143,7 @@ struct niu_ops {
 			  enum dma_data_direction direction);
 	void (*unmap_single)(struct device *dev, u64 dma_address,
 			     size_t size, enum dma_data_direction direction);
+	int (*mapping_error)(struct device *dev, u64 dma_address);
 };
 
 struct niu_link_config {
diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 375bbd60b38a..e6ad7d29a055 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -335,7 +335,7 @@ static void lan88xx_link_change_notify(struct phy_device *phydev)
 	 * As workaround, set to 10 before setting to 100
 	 * at forced 100 F/H mode.
 	 */
-	if (!phydev->autoneg && phydev->speed == 100) {
+	if (phydev->state == PHY_NOLINK && !phydev->autoneg && phydev->speed == 100) {
 		/* disable phy interrupt */
 		temp = phy_read(phydev, LAN88XX_INT_MASK);
 		temp &= ~LAN88XX_INT_MASK_MDINTPIN_EN_;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index d0032db3e9f4..496cff5f3d0a 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1382,6 +1382,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x03f0, 0x9d1d, 1)},	/* HP lt4120 Snapdragon X5 LTE */
 	{QMI_FIXED_INTF(0x22de, 0x9061, 3)},	/* WeTelecom WPD-600N */
 	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9001, 5)},	/* SIMCom 7100E, 7230E, 7600E ++ */
+	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9071, 3)},	/* SIMCom 8230C ++ */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */
diff --git a/drivers/net/wireless/ath/ath6kl/bmi.c b/drivers/net/wireless/ath/ath6kl/bmi.c
index af98e871199d..5a9e93fd1ef4 100644
--- a/drivers/net/wireless/ath/ath6kl/bmi.c
+++ b/drivers/net/wireless/ath/ath6kl/bmi.c
@@ -87,7 +87,9 @@ int ath6kl_bmi_get_target_info(struct ath6kl *ar,
 		 * We need to do some backwards compatibility to make this work.
 		 */
 		if (le32_to_cpu(targ_info->byte_count) != sizeof(*targ_info)) {
-			WARN_ON(1);
+			ath6kl_err("mismatched byte count %d vs. expected %zd\n",
+				   le32_to_cpu(targ_info->byte_count),
+				   sizeof(*targ_info));
 			return -EINVAL;
 		}
 
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
index a9999d10ae81..bff6e796fde0 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -584,7 +584,11 @@ void zd_mac_tx_to_dev(struct sk_buff *skb, int error)
 
 		skb_queue_tail(q, skb);
 		while (skb_queue_len(q) > ZD_MAC_MAX_ACK_WAITERS) {
-			zd_mac_tx_status(hw, skb_dequeue(q),
+			skb = skb_dequeue(q);
+			if (!skb)
+				break;
+
+			zd_mac_tx_status(hw, skb,
 					 mac->ack_pending ? mac->ack_signal : 0,
 					 NULL);
 			mac->ack_pending = 0;
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 44320322037d..c158ae333237 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -812,6 +812,25 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
+static void msm_gpio_irq_init_valid_mask(struct gpio_chip *gc,
+					 unsigned long *valid_mask,
+					 unsigned int ngpios)
+{
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	const struct msm_pingroup *g;
+	int i;
+
+	bitmap_fill(valid_mask, ngpios);
+
+	for (i = 0; i < ngpios; i++) {
+		g = &pctrl->soc->groups[i];
+
+		if (g->intr_detection_width != 1 &&
+		    g->intr_detection_width != 2)
+			clear_bit(i, valid_mask);
+	}
+}
+
 static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -1039,6 +1058,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_bad_irq;
 	girq->parents[0] = pctrl->irq;
+	girq->init_valid_mask = msm_gpio_irq_init_valid_mask;
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 767f4406e55f..1eb7f4eb1156 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -253,7 +253,8 @@ static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
 		vring->align = SMP_CACHE_BYTES;
 		vring->index = i;
 		vring->vdev_id = tm_vdev->vdev.id.device;
-		vring->drop_desc.len = VRING_DROP_DESC_MAX_LEN;
+		vring->drop_desc.len = cpu_to_virtio32(&tm_vdev->vdev,
+						       VRING_DROP_DESC_MAX_LEN);
 		dev = &tm_vdev->vdev.dev;
 
 		size = vring_size(vring->num, vring->align);
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 1879ce5b3ff2..3cf766d892db 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -134,8 +134,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
-	if (!clk_rate)
-		return -EINVAL;
+	if (!clk_rate) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
@@ -154,9 +156,9 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
-		pwm_mediatek_clk_disable(chip, pwm);
-		dev_err(chip->dev, "period %d not supported\n", period_ns);
-		return -EINVAL;
+		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
@@ -173,9 +175,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
+out:
 	pwm_mediatek_clk_disable(chip, pwm);
 
-	return 0;
+	return ret;
 }
 
 static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 110ee6fe76c4..50fcb5fce11a 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -213,6 +213,9 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 				 regtype);
 	}
 
+	if (of_find_property(np, "vin-supply", NULL))
+		config->input_supply = "vin";
+
 	return config;
 }
 
@@ -250,10 +253,22 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	drvdata->gpiods = devm_kzalloc(dev, sizeof(struct gpio_desc *),
-				       GFP_KERNEL);
+	drvdata->gpiods = devm_kcalloc(dev, config->ngpios,
+				       sizeof(struct gpio_desc *), GFP_KERNEL);
 	if (!drvdata->gpiods)
 		return -ENOMEM;
+
+	if (config->input_supply) {
+		drvdata->desc.supply_name = devm_kstrdup(&pdev->dev,
+							 config->input_supply,
+							 GFP_KERNEL);
+		if (!drvdata->desc.supply_name) {
+			dev_err(&pdev->dev,
+				"Failed to allocate input supply\n");
+			return -ENOMEM;
+		}
+	}
+
 	for (i = 0; i < config->ngpios; i++) {
 		drvdata->gpiods[i] = devm_gpiod_get_index(dev,
 							  NULL,
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index ea15bbe0397f..af1c45dd2f38 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -3394,6 +3394,8 @@ static int qla4xxx_alloc_pdu(struct iscsi_task *task, uint8_t opcode)
 		task_data->data_dma = dma_map_single(&ha->pdev->dev, task->data,
 						     task->data_count,
 						     DMA_TO_DEVICE);
+		if (dma_mapping_error(&ha->pdev->dev, task_data->data_dma))
+			return -ENOMEM;
 	}
 
 	DEBUG2(ql4_printk(KERN_INFO, ha, "%s: MaxRecvLen %u, iscsi hrd %d\n",
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index ad2abc96c0f1..97e3857bda32 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -753,7 +753,7 @@ UFS_UNIT_DESC_PARAM(logical_block_size, _LOGICAL_BLK_SIZE, 1);
 UFS_UNIT_DESC_PARAM(logical_block_count, _LOGICAL_BLK_COUNT, 8);
 UFS_UNIT_DESC_PARAM(erase_block_size, _ERASE_BLK_SIZE, 4);
 UFS_UNIT_DESC_PARAM(provisioning_type, _PROVISIONING_TYPE, 1);
-UFS_UNIT_DESC_PARAM(physical_memory_resourse_count, _PHY_MEM_RSRC_CNT, 8);
+UFS_UNIT_DESC_PARAM(physical_memory_resource_count, _PHY_MEM_RSRC_CNT, 8);
 UFS_UNIT_DESC_PARAM(context_capabilities, _CTX_CAPABILITIES, 2);
 UFS_UNIT_DESC_PARAM(large_unit_granularity, _LARGE_UNIT_SIZE_M1, 1);
 
@@ -768,7 +768,7 @@ static struct attribute *ufs_sysfs_unit_descriptor[] = {
 	&dev_attr_logical_block_count.attr,
 	&dev_attr_erase_block_size.attr,
 	&dev_attr_provisioning_type.attr,
-	&dev_attr_physical_memory_resourse_count.attr,
+	&dev_attr_physical_memory_resource_count.attr,
 	&dev_attr_context_capabilities.attr,
 	&dev_attr_large_unit_granularity.attr,
 	NULL,
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 1d94fc89602f..de203b9e3f1b 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -560,12 +560,12 @@ static void ns_delay_scale(char *psc, char *sc, int delay_ns,
 	}
 }
 
-static void fifo_write(struct fsl_dspi *dspi)
+static void dspi_pushr_write(struct fsl_dspi *dspi)
 {
 	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pop_tx_pushr(dspi));
 }
 
-static void cmd_fifo_write(struct fsl_dspi *dspi)
+static void dspi_pushr_cmd_write(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd;
 
@@ -574,7 +574,7 @@ static void cmd_fifo_write(struct fsl_dspi *dspi)
 	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
 }
 
-static void tx_fifo_write(struct fsl_dspi *dspi, u16 txdata)
+static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 {
 	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
 }
@@ -590,18 +590,18 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
 		 */
 		u32 data = dspi_pop_tx(dspi);
 
-		cmd_fifo_write(dspi);
-		tx_fifo_write(dspi, data & 0xFFFF);
-		tx_fifo_write(dspi, data >> 16);
+		dspi_pushr_cmd_write(dspi);
+		dspi_pushr_txdata_write(dspi, data & 0xFFFF);
+		dspi_pushr_txdata_write(dspi, data >> 16);
 	} else {
 		/* Write one entry to both TX FIFO and CMD FIFO
 		 * simultaneously.
 		 */
-		fifo_write(dspi);
+		dspi_pushr_write(dspi);
 	}
 }
 
-static u32 fifo_read(struct fsl_dspi *dspi)
+static u32 dspi_popr_read(struct fsl_dspi *dspi)
 {
 	u32 rxdata = 0;
 
@@ -611,7 +611,7 @@ static u32 fifo_read(struct fsl_dspi *dspi)
 
 static void dspi_tcfq_read(struct fsl_dspi *dspi)
 {
-	dspi_push_rx(dspi, fifo_read(dspi));
+	dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
 static void dspi_eoq_write(struct fsl_dspi *dspi)
@@ -629,7 +629,7 @@ static void dspi_eoq_write(struct fsl_dspi *dspi)
 		if (fifo_size == (DSPI_FIFO_SIZE - 1))
 			dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
 		/* Write combined TX FIFO and CMD FIFO entry */
-		fifo_write(dspi);
+		dspi_pushr_write(dspi);
 	}
 }
 
@@ -639,7 +639,7 @@ static void dspi_eoq_read(struct fsl_dspi *dspi)
 
 	/* Read one FIFO entry and push to rx buffer */
 	while ((dspi->rx < dspi->rx_end) && fifo_size--)
-		dspi_push_rx(dspi, fifo_read(dspi));
+		dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
 static int dspi_rxtx(struct fsl_dspi *dspi)
@@ -773,10 +773,28 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		trans_mode = dspi->devtype_data->trans_mode;
 		switch (trans_mode) {
 		case DSPI_EOQ_MODE:
+			/*
+			 * Reinitialize the completion before transferring data
+			 * to avoid the case where it might remain in the done
+			 * state due to a spurious interrupt from a previous
+			 * transfer. This could falsely signal that the current
+			 * transfer has completed.
+			 */
+			if (dspi->irq)
+				reinit_completion(&dspi->xfer_done);
 			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
 			dspi_eoq_write(dspi);
 			break;
 		case DSPI_TCFQ_MODE:
+			/*
+			 * Reinitialize the completion before transferring data
+			 * to avoid the case where it might remain in the done
+			 * state due to a spurious interrupt from a previous
+			 * transfer. This could falsely signal that the current
+			 * transfer has completed.
+			 */
+			if (dspi->irq)
+				reinit_completion(&dspi->xfer_done);
 			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_TCFQE);
 			dspi_tcfq_write(dspi);
 			break;
@@ -793,13 +811,14 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			goto out;
 		}
 
-		if (!dspi->irq) {
-			do {
-				status = dspi_poll(dspi);
-			} while (status == -EINPROGRESS);
-		} else if (trans_mode != DSPI_DMA_MODE) {
-			wait_for_completion(&dspi->xfer_done);
-			reinit_completion(&dspi->xfer_done);
+		if (trans_mode != DSPI_DMA_MODE) {
+			if (dspi->irq) {
+				wait_for_completion(&dspi->xfer_done);
+			} else {
+				do {
+					status = dspi_poll(dspi);
+				} while (status == -EINPROGRESS);
+			}
 		}
 
 		if (transfer->delay_usecs)
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 57cfe06d7d73..93970939d1e4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1333,30 +1333,21 @@ static sint aes_cipher(u8 *key, uint	hdrlen,
 		num_blocks, payload_index;
 
 	u8 pn_vector[6];
-	u8 mic_iv[16];
-	u8 mic_header1[16];
-	u8 mic_header2[16];
-	u8 ctr_preload[16];
+	u8 mic_iv[16] = {};
+	u8 mic_header1[16] = {};
+	u8 mic_header2[16] = {};
+	u8 ctr_preload[16] = {};
 
 	/* Intermediate Buffers */
-	u8 chain_buffer[16];
-	u8 aes_out[16];
-	u8 padded_buffer[16];
+	u8 chain_buffer[16] = {};
+	u8 aes_out[16] = {};
+	u8 padded_buffer[16] = {};
 	u8 mic[8];
 	uint	frtype  = GetFrameType(pframe);
 	uint	frsubtype  = GetFrameSubType(pframe);
 
 	frsubtype = frsubtype>>4;
 
-
-	memset((void *)mic_iv, 0, 16);
-	memset((void *)mic_header1, 0, 16);
-	memset((void *)mic_header2, 0, 16);
-	memset((void *)ctr_preload, 0, 16);
-	memset((void *)chain_buffer, 0, 16);
-	memset((void *)aes_out, 0, 16);
-	memset((void *)padded_buffer, 0, 16);
-
 	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
 		a4_exists = 0;
 	else
@@ -1581,15 +1572,15 @@ static sint aes_decipher(u8 *key, uint	hdrlen,
 			num_blocks, payload_index;
 	sint res = _SUCCESS;
 	u8 pn_vector[6];
-	u8 mic_iv[16];
-	u8 mic_header1[16];
-	u8 mic_header2[16];
-	u8 ctr_preload[16];
+	u8 mic_iv[16] = {};
+	u8 mic_header1[16] = {};
+	u8 mic_header2[16] = {};
+	u8 ctr_preload[16] = {};
 
 		/* Intermediate Buffers */
-	u8 chain_buffer[16];
-	u8 aes_out[16];
-	u8 padded_buffer[16];
+	u8 chain_buffer[16] = {};
+	u8 aes_out[16] = {};
+	u8 padded_buffer[16] = {};
 	u8 mic[8];
 
 
@@ -1599,15 +1590,6 @@ static sint aes_decipher(u8 *key, uint	hdrlen,
 
 	frsubtype = frsubtype>>4;
 
-
-	memset((void *)mic_iv, 0, 16);
-	memset((void *)mic_header1, 0, 16);
-	memset((void *)mic_header2, 0, 16);
-	memset((void *)ctr_preload, 0, 16);
-	memset((void *)chain_buffer, 0, 16);
-	memset((void *)aes_out, 0, 16);
-	memset((void *)padded_buffer, 0, 16);
-
 	/* start to decrypt the payload */
 
 	num_blocks = (plen-8) / 16; /* plen including LLC, payload_length and mic) */
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 9a4049c894f7..e323e9c0a321 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -874,16 +874,25 @@ static struct platform_driver ulite_platform_driver = {
 
 static int __init ulite_init(void)
 {
+	int ret;
+
+	pr_debug("uartlite: calling uart_register_driver()\n");
+	ret = uart_register_driver(&ulite_uart_driver);
+	if (ret)
+		return ret;
 
 	pr_debug("uartlite: calling platform_driver_register()\n");
-	return platform_driver_register(&ulite_platform_driver);
+	ret = platform_driver_register(&ulite_platform_driver);
+	if (ret)
+		uart_unregister_driver(&ulite_uart_driver);
+
+	return ret;
 }
 
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	if (ulite_uart_driver.state)
-		uart_unregister_driver(&ulite_uart_driver);
+	uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e58dceaf7ff0..3db8efd58747 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4368,6 +4368,7 @@ void do_unblank_screen(int leaving_gfx)
 	set_palette(vc);
 	set_cursor(vc);
 	vt_event_post(VT_EVENT_UNBLANK, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 }
 EXPORT_SYMBOL(do_unblank_screen);
 
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index bc925394e881..6afb941dd267 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -89,7 +89,6 @@ struct wdm_device {
 	u16			wMaxCommand;
 	u16			wMaxPacketSize;
 	__le16			inum;
-	int			reslength;
 	int			length;
 	int			read;
 	int			count;
@@ -201,6 +200,11 @@ static void wdm_in_callback(struct urb *urb)
 	if (desc->rerr == 0 && status != -EPIPE)
 		desc->rerr = status;
 
+	if (length == 0) {
+		dev_dbg(&desc->intf->dev, "received ZLP\n");
+		goto skip_zlp;
+	}
+
 	if (length + desc->length > desc->wMaxCommand) {
 		/* The buffer would overflow */
 		set_bit(WDM_OVERFLOW, &desc->flags);
@@ -209,18 +213,18 @@ static void wdm_in_callback(struct urb *urb)
 		if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
 			memmove(desc->ubuf + desc->length, desc->inbuf, length);
 			desc->length += length;
-			desc->reslength = length;
 		}
 	}
 skip_error:
 
 	if (desc->rerr) {
 		/*
-		 * Since there was an error, userspace may decide to not read
-		 * any data after poll'ing.
+		 * If there was a ZLP or an error, userspace may decide to not
+		 * read any data after poll'ing.
 		 * We should respond to further attempts from the device to send
 		 * data, so that we can get unstuck.
 		 */
+skip_zlp:
 		schedule_work(&desc->service_outs_intr);
 	} else {
 		set_bit(WDM_READ, &desc->flags);
@@ -571,15 +575,6 @@ static ssize_t wdm_read
 			goto retry;
 		}
 
-		if (!desc->reslength) { /* zero length read */
-			dev_dbg(&desc->intf->dev, "zero length - clearing WDM_READ\n");
-			clear_bit(WDM_READ, &desc->flags);
-			rv = service_outstanding_interrupt(desc);
-			spin_unlock_irq(&desc->iuspin);
-			if (rv < 0)
-				goto err;
-			goto retry;
-		}
 		cntr = desc->length;
 		spin_unlock_irq(&desc->iuspin);
 	}
@@ -839,7 +834,7 @@ static void service_interrupt_work(struct work_struct *work)
 
 	spin_lock_irq(&desc->iuspin);
 	service_outstanding_interrupt(desc);
-	if (!desc->resp_count) {
+	if (!desc->resp_count && (desc->length || desc->rerr)) {
 		set_bit(WDM_READ, &desc->flags);
 		wake_up(&desc->wait);
 	}
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 98b1c457a091..5f6ba422c463 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -224,7 +224,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x046a, 0x0023), .driver_info = USB_QUIRK_RESET_RESUME },
 
 	/* Logitech HD Webcam C270 */
-	{ USB_DEVICE(0x046d, 0x0825), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x046d, 0x0825), .driver_info = USB_QUIRK_RESET_RESUME |
+		USB_QUIRK_NO_LPM},
 
 	/* Logitech HD Pro Webcams C920, C920-C, C922, C925e and C930e */
 	{ USB_DEVICE(0x046d, 0x082d), .driver_info = USB_QUIRK_DELAY_INIT },
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 502d911f71fa..571ab8e0c759 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -717,15 +717,16 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 		dev_set_name(&dev->dev, "usb%d", bus->busnum);
 		root_hub = 1;
 	} else {
+		int n;
+
 		/* match any labeling on the hubs; it's one-based */
 		if (parent->devpath[0] == '0') {
-			snprintf(dev->devpath, sizeof dev->devpath,
-				"%d", port1);
+			n = snprintf(dev->devpath, sizeof(dev->devpath), "%d", port1);
 			/* Root ports are not counted in route string */
 			dev->route = 0;
 		} else {
-			snprintf(dev->devpath, sizeof dev->devpath,
-				"%s.%d", parent->devpath, port1);
+			n = snprintf(dev->devpath, sizeof(dev->devpath), "%s.%d",
+				     parent->devpath, port1);
 			/* Route string assumes hubs have less than 16 ports */
 			if (port1 < 15)
 				dev->route = parent->route +
@@ -734,6 +735,11 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 				dev->route = parent->route +
 					(15 << ((parent->level - 1)*4));
 		}
+		if (n >= sizeof(dev->devpath)) {
+			usb_put_hcd(bus_to_hcd(bus));
+			usb_put_dev(dev);
+			return NULL;
+		}
 
 		dev->dev.parent = &parent->dev;
 		dev_set_name(&dev->dev, "%d-%s", bus->busnum, dev->devpath);
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 90fe33f9e095..48d02c5ff849 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1320,14 +1320,14 @@ static struct se_portal_group *usbg_make_tpg(struct se_wwn *wwn,
 	struct usbg_tport *tport = container_of(wwn, struct usbg_tport,
 			tport_wwn);
 	struct usbg_tpg *tpg;
-	unsigned long tpgt;
+	u16 tpgt;
 	int ret;
 	struct f_tcm_opts *opts;
 	unsigned i;
 
 	if (strstr(name, "tpgt_") != name)
 		return ERR_PTR(-EINVAL);
-	if (kstrtoul(name + 5, 0, &tpgt) || tpgt > UINT_MAX)
+	if (kstrtou16(name + 5, 0, &tpgt))
 		return ERR_PTR(-EINVAL);
 	ret = -ENODEV;
 	mutex_lock(&tpg_instances_lock);
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index d432f96ec419..fc67797a0095 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -286,8 +286,8 @@ __acquires(&port->port_lock)
 			break;
 	}
 
-	if (do_tty_wake && port->port.tty)
-		tty_wakeup(port->port.tty);
+	if (do_tty_wake)
+		tty_port_tty_wakeup(&port->port);
 	return status;
 }
 
@@ -564,7 +564,7 @@ static int gs_start_io(struct gs_port *port)
 		gs_start_tx(port);
 		/* Unblock any pending writes into our circular buffer, in case
 		 * we didn't in gs_start_tx() */
-		tty_wakeup(port->port.tty);
+		tty_port_tty_wakeup(&port->port);
 	} else {
 		/* Free reqs only if we are still connected */
 		if (port->port_usb) {
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index a2a1baabca93..464fd15e12ad 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -288,6 +288,9 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 		break;
 	case CMDT_RSP_NAK:
 		switch (cmd) {
+		case DP_CMD_STATUS_UPDATE:
+			dp->state = DP_STATE_EXIT;
+			break;
 		case DP_CMD_CONFIGURE:
 			dp->data.conf = 0;
 			ret = dp_altmode_configured(dp);
@@ -488,7 +491,7 @@ static ssize_t pin_assignment_show(struct device *dev,
 
 	assignments = get_current_pin_assignments(dp);
 
-	for (i = 0; assignments; assignments >>= 1, i++) {
+	for (i = 0; assignments && i < DP_PIN_ASSIGN_MAX; assignments >>= 1, i++) {
 		if (assignments & 1) {
 			if (i == cur)
 				len += sprintf(buf + len, "[%s] ",
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 004894e6dd23..757111e52994 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4747,7 +4747,6 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	int err = 0;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_trans_handle *trans;
-	u64 last_unlink_trans;
 
 	if (inode->i_size > BTRFS_EMPTY_DIR_SIZE)
 		return -ENOTEMPTY;
@@ -4758,6 +4757,23 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
+	/*
+	 * Propagate the last_unlink_trans value of the deleted dir to its
+	 * parent directory. This is to prevent an unrecoverable log tree in the
+	 * case we do something like this:
+	 * 1) create dir foo
+	 * 2) create snapshot under dir foo
+	 * 3) delete the snapshot
+	 * 4) rmdir foo
+	 * 5) mkdir foo
+	 * 6) fsync foo or some file inside foo
+	 *
+	 * This is because we can't unlink other roots when replaying the dir
+	 * deletes for directory foo.
+	 */
+	if (BTRFS_I(inode)->last_unlink_trans >= trans->transid)
+		btrfs_record_snapshot_destroy(trans, BTRFS_I(dir));
+
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 		err = btrfs_unlink_subvol(trans, dir, dentry);
 		goto out;
@@ -4767,28 +4783,12 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto out;
 
-	last_unlink_trans = BTRFS_I(inode)->last_unlink_trans;
-
 	/* now the directory is empty */
 	err = btrfs_unlink_inode(trans, root, BTRFS_I(dir),
 			BTRFS_I(d_inode(dentry)), dentry->d_name.name,
 			dentry->d_name.len);
-	if (!err) {
+	if (!err)
 		btrfs_i_size_write(BTRFS_I(inode), 0);
-		/*
-		 * Propagate the last_unlink_trans value of the deleted dir to
-		 * its parent directory. This is to prevent an unrecoverable
-		 * log tree in the case we do something like this:
-		 * 1) create dir foo
-		 * 2) create snapshot under dir foo
-		 * 3) delete the snapshot
-		 * 4) rmdir foo
-		 * 5) mkdir foo
-		 * 6) fsync foo or some file inside foo
-		 */
-		if (last_unlink_trans >= trans->transid)
-			BTRFS_I(dir)->last_unlink_trans = last_unlink_trans;
-	}
 out:
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(root->fs_info);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 674d774eb662..a29182be29fa 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -793,6 +793,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 		return -EINVAL;
 
+	if (btrfs_root_refs(&root->root_item) == 0)
+		return -ENOENT;
+
 	if (atomic_read(&root->nr_swapfiles)) {
 		btrfs_warn(fs_info,
 			   "cannot snapshot subvolume with active swapfile");
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f75333d7b78a..75bf490cd732 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1033,7 +1033,9 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	search_key.type = BTRFS_INODE_REF_KEY;
 	search_key.offset = parent_objectid;
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
-	if (ret == 0) {
+	if (ret < 0) {
+		return ret;
+	} else if (ret == 0) {
 		struct btrfs_inode_ref *victim_ref;
 		unsigned long ptr;
 		unsigned long ptr_end;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 83122fc5f813..9b10de2276c6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1749,7 +1749,7 @@ static int ceph_zero_objects(struct inode *inode, loff_t offset, loff_t length)
 	s32 stripe_unit = ci->i_layout.stripe_unit;
 	s32 stripe_count = ci->i_layout.stripe_count;
 	s32 object_size = ci->i_layout.object_size;
-	u64 object_set_size = object_size * stripe_count;
+	u64 object_set_size = (u64) object_size * stripe_count;
 	u64 nearly, t;
 
 	/* round offset up to next period boundary */
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index db1fcdedf289..af9752535dba 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -306,6 +306,14 @@ check_smb_hdr(struct smb_hdr *smb)
 	if (smb->Command == SMB_COM_LOCKING_ANDX)
 		return 0;
 
+	/*
+	 * Windows NT server returns error resposne (e.g. STATUS_DELETE_PENDING
+	 * or STATUS_OBJECT_NAME_NOT_FOUND or ERRDOS/ERRbadfile or any other)
+	 * for some TRANS2 requests without the RESPONSE flag set in header.
+	 */
+	if (smb->Command == SMB_COM_TRANSACTION2 && smb->Status.CifsError != 0)
+		return 0;
+
 	cifs_dbg(VFS, "Server sent request, not response. mid=%u\n",
 		 get_mid(smb));
 	return 1;
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index d161bbafe77f..8cffb5dd98cf 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -178,45 +178,30 @@ int dbMount(struct inode *ipbmap)
 	dbmp_le = (struct dbmap_disk *) mp->data;
 	bmp->db_mapsize = le64_to_cpu(dbmp_le->dn_mapsize);
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
-
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
-	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE ||
-		bmp->db_l2nbperpage < 0) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
-
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
-	if (!bmp->db_numag || bmp->db_numag > MAXAG) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
-
 	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
 	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
 	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
-	if (bmp->db_maxag >= MAXAG || bmp->db_maxag < 0 ||
-		bmp->db_agpref >= MAXAG || bmp->db_agpref < 0) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
-
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
-	if (!bmp->db_agwidth) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
-	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
-	    bmp->db_agl2size < 0) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
 
-	if (((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
+	if ((bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) ||
+	    (bmp->db_l2nbperpage < 0) ||
+	    !bmp->db_numag || (bmp->db_numag > MAXAG) ||
+	    (bmp->db_maxag >= MAXAG) || (bmp->db_maxag < 0) ||
+	    (bmp->db_agpref >= MAXAG) || (bmp->db_agpref < 0) ||
+	    (bmp->db_agheight < 0) || (bmp->db_agheight > (L2LPERCTL >> 1)) ||
+	    (bmp->db_agwidth < 1) || (bmp->db_agwidth > (LPERCTL / MAXAG)) ||
+	    (bmp->db_agwidth > (1 << (L2LPERCTL - (bmp->db_agheight << 1)))) ||
+	    (bmp->db_agstart < 0) ||
+	    (bmp->db_agstart > (CTLTREESIZE - 1 - bmp->db_agwidth * (MAXAG - 1))) ||
+	    (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG) ||
+	    (bmp->db_agl2size < 0) ||
+	    ((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
diff --git a/fs/namespace.c b/fs/namespace.c
index 8a3514489768..ee5a87061f20 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2124,14 +2124,14 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
 		struct mount *q;
 		hlist_del_init(&child->mnt_hash);
-		q = __lookup_mnt(&child->mnt_parent->mnt,
-				 child->mnt_mountpoint);
-		if (q)
-			mnt_change_mountpoint(child, smp, q);
 		/* Notice when we are propagating across user namespaces */
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
 		child->mnt.mnt_flags &= ~MNT_LOCKED;
+		q = __lookup_mnt(&child->mnt_parent->mnt,
+				 child->mnt_mountpoint);
+		if (q)
+			mnt_change_mountpoint(child, smp, q);
 		commit_tree(child);
 	}
 	put_mountpoint(smp);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 3b4f93dcf323..31ae042f5a75 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1129,6 +1129,7 @@ static void ff_layout_reset_read(struct nfs_pgio_header *hdr)
 }
 
 static int ff_layout_async_handle_error_v4(struct rpc_task *task,
+					   u32 op_status,
 					   struct nfs4_state *state,
 					   struct nfs_client *clp,
 					   struct pnfs_layout_segment *lseg,
@@ -1139,32 +1140,42 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
 	struct nfs4_slot_table *tbl = &clp->cl_session->fc_slot_table;
 
-	switch (task->tk_status) {
-	case -NFS4ERR_BADSESSION:
-	case -NFS4ERR_BADSLOT:
-	case -NFS4ERR_BAD_HIGH_SLOT:
-	case -NFS4ERR_DEADSESSION:
-	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
-	case -NFS4ERR_SEQ_FALSE_RETRY:
-	case -NFS4ERR_SEQ_MISORDERED:
+	switch (op_status) {
+	case NFS4_OK:
+	case NFS4ERR_NXIO:
+		break;
+	case NFSERR_PERM:
+		if (!task->tk_xprt)
+			break;
+		xprt_force_disconnect(task->tk_xprt);
+		goto out_retry;
+	case NFS4ERR_BADSESSION:
+	case NFS4ERR_BADSLOT:
+	case NFS4ERR_BAD_HIGH_SLOT:
+	case NFS4ERR_DEADSESSION:
+	case NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
+	case NFS4ERR_SEQ_FALSE_RETRY:
+	case NFS4ERR_SEQ_MISORDERED:
 		dprintk("%s ERROR %d, Reset session. Exchangeid "
 			"flags 0x%x\n", __func__, task->tk_status,
 			clp->cl_exchange_flags);
 		nfs4_schedule_session_recovery(clp->cl_session, task->tk_status);
-		break;
-	case -NFS4ERR_DELAY:
-	case -NFS4ERR_GRACE:
+		goto out_retry;
+	case NFS4ERR_DELAY:
+		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
+		fallthrough;
+	case NFS4ERR_GRACE:
 		rpc_delay(task, FF_LAYOUT_POLL_RETRY_MAX);
-		break;
-	case -NFS4ERR_RETRY_UNCACHED_REP:
-		break;
+		goto out_retry;
+	case NFS4ERR_RETRY_UNCACHED_REP:
+		goto out_retry;
 	/* Invalidate Layout errors */
-	case -NFS4ERR_PNFS_NO_LAYOUT:
-	case -ESTALE:           /* mapped NFS4ERR_STALE */
-	case -EBADHANDLE:       /* mapped NFS4ERR_BADHANDLE */
-	case -EISDIR:           /* mapped NFS4ERR_ISDIR */
-	case -NFS4ERR_FHEXPIRED:
-	case -NFS4ERR_WRONG_TYPE:
+	case NFS4ERR_PNFS_NO_LAYOUT:
+	case NFS4ERR_STALE:
+	case NFS4ERR_BADHANDLE:
+	case NFS4ERR_ISDIR:
+	case NFS4ERR_FHEXPIRED:
+	case NFS4ERR_WRONG_TYPE:
 		dprintk("%s Invalid layout error %d\n", __func__,
 			task->tk_status);
 		/*
@@ -1177,6 +1188,11 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		pnfs_destroy_layout(NFS_I(inode));
 		rpc_wake_up(&tbl->slot_tbl_waitq);
 		goto reset;
+	default:
+		break;
+	}
+
+	switch (task->tk_status) {
 	/* RPC connection errors */
 	case -ECONNREFUSED:
 	case -EHOSTDOWN:
@@ -1190,26 +1206,56 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
 				&devid->deviceid);
 		rpc_wake_up(&tbl->slot_tbl_waitq);
-		/* fall through */
+		break;
 	default:
-		if (ff_layout_avoid_mds_available_ds(lseg))
-			return -NFS4ERR_RESET_TO_PNFS;
-reset:
-		dprintk("%s Retry through MDS. Error %d\n", __func__,
-			task->tk_status);
-		return -NFS4ERR_RESET_TO_MDS;
+		break;
 	}
+
+	if (ff_layout_avoid_mds_available_ds(lseg))
+		return -NFS4ERR_RESET_TO_PNFS;
+reset:
+	dprintk("%s Retry through MDS. Error %d\n", __func__,
+		task->tk_status);
+	return -NFS4ERR_RESET_TO_MDS;
+
+out_retry:
 	task->tk_status = 0;
 	return -EAGAIN;
 }
 
 /* Retry all errors through either pNFS or MDS except for -EJUKEBOX */
 static int ff_layout_async_handle_error_v3(struct rpc_task *task,
+					   u32 op_status,
+					   struct nfs_client *clp,
 					   struct pnfs_layout_segment *lseg,
 					   int idx)
 {
 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
 
+	switch (op_status) {
+	case NFS_OK:
+	case NFSERR_NXIO:
+		break;
+	case NFSERR_PERM:
+		if (!task->tk_xprt)
+			break;
+		xprt_force_disconnect(task->tk_xprt);
+		goto out_retry;
+	case NFSERR_ACCES:
+	case NFSERR_BADHANDLE:
+	case NFSERR_FBIG:
+	case NFSERR_IO:
+	case NFSERR_NOSPC:
+	case NFSERR_ROFS:
+	case NFSERR_STALE:
+		goto out_reset_to_pnfs;
+	case NFSERR_JUKEBOX:
+		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
+		goto out_retry;
+	default:
+		break;
+	}
+
 	switch (task->tk_status) {
 	/* File access problems. Don't mark the device as unavailable */
 	case -EACCES:
@@ -1228,6 +1274,7 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
 				&devid->deviceid);
 	}
+out_reset_to_pnfs:
 	/* FIXME: Need to prevent infinite looping here. */
 	return -NFS4ERR_RESET_TO_PNFS;
 out_retry:
@@ -1238,6 +1285,7 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 }
 
 static int ff_layout_async_handle_error(struct rpc_task *task,
+					u32 op_status,
 					struct nfs4_state *state,
 					struct nfs_client *clp,
 					struct pnfs_layout_segment *lseg,
@@ -1256,10 +1304,11 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 
 	switch (vers) {
 	case 3:
-		return ff_layout_async_handle_error_v3(task, lseg, idx);
-	case 4:
-		return ff_layout_async_handle_error_v4(task, state, clp,
+		return ff_layout_async_handle_error_v3(task, op_status, clp,
 						       lseg, idx);
+	case 4:
+		return ff_layout_async_handle_error_v4(task, op_status, state,
+						       clp, lseg, idx);
 	default:
 		/* should never happen */
 		WARN_ON_ONCE(1);
@@ -1304,7 +1353,17 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 	switch (status) {
 	case NFS4ERR_DELAY:
 	case NFS4ERR_GRACE:
-		return;
+	case NFS4ERR_PERM:
+		break;
+	case NFS4ERR_NXIO:
+		ff_layout_mark_ds_unreachable(lseg, idx);
+		/*
+		 * Don't return the layout if this is a read and we still
+		 * have layouts to try
+		 */
+		if (opnum == OP_READ)
+			break;
+		fallthrough;
 	default:
 		break;
 	}
@@ -1327,12 +1386,15 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
 	int err;
 
 	trace_nfs4_pnfs_read(hdr, task->tk_status);
-	if (task->tk_status < 0)
+	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
 					    hdr->args.offset, hdr->args.count,
 					    hdr->res.op_status, OP_READ,
 					    task->tk_status);
-	err = ff_layout_async_handle_error(task, hdr->args.context->state,
+	}
+
+	err = ff_layout_async_handle_error(task, hdr->res.op_status,
+					   hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
 					   hdr->pgio_mirror_idx);
 
@@ -1500,12 +1562,15 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 	int err;
 
 	trace_nfs4_pnfs_write(hdr, task->tk_status);
-	if (task->tk_status < 0)
+	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
 					    hdr->args.offset, hdr->args.count,
 					    hdr->res.op_status, OP_WRITE,
 					    task->tk_status);
-	err = ff_layout_async_handle_error(task, hdr->args.context->state,
+	}
+
+	err = ff_layout_async_handle_error(task, hdr->res.op_status,
+					   hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
 					   hdr->pgio_mirror_idx);
 
@@ -1543,13 +1608,16 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 	int err;
 
 	trace_nfs4_pnfs_commit_ds(data, task->tk_status);
-	if (task->tk_status < 0)
+	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(data->lseg, data->ds_commit_index,
 					    data->args.offset, data->args.count,
 					    data->res.op_status, OP_COMMIT,
 					    task->tk_status);
-	err = ff_layout_async_handle_error(task, NULL, data->ds_clp,
-					   data->lseg, data->ds_commit_index);
+	}
+
+	err = ff_layout_async_handle_error(task, data->res.op_status,
+					   NULL, data->ds_clp, data->lseg,
+					   data->ds_commit_index);
 
 	switch (err) {
 	case -NFS4ERR_RESET_TO_PNFS:
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 251f45fee53c..0dc53732b5c9 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2180,15 +2180,26 @@ EXPORT_SYMBOL_GPL(nfs_net_id);
 static int nfs_net_init(struct net *net)
 {
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
+	int err;
 
 	nfs_clients_init(net);
 
 	if (!rpc_proc_register(net, &nn->rpcstats)) {
-		nfs_clients_exit(net);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_proc_rpc;
 	}
 
-	return nfs_fs_proc_net_init(net);
+	err = nfs_fs_proc_net_init(net);
+	if (err)
+		goto err_proc_nfs;
+
+	return 0;
+
+err_proc_nfs:
+	rpc_proc_unregister(net, "nfs");
+err_proc_rpc:
+	nfs_clients_exit(net);
+	return err;
 }
 
 static void nfs_net_exit(struct net *net)
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 4d75e1cdf0b9..af813e777379 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -191,7 +191,9 @@ enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path)
 
 struct dentry *ovl_dentry_upper(struct dentry *dentry)
 {
-	return ovl_upperdentry_dereference(OVL_I(d_inode(dentry)));
+	struct inode *inode = d_inode(dentry);
+
+	return inode ? ovl_upperdentry_dereference(OVL_I(inode)) : NULL;
 }
 
 struct dentry *ovl_dentry_lower(struct dentry *dentry)
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 3f0c89001fcf..86175a8c04b3 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -33,21 +33,27 @@ static void proc_evict_inode(struct inode *inode)
 {
 	struct proc_dir_entry *de;
 	struct ctl_table_header *head;
+	struct proc_inode *ei = PROC_I(inode);
 
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 
 	/* Stop tracking associated processes */
-	put_pid(PROC_I(inode)->pid);
+	if (ei->pid) {
+		put_pid(ei->pid);
+		ei->pid = NULL;
+	}
 
 	/* Let go of any associated proc directory entry */
-	de = PDE(inode);
-	if (de)
+	de = ei->pde;
+	if (de) {
 		pde_put(de);
+		ei->pde = NULL;
+	}
 
-	head = PROC_I(inode)->sysctl;
+	head = ei->sysctl;
 	if (head) {
-		RCU_INIT_POINTER(PROC_I(inode)->sysctl, NULL);
+		WRITE_ONCE(ei->sysctl, NULL);
 		proc_sys_evict_inode(inode, head);
 	}
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index f4264dd4ea31..c8dad2006980 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -928,17 +928,21 @@ static int proc_sys_compare(const struct dentry *dentry,
 	struct ctl_table_header *head;
 	struct inode *inode;
 
-	/* Although proc doesn't have negative dentries, rcu-walk means
-	 * that inode here can be NULL */
-	/* AV: can it, indeed? */
-	inode = d_inode_rcu(dentry);
-	if (!inode)
-		return 1;
 	if (name->len != len)
 		return 1;
 	if (memcmp(name->name, str, len))
 		return 1;
-	head = rcu_dereference(PROC_I(inode)->sysctl);
+
+	// false positive is fine here - we'll recheck anyway
+	if (d_in_lookup(dentry))
+		return 0;
+
+	inode = d_inode_rcu(dentry);
+	// we just might have run into dentry in the middle of __dentry_kill()
+	if (!inode)
+		return 1;
+
+	head = READ_ONCE(PROC_I(inode)->sysctl);
 	return !head || !sysctl_is_seen(head);
 }
 
diff --git a/include/drm/spsc_queue.h b/include/drm/spsc_queue.h
index 125f096c88cb..ee9df8cc67b7 100644
--- a/include/drm/spsc_queue.h
+++ b/include/drm/spsc_queue.h
@@ -70,9 +70,11 @@ static inline bool spsc_queue_push(struct spsc_queue *queue, struct spsc_node *n
 
 	preempt_disable();
 
+	atomic_inc(&queue->job_count);
+	smp_mb__after_atomic();
+
 	tail = (struct spsc_node **)atomic_long_xchg(&queue->tail, (long)&node->next);
 	WRITE_ONCE(*tail, node);
-	atomic_inc(&queue->job_count);
 
 	/*
 	 * In case of first element verify new node will be visible to the consumer
diff --git a/include/linux/of.h b/include/linux/of.h
index 8681277af9c6..728b9df20a52 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -415,130 +415,6 @@ extern int of_detach_node(struct device_node *);
 
 #define of_match_ptr(_ptr)	(_ptr)
 
-/**
- * of_property_read_u8_array - Find and read an array of u8 from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 8-bit value(s) from
- * it.
- *
- * dts entry of array should be like:
- *  ``property = /bits/ 8 <0x50 0x60 0x70>;``
- *
- * Return: 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_values is modified only if a valid u8 value can be decoded.
- */
-static inline int of_property_read_u8_array(const struct device_node *np,
-					    const char *propname,
-					    u8 *out_values, size_t sz)
-{
-	int ret = of_property_read_variable_u8_array(np, propname, out_values,
-						     sz, 0);
-	if (ret >= 0)
-		return 0;
-	else
-		return ret;
-}
-
-/**
- * of_property_read_u16_array - Find and read an array of u16 from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 16-bit value(s) from
- * it.
- *
- * dts entry of array should be like:
- *  ``property = /bits/ 16 <0x5000 0x6000 0x7000>;``
- *
- * Return: 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_values is modified only if a valid u16 value can be decoded.
- */
-static inline int of_property_read_u16_array(const struct device_node *np,
-					     const char *propname,
-					     u16 *out_values, size_t sz)
-{
-	int ret = of_property_read_variable_u16_array(np, propname, out_values,
-						      sz, 0);
-	if (ret >= 0)
-		return 0;
-	else
-		return ret;
-}
-
-/**
- * of_property_read_u32_array - Find and read an array of 32 bit integers
- * from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 32-bit value(s) from
- * it.
- *
- * Return: 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_values is modified only if a valid u32 value can be decoded.
- */
-static inline int of_property_read_u32_array(const struct device_node *np,
-					     const char *propname,
-					     u32 *out_values, size_t sz)
-{
-	int ret = of_property_read_variable_u32_array(np, propname, out_values,
-						      sz, 0);
-	if (ret >= 0)
-		return 0;
-	else
-		return ret;
-}
-
-/**
- * of_property_read_u64_array - Find and read an array of 64 bit integers
- * from a property.
- *
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
- * @sz:		number of array elements to read
- *
- * Search for a property in a device node and read 64-bit value(s) from
- * it.
- *
- * Return: 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
- *
- * The out_values is modified only if a valid u64 value can be decoded.
- */
-static inline int of_property_read_u64_array(const struct device_node *np,
-					     const char *propname,
-					     u64 *out_values, size_t sz)
-{
-	int ret = of_property_read_variable_u64_array(np, propname, out_values,
-						      sz, 0);
-	if (ret >= 0)
-		return 0;
-	else
-		return ret;
-}
-
 /*
  * struct property *prop;
  * const __be32 *p;
@@ -719,32 +595,6 @@ static inline int of_property_count_elems_of_size(const struct device_node *np,
 	return -ENOSYS;
 }
 
-static inline int of_property_read_u8_array(const struct device_node *np,
-			const char *propname, u8 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-
-static inline int of_property_read_u16_array(const struct device_node *np,
-			const char *propname, u16 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-
-static inline int of_property_read_u32_array(const struct device_node *np,
-					     const char *propname,
-					     u32 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-
-static inline int of_property_read_u64_array(const struct device_node *np,
-					     const char *propname,
-					     u64 *out_values, size_t sz)
-{
-	return -ENOSYS;
-}
-
 static inline int of_property_read_u32_index(const struct device_node *np,
 			const char *propname, u32 index, u32 *out_value)
 {
@@ -1194,7 +1044,8 @@ static inline int of_property_read_string_index(const struct device_node *np,
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
  *
- * Search for a property in a device node.
+ * Search for a boolean property in a device node. Usage on non-boolean
+ * property types is deprecated.
  *
  * Return: true if the property exists false otherwise.
  */
@@ -1206,6 +1057,144 @@ static inline bool of_property_read_bool(const struct device_node *np,
 	return prop ? true : false;
 }
 
+/**
+ * of_property_present - Test if a property is present in a node
+ * @np:		device node to search for the property.
+ * @propname:	name of the property to be searched.
+ *
+ * Test for a property present in a device node.
+ *
+ * Return: true if the property exists false otherwise.
+ */
+static inline bool of_property_present(const struct device_node *np, const char *propname)
+{
+	return of_property_read_bool(np, propname);
+}
+
+/**
+ * of_property_read_u8_array - Find and read an array of u8 from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 8-bit value(s) from
+ * it.
+ *
+ * dts entry of array should be like:
+ *  ``property = /bits/ 8 <0x50 0x60 0x70>;``
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u8 value can be decoded.
+ */
+static inline int of_property_read_u8_array(const struct device_node *np,
+					    const char *propname,
+					    u8 *out_values, size_t sz)
+{
+	int ret = of_property_read_variable_u8_array(np, propname, out_values,
+						     sz, 0);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
+/**
+ * of_property_read_u16_array - Find and read an array of u16 from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 16-bit value(s) from
+ * it.
+ *
+ * dts entry of array should be like:
+ *  ``property = /bits/ 16 <0x5000 0x6000 0x7000>;``
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u16 value can be decoded.
+ */
+static inline int of_property_read_u16_array(const struct device_node *np,
+					     const char *propname,
+					     u16 *out_values, size_t sz)
+{
+	int ret = of_property_read_variable_u16_array(np, propname, out_values,
+						      sz, 0);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
+/**
+ * of_property_read_u32_array - Find and read an array of 32 bit integers
+ * from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 32-bit value(s) from
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u32 value can be decoded.
+ */
+static inline int of_property_read_u32_array(const struct device_node *np,
+					     const char *propname,
+					     u32 *out_values, size_t sz)
+{
+	int ret = of_property_read_variable_u32_array(np, propname, out_values,
+						      sz, 0);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
+/**
+ * of_property_read_u64_array - Find and read an array of 64 bit integers
+ * from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 64-bit value(s) from
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u64 value can be decoded.
+ */
+static inline int of_property_read_u64_array(const struct device_node *np,
+					     const char *propname,
+					     u64 *out_values, size_t sz)
+{
+	int ret = of_property_read_variable_u64_array(np, propname, out_values,
+						      sz, 0);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
 static inline int of_property_read_u8(const struct device_node *np,
 				       const char *propname,
 				       u8 *out_value)
diff --git a/include/linux/regulator/gpio-regulator.h b/include/linux/regulator/gpio-regulator.h
index fdeb312cdabd..c223e50ff9f7 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -42,6 +42,7 @@ struct gpio_regulator_state {
 /**
  * struct gpio_regulator_config - config structure
  * @supply_name:	Name of the regulator supply
+ * @input_supply:	Name of the input regulator supply
  * @enabled_at_boot:	Whether regulator has been enabled at
  *			boot or not. 1 = Yes, 0 = No
  *			This is used to keep the regulator at
@@ -62,6 +63,7 @@ struct gpio_regulator_state {
  */
 struct gpio_regulator_config {
 	const char *supply_name;
+	const char *input_supply;
 
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
diff --git a/include/linux/usb/typec_dp.h b/include/linux/usb/typec_dp.h
index 296909ea04f2..afb73b3e0b80 100644
--- a/include/linux/usb/typec_dp.h
+++ b/include/linux/usb/typec_dp.h
@@ -56,6 +56,7 @@ enum {
 	DP_PIN_ASSIGN_D,
 	DP_PIN_ASSIGN_E,
 	DP_PIN_ASSIGN_F, /* Not supported after v1.0b */
+	DP_PIN_ASSIGN_MAX,
 };
 
 /* DisplayPort alt mode specific commands */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 30d50528d710..7e5df8218689 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2468,9 +2468,9 @@ struct ib_device_ops {
 	struct ib_mr *(*reg_dm_mr)(struct ib_pd *pd, struct ib_dm *dm,
 				   struct ib_dm_mr_attr *attr,
 				   struct uverbs_attr_bundle *attrs);
-	struct ib_counters *(*create_counters)(
-		struct ib_device *device, struct uverbs_attr_bundle *attrs);
-	int (*destroy_counters)(struct ib_counters *counters);
+	int (*create_counters)(struct ib_counters *counters,
+			       struct uverbs_attr_bundle *attrs);
+	void (*destroy_counters)(struct ib_counters *counters);
 	int (*read_counters)(struct ib_counters *counters,
 			     struct ib_counters_read_attr *counters_read_attr,
 			     struct uverbs_attr_bundle *attrs);
@@ -2563,6 +2563,7 @@ struct ib_device_ops {
 	int (*counter_update_stats)(struct rdma_counter *counter);
 
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
+	DECLARE_RDMA_OBJ_SIZE(ib_counters);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
 	DECLARE_RDMA_OBJ_SIZE(ib_srq);
diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
index 68d57c5e99bc..f763d1caf27d 100644
--- a/include/uapi/linux/vm_sockets.h
+++ b/include/uapi/linux/vm_sockets.h
@@ -17,6 +17,10 @@
 #ifndef _UAPI_VM_SOCKETS_H
 #define _UAPI_VM_SOCKETS_H
 
+#ifndef __KERNEL__
+#include <sys/socket.h>        /* for struct sockaddr and sa_family_t */
+#endif
+
 #include <linux/socket.h>
 
 /* Option name for STREAM socket buffer size.  Use as the option name in
diff --git a/init/Kconfig b/init/Kconfig
index 41e87e8a5c6c..50adf085d08b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -28,7 +28,9 @@ config CLANG_VERSION
 	default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
 
 config CC_CAN_LINK
-	def_bool $(success,$(srctree)/scripts/cc-can-link.sh $(CC))
+	bool
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(m64-flag)) if 64BIT
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(m32-flag))
 
 config CC_HAS_ASM_GOTO
 	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
diff --git a/lib/test_objagg.c b/lib/test_objagg.c
index da137939a410..78d25ab19a96 100644
--- a/lib/test_objagg.c
+++ b/lib/test_objagg.c
@@ -899,8 +899,10 @@ static int check_expect_hints_stats(struct objagg_hints *objagg_hints,
 	int err;
 
 	stats = objagg_hints_stats_get(objagg_hints);
-	if (IS_ERR(stats))
+	if (IS_ERR(stats)) {
+		*errmsg = "objagg_hints_stats_get() failed.";
 		return PTR_ERR(stats);
+	}
 	err = __check_expect_stats(stats, expect_stats, errmsg);
 	objagg_stats_put(stats);
 	return err;
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 70cd5f55628d..46ca0f1354fd 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -562,6 +562,7 @@ static int atrtr_create(struct rtentry *r, struct net_device *devhint)
 
 	/* Fill in the routing entry */
 	rt->target  = ta->sat_addr;
+	dev_put(rt->dev); /* Release old device */
 	dev_hold(devhint);
 	rt->dev     = devhint;
 	rt->flags   = r->rt_flags;
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 294cb9efe3d3..0caed8673658 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -45,7 +45,8 @@
 #include <net/atmclip.h>
 
 static struct net_device *clip_devs;
-static struct atm_vcc *atmarpd;
+static struct atm_vcc __rcu *atmarpd;
+static DEFINE_MUTEX(atmarpd_lock);
 static struct timer_list idle_timer;
 static const struct neigh_ops clip_neigh_ops;
 
@@ -53,24 +54,35 @@ static int to_atmarpd(enum atmarp_ctrl_type type, int itf, __be32 ip)
 {
 	struct sock *sk;
 	struct atmarp_ctrl *ctrl;
+	struct atm_vcc *vcc;
 	struct sk_buff *skb;
+	int err = 0;
 
 	pr_debug("(%d)\n", type);
-	if (!atmarpd)
-		return -EUNATCH;
+
+	rcu_read_lock();
+	vcc = rcu_dereference(atmarpd);
+	if (!vcc) {
+		err = -EUNATCH;
+		goto unlock;
+	}
 	skb = alloc_skb(sizeof(struct atmarp_ctrl), GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
+	if (!skb) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 	ctrl = skb_put(skb, sizeof(struct atmarp_ctrl));
 	ctrl->type = type;
 	ctrl->itf_num = itf;
 	ctrl->ip = ip;
-	atm_force_charge(atmarpd, skb->truesize);
+	atm_force_charge(vcc, skb->truesize);
 
-	sk = sk_atm(atmarpd);
+	sk = sk_atm(vcc);
 	skb_queue_tail(&sk->sk_receive_queue, skb);
 	sk->sk_data_ready(sk);
-	return 0;
+unlock:
+	rcu_read_unlock();
+	return err;
 }
 
 static void link_vcc(struct clip_vcc *clip_vcc, struct atmarp_entry *entry)
@@ -418,6 +430,8 @@ static int clip_mkip(struct atm_vcc *vcc, int timeout)
 
 	if (!vcc->push)
 		return -EBADFD;
+	if (vcc->user_back)
+		return -EINVAL;
 	clip_vcc = kmalloc(sizeof(struct clip_vcc), GFP_KERNEL);
 	if (!clip_vcc)
 		return -ENOMEM;
@@ -608,17 +622,27 @@ static void atmarpd_close(struct atm_vcc *vcc)
 {
 	pr_debug("\n");
 
-	rtnl_lock();
-	atmarpd = NULL;
+	mutex_lock(&atmarpd_lock);
+	RCU_INIT_POINTER(atmarpd, NULL);
+	mutex_unlock(&atmarpd_lock);
+
+	synchronize_rcu();
 	skb_queue_purge(&sk_atm(vcc)->sk_receive_queue);
-	rtnl_unlock();
 
 	pr_debug("(done)\n");
 	module_put(THIS_MODULE);
 }
 
+static int atmarpd_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	atm_return_tx(vcc, skb);
+	dev_kfree_skb_any(skb);
+	return 0;
+}
+
 static const struct atmdev_ops atmarpd_dev_ops = {
-	.close = atmarpd_close
+	.close = atmarpd_close,
+	.send = atmarpd_send
 };
 
 
@@ -632,15 +656,18 @@ static struct atm_dev atmarpd_dev = {
 
 static int atm_init_atmarp(struct atm_vcc *vcc)
 {
-	rtnl_lock();
+	if (vcc->push == clip_push)
+		return -EINVAL;
+
+	mutex_lock(&atmarpd_lock);
 	if (atmarpd) {
-		rtnl_unlock();
+		mutex_unlock(&atmarpd_lock);
 		return -EADDRINUSE;
 	}
 
 	mod_timer(&idle_timer, jiffies + CLIP_CHECK_INTERVAL * HZ);
 
-	atmarpd = vcc;
+	rcu_assign_pointer(atmarpd, vcc);
 	set_bit(ATM_VF_META, &vcc->flags);
 	set_bit(ATM_VF_READY, &vcc->flags);
 	    /* allow replies and avoid getting closed if signaling dies */
@@ -649,13 +676,14 @@ static int atm_init_atmarp(struct atm_vcc *vcc)
 	vcc->push = NULL;
 	vcc->pop = NULL; /* crash */
 	vcc->push_oam = NULL; /* crash */
-	rtnl_unlock();
+	mutex_unlock(&atmarpd_lock);
 	return 0;
 }
 
 static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct atm_vcc *vcc = ATM_SD(sock);
+	struct sock *sk = sock->sk;
 	int err = 0;
 
 	switch (cmd) {
@@ -676,14 +704,18 @@ static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		err = clip_create(arg);
 		break;
 	case ATMARPD_CTRL:
+		lock_sock(sk);
 		err = atm_init_atmarp(vcc);
 		if (!err) {
 			sock->state = SS_CONNECTED;
 			__module_get(THIS_MODULE);
 		}
+		release_sock(sk);
 		break;
 	case ATMARP_MKIP:
+		lock_sock(sk);
 		err = clip_mkip(vcc, arg);
+		release_sock(sk);
 		break;
 	case ATMARP_SETENTRY:
 		err = clip_setentry(vcc, (__force __be32)arg);
diff --git a/net/atm/resources.c b/net/atm/resources.c
index 04b2235c5c26..e244c2576d1e 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -148,11 +148,10 @@ void atm_dev_deregister(struct atm_dev *dev)
 	 */
 	mutex_lock(&atm_dev_mutex);
 	list_del(&dev->dev_list);
-	mutex_unlock(&atm_dev_mutex);
-
 	atm_dev_release_vccs(dev);
 	atm_unregister_sysfs(dev);
 	atm_proc_dev_deregister(dev);
+	mutex_unlock(&atm_dev_mutex);
 
 	atm_dev_put(dev);
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index dc9edf8fc336..4939152f6adc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3373,7 +3373,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
 	u8 remote_efs = 0;
-	u16 mtu = L2CAP_DEFAULT_MTU;
+	u16 mtu = 0;
 	u16 result = L2CAP_CONF_SUCCESS;
 	u16 size;
 
@@ -3484,6 +3484,13 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
 
+		/* If MTU is not provided in configure request, use the most recently
+		 * explicitly or implicitly accepted value for the other direction,
+		 * or the default value.
+		 */
+		if (mtu == 0)
+			mtu = chan->imtu ? chan->imtu : L2CAP_DEFAULT_MTU;
+
 		if (mtu < L2CAP_DEFAULT_MIN_MTU)
 			result = L2CAP_CONF_UNACCEPT;
 		else {
diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index aa945ab5b655..05930c2fafd5 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -5,14 +5,15 @@
 
 hostprogs-y := bpfilter_umh
 bpfilter_umh-objs := main.o
-KBUILD_HOSTCFLAGS += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi
+KBUILD_HOSTCFLAGS += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
+			$(filter -m32 -m64, $(KBUILD_CFLAGS))
 HOSTCC := $(CC)
 
 ifeq ($(CONFIG_BPFILTER_UMH), y)
 # builtin bpfilter_umh should be compiled with -static
 # since rootfs isn't mounted at the time of __init
 # function is called and do_execv won't find elf interpreter
-KBUILD_HOSTLDFLAGS += -static
+KBUILD_HOSTLDFLAGS += -static $(filter -m32 -m64, $(KBUILD_CFLAGS))
 endif
 
 $(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b321cec71127..93bae134e730 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2765,7 +2765,8 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 	if (confirm_neigh)
 		dst_confirm_neigh(dst, daddr);
 
-	mtu = max_t(u32, mtu, IPV6_MIN_MTU);
+	if (mtu < IPV6_MIN_MTU)
+		return;
 	if (mtu >= dst_mtu(dst))
 		return;
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 99d5f8b58e92..4c805530edfb 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3982,6 +3982,10 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		if (!multicast &&
 		    !ether_addr_equal(sdata->dev->dev_addr, hdr->addr1))
 			return false;
+		/* reject invalid/our STA address */
+		if (!is_valid_ether_addr(hdr->addr2) ||
+		    ether_addr_equal(sdata->dev->dev_addr, hdr->addr2))
+			return false;
 		if (!rx->sta) {
 			int rate_idx;
 			if (status->encoding != RX_ENC_LEGACY)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 515fe1d539b4..415cd7f50815 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3807,7 +3807,7 @@ void ieee80211_recalc_dtim(struct ieee80211_local *local,
 {
 	u64 tsf = drv_get_tsf(local, sdata);
 	u64 dtim_count = 0;
-	u16 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
+	u32 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
 	u8 dtim_period = sdata->vif.bss_conf.dtim_period;
 	struct ps_data *ps;
 	u8 bcns_from_dtim;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 17d86eee8bd8..808ca542bfba 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -378,7 +378,6 @@ static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 	WARN_ON(skb->sk != NULL);
 	skb->sk = sk;
 	skb->destructor = netlink_skb_destructor;
-	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 	sk_mem_charge(sk, skb->truesize);
 }
 
@@ -1206,41 +1205,48 @@ static struct sk_buff *netlink_alloc_large_skb(unsigned int size,
 int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 		      long *timeo, struct sock *ssk)
 {
+	DECLARE_WAITQUEUE(wait, current);
 	struct netlink_sock *nlk;
+	unsigned int rmem;
 
 	nlk = nlk_sk(sk);
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 
-	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
-		DECLARE_WAITQUEUE(wait, current);
-		if (!*timeo) {
-			if (!ssk || netlink_is_kernel(ssk))
-				netlink_overrun(sk);
-			sock_put(sk);
-			kfree_skb(skb);
-			return -EAGAIN;
-		}
-
-		__set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&nlk->wait, &wait);
+	if ((rmem == skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)) &&
+	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
+		netlink_skb_set_owner_r(skb, sk);
+		return 0;
+	}
 
-		if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-		     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
-		    !sock_flag(sk, SOCK_DEAD))
-			*timeo = schedule_timeout(*timeo);
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 
-		__set_current_state(TASK_RUNNING);
-		remove_wait_queue(&nlk->wait, &wait);
+	if (!*timeo) {
+		if (!ssk || netlink_is_kernel(ssk))
+			netlink_overrun(sk);
 		sock_put(sk);
+		kfree_skb(skb);
+		return -EAGAIN;
+	}
 
-		if (signal_pending(current)) {
-			kfree_skb(skb);
-			return sock_intr_errno(*timeo);
-		}
-		return 1;
+	__set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue(&nlk->wait, &wait);
+	rmem = atomic_read(&sk->sk_rmem_alloc);
+
+	if (((rmem && rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf)) ||
+	     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
+	    !sock_flag(sk, SOCK_DEAD))
+		*timeo = schedule_timeout(*timeo);
+
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&nlk->wait, &wait);
+	sock_put(sk);
+
+	if (signal_pending(current)) {
+		kfree_skb(skb);
+		return sock_intr_errno(*timeo);
 	}
-	netlink_skb_set_owner_r(skb, sk);
-	return 0;
+
+	return 1;
 }
 
 static int __netlink_sendskb(struct sock *sk, struct sk_buff *skb)
@@ -1300,6 +1306,7 @@ static int netlink_unicast_kernel(struct sock *sk, struct sk_buff *skb,
 	ret = -ECONNREFUSED;
 	if (nlk->netlink_rcv != NULL) {
 		ret = skb->len;
+		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 		netlink_skb_set_owner_r(skb, sk);
 		NETLINK_CB(skb).sk = ssk;
 		netlink_deliver_tap_kernel(sk, ssk, skb);
@@ -1378,13 +1385,19 @@ EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 static int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
+	unsigned int rmem, rcvbuf;
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+
+	if ((rmem == skb->truesize || rmem <= rcvbuf) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		__netlink_sendskb(sk, skb);
-		return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
+		return rmem > (rcvbuf >> 1);
 	}
+
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 	return -1;
 }
 
@@ -2173,6 +2186,7 @@ static int netlink_dump(struct sock *sk)
 	struct netlink_ext_ack extack = {};
 	struct netlink_callback *cb;
 	struct sk_buff *skb = NULL;
+	unsigned int rmem, rcvbuf;
 	struct nlmsghdr *nlh;
 	struct module *module;
 	int err = -ENOBUFS;
@@ -2185,9 +2199,6 @@ static int netlink_dump(struct sock *sk)
 		goto errout_skb;
 	}
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
-		goto errout_skb;
-
 	/* NLMSG_GOODSIZE is small to avoid high order allocations being
 	 * required, but it makes sense to _attempt_ a 16K bytes allocation
 	 * to reduce number of system calls on dump operations, if user
@@ -2209,6 +2220,13 @@ static int netlink_dump(struct sock *sk)
 	if (!skb)
 		goto errout_skb;
 
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	if (rmem != skb->truesize && rmem >= rcvbuf) {
+		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+		goto errout_skb;
+	}
+
 	/* Trim skb to allocated size. User is expected to provide buffer as
 	 * large as max(min_dump_alloc, 16KiB (mac_recvmsg_len capped at
 	 * netlink_recvmsg())). dump will pack as many smaller messages as
diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index 64d441d3b653..91855d11ad15 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -347,6 +347,7 @@ static int rose_del_node(struct rose_route_struct *rose_route,
 				case 1:
 					rose_node->neighbour[1] =
 						rose_node->neighbour[2];
+					break;
 				case 2:
 					break;
 				}
@@ -496,21 +497,15 @@ void rose_rt_device_down(struct net_device *dev)
 			t         = rose_node;
 			rose_node = rose_node->next;
 
-			for (i = 0; i < t->count; i++) {
+			for (i = t->count - 1; i >= 0; i--) {
 				if (t->neighbour[i] != s)
 					continue;
 
 				t->count--;
 
-				switch (i) {
-				case 0:
-					t->neighbour[0] = t->neighbour[1];
-					/* fall through */
-				case 1:
-					t->neighbour[1] = t->neighbour[2];
-				case 2:
-					break;
-				}
+				memmove(&t->neighbour[i], &t->neighbour[i + 1],
+					sizeof(t->neighbour[0]) *
+						(t->count - i));
 			}
 
 			if (t->count <= 0)
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 55fb3744552d..99f05057e4c9 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -281,6 +281,9 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
 	unsigned short call_tail, conn_tail, peer_tail;
 	unsigned short call_count, conn_count;
 
+	if (!b)
+		return NULL;
+
 	/* #calls >= #conns >= #peers must hold true. */
 	call_head = smp_load_acquire(&b->call_backlog_head);
 	call_tail = b->call_backlog_tail;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 60c8b81a22dc..7c91f29f69c1 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -328,17 +328,22 @@ struct Qdisc *qdisc_lookup_rcu(struct net_device *dev, u32 handle)
 	return q;
 }
 
-static struct Qdisc *qdisc_leaf(struct Qdisc *p, u32 classid)
+static struct Qdisc *qdisc_leaf(struct Qdisc *p, u32 classid,
+				struct netlink_ext_ack *extack)
 {
 	unsigned long cl;
 	const struct Qdisc_class_ops *cops = p->ops->cl_ops;
 
-	if (cops == NULL)
-		return NULL;
+	if (cops == NULL) {
+		NL_SET_ERR_MSG(extack, "Parent qdisc is not classful");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
 	cl = cops->find(p, classid);
 
-	if (cl == 0)
-		return NULL;
+	if (cl == 0) {
+		NL_SET_ERR_MSG(extack, "Specified class not found");
+		return ERR_PTR(-ENOENT);
+	}
 	return cops->leaf(p, cl);
 }
 
@@ -758,15 +763,12 @@ static u32 qdisc_alloc_handle(struct net_device *dev)
 
 void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 {
-	bool qdisc_is_offloaded = sch->flags & TCQ_F_OFFLOADED;
 	const struct Qdisc_class_ops *cops;
 	unsigned long cl;
 	u32 parentid;
 	bool notify;
 	int drops;
 
-	if (n == 0 && len == 0)
-		return;
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
@@ -775,17 +777,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 
 		if (sch->flags & TCQ_F_NOPARENT)
 			break;
-		/* Notify parent qdisc only if child qdisc becomes empty.
-		 *
-		 * If child was empty even before update then backlog
-		 * counter is screwed and we skip notification because
-		 * parent class is already passive.
-		 *
-		 * If the original child was offloaded then it is allowed
-		 * to be seem as empty, so the parent is notified anyway.
-		 */
-		notify = !sch->q.qlen && !WARN_ON_ONCE(!n &&
-						       !qdisc_is_offloaded);
+		/* Notify parent qdisc only if child qdisc becomes empty. */
+		notify = !sch->q.qlen;
 		/* TODO: perform the search on a per txq basis */
 		sch = qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid));
 		if (sch == NULL) {
@@ -794,6 +787,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 		}
 		cops = sch->ops->cl_ops;
 		if (notify && cops->qlen_notify) {
+			/* Note that qlen_notify must be idempotent as it may get called
+			 * multiple times.
+			 */
 			cl = cops->find(sch, parentid);
 			cops->qlen_notify(sch, cl);
 		}
@@ -1461,7 +1457,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Failed to find qdisc with specified classid");
 					return -ENOENT;
 				}
-				q = qdisc_leaf(p, clid);
+				q = qdisc_leaf(p, clid, extack);
 			} else if (dev_ingress_queue(dev)) {
 				q = dev_ingress_queue(dev)->qdisc_sleeping;
 			}
@@ -1472,6 +1468,8 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			NL_SET_ERR_MSG(extack, "Cannot find specified qdisc on specified device");
 			return -ENOENT;
 		}
+		if (IS_ERR(q))
+			return PTR_ERR(q);
 
 		if (tcm->tcm_handle && q->handle != tcm->tcm_handle) {
 			NL_SET_ERR_MSG(extack, "Invalid handle");
@@ -1568,7 +1566,9 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Failed to find specified qdisc");
 					return -ENOENT;
 				}
-				q = qdisc_leaf(p, clid);
+				q = qdisc_leaf(p, clid, extack);
+				if (IS_ERR(q))
+					return PTR_ERR(q);
 			} else if (dev_ingress_queue_create(dev)) {
 				q = dev_ingress_queue(dev)->qdisc_sleeping;
 			}
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 88e8e8d69b60..820bed3b9cc5 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -699,8 +699,10 @@ static void tipc_topsrv_stop(struct net *net)
 	for (id = 0; srv->idr_in_use; id++) {
 		con = idr_find(&srv->conn_idr, id);
 		if (con) {
+			conn_get(con);
 			spin_unlock_bh(&srv->idr_lock);
 			tipc_conn_close(con);
+			conn_put(con);
 			spin_lock_bh(&srv->idr_lock);
 		}
 	}
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 85488e19dffc..7d54aaf49f20 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -125,6 +125,8 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
 			   u16 proto,
 			   struct vmci_handle handle)
 {
+	memset(pkt, 0, sizeof(*pkt));
+
 	/* We register the stream control handler as an any cid handle so we
 	 * must always send from a source address of VMADDR_CID_ANY
 	 */
@@ -137,8 +139,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
 	pkt->type = type;
 	pkt->src_port = src->svm_port;
 	pkt->dst_port = dst->svm_port;
-	memset(&pkt->proto, 0, sizeof(pkt->proto));
-	memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));
 
 	switch (pkt->type) {
 	case VMCI_TRANSPORT_PACKET_TYPE_INVALID:
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 5d247d8f1e04..82eb69f07b35 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -16,7 +16,7 @@ pound := \#
 dot-target = $(dir $@).$(notdir $@)
 
 ###
-# The temporary file to save gcc -MD generated dependencies must not
+# The temporary file to save gcc -MMD generated dependencies must not
 # contain a comma
 depfile = $(subst $(comma),_,$(dot-target).d)
 
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 4c51c95d40f4..a0a4af508f15 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -92,8 +92,8 @@ _hostcxx_flags += -I $(objtree)/$(obj)
 endif
 endif
 
-hostc_flags    = -Wp,-MD,$(depfile) $(_hostc_flags)
-hostcxx_flags  = -Wp,-MD,$(depfile) $(_hostcxx_flags)
+hostc_flags    = -Wp,-MMD,$(depfile) $(_hostc_flags)
+hostcxx_flags  = -Wp,-MMD,$(depfile) $(_hostcxx_flags)
 
 #####
 # Compile programs on the host
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index a6d0044328b1..9339fadb6a16 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -160,22 +160,22 @@ modkern_aflags = $(if $(part-of-module),				\
 			$(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE),	\
 			$(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL))
 
-c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
+c_flags        = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 -include $(srctree)/include/linux/compiler_types.h       \
 		 $(_c_flags) $(modkern_cflags)                           \
 		 $(basename_flags) $(modname_flags)
 
-a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
+a_flags        = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(_a_flags) $(modkern_aflags)
 
-cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
+cpp_flags      = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(_cpp_flags)
 
 ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 
 DTC_INCLUDE    := $(srctree)/scripts/dtc/include-prefixes
 
-dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
+dtc_cpp_flags  = -Wp,-MMD,$(depfile).pre.tmp -nostdinc                    \
 		 $(addprefix -I,$(DTC_INCLUDE))                          \
 		 -undef -D__DTS__
 
diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 679f9f48370f..b69bc83c103c 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -722,6 +722,10 @@ static int snd_sb16_dma_control_put(struct snd_kcontrol *kcontrol, struct snd_ct
 	change = nval != oval;
 	snd_sb16_set_dma_mode(chip, nval);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	if (change) {
+		snd_dma_disable(chip->dma8);
+		snd_dma_disable(chip->dma16);
+	}
 	return change;
 }
 
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 17a25e453f60..047fe6cca7f1 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -44,7 +44,7 @@ static void hda_codec_unsol_event(struct hdac_device *dev, unsigned int ev)
 	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
 
 	/* ignore unsol events during shutdown */
-	if (codec->bus->shutdown)
+	if (codec->card->shutdown || codec->bus->shutdown)
 		return;
 
 	/* ignore unsol events during system suspend/resume */
diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index a70d244ef88b..f66a0c38c303 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -244,7 +244,7 @@ static int meson_card_parse_of_optional(struct snd_soc_card *card,
 						    const char *p))
 {
 	/* If property is not provided, don't fail ... */
-	if (!of_property_read_bool(card->dev->of_node, propname))
+	if (!of_property_present(card->dev->of_node, propname))
 		return 0;
 
 	/* ... but do fail if it is provided and the parsing fails */
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 1c4ff5799324..d698b609fe52 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -979,6 +979,8 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	 * and request Cluster Descriptor
 	 */
 	wLength = le16_to_cpu(hc_header.wLength);
+	if (wLength < sizeof(cluster))
+		return NULL;
 	cluster = kzalloc(wLength, GFP_KERNEL);
 	if (!cluster)
 		return ERR_PTR(-ENOMEM);
diff --git a/usr/include/Makefile b/usr/include/Makefile
index e2840579156a..293cccc01387 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -8,7 +8,11 @@
 # We cannot go as far as adding -Wpedantic since it emits too many warnings.
 UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
 
-override c_flags = $(UAPI_CFLAGS) -Wp,-MD,$(depfile) -I$(objtree)/usr/include
+# In theory, we do not care -m32 or -m64 for header compile tests.
+# It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
+UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
+
+override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
 
 # The following are excluded for now because they fail to build.
 #

