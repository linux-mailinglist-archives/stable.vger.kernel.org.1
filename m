Return-Path: <stable+bounces-121430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C83A56FA6
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932B63B30DB
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C36217718;
	Fri,  7 Mar 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f+iO0X9j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA924110F;
	Fri,  7 Mar 2025 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369981; cv=none; b=We1B9WrdjL2myBWYNAh/t5edGHoyxojUG6QkbaAwp+TlSzW2QZxVAk9JDlWhzX181qM1ZizKfVGnZnUPgkydyfC0HuEZYvtT0EUm65IKRvMnDCF9RzBw9XtI8zA817ra5wNaA6Gv+0ihJna+gAPbg54B666tHUPdLtQ/BiPCObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369981; c=relaxed/simple;
	bh=uU9zKgD21uSwi9BULmu419mBDwSnx/cwXXE3RPtWi+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uez4YG4HDG8ZojF3oQuIUlYi1rQCxjKPcLhCOzHSuzanuF0xf8wD8NykYn5M7wDglD3IXuPKYv/MCEEoMC4kZQDmxNpjTFWMlGmW4b6JSGK6QJxmiUEnYKtIopHlS7rRM1dcDcQOErkkZWwMwB6Pdd1ad4qiox82qfbzVaRhIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f+iO0X9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AECFC4CED1;
	Fri,  7 Mar 2025 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741369980;
	bh=uU9zKgD21uSwi9BULmu419mBDwSnx/cwXXE3RPtWi+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+iO0X9jrat+0p730SQpWQnoPuNFT+D9HC/OfDJC8ztpJReib3VgwC05Om0zu/g8s
	 gTcV/TLrDfTJcNJ6mIZFtgBXfewXpANHBWS7bYeXIevOpuv6VzedccK1a5JRUsjzQB
	 tAmcm9ZrJZLA7qVmPkEgNikStE49rIR4yNLFPrGI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.18
Date: Fri,  7 Mar 2025 18:52:45 +0100
Message-ID: <2025030745-slashing-hastiness-5416@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025030745-flaxseed-unsubtly-c5e3@gregkh>
References: <2025030745-flaxseed-unsubtly-c5e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index e8b8c5b38405..17dfe0a8ca8f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 17
+SUBLEVEL = 18
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index c315bc1a4e9a..1bf70fa1045d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1243,7 +1243,7 @@ int kvm_arm_pvtime_has_attr(struct kvm_vcpu *vcpu,
 extern unsigned int __ro_after_init kvm_arm_vmid_bits;
 int __init kvm_arm_vmid_alloc_init(void);
 void __init kvm_arm_vmid_alloc_free(void);
-bool kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid);
+void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid);
 void kvm_arm_vmid_clear_active(void);
 
 static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 117702f03321..3cf65daa75a5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -580,6 +580,16 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	mmu = vcpu->arch.hw_mmu;
 	last_ran = this_cpu_ptr(mmu->last_vcpu_ran);
 
+	/*
+	 * Ensure a VMID is allocated for the MMU before programming VTTBR_EL2,
+	 * which happens eagerly in VHE.
+	 *
+	 * Also, the VMID allocator only preserves VMIDs that are active at the
+	 * time of rollover, so KVM might need to grab a new VMID for the MMU if
+	 * this is called from kvm_sched_in().
+	 */
+	kvm_arm_vmid_update(&mmu->vmid);
+
 	/*
 	 * We guarantee that both TLBs and I-cache are private to each
 	 * vcpu. If detecting that a vcpu from the same VM has
@@ -1155,18 +1165,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 */
 		preempt_disable();
 
-		/*
-		 * The VMID allocator only tracks active VMIDs per
-		 * physical CPU, and therefore the VMID allocated may not be
-		 * preserved on VMID roll-over if the task was preempted,
-		 * making a thread's VMID inactive. So we need to call
-		 * kvm_arm_vmid_update() in non-premptible context.
-		 */
-		if (kvm_arm_vmid_update(&vcpu->arch.hw_mmu->vmid) &&
-		    has_vhe())
-			__load_stage2(vcpu->arch.hw_mmu,
-				      vcpu->arch.hw_mmu->arch);
-
 		kvm_pmu_flush_hwstate(vcpu);
 
 		local_irq_disable();
diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
index 806223b7022a..7fe8ba1a2851 100644
--- a/arch/arm64/kvm/vmid.c
+++ b/arch/arm64/kvm/vmid.c
@@ -135,11 +135,10 @@ void kvm_arm_vmid_clear_active(void)
 	atomic64_set(this_cpu_ptr(&active_vmids), VMID_ACTIVE_INVALID);
 }
 
-bool kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
+void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
 {
 	unsigned long flags;
 	u64 vmid, old_active_vmid;
-	bool updated = false;
 
 	vmid = atomic64_read(&kvm_vmid->id);
 
@@ -157,21 +156,17 @@ bool kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
 	if (old_active_vmid != 0 && vmid_gen_match(vmid) &&
 	    0 != atomic64_cmpxchg_relaxed(this_cpu_ptr(&active_vmids),
 					  old_active_vmid, vmid))
-		return false;
+		return;
 
 	raw_spin_lock_irqsave(&cpu_vmid_lock, flags);
 
 	/* Check that our VMID belongs to the current generation. */
 	vmid = atomic64_read(&kvm_vmid->id);
-	if (!vmid_gen_match(vmid)) {
+	if (!vmid_gen_match(vmid))
 		vmid = new_vmid(kvm_vmid);
-		updated = true;
-	}
 
 	atomic64_set(this_cpu_ptr(&active_vmids), vmid);
 	raw_spin_unlock_irqrestore(&cpu_vmid_lock, flags);
-
-	return updated;
 }
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ea71ef2e343c..93ba66de160c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -278,12 +278,7 @@ void __init arm64_memblock_init(void)
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern u16 memstart_offset_seed;
-
-		/*
-		 * Use the sanitised version of id_aa64mmfr0_el1 so that linear
-		 * map randomization can be enabled by shrinking the IPA space.
-		 */
-		u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
 		int parange = cpuid_feature_extract_unsigned_field(
 					mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
 		s64 range = linear_region_size -
diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index fc8130f995c1..6907c456ac8c 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -93,7 +93,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %[r])	\
 		_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %[r])	\
 	: [r] "+r" (ret), [v] "=&r" (val), [u] "+m" (*uaddr), [t] "=&r" (tmp)
-	: [ov] "Jr" (oldval), [nv] "Jr" (newval)
+	: [ov] "Jr" ((long)(int)oldval), [nv] "Jr" (newval)
 	: "memory");
 	__disable_user_access();
 
diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 2d40736fc37c..26b085dbdd07 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -108,11 +108,11 @@ int populate_cache_leaves(unsigned int cpu)
 	if (!np)
 		return -ENOENT;
 
-	if (of_property_read_bool(np, "cache-size"))
+	if (of_property_present(np, "cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
-	if (of_property_read_bool(np, "i-cache-size"))
+	if (of_property_present(np, "i-cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
-	if (of_property_read_bool(np, "d-cache-size"))
+	if (of_property_present(np, "d-cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 
 	prev = np;
@@ -125,11 +125,11 @@ int populate_cache_leaves(unsigned int cpu)
 			break;
 		if (level <= levels)
 			break;
-		if (of_property_read_bool(np, "cache-size"))
+		if (of_property_present(np, "cache-size"))
 			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
-		if (of_property_read_bool(np, "i-cache-size"))
+		if (of_property_present(np, "i-cache-size"))
 			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
-		if (of_property_read_bool(np, "d-cache-size"))
+		if (of_property_present(np, "d-cache-size"))
 			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 		levels = level;
 	}
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3a8eeaa9310c..308430af3e8f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -454,7 +454,7 @@ static void __init riscv_resolve_isa(unsigned long *source_isa,
 			if (bit < RISCV_ISA_EXT_BASE)
 				*this_hwcap |= isa2hwcap[bit];
 		}
-	} while (loop && memcmp(prev_resolved_isa, resolved_isa, sizeof(prev_resolved_isa)));
+	} while (loop && !bitmap_equal(prev_resolved_isa, resolved_isa, RISCV_ISA_EXT_MAX));
 }
 
 static void __init match_isa_ext(const char *name, const char *name_end, unsigned long *bitmap)
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2b3c152d3c91..7934613a98c8 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -288,8 +288,8 @@ void __init setup_arch(char **cmdline_p)
 
 	riscv_init_cbo_blocksizes();
 	riscv_fill_hwcap();
-	init_rt_signal_env();
 	apply_boot_alternatives();
+	init_rt_signal_env();
 
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
 	    riscv_isa_extension_available(NULL, ZICBOM))
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index dcd282419456..c3c517b9eee5 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -215,12 +215,6 @@ static size_t get_rt_frame_size(bool cal_all)
 		if (cal_all || riscv_v_vstate_query(task_pt_regs(current)))
 			total_context_size += riscv_v_sc_size;
 	}
-	/*
-	 * Preserved a __riscv_ctx_hdr for END signal context header if an
-	 * extension uses __riscv_extra_ext_header
-	 */
-	if (total_context_size)
-		total_context_size += sizeof(struct __riscv_ctx_hdr);
 
 	frame_size += total_context_size;
 
diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
index dce667f4b6ab..3070bb31745d 100644
--- a/arch/riscv/kvm/vcpu_sbi_hsm.c
+++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
+#include <linux/wordpart.h>
 #include <asm/sbi.h>
 #include <asm/kvm_vcpu_sbi.h>
 
@@ -79,12 +80,12 @@ static int kvm_sbi_hsm_vcpu_get_status(struct kvm_vcpu *vcpu)
 	target_vcpu = kvm_get_vcpu_by_id(vcpu->kvm, target_vcpuid);
 	if (!target_vcpu)
 		return SBI_ERR_INVALID_PARAM;
-	if (!kvm_riscv_vcpu_stopped(target_vcpu))
-		return SBI_HSM_STATE_STARTED;
-	else if (vcpu->stat.generic.blocking)
+	if (kvm_riscv_vcpu_stopped(target_vcpu))
+		return SBI_HSM_STATE_STOPPED;
+	else if (target_vcpu->stat.generic.blocking)
 		return SBI_HSM_STATE_SUSPENDED;
 	else
-		return SBI_HSM_STATE_STOPPED;
+		return SBI_HSM_STATE_STARTED;
 }
 
 static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
@@ -109,7 +110,7 @@ static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		}
 		return 0;
 	case SBI_EXT_HSM_HART_SUSPEND:
-		switch (cp->a0) {
+		switch (lower_32_bits(cp->a0)) {
 		case SBI_HSM_SUSPEND_RET_DEFAULT:
 			kvm_riscv_vcpu_wfi(vcpu);
 			break;
diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index 9c2ab3dfa93a..5fbf3f94f1e8 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -21,7 +21,7 @@ static int kvm_sbi_ext_time_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	u64 next_cycle;
 
 	if (cp->a6 != SBI_EXT_TIME_SET_TIMER) {
-		retdata->err_val = SBI_ERR_INVALID_PARAM;
+		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 		return 0;
 	}
 
@@ -51,9 +51,10 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
 	unsigned long hmask = cp->a0;
 	unsigned long hbase = cp->a1;
+	unsigned long hart_bit = 0, sentmask = 0;
 
 	if (cp->a6 != SBI_EXT_IPI_SEND_IPI) {
-		retdata->err_val = SBI_ERR_INVALID_PARAM;
+		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 		return 0;
 	}
 
@@ -62,15 +63,23 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		if (hbase != -1UL) {
 			if (tmp->vcpu_id < hbase)
 				continue;
-			if (!(hmask & (1UL << (tmp->vcpu_id - hbase))))
+			hart_bit = tmp->vcpu_id - hbase;
+			if (hart_bit >= __riscv_xlen)
+				goto done;
+			if (!(hmask & (1UL << hart_bit)))
 				continue;
 		}
 		ret = kvm_riscv_vcpu_set_interrupt(tmp, IRQ_VS_SOFT);
 		if (ret < 0)
 			break;
+		sentmask |= 1UL << hart_bit;
 		kvm_riscv_vcpu_pmu_incr_fw(tmp, SBI_PMU_FW_IPI_RCVD);
 	}
 
+done:
+	if (hbase != -1UL && (hmask ^ sentmask))
+		retdata->err_val = SBI_ERR_INVALID_PARAM;
+
 	return ret;
 }
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1b0c2397d657..6f8e9af827e0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1333,6 +1333,7 @@ config X86_REBOOTFIXUPS
 config MICROCODE
 	def_bool y
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
+	select CRYPTO_LIB_SHA256 if CPU_SUP_AMD
 
 config MICROCODE_INITRD32
 	def_bool y
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 65ab6460aed4..0d33c85da453 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -628,7 +628,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= x86_pmu_get_event_config(event);
 
-	if (event->attr.sample_period && x86_pmu.limit_period) {
+	if (!event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 9651275aecd1..dfec2c61e354 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -153,8 +153,8 @@ static void geode_configure(void)
 	u8 ccr3;
 	local_irq_save(flags);
 
-	/* Suspend on halt power saving and enable #SUSP pin */
-	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
+	/* Suspend on halt power saving */
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x08);
 
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* enable MAPEN */
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index fb5d0c67fbab..f5365b32582a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -23,14 +23,18 @@
 
 #include <linux/earlycpio.h>
 #include <linux/firmware.h>
+#include <linux/bsearch.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 #include <linux/initrd.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
+#include <crypto/sha2.h>
+
 #include <asm/microcode.h>
 #include <asm/processor.h>
+#include <asm/cmdline.h>
 #include <asm/setup.h>
 #include <asm/cpu.h>
 #include <asm/msr.h>
@@ -145,6 +149,107 @@ ucode_path[] __maybe_unused = "kernel/x86/microcode/AuthenticAMD.bin";
  */
 static u32 bsp_cpuid_1_eax __ro_after_init;
 
+static bool sha_check = true;
+
+struct patch_digest {
+	u32 patch_id;
+	u8 sha256[SHA256_DIGEST_SIZE];
+};
+
+#include "amd_shas.c"
+
+static int cmp_id(const void *key, const void *elem)
+{
+	struct patch_digest *pd = (struct patch_digest *)elem;
+	u32 patch_id = *(u32 *)key;
+
+	if (patch_id == pd->patch_id)
+		return 0;
+	else if (patch_id < pd->patch_id)
+		return -1;
+	else
+		return 1;
+}
+
+static bool need_sha_check(u32 cur_rev)
+{
+	switch (cur_rev >> 8) {
+	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x83010: return cur_rev <= 0x830107c; break;
+	case 0x86001: return cur_rev <= 0x860010e; break;
+	case 0x86081: return cur_rev <= 0x8608108; break;
+	case 0x87010: return cur_rev <= 0x8701034; break;
+	case 0x8a000: return cur_rev <= 0x8a0000a; break;
+	case 0xa0011: return cur_rev <= 0xa0011da; break;
+	case 0xa0012: return cur_rev <= 0xa001243; break;
+	case 0xa1011: return cur_rev <= 0xa101153; break;
+	case 0xa1012: return cur_rev <= 0xa10124e; break;
+	case 0xa1081: return cur_rev <= 0xa108109; break;
+	case 0xa2010: return cur_rev <= 0xa20102f; break;
+	case 0xa2012: return cur_rev <= 0xa201212; break;
+	case 0xa6012: return cur_rev <= 0xa60120a; break;
+	case 0xa7041: return cur_rev <= 0xa704109; break;
+	case 0xa7052: return cur_rev <= 0xa705208; break;
+	case 0xa7080: return cur_rev <= 0xa708009; break;
+	case 0xa70c0: return cur_rev <= 0xa70C009; break;
+	case 0xaa002: return cur_rev <= 0xaa00218; break;
+	default: break;
+	}
+
+	pr_info("You should not be seeing this. Please send the following couple of lines to x86-<at>-kernel.org\n");
+	pr_info("CPUID(1).EAX: 0x%x, current revision: 0x%x\n", bsp_cpuid_1_eax, cur_rev);
+	return true;
+}
+
+static bool verify_sha256_digest(u32 patch_id, u32 cur_rev, const u8 *data, unsigned int len)
+{
+	struct patch_digest *pd = NULL;
+	u8 digest[SHA256_DIGEST_SIZE];
+	struct sha256_state s;
+	int i;
+
+	if (x86_family(bsp_cpuid_1_eax) < 0x17 ||
+	    x86_family(bsp_cpuid_1_eax) > 0x19)
+		return true;
+
+	if (!need_sha_check(cur_rev))
+		return true;
+
+	if (!sha_check)
+		return true;
+
+	pd = bsearch(&patch_id, phashes, ARRAY_SIZE(phashes), sizeof(struct patch_digest), cmp_id);
+	if (!pd) {
+		pr_err("No sha256 digest for patch ID: 0x%x found\n", patch_id);
+		return false;
+	}
+
+	sha256_init(&s);
+	sha256_update(&s, data, len);
+	sha256_final(&s, digest);
+
+	if (memcmp(digest, pd->sha256, sizeof(digest))) {
+		pr_err("Patch 0x%x SHA256 digest mismatch!\n", patch_id);
+
+		for (i = 0; i < SHA256_DIGEST_SIZE; i++)
+			pr_cont("0x%x ", digest[i]);
+		pr_info("\n");
+
+		return false;
+	}
+
+	return true;
+}
+
+static u32 get_patch_level(void)
+{
+	u32 rev, dummy __always_unused;
+
+	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+
+	return rev;
+}
+
 static union cpuid_1_eax ucode_rev_to_cpuid(unsigned int val)
 {
 	union zen_patch_rev p;
@@ -246,8 +351,7 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size)
  * On success, @sh_psize returns the patch size according to the section header,
  * to the caller.
  */
-static bool
-__verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
+static bool __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
 {
 	u32 p_type, p_size;
 	const u32 *hdr;
@@ -484,10 +588,13 @@ static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
 	}
 }
 
-static int __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
+static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
+				  unsigned int psize)
 {
 	unsigned long p_addr = (unsigned long)&mc->hdr.data_code;
-	u32 rev, dummy;
+
+	if (!verify_sha256_digest(mc->hdr.patch_id, *cur_rev, (const u8 *)p_addr, psize))
+		return -1;
 
 	native_wrmsrl(MSR_AMD64_PATCH_LOADER, p_addr);
 
@@ -505,47 +612,13 @@ static int __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
 	}
 
 	/* verify patch application was successful */
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	if (rev != mc->hdr.patch_id)
-		return -1;
+	*cur_rev = get_patch_level();
+	if (*cur_rev != mc->hdr.patch_id)
+		return false;
 
-	return 0;
+	return true;
 }
 
-/*
- * Early load occurs before we can vmalloc(). So we look for the microcode
- * patch container file in initrd, traverse equivalent cpu table, look for a
- * matching microcode patch, and update, all in initrd memory in place.
- * When vmalloc() is available for use later -- on 64-bit during first AP load,
- * and on 32-bit during save_microcode_in_initrd_amd() -- we can call
- * load_microcode_amd() to save equivalent cpu table and microcode patches in
- * kernel heap memory.
- *
- * Returns true if container found (sets @desc), false otherwise.
- */
-static bool early_apply_microcode(u32 old_rev, void *ucode, size_t size)
-{
-	struct cont_desc desc = { 0 };
-	struct microcode_amd *mc;
-	bool ret = false;
-
-	scan_containers(ucode, size, &desc);
-
-	mc = desc.mc;
-	if (!mc)
-		return ret;
-
-	/*
-	 * Allow application of the same revision to pick up SMT-specific
-	 * changes even if the revision of the other SMT thread is already
-	 * up-to-date.
-	 */
-	if (old_rev > mc->hdr.patch_id)
-		return ret;
-
-	return !__apply_microcode_amd(mc, desc.psize);
-}
 
 static bool get_builtin_microcode(struct cpio_data *cp)
 {
@@ -569,64 +642,74 @@ static bool get_builtin_microcode(struct cpio_data *cp)
 	return false;
 }
 
-static void __init find_blobs_in_containers(struct cpio_data *ret)
+static bool __init find_blobs_in_containers(struct cpio_data *ret)
 {
 	struct cpio_data cp;
+	bool found;
 
 	if (!get_builtin_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
-	*ret = cp;
+	found = cp.data && cp.size;
+	if (found)
+		*ret = cp;
+
+	return found;
 }
 
+/*
+ * Early load occurs before we can vmalloc(). So we look for the microcode
+ * patch container file in initrd, traverse equivalent cpu table, look for a
+ * matching microcode patch, and update, all in initrd memory in place.
+ * When vmalloc() is available for use later -- on 64-bit during first AP load,
+ * and on 32-bit during save_microcode_in_initrd() -- we can call
+ * load_microcode_amd() to save equivalent cpu table and microcode patches in
+ * kernel heap memory.
+ */
 void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_eax)
 {
+	struct cont_desc desc = { };
+	struct microcode_amd *mc;
 	struct cpio_data cp = { };
-	u32 dummy;
+	char buf[4];
+	u32 rev;
+
+	if (cmdline_find_option(boot_command_line, "microcode.amd_sha_check", buf, 4)) {
+		if (!strncmp(buf, "off", 3)) {
+			sha_check = false;
+			pr_warn_once("It is a very very bad idea to disable the blobs SHA check!\n");
+			add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+		}
+	}
 
 	bsp_cpuid_1_eax = cpuid_1_eax;
 
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->old_rev, dummy);
+	rev = get_patch_level();
+	ed->old_rev = rev;
 
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
 
-	find_blobs_in_containers(&cp);
-	if (!(cp.data && cp.size))
+	if (!find_blobs_in_containers(&cp))
 		return;
 
-	if (early_apply_microcode(ed->old_rev, cp.data, cp.size))
-		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
-}
-
-static enum ucode_state _load_microcode_amd(u8 family, const u8 *data, size_t size);
-
-static int __init save_microcode_in_initrd(void)
-{
-	unsigned int cpuid_1_eax = native_cpuid_eax(1);
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-	struct cont_desc desc = { 0 };
-	enum ucode_state ret;
-	struct cpio_data cp;
-
-	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
-		return 0;
-
-	find_blobs_in_containers(&cp);
-	if (!(cp.data && cp.size))
-		return -EINVAL;
-
 	scan_containers(cp.data, cp.size, &desc);
-	if (!desc.mc)
-		return -EINVAL;
 
-	ret = _load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
-	if (ret > UCODE_UPDATED)
-		return -EINVAL;
+	mc = desc.mc;
+	if (!mc)
+		return;
 
-	return 0;
+	/*
+	 * Allow application of the same revision to pick up SMT-specific
+	 * changes even if the revision of the other SMT thread is already
+	 * up-to-date.
+	 */
+	if (ed->old_rev > mc->hdr.patch_id)
+		return;
+
+	if (__apply_microcode_amd(mc, &rev, desc.psize))
+		ed->new_rev = rev;
 }
-early_initcall(save_microcode_in_initrd);
 
 static inline bool patch_cpus_equivalent(struct ucode_patch *p,
 					 struct ucode_patch *n,
@@ -727,14 +810,9 @@ static void free_cache(void)
 static struct ucode_patch *find_patch(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	u32 rev, dummy __always_unused;
 	u16 equiv_id = 0;
 
-	/* fetch rev if not populated yet: */
-	if (!uci->cpu_sig.rev) {
-		rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-		uci->cpu_sig.rev = rev;
-	}
+	uci->cpu_sig.rev = get_patch_level();
 
 	if (x86_family(bsp_cpuid_1_eax) < 0x17) {
 		equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
@@ -757,22 +835,20 @@ void reload_ucode_amd(unsigned int cpu)
 
 	mc = p->data;
 
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
+	rev = get_patch_level();
 	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc, p->size))
-			pr_info_once("reload revision: 0x%08x\n", mc->hdr.patch_id);
+		if (__apply_microcode_amd(mc, &rev, p->size))
+			pr_info_once("reload revision: 0x%08x\n", rev);
 	}
 }
 
 static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct ucode_patch *p;
 
 	csig->sig = cpuid_eax(0x00000001);
-	csig->rev = c->microcode;
+	csig->rev = get_patch_level();
 
 	/*
 	 * a patch could have been loaded early, set uci->mc so that
@@ -813,7 +889,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 		goto out;
 	}
 
-	if (__apply_microcode_amd(mc_amd, p->size)) {
+	if (!__apply_microcode_amd(mc_amd, &rev, p->size)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
 		return UCODE_ERROR;
@@ -935,8 +1011,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 }
 
 /* Scan the blob in @data and add microcode patches to the cache. */
-static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
-					     size_t size)
+static enum ucode_state __load_microcode_amd(u8 family, const u8 *data, size_t size)
 {
 	u8 *fw = (u8 *)data;
 	size_t offset;
@@ -1011,6 +1086,32 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 	return ret;
 }
 
