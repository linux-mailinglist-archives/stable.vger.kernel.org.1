Return-Path: <stable+bounces-136677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6BA9C2E1
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 11:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB739A71EB
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB78238C36;
	Fri, 25 Apr 2025 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F7Fbwf7U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676F238C1E;
	Fri, 25 Apr 2025 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571995; cv=none; b=oig34EGVc/AyRoq+N7Qx4l4TRkGHqZGwJS3LPFL+5NSX5OFj7Eq97V+86lwZIzw6gQVeionVMy/eSzaindQ3D/tcS2B1r5KZqsCp7+rVgTJTFGQFs3bnSrVpcsixz6CU8Yl/I8G0JttYi8wD9hlW0pxtWyT/mlDbXqD0/kzddjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571995; c=relaxed/simple;
	bh=X2EYXibhAi7i9ZjyfAtkhC5Ux+sYiycoaHyN2aACd3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXfpQb2AUCrAvWAvshm76YolDrwaKWa4N7YrImm2QnwTpC9pQcTmalAV7D/nPcB68GsOl7mKdAtQs39iyf/SPtaUfXIm7a1ZiNFB8cYQT/S4Wpy4I7TFK3qDM8XSlVaXQRqketWJUm5OmhX04G2samRF1I+iBul5xn3AeW0fOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F7Fbwf7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DA6C4CEE4;
	Fri, 25 Apr 2025 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745571994;
	bh=X2EYXibhAi7i9ZjyfAtkhC5Ux+sYiycoaHyN2aACd3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7Fbwf7UMTZmBfZwI87jBI5PINuZ571/ut5wnCNaP4Q+8biJdDf3Gdqc/aIRH8mrO
	 dIchGeqEcpPKx9nUfdg9LplsvqJ2/sMysVirOGPwtdUnWDRXtkoG6rlGmr5UHdRbyc
	 hxwdY31m7JpqAd/qYNjhMmFPvvXgEqpI2+uNgYuk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.135
Date: Fri, 25 Apr 2025 11:06:23 +0200
Message-ID: <2025042523-pregnant-starboard-0547@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042523-ranking-polygon-326c@gregkh>
References: <2025042523-ranking-polygon-326c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b19dfb5d2fd..428b2259225d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4833,6 +4833,7 @@ S:	Maintained
 F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
 F:	scripts/sign-file.c
+F:	scripts/ssl-common.h
 F:	tools/certs/
 
 CFAG12864B LCD DRIVER
diff --git a/Makefile b/Makefile
index 50f1a283b67d..be531bb0f734 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 134
+SUBLEVEL = 135
 EXTRAVERSION =
 NAME = Curry Ramen
 
@@ -1075,6 +1075,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
 # Require designated initializers for all marked structures
 KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 7640b5158ff9..256df3a2d823 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1247,8 +1247,7 @@ dpi0_out: endpoint {
 		};
 
 		pwm0: pwm@1401e000 {
-			compatible = "mediatek,mt8173-disp-pwm",
-				     "mediatek,mt6595-disp-pwm";
+			compatible = "mediatek,mt8173-disp-pwm";
 			reg = <0 0x1401e000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&mmsys CLK_MM_DISP_PWM026M>,
@@ -1258,8 +1257,7 @@ pwm0: pwm@1401e000 {
 		};
 
 		pwm1: pwm@1401f000 {
-			compatible = "mediatek,mt8173-disp-pwm",
-				     "mediatek,mt6595-disp-pwm";
+			compatible = "mediatek,mt8173-disp-pwm";
 			reg = <0 0x1401f000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&mmsys CLK_MM_DISP_PWM126M>,
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 8efc3302bf96..cdb024dd33f5 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -75,6 +75,7 @@
 #define ARM_CPU_PART_CORTEX_A76		0xD0B
 #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
 #define ARM_CPU_PART_CORTEX_A77		0xD0D
+#define ARM_CPU_PART_CORTEX_A76AE	0xD0E
 #define ARM_CPU_PART_NEOVERSE_V1	0xD40
 #define ARM_CPU_PART_CORTEX_A78		0xD41
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
@@ -119,6 +120,7 @@
 #define QCOM_CPU_PART_KRYO		0x200
 #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
 #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
 #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
 #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
 #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
@@ -151,6 +153,7 @@
 #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
 #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
 #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_CORTEX_A76AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76AE)
 #define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
 #define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
@@ -188,6 +191,7 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
 #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
+#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
 #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
 #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 930b0e6c9462..7622782d0bb9 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -56,11 +56,13 @@ extern void fpsimd_signal_preserve_current_state(void);
 extern void fpsimd_preserve_current_state(void);
 extern void fpsimd_restore_current_state(void);
 extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
+extern void fpsimd_kvm_prepare(void);
 
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 				     void *sve_state, unsigned int sve_vl,
 				     void *za_state, unsigned int sme_vl,
-				     u64 *svcr);
+				     u64 *svcr, enum fp_type *type,
+				     enum fp_type to_save);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_save_and_flush_cpu_state(void);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 577cf444c113..0935f9849510 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -67,6 +67,7 @@ enum kvm_mode kvm_get_mode(void);
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
 extern unsigned int kvm_sve_max_vl;
+extern unsigned int kvm_host_sve_max_vl;
 int kvm_arm_init_sve(void);
 
 u32 __attribute_const__ kvm_target_cpu(void);
@@ -309,8 +310,18 @@ struct vcpu_reset_state {
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
 
-	/* Guest floating point state */
+	/*
+	 * Guest floating point state
+	 *
+	 * The architecture has two main floating point extensions,
+	 * the original FPSIMD and SVE.  These have overlapping
+	 * register views, with the FPSIMD V registers occupying the
+	 * low 128 bits of the SVE Z registers.  When the core
+	 * floating point code saves the register state of a task it
+	 * records which view it saved in fp_type.
+	 */
 	void *sve_state;
+	enum fp_type fp_type;
 	unsigned int sve_max_vl;
 	u64 svcr;
 
@@ -320,7 +331,6 @@ struct kvm_vcpu_arch {
 	/* Values of trap registers for the guest. */
 	u64 hcr_el2;
 	u64 mdcr_el2;
-	u64 cptr_el2;
 
 	/* Values of trap registers for the host before guest entry. */
 	u64 mdcr_el2_host;
@@ -370,7 +380,6 @@ struct kvm_vcpu_arch {
 	struct kvm_guest_debug_arch vcpu_debug_state;
 	struct kvm_guest_debug_arch external_debug_state;
 
-	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
 	struct task_struct *parent_task;
 
 	struct {
@@ -547,10 +556,6 @@ struct kvm_vcpu_arch {
 /* Save TRBE context if active  */
 #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
 
-/* SVE enabled for host EL0 */
-#define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
-/* SME enabled for EL0 */
-#define HOST_SME_ENABLED	__vcpu_single_flag(sflags, BIT(1))
 /* Physical CPU not in supported_cpus */
 #define ON_UNSUPPORTED_CPU	__vcpu_single_flag(sflags, BIT(2))
 /* WFIT instruction trapped */
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index aa7fa2a08f06..1d0bb7624a1c 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -122,5 +122,6 @@ extern u64 kvm_nvhe_sym(id_aa64isar2_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val);
+extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 400f8956328b..1b822e618bb4 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -122,6 +122,12 @@ enum vec_type {
 	ARM64_VEC_MAX,
 };
 
+enum fp_type {
+	FP_STATE_CURRENT,	/* Save based on current task state. */
+	FP_STATE_FPSIMD,
+	FP_STATE_SVE,
+};
+
 struct cpu_context {
 	unsigned long x19;
 	unsigned long x20;
@@ -152,6 +158,7 @@ struct thread_struct {
 		struct user_fpsimd_state fpsimd_state;
 	} uw;
 
+	enum fp_type		fp_type;	/* registers FPSIMD or SVE? */
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
 	void			*za_state;	/* ZA register, if any */
diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index aa3d3607d5c8..6f9f4f68b9e2 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -96,7 +96,6 @@ enum mitigation_state arm64_get_meltdown_state(void);
 
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
-u8 spectre_bhb_loop_affected(int scope);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 #endif	/* __ASSEMBLY__ */
 #endif	/* __ASM_SPECTRE_H */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 43afe07c74fd..47425311acc5 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -125,6 +125,8 @@ struct fpsimd_last_state_struct {
 	u64 *svcr;
 	unsigned int sve_vl;
 	unsigned int sme_vl;
+	enum fp_type *fp_type;
+	enum fp_type to_save;
 };
 
 static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
@@ -330,15 +332,6 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
  *    The task can execute SVE instructions while in userspace without
  *    trapping to the kernel.
  *
- *    When stored, Z0-Z31 (incorporating Vn in bits[127:0] or the
- *    corresponding Zn), P0-P15 and FFR are encoded in
- *    task->thread.sve_state, formatted appropriately for vector
- *    length task->thread.sve_vl or, if SVCR.SM is set,
- *    task->thread.sme_vl.
- *
- *    task->thread.sve_state must point to a valid buffer at least
- *    sve_state_size(task) bytes in size.
- *
  *    During any syscall, the kernel may optionally clear TIF_SVE and
  *    discard the vector state except for the FPSIMD subset.
  *
@@ -348,7 +341,15 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
  *    do_sve_acc() to be called, which does some preparation and then
  *    sets TIF_SVE.
  *
- *    When stored, FPSIMD registers V0-V31 are encoded in
+ * During any syscall, the kernel may optionally clear TIF_SVE and
+ * discard the vector state except for the FPSIMD subset.
+ *
+ * The data will be stored in one of two formats:
+ *
+ *  * FPSIMD only - FP_STATE_FPSIMD:
+ *
+ *    When the FPSIMD only state stored task->thread.fp_type is set to
+ *    FP_STATE_FPSIMD, the FPSIMD registers V0-V31 are encoded in
  *    task->thread.uw.fpsimd_state; bits [max : 128] for each of Z0-Z31 are
  *    logically zero but not stored anywhere; P0-P15 and FFR are not
  *    stored and have unspecified values from userspace's point of
@@ -356,7 +357,23 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
  *    but userspace is discouraged from relying on this.
  *
  *    task->thread.sve_state does not need to be non-NULL, valid or any
- *    particular size: it must not be dereferenced.
+ *    particular size: it must not be dereferenced and any data stored
+ *    there should be considered stale and not referenced.
+ *
+ *  * SVE state - FP_STATE_SVE:
+ *
+ *    When the full SVE state is stored task->thread.fp_type is set to
+ *    FP_STATE_SVE and Z0-Z31 (incorporating Vn in bits[127:0] or the
+ *    corresponding Zn), P0-P15 and FFR are encoded in in
+ *    task->thread.sve_state, formatted appropriately for vector
+ *    length task->thread.sve_vl or, if SVCR.SM is set,
+ *    task->thread.sme_vl. The storage for the vector registers in
+ *    task->thread.uw.fpsimd_state should be ignored.
+ *
+ *    task->thread.sve_state must point to a valid buffer at least
+ *    sve_state_size(task) bytes in size. The data stored in
+ *    task->thread.uw.fpsimd_state.vregs should be considered stale
+ *    and not referenced.
  *
  *  * FPSR and FPCR are always stored in task->thread.uw.fpsimd_state
  *    irrespective of whether TIF_SVE is clear or set, since these are
@@ -404,12 +421,15 @@ static void task_fpsimd_load(void)
 		}
 	}
 
-	if (restore_sve_regs)
+	if (restore_sve_regs) {
+		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_SVE);
 		sve_load_state(sve_pffr(&current->thread),
 			       &current->thread.uw.fpsimd_state.fpsr,
 			       restore_ffr);
-	else
+	} else {
+		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_FPSIMD);
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
+	}
 }
 
 /*
@@ -419,8 +439,8 @@ static void task_fpsimd_load(void)
  * last, if KVM is involved this may be the guest VM context rather
  * than the host thread for the VM pointed to by current. This means
  * that we must always reference the state storage via last rather
- * than via current, other than the TIF_ flags which KVM will
- * carefully maintain for us.
+ * than via current, if we are saving KVM state then it will have
+ * ensured that the type of registers to save is set in last->to_save.
  */
 static void fpsimd_save(void)
 {
@@ -437,7 +457,8 @@ static void fpsimd_save(void)
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
 		return;
 
-	if (test_thread_flag(TIF_SVE)) {
+	if ((last->to_save == FP_STATE_CURRENT && test_thread_flag(TIF_SVE)) ||
+	    last->to_save == FP_STATE_SVE) {
 		save_sve_regs = true;
 		save_ffr = true;
 		vl = last->sve_vl;
@@ -474,8 +495,10 @@ static void fpsimd_save(void)
 		sve_save_state((char *)last->sve_state +
 					sve_ffr_offset(vl),
 			       &last->st->fpsr, save_ffr);
+		*last->fp_type = FP_STATE_SVE;
 	} else {
 		fpsimd_save_state(last->st);
+		*last->fp_type = FP_STATE_FPSIMD;
 	}
 }
 
@@ -851,8 +874,10 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 
 	fpsimd_flush_task_state(task);
 	if (test_and_clear_tsk_thread_flag(task, TIF_SVE) ||
-	    thread_sm_enabled(&task->thread))
+	    thread_sm_enabled(&task->thread)) {
 		sve_to_fpsimd(task);
+		task->thread.fp_type = FP_STATE_FPSIMD;
+	}
 
 	if (system_supports_sme()) {
 		if (type == ARM64_VEC_SME ||
@@ -1383,6 +1408,7 @@ static void sve_init_regs(void)
 		fpsimd_bind_task_to_cpu();
 	} else {
 		fpsimd_to_sve(current);
+		current->thread.fp_type = FP_STATE_SVE;
 		fpsimd_flush_task_state(current);
 	}
 }
@@ -1612,6 +1638,8 @@ void fpsimd_flush_thread(void)
 		current->thread.svcr = 0;
 	}
 
+	current->thread.fp_type = FP_STATE_FPSIMD;
+
 	put_cpu_fpsimd_context();
 	kfree(sve_state);
 	kfree(za_state);
@@ -1660,6 +1688,8 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->sve_vl = task_get_sve_vl(current);
 	last->sme_vl = task_get_sme_vl(current);
 	last->svcr = &current->thread.svcr;
+	last->fp_type = &current->thread.fp_type;
+	last->to_save = FP_STATE_CURRENT;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
 	/*
@@ -1683,7 +1713,8 @@ static void fpsimd_bind_task_to_cpu(void)
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 			      unsigned int sve_vl, void *za_state,
-			      unsigned int sme_vl, u64 *svcr)
+			      unsigned int sme_vl, u64 *svcr,
+			      enum fp_type *type, enum fp_type to_save)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1697,6 +1728,8 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 	last->za_state = za_state;
 	last->sve_vl = sve_vl;
 	last->sme_vl = sme_vl;
+	last->fp_type = type;
+	last->to_save = to_save;
 }
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 3f06e9d45271..7092840deb5c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -331,6 +331,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 		clear_tsk_thread_flag(dst, TIF_SME);
 	}
 
+	dst->thread.fp_type = FP_STATE_FPSIMD;
+
 	/* clear any pending asynchronous tag fault raised by the parent */
 	clear_tsk_thread_flag(dst, TIF_MTE_ASYNC_FAULT);
 
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 2df5e43ae4d1..93a00cd42edd 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -857,52 +857,86 @@ static unsigned long system_bhb_mitigations;
  * This must be called with SCOPE_LOCAL_CPU for each type of CPU, before any
  * SCOPE_SYSTEM call will give the right answer.
  */
-u8 spectre_bhb_loop_affected(int scope)
+static bool is_spectre_bhb_safe(int scope)
+{
+	static const struct midr_range spectre_bhb_safe_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A510),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A520),
+		MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
+		{},
+	};
+	static bool all_safe = true;
+
+	if (scope != SCOPE_LOCAL_CPU)
+		return all_safe;
+
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_safe_list))
+		return true;
+
+	all_safe = false;
+
+	return false;
+}
+
+static u8 spectre_bhb_loop_affected(void)
 {
 	u8 k = 0;
-	static u8 max_bhb_k;
-
-	if (scope == SCOPE_LOCAL_CPU) {
-		static const struct midr_range spectre_bhb_k32_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k24_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k11_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_AMPERE1),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k8_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-			{},
-		};
-
-		if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
-			k = 32;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
-			k = 24;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
-			k = 11;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
-			k =  8;
-
-		max_bhb_k = max(max_bhb_k, k);
-	} else {
-		k = max_bhb_k;
-	}
+
+	static const struct midr_range spectre_bhb_k132_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+	};
+	static const struct midr_range spectre_bhb_k38_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	};
+	static const struct midr_range spectre_bhb_k32_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k24_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76AE),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k11_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k8_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		{},
+	};
+
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k132_list))
+		k = 132;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k38_list))
+		k = 38;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
+		k = 32;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
+		k = 24;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
+		k = 11;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
+		k =  8;
 
 	return k;
 }
@@ -928,29 +962,13 @@ static enum mitigation_state spectre_bhb_get_cpu_fw_mitigation_state(void)
 	}
 }
 
-static bool is_spectre_bhb_fw_affected(int scope)
+static bool has_spectre_bhb_fw_mitigation(void)
 {
-	static bool system_affected;
 	enum mitigation_state fw_state;
 	bool has_smccc = arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_NONE;
-	static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-		{},
-	};
-	bool cpu_in_list = is_midr_in_range_list(read_cpuid_id(),
-					 spectre_bhb_firmware_mitigated_list);
-
-	if (scope != SCOPE_LOCAL_CPU)
-		return system_affected;
 
 	fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
-	if (cpu_in_list || (has_smccc && fw_state == SPECTRE_MITIGATED)) {
-		system_affected = true;
-		return true;
-	}
-
-	return false;
+	return has_smccc && fw_state == SPECTRE_MITIGATED;
 }
 
 static bool supports_ecbhb(int scope)
@@ -966,6 +984,8 @@ static bool supports_ecbhb(int scope)
 						    ID_AA64MMFR1_EL1_ECBHB_SHIFT);
 }
 
+static u8 max_bhb_k;
+
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
 			     int scope)
 {
@@ -974,16 +994,18 @@ bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
 	if (supports_csv2p3(scope))
 		return false;
 
-	if (supports_clearbhb(scope))
-		return true;
-
-	if (spectre_bhb_loop_affected(scope))
-		return true;
+	if (is_spectre_bhb_safe(scope))
+		return false;
 
-	if (is_spectre_bhb_fw_affected(scope))
-		return true;
+	/*
+	 * At this point the core isn't known to be "safe" so we're going to
+	 * assume it's vulnerable. We still need to update `max_bhb_k` though,
+	 * but only if we aren't mitigating with clearbhb though.
+	 */
+	if (scope == SCOPE_LOCAL_CPU && !supports_clearbhb(SCOPE_LOCAL_CPU))
+		max_bhb_k = max(max_bhb_k, spectre_bhb_loop_affected());
 
-	return false;
+	return true;
 }
 
 static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
@@ -1017,7 +1039,7 @@ early_param("nospectre_bhb", parse_spectre_bhb_param);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
 	bp_hardening_cb_t cpu_cb;
-	enum mitigation_state fw_state, state = SPECTRE_VULNERABLE;
+	enum mitigation_state state = SPECTRE_VULNERABLE;
 	struct bp_hardening_data *data = this_cpu_ptr(&bp_hardening_data);
 
 	if (!is_spectre_bhb_affected(entry, SCOPE_LOCAL_CPU))
@@ -1043,7 +1065,7 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		this_cpu_set_vectors(EL1_VECTOR_BHB_CLEAR_INSN);
 		state = SPECTRE_MITIGATED;
 		set_bit(BHB_INSN, &system_bhb_mitigations);
-	} else if (spectre_bhb_loop_affected(SCOPE_LOCAL_CPU)) {
+	} else if (spectre_bhb_loop_affected()) {
 		/*
 		 * Ensure KVM uses the indirect vector which will have the
 		 * branchy-loop added. A57/A72-r0 will already have selected
@@ -1056,32 +1078,29 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		this_cpu_set_vectors(EL1_VECTOR_BHB_LOOP);
 		state = SPECTRE_MITIGATED;
 		set_bit(BHB_LOOP, &system_bhb_mitigations);
-	} else if (is_spectre_bhb_fw_affected(SCOPE_LOCAL_CPU)) {
-		fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
-		if (fw_state == SPECTRE_MITIGATED) {
-			/*
-			 * Ensure KVM uses one of the spectre bp_hardening
-			 * vectors. The indirect vector doesn't include the EL3
-			 * call, so needs upgrading to
-			 * HYP_VECTOR_SPECTRE_INDIRECT.
-			 */
-			if (!data->slot || data->slot == HYP_VECTOR_INDIRECT)
-				data->slot += 1;
-
-			this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
-
-			/*
-			 * The WA3 call in the vectors supersedes the WA1 call
-			 * made during context-switch. Uninstall any firmware
-			 * bp_hardening callback.
-			 */
-			cpu_cb = spectre_v2_get_sw_mitigation_cb();
-			if (__this_cpu_read(bp_hardening_data.fn) != cpu_cb)
-				__this_cpu_write(bp_hardening_data.fn, NULL);
-
-			state = SPECTRE_MITIGATED;
-			set_bit(BHB_FW, &system_bhb_mitigations);
-		}
+	} else if (has_spectre_bhb_fw_mitigation()) {
+		/*
+		 * Ensure KVM uses one of the spectre bp_hardening
+		 * vectors. The indirect vector doesn't include the EL3
+		 * call, so needs upgrading to
+		 * HYP_VECTOR_SPECTRE_INDIRECT.
+		 */
+		if (!data->slot || data->slot == HYP_VECTOR_INDIRECT)
+			data->slot += 1;
+
+		this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
+
+		/*
+		 * The WA3 call in the vectors supersedes the WA1 call
+		 * made during context-switch. Uninstall any firmware
+		 * bp_hardening callback.
+		 */
+		cpu_cb = spectre_v2_get_sw_mitigation_cb();
+		if (__this_cpu_read(bp_hardening_data.fn) != cpu_cb)
+			__this_cpu_write(bp_hardening_data.fn, NULL);
+
+		state = SPECTRE_MITIGATED;
+		set_bit(BHB_FW, &system_bhb_mitigations);
 	}
 
 	update_mitigation_state(&spectre_bhb_state, state);
@@ -1115,7 +1134,6 @@ void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 {
 	u8 rd;
 	u32 insn;
-	u16 loop_count = spectre_bhb_loop_affected(SCOPE_SYSTEM);
 
 	BUG_ON(nr_inst != 1); /* MOV -> MOV */
 
@@ -1124,7 +1142,7 @@ void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 
 	insn = le32_to_cpu(*origptr);
 	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn);
-	insn = aarch64_insn_gen_movewide(rd, loop_count, 0,
+	insn = aarch64_insn_gen_movewide(rd, max_bhb_k, 0,
 					 AARCH64_INSN_VARIANT_64BIT,
 					 AARCH64_INSN_MOVEWIDE_ZERO);
 	*updptr++ = cpu_to_le32(insn);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b178bbdc1c3b..2f1f86d91612 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -917,6 +917,7 @@ static int sve_set_common(struct task_struct *target,
 		clear_tsk_thread_flag(target, TIF_SVE);
 		if (type == ARM64_VEC_SME)
 			fpsimd_force_sync_to_sve(target);
+		target->thread.fp_type = FP_STATE_FPSIMD;
 		goto out;
 	}
 
@@ -939,6 +940,7 @@ static int sve_set_common(struct task_struct *target,
 	if (!target->thread.sve_state) {
 		ret = -ENOMEM;
 		clear_tsk_thread_flag(target, TIF_SVE);
+		target->thread.fp_type = FP_STATE_FPSIMD;
 		goto out;
 	}
 
@@ -952,6 +954,7 @@ static int sve_set_common(struct task_struct *target,
 	fpsimd_sync_to_sve(target);
 	if (type == ARM64_VEC_SVE)
 		set_tsk_thread_flag(target, TIF_SVE);
+	target->thread.fp_type = FP_STATE_SVE;
 
 	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
 	start = SVE_PT_SVE_OFFSET;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 82f4572c8ddf..2461bbffe7d4 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -207,6 +207,7 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	__get_user_error(fpsimd.fpcr, &ctx->fpcr, err);
 
 	clear_thread_flag(TIF_SVE);
+	current->thread.fp_type = FP_STATE_FPSIMD;
 
 	/* load the hardware registers from the fpsimd_state structure */
 	if (!err)
@@ -297,6 +298,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (sve.head.size <= sizeof(*user->sve)) {
 		clear_thread_flag(TIF_SVE);
 		current->thread.svcr &= ~SVCR_SM_MASK;
+		current->thread.fp_type = FP_STATE_FPSIMD;
 		goto fpsimd_only;
 	}
 
@@ -332,6 +334,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 		current->thread.svcr |= SVCR_SM_MASK;
 	else
 		set_thread_flag(TIF_SVE);
+	current->thread.fp_type = FP_STATE_SVE;
 
 fpsimd_only:
 	/* copy the FP and status/control registers */
@@ -937,9 +940,11 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		 * FPSIMD register state - flush the saved FPSIMD
 		 * register state in case it gets loaded.
 		 */
-		if (current->thread.svcr & SVCR_SM_MASK)
+		if (current->thread.svcr & SVCR_SM_MASK) {
 			memset(&current->thread.uw.fpsimd_state, 0,
 			       sizeof(current->thread.uw.fpsimd_state));
+			current->thread.fp_type = FP_STATE_FPSIMD;
+		}
 
 		current->thread.svcr &= ~(SVCR_ZA_MASK |
 					  SVCR_SM_MASK);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3a05f364b4b6..6eb992056c67 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -371,7 +371,11 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (err)
 		return err;
 
-	return kvm_share_hyp(vcpu, vcpu + 1);
+	err = kvm_share_hyp(vcpu, vcpu + 1);
+	if (err)
+		kvm_vgic_vcpu_destroy(vcpu);
+
+	return err;
 }
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
@@ -1230,7 +1234,6 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	}
 
 	vcpu_reset_hcr(vcpu);
-	vcpu->arch.cptr_el2 = CPTR_EL2_DEFAULT;
 
 	/*
 	 * Handle the "start in power-off" case.
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index ec8e4494873d..3fd86b71ee37 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -49,8 +49,6 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	if (ret)
 		return ret;
 
-	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
-
 	/*
 	 * We need to keep current's task_struct pinned until its data has been
 	 * unshared with the hypervisor to make sure it is not re-used by the
@@ -75,36 +73,20 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(!current->mm);
-	BUG_ON(test_thread_flag(TIF_SVE));
 
 	if (!system_supports_fpsimd())
 		return;
 
-	vcpu->arch.fp_state = FP_STATE_HOST_OWNED;
-
-	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
-	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
-		vcpu_set_flag(vcpu, HOST_SVE_ENABLED);
-
 	/*
-	 * We don't currently support SME guests but if we leave
-	 * things in streaming mode then when the guest starts running
-	 * FPSIMD or SVE code it may generate SME traps so as a
-	 * special case if we are in streaming mode we force the host
-	 * state to be saved now and exit streaming mode so that we
-	 * don't have to handle any SME traps for valid guest
-	 * operations. Do this for ZA as well for now for simplicity.
+	 * Ensure that any host FPSIMD/SVE/SME state is saved and unbound such
+	 * that the host kernel is responsible for restoring this state upon
+	 * return to userspace, and the hyp code doesn't need to save anything.
+	 *
+	 * When the host may use SME, fpsimd_save_and_flush_cpu_state() ensures
+	 * that PSTATE.{SM,ZA} == {0,0}.
 	 */
-	if (system_supports_sme()) {
-		vcpu_clear_flag(vcpu, HOST_SME_ENABLED);
-		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
-			vcpu_set_flag(vcpu, HOST_SME_ENABLED);
-
-		if (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)) {
-			vcpu->arch.fp_state = FP_STATE_FREE;
-			fpsimd_save_and_flush_cpu_state();
-		}
-	}
+	fpsimd_save_and_flush_cpu_state();
+	vcpu->arch.fp_state = FP_STATE_FREE;
 }
 
 /*
@@ -129,9 +111,16 @@ void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu)
  */
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 {
+	enum fp_type fp_type;
+
 	WARN_ON_ONCE(!irqs_disabled());
 
 	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED) {
+		if (vcpu_has_sve(vcpu))
+			fp_type = FP_STATE_SVE;
+		else
+			fp_type = FP_STATE_FPSIMD;
+
 		/*
 		 * Currently we do not support SME guests so SVCR is
 		 * always 0 and we just need a variable to point to.
@@ -139,10 +128,10 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.fp_regs,
 					 vcpu->arch.sve_state,
 					 vcpu->arch.sve_max_vl,
-					 NULL, 0, &vcpu->arch.svcr);
+					 NULL, 0, &vcpu->arch.svcr,
+					 &vcpu->arch.fp_type, fp_type);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
-		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
 	}
 }
 
@@ -158,48 +147,19 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
 	local_irq_save(flags);
 
-	/*
-	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
-	 * CPACR_EL1_DEFAULT and we need to reenable SME.
-	 */
-	if (has_vhe() && system_supports_sme()) {
-		/* Also restore EL0 state seen on entry */
-		if (vcpu_get_flag(vcpu, HOST_SME_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0,
-					 CPACR_EL1_SMEN_EL0EN |
-					 CPACR_EL1_SMEN_EL1EN);
-		else
-			sysreg_clear_set(CPACR_EL1,
-					 CPACR_EL1_SMEN_EL0EN,
-					 CPACR_EL1_SMEN_EL1EN);
-	}
-
 	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED) {
-		if (vcpu_has_sve(vcpu)) {
-			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
-
-			/* Restore the VL that was saved when bound to the CPU */
-			if (!has_vhe())
-				sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
-						       SYS_ZCR_EL1);
-		}
-
-		fpsimd_save_and_flush_cpu_state();
-	} else if (has_vhe() && system_supports_sve()) {
 		/*
-		 * The FPSIMD/SVE state in the CPU has not been touched, and we
-		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been
-		 * reset to CPACR_EL1_DEFAULT by the Hyp code, disabling SVE
-		 * for EL0.  To avoid spurious traps, restore the trap state
-		 * seen by kvm_arch_vcpu_load_fp():
+		 * Flush (save and invalidate) the fpsimd/sve state so that if
+		 * the host tries to use fpsimd/sve, it's not using stale data
+		 * from the guest.
+		 *
+		 * Flushing the state sets the TIF_FOREIGN_FPSTATE bit for the
+		 * context unconditionally, in both nVHE and VHE. This allows
+		 * the kernel to restore the fpsimd/sve state, including ZCR_EL1
+		 * when needed.
 		 */
-		if (vcpu_get_flag(vcpu, HOST_SVE_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_ZEN_EL0EN);
-		else
-			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
+		fpsimd_save_and_flush_cpu_state();
 	}
 
-	update_thread_flag(TIF_SVE, 0);
-
 	local_irq_restore(flags);
 }
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 435346ea1504..d8c94c45cb2f 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -44,6 +44,11 @@ alternative_if ARM64_HAS_RAS_EXTN
 alternative_else_nop_endif
 	mrs	x1, isr_el1
 	cbz	x1,  1f
+
+	// Ensure that __guest_enter() always provides a context
+	// synchronization event so that callers don't need ISBs for anything
+	// that would usually be synchonized by the ERET.
+	isb
 	mov	x0, #ARM_EXCEPTION_IRQ
 	ret
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 081aca8f432e..275176e61d74 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -167,13 +167,68 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 	write_sysreg_el1(__vcpu_sys_reg(vcpu, ZCR_EL1), SYS_ZCR);
 }
 
+static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
+{
+	u64 zcr_el1, zcr_el2;
+
+	if (!guest_owns_fp_regs(vcpu))
+		return;
+
+	if (vcpu_has_sve(vcpu)) {
+		zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+
+		write_sysreg_el2(zcr_el2, SYS_ZCR);
+
+		zcr_el1 = __vcpu_sys_reg(vcpu, ZCR_EL1);
+		write_sysreg_el1(zcr_el1, SYS_ZCR);
+	}
+}
+
+static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
+{
+	u64 zcr_el1, zcr_el2;
+
+	if (!guest_owns_fp_regs(vcpu))
+		return;
+
+	/*
+	 * When the guest owns the FP regs, we know that guest+hyp traps for
+	 * any FPSIMD/SVE/SME features exposed to the guest have been disabled
+	 * by either fpsimd_lazy_switch_to_guest() or kvm_hyp_handle_fpsimd()
+	 * prior to __guest_entry(). As __guest_entry() guarantees a context
+	 * synchronization event, we don't need an ISB here to avoid taking
+	 * traps for anything that was exposed to the guest.
+	 */
+	if (vcpu_has_sve(vcpu)) {
+		zcr_el1 = read_sysreg_el1(SYS_ZCR);
+		__vcpu_sys_reg(vcpu, ZCR_EL1) = zcr_el1;
+
+		/*
+		 * The guest's state is always saved using the guest's max VL.
+		 * Ensure that the host has the guest's max VL active such that
+		 * the host can save the guest's state lazily, but don't
+		 * artificially restrict the host to the guest's max VL.
+		 */
+		if (has_vhe()) {
+			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+			write_sysreg_el2(zcr_el2, SYS_ZCR);
+		} else {
+			zcr_el2 = sve_vq_from_vl(kvm_host_sve_max_vl) - 1;
+			write_sysreg_el2(zcr_el2, SYS_ZCR);
+
+			zcr_el1 = vcpu_sve_max_vq(vcpu) - 1;
+			write_sysreg_el1(zcr_el1, SYS_ZCR);
+		}
+	}
+}
+
 /*
  * We trap the first access to the FP/SIMD to save the host context and
  * restore the guest context lazily.
  * If FP/SIMD is not implemented, handle the trap and inject an undefined
  * instruction exception to the guest. Similarly for trapped SVE accesses.
  */
-static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	bool sve_guest;
 	u8 esr_ec;
@@ -207,10 +262,6 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	}
 	isb();
 
-	/* Write out the host state if it's in the registers */
-	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED)
-		__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
-
 	/* Restore the guest state */
 	if (sve_guest)
 		__hyp_sve_restore_guest(vcpu);
@@ -335,7 +386,7 @@ static bool kvm_hyp_handle_ptrauth(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return true;
 }
 
-static bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
 	    handle_tx2_tvm(vcpu))
@@ -351,7 +402,7 @@ static bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return false;
 }
 
-static bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (static_branch_unlikely(&vgic_v3_cpuif_trap) &&
 	    __vgic_v3_perform_cpuif_access(vcpu) == 1)
@@ -360,19 +411,18 @@ static bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return false;
 }
 
-static bool kvm_hyp_handle_memory_fault(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_memory_fault(struct kvm_vcpu *vcpu,
+					       u64 *exit_code)
 {
 	if (!__populate_fault_info(vcpu))
 		return true;
 
 	return false;
 }
-static bool kvm_hyp_handle_iabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
-	__alias(kvm_hyp_handle_memory_fault);
-static bool kvm_hyp_handle_watchpt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
-	__alias(kvm_hyp_handle_memory_fault);
+#define kvm_hyp_handle_iabt_low		kvm_hyp_handle_memory_fault
+#define kvm_hyp_handle_watchpt_low	kvm_hyp_handle_memory_fault
 
-static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (kvm_hyp_handle_memory_fault(vcpu, exit_code))
 		return true;
@@ -402,23 +452,16 @@ static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
 
 typedef bool (*exit_handler_fn)(struct kvm_vcpu *, u64 *);
 
-static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu);
-
-static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code);
-
 /*
  * Allow the hypervisor to handle the exit with an exit handler if it has one.
  *
  * Returns true if the hypervisor handled the exit, and control should go back
  * to the guest, or false if it hasn't.
  */
