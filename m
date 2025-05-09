Return-Path: <stable+bounces-142986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6936CAB0C9C
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB924E06E7
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA64E274665;
	Fri,  9 May 2025 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MSkwJdkz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0A27465C;
	Fri,  9 May 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746777996; cv=none; b=TbXDZ/GRSf6cQrq8wJodICnLbiqrvZfdM9AxAksjDsWieBdKf1jm3cQs6ioaOd0M0UnIxVSaJmQG3Cy7Tz5NBdquax7lf3GjSDgQKXHBHaJEtK95d5vxJEAOBC1unGTIcD8vVyiTTN3z1yaDsFUe00TRykAvbgOOJVQ2QsFK8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746777996; c=relaxed/simple;
	bh=2NV4Eczf1HeSv/QMN8HrZ9BDYad74exEX1BsZwq/G9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0POIYFTADv8WYOCPKQV5kMSWtTDo9Ex2l+F/WuGpW/BIyNxM4qTP3ugk8VF56IJcdmUvMaCmS/Pj4FrPTrIfiUdzYC7BU/zZxCPIPBHAJ8mToK0TUllhnGspCVdx73XOh5a+v6RBHXrv5rpF7cvrrglgTh7haypciapVRLYETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MSkwJdkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51329C4CEEF;
	Fri,  9 May 2025 08:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746777995;
	bh=2NV4Eczf1HeSv/QMN8HrZ9BDYad74exEX1BsZwq/G9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSkwJdkzeqPr3z9e1zW0ShZooFsHH5ZAvmuBFORskg7zaYlO5UTQyqaCnas5kkri5
	 QE9xLgOjTcD7ZkBdlFDbqbuYHxkVIfqtw3hoid9dREvOmMCa+c9MCGn4xNncmZCdcp
	 uIqsWEeXS7CXcA4fhkbLeCFekPY65WUuZW70g3AY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.138
Date: Fri,  9 May 2025 10:06:23 +0200
Message-ID: <2025050923-chill-matching-f195@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025050923-zigzagged-hardcore-0182@gregkh>
References: <2025050923-zigzagged-hardcore-0182@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index d1994bf77e8f..d8d39fe5ef70 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 137
+SUBLEVEL = 138
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi b/arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi
index f2386dcb9ff2..dda4fa91b2f2 100644
--- a/arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi
@@ -40,6 +40,9 @@ ethphy1: ethernet-phy@1 {
 			reg = <1>;
 			interrupt-parent = <&gpio4>;
 			interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+			micrel,led-mode = <1>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
 			status = "okay";
 		};
 	};
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 93a00cd42edd..3d12fc5af87b 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -891,10 +891,12 @@ static u8 spectre_bhb_loop_affected(void)
 	static const struct midr_range spectre_bhb_k132_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+		{},
 	};
 	static const struct midr_range spectre_bhb_k38_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+		{},
 	};
 	static const struct midr_range spectre_bhb_k32_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
diff --git a/arch/parisc/math-emu/driver.c b/arch/parisc/math-emu/driver.c
index 6ce427b58836..ecd27b48d61f 100644
--- a/arch/parisc/math-emu/driver.c
+++ b/arch/parisc/math-emu/driver.c
@@ -103,9 +103,19 @@ handle_fpe(struct pt_regs *regs)
 
 	memcpy(regs->fr, frcopy, sizeof regs->fr);
 	if (signalcode != 0) {
-	    force_sig_fault(signalcode >> 24, signalcode & 0xffffff,
-			    (void __user *) regs->iaoq[0]);
-	    return -1;
+		int sig = signalcode >> 24;
+
+		if (sig == SIGFPE) {
+			/*
+			 * Clear floating point trap bit to avoid trapping
+			 * again on the first floating-point instruction in
+			 * the userspace signal handler.
+			 */
+			regs->fr[0] &= ~(1ULL << 38);
+		}
+		force_sig_fault(sig, signalcode & 0xffffff,
+				(void __user *) regs->iaoq[0]);
+		return -1;
 	}
 
 	return signalcode ? -1 : 0;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 46677cad3a39..b380fc5ea088 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4177,7 +4177,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	arr[pebs_enable] = (struct perf_guest_switch_msr){
 		.msr = MSR_IA32_PEBS_ENABLE,
 		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
-		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
+		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
 	};
 
 	if (arr[pebs_enable].host) {
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index e2e1ec99c999..256eee99afc8 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -16,7 +16,6 @@
 # define PAGES_NR		4
 #endif
 
-# define KEXEC_CONTROL_PAGE_SIZE	4096
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
 #ifndef __ASSEMBLY__
@@ -45,6 +44,7 @@ struct kimage;
 /* Maximum address we can use for the control code buffer */
 # define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
 
+# define KEXEC_CONTROL_PAGE_SIZE	4096
 
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_386
@@ -59,6 +59,9 @@ struct kimage;
 /* Maximum address we can use for the control pages */
 # define KEXEC_CONTROL_MEMORY_LIMIT     (MAXMEM-1)
 
+/* Allocate one page for the pdp and the second for the code */
+# define KEXEC_CONTROL_PAGE_SIZE  (4096UL + 4096UL)
+
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
 #endif
@@ -143,19 +146,6 @@ struct kimage_arch {
 };
 #else
 struct kimage_arch {
-	/*
-	 * This is a kimage control page, as it must not overlap with either
-	 * source or destination address ranges.
-	 */
-	pgd_t *pgd;
-	/*
-	 * The virtual mapping of the control code page itself is used only
-	 * during the transition, while the current kernel's pages are all
-	 * in place. Thus the intermediate page table pages used to map it
-	 * are not control pages, but instead just normal pages obtained
-	 * with get_zeroed_page(). And have to be tracked (below) so that
-	 * they can be freed.
-	 */
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index abc07d004589..29bef25ac77c 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -47,6 +47,7 @@ KVM_X86_OP(set_idt)
 KVM_X86_OP(get_gdt)
 KVM_X86_OP(set_gdt)
 KVM_X86_OP(sync_dirty_debug_regs)
+KVM_X86_OP(set_dr6)
 KVM_X86_OP(set_dr7)
 KVM_X86_OP(cache_reg)
 KVM_X86_OP(get_rflags)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9de3db4a32f8..eb06c2f68314 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1499,6 +1499,7 @@ struct kvm_x86_ops {
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
+	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 5d61a342871b..24b6eaacc81e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -149,8 +149,7 @@ static void free_transition_pgtable(struct kimage *image)
 	image->arch.pte = NULL;
 }
 
-static int init_transition_pgtable(struct kimage *image, pgd_t *pgd,
-				   unsigned long control_page)
+static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 {
 	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
 	unsigned long vaddr, paddr;
@@ -161,7 +160,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd,
 	pte_t *pte;
 
 	vaddr = (unsigned long)relocate_kernel;
-	paddr = control_page;
+	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
 	pgd += pgd_index(vaddr);
 	if (!pgd_present(*pgd)) {
 		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
@@ -220,7 +219,7 @@ static void *alloc_pgt_page(void *data)
 	return p;
 }
 
-static int init_pgtable(struct kimage *image, unsigned long control_page)
+static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 {
 	struct x86_mapping_info info = {
 		.alloc_pgt_page	= alloc_pgt_page,
@@ -229,12 +228,12 @@ static int init_pgtable(struct kimage *image, unsigned long control_page)
 		.kernpg_flag	= _KERNPG_TABLE_NOENC,
 	};
 	unsigned long mstart, mend;
+	pgd_t *level4p;
 	int result;
 	int i;
 
-	image->arch.pgd = alloc_pgt_page(image);
-	if (!image->arch.pgd)
-		return -ENOMEM;
+	level4p = (pgd_t *)__va(start_pgtable);
+	clear_page(level4p);
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		info.page_flag   |= _PAGE_ENC;
@@ -248,8 +247,8 @@ static int init_pgtable(struct kimage *image, unsigned long control_page)
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
 
-		result = kernel_ident_mapping_init(&info, image->arch.pgd,
-						   mstart, mend);
+		result = kernel_ident_mapping_init(&info,
+						 level4p, mstart, mend);
 		if (result)
 			return result;
 	}
@@ -264,8 +263,8 @@ static int init_pgtable(struct kimage *image, unsigned long control_page)
 		mstart = image->segment[i].mem;
 		mend   = mstart + image->segment[i].memsz;
 
-		result = kernel_ident_mapping_init(&info, image->arch.pgd,
-						   mstart, mend);
+		result = kernel_ident_mapping_init(&info,
+						 level4p, mstart, mend);
 
 		if (result)
 			return result;
@@ -275,19 +274,15 @@ static int init_pgtable(struct kimage *image, unsigned long control_page)
 	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
 	 * not covered by pfn_mapped.
 	 */
-	result = map_efi_systab(&info, image->arch.pgd);
+	result = map_efi_systab(&info, level4p);
 	if (result)
 		return result;
 
-	result = map_acpi_tables(&info, image->arch.pgd);
+	result = map_acpi_tables(&info, level4p);
 	if (result)
 		return result;
 
-	/*
-	 * This must be last because the intermediate page table pages it
-	 * allocates will not be control pages and may overlap the image.
-	 */
-	return init_transition_pgtable(image, image->arch.pgd, control_page);
+	return init_transition_pgtable(image, level4p);
 }
 
 static void load_segments(void)
@@ -304,14 +299,14 @@ static void load_segments(void)
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long control_page;
+	unsigned long start_pgtable;
 	int result;
 
 	/* Calculate the offsets */
-	control_page = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 
 	/* Setup the identity mapped 64bit page table */
-	result = init_pgtable(image, control_page);
+	result = init_pgtable(image, start_pgtable);
 	if (result)
 		return result;
 
@@ -358,12 +353,13 @@ void machine_kexec(struct kimage *image)
 #endif
 	}
 
-	control_page = page_address(image->control_code_page);
+	control_page = page_address(image->control_code_page) + PAGE_SIZE;
 	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-	page_list[PA_TABLE_PAGE] = (unsigned long)__pa(image->arch.pgd);
+	page_list[PA_TABLE_PAGE] =
+	  (unsigned long)__pa(page_address(image->control_code_page));
 
 	if (image->type == KEXEC_TYPE_DEFAULT)
 		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
@@ -582,7 +578,8 @@ static void kexec_mark_crashkres(bool protect)
 
 	/* Don't touch the control code page used in crash_kexec().*/
 	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
-	kexec_mark_range(crashk_res.start, control - 1, protect);
+	/* Control code page is located in the 2nd page. */
+	kexec_mark_range(crashk_res.start, control + PAGE_SIZE - 1, protect);
 	control += KEXEC_CONTROL_PAGE_SIZE;
 	kexec_mark_range(control, crashk_res.end, protect);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d7d1b0f7073f..920e4a3583ab 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1920,11 +1920,11 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
 	svm->asid = sd->next_asid++;
 }
 
-static void svm_set_dr6(struct vcpu_svm *svm, unsigned long value)
+static void svm_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
 {
-	struct vmcb *vmcb = svm->vmcb;
+	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
 
-	if (svm->vcpu.arch.guest_state_protected)
+	if (vcpu->arch.guest_state_protected)
 		return;
 
 	if (unlikely(value != vmcb->save.dr6)) {
@@ -4035,10 +4035,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * Run with all-zero DR6 unless needed, so that we can get the exact cause
 	 * of a #DB.
 	 */
-	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-		svm_set_dr6(svm, vcpu->arch.dr6);
-	else
-		svm_set_dr6(svm, DR6_ACTIVE_LOW);
+	if (likely(!(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)))
+		svm_set_dr6(vcpu, DR6_ACTIVE_LOW);
 
 	clgi();
 	kvm_load_guest_xsave_state(vcpu);
@@ -4807,6 +4805,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
+	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
 	.cache_reg = svm_cache_reg,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 460ba48eb66c..6bd25401bc01 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5536,6 +5536,12 @@ static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	set_debugreg(DR6_RESERVED, 6);
 }
 
+static void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
+{
+	lockdep_assert_irqs_disabled();
+	set_debugreg(vcpu->arch.dr6, 6);
+}
+
 static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	vmcs_writel(GUEST_DR7, val);
@@ -7220,10 +7226,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmx->loaded_vmcs->host_state.cr4 = cr4;
 	}
 
-	/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
-	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-		set_debugreg(vcpu->arch.dr6, 6);
-
 	/* When single-stepping over STI and MOV SS, we must clear the
 	 * corresponding interruptibility bits in the guest state. Otherwise
 	 * vmentry fails as it then expects bit 14 (BS) in pending debug
@@ -8168,6 +8170,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
+	.set_dr6 = vmx_set_dr6,
 	.set_dr7 = vmx_set_dr7,
 	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
 	.cache_reg = vmx_cache_reg,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 580730b1e589..752fa116a261 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10841,6 +10841,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(vcpu->arch.eff_db[1], 1);
 		set_debugreg(vcpu->arch.eff_db[2], 2);
 		set_debugreg(vcpu->arch.eff_db[3], 3);
+		/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
+		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
+			static_call(kvm_x86_set_dr6)(vcpu, vcpu->arch.dr6);
 	} else if (unlikely(hw_breakpoint_active())) {
 		set_debugreg(0, 7);
 	}
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 779ec6e510f7..3f35ce19c7b6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -528,16 +528,18 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
-		unsigned int target_freq, unsigned int relation)
+				   unsigned int target_freq,
+				   unsigned int min, unsigned int max,
+				   unsigned int relation)
 {
 	unsigned int idx;
 
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (!policy->freq_table)
 		return target_freq;
 
-	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
+	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
 	policy->cached_resolved_idx = idx;
 	policy->cached_target_freq = target_freq;
 	return policy->freq_table[idx].frequency;
@@ -557,7 +559,21 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 					 unsigned int target_freq)
 {
-	return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
+	unsigned int min = READ_ONCE(policy->min);
+	unsigned int max = READ_ONCE(policy->max);
+
+	/*
+	 * If this function runs in parallel with cpufreq_set_policy(), it may
+	 * read policy->min before the update and policy->max after the update
+	 * or the other way around, so there is no ordering guarantee.
+	 *
+	 * Resolve this by always honoring the max (in case it comes from
+	 * thermal throttling or similar).
+	 */
+	if (unlikely(min > max))
+		min = max;
+
+	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2283,7 +2299,8 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	target_freq = __resolve_freq(policy, target_freq, relation);
+	target_freq = __resolve_freq(policy, target_freq, policy->min,
+				     policy->max, relation);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
@@ -2573,11 +2590,18 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 * Resolve policy min/max to available frequencies. It ensures
 	 * no frequency resolution will neither overshoot the requested maximum
 	 * nor undershoot the requested minimum.
+	 *
+	 * Avoid storing intermediate values in policy->max or policy->min and
+	 * compiler optimizations around them because they may be accessed
+	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
-	policy->min = new_data.min;
-	policy->max = new_data.max;
-	policy->min = __resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
-	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
+	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
+					       new_data.min, new_data.max,
+					       CPUFREQ_RELATION_H));
+	new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
+				      new_data.max, CPUFREQ_RELATION_L);
+	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
+
 	trace_cpu_frequency_limits(policy);
 
 	policy->cached_target_freq = UINT_MAX;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index c52d19d67557..65cbd5ecbaf8 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -77,7 +77,8 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 		return freq_next;
 	}
 
