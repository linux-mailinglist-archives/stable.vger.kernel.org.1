Return-Path: <stable+bounces-124286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B557A5F460
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F1D3B746E
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE342676D2;
	Thu, 13 Mar 2025 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2dnIs/wx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7C2676D3;
	Thu, 13 Mar 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868897; cv=none; b=Hx3+JN1tKp0vp0m2THsCghA0xpNc2ukG2LrWDCiANFgbWUsSUdaVpRvTttFKV5KeEgmadXu8jrYzyudnlqaQbtZ4Xajis3Fa0WJJc7p0jIZEKYE8XUfp36+YJrmz4wpuvWFq/HsnnIOh/rEAU0CH38ZD6q5zGIz8EKAyQAbPqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868897; c=relaxed/simple;
	bh=Ug1rIAyKlaOcfTv294dqMApjCA0W98cRj7GStyCpI6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ir2SIr8H2+M8bC9tBBy1EhbJr86iwa0ZNmz5e4UHi/09hLJb8yztYgdMmWJjsQWcAj+tX8YNXqz2By+FYGSQPQ9Kol+QeEhQnwUKRxC5i4Oo686/fns4uqm1b1E9+UB1QaZ+QZnDdllNZAEcBckY1XSY6qljopYMa48BBcHOmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2dnIs/wx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E175C4CEE5;
	Thu, 13 Mar 2025 12:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741868896;
	bh=Ug1rIAyKlaOcfTv294dqMApjCA0W98cRj7GStyCpI6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2dnIs/wxz8abnqOzd0gaj1Mfwfr48ZJiOjvP2gQIhQJpT+jMCH0IACz7zAk5NXlFd
	 mCZi5Vomnr+NkOM4+lYEZMkoD1//PqLQAV4kEhYuxx8DQ0n8LQCXGWi8EsgmnxCtVE
	 OPAnqxAYsEocyV7dkXpFpc0rmAWje+qQt9LJxUpU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.131
Date: Thu, 13 Mar 2025 13:28:07 +0100
Message-ID: <2025031307-afternoon-regulate-790f@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025031307-human-sphere-cd14@gregkh>
References: <2025031307-human-sphere-cd14@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index a4b58d8abc83..58d17d339578 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 130
+SUBLEVEL = 131
 EXTRAVERSION =
 NAME = Curry Ramen
 
@@ -1127,6 +1127,11 @@ endif
 KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
 
+# userspace programs are linked via the compiler, use the correct linker
+ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+KBUILD_USERLDFLAGS += $(call cc-option, --ld-path=$(LD))
+endif
+
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
 
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index 2dcb9e003657..30aa420610a0 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -126,14 +126,14 @@ void kexec_reboot(void)
 	/* All secondary cpus go to kexec_smp_wait */
 	if (smp_processor_id() > 0) {
 		relocated_kexec_smp_wait(NULL);
-		unreachable();
+		BUG();
 	}
 #endif
 
 	do_kexec = (void *)reboot_code_buffer;
 	do_kexec(efi_boot, cmdline_ptr, systable_ptr, start_addr, first_ind_entry);
 
-	unreachable();
+	BUG();
 }
 
 
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 138fe5eb3801..05668e964140 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -242,7 +242,7 @@ static inline int tlbe_is_writable(struct kvm_book3e_206_tlb_entry *tlbe)
 	return tlbe->mas7_3 & (MAS3_SW|MAS3_UW);
 }
 
-static inline bool kvmppc_e500_ref_setup(struct tlbe_ref *ref,
+static inline void kvmppc_e500_ref_setup(struct tlbe_ref *ref,
 					 struct kvm_book3e_206_tlb_entry *gtlbe,
 					 kvm_pfn_t pfn, unsigned int wimg)
 {
@@ -252,7 +252,11 @@ static inline bool kvmppc_e500_ref_setup(struct tlbe_ref *ref,
 	/* Use guest supplied MAS2_G and MAS2_E */
 	ref->flags |= (gtlbe->mas2 & MAS2_ATTRIB_MASK) | wimg;
 
-	return tlbe_is_writable(gtlbe);
+	/* Mark the page accessed */
+	kvm_set_pfn_accessed(pfn);
+
+	if (tlbe_is_writable(gtlbe))
+		kvm_set_pfn_dirty(pfn);
 }
 
 static inline void kvmppc_e500_ref_release(struct tlbe_ref *ref)
@@ -322,7 +326,6 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 {
 	struct kvm_memory_slot *slot;
 	unsigned long pfn = 0; /* silence GCC warning */
-	struct page *page = NULL;
 	unsigned long hva;
 	int pfnmap = 0;
 	int tsize = BOOK3E_PAGESZ_4K;
@@ -334,7 +337,6 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	unsigned int wimg = 0;
 	pgd_t *pgdir;
 	unsigned long flags;
-	bool writable = false;
 
 	/* used to check for invalidations in progress */
 	mmu_seq = kvm->mmu_invalidate_seq;
@@ -444,7 +446,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 	if (likely(!pfnmap)) {
 		tsize_pages = 1UL << (tsize + 10 - PAGE_SHIFT);
-		pfn = __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, NULL, &page);
+		pfn = gfn_to_pfn_memslot(slot, gfn);
 		if (is_error_noslot_pfn(pfn)) {
 			if (printk_ratelimit())
 				pr_err("%s: real page not found for gfn %lx\n",
@@ -479,6 +481,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		if (pte_present(pte)) {
 			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
 				MAS2_WIMGE_MASK;
+			local_irq_restore(flags);
 		} else {
 			local_irq_restore(flags);
 			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
@@ -487,9 +490,8 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 			goto out;
 		}
 	}
-	local_irq_restore(flags);
+	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
 
-	writable = kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
 				ref, gvaddr, stlbe);
 
@@ -497,8 +499,11 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	kvmppc_mmu_flush_icache(pfn);
 
 out:
-	kvm_release_faultin_page(kvm, page, !!ret, writable);
 	spin_unlock(&kvm->mmu_lock);
+
+	/* Drop refcount on page, so that mmu notifiers can clear it */
+	kvm_release_pfn_clean(pfn);
+
 	return ret;
 }
 
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 1d2aa448d103..bfedbd7fae3b 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -276,10 +276,10 @@ static void __init test_monitor_call(void)
 		return;
 	asm volatile(
 		"	mc	0,0\n"
-		"0:	xgr	%0,%0\n"
+		"0:	lhi	%[val],0\n"
 		"1:\n"
-		EX_TABLE(0b,1b)
-		: "+d" (val));
+		EX_TABLE(0b, 1b)
+		: [val] "+d" (val));
 	if (!val)
 		panic("Monitor call doesn't work!\n");
 }
diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index cb0386fc4dc3..c648502e4535 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -4,6 +4,7 @@
 
 #include <linux/thread_info.h>
 #include <asm/nospec-branch.h>
+#include <asm/msr.h>
 
 /*
  * On VMENTER we must preserve whatever view of the SPEC_CTRL MSR
@@ -76,6 +77,16 @@ static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
 }
 
+/*
+ * This can be used in noinstr functions & should only be called in bare
+ * metal context.
+ */
+static __always_inline void __update_spec_ctrl(u64 val)
+{
+	__this_cpu_write(x86_spec_ctrl_current, val);
+	native_wrmsrl(MSR_IA32_SPEC_CTRL, val);
+}
+
 #ifdef CONFIG_SMP
 extern void speculative_store_bypass_ht_init(void);
 #else
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 8992a6bce9f0..e5e7c43bf67b 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -342,7 +342,6 @@ bool __init early_is_amd_nb(u32 device)
 
 struct resource *amd_get_mmconfig_range(struct resource *res)
 {
-	u32 address;
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
@@ -350,13 +349,11 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
-	/* assume all cpus from fam10h have mmconfig */
-	if (boot_cpu_data.x86 < 0x10)
+	/* Assume CPUs from Fam10h have mmconfig, although not all VMs do */
+	if (boot_cpu_data.x86 < 0x10 ||
+	    rdmsrl_safe(MSR_FAM10H_MMIO_CONF_BASE, &msr))
 		return NULL;
 
-	address = MSR_FAM10H_MMIO_CONF_BASE;
-	rdmsrl(address, msr);
-
 	/* mmconfig is not enabled */
 	if (!(msr & FAM10H_MMIO_CONF_ENABLE))
 		return NULL;
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 03221a060ae7..7d73b5311551 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -92,7 +92,7 @@ void update_spec_ctrl_cond(u64 val)
 		wrmsrl(MSR_IA32_SPEC_CTRL, val);
 }
 
-u64 spec_ctrl_current(void)
+noinstr u64 spec_ctrl_current(void)
 {
 	return this_cpu_read(x86_spec_ctrl_current);
 }
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 66556833d7af..7cf43c6fb59d 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -801,7 +801,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 3 ; j++)
+			for (j = 0 ; j < 4 ; j++)
 				if (regs[j] & (1 << 31))
 					regs[j] = 0;
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 32bd64017047..b91f3d72bcdd 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -784,26 +784,37 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-#define TLB_INST_4K	0x01
-#define TLB_INST_4M	0x02
-#define TLB_INST_2M_4M	0x03
+#define TLB_INST_4K		0x01
+#define TLB_INST_4M		0x02
+#define TLB_INST_2M_4M		0x03
 
-#define TLB_INST_ALL	0x05
-#define TLB_INST_1G	0x06
+#define TLB_INST_ALL		0x05
+#define TLB_INST_1G		0x06
 
-#define TLB_DATA_4K	0x11
-#define TLB_DATA_4M	0x12
-#define TLB_DATA_2M_4M	0x13
-#define TLB_DATA_4K_4M	0x14
+#define TLB_DATA_4K		0x11
+#define TLB_DATA_4M		0x12
+#define TLB_DATA_2M_4M		0x13
+#define TLB_DATA_4K_4M		0x14
 
-#define TLB_DATA_1G	0x16
+#define TLB_DATA_1G		0x16
+#define TLB_DATA_1G_2M_4M	0x17
 
-#define TLB_DATA0_4K	0x21
-#define TLB_DATA0_4M	0x22
-#define TLB_DATA0_2M_4M	0x23
+#define TLB_DATA0_4K		0x21
+#define TLB_DATA0_4M		0x22
+#define TLB_DATA0_2M_4M		0x23
 
-#define STLB_4K		0x41
-#define STLB_4K_2M	0x42
+#define STLB_4K			0x41
+#define STLB_4K_2M		0x42
+
+/*
+ * All of leaf 0x2's one-byte TLB descriptors implies the same number of
+ * entries for their respective TLB types.  The 0x63 descriptor is an
+ * exception: it implies 4 dTLB entries for 1GB pages 32 dTLB entries
+ * for 2MB or 4MB pages.  Encode descriptor 0x63 dTLB entry count for
+ * 2MB/4MB pages here, as its count for dTLB 1GB pages is already at the
+ * intel_tlb_table[] mapping.
+ */
+#define TLB_0x63_2M_4M_ENTRIES	32
 
 static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x01, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages, 4-way set associative" },