-static inline bool kvm_hyp_handle_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_exit(struct kvm_vcpu *vcpu, u64 *exit_code,
+				       const exit_handler_fn *handlers)
 {
-	const exit_handler_fn *handlers = kvm_get_exit_handler_array(vcpu);
-	exit_handler_fn fn;
-
-	fn = handlers[kvm_vcpu_trap_get_class(vcpu)];
-
+	exit_handler_fn fn = handlers[kvm_vcpu_trap_get_class(vcpu)];
 	if (fn)
 		return fn(vcpu, exit_code);
 
@@ -448,20 +491,9 @@ static inline void synchronize_vcpu_pstate(struct kvm_vcpu *vcpu, u64 *exit_code
  * the guest, false when we should restore the host state and return to the
  * main run loop.
  */
-static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool __fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code,
+				      const exit_handler_fn *handlers)
 {
-	/*
-	 * Save PSTATE early so that we can evaluate the vcpu mode
-	 * early on.
-	 */
-	synchronize_vcpu_pstate(vcpu, exit_code);
-
-	/*
-	 * Check whether we want to repaint the state one way or
-	 * another.
-	 */
-	early_exit_filter(vcpu, exit_code);
-
 	if (ARM_EXCEPTION_CODE(*exit_code) != ARM_EXCEPTION_IRQ)
 		vcpu->arch.fault.esr_el2 = read_sysreg_el2(SYS_ESR);
 
@@ -491,7 +523,7 @@ static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 		goto exit;
 
 	/* Check if there's an exit handler and allow it to handle the exit. */
-	if (kvm_hyp_handle_exit(vcpu, exit_code))
+	if (kvm_hyp_handle_exit(vcpu, exit_code, handlers))
 		goto guest;
 exit:
 	/* Return to the host kernel and handle the exit */
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 3cea4b6ac23e..b183cc866404 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -5,6 +5,7 @@
  */
 
 #include <hyp/adjust_pc.h>
+#include <hyp/switch.h>
 
 #include <asm/pgtable-types.h>
 #include <asm/kvm_asm.h>
@@ -25,7 +26,9 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
 
+	fpsimd_lazy_switch_to_guest(kern_hyp_va(vcpu));
 	cpu_reg(host_ctxt, 1) =  __kvm_vcpu_run(kern_hyp_va(vcpu));
+	fpsimd_lazy_switch_to_host(kern_hyp_va(vcpu));
 }
 
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
@@ -285,11 +288,6 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 	case ESR_ELx_EC_SMC64:
 		handle_host_smc(host_ctxt);
 		break;
-	case ESR_ELx_EC_SVE:
-		sysreg_clear_set(cptr_el2, CPTR_EL2_TZ, 0);
-		isb();
-		sve_cond_update_zcr_vq(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
-		break;
 	case ESR_ELx_EC_IABT_LOW:
 	case ESR_ELx_EC_DABT_LOW:
 		handle_host_mem_abort(host_ctxt);
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 85d3b7ae720f..6042cdd3d887 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -9,6 +9,8 @@
 #include <nvhe/fixed_config.h>
 #include <nvhe/trap_handler.h>
 
+unsigned int kvm_host_sve_max_vl;
+
 /*
  * Set trap register values based on features in ID_AA64PFR0.
  */
@@ -17,7 +19,6 @@ static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
 	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64PFR0_EL1);
 	u64 hcr_set = HCR_RW;
 	u64 hcr_clear = 0;
-	u64 cptr_set = 0;
 
 	/* Protected KVM does not support AArch32 guests. */
 	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0),
@@ -44,16 +45,10 @@ static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
 	/* Trap AMU */
 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_AMU), feature_ids)) {
 		hcr_clear |= HCR_AMVOFFEN;
-		cptr_set |= CPTR_EL2_TAM;
 	}
 
-	/* Trap SVE */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_SVE), feature_ids))
-		cptr_set |= CPTR_EL2_TZ;
-
 	vcpu->arch.hcr_el2 |= hcr_set;
 	vcpu->arch.hcr_el2 &= ~hcr_clear;
-	vcpu->arch.cptr_el2 |= cptr_set;
 }
 
 /*
@@ -83,7 +78,6 @@ static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
 	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64DFR0_EL1);
 	u64 mdcr_set = 0;
 	u64 mdcr_clear = 0;
-	u64 cptr_set = 0;
 
 	/* Trap/constrain PMU */
 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), feature_ids)) {
@@ -110,13 +104,8 @@ static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_TraceFilt), feature_ids))
 		mdcr_set |= MDCR_EL2_TTRF;
 
-	/* Trap Trace */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_TraceVer), feature_ids))
-		cptr_set |= CPTR_EL2_TTA;
-
 	vcpu->arch.mdcr_el2 |= mdcr_set;
 	vcpu->arch.mdcr_el2 &= ~mdcr_clear;
-	vcpu->arch.cptr_el2 |= cptr_set;
 }
 
 /*
@@ -167,8 +156,6 @@ static void pvm_init_trap_regs(struct kvm_vcpu *vcpu)
 	/* Clear res0 and set res1 bits to trap potential new features. */
 	vcpu->arch.hcr_el2 &= ~(HCR_RES0);
 	vcpu->arch.mdcr_el2 &= ~(MDCR_EL2_RES0);
-	vcpu->arch.cptr_el2 |= CPTR_NVHE_EL2_RES1;
-	vcpu->arch.cptr_el2 &= ~(CPTR_NVHE_EL2_RES0);
 }
 
 /*
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 895fb3200076..47c7f3a675ae 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -36,23 +36,54 @@ DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
 extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
 
-static void __activate_traps(struct kvm_vcpu *vcpu)
+static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 {
-	u64 val;
+	u64 val = CPTR_EL2_TAM;	/* Same bit irrespective of E2H */
 
-	___activate_traps(vcpu);
-	__activate_traps_common(vcpu);
-
-	val = vcpu->arch.cptr_el2;
-	val |= CPTR_EL2_TTA | CPTR_EL2_TAM;
-	if (!guest_owns_fp_regs(vcpu)) {
-		val |= CPTR_EL2_TFP | CPTR_EL2_TZ;
+	if (!guest_owns_fp_regs(vcpu))
 		__activate_traps_fpsimd32(vcpu);
-	}
-	if (cpus_have_final_cap(ARM64_SME))
+
+	/* !hVHE case upstream */
+	if (1) {
+		val |= CPTR_EL2_TTA | CPTR_NVHE_EL2_RES1;
+
+		/*
+		 * Always trap SME since it's not supported in KVM.
+		 * TSM is RES1 if SME isn't implemented.
+		 */
 		val |= CPTR_EL2_TSM;
 
-	write_sysreg(val, cptr_el2);
+		if (!vcpu_has_sve(vcpu) || !guest_owns_fp_regs(vcpu))
+			val |= CPTR_EL2_TZ;
+
+		if (!guest_owns_fp_regs(vcpu))
+			val |= CPTR_EL2_TFP;
+
+		write_sysreg(val, cptr_el2);
+	}
+}
+
+static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
+{
+	/* !hVHE case upstream */
+	if (1) {
+		u64 val = CPTR_NVHE_EL2_RES1;
+
+		if (!cpus_have_final_cap(ARM64_SVE))
+			val |= CPTR_EL2_TZ;
+		if (!cpus_have_final_cap(ARM64_SME))
+			val |= CPTR_EL2_TSM;
+
+		write_sysreg(val, cptr_el2);
+	}
+}
+
+static void __activate_traps(struct kvm_vcpu *vcpu)
+{
+	___activate_traps(vcpu);
+	__activate_traps_common(vcpu);
+	__activate_cptr_traps(vcpu);
+
 	write_sysreg(__this_cpu_read(kvm_hyp_vector), vbar_el2);
 
 	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
@@ -73,7 +104,6 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 static void __deactivate_traps(struct kvm_vcpu *vcpu)
 {
 	extern char __kvm_hyp_host_vector[];
-	u64 cptr;
 
 	___deactivate_traps(vcpu);
 
@@ -98,13 +128,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
 
-	cptr = CPTR_EL2_DEFAULT;
-	if (vcpu_has_sve(vcpu) && (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED))
-		cptr |= CPTR_EL2_TZ;
-	if (cpus_have_final_cap(ARM64_SME))
-		cptr &= ~CPTR_EL2_TSM;
-
-	write_sysreg(cptr, cptr_el2);
+	__deactivate_cptr_traps(vcpu);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
 }
 
@@ -209,21 +233,22 @@ static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
 	return hyp_exit_handlers;
 }
 
-/*
- * Some guests (e.g., protected VMs) are not be allowed to run in AArch32.
- * The ARMv8 architecture does not give the hypervisor a mechanism to prevent a
- * guest from dropping to AArch32 EL0 if implemented by the CPU. If the
- * hypervisor spots a guest in such a state ensure it is handled, and don't
- * trust the host to spot or fix it.  The check below is based on the one in
- * kvm_arch_vcpu_ioctl_run().
- *
- * Returns false if the guest ran in AArch32 when it shouldn't have, and
- * thus should exit to the host, or true if a the guest run loop can continue.
- */
-static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
+	const exit_handler_fn *handlers = kvm_get_exit_handler_array(vcpu);
 	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
 
+	synchronize_vcpu_pstate(vcpu, exit_code);
+
+	/*
+	 * Some guests (e.g., protected VMs) are not be allowed to run in
+	 * AArch32.  The ARMv8 architecture does not give the hypervisor a
+	 * mechanism to prevent a guest from dropping to AArch32 EL0 if
+	 * implemented by the CPU. If the hypervisor spots a guest in such a
+	 * state ensure it is handled, and don't trust the host to spot or fix
+	 * it.  The check below is based on the one in
+	 * kvm_arch_vcpu_ioctl_run().
+	 */
 	if (kvm_vm_is_protected(kvm) && vcpu_mode_is_32bit(vcpu)) {
 		/*
 		 * As we have caught the guest red-handed, decide that it isn't
@@ -236,6 +261,8 @@ static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
 		*exit_code &= BIT(ARM_EXIT_WITH_SERROR_BIT);
 		*exit_code |= ARM_EXCEPTION_IL;
 	}
+
+	return __fixup_guest_exit(vcpu, exit_code, handlers);
 }
 
 /* Switch to the guest for legacy non-VHE systems */
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 45ac4a59cc2c..179152bb9e42 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -114,13 +114,11 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
 };
 
-static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
+static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
-	return hyp_exit_handlers;
-}
+	synchronize_vcpu_pstate(vcpu, exit_code);
 
-static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
-{
+	return __fixup_guest_exit(vcpu, exit_code, hyp_exit_handlers);
 }
 
 /* Switch to the guest for VHE systems running in EL2 */
@@ -136,6 +134,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_save_host_state_vhe(host_ctxt);
 
+	fpsimd_lazy_switch_to_guest(vcpu);
+
 	/*
 	 * ARM erratum 1165522 requires us to configure both stage 1 and
 	 * stage 2 translation for the guest context before we clear
@@ -166,6 +166,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	__deactivate_traps(vcpu);
 
+	fpsimd_lazy_switch_to_host(vcpu);
+
 	sysreg_restore_host_state_vhe(host_ctxt);
 
 	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED)
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index f9d070473614..54e00ee631a0 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -42,11 +42,14 @@ static u32 kvm_ipa_limit;
 				 PSR_AA32_I_BIT | PSR_AA32_F_BIT)
 
 unsigned int kvm_sve_max_vl;
+unsigned int kvm_host_sve_max_vl;
 
 int kvm_arm_init_sve(void)
 {
 	if (system_supports_sve()) {
 		kvm_sve_max_vl = sve_max_virtualisable_vl();
+		kvm_host_sve_max_vl = sve_max_vl();
+		kvm_nvhe_sym(kvm_host_sve_max_vl) = kvm_host_sve_max_vl;
 
 		/*
 		 * The get_sve_reg()/set_sve_reg() ioctl interface will need
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f095b99bb214..cd14c3c22320 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1578,7 +1578,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
 		__remove_pgd_mapping(swapper_pg_dir,
 				     __phys_to_virt(start), size);
 	else {
-		max_pfn = PFN_UP(start + size);
+		/* Address of hotplugged memory can be smaller */
+		max_pfn = max(max_pfn, PFN_UP(start + size));
 		max_low_pfn = max_pfn;
 	}
 
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 8319cc409009..4dd55a50d89e 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -173,18 +173,6 @@ static __init int setup_node(int pxm)
 	return acpi_map_pxm_to_node(pxm);
 }
 
-/*
- * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
- * I/O localities since SRAT does not list them.  I/O localities are
- * not supported at this point.
- */
-unsigned int numa_distance_cnt;
-
-static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
-{
-	return slit->locality_count;
-}
-
 void __init numa_set_distance(int from, int to, int distance)
 {
 	if ((u8)distance != distance || (from == to && distance != LOCAL_DISTANCE)) {
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index d53919729f92..93e9110aafa1 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -142,8 +142,6 @@ static void build_prologue(struct jit_ctx *ctx)
 	 */
 	if (seen_tail_call(ctx) && seen_call(ctx))
 		move_reg(ctx, TCC_SAVED, REG_TCC);
-	else
-		emit_insn(ctx, nop);
 
 	ctx->stack_size = stack_adjust;
 }
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index d9421469a731..684b22f54ccc 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -25,11 +25,6 @@ struct jit_data {
 	struct jit_ctx ctx;
 };
 
-static inline void emit_nop(union loongarch_instruction *insn)
-{
-	insn->word = INSN_NOP;
-}
-
 #define emit_insn(ctx, func, ...)						\
 do {										\
 	if (ctx->image != NULL) {						\
diff --git a/arch/mips/dec/prom/init.c b/arch/mips/dec/prom/init.c
index cb12eb211a49..8d74d7d6c05b 100644
--- a/arch/mips/dec/prom/init.c
+++ b/arch/mips/dec/prom/init.c
@@ -42,7 +42,7 @@ int (*__pmax_close)(int);
  * Detect which PROM the DECSTATION has, and set the callback vectors
  * appropriately.
  */
-void __init which_prom(s32 magic, s32 *prom_vec)
+static void __init which_prom(s32 magic, s32 *prom_vec)
 {
 	/*
 	 * No sign of the REX PROM's magic number means we assume a non-REX
diff --git a/arch/mips/include/asm/ds1287.h b/arch/mips/include/asm/ds1287.h
index 46cfb01f9a14..51cb61fd4c03 100644
--- a/arch/mips/include/asm/ds1287.h
+++ b/arch/mips/include/asm/ds1287.h
@@ -8,7 +8,7 @@
 #define __ASM_DS1287_H
 
 extern int ds1287_timer_state(void);
-extern void ds1287_set_base_clock(unsigned int clock);
+extern int ds1287_set_base_clock(unsigned int hz);
 extern int ds1287_clockevent_init(int irq);
 
 #endif
diff --git a/arch/mips/kernel/cevt-ds1287.c b/arch/mips/kernel/cevt-ds1287.c
index 9a47fbcd4638..de64d6bb7ba3 100644
--- a/arch/mips/kernel/cevt-ds1287.c
+++ b/arch/mips/kernel/cevt-ds1287.c
@@ -10,6 +10,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/irq.h>
 
+#include <asm/ds1287.h>
 #include <asm/time.h>
 
 int ds1287_timer_state(void)
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index f8d3caad4cf3..3c06c8389e05 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -25,6 +25,7 @@
 #include <linux/reboot.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/nospec.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 
@@ -1178,6 +1179,9 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	    || nargs + nret > ARRAY_SIZE(args.args))
 		return -EINVAL;
 
+	nargs = array_index_nospec(nargs, ARRAY_SIZE(args.args));
+	nret = array_index_nospec(nret, ARRAY_SIZE(args.args) - nargs);
+
 	/* Copy in args. */
 	if (copy_from_user(args.args, uargs->args,
 			   nargs * sizeof(rtas_arg_t)) != 0)
diff --git a/arch/riscv/include/asm/kgdb.h b/arch/riscv/include/asm/kgdb.h
index 46677daf708b..cc11c4544cff 100644
--- a/arch/riscv/include/asm/kgdb.h
+++ b/arch/riscv/include/asm/kgdb.h
@@ -19,16 +19,9 @@
 
 #ifndef	__ASSEMBLY__
 
+void arch_kgdb_breakpoint(void);
 extern unsigned long kgdb_compiled_break;
 
-static inline void arch_kgdb_breakpoint(void)
-{
-	asm(".global kgdb_compiled_break\n"
-	    ".option norvc\n"
-	    "kgdb_compiled_break: ebreak\n"
-	    ".option rvc\n");
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #define DBG_REG_ZERO "zero"
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 384a63b86420..8426c4510d31 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -61,8 +61,11 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 unsigned long *args)
 {
 	args[0] = regs->orig_a0;
-	args++;
-	memcpy(args, &regs->a1, 5 * sizeof(args[0]));
+	args[1] = regs->a1;
+	args[2] = regs->a2;
+	args[3] = regs->a3;
+	args[4] = regs->a4;
+	args[5] = regs->a5;
 }
 
 static inline int syscall_get_arch(struct task_struct *task)
diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 963ed7edcff2..1d83b3696721 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -273,6 +273,12 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 	regs->epc = pc;
 }
 
+noinline void arch_kgdb_breakpoint(void)
+{
+	asm(".global kgdb_compiled_break\n"
+	    "kgdb_compiled_break: ebreak\n");
+}
+
 void kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
 				char *remcom_out_buffer)
 {
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2acf51c23567..f4c3252abce4 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -76,6 +76,9 @@ static struct resource bss_res = { .name = "Kernel bss", };
 static struct resource elfcorehdr_res = { .name = "ELF Core hdr", };
 #endif
 
+static int num_standard_resources;
+static struct resource *standard_resources;
+
 static int __init add_resource(struct resource *parent,
 				struct resource *res)
 {
@@ -149,7 +152,7 @@ static void __init init_resources(void)
 	struct resource *res = NULL;
 	struct resource *mem_res = NULL;
 	size_t mem_res_sz = 0;
-	int num_resources = 0, res_idx = 0;
+	int num_resources = 0, res_idx = 0, non_resv_res = 0;
 	int ret = 0;
 
 	/* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
@@ -213,6 +216,7 @@ static void __init init_resources(void)
 	/* Add /memory regions to the resource tree */
 	for_each_mem_region(region) {
 		res = &mem_res[res_idx--];
+		non_resv_res++;
 
 		if (unlikely(memblock_is_nomap(region))) {
 			res->name = "Reserved";
@@ -230,6 +234,9 @@ static void __init init_resources(void)
 			goto error;
 	}
 
+	num_standard_resources = non_resv_res;
+	standard_resources = &mem_res[res_idx + 1];
+
 	/* Clean-up any unused pre-allocated resources */
 	if (res_idx >= 0)
 		memblock_free(mem_res, (res_idx + 1) * sizeof(*mem_res));
@@ -241,6 +248,33 @@ static void __init init_resources(void)
 	memblock_free(mem_res, mem_res_sz);
 }
 
+static int __init reserve_memblock_reserved_regions(void)
+{
+	u64 i, j;
+
+	for (i = 0; i < num_standard_resources; i++) {
+		struct resource *mem = &standard_resources[i];
+		phys_addr_t r_start, r_end, mem_size = resource_size(mem);
+
+		if (!memblock_is_region_reserved(mem->start, mem_size))
+			continue;
+
+		for_each_reserved_mem_range(j, &r_start, &r_end) {
+			resource_size_t start, end;
+
+			start = max(PFN_PHYS(PFN_DOWN(r_start)), mem->start);
+			end = min(PFN_PHYS(PFN_UP(r_end)) - 1, mem->end);
+
+			if (start > mem->end || end < mem->start)
+				continue;
+
+			reserve_region_with_split(mem, start, end, "Reserved");
+		}
+	}
+
+	return 0;
+}
+arch_initcall(reserve_memblock_reserved_regions);
 
 static void __init parse_dtb(void)
 {
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 946f33c1b032..4b762c35b608 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -52,8 +52,10 @@ void flush_tlb_pending(void)
 
 void arch_enter_lazy_mmu_mode(void)
 {
-	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
+	struct tlb_batch *tb;
 
+	preempt_disable();
+	tb = this_cpu_ptr(&tlb_batch);
 	tb->active = 1;
 }
 
@@ -64,6 +66,7 @@ void arch_leave_lazy_mmu_mode(void)
 	if (tb->tlb_nr)
 		flush_tlb_pending();
 	tb->active = 0;
+	preempt_enable();
 }
 
 static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 413f9dcff601..4b7faa3180e5 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1149,8 +1149,10 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	 * + precise_ip < 2 for the non event IP
 	 * + For RTM TSX weight we need GPRs for the abort code.
 	 */
-	gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
-	       (attr->sample_regs_intr & PEBS_GP_REGS);
+	gprs = ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+		(attr->sample_regs_intr & PEBS_GP_REGS)) ||
+	       ((sample_type & PERF_SAMPLE_REGS_USER) &&
+		(attr->sample_regs_user & PEBS_GP_REGS));
 
 	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT_TYPE) &&
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
@@ -1792,7 +1794,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			regs->flags &= ~PERF_EFLAGS_EXACT;
 		}
 
-		if (sample_type & PERF_SAMPLE_REGS_INTR)
+		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
 			adaptive_pebs_save_regs(regs, gprs);
 	}
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index d081eb89ba12..831c4e3f371a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4656,28 +4656,28 @@ static struct uncore_event_desc snr_uncore_iio_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
 	/* Free-Running IIO BANDWIDTH IN Counters */
 	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
 	{ /* end: all zeroes */ },
 };
@@ -5250,37 +5250,6 @@ static struct freerunning_counters icx_iio_freerunning[] = {
 	[ICX_IIO_MSR_BW_IN]	= { 0xaa0, 0x1, 0x10, 8, 48, icx_iio_bw_freerunning_box_offsets },
 };
 
-static struct uncore_event_desc icx_uncore_iio_freerunning_events[] = {
-	/* Free-Running IIO CLOCKS Counter */
-	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
-	/* Free-Running IIO BANDWIDTH IN Counters */
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
-	{ /* end: all zeroes */ },
-};
-
 static struct intel_uncore_type icx_uncore_iio_free_running = {
 	.name			= "iio_free_running",
 	.num_counters		= 9,
@@ -5288,7 +5257,7 @@ static struct intel_uncore_type icx_uncore_iio_free_running = {
 	.num_freerunning_types	= ICX_IIO_FREERUNNING_TYPE_MAX,
 	.freerunning		= icx_iio_freerunning,
 	.ops			= &skx_uncore_iio_freerunning_ops,
-	.event_descs		= icx_uncore_iio_freerunning_events,
+	.event_descs		= snr_uncore_iio_freerunning_events,
 	.format_group		= &skx_uncore_iio_freerunning_format_group,
 };
 
@@ -5857,69 +5826,13 @@ static struct freerunning_counters spr_iio_freerunning[] = {
 	[SPR_IIO_MSR_BW_OUT]	= { 0x3808, 0x1, 0x10, 8, 48 },
 };
 
-static struct uncore_event_desc spr_uncore_iio_freerunning_events[] = {
-	/* Free-Running IIO CLOCKS Counter */
-	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
-	/* Free-Running IIO BANDWIDTH IN Counters */
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
-	/* Free-Running IIO BANDWIDTH OUT Counters */
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0,		"event=0xff,umask=0x30"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1,		"event=0xff,umask=0x31"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2,		"event=0xff,umask=0x32"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3,		"event=0xff,umask=0x33"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port4,		"event=0xff,umask=0x34"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port4.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port4.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port5,		"event=0xff,umask=0x35"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port5.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port5.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port6,		"event=0xff,umask=0x36"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port6.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port6.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port7,		"event=0xff,umask=0x37"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port7.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port7.unit,	"MiB"),
-	{ /* end: all zeroes */ },
-};
-
 static struct intel_uncore_type spr_uncore_iio_free_running = {
 	.name			= "iio_free_running",
 	.num_counters		= 17,
 	.num_freerunning_types	= SPR_IIO_FREERUNNING_TYPE_MAX,
 	.freerunning		= spr_iio_freerunning,
 	.ops			= &skx_uncore_iio_freerunning_ops,
-	.event_descs		= spr_uncore_iio_freerunning_events,
+	.event_descs		= snr_uncore_iio_freerunning_events,
 	.format_group		= &skx_uncore_iio_freerunning_format_group,
 };
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 37796a1d0715..9ac93b4ba67b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -787,7 +787,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	 * (model = 0x14) and later actually support it.
 	 * (AMD Erratum #110, docId: 25759).
 	 */
-	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM)) {
+	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		clear_cpu_cap(c, X86_FEATURE_LAHF_LM);
 		if (!rdmsrl_amd_safe(0xc001100d, &value)) {
 			value &= ~BIT_64(32);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index b91f3d72bcdd..2c43a1423b09 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1204,7 +1204,13 @@ static void __split_lock_reenable(struct work_struct *work)
 {
 	sld_update_msr(true);
 }
-static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
+/*
+ * In order for each CPU to schedule its delayed work independently of the
+ * others, delayed work struct must be per-CPU. This is not required when
+ * sysctl_sld_mitigate is enabled because of the semaphore that limits
+ * the number of simultaneously scheduled delayed works to 1.
+ */
+static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
 
 /*
  * If a CPU goes offline with pending delayed work to re-enable split lock
@@ -1225,7 +1231,7 @@ static int splitlock_cpu_offline(unsigned int cpu)
 
 static void split_lock_warn(unsigned long ip)
 {
-	struct delayed_work *work;
+	struct delayed_work *work = NULL;
 	int cpu;
 
 	if (!current->reported_split_lock)
@@ -1247,11 +1253,17 @@ static void split_lock_warn(unsigned long ip)
 		if (down_interruptible(&buslock_sem) == -EINTR)
 			return;
 		work = &sl_reenable_unlock;
-	} else {
-		work = &sl_reenable;
 	}
 
 	cpu = get_cpu();
+
+	if (!work) {
+		work = this_cpu_ptr(&sl_reenable);
+		/* Deferred initialization of per-CPU struct */
+		if (!work->work.func)
+			INIT_DELAYED_WORK(work, __split_lock_reenable);
+	}
+
 	schedule_delayed_work_on(cpu, work, 2);
 
 	/* Disable split lock detection on this CPU to make progress */
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 993734e96615..b87a3f8ccb32 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -753,22 +753,21 @@ void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
 void __init e820__register_nosave_regions(unsigned long limit_pfn)
 {
 	int i;
-	unsigned long pfn = 0;
+	u64 last_addr = 0;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry = &e820_table->entries[i];
 
-		if (pfn < PFN_UP(entry->addr))
-			register_nosave_region(pfn, PFN_UP(entry->addr));
-
-		pfn = PFN_DOWN(entry->addr + entry->size);
-
 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
-			register_nosave_region(PFN_UP(entry->addr), pfn);
+			continue;
 
-		if (pfn >= limit_pfn)
-			break;
+		if (last_addr < entry->addr)
+			register_nosave_region(PFN_DOWN(last_addr), PFN_UP(entry->addr));
+
+		last_addr = entry->addr + entry->size;
 	}
+
+	register_nosave_region(PFN_DOWN(last_addr), limit_pfn);
 }
 
 #ifdef CONFIG_ACPI
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 19ce8199f347..4d5be4956c48 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11460,6 +11460,8 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 	if (kvm_mpx_supported())
 		kvm_load_guest_fpu(vcpu);
 
+	kvm_vcpu_srcu_read_lock(vcpu);
+
 	r = kvm_apic_accept_events(vcpu);
 	if (r < 0)
 		goto out;
@@ -11473,6 +11475,8 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 		mp_state->mp_state = vcpu->arch.mp_state;
 
 out:
+	kvm_vcpu_srcu_read_unlock(vcpu);
+
 	if (kvm_mpx_supported())
 		kvm_put_guest_fpu(vcpu);
 	vcpu_put(vcpu);
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 7fe564eaf228..9e6a27018d0f 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -100,7 +100,12 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	xor %edx, %edx
 	wrmsr
 
-	call xen_prepare_pvh
+	/* Call xen_prepare_pvh() via the kernel virtual mapping */
+	leaq xen_prepare_pvh(%rip), %rax
+	subq phys_base(%rip), %rax
+	addq $__START_KERNEL_map, %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call *%rax
 
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index cced5a2d5fb6..ef596fc10465 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -255,6 +255,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 		blkg->pd[i] = pd;
 		pd->blkg = blkg;
 		pd->plid = i;
+		pd->online = false;
 	}
 
 	return blkg;
@@ -326,8 +327,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
-			if (blkg->pd[i] && pol->pd_online_fn)
-				pol->pd_online_fn(blkg->pd[i]);
+			if (blkg->pd[i]) {
+				if (pol->pd_online_fn)
+					pol->pd_online_fn(blkg->pd[i]);
+				blkg->pd[i]->online = true;
+			}
 		}
 	}
 	blkg->online = true;
@@ -432,8 +436,11 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 
-		if (blkg->pd[i] && pol->pd_offline_fn)
-			pol->pd_offline_fn(blkg->pd[i]);
+		if (blkg->pd[i] && blkg->pd[i]->online) {
+			if (pol->pd_offline_fn)
+				pol->pd_offline_fn(blkg->pd[i]);
+			blkg->pd[i]->online = false;
+		}
 	}
 
 	blkg->online = false;
@@ -1422,6 +1429,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		blkg->pd[pol->plid] = pd;
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
+		pd->online = false;
 	}
 
 	/* all allocated, init in the same order */
@@ -1429,9 +1437,11 @@ int blkcg_activate_policy(struct request_queue *q,
 		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
 			pol->pd_init_fn(blkg->pd[pol->plid]);
 
-	if (pol->pd_online_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
+	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+		if (pol->pd_online_fn)
 			pol->pd_online_fn(blkg->pd[pol->plid]);
+		blkg->pd[pol->plid]->online = true;
+	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
@@ -1493,7 +1503,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 		spin_lock(&blkcg->lock);
 		if (blkg->pd[pol->plid]) {
-			if (pol->pd_offline_fn)
+			if (blkg->pd[pol->plid]->online && pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index aa2b286bc825..59815b269a20 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -125,6 +125,7 @@ struct blkg_policy_data {
 	/* the blkg and policy id this per-policy data belongs to */
 	struct blkcg_gq			*blkg;
 	int				plid;
+	bool				online;
 };
 
 /*
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index e270e64ba342..20993d79d5cc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1430,8 +1430,11 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
 	lockdep_assert_held(&iocg->ioc->lock);
 	lockdep_assert_held(&iocg->waitq.lock);
 
-	/* make sure that nobody messed with @iocg */
-	WARN_ON_ONCE(list_empty(&iocg->active_list));
+	/*
+	 * make sure that nobody messed with @iocg. Check iocg->pd.online
+	 * to avoid warn when removing blkcg or disk.
+	 */
+	WARN_ON_ONCE(list_empty(&iocg->active_list) && iocg->pd.online);
 	WARN_ON_ONCE(iocg->inuse > 1);
 
 	iocg->abs_vdebt -= min(abs_vpay, iocg->abs_vdebt);
diff --git a/certs/Makefile b/certs/Makefile
index 799ad7b9e68a..67e1f2707c2f 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -84,5 +84,5 @@ targets += x509_revocation_list
 
 hostprogs := extract-cert
 
-HOSTCFLAGS_extract-cert.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
+HOSTCFLAGS_extract-cert.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null) -I$(srctree)/scripts
 HOSTLDLIBS_extract-cert = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
diff --git a/certs/extract-cert.c b/certs/extract-cert.c
index 8c1fb9a70d66..0a89cdc3e185 100644
--- a/certs/extract-cert.c
+++ b/certs/extract-cert.c
@@ -21,14 +21,17 @@
 #include <openssl/bio.h>
 #include <openssl/pem.h>
 #include <openssl/err.h>
-#include <openssl/engine.h>
-
-/*
- * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
- *
- * Remove this if/when that API is no longer used
- */
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+#if OPENSSL_VERSION_MAJOR >= 3
+# define USE_PKCS11_PROVIDER
+# include <openssl/provider.h>
+# include <openssl/store.h>
+#else
+# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+#  define USE_PKCS11_ENGINE
+#  include <openssl/engine.h>
+# endif
+#endif
+#include "ssl-common.h"
 
 #define PKEY_ID_PKCS7 2
 
@@ -40,41 +43,6 @@ void format(void)
 	exit(2);
 }
 
-static void display_openssl_errors(int l)
-{
-	const char *file;
-	char buf[120];
-	int e, line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
-
-	while ((e = ERR_get_error_line(&file, &line))) {
-		ERR_error_string(e, buf);
-		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
-	}
-}
-
-static void drain_openssl_errors(void)
-{
-	const char *file;
-	int line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	while (ERR_get_error_line(&file, &line)) {}
-}
-
-#define ERR(cond, fmt, ...)				\
-	do {						\
-		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
-		if (__cond) {				\
-			err(1, fmt, ## __VA_ARGS__);	\
-		}					\
-	} while(0)
-
 static const char *key_pass;
 static BIO *wb;
 static char *cert_dst;
@@ -94,6 +62,66 @@ static void write_cert(X509 *x509)
 		fprintf(stderr, "Extracted cert: %s\n", buf);
 }
 
+static X509 *load_cert_pkcs11(const char *cert_src)
+{
+	X509 *cert = NULL;
+#ifdef USE_PKCS11_PROVIDER
+	OSSL_STORE_CTX *store;
+
+	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+		ERR(1, "OSSL_PROVIDER_try_load(default)");
+
+	store = OSSL_STORE_open(cert_src, NULL, NULL, NULL, NULL);
+	ERR(!store, "OSSL_STORE_open");
+
+	while (!OSSL_STORE_eof(store)) {
+		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
+
+		if (!info) {
+			drain_openssl_errors(__LINE__, 0);
+			continue;
+		}
+		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_CERT) {
+			cert = OSSL_STORE_INFO_get1_CERT(info);
+			ERR(!cert, "OSSL_STORE_INFO_get1_CERT");
+		}
+		OSSL_STORE_INFO_free(info);
+		if (cert)
+			break;
+	}
+	OSSL_STORE_close(store);
+#elif defined(USE_PKCS11_ENGINE)
+		ENGINE *e;
+		struct {
+			const char *cert_id;
+			X509 *cert;
+		} parms;
+
+		parms.cert_id = cert_src;
+		parms.cert = NULL;
+
+		ENGINE_load_builtin_engines();
+		drain_openssl_errors(__LINE__, 1);
+		e = ENGINE_by_id("pkcs11");
+		ERR(!e, "Load PKCS#11 ENGINE");
+		if (ENGINE_init(e))
+			drain_openssl_errors(__LINE__, 1);
+		else
+			ERR(1, "ENGINE_init");
+		if (key_pass)
+			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
+		ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms, NULL, 1);
+		ERR(!parms.cert, "Get X.509 from PKCS#11");
+		cert = parms.cert;
+#else
+		fprintf(stderr, "no pkcs11 engine/provider available\n");
+		exit(1);
+#endif
+	return cert;
+}
+
 int main(int argc, char **argv)
 {
 	char *cert_src;
@@ -119,28 +147,10 @@ int main(int argc, char **argv)
 		fclose(f);
 		exit(0);
 	} else if (!strncmp(cert_src, "pkcs11:", 7)) {
-		ENGINE *e;
-		struct {
-			const char *cert_id;
-			X509 *cert;
-		} parms;
-
-		parms.cert_id = cert_src;
-		parms.cert = NULL;
+		X509 *cert = load_cert_pkcs11(cert_src);
 
-		ENGINE_load_builtin_engines();
-		drain_openssl_errors();
-		e = ENGINE_by_id("pkcs11");
-		ERR(!e, "Load PKCS#11 ENGINE");
-		if (ENGINE_init(e))
-			drain_openssl_errors();
-		else
-			ERR(1, "ENGINE_init");
-		if (key_pass)
-			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
-		ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms, NULL, 1);
-		ERR(!parms.cert, "Get X.509 from PKCS#11");
-		write_cert(parms.cert);
+		ERR(!cert, "load_cert_pkcs11 failed");
+		write_cert(cert);
 	} else {
 		BIO *b;
 		X509 *x509;
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d418462ab791..89f34310237c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -22,8 +22,8 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
-static ssize_t platform_profile_choices_show(struct device *dev,
-					struct device_attribute *attr,
+static ssize_t platform_profile_choices_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
 					char *buf)
 {
 	int len = 0;
@@ -49,8 +49,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	return len;
 }
 
-static ssize_t platform_profile_show(struct device *dev,
-					struct device_attribute *attr,
+static ssize_t platform_profile_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
 					char *buf)
 {
 	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
@@ -77,8 +77,8 @@ static ssize_t platform_profile_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
 
-static ssize_t platform_profile_store(struct device *dev,
-			    struct device_attribute *attr,
+static ssize_t platform_profile_store(struct kobject *kobj,
+			    struct kobj_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int err, i;
@@ -115,12 +115,12 @@ static ssize_t platform_profile_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR_RO(platform_profile_choices);
-static DEVICE_ATTR_RW(platform_profile);
+static struct kobj_attribute attr_platform_profile_choices = __ATTR_RO(platform_profile_choices);
+static struct kobj_attribute attr_platform_profile = __ATTR_RW(platform_profile);
 
 static struct attribute *platform_profile_attrs[] = {
-	&dev_attr_platform_profile_choices.attr,
-	&dev_attr_platform_profile.attr,
+	&attr_platform_profile_choices.attr,
+	&attr_platform_profile.attr,
 	NULL
 };
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 20f53ae4d204..a4b0a499b67d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -592,6 +592,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3f327ba759fd..586982a2a61f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1510,8 +1510,15 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.command = ATA_CMD_PACKET;
 
-	/* is it pointless to prefer PIO for "safety reasons"? */
-	if (ap->flags & ATA_FLAG_PIO_DMA) {
+	/*
+	 * Do not use DMA if the connected device only supports PIO, even if the
+	 * port prefers PIO commands via DMA.
+	 *
+	 * Ideally, we should call atapi_check_dma() to check if it is safe for
+	 * the LLD to use DMA for REQUEST_SENSE, but we don't have a qc.
+	 * Since we can't check the command, perhaps we should only use pio?
+	 */
+	if ((ap->flags & ATA_FLAG_PIO_DMA) && !(dev->flags & ATA_DFLAG_PIO)) {
 		tf.protocol = ATAPI_PROT_DMA;
 		tf.feature |= ATAPI_PKT_DMA;
 	} else {
diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 985f42c4fd70..9113b74b2b67 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -223,10 +223,16 @@ static int pxa_ata_probe(struct platform_device *pdev)
 
 	ap->ioaddr.cmd_addr	= devm_ioremap(&pdev->dev, cmd_res->start,
 						resource_size(cmd_res));
+	if (!ap->ioaddr.cmd_addr)
+		return -ENOMEM;
 	ap->ioaddr.ctl_addr	= devm_ioremap(&pdev->dev, ctl_res->start,
 						resource_size(ctl_res));
+	if (!ap->ioaddr.ctl_addr)
+		return -ENOMEM;
 	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
 						resource_size(dma_res));
+	if (!ap->ioaddr.bmdma_addr)
+		return -ENOMEM;
 
 	/*
 	 * Adjust register offsets
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index fa1966638c06..c524634fd926 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1118,9 +1118,14 @@ static int pdc20621_prog_dimm0(struct ata_host *host)
 	mmio += PDC_CHIP0_OFS;
 
 	for (i = 0; i < ARRAY_SIZE(pdc_i2c_read_data); i++)
-		pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
-				  pdc_i2c_read_data[i].reg,
-				  &spd0[pdc_i2c_read_data[i].ofs]);
+		if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
+				       pdc_i2c_read_data[i].reg,
+				       &spd0[pdc_i2c_read_data[i].ofs])) {
+			dev_err(host->dev,
+				"Failed in i2c read at index %d: device=%#x, reg=%#x\n",
+				i, PDC_DIMM0_SPD_DEV_ADDRESS, pdc_i2c_read_data[i].reg);
+			return -EIO;
+		}
 
 	data |= (spd0[4] - 8) | ((spd0[21] != 0) << 3) | ((spd0[3]-11) << 4);
 	data |= ((spd0[17] / 4) << 6) | ((spd0[5] / 2) << 7) |
@@ -1285,6 +1290,8 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 
 	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
 	size = pdc20621_prog_dimm0(host);
+	if (size < 0)
+		return size;
 	dev_dbg(host->dev, "Local DIMM Size = %dMB\n", size);
 
 	/* Programming DIMM Module Global Control Register (index_CID0:88h) */
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 35d1e2864696..9d0ea5c14bc5 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -684,6 +684,13 @@ int devres_release_group(struct device *dev, void *id)
 		spin_unlock_irqrestore(&dev->devres_lock, flags);
 
 		release_nodes(dev, &todo);
+	} else if (list_empty(&dev->devres_head)) {
+		/*
+		 * dev is probably dying via devres_release_all(): groups
+		 * have already been removed and are on the process of
+		 * being released - don't touch and don't warn.
+		 */
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
 	} else {
 		WARN_ON(1);
 		spin_unlock_irqrestore(&dev->devres_lock, flags);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 041d307a2f28..1c356bda9dfa 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -624,19 +624,20 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	 * dependency.
 	 */
 	fput(old_file);
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	if (partscan)
 		loop_reread_partitions(lo);
 
 	error = 0;
 done:
-	/* enable and uncork uevent now that we are done */
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	return error;
 
 out_err:
 	loop_global_unlock(lo, is_loop);
 out_putf:
 	fput(file);
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	goto done;
 }
 
@@ -1104,8 +1105,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
-	/* enable and uncork uevent now that we are done */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 
 	loop_global_unlock(lo, is_loop);
 	if (partscan)
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 892e2540f008..5651f40db173 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -807,6 +807,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   const char *firmware_name)
 {
 	struct qca_fw_config config = {};
+	const char *variant = "";
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
@@ -901,13 +902,11 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		case QCA_WCN3990:
 		case QCA_WCN3991:
 		case QCA_WCN3998:
-			if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
-				snprintf(config.fwname, sizeof(config.fwname),
-					 "qca/crnv%02xu.bin", rom_ver);
-			} else {
-				snprintf(config.fwname, sizeof(config.fwname),
-					 "qca/crnv%02x.bin", rom_ver);
-			}
+			if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID)
+				variant = "u";
+
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/crnv%02x%s.bin", rom_ver, variant);
 			break;
 		case QCA_WCN3988:
 			snprintf(config.fwname, sizeof(config.fwname),
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 5671f0d9ab28..1c122613e562 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -817,6 +817,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			rtl_dev_err(hdev, "mandatory config file %s not found",
 				    btrtl_dev->ic_info->cfg_name);
 			ret = btrtl_dev->cfg_len;
+			if (!ret)
+				ret = -EINVAL;
 			goto err_free;
 		}
 	}
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index c1feebd9e3a0..6a90fc69ef44 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -102,7 +102,8 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 	if (!skb) {
 		percpu_down_read(&hu->proto_lock);
 
-		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+		    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 			skb = hu->proto->dequeue(hu);
 
 		percpu_up_read(&hu->proto_lock);
@@ -124,7 +125,8 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 	if (!percpu_down_read_trylock(&hu->proto_lock))
 		return 0;
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		goto no_schedule;
 
 	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
@@ -278,7 +280,8 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return -EUNATCH;
 	}
@@ -582,7 +585,8 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
 	if (tty != hu->tty)
 		return;
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+	    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		hci_uart_tx_wakeup(hu);
 }
 
