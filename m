Return-Path: <stable+bounces-45385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239F8C85F6
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 13:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149F11F2589A
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 11:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B64C3CD;
	Fri, 17 May 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xKVptYYj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CF41A91;
	Fri, 17 May 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947100; cv=none; b=QfQkN695qUJoXnW1YSo4hTgi6kCQ5qGqib3RImBc7CW10ivjugAhiyVq5luwm6x/xLMofCICuDH1hDRDdbyQEGpND5pccbHW2d8ieDOpchh4iZkid/nncrw3QfeQoILDt1T0PGILsTX2Em5ETKQ+nLwg59qJfqewN4WuvEMd9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947100; c=relaxed/simple;
	bh=paVupn+L/6bHhTyA2gljMl2ZJ57IdwMSs6IoxtvKglc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXCup8/I16FIMhVy3QESjxRRnmMOiOVHUkZ2MY28viU4lZb1XuoUqPwvEoJT/YIJdhdM7P79jW29Bg4D1cPWpEckxgiVK13sixNWVubaaWLqfWPcR6BEb08+pVahgXhGNWPE7LzxUS2vNL2BV/MhUZ3GymBf/lcYw+QHCRZluAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xKVptYYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF57C2BD10;
	Fri, 17 May 2024 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715947100;
	bh=paVupn+L/6bHhTyA2gljMl2ZJ57IdwMSs6IoxtvKglc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xKVptYYjZmlug5zVR3kVNR1jVJvYoSXt7vBog9AbCQJGX/ZYluak1ePi37Kbskoi3
	 IJ4StcUD6TbzVniUvWKVTqoCPeh8FP75iBUrSCRDXu1/TUoMPiui0NO9dJ1vt+rnKX
	 CEYDqysq+Ne94kKljT3XYxL3Uzn6paiY0+qfbDx8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.159
Date: Fri, 17 May 2024 13:58:11 +0200
Message-ID: <2024051710-reenter-festival-b77a@gregkh>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <2024051710-stained-prepaid-283a@gregkh>
References: <2024051710-stained-prepaid-283a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
index c13c10c8d65d..eed0df9d3a23 100644
--- a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
@@ -42,7 +42,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: maxim,max30100
+            const: maxim,max30102
     then:
       properties:
         maxim,green-led-current-microamp: false
diff --git a/Makefile b/Makefile
index 04e9de5b174d..5cbfe2be72dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 158
+SUBLEVEL = 159
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 43077e11dafd..2acf880fcc34 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -114,6 +114,10 @@ ENDPROC(cpu_resume_mmu)
 	.popsection
 cpu_resume_after_mmu:
 	bl	cpu_init		@ restore the und/abt/irq banked regs
+#if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
+	mov	r0, sp
+	bl	kasan_unpoison_task_stack_below
+#endif
 	mov	r0, #0			@ return zero on success
 	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_resume_after_mmu)
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 7eadecba0175..d636718adbde 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -958,10 +958,10 @@ pcie0: pci@1c00000 {
 			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map =	<0 0 0 1 &intc 0 135 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 2 &intc 0 136 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 3 &intc 0 138 IRQ_TYPE_LEVEL_HIGH>,
-					<0 0 0 4 &intc 0 139 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map =	<0 0 0 1 &intc 0 0 135 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 136 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 138 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 139 IRQ_TYPE_LEVEL_HIGH>;
 
 			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
 				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 15af6c7ad06c..6f7061c878e4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1996,10 +1996,10 @@ pcie0: pci@1c00000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
 				 <&gcc GCC_PCIE_0_AUX_CLK>,
@@ -2101,10 +2101,10 @@ pcie1: pci@1c08000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
 				 <&gcc GCC_PCIE_1_AUX_CLK>,
diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
index 7740995de982..e80b638b7827 100644
--- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
+++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
@@ -284,16 +284,12 @@ int kvm_register_vgic_device(unsigned long type)
 int vgic_v2_parse_attr(struct kvm_device *dev, struct kvm_device_attr *attr,
 		       struct vgic_reg_attr *reg_attr)
 {
-	int cpuid;
+	int cpuid = FIELD_GET(KVM_DEV_ARM_VGIC_CPUID_MASK, attr->attr);
 
-	cpuid = (attr->attr & KVM_DEV_ARM_VGIC_CPUID_MASK) >>
-		 KVM_DEV_ARM_VGIC_CPUID_SHIFT;
-
-	if (cpuid >= atomic_read(&dev->kvm->online_vcpus))
-		return -EINVAL;
-
-	reg_attr->vcpu = kvm_get_vcpu(dev->kvm, cpuid);
 	reg_attr->addr = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
+	reg_attr->vcpu = kvm_get_vcpu_by_id(dev->kvm, cpuid);
+	if (!reg_attr->vcpu)
+		return -EINVAL;
 
 	return 0;
 }
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index b3e4dd6be7e2..428b9f1cf1de 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -157,7 +157,7 @@ static inline long regs_return_value(struct pt_regs *regs)
 #define instruction_pointer(regs) ((regs)->cp0_epc)
 #define profile_pc(regs) instruction_pointer(regs)
 
-extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
+extern asmlinkage long syscall_trace_enter(struct pt_regs *regs);
 extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
 
 extern void die(const char *, struct pt_regs *) __noreturn;
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 04ca75278f02..6cd0246aa2c6 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -98,6 +98,7 @@ void output_thread_info_defines(void)
 	OFFSET(TI_CPU, thread_info, cpu);
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
 	OFFSET(TI_REGS, thread_info, regs);
+	OFFSET(TI_SYSCALL, thread_info, syscall);
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
 	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index db7c5be1d4a3..dd454b429ff7 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1310,16 +1310,13 @@ long arch_ptrace(struct task_struct *child, long request,
  * Notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
-asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
+asmlinkage long syscall_trace_enter(struct pt_regs *regs)
 {
 	user_exit();
 
-	current_thread_info()->syscall = syscall;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
 		if (tracehook_report_syscall_entry(regs))
 			return -1;
-		syscall = current_thread_info()->syscall;
 	}
 
 #ifdef CONFIG_SECCOMP
@@ -1328,7 +1325,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		struct seccomp_data sd;
 		unsigned long args[6];
 
-		sd.nr = syscall;
+		sd.nr = current_thread_info()->syscall;
 		sd.arch = syscall_get_arch(current);
 		syscall_get_arguments(current, regs, args);
 		for (i = 0; i < 6; i++)
@@ -1338,23 +1335,23 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		ret = __secure_computing(&sd);
 		if (ret == -1)
 			return ret;
-		syscall = current_thread_info()->syscall;
 	}
 #endif
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
 
-	audit_syscall_entry(syscall, regs->regs[4], regs->regs[5],
+	audit_syscall_entry(current_thread_info()->syscall,
+			    regs->regs[4], regs->regs[5],
 			    regs->regs[6], regs->regs[7]);
 
 	/*
 	 * Negative syscall numbers are mistaken for rejected syscalls, but
 	 * won't have had the return value set appropriately, so we do so now.
 	 */
-	if (syscall < 0)
+	if (current_thread_info()->syscall < 0)
 		syscall_set_return_value(current, regs, -ENOSYS, 0);
-	return syscall;
+	return current_thread_info()->syscall;
 }
 
 /*
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 9bfce5f75f60..6c14160cd8ba 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -78,6 +78,18 @@ loads_done:
 	PTR_WD	load_a7, bad_stack_a7
 	.previous
 
+	/*
+	 * syscall number is in v0 unless we called syscall(__NR_###)
+	 * where the real syscall number is in a0
+	 */
+	subu	t2, v0,  __NR_O32_Linux
+	bnez	t2, 1f /* __NR_syscall at offset 0 */
+	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
+	b	2f
+1:
+	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
+2:
+
 	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	and	t0, t1
@@ -115,16 +127,7 @@ syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
 
-	/*
-	 * syscall number is in v0 unless we called syscall(__NR_###)
-	 * where the real syscall number is in a0
-	 */
-	move	a1, v0
-	subu	t2, v0,  __NR_O32_Linux
-	bnez	t2, 1f /* __NR_syscall at offset 0 */
-	lw	a1, PT_R4(sp)
-
-1:	jal	syscall_trace_enter
+	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 97456b2ca7dc..97788859238c 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -44,6 +44,8 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
+	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -72,7 +74,6 @@ syscall_common:
 n32_syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
-	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index 5f6ed4b4c399..db5811538563 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -47,6 +47,8 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
+	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -83,7 +85,6 @@ n64_syscall_exit:
 syscall_trace_entry:
 	SAVE_STATIC
 	move	a0, sp
-	move	a1, v0
 	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index d3c2616cba22..7a5abb73e531 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -79,6 +79,22 @@ loads_done:
 	PTR_WD	load_a7, bad_stack_a7
 	.previous
 
+	/*
+	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
+	 * where the real syscall number is in a0
+	 * note: NR_syscall is the first O32 syscall but the macro is
+	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
+	 * therefore __NR_O32_Linux is used (4000)
+	 */
+
+	subu	t2, v0,  __NR_O32_Linux
+	bnez	t2, 1f /* __NR_syscall at offset 0 */
+	LONG_S	a0, TI_SYSCALL($28)	# Save a0 as syscall number
+	b	2f
+1:
+	LONG_S	v0, TI_SYSCALL($28)	# Save v0 as syscall number
+2:
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -113,22 +129,7 @@ trace_a_syscall:
 	sd	a7, PT_R11(sp)		# For indirect syscalls
 
 	move	a0, sp
-	/*
-	 * absolute syscall number is in v0 unless we called syscall(__NR_###)
-	 * where the real syscall number is in a0
-	 * note: NR_syscall is the first O32 syscall but the macro is
-	 * only defined when compiling with -mabi=32 (CONFIG_32BIT)
-	 * therefore __NR_O32_Linux is used (4000)
-	 */
-	.set	push
-	.set	reorder
-	subu	t1, v0,  __NR_O32_Linux
-	move	a1, v0
-	bnez	t1, 1f /* __NR_syscall at offset 0 */
-	ld	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
-	.set	pop
-
-1:	jal	syscall_trace_enter
+	jal	syscall_trace_enter
 
 	bltz	v0, 1f			# seccomp failed? Skip syscall
 
diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index 4f21ae561e4d..390906b8e386 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -9,6 +9,7 @@
 #define CFI_DEF_CFA_OFFSET	.cfi_def_cfa_offset
 #define CFI_ADJUST_CFA_OFFSET	.cfi_adjust_cfa_offset
 #define CFI_RESTORE		.cfi_restore
+#define CFI_REL_OFFSET		.cfi_rel_offset
 
 #ifdef CONFIG_AS_CFI_VAL_OFFSET
 #define CFI_VAL_OFFSET		.cfi_val_offset
diff --git a/arch/s390/kernel/vdso64/vdso_user_wrapper.S b/arch/s390/kernel/vdso64/vdso_user_wrapper.S
index 97f0c0a669a5..0625381359df 100644
--- a/arch/s390/kernel/vdso64/vdso_user_wrapper.S
+++ b/arch/s390/kernel/vdso64/vdso_user_wrapper.S
@@ -23,8 +23,10 @@ __kernel_\func:
 	CFI_DEF_CFA_OFFSET (STACK_FRAME_OVERHEAD + WRAPPER_FRAME_SIZE)
 	CFI_VAL_OFFSET 15, -STACK_FRAME_OVERHEAD
 	stg	%r14,STACK_FRAME_OVERHEAD(%r15)
+	CFI_REL_OFFSET 14, STACK_FRAME_OVERHEAD
 	brasl	%r14,__s390_vdso_\func
 	lg	%r14,STACK_FRAME_OVERHEAD(%r15)
+	CFI_RESTORE 14
 	aghi	%r15,WRAPPER_FRAME_SIZE
 	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD
 	CFI_RESTORE 15
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index a2c872de29a6..32d9db5e6f53 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2632,7 +2632,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 		return 0;
 
 	start = pmd_val(*pmd) & HPAGE_MASK;
-	end = start + HPAGE_SIZE - 1;
+	end = start + HPAGE_SIZE;
 	__storage_key_init_range(start, end);
 	set_bit(PG_arch_1, &page->flags);
 	cond_resched();
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index da36d13ffc16..8631307d3def 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -146,7 +146,7 @@ static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
 	}
 
 	if (!test_and_set_bit(PG_arch_1, &page->flags))
-		__storage_key_init_range(paddr, paddr + size - 1);
+		__storage_key_init_range(paddr, paddr + size);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 645a589edda8..bfdb7b0cf49d 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1336,7 +1336,7 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	struct blkcg_gq *blkg = iocg_to_blkg(iocg);
-	u64 tdelta, delay, new_delay;
+	u64 tdelta, delay, new_delay, shift;
 	s64 vover, vover_pct;
 	u32 hwa;
 
@@ -1351,8 +1351,9 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 
 	/* calculate the current delay in effect - 1/2 every second */
 	tdelta = now->now - iocg->delay_at;
-	if (iocg->delay)
-		delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
+	shift = div64_u64(tdelta, USEC_PER_SEC);
+	if (iocg->delay && shift < BITS_PER_LONG)
+		delay = iocg->delay >> shift;
 	else
 		delay = 0;
 
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7cc9183c8dc8..6dcce036adb9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -161,6 +161,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
+/* Check for valid access_width, otherwise, fallback to using bit_width */
+#define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
+
+/* Shift and apply the mask for CPC reads/writes */
+#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
+					GENMASK(((reg)->bit_width) - 1, 0))
+
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -762,8 +769,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 				if (gas_t->address) {
 					void __iomem *addr;
+					size_t access_width;
 
-					addr = ioremap(gas_t->address, gas_t->bit_width/8);
+					access_width = GET_BIT_WIDTH(gas_t) / 8;
+					addr = ioremap(gas_t->address, access_width);
 					if (!addr)
 						goto out_free;
 					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
@@ -936,6 +945,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 {
 	int ret_val = 0;
 	void __iomem *vaddr = NULL;
+	int size;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
@@ -945,17 +955,26 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	size = GET_BIT_WIDTH(reg);
+
+	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
+		/*
+		 * For registers in PCC space, the register size is determined
+		 * by the bit width field; the access size is used to indicate
+		 * the PCC subspace id.
+		 */
+		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
+	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
 	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
 		return cpc_read_ffh(cpu, reg, val);
 	else
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
-				val, reg->bit_width);
+				val, size);
 
-	switch (reg->bit_width) {
+	switch (size) {
 	case 8:
 		*val = readb_relaxed(vaddr);
 		break;
@@ -969,32 +988,53 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		*val = readq_relaxed(vaddr);
 		break;
 	default:
-		pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
-			 reg->bit_width, pcc_ss_id);
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_debug("Error: Cannot read %u bit width from system memory: 0x%llx\n",
+				size, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
+				size, pcc_ss_id);
+		}
 		ret_val = -EFAULT;
 	}
 
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		*val = MASK_VAL(reg, *val);
+
 	return ret_val;
 }
 
 static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
+	int size;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	size = GET_BIT_WIDTH(reg);
+
+	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
+		/*
+		 * For registers in PCC space, the register size is determined
+		 * by the bit width field; the access size is used to indicate
+		 * the PCC subspace id.
+		 */
+		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
+	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
 	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
 		return cpc_write_ffh(cpu, reg, val);
 	else
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
-				val, reg->bit_width);
+				val, size);
+
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		val = MASK_VAL(reg, val);
 
-	switch (reg->bit_width) {
+	switch (size) {
 	case 8:
 		writeb_relaxed(val, vaddr);
 		break;
@@ -1008,8 +1048,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		writeq_relaxed(val, vaddr);
 		break;
 	default:
-		pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
-			 reg->bit_width, pcc_ss_id);
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_debug("Error: Cannot write %u bit width to system memory: 0x%llx\n",
+				size, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
+				size, pcc_ss_id);
+		}
 		ret_val = -EFAULT;
 		break;
 	}
diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 6fd54e968d10..1564472fd5d5 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -201,7 +201,10 @@ int gemini_sata_start_bridge(struct sata_gemini *sg, unsigned int bridge)
 		pclk = sg->sata0_pclk;
 	else
 		pclk = sg->sata1_pclk;
-	clk_enable(pclk);
+	ret = clk_enable(pclk);
+	if (ret)
+		return ret;
+
 	msleep(10);
 
 	/* Do not keep clocking a bridge that is not online */
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 0f3943ac5417..d4ae33a5f805 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -182,9 +182,10 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
 
-static void qca_tlv_check_data(struct hci_dev *hdev,
+static int qca_tlv_check_data(struct hci_dev *hdev,
 			       struct qca_fw_config *config,
-		u8 *fw_data, enum qca_btsoc_type soc_type)
+			       u8 *fw_data, size_t fw_size,
+			       enum qca_btsoc_type soc_type)
 {
 	const u8 *data;
 	u32 type_len;
@@ -194,12 +195,16 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 	struct tlv_type_patch *tlv_patch;
 	struct tlv_type_nvm *tlv_nvm;
 	uint8_t nvm_baud_rate = config->user_baud_rate;
+	u8 type;
 
 	config->dnld_mode = QCA_SKIP_EVT_NONE;
 	config->dnld_type = QCA_SKIP_EVT_NONE;
 
 	switch (config->type) {
 	case ELF_TYPE_PATCH:
+		if (fw_size < 7)
+			return -EINVAL;
+
 		config->dnld_mode = QCA_SKIP_EVT_VSE_CC;
 		config->dnld_type = QCA_SKIP_EVT_VSE_CC;
 
@@ -208,6 +213,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 		bt_dev_dbg(hdev, "File version      : 0x%x", fw_data[6]);
 		break;
 	case TLV_TYPE_PATCH:
+		if (fw_size < sizeof(struct tlv_type_hdr) + sizeof(struct tlv_type_patch))
+			return -EINVAL;
+
 		tlv = (struct tlv_type_hdr *)fw_data;
 		type_len = le32_to_cpu(tlv->type_len);
 		tlv_patch = (struct tlv_type_patch *)tlv->data;
@@ -247,25 +255,56 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 		break;
 
 	case TLV_TYPE_NVM:
+		if (fw_size < sizeof(struct tlv_type_hdr))
+			return -EINVAL;
+
 		tlv = (struct tlv_type_hdr *)fw_data;
 
 		type_len = le32_to_cpu(tlv->type_len);
-		length = (type_len >> 8) & 0x00ffffff;
+		length = type_len >> 8;
+		type = type_len & 0xff;
 
-		BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
+		/* Some NVM files have more than one set of tags, only parse
+		 * the first set when it has type 2 for now. When there is
+		 * more than one set there is an enclosing header of type 4.
+		 */
+		if (type == 4) {
+			if (fw_size < 2 * sizeof(struct tlv_type_hdr))
+				return -EINVAL;
+
+			tlv++;
+
+			type_len = le32_to_cpu(tlv->type_len);
+			length = type_len >> 8;
+			type = type_len & 0xff;
+		}
+
+		BT_DBG("TLV Type\t\t : 0x%x", type);
 		BT_DBG("Length\t\t : %d bytes", length);
 
+		if (type != 2)
+			break;
+
+		if (fw_size < length + (tlv->data - fw_data))
+			return -EINVAL;
+
 		idx = 0;
 		data = tlv->data;
-		while (idx < length) {
+		while (idx < length - sizeof(struct tlv_type_nvm)) {
 			tlv_nvm = (struct tlv_type_nvm *)(data + idx);
 
 			tag_id = le16_to_cpu(tlv_nvm->tag_id);
 			tag_len = le16_to_cpu(tlv_nvm->tag_len);
 
+			if (length < idx + sizeof(struct tlv_type_nvm) + tag_len)
+				return -EINVAL;
+
 			/* Update NVM tags as needed */
 			switch (tag_id) {
 			case EDL_TAG_ID_HCI:
+				if (tag_len < 3)
+					return -EINVAL;
+
 				/* HCI transport layer parameters
 				 * enabling software inband sleep
 				 * onto controller side.
@@ -281,6 +320,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 				break;
 
 			case EDL_TAG_ID_DEEP_SLEEP:
+				if (tag_len < 1)
+					return -EINVAL;
+
 				/* Sleep enable mask
 				 * enabling deep sleep feature on controller.
 				 */
@@ -289,14 +331,16 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 				break;
 			}
 
-			idx += (sizeof(u16) + sizeof(u16) + 8 + tag_len);
+			idx += sizeof(struct tlv_type_nvm) + tag_len;
 		}
 		break;
 
 	default:
 		BT_ERR("Unknown TLV type %d", config->type);
-		break;
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
@@ -446,7 +490,9 @@ static int qca_download_firmware(struct hci_dev *hdev,
 	memcpy(data, fw->data, size);
 	release_firmware(fw);
 
-	qca_tlv_check_data(hdev, config, data, soc_type);
+	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
+	if (ret)
+		goto out;
 
 	segment = data;
 	remain = size;
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a05b5bca6425..dc2bcf58fc10 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4227,7 +4227,8 @@ void clk_unregister(struct clk *clk)
 	if (ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
-		goto unlock;
+		clk_prepare_unlock();
+		return;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -4261,11 +4262,10 @@ void clk_unregister(struct clk *clk)
 	if (clk->core->protect_count)
 		pr_warn("%s: unregistering protected clock: %s\n",
 					__func__, clk->core->name);
+	clk_prepare_unlock();
 
 	kref_put(&clk->core->ref, __clk_release);
 	free_clk(clk);
-unlock:
-	clk_prepare_unlock();
 }
 EXPORT_SYMBOL_GPL(clk_unregister);
 
@@ -4471,13 +4471,11 @@ void __clk_put(struct clk *clk)
 	    clk->max_rate < clk->core->req_rate)
 		clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
 
-	owner = clk->core->owner;
-	kref_put(&clk->core->ref, __clk_release);
-
 	clk_prepare_unlock();
 
+	owner = clk->core->owner;
+	kref_put(&clk->core->ref, __clk_release);
 	module_put(owner);
-
 	free_clk(clk);
 }
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index c0800da2fa3d..736a781e4007 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -1181,12 +1181,19 @@ static const u32 usb2_clk_regs[] = {
 	SUN50I_H6_USB3_CLK_REG,
 };
 
+static struct ccu_mux_nb sun50i_h6_cpu_nb = {
+	.common		= &cpux_clk.common,
+	.cm		= &cpux_clk.mux,
+	.delay_us       = 1,
+	.bypass_index   = 0, /* index of 24 MHz oscillator */
+};
+
 static int sun50i_h6_ccu_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	void __iomem *reg;
+	int i, ret;
 	u32 val;
-	int i;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(&pdev->dev, res);
@@ -1240,7 +1247,15 @@ static int sun50i_h6_ccu_probe(struct platform_device *pdev)
 	val |= BIT(24);
 	writel(val, reg + SUN50I_H6_HDMI_CEC_CLK_REG);
 
-	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_h6_ccu_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_h6_ccu_desc);
+	if (ret)
+		return ret;
+
+	/* Reparent CPU during PLL CPUX rate changes */
+	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
+				  &sun50i_h6_cpu_nb);
+
+	return 0;
 }
 
 static const struct of_device_id sun50i_h6_ccu_ids[] = {
diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index b0d671db178a..ea31ac7ac1ca 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -148,10 +148,12 @@ packet_buffer_get(struct client *client, char __user *data, size_t user_length)
 	if (atomic_read(&buffer->size) == 0)
 		return -ENODEV;
 
-	/* FIXME: Check length <= user_length. */
+	length = buffer->head->length;
+
+	if (length > user_length)
+		return 0;
 
 	end = buffer->data + buffer->capacity;
-	length = buffer->head->length;
 
 	if (&buffer->head->data[length] < end) {
 		if (copy_to_user(data, buffer->head->data, length))
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 667ff40f3935..7d94e1cbc0ed 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2049,6 +2049,8 @@ static void bus_reset_work(struct work_struct *work)
 
 	ohci->generation = generation;
 	reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
+	if (param_debug & OHCI_PARAM_DEBUG_BUSRESETS)
+		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
 
 	if (ohci->quirks & QUIRK_RESET_PACKET)
 		ohci->request_generation = generation;
@@ -2115,12 +2117,14 @@ static irqreturn_t irq_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	/*
-	 * busReset and postedWriteErr must not be cleared yet
+	 * busReset and postedWriteErr events must not be cleared yet
 	 * (OHCI 1.1 clauses 7.2.3.2 and 13.2.8.1)
 	 */
 	reg_write(ohci, OHCI1394_IntEventClear,
 		  event & ~(OHCI1394_busReset | OHCI1394_postedWriteErr));
 	log_irqs(ohci, event);
+	if (event & OHCI1394_busReset)
+		reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
 
 	if (event & OHCI1394_selfIDComplete)
 		queue_work(selfid_workqueue, &ohci->bus_reset_work);
diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index 5a909f3c79e8..c48a82c24087 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -91,7 +91,7 @@ static inline int to_reg(int gpio, enum ctrl_register reg_type)
 		case 0x5e:
 			return GPIOPANELCTL;
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
 
diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index 16a0fae1e32e..2df948e16eb7 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -104,7 +104,7 @@ static inline int to_reg(int gpio, enum ctrl_register type)
 	unsigned int reg = type == CTRL_IN ? GPIO_IN_CTRL_BASE : GPIO_OUT_CTRL_BASE;
 
 	if (gpio >= WCOVE_GPIO_NUM)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	return reg + gpio;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 228f098e5d88..6bc8c6bee411 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2303,6 +2303,7 @@ static enum bp_result construct_integrated_info(
 				result = get_integrated_info_v2_1(bp, info);
 				break;
 			case 2:
+			case 3:
 				result = get_integrated_info_v2_2(bp, info);
 				break;
 			default:
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index cfe163103cfd..1140292820bb 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2460,7 +2460,7 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
 						     dev->mode_config.max_width,
 						     dev->mode_config.max_height);
 		else
-			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe",
+			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe\n",
 				    connector->base.id, connector->name);
 	}
 
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 5cd2b2ebbbd3..2c8e978eb9ab 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -105,6 +105,8 @@
 #define HHI_HDMI_CLK_CNTL	0x1cc /* 0x73 */
 #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 */
 #define HHI_HDMI_PHY_CNTL1	0x3a4 /* 0xe9 */
+#define  PHY_CNTL1_INIT		0x03900000
+#define  PHY_INVERT		BIT(17)
 #define HHI_HDMI_PHY_CNTL2	0x3a8 /* 0xea */
 #define HHI_HDMI_PHY_CNTL3	0x3ac /* 0xeb */
 #define HHI_HDMI_PHY_CNTL4	0x3b0 /* 0xec */
@@ -129,6 +131,8 @@ struct meson_dw_hdmi_data {
 				    unsigned int addr);
 	void		(*dwc_write)(struct meson_dw_hdmi *dw_hdmi,
 				     unsigned int addr, unsigned int data);
+	u32 cntl0_init;
+	u32 cntl1_init;
 };
 
 struct meson_dw_hdmi {
@@ -384,26 +388,6 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	     drm_mode_is_420_also(display, mode)))
 		mode_is_420 = true;
 
-	/* Enable clocks */
-	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
-
-	/* Bring HDMITX MEM output of power down */
-	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
-
-	/* Bring out of reset */
-	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_SW_RESET,  0);
-
-	/* Enable internal pixclk, tmds_clk, spdif_clk, i2s_clk, cecclk */
-	dw_hdmi_top_write_bits(dw_hdmi, HDMITX_TOP_CLK_CNTL,
-			       0x3, 0x3);
-
-	/* Enable cec_clk and hdcp22_tmdsclk_en */
-	dw_hdmi_top_write_bits(dw_hdmi, HDMITX_TOP_CLK_CNTL,
-			       0x3 << 4, 0x3 << 4);
-
-	/* Enable normal output to PHY */
-	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
-
 	/* TMDS pattern setup */
 	if (mode->clock > 340000 && !mode_is_420) {
 		dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
@@ -425,20 +409,6 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	/* Setup PHY parameters */
 	meson_hdmi_phy_setup_mode(dw_hdmi, mode, mode_is_420);
 
-	/* Setup PHY */
-	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
-			   0xffff << 16, 0x0390 << 16);
-
-	/* BIT_INVERT */
-	if (dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
-	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
-	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
-		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
-				   BIT(17), 0);
-	else
-		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
-				   BIT(17), BIT(17));
-
 	/* Disable clock, fifo, fifo_wr */
 	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1, 0xf, 0);
 
@@ -492,7 +462,9 @@ static void dw_hdmi_phy_disable(struct dw_hdmi *hdmi,
 
 	DRM_DEBUG_DRIVER("\n");
 
-	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0);
+	/* Fallback to init mode */
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL1, dw_hdmi->data->cntl1_init);
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, dw_hdmi->data->cntl0_init);
 }
 
 static enum drm_connector_status dw_hdmi_read_hpd(struct dw_hdmi *hdmi,
@@ -610,11 +582,22 @@ static const struct regmap_config meson_dw_hdmi_regmap_config = {
 	.fast_io = true,
 };
 
-static const struct meson_dw_hdmi_data meson_dw_hdmi_gx_data = {
+static const struct meson_dw_hdmi_data meson_dw_hdmi_gxbb_data = {
 	.top_read = dw_hdmi_top_read,
 	.top_write = dw_hdmi_top_write,
 	.dwc_read = dw_hdmi_dwc_read,
 	.dwc_write = dw_hdmi_dwc_write,
+	.cntl0_init = 0x0,
+	.cntl1_init = PHY_CNTL1_INIT | PHY_INVERT,
+};
+
+static const struct meson_dw_hdmi_data meson_dw_hdmi_gxl_data = {
+	.top_read = dw_hdmi_top_read,
+	.top_write = dw_hdmi_top_write,
+	.dwc_read = dw_hdmi_dwc_read,
+	.dwc_write = dw_hdmi_dwc_write,
+	.cntl0_init = 0x0,
+	.cntl1_init = PHY_CNTL1_INIT,
 };
 
 static const struct meson_dw_hdmi_data meson_dw_hdmi_g12a_data = {
@@ -622,6 +605,8 @@ static const struct meson_dw_hdmi_data meson_dw_hdmi_g12a_data = {
 	.top_write = dw_hdmi_g12a_top_write,
 	.dwc_read = dw_hdmi_g12a_dwc_read,
 	.dwc_write = dw_hdmi_g12a_dwc_write,
+	.cntl0_init = 0x000b4242, /* Bandgap */
+	.cntl1_init = PHY_CNTL1_INIT,
 };
 
 static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
@@ -656,6 +641,13 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
 	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
 				       HDMITX_TOP_CLK_CNTL, 0xff);
 
+	/* Enable normal output to PHY */
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
+
+	/* Setup PHY */
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL1, meson_dw_hdmi->data->cntl1_init);
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, meson_dw_hdmi->data->cntl0_init);
+
 	/* Enable HDMI-TX Interrupt */
 	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
 				       HDMITX_TOP_INTR_CORE);
@@ -883,11 +875,11 @@ static const struct dev_pm_ops meson_dw_hdmi_pm_ops = {
 
 static const struct of_device_id meson_dw_hdmi_of_table[] = {
 	{ .compatible = "amlogic,meson-gxbb-dw-hdmi",
-	  .data = &meson_dw_hdmi_gx_data },
+	  .data = &meson_dw_hdmi_gxbb_data },
 	{ .compatible = "amlogic,meson-gxl-dw-hdmi",
-	  .data = &meson_dw_hdmi_gx_data },
+	  .data = &meson_dw_hdmi_gxl_data },
 	{ .compatible = "amlogic,meson-gxm-dw-hdmi",
-	  .data = &meson_dw_hdmi_gx_data },
+	  .data = &meson_dw_hdmi_gxl_data },
 	{ .compatible = "amlogic,meson-g12a-dw-hdmi",
 	  .data = &meson_dw_hdmi_g12a_data },
 	{ }
diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 447b7594b35a..0107a21dc9f9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -109,12 +109,15 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
 	u8 *dpcd = nv_encoder->dp.dpcd;
 	int ret = NOUVEAU_DP_NONE;
 
-	/* If we've already read the DPCD on an eDP device, we don't need to
-	 * reread it as it won't change
+	/* eDP ports don't support hotplugging - so there's no point in probing eDP ports unless we
+	 * haven't probed them once before.
 	 */
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    dpcd[DP_DPCD_REV] != 0)
-		return NOUVEAU_DP_SST;
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		if (connector->status == connector_status_connected)
+			return NOUVEAU_DP_SST;
+		else if (connector->status == connector_status_disconnected)
+			return NOUVEAU_DP_NONE;
+	}
 
 	mutex_lock(&nv_encoder->dp.hpd_irq_lock);
 	if (mstm) {
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index e1542451ef9d..0d89779de22b 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -420,7 +420,7 @@ static int ili9341_dpi_prepare(struct drm_panel *panel)
 
 	ili9341_dpi_init(ili);
 
-	return ret;
+	return 0;
 }
 
 static int ili9341_dpi_enable(struct drm_panel *panel)
@@ -716,18 +716,18 @@ static int ili9341_probe(struct spi_device *spi)
 
 	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset))
-		dev_err(dev, "Failed to get gpio 'reset'\n");
+		return dev_err_probe(dev, PTR_ERR(reset), "Failed to get gpio 'reset'\n");
 
 	dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
 	if (IS_ERR(dc))
