Return-Path: <stable+bounces-73034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CC296BB05
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F340128A0C4
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C0A1D04BC;
	Wed,  4 Sep 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jfem6kl+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B31D04AB;
	Wed,  4 Sep 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450111; cv=none; b=fYAivEil/3d5yK4mffIPknK7LdPh0Kx/r9kdIdN5/VGHk8+Hq0vKvjwv+jogeBfH0SU/reXp1NudZ6oRDDdcQh2Ukce39pUxv9SB+AGZtgLp+DdxMquJs3SKKUGMOTg3DApcta3rZGB+9N+OlP4uySkmrjNA7RTf4tOknGQd/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450111; c=relaxed/simple;
	bh=kzmnomofKv8ZNyuT3dAaI5kzqtidadDVy3ywWZ2U3Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSH3vEbEuLi1XViN5gJVEmX8z7/fUBljT9PoeXeGQ5v9H9hPY5LjvpWezNWNDCf6XWznds+np3NEWqU3fK5hDZYgdsH6CML3PL6S58DTA4t7KJdxR6nuGsDeN3dVKgLJiSIolTl6n6lPtGvRiy3W+QyhbWeYxsEITva7Mk9eahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jfem6kl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F806C4CEC2;
	Wed,  4 Sep 2024 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725450111;
	bh=kzmnomofKv8ZNyuT3dAaI5kzqtidadDVy3ywWZ2U3Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfem6kl+HQLtXUetCsXzgIV97EDQ6HGwCurlZdUk0Up2969oQSjb1v5KFCQsLlsso
	 tkT7MeMFlBhDlsaAA4IALnO2Cuf19BKAqRIDiukdu+PeL1cOqGxxKUqqb3JcFMwzd4
	 c0Xo/0NlJoaeFuzjLRpYVfb8FTZF0YH1WMRKm4+s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.225
Date: Wed,  4 Sep 2024 13:41:40 +0200
Message-ID: <2024090440-trickster-unearned-b7f6@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024090440-dingbat-unquote-b842@gregkh>
References: <2024090440-dingbat-unquote-b842@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 38351794f6c9..30918576f9de 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 224
+SUBLEVEL = 225
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 7ff800045434..048b75cadd2f 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -27,7 +27,7 @@
 
 #include <asm/numa.h>
 
-static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
+static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
 
 int __init acpi_numa_get_nid(unsigned int cpu)
 {
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 0c66a1d408fd..e831d3dfd50d 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -85,8 +85,10 @@ SYM_INNER_LABEL(__guest_exit_panic, SYM_L_GLOBAL)
 
 	// If the hyp context is loaded, go straight to hyp_panic
 	get_loaded_vcpu x0, x1
-	cbz	x0, hyp_panic
+	cbnz	x0, 1f
+	b	hyp_panic
 
+1:
 	// The hyp context is saved so make sure it is restored to allow
 	// hyp_panic to run at hyp and, subsequently, panic to run in the host.
 	// This makes use of __guest_exit to avoid duplication but sets the
@@ -94,7 +96,7 @@ SYM_INNER_LABEL(__guest_exit_panic, SYM_L_GLOBAL)
 	// current state is saved to the guest context but it will only be
 	// accurate if the guest had been completely restored.
 	adr_this_cpu x0, kvm_hyp_ctxt, x1
-	adr	x1, hyp_panic
+	adr_l	x1, hyp_panic
 	str	x1, [x0, #CPU_XREG_OFFSET(30)]
 
 	get_vcpu_ptr	x1, x0
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 835fa036b2d5..b4bdabbfafdd 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -30,6 +30,7 @@
 #include <trace/events/kvm.h>
 
 #include "sys_regs.h"
+#include "vgic/vgic.h"
 
 #include "trace.h"
 
@@ -275,6 +276,11 @@ static bool access_gic_sgi(struct kvm_vcpu *vcpu,
 {
 	bool g1;
 
+	if (!kvm_has_gicv3(vcpu->kvm)) {
+		kvm_inject_undefined(vcpu);
+		return false;
+	}
+
 	if (!p->is_write)
 		return read_from_write_only(vcpu, p, r);
 
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 64fcd7511110..3d7fa7ef353e 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -318,4 +318,11 @@ int vgic_v4_init(struct kvm *kvm);
 void vgic_v4_teardown(struct kvm *kvm);
 void vgic_v4_configure_vsgis(struct kvm *kvm);
 
+static inline bool kvm_has_gicv3(struct kvm *kvm)
+{
+	return (static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif) &&
+		irqchip_in_kernel(kvm) &&
+		kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3);
+}
+
 #endif
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index f8d1933bfe82..24d2ab277d78 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1769,12 +1769,16 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		c->ases |= (MIPS_ASE_LOONGSON_MMI | MIPS_ASE_LOONGSON_CAM |
 			MIPS_ASE_LOONGSON_EXT | MIPS_ASE_LOONGSON_EXT2);
 		c->ases &= ~MIPS_ASE_VZ; /* VZ of Loongson-3A2000/3000 is incomplete */
+		change_c0_config6(LOONGSON_CONF6_EXTIMER | LOONGSON_CONF6_INTIMER,
+				  LOONGSON_CONF6_INTIMER);
 		break;
 	case PRID_IMP_LOONGSON_64G:
 		__cpu_name[cpu] = "ICT Loongson-3";
 		set_elf_platform(cpu, "loongson3a");
 		set_isa(c, MIPS_CPU_ISA_M64R2);
 		decode_cpucfg(c);
+		change_c0_config6(LOONGSON_CONF6_EXTIMER | LOONGSON_CONF6_INTIMER,
+				  LOONGSON_CONF6_INTIMER);
 		break;
 	default:
 		panic("Unknown Loongson Processor ID!");
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index c6f9e7b9f7cb..8c65810eeca2 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -284,6 +284,9 @@ void calibrate_delay(void)
 
 void __init setup_arch(char **cmdline_p)
 {
+	/* setup memblock allocator */
+	setup_memory();
+
 	unflatten_and_copy_device_tree();
 
 	setup_cpuinfo();
@@ -310,9 +313,6 @@ void __init setup_arch(char **cmdline_p)
 	}
 #endif
 
-	/* setup memblock allocator */
-	setup_memory();
-
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
 
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 2762e8540672..5e3b9be45de9 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -520,7 +520,7 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 
 	old_regs = set_irq_regs(regs);
 	local_irq_disable();
-	irq_enter();
+	irq_enter_rcu();
 
 	eirr_val = mfctl(23) & cpu_eiem & per_cpu(local_ack_eiem, cpu);
 	if (!eirr_val)
@@ -555,7 +555,7 @@ void do_cpu_irq_mask(struct pt_regs *regs)
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
index 7d13d2ef5a90..66de291b27d0 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -235,6 +235,8 @@ static int __init icp_native_map_one_cpu(int hw_id, unsigned long addr,
 	rname = kasprintf(GFP_KERNEL, "CPU %d [0x%x] Interrupt Presentation",
 			  cpu, hw_id);
 
+	if (!rname)
+		return -ENOMEM;
 	if (!request_mem_region(addr, size, rname)) {
 		pr_warn("icp_native: Could not reserve ICP MMIO for CPU %d, interrupt server #0x%x\n",
 			cpu, hw_id);
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 12c5f006c136..8fd441150a4e 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -312,7 +312,10 @@ static inline int share(unsigned long addr, u16 cmd)
 
 	if (!uv_call(0, (u64)&uvcb))
 		return 0;
-	return -EINVAL;
+	pr_err("%s UVC failed (rc: 0x%x, rrc: 0x%x), possible hypervisor bug.\n",
+	       uvcb.header.cmd == UVC_CMD_SET_SHARED_ACCESS ? "Share" : "Unshare",
+	       uvcb.header.rc, uvcb.header.rrc);
+	panic("System security cannot be guaranteed unless the system panics now.\n");
 }
 
 /*
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 985e1e755333..bac1be43d36c 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -252,15 +252,9 @@ static inline void save_vector_registers(void)
 #endif
 }
 
-static inline void setup_control_registers(void)
+static inline void setup_low_address_protection(void)
 {
-	unsigned long reg;
-
-	__ctl_store(reg, 0, 0);
-	reg |= CR0_LOW_ADDRESS_PROTECTION;
-	reg |= CR0_EMERGENCY_SIGNAL_SUBMASK;
-	reg |= CR0_EXTERNAL_CALL_SUBMASK;
-	__ctl_load(reg, 0, 0);
+	__ctl_set_bit(0, 28);
 }
 
 static inline void setup_access_registers(void)
@@ -313,7 +307,7 @@ void __init startup_init(void)
 	save_vector_registers();
 	setup_topology();
 	sclp_early_detect();
-	setup_control_registers();
+	setup_low_address_protection();
 	setup_access_registers();
 	lockdep_on();
 }
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 5674792726cd..2e0c3b0a5a58 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -982,12 +982,12 @@ void __init smp_fill_possible_mask(void)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	/* request the 0x1201 emergency signal external interrupt */
 	if (register_external_irq(EXT_IRQ_EMERGENCY_SIG, do_ext_call_interrupt))
 		panic("Couldn't request external interrupt 0x1201");
-	/* request the 0x1202 external call external interrupt */
+	ctl_set_bit(0, 14);
 	if (register_external_irq(EXT_IRQ_EXTERNAL_CALL, do_ext_call_interrupt))
 		panic("Couldn't request external interrupt 0x1202");
+	ctl_set_bit(0, 13);
 }
 
 void __init smp_prepare_boot_cpu(void)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1cba09a9f1c1..4f731981d326 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -926,7 +926,10 @@ unsigned long arch_align_stack(unsigned long sp)
 
 unsigned long arch_randomize_brk(struct mm_struct *mm)
 {
-	return randomize_page(mm->brk, 0x02000000);
+	if (mmap_is_ia32())
+		return randomize_page(mm->brk, SZ_32M);
+
+	return randomize_page(mm->brk, SZ_1G);
 }
 
 /*
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3717ed6fcccc..467fc8002c44 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5366,6 +5366,9 @@ static void ata_host_release(struct kref *kref)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
+		if (!ap)
+			continue;
+
 		kfree(ap->pmp_link);
 		kfree(ap->slave_link);
 		kfree(ap);
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index e616e33c8a20..25fd73fafb37 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -1118,8 +1118,8 @@ dequeue_rx(struct idt77252_dev *card, struct rsq_entry *rsqe)
 	rpp->len += skb->len;
 
 	if (stat & SAR_RSQE_EPDU) {
+		unsigned int len, truesize;
 		unsigned char *l1l2;
-		unsigned int len;
 
 		l1l2 = (unsigned char *) ((unsigned long) skb->data + skb->len - 6);
 
@@ -1189,14 +1189,15 @@ dequeue_rx(struct idt77252_dev *card, struct rsq_entry *rsqe)
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
index 726d5c83c550..e7d78937f7d6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -768,7 +768,8 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 		break;
 
 	case HCIUARTGETPROTO:
-		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+		if (test_bit(HCI_UART_PROTO_SET, &hu->flags) &&
+		    test_bit(HCI_UART_PROTO_READY, &hu->flags))
 			err = hu->proto->id;
 		else
 			err = -EUNATCH;
diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 7ab83fe601ed..0beafcee7267 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -624,12 +625,10 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct dw_desc		*prev;
 	struct dw_desc		*first;
 	u32			ctllo, ctlhi;
-	u8			m_master = dwc->dws.m_master;
-	u8			lms = DWC_LLP_LMS(m_master);
+	u8			lms = DWC_LLP_LMS(dwc->dws.m_master);
 	dma_addr_t		reg;
 	unsigned int		reg_width;
 	unsigned int		mem_width;
-	unsigned int		data_width = dw->pdata->data_width[m_master];
 	unsigned int		i;
 	struct scatterlist	*sg;
 	size_t			total_len = 0;
@@ -663,7 +662,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			mem = sg_dma_address(sg);
 			len = sg_dma_len(sg);
 
-			mem_width = __ffs(data_width | mem | len);
+			mem_width = __ffs(sconfig->src_addr_width | mem | len);
 
 slave_sg_todev_fill_desc:
 			desc = dwc_desc_get(dwc);
@@ -723,7 +722,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			lli_write(desc, sar, reg);
 			lli_write(desc, dar, mem);
 			lli_write(desc, ctlhi, ctlhi);
-			mem_width = __ffs(data_width | mem);
+			mem_width = __ffs(sconfig->dst_addr_width | mem);
 			lli_write(desc, ctllo, ctllo | DWC_CTLL_DST_WIDTH(mem_width));
 			desc->len = dlen;
 
@@ -783,17 +782,93 @@ bool dw_dma_filter(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL_GPL(dw_dma_filter);
 
+static int dwc_verify_p_buswidth(struct dma_chan *chan)
+{
+	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
+	struct dw_dma *dw = to_dw_dma(chan->device);
+	u32 reg_width, max_width;
+
+	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV)
+		reg_width = dwc->dma_sconfig.dst_addr_width;
+	else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM)
+		reg_width = dwc->dma_sconfig.src_addr_width;
+	else /* DMA_MEM_TO_MEM */
+		return 0;
+
+	max_width = dw->pdata->data_width[dwc->dws.p_master];
+
+	/* Fall-back to 1-byte transfer width if undefined */
+	if (reg_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		reg_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	else if (!is_power_of_2(reg_width) || reg_width > max_width)
+		return -EINVAL;
+	else /* bus width is valid */
+		return 0;
+
+	/* Update undefined addr width value */
+	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV)
+		dwc->dma_sconfig.dst_addr_width = reg_width;
+	else /* DMA_DEV_TO_MEM */
+		dwc->dma_sconfig.src_addr_width = reg_width;
+
+	return 0;
+}
+
+static int dwc_verify_m_buswidth(struct dma_chan *chan)
+{
+	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
+	struct dw_dma *dw = to_dw_dma(chan->device);
+	u32 reg_width, reg_burst, mem_width;
+
+	mem_width = dw->pdata->data_width[dwc->dws.m_master];
+
+	/*
+	 * It's possible to have a data portion locked in the DMA FIFO in case
+	 * of the channel suspension. Subsequent channel disabling will cause
+	 * that data silent loss. In order to prevent that maintain the src and
+	 * dst transfer widths coherency by means of the relation:
+	 * (CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE >= CTLx.DST_TR_WIDTH)
+	 * Look for the details in the commit message that brings this change.
+	 *
+	 * Note the DMA configs utilized in the calculations below must have
+	 * been verified to have correct values by this method call.
+	 */
+	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV) {
+		reg_width = dwc->dma_sconfig.dst_addr_width;
+		if (mem_width < reg_width)
+			return -EINVAL;
+
+		dwc->dma_sconfig.src_addr_width = mem_width;
+	} else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM) {
+		reg_width = dwc->dma_sconfig.src_addr_width;
+		reg_burst = rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
+
+		dwc->dma_sconfig.dst_addr_width = min(mem_width, reg_width * reg_burst);
+	}
+
+	return 0;
+}
+
 static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 {
 	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
 	struct dw_dma *dw = to_dw_dma(chan->device);
+	int ret;
 
 	memcpy(&dwc->dma_sconfig, sconfig, sizeof(*sconfig));
 
 	dwc->dma_sconfig.src_maxburst =
-		clamp(dwc->dma_sconfig.src_maxburst, 0U, dwc->max_burst);
+		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
 	dwc->dma_sconfig.dst_maxburst =
-		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
+		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);
+
+	ret = dwc_verify_p_buswidth(chan);
+	if (ret)
+		return ret;
+
+	ret = dwc_verify_m_buswidth(chan);
+	if (ret)
+		return ret;
 
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.src_maxburst);
 	dw->encode_maxburst(dwc, &dwc->dma_sconfig.dst_maxburst);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 2c1c5f7f98de..48817d2cda89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -386,16 +386,24 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 
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
index ecaa2d7483b2..0a28daa14fb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -725,7 +725,8 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 	uint32_t created = 0;
 	uint32_t allocated = 0;
 	uint32_t tmp, handle = 0;
-	uint32_t *size = &tmp;
+	uint32_t dummy = 0xffffffff;
+	uint32_t *size = &dummy;
 	unsigned idx;
 	int i, r = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index ae8c0f897d59..24dd4df55cb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -553,11 +553,11 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring,	PACKETJ(mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 799a91a064a1..9a444b17530a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1311,7 +1311,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			goto err_unlock;
 		}
 		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
@@ -1969,6 +1969,9 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+	if (PAGE_SIZE > 4096)
+		return -EINVAL;
+
 	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
 
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index ca3842f71984..82071835ec9e 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -166,6 +166,11 @@ static void lima_gp_task_run(struct lima_sched_pipe *pipe,
 	gp_write(LIMA_GP_CMD, cmd);
 }
 
