Return-Path: <stable+bounces-139438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B1AA6A73
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B22A4A4897
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552B1EBA07;
	Fri,  2 May 2025 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QKM9N0mM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B761EB5FF;
	Fri,  2 May 2025 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166054; cv=none; b=OwckRngUVOjtJSaOVCC+pUxeqoFq5goL8/nndbwqpMHUp8uoQl68CQS3AfouA8tCUGeBfJ9+rU3MWaMJlPheFZfLL1li5uLNmYlUjGTyIYQbg+NxM78OZMqNSLY6VTISN/6o/eMynJL9iAxws5fpo31WBujHRuhgTd9wqq24UP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166054; c=relaxed/simple;
	bh=mk3XWbCkqi0nSFMQy1k0z9x9dYOVO8uhVS2kY/x56t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChM1fkh/3wtQkHd3m0/pJrMbSZ1606K/hrApw8B58vnWQPePQ47xOHpzwX6o5FOUM/7obLTw2zImKeGqeLJQ/NT+7JxasdQJsgduIaAcHsrNivjWGq6kRUW2ndSHXl/zD9MY8pAfCPZND8F6ynhiTMTWdKk7lU5bMmz70WzKWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QKM9N0mM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EC4C4CEE4;
	Fri,  2 May 2025 06:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746166053;
	bh=mk3XWbCkqi0nSFMQy1k0z9x9dYOVO8uhVS2kY/x56t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QKM9N0mMKECoL5PAkYmnFphG6wQPJgArXUyiihBCFDt4CBVQY/Dmc6JOsVVpZz5vr
	 NBturTei3W9LB9PShVraCnG2J30eaFO4JKSuzCwPTwJmosldi2ens6q38pafdc/j8X
	 OGZHMN86z+ch9EAxyCD2ah3rBIugG9tjfCCXg3GY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.181
Date: Fri,  2 May 2025 08:07:12 +0200
Message-ID: <2025050211-stowing-limes-ace3@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025050211-climatic-remarry-3f9d@gregkh>
References: <2025050211-climatic-remarry-3f9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/scsi/libsas.rst b/Documentation/scsi/libsas.rst
index 6589dfefbc02..305a253d5c3b 100644
--- a/Documentation/scsi/libsas.rst
+++ b/Documentation/scsi/libsas.rst
@@ -207,7 +207,6 @@ Management Functions (TMFs) described in SAM::
 	/* Task Management Functions. Must be called from process context. */
 	int (*lldd_abort_task)(struct sas_task *);
 	int (*lldd_abort_task_set)(struct domain_device *, u8 *lun);
-	int (*lldd_clear_aca)(struct domain_device *, u8 *lun);
 	int (*lldd_clear_task_set)(struct domain_device *, u8 *lun);
 	int (*lldd_I_T_nexus_reset)(struct domain_device *);
 	int (*lldd_lu_reset)(struct domain_device *, u8 *lun);
@@ -262,7 +261,6 @@ can look like this (called last thing from probe())
 
 	    my_ha->sas_ha.lldd_abort_task     = my_abort_task;
 	    my_ha->sas_ha.lldd_abort_task_set = my_abort_task_set;
-	    my_ha->sas_ha.lldd_clear_aca      = my_clear_aca;
 	    my_ha->sas_ha.lldd_clear_task_set = my_clear_task_set;
 	    my_ha->sas_ha.lldd_I_T_nexus_reset= NULL; (2)
 	    my_ha->sas_ha.lldd_lu_reset       = my_lu_reset;
diff --git a/Makefile b/Makefile
index 619f4ec0f613..26099a3b2964 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 180
+SUBLEVEL = 181
 EXTRAVERSION =
 NAME = Trick or Treat
 
@@ -1066,6 +1066,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
 # Require designated initializers for all marked structures
 KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index c71a5155702d..9d05f908ddef 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1260,8 +1260,7 @@ dpi0_out: endpoint {
 		};
 
 		pwm0: pwm@1401e000 {
-			compatible = "mediatek,mt8173-disp-pwm",
-				     "mediatek,mt6595-disp-pwm";
+			compatible = "mediatek,mt8173-disp-pwm";
 			reg = <0 0x1401e000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&mmsys CLK_MM_DISP_PWM026M>,
@@ -1271,8 +1270,7 @@ pwm0: pwm@1401e000 {
 		};
 
 		pwm1: pwm@1401f000 {
-			compatible = "mediatek,mt8173-disp-pwm",
-				     "mediatek,mt6595-disp-pwm";
+			compatible = "mediatek,mt8173-disp-pwm";
 			reg = <0 0x1401f000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&mmsys CLK_MM_DISP_PWM126M>,
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 7dfaad0fa17b..8fe0c8d0057a 100644
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
@@ -111,6 +112,7 @@
 #define QCOM_CPU_PART_KRYO		0x200
 #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
 #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
 #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
 #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
 #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
@@ -139,6 +141,7 @@
 #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
 #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
 #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_CORTEX_A76AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76AE)
 #define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
 #define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
@@ -170,6 +173,7 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
 #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
+#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
 #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
 #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 9a62884183e5..7a407c3767b6 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -44,9 +44,11 @@ extern void fpsimd_signal_preserve_current_state(void);
 extern void fpsimd_preserve_current_state(void);
 extern void fpsimd_restore_current_state(void);
 extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
+extern void fpsimd_kvm_prepare(void);
 
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
-				     void *sve_state, unsigned int sve_vl);
+				     void *sve_state, unsigned int sve_vl,
+				     enum fp_type *type, enum fp_type to_save);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_save_and_flush_cpu_state(void);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 91038fa2e5e0..6d7b6b5d076d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -64,6 +64,7 @@ enum kvm_mode kvm_get_mode(void);
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
 extern unsigned int kvm_sve_max_vl;
+extern unsigned int kvm_host_sve_max_vl;
 int kvm_arm_init_sve(void);
 
 u32 __attribute_const__ kvm_target_cpu(void);
@@ -280,7 +281,19 @@ struct vcpu_reset_state {
 
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
+
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
 
 	/* Stage 2 paging state used by the hardware on next switch */
@@ -289,7 +302,6 @@ struct kvm_vcpu_arch {
 	/* Values of trap registers for the guest. */
 	u64 hcr_el2;
 	u64 mdcr_el2;
-	u64 cptr_el2;
 
 	/* Values of trap registers for the host before guest entry. */
 	u64 mdcr_el2_host;
@@ -321,7 +333,6 @@ struct kvm_vcpu_arch {
 	struct kvm_guest_debug_arch external_debug_state;
 
 	struct thread_info *host_thread_info;	/* hyp VA */
-	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
 
 	struct {
 		/* {Break,watch}point registers */
@@ -410,8 +421,6 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_DEBUG_DIRTY		(1 << 0)
 #define KVM_ARM64_FP_ENABLED		(1 << 1) /* guest FP regs loaded */
 #define KVM_ARM64_FP_HOST		(1 << 2) /* host FP regs loaded */
-#define KVM_ARM64_HOST_SVE_IN_USE	(1 << 3) /* backup for host TIF_SVE */
-#define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
 #define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
 #define KVM_ARM64_VCPU_SVE_FINALIZED	(1 << 6) /* SVE config completed */
 #define KVM_ARM64_GUEST_HAS_PTRAUTH	(1 << 7) /* PTRAUTH exposed to guest */
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 657d0c94cf82..308df86f9a4b 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -117,5 +117,12 @@ void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
 
 extern u64 kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val);
 extern u64 kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val);
+extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
+
+static inline bool guest_owns_fp_regs(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.flags & KVM_ARM64_FP_ENABLED;
+}
+
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 7364530de0a7..1da032444dac 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -115,6 +115,12 @@ struct debug_info {
 #endif
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
@@ -145,6 +151,7 @@ struct thread_struct {
 		struct user_fpsimd_state fpsimd_state;
 	} uw;
 
+	enum fp_type		fp_type;	/* registers FPSIMD or SVE? */
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
 	unsigned int		sve_vl;		/* SVE vector length */
diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index db7b371b367c..6d7f03adece8 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -97,7 +97,6 @@ enum mitigation_state arm64_get_meltdown_state(void);
 
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
-u8 spectre_bhb_loop_affected(int scope);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e22571e57ae1..4be9d9fd4fb7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -117,6 +117,8 @@ struct fpsimd_last_state_struct {
 	struct user_fpsimd_state *st;
 	void *sve_state;
 	unsigned int sve_vl;
+	enum fp_type *fp_type;
+	enum fp_type to_save;
 };
 
 static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
@@ -243,14 +245,6 @@ static void sve_free(struct task_struct *task)
  *    The task can execute SVE instructions while in userspace without
  *    trapping to the kernel.
  *
- *    When stored, Z0-Z31 (incorporating Vn in bits[127:0] or the
- *    corresponding Zn), P0-P15 and FFR are encoded in in
- *    task->thread.sve_state, formatted appropriately for vector
- *    length task->thread.sve_vl.
- *
- *    task->thread.sve_state must point to a valid buffer at least
- *    sve_state_size(task) bytes in size.
- *
  *    During any syscall, the kernel may optionally clear TIF_SVE and
  *    discard the vector state except for the FPSIMD subset.
  *
@@ -260,7 +254,15 @@ static void sve_free(struct task_struct *task)
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
@@ -268,7 +270,23 @@ static void sve_free(struct task_struct *task)
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
@@ -287,45 +305,68 @@ static void task_fpsimd_load(void)
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE))
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
+		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_SVE);
 		sve_load_state(sve_pffr(&current->thread),
 			       &current->thread.uw.fpsimd_state.fpsr,
 			       sve_vq_from_vl(current->thread.sve_vl) - 1);
-	else
+	} else {
+		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_FPSIMD);
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
+	}
 }
 
 /*
  * Ensure FPSIMD/SVE storage in memory for the loaded context is up to
- * date with respect to the CPU registers.
+ * date with respect to the CPU registers. Note carefully that the
+ * current context is the context last bound to the CPU stored in
+ * last, if KVM is involved this may be the guest VM context rather
+ * than the host thread for the VM pointed to by current. This means
+ * that we must always reference the state storage via last rather
+ * than via current, if we are saving KVM state then it will have
+ * ensured that the type of registers to save is set in last->to_save.
  */
 static void fpsimd_save(void)
 {
 	struct fpsimd_last_state_struct const *last =
 		this_cpu_ptr(&fpsimd_last_state);
 	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
+	bool save_sve_regs = false;
+	unsigned long vl;
 
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
-	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
-		if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-		    test_thread_flag(TIF_SVE)) {
-			if (WARN_ON(sve_get_vl() != last->sve_vl)) {
-				/*
-				 * Can't save the user regs, so current would
-				 * re-enter user with corrupt state.
-				 * There's no way to recover, so kill it:
-				 */
-				force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
-				return;
-			}
-
-			sve_save_state((char *)last->sve_state +
-						sve_ffr_offset(last->sve_vl),
-				       &last->st->fpsr);
-		} else
-			fpsimd_save_state(last->st);
+	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
+		return;
+
+	if ((last->to_save == FP_STATE_CURRENT && test_thread_flag(TIF_SVE)) ||
+	    last->to_save == FP_STATE_SVE) {
+		save_sve_regs = true;
+		vl = last->sve_vl;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && save_sve_regs) {
+		/* Get the configured VL from RDVL, will account for SM */
+		if (WARN_ON(sve_get_vl() != vl)) {
+			/*
+			 * Can't save the user regs, so current would
+			 * re-enter user with corrupt state.
+			 * There's no way to recover, so kill it:
+			 */
+			force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
+			return;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && save_sve_regs) {
+		sve_save_state((char *)last->sve_state +
+			       sve_ffr_offset(last->sve_vl),
+			       &last->st->fpsr);
+		*last->fp_type = FP_STATE_SVE;
+	} else {
+		fpsimd_save_state(last->st);
+		*last->fp_type = FP_STATE_FPSIMD;
 	}
 }
 
@@ -624,8 +665,10 @@ int sve_set_vector_length(struct task_struct *task,
 	}
 
 	fpsimd_flush_task_state(task);
-	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
+	if (test_and_clear_tsk_thread_flag(task, TIF_SVE)) {
 		sve_to_fpsimd(task);
+		task->thread.fp_type = FP_STATE_FPSIMD;
+	}
 
 	if (task == current)
 		put_cpu_fpsimd_context();
@@ -965,6 +1008,7 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
 	} else {
 		fpsimd_to_sve(current);
 		fpsimd_flush_task_state(current);
+		current->thread.fp_type = FP_STATE_SVE;
 	}
 
 	put_cpu_fpsimd_context();
@@ -1079,6 +1123,8 @@ void fpsimd_flush_thread(void)
 			current->thread.sve_vl_onexec = 0;
 	}
 
+	current->thread.fp_type = FP_STATE_FPSIMD;
+
 	put_cpu_fpsimd_context();
 }
 
@@ -1122,6 +1168,8 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
 	last->sve_vl = current->thread.sve_vl;
+	last->fp_type = &current->thread.fp_type;
+	last->to_save = FP_STATE_CURRENT;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
 	if (system_supports_sve()) {
@@ -1136,7 +1184,8 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl)
+			      unsigned int sve_vl, enum fp_type *type,
+			      enum fp_type to_save)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1147,6 +1196,8 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 	last->st = st;
 	last->sve_state = sve_state;
 	last->sve_vl = sve_vl;
+	last->fp_type = type;
+	last->to_save = to_save;
 }
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 839edc4ed7a4..a01f2288ee9a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -307,6 +307,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.sve_state = NULL;
 	clear_tsk_thread_flag(dst, TIF_SVE);
 
+
+	dst->thread.fp_type = FP_STATE_FPSIMD;
+
 	/* clear any pending asynchronous tag fault raised by the parent */
 	clear_tsk_thread_flag(dst, TIF_MTE_ASYNC_FAULT);
 
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index ebce46c4e942..750588f9a1d4 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -845,52 +845,86 @@ static unsigned long system_bhb_mitigations;
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
@@ -916,29 +950,13 @@ static enum mitigation_state spectre_bhb_get_cpu_fw_mitigation_state(void)
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
@@ -954,6 +972,8 @@ static bool supports_ecbhb(int scope)
 						    ID_AA64MMFR1_ECBHB_SHIFT);
 }
 
+static u8 max_bhb_k;
+
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
 			     int scope)
 {
@@ -962,16 +982,18 @@ bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
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
@@ -997,7 +1019,7 @@ static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
 	bp_hardening_cb_t cpu_cb;
-	enum mitigation_state fw_state, state = SPECTRE_VULNERABLE;
+	enum mitigation_state state = SPECTRE_VULNERABLE;
 	struct bp_hardening_data *data = this_cpu_ptr(&bp_hardening_data);
 
 	if (!is_spectre_bhb_affected(entry, SCOPE_LOCAL_CPU))
@@ -1023,7 +1045,7 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		this_cpu_set_vectors(EL1_VECTOR_BHB_CLEAR_INSN);
 		state = SPECTRE_MITIGATED;
 		set_bit(BHB_INSN, &system_bhb_mitigations);
-	} else if (spectre_bhb_loop_affected(SCOPE_LOCAL_CPU)) {
+	} else if (spectre_bhb_loop_affected()) {
 		/*
 		 * Ensure KVM uses the indirect vector which will have the
 		 * branchy-loop added. A57/A72-r0 will already have selected
@@ -1036,32 +1058,29 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
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
@@ -1095,7 +1114,6 @@ void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 {
 	u8 rd;
 	u32 insn;
-	u16 loop_count = spectre_bhb_loop_affected(SCOPE_SYSTEM);
 
 	BUG_ON(nr_inst != 1); /* MOV -> MOV */
 
@@ -1104,7 +1122,7 @@ void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 
 	insn = le32_to_cpu(*origptr);
 	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn);
-	insn = aarch64_insn_gen_movewide(rd, loop_count, 0,
+	insn = aarch64_insn_gen_movewide(rd, max_bhb_k, 0,
 					 AARCH64_INSN_VARIANT_64BIT,
 					 AARCH64_INSN_MOVEWIDE_ZERO);
 	*updptr++ = cpu_to_le32(insn);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 92de9212b7b5..4ef9e688508c 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -829,6 +829,7 @@ static int sve_set(struct task_struct *target,
 		ret = __fpr_set(target, regset, pos, count, kbuf, ubuf,
 				SVE_PT_FPSIMD_OFFSET);
 		clear_tsk_thread_flag(target, TIF_SVE);
+		target->thread.fp_type = FP_STATE_FPSIMD;
 		goto out;
 	}
 
@@ -848,6 +849,7 @@ static int sve_set(struct task_struct *target,
 	if (!target->thread.sve_state) {
 		ret = -ENOMEM;
 		clear_tsk_thread_flag(target, TIF_SVE);
+		target->thread.fp_type = FP_STATE_FPSIMD;
 		goto out;
 	}
 
@@ -858,6 +860,7 @@ static int sve_set(struct task_struct *target,
 	 */
 	fpsimd_sync_to_sve(target);
 	set_tsk_thread_flag(target, TIF_SVE);
+	target->thread.fp_type = FP_STATE_SVE;
 
 	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
 	start = SVE_PT_SVE_OFFSET;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index b3e1beccf458..768de05b616b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -207,6 +207,7 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	__get_user_error(fpsimd.fpcr, &ctx->fpcr, err);
 
 	clear_thread_flag(TIF_SVE);
+	current->thread.fp_type = FP_STATE_FPSIMD;
 
 	/* load the hardware registers from the fpsimd_state structure */
 	if (!err)
@@ -271,6 +272,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 
 	if (sve.head.size <= sizeof(*user->sve)) {
 		clear_thread_flag(TIF_SVE);
+		current->thread.fp_type = FP_STATE_FPSIMD;
 		goto fpsimd_only;
 	}
 
@@ -303,6 +305,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 		return -EFAULT;
 
 	set_thread_flag(TIF_SVE);
+	current->thread.fp_type = FP_STATE_SVE;
 
 fpsimd_only:
 	/* copy the FP and status/control registers */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9ded5443de48..5ca8782edb96 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1138,7 +1138,6 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	}
 
 	vcpu_reset_hcr(vcpu);
-	vcpu->arch.cptr_el2 = CPTR_EL2_DEFAULT;
 
 	/*
 	 * Handle the "start in power-off" case.
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 5621020b28de..cfda503c8b3f 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -55,7 +55,6 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	}
 
 	vcpu->arch.host_thread_info = kern_hyp_va(ti);
-	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
 error:
 	return ret;
 }
@@ -66,24 +65,24 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
  *
  * Here, we just set the correct metadata to indicate that the FPSIMD
  * state in the cpu regs (if any) belongs to current on the host.
- *
- * TIF_SVE is backed up here, since it may get clobbered with guest state.
- * This flag is restored by kvm_arch_vcpu_put_fp(vcpu).
  */
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(!current->mm);
 
-	vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
-			      KVM_ARM64_HOST_SVE_IN_USE |
-			      KVM_ARM64_HOST_SVE_ENABLED);
+	vcpu->arch.flags &= ~KVM_ARM64_FP_ENABLED;
 	vcpu->arch.flags |= KVM_ARM64_FP_HOST;
 
-	if (test_thread_flag(TIF_SVE))
-		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_IN_USE;
-
-	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
-		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
+	/*
+	 * Ensure that any host FPSIMD/SVE/SME state is saved and unbound such
+	 * that the host kernel is responsible for restoring this state upon
+	 * return to userspace, and the hyp code doesn't need to save anything.
+	 *
+	 * When the host may use SME, fpsimd_save_and_flush_cpu_state() ensures
+	 * that PSTATE.{SM,ZA} == {0,0}.
+	 */
+	fpsimd_save_and_flush_cpu_state();
+	vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
 }
 
 /*
@@ -94,15 +93,26 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
  */
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 {
+	enum fp_type fp_type;
+
 	WARN_ON_ONCE(!irqs_disabled());
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
+		if (vcpu_has_sve(vcpu))
+			fp_type = FP_STATE_SVE;
+		else
+			fp_type = FP_STATE_FPSIMD;
+
+		/*
+		 * Currently we do not support SME guests so SVCR is
+		 * always 0 and we just need a variable to point to.
+		 */
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.fp_regs,
 					 vcpu->arch.sve_state,
-					 vcpu->arch.sve_max_vl);
+					 vcpu->arch.sve_max_vl,
+					 &vcpu->arch.fp_type, fp_type);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
-		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
 	}
 }
 
@@ -115,38 +125,22 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
-	bool host_has_sve = system_supports_sve();
-	bool guest_has_sve = vcpu_has_sve(vcpu);
 
 	local_irq_save(flags);
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
-		if (guest_has_sve) {
-			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
-
-			/* Restore the VL that was saved when bound to the CPU */
-			if (!has_vhe())
-				sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
-						       SYS_ZCR_EL1);
-		}
-
-		fpsimd_save_and_flush_cpu_state();
-	} else if (has_vhe() && host_has_sve) {
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
-		if (vcpu->arch.flags & KVM_ARM64_HOST_SVE_ENABLED)
-			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_ZEN_EL0EN);
-		else
-			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
+		fpsimd_save_and_flush_cpu_state();
 	}
 
-	update_thread_flag(TIF_SVE,
-			   vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE);
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
index ecd41844eda0..797544662a95 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -207,16 +207,6 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 	return __get_fault_info(esr, &vcpu->arch.fault);
 }
 
-static inline void __hyp_sve_save_host(struct kvm_vcpu *vcpu)
-{
-	struct thread_struct *thread;
-
-	thread = container_of(vcpu->arch.host_fpsimd_state, struct thread_struct,
-			      uw.fpsimd_state);
-
-	__sve_save_state(sve_pffr(thread), &vcpu->arch.host_fpsimd_state->fpsr);
-}
-
 static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 {
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
@@ -225,24 +215,72 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
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
 /* Check for an FPSIMD/SVE trap and handle as appropriate */
 static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 {
-	bool sve_guest, sve_host;
+	bool sve_guest;
 	u8 esr_ec;
 	u64 reg;
 
 	if (!system_supports_fpsimd())
 		return false;
 
-	if (system_supports_sve()) {
-		sve_guest = vcpu_has_sve(vcpu);
-		sve_host = vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE;
-	} else {
-		sve_guest = false;
-		sve_host = false;
-	}
-
+	sve_guest = vcpu_has_sve(vcpu);
 	esr_ec = kvm_vcpu_trap_get_class(vcpu);
 	if (esr_ec != ESR_ELx_EC_FP_ASIMD &&
 	    esr_ec != ESR_ELx_EC_SVE)
@@ -268,15 +306,7 @@ static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 	}
 	isb();
 
-	if (vcpu->arch.flags & KVM_ARM64_FP_HOST) {
-		if (sve_host)
-			__hyp_sve_save_host(vcpu);
-		else
-			__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
-
-		vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
-	}
-
+	/* Restore the guest state */
 	if (sve_guest)
 		__hyp_sve_restore_guest(vcpu);
 	else
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2da6aa8da868..a446883d5b9a 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -19,13 +19,17 @@
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
+unsigned int kvm_host_sve_max_vl;
+
 void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 
 static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
 
+	fpsimd_lazy_switch_to_guest(kern_hyp_va(vcpu));
 	cpu_reg(host_ctxt, 1) =  __kvm_vcpu_run(kern_hyp_va(vcpu));
+	fpsimd_lazy_switch_to_host(kern_hyp_va(vcpu));
 }
 
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
@@ -237,11 +241,6 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
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
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 4db5409f40c4..fff7491d8351 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -34,21 +34,46 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
 DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
 DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
-static void __activate_traps(struct kvm_vcpu *vcpu)
+static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 {
-	u64 val;
-
-	___activate_traps(vcpu);
-	__activate_traps_common(vcpu);
+	u64 val = CPTR_EL2_TAM;	/* Same bit irrespective of E2H */
 
-	val = vcpu->arch.cptr_el2;
-	val |= CPTR_EL2_TTA | CPTR_EL2_TAM;
-	if (!update_fp_enabled(vcpu)) {
-		val |= CPTR_EL2_TFP | CPTR_EL2_TZ;
+	if (!guest_owns_fp_regs(vcpu))
 		__activate_traps_fpsimd32(vcpu);
+
+	/* !hVHE case upstream */
+	if (1) {
+		val |= CPTR_EL2_TTA | CPTR_NVHE_EL2_RES1;
+
+		if (!vcpu_has_sve(vcpu) || !guest_owns_fp_regs(vcpu))
+			val |= CPTR_EL2_TZ;
+
+		if (!guest_owns_fp_regs(vcpu))
+			val |= CPTR_EL2_TFP;
+
+		write_sysreg(val, cptr_el2);
 	}
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
 
-	write_sysreg(val, cptr_el2);
 	write_sysreg(__this_cpu_read(kvm_hyp_vector), vbar_el2);
 
 	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
@@ -69,7 +94,6 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 static void __deactivate_traps(struct kvm_vcpu *vcpu)
 {
 	extern char __kvm_hyp_host_vector[];
-	u64 cptr;
 
 	___deactivate_traps(vcpu);
 
@@ -94,11 +118,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
 
-	cptr = CPTR_EL2_DEFAULT;
-	if (vcpu_has_sve(vcpu) && (vcpu->arch.flags & KVM_ARM64_FP_ENABLED))
-		cptr |= CPTR_EL2_TZ;
-
-	write_sysreg(cptr, cptr_el2);
+	__deactivate_cptr_traps(vcpu);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
 }
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 813e6e2178c1..d8a8628a9d70 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -114,6 +114,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_save_host_state_vhe(host_ctxt);
 
+	fpsimd_lazy_switch_to_guest(vcpu);
+
 	/*
 	 * ARM erratum 1165522 requires us to configure both stage 1 and
 	 * stage 2 translation for the guest context before we clear
@@ -144,6 +146,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	__deactivate_traps(vcpu);
 
+	fpsimd_lazy_switch_to_host(vcpu);
+
 	sysreg_restore_host_state_vhe(host_ctxt);
 
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED)
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5ce36b0a3343..deb205638279 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -42,11 +42,14 @@ static u32 kvm_ipa_limit;
 				 PSR_AA32_I_BIT | PSR_AA32_F_BIT)
 
 unsigned int kvm_sve_max_vl;
+unsigned int kvm_host_sve_max_vl;
 
 int kvm_arm_init_sve(void)
 {
 	if (system_supports_sve()) {
 		kvm_sve_max_vl = sve_max_virtualisable_vl;
+		kvm_host_sve_max_vl = sve_max_vl;
+		kvm_nvhe_sym(kvm_host_sve_max_vl) = kvm_host_sve_max_vl;
 
 		/*
 		 * The get_sve_reg()/set_sve_reg() ioctl interface will need
diff --git a/arch/mips/dec/prom/init.c b/arch/mips/dec/prom/init.c
index cc988bbd27fc..0880a5551d97 100644
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
diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 696b40beb774..8494466740cc 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -47,6 +47,16 @@ extern phys_addr_t __mips_cm_phys_base(void);
  */
 extern int mips_cm_is64;
 
+/*
+ * mips_cm_is_l2_hci_broken  - determine if HCI is broken
+ *
+ * Some CM reports show that Hardware Cache Initialization is
+ * complete, but in reality it's not the case. They also incorrectly
+ * indicate that Hardware Cache Initialization is supported. This
+ * flags allows warning about this broken feature.
+ */
+extern bool mips_cm_is_l2_hci_broken;
+
 /**
  * mips_cm_error_report - Report CM cache errors
  */
@@ -85,6 +95,18 @@ static inline bool mips_cm_present(void)
 #endif
 }
 
+/**
+ * mips_cm_update_property - update property from the device tree
+ *
+ * Retrieve the properties from the device tree if a CM node exist and
+ * update the internal variable based on this.
+ */
+#ifdef CONFIG_MIPS_CM
+extern void mips_cm_update_property(void);
+#else
+static inline void mips_cm_update_property(void) {}
+#endif
+
 /**
  * mips_cm_has_l2sync - determine whether an L2-only sync region is present
  *
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
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index b4f7d950c846..e21c2fd76167 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/of.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 
@@ -14,6 +15,7 @@
 void __iomem *mips_gcr_base;
 void __iomem *mips_cm_l2sync_base;
 int mips_cm_is64;
+bool mips_cm_is_l2_hci_broken;
 
 static char *cm2_tr[8] = {
 	"mem",	"gcr",	"gic",	"mmio",
@@ -238,6 +240,18 @@ static void mips_cm_probe_l2sync(void)
 	mips_cm_l2sync_base = ioremap(addr, MIPS_CM_L2SYNC_SIZE);
 }
 
+void mips_cm_update_property(void)
+{
+	struct device_node *cm_node;
+
+	cm_node = of_find_compatible_node(of_root, NULL, "mobileye,eyeq6-cm");
+	if (!cm_node)
+		return;
+	pr_info("HCI (Hardware Cache Init for the L2 cache) in GCR_L2_RAM_CONFIG from the CM3 is broken");
+	mips_cm_is_l2_hci_broken = true;
+	of_node_put(cm_node);
+}
+
 int mips_cm_probe(void)
 {
 	phys_addr_t addr;
diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index fcc761b0e11b..d20e8283c5b8 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -62,6 +62,7 @@ static unsigned long pdt_entry[MAX_PDT_ENTRIES] __page_aligned_bss;
 #define PDT_ADDR_PERM_ERR	(pdt_type != PDT_PDC ? 2UL : 0UL)
 #define PDT_ADDR_SINGLE_ERR	1UL
 
+#ifdef CONFIG_PROC_FS
 /* report PDT entries via /proc/meminfo */
 void arch_report_meminfo(struct seq_file *m)
 {
@@ -73,6 +74,7 @@ void arch_report_meminfo(struct seq_file *m)
 	seq_printf(m, "PDT_cur_entries: %7lu\n",
 			pdt_status.pdt_entries);
 }
+#endif
 
 static int get_info_pat_new(void)
 {
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index d01a0ad57e38..f2378f51cbed 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -16,6 +16,7 @@
 #include <linux/capability.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
+#include <linux/nospec.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/completion.h>
@@ -1076,6 +1077,9 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
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
index 34fbb3ea21d5..932ec2500b8a 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -60,8 +60,11 @@ static inline void syscall_get_arguments(struct task_struct *task,
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
 
 static inline void syscall_set_arguments(struct task_struct *task,
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
index 8cc147491c67..0c85b9e59ec0 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -84,6 +84,9 @@ static struct resource bss_res = { .name = "Kernel bss", };
 static struct resource elfcorehdr_res = { .name = "ELF Core hdr", };
 #endif
 
+static int num_standard_resources;
+static struct resource *standard_resources;
+
 static int __init add_resource(struct resource *parent,
 				struct resource *res)
 {
@@ -157,7 +160,7 @@ static void __init init_resources(void)
 	struct resource *res = NULL;
 	struct resource *mem_res = NULL;
 	size_t mem_res_sz = 0;
-	int num_resources = 0, res_idx = 0;
+	int num_resources = 0, res_idx = 0, non_resv_res = 0;
 	int ret = 0;
 
 	/* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
@@ -221,6 +224,7 @@ static void __init init_resources(void)
 	/* Add /memory regions to the resource tree */
 	for_each_mem_region(region) {
 		res = &mem_res[res_idx--];
+		non_resv_res++;
 
 		if (unlikely(memblock_is_nomap(region))) {
 			res->name = "Reserved";
@@ -238,6 +242,9 @@ static void __init init_resources(void)
 			goto error;
 	}
 
+	num_standard_resources = non_resv_res;
+	standard_resources = &mem_res[res_idx + 1];
+
 	/* Clean-up any unused pre-allocated resources */
 	if (res_idx >= 0)
 		memblock_free(__pa(mem_res), (res_idx + 1) * sizeof(*mem_res));
@@ -249,6 +256,33 @@ static void __init init_resources(void)
 	memblock_free(__pa(mem_res), mem_res_sz);
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
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 6f0209d45164..9c5f546a2e1a 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -56,7 +56,7 @@ TRACE_EVENT(kvm_s390_create_vcpu,
 		    __entry->sie_block = sie_block;
 		    ),
 
-	    TP_printk("create cpu %d at 0x%pK, sie block at 0x%pK",
+	    TP_printk("create cpu %d at 0x%p, sie block at 0x%p",
 		      __entry->id, __entry->vcpu, __entry->sie_block)
 	);
 
@@ -255,7 +255,7 @@ TRACE_EVENT(kvm_s390_enable_css,
 		    __entry->kvm = kvm;
 		    ),
 
-	    TP_printk("enabling channel I/O support (kvm @ %pK)\n",
+	    TP_printk("enabling channel I/O support (kvm @ %p)\n",
 		      __entry->kvm)
 	);
 
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 9a725547578e..78ee9a023529 100644
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
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index f4419afc7147..bda217961172 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -16,7 +16,7 @@
 
 SYM_FUNC_START(entry_ibpb)
 	movl	$MSR_IA32_PRED_CMD, %ecx
-	movl	$PRED_CMD_IBPB, %eax
+	movl	_ASM_RIP(x86_pred_cmd), %eax
 	xorl	%edx, %edx
 	wrmsr
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 21a9cb48daf5..99517e85325e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1101,8 +1101,10 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
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
@@ -1701,7 +1703,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
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
index ce5b27db65e1..a8dc7fe5f100 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -811,7 +811,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	 * (model = 0x14) and later actually support it.
 	 * (AMD Erratum #110, docId: 25759).
 	 */
-	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM)) {
+	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		clear_cpu_cap(c, X86_FEATURE_LAHF_LM);
 		if (!rdmsrl_amd_safe(0xc001100d, &value)) {
 			value &= ~BIT_64(32);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dfc02fb32375..75cd45f2338d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1553,7 +1553,7 @@ static void __init spec_ctrl_disable_kernel_rrsba(void)
 	rrsba_disabled = true;
 }
 
-static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_mitigation mode)
+static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation mode)
 {
 	/*
 	 * Similar to context switches, there are two types of RSB attacks
@@ -1577,27 +1577,30 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 	 */
 	switch (mode) {
 	case SPECTRE_V2_NONE:
-		return;
+		break;
 
-	case SPECTRE_V2_EIBRS_LFENCE:
 	case SPECTRE_V2_EIBRS:
+	case SPECTRE_V2_EIBRS_LFENCE:
+	case SPECTRE_V2_EIBRS_RETPOLINE:
 		if (boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB)) {
-			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 			pr_info("Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT\n");
+			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 		}
-		return;
+		break;
 
-	case SPECTRE_V2_EIBRS_RETPOLINE:
 	case SPECTRE_V2_RETPOLINE:
 	case SPECTRE_V2_LFENCE:
 	case SPECTRE_V2_IBRS:
+		pr_info("Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT\n");
+		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
-		pr_info("Spectre v2 / SpectreRSB : Filling RSB on VMEXIT\n");
-		return;
-	}
+		break;
 
-	pr_warn_once("Unknown Spectre v2 mode, disabling RSB mitigation at VM exit");
-	dump_stack();
+	default:
+		pr_warn_once("Unknown Spectre v2 mode, disabling RSB mitigation\n");
+		dump_stack();
+		break;
+	}
 }
 
 /*
@@ -1822,10 +1825,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 *
 	 * FIXME: Is this pointless for retbleed-affected AMD?
 	 */
-	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
-
-	spectre_v2_determine_rsb_fill_type_at_vmexit(mode);
+	spectre_v2_select_rsb_mitigation(mode);
 
 	/*
 	 * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205f2d5a..678289bc60b5 100644
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
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index b595a33860d7..4bb2fbe6676a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -737,7 +737,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	 * Allocating new amd_iommu_pi_data, which will get
 	 * add to the per-vcpu ir_list.
 	 */
-	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_KERNEL_ACCOUNT);
+	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!ir) {
 		ret = -ENOMEM;
 		goto out;
@@ -801,6 +801,7 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
+	bool enable_remapped_mode = true;
 	int idx, ret = 0;
 
 	if (!kvm_arch_has_assigned_device(kvm) ||
@@ -838,6 +839,8 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 		    kvm_vcpu_apicv_active(&svm->vcpu)) {
 			struct amd_iommu_pi_data pi;
 
+			enable_remapped_mode = false;
+
 			/* Try to enable guest_mode in IRTE */
 			pi.base = __sme_set(page_to_phys(svm->avic_backing_page) &
 					    AVIC_HPA_MASK);
@@ -856,33 +859,6 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 			 */
 			if (!ret && pi.is_guest_mode)
 				svm_ir_list_add(svm, &pi);
-		} else {
-			/* Use legacy mode in IRTE */
-			struct amd_iommu_pi_data pi;
-
-			/**
-			 * Here, pi is used to:
-			 * - Tell IOMMU to use legacy mode for this interrupt.
-			 * - Retrieve ga_tag of prior interrupt remapping data.
-			 */
-			pi.prev_ga_tag = 0;
-			pi.is_guest_mode = false;
-			ret = irq_set_vcpu_affinity(host_irq, &pi);
-
-			/**
-			 * Check if the posted interrupt was previously
-			 * setup with the guest_mode by checking if the ga_tag
-			 * was cached. If so, we need to clean up the per-vcpu
-			 * ir_list.
-			 */
-			if (!ret && pi.prev_ga_tag) {
-				int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
-				struct kvm_vcpu *vcpu;
-
-				vcpu = kvm_get_vcpu_by_id(kvm, id);
-				if (vcpu)
-					svm_ir_list_del(to_svm(vcpu), &pi);
-			}
 		}
 
 		if (!ret && svm) {
@@ -898,6 +874,34 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 	}
 
 	ret = 0;
+	if (enable_remapped_mode) {
+		/* Use legacy mode in IRTE */
+		struct amd_iommu_pi_data pi;
+
+		/**
+		 * Here, pi is used to:
+		 * - Tell IOMMU to use legacy mode for this interrupt.
+		 * - Retrieve ga_tag of prior interrupt remapping data.
+		 */
+		pi.prev_ga_tag = 0;
+		pi.is_guest_mode = false;
+		ret = irq_set_vcpu_affinity(host_irq, &pi);
+
+		/**
+		 * Check if the posted interrupt was previously
+		 * setup with the guest_mode by checking if the ga_tag
+		 * was cached. If so, we need to clean up the per-vcpu
+		 * ir_list.
+		 */
+		if (!ret && pi.prev_ga_tag) {
+			int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
+			struct kvm_vcpu *vcpu;
+
+			vcpu = kvm_get_vcpu_by_id(kvm, id);
+			if (vcpu)
+				svm_ir_list_del(to_svm(vcpu), &pi);
+		}
+	}
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 	return ret;
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 46fb83d6a286..4ca480ced35d 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -270,6 +270,7 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
+	bool enable_remapped_mode = true;
 	struct kvm_lapic_irq irq;
 	struct kvm_vcpu *vcpu;
 	struct vcpu_data vcpu_info;
@@ -308,21 +309,8 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,
 
 		kvm_set_msi_irq(kvm, e, &irq);
 		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
-		    !kvm_irq_is_postable(&irq)) {
-			/*
-			 * Make sure the IRTE is in remapped mode if
-			 * we don't handle it in posted mode.
-			 */
-			ret = irq_set_vcpu_affinity(host_irq, NULL);
-			if (ret < 0) {
-				printk(KERN_INFO
-				   "failed to back to remapped mode, irq: %u\n",
-				   host_irq);
-				goto out;
-			}
-
+		    !kvm_irq_is_postable(&irq))
 			continue;