-		dev_err(dev, "Failed to get gpio 'dc'\n");
+		return dev_err_probe(dev, PTR_ERR(dc), "Failed to get gpio 'dc'\n");
 
 	if (!strcmp(id->name, "sf-tc240t-9370-t"))
 		return ili9341_dpi_probe(spi, dc, reset);
 	else if (!strcmp(id->name, "yx240qv29"))
 		return ili9341_dbi_probe(spi, dc, reset);
 
-	return -1;
+	return -ENODEV;
 }
 
 static int ili9341_remove(struct spi_device *spi)
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index d4f26075383d..b19f2f00b215 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -58,56 +58,16 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 			   signed long timeout)
 {
 	struct qxl_device *qdev;
-	struct qxl_release *release;
-	int count = 0, sc = 0;
-	bool have_drawable_releases;
 	unsigned long cur, end = jiffies + timeout;
 
 	qdev = container_of(fence->lock, struct qxl_device, release_lock);
-	release = container_of(fence, struct qxl_release, base);
-	have_drawable_releases = release->type == QXL_RELEASE_DRAWABLE;
-
-retry:
-	sc++;
-
-	if (dma_fence_is_signaled(fence))
-		goto signaled;
-
-	qxl_io_notify_oom(qdev);
-
-	for (count = 0; count < 11; count++) {
-		if (!qxl_queue_garbage_collect(qdev, true))
-			break;
-
-		if (dma_fence_is_signaled(fence))
-			goto signaled;
-	}
-
-	if (dma_fence_is_signaled(fence))
-		goto signaled;
 
-	if (have_drawable_releases || sc < 4) {
-		if (sc > 2)
-			/* back off */
-			usleep_range(500, 1000);
-
-		if (time_after(jiffies, end))
-			return 0;
-
-		if (have_drawable_releases && sc > 300) {
-			DMA_FENCE_WARN(fence,
-				       "failed to wait on release %llu after spincount %d\n",
-				       fence->context & ~0xf0000000, sc);
-			goto signaled;
-		}
-		goto retry;
-	}
-	/*
-	 * yeah, original sync_obj_wait gave up after 3 spins when
-	 * have_drawable_releases is not set.
-	 */
+	if (!wait_event_timeout(qdev->release_event,
+				(dma_fence_is_signaled(fence) ||
+				 (qxl_io_notify_oom(qdev), 0)),
+				timeout))
+		return 0;
 
-signaled:
 	cur = jiffies;
 	if (time_after(cur, end))
 		return 0;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index b32ddbb992de..50eba25456bb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -1068,7 +1068,7 @@ static int vmw_event_fence_action_create(struct drm_file *file_priv,
 	}
 
 	event->event.base.type = DRM_VMW_EVENT_FENCE_SIGNALED;
-	event->event.base.length = sizeof(*event);
+	event->event.base.length = sizeof(event->event);
 	event->event.user_data = user_data;
 
 	ret = drm_event_reserve_init(dev, file_priv, &event->base, &event->event.base);
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 218e3718fd68..96737ddc8120 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -367,11 +367,6 @@ static int host1x_device_uevent(struct device *dev,
 	return 0;
 }
 
-static int host1x_dma_configure(struct device *dev)
-{
-	return of_dma_configure(dev, dev->of_node, true);
-}
-
 static const struct dev_pm_ops host1x_device_pm_ops = {
 	.suspend = pm_generic_suspend,
 	.resume = pm_generic_resume,
@@ -385,7 +380,6 @@ struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
 	.uevent = host1x_device_uevent,
-	.dma_configure = host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
 };
 
@@ -474,8 +468,6 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
-	of_dma_configure(&device->dev, host1x->dev->of_node, true);
-
 	device->dev.dma_parms = &device->dma_parms;
 	dma_set_max_seg_size(&device->dev, UINT_MAX);
 
diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index fa6aa4fc8b52..486fb6a8c356 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #define USB_VENDOR_ID_CORSAIR			0x1b1c
@@ -77,8 +78,11 @@
 struct ccp_device {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
+	/* For reinitializing the completion below */
+	spinlock_t wait_input_report_lock;
 	struct completion wait_input_report;
 	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
+	u8 *cmd_buffer;
 	u8 *buffer;
 	int target[6];
 	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
@@ -111,15 +115,23 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
 	unsigned long t;
 	int ret;
 
-	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
-	ccp->buffer[0] = command;
-	ccp->buffer[1] = byte1;
-	ccp->buffer[2] = byte2;
-	ccp->buffer[3] = byte3;
-
+	memset(ccp->cmd_buffer, 0x00, OUT_BUFFER_SIZE);
+	ccp->cmd_buffer[0] = command;
+	ccp->cmd_buffer[1] = byte1;
+	ccp->cmd_buffer[2] = byte2;
+	ccp->cmd_buffer[3] = byte3;
+
+	/*
+	 * Disable raw event parsing for a moment to safely reinitialize the
+	 * completion. Reinit is done because hidraw could have triggered
+	 * the raw event parsing and marked the ccp->wait_input_report
+	 * completion as done.
+	 */
+	spin_lock_bh(&ccp->wait_input_report_lock);
 	reinit_completion(&ccp->wait_input_report);
+	spin_unlock_bh(&ccp->wait_input_report_lock);
 
-	ret = hid_hw_output_report(ccp->hdev, ccp->buffer, OUT_BUFFER_SIZE);
+	ret = hid_hw_output_report(ccp->hdev, ccp->cmd_buffer, OUT_BUFFER_SIZE);
 	if (ret < 0)
 		return ret;
 
@@ -135,11 +147,12 @@ static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	struct ccp_device *ccp = hid_get_drvdata(hdev);
 
 	/* only copy buffer when requested */
-	if (completion_done(&ccp->wait_input_report))
-		return 0;
-
-	memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
-	complete(&ccp->wait_input_report);
+	spin_lock(&ccp->wait_input_report_lock);
+	if (!completion_done(&ccp->wait_input_report)) {
+		memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
+		complete_all(&ccp->wait_input_report);
+	}
+	spin_unlock(&ccp->wait_input_report_lock);
 
 	return 0;
 }
@@ -492,7 +505,11 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (!ccp)
 		return -ENOMEM;
 
-	ccp->buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
+	ccp->cmd_buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
+	if (!ccp->cmd_buffer)
+		return -ENOMEM;
+
+	ccp->buffer = devm_kmalloc(&hdev->dev, IN_BUFFER_SIZE, GFP_KERNEL);
 	if (!ccp->buffer)
 		return -ENOMEM;
 
@@ -510,7 +527,9 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ccp->hdev = hdev;
 	hid_set_drvdata(hdev, ccp);
+
 	mutex_init(&ccp->mutex);
+	spin_lock_init(&ccp->wait_input_report_lock);
 	init_completion(&ccp->wait_input_report);
 
 	hid_device_io_start(hdev);
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 3daaf2237832..d6dfa268f31b 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -80,11 +80,11 @@ struct ucd9000_debugfs_entry {
  * It has been observed that the UCD90320 randomly fails register access when
  * doing another access right on the back of a register write. To mitigate this
  * make sure that there is a minimum delay between a write access and the
- * following access. The 250us is based on experimental data. At a delay of
- * 200us the issue seems to go away. Add a bit of extra margin to allow for
+ * following access. The 500 is based on experimental data. At a delay of
+ * 350us the issue seems to go away. Add a bit of extra margin to allow for
  * system to system differences.
  */
-#define UCD90320_WAIT_DELAY_US 250
+#define UCD90320_WAIT_DELAY_US 500
 
 static inline void ucd90320_wait(const struct ucd9000_data *data)
 {
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index df600d2917c0..ffae30e5eb5b 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -27,9 +27,13 @@
 #define MXC4005_REG_ZOUT_UPPER		0x07
 #define MXC4005_REG_ZOUT_LOWER		0x08
 
+#define MXC4005_REG_INT_MASK0		0x0A
+
 #define MXC4005_REG_INT_MASK1		0x0B
 #define MXC4005_REG_INT_MASK1_BIT_DRDYE	0x01
 
+#define MXC4005_REG_INT_CLR0		0x00
+
 #define MXC4005_REG_INT_CLR1		0x01
 #define MXC4005_REG_INT_CLR1_BIT_DRDYC	0x01
 
@@ -113,7 +117,9 @@ static bool mxc4005_is_readable_reg(struct device *dev, unsigned int reg)
 static bool mxc4005_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MXC4005_REG_INT_CLR0:
 	case MXC4005_REG_INT_CLR1:
+	case MXC4005_REG_INT_MASK0:
 	case MXC4005_REG_INT_MASK1:
 	case MXC4005_REG_CONTROL:
 		return true;
@@ -330,17 +336,13 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mxc4005_data *data = iio_priv(indio_dev);
+	unsigned int val;
 	int ret;
 
 	mutex_lock(&data->mutex);
-	if (state) {
-		ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1,
-				   MXC4005_REG_INT_MASK1_BIT_DRDYE);
-	} else {
-		ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1,
-				   ~MXC4005_REG_INT_MASK1_BIT_DRDYE);
-	}
 
+	val = state ? MXC4005_REG_INT_MASK1_BIT_DRDYE : 0;
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1, val);
 	if (ret < 0) {
 		mutex_unlock(&data->mutex);
 		dev_err(data->dev, "failed to update reg_int_mask1");
@@ -382,6 +384,14 @@ static int mxc4005_chip_init(struct mxc4005_data *data)
 
 	dev_dbg(data->dev, "MXC4005 chip id %02x\n", reg);
 
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "writing INT_MASK0\n");
+
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1, 0);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "writing INT_MASK1\n");
+
 	return 0;
 }
 
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index a3b9745dd176..e8238459bdad 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1145,6 +1145,7 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	struct device *dev = &st->adis.spi->dev;
 	const struct adis16475_sync *sync;
 	u32 sync_mode;
+	u16 val;
 
 	/* default to internal clk */
 	st->clk_freq = st->info->int_clk * 1000;
@@ -1214,8 +1215,9 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	 * I'm keeping this for simplicity and avoiding extra variables
 	 * in chip_info.
 	 */
+	val = ADIS16475_SYNC_MODE(sync->sync_mode);
 	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
-				 ADIS16475_SYNC_MODE_MASK, sync->sync_mode);
+				 ADIS16475_SYNC_MODE_MASK, val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index a0c5f3bdc324..8665e506404f 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -441,6 +441,7 @@ static int remove_device_files(struct super_block *sb,
 		return PTR_ERR(dir);
 	}
 	simple_recursive_removal(dir, NULL);
+	dput(dir);
 	return 0;
 }
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2ae46fa6b3de..04ac40d11fdf 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1101,6 +1101,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index fe1c3123a7e7..02668fd3404f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -576,6 +576,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-m4u", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
 
 static const struct component_master_ops mtk_iommu_com_ops = {
 	.bind		= mtk_iommu_bind,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index c937ad7f6b73..45ef1ddd2bd0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2526,6 +2526,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
  fail:
 	pr_warn("md: failed to register dev-%s for %s\n",
 		b, mdname(mddev));
+	mddev_destroy_serial_pool(mddev, rdev, false);
 	return err;
 }
 
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 305ffad131a2..02bea4436943 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -585,6 +585,31 @@ static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
 	}
 }
 
+static void at24_probe_temp_sensor(struct i2c_client *client)
+{
+	struct at24_data *at24 = i2c_get_clientdata(client);
+	struct i2c_board_info info = { .type = "jc42" };
+	int ret;
+	u8 val;
+
+	/*
+	 * Byte 2 has value 11 for DDR3, earlier versions don't
+	 * support the thermal sensor present flag
+	 */
+	ret = at24_read(at24, 2, &val, 1);
+	if (ret || val != 11)
+		return;
+
+	/* Byte 32, bit 7 is set if temp sensor is present */
+	ret = at24_read(at24, 32, &val, 1);
+	if (ret || !(val & BIT(7)))
+		return;
+
+	info.addr = 0x18 | (client->addr & 7);
+
+	i2c_new_client_device(client->adapter, &info);
+}
+
 static int at24_probe(struct i2c_client *client)
 {
 	struct regmap_config regmap_config = { };
@@ -757,14 +782,6 @@ static int at24_probe(struct i2c_client *client)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
-	if (IS_ERR(at24->nvmem)) {
-		pm_runtime_disable(dev);
-		if (!pm_runtime_status_suspended(dev))
-			regulator_disable(at24->vcc_reg);
-		return PTR_ERR(at24->nvmem);
-	}
-
 	/*
 	 * Perform a one-byte test read to verify that the
 	 * chip is functional.
@@ -777,6 +794,19 @@ static int at24_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
+	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
+	if (IS_ERR(at24->nvmem)) {
+		pm_runtime_disable(dev);
+		if (!pm_runtime_status_suspended(dev))
+			regulator_disable(at24->vcc_reg);
+		return dev_err_probe(dev, PTR_ERR(at24->nvmem),
+				     "failed to register nvmem\n");
+	}
+
+	/* If this a SPD EEPROM, probe for DDR3 thermal sensor */
+	if (cdata == &at24_data_spd)
+		at24_probe_temp_sensor(client);
+
 	pm_runtime_idle(dev);
 
 	if (writable)
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 00867bcc2ef7..bbabfe49f956 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -115,6 +115,8 @@
 #define MEI_DEV_ID_ARL_S      0x7F68  /* Arrow Lake Point S */
 #define MEI_DEV_ID_ARL_H      0x7770  /* Arrow Lake Point H */
 
+#define MEI_DEV_ID_LNL_M      0xA870  /* Lunar Lake Point M */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 2809338a5c3a..188d847662ff 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -121,6 +121,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_H, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 30fba1ea933e..3fc120802883 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5116,7 +5116,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6141,
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6141",
-		.num_databases = 4096,
+		.num_databases = 256,
 		.num_macs = 2048,
 		.num_ports = 6,
 		.num_internal_phys = 5,
@@ -5559,7 +5559,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6341,
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6341",
-		.num_databases = 4096,
+		.num_databases = 256,
 		.num_macs = 2048,
 		.num_internal_phys = 5,
 		.num_ports = 6,
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index a2b736a9d20c..ef8646e91f5d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET (Gigabit Ethernet) controller driver
  *
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)				"bcmgenet: " fmt
@@ -3256,7 +3256,7 @@ static void bcmgenet_get_hw_addr(struct bcmgenet_priv *priv,
 }
 
 /* Returns a reusable dma control register value */
-static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv)
+static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv, bool flush_rx)
 {
 	unsigned int i;
 	u32 reg;
@@ -3281,6 +3281,14 @@ static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv)
 	udelay(10);
 	bcmgenet_umac_writel(priv, 0, UMAC_TX_FLUSH);
 
+	if (flush_rx) {
+		reg = bcmgenet_rbuf_ctrl_get(priv);
+		bcmgenet_rbuf_ctrl_set(priv, reg | BIT(0));
+		udelay(10);
+		bcmgenet_rbuf_ctrl_set(priv, reg);
+		udelay(10);
+	}
+
 	return dma_ctrl;
 }
 
@@ -3302,7 +3310,9 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	/* Start the network engine */
+	netif_addr_lock_bh(dev);
 	bcmgenet_set_rx_mode(dev);
+	netif_addr_unlock_bh(dev);
 	bcmgenet_enable_rx_napi(priv);
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);
@@ -3344,8 +3354,8 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
 
-	/* Disable RX/TX DMA and flush TX queues */
-	dma_ctrl = bcmgenet_dma_disable(priv);
+	/* Disable RX/TX DMA and flush TX and RX queues */
+	dma_ctrl = bcmgenet_dma_disable(priv, true);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv);
@@ -4201,7 +4211,7 @@ static int bcmgenet_resume(struct device *d)
 			bcmgenet_hfb_create_rxnfc_filter(priv, rule);
 
 	/* Disable RX/TX DMA and flush TX queues */