+static int lima_gp_bus_stop_poll(struct lima_ip *ip)
+{
+	return !!(gp_read(LIMA_GP_STATUS) & LIMA_GP_STATUS_BUS_STOPPED);
+}
+
 static int lima_gp_hard_reset_poll(struct lima_ip *ip)
 {
 	gp_write(LIMA_GP_PERF_CNT_0_LIMIT, 0xC01A0000);
@@ -179,6 +184,13 @@ static int lima_gp_hard_reset(struct lima_ip *ip)
 
 	gp_write(LIMA_GP_PERF_CNT_0_LIMIT, 0xC0FFE000);
 	gp_write(LIMA_GP_INT_MASK, 0);
+
+	gp_write(LIMA_GP_CMD, LIMA_GP_CMD_STOP_BUS);
+	ret = lima_poll_timeout(ip, lima_gp_bus_stop_poll, 10, 100);
+	if (ret) {
+		dev_err(dev->dev, "%s bus stop timeout\n", lima_ip_name(ip));
+		return ret;
+	}
 	gp_write(LIMA_GP_CMD, LIMA_GP_CMD_RESET);
 	ret = lima_poll_timeout(ip, lima_gp_hard_reset_poll, 10, 100);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index bb7c7e437242..31a5646f5493 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -32,24 +32,14 @@
  * @fmt: Pointer to format string
  */
 #define DPU_DEBUG(fmt, ...)                                                \
-	do {                                                               \
-		if (drm_debug_enabled(DRM_UT_KMS))                         \
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
-		if (drm_debug_enabled(DRM_UT_DRIVER))                      \
-			DRM_ERROR(fmt, ##__VA_ARGS__); \
-		else                                                       \
-			pr_debug(fmt, ##__VA_ARGS__);                      \
-	} while (0)
+	DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
 
 #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
 #define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error]" fmt, ##__VA_ARGS__)
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 07becbf3c64f..0b0d86d2121b 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1246,6 +1246,8 @@ static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
 	link_info.rate = ctrl->link->link_params.rate;
 	link_info.capabilities = DP_LINK_CAP_ENHANCED_FRAMING;
 
+	dp_link_reset_phy_params_vx_px(ctrl->link);
+
 	dp_aux_link_configure(ctrl->aux, &link_info);
 	drm_dp_dpcd_write(ctrl->aux, DP_MAIN_LINK_CHANNEL_CODING_SET,
 				&encoding, 1);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9f3f7588fe46..c4e4a24692f6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -875,7 +875,15 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 #define USB_DEVICE_ID_MS_SURFACE3_COVER		0x07de
-#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER	0x02fd
+/*
+ * For a description of the Xbox controller models, refer to:
+ * https://en.wikipedia.org/wiki/Xbox_Wireless_Controller#Summary
+ */
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708	0x02fd
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE	0x0b20
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914	0x0b13
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797	0x0b05
+#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE	0x0b22
 #define USB_DEVICE_ID_MS_PIXART_MOUSE    0x00cb
 #define USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS      0x02e0
 #define USB_DEVICE_ID_MS_MOUSE_0783      0x0783
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 071fd093a5f4..9345e2bfd56e 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -446,7 +446,16 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_PRESENTER },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x091B),
 		.driver_data = MS_SURFACE_DIAL },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
+
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797),
+		.driver_data = MS_QUIRK_FF },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE),
 		.driver_data = MS_QUIRK_FF },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS),
 		.driver_data = MS_QUIRK_FF },
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f6ee287a892c..eee0f938e4d6 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1920,12 +1920,14 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
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
index 4eccc0f69861..d8f252c4caf2 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -312,7 +312,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	 * frequency with only 62 clock ticks max (31 high, 31 low).
 	 * Aim for a duty of 60% LOW, 40% HIGH.
 	 */
-	total_ticks = DIV_ROUND_UP(rate, t->bus_freq_hz);
+	total_ticks = DIV_ROUND_UP(rate, t->bus_freq_hz ?: 1);
 
 	for (cks = 0; cks < 7; cks++) {
 		/*
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index c74868f01637..b7ae4bf2f549 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -13224,15 +13224,16 @@ static void read_mod_write(struct hfi1_devdata *dd, u16 src, u64 bits,
 {
 	u64 reg;
 	u16 idx = src / BITS_PER_REGISTER;
+	unsigned long flags;
 
-	spin_lock(&dd->irq_src_lock);
+	spin_lock_irqsave(&dd->irq_src_lock, flags);
 	reg = read_csr(dd, CCE_INT_MASK + (8 * idx));
 	if (set)
 		reg |= bits;
 	else
 		reg &= ~bits;
 	write_csr(dd, CCE_INT_MASK + (8 * idx), reg);
-	spin_unlock(&dd->irq_src_lock);
+	spin_unlock_irqrestore(&dd->irq_src_lock, flags);
 }
 
 /**
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 76b993e8d672..f34793068f34 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -235,7 +235,7 @@ static int create_cq(struct rtrs_con *con, int cq_vector, u16 cq_size,
 static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
 		     u32 max_send_wr, u32 max_recv_wr, u32 max_sge)
 {
-	struct ib_qp_init_attr init_attr = {NULL};
+	struct ib_qp_init_attr init_attr = {};
 	struct rdma_cm_id *cm_id = con->cm_id;
 	int ret;
 
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 44fe6f2f063c..d0f8c31d7cc0 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -45,6 +45,9 @@ int input_mt_init_slots(struct input_dev *dev, unsigned int num_slots,
 		return 0;
 	if (mt)
 		return mt->num_slots != num_slots ? -EINVAL : 0;
+	/* Arbitrary limit for avoiding too large memory allocation. */
+	if (num_slots > 1024)
+		return -EINVAL;
 
 	mt = kzalloc(struct_size(mt, slots, num_slots), GFP_KERNEL);
 	if (!mt)
diff --git a/drivers/input/serio/ioc3kbd.c b/drivers/input/serio/ioc3kbd.c
index 676b0bda3d72..bf305fbc891d 100644
--- a/drivers/input/serio/ioc3kbd.c
+++ b/drivers/input/serio/ioc3kbd.c
@@ -190,7 +190,7 @@ static int ioc3kbd_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void ioc3kbd_remove(struct platform_device *pdev)
+static int ioc3kbd_remove(struct platform_device *pdev)
 {
 	struct ioc3kbd_data *d = platform_get_drvdata(pdev);
 
@@ -198,6 +198,8 @@ static void ioc3kbd_remove(struct platform_device *pdev)
 
 	serio_unregister_port(d->kbd);
 	serio_unregister_port(d->aux);
+
+	return 0;
 }
 
 static const struct platform_device_id ioc3kbd_id_table[] = {
@@ -208,7 +210,7 @@ MODULE_DEVICE_TABLE(platform, ioc3kbd_id_table);
 
 static struct platform_driver ioc3kbd_driver = {
 	.probe          = ioc3kbd_probe,
-	.remove_new     = ioc3kbd_remove,
+	.remove         = ioc3kbd_remove,
 	.id_table	= ioc3kbd_id_table,
 	.driver = {
 		.name = "ioc3-kbd",
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4e486cccc4cc..a9469751720c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4469,8 +4469,6 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	struct page *vprop_page;
 	int base, nr_ids, i, err = 0;
 
-	BUG_ON(!vm);
-
 	bitmap = its_lpi_alloc(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
 	if (!bitmap)
 		return -ENOMEM;
diff --git a/drivers/md/dm-clone-metadata.c b/drivers/md/dm-clone-metadata.c
index 17712456fa63..383258eae750 100644
--- a/drivers/md/dm-clone-metadata.c
+++ b/drivers/md/dm-clone-metadata.c
@@ -471,11 +471,6 @@ static void __destroy_persistent_data_structures(struct dm_clone_metadata *cmd)
 
 /*---------------------------------------------------------------------------*/
 
-static size_t bitmap_size(unsigned long nr_bits)
-{
-	return BITS_TO_LONGS(nr_bits) * sizeof(long);
-}
-
 static int __dirty_map_init(struct dirty_map *dmap, unsigned long nr_words,
 			    unsigned long nr_regions)
 {
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 4184c8a2d497..d5c103f82ea1 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1064,8 +1064,26 @@ static int do_resume(struct dm_ioctl *param)
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
index dc8498b4b5c1..b56ea42ab7d2 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2343,7 +2343,7 @@ static int dm_wait_for_bios_completion(struct mapped_device *md, long task_state
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
@@ -2368,7 +2368,7 @@ static int dm_wait_for_completion(struct mapped_device *md, long task_state)
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f1f029243e0c..accf9ac9bb8c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7601,11 +7601,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 
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
index 86e3bb590371..022a9f8e19a2 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -1353,6 +1353,10 @@ int cx23885_video_register(struct cx23885_dev *dev)
 	/* register Video device */
 	dev->video_dev = cx23885_vdev_init(dev, dev->pci,
 		&cx23885_video_template, "video");
+	if (!dev->video_dev) {
+		err = -ENOMEM;
+		goto fail_unreg;
+	}
 	dev->video_dev->queue = &dev->vb2_vidq;
 	dev->video_dev->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
 				      V4L2_CAP_AUDIO | V4L2_CAP_VIDEO_CAPTURE;
@@ -1381,6 +1385,10 @@ int cx23885_video_register(struct cx23885_dev *dev)
 	/* register VBI device */
 	dev->vbi_dev = cx23885_vdev_init(dev, dev->pci,
 		&cx23885_vbi_template, "vbi");
+	if (!dev->vbi_dev) {
+		err = -ENOMEM;
+		goto fail_unreg;
+	}
 	dev->vbi_dev->queue = &dev->vb2_vbiq;
 	dev->vbi_dev->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
 				    V4L2_CAP_AUDIO | V4L2_CAP_VBI_CAPTURE;
diff --git a/drivers/media/pci/solo6x10/solo6x10-offsets.h b/drivers/media/pci/solo6x10/solo6x10-offsets.h
index f414ee1316f2..fdbb817e6360 100644
--- a/drivers/media/pci/solo6x10/solo6x10-offsets.h
+++ b/drivers/media/pci/solo6x10/solo6x10-offsets.h
@@ -57,16 +57,16 @@
 #define SOLO_MP4E_EXT_ADDR(__solo) \
 	(SOLO_EREF_EXT_ADDR(__solo) + SOLO_EREF_EXT_AREA(__solo))
 #define SOLO_MP4E_EXT_SIZE(__solo) \
-	max((__solo->nr_chans * 0x00080000),				\
-	    min(((__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo)) -	\
-		 __SOLO_JPEG_MIN_SIZE(__solo)), 0x00ff0000))
+	clamp(__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo) -	\
+	      __SOLO_JPEG_MIN_SIZE(__solo),			\
+	      __solo->nr_chans * 0x00080000, 0x00ff0000)
 
 #define __SOLO_JPEG_MIN_SIZE(__solo)		(__solo->nr_chans * 0x00080000)
 #define SOLO_JPEG_EXT_ADDR(__solo) \
 		(SOLO_MP4E_EXT_ADDR(__solo) + SOLO_MP4E_EXT_SIZE(__solo))
 #define SOLO_JPEG_EXT_SIZE(__solo) \
-	max(__SOLO_JPEG_MIN_SIZE(__solo),				\
-	    min((__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo)), 0x00ff0000))
+	clamp(__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo),	\
+	      __SOLO_JPEG_MIN_SIZE(__solo), 0x00ff0000)
 
 #define SOLO_SDRAM_END(__solo) \
 	(SOLO_JPEG_EXT_ADDR(__solo) + SOLO_JPEG_EXT_SIZE(__solo))
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 6bf9c5c319de..fd55352d743e 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -765,7 +765,7 @@ static int vcodec_domains_get(struct venus_core *core)
 		pd = dev_pm_domain_attach_by_name(dev,
 						  res->vcodec_pmdomains[i]);
 		if (IS_ERR_OR_NULL(pd))
-			return PTR_ERR(pd) ? : -ENODATA;
+			return pd ? PTR_ERR(pd) : -ENODATA;
 		core->pmdomains[i] = pd;
 	}
 
diff --git a/drivers/media/radio/radio-isa.c b/drivers/media/radio/radio-isa.c
index ad2ac16ff12d..610d3e326951 100644
--- a/drivers/media/radio/radio-isa.c
+++ b/drivers/media/radio/radio-isa.c
@@ -36,7 +36,7 @@ static int radio_isa_querycap(struct file *file, void  *priv,
 
 	strscpy(v->driver, isa->drv->driver.driver.name, sizeof(v->driver));
 	strscpy(v->card, isa->drv->card, sizeof(v->card));
-	snprintf(v->bus_info, sizeof(v->bus_info), "ISA:%s", isa->v4l2_dev.name);
+	snprintf(v->bus_info, sizeof(v->bus_info), "ISA:%s", dev_name(isa->v4l2_dev.dev));
 	return 0;
 }
 
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 288f097e2e6f..f6e97ff7a8e4 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -723,11 +723,11 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
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
@@ -767,7 +767,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	sof = y;
 
 	uvc_trace(UVC_TRACE_CLOCK, "%s: PTS %u y %llu.%06llu SOF %u.%06llu "
-		  "(x1 %u x2 %u y1 %u y2 %u SOF offset %u)\n",
+		  "(x1 %u x2 %u y1 %u y2 %llu SOF offset %u)\n",
 		  stream->dev->name, buf->pts,
 		  y >> 16, div_u64((y & 0xffff) * 1000000, 65536),
 		  sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
@@ -782,7 +782,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 		goto done;
 
 	y1 = NSEC_PER_SEC;
-	y2 = (u32)ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
+	y2 = ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
 
 	/* Interpolated and host SOF timestamps can wrap around at slightly
 	 * different times. Handle this by adding or removing 2048 to or from
@@ -802,7 +802,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	timestamp = ktime_to_ns(first->host_time) + y - y1;
 
 	uvc_trace(UVC_TRACE_CLOCK, "%s: SOF %u.%06llu y %llu ts %llu "
-		  "buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %u)\n",
+		  "buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %llu)\n",
 		  stream->dev->name,
 		  sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
 		  y, timestamp, vbuf->vb2_buf.timestamp,
diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index ffec26a99313..5c387d32c078 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -179,8 +179,11 @@ static int stm32_fmc2_ebi_check_mux(struct stm32_fmc2_ebi *ebi,
 				    int cs)
 {
 	u32 bcr;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if (bcr & FMC2_BCR_MTYP)
 		return 0;
@@ -193,8 +196,11 @@ static int stm32_fmc2_ebi_check_waitcfg(struct stm32_fmc2_ebi *ebi,
 					int cs)
 {
 	u32 bcr, val = FIELD_PREP(FMC2_BCR_MTYP, FMC2_BCR_MTYP_NOR);
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if ((bcr & FMC2_BCR_MTYP) == val && bcr & FMC2_BCR_BURSTEN)
 		return 0;
@@ -207,8 +213,11 @@ static int stm32_fmc2_ebi_check_sync_trans(struct stm32_fmc2_ebi *ebi,
 					   int cs)
 {
 	u32 bcr;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if (bcr & FMC2_BCR_BURSTEN)
 		return 0;
@@ -221,8 +230,11 @@ static int stm32_fmc2_ebi_check_async_trans(struct stm32_fmc2_ebi *ebi,
 					    int cs)
 {
 	u32 bcr;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if (!(bcr & FMC2_BCR_BURSTEN) || !(bcr & FMC2_BCR_CBURSTRW))
 		return 0;
@@ -235,8 +247,11 @@ static int stm32_fmc2_ebi_check_cpsize(struct stm32_fmc2_ebi *ebi,
 				       int cs)
 {
 	u32 bcr, val = FIELD_PREP(FMC2_BCR_MTYP, FMC2_BCR_MTYP_PSRAM);
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if ((bcr & FMC2_BCR_MTYP) == val && bcr & FMC2_BCR_BURSTEN)
 		return 0;
@@ -249,12 +264,18 @@ static int stm32_fmc2_ebi_check_address_hold(struct stm32_fmc2_ebi *ebi,
 					     int cs)
 {
 	u32 bcr, bxtr, val = FIELD_PREP(FMC2_BXTR_ACCMOD, FMC2_BXTR_EXTMOD_D);
+	int ret;
+
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
 	if (prop->reg_type == FMC2_REG_BWTR)
-		regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
 	else
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+	if (ret)
+		return ret;
 
 	if ((!(bcr & FMC2_BCR_BURSTEN) || !(bcr & FMC2_BCR_CBURSTRW)) &&
 	    ((bxtr & FMC2_BXTR_ACCMOD) == val || bcr & FMC2_BCR_MUXEN))
@@ -268,12 +289,19 @@ static int stm32_fmc2_ebi_check_clk_period(struct stm32_fmc2_ebi *ebi,
 					   int cs)
 {
 	u32 bcr, bcr1;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
-	if (cs)
-		regmap_read(ebi->regmap, FMC2_BCR1, &bcr1);
-	else
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
+
+	if (cs) {
+		ret = regmap_read(ebi->regmap, FMC2_BCR1, &bcr1);
+		if (ret)
+			return ret;
+	} else {
 		bcr1 = bcr;
+	}
 
 	if (bcr & FMC2_BCR_BURSTEN && (!cs || !(bcr1 & FMC2_BCR1_CCLKEN)))
 		return 0;
@@ -305,12 +333,18 @@ static u32 stm32_fmc2_ebi_ns_to_clk_period(struct stm32_fmc2_ebi *ebi,
 {
 	u32 nb_clk_cycles = stm32_fmc2_ebi_ns_to_clock_cycles(ebi, cs, setup);
 	u32 bcr, btr, clk_period;
+	int ret;
+
+	ret = regmap_read(ebi->regmap, FMC2_BCR1, &bcr);
+	if (ret)
+		return ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR1, &bcr);
 	if (bcr & FMC2_BCR1_CCLKEN || !cs)
-		regmap_read(ebi->regmap, FMC2_BTR1, &btr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR1, &btr);
 	else
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
+	if (ret)
+		return ret;
 
 	clk_period = FIELD_GET(FMC2_BTR_CLKDIV, btr) + 1;
 
@@ -569,11 +603,16 @@ static int stm32_fmc2_ebi_set_address_setup(struct stm32_fmc2_ebi *ebi,
 	if (ret)
 		return ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
+
 	if (prop->reg_type == FMC2_REG_BWTR)
-		regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
 	else
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+	if (ret)
+		return ret;
 
 	if ((bxtr & FMC2_BXTR_ACCMOD) == val || bcr & FMC2_BCR_MUXEN)
 		val = clamp_val(setup, 1, FMC2_BXTR_ADDSET_MAX);
@@ -691,11 +730,14 @@ static int stm32_fmc2_ebi_set_max_low_pulse(struct stm32_fmc2_ebi *ebi,
 					    int cs, u32 setup)
 {
 	u32 old_val, new_val, pcscntr;
+	int ret;
 
 	if (setup < 1)
 		return 0;
 
-	regmap_read(ebi->regmap, FMC2_PCSCNTR, &pcscntr);
+	ret = regmap_read(ebi->regmap, FMC2_PCSCNTR, &pcscntr);
+	if (ret)
+		return ret;
 
 	/* Enable counter for the bank */
 	regmap_update_bits(ebi->regmap, FMC2_PCSCNTR,
@@ -942,17 +984,20 @@ static void stm32_fmc2_ebi_disable_bank(struct stm32_fmc2_ebi *ebi, int cs)
 	regmap_update_bits(ebi->regmap, FMC2_BCR(cs), FMC2_BCR_MBKEN, 0);
 }
 
-static void stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
+static int stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
 {
 	unsigned int cs;
+	int ret;
 
 	for (cs = 0; cs < FMC2_MAX_EBI_CE; cs++) {
-		regmap_read(ebi->regmap, FMC2_BCR(cs), &ebi->bcr[cs]);
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &ebi->btr[cs]);
-		regmap_read(ebi->regmap, FMC2_BWTR(cs), &ebi->bwtr[cs]);
+		ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &ebi->bcr[cs]);
+		ret |= regmap_read(ebi->regmap, FMC2_BTR(cs), &ebi->btr[cs]);
+		ret |= regmap_read(ebi->regmap, FMC2_BWTR(cs), &ebi->bwtr[cs]);
+		if (ret)
+			return ret;
 	}
 
-	regmap_read(ebi->regmap, FMC2_PCSCNTR, &ebi->pcscntr);
+	return regmap_read(ebi->regmap, FMC2_PCSCNTR, &ebi->pcscntr);
 }
 
 static void stm32_fmc2_ebi_set_setup(struct stm32_fmc2_ebi *ebi)
@@ -981,22 +1026,29 @@ static void stm32_fmc2_ebi_disable_banks(struct stm32_fmc2_ebi *ebi)
 }
 
 /* NWAIT signal can not be connected to EBI controller and NAND controller */