@@ -825,7 +836,8 @@ static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x5c, TLB_DATA_4K_4M,		128,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
-	{ 0x63, TLB_DATA_1G,		4,	" TLB_DATA 1 GByte pages, 4-way set associative" },
+	{ 0x63, TLB_DATA_1G_2M_4M,	4,	" TLB_DATA 1 GByte pages, 4-way set associative"
+						" (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here)" },
 	{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
 	{ 0x6c, TLB_DATA_2M_4M,		128,	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
 	{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
@@ -925,6 +937,12 @@ static void intel_tlb_lookup(const unsigned char desc)
 		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
 			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
 		break;
+	case TLB_DATA_1G_2M_4M:
+		if (tlb_lld_2m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
+			tlb_lld_2m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		if (tlb_lld_4m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
+			tlb_lld_4m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		fallthrough;
 	case TLB_DATA_1G:
 		if (tlb_lld_1g[ENTRIES] < intel_tlb_table[k].entries)
 			tlb_lld_1g[ENTRIES] = intel_tlb_table[k].entries;
@@ -948,7 +966,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 		/* If bit 31 is set, this is an unknown format */
-		for (j = 0 ; j < 3 ; j++)
+		for (j = 0 ; j < 4 ; j++)
 			if (regs[j] & (1 << 31))
 				regs[j] = 0;
 
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index da8b8ea6b063..9634ac0fef1d 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -64,6 +64,13 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
+	/*
+	 * ECREATE would detect this too, but checking here also ensures
+	 * that the 'encl_size' calculations below can never overflow.
+	 */
+	if (!is_power_of_2(secs->size))
+		return -EINVAL;
+
 	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a96facc05139..d7d1b0f7073f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3039,6 +3039,18 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 				    __func__, data);
 			break;
 		}
+
+		/*
+		 * AMD changed the architectural behavior of bits 5:2.  On CPUs
+		 * without BusLockTrap, bits 5:2 control "external pins", but
+		 * on CPUs that support BusLockDetect, bit 2 enables BusLockTrap
+		 * and bits 5:3 are reserved-to-zero.  Sadly, old KVM allowed
+		 * the guest to set bits 5:2 despite not actually virtualizing
+		 * Performance-Monitoring/Breakpoint external pins.  Drop bits
+		 * 5:2 for backwards compatibility.
+		 */
+		data &= ~GENMASK(5, 2);
+
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 4cb1425900c6..a7f2faea8858 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -539,7 +539,7 @@ static inline bool is_x2apic_msrpm_offset(u32 offset)
 /* svm.c */
 #define MSR_INVALID				0xffffffffU
 
-#define DEBUGCTL_RESERVED_BITS (~(0x3fULL))
+#define DEBUGCTL_RESERVED_BITS (~(DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR))
 
 extern bool dump_invalid_vmcb;
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index ed861ef33f80..ab697ee64528 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -263,28 +263,33 @@ static void __init probe_page_size_mask(void)
 }
 
 /*
- * INVLPG may not properly flush Global entries
- * on these CPUs when PCIDs are enabled.
+ * INVLPG may not properly flush Global entries on
+ * these CPUs.  New microcode fixes the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,    0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0x2e),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0x42c),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,    0x11),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0x118),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0x4117),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0x2e),
 	{}
 };
 
 static void setup_pcid(void)
 {
+	const struct x86_cpu_id *invlpg_miss_match;
+
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	if (x86_match_cpu(invlpg_miss_ids)) {
+	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
+
+	if (invlpg_miss_match &&
+	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..7acba66eed48 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
 	out[size] = 0;
 
 	while (i < size) {
-		u8 c = le16_to_cpu(in[i]) & 0xff;
+		u8 c = le16_to_cpu(in[i]) & 0x7f;
 
 		if (c && !isprint(c))
 			c = '!';
diff --git a/drivers/base/core.c b/drivers/base/core.c
index f21ceb93e50e..d985c4b87de5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2023,6 +2023,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 out:
 	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
 	put_device(sup_dev);
+	put_device(con_dev);
 	put_device(par_dev);
 	return ret;
 }
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 35580ad45ce6..f2a99e5d304d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1873,9 +1873,12 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
-	/* parameters can only be changed when device isn't live */
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
+	if (test_bit(UB_STATE_USED, &ub->state)) {
+		/*
+		 * Parameters can only be changed when device hasn't
+		 * been started yet
+		 */
 		ret = -EACCES;
 	} else if (copy_from_user(&ub->params, argp, ph.len)) {
 		ret = -EFAULT;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c9747de0d6d..25adb3ac40eb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3769,6 +3769,7 @@ static ssize_t force_poll_sync_write(struct file *file,
 }
 
 static const struct file_operations force_poll_sync_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_poll_sync_read,
 	.write		= force_poll_sync_write,
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index e01754af576b..4bb4bcd45b0a 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -824,8 +824,9 @@ static void mhi_pci_recovery_work(struct work_struct *work)
 err_unprepare:
 	mhi_unprepare_after_power_down(mhi_cntrl);
 err_try_reset:
-	if (pci_reset_function(pdev))
-		dev_err(&pdev->dev, "Recovery failed\n");
+	err = pci_try_reset_function(pdev);
+	if (err)
+		dev_err(&pdev->dev, "Recovery failed: %d\n", err);
 }
 
 static void health_check(struct timer_list *t)
diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 0cb2664085cf..836e21fde028 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -116,10 +116,15 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	struct platform_device *pdev;
 	int res, id;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
 	/* kernfs guarantees string termination, so count + 1 is safe */
 	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
-	if (!aggr)
-		return -ENOMEM;
+	if (!aggr) {
+		res = -ENOMEM;
+		goto put_module;
+	}
 
 	memcpy(aggr->args, buf, count + 1);
 
@@ -158,6 +163,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	}
 
 	aggr->pdev = pdev;
+	module_put(THIS_MODULE);
 	return count;
 
 remove_table:
@@ -172,6 +178,8 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	kfree(aggr->lookups);
 free_ga:
 	kfree(aggr);
+put_module:
+	module_put(THIS_MODULE);
 	return res;
 }
 
@@ -200,13 +208,19 @@ static ssize_t delete_device_store(struct device_driver *driver,
 	if (error)
 		return error;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
 	mutex_lock(&gpio_aggregator_lock);
 	aggr = idr_remove(&gpio_aggregator_idr, id);
 	mutex_unlock(&gpio_aggregator_lock);
-	if (!aggr)
+	if (!aggr) {
+		module_put(THIS_MODULE);
 		return -ENOENT;
+	}
 
 	gpio_aggregator_free(aggr);
+	module_put(THIS_MODULE);
 	return count;
 }
 static DRIVER_ATTR_WO(delete_device);
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 5b117f3bd322..ab200e625010 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -41,7 +41,7 @@ struct gpio_rcar_info {
 
 struct gpio_rcar_priv {
 	void __iomem *base;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct device *dev;
 	struct gpio_chip gpio_chip;
 	unsigned int irq_parent;
@@ -124,7 +124,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	 * "Setting Level-Sensitive Interrupt Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure positive or negative logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, hwirq, !active_high_rising_edge);
@@ -143,7 +143,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	if (!level_trigger)
 		gpio_rcar_write(p, INTCLR, BIT(hwirq));
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
@@ -247,7 +247,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	 * "Setting General Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure positive logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, gpio, false);
@@ -262,7 +262,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	if (p->info.has_outdtsel && output)
 		gpio_rcar_modify_bit(p, OUTDTSEL, gpio, false);
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
@@ -348,7 +348,7 @@ static int gpio_rcar_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 		return 0;
 	}
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	outputs = gpio_rcar_read(p, INOUTSEL);
 	m = outputs & bankmask;
 	if (m)
@@ -357,7 +357,7 @@ static int gpio_rcar_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	m = ~outputs & bankmask;
 	if (m)
 		val |= gpio_rcar_read(p, INDT) & m;
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 
 	bits[0] = val;
 	return 0;
@@ -368,9 +368,9 @@ static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int value)
 	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	gpio_rcar_modify_bit(p, OUTDT, offset, value);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -387,12 +387,12 @@ static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 	if (!bankmask)
 		return;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	val = gpio_rcar_read(p, OUTDT);
 	val &= ~bankmask;
 	val |= (bankmask & bits[0]);
 	gpio_rcar_write(p, OUTDT, val);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
@@ -469,7 +469,12 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 	p->info = *info;
 
 	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