-	dma_ctrl = bcmgenet_dma_disable(priv);
+	dma_ctrl = bcmgenet_dma_disable(priv, false);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv);
diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 04ad0f2b9677..777f0d7e4819 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -312,7 +312,7 @@ bnad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	void *kern_buf;
 
 	/* Copy the user space buf */
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -372,7 +372,7 @@ bnad_debugfs_write_regwr(struct file *file, const char __user *buf,
 	void *kern_buf;
 
 	/* Copy the user space buf */
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index fa5b596ff23a..a074e9d44277 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2682,12 +2682,12 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
 	lb->loopback = 1;
 
 	q = &adap->sge.ethtxq[pi->first_qset];
-	__netif_tx_lock(q->txq, smp_processor_id());
+	__netif_tx_lock_bh(q->txq);
 
 	reclaim_completed_tx(adap, &q->q, -1, true);
 	credits = txq_avail(&q->q) - ndesc;
 	if (unlikely(credits < 0)) {
-		__netif_tx_unlock(q->txq);
+		__netif_tx_unlock_bh(q->txq);
 		return -ENOMEM;
 	}
 
@@ -2722,7 +2722,7 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
 	init_completion(&lb->completion);
 	txq_advance(&q->q, ndesc);
 	cxgb4_ring_tx_db(adap, &q->q, ndesc);
-	__netif_tx_unlock(q->txq);
+	__netif_tx_unlock_bh(q->txq);
 
 	/* wait for the pkt to return */
 	ret = wait_for_completion_timeout(&lb->completion, 10 * HZ);
diff --git a/drivers/net/ethernet/hisilicon/hns3/Makefile b/drivers/net/ethernet/hisilicon/hns3/Makefile
index 7aa2fac76c5e..cb3aaf5252d0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/Makefile
@@ -4,9 +4,9 @@
 #
 
 ccflags-y += -I$(srctree)/$(src)
-
-obj-$(CONFIG_HNS3) += hns3pf/
-obj-$(CONFIG_HNS3) += hns3vf/
+ccflags-y += -I$(srctree)/drivers/net/ethernet/hisilicon/hns3/hns3pf
+ccflags-y += -I$(srctree)/drivers/net/ethernet/hisilicon/hns3/hns3vf
+ccflags-y += -I$(srctree)/drivers/net/ethernet/hisilicon/hns3/hns3_common
 
 obj-$(CONFIG_HNS3) += hnae3.o
 
@@ -14,3 +14,15 @@ obj-$(CONFIG_HNS3_ENET) += hns3.o
 hns3-objs = hns3_enet.o hns3_ethtool.o hns3_debugfs.o
 
 hns3-$(CONFIG_HNS3_DCB) += hns3_dcbnl.o
+
+obj-$(CONFIG_HNS3_HCLGEVF) += hclgevf.o
+
+hclgevf-objs = hns3vf/hclgevf_main.o hns3vf/hclgevf_cmd.o hns3vf/hclgevf_mbx.o  hns3vf/hclgevf_devlink.o \
+		hns3_common/hclge_comm_cmd.o
+
+obj-$(CONFIG_HNS3_HCLGE) += hclge.o
+hclge-objs = hns3pf/hclge_main.o hns3pf/hclge_cmd.o hns3pf/hclge_mdio.o hns3pf/hclge_tm.o \
+		hns3pf/hclge_mbx.o hns3pf/hclge_err.o  hns3pf/hclge_debugfs.o hns3pf/hclge_ptp.o hns3pf/hclge_devlink.o \
+		hns3_common/hclge_comm_cmd.o
+
+hclge-$(CONFIG_HNS3_DCB) += hns3pf/hclge_dcb.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index 277d6d657c42..debbaa1822aa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -46,6 +46,7 @@ enum HCLGE_MBX_OPCODE {
 	HCLGE_MBX_PUSH_PROMISC_INFO,	/* (PF -> VF) push vf promisc info */
 	HCLGE_MBX_VF_UNINIT,            /* (VF -> PF) vf is unintializing */
 	HCLGE_MBX_HANDLE_VF_TBL,	/* (VF -> PF) store/clear hw table */
+	HCLGE_MBX_GET_RING_VECTOR_MAP,	/* (VF -> PF) get ring-to-vector map */
 
 	HCLGE_MBX_GET_VF_FLR_STATUS = 200, /* (M7 -> PF) get vf flr status */
 	HCLGE_MBX_PUSH_LINK_STATUS,	/* (M7 -> PF) get port link status */
@@ -80,6 +81,9 @@ enum hclge_mbx_tbl_cfg_subcode {
 #define HCLGE_MBX_MAX_RESP_DATA_SIZE	8U
 #define HCLGE_MBX_MAX_RING_CHAIN_PARAM_NUM	4
 
+#define HCLGE_RESET_SCHED_TIMEOUT	(3 * HZ)
+#define HCLGE_MBX_SCHED_TIMEOUT	(HZ / 2)
+
 struct hclge_ring_chain_param {
 	u8 ring_type;
 	u8 tqp_index;
@@ -208,6 +212,17 @@ struct hclgevf_mbx_arq_ring {
 	__le16 msg_q[HCLGE_MBX_MAX_ARQ_MSG_NUM][HCLGE_MBX_MAX_ARQ_MSG_SIZE];
 };
 
+struct hclge_dev;
+
+#define HCLGE_MBX_OPCODE_MAX 256
+struct hclge_mbx_ops_param {
+	struct hclge_vport *vport;
+	struct hclge_mbx_vf_to_pf_cmd *req;
+	struct hclge_respond_to_vf_msg *resp_msg;
+};
+
+typedef int (*hclge_mbx_ops_fn)(struct hclge_mbx_ops_param *param);
+
 #define hclge_mbx_ring_ptr_move_crq(crq) \
 	(crq->next_to_use = (crq->next_to_use + 1) % crq->desc_num)
 #define hclge_mbx_tail_ptr_move_arq(arq) \
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index b51afb83d023..f362a2fac3c2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -341,6 +341,7 @@ struct hnae3_dev_specs {
 	u8 max_non_tso_bd_num; /* max BD number of one non-TSO packet */
 	u16 max_frm_size;
 	u16 max_qset_num;
+	u16 umv_size;
 };
 
 struct hnae3_client_ops {
@@ -828,7 +829,7 @@ struct hnae3_handle {
 		struct hnae3_roce_private_info rinfo;
 	};
 
-	u32 numa_node_mask;	/* for multi-chip support */
+	nodemask_t numa_node_mask; /* for multi-chip support */
 
 	enum hnae3_port_base_vlan_state port_base_vlan_state;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
new file mode 100644
index 000000000000..89e999248b9a
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2021-2021 Hisilicon Limited.
+
+#include "hnae3.h"
+#include "hclge_comm_cmd.h"
+
+static bool hclge_is_elem_in_array(const u16 *spec_opcode, u32 size, u16 opcode)
+{
+	u32 i;
+
+	for (i = 0; i < size; i++) {
+		if (spec_opcode[i] == opcode)
+			return true;
+	}
+
+	return false;
+}
+
+static const u16 pf_spec_opcode[] = { HCLGE_COMM_OPC_STATS_64_BIT,
+				      HCLGE_COMM_OPC_STATS_32_BIT,
+				      HCLGE_COMM_OPC_STATS_MAC,
+				      HCLGE_COMM_OPC_STATS_MAC_ALL,
+				      HCLGE_COMM_OPC_QUERY_32_BIT_REG,
+				      HCLGE_COMM_OPC_QUERY_64_BIT_REG,
+				      HCLGE_COMM_QUERY_CLEAR_MPF_RAS_INT,
+				      HCLGE_COMM_QUERY_CLEAR_PF_RAS_INT,
+				      HCLGE_COMM_QUERY_CLEAR_ALL_MPF_MSIX_INT,
+				      HCLGE_COMM_QUERY_CLEAR_ALL_PF_MSIX_INT,
+				      HCLGE_COMM_QUERY_ALL_ERR_INFO };
+
+static const u16 vf_spec_opcode[] = { HCLGE_COMM_OPC_STATS_64_BIT,
+				      HCLGE_COMM_OPC_STATS_32_BIT,
+				      HCLGE_COMM_OPC_STATS_MAC };
+
+static bool hclge_comm_is_special_opcode(u16 opcode, bool is_pf)
+{
+	/* these commands have several descriptors,
+	 * and use the first one to save opcode and return value
+	 */
+	const u16 *spec_opcode = is_pf ? pf_spec_opcode : vf_spec_opcode;
+	u32 size = is_pf ? ARRAY_SIZE(pf_spec_opcode) :
+				ARRAY_SIZE(vf_spec_opcode);
+
+	return hclge_is_elem_in_array(spec_opcode, size, opcode);
+}
+
+static int hclge_comm_ring_space(struct hclge_comm_cmq_ring *ring)
+{
+	int ntc = ring->next_to_clean;
+	int ntu = ring->next_to_use;
+	int used = (ntu - ntc + ring->desc_num) % ring->desc_num;
+
+	return ring->desc_num - used - 1;
+}
+
+static void hclge_comm_cmd_copy_desc(struct hclge_comm_hw *hw,
+				     struct hclge_desc *desc, int num)
+{
+	struct hclge_desc *desc_to_use;
+	int handle = 0;
+
+	while (handle < num) {
+		desc_to_use = &hw->cmq.csq.desc[hw->cmq.csq.next_to_use];
+		*desc_to_use = desc[handle];
+		(hw->cmq.csq.next_to_use)++;
+		if (hw->cmq.csq.next_to_use >= hw->cmq.csq.desc_num)
+			hw->cmq.csq.next_to_use = 0;
+		handle++;
+	}
+}
+
+static int hclge_comm_is_valid_csq_clean_head(struct hclge_comm_cmq_ring *ring,
+					      int head)
+{
+	int ntc = ring->next_to_clean;
+	int ntu = ring->next_to_use;
+
+	if (ntu > ntc)
+		return head >= ntc && head <= ntu;
+
+	return head >= ntc || head <= ntu;
+}
+
+static int hclge_comm_cmd_csq_clean(struct hclge_comm_hw *hw)
+{
+	struct hclge_comm_cmq_ring *csq = &hw->cmq.csq;
+	int clean;
+	u32 head;
+
+	head = hclge_comm_read_dev(hw, HCLGE_COMM_NIC_CSQ_HEAD_REG);
+	rmb(); /* Make sure head is ready before touch any data */
+
+	if (!hclge_comm_is_valid_csq_clean_head(csq, head)) {
+		dev_warn(&hw->cmq.csq.pdev->dev, "wrong cmd head (%u, %d-%d)\n",
+			 head, csq->next_to_use, csq->next_to_clean);
+		dev_warn(&hw->cmq.csq.pdev->dev,
+			 "Disabling any further commands to IMP firmware\n");
+		set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hw->comm_state);
+		dev_warn(&hw->cmq.csq.pdev->dev,
+			 "IMP firmware watchdog reset soon expected!\n");
+		return -EIO;
+	}
+
+	clean = (head - csq->next_to_clean + csq->desc_num) % csq->desc_num;
+	csq->next_to_clean = head;
+	return clean;
+}
+
+static int hclge_comm_cmd_csq_done(struct hclge_comm_hw *hw)
+{
+	u32 head = hclge_comm_read_dev(hw, HCLGE_COMM_NIC_CSQ_HEAD_REG);
+	return head == hw->cmq.csq.next_to_use;
+}
+
+static void hclge_comm_wait_for_resp(struct hclge_comm_hw *hw,
+				     bool *is_completed)
+{
+	u32 timeout = 0;
+
+	do {
+		if (hclge_comm_cmd_csq_done(hw)) {
+			*is_completed = true;
+			break;
+		}
+		udelay(1);
+		timeout++;
+	} while (timeout < hw->cmq.tx_timeout);
+}
+
+static int hclge_comm_cmd_convert_err_code(u16 desc_ret)
+{
+	struct hclge_comm_errcode hclge_comm_cmd_errcode[] = {
+		{ HCLGE_COMM_CMD_EXEC_SUCCESS, 0 },
+		{ HCLGE_COMM_CMD_NO_AUTH, -EPERM },
+		{ HCLGE_COMM_CMD_NOT_SUPPORTED, -EOPNOTSUPP },
+		{ HCLGE_COMM_CMD_QUEUE_FULL, -EXFULL },
+		{ HCLGE_COMM_CMD_NEXT_ERR, -ENOSR },
+		{ HCLGE_COMM_CMD_UNEXE_ERR, -ENOTBLK },
+		{ HCLGE_COMM_CMD_PARA_ERR, -EINVAL },
+		{ HCLGE_COMM_CMD_RESULT_ERR, -ERANGE },
+		{ HCLGE_COMM_CMD_TIMEOUT, -ETIME },
+		{ HCLGE_COMM_CMD_HILINK_ERR, -ENOLINK },
+		{ HCLGE_COMM_CMD_QUEUE_ILLEGAL, -ENXIO },
+		{ HCLGE_COMM_CMD_INVALID, -EBADR },
+	};
+	u32 errcode_count = ARRAY_SIZE(hclge_comm_cmd_errcode);
+	u32 i;
+
+	for (i = 0; i < errcode_count; i++)
+		if (hclge_comm_cmd_errcode[i].imp_errcode == desc_ret)
+			return hclge_comm_cmd_errcode[i].common_errno;
+
+	return -EIO;
+}
+
+static int hclge_comm_cmd_check_retval(struct hclge_comm_hw *hw,
+				       struct hclge_desc *desc, int num,
+				       int ntc, bool is_pf)
+{
+	u16 opcode, desc_ret;
+	int handle;
+
+	opcode = le16_to_cpu(desc[0].opcode);
+	for (handle = 0; handle < num; handle++) {
+		desc[handle] = hw->cmq.csq.desc[ntc];
+		ntc++;
+		if (ntc >= hw->cmq.csq.desc_num)
+			ntc = 0;
+	}
+	if (likely(!hclge_comm_is_special_opcode(opcode, is_pf)))
+		desc_ret = le16_to_cpu(desc[num - 1].retval);
+	else
+		desc_ret = le16_to_cpu(desc[0].retval);
+
+	hw->cmq.last_status = desc_ret;
+
+	return hclge_comm_cmd_convert_err_code(desc_ret);
+}
+
+static int hclge_comm_cmd_check_result(struct hclge_comm_hw *hw,
+				       struct hclge_desc *desc,
+				       int num, int ntc, bool is_pf)
+{
+	bool is_completed = false;
+	int handle, ret;
+
+	/* If the command is sync, wait for the firmware to write back,
+	 * if multi descriptors to be sent, use the first one to check
+	 */
+	if (HCLGE_COMM_SEND_SYNC(le16_to_cpu(desc->flag)))
+		hclge_comm_wait_for_resp(hw, &is_completed);
+
+	if (!is_completed)
+		ret = -EBADE;
+	else
+		ret = hclge_comm_cmd_check_retval(hw, desc, num, ntc, is_pf);
+
+	/* Clean the command send queue */
+	handle = hclge_comm_cmd_csq_clean(hw);
+	if (handle < 0)
+		ret = handle;
+	else if (handle != num)
+		dev_warn(&hw->cmq.csq.pdev->dev,
+			 "cleaned %d, need to clean %d\n", handle, num);
+	return ret;
+}
+
+/**
+ * hclge_comm_cmd_send - send command to command queue
+ * @hw: pointer to the hw struct
+ * @desc: prefilled descriptor for describing the command
+ * @num : the number of descriptors to be sent
+ * @is_pf: bool to judge pf/vf module
+ *
+ * This is the main send command for command queue, it
+ * sends the queue, cleans the queue, etc
+ **/
+int hclge_comm_cmd_send(struct hclge_comm_hw *hw, struct hclge_desc *desc,
+			int num, bool is_pf)
+{
+	struct hclge_comm_cmq_ring *csq = &hw->cmq.csq;
+	int ret;
+	int ntc;
+
+	spin_lock_bh(&hw->cmq.csq.lock);
+
+	if (test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hw->comm_state)) {
+		spin_unlock_bh(&hw->cmq.csq.lock);
+		return -EBUSY;
+	}
+
+	if (num > hclge_comm_ring_space(&hw->cmq.csq)) {
+		/* If CMDQ ring is full, SW HEAD and HW HEAD may be different,
+		 * need update the SW HEAD pointer csq->next_to_clean
+		 */
+		csq->next_to_clean =
+			hclge_comm_read_dev(hw, HCLGE_COMM_NIC_CSQ_HEAD_REG);
+		spin_unlock_bh(&hw->cmq.csq.lock);
+		return -EBUSY;
+	}
+
+	/**
+	 * Record the location of desc in the ring for this time
+	 * which will be use for hardware to write back
+	 */
+	ntc = hw->cmq.csq.next_to_use;
+
+	hclge_comm_cmd_copy_desc(hw, desc, num);
+
+	/* Write to hardware */
+	hclge_comm_write_dev(hw, HCLGE_COMM_NIC_CSQ_TAIL_REG,
+			     hw->cmq.csq.next_to_use);
+
+	ret = hclge_comm_cmd_check_result(hw, desc, num, ntc, is_pf);
+
+	spin_unlock_bh(&hw->cmq.csq.lock);
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
new file mode 100644
index 000000000000..5164c666cae7
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+// Copyright (c) 2021-2021 Hisilicon Limited.
+
+#ifndef __HCLGE_COMM_CMD_H
+#define __HCLGE_COMM_CMD_H
+#include <linux/types.h>
+
+#include "hnae3.h"
+
+#define HCLGE_COMM_CMD_FLAG_NO_INTR		BIT(4)
+
+#define HCLGE_COMM_SEND_SYNC(flag) \
+	((flag) & HCLGE_COMM_CMD_FLAG_NO_INTR)
+
+#define HCLGE_COMM_NIC_CSQ_TAIL_REG		0x27010
+#define HCLGE_COMM_NIC_CSQ_HEAD_REG		0x27014
+
+enum hclge_comm_cmd_return_status {
+	HCLGE_COMM_CMD_EXEC_SUCCESS	= 0,
+	HCLGE_COMM_CMD_NO_AUTH		= 1,
+	HCLGE_COMM_CMD_NOT_SUPPORTED	= 2,
+	HCLGE_COMM_CMD_QUEUE_FULL	= 3,
+	HCLGE_COMM_CMD_NEXT_ERR		= 4,
+	HCLGE_COMM_CMD_UNEXE_ERR	= 5,
+	HCLGE_COMM_CMD_PARA_ERR		= 6,
+	HCLGE_COMM_CMD_RESULT_ERR	= 7,
+	HCLGE_COMM_CMD_TIMEOUT		= 8,
+	HCLGE_COMM_CMD_HILINK_ERR	= 9,
+	HCLGE_COMM_CMD_QUEUE_ILLEGAL	= 10,
+	HCLGE_COMM_CMD_INVALID		= 11,
+};
+
+enum hclge_comm_special_cmd {
+	HCLGE_COMM_OPC_STATS_64_BIT		= 0x0030,
+	HCLGE_COMM_OPC_STATS_32_BIT		= 0x0031,
+	HCLGE_COMM_OPC_STATS_MAC		= 0x0032,
+	HCLGE_COMM_OPC_STATS_MAC_ALL		= 0x0034,
+	HCLGE_COMM_OPC_QUERY_32_BIT_REG		= 0x0041,
+	HCLGE_COMM_OPC_QUERY_64_BIT_REG		= 0x0042,
+	HCLGE_COMM_QUERY_CLEAR_MPF_RAS_INT	= 0x1511,
+	HCLGE_COMM_QUERY_CLEAR_PF_RAS_INT	= 0x1512,
+	HCLGE_COMM_QUERY_CLEAR_ALL_MPF_MSIX_INT	= 0x1514,
+	HCLGE_COMM_QUERY_CLEAR_ALL_PF_MSIX_INT	= 0x1515,
+	HCLGE_COMM_QUERY_ALL_ERR_INFO		= 0x1517,
+};
+
+enum hclge_comm_cmd_state {
+	HCLGE_COMM_STATE_CMD_DISABLE,
+};
+
+struct hclge_comm_errcode {
+	u32 imp_errcode;
+	int common_errno;
+};
+
+#define HCLGE_DESC_DATA_LEN		6
+struct hclge_desc {
+	__le16 opcode;
+	__le16 flag;
+	__le16 retval;
+	__le16 rsv;
+	__le32 data[HCLGE_DESC_DATA_LEN];
+};
+
+struct hclge_comm_cmq_ring {
+	dma_addr_t desc_dma_addr;
+	struct hclge_desc *desc;
+	struct pci_dev *pdev;
+	u32 head;
+	u32 tail;
+
+	u16 buf_size;
+	u16 desc_num;
+	int next_to_use;
+	int next_to_clean;
+	u8 ring_type; /* cmq ring type */
+	spinlock_t lock; /* Command queue lock */
+};
+
+enum hclge_comm_cmd_status {
+	HCLGE_COMM_STATUS_SUCCESS	= 0,
+	HCLGE_COMM_ERR_CSQ_FULL		= -1,
+	HCLGE_COMM_ERR_CSQ_TIMEOUT	= -2,
+	HCLGE_COMM_ERR_CSQ_ERROR	= -3,
+};
+
+struct hclge_comm_cmq {
+	struct hclge_comm_cmq_ring csq;
+	struct hclge_comm_cmq_ring crq;
+	u16 tx_timeout;
+	enum hclge_comm_cmd_status last_status;
+};
+
+struct hclge_comm_hw {
+	void __iomem *io_base;
+	void __iomem *mem_base;
+	struct hclge_comm_cmq cmq;
+	unsigned long comm_state;
+};
+
+static inline void hclge_comm_write_reg(void __iomem *base, u32 reg, u32 value)
+{
+	writel(value, base + reg);
+}
+
+static inline u32 hclge_comm_read_reg(u8 __iomem *base, u32 reg)
+{
+	u8 __iomem *reg_addr = READ_ONCE(base);
+
+	return readl(reg_addr + reg);
+}
+
+#define hclge_comm_write_dev(a, reg, value) \
+	hclge_comm_write_reg((a)->io_base, reg, value)
+#define hclge_comm_read_dev(a, reg) \
+	hclge_comm_read_reg((a)->io_base, reg)
+
+int hclge_comm_cmd_send(struct hclge_comm_hw *hw, struct hclge_desc *desc,
+			int num, bool is_pf);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 45f245b1d331..bd801e35d51e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -924,6 +924,8 @@ hns3_dbg_dev_specs(struct hnae3_handle *h, char *buf, int len, int *pos)
 			  dev_specs->max_tm_rate);
 	*pos += scnprintf(buf + *pos, len - *pos, "MAX QSET number: %u\n",
 			  dev_specs->max_qset_num);
+	*pos += scnprintf(buf + *pos, len - *pos, "umv size: %u\n",
+			  dev_specs->umv_size);
 }
 
 static int hns3_dbg_dev_info(struct hnae3_handle *h, char *buf, int len)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile b/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
deleted file mode 100644
index d1bf5c4c0abb..000000000000
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
+++ /dev/null
@@ -1,12 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Makefile for the HISILICON network device drivers.
-#
-
-ccflags-y := -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
-ccflags-y += -I $(srctree)/$(src)
-
-obj-$(CONFIG_HNS3_HCLGE) += hclge.o
-hclge-objs = hclge_main.o hclge_cmd.o hclge_mdio.o hclge_tm.o hclge_mbx.o hclge_err.o  hclge_debugfs.o hclge_ptp.o hclge_devlink.o
-
-hclge-$(CONFIG_HNS3_DCB) += hclge_dcb.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 9c2eeaa82294..59dd2283d25b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -11,46 +11,24 @@
 #include "hnae3.h"
 #include "hclge_main.h"
 
-#define cmq_ring_to_dev(ring)   (&(ring)->dev->pdev->dev)
-
-static int hclge_ring_space(struct hclge_cmq_ring *ring)
-{
-	int ntu = ring->next_to_use;
-	int ntc = ring->next_to_clean;
-	int used = (ntu - ntc + ring->desc_num) % ring->desc_num;
-
-	return ring->desc_num - used - 1;
-}
-
-static int is_valid_csq_clean_head(struct hclge_cmq_ring *ring, int head)
-{
-	int ntu = ring->next_to_use;
-	int ntc = ring->next_to_clean;
-
-	if (ntu > ntc)
-		return head >= ntc && head <= ntu;
-
-	return head >= ntc || head <= ntu;
-}
-
-static int hclge_alloc_cmd_desc(struct hclge_cmq_ring *ring)
+static int hclge_alloc_cmd_desc(struct hclge_comm_cmq_ring *ring)
 {
 	int size  = ring->desc_num * sizeof(struct hclge_desc);
 
-	ring->desc = dma_alloc_coherent(cmq_ring_to_dev(ring), size,
-					&ring->desc_dma_addr, GFP_KERNEL);
+	ring->desc = dma_alloc_coherent(&ring->pdev->dev,
+					size, &ring->desc_dma_addr, GFP_KERNEL);
 	if (!ring->desc)
 		return -ENOMEM;
 
 	return 0;
 }
 
-static void hclge_free_cmd_desc(struct hclge_cmq_ring *ring)
+static void hclge_free_cmd_desc(struct hclge_comm_cmq_ring *ring)
 {
 	int size  = ring->desc_num * sizeof(struct hclge_desc);
 
 	if (ring->desc) {
-		dma_free_coherent(cmq_ring_to_dev(ring), size,
+		dma_free_coherent(&ring->pdev->dev, size,
 				  ring->desc, ring->desc_dma_addr);
 		ring->desc = NULL;
 	}
@@ -59,12 +37,13 @@ static void hclge_free_cmd_desc(struct hclge_cmq_ring *ring)
 static int hclge_alloc_cmd_queue(struct hclge_dev *hdev, int ring_type)
 {
 	struct hclge_hw *hw = &hdev->hw;
-	struct hclge_cmq_ring *ring =
-		(ring_type == HCLGE_TYPE_CSQ) ? &hw->cmq.csq : &hw->cmq.crq;
+	struct hclge_comm_cmq_ring *ring =
+		(ring_type == HCLGE_TYPE_CSQ) ? &hw->hw.cmq.csq :
+						&hw->hw.cmq.crq;
 	int ret;
 
 	ring->ring_type = ring_type;
-	ring->dev = hdev;
+	ring->pdev = hdev->pdev;
 
 	ret = hclge_alloc_cmd_desc(ring);
 	if (ret) {
@@ -96,11 +75,10 @@ void hclge_cmd_setup_basic_desc(struct hclge_desc *desc,
 		desc->flag |= cpu_to_le16(HCLGE_CMD_FLAG_WR);
 }
 
-static void hclge_cmd_config_regs(struct hclge_cmq_ring *ring)
+static void hclge_cmd_config_regs(struct hclge_hw *hw,
+				  struct hclge_comm_cmq_ring *ring)
 {
 	dma_addr_t dma = ring->desc_dma_addr;
-	struct hclge_dev *hdev = ring->dev;
-	struct hclge_hw *hw = &hdev->hw;
 	u32 reg_val;
 
 	if (ring->ring_type == HCLGE_TYPE_CSQ) {
@@ -128,176 +106,8 @@ static void hclge_cmd_config_regs(struct hclge_cmq_ring *ring)
 
 static void hclge_cmd_init_regs(struct hclge_hw *hw)
 {
-	hclge_cmd_config_regs(&hw->cmq.csq);
-	hclge_cmd_config_regs(&hw->cmq.crq);
-}
-
-static int hclge_cmd_csq_clean(struct hclge_hw *hw)
-{
-	struct hclge_dev *hdev = container_of(hw, struct hclge_dev, hw);
-	struct hclge_cmq_ring *csq = &hw->cmq.csq;
-	u32 head;
-	int clean;
-
-	head = hclge_read_dev(hw, HCLGE_NIC_CSQ_HEAD_REG);
-	rmb(); /* Make sure head is ready before touch any data */
-
-	if (!is_valid_csq_clean_head(csq, head)) {
-		dev_warn(&hdev->pdev->dev, "wrong cmd head (%u, %d-%d)\n", head,
-			 csq->next_to_use, csq->next_to_clean);
-		dev_warn(&hdev->pdev->dev,
-			 "Disabling any further commands to IMP firmware\n");
-		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
-		dev_warn(&hdev->pdev->dev,
-			 "IMP firmware watchdog reset soon expected!\n");
-		return -EIO;
-	}
-
-	clean = (head - csq->next_to_clean + csq->desc_num) % csq->desc_num;
-	csq->next_to_clean = head;
-	return clean;
-}
-
-static int hclge_cmd_csq_done(struct hclge_hw *hw)
-{
-	u32 head = hclge_read_dev(hw, HCLGE_NIC_CSQ_HEAD_REG);
-	return head == hw->cmq.csq.next_to_use;
-}
-
-static bool hclge_is_special_opcode(u16 opcode)
-{
-	/* these commands have several descriptors,
-	 * and use the first one to save opcode and return value
-	 */
-	static const u16 spec_opcode[] = {
-		HCLGE_OPC_STATS_64_BIT,
-		HCLGE_OPC_STATS_32_BIT,
-		HCLGE_OPC_STATS_MAC,
-		HCLGE_OPC_STATS_MAC_ALL,
-		HCLGE_OPC_QUERY_32_BIT_REG,
-		HCLGE_OPC_QUERY_64_BIT_REG,
-		HCLGE_QUERY_CLEAR_MPF_RAS_INT,
-		HCLGE_QUERY_CLEAR_PF_RAS_INT,
-		HCLGE_QUERY_CLEAR_ALL_MPF_MSIX_INT,
-		HCLGE_QUERY_CLEAR_ALL_PF_MSIX_INT,
-		HCLGE_QUERY_ALL_ERR_INFO
-	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(spec_opcode); i++) {
-		if (spec_opcode[i] == opcode)
-			return true;
-	}
-
-	return false;
-}
-
-struct errcode {
-	u32 imp_errcode;
-	int common_errno;
-};
-
-static void hclge_cmd_copy_desc(struct hclge_hw *hw, struct hclge_desc *desc,
-				int num)
-{
-	struct hclge_desc *desc_to_use;
-	int handle = 0;
-
-	while (handle < num) {
-		desc_to_use = &hw->cmq.csq.desc[hw->cmq.csq.next_to_use];
-		*desc_to_use = desc[handle];
-		(hw->cmq.csq.next_to_use)++;
-		if (hw->cmq.csq.next_to_use >= hw->cmq.csq.desc_num)
-			hw->cmq.csq.next_to_use = 0;
-		handle++;
-	}
-}
-
-static int hclge_cmd_convert_err_code(u16 desc_ret)
-{
-	struct errcode hclge_cmd_errcode[] = {
-		{HCLGE_CMD_EXEC_SUCCESS, 0},
-		{HCLGE_CMD_NO_AUTH, -EPERM},
-		{HCLGE_CMD_NOT_SUPPORTED, -EOPNOTSUPP},
-		{HCLGE_CMD_QUEUE_FULL, -EXFULL},
-		{HCLGE_CMD_NEXT_ERR, -ENOSR},
-		{HCLGE_CMD_UNEXE_ERR, -ENOTBLK},
-		{HCLGE_CMD_PARA_ERR, -EINVAL},
-		{HCLGE_CMD_RESULT_ERR, -ERANGE},
-		{HCLGE_CMD_TIMEOUT, -ETIME},
-		{HCLGE_CMD_HILINK_ERR, -ENOLINK},
-		{HCLGE_CMD_QUEUE_ILLEGAL, -ENXIO},
-		{HCLGE_CMD_INVALID, -EBADR},
-	};
-	u32 errcode_count = ARRAY_SIZE(hclge_cmd_errcode);
-	u32 i;
-
-	for (i = 0; i < errcode_count; i++)
-		if (hclge_cmd_errcode[i].imp_errcode == desc_ret)
-			return hclge_cmd_errcode[i].common_errno;
-
-	return -EIO;
-}
-
-static int hclge_cmd_check_retval(struct hclge_hw *hw, struct hclge_desc *desc,
-				  int num, int ntc)
-{
-	u16 opcode, desc_ret;
-	int handle;
-
-	opcode = le16_to_cpu(desc[0].opcode);
-	for (handle = 0; handle < num; handle++) {
-		desc[handle] = hw->cmq.csq.desc[ntc];
-		ntc++;
-		if (ntc >= hw->cmq.csq.desc_num)
-			ntc = 0;
-	}
-	if (likely(!hclge_is_special_opcode(opcode)))
-		desc_ret = le16_to_cpu(desc[num - 1].retval);
-	else
-		desc_ret = le16_to_cpu(desc[0].retval);
-
-	hw->cmq.last_status = desc_ret;
-
-	return hclge_cmd_convert_err_code(desc_ret);
-}
-
-static int hclge_cmd_check_result(struct hclge_hw *hw, struct hclge_desc *desc,
-				  int num, int ntc)
-{
-	struct hclge_dev *hdev = container_of(hw, struct hclge_dev, hw);
-	bool is_completed = false;
-	u32 timeout = 0;
-	int handle, ret;
-
-	/**
-	 * If the command is sync, wait for the firmware to write back,
-	 * if multi descriptors to be sent, use the first one to check
-	 */
-	if (HCLGE_SEND_SYNC(le16_to_cpu(desc->flag))) {
-		do {
-			if (hclge_cmd_csq_done(hw)) {
-				is_completed = true;
-				break;
-			}
-			udelay(1);
-			timeout++;
-		} while (timeout < hw->cmq.tx_timeout);
-	}
-
-	if (!is_completed)
-		ret = -EBADE;
-	else
-		ret = hclge_cmd_check_retval(hw, desc, num, ntc);
-
-	/* Clean the command send queue */
-	handle = hclge_cmd_csq_clean(hw);
-	if (handle < 0)
-		ret = handle;
-	else if (handle != num)
-		dev_warn(&hdev->pdev->dev,
-			 "cleaned %d, need to clean %d\n", handle, num);
-	return ret;
+	hclge_cmd_config_regs(hw, &hw->hw.cmq.csq);
+	hclge_cmd_config_regs(hw, &hw->hw.cmq.crq);
 }
 
 /**
@@ -311,43 +121,7 @@ static int hclge_cmd_check_result(struct hclge_hw *hw, struct hclge_desc *desc,
  **/
 int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 {
-	struct hclge_dev *hdev = container_of(hw, struct hclge_dev, hw);
-	struct hclge_cmq_ring *csq = &hw->cmq.csq;
-	int ret;
-	int ntc;
-
-	spin_lock_bh(&hw->cmq.csq.lock);
-
-	if (test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state)) {
-		spin_unlock_bh(&hw->cmq.csq.lock);
-		return -EBUSY;
-	}
-
-	if (num > hclge_ring_space(&hw->cmq.csq)) {
-		/* If CMDQ ring is full, SW HEAD and HW HEAD may be different,
-		 * need update the SW HEAD pointer csq->next_to_clean
-		 */
-		csq->next_to_clean = hclge_read_dev(hw, HCLGE_NIC_CSQ_HEAD_REG);
-		spin_unlock_bh(&hw->cmq.csq.lock);
-		return -EBUSY;
-	}
-
-	/**
-	 * Record the location of desc in the ring for this time
-	 * which will be use for hardware to write back
-	 */
-	ntc = hw->cmq.csq.next_to_use;
-
-	hclge_cmd_copy_desc(hw, desc, num);
-
-	/* Write to hardware */
-	hclge_write_dev(hw, HCLGE_NIC_CSQ_TAIL_REG, hw->cmq.csq.next_to_use);
-
-	ret = hclge_cmd_check_result(hw, desc, num, ntc);
-
-	spin_unlock_bh(&hw->cmq.csq.lock);
-
-	return ret;
+	return hclge_comm_cmd_send(&hw->hw, desc, num, true);
 }
 
 static void hclge_set_default_capability(struct hclge_dev *hdev)
@@ -401,7 +175,7 @@ static __le32 hclge_build_api_caps(void)
 	return cpu_to_le32(api_caps);
 }
 
-static enum hclge_cmd_status
+static enum hclge_comm_cmd_status
 hclge_cmd_query_version_and_capability(struct hclge_dev *hdev)
 {
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(hdev->pdev);
@@ -433,18 +207,22 @@ hclge_cmd_query_version_and_capability(struct hclge_dev *hdev)
 
 int hclge_cmd_queue_init(struct hclge_dev *hdev)
 {
+	struct hclge_comm_cmq *cmdq = &hdev->hw.hw.cmq;
 	int ret;
 
 	/* Setup the lock for command queue */
-	spin_lock_init(&hdev->hw.cmq.csq.lock);
-	spin_lock_init(&hdev->hw.cmq.crq.lock);
+	spin_lock_init(&cmdq->csq.lock);
+	spin_lock_init(&cmdq->crq.lock);
+
+	cmdq->csq.pdev = hdev->pdev;
+	cmdq->crq.pdev = hdev->pdev;
 
 	/* Setup the queue entries for use cmd queue */
-	hdev->hw.cmq.csq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
-	hdev->hw.cmq.crq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
+	cmdq->csq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
+	cmdq->crq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
 
 	/* Setup Tx write back timeout */
-	hdev->hw.cmq.tx_timeout = HCLGE_CMDQ_TX_TIMEOUT;
+	cmdq->tx_timeout = HCLGE_CMDQ_TX_TIMEOUT;
 
 	/* Setup queue rings */
 	ret = hclge_alloc_cmd_queue(hdev, HCLGE_TYPE_CSQ);
@@ -463,7 +241,7 @@ int hclge_cmd_queue_init(struct hclge_dev *hdev)
 
 	return 0;
 err_csq:
-	hclge_free_cmd_desc(&hdev->hw.cmq.csq);
+	hclge_free_cmd_desc(&hdev->hw.hw.cmq.csq);
 	return ret;
 }
 
@@ -491,22 +269,23 @@ static int hclge_firmware_compat_config(struct hclge_dev *hdev, bool en)
 
 int hclge_cmd_init(struct hclge_dev *hdev)
 {
+	struct hclge_comm_cmq *cmdq = &hdev->hw.hw.cmq;
 	int ret;
 
-	spin_lock_bh(&hdev->hw.cmq.csq.lock);
-	spin_lock(&hdev->hw.cmq.crq.lock);
+	spin_lock_bh(&cmdq->csq.lock);
+	spin_lock(&cmdq->crq.lock);
 
-	hdev->hw.cmq.csq.next_to_clean = 0;
-	hdev->hw.cmq.csq.next_to_use = 0;
-	hdev->hw.cmq.crq.next_to_clean = 0;
-	hdev->hw.cmq.crq.next_to_use = 0;
+	cmdq->csq.next_to_clean = 0;
+	cmdq->csq.next_to_use = 0;
+	cmdq->crq.next_to_clean = 0;
+	cmdq->crq.next_to_use = 0;
 
 	hclge_cmd_init_regs(&hdev->hw);
 
-	spin_unlock(&hdev->hw.cmq.crq.lock);
-	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
+	spin_unlock(&cmdq->crq.lock);
+	spin_unlock_bh(&cmdq->csq.lock);
 
-	clear_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	clear_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 
 	/* Check if there is new reset pending, because the higher level
 	 * reset may happen when lower level reset is being processed.
@@ -550,7 +329,7 @@ int hclge_cmd_init(struct hclge_dev *hdev)
 	return 0;
 
 err_cmd_init:
-	set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 
 	return ret;
 }
@@ -571,19 +350,23 @@ static void hclge_cmd_uninit_regs(struct hclge_hw *hw)
 
 void hclge_cmd_uninit(struct hclge_dev *hdev)
 {
+	struct hclge_comm_cmq *cmdq = &hdev->hw.hw.cmq;
+
+	cmdq->csq.pdev = hdev->pdev;
+
 	hclge_firmware_compat_config(hdev, false);
 
-	set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 	/* wait to ensure that the firmware completes the possible left
 	 * over commands.
 	 */
 	msleep(HCLGE_CMDQ_CLEAR_WAIT_TIME);
-	spin_lock_bh(&hdev->hw.cmq.csq.lock);
-	spin_lock(&hdev->hw.cmq.crq.lock);
+	spin_lock_bh(&cmdq->csq.lock);
+	spin_lock(&cmdq->crq.lock);
 	hclge_cmd_uninit_regs(&hdev->hw);
-	spin_unlock(&hdev->hw.cmq.crq.lock);
-	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
+	spin_unlock(&cmdq->crq.lock);
+	spin_unlock_bh(&cmdq->csq.lock);
 
-	hclge_free_cmd_desc(&hdev->hw.cmq.csq);
-	hclge_free_cmd_desc(&hdev->hw.cmq.crq);
+	hclge_free_cmd_desc(&cmdq->csq);
+	hclge_free_cmd_desc(&cmdq->crq);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 33244472e0d0..303a7592bb18 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -7,74 +7,22 @@
 #include <linux/io.h>
 #include <linux/etherdevice.h>
 #include "hnae3.h"
+#include "hclge_comm_cmd.h"
 
 #define HCLGE_CMDQ_TX_TIMEOUT		30000
 #define HCLGE_CMDQ_CLEAR_WAIT_TIME	200
-#define HCLGE_DESC_DATA_LEN		6
 
 struct hclge_dev;
-struct hclge_desc {
-	__le16 opcode;
 
 #define HCLGE_CMDQ_RX_INVLD_B		0
 #define HCLGE_CMDQ_RX_OUTVLD_B		1
 
-	__le16 flag;
-	__le16 retval;
-	__le16 rsv;
-	__le32 data[HCLGE_DESC_DATA_LEN];
-};
-
-struct hclge_cmq_ring {
-	dma_addr_t desc_dma_addr;
-	struct hclge_desc *desc;
-	struct hclge_dev *dev;
-	u32 head;
-	u32 tail;
-
-	u16 buf_size;
-	u16 desc_num;
-	int next_to_use;
-	int next_to_clean;
-	u8 ring_type; /* cmq ring type */
-	spinlock_t lock; /* Command queue lock */
-};
-
-enum hclge_cmd_return_status {
-	HCLGE_CMD_EXEC_SUCCESS	= 0,
-	HCLGE_CMD_NO_AUTH	= 1,
-	HCLGE_CMD_NOT_SUPPORTED	= 2,
-	HCLGE_CMD_QUEUE_FULL	= 3,
-	HCLGE_CMD_NEXT_ERR	= 4,
-	HCLGE_CMD_UNEXE_ERR	= 5,
-	HCLGE_CMD_PARA_ERR	= 6,
-	HCLGE_CMD_RESULT_ERR	= 7,
-	HCLGE_CMD_TIMEOUT	= 8,
-	HCLGE_CMD_HILINK_ERR	= 9,
-	HCLGE_CMD_QUEUE_ILLEGAL	= 10,
-	HCLGE_CMD_INVALID	= 11,
-};
-
-enum hclge_cmd_status {
-	HCLGE_STATUS_SUCCESS	= 0,
-	HCLGE_ERR_CSQ_FULL	= -1,
-	HCLGE_ERR_CSQ_TIMEOUT	= -2,
-	HCLGE_ERR_CSQ_ERROR	= -3,
-};
-
 struct hclge_misc_vector {
 	u8 __iomem *addr;
 	int vector_irq;
 	char name[HNAE3_INT_NAME_LEN];
 };
 
-struct hclge_cmq {
-	struct hclge_cmq_ring csq;
-	struct hclge_cmq_ring crq;
-	u16 tx_timeout;
-	enum hclge_cmd_status last_status;
-};
-
 #define HCLGE_CMD_FLAG_IN	BIT(0)
 #define HCLGE_CMD_FLAG_OUT	BIT(1)
 #define HCLGE_CMD_FLAG_NEXT	BIT(2)
@@ -1188,7 +1136,9 @@ struct hclge_dev_specs_1_cmd {
 	__le16 max_frm_size;
 	__le16 max_qset_num;
 	__le16 max_int_gl;
-	u8 rsv1[18];
+	u8 rsv0[2];
+	__le16 umv_size;
+	u8 rsv1[14];
 };
 
 /* mac speed type defined in firmware command */
@@ -1241,25 +1191,6 @@ struct hclge_caps_bit_map {
 };
 
 int hclge_cmd_init(struct hclge_dev *hdev);
-static inline void hclge_write_reg(void __iomem *base, u32 reg, u32 value)
-{
-	writel(value, base + reg);
-}
-
-#define hclge_write_dev(a, reg, value) \
-	hclge_write_reg((a)->io_base, reg, value)
-#define hclge_read_dev(a, reg) \
-	hclge_read_reg((a)->io_base, reg)
-
-static inline u32 hclge_read_reg(u8 __iomem *base, u32 reg)
-{
-	u8 __iomem *reg_addr = READ_ONCE(base);
-
-	return readl(reg_addr + reg);
-}
-
-#define HCLGE_SEND_SYNC(flag) \
-	((flag) & HCLGE_CMD_FLAG_NO_INTR)
 
 struct hclge_hw;
 int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num);
@@ -1267,10 +1198,10 @@ void hclge_cmd_setup_basic_desc(struct hclge_desc *desc,
 				enum hclge_opcode_type opcode, bool is_read);
 void hclge_cmd_reuse_desc(struct hclge_desc *desc, bool is_read);
 
-enum hclge_cmd_status hclge_cmd_mdio_write(struct hclge_hw *hw,
-					   struct hclge_desc *desc);
-enum hclge_cmd_status hclge_cmd_mdio_read(struct hclge_hw *hw,
-					  struct hclge_desc *desc);
+enum hclge_comm_cmd_status hclge_cmd_mdio_write(struct hclge_hw *hw,
+						struct hclge_desc *desc);
+enum hclge_comm_cmd_status hclge_cmd_mdio_read(struct hclge_hw *hw,
+					       struct hclge_desc *desc);
 
 void hclge_cmd_uninit(struct hclge_dev *hdev);
 int hclge_cmd_queue_init(struct hclge_dev *hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 598da1be22eb..d58048b05678 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -24,6 +24,7 @@
 #include "hclge_err.h"
 #include "hnae3.h"
 #include "hclge_devlink.h"
+#include "hclge_comm_cmd.h"
 
 #define HCLGE_NAME			"hclge"
 
@@ -1343,8 +1344,6 @@ static void hclge_parse_cfg(struct hclge_cfg *cfg, struct hclge_desc *desc)
 	cfg->umv_space = hnae3_get_field(__le32_to_cpu(req->param[1]),
 					 HCLGE_CFG_UMV_TBL_SPACE_M,
 					 HCLGE_CFG_UMV_TBL_SPACE_S);
-	if (!cfg->umv_space)
-		cfg->umv_space = HCLGE_DEFAULT_UMV_SPACE_PER_PF;
 
 	cfg->pf_rss_size_max = hnae3_get_field(__le32_to_cpu(req->param[2]),
 					       HCLGE_CFG_PF_RSS_SIZE_M,
@@ -1420,6 +1419,7 @@ static void hclge_set_default_dev_specs(struct hclge_dev *hdev)
 	ae_dev->dev_specs.max_int_gl = HCLGE_DEF_MAX_INT_GL;
 	ae_dev->dev_specs.max_frm_size = HCLGE_MAC_MAX_FRAME;
 	ae_dev->dev_specs.max_qset_num = HCLGE_MAX_QSET_NUM;
+	ae_dev->dev_specs.umv_size = HCLGE_DEFAULT_UMV_SPACE_PER_PF;
 }
 
 static void hclge_parse_dev_specs(struct hclge_dev *hdev,
@@ -1441,6 +1441,7 @@ static void hclge_parse_dev_specs(struct hclge_dev *hdev,
 	ae_dev->dev_specs.max_qset_num = le16_to_cpu(req1->max_qset_num);
 	ae_dev->dev_specs.max_int_gl = le16_to_cpu(req1->max_int_gl);
 	ae_dev->dev_specs.max_frm_size = le16_to_cpu(req1->max_frm_size);
+	ae_dev->dev_specs.umv_size = le16_to_cpu(req1->umv_size);
 }
 
 static void hclge_check_dev_specs(struct hclge_dev *hdev)
@@ -1461,6 +1462,8 @@ static void hclge_check_dev_specs(struct hclge_dev *hdev)
 		dev_specs->max_int_gl = HCLGE_DEF_MAX_INT_GL;
 	if (!dev_specs->max_frm_size)
 		dev_specs->max_frm_size = HCLGE_MAC_MAX_FRAME;
+	if (!dev_specs->umv_size)
+		dev_specs->umv_size = HCLGE_DEFAULT_UMV_SPACE_PER_PF;
 }
 
 static int hclge_query_dev_specs(struct hclge_dev *hdev)
@@ -1550,7 +1553,10 @@ static int hclge_configure(struct hclge_dev *hdev)
 	hdev->tm_info.num_pg = 1;
 	hdev->tc_max = cfg.tc_num;
 	hdev->tm_info.hw_pfc_map = 0;
-	hdev->wanted_umv_size = cfg.umv_space;
+	if (cfg.umv_space)
+		hdev->wanted_umv_size = cfg.umv_space;
+	else
+		hdev->wanted_umv_size = hdev->ae_dev->dev_specs.umv_size;
 	hdev->tx_spare_buf_size = cfg.tx_spare_buf_size;
 	hdev->gro_en = true;
 	if (cfg.vlan_fliter_cap == HCLGE_VLAN_FLTR_CAN_MDF)
@@ -1567,6 +1573,9 @@ static int hclge_configure(struct hclge_dev *hdev)
 			cfg.default_speed, ret);
 		return ret;
 	}
+	hdev->hw.mac.req_speed = hdev->hw.mac.speed;
+	hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
+	hdev->hw.mac.req_duplex = DUPLEX_FULL;
 
 	hclge_parse_link_mode(hdev, cfg.speed_ability);
 
@@ -1669,11 +1678,11 @@ static int hclge_alloc_tqps(struct hclge_dev *hdev)
 		 * HCLGE_TQP_MAX_SIZE_DEV_V2
 		 */
 		if (i < HCLGE_TQP_MAX_SIZE_DEV_V2)
-			tqp->q.io_base = hdev->hw.io_base +
+			tqp->q.io_base = hdev->hw.hw.io_base +
 					 HCLGE_TQP_REG_OFFSET +
 					 i * HCLGE_TQP_REG_SIZE;
 		else
-			tqp->q.io_base = hdev->hw.io_base +
+			tqp->q.io_base = hdev->hw.hw.io_base +
 					 HCLGE_TQP_REG_OFFSET +
 					 HCLGE_TQP_EXT_REG_OFFSET +
 					 (i - HCLGE_TQP_MAX_SIZE_DEV_V2) *
@@ -1816,8 +1825,9 @@ static int hclge_vport_setup(struct hclge_vport *vport, u16 num_tqps)
 
 	nic->pdev = hdev->pdev;
 	nic->ae_algo = &ae_algo;
-	nic->numa_node_mask = hdev->numa_node_mask;
-	nic->kinfo.io_base = hdev->hw.io_base;
+	bitmap_copy(nic->numa_node_mask.bits, hdev->numa_node_mask.bits,
+		    MAX_NUMNODES);
+	nic->kinfo.io_base = hdev->hw.hw.io_base;
 
 	ret = hclge_knic_setup(vport, num_tqps,
 			       hdev->num_tx_desc, hdev->num_rx_desc);
@@ -2503,12 +2513,13 @@ static int hclge_init_roce_base_info(struct hclge_vport *vport)
 	roce->rinfo.base_vector = hdev->num_nic_msi;
 
 	roce->rinfo.netdev = nic->kinfo.netdev;
-	roce->rinfo.roce_io_base = hdev->hw.io_base;
-	roce->rinfo.roce_mem_base = hdev->hw.mem_base;
+	roce->rinfo.roce_io_base = hdev->hw.hw.io_base;
+	roce->rinfo.roce_mem_base = hdev->hw.hw.mem_base;
 
 	roce->pdev = nic->pdev;
 	roce->ae_algo = nic->ae_algo;
-	roce->numa_node_mask = nic->numa_node_mask;
+	bitmap_copy(roce->numa_node_mask.bits, nic->numa_node_mask.bits,
+		    MAX_NUMNODES);
 
 	return 0;
 }
@@ -2847,16 +2858,20 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 static void hclge_mbx_task_schedule(struct hclge_dev *hdev)
 {
 	if (!test_bit(HCLGE_STATE_REMOVING, &hdev->state) &&
-	    !test_and_set_bit(HCLGE_STATE_MBX_SERVICE_SCHED, &hdev->state))
+	    !test_and_set_bit(HCLGE_STATE_MBX_SERVICE_SCHED, &hdev->state)) {
+		hdev->last_mbx_scheduled = jiffies;
 		mod_delayed_work(hclge_wq, &hdev->service_task, 0);
+	}
 }
 
 static void hclge_reset_task_schedule(struct hclge_dev *hdev)
 {
 	if (!test_bit(HCLGE_STATE_REMOVING, &hdev->state) &&
 	    test_bit(HCLGE_STATE_SERVICE_INITED, &hdev->state) &&
-	    !test_and_set_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state))
+	    !test_and_set_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state)) {
+		hdev->last_rst_scheduled = jiffies;
 		mod_delayed_work(hclge_wq, &hdev->service_task, 0);
+	}
 }
 
 static void hclge_errhand_task_schedule(struct hclge_dev *hdev)
@@ -3158,9 +3173,9 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
 		return ret;
 	}
 