-		}
 
 		vcpu_info.pi_desc_addr = __pa(&to_vmx(vcpu)->pi_desc);
 		vcpu_info.vector = irq.vector;
@@ -330,11 +318,12 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,
 		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, e->gsi,
 				vcpu_info.vector, vcpu_info.pi_desc_addr, set);
 
-		if (set)
-			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
-		else
-			ret = irq_set_vcpu_affinity(host_irq, NULL);
+		if (!set)
+			continue;
+
+		enable_remapped_mode = false;
 
+		ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
 		if (ret < 0) {
 			printk(KERN_INFO "%s: failed to update PI IRTE\n",
 					__func__);
@@ -342,6 +331,9 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,
 		}
 	}
 
+	if (enable_remapped_mode)
+		ret = irq_set_vcpu_affinity(host_irq, NULL);
+
 	ret = 0;
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 19d083ad2de7..94a23fcb2073 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -384,9 +384,9 @@ static void cond_mitigation(struct task_struct *next)
 	prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_spec);
 
 	/*
-	 * Avoid user/user BTB poisoning by flushing the branch predictor
-	 * when switching between processes. This stops one process from
-	 * doing Spectre-v2 attacks on another.
+	 * Avoid user->user BTB/RSB poisoning by flushing them when switching
+	 * between processes. This stops one process from doing Spectre-v2
+	 * attacks on another.
 	 *
 	 * Both, the conditional and the always IBPB mode use the mm
 	 * pointer to avoid the IBPB when switching between tasks of the
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 72c1e42d121d..b3e3f64d436d 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -99,7 +99,12 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
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
index 6180c680136b..e372a3fc264e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -192,6 +192,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 		blkg->pd[i] = pd;
 		pd->blkg = blkg;
 		pd->plid = i;
+		pd->online = false;
 	}
 
 	return blkg;
@@ -289,8 +290,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
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
@@ -390,8 +394,11 @@ static void blkg_destroy(struct blkcg_gq *blkg)
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
@@ -1367,6 +1374,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		blkg->pd[pol->plid] = pd;
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
+		pd->online = false;
 	}
 
 	/* all allocated, init in the same order */
@@ -1374,9 +1382,11 @@ int blkcg_activate_policy(struct request_queue *q,
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
@@ -1438,7 +1448,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 		spin_lock(&blkcg->lock);
 		if (blkg->pd[pol->plid]) {
-			if (pol->pd_offline_fn)
+			if (blkg->pd[pol->plid]->online && pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ba23562abc80..08d397f063f3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1435,8 +1435,11 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
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
diff --git a/crypto/crypto_null.c b/crypto/crypto_null.c
index 5b84b0f7cc17..337867028653 100644
--- a/crypto/crypto_null.c
+++ b/crypto/crypto_null.c
@@ -17,10 +17,10 @@
 #include <crypto/internal/skcipher.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/mm.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 
-static DEFINE_MUTEX(crypto_default_null_skcipher_lock);
+static DEFINE_SPINLOCK(crypto_default_null_skcipher_lock);
 static struct crypto_sync_skcipher *crypto_default_null_skcipher;
 static int crypto_default_null_skcipher_refcnt;
 
@@ -152,23 +152,32 @@ MODULE_ALIAS_CRYPTO("cipher_null");
 
 struct crypto_sync_skcipher *crypto_get_default_null_skcipher(void)
 {
+	struct crypto_sync_skcipher *ntfm = NULL;
 	struct crypto_sync_skcipher *tfm;
 
-	mutex_lock(&crypto_default_null_skcipher_lock);
+	spin_lock_bh(&crypto_default_null_skcipher_lock);
 	tfm = crypto_default_null_skcipher;
 
 	if (!tfm) {
-		tfm = crypto_alloc_sync_skcipher("ecb(cipher_null)", 0, 0);
-		if (IS_ERR(tfm))
-			goto unlock;
-
-		crypto_default_null_skcipher = tfm;
+		spin_unlock_bh(&crypto_default_null_skcipher_lock);
+
+		ntfm = crypto_alloc_sync_skcipher("ecb(cipher_null)", 0, 0);
+		if (IS_ERR(ntfm))
+			return ntfm;
+
+		spin_lock_bh(&crypto_default_null_skcipher_lock);
+		tfm = crypto_default_null_skcipher;
+		if (!tfm) {
+			tfm = ntfm;
+			ntfm = NULL;
+			crypto_default_null_skcipher = tfm;
+		}
 	}
 
 	crypto_default_null_skcipher_refcnt++;
+	spin_unlock_bh(&crypto_default_null_skcipher_lock);
 
-unlock:
-	mutex_unlock(&crypto_default_null_skcipher_lock);
+	crypto_free_sync_skcipher(ntfm);
 
 	return tfm;
 }
@@ -176,12 +185,16 @@ EXPORT_SYMBOL_GPL(crypto_get_default_null_skcipher);
 
 void crypto_put_default_null_skcipher(void)
 {
-	mutex_lock(&crypto_default_null_skcipher_lock);
+	struct crypto_sync_skcipher *tfm = NULL;
+
+	spin_lock_bh(&crypto_default_null_skcipher_lock);
 	if (!--crypto_default_null_skcipher_refcnt) {
-		crypto_free_sync_skcipher(crypto_default_null_skcipher);
+		tfm = crypto_default_null_skcipher;
 		crypto_default_null_skcipher = NULL;
 	}
-	mutex_unlock(&crypto_default_null_skcipher_lock);
+	spin_unlock_bh(&crypto_default_null_skcipher_lock);
+
+	crypto_free_sync_skcipher(tfm);
 }
 EXPORT_SYMBOL_GPL(crypto_put_default_null_skcipher);
 
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
 
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index fe69dc518f31..9fa339639d0c 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -217,7 +217,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 	node_entry = ACPI_PTR_DIFF(node, table_hdr);
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	while ((unsigned long)entry + proc_sz < table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
@@ -258,7 +258,7 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	table_end = (unsigned long)table_hdr + table_hdr->length;
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
 	while ((unsigned long)entry + proc_sz < table_end) {
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ff5f83c5af00..408a25956f6e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -595,6 +595,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 10742d72f44f..f0b690b39bf7 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1479,8 +1479,15 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
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
index 41430f79663c..3502bfb03c56 100644
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
index c95685f693a6..20b73e0d835a 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -308,15 +308,9 @@ static inline void pdc20621_ata_sg(u8 *buf, unsigned int portno,
 	/* output ATA packet S/G table */
 	addr = PDC_20621_DIMM_BASE + PDC_20621_DIMM_DATA +
 	       (PDC_DIMM_DATA_STEP * portno);
-	VPRINTK("ATA sg addr 0x%x, %d\n", addr, addr);
+
 	buf32[dw] = cpu_to_le32(addr);
 	buf32[dw + 1] = cpu_to_le32(total_len | ATA_PRD_EOT);
-
-	VPRINTK("ATA PSG @ %x == (0x%x, 0x%x)\n",
-		PDC_20621_DIMM_BASE +
-		       (PDC_DIMM_WINDOW_STEP * portno) +
-		       PDC_DIMM_APKT_PRD,
-		buf32[dw], buf32[dw + 1]);
 }
 
 static inline void pdc20621_host_sg(u8 *buf, unsigned int portno,
@@ -332,12 +326,6 @@ static inline void pdc20621_host_sg(u8 *buf, unsigned int portno,
 
 	buf32[dw] = cpu_to_le32(addr);
 	buf32[dw + 1] = cpu_to_le32(total_len | ATA_PRD_EOT);
-
-	VPRINTK("HOST PSG @ %x == (0x%x, 0x%x)\n",
-		PDC_20621_DIMM_BASE +
-		       (PDC_DIMM_WINDOW_STEP * portno) +
-		       PDC_DIMM_HPKT_PRD,
-		buf32[dw], buf32[dw + 1]);
 }
 
 static inline unsigned int pdc20621_ata_pkt(struct ata_taskfile *tf,
@@ -351,7 +339,6 @@ static inline unsigned int pdc20621_ata_pkt(struct ata_taskfile *tf,
 	unsigned int dimm_sg = PDC_20621_DIMM_BASE +
 			       (PDC_DIMM_WINDOW_STEP * portno) +
 			       PDC_DIMM_APKT_PRD;
-	VPRINTK("ENTER, dimm_sg == 0x%x, %d\n", dimm_sg, dimm_sg);
 
 	i = PDC_DIMM_ATA_PKT;
 
@@ -406,8 +393,6 @@ static inline void pdc20621_host_pkt(struct ata_taskfile *tf, u8 *buf,
 	unsigned int dimm_sg = PDC_20621_DIMM_BASE +
 			       (PDC_DIMM_WINDOW_STEP * portno) +
 			       PDC_DIMM_HPKT_PRD;
-	VPRINTK("ENTER, dimm_sg == 0x%x, %d\n", dimm_sg, dimm_sg);
-	VPRINTK("host_sg == 0x%x, %d\n", host_sg, host_sg);
 
 	dw = PDC_DIMM_HOST_PKT >> 2;
 
@@ -424,14 +409,6 @@ static inline void pdc20621_host_pkt(struct ata_taskfile *tf, u8 *buf,
 	buf32[dw + 1] = cpu_to_le32(host_sg);
 	buf32[dw + 2] = cpu_to_le32(dimm_sg);
 	buf32[dw + 3] = 0;
-
-	VPRINTK("HOST PKT @ %x == (0x%x 0x%x 0x%x 0x%x)\n",
-		PDC_20621_DIMM_BASE + (PDC_DIMM_WINDOW_STEP * portno) +
-			PDC_DIMM_HOST_PKT,
-		buf32[dw + 0],
-		buf32[dw + 1],
-		buf32[dw + 2],
-		buf32[dw + 3]);
 }
 
 static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
@@ -447,8 +424,6 @@ static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 
 	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
 
-	VPRINTK("ata%u: ENTER\n", ap->print_id);
-
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
@@ -492,7 +467,8 @@ static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 
 	readl(dimm_mmio);	/* MMIO PCI posting flush */
 
-	VPRINTK("ata pkt buf ofs %u, prd size %u, mmio copied\n", i, sgt_len);
+	ata_port_dbg(ap, "ata pkt buf ofs %u, prd size %u, mmio copied\n",
+		     i, sgt_len);
 }
 
 static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
@@ -504,8 +480,6 @@ static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
 	unsigned int portno = ap->port_no;
 	unsigned int i;
 
-	VPRINTK("ata%u: ENTER\n", ap->print_id);
-
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
@@ -527,7 +501,7 @@ static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
 
 	readl(dimm_mmio);	/* MMIO PCI posting flush */
 
-	VPRINTK("ata pkt buf ofs %u, mmio copied\n", i);
+	ata_port_dbg(ap, "ata pkt buf ofs %u, mmio copied\n", i);
 }
 
 static enum ata_completion_errors pdc20621_qc_prep(struct ata_queued_cmd *qc)
@@ -633,8 +607,6 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
-	VPRINTK("ata%u: ENTER\n", ap->print_id);
-
 	wmb();			/* flush PRD, pkt writes */
 
 	port_ofs = PDC_20621_DIMM_BASE + (PDC_DIMM_WINDOW_STEP * port_no);
@@ -645,7 +617,7 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 
 		pdc20621_dump_hdma(qc);
 		pdc20621_push_hdma(qc, seq, port_ofs + PDC_DIMM_HOST_PKT);
-		VPRINTK("queued ofs 0x%x (%u), seq %u\n",
+		ata_port_dbg(ap, "queued ofs 0x%x (%u), seq %u\n",
 			port_ofs + PDC_DIMM_HOST_PKT,
 			port_ofs + PDC_DIMM_HOST_PKT,
 			seq);
@@ -656,7 +628,7 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 		writel(port_ofs + PDC_DIMM_ATA_PKT,
 		       ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
 		readl(ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
-		VPRINTK("submitted ofs 0x%x (%u), seq %u\n",
+		ata_port_dbg(ap, "submitted ofs 0x%x (%u), seq %u\n",
 			port_ofs + PDC_DIMM_ATA_PKT,
 			port_ofs + PDC_DIMM_ATA_PKT,
 			seq);
@@ -696,14 +668,12 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 	u8 status;
 	unsigned int handled = 0;
 
-	VPRINTK("ENTER\n");
-
 	if ((qc->tf.protocol == ATA_PROT_DMA) &&	/* read */
 	    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
 
 		/* step two - DMA from DIMM to host */
 		if (doing_hdma) {
-			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "read hdma, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
@@ -714,7 +684,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 		/* step one - exec ATA command */
 		else {
 			u8 seq = (u8) (port_no + 1 + 4);
-			VPRINTK("ata%u: read ata, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "read ata, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 
 			/* submit hdma pkt */
@@ -729,7 +699,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 		/* step one - DMA from host to DIMM */
 		if (doing_hdma) {
 			u8 seq = (u8) (port_no + 1);
-			VPRINTK("ata%u: write hdma, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "write hdma, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 
 			/* submit ata pkt */
@@ -742,7 +712,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 
 		/* step two - execute ATA command */
 		else {
-			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "write ata, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
@@ -755,7 +725,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 	} else if (qc->tf.protocol == ATA_PROT_NODATA) {
 
 		status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
+		ata_port_dbg(ap, "BUS_NODATA (drv_stat 0x%X)\n", status);
 		qc->err_mask |= ac_err_mask(status);
 		ata_qc_complete(qc);
 		handled = 1;
@@ -781,29 +751,21 @@ static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
 	unsigned int handled = 0;
 	void __iomem *mmio_base;
 
-	VPRINTK("ENTER\n");
-
-	if (!host || !host->iomap[PDC_MMIO_BAR]) {
-		VPRINTK("QUICK EXIT\n");
+	if (!host || !host->iomap[PDC_MMIO_BAR])
 		return IRQ_NONE;
-	}
 
 	mmio_base = host->iomap[PDC_MMIO_BAR];
 
 	/* reading should also clear interrupts */
 	mmio_base += PDC_CHIP0_OFS;
 	mask = readl(mmio_base + PDC_20621_SEQMASK);
-	VPRINTK("mask == 0x%x\n", mask);
 
-	if (mask == 0xffffffff) {
-		VPRINTK("QUICK EXIT 2\n");
+	if (mask == 0xffffffff)
 		return IRQ_NONE;
-	}
+
 	mask &= 0xffff;		/* only 16 tags possible */
-	if (!mask) {
-		VPRINTK("QUICK EXIT 3\n");
+	if (!mask)
 		return IRQ_NONE;
-	}
 
 	spin_lock(&host->lock);
 
@@ -816,7 +778,8 @@ static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
 		else
 			ap = host->ports[port_no];
 		tmp = mask & (1 << i);
-		VPRINTK("seq %u, port_no %u, ap %p, tmp %x\n", i, port_no, ap, tmp);
+		if (ap)
+			ata_port_dbg(ap, "seq %u, tmp %x\n", i, tmp);
 		if (tmp && ap) {
 			struct ata_queued_cmd *qc;
 
@@ -829,10 +792,6 @@ static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("mask == 0x%x\n", mask);
-
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(handled);
 }
 
@@ -1165,9 +1124,14 @@ static int pdc20621_prog_dimm0(struct ata_host *host)
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
@@ -1272,7 +1236,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	/* Initialize Time Period Register */
 	writel(0xffffffff, mmio + PDC_TIME_PERIOD);
 	time_period = readl(mmio + PDC_TIME_PERIOD);
-	VPRINTK("Time Period Register (0x40): 0x%x\n", time_period);
+	dev_dbg(host->dev, "Time Period Register (0x40): 0x%x\n", time_period);
 
 	/* Enable timer */
 	writel(PDC_TIMER_DEFAULT, mmio + PDC_TIME_CONTROL);
@@ -1287,7 +1251,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	*/
 
 	tcount = readl(mmio + PDC_TIME_COUNTER);
-	VPRINTK("Time Counter Register (0x44): 0x%x\n", tcount);
+	dev_dbg(host->dev, "Time Counter Register (0x44): 0x%x\n", tcount);
 
 	/*
 	   If SX4 is on PCI-X bus, after 3 seconds, the timer counter
@@ -1295,17 +1259,19 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	*/
 	if (tcount >= PCI_X_TCOUNT) {
 		ticks = (time_period - tcount);
-		VPRINTK("Num counters 0x%x (%d)\n", ticks, ticks);
+		dev_dbg(host->dev, "Num counters 0x%x (%d)\n", ticks, ticks);
 
 		clock = (ticks / 300000);
-		VPRINTK("10 * Internal clk = 0x%x (%d)\n", clock, clock);
+		dev_dbg(host->dev, "10 * Internal clk = 0x%x (%d)\n",
+			clock, clock);
 
 		clock = (clock * 33);
-		VPRINTK("10 * Internal clk * 33 = 0x%x (%d)\n", clock, clock);
+		dev_dbg(host->dev, "10 * Internal clk * 33 = 0x%x (%d)\n",
+			clock, clock);
 
 		/* PLL F Param (bit 22:16) */
 		fparam = (1400000 / clock) - 2;
-		VPRINTK("PLL F Param: 0x%x (%d)\n", fparam, fparam);
+		dev_dbg(host->dev, "PLL F Param: 0x%x (%d)\n", fparam, fparam);
 
 		/* OD param = 0x2 (bit 31:30), R param = 0x5 (bit 29:25) */
 		pci_status = (0x8a001824 | (fparam << 16));
@@ -1313,7 +1279,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 		pci_status = PCI_PLL_INIT;
 
 	/* Initialize PLL. */
-	VPRINTK("pci_status: 0x%x\n", pci_status);
+	dev_dbg(host->dev, "pci_status: 0x%x\n", pci_status);
 	writel(pci_status, mmio + PDC_CTL_STATUS);
 	readl(mmio + PDC_CTL_STATUS);
 
@@ -1325,15 +1291,18 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 		printk(KERN_ERR "Detect Local DIMM Fail\n");
 		return 1;	/* DIMM error */
 	}
-	VPRINTK("Local DIMM Speed = %d\n", speed);
+	dev_dbg(host->dev, "Local DIMM Speed = %d\n", speed);
 
 	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
 	size = pdc20621_prog_dimm0(host);
-	VPRINTK("Local DIMM Size = %dMB\n", size);
+	if (size < 0)
+		return size;
+	dev_dbg(host->dev, "Local DIMM Size = %dMB\n", size);
 
 	/* Programming DIMM Module Global Control Register (index_CID0:88h) */
 	if (pdc20621_prog_dimm_global(host)) {
-		printk(KERN_ERR "Programming DIMM Module Global Control Register Fail\n");
+		dev_err(host->dev,
+			"Programming DIMM Module Global Control Register Fail\n");
 		return 1;
 	}
 
@@ -1370,13 +1339,14 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 
 	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
 			       PDC_DIMM_SPD_TYPE, &spd0)) {
-		pr_err("Failed in i2c read: device=%#x, subaddr=%#x\n",
+		dev_err(host->dev,
+			"Failed in i2c read: device=%#x, subaddr=%#x\n",
 		       PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
 		return 1;
 	}
 	if (spd0 == 0x02) {
 		void *buf;
-		VPRINTK("Start ECC initialization\n");
+		dev_dbg(host->dev, "Start ECC initialization\n");
 		addr = 0;
 		length = size * 1024 * 1024;
 		buf = kzalloc(ECC_ERASE_BUF_SZ, GFP_KERNEL);
@@ -1388,7 +1358,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 			addr += ECC_ERASE_BUF_SZ;
 		}
 		kfree(buf);
-		VPRINTK("Finish ECC initialization\n");
+		dev_dbg(host->dev, "Finish ECC initialization\n");
 	}
 	return 0;
 }
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index d56a5d508ccd..8b690f59df27 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -313,13 +313,13 @@ static int hd44780_probe(struct platform_device *pdev)
 fail3:
 	kfree(hd);
 fail2:
-	kfree(lcd);
+	charlcd_free(lcd);
 fail1:
 	kfree(hdc);
 	return ret;
 }
 
-static int hd44780_remove(struct platform_device *pdev)
+static void hd44780_remove(struct platform_device *pdev)
 {
 	struct charlcd *lcd = platform_get_drvdata(pdev);
 	struct hd44780_common *hdc = lcd->drvdata;
@@ -328,8 +328,7 @@ static int hd44780_remove(struct platform_device *pdev)
 	kfree(hdc->hd44780);
 	kfree(lcd->drvdata);
 
-	kfree(lcd);
-	return 0;
+	charlcd_free(lcd);
 }
 
 static const struct of_device_id hd44780_of_match[] = {
@@ -340,7 +339,7 @@ MODULE_DEVICE_TABLE(of, hd44780_of_match);
 
 static struct platform_driver hd44780_driver = {
 	.probe = hd44780_probe,
-	.remove = hd44780_remove,
+	.remove_new = hd44780_remove,
 	.driver		= {
 		.name	= "hd44780",
 		.of_match_table = hd44780_of_match,
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index d3f59028dec7..58e8e2be26ac 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -682,6 +682,13 @@ int devres_release_group(struct device *dev, void *id)
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
index 1d60d5ac0db8..a612370dd9ec 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -605,7 +605,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
-	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
 
 	if (rw == WRITE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
@@ -792,19 +792,20 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
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
 
@@ -1316,8 +1317,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART;
 
-	/* enable and uncork uevent now that we are done */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 
 	loop_global_unlock(lo, is_loop);
 	if (partscan)
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1f8afa0244d8..1918e60caa91 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -677,6 +677,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			rtl_dev_err(hdev, "mandatory config file %s not found",
 				    btrtl_dev->ic_info->cfg_name);
 			ret = btrtl_dev->cfg_len;
+			if (!ret)
+				ret = -EINVAL;
 			goto err_free;
 		}
 	}
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index be51528afed9..4692b9bec469 100644
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
@@ -579,7 +582,8 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
 	if (tty != hu->tty)
 		return;
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+	    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		hci_uart_tx_wakeup(hu);
 }
 
@@ -605,7 +609,8 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return;
 	}
@@ -706,12 +711,16 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
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
index 1cb7c60594f1..c83a3875fbc5 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1192,11 +1192,16 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
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
 
@@ -1214,10 +1219,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 
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
@@ -1234,9 +1237,10 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
 	mhi_add_ring_element(mhi_cntrl, buf_ring);
 
+out:
 	write_unlock_bh(&mhi_chan->lock);
 
-	return 0;
+	return ret;
 }
 
 int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a5d38fdc2589..b0681cc9af7e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1614,8 +1614,8 @@ static void handle_control_message(struct virtio_device *vdev,
 		break;
 	case VIRTIO_CONSOLE_RESIZE: {
 		struct {
-			__u16 rows;
-			__u16 cols;
+			__virtio16 rows;
+			__virtio16 cols;
 		} size;
 
 		if (!is_console_port(port))
@@ -1623,7 +1623,8 @@ static void handle_control_message(struct virtio_device *vdev,
 
 		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
 		       sizeof(size));
-		set_console_size(port, size.rows, size.cols);
+		set_console_size(port, virtio16_to_cpu(vdev, size.rows),
+				 virtio16_to_cpu(vdev, size.cols));
 
 		port->cons.hvc->irq_requested = 1;
 		resize_console(port);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index dc2bcf58fc10..13f7e2ea644d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4993,6 +4993,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
 
+	/* Check if node in clkspec is in disabled/fail state */
+	if (!of_device_is_available(clkspec->np))
+		return ERR_PTR(-ENOENT);
+
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np) {
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
diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index f963080dd61f..8ef13f5baf07 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -88,6 +88,7 @@ struct jr3_pci_poll_delay {
 struct jr3_pci_dev_private {
 	struct timer_list timer;
 	struct comedi_device *dev;
+	bool timer_enable;
 };
 
 union jr3_pci_single_range {
@@ -597,10 +598,11 @@ static void jr3_pci_poll_dev(struct timer_list *t)
 				delay = sub_delay.max;
 		}
 	}
+	if (devpriv->timer_enable) {
+		devpriv->timer.expires = jiffies + msecs_to_jiffies(delay);
+		add_timer(&devpriv->timer);
+	}
 	spin_unlock_irqrestore(&dev->spinlock, flags);
-
-	devpriv->timer.expires = jiffies + msecs_to_jiffies(delay);
-	add_timer(&devpriv->timer);
 }
 
 static struct jr3_pci_subdev_private *
@@ -749,6 +751,7 @@ static int jr3_pci_auto_attach(struct comedi_device *dev,
 	devpriv->dev = dev;
 	timer_setup(&devpriv->timer, jr3_pci_poll_dev, 0);
 	devpriv->timer.expires = jiffies + msecs_to_jiffies(1000);
+	devpriv->timer_enable = true;
 	add_timer(&devpriv->timer);
 
 	return 0;
@@ -758,8 +761,12 @@ static void jr3_pci_detach(struct comedi_device *dev)
 {
 	struct jr3_pci_dev_private *devpriv = dev->private;
 
-	if (devpriv)
-		del_timer_sync(&devpriv->timer);
+	if (devpriv) {
+		spin_lock_bh(&dev->spinlock);
+		devpriv->timer_enable = false;
+		spin_unlock_bh(&dev->spinlock);
+		timer_delete_sync(&devpriv->timer);
+	}
 
 	comedi_pci_detach(dev);
 }
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 17cfa2b92eee..c5a4aa0c2c9a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -620,7 +620,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	int ret;
 
 	if (!policy)
-		return -ENODEV;
+		return 0;
 
 	cpu_data = policy->driver_data;
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a7bbe6f28b54..2c98ddf2c8db 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2654,10 +2654,18 @@ EXPORT_SYMBOL(cpufreq_update_policy);
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
 
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index eb3f1952f986..8c9c2f710790 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -32,11 +32,17 @@ static const struct scmi_perf_proto_ops *perf_ops;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scmi_data *priv = policy->driver_data;
+	struct cpufreq_policy *policy;
+	struct scmi_data *priv;
 	unsigned long rate;
 	int ret;
 
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+
 	ret = perf_ops->freq_get(ph, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 35b20c74dbfc..f111f1f3bf38 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -37,9 +37,16 @@ static struct scpi_ops *scpi_ops;
 
 static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scpi_data *priv = policy->driver_data;
-	unsigned long rate = clk_get_rate(priv->clk);
+	struct cpufreq_policy *policy;
+	struct scpi_data *priv;
+	unsigned long rate;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+	rate = clk_get_rate(priv->clk);
 
 	return rate / 1000;
 }
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index c96c14e7dab1..0ef92109ce22 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -107,7 +107,12 @@ static int atmel_sha204a_probe(struct i2c_client *client,
 
 	i2c_priv->hwrng.name = dev_name(&client->dev);
 	i2c_priv->hwrng.read = atmel_sha204a_rng_read;
-	i2c_priv->hwrng.quality = 1024;
+
+	/*
+	 * According to review by Bill Cox [1], this HWRNG has very low entropy.
+	 * [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
+	 */
+	i2c_priv->hwrng.quality = 1;
 
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
 	if (ret)
diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index 2c52bf7d31ea..d450708e07d6 100644
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
index 9470a9a19f29..f9178821023d 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -118,14 +118,17 @@ static bool sp_pci_is_master(struct sp_device *sp)
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
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index a8094d57d2d0..84f7611c765b 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -186,7 +186,7 @@ static long udmabuf_create(struct miscdevice *device,
 	if (!ubuf)
 		return -ENOMEM;
 
-	pglimit = (size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
+	pglimit = ((u64)size_limit_mb * 1024 * 1024) >> PAGE_SHIFT;
 	for (i = 0; i < head->count; i++) {
 		if (!IS_ALIGNED(list[i].offset, PAGE_SIZE))
 			goto err;
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index f696246f57fd..0d8d01673010 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -828,9 +828,9 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_freezable_timeout(thread->done_wait,
-					done->done,
-					msecs_to_jiffies(params->timeout));
+			wait_event_timeout(thread->done_wait,
+					   done->done,
+					   msecs_to_jiffies(params->timeout));
 
 			status = dma_async_is_tx_complete(chan, cookie, NULL,
 							  NULL);
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 00762de3d409..da310b20fad0 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -81,6 +81,8 @@ struct tegra_gpio {
 	unsigned int *irq;
 
 	const struct tegra_gpio_soc *soc;
+	unsigned int num_irqs_per_bank;
+	unsigned int num_banks;
 
 	void __iomem *secure;
 	void __iomem *base;
@@ -600,12 +602,35 @@ static void tegra186_gpio_init_route_mapping(struct tegra_gpio *gpio)
 	}
 }
 
+static unsigned int tegra186_gpio_irqs_per_bank(struct tegra_gpio *gpio)
+{
+	struct device *dev = gpio->gpio.parent;
+
+	if (gpio->num_irq > gpio->num_banks) {
+		if (gpio->num_irq % gpio->num_banks != 0)
+			goto error;
+	}
+
+	if (gpio->num_irq < gpio->num_banks)
+		goto error;
+
+	gpio->num_irqs_per_bank = gpio->num_irq / gpio->num_banks;
+
+	return 0;
+
+error:
+	dev_err(dev, "invalid number of interrupts (%u) for %u banks\n",
+		gpio->num_irq, gpio->num_banks);
+	return -EINVAL;
+}
+
 static int tegra186_gpio_probe(struct platform_device *pdev)
 {
 	unsigned int i, j, offset;
 	struct gpio_irq_chip *irq;
 	struct tegra_gpio *gpio;
 	struct device_node *np;
+	struct resource *res;
 	char **names;
 	int err;
 
@@ -614,20 +639,30 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gpio->soc = device_get_match_data(&pdev->dev);
+	gpio->gpio.label = gpio->soc->name;
+	gpio->gpio.parent = &pdev->dev;
 
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
+	/* count the number of banks in the controller */
+	for (i = 0; i < gpio->soc->num_ports; i++)
+		if (gpio->soc->ports[i].bank > gpio->num_banks)
+			gpio->num_banks = gpio->soc->ports[i].bank;
+
+	gpio->num_banks++;
+
+	/* get register apertures */
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
@@ -635,6 +670,10 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 
 	gpio->num_irq = err;
 
+	err = tegra186_gpio_irqs_per_bank(gpio);
+	if (err < 0)
+		return err;
+
 	gpio->irq = devm_kcalloc(&pdev->dev, gpio->num_irq, sizeof(*gpio->irq),
 				 GFP_KERNEL);
 	if (!gpio->irq)
@@ -648,9 +687,6 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 		gpio->irq[i] = err;
 	}
 
-	gpio->gpio.label = gpio->soc->name;
-	gpio->gpio.parent = &pdev->dev;
-
 	gpio->gpio.request = gpiochip_generic_request;
 	gpio->gpio.free = gpiochip_generic_free;
 	gpio->gpio.get_direction = tegra186_gpio_get_direction;
@@ -714,7 +750,30 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	irq->parent_handler = tegra186_gpio_irq;
 	irq->parent_handler_data = gpio;
 	irq->num_parents = gpio->num_irq;
-	irq->parents = gpio->irq;
+
+	/*
+	 * To simplify things, use a single interrupt per bank for now. Some
+	 * chips support up to 8 interrupts per bank, which can be useful to
+	 * distribute the load and decrease the processing latency for GPIOs
+	 * but it also requires a more complicated interrupt routing than we
+	 * currently program.
+	 */
+	if (gpio->num_irqs_per_bank > 1) {
+		irq->parents = devm_kcalloc(&pdev->dev, gpio->num_banks,
+					    sizeof(*irq->parents), GFP_KERNEL);
+		if (!irq->parents)
+			return -ENOMEM;
+
+		for (i = 0; i < gpio->num_banks; i++)
+			irq->parents[i] = gpio->irq[i * gpio->num_irqs_per_bank];
+
+		irq->num_parents = gpio->num_banks;
+	} else {
+		irq->num_parents = gpio->num_irq;
+		irq->parents = gpio->irq;
+	}
+
+	tegra186_gpio_init_route_mapping(gpio);
 
 	np = of_find_matching_node(NULL, tegra186_pmc_of_match);
 	if (np) {
@@ -725,8 +784,6 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 			return -EPROBE_DEFER;
 	}
 
-	tegra186_gpio_init_route_mapping(gpio);
-
 	irq->map = devm_kcalloc(&pdev->dev, gpio->gpio.ngpio,
 				sizeof(*irq->map), GFP_KERNEL);
 	if (!irq->map)
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
index b11a98bee4f0..6ed4b1ffa4c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4008,8 +4008,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
-	amdgpu_fence_driver_sw_fini(adev);
 	amdgpu_device_ip_fini(adev);
+	amdgpu_fence_driver_sw_fini(adev);
 	release_firmware(adev->firmware.gpu_info_fw);
 	adev->firmware.gpu_info_fw = NULL;
 	adev->accel_working = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 7444484a12bf..fe94d35fcb45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -225,7 +225,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	if (sgt->sgl->page_link) {
+	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 9f7450a8d004..6d1516c357f5 100644
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
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 34c466e8eee9..7b2111be3019 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -191,6 +191,11 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
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
@@ -395,6 +400,11 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 243dd1efcdbf..7a298158ed11 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -384,7 +384,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
 				pqm->process->pasid,
 				pqn->q->properties.queue_id, retval);
-			if (retval != -ETIME)
+			if (retval != -ETIME && retval != -EIO)
 				goto err_destroy_queue;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a33ca712a89c..25e1908b2fd3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2590,16 +2590,16 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	for (k = 0; k < dc_state->stream_count; k++) {
 		bundle->stream_update.stream = dc_state->streams[k];
 
-		for (m = 0; m < dc_state->stream_status->plane_count; m++) {
+		for (m = 0; m < dc_state->stream_status[k].plane_count; m++) {
 			bundle->surface_updates[m].surface =
-				dc_state->stream_status->plane_states[m];
+				dc_state->stream_status[k].plane_states[m];
 			bundle->surface_updates[m].surface->force_full_update =
 				true;
 		}
 
 		update_planes_and_stream_adapter(dm->dc,
 					 UPDATE_TYPE_FULL,
-					 dc_state->stream_status->plane_count,
+					 dc_state->stream_status[k].plane_count,
 					 dc_state->streams[k],
 					 &bundle->stream_update,
 					 bundle->surface_updates);
@@ -4321,17 +4321,17 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	}
 #endif
 
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
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b727bd7e039d..6696372b82f4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -79,7 +79,7 @@ static void dc_link_destruct(struct dc_link *link)
 	if (link->panel_cntl)
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 
-	if (link->link_enc) {
+	if (link->link_enc && !link->is_dig_mapping_flexible) {
 		/* Update link encoder resource tracking variables. These are used for
 		 * the dynamic assignment of link encoders to streams. Virtual links
 		 * are not assigned encoder resources on creation.
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index bc603c8af3b6..b31c31c39783 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1838,20 +1838,11 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
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
@@ -1859,13 +1850,18 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
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
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 7c5c1414b7a1..257ab8820c7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1852,7 +1852,7 @@ static struct link_encoder *dcn21_link_encoder_create(
 		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc21)
+	if (!enc21 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 81547178a934..30716b88136c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -784,6 +784,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			stream = dc->current_state->streams[0];
 			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
 
+			if (!stream || !plane)
+				return false;
+
 			if (stream && plane) {
 				cursor_cache_enable = stream->cursor_position.enable &&
 						plane->address.grph.cursor_cache_addr.quad_part;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
index 127055044cf1..faab14e343a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
@@ -44,7 +44,7 @@ void hubp31_set_unbounded_requesting(struct hubp *hubp, bool enable)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	REG_UPDATE(DCHUBP_CNTL, HUBP_UNBOUNDED_REQ_MODE, enable);
-	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, enable);
+	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, 1);
 }
 
 void hubp31_soft_reset(struct hubp *hubp, bool reset)
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
index 082f01893f3d..a6df00aa5767 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1278,6 +1278,9 @@ static int arcturus_set_fan_speed_rpm(struct smu_context *smu,
 	uint32_t crystal_clock_freq = 2500;
 	uint32_t tach_period;
 
+	if (!speed || speed > UINT_MAX/8)
+		return -EINVAL;
+
 	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
 	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT,
 		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 7671a8b3c195..7524427b044f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1154,7 +1154,7 @@ int smu_v13_0_set_fan_speed_rpm(struct smu_context *smu,
 	int ret;
 	uint32_t tach_period, crystal_clock_freq;
 
-	if (!speed)
+	if (!speed || speed > UINT_MAX/8)
 		return -EINVAL;
 
 	ret = smu_v13_0_auto_fan_control(smu, 0);
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 2c3883d79f53..bd01d925769d 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1279,7 +1279,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		DRM_DEBUG_ATOMIC("modeset on [ENCODER:%d:%s]\n",
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
index bf90a5be956f..6fc9d638ccd2 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -166,10 +166,10 @@ static const struct dmi_system_id orientation_data[] = {
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
@@ -235,6 +235,12 @@ static const struct dmi_system_id orientation_data[] = {
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
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index eb99441e0ada..42cb3ad04d89 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -983,8 +983,13 @@ int intel_engines_init(struct intel_gt *gt)
 			return err;
 
 		err = setup(engine);
-		if (err)
+		if (err) {
+			intel_engine_cleanup_common(engine);
 			return err;
+		}
+
+		/* The backend should now be responsible for cleanup */
+		GEM_BUG_ON(engine->release == NULL);
 
 		err = engine_init_common(engine);
 		if (err)
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 94c6bd3b0082..9518672dc21b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -389,6 +389,7 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 
 	mtk_dpi_disable(dpi);
 	clk_disable_unprepare(dpi->pixel_clk);
+	clk_disable_unprepare(dpi->tvd_clk);
 	clk_disable_unprepare(dpi->engine_clk);
 }
 
@@ -405,6 +406,12 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
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
@@ -414,6 +421,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 	return 0;
 
 err_pixel:
+	clk_disable_unprepare(dpi->tvd_clk);
+err_engine:
 	clk_disable_unprepare(dpi->engine_clk);
 err_refcount:
 	dpi->refcount--;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx.xml.h b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
index a3cb3d988ba4..5b1adda08d05 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
@@ -1354,6 +1354,10 @@ static inline uint32_t REG_A6XX_RBBM_PERFCTR_RBBM_SEL(uint32_t i0) { return 0x00
 
 #define REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL			0x00000011
 
+#define REG_A6XX_RBBM_GBIF_HALT					0x00000016
+
+#define REG_A6XX_RBBM_GBIF_HALT_ACK				0x00000017
+
 #define REG_A6XX_RBBM_WAIT_FOR_GPU_IDLE_CMD			0x0000001c
 #define A6XX_RBBM_WAIT_FOR_GPU_IDLE_CMD_WAIT_GPU_IDLE		0x00000001
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 8b6fc1b26f04..f1daa923f346 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -869,9 +869,50 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
 		(val & 1), 100, 1000);
 }
 
+#define GBIF_CLIENT_HALT_MASK             BIT(0)
+#define GBIF_ARB_HALT_MASK                BIT(1)
+
+static void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu,
+		bool gx_off)
+{
+	struct msm_gpu *gpu = &adreno_gpu->base;
+
+	if (!a6xx_has_gbif(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0xf);
+		spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) &
+								0xf) == 0xf);
+		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0);
+
+		return;
+	}
+
+	if (gx_off) {
+		/* Halt the gx side of GBIF */
+		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 1);
+		spin_until(gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT_ACK) & 1);
+	}
+
+	/* Halt new client requests on GBIF */
+	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_CLIENT_HALT_MASK);
+	spin_until((gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK) &
+			(GBIF_CLIENT_HALT_MASK)) == GBIF_CLIENT_HALT_MASK);
+
+	/* Halt all AXI requests on GBIF */
+	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_ARB_HALT_MASK);
+	spin_until((gpu_read(gpu,  REG_A6XX_GBIF_HALT_ACK) &
+			(GBIF_ARB_HALT_MASK)) == GBIF_ARB_HALT_MASK);
+
+	/* The GBIF halt needs to be explicitly cleared */
+	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
+}
+
 /* Force the GMU off in case it isn't responsive */
 static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 {
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
+
 	/* Flush all the queues */
 	a6xx_hfi_stop(gmu);
 
@@ -883,6 +924,15 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 
 	/* Make sure there are no outstanding RPMh votes */
 	a6xx_gmu_rpmh_off(gmu);
+
+	/* Halt the gmu cm3 core */
+	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 1);
+
+	a6xx_bus_clear_pending_transactions(adreno_gpu, true);
+
+	/* Reset GPU core blocks */
+	gpu_write(gpu, REG_A6XX_RBBM_SW_RESET_CMD, 1);
+	udelay(100);
 }
 
 static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
@@ -1010,81 +1060,56 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
 	return true;
 }
 
-#define GBIF_CLIENT_HALT_MASK             BIT(0)
-#define GBIF_ARB_HALT_MASK                BIT(1)
-
-static void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu)
-{
-	struct msm_gpu *gpu = &adreno_gpu->base;
-
-	if (!a6xx_has_gbif(adreno_gpu)) {
-		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0xf);
-		spin_until((gpu_read(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL1) &
-								0xf) == 0xf);
-		gpu_write(gpu, REG_A6XX_VBIF_XIN_HALT_CTRL0, 0);
-
-		return;
-	}
-
-	/* Halt new client requests on GBIF */
-	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_CLIENT_HALT_MASK);
-	spin_until((gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK) &
-			(GBIF_CLIENT_HALT_MASK)) == GBIF_CLIENT_HALT_MASK);
-
-	/* Halt all AXI requests on GBIF */
-	gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_ARB_HALT_MASK);
-	spin_until((gpu_read(gpu,  REG_A6XX_GBIF_HALT_ACK) &
-			(GBIF_ARB_HALT_MASK)) == GBIF_ARB_HALT_MASK);
-
-	/* The GBIF halt needs to be explicitly cleared */
-	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
-}
-
 /* Gracefully try to shut down the GMU and by extension the GPU */
 static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 {
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
 
-		a6xx_bus_clear_pending_transactions(adreno_gpu);
+	/* If the GMU isn't responding assume it is hung */
+	if (ret)
+		goto force_off;
 
-		/* tell the GMU we want to slumber */
-		a6xx_gmu_notify_slumber(gmu);
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
@@ -1094,6 +1119,11 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 
 	/* Tell RPMh to power off the GPU */
 	a6xx_rpmh_stop(gmu);
+
+	return;
+
+force_off:
+	a6xx_gmu_force_off(gmu);
 }
 
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 27fae0dc9704..1c38c3acacbe 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -891,6 +891,10 @@ static int hw_init(struct msm_gpu *gpu)
 	/* Make sure the GMU keeps the GPU on while we set it up */
 	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
+	/* Clear GBIF halt in case GX domain was not collapsed */
+	if (a6xx_has_gbif(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
+
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 
 	/*
@@ -1174,6 +1178,15 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	if (hang_debug)
 		a6xx_dump(gpu);
 
+	/*
+	 * To handle recovery specific sequences during the rpm suspend we are
+	 * about to trigger
+	 */
+	a6xx_gpu->hung = true;
+
+	/* Halt SQE first */
+	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);
+
 	/*
 	 * Turn off keep alive that might have been enabled by the hang
 	 * interrupt
@@ -1184,6 +1197,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	gpu->funcs->pm_resume(gpu);
 
 	msm_gpu_hw_init(gpu);
+	a6xx_gpu->hung = false;
 }
 
 static const char *a6xx_uche_fault_block(struct msm_gpu *gpu, u32 mid)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 86e0a7c3fe6d..79d0cecff8e9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -32,6 +32,7 @@ struct a6xx_gpu {
 	void *llc_slice;
 	void *htw_llc_slice;
 	bool have_mmu500;
+	bool hung;
 };
 
 #define to_a6xx_gpu(x) container_of(x, struct a6xx_gpu, base)
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 2048eac841dd..4b16266ac76a 100644
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
index c89d5964148f..112884c10aed 100644
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
index 4d07b21a16e6..03d29321ad49 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -454,7 +454,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
 				       enum repaper_stage stage)
 {
 	u64 start = local_clock();
-	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
+	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
 
 	do {
 		repaper_frame_fixed(epd, fixed_value, stage);
@@ -465,7 +465,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
 				      const u8 *mask, enum repaper_stage stage)
 {
 	u64 start = local_clock();
-	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
+	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
 
 	do {
 		repaper_frame_data(epd, image, mask, stage);
diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 3b4ee21cd811..e92bc2331e89 100644
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
@@ -760,6 +772,11 @@ static int pidff_find_fields(struct pidff_usage *usage, const u8 *table,
 {
 	int i, j, k, found;
 
+	if (!report) {
+		pr_debug("pidff_find_fields, null report\n");
+		return -1;
+	}
+
 	for (k = 0; k < count; k++) {
 		found = 0;
 		for (i = 0; i < report->maxfield; i++) {
@@ -873,6 +890,11 @@ static struct hid_field *pidff_find_special_field(struct hid_report *report,
 {
 	int i;
 
+	if (!report) {
+		pr_debug("pidff_find_special_field, null report\n");
+		return NULL;
+	}
+
 	for (i = 0; i < report->maxfield; i++) {
 		if (report->field[i]->logical == (HID_UP_PID | usage) &&
 		    report->field[i]->report_count > 0) {
diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 96d0eccca3aa..8f7c4fd100d6 100644
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
index 790ea3fda693..69607ae7cdab 100644
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
index ef12fda68d27..ea6556f91302 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2240,6 +2240,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
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
index 29440a1266b8..368429a34d60 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -315,7 +315,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
 		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
-		readsl(master->regs + SVC_I3C_MRDATAB, buf, count);
+		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
 		slot->len += count;
 		buf += count;
 	}
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index aa42ba759fa1..c922faab4a52 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.channel = 0,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 24,
 			.storagebits = 32,
 			.shift = 8,
@@ -370,12 +370,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = ad7768_scan_direct(indio_dev);
-		if (ret >= 0)
-			*val = ret;
 
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
+		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index b052de1b9ccb..cbb14b0b175f 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -78,12 +78,14 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 
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
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 3725f05ad297..be895398df09 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1013,7 +1013,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.stride = sizeof(struct sq_sge);
 	hwq_attr.depth = bnxt_qplib_get_depth(sq);
 	hwq_attr.aux_stride = psn_sz;
-	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
+	hwq_attr.aux_depth = psn_sz ? bnxt_qplib_set_sq_size(sq, qp->wqe_mode)
+				    : 0;
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 83a6b8fbe10f..4fc8e0c8b7ab 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -544,7 +544,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		if (ret)
 			return ret;
 	}
-	dma_set_max_seg_size(dev, UINT_MAX);
+	dma_set_max_seg_size(dev, SZ_2G);
 	ret = ib_register_device(ib_dev, "hns_%d", dev);
 	if (ret) {
 		dev_err(dev, "ib_register_device failed!\n");
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index 8665e506404f..774037ea44a9 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -56,6 +56,7 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = new_inode(dir->i_sb);
 
 	if (!inode) {
+		dput(dentry);
 		error = -EPERM;
 		goto bail;
 	}
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index d346dd48e731..9bb78918e52a 100644
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
 
@@ -564,10 +564,10 @@ static int usnic_ib_pci_probe(struct pci_dev *pdev,
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
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d9251af7f3cf..7d38cc5c04e6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3381,7 +3381,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	 * we should not modify the IRTE
 	 */
 	if (!dev_data || !dev_data->use_vapic)
-		return 0;
+		return -EINVAL;
 
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 1ae37e693de0..d080e21df666 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -101,7 +101,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 
 	ret = mcb_device_register(bus, mdev);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	return 0;
 
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 31c4100d38c1..1864e8180be8 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -1890,16 +1890,13 @@ static void check_migrations(struct work_struct *ws)
  * This function gets called on the error paths of the constructor, so we
  * have to cope with a partially initialised struct.
  */
-static void destroy(struct cache *cache)
+static void __destroy(struct cache *cache)
 {
-	unsigned i;
-
 	mempool_exit(&cache->migration_pool);
 
 	if (cache->prison)
 		dm_bio_prison_destroy_v2(cache->prison);
 
-	cancel_delayed_work_sync(&cache->waker);
 	if (cache->wq)
 		destroy_workqueue(cache->wq);
 
@@ -1927,13 +1924,22 @@ static void destroy(struct cache *cache)
 	if (cache->policy)
 		dm_cache_policy_destroy(cache->policy);
 
+	bioset_exit(&cache->bs);
+
+	kfree(cache);
+}
+
+static void destroy(struct cache *cache)
+{
+	unsigned int i;
+
+	cancel_delayed_work_sync(&cache->waker);
+
 	for (i = 0; i < cache->nr_ctr_args ; i++)
 		kfree(cache->ctr_args[i]);
 	kfree(cache->ctr_args);
 
-	bioset_exit(&cache->bs);
-
-	kfree(cache);
+	__destroy(cache);
 }
 
 static void cache_dtr(struct dm_target *ti)
@@ -2546,7 +2552,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	*result = cache;
 	return 0;
 bad:
-	destroy(cache);
+	__destroy(cache);
 	return r;
 }
 
@@ -2597,7 +2603,7 @@ static int cache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 	r = copy_ctr_args(cache, argc - 3, (const char **)argv + 3);
 	if (r) {
-		destroy(cache);
+		__destroy(cache);
 		goto out;
 	}
 
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index ae372bc44fbf..ffae04983b0a 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4454,16 +4454,19 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
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
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 8427c9767a61..de87606b2e04 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2063,14 +2063,9 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 				if (!rdev_set_badblocks(rdev, sect, s, 0))
 					abort = 1;
 			}
-			if (abort) {
-				conf->recovery_disabled =
-					mddev->recovery_disabled;
-				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-				md_done_sync(mddev, r1_bio->sectors, 0);
-				put_buf(r1_bio);
+			if (abort)
 				return 0;
-			}
+
 			/* Try next page */
 			sectors -= s;
 			sect += s;
@@ -2210,10 +2205,21 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
 	int disks = conf->raid_disks * 2;
 	struct bio *wbio;
 
-	if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
-		/* ouch - failed to read all of that. */
-		if (!fix_sync_read_error(r1_bio))
+	if (!test_bit(R1BIO_Uptodate, &r1_bio->state)) {
+		/*
+		 * ouch - failed to read all of that.
+		 * No need to fix read error for check/repair
+		 * because all member disks are read.
+		 */
+		if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) ||
+		    !fix_sync_read_error(r1_bio)) {
+			conf->recovery_disabled = mddev->recovery_disabled;
+			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+			md_done_sync(mddev, r1_bio->sectors, 0);
+			put_buf(r1_bio);
 			return;
+		}
+	}
 
 	if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
 		process_checks(r1_bio);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index bdd5a564e319..e6c0e24cb9ae 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1771,6 +1771,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
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
index 31bac06d46b5..5bb594ce199a 100644
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
index ca831b4db484..789f288bd1ed 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3645,6 +3645,7 @@ static int ccs_probe(struct i2c_client *client)
 out_disable_runtime_pm:
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 
 out_media_entity_cleanup:
 	media_entity_cleanup(&sensor->src->sd.entity);