-	*npins = ret == 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
+	if (ret) {
+		*npins = RCAR_MAX_GPIO_PER_BANK;
+	} else {
+		*npins = args.args[2];
+		of_node_put(args.np);
+	}
 
 	if (*npins == 0 || *npins > RCAR_MAX_GPIO_PER_BANK) {
 		dev_warn(p->dev, "Invalid number of gpio lines %u, using %u\n",
@@ -506,7 +511,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	p->dev = dev;
-	spin_lock_init(&p->lock);
+	raw_spin_lock_init(&p->lock);
 
 	/* Get device configuration from DT node */
 	ret = gpio_rcar_parse_dt(p, &npins);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c4e548d32504..b41a97185823 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1220,6 +1220,17 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	/* resizing on Dell G5 SE platforms causes problems with runtime pm */
+	if ((amdgpu_runtime_pm != 0) &&
+	    adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    adev->pdev->device == 0x731f &&
+	    adev->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL)
+		return 0;
+
+	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
+	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
+		DRM_WARN("System can't access extended configuration space,please check!!\n");
+
 	/* skip if the bios has already enabled large BAR */
 	if (adev->gmc.real_vram_size &&
 	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8b27fe2f5ab1..87a6d6a4ddf4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1100,7 +1100,8 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
 	/* Invalid input */
-	if (!plane_state->dst_rect.width ||
+	if (!plane_state ||
+			!plane_state->dst_rect.width ||
 			!plane_state->dst_rect.height ||
 			!plane_state->src_rect.width ||
 			!plane_state->src_rect.height) {
diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index 621ff174dff3..0946a11835a4 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -359,7 +359,8 @@ int r300_mc_wait_for_idle(struct radeon_device *rdev)
 	return -1;
 }
 
-static void r300_gpu_init(struct radeon_device *rdev)
+/* rs400_gpu_init also calls this! */
+void r300_gpu_init(struct radeon_device *rdev)
 {
 	uint32_t gb_tile_config, tmp;
 
diff --git a/drivers/gpu/drm/radeon/radeon_asic.h b/drivers/gpu/drm/radeon/radeon_asic.h
index 1e00f6b99f94..8f5e07834fcc 100644
--- a/drivers/gpu/drm/radeon/radeon_asic.h
+++ b/drivers/gpu/drm/radeon/radeon_asic.h
@@ -165,6 +165,7 @@ void r200_set_safe_registers(struct radeon_device *rdev);
  */
 extern int r300_init(struct radeon_device *rdev);
 extern void r300_fini(struct radeon_device *rdev);
+extern void r300_gpu_init(struct radeon_device *rdev);
 extern int r300_suspend(struct radeon_device *rdev);
 extern int r300_resume(struct radeon_device *rdev);
 extern int r300_asic_reset(struct radeon_device *rdev, bool hard);
diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.c
index 6383f7a34bd8..921076292356 100644
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -255,8 +255,22 @@ int rs400_mc_wait_for_idle(struct radeon_device *rdev)
 
 static void rs400_gpu_init(struct radeon_device *rdev)
 {
-	/* FIXME: is this correct ? */
-	r420_pipes_init(rdev);
+	/* Earlier code was calling r420_pipes_init and then
+	 * rs400_mc_wait_for_idle(rdev). The problem is that
+	 * at least on my Mobility Radeon Xpress 200M RC410 card
+	 * that ends up in this code path ends up num_gb_pipes == 3
+	 * while the card seems to have only one pipe. With the
+	 * r420 pipe initialization method.
+	 *
+	 * Problems shown up as HyperZ glitches, see:
+	 * https://bugs.freedesktop.org/show_bug.cgi?id=110897
+	 *
+	 * Delegating initialization to r300 code seems to work
+	 * and results in proper pipe numbers. The rs400 cards
+	 * are said to be not r400, but r300 kind of cards.
+	 */
+	r300_gpu_init(rdev);
+
 	if (rs400_mc_wait_for_idle(rdev)) {
 		pr_warn("rs400: Failed to wait MC idle while programming pipes. Bad things might happen. %08x\n",
 			RREG32(RADEON_MC_STATUS));
diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index 3143ecaaff86..f7f10e97ac05 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -21,7 +21,7 @@
  *
  */
 
-#if !defined(_GPU_SCHED_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#if !defined(_GPU_SCHED_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
 #define _GPU_SCHED_TRACE_H_
 
 #include <linux/stringify.h>
@@ -106,7 +106,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
 		      __entry->seqno)
 );
 
-#endif
+#endif /* _GPU_SCHED_TRACE_H_ */
 
 /* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index 8deded185725..c45e5aa569d2 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -188,7 +188,7 @@ static int appleir_raw_event(struct hid_device *hid, struct hid_report *report,
 	static const u8 flatbattery[] = { 0x25, 0x87, 0xe0 };
 	unsigned long flags;
 
-	if (len != 5)
+	if (len != 5 || !(hid->claimed & HID_CLAIMED_INPUT))
 		goto out;
 
 	if (!memcmp(data, keydown, sizeof(keydown))) {
diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index c6bdb9c4ef3e..d25291ed900d 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -269,11 +269,13 @@ static int cbas_ec_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id cbas_ec_acpi_ids[] = {
 	{ "GOOG000B", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cbas_ec_acpi_ids);
+#endif
 
 #ifdef CONFIG_OF
 static const struct of_device_id cbas_ec_of_match[] = {
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index 14c271d7d8a9..0377dac3fc9a 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -261,12 +261,14 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
  */
 void ishtp_hid_remove(struct ishtp_cl_data *client_data)
 {
+	void *data;
 	int i;
 
 	for (i = 0; i < client_data->num_hid_devices; ++i) {
 		if (client_data->hid_sensor_hubs[i]) {
-			kfree(client_data->hid_sensor_hubs[i]->driver_data);
+			data = client_data->hid_sensor_hubs[i]->driver_data;
 			hid_destroy_device(client_data->hid_sensor_hubs[i]);
+			kfree(data);
 			client_data->hid_sensor_hubs[i] = NULL;
 		}
 	}
diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index 7802bbf5f958..59424103f634 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -22,11 +22,13 @@
  */
 #define AD7314_TEMP_MASK		0x7FE0
 #define AD7314_TEMP_SHIFT		5
+#define AD7314_LEADING_ZEROS_MASK	BIT(15)
 
 /*
  * ADT7301 and ADT7302 temperature masks
  */
 #define ADT7301_TEMP_MASK		0x3FFF
+#define ADT7301_LEADING_ZEROS_MASK	(BIT(15) | BIT(14))
 
 enum ad7314_variant {
 	adt7301,
@@ -65,12 +67,20 @@ static ssize_t ad7314_temperature_show(struct device *dev,
 		return ret;
 	switch (spi_get_device_id(chip->spi_dev)->driver_data) {
 	case ad7314:
+		if (ret & AD7314_LEADING_ZEROS_MASK) {
+			/* Invalid read-out, leading zero part is missing */
+			return -EIO;
+		}
 		data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
 		data = sign_extend32(data, 9);
 
 		return sprintf(buf, "%d\n", 250 * data);
 	case adt7301:
 	case adt7302:
+		if (ret & ADT7301_LEADING_ZEROS_MASK) {
+			/* Invalid read-out, leading zero part is missing */
+			return -EIO;
+		}
 		/*
 		 * Documented as a 13 bit twos complement register
 		 * with a sign bit - which is a 14 bit 2's complement
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 4efbacce5d0c..6bb1900b021c 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -181,40 +181,40 @@ static const struct ntc_compensation ncpXXwf104[] = {
 };
 
 static const struct ntc_compensation ncpXXxh103[] = {
-	{ .temp_c	= -40, .ohm	= 247565 },
-	{ .temp_c	= -35, .ohm	= 181742 },
-	{ .temp_c	= -30, .ohm	= 135128 },
-	{ .temp_c	= -25, .ohm	= 101678 },
-	{ .temp_c	= -20, .ohm	= 77373 },
-	{ .temp_c	= -15, .ohm	= 59504 },
-	{ .temp_c	= -10, .ohm	= 46222 },
-	{ .temp_c	= -5, .ohm	= 36244 },
-	{ .temp_c	= 0, .ohm	= 28674 },
-	{ .temp_c	= 5, .ohm	= 22878 },
-	{ .temp_c	= 10, .ohm	= 18399 },
-	{ .temp_c	= 15, .ohm	= 14910 },
-	{ .temp_c	= 20, .ohm	= 12169 },
+	{ .temp_c	= -40, .ohm	= 195652 },
+	{ .temp_c	= -35, .ohm	= 148171 },
+	{ .temp_c	= -30, .ohm	= 113347 },
+	{ .temp_c	= -25, .ohm	= 87559 },
+	{ .temp_c	= -20, .ohm	= 68237 },
+	{ .temp_c	= -15, .ohm	= 53650 },
+	{ .temp_c	= -10, .ohm	= 42506 },
+	{ .temp_c	= -5, .ohm	= 33892 },
+	{ .temp_c	= 0, .ohm	= 27219 },
+	{ .temp_c	= 5, .ohm	= 22021 },
+	{ .temp_c	= 10, .ohm	= 17926 },
+	{ .temp_c	= 15, .ohm	= 14674 },
+	{ .temp_c	= 20, .ohm	= 12081 },
 	{ .temp_c	= 25, .ohm	= 10000 },
-	{ .temp_c	= 30, .ohm	= 8271 },
-	{ .temp_c	= 35, .ohm	= 6883 },
-	{ .temp_c	= 40, .ohm	= 5762 },
-	{ .temp_c	= 45, .ohm	= 4851 },
-	{ .temp_c	= 50, .ohm	= 4105 },
-	{ .temp_c	= 55, .ohm	= 3492 },
-	{ .temp_c	= 60, .ohm	= 2985 },
-	{ .temp_c	= 65, .ohm	= 2563 },
-	{ .temp_c	= 70, .ohm	= 2211 },
-	{ .temp_c	= 75, .ohm	= 1915 },
-	{ .temp_c	= 80, .ohm	= 1666 },
-	{ .temp_c	= 85, .ohm	= 1454 },
-	{ .temp_c	= 90, .ohm	= 1275 },
-	{ .temp_c	= 95, .ohm	= 1121 },
-	{ .temp_c	= 100, .ohm	= 990 },
-	{ .temp_c	= 105, .ohm	= 876 },
-	{ .temp_c	= 110, .ohm	= 779 },
-	{ .temp_c	= 115, .ohm	= 694 },
-	{ .temp_c	= 120, .ohm	= 620 },
-	{ .temp_c	= 125, .ohm	= 556 },
+	{ .temp_c	= 30, .ohm	= 8315 },
+	{ .temp_c	= 35, .ohm	= 6948 },
+	{ .temp_c	= 40, .ohm	= 5834 },
+	{ .temp_c	= 45, .ohm	= 4917 },
+	{ .temp_c	= 50, .ohm	= 4161 },
+	{ .temp_c	= 55, .ohm	= 3535 },
+	{ .temp_c	= 60, .ohm	= 3014 },
+	{ .temp_c	= 65, .ohm	= 2586 },
+	{ .temp_c	= 70, .ohm	= 2228 },
+	{ .temp_c	= 75, .ohm	= 1925 },
+	{ .temp_c	= 80, .ohm	= 1669 },
+	{ .temp_c	= 85, .ohm	= 1452 },
+	{ .temp_c	= 90, .ohm	= 1268 },
+	{ .temp_c	= 95, .ohm	= 1110 },
+	{ .temp_c	= 100, .ohm	= 974 },
+	{ .temp_c	= 105, .ohm	= 858 },
+	{ .temp_c	= 110, .ohm	= 758 },
+	{ .temp_c	= 115, .ohm	= 672 },
+	{ .temp_c	= 120, .ohm	= 596 },
+	{ .temp_c	= 125, .ohm	= 531 },
 };
 
 /*
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index d0d386990af5..6366610a9082 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -103,6 +103,8 @@ static int pmbus_identify(struct i2c_client *client,
 		if (pmbus_check_byte_register(client, 0, PMBUS_PAGE)) {
 			int page;
 
+			info->pages = PMBUS_PAGES;
+
 			for (page = 1; page < PMBUS_PAGES; page++) {
 				if (pmbus_set_page(client, page, 0xff) < 0)
 					break;
diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 78d9f52e2a71..207084d55044 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -712,7 +712,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		if (!ctx->pcc_comm_addr) {
+		if (IS_ERR_OR_NULL(ctx->pcc_comm_addr)) {
 			dev_err(&pdev->dev,
 				"Failed to ioremap PCC comm region\n");
 			rc = -ENOMEM;
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 8dad239aba2c..e7985db1f29b 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -329,6 +329,21 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa824),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Arrow Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7724),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Panther Lake-H */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xe324),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Panther Lake-P/U */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xe424),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5d7bbccb52b5..ae07dc018e66 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -188,12 +188,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	int ret;
 
 	if (smt_active)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
 	ret = __intel_idle(dev, drv, index);
 
 	if (smt_active)
-		wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
 
 	return ret;
 }
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 3ad5678f2613..7bd180d48cb6 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -329,7 +329,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 #define AT91_HWFIFO_MAX_SIZE_STR	"128"
 #define AT91_HWFIFO_MAX_SIZE		128
 
-#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
+#define AT91_SAMA_CHAN_SINGLE(index, num, addr, rbits)			\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.channel = num,						\
@@ -337,7 +337,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 'u',					\
-			.realbits = 14,					\
+			.realbits = rbits,				\
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -350,7 +350,13 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.indexed = 1,						\
 	}
 
-#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
+#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
+	AT91_SAMA_CHAN_SINGLE(index, num, addr, 14)
+
+#define AT91_SAMA7G5_CHAN_SINGLE(index, num, addr)			\
+	AT91_SAMA_CHAN_SINGLE(index, num, addr, 16)
+
+#define AT91_SAMA_CHAN_DIFF(index, num, num2, addr, rbits)		\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.differential = 1,					\
@@ -360,7 +366,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 's',					\
-			.realbits = 14,					\
+			.realbits = rbits,				\
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -373,6 +379,12 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.indexed = 1,						\
 	}
 
+#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
+	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 14)
+
+#define AT91_SAMA7G5_CHAN_DIFF(index, num, num2, addr)			\
+	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 16)
+
 #define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)				\
 	{								\
 		.type = IIO_POSITIONRELATIVE,				\
@@ -666,30 +678,30 @@ static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
 };
 
 static const struct iio_chan_spec at91_sama7g5_adc_channels[] = {
-	AT91_SAMA5D2_CHAN_SINGLE(0, 0, 0x60),
-	AT91_SAMA5D2_CHAN_SINGLE(1, 1, 0x64),
-	AT91_SAMA5D2_CHAN_SINGLE(2, 2, 0x68),
-	AT91_SAMA5D2_CHAN_SINGLE(3, 3, 0x6c),
-	AT91_SAMA5D2_CHAN_SINGLE(4, 4, 0x70),
-	AT91_SAMA5D2_CHAN_SINGLE(5, 5, 0x74),
-	AT91_SAMA5D2_CHAN_SINGLE(6, 6, 0x78),
-	AT91_SAMA5D2_CHAN_SINGLE(7, 7, 0x7c),
-	AT91_SAMA5D2_CHAN_SINGLE(8, 8, 0x80),
-	AT91_SAMA5D2_CHAN_SINGLE(9, 9, 0x84),
-	AT91_SAMA5D2_CHAN_SINGLE(10, 10, 0x88),
-	AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x8c),
-	AT91_SAMA5D2_CHAN_SINGLE(12, 12, 0x90),
-	AT91_SAMA5D2_CHAN_SINGLE(13, 13, 0x94),
-	AT91_SAMA5D2_CHAN_SINGLE(14, 14, 0x98),
-	AT91_SAMA5D2_CHAN_SINGLE(15, 15, 0x9c),
-	AT91_SAMA5D2_CHAN_DIFF(16, 0, 1, 0x60),
-	AT91_SAMA5D2_CHAN_DIFF(17, 2, 3, 0x68),
-	AT91_SAMA5D2_CHAN_DIFF(18, 4, 5, 0x70),
-	AT91_SAMA5D2_CHAN_DIFF(19, 6, 7, 0x78),
-	AT91_SAMA5D2_CHAN_DIFF(20, 8, 9, 0x80),
-	AT91_SAMA5D2_CHAN_DIFF(21, 10, 11, 0x88),
-	AT91_SAMA5D2_CHAN_DIFF(22, 12, 13, 0x90),
-	AT91_SAMA5D2_CHAN_DIFF(23, 14, 15, 0x98),
+	AT91_SAMA7G5_CHAN_SINGLE(0, 0, 0x60),
+	AT91_SAMA7G5_CHAN_SINGLE(1, 1, 0x64),
+	AT91_SAMA7G5_CHAN_SINGLE(2, 2, 0x68),
+	AT91_SAMA7G5_CHAN_SINGLE(3, 3, 0x6c),
+	AT91_SAMA7G5_CHAN_SINGLE(4, 4, 0x70),
+	AT91_SAMA7G5_CHAN_SINGLE(5, 5, 0x74),
+	AT91_SAMA7G5_CHAN_SINGLE(6, 6, 0x78),
+	AT91_SAMA7G5_CHAN_SINGLE(7, 7, 0x7c),
+	AT91_SAMA7G5_CHAN_SINGLE(8, 8, 0x80),
+	AT91_SAMA7G5_CHAN_SINGLE(9, 9, 0x84),
+	AT91_SAMA7G5_CHAN_SINGLE(10, 10, 0x88),
+	AT91_SAMA7G5_CHAN_SINGLE(11, 11, 0x8c),
+	AT91_SAMA7G5_CHAN_SINGLE(12, 12, 0x90),
+	AT91_SAMA7G5_CHAN_SINGLE(13, 13, 0x94),
+	AT91_SAMA7G5_CHAN_SINGLE(14, 14, 0x98),
+	AT91_SAMA7G5_CHAN_SINGLE(15, 15, 0x9c),
+	AT91_SAMA7G5_CHAN_DIFF(16, 0, 1, 0x60),
+	AT91_SAMA7G5_CHAN_DIFF(17, 2, 3, 0x68),
+	AT91_SAMA7G5_CHAN_DIFF(18, 4, 5, 0x70),
+	AT91_SAMA7G5_CHAN_DIFF(19, 6, 7, 0x78),
+	AT91_SAMA7G5_CHAN_DIFF(20, 8, 9, 0x80),
+	AT91_SAMA7G5_CHAN_DIFF(21, 10, 11, 0x88),
+	AT91_SAMA7G5_CHAN_DIFF(22, 12, 13, 0x90),
+	AT91_SAMA7G5_CHAN_DIFF(23, 14, 15, 0x98),
 	IIO_CHAN_SOFT_TIMESTAMP(24),
 	AT91_SAMA5D2_CHAN_TEMP(AT91_SAMA7G5_ADC_TEMP_CHANNEL, "temp", 0xdc),
 };
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index a492e8f2fc0f..130bda620222 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -703,6 +703,12 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
 		return ret;
 	}
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = ad3552r_write_reg(dac, AD3552R_REG_ADDR_ERR_STATUS,
+				AD3552R_MASK_RESET_STATUS);
+	if (ret)
+		return ret;
+
 	return ad3552r_update_reg_field(dac,
 					addr_mask_map[AD3552R_ADDR_ASCENSION][0],
 					addr_mask_map[AD3552R_ADDR_ASCENSION][1],
diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 68de45fe21b4..c7f5911f9040 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -527,21 +527,15 @@ static int admv8818_init(struct admv8818_state *st)
 	struct spi_device *spi = st->spi;
 	unsigned int chip_id;
 
-	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
-				 ADMV8818_SOFTRESET_N_MSK |
-				 ADMV8818_SOFTRESET_MSK,
-				 FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
-				 FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
+	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+			   ADMV8818_SOFTRESET_N_MSK | ADMV8818_SOFTRESET_MSK);
 	if (ret) {
 		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
 		return ret;
 	}
 
-	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
-				 ADMV8818_SDOACTIVE_N_MSK |
-				 ADMV8818_SDOACTIVE_MSK,
-				 FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
-				 FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
+	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
 	if (ret) {
 		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
 		return ret;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
index df309e8e9379..af3fc89b6cc5 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
@@ -213,6 +213,12 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
 	mtk_vcodec_debug(vpu, "vdec_inst=%p", vpu);
 
 	err = vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
+
+	if (IS_ERR_OR_NULL(vpu->vsi)) {
+		mtk_vcodec_err(vpu, "invalid vdec vsi, status=%d", err);
+		return -EINVAL;
+	}
+
 	mtk_vcodec_debug(vpu, "- ret=%d", err);
 	return err;
 }
diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 285a748748d7..f150d8769f19 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -286,7 +286,6 @@ static int rtsx_usb_get_status_with_bulk(struct rtsx_ucr *ucr, u16 *status)
 int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 {
 	int ret;
-	u8 interrupt_val = 0;
 	u16 *buf;
 
 	if (!status)
@@ -309,20 +308,6 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 		ret = rtsx_usb_get_status_with_bulk(ucr, status);
 	}
 
-	rtsx_usb_read_register(ucr, CARD_INT_PEND, &interrupt_val);
-	/* Cross check presence with interrupts */
-	if (*status & XD_CD)
-		if (!(interrupt_val & XD_INT))
-			*status &= ~XD_CD;
-
-	if (*status & SD_CD)
-		if (!(interrupt_val & SD_INT))
-			*status &= ~SD_CD;
-
-	if (*status & MS_CD)
-		if (!(interrupt_val & MS_INT))
-			*status &= ~MS_CD;
-
 	/* usb_control_msg may return positive when success */
 	if (ret < 0)
 		return ret;
diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index 4eddc5ba1af9..dfaedc0e350d 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -60,7 +60,7 @@ static struct platform_device digsy_mtc_eeprom = {
 };
 
 static struct gpiod_lookup_table eeprom_spi_gpiod_table = {
-	.dev_id         = "spi_gpio",
+	.dev_id         = "spi_gpio.1",
 	.table          = {
 		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_CLK,
 			    "sck", GPIO_ACTIVE_HIGH),
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index d3c03d4edbef..a4668ddd9455 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -117,6 +117,8 @@
 
 #define MEI_DEV_ID_LNL_M      0xA870  /* Lunar Lake Point M */
 
+#define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index dd4d92fa44c6..be9b5d36a077 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -124,6 +124,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 0b0f234b0b50..a8b9ada7526c 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -745,7 +745,7 @@ static int cfv_probe(struct virtio_device *vdev)
 
 	if (cfv->vr_rx)
 		vdev->vringh_config->del_vrhs(cfv->vdev);
-	if (cfv->vdev)
+	if (cfv->vq_tx)
 		vdev->config->del_vqs(cfv->vdev);
 	free_netdev(netdev);
 	return err;
diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/ethernet/emulex/benet/be.h
index 61fe9625bed1..06f42e5b5149 100644
--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -562,7 +562,7 @@ struct be_adapter {
 	struct be_dma_mem mbox_mem_alloced;
 
 	struct be_mcc_obj mcc_obj;
-	struct mutex mcc_lock;	/* For serializing mcc cmds to BE card */
+	spinlock_t mcc_lock;	/* For serializing mcc cmds to BE card */
 	spinlock_t mcc_cq_lock;
 
 	u16 cfg_num_rx_irqs;		/* configured via set-channels */
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 08ec84cd21c0..d00f4e29c9d8 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -573,7 +573,7 @@ int be_process_mcc(struct be_adapter *adapter)
 /* Wait till no more pending mcc requests are present */
 static int be_mcc_wait_compl(struct be_adapter *adapter)
 {
-#define mcc_timeout		12000 /* 12s timeout */
+#define mcc_timeout		120000 /* 12s timeout */
 	int i, status = 0;
 	struct be_mcc_obj *mcc_obj = &adapter->mcc_obj;
 
@@ -587,7 +587,7 @@ static int be_mcc_wait_compl(struct be_adapter *adapter)
 
 		if (atomic_read(&mcc_obj->q.used) == 0)
 			break;
-		usleep_range(500, 1000);
+		udelay(100);
 	}
 	if (i == mcc_timeout) {
 		dev_err(&adapter->pdev->dev, "FW not responding\n");
@@ -865,7 +865,7 @@ static bool use_mcc(struct be_adapter *adapter)
 static int be_cmd_lock(struct be_adapter *adapter)
 {
 	if (use_mcc(adapter)) {
-		mutex_lock(&adapter->mcc_lock);
+		spin_lock_bh(&adapter->mcc_lock);
 		return 0;
 	} else {
 		return mutex_lock_interruptible(&adapter->mbox_lock);
@@ -876,7 +876,7 @@ static int be_cmd_lock(struct be_adapter *adapter)
 static void be_cmd_unlock(struct be_adapter *adapter)
 {
 	if (use_mcc(adapter))
-		return mutex_unlock(&adapter->mcc_lock);
+		return spin_unlock_bh(&adapter->mcc_lock);
 	else
 		return mutex_unlock(&adapter->mbox_lock);
 }
@@ -1046,7 +1046,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 	struct be_cmd_req_mac_query *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1075,7 +1075,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1087,7 +1087,7 @@ int be_cmd_pmac_add(struct be_adapter *adapter, const u8 *mac_addr,
 	struct be_cmd_req_pmac_add *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1112,7 +1112,7 @@ int be_cmd_pmac_add(struct be_adapter *adapter, const u8 *mac_addr,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	 if (base_status(status) == MCC_STATUS_UNAUTHORIZED_REQUEST)
 		status = -EPERM;
@@ -1130,7 +1130,7 @@ int be_cmd_pmac_del(struct be_adapter *adapter, u32 if_id, int pmac_id, u32 dom)
 	if (pmac_id == -1)
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1150,7 +1150,7 @@ int be_cmd_pmac_del(struct be_adapter *adapter, u32 if_id, int pmac_id, u32 dom)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1413,7 +1413,7 @@ int be_cmd_rxq_create(struct be_adapter *adapter,
 	struct be_dma_mem *q_mem = &rxq->dma_mem;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1443,7 +1443,7 @@ int be_cmd_rxq_create(struct be_adapter *adapter,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1507,7 +1507,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, struct be_queue_info *q)
 	struct be_cmd_req_q_destroy *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1524,7 +1524,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, struct be_queue_info *q)
 	q->created = false;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1592,7 +1592,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	struct be_cmd_req_hdr *hdr;
 	int status = 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1620,7 +1620,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	adapter->stats_cmd_sent = true;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1636,7 +1636,7 @@ int lancer_cmd_get_pport_stats(struct be_adapter *adapter,
 			    CMD_SUBSYSTEM_ETH))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1659,7 +1659,7 @@ int lancer_cmd_get_pport_stats(struct be_adapter *adapter,
 	adapter->stats_cmd_sent = true;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1696,7 +1696,7 @@ int be_cmd_link_status_query(struct be_adapter *adapter, u16 *link_speed,
 	struct be_cmd_req_link_status *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	if (link_status)
 		*link_status = LINK_DOWN;
@@ -1735,7 +1735,7 @@ int be_cmd_link_status_query(struct be_adapter *adapter, u16 *link_speed,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1746,7 +1746,7 @@ int be_cmd_get_die_temperature(struct be_adapter *adapter)
 	struct be_cmd_req_get_cntl_addnl_attribs *req;
 	int status = 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1761,7 +1761,7 @@ int be_cmd_get_die_temperature(struct be_adapter *adapter)
 
 	status = be_mcc_notify(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1810,7 +1810,7 @@ int be_cmd_get_fat_dump(struct be_adapter *adapter, u32 buf_len, void *buf)
 	if (!get_fat_cmd.va)
 		return -ENOMEM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	while (total_size) {
 		buf_size = min(total_size, (u32)60*1024);
@@ -1848,9 +1848,9 @@ int be_cmd_get_fat_dump(struct be_adapter *adapter, u32 buf_len, void *buf)
 		log_offset += buf_size;
 	}
 err:
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, get_fat_cmd.size,
 			  get_fat_cmd.va, get_fat_cmd.dma);
-	mutex_unlock(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1861,7 +1861,7 @@ int be_cmd_get_fw_ver(struct be_adapter *adapter)
 	struct be_cmd_req_get_fw_version *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1884,7 +1884,7 @@ int be_cmd_get_fw_ver(struct be_adapter *adapter)
 			sizeof(adapter->fw_on_flash));
 	}
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1898,7 +1898,7 @@ static int __be_cmd_modify_eqd(struct be_adapter *adapter,
 	struct be_cmd_req_modify_eq_delay *req;
 	int status = 0, i;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1921,7 +1921,7 @@ static int __be_cmd_modify_eqd(struct be_adapter *adapter,
 
 	status = be_mcc_notify(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1948,7 +1948,7 @@ int be_cmd_vlan_config(struct be_adapter *adapter, u32 if_id, u16 *vtag_array,
 	struct be_cmd_req_vlan_config *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1970,7 +1970,7 @@ int be_cmd_vlan_config(struct be_adapter *adapter, u32 if_id, u16 *vtag_array,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1981,7 +1981,7 @@ static int __be_cmd_rx_filter(struct be_adapter *adapter, u32 flags, u32 value)
 	struct be_cmd_req_rx_filter *req = mem->va;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2014,7 +2014,7 @@ static int __be_cmd_rx_filter(struct be_adapter *adapter, u32 flags, u32 value)
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2045,7 +2045,7 @@ int be_cmd_set_flow_control(struct be_adapter *adapter, u32 tx_fc, u32 rx_fc)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2065,7 +2065,7 @@ int be_cmd_set_flow_control(struct be_adapter *adapter, u32 tx_fc, u32 rx_fc)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (base_status(status) == MCC_STATUS_FEATURE_NOT_SUPPORTED)
 		return  -EOPNOTSUPP;
@@ -2084,7 +2084,7 @@ int be_cmd_get_flow_control(struct be_adapter *adapter, u32 *tx_fc, u32 *rx_fc)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2107,7 +2107,7 @@ int be_cmd_get_flow_control(struct be_adapter *adapter, u32 *tx_fc, u32 *rx_fc)
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2188,7 +2188,7 @@ int be_cmd_rss_config(struct be_adapter *adapter, u8 *rsstable,
 	if (!(be_if_cap_flags(adapter) & BE_IF_FLAGS_RSS))
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2213,7 +2213,7 @@ int be_cmd_rss_config(struct be_adapter *adapter, u8 *rsstable,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2225,7 +2225,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adapter, u8 port_num,
 	struct be_cmd_req_enable_disable_beacon *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2246,7 +2246,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adapter, u8 port_num,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2257,7 +2257,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adapter, u8 port_num, u32 *state)
 	struct be_cmd_req_get_beacon_state *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2281,7 +2281,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adapter, u8 port_num, u32 *state)
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2305,7 +2305,7 @@ int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
 		return -ENOMEM;
 	}
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2327,7 +2327,7 @@ int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
 		memcpy(data, resp->page_data + off, len);
 	}
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 	return status;
 }
@@ -2344,7 +2344,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	void *ctxt = NULL;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 	adapter->flash_status = 0;
 
 	wrb = wrb_from_mccq(adapter);
@@ -2386,7 +2386,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(60000)))
@@ -2405,7 +2405,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2459,7 +2459,7 @@ static int lancer_cmd_delete_object(struct be_adapter *adapter,
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2477,7 +2477,7 @@ static int lancer_cmd_delete_object(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2490,7 +2490,7 @@ int lancer_cmd_read_object(struct be_adapter *adapter, struct be_dma_mem *cmd,
 	struct lancer_cmd_resp_read_object *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2524,7 +2524,7 @@ int lancer_cmd_read_object(struct be_adapter *adapter, struct be_dma_mem *cmd,
 	}
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2536,7 +2536,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	struct be_cmd_write_flashrom *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 	adapter->flash_status = 0;
 
 	wrb = wrb_from_mccq(adapter);
@@ -2561,7 +2561,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(40000)))
@@ -2572,7 +2572,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2583,7 +2583,7 @@ static int be_cmd_get_flash_crc(struct be_adapter *adapter, u8 *flashed_crc,
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2610,7 +2610,7 @@ static int be_cmd_get_flash_crc(struct be_adapter *adapter, u8 *flashed_crc,
 		memcpy(flashed_crc, req->crc, 4);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3216,7 +3216,7 @@ int be_cmd_enable_magic_wol(struct be_adapter *adapter, u8 *mac,
 	struct be_cmd_req_acpi_wol_magic_config *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3233,7 +3233,7 @@ int be_cmd_enable_magic_wol(struct be_adapter *adapter, u8 *mac,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3248,7 +3248,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3271,7 +3271,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(SET_LB_MODE_TIMEOUT)))
@@ -3280,7 +3280,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3297,7 +3297,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3323,7 +3323,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 	if (status)
 		goto err;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	wait_for_completion(&adapter->et_cmd_compl);
 	resp = embedded_payload(wrb);
@@ -3331,7 +3331,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 
 	return status;
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3347,7 +3347,7 @@ int be_cmd_ddr_dma_test(struct be_adapter *adapter, u64 pattern,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3381,7 +3381,7 @@ int be_cmd_ddr_dma_test(struct be_adapter *adapter, u64 pattern,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3392,7 +3392,7 @@ int be_cmd_get_seeprom_data(struct be_adapter *adapter,
 	struct be_cmd_req_seeprom_read *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3408,7 +3408,7 @@ int be_cmd_get_seeprom_data(struct be_adapter *adapter,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3423,7 +3423,7 @@ int be_cmd_get_phy_info(struct be_adapter *adapter)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3468,7 +3468,7 @@ int be_cmd_get_phy_info(struct be_adapter *adapter)
 	}
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3478,7 +3478,7 @@ static int be_cmd_set_qos(struct be_adapter *adapter, u32 bps, u32 domain)
 	struct be_cmd_req_set_qos *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3498,7 +3498,7 @@ static int be_cmd_set_qos(struct be_adapter *adapter, u32 bps, u32 domain)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3610,7 +3610,7 @@ int be_cmd_get_fn_privileges(struct be_adapter *adapter, u32 *privilege,
 	struct be_cmd_req_get_fn_privileges *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3642,7 +3642,7 @@ int be_cmd_get_fn_privileges(struct be_adapter *adapter, u32 *privilege,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3654,7 +3654,7 @@ int be_cmd_set_fn_privileges(struct be_adapter *adapter, u32 privileges,
 	struct be_cmd_req_set_fn_privileges *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3674,7 +3674,7 @@ int be_cmd_set_fn_privileges(struct be_adapter *adapter, u32 privileges,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3706,7 +3706,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *adapter, u8 *mac,
 		return -ENOMEM;
 	}
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3770,7 +3770,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *adapter, u8 *mac,
 	}
 
 out:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, get_mac_list_cmd.size,
 			  get_mac_list_cmd.va, get_mac_list_cmd.dma);
 	return status;
@@ -3830,7 +3830,7 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 	if (!cmd.va)
 		return -ENOMEM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3852,7 +3852,7 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 
 err:
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3888,7 +3888,7 @@ int be_cmd_set_hsw_config(struct be_adapter *adapter, u16 pvid,
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3929,7 +3929,7 @@ int be_cmd_set_hsw_config(struct be_adapter *adapter, u16 pvid,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3943,7 +3943,7 @@ int be_cmd_get_hsw_config(struct be_adapter *adapter, u16 *pvid,
 	int status;
 	u16 vid;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3990,7 +3990,7 @@ int be_cmd_get_hsw_config(struct be_adapter *adapter, u16 *pvid,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4189,7 +4189,7 @@ int be_cmd_set_ext_fat_capabilites(struct be_adapter *adapter,
 	struct be_cmd_req_set_ext_fat_caps *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4205,7 +4205,7 @@ int be_cmd_set_ext_fat_capabilites(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4683,7 +4683,7 @@ int be_cmd_manage_iface(struct be_adapter *adapter, u32 iface, u8 op)
 	if (iface == 0xFFFFFFFF)
 		return -1;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4700,7 +4700,7 @@ int be_cmd_manage_iface(struct be_adapter *adapter, u32 iface, u8 op)
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4734,7 +4734,7 @@ int be_cmd_get_if_id(struct be_adapter *adapter, struct be_vf_cfg *vf_cfg,
 	struct be_cmd_resp_get_iface_list *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4755,7 +4755,7 @@ int be_cmd_get_if_id(struct be_adapter *adapter, struct be_vf_cfg *vf_cfg,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4849,7 +4849,7 @@ int be_cmd_enable_vf(struct be_adapter *adapter, u8 domain)
 	if (BEx_chip(adapter))
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4867,7 +4867,7 @@ int be_cmd_enable_vf(struct be_adapter *adapter, u8 domain)
 	req->enable = 1;
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4940,7 +4940,7 @@ __be_cmd_set_logical_link_config(struct be_adapter *adapter,
 	u32 link_config = 0;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4968,7 +4968,7 @@ __be_cmd_set_logical_link_config(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4999,8 +4999,7 @@ int be_cmd_set_features(struct be_adapter *adapter)
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	if (mutex_lock_interruptible(&adapter->mcc_lock))
-		return -1;
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -5038,7 +5037,7 @@ int be_cmd_set_features(struct be_adapter *adapter)
 		dev_info(&adapter->pdev->dev,
 			 "Adapter does not support HW error recovery\n");
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -5052,7 +5051,7 @@ int be_roce_mcc_cmd(void *netdev_handle, void *wrb_payload,
 	struct be_cmd_resp_hdr *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -5075,7 +5074,7 @@ int be_roce_mcc_cmd(void *netdev_handle, void *wrb_payload,
 	memcpy(wrb_payload, resp, sizeof(*resp) + resp->response_length);
 	be_dws_le_to_cpu(wrb_payload, sizeof(*resp) + resp->response_length);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 EXPORT_SYMBOL(be_roce_mcc_cmd);
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index b0a85c9b952b..173625a10886 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5672,8 +5672,8 @@ static int be_drv_init(struct be_adapter *adapter)
 	}
 
 	mutex_init(&adapter->mbox_lock);
-	mutex_init(&adapter->mcc_lock);
 	mutex_init(&adapter->rx_filter_lock);
+	spin_lock_init(&adapter->mcc_lock);
 	spin_lock_init(&adapter->mcc_cq_lock);
 	init_completion(&adapter->et_cmd_compl);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 0f06f95b09bc..4d4cea1f5015 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -496,7 +496,7 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 
 		ret = hclge_ptp_get_cycle(hdev);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = hclge_ptp_int_en(hdev, true);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 44991cae9404..071dca86fc88 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2237,6 +2237,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	unsigned int skblen;
 	union sub_crq tx_crq;
 	unsigned int offset;
+	bool use_scrq_send_direct = false;
 	int num_entries = 1;
 	unsigned char *dst;
 	int bufidx = 0;
@@ -2296,6 +2297,20 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	memset(dst, 0, tx_pool->buf_size);
 	data_dma_addr = ltb->addr + offset;
 
+	/* if we are going to send_subcrq_direct this then we need to
+	 * update the checksum before copying the data into ltb. Essentially
+	 * these packets force disable CSO so that we can guarantee that
+	 * FW does not need header info and we can send direct. Also, vnic
+	 * server must be able to xmit standard packets without header data
+	 */
+	if (*hdrs == 0 && !skb_is_gso(skb) &&
+	    !ind_bufp->index && !netdev_xmit_more()) {
+		use_scrq_send_direct = true;
+		if (skb->ip_summed == CHECKSUM_PARTIAL &&
+		    skb_checksum_help(skb))
+			use_scrq_send_direct = false;
+	}
+
 	if (skb_shinfo(skb)->nr_frags) {
 		int cur, i;
 
@@ -2381,11 +2396,13 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_crq.v1.flags1 |= IBMVNIC_TX_LSO;
 		tx_crq.v1.mss = cpu_to_be16(skb_shinfo(skb)->gso_size);
 		hdrs += 2;
-	} else if (!ind_bufp->index && !netdev_xmit_more()) {
-		ind_bufp->indir_arr[0] = tx_crq;
+	} else if (use_scrq_send_direct) {
+		/* See above comment, CSO disabled with direct xmit */
+		tx_crq.v1.flags1 &= ~(IBMVNIC_TX_CHKSUM_OFFLOAD);
 		ind_bufp->index = 1;
 		tx_buff->num_entries = 1;
 		netdev_tx_sent_queue(txq, skb->len);
+		ind_bufp->indir_arr[0] = tx_crq;
 		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, false);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index de14e89619c5..67d9efb05443 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -72,6 +72,17 @@
 #define PPP_PROTO_LEN	2
 #define PPP_LCP_HDRLEN	4
 
+/* The filter instructions generated by libpcap are constructed
+ * assuming a four-byte PPP header on each packet, where the last
+ * 2 bytes are the protocol field defined in the RFC and the first
+ * byte of the first 2 bytes indicates the direction.
+ * The second byte is currently unused, but we still need to initialize
+ * it to prevent crafted BPF programs from reading them which would
+ * cause reading of uninitialized data.
+ */
+#define PPP_FILTER_OUTBOUND_TAG 0x0100
+#define PPP_FILTER_INBOUND_TAG  0x0000
+
 /*
  * An instance of /dev/ppp can be associated with either a ppp
  * interface unit or a ppp channel.  In both cases, file->private_data
@@ -1762,10 +1773,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 
 	if (proto < 0x8000) {
 #ifdef CONFIG_PPP_FILTER
-		/* check if we should pass this packet */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
-		*(u8 *)skb_push(skb, 2) = 1;
+		/* check if the packet passes the pass and active filters.
+		 * See comment for PPP_FILTER_OUTBOUND_TAG above.
+		 */
+		*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_OUTBOUND_TAG);
 		if (ppp->pass_filter &&
 		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 			if (ppp->debug & 1)
@@ -2482,14 +2493,13 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 		/* network protocol frame - give it to the kernel */
 
 #ifdef CONFIG_PPP_FILTER
-		/* check if the packet passes the pass and active filters */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
 		if (ppp->pass_filter || ppp->active_filter) {
 			if (skb_unclone(skb, GFP_ATOMIC))
 				goto err;
-
-			*(u8 *)skb_push(skb, 2) = 0;
+			/* Check if the packet passes the pass and active filters.
+			 * See comment for PPP_FILTER_INBOUND_TAG above.
+			 */
+			*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_INBOUND_TAG);
 			if (ppp->pass_filter &&
 			    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 				if (ppp->debug & 1)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 024c37062a60..789393aa68cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1141,7 +1141,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*fseq_ver))
 				goto invalid_tlv_len;
-			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %s\n",
+			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %.32s\n",
 				 fseq_ver->version);
 			}
 			break;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 81574500a57c..125e22bd34e2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -520,10 +520,16 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	enum nvmet_tcp_recv_state queue_state;
+	struct nvmet_tcp_cmd *queue_cmd;
 	struct nvme_sgl_desc *sgl;
 	u32 len;
 
-	if (unlikely(cmd == queue->cmd)) {
+	/* Pairs with store_release in nvmet_prepare_receive_pdu() */
+	queue_state = smp_load_acquire(&queue->rcv_state);
+	queue_cmd = READ_ONCE(queue->cmd);
+
+	if (unlikely(cmd == queue_cmd)) {
 		sgl = &cmd->req.cmd->common.dptr.sgl;
 		len = le32_to_cpu(sgl->length);
 
@@ -532,7 +538,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		 * Avoid using helpers, this might happen before
 		 * nvmet_req_init is completed.
 		 */
-		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
+		if (queue_state == NVMET_TCP_RECV_PDU &&
 		    len && len <= cmd->req.port->inline_data_size &&
 		    nvme_is_write(cmd->req.cmd))
 			return;
@@ -784,8 +790,9 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
 {
 	queue->offset = 0;
 	queue->left = sizeof(struct nvme_tcp_hdr);
-	queue->cmd = NULL;
-	queue->rcv_state = NVMET_TCP_RECV_PDU;
+	WRITE_ONCE(queue->cmd, NULL);
+	/* Ensure rcv_state is visible only after queue->cmd is set */
+	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
 }
 
 static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7c5f6565de85..5a5d24eeb5f3 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -105,12 +105,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 
 	prop = of_get_flat_dt_prop(node, "alignment", &len);
 	if (prop) {
-		if (len != dt_root_size_cells * sizeof(__be32)) {
+		if (len != dt_root_addr_cells * sizeof(__be32)) {
 			pr_err("invalid alignment property in '%s' node.\n",
 				uname);
 			return -EINVAL;
 		}
-		align = dt_mem_next_cell(dt_root_size_cells, &prop);
+		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index bedc6cd51f39..a57e236be050 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10113,6 +10113,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 	 * Individual addressing is broken on models that expose the
 	 * primary battery as BAT1.
 	 */
+	TPACPI_Q_LNV('G', '8', true),       /* ThinkPad X131e */
 	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
 	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
 	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */
diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 43db495f1986..bfd5d3ccdce2 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1740,7 +1740,8 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 		err = rio_add_net(net);
 		if (err) {
 			rmcd_debug(RDEV, "failed to register net, err=%d", err);
-			kfree(net);
+			put_device(&net->dev);
+			mport->net = NULL;
 			goto cleanup;
 		}
 	}
diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index fdcf742b2adb..c12941f71e2c 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -871,7 +871,10 @@ static struct rio_net *rio_scan_alloc_net(struct rio_mport *mport,
 		dev_set_name(&net->dev, "rnet_%d", net->id);
 		net->dev.parent = &mport->dev;
 		net->dev.release = rio_scan_release_dev;
-		rio_add_net(net);
+		if (rio_add_net(net)) {
+			put_device(&net->dev);
+			net = NULL;
+		}
 	}
 
 	return net;
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index d3a5f10b8b83..57be02f8d5c1 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -6942,7 +6942,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
 	if (rc)
 		return;
 	/* Reset HBA FCF states after successful unregister FCF */
+	spin_lock_irq(&phba->hbalock);
 	phba->fcf.fcf_flag = 0;
+	spin_unlock_irq(&phba->hbalock);
 	phba->fcf.current_rec.flag = 0;
 
 	/*
diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 4ce0cb61e481..245e9c7f92cd 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -147,8 +147,9 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	}
 
 	ret = ctrl->xfer_msg(ctrl, txn);
-
-	if (!ret && need_tid && !txn->msg->comp) {
+	if (ret == -ETIMEDOUT) {
+		slim_free_txn_tid(ctrl, txn);
+	} else if (!ret && need_tid && !txn->msg->comp) {
 		unsigned long ms = txn->rl + HZ;
 
 		timeout = wait_for_completion_timeout(txn->comp,
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 55178579f3c6..b951bd5efdcd 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -39,6 +39,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/mxs-spi.h>
 #include <trace/events/spi.h>
+#include <linux/dma/mxs-dma.h>
 
 #define DRIVER_NAME		"mxs-spi"
 
@@ -252,7 +253,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 		desc = dmaengine_prep_slave_sg(ssp->dmach,
 				&dma_xfer[sg_count].sg, 1,
 				(flags & TXRX_WRITE) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
-				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+				DMA_PREP_INTERRUPT | MXS_DMA_CTRL_WAIT4END);
 
 		if (!desc) {
 			dev_err(ssp->dev,
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 8f3b9a0a38e1..1443e9cf631a 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1131,7 +1131,10 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
-	struct usb_endpoint_descriptor *in, *out;
+	static const u8 ep_addrs[] = {
+		CXACRU_EP_CMD + USB_DIR_IN,
+		CXACRU_EP_CMD + USB_DIR_OUT,
+		0};
 	int ret;
 
 	/* instance init */
@@ -1179,13 +1182,11 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	}
 
 	if (usb_endpoint_xfer_int(&cmd_ep->desc))
-		ret = usb_find_common_endpoints(intf->cur_altsetting,
-						NULL, NULL, &in, &out);
+		ret = usb_check_int_endpoints(intf, ep_addrs);
 	else
-		ret = usb_find_common_endpoints(intf->cur_altsetting,
-						&in, &out, NULL, NULL);
+		ret = usb_check_bulk_endpoints(intf, ep_addrs);
 
-	if (ret) {
+	if (!ret) {
 		usb_err(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");
 		ret = -ENODEV;
 		goto fail;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index ead112aeb3c3..7297bc7d138d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6017,6 +6017,36 @@ void usb_hub_cleanup(void)
 	usb_deregister(&hub_driver);
 } /* usb_hub_cleanup() */
 
+/**
+ * hub_hc_release_resources - clear resources used by host controller
+ * @udev: pointer to device being released
+ *
+ * Context: task context, might sleep
+ *
+ * Function releases the host controller resources in correct order before
+ * making any operation on resuming usb device. The host controller resources
+ * allocated for devices in tree should be released starting from the last
+ * usb device in tree toward the root hub. This function is used only during
+ * resuming device when usb device require reinitialization – that is, when
+ * flag udev->reset_resume is set.
+ *
+ * This call is synchronous, and may not be used in an interrupt context.
+ */
+static void hub_hc_release_resources(struct usb_device *udev)
+{
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev);
+	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	int i;
+
+	/* Release up resources for all children before this device */
+	for (i = 0; i < udev->maxchild; i++)
+		if (hub->ports[i]->child)
+			hub_hc_release_resources(hub->ports[i]->child);
+
+	if (hcd->driver->reset_device)
+		hcd->driver->reset_device(hcd, udev);
+}
+
 /**
  * usb_reset_and_verify_device - perform a USB port reset to reinitialize a device
  * @udev: device to reset (not in SUSPENDED or NOTATTACHED state)
@@ -6081,6 +6111,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	bos = udev->bos;
 	udev->bos = NULL;
 
+	if (udev->reset_resume)
+		hub_hc_release_resources(udev);
+
 	mutex_lock(hcd->address0_mutex);
 
 	for (i = 0; i < PORT_INIT_TRIES; ++i) {
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 027479179f09..6926bd639ec6 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -341,6 +341,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
 	  USB_QUIRK_STRING_FETCH_255 },
 
+	/* Prolific Single-LUN Mass Storage Card Reader */
+	{ USB_DEVICE(0x067b, 0x2731), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_NO_LPM },
+
 	/* Saitek Cyborg Gold Joystick */
 	{ USB_DEVICE(0x06a3, 0x0006), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7f46069c5dc3..324d7673e3c3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -125,11 +125,24 @@ void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 }
 
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
 {
+	unsigned int hw_mode;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+
+	 /*
+	  * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE and
+	  * GUSB2PHYCFG.SUSPHY should be cleared during mode switching,
+	  * and they can be set after core initialization.
+	  */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD && !ignore_susphy) {
+		if (DWC3_GCTL_PRTCAP(reg) != mode)
+			dwc3_enable_susphy(dwc, false);
+	}
+
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -209,7 +222,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	dwc3_set_prtcap(dwc, desired_dr_role);
+	dwc3_set_prtcap(dwc, desired_dr_role, false);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -727,16 +740,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	 */
 	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
 
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
-	 * cleared after power-on reset, and it can be set after core
-	 * initialization.
-	 */
+	/* Ensure the GUSB3PIPECTL.SUSPENDENABLE is cleared prior to phy init. */
 	reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	if (dwc->u2ss_inp3_quirk)
@@ -809,15 +813,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		break;
 	}
 
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
-	 * after power-on reset, and it can be set after core initialization.
-	 */
+	/* Ensure the GUSB2PHYCFG.SUSPHY is cleared prior to phy init. */
 	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	if (dwc->dis_enblslpm_quirk)
@@ -849,6 +845,25 @@ static int dwc3_clk_enable(struct dwc3 *dwc)
 	if (ret)
 		goto disable_ref_clk;
 
+	/*
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY to '0' during
+	 * coreConsultant configuration. So default value will be '0' when the
+	 * core is reset. Application needs to set it to '1' after the core
+	 * initialization is completed.
+	 *
+	 * Certain phy requires to be in P0 power state during initialization.
+	 * Make sure GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY are clear
+	 * prior to phy init to maintain in the P0 state.
+	 *
+	 * After phy initialization, some phy operations can only be executed
+	 * while in lower P states. Ensure GUSB3PIPECTL.SUSPENDENABLE and
+	 * GUSB2PHYCFG.SUSPHY are set soon after initialization to avoid
+	 * blocking phy ops.
+	 */
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
+		dwc3_enable_susphy(dwc, true);
+
 	return 0;
 
 disable_ref_clk:
@@ -1459,7 +1474,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
@@ -1471,7 +1486,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 			return dev_err_probe(dev, ret, "failed to initialize gadget\n");
 		break;
 	case USB_DR_MODE_HOST:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
@@ -1514,7 +1529,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	}
 
 	/* de-assert DRVVBUS for HOST and OTG mode */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
 static void dwc3_get_properties(struct dwc3 *dwc)
@@ -1677,8 +1692,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
 	dwc->tx_max_burst_prd = tx_max_burst_prd;
 
-	dwc->imod_interval = 0;
-
 	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
 }
 
@@ -1696,21 +1709,19 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	unsigned int hwparam_gen =
 		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
 
-	/* Check for proper value of imod_interval */
-	if (dwc->imod_interval && !dwc3_has_imod(dwc)) {
-		dev_warn(dwc->dev, "Interrupt moderation not supported\n");
-		dwc->imod_interval = 0;
-	}
-
 	/*
+	 * Enable IMOD for all supporting controllers.
+	 *
+	 * Particularly, DWC_usb3 v3.00a must enable this feature for
+	 * the following reason:
+	 *
 	 * Workaround for STAR 9000961433 which affects only version
 	 * 3.00a of the DWC_usb3 core. This prevents the controller
 	 * interrupt from being masked while handling events. IMOD
 	 * allows us to work around this issue. Enable it for the
 	 * affected version.
 	 */
-	if (!dwc->imod_interval &&
-	    DWC3_VER_IS(DWC3, 300A))
+	if (dwc3_has_imod((dwc)))
 		dwc->imod_interval = 1;
 
 	/* Check the maximum_speed parameter */
@@ -2217,7 +2228,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (ret)
 			return ret;
 
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 		dwc3_gadget_resume(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -2225,7 +2236,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, true);
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
@@ -2250,7 +2261,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (ret)
 			return ret;
 
-		dwc3_set_prtcap(dwc, dwc->current_dr_role);
+		dwc3_set_prtcap(dwc, dwc->current_dr_role, true);
 
 		dwc3_otg_init(dwc);
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 77aa59de8514..9a3cc6214569 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1517,7 +1517,7 @@ struct dwc3_gadget_ep_cmd_params {
 #define DWC3_HAS_OTG			BIT(3)
 
 /* prototypes */
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 57ddd2e43022..80bfe68cde62 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -173,7 +173,7 @@ void dwc3_otg_init(struct dwc3 *dwc)
 	 * block "Initialize GCTL for OTG operation".
 	 */
 	/* GCTL.PrtCapDir=2'b11 */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG, true);
 	/* GUSB2PHYCFG0.SusPHY=0 */
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
@@ -553,7 +553,7 @@ int dwc3_drd_init(struct dwc3 *dwc)
 
 		dwc3_drd_update(dwc);
 	} else {
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG, true);
 
 		/* use OTG block to get ID event */
 		irq = dwc3_otg_get_irq(dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5d9f25715a60..f227f6c7c6d7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4346,14 +4346,18 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 		    DWC3_GEVNTSIZ_SIZE(evt->length));
 
+	evt->flags &= ~DWC3_EVENT_PENDING;
+	/*
+	 * Add an explicit write memory barrier to make sure that the update of
+	 * clearing DWC3_EVENT_PENDING is observed in dwc3_check_event_buf()
+	 */
+	wmb();
+
 	if (dwc->imod_interval) {
 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
 		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
 	}
 
-	/* Keep the clearing of DWC3_EVENT_PENDING at the end */
-	evt->flags &= ~DWC3_EVENT_PENDING;
-
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 6b3c4cb718e2..87404340763d 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1018,10 +1018,11 @@ static int set_config(struct usb_composite_dev *cdev,
 	else
 		usb_gadget_set_remote_wakeup(gadget, 0);
 done:
-	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
-		usb_gadget_set_selfpowered(gadget);
-	else
+	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
+	    (c && !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER)))
 		usb_gadget_clear_selfpowered(gadget);
+	else
+		usb_gadget_set_selfpowered(gadget);
 
 	usb_gadget_vbus_draw(gadget, power);
 	if (result >= 0 && cdev->delayed_status)
@@ -2490,7 +2491,10 @@ void composite_suspend(struct usb_gadget *gadget)
 
 	cdev->suspended = 1;
 
-	usb_gadget_set_selfpowered(gadget);
+	if (cdev->config &&
+	    cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
+		usb_gadget_set_selfpowered(gadget);
+
 	usb_gadget_vbus_draw(gadget, 2);
 }
 
@@ -2519,8 +2523,11 @@ void composite_resume(struct usb_gadget *gadget)
 		else
 			maxpower = min(maxpower, 900U);
 
-		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW)
+		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW ||
+		    !(cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
 			usb_gadget_clear_selfpowered(gadget);
+		else
+			usb_gadget_set_selfpowered(gadget);
 
 		usb_gadget_vbus_draw(gadget, maxpower);
 	}
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 88402cf424d1..27c924ddb68e 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2388,7 +2388,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * and our use of dma addresses in the trb_address_map radix tree needs
 	 * TRB_SEGMENT_SIZE alignment, so we pick the greater alignment need.
 	 */
-	if (xhci->quirks & XHCI_ZHAOXIN_TRB_FETCH)
+	if (xhci->quirks & XHCI_TRB_OVERFETCH)
+		/* Buggy HC prefetches beyond segment bounds - allocate dummy space at the end */
 		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
 				TRB_SEGMENT_SIZE * 2, TRB_SEGMENT_SIZE * 2, xhci->page_size * 2);
 	else
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index e90ff21b7c54..ca27bc15209c 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -28,8 +28,8 @@
 #define SPARSE_CNTL_ENABLE	0xC12C
 
 /* Device for a quirk */
-#define PCI_VENDOR_ID_FRESCO_LOGIC	0x1b73
-#define PCI_DEVICE_ID_FRESCO_LOGIC_PDK	0x1000
+#define PCI_VENDOR_ID_FRESCO_LOGIC		0x1b73
+#define PCI_DEVICE_ID_FRESCO_LOGIC_PDK		0x1000
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1009	0x1009
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1100	0x1100
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1400	0x1400
@@ -38,8 +38,10 @@
 #define PCI_DEVICE_ID_EJ168		0x7023
 #define PCI_DEVICE_ID_EJ188		0x7052
 
-#define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
-#define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
+#define PCI_DEVICE_ID_VIA_VL805			0x3483
+
+#define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI		0x8c31
+#define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI		0x9c31
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_XHCI	0x9cb1
 #define PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI		0x22b5
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_XHCI		0xa12f
@@ -304,8 +306,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			pdev->device == 0x3432)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483)
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == PCI_DEVICE_ID_VIA_VL805) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
+		xhci->quirks |= XHCI_TRB_OVERFETCH;
+	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
@@ -353,11 +357,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 		if (pdev->device == 0x9202) {
 			xhci->quirks |= XHCI_RESET_ON_RESUME;
-			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+			xhci->quirks |= XHCI_TRB_OVERFETCH;
 		}
 
 		if (pdev->device == 0x9203)
-			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+			xhci->quirks |= XHCI_TRB_OVERFETCH;
 	}
 
 	if (pdev->vendor == PCI_DEVICE_ID_CADENCE &&
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 1a641f281c00..542a4b7fd7ce 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1659,7 +1659,7 @@ struct xhci_hcd {
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
-#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
+#define XHCI_TRB_OVERFETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 96f3939a65e2..9af61f17dfc7 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -312,8 +312,10 @@ static int usbhsc_clk_get(struct device *dev, struct usbhs_priv *priv)
 	priv->clks[1] = of_clk_get(dev_of_node(dev), 1);
 	if (PTR_ERR(priv->clks[1]) == -ENOENT)
 		priv->clks[1] = NULL;
-	else if (IS_ERR(priv->clks[1]))
+	else if (IS_ERR(priv->clks[1])) {
+		clk_put(priv->clks[0]);
 		return PTR_ERR(priv->clks[1]);
+	}
 
 	return 0;
 }
@@ -768,6 +770,8 @@ static int usbhs_remove(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "usb remove\n");
 
+	flush_delayed_work(&priv->notify_hotplug_work);
+
 	/* power off */
 	if (!usbhs_get_dparam(priv, runtime_pwctrl))
 		usbhsc_power_ctrl(priv, 0);
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 105132ae87ac..e8e5723f5412 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1094,7 +1094,7 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		goto usbhs_mod_gadget_probe_err_gpriv;
 	}
 
-	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
+	gpriv->transceiver = devm_usb_get_phy(dev, USB_PHY_TYPE_UNDEFINED);
 	dev_info(dev, "%stransceiver found\n",
 		 !IS_ERR(gpriv->transceiver) ? "" : "no ");
 
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 7b217c712c11..d608fefd4f30 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -332,6 +332,11 @@ static int rt1711h_probe(struct i2c_client *client,
 {
 	int ret;
 	struct rt1711h_chip *chip;
+	const u16 alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED |
+			       TCPC_ALERT_TX_FAILED | TCPC_ALERT_RX_HARD_RST |
+			       TCPC_ALERT_RX_STATUS | TCPC_ALERT_POWER_STATUS |
+			       TCPC_ALERT_CC_STATUS | TCPC_ALERT_RX_BUF_OVF |
+			       TCPC_ALERT_FAULT;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -380,6 +385,12 @@ static int rt1711h_probe(struct i2c_client *client,
 					dev_name(chip->dev), chip);
 	if (ret < 0)
 		return ret;
+
+	/* Enable alert interrupts */
+	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
+	if (ret < 0)
+		return ret;
+
 	enable_irq_wake(client->irq);
 
 	return 0;
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 1e4059521eb0..9c82dc94da81 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -25,7 +25,7 @@
  * difficult to estimate the time it takes for the system to process the command
  * before it is actually passed to the PPM.
  */
-#define UCSI_TIMEOUT_MS		5000
+#define UCSI_TIMEOUT_MS		10000
 
 /*
  * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 423ea888d79a..92730c08fd79 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -49,7 +49,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 	switch (cmd & PMCMD_TYPE_MASK) {
 	case ACRN_PMCMD_GET_PX_CNT:
 	case ACRN_PMCMD_GET_CX_CNT:
-		pm_info = kmalloc(sizeof(u64), GFP_KERNEL);
+		pm_info = kzalloc(sizeof(u64), GFP_KERNEL);
 		if (!pm_info)
 			return -ENOMEM;
 
@@ -64,7 +64,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 		kfree(pm_info);
 		break;
 	case ACRN_PMCMD_GET_PX_DATA:
-		px_data = kmalloc(sizeof(*px_data), GFP_KERNEL);
+		px_data = kzalloc(sizeof(*px_data), GFP_KERNEL);
 		if (!px_data)
 			return -ENOMEM;
 
@@ -79,7 +79,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 		kfree(px_data);
 		break;
 	case ACRN_PMCMD_GET_CX_DATA:
-		cx_data = kmalloc(sizeof(*cx_data), GFP_KERNEL);
+		cx_data = kzalloc(sizeof(*cx_data), GFP_KERNEL);
 		if (!cx_data)
 			return -ENOMEM;
 
diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 5b547a596380..32209acd51be 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -160,7 +160,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	return 0;
 }
 
-void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
+int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 {
 	int i, b;
 	unsigned int ent_idx;
@@ -169,13 +169,17 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	struct exfat_mount_options *opts = &sbi->options;
 
 	if (!is_valid_cluster(sbi, clu))
-		return;
+		return -EIO;
 
 	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
 	i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
 	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
 
+	if (!test_bit_le(b, sbi->vol_amap[i]->b_data))
+		return -EIO;
+
 	clear_bit_le(b, sbi->vol_amap[i]->b_data);
+
 	exfat_update_bh(sbi->vol_amap[i], sync);
 
 	if (opts->discard) {
@@ -190,6 +194,8 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 			opts->discard = 0;
 		}
 	}
+
+	return 0;
 }
 
 /*
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index c79c78bf265b..5a1251207ab2 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -419,7 +419,7 @@ int exfat_count_num_clusters(struct super_block *sb,
 int exfat_load_bitmap(struct super_block *sb);
 void exfat_free_bitmap(struct exfat_sb_info *sbi);
 int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync);
-void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
+int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
 int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index fe007ae2f23c..220ab671a815 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -175,6 +175,7 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 		BITMAP_OFFSET_SECTOR_INDEX(sb, CLUSTER_TO_BITMAP_ENT(clu));
 
 	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+		int err;
 		unsigned int last_cluster = p_chain->dir + p_chain->size - 1;
 		do {
 			bool sync = false;
@@ -189,7 +190,9 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 				cur_cmap_i = next_cmap_i;
 			}
 
-			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			err = exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			if (err)
+				break;
 			clu++;
 			num_clusters++;
 		} while (num_clusters < p_chain->size);
@@ -210,12 +213,13 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 				cur_cmap_i = next_cmap_i;
 			}
 
-			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			if (exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode))))
+				break;
 			clu = n_clu;
 			num_clusters++;
 
 			if (err)
-				goto dec_used_clus;
+				break;
 
 			if (num_clusters >= sbi->num_clusters - EXFAT_FIRST_CLUSTER) {
 				/*
@@ -229,7 +233,6 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 		} while (clu != EXFAT_EOF_CLUSTER);
 	}
 
-dec_used_clus:
 	sbi->used_clusters -= num_clusters;
 	return 0;
 }
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 889e3e570213..0f3753af1674 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -64,12 +64,6 @@ static inline unsigned int nilfs_chunk_size(struct inode *inode)
 	return inode->i_sb->s_blocksize;
 }
 
-static inline void nilfs_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 /*
  * Return the offset into page `page_nr' of the last valid
  * byte in that page, plus one.
@@ -450,8 +444,7 @@ int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino)
 	return 0;
 }
 
-/* Releases the page */
-void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
+int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 		    struct page *page, struct inode *inode)
 {
 	unsigned int from = (char *)de - (char *)page_address(page);
@@ -461,12 +454,15 @@ void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 
 	lock_page(page);
 	err = nilfs_prepare_chunk(page, from, to);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		unlock_page(page);
+		return err;
+	}
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, mapping, from, to);
-	nilfs_put_page(page);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
+	return 0;
 }
 
 /*
@@ -569,7 +565,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 
 /*
  * nilfs_delete_entry deletes a directory entry by merging it with the
- * previous entry. Page is up-to-date. Releases the page.
+ * previous entry. Page is up-to-date.
  */
 int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 {
@@ -598,14 +594,16 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 		from = (char *)pde - (char *)page_address(page);
 	lock_page(page);
 	err = nilfs_prepare_chunk(page, from, to);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		unlock_page(page);
+		goto out;
+	}
 	if (pde)
 		pde->rec_len = nilfs_rec_len_to_disk(to - from);
 	dir->inode = 0;
 	nilfs_commit_chunk(page, mapping, from, to);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 out:
-	nilfs_put_page(page);
 	return err;
 }
 
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index a14f6342a025..67d66207fae1 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -297,6 +297,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 		set_nlink(inode, 1);
 	}
 	err = nilfs_delete_entry(de, page);
+	nilfs_put_page(page);
 	if (err)
 		goto out;
 
@@ -405,7 +406,10 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
 			err = PTR_ERR(new_de);
 			goto out_dir;
 		}
-		nilfs_set_link(new_dir, new_de, new_page, old_inode);
+		err = nilfs_set_link(new_dir, new_de, new_page, old_inode);
+		nilfs_put_page(new_page);
+		if (unlikely(err))
+			goto out_dir;
 		nilfs_mark_inode_dirty(new_dir);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
@@ -428,28 +432,27 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
 	 */
 	old_inode->i_ctime = current_time(old_inode);
 
-	nilfs_delete_entry(old_de, old_page);
-
-	if (dir_de) {
-		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
-		drop_nlink(old_dir);
+	err = nilfs_delete_entry(old_de, old_page);
+	if (likely(!err)) {
+		if (dir_de) {
+			err = nilfs_set_link(old_inode, dir_de, dir_page,
+					     new_dir);
+			drop_nlink(old_dir);
+		}
+		nilfs_mark_inode_dirty(old_dir);
 	}
-	nilfs_mark_inode_dirty(old_dir);
 	nilfs_mark_inode_dirty(old_inode);
 
-	err = nilfs_transaction_commit(old_dir->i_sb);
-	return err;
-
 out_dir:
-	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
-	}
+	if (dir_de)
+		nilfs_put_page(dir_page);
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	nilfs_put_page(old_page);
 out:
-	nilfs_transaction_abort(old_dir->i_sb);
+	if (likely(!err))
+		err = nilfs_transaction_commit(old_dir->i_sb);
+	else
+		nilfs_transaction_abort(old_dir->i_sb);
 	return err;
 }
 
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 5a880b4edf3d..dadafad2fae7 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -240,8 +240,14 @@ nilfs_find_entry(struct inode *, const struct qstr *, struct page **);
 extern int nilfs_delete_entry(struct nilfs_dir_entry *, struct page *);
 extern int nilfs_empty_dir(struct inode *);
 extern struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct page **);
-extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
-			   struct page *, struct inode *);
+int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
+		   struct page *page, struct inode *inode);
+
+static inline void nilfs_put_page(struct page *page)
+{
+	kunmap(page);
+	put_page(page);
+}
 
 /* file.c */
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index b2b98631a000..bfb1f4c2f271 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -325,6 +325,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	} else {
 		if (attr->nres.c_unit)
 			return NULL;
+
+		if (alloc_size > mi->sbi->volume.size)
+			return NULL;
 	}
 
 	return attr;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 9d041fc558e3..646c4047d3b9 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7124,17 +7124,17 @@ int smb2_lock(struct ksmbd_work *work)
 		}
 
 no_check_cl:
+		flock = smb_lock->fl;
+		list_del(&smb_lock->llist);
+
 		if (smb_lock->zero_len) {
 			err = 0;
 			goto skip;
 		}
-
-		flock = smb_lock->fl;
-		list_del(&smb_lock->llist);
 retry:
 		rc = vfs_lock_file(filp, smb_lock->cmd, flock, NULL);
 skip:
-		if (flags & SMB2_LOCKFLAG_UNLOCK) {
+		if (smb_lock->flags & SMB2_LOCKFLAG_UNLOCK) {
 			if (!rc) {
 				ksmbd_debug(SMB, "File unlocked\n");
 			} else if (rc == -ENOENT) {
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 496855f755ac..d1a432af43fb 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -267,6 +267,7 @@ static int handle_response(int type, void *payload, size_t sz)
 		if (entry->type + 1 != type) {
 			pr_err("Waiting for IPC type %d, got %d. Ignore.\n",
 			       entry->type + 1, type);
+			continue;
 		}
 
 		entry->response = kvzalloc(sz, GFP_KERNEL);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7a22db17f3b5..4c8fc82fc27a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1724,6 +1724,7 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
+	t->utask = NULL;
 	if (utask->active_uprobe)
 		put_uprobe(utask->active_uprobe);
 
@@ -1733,7 +1734,6 @@ void uprobe_free_utask(struct task_struct *t)
 
 	xol_free_insn_slot(t);
 	kfree(utask);
-	t->utask = NULL;
 }
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eedbe66e0527..d30e0936cfec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3550,15 +3550,17 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 {
 	struct cfs_rq *prev_cfs_rq;
 	struct list_head *prev;
+	struct rq *rq = rq_of(cfs_rq);
 
 	if (cfs_rq->on_list) {
 		prev = cfs_rq->leaf_cfs_rq_list.prev;
 	} else {
-		struct rq *rq = rq_of(cfs_rq);
-
 		prev = rq->tmp_alone_branch;
 	}
 
+	if (prev == &rq->leaf_cfs_rq_list)
+		return false;
+
 	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
 
 	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index ec0da72e65aa..091a263e053f 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -346,6 +346,7 @@ void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
 		size -= to_go;
 	}
 }
+EXPORT_SYMBOL_GPL(kmsan_handle_dma);
 
 void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir)
diff --git a/mm/memory.c b/mm/memory.c
index 680d864d52eb..fd874df17b36 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2802,8 +2802,10 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(*pgd) && !create)
 			continue;
-		if (WARN_ON_ONCE(pgd_leaf(*pgd)))
-			return -EINVAL;
+		if (WARN_ON_ONCE(pgd_leaf(*pgd))) {
+			err = -EINVAL;
+			break;
+		}
 		if (!pgd_none(*pgd) && WARN_ON_ONCE(pgd_bad(*pgd))) {
 			if (!create)
 				continue;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6680ee77f963..65ad214e21f3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5092,6 +5092,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 restart:
 	compaction_retries = 0;
 	no_progress_loops = 0;
+	compact_result = COMPACT_SKIPPED;
 	compact_priority = DEF_COMPACT_PRIORITY;
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	zonelist_iter_cookie = zonelist_iter_begin();
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7c6694514606..562994159216 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -566,13 +566,13 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 			mask |= PGTBL_PGD_MODIFIED;
 		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
-			return err;
+			break;
 	} while (pgd++, addr = next, addr != end);
 
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
-	return 0;
+	return err;
 }
 
 /*
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index e40aa3e3641c..b477ba37a699 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -131,7 +131,8 @@ int vlan_check_real_dev(struct net_device *real_dev,
 {
 	const char *name = real_dev->name;
 
-	if (real_dev->features & NETIF_F_VLAN_CHALLENGED) {
+	if (real_dev->features & NETIF_F_VLAN_CHALLENGED ||
+	    real_dev->type != ARPHRD_ETHER) {
 		pr_info("VLANs not supported on %s\n", name);
 		NL_SET_ERR_MSG_MOD(extack, "VLANs not supported on device");
 		return -EOPNOTSUPP;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4f116e8c84a0..27bd8c8ddeb0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9733,6 +9733,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 				     sizeof(*ev) + (name ? eir_precalc_len(name_len) : 0) +
 				     eir_precalc_len(sizeof(conn->dev_class)));
 
+	if (!skb)
+		return;
+
 	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, &conn->dst);
 	ev->addr.type = link_to_bdaddr(conn->type, conn->dst_type);
@@ -10514,6 +10517,8 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND,
 			     sizeof(*ev) + (name ? eir_precalc_len(name_len) : 0));
+	if (!skb)
+		return;
 
 	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, bdaddr);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 72a645bf05c9..ce84073e0b7b 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -12,12 +12,15 @@
 #include <net/tcp.h>
 #include <net/protocol.h>
 
-static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
+static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_skb,
 			   unsigned int seq, unsigned int mss)
 {
+	u32 flags = skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
+	u32 ts_seq = skb_shinfo(gso_skb)->tskey;
+
 	while (skb) {
 		if (before(ts_seq, seq + mss)) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_SW_TSTAMP;
+			skb_shinfo(skb)->tx_flags |= flags;
 			skb_shinfo(skb)->tskey = ts_seq;
 			return;
 		}
@@ -119,8 +122,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	th = tcp_hdr(skb);
 	seq = ntohl(th->seq);
 
-	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
-		tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss);
+	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP))
+		tcp_gso_tstamp(segs, gso_skb, seq, mss);
 
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 1456c8c2b8db..2f1f038b0dc1 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -314,13 +314,17 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
 	copy_dtor = gso_skb->destructor == sock_wfree;
-	if (copy_dtor)
+	if (copy_dtor) {
 		gso_skb->destructor = NULL;
+		gso_skb->sk = NULL;
+	}
 
 	segs = skb_segment(gso_skb, features);
 	if (IS_ERR_OR_NULL(segs)) {
-		if (copy_dtor)
+		if (copy_dtor) {
 			gso_skb->destructor = sock_wfree;
+			gso_skb->sk = sk;
+		}
 		return segs;
 	}
 
diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 9d37f7164e73..7397f764c66c 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -88,13 +88,15 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		if (ilwt->connected) {
+		/* cache only if we don't create a dst reference loop */
+		if (ilwt->connected && orig_dst->lwtstate != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->dst_cache, dst, &fl6.saddr);
 			local_bh_enable();
 		}
 	}
 
+	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 	return dst_output(net, sk, skb);
 
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 06fb8e6944b0..7a0cae9a8111 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -24,7 +24,7 @@
 #include <net/llc_s_ac.h>
 #include <net/llc_s_ev.h>
 #include <net/llc_sap.h>
-
+#include <net/sock.h>
 
 /**
  *	llc_sap_action_unitdata_ind - forward UI PDU to network layer
@@ -40,6 +40,26 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 	return 0;
 }
 
+static int llc_prepare_and_xmit(struct sk_buff *skb)
+{
+	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
+	struct sk_buff *nskb;
+	int rc;
+
+	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
+	if (rc)
+		return rc;
+
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return -ENOMEM;
+
+	if (skb->sk)
+		skb_set_owner_w(nskb, skb->sk);
+
+	return dev_queue_xmit(nskb);
+}
+
 /**
  *	llc_sap_action_send_ui - sends UI PDU resp to UNITDATA REQ to MAC layer
  *	@sap: SAP
@@ -52,17 +72,12 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -77,17 +92,12 @@ int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_xid_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U_XID, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_xid_cmd(skb, LLC_XID_NULL_CLASS_2, 0);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -133,17 +143,12 @@ int llc_sap_action_send_xid_r(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_test_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_test_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fef7bb2a08d8..3391d4df2dbb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -969,7 +969,7 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id)
+					     bool needs_id, bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -1003,6 +1003,17 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 			if (entry->addr.id)
 				goto out;
 
+			/* allow callers that only need to look up the local
+			 * addr's id to skip replacement. This allows them to
+			 * avoid calling synchronize_rcu in the packet recv
+			 * path.
+			 */
+			if (!replace) {
+				kfree(entry);
+				ret = cur->addr.id;
+				goto out;
+			}
+
 			pernet->addrs--;
 			entry->addr.id = cur->addr.id;
 			list_del_rcu(&cur->list);
@@ -1149,7 +1160,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1444,7 +1455,8 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info));
+						!mptcp_pm_has_addr_attr_id(attr, info),
+						true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
 		goto out_free;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 88b5702a0a47..e78c9209e0b4 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -116,12 +116,14 @@
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
 static void vsock_sk_destruct(struct sock *sk);
 static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