-	hdev->hw.mac.autoneg = cmd->base.autoneg;
-	hdev->hw.mac.speed = cmd->base.speed;
-	hdev->hw.mac.duplex = cmd->base.duplex;
+	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
+	hdev->hw.mac.req_speed = cmd->base.speed;
+	hdev->hw.mac.req_duplex = cmd->base.duplex;
 	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
 
 	return 0;
@@ -3193,9 +3208,9 @@ static int hclge_tp_port_init(struct hclge_dev *hdev)
 	if (!hnae3_dev_phy_imp_supported(hdev))
 		return 0;
 
-	cmd.base.autoneg = hdev->hw.mac.autoneg;
-	cmd.base.speed = hdev->hw.mac.speed;
-	cmd.base.duplex = hdev->hw.mac.duplex;
+	cmd.base.autoneg = hdev->hw.mac.req_autoneg;
+	cmd.base.speed = hdev->hw.mac.req_speed;
+	cmd.base.duplex = hdev->hw.mac.req_duplex;
 	linkmode_copy(cmd.link_modes.advertising, hdev->hw.mac.advertising);
 
 	return hclge_set_phy_link_ksettings(&hdev->vport->nic, &cmd);
@@ -3354,7 +3369,7 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 	if (BIT(HCLGE_VECTOR0_IMPRESET_INT_B) & msix_src_reg) {
 		dev_info(&hdev->pdev->dev, "IMP reset interrupt\n");
 		set_bit(HNAE3_IMP_RESET, &hdev->reset_pending);
-		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+		set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 		*clearval = BIT(HCLGE_VECTOR0_IMPRESET_INT_B);
 		hdev->rst_stats.imp_rst_cnt++;
 		return HCLGE_VECTOR0_EVENT_RST;
@@ -3362,7 +3377,7 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 
 	if (BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B) & msix_src_reg) {
 		dev_info(&hdev->pdev->dev, "global reset interrupt\n");
-		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+		set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 		set_bit(HNAE3_GLOBAL_RESET, &hdev->reset_pending);
 		*clearval = BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B);
 		hdev->rst_stats.global_rst_cnt++;
@@ -3501,7 +3516,7 @@ static void hclge_get_misc_vector(struct hclge_dev *hdev)
 
 	vector->vector_irq = pci_irq_vector(hdev->pdev, 0);
 
-	vector->addr = hdev->hw.io_base + HCLGE_MISC_VECTOR_REG_BASE;
+	vector->addr = hdev->hw.hw.io_base + HCLGE_MISC_VECTOR_REG_BASE;
 	hdev->vector_status[0] = 0;
 
 	hdev->num_msi_left -= 1;
@@ -3685,10 +3700,17 @@ static int hclge_set_all_vf_rst(struct hclge_dev *hdev, bool reset)
 static void hclge_mailbox_service_task(struct hclge_dev *hdev)
 {
 	if (!test_and_clear_bit(HCLGE_STATE_MBX_SERVICE_SCHED, &hdev->state) ||
-	    test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state) ||
+	    test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state) ||
 	    test_and_set_bit(HCLGE_STATE_MBX_HANDLING, &hdev->state))
 		return;
 
+	if (time_is_before_jiffies(hdev->last_mbx_scheduled +
+				   HCLGE_MBX_SCHED_TIMEOUT))
+		dev_warn(&hdev->pdev->dev,
+			 "mbx service task is scheduled after %ums on cpu%u!\n",
+			 jiffies_to_msecs(jiffies - hdev->last_mbx_scheduled),
+			 smp_processor_id());
+
 	hclge_mbx_handler(hdev);
 
 	clear_bit(HCLGE_STATE_MBX_HANDLING, &hdev->state);
@@ -3925,7 +3947,7 @@ static int hclge_reset_prepare_wait(struct hclge_dev *hdev)
 		 * any mailbox handling or command to firmware is only valid
 		 * after hclge_cmd_init is called.
 		 */
-		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+		set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 		hdev->rst_stats.pf_rst_cnt++;
 		break;
 	case HNAE3_FLR_RESET:
@@ -4338,6 +4360,13 @@ static void hclge_reset_service_task(struct hclge_dev *hdev)
 	if (!test_and_clear_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state))
 		return;
 
+	if (time_is_before_jiffies(hdev->last_rst_scheduled +
+				   HCLGE_RESET_SCHED_TIMEOUT))
+		dev_warn(&hdev->pdev->dev,
+			 "reset service task is scheduled after %ums on cpu%u!\n",
+			 jiffies_to_msecs(jiffies - hdev->last_rst_scheduled),
+			 smp_processor_id());
+
 	down(&hdev->reset_sem);
 	set_bit(HCLGE_STATE_RST_HANDLING, &hdev->state);
 
@@ -4472,11 +4501,11 @@ static void hclge_get_vector_info(struct hclge_dev *hdev, u16 idx,
 
 	/* need an extend offset to config vector >= 64 */
 	if (idx - 1 < HCLGE_PF_MAX_VECTOR_NUM_DEV_V2)
-		vector_info->io_addr = hdev->hw.io_base +
+		vector_info->io_addr = hdev->hw.hw.io_base +
 				HCLGE_VECTOR_REG_BASE +
 				(idx - 1) * HCLGE_VECTOR_REG_OFFSET;
 	else
-		vector_info->io_addr = hdev->hw.io_base +
+		vector_info->io_addr = hdev->hw.hw.io_base +
 				HCLGE_VECTOR_EXT_REG_BASE +
 				(idx - 1) / HCLGE_PF_MAX_VECTOR_NUM_DEV_V2 *
 				HCLGE_VECTOR_REG_OFFSET_H +
@@ -5114,7 +5143,7 @@ int hclge_bind_ring_with_vector(struct hclge_vport *vport,
 	struct hclge_desc desc;
 	struct hclge_ctrl_vector_chain_cmd *req =
 		(struct hclge_ctrl_vector_chain_cmd *)desc.data;
-	enum hclge_cmd_status status;
+	enum hclge_comm_cmd_status status;
 	enum hclge_opcode_type op;
 	u16 tqp_type_and_id;
 	int i;
@@ -7640,7 +7669,7 @@ static bool hclge_get_cmdq_stat(struct hnae3_handle *handle)
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 
-	return test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	return test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 }
 
 static bool hclge_ae_dev_resetting(struct hnae3_handle *handle)
@@ -8127,8 +8156,7 @@ static void hclge_set_timer_task(struct hnae3_handle *handle, bool enable)
 		/* Set the DOWN flag here to disable link updating */
 		set_bit(HCLGE_STATE_DOWN, &hdev->state);
 
-		/* flush memory to make sure DOWN is seen by service task */
-		smp_mb__before_atomic();
+		smp_mb__after_atomic(); /* flush memory to make sure DOWN is seen by service task */
 		hclge_flush_link_update(hdev);
 	}
 }
@@ -8838,7 +8866,7 @@ int hclge_rm_mc_addr_common(struct hclge_vport *vport,
 	char format_mac_addr[HNAE3_FORMAT_MAC_ADDR_LEN];
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_mac_vlan_tbl_entry_cmd req;
-	enum hclge_cmd_status status;
+	enum hclge_comm_cmd_status status;
 	struct hclge_desc desc[3];
 
 	/* mac addr check */
@@ -10074,67 +10102,85 @@ static int hclge_set_vlan_protocol_type(struct hclge_dev *hdev)
 	return status;
 }
 
-static int hclge_init_vlan_config(struct hclge_dev *hdev)
+static int hclge_init_vlan_filter(struct hclge_dev *hdev)
 {
-#define HCLGE_DEF_VLAN_TYPE		0x8100
-
-	struct hnae3_handle *handle = &hdev->vport[0].nic;
 	struct hclge_vport *vport;
+	bool enable = true;
 	int ret;
 	int i;
 
-	if (hdev->ae_dev->dev_version >= HNAE3_DEVICE_VERSION_V2) {
-		/* for revision 0x21, vf vlan filter is per function */
-		for (i = 0; i < hdev->num_alloc_vport; i++) {
-			vport = &hdev->vport[i];
-			ret = hclge_set_vlan_filter_ctrl(hdev,
-							 HCLGE_FILTER_TYPE_VF,
-							 HCLGE_FILTER_FE_EGRESS,
-							 true,
-							 vport->vport_id);
-			if (ret)
-				return ret;
-			vport->cur_vlan_fltr_en = true;
-		}
+	if (hdev->ae_dev->dev_version < HNAE3_DEVICE_VERSION_V2)
+		return hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
+						  HCLGE_FILTER_FE_EGRESS_V1_B,
+						  true, 0);
 
-		ret = hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_PORT,
-						 HCLGE_FILTER_FE_INGRESS, true,
-						 0);
-		if (ret)
-			return ret;
-	} else {
+	/* for revision 0x21, vf vlan filter is per function */
+	for (i = 0; i < hdev->num_alloc_vport; i++) {
+		vport = &hdev->vport[i];
 		ret = hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_VF,
-						 HCLGE_FILTER_FE_EGRESS_V1_B,
-						 true, 0);
+						 HCLGE_FILTER_FE_EGRESS, true,
+						 vport->vport_id);
 		if (ret)
 			return ret;
+		vport->cur_vlan_fltr_en = true;
 	}
 
-	hdev->vlan_type_cfg.rx_in_fst_vlan_type = HCLGE_DEF_VLAN_TYPE;
-	hdev->vlan_type_cfg.rx_in_sec_vlan_type = HCLGE_DEF_VLAN_TYPE;
-	hdev->vlan_type_cfg.rx_ot_fst_vlan_type = HCLGE_DEF_VLAN_TYPE;
-	hdev->vlan_type_cfg.rx_ot_sec_vlan_type = HCLGE_DEF_VLAN_TYPE;
-	hdev->vlan_type_cfg.tx_ot_vlan_type = HCLGE_DEF_VLAN_TYPE;
-	hdev->vlan_type_cfg.tx_in_vlan_type = HCLGE_DEF_VLAN_TYPE;
+	if (test_bit(HNAE3_DEV_SUPPORT_VLAN_FLTR_MDF_B, hdev->ae_dev->caps) &&
+	    !test_bit(HNAE3_DEV_SUPPORT_PORT_VLAN_BYPASS_B, hdev->ae_dev->caps))
+		enable = false;
 
-	ret = hclge_set_vlan_protocol_type(hdev);
-	if (ret)
-		return ret;
+	return hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_PORT,
+					  HCLGE_FILTER_FE_INGRESS, enable, 0);
+}
 
-	for (i = 0; i < hdev->num_alloc_vport; i++) {
-		u16 vlan_tag;
-		u8 qos;
+static int hclge_init_vlan_type(struct hclge_dev *hdev)
+{
+	hdev->vlan_type_cfg.rx_in_fst_vlan_type = ETH_P_8021Q;
+	hdev->vlan_type_cfg.rx_in_sec_vlan_type = ETH_P_8021Q;
+	hdev->vlan_type_cfg.rx_ot_fst_vlan_type = ETH_P_8021Q;
+	hdev->vlan_type_cfg.rx_ot_sec_vlan_type = ETH_P_8021Q;
+	hdev->vlan_type_cfg.tx_ot_vlan_type = ETH_P_8021Q;
+	hdev->vlan_type_cfg.tx_in_vlan_type = ETH_P_8021Q;
+
+	return hclge_set_vlan_protocol_type(hdev);
+}
 
+static int hclge_init_vport_vlan_offload(struct hclge_dev *hdev)
+{
+	struct hclge_port_base_vlan_config *cfg;
+	struct hclge_vport *vport;
+	int ret;
+	int i;
+
+	for (i = 0; i < hdev->num_alloc_vport; i++) {
 		vport = &hdev->vport[i];
-		vlan_tag = vport->port_base_vlan_cfg.vlan_info.vlan_tag;
-		qos = vport->port_base_vlan_cfg.vlan_info.qos;
+		cfg = &vport->port_base_vlan_cfg;
 
-		ret = hclge_vlan_offload_cfg(vport,
-					     vport->port_base_vlan_cfg.state,
-					     vlan_tag, qos);
+		ret = hclge_vlan_offload_cfg(vport, cfg->state,
+					     cfg->vlan_info.vlan_tag,
+					     cfg->vlan_info.qos);
 		if (ret)
 			return ret;
 	}
+	return 0;
+}
+
+static int hclge_init_vlan_config(struct hclge_dev *hdev)
+{
+	struct hnae3_handle *handle = &hdev->vport[0].nic;
+	int ret;
+
+	ret = hclge_init_vlan_filter(hdev);
+	if (ret)
+		return ret;
+
+	ret = hclge_init_vlan_type(hdev);
+	if (ret)
+		return ret;
+
+	ret = hclge_init_vport_vlan_offload(hdev);
+	if (ret)
+		return ret;
 
 	return hclge_set_vlan_filter(handle, htons(ETH_P_8021Q), 0, false);
 }
@@ -11424,10 +11470,11 @@ static int hclge_dev_mem_map(struct hclge_dev *hdev)
 	if (!(pci_select_bars(pdev, IORESOURCE_MEM) & BIT(HCLGE_MEM_BAR)))
 		return 0;
 
-	hw->mem_base = devm_ioremap_wc(&pdev->dev,
-				       pci_resource_start(pdev, HCLGE_MEM_BAR),
-				       pci_resource_len(pdev, HCLGE_MEM_BAR));
-	if (!hw->mem_base) {
+	hw->hw.mem_base =
+		devm_ioremap_wc(&pdev->dev,
+				pci_resource_start(pdev, HCLGE_MEM_BAR),
+				pci_resource_len(pdev, HCLGE_MEM_BAR));
+	if (!hw->hw.mem_base) {
 		dev_err(&pdev->dev, "failed to map device memory\n");
 		return -EFAULT;
 	}
@@ -11466,8 +11513,8 @@ static int hclge_pci_init(struct hclge_dev *hdev)
 
 	pci_set_master(pdev);
 	hw = &hdev->hw;
-	hw->io_base = pcim_iomap(pdev, 2, 0);
-	if (!hw->io_base) {
+	hw->hw.io_base = pcim_iomap(pdev, 2, 0);
+	if (!hw->hw.io_base) {
 		dev_err(&pdev->dev, "Can't map configuration register space\n");
 		ret = -ENOMEM;
 		goto err_clr_master;
@@ -11482,7 +11529,7 @@ static int hclge_pci_init(struct hclge_dev *hdev)
 	return 0;
 
 err_unmap_io_base:
-	pcim_iounmap(pdev, hdev->hw.io_base);
+	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 err_clr_master:
 	pci_clear_master(pdev);
 	pci_release_regions(pdev);
@@ -11496,10 +11543,10 @@ static void hclge_pci_uninit(struct hclge_dev *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
 
-	if (hdev->hw.mem_base)
-		devm_iounmap(&pdev->dev, hdev->hw.mem_base);
+	if (hdev->hw.hw.mem_base)
+		devm_iounmap(&pdev->dev, hdev->hw.hw.mem_base);
 
-	pcim_iounmap(pdev, hdev->hw.io_base);
+	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 	pci_free_irq_vectors(pdev);
 	pci_clear_master(pdev);
 	pci_release_mem_regions(pdev);
@@ -11560,7 +11607,7 @@ static void hclge_reset_prepare_general(struct hnae3_ae_dev *ae_dev,
 
 	/* disable misc vector before reset done */
 	hclge_enable_vector(&hdev->misc_vector, false);
-	set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+	set_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state);
 
 	if (hdev->reset_type == HNAE3_FLR_RESET)
 		hdev->rst_stats.flr_rst_cnt++;
@@ -11851,7 +11898,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 err_devlink_uninit:
 	hclge_devlink_uninit(hdev);
 err_pci_uninit:
-	pcim_iounmap(pdev, hdev->hw.io_base);
+	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index a716027df0ed..1ef5b4c8625a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -228,7 +228,6 @@ enum HCLGE_DEV_STATE {
 	HCLGE_STATE_MBX_HANDLING,
 	HCLGE_STATE_ERR_SERVICE_SCHED,
 	HCLGE_STATE_STATISTICS_UPDATING,
-	HCLGE_STATE_CMD_DISABLE,
 	HCLGE_STATE_LINK_UPDATING,
 	HCLGE_STATE_RST_FAIL,
 	HCLGE_STATE_FD_TBL_CHANGED,
@@ -275,10 +274,13 @@ struct hclge_mac {
 	u8 media_type;	/* port media type, e.g. fibre/copper/backplane */
 	u8 mac_addr[ETH_ALEN];
 	u8 autoneg;
+	u8 req_autoneg;
 	u8 duplex;
+	u8 req_duplex;
 	u8 support_autoneg;
 	u8 speed_type;	/* 0: sfp speed, 1: active speed */
 	u32 speed;
+	u32 req_speed;
 	u32 max_speed;
 	u32 speed_ability; /* speed ability supported by current media */
 	u32 module_type; /* sub media type, e.g. kr/cr/sr/lr */
@@ -294,11 +296,9 @@ struct hclge_mac {
 };
 
 struct hclge_hw {
-	void __iomem *io_base;
-	void __iomem *mem_base;
+	struct hclge_comm_hw hw;
 	struct hclge_mac mac;
 	int num_vec;
-	struct hclge_cmq cmq;
 };
 
 /* TQP stats */
@@ -613,6 +613,11 @@ struct key_info {
 #define MAX_FD_FILTER_NUM	4096
 #define HCLGE_ARFS_EXPIRE_INTERVAL	5UL
 
+#define hclge_read_dev(a, reg) \
+	hclge_comm_read_reg((a)->hw.io_base, reg)
+#define hclge_write_dev(a, reg, value) \
+	hclge_comm_write_reg((a)->hw.io_base, reg, value)
+
 enum HCLGE_FD_ACTIVE_RULE_TYPE {
 	HCLGE_FD_RULE_NONE,
 	HCLGE_FD_ARFS_ACTIVE,
@@ -858,7 +863,7 @@ struct hclge_dev {
 
 	u16 fdir_pf_filter_count; /* Num of guaranteed filters for this PF */
 	u16 num_alloc_vport;		/* Num vports this driver supports */
-	u32 numa_node_mask;
+	nodemask_t numa_node_mask;
 	u16 rx_buf_len;
 	u16 num_tx_desc;		/* desc num of per tx queue */
 	u16 num_rx_desc;		/* desc num of per rx queue */
@@ -925,6 +930,8 @@ struct hclge_dev {
 	u16 hclge_fd_rule_num;
 	unsigned long serv_processed_cnt;
 	unsigned long last_serv_processed;
+	unsigned long last_rst_scheduled;
+	unsigned long last_mbx_scheduled;
 	unsigned long fd_bmap[BITS_TO_LONGS(MAX_FD_FILTER_NUM)];
 	enum HCLGE_FD_ACTIVE_RULE_TYPE fd_active_type;
 	u8 fd_en;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 5182051e5414..77c432ab7856 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -33,7 +33,7 @@ static int hclge_gen_resp_to_vf(struct hclge_vport *vport,
 {
 	struct hclge_mbx_pf_to_vf_cmd *resp_pf_to_vf;
 	struct hclge_dev *hdev = vport->back;
-	enum hclge_cmd_status status;
+	enum hclge_comm_cmd_status status;
 	struct hclge_desc desc;
 	u16 resp;
 
@@ -92,7 +92,7 @@ static int hclge_send_mbx_msg(struct hclge_vport *vport, u8 *msg, u16 msg_len,
 {
 	struct hclge_mbx_pf_to_vf_cmd *resp_pf_to_vf;
 	struct hclge_dev *hdev = vport->back;
-	enum hclge_cmd_status status;
+	enum hclge_comm_cmd_status status;
 	struct hclge_desc desc;
 
 	if (msg_len > HCLGE_MBX_MAX_MSG_SIZE) {
@@ -250,6 +250,81 @@ static int hclge_map_unmap_ring_to_vf_vector(struct hclge_vport *vport, bool en,
 	return ret;
 }
 
+static int hclge_query_ring_vector_map(struct hclge_vport *vport,
+				       struct hnae3_ring_chain_node *ring_chain,
+				       struct hclge_desc *desc)
+{
+	struct hclge_ctrl_vector_chain_cmd *req =
+		(struct hclge_ctrl_vector_chain_cmd *)desc->data;
+	struct hclge_dev *hdev = vport->back;
+	u16 tqp_type_and_id;
+	int status;
+
+	hclge_cmd_setup_basic_desc(desc, HCLGE_OPC_ADD_RING_TO_VECTOR, true);
+
+	tqp_type_and_id = le16_to_cpu(req->tqp_type_and_id[0]);
+	hnae3_set_field(tqp_type_and_id, HCLGE_INT_TYPE_M, HCLGE_INT_TYPE_S,
+			hnae3_get_bit(ring_chain->flag, HNAE3_RING_TYPE_B));
+	hnae3_set_field(tqp_type_and_id, HCLGE_TQP_ID_M, HCLGE_TQP_ID_S,
+			ring_chain->tqp_index);
+	req->tqp_type_and_id[0] = cpu_to_le16(tqp_type_and_id);
+	req->vfid = vport->vport_id;
+
+	status = hclge_cmd_send(&hdev->hw, desc, 1);
+	if (status)
+		dev_err(&hdev->pdev->dev,
+			"Get VF ring vector map info fail, status is %d.\n",
+			status);
+
+	return status;
+}
+
+static int hclge_get_vf_ring_vector_map(struct hclge_vport *vport,
+					struct hclge_mbx_vf_to_pf_cmd *req,
+					struct hclge_respond_to_vf_msg *resp)
+{
+#define HCLGE_LIMIT_RING_NUM			1
+#define HCLGE_RING_TYPE_OFFSET			0
+#define HCLGE_TQP_INDEX_OFFSET			1
+#define HCLGE_INT_GL_INDEX_OFFSET		2
+#define HCLGE_VECTOR_ID_OFFSET			3
+#define HCLGE_RING_VECTOR_MAP_INFO_LEN		4
+	struct hnae3_ring_chain_node ring_chain;
+	struct hclge_desc desc;
+	struct hclge_ctrl_vector_chain_cmd *data =
+		(struct hclge_ctrl_vector_chain_cmd *)desc.data;
+	u16 tqp_type_and_id;
+	u8 int_gl_index;
+	int ret;
+
+	req->msg.ring_num = HCLGE_LIMIT_RING_NUM;
+
+	memset(&ring_chain, 0, sizeof(ring_chain));
+	ret = hclge_get_ring_chain_from_mbx(req, &ring_chain, vport);
+	if (ret)
+		return ret;
+
+	ret = hclge_query_ring_vector_map(vport, &ring_chain, &desc);
+	if (ret) {
+		hclge_free_vector_ring_chain(&ring_chain);
+		return ret;
+	}
+
+	tqp_type_and_id = le16_to_cpu(data->tqp_type_and_id[0]);
+	int_gl_index = hnae3_get_field(tqp_type_and_id,
+				       HCLGE_INT_GL_IDX_M, HCLGE_INT_GL_IDX_S);
+
+	resp->data[HCLGE_RING_TYPE_OFFSET] = req->msg.param[0].ring_type;
+	resp->data[HCLGE_TQP_INDEX_OFFSET] = req->msg.param[0].tqp_index;
+	resp->data[HCLGE_INT_GL_INDEX_OFFSET] = int_gl_index;
+	resp->data[HCLGE_VECTOR_ID_OFFSET] = data->int_vector_id_l;
+	resp->len = HCLGE_RING_VECTOR_MAP_INFO_LEN;
+
+	hclge_free_vector_ring_chain(&ring_chain);
+
+	return ret;
+}
+
 static void hclge_set_vf_promisc_mode(struct hclge_vport *vport,
 				      struct hclge_mbx_vf_to_pf_cmd *req)
 {
@@ -670,7 +745,7 @@ static bool hclge_cmd_crq_empty(struct hclge_hw *hw)
 {
 	u32 tail = hclge_read_dev(hw, HCLGE_NIC_CRQ_TAIL_REG);
 
-	return tail == hw->cmq.crq.next_to_use;
+	return tail == hw->hw.cmq.crq.next_to_use;
 }
 
 static void hclge_handle_ncsi_error(struct hclge_dev *hdev)
@@ -699,20 +774,289 @@ static void hclge_handle_vf_tbl(struct hclge_vport *vport,
 	}
 }
 
+static int
+hclge_mbx_map_ring_to_vector_handler(struct hclge_mbx_ops_param *param)
+{
+	return hclge_map_unmap_ring_to_vf_vector(param->vport, true,
+						 param->req);
+}
+
+static int
+hclge_mbx_unmap_ring_to_vector_handler(struct hclge_mbx_ops_param *param)
+{
+	return hclge_map_unmap_ring_to_vf_vector(param->vport, false,
+						 param->req);
+}
+
+static int
+hclge_mbx_get_ring_vector_map_handler(struct hclge_mbx_ops_param *param)
+{
+	int ret;
+
+	ret = hclge_get_vf_ring_vector_map(param->vport, param->req,
+					   param->resp_msg);
+	if (ret)
+		dev_err(&param->vport->back->pdev->dev,
+			"PF fail(%d) to get VF ring vector map\n",
+			ret);
+	return ret;
+}
+
+static int hclge_mbx_set_promisc_mode_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_set_vf_promisc_mode(param->vport, param->req);
+	return 0;
+}
+
+static int hclge_mbx_set_unicast_handler(struct hclge_mbx_ops_param *param)
+{
+	int ret;
+
+	ret = hclge_set_vf_uc_mac_addr(param->vport, param->req);
+	if (ret)
+		dev_err(&param->vport->back->pdev->dev,
+			"PF fail(%d) to set VF UC MAC Addr\n",
+			ret);
+	return ret;
+}
+
+static int hclge_mbx_set_multicast_handler(struct hclge_mbx_ops_param *param)
+{
+	int ret;
+
+	ret = hclge_set_vf_mc_mac_addr(param->vport, param->req);
+	if (ret)
+		dev_err(&param->vport->back->pdev->dev,
+			"PF fail(%d) to set VF MC MAC Addr\n",
+			ret);
+	return ret;
+}
+
+static int hclge_mbx_set_vlan_handler(struct hclge_mbx_ops_param *param)
+{
+	int ret;
+
+	ret = hclge_set_vf_vlan_cfg(param->vport, param->req, param->resp_msg);
+	if (ret)
+		dev_err(&param->vport->back->pdev->dev,
+			"PF failed(%d) to config VF's VLAN\n",
+			ret);
+	return ret;
+}
+
+static int hclge_mbx_set_alive_handler(struct hclge_mbx_ops_param *param)
+{
+	int ret;
+
+	ret = hclge_set_vf_alive(param->vport, param->req);
+	if (ret)
+		dev_err(&param->vport->back->pdev->dev,
+			"PF failed(%d) to set VF's ALIVE\n",
+			ret);
+	return ret;
+}
+
+static int hclge_mbx_get_qinfo_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_get_vf_queue_info(param->vport, param->resp_msg);
+	return 0;
+}
+
+static int hclge_mbx_get_qdepth_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_get_vf_queue_depth(param->vport, param->resp_msg);
+	return 0;
+}
+
+static int hclge_mbx_get_basic_info_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_get_basic_info(param->vport, param->resp_msg);
+	return 0;
+}
+
+static int hclge_mbx_get_link_status_handler(struct hclge_mbx_ops_param *param)
+{
+	int ret;
+
+	ret = hclge_push_vf_link_status(param->vport);
+	if (ret)
+		dev_err(&param->vport->back->pdev->dev,
+			"failed to inform link stat to VF, ret = %d\n",
+			ret);
+	return ret;
+}
+
+static int hclge_mbx_queue_reset_handler(struct hclge_mbx_ops_param *param)
+{
+	return hclge_mbx_reset_vf_queue(param->vport, param->req,
+					param->resp_msg);
+}
+
+static int hclge_mbx_reset_handler(struct hclge_mbx_ops_param *param)
+{
+	return hclge_reset_vf(param->vport);
+}
+
+static int hclge_mbx_keep_alive_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_vf_keep_alive(param->vport);
+	return 0;
+}
+
+static int hclge_mbx_set_mtu_handler(struct hclge_mbx_ops_param *param)
+{
+	int ret;
+
+	ret = hclge_set_vf_mtu(param->vport, param->req);
+	if (ret)
+		dev_err(&param->vport->back->pdev->dev,
+			"VF fail(%d) to set mtu\n", ret);
+	return ret;
+}
+
+static int hclge_mbx_get_qid_in_pf_handler(struct hclge_mbx_ops_param *param)
+{
+	return hclge_get_queue_id_in_pf(param->vport, param->req,
+					param->resp_msg);
+}
+
+static int hclge_mbx_get_rss_key_handler(struct hclge_mbx_ops_param *param)
+{
+	return hclge_get_rss_key(param->vport, param->req, param->resp_msg);
+}
+
+static int hclge_mbx_get_link_mode_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_get_link_mode(param->vport, param->req);
+	return 0;
+}
+
+static int
+hclge_mbx_get_vf_flr_status_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_rm_vport_all_mac_table(param->vport, false,
+				     HCLGE_MAC_ADDR_UC);
+	hclge_rm_vport_all_mac_table(param->vport, false,
+				     HCLGE_MAC_ADDR_MC);
+	hclge_rm_vport_all_vlan_table(param->vport, false);
+	return 0;
+}
+
+static int hclge_mbx_vf_uninit_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_rm_vport_all_mac_table(param->vport, true,
+				     HCLGE_MAC_ADDR_UC);
+	hclge_rm_vport_all_mac_table(param->vport, true,
+				     HCLGE_MAC_ADDR_MC);
+	hclge_rm_vport_all_vlan_table(param->vport, true);
+	return 0;
+}
+
+static int hclge_mbx_get_media_type_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_get_vf_media_type(param->vport, param->resp_msg);
+	return 0;
+}
+
+static int hclge_mbx_push_link_status_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_handle_link_change_event(param->vport->back, param->req);
+	return 0;
+}
+
+static int hclge_mbx_get_mac_addr_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_get_vf_mac_addr(param->vport, param->resp_msg);
+	return 0;
+}
+
+static int hclge_mbx_ncsi_error_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_handle_ncsi_error(param->vport->back);
+	return 0;
+}
+
+static int hclge_mbx_handle_vf_tbl_handler(struct hclge_mbx_ops_param *param)
+{
+	hclge_handle_vf_tbl(param->vport, param->req);
+	return 0;
+}
+
+static const hclge_mbx_ops_fn hclge_mbx_ops_list[HCLGE_MBX_OPCODE_MAX] = {
+	[HCLGE_MBX_RESET]   = hclge_mbx_reset_handler,
+	[HCLGE_MBX_SET_UNICAST] = hclge_mbx_set_unicast_handler,
+	[HCLGE_MBX_SET_MULTICAST] = hclge_mbx_set_multicast_handler,
+	[HCLGE_MBX_SET_VLAN] = hclge_mbx_set_vlan_handler,
+	[HCLGE_MBX_MAP_RING_TO_VECTOR] = hclge_mbx_map_ring_to_vector_handler,
+	[HCLGE_MBX_UNMAP_RING_TO_VECTOR] = hclge_mbx_unmap_ring_to_vector_handler,
+	[HCLGE_MBX_SET_PROMISC_MODE] = hclge_mbx_set_promisc_mode_handler,
+	[HCLGE_MBX_GET_QINFO] = hclge_mbx_get_qinfo_handler,
+	[HCLGE_MBX_GET_QDEPTH] = hclge_mbx_get_qdepth_handler,
+	[HCLGE_MBX_GET_BASIC_INFO] = hclge_mbx_get_basic_info_handler,
+	[HCLGE_MBX_GET_RSS_KEY] = hclge_mbx_get_rss_key_handler,
+	[HCLGE_MBX_GET_MAC_ADDR] = hclge_mbx_get_mac_addr_handler,
+	[HCLGE_MBX_GET_LINK_STATUS] = hclge_mbx_get_link_status_handler,
+	[HCLGE_MBX_QUEUE_RESET] = hclge_mbx_queue_reset_handler,
+	[HCLGE_MBX_KEEP_ALIVE] = hclge_mbx_keep_alive_handler,
+	[HCLGE_MBX_SET_ALIVE] = hclge_mbx_set_alive_handler,
+	[HCLGE_MBX_SET_MTU] = hclge_mbx_set_mtu_handler,
+	[HCLGE_MBX_GET_QID_IN_PF] = hclge_mbx_get_qid_in_pf_handler,
+	[HCLGE_MBX_GET_LINK_MODE] = hclge_mbx_get_link_mode_handler,
+	[HCLGE_MBX_GET_MEDIA_TYPE] = hclge_mbx_get_media_type_handler,
+	[HCLGE_MBX_VF_UNINIT] = hclge_mbx_vf_uninit_handler,
+	[HCLGE_MBX_HANDLE_VF_TBL] = hclge_mbx_handle_vf_tbl_handler,
+	[HCLGE_MBX_GET_RING_VECTOR_MAP] = hclge_mbx_get_ring_vector_map_handler,
+	[HCLGE_MBX_GET_VF_FLR_STATUS] = hclge_mbx_get_vf_flr_status_handler,
+	[HCLGE_MBX_PUSH_LINK_STATUS] = hclge_mbx_push_link_status_handler,
+	[HCLGE_MBX_NCSI_ERROR] = hclge_mbx_ncsi_error_handler,
+};
+
+static void hclge_mbx_request_handling(struct hclge_mbx_ops_param *param)
+{
+	hclge_mbx_ops_fn cmd_func = NULL;
+	struct hclge_dev *hdev;
+	int ret = 0;
+
+	hdev = param->vport->back;
+	cmd_func = hclge_mbx_ops_list[param->req->msg.code];
+	if (!cmd_func) {
+		dev_err(&hdev->pdev->dev,
+			"un-supported mailbox message, code = %u\n",
+			param->req->msg.code);
+		return;
+	}
+	ret = cmd_func(param);
+
+	/* PF driver should not reply IMP */
+	if (hnae3_get_bit(param->req->mbx_need_resp, HCLGE_MBX_NEED_RESP_B) &&
+	    param->req->msg.code < HCLGE_MBX_GET_VF_FLR_STATUS) {
+		param->resp_msg->status = ret;
+		if (time_is_before_jiffies(hdev->last_mbx_scheduled +
+					   HCLGE_MBX_SCHED_TIMEOUT))
+			dev_warn(&hdev->pdev->dev,
+				 "resp vport%u mbx(%u,%u) late\n",
+				 param->req->mbx_src_vfid,
+				 param->req->msg.code,
+				 param->req->msg.subcode);
+
+		hclge_gen_resp_to_vf(param->vport, param->req, param->resp_msg);
+	}
+}
+
 void hclge_mbx_handler(struct hclge_dev *hdev)
 {
-	struct hclge_cmq_ring *crq = &hdev->hw.cmq.crq;
+	struct hclge_comm_cmq_ring *crq = &hdev->hw.hw.cmq.crq;
 	struct hclge_respond_to_vf_msg resp_msg;
 	struct hclge_mbx_vf_to_pf_cmd *req;
-	struct hclge_vport *vport;
+	struct hclge_mbx_ops_param param;
 	struct hclge_desc *desc;
-	bool is_del = false;
 	unsigned int flag;
-	int ret = 0;
 
+	param.resp_msg = &resp_msg;
 	/* handle all the mailbox requests in the queue */
 	while (!hclge_cmd_crq_empty(&hdev->hw)) {
-		if (test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state)) {
+		if (test_bit(HCLGE_COMM_STATE_CMD_DISABLE,
+			     &hdev->hw.hw.comm_state)) {
 			dev_warn(&hdev->pdev->dev,
 				 "command queue needs re-initializing\n");
 			return;
@@ -733,136 +1077,16 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 			continue;
 		}
 
-		vport = &hdev->vport[req->mbx_src_vfid];
-
 		trace_hclge_pf_mbx_get(hdev, req);
 
 		/* clear the resp_msg before processing every mailbox message */
 		memset(&resp_msg, 0, sizeof(resp_msg));
-
-		switch (req->msg.code) {
-		case HCLGE_MBX_MAP_RING_TO_VECTOR:
-			ret = hclge_map_unmap_ring_to_vf_vector(vport, true,
-								req);
-			break;
-		case HCLGE_MBX_UNMAP_RING_TO_VECTOR:
-			ret = hclge_map_unmap_ring_to_vf_vector(vport, false,
-								req);
-			break;
-		case HCLGE_MBX_SET_PROMISC_MODE:
-			hclge_set_vf_promisc_mode(vport, req);
-			break;
-		case HCLGE_MBX_SET_UNICAST:
-			ret = hclge_set_vf_uc_mac_addr(vport, req);
-			if (ret)
-				dev_err(&hdev->pdev->dev,
-					"PF fail(%d) to set VF UC MAC Addr\n",
-					ret);
-			break;
-		case HCLGE_MBX_SET_MULTICAST:
-			ret = hclge_set_vf_mc_mac_addr(vport, req);
-			if (ret)
-				dev_err(&hdev->pdev->dev,
-					"PF fail(%d) to set VF MC MAC Addr\n",
-					ret);
-			break;
-		case HCLGE_MBX_SET_VLAN:
-			ret = hclge_set_vf_vlan_cfg(vport, req, &resp_msg);
-			if (ret)
-				dev_err(&hdev->pdev->dev,
-					"PF failed(%d) to config VF's VLAN\n",
-					ret);
-			break;
-		case HCLGE_MBX_SET_ALIVE:
-			ret = hclge_set_vf_alive(vport, req);
-			if (ret)
-				dev_err(&hdev->pdev->dev,
-					"PF failed(%d) to set VF's ALIVE\n",
-					ret);
-			break;
-		case HCLGE_MBX_GET_QINFO:
-			hclge_get_vf_queue_info(vport, &resp_msg);
-			break;
-		case HCLGE_MBX_GET_QDEPTH:
-			hclge_get_vf_queue_depth(vport, &resp_msg);
-			break;
-		case HCLGE_MBX_GET_BASIC_INFO:
-			hclge_get_basic_info(vport, &resp_msg);
-			break;
-		case HCLGE_MBX_GET_LINK_STATUS:
-			ret = hclge_push_vf_link_status(vport);
-			if (ret)
-				dev_err(&hdev->pdev->dev,
-					"failed to inform link stat to VF, ret = %d\n",
-					ret);
-			break;
-		case HCLGE_MBX_QUEUE_RESET:
-			ret = hclge_mbx_reset_vf_queue(vport, req, &resp_msg);
-			break;
-		case HCLGE_MBX_RESET:
-			ret = hclge_reset_vf(vport);
-			break;
-		case HCLGE_MBX_KEEP_ALIVE:
-			hclge_vf_keep_alive(vport);
-			break;
-		case HCLGE_MBX_SET_MTU:
-			ret = hclge_set_vf_mtu(vport, req);
-			if (ret)
-				dev_err(&hdev->pdev->dev,
-					"VF fail(%d) to set mtu\n", ret);
-			break;
-		case HCLGE_MBX_GET_QID_IN_PF:
-			ret = hclge_get_queue_id_in_pf(vport, req, &resp_msg);
-			break;
-		case HCLGE_MBX_GET_RSS_KEY:
-			ret = hclge_get_rss_key(vport, req, &resp_msg);
-			break;
-		case HCLGE_MBX_GET_LINK_MODE:
-			hclge_get_link_mode(vport, req);
-			break;
-		case HCLGE_MBX_GET_VF_FLR_STATUS:
-		case HCLGE_MBX_VF_UNINIT:
-			is_del = req->msg.code == HCLGE_MBX_VF_UNINIT;
-			hclge_rm_vport_all_mac_table(vport, is_del,
-						     HCLGE_MAC_ADDR_UC);
-			hclge_rm_vport_all_mac_table(vport, is_del,
-						     HCLGE_MAC_ADDR_MC);
-			hclge_rm_vport_all_vlan_table(vport, is_del);
-			break;
-		case HCLGE_MBX_GET_MEDIA_TYPE:
-			hclge_get_vf_media_type(vport, &resp_msg);
-			break;
-		case HCLGE_MBX_PUSH_LINK_STATUS:
-			hclge_handle_link_change_event(hdev, req);
-			break;
-		case HCLGE_MBX_GET_MAC_ADDR:
-			hclge_get_vf_mac_addr(vport, &resp_msg);
-			break;
-		case HCLGE_MBX_NCSI_ERROR:
-			hclge_handle_ncsi_error(hdev);
-			break;
-		case HCLGE_MBX_HANDLE_VF_TBL:
-			hclge_handle_vf_tbl(vport, req);
-			break;
-		default:
-			dev_err(&hdev->pdev->dev,
-				"un-supported mailbox message, code = %u\n",
-				req->msg.code);
-			break;
-		}
-
-		/* PF driver should not reply IMP */
-		if (hnae3_get_bit(req->mbx_need_resp, HCLGE_MBX_NEED_RESP_B) &&
-		    req->msg.code < HCLGE_MBX_GET_VF_FLR_STATUS) {
-			resp_msg.status = ret;
-			hclge_gen_resp_to_vf(vport, req, &resp_msg);
-		}
+		param.vport = &hdev->vport[req->mbx_src_vfid];
+		param.req = req;
+		hclge_mbx_request_handling(&param);
 
 		crq->desc[crq->next_to_use].flag = 0;
 		hclge_mbx_ring_ptr_move_crq(crq);
-
-		/* reinitialize ret after complete the mbx message processing */
-		ret = 0;
 	}
 
 	/* Write back CMDQ_RQ header pointer, M7 need this pointer */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 1231c34f0949..63d2be4349e3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -47,7 +47,7 @@ static int hclge_mdio_write(struct mii_bus *bus, int phyid, int regnum,
 	struct hclge_desc desc;
 	int ret;
 
-	if (test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state))
+	if (test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state))
 		return 0;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MDIO_CONFIG, false);
@@ -85,7 +85,7 @@ static int hclge_mdio_read(struct mii_bus *bus, int phyid, int regnum)
 	struct hclge_desc desc;
 	int ret;
 
-	if (test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state))
+	if (test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state))
 		return 0;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_MDIO_CONFIG, true);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index dd0750f6daa6..0f06f95b09bc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -464,7 +464,7 @@ static int hclge_ptp_create_clock(struct hclge_dev *hdev)
 	}
 
 	spin_lock_init(&ptp->lock);