@@ -608,7 +612,8 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return;
 	}
@@ -709,12 +714,16 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
+	set_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+	clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	return 0;
 }
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index fb4a2d0d8cc8..c6f13d7c22a2 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -90,6 +90,7 @@ struct hci_uart {
 #define HCI_UART_REGISTERED		1
 #define HCI_UART_PROTO_READY		2
 #define HCI_UART_NO_SUSPEND_NOTIFIER	3
+#define HCI_UART_PROTO_INIT		4
 
 /* TX states  */
 #define HCI_UART_SENDING	1
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 8378c3319cd5..b4bb4f8b8f44 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1201,11 +1201,16 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	struct mhi_ring_element *mhi_tre;
 	struct mhi_buf_info *buf_info;
 	int eot, eob, chain, bei;
-	int ret;
+	int ret = 0;
 
 	/* Protect accesses for reading and incrementing WP */
 	write_lock_bh(&mhi_chan->lock);
 
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	buf_ring = &mhi_chan->buf_ring;
 	tre_ring = &mhi_chan->tre_ring;
 
@@ -1223,10 +1228,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 
 	if (!info->pre_mapped) {
 		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
-		if (ret) {
-			write_unlock_bh(&mhi_chan->lock);
-			return ret;
-		}
+		if (ret)
+			goto out;
 	}
 
 	eob = !!(flags & MHI_EOB);
@@ -1243,9 +1246,10 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
 	mhi_add_ring_element(mhi_cntrl, buf_ring);
 
+out:
 	write_unlock_bh(&mhi_chan->lock);
 
-	return 0;
+	return ret;
 }
 
 int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 5889d9edaf94..caf9ba2dc0b1 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -104,11 +104,10 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		return 0;
 	/* process status changes without irq support */
 	do {
+		usleep_range(priv->timeout_min, priv->timeout_max);
 		status = chip->ops->status(chip);
 		if ((status & mask) == mask)
 			return 0;
-		usleep_range(priv->timeout_min,
-			     priv->timeout_max);
 	} while (time_before(jiffies, stop));
 	return -ETIME;
 }
@@ -433,7 +432,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
 					&priv->int_queue, false) < 0) {
-			rc = -ETIME;
+			if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
+				rc = -EAGAIN;
+			else
+				rc = -ETIME;
 			goto out_err;
 		}
 		status = tpm_tis_status(chip);
@@ -450,7 +452,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
 				&priv->int_queue, false) < 0) {
-		rc = -ETIME;
+		if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
+			rc = -EAGAIN;
+		else
+			rc = -ETIME;
 		goto out_err;
 	}
 	status = tpm_tis_status(chip);
@@ -505,9 +510,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 		if (rc >= 0)
 			/* Data transfer done successfully */
 			break;
-		else if (rc != -EIO)
+		else if (rc != -EAGAIN && rc != -EIO)
 			/* Data transfer failed, not recoverable */
 			return rc;
+
+		usleep_range(priv->timeout_min, priv->timeout_max);
 	}
 
 	rc = tpm_tis_verify_crc(priv, len, buf);
@@ -1044,6 +1051,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
 	}
 
+	if (priv->manufacturer_id == TPM_VID_IFX)
+		set_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags);
+
 	if (is_bsw()) {
 		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
 					ILB_REMAP_SIZE);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 610bfadb6acf..be72681ab8ea 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -88,6 +88,7 @@ enum tpm_tis_flags {
 	TPM_TIS_INVALID_STATUS		= 1,
 	TPM_TIS_DEFAULT_CANCELLATION	= 2,
 	TPM_TIS_IRQ_TESTED		= 3,
+	TPM_TIS_STATUS_VALID_RETRY	= 4,
 };
 
 struct tpm_tis_data {
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 0f21a8a767ac..bb6d39572d7f 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -290,6 +290,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	 */
 	udelay(1);
 
+	if (sc->flags & RETAIN_FF_ENABLE)
+		gdsc_retain_ff_on(sc);
+
 	/* Turn on HW trigger mode if supported */
 	if (sc->flags & HW_CTRL) {
 		ret = gdsc_hwctrl(sc, true);
@@ -306,9 +309,6 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 		udelay(1);
 	}
 
-	if (sc->flags & RETAIN_FF_ENABLE)
-		gdsc_retain_ff_on(sc);
-
 	return 0;
 }
 
@@ -418,13 +418,6 @@ static int gdsc_init(struct gdsc *sc)
 				goto err_disable_supply;
 		}
 
-		/* Turn on HW trigger mode if supported */
-		if (sc->flags & HW_CTRL) {
-			ret = gdsc_hwctrl(sc, true);
-			if (ret < 0)
-				goto err_disable_supply;
-		}
-
 		/*
 		 * Make sure the retain bit is set if the GDSC is already on,
 		 * otherwise we end up turning off the GDSC and destroying all
@@ -432,6 +425,14 @@ static int gdsc_init(struct gdsc *sc)
 		 */
 		if (sc->flags & RETAIN_FF_ENABLE)
 			gdsc_retain_ff_on(sc);
+
+		/* Turn on HW trigger mode if supported */
+		if (sc->flags & HW_CTRL) {
+			ret = gdsc_hwctrl(sc, true);
+			if (ret < 0)
+				goto err_disable_supply;
+		}
+
 	} else if (sc->flags & ALWAYS_ON) {
 		/* If ALWAYS_ON GDSCs are not ON, turn them ON */
 		gdsc_enable(&sc->pd);
@@ -463,6 +464,23 @@ static int gdsc_init(struct gdsc *sc)
 	return ret;
 }
 
+static void gdsc_pm_subdomain_remove(struct gdsc_desc *desc, size_t num)
+{
+	struct device *dev = desc->dev;
+	struct gdsc **scs = desc->scs;
+	int i;
+
+	/* Remove subdomains */
+	for (i = num - 1; i >= 0; i--) {
+		if (!scs[i])
+			continue;
+		if (scs[i]->parent)
+			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
+		else if (!IS_ERR_OR_NULL(dev->pm_domain))
+			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+	}
+}
+
 int gdsc_register(struct gdsc_desc *desc,
 		  struct reset_controller_dev *rcdev, struct regmap *regmap)
 {
@@ -507,30 +525,27 @@ int gdsc_register(struct gdsc_desc *desc,
 		if (!scs[i])
 			continue;
 		if (scs[i]->parent)
-			pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
+			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
 		else if (!IS_ERR_OR_NULL(dev->pm_domain))
-			pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		if (ret)
+			goto err_pm_subdomain_remove;
 	}
 
 	return of_genpd_add_provider_onecell(dev->of_node, data);
+
+err_pm_subdomain_remove:
+	gdsc_pm_subdomain_remove(desc, i);
+
+	return ret;
 }
 
 void gdsc_unregister(struct gdsc_desc *desc)
 {
-	int i;
 	struct device *dev = desc->dev;
-	struct gdsc **scs = desc->scs;
 	size_t num = desc->num;
 
-	/* Remove subdomains */
-	for (i = 0; i < num; i++) {
-		if (!scs[i])
-			continue;
-		if (scs[i]->parent)
-			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
-		else if (!IS_ERR_OR_NULL(dev->pm_domain))
-			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
-	}
+	gdsc_pm_subdomain_remove(desc, num);
 	of_genpd_del_provider(dev->of_node);
 }
 
diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index db2841d0beb8..90c10f378df2 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -168,9 +168,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_bool(pdev->dev.parent->of_node, "wakeup-source")) {
-		ret = device_init_wakeup(&pdev->dev, true);
-		if (ret)
-			goto out_clk_disable;
+		device_set_wakeup_capable(&pdev->dev, true);
 
 		ret = dev_pm_set_wake_irq(&pdev->dev, irq);
 		if (ret)
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 04d89cf0d71d..779ec6e510f7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2673,10 +2673,18 @@ EXPORT_SYMBOL(cpufreq_update_policy);
  */
 void cpufreq_update_limits(unsigned int cpu)
 {
+	struct cpufreq_policy *policy;
+
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return;
+
 	if (cpufreq_driver->update_limits)
 		cpufreq_driver->update_limits(cpu);
 	else
 		cpufreq_update_policy(cpu);
+
+	cpufreq_cpu_put(policy);
 }
 EXPORT_SYMBOL_GPL(cpufreq_update_limits);
 
diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index 9f6db61e5c0d..df12b562ad3b 100644
--- a/drivers/crypto/caam/qi.c
+++ b/drivers/crypto/caam/qi.c
@@ -115,12 +115,12 @@ int caam_qi_enqueue(struct device *qidev, struct caam_drv_req *req)
 	qm_fd_addr_set64(&fd, addr);
 
 	do {
+		refcount_inc(&req->drv_ctx->refcnt);
 		ret = qman_enqueue(req->drv_ctx->req_fq, &fd);
-		if (likely(!ret)) {
-			refcount_inc(&req->drv_ctx->refcnt);
+		if (likely(!ret))
 			return 0;
-		}
 
+		refcount_dec(&req->drv_ctx->refcnt);
 		if (ret != -EBUSY)
 			break;
 		num_retries++;
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 55411b494d69..32c0b2744654 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -179,14 +179,17 @@ static bool sp_pci_is_master(struct sp_device *sp)
 	pdev_new = to_pci_dev(dev_new);
 	pdev_cur = to_pci_dev(dev_cur);
 
-	if (pdev_new->bus->number < pdev_cur->bus->number)
-		return true;
+	if (pci_domain_nr(pdev_new->bus) != pci_domain_nr(pdev_cur->bus))
+		return pci_domain_nr(pdev_new->bus) < pci_domain_nr(pdev_cur->bus);
 
-	if (PCI_SLOT(pdev_new->devfn) < PCI_SLOT(pdev_cur->devfn))
-		return true;
+	if (pdev_new->bus->number != pdev_cur->bus->number)
+		return pdev_new->bus->number < pdev_cur->bus->number;
 
-	if (PCI_FUNC(pdev_new->devfn) < PCI_FUNC(pdev_cur->devfn))
-		return true;
+	if (PCI_SLOT(pdev_new->devfn) != PCI_SLOT(pdev_cur->devfn))
+		return PCI_SLOT(pdev_new->devfn) < PCI_SLOT(pdev_cur->devfn);
+
+	if (PCI_FUNC(pdev_new->devfn) != PCI_FUNC(pdev_cur->devfn))
+		return PCI_FUNC(pdev_new->devfn) < PCI_FUNC(pdev_cur->devfn);
 
 	return false;
 }
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 54d9fa7da9c1..7185554b025e 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -753,6 +753,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	struct gpio_irq_chip *irq;
 	struct tegra_gpio *gpio;
 	struct device_node *np;
+	struct resource *res;
 	char **names;
 	int err;
 
@@ -772,19 +773,19 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->num_banks++;
 
 	/* get register apertures */
-	gpio->secure = devm_platform_ioremap_resource_byname(pdev, "security");
-	if (IS_ERR(gpio->secure)) {
-		gpio->secure = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(gpio->secure))
-			return PTR_ERR(gpio->secure);
-	}
-
-	gpio->base = devm_platform_ioremap_resource_byname(pdev, "gpio");
-	if (IS_ERR(gpio->base)) {
-		gpio->base = devm_platform_ioremap_resource(pdev, 1);
-		if (IS_ERR(gpio->base))
-			return PTR_ERR(gpio->base);
-	}
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "security");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gpio->secure = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gpio->secure))
+		return PTR_ERR(gpio->secure);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpio");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	gpio->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gpio->base))
+		return PTR_ERR(gpio->base);
 
 	err = platform_irq_count(pdev);
 	if (err < 0)
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 06c6401f02b8..1d8168153a1c 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -1012,6 +1012,7 @@ static int zynq_gpio_remove(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		dev_warn(&pdev->dev, "pm_runtime_get_sync() Failed\n");
+	device_init_wakeup(&pdev->dev, 0);
 	gpiochip_remove(&gpio->chip);
 	clk_disable_unprepare(gpio->clk);
 	device_set_wakeup_capable(&pdev->dev, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b41a97185823..fcd0c61499f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6186,6 +6186,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 {
 	struct dma_fence *old = NULL;
 
+	dma_fence_get(gang);
 	do {
 		dma_fence_put(old);
 		rcu_read_lock();
@@ -6195,12 +6196,19 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 		if (old == gang)
 			break;
 
-		if (!dma_fence_is_signaled(old))
+		if (!dma_fence_is_signaled(old)) {
+			dma_fence_put(gang);
 			return old;
+		}
 
 	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
 			 old, gang) != old);
 
+	/*
+	 * Drop it once for the exchanged reference in adev and once for the
+	 * thread local reference acquired in amdgpu_device_get_gang().
+	 */
+	dma_fence_put(old);
 	dma_fence_put(old);
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e8b3e9520cf6..ab06cb4d7b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -210,7 +210,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	if (sgt->sgl->page_link) {
+	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 48076cf8ba80..0a85a59519ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1662,7 +1662,6 @@ static const u16 amdgpu_unsupported_pciidlist[] = {
 };
 
 static const struct pci_device_id pciidlist[] = {
-#ifdef CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
 	{0x1002, 0x6784, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
 	{0x1002, 0x6788, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
@@ -1735,8 +1734,6 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x6665, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_HAINAN|AMD_IS_MOBILITY},
 	{0x1002, 0x6667, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_HAINAN|AMD_IS_MOBILITY},
 	{0x1002, 0x666F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_HAINAN|AMD_IS_MOBILITY},
-#endif
-#ifdef CONFIG_DRM_AMDGPU_CIK
 	/* Kaveri */
 	{0x1002, 0x1304, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_KAVERI|AMD_IS_MOBILITY|AMD_IS_APU},
 	{0x1002, 0x1305, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_KAVERI|AMD_IS_APU},
@@ -1819,7 +1816,6 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x985D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_MULLINS|AMD_IS_MOBILITY|AMD_IS_APU},
 	{0x1002, 0x985E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_MULLINS|AMD_IS_MOBILITY|AMD_IS_APU},
 	{0x1002, 0x985F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_MULLINS|AMD_IS_MOBILITY|AMD_IS_APU},
-#endif
 	/* topaz */
 	{0x1002, 0x6900, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TOPAZ},
 	{0x1002, 0x6901, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TOPAZ},
@@ -2099,14 +2095,14 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		return -ENOTSUPP;
 	}
 
+	switch (flags & AMD_ASIC_MASK) {
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+	case CHIP_VERDE:
+	case CHIP_OLAND:
+	case CHIP_HAINAN:
 #ifdef CONFIG_DRM_AMDGPU_SI
-	if (!amdgpu_si_support) {
-		switch (flags & AMD_ASIC_MASK) {
-		case CHIP_TAHITI:
-		case CHIP_PITCAIRN:
-		case CHIP_VERDE:
-		case CHIP_OLAND:
-		case CHIP_HAINAN:
+		if (!amdgpu_si_support) {
 			dev_info(&pdev->dev,
 				 "SI support provided by radeon.\n");
 			dev_info(&pdev->dev,
@@ -2114,16 +2110,18 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 				);
 			return -ENODEV;
 		}
-	}
+		break;
+#else
+		dev_info(&pdev->dev, "amdgpu is built without SI support.\n");
+		return -ENODEV;
 #endif
+	case CHIP_KAVERI:
+	case CHIP_BONAIRE:
+	case CHIP_HAWAII:
+	case CHIP_KABINI:
+	case CHIP_MULLINS:
 #ifdef CONFIG_DRM_AMDGPU_CIK
-	if (!amdgpu_cik_support) {
-		switch (flags & AMD_ASIC_MASK) {
-		case CHIP_KAVERI:
-		case CHIP_BONAIRE:
-		case CHIP_HAWAII:
-		case CHIP_KABINI:
-		case CHIP_MULLINS:
+		if (!amdgpu_cik_support) {
 			dev_info(&pdev->dev,
 				 "CIK support provided by radeon.\n");
 			dev_info(&pdev->dev,
@@ -2131,8 +2129,14 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 				);
 			return -ENODEV;
 		}
-	}
+		break;
+#else
+		dev_info(&pdev->dev, "amdgpu is built without CIK support.\n");
+		return -ENODEV;
 #endif
+	default:
+		break;
+	}
 
 	adev = devm_drm_dev_alloc(&pdev->dev, &amdgpu_kms_driver, typeof(*adev), ddev);
 	if (IS_ERR(adev))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f83574107eb8..773913a7d6e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -208,6 +208,11 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 		return -EINVAL;
 	}
 
+	if (args->ring_size < KFD_MIN_QUEUE_RING_SIZE) {
+		args->ring_size = KFD_MIN_QUEUE_RING_SIZE;
+		pr_debug("Size lower. clamped to KFD_MIN_QUEUE_RING_SIZE");
+	}
+
 	if (!access_ok((const void __user *) args->read_pointer_address,
 			sizeof(uint32_t))) {
 		pr_err("Can't access read pointer\n");
@@ -464,6 +469,11 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 		return -EINVAL;
 	}
 
+	if (args->ring_size < KFD_MIN_QUEUE_RING_SIZE) {
+		args->ring_size = KFD_MIN_QUEUE_RING_SIZE;
+		pr_debug("Size lower. clamped to KFD_MIN_QUEUE_RING_SIZE");
+	}
+
 	properties.queue_address = args->ring_base_address;
 	properties.queue_size = args->ring_size;
 	properties.queue_percent = args->queue_percentage;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 99e2aef52ef2..bc01c5173ab9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -36,6 +36,7 @@
 #include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 
 struct mm_struct;
 
@@ -1114,6 +1115,17 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
 	p->kobj = NULL;
 }
 
+/*
+ * If any GPU is ongoing reset, wait for reset complete.
+ */
+static void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
+{
+	int i;
+
+	for (i = 0; i < p->n_pdds; i++)
+		flush_workqueue(p->pdds[i]->dev->adev->reset_domain->wq);
+}
+
 /* No process locking is needed in this function, because the process
  * is not findable any more. We must assume that no other thread is
  * using it any more, otherwise we couldn't safely free the process
@@ -1127,6 +1139,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 	kfd_process_dequeue_from_all_devices(p);
 	pqm_uninit(&p->pqm);
 
+	/*
+	 * If GPU in reset, user queues may still running, wait for reset complete.
+	 */
+	kfd_process_wait_gpu_reset_complete(p);
+
 	/* Signal the eviction fence after user mode queues are
 	 * destroyed. This allows any BOs to be freed without
 	 * triggering pointless evictions or waiting for fences.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 1918a3c06ac8..a15bf1e38276 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -429,7 +429,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5a837e3df7f3..f4db6c13049d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4499,17 +4499,17 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
+	if (link_cnt > (MAX_PIPES * 2)) {
+		DRM_ERROR(
+			"KMS: Cannot support more than %d display indexes\n",
+				MAX_PIPES * 2);
+		goto fail;
+	}
+
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
 
-		if (i > AMDGPU_DM_MAX_DISPLAY_INDEX) {
-			DRM_ERROR(
-				"KMS: Cannot support more than %d display indexes\n",
-					AMDGPU_DM_MAX_DISPLAY_INDEX);
-			continue;
-		}
-
 		aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
 		if (!aconnector)
 			goto fail;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 416168c7dcc5..b120aa67d26c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1947,20 +1947,11 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	dc->hwss.get_position(&pipe_ctx, 1, &position);
 	vpos = position.vertical_count;
 
-	/* Avoid wraparound calculation issues */
-	vupdate_start += stream->timing.v_total;
-	vupdate_end += stream->timing.v_total;
-	vpos += stream->timing.v_total;
-
 	if (vpos <= vupdate_start) {
 		/* VPOS is in VACTIVE or back porch. */
 		lines_to_vupdate = vupdate_start - vpos;
-	} else if (vpos > vupdate_end) {
-		/* VPOS is in the front porch. */
-		return;
 	} else {
-		/* VPOS is in VUPDATE. */
-		lines_to_vupdate = 0;
+		lines_to_vupdate = stream->timing.v_total - vpos + vupdate_start;
 	}
 
 	/* Calculate time until VUPDATE in microseconds. */
@@ -1968,13 +1959,18 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 		stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz;
 	us_to_vupdate = lines_to_vupdate * us_per_line;
 
+	/* Stall out until the cursor update completes. */
+	if (vupdate_end < vupdate_start)
+		vupdate_end += stream->timing.v_total;
+
+	/* Position is in the range of vupdate start and end*/
+	if (lines_to_vupdate > stream->timing.v_total - vupdate_end + vupdate_start)
+		us_to_vupdate = 0;
+
 	/* 70 us is a conservative estimate of cursor update time*/
 	if (us_to_vupdate > 70)
 		return;
 
-	/* Stall out until the cursor update completes. */
-	if (vupdate_end < vupdate_start)
-		vupdate_end += stream->timing.v_total;
 	us_vupdate = (vupdate_end - vupdate_start + 1) * us_per_line;
 	udelay(us_to_vupdate + us_vupdate);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
index 39a57bcd7866..576acf2ce10d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
@@ -44,7 +44,7 @@ void hubp31_set_unbounded_requesting(struct hubp *hubp, bool enable)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	REG_UPDATE(DCHUBP_CNTL, HUBP_UNBOUNDED_REQ_MODE, enable);
-	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, enable);
+	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, 1);
 }
 
 void hubp31_soft_reset(struct hubp *hubp, bool reset)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index eae4b4826f04..ab8ae7464664 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -51,6 +51,11 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 	hwmgr->adev = adev;
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
 	hwmgr->device = amdgpu_cgs_create_device(adev);
+	if (!hwmgr->device) {
+		kfree(hwmgr);
+		return -ENOMEM;
+	}
+
 	mutex_init(&hwmgr->msg_lock);
 	hwmgr->chip_family = adev->family;
 	hwmgr->chip_id = adev->asic_type;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index a6c3610db23e..7209e965dc52 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -267,10 +267,10 @@ int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 	if (hwmgr->thermal_controller.fanInfo.bNoFan ||
 			(hwmgr->thermal_controller.fanInfo.
 			ucTachometerPulsesPerRevolution == 0) ||
-			speed == 0 ||
+			(!speed || speed > UINT_MAX/8) ||
 			(speed < hwmgr->thermal_controller.fanInfo.ulMinRPM) ||
 			(speed > hwmgr->thermal_controller.fanInfo.ulMaxRPM))
-		return 0;
+		return -EINVAL;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 190af79f3236..e93b7c4aa8c9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -307,10 +307,10 @@ int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 	int result = 0;
 
 	if (hwmgr->thermal_controller.fanInfo.bNoFan ||
-	    speed == 0 ||
+	    (!speed || speed > UINT_MAX/8) ||
 	    (speed < hwmgr->thermal_controller.fanInfo.ulMinRPM) ||
 	    (speed > hwmgr->thermal_controller.fanInfo.ulMaxRPM))
-		return -1;
+		return -EINVAL;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		result = vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index f4f4efdbda79..56526f489902 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -191,7 +191,7 @@ int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 	uint32_t tach_period, crystal_clock_freq;
 	int result = 0;
 
-	if (!speed)
+	if (!speed || speed > UINT_MAX/8)
 		return -EINVAL;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl)) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 9cd005131f56..ff4447702b12 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1273,6 +1273,9 @@ static int arcturus_set_fan_speed_rpm(struct smu_context *smu,
 	uint32_t crystal_clock_freq = 2500;
 	uint32_t tach_period;
 
+	if (!speed || speed > UINT_MAX/8)
+		return -EINVAL;
+
 	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
 	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT,
 		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 2e061a74a0b7..6c10140b15cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1228,7 +1228,7 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 	uint32_t crystal_clock_freq = 2500;
 	uint32_t tach_period;
 
-	if (speed == 0)
+	if (!speed || speed > UINT_MAX/8)
 		return -EINVAL;
 	/*
 	 * To prevent from possible overheat, some ASICs may have requirement
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e159f715c1c2..00af9edb9eba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1265,7 +1265,7 @@ int smu_v13_0_set_fan_speed_rpm(struct smu_context *smu,
 	uint32_t tach_period;
 	int ret;
 
-	if (!speed)
+	if (!speed || speed > UINT_MAX/8)
 		return -EINVAL;
 
 	ret = smu_v13_0_auto_fan_control(smu, 0);
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index b097bff1cd18..66d223c2d9ab 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1389,7 +1389,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		drm_dbg_atomic(dev, "modeset on [ENCODER:%d:%s]\n",
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 7fd3de89ed07..acd29b4f43f8 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -49,7 +49,7 @@ static LIST_HEAD(panel_list);
  * @dev: parent device of the panel
  * @funcs: panel operations
  * @connector_type: the connector type (DRM_MODE_CONNECTOR_*) corresponding to
- *	the panel interface
+ *	the panel interface (must NOT be DRM_MODE_CONNECTOR_Unknown)
  *
  * Initialize the panel structure for subsequent registration with
  * drm_panel_add().
@@ -57,6 +57,9 @@ static LIST_HEAD(panel_list);
 void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		    const struct drm_panel_funcs *funcs, int connector_type)
 {
+	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
+		DRM_WARN("%s: %s: a valid connector type is required!\n", __func__, dev_name(dev));
+
 	INIT_LIST_HEAD(&panel->list);
 	panel->dev = dev;
 	panel->funcs = funcs;
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index c00f6f16244c..036b095c9888 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -93,6 +93,12 @@ static const struct drm_dmi_panel_orientation_data onegx1_pro = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd640x960_leftside_up = {
+	.width = 640,
+	.height = 960,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd720x1280_rightside_up = {
 	.width = 720,
 	.height = 1280,
@@ -123,6 +129,12 @@ static const struct drm_dmi_panel_orientation_data lcd1080x1920_rightside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd1200x1920_leftside_up = {
+	.width = 1200,
+	.height = 1920,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
 	.width = 1200,
 	.height = 1920,
@@ -184,10 +196,10 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
-	}, {	/* AYA NEO AYANEO 2 */
+	}, {	/* AYA NEO AYANEO 2/2S */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
@@ -202,6 +214,18 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {    /* AYA NEO Flip DS Bottom Screen */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "FLIP DS"),
+		},
+		.driver_data = (void *)&lcd640x960_leftside_up,
+	}, {    /* AYA NEO Flip KB/DS Top Screen */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "FLIP"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYA NEO Founder */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYA NEO"),
@@ -226,6 +250,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {	/* AYA NEO SLIDE */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "SLIDE"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {    /* AYN Loki Max */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
@@ -315,6 +345,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		},
 		.driver_data = (void *)&gpd_win2,
+	}, {	/* GPD Win 2 (correct DMI strings) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "WIN2")
+		},
+		.driver_data = (void *)&lcd720x1280_rightside_up,
 	}, {	/* GPD Win 3 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
@@ -443,6 +479,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer Mini (Intel) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
 	}, {	/* OrangePi Neo */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index d2bed466540a..3da476dec1da 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -222,7 +222,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	u8 *buf;
 	struct opregion_header *header;
 	struct vbt v;
-	const char opregion_signature[16] = OPREGION_SIGNATURE;
 
 	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
 	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
@@ -236,8 +235,10 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	/* emulated opregion with VBT mailbox only */
 	buf = (u8 *)vgpu_opregion(vgpu)->va;
 	header = (struct opregion_header *)buf;
-	memcpy(header->signature, opregion_signature,
-	       sizeof(opregion_signature));
+
+	static_assert(sizeof(header->signature) == sizeof(OPREGION_SIGNATURE) - 1);
+	memcpy(header->signature, OPREGION_SIGNATURE, sizeof(header->signature));
+
 	header->size = 0x8;
 	header->opregion_ver = 0x02000000;
 	header->mboxes = MBOX_VBT;
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 1f5d39a4077c..1fa958e8c40a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -125,14 +125,14 @@ struct mtk_dpi_yc_limit {
  * @is_ck_de_pol: Support CK/DE polarity.
  * @swap_input_support: Support input swap function.
  * @support_direct_pin: IP supports direct connection to dpi panels.
- * @input_2pixel: Input pixel of dp_intf is 2 pixel per round, so enable this
- *		  config to enable this feature.
  * @dimension_mask: Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and VSYNC_PORCH
  *		    (no shift).
  * @hvsize_mask: Mask of HSIZE and VSIZE mask (no shift).
  * @channel_swap_shift: Shift value of channel swap.
  * @yuv422_en_bit: Enable bit of yuv422.
  * @csc_enable_bit: Enable bit of CSC.
+ * @input_2p_en_bit: Enable bit for input two pixel per round feature.
+ *		     If present, implies that the feature must be enabled.
  * @pixels_per_iter: Quantity of transferred pixels per iteration.
  */
 struct mtk_dpi_conf {
@@ -145,12 +145,12 @@ struct mtk_dpi_conf {
 	bool is_ck_de_pol;
 	bool swap_input_support;
 	bool support_direct_pin;
-	bool input_2pixel;
 	u32 dimension_mask;
 	u32 hvsize_mask;
 	u32 channel_swap_shift;
 	u32 yuv422_en_bit;
 	u32 csc_enable_bit;
+	u32 input_2p_en_bit;
 	u32 pixels_per_iter;
 };
 
@@ -463,6 +463,7 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 
 	mtk_dpi_disable(dpi);
 	clk_disable_unprepare(dpi->pixel_clk);
+	clk_disable_unprepare(dpi->tvd_clk);
 	clk_disable_unprepare(dpi->engine_clk);
 }
 
@@ -479,6 +480,12 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 		goto err_refcount;
 	}
 
+	ret = clk_prepare_enable(dpi->tvd_clk);
+	if (ret) {
+		dev_err(dpi->dev, "Failed to enable tvd pll: %d\n", ret);
+		goto err_engine;
+	}
+
 	ret = clk_prepare_enable(dpi->pixel_clk);
 	if (ret) {
 		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
@@ -488,6 +495,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 	return 0;
 
 err_pixel:
+	clk_disable_unprepare(dpi->tvd_clk);
+err_engine:
 	clk_disable_unprepare(dpi->engine_clk);
 err_refcount:
 	dpi->refcount--;
@@ -602,9 +611,9 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 		mtk_dpi_dual_edge(dpi);
 		mtk_dpi_config_disable_edge(dpi);
 	}
-	if (dpi->conf->input_2pixel) {
-		mtk_dpi_mask(dpi, DPI_CON, DPINTF_INPUT_2P_EN,
-			     DPINTF_INPUT_2P_EN);
+	if (dpi->conf->input_2p_en_bit) {
+		mtk_dpi_mask(dpi, DPI_CON, dpi->conf->input_2p_en_bit,
+			     dpi->conf->input_2p_en_bit);
 	}
 	mtk_dpi_sw_reset(dpi, false);
 
@@ -952,12 +961,12 @@ static const struct mtk_dpi_conf mt8195_dpintf_conf = {
 	.output_fmts = mt8195_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8195_output_fmts),
 	.pixels_per_iter = 4,
-	.input_2pixel = true,
 	.dimension_mask = DPINTF_HPW_MASK,
 	.hvsize_mask = DPINTF_HSIZE_MASK,
 	.channel_swap_shift = DPINTF_CH_SWAP,
 	.yuv422_en_bit = DPINTF_YUV422_EN,
 	.csc_enable_bit = DPINTF_CSC_ENABLE,
+	.input_2p_en_bit = DPINTF_INPUT_2P_EN,
 };
 
 static int mtk_dpi_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index ee9b32fbe916..9156e673d360 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1070,49 +1070,50 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	u32 val;
+	int ret;
 
 	/*
-	 * The GMU may still be in slumber unless the GPU started so check and
-	 * skip putting it back into slumber if so
+	 * GMU firmware's internal power state gets messed up if we send "prepare_slumber" hfi when
+	 * oob_gpu handshake wasn't done after the last wake up. So do a dummy handshake here when
+	 * required
 	 */
-	val = gmu_read(gmu, REG_A6XX_GPU_GMU_CX_GMU_RPMH_POWER_STATE);
+	if (adreno_gpu->base.needs_hw_init) {
+		if (a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET))
+			goto force_off;
 
-	if (val != 0xf) {
-		int ret = a6xx_gmu_wait_for_idle(gmu);
+		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
+	}
 
-		/* If the GMU isn't responding assume it is hung */
-		if (ret) {
-			a6xx_gmu_force_off(gmu);
-			return;
-		}
+	ret = a6xx_gmu_wait_for_idle(gmu);
 
-		a6xx_bus_clear_pending_transactions(adreno_gpu, a6xx_gpu->hung);
+	/* If the GMU isn't responding assume it is hung */
+	if (ret)
+		goto force_off;
 
-		/* tell the GMU we want to slumber */
-		ret = a6xx_gmu_notify_slumber(gmu);
-		if (ret) {
-			a6xx_gmu_force_off(gmu);
-			return;
-		}
+	a6xx_bus_clear_pending_transactions(adreno_gpu, a6xx_gpu->hung);
 
-		ret = gmu_poll_timeout(gmu,
-			REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS, val,
-			!(val & A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS_GPUBUSYIGNAHB),
-			100, 10000);
+	/* tell the GMU we want to slumber */
+	ret = a6xx_gmu_notify_slumber(gmu);
+	if (ret)
+		goto force_off;
 
-		/*
-		 * Let the user know we failed to slumber but don't worry too
-		 * much because we are powering down anyway
-		 */
+	ret = gmu_poll_timeout(gmu,
+		REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS, val,
+		!(val & A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS_GPUBUSYIGNAHB),
+		100, 10000);
 
-		if (ret)
-			DRM_DEV_ERROR(gmu->dev,
-				"Unable to slumber GMU: status = 0%x/0%x\n",
-				gmu_read(gmu,
-					REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS),
-				gmu_read(gmu,
-					REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS2));
-	}
+	/*
+	 * Let the user know we failed to slumber but don't worry too
+	 * much because we are powering down anyway
+	 */
+
+	if (ret)
+		DRM_DEV_ERROR(gmu->dev,
+			"Unable to slumber GMU: status = 0%x/0%x\n",
+			gmu_read(gmu,
+				REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS),
+			gmu_read(gmu,
+				REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS2));
 
 	/* Turn off HFI */
 	a6xx_hfi_stop(gmu);
@@ -1122,6 +1123,11 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 
 	/* Tell RPMh to power off the GPU */
 	a6xx_rpmh_stop(gmu);
+
+	return;
+
+force_off:
+	a6xx_gmu_force_off(gmu);
 }
 
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index f2dca41e46c5..2953d6a6d390 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -143,6 +143,9 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 	nouveau_bo_del_io_reserve_lru(bo);
 	nv10_bo_put_tile_region(dev, nvbo->tile, NULL);
 