-static bool stm32_fmc2_ebi_nwait_used_by_ctrls(struct stm32_fmc2_ebi *ebi)
+static int stm32_fmc2_ebi_nwait_used_by_ctrls(struct stm32_fmc2_ebi *ebi)
 {
+	struct device *dev = ebi->dev;
 	unsigned int cs;
 	u32 bcr;
+	int ret;
 
 	for (cs = 0; cs < FMC2_MAX_EBI_CE; cs++) {
 		if (!(ebi->bank_assigned & BIT(cs)))
 			continue;
 
-		regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+		ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+		if (ret)
+			return ret;
+
 		if ((bcr & FMC2_BCR_WAITEN || bcr & FMC2_BCR_ASYNCWAIT) &&
-		    ebi->bank_assigned & BIT(FMC2_NAND))
-			return true;
+		    ebi->bank_assigned & BIT(FMC2_NAND)) {
+			dev_err(dev, "NWAIT signal connected to EBI and NAND controllers\n");
+			return -EINVAL;
+		}
 	}
 
-	return false;
+	return 0;
 }
 
 static void stm32_fmc2_ebi_enable(struct stm32_fmc2_ebi *ebi)
@@ -1083,10 +1135,9 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 		return -ENODEV;
 	}
 
-	if (stm32_fmc2_ebi_nwait_used_by_ctrls(ebi)) {
-		dev_err(dev, "NWAIT signal connected to EBI and NAND controllers\n");
-		return -EINVAL;
-	}
+	ret = stm32_fmc2_ebi_nwait_used_by_ctrls(ebi);
+	if (ret)
+		return ret;
 
 	stm32_fmc2_ebi_enable(ebi);
 
@@ -1131,7 +1182,10 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_release;
 
-	stm32_fmc2_ebi_save_setup(ebi);
+	ret = stm32_fmc2_ebi_save_setup(ebi);
+	if (ret)
+		goto err_release;
+
 	platform_set_drvdata(pdev, ebi);
 
 	return 0;
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index b9b6f000154b..9ebd5cebd4e1 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3125,13 +3125,13 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
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
@@ -3139,6 +3139,7 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 
 #ifdef CONFIG_HIGHMEM
 	__free_pages(test->highmem, BUFFER_ORDER);
+free_test_buffer:
 #endif
 	kfree(test->buffer);
 	kfree(test);
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a6170f80ba64..4da525f9c11f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3171,6 +3171,10 @@ int dw_mci_probe(struct dw_mci *host)
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
@@ -3182,6 +3186,10 @@ int dw_mci_probe(struct dw_mci *host)
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
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c07b9bac1a6a..506b6d1cc27d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -540,7 +540,6 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 		} else {
 			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
 		}
-		ipsec->xs->xso.real_dev = NULL;
 	}
 	spin_unlock_bh(&bond->ipsec_lock);
 	rcu_read_unlock();
@@ -557,34 +556,30 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	struct net_device *real_dev;
 	struct slave *curr_active;
 	struct bonding *bond;
-	int err;
+	bool ok = false;
 
 	bond = netdev_priv(bond_dev);
 	rcu_read_lock();
 	curr_active = rcu_dereference(bond->curr_active_slave);
+	if (!curr_active)
+		goto out;
 	real_dev = curr_active->dev;
 
-	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
-		err = false;
+	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
 		goto out;
-	}
 
-	if (!xs->xso.real_dev) {
-		err = false;
+	if (!xs->xso.real_dev)
 		goto out;
-	}
 
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_offload_ok ||
-	    netif_is_bond_master(real_dev)) {
-		err = false;
+	    netif_is_bond_master(real_dev))
 		goto out;
-	}
 
-	err = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
+	ok = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
 out:
 	rcu_read_unlock();
-	return err;
+	return ok;
 }
 
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index fa0bf77870d4..acc618574994 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -822,7 +822,7 @@ static int bond_option_active_slave_set(struct bonding *bond,
 	/* check to see if we are clearing active */
 	if (!slave_dev) {
 		netdev_dbg(bond->dev, "Clearing current active slave\n");
-		RCU_INIT_POINTER(bond->curr_active_slave, NULL);
+		bond_change_active_slave(bond, NULL);
 		bond_select_active_slave(bond);
 	} else {
 		struct slave *old_active = rtnl_dereference(bond->curr_active_slave);
diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
index 4b080b448ce7..1f7240e0d6bc 100644
--- a/drivers/net/dsa/mv88e6xxx/Makefile
+++ b/drivers/net/dsa/mv88e6xxx/Makefile
@@ -15,3 +15,7 @@ mv88e6xxx-objs += port_hidden.o
 mv88e6xxx-$(CONFIG_NET_DSA_MV88E6XXX_PTP) += ptp.o
 mv88e6xxx-objs += serdes.o
 mv88e6xxx-objs += smi.o
+mv88e6xxx-objs += trace.o
+
+# for tracing framework to find trace.h
+CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index bac9a8a68e50..79377ceb66af 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -12,6 +12,7 @@
 
 #include "chip.h"
 #include "global1.h"
+#include "trace.h"
 
 /* Offset 0x01: ATU FID Register */
 
@@ -114,6 +115,19 @@ static int mv88e6xxx_g1_atu_op_wait(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_ATU_OP, bit, 0);
 }
 
+static int mv88e6xxx_g1_read_atu_violation(struct mv88e6xxx_chip *chip)
+{
+	int err;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_ATU_OP,
+				 MV88E6XXX_G1_ATU_OP_BUSY |
+				 MV88E6XXX_G1_ATU_OP_GET_CLR_VIOLATION);
+	if (err)
+		return err;
+
+	return mv88e6xxx_g1_atu_op_wait(chip);
+}
+
 static int mv88e6xxx_g1_atu_op(struct mv88e6xxx_chip *chip, u16 fid, u16 op)
 {
 	u16 val;
@@ -159,6 +173,41 @@ int mv88e6xxx_g1_atu_get_next(struct mv88e6xxx_chip *chip, u16 fid)
 	return mv88e6xxx_g1_atu_op(chip, fid, MV88E6XXX_G1_ATU_OP_GET_NEXT_DB);
 }
 
+static int mv88e6xxx_g1_atu_fid_read(struct mv88e6xxx_chip *chip, u16 *fid)
+{
+	u16 val = 0, upper = 0, op = 0;
+	int err = -EOPNOTSUPP;
+
+	if (mv88e6xxx_num_databases(chip) > 256) {
+		err = mv88e6xxx_g1_read(chip, MV88E6352_G1_ATU_FID, &val);
+		val &= 0xfff;
+		if (err)
+			return err;
+	} else {
+		err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_ATU_OP, &op);
+		if (err)
+			return err;
+		if (mv88e6xxx_num_databases(chip) > 64) {
+			/* ATU DBNum[7:4] are located in ATU Control 15:12 */
+			err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_ATU_CTL,
+						&upper);
+			if (err)
+				return err;
+
+			upper = (upper >> 8) & 0x00f0;
+		} else if (mv88e6xxx_num_databases(chip) > 16) {
+			/* ATU DBNum[5:4] are located in ATU Operation 9:8 */
+			upper = (op >> 4) & 0x30;
+		}
+
+		/* ATU DBNum[3:0] are located in ATU Operation 3:0 */
+		val = (op & 0xf) | upper;
+	}
+	*fid = val;
+
+	return err;
+}
+
 /* Offset 0x0C: ATU Data Register */
 
 static int mv88e6xxx_g1_atu_data_read(struct mv88e6xxx_chip *chip,
@@ -353,14 +402,12 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 {
 	struct mv88e6xxx_chip *chip = dev_id;
 	struct mv88e6xxx_atu_entry entry;
-	int spid;
-	int err;
-	u16 val;
+	int err, spid;
+	u16 val, fid;
 
 	mv88e6xxx_reg_lock(chip);
 
-	err = mv88e6xxx_g1_atu_op(chip, 0,
-				  MV88E6XXX_G1_ATU_OP_GET_CLR_VIOLATION);
+	err = mv88e6xxx_g1_read_atu_violation(chip);
 	if (err)
 		goto out;
 
@@ -368,6 +415,10 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 	if (err)
 		goto out;
 
+	err = mv88e6xxx_g1_atu_fid_read(chip, &fid);
+	if (err)
+		goto out;
+
 	err = mv88e6xxx_g1_atu_data_read(chip, &entry);
 	if (err)
 		goto out;
@@ -385,24 +436,25 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 	}
 
 	if (val & MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION) {
-		dev_err_ratelimited(chip->dev,
-				    "ATU member violation for %pM portvec %x spid %d\n",
-				    entry.mac, entry.portvec, spid);
+		trace_mv88e6xxx_atu_member_violation(chip->dev, spid,
+						     entry.portvec, entry.mac,
+						     fid);
 		chip->ports[spid].atu_member_violation++;
 	}
 
 	if (val & MV88E6XXX_G1_ATU_OP_MISS_VIOLATION) {
-		dev_err_ratelimited(chip->dev,
-				    "ATU miss violation for %pM portvec %x spid %d\n",
-				    entry.mac, entry.portvec, spid);
+		trace_mv88e6xxx_atu_miss_violation(chip->dev, spid,
+						   entry.portvec, entry.mac,
+						   fid);
 		chip->ports[spid].atu_miss_violation++;
 	}
 
 	if (val & MV88E6XXX_G1_ATU_OP_FULL_VIOLATION) {
-		dev_err_ratelimited(chip->dev,
-				    "ATU full violation for %pM portvec %x spid %d\n",
-				    entry.mac, entry.portvec, spid);
-		chip->ports[spid].atu_full_violation++;
+		trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
+						   entry.portvec, entry.mac,
+						   fid);
+		if (spid < ARRAY_SIZE(chip->ports))
+			chip->ports[spid].atu_full_violation++;
 	}
 	mv88e6xxx_reg_unlock(chip);
 
diff --git a/drivers/net/dsa/mv88e6xxx/trace.c b/drivers/net/dsa/mv88e6xxx/trace.c
new file mode 100644
index 000000000000..7833cb50ca5d
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/trace.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright 2022 NXP
+ */
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/drivers/net/dsa/mv88e6xxx/trace.h b/drivers/net/dsa/mv88e6xxx/trace.h
new file mode 100644
index 000000000000..d9ab5c8dee55
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/trace.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2022 NXP
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM	mv88e6xxx
+
+#if !defined(_MV88E6XXX_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _MV88E6XXX_TRACE_H
+
+#include <linux/device.h>
+#include <linux/if_ether.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(mv88e6xxx_atu_violation,
+
+	TP_PROTO(const struct device *dev, int spid, u16 portvec,
+		 const unsigned char *addr, u16 fid),
+
+	TP_ARGS(dev, spid, portvec, addr, fid),
+
+	TP_STRUCT__entry(
+		__string(name, dev_name(dev))
+		__field(int, spid)
+		__field(u16, portvec)
+		__array(unsigned char, addr, ETH_ALEN)
+		__field(u16, fid)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, dev_name(dev));
+		__entry->spid = spid;
+		__entry->portvec = portvec;
+		memcpy(__entry->addr, addr, ETH_ALEN);
+		__entry->fid = fid;
+	),
+
+	TP_printk("dev %s spid %d portvec 0x%x addr %pM fid %u",
+		  __get_str(name), __entry->spid, __entry->portvec,
+		  __entry->addr, __entry->fid)
+);
+
+DEFINE_EVENT(mv88e6xxx_atu_violation, mv88e6xxx_atu_member_violation,
+	     TP_PROTO(const struct device *dev, int spid, u16 portvec,
+		      const unsigned char *addr, u16 fid),
+	     TP_ARGS(dev, spid, portvec, addr, fid));
+
+DEFINE_EVENT(mv88e6xxx_atu_violation, mv88e6xxx_atu_miss_violation,
+	     TP_PROTO(const struct device *dev, int spid, u16 portvec,
+		      const unsigned char *addr, u16 fid),
+	     TP_ARGS(dev, spid, portvec, addr, fid));
+
+DEFINE_EVENT(mv88e6xxx_atu_violation, mv88e6xxx_atu_full_violation,
+	     TP_PROTO(const struct device *dev, int spid, u16 portvec,
+		      const unsigned char *addr, u16 fid),
+	     TP_ARGS(dev, spid, portvec, addr, fid));
+
+#endif /* _MV88E6XXX_TRACE_H */
+
+/* We don't want to use include/trace/events */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE	trace
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 018988b95035..8a21902212e0 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_mdio.h>
@@ -38,6 +39,10 @@
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
+/* MII Block subblock */
+#define VSC73XX_BLOCK_MII_INTERNAL	0x0 /* Internal MDIO subblock */
+#define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
+
 #define CPU_PORT	6 /* CPU port */
 
 /* MAC Block registers */