-	ptp->io_base = hdev->hw.io_base + HCLGE_PTP_REG_OFFSET;
+	ptp->io_base = hdev->hw.hw.io_base + HCLGE_PTP_REG_OFFSET;
 	ptp->ts_cfg.rx_filter = HWTSTAMP_FILTER_NONE;
 	ptp->ts_cfg.tx_type = HWTSTAMP_TX_OFF;
 	hdev->ptp = ptp;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile b/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
deleted file mode 100644
index 51ff7d86ee90..000000000000
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Makefile for the HISILICON network device drivers.
-#
-
-ccflags-y := -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
-ccflags-y += -I $(srctree)/$(src)
-
-obj-$(CONFIG_HNS3_HCLGEVF) += hclgevf.o
-hclgevf-objs = hclgevf_main.o hclgevf_cmd.o hclgevf_mbx.o  hclgevf_devlink.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index bd8468c2d9a6..a41e04796b0b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -537,7 +537,8 @@ static int hclgevf_set_handle_info(struct hclgevf_dev *hdev)
 
 	nic->ae_algo = &ae_algovf;
 	nic->pdev = hdev->pdev;
-	nic->numa_node_mask = hdev->numa_node_mask;
+	bitmap_copy(nic->numa_node_mask.bits, hdev->numa_node_mask.bits,
+		    MAX_NUMNODES);
 	nic->flags |= HNAE3_SUPPORT_VF;
 	nic->kinfo.io_base = hdev->hw.io_base;
 
@@ -2588,8 +2589,8 @@ static int hclgevf_init_roce_base_info(struct hclgevf_dev *hdev)
 
 	roce->pdev = nic->pdev;
 	roce->ae_algo = nic->ae_algo;
-	roce->numa_node_mask = nic->numa_node_mask;
-
+	bitmap_copy(roce->numa_node_mask.bits, nic->numa_node_mask.bits,
+		    MAX_NUMNODES);
 	return 0;
 }
 
@@ -2721,8 +2722,7 @@ static void hclgevf_set_timer_task(struct hnae3_handle *handle, bool enable)
 	} else {
 		set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
 
-		/* flush memory to make sure DOWN is seen by service task */
-		smp_mb__before_atomic();
+		smp_mb__after_atomic(); /* flush memory to make sure DOWN is seen by service task */
 		hclgevf_flush_link_update(hdev);
 	}
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 5c7538ca36a7..2b216ac96914 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -298,7 +298,7 @@ struct hclgevf_dev {
 	u16 rss_size_max;	/* HW defined max RSS task queue */
 
 	u16 num_alloc_vport;	/* num vports this driver supports */
-	u32 numa_node_mask;
+	nodemask_t numa_node_mask;
 	u16 rx_buf_len;
 	u16 num_tx_desc;	/* desc num of per tx queue */
 	u16 num_rx_desc;	/* desc num of per rx queue */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 4dddf6ec3be8..e20182752951 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -559,12 +559,10 @@ static ssize_t rvu_dbg_qsize_write(struct file *filp,
 	u16 pcifunc;
 	int ret, lf;
 
-	cmd_buf = memdup_user(buffer, count + 1);
+	cmd_buf = memdup_user_nul(buffer, count);
 	if (IS_ERR(cmd_buf))
 		return -ENOMEM;
 
-	cmd_buf[count] = '\0';
-
 	cmd_buf_tmp = strchr(cmd_buf, '\n');
 	if (cmd_buf_tmp) {
 		*cmd_buf_tmp = '\0';
diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 3010833ddde3..8871099b99d8 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1868,8 +1868,8 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 			    struct flow_cls_offload *f)
 {
 	struct qede_arfs_fltr_node *n;
-	int min_hlen, rc = -EINVAL;
 	struct qede_arfs_tuple t;
+	int min_hlen, rc;
 
 	__qede_lock(edev);
 
@@ -1879,7 +1879,8 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse flower attribute and prepare filter */
-	if (qede_parse_flow_attr(edev, proto, f->rule, &t))
+	rc = qede_parse_flow_attr(edev, proto, f->rule, &t);
+	if (rc)
 		goto unlock;
 
 	/* Validate profile mode and number of filters */
@@ -1888,11 +1889,13 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 		DP_NOTICE(edev,
 			  "Filter configuration invalidated, filter mode=0x%x, configured mode=0x%x, filter count=0x%x\n",
 			  t.mode, edev->arfs->mode, edev->arfs->filter_count);
+		rc = -EINVAL;
 		goto unlock;
 	}
 
 	/* parse tc actions and get the vf_id */
-	if (qede_parse_actions(edev, &f->rule->action, f->common.extack))
+	rc = qede_parse_actions(edev, &f->rule->action, f->common.extack);
+	if (rc)
 		goto unlock;
 
 	if (qede_flow_find_fltr(edev, &t)) {
@@ -1998,10 +2001,9 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
 
-	if (qede_parse_flow_attr(edev, proto, flow->rule, t)) {
-		err = -EINVAL;
+	err = qede_parse_flow_attr(edev, proto, flow->rule, t);
+	if (err)
 		goto err_out;
-	}
 
 	/* Make sure location is valid and filter isn't already set */
 	err = qede_flow_spec_validate(edev, &flow->rule->action, t,
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 846ace9830d3..89e1fac07a25 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1419,6 +1419,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
+	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 54064714d73f..b223583dfb73 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -43,7 +43,7 @@
 #define SCU614		0x614 /* Disable GPIO Internal Pull-Down #1 */
 #define SCU618		0x618 /* Disable GPIO Internal Pull-Down #2 */
 #define SCU61C		0x61c /* Disable GPIO Internal Pull-Down #3 */
-#define SCU620		0x620 /* Disable GPIO Internal Pull-Down #4 */
+#define SCU630		0x630 /* Disable GPIO Internal Pull-Down #4 */
 #define SCU634		0x634 /* Disable GPIO Internal Pull-Down #5 */
 #define SCU638		0x638 /* Disable GPIO Internal Pull-Down #6 */
 #define SCU690		0x690 /* Multi-function Pin Control #24 */
@@ -2487,38 +2487,38 @@ static struct aspeed_pin_config aspeed_g6_configs[] = {
 	ASPEED_PULL_DOWN_PINCONF(D14, SCU61C, 0),
 
 	/* GPIOS7 */
-	ASPEED_PULL_DOWN_PINCONF(T24, SCU620, 23),
+	ASPEED_PULL_DOWN_PINCONF(T24, SCU630, 23),
 	/* GPIOS6 */
-	ASPEED_PULL_DOWN_PINCONF(P23, SCU620, 22),
+	ASPEED_PULL_DOWN_PINCONF(P23, SCU630, 22),
 	/* GPIOS5 */
-	ASPEED_PULL_DOWN_PINCONF(P24, SCU620, 21),
+	ASPEED_PULL_DOWN_PINCONF(P24, SCU630, 21),
 	/* GPIOS4 */
-	ASPEED_PULL_DOWN_PINCONF(R26, SCU620, 20),
+	ASPEED_PULL_DOWN_PINCONF(R26, SCU630, 20),
 	/* GPIOS3*/
-	ASPEED_PULL_DOWN_PINCONF(R24, SCU620, 19),
+	ASPEED_PULL_DOWN_PINCONF(R24, SCU630, 19),
 	/* GPIOS2 */
-	ASPEED_PULL_DOWN_PINCONF(T26, SCU620, 18),
+	ASPEED_PULL_DOWN_PINCONF(T26, SCU630, 18),
 	/* GPIOS1 */
-	ASPEED_PULL_DOWN_PINCONF(T25, SCU620, 17),
+	ASPEED_PULL_DOWN_PINCONF(T25, SCU630, 17),
 	/* GPIOS0 */
-	ASPEED_PULL_DOWN_PINCONF(R23, SCU620, 16),
+	ASPEED_PULL_DOWN_PINCONF(R23, SCU630, 16),
 
 	/* GPIOR7 */
-	ASPEED_PULL_DOWN_PINCONF(U26, SCU620, 15),
+	ASPEED_PULL_DOWN_PINCONF(U26, SCU630, 15),
 	/* GPIOR6 */
-	ASPEED_PULL_DOWN_PINCONF(W26, SCU620, 14),
+	ASPEED_PULL_DOWN_PINCONF(W26, SCU630, 14),
 	/* GPIOR5 */
-	ASPEED_PULL_DOWN_PINCONF(T23, SCU620, 13),
+	ASPEED_PULL_DOWN_PINCONF(T23, SCU630, 13),
 	/* GPIOR4 */
-	ASPEED_PULL_DOWN_PINCONF(U25, SCU620, 12),
+	ASPEED_PULL_DOWN_PINCONF(U25, SCU630, 12),
 	/* GPIOR3*/
-	ASPEED_PULL_DOWN_PINCONF(V26, SCU620, 11),
+	ASPEED_PULL_DOWN_PINCONF(V26, SCU630, 11),
 	/* GPIOR2 */
-	ASPEED_PULL_DOWN_PINCONF(V24, SCU620, 10),
+	ASPEED_PULL_DOWN_PINCONF(V24, SCU630, 10),
 	/* GPIOR1 */
-	ASPEED_PULL_DOWN_PINCONF(U24, SCU620, 9),
+	ASPEED_PULL_DOWN_PINCONF(U24, SCU630, 9),
 	/* GPIOR0 */
-	ASPEED_PULL_DOWN_PINCONF(V25, SCU620, 8),
+	ASPEED_PULL_DOWN_PINCONF(V25, SCU630, 8),
 
 	/* GPIOX7 */
 	ASPEED_PULL_DOWN_PINCONF(AB10, SCU634, 31),
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 456b72041c34..1c906fc68c1d 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -2098,13 +2098,7 @@ int pinctrl_enable(struct pinctrl_dev *pctldev)
 
 	error = pinctrl_claim_hogs(pctldev);
 	if (error) {
-		dev_err(pctldev->dev, "could not claim hogs: %i\n",
-			error);
-		pinctrl_free_pindescs(pctldev, pctldev->desc->pins,
-				      pctldev->desc->npins);
-		mutex_destroy(&pctldev->mutex);
-		kfree(pctldev);
-
+		dev_err(pctldev->dev, "could not claim hogs: %i\n", error);
 		return error;
 	}
 
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index eac55fee5281..0220228c5040 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -220,14 +220,16 @@ int pinctrl_dt_to_map(struct pinctrl *p, struct pinctrl_dev *pctldev)
 	for (state = 0; ; state++) {
 		/* Retrieve the pinctrl-* property */
 		propname = kasprintf(GFP_KERNEL, "pinctrl-%d", state);
-		if (!propname)
-			return -ENOMEM;
+		if (!propname) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		prop = of_find_property(np, propname, &size);
 		kfree(propname);
 		if (!prop) {
 			if (state == 0) {
-				of_node_put(np);
-				return -ENODEV;
+				ret = -ENODEV;
+				goto err;
 			}
 			break;
 		}
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 0fa1c36148c2..deade010270a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -79,78 +79,76 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	u32 param = pinconf_to_config_param(*config);
-	int pullup, err, reg, ret = 1;
+	int pullup, reg, err = -ENOTSUPP, ret = 1;
 	const struct mtk_pin_desc *desc;
 
-	if (pin >= hw->soc->npins) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (pin >= hw->soc->npins)
+		return -EINVAL;
+
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (hw->soc->bias_get_combo) {
-			err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
-			if (err)
-				goto out;
-			if (ret == MTK_PUPD_SET_R1R0_00)
-				ret = MTK_DISABLE;
-			if (param == PIN_CONFIG_BIAS_DISABLE) {
-				if (ret != MTK_DISABLE)
-					err = -EINVAL;
-			} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
-				if (!pullup || ret == MTK_DISABLE)
-					err = -EINVAL;
-			} else if (param == PIN_CONFIG_BIAS_PULL_DOWN) {
-				if (pullup || ret == MTK_DISABLE)
-					err = -EINVAL;
-			}
-		} else {
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_get_combo)
+			break;
+		err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
+		if (err)
+			break;
+		if (ret == MTK_PUPD_SET_R1R0_00)
+			ret = MTK_DISABLE;
+		if (param == PIN_CONFIG_BIAS_DISABLE) {
+			if (ret != MTK_DISABLE)
+				err = -EINVAL;
+		} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
+			if (!pullup || ret == MTK_DISABLE)
+				err = -EINVAL;
+		} else if (param == PIN_CONFIG_BIAS_PULL_DOWN) {
+			if (pullup || ret == MTK_DISABLE)
+				err = -EINVAL;
 		}
 		break;
 	case PIN_CONFIG_SLEW_RATE:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SR, &ret);
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-	case PIN_CONFIG_OUTPUT_ENABLE:
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_IES, &ret);
+		if (!ret)
+			err = -EINVAL;
+		break;
+	case PIN_CONFIG_OUTPUT:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &ret);
 		if (err)
-			goto out;
-		/*     CONFIG     Current direction return value
-		 * -------------  ----------------- ----------------------
-		 * OUTPUT_ENABLE       output       1 (= HW value)
-		 *                     input        0 (= HW value)
-		 * INPUT_ENABLE        output       0 (= reverse HW value)
-		 *                     input        1 (= reverse HW value)
-		 */
-		if (param == PIN_CONFIG_INPUT_ENABLE)
-			ret = !ret;
+			break;
+
+		if (!ret) {
+			err = -EINVAL;
+			break;
+		}
 
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DO, &ret);
 		break;
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &ret);
 		if (err)
-			goto out;
+			break;
 		/* return error when in output mode
 		 * because schmitt trigger only work in input mode
 		 */
 		if (ret) {
 			err = -EINVAL;
-			goto out;
+			break;
 		}
 
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SMT, &ret);
-
+		if (!ret)
+			err = -EINVAL;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		if (hw->soc->drive_get)
-			err = hw->soc->drive_get(hw, desc, &ret);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->drive_get)
+			break;
+		err = hw->soc->drive_get(hw, desc, &ret);
 		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
@@ -160,23 +158,18 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 	case MTK_PIN_CONFIG_PU_ADV:
 	case MTK_PIN_CONFIG_PD_ADV:
-		if (hw->soc->adv_pull_get) {
-			pullup = param == MTK_PIN_CONFIG_PU_ADV;
-			err = hw->soc->adv_pull_get(hw, desc, pullup, &ret);
-		} else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_pull_get)
+			break;
+		pullup = param == MTK_PIN_CONFIG_PU_ADV;
+		err = hw->soc->adv_pull_get(hw, desc, pullup, &ret);
 		break;
 	case MTK_PIN_CONFIG_DRV_ADV:
-		if (hw->soc->adv_drive_get)
-			err = hw->soc->adv_drive_get(hw, desc, &ret);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_drive_get)
+			break;
+		err = hw->soc->adv_drive_get(hw, desc, &ret);
 		break;
-	default:
-		err = -ENOTSUPP;
 	}
 
-out:
 	if (!err)
 		*config = pinconf_to_config_packed(param, ret);
 
@@ -188,54 +181,33 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	const struct mtk_pin_desc *desc;
-	int err = 0;
+	int err = -ENOTSUPP;
 	u32 reg;
 
-	if (pin >= hw->soc->npins) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (pin >= hw->soc->npins)
+		return -EINVAL;
+
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
 
 	switch ((u32)param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		if (hw->soc->bias_set_combo)
-			err = hw->soc->bias_set_combo(hw, desc, 0, MTK_DISABLE);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_set_combo)
+			break;
+		err = hw->soc->bias_set_combo(hw, desc, 0, MTK_DISABLE);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		if (hw->soc->bias_set_combo)
-			err = hw->soc->bias_set_combo(hw, desc, 1, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_set_combo)
+			break;
+		err = hw->soc->bias_set_combo(hw, desc, 1, arg);
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (hw->soc->bias_set_combo)
-			err = hw->soc->bias_set_combo(hw, desc, 0, arg);
-		else
-			err = -ENOTSUPP;
-		break;
-	case PIN_CONFIG_OUTPUT_ENABLE:
-		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
-				       MTK_DISABLE);
-		/* Keep set direction to consider the case that a GPIO pin
-		 *  does not have SMT control
-		 */
-		if (err != -ENOTSUPP)
-			goto err;
-
-		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
-				       MTK_OUTPUT);
+		if (!hw->soc->bias_set_combo)
+			break;
+		err = hw->soc->bias_set_combo(hw, desc, 0, arg);
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
 		/* regard all non-zero value as enable */
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_IES, !!arg);
-		if (err)
-			goto err;
-
-		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
-				       MTK_INPUT);
 		break;
 	case PIN_CONFIG_SLEW_RATE:
 		/* regard all non-zero value as enable */
@@ -245,7 +217,7 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DO,
 				       arg);
 		if (err)
-			goto err;
+			break;
 
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 				       MTK_OUTPUT);
@@ -257,15 +229,14 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		 */
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR, !arg);
 		if (err)
-			goto err;
+			break;
 
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, !!arg);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		if (hw->soc->drive_set)
-			err = hw->soc->drive_set(hw, desc, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->drive_set)
+			break;
+		err = hw->soc->drive_set(hw, desc, arg);
 		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
@@ -275,26 +246,19 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		break;
 	case MTK_PIN_CONFIG_PU_ADV:
 	case MTK_PIN_CONFIG_PD_ADV:
-		if (hw->soc->adv_pull_set) {
-			bool pullup;
-
-			pullup = param == MTK_PIN_CONFIG_PU_ADV;
-			err = hw->soc->adv_pull_set(hw, desc, pullup,
-						    arg);
-		} else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_pull_set)
+			break;
+		err = hw->soc->adv_pull_set(hw, desc,
+					    (param == MTK_PIN_CONFIG_PU_ADV),
+					    arg);
 		break;
 	case MTK_PIN_CONFIG_DRV_ADV:
-		if (hw->soc->adv_drive_set)
-			err = hw->soc->adv_drive_set(hw, desc, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_drive_set)
+			break;
+		err = hw->soc->adv_drive_set(hw, desc, arg);
 		break;
-	default:
-		err = -ENOTSUPP;
 	}
 
-err:
 	return err;
 }
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/meson/pinctrl-meson-a1.c
index 79f5d753d7e1..50a87d9618a8 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-a1.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
@@ -250,7 +250,7 @@ static const unsigned int pdm_dclk_x_pins[]		= { GPIOX_10 };
 static const unsigned int pdm_din2_a_pins[]		= { GPIOA_6 };
 static const unsigned int pdm_din1_a_pins[]		= { GPIOA_7 };
 static const unsigned int pdm_din0_a_pins[]		= { GPIOA_8 };
-static const unsigned int pdm_dclk_pins[]		= { GPIOA_9 };
+static const unsigned int pdm_dclk_a_pins[]		= { GPIOA_9 };
 
 /* gen_clk */
 static const unsigned int gen_clk_x_pins[]		= { GPIOX_7 };