+static int __init save_microcode_in_initrd(void)
+{
+	unsigned int cpuid_1_eax = native_cpuid_eax(1);
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	struct cont_desc desc = { 0 };
+	enum ucode_state ret;
+	struct cpio_data cp;
+
+	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
+		return 0;
+
+	if (!find_blobs_in_containers(&cp))
+		return -EINVAL;
+
+	scan_containers(cp.data, cp.size, &desc);
+	if (!desc.mc)
+		return -EINVAL;
+
+	ret = _load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
+	if (ret > UCODE_UPDATED)
+		return -EINVAL;
+
+	return 0;
+}
+early_initcall(save_microcode_in_initrd);
+
 /*
  * AMD microcode firmware naming convention, up to family 15h they are in
  * the legacy file:
diff --git a/arch/x86/kernel/cpu/microcode/amd_shas.c b/arch/x86/kernel/cpu/microcode/amd_shas.c
new file mode 100644
index 000000000000..2a1655b1fdd8
--- /dev/null
+++ b/arch/x86/kernel/cpu/microcode/amd_shas.c
@@ -0,0 +1,444 @@
+/* Keep 'em sorted. */
+static const struct patch_digest phashes[] = {
+ { 0x8001227, {
+		0x99,0xc0,0x9b,0x2b,0xcc,0x9f,0x52,0x1b,
+		0x1a,0x5f,0x1d,0x83,0xa1,0x6c,0xc4,0x46,
+		0xe2,0x6c,0xda,0x73,0xfb,0x2d,0x23,0xa8,
+		0x77,0xdc,0x15,0x31,0x33,0x4a,0x46,0x18,
+	}
+ },
+ { 0x8001250, {
+		0xc0,0x0b,0x6b,0x19,0xfd,0x5c,0x39,0x60,
+		0xd5,0xc3,0x57,0x46,0x54,0xe4,0xd1,0xaa,
+		0xa8,0xf7,0x1f,0xa8,0x6a,0x60,0x3e,0xe3,
+		0x27,0x39,0x8e,0x53,0x30,0xf8,0x49,0x19,
+	}
+ },
+ { 0x800126e, {
+		0xf3,0x8b,0x2b,0xb6,0x34,0xe3,0xc8,0x2c,
+		0xef,0xec,0x63,0x6d,0xc8,0x76,0x77,0xb3,
+		0x25,0x5a,0xb7,0x52,0x8c,0x83,0x26,0xe6,
+		0x4c,0xbe,0xbf,0xe9,0x7d,0x22,0x6a,0x43,
+	}
+ },
+ { 0x800126f, {
+		0x2b,0x5a,0xf2,0x9c,0xdd,0xd2,0x7f,0xec,
+		0xec,0x96,0x09,0x57,0xb0,0x96,0x29,0x8b,
+		0x2e,0x26,0x91,0xf0,0x49,0x33,0x42,0x18,
+		0xdd,0x4b,0x65,0x5a,0xd4,0x15,0x3d,0x33,
+	}
+ },
+ { 0x800820d, {
+		0x68,0x98,0x83,0xcd,0x22,0x0d,0xdd,0x59,
+		0x73,0x2c,0x5b,0x37,0x1f,0x84,0x0e,0x67,
+		0x96,0x43,0x83,0x0c,0x46,0x44,0xab,0x7c,
+		0x7b,0x65,0x9e,0x57,0xb5,0x90,0x4b,0x0e,
+	}
+ },
+ { 0x8301025, {
+		0xe4,0x7d,0xdb,0x1e,0x14,0xb4,0x5e,0x36,
+		0x8f,0x3e,0x48,0x88,0x3c,0x6d,0x76,0xa1,
+		0x59,0xc6,0xc0,0x72,0x42,0xdf,0x6c,0x30,
+		0x6f,0x0b,0x28,0x16,0x61,0xfc,0x79,0x77,
+	}
+ },
+ { 0x8301055, {
+		0x81,0x7b,0x99,0x1b,0xae,0x2d,0x4f,0x9a,
+		0xef,0x13,0xce,0xb5,0x10,0xaf,0x6a,0xea,
+		0xe5,0xb0,0x64,0x98,0x10,0x68,0x34,0x3b,
+		0x9d,0x7a,0xd6,0x22,0x77,0x5f,0xb3,0x5b,
+	}
+ },
+ { 0x8301072, {
+		0xcf,0x76,0xa7,0x1a,0x49,0xdf,0x2a,0x5e,
+		0x9e,0x40,0x70,0xe5,0xdd,0x8a,0xa8,0x28,
+		0x20,0xdc,0x91,0xd8,0x2c,0xa6,0xa0,0xb1,
+		0x2d,0x22,0x26,0x94,0x4b,0x40,0x85,0x30,
+	}
+ },
+ { 0x830107a, {
+		0x2a,0x65,0x8c,0x1a,0x5e,0x07,0x21,0x72,
+		0xdf,0x90,0xa6,0x51,0x37,0xd3,0x4b,0x34,
+		0xc4,0xda,0x03,0xe1,0x8a,0x6c,0xfb,0x20,
+		0x04,0xb2,0x81,0x05,0xd4,0x87,0xf4,0x0a,
+	}
+ },
+ { 0x830107b, {
+		0xb3,0x43,0x13,0x63,0x56,0xc1,0x39,0xad,
+		0x10,0xa6,0x2b,0xcc,0x02,0xe6,0x76,0x2a,
+		0x1e,0x39,0x58,0x3e,0x23,0x6e,0xa4,0x04,
+		0x95,0xea,0xf9,0x6d,0xc2,0x8a,0x13,0x19,
+	}
+ },
+ { 0x830107c, {
+		0x21,0x64,0xde,0xfb,0x9f,0x68,0x96,0x47,
+		0x70,0x5c,0xe2,0x8f,0x18,0x52,0x6a,0xac,
+		0xa4,0xd2,0x2e,0xe0,0xde,0x68,0x66,0xc3,
+		0xeb,0x1e,0xd3,0x3f,0xbc,0x51,0x1d,0x38,
+	}
+ },
+ { 0x860010d, {
+		0x86,0xb6,0x15,0x83,0xbc,0x3b,0x9c,0xe0,
+		0xb3,0xef,0x1d,0x99,0x84,0x35,0x15,0xf7,
+		0x7c,0x2a,0xc6,0x42,0xdb,0x73,0x07,0x5c,
+		0x7d,0xc3,0x02,0xb5,0x43,0x06,0x5e,0xf8,
+	}
+ },
+ { 0x8608108, {
+		0x14,0xfe,0x57,0x86,0x49,0xc8,0x68,0xe2,
+		0x11,0xa3,0xcb,0x6e,0xff,0x6e,0xd5,0x38,
+		0xfe,0x89,0x1a,0xe0,0x67,0xbf,0xc4,0xcc,
+		0x1b,0x9f,0x84,0x77,0x2b,0x9f,0xaa,0xbd,
+	}
+ },
+ { 0x8701034, {
+		0xc3,0x14,0x09,0xa8,0x9c,0x3f,0x8d,0x83,
+		0x9b,0x4c,0xa5,0xb7,0x64,0x8b,0x91,0x5d,
+		0x85,0x6a,0x39,0x26,0x1e,0x14,0x41,0xa8,
+		0x75,0xea,0xa6,0xf9,0xc9,0xd1,0xea,0x2b,
+	}
+ },
+ { 0x8a00008, {
+		0xd7,0x2a,0x93,0xdc,0x05,0x2f,0xa5,0x6e,
+		0x0c,0x61,0x2c,0x07,0x9f,0x38,0xe9,0x8e,
+		0xef,0x7d,0x2a,0x05,0x4d,0x56,0xaf,0x72,
+		0xe7,0x56,0x47,0x6e,0x60,0x27,0xd5,0x8c,
+	}
+ },
+ { 0x8a0000a, {
+		0x73,0x31,0x26,0x22,0xd4,0xf9,0xee,0x3c,
+		0x07,0x06,0xe7,0xb9,0xad,0xd8,0x72,0x44,
+		0x33,0x31,0xaa,0x7d,0xc3,0x67,0x0e,0xdb,
+		0x47,0xb5,0xaa,0xbc,0xf5,0xbb,0xd9,0x20,
+	}
+ },
+ { 0xa00104c, {
+		0x3c,0x8a,0xfe,0x04,0x62,0xd8,0x6d,0xbe,
+		0xa7,0x14,0x28,0x64,0x75,0xc0,0xa3,0x76,
+		0xb7,0x92,0x0b,0x97,0x0a,0x8e,0x9c,0x5b,
+		0x1b,0xc8,0x9d,0x3a,0x1e,0x81,0x3d,0x3b,
+	}
+ },
+ { 0xa00104e, {
+		0xc4,0x35,0x82,0x67,0xd2,0x86,0xe5,0xb2,
+		0xfd,0x69,0x12,0x38,0xc8,0x77,0xba,0xe0,
+		0x70,0xf9,0x77,0x89,0x10,0xa6,0x74,0x4e,
+		0x56,0x58,0x13,0xf5,0x84,0x70,0x28,0x0b,
+	}
+ },
+ { 0xa001053, {
+		0x92,0x0e,0xf4,0x69,0x10,0x3b,0xf9,0x9d,
+		0x31,0x1b,0xa6,0x99,0x08,0x7d,0xd7,0x25,
+		0x7e,0x1e,0x89,0xba,0x35,0x8d,0xac,0xcb,
+		0x3a,0xb4,0xdf,0x58,0x12,0xcf,0xc0,0xc3,
+	}
+ },
+ { 0xa001058, {
+		0x33,0x7d,0xa9,0xb5,0x4e,0x62,0x13,0x36,
+		0xef,0x66,0xc9,0xbd,0x0a,0xa6,0x3b,0x19,
+		0xcb,0xf5,0xc2,0xc3,0x55,0x47,0x20,0xec,
+		0x1f,0x7b,0xa1,0x44,0x0e,0x8e,0xa4,0xb2,
+	}
+ },
+ { 0xa001075, {
+		0x39,0x02,0x82,0xd0,0x7c,0x26,0x43,0xe9,
+		0x26,0xa3,0xd9,0x96,0xf7,0x30,0x13,0x0a,
+		0x8a,0x0e,0xac,0xe7,0x1d,0xdc,0xe2,0x0f,
+		0xcb,0x9e,0x8d,0xbc,0xd2,0xa2,0x44,0xe0,
+	}
+ },
+ { 0xa001078, {
+		0x2d,0x67,0xc7,0x35,0xca,0xef,0x2f,0x25,
+		0x4c,0x45,0x93,0x3f,0x36,0x01,0x8c,0xce,
+		0xa8,0x5b,0x07,0xd3,0xc1,0x35,0x3c,0x04,
+		0x20,0xa2,0xfc,0xdc,0xe6,0xce,0x26,0x3e,
+	}
+ },
+ { 0xa001079, {
+		0x43,0xe2,0x05,0x9c,0xfd,0xb7,0x5b,0xeb,
+		0x5b,0xe9,0xeb,0x3b,0x96,0xf4,0xe4,0x93,
+		0x73,0x45,0x3e,0xac,0x8d,0x3b,0xe4,0xdb,
+		0x10,0x31,0xc1,0xe4,0xa2,0xd0,0x5a,0x8a,
+	}
+ },
+ { 0xa00107a, {
+		0x5f,0x92,0xca,0xff,0xc3,0x59,0x22,0x5f,
+		0x02,0xa0,0x91,0x3b,0x4a,0x45,0x10,0xfd,
+		0x19,0xe1,0x8a,0x6d,0x9a,0x92,0xc1,0x3f,
+		0x75,0x78,0xac,0x78,0x03,0x1d,0xdb,0x18,
+	}
+ },
+ { 0xa001143, {
+		0x56,0xca,0xf7,0x43,0x8a,0x4c,0x46,0x80,
+		0xec,0xde,0xe5,0x9c,0x50,0x84,0x9a,0x42,
+		0x27,0xe5,0x51,0x84,0x8f,0x19,0xc0,0x8d,
+		0x0c,0x25,0xb4,0xb0,0x8f,0x10,0xf3,0xf8,
+	}
+ },
+ { 0xa001144, {
+		0x42,0xd5,0x9b,0xa7,0xd6,0x15,0x29,0x41,
+		0x61,0xc4,0x72,0x3f,0xf3,0x06,0x78,0x4b,
+		0x65,0xf3,0x0e,0xfa,0x9c,0x87,0xde,0x25,
+		0xbd,0xb3,0x9a,0xf4,0x75,0x13,0x53,0xdc,
+	}
+ },
+ { 0xa00115d, {
+		0xd4,0xc4,0x49,0x36,0x89,0x0b,0x47,0xdd,
+		0xfb,0x2f,0x88,0x3b,0x5f,0xf2,0x8e,0x75,
+		0xc6,0x6c,0x37,0x5a,0x90,0x25,0x94,0x3e,
+		0x36,0x9c,0xae,0x02,0x38,0x6c,0xf5,0x05,
+	}
+ },
+ { 0xa001173, {
+		0x28,0xbb,0x9b,0xd1,0xa0,0xa0,0x7e,0x3a,
+		0x59,0x20,0xc0,0xa9,0xb2,0x5c,0xc3,0x35,
+		0x53,0x89,0xe1,0x4c,0x93,0x2f,0x1d,0xc3,
+		0xe5,0xf7,0xf3,0xc8,0x9b,0x61,0xaa,0x9e,
+	}
+ },
+ { 0xa0011a8, {
+		0x97,0xc6,0x16,0x65,0x99,0xa4,0x85,0x3b,
+		0xf6,0xce,0xaa,0x49,0x4a,0x3a,0xc5,0xb6,
+		0x78,0x25,0xbc,0x53,0xaf,0x5d,0xcf,0xf4,
+		0x23,0x12,0xbb,0xb1,0xbc,0x8a,0x02,0x2e,
+	}
+ },
+ { 0xa0011ce, {
+		0xcf,0x1c,0x90,0xa3,0x85,0x0a,0xbf,0x71,
+		0x94,0x0e,0x80,0x86,0x85,0x4f,0xd7,0x86,
+		0xae,0x38,0x23,0x28,0x2b,0x35,0x9b,0x4e,
+		0xfe,0xb8,0xcd,0x3d,0x3d,0x39,0xc9,0x6a,
+	}
+ },
+ { 0xa0011d1, {
+		0xdf,0x0e,0xca,0xde,0xf6,0xce,0x5c,0x1e,
+		0x4c,0xec,0xd7,0x71,0x83,0xcc,0xa8,0x09,
+		0xc7,0xc5,0xfe,0xb2,0xf7,0x05,0xd2,0xc5,
+		0x12,0xdd,0xe4,0xf3,0x92,0x1c,0x3d,0xb8,
+	}
+ },
+ { 0xa0011d3, {
+		0x91,0xe6,0x10,0xd7,0x57,0xb0,0x95,0x0b,
+		0x9a,0x24,0xee,0xf7,0xcf,0x56,0xc1,0xa6,
+		0x4a,0x52,0x7d,0x5f,0x9f,0xdf,0xf6,0x00,
+		0x65,0xf7,0xea,0xe8,0x2a,0x88,0xe2,0x26,
+	}
+ },
+ { 0xa0011d5, {
+		0xed,0x69,0x89,0xf4,0xeb,0x64,0xc2,0x13,
+		0xe0,0x51,0x1f,0x03,0x26,0x52,0x7d,0xb7,
+		0x93,0x5d,0x65,0xca,0xb8,0x12,0x1d,0x62,
+		0x0d,0x5b,0x65,0x34,0x69,0xb2,0x62,0x21,
+	}
+ },
+ { 0xa001223, {
+		0xfb,0x32,0x5f,0xc6,0x83,0x4f,0x8c,0xb8,
+		0xa4,0x05,0xf9,0x71,0x53,0x01,0x16,0xc4,
+		0x83,0x75,0x94,0xdd,0xeb,0x7e,0xb7,0x15,
+		0x8e,0x3b,0x50,0x29,0x8a,0x9c,0xcc,0x45,
+	}
+ },
+ { 0xa001224, {
+		0x0e,0x0c,0xdf,0xb4,0x89,0xee,0x35,0x25,
+		0xdd,0x9e,0xdb,0xc0,0x69,0x83,0x0a,0xad,
+		0x26,0xa9,0xaa,0x9d,0xfc,0x3c,0xea,0xf9,
+		0x6c,0xdc,0xd5,0x6d,0x8b,0x6e,0x85,0x4a,
+	}
+ },
+ { 0xa001227, {
+		0xab,0xc6,0x00,0x69,0x4b,0x50,0x87,0xad,
+		0x5f,0x0e,0x8b,0xea,0x57,0x38,0xce,0x1d,
+		0x0f,0x75,0x26,0x02,0xf6,0xd6,0x96,0xe9,
+		0x87,0xb9,0xd6,0x20,0x27,0x7c,0xd2,0xe0,
+	}
+ },
+ { 0xa001229, {
+		0x7f,0x49,0x49,0x48,0x46,0xa5,0x50,0xa6,
+		0x28,0x89,0x98,0xe2,0x9e,0xb4,0x7f,0x75,
+		0x33,0xa7,0x04,0x02,0xe4,0x82,0xbf,0xb4,
+		0xa5,0x3a,0xba,0x24,0x8d,0x31,0x10,0x1d,
+	}
+ },
+ { 0xa00122e, {
+		0x56,0x94,0xa9,0x5d,0x06,0x68,0xfe,0xaf,
+		0xdf,0x7a,0xff,0x2d,0xdf,0x74,0x0f,0x15,
+		0x66,0xfb,0x00,0xb5,0x51,0x97,0x9b,0xfa,
+		0xcb,0x79,0x85,0x46,0x25,0xb4,0xd2,0x10,
+	}
+ },
+ { 0xa001231, {
+		0x0b,0x46,0xa5,0xfc,0x18,0x15,0xa0,0x9e,
+		0xa6,0xdc,0xb7,0xff,0x17,0xf7,0x30,0x64,
+		0xd4,0xda,0x9e,0x1b,0xc3,0xfc,0x02,0x3b,
+		0xe2,0xc6,0x0e,0x41,0x54,0xb5,0x18,0xdd,
+	}
+ },
+ { 0xa001234, {
+		0x88,0x8d,0xed,0xab,0xb5,0xbd,0x4e,0xf7,
+		0x7f,0xd4,0x0e,0x95,0x34,0x91,0xff,0xcc,
+		0xfb,0x2a,0xcd,0xf7,0xd5,0xdb,0x4c,0x9b,
+		0xd6,0x2e,0x73,0x50,0x8f,0x83,0x79,0x1a,
+	}
+ },
+ { 0xa001236, {
+		0x3d,0x30,0x00,0xb9,0x71,0xba,0x87,0x78,
+		0xa8,0x43,0x55,0xc4,0x26,0x59,0xcf,0x9d,
+		0x93,0xce,0x64,0x0e,0x8b,0x72,0x11,0x8b,
+		0xa3,0x8f,0x51,0xe9,0xca,0x98,0xaa,0x25,
+	}
+ },
+ { 0xa001238, {
+		0x72,0xf7,0x4b,0x0c,0x7d,0x58,0x65,0xcc,
+		0x00,0xcc,0x57,0x16,0x68,0x16,0xf8,0x2a,
+		0x1b,0xb3,0x8b,0xe1,0xb6,0x83,0x8c,0x7e,
+		0xc0,0xcd,0x33,0xf2,0x8d,0xf9,0xef,0x59,
+	}
+ },
+ { 0xa00820c, {
+		0xa8,0x0c,0x81,0xc0,0xa6,0x00,0xe7,0xf3,
+		0x5f,0x65,0xd3,0xb9,0x6f,0xea,0x93,0x63,
+		0xf1,0x8c,0x88,0x45,0xd7,0x82,0x80,0xd1,
+		0xe1,0x3b,0x8d,0xb2,0xf8,0x22,0x03,0xe2,
+	}
+ },
+ { 0xa10113e, {
+		0x05,0x3c,0x66,0xd7,0xa9,0x5a,0x33,0x10,
+		0x1b,0xf8,0x9c,0x8f,0xed,0xfc,0xa7,0xa0,
+		0x15,0xe3,0x3f,0x4b,0x1d,0x0d,0x0a,0xd5,
+		0xfa,0x90,0xc4,0xed,0x9d,0x90,0xaf,0x53,
+	}
+ },
+ { 0xa101144, {
+		0xb3,0x0b,0x26,0x9a,0xf8,0x7c,0x02,0x26,
+		0x35,0x84,0x53,0xa4,0xd3,0x2c,0x7c,0x09,
+		0x68,0x7b,0x96,0xb6,0x93,0xef,0xde,0xbc,
+		0xfd,0x4b,0x15,0xd2,0x81,0xd3,0x51,0x47,
+	}
+ },
+ { 0xa101148, {
+		0x20,0xd5,0x6f,0x40,0x4a,0xf6,0x48,0x90,
+		0xc2,0x93,0x9a,0xc2,0xfd,0xac,0xef,0x4f,
+		0xfa,0xc0,0x3d,0x92,0x3c,0x6d,0x01,0x08,
+		0xf1,0x5e,0xb0,0xde,0xb4,0x98,0xae,0xc4,
+	}
+ },
+ { 0xa10123e, {
+		0x03,0xb9,0x2c,0x76,0x48,0x93,0xc9,0x18,
+		0xfb,0x56,0xfd,0xf7,0xe2,0x1d,0xca,0x4d,
+		0x1d,0x13,0x53,0x63,0xfe,0x42,0x6f,0xfc,
+		0x19,0x0f,0xf1,0xfc,0xa7,0xdd,0x89,0x1b,
+	}
+ },
+ { 0xa101244, {
+		0x71,0x56,0xb5,0x9f,0x21,0xbf,0xb3,0x3c,
+		0x8c,0xd7,0x36,0xd0,0x34,0x52,0x1b,0xb1,
+		0x46,0x2f,0x04,0xf0,0x37,0xd8,0x1e,0x72,
+		0x24,0xa2,0x80,0x84,0x83,0x65,0x84,0xc0,
+	}
+ },
+ { 0xa101248, {
+		0xed,0x3b,0x95,0xa6,0x68,0xa7,0x77,0x3e,
+		0xfc,0x17,0x26,0xe2,0x7b,0xd5,0x56,0x22,
+		0x2c,0x1d,0xef,0xeb,0x56,0xdd,0xba,0x6e,
+		0x1b,0x7d,0x64,0x9d,0x4b,0x53,0x13,0x75,
+	}
+ },
+ { 0xa108108, {
+		0xed,0xc2,0xec,0xa1,0x15,0xc6,0x65,0xe9,
+		0xd0,0xef,0x39,0xaa,0x7f,0x55,0x06,0xc6,
+		0xf5,0xd4,0x3f,0x7b,0x14,0xd5,0x60,0x2c,
+		0x28,0x1e,0x9c,0x59,0x69,0x99,0x4d,0x16,
+	}
+ },
+ { 0xa20102d, {
+		0xf9,0x6e,0xf2,0x32,0xd3,0x0f,0x5f,0x11,
+		0x59,0xa1,0xfe,0xcc,0xcd,0x9b,0x42,0x89,
+		0x8b,0x89,0x2f,0xb5,0xbb,0x82,0xef,0x23,
+		0x8c,0xe9,0x19,0x3e,0xcc,0x3f,0x7b,0xb4,
+	}
+ },
+ { 0xa201210, {
+		0xe8,0x6d,0x51,0x6a,0x8e,0x72,0xf3,0xfe,
+		0x6e,0x16,0xbc,0x62,0x59,0x40,0x17,0xe9,
+		0x6d,0x3d,0x0e,0x6b,0xa7,0xac,0xe3,0x68,
+		0xf7,0x55,0xf0,0x13,0xbb,0x22,0xf6,0x41,
+	}
+ },
+ { 0xa404107, {
+		0xbb,0x04,0x4e,0x47,0xdd,0x5e,0x26,0x45,
+		0x1a,0xc9,0x56,0x24,0xa4,0x4c,0x82,0xb0,
+		0x8b,0x0d,0x9f,0xf9,0x3a,0xdf,0xc6,0x81,
+		0x13,0xbc,0xc5,0x25,0xe4,0xc5,0xc3,0x99,
+	}
+ },
+ { 0xa500011, {
+		0x23,0x3d,0x70,0x7d,0x03,0xc3,0xc4,0xf4,
+		0x2b,0x82,0xc6,0x05,0xda,0x80,0x0a,0xf1,
+		0xd7,0x5b,0x65,0x3a,0x7d,0xab,0xdf,0xa2,
+		0x11,0x5e,0x96,0x7e,0x71,0xe9,0xfc,0x74,
+	}
+ },
+ { 0xa601209, {
+		0x66,0x48,0xd4,0x09,0x05,0xcb,0x29,0x32,
+		0x66,0xb7,0x9a,0x76,0xcd,0x11,0xf3,0x30,
+		0x15,0x86,0xcc,0x5d,0x97,0x0f,0xc0,0x46,
+		0xe8,0x73,0xe2,0xd6,0xdb,0xd2,0x77,0x1d,
+	}
+ },
+ { 0xa704107, {
+		0xf3,0xc6,0x58,0x26,0xee,0xac,0x3f,0xd6,
+		0xce,0xa1,0x72,0x47,0x3b,0xba,0x2b,0x93,
+		0x2a,0xad,0x8e,0x6b,0xea,0x9b,0xb7,0xc2,
+		0x64,0x39,0x71,0x8c,0xce,0xe7,0x41,0x39,
+	}
+ },
+ { 0xa705206, {
+		0x8d,0xc0,0x76,0xbd,0x58,0x9f,0x8f,0xa4,
+		0x12,0x9d,0x21,0xfb,0x48,0x21,0xbc,0xe7,
+		0x67,0x6f,0x04,0x18,0xae,0x20,0x87,0x4b,
+		0x03,0x35,0xe9,0xbe,0xfb,0x06,0xdf,0xfc,
+	}
+ },
+ { 0xa708007, {
+		0x6b,0x76,0xcc,0x78,0xc5,0x8a,0xa3,0xe3,
+		0x32,0x2d,0x79,0xe4,0xc3,0x80,0xdb,0xb2,
+		0x07,0xaa,0x3a,0xe0,0x57,0x13,0x72,0x80,
+		0xdf,0x92,0x73,0x84,0x87,0x3c,0x73,0x93,
+	}
+ },
+ { 0xa70c005, {
+		0x88,0x5d,0xfb,0x79,0x64,0xd8,0x46,0x3b,
+		0x4a,0x83,0x8e,0x77,0x7e,0xcf,0xb3,0x0f,
+		0x1f,0x1f,0xf1,0x97,0xeb,0xfe,0x56,0x55,
+		0xee,0x49,0xac,0xe1,0x8b,0x13,0xc5,0x13,
+	}
+ },
+ { 0xaa00116, {
+		0xe8,0x4c,0x2c,0x88,0xa1,0xac,0x24,0x63,
+		0x65,0xe5,0xaa,0x2d,0x16,0xa9,0xc3,0xf5,
+		0xfe,0x1d,0x5e,0x65,0xc7,0xaa,0x92,0x4d,
+		0x91,0xee,0x76,0xbb,0x4c,0x66,0x78,0xc9,
+	}
+ },
+ { 0xaa00212, {
+		0xbd,0x57,0x5d,0x0a,0x0a,0x30,0xc1,0x75,
+		0x95,0x58,0x5e,0x93,0x02,0x28,0x43,0x71,
+		0xed,0x42,0x29,0xc8,0xec,0x34,0x2b,0xb2,
+		0x1a,0x65,0x4b,0xfe,0x07,0x0f,0x34,0xa1,
+	}
+ },
+ { 0xaa00213, {
+		0xed,0x58,0xb7,0x76,0x81,0x7f,0xd9,0x3a,
+		0x1a,0xff,0x8b,0x34,0xb8,0x4a,0x99,0x0f,
+		0x28,0x49,0x6c,0x56,0x2b,0xdc,0xb7,0xed,
+		0x96,0xd5,0x9d,0xc1,0x7a,0xd4,0x51,0x9b,
+	}
+ },
+ { 0xaa00215, {
+		0x55,0xd3,0x28,0xcb,0x87,0xa9,0x32,0xe9,
+		0x4e,0x85,0x4b,0x7c,0x6b,0xd5,0x7c,0xd4,
+		0x1b,0x51,0x71,0x3a,0x0e,0x0b,0xdc,0x9b,
+		0x68,0x2f,0x46,0xee,0xfe,0xc6,0x6d,0xef,
+	}
+ },
+};
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 21776c529fa9..5df621752fef 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -100,14 +100,12 @@ extern bool force_minrev;
 #ifdef CONFIG_CPU_SUP_AMD
 void load_ucode_amd_bsp(struct early_load_data *ed, unsigned int family);
 void load_ucode_amd_ap(unsigned int family);
-int save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
 struct microcode_ops *init_amd_microcode(void);
 void exit_amd_microcode(void);
 #else /* CONFIG_CPU_SUP_AMD */
 static inline void load_ucode_amd_bsp(struct early_load_data *ed, unsigned int family) { }
 static inline void load_ucode_amd_ap(unsigned int family) { }
-static inline int save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) { }
 static inline struct microcode_ops *init_amd_microcode(void) { return NULL; }
 static inline void exit_amd_microcode(void) { }
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 767bcbce74fa..c11db5be2532 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -427,13 +427,14 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 		}
 	}
 	hlist_add_head_rcu(&zwplug->node, &disk->zone_wplugs_hash[idx]);
+	atomic_inc(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
 
 	return true;
 }
 
-static struct blk_zone_wplug *disk_get_zone_wplug(struct gendisk *disk,
-						  sector_t sector)
+static struct blk_zone_wplug *disk_get_hashed_zone_wplug(struct gendisk *disk,
+							 sector_t sector)
 {
 	unsigned int zno = disk_zone_no(disk, sector);
 	unsigned int idx = hash_32(zno, disk->zone_wplugs_hash_bits);
@@ -454,6 +455,15 @@ static struct blk_zone_wplug *disk_get_zone_wplug(struct gendisk *disk,
 	return NULL;
 }
 
+static inline struct blk_zone_wplug *disk_get_zone_wplug(struct gendisk *disk,
+							 sector_t sector)
+{
+	if (!atomic_read(&disk->nr_zone_wplugs))
+		return NULL;
+
+	return disk_get_hashed_zone_wplug(disk, sector);
+}
+
 static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
 {
 	struct blk_zone_wplug *zwplug =
@@ -518,6 +528,7 @@ static void disk_remove_zone_wplug(struct gendisk *disk,
 	zwplug->flags |= BLK_ZONE_WPLUG_UNHASHED;
 	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
 	hlist_del_init_rcu(&zwplug->node);
+	atomic_dec(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
 	disk_put_zone_wplug(zwplug);
 }
@@ -607,6 +618,11 @@ static void disk_zone_wplug_abort(struct blk_zone_wplug *zwplug)
 {
 	struct bio *bio;
 
+	if (bio_list_empty(&zwplug->bio_list))
+		return;
+
+	pr_warn_ratelimited("%s: zone %u: Aborting plugged BIOs\n",
+			    zwplug->disk->disk_name, zwplug->zone_no);
 	while ((bio = bio_list_pop(&zwplug->bio_list)))
 		blk_zone_wplug_bio_io_error(zwplug, bio);
 }
@@ -1055,6 +1071,47 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	return true;
 }
 
+static void blk_zone_wplug_handle_native_zone_append(struct bio *bio)
+{
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	struct blk_zone_wplug *zwplug;
+	unsigned long flags;
+
+	/*
+	 * We have native support for zone append operations, so we are not
+	 * going to handle @bio through plugging. However, we may already have a
+	 * zone write plug for the target zone if that zone was previously
+	 * partially written using regular writes. In such case, we risk leaving
+	 * the plug in the disk hash table if the zone is fully written using
+	 * zone append operations. Avoid this by removing the zone write plug.
+	 */
+	zwplug = disk_get_zone_wplug(disk, bio->bi_iter.bi_sector);
+	if (likely(!zwplug))
+		return;
+
+	spin_lock_irqsave(&zwplug->lock, flags);
+
+	/*
+	 * We are about to remove the zone write plug. But if the user
+	 * (mistakenly) has issued regular writes together with native zone
+	 * append, we must aborts the writes as otherwise the plugged BIOs would
+	 * not be executed by the plug BIO work as disk_get_zone_wplug() will
+	 * return NULL after the plug is removed. Aborting the plugged write
+	 * BIOs is consistent with the fact that these writes will most likely
+	 * fail anyway as there is no ordering guarantees between zone append
+	 * operations and regular write operations.
+	 */
+	if (!bio_list_empty(&zwplug->bio_list)) {
+		pr_warn_ratelimited("%s: zone %u: Invalid mix of zone append and regular writes\n",
+				    disk->disk_name, zwplug->zone_no);
+		disk_zone_wplug_abort(zwplug);
+	}
+	disk_remove_zone_wplug(disk, zwplug);
+	spin_unlock_irqrestore(&zwplug->lock, flags);
+
+	disk_put_zone_wplug(zwplug);
+}
+
 /**
  * blk_zone_plug_bio - Handle a zone write BIO with zone write plugging
  * @bio: The BIO being submitted
@@ -1111,8 +1168,10 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
 	 */
 	switch (bio_op(bio)) {
 	case REQ_OP_ZONE_APPEND:
-		if (!bdev_emulates_zone_append(bdev))
+		if (!bdev_emulates_zone_append(bdev)) {
+			blk_zone_wplug_handle_native_zone_append(bio);
 			return false;
+		}
 		fallthrough;
 	case REQ_OP_WRITE:
 	case REQ_OP_WRITE_ZEROES:
@@ -1299,6 +1358,7 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 {
 	unsigned int i;
 
+	atomic_set(&disk->nr_zone_wplugs, 0);
 	disk->zone_wplugs_hash_bits =
 		min(ilog2(pool_size) + 1, BLK_ZONE_WPLUG_MAX_HASH_BITS);
 
@@ -1353,6 +1413,7 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 		}
 	}
 
+	WARN_ON_ONCE(atomic_read(&disk->nr_zone_wplugs));
 	kfree(disk->zone_wplugs_hash);
 	disk->zone_wplugs_hash = NULL;
 	disk->zone_wplugs_hash_bits = 0;
@@ -1570,11 +1631,12 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	}
 
 	/*
-	 * We need to track the write pointer of all zones that are not
-	 * empty nor full. So make sure we have a zone write plug for
-	 * such zone if the device has a zone write plug hash table.
+	 * If the device needs zone append emulation, we need to track the
+	 * write pointer of all zones that are not empty nor full. So make sure
+	 * we have a zone write plug for such zone if the device has a zone
+	 * write plug hash table.
 	 */
-	if (!disk->zone_wplugs_hash)
+	if (!queue_emulates_zone_append(disk->queue) || !disk->zone_wplugs_hash)
 		return 0;
 
 	disk_zone_wplug_sync_wp_offset(disk, zone);
diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 419220fa42fd..bd1ea99c3b47 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1609,8 +1609,8 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 				goto out_fw;
 			}
 
-			ret = regmap_raw_write_async(regmap, reg, buf->buf,
-						     le32_to_cpu(region->len));
+			ret = regmap_raw_write(regmap, reg, buf->buf,
+					       le32_to_cpu(region->len));
 			if (ret != 0) {
 				cs_dsp_err(dsp,
 					   "%s.%d: Failed to write %d bytes at %d in %s: %d\n",
@@ -1625,12 +1625,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 		regions++;
 	}
 
-	ret = regmap_async_complete(regmap);
-	if (ret != 0) {
-		cs_dsp_err(dsp, "Failed to complete async write: %d\n", ret);
-		goto out_fw;
-	}
-
 	if (pos > firmware->size)
 		cs_dsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
 			    file, regions, pos - firmware->size);
@@ -1638,7 +1632,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 	cs_dsp_debugfs_save_wmfwname(dsp, file);
 
 out_fw:
-	regmap_async_complete(regmap);
 	cs_dsp_buf_free(&buf_list);
 
 	if (ret == -EOVERFLOW)
@@ -2326,8 +2319,8 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 			cs_dsp_dbg(dsp, "%s.%d: Writing %d bytes at %x\n",
 				   file, blocks, le32_to_cpu(blk->len),
 				   reg);
-			ret = regmap_raw_write_async(regmap, reg, buf->buf,
-						     le32_to_cpu(blk->len));
+			ret = regmap_raw_write(regmap, reg, buf->buf,
+					       le32_to_cpu(blk->len));
 			if (ret != 0) {
 				cs_dsp_err(dsp,
 					   "%s.%d: Failed to write to %x in %s: %d\n",
@@ -2339,10 +2332,6 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 		blocks++;
 	}
 
-	ret = regmap_async_complete(regmap);
-	if (ret != 0)
-		cs_dsp_err(dsp, "Failed to complete async write: %d\n", ret);
-
 	if (pos > firmware->size)
 		cs_dsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
 			    file, blocks, pos - firmware->size);
@@ -2350,7 +2339,6 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 	cs_dsp_debugfs_save_binname(dsp, file);
 
 out_fw:
-	regmap_async_complete(regmap);
 	cs_dsp_buf_free(&buf_list);
 
 	if (ret == -EOVERFLOW)
@@ -2561,8 +2549,8 @@ static int cs_dsp_adsp2_enable_core(struct cs_dsp *dsp)
 {
 	int ret;
 
-	ret = regmap_update_bits_async(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				       ADSP2_SYS_ENA, ADSP2_SYS_ENA);
+	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				 ADSP2_SYS_ENA, ADSP2_SYS_ENA);
 	if (ret != 0)
 		return ret;
 
diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 5ed0602c2f75..4eb0dff4dfaf 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -103,9 +103,7 @@ void __init efi_mokvar_table_init(void)
 	void *va = NULL;
 	unsigned long cur_offset = 0;
 	unsigned long offset_limit;
-	unsigned long map_size = 0;
 	unsigned long map_size_needed = 0;
-	unsigned long size;
 	struct efi_mokvar_table_entry *mokvar_entry;
 	int err;
 
@@ -134,48 +132,34 @@ void __init efi_mokvar_table_init(void)
 	 */
 	err = -EINVAL;
 	while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
-		mokvar_entry = va + cur_offset;
-		map_size_needed = cur_offset + sizeof(*mokvar_entry);
-		if (map_size_needed > map_size) {
-			if (va)
-				early_memunmap(va, map_size);
-			/*
-			 * Map a little more than the fixed size entry
-			 * header, anticipating some data. It's safe to
-			 * do so as long as we stay within current memory
-			 * descriptor.
-			 */
-			map_size = min(map_size_needed + 2*EFI_PAGE_SIZE,
-				       offset_limit);
-			va = early_memremap(efi.mokvar_table, map_size);
-			if (!va) {
-				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%lu.\n",
-				       efi.mokvar_table, map_size);
-				return;
-			}
-			mokvar_entry = va + cur_offset;
+		if (va)
+			early_memunmap(va, sizeof(*mokvar_entry));
+		va = early_memremap(efi.mokvar_table + cur_offset, sizeof(*mokvar_entry));
+		if (!va) {
+			pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%zu.\n",
+			       efi.mokvar_table + cur_offset, sizeof(*mokvar_entry));
+			return;
 		}
+		mokvar_entry = va;
 
 		/* Check for last sentinel entry */
 		if (mokvar_entry->name[0] == '\0') {
 			if (mokvar_entry->data_size != 0)
 				break;
 			err = 0;
+			map_size_needed = cur_offset + sizeof(*mokvar_entry);
 			break;
 		}
 
-		/* Sanity check that the name is null terminated */
-		size = strnlen(mokvar_entry->name,
-			       sizeof(mokvar_entry->name));
-		if (size >= sizeof(mokvar_entry->name))
-			break;
+		/* Enforce that the name is NUL terminated */
+		mokvar_entry->name[sizeof(mokvar_entry->name) - 1] = '\0';
 
 		/* Advance to the next entry */
-		cur_offset = map_size_needed + mokvar_entry->data_size;
+		cur_offset += sizeof(*mokvar_entry) + mokvar_entry->data_size;
 	}
 
 	if (va)
-		early_memunmap(va, map_size);
+		early_memunmap(va, sizeof(*mokvar_entry));
 	if (err) {
 		pr_err("EFI MOKvar config table is not valid\n");
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 45e28726e148..96845541b2d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1542,6 +1542,13 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	/* resizing on Dell G5 SE platforms causes problems with runtime pm */
+	if ((amdgpu_runtime_pm != 0) &&
+	    adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    adev->pdev->device == 0x731f &&
+	    adev->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL)
+		return 0;
+
 	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
 	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
 		DRM_WARN("System can't access extended configuration space, please check!!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 425073d99491..1c8ac4cf08c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2280,7 +2280,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	struct amdgpu_res_cursor cursor;
 	u64 addr;
-	int r;
+	int r = 0;
 
 	if (!adev->mman.buffer_funcs_enabled)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 2eff37aaf827..1695dd78ede8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -107,6 +107,8 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
 			0x53 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
 
+	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
 
 	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
@@ -167,10 +169,10 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
-	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
+
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 68dbc0399c87..3c0ae28c5923 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -154,6 +154,8 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
 			0x55 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
 
+	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
 
 	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
@@ -221,10 +223,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
-	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 2b72d5b4949b..565858b9044d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -121,6 +121,8 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
 			0x55 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
 
+	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
 
 	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
@@ -184,10 +186,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
-	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 84e8ea3a8a0c..217af36dc097 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -182,6 +182,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
 			0x53 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
 
+	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
+
 	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
 
 	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
@@ -244,7 +247,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m = get_mqd(mqd);
 
-	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
 	m->cp_hqd_pq_control |= order_base_2(q->queue_size / 4) - 1;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 85e58e0f6059..5df26f8937cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1593,75 +1593,130 @@ static bool dm_should_disable_stutter(struct pci_dev *pdev)
 	return false;
 }
 
-static const struct dmi_system_id hpd_disconnect_quirk_table[] = {
+struct amdgpu_dm_quirks {
+	bool aux_hpd_discon;
+	bool support_edp0_on_dp1;
+};
+
+static struct amdgpu_dm_quirks quirk_entries = {
+	.aux_hpd_discon = false,
+	.support_edp0_on_dp1 = false
+};
+
+static int edp0_on_dp1_callback(const struct dmi_system_id *id)
+{
+	quirk_entries.support_edp0_on_dp1 = true;
+	return 0;
+}
+
+static int aux_hpd_discon_callback(const struct dmi_system_id *id)
+{
+	quirk_entries.aux_hpd_discon = true;
+	return 0;
+}
+
+static const struct dmi_system_id dmi_quirk_table[] = {
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3660"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3260"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3460"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower Plus 7010"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower 7010"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF Plus 7010"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF 7010"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Micro Plus 7010"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Micro 7010"),
 		},
 	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite mt645 G8 Mobile Thin Client"),
+		},
+	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 665 16 inch G11 Notebook PC"),
+		},
+	},
 	{}
 	/* TODO: refactor this from a fixed table to a dynamic option */
 };
 
-static void retrieve_dmi_info(struct amdgpu_display_manager *dm)
+static void retrieve_dmi_info(struct amdgpu_display_manager *dm, struct dc_init_data *init_data)
 {
-	const struct dmi_system_id *dmi_id;
+	int dmi_id;
+	struct drm_device *dev = dm->ddev;
 
 	dm->aux_hpd_discon_quirk = false;
+	init_data->flags.support_edp0_on_dp1 = false;
+
+	dmi_id = dmi_check_system(dmi_quirk_table);
 
-	dmi_id = dmi_first_match(hpd_disconnect_quirk_table);
-	if (dmi_id) {
+	if (!dmi_id)
+		return;
+
+	if (quirk_entries.aux_hpd_discon) {
 		dm->aux_hpd_discon_quirk = true;
-		DRM_INFO("aux_hpd_discon_quirk attached\n");
+		drm_info(dev, "aux_hpd_discon_quirk attached\n");
+	}
+	if (quirk_entries.support_edp0_on_dp1) {
+		init_data->flags.support_edp0_on_dp1 = true;
+		drm_info(dev, "aux_hpd_discon_quirk attached\n");
 	}
 }
 
@@ -1969,7 +2024,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
 
-	retrieve_dmi_info(&adev->dm);
+	retrieve_dmi_info(&adev->dm, &init_data);
 
 	if (adev->dm.bb_from_dmub)
 		init_data.bb_from_dmub = adev->dm.bb_from_dmub;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 3390f0d8420a..c4a7fd453e5f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -894,6 +894,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	int i;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -920,6 +921,12 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	/* Update reference counts for HPDs */
+	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
+		if (amdgpu_irq_get(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
+			drm_err(dev, "DM_IRQ: Failed get HPD for source=%d)!\n", i);
+	}
 }
 
 /**
@@ -935,6 +942,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	int i;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -960,4 +968,10 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	/* Update reference counts for HPDs */
+	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
+		if (amdgpu_irq_put(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
+			drm_err(dev, "DM_IRQ: Failed put HPD for source=%d!\n", i);
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 45858bf1523d..e140b7a04d72 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -54,7 +54,8 @@ static bool link_supports_psrsu(struct dc_link *link)
 	if (amdgpu_dc_debug_mask & DC_DISABLE_PSR_SU)
 		return false;
 
-	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
+	/* Temporarily disable PSR-SU to avoid glitches */
+	return false;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index e8b6989a40f3..6b34a33d788f 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3043,6 +3043,7 @@ static int kv_dpm_hw_init(void *handle)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	kv_dpm_setup_asic(adev);
 	ret = kv_dpm_enable(adev);
 	if (ret)
@@ -3050,6 +3051,8 @@ static int kv_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
+
 	return ret;
 }
 
@@ -3067,32 +3070,42 @@ static int kv_dpm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_work_sync(&adev->pm.dpm.thermal.work);
+
 	if (adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
+		adev->pm.dpm_enabled = false;
 		/* disable dpm */
 		kv_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+		mutex_unlock(&adev->pm.mutex);
 	}
 	return 0;
 }
 
 static int kv_dpm_resume(void *handle)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
+	if (!amdgpu_dpm)
+		return 0;
+
+	if (!adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
 		/* asic init will reset to the boot state */
 		kv_dpm_setup_asic(adev);
 		ret = kv_dpm_enable(adev);
-		if (ret)
+		if (ret) {
 			adev->pm.dpm_enabled = false;
-		else
+		} else {
 			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
+		}
+		mutex_unlock(&adev->pm.mutex);
 	}
-	return 0;
+	return ret;
 }
 
 static bool kv_dpm_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index e861355ebd75..c7518b13e787 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -1009,9 +1009,12 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
 	int temp, size = sizeof(temp);
 
-	if (!adev->pm.dpm_enabled)
-		return;
+	mutex_lock(&adev->pm.mutex);
 
+	if (!adev->pm.dpm_enabled) {
+		mutex_unlock(&adev->pm.mutex);
+		return;
+	}
 	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
 				   AMDGPU_PP_SENSOR_GPU_TEMP,
 				   (void *)&temp,
@@ -1033,4 +1036,5 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	adev->pm.dpm.state = dpm_state;
 
 	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index a1baa13ab2c2..a5ad1b60597e 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7783,6 +7783,7 @@ static int si_dpm_hw_init(void *handle)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	si_dpm_setup_asic(adev);
 	ret = si_dpm_enable(adev);
 	if (ret)
@@ -7790,6 +7791,7 @@ static int si_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
 	return ret;
 }
 
@@ -7807,32 +7809,44 @@ static int si_dpm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_work_sync(&adev->pm.dpm.thermal.work);
+
 	if (adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
+		adev->pm.dpm_enabled = false;
 		/* disable dpm */
 		si_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+		mutex_unlock(&adev->pm.mutex);
 	}
+
 	return 0;
 }
 
 static int si_dpm_resume(void *handle)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
+	if (!amdgpu_dpm)
+		return 0;
+
+	if (!adev->pm.dpm_enabled) {
 		/* asic init will reset to the boot state */
+		mutex_lock(&adev->pm.mutex);
 		si_dpm_setup_asic(adev);
 		ret = si_dpm_enable(adev);
-		if (ret)
+		if (ret) {
 			adev->pm.dpm_enabled = false;
-		else
+		} else {
 			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
+		}
+		mutex_unlock(&adev->pm.mutex);
 	}
-	return 0;
+
+	return ret;
 }
 
 static bool si_dpm_is_idle(void *handle)
diff --git a/drivers/gpu/drm/xe/regs/xe_engine_regs.h b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
index 7c78496e6213..192e571348f6 100644
--- a/drivers/gpu/drm/xe/regs/xe_engine_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
@@ -53,7 +53,6 @@
 
 #define RING_CTL(base)				XE_REG((base) + 0x3c)
 #define   RING_CTL_SIZE(size)			((size) - PAGE_SIZE) /* in bytes -> pages */
-#define   RING_CTL_SIZE(size)			((size) - PAGE_SIZE) /* in bytes -> pages */
 
 #define RING_START_UDW(base)			XE_REG((base) + 0x48)
 
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index e6744422dee4..448766033690 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -47,6 +47,11 @@ enum xe_oa_submit_deps {
 	XE_OA_SUBMIT_ADD_DEPS,
 };
 