+	if (bo->base.import_attach)
+		drm_prime_gem_destroy(&bo->base, bo->sg);
+
 	/*
 	 * If nouveau_bo_new() allocated this buffer, the GEM object was never
 	 * initialized, so don't attempt to release it.
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index fab542a758ff..a14728427ee4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -87,9 +87,6 @@ nouveau_gem_object_del(struct drm_gem_object *gem)
 		return;
 	}
 
-	if (gem->import_attach)
-		drm_prime_gem_destroy(gem, nvbo->bo.sg);
-
 	ttm_bo_put(&nvbo->bo);
 
 	pm_runtime_mark_last_busy(dev);
diff --git a/drivers/gpu/drm/sti/Makefile b/drivers/gpu/drm/sti/Makefile
index f203ac5514ae..f778a4eee7c9 100644
--- a/drivers/gpu/drm/sti/Makefile
+++ b/drivers/gpu/drm/sti/Makefile
@@ -7,8 +7,6 @@ sti-drm-y := \
 	sti_compositor.o \
 	sti_crtc.o \
 	sti_plane.o \
-	sti_crtc.o \
-	sti_plane.o \
 	sti_hdmi.o \
 	sti_hdmi_tx3g4c28phy.o \
 	sti_dvo.o \
diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 7e2b0e224135..ebb9b1f782f9 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -455,7 +455,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
 				       enum repaper_stage stage)
 {
 	u64 start = local_clock();
-	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
+	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
 
 	do {
 		repaper_frame_fixed(epd, fixed_value, stage);
@@ -466,7 +466,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
 				      const u8 *mask, enum repaper_stage stage)
 {
 	u64 start = local_clock();
-	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
+	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
 
 	do {
 		repaper_frame_data(epd, image, mask, stage);
diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 3b4ee21cd811..26cb331b646c 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -21,6 +21,7 @@
 #include "usbhid.h"
 
 #define	PID_EFFECTS_MAX		64
+#define	PID_INFINITE		0xffff
 
 /* Report usage table used to put reports into an array */
 
@@ -261,10 +262,22 @@ static void pidff_set_envelope_report(struct pidff_device *pidff,
 static int pidff_needs_set_envelope(struct ff_envelope *envelope,
 				    struct ff_envelope *old)
 {
-	return envelope->attack_level != old->attack_level ||
-	       envelope->fade_level != old->fade_level ||
+	bool needs_new_envelope;
+	needs_new_envelope = envelope->attack_level  != 0 ||
+			     envelope->fade_level    != 0 ||
+			     envelope->attack_length != 0 ||
+			     envelope->fade_length   != 0;
+
+	if (!needs_new_envelope)
+		return false;
+
+	if (!old)
+		return needs_new_envelope;
+
+	return envelope->attack_level  != old->attack_level  ||
+	       envelope->fade_level    != old->fade_level    ||
 	       envelope->attack_length != old->attack_length ||
-	       envelope->fade_length != old->fade_length;
+	       envelope->fade_length   != old->fade_length;
 }
 
 /*
@@ -301,7 +314,12 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff->set_effect_type->value[0] =
 		pidff->create_new_effect_type->value[0];
-	pidff->set_effect[PID_DURATION].value[0] = effect->replay.length;
+
+	/* Convert infinite length from Linux API (0)
+	   to PID standard (NULL) if needed */
+	pidff->set_effect[PID_DURATION].value[0] =
+		effect->replay.length == 0 ? PID_INFINITE : effect->replay.length;
+
 	pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = effect->trigger.button;
 	pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] =
 		effect->trigger.interval;
@@ -574,11 +592,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_constant(effect, old))
 			pidff_set_constant_force_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.constant.envelope,
-					&old->u.constant.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.constant.envelope);
+		if (pidff_needs_set_envelope(&effect->u.constant.envelope,
+					old ? &old->u.constant.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.constant.envelope);
 		break;
 
 	case FF_PERIODIC:
@@ -613,11 +629,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_periodic(effect, old))
 			pidff_set_periodic_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.periodic.envelope,
-					&old->u.periodic.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.periodic.envelope);
+		if (pidff_needs_set_envelope(&effect->u.periodic.envelope,
+					old ? &old->u.periodic.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.periodic.envelope);
 		break;
 
 	case FF_RAMP:
@@ -631,11 +645,9 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			pidff_set_effect_report(pidff, effect);
 		if (!old || pidff_needs_set_ramp(effect, old))
 			pidff_set_ramp_force_report(pidff, effect);
-		if (!old ||
-		    pidff_needs_set_envelope(&effect->u.ramp.envelope,
-					&old->u.ramp.envelope))
-			pidff_set_envelope_report(pidff,
-					&effect->u.ramp.envelope);
+		if (pidff_needs_set_envelope(&effect->u.ramp.envelope,
+					old ? &old->u.ramp.envelope : NULL))
+			pidff_set_envelope_report(pidff, &effect->u.ramp.envelope);
 		break;
 
 	case FF_SPRING:
@@ -758,6 +770,11 @@ static void pidff_set_autocenter(struct input_dev *dev, u16 magnitude)
 static int pidff_find_fields(struct pidff_usage *usage, const u8 *table,
 			     struct hid_report *report, int count, int strict)
 {
+	if (!report) {
+		pr_debug("pidff_find_fields, null report\n");
+		return -1;
+	}
+
 	int i, j, k, found;
 
 	for (k = 0; k < count; k++) {
@@ -871,6 +888,11 @@ static int pidff_reports_ok(struct pidff_device *pidff)
 static struct hid_field *pidff_find_special_field(struct hid_report *report,
 						  int usage, int enforce_min)
 {
+	if (!report) {
+		pr_debug("pidff_find_special_field, null report\n");
+		return NULL;
+	}
+
 	int i;
 
 	for (i = 0; i < report->maxfield; i++) {
diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 274ad8443f8c..b3f1b7746eab 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -403,6 +403,7 @@ static void ssip_reset(struct hsi_client *cl)
 	del_timer(&ssi->rx_wd);
 	del_timer(&ssi->tx_wd);
 	del_timer(&ssi->keep_alive);
+	cancel_work_sync(&ssi->work);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
 	ssi->recv_state = 0;
diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 4e787dc709f9..d13b5f804540 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -247,6 +247,9 @@ static int ec_i2c_probe(struct platform_device *pdev)
 	u32 remote_bus;
 	int err;
 
+	if (!ec)
+		return dev_err_probe(dev, -EPROBE_DEFER, "couldn't find parent EC device\n");
+
 	if (!ec->cmd_xfer) {
 		dev_err(dev, "Missing sendrecv\n");
 		return -EINVAL;
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7bb005de974e..18103c1e8d76 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2495,6 +2495,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
  */
 void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
 {
+	if (!dev->ibi || !slot)
+		return;
+
 	atomic_inc(&dev->ibi->pending_ibis);
 	queue_work(dev->common.master->wq, &slot->work);
 }
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 157ff26d40be..38095649ed27 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -368,7 +368,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
 		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
-		readsl(master->regs + SVC_I3C_MRDATAB, buf, count);
+		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
 		slot->len += count;
 		buf += count;
 	}
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 067d7f42871f..bb3c361bd8d4 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -72,6 +72,8 @@ static const char * const cma_events[] = {
 static void cma_iboe_set_mgid(struct sockaddr *addr, union ib_gid *mgid,
 			      enum ib_gid_type gid_type);
 
+static void cma_netevent_work_handler(struct work_struct *_work);
+
 const char *__attribute_const__ rdma_event_msg(enum rdma_cm_event_type event)
 {
 	size_t index = event;
@@ -994,6 +996,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
 	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
 	id_priv->seq_num &= 0x00ffffff;
+	INIT_WORK(&id_priv->id.net_work, cma_netevent_work_handler);
 
 	rdma_restrack_new(&id_priv->res, RDMA_RESTRACK_CM_ID);
 	if (parent)
@@ -5186,7 +5189,6 @@ static int cma_netevent_callback(struct notifier_block *self,
 		if (!memcmp(current_id->id.route.addr.dev_addr.dst_dev_addr,
 			   neigh->ha, ETH_ALEN))
 			continue;
-		INIT_WORK(&current_id->id.net_work, cma_netevent_work_handler);
 		cma_id_get(current_id);
 		queue_work(cma_wq, &current_id->id.net_work);
 	}
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index e9fa22d31c23..c48ef6083020 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -76,12 +76,14 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 
 		npfns = (end - start) >> PAGE_SHIFT;
 		umem_odp->pfn_list = kvcalloc(
-			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
+			npfns, sizeof(*umem_odp->pfn_list),
+			GFP_KERNEL | __GFP_NOWARN);
 		if (!umem_odp->pfn_list)
 			return -ENOMEM;
 
 		umem_odp->dma_list = kvcalloc(
-			ndmas, sizeof(*umem_odp->dma_list), GFP_KERNEL);
+			ndmas, sizeof(*umem_odp->dma_list),
+			GFP_KERNEL | __GFP_NOWARN);
 		if (!umem_odp->dma_list) {
 			ret = -ENOMEM;
 			goto out_pfn_list;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 5106b3ce89f0..eae22ac42e05 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -642,7 +642,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		if (ret)
 			return ret;
 	}
-	dma_set_max_seg_size(dev, UINT_MAX);
+	dma_set_max_seg_size(dev, SZ_2G);
 	ret = ib_register_device(ib_dev, "hns_%d", dev);
 	if (ret) {
 		dev_err(dev, "ib_register_device failed!\n");
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 46653ad56f5a..ec2d8f78c898 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -380,7 +380,7 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 	if (!us_ibdev) {
 		usnic_err("Device %s context alloc failed\n",
 				netdev_name(pci_get_drvdata(dev)));
-		return ERR_PTR(-EFAULT);
+		return NULL;
 	}
 
 	us_ibdev->ufdev = usnic_fwd_dev_alloc(dev);
@@ -500,8 +500,8 @@ static struct usnic_ib_dev *usnic_ib_discover_pf(struct usnic_vnic *vnic)
 	}
 
 	us_ibdev = usnic_ib_device_add(parent_pci);
-	if (IS_ERR_OR_NULL(us_ibdev)) {
-		us_ibdev = us_ibdev ? us_ibdev : ERR_PTR(-EFAULT);
+	if (!us_ibdev) {
+		us_ibdev = ERR_PTR(-EFAULT);
 		goto out;
 	}
 
@@ -569,10 +569,10 @@ static int usnic_ib_pci_probe(struct pci_dev *pdev,
 	}
 
 	pf = usnic_ib_discover_pf(vf->vnic);
-	if (IS_ERR_OR_NULL(pf)) {
-		usnic_err("Failed to discover pf of vnic %s with err%ld\n",
-				pci_name(pdev), PTR_ERR(pf));
-		err = pf ? PTR_ERR(pf) : -EFAULT;
+	if (IS_ERR(pf)) {
+		err = PTR_ERR(pf);
+		usnic_err("Failed to discover pf of vnic %s with err%d\n",
+				pci_name(pdev), err);
 		goto out_clean_vnic;
 	}
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 576163f88a4a..d4cb09b2e267 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1268,15 +1268,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 	mutex_init(&data->mutex);
 
-	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
-				     "mtk-iommu.%pa", &ioaddr);
-	if (ret)
-		goto out_link_remove;
-
-	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
-	if (ret)
-		goto out_sysfs_remove;
-
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE)) {
 		list_add_tail(&data->list, data->plat_data->hw_list);
 		data->hw_list = data->plat_data->hw_list;
@@ -1286,19 +1277,28 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		data->hw_list = &data->hw_list_head;
 	}
 
+	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
+				     "mtk-iommu.%pa", &ioaddr);
+	if (ret)
+		goto out_list_del;
+
+	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
+	if (ret)
+		goto out_sysfs_remove;
+
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 		if (ret)
-			goto out_list_del;
+			goto out_device_unregister;
 	}
 	return ret;
 
-out_list_del:
-	list_del(&data->list);
+out_device_unregister:
 	iommu_device_unregister(&data->iommu);
 out_sysfs_remove:
 	iommu_device_sysfs_remove(&data->iommu);
-out_link_remove:
+out_list_del:
+	list_del(&data->list);
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
 		device_link_remove(data->smicomm_dev, dev);
 out_runtime_disable:
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 828a98acf2a6..9f0ce838d512 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -389,6 +389,12 @@ static int ebs_map(struct dm_target *ti, struct bio *bio)
 	return DM_MAPIO_REMAPPED;
 }
 
+static void ebs_postsuspend(struct dm_target *ti)
+{
+	struct ebs_c *ec = ti->private;
+	dm_bufio_client_reset(ec->bufio);
+}
+
 static void ebs_status(struct dm_target *ti, status_type_t type,
 		       unsigned int status_flags, char *result, unsigned int maxlen)
 {
@@ -446,6 +452,7 @@ static struct target_type ebs_target = {
 	.ctr		 = ebs_ctr,
 	.dtr		 = ebs_dtr,
 	.map		 = ebs_map,
+	.postsuspend	 = ebs_postsuspend,
 	.status		 = ebs_status,
 	.io_hints	 = ebs_io_hints,
 	.prepare_ioctl	 = ebs_prepare_ioctl,
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index e0ffac93f900..c1f1f4ad608d 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4546,16 +4546,19 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 
 		ic->recalc_bitmap = dm_integrity_alloc_page_list(n_bitmap_pages);
 		if (!ic->recalc_bitmap) {
+			ti->error = "Could not allocate memory for bitmap";
 			r = -ENOMEM;
 			goto bad;
 		}
 		ic->may_write_bitmap = dm_integrity_alloc_page_list(n_bitmap_pages);
 		if (!ic->may_write_bitmap) {
+			ti->error = "Could not allocate memory for bitmap";
 			r = -ENOMEM;
 			goto bad;
 		}
 		ic->bbs = kvmalloc_array(ic->n_bitmap_blocks, sizeof(struct bitmap_block_status), GFP_KERNEL);
 		if (!ic->bbs) {
+			ti->error = "Could not allocate memory for bitmap";
 			r = -ENOMEM;
 			goto bad;
 		}
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 52585e2c61aa..a3c1682a2298 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -823,6 +823,13 @@ static int verity_map(struct dm_target *ti, struct bio *bio)
 	return DM_MAPIO_SUBMITTED;
 }
 
+static void verity_postsuspend(struct dm_target *ti)
+{
+	struct dm_verity *v = ti->private;
+	flush_workqueue(v->verify_wq);
+	dm_bufio_client_reset(v->bufio);
+}
+
 /*
  * Status: V (valid) or C (corruption found)
  */
@@ -1542,6 +1549,7 @@ static struct target_type verity_target = {
 	.ctr		= verity_ctr,
 	.dtr		= verity_dtr,
 	.map		= verity_map,
+	.postsuspend	= verity_postsuspend,
 	.status		= verity_status,
 	.prepare_ioctl	= verity_prepare_ioctl,
 	.iterate_devices = verity_iterate_devices,
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index e18e21b24210..02629516748e 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2029,9 +2029,8 @@ int md_bitmap_get_stats(struct bitmap *bitmap, struct md_bitmap_stats *stats)
 
 	if (!bitmap)
 		return -ENOENT;
-	if (bitmap->mddev->bitmap_info.external)
-		return -ENOENT;
-	if (!bitmap->storage.sb_page) /* no superblock */
+	if (!bitmap->mddev->bitmap_info.external &&
+	    !bitmap->storage.sb_page)
 		return -EINVAL;
 	sb = kmap_local_page(bitmap->storage.sb_page);
 	stats->sync_size = le64_to_cpu(sb->sync_size);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5e2751d42f64..d5fbccc72810 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -667,24 +667,34 @@ static inline struct mddev *mddev_get(struct mddev *mddev)
 
 static void mddev_delayed_delete(struct work_struct *ws);
 
+static void __mddev_put(struct mddev *mddev)
+{
+	if (mddev->raid_disks || !list_empty(&mddev->disks) ||
+	    mddev->ctime || mddev->hold_active)
+		return;
+
+	/* Array is not configured at all, and not held active, so destroy it */
+	set_bit(MD_DELETED, &mddev->flags);
+
+	/*
+	 * Call queue_work inside the spinlock so that flush_workqueue() after
+	 * mddev_find will succeed in waiting for the work to be done.
+	 */
+	INIT_WORK(&mddev->del_work, mddev_delayed_delete);
+	queue_work(md_misc_wq, &mddev->del_work);
+}
+
+static void mddev_put_locked(struct mddev *mddev)
+{
+	if (atomic_dec_and_test(&mddev->active))
+		__mddev_put(mddev);
+}
+
 void mddev_put(struct mddev *mddev)
 {
 	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
 		return;
-	if (!mddev->raid_disks && list_empty(&mddev->disks) &&
-	    mddev->ctime == 0 && !mddev->hold_active) {
-		/* Array is not configured at all, and not held active,
-		 * so destroy it */
-		set_bit(MD_DELETED, &mddev->flags);
-
-		/*
-		 * Call queue_work inside the spinlock so that
-		 * flush_workqueue() after mddev_find will succeed in waiting
-		 * for the work to be done.
-		 */
-		INIT_WORK(&mddev->del_work, mddev_delayed_delete);
-		queue_work(md_misc_wq, &mddev->del_work);
-	}
+	__mddev_put(mddev);
 	spin_unlock(&all_mddevs_lock);
 }
 
@@ -9700,11 +9710,11 @@ EXPORT_SYMBOL_GPL(rdev_clear_badblocks);
 static int md_notify_reboot(struct notifier_block *this,
 			    unsigned long code, void *x)
 {
-	struct mddev *mddev, *n;
+	struct mddev *mddev;
 	int need_delay = 0;
 
 	spin_lock(&all_mddevs_lock);
-	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
+	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
 		if (!mddev_get(mddev))
 			continue;
 		spin_unlock(&all_mddevs_lock);
@@ -9716,8 +9726,8 @@ static int md_notify_reboot(struct notifier_block *this,
 			mddev_unlock(mddev);
 		}
 		need_delay = 1;
-		mddev_put(mddev);
 		spin_lock(&all_mddevs_lock);
+		mddev_put_locked(mddev);
 	}
 	spin_unlock(&all_mddevs_lock);
 
@@ -10039,7 +10049,7 @@ void md_autostart_arrays(int part)
 
 static __exit void md_exit(void)
 {
-	struct mddev *mddev, *n;
+	struct mddev *mddev;
 	int delay = 1;
 
 	unregister_blkdev(MD_MAJOR,"md");
@@ -10060,7 +10070,7 @@ static __exit void md_exit(void)
 	remove_proc_entry("mdstat", NULL);
 
 	spin_lock(&all_mddevs_lock);
-	list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
+	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
 		if (!mddev_get(mddev))
 			continue;
 		spin_unlock(&all_mddevs_lock);
@@ -10072,8 +10082,8 @@ static __exit void md_exit(void)
 		 * the mddev for destruction by a workqueue, and the
 		 * destroy_workqueue() below will wait for that to complete.
 		 */
-		mddev_put(mddev);
 		spin_lock(&all_mddevs_lock);
+		mddev_put_locked(mddev);
 	}
 	spin_unlock(&all_mddevs_lock);
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index f608f30c7d6a..24427eddf61b 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1772,6 +1772,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	 * The discard bio returns only first r10bio finishes
 	 */
 	if (first_copy) {
+		md_account_bio(mddev, &bio);
 		r10_bio->master_bio = bio;
 		set_bit(R10BIO_Discard, &r10_bio->state);
 		first_copy = false;
diff --git a/drivers/media/common/siano/smsdvb-main.c b/drivers/media/common/siano/smsdvb-main.c
index f80caaa333da..67c47e3d671d 100644
--- a/drivers/media/common/siano/smsdvb-main.c
+++ b/drivers/media/common/siano/smsdvb-main.c
@@ -1243,6 +1243,8 @@ static int __init smsdvb_module_init(void)
 	smsdvb_debugfs_register();
 
 	rc = smscore_register_hotplug(smsdvb_hotplug);
+	if (rc)
+		smsdvb_debugfs_unregister();
 
 	pr_debug("\n");
 
diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
index d75eb3d8be5a..2e827bec5823 100644
--- a/drivers/media/i2c/adv748x/adv748x.h
+++ b/drivers/media/i2c/adv748x/adv748x.h
@@ -322,7 +322,7 @@ struct adv748x_state {
 
 /* Free run pattern select */
 #define ADV748X_SDP_FRP			0x14
-#define ADV748X_SDP_FRP_MASK		GENMASK(3, 1)
+#define ADV748X_SDP_FRP_MASK		GENMASK(2, 0)
 
 /* Saturation */
 #define ADV748X_SDP_SD_SAT_U		0xe3	/* user_map_rw_reg_e3 */
diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index eb9ad5a50d95..0579fae3d014 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3642,6 +3642,7 @@ static int ccs_probe(struct i2c_client *client)
 out_disable_runtime_pm:
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 
 out_media_entity_cleanup:
 	media_entity_cleanup(&sensor->src->sd.entity);
@@ -3674,9 +3675,10 @@ static void ccs_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(subdev);
 
 	pm_runtime_disable(&client->dev);
-	if (!pm_runtime_status_suspended(&client->dev))
+	if (!pm_runtime_status_suspended(&client->dev)) {
 		ccs_power_off(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 
 	for (i = 0; i < sensor->ssds_used; i++) {
 		v4l2_device_unregister_subdev(&sensor->ssds[i].sd);
diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 88e987435285..a418edae893a 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -922,6 +922,8 @@ static int ov7251_set_power_on(struct device *dev)
 		return ret;
 	}
 
+	usleep_range(1000, 1100);
+
 	gpiod_set_value_cansleep(ov7251->enable_gpio, 1);
 
 	/* wait at least 65536 external clock cycles */
@@ -1675,7 +1677,7 @@ static int ov7251_probe(struct i2c_client *client)
 		return PTR_ERR(ov7251->analog_regulator);
 	}
 
-	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(ov7251->enable_gpio)) {
 		dev_err(dev, "cannot get enable gpio\n");
 		return PTR_ERR(ov7251->enable_gpio);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index cf16cf2807f0..f0e207044bf3 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -1192,7 +1192,8 @@ static int vdec_vp9_slice_setup_lat(struct vdec_vp9_slice_instance *instance,
 	return ret;
 }
 
-static
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
 void vdec_vp9_slice_map_counts_eob_coef(unsigned int i, unsigned int j, unsigned int k,
 					struct vdec_vp9_slice_frame_counts *counts,
 					struct v4l2_vp9_frame_symbol_counts *counts_helper)
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index c43839539d4d..8eb9e32031f7 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -19,6 +19,8 @@ static void init_codecs(struct venus_core *core)
 	struct hfi_plat_caps *caps = core->caps, *cap;
 	unsigned long bit;
 
+	core->codecs_count = 0;
+
 	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
 		return;
 
@@ -62,7 +64,7 @@ fill_buf_mode(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 		cap->cap_bufs_mode_dynamic = true;
 }
 
-static void
+static int
 parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_buffer_alloc_mode_supported *mode = data;
@@ -70,7 +72,7 @@ parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	u32 *type;
 
 	if (num_entries > MAX_ALLOC_MODE_ENTRIES)
-		return;
+		return -EINVAL;
 
 	type = mode->data;
 
@@ -82,6 +84,8 @@ parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 
 		type++;
 	}
+
+	return sizeof(*mode);
 }
 
 static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
@@ -96,7 +100,7 @@ static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
 	cap->num_pl += num;
 }
 
-static void
+static int
 parse_profile_level(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_profile_level_supported *pl = data;
@@ -104,12 +108,14 @@ parse_profile_level(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct hfi_profile_level pl_arr[HFI_MAX_PROFILE_COUNT] = {};
 
 	if (pl->profile_count > HFI_MAX_PROFILE_COUNT)
-		return;
+		return -EINVAL;
 
 	memcpy(pl_arr, proflevel, pl->profile_count * sizeof(*proflevel));
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_profile_level, pl_arr, pl->profile_count);
+
+	return pl->profile_count * sizeof(*proflevel) + sizeof(u32);
 }
 
 static void
@@ -124,7 +130,7 @@ fill_caps(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 	cap->num_caps += num;
 }
 
-static void
+static int
 parse_caps(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_capabilities *caps = data;
@@ -133,12 +139,14 @@ parse_caps(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct hfi_capability caps_arr[MAX_CAP_ENTRIES] = {};
 
 	if (num_caps > MAX_CAP_ENTRIES)
-		return;
+		return -EINVAL;
 
 	memcpy(caps_arr, cap, num_caps * sizeof(*cap));
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_caps, caps_arr, num_caps);
+
+	return sizeof(*caps);
 }
 
 static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
@@ -153,7 +161,7 @@ static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
 	cap->num_fmts += num_fmts;
 }
 
-static void
+static int
 parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_uncompressed_format_supported *fmt = data;
@@ -162,7 +170,8 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct raw_formats rawfmts[MAX_FMT_ENTRIES] = {};
 	u32 entries = fmt->format_entries;
 	unsigned int i = 0;
-	u32 num_planes;
+	u32 num_planes = 0;
+	u32 size;
 
 	while (entries) {
 		num_planes = pinfo->num_planes;
@@ -172,7 +181,7 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 		i++;
 
 		if (i >= MAX_FMT_ENTRIES)
-			return;
+			return -EINVAL;
 
 		if (pinfo->num_planes > MAX_PLANES)
 			break;
@@ -184,9 +193,13 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_raw_fmts, rawfmts, i);
+	size = fmt->format_entries * (sizeof(*constr) * num_planes + 2 * sizeof(u32))
+		+ 2 * sizeof(u32);
+
+	return size;
 }
 
-static void parse_codecs(struct venus_core *core, void *data)
+static int parse_codecs(struct venus_core *core, void *data)
 {
 	struct hfi_codec_supported *codecs = data;
 
@@ -198,21 +211,27 @@ static void parse_codecs(struct venus_core *core, void *data)
 		core->dec_codecs &= ~HFI_VIDEO_CODEC_SPARK;
 		core->enc_codecs &= ~HFI_VIDEO_CODEC_HEVC;
 	}
+
+	return sizeof(*codecs);
 }
 
-static void parse_max_sessions(struct venus_core *core, const void *data)
+static int parse_max_sessions(struct venus_core *core, const void *data)
 {
 	const struct hfi_max_sessions_supported *sessions = data;
 
 	core->max_sessions_supported = sessions->max_sessions;
+
+	return sizeof(*sessions);
 }
 
-static void parse_codecs_mask(u32 *codecs, u32 *domain, void *data)
+static int parse_codecs_mask(u32 *codecs, u32 *domain, void *data)
 {
 	struct hfi_codec_mask_supported *mask = data;
 
 	*codecs = mask->codecs;
 	*domain = mask->video_domains;
+
+	return sizeof(*mask);
 }
 
 static void parser_init(struct venus_inst *inst, u32 *codecs, u32 *domain)
@@ -281,8 +300,9 @@ static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
 u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 	       u32 size)
 {
-	unsigned int words_count = size >> 2;
-	u32 *word = buf, *data, codecs = 0, domain = 0;
+	u32 *words = buf, *payload, codecs = 0, domain = 0;
+	u32 *frame_size = buf + size;
+	u32 rem_bytes = size;
 	int ret;
 
 	ret = hfi_platform_parser(core, inst);
@@ -299,38 +319,66 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 		memset(core->caps, 0, sizeof(core->caps));
 	}
 