-	index = cpufreq_frequency_table_target(policy, freq_next, relation);
+	index = cpufreq_frequency_table_target(policy, freq_next, policy->min,
+					       policy->max, relation);
 	freq_req = freq_table[index].frequency;
 	freq_reduc = freq_req * od_tuners->powersave_bias / 1000;
 	freq_avg = freq_req - freq_reduc;
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 67e56cf638ef..190f8aa7ad02 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -116,8 +116,8 @@ int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy)
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
-				 unsigned int target_freq,
-				 unsigned int relation)
+				 unsigned int target_freq, unsigned int min,
+				 unsigned int max, unsigned int relation)
 {
 	struct cpufreq_frequency_table optimal = {
 		.driver_data = ~0,
@@ -148,7 +148,7 @@ int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
 	cpufreq_for_each_valid_entry_idx(pos, table, i) {
 		freq = pos->frequency;
 
-		if ((freq < policy->min) || (freq > policy->max))
+		if (freq < min || freq > max)
 			continue;
 		if (freq == target_freq) {
 			optimal.driver_data = i;
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..f865139e43db 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -98,7 +98,7 @@ static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 	if (status & priv->ecc_stat_ce_mask) {
 		regmap_read(drvdata->mc_vbase, priv->ecc_saddr_offset,
 			    &err_addr);
-		if (priv->ecc_uecnt_offset)
+		if (priv->ecc_cecnt_offset)
 			regmap_read(drvdata->mc_vbase,  priv->ecc_cecnt_offset,
 				    &err_count);
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, err_count,
@@ -1015,9 +1015,6 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 		}
 	}
 
-	/* Interrupt mode set to every SBERR */
-	regmap_write(ecc_mgr_map, ALTR_A10_ECC_INTMODE_OFST,
-		     ALTR_A10_ECC_INTMODE);
 	/* Enable ECC */
 	ecc_set_bits(ecc_ctrl_en_mask, (ecc_block_base +
 					ALTR_A10_ECC_CTRL_OFST));
@@ -2138,6 +2135,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		return PTR_ERR(edac->ecc_mgr_map);
 	}
 
+	/* Set irq mask for DDR SBE to avoid any pending irq before registration */
+	regmap_write(edac->ecc_mgr_map, A10_SYSMGR_ECC_INTMASK_SET_OFST,
+		     (A10_SYSMGR_ECC_INTMASK_SDMMCB | A10_SYSMGR_ECC_INTMASK_DDR0));
+
 	edac->irq_chip.name = pdev->dev.of_node->name;
 	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
 	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 3727e72c8c2e..7248d24c4908 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -249,6 +249,8 @@ struct altr_sdram_mc_data {
 #define A10_SYSMGR_ECC_INTMASK_SET_OFST   0x94
 #define A10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
 #define A10_SYSMGR_ECC_INTMASK_OCRAM      BIT(1)
+#define A10_SYSMGR_ECC_INTMASK_SDMMCB     BIT(16)
+#define A10_SYSMGR_ECC_INTMASK_DDR0       BIT(17)
 
 #define A10_SYSMGR_ECC_INTSTAT_SERR_OFST  0x9C
 #define A10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xA0
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index e9f86b757301..e1e278d431e9 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -306,7 +306,8 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 			memcpy(buffer + idx, drv_info->rx_buffer + idx * sz,
 			       buf_sz);
 
-	ffa_rx_release();
+	if (!(flags & PARTITION_INFO_GET_RETURN_COUNT_ONLY))
+		ffa_rx_release();
 
 	mutex_unlock(&drv_info->rx_lock);
 
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 35bb70724d44..8c6f99d15f22 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -73,6 +73,9 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
 	if (!dev)
 		return NULL;
 
+	/* Drop the refcnt bumped implicitly by device_find_child */
+	put_device(dev);
+
 	return to_scmi_dev(dev);
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 3f211c0308a2..6110d88efdbb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -39,10 +39,10 @@
 static bool
 lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
 {
-
 	struct dc_link *link = handle;
 	struct i2c_payload i2c_payloads[] = {{true, address, size, (void *)data} };
-	struct i2c_command cmd = {i2c_payloads, 1, I2C_COMMAND_ENGINE_HW, link->dc->caps.i2c_speed_in_khz};
+	struct i2c_command cmd = {i2c_payloads, 1, I2C_COMMAND_ENGINE_HW,
+				  link->dc->caps.i2c_speed_in_khz};
 
 	return dm_helpers_submit_i2c(link->ctx, link, &cmd);
 }
@@ -52,8 +52,10 @@ lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data, uint3
 {
 	struct dc_link *link = handle;
 
-	struct i2c_payload i2c_payloads[] = {{true, address, 1, &offset}, {false, address, size, data} };
-	struct i2c_command cmd = {i2c_payloads, 2, I2C_COMMAND_ENGINE_HW, link->dc->caps.i2c_speed_in_khz};
+	struct i2c_payload i2c_payloads[] = {{true, address, 1, &offset},
+					     {false, address, size, data} };
+	struct i2c_command cmd = {i2c_payloads, 2, I2C_COMMAND_ENGINE_HW,
+				  link->dc->caps.i2c_speed_in_khz};
 
 	return dm_helpers_submit_i2c(link->ctx, link, &cmd);
 }
@@ -76,7 +78,6 @@ lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
 
 static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
 {
-
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 
 	if (!psp->hdcp_context.context.initialized) {
@@ -96,13 +97,12 @@ static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint
 	*srm_version = hdcp_cmd->out_msg.hdcp_get_srm.srm_version;
 	*srm_size = hdcp_cmd->out_msg.hdcp_get_srm.srm_buf_size;
 
-
 	return hdcp_cmd->out_msg.hdcp_get_srm.srm_buf;
 }
 
-static int psp_set_srm(struct psp_context *psp, uint8_t *srm, uint32_t srm_size, uint32_t *srm_version)
+static int psp_set_srm(struct psp_context *psp,
+		       u8 *srm, uint32_t srm_size, uint32_t *srm_version)
 {
-
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 
 	if (!psp->hdcp_context.context.initialized) {
@@ -119,7 +119,8 @@ static int psp_set_srm(struct psp_context *psp, uint8_t *srm, uint32_t srm_size,
 
 	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
 
-	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS || hdcp_cmd->out_msg.hdcp_set_srm.valid_signature != 1 ||
+	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS ||
+	    hdcp_cmd->out_msg.hdcp_set_srm.valid_signature != 1 ||
 	    hdcp_cmd->out_msg.hdcp_set_srm.srm_version == PSP_SRM_VERSION_MAX)
 		return -EINVAL;
 
@@ -150,7 +151,6 @@ static void process_output(struct hdcp_workqueue *hdcp_work)
 
 static void link_lock(struct hdcp_workqueue *work, bool lock)
 {
-
 	int i = 0;
 
 	for (i = 0; i < work->max_link; i++) {
@@ -160,72 +160,69 @@ static void link_lock(struct hdcp_workqueue *work, bool lock)
 			mutex_unlock(&work[i].mutex);
 	}
 }
+
 void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 			 unsigned int link_index,
 			 struct amdgpu_dm_connector *aconnector,
-			 uint8_t content_type,
+			 u8 content_type,
 			 bool enable_encryption)
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
-	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
-	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
-	struct mod_hdcp_display_query query;
-
-	mutex_lock(&hdcp_w->mutex);
-	hdcp_w->aconnector = aconnector;
-
-	query.display = NULL;
-	mod_hdcp_query_display(&hdcp_w->hdcp, aconnector->base.index, &query);
-
-	if (query.display != NULL) {
-		memcpy(display, query.display, sizeof(struct mod_hdcp_display));
-		mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
-
-		hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
-
-		if (enable_encryption) {
-			/* Explicitly set the saved SRM as sysfs call will be after we already enabled hdcp
-			 * (s3 resume case)
-			 */
-			if (hdcp_work->srm_size > 0)
-				psp_set_srm(hdcp_work->hdcp.config.psp.handle, hdcp_work->srm, hdcp_work->srm_size,
-					    &hdcp_work->srm_version);
-
-			display->adjust.disable = MOD_HDCP_DISPLAY_NOT_DISABLE;
-			if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
-				hdcp_w->link.adjust.hdcp1.disable = 0;
-				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
-			} else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1) {
-				hdcp_w->link.adjust.hdcp1.disable = 1;
-				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_1;
-			}
-
-			schedule_delayed_work(&hdcp_w->property_validate_dwork,
-					      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
-		} else {
-			display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
-			hdcp_w->encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
-			cancel_delayed_work(&hdcp_w->property_validate_dwork);
+	struct mod_hdcp_link_adjustment link_adjust;
+	struct mod_hdcp_display_adjustment display_adjust;
+	unsigned int conn_index = aconnector->base.index;
+
+	guard(mutex)(&hdcp_w->mutex);
+	drm_connector_get(&aconnector->base);
+	if (hdcp_w->aconnector[conn_index])
+		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
+	hdcp_w->aconnector[conn_index] = aconnector;
+
+	memset(&link_adjust, 0, sizeof(link_adjust));
+	memset(&display_adjust, 0, sizeof(display_adjust));
+
+	if (enable_encryption) {
+		/* Explicitly set the saved SRM as sysfs call will be after we already enabled hdcp
+		 * (s3 resume case)
+		 */
+		if (hdcp_work->srm_size > 0)
+			psp_set_srm(hdcp_work->hdcp.config.psp.handle, hdcp_work->srm,
+				    hdcp_work->srm_size,
+				    &hdcp_work->srm_version);
+
+		display_adjust.disable = MOD_HDCP_DISPLAY_NOT_DISABLE;
+
+		link_adjust.auth_delay = 2;
+
+		if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
+			link_adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
+		} else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1) {
+			link_adjust.hdcp1.disable = 1;
+			link_adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_1;
 		}
 
-		display->state = MOD_HDCP_DISPLAY_ACTIVE;
+		schedule_delayed_work(&hdcp_w->property_validate_dwork,
+				      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
+	} else {
+		display_adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
+		hdcp_w->encryption_status[conn_index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+		cancel_delayed_work(&hdcp_w->property_validate_dwork);
 	}
 
-	mod_hdcp_add_display(&hdcp_w->hdcp, link, display, &hdcp_w->output);
+	mod_hdcp_update_display(&hdcp_w->hdcp, conn_index, &link_adjust, &display_adjust, &hdcp_w->output);
 
 	process_output(hdcp_w);
-	mutex_unlock(&hdcp_w->mutex);
 }
 
 static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
-			 unsigned int link_index,
+				unsigned int link_index,
 			 struct amdgpu_dm_connector *aconnector)
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
 	struct drm_connector_state *conn_state = aconnector->base.state;
+	unsigned int conn_index = aconnector->base.index;
 
-	mutex_lock(&hdcp_w->mutex);
-	hdcp_w->aconnector = aconnector;
+	guard(mutex)(&hdcp_w->mutex);
 
 	/* the removal of display will invoke auth reset -> hdcp destroy and
 	 * we'd expect the Content Protection (CP) property changed back to
@@ -236,28 +233,39 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 		conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 
 		DRM_DEBUG_DRIVER("[HDCP_DM] display %d, CP 2 -> 1, type %u, DPMS %u\n",
-			 aconnector->base.index, conn_state->hdcp_content_type, aconnector->base.dpms);
+				 aconnector->base.index, conn_state->hdcp_content_type,
+				 aconnector->base.dpms);
 	}
 
 	mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
-
+	if (hdcp_w->aconnector[conn_index]) {
+		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
+		hdcp_w->aconnector[conn_index] = NULL;
+	}
 	process_output(hdcp_w);
-	mutex_unlock(&hdcp_w->mutex);
 }
+
 void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
+	unsigned int conn_index;
 
-	mutex_lock(&hdcp_w->mutex);
+	guard(mutex)(&hdcp_w->mutex);
 
 	mod_hdcp_reset_connection(&hdcp_w->hdcp,  &hdcp_w->output);
 
 	cancel_delayed_work(&hdcp_w->property_validate_dwork);
-	hdcp_w->encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 
-	process_output(hdcp_w);
+	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX; conn_index++) {
+		hdcp_w->encryption_status[conn_index] =
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+		if (hdcp_w->aconnector[conn_index]) {
+			drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
+			hdcp_w->aconnector[conn_index] = NULL;
+		}
+	}
 
-	mutex_unlock(&hdcp_w->mutex);
+	process_output(hdcp_w);
 }
 
 void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
@@ -267,17 +275,14 @@ void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index
 	schedule_work(&hdcp_w->cpirq_work);
 }
 
-
-
-
 static void event_callback(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work;
 
 	hdcp_work = container_of(to_delayed_work(work), struct hdcp_workqueue,
-				      callback_dwork);
+				 callback_dwork);
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	cancel_delayed_work(&hdcp_work->callback_dwork);
 
@@ -285,54 +290,79 @@ static void event_callback(struct work_struct *work)
 			       &hdcp_work->output);
 
 	process_output(hdcp_work);
-
-	mutex_unlock(&hdcp_work->mutex);
-
-
 }
+
 static void event_property_update(struct work_struct *work)
 {
-
-	struct hdcp_workqueue *hdcp_work = container_of(work, struct hdcp_workqueue, property_update_work);
-	struct amdgpu_dm_connector *aconnector = hdcp_work->aconnector;
-	struct drm_device *dev = hdcp_work->aconnector->base.dev;
+	struct hdcp_workqueue *hdcp_work = container_of(work, struct hdcp_workqueue,
+							property_update_work);
+	struct amdgpu_dm_connector *aconnector = NULL;
+	struct drm_device *dev;
 	long ret;
+	unsigned int conn_index;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
 
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-	mutex_lock(&hdcp_work->mutex);
+	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX; conn_index++) {
+		aconnector = hdcp_work->aconnector[conn_index];
 
+		if (!aconnector)
+			continue;
 
-	if (aconnector->base.state && aconnector->base.state->commit) {
-		ret = wait_for_completion_interruptible_timeout(&aconnector->base.state->commit->hw_done, 10 * HZ);
+		if (!aconnector->base.index)
+			continue;
 
-		if (ret == 0) {
-			DRM_ERROR("HDCP state unknown! Setting it to DESIRED");
-			hdcp_work->encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
-		}
-	}
+		connector = &aconnector->base;
+
+		/* check if display connected */
+		if (connector->status != connector_status_connected)
+			continue;
+
+		conn_state = aconnector->base.state;
 
-	if (aconnector->base.state) {
-		if (hdcp_work->encryption_status != MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {
-			if (aconnector->base.state->hdcp_content_type ==
+		if (!conn_state)
+			continue;
+
+		dev = connector->dev;
+
+		if (!dev)
+			continue;
+
+		drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+		guard(mutex)(&hdcp_work->mutex);
+
+		if (conn_state->commit) {
+			ret = wait_for_completion_interruptible_timeout(&conn_state->commit->hw_done,
+									10 * HZ);
+			if (ret == 0) {
+				DRM_ERROR("HDCP state unknown! Setting it to DESIRED\n");
+				hdcp_work->encryption_status[conn_index] =
+					MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+			}
+		}
+		if (hdcp_work->encryption_status[conn_index] !=
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {
+			if (conn_state->hdcp_content_type ==
 				DRM_MODE_HDCP_CONTENT_TYPE0 &&
-			hdcp_work->encryption_status <=
-				MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON)
-				drm_hdcp_update_content_protection(&aconnector->base,
-					DRM_MODE_CONTENT_PROTECTION_ENABLED);
-			else if (aconnector->base.state->hdcp_content_type ==
+				hdcp_work->encryption_status[conn_index] <=
+				MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON) {
+				DRM_DEBUG_DRIVER("[HDCP_DM] DRM_MODE_CONTENT_PROTECTION_ENABLED\n");
+				drm_hdcp_update_content_protection(connector,
+								   DRM_MODE_CONTENT_PROTECTION_ENABLED);
+			} else if (conn_state->hdcp_content_type ==
 					DRM_MODE_HDCP_CONTENT_TYPE1 &&
-				hdcp_work->encryption_status ==
-					MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON)
-				drm_hdcp_update_content_protection(&aconnector->base,
-					DRM_MODE_CONTENT_PROTECTION_ENABLED);
+					hdcp_work->encryption_status[conn_index] ==
+					MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON) {
+				drm_hdcp_update_content_protection(connector,
+								   DRM_MODE_CONTENT_PROTECTION_ENABLED);
+			}
 		} else {
-			drm_hdcp_update_content_protection(&aconnector->base,
-				DRM_MODE_CONTENT_PROTECTION_DESIRED);
+			DRM_DEBUG_DRIVER("[HDCP_DM] DRM_MODE_CONTENT_PROTECTION_DESIRED\n");
+			drm_hdcp_update_content_protection(connector,
+							   DRM_MODE_CONTENT_PROTECTION_DESIRED);
 		}
+		drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	}
-
-	mutex_unlock(&hdcp_work->mutex);
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 }
 
 static void event_property_validate(struct work_struct *work)
@@ -340,22 +370,53 @@ static void event_property_validate(struct work_struct *work)
 	struct hdcp_workqueue *hdcp_work =
 		container_of(to_delayed_work(work), struct hdcp_workqueue, property_validate_dwork);
 	struct mod_hdcp_display_query query;
-	struct amdgpu_dm_connector *aconnector = hdcp_work->aconnector;
+	struct amdgpu_dm_connector *aconnector;
+	unsigned int conn_index;
 
-	if (!aconnector)
-		return;
+	guard(mutex)(&hdcp_work->mutex);
 
-	mutex_lock(&hdcp_work->mutex);
+	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX;
+	     conn_index++) {
+		aconnector = hdcp_work->aconnector[conn_index];
 
-	query.encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
-	mod_hdcp_query_display(&hdcp_work->hdcp, aconnector->base.index, &query);
 
-	if (query.encryption_status != hdcp_work->encryption_status) {
-		hdcp_work->encryption_status = query.encryption_status;
-		schedule_work(&hdcp_work->property_update_work);
-	}
+		if (!aconnector)
+			continue;
+
+		if (!aconnector->base.index)
+			continue;
+
+		/* check if display connected */
+		if (aconnector->base.status != connector_status_connected)
+			continue;
+
+		if (!aconnector->base.state)
+			continue;
+
+		query.encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+		mod_hdcp_query_display(&hdcp_work->hdcp, aconnector->base.index,
+				       &query);
+
+		DRM_DEBUG_DRIVER("[HDCP_DM] disp %d, connector->CP %u, (query, work): (%d, %d)\n",
+				 aconnector->base.index,
+			aconnector->base.state->content_protection,
+			query.encryption_status,
+			hdcp_work->encryption_status[conn_index]);
 
-	mutex_unlock(&hdcp_work->mutex);
+		if (query.encryption_status !=
+		    hdcp_work->encryption_status[conn_index]) {
+			DRM_DEBUG_DRIVER("[HDCP_DM] encryption_status change from %x to %x\n",
+					 hdcp_work->encryption_status[conn_index],
+					 query.encryption_status);
+
+			hdcp_work->encryption_status[conn_index] =
+				query.encryption_status;
+
+			DRM_DEBUG_DRIVER("[HDCP_DM] trigger property_update_work\n");
+
+			schedule_work(&hdcp_work->property_update_work);
+		}
+	}
 }
 
 static void event_watchdog_timer(struct work_struct *work)
@@ -363,10 +424,10 @@ static void event_watchdog_timer(struct work_struct *work)
 	struct hdcp_workqueue *hdcp_work;
 
 	hdcp_work = container_of(to_delayed_work(work),
-				      struct hdcp_workqueue,
+				 struct hdcp_workqueue,
 				      watchdog_timer_dwork);
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	cancel_delayed_work(&hdcp_work->watchdog_timer_dwork);
 
@@ -375,9 +436,6 @@ static void event_watchdog_timer(struct work_struct *work)
 			       &hdcp_work->output);
 
 	process_output(hdcp_work);
-
-	mutex_unlock(&hdcp_work->mutex);
-
 }
 
 static void event_cpirq(struct work_struct *work)
@@ -386,17 +444,13 @@ static void event_cpirq(struct work_struct *work)
 
 	hdcp_work = container_of(work, struct hdcp_workqueue, cpirq_work);
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	mod_hdcp_process_event(&hdcp_work->hdcp, MOD_HDCP_EVENT_CPIRQ, &hdcp_work->output);
 
 	process_output(hdcp_work);
-
-	mutex_unlock(&hdcp_work->mutex);
-
 }
 
-
 void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 {
 	int i = 0;
@@ -413,10 +467,8 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 	kfree(hdcp_work);
 }
 
-
 static bool enable_assr(void *handle, struct dc_link *link)
 {
-
 	struct hdcp_workqueue *hdcp_work = handle;
 	struct mod_hdcp hdcp = hdcp_work->hdcp;
 	struct psp_context *psp = hdcp.config.psp.handle;
@@ -430,11 +482,12 @@ static bool enable_assr(void *handle, struct dc_link *link)
 
 	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.context.mem_context.shared_buf;
 
-	mutex_lock(&psp->dtm_context.mutex);
+	guard(mutex)(&psp->dtm_context.mutex);
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
 
 	dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_ASSR_ENABLE;
-	dtm_cmd->dtm_in_message.topology_assr_enable.display_topology_dig_be_index = link->link_enc_hw_inst;
+	dtm_cmd->dtm_in_message.topology_assr_enable.display_topology_dig_be_index =
+		link->link_enc_hw_inst;
 	dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
 
 	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
@@ -444,8 +497,6 @@ static bool enable_assr(void *handle, struct dc_link *link)
 		res = false;
 	}
 
-	mutex_unlock(&psp->dtm_context.mutex);
-
 	return res;
 }
 
@@ -454,9 +505,10 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct hdcp_workqueue *hdcp_work = handle;
 	struct amdgpu_dm_connector *aconnector = config->dm_stream_ctx;
 	int link_index = aconnector->dc_link->link_index;
+	unsigned int conn_index = aconnector->base.index;
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
-	struct drm_connector_state *conn_state;
+	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
 	struct dc_sink *sink = NULL;
 	bool link_is_hdcp14 = false;
 
@@ -476,7 +528,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	else if (aconnector->dc_em_sink)
 		sink = aconnector->dc_em_sink;
 
-	if (sink != NULL)
+	if (sink)
 		link->mode = mod_hdcp_signal_type_to_operation_mode(sink->sink_signal);
 
 	display->controller = CONTROLLER_ID_D0 + config->otg_inst;
@@ -498,19 +550,28 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 	link->adjust.auth_delay = 3;
 	link->adjust.hdcp1.disable = 0;
-	conn_state = aconnector->base.state;
+	hdcp_w->encryption_status[display->index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 
 	DRM_DEBUG_DRIVER("[HDCP_DM] display %d, CP %d, type %d\n", aconnector->base.index,
-			(!!aconnector->base.state) ? aconnector->base.state->content_protection : -1,
-			(!!aconnector->base.state) ? aconnector->base.state->hdcp_content_type : -1);
+			 (!!aconnector->base.state) ?
+			 aconnector->base.state->content_protection : -1,
+			 (!!aconnector->base.state) ?
+			 aconnector->base.state->hdcp_content_type : -1);
 
-	if (conn_state)
-		hdcp_update_display(hdcp_work, link_index, aconnector,
-			conn_state->hdcp_content_type, false);
-}
+	guard(mutex)(&hdcp_w->mutex);
 
+	mod_hdcp_add_display(&hdcp_w->hdcp, link, display, &hdcp_w->output);
+	drm_connector_get(&aconnector->base);
+	if (hdcp_w->aconnector[conn_index])
+		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
+	hdcp_w->aconnector[conn_index] = aconnector;
+	process_output(hdcp_w);
+}
 
-/* NOTE: From the usermodes prospective you only need to call write *ONCE*, the kernel
+/**
+ * DOC: Add sysfs interface for set/get srm
+ *
+ * NOTE: From the usermodes prospective you only need to call write *ONCE*, the kernel
  *      will automatically call once or twice depending on the size
  *
  * call: "cat file > /sys/class/drm/card0/device/hdcp_srm" from usermode no matter what the size is
@@ -521,23 +582,23 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
  * sysfs interface doesn't tell us the size we will get so we are sending partial SRMs to psp and on
  * the last call we will send the full SRM. PSP will fail on every call before the last.
  *
- * This means we don't know if the SRM is good until the last call. And because of this limitation we
- * cannot throw errors early as it will stop the kernel from writing to sysfs
+ * This means we don't know if the SRM is good until the last call. And because of this
+ * limitation we cannot throw errors early as it will stop the kernel from writing to sysfs
  *
  * Example 1:
- * 	Good SRM size = 5096
- * 	first call to write 4096 -> PSP fails
- * 	Second call to write 1000 -> PSP Pass -> SRM is set
+ *	Good SRM size = 5096
+ *	first call to write 4096 -> PSP fails
+ *	Second call to write 1000 -> PSP Pass -> SRM is set
  *
  * Example 2:
- * 	Bad SRM size = 4096
- * 	first call to write 4096 -> PSP fails (This is the same as above, but we don't know if this
- * 	is the last call)
+ *	Bad SRM size = 4096
+ *	first call to write 4096 -> PSP fails (This is the same as above, but we don't know if this
+ *	is the last call)
  *
  * Solution?:
- * 	1: Parse the SRM? -> It is signed so we don't know the EOF
- * 	2: We can have another sysfs that passes the size before calling set. -> simpler solution
- * 	below
+ *	1: Parse the SRM? -> It is signed so we don't know the EOF
+ *	2: We can have another sysfs that passes the size before calling set. -> simpler solution
+ *	below
  *
  * Easy Solution:
  * Always call get after Set to verify if set was successful.
@@ -546,20 +607,21 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
  * +----------------------+
  * PSP will only update its srm if its older than the one we are trying to load.
  * Always do set first than get.
- * 	-if we try to "1. SET" a older version PSP will reject it and we can "2. GET" the newer
- * 	version and save it
+ *	-if we try to "1. SET" a older version PSP will reject it and we can "2. GET" the newer
+ *	version and save it
  *
- * 	-if we try to "1. SET" a newer version PSP will accept it and we can "2. GET" the
- * 	same(newer) version back and save it
+ *	-if we try to "1. SET" a newer version PSP will accept it and we can "2. GET" the
+ *	same(newer) version back and save it
  *
- * 	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
- * 	incorrect/corrupted and we should correct our SRM by getting it from PSP
+ *	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
+ *	incorrect/corrupted and we should correct our SRM by getting it from PSP
  */
-static ssize_t srm_data_write(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
+static ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
+			      struct bin_attribute *bin_attr, char *buffer,
 			      loff_t pos, size_t count)
 {
 	struct hdcp_workqueue *work;
-	uint32_t srm_version = 0;
+	u32 srm_version = 0;
 
 	work = container_of(bin_attr, struct hdcp_workqueue, attr);
 	link_lock(work, true);
@@ -573,19 +635,19 @@ static ssize_t srm_data_write(struct file *filp, struct kobject *kobj, struct bi
 		work->srm_version = srm_version;
 	}
 
-
 	link_lock(work, false);
 
 	return count;
 }
 