+enum xe_oa_user_extn_from {
+	XE_OA_USER_EXTN_FROM_OPEN,
+	XE_OA_USER_EXTN_FROM_CONFIG,
+};
+
 struct xe_oa_reg {
 	struct xe_reg addr;
 	u32 value;
@@ -94,6 +99,17 @@ struct xe_oa_config_bo {
 	struct xe_bb *bb;
 };
 
+struct xe_oa_fence {
+	/* @base: dma fence base */
+	struct dma_fence base;
+	/* @lock: lock for the fence */
+	spinlock_t lock;
+	/* @work: work to signal @base */
+	struct delayed_work work;
+	/* @cb: callback to schedule @work */
+	struct dma_fence_cb cb;
+};
+
 #define DRM_FMT(x) DRM_XE_OA_FMT_TYPE_##x
 
 static const struct xe_oa_format oa_formats[] = {
@@ -166,10 +182,10 @@ static struct xe_oa_config *xe_oa_get_oa_config(struct xe_oa *oa, int metrics_se
 	return oa_config;
 }
 
-static void free_oa_config_bo(struct xe_oa_config_bo *oa_bo)
+static void free_oa_config_bo(struct xe_oa_config_bo *oa_bo, struct dma_fence *last_fence)
 {
 	xe_oa_config_put(oa_bo->oa_config);
-	xe_bb_free(oa_bo->bb, NULL);
+	xe_bb_free(oa_bo->bb, last_fence);
 	kfree(oa_bo);
 }
 
@@ -668,7 +684,8 @@ static void xe_oa_free_configs(struct xe_oa_stream *stream)
 
 	xe_oa_config_put(stream->oa_config);
 	llist_for_each_entry_safe(oa_bo, tmp, stream->oa_config_bos.first, node)
-		free_oa_config_bo(oa_bo);
+		free_oa_config_bo(oa_bo, stream->last_fence);
+	dma_fence_put(stream->last_fence);
 }
 
 static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *reg_lri, u32 count)
@@ -832,6 +849,7 @@ static void xe_oa_stream_destroy(struct xe_oa_stream *stream)
 		xe_gt_WARN_ON(gt, xe_guc_pc_unset_gucrc_mode(&gt->uc.guc.pc));
 
 	xe_oa_free_configs(stream);
+	xe_file_put(stream->xef);
 }
 
 static int xe_oa_alloc_oa_buffer(struct xe_oa_stream *stream)
@@ -902,40 +920,113 @@ xe_oa_alloc_config_buffer(struct xe_oa_stream *stream, struct xe_oa_config *oa_c
 	return oa_bo;
 }
 
+static void xe_oa_update_last_fence(struct xe_oa_stream *stream, struct dma_fence *fence)
+{
+	dma_fence_put(stream->last_fence);
+	stream->last_fence = dma_fence_get(fence);
+}
+
+static void xe_oa_fence_work_fn(struct work_struct *w)
+{
+	struct xe_oa_fence *ofence = container_of(w, typeof(*ofence), work.work);
+
+	/* Signal fence to indicate new OA configuration is active */
+	dma_fence_signal(&ofence->base);
+	dma_fence_put(&ofence->base);
+}
+
+static void xe_oa_config_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
+{
+	/* Additional empirical delay needed for NOA programming after registers are written */
+#define NOA_PROGRAM_ADDITIONAL_DELAY_US 500
+
+	struct xe_oa_fence *ofence = container_of(cb, typeof(*ofence), cb);
+
+	INIT_DELAYED_WORK(&ofence->work, xe_oa_fence_work_fn);
+	queue_delayed_work(system_unbound_wq, &ofence->work,
+			   usecs_to_jiffies(NOA_PROGRAM_ADDITIONAL_DELAY_US));
+	dma_fence_put(fence);
+}
+
+static const char *xe_oa_get_driver_name(struct dma_fence *fence)
+{
+	return "xe_oa";
+}
+
+static const char *xe_oa_get_timeline_name(struct dma_fence *fence)
+{
+	return "unbound";
+}
+
+static const struct dma_fence_ops xe_oa_fence_ops = {
+	.get_driver_name = xe_oa_get_driver_name,
+	.get_timeline_name = xe_oa_get_timeline_name,
+};
+
 static int xe_oa_emit_oa_config(struct xe_oa_stream *stream, struct xe_oa_config *config)
 {
 #define NOA_PROGRAM_ADDITIONAL_DELAY_US 500
 	struct xe_oa_config_bo *oa_bo;
-	int err = 0, us = NOA_PROGRAM_ADDITIONAL_DELAY_US;
+	struct xe_oa_fence *ofence;
+	int i, err, num_signal = 0;
 	struct dma_fence *fence;
-	long timeout;
 
-	/* Emit OA configuration batch */
+	ofence = kzalloc(sizeof(*ofence), GFP_KERNEL);
+	if (!ofence) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
 	oa_bo = xe_oa_alloc_config_buffer(stream, config);
 	if (IS_ERR(oa_bo)) {
 		err = PTR_ERR(oa_bo);
 		goto exit;
 	}
 
+	/* Emit OA configuration batch */
 	fence = xe_oa_submit_bb(stream, XE_OA_SUBMIT_ADD_DEPS, oa_bo->bb);
 	if (IS_ERR(fence)) {
 		err = PTR_ERR(fence);
 		goto exit;
 	}
 
-	/* Wait till all previous batches have executed */
-	timeout = dma_fence_wait_timeout(fence, false, 5 * HZ);
-	dma_fence_put(fence);
-	if (timeout < 0)
-		err = timeout;
-	else if (!timeout)
-		err = -ETIME;
-	if (err)
-		drm_dbg(&stream->oa->xe->drm, "dma_fence_wait_timeout err %d\n", err);
+	/* Point of no return: initialize and set fence to signal */
+	spin_lock_init(&ofence->lock);
+	dma_fence_init(&ofence->base, &xe_oa_fence_ops, &ofence->lock, 0, 0);
 
-	/* Additional empirical delay needed for NOA programming after registers are written */
-	usleep_range(us, 2 * us);
+	for (i = 0; i < stream->num_syncs; i++) {
+		if (stream->syncs[i].flags & DRM_XE_SYNC_FLAG_SIGNAL)
+			num_signal++;
+		xe_sync_entry_signal(&stream->syncs[i], &ofence->base);
+	}
+
+	/* Additional dma_fence_get in case we dma_fence_wait */
+	if (!num_signal)
+		dma_fence_get(&ofence->base);
+
+	/* Update last fence too before adding callback */
+	xe_oa_update_last_fence(stream, fence);
+
+	/* Add job fence callback to schedule work to signal ofence->base */
+	err = dma_fence_add_callback(fence, &ofence->cb, xe_oa_config_cb);
+	xe_gt_assert(stream->gt, !err || err == -ENOENT);
+	if (err == -ENOENT)
+		xe_oa_config_cb(fence, &ofence->cb);
+
+	/* If nothing needs to be signaled we wait synchronously */
+	if (!num_signal) {
+		dma_fence_wait(&ofence->base, false);
+		dma_fence_put(&ofence->base);
+	}
+
+	/* Done with syncs */
+	for (i = 0; i < stream->num_syncs; i++)
+		xe_sync_entry_cleanup(&stream->syncs[i]);
+	kfree(stream->syncs);
+
+	return 0;
 exit:
+	kfree(ofence);
 	return err;
 }
 
@@ -1006,6 +1097,262 @@ static int xe_oa_enable_metric_set(struct xe_oa_stream *stream)
 	return xe_oa_emit_oa_config(stream, stream->oa_config);
 }
 