@@ -3677,9 +3678,10 @@ static int ccs_remove(struct i2c_client *client)
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
index ebb299f207e5..704199b3957c 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -748,6 +748,8 @@ static int ov7251_set_power_on(struct ov7251 *ov7251)
 		return ret;
 	}
 
+	usleep_range(1000, 1100);
+
 	gpiod_set_value_cansleep(ov7251->enable_gpio, 1);
 
 	/* wait at least 65536 external clock cycles */
@@ -1333,7 +1335,7 @@ static int ov7251_probe(struct i2c_client *client)
 		return PTR_ERR(ov7251->analog_regulator);
 	}
 
-	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(ov7251->enable_gpio)) {
 		dev_err(dev, "cannot get enable gpio\n");
 		return PTR_ERR(ov7251->enable_gpio);
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index a04673d2c3ed..5475879c2669 100644
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
@@ -279,8 +298,9 @@ static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
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
@@ -297,38 +317,66 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
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
index 9dd715af2379..c753756108dc 100644
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
 
@@ -1023,18 +1029,26 @@ static void venus_sfr_print(struct venus_hfi_device *hdev)
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
diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index 9cd765e31c49..d31ee190301b 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -26,7 +26,6 @@
 #include <linux/usb/input.h>
 #include <media/rc-core.h>
 
-#define DRIVER_VERSION	"1.61"
 #define DRIVER_NAME	"streamzap"
 #define DRIVER_DESC	"Streamzap Remote Control driver"
 
@@ -67,9 +66,6 @@ struct streamzap_ir {
 	struct device *dev;
 
 	/* usb */
-	struct usb_device	*usbdev;
-	struct usb_interface	*interface;
-	struct usb_endpoint_descriptor *endpoint;
 	struct urb		*urb_in;
 
 	/* buffer & dma */
@@ -86,9 +82,7 @@ struct streamzap_ir {
 	/* start time of signal; necessary for gap tracking */
 	ktime_t			signal_last;
 	ktime_t			signal_start;
-	bool			timeout_enabled;
 
-	char			name[128];
 	char			phys[64];
 };
 
@@ -179,39 +173,10 @@ static void sz_push_half_space(struct streamzap_ir *sz,
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
@@ -242,10 +207,7 @@ static void streamzap_callback(struct urb *urb)
 					.duration = sz->rdev->timeout
 				};
 				sz->idle = true;
-				if (sz->timeout_enabled)
-					sz_push(sz, rawir);
-				ir_raw_event_handle(sz->rdev);
-				ir_raw_event_reset(sz->rdev);
+				sz_push(sz, rawir);
 			} else {
 				sz_push_full_space(sz, sz->buf_in[i]);
 			}
@@ -264,30 +226,63 @@ static void streamzap_callback(struct urb *urb)
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
 
-static struct rc_dev *streamzap_init_rc_dev(struct streamzap_ir *sz)
+static struct rc_dev *streamzap_init_rc_dev(struct streamzap_ir *sz,
+					    struct usb_device *usbdev)
 {
 	struct rc_dev *rdev;
 	struct device *dev = sz->dev;
 	int ret;
 
 	rdev = rc_allocate_device(RC_DRIVER_IR_RAW);
-	if (!rdev) {
-		dev_err(dev, "remote dev allocation failed\n");
+	if (!rdev)
 		goto out;
-	}
 
-	snprintf(sz->name, sizeof(sz->name), "Streamzap PC Remote Infrared Receiver (%04x:%04x)",
-		 le16_to_cpu(sz->usbdev->descriptor.idVendor),
-		 le16_to_cpu(sz->usbdev->descriptor.idProduct));
-	usb_make_path(sz->usbdev, sz->phys, sizeof(sz->phys));
+	usb_make_path(usbdev, sz->phys, sizeof(sz->phys));
 	strlcat(sz->phys, "/input0", sizeof(sz->phys));
 
-	rdev->device_name = sz->name;
+	rdev->device_name = "Streamzap PC Remote Infrared Receiver";
 	rdev->input_phys = sz->phys;
-	usb_to_input_id(sz->usbdev, &rdev->input_id);
+	usb_to_input_id(usbdev, &rdev->input_id);
 	rdev->dev.parent = dev;
 	rdev->priv = sz;
 	rdev->allowed_protocols = RC_PROTO_BIT_ALL_IR_DECODER;
@@ -318,9 +313,9 @@ static int streamzap_probe(struct usb_interface *intf,
 			   const struct usb_device_id *id)
 {
 	struct usb_device *usbdev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *endpoint;
 	struct usb_host_interface *iface_host;
 	struct streamzap_ir *sz = NULL;
-	char buf[63], name[128] = "";
 	int retval = -ENOMEM;
 	int pipe, maxp;
 
@@ -329,9 +324,6 @@ static int streamzap_probe(struct usb_interface *intf,
 	if (!sz)
 		return -ENOMEM;
 
-	sz->usbdev = usbdev;
-	sz->interface = intf;
-
 	/* Check to ensure endpoint information matches requirements */
 	iface_host = intf->cur_altsetting;
 
@@ -342,22 +334,22 @@ static int streamzap_probe(struct usb_interface *intf,
 		goto free_sz;
 	}
 
-	sz->endpoint = &(iface_host->endpoint[0].desc);
-	if (!usb_endpoint_dir_in(sz->endpoint)) {
+	endpoint = &iface_host->endpoint[0].desc;
+	if (!usb_endpoint_dir_in(endpoint)) {
 		dev_err(&intf->dev, "%s: endpoint doesn't match input device 02%02x\n",
-			__func__, sz->endpoint->bEndpointAddress);
+			__func__, endpoint->bEndpointAddress);
 		retval = -ENODEV;
 		goto free_sz;
 	}
 
-	if (!usb_endpoint_xfer_int(sz->endpoint)) {
+	if (!usb_endpoint_xfer_int(endpoint)) {
 		dev_err(&intf->dev, "%s: endpoint attributes don't match xfer 02%02x\n",
-			__func__, sz->endpoint->bmAttributes);
+			__func__, endpoint->bmAttributes);
 		retval = -ENODEV;
 		goto free_sz;
 	}
 
-	pipe = usb_rcvintpipe(usbdev, sz->endpoint->bEndpointAddress);
+	pipe = usb_rcvintpipe(usbdev, endpoint->bEndpointAddress);
 	maxp = usb_maxpacket(usbdev, pipe, usb_pipeout(pipe));
 
 	if (maxp == 0) {
@@ -379,25 +371,13 @@ static int streamzap_probe(struct usb_interface *intf,
 	sz->dev = &intf->dev;
 	sz->buf_in_len = maxp;
 
-	if (usbdev->descriptor.iManufacturer
-	    && usb_string(usbdev, usbdev->descriptor.iManufacturer,
-			  buf, sizeof(buf)) > 0)
-		strscpy(name, buf, sizeof(name));
-
-	if (usbdev->descriptor.iProduct
-	    && usb_string(usbdev, usbdev->descriptor.iProduct,
-			  buf, sizeof(buf)) > 0)
-		snprintf(name + strlen(name), sizeof(name) - strlen(name),
-			 " %s", buf);
-
-	sz->rdev = streamzap_init_rc_dev(sz);
+	sz->rdev = streamzap_init_rc_dev(sz, usbdev);
 	if (!sz->rdev)
 		goto rc_dev_fail;
 
 	sz->idle = true;
 	sz->decoder_state = PulseSpace;
 	/* FIXME: don't yet have a way to set this */
-	sz->timeout_enabled = true;
 	sz->rdev->timeout = SZ_TIMEOUT * SZ_RESOLUTION;
 	#if 0
 	/* not yet supported, depends on patches from maxim */
@@ -410,8 +390,7 @@ static int streamzap_probe(struct usb_interface *intf,
 
 	/* Complete final initialisations */
 	usb_fill_int_urb(sz->urb_in, usbdev, pipe, sz->buf_in,
-			 maxp, (usb_complete_t)streamzap_callback,
-			 sz, sz->endpoint->bInterval);
+			 maxp, streamzap_callback, sz, endpoint->bInterval);
 	sz->urb_in->transfer_dma = sz->dma_in;
 	sz->urb_in->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
@@ -420,9 +399,6 @@ static int streamzap_probe(struct usb_interface *intf,
 	if (usb_submit_urb(sz->urb_in, GFP_ATOMIC))
 		dev_err(sz->dev, "urb submit failed\n");
 
-	dev_info(sz->dev, "Registered %s on usb%d:%d\n", name,
-		 usbdev->bus->busnum, usbdev->devnum);
-
 	return 0;
 
 rc_dev_fail:
@@ -455,9 +431,8 @@ static void streamzap_disconnect(struct usb_interface *interface)
 	if (!sz)
 		return;
 
-	sz->usbdev = NULL;
-	rc_unregister_device(sz->rdev);
 	usb_kill_urb(sz->urb_in);
+	rc_unregister_device(sz->rdev);
 	usb_free_urb(sz->urb_in);
 	usb_free_coherent(usbdev, sz->buf_in_len, sz->buf_in, sz->dma_in);
 
diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
index d714fe50afe5..48178d5150d7 100644
--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -1321,9 +1321,6 @@ static int vim2m_probe(struct platform_device *pdev)
 	vfd->v4l2_dev = &dev->v4l2_dev;
 
 	video_set_drvdata(vfd, dev);
-	v4l2_info(&dev->v4l2_dev,
-		  "Device registered as /dev/video%d\n", vfd->num);
-
 	platform_set_drvdata(pdev, dev);
 
 	dev->m2m_dev = v4l2_m2m_init(&m2m_ops);
@@ -1350,6 +1347,9 @@ static int vim2m_probe(struct platform_device *pdev)
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
index 1b73318d1f1f..f487a03c1b5d 100644
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
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 3f8349fbbc3a..c8f4c593b596 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -117,6 +117,7 @@
 
 #define MEI_DEV_ID_LNL_M      0xA870  /* Lunar Lake Point M */
 
+#define MEI_DEV_ID_PTL_H      0xE370  /* Panther Lake H */
 #define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
 
 /*
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 31012ea4c01a..e6d55511de47 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -123,6 +123,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_H, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 0223e96aae47..fc3ebe96274f 100644
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
diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index 6b48397c750c..8579a38698e6 100644
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
index e13d42c0acb0..f008cc4ee482 100644
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
index c1e7ab13e777..aa89fcfd71ea 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2963,7 +2963,7 @@ static int brcmnand_resume(struct device *dev)
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
index df67262c3092..27025ca5a759 100644
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
index 07a3f12e02dd..2d1d60dbe7f0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3192,6 +3192,21 @@ static int mv88e6xxx_stats_setup(struct mv88e6xxx_chip *chip)
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
@@ -4569,6 +4584,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 
 static const struct mv88e6xxx_ops mv88e6320_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
@@ -4581,6 +4597,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -4605,8 +4622,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -4615,6 +4632,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
@@ -4627,6 +4645,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -4650,8 +4669,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5200,7 +5219,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -5622,6 +5641,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
@@ -5643,7 +5663,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 381068395c63..e6d1801bb8f5 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -653,7 +653,8 @@ void mv88e6xxx_teardown_devlink_regions_global(struct dsa_switch *ds)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mv88e6xxx_regions); i++)
-		dsa_devlink_region_destroy(chip->regions[i]);
+		if (chip->regions[i])
+			dsa_devlink_region_destroy(chip->regions[i]);
 }
 
 void mv88e6xxx_teardown_devlink_regions_port(struct dsa_switch *ds, int port)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 129352bbe114..f1e09a8dfc5c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -2262,6 +2262,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
 						   GFP_KERNEL);
 		if (!eth_filter->port[i].bmap) {
 			ret = -ENOMEM;
+			kvfree(eth_filter->port[i].loc_array);
 			goto free_eth_finfo;
 		}
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index d5acee27894e..9f99a6ed7008 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -577,6 +577,7 @@
 #define IGC_PTM_STAT_T4M1_OVFL		BIT(3) /* T4 minus T1 overflow */
 #define IGC_PTM_STAT_ADJUST_1ST		BIT(4) /* 1588 timer adjusted during 1st PTM cycle */
 #define IGC_PTM_STAT_ADJUST_CYC		BIT(5) /* 1588 timer adjusted during non-1st PTM cycle */
+#define IGC_PTM_STAT_ALL		GENMASK(5, 0) /* Used to clear all status */
 
 /* PCIe PTM Cycle Control */
 #define IGC_PTM_CYCLE_CTRL_CYC_TIME(msec)	((msec) & 0x3ff) /* PTM Cycle Time (msec) */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27c24bfc2dbe..4186e5732f97 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6722,6 +6722,7 @@ static int igc_probe(struct pci_dev *pdev,
 
 err_register:
 	igc_release_hw_control(adapter);
+	igc_ptp_stop(adapter);
 err_eeprom:
 	if (!igc_check_reset_block(hw))
 		igc_reset_phy(hw);
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 556750b61c98..49f8b0b0e658 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -849,45 +849,60 @@ static void igc_ptm_log_error(struct igc_adapter *adapter, u32 ptm_stat)
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
@@ -896,15 +911,7 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
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
@@ -1068,8 +1075,12 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
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
@@ -1086,10 +1097,13 @@ void igc_ptp_stop(struct igc_adapter *adapter)
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
 
@@ -1121,14 +1135,19 @@ void igc_ptp_reset(struct igc_adapter *adapter)
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
diff --git a/drivers/net/ethernet/microsoft/mana/mana.h b/drivers/net/ethernet/microsoft/mana/mana.h
index 35e937a7079c..6aac4824090c 100644
--- a/drivers/net/ethernet/microsoft/mana/mana.h
+++ b/drivers/net/ethernet/microsoft/mana/mana.h
@@ -76,6 +76,8 @@ struct mana_txq {
 
 	atomic_t pending_sends;
 
+	bool napi_initialized;
+
 	struct mana_stats stats;
 };
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b0963fda4d9f..3c754b31c30d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1154,10 +1154,12 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 
 	for (i = 0; i < apc->num_queues; i++) {
 		napi = &apc->tx_qp[i].tx_cq.napi;
-		napi_synchronize(napi);
-		napi_disable(napi);
-		netif_napi_del(napi);
-
+		if (apc->tx_qp[i].txq.napi_initialized) {
+			napi_synchronize(napi);
+			napi_disable(napi);
+			netif_napi_del(napi);
+			apc->tx_qp[i].txq.napi_initialized = false;
+		}
 		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
 
 		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
@@ -1213,6 +1215,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 		txq->ndev = net;
 		txq->net_txq = netdev_get_tx_queue(net, i);
 		txq->vp_offset = apc->tx_vp_offset;
+		txq->napi_initialized = false;
 		skb_queue_head_init(&txq->pending_skbs);
 
 		memset(&spec, 0, sizeof(spec));
@@ -1277,6 +1280,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 
 		netif_tx_napi_add(net, &cq->napi, mana_poll, NAPI_POLL_WEIGHT);
 		napi_enable(&cq->napi);
+		txq->napi_initialized = true;
 
 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 	}
@@ -1288,7 +1292,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 }
 
 static void mana_destroy_rxq(struct mana_port_context *apc,
-			     struct mana_rxq *rxq, bool validate_state)
+			     struct mana_rxq *rxq, bool napi_initialized)
 
 {
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
@@ -1302,12 +1306,13 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 
 	napi = &rxq->rx_cq.napi;
 
-	if (validate_state)
+	if (napi_initialized) {
 		napi_synchronize(napi);
 
-	napi_disable(napi);
-	netif_napi_del(napi);
+		napi_disable(napi);
 
+		netif_napi_del(napi);
+	}
 	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
 
 	mana_deinit_cq(apc, &rxq->rx_cq);
diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index f550576eb9da..6f9d8da76c4d 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -91,9 +91,8 @@ int phy_led_triggers_register(struct phy_device *phy)
 	if (!phy->phy_num_led_triggers)
 		return 0;
 
-	phy->led_link_trigger = devm_kzalloc(&phy->mdio.dev,
-					     sizeof(*phy->led_link_trigger),
-					     GFP_KERNEL);
+	phy->led_link_trigger = kzalloc(sizeof(*phy->led_link_trigger),
+					GFP_KERNEL);
 	if (!phy->led_link_trigger) {
 		err = -ENOMEM;
 		goto out_clear;
@@ -103,10 +102,9 @@ int phy_led_triggers_register(struct phy_device *phy)
 	if (err)
 		goto out_free_link;
 
-	phy->phy_led_triggers = devm_kcalloc(&phy->mdio.dev,
-					    phy->phy_num_led_triggers,
-					    sizeof(struct phy_led_trigger),
-					    GFP_KERNEL);
+	phy->phy_led_triggers = kcalloc(phy->phy_num_led_triggers,
+					sizeof(struct phy_led_trigger),
+					GFP_KERNEL);
 	if (!phy->phy_led_triggers) {
 		err = -ENOMEM;
 		goto out_unreg_link;
@@ -127,11 +125,11 @@ int phy_led_triggers_register(struct phy_device *phy)
 out_unreg:
 	while (i--)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
-	devm_kfree(&phy->mdio.dev, phy->phy_led_triggers);
+	kfree(phy->phy_led_triggers);
 out_unreg_link:
 	phy_led_trigger_unregister(phy->led_link_trigger);
 out_free_link:
-	devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
+	kfree(phy->led_link_trigger);
 	phy->led_link_trigger = NULL;
 out_clear:
 	phy->phy_num_led_triggers = 0;
@@ -145,8 +143,13 @@ void phy_led_triggers_unregister(struct phy_device *phy)
 
 	for (i = 0; i < phy->phy_num_led_triggers; i++)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
+	kfree(phy->phy_led_triggers);
+	phy->phy_led_triggers = NULL;
 
-	if (phy->led_link_trigger)
+	if (phy->led_link_trigger) {
 		phy_led_trigger_unregister(phy->led_link_trigger);
+		kfree(phy->led_link_trigger);
+		phy->led_link_trigger = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(phy_led_triggers_unregister);
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 692c558beed5..c8d9c580ed50 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -517,6 +517,11 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *skb)
 	unsigned char *data;
 	int islcp;
 
+	/* Ensure we can safely access protocol field and LCP code */
+	if (!pskb_may_pull(skb, 3)) {
+		kfree_skb(skb);
+		return NULL;
+	}
 	data  = skb->data;
 	proto = get_unaligned_be16(data);
 
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 63e1c2d783c5..b2e0abb5b2b5 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2004-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2012,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2016-2017 Erik Stromdahl <erik.stromdahl@gmail.com>
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -2648,9 +2649,9 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 
 	netif_napi_del(&ar->napi);
 
-	ath10k_core_destroy(ar);
-
 	destroy_workqueue(ar_sdio->workqueue);
+
+	ath10k_core_destroy(ar);
 }
 
 static const struct sdio_device_id ath10k_sdio_devices[] = {
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 7582761c61e2..26953dcffe19 100644
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
index 832b0792e0e9..05f5ba184cfb 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -74,6 +74,10 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 
 #ifdef CONFIG_NL80211_TESTMODE
 	dev->test_mtd.name = devm_kstrdup(dev->dev, part, GFP_KERNEL);
+	if (!dev->test_mtd.name) {
+		ret = -ENOMEM;
+		goto out_put_node;
+	}
 	dev->test_mtd.offset = offset;
 #endif
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 2575369e44e2..9369515f36a3 100644
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
index 98cd39619d57..5771f61392ef 100644
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
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 72060acb9caf..366e19dbae31 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1041,7 +1041,7 @@ static inline char *idt_get_mw_name(enum idt_mw_type mw_type)
 static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 				       unsigned char *mw_cnt)
 {
-	struct idt_mw_cfg mws[IDT_MAX_NR_MWS], *ret_mws;
+	struct idt_mw_cfg *mws;
 	const struct idt_ntb_bar *bars;
 	enum idt_mw_type mw_type;
 	unsigned char widx, bidx, en_cnt;
@@ -1049,6 +1049,11 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 	int aprt_size;
 	u32 data;
 
+	mws = devm_kcalloc(&ndev->ntb.pdev->dev, IDT_MAX_NR_MWS,
+			   sizeof(*mws), GFP_KERNEL);
+	if (!mws)
+		return ERR_PTR(-ENOMEM);
+
 	/* Retrieve the array of the BARs registers */
 	bars = portdata_tbl[port].bars;
 
@@ -1103,16 +1108,7 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 		}
 	}
 
-	/* Allocate memory for memory window descriptors */
-	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
-			       GFP_KERNEL);
-	if (!ret_mws)
-		return ERR_PTR(-ENOMEM);
-
-	/* Copy the info of detected memory windows */
-	memcpy(ret_mws, mws, (*mw_cnt)*sizeof(*ret_mws));
-
-	return ret_mws;
+	return mws;
 }
 
 /*
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9532108d2dce..72c67a1ce7c4 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1338,7 +1338,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	qp_count = ilog2(qp_bitmap);
 	if (nt->use_msi) {
 		qp_count -= 1;
-		nt->msi_db_mask = 1 << qp_count;
+		nt->msi_db_mask = BIT_ULL(qp_count);
 		ntb_db_clear_mask(ndev, nt->msi_db_mask);
 	}
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6748532c776b..b9ba20f4048d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4221,6 +4221,15 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
+#ifdef CONFIG_NVME_MULTIPATH
+	else if (ctrl->ana_log_buf)
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
+#endif
 }
 
 /*
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d3ca59ae4c7a..812d085d49c9 100644
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
@@ -1044,33 +1030,24 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	struct nvmet_fc_hostport *newhost, *match = NULL;
 	unsigned long flags;
 
+	/*
+	 * Caller holds a reference on tgtport.
+	 */
+
 	/* if LLDD not implemented, leave as NULL */
 	if (!hosthandle)
 		return NULL;
 
-	/*
-	 * take reference for what will be the newly allocated hostport if
-	 * we end up using a new allocation
-	 */
-	if (!nvmet_fc_tgtport_get(tgtport))
-		return ERR_PTR(-EINVAL);
-
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	if (match) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (match)
 		return match;
-	}
 
 	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
-	if (!newhost) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (!newhost)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
@@ -1079,6 +1056,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);
@@ -1113,7 +1091,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *
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
index ddb3ed0483d9..5c4254ab5d83 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -36,11 +36,15 @@
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
 
@@ -443,8 +447,10 @@ int of_irq_count(struct device_node *dev)
 	struct of_phandle_args irq;
 	int nr = 0;
 
-	while (of_irq_parse_one(dev, nr, &irq) == 0)
+	while (of_irq_parse_one(dev, nr, &irq) == 0) {
+		of_node_put(irq.np);
 		nr++;
+	}
 
 	return nr;
 }
@@ -549,6 +555,8 @@ void __init of_irq_init(const struct of_device_id *matches)
 						desc->interrupt_parent);
 			if (ret) {
 				of_node_clear_flag(desc->dev, OF_POPULATED);
+				of_node_put(desc->interrupt_parent);
+				of_node_put(desc->dev);
 				kfree(desc);
 				continue;
 			}