-	while (words_count) {
-		data = word + 1;
+	while (words < frame_size) {
+		payload = words + 1;
 
-		switch (*word) {
+		switch (*words) {
 		case HFI_PROPERTY_PARAM_CODEC_SUPPORTED:
-			parse_codecs(core, data);
+			if (rem_bytes <= sizeof(struct hfi_codec_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_codecs(core, payload);
+			if (ret < 0)
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
 			init_codecs(core);
 			break;
 		case HFI_PROPERTY_PARAM_MAX_SESSIONS_SUPPORTED:
-			parse_max_sessions(core, data);
+			if (rem_bytes <= sizeof(struct hfi_max_sessions_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_max_sessions(core, payload);
 			break;
 		case HFI_PROPERTY_PARAM_CODEC_MASK_SUPPORTED:
-			parse_codecs_mask(&codecs, &domain, data);
+			if (rem_bytes <= sizeof(struct hfi_codec_mask_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_codecs_mask(&codecs, &domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_UNCOMPRESSED_FORMAT_SUPPORTED:
-			parse_raw_formats(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_uncompressed_format_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_raw_formats(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_CAPABILITY_SUPPORTED:
-			parse_caps(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_capabilities))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_caps(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_PROFILE_LEVEL_SUPPORTED:
-			parse_profile_level(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_profile_level_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_profile_level(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE_SUPPORTED:
-			parse_alloc_mode(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_buffer_alloc_mode_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_alloc_mode(core, codecs, domain, payload);
 			break;
 		default:
+			ret = sizeof(u32);
 			break;
 		}
 
-		word++;
-		words_count--;
+		if (ret < 0)
+			return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+		words += ret / sizeof(u32);
+		rem_bytes -= ret;
 	}
 
 	if (!core->max_sessions_supported)
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index d46938aab26b..92ea4642d898 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -187,6 +187,9 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 	/* ensure rd/wr indices's are read from memory */
 	rmb();
 
+	if (qsize > IFACEQ_QUEUE_SIZE / 4)
+		return -EINVAL;
+
 	if (wr_idx >= rd_idx)
 		empty_space = qsize - (wr_idx - rd_idx);
 	else
@@ -255,6 +258,9 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
 	wr_idx = qhdr->write_idx;
 	qsize = qhdr->q_size;
 
+	if (qsize > IFACEQ_QUEUE_SIZE / 4)
+		return -EINVAL;
+
 	/* make sure data is valid before using it */
 	rmb();
 
@@ -1053,18 +1059,26 @@ static void venus_sfr_print(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
 	struct hfi_sfr *sfr = hdev->sfr.kva;
+	u32 size;
 	void *p;
 
 	if (!sfr)
 		return;
 
-	p = memchr(sfr->data, '\0', sfr->buf_size);
+	size = sfr->buf_size;
+	if (!size)
+		return;
+
+	if (size > ALIGNED_SFR_SIZE)
+		size = ALIGNED_SFR_SIZE;
+
+	p = memchr(sfr->data, '\0', size);
 	/*
 	 * SFR isn't guaranteed to be NULL terminated since SYS_ERROR indicates
 	 * that Venus is in the process of crashing.
 	 */
 	if (!p)
-		sfr->data[sfr->buf_size - 1] = '\0';
+		sfr->data[size - 1] = '\0';
 
 	dev_err_ratelimited(dev, "SFR message from FW: %s\n", sfr->data);
 }
diff --git a/drivers/media/platform/st/stm32/dma2d/dma2d.c b/drivers/media/platform/st/stm32/dma2d/dma2d.c
index 9706aa41b5d2..1a8c4b76df0d 100644
--- a/drivers/media/platform/st/stm32/dma2d/dma2d.c
+++ b/drivers/media/platform/st/stm32/dma2d/dma2d.c
@@ -492,7 +492,8 @@ static void device_run(void *prv)
 	dst->sequence = frm_cap->sequence++;
 	v4l2_m2m_buf_copy_metadata(src, dst, true);
 
-	clk_enable(dev->gate);
+	if (clk_enable(dev->gate))
+		goto end;
 
 	dma2d_config_fg(dev, frm_out,
 			vb2_dma_contig_plane_dma_addr(&src->vb2_buf, 0));
diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index 2ce62fe5d60f..d3b48a0dd1f4 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -138,39 +138,10 @@ static void sz_push_half_space(struct streamzap_ir *sz,
 	sz_push_full_space(sz, value & SZ_SPACE_MASK);
 }
 
-/*
- * streamzap_callback - usb IRQ handler callback
- *
- * This procedure is invoked on reception of data from
- * the usb remote.
- */
-static void streamzap_callback(struct urb *urb)
+static void sz_process_ir_data(struct streamzap_ir *sz, int len)
 {
-	struct streamzap_ir *sz;
 	unsigned int i;
-	int len;
-
-	if (!urb)
-		return;
-
-	sz = urb->context;
-	len = urb->actual_length;
-
-	switch (urb->status) {
-	case -ECONNRESET:
-	case -ENOENT:
-	case -ESHUTDOWN:
-		/*
-		 * this urb is terminated, clean up.
-		 * sz might already be invalid at this point
-		 */
-		dev_err(sz->dev, "urb terminated, status: %d\n", urb->status);
-		return;
-	default:
-		break;
-	}
 
-	dev_dbg(sz->dev, "%s: received urb, len %d\n", __func__, len);
 	for (i = 0; i < len; i++) {
 		dev_dbg(sz->dev, "sz->buf_in[%d]: %x\n",
 			i, (unsigned char)sz->buf_in[i]);
@@ -219,6 +190,43 @@ static void streamzap_callback(struct urb *urb)
 	}
 
 	ir_raw_event_handle(sz->rdev);
+}
+
+/*
+ * streamzap_callback - usb IRQ handler callback
+ *
+ * This procedure is invoked on reception of data from
+ * the usb remote.
+ */
+static void streamzap_callback(struct urb *urb)
+{
+	struct streamzap_ir *sz;
+	int len;
+
+	if (!urb)
+		return;
+
+	sz = urb->context;
+	len = urb->actual_length;
+
+	switch (urb->status) {
+	case 0:
+		dev_dbg(sz->dev, "%s: received urb, len %d\n", __func__, len);
+		sz_process_ir_data(sz, len);
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/*
+		 * this urb is terminated, clean up.
+		 * sz might already be invalid at this point
+		 */
+		dev_err(sz->dev, "urb terminated, status: %d\n", urb->status);
+		return;
+	default:
+		break;
+	}
+
 	usb_submit_urb(urb, GFP_ATOMIC);
 }
 
diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
index 7964426bf2f7..3367cdf9f104 100644
--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -1316,9 +1316,6 @@ static int vim2m_probe(struct platform_device *pdev)
 	vfd->v4l2_dev = &dev->v4l2_dev;
 
 	video_set_drvdata(vfd, dev);
-	v4l2_info(&dev->v4l2_dev,
-		  "Device registered as /dev/video%d\n", vfd->num);
-
 	platform_set_drvdata(pdev, dev);
 
 	dev->m2m_dev = v4l2_m2m_init(&m2m_ops);
@@ -1345,6 +1342,9 @@ static int vim2m_probe(struct platform_device *pdev)
 		goto error_m2m;
 	}
 
+	v4l2_info(&dev->v4l2_dev,
+		  "Device registered as /dev/video%d\n", vfd->num);
+
 #ifdef CONFIG_MEDIA_CONTROLLER
 	ret = v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
 						 MEDIA_ENT_F_PROC_VIDEO_SCALER);
diff --git a/drivers/media/v4l2-core/v4l2-dv-timings.c b/drivers/media/v4l2-core/v4l2-dv-timings.c
index 2cf5dcee0ce8..4d05873892c1 100644
--- a/drivers/media/v4l2-core/v4l2-dv-timings.c
+++ b/drivers/media/v4l2-core/v4l2-dv-timings.c
@@ -764,7 +764,7 @@ bool v4l2_detect_gtf(unsigned int frame_height,
 		u64 num;
 		u32 den;
 
-		num = ((image_width * GTF_D_C_PRIME * (u64)hfreq) -
+		num = (((u64)image_width * GTF_D_C_PRIME * hfreq) -
 		      ((u64)image_width * GTF_D_M_PRIME * 1000));
 		den = (hfreq * (100 - GTF_D_C_PRIME) + GTF_D_M_PRIME * 1000) *
 		      (2 * GTF_CELL_GRAN);
@@ -774,7 +774,7 @@ bool v4l2_detect_gtf(unsigned int frame_height,
 		u64 num;
 		u32 den;
 
-		num = ((image_width * GTF_S_C_PRIME * (u64)hfreq) -
+		num = (((u64)image_width * GTF_S_C_PRIME * hfreq) -
 		      ((u64)image_width * GTF_S_M_PRIME * 1000));
 		den = (hfreq * (100 - GTF_S_C_PRIME) + GTF_S_M_PRIME * 1000) *
 		      (2 * GTF_CELL_GRAN);
diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
index 3eff98e26bea..6f8e39fe44ab 100644
--- a/drivers/mfd/ene-kb3930.c
+++ b/drivers/mfd/ene-kb3930.c
@@ -162,7 +162,7 @@ static int kb3930_probe(struct i2c_client *client)
 			devm_gpiod_get_array_optional(dev, "off", GPIOD_IN);
 		if (IS_ERR(ddata->off_gpios))
 			return PTR_ERR(ddata->off_gpios);
-		if (ddata->off_gpios->ndescs < 2) {
+		if (ddata->off_gpios && ddata->off_gpios->ndescs < 2) {
 			dev_err(dev, "invalid off-gpios property\n");
 			return -EINVAL;
 		}
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 18059a12d4e1..7b5fc0a50231 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -245,7 +245,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	return true;
 
 fail:
-	switch (irq_type) {
+	switch (test->irq_type) {
 	case IRQ_TYPE_LEGACY:
 		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
 			pci_irq_vector(pdev, i));
@@ -262,6 +262,9 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 		break;
 	}
 
+	test->num_irqs = i;
+	pci_endpoint_test_release_irq(test);
+
 	return false;
 }
 
@@ -714,6 +717,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	if (!pci_endpoint_test_request_irq(test))
 		goto err;
 
+	irq_type = test->irq_type;
 	return true;
 
 err:
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d0da4573b38c..0822493c949e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2574,6 +2574,91 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
 	}
 }
 
+static void dw_mci_push_data64_32(struct dw_mci *host, void *buf, int cnt)
+{
+	struct mmc_data *data = host->data;
+	int init_cnt = cnt;
+
+	/* try and push anything in the part_buf */
+	if (unlikely(host->part_buf_count)) {
+		int len = dw_mci_push_part_bytes(host, buf, cnt);
+
+		buf += len;
+		cnt -= len;
+
+		if (host->part_buf_count == 8) {
+			mci_fifo_l_writeq(host->fifo_reg, host->part_buf);
+			host->part_buf_count = 0;
+		}
+	}
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (unlikely((unsigned long)buf & 0x7)) {
+		while (cnt >= 8) {
+			u64 aligned_buf[16];
+			int len = min(cnt & -8, (int)sizeof(aligned_buf));
+			int items = len >> 3;
+			int i;
+			/* memcpy from input buffer into aligned buffer */
+			memcpy(aligned_buf, buf, len);
+			buf += len;
+			cnt -= len;
+			/* push data from aligned buffer into fifo */
+			for (i = 0; i < items; ++i)
+				mci_fifo_l_writeq(host->fifo_reg, aligned_buf[i]);
+		}
+	} else
+#endif
+	{
+		u64 *pdata = buf;
+
+		for (; cnt >= 8; cnt -= 8)
+			mci_fifo_l_writeq(host->fifo_reg, *pdata++);
+		buf = pdata;
+	}
+	/* put anything remaining in the part_buf */
+	if (cnt) {
+		dw_mci_set_part_bytes(host, buf, cnt);
+		/* Push data if we have reached the expected data length */
+		if ((data->bytes_xfered + init_cnt) ==
+		    (data->blksz * data->blocks))
+			mci_fifo_l_writeq(host->fifo_reg, host->part_buf);
+	}
+}
+
+static void dw_mci_pull_data64_32(struct dw_mci *host, void *buf, int cnt)
+{
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (unlikely((unsigned long)buf & 0x7)) {
+		while (cnt >= 8) {
+			/* pull data from fifo into aligned buffer */
+			u64 aligned_buf[16];
+			int len = min(cnt & -8, (int)sizeof(aligned_buf));
+			int items = len >> 3;
+			int i;
+
+			for (i = 0; i < items; ++i)
+				aligned_buf[i] = mci_fifo_l_readq(host->fifo_reg);
+
+			/* memcpy from aligned buffer into output buffer */
+			memcpy(buf, aligned_buf, len);
+			buf += len;
+			cnt -= len;
+		}
+	} else
+#endif
+	{
+		u64 *pdata = buf;
+
+		for (; cnt >= 8; cnt -= 8)
+			*pdata++ = mci_fifo_l_readq(host->fifo_reg);
+		buf = pdata;
+	}
+	if (cnt) {
+		host->part_buf = mci_fifo_l_readq(host->fifo_reg);
+		dw_mci_pull_final_bytes(host, buf, cnt);
+	}
+}
+
 static void dw_mci_pull_data(struct dw_mci *host, void *buf, int cnt)
 {
 	int len;
@@ -3374,8 +3459,13 @@ int dw_mci_probe(struct dw_mci *host)
 		width = 16;
 		host->data_shift = 1;
 	} else if (i == 2) {
-		host->push_data = dw_mci_push_data64;
-		host->pull_data = dw_mci_pull_data64;
+		if ((host->quirks & DW_MMC_QUIRK_FIFO64_32)) {
+			host->push_data = dw_mci_push_data64_32;
+			host->pull_data = dw_mci_pull_data64_32;
+		} else {
+			host->push_data = dw_mci_push_data64;
+			host->pull_data = dw_mci_pull_data64;
+		}
 		width = 64;
 		host->data_shift = 3;
 	} else {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 4ed81f94f7ca..af16dbb37f26 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -280,6 +280,8 @@ struct dw_mci_board {
 
 /* Support for longer data read timeout */
 #define DW_MMC_QUIRK_EXTENDED_TMOUT            BIT(0)
+/* Force 32-bit access to the FIFO */
+#define DW_MMC_QUIRK_FIFO64_32                 BIT(1)
 
 #define DW_MMC_240A		0x240a
 #define DW_MMC_280A		0x280a
@@ -471,6 +473,31 @@ struct dw_mci_board {
 #define mci_fifo_writel(__value, __reg)	__raw_writel(__reg, __value)
 #define mci_fifo_writeq(__value, __reg)	__raw_writeq(__reg, __value)
 
+/*
+ * Some dw_mmc devices have 64-bit FIFOs, but expect them to be
+ * accessed using two 32-bit accesses. If such controller is used
+ * with a 64-bit kernel, this has to be done explicitly.
+ */
+static inline u64 mci_fifo_l_readq(void __iomem *addr)
+{
+	u64 ans;
+	u32 proxy[2];
+
+	proxy[0] = mci_fifo_readl(addr);
+	proxy[1] = mci_fifo_readl(addr + 4);
+	memcpy(&ans, proxy, 8);
+	return ans;
+}
+
+static inline void mci_fifo_l_writeq(void __iomem *addr, u64 value)
+{
+	u32 proxy[2];
+
+	memcpy(proxy, &value, 8);
+	mci_fifo_writel(addr, proxy[0]);
+	mci_fifo_writel(addr + 4, proxy[1]);
+}
+
 /* Register access macros */
 #define mci_readl(dev, reg)			\
 	readl_relaxed((dev)->regs + SDMMC_##reg)
diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index 58ca1c21ebe6..cd1eeb7a8cf1 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -482,10 +482,11 @@ static inline u16 INFTL_findwriteunit(struct INFTLrecord *inftl, unsigned block)
 		silly = MAX_LOOPS;
 
 		while (thisEUN <= inftl->lastEUN) {
-			inftl_read_oob(mtd, (thisEUN * inftl->EraseSize) +
-				       blockofs, 8, &retlen, (char *)&bci);
-
-			status = bci.Status | bci.Status1;
+			if (inftl_read_oob(mtd, (thisEUN * inftl->EraseSize) +
+				       blockofs, 8, &retlen, (char *)&bci) < 0)
+				status = SECTOR_IGNORE;
+			else
+				status = bci.Status | bci.Status1;
 			pr_debug("INFTL: status of block %d in EUN %d is %x\n",
 					block , writeEUN, status);
 
diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index 7ac8ac901306..9cf3872e37ae 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -417,11 +417,14 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	}
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
-	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
-	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	cxt->rmmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
+	cxt->usedmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
-	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	cxt->badmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
+
+	if (!cxt->rmmap || !cxt->usedmap || !cxt->badmap)
+		return;
 
 	/* just support dmesg right now */
 	cxt->dev.flags = PSTORE_FLAGS_DMESG;
@@ -527,9 +530,6 @@ static void mtdpstore_notify_remove(struct mtd_info *mtd)
 	mtdpstore_flush_removed(cxt);
 
 	unregister_pstore_device(&cxt->dev);
-	kfree(cxt->badmap);
-	kfree(cxt->usedmap);
-	kfree(cxt->rmmap);
 	cxt->mtd = NULL;
 	cxt->index = -1;
 }
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 39661e23d7d4..20c6aeef107c 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2968,7 +2968,7 @@ static int brcmnand_resume(struct device *dev)
 		brcmnand_save_restore_cs_config(host, 1);
 
 		/* Reset the chip, required by some chips after power-up */
-		nand_reset_op(chip);
+		nand_reset(chip, 0);
 	}
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index ed0cf732d20e..36cfe03cd4ac 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -387,6 +387,9 @@ static int r852_wait(struct nand_chip *chip)
 static int r852_ready(struct nand_chip *chip)
 {
 	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
+	if (dev->card_unstable)
+		return 0;
+
 	return !(r852_read_reg(dev, R852_CARD_STA) & R852_CARD_STA_BUSY);
 }
 
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 463c6d84ae1b..ea7d2c01e672 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -724,6 +724,15 @@ static void b53_enable_mib(struct b53_device *dev)
 	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
 }
 
+static void b53_enable_stp(struct b53_device *dev)
+{
+	u8 gc;
+
+	b53_read8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, &gc);
+	gc |= GC_RX_BPDU_EN;
+	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
+}
+
 static u16 b53_default_pvid(struct b53_device *dev)
 {
 	if (is5325(dev) || is5365(dev))
@@ -863,6 +872,7 @@ static int b53_switch_reset(struct b53_device *dev)
 	}
 
 	b53_enable_mib(dev);
+	b53_enable_stp(dev);
 
 	return b53_flush_arl(dev, FAST_AGE_STATIC);
 }
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b485176e53cd..4c60f79ce269 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1724,6 +1724,8 @@ static int mv88e6xxx_vtu_get(struct mv88e6xxx_chip *chip, u16 vid,
 	if (!chip->info->ops->vtu_getnext)
 		return -EOPNOTSUPP;
 
+	memset(entry, 0, sizeof(*entry));
+
 	entry->vid = vid ? vid - 1 : mv88e6xxx_max_vid(chip);
 	entry->valid = false;
 
@@ -1859,7 +1861,16 @@ static int mv88e6xxx_mst_put(struct mv88e6xxx_chip *chip, u8 sid)
 	struct mv88e6xxx_mst *mst, *tmp;
 	int err;
 
-	if (!sid)
+	/* If the SID is zero, it is for a VLAN mapped to the default MSTI,
+	 * and mv88e6xxx_stu_setup() made sure it is always present, and thus,
+	 * should not be removed here.
+	 *
+	 * If the chip lacks STU support, numerically the "sid" variable will
+	 * happen to also be zero, but we don't want to rely on that fact, so
+	 * we explicitly test that first. In that case, there is also nothing
+	 * to do here.
+	 */
+	if (!mv88e6xxx_has_stu(chip) || !sid)
 		return 0;
 
 	list_for_each_entry_safe(mst, tmp, &chip->msts, node) {
@@ -3694,6 +3705,21 @@ static int mv88e6xxx_stats_setup(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_stats_clear(chip);
 }
 
+static int mv88e6320_setup_errata(struct mv88e6xxx_chip *chip)
+{
+	u16 dummy;
+	int err;
+
+	/* Workaround for erratum
+	 *   3.3 RGMII timing may be out of spec when transmit delay is enabled
+	 */
+	err = mv88e6xxx_port_hidden_write(chip, 0, 0xf, 0x7, 0xe000);
+	if (err)
+		return err;
+
+	return mv88e6xxx_port_hidden_read(chip, 0, 0xf, 0x7, &dummy);
+}
+
 /* Check if the errata has already been applied. */
 static bool mv88e6390_setup_errata_applied(struct mv88e6xxx_chip *chip)
 {
@@ -5110,6 +5136,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 
 static const struct mv88e6xxx_ops mv88e6320_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
@@ -5157,6 +5184,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 1266eabee086..2ab2eb2cb47b 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -743,7 +743,8 @@ void mv88e6xxx_teardown_devlink_regions_global(struct dsa_switch *ds)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mv88e6xxx_regions); i++)
-		dsa_devlink_region_destroy(chip->regions[i]);
+		if (chip->regions[i])
+			dsa_devlink_region_destroy(chip->regions[i]);
 }
 
 void mv88e6xxx_teardown_devlink_regions_port(struct dsa_switch *ds, int port)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 8477a93cee6b..b77897aa06c4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -2273,6 +2273,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
 		eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
 		if (!eth_filter->port[i].bmap) {
 			ret = -ENOMEM;
+			kvfree(eth_filter->port[i].loc_array);
 			goto free_eth_finfo;
 		}
 	}
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 033f17cb96be..7e60139f8ac5 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -327,7 +327,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				 */
 				data[i++] = 0;
 				data[i++] = 0;
-				data[i++] = tx->dqo_tx.tail - tx->dqo_tx.head;
+				data[i++] =
+					(tx->dqo_tx.tail - tx->dqo_tx.head) &
+					tx->mask;
 			}
 			do {
 				start =
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 8187a658dcbd..17a7e3c875cc 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -574,6 +574,7 @@
 #define IGC_PTM_STAT_T4M1_OVFL		BIT(3) /* T4 minus T1 overflow */
 #define IGC_PTM_STAT_ADJUST_1ST		BIT(4) /* 1588 timer adjusted during 1st PTM cycle */
 #define IGC_PTM_STAT_ADJUST_CYC		BIT(5) /* 1588 timer adjusted during non-1st PTM cycle */
+#define IGC_PTM_STAT_ALL		GENMASK(5, 0) /* Used to clear all status */
 
 /* PCIe PTM Cycle Control */
 #define IGC_PTM_CYCLE_CTRL_CYC_TIME(msec)	((msec) & 0x3ff) /* PTM Cycle Time (msec) */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6ae2d0b723c8..082f78beeb4e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6725,6 +6725,7 @@ static int igc_probe(struct pci_dev *pdev,
 
 err_register:
 	igc_release_hw_control(adapter);
+	igc_ptp_stop(adapter);
 err_eeprom:
 	if (!igc_check_reset_block(hw))
 		igc_reset_phy(hw);
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 14cd7f995280..8731e8f23494 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -844,45 +844,60 @@ static void igc_ptm_log_error(struct igc_adapter *adapter, u32 ptm_stat)
 	}
 }
 
+static void igc_ptm_trigger(struct igc_hw *hw)
+{
+	u32 ctrl;
+
+	/* To "manually" start the PTM cycle we need to set the
+	 * trigger (TRIG) bit
+	 */
+	ctrl = rd32(IGC_PTM_CTRL);
+	ctrl |= IGC_PTM_CTRL_TRIG;
+	wr32(IGC_PTM_CTRL, ctrl);
+	/* Perform flush after write to CTRL register otherwise
+	 * transaction may not start
+	 */
+	wrfl();
+}
+
+static void igc_ptm_reset(struct igc_hw *hw)
+{
+	u32 ctrl;
+
+	ctrl = rd32(IGC_PTM_CTRL);
+	ctrl &= ~IGC_PTM_CTRL_TRIG;
+	wr32(IGC_PTM_CTRL, ctrl);
+	/* Write to clear all status */
+	wr32(IGC_PTM_STAT, IGC_PTM_STAT_ALL);
+}
+
 static int igc_phc_get_syncdevicetime(ktime_t *device,
 				      struct system_counterval_t *system,
 				      void *ctx)
 {
-	u32 stat, t2_curr_h, t2_curr_l, ctrl;
 	struct igc_adapter *adapter = ctx;
 	struct igc_hw *hw = &adapter->hw;
+	u32 stat, t2_curr_h, t2_curr_l;
 	int err, count = 100;
 	ktime_t t1, t2_curr;
 
-	/* Get a snapshot of system clocks to use as historic value. */
-	ktime_get_snapshot(&adapter->snapshot);
-
+	/* Doing this in a loop because in the event of a
+	 * badly timed (ha!) system clock adjustment, we may
+	 * get PTM errors from the PCI root, but these errors
+	 * are transitory. Repeating the process returns valid
+	 * data eventually.
+	 */
 	do {
-		/* Doing this in a loop because in the event of a
-		 * badly timed (ha!) system clock adjustment, we may
-		 * get PTM errors from the PCI root, but these errors
-		 * are transitory. Repeating the process returns valid
-		 * data eventually.
-		 */
+		/* Get a snapshot of system clocks to use as historic value. */
+		ktime_get_snapshot(&adapter->snapshot);
 
-		/* To "manually" start the PTM cycle we need to clear and
-		 * then set again the TRIG bit.
-		 */
-		ctrl = rd32(IGC_PTM_CTRL);
-		ctrl &= ~IGC_PTM_CTRL_TRIG;
-		wr32(IGC_PTM_CTRL, ctrl);
-		ctrl |= IGC_PTM_CTRL_TRIG;
-		wr32(IGC_PTM_CTRL, ctrl);
-
-		/* The cycle only starts "for real" when software notifies
-		 * that it has read the registers, this is done by setting
-		 * VALID bit.
-		 */
-		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
+		igc_ptm_trigger(hw);
 
 		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
 					 stat, IGC_PTM_STAT_SLEEP,
 					 IGC_PTM_STAT_TIMEOUT);
+		igc_ptm_reset(hw);
+
 		if (err < 0) {
 			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 			return err;
@@ -891,15 +906,7 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 		if ((stat & IGC_PTM_STAT_VALID) == IGC_PTM_STAT_VALID)
 			break;
 
-		if (stat & ~IGC_PTM_STAT_VALID) {
-			/* An error occurred, log it. */
-			igc_ptm_log_error(adapter, stat);
-			/* The STAT register is write-1-to-clear (W1C),
-			 * so write the previous error status to clear it.
-			 */
-			wr32(IGC_PTM_STAT, stat);
-			continue;
-		}
+		igc_ptm_log_error(adapter, stat);
 	} while (--count);
 
 	if (!count) {
@@ -1063,8 +1070,12 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
  **/
 void igc_ptp_stop(struct igc_adapter *adapter)
 {
+	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
+		return;
+
 	igc_ptp_suspend(adapter);
 
+	adapter->ptp_flags &= ~IGC_PTP_ENABLED;
 	if (adapter->ptp_clock) {
 		ptp_clock_unregister(adapter->ptp_clock);
 		netdev_info(adapter->netdev, "PHC removed\n");
@@ -1081,10 +1092,13 @@ void igc_ptp_stop(struct igc_adapter *adapter)
 void igc_ptp_reset(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
-	u32 cycle_ctrl, ctrl;
+	u32 cycle_ctrl, ctrl, stat;
 	unsigned long flags;
 	u32 timadj;
 
+	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
+		return;
+
 	/* reset the tstamp_config */
 	igc_ptp_set_timestamp_mode(adapter, &adapter->tstamp_config);
 
@@ -1116,14 +1130,19 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 		ctrl = IGC_PTM_CTRL_EN |
 			IGC_PTM_CTRL_START_NOW |
 			IGC_PTM_CTRL_SHRT_CYC(IGC_PTM_SHORT_CYC_DEFAULT) |
-			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT) |
-			IGC_PTM_CTRL_TRIG;
+			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT);
 
 		wr32(IGC_PTM_CTRL, ctrl);
 
 		/* Force the first cycle to run. */
-		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
+		igc_ptm_trigger(hw);
+
+		if (readx_poll_timeout_atomic(rd32, IGC_PTM_STAT, stat,
+					      stat, IGC_PTM_STAT_SLEEP,
+					      IGC_PTM_STAT_TIMEOUT))
+			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 
+		igc_ptm_reset(hw);
 		break;
 	default:
 		/* No work to do. */
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 94ef6f9ca510..fb533c43deee 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -515,6 +515,11 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *skb)
 	unsigned char *data;
 	int islcp;
 
+	/* Ensure we can safely access protocol field and LCP code */
+	if (!pskb_may_pull(skb, 3)) {
+		kfree_skb(skb);
+		return NULL;
+	}
 	data  = skb->data;
 	proto = get_unaligned_be16(data);
 
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 24e609c1f523..4a15c22cf348 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2553,7 +2553,7 @@ static void at76_disconnect(struct usb_interface *interface)
 
 	wiphy_info(priv->hw->wiphy, "disconnecting\n");
 	at76_delete_device(priv);
-	usb_put_dev(priv->udev);
+	usb_put_dev(interface_to_usbdev(interface));
 	dev_info(&interface->dev, "disconnected\n");
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 0a88048b8976..d35f31378ac1 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -90,6 +90,10 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 
 #ifdef CONFIG_NL80211_TESTMODE
 	dev->test_mtd.name = devm_kstrdup(dev->dev, part, GFP_KERNEL);
+	if (!dev->test_mtd.name) {
+		ret = -ENOMEM;
+		goto out_put_node;
+	}
 	dev->test_mtd.offset = offset;
 #endif
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 55068f3252ef..d80430999219 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -21,6 +21,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
 	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
+	{ USB_DEVICE(0x2357, 0x0137) },	/* TP-Link TL-WDN6200 */
 	{ },
 };
 
diff --git a/drivers/net/wireless/ti/wl1251/tx.c b/drivers/net/wireless/ti/wl1251/tx.c
index e9dc3c72bb11..06dc74cc6cb5 100644
--- a/drivers/net/wireless/ti/wl1251/tx.c
+++ b/drivers/net/wireless/ti/wl1251/tx.c
@@ -342,8 +342,10 @@ void wl1251_tx_work(struct work_struct *work)
 	while ((skb = skb_dequeue(&wl->tx_queue))) {
 		if (!woken_up) {
 			ret = wl1251_ps_elp_wakeup(wl);
-			if (ret < 0)
+			if (ret < 0) {
+				skb_queue_head(&wl->tx_queue, skb);
 				goto out;
+			}
 			woken_up = true;
 		}
 
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 5b25260e5925..43b387ba9eb1 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1351,7 +1351,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	qp_count = ilog2(qp_bitmap);
 	if (nt->use_msi) {
 		qp_count -= 1;
-		nt->msi_db_mask = 1 << qp_count;
+		nt->msi_db_mask = BIT_ULL(qp_count);
 		ntb_db_clear_mask(ndev, nt->msi_db_mask);
 	}
 
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 8a02ed63b156..d40d5a4ea932 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -173,20 +173,6 @@ struct nvmet_fc_tgt_assoc {
 	struct rcu_head			rcu;
 };
 
-
-static inline int
-nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
-{
-	return (iodptr - iodptr->tgtport->iod);
-}
-
-static inline int
-nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
-{
-	return (fodptr - fodptr->queue->fod);
-}
-
-
 /*
  * Association and Connection IDs:
  *
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index f5b8442b653d..787dfb3859a0 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -478,7 +478,7 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	if (targetport) {
 		tport = targetport->private;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		queue_work(nvmet_wq, &tport->ls_work);
 	}
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 8d77566eae1a..24e2273b9df2 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/list.h>
@@ -38,11 +39,15 @@
 unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
 {
 	struct of_phandle_args oirq;
+	unsigned int ret;
 
 	if (of_irq_parse_one(dev, index, &oirq))
 		return 0;
 
-	return irq_create_of_mapping(&oirq);
+	ret = irq_create_of_mapping(&oirq);
+	of_node_put(oirq.np);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
 
@@ -165,6 +170,8 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
  * the specifier for each map, and then returns the translated map.
  *
  * Return: 0 on success and a negative number on error
+ *
+ * Note: refcount of node @out_irq->np is increased by 1 on success.
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
@@ -310,6 +317,12 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		addrsize = (imap - match_array) - intsize;
 
 		if (ipar == newpar) {
+			/*
+			 * We got @ipar's refcount, but the refcount was
+			 * gotten again by of_irq_parse_imap_parent() via its
+			 * alias @newpar.
+			 */
+			of_node_put(ipar);
 			pr_debug("%pOF interrupt-map entry to self\n", ipar);
 			return 0;
 		}
@@ -339,10 +352,12 @@ EXPORT_SYMBOL_GPL(of_irq_parse_raw);
  * This function resolves an interrupt for a node by walking the interrupt tree,
  * finding which interrupt controller node it is attached to, and returning the
  * interrupt specifier that can be used to retrieve a Linux IRQ number.
+ *
+ * Note: refcount of node @out_irq->np is increased by 1 on success.
  */
 int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_args *out_irq)
 {
-	struct device_node *p;
+	struct device_node __free(device_node) *p = NULL;
 	const __be32 *addr;
 	u32 intsize;
 	int i, res, addr_len;
@@ -367,41 +382,33 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
-	if (!res)
-		return of_irq_parse_raw(addr_buf, out_irq);
-
-	/* Look for the interrupt parent. */
-	p = of_irq_find_parent(device);
-	if (p == NULL)
-		return -EINVAL;
-
-	/* Get size of interrupt specifier */
-	if (of_property_read_u32(p, "#interrupt-cells", &intsize)) {
-		res = -EINVAL;
-		goto out;
-	}
-
-	pr_debug(" parent=%pOF, intsize=%d\n", p, intsize);
+	if (!res) {
+		p = out_irq->np;
+	} else {
+		/* Look for the interrupt parent. */
+		p = of_irq_find_parent(device);
+		/* Get size of interrupt specifier */
+		if (!p || of_property_read_u32(p, "#interrupt-cells", &intsize))
+			return -EINVAL;
+
+		pr_debug(" parent=%pOF, intsize=%d\n", p, intsize);
+
+		/* Copy intspec into irq structure */
+		out_irq->np = p;
+		out_irq->args_count = intsize;
+		for (i = 0; i < intsize; i++) {
+			res = of_property_read_u32_index(device, "interrupts",
+							(index * intsize) + i,
+							out_irq->args + i);
+			if (res)
+				return res;
+		}
 
-	/* Copy intspec into irq structure */
-	out_irq->np = p;
-	out_irq->args_count = intsize;
-	for (i = 0; i < intsize; i++) {
-		res = of_property_read_u32_index(device, "interrupts",
-						 (index * intsize) + i,
-						 out_irq->args + i);
-		if (res)
-			goto out;
+		pr_debug(" intspec=%d\n", *out_irq->args);
 	}
 
-	pr_debug(" intspec=%d\n", *out_irq->args);
-
-
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr_buf, out_irq);
- out:
-	of_node_put(p);
-	return res;
+	return of_irq_parse_raw(addr_buf, out_irq);
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_one);
 
@@ -500,8 +507,10 @@ int of_irq_count(struct device_node *dev)
 	struct of_phandle_args irq;
 	int nr = 0;
 
-	while (of_irq_parse_one(dev, nr, &irq) == 0)
+	while (of_irq_parse_one(dev, nr, &irq) == 0) {
+		of_node_put(irq.np);
 		nr++;
+	}
 
 	return nr;
 }
@@ -618,6 +627,8 @@ void __init of_irq_init(const struct of_device_id *matches)
 				       __func__, desc->dev, desc->dev,
 				       desc->interrupt_parent);
 				of_node_clear_flag(desc->dev, OF_POPULATED);
+				of_node_put(desc->interrupt_parent);
+				of_node_put(desc->dev);
 				kfree(desc);
 				continue;
 			}
@@ -648,6 +659,7 @@ void __init of_irq_init(const struct of_device_id *matches)
 err:
 	list_for_each_entry_safe(desc, temp_desc, &intc_desc_list, list) {
 		list_del(&desc->list);
+		of_node_put(desc->interrupt_parent);
 		of_node_put(desc->dev);
 		kfree(desc);
 	}
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 3056e9b7223e..425db793080d 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1488,7 +1488,7 @@ static struct pci_ops brcm7425_pcie_ops = {
 
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node, *msi_np;
+	struct device_node *np = pdev->dev.of_node;
 	struct pci_host_bridge *bridge;
 	const struct pcie_cfg_data *data;
 	struct brcm_pcie *pcie;
@@ -1563,9 +1563,14 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
-	if (pci_msi_enabled() && msi_np == pcie->np) {
-		ret = brcm_pcie_enable_msi(pcie);
+	if (pci_msi_enabled()) {
+		struct device_node *msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
+
+		if (msi_np == pcie->np)
+			ret = brcm_pcie_enable_msi(pcie);
+
+		of_node_put(msi_np);
+
 		if (ret) {
 			dev_err(pcie->dev, "probe of internal MSI failed");
 			goto fail;
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a1dd614bdc32..09995b6e73bc 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -110,7 +110,7 @@ struct vmd_irq_list {
 struct vmd_dev {
 	struct pci_dev		*dev;
 
-	spinlock_t		cfg_lock;
+	raw_spinlock_t		cfg_lock;
 	void __iomem		*cfgbar;
 
 	int msix_count;
@@ -387,7 +387,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		*value = readb(addr);
@@ -402,7 +402,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -422,7 +422,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
@@ -440,7 +440,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -958,7 +958,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	spin_lock_init(&vmd->cfg_lock);
+	raw_spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f411cef0186e..8a35a9887302 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5578,8 +5578,6 @@ static bool pci_bus_resetable(struct pci_bus *bus)
 		return false;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!pci_reset_supported(dev))
-			return false;
 		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
 		    (dev->subordinate && !pci_bus_resetable(dev->subordinate)))
 			return false;
@@ -5656,8 +5654,6 @@ static bool pci_slot_resetable(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		if (!pci_reset_supported(dev))
-			return false;
 		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
 		    (dev->subordinate && !pci_bus_resetable(dev->subordinate)))
 			return false;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bd3532764877..b4ed95c4a5a6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1141,7 +1141,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 add_dev:
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
-	WARN_ON(ret < 0);
+	if (WARN_ON(ret < 0)) {
+		put_device(&child->dev);
+		return NULL;
+	}
 
 	pcibios_add_bus(child);
 
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 3f07df5a7e95..d351d6ce750b 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -340,12 +340,10 @@ armpmu_add(struct perf_event *event, int flags)
 	if (idx < 0)
 		return idx;
 
-	/*
-	 * If there is an event in the counter we are going to use then make
-	 * sure it is disabled.
-	 */
+	/* The newly-allocated counter should be empty */
+	WARN_ON_ONCE(hw_events->events[idx]);
+
 	event->hw.idx = idx;
-	armpmu->disable(event);
 	hw_events->events[idx] = event;
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 8bf8b21954fe..7d25d95e156c 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1006,8 +1006,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct msm_pingroup *g;
 	unsigned long flags;
-	bool was_enabled;
-	u32 val;
+	u32 val, oldval;
 
 	if (msm_gpio_needs_dual_edge_parent_workaround(d, type)) {
 		set_bit(d->hwirq, pctrl->dual_edge_irqs);
@@ -1067,8 +1066,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	 * internal circuitry of TLMM, toggling the RAW_STATUS
 	 * could cause the INTR_STATUS to be set for EDGE interrupts.
 	 */
-	val = msm_readl_intr_cfg(pctrl, g);
-	was_enabled = val & BIT(g->intr_raw_status_bit);
+	val = oldval = msm_readl_intr_cfg(pctrl, g);
 	val |= BIT(g->intr_raw_status_bit);
 	if (g->intr_detection_width == 2) {
 		val &= ~(3 << g->intr_detection_bit);
@@ -1121,9 +1119,11 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	/*
 	 * The first time we set RAW_STATUS_EN it could trigger an interrupt.
 	 * Clear the interrupt.  This is safe because we have
-	 * IRQCHIP_SET_TYPE_MASKED.
+	 * IRQCHIP_SET_TYPE_MASKED. When changing the interrupt type, we could
+	 * also still have a non-matching interrupt latched, so clear whenever
+	 * making changes to the interrupt configuration.
 	 */
-	if (!was_enabled)
+	if (val != oldval)
 		msm_ack_intr_status(pctrl, g);
 
 	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 47b2f8bb6fb5..c60744d97d5b 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -427,11 +427,14 @@ static int asus_pega_lucid_set(struct asus_laptop *asus, int unit, bool enable)
 
 static int pega_acc_axis(struct asus_laptop *asus, int curr, char *method)
 {
+	unsigned long long val = (unsigned long long)curr;
+	acpi_status status;
 	int i, delta;
-	unsigned long long val;
-	for (i = 0; i < PEGA_ACC_RETRIES; i++) {
-		acpi_evaluate_integer(asus->handle, method, NULL, &val);
 
+	for (i = 0; i < PEGA_ACC_RETRIES; i++) {
+		status = acpi_evaluate_integer(asus->handle, method, NULL, &val);
+		if (ACPI_FAILURE(status))
+			continue;
 		/* The output is noisy.  From reading the ASL
 		 * dissassembly, timeout errors are returned with 1's
 		 * in the high word, and the lack of locking around
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 87b960e941ba..b6f66a9886ce 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1654,6 +1654,7 @@ ptp_ocp_signal_set(struct ptp_ocp *bp, int gen, struct ptp_ocp_signal *s)
 	if (!s->start) {
 		/* roundup() does not work on 32-bit systems */
 		s->start = DIV64_U64_ROUND_UP(start_ns, s->period);
+		s->start *= s->period;
 		s->start = ktime_add(s->start, s->phase);
 	}
 
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 0247757f9a72..6751f3d00560 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -123,6 +123,9 @@ static unsigned int fsl_pwm_ticks_to_ns(struct fsl_pwm_chip *fpc,
 	unsigned long long exval;
 
 	rate = clk_get_rate(fpc->clk[fpc->period.clk_select]);
+	if (rate >> fpc->period.clk_ps == 0)
+		return 0;
+
 	exval = ticks;
 	exval *= 1000000000UL;
 	do_div(exval, rate >> fpc->period.clk_ps);
@@ -195,6 +198,9 @@ static unsigned int fsl_pwm_calculate_duty(struct fsl_pwm_chip *fpc,
 	unsigned int period = fpc->period.mod_period + 1;
 	unsigned int period_ns = fsl_pwm_ticks_to_ns(fpc, period);
 
+	if (!period_ns)
+		return 0;
+
 	duty = (unsigned long long)duty_ns * period;
 	do_div(duty, period_ns);
 
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index a337b47dc2f7..10c2ed23f551 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -120,21 +120,25 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
+	unsigned long clk_rate;
 	u64 resolution;
 	int ret;
 
 	ret = pwm_mediatek_clk_enable(chip, pwm);
-
 	if (ret < 0)
 		return ret;
 
+	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
+	if (!clk_rate)
+		return -EINVAL;
+
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
 		writel(0, pc->regs + PWM_CK_26M_SEL);
 
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
+	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
 	while (cnt_period > 8191) {
diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 55f46d09602b..b2e75d870532 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -8,6 +8,7 @@
  * - The hardware cannot generate a 0% duty cycle.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -103,23 +104,24 @@ static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp,
 	rcar_pwm_write(rp, value, RCAR_PWMCR);
 }
 
-static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
-				int period_ns)
+static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, u64 duty_ns,
+				u64 period_ns)
 {
-	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
+	unsigned long long tmp;
 	unsigned long clk_rate = clk_get_rate(rp->clk);
 	u32 cyc, ph;
 
-	one_cycle = NSEC_PER_SEC * 100ULL << div;
-	do_div(one_cycle, clk_rate);
+	/* div <= 24 == RCAR_PWM_MAX_DIVISION, so the shift doesn't overflow. */
+	tmp = mul_u64_u64_div_u64(period_ns, clk_rate, (u64)NSEC_PER_SEC << div);
+	if (tmp > FIELD_MAX(RCAR_PWMCNT_CYC0_MASK))
+		tmp = FIELD_MAX(RCAR_PWMCNT_CYC0_MASK);
 
-	tmp = period_ns * 100ULL;
-	do_div(tmp, one_cycle);
-	cyc = (tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;
+	cyc = FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, tmp);
 
-	tmp = duty_ns * 100ULL;
-	do_div(tmp, one_cycle);
-	ph = tmp & RCAR_PWMCNT_PH0_MASK;
+	tmp = mul_u64_u64_div_u64(duty_ns, clk_rate, (u64)NSEC_PER_SEC << div);
+	if (tmp > FIELD_MAX(RCAR_PWMCNT_PH0_MASK))
+		tmp = FIELD_MAX(RCAR_PWMCNT_PH0_MASK);
+	ph = FIELD_PREP(RCAR_PWMCNT_PH0_MASK, tmp);
 
 	/* Avoid prohibited setting */
 	if (cyc == 0 || ph == 0)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 50697672146a..ae39f6b5dc9a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2502,6 +2502,7 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = to_hisi_sas_port(sas_port);
 	struct sas_ata_task *ata_task = &task->ata_task;
 	struct sas_tmf_task *tmf = slot->tmf;
+	int phy_id;
 	u8 *buf_cmd;
 	int has_data = 0, hdr_tag = 0;
 	u32 dw0, dw1 = 0, dw2 = 0;
@@ -2509,10 +2510,14 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 	/* create header */
 	/* dw0 */
 	dw0 = port->id << CMD_HDR_PORT_OFF;
-	if (parent_dev && dev_is_expander(parent_dev->dev_type))
+	if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
 		dw0 |= 3 << CMD_HDR_CMD_OFF;
-	else
+	} else {
+		phy_id = device->phy->identify.phy_identifier;
+		dw0 |= (1U << phy_id) << CMD_HDR_PHY_ID_OFF;
+		dw0 |= CMD_HDR_FORCE_PHY_MSK;
 		dw0 |= 4 << CMD_HDR_CMD_OFF;
+	}
 
 	if (tmf && ata_task->force_phy) {
 		dw0 |= CMD_HDR_FORCE_PHY_MSK;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 05dcd925a3fa..20b4d76e0714 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -357,6 +357,10 @@
 #define CMD_HDR_RESP_REPORT_MSK		(0x1 << CMD_HDR_RESP_REPORT_OFF)
 #define CMD_HDR_TLR_CTRL_OFF		6
 #define CMD_HDR_TLR_CTRL_MSK		(0x3 << CMD_HDR_TLR_CTRL_OFF)
+#define CMD_HDR_PHY_ID_OFF		8
+#define CMD_HDR_PHY_ID_MSK		(0x1ff << CMD_HDR_PHY_ID_OFF)
+#define CMD_HDR_FORCE_PHY_OFF		17
+#define CMD_HDR_FORCE_PHY_MSK		(0x1U << CMD_HDR_FORCE_PHY_OFF)
 #define CMD_HDR_PORT_OFF		18
 #define CMD_HDR_PORT_MSK		(0xf << CMD_HDR_PORT_OFF)
 #define CMD_HDR_PRIORITY_OFF		27
@@ -1385,15 +1389,21 @@ static void prep_ata_v3_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_port *port = to_hisi_sas_port(sas_port);
+	int phy_id;
 	u8 *buf_cmd;
 	int has_data = 0, hdr_tag = 0;
 	u32 dw1 = 0, dw2 = 0;
 
 	hdr->dw0 = cpu_to_le32(port->id << CMD_HDR_PORT_OFF);
-	if (parent_dev && dev_is_expander(parent_dev->dev_type))
+	if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
 		hdr->dw0 |= cpu_to_le32(3 << CMD_HDR_CMD_OFF);
-	else
+	} else {
+		phy_id = device->phy->identify.phy_identifier;
+		hdr->dw0 |= cpu_to_le32((1U << phy_id)
+				<< CMD_HDR_PHY_ID_OFF);
+		hdr->dw0 |= CMD_HDR_FORCE_PHY_MSK;
 		hdr->dw0 |= cpu_to_le32(4U << CMD_HDR_CMD_OFF);
+	}
 
 	switch (task->data_dir) {
 	case DMA_TO_DEVICE:
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index f4b32ce45ce0..247e84e989aa 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -2101,6 +2101,9 @@ static int megasas_slave_configure(struct scsi_device *sdev)
 	/* This sdev property may change post OCR */
 	megasas_set_dynamic_target_properties(sdev, is_target_prop);
 
+	if (!MEGASAS_IS_LOGICAL(sdev))
+		sdev->no_vpd_size = 1;
+
 	mutex_unlock(&instance->reset_mutex);
 
 	return 0;
@@ -3661,8 +3664,10 @@ megasas_complete_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd,
 
 		case MFI_STAT_SCSI_IO_FAILED:
 		case MFI_STAT_LD_INIT_IN_PROGRESS:
-			cmd->scmd->result =
-			    (DID_ERROR << 16) | hdr->scsi_status;
+			if (hdr->scsi_status == 0xf0)
+				cmd->scmd->result = (DID_ERROR << 16) | SAM_STAT_CHECK_CONDITION;
+			else
+				cmd->scmd->result = (DID_ERROR << 16) | hdr->scsi_status;
 			break;
 
 		case MFI_STAT_SCSI_DONE_WITH_ERROR:
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 1475f3e259c1..4c79d699543e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2040,7 +2040,10 @@ map_cmd_status(struct fusion_context *fusion,
 
 	case MFI_STAT_SCSI_IO_FAILED:
 	case MFI_STAT_LD_INIT_IN_PROGRESS:
-		scmd->result = (DID_ERROR << 16) | ext_status;
+		if (ext_status == 0xf0)
+			scmd->result = (DID_ERROR << 16) | SAM_STAT_CHECK_CONDITION;
+		else
+			scmd->result = (DID_ERROR << 16) | ext_status;
 		break;
 
 	case MFI_STAT_SCSI_DONE_WITH_ERROR:
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 687487ea4fd3..7f0fd03dd03b 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3207,11 +3207,14 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 	}
 
 	/* see similar check in iscsi_if_set_param() */
-	if (strlen(data) > ev->u.set_host_param.len)
-		return -EINVAL;
+	if (strlen(data) > ev->u.set_host_param.len) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	err = transport->set_host_param(shost, ev->u.set_host_param.param,
 					data, ev->u.set_host_param.len);
+out:
 	scsi_host_put(shost);
 	return err;
 }
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index b3caa3b9722d..7f107be34423 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4112,7 +4112,7 @@ static void validate_options(void)
  */
 static int __init st_setup(char *str)
 {
-	int i, len, ints[5];
+	int i, len, ints[ARRAY_SIZE(parms) + 1];
 	char *stp;
 
 	stp = get_options(str, ARRAY_SIZE(ints), ints);
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 0fb3631e7346..b80bd80aa012 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -131,6 +131,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 
 	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 						"%x", soc_info.revision);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
 	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b371e4eb41ec..42861bc45073 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1509,6 +1509,12 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 		int ret = PTR_ERR(cqspi->rx_chan);
 
 		cqspi->rx_chan = NULL;
+		if (ret == -ENODEV) {
+			/* DMA support is not mandatory */
+			dev_info(&cqspi->pdev->dev, "No Rx DMA available\n");
+			return 0;
+		}
+
 		return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
 	}
 	init_completion(&cqspi->rx_dma_complete);
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 819e059cde71..9fc375cee5a6 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -373,6 +373,7 @@ static const struct tsadc_table rk3328_code_table[] = {
 	{296, -40000},
 	{304, -35000},
 	{313, -30000},
+	{322, -25000},
 	{331, -20000},
 	{340, -15000},
 	{349, -10000},
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index c0030a03dd34..064829640c18 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -901,6 +901,12 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 	}
 
 	phy_set_bus_width(generic_phy, ufs->avail_ln_rx);
+
+	if (generic_phy->power_count) {
+		phy_power_off(generic_phy);
+		phy_exit(generic_phy);
+	}
+
 	ret = phy_init(generic_phy);
 	if (ret) {
 		dev_err(hba->dev, "%s: phy init failed, ret = %d\n",
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index b6ac21b0322d..8cc84840efe8 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -166,9 +166,12 @@ static void fill_indir(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mkey, v
 			klm->bcount = cpu_to_be32(klm_bcount(dmr->end - dmr->start));
 			preve = dmr->end;
 		} else {
+			u64 bcount = min_t(u64, dmr->start - preve, MAX_KLM_SIZE);
+
 			klm->key = cpu_to_be32(mvdev->res.null_mkey);
-			klm->bcount = cpu_to_be32(klm_bcount(dmr->start - preve));
-			preve = dmr->start;
+			klm->bcount = cpu_to_be32(klm_bcount(bcount));
+			preve += bcount;
+
 			goto again;
 		}
 	}
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 92fb6b7e1f68..a6225f962190 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -2749,9 +2749,13 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool mem_to_mem)
 {
 	int r;
-	enum omap_overlay_caps caps = dss_feat_get_overlay_caps(plane);
+	enum omap_overlay_caps caps;
 	enum omap_channel channel;
 
+	if (plane == OMAP_DSS_WB)
+		return -EINVAL;
+
+	caps = dss_feat_get_overlay_caps(plane);
 	channel = dispc_ovl_get_channel_out(plane);
 
 	DSSDBG("dispc_ovl_setup %d, pa %pad, pa_uv %pad, sw %d, %d,%d, %dx%d ->"
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index fe52c8cbf136..0893c1012de6 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -112,7 +112,7 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 }
 
 #ifdef CONFIG_X86
-int __init xen_swiotlb_fixup(void *buf, unsigned long nslabs)
+int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
 {
 	int rc;
 	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
diff --git a/drivers/xen/xenfs/xensyms.c b/drivers/xen/xenfs/xensyms.c
index c6c73a33c44d..18bc11756ad3 100644
--- a/drivers/xen/xenfs/xensyms.c
+++ b/drivers/xen/xenfs/xensyms.c
@@ -48,7 +48,7 @@ static int xensyms_next_sym(struct xensyms *xs)
 			return -ENOMEM;
 
 		set_xen_guest_handle(symdata->name, xs->name);
-		symdata->symnum--; /* Rewind */
+		symdata->symnum = symnum; /* Rewind */
 
 		ret = HYPERVISOR_platform_op(&xs->op);
 		if (ret < 0)
@@ -78,7 +78,7 @@ static void *xensyms_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	struct xensyms *xs = (struct xensyms *)m->private;
 
-	xs->op.u.symdata.symnum = ++(*pos);
+	*pos = xs->op.u.symdata.symnum;
 
 	if (xensyms_next_sym(xs))
 		return NULL;
diff --git a/fs/Kconfig b/fs/Kconfig
index 703a1cea0fc0..7104e3eb38eb 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -347,6 +347,7 @@ config GRACE_PERIOD
 config LOCKD
 	tristate
 	depends on FILE_LOCKING
+	select CRC32
 	select GRACE_PERIOD
 
 config LOCKD_V4
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 30fe5ebc3650..de4f590fe30f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4661,6 +4661,18 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	btrfs_flush_workqueue(fs_info->delalloc_workers);
 
+	/*
+	 * When finishing a compressed write bio we schedule a work queue item
+	 * to finish an ordered extent - btrfs_finish_compressed_write_work()
+	 * calls btrfs_finish_ordered_extent() which in turns does a call to
+	 * btrfs_queue_ordered_fn(), and that queues the ordered extent
+	 * completion either in the endio_write_workers work queue or in the
+	 * fs_info->endio_freespace_worker work queue. We flush those queues
+	 * below, so before we flush them we must flush this queue for the
+	 * workers of compressed writes.
+	 */
+	flush_workqueue(fs_info->compressed_write_workers);
+
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
 	 * completed and created new delayed iputs. If one of the async reclaim
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a13ab3abef12..2195e07803b8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1428,6 +1428,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					     locked_page,
 					     clear_bits,
 					     page_ops);
+		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
 		start += cur_alloc_size;
 	}
 
@@ -1441,6 +1442,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
 		extent_clear_unlock_delalloc(inode, start, end, locked_page,
 					     clear_bits, page_ops);
+		btrfs_qgroup_free_data(inode, NULL, start, end - start + 1, NULL);
 	}
 	return ret;
 }
@@ -2168,13 +2170,15 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	if (nocow)
 		btrfs_dec_nocow_writers(bg);
 
-	if (ret && cur_offset < end)
+	if (ret && cur_offset < end) {
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC | EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
 					     PAGE_END_WRITEBACK);
+		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
+	}
 	btrfs_free_path(path);
 	return ret;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c0ff0c2fc01d..91b19d66449b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1640,8 +1640,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
 			BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	if (!IS_ERR(subvol_name)) {
-		seq_puts(seq, ",subvol=");
-		seq_escape(seq, subvol_name, " \t\n\\");
+		seq_show_option(seq, "subvol", subvol_name);
 		kfree(subvol_name);
 	}
 	return 0;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 794526ab90d2..1dff64e62047 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1909,6 +1909,9 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
 
+		if (!device->bdev)
+			continue;
+
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 
@@ -2052,6 +2055,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		struct btrfs_device *device = map->stripes[i].dev;
 		const u64 physical = map->stripes[i].physical;
 
+		if (!device->bdev)
+			continue;
+
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 694af768ac5b..f460150ec73e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4776,22 +4776,43 @@ static inline void ext4_inode_set_iversion_queried(struct inode *inode, u64 val)
 		inode_set_iversion_queried(inode, val);
 }
 
-static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
-
+static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
+			    const char *function, unsigned int line)
 {
+	const char *err_str;
+
 	if (flags & EXT4_IGET_EA_INODE) {
-		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-			return "missing EA_INODE flag";
+		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+			err_str = "missing EA_INODE flag";
+			goto error;
+		}
 		if (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
-		    EXT4_I(inode)->i_file_acl)
-			return "ea_inode with extended attributes";
+		    EXT4_I(inode)->i_file_acl) {
+			err_str = "ea_inode with extended attributes";
+			goto error;
+		}
 	} else {
-		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-			return "unexpected EA_INODE flag";
+		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+			/*
+			 * open_by_handle_at() could provide an old inode number
+			 * that has since been reused for an ea_inode; this does
+			 * not indicate filesystem corruption
+			 */
+			if (flags & EXT4_IGET_HANDLE)
+				return -ESTALE;
+			err_str = "unexpected EA_INODE flag";
+			goto error;
+		}
+	}
+	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
+		err_str = "unexpected bad inode w/o EXT4_IGET_BAD";
+		goto error;
 	}
-	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD))
-		return "unexpected bad inode w/o EXT4_IGET_BAD";
-	return NULL;
+	return 0;
+
+error:
+	ext4_error_inode(inode, function, line, 0, err_str);
+	return -EFSCORRUPTED;
 }
 
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
@@ -4803,7 +4824,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_inode_info *ei;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct inode *inode;
-	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4832,10 +4852,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW)) {
-		if ((err_str = check_igot_inode(inode, flags)) != NULL) {
-			ext4_error_inode(inode, function, line, 0, err_str);
+		ret = check_igot_inode(inode, flags, function, line);
+		if (ret) {
 			iput(inode);
-			return ERR_PTR(-EFSCORRUPTED);
+			return ERR_PTR(ret);
 		}
 		return inode;
 	}
@@ -5107,13 +5127,21 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
-	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
-		ext4_error_inode(inode, function, line, 0, err_str);
-		ret = -EFSCORRUPTED;
-		goto bad_inode;
+	ret = check_igot_inode(inode, flags, function, line);
+	/*
+	 * -ESTALE here means there is nothing inherently wrong with the inode,
+	 * it's just not an inode we can return for an fhandle lookup.
+	 */
+	if (ret == -ESTALE) {
+		brelse(iloc.bh);
+		unlock_new_inode(inode);
+		iput(inode);
+		return ERR_PTR(-ESTALE);
 	}
-
+	if (ret)
+		goto bad_inode;
 	brelse(iloc.bh);
+
 	unlock_new_inode(inode);
 	return inode;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index b6a8b6c851cc..b8683c5acffe 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2041,7 +2041,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	 * split it in half by count; each resulting block will have at least
 	 * half the space free.
 	 */
-	if (i > 0)
+	if (i >= 0)
 		split = count - move;
 	else
 		split = count/2;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 1568baedab07..7f0231b34905 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6810,12 +6810,25 @@ static int ext4_release_dquot(struct dquot *dquot)
 {
 	int ret, err;
 	handle_t *handle;
+	bool freeze_protected = false;
+
+	/*
+	 * Trying to sb_start_intwrite() in a running transaction
+	 * can result in a deadlock. Further, running transactions
+	 * are already protected from freezing.
+	 */
+	if (!ext4_journal_current_handle()) {
+		sb_start_intwrite(dquot->dq_sb);
+		freeze_protected = true;
+	}
 
 	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
 				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
 	if (IS_ERR(handle)) {
 		/* Release dquot anyway to avoid endless cycle in dqput() */
 		dquot_release(dquot);
+		if (freeze_protected)
+			sb_end_intwrite(dquot->dq_sb);
 		return PTR_ERR(handle);
 	}
 	ret = dquot_release(dquot);
@@ -6826,6 +6839,10 @@ static int ext4_release_dquot(struct dquot *dquot)
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
+
+	if (freeze_protected)
+		sb_end_intwrite(dquot->dq_sb);
+
 	return ret;
 }
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5598aec75775..95dbc7c9843b 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1127,15 +1127,24 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 {
 	struct inode *ea_inode;
 	struct ext4_xattr_entry *entry;
+	struct ext4_iloc iloc;
 	bool dirty = false;
 	unsigned int ea_ino;
 	int err;
 	int credits;
+	void *end;
+
+	if (block_csum)
+		end = (void *)bh->b_data + bh->b_size;
+	else {
+		ext4_get_inode_loc(parent, &iloc);
+		end = (void *)ext4_raw_inode(&iloc) + EXT4_SB(parent->i_sb)->s_inode_size;
+	}
 
 	/* One credit for dec ref on ea_inode, one for orphan list addition, */
 	credits = 2 + extra_credits;
 
-	for (entry = first; !IS_LAST_ENTRY(entry);
+	for (entry = first; (void *)entry < end && !IS_LAST_ENTRY(entry);
 	     entry = EXT4_XATTR_NEXT(entry)) {
 		if (!entry->e_value_inum)
 			continue;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0f350368dea7..b8296b0414fc 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -695,8 +695,12 @@ void f2fs_update_inode_page(struct inode *inode)
 		if (err == -ENOENT)
 			return;
 
+		if (err == -EFSCORRUPTED)
+			goto stop_checkpoint;
+
 		if (err == -ENOMEM || ++count <= DEFAULT_RETRY_IO_COUNT)
 			goto retry;
+stop_checkpoint:
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_UPDATE_INODE);
 		return;
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 745ecf5523c9..ccc72781e0c6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1112,7 +1112,14 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	trace_f2fs_truncate_inode_blocks_enter(inode, from);
 
 	level = get_node_path(inode, from, offset, noffset);
-	if (level < 0) {
+	if (level <= 0) {
+		if (!level) {
+			level = -EFSCORRUPTED;
+			f2fs_err(sbi, "%s: inode ino=%lx has corrupted node block, from:%lu addrs:%u",
+					__func__, inode->i_ino,
+					from, ADDRS_PER_INODE(inode));
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+		}
 		trace_f2fs_truncate_inode_blocks_exit(inode, level);
 		return level;
 	}
diff --git a/fs/file.c b/fs/file.c
index bc0c087b31bb..2eccbb5dcd86 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -362,17 +362,25 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
 
+	/*
+	 * We may be racing against fd allocation from other threads using this
+	 * files_struct, despite holding ->file_lock.
+	 *
+	 * alloc_fd() might have already claimed a slot, while fd_install()
+	 * did not populate it yet. Note the latter operates locklessly, so
+	 * the file can show up as we are walking the array below.
+	 *
+	 * At the same time we know no files will disappear as all other
+	 * operations take the lock.
+	 *
+	 * Instead of trying to placate userspace racing with itself, we
+	 * ref the file if we see it and mark the fd slot as unused otherwise.
+	 */
 	for (i = open_files; i != 0; i--) {
-		struct file *f = *old_fds++;
+		struct file *f = rcu_dereference_raw(*old_fds++);
 		if (f) {
 			get_file(f);
 		} else {
-			/*
-			 * The fd may be claimed in the fd bitmap but not yet
-			 * instantiated in the files array if a sibling thread
-			 * is partway through open().  So make sure that this
-			 * fd is available to the new process.
-			 */
 			__clear_open_fd(open_files - i, new_fdt);
 		}
 		rcu_assign_pointer(*new_fds++, f);
@@ -625,7 +633,7 @@ static struct file *pick_file(struct files_struct *files, unsigned fd)
 		return NULL;
 
 	fd = array_index_nospec(fd, fdt->max_fds);
-	file = fdt->fd[fd];
+	file = rcu_dereference_raw(fdt->fd[fd]);
 	if (file) {
 		rcu_assign_pointer(fdt->fd[fd], NULL);
 		__put_unused_fd(files, fd);
@@ -1093,7 +1101,7 @@ __releases(&files->file_lock)
 	 */
 	fdt = files_fdtable(files);
 	fd = array_index_nospec(fd, fdt->max_fds);
-	tofree = fdt->fd[fd];
+	tofree = rcu_dereference_raw(fdt->fd[fd]);
 	if (!tofree && fd_is_open(fd, fdt))
 		goto Ebusy;
 	get_file(file);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 92d41269f1d3..9e4f2ba0ef9d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1429,6 +1429,9 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	unsigned int virtqueue_size;
 	int err = -EIO;
 
+	if (!fsc->source)
+		return invalf(fsc, "No source specified");
+
 	/* This gets a reference on virtio_fs object. This ptr gets installed
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
 	 * to drop the reference to this object.
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 6add6ebfef89..cb823a8a6ba9 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
 	else
 		key_len = tree->max_key_len + 1;
 
+	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
+		memset(key, 0, sizeof(hfs_btree_key));
+		pr_err("hfs: Invalid key length: %d\n", key_len);
+		return;
+	}
+
 	hfs_bnode_read(node, key, off, key_len);
 }
 
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 87974d5e6791..079ea80534f7 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
 	else
 		key_len = tree->max_key_len + 2;
 
+	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
+		memset(key, 0, sizeof(hfsplus_btree_key));
+		pr_err("hfsplus: Invalid key length: %d\n", key_len);
+		return;
+	}
+
 	hfs_bnode_read(node, key, off, key_len);
 }
 
diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 35768a63fb1d..421d247fae52 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -180,7 +180,7 @@ static struct dentry *isofs_fh_to_parent(struct super_block *sb,
 		return NULL;
 
 	return isofs_export_iget(sb,
-			fh_len > 2 ? ifid->parent_block : 0,
+			fh_len > 3 ? ifid->parent_block : 0,
 			ifid->parent_offset,
 			fh_len > 4 ? ifid->parent_generation : 0);
 }
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 55ada2b88146..41ab2dfd1ac2 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1711,7 +1711,6 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 
 	/* Log is no longer empty */
 	write_lock(&journal->j_state_lock);
-	WARN_ON(!sb->s_sequence);
 	journal->j_flags &= ~JBD2_FLUSHED;
 	write_unlock(&journal->j_state_lock);
 
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 6509102e581a..5e32526174e8 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -204,6 +204,10 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
+	if (!bmp->db_agwidth) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
 	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
@@ -3403,7 +3407,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 	oldl2agsize = bmp->db_agl2size;
 
 	bmp->db_agl2size = l2agsize;
-	bmp->db_agsize = 1 << l2agsize;
+	bmp->db_agsize = (s64)1 << l2agsize;
 
 	/* compute new number of AG */
 	agno = bmp->db_numag;
@@ -3666,8 +3670,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
 	 * system size is not a multiple of the group size).
 	 */
 	inactfree = (inactags && ag_rem) ?
-	    ((inactags - 1) << bmp->db_agl2size) + ag_rem
-	    : inactags << bmp->db_agl2size;
+	    (((s64)inactags - 1) << bmp->db_agl2size) + ag_rem
+	    : ((s64)inactags << bmp->db_agl2size);
 
 	/* determine how many free blocks are in the active
 	 * allocation groups plus the average number of free blocks
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index c72e97f06579..155f66812934 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -102,7 +102,7 @@ int diMount(struct inode *ipimap)
 	 * allocate/initialize the in-memory inode map control structure
 	 */
 	/* allocate the in-memory inode map control structure. */
-	imap = kmalloc(sizeof(struct inomap), GFP_KERNEL);
+	imap = kzalloc(sizeof(struct inomap), GFP_KERNEL);
 	if (imap == NULL)
 		return -ENOMEM;
 
@@ -456,7 +456,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
 	dp += inum % 8;		/* 8 inodes per 4K page */
 
 	/* copy on-disk inode to in-memory inode */
-	if ((copy_from_dinode(dp, ip)) != 0) {
+	if ((copy_from_dinode(dp, ip) != 0) || (ip->i_nlink == 0)) {
 		/* handle bad return by returning NULL for ip */
 		set_nlink(ip, 1);	/* Don't want iput() deleting it */
 		iput(ip);
diff --git a/fs/namespace.c b/fs/namespace.c
index 59a9f877738b..57166cc7e511 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1777,6 +1777,7 @@ static void warn_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -1786,7 +1787,7 @@ static int can_umount(const struct path *path, int flags)
 		return -EINVAL;
 	if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
 		return -EINVAL;
-	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
+	if (flags & MNT_FORCE && !ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 14a72224b657..899e25e9b4eb 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -2,6 +2,7 @@
 config NFS_FS
 	tristate "NFS client support"
 	depends on INET && FILE_LOCKING && MULTIUSER
+	select CRC32
 	select LOCKD
 	select SUNRPC
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
@@ -194,7 +195,6 @@ config NFS_USE_KERNEL_DNS
 config NFS_DEBUG
 	bool
 	depends on NFS_FS && SUNRPC_DEBUG
-	select CRC32
 	default y
 
 config NFS_DISABLE_UDP_SUPPORT
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 7fa23a6368e0..ece517ebcca0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -826,33 +826,11 @@ u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
 	return ((u64)ts->tv_sec << 30) + ts->tv_nsec;
 }
 
-#ifdef CONFIG_CRC32
-/**
- * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
- * @fh - pointer to filehandle
- *
- * returns a crc32 hash for the filehandle that is compatible with
- * the one displayed by "wireshark".
- */
-static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
-{
-	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
-}
 static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
 {
 	return ~crc32_le(0xFFFFFFFF, &stateid->other[0],
 				NFS4_STATEID_OTHER_SIZE);
 }
-#else
-static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
-{
-	return 0;
-}
-static inline u32 nfs_stateid_hash(nfs4_stateid *stateid)
-{
-	return 0;
-}
-#endif
 
 static inline bool nfs_error_is_fatal(int err)
 {
diff --git a/fs/nfs/nfs4session.h b/fs/nfs/nfs4session.h
index 351616c61df5..f9c291e2165c 100644
--- a/fs/nfs/nfs4session.h
+++ b/fs/nfs/nfs4session.h
@@ -148,16 +148,12 @@ static inline void nfs4_copy_sessionid(struct nfs4_sessionid *dst,
 	memcpy(dst->data, src->data, NFS4_MAX_SESSIONID_LEN);
 }
 
-#ifdef CONFIG_CRC32
 /*
  * nfs_session_id_hash - calculate the crc32 hash for the session id
  * @session - pointer to session
  */
 #define nfs_session_id_hash(sess_id) \
 	(~crc32_le(0xFFFFFFFF, &(sess_id)->data[0], sizeof((sess_id)->data)))
-#else
-#define nfs_session_id_hash(session) (0)
-#endif
 #else /* defined(CONFIG_NFS_V4_1) */
 
 static inline int nfs4_init_session(struct nfs_client *clp)
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 7c441f2bd444..4f704f868d9c 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -4,6 +4,7 @@ config NFSD
 	depends on INET
 	depends on FILE_LOCKING
 	depends on FSNOTIFY
+	select CRC32
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 628d20574a91..bdee95d714d0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4941,7 +4941,7 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	queued = nfsd4_run_cb(&dp->dl_recall);
 	WARN_ON_ONCE(!queued);
 	if (!queued)
-		nfs4_put_stid(&dp->dl_stid);
+		refcount_dec(&dp->dl_stid.sc_count);
 }
 
 /* Called from break_lease() with flc_lock held. */
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 513e028b0bbe..40aee06ebd95 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -263,7 +263,6 @@ static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
 	return true;
 }
 
-#ifdef CONFIG_CRC32
 /**
  * knfsd_fh_hash - calculate the crc32 hash for the filehandle
  * @fh - pointer to filehandle
@@ -275,12 +274,6 @@ static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 {
 	return ~crc32_le(0xFFFFFFFF, fh->fh_raw, fh->fh_size);
 }
-#else
-static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
-{
-	return 0;
-}
-#endif
 
 /**
  * fh_clear_pre_post_attrs - Reset pre/post attributes
diff --git a/fs/smb/client/cifs_dfs_ref.c b/fs/smb/client/cifs_dfs_ref.c
index 020e71fe1454..876f9a43a99d 100644
--- a/fs/smb/client/cifs_dfs_ref.c
+++ b/fs/smb/client/cifs_dfs_ref.c
@@ -258,6 +258,31 @@ char *cifs_compose_mount_options(const char *sb_mountdata,
 	goto compose_mount_options_out;
 }
 
+static int set_dest_addr(struct smb3_fs_context *ctx, const char *full_path)
+{
+	struct sockaddr *addr = (struct sockaddr *)&ctx->dstaddr;
+	char *str_addr = NULL;
+	int rc;
+
+	rc = dns_resolve_server_name_to_ip(full_path, &str_addr, NULL);
+	if (rc < 0)
+		goto out;
+
+	rc = cifs_convert_address(addr, str_addr, strlen(str_addr));
+	if (!rc) {
+		cifs_dbg(FYI, "%s: failed to convert ip address\n", __func__);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	cifs_set_port(addr, ctx->port);
+	rc = 0;
+
+out:
+	kfree(str_addr);
+	return rc;
+}
+
 /*
  * Create a vfsmount that we can automount
  */
@@ -295,8 +320,7 @@ static struct vfsmount *cifs_dfs_do_automount(struct path *path)
 	ctx = smb3_fc2context(fc);
 
 	page = alloc_dentry_path();
-	/* always use tree name prefix */
-	full_path = build_path_from_dentry_optional_prefix(mntpt, page, true);
+	full_path = dfs_get_automount_devname(mntpt, page);
 	if (IS_ERR(full_path)) {
 		mnt = ERR_CAST(full_path);
 		goto out;
@@ -315,6 +339,12 @@ static struct vfsmount *cifs_dfs_do_automount(struct path *path)
 		goto out;
 	}
 
+	rc = set_dest_addr(ctx, full_path);
+	if (rc) {
+		mnt = ERR_PTR(rc);
+		goto out;
+	}
+
 	rc = smb3_parse_devname(full_path, ctx);
 	if (!rc)
 		mnt = fc_mount(fc);
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index f37e4da0fe40..d1fd54fb3cc1 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -57,8 +57,29 @@ extern void exit_cifs_idmap(void);
 extern int init_cifs_spnego(void);
 extern void exit_cifs_spnego(void);
 extern const char *build_path_from_dentry(struct dentry *, void *);
+char *__build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
+					       const char *tree, int tree_len,
+					       bool prefix);
 extern char *build_path_from_dentry_optional_prefix(struct dentry *direntry,
 						    void *page, bool prefix);
+
+#ifdef CONFIG_CIFS_DFS_UPCALL
+static inline char *dfs_get_automount_devname(struct dentry *dentry, void *page)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+	struct TCP_Server_Info *server = tcon->ses->server;
+
+	if (unlikely(!server->origin_fullpath))
+		return ERR_PTR(-EREMOTE);
+
+	return __build_path_from_dentry_optional_prefix(dentry, page,
+							server->origin_fullpath,
+							strlen(server->origin_fullpath),
+							true);
+}
+#endif
+
 static inline void *alloc_dentry_path(void)
 {
 	return __getname();
@@ -152,6 +173,8 @@ extern int cifs_get_writable_path(struct cifs_tcon *tcon, const char *name,
 extern struct cifsFileInfo *find_readable_file(struct cifsInodeInfo *, bool);
 extern int cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
 				  struct cifsFileInfo **ret_file);
+extern int cifs_get_hardlink_path(struct cifs_tcon *tcon, struct inode *inode,
+				  struct file *file);
 extern unsigned int smbCalcSize(void *buf);
 extern int decode_negTokenInit(unsigned char *security_blob, int length,
 			struct TCP_Server_Info *server);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 01ce81f77e89..6aeb25006db8 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2417,6 +2417,8 @@ static int match_tcon(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 		return 0;
 	if (tcon->nodelete != ctx->nodelete)
 		return 0;
+	if (tcon->posix_extensions != ctx->linux_ext)
+		return 0;
 	return 1;
 }
 
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 863c7bc3db86..477302157ab3 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -78,14 +78,13 @@ build_path_from_dentry(struct dentry *direntry, void *page)
 						      prefix);
 }
 
-char *
-build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
-				       bool prefix)
+char *__build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
+					       const char *tree, int tree_len,
+					       bool prefix)
 {
 	int dfsplen;
 	int pplen = 0;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(direntry->d_sb);
-	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 	char dirsep = CIFS_DIR_SEP(cifs_sb);
 	char *s;
 
@@ -93,7 +92,7 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
 		return ERR_PTR(-ENOMEM);
 
 	if (prefix)
-		dfsplen = strnlen(tcon->tree_name, MAX_TREE_SIZE + 1);
+		dfsplen = strnlen(tree, tree_len + 1);
 	else
 		dfsplen = 0;
 
@@ -123,7 +122,7 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
 	}
 	if (dfsplen) {
 		s -= dfsplen;
-		memcpy(s, tcon->tree_name, dfsplen);
+		memcpy(s, tree, dfsplen);
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) {
 			int i;
 			for (i = 0; i < dfsplen; i++) {
@@ -135,6 +134,16 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
 	return s;
 }
 
+char *build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
+					     bool prefix)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(direntry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+
+	return __build_path_from_dentry_optional_prefix(direntry, page, tcon->tree_name,
+							MAX_TREE_SIZE, prefix);
+}
+
 /*
  * Don't allow path components longer than the server max.
  * Don't allow the separator character in a path component.
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index d23dfc83de50..9b0919d9e337 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -687,6 +687,11 @@ int cifs_open(struct inode *inode, struct file *file)
 		} else {
 			_cifsFileInfo_put(cfile, true, false);
 		}
+	} else {
+		/* hard link on the defeered close file */
+		rc = cifs_get_hardlink_path(tcon, inode, file);
+		if (rc)
+			cifs_close_deferred_file(CIFS_I(inode));
 	}
 
 	if (server->oplocks)
@@ -1735,6 +1740,29 @@ cifs_move_llist(struct list_head *source, struct list_head *dest)
 		list_move(li, dest);
 }
 