+static int decode_oa_format(struct xe_oa *oa, u64 fmt, enum xe_oa_format_name *name)
+{
+	u32 counter_size = FIELD_GET(DRM_XE_OA_FORMAT_MASK_COUNTER_SIZE, fmt);
+	u32 counter_sel = FIELD_GET(DRM_XE_OA_FORMAT_MASK_COUNTER_SEL, fmt);
+	u32 bc_report = FIELD_GET(DRM_XE_OA_FORMAT_MASK_BC_REPORT, fmt);
+	u32 type = FIELD_GET(DRM_XE_OA_FORMAT_MASK_FMT_TYPE, fmt);
+	int idx;
+
+	for_each_set_bit(idx, oa->format_mask, __XE_OA_FORMAT_MAX) {
+		const struct xe_oa_format *f = &oa->oa_formats[idx];
+
+		if (counter_size == f->counter_size && bc_report == f->bc_report &&
+		    type == f->type && counter_sel == f->counter_select) {
+			*name = idx;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int xe_oa_set_prop_oa_unit_id(struct xe_oa *oa, u64 value,
+				     struct xe_oa_open_param *param)
+{
+	if (value >= oa->oa_unit_ids) {
+		drm_dbg(&oa->xe->drm, "OA unit ID out of range %lld\n", value);
+		return -EINVAL;
+	}
+	param->oa_unit_id = value;
+	return 0;
+}
+
+static int xe_oa_set_prop_sample_oa(struct xe_oa *oa, u64 value,
+				    struct xe_oa_open_param *param)
+{
+	param->sample = value;
+	return 0;
+}
+
+static int xe_oa_set_prop_metric_set(struct xe_oa *oa, u64 value,
+				     struct xe_oa_open_param *param)
+{
+	param->metric_set = value;
+	return 0;
+}
+
+static int xe_oa_set_prop_oa_format(struct xe_oa *oa, u64 value,
+				    struct xe_oa_open_param *param)
+{
+	int ret = decode_oa_format(oa, value, &param->oa_format);
+
+	if (ret) {
+		drm_dbg(&oa->xe->drm, "Unsupported OA report format %#llx\n", value);
+		return ret;
+	}
+	return 0;
+}
+
+static int xe_oa_set_prop_oa_exponent(struct xe_oa *oa, u64 value,
+				      struct xe_oa_open_param *param)
+{
+#define OA_EXPONENT_MAX 31
+
+	if (value > OA_EXPONENT_MAX) {
+		drm_dbg(&oa->xe->drm, "OA timer exponent too high (> %u)\n", OA_EXPONENT_MAX);
+		return -EINVAL;
+	}
+	param->period_exponent = value;
+	return 0;
+}
+
+static int xe_oa_set_prop_disabled(struct xe_oa *oa, u64 value,
+				   struct xe_oa_open_param *param)
+{
+	param->disabled = value;
+	return 0;
+}
+
+static int xe_oa_set_prop_exec_queue_id(struct xe_oa *oa, u64 value,
+					struct xe_oa_open_param *param)
+{
+	param->exec_queue_id = value;
+	return 0;
+}
+
+static int xe_oa_set_prop_engine_instance(struct xe_oa *oa, u64 value,
+					  struct xe_oa_open_param *param)
+{
+	param->engine_instance = value;
+	return 0;
+}
+
+static int xe_oa_set_no_preempt(struct xe_oa *oa, u64 value,
+				struct xe_oa_open_param *param)
+{
+	param->no_preempt = value;
+	return 0;
+}
+
+static int xe_oa_set_prop_num_syncs(struct xe_oa *oa, u64 value,
+				    struct xe_oa_open_param *param)
+{
+	param->num_syncs = value;
+	return 0;
+}
+
+static int xe_oa_set_prop_syncs_user(struct xe_oa *oa, u64 value,
+				     struct xe_oa_open_param *param)
+{
+	param->syncs_user = u64_to_user_ptr(value);
+	return 0;
+}
+
+static int xe_oa_set_prop_ret_inval(struct xe_oa *oa, u64 value,
+				    struct xe_oa_open_param *param)
+{
+	return -EINVAL;
+}
+
+typedef int (*xe_oa_set_property_fn)(struct xe_oa *oa, u64 value,
+				     struct xe_oa_open_param *param);
+static const xe_oa_set_property_fn xe_oa_set_property_funcs_open[] = {
+	[DRM_XE_OA_PROPERTY_OA_UNIT_ID] = xe_oa_set_prop_oa_unit_id,
+	[DRM_XE_OA_PROPERTY_SAMPLE_OA] = xe_oa_set_prop_sample_oa,
+	[DRM_XE_OA_PROPERTY_OA_METRIC_SET] = xe_oa_set_prop_metric_set,
+	[DRM_XE_OA_PROPERTY_OA_FORMAT] = xe_oa_set_prop_oa_format,
+	[DRM_XE_OA_PROPERTY_OA_PERIOD_EXPONENT] = xe_oa_set_prop_oa_exponent,
+	[DRM_XE_OA_PROPERTY_OA_DISABLED] = xe_oa_set_prop_disabled,
+	[DRM_XE_OA_PROPERTY_EXEC_QUEUE_ID] = xe_oa_set_prop_exec_queue_id,
+	[DRM_XE_OA_PROPERTY_OA_ENGINE_INSTANCE] = xe_oa_set_prop_engine_instance,
+	[DRM_XE_OA_PROPERTY_NO_PREEMPT] = xe_oa_set_no_preempt,
+	[DRM_XE_OA_PROPERTY_NUM_SYNCS] = xe_oa_set_prop_num_syncs,
+	[DRM_XE_OA_PROPERTY_SYNCS] = xe_oa_set_prop_syncs_user,
+};
+
+static const xe_oa_set_property_fn xe_oa_set_property_funcs_config[] = {
+	[DRM_XE_OA_PROPERTY_OA_UNIT_ID] = xe_oa_set_prop_ret_inval,
+	[DRM_XE_OA_PROPERTY_SAMPLE_OA] = xe_oa_set_prop_ret_inval,
+	[DRM_XE_OA_PROPERTY_OA_METRIC_SET] = xe_oa_set_prop_metric_set,
+	[DRM_XE_OA_PROPERTY_OA_FORMAT] = xe_oa_set_prop_ret_inval,
+	[DRM_XE_OA_PROPERTY_OA_PERIOD_EXPONENT] = xe_oa_set_prop_ret_inval,
+	[DRM_XE_OA_PROPERTY_OA_DISABLED] = xe_oa_set_prop_ret_inval,
+	[DRM_XE_OA_PROPERTY_EXEC_QUEUE_ID] = xe_oa_set_prop_ret_inval,
+	[DRM_XE_OA_PROPERTY_OA_ENGINE_INSTANCE] = xe_oa_set_prop_ret_inval,
+	[DRM_XE_OA_PROPERTY_NO_PREEMPT] = xe_oa_set_prop_ret_inval,
+	[DRM_XE_OA_PROPERTY_NUM_SYNCS] = xe_oa_set_prop_num_syncs,
+	[DRM_XE_OA_PROPERTY_SYNCS] = xe_oa_set_prop_syncs_user,
+};
+
+static int xe_oa_user_ext_set_property(struct xe_oa *oa, enum xe_oa_user_extn_from from,
+				       u64 extension, struct xe_oa_open_param *param)
+{
+	u64 __user *address = u64_to_user_ptr(extension);
+	struct drm_xe_ext_set_property ext;
+	int err;
+	u32 idx;
+
+	err = __copy_from_user(&ext, address, sizeof(ext));
+	if (XE_IOCTL_DBG(oa->xe, err))
+		return -EFAULT;
+
+	BUILD_BUG_ON(ARRAY_SIZE(xe_oa_set_property_funcs_open) !=
+		     ARRAY_SIZE(xe_oa_set_property_funcs_config));
+
+	if (XE_IOCTL_DBG(oa->xe, ext.property >= ARRAY_SIZE(xe_oa_set_property_funcs_open)) ||
+	    XE_IOCTL_DBG(oa->xe, ext.pad))
+		return -EINVAL;
+
+	idx = array_index_nospec(ext.property, ARRAY_SIZE(xe_oa_set_property_funcs_open));
+
+	if (from == XE_OA_USER_EXTN_FROM_CONFIG)
+		return xe_oa_set_property_funcs_config[idx](oa, ext.value, param);
+	else
+		return xe_oa_set_property_funcs_open[idx](oa, ext.value, param);
+}
+
+typedef int (*xe_oa_user_extension_fn)(struct xe_oa *oa,  enum xe_oa_user_extn_from from,
+				       u64 extension, struct xe_oa_open_param *param);
+static const xe_oa_user_extension_fn xe_oa_user_extension_funcs[] = {
+	[DRM_XE_OA_EXTENSION_SET_PROPERTY] = xe_oa_user_ext_set_property,
+};
+
+#define MAX_USER_EXTENSIONS	16
+static int xe_oa_user_extensions(struct xe_oa *oa, enum xe_oa_user_extn_from from, u64 extension,
+				 int ext_number, struct xe_oa_open_param *param)
+{
+	u64 __user *address = u64_to_user_ptr(extension);
+	struct drm_xe_user_extension ext;
+	int err;
+	u32 idx;
+
+	if (XE_IOCTL_DBG(oa->xe, ext_number >= MAX_USER_EXTENSIONS))
+		return -E2BIG;
+
+	err = __copy_from_user(&ext, address, sizeof(ext));
+	if (XE_IOCTL_DBG(oa->xe, err))
+		return -EFAULT;
+
+	if (XE_IOCTL_DBG(oa->xe, ext.pad) ||
+	    XE_IOCTL_DBG(oa->xe, ext.name >= ARRAY_SIZE(xe_oa_user_extension_funcs)))
+		return -EINVAL;
+
+	idx = array_index_nospec(ext.name, ARRAY_SIZE(xe_oa_user_extension_funcs));
+	err = xe_oa_user_extension_funcs[idx](oa, from, extension, param);
+	if (XE_IOCTL_DBG(oa->xe, err))
+		return err;
+
+	if (ext.next_extension)
+		return xe_oa_user_extensions(oa, from, ext.next_extension, ++ext_number, param);
+
+	return 0;
+}
+
+static int xe_oa_parse_syncs(struct xe_oa *oa, struct xe_oa_open_param *param)
+{
+	int ret, num_syncs, num_ufence = 0;
+
+	if (param->num_syncs && !param->syncs_user) {
+		drm_dbg(&oa->xe->drm, "num_syncs specified without sync array\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (param->num_syncs) {
+		param->syncs = kcalloc(param->num_syncs, sizeof(*param->syncs), GFP_KERNEL);
+		if (!param->syncs) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+	}
+
+	for (num_syncs = 0; num_syncs < param->num_syncs; num_syncs++) {
+		ret = xe_sync_entry_parse(oa->xe, param->xef, &param->syncs[num_syncs],
+					  &param->syncs_user[num_syncs], 0);
+		if (ret)
+			goto err_syncs;
+
+		if (xe_sync_is_ufence(&param->syncs[num_syncs]))
+			num_ufence++;
+	}
+
+	if (XE_IOCTL_DBG(oa->xe, num_ufence > 1)) {
+		ret = -EINVAL;
+		goto err_syncs;
+	}
+
+	return 0;
+
+err_syncs:
+	while (num_syncs--)
+		xe_sync_entry_cleanup(&param->syncs[num_syncs]);
+	kfree(param->syncs);
+exit:
+	return ret;
+}
+
 static void xe_oa_stream_enable(struct xe_oa_stream *stream)
 {
 	stream->pollin = false;
@@ -1099,36 +1446,38 @@ static int xe_oa_disable_locked(struct xe_oa_stream *stream)
 
 static long xe_oa_config_locked(struct xe_oa_stream *stream, u64 arg)
 {
-	struct drm_xe_ext_set_property ext;
+	struct xe_oa_open_param param = {};
 	long ret = stream->oa_config->id;
 	struct xe_oa_config *config;
 	int err;
 
-	err = __copy_from_user(&ext, u64_to_user_ptr(arg), sizeof(ext));
-	if (XE_IOCTL_DBG(stream->oa->xe, err))
-		return -EFAULT;
-
-	if (XE_IOCTL_DBG(stream->oa->xe, ext.pad) ||
-	    XE_IOCTL_DBG(stream->oa->xe, ext.base.name != DRM_XE_OA_EXTENSION_SET_PROPERTY) ||
-	    XE_IOCTL_DBG(stream->oa->xe, ext.base.next_extension) ||
-	    XE_IOCTL_DBG(stream->oa->xe, ext.property != DRM_XE_OA_PROPERTY_OA_METRIC_SET))
-		return -EINVAL;
+	err = xe_oa_user_extensions(stream->oa, XE_OA_USER_EXTN_FROM_CONFIG, arg, 0, &param);
+	if (err)
+		return err;
 
-	config = xe_oa_get_oa_config(stream->oa, ext.value);
+	config = xe_oa_get_oa_config(stream->oa, param.metric_set);
 	if (!config)
 		return -ENODEV;
 
-	if (config != stream->oa_config) {
-		err = xe_oa_emit_oa_config(stream, config);
-		if (!err)
-			config = xchg(&stream->oa_config, config);
-		else
-			ret = err;
+	param.xef = stream->xef;
+	err = xe_oa_parse_syncs(stream->oa, &param);
+	if (err)
+		goto err_config_put;
+
+	stream->num_syncs = param.num_syncs;
+	stream->syncs = param.syncs;
+
+	err = xe_oa_emit_oa_config(stream, config);
+	if (!err) {
+		config = xchg(&stream->oa_config, config);
+		drm_dbg(&stream->oa->xe->drm, "changed to oa config uuid=%s\n",
+			stream->oa_config->uuid);
 	}
 
+err_config_put:
 	xe_oa_config_put(config);
 
-	return ret;
+	return err ?: ret;
 }
 
 static long xe_oa_status_locked(struct xe_oa_stream *stream, unsigned long arg)
@@ -1367,10 +1716,11 @@ static int xe_oa_stream_init(struct xe_oa_stream *stream,
 	stream->oa_buffer.format = &stream->oa->oa_formats[param->oa_format];
 
 	stream->sample = param->sample;
-	stream->periodic = param->period_exponent > 0;
+	stream->periodic = param->period_exponent >= 0;
 	stream->period_exponent = param->period_exponent;
 	stream->no_preempt = param->no_preempt;
 
+	stream->xef = xe_file_get(param->xef);
 	stream->num_syncs = param->num_syncs;
 	stream->syncs = param->syncs;
 
@@ -1470,6 +1820,7 @@ static int xe_oa_stream_init(struct xe_oa_stream *stream,
 err_free_configs:
 	xe_oa_free_configs(stream);
 exit:
+	xe_file_put(stream->xef);
 	return ret;
 }
 
@@ -1579,27 +1930,6 @@ static bool engine_supports_oa_format(const struct xe_hw_engine *hwe, int type)
 	}
 }
 
-static int decode_oa_format(struct xe_oa *oa, u64 fmt, enum xe_oa_format_name *name)
-{
-	u32 counter_size = FIELD_GET(DRM_XE_OA_FORMAT_MASK_COUNTER_SIZE, fmt);
-	u32 counter_sel = FIELD_GET(DRM_XE_OA_FORMAT_MASK_COUNTER_SEL, fmt);
-	u32 bc_report = FIELD_GET(DRM_XE_OA_FORMAT_MASK_BC_REPORT, fmt);
-	u32 type = FIELD_GET(DRM_XE_OA_FORMAT_MASK_FMT_TYPE, fmt);
-	int idx;
-
-	for_each_set_bit(idx, oa->format_mask, __XE_OA_FORMAT_MAX) {
-		const struct xe_oa_format *f = &oa->oa_formats[idx];
-
-		if (counter_size == f->counter_size && bc_report == f->bc_report &&
-		    type == f->type && counter_sel == f->counter_select) {
-			*name = idx;
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
 /**
  * xe_oa_unit_id - Return OA unit ID for a hardware engine
  * @hwe: @xe_hw_engine
@@ -1646,214 +1976,6 @@ static int xe_oa_assign_hwe(struct xe_oa *oa, struct xe_oa_open_param *param)
 	return ret;
 }
 
-static int xe_oa_set_prop_oa_unit_id(struct xe_oa *oa, u64 value,
-				     struct xe_oa_open_param *param)
-{
-	if (value >= oa->oa_unit_ids) {
-		drm_dbg(&oa->xe->drm, "OA unit ID out of range %lld\n", value);
-		return -EINVAL;
-	}
-	param->oa_unit_id = value;
-	return 0;
-}
-
-static int xe_oa_set_prop_sample_oa(struct xe_oa *oa, u64 value,
-				    struct xe_oa_open_param *param)
-{
-	param->sample = value;
-	return 0;
-}
-
-static int xe_oa_set_prop_metric_set(struct xe_oa *oa, u64 value,
-				     struct xe_oa_open_param *param)
-{
-	param->metric_set = value;
-	return 0;
-}
-
-static int xe_oa_set_prop_oa_format(struct xe_oa *oa, u64 value,
-				    struct xe_oa_open_param *param)
-{
-	int ret = decode_oa_format(oa, value, &param->oa_format);
-
-	if (ret) {
-		drm_dbg(&oa->xe->drm, "Unsupported OA report format %#llx\n", value);
-		return ret;
-	}
-	return 0;
-}
-
-static int xe_oa_set_prop_oa_exponent(struct xe_oa *oa, u64 value,
-				      struct xe_oa_open_param *param)
-{
-#define OA_EXPONENT_MAX 31
-
-	if (value > OA_EXPONENT_MAX) {
-		drm_dbg(&oa->xe->drm, "OA timer exponent too high (> %u)\n", OA_EXPONENT_MAX);
-		return -EINVAL;
-	}
-	param->period_exponent = value;
-	return 0;
-}
-
-static int xe_oa_set_prop_disabled(struct xe_oa *oa, u64 value,
-				   struct xe_oa_open_param *param)
-{
-	param->disabled = value;
-	return 0;
-}
-
-static int xe_oa_set_prop_exec_queue_id(struct xe_oa *oa, u64 value,
-					struct xe_oa_open_param *param)
-{
-	param->exec_queue_id = value;
-	return 0;
-}
-
-static int xe_oa_set_prop_engine_instance(struct xe_oa *oa, u64 value,
-					  struct xe_oa_open_param *param)
-{
-	param->engine_instance = value;
-	return 0;
-}
-
-static int xe_oa_set_no_preempt(struct xe_oa *oa, u64 value,
-				struct xe_oa_open_param *param)
-{
-	param->no_preempt = value;
-	return 0;
-}
-
-static int xe_oa_set_prop_num_syncs(struct xe_oa *oa, u64 value,
-				    struct xe_oa_open_param *param)
-{
-	param->num_syncs = value;
-	return 0;
-}
-
-static int xe_oa_set_prop_syncs_user(struct xe_oa *oa, u64 value,
-				     struct xe_oa_open_param *param)
-{
-	param->syncs_user = u64_to_user_ptr(value);
-	return 0;
-}
-
-typedef int (*xe_oa_set_property_fn)(struct xe_oa *oa, u64 value,
-				     struct xe_oa_open_param *param);
-static const xe_oa_set_property_fn xe_oa_set_property_funcs[] = {
-	[DRM_XE_OA_PROPERTY_OA_UNIT_ID] = xe_oa_set_prop_oa_unit_id,
-	[DRM_XE_OA_PROPERTY_SAMPLE_OA] = xe_oa_set_prop_sample_oa,
-	[DRM_XE_OA_PROPERTY_OA_METRIC_SET] = xe_oa_set_prop_metric_set,
-	[DRM_XE_OA_PROPERTY_OA_FORMAT] = xe_oa_set_prop_oa_format,
-	[DRM_XE_OA_PROPERTY_OA_PERIOD_EXPONENT] = xe_oa_set_prop_oa_exponent,
-	[DRM_XE_OA_PROPERTY_OA_DISABLED] = xe_oa_set_prop_disabled,
-	[DRM_XE_OA_PROPERTY_EXEC_QUEUE_ID] = xe_oa_set_prop_exec_queue_id,
-	[DRM_XE_OA_PROPERTY_OA_ENGINE_INSTANCE] = xe_oa_set_prop_engine_instance,
-	[DRM_XE_OA_PROPERTY_NO_PREEMPT] = xe_oa_set_no_preempt,
-	[DRM_XE_OA_PROPERTY_NUM_SYNCS] = xe_oa_set_prop_num_syncs,
-	[DRM_XE_OA_PROPERTY_SYNCS] = xe_oa_set_prop_syncs_user,
-};
-
-static int xe_oa_user_ext_set_property(struct xe_oa *oa, u64 extension,
-				       struct xe_oa_open_param *param)
-{
-	u64 __user *address = u64_to_user_ptr(extension);
-	struct drm_xe_ext_set_property ext;
-	int err;
-	u32 idx;
-
-	err = __copy_from_user(&ext, address, sizeof(ext));
-	if (XE_IOCTL_DBG(oa->xe, err))
-		return -EFAULT;
-
-	if (XE_IOCTL_DBG(oa->xe, ext.property >= ARRAY_SIZE(xe_oa_set_property_funcs)) ||
-	    XE_IOCTL_DBG(oa->xe, ext.pad))
-		return -EINVAL;
-
-	idx = array_index_nospec(ext.property, ARRAY_SIZE(xe_oa_set_property_funcs));
-	return xe_oa_set_property_funcs[idx](oa, ext.value, param);
-}
-
-typedef int (*xe_oa_user_extension_fn)(struct xe_oa *oa, u64 extension,
-				       struct xe_oa_open_param *param);
-static const xe_oa_user_extension_fn xe_oa_user_extension_funcs[] = {
-	[DRM_XE_OA_EXTENSION_SET_PROPERTY] = xe_oa_user_ext_set_property,
-};
-
-#define MAX_USER_EXTENSIONS	16
-static int xe_oa_user_extensions(struct xe_oa *oa, u64 extension, int ext_number,
-				 struct xe_oa_open_param *param)
-{
-	u64 __user *address = u64_to_user_ptr(extension);
-	struct drm_xe_user_extension ext;
-	int err;
-	u32 idx;
-
-	if (XE_IOCTL_DBG(oa->xe, ext_number >= MAX_USER_EXTENSIONS))
-		return -E2BIG;
-
-	err = __copy_from_user(&ext, address, sizeof(ext));
-	if (XE_IOCTL_DBG(oa->xe, err))
-		return -EFAULT;
-
-	if (XE_IOCTL_DBG(oa->xe, ext.pad) ||
-	    XE_IOCTL_DBG(oa->xe, ext.name >= ARRAY_SIZE(xe_oa_user_extension_funcs)))
-		return -EINVAL;
-
-	idx = array_index_nospec(ext.name, ARRAY_SIZE(xe_oa_user_extension_funcs));
-	err = xe_oa_user_extension_funcs[idx](oa, extension, param);
-	if (XE_IOCTL_DBG(oa->xe, err))
-		return err;
-
-	if (ext.next_extension)
-		return xe_oa_user_extensions(oa, ext.next_extension, ++ext_number, param);
-
-	return 0;
-}
-
-static int xe_oa_parse_syncs(struct xe_oa *oa, struct xe_oa_open_param *param)
-{
-	int ret, num_syncs, num_ufence = 0;
-
-	if (param->num_syncs && !param->syncs_user) {
-		drm_dbg(&oa->xe->drm, "num_syncs specified without sync array\n");
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	if (param->num_syncs) {
-		param->syncs = kcalloc(param->num_syncs, sizeof(*param->syncs), GFP_KERNEL);
-		if (!param->syncs) {
-			ret = -ENOMEM;
-			goto exit;
-		}
-	}
-
-	for (num_syncs = 0; num_syncs < param->num_syncs; num_syncs++) {
-		ret = xe_sync_entry_parse(oa->xe, param->xef, &param->syncs[num_syncs],
-					  &param->syncs_user[num_syncs], 0);
-		if (ret)
-			goto err_syncs;
-
-		if (xe_sync_is_ufence(&param->syncs[num_syncs]))
-			num_ufence++;
-	}
-
-	if (XE_IOCTL_DBG(oa->xe, num_ufence > 1)) {
-		ret = -EINVAL;
-		goto err_syncs;
-	}
-
-	return 0;
-
-err_syncs:
-	while (num_syncs--)
-		xe_sync_entry_cleanup(&param->syncs[num_syncs]);
-	kfree(param->syncs);
-exit:
-	return ret;
-}
-
 /**
  * xe_oa_stream_open_ioctl - Opens an OA stream
  * @dev: @drm_device
@@ -1880,7 +2002,8 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
 	}
 
 	param.xef = xef;
-	ret = xe_oa_user_extensions(oa, data, 0, &param);
+	param.period_exponent = -1;
+	ret = xe_oa_user_extensions(oa, XE_OA_USER_EXTN_FROM_OPEN, data, 0, &param);
 	if (ret)
 		return ret;
 
@@ -1934,7 +2057,7 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
 		goto err_exec_q;
 	}
 
-	if (param.period_exponent > 0) {
+	if (param.period_exponent >= 0) {
 		u64 oa_period, oa_freq_hz;
 
 		/* Requesting samples from OAG buffer is a privileged operation */
diff --git a/drivers/gpu/drm/xe/xe_oa_types.h b/drivers/gpu/drm/xe/xe_oa_types.h
index 99f4b2d4bdcf..fea9d981e414 100644
--- a/drivers/gpu/drm/xe/xe_oa_types.h
+++ b/drivers/gpu/drm/xe/xe_oa_types.h
@@ -239,6 +239,12 @@ struct xe_oa_stream {
 	/** @no_preempt: Whether preemption and timeslicing is disabled for stream exec_q */
 	u32 no_preempt;
 
+	/** @xef: xe_file with which the stream was opened */
+	struct xe_file *xef;
+
+	/** @last_fence: fence to use in stream destroy when needed */
+	struct dma_fence *last_fence;
+
 	/** @num_syncs: size of @syncs array */
 	u32 num_syncs;
 
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index c99380271de6..5693b337f5df 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -667,20 +667,33 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
 
 	/* Collect invalidated userptrs */
 	spin_lock(&vm->userptr.invalidated_lock);
+	xe_assert(vm->xe, list_empty(&vm->userptr.repin_list));
 	list_for_each_entry_safe(uvma, next, &vm->userptr.invalidated,
 				 userptr.invalidate_link) {
 		list_del_init(&uvma->userptr.invalidate_link);
-		list_move_tail(&uvma->userptr.repin_link,
-			       &vm->userptr.repin_list);
+		list_add_tail(&uvma->userptr.repin_link,
+			      &vm->userptr.repin_list);
 	}
 	spin_unlock(&vm->userptr.invalidated_lock);
 
-	/* Pin and move to temporary list */
+	/* Pin and move to bind list */
 	list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
 				 userptr.repin_link) {
 		err = xe_vma_userptr_pin_pages(uvma);
 		if (err == -EFAULT) {
 			list_del_init(&uvma->userptr.repin_link);
+			/*
+			 * We might have already done the pin once already, but
+			 * then had to retry before the re-bind happened, due
+			 * some other condition in the caller, but in the
+			 * meantime the userptr got dinged by the notifier such
+			 * that we need to revalidate here, but this time we hit
+			 * the EFAULT. In such a case make sure we remove
+			 * ourselves from the rebind list to avoid going down in
+			 * flames.
+			 */
+			if (!list_empty(&uvma->vma.combined_links.rebind))
+				list_del_init(&uvma->vma.combined_links.rebind);
 
 			/* Wait for pending binds */
 			xe_vm_lock(vm, false);
@@ -691,10 +704,10 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
 			err = xe_vm_invalidate_vma(&uvma->vma);
 			xe_vm_unlock(vm);
 			if (err)
-				return err;
+				break;
 		} else {
-			if (err < 0)
-				return err;
+			if (err)
+				break;
 
 			list_del_init(&uvma->userptr.repin_link);
 			list_move_tail(&uvma->vma.combined_links.rebind,
@@ -702,7 +715,19 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
 		}
 	}
 
-	return 0;
+	if (err) {
+		down_write(&vm->userptr.notifier_lock);
+		spin_lock(&vm->userptr.invalidated_lock);
+		list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
+					 userptr.repin_link) {
+			list_del_init(&uvma->userptr.repin_link);
+			list_move_tail(&uvma->userptr.invalidate_link,
+				       &vm->userptr.invalidated);
+		}
+		spin_unlock(&vm->userptr.invalidated_lock);
+		up_write(&vm->userptr.notifier_lock);
+	}
+	return err;
 }
 
 /**
@@ -1066,6 +1091,7 @@ static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
 		xe_assert(vm->xe, vma->gpuva.flags & XE_VMA_DESTROYED);
 
 		spin_lock(&vm->userptr.invalidated_lock);
+		xe_assert(vm->xe, list_empty(&to_userptr_vma(vma)->userptr.repin_link));
 		list_del(&to_userptr_vma(vma)->userptr.invalidate_link);
 		spin_unlock(&vm->userptr.invalidated_lock);
 	} else if (!xe_vma_is_null(vma)) {
diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.c
index 8821cac3897b..b475dd27b7af 100644
--- a/drivers/i2c/busses/i2c-ls2x.c
+++ b/drivers/i2c/busses/i2c-ls2x.c
@@ -10,6 +10,7 @@
  * Rewritten for mainline by Binbin Zhou <zhoubinbin@loongson.cn>
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/completion.h>
 #include <linux/device.h>
@@ -26,7 +27,8 @@
 #include <linux/units.h>
 
 /* I2C Registers */
-#define I2C_LS2X_PRER		0x0 /* Freq Division Register(16 bits) */
+#define I2C_LS2X_PRER_LO	0x0 /* Freq Division Low Byte Register */
+#define I2C_LS2X_PRER_HI	0x1 /* Freq Division High Byte Register */
 #define I2C_LS2X_CTR		0x2 /* Control Register */
 #define I2C_LS2X_TXR		0x3 /* Transport Data Register */
 #define I2C_LS2X_RXR		0x3 /* Receive Data Register */
@@ -93,6 +95,7 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
  */
 static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 {
+	u16 val;
 	struct i2c_timings *t = &priv->i2c_t;
 	struct device *dev = priv->adapter.dev.parent;
 	u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
@@ -104,9 +107,14 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 	else
 		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
 
-	/* Calculate and set i2c frequency. */
-	writew(LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1,
-	       priv->base + I2C_LS2X_PRER);
+	/*
+	 * According to the chip manual, we can only access the registers as bytes,
+	 * otherwise the high bits will be truncated.
+	 * So set the I2C frequency with a sequential writeb() instead of writew().
+	 */
+	val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
+	writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_LO);
+	writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER_HI);
 }
 
 static void ls2x_i2c_init(struct ls2x_i2c_priv *priv)
diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index bbcb4d6668ce..a693ebb64edf 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -2319,6 +2319,13 @@ static int npcm_i2c_probe_bus(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	/*
+	 * Disable the interrupt to avoid the interrupt handler being triggered
+	 * incorrectly by the asynchronous interrupt status since the machine
+	 * might do a warm reset during the last smbus/i2c transfer session.
+	 */
+	npcm_i2c_int_enable(bus, false);
+
 	ret = devm_request_irq(bus->dev, irq, npcm_i2c_bus_irq, 0,
 			       dev_name(bus->dev), bus);
 	if (ret)
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 67aebfe0fed6..524ed143f875 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -55,6 +55,7 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
+#include <asm/tsc.h>
 #include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
@@ -1749,6 +1750,9 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 		if (intel_idle_state_needs_timer_stop(state))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
+		if (cx->type > ACPI_STATE_C1 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+			mark_tsc_unstable("TSC halts in idle");
+
 		state->enter = intel_idle;
 		state->enter_s2idle = intel_idle_s2idle;
 	}
diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index e94518b12f86..a316afc0139c 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -154,6 +154,14 @@ struct bnxt_re_pacing {
 
 #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
 
+#define BNXT_RE_MIN_MSIX		2
+#define BNXT_RE_MAX_MSIX		BNXT_MAX_ROCE_MSIX
+struct bnxt_re_nq_record {
+	struct bnxt_msix_entry	msix_entries[BNXT_RE_MAX_MSIX];
+	struct bnxt_qplib_nq	nq[BNXT_RE_MAX_MSIX];
+	int			num_msix;
+};
+
 #define MAX_CQ_HASH_BITS		(16)
 #define MAX_SRQ_HASH_BITS		(16)
 struct bnxt_re_dev {
@@ -174,24 +182,20 @@ struct bnxt_re_dev {
 	unsigned int			version, major, minor;
 	struct bnxt_qplib_chip_ctx	*chip_ctx;
 	struct bnxt_en_dev		*en_dev;
-	int				num_msix;
 
 	int				id;
 
 	struct delayed_work		worker;
 	u8				cur_prio_map;
 
-	/* FP Notification Queue (CQ & SRQ) */
-	struct tasklet_struct		nq_task;
-
 	/* RCFW Channel */
 	struct bnxt_qplib_rcfw		rcfw;
 
-	/* NQ */
-	struct bnxt_qplib_nq		nq[BNXT_MAX_ROCE_MSIX];
+	/* NQ record */
+	struct bnxt_re_nq_record	*nqr;
 
 	/* Device Resources */
-	struct bnxt_qplib_dev_attr	dev_attr;
+	struct bnxt_qplib_dev_attr	*dev_attr;
 	struct bnxt_qplib_ctx		qplib_ctx;
 	struct bnxt_qplib_res		qplib_res;
 	struct bnxt_qplib_dpi		dpi_privileged;
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 1e63f8091748..f51adb0a97e6 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -357,8 +357,8 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 			goto done;
 		}
 		bnxt_re_copy_err_stats(rdev, stats, err_s);
-		if (_is_ext_stats_supported(rdev->dev_attr.dev_cap_flags) &&
-		    !rdev->is_virtfn) {
+		if (bnxt_ext_stats_supported(rdev->chip_ctx, rdev->dev_attr->dev_cap_flags,
+					     rdev->is_virtfn)) {
 			rc = bnxt_re_get_ext_stat(rdev, stats);
 			if (rc) {
 				clear_bit(BNXT_RE_FLAG_ISSUE_ROCE_STATS,
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index a7067c3c0679..0b21d8b5d962 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -118,7 +118,7 @@ static enum ib_access_flags __to_ib_access_flags(int qflags)
 static void bnxt_re_check_and_set_relaxed_ordering(struct bnxt_re_dev *rdev,
 						   struct bnxt_qplib_mrw *qplib_mr)
 {
-	if (_is_relaxed_ordering_supported(rdev->dev_attr.dev_cap_flags2) &&
+	if (_is_relaxed_ordering_supported(rdev->dev_attr->dev_cap_flags2) &&
 	    pcie_relaxed_ordering_enabled(rdev->en_dev->pdev))
 		qplib_mr->flags |= CMDQ_REGISTER_MR_FLAGS_ENABLE_RO;
 }
@@ -143,7 +143,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 			 struct ib_udata *udata)
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 
 	memset(ib_attr, 0, sizeof(*ib_attr));
 	memcpy(&ib_attr->fw_ver, dev_attr->fw_ver,
@@ -216,7 +216,7 @@ int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 		       struct ib_port_attr *port_attr)
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	int rc;
 
 	memset(port_attr, 0, sizeof(*port_attr));
@@ -274,8 +274,8 @@ void bnxt_re_query_fw_str(struct ib_device *ibdev, char *str)
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 
 	snprintf(str, IB_FW_VERSION_NAME_MAX, "%d.%d.%d.%d",
-		 rdev->dev_attr.fw_ver[0], rdev->dev_attr.fw_ver[1],
-		 rdev->dev_attr.fw_ver[2], rdev->dev_attr.fw_ver[3]);
+		 rdev->dev_attr->fw_ver[0], rdev->dev_attr->fw_ver[1],
+		 rdev->dev_attr->fw_ver[2], rdev->dev_attr->fw_ver[3]);
 }
 
 int bnxt_re_query_pkey(struct ib_device *ibdev, u32 port_num,
@@ -526,7 +526,7 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	mr->qplib_mr.pd = &pd->qplib_pd;
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_PMR;
 	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
-	if (!_is_alloc_mr_unified(rdev->dev_attr.dev_cap_flags)) {
+	if (!_is_alloc_mr_unified(rdev->dev_attr->dev_cap_flags)) {
 		rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to alloc fence-HW-MR\n");
@@ -1001,7 +1001,7 @@ static int bnxt_re_setup_swqe_size(struct bnxt_re_qp *qp,
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	sq = &qplqp->sq;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	align = sizeof(struct sq_send_hdr);
 	ilsize = ALIGN(init_attr->cap.max_inline_data, align);
@@ -1221,7 +1221,7 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	rq = &qplqp->rq;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	if (init_attr->srq) {
 		struct bnxt_re_srq *srq;
@@ -1258,7 +1258,7 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		qplqp->rq.max_sge = dev_attr->max_qp_sges;
@@ -1284,7 +1284,7 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	sq = &qplqp->sq;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	sq->max_sge = init_attr->cap.max_send_sge;
 	entries = init_attr->cap.max_send_wr;
@@ -1337,7 +1337,7 @@ static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		entries = bnxt_re_init_depth(init_attr->cap.max_send_wr + 1, uctx);
@@ -1386,7 +1386,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	/* Setup misc params */
 	ether_addr_copy(qplqp->smac, rdev->netdev->dev_addr);
@@ -1556,7 +1556,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	ib_pd = ib_qp->pd;
 	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	rdev = pd->rdev;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
@@ -1783,7 +1783,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	ib_pd = ib_srq->pd;
 	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	rdev = pd->rdev;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 	srq = container_of(ib_srq, struct bnxt_re_srq, ib_srq);
 
 	if (srq_init_attr->attr.max_wr >= dev_attr->max_srq_wqes) {
@@ -1814,8 +1814,10 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	srq->qplib_srq.wqe_size = bnxt_re_get_rwqe_size(dev_attr->max_srq_sges);
 	srq->qplib_srq.threshold = srq_init_attr->attr.srq_limit;
 	srq->srq_limit = srq_init_attr->attr.srq_limit;
-	srq->qplib_srq.eventq_hw_ring_id = rdev->nq[0].ring_id;
-	nq = &rdev->nq[0];
+	srq->qplib_srq.eventq_hw_ring_id = rdev->nqr->nq[0].ring_id;
+	srq->qplib_srq.sg_info.pgsize = PAGE_SIZE;
+	srq->qplib_srq.sg_info.pgshft = PAGE_SHIFT;
+	nq = &rdev->nqr->nq[0];
 
 	if (udata) {
 		rc = bnxt_re_init_user_srq(rdev, pd, srq, udata);
@@ -1987,7 +1989,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 {
 	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 	struct bnxt_re_dev *rdev = qp->rdev;
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	enum ib_qp_state curr_qp_state, new_qp_state;
 	int rc, entries;
 	unsigned int flags;
@@ -3011,7 +3013,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct bnxt_re_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
 	struct bnxt_qplib_nq *nq = NULL;
 	unsigned int nq_alloc_cnt;
@@ -3070,7 +3072,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	 * used for getting the NQ index.
 	 */
 	nq_alloc_cnt = atomic_inc_return(&rdev->nq_alloc_cnt);
-	nq = &rdev->nq[nq_alloc_cnt % (rdev->num_msix - 1)];
+	nq = &rdev->nqr->nq[nq_alloc_cnt % (rdev->nqr->num_msix - 1)];
 	cq->qplib_cq.max_wqe = entries;
 	cq->qplib_cq.cnq_hw_ring_id = nq->ring_id;
 	cq->qplib_cq.nq	= nq;
@@ -3154,7 +3156,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 
 	cq =  container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	rdev = cq->rdev;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 	if (!ibcq->uobject) {
 		ibdev_err(&rdev->ibdev, "Kernel CQ Resize not supported");
 		return -EOPNOTSUPP;
@@ -4127,7 +4129,7 @@ static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64
 	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_MR;
 
-	if (!_is_alloc_mr_unified(rdev->dev_attr.dev_cap_flags)) {
+	if (!_is_alloc_mr_unified(rdev->dev_attr->dev_cap_flags)) {
 		rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to allocate MR rc = %d", rc);
@@ -4219,7 +4221,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	struct bnxt_re_ucontext *uctx =
 		container_of(ctx, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_re_user_mmap_entry *entry;
 	struct bnxt_re_uctx_resp resp = {};
 	struct bnxt_re_uctx_req ureq = {};
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 8abd1b723f8f..9bd837a5b8a1 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -152,6 +152,10 @@ static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 
 	if (!rdev->chip_ctx)
 		return;
+
+	kfree(rdev->dev_attr);
+	rdev->dev_attr = NULL;
+
 	chip_ctx = rdev->chip_ctx;
 	rdev->chip_ctx = NULL;
 	rdev->rcfw.res = NULL;
@@ -165,7 +169,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx;
 	struct bnxt_en_dev *en_dev;
-	int rc;
+	int rc = -ENOMEM;
 
 	en_dev = rdev->en_dev;
 
@@ -181,23 +185,30 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 
 	rdev->qplib_res.cctx = rdev->chip_ctx;
 	rdev->rcfw.res = &rdev->qplib_res;
-	rdev->qplib_res.dattr = &rdev->dev_attr;
+	rdev->dev_attr = kzalloc(sizeof(*rdev->dev_attr), GFP_KERNEL);
+	if (!rdev->dev_attr)
+		goto free_chip_ctx;
+	rdev->qplib_res.dattr = rdev->dev_attr;
 	rdev->qplib_res.is_vf = BNXT_EN_VF(en_dev);
 
 	bnxt_re_set_drv_mode(rdev);
 
 	bnxt_re_set_db_offset(rdev);
 	rc = bnxt_qplib_map_db_bar(&rdev->qplib_res);
-	if (rc) {
-		kfree(rdev->chip_ctx);
-		rdev->chip_ctx = NULL;
-		return rc;
-	}
+	if (rc)
+		goto free_dev_attr;
 
 	if (bnxt_qplib_determine_atomics(en_dev->pdev))
 		ibdev_info(&rdev->ibdev,
 			   "platform doesn't support global atomics.");
 	return 0;
+free_dev_attr:
+	kfree(rdev->dev_attr);
+	rdev->dev_attr = NULL;
+free_chip_ctx:
+	kfree(rdev->chip_ctx);
+	rdev->chip_ctx = NULL;
+	return rc;
 }
 
 /* SR-IOV helper functions */
@@ -219,7 +230,7 @@ static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 	struct bnxt_qplib_ctx *ctx;
 	int i;
 
-	attr = &rdev->dev_attr;
+	attr = rdev->dev_attr;
 	ctx = &rdev->qplib_ctx;
 
 	ctx->qpc_count = min_t(u32, BNXT_RE_MAX_QPC_COUNT,
@@ -233,7 +244,7 @@ static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
 		for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
 			rdev->qplib_ctx.tqm_ctx.qcount[i] =
-			rdev->dev_attr.tqm_alloc_reqs[i];
+			rdev->dev_attr->tqm_alloc_reqs[i];
 }
 
 static void bnxt_re_limit_vf_res(struct bnxt_qplib_ctx *qplib_ctx, u32 num_vf)
@@ -314,10 +325,12 @@ static void bnxt_re_stop_irq(void *handle)
 	int indx;
 
 	rdev = en_info->rdev;
+	if (!rdev)
+		return;
 	rcfw = &rdev->rcfw;
 
-	for (indx = BNXT_RE_NQ_IDX; indx < rdev->num_msix; indx++) {
-		nq = &rdev->nq[indx - 1];
+	for (indx = BNXT_RE_NQ_IDX; indx < rdev->nqr->num_msix; indx++) {
+		nq = &rdev->nqr->nq[indx - 1];
 		bnxt_qplib_nq_stop_irq(nq, false);
 	}
 
@@ -334,7 +347,9 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	int indx, rc;
 
 	rdev = en_info->rdev;
-	msix_ent = rdev->en_dev->msix_entries;
+	if (!rdev)
+		return;
+	msix_ent = rdev->nqr->msix_entries;
 	rcfw = &rdev->rcfw;
 	if (!ent) {
 		/* Not setting the f/w timeout bit in rcfw.
@@ -349,8 +364,8 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	/* Vectors may change after restart, so update with new vectors
 	 * in device sctructure.
 	 */
-	for (indx = 0; indx < rdev->num_msix; indx++)
-		rdev->en_dev->msix_entries[indx].vector = ent[indx].vector;
+	for (indx = 0; indx < rdev->nqr->num_msix; indx++)
+		rdev->nqr->msix_entries[indx].vector = ent[indx].vector;
 
 	rc = bnxt_qplib_rcfw_start_irq(rcfw, msix_ent[BNXT_RE_AEQ_IDX].vector,
 				       false);
@@ -358,8 +373,8 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 		ibdev_warn(&rdev->ibdev, "Failed to reinit CREQ\n");
 		return;
 	}
-	for (indx = BNXT_RE_NQ_IDX ; indx < rdev->num_msix; indx++) {
-		nq = &rdev->nq[indx - 1];
+	for (indx = BNXT_RE_NQ_IDX ; indx < rdev->nqr->num_msix; indx++) {
+		nq = &rdev->nqr->nq[indx - 1];
 		rc = bnxt_qplib_nq_start_irq(nq, indx - 1,
 					     msix_ent[indx].vector, false);
 		if (rc) {
@@ -943,7 +958,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 
 	addrconf_addr_eui48((u8 *)&ibdev->node_guid, rdev->netdev->dev_addr);
 
-	ibdev->num_comp_vectors	= rdev->num_msix - 1;
+	ibdev->num_comp_vectors	= rdev->nqr->num_msix - 1;
 	ibdev->dev.parent = &rdev->en_dev->pdev->dev;
 	ibdev->local_dma_lkey = BNXT_QPLIB_RSVD_LKEY;
 
@@ -1276,8 +1291,8 @@ static void bnxt_re_cleanup_res(struct bnxt_re_dev *rdev)
 {
 	int i;
 
-	for (i = 1; i < rdev->num_msix; i++)
-		bnxt_qplib_disable_nq(&rdev->nq[i - 1]);
+	for (i = 1; i < rdev->nqr->num_msix; i++)
+		bnxt_qplib_disable_nq(&rdev->nqr->nq[i - 1]);
 
 	if (rdev->qplib_res.rcfw)
 		bnxt_qplib_cleanup_res(&rdev->qplib_res);
@@ -1291,10 +1306,10 @@ static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 
 	bnxt_qplib_init_res(&rdev->qplib_res);
 
-	for (i = 1; i < rdev->num_msix ; i++) {
-		db_offt = rdev->en_dev->msix_entries[i].db_offset;
-		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, &rdev->nq[i - 1],
-					  i - 1, rdev->en_dev->msix_entries[i].vector,
+	for (i = 1; i < rdev->nqr->num_msix ; i++) {
+		db_offt = rdev->nqr->msix_entries[i].db_offset;
+		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, &rdev->nqr->nq[i - 1],
+					  i - 1, rdev->nqr->msix_entries[i].vector,
 					  db_offt, &bnxt_re_cqn_handler,
 					  &bnxt_re_srqn_handler);
 		if (rc) {
@@ -1307,20 +1322,22 @@ static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 	return 0;
 fail:
 	for (i = num_vec_enabled; i >= 0; i--)
-		bnxt_qplib_disable_nq(&rdev->nq[i]);
+		bnxt_qplib_disable_nq(&rdev->nqr->nq[i]);
 	return rc;
 }
 
 static void bnxt_re_free_nq_res(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_nq *nq;
 	u8 type;
 	int i;
 
-	for (i = 0; i < rdev->num_msix - 1; i++) {
+	for (i = 0; i < rdev->nqr->num_msix - 1; i++) {
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-		bnxt_re_net_ring_free(rdev, rdev->nq[i].ring_id, type);
-		bnxt_qplib_free_nq(&rdev->nq[i]);
-		rdev->nq[i].res = NULL;
+		nq = &rdev->nqr->nq[i];
+		bnxt_re_net_ring_free(rdev, nq->ring_id, type);
+		bnxt_qplib_free_nq(nq);
+		nq->res = NULL;
 	}
 }
 
@@ -1347,12 +1364,11 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 
 	/* Configure and allocate resources for qplib */
 	rdev->qplib_res.rcfw = &rdev->rcfw;
-	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr);
+	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw);
 	if (rc)
 		goto fail;
 
-	rc = bnxt_qplib_alloc_res(&rdev->qplib_res, rdev->en_dev->pdev,
-				  rdev->netdev, &rdev->dev_attr);
+	rc = bnxt_qplib_alloc_res(&rdev->qplib_res, rdev->netdev);
 	if (rc)
 		goto fail;
 
@@ -1362,12 +1378,12 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 	if (rc)
 		goto dealloc_res;
 
-	for (i = 0; i < rdev->num_msix - 1; i++) {
+	for (i = 0; i < rdev->nqr->num_msix - 1; i++) {
 		struct bnxt_qplib_nq *nq;
 
-		nq = &rdev->nq[i];
+		nq = &rdev->nqr->nq[i];
 		nq->hwq.max_elements = BNXT_QPLIB_NQE_MAX_CNT;
-		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, &rdev->nq[i]);
+		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, nq);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Alloc Failed NQ%d rc:%#x",
 				  i, rc);
@@ -1375,17 +1391,17 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 		}
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		rattr.dma_arr = nq->hwq.pbl[PBL_LVL_0].pg_map_arr;
-		rattr.pages = nq->hwq.pbl[rdev->nq[i].hwq.level].pg_count;
+		rattr.pages = nq->hwq.pbl[rdev->nqr->nq[i].hwq.level].pg_count;
 		rattr.type = type;
 		rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 		rattr.depth = BNXT_QPLIB_NQE_MAX_CNT - 1;
-		rattr.lrid = rdev->en_dev->msix_entries[i + 1].ring_idx;
+		rattr.lrid = rdev->nqr->msix_entries[i + 1].ring_idx;
 		rc = bnxt_re_net_ring_alloc(rdev, &rattr, &nq->ring_id);
 		if (rc) {
 			ibdev_err(&rdev->ibdev,
 				  "Failed to allocate NQ fw id with rc = 0x%x",
 				  rc);
-			bnxt_qplib_free_nq(&rdev->nq[i]);
+			bnxt_qplib_free_nq(nq);
 			goto free_nq;
 		}
 		num_vec_created++;
@@ -1394,8 +1410,8 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 free_nq:
 	for (i = num_vec_created - 1; i >= 0; i--) {
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-		bnxt_re_net_ring_free(rdev, rdev->nq[i].ring_id, type);
-		bnxt_qplib_free_nq(&rdev->nq[i]);
+		bnxt_re_net_ring_free(rdev, rdev->nqr->nq[i].ring_id, type);
+		bnxt_qplib_free_nq(&rdev->nqr->nq[i]);
 	}
 	bnxt_qplib_dealloc_dpi(&rdev->qplib_res,
 			       &rdev->dpi_privileged);
@@ -1584,6 +1600,21 @@ static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
+static int bnxt_re_alloc_nqr_mem(struct bnxt_re_dev *rdev)
+{
+	rdev->nqr = kzalloc(sizeof(*rdev->nqr), GFP_KERNEL);
+	if (!rdev->nqr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void bnxt_re_free_nqr_mem(struct bnxt_re_dev *rdev)
+{
+	kfree(rdev->nqr);
+	rdev->nqr = NULL;
+}
+
 static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	u8 type;
@@ -1611,11 +1642,12 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 		bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 	}
 
-	rdev->num_msix = 0;
+	rdev->nqr->num_msix = 0;
 
 	if (rdev->pacing.dbr_pacing)
 		bnxt_re_deinitialize_dbr_pacing(rdev);
 
+	bnxt_re_free_nqr_mem(rdev);
 	bnxt_re_destroy_chip_ctx(rdev);
 	if (op_type == BNXT_RE_COMPLETE_REMOVE) {
 		if (test_and_clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
@@ -1653,6 +1685,17 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	}
 	set_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 
+	if (rdev->en_dev->ulp_tbl->msix_requested < BNXT_RE_MIN_MSIX) {
+		ibdev_err(&rdev->ibdev,
+			  "RoCE requires minimum 2 MSI-X vectors, but only %d reserved\n",
+			  rdev->en_dev->ulp_tbl->msix_requested);
+		bnxt_unregister_dev(rdev->en_dev);
+		clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+		return -EINVAL;
+	}
+	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
+		  rdev->en_dev->ulp_tbl->msix_requested);
+
 	rc = bnxt_re_setup_chip_ctx(rdev);
 	if (rc) {
 		bnxt_unregister_dev(rdev->en_dev);
@@ -1661,19 +1704,20 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		return -EINVAL;
 	}
 
+	rc = bnxt_re_alloc_nqr_mem(rdev);
+	if (rc) {
+		bnxt_re_destroy_chip_ctx(rdev);
+		bnxt_unregister_dev(rdev->en_dev);
+		clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+		return rc;
+	}
+	rdev->nqr->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
+	memcpy(rdev->nqr->msix_entries, rdev->en_dev->msix_entries,
+	       sizeof(struct bnxt_msix_entry) * rdev->nqr->num_msix);
+
 	/* Check whether VF or PF */
 	bnxt_re_get_sriov_func_type(rdev);
 
-	if (!rdev->en_dev->ulp_tbl->msix_requested) {
-		ibdev_err(&rdev->ibdev,
-			  "Failed to get MSI-X vectors: %#x\n", rc);
-		rc = -EINVAL;
-		goto fail;
-	}
-	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
-		  rdev->en_dev->ulp_tbl->msix_requested);
-	rdev->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
-
 	bnxt_re_query_hwrm_intf_version(rdev);
 
 	/* Establish RCFW Communication Channel to initialize the context
@@ -1695,14 +1739,14 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	rattr.type = type;
 	rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 	rattr.depth = BNXT_QPLIB_CREQE_MAX_CNT - 1;
-	rattr.lrid = rdev->en_dev->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
+	rattr.lrid = rdev->nqr->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
 	rc = bnxt_re_net_ring_alloc(rdev, &rattr, &creq->ring_id);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to allocate CREQ: %#x\n", rc);
 		goto free_rcfw;
 	}
-	db_offt = rdev->en_dev->msix_entries[BNXT_RE_AEQ_IDX].db_offset;
-	vid = rdev->en_dev->msix_entries[BNXT_RE_AEQ_IDX].vector;
+	db_offt = rdev->nqr->msix_entries[BNXT_RE_AEQ_IDX].db_offset;
+	vid = rdev->nqr->msix_entries[BNXT_RE_AEQ_IDX].vector;
 	rc = bnxt_qplib_enable_rcfw_channel(&rdev->rcfw,
 					    vid, db_offt,
 					    &bnxt_re_aeq_handler);
@@ -1722,7 +1766,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 			rdev->pacing.dbr_pacing = false;
 		}
 	}
-	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr);
+	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw);
 	if (rc)
 		goto disable_rcfw;
 
@@ -2047,6 +2091,7 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 	ibdev_info(&rdev->ibdev, "%s: L2 driver notified to stop en_state 0x%lx",
 		   __func__, en_dev->en_state);
 	bnxt_re_remove_device(rdev, BNXT_RE_PRE_RECOVERY_REMOVE, adev);
+	bnxt_re_update_en_info_rdev(NULL, en_info, adev);
 	mutex_unlock(&bnxt_re_mutex);
 
 	return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 96ceec1e8199..02922a0987ad 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -876,14 +876,13 @@ void bnxt_qplib_free_res(struct bnxt_qplib_res *res)
 	bnxt_qplib_free_dpi_tbl(res, &res->dpi_tbl);
 }
 
-int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
-			 struct net_device *netdev,
-			 struct bnxt_qplib_dev_attr *dev_attr)
+int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct net_device *netdev)
 {
+	struct bnxt_qplib_dev_attr *dev_attr;
 	int rc;
 
-	res->pdev = pdev;
 	res->netdev = netdev;
+	dev_attr = res->dattr;
 
 	rc = bnxt_qplib_alloc_sgid_tbl(res, &res->sgid_tbl, dev_attr->max_sgid);
 	if (rc)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index c2f710364e0f..b40cff8252bc 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -421,9 +421,7 @@ int bnxt_qplib_dealloc_dpi(struct bnxt_qplib_res *res,
 void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_init_res(struct bnxt_qplib_res *res);
 void bnxt_qplib_free_res(struct bnxt_qplib_res *res);
-int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
-			 struct net_device *netdev,
-			 struct bnxt_qplib_dev_attr *dev_attr);
+int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct net_device *netdev);
 void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx);
 int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
@@ -546,6 +544,14 @@ static inline bool _is_ext_stats_supported(u16 dev_cap_flags)
 		CREQ_QUERY_FUNC_RESP_SB_EXT_STATS;
 }
 
+static inline int bnxt_ext_stats_supported(struct bnxt_qplib_chip_ctx *ctx,
+					   u16 flags, bool virtfn)
+{
+	/* ext stats supported if cap flag is set AND is a PF OR a Thor2 VF */
+	return (_is_ext_stats_supported(flags) &&
+		((virtfn && bnxt_qplib_is_chip_gen_p7(ctx)) || (!virtfn)));
+}
+
 static inline bool _is_hw_retx_supported(u16 dev_cap_flags)
 {
 	return dev_cap_flags &
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 3cca7b1395f6..807439b1acb5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -88,9 +88,9 @@ static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 	fw_ver[3] = resp.fw_rsvd;
 }
 
-int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
-			    struct bnxt_qplib_dev_attr *attr)
+int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw)
 {
+	struct bnxt_qplib_dev_attr *attr = rcfw->res->dattr;
 	struct creq_query_func_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct creq_query_func_resp_sb *sb;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index ecf3f45fea74..de959b3c28e0 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -325,8 +325,7 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			   struct bnxt_qplib_gid *gid, u16 gid_idx,
 			   const u8 *smac);
-int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
-			    struct bnxt_qplib_dev_attr *attr);
+int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_rcfw *rcfw,
 				  struct bnxt_qplib_ctx *ctx);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0144e7210d05..f5c3e560df58 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1286,10 +1286,8 @@ static u32 hns_roce_cmdq_tx_timeout(u16 opcode, u32 tx_timeout)
 	return tx_timeout;
 }
 
-static void hns_roce_wait_csq_done(struct hns_roce_dev *hr_dev, u16 opcode)
+static void hns_roce_wait_csq_done(struct hns_roce_dev *hr_dev, u32 tx_timeout)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	u32 tx_timeout = hns_roce_cmdq_tx_timeout(opcode, priv->cmq.tx_timeout);
 	u32 timeout = 0;
 
 	do {
@@ -1299,8 +1297,9 @@ static void hns_roce_wait_csq_done(struct hns_roce_dev *hr_dev, u16 opcode)
 	} while (++timeout < tx_timeout);
 }
 
-static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_cmq_desc *desc, int num)
+static int __hns_roce_cmq_send_one(struct hns_roce_dev *hr_dev,
+				   struct hns_roce_cmq_desc *desc,
+				   int num, u32 tx_timeout)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_v2_cmq_ring *csq = &priv->cmq.csq;
@@ -1309,8 +1308,6 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	int ret;
 	int i;
 
-	spin_lock_bh(&csq->lock);
-
 	tail = csq->head;
 
 	for (i = 0; i < num; i++) {
@@ -1324,22 +1321,17 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 
 	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CMDS_CNT]);
 
-	hns_roce_wait_csq_done(hr_dev, le16_to_cpu(desc->opcode));
+	hns_roce_wait_csq_done(hr_dev, tx_timeout);
 	if (hns_roce_cmq_csq_done(hr_dev)) {
 		ret = 0;
 		for (i = 0; i < num; i++) {
 			/* check the result of hardware write back */
-			desc[i] = csq->desc[tail++];
+			desc_ret = le16_to_cpu(csq->desc[tail++].retval);
 			if (tail == csq->desc_num)
 				tail = 0;
-
-			desc_ret = le16_to_cpu(desc[i].retval);
 			if (likely(desc_ret == CMD_EXEC_SUCCESS))
 				continue;
 
-			dev_err_ratelimited(hr_dev->dev,
-					    "Cmdq IO error, opcode = 0x%x, return = 0x%x.\n",
-					    desc->opcode, desc_ret);
 			ret = hns_roce_cmd_err_convert_errno(desc_ret);
 		}
 	} else {
@@ -1354,14 +1346,54 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 		ret = -EAGAIN;
 	}
 
-	spin_unlock_bh(&csq->lock);
-
 	if (ret)
 		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CMDS_ERR_CNT]);
 
 	return ret;
 }
 
+static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_cmq_desc *desc, int num)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_cmq_ring *csq = &priv->cmq.csq;
+	u16 opcode = le16_to_cpu(desc->opcode);
+	u32 tx_timeout = hns_roce_cmdq_tx_timeout(opcode, priv->cmq.tx_timeout);
+	u8 try_cnt = HNS_ROCE_OPC_POST_MB_TRY_CNT;
+	u32 rsv_tail;
+	int ret;
+	int i;
+
+	while (try_cnt) {
+		try_cnt--;
+
+		spin_lock_bh(&csq->lock);
+		rsv_tail = csq->head;
+		ret = __hns_roce_cmq_send_one(hr_dev, desc, num, tx_timeout);
+		if (opcode == HNS_ROCE_OPC_POST_MB && ret == -ETIME &&
+		    try_cnt) {
+			spin_unlock_bh(&csq->lock);
+			mdelay(HNS_ROCE_OPC_POST_MB_RETRY_GAP_MSEC);
+			continue;
+		}
+
+		for (i = 0; i < num; i++) {
+			desc[i] = csq->desc[rsv_tail++];
+			if (rsv_tail == csq->desc_num)
+				rsv_tail = 0;
+		}
+		spin_unlock_bh(&csq->lock);
+		break;
+	}
+
+	if (ret)
+		dev_err_ratelimited(hr_dev->dev,
+				    "Cmdq IO error, opcode = 0x%x, return = %d.\n",
+				    opcode, ret);
+
+	return ret;
+}
+
 static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			     struct hns_roce_cmq_desc *desc, int num)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index cbdbc9edbce6..91a5665465ff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -230,6 +230,8 @@ enum hns_roce_opcode_type {
 };
 
 #define HNS_ROCE_OPC_POST_MB_TIMEOUT 35000
+#define HNS_ROCE_OPC_POST_MB_TRY_CNT 8
+#define HNS_ROCE_OPC_POST_MB_RETRY_GAP_MSEC 5
 struct hns_roce_cmdq_tx_timeout_map {
 	u16 opcode;
 	u32 tx_timeout;
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 67c2d43135a8..457cea6d9909 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -174,7 +174,7 @@ static int mana_gd_allocate_doorbell_page(struct gdma_context *gc,
 
 	req.resource_type = GDMA_RESOURCE_DOORBELL_PAGE;
 	req.num_resources = 1;
-	req.alignment = 1;
+	req.alignment = PAGE_SIZE / MANA_PAGE_SIZE;
 
 	/* Have GDMA start searching from 0 */
 	req.allocated_resources = 0;
diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 505bc47fd575..99036afb3aef 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -67,7 +67,8 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 		ah->av.tclass = grh->traffic_class;
 	}
 
-	ah->av.stat_rate_sl = (rdma_ah_get_static_rate(ah_attr) << 4);
+	ah->av.stat_rate_sl =
+		(mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr)) << 4);
 
 	if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
 		if (init_attr->xmit_slave)
diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 4f6c1968a2ee..81cfa74147a1 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -546,6 +546,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 				   struct ib_qp *qp)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
+	bool new = false;
 	int err;
 
 	if (!counter->id) {
@@ -560,6 +561,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 			return err;
 		counter->id =
 			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
+		new = true;
 	}
 
 	err = mlx5_ib_qp_set_counter(qp, counter);
@@ -569,8 +571,10 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 	return 0;
 
 fail_set_counter:
-	mlx5_ib_counter_dealloc(counter);
-	counter->id = 0;
+	if (new) {
+		mlx5_ib_counter_dealloc(counter);
+		counter->id = 0;
+	}
 
 	return err;
 }
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index bb02b6adbf2c..753faa9ad06a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1550,7 +1550,7 @@ static void mlx5_ib_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
 
 	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
 
-	if (!umem_dmabuf->sgt)
+	if (!umem_dmabuf->sgt || !mr)
 		return;
 
 	mlx5r_umr_update_mr_pas(mr, MLX5_IB_UPD_XLT_ZAP);
@@ -1935,7 +1935,8 @@ mlx5_alloc_priv_descs(struct ib_device *device,
 static void
 mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 {
-	if (!mr->umem && !mr->data_direct && mr->descs) {
+	if (!mr->umem && !mr->data_direct &&
+	    mr->ibmr.type != IB_MR_TYPE_DM && mr->descs) {
 		struct ib_device *device = mr->ibmr.device;
 		int size = mr->max_descs * mr->desc_size;
 		struct mlx5_ib_dev *dev = to_mdev(device);
@@ -2022,11 +2023,16 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
 	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
 	bool is_odp = is_odp_mr(mr);
+	bool is_odp_dma_buf = is_dmabuf_mr(mr) &&
+			!to_ib_umem_dmabuf(mr->umem)->pinned;
 	int ret = 0;
 
 	if (is_odp)
 		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
 
+	if (is_odp_dma_buf)
+		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv, NULL);
+
 	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr)) {
 		ent = mr->mmkey.cache_ent;
 		/* upon storing to a clean temp entry - schedule its cleanup */
@@ -2054,6 +2060,12 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		mutex_unlock(&to_ib_umem_odp(mr->umem)->umem_mutex);
 	}
 
+	if (is_odp_dma_buf) {
+		if (!ret)
+			to_ib_umem_dmabuf(mr->umem)->private = NULL;
+		dma_resv_unlock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
+	}
+
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 1d3bf5615770..b4e2a6f9cb9c 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -242,6 +242,7 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	if (__xa_cmpxchg(&imr->implicit_children, idx, mr, NULL, GFP_KERNEL) !=
 	    mr) {
 		xa_unlock(&imr->implicit_children);
+		mlx5r_deref_odp_mkey(&imr->mmkey);
 		return;
 	}
 
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 10ce3b44f645..ded139b4e87a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3420,11 +3420,11 @@ static int ib_to_mlx5_rate_map(u8 rate)
 	return 0;
 }
 
-static int ib_rate_to_mlx5(struct mlx5_ib_dev *dev, u8 rate)
+int mlx5r_ib_rate(struct mlx5_ib_dev *dev, u8 rate)
 {
 	u32 stat_rate_support;
 
-	if (rate == IB_RATE_PORT_CURRENT)
+	if (rate == IB_RATE_PORT_CURRENT || rate == IB_RATE_800_GBPS)
 		return 0;
 
 	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_800_GBPS)
@@ -3569,7 +3569,7 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		       sizeof(grh->dgid.raw));
 	}
 
-	err = ib_rate_to_mlx5(dev, rdma_ah_get_static_rate(ah));
+	err = mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah));
 	if (err < 0)
 		return err;
 	MLX5_SET(ads, path, stat_rate, err);
@@ -4547,6 +4547,8 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 		set_id = mlx5_ib_get_counters_id(dev, attr->port_num - 1);
 		MLX5_SET(dctc, dctc, counter_set_id, set_id);
+
+		qp->port = attr->port_num;
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		struct mlx5_ib_modify_qp_resp resp = {};
 		u32 out[MLX5_ST_SZ_DW(create_dct_out)] = {};
@@ -5033,7 +5035,7 @@ static int mlx5_ib_dct_query_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *mqp,
 	}
 
 	if (qp_attr_mask & IB_QP_PORT)
-		qp_attr->port_num = MLX5_GET(dctc, dctc, port);
+		qp_attr->port_num = mqp->port;
 	if (qp_attr_mask & IB_QP_MIN_RNR_TIMER)
 		qp_attr->min_rnr_timer = MLX5_GET(dctc, dctc, min_rnr_nak);
 	if (qp_attr_mask & IB_QP_AV) {
diff --git a/drivers/infiniband/hw/mlx5/qp.h b/drivers/infiniband/hw/mlx5/qp.h
index b6ee7c3ee1ca..2530e7730635 100644
--- a/drivers/infiniband/hw/mlx5/qp.h
+++ b/drivers/infiniband/hw/mlx5/qp.h
@@ -56,4 +56,5 @@ int mlx5_core_xrcd_dealloc(struct mlx5_ib_dev *dev, u32 xrcdn);
 int mlx5_ib_qp_set_counter(struct ib_qp *qp, struct rdma_counter *counter);
 int mlx5_ib_qp_event_init(void);
 void mlx5_ib_qp_event_cleanup(void);
+int mlx5r_ib_rate(struct mlx5_ib_dev *dev, u8 rate);
 #endif /* _MLX5_IB_QP_H */
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 887fd6fa3ba9..793f3c5c4d01 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -231,30 +231,6 @@ void mlx5r_umr_cleanup(struct mlx5_ib_dev *dev)
 	ib_dealloc_pd(dev->umrc.pd);
 }
 
-static int mlx5r_umr_recover(struct mlx5_ib_dev *dev)
-{
-	struct umr_common *umrc = &dev->umrc;
-	struct ib_qp_attr attr;
-	int err;
-
-	attr.qp_state = IB_QPS_RESET;
-	err = ib_modify_qp(umrc->qp, &attr, IB_QP_STATE);
-	if (err) {
-		mlx5_ib_dbg(dev, "Couldn't modify UMR QP\n");
-		goto err;
-	}
-
-	err = mlx5r_umr_qp_rst2rts(dev, umrc->qp);
-	if (err)
-		goto err;
-
-	umrc->state = MLX5_UMR_STATE_ACTIVE;
-	return 0;
-
-err:
-	umrc->state = MLX5_UMR_STATE_ERR;
-	return err;
-}
 
 static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
 			       struct mlx5r_umr_wqe *wqe, bool with_data)