@@ -579,6 +587,7 @@ void __init of_irq_init(const struct of_device_id *matches)
 err:
 	list_for_each_entry_safe(desc, temp_desc, &intc_desc_list, list) {
 		list_del(&desc->list);
+		of_node_put(desc->interrupt_parent);
 		of_node_put(desc->dev);
 		kfree(desc);
 	}
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c3c1d700f519..6a676bde5e2c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1231,7 +1231,7 @@ static const struct of_device_id brcm_pcie_match[] = {
 
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node, *msi_np;
+	struct device_node *np = pdev->dev.of_node;
 	struct pci_host_bridge *bridge;
 	const struct pcie_cfg_data *data;
 	struct brcm_pcie *pcie;
@@ -1306,9 +1306,14 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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
index 10a078ef4799..1195c570599c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -108,7 +108,7 @@ struct vmd_irq_list {
 struct vmd_dev {
 	struct pci_dev		*dev;
 
-	spinlock_t		cfg_lock;
+	raw_spinlock_t		cfg_lock;
 	void __iomem		*cfgbar;
 
 	int msix_count;
@@ -386,7 +386,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		*value = readb(addr);
@@ -401,7 +401,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -421,7 +421,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
@@ -439,7 +439,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -850,7 +850,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	spin_lock_init(&vmd->cfg_lock);
+	raw_spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6a5f53f968c3..99342ae6ff5b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5484,8 +5484,6 @@ static bool pci_bus_resetable(struct pci_bus *bus)
 		return false;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!pci_reset_supported(dev))
-			return false;
 		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
 		    (dev->subordinate && !pci_bus_resetable(dev->subordinate)))
 			return false;
@@ -5562,8 +5560,6 @@ static bool pci_slot_resetable(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		if (!pci_reset_supported(dev))
-			return false;
 		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
 		    (dev->subordinate && !pci_bus_resetable(dev->subordinate)))
 			return false;
@@ -6713,60 +6709,70 @@ static void pci_no_domains(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-static atomic_t __domain_nr = ATOMIC_INIT(-1);
+static DEFINE_IDA(pci_domain_nr_static_ida);
+static DEFINE_IDA(pci_domain_nr_dynamic_ida);
 
-static int pci_get_new_domain_nr(void)
+static void of_pci_reserve_static_domain_nr(void)
 {
-	return atomic_inc_return(&__domain_nr);
+	struct device_node *np;
+	int domain_nr;
+
+	for_each_node_by_type(np, "pci") {
+		domain_nr = of_get_pci_domain_nr(np);
+		if (domain_nr < 0)
+			continue;
+		/*
+		 * Permanently allocate domain_nr in dynamic_ida
+		 * to prevent it from dynamic allocation.
+		 */
+		ida_alloc_range(&pci_domain_nr_dynamic_ida,
+				domain_nr, domain_nr, GFP_KERNEL);
+	}
 }
 
 static int of_pci_bus_find_domain_nr(struct device *parent)
 {
-	static int use_dt_domains = -1;
-	int domain = -1;
+	static bool static_domains_reserved = false;
+	int domain_nr;
 
-	if (parent)
-		domain = of_get_pci_domain_nr(parent->of_node);
+	/* On the first call scan device tree for static allocations. */
+	if (!static_domains_reserved) {
+		of_pci_reserve_static_domain_nr();
+		static_domains_reserved = true;
+	}
+
+	if (parent) {
+		/*
+		 * If domain is in DT, allocate it in static IDA.  This
+		 * prevents duplicate static allocations in case of errors
+		 * in DT.
+		 */
+		domain_nr = of_get_pci_domain_nr(parent->of_node);
+		if (domain_nr >= 0)
+			return ida_alloc_range(&pci_domain_nr_static_ida,
+					       domain_nr, domain_nr,
+					       GFP_KERNEL);
+	}
 
 	/*
-	 * Check DT domain and use_dt_domains values.
-	 *
-	 * If DT domain property is valid (domain >= 0) and
-	 * use_dt_domains != 0, the DT assignment is valid since this means
-	 * we have not previously allocated a domain number by using
-	 * pci_get_new_domain_nr(); we should also update use_dt_domains to
-	 * 1, to indicate that we have just assigned a domain number from
-	 * DT.
-	 *
-	 * If DT domain property value is not valid (ie domain < 0), and we
-	 * have not previously assigned a domain number from DT
-	 * (use_dt_domains != 1) we should assign a domain number by
-	 * using the:
-	 *
-	 * pci_get_new_domain_nr()
-	 *
-	 * API and update the use_dt_domains value to keep track of method we
-	 * are using to assign domain numbers (use_dt_domains = 0).
-	 *
-	 * All other combinations imply we have a platform that is trying
-	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
-	 * which is a recipe for domain mishandling and it is prevented by
-	 * invalidating the domain value (domain = -1) and printing a
-	 * corresponding error.
+	 * If domain was not specified in DT, choose a free ID from dynamic
+	 * allocations. All domain numbers from DT are permanently in
+	 * dynamic allocations to prevent assigning them to other DT nodes
+	 * without static domain.
 	 */
-	if (domain >= 0 && use_dt_domains) {
-		use_dt_domains = 1;
-	} else if (domain < 0 && use_dt_domains != 1) {
-		use_dt_domains = 0;
-		domain = pci_get_new_domain_nr();
-	} else {
-		if (parent)
-			pr_err("Node %pOF has ", parent->of_node);
-		pr_err("Inconsistent \"linux,pci-domain\" property in DT\n");
-		domain = -1;
-	}
+	return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
+}
+
+static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	if (bus->domain_nr < 0)
+		return;
 
-	return domain;
+	/* Release domain from IDA where it was allocated. */
+	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
+		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
+	else
+		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
 }
 
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
@@ -6774,6 +6780,13 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
 			       acpi_pci_bus_find_domain_nr(bus);
 }
+
+void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	if (!acpi_disabled)
+		return;
+	of_pci_bus_release_domain_nr(bus, parent);
+}
 #endif
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 51615e4d28f4..773715992cf0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -883,11 +883,12 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
-	struct resource_entry *window, *n;
+	struct resource_entry *window, *next, *n;
 	struct pci_bus *bus, *b;
-	resource_size_t offset;
+	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
-	struct resource *res;
+	struct resource *res, *next_res;
+	bool bus_registered = false;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -908,6 +909,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
 	else
 		bus->domain_nr = bridge->domain_nr;
+	if (bus->domain_nr < 0) {
+		err = bus->domain_nr;
+		goto free;
+	}
 #endif
 
 	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
@@ -947,6 +952,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	name = dev_name(&bus->dev);
 
 	err = device_register(&bus->dev);
+	bus_registered = true;
 	if (err)
 		goto unregister;
 
@@ -969,11 +975,36 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
 		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
 
+	/* Coalesce contiguous windows */
+	resource_list_for_each_entry_safe(window, n, &resources) {
+		if (list_is_last(&window->node, &resources))
+			break;
+
+		next = list_next_entry(window, node);
+		offset = window->offset;
+		res = window->res;
+		next_offset = next->offset;
+		next_res = next->res;
+
+		if (res->flags != next_res->flags || offset != next_offset)
+			continue;
+
+		if (res->end + 1 == next_res->start) {
+			next_res->start = res->start;
+			res->flags = res->start = res->end = 0;
+		}
+	}
+
 	/* Add initial resources to the bus */
 	resource_list_for_each_entry_safe(window, n, &resources) {
-		list_move_tail(&window->node, &bridge->windows);
 		offset = window->offset;
 		res = window->res;
+		if (!res->flags && !res->start && !res->end) {
+			release_resource(res);
+			continue;
+		}
+
+		list_move_tail(&window->node, &bridge->windows);
 
 		if (res->flags & IORESOURCE_BUS)
 			pci_bus_insert_busn_res(bus, bus->number, res->end);
@@ -1004,9 +1035,15 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 unregister:
 	put_device(&bridge->dev);
 	device_del(&bridge->dev);
-
 free:
-	kfree(bus);
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	pci_bus_release_domain_nr(bus, parent);
+#endif
+	if (bus_registered)
+		put_device(&bus->dev);
+	else
+		kfree(bus);
+
 	return err;
 }
 
@@ -1115,7 +1152,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 add_dev:
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
-	WARN_ON(ret < 0);
+	if (WARN_ON(ret < 0)) {
+		put_device(&child->dev);
+		return NULL;
+	}
 
 	pcibios_add_bus(child);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 4c54c75050dc..22d39e12b236 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -157,6 +157,13 @@ void pci_remove_root_bus(struct pci_bus *bus)
 	list_for_each_entry_safe(child, tmp,
 				 &bus->devices, bus_list)
 		pci_remove_bus_device(child);