-static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
+static ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *bin_attr, char *buffer,
 			     loff_t pos, size_t count)
 {
 	struct hdcp_workqueue *work;
-	uint8_t *srm = NULL;
-	uint32_t srm_version;
-	uint32_t srm_size;
+	u8 *srm = NULL;
+	u32 srm_version;
+	u32 srm_size;
 	size_t ret = count;
 
 	work = container_of(bin_attr, struct hdcp_workqueue, attr);
@@ -618,12 +680,12 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
 /* From the hdcp spec (5.Renewability) SRM needs to be stored in a non-volatile memory.
  *
  * For example,
- * 	if Application "A" sets the SRM (ver 2) and we reboot/suspend and later when Application "B"
- * 	needs to use HDCP, the version in PSP should be SRM(ver 2). So SRM should be persistent
- * 	across boot/reboots/suspend/resume/shutdown
+ *	if Application "A" sets the SRM (ver 2) and we reboot/suspend and later when Application "B"
+ *	needs to use HDCP, the version in PSP should be SRM(ver 2). So SRM should be persistent
+ *	across boot/reboots/suspend/resume/shutdown
  *
- * Currently when the system goes down (suspend/shutdown) the SRM is cleared from PSP. For HDCP we need
- * to make the SRM persistent.
+ * Currently when the system goes down (suspend/shutdown) the SRM is cleared from PSP. For HDCP
+ * we need to make the SRM persistent.
  *
  * -PSP owns the checking of SRM but doesn't have the ability to store it in a non-volatile memory.
  * -The kernel cannot write to the file systems.
@@ -633,8 +695,8 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
  *
  * Usermode can read/write to/from PSP using the sysfs interface
  * For example:
- * 	to save SRM from PSP to storage : cat /sys/class/drm/card0/device/hdcp_srm > srmfile
- * 	to load from storage to PSP: cat srmfile > /sys/class/drm/card0/device/hdcp_srm
+ *	to save SRM from PSP to storage : cat /sys/class/drm/card0/device/hdcp_srm > srmfile
+ *	to load from storage to PSP: cat srmfile > /sys/class/drm/card0/device/hdcp_srm
  */
 static const struct bin_attribute data_attr = {
 	.attr = {.name = "hdcp_srm", .mode = 0664},
@@ -643,10 +705,9 @@ static const struct bin_attribute data_attr = {
 	.read = srm_data_read,
 };
 
-
-struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc)
+struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
+					     struct cp_psp *cp_psp, struct dc *dc)
 {
-
 	int max_caps = dc->caps.max_links;
 	struct hdcp_workqueue *hdcp_work;
 	int i = 0;
@@ -655,14 +716,16 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 	if (ZERO_OR_NULL_PTR(hdcp_work))
 		return NULL;
 
-	hdcp_work->srm = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm), GFP_KERNEL);
+	hdcp_work->srm = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE,
+				 sizeof(*hdcp_work->srm), GFP_KERNEL);
 
-	if (hdcp_work->srm == NULL)
+	if (!hdcp_work->srm)
 		goto fail_alloc_context;
 
-	hdcp_work->srm_temp = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm_temp), GFP_KERNEL);
+	hdcp_work->srm_temp = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE,
+				      sizeof(*hdcp_work->srm_temp), GFP_KERNEL);
 
-	if (hdcp_work->srm_temp == NULL)
+	if (!hdcp_work->srm_temp)
 		goto fail_alloc_context;
 
 	hdcp_work->max_link = max_caps;
@@ -687,6 +750,13 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 		hdcp_work[i].hdcp.config.ddc.funcs.read_i2c = lp_read_i2c;
 		hdcp_work[i].hdcp.config.ddc.funcs.write_dpcd = lp_write_dpcd;
 		hdcp_work[i].hdcp.config.ddc.funcs.read_dpcd = lp_read_dpcd;
+
+		memset(hdcp_work[i].aconnector, 0,
+		       sizeof(struct amdgpu_dm_connector *) *
+			       AMDGPU_DM_MAX_DISPLAY_INDEX);
+		memset(hdcp_work[i].encryption_status, 0,
+		       sizeof(enum mod_hdcp_encryption_status) *
+			       AMDGPU_DM_MAX_DISPLAY_INDEX);
 	}
 
 	cp_psp->funcs.update_stream_config = update_config;
@@ -708,10 +778,5 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 	kfree(hdcp_work);
 
 	return NULL;
-
-
-
 }
 
-
-
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index bbbf7d0eff82..69b445b011c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -43,7 +43,7 @@ struct hdcp_workqueue {
 	struct delayed_work callback_dwork;
 	struct delayed_work watchdog_timer_dwork;
 	struct delayed_work property_validate_dwork;
-	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_connector *aconnector[AMDGPU_DM_MAX_DISPLAY_INDEX];
 	struct mutex mutex;
 
 	struct mod_hdcp hdcp;
@@ -51,8 +51,7 @@ struct hdcp_workqueue {
 	struct mod_hdcp_display display;
 	struct mod_hdcp_link link;
 
-	enum mod_hdcp_encryption_status encryption_status;
-
+	enum mod_hdcp_encryption_status encryption_status[AMDGPU_DM_MAX_DISPLAY_INDEX];
 	/* when display is unplugged from mst hub, connctor will be
 	 * destroyed within dm_dp_mst_connector_destroy. connector
 	 * hdcp perperties, like type, undesired, desired, enabled,
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a942dc6a6dc..2a82119eb58e 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
+				 FREQ_1000_1001(params[i].phy_freq/10)*10);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index abcac7db4347..c84f4b9dbb2c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -95,7 +95,7 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 	while (!list_empty(&fctx->pending)) {
 		fence = list_entry(fctx->pending.next, typeof(*fence), head);
 
-		if (error)
+		if (error && !dma_fence_is_signaled_locked(&fence->base))
 			dma_fence_set_error(&fence->base, error);
 
 		if (nouveau_fence_signal(fence))
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index ff12018bc206..45d97d611ba1 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -616,9 +616,9 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	return 0;
 
 rpm_disable:
-	pm_runtime_put(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c9598c506ff9..bc78e8665551 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3610,6 +3610,14 @@ static int __init parse_ivrs_acpihid(char *str)
 	while (*uid == '0' && *(uid + 1))
 		uid++;
 
+	if (strlen(hid) >= ACPIHID_HID_LEN) {
+		pr_err("Invalid command line: hid is too long\n");
+		return 1;
+	} else if (strlen(uid) >= ACPIHID_UID_LEN) {
+		pr_err("Invalid command line: uid is too long\n");
+		return 1;
+	}
+
 	i = early_acpihid_map_size++;
 	memcpy(early_acpihid_map[i].hid, hid, strlen(hid));
 	memcpy(early_acpihid_map[i].uid, uid, strlen(uid));
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 96b72f3dad0d..6a60bad48b27 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1443,26 +1443,37 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static int arm_smmu_streams_cmp_key(const void *lhs, const struct rb_node *rhs)
+{
+	struct arm_smmu_stream *stream_rhs =
+		rb_entry(rhs, struct arm_smmu_stream, node);
+	const u32 *sid_lhs = lhs;
+
+	if (*sid_lhs < stream_rhs->id)
+		return -1;
+	if (*sid_lhs > stream_rhs->id)
+		return 1;
+	return 0;
+}
+
+static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
+				     const struct rb_node *rhs)
+{
+	return arm_smmu_streams_cmp_key(
+		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
+}
+
 static struct arm_smmu_master *
 arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
-	struct arm_smmu_stream *stream;
 
 	lockdep_assert_held(&smmu->streams_mutex);
 
-	node = smmu->streams.rb_node;
-	while (node) {
-		stream = rb_entry(node, struct arm_smmu_stream, node);
-		if (stream->id < sid)
-			node = node->rb_right;
-		else if (stream->id > sid)
-			node = node->rb_left;
-		else
-			return stream->master;
-	}
-
-	return NULL;
+	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct arm_smmu_stream, node)->master;
 }
 
 /* IRQ and event handlers */
@@ -2590,8 +2601,6 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 {
 	int i;
 	int ret = 0;
-	struct arm_smmu_stream *new_stream, *cur_stream;
-	struct rb_node **new_node, *parent_node = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
@@ -2602,9 +2611,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct rb_node *existing;
 		u32 sid = fwspec->ids[i];
 
-		new_stream = &master->streams[i];
 		new_stream->id = sid;
 		new_stream->master = master;
 
@@ -2613,28 +2623,23 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 			break;
 
 		/* Insert into SID tree */
-		new_node = &(smmu->streams.rb_node);
-		while (*new_node) {
-			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
-					      node);
-			parent_node = *new_node;
-			if (cur_stream->id > new_stream->id) {
-				new_node = &((*new_node)->rb_left);
-			} else if (cur_stream->id < new_stream->id) {
-				new_node = &((*new_node)->rb_right);
-			} else {
-				dev_warn(master->dev,
-					 "stream %u already in tree\n",
-					 cur_stream->id);
-				ret = -EINVAL;
-				break;
-			}
-		}
-		if (ret)
-			break;
+		existing = rb_find_add(&new_stream->node, &smmu->streams,
+				       arm_smmu_streams_cmp_node);
+		if (existing) {
+			struct arm_smmu_master *existing_master =
+				rb_entry(existing, struct arm_smmu_stream, node)
+					->master;
+
+			/* Bridged PCI devices may end up with duplicated IDs */
+			if (existing_master == master)
+				continue;
 
-		rb_link_node(&new_stream->node, parent_node, new_node);
-		rb_insert_color(&new_stream->node, &smmu->streams);
+			dev_warn(master->dev,
+				 "stream %u already in tree from dev %s\n", sid,
+				 dev_name(existing_master->dev));
+			ret = -EINVAL;
+			break;
+		}
 	}
 
 	if (ret) {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9a1bdfda9a9a..5847ac29d976 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4836,6 +4836,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_igfx);
 
+/* QM57/QS57 integrated gfx malfunctions with dmar */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_iommu_igfx);
+
 /* Broadwell igfx malfunctions with dmar */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1606, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x160B, quirk_iommu_igfx);
@@ -4913,7 +4916,6 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0062, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x006a, quirk_calpella_no_shadow_gtt);
 
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 414cd925064f..c04f2481068b 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -262,7 +262,7 @@ static struct msi_domain_info gicv2m_pmsi_domain_info = {
 	.chip	= &gicv2m_pmsi_irq_chip,
 };
 
-static void gicv2m_teardown(void)
+static void __init gicv2m_teardown(void)
 {
 	struct v2m_data *v2m, *tmp;
 
@@ -277,7 +277,7 @@ static void gicv2m_teardown(void)
 	}
 }
 
-static int gicv2m_allocate_domains(struct irq_domain *parent)
+static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
 	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
 	struct v2m_data *v2m;
@@ -404,7 +404,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	return ret;
 }
 
-static const struct of_device_id gicv2m_device_id[] = {
+static __initconst struct of_device_id gicv2m_device_id[] = {
 	{	.compatible	= "arm,gic-v2m-frame",	},
 	{},
 };
@@ -469,7 +469,7 @@ static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 	return data->fwnode;
 }
 
-static bool acpi_check_amazon_graviton_quirks(void)
+static __init bool acpi_check_amazon_graviton_quirks(void)
 {
 	static struct acpi_table_madt *madt;
 	acpi_status status;
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index d30614661eea..775ab17e51f9 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -226,6 +226,9 @@ static int qcom_mpm_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
+	if (pin == GPIO_NO_WAKE_IRQ)
+		return irq_domain_disconnect_hierarchy(domain, virq);
+
 	ret = irq_domain_set_hwirq_and_chip(domain, virq, pin,
 					    &qcom_mpm_chip, priv);
 	if (ret)
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index ec662f97ba82..496f9176113f 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1685,7 +1685,8 @@ static void __scan(struct dm_bufio_client *c)
 				atomic_long_dec(&c->need_shrink);
 				freed++;
 			}
-			cond_resched();
+			if (!(static_branch_unlikely(&no_sleep_enabled) && c->no_sleep))
+				cond_resched();
 		}
 	}
 }
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index c1f1f4ad608d..efd0732a8c10 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4637,7 +4637,7 @@ static void dm_integrity_dtr(struct dm_target *ti)
 	BUG_ON(!RB_EMPTY_ROOT(&ic->in_progress));
 	BUG_ON(!list_empty(&ic->wait_list));
 
-	if (ic->mode == 'B')
+	if (ic->mode == 'B' && ic->bitmap_flush_work.work.func)
 		cancel_delayed_work_sync(&ic->bitmap_flush_work);
 	if (ic->metadata_wq)
 		destroy_workqueue(ic->metadata_wq);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index aabb2435070b..492a3b38f552 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -502,8 +502,9 @@ static char **realloc_argv(unsigned int *size, char **old_argv)
 		gfp = GFP_NOIO;
 	}
 	argv = kmalloc_array(new_size, sizeof(*argv), gfp);
-	if (argv && old_argv) {
-		memcpy(argv, old_argv, *size * sizeof(*argv));
+	if (argv) {
+		if (old_argv)
+			memcpy(argv, old_argv, *size * sizeof(*argv));
 		*size = new_size;
 	}
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index d5fbccc72810..a9fcfcbc2d11 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5965,6 +5965,13 @@ int md_run(struct mddev *mddev)
 			goto exit_bio_set;
 	}
 
+	if (!bioset_initialized(&mddev->io_acct_set)) {
+		err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
+				  offsetof(struct md_io_acct, bio_clone), 0);
+		if (err)
+			goto exit_sync_set;
+	}
+
 	spin_lock(&pers_lock);
 	pers = find_pers(mddev->level, mddev->clevel);
 	if (!pers || !try_module_get(pers->owner)) {
@@ -6142,6 +6149,8 @@ int md_run(struct mddev *mddev)
 	module_put(pers->owner);
 	md_bitmap_destroy(mddev);
 abort:
+	bioset_exit(&mddev->io_acct_set);
+exit_sync_set:
 	bioset_exit(&mddev->sync_set);
 exit_bio_set:
 	bioset_exit(&mddev->bio_set);
@@ -6374,6 +6383,7 @@ static void __md_stop(struct mddev *mddev)
 	percpu_ref_exit(&mddev->active_io);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
+	bioset_exit(&mddev->io_acct_set);
 }
 
 void md_stop(struct mddev *mddev)
@@ -8744,23 +8754,6 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 }
 EXPORT_SYMBOL_GPL(md_submit_discard_bio);
 
-int acct_bioset_init(struct mddev *mddev)
-{
-	int err = 0;
-
-	if (!bioset_initialized(&mddev->io_acct_set))
-		err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
-			offsetof(struct md_io_acct, bio_clone), 0);
-	return err;
-}
-EXPORT_SYMBOL_GPL(acct_bioset_init);
-
-void acct_bioset_exit(struct mddev *mddev)
-{
-	bioset_exit(&mddev->io_acct_set);
-}
-EXPORT_SYMBOL_GPL(acct_bioset_exit);
-
 static void md_end_io_acct(struct bio *bio)
 {
 	struct md_io_acct *md_io_acct = bio->bi_private;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 4f0b48097455..1fda5e139beb 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -746,8 +746,6 @@ extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
 extern void md_finish_reshape(struct mddev *mddev);
 void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 			struct bio *bio, sector_t start, sector_t size);
-int acct_bioset_init(struct mddev *mddev);
-void acct_bioset_exit(struct mddev *mddev);
 void md_account_bio(struct mddev *mddev, struct bio **bio);
 
 extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 7c6a0b4437d8..c50a7abda744 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -377,7 +377,6 @@ static void raid0_free(struct mddev *mddev, void *priv)
 	struct r0conf *conf = priv;
 
 	free_conf(mddev, conf);
-	acct_bioset_exit(mddev);
 }
 
 static int raid0_run(struct mddev *mddev)
@@ -392,16 +391,11 @@ static int raid0_run(struct mddev *mddev)
 	if (md_check_no_bitmap(mddev))
 		return -EINVAL;
 
-	if (acct_bioset_init(mddev)) {
-		pr_err("md/raid0:%s: alloc acct bioset failed.\n", mdname(mddev));
-		return -ENOMEM;
-	}
-
 	/* if private is not null, we are here after takeover */
 	if (mddev->private == NULL) {
 		ret = create_strip_zones(mddev, &conf);
 		if (ret < 0)
-			goto exit_acct_set;
+			return ret;
 		mddev->private = conf;
 	}
 	conf = mddev->private;
@@ -432,15 +426,9 @@ static int raid0_run(struct mddev *mddev)
 
 	ret = md_integrity_register(mddev);
 	if (ret)
-		goto free;
+		free_conf(mddev, conf);
 
 	return ret;
-
-free:
-	free_conf(mddev, conf);
-exit_acct_set:
-	acct_bioset_exit(mddev);
-	return ret;
 }
 
 /*
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4315dabd3202..6e80a439ec45 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7770,19 +7770,12 @@ static int raid5_run(struct mddev *mddev)
 	struct md_rdev *rdev;
 	struct md_rdev *journal_dev = NULL;
 	sector_t reshape_offset = 0;
-	int i, ret = 0;
+	int i;
 	long long min_offset_diff = 0;
 	int first = 1;
 
-	if (acct_bioset_init(mddev)) {
-		pr_err("md/raid456:%s: alloc acct bioset failed.\n", mdname(mddev));
+	if (mddev_init_writes_pending(mddev) < 0)
 		return -ENOMEM;
-	}
-
-	if (mddev_init_writes_pending(mddev) < 0) {
-		ret = -ENOMEM;
-		goto exit_acct_set;
-	}
 
 	if (mddev->recovery_cp != MaxSector)
 		pr_notice("md/raid:%s: not clean -- starting background reconstruction\n",
@@ -7813,8 +7806,7 @@ static int raid5_run(struct mddev *mddev)
 	    (mddev->bitmap_info.offset || mddev->bitmap_info.file)) {
 		pr_notice("md/raid:%s: array cannot have both journal and bitmap\n",
 			  mdname(mddev));
-		ret = -EINVAL;
-		goto exit_acct_set;
+		return -EINVAL;
 	}
 
 	if (mddev->reshape_position != MaxSector) {
@@ -7839,15 +7831,13 @@ static int raid5_run(struct mddev *mddev)
 		if (journal_dev) {
 			pr_warn("md/raid:%s: don't support reshape with journal - aborting.\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 
 		if (mddev->new_level != mddev->level) {
 			pr_warn("md/raid:%s: unsupported reshape required - aborting.\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 		old_disks = mddev->raid_disks - mddev->delta_disks;
 		/* reshape_position must be on a new-stripe boundary, and one
@@ -7863,8 +7853,7 @@ static int raid5_run(struct mddev *mddev)
 		if (sector_div(here_new, chunk_sectors * new_data_disks)) {
 			pr_warn("md/raid:%s: reshape_position not on a stripe boundary\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 		reshape_offset = here_new * chunk_sectors;
 		/* here_new is the stripe we will write to */
@@ -7886,8 +7875,7 @@ static int raid5_run(struct mddev *mddev)
 			else if (mddev->ro == 0) {
 				pr_warn("md/raid:%s: in-place reshape must be started in read-only mode - aborting\n",
 					mdname(mddev));
-				ret = -EINVAL;
-				goto exit_acct_set;
+				return -EINVAL;
 			}
 		} else if (mddev->reshape_backwards
 		    ? (here_new * chunk_sectors + min_offset_diff <=
@@ -7897,8 +7885,7 @@ static int raid5_run(struct mddev *mddev)
 			/* Reading from the same stripe as writing to - bad */
 			pr_warn("md/raid:%s: reshape_position too early for auto-recovery - aborting.\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 		pr_debug("md/raid:%s: reshape will continue\n", mdname(mddev));
 		/* OK, we should be able to continue; */
@@ -7922,10 +7909,8 @@ static int raid5_run(struct mddev *mddev)
 	else
 		conf = mddev->private;
 
-	if (IS_ERR(conf)) {
-		ret = PTR_ERR(conf);
-		goto exit_acct_set;
-	}
+	if (IS_ERR(conf))
+		return PTR_ERR(conf);
 
 	if (test_bit(MD_HAS_JOURNAL, &mddev->flags)) {
 		if (!journal_dev) {
@@ -8125,10 +8110,7 @@ static int raid5_run(struct mddev *mddev)
 	free_conf(conf);
 	mddev->private = NULL;
 	pr_warn("md/raid:%s: failed to run raid set.\n", mdname(mddev));
-	ret = -EIO;
-exit_acct_set:
-	acct_bioset_exit(mddev);
-	return ret;
+	return -EIO;
 }
 
 static void raid5_free(struct mddev *mddev, void *priv)
@@ -8136,7 +8118,6 @@ static void raid5_free(struct mddev *mddev, void *priv)
 	struct r5conf *conf = priv;
 
 	free_conf(conf);
-	acct_bioset_exit(mddev);
 	mddev->to_remove = &raid5_attrs_group;
 }
 
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 7572c5714b46..d0a15645a0b8 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1109,26 +1109,26 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	num_irqs = platform_irq_count(pdev);
 	if (num_irqs < 0) {
 		ret = num_irqs;
-		goto eirq;
+		goto edisclk;
 	}
 
 	/* There must be at least one IRQ source */
 	if (!num_irqs) {
 		ret = -ENXIO;
-		goto eirq;
+		goto edisclk;
 	}
 
 	for (i = 0; i < num_irqs; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq < 0) {
 			ret = irq;
-			goto eirq;
+			goto edisclk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
 				       dev_name(&pdev->dev), host);
 		if (ret)
-			goto eirq;
+			goto edisclk;
 	}
 
 	ret = tmio_mmc_host_probe(host);
@@ -1140,8 +1140,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	return ret;
 
-eirq:
-	tmio_mmc_host_remove(host);
 edisclk:
 	renesas_sdhi_clk_disable(host);
 efree:
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 391c4e3cb66f..67af798686b8 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1517,7 +1517,7 @@ static void vsc9959_tas_clock_adjust(struct ocelot *ocelot)
 	struct tc_taprio_qopt_offload *taprio;
 	struct ocelot_port *ocelot_port;
 	struct timespec64 base_ts;
-	int port;
+	int i, port;
 	u32 val;
 
 	mutex_lock(&ocelot->tas_lock);
@@ -1549,6 +1549,9 @@ static void vsc9959_tas_clock_adjust(struct ocelot *ocelot)
 			   QSYS_PARAM_CFG_REG_3_BASE_TIME_SEC_MSB_M,
 			   QSYS_PARAM_CFG_REG_3);
 
+		for (i = 0; i < taprio->num_entries; i++)
+			vsc9959_tas_gcl_set(ocelot, i, &taprio->entries[i]);
+
 		ocelot_rmw(ocelot, QSYS_TAS_PARAM_CFG_CTRL_CONFIG_CHANGE,
 			   QSYS_TAS_PARAM_CFG_CTRL_CONFIG_CHANGE,
 			   QSYS_TAS_PARAM_CFG_CTRL);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
index 230726d7b74f..d41b58fad37b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
@@ -373,8 +373,13 @@ static int xgbe_map_rx_buffer(struct xgbe_prv_data *pdata,
 	}
 
 	/* Set up the header page info */
-	xgbe_set_buffer_data(&rdata->rx.hdr, &ring->rx_hdr_pa,
-			     XGBE_SKB_ALLOC_SIZE);
+	if (pdata->netdev->features & NETIF_F_RXCSUM) {
+		xgbe_set_buffer_data(&rdata->rx.hdr, &ring->rx_hdr_pa,
+				     XGBE_SKB_ALLOC_SIZE);
+	} else {
+		xgbe_set_buffer_data(&rdata->rx.hdr, &ring->rx_hdr_pa,
+				     pdata->rx_buf_size);
+	}
 
 	/* Set up the buffer page info */
 	xgbe_set_buffer_data(&rdata->rx.buf, &ring->rx_buf_pa,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 4030d619e84f..3cf7943b590c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -320,6 +320,18 @@ static void xgbe_config_sph_mode(struct xgbe_prv_data *pdata)
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, HDSMS, XGBE_SPH_HDSMS_SIZE);
 }
 