+static void vsock_close(struct sock *sk, long timeout);
 
 /* Protocol family. */
 static struct proto vsock_proto = {
 	.name = "AF_VSOCK",
 	.owner = THIS_MODULE,
 	.obj_size = sizeof(struct vsock_sock),
+	.close = vsock_close,
 };
 
 /* The default peer timeout indicates how long we will wait for a peer response
@@ -331,7 +333,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
 void vsock_remove_sock(struct vsock_sock *vsk)
 {
-	vsock_remove_bound(vsk);
+	/* Transport reassignment must not remove the binding. */
+	if (sock_flag(sk_vsock(vsk), SOCK_DEAD))
+		vsock_remove_bound(vsk);
+
 	vsock_remove_connected(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_sock);
@@ -803,39 +808,44 @@ static bool sock_type_connectible(u16 type)
 
 static void __vsock_release(struct sock *sk, int level)
 {
-	if (sk) {
-		struct sock *pending;
-		struct vsock_sock *vsk;
+	struct vsock_sock *vsk;
+	struct sock *pending;
 
-		vsk = vsock_sk(sk);
-		pending = NULL;	/* Compiler warning. */
+	vsk = vsock_sk(sk);
+	pending = NULL;	/* Compiler warning. */
 
-		/* When "level" is SINGLE_DEPTH_NESTING, use the nested
-		 * version to avoid the warning "possible recursive locking
-		 * detected". When "level" is 0, lock_sock_nested(sk, level)
-		 * is the same as lock_sock(sk).
-		 */
-		lock_sock_nested(sk, level);
+	/* When "level" is SINGLE_DEPTH_NESTING, use the nested
+	 * version to avoid the warning "possible recursive locking
+	 * detected". When "level" is 0, lock_sock_nested(sk, level)
+	 * is the same as lock_sock(sk).
+	 */
+	lock_sock_nested(sk, level);
 
-		if (vsk->transport)
-			vsk->transport->release(vsk);
-		else if (sock_type_connectible(sk->sk_type))
-			vsock_remove_sock(vsk);
+	/* Indicate to vsock_remove_sock() that the socket is being released and
+	 * can be removed from the bound_table. Unlike transport reassignment
+	 * case, where the socket must remain bound despite vsock_remove_sock()
+	 * being called from the transport release() callback.
+	 */
+	sock_set_flag(sk, SOCK_DEAD);
 
-		sock_orphan(sk);
-		sk->sk_shutdown = SHUTDOWN_MASK;
+	if (vsk->transport)
+		vsk->transport->release(vsk);
+	else if (sock_type_connectible(sk->sk_type))
+		vsock_remove_sock(vsk);
 
-		skb_queue_purge(&sk->sk_receive_queue);
+	sock_orphan(sk);
+	sk->sk_shutdown = SHUTDOWN_MASK;
 
-		/* Clean up any sockets that never were accepted. */
-		while ((pending = vsock_dequeue_accept(sk)) != NULL) {
-			__vsock_release(pending, SINGLE_DEPTH_NESTING);
-			sock_put(pending);
-		}
+	skb_queue_purge(&sk->sk_receive_queue);
 
-		release_sock(sk);
-		sock_put(sk);
+	/* Clean up any sockets that never were accepted. */
+	while ((pending = vsock_dequeue_accept(sk)) != NULL) {
+		__vsock_release(pending, SINGLE_DEPTH_NESTING);
+		sock_put(pending);
 	}
+
+	release_sock(sk);
+	sock_put(sk);
 }
 
 static void vsock_sk_destruct(struct sock *sk)
@@ -912,9 +922,22 @@ void vsock_data_ready(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(vsock_data_ready);
 
+/* Dummy callback required by sockmap.
+ * See unconditional call of saved_close() in sock_map_close().
+ */
+static void vsock_close(struct sock *sk, long timeout)
+{
+}
+
 static int vsock_release(struct socket *sock)
 {
-	__vsock_release(sock->sk, 0);
+	struct sock *sk = sock->sk;
+
+	if (!sk)
+		return 0;
+
+	sk->sk_prot->close(sk, 0);
+	__vsock_release(sk, 0);
 	sock->sk = NULL;
 	sock->state = SS_FREE;
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0ba824c3fd1b..3ff2fe98a974 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4050,6 +4050,11 @@ static int parse_monitor_flags(struct nlattr *nla, u32 *mntrflags)
 		if (flags[flag])
 			*mntrflags |= (1<<flag);
 
+	/* cooked monitor mode is incompatible with other modes */
+	if (*mntrflags & MONITOR_FLAG_COOK_FRAMES &&
+	    *mntrflags != MONITOR_FLAG_COOK_FRAMES)
+		return -EOPNOTSUPP;
+
 	*mntrflags |= MONITOR_FLAG_CHANGED;
 
 	return 0;
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 5da1a641ef17..34a6bc43119b 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -405,7 +405,8 @@ static bool is_an_alpha2(const char *alpha2)
 {
 	if (!alpha2)
 		return false;
-	return isalpha(alpha2[0]) && isalpha(alpha2[1]);
+	return isascii(alpha2[0]) && isalpha(alpha2[0]) &&
+	       isascii(alpha2[1]) && isalpha(alpha2[1]);
 }
 
 static bool alpha2_equal(const char *alpha2_x, const char *alpha2_y)
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index d29d8372a3c0..fa083b01aed5 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -132,6 +132,7 @@ comment "Set to Y if you want auto-loading the side codec driver"
 
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
+	depends on INPUT
 	select SND_HDA_GENERIC
 	select SND_HDA_GENERIC_LEDS
 	help
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b8d769b2d0f9..56ee7708f6c4 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2217,6 +2217,8 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
 	/* KONTRON SinglePC may cause a stall at runtime resume */
 	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
+	/* Dell ALC3271 */
+	SND_PCI_QUIRK(0x1028, 0x0962, "Dell ALC3271", 0),
 	{}
 };
 #endif /* CONFIG_PM */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 96725b6599ec..e5e222e74d78 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3831,6 +3831,79 @@ static void alc225_shutup(struct hda_codec *codec)
 	}
 }
 