+
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	/* Release domain_nr if it was dynamically allocated */
+	if (host_bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
+		pci_bus_release_domain_nr(bus, host_bridge->dev.parent);
+#endif
+
 	pci_remove_bus(bus);
 	host_bridge->bus = NULL;
 
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 57d20cf3da7a..fd59f40f7443 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -338,12 +338,10 @@ armpmu_add(struct perf_event *event, int flags)
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
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index bf7706bf101a..be31b1e25b38 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -455,7 +455,7 @@ tegra_xusb_find_port_node(struct tegra_xusb_padctl *padctl, const char *type,
 	name = kasprintf(GFP_KERNEL, "%s-%u", type, index);
 	if (!name) {
 		of_node_put(ports);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 	np = of_get_child_by_name(ports, name);
 	kfree(name);
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 8476a8ac4451..e753161428b4 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -955,8 +955,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct msm_pingroup *g;
 	unsigned long flags;
-	bool was_enabled;
-	u32 val;
+	u32 val, oldval;
 
 	if (msm_gpio_needs_dual_edge_parent_workaround(d, type)) {
 		set_bit(d->hwirq, pctrl->dual_edge_irqs);
@@ -1016,8 +1015,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	 * internal circuitry of TLMM, toggling the RAW_STATUS
 	 * could cause the INTR_STATUS to be set for EDGE interrupts.
 	 */
-	val = msm_readl_intr_cfg(pctrl, g);
-	was_enabled = val & BIT(g->intr_raw_status_bit);
+	val = oldval = msm_readl_intr_cfg(pctrl, g);
 	val |= BIT(g->intr_raw_status_bit);
 	if (g->intr_detection_width == 2) {
 		val &= ~(3 << g->intr_detection_bit);
@@ -1070,9 +1068,11 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
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
index 4d2d32bfbe2a..977b62458c3a 100644
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
index f8f9a7489129..bb764428bfe7 100644
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
index b437192380e2..b2e75d870532 100644
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
 
-	one_cycle = (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div);
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
diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index de028868c6f4..4e5d5da258d6 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -260,6 +260,19 @@ static struct console sclp_console =
 	.index = 0 /* ttyS0 */
 };
 
+/*
+ *  Release allocated pages.
+ */
+static void __init __sclp_console_free_pages(void)
+{
+	struct list_head *page, *p;
+
+	list_for_each_safe(page, p, &sclp_con_pages) {
+		list_del(page);
+		free_page((unsigned long)page);
+	}
+}
+
 /*
  * called by console_init() in drivers/char/tty_io.c at boot-time.
  */
@@ -279,6 +292,10 @@ sclp_console_init(void)
 	/* Allocate pages for output buffering */
 	for (i = 0; i < sclp_console_pages; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		if (!page) {
+			__sclp_console_free_pages();
+			return -ENOMEM;
+		}
 		list_add_tail(page, &sclp_con_pages);
 	}
 	sclp_conbuf = NULL;
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 971fbb52740b..432dad2a2266 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -490,6 +490,17 @@ static const struct tty_operations sclp_ops = {
 	.flush_buffer = sclp_tty_flush_buffer,
 };
 
+/* Release allocated pages. */
+static void __init __sclp_tty_free_pages(void)
+{
+	struct list_head *page, *p;
+
+	list_for_each_safe(page, p, &sclp_tty_pages) {
+		list_del(page);
+		free_page((unsigned long)page);
+	}
+}
+
 static int __init
 sclp_tty_init(void)
 {
@@ -516,6 +527,7 @@ sclp_tty_init(void)
 	for (i = 0; i < MAX_KMEM_PAGES; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 		if (page == NULL) {
+			__sclp_tty_free_pages();
 			tty_driver_kref_put(driver);
 			return -ENOMEM;
 		}
diff --git a/drivers/scsi/aic94xx/aic94xx.h b/drivers/scsi/aic94xx/aic94xx.h
index 8f24180646c2..f595bc2ee45e 100644
--- a/drivers/scsi/aic94xx/aic94xx.h
+++ b/drivers/scsi/aic94xx/aic94xx.h
@@ -60,7 +60,6 @@ void asd_set_dmamode(struct domain_device *dev);
 /* ---------- TMFs ---------- */
 int  asd_abort_task(struct sas_task *);
 int  asd_abort_task_set(struct domain_device *, u8 *lun);
-int  asd_clear_aca(struct domain_device *, u8 *lun);
 int  asd_clear_task_set(struct domain_device *, u8 *lun);
 int  asd_lu_reset(struct domain_device *, u8 *lun);
 int  asd_I_T_nexus_reset(struct domain_device *dev);
diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 7a78606598c4..954d0c5ae2e2 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -960,7 +960,6 @@ static struct sas_domain_function_template aic94xx_transport_functions = {
 
 	.lldd_abort_task	= asd_abort_task,
 	.lldd_abort_task_set	= asd_abort_task_set,
-	.lldd_clear_aca		= asd_clear_aca,
 	.lldd_clear_task_set	= asd_clear_task_set,
 	.lldd_I_T_nexus_reset	= asd_I_T_nexus_reset,
 	.lldd_lu_reset		= asd_lu_reset,
diff --git a/drivers/scsi/aic94xx/aic94xx_tmf.c b/drivers/scsi/aic94xx/aic94xx_tmf.c
index 0eb6e206a2b4..0ff0d6506ccf 100644
--- a/drivers/scsi/aic94xx/aic94xx_tmf.c
+++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
@@ -644,15 +644,6 @@ int asd_abort_task_set(struct domain_device *dev, u8 *lun)
 	return res;
 }
 
-int asd_clear_aca(struct domain_device *dev, u8 *lun)
-{
-	int res = asd_initiate_ssp_tmf(dev, lun, TMF_CLEAR_ACA, 0);
-
-	if (res == TMF_RESP_FUNC_COMPLETE)
-		asd_clear_nexus_I_T_L(dev, lun);
-	return res;
-}
-
 int asd_clear_task_set(struct domain_device *dev, u8 *lun)
 {
 	int res = asd_initiate_ssp_tmf(dev, lun, TMF_CLEAR_TASK_SET, 0);
diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 57be32ba0109..081b4e22a502 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -134,6 +134,11 @@ struct hisi_sas_rst {
 	bool done;
 };
 
+struct hisi_sas_internal_abort {
+	unsigned int flag;
+	unsigned int tag;
+};
+
 #define HISI_SAS_RST_WORK_INIT(r, c) \
 	{	.hisi_hba = hisi_hba, \
 		.completion = &c, \
@@ -229,13 +234,6 @@ struct hisi_sas_device {
 	spinlock_t lock; /* For protecting slots */
 };
 
-struct hisi_sas_tmf_task {
-	int force_phy;
-	int phy_id;
-	u8 tmf;
-	u16 tag_of_task_to_be_managed;
-};
-
 struct hisi_sas_slot {
 	struct list_head entry;
 	struct list_head delivery;
@@ -254,7 +252,7 @@ struct hisi_sas_slot {
 	dma_addr_t cmd_hdr_dma;
 	struct timer_list internal_abort_timer;
 	bool is_internal;
-	struct hisi_sas_tmf_task *tmf;
+	struct sas_tmf_task *tmf;
 	/* Do not reorder/change members after here */
 	void	*buf;
 	dma_addr_t buf_dma;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 530f61df109a..8c32f815a968 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -11,7 +11,7 @@
 	((!dev) || (dev->dev_type == SAS_PHY_UNUSED))
 
 static int hisi_sas_debug_issue_ssp_tmf(struct domain_device *device,
-				u8 *lun, struct hisi_sas_tmf_task *tmf);
+				u8 *lun, struct sas_tmf_task *tmf);
 static int
 hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 			     struct domain_device *device,
@@ -273,11 +273,11 @@ static void hisi_sas_task_prep_ata(struct hisi_hba *hisi_hba,
 }
 
 static void hisi_sas_task_prep_abort(struct hisi_hba *hisi_hba,
-		struct hisi_sas_slot *slot,
-		int device_id, int abort_flag, int tag_to_abort)
+		struct hisi_sas_internal_abort *abort,
+		struct hisi_sas_slot *slot, int device_id)
 {
 	hisi_hba->hw->prep_abort(hisi_hba, slot,
-			device_id, abort_flag, tag_to_abort);
+			device_id, abort->flag, abort->tag);
 }
 
 static void hisi_sas_dma_unmap(struct hisi_hba *hisi_hba,
@@ -403,95 +403,19 @@ static int hisi_sas_dif_dma_map(struct hisi_hba *hisi_hba,
 	return rc;
 }
 
-static int hisi_sas_task_prep(struct sas_task *task,
-			      struct hisi_sas_dq **dq_pointer,
-			      bool is_tmf, struct hisi_sas_tmf_task *tmf,
-			      int *pass)
+static
+void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
+			   struct hisi_sas_slot *slot,
+			   struct hisi_sas_dq *dq,
+			   struct hisi_sas_device *sas_dev,
+			   struct hisi_sas_internal_abort *abort)
 {
-	struct domain_device *device = task->dev;
-	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
-	struct hisi_sas_device *sas_dev = device->lldd_dev;
-	struct hisi_sas_port *port;
-	struct hisi_sas_slot *slot;
-	struct hisi_sas_cmd_hdr	*cmd_hdr_base;
-	struct asd_sas_port *sas_port = device->port;
-	struct device *dev = hisi_hba->dev;
-	int dlvry_queue_slot, dlvry_queue, rc, slot_idx;
-	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
-	struct scsi_cmnd *scmd = NULL;
-	struct hisi_sas_dq *dq;
+	struct hisi_sas_cmd_hdr *cmd_hdr_base;
+	int dlvry_queue_slot, dlvry_queue;
+	struct sas_task *task = slot->task;
 	unsigned long flags;
 	int wr_q_index;
 
-	if (DEV_IS_GONE(sas_dev)) {
-		if (sas_dev)
-			dev_info(dev, "task prep: device %d not ready\n",
-				 sas_dev->device_id);
-		else
-			dev_info(dev, "task prep: device %016llx not ready\n",
-				 SAS_ADDR(device->sas_addr));
-
-		return -ECOMM;
-	}
-
-	if (task->uldd_task) {
-		struct ata_queued_cmd *qc;
-
-		if (dev_is_sata(device)) {
-			qc = task->uldd_task;
-			scmd = qc->scsicmd;
-		} else {
-			scmd = task->uldd_task;
-		}
-	}
-
-	if (scmd) {
-		unsigned int dq_index;
-		u32 blk_tag;
-
-		blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
-		dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
-		*dq_pointer = dq = &hisi_hba->dq[dq_index];
-	} else {
-		struct Scsi_Host *shost = hisi_hba->shost;
-		struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-		int queue = qmap->mq_map[raw_smp_processor_id()];
-
-		*dq_pointer = dq = &hisi_hba->dq[queue];
-	}
-
-	port = to_hisi_sas_port(sas_port);
-	if (port && !port->port_attached) {
-		dev_info(dev, "task prep: %s port%d not attach device\n",
-			 (dev_is_sata(device)) ?
-			 "SATA/STP" : "SAS",
-			 device->port->id);
-
-		return -ECOMM;
-	}
-
-	rc = hisi_sas_dma_map(hisi_hba, task, &n_elem,
-			      &n_elem_req);
-	if (rc < 0)
-		goto prep_out;
-
-	if (!sas_protocol_ata(task->task_proto)) {
-		rc = hisi_sas_dif_dma_map(hisi_hba, &n_elem_dif, task);
-		if (rc < 0)
-			goto err_out_dma_unmap;
-	}
-
-	if (hisi_hba->hw->slot_index_alloc)
-		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
-	else
-		rc = hisi_sas_slot_index_alloc(hisi_hba, scmd);
-
-	if (rc < 0)
-		goto err_out_dif_dma_unmap;
-
-	slot_idx = rc;
-	slot = &hisi_hba->slot_info[slot_idx];
-
 	spin_lock(&dq->lock);
 	wr_q_index = dq->wr_point;
 	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
@@ -505,16 +429,11 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	dlvry_queue_slot = wr_q_index;
 
 	slot->device_id = sas_dev->device_id;
-	slot->n_elem = n_elem;
-	slot->n_elem_dif = n_elem_dif;
 	slot->dlvry_queue = dlvry_queue;
 	slot->dlvry_queue_slot = dlvry_queue_slot;
 	cmd_hdr_base = hisi_hba->cmd_hdr[dlvry_queue];
 	slot->cmd_hdr = &cmd_hdr_base[dlvry_queue_slot];
-	slot->task = task;
-	slot->port = port;
-	slot->tmf = tmf;
-	slot->is_internal = is_tmf;
+
 	task->lldd_task = slot;
 
 	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
@@ -534,8 +453,14 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 		hisi_sas_task_prep_ata(hisi_hba, slot);
 		break;
+	case SAS_PROTOCOL_NONE:
+		if (abort) {
+			hisi_sas_task_prep_abort(hisi_hba, abort, slot, sas_dev->device_id);
+			break;
+		}
+	fallthrough;
 	default:
-		dev_err(dev, "task prep: unknown/unsupported proto (0x%x)\n",
+		dev_err(hisi_hba->dev, "task prep: unknown/unsupported proto (0x%x)\n",
 			task->task_proto);
 		break;
 	}
@@ -544,32 +469,27 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	task->task_state_flags |= SAS_TASK_AT_INITIATOR;
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 
-	++(*pass);
 	WRITE_ONCE(slot->ready, 1);
 
-	return 0;
-
-err_out_dif_dma_unmap:
-	if (!sas_protocol_ata(task->task_proto))
-		hisi_sas_dif_dma_unmap(hisi_hba, task, n_elem_dif);
-err_out_dma_unmap:
-	hisi_sas_dma_unmap(hisi_hba, task, n_elem,
-			   n_elem_req);
-prep_out:
-	dev_err(dev, "task prep: failed[%d]!\n", rc);
-	return rc;
+	spin_lock(&dq->lock);
+	hisi_hba->hw->start_delivery(dq);
+	spin_unlock(&dq->lock);
 }
 
 static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
-			      bool is_tmf, struct hisi_sas_tmf_task *tmf)
+			      struct sas_tmf_task *tmf)
 {
-	u32 rc;
-	u32 pass = 0;
-	struct hisi_hba *hisi_hba;
-	struct device *dev;
+	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
 	struct domain_device *device = task->dev;
 	struct asd_sas_port *sas_port = device->port;
+	struct hisi_sas_device *sas_dev = device->lldd_dev;
+	struct scsi_cmnd *scmd = NULL;
 	struct hisi_sas_dq *dq = NULL;
+	struct hisi_sas_port *port;
+	struct hisi_hba *hisi_hba;
+	struct hisi_sas_slot *slot;
+	struct device *dev;
+	int rc;
 
 	if (!sas_port) {
 		struct task_status_struct *ts = &task->task_status;
@@ -596,17 +516,94 @@ static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
 		up(&hisi_hba->sem);
 	}
 
-	/* protect task_prep and start_delivery sequence */
-	rc = hisi_sas_task_prep(task, &dq, is_tmf, tmf, &pass);
-	if (rc)
-		dev_err(dev, "task exec: failed[%d]!\n", rc);
+	if (DEV_IS_GONE(sas_dev)) {
+		if (sas_dev)
+			dev_info(dev, "task prep: device %d not ready\n",
+				 sas_dev->device_id);
+		else
+			dev_info(dev, "task prep: device %016llx not ready\n",
+				 SAS_ADDR(device->sas_addr));
 
-	if (likely(pass)) {
-		spin_lock(&dq->lock);
-		hisi_hba->hw->start_delivery(dq);
-		spin_unlock(&dq->lock);
+		return -ECOMM;
 	}
 
+	if (task->uldd_task) {
+		struct ata_queued_cmd *qc;
+
+		if (dev_is_sata(device)) {
+			qc = task->uldd_task;
+			scmd = qc->scsicmd;
+		} else {
+			scmd = task->uldd_task;
+		}
+	}
+
+	if (scmd) {
+		unsigned int dq_index;
+		u32 blk_tag;
+
+		blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
+		dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
+		dq = &hisi_hba->dq[dq_index];
+	} else {
+		struct Scsi_Host *shost = hisi_hba->shost;
+		struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+		int queue = qmap->mq_map[raw_smp_processor_id()];
+
+		dq = &hisi_hba->dq[queue];
+	}
+
+	port = to_hisi_sas_port(sas_port);
+	if (port && !port->port_attached) {
+		dev_info(dev, "task prep: %s port%d not attach device\n",
+			 (dev_is_sata(device)) ?
+			 "SATA/STP" : "SAS",
+			 device->port->id);
+
+		return -ECOMM;
+	}
+
+	rc = hisi_sas_dma_map(hisi_hba, task, &n_elem,
+			      &n_elem_req);
+	if (rc < 0)
+		goto prep_out;
+
+	if (!sas_protocol_ata(task->task_proto)) {
+		rc = hisi_sas_dif_dma_map(hisi_hba, &n_elem_dif, task);
+		if (rc < 0)
+			goto err_out_dma_unmap;
+	}
+
+	if (hisi_hba->hw->slot_index_alloc)
+		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
+	else
+		rc = hisi_sas_slot_index_alloc(hisi_hba, scmd);
+
+	if (rc < 0)
+		goto err_out_dif_dma_unmap;
+
+	slot = &hisi_hba->slot_info[rc];
+	slot->n_elem = n_elem;
+	slot->n_elem_dif = n_elem_dif;
+	slot->task = task;
+	slot->port = port;
+
+	slot->tmf = tmf;
+	slot->is_internal = tmf;
+
+	/* protect task_prep and start_delivery sequence */
+	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, NULL);
+
+	return 0;
+
+err_out_dif_dma_unmap:
+	if (!sas_protocol_ata(task->task_proto))
+		hisi_sas_dif_dma_unmap(hisi_hba, task, n_elem_dif);
+err_out_dma_unmap:
+	hisi_sas_dma_unmap(hisi_hba, task, n_elem,
+				   n_elem_req);
+prep_out:
+	dev_err(dev, "task exec: failed[%d]!\n", rc);
 	return rc;
 }
 
@@ -694,7 +691,7 @@ static int hisi_sas_init_device(struct domain_device *device)
 {
 	int rc = TMF_RESP_FUNC_COMPLETE;
 	struct scsi_lun lun;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int retry = HISI_SAS_DISK_RECOVER_CNT;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
@@ -855,8 +852,28 @@ static void hisi_sas_phyup_work(struct work_struct *work)
 		container_of(work, typeof(*phy), works[HISI_PHYE_PHY_UP]);
 	struct hisi_hba *hisi_hba = phy->hisi_hba;
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
+	struct asd_sas_port *sas_port = sas_phy->port;
+	struct hisi_sas_port *port = phy->port;
+	struct device *dev = hisi_hba->dev;
+	struct domain_device *port_dev;
 	int phy_no = sas_phy->id;
 
+	if (!test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags) &&
+	    sas_port && port && (port->id != phy->port_id)) {
+		dev_info(dev, "phy%d's hw port id changed from %d to %llu\n",
+				phy_no, port->id, phy->port_id);
+		port_dev = sas_port->port_dev;
+		if (port_dev && !dev_is_expander(port_dev->dev_type)) {
+			/*
+			 * Set the device state to gone to block
+			 * sending IO to the device.
+			 */
+			set_bit(SAS_DEV_GONE, &port_dev->state);
+			hisi_sas_notify_phy_event(phy, HISI_PHYE_LINK_RESET);
+			return;
+		}
+	}
+
 	phy->wait_phyup_cnt = 0;
 	if (phy->identify.target_port_protocols == SAS_PROTOCOL_SSP)
 		hisi_hba->hw->sl_notify_ssp(hisi_hba, phy_no);
@@ -1094,7 +1111,7 @@ static void hisi_sas_dev_gone(struct domain_device *device)
 
 static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 {
-	return hisi_sas_task_exec(task, gfp_flags, 0, NULL);
+	return hisi_sas_task_exec(task, gfp_flags, NULL);
 }
 
 static int hisi_sas_phy_set_linkrate(struct hisi_hba *hisi_hba, int phy_no,
@@ -1198,7 +1215,7 @@ static void hisi_sas_tmf_timedout(struct timer_list *t)
 #define INTERNAL_ABORT_TIMEOUT		(6 * HZ)
 static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
 					   void *parameter, u32 para_len,
-					   struct hisi_sas_tmf_task *tmf)
+					   struct sas_tmf_task *tmf)
 {
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba = sas_dev->hisi_hba;
@@ -1226,8 +1243,7 @@ static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
 		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
 		add_timer(&task->slow_task->timer);
 
-		res = hisi_sas_task_exec(task, GFP_KERNEL, 1, tmf);
-
+		res = hisi_sas_task_exec(task, GFP_KERNEL, tmf);
 		if (res) {
 			del_timer(&task->slow_task->timer);
 			dev_err(dev, "abort tmf: executing internal task failed: %d\n",
@@ -1334,12 +1350,13 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
 	int s = sizeof(struct host_to_dev_fis);
+	struct sas_tmf_task tmf = {};
 
 	ata_for_each_link(link, ap, EDGE) {
 		int pmp = sata_srst_pmp(link);
 
 		hisi_sas_fill_ata_reset_cmd(link->device, 1, pmp, fis);
-		rc = hisi_sas_exec_internal_tmf_task(device, fis, s, NULL);
+		rc = hisi_sas_exec_internal_tmf_task(device, fis, s, &tmf);
 		if (rc != TMF_RESP_FUNC_COMPLETE)
 			break;
 	}
@@ -1350,7 +1367,7 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 
 			hisi_sas_fill_ata_reset_cmd(link->device, 0, pmp, fis);
 			rc = hisi_sas_exec_internal_tmf_task(device, fis,
-							     s, NULL);
+							     s, &tmf);
 			if (rc != TMF_RESP_FUNC_COMPLETE)
 				dev_err(dev, "ata disk %016llx de-reset failed\n",
 					SAS_ADDR(device->sas_addr));
@@ -1367,7 +1384,7 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 }
 
 static int hisi_sas_debug_issue_ssp_tmf(struct domain_device *device,
-				u8 *lun, struct hisi_sas_tmf_task *tmf)
+				u8 *lun, struct sas_tmf_task *tmf)
 {
 	struct sas_ssp_task ssp_task;
 
@@ -1472,7 +1489,7 @@ static void hisi_sas_send_ata_reset_each_phy(struct hisi_hba *hisi_hba,
 					     struct asd_sas_port *sas_port,
 					     struct domain_device *device)
 {
-	struct hisi_sas_tmf_task tmf_task = { .force_phy = 1 };
+	struct sas_tmf_task tmf_task = { .force_phy = 1 };
 	struct ata_port *ap = device->sata_dev.ap;
 	struct device *dev = hisi_hba->dev;
 	int s = sizeof(struct host_to_dev_fis);
@@ -1627,7 +1644,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 static int hisi_sas_abort_task(struct sas_task *task)
 {
 	struct scsi_lun lun;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct domain_device *device = task->dev;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba;
@@ -1736,7 +1753,7 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 {
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc;
 
 	rc = hisi_sas_internal_task_abort(hisi_hba, device,
@@ -1756,17 +1773,6 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 	return rc;
 }
 
-static int hisi_sas_clear_aca(struct domain_device *device, u8 *lun)
-{
-	struct hisi_sas_tmf_task tmf_task;
-	int rc;
-
-	tmf_task.tmf = TMF_CLEAR_ACA;
-	rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
-
-	return rc;
-}
-
 #define I_T_NEXUS_RESET_PHYUP_TIMEOUT  (2 * HZ)
 
 static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
@@ -1882,7 +1888,7 @@ static int hisi_sas_lu_reset(struct domain_device *device, u8 *lun)
 			hisi_sas_release_task(hisi_hba, device);
 		sas_put_local_phy(phy);
 	} else {
-		struct hisi_sas_tmf_task tmf_task = { .tmf =  TMF_LU_RESET };
+		struct sas_tmf_task tmf_task = { .tmf =  TMF_LU_RESET };
 
 		rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
 		if (rc == TMF_RESP_FUNC_COMPLETE)
@@ -1940,7 +1946,7 @@ static int hisi_sas_clear_nexus_ha(struct sas_ha_struct *sas_ha)
 static int hisi_sas_query_task(struct sas_task *task)
 {
 	struct scsi_lun lun;
-	struct hisi_sas_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
@@ -1973,19 +1979,17 @@ static int hisi_sas_query_task(struct sas_task *task)
 
 static int
 hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
-				  struct sas_task *task, int abort_flag,
-				  int task_tag, struct hisi_sas_dq *dq)
+				  struct hisi_sas_internal_abort *abort,
+				  struct sas_task *task,
+				  struct hisi_sas_dq *dq)
 {
 	struct domain_device *device = task->dev;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct device *dev = hisi_hba->dev;
 	struct hisi_sas_port *port;
-	struct hisi_sas_slot *slot;
 	struct asd_sas_port *sas_port = device->port;
-	struct hisi_sas_cmd_hdr *cmd_hdr_base;
-	int dlvry_queue_slot, dlvry_queue, n_elem = 0, rc, slot_idx;
-	unsigned long flags;
-	int wr_q_index;
+	struct hisi_sas_slot *slot;
+	int slot_idx;
 
 	if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags)))
 		return -EINVAL;
@@ -1996,59 +2000,24 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 	port = to_hisi_sas_port(sas_port);
 
 	/* simply get a slot and send abort command */
-	rc = hisi_sas_slot_index_alloc(hisi_hba, NULL);
-	if (rc < 0)
+	slot_idx = hisi_sas_slot_index_alloc(hisi_hba, NULL);
+	if (slot_idx < 0)
 		goto err_out;
 
-	slot_idx = rc;
 	slot = &hisi_hba->slot_info[slot_idx];
-
-	spin_lock(&dq->lock);
-	wr_q_index = dq->wr_point;
-	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
-	list_add_tail(&slot->delivery, &dq->list);
-	spin_unlock(&dq->lock);
-	spin_lock(&sas_dev->lock);
-	list_add_tail(&slot->entry, &sas_dev->list);
-	spin_unlock(&sas_dev->lock);
-
-	dlvry_queue = dq->id;
-	dlvry_queue_slot = wr_q_index;
-
-	slot->device_id = sas_dev->device_id;
-	slot->n_elem = n_elem;
-	slot->dlvry_queue = dlvry_queue;
-	slot->dlvry_queue_slot = dlvry_queue_slot;
-	cmd_hdr_base = hisi_hba->cmd_hdr[dlvry_queue];
-	slot->cmd_hdr = &cmd_hdr_base[dlvry_queue_slot];
+	slot->n_elem = 0;
 	slot->task = task;
 	slot->port = port;
 	slot->is_internal = true;
-	task->lldd_task = slot;
 
-	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
-	memset(hisi_sas_cmd_hdr_addr_mem(slot), 0, HISI_SAS_COMMAND_TABLE_SZ);
-	memset(hisi_sas_status_buf_addr_mem(slot), 0,
-	       sizeof(struct hisi_sas_err_record));
-
-	hisi_sas_task_prep_abort(hisi_hba, slot, device_id,
-				      abort_flag, task_tag);
-
-	spin_lock_irqsave(&task->task_state_lock, flags);
-	task->task_state_flags |= SAS_TASK_AT_INITIATOR;
-	spin_unlock_irqrestore(&task->task_state_lock, flags);
-	WRITE_ONCE(slot->ready, 1);
-	/* send abort command to the chip */
-	spin_lock(&dq->lock);
-	hisi_hba->hw->start_delivery(dq);
-	spin_unlock(&dq->lock);
+	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, abort);
 
 	return 0;
 
 err_out:
-	dev_err(dev, "internal abort task prep: failed[%d]!\n", rc);
+	dev_err(dev, "internal abort task prep: failed[%d]!\n", slot_idx);
 
-	return rc;
+	return slot_idx;
 }
 
 /**
@@ -2070,9 +2039,12 @@ _hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 {
 	struct sas_task *task;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
+	struct hisi_sas_internal_abort abort = {
+		.flag = abort_flag,
+		.tag = tag,
+	};
 	struct device *dev = hisi_hba->dev;
 	int res;
-
 	/*
 	 * The interface is not realized means this HW don't support internal
 	 * abort, or don't need to do internal abort. Then here, we return
@@ -2097,7 +2069,7 @@ _hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 	add_timer(&task->slow_task->timer);
 
 	res = hisi_sas_internal_abort_task_exec(hisi_hba, sas_dev->device_id,
-						task, abort_flag, tag, dq);
+						&abort, task, dq);
 	if (res) {
 		del_timer(&task->slow_task->timer);
 		dev_err(dev, "internal task abort: executing internal task failed: %d\n",
@@ -2312,7 +2284,6 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
 	.lldd_control_phy	= hisi_sas_control_phy,
 	.lldd_abort_task	= hisi_sas_abort_task,
 	.lldd_abort_task_set	= hisi_sas_abort_task_set,
-	.lldd_clear_aca		= hisi_sas_clear_aca,
 	.lldd_I_T_nexus_reset	= hisi_sas_I_T_nexus_reset,
 	.lldd_lu_reset		= hisi_sas_lu_reset,
 	.lldd_query_task	= hisi_sas_query_task,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 862f4e8b7eb5..76756dd318d7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -958,7 +958,7 @@ static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = slot->port;
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
 	u8 *buf_cmd, fburst = 0;
 	u32 dw1, dw2;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index a6d89a149546..0582737b1d30 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -1742,7 +1742,7 @@ static void prep_ssp_v2_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = slot->port;
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
 	u8 *buf_cmd;
 	u32 dw1 = 0, dw2 = 0;
@@ -2499,7 +2499,8 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_port *port = to_hisi_sas_port(sas_port);
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
+	int phy_id;
 	u8 *buf_cmd;
 	int has_data = 0, hdr_tag = 0;
 	u32 dw0, dw1 = 0, dw2 = 0;
@@ -2507,10 +2508,14 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
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
 
 	if (tmf && tmf->force_phy) {
 		dw0 |= CMD_HDR_FORCE_PHY_MSK;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 3f3d768548c5..6d467ae9d337 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -356,6 +356,10 @@
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
@@ -1223,7 +1227,7 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = slot->port;
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
-	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
 	unsigned char prot_op;
 	u8 *buf_cmd;
@@ -1384,15 +1388,21 @@ static void prep_ata_v3_hw(struct hisi_hba *hisi_hba,
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
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index ffd33e5decae..bd73f6925a9d 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -191,7 +191,6 @@ static struct sas_domain_function_template isci_transport_ops  = {
 	/* Task Management Functions. Must be called from process context. */
 	.lldd_abort_task	= isci_task_abort_task,
 	.lldd_abort_task_set	= isci_task_abort_task_set,
-	.lldd_clear_aca		= isci_task_clear_aca,
 	.lldd_clear_task_set	= isci_task_clear_task_set,
 	.lldd_I_T_nexus_reset	= isci_task_I_T_nexus_reset,
 	.lldd_lu_reset		= isci_task_lu_reset,
diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
index 3fd88d72a0c0..403bfee34d84 100644
--- a/drivers/scsi/isci/task.c
+++ b/drivers/scsi/isci/task.c
@@ -625,24 +625,6 @@ int isci_task_abort_task_set(
 }
 
 
-/**
- * isci_task_clear_aca() - This function is one of the SAS Domain Template
- *    functions. This is one of the Task Management functoins called by libsas.
- * @d_device: This parameter specifies the domain device associated with this
- *    request.
- * @lun: This parameter specifies the lun	 associated with this request.
- *
- * status, zero indicates success.
- */
-int isci_task_clear_aca(
-	struct domain_device *d_device,
-	u8 *lun)
-{
-	return TMF_RESP_FUNC_FAILED;
-}
-
-
-
 /**
  * isci_task_clear_task_set() - This function is one of the SAS Domain Template
  *    functions. This is one of the Task Management functoins called by libsas.
diff --git a/drivers/scsi/isci/task.h b/drivers/scsi/isci/task.h
index 8f4531f22ac2..5939cb175a20 100644
--- a/drivers/scsi/isci/task.h
+++ b/drivers/scsi/isci/task.h
@@ -140,10 +140,6 @@ int isci_task_abort_task_set(
 	struct domain_device *d_device,
 	u8 *lun);
 
-int isci_task_clear_aca(
-	struct domain_device *d_device,
-	u8 *lun);
-
 int isci_task_clear_task_set(
 	struct domain_device *d_device,
 	u8 *lun);
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 5f44a0763f37..134d56bd00da 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1517,10 +1517,13 @@ lpfc_initial_flogi(struct lpfc_vport *vport)
 	}
 
 	if (lpfc_issue_els_flogi(vport, ndlp, 0)) {
-		/* This decrement of reference count to node shall kick off
-		 * the release of the node.
+		/* A node reference should be retained while registered with a
+		 * transport or dev-loss-evt work is pending.
+		 * Otherwise, decrement node reference to trigger release.
 		 */
-		lpfc_nlp_put(ndlp);
+		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
+		    !(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+			lpfc_nlp_put(ndlp);
 		return 0;
 	}
 	return 1;
@@ -1563,10 +1566,13 @@ lpfc_initial_fdisc(struct lpfc_vport *vport)
 	}
 
 	if (lpfc_issue_els_fdisc(vport, ndlp, 0)) {
-		/* decrement node reference count to trigger the release of
-		 * the node.
+		/* A node reference should be retained while registered with a
+		 * transport or dev-loss-evt work is pending.
+		 * Otherwise, decrement node reference to trigger release.
 		 */
-		lpfc_nlp_put(ndlp);
+		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
+		    !(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+			lpfc_nlp_put(ndlp);
 		return 0;
 	}
 	return 1;
@@ -1967,6 +1973,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_dmabuf *prsp;
 	int disc;
 	struct serv_parm *sp = NULL;
+	bool release_node = false;
 
 	/* we pass cmdiocb to state machine which needs rspiocb as well */
 	cmdiocb->context_un.rsp_iocb = rspiocb;
@@ -2047,19 +2054,21 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			spin_unlock_irq(&ndlp->lock);
 			goto out;
 		}
-		spin_unlock_irq(&ndlp->lock);
 
 		/* No PLOGI collision and the node is not registered with the
 		 * scsi or nvme transport. It is no longer an active node. Just
 		 * start the device remove process.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-			spin_lock_irq(&ndlp->lock);
 			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+				release_node = true;
+		}
+		spin_unlock_irq(&ndlp->lock);
+
+		if (release_node)
 			lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 						NLP_EVT_DEVICE_RM);
-		}
 	} else {
 		/* Good status, call state machine */
 		prsp = list_entry(((struct lpfc_dmabuf *)
@@ -2269,6 +2278,7 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_nodelist *ndlp;
 	char *mode;
 	u32 loglevel;
+	bool release_node = false;
 
 	/* we pass cmdiocb to state machine which needs rspiocb as well */
 	cmdiocb->context_un.rsp_iocb = rspiocb;
@@ -2335,14 +2345,18 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * it is no longer an active node.  Otherwise devloss
 		 * handles the final cleanup.
 		 */
+		spin_lock_irq(&ndlp->lock);
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
 		    !ndlp->fc4_prli_sent) {
-			spin_lock_irq(&ndlp->lock);
 			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+				release_node = true;
+		}
+		spin_unlock_irq(&ndlp->lock);
+
+		if (release_node)
 			lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 						NLP_EVT_DEVICE_RM);
-		}
 	} else {
 		/* Good status, call state machine.  However, if another
 		 * PRLI is outstanding, don't call the state machine
@@ -2713,6 +2727,7 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	IOCB_t *irsp;
 	struct lpfc_nodelist *ndlp;
 	int  disc;
+	bool release_node = false;
 
 	/* we pass cmdiocb to state machine which needs rspiocb as well */
 	cmdiocb->context_un.rsp_iocb = rspiocb;
@@ -2771,13 +2786,17 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * transport, it is no longer an active node. Otherwise
 		 * devloss handles the final cleanup.
 		 */
+		spin_lock_irq(&ndlp->lock);
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-			spin_lock_irq(&ndlp->lock);
 			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+				release_node = true;
+		}
+		spin_unlock_irq(&ndlp->lock);
+
+		if (release_node)
 			lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 						NLP_EVT_DEVICE_RM);
-		}
 	} else
 		/* Good status, call state machine */
 		lpfc_disc_state_machine(vport, ndlp, cmdiocb,
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 4bb0a15cfcc0..54aff304cdcf 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -6954,7 +6954,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
 	if (rc)
 		return;
 	/* Reset HBA FCF states after successful unregister FCF */
+	spin_lock_irq(&phba->hbalock);
 	phba->fcf.fcf_flag = 0;
+	spin_unlock_irq(&phba->hbalock);
 	phba->fcf.current_rec.flag = 0;
 
 	/*
diff --git a/drivers/scsi/mvsas/mv_defs.h b/drivers/scsi/mvsas/mv_defs.h
index 199ab49aa047..7123a2efbf58 100644
--- a/drivers/scsi/mvsas/mv_defs.h
+++ b/drivers/scsi/mvsas/mv_defs.h
@@ -486,9 +486,4 @@ enum datapres_field {
 	SENSE_DATA	= 2,
 };
 
-/* define task management IU */
-struct mvs_tmf_task{
-	u8 tmf;
-	u16 tag_of_task_to_be_managed;
-};
 #endif
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index f6f8ca3c8c7f..1c98662db080 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -64,7 +64,6 @@ static struct sas_domain_function_template mvs_transport_ops = {
 
 	.lldd_abort_task	= mvs_abort_task,
 	.lldd_abort_task_set    = mvs_abort_task_set,
-	.lldd_clear_aca         = mvs_clear_aca,
 	.lldd_clear_task_set    = mvs_clear_task_set,
 	.lldd_I_T_nexus_reset	= mvs_I_T_nexus_reset,
 	.lldd_lu_reset 		= mvs_lu_reset,
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 31d1ea5a5dd2..04d3710c683f 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -551,7 +551,7 @@ static int mvs_task_prep_ata(struct mvs_info *mvi,
 
 static int mvs_task_prep_ssp(struct mvs_info *mvi,
 			     struct mvs_task_exec_info *tei, int is_tmf,
-			     struct mvs_tmf_task *tmf)
+			     struct sas_tmf_task *tmf)
 {
 	struct sas_task *task = tei->task;
 	struct mvs_cmd_hdr *hdr = tei->hdr;
@@ -691,7 +691,7 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 
 #define	DEV_IS_GONE(mvi_dev)	((!mvi_dev || (mvi_dev->dev_type == SAS_PHY_UNUSED)))
 static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf,
-				struct mvs_tmf_task *tmf, int *pass)
+				struct sas_tmf_task *tmf, int *pass)
 {
 	struct domain_device *dev = task->dev;
 	struct mvs_device *mvi_dev = dev->lldd_dev;
@@ -837,7 +837,7 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 
 static int mvs_task_exec(struct sas_task *task, gfp_t gfp_flags,
 				struct completion *completion, int is_tmf,
-				struct mvs_tmf_task *tmf)
+				struct sas_tmf_task *tmf)
 {
 	struct mvs_info *mvi = NULL;
 	u32 rc = 0;
@@ -1275,7 +1275,7 @@ static void mvs_tmf_timedout(struct timer_list *t)
 
 #define MVS_TASK_TIMEOUT 20
 static int mvs_exec_internal_tmf_task(struct domain_device *dev,
-			void *parameter, u32 para_len, struct mvs_tmf_task *tmf)
+			void *parameter, u32 para_len, struct sas_tmf_task *tmf)
 {
 	int res, retry;
 	struct sas_task *task = NULL;
@@ -1350,7 +1350,7 @@ static int mvs_exec_internal_tmf_task(struct domain_device *dev,
 }
 
 static int mvs_debug_issue_ssp_tmf(struct domain_device *dev,
-				u8 *lun, struct mvs_tmf_task *tmf)
+				u8 *lun, struct sas_tmf_task *tmf)
 {
 	struct sas_ssp_task ssp_task;
 	if (!(dev->tproto & SAS_PROTOCOL_SSP))
@@ -1382,7 +1382,7 @@ int mvs_lu_reset(struct domain_device *dev, u8 *lun)
 {
 	unsigned long flags;
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct mvs_device * mvi_dev = dev->lldd_dev;
 	struct mvs_info *mvi = mvi_dev->mvi_info;
 
@@ -1426,7 +1426,7 @@ int mvs_query_task(struct sas_task *task)
 {
 	u32 tag;
 	struct scsi_lun lun;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
@@ -1463,7 +1463,7 @@ int mvs_query_task(struct sas_task *task)
 int mvs_abort_task(struct sas_task *task)
 {
 	struct scsi_lun lun;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct domain_device *dev = task->dev;
 	struct mvs_device *mvi_dev = (struct mvs_device *)dev->lldd_dev;
 	struct mvs_info *mvi;
@@ -1540,7 +1540,7 @@ int mvs_abort_task(struct sas_task *task)
 int mvs_abort_task_set(struct domain_device *dev, u8 *lun)
 {
 	int rc;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_ABORT_TASK_SET;
 	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
@@ -1548,21 +1548,10 @@ int mvs_abort_task_set(struct domain_device *dev, u8 *lun)
 	return rc;
 }
 
-int mvs_clear_aca(struct domain_device *dev, u8 *lun)
-{
-	int rc = TMF_RESP_FUNC_FAILED;
-	struct mvs_tmf_task tmf_task;
-
-	tmf_task.tmf = TMF_CLEAR_ACA;
-	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
-
-	return rc;
-}
-
 int mvs_clear_task_set(struct domain_device *dev, u8 *lun)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct mvs_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_CLEAR_TASK_SET;
 	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
index 8ff976c9967e..fa654c73beee 100644
--- a/drivers/scsi/mvsas/mv_sas.h
+++ b/drivers/scsi/mvsas/mv_sas.h
@@ -441,7 +441,6 @@ int mvs_scan_finished(struct Scsi_Host *shost, unsigned long time);
 int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags);
 int mvs_abort_task(struct sas_task *task);
 int mvs_abort_task_set(struct domain_device *dev, u8 *lun);
-int mvs_clear_aca(struct domain_device *dev, u8 *lun);
 int mvs_clear_task_set(struct domain_device *dev, u8 * lun);
 void mvs_port_formed(struct asd_sas_phy *sas_phy);
 void mvs_port_deformed(struct asd_sas_phy *sas_phy);
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 352705e023c8..537b762a2b83 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4624,7 +4624,7 @@ int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
  * @tmf: task management function.
  */
 int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
-	struct pm8001_ccb_info *ccb, struct pm8001_tmf_task *tmf)
+	struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf)
 {
 	struct sas_task *task = ccb->task;
 	struct domain_device *dev = task->dev;
@@ -4636,7 +4636,7 @@ int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
 
 	memset(&sspTMCmd, 0, sizeof(sspTMCmd));
 	sspTMCmd.device_id = cpu_to_le32(pm8001_dev->device_id);
-	sspTMCmd.relate_tag = cpu_to_le32(tmf->tag_of_task_to_be_managed);
+	sspTMCmd.relate_tag = cpu_to_le32((u32)tmf->tag_of_task_to_be_managed);
 	sspTMCmd.tmf = cpu_to_le32(tmf->tmf);
 	memcpy(sspTMCmd.lun, task->ssp_task.LUN, 8);
 	sspTMCmd.tag = cpu_to_le32(ccb->ccb_tag);
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index a54460fe8630..0659ee9aafce 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -123,7 +123,6 @@ static struct sas_domain_function_template pm8001_transport_ops = {
 
 	.lldd_abort_task	= pm8001_abort_task,
 	.lldd_abort_task_set	= pm8001_abort_task_set,
-	.lldd_clear_aca		= pm8001_clear_aca,
 	.lldd_clear_task_set	= pm8001_clear_task_set,
 	.lldd_I_T_nexus_reset   = pm8001_I_T_nexus_reset,
 	.lldd_lu_reset		= pm8001_lu_reset,
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 5fb08acbc0e5..0c79f2a9eba7 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -335,7 +335,7 @@ static int pm8001_task_prep_ata(struct pm8001_hba_info *pm8001_ha,
   * @tmf: the task management IU
   */
 static int pm8001_task_prep_ssp_tm(struct pm8001_hba_info *pm8001_ha,
-	struct pm8001_ccb_info *ccb, struct pm8001_tmf_task *tmf)
+	struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf)
 {
 	return PM8001_CHIP_DISP->ssp_tm_req(pm8001_ha, ccb, tmf);
 }
@@ -378,7 +378,7 @@ static int sas_find_local_port_id(struct domain_device *dev)
   * @tmf: the task management IU
   */
 static int pm8001_task_exec(struct sas_task *task,
-	gfp_t gfp_flags, int is_tmf, struct pm8001_tmf_task *tmf)
+	gfp_t gfp_flags, int is_tmf, struct sas_tmf_task *tmf)
 {
 	struct domain_device *dev = task->dev;
 	struct pm8001_hba_info *pm8001_ha;
@@ -715,7 +715,7 @@ static void pm8001_tmf_timedout(struct timer_list *t)
   * this function, note it is also with the task execute interface.
   */
 static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
-	void *parameter, u32 para_len, struct pm8001_tmf_task *tmf)
+	void *parameter, u32 para_len, struct sas_tmf_task *tmf)
 {
 	int res, retry;
 	struct sas_task *task = NULL;
@@ -892,6 +892,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
+		pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;
 		pm8001_free_dev(pm8001_dev);
 	} else {
 		pm8001_dbg(pm8001_ha, DISC, "Found dev has gone.\n");
@@ -906,7 +907,7 @@ void pm8001_dev_gone(struct domain_device *dev)
 }
 
 static int pm8001_issue_ssp_tmf(struct domain_device *dev,
-	u8 *lun, struct pm8001_tmf_task *tmf)
+	u8 *lun, struct sas_tmf_task *tmf)
 {
 	struct sas_ssp_task ssp_task;
 	if (!(dev->tproto & SAS_PROTOCOL_SSP))
@@ -1108,7 +1109,7 @@ int pm8001_I_T_nexus_event_handler(struct domain_device *dev)
 int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 	DECLARE_COMPLETION_ONSTACK(completion_setstate);
@@ -1137,7 +1138,7 @@ int pm8001_query_task(struct sas_task *task)
 {
 	u32 tag = 0xdeadbeef;
 	struct scsi_lun lun;
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 	if (unlikely(!task || !task->lldd_task || !task->dev))
 		return rc;
@@ -1186,7 +1187,7 @@ int pm8001_abort_task(struct sas_task *task)
 	struct pm8001_hba_info *pm8001_ha;
 	struct scsi_lun lun;
 	struct pm8001_device *pm8001_dev;
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED, ret;
 	u32 phy_id;
 	struct sas_task_slow slow_task;
@@ -1335,23 +1336,15 @@ int pm8001_abort_task(struct sas_task *task)
 
 int pm8001_abort_task_set(struct domain_device *dev, u8 *lun)
 {
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 
 	tmf_task.tmf = TMF_ABORT_TASK_SET;
 	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
 }
 
-int pm8001_clear_aca(struct domain_device *dev, u8 *lun)
-{
-	struct pm8001_tmf_task tmf_task;
-
-	tmf_task.tmf = TMF_CLEAR_ACA;
-	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
-}
-
 int pm8001_clear_task_set(struct domain_device *dev, u8 *lun)
 {
-	struct pm8001_tmf_task tmf_task;
+	struct sas_tmf_task tmf_task;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index f40a41f450d9..75864b47921a 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -99,11 +99,7 @@ extern const struct pm8001_dispatch pm8001_80xx_dispatch;
 struct pm8001_hba_info;
 struct pm8001_ccb_info;
 struct pm8001_device;
-/* define task management IU */
-struct pm8001_tmf_task {
-	u8	tmf;
-	u32	tag_of_task_to_be_managed;
-};
+
 struct pm8001_ioctl_payload {
 	u32	signature;
 	u16	major_function;
@@ -203,7 +199,7 @@ struct pm8001_dispatch {
 		struct pm8001_device *pm8001_dev, u8 flag, u32 task_tag,
 		u32 cmd_tag);
 	int (*ssp_tm_req)(struct pm8001_hba_info *pm8001_ha,
-		struct pm8001_ccb_info *ccb, struct pm8001_tmf_task *tmf);
+		struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf);
 	int (*get_nvmd_req)(struct pm8001_hba_info *pm8001_ha, void *payload);
 	int (*set_nvmd_req)(struct pm8001_hba_info *pm8001_ha, void *payload);
 	int (*fw_flash_update_req)(struct pm8001_hba_info *pm8001_ha,
@@ -645,7 +641,6 @@ int pm8001_scan_finished(struct Scsi_Host *shost, unsigned long time);
 int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags);
 int pm8001_abort_task(struct sas_task *task);
 int pm8001_abort_task_set(struct domain_device *dev, u8 *lun);
-int pm8001_clear_aca(struct domain_device *dev, u8 *lun);
 int pm8001_clear_task_set(struct domain_device *dev, u8 *lun);
 int pm8001_dev_found(struct domain_device *dev);
 void pm8001_dev_gone(struct domain_device *dev);
@@ -683,7 +678,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha, void *payload);
 int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha, void *payload);
 int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
 				struct pm8001_ccb_info *ccb,
-				struct pm8001_tmf_task *tmf);
+				struct sas_tmf_task *tmf);
 int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
 				struct pm8001_device *pm8001_dev,
 				u8 flag, u32 task_tag, u32 cmd_tag);
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index f839e8e497be..8930acdff08c 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3228,11 +3228,14 @@ iscsi_set_host_param(struct iscsi_transport *transport,
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
index 1551d533c719..956b3b9c5aad 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4109,7 +4109,7 @@ static void validate_options(void)
  */
 static int __init st_setup(char *str)
 {
-	int i, len, ints[5];
+	int i, len, ints[ARRAY_SIZE(parms) + 1];
 	char *stp;
 
 	stp = get_options(str, ARRAY_SIZE(ints), ints);
diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index 16e8ddcf22fe..b8bbfd81b8ae 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -175,6 +175,7 @@ void ufs_bsg_remove(struct ufs_hba *hba)
 		return;
 
 	bsg_remove_queue(hba->bsg_queue);
+	hba->bsg_queue = NULL;
 
 	device_del(bsg_dev);
 	put_device(bsg_dev);
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 5c1d0f97f766..edcae687cd2a 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -24,6 +25,17 @@
 
 #include "exynos-asv.h"
 
+struct exynos_chipid_variant {
+	unsigned int rev_reg;		/* revision register offset */
+	unsigned int main_rev_shift;	/* main revision offset in rev_reg */
+	unsigned int sub_rev_shift;	/* sub revision offset in rev_reg */
+};
+
+struct exynos_chipid_info {
+	u32 product_id;
+	u32 revision;
+};
+
 static const struct exynos_soc_id {
 	const char *name;
 	unsigned int id;
@@ -49,31 +61,57 @@ static const char *product_id_to_soc_id(unsigned int product_id)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
-		if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
+		if (product_id == soc_ids[i].id)
 			return soc_ids[i].name;
 	return NULL;
 }
 
+static int exynos_chipid_get_chipid_info(struct regmap *regmap,
+		const struct exynos_chipid_variant *data,
+		struct exynos_chipid_info *soc_info)
+{
+	int ret;
+	unsigned int val, main_rev, sub_rev;
+
+	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &val);
+	if (ret < 0)
+		return ret;
+	soc_info->product_id = val & EXYNOS_MASK;
+
+	if (data->rev_reg != EXYNOS_CHIPID_REG_PRO_ID) {
+		ret = regmap_read(regmap, data->rev_reg, &val);
+		if (ret < 0)
+			return ret;
+	}
+	main_rev = (val >> data->main_rev_shift) & EXYNOS_REV_PART_MASK;
+	sub_rev = (val >> data->sub_rev_shift) & EXYNOS_REV_PART_MASK;
+	soc_info->revision = (main_rev << EXYNOS_REV_PART_SHIFT) | sub_rev;
+
+	return 0;
+}
+
 static int exynos_chipid_probe(struct platform_device *pdev)
 {
+	const struct exynos_chipid_variant *drv_data;
+	struct exynos_chipid_info soc_info;
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device_node *root;
 	struct regmap *regmap;
-	u32 product_id;
-	u32 revision;
 	int ret;
 
+	drv_data = of_device_get_match_data(&pdev->dev);
+	if (!drv_data)
+		return -EINVAL;
+
 	regmap = device_node_to_regmap(pdev->dev.of_node);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &product_id);
+	ret = exynos_chipid_get_chipid_info(regmap, drv_data, &soc_info);
 	if (ret < 0)
 		return ret;
 
-	revision = product_id & EXYNOS_REV_MASK;
-
 	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
 				    GFP_KERNEL);
 	if (!soc_dev_attr)