+int
+cifs_get_hardlink_path(struct cifs_tcon *tcon, struct inode *inode,
+				struct file *file)
+{
+	struct cifsFileInfo *open_file = NULL;
+	struct cifsInodeInfo *cinode = CIFS_I(inode);
+	int rc = 0;
+
+	spin_lock(&tcon->open_file_lock);
+	spin_lock(&cinode->open_file_lock);
+
+	list_for_each_entry(open_file, &cinode->openFileList, flist) {
+		if (file->f_flags == open_file->f_flags) {
+			rc = -EINVAL;
+			break;
+		}
+	}
+
+	spin_unlock(&cinode->open_file_lock);
+	spin_unlock(&tcon->open_file_lock);
+	return rc;
+}
+
 void
 cifs_free_llist(struct list_head *llist)
 {
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index de2366d05767..e6d2e4162b08 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1111,6 +1111,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		ctx->closetimeo = HZ * result.uint_32;
 		break;
 	case Opt_echo_interval:
+		if (result.uint_32 < SMB_ECHO_INTERVAL_MIN ||
+		    result.uint_32 > SMB_ECHO_INTERVAL_MAX) {
+			cifs_errorf(fc, "echo interval is out of bounds\n");
+			goto cifs_parse_mount_err;
+		}
 		ctx->echo_interval = result.uint_32;
 		break;
 	case Opt_snapshot:
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 8c149cb531d3..01352d7c10f1 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -814,11 +814,12 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 		WARN_ONCE(tcon->tc_count < 0, "tcon refcount is negative");
 		spin_unlock(&cifs_tcp_ses_lock);
 
-		if (tcon->ses)
+		if (tcon->ses) {
 			server = tcon->ses->server;
-
-		cifs_server_dbg(FYI, "tid=0x%x: tcon is closing, skipping async close retry of fid %llu %llu\n",
-				tcon->tid, persistent_fid, volatile_fid);
+			cifs_server_dbg(FYI,
+					"tid=0x%x: tcon is closing, skipping async close retry of fid %llu %llu\n",
+					tcon->tid, persistent_fid, volatile_fid);
+		}
 
 		return 0;
 	}
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index a3c016a11e27..2fcfabc35b06 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1515,7 +1515,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
  * @open_req:	buffer containing smb2 file open(create) request
  * @is_dir:	whether leasing file is directory
  *