@@ -302,6 +278,61 @@ static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
 	return err;
 }
 
+static int mlx5r_umr_recover(struct mlx5_ib_dev *dev, u32 mkey,
+			     struct mlx5r_umr_context *umr_context,
+			     struct mlx5r_umr_wqe *wqe, bool with_data)
+{
+	struct umr_common *umrc = &dev->umrc;
+	struct ib_qp_attr attr;
+	int err;
+
+	mutex_lock(&umrc->lock);
+	/* Preventing any further WRs to be sent now */
+	if (umrc->state != MLX5_UMR_STATE_RECOVER) {
+		mlx5_ib_warn(dev, "UMR recovery encountered an unexpected state=%d\n",
+			     umrc->state);
+		umrc->state = MLX5_UMR_STATE_RECOVER;
+	}
+	mutex_unlock(&umrc->lock);
+
+	/* Sending a final/barrier WR (the failed one) and wait for its completion.
+	 * This will ensure that all the previous WRs got a completion before
+	 * we set the QP state to RESET.
+	 */
+	err = mlx5r_umr_post_send(umrc->qp, mkey, &umr_context->cqe, wqe,
+				  with_data);
+	if (err) {
+		mlx5_ib_warn(dev, "UMR recovery post send failed, err %d\n", err);
+		goto err;
+	}
+
+	/* Since the QP is in an error state, it will only receive
+	 * IB_WC_WR_FLUSH_ERR. However, as it serves only as a barrier
+	 * we don't care about its status.
+	 */
+	wait_for_completion(&umr_context->done);
+
+	attr.qp_state = IB_QPS_RESET;
+	err = ib_modify_qp(umrc->qp, &attr, IB_QP_STATE);
+	if (err) {
+		mlx5_ib_warn(dev, "Couldn't modify UMR QP to RESET, err=%d\n", err);
+		goto err;
+	}
+
+	err = mlx5r_umr_qp_rst2rts(dev, umrc->qp);
+	if (err) {
+		mlx5_ib_warn(dev, "Couldn't modify UMR QP to RTS, err=%d\n", err);
+		goto err;
+	}
+
+	umrc->state = MLX5_UMR_STATE_ACTIVE;
+	return 0;
+
+err:
+	umrc->state = MLX5_UMR_STATE_ERR;
+	return err;
+}
+
 static void mlx5r_umr_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct mlx5_ib_umr_context *context =
@@ -366,9 +397,7 @@ static int mlx5r_umr_post_send_wait(struct mlx5_ib_dev *dev, u32 mkey,
 		mlx5_ib_warn(dev,
 			"reg umr failed (%u). Trying to recover and resubmit the flushed WQEs, mkey = %u\n",
 			umr_context.status, mkey);
-		mutex_lock(&umrc->lock);
-		err = mlx5r_umr_recover(dev);
-		mutex_unlock(&umrc->lock);
+		err = mlx5r_umr_recover(dev, mkey, &umr_context, wqe, with_data);
 		if (err)
 			mlx5_ib_warn(dev, "couldn't recover UMR, err %d\n",
 				     err);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index eaf862e8dea1..7f553f7aa3cb 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2056,6 +2056,7 @@ int enable_drhd_fault_handling(unsigned int cpu)
 	/*
 	 * Enable fault control interrupt.
 	 */
+	guard(rwsem_read)(&dmar_global_lock);
 	for_each_iommu(iommu, drhd) {
 		u32 fault_status;
 		int ret;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc23cfcdeb2d..9c46a4cd3848 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3307,7 +3307,14 @@ int __init intel_iommu_init(void)
 		iommu_device_sysfs_add(&iommu->iommu, NULL,
 				       intel_iommu_groups,
 				       "%s", iommu->name);
+		/*
+		 * The iommu device probe is protected by the iommu_probe_device_lock.
+		 * Release the dmar_global_lock before entering the device probe path
+		 * to avoid unnecessary lock order splat.
+		 */
+		up_read(&dmar_global_lock);
 		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+		down_read(&dmar_global_lock);
 
 		iommu_pmu_register(iommu);
 	}
@@ -4547,9 +4554,6 @@ static int context_setup_pass_through_cb(struct pci_dev *pdev, u16 alias, void *
 {
 	struct device *dev = data;
 
-	if (dev != &pdev->dev)
-		return 0;
-
 	return context_setup_pass_through(dev, PCI_BUS_NUM(alias), alias & 0xff);
 }
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index ee9f7cecd78e..555dc06b9422 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3790,10 +3790,6 @@ static void dm_integrity_status(struct dm_target *ti, status_type_t type,
 		break;
 
 	case STATUSTYPE_TABLE: {
-		__u64 watermark_percentage = (__u64)(ic->journal_entries - ic->free_sectors_threshold) * 100;
-
-		watermark_percentage += ic->journal_entries / 2;
-		do_div(watermark_percentage, ic->journal_entries);
 		arg_count = 3;
 		arg_count += !!ic->meta_dev;
 		arg_count += ic->sectors_per_block != 1;
@@ -3826,6 +3822,10 @@ static void dm_integrity_status(struct dm_target *ti, status_type_t type,
 		DMEMIT(" interleave_sectors:%u", 1U << ic->sb->log2_interleave_sectors);
 		DMEMIT(" buffer_sectors:%u", 1U << ic->log2_buffer_sectors);
 		if (ic->mode == 'J') {
+			__u64 watermark_percentage = (__u64)(ic->journal_entries - ic->free_sectors_threshold) * 100;
+
+			watermark_percentage += ic->journal_entries / 2;
+			do_div(watermark_percentage, ic->journal_entries);
 			DMEMIT(" journal_watermark:%u", (unsigned int)watermark_percentage);
 			DMEMIT(" commit_time:%u", ic->autocommit_msec);
 		}
diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
index 80628ae93fba..5a74b3a85ec4 100644
--- a/drivers/md/dm-vdo/dedupe.c
+++ b/drivers/md/dm-vdo/dedupe.c
@@ -2178,6 +2178,7 @@ static int initialize_index(struct vdo *vdo, struct hash_zones *zones)
 
 	vdo_set_dedupe_index_timeout_interval(vdo_dedupe_index_timeout_interval);
 	vdo_set_dedupe_index_min_timer_interval(vdo_dedupe_index_min_timer_interval);
+	spin_lock_init(&zones->lock);
 
 	/*
 	 * Since we will save up the timeouts that would have been reported but were ratelimited,
diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 6989972eebc3..10687722d14c 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -43,4 +43,10 @@ config NET_DSA_REALTEK_RTL8366RB
 	help
 	  Select to enable support for Realtek RTL8366RB.
 
+config NET_DSA_REALTEK_RTL8366RB_LEDS
+	bool "Support RTL8366RB LED control"
+	depends on (LEDS_CLASS=y || LEDS_CLASS=NET_DSA_REALTEK_RTL8366RB)
+	depends on NET_DSA_REALTEK_RTL8366RB
+	default NET_DSA_REALTEK_RTL8366RB
+
 endif
diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 35491dc20d6d..17367bcba496 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -12,4 +12,7 @@ endif
 
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
+ifdef CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS
+rtl8366-objs 				+= rtl8366rb-leds.o
+endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
diff --git a/drivers/net/dsa/realtek/rtl8366rb-leds.c b/drivers/net/dsa/realtek/rtl8366rb-leds.c
new file mode 100644
index 000000000000..99c890681ae6
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8366rb-leds.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <net/dsa.h>
+#include "rtl83xx.h"
+#include "rtl8366rb.h"
+
+static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
+{
+	switch (led_group) {
+	case 0:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 1:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 2:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 3:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	default:
+		return 0;
+	}
+}
+
+static int rb8366rb_get_port_led(struct rtl8366rb_led *led)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+	u32 val;
+
+	ret = regmap_read(priv->map, RTL8366RB_LED_X_X_CTRL_REG(led_group),
+			  &val);
+	if (ret) {
+		dev_err(priv->dev, "error reading LED on port %d group %d\n",
+			led_group, port_num);
+		return ret;
+	}
+
+	return !!(val & rtl8366rb_led_group_port_mask(led_group, port_num));
+}
+
+static int rb8366rb_set_port_led(struct rtl8366rb_led *led, bool enable)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8366RB_LED_X_X_CTRL_REG(led_group),
+				 rtl8366rb_led_group_port_mask(led_group,
+							       port_num),
+				 enable ? 0xffff : 0);
+	if (ret) {
+		dev_err(priv->dev, "error updating LED on port %d group %d\n",
+			led_group, port_num);
+		return ret;
+	}
+
+	/* Change the LED group to manual controlled LEDs if required */
+	ret = rb8366rb_set_ledgroup_mode(priv, led_group,
+					 RTL8366RB_LEDGROUP_FORCE);
+
+	if (ret) {
+		dev_err(priv->dev, "error updating LED GROUP group %d\n",
+			led_group);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+rtl8366rb_cled_brightness_set_blocking(struct led_classdev *ldev,
+				       enum led_brightness brightness)
+{
+	struct rtl8366rb_led *led = container_of(ldev, struct rtl8366rb_led,
+						 cdev);
+
+	return rb8366rb_set_port_led(led, brightness == LED_ON);
+}
+
+static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
+			       struct fwnode_handle *led_fwnode)
+{
+	struct rtl8366rb *rb = priv->chip_data;
+	struct led_init_data init_data = { };
+	enum led_default_state state;
+	struct rtl8366rb_led *led;
+	u32 led_group;
+	int ret;
+
+	ret = fwnode_property_read_u32(led_fwnode, "reg", &led_group);
+	if (ret)
+		return ret;
+
+	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
+		dev_warn(priv->dev, "Invalid LED reg %d defined for port %d",
+			 led_group, dp->index);
+		return -EINVAL;
+	}
+
+	led = &rb->leds[dp->index][led_group];
+	led->port_num = dp->index;
+	led->led_group = led_group;
+	led->priv = priv;
+
+	state = led_init_default_state_get(led_fwnode);
+	switch (state) {
+	case LEDS_DEFSTATE_ON:
+		led->cdev.brightness = 1;
+		rb8366rb_set_port_led(led, 1);
+		break;
+	case LEDS_DEFSTATE_KEEP:
+		led->cdev.brightness =
+			rb8366rb_get_port_led(led);
+		break;
+	case LEDS_DEFSTATE_OFF:
+	default:
+		led->cdev.brightness = 0;
+		rb8366rb_set_port_led(led, 0);
+	}
+
+	led->cdev.max_brightness = 1;
+	led->cdev.brightness_set_blocking =
+		rtl8366rb_cled_brightness_set_blocking;
+	init_data.fwnode = led_fwnode;
+	init_data.devname_mandatory = true;
+
+	init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
+					 dp->ds->index, dp->index, led_group);
+	if (!init_data.devicename)
+		return -ENOMEM;
+
+	ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
+	if (ret) {
+		dev_warn(priv->dev, "Failed to init LED %d for port %d",
+			 led_group, dp->index);
+		return ret;
+	}
+
+	return 0;
+}
+
+int rtl8366rb_setup_leds(struct realtek_priv *priv)
+{
+	struct dsa_switch *ds = &priv->ds;
+	struct device_node *leds_np;
+	struct dsa_port *dp;
+	int ret = 0;
+
+	dsa_switch_for_each_port(dp, ds) {
+		if (!dp->dn)
+			continue;
+
+		leds_np = of_get_child_by_name(dp->dn, "leds");
+		if (!leds_np) {
+			dev_dbg(priv->dev, "No leds defined for port %d",
+				dp->index);
+			continue;
+		}
+
+		for_each_child_of_node_scoped(leds_np, led_np) {
+			ret = rtl8366rb_setup_led(priv, dp,
+						  of_fwnode_handle(led_np));
+			if (ret)
+				break;
+		}
+
+		of_node_put(leds_np);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index c7a8cd060587..ae3d49fc22b8 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -26,11 +26,7 @@
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
 #include "rtl83xx.h"
-
-#define RTL8366RB_PORT_NUM_CPU		5
-#define RTL8366RB_NUM_PORTS		6
-#define RTL8366RB_PHY_NO_MAX		4
-#define RTL8366RB_PHY_ADDR_MAX		31
+#include "rtl8366rb.h"
 
 /* Switch Global Configuration register */
 #define RTL8366RB_SGCR				0x0000
@@ -175,39 +171,6 @@
  */
 #define RTL8366RB_VLAN_INGRESS_CTRL2_REG	0x037f
 
-/* LED control registers */
-/* The LED blink rate is global; it is used by all triggers in all groups. */
-#define RTL8366RB_LED_BLINKRATE_REG		0x0430
-#define RTL8366RB_LED_BLINKRATE_MASK		0x0007
-#define RTL8366RB_LED_BLINKRATE_28MS		0x0000
-#define RTL8366RB_LED_BLINKRATE_56MS		0x0001
-#define RTL8366RB_LED_BLINKRATE_84MS		0x0002
-#define RTL8366RB_LED_BLINKRATE_111MS		0x0003
-#define RTL8366RB_LED_BLINKRATE_222MS		0x0004
-#define RTL8366RB_LED_BLINKRATE_446MS		0x0005
-
-/* LED trigger event for each group */
-#define RTL8366RB_LED_CTRL_REG			0x0431
-#define RTL8366RB_LED_CTRL_OFFSET(led_group)	\
-	(4 * (led_group))
-#define RTL8366RB_LED_CTRL_MASK(led_group)	\
-	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
-
-/* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
- * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
- * RTL8366RB_LEDGROUP_FORCE. Otherwise, it is ignored.
- */
-#define RTL8366RB_LED_0_1_CTRL_REG		0x0432
-#define RTL8366RB_LED_2_3_CTRL_REG		0x0433
-#define RTL8366RB_LED_X_X_CTRL_REG(led_group)	\
-	((led_group) <= 1 ? \
-		RTL8366RB_LED_0_1_CTRL_REG : \
-		RTL8366RB_LED_2_3_CTRL_REG)
-#define RTL8366RB_LED_0_X_CTRL_MASK		GENMASK(5, 0)
-#define RTL8366RB_LED_X_1_CTRL_MASK		GENMASK(11, 6)
-#define RTL8366RB_LED_2_X_CTRL_MASK		GENMASK(5, 0)
-#define RTL8366RB_LED_X_3_CTRL_MASK		GENMASK(11, 6)
-
 #define RTL8366RB_MIB_COUNT			33
 #define RTL8366RB_GLOBAL_MIB_COUNT		1
 #define RTL8366RB_MIB_COUNTER_PORT_OFFSET	0x0050
@@ -243,7 +206,6 @@
 #define RTL8366RB_PORT_STATUS_AN_MASK		0x0080
 
 #define RTL8366RB_NUM_VLANS		16
-#define RTL8366RB_NUM_LEDGROUPS		4
 #define RTL8366RB_NUM_VIDS		4096
 #define RTL8366RB_PRIORITYMAX		7
 #define RTL8366RB_NUM_FIDS		8
@@ -350,46 +312,6 @@
 #define RTL8366RB_GREEN_FEATURE_TX	BIT(0)
 #define RTL8366RB_GREEN_FEATURE_RX	BIT(2)
 
-enum rtl8366_ledgroup_mode {
-	RTL8366RB_LEDGROUP_OFF			= 0x0,
-	RTL8366RB_LEDGROUP_DUP_COL		= 0x1,
-	RTL8366RB_LEDGROUP_LINK_ACT		= 0x2,
-	RTL8366RB_LEDGROUP_SPD1000		= 0x3,
-	RTL8366RB_LEDGROUP_SPD100		= 0x4,
-	RTL8366RB_LEDGROUP_SPD10		= 0x5,
-	RTL8366RB_LEDGROUP_SPD1000_ACT		= 0x6,
-	RTL8366RB_LEDGROUP_SPD100_ACT		= 0x7,
-	RTL8366RB_LEDGROUP_SPD10_ACT		= 0x8,
-	RTL8366RB_LEDGROUP_SPD100_10_ACT	= 0x9,
-	RTL8366RB_LEDGROUP_FIBER		= 0xa,
-	RTL8366RB_LEDGROUP_AN_FAULT		= 0xb,
-	RTL8366RB_LEDGROUP_LINK_RX		= 0xc,
-	RTL8366RB_LEDGROUP_LINK_TX		= 0xd,
-	RTL8366RB_LEDGROUP_MASTER		= 0xe,
-	RTL8366RB_LEDGROUP_FORCE		= 0xf,
-
-	__RTL8366RB_LEDGROUP_MODE_MAX
-};
-
-struct rtl8366rb_led {
-	u8 port_num;
-	u8 led_group;
-	struct realtek_priv *priv;
-	struct led_classdev cdev;
-};
-
-/**
- * struct rtl8366rb - RTL8366RB-specific data
- * @max_mtu: per-port max MTU setting
- * @pvid_enabled: if PVID is set for respective port
- * @leds: per-port and per-ledgroup led info
- */
-struct rtl8366rb {
-	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
-	bool pvid_enabled[RTL8366RB_NUM_PORTS];
-	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
-};
-
 static struct rtl8366_mib_counter rtl8366rb_mib_counters[] = {
 	{ 0,  0, 4, "IfInOctets"				},
 	{ 0,  4, 4, "EtherStatsOctets"				},
@@ -830,9 +752,10 @@ static int rtl8366rb_jam_table(const struct rtl8366rb_jam_tbl_entry *jam_table,
 	return 0;
 }
 
-static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
-				      u8 led_group,
-				      enum rtl8366_ledgroup_mode mode)
+/* This code is used also with LEDs disabled */
+int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
+			       u8 led_group,
+			       enum rtl8366_ledgroup_mode mode)
 {
 	int ret;
 	u32 val;
@@ -849,144 +772,7 @@ static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
 	return 0;
 }
 
-static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
-{
-	switch (led_group) {
-	case 0:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	case 1:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	case 2:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	case 3:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	default:
-		return 0;
-	}
-}
-
-static int rb8366rb_get_port_led(struct rtl8366rb_led *led)
-{
-	struct realtek_priv *priv = led->priv;
-	u8 led_group = led->led_group;
-	u8 port_num = led->port_num;
-	int ret;
-	u32 val;
-
-	ret = regmap_read(priv->map, RTL8366RB_LED_X_X_CTRL_REG(led_group),
-			  &val);
-	if (ret) {
-		dev_err(priv->dev, "error reading LED on port %d group %d\n",
-			led_group, port_num);
-		return ret;
-	}
-
-	return !!(val & rtl8366rb_led_group_port_mask(led_group, port_num));
-}
-
-static int rb8366rb_set_port_led(struct rtl8366rb_led *led, bool enable)
-{
-	struct realtek_priv *priv = led->priv;
-	u8 led_group = led->led_group;
-	u8 port_num = led->port_num;
-	int ret;
-
-	ret = regmap_update_bits(priv->map,
-				 RTL8366RB_LED_X_X_CTRL_REG(led_group),
-				 rtl8366rb_led_group_port_mask(led_group,
-							       port_num),
-				 enable ? 0xffff : 0);
-	if (ret) {
-		dev_err(priv->dev, "error updating LED on port %d group %d\n",
-			led_group, port_num);
-		return ret;
-	}
-
-	/* Change the LED group to manual controlled LEDs if required */
-	ret = rb8366rb_set_ledgroup_mode(priv, led_group,
-					 RTL8366RB_LEDGROUP_FORCE);
-
-	if (ret) {
-		dev_err(priv->dev, "error updating LED GROUP group %d\n",
-			led_group);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int
-rtl8366rb_cled_brightness_set_blocking(struct led_classdev *ldev,
-				       enum led_brightness brightness)
-{
-	struct rtl8366rb_led *led = container_of(ldev, struct rtl8366rb_led,
-						 cdev);
-
-	return rb8366rb_set_port_led(led, brightness == LED_ON);
-}
-
-static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
-			       struct fwnode_handle *led_fwnode)
-{
-	struct rtl8366rb *rb = priv->chip_data;
-	struct led_init_data init_data = { };
-	enum led_default_state state;
-	struct rtl8366rb_led *led;
-	u32 led_group;
-	int ret;
-
-	ret = fwnode_property_read_u32(led_fwnode, "reg", &led_group);
-	if (ret)
-		return ret;
-
-	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
-		dev_warn(priv->dev, "Invalid LED reg %d defined for port %d",
-			 led_group, dp->index);
-		return -EINVAL;
-	}
-
-	led = &rb->leds[dp->index][led_group];
-	led->port_num = dp->index;
-	led->led_group = led_group;
-	led->priv = priv;
-
-	state = led_init_default_state_get(led_fwnode);
-	switch (state) {
-	case LEDS_DEFSTATE_ON:
-		led->cdev.brightness = 1;
-		rb8366rb_set_port_led(led, 1);
-		break;
-	case LEDS_DEFSTATE_KEEP:
-		led->cdev.brightness =
-			rb8366rb_get_port_led(led);
-		break;
-	case LEDS_DEFSTATE_OFF:
-	default:
-		led->cdev.brightness = 0;
-		rb8366rb_set_port_led(led, 0);
-	}
-
-	led->cdev.max_brightness = 1;
-	led->cdev.brightness_set_blocking =
-		rtl8366rb_cled_brightness_set_blocking;
-	init_data.fwnode = led_fwnode;
-	init_data.devname_mandatory = true;
-
-	init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
-					 dp->ds->index, dp->index, led_group);
-	if (!init_data.devicename)
-		return -ENOMEM;
-
-	ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
-	if (ret) {
-		dev_warn(priv->dev, "Failed to init LED %d for port %d",
-			 led_group, dp->index);
-		return ret;
-	}
-
-	return 0;
-}
-
+/* This code is used also with LEDs disabled */
 static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 {
 	int ret = 0;
@@ -1007,38 +793,6 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 	return ret;
 }
 
-static int rtl8366rb_setup_leds(struct realtek_priv *priv)
-{
-	struct dsa_switch *ds = &priv->ds;
-	struct device_node *leds_np;
-	struct dsa_port *dp;
-	int ret = 0;
-
-	dsa_switch_for_each_port(dp, ds) {
-		if (!dp->dn)
-			continue;
-
-		leds_np = of_get_child_by_name(dp->dn, "leds");
-		if (!leds_np) {
-			dev_dbg(priv->dev, "No leds defined for port %d",
-				dp->index);
-			continue;
-		}
-
-		for_each_child_of_node_scoped(leds_np, led_np) {
-			ret = rtl8366rb_setup_led(priv, dp,
-						  of_fwnode_handle(led_np));
-			if (ret)
-				break;
-		}
-
-		of_node_put(leds_np);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
 static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
diff --git a/drivers/net/dsa/realtek/rtl8366rb.h b/drivers/net/dsa/realtek/rtl8366rb.h
new file mode 100644
index 000000000000..685ff3275faa
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8366rb.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _RTL8366RB_H
+#define _RTL8366RB_H
+
+#include "realtek.h"
+
+#define RTL8366RB_PORT_NUM_CPU		5
+#define RTL8366RB_NUM_PORTS		6
+#define RTL8366RB_PHY_NO_MAX		4
+#define RTL8366RB_NUM_LEDGROUPS		4
+#define RTL8366RB_PHY_ADDR_MAX		31
+
+/* LED control registers */
+/* The LED blink rate is global; it is used by all triggers in all groups. */
+#define RTL8366RB_LED_BLINKRATE_REG		0x0430
+#define RTL8366RB_LED_BLINKRATE_MASK		0x0007
+#define RTL8366RB_LED_BLINKRATE_28MS		0x0000
+#define RTL8366RB_LED_BLINKRATE_56MS		0x0001
+#define RTL8366RB_LED_BLINKRATE_84MS		0x0002
+#define RTL8366RB_LED_BLINKRATE_111MS		0x0003
+#define RTL8366RB_LED_BLINKRATE_222MS		0x0004
+#define RTL8366RB_LED_BLINKRATE_446MS		0x0005
+
+/* LED trigger event for each group */
+#define RTL8366RB_LED_CTRL_REG			0x0431
+#define RTL8366RB_LED_CTRL_OFFSET(led_group)	\
+	(4 * (led_group))
+#define RTL8366RB_LED_CTRL_MASK(led_group)	\
+	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
+
+/* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
+ * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
+ * RTL8366RB_LEDGROUP_FORCE. Otherwise, it is ignored.
+ */
+#define RTL8366RB_LED_0_1_CTRL_REG		0x0432
+#define RTL8366RB_LED_2_3_CTRL_REG		0x0433
+#define RTL8366RB_LED_X_X_CTRL_REG(led_group)	\
+	((led_group) <= 1 ? \
+		RTL8366RB_LED_0_1_CTRL_REG : \
+		RTL8366RB_LED_2_3_CTRL_REG)
+#define RTL8366RB_LED_0_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_1_CTRL_MASK		GENMASK(11, 6)
+#define RTL8366RB_LED_2_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_3_CTRL_MASK		GENMASK(11, 6)
+
+enum rtl8366_ledgroup_mode {
+	RTL8366RB_LEDGROUP_OFF			= 0x0,
+	RTL8366RB_LEDGROUP_DUP_COL		= 0x1,
+	RTL8366RB_LEDGROUP_LINK_ACT		= 0x2,
+	RTL8366RB_LEDGROUP_SPD1000		= 0x3,
+	RTL8366RB_LEDGROUP_SPD100		= 0x4,
+	RTL8366RB_LEDGROUP_SPD10		= 0x5,
+	RTL8366RB_LEDGROUP_SPD1000_ACT		= 0x6,
+	RTL8366RB_LEDGROUP_SPD100_ACT		= 0x7,
+	RTL8366RB_LEDGROUP_SPD10_ACT		= 0x8,
+	RTL8366RB_LEDGROUP_SPD100_10_ACT	= 0x9,
+	RTL8366RB_LEDGROUP_FIBER		= 0xa,
+	RTL8366RB_LEDGROUP_AN_FAULT		= 0xb,
+	RTL8366RB_LEDGROUP_LINK_RX		= 0xc,
+	RTL8366RB_LEDGROUP_LINK_TX		= 0xd,
+	RTL8366RB_LEDGROUP_MASTER		= 0xe,
+	RTL8366RB_LEDGROUP_FORCE		= 0xf,
+
+	__RTL8366RB_LEDGROUP_MODE_MAX
+};
+
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS)
+
+struct rtl8366rb_led {
+	u8 port_num;
+	u8 led_group;
+	struct realtek_priv *priv;
+	struct led_classdev cdev;
+};
+
+int rtl8366rb_setup_leds(struct realtek_priv *priv);
+
+#else
+
+static inline int rtl8366rb_setup_leds(struct realtek_priv *priv)
+{
+	return 0;
+}
+
+#endif /* IS_ENABLED(CONFIG_LEDS_CLASS) */
+
+/**
+ * struct rtl8366rb - RTL8366RB-specific data
+ * @max_mtu: per-port max MTU setting
+ * @pvid_enabled: if PVID is set for respective port
+ * @leds: per-port and per-ledgroup led info
+ */
+struct rtl8366rb {
+	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
+	bool pvid_enabled[RTL8366RB_NUM_PORTS];
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS)
+	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
+#endif
+};
+
+/* This code is used also with LEDs disabled */
+int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
+			       u8 led_group,
+			       enum rtl8366_ledgroup_mode mode);
+
+#endif /* _RTL8366RB_H */
diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 5740c98d8c9f..2847278d9cd4 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1279,6 +1279,8 @@ struct macb {
 	struct clk		*rx_clk;
 	struct clk		*tsu_clk;
 	struct net_device	*dev;
+	/* Protects hw_stats and ethtool_stats */
+	spinlock_t		stats_lock;
 	union {
 		struct macb_stats	macb;
 		struct gem_stats	gem;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 56901280ba04..60847cdb516e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1992,10 +1992,12 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 
 		if (status & MACB_BIT(ISR_ROVR)) {
 			/* We missed at least one packet */
+			spin_lock(&bp->stats_lock);
 			if (macb_is_gem(bp))
 				bp->hw_stats.gem.rx_overruns++;
 			else
 				bp->hw_stats.macb.rx_overruns++;
+			spin_unlock(&bp->stats_lock);
 
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
@@ -3116,6 +3118,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 	if (!netif_running(bp->dev))
 		return nstat;
 
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 
 	nstat->rx_errors = (hwstat->rx_frame_check_sequence_errors +
@@ -3145,6 +3148,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 	nstat->tx_aborted_errors = hwstat->tx_excessive_collisions;
 	nstat->tx_carrier_errors = hwstat->tx_carrier_sense_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underrun;
+	spin_unlock_irq(&bp->stats_lock);
 
 	return nstat;
 }
@@ -3152,12 +3156,13 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 static void gem_get_ethtool_stats(struct net_device *dev,
 				  struct ethtool_stats *stats, u64 *data)
 {
-	struct macb *bp;
+	struct macb *bp = netdev_priv(dev);
 
-	bp = netdev_priv(dev);
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
 			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 static int gem_get_sset_count(struct net_device *dev, int sset)
@@ -3207,6 +3212,7 @@ static struct net_device_stats *macb_get_stats(struct net_device *dev)
 		return gem_get_stats(bp);
 
 	/* read stats from hardware */
+	spin_lock_irq(&bp->stats_lock);
 	macb_update_stats(bp);
 
 	/* Convert HW stats into netdevice stats */
@@ -3240,6 +3246,7 @@ static struct net_device_stats *macb_get_stats(struct net_device *dev)
 	nstat->tx_carrier_errors = hwstat->tx_carrier_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underruns;
 	/* Don't know about heartbeat or window errors... */
+	spin_unlock_irq(&bp->stats_lock);
 
 	return nstat;
 }
@@ -5110,6 +5117,7 @@ static int macb_probe(struct platform_device *pdev)
 		}
 	}
 	spin_lock_init(&bp->lock);
+	spin_lock_init(&bp->stats_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 16a7908c79f7..f662a5d54986 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -145,6 +145,24 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+/**
+ * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buffer Tx frame
+ * @tx_ring: Pointer to the Tx ring on which the buffer descriptors are located
+ * @count: Number of Tx buffer descriptors which need to be unmapped
+ * @i: Index of the last successfully mapped Tx buffer descriptor
+ */
+static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
+{
+	while (count--) {
+		struct enetc_tx_swbd *tx_swbd = &tx_ring->tx_swbd[i];
+
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	}
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -235,9 +253,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 lo, hi, val;
-			u64 sec, nsec;
+			__be32 new_sec_l, new_nsec;
+			u32 lo, hi, nsec, val;
+			__be16 new_sec_h;
 			u8 *data;
+			u64 sec;
 
 			lo = enetc_rd_hot(hw, ENETC_SICTR0);
 			hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -251,13 +271,38 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 			/* Update originTimestamp field of Sync packet
 			 * - 48 bits seconds field
 			 * - 32 bits nanseconds field
+			 *
+			 * In addition, the UDP checksum needs to be updated
+			 * by software after updating originTimestamp field,
+			 * otherwise the hardware will calculate the wrong
+			 * checksum when updating the correction field and
+			 * update it to the packet.
 			 */
 			data = skb_mac_header(skb);
-			*(__be16 *)(data + offset2) =
-				htons((sec >> 32) & 0xffff);
-			*(__be32 *)(data + offset2 + 2) =
-				htonl(sec & 0xffffffff);
-			*(__be32 *)(data + offset2 + 6) = htonl(nsec);
+			new_sec_h = htons((sec >> 32) & 0xffff);
+			new_sec_l = htonl(sec & 0xffffffff);
+			new_nsec = htonl(nsec);
+			if (udp) {
+				struct udphdr *uh = udp_hdr(skb);
+				__be32 old_sec_l, old_nsec;
+				__be16 old_sec_h;
+
+				old_sec_h = *(__be16 *)(data + offset2);
+				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+							 new_sec_h, false);
+
+				old_sec_l = *(__be32 *)(data + offset2 + 2);
+				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+							 new_sec_l, false);
+
+				old_nsec = *(__be32 *)(data + offset2 + 6);
+				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+							 new_nsec, false);
+			}
+
+			*(__be16 *)(data + offset2) = new_sec_h;
+			*(__be32 *)(data + offset2 + 2) = new_sec_l;
+			*(__be32 *)(data + offset2 + 6) = new_nsec;
 
 			/* Configure single-step register */
 			val = ENETC_PM0_SINGLE_STEP_EN;
@@ -328,25 +373,20 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 dma_err:
 	dev_err(tx_ring->dev, "DMA map error");
 
-	do {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	} while (count--);
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }
 
-static void enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
-				 struct enetc_tx_swbd *tx_swbd,
-				 union enetc_tx_bd *txbd, int *i, int hdr_len,
-				 int data_len)
+static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+				struct enetc_tx_swbd *tx_swbd,
+				union enetc_tx_bd *txbd, int *i, int hdr_len,
+				int data_len)
 {
 	union enetc_tx_bd txbd_tmp;
 	u8 flags = 0, e_flags = 0;
 	dma_addr_t addr;
+	int count = 1;
 
 	enetc_clear_tx_bd(&txbd_tmp);
 	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
@@ -389,7 +429,10 @@ static void enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 		/* Write the BD */
 		txbd_tmp.ext.e_flags = e_flags;
 		*txbd = txbd_tmp;
+		count++;
 	}
+
+	return count;
 }
 
 static int enetc_map_tx_tso_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