+static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
+{
+	unsigned int i;
+
+	for (i = 0; i < pdata->channel_count; i++) {
+		if (!pdata->channel[i]->rx_ring)
+			break;
+
+		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_CR, SPH, 0);
+	}
+}
+
 static int xgbe_write_rss_reg(struct xgbe_prv_data *pdata, unsigned int type,
 			      unsigned int index, unsigned int val)
 {
@@ -3495,8 +3507,12 @@ static int xgbe_init(struct xgbe_prv_data *pdata)
 	xgbe_config_tx_coalesce(pdata);
 	xgbe_config_rx_buffer_size(pdata);
 	xgbe_config_tso_mode(pdata);
-	xgbe_config_sph_mode(pdata);
-	xgbe_config_rss(pdata);
+
+	if (pdata->netdev->features & NETIF_F_RXCSUM) {
+		xgbe_config_sph_mode(pdata);
+		xgbe_config_rss(pdata);
+	}
+
 	desc_if->wrapper_tx_desc_init(pdata);
 	desc_if->wrapper_rx_desc_init(pdata);
 	xgbe_enable_dma_interrupts(pdata);
@@ -3650,5 +3666,9 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
 	hw_if->disable_vxlan = xgbe_disable_vxlan;
 	hw_if->set_vxlan_id = xgbe_set_vxlan_id;
 
+	/* For Split Header*/
+	hw_if->enable_sph = xgbe_config_sph_mode;
+	hw_if->disable_sph = xgbe_disable_sph_mode;
+
 	DBGPR("<--xgbe_init_function_ptrs\n");
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 6b73648b3779..34d45cebefb5 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2257,10 +2257,17 @@ static int xgbe_set_features(struct net_device *netdev,
 	if (ret)
 		return ret;
 
-	if ((features & NETIF_F_RXCSUM) && !rxcsum)
+	if ((features & NETIF_F_RXCSUM) && !rxcsum) {
+		hw_if->enable_sph(pdata);
+		hw_if->enable_vxlan(pdata);
 		hw_if->enable_rx_csum(pdata);
-	else if (!(features & NETIF_F_RXCSUM) && rxcsum)
+		schedule_work(&pdata->restart_work);
+	} else if (!(features & NETIF_F_RXCSUM) && rxcsum) {
+		hw_if->disable_sph(pdata);
+		hw_if->disable_vxlan(pdata);
 		hw_if->disable_rx_csum(pdata);
+		schedule_work(&pdata->restart_work);
+	}
 
 	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && !rxvlan)
 		hw_if->enable_rx_vlan_stripping(pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 7a41367c437d..b17c7d1dc4b0 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -859,6 +859,10 @@ struct xgbe_hw_if {
 	void (*enable_vxlan)(struct xgbe_prv_data *);
 	void (*disable_vxlan)(struct xgbe_prv_data *);
 	void (*set_vxlan_id)(struct xgbe_prv_data *);
+
+	/* For Split Header */
+	void (*enable_sph)(struct xgbe_prv_data *pdata);
+	void (*disable_sph)(struct xgbe_prv_data *pdata);
 };
 
 /* This structure represents implementation specific routines for an
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index c06789882036..32813cdd5aa5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -66,20 +66,30 @@ static int bnxt_hwrm_dbg_dma_data(struct bnxt *bp, void *msg,
 			}
 		}
 
+		if (cmn_req->req_type ==
+				cpu_to_le16(HWRM_DBG_COREDUMP_RETRIEVE))
+			info->dest_buf_size += len;
+
 		if (info->dest_buf) {
 			if ((info->seg_start + off + len) <=
 			    BNXT_COREDUMP_BUF_LEN(info->buf_len)) {
-				memcpy(info->dest_buf + off, dma_buf, len);
+				u16 copylen = min_t(u16, len,
+						    info->dest_buf_size - off);
+
+				memcpy(info->dest_buf + off, dma_buf, copylen);
+				if (copylen < len)
+					break;
 			} else {
 				rc = -ENOBUFS;
+				if (cmn_req->req_type ==
+				    cpu_to_le16(HWRM_DBG_COREDUMP_LIST)) {
+					kfree(info->dest_buf);
+					info->dest_buf = NULL;
+				}
 				break;
 			}
 		}
 
-		if (cmn_req->req_type ==
-				cpu_to_le16(HWRM_DBG_COREDUMP_RETRIEVE))
-			info->dest_buf_size += len;
-
 		if (!(cmn_resp->flags & HWRM_DBG_CMN_FLAGS_MORE))
 			break;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 799adba0034a..7daaed4520ac 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1392,6 +1392,17 @@ static int bnxt_get_regs_len(struct net_device *dev)
 	return reg_len;
 }
 
+#define BNXT_PCIE_32B_ENTRY(start, end)			\
+	 { offsetof(struct pcie_ctx_hw_stats, start),	\
+	   offsetof(struct pcie_ctx_hw_stats, end) }
+
+static const struct {
+	u16 start;
+	u16 end;
+} bnxt_pcie_32b_entries[] = {
+	BNXT_PCIE_32B_ENTRY(pcie_ltssm_histogram[0], pcie_ltssm_histogram[3]),
+};
+
 static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 			  void *_p)
 {
@@ -1423,12 +1434,27 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 	req->pcie_stat_host_addr = cpu_to_le64(hw_pcie_stats_addr);
 	rc = hwrm_req_send(bp, req);
 	if (!rc) {
-		__le64 *src = (__le64 *)hw_pcie_stats;
-		u64 *dst = (u64 *)(_p + BNXT_PXP_REG_LEN);
-		int i;
-
-		for (i = 0; i < sizeof(*hw_pcie_stats) / sizeof(__le64); i++)
-			dst[i] = le64_to_cpu(src[i]);
+		u8 *dst = (u8 *)(_p + BNXT_PXP_REG_LEN);
+		u8 *src = (u8 *)hw_pcie_stats;
+		int i, j;
+
+		for (i = 0, j = 0; i < sizeof(*hw_pcie_stats); ) {
+			if (i >= bnxt_pcie_32b_entries[j].start &&
+			    i <= bnxt_pcie_32b_entries[j].end) {
+				u32 *dst32 = (u32 *)(dst + i);
+
+				*dst32 = le32_to_cpu(*(__le32 *)(src + i));
+				i += 4;
+				if (i > bnxt_pcie_32b_entries[j].end &&
+				    j < ARRAY_SIZE(bnxt_pcie_32b_entries) - 1)
+					j++;
+			} else {
+				u64 *dst64 = (u64 *)(dst + i);
+
+				*dst64 = le64_to_cpu(*(__le64 *)(src + i));
+				i += 8;
+			}
+		}
 	}
 	hwrm_req_drop(bp, req);
 }
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 2c67a857a42f..71cb7fe63de3 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -352,7 +352,7 @@ parse_eeprom (struct net_device *dev)
 	eth_hw_addr_set(dev, psrom->mac_addr);
 
 	if (np->chip_id == CHIP_IP1000A) {
-		np->led_mode = psrom->led_mode;
+		np->led_mode = le16_to_cpu(psrom->led_mode);
 		return 0;
 	}
 
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 195dc6cfd895..0e33e2eaae96 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -335,7 +335,7 @@ typedef struct t_SROM {
 	u16 sub_system_id;	/* 0x06 */
 	u16 pci_base_1;		/* 0x08 (IP1000A only) */
 	u16 pci_base_2;		/* 0x0a (IP1000A only) */
-	u16 led_mode;		/* 0x0c (IP1000A only) */
+	__le16 led_mode;	/* 0x0c (IP1000A only) */
 	u16 reserved1[9];	/* 0x0e-0x1f */
 	u8 mac_addr[6];		/* 0x20-0x25 */
 	u8 reserved2[10];	/* 0x26-0x2f */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 018ce4f4be6f..4a513dba8f53 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -692,7 +692,12 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	writel(0, txq->bd.reg_desc_active);
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index d2603cfc122c..430b3ec800a9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -60,7 +60,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.name = "tm_qset",
 		.cmd = HNAE3_DBG_CMD_TM_QSET,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
+		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_file_init,
 	},
 	{
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 9d27fad9f35f..9bcd03e1994f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -472,20 +472,14 @@ static void hns3_mask_vector_irq(struct hns3_enet_tqp_vector *tqp_vector,
 	writel(mask_en, tqp_vector->mask_addr);
 }
 
-static void hns3_vector_enable(struct hns3_enet_tqp_vector *tqp_vector)
+static void hns3_irq_enable(struct hns3_enet_tqp_vector *tqp_vector)
 {
 	napi_enable(&tqp_vector->napi);
 	enable_irq(tqp_vector->vector_irq);
-
-	/* enable vector */
-	hns3_mask_vector_irq(tqp_vector, 1);
 }
 
-static void hns3_vector_disable(struct hns3_enet_tqp_vector *tqp_vector)
+static void hns3_irq_disable(struct hns3_enet_tqp_vector *tqp_vector)
 {
-	/* disable vector */
-	hns3_mask_vector_irq(tqp_vector, 0);
-
 	disable_irq(tqp_vector->vector_irq);
 	napi_disable(&tqp_vector->napi);
 	cancel_work_sync(&tqp_vector->rx_group.dim.work);
@@ -706,11 +700,42 @@ static int hns3_set_rx_cpu_rmap(struct net_device *netdev)
 	return 0;
 }
 
+static void hns3_enable_irqs_and_tqps(struct net_device *netdev)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = priv->ae_handle;
+	u16 i;
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_irq_enable(&priv->tqp_vector[i]);
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_mask_vector_irq(&priv->tqp_vector[i], 1);
+
+	for (i = 0; i < h->kinfo.num_tqps; i++)
+		hns3_tqp_enable(h->kinfo.tqp[i]);
+}
+
+static void hns3_disable_irqs_and_tqps(struct net_device *netdev)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = priv->ae_handle;
+	u16 i;
+
+	for (i = 0; i < h->kinfo.num_tqps; i++)
+		hns3_tqp_disable(h->kinfo.tqp[i]);
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_mask_vector_irq(&priv->tqp_vector[i], 0);
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_irq_disable(&priv->tqp_vector[i]);
+}
+
 static int hns3_nic_net_up(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = priv->ae_handle;
-	int i, j;
 	int ret;
 
 	ret = hns3_nic_reset_all_ring(h);
@@ -719,23 +744,13 @@ static int hns3_nic_net_up(struct net_device *netdev)
 
 	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
-	/* enable the vectors */
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_enable(&priv->tqp_vector[i]);
-
-	/* enable rcb */
-	for (j = 0; j < h->kinfo.num_tqps; j++)
-		hns3_tqp_enable(h->kinfo.tqp[j]);
+	hns3_enable_irqs_and_tqps(netdev);
 
 	/* start the ae_dev */
 	ret = h->ae_algo->ops->start ? h->ae_algo->ops->start(h) : 0;
 	if (ret) {
 		set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
-		while (j--)
-			hns3_tqp_disable(h->kinfo.tqp[j]);
-
-		for (j = i - 1; j >= 0; j--)
-			hns3_vector_disable(&priv->tqp_vector[j]);
+		hns3_disable_irqs_and_tqps(netdev);
 	}
 
 	return ret;
@@ -822,17 +837,9 @@ static void hns3_reset_tx_queue(struct hnae3_handle *h)
 static void hns3_nic_net_down(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
-	struct hnae3_handle *h = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops;
-	int i;
 
-	/* disable vectors */
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_disable(&priv->tqp_vector[i]);
-
-	/* disable rcb */
-	for (i = 0; i < h->kinfo.num_tqps; i++)
-		hns3_tqp_disable(h->kinfo.tqp[i]);
+	hns3_disable_irqs_and_tqps(netdev);
 
 	/* stop ae_dev */
 	ops = priv->ae_handle->ae_algo->ops;
@@ -5869,8 +5876,6 @@ int hns3_set_channels(struct net_device *netdev,
 void hns3_external_lb_prepare(struct net_device *ndev, bool if_running)
 {
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
-	struct hnae3_handle *h = priv->ae_handle;
-	int i;
 
 	if (!if_running)
 		return;
@@ -5881,11 +5886,7 @@ void hns3_external_lb_prepare(struct net_device *ndev, bool if_running)
 	netif_carrier_off(ndev);
 	netif_tx_disable(ndev);
 
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_disable(&priv->tqp_vector[i]);
-
-	for (i = 0; i < h->kinfo.num_tqps; i++)
-		hns3_tqp_disable(h->kinfo.tqp[i]);
+	hns3_disable_irqs_and_tqps(ndev);
 
 	/* delay ring buffer clearing to hns3_reset_notify_uninit_enet
 	 * during reset process, because driver may not be able
@@ -5901,7 +5902,6 @@ void hns3_external_lb_restore(struct net_device *ndev, bool if_running)
 {
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = priv->ae_handle;
-	int i;
 
 	if (!if_running)
 		return;
@@ -5917,11 +5917,7 @@ void hns3_external_lb_restore(struct net_device *ndev, bool if_running)
 
 	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_enable(&priv->tqp_vector[i]);
-
-	for (i = 0; i < h->kinfo.num_tqps; i++)
-		hns3_tqp_enable(h->kinfo.tqp[i]);
+	hns3_enable_irqs_and_tqps(ndev);
 
 	netif_tx_wake_all_queues(ndev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 4d4cea1f5015..b7cf9fbf9718 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -452,6 +452,13 @@ static int hclge_ptp_create_clock(struct hclge_dev *hdev)
 	ptp->info.settime64 = hclge_ptp_settime;
 
 	ptp->info.n_alarm = 0;
+
+	spin_lock_init(&ptp->lock);
+	ptp->io_base = hdev->hw.hw.io_base + HCLGE_PTP_REG_OFFSET;
+	ptp->ts_cfg.rx_filter = HWTSTAMP_FILTER_NONE;
+	ptp->ts_cfg.tx_type = HWTSTAMP_TX_OFF;
+	hdev->ptp = ptp;
+
 	ptp->clock = ptp_clock_register(&ptp->info, &hdev->pdev->dev);
 	if (IS_ERR(ptp->clock)) {
 		dev_err(&hdev->pdev->dev,
@@ -463,12 +470,6 @@ static int hclge_ptp_create_clock(struct hclge_dev *hdev)
 		return -ENODEV;
 	}
 
-	spin_lock_init(&ptp->lock);
-	ptp->io_base = hdev->hw.hw.io_base + HCLGE_PTP_REG_OFFSET;
-	ptp->ts_cfg.rx_filter = HWTSTAMP_FILTER_NONE;
-	ptp->ts_cfg.tx_type = HWTSTAMP_TX_OFF;
-	hdev->ptp = ptp;
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 06493853b2b4..b11d38a6093f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1309,9 +1309,8 @@ static void hclgevf_sync_vlan_filter(struct hclgevf_dev *hdev)
 	rtnl_unlock();
 }
 
-static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
+static int hclgevf_en_hw_strip_rxvtag_cmd(struct hclgevf_dev *hdev, bool enable)
 {
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	struct hclge_vf_to_pf_msg send_msg;
 
 	hclgevf_build_send_msg(&send_msg, HCLGE_MBX_SET_VLAN,
@@ -1320,6 +1319,19 @@ static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
 	return hclgevf_send_mbx_msg(hdev, &send_msg, false, NULL, 0);
 }
 
+static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	int ret;
+
+	ret = hclgevf_en_hw_strip_rxvtag_cmd(hdev, enable);
+	if (ret)
+		return ret;
+
+	hdev->rxvtag_strip_en = enable;
+	return 0;
+}
+
 static int hclgevf_reset_tqp(struct hnae3_handle *handle)
 {
 #define HCLGEVF_RESET_ALL_QUEUE_DONE	1U
@@ -2198,12 +2210,13 @@ static int hclgevf_rss_init_hw(struct hclgevf_dev *hdev)
 					  tc_valid, tc_size);
 }
 
-static int hclgevf_init_vlan_config(struct hclgevf_dev *hdev)
+static int hclgevf_init_vlan_config(struct hclgevf_dev *hdev,
+				    bool rxvtag_strip_en)
 {
 	struct hnae3_handle *nic = &hdev->nic;
 	int ret;
 
-	ret = hclgevf_en_hw_strip_rxvtag(nic, true);
+	ret = hclgevf_en_hw_strip_rxvtag(nic, rxvtag_strip_en);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to enable rx vlan offload, ret = %d\n", ret);
@@ -2872,7 +2885,7 @@ static int hclgevf_reset_hdev(struct hclgevf_dev *hdev)
 	if (ret)
 		return ret;
 
-	ret = hclgevf_init_vlan_config(hdev);
+	ret = hclgevf_init_vlan_config(hdev, hdev->rxvtag_strip_en);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed(%d) to initialize VLAN config\n", ret);
@@ -2985,7 +2998,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		goto err_config;
 	}
 
-	ret = hclgevf_init_vlan_config(hdev);
+	ret = hclgevf_init_vlan_config(hdev, true);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed(%d) to initialize VLAN config\n", ret);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 976414d00e67..1f62ac062d04 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -253,6 +253,7 @@ struct hclgevf_dev {
 	int *vector_irq;
 
 	bool gro_en;
+	bool rxvtag_strip_en;
 
 	unsigned long vlan_del_fail_bmap[BITS_TO_LONGS(VLAN_N_VID)];
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index bff3e9662a8f..a9df95088df3 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -1811,6 +1811,11 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 	pf = vf->pf;
 	dev = ice_pf_to_dev(pf);
 	vf_vsi = ice_get_vf_vsi(vf);
+	if (!vf_vsi) {
+		dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err_exit;
+	}
 
 #define ICE_VF_MAX_FDIR_FILTERS	128
 	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index ad27749c0931..c42e9f741f95 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1164,6 +1164,7 @@ static int mtk_star_tx_poll(struct napi_struct *napi, int budget)
 	struct net_device *ndev = priv->ndev;
 	unsigned int head = ring->head;
 	unsigned int entry = ring->tail;
+	unsigned long flags;
 
 	while (entry != head && count < (MTK_STAR_RING_NUM_DESCS - 1)) {
 		ret = mtk_star_tx_complete_one(priv);
@@ -1183,9 +1184,9 @@ static int mtk_star_tx_poll(struct napi_struct *napi, int budget)
 		netif_wake_queue(ndev);
 
 	if (napi_complete(napi)) {
-		spin_lock(&priv->lock);
+		spin_lock_irqsave(&priv->lock, flags);
 		mtk_star_enable_dma_irq(priv, false, true);
-		spin_unlock(&priv->lock);
+		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
 	return 0;
@@ -1342,16 +1343,16 @@ static int mtk_star_rx(struct mtk_star_priv *priv, int budget)
 static int mtk_star_rx_poll(struct napi_struct *napi, int budget)
 {
 	struct mtk_star_priv *priv;
+	unsigned long flags;
 	int work_done = 0;
 
 	priv = container_of(napi, struct mtk_star_priv, rx_napi);
 
 	work_done = mtk_star_rx(priv, budget);
-	if (work_done < budget) {
-		napi_complete_done(napi, work_done);
-		spin_lock(&priv->lock);
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		spin_lock_irqsave(&priv->lock, flags);
 		mtk_star_enable_dma_irq(priv, true, false);
-		spin_unlock(&priv->lock);
+		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
 	return work_done;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 433cdd0a2cf3..5237abbdcda1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3320,7 +3320,9 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	int err;
 
 	mutex_init(&esw->offloads.termtbl_mutex);
-	mlx5_rdma_enable_roce(esw->dev);
+	err = mlx5_rdma_enable_roce(esw->dev);
+	if (err)
+		goto err_roce;
 
 	err = mlx5_esw_host_number_init(esw);
 	if (err)
@@ -3378,6 +3380,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	esw_offloads_metadata_uninit(esw);
 err_metadata:
 	mlx5_rdma_disable_roce(esw->dev);
+err_roce:
 	mutex_destroy(&esw->offloads.termtbl_mutex);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
index 540cf05f6373..e61a4fa46d77 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
@@ -130,8 +130,8 @@ static void mlx5_rdma_make_default_gid(struct mlx5_core_dev *dev, union ib_gid *
 
 static int mlx5_rdma_add_roce_addr(struct mlx5_core_dev *dev)
 {
+	u8 mac[ETH_ALEN] = {};
 	union ib_gid gid;
-	u8 mac[ETH_ALEN];
 
 	mlx5_rdma_make_default_gid(dev, &gid);
 	return mlx5_core_roce_gid_set(dev, 0,
@@ -152,17 +152,17 @@ void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev)
 	mlx5_nic_vport_disable_roce(dev);
 }
 
-void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
+int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
 {
 	int err;
 
 	if (!MLX5_CAP_GEN(dev, roce))
-		return;
+		return 0;
 
 	err = mlx5_nic_vport_enable_roce(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed to enable RoCE: %d\n", err);
-		return;
+		return err;
 	}
 
 	err = mlx5_rdma_add_roce_addr(dev);
@@ -177,10 +177,11 @@ void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
 		goto del_roce_addr;
 	}
 
-	return;
+	return err;
 
 del_roce_addr:
 	mlx5_rdma_del_roce_addr(dev);
 disable_roce:
 	mlx5_nic_vport_disable_roce(dev);
+	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.h b/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
index 750cff2a71a4..3d9e76c3d42f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
@@ -8,12 +8,12 @@
 
 #ifdef CONFIG_MLX5_ESWITCH
 
-void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev);
+int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev);
 void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev);
 
 #else /* CONFIG_MLX5_ESWITCH */
 
-static inline void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev) {}
+static inline int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev) { return 0; }
 static inline void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev) {}
 
 #endif /* CONFIG_MLX5_ESWITCH */
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 0b2eaed11072..2e69ba0143b1 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1943,6 +1943,7 @@ static void lan743x_tx_frame_add_lso(struct lan743x_tx *tx,
 	if (nr_frags <= 0) {
 		tx->frame_data0 |= TX_DESC_DATA0_LS_;
 		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+		tx->frame_last = tx->frame_first;
 	}
 	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
@@ -2012,6 +2013,7 @@ static int lan743x_tx_frame_add_fragment(struct lan743x_tx *tx,
 		tx->frame_first = 0;
 		tx->frame_data0 = 0;
 		tx->frame_tail = 0;
+		tx->frame_last = 0;
 		return -ENOMEM;
 	}
 
@@ -2052,16 +2054,18 @@ static void lan743x_tx_frame_end(struct lan743x_tx *tx,
 	    TX_DESC_DATA0_DTYPE_DATA_) {
 		tx->frame_data0 |= TX_DESC_DATA0_LS_;
 		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+		tx->frame_last = tx->frame_tail;
 	}
 
-	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
-	buffer_info = &tx->buffer_info[tx->frame_tail];
+	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_last];
+	buffer_info = &tx->buffer_info[tx->frame_last];
 	buffer_info->skb = skb;
 	if (time_stamp)
 		buffer_info->flags |= TX_BUFFER_INFO_FLAG_TIMESTAMP_REQUESTED;
 	if (ignore_sync)
 		buffer_info->flags |= TX_BUFFER_INFO_FLAG_IGNORE_SYNC;
 
+	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
 	tx->frame_tail = lan743x_tx_next_index(tx, tx->frame_tail);
 	tx->last_tail = tx->frame_tail;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 92a5660b8820..c0d209f36188 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -974,6 +974,7 @@ struct lan743x_tx {
 	u32		frame_first;
 	u32		frame_data0;
 	u32		frame_tail;
+	u32		frame_last;
 
 	struct lan743x_tx_buffer_info *buffer_info;
 
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 71dbdac38020..203cb4978544 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -416,9 +416,158 @@ static u16 ocelot_vlan_unaware_pvid(struct ocelot *ocelot,
 	return VLAN_N_VID - bridge_num - 1;
 }
 
+/**
+ * ocelot_update_vlan_reclassify_rule() - Make switch aware only to bridge VLAN TPID
+ *
+ * @ocelot: Switch private data structure
+ * @port: Index of ingress port
+ *
+ * IEEE 802.1Q-2018 clauses "5.5 C-VLAN component conformance" and "5.6 S-VLAN
+ * component conformance" suggest that a C-VLAN component should only recognize
+ * and filter on C-Tags, and an S-VLAN component should only recognize and
+ * process based on C-Tags.
+ *
+ * In Linux, as per commit 1a0b20b25732 ("Merge branch 'bridge-next'"), C-VLAN
+ * components are largely represented by a bridge with vlan_protocol 802.1Q,
+ * and S-VLAN components by a bridge with vlan_protocol 802.1ad.
+ *
+ * Currently the driver only offloads vlan_protocol 802.1Q, but the hardware
+ * design is non-conformant, because the switch assigns each frame to a VLAN
+ * based on an entirely different question, as detailed in figure "Basic VLAN
+ * Classification Flow" from its manual and reproduced below.
+ *
+ * Set TAG_TYPE, PCP, DEI, VID to port-default values in VLAN_CFG register
+ * if VLAN_AWARE_ENA[port] and frame has outer tag then:
+ *   if VLAN_INNER_TAG_ENA[port] and frame has inner tag then:
+ *     TAG_TYPE = (Frame.InnerTPID <> 0x8100)
+ *     Set PCP, DEI, VID to values from inner VLAN header
+ *   else:
+ *     TAG_TYPE = (Frame.OuterTPID <> 0x8100)
+ *     Set PCP, DEI, VID to values from outer VLAN header
+ *   if VID == 0 then:
+ *     VID = VLAN_CFG.VLAN_VID
+ *
+ * Summarized, the switch will recognize both 802.1Q and 802.1ad TPIDs as VLAN
+ * "with equal rights", and just set the TAG_TYPE bit to 0 (if 802.1Q) or to 1
+ * (if 802.1ad). It will classify based on whichever of the tags is "outer", no
+ * matter what TPID that may have (or "inner", if VLAN_INNER_TAG_ENA[port]).
+ *
+ * In the VLAN Table, the TAG_TYPE information is not accessible - just the
+ * classified VID is - so it is as if each VLAN Table entry is for 2 VLANs:
+ * C-VLAN X, and S-VLAN X.
+ *
+ * Whereas the Linux bridge behavior is to only filter on frames with a TPID
+ * equal to the vlan_protocol, and treat everything else as VLAN-untagged.
+ *
+ * Consider an ingress packet tagged with 802.1ad VID=3 and 802.1Q VID=5,
+ * received on a bridge vlan_filtering=1 vlan_protocol=802.1Q port. This frame
+ * should be treated as 802.1Q-untagged, and classified to the PVID of that
+ * bridge port. Not to VID=3, and not to VID=5.
+ *
+ * The VCAP IS1 TCAM has everything we need to overwrite the choices made in
+ * the basic VLAN classification pipeline: it can match on TAG_TYPE in the key,
+ * and it can modify the classified VID in the action. Thus, for each port
+ * under a vlan_filtering bridge, we can insert a rule in VCAP IS1 lookup 0 to
+ * match on 802.1ad tagged frames and modify their classified VID to the 802.1Q
+ * PVID of the port. This effectively makes it appear to the outside world as
+ * if those packets were processed as VLAN-untagged.
+ *
+ * The rule needs to be updated each time the bridge PVID changes, and needs
+ * to be deleted if the bridge PVID is deleted, or if the port becomes
+ * VLAN-unaware.
+ */
+static int ocelot_update_vlan_reclassify_rule(struct ocelot *ocelot, int port)
+{
+	unsigned long cookie = OCELOT_VCAP_IS1_VLAN_RECLASSIFY(ocelot, port);
+	struct ocelot_vcap_block *block_vcap_is1 = &ocelot->block[VCAP_IS1];
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	const struct ocelot_bridge_vlan *pvid_vlan;
+	struct ocelot_vcap_filter *filter;
+	int err, val, pcp, dei;
+	bool vid_replace_ena;
+	u16 vid;
+
+	pvid_vlan = ocelot_port->pvid_vlan;
+	vid_replace_ena = ocelot_port->vlan_aware && pvid_vlan;
+
+	filter = ocelot_vcap_block_find_filter_by_id(block_vcap_is1, cookie,
+						     false);
+	if (!vid_replace_ena) {
+		/* If the reclassification filter doesn't need to exist, delete
+		 * it if it was previously installed, and exit doing nothing
+		 * otherwise.
+		 */
+		if (filter)
+			return ocelot_vcap_filter_del(ocelot, filter);
+
+		return 0;
+	}
+
+	/* The reclassification rule must apply. See if it already exists
+	 * or if it must be created.
+	 */
+
+	/* Treating as VLAN-untagged means using as classified VID equal to
+	 * the bridge PVID, and PCP/DEI set to the port default QoS values.
+	 */
+	vid = pvid_vlan->vid;
+	val = ocelot_read_gix(ocelot, ANA_PORT_QOS_CFG, port);
+	pcp = ANA_PORT_QOS_CFG_QOS_DEFAULT_VAL_X(val);
+	dei = !!(val & ANA_PORT_QOS_CFG_DP_DEFAULT_VAL);
+
+	if (filter) {
+		bool changed = false;
+
+		/* Filter exists, just update it */
+		if (filter->action.vid != vid) {
+			filter->action.vid = vid;
+			changed = true;
+		}
+		if (filter->action.pcp != pcp) {
+			filter->action.pcp = pcp;
+			changed = true;
+		}
+		if (filter->action.dei != dei) {
+			filter->action.dei = dei;
+			changed = true;
+		}
+
+		if (!changed)
+			return 0;
+
+		return ocelot_vcap_filter_replace(ocelot, filter);
+	}
+
+	/* Filter doesn't exist, create it */
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return -ENOMEM;
+
+	filter->key_type = OCELOT_VCAP_KEY_ANY;
+	filter->ingress_port_mask = BIT(port);
+	filter->vlan.tpid = OCELOT_VCAP_BIT_1;
+	filter->prio = 1;
+	filter->id.cookie = cookie;
+	filter->id.tc_offload = false;
+	filter->block_id = VCAP_IS1;
+	filter->type = OCELOT_VCAP_FILTER_OFFLOAD;
+	filter->lookup = 0;
+	filter->action.vid_replace_ena = true;
+	filter->action.pcp_dei_ena = true;
+	filter->action.vid = vid;
+	filter->action.pcp = pcp;
+	filter->action.dei = dei;
+
+	err = ocelot_vcap_filter_add(ocelot, filter, NULL);
+	if (err)
+		kfree(filter);
+
+	return err;
+}
+
 /* Default vlan to clasify for untagged frames (may be zero) */
-static void ocelot_port_set_pvid(struct ocelot *ocelot, int port,
-				 const struct ocelot_bridge_vlan *pvid_vlan)
+static int ocelot_port_set_pvid(struct ocelot *ocelot, int port,
+				const struct ocelot_bridge_vlan *pvid_vlan)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
 	u16 pvid = ocelot_vlan_unaware_pvid(ocelot, ocelot_port->bridge);
@@ -438,15 +587,23 @@ static void ocelot_port_set_pvid(struct ocelot *ocelot, int port,
 	 * happens automatically), but also 802.1p traffic which gets
 	 * classified to VLAN 0, but that is always in our RX filter, so it
 	 * would get accepted were it not for this setting.
+	 *
+	 * Also, we only support the bridge 802.1Q VLAN protocol, so
+	 * 802.1ad-tagged frames (carrying S-Tags) should be considered
+	 * 802.1Q-untagged, and also dropped.
 	 */
 	if (!pvid_vlan && ocelot_port->vlan_aware)
 		val = ANA_PORT_DROP_CFG_DROP_PRIO_S_TAGGED_ENA |
-		      ANA_PORT_DROP_CFG_DROP_PRIO_C_TAGGED_ENA;
+		      ANA_PORT_DROP_CFG_DROP_PRIO_C_TAGGED_ENA |
+		      ANA_PORT_DROP_CFG_DROP_S_TAGGED_ENA;
 
 	ocelot_rmw_gix(ocelot, val,
 		       ANA_PORT_DROP_CFG_DROP_PRIO_S_TAGGED_ENA |
-		       ANA_PORT_DROP_CFG_DROP_PRIO_C_TAGGED_ENA,
+		       ANA_PORT_DROP_CFG_DROP_PRIO_C_TAGGED_ENA |
+		       ANA_PORT_DROP_CFG_DROP_S_TAGGED_ENA,
 		       ANA_PORT_DROP_CFG, port);
+
+	return ocelot_update_vlan_reclassify_rule(ocelot, port);
 }
 
 static struct ocelot_bridge_vlan *ocelot_bridge_vlan_find(struct ocelot *ocelot,
@@ -594,7 +751,10 @@ int ocelot_port_vlan_filtering(struct ocelot *ocelot, int port,
 		       ANA_PORT_VLAN_CFG_VLAN_POP_CNT_M,
 		       ANA_PORT_VLAN_CFG, port);
 
-	ocelot_port_set_pvid(ocelot, port, ocelot_port->pvid_vlan);
+	err = ocelot_port_set_pvid(ocelot, port, ocelot_port->pvid_vlan);
+	if (err)
+		return err;
+
 	ocelot_port_manage_port_tag(ocelot, port);
 
 	return 0;
@@ -633,6 +793,7 @@ EXPORT_SYMBOL(ocelot_vlan_prepare);
 int ocelot_vlan_add(struct ocelot *ocelot, int port, u16 vid, bool pvid,
 		    bool untagged)
 {
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
 	int err;
 
 	/* Ignore VID 0 added to our RX filter by the 8021q module, since
@@ -647,9 +808,17 @@ int ocelot_vlan_add(struct ocelot *ocelot, int port, u16 vid, bool pvid,
 		return err;
 
 	/* Default ingress vlan classification */
-	if (pvid)
-		ocelot_port_set_pvid(ocelot, port,
-				     ocelot_bridge_vlan_find(ocelot, vid));
+	if (pvid) {
+		err = ocelot_port_set_pvid(ocelot, port,
+					   ocelot_bridge_vlan_find(ocelot, vid));
+		if (err)
+			return err;
+	} else if (ocelot_port->pvid_vlan &&
+		   ocelot_bridge_vlan_find(ocelot, vid) == ocelot_port->pvid_vlan) {
+		err = ocelot_port_set_pvid(ocelot, port, NULL);
+		if (err)
+			return err;
+	}
 
 	/* Untagged egress vlan clasification */
 	ocelot_port_manage_port_tag(ocelot, port);
@@ -675,8 +844,11 @@ int ocelot_vlan_del(struct ocelot *ocelot, int port, u16 vid)
 		return err;
 
 	/* Ingress */
-	if (del_pvid)
-		ocelot_port_set_pvid(ocelot, port, NULL);
+	if (del_pvid) {
+		err = ocelot_port_set_pvid(ocelot, port, NULL);
+		if (err)
+			return err;
+	}
 
 	/* Egress */
 	ocelot_port_manage_port_tag(ocelot, port);
@@ -2502,7 +2674,7 @@ int ocelot_port_set_default_prio(struct ocelot *ocelot, int port, u8 prio)
 		       ANA_PORT_QOS_CFG,
 		       port);
 
-	return 0;
+	return ocelot_update_vlan_reclassify_rule(ocelot, port);
 }
 EXPORT_SYMBOL_GPL(ocelot_port_set_default_prio);
 
diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.c b/drivers/net/ethernet/mscc/ocelot_vcap.c
index 73cdec5ca6a3..5734b86aed5b 100644
--- a/drivers/net/ethernet/mscc/ocelot_vcap.c
+++ b/drivers/net/ethernet/mscc/ocelot_vcap.c
@@ -695,6 +695,7 @@ static void is1_entry_set(struct ocelot *ocelot, int ix,
 	vcap_key_bit_set(vcap, &data, VCAP_IS1_HK_L2_MC, filter->dmac_mc);
 	vcap_key_bit_set(vcap, &data, VCAP_IS1_HK_L2_BC, filter->dmac_bc);
 	vcap_key_bit_set(vcap, &data, VCAP_IS1_HK_VLAN_TAGGED, tag->tagged);
+	vcap_key_bit_set(vcap, &data, VCAP_IS1_HK_TPID, tag->tpid);
 	vcap_key_set(vcap, &data, VCAP_IS1_HK_VID,
 		     tag->vid.value, tag->vid.mask);
 	vcap_key_set(vcap, &data, VCAP_IS1_HK_PCP,
diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
index 8f67c39f479e..060a566bc6aa 100644
--- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -33,7 +34,7 @@
 #define CMD_CTR		(0x2 << CMD_SHIFT)
 
 #define CMD_MASK	GENMASK(15, CMD_SHIFT)
-#define LEN_MASK	GENMASK(CMD_SHIFT - 1, 0)
+#define LEN_MASK	GENMASK(CMD_SHIFT - 2, 0)
 
 #define DET_CMD_LEN	4
 #define DET_SOF_LEN	2
@@ -262,7 +263,7 @@ static int mse102x_tx_frame_spi(struct mse102x_net *mse, struct sk_buff *txp,
 }
 
 static int mse102x_rx_frame_spi(struct mse102x_net *mse, u8 *buff,
-				unsigned int frame_len)
+				unsigned int frame_len, bool drop)
 {
 	struct mse102x_net_spi *mses = to_mse102x_spi(mse);
 	struct spi_transfer *xfer = &mses->spi_xfer;
@@ -280,6 +281,9 @@ static int mse102x_rx_frame_spi(struct mse102x_net *mse, u8 *buff,
 		netdev_err(mse->ndev, "%s: spi_sync() failed: %d\n",
 			   __func__, ret);
 		mse->stats.xfer_err++;
+	} else if (drop) {
+		netdev_dbg(mse->ndev, "%s: Drop frame\n", __func__);
+		ret = -EINVAL;
 	} else if (*sof != cpu_to_be16(DET_SOF)) {
 		netdev_dbg(mse->ndev, "%s: SPI start of frame is invalid (0x%04x)\n",
 			   __func__, *sof);
@@ -307,6 +311,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 	struct sk_buff *skb;
 	unsigned int rxalign;
 	unsigned int rxlen;
+	bool drop = false;
 	__be16 rx = 0;
 	u16 cmd_resp;
 	u8 *rxpkt;
@@ -329,7 +334,8 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 			net_dbg_ratelimited("%s: Unexpected response (0x%04x)\n",
 					    __func__, cmd_resp);
 			mse->stats.invalid_rts++;
-			return;
+			drop = true;
+			goto drop;
 		}
 
 		net_dbg_ratelimited("%s: Unexpected response to first CMD\n",
@@ -337,12 +343,20 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 	}
 
 	rxlen = cmd_resp & LEN_MASK;
-	if (!rxlen) {
-		net_dbg_ratelimited("%s: No frame length defined\n", __func__);
+	if (rxlen < ETH_ZLEN || rxlen > VLAN_ETH_FRAME_LEN) {
+		net_dbg_ratelimited("%s: Invalid frame length: %d\n", __func__,
+				    rxlen);
 		mse->stats.invalid_len++;
-		return;
+		drop = true;
 	}
 
+	/* In case of a invalid CMD_RTS, the frame must be consumed anyway.
+	 * So assume the maximum possible frame length.
+	 */
+drop:
+	if (drop)
+		rxlen = VLAN_ETH_FRAME_LEN;
+
 	rxalign = ALIGN(rxlen + DET_SOF_LEN + DET_DFT_LEN, 4);
 	skb = netdev_alloc_skb_ip_align(mse->ndev, rxalign);
 	if (!skb)
@@ -353,7 +367,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 	 * They are copied, but ignored.
 	 */
 	rxpkt = skb_put(skb, rxlen) - DET_SOF_LEN;
-	if (mse102x_rx_frame_spi(mse, rxpkt, rxlen)) {
+	if (mse102x_rx_frame_spi(mse, rxpkt, rxlen, drop)) {
 		mse->ndev->stats.rx_errors++;
 		dev_kfree_skb(skb);
 		return;
@@ -509,6 +523,7 @@ static irqreturn_t mse102x_irq(int irq, void *_mse)
 static int mse102x_net_open(struct net_device *ndev)
 {
 	struct mse102x_net *mse = netdev_priv(ndev);
+	struct mse102x_net_spi *mses = to_mse102x_spi(mse);
 	int ret;
 
 	ret = request_threaded_irq(ndev->irq, NULL, mse102x_irq, IRQF_ONESHOT,
@@ -524,6 +539,13 @@ static int mse102x_net_open(struct net_device *ndev)
 
 	netif_carrier_on(ndev);
 
+	/* The SPI interrupt can stuck in case of pending packet(s).
+	 * So poll for possible packet(s) to re-arm the interrupt.
+	 */
+	mutex_lock(&mses->lock);
+	mse102x_rx_pkt_spi(mse);
+	mutex_unlock(&mses->lock);
+
 	netif_dbg(mse, ifup, ndev, "network device up\n");
 
 	return 0;
diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 0b88635f4fbc..623607fd2cef 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -31,47 +31,6 @@ static int lan88xx_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, LAN88XX_EXT_PAGE_ACCESS, page);
 }
 
-static int lan88xx_phy_config_intr(struct phy_device *phydev)
-{
-	int rc;
-
-	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
-		/* unmask all source and clear them before enable */
-		rc = phy_write(phydev, LAN88XX_INT_MASK, 0x7FFF);
-		rc = phy_read(phydev, LAN88XX_INT_STS);
-		rc = phy_write(phydev, LAN88XX_INT_MASK,
-			       LAN88XX_INT_MASK_MDINTPIN_EN_ |
-			       LAN88XX_INT_MASK_LINK_CHANGE_);
-	} else {
-		rc = phy_write(phydev, LAN88XX_INT_MASK, 0);
-		if (rc)
-			return rc;
-
-		/* Ack interrupts after they have been disabled */
-		rc = phy_read(phydev, LAN88XX_INT_STS);
-	}
-
-	return rc < 0 ? rc : 0;
-}
-
-static irqreturn_t lan88xx_handle_interrupt(struct phy_device *phydev)
-{
-	int irq_status;
-
-	irq_status = phy_read(phydev, LAN88XX_INT_STS);
-	if (irq_status < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	}
-
-	if (!(irq_status & LAN88XX_INT_STS_LINK_CHANGE_))
-		return IRQ_NONE;
-
-	phy_trigger_machine(phydev);
-
-	return IRQ_HANDLED;
-}
-
 static int lan88xx_suspend(struct phy_device *phydev)
 {
 	struct lan88xx_priv *priv = phydev->priv;
@@ -392,8 +351,9 @@ static struct phy_driver microchip_phy_driver[] = {
 	.config_aneg	= lan88xx_config_aneg,
 	.link_change_notify = lan88xx_link_change_notify,
 
-	.config_intr	= lan88xx_phy_config_intr,
-	.handle_interrupt = lan88xx_handle_interrupt,
+	/* Interrupt handling is broken, do not define related
+	 * functions to force polling.
+	 */
 
 	.suspend	= lan88xx_suspend,
 	.resume		= genphy_resume,
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index bb0bf1415872..7b3739b29c8f 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -630,16 +630,6 @@ static const struct driver_info	zte_rndis_info = {
 	.tx_fixup =	rndis_tx_fixup,
 };
 
-static const struct driver_info	wwan_rndis_info = {
-	.description =	"Mobile Broadband RNDIS device",
-	.flags =	FLAG_WWAN | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT,
-	.bind =		rndis_bind,
-	.unbind =	rndis_unbind,
-	.status =	rndis_status,
-	.rx_fixup =	rndis_rx_fixup,
-	.tx_fixup =	rndis_tx_fixup,
-};
-
 /*-------------------------------------------------------------------------*/
 
 static const struct usb_device_id	products [] = {
@@ -676,11 +666,9 @@ static const struct usb_device_id	products [] = {
 	USB_INTERFACE_INFO(USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
 	.driver_info = (unsigned long) &rndis_info,
 }, {
-	/* Mobile Broadband Modem, seen in Novatel Verizon USB730L and
-	 * Telit FN990A (RNDIS)
-	 */
+	/* Novatel Verizon USB730L */
 	USB_INTERFACE_INFO(USB_CLASS_MISC, 4, 1),
-	.driver_info = (unsigned long)&wwan_rndis_info,
+	.driver_info = (unsigned long) &rndis_info,
 },
 	{ },		// END
 };
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 1ffc00e27080..c6d4fae958ca 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -627,7 +627,11 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 	 * default dst remote_ip previously added for this vni
 	 */
 	if (!vxlan_addr_any(&vninode->remote_ip) ||
-	    !vxlan_addr_any(&dst->remote_ip))
+	    !vxlan_addr_any(&dst->remote_ip)) {
+		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac,
+						vninode->vni);
+
+		spin_lock_bh(&vxlan->hash_lock[hash_index]);
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   (vxlan_addr_any(&vninode->remote_ip) ?
 				   dst->remote_ip : vninode->remote_ip),
@@ -635,6 +639,8 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 				   vninode->vni, vninode->vni,
 				   dst->remote_ifindex,
 				   true);
+		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	}
 
 	if (vxlan->dev->flags & IFF_UP) {
 		if (vxlan_addr_multicast(&vninode->remote_ip) &&
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 85e18fb9c497..92b0839970c2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -903,14 +903,16 @@ brcmf_usb_dl_writeimage(struct brcmf_usbdev_info *devinfo, u8 *fw, int fwlen)
 	}
 
 	/* 1) Prepare USB boot loader for runtime image */
-	brcmf_usb_dl_cmd(devinfo, DL_START, &state, sizeof(state));
+	err = brcmf_usb_dl_cmd(devinfo, DL_START, &state, sizeof(state));
+	if (err)
+		goto fail;
 
 	rdlstate = le32_to_cpu(state.state);
 	rdlbytes = le32_to_cpu(state.bytes);
 
 	/* 2) Check we are in the Waiting state */
 	if (rdlstate != DL_WAITING) {
-		brcmf_err("Failed to DL_START\n");
+		brcmf_err("Invalid DL state: %u\n", rdlstate);
 		err = -EINVAL;
 		goto fail;
 	}
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 87a4ff888ddd..70d6f5244e5e 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -103,7 +103,6 @@ int plfxlc_mac_init_hw(struct ieee80211_hw *hw)
 void plfxlc_mac_release(struct plfxlc_mac *mac)
 {
 	plfxlc_chip_release(&mac->chip);
-	lockdep_assert_held(&mac->lock);
 }
 
 int plfxlc_op_start(struct ieee80211_hw *hw)
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6dd19322c7f8..4e1b91c0416b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1686,7 +1686,7 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	cancel_work_sync(&queue->io_work);
 }
 
-static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1700,6 +1700,31 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_unlock(&queue->queue_lock);
 }
 
+static void nvme_tcp_wait_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	int timeout = 100;
+
+	while (timeout > 0) {
+		if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags) ||
+		    !sk_wmem_alloc_get(queue->sock->sk))
+			return;
+		msleep(2);
+		timeout -= 2;
+	}
+	dev_warn(nctrl->device,
+		 "qid %d: timeout draining sock wmem allocation expired\n",
+		 qid);
+}
+
+static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	nvme_tcp_stop_queue_nowait(nctrl, qid);
+	nvme_tcp_wait_queue(nctrl, qid);
+}
+
+
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
 	write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -1766,7 +1791,9 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_tcp_stop_queue(ctrl, i);