@@ -591,7 +591,7 @@ static struct meson_pmx_group meson_a1_periphs_groups[] = {
 	GROUP(pdm_din2_a,		3),
 	GROUP(pdm_din1_a,		3),
 	GROUP(pdm_din0_a,		3),
-	GROUP(pdm_dclk,			3),
+	GROUP(pdm_dclk_a,		3),
 	GROUP(pwm_c_a,			3),
 	GROUP(pwm_b_a,			3),
 
@@ -755,7 +755,7 @@ static const char * const spi_a_groups[] = {
 
 static const char * const pdm_groups[] = {
 	"pdm_din0_x", "pdm_din1_x", "pdm_din2_x", "pdm_dclk_x", "pdm_din2_a",
-	"pdm_din1_a", "pdm_din0_a", "pdm_dclk",
+	"pdm_din1_a", "pdm_din0_a", "pdm_dclk_a",
 };
 
 static const char * const gen_clk_groups[] = {
diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index f1248faf5905..383bf19819df 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -591,7 +591,7 @@ static const struct regulator_ops mt6360_chg_otg_ops = {
 };
 
 static const struct regulator_desc mt6360_otg_rdesc = {
-	.of_match = "usb-otg-vbus",
+	.of_match = "usb-otg-vbus-regulator",
 	.name = "usb-otg-vbus",
 	.ops = &mt6360_chg_otg_ops,
 	.owner = THIS_MODULE,
diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 594bb3b8a4d1..a84afccd509f 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -193,6 +193,7 @@ static const int rt9455_voreg_values[] = {
 	4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000
 };
 
+#if IS_ENABLED(CONFIG_USB_PHY)
 /*
  * When the charger is in boost mode, REG02[7:2] represent boost output
  * voltage.
@@ -208,6 +209,7 @@ static const int rt9455_boost_voltage_values[] = {
 	5600000, 5600000, 5600000, 5600000, 5600000, 5600000, 5600000, 5600000,
 	5600000, 5600000, 5600000, 5600000, 5600000, 5600000, 5600000, 5600000,
 };
+#endif
 
 /* REG07[3:0] (VMREG) in uV */
 static const int rt9455_vmreg_values[] = {
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9b1f27f87c95..d6febb9ec60d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1872,19 +1872,24 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 		}
 	}
 
-	if (err != -EEXIST)
+	if (err != -EEXIST) {
 		regulator->debugfs = debugfs_create_dir(supply_name, rdev->debugfs);
-	if (IS_ERR(regulator->debugfs))
-		rdev_dbg(rdev, "Failed to create debugfs directory\n");
+		if (IS_ERR(regulator->debugfs)) {
+			rdev_dbg(rdev, "Failed to create debugfs directory\n");
+			regulator->debugfs = NULL;
+		}
+	}
 
-	debugfs_create_u32("uA_load", 0444, regulator->debugfs,
-			   &regulator->uA_load);
-	debugfs_create_u32("min_uV", 0444, regulator->debugfs,
-			   &regulator->voltage[PM_SUSPEND_ON].min_uV);
-	debugfs_create_u32("max_uV", 0444, regulator->debugfs,
-			   &regulator->voltage[PM_SUSPEND_ON].max_uV);
-	debugfs_create_file("constraint_flags", 0444, regulator->debugfs,
-			    regulator, &constraint_flags_fops);
+	if (regulator->debugfs) {
+		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
+				   &regulator->uA_load);
+		debugfs_create_u32("min_uV", 0444, regulator->debugfs,
+				   &regulator->voltage[PM_SUSPEND_ON].min_uV);
+		debugfs_create_u32("max_uV", 0444, regulator->debugfs,
+				   &regulator->voltage[PM_SUSPEND_ON].max_uV);
+		debugfs_create_file("constraint_flags", 0444, regulator->debugfs,
+				    regulator, &constraint_flags_fops);
+	}
 
 	/*
 	 * Check now if the regulator is an always on regulator - if
diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
index 4d34be94d166..fc464a4450dc 100644
--- a/drivers/regulator/mt6360-regulator.c
+++ b/drivers/regulator/mt6360-regulator.c
@@ -319,15 +319,15 @@ static unsigned int mt6360_regulator_of_map_mode(unsigned int hw_mode)
 	}
 }
 
-#define MT6360_REGULATOR_DESC(_name, _sname, ereg, emask, vreg,	vmask,	\
-			      mreg, mmask, streg, stmask, vranges,	\
-			      vcnts, offon_delay, irq_tbls)		\
+#define MT6360_REGULATOR_DESC(match, _name, _sname, ereg, emask, vreg,	\
+			      vmask, mreg, mmask, streg, stmask,	\
+			      vranges, vcnts, offon_delay, irq_tbls)	\
 {									\
 	.desc = {							\
 		.name = #_name,						\
 		.supply_name = #_sname,					\
 		.id =  MT6360_REGULATOR_##_name,			\
-		.of_match = of_match_ptr(#_name),			\
+		.of_match = of_match_ptr(match),			\
 		.regulators_node = of_match_ptr("regulator"),		\
 		.of_map_mode = mt6360_regulator_of_map_mode,		\
 		.owner = THIS_MODULE,					\
@@ -351,21 +351,29 @@ static unsigned int mt6360_regulator_of_map_mode(unsigned int hw_mode)
 }
 
 static const struct mt6360_regulator_desc mt6360_regulator_descs[] =  {
-	MT6360_REGULATOR_DESC(BUCK1, BUCK1_VIN, 0x117, 0x40, 0x110, 0xff, 0x117, 0x30, 0x117, 0x04,
+	MT6360_REGULATOR_DESC("buck1", BUCK1, BUCK1_VIN,
+			      0x117, 0x40, 0x110, 0xff, 0x117, 0x30, 0x117, 0x04,
 			      buck_vout_ranges, 256, 0, buck1_irq_tbls),
-	MT6360_REGULATOR_DESC(BUCK2, BUCK2_VIN, 0x127, 0x40, 0x120, 0xff, 0x127, 0x30, 0x127, 0x04,
+	MT6360_REGULATOR_DESC("buck2", BUCK2, BUCK2_VIN,
+			      0x127, 0x40, 0x120, 0xff, 0x127, 0x30, 0x127, 0x04,
 			      buck_vout_ranges, 256, 0, buck2_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO6, LDO_VIN3, 0x137, 0x40, 0x13B, 0xff, 0x137, 0x30, 0x137, 0x04,
+	MT6360_REGULATOR_DESC("ldo6", LDO6, LDO_VIN3,
+			      0x137, 0x40, 0x13B, 0xff, 0x137, 0x30, 0x137, 0x04,
 			      ldo_vout_ranges1, 256, 0, ldo6_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO7, LDO_VIN3, 0x131, 0x40, 0x135, 0xff, 0x131, 0x30, 0x131, 0x04,
+	MT6360_REGULATOR_DESC("ldo7", LDO7, LDO_VIN3,
+			      0x131, 0x40, 0x135, 0xff, 0x131, 0x30, 0x131, 0x04,
 			      ldo_vout_ranges1, 256, 0, ldo7_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO1, LDO_VIN1, 0x217, 0x40, 0x21B, 0xff, 0x217, 0x30, 0x217, 0x04,
+	MT6360_REGULATOR_DESC("ldo1", LDO1, LDO_VIN1,
+			      0x217, 0x40, 0x21B, 0xff, 0x217, 0x30, 0x217, 0x04,
 			      ldo_vout_ranges2, 256, 0, ldo1_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO2, LDO_VIN1, 0x211, 0x40, 0x215, 0xff, 0x211, 0x30, 0x211, 0x04,
+	MT6360_REGULATOR_DESC("ldo2", LDO2, LDO_VIN1,
+			      0x211, 0x40, 0x215, 0xff, 0x211, 0x30, 0x211, 0x04,
 			      ldo_vout_ranges2, 256, 0, ldo2_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO3, LDO_VIN1, 0x205, 0x40, 0x209, 0xff, 0x205, 0x30, 0x205, 0x04,
+	MT6360_REGULATOR_DESC("ldo3", LDO3, LDO_VIN1,
+			      0x205, 0x40, 0x209, 0xff, 0x205, 0x30, 0x205, 0x04,
 			      ldo_vout_ranges2, 256, 100, ldo3_irq_tbls),
-	MT6360_REGULATOR_DESC(LDO5, LDO_VIN2, 0x20B, 0x40, 0x20F, 0x7f, 0x20B, 0x30, 0x20B, 0x04,
+	MT6360_REGULATOR_DESC("ldo5", LDO5, LDO_VIN2,
+			      0x20B, 0x40, 0x20F, 0x7f, 0x20B, 0x30, 0x20B, 0x04,
 			      ldo_vout_ranges3, 128, 100, ldo5_irq_tbls),
 };
 
diff --git a/drivers/s390/cio/cio_inject.c b/drivers/s390/cio/cio_inject.c
index 8613fa937237..a2e771ebae8e 100644
--- a/drivers/s390/cio/cio_inject.c
+++ b/drivers/s390/cio/cio_inject.c
@@ -95,7 +95,7 @@ static ssize_t crw_inject_write(struct file *file, const char __user *buf,
 		return -EINVAL;
 	}
 
-	buffer = vmemdup_user(buf, lbuf);
+	buffer = memdup_user_nul(buf, lbuf);
 	if (IS_ERR(buffer))
 		return -ENOMEM;
 
diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index e8c360879883..71464e9ad4f8 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -545,7 +545,6 @@ static inline bool qeth_out_queue_is_empty(struct qeth_qdio_out_q *queue)
 struct qeth_qdio_info {
 	atomic_t state;
 	/* input */
-	int no_in_queues;
 	struct qeth_qdio_q *in_q;
 	struct qeth_qdio_q *c_q;
 	struct qeth_qdio_buffer_pool in_buf_pool;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c1346c4e2242..5c69cba6459f 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -354,8 +354,8 @@ static int qeth_cq_init(struct qeth_card *card)
 		qdio_reset_buffers(card->qdio.c_q->qdio_bufs,
 				   QDIO_MAX_BUFFERS_PER_Q);
 		card->qdio.c_q->next_buf_to_init = 127;
-		rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT,
-			     card->qdio.no_in_queues - 1, 0, 127, NULL);
+		rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 1, 0, 127,
+			     NULL);
 		if (rc) {
 			QETH_CARD_TEXT_(card, 2, "1err%d", rc);
 			goto out;
@@ -366,35 +366,33 @@ static int qeth_cq_init(struct qeth_card *card)
 	return rc;
 }
 
+static void qeth_free_cq(struct qeth_card *card)
+{
+	if (card->qdio.c_q) {
+		qeth_free_qdio_queue(card->qdio.c_q);
+		card->qdio.c_q = NULL;
+	}
+}
+
 static int qeth_alloc_cq(struct qeth_card *card)
 {
 	if (card->options.cq == QETH_CQ_ENABLED) {
 		QETH_CARD_TEXT(card, 2, "cqon");
-		card->qdio.c_q = qeth_alloc_qdio_queue();
 		if (!card->qdio.c_q) {
-			dev_err(&card->gdev->dev, "Failed to create completion queue\n");
-			return -ENOMEM;
+			card->qdio.c_q = qeth_alloc_qdio_queue();
+			if (!card->qdio.c_q) {
+				dev_err(&card->gdev->dev,
+					"Failed to create completion queue\n");
+				return -ENOMEM;
+			}
 		}
-
-		card->qdio.no_in_queues = 2;
 	} else {
 		QETH_CARD_TEXT(card, 2, "nocq");
-		card->qdio.c_q = NULL;
-		card->qdio.no_in_queues = 1;
+		qeth_free_cq(card);
 	}
-	QETH_CARD_TEXT_(card, 2, "iqc%d", card->qdio.no_in_queues);
 	return 0;
 }
 
-static void qeth_free_cq(struct qeth_card *card)
-{
-	if (card->qdio.c_q) {
-		--card->qdio.no_in_queues;
-		qeth_free_qdio_queue(card->qdio.c_q);
-		card->qdio.c_q = NULL;
-	}
-}
-
 static enum iucv_tx_notify qeth_compute_cq_notification(int sbalf15,
 							int delayed)
 {
@@ -1492,7 +1490,6 @@ static void qeth_init_qdio_info(struct qeth_card *card)
 	card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
 
 	/* inbound */
-	card->qdio.no_in_queues = 1;
 	card->qdio.in_buf_size = QETH_IN_BUF_SIZE_DEFAULT;
 	if (IS_IQD(card))
 		card->qdio.init_pool.buf_count = QETH_IN_BUF_COUNT_HSDEFAULT;
@@ -2592,6 +2589,10 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 2, "allcqdbf");
 
+	/* completion */
+	if (qeth_alloc_cq(card))
+		goto out_err;
+
 	if (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED,
 		QETH_QDIO_ALLOCATED) != QETH_QDIO_UNINITIALIZED)
 		return 0;
@@ -2632,10 +2633,6 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
 		queue->priority = QETH_QIB_PQUE_PRIO_DEFAULT;
 	}
 
-	/* completion */
-	if (qeth_alloc_cq(card))
-		goto out_freeoutq;
-
 	return 0;
 
 out_freeoutq:
@@ -2649,6 +2646,8 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
 	card->qdio.in_q = NULL;
 out_nomem:
 	atomic_set(&card->qdio.state, QETH_QDIO_UNINITIALIZED);
+	qeth_free_cq(card);
+out_err:
 	return -ENOMEM;
 }
 
@@ -2656,11 +2655,12 @@ static void qeth_free_qdio_queues(struct qeth_card *card)
 {
 	int i, j;
 
+	qeth_free_cq(card);
+
 	if (atomic_xchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED) ==
 		QETH_QDIO_UNINITIALIZED)
 		return;
 
-	qeth_free_cq(card);
 	for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j) {
 		if (card->qdio.in_q->bufs[j].rx_skb)
 			dev_kfree_skb_any(card->qdio.in_q->bufs[j].rx_skb);
@@ -3713,24 +3713,11 @@ static void qeth_qdio_poll(struct ccw_device *cdev, unsigned long card_ptr)
 
 int qeth_configure_cq(struct qeth_card *card, enum qeth_cq cq)
 {
-	int rc;
-
-	if (card->options.cq ==  QETH_CQ_NOTAVAILABLE) {
-		rc = -1;
-		goto out;
-	} else {
-		if (card->options.cq == cq) {
-			rc = 0;
-			goto out;
-		}
-
-		qeth_free_qdio_queues(card);
-		card->options.cq = cq;
-		rc = 0;
-	}
-out:
-	return rc;
+	if (card->options.cq == QETH_CQ_NOTAVAILABLE)
+		return -1;
 
+	card->options.cq = cq;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(qeth_configure_cq);
 
@@ -5173,6 +5160,7 @@ static int qeth_qdio_establish(struct qeth_card *card)
 	struct qdio_buffer **in_sbal_ptrs[QETH_MAX_IN_QUEUES];
 	struct qeth_qib_parms *qib_parms = NULL;
 	struct qdio_initialize init_data;
+	unsigned int no_input_qs = 1;
 	unsigned int i;
 	int rc = 0;
 
@@ -5187,8 +5175,10 @@ static int qeth_qdio_establish(struct qeth_card *card)
 	}
 
 	in_sbal_ptrs[0] = card->qdio.in_q->qdio_bufs;
-	if (card->options.cq == QETH_CQ_ENABLED)
+	if (card->options.cq == QETH_CQ_ENABLED) {
 		in_sbal_ptrs[1] = card->qdio.c_q->qdio_bufs;
+		no_input_qs++;
+	}
 
 	for (i = 0; i < card->qdio.no_out_queues; i++)
 		out_sbal_ptrs[i] = card->qdio.out_qs[i]->qdio_bufs;
@@ -5198,7 +5188,7 @@ static int qeth_qdio_establish(struct qeth_card *card)
 							  QDIO_QETH_QFMT;
 	init_data.qib_param_field_format = 0;
 	init_data.qib_param_field	 = (void *)qib_parms;
-	init_data.no_input_qs            = card->qdio.no_in_queues;
+	init_data.no_input_qs		 = no_input_qs;
 	init_data.no_output_qs           = card->qdio.no_out_queues;
 	init_data.input_handler		 = qeth_qdio_input_handler;
 	init_data.output_handler	 = qeth_qdio_output_handler;
diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
index 9200b718085c..5015d9b0817a 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -833,7 +833,6 @@ static void bnx2fc_free_session_resc(struct bnx2fc_hba *hba,
 
 	BNX2FC_TGT_DBG(tgt, "Freeing up session resources\n");
 
-	spin_lock_bh(&tgt->cq_lock);
 	ctx_base_ptr = tgt->ctx_base;
 	tgt->ctx_base = NULL;
 
@@ -889,7 +888,6 @@ static void bnx2fc_free_session_resc(struct bnx2fc_hba *hba,
 				    tgt->sq, tgt->sq_dma);
 		tgt->sq = NULL;
 	}
-	spin_unlock_bh(&tgt->cq_lock);
 
 	if (ctx_base_ptr)
 		iounmap(ctx_base_ptr);
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 65ac952b767f..194825ff1ee8 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1341,7 +1341,6 @@ struct lpfc_hba {
 	unsigned long bit_flags;
 #define	FABRIC_COMANDS_BLOCKED	0
 	atomic_t num_rsrc_err;
-	atomic_t num_cmd_success;
 	unsigned long last_rsrc_error_time;
 	unsigned long last_ramp_down_time;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 4e0c0b273e5f..2ff8ace6f78f 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2539,9 +2539,9 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		/* No concern about the role change on the nvme remoteport.
 		 * The transport will update it.
 		 */
-		spin_lock_irq(&vport->phba->hbalock);
+		spin_lock_irq(&ndlp->lock);
 		ndlp->fc4_xpt_flags |= NVME_XPT_UNREG_WAIT;
-		spin_unlock_irq(&vport->phba->hbalock);
+		spin_unlock_irq(&ndlp->lock);
 
 		/* Don't let the host nvme transport keep sending keep-alives
 		 * on this remoteport. Vport is unloading, no recovery. The
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 6d1a3cbd6b3c..d9fb5e09fb53 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -231,11 +231,10 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
 	struct Scsi_Host  *shost;
 	struct scsi_device *sdev;
 	unsigned long new_queue_depth;
-	unsigned long num_rsrc_err, num_cmd_success;
+	unsigned long num_rsrc_err;
 	int i;
 
 	num_rsrc_err = atomic_read(&phba->num_rsrc_err);
-	num_cmd_success = atomic_read(&phba->num_cmd_success);
 
 	/*
 	 * The error and success command counters are global per
@@ -250,20 +249,16 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
 		for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
 			shost = lpfc_shost_from_vport(vports[i]);
 			shost_for_each_device(sdev, shost) {
-				new_queue_depth =
-					sdev->queue_depth * num_rsrc_err /
-					(num_rsrc_err + num_cmd_success);
-				if (!new_queue_depth)
-					new_queue_depth = sdev->queue_depth - 1;
+				if (num_rsrc_err >= sdev->queue_depth)
+					new_queue_depth = 1;
 				else
 					new_queue_depth = sdev->queue_depth -
-								new_queue_depth;
+						num_rsrc_err;
 				scsi_change_queue_depth(sdev, new_queue_depth);
 			}
 		}
 	lpfc_destroy_vport_work_array(phba, vports);
 	atomic_set(&phba->num_rsrc_err, 0);
-	atomic_set(&phba->num_cmd_success, 0);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index da9a1f72d938..b1071226e27f 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -651,10 +651,6 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	lpfc_free_sysfs_attr(vport);
 	lpfc_debugfs_terminate(vport);
 
-	/* Remove FC host to break driver binding. */
-	fc_remove_host(shost);
-	scsi_remove_host(shost);
-
 	/* Send the DA_ID and Fabric LOGO to cleanup Nameserver entries. */
 	ndlp = lpfc_findnode_did(vport, Fabric_DID);
 	if (!ndlp)
@@ -700,6 +696,10 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 
 skip_logo:
 
+	/* Remove FC host to break driver binding. */
+	fc_remove_host(shost);
+	scsi_remove_host(shost);
+
 	lpfc_cleanup(vport);
 
 	/* Remove scsi host now.  The nodes are cleaned up. */
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 21519ce05bdb..286997adb6ea 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1376,7 +1376,11 @@ static void qcom_slim_ngd_up_worker(struct work_struct *work)
 	ctrl = container_of(work, struct qcom_slim_ngd_ctrl, ngd_up_work);
 
 	/* Make sure qmi service is up before continuing */
-	wait_for_completion_interruptible(&ctrl->qmi_up);
+	if (!wait_for_completion_interruptible_timeout(&ctrl->qmi_up,
+						       msecs_to_jiffies(MSEC_PER_SEC))) {
+		dev_err(ctrl->dev, "QMI wait timeout\n");
+		return;
+	}
 
 	mutex_lock(&ctrl->ssr_lock);
 	qcom_slim_ngd_enable(ctrl, true);
diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 525cc0143a30..54730e93fba4 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -151,8 +151,6 @@ static const struct debugfs_reg32 hisi_spi_regs[] = {
 	HISI_SPI_DBGFS_REG("ENR", HISI_SPI_ENR),
 	HISI_SPI_DBGFS_REG("FIFOC", HISI_SPI_FIFOC),
 	HISI_SPI_DBGFS_REG("IMR", HISI_SPI_IMR),
-	HISI_SPI_DBGFS_REG("DIN", HISI_SPI_DIN),
-	HISI_SPI_DBGFS_REG("DOUT", HISI_SPI_DOUT),
 	HISI_SPI_DBGFS_REG("SR", HISI_SPI_SR),
 	HISI_SPI_DBGFS_REG("RISR", HISI_SPI_RISR),
 	HISI_SPI_DBGFS_REG("ISR", HISI_SPI_ISR),
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 023bd4516a68..30ce3451bc6b 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3566,6 +3566,8 @@ static int __init target_core_init_configfs(void)
 {
 	struct configfs_subsystem *subsys = &target_core_fabrics;
 	struct t10_alua_lu_gp *lu_gp;
+	struct cred *kern_cred;
+	const struct cred *old_cred;
 	int ret;
 
 	pr_debug("TARGET_CORE[0]: Loading Generic Kernel Storage"
@@ -3642,11 +3644,21 @@ static int __init target_core_init_configfs(void)
 	if (ret < 0)
 		goto out;
 
+	/* We use the kernel credentials to access the target directory */
+	kern_cred = prepare_kernel_cred(&init_task);
+	if (!kern_cred) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	old_cred = override_creds(kern_cred);
 	target_init_dbroot();
+	revert_creds(old_cred);
+	put_cred(kern_cred);
 
 	return 0;
 
 out:
+	target_xcopy_release_pt();
 	configfs_unregister_subsystem(subsys);
 	core_dev_release_virtual_lun0();
 	rd_module_exit();
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a603e8a54196..7bb3f81ac3b3 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5049,9 +5049,10 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	}
 	if (usb_endpoint_maxp(&udev->ep0.desc) == i) {
 		;	/* Initial ep0 maxpacket guess is right */
-	} else if ((udev->speed == USB_SPEED_FULL ||
+	} else if (((udev->speed == USB_SPEED_FULL ||
 				udev->speed == USB_SPEED_HIGH) &&
-			(i == 8 || i == 16 || i == 32 || i == 64)) {
+			(i == 8 || i == 16 || i == 32 || i == 64)) ||
+			(udev->speed >= USB_SPEED_SUPER && i > 0)) {
 		/* Initial guess is wrong; use the descriptor's value */
 		if (udev->speed == USB_SPEED_FULL)
 			dev_dbg(&udev->dev, "ep0 maxpacket = %d\n", i);
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0f0269d28c37..a469d0524789 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -102,6 +102,27 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 	return 0;
 }
 
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	if (enable && !dwc->dis_u3_susphy_quirk)
+		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+	else
+		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (enable && !dwc->dis_u2_susphy_quirk)
+		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+	else
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+}
+
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
@@ -593,11 +614,8 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
  */
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
-	unsigned int hw_mode;
 	u32 reg;
 
-	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
 	/*
@@ -607,21 +625,16 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
 
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
-	 * to '0' during coreConsultant configuration. So default value
-	 * will be '0' when the core is reset. Application needs to set it
-	 * to '1' after the core initialization is completed.
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
+	 * So default value will be '0' when the core is reset. Application
+	 * needs to set it to '1' after the core initialization is completed.
+	 *
+	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
+	 * cleared after power-on reset, and it can be set after core
+	 * initialization.
 	 */
-	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
-		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-
-	/*
-	 * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be cleared after
-	 * power-on reset, and it can be set after core initialization, which is
-	 * after device soft-reset during initialization.
-	 */
-	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
-		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+	reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
@@ -647,9 +660,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->tx_de_emphasis_quirk)
 		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_de_emphasis);
 
-	if (dwc->dis_u3_susphy_quirk)
-		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
-
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
@@ -697,24 +707,15 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	}
 
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
-	 * '0' during coreConsultant configuration. So default value will
-	 * be '0' when the core is reset. Application needs to set it to
-	 * '1' after the core initialization is completed.
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
+	 * So default value will be '0' when the core is reset. Application
+	 * needs to set it to '1' after the core initialization is completed.
+	 *
+	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
+	 * after power-on reset, and it can be set after core initialization.
 	 */
-	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
-		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-
-	/*
-	 * For DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared after
-	 * power-on reset, and it can be set after core initialization, which is
-	 * after device soft-reset during initialization.
-	 */
-	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-
-	if (dwc->dis_u2_susphy_quirk)
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	if (dwc->dis_enblslpm_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
@@ -996,21 +997,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err1;
 
-	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
-	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
-		if (!dwc->dis_u3_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
-		}
-
-		if (!dwc->dis_u2_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-		}
-	}
-
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d64f7edc70c1..8c8e17cc1344 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1517,6 +1517,7 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc);
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
 
 int dwc3_core_soft_reset(struct dwc3 *dwc);
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
 
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 86cf3b2b66e9..af35278a5e8f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2775,6 +2775,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
+	dwc3_enable_susphy(dwc, true);
 
 	return 0;
 
@@ -4512,6 +4513,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
+	dwc3_enable_susphy(dwc, false);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 012b54cb847f..9adcf3a7e978 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -9,9 +9,30 @@
 
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
 
+#include "../host/xhci-plat.h"
 #include "core.h"
 
+static void dwc3_xhci_plat_start(struct usb_hcd *hcd)
+{
+	struct platform_device *pdev;
+	struct dwc3 *dwc;
+
+	if (!usb_hcd_is_primary_hcd(hcd))
+		return;
+
+	pdev = to_platform_device(hcd->self.controller);
+	dwc = dev_get_drvdata(pdev->dev.parent);
+
+	dwc3_enable_susphy(dwc, true);
+}
+
+static const struct xhci_plat_priv dwc3_xhci_plat_quirk = {
+	.plat_start = dwc3_xhci_plat_start,
+};
+
 static int dwc3_host_get_irq(struct dwc3 *dwc)
 {
 	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
@@ -117,6 +138,11 @@ int dwc3_host_init(struct dwc3 *dwc)
 		}
 	}
 
+	ret = platform_device_add_data(xhci, &dwc3_xhci_plat_quirk,
+				       sizeof(struct xhci_plat_priv));
+	if (ret)
+		goto err;
+
 	ret = platform_device_add(xhci);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register xHCI device\n");
@@ -131,6 +157,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 void dwc3_host_exit(struct dwc3 *dwc)
 {
+	dwc3_enable_susphy(dwc, false);
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci = NULL;
 }
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index edce0a1bdddf..3f035e905b24 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1978,7 +1978,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			buf[5] = 0x01;
 			switch (ctrl->bRequestType & USB_RECIP_MASK) {
 			case USB_RECIP_DEVICE:
-				if (w_index != 0x4 || (w_value >> 8))
+				if (w_index != 0x4 || (w_value & 0xff))
 					break;
 				buf[6] = w_index;
 				/* Number of ext compat interfaces */
@@ -1994,9 +1994,9 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				}
 				break;
 			case USB_RECIP_INTERFACE:
-				if (w_index != 0x5 || (w_value >> 8))
+				if (w_index != 0x5 || (w_value & 0xff))
 					break;
-				interface = w_value & 0xFF;
+				interface = w_value >> 8;
 				if (interface >= MAX_CONFIG_INTERFACES ||
 				    !os_desc_cfg->interface[interface])
 					break;
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 73ad9c3acc33..a4367a43cdd8 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3414,7 +3414,7 @@ static int ffs_func_setup(struct usb_function *f,
 	__ffs_event_add(ffs, FUNCTIONFS_SETUP);
 	spin_unlock_irqrestore(&ffs->ev.waitq.lock, flags);
 
-	return creq->wLength == 0 ? USB_GADGET_DELAYED_STATUS : 0;
+	return ffs->ev.setup.wLength == 0 ? USB_GADGET_DELAYED_STATUS : 0;
 }
 
 static bool ffs_func_req_match(struct usb_function *f,
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 1f5e69314a17..90185d1df20c 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -890,6 +890,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	/* Check for an all 1's result which is a typical consequence
 	 * of dead, unclocked, or unplugged (CardBus...) devices
 	 */
+again:
 	if (ints == ~(u32)0) {
 		ohci->rh_state = OHCI_RH_HALTED;
 		ohci_dbg (ohci, "device removed!\n");
@@ -984,6 +985,13 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	}
 	spin_unlock(&ohci->lock);
 
+	/* repeat until all enabled interrupts are handled */
+	if (ohci->rh_state != OHCI_RH_HALTED) {
+		ints = ohci_readl(ohci, &regs->intrstatus);
+		if (ints && (ints & ohci_readl(ohci, &regs->intrenable)))
+			goto again;
+	}
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 561d0b7bce09..29f15298e315 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -8,7 +8,9 @@
 #ifndef _XHCI_PLAT_H
 #define _XHCI_PLAT_H
 
-#include "xhci.h"	/* for hcd_to_xhci() */
+struct device;
+struct platform_device;
+struct usb_hcd;
 
 struct xhci_plat_priv {
 	const char *firmware_name;
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 985e512c0e65..cb6458ec042c 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -854,7 +854,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num)
 	struct ucsi_connector *con = &ucsi->connector[num - 1];
 
 	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
-		dev_dbg(ucsi->dev, "Bogus connector change event\n");
+		dev_dbg(ucsi->dev, "Early connector change event\n");
 		return;
 	}
 