@@ -521,9 +564,9 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 
 		/* compute the csum over the L4 header */
 		csum = enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
-		enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i, hdr_len, data_len);
+		count += enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd,
+					      &i, hdr_len, data_len);
 		bd_data_num = 0;
-		count++;
 
 		while (data_len > 0) {
 			int size;
@@ -547,8 +590,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			err = enetc_map_tx_tso_data(tx_ring, skb, tx_swbd, txbd,
 						    tso.data, size,
 						    size == data_len);
-			if (err)
+			if (err) {
+				if (i == 0)
+					i = tx_ring->bd_count;
+				i--;
+
 				goto err_map_data;
+			}
 
 			data_len -= size;
 			count++;
@@ -577,13 +625,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 	dev_err(tx_ring->dev, "DMA map error");
 
 err_chained_bd:
-	do {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	} while (count--);
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }
@@ -1623,7 +1665,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				tx_ring->stats.xdp_tx_drops++;
 			} else {
-				tx_ring->stats.xdp_tx += xdp_tx_bd_cnt;
+				tx_ring->stats.xdp_tx++;
 				rx_ring->xdp.xdp_tx_in_flight += xdp_tx_bd_cnt;
 				xdp_tx_frm_cnt++;
 				/* The XDP_TX enqueue was successful, so we
@@ -2929,6 +2971,9 @@ static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 		new_offloads |= ENETC_F_TX_TSTAMP;
 		break;
 	case HWTSTAMP_TX_ONESTEP_SYNC:
+		if (!enetc_si_is_pf(priv->si))
+			return -EOPNOTSUPP;
+
 		new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
 		new_offloads |= ENETC_F_TX_ONESTEP_SYNC_TSTAMP;
 		break;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2563eb8ac7b6..6a24324703bf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -843,6 +843,7 @@ static int enetc_set_coalesce(struct net_device *ndev,
 static int enetc_get_ts_info(struct net_device *ndev,
 			     struct kernel_ethtool_ts_info *info)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int *phc_idx;
 
 	phc_idx = symbol_get(enetc_phc_index);
@@ -863,8 +864,10 @@ static int enetc_get_ts_info(struct net_device *ndev,
 				SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
-			 (1 << HWTSTAMP_TX_ON) |
-			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
+			 (1 << HWTSTAMP_TX_ON);
+
+	if (enetc_si_is_pf(priv->si))
+		info->tx_types |= (1 << HWTSTAMP_TX_ONESTEP_SYNC);
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 558cda577191..2960709f6b62 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -207,6 +207,7 @@ enum ice_feature {
 	ICE_F_GNSS,
 	ICE_F_ROCE_LAG,
 	ICE_F_SRIOV_LAG,
+	ICE_F_MBX_LIMIT,
 	ICE_F_MAX
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index fb527434b58b..d649c197cf67 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -38,8 +38,7 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	if (ice_vsi_add_vlan_zero(uplink_vsi))
 		goto err_vlan_zero;
 
-	if (ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, true,
-			     ICE_FLTR_RX))
+	if (ice_set_dflt_vsi(uplink_vsi))
 		goto err_def_rx;
 
 	if (ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, true,
diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 91cbae1eec89..8d31bfe28cc8 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -539,5 +539,8 @@
 #define E830_PRTMAC_CL01_QNT_THR_CL0_M		GENMASK(15, 0)
 #define VFINT_DYN_CTLN(_i)			(0x00003800 + ((_i) * 4))
 #define VFINT_DYN_CTLN_CLEARPBA_M		BIT(1)
+#define E830_MBX_PF_IN_FLIGHT_VF_MSGS_THRESH	0x00234000
+#define E830_MBX_VF_DEC_TRIG(_VF)		(0x00233800 + (_VF) * 4)
+#define E830_MBX_VF_IN_FLIGHT_MSGS_AT_PF_CNT(_VF)	(0x00233000 + (_VF) * 4)
 
 #endif /* _ICE_HW_AUTOGEN_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 06e712cdc3d9..d4e74f96a8ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3880,6 +3880,9 @@ void ice_init_feature_support(struct ice_pf *pf)
 	default:
 		break;
 	}
+
+	if (pf->hw.mac_type == ICE_MAC_E830)
+		ice_set_feature_support(pf, ICE_F_MBX_LIMIT);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 45eefe22fb5b..ca707dfcb286 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1546,12 +1546,20 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum ice_ctl_q q_type)
 			ice_vf_lan_overflow_event(pf, &event);
 			break;
 		case ice_mbx_opc_send_msg_to_pf:
-			data.num_msg_proc = i;
-			data.num_pending_arq = pending;
-			data.max_num_msgs_mbx = hw->mailboxq.num_rq_entries;
-			data.async_watermark_val = ICE_MBX_OVERFLOW_WATERMARK;
+			if (ice_is_feature_supported(pf, ICE_F_MBX_LIMIT)) {
+				ice_vc_process_vf_msg(pf, &event, NULL);
+				ice_mbx_vf_dec_trig_e830(hw, &event);
+			} else {
+				u16 val = hw->mailboxq.num_rq_entries;
+
+				data.max_num_msgs_mbx = val;
+				val = ICE_MBX_OVERFLOW_WATERMARK;
+				data.async_watermark_val = val;
+				data.num_msg_proc = i;
+				data.num_pending_arq = pending;
 
-			ice_vc_process_vf_msg(pf, &event, &data);
+				ice_vc_process_vf_msg(pf, &event, &data);
+			}
 			break;
 		case ice_aqc_opc_fw_logs_event:
 			ice_get_fwlog_data(pf, &event);
@@ -4082,7 +4090,11 @@ static int ice_init_pf(struct ice_pf *pf)
 
 	mutex_init(&pf->vfs.table_lock);
 	hash_init(pf->vfs.table);
-	ice_mbx_init_snapshot(&pf->hw);
+	if (ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
+		wr32(&pf->hw, E830_MBX_PF_IN_FLIGHT_VF_MSGS_THRESH,
+		     ICE_MBX_OVERFLOW_WATERMARK);
+	else
+		ice_mbx_init_snapshot(&pf->hw);
 
 	xa_init(&pf->dyn_ports);
 	xa_init(&pf->sf_nums);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 91cb393f616f..8aabf7749aa5 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -36,6 +36,7 @@ static void ice_free_vf_entries(struct ice_pf *pf)
 
 	hash_for_each_safe(vfs->table, bkt, tmp, vf, entry) {
 		hash_del_rcu(&vf->entry);
+		ice_deinitialize_vf_entry(vf);
 		ice_put_vf(vf);
 	}
 }
@@ -193,9 +194,6 @@ void ice_free_vfs(struct ice_pf *pf)
 			wr32(hw, GLGEN_VFLRSTAT(reg_idx), BIT(bit_idx));
 		}
 
-		/* clear malicious info since the VF is getting released */
-		list_del(&vf->mbx_info.list_entry);
-
 		mutex_unlock(&vf->cfg_lock);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 8c434689e3f7..815ad0bfe832 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -716,6 +716,23 @@ ice_vf_clear_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 promisc_m)
 	return 0;
 }
 
+/**
+ * ice_reset_vf_mbx_cnt - reset VF mailbox message count
+ * @vf: pointer to the VF structure
+ *
+ * This function clears the VF mailbox message count, and should be called on
+ * VF reset.
+ */
+static void ice_reset_vf_mbx_cnt(struct ice_vf *vf)
+{
+	struct ice_pf *pf = vf->pf;
+
+	if (ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
+		ice_mbx_vf_clear_cnt_e830(&pf->hw, vf->vf_id);
+	else
+		ice_mbx_clear_malvf(&vf->mbx_info);
+}
+
 /**
  * ice_reset_all_vfs - reset all allocated VFs in one go
  * @pf: pointer to the PF structure
@@ -742,7 +759,7 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 
 	/* clear all malicious info if the VFs are getting reset */
 	ice_for_each_vf(pf, bkt, vf)
-		ice_mbx_clear_malvf(&vf->mbx_info);
+		ice_reset_vf_mbx_cnt(vf);
 
 	/* If VFs have been disabled, there is no need to reset */
 	if (test_and_set_bit(ICE_VF_DIS, pf->state)) {
@@ -958,7 +975,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 	ice_eswitch_update_repr(&vf->repr_id, vsi);
 
 	/* if the VF has been reset allow it to come up again */
-	ice_mbx_clear_malvf(&vf->mbx_info);
+	ice_reset_vf_mbx_cnt(vf);
 
 out_unlock:
 	if (lag && lag->bonded && lag->primary &&
@@ -1011,11 +1028,22 @@ void ice_initialize_vf_entry(struct ice_vf *vf)
 	ice_vf_fdir_init(vf);
 
 	/* Initialize mailbox info for this VF */
-	ice_mbx_init_vf_info(&pf->hw, &vf->mbx_info);
+	if (ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
+		ice_mbx_vf_clear_cnt_e830(&pf->hw, vf->vf_id);
+	else
+		ice_mbx_init_vf_info(&pf->hw, &vf->mbx_info);
 
 	mutex_init(&vf->cfg_lock);
 }
 
+void ice_deinitialize_vf_entry(struct ice_vf *vf)
+{
+	struct ice_pf *pf = vf->pf;
+
+	if (!ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
+		list_del(&vf->mbx_info.list_entry);
+}
+
 /**
  * ice_dis_vf_qs - Disable the VF queues
  * @vf: pointer to the VF structure
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
index 0c7e77c0a09f..5392b0404986 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
@@ -24,6 +24,7 @@
 #endif
 
 void ice_initialize_vf_entry(struct ice_vf *vf);
+void ice_deinitialize_vf_entry(struct ice_vf *vf);
 void ice_dis_vf_qs(struct ice_vf *vf);
 int ice_check_vf_init(struct ice_vf *vf);
 enum virtchnl_status_code ice_err_to_virt_err(int err);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_mbx.c b/drivers/net/ethernet/intel/ice/ice_vf_mbx.c
index 40cb4ba0789c..75c8113e58ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_mbx.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_mbx.c
@@ -210,6 +210,38 @@ ice_mbx_detect_malvf(struct ice_hw *hw, struct ice_mbx_vf_info *vf_info,
 	return 0;
 }
 
+/**
+ * ice_mbx_vf_dec_trig_e830 - Decrements the VF mailbox queue counter
+ * @hw: pointer to the HW struct
+ * @event: pointer to the control queue receive event
+ *
+ * This function triggers to decrement the counter
+ * MBX_VF_IN_FLIGHT_MSGS_AT_PF_CNT when the driver replenishes
+ * the buffers at the PF mailbox queue.
+ */
+void ice_mbx_vf_dec_trig_e830(const struct ice_hw *hw,
+			      const struct ice_rq_event_info *event)
+{
+	u16 vfid = le16_to_cpu(event->desc.retval);
+
+	wr32(hw, E830_MBX_VF_DEC_TRIG(vfid), 1);
+}
+
+/**
+ * ice_mbx_vf_clear_cnt_e830 - Clear the VF mailbox queue count
+ * @hw: pointer to the HW struct
+ * @vf_id: VF ID in the PF space
+ *
+ * This function clears the counter MBX_VF_IN_FLIGHT_MSGS_AT_PF_CNT, and should
+ * be called when a VF is created and on VF reset.
+ */
+void ice_mbx_vf_clear_cnt_e830(const struct ice_hw *hw, u16 vf_id)
+{
+	u32 reg = rd32(hw, E830_MBX_VF_IN_FLIGHT_MSGS_AT_PF_CNT(vf_id));
+
+	wr32(hw, E830_MBX_VF_DEC_TRIG(vf_id), reg);
+}
+
 /**
  * ice_mbx_vf_state_handler - Handle states of the overflow algorithm
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_mbx.h b/drivers/net/ethernet/intel/ice/ice_vf_mbx.h
index 44bc030d17e0..684de89e5c5e 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_mbx.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_mbx.h
@@ -19,6 +19,9 @@ ice_aq_send_msg_to_vf(struct ice_hw *hw, u16 vfid, u32 v_opcode, u32 v_retval,
 		      u8 *msg, u16 msglen, struct ice_sq_cd *cd);
 
 u32 ice_conv_link_speed_to_virtchnl(bool adv_link_support, u16 link_speed);
+void ice_mbx_vf_dec_trig_e830(const struct ice_hw *hw,
+			      const struct ice_rq_event_info *event);
+void ice_mbx_vf_clear_cnt_e830(const struct ice_hw *hw, u16 vf_id);
 int
 ice_mbx_vf_state_handler(struct ice_hw *hw, struct ice_mbx_data *mbx_data,
 			 struct ice_mbx_vf_info *vf_info, bool *report_malvf);
@@ -47,5 +50,11 @@ static inline void ice_mbx_init_snapshot(struct ice_hw *hw)
 {
 }
 
+static inline void
+ice_mbx_vf_dec_trig_e830(const struct ice_hw *hw,
+			 const struct ice_rq_event_info *event)
+{
+}
+
 #endif /* CONFIG_PCI_IOV */
 #endif /* _ICE_VF_MBX_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index b6ec01f6fa73..c8c1d48ff793 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -4008,8 +4008,10 @@ ice_is_malicious_vf(struct ice_vf *vf, struct ice_mbx_data *mbxdata)
  * @event: pointer to the AQ event
  * @mbxdata: information used to detect VF attempting mailbox overflow
  *
- * called from the common asq/arq handler to
- * process request from VF
+ * Called from the common asq/arq handler to process request from VF. When this
+ * flow is used for devices with hardware VF to PF message queue overflow
+ * support (ICE_F_MBX_LIMIT) mbxdata is set to NULL and ice_is_malicious_vf
+ * check is skipped.
  */
 void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 			   struct ice_mbx_data *mbxdata)
@@ -4035,7 +4037,7 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 	mutex_lock(&vf->cfg_lock);
 
 	/* Check if the VF is trying to overflow the mailbox */
-	if (ice_is_malicious_vf(vf, mbxdata))
+	if (mbxdata && ice_is_malicious_vf(vf, mbxdata))
 		goto finish;
 
 	/* Check if VF is disabled. */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 1e0d1f9b07fb..afc902ae4763 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3013,7 +3013,6 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	skb_shinfo(skb)->gso_size = rsc_seg_len;
 
 	skb_reset_network_header(skb);
-	len = skb->len - skb_transport_offset(skb);
 
 	if (ipv4) {
 		struct iphdr *ipv4h = ip_hdr(skb);
@@ -3022,6 +3021,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 
 		/* Reset and set transport header offset in skb */
 		skb_set_transport_header(skb, sizeof(struct iphdr));
+		len = skb->len - skb_transport_offset(skb);
 
 		/* Compute the TCP pseudo header checksum*/
 		tcp_hdr(skb)->check =
@@ -3031,6 +3031,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 
 		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
 		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+		len = skb->len - skb_transport_offset(skb);
 		tcp_hdr(skb)->check =
 			~tcp_v6_check(len, &ipv6h->saddr, &ipv6h->daddr, 0);
 	}
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 1641791a2d5b..8ed83fb98862 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -324,7 +324,7 @@ static const struct mvpp2_cls_flow cls_flows[MVPP2_N_PRS_FLOWS] = {
 		       MVPP2_PRS_RI_VLAN_MASK),
 	/* Non IP flow, with vlan tag */
 	MVPP2_DEF_FLOW(MVPP22_FLOW_ETHERNET, MVPP2_FL_NON_IP_TAG,
-		       MVPP22_CLS_HEK_OPT_VLAN,
+		       MVPP22_CLS_HEK_TAGGED,
 		       0, 0),
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 7db9cab9bedf..d9362eabc6a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -572,7 +572,7 @@ irq_pool_alloc(struct mlx5_core_dev *dev, int start, int size, char *name,
 	pool->min_threshold = min_threshold * MLX5_EQ_REFS_PER_IRQ;
 	pool->max_threshold = max_threshold * MLX5_EQ_REFS_PER_IRQ;
 	mlx5_core_dbg(dev, "pool->name = %s, pool->size = %d, pool->start = %d",
-		      name, size, start);
+		      name ? name : "mlx5_pcif_pool", size, start);
 	return pool;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index bfe6e2d631bd..f5acfb7d4ff6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -516,6 +516,19 @@ static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
 	return 0;
 }
 
+/* Loongson's DWMAC device may take nearly two seconds to complete DMA reset */
+static int loongson_dwmac_fix_reset(void *priv, void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr + DMA_BUS_MODE);
+
+	value |= DMA_BUS_MODE_SFT_RESET;
+	writel(value, ioaddr + DMA_BUS_MODE);
+
+	return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
+				  !(value & DMA_BUS_MODE_SFT_RESET),
+				  10000, 2000000);
+}
+
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
@@ -566,6 +579,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	plat->bsp_priv = ld;
 	plat->setup = loongson_dwmac_setup;
+	plat->fix_soc_reset = loongson_dwmac_fix_reset;
 	ld->dev = &pdev->dev;
 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
 
diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 0d5a862cd78a..3a13d60a947a 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -99,6 +99,7 @@ config TI_K3_AM65_CPSW_NUSS
 	select NET_DEVLINK
 	select TI_DAVINCI_MDIO
 	select PHYLINK
+	select PAGE_POOL
 	select TI_K3_CPPI_DESC_POOL
 	imply PHY_TI_GMII_SEL
 	depends on TI_K3_AM65_CPTS || !TI_K3_AM65_CPTS
diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 768578c0d958..d59c1744840a 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -474,26 +474,7 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 static int icss_iep_perout_enable(struct icss_iep *iep,
 				  struct ptp_perout_request *req, int on)
 {
-	int ret = 0;
-
-	mutex_lock(&iep->ptp_clk_mutex);
-
-	if (iep->pps_enabled) {
-		ret = -EBUSY;
-		goto exit;
-	}
-
-	if (iep->perout_enabled == !!on)
-		goto exit;
-
-	ret = icss_iep_perout_enable_hw(iep, req, on);
-	if (!ret)
-		iep->perout_enabled = !!on;
-
-exit:
-	mutex_unlock(&iep->ptp_clk_mutex);
-
-	return ret;
+	return -EOPNOTSUPP;
 }
 
 static void icss_iep_cap_cmp_work(struct work_struct *work)
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index b1afcb8740de..ca62188a317a 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -3,6 +3,7 @@
  */
 
 #include <net/inet_dscp.h>
+#include <net/ip.h>
 
 #include "ipvlan.h"
 
@@ -415,20 +416,25 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 
 static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 {
-	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net_device *dev = skb->dev;
 	struct net *net = dev_net(dev);
-	struct rtable *rt;
 	int err, ret = NET_XMIT_DROP;
+	const struct iphdr *ip4h;
+	struct rtable *rt;
 	struct flowi4 fl4 = {
 		.flowi4_oif = dev->ifindex,
-		.flowi4_tos = ip4h->tos & INET_DSCP_MASK,
 		.flowi4_flags = FLOWI_FLAG_ANYSRC,
 		.flowi4_mark = skb->mark,
-		.daddr = ip4h->daddr,
-		.saddr = ip4h->saddr,
 	};
 
+	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+		goto err;
+
+	ip4h = ip_hdr(skb);
+	fl4.daddr = ip4h->daddr;
+	fl4.saddr = ip4h->saddr;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip4h));
+
 	rt = ip_route_output_flow(net, &fl4, NULL);
 	if (IS_ERR(rt))
 		goto err;
@@ -487,6 +493,12 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 	struct net_device *dev = skb->dev;
 	int err, ret = NET_XMIT_DROP;
 
+	if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr))) {
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return ret;
+	}
+
 	err = ipvlan_route_v6_outbound(dev, skb);
 	if (unlikely(err)) {
 		DEV_STATS_INC(dev, tx_errors);
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 1993b90b1a5f..491e56b3263f 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -244,8 +244,22 @@ static netdev_tx_t blackhole_netdev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static int blackhole_neigh_output(struct neighbour *n, struct sk_buff *skb)
+{
+	kfree_skb(skb);
+	return 0;
+}
+
+static int blackhole_neigh_construct(struct net_device *dev,
+				     struct neighbour *n)
+{
+	n->output = blackhole_neigh_output;
+	return 0;
+}
+
 static const struct net_device_ops blackhole_netdev_ops = {
 	.ndo_start_xmit = blackhole_netdev_xmit,
+	.ndo_neigh_construct = blackhole_neigh_construct,
 };
 
 /* This is a dst-dummy device used specifically for invalidated
diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index bd8a51ec0ecd..ec336c3e338d 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -774,7 +774,7 @@ static int qca807x_config_init(struct phy_device *phydev)
 	control_dac &= ~QCA807X_CONTROL_DAC_MASK;
 	if (!priv->dac_full_amplitude)
 		control_dac |= QCA807X_CONTROL_DAC_DSP_AMPLITUDE;
-	if (!priv->dac_full_amplitude)
+	if (!priv->dac_full_bias_current)
 		control_dac |= QCA807X_CONTROL_DAC_DSP_BIAS_CURRENT;
 	if (!priv->dac_disable_bias_current_tweak)
 		control_dac |= QCA807X_CONTROL_DAC_BIAS_CURRENT_TWEAK;
diff --git a/drivers/net/usb/gl620a.c b/drivers/net/usb/gl620a.c
index 46af78caf457..0bfa37c14059 100644
--- a/drivers/net/usb/gl620a.c
+++ b/drivers/net/usb/gl620a.c
@@ -179,9 +179,7 @@ static int genelink_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	dev->hard_mtu = GL_RCV_BUF_SIZE;
 	dev->net->hard_header_len += 4;
-	dev->in = usb_rcvbulkpipe(dev->udev, dev->driver_info->in);
-	dev->out = usb_sndbulkpipe(dev->udev, dev->driver_info->out);
-	return 0;
+	return usbnet_get_endpoints(dev, intf);
 }
 
 static const struct driver_info	genelink_info = {
diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 2f7a05f21dc5..dcb8e1628632 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -125,6 +125,7 @@ config PHY_ROCKCHIP_USBDP
 	depends on ARCH_ROCKCHIP && OF
 	depends on TYPEC
 	select GENERIC_PHY
+	select USB_COMMON
 	help
 	  Enable this to support the Rockchip USB3.0/DP combo PHY with
 	  Samsung IP block. This is required for USB3 support on RK3588.
diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 2eb3329ca23f..1ef6d9630f7e 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -309,7 +309,10 @@ static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy
 
 	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
 
-	priv->phy_rst = devm_reset_control_get(dev, "phy");
+	priv->phy_rst = devm_reset_control_get_exclusive(dev, "phy");
+	/* fallback to old behaviour */
+	if (PTR_ERR(priv->phy_rst) == -ENOENT)
+		priv->phy_rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(priv->phy_rst))
 		return dev_err_probe(dev, PTR_ERR(priv->phy_rst), "failed to get phy reset\n");
 
diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index c421b495eb0f..46b8f6987c62 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -488,9 +488,9 @@ exynos5_usbdrd_pipe3_set_refclk(struct phy_usb_instance *inst)
 	reg |=	PHYCLKRST_REFCLKSEL_EXT_REFCLK;
 
 	/* FSEL settings corresponding to reference clock */
-	reg &= ~PHYCLKRST_FSEL_PIPE_MASK |
-		PHYCLKRST_MPLL_MULTIPLIER_MASK |
-		PHYCLKRST_SSC_REFCLKSEL_MASK;
+	reg &= ~(PHYCLKRST_FSEL_PIPE_MASK |
+		 PHYCLKRST_MPLL_MULTIPLIER_MASK |
+		 PHYCLKRST_SSC_REFCLKSEL_MASK);
 	switch (phy_drd->extrefclk) {
 	case EXYNOS5_FSEL_50MHZ:
 		reg |= (PHYCLKRST_MPLL_MULTIPLIER_50M_REF |
@@ -532,9 +532,9 @@ exynos5_usbdrd_utmi_set_refclk(struct phy_usb_instance *inst)
 	reg &= ~PHYCLKRST_REFCLKSEL_MASK;
 	reg |=	PHYCLKRST_REFCLKSEL_EXT_REFCLK;
 
-	reg &= ~PHYCLKRST_FSEL_UTMI_MASK |
-		PHYCLKRST_MPLL_MULTIPLIER_MASK |
-		PHYCLKRST_SSC_REFCLKSEL_MASK;
+	reg &= ~(PHYCLKRST_FSEL_UTMI_MASK |
+		 PHYCLKRST_MPLL_MULTIPLIER_MASK |
+		 PHYCLKRST_SSC_REFCLKSEL_MASK);
 	reg |= PHYCLKRST_FSEL(phy_drd->extrefclk);
 
 	return reg;
@@ -1296,14 +1296,17 @@ static int exynos5_usbdrd_gs101_phy_exit(struct phy *phy)
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 	int ret;
 
+	if (inst->phy_cfg->id == EXYNOS5_DRDPHY_UTMI) {
+		ret = exynos850_usbdrd_phy_exit(phy);
+		if (ret)
+			return ret;
+	}
+
+	exynos5_usbdrd_phy_isol(inst, true);
+
 	if (inst->phy_cfg->id != EXYNOS5_DRDPHY_UTMI)
 		return 0;
 
-	ret = exynos850_usbdrd_phy_exit(phy);
-	if (ret)
-		return ret;
-
-	exynos5_usbdrd_phy_isol(inst, true);
 	return regulator_bulk_disable(phy_drd->drv_data->n_regulators,
 				      phy_drd->regulators);
 }
diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 0f60d5d1c167..fae6242aa730 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -928,6 +928,7 @@ static int tegra186_utmi_phy_init(struct phy *phy)
 	unsigned int index = lane->index;
 	struct device *dev = padctl->dev;
 	int err;
+	u32 reg;
 
 	port = tegra_xusb_find_usb2_port(padctl, index);
 	if (!port) {
@@ -935,6 +936,16 @@ static int tegra186_utmi_phy_init(struct phy *phy)
 		return -ENODEV;
 	}
 
+	if (port->mode == USB_DR_MODE_OTG ||
+	    port->mode == USB_DR_MODE_PERIPHERAL) {
+		/* reset VBUS&ID OVERRIDE */
+		reg = padctl_readl(padctl, USB2_VBUS_ID);
+		reg &= ~VBUS_OVERRIDE;
+		reg &= ~ID_OVERRIDE(~0);
+		reg |= ID_OVERRIDE_FLOATING;
+		padctl_writel(padctl, reg, USB2_VBUS_ID);
+	}
+
 	if (port->supply && port->mode == USB_DR_MODE_HOST) {
 		err = regulator_enable(port->supply);
 		if (err) {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c9dde1ac9523..3023b07dc483 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1653,13 +1653,6 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 	if (in_flight)
 		__set_bit(SCMD_STATE_INFLIGHT, &cmd->state);
 
-	/*
-	 * Only clear the driver-private command data if the LLD does not supply
-	 * a function to initialize that data.
-	 */
-	if (!shost->hostt->init_cmd_priv)
-		memset(cmd + 1, 0, shost->hostt->cmd_size);
-
 	cmd->prot_op = SCSI_PROT_NORMAL;
 	if (blk_rq_bytes(req))
 		cmd->sc_data_direction = rq_dma_dir(req);
@@ -1826,6 +1819,13 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!scsi_host_queue_ready(q, shost, sdev, cmd))
 		goto out_dec_target_busy;
 
+	/*
+	 * Only clear the driver-private command data if the LLD does not supply
+	 * a function to initialize that data.
+	 */
+	if (shost->hostt->cmd_size && !shost->hostt->init_cmd_priv)
+		memset(cmd + 1, 0, shost->hostt->cmd_size);
+
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		ret = scsi_prepare_cmd(req);
 		if (ret != BLK_STS_OK)
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 863e7a4272e6..b887e48e8c7e 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -67,6 +67,7 @@ static void bang_bang_control(struct thermal_zone_device *tz,
 			      const struct thermal_trip *trip,
 			      bool crossed_up)
 {
+	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *instance;
 
 	lockdep_assert_held(&tz->lock);
@@ -75,10 +76,8 @@ static void bang_bang_control(struct thermal_zone_device *tz,
 		thermal_zone_trip_id(tz, trip), trip->temperature,
 		tz->temperature, trip->hysteresis);
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip == trip)
-			bang_bang_set_instance_target(instance, crossed_up);
-	}
+	list_for_each_entry(instance, &td->thermal_instances, trip_node)
+		bang_bang_set_instance_target(instance, crossed_up);
 }
 
 static void bang_bang_manage(struct thermal_zone_device *tz)
@@ -104,8 +103,8 @@ static void bang_bang_manage(struct thermal_zone_device *tz)
 		 * to the thermal zone temperature and the trip point threshold.
 		 */
 		turn_on = tz->temperature >= td->threshold;
-		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-			if (!instance->initialized && instance->trip == trip)
+		list_for_each_entry(instance, &td->thermal_instances, trip_node) {
+			if (!instance->initialized)
 				bang_bang_set_instance_target(instance, turn_on);
 		}
 	}
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index ce0ea571ed67..d37d57d48c38 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -44,7 +44,7 @@ static int get_trip_level(struct thermal_zone_device *tz)
 /**
  * fair_share_throttle - throttles devices associated with the given zone
  * @tz: thermal_zone_device
- * @trip: trip point
+ * @td: trip point descriptor
  * @trip_level: number of trips crossed by the zone temperature
  *
  * Throttling Logic: This uses three parameters to calculate the new
@@ -61,29 +61,23 @@ static int get_trip_level(struct thermal_zone_device *tz)
  * new_state of cooling device = P3 * P2 * P1
  */
 static void fair_share_throttle(struct thermal_zone_device *tz,
-				const struct thermal_trip *trip,
+				const struct thermal_trip_desc *td,
 				int trip_level)
 {
 	struct thermal_instance *instance;
 	int total_weight = 0;
 	int nr_instances = 0;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
-			continue;
-
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		total_weight += instance->weight;
 		nr_instances++;
 	}
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		struct thermal_cooling_device *cdev = instance->cdev;
 		u64 dividend;
 		u32 divisor;
 
-		if (instance->trip != trip)
-			continue;
-
 		dividend = trip_level;
 		dividend *= cdev->max_state;
 		divisor = tz->num_trips;
@@ -116,7 +110,7 @@ static void fair_share_manage(struct thermal_zone_device *tz)
 		    trip->type == THERMAL_TRIP_HOT)
 			continue;
 
-		fair_share_throttle(tz, trip, trip_level);
+		fair_share_throttle(tz, td, trip_level);
 	}
 }
 
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 1b2345a697c5..90b4bfd9237b 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -97,11 +97,9 @@ struct power_allocator_params {
 	struct power_actor *power;
 };
 
-static bool power_actor_is_valid(struct power_allocator_params *params,
-				 struct thermal_instance *instance)
+static bool power_actor_is_valid(struct thermal_instance *instance)
 {
-	return (instance->trip == params->trip_max &&
-		 cdev_is_power_actor(instance->cdev));
+	return cdev_is_power_actor(instance->cdev);
 }
 
 /**
@@ -118,13 +116,14 @@ static bool power_actor_is_valid(struct power_allocator_params *params,
 static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 {
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
 	struct thermal_cooling_device *cdev;
 	struct thermal_instance *instance;
 	u32 sustainable_power = 0;
 	u32 min_power;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (!power_actor_is_valid(params, instance))
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
+		if (!power_actor_is_valid(instance))
 			continue;
 
 		cdev = instance->cdev;
@@ -364,7 +363,7 @@ static void divvy_up_power(struct power_actor *power, int num_actors,
 
 	for (i = 0; i < num_actors; i++) {
 		struct power_actor *pa = &power[i];
-		u64 req_range = (u64)pa->req_power * power_range;
+		u64 req_range = (u64)pa->weighted_req_power * power_range;
 
 		pa->granted_power = DIV_ROUND_CLOSEST_ULL(req_range,
 							  total_req_power);
@@ -400,6 +399,7 @@ static void divvy_up_power(struct power_actor *power, int num_actors,
 static void allocate_power(struct thermal_zone_device *tz, int control_temp)
 {
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
 	unsigned int num_actors = params->num_actors;
 	struct power_actor *power = params->power;
 	struct thermal_cooling_device *cdev;
@@ -417,10 +417,10 @@ static void allocate_power(struct thermal_zone_device *tz, int control_temp)
 	/* Clean all buffers for new power estimations */
 	memset(power, 0, params->buffer_size);
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		struct power_actor *pa = &power[i];
 
-		if (!power_actor_is_valid(params, instance))
+		if (!power_actor_is_valid(instance))
 			continue;
 
 		cdev = instance->cdev;
@@ -454,10 +454,10 @@ static void allocate_power(struct thermal_zone_device *tz, int control_temp)
 		       power_range);
 
 	i = 0;
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		struct power_actor *pa = &power[i];
 