@@ -196,6 +201,8 @@
 #define VSC73XX_MII_CMD		0x1
 #define VSC73XX_MII_DATA	0x2
 
+#define VSC73XX_MII_STAT_BUSY	BIT(3)
+
 /* Arbiter block 5 registers */
 #define VSC73XX_ARBEMPTY		0x0c
 #define VSC73XX_ARBDISC			0x0e
@@ -269,6 +276,10 @@
 #define IS_7398(a) ((a)->chipid == VSC73XX_CHIPID_ID_7398)
 #define IS_739X(a) (IS_7395(a) || IS_7398(a))
 
+#define VSC73XX_POLL_SLEEP_US		1000
+#define VSC73XX_MDIO_POLL_SLEEP_US	5
+#define VSC73XX_POLL_TIMEOUT_US		10000
+
 struct vsc73xx_counter {
 	u8 counter;
 	const char *name;
@@ -484,6 +495,22 @@ static int vsc73xx_detect(struct vsc73xx *vsc)
 	return 0;
 }
 
+static int vsc73xx_mdio_busy_check(struct vsc73xx *vsc)
+{
+	int ret, err;
+	u32 val;
+
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 || !(val & VSC73XX_MII_STAT_BUSY),
+				VSC73XX_MDIO_POLL_SLEEP_US,
+				VSC73XX_POLL_TIMEOUT_US, false, vsc,
+				VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+				VSC73XX_MII_STAT, &val);
+	if (ret)
+		return ret;
+	return err;
+}
+
 static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -491,12 +518,20 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 	u32 val;
 	int ret;
 
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	/* Setting bit 26 means "read" */
 	cmd = BIT(26) | (phy << 21) | (regnum << 16);
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
 		return ret;
-	msleep(2);
+
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, 0, 2, &val);
 	if (ret)
 		return ret;
@@ -520,6 +555,10 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 	u32 cmd;
 	int ret;
 
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	/* It was found through tedious experiments that this router
 	 * chip really hates to have it's PHYs reset. They
 	 * never recover if that happens: autonegotiation stops
@@ -531,7 +570,7 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 		return 0;
 	}
 
-	cmd = (phy << 21) | (regnum << 16);
+	cmd = (phy << 21) | (regnum << 16) | val;
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
 		return ret;
@@ -780,7 +819,7 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 	 * after a PHY or the CPU port comes up or down.
 	 */
 	if (!phydev->link) {
-		int maxloop = 10;
+		int ret, err;
 
 		dev_dbg(vsc->dev, "port %d: went down\n",
 			port);
@@ -795,19 +834,17 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 				    VSC73XX_ARBDISC, BIT(port), BIT(port));
 
 		/* Wait until queue is empty */
-		vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-			     VSC73XX_ARBEMPTY, &val);
-		while (!(val & BIT(port))) {
-			msleep(1);
-			vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				     VSC73XX_ARBEMPTY, &val);
-			if (--maxloop == 0) {
-				dev_err(vsc->dev,
-					"timeout waiting for block arbiter\n");
-				/* Continue anyway */
-				break;
-			}
-		}
+		ret = read_poll_timeout(vsc73xx_read, err,
+					err < 0 || (val & BIT(port)),
+					VSC73XX_POLL_SLEEP_US,
+					VSC73XX_POLL_TIMEOUT_US, false,
+					vsc, VSC73XX_BLOCK_ARBITER, 0,
+					VSC73XX_ARBEMPTY, &val);
+		if (ret)
+			dev_err(vsc->dev,
+				"timeout waiting for block arbiter\n");
+		else if (err < 0)
+			dev_err(vsc->dev, "error reading arbiter\n");
 
 		/* Put this port into reset */
 		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 5fbc087268db..92a9f80554b3 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -1244,7 +1244,8 @@ static u64 hash_filter_ntuple(struct ch_filter_specification *fs,
 	 * in the Compressed Filter Tuple.
 	 */
 	if (tp->vlan_shift >= 0 && fs->mask.ivlan)
-		ntuple |= (FT_VLAN_VLD_F | fs->val.ivlan) << tp->vlan_shift;
+		ntuple |= (u64)(FT_VLAN_VLD_F |
+				fs->val.ivlan) << tp->vlan_shift;
 
 	if (tp->port_shift >= 0 && fs->mask.iport)
 		ntuple |= (u64)fs->val.iport << tp->port_shift;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index f8275534205a..9ff5179b4d87 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4536,6 +4536,9 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	int ret;
 
+	if (!test_bit(HNS3_NIC_STATE_DOWN, &priv->state))
+		hns3_nic_net_stop(netdev);
+
 	if (!test_and_clear_bit(HNS3_NIC_STATE_INITED, &priv->state)) {
 		netdev_warn(netdev, "already uninitialized\n");
 		return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5dbee850fef5..885793707a5f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -10051,8 +10051,8 @@ static void hclge_flr_done(struct hnae3_ae_dev *ae_dev)
 		dev_err(&hdev->pdev->dev, "fail to rebuild, ret=%d\n", ret);
 
 	hdev->reset_type = HNAE3_NONE_RESET;
-	clear_bit(HCLGE_STATE_RST_HANDLING, &hdev->state);
-	up(&hdev->reset_sem);
+	if (test_and_clear_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		up(&hdev->reset_sem);
 }
 
 static void hclge_clear_resetting_state(struct hclge_dev *hdev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 51b7b46f2f30..9969714d1133 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -715,10 +715,11 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 		req = (struct hclge_mbx_vf_to_pf_cmd *)desc->data;
 
 		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
-		if (unlikely(!hnae3_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B))) {
+		if (unlikely(!hnae3_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B) ||
+			     req->mbx_src_vfid > hdev->num_req_vfs)) {
 			dev_warn(&hdev->pdev->dev,
-				 "dropped invalid mailbox message, code = %u\n",
-				 req->msg.code);
+				 "dropped invalid mailbox message, code = %u, vfid = %u\n",
+				 req->msg.code, req->mbx_src_vfid);
 
 			/* dropping/not processing this invalid message */
 			crq->desc[crq->next_to_use].flag = 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index be41117ec146..755935f9efc8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2093,8 +2093,8 @@ static void hclgevf_flr_done(struct hnae3_ae_dev *ae_dev)
 			 ret);
 
 	hdev->reset_type = HNAE3_NONE_RESET;
-	clear_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state);
-	up(&hdev->reset_sem);
+	if (test_and_clear_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state))
+		up(&hdev->reset_sem);
 }
 
 static u32 hclgevf_get_fw_version(struct hnae3_handle *handle)
diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 4564ee02c95f..83a6114afbf9 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -990,7 +990,7 @@ static void sun3_82586_timeout(struct net_device *dev, unsigned int txqueue)
 	{
 #ifdef DEBUG
 		printk("%s: xmitter timed out, try to restart! stat: %02x\n",dev->name,p->scb->cus);
-		printk("%s: command-stats: %04x %04x\n",dev->name,swab16(p->xmit_cmds[0]->cmd_status),swab16(p->xmit_cmds[1]->cmd_status));
+		printk("%s: command-stats: %04x\n", dev->name, swab16(p->xmit_cmds[0]->cmd_status));
 		printk("%s: check, whether you set the right interrupt number!\n",dev->name);
 #endif
 		sun3_82586_close(dev);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 442a9bcbf60a..7734264d570d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -786,7 +786,7 @@ ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf, int rx_buf_pgcnt)
 		return false;
 #else
 #define ICE_LAST_OFFSET \
-	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_2048)
+	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_3072)
 	if (rx_buf->page_offset > ICE_LAST_OFFSET)
 		return false;
 #endif /* PAGE_SIZE < 8192) */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index b416a8ee2eed..26631bca5ab8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -679,7 +679,7 @@ mlx5e_ethtool_flow_replace(struct mlx5e_priv *priv,
 	if (num_tuples <= 0) {
 		netdev_warn(priv->netdev, "%s: flow is not valid %d\n",
 			    __func__, num_tuples);
-		return num_tuples;
+		return num_tuples < 0 ? num_tuples : -EINVAL;
 	}
 
 	eth_ft = get_flow_table(priv, fs, num_tuples);
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 7326ad4d5e1c..071822028ea5 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -159,16 +159,17 @@
 #define XAE_RCW1_OFFSET		0x00000404 /* Rx Configuration Word 1 */
 #define XAE_TC_OFFSET		0x00000408 /* Tx Configuration */
 #define XAE_FCC_OFFSET		0x0000040C /* Flow Control Configuration */
-#define XAE_EMMC_OFFSET		0x00000410 /* EMAC mode configuration */
-#define XAE_PHYC_OFFSET		0x00000414 /* RGMII/SGMII configuration */
+#define XAE_EMMC_OFFSET		0x00000410 /* MAC speed configuration */
+#define XAE_PHYC_OFFSET		0x00000414 /* RX Max Frame Configuration */
 #define XAE_ID_OFFSET		0x000004F8 /* Identification register */
-#define XAE_MDIO_MC_OFFSET	0x00000500 /* MII Management Config */
-#define XAE_MDIO_MCR_OFFSET	0x00000504 /* MII Management Control */
-#define XAE_MDIO_MWD_OFFSET	0x00000508 /* MII Management Write Data */
-#define XAE_MDIO_MRD_OFFSET	0x0000050C /* MII Management Read Data */
+#define XAE_MDIO_MC_OFFSET	0x00000500 /* MDIO Setup */
+#define XAE_MDIO_MCR_OFFSET	0x00000504 /* MDIO Control */
+#define XAE_MDIO_MWD_OFFSET	0x00000508 /* MDIO Write Data */
+#define XAE_MDIO_MRD_OFFSET	0x0000050C /* MDIO Read Data */
 #define XAE_UAW0_OFFSET		0x00000700 /* Unicast address word 0 */
 #define XAE_UAW1_OFFSET		0x00000704 /* Unicast address word 1 */
-#define XAE_FMI_OFFSET		0x00000708 /* Filter Mask Index */
+#define XAE_FMI_OFFSET		0x00000708 /* Frame Filter Control */
+#define XAE_FFE_OFFSET		0x0000070C /* Frame Filter Enable */
 #define XAE_AF0_OFFSET		0x00000710 /* Address Filter 0 */
 #define XAE_AF1_OFFSET		0x00000714 /* Address Filter 1 */
 
@@ -307,7 +308,7 @@
  */
 #define XAE_UAW1_UNICASTADDR_MASK	0x0000FFFF
 
-/* Bit masks for Axi Ethernet FMI register */
+/* Bit masks for Axi Ethernet FMC register */
 #define XAE_FMI_PM_MASK			0x80000000 /* Promis. mode enable */
 #define XAE_FMI_IND_MASK		0x00000003 /* Index Mask */
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 2a5a3f8761c3..3253ace2b601 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -409,7 +409,7 @@ static int netdev_set_mac_address(struct net_device *ndev, void *p)
  */
 static void axienet_set_multicast_list(struct net_device *ndev)
 {
-	int i;
+	int i = 0;
 	u32 reg, af0reg, af1reg;
 	struct axienet_local *lp = netdev_priv(ndev);
 
@@ -427,7 +427,10 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
 
-		i = 0;
+		reg = axienet_ior(lp, XAE_FMI_OFFSET);
+		reg &= ~XAE_FMI_PM_MASK;
+		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+
 		netdev_for_each_mc_addr(ha, ndev) {
 			if (i >= XAE_MULTICAST_CAM_TABLE_NUM)
 				break;
@@ -446,6 +449,7 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 			axienet_iow(lp, XAE_FMI_OFFSET, reg);
 			axienet_iow(lp, XAE_AF0_OFFSET, af0reg);
 			axienet_iow(lp, XAE_AF1_OFFSET, af1reg);
+			axienet_iow(lp, XAE_FFE_OFFSET, 1);
 			i++;
 		}
 	} else {
@@ -453,18 +457,15 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg &= ~XAE_FMI_PM_MASK;
 
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-
-		for (i = 0; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
-			reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
-			reg |= i;
-
-			axienet_iow(lp, XAE_FMI_OFFSET, reg);
-			axienet_iow(lp, XAE_AF0_OFFSET, 0);
-			axienet_iow(lp, XAE_AF1_OFFSET, 0);
-		}
-
 		dev_info(&ndev->dev, "Promiscuous mode disabled.\n");
 	}
+
+	for (; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
+		reg = axienet_ior(lp, XAE_FMI_OFFSET) & 0xFFFFFF00;
+		reg |= i;
+		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+		axienet_iow(lp, XAE_FFE_OFFSET, 0);
+	}
 }
 
 /**
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index c8246363d383..24cb7b97e4fc 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -567,6 +567,9 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_cow_head(skb, dev->needed_headroom))
 		goto tx_err;
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	skb_reset_inner_headers(skb);
 
 	/* PDP context lookups in gtp_build_skb_*() need rcu read-side lock. */