@@ -1241,6 +1241,7 @@ static int ucsi_init(struct ucsi *ucsi)
 {
 	struct ucsi_connector *con;
 	u64 command, ntfy;
+	u32 cci;
 	int ret;
 	int i;
 
@@ -1292,6 +1293,15 @@ static int ucsi_init(struct ucsi *ucsi)
 		goto err_unregister;
 
 	ucsi->ntfy = ntfy;
+
+	mutex_lock(&ucsi->ppm_lock);
+	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	mutex_unlock(&ucsi->ppm_lock);
+	if (ret)
+		return ret;
+	if (UCSI_CCI_CONNECTOR(cci))
+		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+
 	return 0;
 
 err_unregister:
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 7437b185fa8e..0c84d414660c 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -660,6 +660,7 @@ const struct file_operations v9fs_file_operations = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -701,4 +702,5 @@ const struct file_operations v9fs_mmap_file_operations_dotl = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 0d9b7d453a87..ef103ef392ee 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -87,7 +87,7 @@ static int p9mode2perm(struct v9fs_session_info *v9ses,
 	int res;
 	int mode = stat->mode;
 
-	res = mode & S_IALLUGO;
+	res = mode & 0777; /* S_IRWXUGO */
 	if (v9fs_proto_dotu(v9ses)) {
 		if ((mode & P9_DMSETUID) == P9_DMSETUID)
 			res |= S_ISUID;
@@ -178,6 +178,9 @@ int v9fs_uflags2omode(int uflags, int extended)
 		break;
 	}
 
+	if (uflags & O_TRUNC)
+		ret |= P9_OTRUNC;
+
 	if (extended) {
 		if (uflags & O_EXCL)
 			ret |= P9_OEXCL;
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 7449f7fd47d2..51ac2653984a 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -340,6 +340,7 @@ static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
 	.free_inode = v9fs_free_inode,
 	.statfs = simple_statfs,
+	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c7d8a18daaf5..07c6ab4ba0d4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2261,7 +2261,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		 */
 		if (*bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
-			btrfs_delalloc_release_metadata(inode, len, false);
+			btrfs_delalloc_release_metadata(inode, len, true);
 
 		/* For sanity tests. */
 		if (btrfs_is_testing(fs_info))
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f1ef176a6424..c2842e892e4e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7612,8 +7612,8 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	sctx->waiting_dir_moves = RB_ROOT;
 	sctx->orphan_dirs = RB_ROOT;
 
-	sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
-				     arg->clone_sources_count + 1,
+	sctx->clone_roots = kvcalloc(arg->clone_sources_count + 1,
+				     sizeof(*sctx->clone_roots),
 				     GFP_KERNEL);
 	if (!sctx->clone_roots) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 99cdd1d6a4bf..a9b794c47159 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1424,6 +1424,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
+			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
@@ -1448,7 +1449,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			if (ret2)
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
-			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 36e77956c63f..b5e2daf538d4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1260,25 +1260,32 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
 	struct btrfs_device *tmp_device;
+	int ret = 0;
 
 	flags |= FMODE_EXCL;
 
 	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
 				 dev_list) {
-		int ret;
+		int ret2;
 
-		ret = btrfs_open_one_device(fs_devices, device, flags, holder);
-		if (ret == 0 &&
+		ret2 = btrfs_open_one_device(fs_devices, device, flags, holder);
+		if (ret2 == 0 &&
 		    (!latest_dev || device->generation > latest_dev->generation)) {
 			latest_dev = device;
-		} else if (ret == -ENODATA) {
+		} else if (ret2 == -ENODATA) {
 			fs_devices->num_devices--;
 			list_del(&device->dev_list);
 			btrfs_free_device(device);
 		}
+		if (ret == 0 && ret2 != 0)
+			ret = ret2;
 	}
-	if (fs_devices->open_devices == 0)
+
+	if (fs_devices->open_devices == 0) {
+		if (ret)
+			return ret;
 		return -EINVAL;
+	}
 
 	fs_devices->opened = 1;
 	fs_devices->latest_dev = latest_dev;
@@ -3367,6 +3374,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			 * alignment and size).
 			 */
 			ret = -EUCLEAN;
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto error;
 		}
 
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 0ec1eaf33833..d2011c3c33fc 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1704,7 +1704,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	struct buffer_head *dibh, *bh;
 	struct gfs2_holder rd_gh;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
-	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
+	unsigned int bsize = 1 << bsize_shift;
+	u64 lblock = (offset + bsize - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
 	unsigned int start_aligned, end_aligned;
@@ -1715,7 +1716,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
-	if (offset >= maxsize) {
+	if (offset + bsize - 1 >= maxsize) {
 		/*
 		 * The starting point lies beyond the allocated meta-data;
 		 * there are no blocks do deallocate.
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 11b201e6ee44..63b01f7d9703 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -167,20 +167,17 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	int rc;
 	bool is_chained = false;
 
-	if (conn->ops->allocate_rsp_buf(work))
-		return;
-
 	if (conn->ops->is_transform_hdr &&
 	    conn->ops->is_transform_hdr(work->request_buf)) {
 		rc = conn->ops->decrypt_req(work);
-		if (rc < 0) {
-			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
-			goto send;
-		}
-
+		if (rc < 0)
+			return;
 		work->encrypted = true;
 	}
 
+	if (conn->ops->allocate_rsp_buf(work))
+		return;
+
 	rc = conn->ops->init_rsp_hdr(work);
 	if (rc) {
 		/* either uid or tid is not correct */
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 86b1fb43104e..57f59172d821 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -536,6 +536,10 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	if (cmd == SMB2_QUERY_INFO_HE) {
 		struct smb2_query_info_req *req;
 
+		if (get_rfc1002_len(work->request_buf) <
+		    offsetof(struct smb2_query_info_req, OutputBufferLength))
+			return -EINVAL;
+
 		req = smb2_get_msg(work->request_buf);
 		if ((req->InfoType == SMB2_O_INFO_FILE &&
 		     (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 173a488bfeee..7afb2412c4d4 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -745,10 +745,15 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out4;
 	}
 
+	/*
+	 * explicitly handle file overwrite case, for compatibility with
+	 * filesystems that may not support rename flags (e.g: fuse)
+	 */
 	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
 		err = -EEXIST;
 		goto out4;
 	}
+	flags &= ~(RENAME_NOREPLACE);
 
 	if (old_child == trap) {
 		err = -EINVAL;
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 090b16890e3d..9e3a3570efc0 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -73,7 +73,6 @@ const struct rpc_program nfs_program = {
 	.number			= NFS_PROGRAM,
 	.nrvers			= ARRAY_SIZE(nfs_version),
 	.version		= nfs_version,
-	.stats			= &nfs_rpcstat,
 	.pipe_dir_name		= NFS_PIPE_DIRNAME,
 };
 
@@ -500,6 +499,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 			  const struct nfs_client_initdata *cl_init,
 			  rpc_authflavor_t flavor)
 {
+	struct nfs_net		*nn = net_generic(clp->cl_net, nfs_net_id);
 	struct rpc_clnt		*clnt = NULL;
 	struct rpc_create_args args = {
 		.net		= clp->cl_net,
@@ -511,6 +511,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		.servername	= clp->cl_hostname,
 		.nodename	= cl_init->nodename,
 		.program	= &nfs_program,
+		.stats		= &nn->rpcstats,
 		.version	= clp->rpc_ops->version,
 		.authflavor	= flavor,
 		.cred		= cl_init->cred,
@@ -1129,6 +1130,8 @@ void nfs_clients_init(struct net *net)
 #endif
 	spin_lock_init(&nn->nfs_client_lock);
 	nn->boot_time = ktime_get_real();
+	memset(&nn->rpcstats, 0, sizeof(nn->rpcstats));
+	nn->rpcstats.program = &nfs_program;
 
 	nfs_netns_sysfs_setup(nn, net);
 }
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index d8f01d222c49..48ade92d4ce8 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2360,12 +2360,21 @@ EXPORT_SYMBOL_GPL(nfs_net_id);
 
 static int nfs_net_init(struct net *net)
 {
+	struct nfs_net *nn = net_generic(net, nfs_net_id);
+
 	nfs_clients_init(net);
+
+	if (!rpc_proc_register(net, &nn->rpcstats)) {
+		nfs_clients_exit(net);
+		return -ENOMEM;
+	}
+
 	return nfs_fs_proc_net_init(net);
 }
 
 static void nfs_net_exit(struct net *net)
 {
+	rpc_proc_unregister(net, "nfs");
 	nfs_fs_proc_net_exit(net);
 	nfs_clients_exit(net);
 }
@@ -2424,15 +2433,12 @@ static int __init init_nfs_fs(void)
 	if (err)
 		goto out1;
 
-	rpc_proc_register(&init_net, &nfs_rpcstat);
-
 	err = register_nfs_fs();
 	if (err)
 		goto out0;
 
 	return 0;
 out0:
-	rpc_proc_unregister(&init_net, "nfs");
 	nfs_destroy_directcache();
 out1:
 	nfs_destroy_writepagecache();
@@ -2465,7 +2471,6 @@ static void __exit exit_nfs_fs(void)
 	nfs_destroy_nfspagecache();
 	nfs_fscache_unregister();
 	unregister_pernet_subsys(&nfs_net_ops);
-	rpc_proc_unregister(&init_net, "nfs");
 	unregister_nfs_fs();
 	nfs_fs_proc_exit();
 	nfsiod_stop();
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2ceb4b98ec15..d0965b4676a5 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -428,8 +428,6 @@ int nfs_try_get_tree(struct fs_context *);
 int nfs_get_tree_common(struct fs_context *);
 void nfs_kill_super(struct super_block *);
 
-extern struct rpc_stat nfs_rpcstat;
-
 extern int __init register_nfs_fs(void);
 extern void __exit unregister_nfs_fs(void);
 extern bool nfs_sb_active(struct super_block *sb);
diff --git a/fs/nfs/netns.h b/fs/nfs/netns.h
index c8374f74dce1..a68b21603ea9 100644
--- a/fs/nfs/netns.h
+++ b/fs/nfs/netns.h
@@ -9,6 +9,7 @@
 #include <linux/nfs4.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/sunrpc/stats.h>
 
 struct bl_dev_msg {
 	int32_t status;
@@ -34,6 +35,7 @@ struct nfs_net {
 	struct nfs_netns_client *nfs_client;
 	spinlock_t nfs_client_lock;
 	ktime_t boot_time;
+	struct rpc_stat rpcstats;
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *proc_nfsfs;
 #endif
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 74a26cabc084..4236de05a8e7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1651,17 +1651,17 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
 struct btf *bpf_get_btf_vmlinux(void);
 
 /* Map specifics */
-struct xdp_buff;
+struct xdp_frame;
 struct sk_buff;
 struct bpf_dtab_netdev;
 struct bpf_cpu_map_entry;
 
 void __dev_flush(void);
-int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
-int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
+int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
-int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
+int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 			  struct bpf_map *map, bool exclude_ingress);
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 			     struct bpf_prog *xdp_prog);
@@ -1670,7 +1670,7 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 			   bool exclude_ingress);
 
 void __cpu_map_flush(void);
-int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_buff *xdp,
+int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
 int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 			     struct sk_buff *skb);
@@ -1823,26 +1823,26 @@ static inline void __dev_flush(void)
 {
 }
 
-struct xdp_buff;
+struct xdp_frame;
 struct bpf_dtab_netdev;
 struct bpf_cpu_map_entry;
 
 static inline
-int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
 	return 0;
 }
 
 static inline
-int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
+int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
 	return 0;
 }
 
 static inline
-int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
+int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 			  struct bpf_map *map, bool exclude_ingress)
 {
 	return 0;
@@ -1870,7 +1870,7 @@ static inline void __cpu_map_flush(void)
 }
 
 static inline int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu,
-				  struct xdp_buff *xdp,
+				  struct xdp_frame *xdpf,
 				  struct net_device *dev_rx)
 {
 	return 0;
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 6659d0369ec5..9d276655cc25 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -631,11 +631,4 @@ u64 dma_fence_context_alloc(unsigned num);
 			##args);					\
 	} while (0)
 
-#define DMA_FENCE_WARN(f, fmt, args...) \
-	do {								\
-		struct dma_fence *__ff = (f);				\
-		pr_warn("f %llu#%llu: " fmt, __ff->context, __ff->seqno,\
-			 ##args);					\
-	} while (0)
-
 #endif /* __LINUX_DMA_FENCE_H */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index ddaeb2afc022..af0103bebb7b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1020,6 +1020,10 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 int xdp_do_redirect(struct net_device *dev,
 		    struct xdp_buff *xdp,
 		    struct bpf_prog *prog);
+int xdp_do_redirect_frame(struct net_device *dev,
+			  struct xdp_buff *xdp,
+			  struct xdp_frame *xdpf,
+			  struct bpf_prog *prog);
 void xdp_do_flush(void);
 
 /* The xdp_do_flush_map() helper has been renamed to drop the _map suffix, as
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7ed1d4472c0c..15de91c65a09 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2735,6 +2735,21 @@ static inline void skb_mac_header_rebuild(struct sk_buff *skb)
 	}
 }
 
+/* Move the full mac header up to current network_header.
+ * Leaves skb->data pointing at offset skb->mac_len into the mac_header.
+ * Must be provided the complete mac header length.
+ */
+static inline void skb_mac_header_rebuild_full(struct sk_buff *skb, u32 full_mac_len)
+{
+	if (skb_mac_header_was_set(skb)) {
+		const unsigned char *old_mac = skb_mac_header(skb);
+
+		skb_set_mac_header(skb, -full_mac_len);
+		memmove(skb_mac_header(skb), old_mac, full_mac_len);
+		__skb_push(skb, full_mac_len - skb->mac_len);
+	}
+}
+
 static inline int skb_checksum_start_offset(const struct sk_buff *skb)
 {
 	return skb->csum_start - skb_headroom(skb);
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 4273505d309a..422b391d931f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -73,7 +73,6 @@ struct sk_psock_link {
 };
 
 struct sk_psock_work_state {
-	struct sk_buff			*skb;
 	u32				len;
 	u32				off;
 };
@@ -107,7 +106,7 @@ struct sk_psock {
 	struct proto			*sk_proto;
 	struct mutex			work_mutex;
 	struct sk_psock_work_state	work_state;
-	struct work_struct		work;
+	struct delayed_work		work;
 	struct rcu_work			rwork;
 };
 
@@ -462,10 +461,12 @@ static inline void sk_psock_put(struct sock *sk, struct sk_psock *psock)
 
 static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock *psock)
 {
+	read_lock_bh(&sk->sk_callback_lock);
 	if (psock->saved_data_ready)
 		psock->saved_data_ready(sk);
 	else
 		sk->sk_data_ready(sk);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static inline void psock_set_prog(struct bpf_prog **pprog,
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 71ec22b1df86..9c5197c360b9 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -130,6 +130,7 @@ struct rpc_create_args {
 	const char		*servername;
 	const char		*nodename;
 	const struct rpc_program *program;
+	struct rpc_stat		*stats;
 	u32			prognumber;	/* overrides program->number */
 	u32			version;
 	rpc_authflavor_t	authflavor;
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 6156ed2950f9..2e2e30d31a76 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1019,6 +1019,9 @@ struct xfrm_offload {
 #define CRYPTO_INVALID_PACKET_SYNTAX		64
 #define CRYPTO_INVALID_PROTOCOL			128
 
+	/* Used to keep whole l2 header for transport mode GRO */
+	__u32			orig_mac_len;
+
 	__u8			proto;
 	__u8			inner_ipproto;
 };
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index a8429cfb4ae8..0848d5691fd1 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -764,15 +764,9 @@ static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf)
 		list_add(&bq->flush_node, flush_list);
 }
 
-int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_buff *xdp,
+int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
-	struct xdp_frame *xdpf;
-
-	xdpf = xdp_convert_buff_to_frame(xdp);
-	if (unlikely(!xdpf))
-		return -EOVERFLOW;
-
 	/* Info needed when constructing SKB on remote CPU */
 	xdpf->dev_rx = dev_rx;
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index b591073c5f83..bbf3ec03aa59 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -468,24 +468,19 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	bq->q[bq->count++] = xdpf;
 }
 
-static inline int __xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+static inline int __xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 				struct net_device *dev_rx,
 				struct bpf_prog *xdp_prog)
 {
-	struct xdp_frame *xdpf;
 	int err;
 
 	if (!dev->netdev_ops->ndo_xdp_xmit)
 		return -EOPNOTSUPP;
 
-	err = xdp_ok_fwd_dev(dev, xdp->data_end - xdp->data);
+	err = xdp_ok_fwd_dev(dev, xdpf->len);
 	if (unlikely(err))
 		return err;
 
-	xdpf = xdp_convert_buff_to_frame(xdp);
-	if (unlikely(!xdpf))
-		return -EOVERFLOW;
-
 	bq_enqueue(dev, xdpf, dev_rx, xdp_prog);
 	return 0;
 }
@@ -521,27 +516,27 @@ static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab_netdev
 	return act;
 }
 
-int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
-	return __xdp_enqueue(dev, xdp, dev_rx, NULL);
+	return __xdp_enqueue(dev, xdpf, dev_rx, NULL);
 }
 
-int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
+int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
 	struct net_device *dev = dst->dev;
 
-	return __xdp_enqueue(dev, xdp, dev_rx, dst->xdp_prog);
+	return __xdp_enqueue(dev, xdpf, dev_rx, dst->xdp_prog);
 }
 
-static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_buff *xdp)
+static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_frame *xdpf)
 {
 	if (!obj ||
 	    !obj->dev->netdev_ops->ndo_xdp_xmit)
 		return false;
 
-	if (xdp_ok_fwd_dev(obj->dev, xdp->data_end - xdp->data))
+	if (xdp_ok_fwd_dev(obj->dev, xdpf->len))
 		return false;
 
 	return true;
@@ -587,14 +582,13 @@ static int get_upper_ifindexes(struct net_device *dev, int *indexes)
 	return n;
 }
 
-int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
+int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 			  struct bpf_map *map, bool exclude_ingress)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *dst, *last_dst = NULL;
 	int excluded_devices[1+MAX_NEST_DEV];
 	struct hlist_head *head;
-	struct xdp_frame *xdpf;
 	int num_excluded = 0;
 	unsigned int i;
 	int err;
@@ -604,15 +598,11 @@ int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
 		excluded_devices[num_excluded++] = dev_rx->ifindex;
 	}
 
-	xdpf = xdp_convert_buff_to_frame(xdp);
-	if (unlikely(!xdpf))
-		return -EOVERFLOW;
-
 	if (map->map_type == BPF_MAP_TYPE_DEVMAP) {
 		for (i = 0; i < map->max_entries; i++) {
 			dst = rcu_dereference_check(dtab->netdev_map[i],
 						    rcu_read_lock_bh_held());
-			if (!is_valid_dst(dst, xdp))
+			if (!is_valid_dst(dst, xdpf))
 				continue;
 
 			if (is_ifindex_excluded(excluded_devices, num_excluded, dst->dev->ifindex))
@@ -635,7 +625,7 @@ int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
 			head = dev_map_index_hash(dtab, i);
 			hlist_for_each_entry_rcu(dst, head, index_hlist,
 						 lockdep_is_held(&dtab->index_lock)) {
-				if (!is_valid_dst(dst, xdp))
+				if (!is_valid_dst(dst, xdpf))
 					continue;
 
 				if (is_ifindex_excluded(excluded_devices, num_excluded,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 67b325427022..94d952967fbf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11875,8 +11875,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			f = fdget(fd);
 			map = __bpf_map_get(f);
 			if (IS_ERR(map)) {
-				verbose(env, "fd %d is not pointing to valid bpf_map\n",
-					insn[0].imm);
+				verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
 				return PTR_ERR(map);
 			}
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 28faea9b5da6..2025b624fbb6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -319,7 +319,7 @@ config DEBUG_INFO_DWARF5
 endchoice # "DWARF version"
 
 config DEBUG_INFO_BTF
-	bool "Generate BTF typeinfo"
+	bool "Generate BTF type information"
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	help
@@ -331,7 +331,8 @@ config PAHOLE_HAS_SPLIT_BTF
 	def_bool PAHOLE_VERSION >= 119
 
 config DEBUG_INFO_BTF_MODULES
-	def_bool y
+	bool "Generate BTF type information for kernel modules"
+	default y
 	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
 	help
 	  Generate compact split BTF type information for kernel modules.
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2ca56c22a169..27a5a28c412d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -260,7 +260,11 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		} else {
 			for (end = buf; *end && !isspace(*end); end++)
 				;
-			BUG_ON(end == buf);
+			if (end == buf) {
+				pr_err("parse err after word:%d=%s\n", nwords,
+				       nwords ? words[nwords - 1] : "<none>");
+				return -EINVAL;
+			}
 		}
 
 		/* `buf' is start of word, `end' is one past its end */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 11bfc8737e6c..900b35297585 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -435,6 +435,9 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
+	if (!conn)
+		return;
+
 	mutex_lock(&conn->chan_lock);
 	/* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
 	 * this work. No need to call l2cap_chan_hold(chan) here again.
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 57c6a4f845a3..431e09cac178 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -83,6 +83,10 @@ static void sco_sock_timeout(struct work_struct *work)
 	struct sock *sk;
 
 	sco_conn_lock(conn);
+	if (!conn->hcon) {
+		sco_conn_unlock(conn);
+		return;
+	}
 	sk = conn->sk;
 	if (sk)
 		sock_hold(sk);
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 011bd3c59da1..1b66c276118a 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -253,6 +253,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 {
 	struct net_device *dev = BR_INPUT_SKB_CB(skb)->brdev;
 	const unsigned char *src = eth_hdr(skb)->h_source;
+	struct sk_buff *nskb;
 
 	if (!should_deliver(p, skb))
 		return;
@@ -261,12 +262,16 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 	if (skb->dev == p->dev && ether_addr_equal(src, addr))
 		return;
 
-	skb = skb_copy(skb, GFP_ATOMIC);
-	if (!skb) {
+	__skb_push(skb, ETH_HLEN);
+	nskb = pskb_copy(skb, GFP_ATOMIC);
+	__skb_pull(skb, ETH_HLEN);
+	if (!nskb) {
 		DEV_STATS_INC(dev, tx_dropped);
 		return;
 	}
 
+	skb = nskb;
+	__skb_pull(skb, ETH_HLEN);
 	if (!is_broadcast_ether_addr(addr))
 		memcpy(eth_hdr(skb)->h_dest, addr, ETH_ALEN);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 457d1a164ad5..47eb1bd47aa6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3987,37 +3987,75 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_master_redirect);
 
-int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
-		    struct bpf_prog *xdp_prog)
+static inline int __xdp_do_redirect_xsk(struct bpf_redirect_info *ri,
+					struct net_device *dev,
+					struct xdp_buff *xdp,
+					struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
+	int err;
+
+	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
+	ri->map_type = BPF_MAP_TYPE_UNSPEC;
+
+	err = __xsk_map_redirect(fwd, xdp);
+	if (unlikely(err))
+		goto err;
+
+	_trace_xdp_redirect_map(dev, xdp_prog, fwd, map_type, map_id, ri->tgt_index);
+	return 0;
+err:
+	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map_type, map_id, ri->tgt_index, err);
+	return err;
+}
+
+static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
+						   struct net_device *dev,
+						   struct xdp_frame *xdpf,
+						   struct bpf_prog *xdp_prog)
+{
+	enum bpf_map_type map_type = ri->map_type;
+	void *fwd = ri->tgt_value;
+	u32 map_id = ri->map_id;
+	u32 flags = ri->flags;
 	struct bpf_map *map;
 	int err;
 
 	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
+	ri->flags = 0;
 	ri->map_type = BPF_MAP_TYPE_UNSPEC;
 
+	if (unlikely(!xdpf)) {
+		err = -EOVERFLOW;
+		goto err;
+	}
+
 	switch (map_type) {
 	case BPF_MAP_TYPE_DEVMAP:
 		fallthrough;
 	case BPF_MAP_TYPE_DEVMAP_HASH:
-		map = READ_ONCE(ri->map);
-		if (unlikely(map)) {
+		if (unlikely(flags & BPF_F_BROADCAST)) {
+			map = READ_ONCE(ri->map);
+
+			/* The map pointer is cleared when the map is being torn
+			 * down by bpf_clear_redirect_map()
+			 */
+			if (unlikely(!map)) {
+				err = -ENOENT;
+				break;
+			}
+
 			WRITE_ONCE(ri->map, NULL);
-			err = dev_map_enqueue_multi(xdp, dev, map,
-						    ri->flags & BPF_F_EXCLUDE_INGRESS);
+			err = dev_map_enqueue_multi(xdpf, dev, map,
+						    flags & BPF_F_EXCLUDE_INGRESS);
 		} else {
-			err = dev_map_enqueue(fwd, xdp, dev);
+			err = dev_map_enqueue(fwd, xdpf, dev);
 		}
 		break;
 	case BPF_MAP_TYPE_CPUMAP:
-		err = cpu_map_enqueue(fwd, xdp, dev);
-		break;
-	case BPF_MAP_TYPE_XSKMAP:
-		err = __xsk_map_redirect(fwd, xdp);
+		err = cpu_map_enqueue(fwd, xdpf, dev);
 		break;
 	case BPF_MAP_TYPE_UNSPEC:
 		if (map_id == INT_MAX) {
@@ -4026,7 +4064,7 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 				err = -EINVAL;
 				break;
 			}
-			err = dev_xdp_enqueue(fwd, xdp, dev);
+			err = dev_xdp_enqueue(fwd, xdpf, dev);
 			break;
 		}
 		fallthrough;
@@ -4043,14 +4081,40 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map_type, map_id, ri->tgt_index, err);
 	return err;
 }
+
+int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
+		    struct bpf_prog *xdp_prog)
+{
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	enum bpf_map_type map_type = ri->map_type;
+
+	if (map_type == BPF_MAP_TYPE_XSKMAP)
+		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
+
+	return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
+				       xdp_prog);
+}
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
+int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
+			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
+{
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	enum bpf_map_type map_type = ri->map_type;
+
+	if (map_type == BPF_MAP_TYPE_XSKMAP)
+		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
+
+	return __xdp_do_redirect_frame(ri, dev, xdpf, xdp_prog);
+}
+EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
+
 static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct xdp_buff *xdp,
-				       struct bpf_prog *xdp_prog,
-				       void *fwd,
-				       enum bpf_map_type map_type, u32 map_id)
+				       struct bpf_prog *xdp_prog, void *fwd,
+				       enum bpf_map_type map_type, u32 map_id,
+				       u32 flags)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	struct bpf_map *map;
@@ -4060,11 +4124,20 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 	case BPF_MAP_TYPE_DEVMAP:
 		fallthrough;
 	case BPF_MAP_TYPE_DEVMAP_HASH:
-		map = READ_ONCE(ri->map);
-		if (unlikely(map)) {
+		if (unlikely(flags & BPF_F_BROADCAST)) {
+			map = READ_ONCE(ri->map);
+
+			/* The map pointer is cleared when the map is being torn
+			 * down by bpf_clear_redirect_map()
+			 */
+			if (unlikely(!map)) {
+				err = -ENOENT;
+				break;
+			}
+
 			WRITE_ONCE(ri->map, NULL);
 			err = dev_map_redirect_multi(dev, skb, xdp_prog, map,
-						     ri->flags & BPF_F_EXCLUDE_INGRESS);
+						     flags & BPF_F_EXCLUDE_INGRESS);
 		} else {
 			err = dev_map_generic_redirect(fwd, skb, xdp_prog);
 		}
@@ -4101,9 +4174,11 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
+	u32 flags = ri->flags;
 	int err;
 
 	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
+	ri->flags = 0;
 	ri->map_type = BPF_MAP_TYPE_UNSPEC;
 
 	if (map_type == BPF_MAP_TYPE_UNSPEC && map_id == INT_MAX) {
@@ -4123,7 +4198,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 		return 0;
 	}
 
-	return xdp_do_generic_redirect_map(dev, skb, xdp, xdp_prog, fwd, map_type, map_id);
+	return xdp_do_generic_redirect_map(dev, skb, xdp, xdp_prog, fwd, map_type, map_id, flags);
 err:
 	_trace_xdp_redirect_err(dev, xdp_prog, ri->tgt_index, err);
 	return err;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index dcddc54d0840..a209db33fa5f 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -68,12 +68,15 @@ DEFINE_COOKIE(net_cookie);
 
 static struct net_generic *net_alloc_generic(void)
 {
+	unsigned int gen_ptrs = READ_ONCE(max_gen_ptrs);
+	unsigned int generic_size;
 	struct net_generic *ng;
-	unsigned int generic_size = offsetof(struct net_generic, ptr[max_gen_ptrs]);
+
+	generic_size = offsetof(struct net_generic, ptr[gen_ptrs]);
 
 	ng = kzalloc(generic_size, GFP_KERNEL);
 	if (ng)
-		ng->s.len = max_gen_ptrs;
+		ng->s.len = gen_ptrs;
 
 	return ng;
 }
@@ -1211,7 +1214,11 @@ static int register_pernet_operations(struct list_head *list,
 		if (error < 0)
 			return error;
 		*ops->id = error;
-		max_gen_ptrs = max(max_gen_ptrs, *ops->id + 1);
+		/* This does not require READ_ONCE as writers already hold
+		 * pernet_ops_rwsem. But WRITE_ONCE is needed to protect
+		 * net_alloc_generic.
+		 */
+		WRITE_ONCE(max_gen_ptrs, max(max_gen_ptrs, *ops->id + 1));
 	}
 	error = __register_pernet_operations(list, ops);
 	if (error) {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ef218e290dfb..d25632fbfa89 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2383,7 +2383,7 @@ static int do_setvfinfo(struct net_device *dev, struct nlattr **tb)
 
 		nla_for_each_nested(attr, tb[IFLA_VF_VLAN_LIST], rem) {
 			if (nla_type(attr) != IFLA_VF_VLAN_INFO ||
-			    nla_len(attr) < NLA_HDRLEN) {
+			    nla_len(attr) < sizeof(struct ifla_vf_vlan_info)) {
 				return -EINVAL;
 			}
 			if (len >= MAX_VLAN_LIST_LEN)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a42431860af9..4ec8cfd357eb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1583,11 +1583,17 @@ static inline int skb_alloc_rx_flag(const struct sk_buff *skb)
 
 struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t gfp_mask)
 {
-	int headerlen = skb_headroom(skb);
-	unsigned int size = skb_end_offset(skb) + skb->data_len;
-	struct sk_buff *n = __alloc_skb(size, gfp_mask,
-					skb_alloc_rx_flag(skb), NUMA_NO_NODE);
+	struct sk_buff *n;
+	unsigned int size;
+	int headerlen;
+
+	if (WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST))
+		return NULL;
 
+	headerlen = skb_headroom(skb);
+	size = skb_end_offset(skb) + skb->data_len;
+	n = __alloc_skb(size, gfp_mask,
+			skb_alloc_rx_flag(skb), NUMA_NO_NODE);
 	if (!n)
 		return NULL;
 
@@ -1899,12 +1905,17 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 	/*
 	 *	Allocate the copy buffer
 	 */
-	struct sk_buff *n = __alloc_skb(newheadroom + skb->len + newtailroom,
-					gfp_mask, skb_alloc_rx_flag(skb),
-					NUMA_NO_NODE);
-	int oldheadroom = skb_headroom(skb);
 	int head_copy_len, head_copy_off;
+	struct sk_buff *n;
+	int oldheadroom;
+
+	if (WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST))
+		return NULL;
 
+	oldheadroom = skb_headroom(skb);
+	n = __alloc_skb(newheadroom + skb->len + newtailroom,
+			gfp_mask, skb_alloc_rx_flag(skb),
+			NUMA_NO_NODE);
 	if (!n)
 		return NULL;
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 9cd14212dcd0..ec8671eccae0 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -481,8 +481,6 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		msg_rx = sk_psock_peek_msg(psock);
 	}
 out:
-	if (psock->work_state.skb && copied > 0)
-		schedule_work(&psock->work);
 	return copied;
 }
 EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
@@ -617,42 +615,33 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 
 static void sk_psock_skb_state(struct sk_psock *psock,
 			       struct sk_psock_work_state *state,
-			       struct sk_buff *skb,
 			       int len, int off)
 {
 	spin_lock_bh(&psock->ingress_lock);
 	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
-		state->skb = skb;
 		state->len = len;
 		state->off = off;
-	} else {
-		sock_drop(psock->sk, skb);
 	}
 	spin_unlock_bh(&psock->ingress_lock);
 }
 
 static void sk_psock_backlog(struct work_struct *work)
 {
-	struct sk_psock *psock = container_of(work, struct sk_psock, work);
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct sk_psock *psock = container_of(dwork, struct sk_psock, work);
 	struct sk_psock_work_state *state = &psock->work_state;
 	struct sk_buff *skb = NULL;
+	u32 len = 0, off = 0;
 	bool ingress;
-	u32 len, off;
 	int ret;
 
 	mutex_lock(&psock->work_mutex);
-	if (unlikely(state->skb)) {
-		spin_lock_bh(&psock->ingress_lock);
-		skb = state->skb;
+	if (unlikely(state->len)) {
 		len = state->len;
 		off = state->off;
-		state->skb = NULL;
-		spin_unlock_bh(&psock->ingress_lock);
 	}
-	if (skb)
-		goto start;
 
-	while ((skb = skb_dequeue(&psock->ingress_skb))) {
+	while ((skb = skb_peek(&psock->ingress_skb))) {
 		len = skb->len;
 		off = 0;
 		if (skb_bpf_strparser(skb)) {
@@ -661,7 +650,6 @@ static void sk_psock_backlog(struct work_struct *work)
 			off = stm->offset;
 			len = stm->full_len;
 		}
-start:
 		ingress = skb_bpf_ingress(skb);
 		skb_bpf_redirect_clear(skb);
 		do {
@@ -671,22 +659,28 @@ static void sk_psock_backlog(struct work_struct *work)
 							  len, ingress);
 			if (ret <= 0) {
 				if (ret == -EAGAIN) {
-					sk_psock_skb_state(psock, state, skb,
-							   len, off);
+					sk_psock_skb_state(psock, state, len, off);
+
+					/* Delay slightly to prioritize any
+					 * other work that might be here.
+					 */
+					if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+						schedule_delayed_work(&psock->work, 1);
 					goto end;
 				}
 				/* Hard errors break pipe and stop xmit. */
 				sk_psock_report_error(psock, ret ? -ret : EPIPE);
 				sk_psock_clear_state(psock, SK_PSOCK_TX_ENABLED);
-				sock_drop(psock->sk, skb);
 				goto end;
 			}
 			off += ret;
 			len -= ret;
 		} while (len);
 
-		if (!ingress)
+		skb = skb_dequeue(&psock->ingress_skb);
+		if (!ingress) {
 			kfree_skb(skb);
+		}
 	}
 end:
 	mutex_unlock(&psock->work_mutex);
@@ -727,7 +721,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	INIT_LIST_HEAD(&psock->link);
 	spin_lock_init(&psock->link_lock);
 
-	INIT_WORK(&psock->work, sk_psock_backlog);
+	INIT_DELAYED_WORK(&psock->work, sk_psock_backlog);
 	mutex_init(&psock->work_mutex);
 	INIT_LIST_HEAD(&psock->ingress_msg);
 	spin_lock_init(&psock->ingress_lock);
@@ -779,11 +773,6 @@ static void __sk_psock_zap_ingress(struct sk_psock *psock)
 		skb_bpf_redirect_clear(skb);
 		sock_drop(psock->sk, skb);
 	}
-	kfree_skb(psock->work_state.skb);
-	/* We null the skb here to ensure that calls to sk_psock_backlog
-	 * do not pick up the free'd skb.
-	 */
-	psock->work_state.skb = NULL;
 	__sk_psock_purge_ingress_msg(psock);
 }
 
@@ -802,7 +791,6 @@ void sk_psock_stop(struct sk_psock *psock)
 	spin_lock_bh(&psock->ingress_lock);
 	sk_psock_clear_state(psock, SK_PSOCK_TX_ENABLED);
 	sk_psock_cork_free(psock);
-	__sk_psock_zap_ingress(psock);
 	spin_unlock_bh(&psock->ingress_lock);
 }
 
@@ -816,7 +804,8 @@ static void sk_psock_destroy(struct work_struct *work)
 
 	sk_psock_done_strp(psock);
 
-	cancel_work_sync(&psock->work);
+	cancel_delayed_work_sync(&psock->work);
+	__sk_psock_zap_ingress(psock);
 	mutex_destroy(&psock->work_mutex);
 
 	psock_progs_drop(&psock->progs);
@@ -931,7 +920,7 @@ static int sk_psock_skb_redirect(struct sk_psock *from, struct sk_buff *skb)
 	}
 
 	skb_queue_tail(&psock_other->ingress_skb, skb);
-	schedule_work(&psock_other->work);
+	schedule_delayed_work(&psock_other->work, 0);
 	spin_unlock_bh(&psock_other->ingress_lock);
 	return 0;
 }
@@ -1011,7 +1000,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 			spin_lock_bh(&psock->ingress_lock);
 			if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 				skb_queue_tail(&psock->ingress_skb, skb);
-				schedule_work(&psock->work);
+				schedule_delayed_work(&psock->work, 0);
 				err = 0;
 			}
 			spin_unlock_bh(&psock->ingress_lock);
@@ -1042,7 +1031,7 @@ static void sk_psock_write_space(struct sock *sk)
 	psock = sk_psock(sk);
 	if (likely(psock)) {
 		if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
-			schedule_work(&psock->work);
+			schedule_delayed_work(&psock->work, 0);
 		write_space = psock->saved_write_space;
 	}
 	rcu_read_unlock();