-		if (!power_actor_is_valid(params, instance))
+		if (!power_actor_is_valid(instance))
 			continue;
 
 		power_actor_set_power(instance->cdev, instance,
@@ -538,12 +538,13 @@ static void reset_pid_controller(struct power_allocator_params *params)
 static void allow_maximum_power(struct thermal_zone_device *tz)
 {
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
 	struct thermal_cooling_device *cdev;
 	struct thermal_instance *instance;
 	u32 req_power;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (!power_actor_is_valid(params, instance))
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
+		if (!power_actor_is_valid(instance))
 			continue;
 
 		cdev = instance->cdev;
@@ -581,13 +582,16 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 static int check_power_actors(struct thermal_zone_device *tz,
 			      struct power_allocator_params *params)
 {
+	const struct thermal_trip_desc *td;
 	struct thermal_instance *instance;
 	int ret = 0;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != params->trip_max)
-			continue;
+	if (!params->trip_max)
+		return 0;
+
+	td = trip_to_trip_desc(params->trip_max);
 
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		if (!cdev_is_power_actor(instance->cdev)) {
 			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
 				 instance->cdev->type);
@@ -631,30 +635,43 @@ static int allocate_actors_buffer(struct power_allocator_params *params,
 	return ret;
 }
 
+static void power_allocator_update_weight(struct power_allocator_params *params)
+{
+	const struct thermal_trip_desc *td;
+	struct thermal_instance *instance;
+
+	if (!params->trip_max)
+		return;
+
+	td = trip_to_trip_desc(params->trip_max);
+
+	params->total_weight = 0;
+	list_for_each_entry(instance, &td->thermal_instances, trip_node)
+		if (power_actor_is_valid(instance))
+			params->total_weight += instance->weight;
+}
+
 static void power_allocator_update_tz(struct thermal_zone_device *tz,
 				      enum thermal_notify_event reason)
 {
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip_desc *td = trip_to_trip_desc(params->trip_max);
 	struct thermal_instance *instance;
 	int num_actors = 0;
 
 	switch (reason) {
 	case THERMAL_TZ_BIND_CDEV:
 	case THERMAL_TZ_UNBIND_CDEV:
-		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-			if (power_actor_is_valid(params, instance))
+		list_for_each_entry(instance, &td->thermal_instances, trip_node)
+			if (power_actor_is_valid(instance))
 				num_actors++;
 
-		if (num_actors == params->num_actors)
-			return;
+		if (num_actors != params->num_actors)
+			allocate_actors_buffer(params, num_actors);
 
-		allocate_actors_buffer(params, num_actors);
-		break;
+		fallthrough;
 	case THERMAL_INSTANCE_WEIGHT_CHANGED:
-		params->total_weight = 0;
-		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-			if (power_actor_is_valid(params, instance))
-				params->total_weight += instance->weight;
+		power_allocator_update_weight(params);
 		break;
 	default:
 		break;
@@ -720,6 +737,8 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 
 	tz->governor_data = params;
 
+	power_allocator_update_weight(params);
+
 	return 0;
 
 free_params:
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index fd5527188cf9..ea4bf88d37f3 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -66,9 +66,10 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 }
 
 static void thermal_zone_trip_update(struct thermal_zone_device *tz,
-				     const struct thermal_trip *trip,
+				     const struct thermal_trip_desc *td,
 				     int trip_threshold)
 {
+	const struct thermal_trip *trip = &td->trip;
 	enum thermal_trend trend = get_tz_trend(tz, trip);
 	int trip_id = thermal_zone_trip_id(tz, trip);
 	struct thermal_instance *instance;
@@ -82,12 +83,9 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
 		trip_id, trip->type, trip_threshold, trend, throttle);
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
 		int old_target;
 
-		if (instance->trip != trip)
-			continue;
-
 		old_target = instance->target;
 		instance->target = get_target_state(instance, trend, throttle);
 
@@ -127,11 +125,13 @@ static void step_wise_manage(struct thermal_zone_device *tz)
 		    trip->type == THERMAL_TRIP_HOT)
 			continue;
 
-		thermal_zone_trip_update(tz, trip, td->threshold);
+		thermal_zone_trip_update(tz, td, td->threshold);
 	}
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		thermal_cdev_update(instance->cdev);
+	for_each_trip_desc(tz, td) {
+		list_for_each_entry(instance, &td->thermal_instances, trip_node)
+			thermal_cdev_update(instance->cdev);
+	}
 }
 
 static struct thermal_governor thermal_gov_step_wise = {
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 1d2f2b307bac..c2fa236e10cd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -490,7 +490,7 @@ static void thermal_zone_device_check(struct work_struct *work)
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
-	struct thermal_instance *pos;
+	struct thermal_trip_desc *td;
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
@@ -498,8 +498,12 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 	tz->passive = 0;
 	tz->prev_low_trip = -INT_MAX;
 	tz->prev_high_trip = INT_MAX;
-	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
-		pos->initialized = false;
+	for_each_trip_desc(tz, td) {
+		struct thermal_instance *instance;
+
+		list_for_each_entry(instance, &td->thermal_instances, trip_node)
+			instance->initialized = false;
+	}
 }
 
 static void thermal_governor_trip_crossed(struct thermal_governor *governor,
@@ -764,12 +768,12 @@ struct thermal_zone_device *thermal_zone_get_by_id(int id)
  * Return: 0 on success, the proper error value otherwise.
  */
 static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-				     const struct thermal_trip *trip,
+				     struct thermal_trip *trip,
 				     struct thermal_cooling_device *cdev,
 				     struct cooling_spec *cool_spec)
 {
-	struct thermal_instance *dev;
-	struct thermal_instance *pos;
+	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+	struct thermal_instance *dev, *instance;
 	bool upper_no_limit;
 	int result;
 
@@ -832,13 +836,13 @@ static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 		goto remove_trip_file;
 
 	mutex_lock(&cdev->lock);
-	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
-		if (pos->trip == trip && pos->cdev == cdev) {
+	list_for_each_entry(instance, &td->thermal_instances, trip_node)
+		if (instance->cdev == cdev) {
 			result = -EEXIST;
 			break;
 		}
 	if (!result) {
-		list_add_tail(&dev->tz_node, &tz->thermal_instances);
+		list_add_tail(&dev->trip_node, &td->thermal_instances);
 		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
 		atomic_set(&tz->need_update, 1);
 
@@ -872,15 +876,16 @@ static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
  * This function is usually called in the thermal zone device .unbind callback.
  */
 static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-					  const struct thermal_trip *trip,
+					  struct thermal_trip *trip,
 					  struct thermal_cooling_device *cdev)
 {
+	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
 
 	mutex_lock(&cdev->lock);
-	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
-		if (pos->trip == trip && pos->cdev == cdev) {
-			list_del(&pos->tz_node);
+	list_for_each_entry_safe(pos, next, &td->thermal_instances, trip_node) {
+		if (pos->cdev == cdev) {
+			list_del(&pos->trip_node);
 			list_del(&pos->cdev_node);
 
 			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
@@ -1435,7 +1440,6 @@ thermal_zone_device_register_with_trips(const char *type,
 		}
 	}
 
-	INIT_LIST_HEAD(&tz->thermal_instances);
 	INIT_LIST_HEAD(&tz->node);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
@@ -1459,6 +1463,7 @@ thermal_zone_device_register_with_trips(const char *type,
 	tz->num_trips = num_trips;
 	for_each_trip_desc(tz, td) {
 		td->trip = *trip++;
+		INIT_LIST_HEAD(&td->thermal_instances);
 		/*
 		 * Mark all thresholds as invalid to start with even though
 		 * this only matters for the trips that start as invalid and
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 421522a2bb9d..163871699a60 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -30,6 +30,7 @@ struct thermal_trip_desc {
 	struct thermal_trip trip;
 	struct thermal_trip_attrs trip_attrs;
 	struct list_head notify_list_node;
+	struct list_head thermal_instances;
 	int notify_temp;
 	int threshold;
 };
@@ -99,7 +100,6 @@ struct thermal_governor {
  * @tzp:	thermal zone parameters
  * @governor:	pointer to the governor for this thermal zone
  * @governor_data:	private pointer for governor data
- * @thermal_instances:	list of &struct thermal_instance of this thermal zone
  * @ida:	&struct ida to generate unique id for this zone's cooling
  *		devices
  * @lock:	lock to protect thermal_instances list
@@ -133,7 +133,6 @@ struct thermal_zone_device {
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
 	void *governor_data;
-	struct list_head thermal_instances;
 	struct ida ida;
 	struct mutex lock;
 	struct list_head node;
@@ -230,7 +229,7 @@ struct thermal_instance {
 	struct device_attribute attr;
 	char weight_attr_name[THERMAL_NAME_LENGTH];
 	struct device_attribute weight_attr;
-	struct list_head tz_node; /* node in tz->thermal_instances */
+	struct list_head trip_node; /* node in trip->thermal_instances */
 	struct list_head cdev_node; /* node in cdev->thermal_instances */
 	unsigned int weight; /* The weight of the cooling device */
 	bool upper_no_limit;
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index dc374a7a1a65..403d62d3ce77 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -43,10 +43,11 @@ static bool thermal_instance_present(struct thermal_zone_device *tz,
 				     struct thermal_cooling_device *cdev,
 				     const struct thermal_trip *trip)
 {
+	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *ti;
 
-	list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
-		if (ti->trip == trip && ti->cdev == cdev)
+	list_for_each_entry(ti, &td->thermal_instances, trip_node) {
+		if (ti->cdev == cdev)
 			return true;
 	}
 
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5d3d8ce672cd..e0aa9d9d5604 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -293,12 +293,40 @@ static bool thermal_of_get_cooling_spec(struct device_node *map_np, int index,
 	return true;
 }
 
+static bool thermal_of_cm_lookup(struct device_node *cm_np,
+				 const struct thermal_trip *trip,
+				 struct thermal_cooling_device *cdev,
+				 struct cooling_spec *c)
+{
+	for_each_child_of_node_scoped(cm_np, child) {
+		struct device_node *tr_np;
+		int count, i;
+
+		tr_np = of_parse_phandle(child, "trip", 0);
+		if (tr_np != trip->priv)
+			continue;
+
+		/* The trip has been found, look up the cdev. */
+		count = of_count_phandle_with_args(child, "cooling-device",
+						   "#cooling-cells");
+		if (count <= 0)
+			pr_err("Add a cooling_device property with at least one device\n");
+
+		for (i = 0; i < count; i++) {
+			if (thermal_of_get_cooling_spec(child, i, cdev, c))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static bool thermal_of_should_bind(struct thermal_zone_device *tz,
 				   const struct thermal_trip *trip,
 				   struct thermal_cooling_device *cdev,
 				   struct cooling_spec *c)
 {
-	struct device_node *tz_np, *cm_np, *child;
+	struct device_node *tz_np, *cm_np;
 	bool result = false;
 
 	tz_np = thermal_of_zone_get_by_name(tz);
@@ -312,28 +340,7 @@ static bool thermal_of_should_bind(struct thermal_zone_device *tz,
 		goto out;
 
 	/* Look up the trip and the cdev in the cooling maps. */
-	for_each_child_of_node(cm_np, child) {
-		struct device_node *tr_np;
-		int count, i;
-
-		tr_np = of_parse_phandle(child, "trip", 0);
-		if (tr_np != trip->priv)
-			continue;
-
-		/* The trip has been found, look up the cdev. */
-		count = of_count_phandle_with_args(child, "cooling-device", "#cooling-cells");
-		if (count <= 0)
-			pr_err("Add a cooling_device property with at least one device\n");
-
-		for (i = 0; i < count; i++) {
-			result = thermal_of_get_cooling_spec(child, i, cdev, c);
-			if (result)
-				break;
-		}
-
-		of_node_put(child);
-		break;
-	}
+	result = thermal_of_cm_lookup(cm_np, trip, cdev, c);
 
 	of_node_put(cm_np);
 out:
diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 8d4ad0a3f2cf..252186124669 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -194,10 +194,12 @@ static int ufs_bsg_request(struct bsg_job *job)
 	ufshcd_rpm_put_sync(hba);
 	kfree(buff);
 	bsg_reply->result = ret;
-	job->reply_len = !rpmb ? sizeof(struct ufs_bsg_reply) : sizeof(struct ufs_rpmb_reply);
 	/* complete the job here only if no error */
-	if (ret == 0)
+	if (ret == 0) {
+		job->reply_len = rpmb ? sizeof(struct ufs_rpmb_reply) :
+					sizeof(struct ufs_bsg_reply);
 		bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
+	}
 
 	return ret;
 }
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 67410c4cebee..a3e95ef5eda8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -266,7 +266,7 @@ static bool ufshcd_has_pending_tasks(struct ufs_hba *hba)
 
 static bool ufshcd_is_ufs_dev_busy(struct ufs_hba *hba)
 {
-	return hba->outstanding_reqs || ufshcd_has_pending_tasks(hba);
+	return scsi_host_busy(hba->host) || ufshcd_has_pending_tasks(hba);
 }
 
 static const struct ufs_dev_quirk ufs_fixups[] = {
@@ -639,8 +639,8 @@ static void ufshcd_print_host_state(struct ufs_hba *hba)
 	const struct scsi_device *sdev_ufs = hba->ufs_device_wlun;
 
 	dev_err(hba->dev, "UFS Host state=%d\n", hba->ufshcd_state);
-	dev_err(hba->dev, "outstanding reqs=0x%lx tasks=0x%lx\n",
-		hba->outstanding_reqs, hba->outstanding_tasks);
+	dev_err(hba->dev, "%d outstanding reqs, tasks=0x%lx\n",
+		scsi_host_busy(hba->host), hba->outstanding_tasks);
 	dev_err(hba->dev, "saved_err=0x%x, saved_uic_err=0x%x\n",
 		hba->saved_err, hba->saved_uic_err);
 	dev_err(hba->dev, "Device power mode=%d, UIC link state=%d\n",
@@ -8975,7 +8975,7 @@ static enum scsi_timeout_action ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 	dev_info(hba->dev, "%s() finished; outstanding_tasks = %#lx.\n",
 		 __func__, hba->outstanding_tasks);
 
-	return hba->outstanding_reqs ? SCSI_EH_RESET_TIMER : SCSI_EH_DONE;
+	return scsi_host_busy(hba->host) ? SCSI_EH_RESET_TIMER : SCSI_EH_DONE;
 }
 
 static const struct attribute_group *ufshcd_driver_groups[] = {
@@ -10457,6 +10457,21 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	 */
 	spin_lock_init(&hba->clk_gating.lock);
 
+	/*
+	 * Set the default power management level for runtime and system PM.
+	 * Host controller drivers can override them in their
+	 * 'ufs_hba_variant_ops::init' callback.
+	 *
+	 * Default power saving mode is to keep UFS link in Hibern8 state
+	 * and UFS device in sleep state.
+	 */
+	hba->rpm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
+						UFS_SLEEP_PWR_MODE,
+						UIC_LINK_HIBERN8_STATE);
+	hba->spm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
+						UFS_SLEEP_PWR_MODE,
+						UIC_LINK_HIBERN8_STATE);
+
 	err = ufshcd_hba_init(hba);
 	if (err)
 		goto out_error;
@@ -10606,21 +10621,6 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		goto free_tmf_queue;
 	}
 
-	/*
-	 * Set the default power management level for runtime and system PM if
-	 * not set by the host controller drivers.
-	 * Default power saving mode is to keep UFS link in Hibern8 state
-	 * and UFS device in sleep state.
-	 */
-	if (!hba->rpm_lvl)
-		hba->rpm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
-						UFS_SLEEP_PWR_MODE,
-						UIC_LINK_HIBERN8_STATE);
-	if (!hba->spm_lvl)
-		hba->spm_lvl = ufs_get_desired_pm_lvl_for_dev_link_state(
-						UFS_SLEEP_PWR_MODE,
-						UIC_LINK_HIBERN8_STATE);
-
 	INIT_DELAYED_WORK(&hba->rpm_dev_flush_recheck_work, ufshcd_rpm_dev_flush_recheck_work);
 	INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
 
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 038f9d0ae3af..4504e16b458c 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -163,6 +163,8 @@ static struct afs_server *afs_install_server(struct afs_cell *cell,
 	rb_insert_color(&server->uuid_rb, &net->fs_servers);
 	hlist_add_head_rcu(&server->proc_link, &net->fs_proc);
 
+	afs_get_cell(cell, afs_cell_trace_get_server);
+
 added_dup:
 	write_seqlock(&net->fs_addr_lock);
 	estate = rcu_dereference_protected(server->endpoint_state,
@@ -442,6 +444,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
 			 atomic_read(&server->active), afs_server_trace_free);
 	afs_put_endpoint_state(rcu_access_pointer(server->endpoint_state),
 			       afs_estate_trace_put_server);
+	afs_put_cell(server->cell, afs_cell_trace_put_server);
 	kfree(server);
 }
 
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index 7e7e567a7f8a..d20cd902ef94 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -97,8 +97,8 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 				break;
 		if (j < slist->nr_servers) {
 			if (slist->servers[j].server == server) {
-				afs_put_server(volume->cell->net, server,
-					       afs_server_trace_put_slist_isort);
+				afs_unuse_server(volume->cell->net, server,
+						 afs_server_trace_put_slist_isort);
 				continue;
 			}
 
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 035ba52742a5..4db912f56230 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -780,6 +780,43 @@ int nfs4_inode_return_delegation(struct inode *inode)
 	return 0;
 }
 
+/**
+ * nfs4_inode_set_return_delegation_on_close - asynchronously return a delegation
+ * @inode: inode to process
+ *
+ * This routine is called to request that the delegation be returned as soon
+ * as the file is closed. If the file is already closed, the delegation is
+ * immediately returned.
+ */
+void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
+{
+	struct nfs_delegation *delegation;
+	struct nfs_delegation *ret = NULL;
+
+	if (!inode)
+		return;
+	rcu_read_lock();
+	delegation = nfs4_get_valid_delegation(inode);
+	if (!delegation)
+		goto out;
+	spin_lock(&delegation->lock);
+	if (!delegation->inode)
+		goto out_unlock;
+	if (list_empty(&NFS_I(inode)->open_files) &&
+	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
+		/* Refcount matched in nfs_end_delegation_return() */
+		ret = nfs_get_delegation(delegation);
+	} else
+		set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
+out_unlock:
+	spin_unlock(&delegation->lock);
+	if (ret)
+		nfs_clear_verifier_delegated(inode);
+out:
+	rcu_read_unlock();
+	nfs_end_delegation_return(inode, ret, 0);
+}
+
 /**
  * nfs4_inode_return_delegation_on_close - asynchronously return a delegation
  * @inode: inode to process
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 71524d34ed20..8ff5ab9c5c25 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -49,6 +49,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 				  unsigned long pagemod_limit, u32 deleg_type);
 int nfs4_inode_return_delegation(struct inode *inode);
 void nfs4_inode_return_delegation_on_close(struct inode *inode);
+void nfs4_inode_set_return_delegation_on_close(struct inode *inode);
 int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_stateid *stateid);
 void nfs_inode_evict_delegation(struct inode *inode);
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 90079ca134dd..c1f1b826888c 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -56,6 +56,7 @@
 #include <linux/uaccess.h>
 #include <linux/atomic.h>
 
+#include "delegation.h"
 #include "internal.h"
 #include "iostat.h"
 #include "pnfs.h"
@@ -130,6 +131,20 @@ static void nfs_direct_truncate_request(struct nfs_direct_req *dreq,
 		dreq->count = req_start;
 }
 
+static void nfs_direct_file_adjust_size_locked(struct inode *inode,
+					       loff_t offset, size_t count)
+{
+	loff_t newsize = offset + (loff_t)count;
+	loff_t oldsize = i_size_read(inode);
+
+	if (newsize > oldsize) {
+		i_size_write(inode, newsize);
+		NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
+		trace_nfs_size_grow(inode, newsize);
+		nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
+	}
+}
+
 /**
  * nfs_swap_rw - NFS address space operation for swap I/O
  * @iocb: target I/O control block
@@ -272,6 +287,8 @@ static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
 	nfs_direct_count_bytes(dreq, hdr);
 	spin_unlock(&dreq->lock);
 
+	nfs_update_delegated_atime(dreq->inode);
+
 	while (!list_empty(&hdr->pages)) {
 		struct nfs_page *req = nfs_list_entry(hdr->pages.next);
 		struct page *page = req->wb_page;
@@ -732,6 +749,7 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	struct nfs_direct_req *dreq = hdr->dreq;
 	struct nfs_commit_info cinfo;
 	struct nfs_page *req = nfs_list_entry(hdr->pages.next);
+	struct inode *inode = dreq->inode;
 	int flags = NFS_ODIRECT_DONE;
 
 	trace_nfs_direct_write_completion(dreq);
@@ -753,6 +771,11 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	}
 	spin_unlock(&dreq->lock);
 
+	spin_lock(&inode->i_lock);
+	nfs_direct_file_adjust_size_locked(inode, dreq->io_start, dreq->count);
+	nfs_update_delegated_mtime_locked(dreq->inode);
+	spin_unlock(&inode->i_lock);
+
 	while (!list_empty(&hdr->pages)) {
 
 		req = nfs_list_entry(hdr->pages.next);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 405f17e6e0b4..e7bc99c69743 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3898,8 +3898,11 @@ nfs4_atomic_open(struct inode *dir, struct nfs_open_context *ctx,
 
 static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 {
+	struct dentry *dentry = ctx->dentry;
 	if (ctx->state == NULL)
 		return;
+	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
+		nfs4_inode_set_return_delegation_on_close(d_inode(dentry));
 	if (is_sync)
 		nfs4_close_sync(ctx->state, _nfs4_ctx_to_openmode(ctx));
 	else
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b2c78621da44..4388004a319d 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -619,7 +619,6 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ofs, ovl_dentry_upper(c->dentry), udir, upper);
-		dput(upper);
 
 		if (!err) {
 			/* Restore timestamps on parent (best effort) */
@@ -627,6 +626,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 			ovl_dentry_set_upper_alias(c->dentry);
 			ovl_dentry_update_reval(c->dentry, upper);
 		}
+		dput(upper);
 	}
 	inode_unlock(udir);
 	if (err)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fa284b64b2de..23b358a1271c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -450,7 +450,7 @@
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
-		*(.rodata) *(.rodata.*)					\
+		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b7f327ce797e..8f37c5dd52b2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -196,10 +196,11 @@ struct gendisk {
 	unsigned int		zone_capacity;
 	unsigned int		last_zone_capacity;
 	unsigned long __rcu	*conv_zones_bitmap;
-	unsigned int            zone_wplugs_hash_bits;
-	spinlock_t              zone_wplugs_lock;
+	unsigned int		zone_wplugs_hash_bits;
+	atomic_t		nr_zone_wplugs;
+	spinlock_t		zone_wplugs_lock;
 	struct mempool_s	*zone_wplugs_pool;
-	struct hlist_head       *zone_wplugs_hash;
+	struct hlist_head	*zone_wplugs_hash;
 	struct workqueue_struct *zone_wplugs_wq;
 #endif /* CONFIG_BLK_DEV_ZONED */
 
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index cd6f9aae311f..070b3b680209 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -52,18 +52,6 @@
  */
 #define barrier_before_unreachable() asm volatile("")
 
-/*
- * Mark a position in code as unreachable.  This can be used to
- * suppress control flow warnings after asm blocks that transfer
- * control elsewhere.
- */
-#define unreachable() \
-	do {					\
-		annotate_unreachable();		\
-		barrier_before_unreachable();	\
-		__builtin_unreachable();	\
-	} while (0)
-
 #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
 #define __HAVE_BUILTIN_BSWAP32__
 #define __HAVE_BUILTIN_BSWAP64__
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2d962dade9fa..b15911e201bf 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -109,44 +109,21 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 /* Unreachable code */
 #ifdef CONFIG_OBJTOOL
-/*
- * These macros help objtool understand GCC code flow for unreachable code.
- * The __COUNTER__ based labels are a hack to make each instance of the macros
- * unique, to convince GCC not to merge duplicate inline asm statements.
- */
-#define __stringify_label(n) #n
-
-#define __annotate_reachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
-			".pushsection .discard.reachable\n\t"		\
-			".long " __stringify_label(c) "b - .\n\t"	\
-			".popsection\n\t");				\
-})
-#define annotate_reachable() __annotate_reachable(__COUNTER__)
-
-#define __annotate_unreachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
-		     ".pushsection .discard.unreachable\n\t"		\
-		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
-})
-#define annotate_unreachable() __annotate_unreachable(__COUNTER__)
-
 /* Annotate a C jump table to allow objtool to follow the code flow */
-#define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
-
+#define __annotate_jump_table __section(".data.rel.ro.c_jump_table")
 #else /* !CONFIG_OBJTOOL */
-#define annotate_reachable()
-#define annotate_unreachable()
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
 
-#ifndef unreachable
-# define unreachable() do {		\
-	annotate_unreachable();		\
+/*
+ * Mark a position in code as unreachable.  This can be used to
+ * suppress control flow warnings after asm blocks that transfer
+ * control elsewhere.
+ */
+#define unreachable() do {		\
+	barrier_before_unreachable();	\
 	__builtin_unreachable();	\
 } while (0)
-#endif
 
 /*
  * KENTRY - kernel entry point
diff --git a/include/linux/rcuref.h b/include/linux/rcuref.h
index 2c8bfd0f1b6b..6322d8c1c6b4 100644
--- a/include/linux/rcuref.h
+++ b/include/linux/rcuref.h
@@ -71,27 +71,30 @@ static inline __must_check bool rcuref_get(rcuref_t *ref)
 	return rcuref_get_slowpath(ref);
 }
 
-extern __must_check bool rcuref_put_slowpath(rcuref_t *ref);
+extern __must_check bool rcuref_put_slowpath(rcuref_t *ref, unsigned int cnt);
 
 /*
  * Internal helper. Do not invoke directly.
  */
 static __always_inline __must_check bool __rcuref_put(rcuref_t *ref)
 {
+	int cnt;
+
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() && preemptible(),
 			 "suspicious rcuref_put_rcusafe() usage");
 	/*
 	 * Unconditionally decrease the reference count. The saturation and
 	 * dead zones provide enough tolerance for this.
 	 */
-	if (likely(!atomic_add_negative_release(-1, &ref->refcnt)))
+	cnt = atomic_sub_return_release(1, &ref->refcnt);
+	if (likely(cnt >= 0))
 		return false;
 
 	/*
 	 * Handle the last reference drop and cases inside the saturation
 	 * and dead zones.
 	 */
-	return rcuref_put_slowpath(ref);
+	return rcuref_put_slowpath(ref, cnt);
 }
 
 /**
diff --git a/include/linux/socket.h b/include/linux/socket.h
index d18cc47e89bd..c3322eb3d686 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -392,6 +392,8 @@ struct ucred {
 
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
+extern int put_cmsg_notrunc(struct msghdr *msg, int level, int type, int len,
+			    void *data);
 
 struct timespec64;
 struct __kernel_timespec;
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index fec1e8a1570c..eac57914dcf3 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -158,7 +158,6 @@ enum {
 	RPC_TASK_NEED_XMIT,
 	RPC_TASK_NEED_RECV,
 	RPC_TASK_MSG_PIN_WAIT,
-	RPC_TASK_SIGNALLED,
 };
 
 #define rpc_test_and_set_running(t) \
@@ -171,7 +170,7 @@ enum {
 
 #define RPC_IS_ACTIVATED(t)	test_bit(RPC_TASK_ACTIVE, &(t)->tk_runstate)
 
-#define RPC_SIGNALLED(t)	test_bit(RPC_TASK_SIGNALLED, &(t)->tk_runstate)
+#define RPC_SIGNALLED(t)	(READ_ONCE(task->tk_rpc_status) == -ERESTARTSYS)
 
 /*
  * Task priorities.
diff --git a/include/net/ip.h b/include/net/ip.h
index fe4f85438114..bd201278c55a 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -424,6 +424,11 @@ int ip_decrease_ttl(struct iphdr *iph)
 	return --iph->ttl;
 }
 
+static inline dscp_t ip4h_dscp(const struct iphdr *ip4h)
+{
+	return inet_dsfield_to_dscp(ip4h->tos);
+}
+
 static inline int ip_mtu_locked(const struct dst_entry *dst)
 {
 	const struct rtable *rt = dst_rtable(dst);
diff --git a/include/net/route.h b/include/net/route.h
index da34b6fa9862..8a11d19f897b 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -208,12 +208,13 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
 		      const struct sk_buff *hint);
 
 static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
-				 u8 tos, struct net_device *devin)
+				 dscp_t dscp, struct net_device *devin)
 {
 	int err;
 
 	rcu_read_lock();
-	err = ip_route_input_noref(skb, dst, src, tos, devin);
+	err = ip_route_input_noref(skb, dst, src, inet_dscp_to_dsfield(dscp),
+				   devin);
 	if (!err) {
 		skb_dst_force(skb);
 		if (!skb_dst(skb))
diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 3dc7a1551ac3..5d653a3491d0 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -12,6 +12,7 @@
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/spi/spi.h>
 #include <sound/cs-amp-lib.h>
 
 #define CS35L56_DEVID					0x0000000
@@ -61,6 +62,7 @@
 #define CS35L56_IRQ1_MASK_8				0x000E0AC
 #define CS35L56_IRQ1_MASK_18				0x000E0D4
 #define CS35L56_IRQ1_MASK_20				0x000E0DC
+#define CS35L56_DSP_MBOX_1_RAW				0x0011000
 #define CS35L56_DSP_VIRTUAL1_MBOX_1			0x0011020
 #define CS35L56_DSP_VIRTUAL1_MBOX_2			0x0011024
 #define CS35L56_DSP_VIRTUAL1_MBOX_3			0x0011028
@@ -224,6 +226,7 @@
 #define CS35L56_HALO_STATE_SHUTDOWN			1
 #define CS35L56_HALO_STATE_BOOT_DONE			2
 
+#define CS35L56_MBOX_CMD_PING				0x0A000000
 #define CS35L56_MBOX_CMD_AUDIO_PLAY			0x0B000001
 #define CS35L56_MBOX_CMD_AUDIO_PAUSE			0x0B000002
 #define CS35L56_MBOX_CMD_AUDIO_REINIT			0x0B000003
@@ -254,6 +257,16 @@
 #define CS35L56_NUM_BULK_SUPPLIES			3
 #define CS35L56_NUM_DSP_REGIONS				5
 
+/* Additional margin for SYSTEM_RESET to control port ready on SPI */
+#define CS35L56_SPI_RESET_TO_PORT_READY_US (CS35L56_CONTROL_PORT_READY_US + 2500)
+
+struct cs35l56_spi_payload {
+	__be32	addr;
+	__be16	pad;
+	__be32	value;
+} __packed;
+static_assert(sizeof(struct cs35l56_spi_payload) == 10);
+
 struct cs35l56_base {
 	struct device *dev;
 	struct regmap *regmap;
@@ -269,6 +282,7 @@ struct cs35l56_base {
 	s8 cal_index;
 	struct cirrus_amp_cal_data cal_data;
 	struct gpio_desc *reset_gpio;
+	struct cs35l56_spi_payload *spi_payload_buf;
 };
 
 static inline bool cs35l56_is_otp_register(unsigned int reg)
@@ -276,6 +290,23 @@ static inline bool cs35l56_is_otp_register(unsigned int reg)
 	return (reg >> 16) == 3;
 }
 
+static inline int cs35l56_init_config_for_spi(struct cs35l56_base *cs35l56,
+					      struct spi_device *spi)
+{
+	cs35l56->spi_payload_buf = devm_kzalloc(&spi->dev,
+						sizeof(*cs35l56->spi_payload_buf),
+						GFP_KERNEL | GFP_DMA);
+	if (!cs35l56->spi_payload_buf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline bool cs35l56_is_spi(struct cs35l56_base *cs35l56)
+{
+	return IS_ENABLED(CONFIG_SPI_MASTER) && !!cs35l56->spi_payload_buf;
+}
+
 extern const struct regmap_config cs35l56_regmap_i2c;
 extern const struct regmap_config cs35l56_regmap_spi;
 extern const struct regmap_config cs35l56_regmap_sdw;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 9a75590227f2..3dddfc6abf0e 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -173,6 +173,7 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_get_queue_dns,	"GET q-dns ") \
 	EM(afs_cell_trace_get_queue_manage,	"GET q-mng ") \
 	EM(afs_cell_trace_get_queue_new,	"GET q-new ") \
+	EM(afs_cell_trace_get_server,		"GET server") \
 	EM(afs_cell_trace_get_vol,		"GET vol   ") \
 	EM(afs_cell_trace_insert,		"INSERT    ") \
 	EM(afs_cell_trace_manage,		"MANAGE    ") \
@@ -180,6 +181,7 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_put_destroy,		"PUT destry") \
 	EM(afs_cell_trace_put_queue_work,	"PUT q-work") \
 	EM(afs_cell_trace_put_queue_fail,	"PUT q-fail") \
+	EM(afs_cell_trace_put_server,		"PUT server") \
 	EM(afs_cell_trace_put_vol,		"PUT vol   ") \
 	EM(afs_cell_trace_see_source,		"SEE source") \
 	EM(afs_cell_trace_see_ws,		"SEE ws    ") \
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 5e8495216689..5fe852bd31ab 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -360,8 +360,7 @@ TRACE_EVENT(rpc_request,
 		{ (1UL << RPC_TASK_ACTIVE), "ACTIVE" },			\
 		{ (1UL << RPC_TASK_NEED_XMIT), "NEED_XMIT" },		\
 		{ (1UL << RPC_TASK_NEED_RECV), "NEED_RECV" },		\
-		{ (1UL << RPC_TASK_MSG_PIN_WAIT), "MSG_PIN_WAIT" },	\
-		{ (1UL << RPC_TASK_SIGNALLED), "SIGNALLED" })
+		{ (1UL << RPC_TASK_MSG_PIN_WAIT), "MSG_PIN_WAIT" })
 
 DECLARE_EVENT_CLASS(rpc_task_running,
 
diff --git a/io_uring/net.c b/io_uring/net.c
index 3974c417fe26..f32311f64113 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -334,7 +334,9 @@ static int io_sendmsg_copy_hdr(struct io_kiocb *req,
 		if (unlikely(ret))
 			return ret;
 
-		return __get_compat_msghdr(&iomsg->msg, &cmsg, NULL);
+		ret = __get_compat_msghdr(&iomsg->msg, &cmsg, NULL);
+		sr->msg_control = iomsg->msg.msg_control_user;
+		return ret;
 	}
 #endif
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 501d8c2fedff..a0e1d2124727 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4957,7 +4957,7 @@ static struct perf_event_pmu_context *
 find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		     struct perf_event *event)
 {
-	struct perf_event_pmu_context *new = NULL, *epc;
+	struct perf_event_pmu_context *new = NULL, *pos = NULL, *epc;
 	void *task_ctx_data = NULL;
 
 	if (!ctx->task) {
@@ -5014,12 +5014,19 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 			atomic_inc(&epc->refcount);
 			goto found_epc;
 		}
+		/* Make sure the pmu_ctx_list is sorted by PMU type: */
+		if (!pos && epc->pmu->type > pmu->type)
+			pos = epc;
 	}
 
 	epc = new;
 	new = NULL;
 
-	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	if (!pos)
+		list_add_tail(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	else
+		list_add(&epc->pmu_ctx_entry, pos->pmu_ctx_entry.prev);
+
 	epc->ctx = ctx;
 
 found_epc:
@@ -5969,14 +5976,15 @@ static int _perf_event_period(struct perf_event *event, u64 value)
 	if (!value)
 		return -EINVAL;
 
-	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
-		return -EINVAL;
-
-	if (perf_event_check_period(event, value))
-		return -EINVAL;
-
-	if (!event->attr.freq && (value & (1ULL << 63)))
-		return -EINVAL;
+	if (event->attr.freq) {
+		if (value > sysctl_perf_event_sample_rate)
+			return -EINVAL;
+	} else {
+		if (perf_event_check_period(event, value))
+			return -EINVAL;
+		if (value & (1ULL << 63))
+			return -EINVAL;
+	}
 
 	event_function_call(event, __perf_event_period, &value);
 
@@ -8233,7 +8241,8 @@ void perf_event_exec(void)
 
 	perf_event_enable_on_exec(ctx);
 	perf_event_remove_on_exec(ctx);
-	perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
+	scoped_guard(rcu)
+		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
 
 	perf_unpin_context(ctx);
 	put_ctx(ctx);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4b52cb2ae6d6..a0e0676f5d8b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -489,6 +489,11 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret <= 0)
 		goto put_old;
 
+	if (is_zero_page(old_page)) {
+		ret = -EINVAL;
+		goto put_old;
+	}
+
 	if (WARN(!is_register && PageCompound(old_page),
 		 "uprobe unregister should never work on compound page\n")) {
 		ret = -EINVAL;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c72356836eb6..9803f10a082a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7229,7 +7229,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 int __sched __cond_resched(void)
 {
-	if (should_resched(0)) {
+	if (should_resched(0) && !irqs_disabled()) {
 		preempt_schedule_common();
 		return 1;
 	}
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index aa57ae3eb1ff..325fd5b9d471 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3047,7 +3047,6 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 {
 	struct task_struct *prev = rq->curr;
 	struct task_struct *p;
-	bool prev_on_scx = prev->sched_class == &ext_sched_class;
 	bool keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
 	bool kick_idle = false;
 
@@ -3067,14 +3066,18 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 	 * if pick_task_scx() is called without preceding balance_scx().
 	 */
 	if (unlikely(rq->scx.flags & SCX_RQ_BAL_PENDING)) {
-		if (prev_on_scx) {
+		if (prev->scx.flags & SCX_TASK_QUEUED) {
 			keep_prev = true;
 		} else {
 			keep_prev = false;
 			kick_idle = true;
 		}
-	} else if (unlikely(keep_prev && !prev_on_scx)) {
-		/* only allowed during transitions */
+	} else if (unlikely(keep_prev &&
+			    prev->sched_class != &ext_sched_class)) {
+		/*
+		 * Can happen while enabling as SCX_RQ_BAL_PENDING assertion is
+		 * conditional on scx_enabled() and may have been skipped.
+		 */
 		WARN_ON_ONCE(scx_ops_enable_state() == SCX_OPS_ENABLED);
 		keep_prev = false;
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 71cc1bbfe9aa..dbd375f28ee0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -541,6 +541,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 	static struct trace_seq s;
 	unsigned long long avg;
 	unsigned long long stddev;
+	unsigned long long stddev_denom;
 #endif
 	mutex_lock(&ftrace_profile_lock);
 
@@ -562,23 +563,19 @@ static int function_stat_show(struct seq_file *m, void *v)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	seq_puts(m, "    ");
 
-	/* Sample standard deviation (s^2) */
-	if (rec->counter <= 1)
-		stddev = 0;
-	else {
-		/*
-		 * Apply Welford's method:
-		 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
-		 */
+	/*
+	 * Variance formula:
+	 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
+	 * Maybe Welford's method is better here?
+	 * Divide only by 1000 for ns^2 -> us^2 conversion.
+	 * trace_print_graph_duration will divide by 1000 again.
+	 */
+	stddev = 0;
+	stddev_denom = rec->counter * (rec->counter - 1) * 1000;
+	if (stddev_denom) {
 		stddev = rec->counter * rec->time_squared -
 			 rec->time * rec->time;
-
-		/*
-		 * Divide only 1000 for ns^2 -> us^2 conversion.
-		 * trace_print_graph_duration will divide 1000 again.
-		 */
-		stddev = div64_ul(stddev,
-				  rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev, stddev_denom);
 	}
 
 	trace_seq_init(&s);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5f9119eb7c67..31f5ad322fab 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6652,27 +6652,27 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (existing_hist_update_only(glob, trigger_data, file))
 		goto out_free;
 
-	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
-	if (ret < 0)
-		goto out_free;
+	if (!get_named_trigger_data(trigger_data)) {
 
-	if (get_named_trigger_data(trigger_data))
-		goto enable;
+		ret = create_actions(hist_data);
+		if (ret)
+			goto out_free;
 
-	ret = create_actions(hist_data);
-	if (ret)
-		goto out_unreg;
+		if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+			ret = save_hist_vars(hist_data);
+			if (ret)
+				goto out_free;
+		}
 
-	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		ret = save_hist_vars(hist_data);
+		ret = tracing_map_init(hist_data->map);
 		if (ret)
-			goto out_unreg;
+			goto out_free;
 	}
 
-	ret = tracing_map_init(hist_data->map);
-	if (ret)
-		goto out_unreg;
-enable:
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret < 0)
+		goto out_free;
+
 	ret = hist_trigger_enable(trigger_data, file);
 	if (ret)
 		goto out_unreg;
diff --git a/lib/rcuref.c b/lib/rcuref.c
index 97f300eca927..5bd726b71e39 100644
--- a/lib/rcuref.c
+++ b/lib/rcuref.c
@@ -220,6 +220,7 @@ EXPORT_SYMBOL_GPL(rcuref_get_slowpath);
 /**
  * rcuref_put_slowpath - Slowpath of __rcuref_put()
  * @ref:	Pointer to the reference count
+ * @cnt:	The resulting value of the fastpath decrement
  *
  * Invoked when the reference count is outside of the valid zone.
  *
@@ -233,10 +234,8 @@ EXPORT_SYMBOL_GPL(rcuref_get_slowpath);
  *	with a concurrent get()/put() pair. Caller is not allowed to
  *	deconstruct the protected object.
  */
-bool rcuref_put_slowpath(rcuref_t *ref)
+bool rcuref_put_slowpath(rcuref_t *ref, unsigned int cnt)
 {
-	unsigned int cnt = atomic_read(&ref->refcnt);
-
 	/* Did this drop the last reference? */
 	if (likely(cnt == RCUREF_NOREF)) {
 		/*
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 27b4c4a2ba1f..728a5ce9b505 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -636,7 +636,8 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	    test_bit(FLAG_HOLD_HCI_CONN, &chan->flags))
 		hci_conn_hold(conn->hcon);
 
-	list_add(&chan->list, &conn->chan_l);
+	/* Append to the list since the order matters for ECRED */
+	list_add_tail(&chan->list, &conn->chan_l);
 }
 
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
@@ -3776,7 +3777,11 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 	struct l2cap_ecred_conn_rsp *rsp_flex =
 		container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, hdr);
 
-	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+	/* Check if channel for outgoing connection or if it wasn't deferred
+	 * since in those cases it must be skipped.
+	 */
+	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags) ||
+	    !test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
 		return;
 
 	/* Reset ident so only one response is sent */
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 1d458e9da660..17a5f5923d61 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -370,9 +370,9 @@ br_nf_ipv4_daddr_was_changed(const struct sk_buff *skb,
  */
 static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb->dev, *br_indev;
-	struct iphdr *iph = ip_hdr(skb);
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
+	struct net_device *dev = skb->dev, *br_indev;
+	const struct iphdr *iph = ip_hdr(skb);
 	struct rtable *rt;
 	int err;
 
@@ -390,7 +390,9 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 	}
 	nf_bridge->in_prerouting = 0;
 	if (br_nf_ipv4_daddr_was_changed(skb, nf_bridge)) {
-		if ((err = ip_route_input(skb, iph->daddr, iph->saddr, iph->tos, dev))) {
+		err = ip_route_input(skb, iph->daddr, iph->saddr,
+				     ip4h_dscp(iph), dev);
+		if (err) {
 			struct in_device *in_dev = __in_dev_get_rcu(dev);
 
 			/* If err equals -EHOSTUNREACH the error is due to a
diff --git a/net/core/gro.c b/net/core/gro.c
index 78b320b63174..0ad549b07e03 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -653,6 +653,7 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 	skb->pkt_type = PACKET_HOST;
 
 	skb->encapsulation = 0;
+	skb->ip_summed = CHECKSUM_NONE;
 	skb_shinfo(skb)->gso_type = 0;
 	skb_shinfo(skb)->gso_size = 0;
 	if (unlikely(skb->slow_gro)) {
diff --git a/net/core/scm.c b/net/core/scm.c
index 4f6a14babe5a..733c0cbd393d 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -282,6 +282,16 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 }
 EXPORT_SYMBOL(put_cmsg);
 
+int put_cmsg_notrunc(struct msghdr *msg, int level, int type, int len,
+		     void *data)
+{
+	/* Don't produce truncated CMSGs */
+	if (!msg->msg_control || msg->msg_controllen < CMSG_LEN(len))
+		return -ETOOSMALL;
+
+	return put_cmsg(msg, level, type, len, data);
+}
+
 void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss_internal)
 {
 	struct scm_timestamping64 tss;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 61a950f13a91..f220306731da 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6127,11 +6127,11 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->offload_fwd_mark = 0;
 	skb->offload_l3_fwd_mark = 0;
 #endif
+	ipvs_reset(skb);
 
 	if (!xnet)
 		return;
 
-	ipvs_reset(skb);
 	skb->mark = 0;
 	skb_clear_tstamp(skb);
 }
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5dd54a813398..47e2743ffe22 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -34,6 +34,7 @@ static int min_sndbuf = SOCK_MIN_SNDBUF;
 static int min_rcvbuf = SOCK_MIN_RCVBUF;
 static int max_skb_frags = MAX_SKB_FRAGS;
 static int min_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE;
+static int netdev_budget_usecs_min = 2 * USEC_PER_SEC / HZ;
 
 static int net_msg_warn;	/* Unused, but still a sysctl */
 
@@ -580,7 +581,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.extra1		= &netdev_budget_usecs_min,
 	},
 	{
 		.procname	= "fb_tunnels_only_for_init_net",
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index f45bc187a92a..b8111ec651b5 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -477,13 +477,11 @@ static struct net_device *icmp_get_route_lookup_dev(struct sk_buff *skb)
 	return route_lookup_dev;
 }
 
-static struct rtable *icmp_route_lookup(struct net *net,
-					struct flowi4 *fl4,
+static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 					struct sk_buff *skb_in,
-					const struct iphdr *iph,
-					__be32 saddr, u8 tos, u32 mark,
-					int type, int code,
-					struct icmp_bxm *param)
+					const struct iphdr *iph, __be32 saddr,
+					dscp_t dscp, u32 mark, int type,
+					int code, struct icmp_bxm *param)
 {
 	struct net_device *route_lookup_dev;
 	struct dst_entry *dst, *dst2;
@@ -497,7 +495,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	fl4->saddr = saddr;
 	fl4->flowi4_mark = mark;
 	fl4->flowi4_uid = sock_net_uid(net, NULL);
-	fl4->flowi4_tos = tos & INET_DSCP_MASK;
+	fl4->flowi4_tos = inet_dscp_to_dsfield(dscp);
 	fl4->flowi4_proto = IPPROTO_ICMP;
 	fl4->fl4_icmp_type = type;
 	fl4->fl4_icmp_code = code;
@@ -549,7 +547,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 		orefdst = skb_in->_skb_refdst; /* save old refdst */
 		skb_dst_set(skb_in, NULL);
 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
-				     tos, rt2->dst.dev);
+				     dscp, rt2->dst.dev);
 
 		dst_release(&rt2->dst);
 		rt2 = skb_rtable(skb_in);
@@ -745,8 +743,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	ipc.opt = &icmp_param.replyopts.opt;
 	ipc.sockc.mark = mark;
 
-	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr, tos, mark,
-			       type, code, &icmp_param);
+	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr,
+			       inet_dsfield_to_dscp(tos), mark, type, code,
+			       &icmp_param);
 	if (IS_ERR(rt))
 		goto out_unlock;
 
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index 68aedb8877b9..81e86e5defee 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -617,7 +617,8 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev)
 
 		orefdst = skb->_skb_refdst;
 		skb_dst_set(skb, NULL);