- * Return:  oplock state, -ENOENT if create lease context not found
+ * Return: allocated lease context object on success, otherwise NULL
  */
 struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
 {
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index dbe272970c25..8c9857b36add 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1615,8 +1615,10 @@ static int krb5_authenticate(struct ksmbd_work *work,
 	if (prev_sess_id && prev_sess_id != sess->id)
 		destroy_previous_session(conn, sess->user, prev_sess_id);
 
-	if (sess->state == SMB2_SESSION_VALID)
+	if (sess->state == SMB2_SESSION_VALID) {
 		ksmbd_free_user(sess->user);
+		sess->user = NULL;
+	}
 
 	retval = ksmbd_krb5_authenticate(sess, in_blob, in_len,
 					 out_blob, &out_len);
@@ -3241,7 +3243,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out1;
 		}
 	} else {
-		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
+		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE && lc) {
 			/*
 			 * Compare parent lease using parent key. If there is no
 			 * a lease that has same parent key, Send lease break
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index d1a432af43fb..7fc4b33b89e3 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -296,7 +296,11 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	server_conf.signing = req->signing;
 	server_conf.tcp_port = req->tcp_port;
 	server_conf.ipc_timeout = req->ipc_timeout * HZ;
-	server_conf.deadtime = req->deadtime * SMB_ECHO_INTERVAL;
+	if (check_mul_overflow(req->deadtime, SMB_ECHO_INTERVAL,
+					&server_conf.deadtime)) {
+		ret = -EINVAL;
+		goto out;
+	}
 	server_conf.share_fake_fscaps = req->share_fake_fscaps;
 	ksmbd_init_domain(req->sub_auth);
 
@@ -319,6 +323,7 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	ret |= ksmbd_set_work_group(req->work_group);
 	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
 					req->ifc_list_sz);
+out:
 	if (ret) {
 		pr_err("Server configuration error: %s %s %s\n",
 		       req->netbios_name, req->server_string,
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 396d4ea77d34..25e8004a5905 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -493,7 +493,8 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 	int err = 0;
 
 	if (work->conn->connection_type) {
-		if (!(fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
+		if (!(fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE)) ||
+		    S_ISDIR(file_inode(fp->filp)->i_mode)) {
 			pr_err("no right to write(%pD)\n", fp->filp);
 			err = -EACCES;
 			goto out;
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 439815cc1ab9..c451adbe82f0 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -241,6 +241,7 @@ static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
 	WARN_ON_ONCE(debug_locks &&
+		     (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
 		     (!lockdep_is_held(&inode->i_lock) &&
 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
 		      !lockdep_is_held(&inode->i_wb->list_lock)));
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2189c0d18fa7..e9c1338851e3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -250,6 +250,7 @@ struct bpf_map {
 	 * same prog type, JITed flag and xdp_has_frags flag.
 	 */
 	struct {
+		const struct btf_type *attach_func_proto;
 		spinlock_t lock;
 		enum bpf_prog_type type;
 		bool jited;
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index b06375e88e58..095a95c1fae8 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -10,6 +10,7 @@
 
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/string.h>
+#include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
 /*
@@ -44,4 +45,16 @@ enum nfs3_stable_how {
 	/* used by direct.c to mark verf as invalid */
 	NFS_INVALID_STABLE_HOW = -1
 };
+
+/**
+ * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
+ * @fh - pointer to filehandle
+ *
+ * returns a crc32 hash for the filehandle that is compatible with
+ * the one displayed by "wireshark".
+ */
+static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
+{
+	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
+}
 #endif /* _LINUX_NFS_H */
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index ae2c6a3cec5d..f532d1eda761 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -138,4 +138,26 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 extern void rtnl_offload_xstats_notify(struct net_device *dev);
 
+static inline int rtnl_has_listeners(const struct net *net, u32 group)
+{
+	struct sock *rtnl = net->rtnl;
+
+	return netlink_has_listeners(rtnl, group);
+}
+
+/**
+ * rtnl_notify_needed - check if notification is needed
+ * @net: Pointer to the net namespace
+ * @nlflags: netlink ingress message flags
+ * @group: rtnl group
+ *
+ * Based on the ingress message flags and rtnl group, returns true
+ * if a notification is needed, false otherwise.
+ */
+static inline bool
+rtnl_notify_needed(const struct net *net, u16 nlflags, u32 group)
+{
+	return (nlflags & NLM_F_ECHO) || rtnl_has_listeners(net, group);
+}
+
 #endif	/* __LINUX_RTNETLINK_H */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index df5cd4245f29..dd0784a6e07d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -271,6 +271,7 @@ enum tpm2_cc_attrs {
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
 #define TPM_VID_ATML     0x1114
+#define TPM_VID_IFX      0x15D1
 
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 00ee9eb601a6..8995914916ca 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -777,6 +777,7 @@ struct sctp_transport {
 
 	/* Reference counting. */
 	refcount_t refcnt;
+	__u32	dead:1,
 		/* RTO-Pending : A flag used to track if one of the DATA
 		 *		chunks sent to this address is currently being
 		 *		used to compute a RTT. If this flag is 0,
@@ -786,7 +787,7 @@ struct sctp_transport {
 		 *		calculation completes (i.e. the DATA chunk
 		 *		is SACK'd) clear this flag.
 		 */
-	__u32	rto_pending:1,
+		rto_pending:1,
 
 		/*
 		 * hb_sent : a flag that signals that we have a pending
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 42b60198b6c5..deed930ed305 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -55,6 +55,8 @@ struct kfd_ioctl_get_version_args {
 #define KFD_MAX_QUEUE_PERCENTAGE	100
 #define KFD_MAX_QUEUE_PRIORITY		15
 
+#define KFD_MIN_QUEUE_RING_SIZE		1024
+
 struct kfd_ioctl_create_queue_args {
 	__u64 ring_base_address;	/* to KFD */
 	__u64 write_pointer_address;	/* from KFD */
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 9c4bcc37a455..17bdfaa9eb87 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -38,9 +38,11 @@ struct landlock_ruleset_attr {
  *
  * - %LANDLOCK_CREATE_RULESET_VERSION: Get the highest supported Landlock ABI
  *   version.
+ * - %LANDLOCK_CREATE_RULESET_ERRATA: Get a bitmask of fixed issues.
  */
 /* clang-format off */
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
+#define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/include/xen/interface/xen-mca.h b/include/xen/interface/xen-mca.h
index 464aa6b3a5f9..1c9afbe8cc26 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -372,7 +372,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 55902303d7dc..147ada2ce747 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -336,6 +336,8 @@ int io_provide_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 	p->nbufs = tmp;
 	p->addr = READ_ONCE(sqe->addr);
 	p->len = READ_ONCE(sqe->len);
+	if (!p->len)
+		return -EINVAL;
 
 	if (check_mul_overflow((unsigned long)p->len, (unsigned long)p->nbufs,
 				&size))
diff --git a/io_uring/net.c b/io_uring/net.c
index d56e8a47e50f..898990e71367 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1391,6 +1391,8 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 		goto retry;
 
 	io_req_set_res(req, ret, 0);
+	if (!(issue_flags & IO_URING_F_MULTISHOT))
+		return IOU_OK;
 	return IOU_STOP_MULTISHOT;
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 83b416af4da1..c281f5b8705e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2121,6 +2121,7 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	bool ret;
+	struct bpf_prog_aux *aux = fp->aux;
 
 	if (fp->kprobe_override)
 		return false;
@@ -2132,12 +2133,26 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 		 */
 		map->owner.type  = prog_type;
 		map->owner.jited = fp->jited;
-		map->owner.xdp_has_frags = fp->aux->xdp_has_frags;
+		map->owner.xdp_has_frags = aux->xdp_has_frags;
+		map->owner.attach_func_proto = aux->attach_func_proto;
 		ret = true;
 	} else {
 		ret = map->owner.type  == prog_type &&
 		      map->owner.jited == fp->jited &&
-		      map->owner.xdp_has_frags == fp->aux->xdp_has_frags;
+		      map->owner.xdp_has_frags == aux->xdp_has_frags;
+		if (ret &&
+		    map->owner.attach_func_proto != aux->attach_func_proto) {
+			switch (prog_type) {
+			case BPF_PROG_TYPE_TRACING:
+			case BPF_PROG_TYPE_LSM:
+			case BPF_PROG_TYPE_EXT:
+			case BPF_PROG_TYPE_STRUCT_OPS:
+				ret = false;
+				break;
+			default:
+				break;
+			}
+		}
 	}
 	spin_unlock(&map->owner.lock);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7a4004f09bae..27fdf1b2fc46 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -813,7 +813,7 @@ static const struct vm_operations_struct bpf_map_default_vmops = {
 static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct bpf_map *map = filp->private_data;
-	int err;
+	int err = 0;
 
 	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
 	    map_value_has_timer(map) || map_value_has_kptrs(map))
@@ -838,7 +838,12 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 			err = -EACCES;
 			goto out;
 		}
+		bpf_map_write_active_inc(map);
 	}
+out:
+	mutex_unlock(&map->freeze_mutex);
+	if (err)
+		return err;
 
 	/* set default open/close callbacks */
 	vma->vm_ops = &bpf_map_default_vmops;
@@ -849,13 +854,11 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 		vma->vm_flags &= ~VM_MAYWRITE;
 
 	err = map->ops->map_mmap(map, vma);
-	if (err)
-		goto out;
+	if (err) {
+		if (vma->vm_flags & VM_WRITE)
+			bpf_map_write_active_dec(map);
+	}
 
-	if (vma->vm_flags & VM_MAYWRITE)
-		bpf_map_write_active_inc(map);
-out:
-	mutex_unlock(&map->freeze_mutex);
 	return err;
 }
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7fb9731bc5f5..5f8ce961cd9a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6021,6 +6021,9 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		hlist_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
 		WRITE_ONCE(class->name, NULL);
+		/* Class allocated but not used, -1 in nr_unused_locks */
+		if (class->usage_mask == 0)
+			debug_atomic_dec(nr_unused_locks);
 		nr_lock_classes--;
 		__clear_bit(class - lock_classes, lock_classes_in_use);
 		if (class - lock_classes == max_lock_class_idx)
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 542c0e82a900..4dcb48973318 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -84,7 +84,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 
 	if (unlikely(sg_policy->limits_changed)) {
 		sg_policy->limits_changed = false;
-		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+		sg_policy->need_freq_update = true;
 		return true;
 	}
 
@@ -96,10 +96,22 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (sg_policy->need_freq_update)
+	if (sg_policy->need_freq_update) {
 		sg_policy->need_freq_update = false;
-	else if (sg_policy->next_freq == next_freq)
+		/*
+		 * The policy limits have changed, but if the return value of
+		 * cpufreq_driver_resolve_freq() after applying the new limits
+		 * is still equal to the previously selected frequency, the
+		 * driver callback need not be invoked unless the driver
+		 * specifically wants that to happen on every update of the
+		 * policy limits.
+		 */
+		if (sg_policy->next_freq == next_freq &&
+		    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
+			return false;
+	} else if (sg_policy->next_freq == next_freq) {
 		return false;
+	}
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ce8a8eae7e83..bd19c83c0e5e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6522,6 +6522,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 				}
 			}
 		}
+		cond_resched();
 	} while_for_each_ftrace_rec();
 out:
 	mutex_unlock(&ftrace_lock);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 94bb5f9251b1..ed0d0c8a2b4b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -776,7 +776,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
-			call->class->reg(call, TRACE_REG_UNREGISTER, file);
+			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);
+
+			WARN_ON_ONCE(ret);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
 		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 86a0531efd43..23fbd1b10712 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -716,7 +716,7 @@ static __always_inline char *test_string(char *str)
 	kstr = ubuf->buffer;
 
 	/* For safety, do not trust the string pointer */
-	if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
+	if (strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE) < 0)
 		return NULL;
 	return kstr;
 }
@@ -735,7 +735,7 @@ static __always_inline char *test_ustring(char *str)
 
 	/* user space address? */
 	ustr = (char __user *)str;
-	if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
+	if (strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE) < 0)
 		return NULL;
 
 	return kstr;
diff --git a/lib/sg_split.c b/lib/sg_split.c
index 60a0babebf2e..0f89aab5c671 100644
--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -88,8 +88,6 @@ static void sg_split_phys(struct sg_splitter *splitters, const int nb_splits)
 			if (!j) {
 				out_sg->offset += split->skip_sg0;
 				out_sg->length -= split->skip_sg0;
-			} else {
-				out_sg->offset = 0;
 			}
 			sg_dma_address(out_sg) = 0;
 			sg_dma_len(out_sg) = 0;
diff --git a/lib/string.c b/lib/string.c
index 3371d26a0e39..c4b8349ff058 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -181,6 +181,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
 		return -E2BIG;
 
+#ifndef CONFIG_DCACHE_WORD_ACCESS
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	/*
 	 * If src is unaligned, don't cross a page boundary,
@@ -195,12 +196,14 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 	/* If src or dest is unaligned, don't do word-at-a-time. */
 	if (((long) dest | (long) src) & (sizeof(long) - 1))
 		max = 0;
+#endif
 #endif
 
 	/*
-	 * read_word_at_a_time() below may read uninitialized bytes after the
-	 * trailing zero and use them in comparisons. Disable this optimization
-	 * under KMSAN to prevent false positive reports.
+	 * load_unaligned_zeropad() or read_word_at_a_time() below may read
+	 * uninitialized bytes after the trailing zero and use them in
+	 * comparisons. Disable this optimization under KMSAN to prevent
+	 * false positive reports.
 	 */
 	if (IS_ENABLED(CONFIG_KMSAN))
 		max = 0;
@@ -208,7 +211,11 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, data;
 
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+		c = load_unaligned_zeropad(src+res);
+#else
 		c = read_word_at_a_time(src+res);
+#endif
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
diff --git a/mm/filemap.c b/mm/filemap.c
index 78bf403473fb..6649a853dc5f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2266,6 +2266,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 			*start = folio->index + nr;
 			goto out;
 		}
+		xas_advance(&xas, folio_next_index(folio) - 1);
 		continue;
 put_folio:
 		folio_put(folio);
diff --git a/mm/gup.c b/mm/gup.c
index b1daaa9d89aa..37c55e61460e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -232,7 +232,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
 		 * and it is used in a *lot* of places.
 		 */
 		if (is_zero_page(page))
-			return 0;
+			return true;
 
 		/*
 		 * Similar to try_grab_folio(): be sure to *also*
@@ -1881,8 +1881,8 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
 	} while (start != end);
 	mmap_read_unlock(mm);
 
-	if (size > (unsigned long)uaddr - start)
-		return size - ((unsigned long)uaddr - start);
+	if (size > start - (unsigned long)uaddr)
+		return size - (start - (unsigned long)uaddr);
 	return 0;
 }
 EXPORT_SYMBOL(fault_in_safe_writeable);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 56b2dcc2c0d6..9ca2b58aceec 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -764,12 +764,17 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 	mmap_read_lock(p->mm);
 	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwp_walk_ops,
 			      (void *)&priv);
+	/*
+	 * ret = 1 when CMCI wins, regardless of whether try_to_unmap()
+	 * succeeds or fails, then kill the process with SIGBUS.
+	 * ret = 0 when poison page is a clean page and it's dropped, no
+	 * SIGBUS is needed.
+	 */
 	if (ret == 1 && priv.tk.addr)
 		kill_proc(&priv.tk, pfn, flags);
-	else
-		ret = 0;
 	mmap_read_unlock(p->mm);
-	return ret > 0 ? -EHWPOISON : -EFAULT;
+
+	return ret > 0 ? -EHWPOISON : 0;
 }
 
 static const char *action_name[] = {
diff --git a/mm/memory.c b/mm/memory.c
index 2e776ea38348..454d918449b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2659,11 +2659,11 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	if (fn) {
 		do {
 			if (create || !pte_none(*pte)) {
-				err = fn(pte++, addr, data);
+				err = fn(pte, addr, data);
 				if (err)
 					break;
 			}
-		} while (addr += PAGE_SIZE, addr != end);
+		} while (pte++, addr += PAGE_SIZE, addr != end);
 	}
 	*mask |= PGTBL_PTE_MODIFIED;
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 7da2d8d097d9..7d7bacd37ff4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2306,7 +2306,7 @@ static bool folio_make_device_exclusive(struct folio *folio,
 	 * Restrict to anonymous folios for now to avoid potential writeback
 	 * issues.
 	 */
-	if (!folio_test_anon(folio))
+	if (!folio_test_anon(folio) || folio_test_hugetlb(folio))
 		return false;
 
 	rmap_walk(folio, &rwc);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index be863204d7c8..1f7a90ecc700 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7729,7 +7729,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 		return NODE_RECLAIM_NOSCAN;
 
 	ret = __node_reclaim(pgdat, gfp_mask, order);
-	clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
+	clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 
 	if (!ret)
 		count_vm_event(PGSCAN_ZONE_RECLAIM_FAILED);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index d3e511e1eba8..c08228d48834 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -272,17 +272,6 @@ static int vlan_dev_open(struct net_device *dev)
 			goto out;
 	}
 
-	if (dev->flags & IFF_ALLMULTI) {
-		err = dev_set_allmulti(real_dev, 1);
-		if (err < 0)
-			goto del_unicast;
-	}
-	if (dev->flags & IFF_PROMISC) {
-		err = dev_set_promiscuity(real_dev, 1);
-		if (err < 0)
-			goto clear_allmulti;
-	}
-
 	ether_addr_copy(vlan->real_dev_addr, real_dev->dev_addr);
 
 	if (vlan->flags & VLAN_FLAG_GVRP)
@@ -296,12 +285,6 @@ static int vlan_dev_open(struct net_device *dev)
 		netif_carrier_on(dev);
 	return 0;
 
-clear_allmulti:
-	if (dev->flags & IFF_ALLMULTI)
-		dev_set_allmulti(real_dev, -1);
-del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
 out:
 	netif_carrier_off(dev);
 	return err;
@@ -314,10 +297,6 @@ static int vlan_dev_stop(struct net_device *dev)
 
 	dev_mc_unsync(real_dev, dev);
 	dev_uc_unsync(real_dev, dev);
-	if (dev->flags & IFF_ALLMULTI)
-		dev_set_allmulti(real_dev, -1);
-	if (dev->flags & IFF_PROMISC)
-		dev_set_promiscuity(real_dev, -1);
 
 	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
 		dev_uc_del(real_dev, dev->dev_addr);
@@ -474,12 +453,10 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
 {
 	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
 
-	if (dev->flags & IFF_UP) {
-		if (change & IFF_ALLMULTI)
-			dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (change & IFF_PROMISC)
-			dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
-	}
+	if (change & IFF_ALLMULTI)
+		dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
+	if (change & IFF_PROMISC)
+		dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
 }
 
 static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6cfd61628cd7..8667723d4e96 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6248,11 +6248,12 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * event or send an immediate device found event if the data
 	 * should not be stored for later.
 	 */
-	if (!ext_adv &&	!has_pending_adv_report(hdev)) {
+	if (!has_pending_adv_report(hdev)) {
 		/* If the report will trigger a SCAN_REQ store it for
 		 * later merging.
 		 */
-		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND) {
+		if (!ext_adv && (type == LE_ADV_IND ||
+				 type == LE_ADV_SCAN_IND)) {
 			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
 						 rssi, flags, data, len);
 			return;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 21a79ef7092d..222105e24d2d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4186,7 +4186,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(L2CAP_PSM_SDP) &&
-	    !hci_conn_check_link_mode(conn->hcon)) {
+	    (!hci_conn_check_link_mode(conn->hcon) ||
+	    !l2cap_check_enc_key_size(conn->hcon))) {
 		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
 		result = L2CAP_CR_SEC_BLOCK;
 		goto response;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 9ffd40b8270c..23a82567fe62 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -715,8 +715,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 				u16 flags, bool *changed,
 				struct netlink_ext_ack *extack)
 {
-	bool would_change = __vlan_flags_would_change(vlan, flags);
 	bool becomes_brentry = false;
+	bool would_change = false;
 	int err;
 
 	if (!br_vlan_is_brentry(vlan)) {
@@ -725,6 +725,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 			return -EINVAL;
 
 		becomes_brentry = true;
+	} else {
+		would_change = __vlan_flags_would_change(vlan, flags);
 	}
 
 	/* Master VLANs that aren't brentries weren't notified before,
diff --git a/net/core/filter.c b/net/core/filter.c
index 370f61f9bf4b..d713696d0832 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -212,24 +212,36 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
 	return 0;
 }
 
+static int bpf_skb_load_helper_convert_offset(const struct sk_buff *skb, int offset)
+{
+	if (likely(offset >= 0))
+		return offset;
+
+	if (offset >= SKF_NET_OFF)
+		return offset - SKF_NET_OFF + skb_network_offset(skb);
+
+	if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
+		return offset - SKF_LL_OFF + skb_mac_offset(skb);
+
+	return INT_MIN;
+}
+
 BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u8 tmp, *ptr;
+	u8 tmp;
 	const int len = sizeof(tmp);
 
-	if (offset >= 0) {
-		if (headlen - offset >= len)
-			return *(u8 *)(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return tmp;
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return *(u8 *)ptr;
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return *(u8 *)(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return tmp;
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
@@ -242,21 +254,19 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	__be16 tmp, *ptr;
+	__be16 tmp;
 	const int len = sizeof(tmp);
 
-	if (offset >= 0) {
-		if (headlen - offset >= len)
-			return get_unaligned_be16(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be16_to_cpu(tmp);
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be16(ptr);
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be16(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be16_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
@@ -269,21 +279,19 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	__be32 tmp, *ptr;
+	__be32 tmp;
 	const int len = sizeof(tmp);
 
-	if (likely(offset >= 0)) {
-		if (headlen - offset >= len)
-			return get_unaligned_be32(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be32_to_cpu(tmp);
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be32(ptr);
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be32(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be32_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, skb,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index caf6d950d54a..acc1d0d055cd 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -841,7 +841,13 @@ static void page_pool_release_retry(struct work_struct *wq)
 	int inflight;
 
 	inflight = page_pool_release(pool);
-	if (!inflight)
+	/* In rare cases, a driver bug may cause inflight to go negative.
+	 * Don't reschedule release if inflight is 0 or negative.
+	 * - If 0, the page_pool has been destroyed
+	 * - if negative, we will never recover
+	 * in both cases no reschedule is necessary.
+	 */
+	if (inflight <= 0)
 		return;
 
 	/* Periodic warning */
diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 89371b16416e..6a33f35a0f74 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -180,7 +180,7 @@ static int dsa_port_do_tag_8021q_vlan_del(struct dsa_port *dp, u16 vid)
 
 	err = ds->ops->tag_8021q_vlan_del(ds, port, vid);
 	if (err) {
-		refcount_inc(&v->refcount);
+		refcount_set(&v->refcount, 1);
 		return err;
 	}
 
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index e5efdf2817ef..98c064113882 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -384,7 +384,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	ret = ops->prepare_data(req_info, reply_data, info);
 	rtnl_unlock();
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_dev;
 	ret = ops->reply_size(req_info, reply_data);
 	if (ret < 0)
 		goto err_cleanup;
@@ -442,7 +442,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, NULL);
 	rtnl_unlock();
 	if (ret < 0)
-		goto out;
+		goto out_cancel;
 	ret = ethnl_fill_reply_header(skb, dev, ctx->ops->hdr_attr);
 	if (ret < 0)
 		goto out;
@@ -451,6 +451,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 out:
 	if (ctx->ops->cleanup_data)
 		ctx->ops->cleanup_data(ctx->reply_data);
+out_cancel:
 	ctx->reply_data->dev = NULL;
 	if (ret < 0)
 		genlmsg_cancel(skb, ehdr);
@@ -636,7 +637,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 	ethnl_init_reply_data(reply_data, ops, dev);
 	ret = ops->prepare_data(req_info, reply_data, NULL);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_rep;
 	ret = ops->reply_size(req_info, reply_data);
 	if (ret < 0)
 		goto err_cleanup;
@@ -671,6 +672,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 err_cleanup:
 	if (ops->cleanup_data)
 		ops->cleanup_data(reply_data);
+err_rep:
 	kfree(reply_data);
 	kfree(req_info);
 	return;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d6de164720a0..4e6b833dc40b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -474,10 +474,10 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		goto out;
 
 	hash = fl6->mp_hash;
-	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
-	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
-			    strict) >= 0) {
-		match = first;
+	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound)) {
+		if (rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
+				    strict) >= 0)
+			match = first;
 		goto out;
 	}
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 8861f63e2cfb..fc60e80088a3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -688,6 +688,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		ieee80211_txq_remove_vlan(local, sdata);
 
+	if (sdata->vif.txq)
+		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
+
 	sdata->bss = NULL;
 
 	if (local->open_count == 0)
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9b1ce7c3925a..47eb67dc11cf 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -365,6 +365,12 @@ u32 airtime_link_metric_get(struct ieee80211_local *local,
 	return (u32)result;
 }
 
+/* Check that the first metric is at least 10% better than the second one */
+static bool is_metric_better(u32 x, u32 y)
+{
+	return (x < y) && (x < (y - x / 10));
+}
+
 /**
  * hwmp_route_info_get - Update routing info to originator and transmitter
  *
@@ -455,8 +461,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 				    (mpath->sn == orig_sn &&
 				     (rcu_access_pointer(mpath->next_hop) !=
 						      sta ?
-					      mult_frac(new_metric, 10, 9) :
-					      new_metric) >= mpath->metric)) {
+					      !is_metric_better(new_metric, mpath->metric) :
+					      new_metric >= mpath->metric))) {
 					process = false;
 					fresh_info = false;
 				}
@@ -526,8 +532,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
 			if ((mpath->flags & MESH_PATH_FIXED) ||
 			    ((mpath->flags & MESH_PATH_ACTIVE) &&
 			     ((rcu_access_pointer(mpath->next_hop) != sta ?
-				       mult_frac(last_hop_metric, 10, 9) :
-				       last_hop_metric) > mpath->metric)))
+				      !is_metric_better(last_hop_metric, mpath->metric) :
+				       last_hop_metric > mpath->metric))))
 				fresh_info = false;
 		} else {
 			mpath = mesh_path_add(sdata, ta);
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 2316e7772b78..6a963eac1cc2 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -551,6 +551,9 @@ static int mctp_sk_hash(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 
+	/* Bind lookup runs under RCU, remain live during that. */
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	mutex_lock(&net->mctp.bind_lock);
 	sk_add_node_rcu(sk, &net->mctp.binds);
 	mutex_unlock(&net->mctp.bind_lock);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 766797ace942..129c9e9ee396 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1266,6 +1266,32 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, inet_sk(sk)->tos);
+	case IP_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_sk(sk)->freebind);
+	case IP_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_sk(sk)->transparent);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = (void *)msk;
+
+	switch (optname) {
+	case IPV6_V6ONLY:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    sk->sk_ipv6only);
+	case IPV6_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_sk(sk)->transparent);
+	case IPV6_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_sk(sk)->freebind);
 	}
 
 	return -EOPNOTSUPP;
@@ -1308,6 +1334,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_IP)
 		return mptcp_getsockopt_v4(msk, optname, optval, option);
+	if (level == SOL_IPV6)
+		return mptcp_getsockopt_v6(msk, optname, optval, option);
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	if (level == SOL_MPTCP)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c3e0ad7beb57..a6237eb55537 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -643,8 +643,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 
 	subflow_req = mptcp_subflow_rsk(req);
 	msk = subflow_req->msk;
-	if (!msk)
-		return false;
 
 	subflow_generate_hmac(msk->remote_key, msk->local_key,
 			      subflow_req->remote_nonce,
@@ -739,12 +737,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
-		    !subflow_hmac_valid(req, &mp_opt) ||
-		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK))
 			fallback = true;
-		}
 	}
 
 create_child:
@@ -794,6 +788,17 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
+			if (!subflow_hmac_valid(req, &mp_opt)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;
+			}
+
+			if (!mptcp_can_accept_new_subflow(owner)) {
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;
+			}
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index b8d3c3213efe..c15db28c5ebc 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -994,8 +994,9 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(5, lt,  8,  pkt[8], bsize);
 
 		NFT_PIPAPO_AVX2_AND(6, 2, 3);
+		NFT_PIPAPO_AVX2_AND(3, 4, 7);
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(7, lt,  9,  pkt[9], bsize);
-		NFT_PIPAPO_AVX2_AND(0, 4, 5);
+		NFT_PIPAPO_AVX2_AND(0, 3, 5);
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(1, lt, 10, pkt[10], bsize);
 		NFT_PIPAPO_AVX2_AND(2, 6, 7);
 		NFT_PIPAPO_AVX2_BUCKET_LOAD8(3, lt, 11, pkt[11], bsize);
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 5ebbec656895..0ed3953dbe52 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2860,7 +2860,8 @@ static int validate_set(const struct nlattr *a,
 	size_t key_len;
 
 	/* There can be only one key in a action */
-	if (nla_total_size(nla_len(ovs_key)) != nla_len(a))
+	if (!nla_ok(ovs_key, nla_len(a)) ||
+	    nla_total_size(nla_len(ovs_key)) != nla_len(a))
 		return -EINVAL;
 
 	key_len = nla_len(ovs_key);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 445ab1b0537d..89da596be1b8 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1824,6 +1824,7 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 	struct tcmsg *tcm;
 	struct nlmsghdr  *nlh;
 	unsigned char *b = skb_tail_pointer(skb);
+	int ret = -EMSGSIZE;
 
 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*tcm), flags);
 	if (!nlh)
@@ -1868,11 +1869,45 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 
 	return skb->len;
 
+cls_op_not_supp:
+	ret = -EOPNOTSUPP;
 out_nlmsg_trim:
 nla_put_failure:
-cls_op_not_supp:
 	nlmsg_trim(skb, b);
-	return -1;
+	return ret;
+}
+
+static struct sk_buff *tfilter_notify_prep(struct net *net,
+					   struct sk_buff *oskb,
+					   struct nlmsghdr *n,
+					   struct tcf_proto *tp,
+					   struct tcf_block *block,
+					   struct Qdisc *q, u32 parent,
+					   void *fh, int event,
+					   u32 portid, bool rtnl_held,
+					   struct netlink_ext_ack *extack)
+{
+	unsigned int size = oskb ? max(NLMSG_GOODSIZE, oskb->len) : NLMSG_GOODSIZE;
+	struct sk_buff *skb;
+	int ret;
+
+retry:
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return ERR_PTR(-ENOBUFS);
+
+	ret = tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
+			    n->nlmsg_seq, n->nlmsg_flags, event, false,
+			    rtnl_held, extack);
+	if (ret <= 0) {
+		kfree_skb(skb);
+		if (ret == -EMSGSIZE) {
+			size += NLMSG_GOODSIZE;
+			goto retry;
+		}
+		return ERR_PTR(-EINVAL);
+	}
+	return skb;
 }
 
 static int tfilter_notify(struct net *net, struct sk_buff *oskb,
@@ -1885,16 +1920,13 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	int err = 0;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
+	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
+		return 0;
 
-	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
-			  n->nlmsg_seq, n->nlmsg_flags, event,
-			  false, rtnl_held, extack) <= 0) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
+	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh, event,
+				  portid, rtnl_held, extack);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
 
 	if (unicast)
 		err = rtnl_unicast(skb, net, portid);
@@ -1914,16 +1946,14 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	int err;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
+	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
+		return tp->ops->delete(tp, fh, last, rtnl_held, extack);
 
-	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
-			  n->nlmsg_seq, n->nlmsg_flags, RTM_DELTFILTER,
-			  false, rtnl_held, extack) <= 0) {
+	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh,
+				  RTM_DELTFILTER, portid, rtnl_held, extack);
+	if (IS_ERR(skb)) {
 		NL_SET_ERR_MSG(extack, "Failed to build del event notification");
-		kfree_skb(skb);
-		return -EINVAL;
+		return PTR_ERR(skb);
 	}
 
 	err = tp->ops->delete(tp, fh, last, rtnl_held, extack);
@@ -2731,6 +2761,9 @@ static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
 	struct sk_buff *skb;
 	int err = 0;
 
+	if (!unicast && !rtnl_notify_needed(net, flags, RTNLGRP_TC))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -2760,6 +2793,9 @@ static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
 	struct net *net = block->net;
 	struct sk_buff *skb;
 
+	if (!rtnl_notify_needed(net, flags, RTNLGRP_TC))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index d7a4874543de..5f2e06815745 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -95,10 +95,7 @@ static struct sk_buff *codel_qdisc_dequeue(struct Qdisc *sch)
 			    &q->stats, qdisc_pkt_len, codel_get_enqueue_time,
 			    drop_func, dequeue_func);
 
-	/* We cant call qdisc_tree_reduce_backlog() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->stats.drop_count && sch->q.qlen) {
+	if (q->stats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->stats.drop_count, q->stats.drop_len);
 		q->stats.drop_count = 0;
 		q->stats.drop_len = 0;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 8c4fee063436..9330923a624c 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -314,10 +314,8 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
 	}
 	qdisc_bstats_update(sch, skb);
 	flow->deficit -= qdisc_pkt_len(skb);
-	/* We cant call qdisc_tree_reduce_backlog() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->cstats.drop_count && sch->q.qlen) {
+
+	if (q->cstats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
 					  q->cstats.drop_len);
 		q->cstats.drop_count = 0;
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 60754f366ab7..002941d35b64 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -631,6 +631,15 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	struct red_parms *p = NULL;
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tail = NULL;
+	unsigned int maxflows;
+	unsigned int quantum;
+	unsigned int divisor;
+	int perturb_period;
+	u8 headdrop;
+	u8 maxdepth;
+	int limit;
+	u8 flags;
+
 
 	if (opt->nla_len < nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
@@ -652,39 +661,64 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
-	if (ctl->limit == 1) {
-		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
-		return -EINVAL;
-	}
+
 	sch_tree_lock(sch);
+
+	limit = q->limit;
+	divisor = q->divisor;
+	headdrop = q->headdrop;
+	maxdepth = q->maxdepth;
+	maxflows = q->maxflows;
+	perturb_period = q->perturb_period;
+	quantum = q->quantum;
+	flags = q->flags;
+
+	/* update and validate configuration */
 	if (ctl->quantum)