diff --git a/net/core/sock.c b/net/core/sock.c
index 6f761f3c272a..62e376f09f95 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -459,7 +459,7 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned long flags;
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf) {
+	if (atomic_read(&sk->sk_rmem_alloc) >= READ_ONCE(sk->sk_rcvbuf)) {
 		atomic_inc(&sk->sk_drops);
 		trace_sock_rcvqueue_full(sk, skb);
 		return -ENOMEM;
@@ -511,7 +511,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 4e42bc679bac..2ded250ac0d2 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1577,9 +1577,10 @@ void sock_map_close(struct sock *sk, long timeout)
 		rcu_read_unlock();
 		sk_psock_stop(psock);
 		release_sock(sk);
-		cancel_work_sync(&psock->work);
+		cancel_delayed_work_sync(&psock->work);
 		sk_psock_put(sk, psock);
 	}
+
 	/* Make sure we do not recurse. This is a bug.
 	 * Leak the socket instead of crashing on a stack overflow.
 	 */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 16fd3da68e9f..9c7998377d6b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2692,7 +2692,7 @@ void tcp_shutdown(struct sock *sk, int how)
 	/* If we've already sent a FIN, or it's a closed state, skip this. */
 	if ((1 << sk->sk_state) &
 	    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
-	     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) {
+	     TCPF_CLOSE_WAIT)) {
 		/* Clear out any half completed packets.  FIN if needed. */
 		if (tcp_close_state(sk))
 			tcp_send_fin(sk);
@@ -2803,7 +2803,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		 * machine. State transitions:
 		 *
 		 * TCP_ESTABLISHED -> TCP_FIN_WAIT1
-		 * TCP_SYN_RECV	-> TCP_FIN_WAIT1 (forget it, it's impossible)
+		 * TCP_SYN_RECV	-> TCP_FIN_WAIT1 (it is difficult)
 		 * TCP_CLOSE_WAIT -> TCP_LAST_ACK
 		 *
 		 * are legal only when FIN has been sent (i.e. in window),
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index e3a9477293ce..5fdef5ddfbbe 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -174,6 +174,24 @@ static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
 	return ret;
 }
 
+static bool is_next_msg_fin(struct sk_psock *psock)
+{
+	struct scatterlist *sge;
+	struct sk_msg *msg_rx;
+	int i;
+
+	msg_rx = sk_psock_peek_msg(psock);
+	i = msg_rx->sg.start;
+	sge = sk_msg_elem(msg_rx, i);
+	if (!sge->length) {
+		struct sk_buff *skb = msg_rx->skb;
+
+		if (skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+			return true;
+	}
+	return false;
+}
+
 static int tcp_bpf_recvmsg_parser(struct sock *sk,
 				  struct msghdr *msg,
 				  size_t len,
@@ -195,8 +213,41 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
 
 	lock_sock(sk);
+
+	/* We may have received data on the sk_receive_queue pre-accept and
+	 * then we can not use read_skb in this context because we haven't
+	 * assigned a sk_socket yet so have no link to the ops. The work-around
+	 * is to check the sk_receive_queue and in these cases read skbs off
+	 * queue again. The read_skb hook is not running at this point because
+	 * of lock_sock so we avoid having multiple runners in read_skb.
+	 */
+	if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
+		tcp_data_ready(sk);
+		/* This handles the ENOMEM errors if we both receive data
+		 * pre accept and are already under memory pressure. At least
+		 * let user know to retry.
+		 */
+		if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
+			copied = -EAGAIN;
+			goto out;
+		}
+	}
+
 msg_bytes_ready:
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
+	/* The typical case for EFAULT is the socket was gracefully
+	 * shutdown with a FIN pkt. So check here the other case is
+	 * some error on copy_page_to_iter which would be unexpected.
+	 * On fin return correct return code to zero.
+	 */
+	if (copied == -EFAULT) {
+		bool is_fin = is_next_msg_fin(psock);
+
+		if (is_fin) {
+			copied = 0;
+			goto out;
+		}
+	}
 	if (!copied) {
 		long timeo;
 		int data;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e51b5d887c24..52a9d7f96da4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6543,6 +6543,8 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 		tcp_initialize_rcv_mss(sk);
 		tcp_fast_path_on(tp);
+		if (sk->sk_shutdown & SEND_SHUTDOWN)
+			tcp_shutdown(sk, SEND_SHUTDOWN);
 		break;
 
 	case TCP_FIN_WAIT1: {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0666be6b9ec9..e162bed1916a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -153,6 +153,12 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	if (tcptw->tw_ts_recent_stamp &&
 	    (!twp || (reuse && time_after32(ktime_get_seconds(),
 					    tcptw->tw_ts_recent_stamp)))) {
+		/* inet_twsk_hashdance() sets sk_refcnt after putting twsk
+		 * and releasing the bucket lock.
+		 */
+		if (unlikely(!refcount_inc_not_zero(&sktw->sk_refcnt)))
+			return 0;
+
 		/* In case of repair and re-using TIME-WAIT sockets we still
 		 * want to be sure that it is safe as above but honor the
 		 * sequence numbers and time stamps set as part of the repair
@@ -173,7 +179,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 			tp->rx_opt.ts_recent	   = tcptw->tw_ts_recent;
 			tp->rx_opt.ts_recent_stamp = tcptw->tw_ts_recent_stamp;
 		}
-		sock_hold(sktw);
+
 		return 1;
 	}
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d8817d6c7b96..0fb84e57a2d4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3441,7 +3441,9 @@ void tcp_send_fin(struct sock *sk)
 			return;
 		}
 	} else {
-		skb = alloc_skb_fclone(MAX_TCP_HEADER, sk->sk_allocation);
+		skb = alloc_skb_fclone(MAX_TCP_HEADER,
+				       sk_gfp_mask(sk, GFP_ATOMIC |
+						       __GFP_NOWARN));
 		if (unlikely(!skb))
 			return;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 7c6ac47b0bb1..c61268849948 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -434,6 +434,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 	struct sk_buff *p;
 	unsigned int ulen;
 	int ret = 0;
+	int flush;
 
 	/* requires non zero csum, for symmetry with GSO */
 	if (!uh->check) {
@@ -467,13 +468,22 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 			return p;
 		}
 
+		flush = NAPI_GRO_CB(p)->flush;
+
+		if (NAPI_GRO_CB(p)->flush_id != 1 ||
+		    NAPI_GRO_CB(p)->count != 1 ||
+		    !NAPI_GRO_CB(p)->is_atomic)
+			flush |= NAPI_GRO_CB(p)->flush_id;
+		else
+			NAPI_GRO_CB(p)->is_atomic = false;
+
 		/* Terminate the flow on len mismatch or if it grow "too much".
 		 * Under small packet flood GRO count could elsewhere grow a lot
 		 * leading to excessive truesize values.
 		 * On len mismatch merge the first packet shorter than gso_size,
 		 * otherwise complete the GRO packet.
 		 */
-		if (ulen > ntohs(uh2->len)) {
+		if (ulen > ntohs(uh2->len) || flush) {
 			pp = p;
 		} else {
 			if (NAPI_GRO_CB(skb)->is_flist) {
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index eac206a290d0..1f50517289fd 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -61,7 +61,11 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 	ip_send_check(iph);
 
 	if (xo && (xo->flags & XFRM_GRO)) {
-		skb_mac_header_rebuild(skb);
+		/* The full l2 header needs to be preserved so that re-injecting the packet at l2
+		 * works correctly in the presence of vlan tags.
+		 */
+		skb_mac_header_rebuild_full(skb, xo->orig_mac_len);
+		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
 		return 0;
 	}
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 8e9e80eb0f32..a4caaead74c1 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -232,8 +232,12 @@ static int __fib6_rule_action(struct fib_rule *rule, struct flowi *flp,
 	rt = pol_lookup_func(lookup,
 			     net, table, flp6, arg->lookup_data, flags);
 	if (rt != net->ipv6.ip6_null_entry) {
+		struct inet6_dev *idev = ip6_dst_idev(&rt->dst);
+
+		if (!idev)
+			goto again;
 		err = fib6_rule_saddr(net, rule, flags, flp6,
-				      ip6_dst_idev(&rt->dst)->dev);
+				      idev->dev);
 
 		if (err == -EAGAIN)
 			goto again;
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 4907ab241d6b..7dbefbb338ca 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -56,7 +56,11 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
 	skb_postpush_rcsum(skb, skb_network_header(skb), nhlen);
 
 	if (xo && (xo->flags & XFRM_GRO)) {
-		skb_mac_header_rebuild(skb);
+		/* The full l2 header needs to be preserved so that re-injecting the packet at l2
+		 * works correctly in the presence of vlan tags.
+		 */
+		skb_mac_header_rebuild_full(skb, xo->orig_mac_len);
+		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
 		return 0;
 	}
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 6cd97c75445c..9a36e174984c 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -136,6 +136,9 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
 	/* checksums verified by L2TP */
 	skb->ip_summed = CHECKSUM_NONE;
 
+	/* drop outer flow-hash */
+	skb_clear_hash(skb);
+
 	skb_dst_drop(skb);
 	nf_reset_ct(skb);
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 21549a440b38..03f8c8bdab76 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -113,7 +113,7 @@ struct ieee80211_bss {
 };
 
 /**
- * enum ieee80211_corrupt_data_flags - BSS data corruption flags
+ * enum ieee80211_bss_corrupt_data_flags - BSS data corruption flags
  * @IEEE80211_BSS_CORRUPT_BEACON: last beacon frame received was corrupted
  * @IEEE80211_BSS_CORRUPT_PROBE_RESP: last probe response received was corrupted
  *
@@ -126,7 +126,7 @@ enum ieee80211_bss_corrupt_data_flags {
 };
 
 /**
- * enum ieee80211_valid_data_flags - BSS valid data flags
+ * enum ieee80211_bss_valid_data_flags - BSS valid data flags
  * @IEEE80211_BSS_VALID_WMM: WMM/UAPSD data was gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_RATES: Supported rates were gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_ERP: ERP flag was gathered from non-corrupt IE
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cde62dafda49..3c3f630f4943 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3395,6 +3395,9 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
 	}
+
+	WRITE_ONCE(msk->write_seq, subflow->idsn);
+	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sock->sk), MPTCP_MIB_MPCAPABLEACTIVE);
 
diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index 0f23e5e8e03e..3e0fc71d95a1 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -76,13 +76,15 @@ EXPORT_SYMBOL_GPL(nsh_pop);
 static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 				       netdev_features_t features)
 {
+	unsigned int outer_hlen, mac_len, nsh_len;
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	u16 mac_offset = skb->mac_header;
-	unsigned int nsh_len, mac_len;
-	__be16 proto;
+	__be16 outer_proto, proto;
 
 	skb_reset_network_header(skb);
 
+	outer_proto = skb->protocol;
+	outer_hlen = skb_mac_header_len(skb);
 	mac_len = skb->mac_len;
 
 	if (unlikely(!pskb_may_pull(skb, NSH_BASE_HDR_LEN)))
@@ -112,10 +114,10 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 	}
 
 	for (skb = segs; skb; skb = skb->next) {
-		skb->protocol = htons(ETH_P_NSH);
-		__skb_push(skb, nsh_len);
-		skb->mac_header = mac_offset;
-		skb->network_header = skb->mac_header + mac_len;
+		skb->protocol = outer_proto;
+		__skb_push(skb, nsh_len + outer_hlen);
+		skb_reset_mac_header(skb);
+		skb_set_network_header(skb, outer_hlen);
 		skb->mac_len = mac_len;
 	}
 
diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 59aebe296890..dd4c7e9a634f 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -193,7 +193,7 @@ void rtm_phonet_notify(int event, struct net_device *dev, u8 dst)
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
+	skb = nlmsg_new(NLMSG_ALIGN(sizeof(struct rtmsg)) +
 			nla_total_size(1) + nla_total_size(4), GFP_KERNEL);
 	if (skb == NULL)
 		goto errout;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index af1ca707c3d3..59fd6dedbbed 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -398,7 +398,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	clnt->cl_maxproc  = version->nrprocs;
 	clnt->cl_prog     = args->prognumber ? : program->number;
 	clnt->cl_vers     = version->number;
-	clnt->cl_stats    = program->stats;
+	clnt->cl_stats    = args->stats ? : program->stats;
 	clnt->cl_metrics  = rpc_alloc_iostats(clnt);
 	rpc_init_pipe_dir_head(&clnt->cl_pipedir_objects);
 	err = -ENOMEM;
@@ -677,6 +677,7 @@ struct rpc_clnt *rpc_clone_client(struct rpc_clnt *clnt)
 		.version	= clnt->cl_vers,
 		.authflavor	= clnt->cl_auth->au_flavor,
 		.cred		= clnt->cl_cred,
+		.stats		= clnt->cl_stats,
 	};
 	return __rpc_clone_client(&args, clnt);
 }
@@ -699,6 +700,7 @@ rpc_clone_client_set_auth(struct rpc_clnt *clnt, rpc_authflavor_t flavor)
 		.version	= clnt->cl_vers,
 		.authflavor	= flavor,
 		.cred		= clnt->cl_cred,
+		.stats		= clnt->cl_stats,
 	};
 	return __rpc_clone_client(&args, clnt);
 }
@@ -979,6 +981,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 		.version	= vers,
 		.authflavor	= old->cl_auth->au_flavor,
 		.cred		= old->cl_cred,
+		.stats		= old->cl_stats,
 	};
 	struct rpc_clnt *clnt;
 	int err;
diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 5c9fd4791c4b..76284fc538eb 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -142,9 +142,9 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 	if (fragid == FIRST_FRAGMENT) {
 		if (unlikely(head))
 			goto err;
-		*buf = NULL;
 		if (skb_has_frag_list(frag) && __skb_linearize(frag))
 			goto err;
+		*buf = NULL;
 		frag = skb_unshare(frag, GFP_ATOMIC);
 		if (unlikely(!frag))
 			goto err;
@@ -156,6 +156,11 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 	if (!head)
 		goto err;
 
+	/* Either the input skb ownership is transferred to headskb
+	 * or the input skb is freed, clear the reference to avoid
+	 * bad access on error path.
+	 */
+	*buf = NULL;
 	if (skb_try_coalesce(head, frag, &headstolen, &delta)) {
 		kfree_skb_partial(frag, headstolen);
 	} else {
@@ -179,7 +184,6 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 		*headbuf = NULL;
 		return 1;
 	}
-	*buf = NULL;
 	return 0;
 err:
 	kfree_skb(*buf);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 99149b10f86f..d758ec565589 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12890,6 +12890,8 @@ static int nl80211_set_coalesce(struct sk_buff *skb, struct genl_info *info)
 error:
 	for (i = 0; i < new_coalesce.n_rules; i++) {
 		tmp_rule = &new_coalesce.rules[i];
+		if (!tmp_rule)
+			continue;
 		for (j = 0; j < tmp_rule->n_patterns; j++)
 			kfree(tmp_rule->patterns[j].mask);
 		kfree(tmp_rule->patterns);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 19b78d472283..dafea8bfcf3c 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -963,7 +963,7 @@ TRACE_EVENT(rdev_get_mpp,
 TRACE_EVENT(rdev_dump_mpp,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int _idx,
 		 u8 *dst, u8 *mpp),
-	TP_ARGS(wiphy, netdev, _idx, mpp, dst),
+	TP_ARGS(wiphy, netdev, _idx, dst, mpp),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index a6861832710d..7f326a01cbce 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -400,11 +400,15 @@ static int xfrm_prepare_input(struct xfrm_state *x, struct sk_buff *skb)
  */
 static int xfrm4_transport_input(struct xfrm_state *x, struct sk_buff *skb)
 {
+	struct xfrm_offload *xo = xfrm_offload(skb);
 	int ihl = skb->data - skb_transport_header(skb);
 
 	if (skb->transport_header != skb->network_header) {
 		memmove(skb_transport_header(skb),
 			skb_network_header(skb), ihl);
+		if (xo)
+			xo->orig_mac_len =
+				skb_mac_header_was_set(skb) ? skb_mac_header_len(skb) : 0;
 		skb->network_header = skb->transport_header;
 	}
 	ip_hdr(skb)->tot_len = htons(skb->len + ihl);
@@ -415,11 +419,15 @@ static int xfrm4_transport_input(struct xfrm_state *x, struct sk_buff *skb)
 static int xfrm6_transport_input(struct xfrm_state *x, struct sk_buff *skb)
 {
 #if IS_ENABLED(CONFIG_IPV6)
+	struct xfrm_offload *xo = xfrm_offload(skb);
 	int ihl = skb->data - skb_transport_header(skb);
 
 	if (skb->transport_header != skb->network_header) {
 		memmove(skb_transport_header(skb),
 			skb_network_header(skb), ihl);
+		if (xo)
+			xo->orig_mac_len =
+				skb_mac_header_was_set(skb) ? skb_mac_header_len(skb) : 0;
 		skb->network_header = skb->transport_header;
 	}
 	ipv6_hdr(skb)->payload_len = htons(skb->len + ihl -
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 47f047458264..dce4cf55a4b6 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -23,7 +23,7 @@ modname = $(notdir $(@:.mod.o=))
 part-of-module = y
 
 quiet_cmd_cc_o_c = CC [M]  $@
-      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV), $(c_flags)) -c -o $@ $<
+      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV) $(CFLAGS_KCSAN), $(c_flags)) -c -o $@ $<
 
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
diff --git a/security/keys/key.c b/security/keys/key.c
index e65240641ca5..f2a84d86eab4 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -464,7 +464,8 @@ static int __key_instantiate_and_link(struct key *key,
 			if (authkey)
 				key_invalidate(authkey);
 
-			key_set_expiry(key, prep->expiry);
+			if (prep->expiry != TIME64_MAX)
+				key_set_expiry(key, prep->expiry);
 		}
 	}
 
diff --git a/sound/hda/intel-sdw-acpi.c b/sound/hda/intel-sdw-acpi.c
index b7758dbe2371..7c1e47aa4e7a 100644
--- a/sound/hda/intel-sdw-acpi.c
+++ b/sound/hda/intel-sdw-acpi.c
@@ -41,6 +41,8 @@ static bool is_link_enabled(struct fwnode_handle *fw_node, int i)
 				 "intel-quirk-mask",
 				 &quirk_mask);
 
+	fwnode_handle_put(link);
+
 	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
 		return false;
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 94859fdd1da0..c7529aa13f94 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9131,6 +9131,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x86c1, "HP Laptop 15-da3001TU", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index b93ea33739f2..6458d5dc4902 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -99,6 +99,7 @@ config SND_MESON_AXG_PDM
 
 config SND_MESON_CARD_UTILS
 	tristate
+	select SND_DYNAMIC_MINORS
 
 config SND_MESON_CODEC_GLUE
 	tristate
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 2b77010c2c5c..cbbaa55d92a6 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -320,6 +320,7 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 
 	dai_link->cpus = cpu;
 	dai_link->num_cpus = 1;
+	dai_link->nonatomic = true;
 
 	ret = meson_card_parse_dai(card, np, &dai_link->cpus->of_node,
 				   &dai_link->cpus->dai_name);
diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index bccfb770b339..94b169a5493b 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2018 BayLibre, SAS.
 // Author: Jerome Brunet <jbrunet@baylibre.com>
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -145,8 +146,8 @@ int axg_fifo_pcm_hw_params(struct snd_soc_component *component,
 	/* Enable irq if necessary  */
 	irq_en = runtime->no_period_wakeup ? 0 : FIFO_INT_COUNT_REPEAT;
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT),
-			   CTRL0_INT_EN(irq_en));
+			   CTRL0_INT_EN,
+			   FIELD_PREP(CTRL0_INT_EN, irq_en));
 
 	return 0;
 }
@@ -176,9 +177,9 @@ int axg_fifo_pcm_hw_free(struct snd_soc_component *component,
 {
 	struct axg_fifo *fifo = axg_fifo_data(ss);
 
-	/* Disable the block count irq */
+	/* Disable irqs */
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT), 0);
+			   CTRL0_INT_EN, 0);
 
 	return 0;
 }
@@ -187,13 +188,13 @@ EXPORT_SYMBOL_GPL(axg_fifo_pcm_hw_free);
 static void axg_fifo_ack_irq(struct axg_fifo *fifo, u8 mask)
 {
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
-			   CTRL1_INT_CLR(FIFO_INT_MASK),
-			   CTRL1_INT_CLR(mask));
+			   CTRL1_INT_CLR,
+			   FIELD_PREP(CTRL1_INT_CLR, mask));
 
 	/* Clear must also be cleared */
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
-			   CTRL1_INT_CLR(FIFO_INT_MASK),
-			   0);
+			   CTRL1_INT_CLR,
+			   FIELD_PREP(CTRL1_INT_CLR, 0));
 }
 
 static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
@@ -203,18 +204,26 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
 	unsigned int status;
 
 	regmap_read(fifo->map, FIFO_STATUS1, &status);
+	status = FIELD_GET(STATUS1_INT_STS, status);
+	axg_fifo_ack_irq(fifo, status);
 
-	status = STATUS1_INT_STS(status) & FIFO_INT_MASK;
+	/* Use the thread to call period elapsed on nonatomic links */
 	if (status & FIFO_INT_COUNT_REPEAT)
-		snd_pcm_period_elapsed(ss);
-	else
-		dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
-			status);
+		return IRQ_WAKE_THREAD;
 
-	/* Ack irqs */
-	axg_fifo_ack_irq(fifo, status);
+	dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
+		status);
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t axg_fifo_pcm_irq_block_thread(int irq, void *dev_id)
+{
+	struct snd_pcm_substream *ss = dev_id;
+
+	snd_pcm_period_elapsed(ss);
 
-	return IRQ_RETVAL(status);
+	return IRQ_HANDLED;
 }
 
 int axg_fifo_pcm_open(struct snd_soc_component *component,
@@ -242,8 +251,9 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	ret = request_irq(fifo->irq, axg_fifo_pcm_irq_block, 0,
-			  dev_name(dev), ss);
+	ret = request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
+				   axg_fifo_pcm_irq_block_thread,
+				   IRQF_ONESHOT, dev_name(dev), ss);
 	if (ret)
 		return ret;
 
@@ -254,15 +264,15 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
 
 	/* Setup status2 so it reports the memory pointer */
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
-			   CTRL1_STATUS2_SEL_MASK,
-			   CTRL1_STATUS2_SEL(STATUS2_SEL_DDR_READ));
+			   CTRL1_STATUS2_SEL,
+			   FIELD_PREP(CTRL1_STATUS2_SEL, STATUS2_SEL_DDR_READ));
 
 	/* Make sure the dma is initially disabled */
 	__dma_enable(fifo, false);
 
 	/* Disable irqs until params are ready */
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_INT_EN(FIFO_INT_MASK), 0);
+			   CTRL0_INT_EN, 0);
 
 	/* Clear any pending interrupt */
 	axg_fifo_ack_irq(fifo, FIFO_INT_MASK);
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index b63acd723c87..5b7d32c37991 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -42,21 +42,19 @@ struct snd_soc_pcm_runtime;
 
 #define FIFO_CTRL0			0x00
 #define  CTRL0_DMA_EN			BIT(31)
-#define  CTRL0_INT_EN(x)		((x) << 16)
+#define  CTRL0_INT_EN			GENMASK(23, 16)
 #define  CTRL0_SEL_MASK			GENMASK(2, 0)
 #define  CTRL0_SEL_SHIFT		0
 #define FIFO_CTRL1			0x04
-#define  CTRL1_INT_CLR(x)		((x) << 0)
-#define  CTRL1_STATUS2_SEL_MASK		GENMASK(11, 8)
-#define  CTRL1_STATUS2_SEL(x)		((x) << 8)
+#define  CTRL1_INT_CLR			GENMASK(7, 0)
+#define  CTRL1_STATUS2_SEL		GENMASK(11, 8)
 #define   STATUS2_SEL_DDR_READ		0
-#define  CTRL1_FRDDR_DEPTH_MASK		GENMASK(31, 24)
-#define  CTRL1_FRDDR_DEPTH(x)		((x) << 24)
+#define  CTRL1_FRDDR_DEPTH		GENMASK(31, 24)
 #define FIFO_START_ADDR			0x08
 #define FIFO_FINISH_ADDR		0x0c
 #define FIFO_INT_ADDR			0x10
 #define FIFO_STATUS1			0x14
-#define  STATUS1_INT_STS(x)		((x) << 0)
+#define  STATUS1_INT_STS		GENMASK(7, 0)
 #define FIFO_STATUS2			0x18
 #define FIFO_INIT_ADDR			0x24
 #define FIFO_CTRL2			0x28
diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index 37f4bb3469b5..38c731ad4070 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -7,6 +7,7 @@
  * This driver implements the frontend playback DAI of AXG and G12A based SoCs
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/module.h>
@@ -59,8 +60,8 @@ static int axg_frddr_dai_hw_params(struct snd_pcm_substream *substream,
 	/* Trim the FIFO depth if the period is small to improve latency */
 	depth = min(period, fifo->depth);
 	val = (depth / AXG_FIFO_BURST) - 1;
-	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_FRDDR_DEPTH_MASK,
-			   CTRL1_FRDDR_DEPTH(val));
+	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_FRDDR_DEPTH,
+			   FIELD_PREP(CTRL1_FRDDR_DEPTH, val));
 
 	return 0;
 }
diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 60d132ab1ab7..f5145902360d 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -362,13 +362,29 @@ static int axg_tdm_iface_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int axg_tdm_iface_prepare(struct snd_pcm_substream *substream,
+static int axg_tdm_iface_trigger(struct snd_pcm_substream *substream,
+				 int cmd,
 				 struct snd_soc_dai *dai)
 {
-	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
+	struct axg_tdm_stream *ts =
+		snd_soc_dai_get_dma_data(dai, substream);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		axg_tdm_stream_start(ts);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_STOP:
+		axg_tdm_stream_stop(ts);
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	/* Force all attached formatters to update */
-	return axg_tdm_stream_reset(ts);
+	return 0;
 }
 
 static int axg_tdm_iface_remove_dai(struct snd_soc_dai *dai)
@@ -408,8 +424,8 @@ static const struct snd_soc_dai_ops axg_tdm_iface_ops = {
 	.set_fmt	= axg_tdm_iface_set_fmt,
 	.startup	= axg_tdm_iface_startup,
 	.hw_params	= axg_tdm_iface_hw_params,
-	.prepare	= axg_tdm_iface_prepare,
 	.hw_free	= axg_tdm_iface_hw_free,
+	.trigger	= axg_tdm_iface_trigger,
 };
 
 /* TDM Backend DAIs */
diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index d6adf7edea41..85a17d8861f2 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -5,6 +5,7 @@
 
 /* This driver implements the frontend capture DAI of AXG based SoCs */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/module.h>
@@ -19,12 +20,9 @@
 #define CTRL0_TODDR_EXT_SIGNED		BIT(29)
 #define CTRL0_TODDR_PP_MODE		BIT(28)
 #define CTRL0_TODDR_SYNC_CH		BIT(27)
-#define CTRL0_TODDR_TYPE_MASK		GENMASK(15, 13)
-#define CTRL0_TODDR_TYPE(x)		((x) << 13)
-#define CTRL0_TODDR_MSB_POS_MASK	GENMASK(12, 8)
-#define CTRL0_TODDR_MSB_POS(x)		((x) << 8)
-#define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
-#define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
+#define CTRL0_TODDR_TYPE		GENMASK(15, 13)
+#define CTRL0_TODDR_MSB_POS		GENMASK(12, 8)
+#define CTRL0_TODDR_LSB_POS		GENMASK(7, 3)
 #define CTRL1_TODDR_FORCE_FINISH	BIT(25)
 #define CTRL1_SEL_SHIFT			28
 
@@ -76,12 +74,12 @@ static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 	width = params_width(params);
 
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_TODDR_TYPE_MASK |
-			   CTRL0_TODDR_MSB_POS_MASK |
-			   CTRL0_TODDR_LSB_POS_MASK,
-			   CTRL0_TODDR_TYPE(type) |
-			   CTRL0_TODDR_MSB_POS(TODDR_MSB_POS) |
-			   CTRL0_TODDR_LSB_POS(TODDR_MSB_POS - (width - 1)));
+			   CTRL0_TODDR_TYPE |
+			   CTRL0_TODDR_MSB_POS |
+			   CTRL0_TODDR_LSB_POS,
+			   FIELD_PREP(CTRL0_TODDR_TYPE, type) |
+			   FIELD_PREP(CTRL0_TODDR_MSB_POS, TODDR_MSB_POS) |
+			   FIELD_PREP(CTRL0_TODDR_LSB_POS, TODDR_MSB_POS - (width - 1)));
 
 	return 0;
 }
diff --git a/sound/soc/tegra/tegra186_dspk.c b/sound/soc/tegra/tegra186_dspk.c
index a74c980ee775..d5a74e25371d 100644
--- a/sound/soc/tegra/tegra186_dspk.c
+++ b/sound/soc/tegra/tegra186_dspk.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: Copyright (c) 2020-2024 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 //
 // tegra186_dspk.c - Tegra186 DSPK driver
-//
-// Copyright (c) 2020 NVIDIA CORPORATION. All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -241,14 +240,14 @@ static int tegra186_dspk_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	cif_conf.client_bits = TEGRA_ACIF_BITS_24;
-
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		cif_conf.audio_bits = TEGRA_ACIF_BITS_16;
+		cif_conf.client_bits = TEGRA_ACIF_BITS_16;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		cif_conf.audio_bits = TEGRA_ACIF_BITS_32;
+		cif_conf.client_bits = TEGRA_ACIF_BITS_24;
 		break;
 	default:
 		dev_err(dev, "unsupported format!\n");
diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 56a19eeec5c7..5b82329f4440 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2423,12 +2423,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	mcasp_reparent_fck(pdev);
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
-					      &davinci_mcasp_dai[mcasp->op_mode], 1);
-
-	if (ret != 0)
-		goto err;
-
 	ret = davinci_mcasp_get_dma_type(mcasp);
 	switch (ret) {
 	case PCM_EDMA:
@@ -2455,6 +2449,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	ret = devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
+					      &davinci_mcasp_dai[mcasp->op_mode], 1);
+
+	if (ret != 0)
+		goto err;
+
 no_audio:
 	ret = davinci_mcasp_init_gpiochip(mcasp);
 	if (ret) {
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index b67617b68e50..f4437015d43a 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -202,7 +202,7 @@ int line6_send_raw_message_async(struct usb_line6 *line6, const char *buffer,
 	struct urb *urb;
 
 	/* create message: */
-	msg = kmalloc(sizeof(struct message), GFP_ATOMIC);
+	msg = kzalloc(sizeof(struct message), GFP_ATOMIC);
 	if (msg == NULL)
 		return -ENOMEM;
 
@@ -688,7 +688,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 	int ret;
 
 	/* initialize USB buffers: */
-	line6->buffer_listen = kmalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
+	line6->buffer_listen = kzalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
 	if (!line6->buffer_listen)
 		return -ENOMEM;
 
@@ -697,7 +697,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 		return -ENOMEM;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
-		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
+		line6->buffer_message = kzalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
 		if (!line6->buffer_message)
 			return -ENOMEM;
 
diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index b3d4bf08e70b..f382cd53cb4e 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -322,7 +322,7 @@ below the processor's base frequency.
 
 Busy% = MPERF_delta/TSC_delta
 
-Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
+Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
 
 Note that these calculations depend on TSC_delta, so they
 are not reliable during intervals when TSC_MHz is not running at the base frequency.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 65ada8065cfc..0822e7dc0fd8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1761,9 +1761,10 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	average.packages.rapl_dram_perf_status += p->rapl_dram_perf_status;
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW)
-			continue;
-		average.packages.counter[i] += p->counter[i];
+		if ((mp->format == FORMAT_RAW) && (topo.num_packages == 0))
+			average.packages.counter[i] = p->counter[i];
+		else
+			average.packages.counter[i] += p->counter[i];
 	}
 	return 0;
 }
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 48b9a803235a..d13ebde20322 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -21,9 +21,6 @@
  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *   GNU General Public License for more details.
  */
-
-
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
@@ -62,45 +59,47 @@ int clear_time_state(void)
 #define NUM_FREQ_OUTOFRANGE 4
 #define NUM_FREQ_INVALID 2
 
+#define SHIFTED_PPM (1 << 16)
+
 long valid_freq[NUM_FREQ_VALID] = {
-	-499<<16,
-	-450<<16,
-	-400<<16,
-	-350<<16,
-	-300<<16,
-	-250<<16,
-	-200<<16,
-	-150<<16,
-	-100<<16,
-	-75<<16,
-	-50<<16,
-	-25<<16,
-	-10<<16,
-	-5<<16,
-	-1<<16,
+	 -499 * SHIFTED_PPM,
+	 -450 * SHIFTED_PPM,
+	 -400 * SHIFTED_PPM,
+	 -350 * SHIFTED_PPM,
+	 -300 * SHIFTED_PPM,
+	 -250 * SHIFTED_PPM,
+	 -200 * SHIFTED_PPM,
+	 -150 * SHIFTED_PPM,
+	 -100 * SHIFTED_PPM,
+	  -75 * SHIFTED_PPM,
+	  -50 * SHIFTED_PPM,
+	  -25 * SHIFTED_PPM,
+	  -10 * SHIFTED_PPM,
+	   -5 * SHIFTED_PPM,
+	   -1 * SHIFTED_PPM,
 	-1000,
-	1<<16,
-	5<<16,
-	10<<16,
-	25<<16,
-	50<<16,
-	75<<16,
-	100<<16,
-	150<<16,
-	200<<16,
-	250<<16,
-	300<<16,
-	350<<16,
-	400<<16,
-	450<<16,
-	499<<16,
+	    1 * SHIFTED_PPM,
+	    5 * SHIFTED_PPM,
+	   10 * SHIFTED_PPM,
+	   25 * SHIFTED_PPM,
+	   50 * SHIFTED_PPM,
+	   75 * SHIFTED_PPM,
+	  100 * SHIFTED_PPM,
+	  150 * SHIFTED_PPM,
+	  200 * SHIFTED_PPM,
+	  250 * SHIFTED_PPM,
+	  300 * SHIFTED_PPM,
+	  350 * SHIFTED_PPM,
+	  400 * SHIFTED_PPM,
+	  450 * SHIFTED_PPM,
+	  499 * SHIFTED_PPM,
 };
 
 long outofrange_freq[NUM_FREQ_OUTOFRANGE] = {
-	-1000<<16,
-	-550<<16,
-	550<<16,
-	1000<<16,
+	-1000 * SHIFTED_PPM,
+	 -550 * SHIFTED_PPM,
+	  550 * SHIFTED_PPM,
+	 1000 * SHIFTED_PPM,
 };
 
 #define LONG_MAX (~0UL>>1)