-		err = ip_route_input(skb, nexthop, iph->saddr, iph->tos, dev);
+		err = ip_route_input(skb, nexthop, iph->saddr, ip4h_dscp(iph),
+				     dev);
 		rt2 = skb_rtable(skb);
 		if (err || (rt2->rt_type != RTN_UNICAST && rt2->rt_type != RTN_LOCAL)) {
 			skb_dst_drop(skb);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 68cb6a966b18..b731a4a8f2b0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2456,14 +2456,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			 */
 			memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
 			dmabuf_cmsg.frag_size = copy;
-			err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEAR,
-				       sizeof(dmabuf_cmsg), &dmabuf_cmsg);
-			if (err || msg->msg_flags & MSG_CTRUNC) {
-				msg->msg_flags &= ~MSG_CTRUNC;
-				if (!err)
-					err = -ETOOSMALL;
+			err = put_cmsg_notrunc(msg, SOL_SOCKET,
+					       SO_DEVMEM_LINEAR,
+					       sizeof(dmabuf_cmsg),
+					       &dmabuf_cmsg);
+			if (err)
 				goto out;
-			}
 
 			sent += copy;
 
@@ -2517,16 +2515,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				offset += copy;
 				remaining_len -= copy;
 
-				err = put_cmsg(msg, SOL_SOCKET,
-					       SO_DEVMEM_DMABUF,
-					       sizeof(dmabuf_cmsg),
-					       &dmabuf_cmsg);
-				if (err || msg->msg_flags & MSG_CTRUNC) {
-					msg->msg_flags &= ~MSG_CTRUNC;
-					if (!err)
-						err = -ETOOSMALL;
+				err = put_cmsg_notrunc(msg, SOL_SOCKET,
+						       SO_DEVMEM_DMABUF,
+						       sizeof(dmabuf_cmsg),
+						       &dmabuf_cmsg);
+				if (err)
 					goto out;
-				}
 
 				atomic_long_inc(&niov->pp_ref_count);
 				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bb1fe1ba867a..f3e4fc957219 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -806,12 +806,6 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 	/* In sequence, PAWS is OK. */
 
-	/* TODO: We probably should defer ts_recent change once
-	 * we take ownership of @req.
-	 */
-	if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
-		WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
-
 	if (TCP_SKB_CB(skb)->seq == tcp_rsk(req)->rcv_isn) {
 		/* Truncate SYN, it is out of window starting
 		   at tcp_rsk(req)->rcv_isn + 1. */
@@ -860,6 +854,10 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!child)
 		goto listen_overflow;
 
+	if (own_req && tmp_opt.saw_tstamp &&
+	    !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
+		tcp_sk(child)->rx_opt.ts_recent = tmp_opt.rcv_tsval;
+
 	if (own_req && rsk_drop_req(req)) {
 		reqsk_queue_removed(&inet_csk(req->rsk_listener)->icsk_accept_queue, req);
 		inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index b60e13c42bca..48fd53b98972 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -630,8 +630,8 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		}
 		skb_dst_set(skb2, &rt->dst);
 	} else {
-		if (ip_route_input(skb2, eiph->daddr, eiph->saddr, eiph->tos,
-				   skb2->dev) ||
+		if (ip_route_input(skb2, eiph->daddr, eiph->saddr,
+				   ip4h_dscp(eiph), skb2->dev) ||
 		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL6)
 			goto out;
 	}
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 0ac4283acdf2..7c05ac846646 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -262,10 +262,18 @@ static int rpl_input(struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
+	struct lwtunnel_state *lwtst;
 	struct rpl_lwt *rlwt;
 	int err;
 
-	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
+	/* We cannot dereference "orig_dst" once ip6_route_input() or
+	 * skb_dst_drop() is called. However, in order to detect a dst loop, we
+	 * need the address of its lwtstate. So, save the address of lwtstate
+	 * now and use it later as a comparison.
+	 */
+	lwtst = orig_dst->lwtstate;
+
+	rlwt = rpl_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
@@ -280,7 +288,9 @@ static int rpl_input(struct sk_buff *skb)
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
-		if (!dst->error) {
+
+		/* cache only if we don't create a dst reference loop */
+		if (!dst->error && lwtst != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&rlwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 33833b2064c0..51583461ae29 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -472,10 +472,18 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
+	struct lwtunnel_state *lwtst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
+	/* We cannot dereference "orig_dst" once ip6_route_input() or
+	 * skb_dst_drop() is called. However, in order to detect a dst loop, we
+	 * need the address of its lwtstate. So, save the address of lwtstate
+	 * now and use it later as a comparison.
+	 */
+	lwtst = orig_dst->lwtstate;
+
+	slwt = seg6_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
@@ -490,7 +498,9 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
-		if (!dst->error) {
+
+		/* cache only if we don't create a dst reference loop */
+		if (!dst->error && lwtst != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&slwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8c4f934d198c..b4ba2d9f0417 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1513,11 +1513,6 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		if (mptcp_pm_is_userspace(msk))
 			goto next;
 
-		if (list_empty(&msk->conn_list)) {
-			mptcp_pm_remove_anno_addr(msk, addr, false);
-			goto next;
-		}
-
 		lock_sock(sk);
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 860903e06422..b56bbee7312c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1140,7 +1140,6 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (data_len == 0) {
 		pr_debug("infinite mapping received\n");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
-		subflow->map_data_len = 0;
 		return MAPPING_INVALID;
 	}
 
@@ -1284,18 +1283,6 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		mptcp_schedule_work(sk);
 }
 
-static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
-{
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-
-	if (subflow->mp_join)
-		return false;
-	else if (READ_ONCE(msk->csum_enabled))
-		return !subflow->valid_csum_seen;
-	else
-		return READ_ONCE(msk->allow_infinite_fallback);
-}
-
 static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -1391,7 +1378,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!subflow_can_fallback(subflow) && subflow->map_data_len) {
+		if (!READ_ONCE(msk->allow_infinite_fallback)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 085e7892d310..b1536da2246b 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -478,6 +478,18 @@ static int rxperf_deliver_request(struct rxperf_call *call)
 		call->unmarshal++;
 		fallthrough;
 	case 2:
+		ret = rxperf_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		/* Deal with the terminal magic cookie. */
+		call->iov_len = 4;
+		call->kvec[0].iov_len	= call->iov_len;
+		call->kvec[0].iov_base	= call->tmp;
+		iov_iter_kvec(&call->iter, READ, call->kvec, 1, call->iov_len);
+		call->unmarshal++;
+		fallthrough;
+	case 3:
 		ret = rxperf_extract_data(call, false);
 		if (ret < 0)
 			return ret;
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 059f6ef1ad18..7fcb0574fc79 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1669,12 +1669,14 @@ static void remove_cache_proc_entries(struct cache_detail *cd)
 	}
 }
 
-#ifdef CONFIG_PROC_FS
 static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
 {
 	struct proc_dir_entry *p;
 	struct sunrpc_net *sn;
 
+	if (!IS_ENABLED(CONFIG_PROC_FS))
+		return 0;
+
 	sn = net_generic(net, sunrpc_net_id);
 	cd->procfs = proc_mkdir(cd->name, sn->proc_net_rpc);
 	if (cd->procfs == NULL)
@@ -1702,12 +1704,6 @@ static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
 	remove_cache_proc_entries(cd);
 	return -ENOMEM;
 }
-#else /* CONFIG_PROC_FS */
-static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
-{
-	return 0;
-}
-#endif
 
 void __init cache_initialize(void)
 {
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index cef623ea1506..9b45fbdc90ca 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -864,8 +864,6 @@ void rpc_signal_task(struct rpc_task *task)
 	if (!rpc_task_set_rpc_status(task, -ERESTARTSYS))
 		return;
 	trace_rpc_task_signalled(task, task->tk_action);
-	set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
-	smp_mb__after_atomic();
 	queue = READ_ONCE(task->tk_waitqueue);
 	if (queue)
 		rpc_wake_up_queued_task(queue, task);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index b69e6290acfa..171ad4e2523f 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2580,7 +2580,15 @@ static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
 	struct sock_xprt *lower_transport =
 				container_of(lower_xprt, struct sock_xprt, xprt);
 
-	lower_transport->xprt_err = status ? -EACCES : 0;
+	switch (status) {
+	case 0:
+	case -EACCES:
+	case -ETIMEDOUT:
+		lower_transport->xprt_err = status;
+		break;
+	default:
+		lower_transport->xprt_err = -EACCES;
+	}
 	complete(&lower_transport->handshake_done);
 	xprt_put(lower_xprt);
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3c323ca213d4..abfdb4905ca2 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -149,6 +149,9 @@ struct ima_kexec_hdr {
 #define IMA_CHECK_BLACKLIST	0x40000000
 #define IMA_VERITY_REQUIRED	0x80000000
 
+/* Exclude non-action flags which are not rule-specific. */
+#define IMA_NONACTION_RULE_FLAGS	(IMA_NONACTION_FLAGS & ~IMA_NEW_FILE)
+
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
 #define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 06132cf47016..4b213de8dcb4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -269,10 +269,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	mutex_lock(&iint->mutex);
 
 	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
-		/* reset appraisal flags if ima_inode_post_setattr was called */
+		/*
+		 * Reset appraisal flags (action and non-action rule-specific)
+		 * if ima_inode_post_setattr was called.
+		 */
 		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
 				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
-				 IMA_NONACTION_FLAGS);
+				 IMA_NONACTION_RULE_FLAGS);
 
 	/*
 	 * Re-evaulate the file if either the xattr has changed or the
diff --git a/security/landlock/net.c b/security/landlock/net.c
index d5dcc4407a19..104b6c01fe50 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -63,8 +63,7 @@ static int current_check_access_socket(struct socket *const sock,
 	if (WARN_ON_ONCE(dom->num_layers < 1))
 		return -EACCES;
 
-	/* Checks if it's a (potential) TCP socket. */
-	if (sock->type != SOCK_STREAM)
+	if (!sk_is_tcp(sock->sk))
 		return 0;
 
 	/* Checks for minimal header length to safely read sa_family. */
diff --git a/sound/pci/hda/cs35l56_hda_spi.c b/sound/pci/hda/cs35l56_hda_spi.c
index 7f02155fe61e..7c94110b6272 100644
--- a/sound/pci/hda/cs35l56_hda_spi.c
+++ b/sound/pci/hda/cs35l56_hda_spi.c
@@ -22,6 +22,9 @@ static int cs35l56_hda_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	cs35l56->base.dev = &spi->dev;
+	ret = cs35l56_init_config_for_spi(&cs35l56->base, spi);
+	if (ret)
+		return ret;
 
 #ifdef CS35L56_WAKE_HOLD_TIME_US
 	cs35l56->base.can_hibernate = true;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9bf99fe6cd34..4a3b4c6d4114 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10564,6 +10564,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1460, "Asus VivoBook 15", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1463, "Asus GA402X/GA402N", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604VI/VC/VE/VG/VJ/VQ/VU/VV/VY/VZ", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603VQ/VU/VV/VJ/VI", ALC285_FIXUP_ASUS_HEADSET_MIC),
@@ -10597,7 +10598,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index e45e9ae01bc6..195841a567c3 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -10,6 +10,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <sound/cs-amp-lib.h>
 
@@ -303,6 +304,79 @@ void cs35l56_wait_min_reset_pulse(void)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_wait_min_reset_pulse, SND_SOC_CS35L56_SHARED);
 
+static const struct {
+	u32 addr;
+	u32 value;
+} cs35l56_spi_system_reset_stages[] = {
+	{ .addr = CS35L56_DSP_VIRTUAL1_MBOX_1, .value = CS35L56_MBOX_CMD_SYSTEM_RESET },
+	/* The next write is necessary to delimit the soft reset */
+	{ .addr = CS35L56_DSP_MBOX_1_RAW, .value = CS35L56_MBOX_CMD_PING },
+};
+
+static void cs35l56_spi_issue_bus_locked_reset(struct cs35l56_base *cs35l56_base,
+					       struct spi_device *spi)
+{
+	struct cs35l56_spi_payload *buf = cs35l56_base->spi_payload_buf;
+	struct spi_transfer t = {
+		.tx_buf		= buf,
+		.len		= sizeof(*buf),
+	};
+	struct spi_message m;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l56_spi_system_reset_stages); i++) {
+		buf->addr = cpu_to_be32(cs35l56_spi_system_reset_stages[i].addr);
+		buf->value = cpu_to_be32(cs35l56_spi_system_reset_stages[i].value);
+		spi_message_init_with_transfers(&m, &t, 1);
+		ret = spi_sync_locked(spi, &m);
+		if (ret)
+			dev_warn(cs35l56_base->dev, "spi_sync failed: %d\n", ret);
+
+		usleep_range(CS35L56_SPI_RESET_TO_PORT_READY_US,
+			     2 * CS35L56_SPI_RESET_TO_PORT_READY_US);
+	}
+}
+
+static void cs35l56_spi_system_reset(struct cs35l56_base *cs35l56_base)
+{
+	struct spi_device *spi = to_spi_device(cs35l56_base->dev);
+	unsigned int val;
+	int read_ret, ret;
+
+	/*
+	 * There must not be any other SPI bus activity while the amp is
+	 * soft-resetting.
+	 */
+	ret = spi_bus_lock(spi->controller);
+	if (ret) {
+		dev_warn(cs35l56_base->dev, "spi_bus_lock failed: %d\n", ret);
+		return;
+	}
+
+	cs35l56_spi_issue_bus_locked_reset(cs35l56_base, spi);
+	spi_bus_unlock(spi->controller);
+
+	/*
+	 * Check firmware boot by testing for a response in MBOX_2.
+	 * HALO_STATE cannot be trusted yet because the reset sequence
+	 * can leave it with stale state. But MBOX is reset.
+	 * The regmap must remain in cache-only until the chip has
+	 * booted, so use a bypassed read.
+	 */
+	ret = read_poll_timeout(regmap_read_bypassed, read_ret,
+				(val > 0) && (val < 0xffffffff),
+				CS35L56_HALO_STATE_POLL_US,
+				CS35L56_HALO_STATE_TIMEOUT_US,
+				false,
+				cs35l56_base->regmap,
+				CS35L56_DSP_VIRTUAL1_MBOX_2,
+				&val);
+	if (ret) {
+		dev_err(cs35l56_base->dev, "SPI reboot timed out(%d): MBOX2=%#x\n",
+			read_ret, val);
+	}
+}
+
 static const struct reg_sequence cs35l56_system_reset_seq[] = {
 	REG_SEQ0(CS35L56_DSP1_HALO_STATE, 0),
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
@@ -315,6 +389,12 @@ void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
 	 * accesses other than the controlled system reset sequence below.
 	 */
 	regcache_cache_only(cs35l56_base->regmap, true);
+
+	if (cs35l56_is_spi(cs35l56_base)) {
+		cs35l56_spi_system_reset(cs35l56_base);
+		return;
+	}
+
 	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
 					cs35l56_system_reset_seq,
 					ARRAY_SIZE(cs35l56_system_reset_seq));
diff --git a/sound/soc/codecs/cs35l56-spi.c b/sound/soc/codecs/cs35l56-spi.c
index b07b798b0b45..568f554a8638 100644
--- a/sound/soc/codecs/cs35l56-spi.c
+++ b/sound/soc/codecs/cs35l56-spi.c
@@ -33,6 +33,9 @@ static int cs35l56_spi_probe(struct spi_device *spi)
 
 	cs35l56->base.dev = &spi->dev;
 	cs35l56->base.can_hibernate = true;
+	ret = cs35l56_init_config_for_spi(&cs35l56->base, spi);
+	if (ret)
+		return ret;
 
 	ret = cs35l56_common_probe(cs35l56);
 	if (ret != 0)
diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index f3c97da798dc..76159c45e6b5 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -233,7 +233,6 @@ static const struct snd_kcontrol_new es8328_right_line_controls =
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL17, 7, 1, 0),
 	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL17, 6, 1, 0),
 	SOC_DAPM_SINGLE("Right Playback Switch", ES8328_DACCONTROL18, 7, 1, 0),
 	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL18, 6, 1, 0),
@@ -243,7 +242,6 @@ static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
 static const struct snd_kcontrol_new es8328_right_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Left Playback Switch", ES8328_DACCONTROL19, 7, 1, 0),
 	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL19, 6, 1, 0),
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL20, 7, 1, 0),
 	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL20, 6, 1, 0),
 };
 
@@ -336,10 +334,10 @@ static const struct snd_soc_dapm_widget es8328_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", ES8328_DACPOWER,
 			ES8328_DACPOWER_LDAC_OFF, 1),
 
-	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MIXER("Left Mixer", ES8328_DACCONTROL17, 7, 0,
 		&es8328_left_mixer_controls[0],
 		ARRAY_SIZE(es8328_left_mixer_controls)),
-	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MIXER("Right Mixer", ES8328_DACCONTROL20, 7, 0,
 		&es8328_right_mixer_controls[0],
 		ARRAY_SIZE(es8328_right_mixer_controls)),
 
@@ -418,19 +416,14 @@ static const struct snd_soc_dapm_route es8328_dapm_routes[] = {
 	{ "Right Line Mux", "PGA", "Right PGA Mux" },
 	{ "Right Line Mux", "Differential", "Differential Mux" },
 
-	{ "Left Out 1", NULL, "Left DAC" },
-	{ "Right Out 1", NULL, "Right DAC" },
-	{ "Left Out 2", NULL, "Left DAC" },
-	{ "Right Out 2", NULL, "Right DAC" },
-
-	{ "Left Mixer", "Playback Switch", "Left DAC" },
+	{ "Left Mixer", NULL, "Left DAC" },
 	{ "Left Mixer", "Left Bypass Switch", "Left Line Mux" },
 	{ "Left Mixer", "Right Playback Switch", "Right DAC" },
 	{ "Left Mixer", "Right Bypass Switch", "Right Line Mux" },
 
 	{ "Right Mixer", "Left Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Left Bypass Switch", "Left Line Mux" },
-	{ "Right Mixer", "Playback Switch", "Right DAC" },
+	{ "Right Mixer", NULL, "Right DAC" },
 	{ "Right Mixer", "Right Bypass Switch", "Right Line Mux" },
 
 	{ "DAC DIG", NULL, "DAC STM" },
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 634168d2bb6e..c5efbceb06d1 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -994,10 +994,10 @@ static struct snd_soc_dai_driver fsl_sai_dai_template[] = {
 	{
 		.name = "sai-tx",
 		.playback = {
-			.stream_name = "CPU-Playback",
+			.stream_name = "SAI-Playback",
 			.channels_min = 1,
 			.channels_max = 32,
-				.rate_min = 8000,
+			.rate_min = 8000,
 			.rate_max = 2822400,
 			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = FSL_SAI_FORMATS,
@@ -1007,7 +1007,7 @@ static struct snd_soc_dai_driver fsl_sai_dai_template[] = {
 	{
 		.name = "sai-rx",
 		.capture = {
-			.stream_name = "CPU-Capture",
+			.stream_name = "SAI-Capture",
 			.channels_min = 1,
 			.channels_max = 32,
 			.rate_min = 8000,
diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index ff3671226306..ca33ecad0752 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -119,8 +119,8 @@ static const struct snd_soc_ops imx_audmix_be_ops = {
 static const char *name[][3] = {
 	{"HiFi-AUDMIX-FE-0", "HiFi-AUDMIX-FE-1", "HiFi-AUDMIX-FE-2"},
 	{"sai-tx", "sai-tx", "sai-rx"},
-	{"AUDMIX-Playback-0", "AUDMIX-Playback-1", "CPU-Capture"},
-	{"CPU-Playback", "CPU-Playback", "AUDMIX-Capture-0"},
+	{"AUDMIX-Playback-0", "AUDMIX-Playback-1", "SAI-Capture"},
+	{"SAI-Playback", "SAI-Playback", "AUDMIX-Capture-0"},
 };
 
 static int imx_audmix_probe(struct platform_device *pdev)
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 737dd00e97b1..779d97d31f17 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1145,7 +1145,7 @@ static int snd_usbmidi_output_close(struct snd_rawmidi_substream *substream)
 {
 	struct usbmidi_out_port *port = substream->runtime->private_data;
 
-	cancel_work_sync(&port->ep->work);
+	flush_work(&port->ep->work);
 	return substream_open(substream, 0, 0);
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a97efb7b131e..09210fb4ac60 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1868,6 +1868,7 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x534d, 0x2109): /* MacroSilicon MS2109 */
 		subs->stream_offset_adj = 2;
 		break;
+	case USB_ID(0x2b73, 0x000a): /* Pioneer DJM-900NXS2 */
 	case USB_ID(0x2b73, 0x0013): /* Pioneer DJM-450 */
 		pioneer_djm_set_format_quirk(subs, 0x0082);
 		break;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8e02db7e8332..1691aa6e6ce3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -639,47 +639,8 @@ static int add_dead_ends(struct objtool_file *file)
 	uint64_t offset;
 
 	/*
-	 * Check for manually annotated dead ends.
-	 */
-	rsec = find_section_by_name(file->elf, ".rela.discard.unreachable");
-	if (!rsec)
-		goto reachable;
-
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type == STT_SECTION) {
-			offset = reloc_addend(reloc);
-		} else if (reloc->sym->local_label) {
-			offset = reloc->sym->offset;
-		} else {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, offset);
-		if (insn)
-			insn = prev_insn_same_sec(file, insn);
-		else if (offset == reloc->sym->sec->sh.sh_size) {
-			insn = find_last_insn(file, reloc->sym->sec);
-			if (!insn) {
-				WARN("can't find unreachable insn at %s+0x%" PRIx64,
-				     reloc->sym->sec->name, offset);
-				return -1;
-			}
-		} else {
-			WARN("can't find unreachable insn at %s+0x%" PRIx64,
-			     reloc->sym->sec->name, offset);
-			return -1;
-		}
-
-		insn->dead_end = true;
-	}
-
-reachable:
-	/*
-	 * These manually annotated reachable checks are needed for GCC 4.4,
-	 * where the Linux unreachable() macro isn't supported.  In that case
-	 * GCC doesn't know the "ud2" is fatal, so it generates code as if it's
-	 * not a dead end.
+	 * UD2 defaults to being a dead-end, allow them to be annotated for
+	 * non-fatal, eg WARN.
 	 */
 	rsec = find_section_by_name(file->elf, ".rela.discard.reachable");
 	if (!rsec)
@@ -2628,13 +2589,14 @@ static void mark_rodata(struct objtool_file *file)
 	 *
 	 * - .rodata: can contain GCC switch tables
 	 * - .rodata.<func>: same, if -fdata-sections is being used
-	 * - .rodata..c_jump_table: contains C annotated jump tables
+	 * - .data.rel.ro.c_jump_table: contains C annotated jump tables
 	 *
 	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if (!strncmp(sec->name, ".rodata", 7) &&
-		    !strstr(sec->name, ".str1.")) {
+		if ((!strncmp(sec->name, ".rodata", 7) &&
+		     !strstr(sec->name, ".str1.")) ||
+		    !strncmp(sec->name, ".data.rel.ro", 12)) {
 			sec->rodata = true;
 			found = true;
 		}
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 86d4af9c5aa9..89ee12b1a138 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -10,7 +10,7 @@
 #include <objtool/check.h>
 #include <objtool/elf.h>
 
-#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
+#define C_JUMP_TABLE_SECTION ".data.rel.ro.c_jump_table"
 
 struct special_alt {
 	struct list_head list;
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 30f29096e27c..4868b514ae78 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -40,10 +40,9 @@ def addremove_queues(cfg, nl) -> None:
 
     netnl = EthtoolFamily()
     channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
-    if channels['combined-count'] == 0:
-        rx_type = 'rx'
-    else:
-        rx_type = 'combined'
+    rx_type = 'rx'
+    if channels.get('combined-count', 0) > 0:
+            rx_type = 'combined'
 
     expected = curr_queues - 1
     cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 61056fa074bb..40a2def50b83 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -234,6 +234,7 @@ enforce_ruleset(struct __test_metadata *const _metadata, const int ruleset_fd)
 struct protocol_variant {
 	int domain;
 	int type;
+	int protocol;
 };
 
 struct service_fixture {
diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 29af19c4e9f9..a8982da4acbd 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -3,6 +3,8 @@ CONFIG_CGROUP_SCHED=y
 CONFIG_INET=y
 CONFIG_IPV6=y
 CONFIG_KEYS=y
+CONFIG_MPTCP=y
+CONFIG_MPTCP_IPV6=y
 CONFIG_NET=y
 CONFIG_NET_NS=y
 CONFIG_OVERLAY_FS=y
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 4e0aeb53b225..376079d70d3f 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -85,18 +85,18 @@ static void setup_loopback(struct __test_metadata *const _metadata)
 	clear_ambient_cap(_metadata, CAP_NET_ADMIN);
 }
 
+static bool prot_is_tcp(const struct protocol_variant *const prot)
+{
+	return (prot->domain == AF_INET || prot->domain == AF_INET6) &&
+	       prot->type == SOCK_STREAM &&
+	       (prot->protocol == IPPROTO_TCP || prot->protocol == IPPROTO_IP);
+}
+
 static bool is_restricted(const struct protocol_variant *const prot,
 			  const enum sandbox_type sandbox)
 {
-	switch (prot->domain) {
-	case AF_INET:
-	case AF_INET6:
-		switch (prot->type) {
-		case SOCK_STREAM:
-			return sandbox == TCP_SANDBOX;
-		}
-		break;
-	}
+	if (sandbox == TCP_SANDBOX)
+		return prot_is_tcp(prot);
 	return false;
 }
 
@@ -105,7 +105,7 @@ static int socket_variant(const struct service_fixture *const srv)
 	int ret;
 
 	ret = socket(srv->protocol.domain, srv->protocol.type | SOCK_CLOEXEC,
-		     0);
+		     srv->protocol.protocol);
 	if (ret < 0)
 		return -errno;
 	return ret;
@@ -290,22 +290,59 @@ FIXTURE_TEARDOWN(protocol)
 }
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv4_tcp) {
+FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv4_tcp1) {
 	/* clang-format on */
 	.sandbox = NO_SANDBOX,
 	.prot = {
 		.domain = AF_INET,
 		.type = SOCK_STREAM,
+		/* IPPROTO_IP == 0 */
+		.protocol = IPPROTO_IP,
 	},
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv6_tcp) {
+FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv4_tcp2) {
+	/* clang-format on */
+	.sandbox = NO_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_TCP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv6_tcp1) {
 	/* clang-format on */
 	.sandbox = NO_SANDBOX,
 	.prot = {
 		.domain = AF_INET6,
 		.type = SOCK_STREAM,
+		/* IPPROTO_IP == 0 */
+		.protocol = IPPROTO_IP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv6_tcp2) {
+	/* clang-format on */
+	.sandbox = NO_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_TCP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv4_mptcp) {
+	/* clang-format on */
+	.sandbox = NO_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_MPTCP,
 	},
 };
 
@@ -329,6 +366,17 @@ FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv6_udp) {
 	},
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_ipv6_mptcp) {
+	/* clang-format on */
+	.sandbox = NO_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_MPTCP,
+	},
+};
+
 /* clang-format off */
 FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_unix_stream) {
 	/* clang-format on */
@@ -350,22 +398,48 @@ FIXTURE_VARIANT_ADD(protocol, no_sandbox_with_unix_datagram) {
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv4_tcp) {
+FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv4_tcp1) {
+	/* clang-format on */
+	.sandbox = TCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		/* IPPROTO_IP == 0 */
+		.protocol = IPPROTO_IP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv4_tcp2) {
 	/* clang-format on */
 	.sandbox = TCP_SANDBOX,
 	.prot = {
 		.domain = AF_INET,
 		.type = SOCK_STREAM,
+		.protocol = IPPROTO_TCP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv6_tcp1) {
+	/* clang-format on */
+	.sandbox = TCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		/* IPPROTO_IP == 0 */
+		.protocol = IPPROTO_IP,
 	},
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv6_tcp) {
+FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv6_tcp2) {
 	/* clang-format on */
 	.sandbox = TCP_SANDBOX,
 	.prot = {
 		.domain = AF_INET6,
 		.type = SOCK_STREAM,
+		.protocol = IPPROTO_TCP,
 	},
 };
 
@@ -389,6 +463,17 @@ FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv6_udp) {
 	},
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv4_mptcp) {
+	/* clang-format on */
+	.sandbox = TCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_MPTCP,
+	},
+};
+
 /* clang-format off */
 FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_unix_stream) {
 	/* clang-format on */
@@ -399,6 +484,17 @@ FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_unix_stream) {
 	},
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_ipv6_mptcp) {
+	/* clang-format on */
+	.sandbox = TCP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_MPTCP,
+	},
+};
+
 /* clang-format off */
 FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_unix_datagram) {
 	/* clang-format on */
diff --git a/tools/testing/selftests/rseq/rseq-riscv-bits.h b/tools/testing/selftests/rseq/rseq-riscv-bits.h
index de31a0143139..f02f411d550d 100644
--- a/tools/testing/selftests/rseq/rseq-riscv-bits.h
+++ b/tools/testing/selftests/rseq/rseq-riscv-bits.h
@@ -243,7 +243,7 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
 #ifdef RSEQ_COMPARE_TWICE
 				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
 #endif
-				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, 3)
+				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, 3)
 				  RSEQ_INJECT_ASM(4)
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
@@ -251,8 +251,8 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
 				    [current_cpu_id]		"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
 				    [rseq_cs]			"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [ptr]			"r" (ptr),
-				    [off]			"er" (off),
-				    [inc]			"er" (inc)
+				    [off]			"r" (off),
+				    [inc]			"r" (inc)
 				    RSEQ_INJECT_INPUT
 				  : "memory", RSEQ_ASM_TMP_REG_1
 				    RSEQ_INJECT_CLOBBER
diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index 37e598d0a365..67d544aaa9a3 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -158,7 +158,7 @@ do {									\
 	"bnez	" RSEQ_ASM_TMP_REG_1 ", 222b\n"				\
 	"333:\n"
 
-#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, post_commit_label)		\
+#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, post_commit_label)	\
 	"mv	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(ptr) "]\n"	\
 	RSEQ_ASM_OP_R_ADD(off)						\
 	REG_L	  RSEQ_ASM_TMP_REG_1 ", 0(" RSEQ_ASM_TMP_REG_1 ")\n"	\