@@ -798,7 +801,7 @@ static struct sock *gtp_encap_enable_socket(int fd, int type,
 	sock = sockfd_lookup(fd, &err);
 	if (!sock) {
 		pr_debug("gtp socket fd=%d not found\n", fd);
-		return NULL;
+		return ERR_PTR(err);
 	}
 
 	sk = sock->sk;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index a9df48c75155..a52af491eed5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2675,7 +2675,7 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 	if (!(mvm->scan_status & type))
 		return 0;
 
-	if (iwl_mvm_is_radio_killed(mvm)) {
+	if (!test_bit(STATUS_DEVICE_ENABLED, &mvm->trans->status)) {
 		ret = 0;
 		goto out;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 03ba8ed995bf..9c90a5bd3a81 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4314,11 +4314,27 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
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
@@ -4411,8 +4427,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	if (ret < 0) {
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: wiphy_register failed: %d\n", __func__, ret);
-		wiphy_free(wiphy);
-		return ret;
+		goto err;
 	}
 
 	if (!adapter->regd) {
@@ -4454,4 +4469,9 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 
 	adapter->wiphy = wiphy;
 	return ret;
+
+err:
+	wiphy_free(wiphy);
+
+	return ret;
 }
diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index 400dd585916b..7ef088650357 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -1170,7 +1170,7 @@ void cw1200_rx_cb(struct cw1200_common *priv,
 		size_t ies_len = skb->len - (ies - (u8 *)(skb->data));
 
 		tim_ie = cfg80211_find_ie(WLAN_EID_TIM, ies, ies_len);
-		if (tim_ie) {
+		if (tim_ie && tim_ie[1] >= sizeof(struct ieee80211_tim_ie)) {
 			struct ieee80211_tim_ie *tim =
 				(struct ieee80211_tim_ie *)&tim_ie[2];
 
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index 87e1296c6838..4de5205d9d61 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1751,6 +1751,11 @@ static int pn533_start_poll(struct nfc_dev *nfc_dev,
 	}
 
 	pn533_poll_create_mod_list(dev, im_protocols, tm_protocols);
+	if (!dev->poll_mod_count) {
+		nfc_err(dev->dev,
+			"Poll mod list is empty\n");
+		return -EINVAL;
+	}
 
 	/* Do not always start polling from the same modulation */
 	get_random_bytes(&rand_mod, sizeof(rand_mod));
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 6d5552f2f184..944e8a276663 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -472,12 +472,8 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
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
@@ -488,12 +484,8 @@ static void nvmet_rdma_free_rsps(struct nvmet_rdma_queue *queue)
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
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d70a2fa4ba45..e493fc709065 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -846,6 +846,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 		pr_err("bad nvme-tcp pdu length (%d)\n",
 			le32_to_cpu(icreq->hdr.plen));
 		nvmet_tcp_fatal_error(queue);
+		return -EPROTO;
 	}
 
 	if (icreq->pfv != NVME_TCP_PFV_1_0) {
diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index 1373a3c67962..a3564e12927b 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -195,7 +195,7 @@ const char *nvmet_trace_disk_name(struct trace_seq *p, char *name)
 	return ret;
 }
 
-const char *nvmet_trace_ctrl_name(struct trace_seq *p, struct nvmet_ctrl *ctrl)
+const char *nvmet_trace_ctrl_id(struct trace_seq *p, u16 ctrl_id)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
 
@@ -208,8 +208,8 @@ const char *nvmet_trace_ctrl_name(struct trace_seq *p, struct nvmet_ctrl *ctrl)
 	 * If we can know the extra data of the connect command in this stage,
 	 * we can update this print statement later.
 	 */
-	if (ctrl)
-		trace_seq_printf(p, "%d", ctrl->cntlid);
+	if (ctrl_id)
+		trace_seq_printf(p, "%d", ctrl_id);
 	else
 		trace_seq_printf(p, "_");
 	trace_seq_putc(p, 0);
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index c14e3249a14d..13fb8265f952 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -32,18 +32,24 @@ const char *nvmet_trace_parse_fabrics_cmd(struct trace_seq *p, u8 fctype,
 	 nvmet_trace_parse_nvm_cmd(p, opcode, cdw10) :			\
 	 nvmet_trace_parse_admin_cmd(p, opcode, cdw10)))
 
-const char *nvmet_trace_ctrl_name(struct trace_seq *p, struct nvmet_ctrl *ctrl);
-#define __print_ctrl_name(ctrl)				\
-	nvmet_trace_ctrl_name(p, ctrl)
+const char *nvmet_trace_ctrl_id(struct trace_seq *p, u16 ctrl_id);
+#define __print_ctrl_id(ctrl_id)			\
+	nvmet_trace_ctrl_id(p, ctrl_id)
 
 const char *nvmet_trace_disk_name(struct trace_seq *p, char *name);
 #define __print_disk_name(name)				\
 	nvmet_trace_disk_name(p, name)
 
 #ifndef TRACE_HEADER_MULTI_READ
-static inline struct nvmet_ctrl *nvmet_req_to_ctrl(struct nvmet_req *req)
+static inline u16 nvmet_req_to_ctrl_id(struct nvmet_req *req)
 {
-	return req->sq->ctrl;
+	/*
+	 * The queue and controller pointers are not valid until an association
+	 * has been established.
+	 */
+	if (!req->sq || !req->sq->ctrl)
+		return 0;
+	return req->sq->ctrl->cntlid;
 }
 
 static inline void __assign_req_name(char *name, struct nvmet_req *req)
@@ -60,7 +66,7 @@ TRACE_EVENT(nvmet_req_init,
 	TP_ARGS(req, cmd),
 	TP_STRUCT__entry(
 		__field(struct nvme_command *, cmd)
-		__field(struct nvmet_ctrl *, ctrl)
+		__field(u16, ctrl_id)
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, qid)
 		__field(u16, cid)
@@ -73,7 +79,7 @@ TRACE_EVENT(nvmet_req_init,
 	),
 	TP_fast_assign(
 		__entry->cmd = cmd;
-		__entry->ctrl = nvmet_req_to_ctrl(req);
+		__entry->ctrl_id = nvmet_req_to_ctrl_id(req);
 		__assign_req_name(__entry->disk, req);
 		__entry->qid = req->sq->qid;
 		__entry->cid = cmd->common.command_id;
@@ -87,7 +93,7 @@ TRACE_EVENT(nvmet_req_init,
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, nsid=%u, flags=%#x, "
 		  "meta=%#llx, cmd=(%s, %s)",
-		__print_ctrl_name(__entry->ctrl),
+		__print_ctrl_id(__entry->ctrl_id),
 		__print_disk_name(__entry->disk),
 		__entry->qid, __entry->cid, __entry->nsid,
 		__entry->flags, __entry->metadata,
@@ -101,7 +107,7 @@ TRACE_EVENT(nvmet_req_complete,
 	TP_PROTO(struct nvmet_req *req),
 	TP_ARGS(req),
 	TP_STRUCT__entry(
-		__field(struct nvmet_ctrl *, ctrl)
+		__field(u16, ctrl_id)
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, qid)
 		__field(int, cid)
@@ -109,7 +115,7 @@ TRACE_EVENT(nvmet_req_complete,
 		__field(u16, status)
 	),
 	TP_fast_assign(
-		__entry->ctrl = nvmet_req_to_ctrl(req);
+		__entry->ctrl_id = nvmet_req_to_ctrl_id(req);
 		__entry->qid = req->cq->qid;
 		__entry->cid = req->cqe->command_id;
 		__entry->result = le64_to_cpu(req->cqe->result.u64);
@@ -117,7 +123,7 @@ TRACE_EVENT(nvmet_req_complete,
 		__assign_req_name(__entry->disk, req);
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, res=%#llx, status=%#x",
-		__print_ctrl_name(__entry->ctrl),
+		__print_ctrl_id(__entry->ctrl_id),
 		__print_disk_name(__entry->disk),
 		__entry->qid, __entry->cid, __entry->result, __entry->status)
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index e0f22ce219ee..b85c1ce210f6 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -3695,7 +3695,7 @@ static struct rockchip_pin_bank rk3328_pin_banks[] = {
 	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0,
-			     0,
+			     IOMUX_WIDTH_2BIT,
 			     IOMUX_WIDTH_3BIT,
 			     0),
 	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3",
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 4860c4dd853f..5b76594b535c 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -350,6 +350,8 @@ static int pcs_get_function(struct pinctrl_dev *pctldev, unsigned pin,
 		return -ENOTSUPP;
 	fselector = setting->func;
 	function = pinmux_generic_get_function(pctldev, fselector);
+	if (!function)
+		return -EINVAL;
 	*func = function->data;
 	if (!(*func)) {
 		dev_err(pcs->dev, "%s could not find function%i\n",
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 81de5c98221a..0b09ed6ac133 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1665,9 +1665,15 @@ static int dasd_ese_needs_format(struct dasd_block *block, struct irb *irb)
 	if (!sense)
 		return 0;
 
-	return !!(sense[1] & SNS1_NO_REC_FOUND) ||
-		!!(sense[1] & SNS1_FILE_PROTECTED) ||
-		scsw_cstat(&irb->scsw) == SCHN_STAT_INCORR_LEN;
+	if (sense[1] & SNS1_NO_REC_FOUND)
+		return 1;
+
+	if ((sense[1] & SNS1_INV_TRACK_FORMAT) &&
+	    scsw_is_tm(&irb->scsw) &&
+	    !(sense[2] & SNS2_ENV_DATA_PRESENT))
+		return 1;
+
+	return 0;
 }
 
 static int dasd_ese_oos_cond(u8 *sense)
@@ -1688,7 +1694,7 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	struct dasd_device *device;
 	unsigned long now;
 	int nrf_suppressed = 0;
-	int fp_suppressed = 0;
+	int it_suppressed = 0;
 	struct request *req;
 	u8 *sense = NULL;
 	int expires;
@@ -1743,8 +1749,9 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		 */
 		sense = dasd_get_sense(irb);
 		if (sense) {
-			fp_suppressed = (sense[1] & SNS1_FILE_PROTECTED) &&
-				test_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
+			it_suppressed =	(sense[1] & SNS1_INV_TRACK_FORMAT) &&
+				!(sense[2] & SNS2_ENV_DATA_PRESENT) &&
+				test_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 			nrf_suppressed = (sense[1] & SNS1_NO_REC_FOUND) &&
 				test_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
 
@@ -1759,7 +1766,7 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 				return;
 			}
 		}
-		if (!(fp_suppressed || nrf_suppressed))
+		if (!(it_suppressed || nrf_suppressed))
 			device->discipline->dump_sense_dbf(device, irb, "int");
 
 		if (device->features & DASD_FEATURE_ERPLOG)
@@ -2513,14 +2520,17 @@ static int _dasd_sleep_on_queue(struct list_head *ccw_queue, int interruptible)
 	rc = 0;
 	list_for_each_entry_safe(cqr, n, ccw_queue, blocklist) {
 		/*
-		 * In some cases the 'File Protected' or 'Incorrect Length'
-		 * error might be expected and error recovery would be
-		 * unnecessary in these cases.	Check if the according suppress
-		 * bit is set.
+		 * In some cases certain errors might be expected and
+		 * error recovery would be unnecessary in these cases.
+		 * Check if the according suppress bit is set.
 		 */
 		sense = dasd_get_sense(&cqr->irb);
-		if (sense && sense[1] & SNS1_FILE_PROTECTED &&
-		    test_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags))
+		if (sense && (sense[1] & SNS1_INV_TRACK_FORMAT) &&
+		    !(sense[2] & SNS2_ENV_DATA_PRESENT) &&
+		    test_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags))
+			continue;
+		if (sense && (sense[1] & SNS1_NO_REC_FOUND) &&
+		    test_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags))
 			continue;
 		if (scsw_cstat(&cqr->irb.scsw) == 0x40 &&
 		    test_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags))
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index c2d4ea74e0d0..845f088ce97b 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -1401,14 +1401,8 @@ dasd_3990_erp_file_prot(struct dasd_ccw_req * erp)
 
 	struct dasd_device *device = erp->startdev;
 
-	/*
-	 * In some cases the 'File Protected' error might be expected and
-	 * log messages shouldn't be written then.
-	 * Check if the according suppress bit is set.
-	 */
-	if (!test_bit(DASD_CQR_SUPPRESS_FP, &erp->flags))
-		dev_err(&device->cdev->dev,
-			"Accessing the DASD failed because of a hardware error\n");
+	dev_err(&device->cdev->dev,
+		"Accessing the DASD failed because of a hardware error\n");
 
 	return dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index c6930c159d2a..fddcb910157c 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2201,6 +2201,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 	cqr->status = DASD_CQR_FILLED;
 	/* Set flags to suppress output for expected errors */
 	set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
+	set_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 
 	return cqr;
 }
@@ -2482,7 +2483,6 @@ dasd_eckd_build_check_tcw(struct dasd_device *base, struct format_data_t *fdata,
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 	/* Set flags to suppress output for expected errors */
-	set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
 	set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 
 	return cqr;
@@ -4031,8 +4031,6 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 
 	/* Set flags to suppress output for expected errors */
 	if (dasd_eckd_is_ese(basedev)) {
-		set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
-		set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 		set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
 	}
 
@@ -4534,9 +4532,8 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
 
 	/* Set flags to suppress output for expected errors */
 	if (dasd_eckd_is_ese(basedev)) {
-		set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
-		set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 		set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
+		set_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 	}
 
 	return cqr;
@@ -5706,36 +5703,32 @@ static void dasd_eckd_dump_sense(struct dasd_device *device,
 {
 	u8 *sense = dasd_get_sense(irb);
 
-	if (scsw_is_tm(&irb->scsw)) {
-		/*
-		 * In some cases the 'File Protected' or 'Incorrect Length'
-		 * error might be expected and log messages shouldn't be written
-		 * then. Check if the according suppress bit is set.
-		 */
-		if (sense && (sense[1] & SNS1_FILE_PROTECTED) &&
-		    test_bit(DASD_CQR_SUPPRESS_FP, &req->flags))
-			return;
-		if (scsw_cstat(&irb->scsw) == 0x40 &&
-		    test_bit(DASD_CQR_SUPPRESS_IL, &req->flags))
-			return;
+	/*
+	 * In some cases certain errors might be expected and
+	 * log messages shouldn't be written then.
+	 * Check if the according suppress bit is set.
+	 */
+	if (sense && (sense[1] & SNS1_INV_TRACK_FORMAT) &&
+	    !(sense[2] & SNS2_ENV_DATA_PRESENT) &&
+	    test_bit(DASD_CQR_SUPPRESS_IT, &req->flags))
+		return;
 
-		dasd_eckd_dump_sense_tcw(device, req, irb);
-	} else {
-		/*
-		 * In some cases the 'Command Reject' or 'No Record Found'
-		 * error might be expected and log messages shouldn't be
-		 * written then. Check if the according suppress bit is set.
-		 */
-		if (sense && sense[0] & SNS0_CMD_REJECT &&
-		    test_bit(DASD_CQR_SUPPRESS_CR, &req->flags))
-			return;
+	if (sense && sense[0] & SNS0_CMD_REJECT &&
+	    test_bit(DASD_CQR_SUPPRESS_CR, &req->flags))
+		return;
 
-		if (sense && sense[1] & SNS1_NO_REC_FOUND &&
-		    test_bit(DASD_CQR_SUPPRESS_NRF, &req->flags))
-			return;
+	if (sense && sense[1] & SNS1_NO_REC_FOUND &&
+	    test_bit(DASD_CQR_SUPPRESS_NRF, &req->flags))
+		return;
 
+	if (scsw_cstat(&irb->scsw) == 0x40 &&
+	    test_bit(DASD_CQR_SUPPRESS_IL, &req->flags))
+		return;
+
+	if (scsw_is_tm(&irb->scsw))
+		dasd_eckd_dump_sense_tcw(device, req, irb);
+	else
 		dasd_eckd_dump_sense_ccw(device, req, irb);
-	}
 }
 
 static int dasd_eckd_pm_freeze(struct dasd_device *device)
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 5d7d35ca5eb4..052b5d1ba9c1 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -226,7 +226,7 @@ struct dasd_ccw_req {
  * The following flags are used to suppress output of certain errors.
  */
 #define DASD_CQR_SUPPRESS_NRF	4	/* Suppress 'No Record Found' error */
-#define DASD_CQR_SUPPRESS_FP	5	/* Suppress 'File Protected' error*/
+#define DASD_CQR_SUPPRESS_IT	5	/* Suppress 'Invalid Track' error*/
 #define DASD_CQR_SUPPRESS_IL	6	/* Suppress 'Incorrect Length' error */
 #define DASD_CQR_SUPPRESS_CR	7	/* Suppress 'Command Reject' error */
 
diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index 45f9c0736be4..e5f28370a903 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -16,20 +16,21 @@ struct idset {
 	unsigned long bitmap[];
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
index 355b16f0b145..34e45c87cae0 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -642,6 +642,7 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
 
 	if (aac_comm_init(dev)<0){
 		kfree(dev->queues);
+		dev->queues = NULL;
 		return NULL;
 	}
 	/*
@@ -649,6 +650,7 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
 	 */
 	if (aac_fib_setup(dev) < 0) {
 		kfree(dev->queues);
+		dev->queues = NULL;
 		return NULL;
 	}
 		
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 923ceaba0bf3..84f90f4d5abd 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -7048,7 +7048,7 @@ lpfc_sli4_repost_sgl_list(struct lpfc_hba *phba,
 	struct lpfc_sglq *sglq_entry = NULL;
 	struct lpfc_sglq *sglq_entry_next = NULL;
 	struct lpfc_sglq *sglq_entry_first = NULL;
-	int status, total_cnt;
+	int status = 0, total_cnt;
 	int post_cnt = 0, num_posted = 0, block_cnt = 0;
 	int last_xritag = NO_XRI;
 	LIST_HEAD(prep_sgl_list);
diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index c37dd15d16d2..83f2576ed2aa 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -677,10 +677,10 @@ spi_dv_device_echo_buffer(struct scsi_device *sdev, u8 *buffer,
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
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index fc5610603b17..006bb28e2a6e 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -319,7 +319,7 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
+	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WC);
 	if (!cmd_db_header) {
 		ret = -ENOMEM;
 		cmd_db_header = NULL;
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a377c3d02c55..d8f556f793fc 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1425,18 +1425,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
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
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index a19cfb2998c9..f19bb5c796cf 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -658,9 +658,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	ret = ad2s1210_setup_gpios(st);
-	if (ret < 0)
-		return ret;
 
 	spi_set_drvdata(spi, indio_dev);
 
@@ -671,6 +668,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
+	ret = ad2s1210_setup_gpios(st);
+	if (ret < 0)
+		return ret;
+
 	indio_dev->info = &ad2s1210_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1210_channels;
diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 8c740c771f50..8e3fc4b78fd2 100644
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
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index b13a944eb462..f6580d11c0fe 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2584,6 +2584,7 @@ void tb_switch_remove(struct tb_switch *sw)
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
 		} else if (port->xdomain) {
+			port->xdomain->is_unplugged = true;
 			tb_xdomain_remove(port->xdomain);
 			port->xdomain = NULL;
 		}
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 4e4a71307d63..c494b77e6749 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1757,6 +1757,9 @@ static const struct usb_device_id acm_ids[] = {
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
index 366c09521785..d93a02e6050b 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -667,6 +667,7 @@ static int add_power_attributes(struct device *dev)
 
 static void remove_power_attributes(struct device *dev)
 {
+	sysfs_unmerge_group(&dev->kobj, &usb3_hardware_lpm_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &usb2_hardware_lpm_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &power_attr_group);
 }
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7275bff857ae..ee7682faa6f3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -430,6 +430,13 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
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
@@ -451,6 +458,9 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
+	if (!dwc->ev_buf)
+		return 0;
+
 	evt = dwc->ev_buf;
 	evt->lpos = 0;
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
@@ -467,6 +477,17 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
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
index efaf0db595f4..6b59bbb22da4 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -522,11 +522,13 @@ static int dwc3_omap_probe(struct platform_device *pdev)
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
index e733be840545..e0ab69bdddbe 100644
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
@@ -269,7 +266,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	if (!child_pdev) {
 		dev_err(dev, "failed to find dwc3 core device\n");
 		ret = -ENODEV;
-		goto err_node_put;
+		goto depopulate;
 	}
 
 	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
@@ -285,6 +282,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	ret = st_dwc3_drd_init(dwc3_data);
 	if (ret) {
 		dev_err(dev, "drd initialisation failed\n");
+		of_platform_depopulate(dev);
 		goto undo_softreset;
 	}
 
@@ -294,14 +292,14 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dwc3_data);
 	return 0;
 
+depopulate:
+	of_platform_depopulate(dev);
 err_node_put:
 	of_node_put(child);
 undo_softreset:
 	reset_control_assert(dwc3_data->rstc_rst);
 undo_powerdown:
 	reset_control_assert(dwc3_data->rstc_pwrdn);
-undo_platform_dev_alloc:
-	platform_device_put(pdev);
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index ad6ff9c4188e..3986e0639f05 100644
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
index b069fe3f8ab0..19914d08fc0d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2826,7 +2826,7 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
 				xhci->num_active_eps);
 		return -ENOMEM;
 	}
-	if ((xhci->quirks & XHCI_SW_BW_CHECKING) &&
+	if ((xhci->quirks & XHCI_SW_BW_CHECKING) && !ctx_change &&
 	    xhci_reserve_bandwidth(xhci, virt_dev, command->in_ctx)) {
 		if ((xhci->quirks & XHCI_EP_LIMIT_QUIRK))
 			xhci_free_host_resources(xhci, ctrl_ctx);
@@ -4242,8 +4242,10 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
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
index 73d97f7bf15b..c9fade980f36 100644
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
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ccc4c6d8a578..11dc833ca2c4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -186,6 +186,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	unsigned char k_rand_bytes[16];
 	int items;
 	elf_addr_t *elf_info;
+	elf_addr_t flags = 0;
 	int ei_index;
 	const struct cred *cred = current_cred();
 	struct vm_area_struct *vma;
@@ -260,7 +261,9 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	NEW_AUX_ENT(AT_FLAGS, 0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
+		flags |= AT_FLAGS_PRESERVE_ARGV0;
+	NEW_AUX_ENT(AT_FLAGS, flags);
 	NEW_AUX_ENT(AT_ENTRY, e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 48bb1290ed2f..a3bf15dafab7 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -320,7 +320,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	else
 		executable_stack = EXSTACK_DEFAULT;
 
-	if (stack_size == 0) {
+	if (stack_size == 0 && interp_params.flags & ELF_FDPIC_FLAG_PRESENT) {
 		stack_size = interp_params.stack_size;
 		if (interp_params.flags & ELF_FDPIC_FLAG_EXEC_STACK)
 			executable_stack = EXSTACK_ENABLE_X;
@@ -506,6 +506,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	char __user *u_platform, *u_base_platform, *p;
 	int loop;
 	int nr;	/* reset for each csp adjustment */
+	unsigned long flags = 0;
 
 #ifdef CONFIG_MMU
 	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
@@ -648,7 +649,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	NEW_AUX_ENT(AT_FLAGS,	0);
+	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
+		flags |= AT_FLAGS_PRESERVE_ARGV0;
+	NEW_AUX_ENT(AT_FLAGS,	flags);
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
 	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index ce0047feea72..740dac1012ae 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -60,12 +60,11 @@ typedef struct {
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
@@ -82,19 +81,23 @@ static int entry_count;
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
 
@@ -123,9 +126,49 @@ static Node *check_file(struct linux_binprm *bprm)
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
@@ -139,12 +182,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
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
 
@@ -153,7 +191,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
 		goto ret;
 
-	if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
+	if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
+		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
+	} else {
 		retval = remove_arg_zero(bprm);
 		if (retval)
 			goto ret;
@@ -196,7 +236,16 @@ static int load_misc_binary(struct linux_binprm *bprm)
 
 	retval = 0;
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
 }
 
@@ -551,30 +600,90 @@ static struct inode *bm_get_inode(struct super_block *sb, int mode)
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
@@ -601,8 +710,8 @@ bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
 {
-	struct dentry *root;
-	Node *e = file_inode(file)->i_private;
+	struct inode *inode = file_inode(file);
+	Node *e = inode->i_private;
 	int res = parse_command(buffer, count);
 
 	switch (res) {
@@ -616,13 +725,22 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
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
@@ -681,13 +799,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
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
@@ -731,7 +843,8 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		size_t count, loff_t *ppos)
 {
 	int res = parse_command(buffer, count);
-	struct dentry *root;
+	Node *e, *next;
+	struct inode *inode;
 
 	switch (res) {
 	case 1:
@@ -744,13 +857,22 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
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
index cdfc791b3c40..e2afaa70ae5e 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -986,7 +986,7 @@ static void btrfs_release_delayed_inode(struct btrfs_delayed_node *delayed_node)
 
 	if (delayed_node &&
 	    test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
-		BUG_ON(!delayed_node->root);
+		ASSERT(delayed_node->root);
 		clear_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags);
 		delayed_node->count--;
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index af52c9e005b3..a779965d2990 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1755,9 +1755,9 @@ static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 	ctl->free_space -= bytes;
 }
 
-static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
-			    struct btrfs_free_space *info, u64 offset,
-			    u64 bytes)
+static void btrfs_bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
+				  struct btrfs_free_space *info, u64 offset,
+				  u64 bytes)
 {
 	unsigned long start, count, end;
 	int extent_delta = 1;
@@ -2077,7 +2077,7 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 
 	bytes_to_set = min(end - offset, bytes);
 
-	bitmap_set_bits(ctl, info, offset, bytes_to_set);
+	btrfs_bitmap_set_bits(ctl, info, offset, bytes_to_set);
 
 	/*
 	 * We set some bytes, we have no idea what the max extent size is
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1f99d7dced17..4bf28f74605f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3918,7 +3918,14 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
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
index 83d17f22335b..7518ab3b409c 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2658,8 +2658,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (nr_old_roots == 0 && nr_new_roots == 0)
 		goto out_free;
 
-	BUG_ON(!fs_info->quota_root);
-
 	trace_btrfs_qgroup_account_extent(fs_info, trans->transid, bytenr,
 					num_bytes, nr_old_roots, nr_new_roots);
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index a5ed01d49f06..a9e72f42e91e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -685,7 +685,12 @@ static int begin_cmd(struct send_ctx *sctx, int cmd)
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
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 5b952f69bc1f..2b0fc0c30f36 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1546,6 +1546,72 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	return 0;
 }
 
+static int check_dev_extent_item(const struct extent_buffer *leaf,
+				 const struct btrfs_key *key,
+				 int slot,
+				 struct btrfs_key *prev_key)
+{
+	struct btrfs_dev_extent *de;
+	const u32 sectorsize = leaf->fs_info->sectorsize;
+
+	de = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
+	/* Basic fixed member checks. */
+	if (unlikely(btrfs_dev_extent_chunk_tree(leaf, de) !=
+		     BTRFS_CHUNK_TREE_OBJECTID)) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk tree id, has %llu expect %llu",
+			    btrfs_dev_extent_chunk_tree(leaf, de),
+			    BTRFS_CHUNK_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_dev_extent_chunk_objectid(leaf, de) !=
+		     BTRFS_FIRST_CHUNK_TREE_OBJECTID)) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk objectid, has %llu expect %llu",
+			    btrfs_dev_extent_chunk_objectid(leaf, de),
+			    BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	/* Alignment check. */
+	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent key.offset, has %llu not aligned to %u",
+			    key->offset, sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_chunk_offset(leaf, de),
+				 sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk offset, has %llu not aligned to %u",
+			    btrfs_dev_extent_chunk_objectid(leaf, de),
+			    sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_length(leaf, de),
+				 sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent length, has %llu not aligned to %u",
+			    btrfs_dev_extent_length(leaf, de), sectorsize);
+		return -EUCLEAN;
+	}
+	/* Overlap check with previous dev extent. */
+	if (slot && prev_key->objectid == key->objectid &&
+	    prev_key->type == key->type) {
+		struct btrfs_dev_extent *prev_de;
+		u64 prev_len;
+
+		prev_de = btrfs_item_ptr(leaf, slot - 1, struct btrfs_dev_extent);
+		prev_len = btrfs_dev_extent_length(leaf, prev_de);
+		if (unlikely(prev_key->offset + prev_len > key->offset)) {
+			generic_err(leaf, slot,
+		"dev extent overlap, prev offset %llu len %llu current offset %llu",
+				    prev_key->objectid, prev_len, key->offset);
+			return -EUCLEAN;
+		}
+	}
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -1581,6 +1647,9 @@ static int check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_DEV_ITEM_KEY:
 		ret = check_dev_item(leaf, key, slot);
 		break;
+	case BTRFS_DEV_EXTENT_KEY:
+		ret = check_dev_extent_item(leaf, key, slot, prev_key);
+		break;
 	case BTRFS_INODE_ITEM_KEY:
 		ret = check_inode_item(leaf, key, slot);
 		break;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9e1259272791..f5fa9d542d64 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3399,9 +3399,10 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	struct ext4_extent *ex, *abut_ex;
 	ext4_lblk_t ee_block, eof_block;
 	unsigned int ee_len, depth, map_len = map->m_len;
-	int allocated = 0, max_zeroout = 0;
 	int err = 0;
 	int split_flag = EXT4_EXT_DATA_VALID2;
+	int allocated = 0;
+	unsigned int max_zeroout = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)map->m_lblk, map_len);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index bc5db22df9fe..7cbbcee225dd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5955,6 +5955,9 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 	bool set_trimmed = false;
 	void *bitmap;
 
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		return 0;
+
 	last = ext4_last_grp_cluster(sb, e4b->bd_group);
 	bitmap = e4b->bd_bitmap;
 	if (start == 0 && max >= last)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 134a78179e6f..6fcc83637b15 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2215,6 +2215,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 #endif
 
 	segno = GET_SEGNO(sbi, blkaddr);
+	if (segno == NULL_SEGNO)
+		return;
 
 	se = get_seg_entry(sbi, segno);
 	new_vblocks = se->valid_blocks + del;
@@ -3391,8 +3393,7 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	 * since SSR needs latest valid block information.
 	 */
 	update_sit_entry(sbi, *new_blkaddr, 1);
-	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
-		update_sit_entry(sbi, old_blkaddr, -1);
+	update_sit_entry(sbi, old_blkaddr, -1);
 
 	if (!__has_curseg_space(sbi, curseg)) {
 		if (from_gc)
diff --git a/fs/file.c b/fs/file.c
index 105a084b7924..40a7fc127f37 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -46,27 +46,23 @@ static void free_fdtable_rcu(struct rcu_head *rcu)
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
@@ -84,7 +80,7 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
 	memcpy(nfdt->fd, ofdt->fd, cpy);
 	memset((char *)nfdt->fd + cpy, 0, set);
 
-	copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds);
+	copy_fd_bitmaps(nfdt, ofdt, fdt_words(ofdt));
 }
 
 /*
@@ -374,7 +370,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 		open_files = sane_fdtable_size(old_fdt, max_fds);
 	}
 
-	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
+	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
 
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8ac91ba05d6d..e6cbed7aedcb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1627,9 +1627,11 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
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
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 7d4655022afc..c50999ad9f7a 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -315,6 +315,16 @@ static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
 		return -ENOMEM;
 	memcpy(fs->tag, tag_buf, len);
 	fs->tag[len] = '\0';
+
+	/* While the VIRTIO specification allows any character, newlines are
+	 * awkward on mount(8) command-lines and cause problems in the sysfs
+	 * "tag" attr and uevent TAG= properties. Forbid them.
+	 */
+	if (strchr(fs->tag, '\n')) {
+		dev_dbg(&vdev->dev, "refusing virtiofs tag with newline character\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index d75d56d9ea0c..22905a076a6a 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1905,7 +1905,7 @@ static int setattr_chown(struct inode *inode, struct iattr *attr)
 	kuid_t ouid, nuid;
 	kgid_t ogid, ngid;
 	int error;
-	struct gfs2_alloc_parms ap;
+	struct gfs2_alloc_parms ap = {};
 
 	ouid = inode->i_uid;
 	ogid = inode->i_gid;
diff --git a/fs/inode.c b/fs/inode.c
index 5c7139aa2bda..de7a63c24c5d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -453,6 +453,39 @@ static void inode_lru_list_del(struct inode *inode)
 		this_cpu_dec(nr_unused);
 }
 
+static void inode_pin_lru_isolating(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	inode->i_state |= I_LRU_ISOLATING;
+}
+
+static void inode_unpin_lru_isolating(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
+	inode->i_state &= ~I_LRU_ISOLATING;
+	smp_mb();
+	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
+	spin_unlock(&inode->i_lock);
+}
+
+static void inode_wait_for_lru_isolating(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	if (inode->i_state & I_LRU_ISOLATING) {
+		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
+		wait_queue_head_t *wqh;
+
+		wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
+		spin_unlock(&inode->i_lock);
+		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
+		spin_lock(&inode->i_lock);
+		WARN_ON(inode->i_state & I_LRU_ISOLATING);
+	}
+	spin_unlock(&inode->i_lock);
+}
+
 /**
  * inode_sb_list_add - add inode to the superblock list of inodes
  * @inode: inode to add
@@ -565,6 +598,8 @@ static void evict(struct inode *inode)
 
 	inode_sb_list_del(inode);
 
+	inode_wait_for_lru_isolating(inode);
+
 	/*
 	 * Wait for flusher thread to be done with the inode so that filesystem
 	 * does not start destroying it while writeback is still running. Since
@@ -764,7 +799,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	}
 
 	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
-		__iget(inode);
+		inode_pin_lru_isolating(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(lru_lock);
 		if (remove_inode_buffers(inode)) {
@@ -777,7 +812,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 			if (current->reclaim_state)
 				current->reclaim_state->reclaimed_slab += reap;
 		}
-		iput(inode);
+		inode_unpin_lru_isolating(inode);
 		spin_lock(lru_lock);
 		return LRU_RETRY;
 	}
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index ed6a3ed83755..f2da20ce6875 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2000,6 +2000,14 @@ pnfs_update_layout(struct inode *ino,
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
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 244e4258ce16..4440ff43cb66 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -53,9 +53,10 @@ static struct file *ovl_open_realfile(const struct file *file,
 	err = inode_permission(realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
-		realfile = ERR_PTR(-EPERM);
 	} else {
+		if (!inode_owner_or_capable(realinode))
+			flags &= ~O_NOATIME;
+
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
 					       current_cred());
 	}
@@ -75,12 +76,6 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	struct inode *inode = file_inode(file);
 	int err;
 
-	flags |= OVL_OPEN_FLAGS;
-
-	/* If some flag changed that cannot be changed then something's amiss */
-	if (WARN_ON((file->f_flags ^ flags) & ~OVL_SETFL_MASK))
-		return -EIO;
-
 	flags &= OVL_SETFL_MASK;
 
 	if (((flags ^ file->f_flags) & O_APPEND) && IS_APPEND(inode))
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6a7b7d44753a..9b8babbd1653 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -997,9 +997,8 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
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
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 5a9786e6b554..c26ce73dcb08 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -73,6 +73,10 @@ struct linux_binprm {
 #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
 #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
 
+/* preserve argv0 for the interpreter  */
+#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
+#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
+
 /* Function parameter for binfmt->coredump */
 struct coredump_params {
 	const kernel_siginfo_t *siginfo;
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index c4f6a9270c03..29b19d2ba5ba 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -240,22 +240,24 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
 #define small_const_nbits(nbits) \
 	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
 
+#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
+
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = bitmap_size(nbits);
 	memset(dst, 0, len);
 }
 
 static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = bitmap_size(nbits);
 	memset(dst, 0xff, len);
 }
 
 static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = bitmap_size(nbits);
 	memcpy(dst, src, len);
 }
 
@@ -270,6 +272,18 @@ static inline void bitmap_copy_clear_tail(unsigned long *dst,
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
index a47e1aebaff2..e5f11dae208d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -59,7 +59,7 @@ struct blk_keyslot_manager;
  */
 #define BLKCG_MAX_POLS		5
 
-static inline int blk_validate_block_size(unsigned int bsize)
+static inline int blk_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f0d895d6ac39..bb29102ec966 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -690,7 +690,7 @@ static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
  */
 static inline unsigned int cpumask_size(void)
 {
-	return BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long);
+	return bitmap_size(nr_cpumask_bits);
 }
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6a26ef54ac25..2e202f01c38d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2249,6 +2249,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *			Used to detect that mark_inode_dirty() should not move
  * 			inode between dirty lists.
  *
+ * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
+ *			i_count.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2271,6 +2274,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_CREATING		(1 << 15)
 #define I_DONTCACHE		(1 << 16)
 #define I_SYNC_QUEUED		(1 << 17)
+#define __I_LRU_ISOLATING	19
+#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 36e5e75e7172..be01eda3b6ff 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -61,7 +61,7 @@ static inline bool sk_can_busy_loop(struct sock *sk)
 static inline unsigned long busy_loop_current_time(void)
 {
 #ifdef CONFIG_NET_RX_BUSY_POLL
-	return (unsigned long)(local_clock() >> 10);
+	return (unsigned long)(ktime_get_ns() >> 10);
 #else
 	return 0;
 #endif
diff --git a/include/net/kcm.h b/include/net/kcm.h
index 2d704f8f4905..8e8252e08a9c 100644
--- a/include/net/kcm.h
+++ b/include/net/kcm.h
@@ -70,6 +70,7 @@ struct kcm_sock {
 	struct work_struct tx_work;
 	struct list_head wait_psock_list;
 	struct sk_buff *seq_skb;
+	struct mutex tx_mutex;
 	u32 tx_stopped : 1;
 
 	/* Don't use bit fields here, these are set under different locks */
diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
index 689025d9c185..c6f9450efc12 100644
--- a/include/uapi/linux/binfmts.h
+++ b/include/uapi/linux/binfmts.h
@@ -18,4 +18,8 @@ struct pt_regs;
 /* sizeof(linux_binprm->buf) */
 #define BINPRM_BUF_SIZE 256
 
+/* preserve argv0 for the interpreter  */
+#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
+#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
+
 #endif /* _UAPI_LINUX_BINFMTS_H */
diff --git a/ipc/util.c b/ipc/util.c
index bbb5190af6d9..7c3601dad9bd 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -754,21 +754,13 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
 static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 					      loff_t *new_pos)
 {
-	struct kern_ipc_perm *ipc;
-	int total, id;
-
-	total = 0;
-	for (id = 0; id < pos && total < ids->in_use; id++) {
-		ipc = idr_find(&ids->ipcs_idr, id);
-		if (ipc != NULL)
-			total++;
-	}
+	struct kern_ipc_perm *ipc = NULL;
+	int max_idx = ipc_get_maxidx(ids);
 
-	ipc = NULL;
-	if (total >= ids->in_use)
+	if (max_idx == -1 || pos > max_idx)
 		goto out;
 
-	for (; pos < ipc_mni; pos++) {
+	for (; pos <= max_idx; pos++) {
 		ipc = idr_find(&ids->ipcs_idr, pos);
 		if (ipc != NULL) {
 			rcu_read_lock();
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9f2a93c829a9..731547a0d057 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -22,6 +22,7 @@
  *  distribution for more details.
  */
 
+#include "cgroup-internal.h"
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cpuset.h>
@@ -3725,10 +3726,14 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
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
index 2b2a6e29219d..16f1e747c567 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1182,6 +1182,8 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(!timer->function))
+		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard
diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
index d42cebf7407f..d3b64b10da1c 100644
--- a/lib/math/prime_numbers.c
+++ b/lib/math/prime_numbers.c
@@ -6,8 +6,6 @@
 #include <linux/prime_numbers.h>
 #include <linux/slab.h>
 
-#define bitmap_size(nbits) (BITS_TO_LONGS(nbits) * sizeof(unsigned long))
-
 struct primes {
 	struct rcu_head rcu;
 	unsigned long last, sz;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 186ae9dba0fd..874f91715296 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4884,9 +4884,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
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
index 09b6d825124e..f74990427296 100644
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
index c8c1cd55c0eb..9787a4c55113 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4685,19 +4685,19 @@ static void hci_sched_le(struct hci_dev *hdev)
 {
 	struct hci_chan *chan;
 	struct sk_buff *skb;
-	int quote, cnt, tmp;
+	int quote, *cnt, tmp;
 
 	BT_DBG("%s", hdev->name);
 
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
+	cnt = hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
 
-	__check_timeout(hdev, cnt, LE_LINK);
+	__check_timeout(hdev, *cnt, LE_LINK);
 
-	tmp = cnt;
-	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
+	tmp = *cnt;
+	while (*cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
@@ -4712,7 +4712,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 			hci_send_frame(hdev, skb);
 			hdev->le_last_tx = jiffies;
 
-			cnt--;
+			(*cnt)--;
 			chan->sent++;
 			chan->conn->sent++;
 
@@ -4722,12 +4722,7 @@ static void hci_sched_le(struct hci_dev *hdev)
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
index bd8cfcfca7ae..0078e33e12ba 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2962,6 +2962,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * will be kept and this function does nothing.
 		 */
 		p = hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
+		if (!p) {
+			err = -EIO;
+			goto unlock;
+		}
 
 		if (p->auto_connect == HCI_AUTO_CONN_EXPLICIT)
 			p->auto_connect = HCI_AUTO_CONN_DISABLED;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 27381e7425a8..20cae8f76876 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -914,7 +914,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	 * Confirms and the responder Enters the passkey.
 	 */
 	if (smp->method == OVERLAP) {
-		if (hcon->role == HCI_ROLE_MASTER)
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp->method = CFM_PASSKEY;
 		else
 			smp->method = REQ_PASSKEY;
@@ -964,7 +964,7 @@ static u8 smp_confirm(struct smp_chan *smp)
 
 	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 
-	if (conn->hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 	else
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -980,7 +980,8 @@ static u8 smp_random(struct smp_chan *smp)
 	int ret;
 
 	bt_dev_dbg(conn->hcon->hdev, "conn %p %s", conn,
-		   conn->hcon->out ? "initiator" : "responder");
+		   test_bit(SMP_FLAG_INITIATOR, &smp->flags) ? "initiator" :
+		   "responder");
 
 	ret = smp_c1(smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
@@ -994,7 +995,7 @@ static u8 smp_random(struct smp_chan *smp)
 		return SMP_CONFIRM_FAILED;
 	}
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		u8 stk[16];
 		__le64 rand = 0;
 		__le16 ediv = 0;
@@ -1251,14 +1252,15 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
-	if (hcon->out && (smp->remote_key_dist & KEY_DIST_MASK)) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags) &&
+	    (smp->remote_key_dist & KEY_DIST_MASK)) {
 		smp_allow_key_dist(smp);
 		return;
 	}
 
 	req = (void *) &smp->preq[1];
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		keydist = &rsp->init_key_dist;
 		*keydist &= req->init_key_dist;
 	} else {
@@ -1427,7 +1429,7 @@ static int sc_mackey_and_ltk(struct smp_chan *smp, u8 mackey[16], u8 ltk[16])
 	struct hci_conn *hcon = smp->conn->hcon;
 	u8 *na, *nb, a[7], b[7];
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		na   = smp->prnd;
 		nb   = smp->rrnd;
 	} else {
@@ -1455,7 +1457,7 @@ static void sc_dhkey_check(struct smp_chan *smp)
 	a[6] = hcon->init_addr_type;
 	b[6] = hcon->resp_addr_type;
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local_addr = a;
 		remote_addr = b;
 		memcpy(io_cap, &smp->preq[1], 3);
@@ -1534,7 +1536,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 		/* The round is only complete when the initiator
 		 * receives pairing random.
 		 */
-		if (!hcon->out) {
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 			if (smp->passkey_round == 20)
@@ -1562,7 +1564,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
 
-		if (hcon->out) {
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 			return 0;
@@ -1573,7 +1575,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 	case SMP_CMD_PUBLIC_KEY:
 	default:
 		/* Initiating device starts the round */
-		if (!hcon->out)
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			return 0;
 
 		bt_dev_dbg(hdev, "Starting passkey round %u",
@@ -1618,7 +1620,7 @@ static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
 	}
 
 	/* Initiator sends DHKey check first */
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		sc_dhkey_check(smp);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 	} else if (test_and_clear_bit(SMP_FLAG_DHKEY_PENDING, &smp->flags)) {
@@ -1741,7 +1743,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct hci_dev *hdev = conn->hcon->hdev;
-	struct smp_chan *smp;
+	struct smp_chan *smp = chan->data;
 	u8 key_size, auth, sec_level;
 	int ret;
 
@@ -1750,16 +1752,14 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*req))
 		return SMP_INVALID_PARAMS;
 
-	if (conn->hcon->role != HCI_ROLE_SLAVE)
+	if (smp && test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_CMD_NOTSUPP;
 
-	if (!chan->data)
+	if (!smp) {
 		smp = smp_chan_create(conn);
-	else
-		smp = chan->data;
-
-	if (!smp)
-		return SMP_UNSPECIFIED;
+		if (!smp)
+			return SMP_UNSPECIFIED;
+	}
 
 	/* We didn't start the pairing, so match remote */
 	auth = req->auth_req & AUTH_REQ_MASK(hdev);
@@ -1941,7 +1941,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rsp))
 		return SMP_INVALID_PARAMS;
 
-	if (conn->hcon->role != HCI_ROLE_MASTER)
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_CMD_NOTSUPP;
 
 	skb_pull(skb, sizeof(*rsp));
@@ -2036,7 +2036,7 @@ static u8 sc_check_confirm(struct smp_chan *smp)
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_CONFIRM);
 
-	if (conn->hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -2058,7 +2058,7 @@ static int fixup_sc_false_positive(struct smp_chan *smp)
 	u8 auth;
 
 	/* The issue is only observed when we're in responder role */
-	if (hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_UNSPECIFIED;
 
 	if (hci_dev_test_flag(hdev, HCI_SC_ONLY)) {
@@ -2094,7 +2094,8 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct hci_dev *hdev = hcon->hdev;
 
 	bt_dev_dbg(hdev, "conn %p %s", conn,
-		   hcon->out ? "initiator" : "responder");
+		   test_bit(SMP_FLAG_INITIATOR, &smp->flags) ? "initiator" :
+		   "responder");
 
 	if (skb->len < sizeof(smp->pcnf))
 		return SMP_INVALID_PARAMS;
@@ -2116,7 +2117,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 			return ret;
 	}
 
-	if (conn->hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -2151,7 +2152,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_SC, &smp->flags))
 		return smp_random(smp);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		pkax = smp->local_pk;
 		pkbx = smp->remote_pk;
 		na   = smp->prnd;
@@ -2164,7 +2165,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (smp->method == REQ_OOB) {
-		if (!hcon->out)
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
@@ -2175,7 +2176,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_RANDOM);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		u8 cfm[16];
 
 		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->local_pk,
@@ -2216,7 +2217,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_UNSPECIFIED;
 
 	if (smp->method == REQ_OOB) {
-		if (hcon->out) {
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			sc_dhkey_check(smp);
 			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 		}
@@ -2290,10 +2291,27 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
 	return false;
 }
 
+static void smp_send_pairing_req(struct smp_chan *smp, __u8 auth)
+{
+	struct smp_cmd_pairing cp;
+
+	if (smp->conn->hcon->type == ACL_LINK)
+		build_bredr_pairing_cmd(smp, &cp, NULL);
+	else
+		build_pairing_cmd(smp->conn, &cp, NULL, auth);
+
+	smp->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&smp->preq[1], &cp, sizeof(cp));
+
+	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+
+	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
+}
+
 static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_security_req *rp = (void *) skb->data;
-	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	struct smp_chan *smp;
@@ -2342,16 +2360,20 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	memset(&cp, 0, sizeof(cp));
-	build_pairing_cmd(conn, &cp, NULL, auth);
+	smp_send_pairing_req(smp, auth);
 
-	smp->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&smp->preq[1], &cp, sizeof(cp));
+	return 0;
+}
 
-	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
-	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+static void smp_send_security_req(struct smp_chan *smp, __u8 auth)
+{
+	struct smp_cmd_security_req cp;
 
-	return 0;
+	cp.auth_req = auth;
+	smp_send_cmd(smp->conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
+
+	clear_bit(SMP_FLAG_INITIATOR, &smp->flags);
 }
 
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
@@ -2422,23 +2444,11 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 			authreq |= SMP_AUTH_MITM;
 	}
 
-	if (hcon->role == HCI_ROLE_MASTER) {
-		struct smp_cmd_pairing cp;
-
-		build_pairing_cmd(conn, &cp, NULL, authreq);
-		smp->preq[0] = SMP_CMD_PAIRING_REQ;
-		memcpy(&smp->preq[1], &cp, sizeof(cp));
-
-		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
-		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
-	} else {
-		struct smp_cmd_security_req cp;
-		cp.auth_req = authreq;
-		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
-		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
-	}
+	if (hcon->role == HCI_ROLE_MASTER)
+		smp_send_pairing_req(smp, authreq);
+	else
+		smp_send_security_req(smp, authreq);
 
-	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
 	ret = 0;
 
 unlock:
@@ -2689,8 +2699,6 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 sc_select_method(struct smp_chan *smp)
 {
-	struct l2cap_conn *conn = smp->conn;
-	struct hci_conn *hcon = conn->hcon;
 	struct smp_cmd_pairing *local, *remote;
 	u8 local_mitm, remote_mitm, local_io, remote_io, method;
 
@@ -2703,7 +2711,7 @@ static u8 sc_select_method(struct smp_chan *smp)
 	 * the "struct smp_cmd_pairing" from them we need to skip the
 	 * first byte which contains the opcode.
 	 */
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local = (void *) &smp->preq[1];
 		remote = (void *) &smp->prsp[1];
 	} else {
@@ -2772,7 +2780,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* Non-initiating device sends its public key after receiving
 	 * the key from the initiating device.
 	 */
-	if (!hcon->out) {
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		err = sc_send_public_key(smp);
 		if (err)
 			return err;
@@ -2834,7 +2842,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (smp->method == REQ_OOB) {
-		if (hcon->out)
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 
@@ -2843,7 +2851,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 		return 0;
 	}
 
-	if (hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 
 	if (smp->method == REQ_PASSKEY) {
@@ -2858,7 +2866,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* The Initiating device waits for the non-initiating device to
 	 * send the confirm value.
 	 */
-	if (conn->hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return 0;
 
 	err = smp_f4(smp->tfm_cmac, smp->local_pk, smp->remote_pk, smp->prnd,
@@ -2892,7 +2900,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	a[6] = hcon->init_addr_type;
 	b[6] = hcon->resp_addr_type;
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local_addr = a;
 		remote_addr = b;
 		memcpy(io_cap, &smp->prsp[1], 3);
@@ -2917,7 +2925,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (crypto_memneq(check->e, e, 16))
 		return SMP_DHKEY_CHECK_FAILED;
 
-	if (!hcon->out) {
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		if (test_bit(SMP_FLAG_WAIT_USER, &smp->flags)) {
 			set_bit(SMP_FLAG_DHKEY_PENDING, &smp->flags);
 			return 0;
@@ -2929,7 +2937,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	sc_add_ltk(smp);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		hci_le_start_enc(hcon, 0, 0, smp->tk, smp->enc_key_size);
 		hcon->enc_key_size = smp->enc_key_size;
 	}
@@ -3078,7 +3086,6 @@ static void bredr_pairing(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
-	struct smp_cmd_pairing req;
 	struct smp_chan *smp;
 
 	bt_dev_dbg(hdev, "chan %p", chan);
@@ -3130,14 +3137,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 
 	bt_dev_dbg(hdev, "starting SMP over BR/EDR");
 
-	/* Prepare and send the BR/EDR SMP Pairing Request */
-	build_bredr_pairing_cmd(smp, &req, NULL);
-
-	smp->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&smp->preq[1], &req, sizeof(req));
-
-	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(req), &req);
-	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+	smp_send_pairing_req(smp, 0x00);
 }
 
 static void smp_resume_cb(struct l2cap_chan *chan)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 989b3f7ee85f..99303897b7bb 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -213,7 +213,7 @@ static ssize_t speed_show(struct device *dev,
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	if (netif_running(netdev) && netif_device_present(netdev)) {
+	if (netif_running(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
 		if (!__ethtool_get_link_ksettings(netdev, &cmd))
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 12bf740e2fb3..0a588545d352 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -432,6 +432,9 @@ int __ethtool_get_link_ksettings(struct net_device *dev,
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
+	if (!netif_device_present(dev))
+		return -ENODEV;
+
 	memset(link_ksettings, 0, sizeof(*link_ksettings));
 	return dev->ethtool_ops->get_link_ksettings(dev, link_ksettings);
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 32512b8ca5e7..436733021b1e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1952,6 +1952,7 @@ int ip6_send_skb(struct sk_buff *skb)
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	int err;
 
+	rcu_read_lock();
 	err = ip6_local_out(net, skb->sk, skb);
 	if (err) {
 		if (err > 0)
@@ -1961,6 +1962,7 @@ int ip6_send_skb(struct sk_buff *skb)
 				      IPSTATS_MIB_OUTDISCARDS);
 	}
 
+	rcu_read_unlock();
 	return err;
 }
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d1f819238414..bd27204725ed 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1531,7 +1531,8 @@ static void ip6_tnl_link_config(struct ip6_tnl *t)
 			tdev = __dev_get_by_index(t->net, p->link);
 
 		if (tdev) {
-			dev->hard_header_len = tdev->hard_header_len + t_hlen;
+			dev->needed_headroom = tdev->hard_header_len +
+				tdev->needed_headroom + t_hlen;
 			mtu = min_t(unsigned int, tdev->mtu, IP6_MAX_MTU);
 
 			mtu = mtu - t_hlen;
@@ -1758,7 +1759,9 @@ ip6_tnl_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct ip6_tnl *tnl = netdev_priv(dev);
+	int t_hlen;
 
+	t_hlen = tnl->hlen + sizeof(struct ipv6hdr);
 	if (tnl->parms.proto == IPPROTO_IPV6) {
 		if (new_mtu < IPV6_MIN_MTU)
 			return -EINVAL;
@@ -1767,10 +1770,10 @@ int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
 			return -EINVAL;
 	}
 	if (tnl->parms.proto == IPPROTO_IPV6 || tnl->parms.proto == 0) {
-		if (new_mtu > IP6_MAX_MTU - dev->hard_header_len)
+		if (new_mtu > IP6_MAX_MTU - dev->hard_header_len - t_hlen)
 			return -EINVAL;
 	} else {
-		if (new_mtu > IP_MAX_MTU - dev->hard_header_len)
+		if (new_mtu > IP_MAX_MTU - dev->hard_header_len - t_hlen)
 			return -EINVAL;
 	}
 	dev->mtu = new_mtu;
@@ -1916,12 +1919,11 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	t_hlen = t->hlen + sizeof(struct ipv6hdr);
 
 	dev->type = ARPHRD_TUNNEL6;
-	dev->hard_header_len = LL_MAX_HEADER + t_hlen;
 	dev->mtu = ETH_DATA_LEN - t_hlen;
 	if (!(t->parms.flags & IP6_TNL_F_IGN_ENCAP_LIMIT))
 		dev->mtu -= 8;
 	dev->min_mtu = ETH_MIN_MTU;
-	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len;
+	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len - t_hlen;
 
 	dev_hold(dev);
 	return 0;
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 06770b77e5d2..be5f598acbce 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -1088,8 +1088,7 @@ static int iucv_message_receive_iprmdata(struct iucv_path *path,
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
index 7420b4f19b45..2f2840aa4a81 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -911,6 +911,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		  !(msg->msg_flags & MSG_MORE) : !!(msg->msg_flags & MSG_EOR);
 	int err = -EPIPE;
 
+	mutex_lock(&kcm->tx_mutex);
 	lock_sock(sk);
 
 	/* Per tcp_sendmsg this should be in poll */
@@ -1059,6 +1060,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	KCM_STATS_ADD(kcm->stats.tx_bytes, copied);
 
 	release_sock(sk);
+	mutex_unlock(&kcm->tx_mutex);
 	return copied;
 
 out_error:
@@ -1084,6 +1086,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		sk->sk_write_space(sk);
 
 	release_sock(sk);
+	mutex_unlock(&kcm->tx_mutex);
 	return err;
 }
 
@@ -1326,6 +1329,7 @@ static void init_kcm_sock(struct kcm_sock *kcm, struct kcm_mux *mux)
 	spin_unlock_bh(&mux->lock);
 
 	INIT_WORK(&kcm->tx_work, kcm_tx_work);
+	mutex_init(&kcm->tx_mutex);
 
 	spin_lock_bh(&mux->rx_lock);
 	kcm_rcv_ready(kcm);
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 92e5812daf89..4b4ab1961068 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -491,7 +491,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 {
 	struct tid_ampdu_tx *tid_tx;
 	struct ieee80211_local *local = sta->local;
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_ampdu_params params = {
 		.sta = &sta->sta,
 		.action = IEEE80211_AMPDU_TX_START,
@@ -521,7 +521,6 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 	 */
 	synchronize_net();
 
-	sdata = sta->sdata;
 	params.ssn = sta->tid_seq[tid] >> 4;
 	ret = drv_ampdu_action(local, sdata, &params);
 	tid_tx->ssn = params.ssn;
@@ -535,9 +534,6 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 		 */
 		set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state);
 	} else if (ret) {
-		if (!sdata)
-			return;
-
 		ht_dbg(sdata,
 		       "BA request denied - HW unavailable for %pM tid %d\n",
 		       sta->sta.addr, tid);
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 120bd9cdf7df..48322e45e7dd 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -331,9 +331,6 @@ int drv_ampdu_action(struct ieee80211_local *local,
 
 	might_sleep();
 
-	if (!sdata)
-		return -EIO;
-
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f7637176d719..3bb7a3314788 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1064,6 +1064,20 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 	 *	 after _part1 and before _part2!
 	 */
 
+	/*
+	 * There's a potential race in _part1 where we set WLAN_STA_BLOCK_BA
+	 * but someone might have just gotten past a check, and not yet into
+	 * queuing the work/creating the data/etc.
+	 *
+	 * Do another round of destruction so that the worker is certainly
+	 * canceled before we later free the station.
+	 *
+	 * Since this is after synchronize_rcu()/synchronize_net() we're now
+	 * certain that nobody can actually hold a reference to the STA and
+	 * be calling e.g. ieee80211_start_tx_ba_session().
+	 */
+	ieee80211_sta_tear_down_BA_sessions(sta, AGG_STOP_DESTROY_STA);
+
 	might_sleep();
 	lockdep_assert_held(&local->sta_mtx);
 
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index d7ca71c59754..23bd18084c8a 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -95,7 +95,7 @@ static size_t subflow_get_info_size(const struct sock *sk)
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
 		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
-		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
 		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_FLAGS */
 		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_REM */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a343b3077458..0ef6a99b62b0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1664,7 +1664,7 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 			return NULL;
 		}
 
-		if (subflow->backup) {
+		if (subflow->backup || subflow->request_bkup) {
 			if (!backup)
 				backup = ssk;
 			continue;
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 746ca77d0aad..f6275d93f8a5 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -682,8 +682,8 @@ static int nf_flow_offload_tuple(struct nf_flowtable *flowtable,
 				 struct list_head *block_cb_list)
 {
 	struct flow_cls_offload cls_flow = {};
+	struct netlink_ext_ack extack = {};
 	struct flow_block_cb *block_cb;
-	struct netlink_ext_ack extack;
 	__be16 proto = ETH_P_ALL;
 	int err, i = 0;
 
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index 75fa6fcd6cd6..ea102b9a168b 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -105,11 +105,16 @@ static void nft_counter_reset(struct nft_counter_percpu_priv *priv,
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
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index ac3678d2d6d5..4f2a3d46554f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -126,7 +126,7 @@ static const char *const nlk_cb_mutex_key_strings[MAX_LINKS + 1] = {
 	"nlk_cb_mutex-MAX_LINKS"
 };
 
-static int netlink_dump(struct sock *sk);
+static int netlink_dump(struct sock *sk, bool lock_taken);
 
 /* nl_table locking explained:
  * Lookup and traversal are protected with an RCU read-side lock. Insertion
@@ -1996,7 +1996,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	if (READ_ONCE(nlk->cb_running) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
-		ret = netlink_dump(sk);
+		ret = netlink_dump(sk, false);
 		if (ret) {
 			sk->sk_err = -ret;
 			sk->sk_error_report(sk);
@@ -2206,7 +2206,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	return 0;
 }
 
-static int netlink_dump(struct sock *sk)
+static int netlink_dump(struct sock *sk, bool lock_taken)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
 	struct netlink_ext_ack extack = {};
@@ -2218,7 +2218,8 @@ static int netlink_dump(struct sock *sk)
 	int alloc_min_size;
 	int alloc_size;
 
-	mutex_lock(nlk->cb_mutex);
+	if (!lock_taken)
+		mutex_lock(nlk->cb_mutex);
 	if (!nlk->cb_running) {
 		err = -EINVAL;
 		goto errout_skb;
@@ -2374,9 +2375,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	WRITE_ONCE(nlk->cb_running, true);
 	nlk->dump_done_errno = INT_MAX;
 
-	mutex_unlock(nlk->cb_mutex);
-
-	ret = netlink_dump(sk);
+	ret = netlink_dump(sk, true);
 
 	sock_put(sk);
 
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 967d115f97ef..f570d64367a4 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -424,6 +424,7 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 	struct sock *sk = rds_rs_to_sk(rs);
 	int ret = 0;
 	unsigned long flags;
+	struct rds_incoming *to_drop = NULL;
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	if (!list_empty(&inc->i_item)) {
@@ -434,11 +435,14 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
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
@@ -761,16 +765,21 @@ void rds_clear_recv_queue(struct rds_sock *rs)
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
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 08aaa6efc62c..e0e16b0fdb17 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -437,12 +437,10 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct netem_sched_data *q = qdisc_priv(sch);
 	/* We don't fill cb now as skb_unshare() may invalidate it */
 	struct netem_skb_cb *cb;
-	struct sk_buff *skb2;
+	struct sk_buff *skb2 = NULL;
 	struct sk_buff *segs = NULL;
 	unsigned int prev_len = qdisc_pkt_len(skb);
 	int count = 1;
-	int rc = NET_XMIT_SUCCESS;
-	int rc_drop = NET_XMIT_DROP;
 
 	/* Do not fool qdisc_drop_all() */
 	skb->prev = NULL;
@@ -471,19 +469,11 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		skb_orphan_partial(skb);
 
 	/*
-	 * If we need to duplicate packet, then re-insert at top of the
-	 * qdisc tree, since parent queuer expects that only one
-	 * skb will be queued.
+	 * If we need to duplicate packet, then clone it before
+	 * original is modified.
 	 */
-	if (count > 1 && (skb2 = skb_clone(skb, GFP_ATOMIC)) != NULL) {
-		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
-
-		q->duplicate = 0;
-		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
-		rc_drop = NET_XMIT_SUCCESS;
-	}
+	if (count > 1)
+		skb2 = skb_clone(skb, GFP_ATOMIC);
 
 	/*
 	 * Randomized packet corruption.
@@ -495,7 +485,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (skb_is_gso(skb)) {
 			skb = netem_segment(skb, sch, to_free);
 			if (!skb)
-				return rc_drop;
+				goto finish_segs;
+
 			segs = skb->next;
 			skb_mark_not_on_list(skb);
 			qdisc_skb_cb(skb)->pkt_len = skb->len;
@@ -521,7 +512,24 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-		return rc_drop;
+		if (skb2)
+			__qdisc_drop(skb2, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	/*
+	 * If doing duplication then re-insert at top of the
+	 * qdisc tree, since parent queuer expects that only one
+	 * skb will be queued.
+	 */
+	if (skb2) {
+		struct Qdisc *rootq = qdisc_root_bh(sch);
+		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
+
+		q->duplicate = 0;
+		rootq->enqueue(skb2, rootq, to_free);
+		q->duplicate = dupsave;
+		skb2 = NULL;
 	}
 
 	qdisc_qstats_backlog_inc(sch, skb);
@@ -592,9 +600,12 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 finish_segs:
+	if (skb2)
+		__qdisc_drop(skb2, to_free);
+
 	if (segs) {
 		unsigned int len, last_len;
-		int nb;
+		int rc, nb;
 
 		len = skb ? skb->len : 0;
 		nb = skb ? 1 : 0;
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index d1eacf3358b8..60782504ad3e 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -679,8 +679,8 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 					set_current_state(TASK_RUNNING);
 					return -EINTR;
 				}
+				freezable_schedule_timeout(msecs_to_jiffies(500));
 			}
-			freezable_schedule_timeout(msecs_to_jiffies(500));
 			rqstp->rq_pages[i] = p;
 		}
 	rqstp->rq_page_end = &rqstp->rq_pages[i];
diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 533137f45361..4951d9bef579 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -78,14 +78,14 @@ struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
 	strcpy(buf + 3, TEST_U32_NAME);
 	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
-	*((u32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = TEST_U32_DATA;
+	*((__le32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = cpu_to_le32(TEST_U32_DATA);
 
 	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
 	*buf = AA_NAME;
 	*(buf + 1) = strlen(TEST_U64_NAME) + 1;
 	strcpy(buf + 3, TEST_U64_NAME);
 	*(buf + 3 + strlen(TEST_U64_NAME) + 1) = AA_U64;
-	*((u64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = TEST_U64_DATA;
+	*((__le64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = cpu_to_le64(TEST_U64_DATA);
 
 	buf = e->start + TEST_NAMED_BLOB_BUF_OFFSET;
 	*buf = AA_NAME;
@@ -101,7 +101,7 @@ struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
 	strcpy(buf + 3, TEST_ARRAY_NAME);
 	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
-	*((u16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = TEST_ARRAY_SIZE;
+	*((__le16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = cpu_to_le16(TEST_ARRAY_SIZE);
 
 	return e;
 }
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 884a014ce2b8..ab71d0948205 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -332,12 +332,12 @@ static int avc_add_xperms_decision(struct avc_node *node,
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
index 708c9a46eefe..7e6fd86df41c 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -556,7 +556,7 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
 	/* check the actual time for the start tick;
 	 * bail out as error if it's way too low (< 100us)
 	 */
-	if (start) {
+	if (start && !(timer->hw.flags & SNDRV_TIMER_HW_SLAVE)) {
 		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000) {
 			result = -EINVAL;
 			goto unlock;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e8e9cfb4a935..04fd52bba057 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -578,7 +578,6 @@ static void alc_shutup_pins(struct hda_codec *codec)
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
-	case 0x10ec0257:
 	case 0x19e58326:
 	case 0x10ec0283:
 	case 0x10ec0285:
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 8f2fb2ac7af6..008229ae7ff4 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -273,6 +273,7 @@ YAMAHA_DEVICE(0x105a, NULL),
 YAMAHA_DEVICE(0x105b, NULL),
 YAMAHA_DEVICE(0x105c, NULL),
 YAMAHA_DEVICE(0x105d, NULL),
+YAMAHA_DEVICE(0x1718, "P-125"),
 {
 	USB_DEVICE(0x0499, 0x1503),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
new file mode 100644
index 000000000000..14e34ace80dd
--- /dev/null
+++ b/tools/include/linux/align.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TOOLS_LINUX_ALIGN_H
+#define _TOOLS_LINUX_ALIGN_H
+
+#include <uapi/linux/const.h>
+
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif /* _TOOLS_LINUX_ALIGN_H */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 477a1cae513f..de45cad6cec1 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -3,6 +3,7 @@
 #define _PERF_BITOPS_H
 
 #include <string.h>
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <stdlib.h>
 #include <linux/kernel.h>
@@ -30,13 +31,14 @@ void bitmap_clear(unsigned long *map, unsigned int start, int len);
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
 
@@ -122,7 +124,7 @@ static inline int test_and_clear_bit(int nr, unsigned long *addr)
  */
 static inline unsigned long *bitmap_alloc(int nbits)
 {
-	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
+	return calloc(1, bitmap_size(nbits));
 }
 
 /*
@@ -165,7 +167,6 @@ static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 #define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
-#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
 
 static inline int bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 0a26795842f6..506f3ab60518 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -224,4 +224,39 @@ TEST(close_range_unshare_capped)
 	EXPECT_EQ(0, WEXITSTATUS(status));
 }
 
+TEST(close_range_bitmap_corruption)
+{
+	pid_t pid;
+	int status;
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	/* get the first 128 descriptors open */
+	for (int i = 2; i < 128; i++)
+		EXPECT_GE(dup2(0, i), 0);
+
+	/* get descriptor table shared */
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* unshare and truncate descriptor table down to 64 */
+		if (sys_close_range(64, ~0U, CLOSE_RANGE_UNSHARE))
+			exit(EXIT_FAILURE);
+
+		ASSERT_EQ(fcntl(64, F_GETFD), -1);
+		/* ... and verify that the range 64..127 is not
+		   stuck "fully used" according to secondary bitmap */
+		EXPECT_EQ(dup(0), 64)
+			exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index a3e43189d940..d6a9d97f73c2 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -129,7 +129,6 @@ class PluginMgr:
             except Exception as ee:
                 print('exception {} in call to pre_case for {} plugin'.
                       format(ee, pgn_inst.__class__))
-                print('test_ordinal is {}'.format(test_ordinal))
                 print('testid is {}'.format(caseinfo['id']))
                 raise
 