-		q->quantum = ctl->quantum;
-	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
+		quantum = ctl->quantum;
+	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
-		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
+		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-		q->divisor = ctl->divisor;
-		q->maxflows = min_t(u32, q->maxflows, q->divisor);
+		divisor = ctl->divisor;
+		maxflows = min_t(u32, maxflows, divisor);
 	}
 	if (ctl_v1) {
 		if (ctl_v1->depth)
-			q->maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
+			maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
 		if (p) {
-			swap(q->red_parms, p);
-			red_set_parms(q->red_parms,
+			red_set_parms(p,
 				      ctl_v1->qth_min, ctl_v1->qth_max,
 				      ctl_v1->Wlog,
 				      ctl_v1->Plog, ctl_v1->Scell_log,
 				      NULL,
 				      ctl_v1->max_P);
 		}
-		q->flags = ctl_v1->flags;
-		q->headdrop = ctl_v1->headdrop;
+		flags = ctl_v1->flags;
+		headdrop = ctl_v1->headdrop;
 	}
 	if (ctl->limit) {
-		q->limit = min_t(u32, ctl->limit, q->maxdepth * q->maxflows);
-		q->maxflows = min_t(u32, q->maxflows, q->limit);
+		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
+		maxflows = min_t(u32, maxflows, limit);
 	}
+	if (limit == 1) {
+		sch_tree_unlock(sch);
+		kfree(p);
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
+
+	/* commit configuration */
+	q->limit = limit;
+	q->divisor = divisor;
+	q->headdrop = headdrop;
+	q->maxdepth = maxdepth;
+	q->maxflows = maxflows;
+	WRITE_ONCE(q->perturb_period, perturb_period);
+	q->quantum = quantum;
+	q->flags = flags;
+	if (p)
+		swap(q->red_parms, p);
 
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > q->limit) {
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 0b201cd811a1..65162d67c3a3 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -70,8 +70,9 @@
 /* Forward declarations for internal helper functions. */
 static bool sctp_writeable(const struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len);
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len);
 static int sctp_wait_for_packet(struct sock *sk, int *err, long *timeo_p);
 static int sctp_wait_for_connect(struct sctp_association *, long *timeo_p);
 static int sctp_wait_for_accept(struct sock *sk, long timeo);
@@ -1826,7 +1827,7 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 
 	if (sctp_wspace(asoc) <= 0 || !sk_wmem_schedule(sk, msg_len)) {
 		timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
-		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len);
+		err = sctp_wait_for_sndbuf(asoc, transport, &timeo, msg_len);
 		if (err)
 			goto err;
 		if (unlikely(sinfo->sinfo_stream >= asoc->stream.outcnt)) {
@@ -9203,8 +9204,9 @@ void sctp_sock_rfree(struct sk_buff *skb)
 
 
 /* Helper function to wait for space in the sndbuf.  */
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len)
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len)
 {
 	struct sock *sk = asoc->base.sk;
 	long current_timeo = *timeo_p;
@@ -9214,7 +9216,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 	pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
 		 *timeo_p, msg_len);
 
-	/* Increment the association's refcnt.  */
+	/* Increment the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_hold(transport);
 	sctp_association_hold(asoc);
 
 	/* Wait on the association specific sndbuf space. */
@@ -9223,7 +9227,7 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 					  TASK_INTERRUPTIBLE);
 		if (asoc->base.dead)
 			goto do_dead;
-		if (!*timeo_p)
+		if ((!*timeo_p) || (transport && transport->dead))
 			goto do_nonblock;
 		if (sk->sk_err || asoc->state >= SCTP_STATE_SHUTDOWN_PENDING)
 			goto do_error;
@@ -9248,7 +9252,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 out:
 	finish_wait(&asoc->wait, &wait);
 
-	/* Release the association's refcnt.  */
+	/* Release the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_put(transport);
 	sctp_association_put(asoc);
 
 	return err;
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 2990365c2f2c..87ed33b9db1b 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -117,6 +117,8 @@ struct sctp_transport *sctp_transport_new(struct net *net,
  */
 void sctp_transport_free(struct sctp_transport *transport)
 {
+	transport->dead = 1;
+
 	/* Try to delete the heartbeat timer.  */
 	if (del_timer(&transport->hb_timer))
 		sctp_transport_put(transport);
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 8715c9b05f90..d6a8f0aa531b 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1068,6 +1068,7 @@ int tipc_link_xmit(struct tipc_link *l, struct sk_buff_head *list,
 	if (unlikely(l->backlog[imp].len >= l->backlog[imp].limit)) {
 		if (imp == TIPC_SYSTEM_IMPORTANCE) {
 			pr_warn("%s<%s>, link overflow", link_rst_msg, l->name);
+			__skb_queue_purge(list);
 			return -ENOBUFS;
 		}
 		rc = link_schedule_user(l, hdr);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 75cd20c0e3fd..14d01558311d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -900,6 +900,11 @@ static int tls_setsockopt(struct sock *sk, int level, int optname,
 	return do_tls_setsockopt(sk, optname, optval, optlen);
 }
 
+static int tls_disconnect(struct sock *sk, int flags)
+{
+	return -EOPNOTSUPP;
+}
+
 struct tls_context *tls_ctx_create(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -995,6 +1000,7 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_BASE][TLS_BASE] = *base;
 	prot[TLS_BASE][TLS_BASE].setsockopt	= tls_setsockopt;
 	prot[TLS_BASE][TLS_BASE].getsockopt	= tls_getsockopt;
+	prot[TLS_BASE][TLS_BASE].disconnect	= tls_disconnect;
 	prot[TLS_BASE][TLS_BASE].close		= tls_sk_proto_close;
 
 	prot[TLS_SW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 3edb156ae52c..7070245edfc1 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -27,14 +27,17 @@
 #include <openssl/evp.h>
 #include <openssl/pem.h>
 #include <openssl/err.h>
-#include <openssl/engine.h>
-
-/*
- * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
- *
- * Remove this if/when that API is no longer used
- */
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+#if OPENSSL_VERSION_MAJOR >= 3
+# define USE_PKCS11_PROVIDER
+# include <openssl/provider.h>
+# include <openssl/store.h>
+#else
+# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+#  define USE_PKCS11_ENGINE
+#  include <openssl/engine.h>
+# endif
+#endif
+#include "ssl-common.h"
 
 /*
  * Use CMS if we have openssl-1.0.0 or newer available - otherwise we have to
@@ -83,41 +86,6 @@ void format(void)
 	exit(2);
 }
 
-static void display_openssl_errors(int l)
-{
-	const char *file;
-	char buf[120];
-	int e, line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
-
-	while ((e = ERR_get_error_line(&file, &line))) {
-		ERR_error_string(e, buf);
-		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
-	}
-}
-
-static void drain_openssl_errors(void)
-{
-	const char *file;
-	int line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	while (ERR_get_error_line(&file, &line)) {}
-}
-
-#define ERR(cond, fmt, ...)				\
-	do {						\
-		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
-		if (__cond) {				\
-			errx(1, fmt, ## __VA_ARGS__);	\
-		}					\
-	} while(0)
-
 static const char *key_pass;
 
 static int pem_pw_cb(char *buf, int len, int w, void *v)
@@ -139,28 +107,64 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
 	return pwlen;
 }
 
-static EVP_PKEY *read_private_key(const char *private_key_name)
+static EVP_PKEY *read_private_key_pkcs11(const char *private_key_name)
 {
-	EVP_PKEY *private_key;
+	EVP_PKEY *private_key = NULL;
+#ifdef USE_PKCS11_PROVIDER
+	OSSL_STORE_CTX *store;
 
+	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+		ERR(1, "OSSL_PROVIDER_try_load(default)");
+
+	store = OSSL_STORE_open(private_key_name, NULL, NULL, NULL, NULL);
+	ERR(!store, "OSSL_STORE_open");
+
+	while (!OSSL_STORE_eof(store)) {
+		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
+
+		if (!info) {
+			drain_openssl_errors(__LINE__, 0);
+			continue;
+		}
+		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
+			private_key = OSSL_STORE_INFO_get1_PKEY(info);
+			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
+		}
+		OSSL_STORE_INFO_free(info);
+		if (private_key)
+			break;
+	}
+	OSSL_STORE_close(store);
+#elif defined(USE_PKCS11_ENGINE)
+	ENGINE *e;
+
+	ENGINE_load_builtin_engines();
+	drain_openssl_errors(__LINE__, 1);
+	e = ENGINE_by_id("pkcs11");
+	ERR(!e, "Load PKCS#11 ENGINE");
+	if (ENGINE_init(e))
+		drain_openssl_errors(__LINE__, 1);
+	else
+		ERR(1, "ENGINE_init");
+	if (key_pass)
+		ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
+	private_key = ENGINE_load_private_key(e, private_key_name, NULL, NULL);
+	ERR(!private_key, "%s", private_key_name);
+#else
+	fprintf(stderr, "no pkcs11 engine/provider available\n");
+	exit(1);
+#endif
+	return private_key;
+}
+
+static EVP_PKEY *read_private_key(const char *private_key_name)
+{
 	if (!strncmp(private_key_name, "pkcs11:", 7)) {
-		ENGINE *e;
-
-		ENGINE_load_builtin_engines();
-		drain_openssl_errors();
-		e = ENGINE_by_id("pkcs11");
-		ERR(!e, "Load PKCS#11 ENGINE");
-		if (ENGINE_init(e))
-			drain_openssl_errors();
-		else
-			ERR(1, "ENGINE_init");
-		if (key_pass)
-			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
-			    "Set PKCS#11 PIN");
-		private_key = ENGINE_load_private_key(e, private_key_name,
-						      NULL, NULL);
-		ERR(!private_key, "%s", private_key_name);
+		return read_private_key_pkcs11(private_key_name);
 	} else {
+		EVP_PKEY *private_key;
 		BIO *b;
 
 		b = BIO_new_file(private_key_name, "rb");
@@ -169,9 +173,9 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
 						      NULL);
 		ERR(!private_key, "%s", private_key_name);
 		BIO_free(b);
-	}
 
-	return private_key;
+		return private_key;
+	}
 }
 
 static X509 *read_x509(const char *x509_name)
@@ -306,7 +310,7 @@ int main(int argc, char **argv)
 
 		/* Digest the module data. */
 		OpenSSL_add_all_digests();
-		display_openssl_errors(__LINE__);
+		drain_openssl_errors(__LINE__, 0);
 		digest_algo = EVP_get_digestbyname(hash_algo);
 		ERR(!digest_algo, "EVP_get_digestbyname");
 
diff --git a/scripts/ssl-common.h b/scripts/ssl-common.h
new file mode 100644
index 000000000000..2db0e181143c
--- /dev/null
+++ b/scripts/ssl-common.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ * SSL helper functions shared by sign-file and extract-cert.
+ */
+
+static void drain_openssl_errors(int l, int silent)
+{
+	const char *file;
+	char buf[120];
+	int e, line;
+
+	if (ERR_peek_error() == 0)
+		return;
+	if (!silent)
+		fprintf(stderr, "At main.c:%d:\n", l);
+
+	while ((e = ERR_peek_error_line(&file, &line))) {
+		ERR_error_string(e, buf);
+		if (!silent)
+			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+		ERR_get_error();
+	}
+}
+
+#define ERR(cond, fmt, ...)				\
+	do {						\
+		bool __cond = (cond);			\
+		drain_openssl_errors(__LINE__, 0);	\
+		if (__cond) {				\
+			errx(1, fmt, ## __VA_ARGS__);	\
+		}					\
+	} while (0)
diff --git a/security/landlock/errata.h b/security/landlock/errata.h
new file mode 100644
index 000000000000..fe91ef0e6f72
--- /dev/null
+++ b/security/landlock/errata.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Errata information
+ *
+ * Copyright Â© 2025 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_ERRATA_H
+#define _SECURITY_LANDLOCK_ERRATA_H
+
+#include <linux/init.h>
+
+struct landlock_erratum {
+	const int abi;
+	const u8 number;
+};
+
+/* clang-format off */
+#define LANDLOCK_ERRATUM(NUMBER) \
+	{ \
+		.abi = LANDLOCK_ERRATA_ABI, \
+		.number = NUMBER, \
+	},
+/* clang-format on */
+
+/*
+ * Some fixes may require user space to check if they are applied on the running
+ * kernel before using a specific feature.  For instance, this applies when a
+ * restriction was previously too restrictive and is now getting relaxed (for
+ * compatibility or semantic reasons).  However, non-visible changes for
+ * legitimate use (e.g. security fixes) do not require an erratum.
+ */
+static const struct landlock_erratum landlock_errata_init[] __initconst = {
+
+/*
+ * Only Sparse may not implement __has_include.  If a compiler does not
+ * implement __has_include, a warning will be printed at boot time (see
+ * setup.c).
+ */
+#ifdef __has_include
+
+#define LANDLOCK_ERRATA_ABI 1
+#if __has_include("errata/abi-1.h")
+#include "errata/abi-1.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 2
+#if __has_include("errata/abi-2.h")
+#include "errata/abi-2.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 3
+#if __has_include("errata/abi-3.h")
+#include "errata/abi-3.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 4
+#if __has_include("errata/abi-4.h")
+#include "errata/abi-4.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+/*
+ * For each new erratum, we need to include all the ABI files up to the impacted
+ * ABI to make all potential future intermediate errata easy to backport.
+ *
+ * If such change involves more than one ABI addition, then it must be in a
+ * dedicated commit with the same Fixes tag as used for the actual fix.
+ *
+ * Each commit creating a new security/landlock/errata/abi-*.h file must have a
+ * Depends-on tag to reference the commit that previously added the line to
+ * include this new file, except if the original Fixes tag is enough.
+ *
+ * Each erratum must be documented in its related ABI file, and a dedicated
+ * commit must update Documentation/userspace-api/landlock.rst to include this
+ * erratum.  This commit will not be backported.
+ */
+
+#endif
+
+	{}
+};
+
+#endif /* _SECURITY_LANDLOCK_ERRATA_H */
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f8e8e980454c..cdee579901da 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -6,11 +6,13 @@
  * Copyright © 2018-2020 ANSSI
  */
 
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
 
 #include "common.h"
 #include "cred.h"
+#include "errata.h"
 #include "fs.h"
 #include "ptrace.h"
 #include "setup.h"
@@ -23,8 +25,36 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+int landlock_errata __ro_after_init;
+
+static void __init compute_errata(void)
+{
+	size_t i;
+
+#ifndef __has_include
+	/*
+	 * This is a safeguard to make sure the compiler implements
+	 * __has_include (see errata.h).
+	 */
+	WARN_ON_ONCE(1);
+	return;
+#endif
+
+	for (i = 0; landlock_errata_init[i].number; i++) {
+		const int prev_errata = landlock_errata;
+
+		if (WARN_ON_ONCE(landlock_errata_init[i].abi >
+				 landlock_abi_version))
+			continue;
+
+		landlock_errata |= BIT(landlock_errata_init[i].number - 1);
+		WARN_ON_ONCE(prev_errata == landlock_errata);
+	}
+}
+
 static int __init landlock_init(void)
 {
+	compute_errata();
 	landlock_add_cred_hooks();
 	landlock_add_ptrace_hooks();
 	landlock_add_fs_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 1daffab1ab4b..420dceca35d2 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -11,7 +11,10 @@
 
 #include <linux/lsm_hooks.h>
 
+extern const int landlock_abi_version;
+
 extern bool landlock_initialized;
+extern int landlock_errata;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index d0cb3d0cbf98..7590a74a55e5 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -150,7 +150,9 @@ static const struct file_operations ruleset_fops = {
  *        the new ruleset.
  * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
  *        backward and forward compatibility).
- * @flags: Supported value: %LANDLOCK_CREATE_RULESET_VERSION.
+ * @flags: Supported value:
+ *         - %LANDLOCK_CREATE_RULESET_VERSION
+ *         - %LANDLOCK_CREATE_RULESET_ERRATA
  *
  * This system call enables to create a new Landlock ruleset, and returns the
  * related file descriptor on success.
@@ -159,6 +161,10 @@ static const struct file_operations ruleset_fops = {
  * 0, then the returned value is the highest supported Landlock ABI version
  * (starting at 1).
  *
+ * If @flags is %LANDLOCK_CREATE_RULESET_ERRATA and @attr is NULL and @size is
+ * 0, then the returned value is a bitmask of fixed issues for the current
+ * Landlock ABI version.
+ *
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
@@ -181,9 +187,15 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 		return -EOPNOTSUPP;
 
 	if (flags) {
-		if ((flags == LANDLOCK_CREATE_RULESET_VERSION) && !attr &&
-		    !size)
-			return LANDLOCK_ABI_VERSION;
+		if (attr || size)
+			return -EINVAL;
+
+		if (flags == LANDLOCK_CREATE_RULESET_VERSION)
+			return landlock_abi_version;
+
+		if (flags == LANDLOCK_CREATE_RULESET_ERRATA)
+			return landlock_errata;
+
 		return -EINVAL;
 	}
 
@@ -213,6 +225,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	return ruleset_fd;
 }
 
+const int landlock_abi_version = LANDLOCK_ABI_VERSION;
+
 /*
  * Returns an owned ruleset from a FD. It is thus needed to call
  * landlock_put_ruleset() on the return value.
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 56ee7708f6c4..5eeea9a4d201 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/acpi.h>
 #include <linux/pgtable.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86
 /* for snoop control */
@@ -1366,8 +1367,21 @@ static void azx_free(struct azx *chip)
 	if (use_vga_switcheroo(hda)) {
 		if (chip->disabled && hda->probe_continued)
 			snd_hda_unlock_devices(&chip->bus);
-		if (hda->vga_switcheroo_registered)
+		if (hda->vga_switcheroo_registered) {
 			vga_switcheroo_unregister_client(chip->pci);
+
+			/* Some GPUs don't have sound, and azx_first_init fails,
+			 * leaving the device probed but non-functional. As long
+			 * as it's probed, the PCI subsystem keeps its runtime
+			 * PM status as active. Force it to suspended (as we
+			 * actually stop the chip) to allow GPU to suspend via
+			 * vga_switcheroo, and print a warning.
+			 */
+			dev_warn(&pci->dev, "GPU sound probed, but not operational: please add a quirk to driver_denylist\n");
+			pm_runtime_disable(&pci->dev);
+			pm_runtime_set_suspended(&pci->dev);
+			pm_runtime_enable(&pci->dev);
+		}
 	}
 
 	if (bus->chip_init) {
@@ -2074,6 +2088,27 @@ static const struct pci_device_id driver_denylist[] = {
 	{}
 };
 
+static struct pci_device_id driver_denylist_ideapad_z570[] = {
+	{ PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) }, /* NVIDIA GF108 HDA */
+	{}
+};
+
+/* DMI-based denylist, to be used when:
+ *  - PCI subsystem IDs are zero, impossible to distinguish from valid sound cards.
+ *  - Different modifications of the same laptop use different GPU models.
+ */
+static const struct dmi_system_id driver_denylist_dmi[] = {
+	{
+		/* No HDA in NVIDIA DGPU. BIOS disables it, but quirk_nvidia_hda() reenables. */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Ideapad Z570"),
+		},
+		.driver_data = &driver_denylist_ideapad_z570,
+	},
+	{}
+};
+
 static const struct hda_controller_ops pci_hda_ops = {
 	.disable_msi_reset_irq = disable_msi_reset_irq,
 	.position_check = azx_position_check,
@@ -2084,6 +2119,7 @@ static DECLARE_BITMAP(probed_devs, SNDRV_CARDS);
 static int azx_probe(struct pci_dev *pci,
 		     const struct pci_device_id *pci_id)
 {
+	const struct dmi_system_id *dmi;
 	struct snd_card *card;
 	struct hda_intel *hda;
 	struct azx *chip;
@@ -2096,6 +2132,12 @@ static int azx_probe(struct pci_dev *pci,
 		return -ENODEV;
 	}
 
+	dmi = dmi_first_match(driver_denylist_dmi);
+	if (dmi && pci_match_id(dmi->driver_data, pci)) {
+		dev_info(&pci->dev, "Skipping the device on the DMI denylist\n");
+		return -ENODEV;
+	}
+
 	dev = find_first_zero_bit(probed_devs, SNDRV_CARDS);
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 93e8990c23bc..61b48f2418bf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10071,6 +10071,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1c80, "ASUS VivoBook TP401", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 77ea8a6c2d6d..1f94269e121a 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -479,6 +479,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "pang13"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7UCX"),
+		}
+	},
 	{}
 };
 
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index bb9de5767ebc..e217c56a7e87 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -63,6 +63,10 @@
 #define CDC_WSA_TX_SPKR_PROT_CLK_DISABLE	0
 #define CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK	GENMASK(3, 0)
 #define CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K	0
+#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K	1
+#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K	2
+#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K	3
+#define CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K	4
 #define CDC_WSA_TX0_SPKR_PROT_PATH_CFG0		(0x0248)
 #define CDC_WSA_TX1_SPKR_PROT_PATH_CTL		(0x0264)
 #define CDC_WSA_TX1_SPKR_PROT_PATH_CFG0		(0x0268)
@@ -344,6 +348,7 @@ struct wsa_macro {
 	int ear_spkr_gain;
 	int spkr_gain_offset;
 	int spkr_mode;
+	u32 pcm_rate_vi;
 	int is_softclip_on[WSA_MACRO_SOFTCLIP_MAX];
 	int softclip_clk_users[WSA_MACRO_SOFTCLIP_MAX];
 	struct regmap *regmap;
@@ -971,6 +976,7 @@ static int wsa_macro_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (substream->stream) {
@@ -982,6 +988,11 @@ static int wsa_macro_hw_params(struct snd_pcm_substream *substream,
 				__func__, params_rate(params));
 			return ret;
 		}
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		if (dai->id == WSA_MACRO_AIF_VI)
+			wsa->pcm_rate_vi = params_rate(params);
+
 		break;
 	default:
 		break;
@@ -1139,35 +1150,11 @@ static void wsa_macro_mclk_enable(struct wsa_macro *wsa, bool mclk_enable)
 	}
 }
 
-static int wsa_macro_mclk_event(struct snd_soc_dapm_widget *w,
-				struct snd_kcontrol *kcontrol, int event)
+static void wsa_macro_enable_disable_vi_sense(struct snd_soc_component *component, bool enable,
+						u32 tx_reg0, u32 tx_reg1, u32 val)
 {
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
-
-	wsa_macro_mclk_enable(wsa, event == SND_SOC_DAPM_PRE_PMU);
-	return 0;
-}
-
-static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
-					struct snd_kcontrol *kcontrol,
-					int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
-	u32 tx_reg0, tx_reg1;
-
-	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
-		tx_reg0 = CDC_WSA_TX0_SPKR_PROT_PATH_CTL;
-		tx_reg1 = CDC_WSA_TX1_SPKR_PROT_PATH_CTL;
-	} else if (test_bit(WSA_MACRO_TX1, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
-		tx_reg0 = CDC_WSA_TX2_SPKR_PROT_PATH_CTL;
-		tx_reg1 = CDC_WSA_TX3_SPKR_PROT_PATH_CTL;
-	}
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-			/* Enable V&I sensing */
+	if (enable) {
+		/* Enable V&I sensing */
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
 					      CDC_WSA_TX_SPKR_PROT_RESET);
@@ -1176,10 +1163,10 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 					      CDC_WSA_TX_SPKR_PROT_RESET);
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
-					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K);
+					      val);
 		snd_soc_component_update_bits(component, tx_reg1,
 					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
-					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K);
+					      val);
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_CLK_EN_MASK,
 					      CDC_WSA_TX_SPKR_PROT_CLK_ENABLE);
@@ -1192,9 +1179,7 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 		snd_soc_component_update_bits(component, tx_reg1,
 					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
 					      CDC_WSA_TX_SPKR_PROT_NO_RESET);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		/* Disable V&I sensing */
+	} else {
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
 					      CDC_WSA_TX_SPKR_PROT_RESET);
@@ -1207,6 +1192,72 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 		snd_soc_component_update_bits(component, tx_reg1,
 					      CDC_WSA_TX_SPKR_PROT_CLK_EN_MASK,
 					      CDC_WSA_TX_SPKR_PROT_CLK_DISABLE);
+	}
+}
+
+static void wsa_macro_enable_disable_vi_feedback(struct snd_soc_component *component,
+						 bool enable, u32 rate)
+{
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
+
+	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI]))
+		wsa_macro_enable_disable_vi_sense(component, enable,
+				CDC_WSA_TX0_SPKR_PROT_PATH_CTL,
+				CDC_WSA_TX1_SPKR_PROT_PATH_CTL, rate);
+
+	if (test_bit(WSA_MACRO_TX1, &wsa->active_ch_mask[WSA_MACRO_AIF_VI]))
+		wsa_macro_enable_disable_vi_sense(component, enable,
+				CDC_WSA_TX2_SPKR_PROT_PATH_CTL,
+				CDC_WSA_TX3_SPKR_PROT_PATH_CTL, rate);
+}
+
+static int wsa_macro_mclk_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
+
+	wsa_macro_mclk_enable(wsa, event == SND_SOC_DAPM_PRE_PMU);
+	return 0;
+}
+
+static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol,
+					int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
+	u32 rate_val;
+
+	switch (wsa->pcm_rate_vi) {
+	case 8000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
+		break;
+	case 16000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K;
+		break;
+	case 24000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K;
+		break;
+	case 32000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K;
+		break;
+	case 48000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K;
+		break;
+	default:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
+		break;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Enable V&I sensing */
+		wsa_macro_enable_disable_vi_feedback(component, true, rate_val);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* Disable V&I sensing */
+		wsa_macro_enable_disable_vi_feedback(component, false, rate_val);
 		break;
 	}
 
diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 672148dd4b23..acb499a5043c 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -492,11 +492,17 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 		goto err_disable_pm;
 	}
 
-	priv->pdev = platform_device_register_data(dev, "imx-audmix", 0, NULL, 0);
-	if (IS_ERR(priv->pdev)) {
-		ret = PTR_ERR(priv->pdev);
-		dev_err(dev, "failed to register platform: %d\n", ret);
-		goto err_disable_pm;
+	/*
+	 * If dais property exist, then register the imx-audmix card driver.
+	 * otherwise, it should be linked by audio graph card.
+	 */
+	if (of_find_property(pdev->dev.of_node, "dais", NULL)) {
+		priv->pdev = platform_device_register_data(dev, "imx-audmix", 0, NULL, 0);
+		if (IS_ERR(priv->pdev)) {
+			ret = PTR_ERR(priv->pdev);
+			dev_err(dev, "failed to register platform: %d\n", ret);
+			goto err_disable_pm;
+		}
 	}
 
 	return 0;
diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 7f02f5b2c33f..de99c6920df8 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -24,8 +24,8 @@
 #define PLAYBACK_MIN_PERIOD_SIZE	128
 #define CAPTURE_MIN_NUM_PERIODS		2
 #define CAPTURE_MAX_NUM_PERIODS		8
-#define CAPTURE_MAX_PERIOD_SIZE		4096
-#define CAPTURE_MIN_PERIOD_SIZE		320
+#define CAPTURE_MAX_PERIOD_SIZE		65536
+#define CAPTURE_MIN_PERIOD_SIZE		6144
 #define BUFFER_BYTES_MAX (PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE)
 #define BUFFER_BYTES_MIN (PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE)
 #define SID_MASK_DEFAULT	0xF
@@ -292,13 +292,14 @@ static int q6apm_dai_open(struct snd_soc_component *component,
 		}
 	}
 
-	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
+	/* setup 10ms latency to accommodate DSP restrictions */
+	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for period bytes step ret = %d\n", ret);
 		goto err;
 	}
 
-	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
+	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for buffer bytes step ret = %d\n", ret);
 		goto err;
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 5fc8088e63c8..9d314f412abc 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -902,9 +902,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 
 		if (ret < 0) {
 			dev_err(dev, "q6asm_open_write failed\n");
-			q6asm_audio_client_free(prtd->audio_client);
-			prtd->audio_client = NULL;
-			return ret;
+			goto open_err;
 		}
 	}
 
@@ -913,7 +911,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 			      prtd->session_id, dir);
 	if (ret) {
 		dev_err(dev, "Stream reg failed ret:%d\n", ret);
-		return ret;
+		goto q6_err;
 	}
 
 	ret = __q6asm_dai_compr_set_codec_params(component, stream,
@@ -921,7 +919,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 						 prtd->stream_id);
 	if (ret) {
 		dev_err(dev, "codec param setup failed ret:%d\n", ret);
-		return ret;
+		goto q6_err;
 	}
 
 	ret = q6asm_map_memory_regions(dir, prtd->audio_client, prtd->phys,
@@ -930,12 +928,21 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 
 	if (ret < 0) {
 		dev_err(dev, "Buffer Mapping failed ret:%d\n", ret);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto q6_err;
 	}
 
 	prtd->state = Q6ASM_STREAM_RUNNING;
 
 	return 0;
+
+q6_err:
+	q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
+
+open_err:
+	q6asm_audio_client_free(prtd->audio_client);
+	prtd->audio_client = NULL;
+	return ret;
 }
 
 static int q6asm_dai_compr_set_metadata(struct snd_soc_component *component,
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index eed71369c7af..d300cd1f922b 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -489,16 +489,84 @@ static void ch345_broken_sysex_input(struct snd_usb_midi_in_endpoint *ep,
 
 /*
  * CME protocol: like the standard protocol, but SysEx commands are sent as a
- * single USB packet preceded by a 0x0F byte.
+ * single USB packet preceded by a 0x0F byte, as are system realtime
+ * messages and MIDI Active Sensing.
+ * Also, multiple messages can be sent in the same packet.
  */
 static void snd_usbmidi_cme_input(struct snd_usb_midi_in_endpoint *ep,
 				  uint8_t *buffer, int buffer_length)
 {
-	if (buffer_length < 2 || (buffer[0] & 0x0f) != 0x0f)
-		snd_usbmidi_standard_input(ep, buffer, buffer_length);
-	else
-		snd_usbmidi_input_data(ep, buffer[0] >> 4,
-				       &buffer[1], buffer_length - 1);
+	int remaining = buffer_length;
+
+	/*
+	 * CME send sysex, song position pointer, system realtime
+	 * and active sensing using CIN 0x0f, which in the standard
+	 * is only intended for single byte unparsed data.
+	 * So we need to interpret these here before sending them on.
+	 * By default, we assume single byte data, which is true
+	 * for system realtime (midi clock, start, stop and continue)
+	 * and active sensing, and handle the other (known) cases
+	 * separately.
+	 * In contrast to the standard, CME does not split sysex
+	 * into multiple 4-byte packets, but lumps everything together
+	 * into one. In addition, CME can string multiple messages
+	 * together in the same packet; pressing the Record button
+	 * on an UF6 sends a sysex message directly followed
+	 * by a song position pointer in the same packet.
+	 * For it to have any reasonable meaning, a sysex message
+	 * needs to be at least 3 bytes in length (0xf0, id, 0xf7),
+	 * corresponding to a packet size of 4 bytes, and the ones sent
+	 * by CME devices are 6 or 7 bytes, making the packet fragments
+	 * 7 or 8 bytes long (six or seven bytes plus preceding CN+CIN byte).
+	 * For the other types, the packet size is always 4 bytes,
+	 * as per the standard, with the data size being 3 for SPP
+	 * and 1 for the others.
+	 * Thus all packet fragments are at least 4 bytes long, so we can
+	 * skip anything that is shorter; this also conveniantly skips
+	 * packets with size 0, which CME devices continuously send when
+	 * they have nothing better to do.
+	 * Another quirk is that sometimes multiple messages are sent
+	 * in the same packet. This has been observed for midi clock
+	 * and active sensing i.e. 0x0f 0xf8 0x00 0x00 0x0f 0xfe 0x00 0x00,
+	 * but also multiple note ons/offs, and control change together
+	 * with MIDI clock. Similarly, some sysex messages are followed by
+	 * the song position pointer in the same packet, and occasionally
+	 * additionally by a midi clock or active sensing.
+	 * We handle this by looping over all data and parsing it along the way.
+	 */
+	while (remaining >= 4) {
+		int source_length = 4; /* default */
+
+		if ((buffer[0] & 0x0f) == 0x0f) {
+			int data_length = 1; /* default */
+
+			if (buffer[1] == 0xf0) {
+				/* Sysex: Find EOX and send on whole message. */
+				/* To kick off the search, skip the first
+				 * two bytes (CN+CIN and SYSEX (0xf0).
+				 */
+				uint8_t *tmp_buf = buffer + 2;
+				int tmp_length = remaining - 2;
+
+				while (tmp_length > 1 && *tmp_buf != 0xf7) {
+					tmp_buf++;
+					tmp_length--;
+				}
+				data_length = tmp_buf - buffer;
+				source_length = data_length + 1;
+			} else if (buffer[1] == 0xf2) {
+				/* Three byte song position pointer */
+				data_length = 3;
+			}
+			snd_usbmidi_input_data(ep, buffer[0] >> 4,
+					       &buffer[1], data_length);
+		} else {
+			/* normal channel events */
+			snd_usbmidi_standard_input(ep, buffer, source_length);
+		}
+		buffer += source_length;
+		remaining -= source_length;
+	}
 }
 
 /*
diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index e63dc11fa3a5..48e25be6e163 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -120,6 +120,10 @@ FILE *prepare_output(const char *dirname)
 struct config *prepare_default_config()
 {
 	struct config *config = malloc(sizeof(struct config));
+	if (!config) {
+		perror("malloc");
+		return NULL;
+	}
 
 	dprintf("loading defaults\n");
 
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index aecea16cbd02..2109bd42c144 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4282,6 +4282,14 @@ if (defined($opt{"LOG_FILE"})) {
     if ($opt{"CLEAR_LOG"}) {
 	unlink $opt{"LOG_FILE"};
     }
+
+    if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
+        my $dir = $1;
+        if (! -d $dir) {
+            mkpath($dir) or die "Failed to create directories '$dir': $!";
+            print "\nThe log directory $dir did not exist, so it was created.\n";
+        }
+    }
     open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
     LOG->autoflush(1);
 }
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index d587a558997f..11149bd12a1f 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -121,7 +121,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list)
 {
 	if (kmalloc_verbose)
-		pr_debug("Bulk free %p[0-%lu]\n", list, size - 1);
+		pr_debug("Bulk free %p[0-%zu]\n", list, size - 1);
 
 	pthread_mutex_lock(&cachep->lock);
 	for (int i = 0; i < size; i++)
@@ -139,7 +139,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 	size_t i;
 
 	if (kmalloc_verbose)
-		pr_debug("Bulk alloc %lu\n", size);
+		pr_debug("Bulk alloc %zu\n", size);
 
 	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
 		if (cachep->non_kernel < size)
diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 7d7a6a06cdb7..2d8230da9064 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -98,7 +98,7 @@ int main(int argc, char *argv[])
 	info("Calling futex_waitv on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
 	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
 	if (!res || errno != EWOULDBLOCK) {
-		ksft_test_result_pass("futex_waitv returned: %d %s\n",
+		ksft_test_result_fail("futex_waitv returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
 		ret = RET_FAIL;
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index e43831746146..ea970679c5d9 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -98,10 +98,54 @@ TEST(abi_version)
 	ASSERT_EQ(EINVAL, errno);
 }
 
+/*
+ * Old source trees might not have the set of Kselftest fixes related to kernel
+ * UAPI headers.
+ */
+#ifndef LANDLOCK_CREATE_RULESET_ERRATA
+#define LANDLOCK_CREATE_RULESET_ERRATA (1U << 1)
+#endif
+
+TEST(errata)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	int errata;
+
+	errata = landlock_create_ruleset(NULL, 0,
+					 LANDLOCK_CREATE_RULESET_ERRATA);
+	/* The errata bitmask will not be backported to tests. */
+	ASSERT_LE(0, errata);
+	TH_LOG("errata: 0x%x", errata);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
+					      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
+					      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1,
+		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
+					  LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(
+			      NULL, 0,
+			      LANDLOCK_CREATE_RULESET_VERSION |
+				      LANDLOCK_CREATE_RULESET_ERRATA));
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
+					      LANDLOCK_CREATE_RULESET_ERRATA |
+						      1 << 31));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 /* Tests ordering of syscall argument checks. */
 TEST(create_ruleset_checks_ordering)
 {
-	const int last_flag = LANDLOCK_CREATE_RULESET_VERSION;
+	const int last_flag = LANDLOCK_CREATE_RULESET_ERRATA;
 	const int invalid_flag = last_flag << 1;
 	int ruleset_fd;
 	const struct landlock_ruleset_attr ruleset_attr = {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ae2d76d4b404..a842f5ade6e3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1213,7 +1213,7 @@ int main_loop(void)
 	/* close the client socket open only if we are not going to reconnect */
 	ret = copyfd_io(fd_in, fd, 1, 0);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (cfg_truncate > 0) {
 		shutdown(fd, SHUT_WR);
@@ -1233,7 +1233,10 @@ int main_loop(void)
 		close(fd);
 	}
 
-	return 0;
+out:
+	if (cfg_input)
+		close(fd_in);
+	return ret;
 }
 
 int parse_proto(const char *proto)