@@ -86,8 +124,10 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	of_node_put(root);
 
 	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"%x", revision);
-	soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
+						"%x", soc_info.revision);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
+	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");
 		return -ENODEV;
@@ -104,9 +144,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, soc_dev);
 
-	dev_info(soc_device_to_device(soc_dev),
-		 "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
-		 soc_dev_attr->soc_id, product_id, revision);
+	dev_info(&pdev->dev, "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
+		 soc_dev_attr->soc_id, soc_info.product_id, soc_info.revision);
 
 	return 0;
 
@@ -125,9 +164,18 @@ static int exynos_chipid_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct exynos_chipid_variant exynos4210_chipid_drv_data = {
+	.rev_reg	= 0x0,
+	.main_rev_shift	= 4,
+	.sub_rev_shift	= 0,
+};
+
 static const struct of_device_id exynos_chipid_of_device_ids[] = {
-	{ .compatible = "samsung,exynos4210-chipid" },
-	{}
+	{
+		.compatible	= "samsung,exynos4210-chipid",
+		.data		= &exynos4210_chipid_drv_data,
+	},
+	{ }
 };
 
 static struct platform_driver exynos_chipid_driver = {
diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index f32e1cbbe8c5..1248d5d56c8d 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -696,6 +696,8 @@ static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
 	data = prm->data;
 	name = devm_kasprintf(dev, GFP_KERNEL, "prm_%s",
 			      data->name);
+	if (!name)
+		return -ENOMEM;
 
 	prmd->dev = dev;
 	prmd->prm = prm;
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5c8f198b0ae3..a60399417a28 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1370,6 +1370,12 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 	if (IS_ERR(cqspi->rx_chan)) {
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
index 657d84b9963e..5822445a80ec 100644
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
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 69a32d94ec9d..493bde7b8e39 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -595,8 +595,11 @@ static void sifive_serial_break_ctl(struct uart_port *port, int break_state)
 static int sifive_serial_startup(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_enable_rxwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 
 	return 0;
 }
@@ -604,9 +607,12 @@ static int sifive_serial_startup(struct uart_port *port)
 static void sifive_serial_shutdown(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_disable_rxwm(ssp);
 	__ssp_disable_txwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 }
 
 /**
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 2b8f98f0707e..c12d7f040171 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1960,6 +1960,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 	unsigned int bit;
 	unsigned long reg;
 
+	local_bh_disable();
 	spin_lock_irqsave(&priv_dev->lock, flags);
 
 	reg = readl(&priv_dev->regs->usb_ists);
@@ -2001,6 +2002,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 irqend:
 	writel(~0, &priv_dev->regs->ep_ien);
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 13731e85980e..a72459b8197c 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -322,6 +322,13 @@ static int ci_hdrc_imx_notify_event(struct ci_hdrc *ci, unsigned int event)
 	return ret;
 }
 
+static void ci_hdrc_imx_disable_regulator(void *arg)
+{
+	struct ci_hdrc_imx_data *data = arg;
+
+	regulator_disable(data->hsic_pad_regulator);
+}
+
 static int ci_hdrc_imx_probe(struct platform_device *pdev)
 {
 	struct ci_hdrc_imx_data *data;
@@ -379,6 +386,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 					"Failed to enable HSIC pad regulator\n");
 				goto err_put;
 			}
+			ret = devm_add_action_or_reset(dev,
+					ci_hdrc_imx_disable_regulator, data);
+			if (ret) {
+				dev_err(dev,
+					"Failed to add regulator devm action\n");
+				goto err_put;
+			}
 		}
 	}
 
@@ -417,11 +431,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	ret = imx_get_clks(dev);
 	if (ret)
-		goto disable_hsic_regulator;
+		goto qos_remove_request;
 
 	ret = imx_prepare_enable_clks(dev);
 	if (ret)
-		goto disable_hsic_regulator;
+		goto qos_remove_request;
 
 	data->phy = devm_usb_get_phy_by_phandle(dev, "fsl,usbphy", 0);
 	if (IS_ERR(data->phy)) {
@@ -447,7 +461,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	    of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
 		pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
 		data->override_phy_control = true;
-		usb_phy_init(pdata.usb_phy);
+		ret = usb_phy_init(pdata.usb_phy);
+		if (ret) {
+			dev_err(dev, "Failed to init phy\n");
+			goto err_clk;
+		}
 	}
 
 	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
@@ -456,7 +474,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	ret = imx_usbmisc_init(data->usbmisc_data);
 	if (ret) {
 		dev_err(dev, "usbmisc init failed, ret=%d\n", ret);
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	data->ci_pdev = ci_hdrc_add_device(dev,
@@ -465,7 +483,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(data->ci_pdev)) {
 		ret = PTR_ERR(data->ci_pdev);
 		dev_err_probe(dev, ret, "ci_hdrc_add_device failed\n");
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	if (data->usbmisc_data) {
@@ -499,17 +517,18 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
+phy_shutdown:
+	if (data->override_phy_control)
+		usb_phy_shutdown(data->phy);
 err_clk:
 	imx_disable_unprepare_clks(dev);
-disable_hsic_regulator:
-	if (data->hsic_pad_regulator)
-		/* don't overwrite original ret (cf. EPROBE_DEFER) */
-		regulator_disable(data->hsic_pad_regulator);
+qos_remove_request:
 	if (pdata.flags & CI_HDRC_PMQOS)
 		cpu_latency_qos_remove_request(&data->pm_qos_req);
 	data->ci_pdev = NULL;
 err_put:
-	put_device(data->usbmisc_data->dev);
+	if (data->usbmisc_data)
+		put_device(data->usbmisc_data->dev);
 	return ret;
 }
 
@@ -530,10 +549,9 @@ static void ci_hdrc_imx_remove(struct platform_device *pdev)
 		imx_disable_unprepare_clks(&pdev->dev);
 		if (data->plat_data->flags & CI_HDRC_PMQOS)
 			cpu_latency_qos_remove_request(&data->pm_qos_req);
-		if (data->hsic_pad_regulator)
-			regulator_disable(data->hsic_pad_regulator);
 	}
-	put_device(data->usbmisc_data->dev);
+	if (data->usbmisc_data)
+		put_device(data->usbmisc_data->dev);
 }
 
 static void ci_hdrc_imx_shutdown(struct platform_device *pdev)
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index d85606bad562..a4be6dba756b 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -726,7 +726,7 @@ static int wdm_open(struct inode *inode, struct file *file)
 		rv = -EBUSY;
 		goto out;
 	}
-
+	smp_rmb(); /* ordered against wdm_wwan_port_stop() */
 	rv = usb_autopm_get_interface(desc->intf);
 	if (rv < 0) {
 		dev_err(&desc->intf->dev, "Error autopm - %d\n", rv);
@@ -829,6 +829,7 @@ static struct usb_class_driver wdm_class = {
 static int wdm_wwan_port_start(struct wwan_port *port)
 {
 	struct wdm_device *desc = wwan_port_get_drvdata(port);
+	int rv;
 
 	/* The interface is both exposed via the WWAN framework and as a
 	 * legacy usbmisc chardev. If chardev is already open, just fail
@@ -848,7 +849,15 @@ static int wdm_wwan_port_start(struct wwan_port *port)
 	wwan_port_txon(port);
 
 	/* Start getting events */
-	return usb_submit_urb(desc->validity, GFP_KERNEL);
+	rv = usb_submit_urb(desc->validity, GFP_KERNEL);
+	if (rv < 0) {
+		wwan_port_txoff(port);
+		desc->manage_power(desc->intf, 0);
+		/* this must be last lest we race with chardev open */
+		clear_bit(WDM_WWAN_IN_USE, &desc->flags);
+	}
+
+	return rv;
 }
 
 static void wdm_wwan_port_stop(struct wwan_port *port)
@@ -859,8 +868,10 @@ static void wdm_wwan_port_stop(struct wwan_port *port)
 	poison_urbs(desc);
 	desc->manage_power(desc->intf, 0);
 	clear_bit(WDM_READ, &desc->flags);
-	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
 	unpoison_urbs(desc);
+	smp_wmb(); /* ordered against wdm_open() */
+	/* this must be last lest we open a poisoned device */
+	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
 }
 
 static void wdm_wwan_port_tx_complete(struct urb *urb)
@@ -868,7 +879,7 @@ static void wdm_wwan_port_tx_complete(struct urb *urb)
 	struct sk_buff *skb = urb->context;
 	struct wdm_device *desc = skb_shinfo(skb)->destructor_arg;
 
-	usb_autopm_put_interface(desc->intf);
+	usb_autopm_put_interface_async(desc->intf);
 	wwan_port_txon(desc->wwanp);
 	kfree_skb(skb);
 }
@@ -898,7 +909,7 @@ static int wdm_wwan_port_tx(struct wwan_port *port, struct sk_buff *skb)
 	req->bRequestType = (USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE);
 	req->bRequest = USB_CDC_SEND_ENCAPSULATED_COMMAND;
 	req->wValue = 0;
-	req->wIndex = desc->inum;
+	req->wIndex = desc->inum; /* already converted */
 	req->wLength = cpu_to_le16(skb->len);
 
 	skb_shinfo(skb)->destructor_arg = desc;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index a312363d584f..491d209e7e69 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -366,6 +366,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0781, 0x5583), .driver_info = USB_QUIRK_NO_LPM },
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* SanDisk Corp. SanDisk 3.2Gen1 */
+	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Realforce 87U Keyboard */
 	{ USB_DEVICE(0x0853, 0x011b), .driver_info = USB_QUIRK_NO_LPM },
 
@@ -380,6 +383,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0904, 0x6103), .driver_info =
 			USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL },
 