+static void alc222_init(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
+	bool hp1_pin_sense, hp2_pin_sense;
+
+	if (!hp_pin)
+		return;
+
+	msleep(30);
+
+	hp1_pin_sense = snd_hda_jack_detect(codec, hp_pin);
+	hp2_pin_sense = snd_hda_jack_detect(codec, 0x14);
+
+	if (hp1_pin_sense || hp2_pin_sense) {
+		msleep(2);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		msleep(75);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+
+		msleep(75);
+	}
+}
+
+static void alc222_shutup(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
+	bool hp1_pin_sense, hp2_pin_sense;
+
+	if (!hp_pin)
+		hp_pin = 0x21;
+
+	hp1_pin_sense = snd_hda_jack_detect(codec, hp_pin);
+	hp2_pin_sense = snd_hda_jack_detect(codec, 0x14);
+
+	if (hp1_pin_sense || hp2_pin_sense) {
+		msleep(2);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+		msleep(75);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+		msleep(75);
+	}
+	alc_auto_setup_eapd(codec, false);
+	alc_shutup_pins(codec);
+}
+
 static void alc_default_init(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -4789,7 +4862,6 @@ static void alc298_fixup_samsung_amp(struct hda_codec *codec,
 	}
 }
 
-#if IS_REACHABLE(CONFIG_INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
@@ -4898,10 +4970,6 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
 		spec->kb_dev = NULL;
 	}
 }