+		nvme_tcp_stop_queue_nowait(ctrl, i);
+	for (i = 1; i < ctrl->queue_count; i++)
+		nvme_tcp_wait_queue(ctrl, i);
 }
 
 static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a3acf144a40d..4f20094faee5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1172,11 +1172,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
 					     "pcie_aux clock source missing or invalid\n");
-		fallthrough;
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
-
+		fallthrough;
+	case IMX7D:
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
 									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 00ac7e381441..0be3087e21d5 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -121,15 +121,13 @@ static int uncore_event_cpu_online(unsigned int cpu)
 {
 	struct uncore_data *data;
 	int target;
+	int ret;
 
 	/* Check if there is an online cpu in the package for uncore MSR */
 	target = cpumask_any_and(&uncore_cpu_mask, topology_die_cpumask(cpu));
 	if (target < nr_cpu_ids)
 		return 0;
 
-	/* Use this CPU on this die as a control CPU */
-	cpumask_set_cpu(cpu, &uncore_cpu_mask);
-
 	data = uncore_get_instance(cpu);
 	if (!data)
 		return 0;
@@ -137,7 +135,14 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	data->package_id = topology_physical_package_id(cpu);
 	data->die_id = topology_die_id(cpu);
 
-	return uncore_freq_add_entry(data, cpu);
+	ret = uncore_freq_add_entry(data, cpu);
+	if (ret)
+		return ret;
+
+	/* Use this CPU on this die as a control CPU */
+	cpumask_set_cpu(cpu, &uncore_cpu_mask);
+
+	return 0;
 }
 
 static int uncore_event_cpu_offline(unsigned int cpu)
diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 1dee600e773f..f8a192cc82f2 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -544,7 +544,19 @@ int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
 		retval = -ENOMEM;
 		goto out;
 	}
-	sess->user = user;
+
+	if (!sess->user) {
+		/* First successful authentication */
+		sess->user = user;
+	} else {
+		if (!ksmbd_compare_user(sess->user, user)) {
+			ksmbd_debug(AUTH, "different user tried to reuse session\n");
+			retval = -EPERM;
+			ksmbd_free_user(user);
+			goto out;
+		}
+		ksmbd_free_user(user);
+	}
 
 	memcpy(sess->sess_key, resp->payload, resp->session_key_len);
 	memcpy(out_blob, resp->payload + resp->session_key_len,
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8c9857b36add..9b1ba4aedbce 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1615,11 +1615,6 @@ static int krb5_authenticate(struct ksmbd_work *work,
 	if (prev_sess_id && prev_sess_id != sess->id)
 		destroy_previous_session(conn, sess->user, prev_sess_id);
 
-	if (sess->state == SMB2_SESSION_VALID) {
-		ksmbd_free_user(sess->user);
-		sess->user = NULL;
-	}
-
 	retval = ksmbd_krb5_authenticate(sess, in_blob, in_len,
 					 out_blob, &out_len);
 	if (retval) {
diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index d440393b40eb..54de405cbab5 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -619,7 +619,6 @@ xfs_attr_rmtval_set_blk(
 	if (error)
 		return error;
 
-	ASSERT(nmap == 1);
 	ASSERT((map->br_startblock != DELAYSTARTBLOCK) &&
 	       (map->br_startblock != HOLESTARTBLOCK));
 
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 2a3b78032cb0..14b0d230f61b 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -1530,6 +1530,7 @@ xfs_bmap_add_extent_delay_real(
 			if (error)
 				goto done;
 		}
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING | BMAP_LEFT_CONTIG:
@@ -1559,6 +1560,7 @@ xfs_bmap_add_extent_delay_real(
 			if (error)
 				goto done;
 		}
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING | BMAP_RIGHT_CONTIG:
@@ -1592,6 +1594,7 @@ xfs_bmap_add_extent_delay_real(
 			if (error)
 				goto done;
 		}
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING:
@@ -1624,6 +1627,7 @@ xfs_bmap_add_extent_delay_real(
 				goto done;
 			}
 		}
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_LEFT_FILLING | BMAP_LEFT_CONTIG:
@@ -1661,6 +1665,7 @@ xfs_bmap_add_extent_delay_real(
 			if (error)
 				goto done;
 		}
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_LEFT_FILLING:
@@ -1748,6 +1753,7 @@ xfs_bmap_add_extent_delay_real(
 		xfs_iext_update_extent(bma->ip, state, &bma->icur, &PREV);
 		xfs_iext_next(ifp, &bma->icur);
 		xfs_iext_update_extent(bma->ip, state, &bma->icur, &RIGHT);
+		ASSERT(da_new <= da_old);
 		break;
 
 	case BMAP_RIGHT_FILLING:
@@ -1795,6 +1801,7 @@ xfs_bmap_add_extent_delay_real(
 		PREV.br_blockcount = temp;
 		xfs_iext_insert(bma->ip, &bma->icur, &PREV, state);
 		xfs_iext_next(ifp, &bma->icur);
+		ASSERT(da_new <= da_old);
 		break;
 
 	case 0:
@@ -1915,11 +1922,9 @@ xfs_bmap_add_extent_delay_real(
 	}
 
 	/* adjust for changes in reserved delayed indirect blocks */
-	if (da_new != da_old) {
-		ASSERT(state == 0 || da_new < da_old);
+	if (da_new != da_old)
 		error = xfs_mod_fdblocks(mp, (int64_t)(da_old - da_new),
-				false);
-	}
+				true);
 
 	xfs_bmap_check_leaf_extents(bma->cur, bma->ip, whichfork);
 done:
@@ -3954,20 +3959,32 @@ xfs_bmapi_reserve_delalloc(
 	xfs_extlen_t		alen;
 	xfs_extlen_t		indlen;
 	int			error;
-	xfs_fileoff_t		aoff = off;
+	xfs_fileoff_t		aoff;
+	bool			use_cowextszhint =
+					whichfork == XFS_COW_FORK && !prealloc;
 
+retry:
 	/*
 	 * Cap the alloc length. Keep track of prealloc so we know whether to
 	 * tag the inode before we return.
 	 */
+	aoff = off;
 	alen = XFS_FILBLKS_MIN(len + prealloc, XFS_MAX_BMBT_EXTLEN);
 	if (!eof)
 		alen = XFS_FILBLKS_MIN(alen, got->br_startoff - aoff);
 	if (prealloc && alen >= len)
 		prealloc = alen - len;
 
-	/* Figure out the extent size, adjust alen */
-	if (whichfork == XFS_COW_FORK) {
+	/*
+	 * If we're targetting the COW fork but aren't creating a speculative
+	 * posteof preallocation, try to expand the reservation to align with
+	 * the COW extent size hint if there's sufficient free space.
+	 *
+	 * Unlike the data fork, the CoW cancellation functions will free all
+	 * the reservations at inactivation, so we don't require that every
+	 * delalloc reservation have a dirty pagecache.
+	 */
+	if (use_cowextszhint) {
 		struct xfs_bmbt_irec	prev;
 		xfs_extlen_t		extsz = xfs_get_cowextsz_hint(ip);
 
@@ -3986,7 +4003,7 @@ xfs_bmapi_reserve_delalloc(
 	 */
 	error = xfs_quota_reserve_blkres(ip, alen);
 	if (error)
-		return error;
+		goto out;
 
 	/*
 	 * Split changing sb for alen and indlen since they could be coming
@@ -4031,6 +4048,17 @@ xfs_bmapi_reserve_delalloc(
 out_unreserve_quota:
 	if (XFS_IS_QUOTA_ON(mp))
 		xfs_quota_unreserve_blkres(ip, alen);
+out:
+	if (error == -ENOSPC || error == -EDQUOT) {
+		trace_xfs_delalloc_enospc(ip, off, len);
+
+		if (prealloc || use_cowextszhint) {
+			/* retry without any preallocation */
+			use_cowextszhint = false;
+			prealloc = 0;
+			goto retry;
+		}
+	}
 	return error;
 }
 
@@ -4113,8 +4141,10 @@ xfs_bmapi_allocate(
 	} else {
 		error = xfs_bmap_alloc_userdata(bma);
 	}
-	if (error || bma->blkno == NULLFSBLOCK)
+	if (error)
 		return error;
+	if (bma->blkno == NULLFSBLOCK)
+		return -ENOSPC;
 
 	if (bma->flags & XFS_BMAPI_ZERO) {
 		error = xfs_zero_extent(bma->ip, bma->blkno, bma->length);
@@ -4294,6 +4324,15 @@ xfs_bmapi_finish(
  * extent state if necessary.  Details behaviour is controlled by the flags
  * parameter.  Only allocates blocks from a single allocation group, to avoid
  * locking problems.
+ *
+ * Returns 0 on success and places the extent mappings in mval.  nmaps is used
+ * as an input/output parameter where the caller specifies the maximum number
+ * of mappings that may be returned and xfs_bmapi_write passes back the number
+ * of mappings (including existing mappings) it found.
+ *
+ * Returns a negative error code on failure, including -ENOSPC when it could not
+ * allocate any blocks and -ENOSR when it did allocate blocks to convert a
+ * delalloc range, but those blocks were before the passed in range.
  */
 int
 xfs_bmapi_write(
@@ -4421,10 +4460,16 @@ xfs_bmapi_write(
 			ASSERT(len > 0);
 			ASSERT(bma.length > 0);
 			error = xfs_bmapi_allocate(&bma);
-			if (error)
+			if (error) {
+				/*
+				 * If we already allocated space in a previous
+				 * iteration return what we go so far when
+				 * running out of space.
+				 */
+				if (error == -ENOSPC && bma.nallocs)
+					break;
 				goto error0;
-			if (bma.blkno == NULLFSBLOCK)
-				break;
+			}
 
 			/*
 			 * If this is a CoW allocation, record the data in
@@ -4462,7 +4507,6 @@ xfs_bmapi_write(
 		if (!xfs_iext_next_extent(ifp, &bma.icur, &bma.got))
 			eof = true;
 	}
-	*nmap = n;
 
 	error = xfs_bmap_btree_to_extents(tp, ip, bma.cur, &bma.logflags,
 			whichfork);
@@ -4473,7 +4517,22 @@ xfs_bmapi_write(
 	       ifp->if_nextents > XFS_IFORK_MAXEXT(ip, whichfork));
 	xfs_bmapi_finish(&bma, whichfork, 0);
 	xfs_bmap_validate_ret(orig_bno, orig_len, orig_flags, orig_mval,
-		orig_nmap, *nmap);
+		orig_nmap, n);
+
+	/*
+	 * When converting delayed allocations, xfs_bmapi_allocate ignores
+	 * the passed in bno and always converts from the start of the found
+	 * delalloc extent.
+	 *
+	 * To avoid a successful return with *nmap set to 0, return the magic
+	 * -ENOSR error code for this particular case so that the caller can
+	 * handle it.
+	 */
+	if (!n) {
+		ASSERT(bma.nallocs >= *nmap);
+		return -ENOSR;
+	}
+	*nmap = n;
 	return 0;
 error0:
 	xfs_bmapi_finish(&bma, whichfork, error);
@@ -4486,8 +4545,8 @@ xfs_bmapi_write(
  * invocations to allocate the target offset if a large enough physical extent
  * is not available.
  */
-int
-xfs_bmapi_convert_delalloc(
+static int
+xfs_bmapi_convert_one_delalloc(
 	struct xfs_inode	*ip,
 	int			whichfork,
 	xfs_off_t		offset,
@@ -4544,7 +4603,8 @@ xfs_bmapi_convert_delalloc(
 	if (!isnullstartblock(bma.got.br_startblock)) {
 		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
 				xfs_iomap_inode_sequence(ip, flags));
-		*seq = READ_ONCE(ifp->if_seq);
+		if (seq)
+			*seq = READ_ONCE(ifp->if_seq);
 		goto out_trans_cancel;
 	}
 
@@ -4580,9 +4640,6 @@ xfs_bmapi_convert_delalloc(
 	if (error)
 		goto out_finish;
 
-	error = -ENOSPC;
-	if (WARN_ON_ONCE(bma.blkno == NULLFSBLOCK))
-		goto out_finish;
 	error = -EFSCORRUPTED;
 	if (WARN_ON_ONCE(!xfs_valid_startblock(ip, bma.got.br_startblock)))
 		goto out_finish;
@@ -4593,7 +4650,8 @@ xfs_bmapi_convert_delalloc(
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
 	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
 				xfs_iomap_inode_sequence(ip, flags));
-	*seq = READ_ONCE(ifp->if_seq);
+	if (seq)
+		*seq = READ_ONCE(ifp->if_seq);
 
 	if (whichfork == XFS_COW_FORK)
 		xfs_refcount_alloc_cow_extent(tp, bma.blkno, bma.length);
@@ -4616,6 +4674,36 @@ xfs_bmapi_convert_delalloc(
 	return error;
 }
 
+/*
+ * Pass in a dellalloc extent and convert it to real extents, return the real
+ * extent that maps offset_fsb in iomap.
+ */
+int
+xfs_bmapi_convert_delalloc(
+	struct xfs_inode	*ip,
+	int			whichfork,
+	loff_t			offset,
+	struct iomap		*iomap,
+	unsigned int		*seq)
+{
+	int			error;
+
+	/*
+	 * Attempt to allocate whatever delalloc extent currently backs offset
+	 * and put the result into iomap.  Allocate in a loop because it may
+	 * take several attempts to allocate real blocks for a contiguous
+	 * delalloc extent if free space is sufficiently fragmented.
+	 */
+	do {
+		error = xfs_bmapi_convert_one_delalloc(ip, whichfork, offset,
+					iomap, seq);
+		if (error)
+			return error;
+	} while (iomap->offset + iomap->length <= offset);
+
+	return 0;
+}
+
 int
 xfs_bmapi_remap(
 	struct xfs_trans	*tp,
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 282c7cf032f4..12e3cca804b7 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2158,8 +2158,8 @@ xfs_da_grow_inode_int(
 	struct xfs_inode	*dp = args->dp;
 	int			w = args->whichfork;
 	xfs_rfsblock_t		nblks = dp->i_nblocks;
-	struct xfs_bmbt_irec	map, *mapp;
-	int			nmap, error, got, i, mapi;
+	struct xfs_bmbt_irec	map, *mapp = &map;
+	int			nmap, error, got, i, mapi = 1;
 
 	/*
 	 * Find a spot in the file space to put the new block.
@@ -2175,14 +2175,7 @@ xfs_da_grow_inode_int(
 	error = xfs_bmapi_write(tp, dp, *bno, count,
 			xfs_bmapi_aflag(w)|XFS_BMAPI_METADATA|XFS_BMAPI_CONTIG,
 			args->total, &map, &nmap);
-	if (error)
-		return error;
-
-	ASSERT(nmap <= 1);
-	if (nmap == 1) {
-		mapp = &map;
-		mapi = 1;
-	} else if (nmap == 0 && count > 1) {
+	if (error == -ENOSPC && count > 1) {
 		xfs_fileoff_t		b;
 		int			c;
 
@@ -2199,16 +2192,13 @@ xfs_da_grow_inode_int(
 					args->total, &mapp[mapi], &nmap);
 			if (error)
 				goto out_free_map;
-			if (nmap < 1)
-				break;
 			mapi += nmap;
 			b = mapp[mapi - 1].br_startoff +
 			    mapp[mapi - 1].br_blockcount;
 		}
-	} else {
-		mapi = 0;
-		mapp = NULL;
 	}
+	if (error)
+		goto out_free_map;
 
 	/*
 	 * Count the blocks we got, make sure it matches the total.
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 601b05ca5fc2..3c611c8ac158 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -365,17 +365,40 @@ xfs_dinode_verify_fork(
 	/*
 	 * For fork types that can contain local data, check that the fork
 	 * format matches the size of local data contained within the fork.
-	 *
-	 * For all types, check that when the size says the should be in extent
-	 * or btree format, the inode isn't claiming it is in local format.
 	 */
 	if (whichfork == XFS_DATA_FORK) {
-		if (S_ISDIR(mode) || S_ISLNK(mode)) {
+		/*
+		 * A directory small enough to fit in the inode must be stored
+		 * in local format.  The directory sf <-> extents conversion
+		 * code updates the directory size accordingly.  Directories
+		 * being truncated have zero size and are not subject to this
+		 * check.
+		 */
+		if (S_ISDIR(mode)) {
+			if (dip->di_size &&
+			    be64_to_cpu(dip->di_size) <= fork_size &&
+			    fork_format != XFS_DINODE_FMT_LOCAL)
+				return __this_address;
+		}
+
+		/*
+		 * A symlink with a target small enough to fit in the inode can
+		 * be stored in extents format if xattrs were added (thus
+		 * converting the data fork from shortform to remote format)
+		 * and then removed.
+		 */
+		if (S_ISLNK(mode)) {
 			if (be64_to_cpu(dip->di_size) <= fork_size &&
+			    fork_format != XFS_DINODE_FMT_EXTENTS &&
 			    fork_format != XFS_DINODE_FMT_LOCAL)
 				return __this_address;
 		}
 
+		/*
+		 * For all types, check that when the size says the fork should
+		 * be in extent or btree format, the inode isn't claiming to be
+		 * in local format.
+		 */
 		if (be64_to_cpu(dip->di_size) > fork_size &&
 		    fork_format == XFS_DINODE_FMT_LOCAL)
 			return __this_address;
@@ -491,9 +514,19 @@ xfs_dinode_verify(
 	if (mode && xfs_mode_to_ftype(mode) == XFS_DIR3_FT_UNKNOWN)
 		return __this_address;
 
-	/* No zero-length symlinks/dirs. */
-	if ((S_ISLNK(mode) || S_ISDIR(mode)) && di_size == 0)
-		return __this_address;
+	/*
+	 * No zero-length symlinks/dirs unless they're unlinked and hence being
+	 * inactivated.
+	 */
+	if ((S_ISLNK(mode) || S_ISDIR(mode)) && di_size == 0) {
+		if (dip->di_version > 1) {
+			if (dip->di_nlink)
+				return __this_address;
+		} else {
+			if (dip->di_onlink)
+				return __this_address;
+		}
+	}
 
 	fa = xfs_dinode_verify_nrext64(mp, dip);
 	if (fa)
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 90ed55cd3d10..8e0a176b8e0b 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1022,11 +1022,12 @@ xfs_log_sb(
 	 * and hence we don't need have to update it here.
 	 */
 	if (xfs_has_lazysbcount(mp)) {
-		mp->m_sb.sb_icount = percpu_counter_sum(&mp->m_icount);
+		mp->m_sb.sb_icount = percpu_counter_sum_positive(&mp->m_icount);
 		mp->m_sb.sb_ifree = min_t(uint64_t,
-				percpu_counter_sum(&mp->m_ifree),
+				percpu_counter_sum_positive(&mp->m_ifree),
 				mp->m_sb.sb_icount);
-		mp->m_sb.sb_fdblocks = percpu_counter_sum(&mp->m_fdblocks);
+		mp->m_sb.sb_fdblocks =
+				percpu_counter_sum_positive(&mp->m_fdblocks);
 	}
 
 	xfs_sb_to_disk(bp->b_addr, &mp->m_sb);
diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index b6f0c9f3f124..f51771e5c3fe 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -159,6 +159,11 @@ xchk_xattr_listent(
 	args.value = xchk_xattr_valuebuf(sx->sc);
 	args.valuelen = valuelen;
 
+	/*
+	 * Get the attr value to ensure that lookup can find this attribute
+	 * through the dabtree indexing and that remote value retrieval also
+	 * works correctly.
+	 */
 	error = xfs_attr_get_ilocked(&args);
 	/* ENODATA means the hash lookup failed and the attr is bad */
 	if (error == -ENODATA)
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 21c241e96d48..50a7f2745514 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -225,45 +225,6 @@ xfs_imap_valid(
 	return true;
 }
 
-/*
- * Pass in a dellalloc extent and convert it to real extents, return the real
- * extent that maps offset_fsb in wpc->iomap.
- *
- * The current page is held locked so nothing could have removed the block
- * backing offset_fsb, although it could have moved from the COW to the data
- * fork by another thread.
- */
-static int
-xfs_convert_blocks(
-	struct iomap_writepage_ctx *wpc,
-	struct xfs_inode	*ip,
-	int			whichfork,
-	loff_t			offset)
-{
-	int			error;
-	unsigned		*seq;
-
-	if (whichfork == XFS_COW_FORK)
-		seq = &XFS_WPC(wpc)->cow_seq;
-	else
-		seq = &XFS_WPC(wpc)->data_seq;
-
-	/*
-	 * Attempt to allocate whatever delalloc extent currently backs offset
-	 * and put the result into wpc->iomap.  Allocate in a loop because it
-	 * may take several attempts to allocate real blocks for a contiguous
-	 * delalloc extent if free space is sufficiently fragmented.
-	 */
-	do {
-		error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
-				&wpc->iomap, seq);
-		if (error)
-			return error;
-	} while (wpc->iomap.offset + wpc->iomap.length <= offset);
-
-	return 0;
-}
-
 static int
 xfs_map_blocks(
 	struct iomap_writepage_ctx *wpc,
@@ -281,6 +242,7 @@ xfs_map_blocks(
 	struct xfs_iext_cursor	icur;
 	int			retries = 0;
 	int			error = 0;
+	unsigned int		*seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -376,7 +338,19 @@ xfs_map_blocks(
 	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
-	error = xfs_convert_blocks(wpc, ip, whichfork, offset);
+	/*
+	 * Convert a dellalloc extent to a real one. The current page is held
+	 * locked so nothing could have removed the block backing offset_fsb,
+	 * although it could have moved from the COW to the data fork by another
+	 * thread.
+	 */
+	if (whichfork == XFS_COW_FORK)
+		seq = &XFS_WPC(wpc)->cow_seq;
+	else
+		seq = &XFS_WPC(wpc)->data_seq;
+
+	error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
+				&wpc->iomap, seq);
 	if (error) {
 		/*
 		 * If we failed to find the extent in the COW fork we might have
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 11e88a76a33c..4a712f1565c1 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -510,6 +510,9 @@ xfs_attri_validate(
 	unsigned int			op = attrp->alfi_op_flags &
 					     XFS_ATTRI_OP_FLAGS_TYPE_MASK;
 
+	if (!xfs_sb_version_haslogxattrs(&mp->m_sb))
+		return false;
+
 	if (attrp->__pad != 0)
 		return false;
 
@@ -601,8 +604,6 @@ xfs_attri_item_recover(
 	args->op_flags = XFS_DA_OP_RECOVERY | XFS_DA_OP_OKNOENT |
 			 XFS_DA_OP_LOGGED;
 
-	ASSERT(xfs_sb_version_haslogxattrs(&mp->m_sb));
-
 	switch (attr->xattri_op_flags) {
 	case XFS_ATTRI_OP_FLAGS_SET:
 	case XFS_ATTRI_OP_FLAGS_REPLACE:
@@ -716,48 +717,111 @@ xlog_recover_attri_commit_pass2(
 	const void			*attr_value = NULL;
 	const void			*attr_name;
 	size_t				len;
-
-	attri_formatp = item->ri_buf[0].i_addr;
-	attr_name = item->ri_buf[1].i_addr;
+	unsigned int			op, i = 0;
 
 	/* Validate xfs_attri_log_format before the large memory allocation */
 	len = sizeof(struct xfs_attri_log_format);
-	if (item->ri_buf[0].i_len != len) {
+	if (item->ri_buf[i].i_len != len) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				item->ri_buf[0].i_addr, item->ri_buf[0].i_len);
 		return -EFSCORRUPTED;
 	}
 
+	attri_formatp = item->ri_buf[i].i_addr;
 	if (!xfs_attri_validate(mp, attri_formatp)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-				item->ri_buf[0].i_addr, item->ri_buf[0].i_len);
+				attri_formatp, len);
+		return -EFSCORRUPTED;
+	}
+
+	/* Check the number of log iovecs makes sense for the op code. */
+	op = attri_formatp->alfi_op_flags & XFS_ATTRI_OP_FLAGS_TYPE_MASK;
+	switch (op) {
+	case XFS_ATTRI_OP_FLAGS_SET:
+	case XFS_ATTRI_OP_FLAGS_REPLACE:
+		/* Log item, attr name, attr value */
+		if (item->ri_total != 3) {
+			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+					     attri_formatp, len);
+			return -EFSCORRUPTED;
+		}
+		break;
+	case XFS_ATTRI_OP_FLAGS_REMOVE:
+		/* Log item, attr name */
+		if (item->ri_total != 2) {
+			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+					     attri_formatp, len);
+			return -EFSCORRUPTED;
+		}
+		break;
+	default:
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				     attri_formatp, len);
 		return -EFSCORRUPTED;
 	}
+	i++;
 
 	/* Validate the attr name */
-	if (item->ri_buf[1].i_len !=
+	if (item->ri_buf[i].i_len !=
 			xlog_calc_iovec_len(attri_formatp->alfi_name_len)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-				item->ri_buf[0].i_addr, item->ri_buf[0].i_len);
+				attri_formatp, len);
 		return -EFSCORRUPTED;
 	}
 
+	attr_name = item->ri_buf[i].i_addr;
 	if (!xfs_attr_namecheck(attr_name, attri_formatp->alfi_name_len)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
-				item->ri_buf[1].i_addr, item->ri_buf[1].i_len);
+				attri_formatp, len);
 		return -EFSCORRUPTED;
 	}
+	i++;
 
 	/* Validate the attr value, if present */
 	if (attri_formatp->alfi_value_len != 0) {
-		if (item->ri_buf[2].i_len != xlog_calc_iovec_len(attri_formatp->alfi_value_len)) {
+		if (item->ri_buf[i].i_len != xlog_calc_iovec_len(attri_formatp->alfi_value_len)) {
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					item->ri_buf[0].i_addr,
 					item->ri_buf[0].i_len);
 			return -EFSCORRUPTED;
 		}
 
-		attr_value = item->ri_buf[2].i_addr;
+		attr_value = item->ri_buf[i].i_addr;
+		i++;
+	}
+
+	/*
+	 * Make sure we got the correct number of buffers for the operation
+	 * that we just loaded.
+	 */
+	if (i != item->ri_total) {
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				attri_formatp, len);
+		return -EFSCORRUPTED;
+	}
+
+	switch (op) {
+	case XFS_ATTRI_OP_FLAGS_REMOVE:
+		/* Regular remove operations operate only on names. */
+		if (attr_value != NULL || attri_formatp->alfi_value_len != 0) {
+			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+					     attri_formatp, len);
+			return -EFSCORRUPTED;
+		}
+		fallthrough;
+	case XFS_ATTRI_OP_FLAGS_SET:
+	case XFS_ATTRI_OP_FLAGS_REPLACE:
+		/*
+		 * Regular xattr set/remove/replace operations require a name
+		 * and do not take a newname.  Values are optional for set and
+		 * replace.
+		 */
+		if (attr_name == NULL || attri_formatp->alfi_name_len == 0) {
+			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+					     attri_formatp, len);
+			return -EFSCORRUPTED;
+		}
+		break;
 	}
 
 	/*
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 468bb61a5e46..62b92e92a685 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -636,13 +636,11 @@ xfs_bmap_punch_delalloc_range(
 
 /*
  * Test whether it is appropriate to check an inode for and free post EOF
- * blocks. The 'force' parameter determines whether we should also consider
- * regular files that are marked preallocated or append-only.
+ * blocks.
  */
 bool
 xfs_can_free_eofblocks(
-	struct xfs_inode	*ip,
-	bool			force)
+	struct xfs_inode	*ip)
 {
 	struct xfs_bmbt_irec	imap;
 	struct xfs_mount	*mp = ip->i_mount;
@@ -676,11 +674,11 @@ xfs_can_free_eofblocks(
 		return false;
 
 	/*
-	 * Do not free real preallocated or append-only files unless the file
-	 * has delalloc blocks and we are forced to remove them.
+	 * Only free real extents for inodes with persistent preallocations or
+	 * the append-only flag.
 	 */
 	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND))
-		if (!force || ip->i_delayed_blks == 0)
+		if (ip->i_delayed_blks == 0)
 			return false;
 
 	/*
@@ -734,6 +732,22 @@ xfs_free_eofblocks(
 	/* Wait on dio to ensure i_size has settled. */
 	inode_dio_wait(VFS_I(ip));
 
+	/*
+	 * For preallocated files only free delayed allocations.
+	 *
+	 * Note that this means we also leave speculative preallocations in
+	 * place for preallocated files.
+	 */
+	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) {
+		if (ip->i_delayed_blks) {
+			xfs_bmap_punch_delalloc_range(ip,
+				round_up(XFS_ISIZE(ip), mp->m_sb.sb_blocksize),
+				LLONG_MAX);
+		}
+		xfs_inode_clear_eofblocks_tag(ip);
+		return 0;
+	}
+
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
 	if (error) {
 		ASSERT(xfs_is_shutdown(mp));
@@ -868,33 +882,32 @@ xfs_alloc_file_space(
 		if (error)
 			goto error;
 
-		error = xfs_bmapi_write(tp, ip, startoffset_fsb,
-				allocatesize_fsb, XFS_BMAPI_PREALLOC, 0, imapp,
-				&nimaps);
-		if (error)
-			goto error;
-
-		ip->i_diflags |= XFS_DIFLAG_PREALLOC;
-		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
-
-		error = xfs_trans_commit(tp);
-		xfs_iunlock(ip, XFS_ILOCK_EXCL);
-		if (error)
-			break;
-
 		/*
 		 * If the allocator cannot find a single free extent large
 		 * enough to cover the start block of the requested range,
-		 * xfs_bmapi_write will return 0 but leave *nimaps set to 0.
+		 * xfs_bmapi_write will return -ENOSR.
 		 *
 		 * In that case we simply need to keep looping with the same
 		 * startoffset_fsb so that one of the following allocations
 		 * will eventually reach the requested range.
 		 */
-		if (nimaps) {
+		error = xfs_bmapi_write(tp, ip, startoffset_fsb,
+				allocatesize_fsb, XFS_BMAPI_PREALLOC, 0, imapp,
+				&nimaps);
+		if (error) {
+			if (error != -ENOSR)
+				goto error;
+			error = 0;
+		} else {
 			startoffset_fsb += imapp->br_blockcount;
 			allocatesize_fsb -= imapp->br_blockcount;
 		}
+
+		ip->i_diflags |= XFS_DIFLAG_PREALLOC;
+		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+
+		error = xfs_trans_commit(tp);
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	}
 
 	return error;
@@ -1049,7 +1062,7 @@ xfs_prepare_shift(
 	 * Trim eofblocks to avoid shifting uninitialized post-eof preallocation
 	 * into the accessible region of the file.
 	 */
-	if (xfs_can_free_eofblocks(ip, true)) {
+	if (xfs_can_free_eofblocks(ip)) {
 		error = xfs_free_eofblocks(ip);
 		if (error)
 			return error;
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 6888078f5c31..1383019ccdb7 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -63,7 +63,7 @@ int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
 				xfs_off_t len);
 
 /* EOF block manipulation functions */
-bool	xfs_can_free_eofblocks(struct xfs_inode *ip, bool force);
+bool	xfs_can_free_eofblocks(struct xfs_inode *ip);
 int	xfs_free_eofblocks(struct xfs_inode *ip);
 
 int	xfs_swap_extents(struct xfs_inode *ip, struct xfs_inode *tip,
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index a8b2f3b278ea..6186b69be50a 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -333,7 +333,6 @@ xfs_dquot_disk_alloc(
 		goto err_cancel;
 
 	ASSERT(map.br_blockcount == XFS_DQUOT_CLUSTER_SIZE_FSB);
-	ASSERT(nmaps == 1);
 	ASSERT((map.br_startblock != DELAYSTARTBLOCK) &&
 	       (map.br_startblock != HOLESTARTBLOCK));
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 6df826fc787c..586d26c05160 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1186,7 +1186,7 @@ xfs_inode_free_eofblocks(
 	}
 	*lockflags |= XFS_IOLOCK_EXCL;
 
-	if (xfs_can_free_eofblocks(ip, false))
+	if (xfs_can_free_eofblocks(ip))
 		return xfs_free_eofblocks(ip);
 
 	/* inode could be preallocated or append-only */
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 26961b0dae03..b26d26d29273 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1459,7 +1459,7 @@ xfs_release(
 	if (!xfs_ilock_nowait(ip, XFS_IOLOCK_EXCL))
 		return 0;
 
-	if (xfs_can_free_eofblocks(ip, false)) {
+	if (xfs_can_free_eofblocks(ip)) {
 		/*
 		 * Check if the inode is being opened, written and closed
 		 * frequently and we have delayed allocation blocks outstanding
@@ -1675,15 +1675,13 @@ xfs_inode_needs_inactive(
 
 	/*
 	 * This file isn't being freed, so check if there are post-eof blocks
-	 * to free.  @force is true because we are evicting an inode from the
-	 * cache.  Post-eof blocks must be freed, lest we end up with broken
-	 * free space accounting.
+	 * to free.
 	 *
 	 * Note: don't bother with iolock here since lockdep complains about
 	 * acquiring it in reclaim context. We have the only reference to the
 	 * inode at this point anyways.
 	 */
-	return xfs_can_free_eofblocks(ip, true);
+	return xfs_can_free_eofblocks(ip);
 }
 
 /*
@@ -1734,15 +1732,11 @@ xfs_inactive(
 
 	if (VFS_I(ip)->i_nlink != 0) {
 		/*
-		 * force is true because we are evicting an inode from the
-		 * cache. Post-eof blocks must be freed, lest we end up with
-		 * broken free space accounting.
-		 *
 		 * Note: don't bother with iolock here since lockdep complains
 		 * about acquiring it in reclaim context. We have the only
 		 * reference to the inode at this point anyways.
 		 */
-		if (xfs_can_free_eofblocks(ip, true))
+		if (xfs_can_free_eofblocks(ip))
 			error = xfs_free_eofblocks(ip);
 
 		goto out;
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ab5512c0bcf7..28a1c19dfdb3 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -309,14 +309,6 @@ xfs_iomap_write_direct(
 	if (error)
 		goto out_unlock;
 
-	/*
-	 * Copy any maps to caller's array and return any error.
-	 */
-	if (nimaps == 0) {
-		error = -ENOSPC;
-		goto out_unlock;
-	}
-
 	if (unlikely(!xfs_valid_startblock(ip, imap->br_startblock)))
 		error = xfs_alert_fsblock_zero(ip, imap);
 
@@ -1004,6 +996,24 @@ xfs_buffered_write_iomap_begin(
 		goto out_unlock;
 	}
 
+	/*
+	 * For zeroing, trim a delalloc extent that extends beyond the EOF
+	 * block.  If it starts beyond the EOF block, convert it to an
+	 * unwritten extent.
+	 */
+	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
+	    isnullstartblock(imap.br_startblock)) {
+		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
+
+		if (offset_fsb >= eof_fsb)
+			goto convert_delay;
+		if (end_fsb > eof_fsb) {
+			end_fsb = eof_fsb;
+			xfs_trim_extent(&imap, offset_fsb,
+					end_fsb - offset_fsb);
+		}
+	}
+
 	/*
 	 * Search the COW fork extent list even if we did not find a data fork
 	 * extent.  This serves two purposes: first this implements the
@@ -1105,47 +1115,48 @@ xfs_buffered_write_iomap_begin(
 		}
 	}
 
-retry:
-	error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
-			end_fsb - offset_fsb, prealloc_blocks,
-			allocfork == XFS_DATA_FORK ? &imap : &cmap,
-			allocfork == XFS_DATA_FORK ? &icur : &ccur,
-			allocfork == XFS_DATA_FORK ? eof : cow_eof);
-	switch (error) {
-	case 0:
-		break;
-	case -ENOSPC:
-	case -EDQUOT:
-		/* retry without any preallocation */
-		trace_xfs_delalloc_enospc(ip, offset, count);
-		if (prealloc_blocks) {
-			prealloc_blocks = 0;
-			goto retry;
-		}
-		fallthrough;
-	default:
-		goto out_unlock;
-	}
-
 	if (allocfork == XFS_COW_FORK) {
+		error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
+				end_fsb - offset_fsb, prealloc_blocks, &cmap,
+				&ccur, cow_eof);
+		if (error)
+			goto out_unlock;
+
 		trace_xfs_iomap_alloc(ip, offset, count, allocfork, &cmap);
 		goto found_cow;
 	}
 
+	error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
+			end_fsb - offset_fsb, prealloc_blocks, &imap, &icur,
+			eof);
+	if (error)
+		goto out_unlock;
+
 	/*
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
 	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_NEW);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	xfs_iunlock(ip, lockmode);
 	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
 
 found_imap:
 	seq = xfs_iomap_inode_sequence(ip, 0);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	xfs_iunlock(ip, lockmode);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 
+convert_delay:
+	xfs_iunlock(ip, lockmode);
+	truncate_pagecache(inode, offset);
+	error = xfs_bmapi_convert_delalloc(ip, XFS_DATA_FORK, offset,
+					   iomap, NULL);
+	if (error)
+		return error;
+
+	trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
+	return 0;
+
 found_cow:
 	seq = xfs_iomap_inode_sequence(ip, 0);
 	if (imap.br_startoff <= offset_fsb) {
@@ -1153,17 +1164,17 @@ xfs_buffered_write_iomap_begin(
 		if (error)
 			goto out_unlock;
 		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
-		xfs_iunlock(ip, XFS_ILOCK_EXCL);
+		xfs_iunlock(ip, lockmode);
 		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
 					 IOMAP_F_SHARED, seq);
 	}
 
 	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	xfs_iunlock(ip, lockmode);
 	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
 
 out_unlock:
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	xfs_iunlock(ip, lockmode);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 1bac6a8af970..d539487eaf1a 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -431,13 +431,6 @@ xfs_reflink_fill_cow_hole(
 	if (error)
 		return error;
 
-	/*
-	 * Allocation succeeded but the requested range was not even partially
-	 * satisfied?  Bail out!
-	 */
-	if (nimaps == 0)
-		return -ENOSPC;
-
 convert:
 	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
 
@@ -500,13 +493,6 @@ xfs_reflink_fill_delalloc(
 		error = xfs_trans_commit(tp);
 		if (error)
 			return error;
-
-		/*
-		 * Allocation succeeded but the requested range was not even
-		 * partially satisfied?  Bail out!
-		 */
-		if (nimaps == 0)
-			return -ENOSPC;
 	} while (cmap->br_startoff + cmap->br_blockcount <= imap->br_startoff);
 
 	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
@@ -732,12 +718,6 @@ xfs_reflink_end_cow_extent(
 	int			nmaps;
 	int			error;
 
-	/* No COW extents?  That's easy! */
-	if (ifp->if_bytes == 0) {
-		*offset_fsb = end_fsb;
-		return 0;
-	}
-
 	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
 			XFS_TRANS_RESERVE, &tp);
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 7c5134899634..5cf1e91f4c20 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -840,8 +840,6 @@ xfs_growfs_rt_alloc(
 		nmap = 1;
 		error = xfs_bmapi_write(tp, ip, oblocks, nblocks - oblocks,
 					XFS_BMAPI_METADATA, 0, &map, &nmap);
-		if (!error && nmap < 1)
-			error = -ENOSPC;
 		if (error)
 			goto out_trans_cancel;
 		/*
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 3759d0a15c7b..d87a0d024693 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -789,8 +789,8 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy);
 
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
-				 unsigned int target_freq,
-				 unsigned int relation);
+				 unsigned int target_freq, unsigned int min,
+				 unsigned int max, unsigned int relation);
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq);
 
@@ -855,12 +855,12 @@ static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
 	return best;
 }
 
-/* Works only on sorted freq-tables */
-static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
-					     unsigned int target_freq,
-					     bool efficiencies)
+static inline int find_index_l(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_al(policy, target_freq,
@@ -870,6 +870,14 @@ static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
 						   efficiencies);
 }
 
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_l(policy, target_freq, policy->min, policy->max, efficiencies);
+}
+
 /* Find highest freq at or below target in a table in ascending order */
 static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
 					      unsigned int target_freq,
@@ -923,12 +931,12 @@ static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
 	return best;
 }
 
-/* Works only on sorted freq-tables */
-static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
-					     unsigned int target_freq,
-					     bool efficiencies)
+static inline int find_index_h(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_ah(policy, target_freq,
@@ -938,6 +946,14 @@ static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
 						   efficiencies);
 }
 
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_h(policy, target_freq, policy->min, policy->max, efficiencies);
+}
+
 /* Find closest freq to target in a table in ascending order */
 static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
 					      unsigned int target_freq,
@@ -1008,12 +1024,12 @@ static inline int cpufreq_table_find_index_dc(struct cpufreq_policy *policy,
 	return best;
 }
 
-/* Works only on sorted freq-tables */
-static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
-					     unsigned int target_freq,
-					     bool efficiencies)
+static inline int find_index_c(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_ac(policy, target_freq,
@@ -1023,7 +1039,17 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
 						   efficiencies);
 }
 
-static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy, int idx)
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_c(policy, target_freq, policy->min, policy->max, efficiencies);
+}
+
+static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy,
+					unsigned int min, unsigned int max,
+					int idx)
 {
 	unsigned int freq;
 
@@ -1032,11 +1058,13 @@ static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy, int idx)
 
 	freq = policy->freq_table[idx].frequency;
 
-	return freq == clamp_val(freq, policy->min, policy->max);
+	return freq == clamp_val(freq, min, max);
 }
 
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
+						 unsigned int min,
+						 unsigned int max,
 						 unsigned int relation)
 {
 	bool efficiencies = policy->efficiencies_available &&
@@ -1047,29 +1075,26 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 	relation &= ~CPUFREQ_RELATION_E;
 
 	if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
-		return cpufreq_table_index_unsorted(policy, target_freq,
-						    relation);
+		return cpufreq_table_index_unsorted(policy, target_freq, min,
+						    max, relation);
 retry:
 	switch (relation) {
 	case CPUFREQ_RELATION_L:
-		idx = cpufreq_table_find_index_l(policy, target_freq,
-						 efficiencies);
+		idx = find_index_l(policy, target_freq, min, max, efficiencies);
 		break;
 	case CPUFREQ_RELATION_H:
-		idx = cpufreq_table_find_index_h(policy, target_freq,
-						 efficiencies);
+		idx = find_index_h(policy, target_freq, min, max, efficiencies);
 		break;
 	case CPUFREQ_RELATION_C:
-		idx = cpufreq_table_find_index_c(policy, target_freq,
-						 efficiencies);
+		idx = find_index_c(policy, target_freq, min, max, efficiencies);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
 	}
 
-	/* Limit frequency index to honor policy->min/max */
-	if (!cpufreq_is_in_limits(policy, idx) && efficiencies) {
+	/* Limit frequency index to honor min and max */
+	if (!cpufreq_is_in_limits(policy, min, max, idx) && efficiencies) {
 		efficiencies = false;
 		goto retry;
 	}
diff --git a/include/soc/mscc/ocelot_vcap.h b/include/soc/mscc/ocelot_vcap.h
index c601a4598b0d..eb19668a06db 100644
--- a/include/soc/mscc/ocelot_vcap.h
+++ b/include/soc/mscc/ocelot_vcap.h
@@ -13,6 +13,7 @@
  */
 #define OCELOT_VCAP_ES0_TAG_8021Q_RXVLAN(ocelot, port, upstream) ((upstream) << 16 | (port))
 #define OCELOT_VCAP_IS1_TAG_8021Q_TXVLAN(ocelot, port)		(port)
+#define OCELOT_VCAP_IS1_VLAN_RECLASSIFY(ocelot, port)		((ocelot)->num_phys_ports + (port))
 #define OCELOT_VCAP_IS2_TAG_8021Q_TXVLAN(ocelot, port)		(port)
 #define OCELOT_VCAP_IS2_MRP_REDIRECT(ocelot, port)		((ocelot)->num_phys_ports + (port))
 #define OCELOT_VCAP_IS2_MRP_TRAP(ocelot)			((ocelot)->num_phys_ports * 2)
@@ -499,6 +500,7 @@ struct ocelot_vcap_key_vlan {
 	struct ocelot_vcap_u8  pcp;    /* PCP (3 bit) */
 	enum ocelot_vcap_bit dei;    /* DEI */
 	enum ocelot_vcap_bit tagged; /* Tagged/untagged frame */
+	enum ocelot_vcap_bit tpid;
 };
 
 struct ocelot_vcap_key_etype {
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index acc176aa1cbe..9da29583dfbc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7054,13 +7054,14 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 		/* Copy the data into the page, so we can start over. */
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
-					  trace_seq_used(&iter->seq));
+					  min((size_t)trace_seq_used(&iter->seq),
+						  PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;
 		}
 		spd.partial[i].offset = 0;
-		spd.partial[i].len = trace_seq_used(&iter->seq);
+		spd.partial[i].len = ret;
 
 		trace_seq_init(&iter->seq);
 	}
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 2f1f038b0dc1..d415b4fb2f1f 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -246,6 +246,62 @@ static struct sk_buff *__udpv4_gso_segment_list_csum(struct sk_buff *segs)
 	return segs;
 }
 
+static void __udpv6_gso_segment_csum(struct sk_buff *seg,
+				     struct in6_addr *oldip,
+				     const struct in6_addr *newip,
+				     __be16 *oldport, __be16 newport)
+{
+	struct udphdr *uh = udp_hdr(seg);
+
+	if (ipv6_addr_equal(oldip, newip) && *oldport == newport)
+		return;
+
+	if (uh->check) {
+		inet_proto_csum_replace16(&uh->check, seg, oldip->s6_addr32,
+					  newip->s6_addr32, true);
+
+		inet_proto_csum_replace2(&uh->check, seg, *oldport, newport,
+					 false);
+		if (!uh->check)
+			uh->check = CSUM_MANGLED_0;
+	}
+
+	*oldip = *newip;
+	*oldport = newport;
+}
+
+static struct sk_buff *__udpv6_gso_segment_list_csum(struct sk_buff *segs)
+{
+	const struct ipv6hdr *iph;
+	const struct udphdr *uh;
+	struct ipv6hdr *iph2;
+	struct sk_buff *seg;
+	struct udphdr *uh2;
+
+	seg = segs;
+	uh = udp_hdr(seg);
+	iph = ipv6_hdr(seg);
+	uh2 = udp_hdr(seg->next);
+	iph2 = ipv6_hdr(seg->next);
+
+	if (!(*(const u32 *)&uh->source ^ *(const u32 *)&uh2->source) &&
+	    ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
+	    ipv6_addr_equal(&iph->daddr, &iph2->daddr))
+		return segs;
+
+	while ((seg = seg->next)) {
+		uh2 = udp_hdr(seg);
+		iph2 = ipv6_hdr(seg);
+
+		__udpv6_gso_segment_csum(seg, &iph2->saddr, &iph->saddr,
+					 &uh2->source, uh->source);
+		__udpv6_gso_segment_csum(seg, &iph2->daddr, &iph->daddr,
+					 &uh2->dest, uh->dest);
+	}
+
+	return segs;
+}
+
 static struct sk_buff *__udp_gso_segment_list(struct sk_buff *skb,
 					      netdev_features_t features,
 					      bool is_ipv6)
@@ -258,7 +314,10 @@ static struct sk_buff *__udp_gso_segment_list(struct sk_buff *skb,
 
 	udp_hdr(skb)->len = htons(sizeof(struct udphdr) + mss);
 
-	return is_ipv6 ? skb : __udpv4_gso_segment_list_csum(skb);
+	if (is_ipv6)
+		return __udpv6_gso_segment_list_csum(skb);
+	else
+		return __udpv4_gso_segment_list_csum(skb);
 }
 
 struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index e35a4e90f4e6..3aee041c7bdb 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -36,6 +36,11 @@ struct drr_sched {
 	struct Qdisc_class_hash		clhash;
 };
 
+static bool cl_is_active(struct drr_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static struct drr_class *drr_find_class(struct Qdisc *sch, u32 classid)
 {
 	struct drr_sched *q = qdisc_priv(sch);
@@ -106,6 +111,7 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		return -ENOBUFS;
 
 	gnet_stats_basic_sync_init(&cl->bstats);
+	INIT_LIST_HEAD(&cl->alist);
 	cl->common.classid = classid;
 	cl->quantum	   = quantum;
 	cl->qdisc	   = qdisc_create_dflt(sch->dev_queue,
@@ -228,7 +234,7 @@ static void drr_qlen_notify(struct Qdisc *csh, unsigned long arg)
 {
 	struct drr_class *cl = (struct drr_class *)arg;
 
-	list_del(&cl->alist);
+	list_del_init(&cl->alist);
 }
 
 static int drr_dump_class(struct Qdisc *sch, unsigned long arg,
@@ -335,7 +341,6 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct drr_sched *q = qdisc_priv(sch);
 	struct drr_class *cl;
 	int err = 0;
-	bool first;
 
 	cl = drr_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -345,7 +350,6 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -355,7 +359,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first) {
+	if (!cl_is_active(cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
@@ -389,7 +393,7 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			if (unlikely(skb == NULL))
 				goto out;
 			if (cl->qdisc->q.qlen == 0)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 
 			bstats_update(&cl->bstats, skb);
 			qdisc_bstats_update(sch, skb);
@@ -430,7 +434,7 @@ static void drr_reset_qdisc(struct Qdisc *sch)
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
 			if (cl->qdisc->q.qlen)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 			qdisc_reset(cl->qdisc);
 		}
 	}
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 9fd70462b41d..9da86db4d2c2 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -74,6 +74,11 @@ static const struct nla_policy ets_class_policy[TCA_ETS_MAX + 1] = {
 	[TCA_ETS_QUANTA_BAND] = { .type = NLA_U32 },
 };
 
+static bool cl_is_active(struct ets_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static int ets_quantum_parse(struct Qdisc *sch, const struct nlattr *attr,
 			     unsigned int *quantum,
 			     struct netlink_ext_ack *extack)
@@ -293,7 +298,7 @@ static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	 * to remove them.
 	 */
 	if (!ets_class_is_strict(q, cl) && sch->q.qlen)
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 }
 
 static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
@@ -416,7 +421,6 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct ets_sched *q = qdisc_priv(sch);
 	struct ets_class *cl;
 	int err = 0;
-	bool first;
 
 	cl = ets_classify(skb, sch, &err);
 	if (!cl) {
@@ -426,7 +430,6 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -436,7 +439,7 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first && !ets_class_is_strict(q, cl)) {
+	if (!cl_is_active(cl) && !ets_class_is_strict(q, cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
@@ -488,7 +491,7 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 			if (unlikely(!skb))
 				goto out;
 			if (cl->qdisc->q.qlen == 0)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 			return ets_qdisc_dequeue_skb(sch, skb);
 		}
 
@@ -657,7 +660,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 	for (i = q->nbands; i < oldbands; i++) {
 		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
-			list_del(&q->classes[i].alist);
+			list_del_init(&q->classes[i].alist);
 		qdisc_tree_flush_backlog(q->classes[i].qdisc);
 	}
 	q->nstrict = nstrict;
@@ -713,7 +716,7 @@ static void ets_qdisc_reset(struct Qdisc *sch)
 
 	for (band = q->nstrict; band < q->nbands; band++) {
 		if (q->classes[band].qdisc->q.qlen)
-			list_del(&q->classes[band].alist);
+			list_del_init(&q->classes[band].alist);
 	}
 	for (band = 0; band < q->nbands; band++)
 		qdisc_reset(q->classes[band].qdisc);
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index dbed490aafd3..fc1370c29373 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -204,7 +204,10 @@ eltree_insert(struct hfsc_class *cl)
 static inline void
 eltree_remove(struct hfsc_class *cl)
 {
-	rb_erase(&cl->el_node, &cl->sched->eligible);
+	if (!RB_EMPTY_NODE(&cl->el_node)) {
+		rb_erase(&cl->el_node, &cl->sched->eligible);
+		RB_CLEAR_NODE(&cl->el_node);
+	}
 }
 
 static inline void
@@ -1222,7 +1225,8 @@ hfsc_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	/* vttree is now handled in update_vf() so that update_vf(cl, 0, 0)
 	 * needs to be called explicitly to remove a class from vttree.
 	 */
-	update_vf(cl, 0, 0);
+	if (cl->cl_nactive)
+		update_vf(cl, 0, 0);
 	if (cl->cl_flags & HFSC_RSC)
 		eltree_remove(cl);
 }
@@ -1564,7 +1568,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
-	if (first) {
+	if (first && !cl->cl_nactive) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index d23f8ea63082..fb0fb8825574 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1482,6 +1482,8 @@ static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)
 {
 	struct htb_class *cl = (struct htb_class *)arg;
 
+	if (!cl->prio_activity)
+		return;
 	htb_deactivate(qdisc_priv(sch), cl);
 }
 
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index ed01634af82c..6462468bf77c 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -204,6 +204,11 @@ struct qfq_sched {
  */
 enum update_reason {enqueue, requeue};
 
+static bool cl_is_active(struct qfq_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static struct qfq_class *qfq_find_class(struct Qdisc *sch, u32 classid)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
@@ -349,7 +354,7 @@ static void qfq_deactivate_class(struct qfq_sched *q, struct qfq_class *cl)
 	struct qfq_aggregate *agg = cl->agg;
 
 
-	list_del(&cl->alist); /* remove from RR queue of the aggregate */
+	list_del_init(&cl->alist); /* remove from RR queue of the aggregate */
 	if (list_empty(&agg->active)) /* agg is now inactive */
 		qfq_deactivate_agg(q, agg);
 }
@@ -478,6 +483,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	gnet_stats_basic_sync_init(&cl->bstats);
 	cl->common.classid = classid;
 	cl->deficit = lmax;
+	INIT_LIST_HEAD(&cl->alist);
 
 	cl->qdisc = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
 				      classid, NULL);
@@ -984,7 +990,7 @@ static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
 	cl->deficit -= (int) len;
 
 	if (cl->qdisc->q.qlen == 0) /* no more packets, remove from list */
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 	else if (cl->deficit < qdisc_pkt_len(cl->qdisc->ops->peek(cl->qdisc))) {
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
@@ -1216,7 +1222,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct qfq_class *cl;
 	struct qfq_aggregate *agg;
 	int err = 0;
-	bool first;
 
 	cl = qfq_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -1238,7 +1243,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	gso_segs = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		pr_debug("qfq_enqueue: enqueue failed %d\n", err);
@@ -1254,8 +1258,8 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	++sch->q.qlen;
 
 	agg = cl->agg;
-	/* if the queue was not empty, then done here */
-	if (!first) {
+	/* if the class is active, then done here */
+	if (cl_is_active(cl)) {
 		if (unlikely(skb == cl->qdisc->ops->peek(cl->qdisc)) &&
 		    list_first_entry(&agg->active, struct qfq_class, alist)
 		    == cl && cl->deficit < len)
@@ -1417,6 +1421,8 @@ static void qfq_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	struct qfq_sched *q = qdisc_priv(sch);
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
+	if (list_empty(&cl->alist))
+		return;
 	qfq_deactivate_class(q, cl);
 }
 
diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index f75c19ef3551..3f790d1f11a9 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -840,14 +840,14 @@ static void ak4613_parse_of(struct ak4613_priv *priv,
 	/* Input 1 - 2 */
 	for (i = 0; i < 2; i++) {
 		snprintf(prop, sizeof(prop), "asahi-kasei,in%d-single-end", i + 1);
-		if (!of_get_property(np, prop, NULL))
+		if (!of_property_read_bool(np, prop))
 			priv->ic |= 1 << i;
 	}
 
 	/* Output 1 - 6 */
 	for (i = 0; i < 6; i++) {
 		snprintf(prop, sizeof(prop), "asahi-kasei,out%d-single-end", i + 1);
-		if (!of_get_property(np, prop, NULL))
+		if (!of_property_read_bool(np, prop))
 			priv->oc |= 1 << i;
 	}
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6a4101dc15a5..b13370d2ec1d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2837,7 +2837,7 @@ int snd_soc_of_parse_pin_switches(struct snd_soc_card *card, const char *prop)
 	unsigned int i, nb_controls;
 	int ret;
 
-	if (!of_property_read_bool(dev->of_node, prop))
+	if (!of_property_present(dev->of_node, prop))
 		return 0;
 
 	strings = devm_kcalloc(dev, nb_controls_max,
@@ -2911,23 +2911,17 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 	if (rx_mask)
 		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-rx-mask", rx_mask);
 
-	if (of_property_read_bool(np, "dai-tdm-slot-num")) {
-		ret = of_property_read_u32(np, "dai-tdm-slot-num", &val);
-		if (ret)
-			return ret;
-
-		if (slots)
-			*slots = val;
-	}
-
-	if (of_property_read_bool(np, "dai-tdm-slot-width")) {
-		ret = of_property_read_u32(np, "dai-tdm-slot-width", &val);
-		if (ret)
-			return ret;
+	ret = of_property_read_u32(np, "dai-tdm-slot-num", &val);
+	if (ret && ret != -EINVAL)
+		return ret;
+	if (!ret && slots)
+		*slots = val;
 
-		if (slot_width)
-			*slot_width = val;
-	}
+	ret = of_property_read_u32(np, "dai-tdm-slot-width", &val);
+	if (ret && ret != -EINVAL)
+		return ret;
+	if (!ret && slot_width)
+		*slot_width = val;
 
 	return 0;
 }
@@ -3143,10 +3137,10 @@ unsigned int snd_soc_daifmt_parse_format(struct device_node *np,
 	 * SND_SOC_DAIFMT_INV_MASK area
 	 */
 	snprintf(prop, sizeof(prop), "%sbitclock-inversion", prefix);
-	bit = !!of_get_property(np, prop, NULL);
+	bit = of_property_read_bool(np, prop);
 
 	snprintf(prop, sizeof(prop), "%sframe-inversion", prefix);
-	frame = !!of_get_property(np, prop, NULL);
+	frame = of_property_read_bool(np, prop);
 
 	switch ((bit << 4) + frame) {
 	case 0x11:
@@ -3183,12 +3177,12 @@ unsigned int snd_soc_daifmt_parse_clock_provider_raw(struct device_node *np,
 	 * check "[prefix]frame-master"
 	 */
 	snprintf(prop, sizeof(prop), "%sbitclock-master", prefix);
-	bit = !!of_get_property(np, prop, NULL);
+	bit = of_property_present(np, prop);
 	if (bit && bitclkmaster)
 		*bitclkmaster = of_parse_phandle(np, prop, 0);
 
 	snprintf(prop, sizeof(prop), "%sframe-master", prefix);
-	frame = !!of_get_property(np, prop, NULL);
+	frame = of_property_present(np, prop);
 	if (frame && framemaster)
 		*framemaster = of_parse_phandle(np, prop, 0);
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3f998a09fc42..5a0fec90ae25 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1499,10 +1499,13 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		/*
 		 * Filter for systems with 'component_chaining' enabled.
 		 * This helps to avoid unnecessary re-configuration of an
-		 * already active BE on such systems.
+		 * already active BE on such systems and ensures the BE DAI
+		 * widget is powered ON after hw_params() BE DAI callback.
 		 */
 		if (fe->card->component_chaining &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_NEW) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
 			continue;
 
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 3b3a5ea6fcbf..f33d25a4e4cc 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -263,7 +263,8 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 	}
 
 	/* Jabra Evolve 65 headset */
-	if (chip->usb_id == USB_ID(0x0b0e, 0x030b)) {
+	if (chip->usb_id == USB_ID(0x0b0e, 0x030b) ||
+	    chip->usb_id == USB_ID(0x0b0e, 0x030c)) {
 		/* only 48kHz for playback while keeping 16kHz for capture */
 		if (fp->nr_rates != 1)
 			return set_fixed_rate(fp, 48000, SNDRV_PCM_RATE_48000);