+	/* Silicon Motion Flash Drive */
+	{ USB_DEVICE(0x090c, 0x1000), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Sound Devices USBPre2 */
 	{ USB_DEVICE(0x0926, 0x0202), .driver_info =
 			USB_QUIRK_ENDPOINT_IGNORE },
@@ -533,6 +539,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
 
+	/* VLI disk */
+	{ USB_DEVICE(0x2109, 0x0711), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Raydium Touchscreen */
 	{ USB_DEVICE(0x2386, 0x3114), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 1872de3ce98b..5e0b326875fa 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -132,11 +132,21 @@ static const struct property_entry dwc3_pci_intel_byt_properties[] = {
 	{}
 };
 
+/*
+ * Intel Merrifield SoC uses these endpoints for tracing and they cannot
+ * be re-allocated if being used because the side band flow control signals
+ * are hard wired to certain endpoints:
+ * - 1 High BW Bulk IN (IN#1) (RTIT)
+ * - 1 1KB BW Bulk IN (IN#8) + 1 1KB BW Bulk OUT (Run Control) (OUT#8)
+ */
+static const u8 dwc3_pci_mrfld_reserved_endpoints[] = { 3, 16, 17 };
+
 static const struct property_entry dwc3_pci_mrfld_properties[] = {
 	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "mrfld_bcove_pwrsrc"),
 	PROPERTY_ENTRY_BOOL("snps,dis_u3_susphy_quirk"),
 	PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
+	PROPERTY_ENTRY_U8_ARRAY("snps,reserved-endpoints", dwc3_pci_mrfld_reserved_endpoints),
 	PROPERTY_ENTRY_BOOL("snps,usb2-gadget-lpm-disable"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 	{}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fda00639ff0c..a99e669468ee 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4361,6 +4361,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+			count, evt->length);
+		return IRQ_NONE;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index d918e8b2af3c..c5f712383775 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -538,6 +538,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	d->vhub = vhub;
 	d->index = idx;
 	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
+	if (!d->name)
+		return -ENOMEM;
+
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 6d95b90683bc..37a5914f7987 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1956,6 +1956,12 @@ max3421_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id max3421_spi_ids[] = {
+	{ "max3421" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, max3421_spi_ids);
+
 static const struct of_device_id max3421_of_match_table[] = {
 	{ .compatible = "maxim,max3421", },
 	{},
@@ -1965,6 +1971,7 @@ MODULE_DEVICE_TABLE(of, max3421_of_match_table);
 static struct spi_driver max3421_driver = {
 	.probe		= max3421_probe,
 	.remove		= max3421_remove,
+	.id_table	= max3421_spi_ids,
 	.driver		= {
 		.name	= "max3421-hcd",
 		.of_match_table = of_match_ptr(max3421_of_match_table),
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 41efe927d8f3..70153ce60128 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -165,6 +165,25 @@ static int ohci_quirk_amd700(struct usb_hcd *hcd)
 	return 0;
 }
 
+static int ohci_quirk_loongson(struct usb_hcd *hcd)
+{
+	struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
+
+	/*
+	 * Loongson's LS7A OHCI controller (rev 0x02) has a
+	 * flaw. MMIO register with offset 0x60/64 is treated
+	 * as legacy PS2-compatible keyboard/mouse interface.
+	 * Since OHCI only use 4KB BAR resource, LS7A OHCI's
+	 * 32KB BAR is wrapped around (the 2nd 4KB BAR space
+	 * is the same as the 1st 4KB internally). So add 4KB
+	 * offset (0x1000) to the OHCI registers as a quirk.
+	 */
+	if (pdev->revision == 0x2)
+		hcd->regs += SZ_4K;	/* SZ_4K = 0x1000 */
+
+	return 0;
+}
+
 static int ohci_quirk_qemu(struct usb_hcd *hcd)
 {
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
@@ -224,6 +243,10 @@ static const struct pci_device_id ohci_pci_quirks[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4399),
 		.driver_data = (unsigned long)ohci_quirk_amd700,
 	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a24),
+		.driver_data = (unsigned long)ohci_quirk_loongson,
+	},
 	{
 		.vendor		= PCI_VENDOR_ID_APPLE,
 		.device		= 0x003f,
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 64bf50ea62a4..cd94b0a4e021 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1183,16 +1183,19 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Stopped state, but it will soon change to Running.
 			 *
 			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again, on
-			 * chips where this is known to help. Wait for 100ms.
+			 * Keep retrying until the EP starts and stops again.
 			 */
-			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
-				break;
 			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
 			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
 					GET_EP_CTX_STATE(ep_ctx));
+			/*
+			 * Don't retry forever if we guessed wrong or a defective HC never starts
+			 * the EP or says 'Running' but fails the command. We must give back TDs.
+			 */
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command)
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 2e1e7e4625b6..a40d5e625015 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1071,6 +1071,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 2) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
+	/* Abacus Electrics */
+	{ USB_DEVICE(FTDI_VID, ABACUS_OPTICAL_PROBE_PID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index f4d729562355..9c95ca876bae 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -435,6 +435,11 @@
 #define LINX_FUTURE_1_PID   0xF44B	/* Linx future device */
 #define LINX_FUTURE_2_PID   0xF44C	/* Linx future device */
 
+/*
+ * Abacus Electrics
+ */
+#define ABACUS_OPTICAL_PROBE_PID	0xf458 /* ABACUS ELECTRICS Optical Probe */
+
 /*
  * Oceanic product ids
  */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 715738d70cbf..b09d95da2fe5 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -611,6 +611,7 @@ static void option_instat_callback(struct urb *urb);
 /* Sierra Wireless products */
 #define SIERRA_VENDOR_ID			0x1199
 #define SIERRA_PRODUCT_EM9191			0x90d3
+#define SIERRA_PRODUCT_EM9291			0x90e3
 
 /* UNISOC (Spreadtrum) products */
 #define UNISOC_VENDOR_ID			0x1782
@@ -2432,6 +2433,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 24b8772a345e..bac5ab6377ae 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -101,6 +101,11 @@ DEVICE(nokia, NOKIA_IDS);
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
 DEVICE_N(novatel_gps, NOVATEL_IDS, 3);
 
+/* OWON electronic test and measurement equipment driver */
+#define OWON_IDS()			\
+	{ USB_DEVICE(0x5345, 0x1234) } /* HDS200 oscilloscopes and others */
+DEVICE(owon, OWON_IDS);
+
 /* Siemens USB/MPI adapter */
 #define SIEMENS_IDS()			\
 	{ USB_DEVICE(0x908, 0x0004) }
@@ -135,6 +140,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 	&motorola_tetra_device,
 	&nokia_device,
 	&novatel_gps_device,
+	&owon_device,
 	&siemens_mpi_device,
 	&suunto_device,
 	&vivopay_device,
@@ -154,6 +160,7 @@ static const struct usb_device_id id_table[] = {
 	MOTOROLA_TETRA_IDS(),
 	NOKIA_IDS(),
 	NOVATEL_IDS(),
+	OWON_IDS(),
 	SIEMENS_IDS(),
 	SUUNTO_IDS(),
 	VIVOPAY_IDS(),
diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 1f8c9b16a0fb..d460d71b4257 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -83,6 +83,13 @@ UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_LUNS),
 
+/* Reported-by: Oliver Neukum <oneukum@suse.com> */
+UNUSUAL_DEV(0x125f, 0xa94a, 0x0160, 0x0160,
+		"ADATA",
+		"Portable HDD CH94",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_ATA_1X),
+
 /* Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com> */
 UNUSUAL_DEV(0x13fd, 0x3940, 0x0000, 0x9999,
 		"Initio Corporation",
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 32ce1a6aae0d..59504edd1e55 100644
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
diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index f54d256e2d54..589dae9ebb63 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -217,7 +217,7 @@ static int led_bl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int led_bl_remove(struct platform_device *pdev)
+static void led_bl_remove(struct platform_device *pdev)
 {
 	struct led_bl_data *priv = platform_get_drvdata(pdev);
 	struct backlight_device *bl = priv->bl_dev;
@@ -226,10 +226,11 @@ static int led_bl_remove(struct platform_device *pdev)
 	backlight_device_unregister(bl);
 
 	led_bl_power_off(priv);
-	for (i = 0; i < priv->nb_leds; i++)
+	for (i = 0; i < priv->nb_leds; i++) {
+		mutex_lock(&priv->leds[i]->led_access);
 		led_sysfs_enable(priv->leds[i]);
-
-	return 0;
+		mutex_unlock(&priv->leds[i]->led_access);
+	}
 }
 
 static const struct of_device_id led_bl_of_match[] = {
@@ -245,7 +246,7 @@ static struct platform_driver led_bl_driver = {
 		.of_match_table	= of_match_ptr(led_bl_of_match),
 	},
 	.probe		= led_bl_probe,
-	.remove		= led_bl_remove,
+	.remove_new	= led_bl_remove,
 };
 
 module_platform_driver(led_bl_driver);
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index b2d6e6df2161..d852bef1d507 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -2751,9 +2751,13 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
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
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 1b2c3aca6887..474b0173323a 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -241,7 +241,7 @@ config XEN_PRIVCMD
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
 	  This ACPI processor uploads Power Management information to the Xen
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
index 9ea9614107a4..cc9543ed9460 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -340,6 +340,7 @@ config GRACE_PERIOD
 config LOCKD
 	tristate
 	depends on FILE_LOCKING
+	select CRC32
 	select GRACE_PERIOD
 
 config LOCKD_V4
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5d8cf38cb9b9..27994da46caa 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1559,8 +1559,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
 			BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	if (!IS_ERR(subvol_name)) {
-		seq_puts(seq, ",subvol=");
-		seq_escape(seq, subvol_name, " \t\n\\");
+		seq_show_option(seq, "subvol", subvol_name);
 		kfree(subvol_name);
 	}
 	return 0;
diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index 8eb91bd18439..dd39097027b5 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -382,6 +382,8 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 		list_for_each(tmp2, &server->smb_ses_list) {
 			ses = list_entry(tmp2, struct cifs_ses,
 					 smb_ses_list);
+			if (ses->status == CifsExiting)
+				continue;
 			i++;
 			if ((ses->serverDomain == NULL) ||
 				(ses->serverOS == NULL) ||
@@ -611,6 +613,8 @@ static int cifs_stats_proc_show(struct seq_file *m, void *v)
 		list_for_each(tmp2, &server->smb_ses_list) {
 			ses = list_entry(tmp2, struct cifs_ses,
 					 smb_ses_list);
+			if (cifs_ses_exiting(ses))
+				continue;
 			list_for_each(tmp3, &ses->tcon_list) {
 				tcon = list_entry(tmp3,
 						  struct cifs_tcon,
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 7b57cc5d7022..68b9b382d44b 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1719,6 +1719,7 @@ static inline bool is_retryable_error(int error)
 #define   MID_RETRY_NEEDED      8 /* session closed while this request out */
 #define   MID_RESPONSE_MALFORMED 0x10
 #define   MID_SHUTDOWN		 0x20
+#define   MID_RESPONSE_READY 0x40 /* ready for other process handle the rsp */
 
 /* Flags */
 #define   MID_WAIT_CANCELLED	 1 /* Cancelled while waiting for response */
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 50844d51da5d..7d00802f9722 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -83,7 +83,7 @@ extern struct mid_q_entry *AllocMidQEntry(const struct smb_hdr *smb_buffer,
 					struct TCP_Server_Info *server);
 extern void DeleteMidQEntry(struct mid_q_entry *midEntry);
 extern void cifs_delete_mid(struct mid_q_entry *mid);
-extern void cifs_mid_q_entry_release(struct mid_q_entry *midEntry);
+void _cifs_mid_q_entry_release(struct kref *refcount);
 extern void cifs_wake_up_task(struct mid_q_entry *mid);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct mid_q_entry *mid);
@@ -637,4 +637,9 @@ static inline int cifs_create_options(struct cifs_sb_info *cifs_sb, int options)
 struct super_block *cifs_get_tcon_super(struct cifs_tcon *tcon);
 void cifs_put_tcon_super(struct super_block *sb);
 
+static inline void cifs_mid_q_entry_release(struct mid_q_entry *midEntry)
+{
+	kref_put(&midEntry->refcount, _cifs_mid_q_entry_release);
+}
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 96788385e1e7..51ceaf9ea315 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1683,7 +1683,7 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		goto out;
 	}
 
-	cifs_dbg(FYI, "IPC tcon rc = %d ipc tid = %d\n", rc, tcon->tid);
+	cifs_dbg(FYI, "IPC tcon rc=%d ipc tid=0x%x\n", rc, tcon->tid);
 
 	ses->tcon_ipc = tcon;
 out:
diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 24c42043a227..c3a71c69d339 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -1088,6 +1088,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
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
diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index 71883ba9e567..e846c18b71d2 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -232,7 +232,8 @@ static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
 		spin_lock(&cifs_tcp_ses_lock);
 		list_for_each_entry(server_it, &cifs_tcp_ses_list, tcp_ses_list) {
 			list_for_each_entry(ses_it, &server_it->smb_ses_list, smb_ses_list) {
-				if (ses_it->Suid == out.session_id) {
+				if (ses_it->status != CifsExiting &&
+				    ses_it->Suid == out.session_id) {
 					ses = ses_it;
 					/*
 					 * since we are using the session outside the crit
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 8f409404aee1..b84e682b4cae 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -759,7 +759,7 @@ __smb2_handle_cancelled_cmd(struct cifs_tcon *tcon, __u16 cmd, __u64 mid,
 {
 	struct close_cancelled_open *cancelled;
 
-	cancelled = kzalloc(sizeof(*cancelled), GFP_ATOMIC);
+	cancelled = kzalloc(sizeof(*cancelled), GFP_KERNEL);
 	if (!cancelled)
 		return -ENOMEM;
 
@@ -788,11 +788,12 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 		WARN_ONCE(tcon->tc_count < 0, "tcon refcount is negative");
 		spin_unlock(&cifs_tcp_ses_lock);
 
-		if (tcon->ses)
+		if (tcon->ses) {
 			server = tcon->ses->server;
-
-		cifs_server_dbg(FYI, "tid=%u: tcon is closing, skipping async close retry of fid %llu %llu\n",
-				tcon->tid, persistent_fid, volatile_fid);
+			cifs_server_dbg(FYI,
+					"tid=0x%x: tcon is closing, skipping async close retry of fid %llu %llu\n",
+					tcon->tid, persistent_fid, volatile_fid);
+		}
 
 		return 0;
 	}
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 7bce1ab86c4d..da9305f0b6f5 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4541,7 +4541,7 @@ smb2_get_enc_key(struct TCP_Server_Info *server, __u64 ses_id, int enc, u8 *key)
  */
 static int
 crypt_message(struct TCP_Server_Info *server, int num_rqst,
-	      struct smb_rqst *rqst, int enc)
+	      struct smb_rqst *rqst, int enc, struct crypto_aead *tfm)
 {
 	struct smb2_transform_hdr *tr_hdr =
 		(struct smb2_transform_hdr *)rqst[0].rq_iov[0].iov_base;
@@ -4552,8 +4552,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	u8 key[SMB3_ENC_DEC_KEY_SIZE];
 	struct aead_request *req;
 	u8 *iv;
-	DECLARE_CRYPTO_WAIT(wait);
-	struct crypto_aead *tfm;
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
 
@@ -4564,15 +4562,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 		return rc;
 	}
 
-	rc = smb3_crypto_aead_allocate(server);
-	if (rc) {
-		cifs_server_dbg(VFS, "%s: crypto alloc failed\n", __func__);
-		return rc;
-	}
-
-	tfm = enc ? server->secmech.ccmaesencrypt :
-						server->secmech.ccmaesdecrypt;
-
 	if ((server->cipher_type == SMB2_ENCRYPTION_AES256_CCM) ||
 		(server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
 		rc = crypto_aead_setkey(tfm, key, SMB3_GCM256_CRYPTKEY_SIZE);
@@ -4611,11 +4600,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
 	aead_request_set_ad(req, assoc_data_len);
 
-	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-				  crypto_req_done, &wait);
-
-	rc = crypto_wait_req(enc ? crypto_aead_encrypt(req)
-				: crypto_aead_decrypt(req), &wait);
+	rc = enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req);
 
 	if (!rc && enc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
@@ -4704,7 +4689,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	/* fill the 1st iov with a transform header */
 	fill_transform_hdr(tr_hdr, orig_len, old_rq, server->cipher_type);
 
-	rc = crypt_message(server, num_rqst, new_rq, 1);
+	rc = crypt_message(server, num_rqst, new_rq, 1, server->secmech.ccmaesencrypt);
 	cifs_dbg(FYI, "Encrypt message returned %d\n", rc);
 	if (rc)
 		goto err_free;
@@ -4730,8 +4715,9 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 		 unsigned int npages, unsigned int page_data_size,
 		 bool is_offloaded)
 {
-	struct kvec iov[2];
+	struct crypto_aead *tfm;
 	struct smb_rqst rqst = {NULL};
+	struct kvec iov[2];
 	int rc;
 
 	iov[0].iov_base = buf;
@@ -4746,9 +4732,31 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 	rqst.rq_pagesz = PAGE_SIZE;
 	rqst.rq_tailsz = (page_data_size % PAGE_SIZE) ? : PAGE_SIZE;
 
-	rc = crypt_message(server, 1, &rqst, 0);
+	if (is_offloaded) {
+		if ((server->cipher_type == SMB2_ENCRYPTION_AES128_GCM) ||
+		    (server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
+			tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
+		else
+			tfm = crypto_alloc_aead("ccm(aes)", 0, 0);
+		if (IS_ERR(tfm)) {
+			rc = PTR_ERR(tfm);
+			cifs_server_dbg(VFS, "%s: Failed alloc decrypt TFM, rc=%d\n", __func__, rc);
+
+			return rc;
+		}
+	} else {
+		if (unlikely(!server->secmech.ccmaesdecrypt))
+			return -EIO;
+
+		tfm = server->secmech.ccmaesdecrypt;
+	}
+
+	rc = crypt_message(server, 1, &rqst, 0, tfm);
 	cifs_dbg(FYI, "Decrypt message returned %d\n", rc);
 
+	if (is_offloaded)
+		crypto_free_aead(tfm);
+
 	if (rc)
 		return rc;
 
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index bd7aeb4dcacf..302c08dfb686 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1028,7 +1028,9 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 	 * SMB3.0 supports only 1 cipher and doesn't have a encryption neg context
 	 * Set the cipher type manually.
 	 */
-	if (server->dialect == SMB30_PROT_ID && (server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
+	if ((server->dialect == SMB30_PROT_ID ||
+	     server->dialect == SMB302_PROT_ID) &&
+	    (server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
 		server->cipher_type = SMB2_ENCRYPTION_AES128_CCM;
 
 	security_blob = smb2_get_data_area_len(&blob_offset, &blob_length,
@@ -1063,6 +1065,12 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 		else
 			cifs_server_dbg(VFS, "Missing expected negotiate contexts\n");
 	}
+
+	if (server->cipher_type && !rc) {
+		rc = smb3_crypto_aead_allocate(server);
+		if (rc)
+			cifs_server_dbg(VFS, "%s: crypto alloc failed, rc=%d\n", __func__, rc);
+	}
 neg_exit:
 	free_rsp_buf(resp_buftype, rsp);
 	return rc;
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 49b7edbe3497..c5c1e743359d 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -34,6 +34,8 @@
 void
 cifs_wake_up_task(struct mid_q_entry *mid)
 {
+	if (mid->mid_state == MID_RESPONSE_RECEIVED)
+		mid->mid_state = MID_RESPONSE_READY;
 	wake_up_process(mid->callback_data);
 }
 
@@ -73,7 +75,7 @@ AllocMidQEntry(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 	return temp;
 }
 
-static void _cifs_mid_q_entry_release(struct kref *refcount)
+void _cifs_mid_q_entry_release(struct kref *refcount)
 {
 	struct mid_q_entry *midEntry =
 			container_of(refcount, struct mid_q_entry, refcount);
@@ -86,7 +88,8 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 	struct TCP_Server_Info *server = midEntry->server;
 
 	if (midEntry->resp_buf && (midEntry->mid_flags & MID_WAIT_CANCELLED) &&
-	    midEntry->mid_state == MID_RESPONSE_RECEIVED &&
+	    (midEntry->mid_state == MID_RESPONSE_RECEIVED ||
+	     midEntry->mid_state == MID_RESPONSE_READY) &&
 	    server->ops->handle_cancelled_mid)
 		server->ops->handle_cancelled_mid(midEntry, server);
 
@@ -152,13 +155,6 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 	mempool_free(midEntry, cifs_mid_poolp);
 }
 
-void cifs_mid_q_entry_release(struct mid_q_entry *midEntry)
-{
-	spin_lock(&GlobalMid_Lock);
-	kref_put(&midEntry->refcount, _cifs_mid_q_entry_release);
-	spin_unlock(&GlobalMid_Lock);
-}
-
 void DeleteMidQEntry(struct mid_q_entry *midEntry)
 {
 	cifs_mid_q_entry_release(midEntry);
@@ -762,7 +758,8 @@ wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 	int error;
 
 	error = wait_event_freezekillable_unsafe(server->response_q,
-				    midQ->mid_state != MID_REQUEST_SUBMITTED);
+				    midQ->mid_state != MID_REQUEST_SUBMITTED &&
+				    midQ->mid_state != MID_RESPONSE_RECEIVED);
 	if (error < 0)
 		return -ERESTARTSYS;
 
@@ -914,7 +911,7 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 
 	spin_lock(&GlobalMid_Lock);
 	switch (mid->mid_state) {
-	case MID_RESPONSE_RECEIVED:
+	case MID_RESPONSE_READY:
 		spin_unlock(&GlobalMid_Lock);
 		return rc;
 	case MID_RETRY_NEEDED:
@@ -1013,6 +1010,9 @@ cifs_compound_callback(struct mid_q_entry *mid)
 	credits.instance = server->reconnect_instance;
 
 	add_credits(server, &credits, mid->optype);
+
+	if (mid->mid_state == MID_RESPONSE_RECEIVED)
+		mid->mid_state = MID_RESPONSE_READY;
 }
 
 static void
@@ -1204,7 +1204,8 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			send_cancel(server, &rqst[i], midQ[i]);
 			spin_lock(&GlobalMid_Lock);
 			midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
-			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED) {
+			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ[i]->mid_state == MID_RESPONSE_RECEIVED) {
 				midQ[i]->callback = cifs_cancelled_callback;
 				cancelled_mid[i] = true;
 				credits[i].value = 0;
@@ -1225,7 +1226,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		}
 
 		if (!midQ[i]->resp_buf ||
-		    midQ[i]->mid_state != MID_RESPONSE_RECEIVED) {
+		    midQ[i]->mid_state != MID_RESPONSE_READY) {
 			rc = -EIO;
 			cifs_dbg(FYI, "Bad MID state?\n");
 			goto out;
@@ -1404,7 +1405,8 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	if (rc != 0) {
 		send_cancel(server, &rqst, midQ);
 		spin_lock(&GlobalMid_Lock);
-		if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
+		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 			/* no longer considered to be "in-flight" */
 			midQ->callback = DeleteMidQEntry;
 			spin_unlock(&GlobalMid_Lock);
@@ -1421,7 +1423,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	}
 
 	if (!midQ->resp_buf || !out_buf ||
-	    midQ->mid_state != MID_RESPONSE_RECEIVED) {
+	    midQ->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_server_dbg(VFS, "Bad MID state?\n");
 		goto out;
@@ -1541,13 +1543,15 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* Wait for a reply - allow signals to interrupt. */
 	rc = wait_event_interruptible(server->response_q,
-		(!(midQ->mid_state == MID_REQUEST_SUBMITTED)) ||
+		(!(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		   midQ->mid_state == MID_RESPONSE_RECEIVED)) ||
 		((server->tcpStatus != CifsGood) &&
 		 (server->tcpStatus != CifsNew)));
 
 	/* Were we interrupted by a signal ? */
 	if ((rc == -ERESTARTSYS) &&
-		(midQ->mid_state == MID_REQUEST_SUBMITTED) &&
+		(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		 midQ->mid_state == MID_RESPONSE_RECEIVED) &&
 		((server->tcpStatus == CifsGood) ||
 		 (server->tcpStatus == CifsNew))) {
 
@@ -1577,7 +1581,8 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		if (rc) {
 			send_cancel(server, &rqst, midQ);
 			spin_lock(&GlobalMid_Lock);
-			if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
+			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 				/* no longer considered to be "in-flight" */
 				midQ->callback = DeleteMidQEntry;
 				spin_unlock(&GlobalMid_Lock);
@@ -1595,7 +1600,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 
 	/* rcvd frame is ok */
-	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_RECEIVED) {
+	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_tcon_dbg(VFS, "Bad MID state?\n");
 		goto out;
diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 6fe3c941b565..4d6ba140276b 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -351,10 +351,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
 {
 	__le32 *bref = p;
 	unsigned int blk;
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	if (journal && inode == journal->j_inode)
 		return 0;
 
 	while (bref < p+max) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 87e6187e6584..12f3b4fd201b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -409,10 +409,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
 				unsigned int line,
 				struct ext4_map_blocks *map)
 {
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+
+	if (journal && inode == journal->j_inode)
 		return 0;
+
 	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,
 				 "lblock %lu mapped to illegal pblock %llu "
@@ -4593,22 +4594,43 @@ static inline u64 ext4_inode_peek_iversion(const struct inode *inode)
 		return inode_peek_iversion(inode);
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
@@ -4620,7 +4642,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_inode_info *ei;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct inode *inode;
-	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4649,10 +4670,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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
@@ -4927,13 +4948,21 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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
index 2141f39e01d5..9327eebace41 100644
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
index 541cfd118fbc..01fad4554255 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5085,8 +5085,8 @@ failed_mount9: __maybe_unused
 failed_mount3:
 	/* flush s_error_work before sbi destroy */
 	flush_work(&sbi->s_error_work);
-	del_timer_sync(&sbi->s_err_report);
 	ext4_stop_mmpd(sbi);
+	del_timer_sync(&sbi->s_err_report);
 failed_mount2:
 	rcu_read_lock();
 	group_desc = rcu_dereference(sbi->s_group_desc);
@@ -6212,12 +6212,25 @@ static int ext4_release_dquot(struct dquot *dquot)
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
@@ -6228,6 +6241,10 @@ static int ext4_release_dquot(struct dquot *dquot)
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
index a22c85bf8ae9..d9f57a60f7b9 100644
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
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 135927974e28..8b04e4335690 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -64,7 +64,7 @@ enum {
 
 struct f2fs_fault_info {
 	atomic_t inject_ops;
-	unsigned int inject_rate;
+	int inject_rate;
 	unsigned int inject_type;
 };
 
@@ -4373,10 +4373,14 @@ static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
 }
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
-							unsigned int type);
+extern int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
+							unsigned long type);
 #else
-#define f2fs_build_fault_attr(sbi, rate, type)		do { } while (0)
+static inline int f2fs_build_fault_attr(struct f2fs_sb_info *sbi,
+					unsigned long rate, unsigned long type)
+{
+	return 0;
+}
 #endif
 
 static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b6758887540f..ae6d65f2ea06 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1105,7 +1105,14 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
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
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f8aaff9b1784..0cf564ded140 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -61,21 +61,31 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_DQUOT_INIT]	= "dquot initialize",
 };
 
-void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
-							unsigned int type)
+int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
+							unsigned long type)
 {
 	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
 
 	if (rate) {
+		if (rate > INT_MAX)
+			return -EINVAL;
 		atomic_set(&ffi->inject_ops, 0);
-		ffi->inject_rate = rate;
+		ffi->inject_rate = (int)rate;
 	}
 
-	if (type)
-		ffi->inject_type = type;
+	if (type) {
+		if (type >= BIT(FAULT_MAX))
+			return -EINVAL;
+		ffi->inject_type = (unsigned int)type;
+	}
 
 	if (!rate && !type)
 		memset(ffi, 0, sizeof(struct f2fs_fault_info));
+	else
+		f2fs_info(sbi,
+			"build fault injection attr: rate: %lu, type: 0x%lx",
+								rate, type);
+	return 0;
 }
 #endif
 
@@ -901,14 +911,17 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_fault_injection:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			f2fs_build_fault_attr(sbi, arg, F2FS_ALL_FAULT_TYPE);
+			if (f2fs_build_fault_attr(sbi, arg,
+					F2FS_ALL_FAULT_TYPE))
+				return -EINVAL;
 			set_opt(sbi, FAULT_INJECTION);
 			break;
 
 		case Opt_fault_type:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			f2fs_build_fault_attr(sbi, 0, arg);
+			if (f2fs_build_fault_attr(sbi, 0, arg))
+				return -EINVAL;
 			set_opt(sbi, FAULT_INJECTION);
 			break;
 #else
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 63af1573ebca..30ff2c087726 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -407,10 +407,16 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	if (ret < 0)
 		return ret;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (a->struct_type == FAULT_INFO_TYPE && t >= (1 << FAULT_MAX))
-		return -EINVAL;
-	if (a->struct_type == FAULT_INFO_RATE && t >= UINT_MAX)
-		return -EINVAL;
+	if (a->struct_type == FAULT_INFO_TYPE) {
+		if (f2fs_build_fault_attr(sbi, 0, t))
+			return -EINVAL;
+		return count;
+	}
+	if (a->struct_type == FAULT_INFO_RATE) {
+		if (f2fs_build_fault_attr(sbi, t, 0))
+			return -EINVAL;
+		return count;
+	}
 #endif
 	if (a->struct_type == RESERVED_BLOCKS) {
 		spin_lock(&sbi->stat_lock);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a4deacc6f78c..ba8d5f5dbeb0 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1431,6 +1431,9 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	unsigned int virtqueue_size;
 	int err = -EIO;
 
+	if (!fsc->source)
+		return invalf(fsc, "No source specified");
+
 	/* This gets a reference on virtio_fs object. This ptr gets installed
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
 	 * to drop the reference to this object.
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 397e02a56697..2251286cd83f 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -70,6 +70,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
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
index 177fae4e6581..cf6e5de7b9da 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -69,6 +69,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
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
index 464ae5e73065..b1eb4493c77b 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1701,7 +1701,6 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 
 	/* Log is no longer empty */
 	write_lock(&journal->j_state_lock);
-	WARN_ON(!sb->s_sequence);
 	journal->j_flags &= ~JBD2_FLUSHED;
 	write_unlock(&journal->j_state_lock);
 
diff --git a/fs/jfs/jfs_dinode.h b/fs/jfs/jfs_dinode.h
index 6b231d0d0071..603aae17a693 100644
--- a/fs/jfs/jfs_dinode.h
+++ b/fs/jfs/jfs_dinode.h
@@ -96,7 +96,7 @@ struct dinode {
 #define di_gengen	u._file._u1._imap._gengen
 
 			union {
-				xtpage_t _xtroot;
+				xtroot_t _xtroot;
 				struct {
 					u8 unused[16];	/* 16: */
 					dxd_t _dxd;	/* 16: */
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index e6cbe4c982c5..65a94b012174 100644
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
@@ -1694,6 +1698,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		} else if (rc == -ENOSPC) {
 			/* search for next smaller log2 block */
 			l2nb = BLKSTOL2(nblocks) - 1;
+			if (unlikely(l2nb < 0))
+				break;
 			nblocks = 1LL << l2nb;
 		} else {
 			/* Trim any already allocated blocks */
@@ -3469,7 +3475,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 	oldl2agsize = bmp->db_agl2size;
 
 	bmp->db_agl2size = l2agsize;
-	bmp->db_agsize = 1 << l2agsize;
+	bmp->db_agsize = (s64)1 << l2agsize;
 
 	/* compute new number of AG */
 	agno = bmp->db_numag;
@@ -3732,8 +3738,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
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
index c72e97f06579..9adb29e7862c 100644
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
@@ -673,7 +673,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		 * This is the special xtree inside the directory for storing
 		 * the directory table
 		 */
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
 		xad_t *xad;
 
 		jfs_ip->xtlid = 0;
@@ -687,7 +687,7 @@ int diWrite(tid_t tid, struct inode *ip)
 		 * copy xtree root from inode to dinode:
 		 */
 		p = &jfs_ip->i_xtroot;
-		xp = (xtpage_t *) &dp->di_dirtable;
+		xp = (xtroot_t *) &dp->di_dirtable;
 		lv = ilinelock->lv;
 		for (n = 0; n < ilinelock->index; n++, lv++) {
 			memcpy(&xp->xad[lv->offset], &p->xad[lv->offset],
@@ -716,7 +716,7 @@ int diWrite(tid_t tid, struct inode *ip)
 	 *	regular file: 16 byte (XAD slot) granularity
 	 */
 	if (type & tlckXTREE) {
-		xtpage_t *p, *xp;
+		xtroot_t *p, *xp;
 		xad_t *xad;
 
 		/*
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 721def69e732..dd4264aa9bed 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -66,7 +66,7 @@ struct jfs_inode_info {
 	lid_t	xtlid;		/* lid of xtree lock on directory */
 	union {
 		struct {
-			xtpage_t _xtroot;	/* 288: xtree root */
+			xtroot_t _xtroot;	/* 288: xtree root */
 			struct inomap *_imap;	/* 4: inode map header	*/
 		} file;
 		struct {
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 6c8680d3907a..3a547e0b934f 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -783,7 +783,7 @@ struct tlock *txLock(tid_t tid, struct inode *ip, struct metapage * mp,
 			if (mp->xflag & COMMIT_PAGE)
 				p = (xtpage_t *) mp->data;
 			else
-				p = &jfs_ip->i_xtroot;
+				p = (xtpage_t *) &jfs_ip->i_xtroot;
 			xtlck->lwm.offset =
 			    le16_to_cpu(p->header.nextindex);
 		}
@@ -1710,7 +1710,7 @@ static void xtLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 
 	if (tlck->type & tlckBTROOT) {
 		lrd->log.redopage.type |= cpu_to_le16(LOG_BTROOT);
-		p = &JFS_IP(ip)->i_xtroot;
+		p = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
 		if (S_ISDIR(ip->i_mode))
 			lrd->log.redopage.type |=
 			    cpu_to_le16(LOG_DIR_XTREE);
diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 3148e9b35f3b..34db519933b4 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -1224,7 +1224,7 @@ xtSplitRoot(tid_t tid,
 	struct xtlock *xtlck;
 	int rc;
 
-	sp = &JFS_IP(ip)->i_xtroot;
+	sp = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
 
 	INCREMENT(xtStat.split);
 
@@ -3059,7 +3059,7 @@ static int xtRelink(tid_t tid, struct inode *ip, xtpage_t * p)
  */
 void xtInitRoot(tid_t tid, struct inode *ip)
 {
-	xtpage_t *p;
+	xtroot_t *p;
 
 	/*
 	 * acquire a transaction lock on the root
diff --git a/fs/jfs/jfs_xtree.h b/fs/jfs/jfs_xtree.h
index 5f51be8596b3..dc9b5f8d6385 100644
--- a/fs/jfs/jfs_xtree.h
+++ b/fs/jfs/jfs_xtree.h
@@ -65,24 +65,33 @@ struct xadlist {
 #define XTPAGEMAXSLOT	256
 #define XTENTRYSTART	2
 
-/*
- *	xtree page:
- */
-typedef union {
-	struct xtheader {
-		__le64 next;	/* 8: */
-		__le64 prev;	/* 8: */
+struct xtheader {
+	__le64 next;	/* 8: */
+	__le64 prev;	/* 8: */
 
-		u8 flag;	/* 1: */
-		u8 rsrvd1;	/* 1: */
-		__le16 nextindex;	/* 2: next index = number of entries */
-		__le16 maxentry;	/* 2: max number of entries */
-		__le16 rsrvd2;	/* 2: */
+	u8 flag;	/* 1: */
+	u8 rsrvd1;	/* 1: */
+	__le16 nextindex;	/* 2: next index = number of entries */
+	__le16 maxentry;	/* 2: max number of entries */
+	__le16 rsrvd2;	/* 2: */
 
-		pxd_t self;	/* 8: self */
-	} header;		/* (32) */
+	pxd_t self;	/* 8: self */
+};
 
+/*
+ *	xtree root (in inode):
+ */
+typedef union {
+	struct xtheader header;
 	xad_t xad[XTROOTMAXSLOT];	/* 16 * maxentry: xad array */
+} xtroot_t;
+
+/*
+ *	xtree page:
+ */
+typedef union {
+	struct xtheader header;
+	xad_t xad[XTPAGEMAXSLOT];	/* 16 * maxentry: xad array */
 } xtpage_t;
 
 /*
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 4e444d01a3c3..9fcdcea0e6bd 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1498,7 +1498,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
  * @open_req:	buffer containing smb2 file open(create) request
  * @is_dir:	whether leasing file is directory
  *
- * Return:  oplock state, -ENOENT if create lease context not found
+ * Return: allocated lease context object on success, otherwise NULL
  */
 struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
 {
diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index 4d1211bde190..9e54ecc9d4ad 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -102,7 +102,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferLength);
 		break;
 	case SMB2_TREE_CONNECT:
-		*off = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset);
+		*off = max_t(unsigned short int,
+			     le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset),
+			     offsetof(struct smb2_tree_connect_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathLength);
 		break;
 	case SMB2_CREATE:
@@ -129,11 +131,15 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	}
 	case SMB2_QUERY_INFO:
-		*off = le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset);
+		*off = max_t(unsigned int,
+			     le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset),
+			     offsetof(struct smb2_query_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferLength);
 		break;
 	case SMB2_SET_INFO:
-		*off = le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset);
+		*off = max_t(unsigned int,
+			     le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset),
+			     offsetof(struct smb2_set_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_set_info_req *)hdr)->BufferLength);
 		break;
 	case SMB2_READ:
@@ -143,7 +149,7 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 	case SMB2_WRITE:
 		if (((struct smb2_write_req *)hdr)->DataOffset ||
 		    ((struct smb2_write_req *)hdr)->Length) {
-			*off = max_t(unsigned int,
+			*off = max_t(unsigned short int,
 				     le16_to_cpu(((struct smb2_write_req *)hdr)->DataOffset),
 				     offsetof(struct smb2_write_req, Buffer) - 4);
 			*len = le32_to_cpu(((struct smb2_write_req *)hdr)->Length);
@@ -154,7 +160,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoLength);
 		break;
 	case SMB2_QUERY_DIRECTORY:
-		*off = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset);
+		*off = max_t(unsigned short int,
+			     le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset),
+			     offsetof(struct smb2_query_directory_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameLength);
 		break;
 	case SMB2_LOCK:
@@ -169,7 +177,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	}
 	case SMB2_IOCTL:
-		*off = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset);
+		*off = max_t(unsigned int,
+			     le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset),
+			     offsetof(struct smb2_ioctl_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputCount);
 		break;
 	default:
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 3dfe0acf21a5..b21601c0a457 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1967,7 +1967,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 
 	WORK_BUFFERS(work, req, rsp);
 
-	treename = smb_strndup_from_utf16(req->Buffer,
+	treename = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->PathOffset),
 					  le16_to_cpu(req->PathLength), true,
 					  conn->local_nls);
 	if (IS_ERR(treename)) {
@@ -2714,7 +2714,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out2;
 		}
 
-		name = smb2_get_name(req->Buffer,
+		name = smb2_get_name((char *)req + le16_to_cpu(req->NameOffset),
 				     le16_to_cpu(req->NameLength),
 				     work->conn->local_nls);
 		if (IS_ERR(name)) {
@@ -3230,7 +3230,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out1;
 		}
 	} else {
-		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
+		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE && lc) {
 			/*
 			 * Compare parent lease using parent key. If there is no
 			 * a lease that has same parent key, Send lease break
@@ -4086,7 +4086,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	}
 
 	srch_flag = req->Flags;
-	srch_ptr = smb_strndup_from_utf16(req->Buffer,
+	srch_ptr = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->FileNameOffset),
 					  le16_to_cpu(req->FileNameLength), 1,
 					  conn->local_nls);
 	if (IS_ERR(srch_ptr)) {
@@ -4346,7 +4346,8 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    sizeof(struct smb2_ea_info_req))
 			return -EINVAL;
 
-		ea_req = (struct smb2_ea_info_req *)req->Buffer;
+		ea_req = (struct smb2_ea_info_req *)((char *)req +
+						     le16_to_cpu(req->InputBufferOffset));
 	} else {
 		/* need to send all EAs, if no specific EA is requested*/
 		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
@@ -5952,6 +5953,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			      struct ksmbd_share_config *share)
 {
 	unsigned int buf_len = le32_to_cpu(req->BufferLength);
+	char *buffer = (char *)req + le16_to_cpu(req->BufferOffset);
 
 	switch (req->FileInfoClass) {
 	case FILE_BASIC_INFORMATION:
@@ -5959,7 +5961,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_basic_info))
 			return -EINVAL;
 
-		return set_file_basic_info(fp, (struct smb2_file_basic_info *)req->Buffer, share);
+		return set_file_basic_info(fp, (struct smb2_file_basic_info *)buffer, share);
 	}
 	case FILE_ALLOCATION_INFORMATION:
 	{
@@ -5967,7 +5969,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_allocation_info(work, fp,
-						(struct smb2_file_alloc_info *)req->Buffer);
+						(struct smb2_file_alloc_info *)buffer);
 	}
 	case FILE_END_OF_FILE_INFORMATION:
 	{
@@ -5975,7 +5977,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_end_of_file_info(work, fp,
-					    (struct smb2_file_eof_info *)req->Buffer);
+					    (struct smb2_file_eof_info *)buffer);
 	}
 	case FILE_RENAME_INFORMATION:
 	{
@@ -5983,7 +5985,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_rename_info(work, fp,
-				       (struct smb2_file_rename_info *)req->Buffer,
+				       (struct smb2_file_rename_info *)buffer,
 				       buf_len);
 	}
 	case FILE_LINK_INFORMATION:
@@ -5992,7 +5994,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_create_link(work, work->tcon->share_conf,
-					(struct smb2_file_link_info *)req->Buffer,
+					(struct smb2_file_link_info *)buffer,
 					buf_len, fp->filp,
 					work->conn->local_nls);
 	}
@@ -6002,7 +6004,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_disposition_info(fp,
-						 (struct smb2_file_disposition_info *)req->Buffer);
+						 (struct smb2_file_disposition_info *)buffer);
 	}
 	case FILE_FULL_EA_INFORMATION:
 	{
@@ -6015,7 +6017,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_ea_info))
 			return -EINVAL;
 
-		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
+		return smb2_set_ea((struct smb2_ea_info *)buffer,
 				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
@@ -6023,14 +6025,14 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_pos_info))
 			return -EINVAL;
 
-		return set_file_position_info(fp, (struct smb2_file_pos_info *)req->Buffer);
+		return set_file_position_info(fp, (struct smb2_file_pos_info *)buffer);
 	}
 	case FILE_MODE_INFORMATION:
 	{
 		if (buf_len < sizeof(struct smb2_file_mode_info))
 			return -EINVAL;
 
-		return set_file_mode_info(fp, (struct smb2_file_mode_info *)req->Buffer);
+		return set_file_mode_info(fp, (struct smb2_file_mode_info *)buffer);
 	}
 	}
 
@@ -6111,7 +6113,7 @@ int smb2_set_info(struct ksmbd_work *work)
 		}
 		rc = smb2_set_info_sec(fp,
 				       le32_to_cpu(req->AdditionalInformation),
-				       req->Buffer,
+				       (char *)req + le16_to_cpu(req->BufferOffset),
 				       le32_to_cpu(req->BufferLength));
 		ksmbd_revert_fsids(work);
 		break;
@@ -7563,7 +7565,7 @@ static int fsctl_pipe_transceive(struct ksmbd_work *work, u64 id,
 				 struct smb2_ioctl_rsp *rsp)
 {
 	struct ksmbd_rpc_command *rpc_resp;
-	char *data_buf = (char *)&req->Buffer[0];
+	char *data_buf = (char *)req + le32_to_cpu(req->InputOffset);
 	int nbytes = 0;
 
 	rpc_resp = ksmbd_rpc_ioctl(work->sess, id, data_buf,
@@ -7676,6 +7678,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 	u64 id = KSMBD_NO_FID;
 	struct ksmbd_conn *conn = work->conn;
 	int ret = 0;
+	char *buffer;
 
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
@@ -7698,6 +7701,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		goto out;
 	}
 
+	buffer = (char *)req + le32_to_cpu(req->InputOffset);
 	cnt_code = le32_to_cpu(req->CntCode);
 	ret = smb2_calc_max_out_buf_len(work, 48,
 					le32_to_cpu(req->MaxOutputResponse));
@@ -7755,7 +7759,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_validate_negotiate_info(conn,
-			(struct validate_negotiate_info_req *)&req->Buffer[0],
+			(struct validate_negotiate_info_req *)buffer,
 			(struct validate_negotiate_info_rsp *)&rsp->Buffer[0],
 			in_buf_len);
 		if (ret < 0)
@@ -7808,7 +7812,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		rsp->VolatileFileId = req->VolatileFileId;
 		rsp->PersistentFileId = req->PersistentFileId;
 		fsctl_copychunk(work,
-				(struct copychunk_ioctl_req *)&req->Buffer[0],
+				(struct copychunk_ioctl_req *)buffer,
 				le32_to_cpu(req->CntCode),
 				le32_to_cpu(req->InputCount),
 				req->VolatileFileId,
@@ -7821,8 +7825,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		ret = fsctl_set_sparse(work, id,
-				       (struct file_sparse *)&req->Buffer[0]);
+		ret = fsctl_set_sparse(work, id, (struct file_sparse *)buffer);
 		if (ret < 0)
 			goto out;
 		break;
@@ -7845,7 +7848,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		zero_data =
-			(struct file_zero_data_information *)&req->Buffer[0];
+			(struct file_zero_data_information *)buffer;
 
 		off = le64_to_cpu(zero_data->FileOffset);
 		bfz = le64_to_cpu(zero_data->BeyondFinalZero);
@@ -7876,7 +7879,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_query_allocated_ranges(work, id,
-			(struct file_allocated_range_buffer *)&req->Buffer[0],
+			(struct file_allocated_range_buffer *)buffer,
 			(struct file_allocated_range_buffer *)&rsp->Buffer[0],
 			out_buf_len /
 			sizeof(struct file_allocated_range_buffer), &nbytes);
@@ -7920,7 +7923,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		dup_ext = (struct duplicate_extents_to_file *)&req->Buffer[0];
+		dup_ext = (struct duplicate_extents_to_file *)buffer;
 
 		fp_in = ksmbd_lookup_fd_slow(work, dup_ext->VolatileFileHandle,
 					     dup_ext->PersistentFileHandle);
diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index 0d096a11ba30..7e6003c6cd9b 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -294,7 +294,11 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
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
 
@@ -317,6 +321,7 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	ret |= ksmbd_set_work_group(req->work_group);
 	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
 					req->ifc_list_sz);
+out:
 	if (ret) {
 		pr_err("Server configuration error: %s %s %s\n",
 		       req->netbios_name, req->server_string,
diff --git a/fs/namespace.c b/fs/namespace.c
index 22af4b6c737f..642baef4d9aa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1734,6 +1734,7 @@ static void warn_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -1743,7 +1744,7 @@ static int can_umount(const struct path *path, int flags)
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
index 692018327b5f..a6d0b64dda36 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -768,33 +768,11 @@ u64 nfs_timespec_to_change_attr(const struct timespec64 *ts)
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
index 3de425f59b3a..1dbc5562ac25 100644
--- a/fs/nfs/nfs4session.h
+++ b/fs/nfs/nfs4session.h
@@ -147,16 +147,12 @@ static inline void nfs4_copy_sessionid(struct nfs4_sessionid *dst,
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
index 7f071519fb2e..73367b41e4fa 100644
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
index 5e576b1f46c7..1d09fb4ff5a5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4944,7 +4944,7 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
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
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2d5d234a4533..74cf9c51e322 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -435,6 +435,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	}
 
 	if (extend_init && !is_compressed(ni)) {
+		WARN_ON(ni->i_valid >= pos);
 		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
 		if (err)
 			goto out;
diff --git a/fs/proc/array.c b/fs/proc/array.c
index c925287a4dc4..2cb01aaa6718 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -462,12 +462,12 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	int permitted;
 	struct mm_struct *mm;
 	unsigned long long start_time;
-	unsigned long cmin_flt = 0, cmaj_flt = 0;
-	unsigned long  min_flt = 0,  maj_flt = 0;
-	u64 cutime, cstime, utime, stime;
-	u64 cgtime, gtime;
+	unsigned long cmin_flt, cmaj_flt, min_flt, maj_flt;
+	u64 cutime, cstime, cgtime, utime, stime, gtime;
 	unsigned long rsslim = 0;
 	unsigned long flags;
+	struct signal_struct *sig = task->signal;
+	unsigned int seq = 1;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -495,12 +495,8 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
-	cutime = cstime = 0;
-	cgtime = gtime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
-		struct signal_struct *sig = task->signal;
-
 		if (sig->tty) {
 			struct pid *pgrp = tty_get_pgrp(sig->tty);
 			tty_pgrp = pid_nr_ns(pgrp, ns);
@@ -511,36 +507,45 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		num_threads = get_nr_threads(task);
 		collect_sigign_sigcatch(task, &sigign, &sigcatch);
 
+		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
+
+		sid = task_session_nr_ns(task, ns);
+		ppid = task_tgid_nr_ns(task->real_parent, ns);
+		pgid = task_pgrp_nr_ns(task, ns);
+
+		unlock_task_sighand(task, &flags);
+	}
+
+	if (permitted && (!whole || num_threads < 2))
+		wchan = !task_is_running(task);
+
+	do {
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
+		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+
 		cmin_flt = sig->cmin_flt;
 		cmaj_flt = sig->cmaj_flt;
 		cutime = sig->cutime;
 		cstime = sig->cstime;
 		cgtime = sig->cgtime;
-		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
 
-		/* add up live thread stats at the group level */
 		if (whole) {
 			struct task_struct *t = task;
+
+			min_flt = sig->min_flt;
+			maj_flt = sig->maj_flt;
+			gtime = sig->gtime;
+
+			rcu_read_lock();
 			do {
 				min_flt += t->min_flt;
 				maj_flt += t->maj_flt;
 				gtime += task_gtime(t);
 			} while_each_thread(task, t);
-
-			min_flt += sig->min_flt;
-			maj_flt += sig->maj_flt;
-			gtime += sig->gtime;
+			rcu_read_unlock();
 		}
-
-		sid = task_session_nr_ns(task, ns);
-		ppid = task_tgid_nr_ns(task->real_parent, ns);
-		pgid = task_pgrp_nr_ns(task, ns);
-
-		unlock_task_sighand(task, &flags);
-	}
-
-	if (permitted && (!whole || num_threads < 2))
-		wchan = !task_is_running(task);
+	} while (need_seqretry(&sig->stats_lock, seq));
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 
 	if (whole) {
 		thread_group_cputime_adjusted(task, &utime, &stime);
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index eed9a98eae0d..5545dcd231af 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -283,6 +283,7 @@ static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
 	WARN_ON_ONCE(debug_locks &&
+		     (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
 		     (!lockdep_is_held(&inode->i_lock) &&
 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
 		      !lockdep_is_held(&inode->i_wb->list_lock)));
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 27c363f6b281..c5eda86e4118 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -92,6 +92,7 @@ struct blkg_policy_data {
 	/* the blkg and policy id this per-policy data belongs to */
 	struct blkcg_gq			*blkg;
 	int				plid;
+	bool				online;
 };
 
 /*
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9cb355868339..7d8294d0d717 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -800,7 +800,14 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 	 * under local_bh_disable(), which provides the needed RCU protection
 	 * for accessing map entries.
 	 */
-	u32 act = __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	u32 act;
+
+	if (ri->map_id || ri->map_type) {
+		ri->map_id = 0;
+		ri->map_type = BPF_MAP_TYPE_UNSPEC;
+	}
+	act = __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
 
 	if (static_branch_unlikely(&bpf_master_redirect_enabled_key)) {
 		if (act == XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a97c2b9885e1..ccff086316e9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1719,6 +1719,7 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 { return 0; }
 #endif
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
+void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent);
 #endif
 
 /* Some architectures require additional setup to direct VGA traffic */
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 879a5c8f930b..547d7cc9097e 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -8,6 +8,7 @@
 
 #include <linux/sched.h>
 #include <linux/magic.h>
+#include <linux/kasan.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
@@ -86,6 +87,7 @@ static inline int object_is_on_stack(const void *obj)
 {
 	void *stack = task_stack_page(current);
 
+	obj = kasan_reset_tag(obj);
 	return (obj >= stack) && (obj < (stack + THREAD_SIZE));
 }
 
diff --git a/include/linux/soc/samsung/exynos-chipid.h b/include/linux/soc/samsung/exynos-chipid.h
index 8bca6763f99c..62f0e2531068 100644
--- a/include/linux/soc/samsung/exynos-chipid.h
+++ b/include/linux/soc/samsung/exynos-chipid.h
@@ -9,10 +9,8 @@
 #define __LINUX_SOC_EXYNOS_CHIPID_H
 
 #define EXYNOS_CHIPID_REG_PRO_ID	0x00
-#define EXYNOS_SUBREV_MASK		(0xf << 4)
-#define EXYNOS_MAINREV_MASK		(0xf << 0)
-#define EXYNOS_REV_MASK			(EXYNOS_SUBREV_MASK | \
-					 EXYNOS_MAINREV_MASK)
+#define EXYNOS_REV_PART_MASK		0xf
+#define EXYNOS_REV_PART_SHIFT		4
 #define EXYNOS_MASK			0xfffff000
 
 #define EXYNOS_CHIPID_REG_PKG_ID	0x04
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7d2bd562da4b..b08b559f5242 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -314,6 +314,7 @@ int  bt_sock_register(int proto, const struct net_proto_family *ops);
 void bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index ff9ecc76d622..c3cc3a465955 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -80,6 +80,7 @@ struct net {
 						 * or to unregister pernet ops
 						 * (pernet_ops_rwsem write locked).
 						 */
+	struct llist_node	defer_free_list;
 	struct llist_node	cleanup_list;	/* namespaces on death row */
 
 #ifdef CONFIG_KEYS
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 821b20a0f882..b73eadf644b3 100644
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
diff --git a/include/net/sock.h b/include/net/sock.h
index ca3cc2b325d7..0461890f10ae 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1472,6 +1472,12 @@ static inline void sock_prot_inuse_add(const struct net *net,
 {
 	this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
 }
+
+static inline void sock_inuse_add(const struct net *net, int val)
+{
+	this_cpu_add(*net->core.sock_inuse, val);
+}
+
 int sock_prot_inuse_get(struct net *net, struct proto *proto);
 int sock_inuse_get(struct net *net);
 #else
@@ -1479,6 +1485,10 @@ static inline void sock_prot_inuse_add(const struct net *net,
 				       const struct proto *prot, int val)
 {
 }
+
+static inline void sock_inuse_add(const struct net *net, int val)
+{
+}
 #endif
 
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 6fe125a71b60..306005b3b60f 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -576,6 +576,15 @@ struct sas_ssp_task {
 	struct scsi_cmnd *cmd;
 };
 
+struct sas_tmf_task {
+	u8 tmf;
+	u16 tag_of_task_to_be_managed;
+
+	/* Temp */
+	int force_phy;
+	int phy_id;
+};
+
 struct sas_task {
 	struct domain_device *dev;
 
@@ -636,7 +645,6 @@ struct sas_domain_function_template {
 	/* Task Management Functions. Must be called from process context. */
 	int (*lldd_abort_task)(struct sas_task *);
 	int (*lldd_abort_task_set)(struct domain_device *, u8 *lun);
-	int (*lldd_clear_aca)(struct domain_device *, u8 *lun);
 	int (*lldd_clear_task_set)(struct domain_device *, u8 *lun);
 	int (*lldd_I_T_nexus_reset)(struct domain_device *);
 	int (*lldd_ata_check_ready)(struct domain_device *);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index af96af174dc4..48d747f3ee8d 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -50,6 +50,8 @@ struct kfd_ioctl_get_version_args {
 #define KFD_MAX_QUEUE_PERCENTAGE	100
 #define KFD_MAX_QUEUE_PRIORITY		15
 
+#define KFD_MIN_QUEUE_RING_SIZE		1024
+
 struct kfd_ioctl_create_queue_args {
 	__u64 ring_base_address;	/* to KFD */
 	__u64 write_pointer_address;	/* from KFD */
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 21c8d58283c9..d00621d4d52d 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -32,9 +32,11 @@ struct landlock_ruleset_attr {
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
index 7483a78d2425..20a3b320d1a5 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -371,7 +371,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
diff --git a/init/Kconfig b/init/Kconfig
index dafc3ba6fa7a..b66259bfd235 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -674,7 +674,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
@@ -2194,6 +2194,7 @@ comment "Do not forget to sign required modules with scripts/sign-file"
 choice
 	prompt "Which hash algorithm should modules be signed with?"
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+	default MODULE_SIG_SHA512
 	help
 	  This determines which sort of hashing algorithm will be used during
 	  signature generation.  This algorithm _must_ be built into the kernel
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 13f870e47ab6..d3feaf6d68eb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3,6 +3,7 @@
  */
 #include <linux/bpf.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/random.h>
 #include <linux/smp.h>
 #include <linux/topology.h>
@@ -24,12 +25,13 @@
  *
  * Different map implementations will rely on rcu in map methods
  * lookup/update/delete, therefore eBPF programs must run under rcu lock
- * if program is allowed to access maps, so check rcu_read_lock_held in
- * all three functions.
+ * if program is allowed to access maps, so check rcu_read_lock_held() or
+ * rcu_read_lock_trace_held() in all three functions.
  */
 BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -45,7 +47,8 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -62,7 +65,8 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7fce461eae10..6f309248f13f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -654,7 +654,7 @@ static const struct vm_operations_struct bpf_map_default_vmops = {
 static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct bpf_map *map = filp->private_data;
-	int err;
+	int err = 0;
 
 	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
 	    map_value_has_timer(map))
@@ -679,7 +679,12 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
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
@@ -690,13 +695,11 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
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
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42622..24d96a2fe062 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -69,8 +69,7 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes __initconst =
-	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+#define size_bytes ((phys_addr_t)CMA_SIZE_MBYTES * SZ_1M)
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
 static phys_addr_t limit_cmdline __initdata;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f0c6ddeae20f..1f00d46ffd4d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5982,6 +5982,9 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
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
index e23a0fc96a7d..519f742d44f4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -91,7 +91,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 
 	if (unlikely(sg_policy->limits_changed)) {
 		sg_policy->limits_changed = false;
-		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+		sg_policy->need_freq_update = true;
 		return true;
 	}
 
@@ -103,10 +103,22 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
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
index 80ccb29bf752..d91a673ffc3e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6090,6 +6090,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 				}
 			}
 		}
+		cond_resched();
 	} while_for_each_ftrace_rec();
 out:
 	mutex_unlock(&ftrace_lock);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 54a035b079d3..e9d40f9fb09b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -763,7 +763,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
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
index 60c34fc44a63..1aff7c8723e2 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -676,7 +676,7 @@ static __always_inline char *test_string(char *str)
 	kstr = ubuf->buffer;
 
 	/* For safety, do not trust the string pointer */
-	if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
+	if (strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE) < 0)
 		return NULL;
 	return kstr;
 }
@@ -695,7 +695,7 @@ static __always_inline char *test_ustring(char *str)
 
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
index b2de45a581f4..7c0c69bb5b68 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -186,6 +186,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
 		return -E2BIG;
 
+#ifndef CONFIG_DCACHE_WORD_ACCESS
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	/*
 	 * If src is unaligned, don't cross a page boundary,
@@ -200,12 +201,26 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 	/* If src or dest is unaligned, don't do word-at-a-time. */
 	if (((long) dest | (long) src) & (sizeof(long) - 1))
 		max = 0;
+#endif
 #endif
 
+	/*
+	 * load_unaligned_zeropad() or read_word_at_a_time() below may read
+	 * uninitialized bytes after the trailing zero and use them in
+	 * comparisons. Disable this optimization under KMSAN to prevent
+	 * false positive reports.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN))
+		max = 0;
+
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
diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 2062be1f2e80..f90f2b9842ec 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -35,18 +35,22 @@ static void test_ubsan_shift_out_of_bounds(void)
 
 static void test_ubsan_out_of_bounds(void)
 {
-	volatile int i = 4, j = 5, k = -1;
-	volatile char above[4] = { }; /* Protect surrounding memory. */
-	volatile int arr[4];
-	volatile char below[4] = { }; /* Protect surrounding memory. */
+	int i = 4, j = 4, k = -1;
+	volatile struct {
+		char above[4]; /* Protect surrounding memory. */
+		int arr[4];
+		char below[4]; /* Protect surrounding memory. */
+	} data;
 
-	above[0] = below[0];
+	OPTIMIZER_HIDE_VAR(i);
+	OPTIMIZER_HIDE_VAR(j);
+	OPTIMIZER_HIDE_VAR(k);
 
 	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "above");
-	arr[j] = i;
+	data.arr[j] = i;
 
 	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "below");
-	arr[k] = i;
+	data.arr[k] = i;
 }
 
 enum ubsan_test_enum {
diff --git a/mm/filemap.c b/mm/filemap.c
index c71e86c12418..cc86c5a127b9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2617,7 +2617,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (unlikely(!iov_iter_count(iter)))
 		return 0;
 
-	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
+	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
 	pagevec_init(&pvec);
 
 	do {
diff --git a/mm/gup.c b/mm/gup.c
index 0a1839b32574..118c47447185 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1768,8 +1768,8 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
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
index 8be244f6c320..7e39a4c9e0df 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -707,12 +707,17 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
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
index 62fe3707ff92..4998b4c49052 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2570,11 +2570,11 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
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
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f162e9159296..7ec7559acc8e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4581,7 +4581,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 		return NODE_RECLAIM_NOSCAN;
 
 	ret = __node_reclaim(pgdat, gfp_mask, order);
-	clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
+	clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 
 	if (!ret)
 		count_vm_event(PGSCAN_ZONE_RECLAIM_FAILED);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index ad2d3ad34b7d..945a5bb7402d 100644
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
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 9c9c855b9736..aebef5cf12d4 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -154,6 +154,28 @@ void bt_sock_unlink(struct bt_sock_list *l, struct sock *sk)
 }
 EXPORT_SYMBOL(bt_sock_unlink);
 
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s)
+{
+	struct sock *sk;
+
+	if (!l || !s)
+		return false;
+
+	read_lock(&l->lock);
+
+	sk_for_each(sk, &l->head) {
+		if (s == sk) {
+			read_unlock(&l->lock);
+			return true;
+		}
+	}
+
+	read_unlock(&l->lock);
+
+	return false;
+}
+EXPORT_SYMBOL(bt_sock_linked);
+
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
 	BT_DBG("parent %p, sk %p", parent, sk);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 83af50c3838a..84b07b27b3cf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5777,11 +5777,12 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
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
index 2d451009a647..d34e161a30b3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4162,7 +4162,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(L2CAP_PSM_SDP) &&
-	    !hci_conn_check_link_mode(conn->hcon)) {
+	    (!hci_conn_check_link_mode(conn->hcon) ||
+	    !l2cap_check_enc_key_size(conn->hcon))) {
 		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
 		result = L2CAP_CR_SEC_BLOCK;
 		goto response;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index f5192116922d..83412efe2895 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -76,6 +76,16 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static struct sock *sco_sock_hold(struct sco_conn *conn)
+{
+	if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
+		return NULL;
+
+	sock_hold(conn->sk);
+
+	return conn->sk;
+}
+
 static void sco_sock_timeout(struct work_struct *work)
 {
 	struct sco_conn *conn = container_of(work, struct sco_conn,
@@ -87,9 +97,7 @@ static void sco_sock_timeout(struct work_struct *work)
 		sco_conn_unlock(conn);
 		return;
 	}
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -191,9 +199,7 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill socket */
 	sco_conn_lock(conn);
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (sk) {
diff --git a/net/core/dev.c b/net/core/dev.c
index 81f9fd0c5830..2f7bd1fe5851 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3231,6 +3231,7 @@ static u16 skb_tx_hash(const struct net_device *dev,
 	}
 
 	if (skb_rx_queue_recorded(skb)) {
+		BUILD_BUG_ON_INVALID(qcount == 0);
 		hash = skb_get_rx_queue(skb);
 		if (hash >= qoffset)
 			hash -= qoffset;
diff --git a/net/core/filter.c b/net/core/filter.c
index 84ec1b14b23f..9d358fb865e2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -209,24 +209,36 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
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
@@ -239,21 +251,19 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u16 tmp, *ptr;
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
@@ -266,21 +276,19 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u32 tmp, *ptr;
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
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1e9e76c4ff5b..09ba69532273 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -440,11 +440,28 @@ static struct net *net_alloc(void)
 	goto out;
 }
 
+static LLIST_HEAD(defer_free_list);
+
+static void net_complete_free(void)
+{
+	struct llist_node *kill_list;
+	struct net *net, *next;
+
+	/* Get the list of namespaces to free from last round. */
+	kill_list = llist_del_all(&defer_free_list);
+
+	llist_for_each_entry_safe(net, next, kill_list, defer_free_list)
+		kmem_cache_free(net_cachep, net);
+
+}
+
 static void net_free(struct net *net)
 {
 	if (refcount_dec_and_test(&net->passive)) {
 		kfree(rcu_access_pointer(net->gen));
-		kmem_cache_free(net_cachep, net);
+
+		/* Wait for an extra rcu_barrier() before final free. */
+		llist_add(&net->defer_free_list, &defer_free_list);
 	}
 }
 
@@ -628,6 +645,8 @@ static void cleanup_net(struct work_struct *work)
 	 */
 	rcu_barrier();
 
+	net_complete_free();
+
 	/* Finally it is safe to free my network namespace structure */
 	list_for_each_entry_safe(net, tmp, &net_exit_list, exit_list) {
 		list_del_init(&net->exit_list);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 069d6ba0e33f..416be038e1ca 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -699,7 +699,13 @@ static void page_pool_release_retry(struct work_struct *wq)
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
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 46a97c915e93..e8e67429e437 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1899,7 +1899,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_NUM_TX_QUEUES]	= { .type = NLA_U32 },
 	[IFLA_NUM_RX_QUEUES]	= { .type = NLA_U32 },
 	[IFLA_GSO_MAX_SEGS]	= { .type = NLA_U32 },
-	[IFLA_GSO_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_GSO_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_PHYS_PORT_ID]	= { .type = NLA_BINARY, .len = MAX_PHYS_ITEM_ID_LEN },
 	[IFLA_CARRIER_CHANGES]	= { .type = NLA_U32 },  /* ignored */
 	[IFLA_PHYS_SWITCH_ID]	= { .type = NLA_BINARY, .len = MAX_PHYS_ITEM_ID_LEN },
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 9077fa969892..29ca19ec82bb 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -100,10 +100,10 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	ehdr->h_proto = htons(ETH_P_IP);
 
 	if (attr->tcp) {
+		memset(thdr, 0, sizeof(*thdr));
 		thdr->source = htons(attr->sport);
 		thdr->dest = htons(attr->dport);
 		thdr->doff = sizeof(struct tcphdr) / 4;
-		thdr->check = 0;
 	} else {
 		uhdr->source = htons(attr->sport);
 		uhdr->dest = htons(attr->dport);
@@ -144,10 +144,18 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	attr->id = net_test_next_id;
 	shdr->id = net_test_next_id++;
 
-	if (attr->size)
-		skb_put(skb, attr->size);
-	if (attr->max_size && attr->max_size > skb->len)
-		skb_put(skb, attr->max_size - skb->len);
+	if (attr->size) {
+		void *payload = skb_put(skb, attr->size);
+
+		memset(payload, 0, attr->size);
+	}
+
+	if (attr->max_size && attr->max_size > skb->len) {
+		size_t pad_len = attr->max_size - skb->len;
+		void *pad = skb_put(skb, pad_len);
+
+		memset(pad, 0, pad_len);
+	}
 
 	skb->csum = 0;
 	skb->ip_summed = CHECKSUM_PARTIAL;
diff --git a/net/core/sock.c b/net/core/sock.c
index dce2bf8dfd1d..7f7f02a01f2d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -144,8 +144,6 @@
 static DEFINE_MUTEX(proto_list_mutex);
 static LIST_HEAD(proto_list);
 
-static void sock_inuse_add(struct net *net, int val);
-
 /**
  * sk_ns_capable - General socket capability test
  * @sk: Socket to use a capability on or through
@@ -3519,11 +3517,6 @@ int sock_prot_inuse_get(struct net *net, struct proto *prot)
 }
 EXPORT_SYMBOL_GPL(sock_prot_inuse_get);
 
-static void sock_inuse_add(struct net *net, int val)
-{
-	this_cpu_add(*net->core.sock_inuse, val);
-}
-
 int sock_inuse_get(struct net *net)
 {
 	int cpu, res = 0;
@@ -3602,9 +3595,6 @@ static inline void release_proto_idx(struct proto *prot)
 {
 }
 
-static void sock_inuse_add(struct net *net, int val)
-{
-}
 #endif
 
 static void tw_prot_cleanup(struct timewait_sock_ops *twsk_prot)
diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index e443088ab0f6..cc96afc6468d 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -196,7 +196,7 @@ static int dsa_switch_do_tag_8021q_vlan_del(struct dsa_switch *ds, int port,
 
 	err = ds->ops->tag_8021q_vlan_del(ds, port, vid);
 	if (err) {
-		refcount_inc(&v->refcount);
+		refcount_set(&v->refcount, 1);
 		return err;
 	}
 
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 0ffcd0e873b6..e35a3e5736cf 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -377,7 +377,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	ret = ops->prepare_data(req_info, reply_data, info);
 	rtnl_unlock();
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_dev;
 	ret = ops->reply_size(req_info, reply_data);
 	if (ret < 0)
 		goto err_cleanup;
@@ -435,7 +435,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, NULL);
 	rtnl_unlock();
 	if (ret < 0)
-		goto out;
+		goto out_cancel;
 	ret = ethnl_fill_reply_header(skb, dev, ctx->ops->hdr_attr);
 	if (ret < 0)
 		goto out;
@@ -444,6 +444,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 out:
 	if (ctx->ops->cleanup_data)
 		ctx->ops->cleanup_data(ctx->reply_data);
+out_cancel:
 	ctx->reply_data->dev = NULL;
 	if (ret < 0)
 		genlmsg_cancel(skb, ehdr);
@@ -628,7 +629,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 	ethnl_init_reply_data(reply_data, ops, dev);
 	ret = ops->prepare_data(req_info, reply_data, NULL);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_rep;
 	ret = ops->reply_size(req_info, reply_data);
 	if (ret < 0)
 		goto err_cleanup;
@@ -664,6 +665,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 err_cleanup:
 	if (ops->cleanup_data)
 		ops->cleanup_data(reply_data);
+err_rep:
 	kfree(reply_data);
 	kfree(req_info);
 	return;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index f8b2fdaef67f..f30a5b7d93f4 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -377,6 +377,7 @@ static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
 	struct inet6_dev *idev = rt->rt6i_idev;
 	struct net_device *loopback_dev =
 		dev_net(dev)->loopback_dev;
+	struct fib6_info *from;
 
 	if (idev && idev->dev != loopback_dev) {
 		struct inet6_dev *loopback_idev = in6_dev_get(loopback_dev);
@@ -385,6 +386,8 @@ static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
 			in6_dev_put(idev);
 		}
 	}
+	from = xchg((__force struct fib6_info **)&rt->from, NULL);
+	fib6_info_release(from);
 }
 
 static bool __rt6_check_expired(const struct rt6_info *rt)
@@ -1443,7 +1446,6 @@ static DEFINE_SPINLOCK(rt6_exception_lock);
 static void rt6_remove_exception(struct rt6_exception_bucket *bucket,
 				 struct rt6_exception *rt6_ex)
 {
-	struct fib6_info *from;
 	struct net *net;
 
 	if (!bucket || !rt6_ex)
@@ -1455,8 +1457,6 @@ static void rt6_remove_exception(struct rt6_exception_bucket *bucket,
 	/* purge completely the exception to allow releasing the held resources:
 	 * some [sk] cache may keep the dst around for unlimited time
 	 */
-	from = xchg((__force struct fib6_info **)&rt6_ex->rt6i->from, NULL);
-	fib6_info_release(from);
 	dst_dev_put(&rt6_ex->rt6i->dst);
 
 	hlist_del_rcu(&rt6_ex->hlist);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e362a08af287..e437bcadf4a2 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -585,6 +585,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		ieee80211_txq_remove_vlan(local, sdata);
 
+	if (sdata->vif.txq)
+		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
+
 	sdata->bss = NULL;
 
 	if (local->open_count == 0)
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 44a6fdb6efbd..e6b6a7508ff1 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -360,6 +360,12 @@ u32 airtime_link_metric_get(struct ieee80211_local *local,
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
@@ -450,8 +456,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
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
@@ -521,8 +527,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_data *sdata,
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
index 0ca031866ce1..53b3a294b042 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -253,6 +253,9 @@ static int mctp_sk_hash(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 
+	/* Bind lookup runs under RCU, remain live during that. */
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	mutex_lock(&net->mctp.bind_lock);
 	sk_add_node_rcu(sk, &net->mctp.binds);
 	mutex_unlock(&net->mctp.bind_lock);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 93d2f028fa91..cd10f4a54de7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -793,6 +793,20 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = (void *)msk;
+
+	switch (optname) {
+	case IPV6_V6ONLY:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    sk->sk_ipv6only);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 int mptcp_getsockopt(struct sock *sk, int level, int optname,
 		     char __user *optval, int __user *option)
 {
@@ -813,6 +827,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	if (ssk)
 		return tcp_getsockopt(ssk, level, optname, optval, option);
 
+	if (level == SOL_IPV6)
+		return mptcp_getsockopt_v6(msk, optname, optval, option);
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	return -EOPNOTSUPP;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d8b33e10750b..2bf7f65b0afe 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -589,8 +589,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 
 	subflow_req = mptcp_subflow_rsk(req);
 	msk = subflow_req->msk;
-	if (!msk)
-		return false;
 
 	subflow_generate_hmac(msk->remote_key, msk->local_key,
 			      subflow_req->remote_nonce,
@@ -716,12 +714,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			fallback = true;
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
@@ -788,6 +782,17 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
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
@@ -1579,9 +1584,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	 */
 	sf->sk->sk_net_refcnt = 1;
 	get_net(net);
-#ifdef CONFIG_PROC_FS
-	this_cpu_add(*net->core.sock_inuse, 1);
-#endif
+	sock_inuse_add(net, 1);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	release_sock(sf->sk);
 
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index fb9f1badeddb..4c9ef2ae4d68 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1384,20 +1384,20 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 		sched = NULL;
 	}
 
-	/* Bind the ct retriever */
-	RCU_INIT_POINTER(svc->pe, pe);
-	pe = NULL;
-
 	/* Update the virtual service counters */
 	if (svc->port == FTPPORT)
 		atomic_inc(&ipvs->ftpsvc_counter);
 	else if (svc->port == 0)
 		atomic_inc(&ipvs->nullsvc_counter);
-	if (svc->pe && svc->pe->conn_out)
+	if (pe && pe->conn_out)
 		atomic_inc(&ipvs->conn_out_counter);
 
 	ip_vs_start_estimator(ipvs, &svc->stats);
 
+	/* Bind the ct retriever */
+	RCU_INIT_POINTER(svc->pe, pe);
+	pe = NULL;
+
 	/* Count only IPv4 services for old get/setsockopt interface */
 	if (svc->af == AF_INET)
 		ipvs->num_services++;
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index dfae90cd3493..ecabe66368ea 100644
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
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index aca6e2b599c8..fd484b38133e 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -913,7 +913,9 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 {
 	struct vport *vport = ovs_vport_rcu(dp, out_port);
 
-	if (likely(vport)) {
+	if (likely(vport &&
+		   netif_running(vport->dev) &&
+		   netif_carrier_ok(vport->dev))) {
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index d9bef3decd70..7db0f8938c14 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2831,7 +2831,8 @@ static int validate_set(const struct nlattr *a,
 	size_t key_len;
 
 	/* There can be only one key in a action */
-	if (nla_total_size(nla_len(ovs_key)) != nla_len(a))
+	if (!nla_ok(ovs_key, nla_len(a)) ||
+	    nla_total_size(nla_len(ovs_key)) != nla_len(a))
 		return -EINVAL;
 
 	key_len = nla_len(ovs_key);
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 65d463ad8770..3ea23e7caab6 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -916,6 +916,37 @@ static int pep_sock_enable(struct sock *sk, struct sockaddr *addr, int len)
 	return 0;
 }
 
+static unsigned int pep_first_packet_length(struct sock *sk)
+{
+	struct pep_sock *pn = pep_sk(sk);
+	struct sk_buff_head *q;
+	struct sk_buff *skb;
+	unsigned int len = 0;
+	bool found = false;
+
+	if (sock_flag(sk, SOCK_URGINLINE)) {
+		q = &pn->ctrlreq_queue;
+		spin_lock_bh(&q->lock);
+		skb = skb_peek(q);
+		if (skb) {
+			len = skb->len;
+			found = true;
+		}
+		spin_unlock_bh(&q->lock);
+	}
+
+	if (likely(!found)) {
+		q = &sk->sk_receive_queue;
+		spin_lock_bh(&q->lock);
+		skb = skb_peek(q);
+		if (skb)
+			len = skb->len;
+		spin_unlock_bh(&q->lock);
+	}
+
+	return len;
+}
+
 static int pep_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
 	struct pep_sock *pn = pep_sk(sk);
@@ -929,15 +960,7 @@ static int pep_ioctl(struct sock *sk, int cmd, unsigned long arg)
 			break;
 		}
 
-		lock_sock(sk);
-		if (sock_flag(sk, SOCK_URGINLINE) &&
-		    !skb_queue_empty(&pn->ctrlreq_queue))
-			answ = skb_peek(&pn->ctrlreq_queue)->len;
-		else if (!skb_queue_empty(&sk->sk_receive_queue))
-			answ = skb_peek(&sk->sk_receive_queue)->len;
-		else
-			answ = 0;
-		release_sock(sk);
+		answ = pep_first_packet_length(sk);
 		ret = put_user(answ, (int __user *)arg);
 		break;
 
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 1f0db6c85b09..85c296664c9a 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -959,6 +959,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	if (cl != NULL) {
 		int old_flags;
+		int len = 0;
 
 		if (parentid) {
 			if (cl->cl_parent &&
@@ -989,9 +990,13 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (usc != NULL)
 			hfsc_change_usc(cl, usc, cur_time);
 
+		if (cl->qdisc->q.qlen != 0)
+			len = qdisc_peek_len(cl->qdisc);
+		/* Check queue length again since some qdisc implementations
+		 * (e.g., netem/codel) might empty the queue during the peek
+		 * operation.
+		 */
 		if (cl->qdisc->q.qlen != 0) {
-			int len = qdisc_peek_len(cl->qdisc);
-
 			if (cl->cl_flags & HFSC_RSC) {
 				if (old_flags & HFSC_RSC)
 					update_ed(cl, len);
@@ -1639,10 +1644,16 @@ hfsc_dequeue(struct Qdisc *sch)
 		if (cl->qdisc->q.qlen != 0) {
 			/* update ed */
 			next_len = qdisc_peek_len(cl->qdisc);
-			if (realtime)
-				update_ed(cl, next_len);
-			else
-				update_d(cl, next_len);
+			/* Check queue length again since some qdisc implementations
+			 * (e.g., netem/codel) might empty the queue during the peek
+			 * operation.
+			 */
+			if (cl->qdisc->q.qlen != 0) {
+				if (realtime)
+					update_ed(cl, next_len);
+				else
+					update_d(cl, next_len);
+			}
 		} else {
 			/* the class becomes passive */
 			eltree_remove(cl);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 528d9ecf1dd8..5e84083e50d7 100644
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
@@ -1828,7 +1829,7 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 
 	if (sctp_wspace(asoc) <= 0 || !sk_wmem_schedule(sk, msg_len)) {
 		timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
-		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len);
+		err = sctp_wait_for_sndbuf(asoc, transport, &timeo, msg_len);
 		if (err)
 			goto err;
 		if (unlikely(sinfo->sinfo_stream >= asoc->stream.outcnt)) {
@@ -9206,8 +9207,9 @@ void sctp_sock_rfree(struct sk_buff *skb)
 
 
 /* Helper function to wait for space in the sndbuf.  */
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len)
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len)
 {
 	struct sock *sk = asoc->base.sk;
 	long current_timeo = *timeo_p;
@@ -9217,7 +9219,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 	pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
 		 *timeo_p, msg_len);
 
-	/* Increment the association's refcnt.  */
+	/* Increment the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_hold(transport);
 	sctp_association_hold(asoc);
 
 	/* Wait on the association specific sndbuf space. */
@@ -9226,7 +9230,7 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 					  TASK_INTERRUPTIBLE);
 		if (asoc->base.dead)
 			goto do_dead;
-		if (!*timeo_p)
+		if ((!*timeo_p) || (transport && transport->dead))
 			goto do_nonblock;
 		if (sk->sk_err || asoc->state >= SCTP_STATE_SHUTDOWN_PENDING)
 			goto do_error;
@@ -9253,7 +9257,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 out:
 	finish_wait(&asoc->wait, &wait);
 
-	/* Release the association's refcnt.  */
+	/* Release the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_put(transport);
 	sctp_association_put(asoc);
 
 	return err;
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index d1add537beaa..687e6a43d049 100644
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
index d13a85b9cdb2..b098b74516d1 100644
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
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 9618e4429f0f..23efd35adaa3 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -716,7 +716,8 @@ void tipc_mon_reinit_self(struct net *net)
 		if (!mon)
 			continue;
 		write_lock_bh(&mon->lock);
-		mon->self->addr = tipc_own_addr(net);
+		if (mon->self)
+			mon->self->addr = tipc_own_addr(net);
 		write_unlock_bh(&mon->lock);
 	}
 }
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 4a3bf8528da7..ba170f1f38a4 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -626,6 +626,11 @@ static int tls_setsockopt(struct sock *sk, int level, int optname,
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
@@ -720,6 +725,7 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_BASE][TLS_BASE] = *base;
 	prot[TLS_BASE][TLS_BASE].setsockopt	= tls_setsockopt;
 	prot[TLS_BASE][TLS_BASE].getsockopt	= tls_getsockopt;
+	prot[TLS_BASE][TLS_BASE].disconnect	= tls_disconnect;
 	prot[TLS_BASE][TLS_BASE].close		= tls_sk_proto_close;
 
 	prot[TLS_SW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
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
index 229a6918b52f..c0deb7044d16 100644
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
  * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
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
index 16c7fbb84276..5f0e7765b8bd 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1365,8 +1365,21 @@ static void azx_free(struct azx *chip)
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
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 5dbe5de81dc3..0f8f08363b53 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -62,6 +62,10 @@
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
@@ -967,6 +972,7 @@ static int wsa_macro_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (substream->stream) {
@@ -978,6 +984,11 @@ static int wsa_macro_hw_params(struct snd_pcm_substream *substream,
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
@@ -1135,35 +1146,11 @@ static void wsa_macro_mclk_enable(struct wsa_macro *wsa, bool mclk_enable)
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
@@ -1172,10 +1159,10 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
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
@@ -1188,9 +1175,7 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
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
@@ -1203,6 +1188,72 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
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
 
diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 94ffd2ba29ae..765ac2a3e963 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2281,7 +2281,7 @@ static irqreturn_t wcd934x_slim_irq_handler(int irq, void *data)
 {
 	struct wcd934x_codec *wcd = data;
 	unsigned long status = 0;
-	int i, j, port_id;
+	unsigned int i, j, port_id;
 	unsigned int val, int_val = 0;
 	irqreturn_t ret = IRQ_NONE;
 	bool tx;
diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index f931288e256c..9c46b25cc654 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -500,11 +500,17 @@ static int fsl_audmix_probe(struct platform_device *pdev)
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
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index b74b67720ef4..ad2c9788e321 100644
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
index a56c1a69b422..c6586da43a04 100644
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
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index c10d91fff2fb..1ddec1f4f05d 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -337,6 +337,21 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 	if (!snd->substreams)
 		return -ENOMEM;
 
+	/*
+	 * Initialize critical substream fields early in case we hit an
+	 * error path and end up trying to clean up uninitialized structures
+	 * elsewhere.
+	 */
+	for (i = 0; i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+
+		vss->snd = snd;
+		vss->sid = i;
+		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
+		init_waitqueue_head(&vss->msg_empty);
+		spin_lock_init(&vss->lock);
+	}
+
 	info = kcalloc(snd->nsubstreams, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -350,12 +365,6 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
 		struct virtio_pcm *vpcm;
 
-		vss->snd = snd;
-		vss->sid = i;
-		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
-		init_waitqueue_head(&vss->msg_empty);
-		spin_lock_init(&vss->lock);
-
 		rc = virtsnd_pcm_build_hw(vss, &info[i]);
 		if (rc)
 			goto on_exit;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c2596b1e1fb1..d2366ec61edc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3416,6 +3416,9 @@ static int validate_entry(struct objtool_file *file, struct instruction *insn)
 			break;
 		}
 
+		if (insn->dead_end)
+			return 0;
+
 		if (!next) {
 			WARN_FUNC("teh end!", insn->sec, insn->offset);
 			return -1;
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
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 1a8fa6b0c887..c78064cf50b1 100644
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
diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 4c88238fc8f0..c0ae86c28d7f 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -261,9 +261,6 @@ TEST(check_file_mmap)
 		TH_LOG("No read-ahead pages found in memory");
 	}
 
-	EXPECT_LT(i, vec_size) {
-		TH_LOG("Read-ahead pages reached the end of the file");
-	}
 	/*
 	 * End of the readahead window. The rest of the pages shouldn't
 	 * be in memory.
diff --git a/tools/testing/selftests/ublk/test_stripe_04.sh b/tools/testing/selftests/ublk/test_stripe_04.sh
new file mode 100755
index 000000000000..1f2b642381d1
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_04.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="stripe_04"
+ERR_CODE=0
+
+_prep_test "stripe" "mkfs & mount & umount on zero copy"
+
+backfile_0=$(_create_backfile 256M)
+backfile_1=$(_create_backfile 256M)
+dev_id=$(_add_ublk_dev -t stripe -z -q 2 "$backfile_0" "$backfile_1")
+_check_add_dev $TID $? "$backfile_0" "$backfile_1"
+
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "stripe"
+
+_remove_backfile "$backfile_0"
+_remove_backfile "$backfile_1"
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index 8e00276b4e69..dc3fc438b3d9 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -27,7 +27,7 @@ fi
 if [[ $cgroup2 ]]; then
   cgroup_path=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup2 none $cgroup_path
     do_umount=1
   fi
@@ -35,7 +35,7 @@ if [[ $cgroup2 ]]; then
 else
   cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup memory,hugetlb $cgroup_path
     do_umount=1
   fi
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
index 14d26075c863..302f2c7003f0 100644
--- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -22,7 +22,7 @@ fi
 if [[ $cgroup2 ]]; then
   CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$CGROUP_ROOT" ]]; then
-    CGROUP_ROOT=/dev/cgroup/memory
+    CGROUP_ROOT=$(mktemp -d)
     mount -t cgroup2 none $CGROUP_ROOT
     do_umount=1
   fi