-#else /* INPUT */
-#define alc280_fixup_hp_gpio2_mic_hotkey	NULL
-#define alc233_fixup_lenovo_line2_mic_hotkey	NULL
-#endif /* INPUT */
 
 static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
@@ -4915,6 +4983,16 @@ static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 	}
 }
 
+static void alc233_fixup_lenovo_low_en_micmute_led(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->micmute_led_polarity = 1;
+	alc233_fixup_lenovo_line2_mic_hotkey(codec, fix, action);
+}
+
 static void alc_hp_mute_disable(struct hda_codec *codec, unsigned int delay)
 {
 	if (delay <= 0)
@@ -7220,6 +7298,7 @@ enum {
 	ALC275_FIXUP_DELL_XPS,
 	ALC293_FIXUP_LENOVO_SPK_NOISE,
 	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
+	ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED,
 	ALC255_FIXUP_DELL_SPK_NOISE,
 	ALC225_FIXUP_DISABLE_MIC_VREF,
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -8180,6 +8259,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc233_fixup_lenovo_line2_mic_hotkey,
 	},
+	[ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc233_fixup_lenovo_low_en_micmute_led,
+	},
 	[ALC233_FIXUP_INTEL_NUC8_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic,
@@ -10170,6 +10253,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3178, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x17aa, 0x3384, "ThinkCentre M90a PRO", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
+	SND_PCI_QUIRK(0x17aa, 0x3386, "ThinkCentre M90a Gen6", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
+	SND_PCI_QUIRK(0x17aa, 0x3387, "ThinkCentre M70a Gen6", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
@@ -11093,8 +11179,11 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->codec_variant = ALC269_TYPE_ALC300;
 		spec->gen.mixer_nid = 0; /* no loopback on ALC300 */
 		break;
+	case 0x10ec0222:
 	case 0x10ec0623:
 		spec->codec_variant = ALC269_TYPE_ALC623;
+		spec->shutup = alc222_shutup;
+		spec->init_hook = alc222_init;
 		break;
 	case 0x10ec0700:
 	case 0x10ec0701:
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 4c4ce0319d62..0fe989a63376 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -151,6 +151,12 @@ static int snd_usx2y_card_used[SNDRV_CARDS];
 static void snd_usx2y_card_private_free(struct snd_card *card);
 static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s);
 
+#ifdef USX2Y_NRPACKS_VARIABLE
+int nrpacks = USX2Y_NRPACKS; /* number of packets per urb */
+module_param(nrpacks, int, 0444);
+MODULE_PARM_DESC(nrpacks, "Number of packets per URB.");
+#endif
+
 /*
  * pipe 4 is used for switching the lamps, setting samplerate, volumes ....
  */
@@ -433,6 +439,11 @@ static int snd_usx2y_probe(struct usb_interface *intf,
 	struct snd_card *card;
 	int err;
 
+#ifdef USX2Y_NRPACKS_VARIABLE
+	if (nrpacks < 0 || nrpacks > USX2Y_NRPACKS_MAX)
+		return -EINVAL;
+#endif
+
 	if (le16_to_cpu(device->descriptor.idVendor) != 0x1604 ||
 	    (le16_to_cpu(device->descriptor.idProduct) != USB_ID_US122 &&
 	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US224 &&
diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index 8d82f5cc2fe1..0538c457921e 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -7,6 +7,32 @@
 
 #define NRURBS	        2
 
+/* Default value used for nr of packs per urb.
+ * 1 to 4 have been tested ok on uhci.
+ * To use 3 on ohci, you'd need a patch:
+ * look for "0000425-linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz" on
+ * "https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425"
+ *
+ * 1, 2 and 4 work out of the box on ohci, if I recall correctly.
+ * Bigger is safer operation, smaller gives lower latencies.
+ */
+#define USX2Y_NRPACKS 4
+
+#define USX2Y_NRPACKS_MAX 1024
+
+/* If your system works ok with this module's parameter
+ * nrpacks set to 1, you might as well comment
+ * this define out, and thereby produce smaller, faster code.
+ * You'd also set USX2Y_NRPACKS to 1 then.
+ */
+#define USX2Y_NRPACKS_VARIABLE 1
+
+#ifdef USX2Y_NRPACKS_VARIABLE
+extern int nrpacks;
+#define nr_of_packs() nrpacks
+#else
+#define nr_of_packs() USX2Y_NRPACKS
+#endif
 
 #define URBS_ASYNC_SEQ 10
 #define URB_DATA_LEN_ASYNC_SEQ 32
diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 5197599e7aa6..98d0e8edc983 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -28,33 +28,6 @@
 #include "usx2y.h"
 #include "usbusx2y.h"
 
-/* Default value used for nr of packs per urb.
- * 1 to 4 have been tested ok on uhci.
- * To use 3 on ohci, you'd need a patch:
- * look for "0000425-linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz" on
- * "https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425"
- *
- * 1, 2 and 4 work out of the box on ohci, if I recall correctly.
- * Bigger is safer operation, smaller gives lower latencies.
- */
-#define USX2Y_NRPACKS 4
-
-/* If your system works ok with this module's parameter
- * nrpacks set to 1, you might as well comment
- * this define out, and thereby produce smaller, faster code.
- * You'd also set USX2Y_NRPACKS to 1 then.
- */
-#define USX2Y_NRPACKS_VARIABLE 1
-
-#ifdef USX2Y_NRPACKS_VARIABLE
-static int nrpacks = USX2Y_NRPACKS; /* number of packets per urb */
-#define  nr_of_packs() nrpacks
-module_param(nrpacks, int, 0444);
-MODULE_PARM_DESC(nrpacks, "Number of packets per URB.");
-#else
-#define nr_of_packs() USX2Y_NRPACKS
-#endif
-
 static int usx2y_urb_capt_retire(struct snd_usx2y_substream *subs)
 {
 	struct urb	*urb = subs->completed_urb;

