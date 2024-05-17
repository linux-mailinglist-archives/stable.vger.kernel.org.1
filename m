Return-Path: <stable+bounces-45388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D68C85FF
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 14:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF221F25EE4
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD845037;
	Fri, 17 May 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kMChuOIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310A50A67;
	Fri, 17 May 2024 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947121; cv=none; b=IXMHW38dbbs/fBJ14W/VCd9l/oLwMhDP75/InzgF+As9ahNBSPXj6M0EJYYSik8z8ujMOKT1UmwmOtSd+rQ9FCtFcynKPuv4uDuPDpEP/B19EZ/lZhjch9wa4RH7e5Mh8JZL4s3rnjiSD0nJE2RFaJqg3IGXG4eByVLVhYpNo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947121; c=relaxed/simple;
	bh=q6chlpaN8upgjy2wqqo5h34TDYHtTG+BLR7pXB/5PAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQS3KYcovaWbS+Mc1RmhKtt8rXXlxS/VAEgQbb9bJz3CXABiCTiY5YS05y1ddlbjewpFRbGM2+5BQXlKGl8GCsrM6yae/MJmWih5xIuy8Cql391sZJL6yZES+6m1s3nsW3XQby9h8BsH/dodpU+tvyZ990LDQlvaa+/kCtvKdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kMChuOIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F7BC2BD10;
	Fri, 17 May 2024 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715947120;
	bh=q6chlpaN8upgjy2wqqo5h34TDYHtTG+BLR7pXB/5PAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMChuOIF3PbiQhdiRtRytQBbLftb05oF8I7/SejMxzGrC7xtdhNadERXJfXOPaVXC
	 RCUwP13ICqvM6Ec0Y+FBYVsflCYETur9csapVMvzuG6bFq6q/PQ0InXm/jjH6gYn+T
	 TBccil1GN9O0LrgFHthvV4y1tho8t26rDWWFWAJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.91
Date: Fri, 17 May 2024 13:58:28 +0200
Message-ID: <2024051728-cope-grip-839d@gregkh>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <2024051728-hypocrisy-armband-32a1@gregkh>
References: <2024051728-hypocrisy-armband-32a1@gregkh>
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
diff --git a/MAINTAINERS b/MAINTAINERS
index ecf4d0c8f446..4b19dfb5d2fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22557,6 +22557,7 @@ F:	include/xen/swiotlb-xen.h
 
 XFS FILESYSTEM
 C:	irc://irc.oftc.net/xfs
+M:	Leah Rumancik <leah.rumancik@gmail.com>
 M:	Darrick J. Wong <djwong@kernel.org>
 L:	linux-xfs@vger.kernel.org
 S:	Supported
diff --git a/Makefile b/Makefile
index 7ae5cf9ec9e5..a7d90996e412 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 90
+SUBLEVEL = 91
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index a86a1d4f3461..93afd1005b43 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -127,6 +127,10 @@ cpu_resume_after_mmu:
 	instr_sync
 #endif
 	bl	cpu_init		@ restore the und/abt/irq banked regs
+#if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
+	mov	r0, sp
+	bl	kasan_unpoison_task_stack_below
+#endif
 	mov	r0, #0			@ return zero on success
 	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_resume_after_mmu)
diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
index bf4b3d9631ce..63731fb3d8f6 100644
--- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
+++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
@@ -337,16 +337,12 @@ int kvm_register_vgic_device(unsigned long type)
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
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0ce5f13eabb1..afb79209d413 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1679,15 +1679,15 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 
 	emit_call(enter_prog, ctx);
 
+	/* save return value to callee saved register x20 */
+	emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
+
 	/* if (__bpf_prog_enter(prog) == 0)
 	 *         goto skip_exec_of_prog;
 	 */
 	branch = ctx->image + ctx->idx;
 	emit(A64_NOP, ctx);
 
-	/* save return value to callee saved register x20 */
-	emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
-
 	emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
 	if (!p->jited)
 		emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
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
index c4501897b870..08342b9eccdb 100644
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
index 567aec4abac0..a8e569830ec8 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1309,16 +1309,13 @@ long arch_ptrace(struct task_struct *child, long request,
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
 		if (ptrace_report_syscall_entry(regs))
 			return -1;
-		syscall = current_thread_info()->syscall;
 	}
 
 #ifdef CONFIG_SECCOMP
@@ -1327,7 +1324,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 		struct seccomp_data sd;
 		unsigned long args[6];
 
-		sd.nr = syscall;
+		sd.nr = current_thread_info()->syscall;
 		sd.arch = syscall_get_arch(current);
 		syscall_get_arguments(current, regs, args);
 		for (i = 0; i < 6; i++)
@@ -1337,23 +1334,23 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
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
index 18dc9b345056..2c604717e630 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -77,6 +77,18 @@ loads_done:
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
@@ -114,16 +126,7 @@ syscall_trace_entry:
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
index e6264aa62e45..be11ea5cc67e 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -46,6 +46,8 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
+	LONG_S	v0, TI_SYSCALL($28)     # Store syscall number
+
 	li	t1, _TIF_WORK_SYSCALL_ENTRY
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -82,7 +84,6 @@ n64_syscall_exit:
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
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 1e5f083cdb72..5e00a3cde93b 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -781,8 +781,16 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	 * parent bus. During reboot, there will be ibm,dma-window property to
 	 * define DMA window. For kdump, there will at least be default window or DDW
 	 * or both.
+	 * There is an exception to the above. In case the PE goes into frozen
+	 * state, firmware may not provide ibm,dma-window property at the time
+	 * of LPAR boot up.
 	 */
 
+	if (!pdn) {
+		pr_debug("  no ibm,dma-window property !\n");
+		return;
+	}
+
 	ppci = PCI_DN(pdn);
 
 	pr_debug("  parent is %pOF, iommu_table: 0x%p\n",
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 63a1e1fe0185..25f95440a773 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -21,19 +21,6 @@
 
 #include "plpks.h"
 
-#define PKS_FW_OWNER	     0x1
-#define PKS_BOOTLOADER_OWNER 0x2
-#define PKS_OS_OWNER	     0x3
-
-#define LABEL_VERSION	    0
-#define MAX_LABEL_ATTR_SIZE 16
-#define MAX_NAME_SIZE	    239
-#define MAX_DATA_SIZE	    4000
-
-#define PKS_FLUSH_MAX_TIMEOUT 5000 //msec
-#define PKS_FLUSH_SLEEP	      10 //msec
-#define PKS_FLUSH_SLEEP_RANGE 400
-
 static u8 *ospassword;
 static u16 ospasswordlength;
 
@@ -60,7 +47,7 @@ struct label_attr {
 
 struct label {
 	struct label_attr attr;
-	u8 name[MAX_NAME_SIZE];
+	u8 name[PLPKS_MAX_NAME_SIZE];
 	size_t size;
 };
 
@@ -123,7 +110,7 @@ static int pseries_status_to_err(int rc)
 static int plpks_gen_password(void)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
-	u8 *password, consumer = PKS_OS_OWNER;
+	u8 *password, consumer = PLPKS_OS_OWNER;
 	int rc;
 
 	password = kzalloc(maxpwsize, GFP_KERNEL);
@@ -159,22 +146,18 @@ static struct plpks_auth *construct_auth(u8 consumer)
 {
 	struct plpks_auth *auth;
 
-	if (consumer > PKS_OS_OWNER)
+	if (consumer > PLPKS_OS_OWNER)
 		return ERR_PTR(-EINVAL);
 
-	auth = kmalloc(struct_size(auth, password, maxpwsize), GFP_KERNEL);
+	auth = kzalloc(struct_size(auth, password, maxpwsize), GFP_KERNEL);
 	if (!auth)
 		return ERR_PTR(-ENOMEM);
 
 	auth->version = 1;
 	auth->consumer = consumer;
-	auth->rsvd0 = 0;
-	auth->rsvd1 = 0;
 
-	if (consumer == PKS_FW_OWNER || consumer == PKS_BOOTLOADER_OWNER) {
-		auth->passwordlength = 0;
+	if (consumer == PLPKS_FW_OWNER || consumer == PLPKS_BOOTLOADER_OWNER)
 		return auth;
-	}
 
 	memcpy(auth->password, ospassword, ospasswordlength);
 
@@ -193,7 +176,7 @@ static struct label *construct_label(char *component, u8 varos, u8 *name,
 	struct label *label;
 	size_t slen;
 
-	if (!name || namelen > MAX_NAME_SIZE)
+	if (!name || namelen > PLPKS_MAX_NAME_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	slen = strlen(component);
@@ -207,9 +190,9 @@ static struct label *construct_label(char *component, u8 varos, u8 *name,
 	if (component)
 		memcpy(&label->attr.prefix, component, slen);
 
-	label->attr.version = LABEL_VERSION;
+	label->attr.version = PLPKS_LABEL_VERSION;
 	label->attr.os = varos;
-	label->attr.length = MAX_LABEL_ATTR_SIZE;
+	label->attr.length = PLPKS_MAX_LABEL_ATTR_SIZE;
 	memcpy(&label->name, name, namelen);
 
 	label->size = sizeof(struct label_attr) + namelen;
@@ -271,10 +254,9 @@ static int plpks_confirm_object_flushed(struct label *label,
 		if (!rc && status == 1)
 			break;
 
-		usleep_range(PKS_FLUSH_SLEEP,
-			     PKS_FLUSH_SLEEP + PKS_FLUSH_SLEEP_RANGE);
-		timeout = timeout + PKS_FLUSH_SLEEP;
-	} while (timeout < PKS_FLUSH_MAX_TIMEOUT);
+		fsleep(PLPKS_FLUSH_SLEEP);
+		timeout = timeout + PLPKS_FLUSH_SLEEP;
+	} while (timeout < PLPKS_MAX_TIMEOUT);
 
 	rc = pseries_status_to_err(rc);
 
@@ -289,13 +271,13 @@ int plpks_write_var(struct plpks_var var)
 	int rc;
 
 	if (!var.component || !var.data || var.datalen <= 0 ||
-	    var.namelen > MAX_NAME_SIZE || var.datalen > MAX_DATA_SIZE)
+	    var.namelen > PLPKS_MAX_NAME_SIZE || var.datalen > PLPKS_MAX_DATA_SIZE)
 		return -EINVAL;
 
-	if (var.policy & SIGNEDUPDATE)
+	if (var.policy & PLPKS_SIGNEDUPDATE)
 		return -EINVAL;
 
-	auth = construct_auth(PKS_OS_OWNER);
+	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
@@ -331,10 +313,10 @@ int plpks_remove_var(char *component, u8 varos, struct plpks_var_name vname)
 	struct label *label;
 	int rc;
 
-	if (!component || vname.namelen > MAX_NAME_SIZE)
+	if (!component || vname.namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
-	auth = construct_auth(PKS_OS_OWNER);
+	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
@@ -370,14 +352,14 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 	u8 *output;
 	int rc;
 
-	if (var->namelen > MAX_NAME_SIZE)
+	if (var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
 	auth = construct_auth(consumer);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
-	if (consumer == PKS_OS_OWNER) {
+	if (consumer == PLPKS_OS_OWNER) {
 		label = construct_label(var->component, var->os, var->name,
 					var->namelen);
 		if (IS_ERR(label)) {
@@ -392,7 +374,7 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 		goto out_free_label;
 	}
 
-	if (consumer == PKS_OS_OWNER)
+	if (consumer == PLPKS_OS_OWNER)
 		rc = plpar_hcall(H_PKS_READ_OBJECT, retbuf, virt_to_phys(auth),
 				 virt_to_phys(label), label->size, virt_to_phys(output),
 				 maxobjsize);
@@ -434,17 +416,17 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 
 int plpks_read_os_var(struct plpks_var *var)
 {
-	return plpks_read_var(PKS_OS_OWNER, var);
+	return plpks_read_var(PLPKS_OS_OWNER, var);
 }
 
 int plpks_read_fw_var(struct plpks_var *var)
 {
-	return plpks_read_var(PKS_FW_OWNER, var);
+	return plpks_read_var(PLPKS_FW_OWNER, var);
 }
 
 int plpks_read_bootloader_var(struct plpks_var *var)
 {
-	return plpks_read_var(PKS_BOOTLOADER_OWNER, var);
+	return plpks_read_var(PLPKS_BOOTLOADER_OWNER, var);
 }
 
 static __init int pseries_plpks_init(void)
diff --git a/arch/powerpc/platforms/pseries/plpks.h b/arch/powerpc/platforms/pseries/plpks.h
index 275ccd86bfb5..07278a990c2d 100644
--- a/arch/powerpc/platforms/pseries/plpks.h
+++ b/arch/powerpc/platforms/pseries/plpks.h
@@ -12,14 +12,39 @@
 #include <linux/types.h>
 #include <linux/list.h>
 
-#define OSSECBOOTAUDIT 0x40000000
-#define OSSECBOOTENFORCE 0x20000000
-#define WORLDREADABLE 0x08000000
-#define SIGNEDUPDATE 0x01000000
+// Object policy flags from supported_policies
+#define PLPKS_OSSECBOOTAUDIT	PPC_BIT32(1) // OS secure boot must be audit/enforce
+#define PLPKS_OSSECBOOTENFORCE	PPC_BIT32(2) // OS secure boot must be enforce
+#define PLPKS_PWSET		PPC_BIT32(3) // No access without password set
+#define PLPKS_WORLDREADABLE	PPC_BIT32(4) // Readable without authentication
+#define PLPKS_IMMUTABLE		PPC_BIT32(5) // Once written, object cannot be removed
+#define PLPKS_TRANSIENT		PPC_BIT32(6) // Object does not persist through reboot
+#define PLPKS_SIGNEDUPDATE	PPC_BIT32(7) // Object can only be modified by signed updates
+#define PLPKS_HVPROVISIONED	PPC_BIT32(28) // Hypervisor has provisioned this object
 
-#define PLPKS_VAR_LINUX	0x02
+// Signature algorithm flags from signed_update_algorithms
+#define PLPKS_ALG_RSA2048	PPC_BIT(0)
+#define PLPKS_ALG_RSA4096	PPC_BIT(1)
+
+// Object label OS metadata flags
+#define PLPKS_VAR_LINUX		0x02
 #define PLPKS_VAR_COMMON	0x04
 
+// Flags for which consumer owns an object is owned by
+#define PLPKS_FW_OWNER			0x1
+#define PLPKS_BOOTLOADER_OWNER		0x2
+#define PLPKS_OS_OWNER			0x3
+
+// Flags for label metadata fields
+#define PLPKS_LABEL_VERSION		0
+#define PLPKS_MAX_LABEL_ATTR_SIZE	16
+#define PLPKS_MAX_NAME_SIZE		239
+#define PLPKS_MAX_DATA_SIZE		4000
+
+// Timeouts for PLPKS operations
+#define PLPKS_MAX_TIMEOUT		(5 * USEC_PER_SEC)
+#define PLPKS_FLUSH_SLEEP		10000 // usec
+
 struct plpks_var {
 	char *component;
 	u8 *name;
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
index 662cf23a1b44..59657e0363e7 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2642,7 +2642,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 		return 0;
 
 	start = pmd_val(*pmd) & HPAGE_MASK;
-	end = start + HPAGE_SIZE - 1;
+	end = start + HPAGE_SIZE;
 	__storage_key_init_range(start, end);
 	set_bit(PG_arch_1, &page->flags);
 	cond_resched();
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index c299a18273ff..33ef6790114a 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -139,7 +139,7 @@ static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
 	}
 
 	if (!test_and_set_bit(PG_arch_1, &page->flags))
-		__storage_key_init_range(paddr, paddr + size - 1);
+		__storage_key_init_range(paddr, paddr + size);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index e6557024e3da..64b594d660b7 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1331,7 +1331,7 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	struct blkcg_gq *blkg = iocg_to_blkg(iocg);
-	u64 tdelta, delay, new_delay;
+	u64 tdelta, delay, new_delay, shift;
 	s64 vover, vover_pct;
 	u32 hwa;
 
@@ -1346,8 +1346,9 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 
 	/* calculate the current delay in effect - 1/2 every second */
 	tdelta = now->now - iocg->delay_at;
-	if (iocg->delay)
-		delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
+	shift = div64_u64(tdelta, USEC_PER_SEC);
+	if (iocg->delay && shift < BITS_PER_LONG)
+		delay = iocg->delay >> shift;
 	else
 		delay = 0;
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 47567ba1185a..99b8e2e44872 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -89,7 +89,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
 	uint64_t range[2];
-	uint64_t start, len;
+	uint64_t start, len, end;
 	struct inode *inode = bdev->bd_inode;
 	int err;
 
@@ -110,7 +110,8 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	if (len & 511)
 		return -EINVAL;
 
-	if (start + len > bdev_nr_bytes(bdev))
+	if (check_add_overflow(start, len, &end) ||
+	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
 	filemap_invalidate_lock(inode->i_mapping);
diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index c96fcf9ee3c0..01f050b1bc93 100644
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
index 5277090c6d6d..a0fadde993d7 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -99,7 +99,8 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	struct edl_event_hdr *edl;
-	char cmd, build_label[QCA_FW_BUILD_VER_LEN];
+	char *build_label;
+	char cmd;
 	int build_lbl_len, err = 0;
 
 	bt_dev_dbg(hdev, "QCA read fw build info");
@@ -114,6 +115,11 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 		return err;
 	}
 
+	if (skb->len < sizeof(*edl)) {
+		err = -EILSEQ;
+		goto out;
+	}
+
 	edl = (struct edl_event_hdr *)(skb->data);
 	if (!edl) {
 		bt_dev_err(hdev, "QCA read fw build info with no header");
@@ -129,14 +135,25 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 		goto out;
 	}
 
+	if (skb->len < sizeof(*edl) + 1) {
+		err = -EILSEQ;
+		goto out;
+	}
+
 	build_lbl_len = edl->data[0];
-	if (build_lbl_len <= QCA_FW_BUILD_VER_LEN - 1) {
-		memcpy(build_label, edl->data + 1, build_lbl_len);
-		*(build_label + build_lbl_len) = '\0';
+
+	if (skb->len < sizeof(*edl) + 1 + build_lbl_len) {
+		err = -EILSEQ;
+		goto out;
 	}
 
+	build_label = kstrndup(&edl->data[1], build_lbl_len, GFP_KERNEL);
+	if (!build_label)
+		goto out;
+
 	hci_set_fw_info(hdev, "%s", build_label);
 
+	kfree(build_label);
 out:
 	kfree_skb(skb);
 	return err;
@@ -205,6 +222,49 @@ static int qca_send_reset(struct hci_dev *hdev)
 	return 0;
 }
 
+static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
+{
+	u8 cmd;
+	struct sk_buff *skb;
+	struct edl_event_hdr *edl;
+	int err = 0;
+
+	cmd = EDL_GET_BID_REQ_CMD;
+	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
+				&cmd, 0, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Reading QCA board ID failed (%d)", err);
+		return err;
+	}
+
+	edl = skb_pull_data(skb, sizeof(*edl));
+	if (!edl) {
+		bt_dev_err(hdev, "QCA read board ID with no header");
+		err = -EILSEQ;
+		goto out;
+	}
+
+	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
+	    edl->rtype != EDL_GET_BID_REQ_CMD) {
+		bt_dev_err(hdev, "QCA Wrong packet: %d %d", edl->cresp, edl->rtype);
+		err = -EIO;
+		goto out;
+	}
+
+	if (skb->len < 3) {
+		err = -EILSEQ;
+		goto out;
+	}
+
+	*bid = (edl->data[1] << 8) + edl->data[2];
+	bt_dev_dbg(hdev, "%s: bid = %x", __func__, *bid);
+
+out:
+	kfree_skb(skb);
+	return err;
+}
+
 int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -227,9 +287,10 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
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
@@ -239,12 +300,16 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
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
 
@@ -253,6 +318,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 		bt_dev_dbg(hdev, "File version      : 0x%x", fw_data[6]);
 		break;
 	case TLV_TYPE_PATCH:
+		if (fw_size < sizeof(struct tlv_type_hdr) + sizeof(struct tlv_type_patch))
+			return -EINVAL;
+
 		tlv = (struct tlv_type_hdr *)fw_data;
 		type_len = le32_to_cpu(tlv->type_len);
 		tlv_patch = (struct tlv_type_patch *)tlv->data;
@@ -292,25 +360,56 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
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
@@ -326,6 +425,9 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
 				break;
 
 			case EDL_TAG_ID_DEEP_SLEEP:
+				if (tag_len < 1)
+					return -EINVAL;
+
 				/* Sleep enable mask
 				 * enabling deep sleep feature on controller.
 				 */
@@ -334,14 +436,16 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
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
@@ -491,7 +595,9 @@ static int qca_download_firmware(struct hci_dev *hdev,
 	memcpy(data, fw->data, size);
 	release_firmware(fw);
 
-	qca_tlv_check_data(hdev, config, data, soc_type);
+	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
+	if (ret)
+		goto out;
 
 	segment = data;
 	remain = size;
@@ -574,6 +680,23 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
+static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
+		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
+{
+	const char *variant;
+
+	/* hsp gf chip */
+	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
+		variant = "g";
+	else
+		variant = "";
+
+	if (bid == 0x0)
+		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
+	else
+		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
+}
+
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
 		   const char *firmware_name)
@@ -582,6 +705,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
+	u16 boardid = 0;
 
 	bt_dev_dbg(hdev, "QCA setup on UART");
 
@@ -615,6 +739,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/apbtfw%02x.tlv", rom_ver);
 		break;
+	case QCA_QCA2066:
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hpbtfw%02x.tlv", rom_ver);
+		break;
 	case QCA_QCA6390:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/htbtfw%02x.tlv", rom_ver);
@@ -649,6 +777,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Give the controller some time to get ready to receive the NVM */
 	msleep(10);
 
+	if (soc_type == QCA_QCA2066)
+		qca_read_fw_board_id(hdev, &boardid);
+
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	if (firmware_name) {
@@ -671,6 +802,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/apnv%02x.bin", rom_ver);
 			break;
+		case QCA_QCA2066:
+			qca_generate_hsp_nvm_name(config.fwname,
+				sizeof(config.fwname), ver, rom_ver, boardid);
+			break;
 		case QCA_QCA6390:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/htnv%02x.bin", rom_ver);
@@ -702,6 +837,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	switch (soc_type) {
 	case QCA_WCN3991:
+	case QCA_QCA2066:
 	case QCA_QCA6390:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 03bff5c0059d..38e2fbc95024 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -12,6 +12,7 @@
 #define EDL_PATCH_VER_REQ_CMD		(0x19)
 #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
 #define EDL_GET_BUILD_INFO_CMD		(0x20)
+#define EDL_GET_BID_REQ_CMD			(0x23)
 #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
 #define EDL_PATCH_CONFIG_CMD		(0x28)
 #define MAX_SIZE_PER_TLV_SEGMENT	(243)
@@ -46,8 +47,8 @@
 #define get_soc_ver(soc_id, rom_ver)	\
 	((le32_to_cpu(soc_id) << 16) | (le16_to_cpu(rom_ver)))
 
-#define QCA_FW_BUILD_VER_LEN		255
-
+#define QCA_HSP_GF_SOC_ID			0x1200
+#define QCA_HSP_GF_SOC_MASK			0x0000ff00
 
 enum qca_baudrate {
 	QCA_BAUDRATE_115200 	= 0,
@@ -146,6 +147,7 @@ enum qca_btsoc_type {
 	QCA_WCN3990,
 	QCA_WCN3998,
 	QCA_WCN3991,
+	QCA_QCA2066,
 	QCA_QCA6390,
 	QCA_WCN6750,
 	QCA_WCN6855,
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 179278b801eb..a0e2b5d99269 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1808,6 +1808,10 @@ static int qca_setup(struct hci_uart *hu)
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
 	switch (soc_type) {
+	case QCA_QCA2066:
+		soc_name = "qca2066";
+		break;
+
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2000,6 +2004,11 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
 	.num_vregs = 4,
 };
 
+static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
+	.soc_type = QCA_QCA2066,
+	.num_vregs = 0,
+};
+
 static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
 	.soc_type = QCA_QCA6390,
 	.num_vregs = 0,
@@ -2539,6 +2548,7 @@ static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id qca_bluetooth_of_match[] = {
+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},
 	{ .compatible = "qcom,qca6174-bt" },
 	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
 	{ .compatible = "qcom,qca9377-bt" },
@@ -2556,6 +2566,7 @@ MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
+	{ "QCOM2066", (kernel_ulong_t)&qca_soc_data_qca2066 },
 	{ "QCOM6390", (kernel_ulong_t)&qca_soc_data_qca6390 },
 	{ "DLA16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
 	{ "DLB16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index dc4c0a0a5129..30b4c288c1bb 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -155,7 +155,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 out:
 	if (!priv->response_length) {
 		*off = 0;
-		del_singleshot_timer_sync(&priv->user_read_timer);
+		del_timer_sync(&priv->user_read_timer);
 		flush_work(&priv->timeout_work);
 	}
 	mutex_unlock(&priv->buffer_mutex);
@@ -262,7 +262,7 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
 void tpm_common_release(struct file *file, struct file_priv *priv)
 {
 	flush_work(&priv->async_work);
-	del_singleshot_timer_sync(&priv->user_read_timer);
+	del_timer_sync(&priv->user_read_timer);
 	flush_work(&priv->timeout_work);
 	file->private_data = NULL;
 	priv->response_length = 0;
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fe1d45eac837..8ecbb8f49465 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4435,7 +4435,8 @@ void clk_unregister(struct clk *clk)
 	if (ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
-		goto unlock;
+		clk_prepare_unlock();
+		return;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -4469,11 +4470,10 @@ void clk_unregister(struct clk *clk)
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
 
@@ -4632,13 +4632,11 @@ void __clk_put(struct clk *clk)
 	if (clk->min_rate > 0 || clk->max_rate < ULONG_MAX)
 		clk_set_rate_range_nolock(clk, 0, ULONG_MAX);
 
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
index 42568c616181..892df807275c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -1181,11 +1181,18 @@ static const u32 usb2_clk_regs[] = {
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
 	void __iomem *reg;
+	int i, ret;
 	u32 val;
-	int i;
 
 	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
@@ -1252,7 +1259,15 @@ static int sun50i_h6_ccu_probe(struct platform_device *pdev)
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
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index a9b96b18772f..9f8adb7013eb 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -198,6 +198,18 @@ static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
 	int rc;
 
 	dev_dbg(&pdev->dev, "%s called\n", __func__);
+
+	/*
+	 * Due to an erratum in some of the devices supported by the driver,
+	 * direct user submission to the device can be unsafe.
+	 * (See the INTEL-SA-01084 security advisory)
+	 *
+	 * For the devices that exhibit this behavior, require that the user
+	 * has CAP_SYS_RAWIO capabilities.
+	 */
+	if (!idxd->user_submission_safe && !capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
 	rc = check_vma(wq, vma, __func__);
 	if (rc < 0)
 		return rc;
@@ -212,6 +224,70 @@ static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
 			vma->vm_page_prot);
 }
 
+static int idxd_submit_user_descriptor(struct idxd_user_context *ctx,
+				       struct dsa_hw_desc __user *udesc)
+{
+	struct idxd_wq *wq = ctx->wq;
+	struct idxd_dev *idxd_dev = &wq->idxd->idxd_dev;
+	const uint64_t comp_addr_align = is_dsa_dev(idxd_dev) ? 0x20 : 0x40;
+	void __iomem *portal = idxd_wq_portal_addr(wq);
+	struct dsa_hw_desc descriptor __aligned(64);
+	int rc;
+
+	rc = copy_from_user(&descriptor, udesc, sizeof(descriptor));
+	if (rc)
+		return -EFAULT;
+
+	/*
+	 * DSA devices are capable of indirect ("batch") command submission.
+	 * On devices where direct user submissions are not safe, we cannot
+	 * allow this since there is no good way for us to verify these
+	 * indirect commands.
+	 */
+	if (is_dsa_dev(idxd_dev) && descriptor.opcode == DSA_OPCODE_BATCH &&
+		!wq->idxd->user_submission_safe)
+		return -EINVAL;
+	/*
+	 * As per the programming specification, the completion address must be
+	 * aligned to 32 or 64 bytes. If this is violated the hardware
+	 * engine can get very confused (security issue).
+	 */
+	if (!IS_ALIGNED(descriptor.completion_addr, comp_addr_align))
+		return -EINVAL;
+
+	if (wq_dedicated(wq))
+		iosubmit_cmds512(portal, &descriptor, 1);
+	else {
+		descriptor.priv = 0;
+		descriptor.pasid = ctx->pasid;
+		rc = idxd_enqcmds(wq, portal, &descriptor);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+static ssize_t idxd_cdev_write(struct file *filp, const char __user *buf, size_t len,
+			       loff_t *unused)
+{
+	struct dsa_hw_desc __user *udesc = (struct dsa_hw_desc __user *)buf;
+	struct idxd_user_context *ctx = filp->private_data;
+	ssize_t written = 0;
+	int i;
+
+	for (i = 0; i < len/sizeof(struct dsa_hw_desc); i++) {
+		int rc = idxd_submit_user_descriptor(ctx, udesc + i);
+
+		if (rc)
+			return written ? written : rc;
+
+		written += sizeof(struct dsa_hw_desc);
+	}
+
+	return written;
+}
+
 static __poll_t idxd_cdev_poll(struct file *filp,
 			       struct poll_table_struct *wait)
 {
@@ -234,6 +310,7 @@ static const struct file_operations idxd_cdev_fops = {
 	.open = idxd_cdev_open,
 	.release = idxd_cdev_release,
 	.mmap = idxd_cdev_mmap,
+	.write = idxd_cdev_write,
 	.poll = idxd_cdev_poll,
 };
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7ced8d283d98..14c6ef987fed 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -258,6 +258,7 @@ struct idxd_driver_data {
 	struct device_type *dev_type;
 	int compl_size;
 	int align;
+	bool user_submission_safe;
 };
 
 struct idxd_device {
@@ -316,6 +317,8 @@ struct idxd_device {
 	struct idxd_pmu *idxd_pmu;
 
 	unsigned long *opcap_bmap;
+
+	bool user_submission_safe;
 };
 
 /* IDXD software descriptor */
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index e0f49545d89f..30193195c813 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -48,6 +48,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
 		.compl_size = sizeof(struct dsa_completion_record),
 		.align = 32,
 		.dev_type = &dsa_device_type,
+		.user_submission_safe = false, /* See INTEL-SA-01084 security advisory */
 	},
 	[IDXD_TYPE_IAX] = {
 		.name_prefix = "iax",
@@ -55,6 +56,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
 		.compl_size = sizeof(struct iax_completion_record),
 		.align = 64,
 		.dev_type = &iax_device_type,
+		.user_submission_safe = false, /* See INTEL-SA-01084 security advisory */
 	},
 };
 
@@ -663,6 +665,8 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev_info(&pdev->dev, "Intel(R) Accelerator Device (v%x)\n",
 		 idxd->hw.version);
 
+	idxd->user_submission_safe = data->user_submission_safe;
+
 	return 0;
 
  err_dev_register:
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index fe3b8d04f9db..fdfe7930f183 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -4,9 +4,6 @@
 #define _IDXD_REGISTERS_H_
 
 /* PCI Config */
-#define PCI_DEVICE_ID_INTEL_DSA_SPR0	0x0b25
-#define PCI_DEVICE_ID_INTEL_IAX_SPR0	0x0cfe
-
 #define DEVICE_VERSION_1		0x100
 #define DEVICE_VERSION_2		0x200
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6e1e14b376e6..c811757d0f97 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1162,12 +1162,35 @@ static ssize_t wq_enqcmds_retries_store(struct device *dev, struct device_attrib
 static struct device_attribute dev_attr_wq_enqcmds_retries =
 		__ATTR(enqcmds_retries, 0644, wq_enqcmds_retries_show, wq_enqcmds_retries_store);
 
+static ssize_t op_cap_show_common(struct device *dev, char *buf, unsigned long *opcap_bmap)
+{
+	ssize_t pos;
+	int i;
+
+	pos = 0;
+	for (i = IDXD_MAX_OPCAP_BITS/64 - 1; i >= 0; i--) {
+		unsigned long val = opcap_bmap[i];
+
+		/* On systems where direct user submissions are not safe, we need to clear out
+		 * the BATCH capability from the capability mask in sysfs since we cannot support
+		 * that command on such systems.
+		 */
+		if (i == DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submission_safe)
+			clear_bit(DSA_OPCODE_BATCH % 64, &val);
+
+		pos += sysfs_emit_at(buf, pos, "%*pb", 64, &val);
+		pos += sysfs_emit_at(buf, pos, "%c", i == 0 ? '\n' : ',');
+	}
+
+	return pos;
+}
+
 static ssize_t wq_op_config_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct idxd_wq *wq = confdev_to_wq(dev);
 
-	return sysfs_emit(buf, "%*pb\n", IDXD_MAX_OPCAP_BITS, wq->opcap_bmap);
+	return op_cap_show_common(dev, buf, wq->opcap_bmap);
 }
 
 static int idxd_verify_supported_opcap(struct idxd_device *idxd, unsigned long *opmask)
@@ -1381,7 +1404,7 @@ static ssize_t op_cap_show(struct device *dev,
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
-	return sysfs_emit(buf, "%*pb\n", IDXD_MAX_OPCAP_BITS, idxd->opcap_bmap);
+	return op_cap_show_common(dev, buf, idxd->opcap_bmap);
 }
 static DEVICE_ATTR_RO(op_cap);
 
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
index 1ee62cd58582..25db014494a4 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -92,7 +92,7 @@ static inline int to_reg(int gpio, enum ctrl_register reg_type)
 		case 0x5e:
 			return GPIOPANELCTL;
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
 
diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index c18b6b47384f..94ca9d03c094 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -104,7 +104,7 @@ static inline int to_reg(int gpio, enum ctrl_register type)
 	unsigned int reg = type == CTRL_IN ? GPIO_IN_CTRL_BASE : GPIO_OUT_CTRL_BASE;
 
 	if (gpio >= WCOVE_GPIO_NUM)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	return reg + gpio;
 }
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e40c93f0960b..97e8335716b0 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -5,6 +5,7 @@
 #include <linux/bitmap.h>
 #include <linux/build_bug.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/compat.h>
 #include <linux/compiler.h>
 #include <linux/device.h>
@@ -12,6 +13,7 @@
 #include <linux/file.h>
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
+#include <linux/hte.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
 #include <linux/kernel.h>
@@ -20,11 +22,13 @@
 #include <linux/mutex.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/poll.h>
+#include <linux/rbtree.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/timekeeping.h>
 #include <linux/uaccess.h>
 #include <linux/workqueue.h>
-#include <linux/hte.h>
+
 #include <uapi/linux/gpio.h>
 
 #include "gpiolib.h"
@@ -463,6 +467,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 
 /**
  * struct line - contains the state of a requested line
+ * @node: to store the object in supinfo_tree if supplemental
  * @desc: the GPIO descriptor for this line.
  * @req: the corresponding line request
  * @irq: the interrupt triggered in response to events on this GPIO
@@ -475,6 +480,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @line_seqno: the seqno for the current edge event in the sequence of
  * events for this line.
  * @work: the worker that implements software debouncing
+ * @debounce_period_us: the debounce period in microseconds
  * @sw_debounced: flag indicating if the software debouncer is active
  * @level: the current debounced physical level of the line
  * @hdesc: the Hardware Timestamp Engine (HTE) descriptor
@@ -483,6 +489,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @last_seqno: the last sequence number before debounce period expires
  */
 struct line {
+	struct rb_node node;
 	struct gpio_desc *desc;
 	/*
 	 * -- edge detector specific fields --
@@ -516,6 +523,15 @@ struct line {
 	 * -- debouncer specific fields --
 	 */
 	struct delayed_work work;
+	/*
+	 * debounce_period_us is accessed by debounce_irq_handler() and
+	 * process_hw_ts() which are disabled when modified by
+	 * debounce_setup(), edge_detector_setup() or edge_detector_stop()
+	 * or can live with a stale version when updated by
+	 * edge_detector_update().
+	 * The modifying functions are themselves mutually exclusive.
+	 */
+	unsigned int debounce_period_us;
 	/*
 	 * sw_debounce is accessed by linereq_set_config(), which is the
 	 * only setter, and linereq_get_values(), which can live with a
@@ -548,6 +564,17 @@ struct line {
 #endif /* CONFIG_HTE */
 };
 
+/*
+ * a rbtree of the struct lines containing supplemental info.
+ * Used to populate gpio_v2_line_info with cdev specific fields not contained
+ * in the struct gpio_desc.
+ * A line is determined to contain supplemental information by
+ * line_has_supinfo().
+ */
+static struct rb_root supinfo_tree = RB_ROOT;
+/* covers supinfo_tree */
+static DEFINE_SPINLOCK(supinfo_lock);
+
 /**
  * struct linereq - contains the state of a userspace line request
  * @gdev: the GPIO device the line request pertains to
@@ -560,7 +587,8 @@ struct line {
  * this line request.  Note that this is not used when @num_lines is 1, as
  * the line_seqno is then the same and is cheaper to calculate.
  * @config_mutex: mutex for serializing ioctl() calls to ensure consistency
- * of configuration, particularly multi-step accesses to desc flags.
+ * of configuration, particularly multi-step accesses to desc flags and
+ * changes to supinfo status.
  * @lines: the lines held by this line request, with @num_lines elements.
  */
 struct linereq {
@@ -575,6 +603,103 @@ struct linereq {
 	struct line lines[];
 };
 
+static void supinfo_insert(struct line *line)
+{
+	struct rb_node **new = &(supinfo_tree.rb_node), *parent = NULL;
+	struct line *entry;
+
+	guard(spinlock)(&supinfo_lock);
+
+	while (*new) {
+		entry = container_of(*new, struct line, node);
+
+		parent = *new;
+		if (line->desc < entry->desc) {
+			new = &((*new)->rb_left);
+		} else if (line->desc > entry->desc) {
+			new = &((*new)->rb_right);
+		} else {
+			/* this should never happen */
+			WARN(1, "duplicate line inserted");
+			return;
+		}
+	}
+
+	rb_link_node(&line->node, parent, new);
+	rb_insert_color(&line->node, &supinfo_tree);
+}
+
+static void supinfo_erase(struct line *line)
+{
+	guard(spinlock)(&supinfo_lock);
+
+	rb_erase(&line->node, &supinfo_tree);
+}
+
+static struct line *supinfo_find(struct gpio_desc *desc)
+{
+	struct rb_node *node = supinfo_tree.rb_node;
+	struct line *line;
+
+	while (node) {
+		line = container_of(node, struct line, node);
+		if (desc < line->desc)
+			node = node->rb_left;
+		else if (desc > line->desc)
+			node = node->rb_right;
+		else
+			return line;
+	}
+	return NULL;
+}
+
+static void supinfo_to_lineinfo(struct gpio_desc *desc,
+				struct gpio_v2_line_info *info)
+{
+	struct gpio_v2_line_attribute *attr;
+	struct line *line;
+
+	guard(spinlock)(&supinfo_lock);
+
+	line = supinfo_find(desc);
+	if (!line)
+		return;
+
+	attr = &info->attrs[info->num_attrs];
+	attr->id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
+	attr->debounce_period_us = READ_ONCE(line->debounce_period_us);
+	info->num_attrs++;
+}
+
+static inline bool line_has_supinfo(struct line *line)
+{
+	return READ_ONCE(line->debounce_period_us);
+}
+
+/*
+ * Checks line_has_supinfo() before and after the change to avoid unnecessary
+ * supinfo_tree access.
+ * Called indirectly by linereq_create() or linereq_set_config() so line
+ * is already protected from concurrent changes.
+ */
+static void line_set_debounce_period(struct line *line,
+				     unsigned int debounce_period_us)
+{
+	bool was_suppl = line_has_supinfo(line);
+
+	WRITE_ONCE(line->debounce_period_us, debounce_period_us);
+
+	/* if supinfo status is unchanged then we're done */
+	if (line_has_supinfo(line) == was_suppl)
+		return;
+
+	/* supinfo status has changed, so update the tree */
+	if (was_suppl)
+		supinfo_erase(line);
+	else
+		supinfo_insert(line);
+}
+
 #define GPIO_V2_LINE_BIAS_FLAGS \
 	(GPIO_V2_LINE_FLAG_BIAS_PULL_UP | \
 	 GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN | \
@@ -712,7 +837,7 @@ static enum hte_return process_hw_ts(struct hte_ts_data *ts, void *p)
 		line->total_discard_seq++;
 		line->last_seqno = ts->seq;
 		mod_delayed_work(system_wq, &line->work,
-		  usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
+		  usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
 	} else {
 		if (unlikely(ts->seq < line->line_seqno))
 			return HTE_CB_HANDLED;
@@ -853,7 +978,7 @@ static irqreturn_t debounce_irq_handler(int irq, void *p)
 	struct line *line = p;
 
 	mod_delayed_work(system_wq, &line->work,
-		usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
+		usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
 
 	return IRQ_HANDLED;
 }
@@ -935,7 +1060,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 	/* try hardware */
 	ret = gpiod_set_debounce(line->desc, debounce_period_us);
 	if (!ret) {
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
 		return ret;
 	}
 	if (ret != -ENOTSUPP)
@@ -1014,8 +1139,7 @@ static void edge_detector_stop(struct line *line)
 	cancel_delayed_work_sync(&line->work);
 	WRITE_ONCE(line->sw_debounced, 0);
 	WRITE_ONCE(line->edflags, 0);
-	if (line->desc)
-		WRITE_ONCE(line->desc->debounce_period_us, 0);
+	line_set_debounce_period(line, 0);
 	/* do not change line->level - see comment in debounced_value() */
 }
 
@@ -1040,7 +1164,7 @@ static int edge_detector_setup(struct line *line,
 		ret = debounce_setup(line, debounce_period_us);
 		if (ret)
 			return ret;
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
 	}
 
 	/* detection disabled or sw debouncer will provide edge detection */
@@ -1077,17 +1201,31 @@ static int edge_detector_update(struct line *line,
 				struct gpio_v2_line_config *lc,
 				unsigned int line_idx, u64 edflags)
 {
+	u64 eflags;
+	int ret;
 	u64 active_edflags = READ_ONCE(line->edflags);
 	unsigned int debounce_period_us =
 			gpio_v2_line_config_debounce_period(lc, line_idx);
 
 	if ((active_edflags == edflags) &&
-	    (READ_ONCE(line->desc->debounce_period_us) == debounce_period_us))
+	    (READ_ONCE(line->debounce_period_us) == debounce_period_us))
 		return 0;
 
 	/* sw debounced and still will be...*/
 	if (debounce_period_us && READ_ONCE(line->sw_debounced)) {
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
+		/*
+		 * ensure event fifo is initialised if edge detection
+		 * is now enabled.
+		 */
+		eflags = edflags & GPIO_V2_LINE_EDGE_FLAGS;
+		if (eflags && !kfifo_initialized(&line->req->events)) {
+			ret = kfifo_alloc(&line->req->events,
+					  line->req->event_buffer_size,
+					  GFP_KERNEL);
+			if (ret)
+				return ret;
+		}
 		return 0;
 	}
 
@@ -1564,13 +1702,18 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 
 static void linereq_free(struct linereq *lr)
 {
+	struct line *line;
 	unsigned int i;
 
 	for (i = 0; i < lr->num_lines; i++) {
-		if (lr->lines[i].desc) {
-			edge_detector_stop(&lr->lines[i]);
-			gpiod_free(lr->lines[i].desc);
-		}
+		line = &lr->lines[i];
+		if (!line->desc)
+			continue;
+
+		edge_detector_stop(line);
+		if (line_has_supinfo(line))
+			supinfo_erase(line);
+		gpiod_free(line->desc);
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
@@ -2237,8 +2380,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	struct gpio_chip *gc = desc->gdev->chip;
 	bool ok_for_pinctrl;
 	unsigned long flags;
-	u32 debounce_period_us;
-	unsigned int num_attrs = 0;
 
 	memset(info, 0, sizeof(*info));
 	info->offset = gpio_chip_hwgpio(desc);
@@ -2305,14 +2446,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags))
 		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
 
-	debounce_period_us = READ_ONCE(desc->debounce_period_us);
-	if (debounce_period_us) {
-		info->attrs[num_attrs].id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
-		info->attrs[num_attrs].debounce_period_us = debounce_period_us;
-		num_attrs++;
-	}
-	info->num_attrs = num_attrs;
-
 	spin_unlock_irqrestore(&gpio_lock, flags);
 }
 
@@ -2418,6 +2551,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 			return -EBUSY;
 	}
 	gpio_desc_to_lineinfo(desc, &lineinfo);
+	supinfo_to_lineinfo(desc, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
 		if (watch)
@@ -2521,6 +2655,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	chg.event_type = action;
 	chg.timestamp_ns = ktime_get_ns();
 	gpio_desc_to_lineinfo(desc, &chg.info);
+	supinfo_to_lineinfo(desc, &chg.info);
 
 	ret = kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.lock);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3bf0e893c07d..f34bc9bb7045 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -301,12 +301,15 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		dma_fence_set_error(finished, -ECANCELED);
 
 	if (finished->error < 0) {
-		DRM_INFO("Skip scheduling IBs!\n");
+		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
+			ring->name);
 	} else {
 		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
 				       &fence);
 		if (r)
-			DRM_ERROR("Error scheduling IBs (%d)\n", r);
+			dev_err(adev->dev,
+				"Error scheduling IBs (%d) in ring(%s)", r,
+				ring->name);
 	}
 
 	job->job_run_counter++;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cde2fd2f7117..9a111988b7f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1222,14 +1222,18 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
  * amdgpu_bo_move_notify - notification about a memory move
  * @bo: pointer to a buffer object
  * @evict: if this move is evicting the buffer from the graphics address space
+ * @new_mem: new resource for backing the BO
  *
  * Marks the corresponding &amdgpu_bo buffer object as invalid, also performs
  * bookkeeping.
  * TTM driver callback which is called when ttm moves a buffer.
  */
-void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
+void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
+			   bool evict,
+			   struct ttm_resource *new_mem)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
+	struct ttm_resource *old_mem = bo->resource;
 	struct amdgpu_bo *abo;
 
 	if (!amdgpu_bo_is_amdgpu_bo(bo))
@@ -1241,12 +1245,12 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
 	amdgpu_bo_kunmap(abo);
 
 	if (abo->tbo.base.dma_buf && !abo->tbo.base.import_attach &&
-	    bo->resource->mem_type != TTM_PL_SYSTEM)
+	    old_mem && old_mem->mem_type != TTM_PL_SYSTEM)
 		dma_buf_move_notify(abo->tbo.base.dma_buf);
 
-	/* remember the eviction */
-	if (evict)
-		atomic64_inc(&adev->num_evictions);
+	/* move_notify is called before move happens */
+	trace_amdgpu_bo_move(abo, new_mem ? new_mem->mem_type : -1,
+			     old_mem ? old_mem->mem_type : -1);
 }
 
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 2ada421e79e4..6dcd7bab42fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -312,7 +312,9 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			   size_t buffer_size, uint32_t *metadata_size,
 			   uint64_t *flags);
-void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
+void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
+			   bool evict,
+			   struct ttm_resource *new_mem);
 void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
 vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
 void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index dfb9d4200773..7afefaa37427 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -483,14 +483,16 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
 	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
 			 bo->ttm == NULL)) {
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		goto out;
+		return 0;
 	}
 	if (old_mem->mem_type == TTM_PL_SYSTEM &&
 	    (new_mem->mem_type == TTM_PL_TT ||
 	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		goto out;
+		return 0;
 	}
 	if ((old_mem->mem_type == TTM_PL_TT ||
 	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
@@ -500,9 +502,10 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 			return r;
 
 		amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_resource_free(bo, &bo->resource);
 		ttm_bo_assign_mem(bo, new_mem);
-		goto out;
+		return 0;
 	}
 
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
@@ -512,8 +515,9 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	    new_mem->mem_type == AMDGPU_PL_GWS ||
 	    new_mem->mem_type == AMDGPU_PL_OA) {
 		/* Nothing to save here */
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
-		goto out;
+		return 0;
 	}
 
 	if (bo->type == ttm_bo_type_device &&
@@ -525,22 +529,23 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		abo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	}
 
-	if (adev->mman.buffer_funcs_enabled) {
-		if (((old_mem->mem_type == TTM_PL_SYSTEM &&
-		      new_mem->mem_type == TTM_PL_VRAM) ||
-		     (old_mem->mem_type == TTM_PL_VRAM &&
-		      new_mem->mem_type == TTM_PL_SYSTEM))) {
-			hop->fpfn = 0;
-			hop->lpfn = 0;
-			hop->mem_type = TTM_PL_TT;
-			hop->flags = TTM_PL_FLAG_TEMPORARY;
-			return -EMULTIHOP;
-		}
+	if (adev->mman.buffer_funcs_enabled &&
+	    ((old_mem->mem_type == TTM_PL_SYSTEM &&
+	      new_mem->mem_type == TTM_PL_VRAM) ||
+	     (old_mem->mem_type == TTM_PL_VRAM &&
+	      new_mem->mem_type == TTM_PL_SYSTEM))) {
+		hop->fpfn = 0;
+		hop->lpfn = 0;
+		hop->mem_type = TTM_PL_TT;
+		hop->flags = TTM_PL_FLAG_TEMPORARY;
+		return -EMULTIHOP;
+	}
 
+	amdgpu_bo_move_notify(bo, evict, new_mem);
+	if (adev->mman.buffer_funcs_enabled)
 		r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
-	} else {
+	else
 		r = -ENODEV;
-	}
 
 	if (r) {
 		/* Check that all memory is CPU accessible */
@@ -555,11 +560,10 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 			return r;
 	}
 
-	trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
-out:
-	/* update statistics */
+	/* update statistics after the move */
+	if (evict)
+		atomic64_inc(&adev->num_evictions);
 	atomic64_add(bo->base.size, &adev->num_bytes_moved);
-	amdgpu_bo_move_notify(bo, evict);
 	return 0;
 }
 
@@ -1505,7 +1509,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
-	amdgpu_bo_move_notify(bo, false);
+	amdgpu_bo_move_notify(bo, false, NULL);
 }
 
 static struct ttm_device_funcs amdgpu_bo_driver = {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3f403afd6de8..b0f475d51ae7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1106,7 +1106,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			goto err_unlock;
 		}
 		offset = dev->adev->rmmio_remap.bus_addr;
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
@@ -2215,7 +2215,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 			return -EINVAL;
 		}
 		offset = pdd->dev->adev->rmmio_remap.bus_addr;
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			pr_err("amdgpu_amdkfd_get_mmio_remap_phys_addr failed\n");
 			return -ENOMEM;
 		}
@@ -2886,6 +2886,9 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+	if (PAGE_SIZE > 4096)
+		return -EINVAL;
+
 	address = dev->adev->rmmio_remap.bus_addr;
 
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 93e40e0a1508..4d2590964a20 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2962,6 +2962,7 @@ static enum bp_result construct_integrated_info(
 				result = get_integrated_info_v2_1(bp, info);
 				break;
 			case 2:
+			case 3:
 				result = get_integrated_info_v2_2(bp, info);
 				break;
 			default:
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
index 80dfaa4d4d81..eb3a4624f781 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
@@ -393,6 +393,12 @@ void dcn31_hpo_dp_link_enc_set_throttled_vcp_size(
 				x),
 			25));
 
+	// If y rounds up to integer, carry it over to x.
+	if (y >> 25) {
+		x += 1;
+		y = 0;
+	}
+
 	switch (stream_encoder_inst) {
 	case 0:
 		REG_SET_2(DP_DPHY_SYM32_VC_RATE_CNTL0, 0,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 21b374d12181..5de31961319a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -222,7 +222,7 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!en && !adev->in_s0ix) {
+	if (!en && adev->in_s4) {
 		/* Adds a GFX reset as workaround just before sending the
 		 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
 		 * an invalid state.
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 27de2a97f1d1..3d18d840ef3b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2707,7 +2707,7 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
 						     dev->mode_config.max_width,
 						     dev->mode_config.max_height);
 		else
-			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe",
+			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe\n",
 				    connector->base.id, connector->name);
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 9cc1ef2ca72c..efbb0cffd3bc 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -1034,22 +1034,11 @@ parse_lfp_backlight(struct drm_i915_private *i915,
 
 	panel->vbt.backlight.type = INTEL_BACKLIGHT_DISPLAY_DDI;
 	if (i915->display.vbt.version >= 191) {
-		size_t exp_size;
+		const struct lfp_backlight_control_method *method;
 
-		if (i915->display.vbt.version >= 236)
-			exp_size = sizeof(struct bdb_lfp_backlight_data);
-		else if (i915->display.vbt.version >= 234)
-			exp_size = EXP_BDB_LFP_BL_DATA_SIZE_REV_234;
-		else
-			exp_size = EXP_BDB_LFP_BL_DATA_SIZE_REV_191;
-
-		if (get_blocksize(backlight_data) >= exp_size) {
-			const struct lfp_backlight_control_method *method;
-
-			method = &backlight_data->backlight_control[panel_type];
-			panel->vbt.backlight.type = method->type;
-			panel->vbt.backlight.controller = method->controller;
-		}
+		method = &backlight_data->backlight_control[panel_type];
+		panel->vbt.backlight.type = method->type;
+		panel->vbt.backlight.controller = method->controller;
 	}
 
 	panel->vbt.backlight.pwm_freq_hz = entry->pwm_freq_hz;
diff --git a/drivers/gpu/drm/i915/display/intel_vbt_defs.h b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
index a9f44abfc9fc..b50cd0dcabda 100644
--- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
+++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
@@ -897,11 +897,6 @@ struct lfp_brightness_level {
 	u16 reserved;
 } __packed;
 
-#define EXP_BDB_LFP_BL_DATA_SIZE_REV_191 \
-	offsetof(struct bdb_lfp_backlight_data, brightness_level)
-#define EXP_BDB_LFP_BL_DATA_SIZE_REV_234 \
-	offsetof(struct bdb_lfp_backlight_data, brightness_precision_bits)
-
 struct bdb_lfp_backlight_data {
 	u8 entry_size;
 	struct lfp_backlight_data_entry data[16];
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
index 53185746fb3d..17e1e23a780e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -109,12 +109,15 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
 	u8 *dpcd = nv_encoder->dp.dpcd;
 	int ret = NOUVEAU_DP_NONE, hpd;
 
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
index 39dc40cf681f..285e76818d84 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -420,7 +420,7 @@ static int ili9341_dpi_prepare(struct drm_panel *panel)
 
 	ili9341_dpi_init(ili);
 
-	return ret;
+	return 0;
 }
 
 static int ili9341_dpi_enable(struct drm_panel *panel)
@@ -717,18 +717,18 @@ static int ili9341_probe(struct spi_device *spi)
 
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
 
 static void ili9341_remove(struct spi_device *spi)
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 9febc8b73f09..368d26da0d6a 100644
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
index 66cc35dc223e..95344735d00e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -991,7 +991,7 @@ static int vmw_event_fence_action_create(struct drm_file *file_priv,
 	}
 
 	event->event.base.type = DRM_VMW_EVENT_FENCE_SIGNALED;
-	event->event.base.length = sizeof(*event);
+	event->event.base.length = sizeof(event->event);
 	event->event.user_data = user_data;
 
 	ret = drm_event_reserve_init(dev, file_priv, &event->base, &event->event.base);
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index bdee16a0bb8e..ba622fb5e482 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -368,11 +368,6 @@ static int host1x_device_uevent(struct device *dev,
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
@@ -386,7 +381,6 @@ struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
 	.uevent = host1x_device_uevent,
-	.dma_configure = host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
 };
 
@@ -475,8 +469,6 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
-	of_dma_configure(&device->dev, host1x->dev->of_node, true);
-
 	device->dev.dma_parms = &device->dma_parms;
 	dma_set_max_seg_size(&device->dev, UINT_MAX);
 
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 56f7e06c673e..47e1bd8de9fc 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -153,7 +153,9 @@ void vmbus_free_ring(struct vmbus_channel *channel)
 	hv_ringbuffer_cleanup(&channel->inbound);
 
 	if (channel->ringbuffer_page) {
-		__free_pages(channel->ringbuffer_page,
+		/* In a CoCo VM leak the memory if it didn't get re-encrypted */
+		if (!channel->ringbuffer_gpadlhandle.decrypted)
+			__free_pages(channel->ringbuffer_page,
 			     get_order(channel->ringbuffer_pagecount
 				       << PAGE_SHIFT));
 		channel->ringbuffer_page = NULL;
@@ -472,9 +474,18 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
 
 	ret = create_gpadl_header(type, kbuffer, size, send_offset, &msginfo);
-	if (ret)
+	if (ret) {
+		gpadl->decrypted = false;
 		return ret;
+	}
 
+	/*
+	 * Set the "decrypted" flag to true for the set_memory_decrypted()
+	 * success case. In the failure case, the encryption state of the
+	 * memory is unknown. Leave "decrypted" as true to ensure the
+	 * memory will be leaked instead of going back on the free list.
+	 */
+	gpadl->decrypted = true;
 	ret = set_memory_decrypted((unsigned long)kbuffer,
 				   PFN_UP(size));
 	if (ret) {
@@ -563,9 +574,15 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 
 	kfree(msginfo);
 
-	if (ret)
-		set_memory_encrypted((unsigned long)kbuffer,
-				     PFN_UP(size));
+	if (ret) {
+		/*
+		 * If set_memory_encrypted() fails, the decrypted flag is
+		 * left as true so the memory is leaked instead of being
+		 * put back on the free list.
+		 */
+		if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
+			gpadl->decrypted = false;
+	}
 
 	return ret;
 }
@@ -886,6 +903,8 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 	if (ret)
 		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
 
+	gpadl->decrypted = ret;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
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
index 2d939773445d..e2931ea8af1f 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1126,6 +1126,7 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	struct device *dev = &st->adis.spi->dev;
 	const struct adis16475_sync *sync;
 	u32 sync_mode;
+	u16 val;
 
 	/* default to internal clk */
 	st->clk_freq = st->info->int_clk * 1000;
@@ -1187,8 +1188,9 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
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
index a973905afd13..182a89bb24ef 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -440,6 +440,7 @@ static int remove_device_files(struct super_block *sb,
 		return PTR_ERR(dir);
 	}
 	simple_recursive_removal(dir, NULL);
+	dput(dir);
 	return 0;
 }
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0ba2a63a9538..576163f88a4a 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1570,6 +1570,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8195-iommu-vpp",   .data = &mt8195_data_vpp},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index a978220eb620..5dd06bcb507f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -602,6 +602,7 @@ static const struct of_device_id mtk_iommu_v1_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-m4u", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_v1_of_ids);
 
 static const struct component_master_ops mtk_iommu_v1_com_ops = {
 	.bind		= mtk_iommu_v1_bind,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 788acc81e7a8..506c998c0ca5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2508,6 +2508,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
  fail:
 	pr_warn("md: failed to register dev-%s for %s\n",
 		b, mdname(mddev));
+	mddev_destroy_serial_pool(mddev, rdev, false);
 	return err;
 }
 
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 938c4f41b98c..e664c1c85250 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -581,6 +581,31 @@ static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
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
@@ -756,14 +781,6 @@ static int at24_probe(struct i2c_client *client)
 	}
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
 	 * Perform a one-byte test read to verify that the chip is functional,
 	 * unless powering on the device is to be avoided during probe (i.e.
@@ -779,6 +796,19 @@ static int at24_probe(struct i2c_client *client)
 		}
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
index 3390ff511103..d3c03d4edbef 100644
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
index a617f64a351d..a4bdc4128458 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -122,6 +122,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_H, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ba906dfab055..517c50d11fbc 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5677,7 +5677,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6141,
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6141",
-		.num_databases = 4096,
+		.num_databases = 256,
 		.num_macs = 2048,
 		.num_ports = 6,
 		.num_internal_phys = 5,
@@ -6134,7 +6134,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6341,
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6341",
-		.num_databases = 4096,
+		.num_databases = 256,
 		.num_macs = 2048,
 		.num_internal_phys = 5,
 		.num_ports = 6,
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index c2a991308215..f087a9716409 100644
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
@@ -2468,14 +2468,18 @@ static void umac_enable_set(struct bcmgenet_priv *priv, u32 mask, bool enable)
 {
 	u32 reg;
 
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
-	if (reg & CMD_SW_RESET)
+	if (reg & CMD_SW_RESET) {
+		spin_unlock_bh(&priv->reg_lock);
 		return;
+	}
 	if (enable)
 		reg |= mask;
 	else
 		reg &= ~mask;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	/* UniMAC stops on a packet boundary, wait for a full-size packet
 	 * to be processed
@@ -2491,8 +2495,10 @@ static void reset_umac(struct bcmgenet_priv *priv)
 	udelay(10);
 
 	/* issue soft reset and disable MAC while updating its registers */
+	spin_lock_bh(&priv->reg_lock);
 	bcmgenet_umac_writel(priv, CMD_SW_RESET, UMAC_CMD);
 	udelay(2);
+	spin_unlock_bh(&priv->reg_lock);
 }
 
 static void bcmgenet_intr_disable(struct bcmgenet_priv *priv)
@@ -3298,7 +3304,7 @@ static void bcmgenet_get_hw_addr(struct bcmgenet_priv *priv,
 }
 
 /* Returns a reusable dma control register value */
-static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv)
+static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv, bool flush_rx)
 {
 	unsigned int i;
 	u32 reg;
@@ -3323,6 +3329,14 @@ static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv)
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
 
@@ -3344,7 +3358,9 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	/* Start the network engine */
+	netif_addr_lock_bh(dev);
 	bcmgenet_set_rx_mode(dev);
+	netif_addr_unlock_bh(dev);
 	bcmgenet_enable_rx_napi(priv);
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);
@@ -3386,8 +3402,8 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
 
-	/* Disable RX/TX DMA and flush TX queues */
-	dma_ctrl = bcmgenet_dma_disable(priv);
+	/* Disable RX/TX DMA and flush TX and RX queues */
+	dma_ctrl = bcmgenet_dma_disable(priv, true);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv);
@@ -3605,16 +3621,19 @@ static void bcmgenet_set_rx_mode(struct net_device *dev)
 	 * 3. The number of filters needed exceeds the number filters
 	 *    supported by the hardware.
 	*/
+	spin_lock(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	if ((dev->flags & (IFF_PROMISC | IFF_ALLMULTI)) ||
 	    (nfilter > MAX_MDF_FILTER)) {
 		reg |= CMD_PROMISC;
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+		spin_unlock(&priv->reg_lock);
 		bcmgenet_umac_writel(priv, 0, UMAC_MDF_CTRL);
 		return;
 	} else {
 		reg &= ~CMD_PROMISC;
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+		spin_unlock(&priv->reg_lock);
 	}
 
 	/* update MDF filter */
@@ -4016,6 +4035,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	spin_lock_init(&priv->reg_lock);
 	spin_lock_init(&priv->lock);
 
 	/* Set default pause parameters */
@@ -4258,7 +4278,7 @@ static int bcmgenet_resume(struct device *d)
 			bcmgenet_hfb_create_rxnfc_filter(priv, rule);
 
 	/* Disable RX/TX DMA and flush TX queues */
-	dma_ctrl = bcmgenet_dma_disable(priv);
+	dma_ctrl = bcmgenet_dma_disable(priv, false);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 1985c0ec4da2..28e2c94ef835 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #ifndef __BCMGENET_H__
@@ -573,6 +573,8 @@ struct bcmgenet_rxnfc_rule {
 /* device context */
 struct bcmgenet_priv {
 	void __iomem *base;
+	/* reg_lock: lock to serialize access to shared registers */
+	spinlock_t reg_lock;
 	enum bcmgenet_version version;
 	struct net_device *dev;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index f55d9d9c01a8..56781e721497 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET (Gigabit Ethernet) Wake-on-LAN support
  *
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)				"bcmgenet_wol: " fmt
@@ -133,6 +133,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Can't suspend with WoL if MAC is still in reset */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	if (reg & CMD_SW_RESET)
 		reg &= ~CMD_SW_RESET;
@@ -140,6 +141,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* disable RX */
 	reg &= ~CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 	mdelay(10);
 
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
@@ -185,6 +187,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Enable CRC forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	priv->crc_fwd_en = 1;
 	reg |= CMD_CRC_FWD;
@@ -192,6 +195,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* Receiver must be enabled for WOL MP detection */
 	reg |= CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	reg = UMAC_IRQ_MPD_R;
 	if (hfb_enable)
@@ -238,7 +242,9 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Disable CRC Forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~CMD_CRC_FWD;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 1779ee524dac..f21f2aaa6fd9 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET MDIO routines
  *
- * Copyright (c) 2014-2017 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #include <linux/acpi.h>
@@ -72,10 +72,10 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	 * Receive clock is provided by the PHY.
 	 */
 	reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
-	reg &= ~OOB_DISABLE;
 	reg |= RGMII_LINK;
 	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~((CMD_SPEED_MASK << CMD_SPEED_SHIFT) |
 		       CMD_HD_EN |
@@ -88,6 +88,7 @@ static void bcmgenet_mac_config(struct net_device *dev)
 		reg |= CMD_TX_EN | CMD_RX_EN;
 	}
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	priv->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
 	bcmgenet_eee_enable_set(dev,
@@ -100,10 +101,18 @@ static void bcmgenet_mac_config(struct net_device *dev)
  */
 void bcmgenet_mii_setup(struct net_device *dev)
 {
+	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct phy_device *phydev = dev->phydev;
+	u32 reg;
 
-	if (phydev->link)
+	if (phydev->link) {
 		bcmgenet_mac_config(dev);
+	} else {
+		reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
+		reg &= ~RGMII_LINK;
+		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+	}
+
 	phy_print_status(phydev);
 }
 
@@ -264,18 +273,22 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 			(priv->phy_interface != PHY_INTERFACE_MODE_MOCA);
 
 	/* This is an external PHY (xMII), so we need to enable the RGMII
-	 * block for the interface to work
+	 * block for the interface to work, unconditionally clear the
+	 * Out-of-band disable since we do not need it.
 	 */
+	mutex_lock(&phydev->lock);
+	reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
+	reg &= ~OOB_DISABLE;
 	if (priv->ext_phy) {
-		reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 		reg &= ~ID_MODE_DIS;
 		reg |= id_mode_dis;
 		if (GENET_IS_V1(priv) || GENET_IS_V2(priv) || GENET_IS_V3(priv))
 			reg |= RGMII_MODE_EN_V123;
 		else
 			reg |= RGMII_MODE_EN;
-		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 	}
+	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+	mutex_unlock(&phydev->lock);
 
 	if (init)
 		dev_info(kdev, "configuring instance for %s\n", phy_name);
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
index 46809e2d94ee..4809d9eae6ca 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2684,12 +2684,12 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
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
 
@@ -2724,7 +2724,7 @@ int cxgb4_selftest_lb_pkt(struct net_device *netdev)
 	init_completion(&lb->completion);
 	txq_advance(&q->q, ndesc);
 	cxgb4_ring_tx_db(adap, &q->q, ndesc);
-	__netif_tx_unlock(q->txq);
+	__netif_tx_unlock_bh(q->txq);
 
 	/* wait for the pkt to return */
 	ret = wait_for_completion_timeout(&lb->completion, 10 * HZ);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index c693bb701ba3..60b8d61af07f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -873,7 +873,7 @@ struct hnae3_handle {
 		struct hnae3_roce_private_info rinfo;
 	};
 
-	u32 numa_node_mask;	/* for multi-chip support */
+	nodemask_t numa_node_mask; /* for multi-chip support */
 
 	enum hnae3_port_base_vlan_state port_base_vlan_state;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9db363fbc34f..a2655adc764c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1624,6 +1624,9 @@ static int hclge_configure(struct hclge_dev *hdev)
 			cfg.default_speed, ret);
 		return ret;
 	}
+	hdev->hw.mac.req_speed = hdev->hw.mac.speed;
+	hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
+	hdev->hw.mac.req_duplex = DUPLEX_FULL;
 
 	hclge_parse_link_mode(hdev, cfg.speed_ability);
 
@@ -1853,7 +1856,8 @@ static int hclge_vport_setup(struct hclge_vport *vport, u16 num_tqps)
 
 	nic->pdev = hdev->pdev;
 	nic->ae_algo = &ae_algo;
-	nic->numa_node_mask = hdev->numa_node_mask;
+	bitmap_copy(nic->numa_node_mask.bits, hdev->numa_node_mask.bits,
+		    MAX_NUMNODES);
 	nic->kinfo.io_base = hdev->hw.hw.io_base;
 
 	ret = hclge_knic_setup(vport, num_tqps,
@@ -2545,7 +2549,8 @@ static int hclge_init_roce_base_info(struct hclge_vport *vport)
 
 	roce->pdev = nic->pdev;
 	roce->ae_algo = nic->ae_algo;
-	roce->numa_node_mask = nic->numa_node_mask;
+	bitmap_copy(roce->numa_node_mask.bits, nic->numa_node_mask.bits,
+		    MAX_NUMNODES);
 
 	return 0;
 }
@@ -3429,9 +3434,9 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
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
@@ -3464,9 +3469,9 @@ static int hclge_tp_port_init(struct hclge_dev *hdev)
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
@@ -8046,8 +8051,7 @@ static void hclge_set_timer_task(struct hnae3_handle *handle, bool enable)
 		/* Set the DOWN flag here to disable link updating */
 		set_bit(HCLGE_STATE_DOWN, &hdev->state);
 
-		/* flush memory to make sure DOWN is seen by service task */
-		smp_mb__before_atomic();
+		smp_mb__after_atomic(); /* flush memory to make sure DOWN is seen by service task */
 		hclge_flush_link_update(hdev);
 	}
 }
@@ -10000,6 +10004,7 @@ static int hclge_set_vlan_protocol_type(struct hclge_dev *hdev)
 static int hclge_init_vlan_filter(struct hclge_dev *hdev)
 {
 	struct hclge_vport *vport;
+	bool enable = true;
 	int ret;
 	int i;
 
@@ -10019,8 +10024,12 @@ static int hclge_init_vlan_filter(struct hclge_dev *hdev)
 		vport->cur_vlan_fltr_en = true;
 	}
 
+	if (test_bit(HNAE3_DEV_SUPPORT_VLAN_FLTR_MDF_B, hdev->ae_dev->caps) &&
+	    !test_bit(HNAE3_DEV_SUPPORT_PORT_VLAN_BYPASS_B, hdev->ae_dev->caps))
+		enable = false;
+
 	return hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_PORT,
-					  HCLGE_FILTER_FE_INGRESS, true, 0);
+					  HCLGE_FILTER_FE_INGRESS, enable, 0);
 }
 
 static int hclge_init_vlan_type(struct hclge_dev *hdev)
@@ -11600,16 +11609,10 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	if (ret)
 		goto out;
 
-	ret = hclge_devlink_init(hdev);
-	if (ret)
-		goto err_pci_uninit;
-
-	devl_lock(hdev->devlink);
-
 	/* Firmware command queue initialize */
 	ret = hclge_comm_cmd_queue_init(hdev->pdev, &hdev->hw.hw);
 	if (ret)
-		goto err_devlink_uninit;
+		goto err_pci_uninit;
 
 	/* Firmware command initialize */
 	ret = hclge_comm_cmd_init(hdev->ae_dev, &hdev->hw.hw, &hdev->fw_version,
@@ -11737,7 +11740,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	ret = hclge_update_port_info(hdev);
 	if (ret)
-		goto err_mdiobus_unreg;
+		goto err_ptp_uninit;
 
 	INIT_KFIFO(hdev->mac_tnl_log);
 
@@ -11772,6 +11775,10 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	/* Enable MISC vector(vector0) */
 	hclge_enable_vector(&hdev->misc_vector, true);
 
+	ret = hclge_devlink_init(hdev);
+	if (ret)
+		goto err_ptp_uninit;
+
 	hclge_state_init(hdev);
 	hdev->last_reset_time = jiffies;
 
@@ -11779,10 +11786,10 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		 HCLGE_DRIVER_NAME);
 
 	hclge_task_schedule(hdev, round_jiffies_relative(HZ));
-
-	devl_unlock(hdev->devlink);
 	return 0;
 
+err_ptp_uninit:
+	hclge_ptp_uninit(hdev);
 err_mdiobus_unreg:
 	if (hdev->hw.mac.phydev)
 		mdiobus_unregister(hdev->hw.mac.mdio_bus);
@@ -11792,9 +11799,6 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	pci_free_irq_vectors(pdev);
 err_cmd_uninit:
 	hclge_comm_cmd_uninit(hdev->ae_dev, &hdev->hw.hw);
-err_devlink_uninit:
-	devl_unlock(hdev->devlink);
-	hclge_devlink_uninit(hdev);
 err_pci_uninit:
 	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 	pci_clear_master(pdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index f6fef790e16c..fd79bb81b6e0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -256,11 +256,14 @@ struct hclge_mac {
 	u8 media_type;	/* port media type, e.g. fibre/copper/backplane */
 	u8 mac_addr[ETH_ALEN];
 	u8 autoneg;
+	u8 req_autoneg;
 	u8 duplex;
+	u8 req_duplex;
 	u8 support_autoneg;
 	u8 speed_type;	/* 0: sfp speed, 1: active speed */
 	u8 lane_num;
 	u32 speed;
+	u32 req_speed;
 	u32 max_speed;
 	u32 speed_ability; /* speed ability supported by current media */
 	u32 module_type; /* sub media type, e.g. kr/cr/sr/lr */
@@ -872,7 +875,7 @@ struct hclge_dev {
 
 	u16 fdir_pf_filter_count; /* Num of guaranteed filters for this PF */
 	u16 num_alloc_vport;		/* Num vports this driver supports */
-	u32 numa_node_mask;
+	nodemask_t numa_node_mask;
 	u16 rx_buf_len;
 	u16 num_tx_desc;		/* desc num of per tx queue */
 	u16 num_rx_desc;		/* desc num of per rx queue */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 04ff9bf12185..877feee53804 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -1077,12 +1077,13 @@ static void hclge_mbx_request_handling(struct hclge_mbx_ops_param *param)
 
 	hdev = param->vport->back;
 	cmd_func = hclge_mbx_ops_list[param->req->msg.code];
-	if (cmd_func)
-		ret = cmd_func(param);
-	else
+	if (!cmd_func) {
 		dev_err(&hdev->pdev->dev,
 			"un-supported mailbox message, code = %u\n",
 			param->req->msg.code);
+		return;
+	}
+	ret = cmd_func(param);
 
 	/* PF driver should not reply IMP */
 	if (hnae3_get_bit(param->req->mbx_need_resp, HCLGE_MBX_NEED_RESP_B) &&
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 5a978ea101a9..1f5a27fb309a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -464,7 +464,8 @@ static int hclgevf_set_handle_info(struct hclgevf_dev *hdev)
 
 	nic->ae_algo = &ae_algovf;
 	nic->pdev = hdev->pdev;
-	nic->numa_node_mask = hdev->numa_node_mask;
+	bitmap_copy(nic->numa_node_mask.bits, hdev->numa_node_mask.bits,
+		    MAX_NUMNODES);
 	nic->flags |= HNAE3_SUPPORT_VF;
 	nic->kinfo.io_base = hdev->hw.hw.io_base;
 
@@ -2136,8 +2137,8 @@ static int hclgevf_init_roce_base_info(struct hclgevf_dev *hdev)
 
 	roce->pdev = nic->pdev;
 	roce->ae_algo = nic->ae_algo;
-	roce->numa_node_mask = nic->numa_node_mask;
-
+	bitmap_copy(roce->numa_node_mask.bits, nic->numa_node_mask.bits,
+		    MAX_NUMNODES);
 	return 0;
 }
 
@@ -2235,8 +2236,7 @@ static void hclgevf_set_timer_task(struct hnae3_handle *handle, bool enable)
 	} else {
 		set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
 
-		/* flush memory to make sure DOWN is seen by service task */
-		smp_mb__before_atomic();
+		smp_mb__after_atomic(); /* flush memory to make sure DOWN is seen by service task */
 		hclgevf_flush_link_update(hdev);
 	}
 }
@@ -2902,10 +2902,6 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 	if (ret)
 		return ret;
 
-	ret = hclgevf_devlink_init(hdev);
-	if (ret)
-		goto err_devlink_init;
-
 	ret = hclge_comm_cmd_queue_init(hdev->pdev, &hdev->hw.hw);
 	if (ret)
 		goto err_cmd_queue_init;
@@ -2998,6 +2994,10 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 
 	hclgevf_init_rxd_adv_layout(hdev);
 
+	ret = hclgevf_devlink_init(hdev);
+	if (ret)
+		goto err_config;
+
 	set_bit(HCLGEVF_STATE_SERVICE_INITED, &hdev->state);
 
 	hdev->last_reset_time = jiffies;
@@ -3017,8 +3017,6 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 err_cmd_init:
 	hclge_comm_cmd_uninit(hdev->ae_dev, &hdev->hw.hw);
 err_cmd_queue_init:
-	hclgevf_devlink_uninit(hdev);
-err_devlink_init:
 	hclgevf_pci_uninit(hdev);
 	clear_bit(HCLGEVF_STATE_IRQ_INITED, &hdev->state);
 	return ret;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index d65ace07b456..976414d00e67 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -236,7 +236,7 @@ struct hclgevf_dev {
 	u16 rss_size_max;	/* HW defined max RSS task queue */
 
 	u16 num_alloc_vport;	/* num vports this driver supports */
-	u32 numa_node_mask;
+	nodemask_t numa_node_mask;
 	u16 rx_buf_len;
 	u16 num_tx_desc;	/* desc num of per tx queue */
 	u16 num_rx_desc;	/* desc num of per rx queue */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index cc5d342e026c..a3c1d82032f5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -999,12 +999,10 @@ static ssize_t rvu_dbg_qsize_write(struct file *filp,
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
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index d4cdf3d4f552..502518cdb461 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -234,12 +234,13 @@ static void ks8851_dbg_dumpkkt(struct ks8851_net *ks, u8 *rxpkt)
 /**
  * ks8851_rx_pkts - receive packets from the host
  * @ks: The device information.
+ * @rxq: Queue of packets received in this function.
  *
  * This is called from the IRQ work queue when the system detects that there
  * are packets in the receive queue. Find out how many packets there are and
  * read them from the FIFO.
  */
-static void ks8851_rx_pkts(struct ks8851_net *ks)
+static void ks8851_rx_pkts(struct ks8851_net *ks, struct sk_buff_head *rxq)
 {
 	struct sk_buff *skb;
 	unsigned rxfc;
@@ -299,7 +300,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 					ks8851_dbg_dumpkkt(ks, rxpkt);
 
 				skb->protocol = eth_type_trans(skb, ks->netdev);
-				__netif_rx(skb);
+				__skb_queue_tail(rxq, skb);
 
 				ks->netdev->stats.rx_packets++;
 				ks->netdev->stats.rx_bytes += rxlen;
@@ -326,11 +327,11 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 static irqreturn_t ks8851_irq(int irq, void *_ks)
 {
 	struct ks8851_net *ks = _ks;
+	struct sk_buff_head rxq;
 	unsigned handled = 0;
 	unsigned long flags;
 	unsigned int status;
-
-	local_bh_disable();
+	struct sk_buff *skb;
 
 	ks8851_lock(ks, &flags);
 
@@ -384,7 +385,8 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		 * from the device so do not bother masking just the RX
 		 * from the device. */
 
-		ks8851_rx_pkts(ks);
+		__skb_queue_head_init(&rxq);
+		ks8851_rx_pkts(ks, &rxq);
 	}
 
 	/* if something stopped the rx process, probably due to wanting
@@ -408,7 +410,9 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
-	local_bh_enable();
+	if (status & IRQ_RXI)
+		while ((skb = __skb_dequeue(&rxq)))
+			netif_rx(skb);
 
 	return IRQ_HANDLED;
 }
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
index 2d82481d34e6..45a542659a81 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1429,6 +1429,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
+	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index fbd36dff9ec2..01ce289f4abf 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1721,6 +1721,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	bool raw_proto = false;
 	void *oiph;
 	__be32 vni = 0;
+	int nh;
 
 	/* Need UDP and VXLAN header to be present */
 	if (!pskb_may_pull(skb, VXLAN_HLEN))
@@ -1809,9 +1810,25 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		skb->pkt_type = PACKET_HOST;
 	}
 
-	oiph = skb_network_header(skb);
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
 
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(vxlan->dev, rx_length_errors);
+		DEV_STATS_INC(vxlan->dev, rx_errors);
+		vxlan_vnifilter_count(vxlan, vni, vninode,
+				      VXLAN_VNI_STATS_RX_ERRORS, 0);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	oiph = skb->head + nh;
+
 	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
 		++vxlan->dev->stats.rx_frame_errors;
 		++vxlan->dev->stats.rx_errors;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 20160683e868..75b4dd8a55b0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4284,7 +4284,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 				"Found shared namespace %d, but multipathing not supported.\n",
 				info->nsid);
 			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0\n.");
+				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
 		}
 	}
 
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 80838dc54b3a..7938741136a2 100644
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
@@ -2494,38 +2494,38 @@ static struct aspeed_pin_config aspeed_g6_configs[] = {
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
index f1962866bb81..1ef36a0a7dd2 100644
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
index 6e0a40962f38..5ee746cb81f5 100644
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
diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 67db79f38051..a0b7b16cb4de 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -276,33 +276,33 @@ static const unsigned int byt_score_plt_clk5_pins[] = { 101 };
 static const unsigned int byt_score_smbus_pins[] = { 51, 52, 53 };
 
 static const struct intel_pingroup byt_score_groups[] = {
-	PIN_GROUP("uart1_grp", byt_score_uart1_pins, 1),
-	PIN_GROUP("uart2_grp", byt_score_uart2_pins, 1),
-	PIN_GROUP("pwm0_grp", byt_score_pwm0_pins, 1),
-	PIN_GROUP("pwm1_grp", byt_score_pwm1_pins, 1),
-	PIN_GROUP("ssp2_grp", byt_score_ssp2_pins, 1),
-	PIN_GROUP("sio_spi_grp", byt_score_sio_spi_pins, 1),
-	PIN_GROUP("i2c5_grp", byt_score_i2c5_pins, 1),
-	PIN_GROUP("i2c6_grp", byt_score_i2c6_pins, 1),
-	PIN_GROUP("i2c4_grp", byt_score_i2c4_pins, 1),
-	PIN_GROUP("i2c3_grp", byt_score_i2c3_pins, 1),
-	PIN_GROUP("i2c2_grp", byt_score_i2c2_pins, 1),
-	PIN_GROUP("i2c1_grp", byt_score_i2c1_pins, 1),
-	PIN_GROUP("i2c0_grp", byt_score_i2c0_pins, 1),
-	PIN_GROUP("ssp0_grp", byt_score_ssp0_pins, 1),
-	PIN_GROUP("ssp1_grp", byt_score_ssp1_pins, 1),
-	PIN_GROUP("sdcard_grp", byt_score_sdcard_pins, byt_score_sdcard_mux_values),
-	PIN_GROUP("sdio_grp", byt_score_sdio_pins, 1),
-	PIN_GROUP("emmc_grp", byt_score_emmc_pins, 1),
-	PIN_GROUP("lpc_grp", byt_score_ilb_lpc_pins, 1),
-	PIN_GROUP("sata_grp", byt_score_sata_pins, 1),
-	PIN_GROUP("plt_clk0_grp", byt_score_plt_clk0_pins, 1),
-	PIN_GROUP("plt_clk1_grp", byt_score_plt_clk1_pins, 1),
-	PIN_GROUP("plt_clk2_grp", byt_score_plt_clk2_pins, 1),
-	PIN_GROUP("plt_clk3_grp", byt_score_plt_clk3_pins, 1),
-	PIN_GROUP("plt_clk4_grp", byt_score_plt_clk4_pins, 1),
-	PIN_GROUP("plt_clk5_grp", byt_score_plt_clk5_pins, 1),
-	PIN_GROUP("smbus_grp", byt_score_smbus_pins, 1),
+	PIN_GROUP_GPIO("uart1_grp", byt_score_uart1_pins, 1),
+	PIN_GROUP_GPIO("uart2_grp", byt_score_uart2_pins, 1),
+	PIN_GROUP_GPIO("pwm0_grp", byt_score_pwm0_pins, 1),
+	PIN_GROUP_GPIO("pwm1_grp", byt_score_pwm1_pins, 1),
+	PIN_GROUP_GPIO("ssp2_grp", byt_score_ssp2_pins, 1),
+	PIN_GROUP_GPIO("sio_spi_grp", byt_score_sio_spi_pins, 1),
+	PIN_GROUP_GPIO("i2c5_grp", byt_score_i2c5_pins, 1),
+	PIN_GROUP_GPIO("i2c6_grp", byt_score_i2c6_pins, 1),
+	PIN_GROUP_GPIO("i2c4_grp", byt_score_i2c4_pins, 1),
+	PIN_GROUP_GPIO("i2c3_grp", byt_score_i2c3_pins, 1),
+	PIN_GROUP_GPIO("i2c2_grp", byt_score_i2c2_pins, 1),
+	PIN_GROUP_GPIO("i2c1_grp", byt_score_i2c1_pins, 1),
+	PIN_GROUP_GPIO("i2c0_grp", byt_score_i2c0_pins, 1),
+	PIN_GROUP_GPIO("ssp0_grp", byt_score_ssp0_pins, 1),
+	PIN_GROUP_GPIO("ssp1_grp", byt_score_ssp1_pins, 1),
+	PIN_GROUP_GPIO("sdcard_grp", byt_score_sdcard_pins, byt_score_sdcard_mux_values),
+	PIN_GROUP_GPIO("sdio_grp", byt_score_sdio_pins, 1),
+	PIN_GROUP_GPIO("emmc_grp", byt_score_emmc_pins, 1),
+	PIN_GROUP_GPIO("lpc_grp", byt_score_ilb_lpc_pins, 1),
+	PIN_GROUP_GPIO("sata_grp", byt_score_sata_pins, 1),
+	PIN_GROUP_GPIO("plt_clk0_grp", byt_score_plt_clk0_pins, 1),
+	PIN_GROUP_GPIO("plt_clk1_grp", byt_score_plt_clk1_pins, 1),
+	PIN_GROUP_GPIO("plt_clk2_grp", byt_score_plt_clk2_pins, 1),
+	PIN_GROUP_GPIO("plt_clk3_grp", byt_score_plt_clk3_pins, 1),
+	PIN_GROUP_GPIO("plt_clk4_grp", byt_score_plt_clk4_pins, 1),
+	PIN_GROUP_GPIO("plt_clk5_grp", byt_score_plt_clk5_pins, 1),
+	PIN_GROUP_GPIO("smbus_grp", byt_score_smbus_pins, 1),
 };
 
 static const char * const byt_score_uart_groups[] = {
@@ -330,12 +330,14 @@ static const char * const byt_score_plt_clk_groups[] = {
 };
 static const char * const byt_score_smbus_groups[] = { "smbus_grp" };
 static const char * const byt_score_gpio_groups[] = {
-	"uart1_grp", "uart2_grp", "pwm0_grp", "pwm1_grp", "ssp0_grp",
-	"ssp1_grp", "ssp2_grp", "sio_spi_grp", "i2c0_grp", "i2c1_grp",
-	"i2c2_grp", "i2c3_grp", "i2c4_grp", "i2c5_grp", "i2c6_grp",
-	"sdcard_grp", "sdio_grp", "emmc_grp", "lpc_grp", "sata_grp",
-	"plt_clk0_grp", "plt_clk1_grp", "plt_clk2_grp", "plt_clk3_grp",
-	"plt_clk4_grp", "plt_clk5_grp", "smbus_grp",
+	"uart1_grp_gpio", "uart2_grp_gpio", "pwm0_grp_gpio",
+	"pwm1_grp_gpio", "ssp0_grp_gpio", "ssp1_grp_gpio", "ssp2_grp_gpio",
+	"sio_spi_grp_gpio", "i2c0_grp_gpio", "i2c1_grp_gpio", "i2c2_grp_gpio",
+	"i2c3_grp_gpio", "i2c4_grp_gpio", "i2c5_grp_gpio", "i2c6_grp_gpio",
+	"sdcard_grp_gpio", "sdio_grp_gpio", "emmc_grp_gpio", "lpc_grp_gpio",
+	"sata_grp_gpio", "plt_clk0_grp_gpio", "plt_clk1_grp_gpio",
+	"plt_clk2_grp_gpio", "plt_clk3_grp_gpio", "plt_clk4_grp_gpio",
+	"plt_clk5_grp_gpio", "smbus_grp_gpio",
 };
 
 static const struct intel_function byt_score_functions[] = {
@@ -454,8 +456,8 @@ static const struct intel_pingroup byt_sus_groups[] = {
 	PIN_GROUP("usb_oc_grp_gpio", byt_sus_usb_over_current_pins, byt_sus_usb_over_current_gpio_mode_values),
 	PIN_GROUP("usb_ulpi_grp_gpio", byt_sus_usb_ulpi_pins, byt_sus_usb_ulpi_gpio_mode_values),
 	PIN_GROUP("pcu_spi_grp_gpio", byt_sus_pcu_spi_pins, byt_sus_pcu_spi_gpio_mode_values),
-	PIN_GROUP("pmu_clk1_grp", byt_sus_pmu_clk1_pins, 1),
-	PIN_GROUP("pmu_clk2_grp", byt_sus_pmu_clk2_pins, 1),
+	PIN_GROUP_GPIO("pmu_clk1_grp", byt_sus_pmu_clk1_pins, 1),
+	PIN_GROUP_GPIO("pmu_clk2_grp", byt_sus_pmu_clk2_pins, 1),
 };
 
 static const char * const byt_sus_usb_groups[] = {
@@ -467,7 +469,7 @@ static const char * const byt_sus_pmu_clk_groups[] = {
 };
 static const char * const byt_sus_gpio_groups[] = {
 	"usb_oc_grp_gpio", "usb_ulpi_grp_gpio", "pcu_spi_grp_gpio",
-	"pmu_clk1_grp", "pmu_clk2_grp",
+	"pmu_clk1_grp_gpio", "pmu_clk2_grp_gpio",
 };
 
 static const struct intel_function byt_sus_functions[] = {
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 954a41226740..8542053d4d6d 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -362,7 +362,7 @@ static const char *intel_get_function_name(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	return pctrl->soc->functions[function].name;
+	return pctrl->soc->functions[function].func.name;
 }
 
 static int intel_get_function_groups(struct pinctrl_dev *pctldev,
@@ -372,8 +372,8 @@ static int intel_get_function_groups(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	*groups = pctrl->soc->functions[function].groups;
-	*ngroups = pctrl->soc->functions[function].ngroups;
+	*groups = pctrl->soc->functions[function].func.groups;
+	*ngroups = pctrl->soc->functions[function].func.ngroups;
 	return 0;
 }
 
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 65628423bf63..0d45063435eb 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -36,11 +36,13 @@ struct intel_pingroup {
 
 /**
  * struct intel_function - Description about a function
+ * @func: Generic data of the pin function (name and groups of pins)
  * @name: Name of the function
  * @groups: An array of groups for this function
  * @ngroups: Number of groups in @groups
  */
 struct intel_function {
+	struct pinfunction func;
 	const char *name;
 	const char * const *groups;
 	size_t ngroups;
@@ -158,11 +160,16 @@ struct intel_community {
 		.modes = __builtin_choose_expr(__builtin_constant_p((m)), NULL, (m)),	\
 	}
 
-#define FUNCTION(n, g)				\
-	{					\
-		.name = (n),			\
-		.groups = (g),			\
-		.ngroups = ARRAY_SIZE((g)),	\
+#define PIN_GROUP_GPIO(n, p, m)						\
+	 PIN_GROUP(n, p, m),						\
+	 PIN_GROUP(n "_gpio", p, 0)
+
+#define FUNCTION(n, g)							\
+	{								\
+		.func = PINCTRL_PINFUNCTION((n), (g), ARRAY_SIZE(g)),	\
+		.name = (n),						\
+		.groups = (g),						\
+		.ngroups = ARRAY_SIZE((g)),				\
 	}
 
 /**
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index ad873bd051b6..ee72c6894a5d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -160,20 +160,21 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
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
 			break;
-		/*     CONFIG     Current direction return value
-		 * -------------  ----------------- ----------------------
-		 * OUTPUT_ENABLE       output       1 (= HW value)
-		 *                     input        0 (= HW value)
-		 * INPUT_ENABLE        output       0 (= reverse HW value)
-		 *                     input        1 (= reverse HW value)
-		 */
-		if (param == PIN_CONFIG_INPUT_ENABLE)
-			ret = !ret;
 
+		if (!ret) {
+			err = -EINVAL;
+			break;
+		}
+
+		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DO, &ret);
 		break;
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &ret);
@@ -188,6 +189,8 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		}
 
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SMT, &ret);
+		if (!ret)
+			err = -EINVAL;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		if (!hw->soc->drive_get)
@@ -276,26 +279,9 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 		err = hw->soc->bias_set_combo(hw, desc, 0, arg);
 		break;
-	case PIN_CONFIG_OUTPUT_ENABLE:
-		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
-				       MTK_DISABLE);
-		/* Keep set direction to consider the case that a GPIO pin
-		 *  does not have SMT control
-		 */
-		if (err != -ENOTSUPP)
-			break;
-
-		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
-				       MTK_OUTPUT);
-		break;
 	case PIN_CONFIG_INPUT_ENABLE:
 		/* regard all non-zero value as enable */
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_IES, !!arg);
-		if (err)
-			break;
-
-		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
-				       MTK_INPUT);
 		break;
 	case PIN_CONFIG_SLEW_RATE:
 		/* regard all non-zero value as enable */
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
index 72962286d704..c5597967a069 100644
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
index c8702011b761..ff11f37e28c7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1916,19 +1916,24 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
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
 
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 1e6340e2c258..f99d1d325f3e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -364,30 +364,33 @@ static int qeth_cq_init(struct qeth_card *card)
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
 	} else {
 		QETH_CARD_TEXT(card, 2, "nocq");
-		card->qdio.c_q = NULL;
+		qeth_free_cq(card);
 	}
 	return 0;
 }
 
-static void qeth_free_cq(struct qeth_card *card)
-{
-	if (card->qdio.c_q) {
-		qeth_free_qdio_queue(card->qdio.c_q);
-		card->qdio.c_q = NULL;
-	}
-}
-
 static enum iucv_tx_notify qeth_compute_cq_notification(int sbalf15,
 							int delayed)
 {
@@ -2628,6 +2631,10 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 2, "allcqdbf");
 
+	/* completion */
+	if (qeth_alloc_cq(card))
+		goto out_err;
+
 	if (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED,
 		QETH_QDIO_ALLOCATED) != QETH_QDIO_UNINITIALIZED)
 		return 0;
@@ -2663,10 +2670,6 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
 		queue->priority = QETH_QIB_PQUE_PRIO_DEFAULT;
 	}
 
-	/* completion */
-	if (qeth_alloc_cq(card))
-		goto out_freeoutq;
-
 	return 0;
 
 out_freeoutq:
@@ -2677,6 +2680,8 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
 	qeth_free_buffer_pool(card);
 out_buffer_pool:
 	atomic_set(&card->qdio.state, QETH_QDIO_UNINITIALIZED);
+	qeth_free_cq(card);
+out_err:
 	return -ENOMEM;
 }
 
@@ -2684,11 +2689,12 @@ static void qeth_free_qdio_queues(struct qeth_card *card)
 {
 	int i, j;
 
+	qeth_free_cq(card);
+
 	if (atomic_xchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED) ==
 		QETH_QDIO_UNINITIALIZED)
 		return;
 
-	qeth_free_cq(card);
 	for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j) {
 		if (card->qdio.in_q->bufs[j].rx_skb) {
 			consume_skb(card->qdio.in_q->bufs[j].rx_skb);
@@ -3740,24 +3746,11 @@ static void qeth_qdio_poll(struct ccw_device *cdev, unsigned long card_ptr)
 
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
 
diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
index 2c246e80c1c4..d91659811eb3 100644
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
index dc5ac3cc70f6..6f08fbe103cb 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1355,7 +1355,6 @@ struct lpfc_hba {
 	struct timer_list fabric_block_timer;
 	unsigned long bit_flags;
 	atomic_t num_rsrc_err;
-	atomic_t num_cmd_success;
 	unsigned long last_rsrc_error_time;
 	unsigned long last_ramp_down_time;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 6b5ce9869e6b..05764008f6e7 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4384,23 +4384,23 @@ lpfc_els_retry_delay(struct timer_list *t)
 	unsigned long flags;
 	struct lpfc_work_evt  *evtp = &ndlp->els_retry_evt;
 
+	/* Hold a node reference for outstanding queued work */
+	if (!lpfc_nlp_get(ndlp))
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, flags);
 	if (!list_empty(&evtp->evt_listp)) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
+		lpfc_nlp_put(ndlp);
 		return;
 	}
 
-	/* We need to hold the node by incrementing the reference
-	 * count until the queued work is done
-	 */
-	evtp->evt_arg1  = lpfc_nlp_get(ndlp);
-	if (evtp->evt_arg1) {
-		evtp->evt = LPFC_EVT_ELS_RETRY;
-		list_add_tail(&evtp->evt_listp, &phba->work_list);
-		lpfc_worker_wake_up(phba);
-	}
+	evtp->evt_arg1 = ndlp;
+	evtp->evt = LPFC_EVT_ELS_RETRY;
+	list_add_tail(&evtp->evt_listp, &phba->work_list);
 	spin_unlock_irqrestore(&phba->hbalock, flags);
-	return;
+
+	lpfc_worker_wake_up(phba);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 549fa7d6c0f6..aaa98a006fdc 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -241,7 +241,9 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 		if (evtp->evt_arg1) {
 			evtp->evt = LPFC_EVT_DEV_LOSS;
 			list_add_tail(&evtp->evt_listp, &phba->work_list);
+			spin_unlock_irqrestore(&phba->hbalock, iflags);
 			lpfc_worker_wake_up(phba);
+			return;
 		}
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	} else {
@@ -259,10 +261,7 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 			lpfc_disc_state_machine(vport, ndlp, NULL,
 						NLP_EVT_DEVICE_RM);
 		}
-
 	}
-
-	return;
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 152245f7cacc..7e9e0d969256 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2621,9 +2621,9 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
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
index 0bb7e164b525..2a81a42de5c1 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -167,11 +167,10 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
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
@@ -186,20 +185,16 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
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
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 427a6ac803e5..47b8102a7063 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1217,9 +1217,9 @@ lpfc_set_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	empty = list_empty(&phba->active_rrq_list);
 	list_add_tail(&rrq->list, &phba->active_rrq_list);
 	phba->hba_flag |= HBA_RRQ_ACTIVE;
+	spin_unlock_irqrestore(&phba->hbalock, iflags);
 	if (empty)
 		lpfc_worker_wake_up(phba);
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
 	return 0;
 out:
 	spin_unlock_irqrestore(&phba->hbalock, iflags);
@@ -11361,18 +11361,18 @@ lpfc_sli_post_recovery_event(struct lpfc_hba *phba,
 	unsigned long iflags;
 	struct lpfc_work_evt  *evtp = &ndlp->recovery_evt;
 
+	/* Hold a node reference for outstanding queued work */
+	if (!lpfc_nlp_get(ndlp))
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	if (!list_empty(&evtp->evt_listp)) {
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
+		lpfc_nlp_put(ndlp);
 		return;
 	}
 
-	/* Incrementing the reference count until the queued work is done. */
-	evtp->evt_arg1  = lpfc_nlp_get(ndlp);
-	if (!evtp->evt_arg1) {
-		spin_unlock_irqrestore(&phba->hbalock, iflags);
-		return;
-	}
+	evtp->evt_arg1 = ndlp;
 	evtp->evt = LPFC_EVT_RECOVER_PORT;
 	list_add_tail(&evtp->evt_listp, &phba->work_list);
 	spin_unlock_irqrestore(&phba->hbalock, iflags);
diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index 4d171f5c213f..6b4259894584 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -693,10 +693,6 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	lpfc_free_sysfs_attr(vport);
 	lpfc_debugfs_terminate(vport);
 
-	/* Remove FC host to break driver binding. */
-	fc_remove_host(shost);
-	scsi_remove_host(shost);
-
 	/* Send the DA_ID and Fabric LOGO to cleanup Nameserver entries. */
 	ndlp = lpfc_findnode_did(vport, Fabric_DID);
 	if (!ndlp)
@@ -740,6 +736,10 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 
 skip_logo:
 
+	/* Remove FC host to break driver binding. */
+	fc_remove_host(shost);
+	scsi_remove_host(shost);
+
 	lpfc_cleanup(vport);
 
 	/* Remove scsi host now.  The nodes are cleaned up. */
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 8c662d08706f..42600e5c457a 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -1344,7 +1344,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job, unsigned int *reply
 	if ((mpirep_offset != 0xFF) &&
 	    drv_bufs[mpirep_offset].bsg_buf_len) {
 		drv_buf_iter = &drv_bufs[mpirep_offset];
-		drv_buf_iter->kern_buf_len = (sizeof(*bsg_reply_buf) - 1 +
+		drv_buf_iter->kern_buf_len = (sizeof(*bsg_reply_buf) +
 					   mrioc->reply_sz);
 		bsg_reply_buf = kzalloc(drv_buf_iter->kern_buf_len, GFP_KERNEL);
 
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 76c5e446d243..da8555f3b6ca 100644
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
diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 80c3e38f5c1b..a5f0a61b266f 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/clk.h>
+#include <linux/fpga/adi-axi-common.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -13,12 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
-#define SPI_ENGINE_VERSION_MAJOR(x)	((x >> 16) & 0xff)
-#define SPI_ENGINE_VERSION_MINOR(x)	((x >> 8) & 0xff)
-#define SPI_ENGINE_VERSION_PATCH(x)	(x & 0xff)
-
-#define SPI_ENGINE_REG_VERSION			0x00
-
 #define SPI_ENGINE_REG_RESET			0x40
 
 #define SPI_ENGINE_REG_INT_ENABLE		0x80
@@ -78,28 +74,42 @@ struct spi_engine_program {
 	uint16_t instructions[];
 };
 
-struct spi_engine {
-	struct clk *clk;
-	struct clk *ref_clk;
-
-	spinlock_t lock;
-
-	void __iomem *base;
-
-	struct spi_message *msg;
+/**
+ * struct spi_engine_message_state - SPI engine per-message state
+ */
+struct spi_engine_message_state {
+	/** Instructions for executing this message. */
 	struct spi_engine_program *p;
+	/** Number of elements in cmd_buf array. */
 	unsigned cmd_length;
+	/** Array of commands not yet written to CMD FIFO. */
 	const uint16_t *cmd_buf;
-
+	/** Next xfer with tx_buf not yet fully written to TX FIFO. */
 	struct spi_transfer *tx_xfer;
+	/** Size of tx_buf in bytes. */
 	unsigned int tx_length;
+	/** Bytes not yet written to TX FIFO. */
 	const uint8_t *tx_buf;
-
+	/** Next xfer with rx_buf not yet fully written to RX FIFO. */
 	struct spi_transfer *rx_xfer;
+	/** Size of tx_buf in bytes. */
 	unsigned int rx_length;
+	/** Bytes not yet written to the RX FIFO. */
 	uint8_t *rx_buf;
+	/** ID to correlate SYNC interrupts with this message. */
+	u8 sync_id;
+};
+
+struct spi_engine {
+	struct clk *clk;
+	struct clk *ref_clk;
+
+	spinlock_t lock;
 
-	unsigned int sync_id;
+	void __iomem *base;
+
+	struct spi_message *msg;
+	struct ida sync_ida;
 	unsigned int completed_id;
 
 	unsigned int int_enable;
@@ -258,106 +268,111 @@ static void spi_engine_xfer_next(struct spi_engine *spi_engine,
 
 static void spi_engine_tx_next(struct spi_engine *spi_engine)
 {
-	struct spi_transfer *xfer = spi_engine->tx_xfer;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_transfer *xfer = st->tx_xfer;
 
 	do {
 		spi_engine_xfer_next(spi_engine, &xfer);
 	} while (xfer && !xfer->tx_buf);
 
-	spi_engine->tx_xfer = xfer;
+	st->tx_xfer = xfer;
 	if (xfer) {
-		spi_engine->tx_length = xfer->len;
-		spi_engine->tx_buf = xfer->tx_buf;
+		st->tx_length = xfer->len;
+		st->tx_buf = xfer->tx_buf;
 	} else {
-		spi_engine->tx_buf = NULL;
+		st->tx_buf = NULL;
 	}
 }
 
 static void spi_engine_rx_next(struct spi_engine *spi_engine)
 {
-	struct spi_transfer *xfer = spi_engine->rx_xfer;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_transfer *xfer = st->rx_xfer;
 
 	do {
 		spi_engine_xfer_next(spi_engine, &xfer);
 	} while (xfer && !xfer->rx_buf);
 
-	spi_engine->rx_xfer = xfer;
+	st->rx_xfer = xfer;
 	if (xfer) {
-		spi_engine->rx_length = xfer->len;
-		spi_engine->rx_buf = xfer->rx_buf;
+		st->rx_length = xfer->len;
+		st->rx_buf = xfer->rx_buf;
 	} else {
-		spi_engine->rx_buf = NULL;
+		st->rx_buf = NULL;
 	}
 }
 
 static bool spi_engine_write_cmd_fifo(struct spi_engine *spi_engine)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_CMD_FIFO;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
 	unsigned int n, m, i;
 	const uint16_t *buf;
 
 	n = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_CMD_FIFO_ROOM);
-	while (n && spi_engine->cmd_length) {
-		m = min(n, spi_engine->cmd_length);
-		buf = spi_engine->cmd_buf;
+	while (n && st->cmd_length) {
+		m = min(n, st->cmd_length);
+		buf = st->cmd_buf;
 		for (i = 0; i < m; i++)
 			writel_relaxed(buf[i], addr);
-		spi_engine->cmd_buf += m;
-		spi_engine->cmd_length -= m;
+		st->cmd_buf += m;
+		st->cmd_length -= m;
 		n -= m;
 	}
 
-	return spi_engine->cmd_length != 0;
+	return st->cmd_length != 0;
 }
 
 static bool spi_engine_write_tx_fifo(struct spi_engine *spi_engine)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_SDO_DATA_FIFO;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
 	unsigned int n, m, i;
 	const uint8_t *buf;
 
 	n = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_SDO_FIFO_ROOM);
-	while (n && spi_engine->tx_length) {
-		m = min(n, spi_engine->tx_length);
-		buf = spi_engine->tx_buf;
+	while (n && st->tx_length) {
+		m = min(n, st->tx_length);
+		buf = st->tx_buf;
 		for (i = 0; i < m; i++)
 			writel_relaxed(buf[i], addr);
-		spi_engine->tx_buf += m;
-		spi_engine->tx_length -= m;
+		st->tx_buf += m;
+		st->tx_length -= m;
 		n -= m;
-		if (spi_engine->tx_length == 0)
+		if (st->tx_length == 0)
 			spi_engine_tx_next(spi_engine);
 	}
 
-	return spi_engine->tx_length != 0;
+	return st->tx_length != 0;
 }
 
 static bool spi_engine_read_rx_fifo(struct spi_engine *spi_engine)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_SDI_DATA_FIFO;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
 	unsigned int n, m, i;
 	uint8_t *buf;
 
 	n = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_SDI_FIFO_LEVEL);
-	while (n && spi_engine->rx_length) {
-		m = min(n, spi_engine->rx_length);
-		buf = spi_engine->rx_buf;
+	while (n && st->rx_length) {
+		m = min(n, st->rx_length);
+		buf = st->rx_buf;
 		for (i = 0; i < m; i++)
 			buf[i] = readl_relaxed(addr);
-		spi_engine->rx_buf += m;
-		spi_engine->rx_length -= m;
+		st->rx_buf += m;
+		st->rx_length -= m;
 		n -= m;
-		if (spi_engine->rx_length == 0)
+		if (st->rx_length == 0)
 			spi_engine_rx_next(spi_engine);
 	}
 
-	return spi_engine->rx_length != 0;
+	return st->rx_length != 0;
 }
 
 static irqreturn_t spi_engine_irq(int irq, void *devid)
 {
-	struct spi_master *master = devid;
-	struct spi_engine *spi_engine = spi_master_get_devdata(master);
+	struct spi_controller *host = devid;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	unsigned int disable_int = 0;
 	unsigned int pending;
 
@@ -387,16 +402,20 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 			disable_int |= SPI_ENGINE_INT_SDI_ALMOST_FULL;
 	}
 
-	if (pending & SPI_ENGINE_INT_SYNC) {
-		if (spi_engine->msg &&
-		    spi_engine->completed_id == spi_engine->sync_id) {
+	if (pending & SPI_ENGINE_INT_SYNC && spi_engine->msg) {
+		struct spi_engine_message_state *st = spi_engine->msg->state;
+
+		if (spi_engine->completed_id == st->sync_id) {
 			struct spi_message *msg = spi_engine->msg;
+			struct spi_engine_message_state *st = msg->state;
 
-			kfree(spi_engine->p);
+			ida_free(&spi_engine->sync_ida, st->sync_id);
+			kfree(st->p);
+			kfree(st);
 			msg->status = 0;
 			msg->actual_length = msg->frame_length;
 			spi_engine->msg = NULL;
-			spi_finalize_current_message(master);
+			spi_finalize_current_message(host);
 			disable_int |= SPI_ENGINE_INT_SYNC;
 		}
 	}
@@ -412,34 +431,51 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static int spi_engine_transfer_one_message(struct spi_master *master,
+static int spi_engine_transfer_one_message(struct spi_controller *host,
 	struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
-	struct spi_engine *spi_engine = spi_master_get_devdata(master);
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_message_state *st;
 	unsigned int int_enable = 0;
 	unsigned long flags;
 	size_t size;
+	int ret;
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
 
 	p_dry.length = 0;
 	spi_engine_compile_message(spi_engine, msg, true, &p_dry);
 
 	size = sizeof(*p->instructions) * (p_dry.length + 1);
 	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);
-	if (!p)
+	if (!p) {
+		kfree(st);
 		return -ENOMEM;
+	}
+
+	ret = ida_alloc_range(&spi_engine->sync_ida, 0, U8_MAX, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(p);
+		kfree(st);
+		return ret;
+	}
+
+	st->sync_id = ret;
+
 	spi_engine_compile_message(spi_engine, msg, false, p);
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
-	spi_engine->sync_id = (spi_engine->sync_id + 1) & 0xff;
-	spi_engine_program_add_cmd(p, false,
-		SPI_ENGINE_CMD_SYNC(spi_engine->sync_id));
+	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(st->sync_id));
 
+	msg->state = st;
 	spi_engine->msg = msg;
-	spi_engine->p = p;
+	st->p = p;
 
-	spi_engine->cmd_buf = p->instructions;
-	spi_engine->cmd_length = p->length;
+	st->cmd_buf = p->instructions;
+	st->cmd_length = p->length;
 	if (spi_engine_write_cmd_fifo(spi_engine))
 		int_enable |= SPI_ENGINE_INT_CMD_ALMOST_EMPTY;
 
@@ -448,7 +484,7 @@ static int spi_engine_transfer_one_message(struct spi_master *master,
 		int_enable |= SPI_ENGINE_INT_SDO_ALMOST_EMPTY;
 
 	spi_engine_rx_next(spi_engine);
-	if (spi_engine->rx_length != 0)
+	if (st->rx_length != 0)
 		int_enable |= SPI_ENGINE_INT_SDI_ALMOST_FULL;
 
 	int_enable |= SPI_ENGINE_INT_SYNC;
@@ -464,7 +500,7 @@ static int spi_engine_transfer_one_message(struct spi_master *master,
 static int spi_engine_probe(struct platform_device *pdev)
 {
 	struct spi_engine *spi_engine;
-	struct spi_master *master;
+	struct spi_controller *host;
 	unsigned int version;
 	int irq;
 	int ret;
@@ -473,107 +509,76 @@ static int spi_engine_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return -ENXIO;
 
-	spi_engine = devm_kzalloc(&pdev->dev, sizeof(*spi_engine), GFP_KERNEL);
-	if (!spi_engine)
-		return -ENOMEM;
-
-	master = spi_alloc_master(&pdev->dev, 0);
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi_engine));
+	if (!host)
 		return -ENOMEM;
 
-	spi_master_set_devdata(master, spi_engine);
+	spi_engine = spi_controller_get_devdata(host);
 
 	spin_lock_init(&spi_engine->lock);
+	ida_init(&spi_engine->sync_ida);
 
-	spi_engine->clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
-	if (IS_ERR(spi_engine->clk)) {
-		ret = PTR_ERR(spi_engine->clk);
-		goto err_put_master;
-	}
-
-	spi_engine->ref_clk = devm_clk_get(&pdev->dev, "spi_clk");
-	if (IS_ERR(spi_engine->ref_clk)) {
-		ret = PTR_ERR(spi_engine->ref_clk);
-		goto err_put_master;
-	}
+	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
+	if (IS_ERR(spi_engine->clk))
+		return PTR_ERR(spi_engine->clk);
 
-	ret = clk_prepare_enable(spi_engine->clk);
-	if (ret)
-		goto err_put_master;
-
-	ret = clk_prepare_enable(spi_engine->ref_clk);
-	if (ret)
-		goto err_clk_disable;
+	spi_engine->ref_clk = devm_clk_get_enabled(&pdev->dev, "spi_clk");
+	if (IS_ERR(spi_engine->ref_clk))
+		return PTR_ERR(spi_engine->ref_clk);
 
 	spi_engine->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(spi_engine->base)) {
-		ret = PTR_ERR(spi_engine->base);
-		goto err_ref_clk_disable;
-	}
-
-	version = readl(spi_engine->base + SPI_ENGINE_REG_VERSION);
-	if (SPI_ENGINE_VERSION_MAJOR(version) != 1) {
-		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%c\n",
-			SPI_ENGINE_VERSION_MAJOR(version),
-			SPI_ENGINE_VERSION_MINOR(version),
-			SPI_ENGINE_VERSION_PATCH(version));
-		ret = -ENODEV;
-		goto err_ref_clk_disable;
+	if (IS_ERR(spi_engine->base))
+		return PTR_ERR(spi_engine->base);
+
+	version = readl(spi_engine->base + ADI_AXI_REG_VERSION);
+	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1) {
+		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%u\n",
+			ADI_AXI_PCORE_VER_MAJOR(version),
+			ADI_AXI_PCORE_VER_MINOR(version),
+			ADI_AXI_PCORE_VER_PATCH(version));
+		return -ENODEV;
 	}
 
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_RESET);
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
 
-	ret = request_irq(irq, spi_engine_irq, 0, pdev->name, master);
+	ret = request_irq(irq, spi_engine_irq, 0, pdev->name, host);
 	if (ret)
-		goto err_ref_clk_disable;
+		return ret;
 
-	master->dev.of_node = pdev->dev.of_node;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
-	master->transfer_one_message = spi_engine_transfer_one_message;
-	master->num_chipselect = 8;
+	host->dev.of_node = pdev->dev.of_node;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
+	host->transfer_one_message = spi_engine_transfer_one_message;
+	host->num_chipselect = 8;
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto err_free_irq;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
 	return 0;
 err_free_irq:
-	free_irq(irq, master);
-err_ref_clk_disable:
-	clk_disable_unprepare(spi_engine->ref_clk);
-err_clk_disable:
-	clk_disable_unprepare(spi_engine->clk);
-err_put_master:
-	spi_master_put(master);
+	free_irq(irq, host);
 	return ret;
 }
 
-static int spi_engine_remove(struct platform_device *pdev)
+static void spi_engine_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
-	struct spi_engine *spi_engine = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	int irq = platform_get_irq(pdev, 0);
 
-	spi_unregister_master(master);
-
-	free_irq(irq, master);
+	spi_unregister_controller(host);
 
-	spi_master_put(master);
+	free_irq(irq, host);
 
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
 	writel_relaxed(0x01, spi_engine->base + SPI_ENGINE_REG_RESET);
-
-	clk_disable_unprepare(spi_engine->ref_clk);
-	clk_disable_unprepare(spi_engine->clk);
-
-	return 0;
 }
 
 static const struct of_device_id spi_engine_match_table[] = {
@@ -584,7 +589,7 @@ MODULE_DEVICE_TABLE(of, spi_engine_match_table);
 
 static struct platform_driver spi_engine_driver = {
 	.probe = spi_engine_probe,
-	.remove = spi_engine_remove,
+	.remove_new = spi_engine_remove,
 	.driver = {
 		.name = "spi-engine",
 		.of_match_table = spi_engine_match_table,
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
diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 19a6a46829f6..620c5d19031e 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -283,6 +283,7 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 	}
 
 	control = readl_relaxed(qspi->regs + REG_CONTROL);
+	control &= ~CONTROL_CLKRATE_MASK;
 	control |= baud_rate_val << CONTROL_CLKRATE_SHIFT;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
 	control = readl_relaxed(qspi->regs + REG_CONTROL);
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 19688f333e0b..1018feff468c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2774,6 +2774,17 @@ int spi_slave_abort(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_slave_abort);
 
+int spi_target_abort(struct spi_device *spi)
+{
+	struct spi_controller *ctlr = spi->controller;
+
+	if (spi_controller_is_target(ctlr) && ctlr->target_abort)
+		return ctlr->target_abort(ctlr);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(spi_target_abort);
+
 static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
@@ -4206,6 +4217,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 		wait_for_completion(&done);
 		status = message->status;
 	}
+	message->complete = NULL;
 	message->context = NULL;
 
 	return status;
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 02fdef7a16c8..c7cd54171d99 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -1116,8 +1116,8 @@ static int hfa384x_usbctlx_complete_sync(struct hfa384x *hw,
 		if (ctlx == get_active_ctlx(hw)) {
 			spin_unlock_irqrestore(&hw->ctlxq.lock, flags);
 
-			del_singleshot_timer_sync(&hw->reqtimer);
-			del_singleshot_timer_sync(&hw->resptimer);
+			del_timer_sync(&hw->reqtimer);
+			del_timer_sync(&hw->resptimer);
 			hw->req_timer_done = 1;
 			hw->resp_timer_done = 1;
 			usb_kill_urb(&hw->ctlx_urb);
diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index e13da7fadfff..c13f1699e5a2 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -170,9 +170,9 @@ static void prism2sta_disconnect_usb(struct usb_interface *interface)
 		 */
 		prism2sta_ifstate(wlandev, P80211ENUM_ifstate_disable);
 
-		del_singleshot_timer_sync(&hw->throttle);
-		del_singleshot_timer_sync(&hw->reqtimer);
-		del_singleshot_timer_sync(&hw->resptimer);
+		del_timer_sync(&hw->throttle);
+		del_timer_sync(&hw->reqtimer);
+		del_timer_sync(&hw->resptimer);
 
 		/* Unlink all the URBs. This "removes the wheels"
 		 * from the entire CTLX handling mechanism.
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 416514c5c7ac..1a26dd0d5666 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3587,6 +3587,8 @@ static int __init target_core_init_configfs(void)
 {
 	struct configfs_subsystem *subsys = &target_core_fabrics;
 	struct t10_alua_lu_gp *lu_gp;
+	struct cred *kern_cred;
+	const struct cred *old_cred;
 	int ret;
 
 	pr_debug("TARGET_CORE[0]: Loading Generic Kernel Storage"
@@ -3663,11 +3665,21 @@ static int __init target_core_init_configfs(void)
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
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f3c25467e571..948449a13247 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9044,7 +9044,10 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	/* UFS device & link must be active before we enter in this function */
 	if (!ufshcd_is_ufs_dev_active(hba) || !ufshcd_is_link_active(hba)) {
-		ret = -EINVAL;
+		/*  Wait err handler finish or trigger err recovery */
+		if (!ufshcd_eh_in_progress(hba))
+			ufshcd_force_error_recovery(hba);
+		ret = -EBUSY;
 		goto enable_scaling;
 	}
 
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index c08a6cfd119f..e5789dfcaff6 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -181,12 +181,14 @@ hv_uio_cleanup(struct hv_device *dev, struct hv_uio_private_data *pdata)
 {
 	if (pdata->send_gpadl.gpadl_handle) {
 		vmbus_teardown_gpadl(dev->channel, &pdata->send_gpadl);
-		vfree(pdata->send_buf);
+		if (!pdata->send_gpadl.decrypted)
+			vfree(pdata->send_buf);
 	}
 
 	if (pdata->recv_gpadl.gpadl_handle) {
 		vmbus_teardown_gpadl(dev->channel, &pdata->recv_gpadl);
-		vfree(pdata->recv_buf);
+		if (!pdata->recv_gpadl.decrypted)
+			vfree(pdata->recv_buf);
 	}
 }
 
@@ -295,7 +297,8 @@ hv_uio_probe(struct hv_device *dev,
 	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
 				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
 	if (ret) {
-		vfree(pdata->recv_buf);
+		if (!pdata->recv_gpadl.decrypted)
+			vfree(pdata->recv_buf);
 		goto fail_close;
 	}
 
@@ -317,7 +320,8 @@ hv_uio_probe(struct hv_device *dev,
 	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
 				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
 	if (ret) {
-		vfree(pdata->send_buf);
+		if (!pdata->send_gpadl.decrypted)
+			vfree(pdata->send_buf);
 		goto fail_close;
 	}
 
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index dea110241ee7..50a5608c204f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5069,9 +5069,10 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
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
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 93a63b7f164d..0007031fad0d 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -23,13 +23,15 @@ static ssize_t disable_show(struct device *dev,
 	struct usb_port *port_dev = to_usb_port(dev);
 	struct usb_device *hdev = to_usb_device(dev->parent->parent);
 	struct usb_hub *hub = usb_hub_to_struct_hub(hdev);
-	struct usb_interface *intf = to_usb_interface(hub->intfdev);
+	struct usb_interface *intf = to_usb_interface(dev->parent);
 	int port1 = port_dev->portnum;
 	u16 portstatus, unused;
 	bool disabled;
 	int rc;
 	struct kernfs_node *kn;
 
+	if (!hub)
+		return -ENODEV;
 	hub_get(hub);
 	rc = usb_autopm_get_interface(intf);
 	if (rc < 0)
@@ -73,12 +75,14 @@ static ssize_t disable_store(struct device *dev, struct device_attribute *attr,
 	struct usb_port *port_dev = to_usb_port(dev);
 	struct usb_device *hdev = to_usb_device(dev->parent->parent);
 	struct usb_hub *hub = usb_hub_to_struct_hub(hdev);
-	struct usb_interface *intf = to_usb_interface(hub->intfdev);
+	struct usb_interface *intf = to_usb_interface(dev->parent);
 	int port1 = port_dev->portnum;
 	bool disabled;
 	int rc;
 	struct kernfs_node *kn;
 
+	if (!hub)
+		return -ENODEV;
 	rc = strtobool(buf, &disabled);
 	if (rc)
 		return rc;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 011a3909f9ad..3b5482621e5e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -104,6 +104,27 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
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
@@ -669,11 +690,8 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
  */
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
-	unsigned int hw_mode;
 	u32 reg;
 
-	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
 	/*
@@ -683,21 +701,16 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
 
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
-	 * to '0' during coreConsultant configuration. So default value
-	 * will be '0' when the core is reset. Application needs to set it
-	 * to '1' after the core initialization is completed.
-	 */
-	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
-		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-
-	/*
-	 * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be cleared after
-	 * power-on reset, and it can be set after core initialization, which is
-	 * after device soft-reset during initialization.
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
+	 * So default value will be '0' when the core is reset. Application
+	 * needs to set it to '1' after the core initialization is completed.
+	 *
+	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
+	 * cleared after power-on reset, and it can be set after core
+	 * initialization.
 	 */
-	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
-		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+	reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
@@ -723,9 +736,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->tx_de_emphasis_quirk)
 		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_de_emphasis);
 
-	if (dwc->dis_u3_susphy_quirk)
-		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
-
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
@@ -773,24 +783,15 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	}
 
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
-	 * '0' during coreConsultant configuration. So default value will
-	 * be '0' when the core is reset. Application needs to set it to
-	 * '1' after the core initialization is completed.
-	 */
-	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
-		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-
-	/*
-	 * For DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared after
-	 * power-on reset, and it can be set after core initialization, which is
-	 * after device soft-reset during initialization.
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
+	 * So default value will be '0' when the core is reset. Application
+	 * needs to set it to '1' after the core initialization is completed.
+	 *
+	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
+	 * after power-on reset, and it can be set after core initialization.
 	 */
-	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-
-	if (dwc->dis_u2_susphy_quirk)
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	if (dwc->dis_enblslpm_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
@@ -1238,21 +1239,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
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
index 889c122dad45..472a6a7e1558 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1558,6 +1558,7 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc);
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
 
 int dwc3_core_soft_reset(struct dwc3 *dwc);
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
 
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b134110cc2ed..2d7ac92ce9b8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2831,6 +2831,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
+	dwc3_enable_susphy(dwc, true);
 
 	return 0;
 
@@ -4573,6 +4574,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
+	dwc3_enable_susphy(dwc, false);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f4d8e80c4c34..c0dba453f1b8 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -10,9 +10,30 @@
 #include <linux/irq.h>
 #include <linux/of.h>
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
 static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
 					int irq, char *name)
 {
@@ -122,6 +143,11 @@ int dwc3_host_init(struct dwc3 *dwc)
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
@@ -136,6 +162,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 void dwc3_host_exit(struct dwc3 *dwc)
 {
+	dwc3_enable_susphy(dwc, false);
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci = NULL;
 }
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 247cca46cdfa..f10e43a948fd 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1993,7 +1993,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			buf[5] = 0x01;
 			switch (ctrl->bRequestType & USB_RECIP_MASK) {
 			case USB_RECIP_DEVICE:
-				if (w_index != 0x4 || (w_value >> 8))
+				if (w_index != 0x4 || (w_value & 0xff))
 					break;
 				buf[6] = w_index;
 				/* Number of ext compat interfaces */
@@ -2009,9 +2009,9 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
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
index 3e59055aa504..b2da74bb107a 100644
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
index 0457dd9f6c19..ab175e181e55 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -888,6 +888,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	/* Check for an all 1's result which is a typical consequence
 	 * of dead, unclocked, or unplugged (CardBus...) devices
 	 */
+again:
 	if (ints == ~(u32)0) {
 		ohci->rh_state = OHCI_RH_HALTED;
 		ohci_dbg (ohci, "device removed!\n");
@@ -982,6 +983,13 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
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
index 1fb149d1fbce..f3abce238207 100644
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
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bf615dc8085e..bbcc0e0aa070 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1479,7 +1479,8 @@ static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 	port->partner_ident.cert_stat = p[VDO_INDEX_CSTAT];
 	port->partner_ident.product = product;
 
-	typec_partner_set_identity(port->partner);
+	if (port->partner)
+		typec_partner_set_identity(port->partner);
 
 	tcpm_log(port, "Identity: %04x:%04x.%04x",
 		 PD_IDH_VID(vdo),
@@ -1567,6 +1568,9 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
 	struct typec_altmode *altmode;
 	int i;
 
+	if (!port->partner)
+		return;
+
 	for (i = 0; i < modep->altmodes; i++) {
 		altmode = typec_partner_register_altmode(port->partner,
 						&modep->altmode_desc[i]);
@@ -2416,7 +2420,7 @@ static int tcpm_register_sink_caps(struct tcpm_port *port)
 {
 	struct usb_power_delivery_desc desc = { port->negotiated_rev };
 	struct usb_power_delivery_capabilities_desc caps = { };
-	struct usb_power_delivery_capabilities *cap;
+	struct usb_power_delivery_capabilities *cap = port->partner_source_caps;
 
 	if (!port->partner_pd)
 		port->partner_pd = usb_power_delivery_register(NULL, &desc);
@@ -2426,6 +2430,9 @@ static int tcpm_register_sink_caps(struct tcpm_port *port)
 	memcpy(caps.pdo, port->sink_caps, sizeof(u32) * port->nr_sink_caps);
 	caps.role = TYPEC_SINK;
 
+	if (cap)
+		usb_power_delivery_unregister_capabilities(cap);
+
 	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
 	if (IS_ERR(cap))
 		return PTR_ERR(cap);
@@ -3635,7 +3642,10 @@ static int tcpm_init_vconn(struct tcpm_port *port)
 
 static void tcpm_typec_connect(struct tcpm_port *port)
 {
+	struct typec_partner *partner;
+
 	if (!port->connected) {
+		port->connected = true;
 		/* Make sure we don't report stale identity information */
 		memset(&port->partner_ident, 0, sizeof(port->partner_ident));
 		port->partner_desc.usb_pd = port->pd_capable;
@@ -3645,9 +3655,13 @@ static void tcpm_typec_connect(struct tcpm_port *port)
 			port->partner_desc.accessory = TYPEC_ACCESSORY_AUDIO;
 		else
 			port->partner_desc.accessory = TYPEC_ACCESSORY_NONE;
-		port->partner = typec_register_partner(port->typec_port,
-						       &port->partner_desc);
-		port->connected = true;
+		partner = typec_register_partner(port->typec_port, &port->partner_desc);
+		if (IS_ERR(partner)) {
+			dev_err(port->dev, "Failed to register partner (%ld)\n", PTR_ERR(partner));
+			return;
+		}
+
+		port->partner = partner;
 		typec_partner_set_usb_power_delivery(port->partner, port->partner_pd);
 	}
 }
@@ -3717,9 +3731,11 @@ static int tcpm_src_attach(struct tcpm_port *port)
 static void tcpm_typec_disconnect(struct tcpm_port *port)
 {
 	if (port->connected) {
-		typec_partner_set_usb_power_delivery(port->partner, NULL);
-		typec_unregister_partner(port->partner);
-		port->partner = NULL;
+		if (port->partner) {
+			typec_partner_set_usb_power_delivery(port->partner, NULL);
+			typec_unregister_partner(port->partner);
+			port->partner = NULL;
+		}
 		port->connected = false;
 	}
 }
@@ -3935,6 +3951,9 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
 
 static void tcpm_set_initial_svdm_version(struct tcpm_port *port)
 {
+	if (!port->partner)
+		return;
+
 	switch (port->negotiated_rev) {
 	case PD_REV30:
 		break;
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 98f335cbbcde..a163218fdc74 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -855,7 +855,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num)
 	struct ucsi_connector *con = &ucsi->connector[num - 1];
 
 	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
-		dev_dbg(ucsi->dev, "Bogus connector change event\n");
+		dev_dbg(ucsi->dev, "Early connector change event\n");
 		return;
 	}
 
@@ -1248,6 +1248,7 @@ static int ucsi_init(struct ucsi *ucsi)
 {
 	struct ucsi_connector *con, *connector;
 	u64 command, ntfy;
+	u32 cci;
 	int ret;
 	int i;
 
@@ -1300,6 +1301,15 @@ static int ucsi_init(struct ucsi *ucsi)
 
 	ucsi->connector = connector;
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
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 1d4919edfbde..a3ed9ab47748 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -71,6 +71,8 @@ static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 		case PCI_DEVICE_ID_INTEL_QAT_C62X_VF:
 		case PCI_DEVICE_ID_INTEL_QAT_DH895XCC:
 		case PCI_DEVICE_ID_INTEL_QAT_DH895XCC_VF:
+		case PCI_DEVICE_ID_INTEL_DSA_SPR0:
+		case PCI_DEVICE_ID_INTEL_IAX_SPR0:
 			return true;
 		default:
 			return false;
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index aec43ba83799..87222067fe5d 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -667,6 +667,7 @@ const struct file_operations v9fs_file_operations = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -708,4 +709,5 @@ const struct file_operations v9fs_mmap_file_operations_dotl = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 5e2657c1dbbe..8f287009545c 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -85,7 +85,7 @@ static int p9mode2perm(struct v9fs_session_info *v9ses,
 	int res;
 	int mode = stat->mode;
 
-	res = mode & S_IALLUGO;
+	res = mode & 0777; /* S_IRWXUGO */
 	if (v9fs_proto_dotu(v9ses)) {
 		if ((mode & P9_DMSETUID) == P9_DMSETUID)
 			res |= S_ISUID;
@@ -181,6 +181,9 @@ int v9fs_uflags2omode(int uflags, int extended)
 		break;
 	}
 
+	if (uflags & O_TRUNC)
+		ret |= P9_OTRUNC;
+
 	if (extended) {
 		if (uflags & O_EXCL)
 			ret |= P9_OEXCL;
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 2d9ee073d12c..7c35347f1d9b 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -342,6 +342,7 @@ static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
 	.free_inode = v9fs_free_inode,
 	.statfs = simple_statfs,
+	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 539bc9bdcb93..5f923c9b773e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1324,19 +1324,14 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 		unsigned int last = allocated;
 
 		allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages, page_array);
-
-		if (allocated == nr_pages)
-			return 0;
-
-		/*
-		 * During this iteration, no page could be allocated, even
-		 * though alloc_pages_bulk_array() falls back to alloc_page()
-		 * if  it could not bulk-allocate. So we must be out of memory.
-		 */
-		if (allocated == last)
+		if (unlikely(allocated == last)) {
+			/* No progress, fail and do cleanup. */
+			for (int i = 0; i < allocated; i++) {
+				__free_page(page_array[i]);
+				page_array[i] = NULL;
+			}
 			return -ENOMEM;
-
-		memalloc_retry_wait(GFP_NOFS);
+		}
 	}
 	return 0;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f7f4bcc09464..10ded9c2be03 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2472,7 +2472,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		 */
 		if (bits & EXTENT_CLEAR_META_RESV &&
 		    root != fs_info->tree_root)
-			btrfs_delalloc_release_metadata(inode, len, false);
+			btrfs_delalloc_release_metadata(inode, len, true);
 
 		/* For sanity tests. */
 		if (btrfs_is_testing(fs_info))
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 754a9fb0165f..ec3db315f561 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7955,8 +7955,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	sctx->rbtree_new_refs = RB_ROOT;
 	sctx->rbtree_deleted_refs = RB_ROOT;
 
-	sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
-				     arg->clone_sources_count + 1,
+	sctx->clone_roots = kvcalloc(arg->clone_sources_count + 1,
+				     sizeof(*sctx->clone_roots),
 				     GFP_KERNEL);
 	if (!sctx->clone_roots) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5549c843f0d3..a7853a3a5719 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1440,6 +1440,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
+			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
@@ -1464,7 +1465,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			if (ret2)
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
-			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ab5d410d560e..8c7e74499ed1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1233,25 +1233,32 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
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
@@ -3390,6 +3397,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			 * alignment and size).
 			 */
 			ret = -EUCLEAN;
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto error;
 		}
 
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index e7537fd305dd..9ad11e5bf14c 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1702,7 +1702,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	struct buffer_head *dibh, *bh;
 	struct gfs2_holder rd_gh;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
-	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
+	unsigned int bsize = 1 << bsize_shift;
+	u64 lblock = (offset + bsize - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
 	unsigned int start_aligned, end_aligned;
@@ -1713,7 +1714,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
-	if (offset >= maxsize) {
+	if (offset + bsize - 1 >= maxsize) {
 		/*
 		 * The starting point lies beyond the allocated meta-data;
 		 * there are no blocks do deallocate.
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 4fe4b3393e71..330729445d8a 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1108,10 +1108,10 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
 
-	if (hugetlb_page_subpool(&src->page)) {
-		hugetlb_set_page_subpool(&dst->page,
-					hugetlb_page_subpool(&src->page));
-		hugetlb_set_page_subpool(&src->page, NULL);
+	if (hugetlb_folio_subpool(src)) {
+		hugetlb_set_folio_subpool(dst,
+					hugetlb_folio_subpool(src));
+		hugetlb_set_folio_subpool(src, NULL);
 	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index f50e025ae406..755256875052 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -73,7 +73,6 @@ const struct rpc_program nfs_program = {
 	.number			= NFS_PROGRAM,
 	.nrvers			= ARRAY_SIZE(nfs_version),
 	.version		= nfs_version,
-	.stats			= &nfs_rpcstat,
 	.pipe_dir_name		= NFS_PIPE_DIRNAME,
 };
 
@@ -496,6 +495,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 			  const struct nfs_client_initdata *cl_init,
 			  rpc_authflavor_t flavor)
 {
+	struct nfs_net		*nn = net_generic(clp->cl_net, nfs_net_id);
 	struct rpc_clnt		*clnt = NULL;
 	struct rpc_create_args args = {
 		.net		= clp->cl_net,
@@ -507,6 +507,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		.servername	= clp->cl_hostname,
 		.nodename	= cl_init->nodename,
 		.program	= &nfs_program,
+		.stats		= &nn->rpcstats,
 		.version	= clp->rpc_ops->version,
 		.authflavor	= flavor,
 		.cred		= cl_init->cred,
@@ -1142,6 +1143,8 @@ void nfs_clients_init(struct net *net)
 #endif
 	spin_lock_init(&nn->nfs_client_lock);
 	nn->boot_time = ktime_get_real();
+	memset(&nn->rpcstats, 0, sizeof(nn->rpcstats));
+	nn->rpcstats.program = &nfs_program;
 
 	nfs_netns_sysfs_setup(nn, net);
 }
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e0c1fb98f907..cf8c3771e4bf 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2333,12 +2333,21 @@ EXPORT_SYMBOL_GPL(nfs_net_id);
 
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
@@ -2393,15 +2402,12 @@ static int __init init_nfs_fs(void)
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
@@ -2431,7 +2437,6 @@ static void __exit exit_nfs_fs(void)
 	nfs_destroy_inodecache();
 	nfs_destroy_nfspagecache();
 	unregister_pernet_subsys(&nfs_net_ops);
-	rpc_proc_unregister(&init_net, "nfs");
 	unregister_nfs_fs();
 	nfs_fs_proc_exit();
 	nfsiod_stop();
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 35a8ae46b6c3..b3b801e7c4bc 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -443,8 +443,6 @@ int nfs_try_get_tree(struct fs_context *);
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
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 338b34c99b2d..3fdafb9297f1 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1045,18 +1045,45 @@ cifs_cancelled_callback(struct mid_q_entry *mid)
 struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 {
 	uint index = 0;
+	unsigned int min_in_flight = UINT_MAX, max_in_flight = 0;
+	struct TCP_Server_Info *server = NULL;
+	int i;
 
 	if (!ses)
 		return NULL;
 
-	/* round robin */
-	index = (uint)atomic_inc_return(&ses->chan_seq);
-
 	spin_lock(&ses->chan_lock);
-	index %= ses->chan_count;
+	for (i = 0; i < ses->chan_count; i++) {
+		server = ses->chans[i].server;
+		if (!server)
+			continue;
+
+		/*
+		 * strictly speaking, we should pick up req_lock to read
+		 * server->in_flight. But it shouldn't matter much here if we
+		 * race while reading this data. The worst that can happen is
+		 * that we could use a channel that's not least loaded. Avoiding
+		 * taking the lock could help reduce wait time, which is
+		 * important for this function
+		 */
+		if (server->in_flight < min_in_flight) {
+			min_in_flight = server->in_flight;
+			index = i;
+		}
+		if (server->in_flight > max_in_flight)
+			max_in_flight = server->in_flight;
+	}
+
+	/* if all channels are equally loaded, fall back to round-robin */
+	if (min_in_flight == max_in_flight) {
+		index = (uint)atomic_inc_return(&ses->chan_seq);
+		index %= ses->chan_count;
+	}
+
+	server = ses->chans[index].server;
 	spin_unlock(&ses->chan_lock);
 
-	return ses->chans[index].server;
+	return server;
 }
 
 int
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 1253e9bde34c..1b98796499d7 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -612,13 +612,23 @@ static int oplock_break_pending(struct oplock_info *opinfo, int req_op_level)
 
 		if (opinfo->op_state == OPLOCK_CLOSING)
 			return -ENOENT;
-		else if (!opinfo->is_lease && opinfo->level <= req_op_level)
-			return 1;
+		else if (opinfo->level <= req_op_level) {
+			if (opinfo->is_lease &&
+			    opinfo->o_lease->state !=
+			     (SMB2_LEASE_HANDLE_CACHING_LE |
+			      SMB2_LEASE_READ_CACHING_LE))
+				return 1;
+		}
 	}
 
-	if (!opinfo->is_lease && opinfo->level <= req_op_level) {
-		wake_up_oplock_break(opinfo);
-		return 1;
+	if (opinfo->level <= req_op_level) {
+		if (opinfo->is_lease &&
+		    opinfo->o_lease->state !=
+		     (SMB2_LEASE_HANDLE_CACHING_LE |
+		      SMB2_LEASE_READ_CACHING_LE)) {
+			wake_up_oplock_break(opinfo);
+			return 1;
+		}
 	}
 	return 0;
 }
@@ -886,7 +896,6 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
 		struct lease *lease = brk_opinfo->o_lease;
 
 		atomic_inc(&brk_opinfo->breaking_cnt);
-
 		err = oplock_break_pending(brk_opinfo, req_op_level);
 		if (err)
 			return err < 0 ? err : 0;
@@ -1199,7 +1208,9 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 
 	/* Only v2 leases handle the directory */
 	if (S_ISDIR(file_inode(fp->filp)->i_mode)) {
-		if (!lctx || lctx->version != 2)
+		if (!lctx || lctx->version != 2 ||
+		    (lctx->flags != SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE &&
+		     !lctx->epoch))
 			return 0;
 	}
 
@@ -1461,8 +1472,9 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 		buf->lcontext.LeaseFlags = lease->flags;
 		buf->lcontext.Epoch = cpu_to_le16(lease->epoch);
 		buf->lcontext.LeaseState = lease->state;
-		memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
-		       SMB2_LEASE_KEY_SIZE);
+		if (lease->flags == SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE)
+			memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
+			       SMB2_LEASE_KEY_SIZE);
 		buf->ccontext.DataOffset = cpu_to_le16(offsetof
 				(struct create_lease_v2, lcontext));
 		buf->ccontext.DataLength = cpu_to_le32(sizeof(struct lease_context_v2));
@@ -1527,8 +1539,9 @@ struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
 		lreq->flags = lc->lcontext.LeaseFlags;
 		lreq->epoch = lc->lcontext.Epoch;
 		lreq->duration = lc->lcontext.LeaseDuration;
-		memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
-				SMB2_LEASE_KEY_SIZE);
+		if (lreq->flags == SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE)
+			memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
+			       SMB2_LEASE_KEY_SIZE);
 		lreq->version = 2;
 	} else {
 		struct create_lease *lc = (struct create_lease *)cc;
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 9d4222154dcc..0012919309f1 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -446,6 +446,10 @@ static int create_socket(struct interface *iface)
 		sin6.sin6_family = PF_INET6;
 		sin6.sin6_addr = in6addr_any;
 		sin6.sin6_port = htons(server_conf.tcp_port);
+
+		lock_sock(ksmbd_socket->sk);
+		ksmbd_socket->sk->sk_ipv6only = false;
+		release_sock(ksmbd_socket->sk);
 	}
 
 	ksmbd_tcp_nodelay(ksmbd_socket);
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 574b4121ebe3..8f50c589ad5f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -226,6 +226,17 @@ struct ftrace_likely_data {
 # define __no_kcsan
 #endif
 
+#ifdef __SANITIZE_MEMORY__
+/*
+ * Similarly to KASAN and KCSAN, KMSAN loses function attributes of inlined
+ * functions, therefore disabling KMSAN checks also requires disabling inlining.
+ *
+ * __no_sanitize_or_inline effectively prevents KMSAN from reporting errors
+ * within the function and marks all its outputs as initialized.
+ */
+# define __no_sanitize_or_inline __no_kmsan_checks notrace __maybe_unused
+#endif
+
 #ifndef __no_sanitize_or_inline
 #define __no_sanitize_or_inline __always_inline
 #endif
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 5d6a5f3097cd..b79097b9070b 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -659,11 +659,4 @@ static inline bool dma_fence_is_container(struct dma_fence *fence)
 	return dma_fence_is_array(fence) || dma_fence_is_chain(fence);
 }
 
-#define DMA_FENCE_WARN(f, fmt, args...) \
-	do {								\
-		struct dma_fence *__ff = (f);				\
-		pr_warn("f %llu#%llu: " fmt, __ff->context, __ff->seqno,\
-			 ##args);					\
-	} while (0)
-
 #endif /* __LINUX_DMA_FENCE_H */
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index d88c46ca82e1..6811ab702e8d 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_GFP_TYPES_H
 #define __LINUX_GFP_TYPES_H
 
+#include <linux/bits.h>
+
 /* The typedef is in types.h but we want the documentation here */
 #if 0
 /**
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1c6f35ba1604..37eeef9841c4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -625,26 +625,50 @@ enum hugetlb_page_flags {
  */
 #ifdef CONFIG_HUGETLB_PAGE
 #define TESTHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+bool folio_test_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		return test_bit(HPG_##flname, private);		\
+	}							\
 static inline int HPage##uname(struct page *page)		\
 	{ return test_bit(HPG_##flname, &(page->private)); }
 
 #define SETHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+void folio_set_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		set_bit(HPG_##flname, private);			\
+	}							\
 static inline void SetHPage##uname(struct page *page)		\
 	{ set_bit(HPG_##flname, &(page->private)); }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+void folio_clear_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		clear_bit(HPG_##flname, private);		\
+	}							\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ clear_bit(HPG_##flname, &(page->private)); }
 #else
 #define TESTHPAGEFLAG(uname, flname)				\
+static inline bool						\
+folio_test_hugetlb_##flname(struct folio *folio)		\
+	{ return 0; }						\
 static inline int HPage##uname(struct page *page)		\
 	{ return 0; }
 
 #define SETHPAGEFLAG(uname, flname)				\
+static inline void						\
+folio_set_hugetlb_##flname(struct folio *folio) 		\
+	{ }							\
 static inline void SetHPage##uname(struct page *page)		\
 	{ }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
+static inline void						\
+folio_clear_hugetlb_##flname(struct folio *folio)		\
+	{ }							\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ }
 #endif
@@ -730,18 +754,29 @@ extern unsigned int default_hstate_idx;
 
 #define default_hstate (hstates[default_hstate_idx])
 
+static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
+{
+	return (void *)folio_get_private_1(folio);
+}
+
 /*
  * hugetlb page subpool pointer located in hpage[1].private
  */
 static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
 {
-	return (void *)page_private(hpage + SUBPAGE_INDEX_SUBPOOL);
+	return hugetlb_folio_subpool(page_folio(hpage));
+}
+
+static inline void hugetlb_set_folio_subpool(struct folio *folio,
+					struct hugepage_subpool *subpool)
+{
+	folio_set_private_1(folio, (unsigned long)subpool);
 }
 
 static inline void hugetlb_set_page_subpool(struct page *hpage,
 					struct hugepage_subpool *subpool)
 {
-	set_page_private(hpage + SUBPAGE_INDEX_SUBPOOL, (unsigned long)subpool);
+	hugetlb_set_folio_subpool(page_folio(hpage), subpool);
 }
 
 static inline struct hstate *hstate_file(struct file *f)
@@ -828,10 +863,15 @@ static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
 }
 #endif
 
+static inline struct hstate *folio_hstate(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+	return size_to_hstate(folio_size(folio));
+}
+
 static inline struct hstate *page_hstate(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
-	return size_to_hstate(page_size(page));
+	return folio_hstate(page_folio(page));
 }
 
 static inline unsigned hstate_index_to_shift(unsigned index)
@@ -1042,6 +1082,11 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
 	return NULL;
 }
 
+static inline struct hstate *folio_hstate(struct folio *folio)
+{
+	return NULL;
+}
+
 static inline struct hstate *page_hstate(struct page *page)
 {
 	return NULL;
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 630cd255d0cf..241bf4fe701a 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -67,54 +67,61 @@ struct hugetlb_cgroup {
 };
 
 static inline struct hugetlb_cgroup *
-__hugetlb_cgroup_from_page(struct page *page, bool rsvd)
+__hugetlb_cgroup_from_folio(struct folio *folio, bool rsvd)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
+	struct page *tail;
 
-	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+	if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
 		return NULL;
-	if (rsvd)
-		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP_RSVD);
-	else
-		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP);
+
+	if (rsvd) {
+		tail = folio_page(folio, SUBPAGE_INDEX_CGROUP_RSVD);
+		return (void *)page_private(tail);
+	}
+
+	else {
+		tail = folio_page(folio, SUBPAGE_INDEX_CGROUP);
+		return (void *)page_private(tail);
+	}
 }
 
-static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
+static inline struct hugetlb_cgroup *hugetlb_cgroup_from_folio(struct folio *folio)
 {
-	return __hugetlb_cgroup_from_page(page, false);
+	return __hugetlb_cgroup_from_folio(folio, false);
 }
 
 static inline struct hugetlb_cgroup *
-hugetlb_cgroup_from_page_rsvd(struct page *page)
+hugetlb_cgroup_from_folio_rsvd(struct folio *folio)
 {
-	return __hugetlb_cgroup_from_page(page, true);
+	return __hugetlb_cgroup_from_folio(folio, true);
 }
 
-static inline void __set_hugetlb_cgroup(struct page *page,
+static inline void __set_hugetlb_cgroup(struct folio *folio,
 				       struct hugetlb_cgroup *h_cg, bool rsvd)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 
-	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
+	if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
 		return;
 	if (rsvd)
-		set_page_private(page + SUBPAGE_INDEX_CGROUP_RSVD,
+		set_page_private(folio_page(folio, SUBPAGE_INDEX_CGROUP_RSVD),
 				 (unsigned long)h_cg);
 	else
-		set_page_private(page + SUBPAGE_INDEX_CGROUP,
+		set_page_private(folio_page(folio, SUBPAGE_INDEX_CGROUP),
 				 (unsigned long)h_cg);
 }
 
 static inline void set_hugetlb_cgroup(struct page *page,
 				     struct hugetlb_cgroup *h_cg)
 {
-	__set_hugetlb_cgroup(page, h_cg, false);
+	__set_hugetlb_cgroup(page_folio(page), h_cg, false);
 }
 
 static inline void set_hugetlb_cgroup_rsvd(struct page *page,
 					  struct hugetlb_cgroup *h_cg)
 {
-	__set_hugetlb_cgroup(page, h_cg, true);
+	__set_hugetlb_cgroup(page_folio(page), h_cg, true);
 }
 
 static inline bool hugetlb_cgroup_disabled(void)
@@ -151,10 +158,10 @@ extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 extern void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 					      struct hugetlb_cgroup *h_cg,
 					      struct page *page);
-extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-					 struct page *page);
-extern void hugetlb_cgroup_uncharge_page_rsvd(int idx, unsigned long nr_pages,
-					      struct page *page);
+extern void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
+					 struct folio *folio);
+extern void hugetlb_cgroup_uncharge_folio_rsvd(int idx, unsigned long nr_pages,
+					      struct folio *folio);
 
 extern void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 					   struct hugetlb_cgroup *h_cg);
@@ -181,19 +188,13 @@ static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 {
 }
 
-static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
+static inline struct hugetlb_cgroup *hugetlb_cgroup_from_folio(struct folio *folio)
 {
 	return NULL;
 }
 
 static inline struct hugetlb_cgroup *
-hugetlb_cgroup_from_page_resv(struct page *page)
-{
-	return NULL;
-}
-
-static inline struct hugetlb_cgroup *
-hugetlb_cgroup_from_page_rsvd(struct page *page)
+hugetlb_cgroup_from_folio_rsvd(struct folio *folio)
 {
 	return NULL;
 }
@@ -253,14 +254,14 @@ hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 {
 }
 
-static inline void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-						struct page *page)
+static inline void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
+						struct folio *folio)
 {
 }
 
-static inline void hugetlb_cgroup_uncharge_page_rsvd(int idx,
+static inline void hugetlb_cgroup_uncharge_folio_rsvd(int idx,
 						     unsigned long nr_pages,
-						     struct page *page)
+						     struct folio *folio)
 {
 }
 static inline void hugetlb_cgroup_uncharge_cgroup(int idx,
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 4fbd5d841711..811d59cf891b 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -832,6 +832,7 @@ struct vmbus_gpadl {
 	u32 gpadl_handle;
 	u32 size;
 	void *buffer;
+	bool decrypted;
 };
 
 struct vmbus_channel {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 247aedb18d5c..a9c1d611029d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -144,6 +144,7 @@ struct page {
 			atomic_t compound_pincount;
 #ifdef CONFIG_64BIT
 			unsigned int compound_nr; /* 1 << compound_order */
+			unsigned long _private_1;
 #endif
 		};
 		struct {	/* Second tail page of compound page */
@@ -264,6 +265,7 @@ struct page {
  * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
+ * @_private_1: Do not use directly, call folio_get_private_1().
  *
  * A folio is a physically, virtually and logically contiguous set
  * of bytes.  It is a power-of-two in size, and it is aligned to that
@@ -311,6 +313,7 @@ struct folio {
 #ifdef CONFIG_64BIT
 	unsigned int _folio_nr_pages;
 #endif
+	unsigned long _private_1;
 };
 
 #define FOLIO_MATCH(pg, fl)						\
@@ -338,6 +341,7 @@ FOLIO_MATCH(compound_mapcount, _total_mapcount);
 FOLIO_MATCH(compound_pincount, _pincount);
 #ifdef CONFIG_64BIT
 FOLIO_MATCH(compound_nr, _folio_nr_pages);
+FOLIO_MATCH(_private_1, _private_1);
 #endif
 #undef FOLIO_MATCH
 
@@ -383,6 +387,16 @@ static inline void *folio_get_private(struct folio *folio)
 	return folio->private;
 }
 
+static inline void folio_set_private_1(struct folio *folio, unsigned long private)
+{
+	folio->_private_1 = private;
+}
+
+static inline unsigned long folio_get_private_1(struct folio *folio)
+{
+	return folio->_private_1;
+}
+
 struct page_frag_cache {
 	void * va;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9e9794d03c9f..2c1371320c29 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2664,7 +2664,9 @@
 #define PCI_DEVICE_ID_INTEL_QUARK_X1000_ILB	0x095e
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
 #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
+#define PCI_DEVICE_ID_INTEL_DSA_SPR0	0x0b25
 #define PCI_DEVICE_ID_INTEL_CENTERTON_ILB	0x0c60
+#define PCI_DEVICE_ID_INTEL_IAX_SPR0	0x0cfe
 #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062
 #define PCI_DEVICE_ID_INTEL_82573E_SOL	0x1085
 #define PCI_DEVICE_ID_INTEL_82573L_SOL	0x108f
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 487117ccb1bc..fb25085d0922 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -206,6 +206,26 @@ extern int pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 				const char *pin_group, const unsigned **pins,
 				unsigned *num_pins);
 
+/**
+ * struct pinfunction - Description about a function
+ * @name: Name of the function
+ * @groups: An array of groups for this function
+ * @ngroups: Number of groups in @groups
+ */
+struct pinfunction {
+	const char *name;
+	const char * const *groups;
+	size_t ngroups;
+};
+
+/* Convenience macro to define a single named pinfunction */
+#define PINCTRL_PINFUNCTION(_name, _groups, _ngroups)	\
+(struct pinfunction) {					\
+		.name = (_name),			\
+		.groups = (_groups),			\
+		.ngroups = (_ngroups),			\
+	}
+
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_PINCTRL)
 extern struct pinctrl_dev *of_pinctrl_get(struct device_node *np);
 #else
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index ee3b4a014611..a9ca87a8f4e6 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -361,13 +361,13 @@ devm_regulator_get_exclusive(struct device *dev, const char *id)
 
 static inline int devm_regulator_get_enable(struct device *dev, const char *id)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static inline int devm_regulator_get_enable_optional(struct device *dev,
 						     const char *id)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static inline struct regulator *__must_check
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d5f888fe0e33..cecd3b6bebb8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2927,6 +2927,21 @@ static inline void skb_mac_header_rebuild(struct sk_buff *skb)
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
index bd4418377bac..062fe440f5d0 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -456,10 +456,12 @@ static inline void sk_psock_put(struct sock *sk, struct sk_psock *psock)
 
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
diff --git a/include/linux/slab.h b/include/linux/slab.h
index cb4b5deca9a9..b8e77ffc3892 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -198,7 +198,7 @@ void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
-DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
+DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
 
 /**
  * ksize - Report actual allocation size of associated object
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8e9054d9f6df..0ce659d6fcb7 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -376,6 +376,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @max_speed_hz: Highest supported transfer speed
  * @flags: other constraints relevant to this driver
  * @slave: indicates that this is an SPI slave controller
+ * @target: indicates that this is an SPI target controller
  * @devm_allocated: whether the allocation of this struct is devres-managed
  * @max_transfer_size: function that returns the max transfer size for
  *	a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
@@ -460,6 +461,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @mem_caps: controller capabilities for the handling of memory operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
+ * @target_abort: abort the ongoing transfer request on an SPI target controller
  * @cs_gpiods: Array of GPIO descs to use as chip select lines; one per CS
  *	number. Any individual value may be NULL for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
@@ -556,8 +558,12 @@ struct spi_controller {
 	/* Flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
 
-	/* Flag indicating this is an SPI slave controller */
-	bool			slave;
+	union {
+		/* Flag indicating this is an SPI slave controller */
+		bool			slave;
+		/* Flag indicating this is an SPI target controller */
+		bool			target;
+	};
 
 	/*
 	 * on some hardware transfer / message size may be constrained
@@ -670,7 +676,10 @@ struct spi_controller {
 			       struct spi_message *message);
 	int (*unprepare_message)(struct spi_controller *ctlr,
 				 struct spi_message *message);
-	int (*slave_abort)(struct spi_controller *ctlr);
+	union {
+		int (*slave_abort)(struct spi_controller *ctlr);
+		int (*target_abort)(struct spi_controller *ctlr);
+	};
 
 	/*
 	 * These hooks are for drivers that use a generic implementation
@@ -748,6 +757,11 @@ static inline bool spi_controller_is_slave(struct spi_controller *ctlr)
 	return IS_ENABLED(CONFIG_SPI_SLAVE) && ctlr->slave;
 }
 
+static inline bool spi_controller_is_target(struct spi_controller *ctlr)
+{
+	return IS_ENABLED(CONFIG_SPI_SLAVE) && ctlr->target;
+}
+
 /* PM calls that need to be issued by the driver */
 extern int spi_controller_suspend(struct spi_controller *ctlr);
 extern int spi_controller_resume(struct spi_controller *ctlr);
@@ -784,6 +798,21 @@ static inline struct spi_controller *spi_alloc_slave(struct device *host,
 	return __spi_alloc_controller(host, size, true);
 }
 
+static inline struct spi_controller *spi_alloc_host(struct device *dev,
+						    unsigned int size)
+{
+	return __spi_alloc_controller(dev, size, false);
+}
+
+static inline struct spi_controller *spi_alloc_target(struct device *dev,
+						      unsigned int size)
+{
+	if (!IS_ENABLED(CONFIG_SPI_SLAVE))
+		return NULL;
+
+	return __spi_alloc_controller(dev, size, true);
+}
+
 struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
 						   unsigned int size,
 						   bool slave);
@@ -803,6 +832,21 @@ static inline struct spi_controller *devm_spi_alloc_slave(struct device *dev,
 	return __devm_spi_alloc_controller(dev, size, true);
 }
 
+static inline struct spi_controller *devm_spi_alloc_host(struct device *dev,
+							 unsigned int size)
+{
+	return __devm_spi_alloc_controller(dev, size, false);
+}
+
+static inline struct spi_controller *devm_spi_alloc_target(struct device *dev,
+							   unsigned int size)
+{
+	if (!IS_ENABLED(CONFIG_SPI_SLAVE))
+		return NULL;
+
+	return __devm_spi_alloc_controller(dev, size, true);
+}
+
 extern int spi_register_controller(struct spi_controller *ctlr);
 extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
@@ -1162,6 +1206,7 @@ static inline void spi_message_free(struct spi_message *m)
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
 extern int spi_slave_abort(struct spi_device *spi);
+extern int spi_target_abort(struct spi_device *spi);
 
 static inline size_t
 spi_max_message_size(struct spi_device *spi)
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index c794b0ce4e78..809c23120d54 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -131,6 +131,7 @@ struct rpc_create_args {
 	const char		*servername;
 	const char		*nodename;
 	const struct rpc_program *program;
+	struct rpc_stat		*stats;
 	u32			prognumber;	/* overrides program->number */
 	u32			version;
 	rpc_authflavor_t	authflavor;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index b07b277d6a16..1f59f9edcc24 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -409,6 +409,55 @@ static inline bool is_migration_entry_dirty(swp_entry_t entry)
 }
 #endif	/* CONFIG_MIGRATION */
 
+#ifdef CONFIG_MEMORY_FAILURE
+
+extern atomic_long_t num_poisoned_pages __read_mostly;
+
+/*
+ * Support for hardware poisoned pages
+ */
+static inline swp_entry_t make_hwpoison_entry(struct page *page)
+{
+	BUG_ON(!PageLocked(page));
+	return swp_entry(SWP_HWPOISON, page_to_pfn(page));
+}
+
+static inline int is_hwpoison_entry(swp_entry_t entry)
+{
+	return swp_type(entry) == SWP_HWPOISON;
+}
+
+static inline void num_poisoned_pages_inc(void)
+{
+	atomic_long_inc(&num_poisoned_pages);
+}
+
+static inline void num_poisoned_pages_sub(long i)
+{
+	atomic_long_sub(i, &num_poisoned_pages);
+}
+
+#else  /* CONFIG_MEMORY_FAILURE */
+
+static inline swp_entry_t make_hwpoison_entry(struct page *page)
+{
+	return swp_entry(0, 0);
+}
+
+static inline int is_hwpoison_entry(swp_entry_t swp)
+{
+	return 0;
+}
+
+static inline void num_poisoned_pages_inc(void)
+{
+}
+
+static inline void num_poisoned_pages_sub(long i)
+{
+}
+#endif  /* CONFIG_MEMORY_FAILURE */
+
 typedef unsigned long pte_marker;
 
 #define  PTE_MARKER_UFFD_WP  BIT(0)
@@ -503,8 +552,9 @@ static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 
 /*
  * A pfn swap entry is a special type of swap entry that always has a pfn stored
- * in the swap offset. They are used to represent unaddressable device memory
- * and to restrict access to a page undergoing migration.
+ * in the swap offset. They can either be used to represent unaddressable device
+ * memory, to restrict access to a page undergoing migration or to represent a
+ * pfn which has been hwpoisoned and unmapped.
  */
 static inline bool is_pfn_swap_entry(swp_entry_t entry)
 {
@@ -512,7 +562,7 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
 	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
 
 	return is_migration_entry(entry) || is_device_private_entry(entry) ||
-	       is_device_exclusive_entry(entry);
+	       is_device_exclusive_entry(entry) || is_hwpoison_entry(entry);
 }
 
 struct page_vma_mapped_walk;
@@ -581,55 +631,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 }
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-#ifdef CONFIG_MEMORY_FAILURE
-
-extern atomic_long_t num_poisoned_pages __read_mostly;
-
-/*
- * Support for hardware poisoned pages
- */
-static inline swp_entry_t make_hwpoison_entry(struct page *page)
-{
-	BUG_ON(!PageLocked(page));
-	return swp_entry(SWP_HWPOISON, page_to_pfn(page));
-}
-
-static inline int is_hwpoison_entry(swp_entry_t entry)
-{
-	return swp_type(entry) == SWP_HWPOISON;
-}
-
-static inline void num_poisoned_pages_inc(void)
-{
-	atomic_long_inc(&num_poisoned_pages);
-}
-
-static inline void num_poisoned_pages_sub(long i)
-{
-	atomic_long_sub(i, &num_poisoned_pages);
-}
-
-#else  /* CONFIG_MEMORY_FAILURE */
-
-static inline swp_entry_t make_hwpoison_entry(struct page *page)
-{
-	return swp_entry(0, 0);
-}
-
-static inline int is_hwpoison_entry(swp_entry_t swp)
-{
-	return 0;
-}
-
-static inline void num_poisoned_pages_inc(void)
-{
-}
-
-static inline void num_poisoned_pages_sub(long i)
-{
-}
-#endif  /* CONFIG_MEMORY_FAILURE */
-
 static inline int non_swap_entry(swp_entry_t entry)
 {
 	return swp_type(entry) >= MAX_SWAPFILES;
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 6d18f04ad703..e338e173ce8b 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -169,7 +169,6 @@ static inline int timer_pending(const struct timer_list * timer)
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
-extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
@@ -184,6 +183,7 @@ extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
+extern int timer_delete(struct timer_list *timer);
 
 /**
  * del_timer_sync - Delete a pending timer and wait for a running callback
@@ -198,7 +198,18 @@ static inline int del_timer_sync(struct timer_list *timer)
 	return timer_delete_sync(timer);
 }
 
-#define del_singleshot_timer_sync(t) del_timer_sync(t)
+/**
+ * del_timer - Delete a pending timer
+ * @timer:	The timer to be deleted
+ *
+ * See timer_delete() for detailed explanation.
+ *
+ * Do not use in new code. Use timer_delete() instead.
+ */
+static inline int del_timer(struct timer_list *timer)
+{
+	return timer_delete(timer);
+}
 
 extern void init_timers(void);
 struct hrtimer;
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 9ec6f2e92ad3..5b9c2c535702 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1032,6 +1032,9 @@ struct xfrm_offload {
 #define CRYPTO_INVALID_PACKET_SYNTAX		64
 #define CRYPTO_INVALID_PROTOCOL			128
 
+	/* Used to keep whole l2 header for transport mode GRO */
+	__u32			orig_mac_len;
+
 	__u8			proto;
 	__u8			inner_ipproto;
 };
diff --git a/include/uapi/scsi/scsi_bsg_mpi3mr.h b/include/uapi/scsi/scsi_bsg_mpi3mr.h
index fdc3517f9e19..c48c5d08c0fa 100644
--- a/include/uapi/scsi/scsi_bsg_mpi3mr.h
+++ b/include/uapi/scsi/scsi_bsg_mpi3mr.h
@@ -382,7 +382,7 @@ struct mpi3mr_bsg_in_reply_buf {
 	__u8	mpi_reply_type;
 	__u8	rsvd1;
 	__u16	rsvd2;
-	__u8	reply_buf[1];
+	__u8	reply_buf[];
 };
 
 /**
diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 48ee750849f2..78e810f49c44 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -88,6 +88,18 @@ static int bloom_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 	return -EOPNOTSUPP;
 }
 
+/* Called from syscall */
+static int bloom_map_alloc_check(union bpf_attr *attr)
+{
+	if (attr->value_size > KMALLOC_MAX_SIZE)
+		/* if value_size is bigger, the user space won't be able to
+		 * access the elements.
+		 */
+		return -E2BIG;
+
+	return 0;
+}
+
 static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 {
 	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
@@ -196,6 +208,7 @@ static int bloom_map_check_btf(const struct bpf_map *map,
 BTF_ID_LIST_SINGLE(bpf_bloom_map_btf_ids, struct, bpf_bloom_filter)
 const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = bloom_map_alloc_check,
 	.map_alloc = bloom_map_alloc,
 	.map_free = bloom_map_free,
 	.map_get_next_key = bloom_map_get_next_key,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 27cc6e3db5a8..18b3f429abe1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13177,8 +13177,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			f = fdget(fd);
 			map = __bpf_map_get(f);
 			if (IS_ERR(map)) {
-				verbose(env, "fd %d is not pointing to valid bpf_map\n",
-					insn[0].imm);
+				verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
 				return PTR_ERR(map);
 			}
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 59469897432b..e09852be4e63 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1255,7 +1255,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 EXPORT_SYMBOL_GPL(add_timer_on);
 
 /**
- * del_timer - Deactivate a timer.
+ * timer_delete - Deactivate a timer
  * @timer:	The timer to be deactivated
  *
  * The function only deactivates a pending timer, but contrary to
@@ -1268,7 +1268,7 @@ EXPORT_SYMBOL_GPL(add_timer_on);
  * * %0 - The timer was not pending
  * * %1 - The timer was pending and deactivated
  */
-int del_timer(struct timer_list *timer)
+int timer_delete(struct timer_list *timer)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1284,7 +1284,7 @@ int del_timer(struct timer_list *timer)
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer);
+EXPORT_SYMBOL(timer_delete);
 
 /**
  * try_to_del_timer_sync - Try to deactivate a timer
@@ -1963,7 +1963,7 @@ signed long __sched schedule_timeout(signed long timeout)
 	timer_setup_on_stack(&timer.timer, process_timeout, 0);
 	__mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
 	schedule();
-	del_singleshot_timer_sync(&timer.timer);
+	del_timer_sync(&timer.timer);
 
 	/* Remove the timer from the object tracker */
 	destroy_timer_on_stack(&timer.timer);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 95541b99aa8e..b2dff1935893 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -343,7 +343,7 @@ config DEBUG_INFO_SPLIT
 	  Incompatible with older versions of ccache.
 
 config DEBUG_INFO_BTF
-	bool "Generate BTF typeinfo"
+	bool "Generate BTF type information"
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
@@ -374,7 +374,8 @@ config PAHOLE_HAS_LANG_EXCLUDE
 	  using DEBUG_INFO_BTF_MODULES.
 
 config DEBUG_INFO_BTF_MODULES
-	def_bool y
+	bool "Generate BTF type information for kernel modules"
+	default y
 	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
 	help
 	  Generate compact split BTF type information for kernel modules.
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 009f2ead09c1..939678ea930e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -301,7 +301,11 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 37288a7f0fa6..4361dcf70139 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1661,9 +1661,10 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
 							bool demote)
 {
 	int nid = page_to_nid(page);
+	struct folio *folio = page_folio(page);
 
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
+	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio(folio), folio);
+	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
 
 	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1761,7 +1762,6 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
 	struct page *subpage;
-	bool clear_dtor = HPageVmemmapOptimized(page);
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
@@ -1796,7 +1796,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 * If vmemmap pages were allocated above, then we need to clear the
 	 * hugetlb destructor under the hugetlb lock.
 	 */
-	if (clear_dtor) {
+	if (PageHuge(page)) {
 		spin_lock_irq(&hugetlb_lock);
 		__clear_hugetlb_destructor(h, page);
 		spin_unlock_irq(&hugetlb_lock);
@@ -1917,21 +1917,22 @@ void free_huge_page(struct page *page)
 	 * Can't pass hstate in here because it is called from the
 	 * compound page destructor.
 	 */
-	struct hstate *h = page_hstate(page);
-	int nid = page_to_nid(page);
-	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
+	struct folio *folio = page_folio(page);
+	struct hstate *h = folio_hstate(folio);
+	int nid = folio_nid(folio);
+	struct hugepage_subpool *spool = hugetlb_folio_subpool(folio);
 	bool restore_reserve;
 	unsigned long flags;
 
-	VM_BUG_ON_PAGE(page_count(page), page);
-	VM_BUG_ON_PAGE(page_mapcount(page), page);
+	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
+	VM_BUG_ON_FOLIO(folio_mapcount(folio), folio);
 
-	hugetlb_set_page_subpool(page, NULL);
-	if (PageAnon(page))
-		__ClearPageAnonExclusive(page);
-	page->mapping = NULL;
-	restore_reserve = HPageRestoreReserve(page);
-	ClearHPageRestoreReserve(page);
+	hugetlb_set_folio_subpool(folio, NULL);
+	if (folio_test_anon(folio))
+		__ClearPageAnonExclusive(&folio->page);
+	folio->mapping = NULL;
+	restore_reserve = folio_test_hugetlb_restore_reserve(folio);
+	folio_clear_hugetlb_restore_reserve(folio);
 
 	/*
 	 * If HPageRestoreReserve was set on page, page allocation consumed a
@@ -1953,15 +1954,15 @@ void free_huge_page(struct page *page)
 	}
 
 	spin_lock_irqsave(&hugetlb_lock, flags);
-	ClearHPageMigratable(page);
-	hugetlb_cgroup_uncharge_page(hstate_index(h),
-				     pages_per_huge_page(h), page);
-	hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
-					  pages_per_huge_page(h), page);
+	folio_clear_hugetlb_migratable(folio);
+	hugetlb_cgroup_uncharge_folio(hstate_index(h),
+				     pages_per_huge_page(h), folio);
+	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
+					  pages_per_huge_page(h), folio);
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
-	if (HPageTemporary(page)) {
+	if (folio_test_hugetlb_temporary(folio)) {
 		remove_hugetlb_page(h, page, false);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page, true);
@@ -3080,6 +3081,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct page *page;
+	struct folio *folio;
 	long map_chg, map_commit;
 	long gbl_chg;
 	int ret, idx;
@@ -3143,6 +3145,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * a reservation exists for the allocation.
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
+
 	if (!page) {
 		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
@@ -3157,6 +3160,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		set_page_refcounted(page);
 		/* Fall through */
 	}
+	folio = page_folio(page);
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
 	/* If allocation is not consuming a reservation, also store the
 	 * hugetlb_cgroup pointer on the page.
@@ -3185,9 +3189,12 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 
 		rsv_adjust = hugepage_subpool_put_pages(spool, 1);
 		hugetlb_acct_memory(h, -rsv_adjust);
-		if (deferred_reserve)
-			hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
-					pages_per_huge_page(h), page);
+		if (deferred_reserve) {
+			spin_lock_irq(&hugetlb_lock);
+			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
+					pages_per_huge_page(h), folio);
+			spin_unlock_irq(&hugetlb_lock);
+		}
 	}
 	return page;
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index f61d132df52b..32f4408eda24 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -191,8 +191,9 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	struct page_counter *counter;
 	struct hugetlb_cgroup *page_hcg;
 	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
+	struct folio *folio = page_folio(page);
 
-	page_hcg = hugetlb_cgroup_from_page(page);
+	page_hcg = hugetlb_cgroup_from_folio(folio);
 	/*
 	 * We can have pages in active list without any cgroup
 	 * ie, hugepage with less than 3 pages. We can safely
@@ -314,7 +315,7 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
 
-	__set_hugetlb_cgroup(page, h_cg, rsvd);
+	__set_hugetlb_cgroup(page_folio(page), h_cg, rsvd);
 	if (!rsvd) {
 		unsigned long usage =
 			h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
@@ -345,18 +346,18 @@ void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 /*
  * Should be called with hugetlb_lock held
  */
-static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-					   struct page *page, bool rsvd)
+static void __hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
+					   struct folio *folio, bool rsvd)
 {
 	struct hugetlb_cgroup *h_cg;
 
 	if (hugetlb_cgroup_disabled())
 		return;
 	lockdep_assert_held(&hugetlb_lock);
-	h_cg = __hugetlb_cgroup_from_page(page, rsvd);
+	h_cg = __hugetlb_cgroup_from_folio(folio, rsvd);
 	if (unlikely(!h_cg))
 		return;
-	__set_hugetlb_cgroup(page, NULL, rsvd);
+	__set_hugetlb_cgroup(folio, NULL, rsvd);
 
 	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
 								   rsvd),
@@ -366,27 +367,27 @@ static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 		css_put(&h_cg->css);
 	else {
 		unsigned long usage =
-			h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
+			h_cg->nodeinfo[folio_nid(folio)]->usage[idx];
 		/*
 		 * This write is not atomic due to fetching usage and writing
 		 * to it, but that's fine because we call this with
 		 * hugetlb_lock held anyway.
 		 */
-		WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx],
+		WRITE_ONCE(h_cg->nodeinfo[folio_nid(folio)]->usage[idx],
 			   usage - nr_pages);
 	}
 }
 
-void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-				  struct page *page)
+void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
+				  struct folio *folio)
 {
-	__hugetlb_cgroup_uncharge_page(idx, nr_pages, page, false);
+	__hugetlb_cgroup_uncharge_folio(idx, nr_pages, folio, false);
 }
 
-void hugetlb_cgroup_uncharge_page_rsvd(int idx, unsigned long nr_pages,
-				       struct page *page)
+void hugetlb_cgroup_uncharge_folio_rsvd(int idx, unsigned long nr_pages,
+				       struct folio *folio)
 {
-	__hugetlb_cgroup_uncharge_page(idx, nr_pages, page, true);
+	__hugetlb_cgroup_uncharge_folio(idx, nr_pages, folio, true);
 }
 
 static void __hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
@@ -888,13 +889,14 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	struct hugetlb_cgroup *h_cg;
 	struct hugetlb_cgroup *h_cg_rsvd;
 	struct hstate *h = page_hstate(oldhpage);
+	struct folio *old_folio = page_folio(oldhpage);
 
 	if (hugetlb_cgroup_disabled())
 		return;
 
 	spin_lock_irq(&hugetlb_lock);
-	h_cg = hugetlb_cgroup_from_page(oldhpage);
-	h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
+	h_cg = hugetlb_cgroup_from_folio(old_folio);
+	h_cg_rsvd = hugetlb_cgroup_from_folio_rsvd(old_folio);
 	set_hugetlb_cgroup(oldhpage, NULL);
 	set_hugetlb_cgroup_rsvd(oldhpage, NULL);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index c5968021fde0..0252aa4ff572 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1632,7 +1632,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		nid = folio_nid(folio);
 
 	if (folio_test_hugetlb(folio)) {
-		struct hstate *h = page_hstate(&folio->page);
+		struct hstate *h = folio_hstate(folio);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
 		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
diff --git a/mm/readahead.c b/mm/readahead.c
index e4b772bb70e6..794d8ddc0697 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -504,6 +504,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	pgoff_t index = readahead_index(ractl);
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
+	unsigned int nofs;
 	int err = 0;
 	gfp_t gfp = readahead_gfp_mask(mapping);
 
@@ -520,6 +521,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
 			new_order--;
 	}
 
+	/* See comment in page_cache_ra_unbounded() */
+	nofs = memalloc_nofs_save();
 	filemap_invalidate_lock_shared(mapping);
 	while (index <= limit) {
 		unsigned int order = new_order;
@@ -548,6 +551,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	read_pages(ractl);
 	filemap_invalidate_unlock_shared(mapping);
+	memalloc_nofs_restore(nofs);
 
 	/*
 	 * If there were already pages in the page cache, then we may have
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 02e67ff05b7b..d6be3cb86598 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2733,8 +2733,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_unregister_suspend_notifier(hdev);
 
-	msft_unregister(hdev);
-
 	hci_dev_do_close(hdev);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
@@ -2788,6 +2786,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_discovery_filter_clear(hdev);
 	hci_blocked_keys_clear(hdev);
 	hci_codec_list_clear(&hdev->local_codecs);
+	msft_release(hdev);
 	hci_dev_unlock(hdev);
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b4cba55be5ad..c34011113d4c 100644
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
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index bee6a4c656be..076cf8bce4d9 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -584,7 +584,7 @@ void msft_register(struct hci_dev *hdev)
 	hdev->msft_data = msft;
 }
 
-void msft_unregister(struct hci_dev *hdev)
+void msft_release(struct hci_dev *hdev)
 {
 	struct msft_data *msft = hdev->msft_data;
 
diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index 2a63205b377b..fe538e9c91c0 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -14,7 +14,7 @@
 
 bool msft_monitor_supported(struct hci_dev *hdev);
 void msft_register(struct hci_dev *hdev);
-void msft_unregister(struct hci_dev *hdev);
+void msft_release(struct hci_dev *hdev);
 void msft_do_open(struct hci_dev *hdev);
 void msft_do_close(struct hci_dev *hdev);
 void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb);
@@ -35,7 +35,7 @@ static inline bool msft_monitor_supported(struct hci_dev *hdev)
 }
 
 static inline void msft_register(struct hci_dev *hdev) {}
-static inline void msft_unregister(struct hci_dev *hdev) {}
+static inline void msft_release(struct hci_dev *hdev) {}
 static inline void msft_do_open(struct hci_dev *hdev) {}
 static inline void msft_do_close(struct hci_dev *hdev) {}
 static inline void msft_vendor_evt(struct hci_dev *hdev, void *data,
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 4a6bf60f3e7a..301cf802d32c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -84,6 +84,10 @@ static void sco_sock_timeout(struct work_struct *work)
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
index 4e3394a7d7d4..9661698e86e4 100644
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
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index d38eff27767d..e9e5c77ef0f4 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -439,7 +439,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			  u32 filter_mask, const struct net_device *dev,
 			  bool getlink)
 {
-	u8 operstate = netif_running(dev) ? dev->operstate : IF_OPER_DOWN;
+	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
+					    IF_OPER_DOWN;
 	struct nlattr *af = NULL;
 	struct net_bridge *br;
 	struct ifinfomsg *hdr;
diff --git a/net/core/filter.c b/net/core/filter.c
index cb7c4651eaec..1d8b271ef8cc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4244,10 +4244,12 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
+	u32 flags = ri->flags;
 	struct bpf_map *map;
 	int err;
 
 	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
+	ri->flags = 0;
 	ri->map_type = BPF_MAP_TYPE_UNSPEC;
 
 	if (unlikely(!xdpf)) {
@@ -4259,11 +4261,20 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
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
 			err = dev_map_enqueue_multi(xdpf, dev, map,
-						    ri->flags & BPF_F_EXCLUDE_INGRESS);
+						    flags & BPF_F_EXCLUDE_INGRESS);
 		} else {
 			err = dev_map_enqueue(fwd, xdpf, dev);
 		}
@@ -4334,9 +4345,9 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
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
@@ -4346,11 +4357,20 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
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
@@ -4387,9 +4407,11 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
+	u32 flags = ri->flags;
 	int err;
 
 	ri->map_id = 0; /* Valid map id idr range: [1,INT_MAX[ */
+	ri->flags = 0;
 	ri->map_type = BPF_MAP_TYPE_UNSPEC;
 
 	if (map_type == BPF_MAP_TYPE_UNSPEC && map_id == INT_MAX) {
@@ -4409,7 +4431,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 		return 0;
 	}
 
-	return xdp_do_generic_redirect_map(dev, skb, xdp, xdp_prog, fwd, map_type, map_id);
+	return xdp_do_generic_redirect_map(dev, skb, xdp, xdp_prog, fwd, map_type, map_id, flags);
 err:
 	_trace_xdp_redirect_err(dev, xdp_prog, ri->tgt_index, err);
 	return err;
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index aa6cb1f90966..13513efcfbfe 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -53,7 +53,7 @@ static void rfc2863_policy(struct net_device *dev)
 {
 	unsigned char operstate = default_operstate(dev);
 
-	if (operstate == dev->operstate)
+	if (operstate == READ_ONCE(dev->operstate))
 		return;
 
 	write_lock(&dev_base_lock);
@@ -73,7 +73,7 @@ static void rfc2863_policy(struct net_device *dev)
 		break;
 	}
 
-	dev->operstate = operstate;
+	WRITE_ONCE(dev->operstate, operstate);
 
 	write_unlock(&dev_base_lock);
 }
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 8409d41405df..fdf3308b0335 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -306,11 +306,9 @@ static ssize_t operstate_show(struct device *dev,
 	const struct net_device *netdev = to_net_dev(dev);
 	unsigned char operstate;
 
-	read_lock(&dev_base_lock);
-	operstate = netdev->operstate;
+	operstate = READ_ONCE(netdev->operstate);
 	if (!netif_running(netdev))
 		operstate = IF_OPER_DOWN;
-	read_unlock(&dev_base_lock);
 
 	if (operstate >= ARRAY_SIZE(operstates))
 		return -EINVAL; /* should not happen */
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 4c1707d0eb9b..c33930a17162 100644
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
@@ -1217,7 +1220,11 @@ static int register_pernet_operations(struct list_head *list,
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
index ac379e4590f8..1163226c025c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -876,9 +876,9 @@ static void set_operstate(struct net_device *dev, unsigned char transition)
 		break;
 	}
 
-	if (dev->operstate != operstate) {
+	if (READ_ONCE(dev->operstate) != operstate) {
 		write_lock(&dev_base_lock);
-		dev->operstate = operstate;
+		WRITE_ONCE(dev->operstate, operstate);
 		write_unlock(&dev_base_lock);
 		netdev_state_change(dev);
 	}
@@ -2443,7 +2443,7 @@ static int do_setvfinfo(struct net_device *dev, struct nlattr **tb)
 
 		nla_for_each_nested(attr, tb[IFLA_VF_VLAN_LIST], rem) {
 			if (nla_type(attr) != IFLA_VF_VLAN_INFO ||
-			    nla_len(attr) < NLA_HDRLEN) {
+			    nla_len(attr) < sizeof(struct ifla_vf_vlan_info)) {
 				return -EINVAL;
 			}
 			if (len >= MAX_VLAN_LIST_LEN)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e38a4c7449f6..4d46788cd493 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1720,11 +1720,17 @@ static inline int skb_alloc_rx_flag(const struct sk_buff *skb)
 
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
 
@@ -2037,12 +2043,17 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
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
index 39643f78cf78..8b0459a6b629 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1217,11 +1217,8 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 		rcu_read_lock();
 		psock = sk_psock(sk);
-		if (psock) {
-			read_lock_bh(&sk->sk_callback_lock);
+		if (psock)
 			sk_psock_data_ready(sk, psock);
-			read_unlock_bh(&sk->sk_callback_lock);
-		}
 		rcu_read_unlock();
 	}
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 550af616f535..48199e6e8f16 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -482,7 +482,7 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned long flags;
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf) {
+	if (atomic_read(&sk->sk_rmem_alloc) >= READ_ONCE(sk->sk_rcvbuf)) {
 		atomic_inc(&sk->sk_drops);
 		trace_sock_rcvqueue_full(sk, skb);
 		return -ENOMEM;
@@ -552,7 +552,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 83906d093f0a..ad75724b69ad 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -31,8 +31,8 @@ static bool is_slave_up(struct net_device *dev)
 static void __hsr_set_operstate(struct net_device *dev, int transition)
 {
 	write_lock(&dev_base_lock);
-	if (dev->operstate != transition) {
-		dev->operstate = transition;
+	if (READ_ONCE(dev->operstate) != transition) {
+		WRITE_ONCE(dev->operstate, transition);
 		write_unlock(&dev_base_lock);
 		netdev_state_change(dev);
 	} else {
@@ -71,39 +71,36 @@ static bool hsr_check_carrier(struct hsr_port *master)
 	return false;
 }
 
-static void hsr_check_announce(struct net_device *hsr_dev,
-			       unsigned char old_operstate)
+static void hsr_check_announce(struct net_device *hsr_dev)
 {
 	struct hsr_priv *hsr;
 
 	hsr = netdev_priv(hsr_dev);
-
-	if (hsr_dev->operstate == IF_OPER_UP && old_operstate != IF_OPER_UP) {
-		/* Went up */
-		hsr->announce_count = 0;
-		mod_timer(&hsr->announce_timer,
-			  jiffies + msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
+	if (netif_running(hsr_dev) && netif_oper_up(hsr_dev)) {
+		/* Enable announce timer and start sending supervisory frames */
+		if (!timer_pending(&hsr->announce_timer)) {
+			hsr->announce_count = 0;
+			mod_timer(&hsr->announce_timer, jiffies +
+				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
+		}
+	} else {
+		/* Deactivate the announce timer  */
+		timer_delete(&hsr->announce_timer);
 	}
-
-	if (hsr_dev->operstate != IF_OPER_UP && old_operstate == IF_OPER_UP)
-		/* Went down */
-		del_timer(&hsr->announce_timer);
 }
 
 void hsr_check_carrier_and_operstate(struct hsr_priv *hsr)
 {
 	struct hsr_port *master;
-	unsigned char old_operstate;
 	bool has_carrier;
 
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	/* netif_stacked_transfer_operstate() cannot be used here since
 	 * it doesn't set IF_OPER_LOWERLAYERDOWN (?)
 	 */
-	old_operstate = master->dev->operstate;
 	has_carrier = hsr_check_carrier(master);
 	hsr_set_operstate(master, has_carrier);
-	hsr_check_announce(master->dev, old_operstate);
+	hsr_check_announce(master->dev);
 }
 
 int hsr_get_max_mtu(struct hsr_priv *hsr)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f01c0a5d2c37..3447a09ee83a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2831,7 +2831,7 @@ void tcp_shutdown(struct sock *sk, int how)
 	/* If we've already sent a FIN, or it's a closed state, skip this. */
 	if ((1 << sk->sk_state) &
 	    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
-	     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) {
+	     TCPF_CLOSE_WAIT)) {
 		/* Clear out any half completed packets.  FIN if needed. */
 		if (tcp_close_state(sk))
 			tcp_send_fin(sk);
@@ -2940,7 +2940,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		 * machine. State transitions:
 		 *
 		 * TCP_ESTABLISHED -> TCP_FIN_WAIT1
-		 * TCP_SYN_RECV	-> TCP_FIN_WAIT1 (forget it, it's impossible)
+		 * TCP_SYN_RECV	-> TCP_FIN_WAIT1 (it is difficult)
 		 * TCP_CLOSE_WAIT -> TCP_LAST_ACK
 		 *
 		 * are legal only when FIN has been sent (i.e. in window),
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 34460c9b37ae..4c9da9455336 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6597,6 +6597,8 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 		tcp_initialize_rcv_mss(sk);
 		tcp_fast_path_on(tp);
+		if (sk->sk_shutdown & SEND_SHUTDOWN)
+			tcp_shutdown(sk, SEND_SHUTDOWN);
 		break;
 
 	case TCP_FIN_WAIT1: {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index be2c807eed15..5dcb969cb5e9 100644
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
index 67087da45a1f..15f814c1e169 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3480,7 +3480,9 @@ void tcp_send_fin(struct sock *sk)
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
index 84b7d6089f76..794ea24292f6 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -463,6 +463,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 	struct sk_buff *p;
 	unsigned int ulen;
 	int ret = 0;
+	int flush;
 
 	/* requires non zero csum, for symmetry with GSO */
 	if (!uh->check) {
@@ -496,13 +497,22 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
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
index 183f6dc37242..f6e90ba50b63 100644
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
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3866deaadbb6..22e246ff910e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4133,7 +4133,7 @@ static void addrconf_dad_work(struct work_struct *w)
 			if (!ipv6_generate_eui64(addr.s6_addr + 8, idev->dev) &&
 			    ipv6_addr_equal(&ifp->addr, &addr)) {
 				/* DAD failed for link-local based on MAC */
-				idev->cnf.disable_ipv6 = 1;
+				WRITE_ONCE(idev->cnf.disable_ipv6, 1);
 
 				pr_info("%s: IPv6 being disabled!\n",
 					ifp->idev->dev->name);
@@ -5979,7 +5979,7 @@ static int inet6_fill_ifinfo(struct sk_buff *skb, struct inet6_dev *idev,
 	    (dev->ifindex != dev_get_iflink(dev) &&
 	     nla_put_u32(skb, IFLA_LINK, dev_get_iflink(dev))) ||
 	    nla_put_u8(skb, IFLA_OPERSTATE,
-		       netif_running(dev) ? dev->operstate : IF_OPER_DOWN))
+		       netif_running(dev) ? READ_ONCE(dev->operstate) : IF_OPER_DOWN))
 		goto nla_put_failure;
 	protoinfo = nla_nest_start_noflag(skb, IFLA_PROTINFO);
 	if (!protoinfo)
@@ -6289,7 +6289,8 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 		idev = __in6_dev_get(dev);
 		if (idev) {
 			int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
-			idev->cnf.disable_ipv6 = newf;
+
+			WRITE_ONCE(idev->cnf.disable_ipv6, newf);
 			if (changed)
 				dev_disable_change(idev);
 		}
@@ -6306,7 +6307,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 
 	net = (struct net *)table->extra2;
 	old = *p;
-	*p = newf;
+	WRITE_ONCE(*p, newf);
 
 	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
 		rtnl_unlock();
@@ -6314,7 +6315,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 	}
 
 	if (p == &net->ipv6.devconf_all->disable_ipv6) {
-		net->ipv6.devconf_dflt->disable_ipv6 = newf;
+		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
 		addrconf_disable_change(net, newf);
 	} else if ((!newf) ^ (!old))
 		dev_disable_change((struct inet6_dev *)table->extra1);
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index be52b18e08a6..6eeab21512ba 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -233,8 +233,12 @@ static int __fib6_rule_action(struct fib_rule *rule, struct flowi *flp,
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
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index b8378814532c..1ba97933c74f 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -168,9 +168,9 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 
 	SKB_DR_SET(reason, NOT_SPECIFIED);
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL ||
-	    !idev || unlikely(idev->cnf.disable_ipv6)) {
+	    !idev || unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INDISCARDS);
-		if (idev && unlikely(idev->cnf.disable_ipv6))
+		if (idev && unlikely(READ_ONCE(idev->cnf.disable_ipv6)))
 			SKB_DR_SET(reason, IPV6DISABLED);
 		goto drop;
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index e9ae084d038d..fb26401950e7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -224,7 +224,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(idev->cnf.disable_ipv6)) {
+	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
 		return 0;
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 4156387248e4..8432b50d9ce4 100644
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
index f2ae03c40473..1f41d2f3b8c4 100644
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
index d5dd2d9e89b4..3e14d5c9aa1b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -120,7 +120,7 @@ struct ieee80211_bss {
 };
 
 /**
- * enum ieee80211_corrupt_data_flags - BSS data corruption flags
+ * enum ieee80211_bss_corrupt_data_flags - BSS data corruption flags
  * @IEEE80211_BSS_CORRUPT_BEACON: last beacon frame received was corrupted
  * @IEEE80211_BSS_CORRUPT_PROBE_RESP: last probe response received was corrupted
  *
@@ -133,7 +133,7 @@ enum ieee80211_bss_corrupt_data_flags {
 };
 
 /**
- * enum ieee80211_valid_data_flags - BSS valid data flags
+ * enum ieee80211_bss_valid_data_flags - BSS valid data flags
  * @IEEE80211_BSS_VALID_WMM: WMM/UAPSD data was gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_RATES: Supported rates were gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_ERP: ERP flag was gathered from non-corrupt IE
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c652c8ca765c..b6815610a6fa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3754,6 +3754,9 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
 	}
+
+	WRITE_ONCE(msk->write_seq, subflow->idsn);
+	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 
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
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index ace861173532..6de53431629c 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -209,13 +209,18 @@ int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
 	if (IS_ERR(rt))
 		goto out;
 	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
-		goto out;
-	neigh = rt->dst.ops->neigh_lookup(&rt->dst, NULL, &fl4.daddr);
-	if (neigh) {
-		memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
-		*uses_gateway = rt->rt_uses_gateway;
-		return 0;
-	}
+		goto out_rt;
+	neigh = dst_neigh_lookup(&rt->dst, &fl4.daddr);
+	if (!neigh)
+		goto out_rt;
+	memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
+	*uses_gateway = rt->rt_uses_gateway;
+	neigh_release(neigh);
+	ip_rt_put(rt);
+	return 0;
+
+out_rt:
+	ip_rt_put(rt);
 out:
 	return -ENOENT;
 }
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 61e5c77462e9..b774028e4aa8 100644
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
@@ -1044,6 +1046,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 		.version	= vers,
 		.authflavor	= old->cl_auth->au_flavor,
 		.cred		= old->cl_cred,
+		.stats		= old->cl_stats,
 	};
 	struct rpc_clnt *clnt;
 	int err;
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 656cec208371..ab453ede54f0 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1164,7 +1164,7 @@ xprt_request_enqueue_receive(struct rpc_task *task)
 	spin_unlock(&xprt->queue_lock);
 
 	/* Turn off autodisconnect */
-	del_singleshot_timer_sync(&xprt->timer);
+	del_timer_sync(&xprt->timer);
 	return 0;
 }
 
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
index 1a3bd554e258..a00df7b89ca8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13802,6 +13802,8 @@ static int nl80211_set_coalesce(struct sk_buff *skb, struct genl_info *info)
 error:
 	for (i = 0; i < new_coalesce.n_rules; i++) {
 		tmp_rule = &new_coalesce.rules[i];
+		if (!tmp_rule)
+			continue;
 		for (j = 0; j < tmp_rule->n_patterns; j++)
 			kfree(tmp_rule->patterns[j].mask);
 		kfree(tmp_rule->patterns);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a405c3edbc47..cb5c3224e038 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1018,7 +1018,7 @@ TRACE_EVENT(rdev_get_mpp,
 TRACE_EVENT(rdev_dump_mpp,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int _idx,
 		 u8 *dst, u8 *mpp),
-	TP_ARGS(wiphy, netdev, _idx, mpp, dst),
+	TP_ARGS(wiphy, netdev, _idx, dst, mpp),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index d0320e35accb..4bba890ff3bc 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -388,11 +388,15 @@ static int xfrm_prepare_input(struct xfrm_state *x, struct sk_buff *skb)
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
@@ -403,11 +407,15 @@ static int xfrm4_transport_input(struct xfrm_state *x, struct sk_buff *skb)
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
diff --git a/rust/Makefile b/rust/Makefile
index 7700d3853404..6d0c0e9757f2 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -322,10 +322,9 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
       cmd_rustc_procmacro = \
 	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
-		--emit=dep-info,link --extern proc_macro \
-		--crate-type proc-macro --out-dir $(objtree)/$(obj) \
+		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
+		--crate-type proc-macro \
 		--crate-name $(patsubst lib%.so,%,$(notdir $@)) $<; \
-	mv $(objtree)/$(obj)/$(patsubst lib%.so,%,$(notdir $@)).d $(depfile); \
 	sed -i '/^\#/d' $(depfile)
 
 # Procedural macros can only be used with the `rustc` that compiled it.
@@ -339,10 +338,10 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 	OBJTREE=$(abspath $(objtree)) \
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
 		$(filter-out $(skip_flags),$(rust_flags) $(rustc_target_flags)) \
-		--emit=dep-info,obj,metadata --crate-type rlib \
-		--out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \
+		--emit=dep-info=$(depfile) --emit=obj=$@ \
+		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
+		--crate-type rlib -L$(objtree)/$(obj) \
 		--crate-name $(patsubst %.o,%,$(notdir $@)) $<; \
-	mv $(objtree)/$(obj)/$(patsubst %.o,%,$(notdir $@)).d $(depfile); \
 	sed -i '/^\#/d' $(depfile) \
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
 
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 466b2a8fe569..4a3a6306cfe1 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -25,7 +25,7 @@ pub struct Error(core::ffi::c_int);
 
 impl Error {
     /// Returns the kernel error code.
-    pub fn to_kernel_errno(self) -> core::ffi::c_int {
+    pub fn to_errno(self) -> core::ffi::c_int {
         self.0
     }
 }
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index abd46261d385..43cf5f6bde9c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -37,7 +37,7 @@ const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
 /// The top level entrypoint to implementing a kernel module.
 ///
 /// For any teardown or cleanup operations, your type may implement [`Drop`].
-pub trait Module: Sized + Sync {
+pub trait Module: Sized + Sync + Send {
     /// Called at module initialization time.
     ///
     /// Use this method to perform whatever setup or registration your module
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 186a5b8be23c..031028b3dc41 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -179,17 +179,6 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             /// Used by the printing macros, e.g. [`info!`].
             const __LOG_PREFIX: &[u8] = b\"{name}\\0\";
 
-            /// The \"Rust loadable module\" mark, for `scripts/is_rust_module.sh`.
-            //
-            // This may be best done another way later on, e.g. as a new modinfo
-            // key or a new section. For the moment, keep it simple.
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[used]
-            static __IS_RUST_MODULE: () = ();
-
-            static mut __MOD: Option<{type_}> = None;
-
             // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
             // freed until the module is unloaded.
             #[cfg(MODULE)]
@@ -201,76 +190,132 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
                 kernel::ThisModule::from_ptr(core::ptr::null_mut())
             }};
 
-            // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn init_module() -> core::ffi::c_int {{
-                __init()
-            }}
-
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn cleanup_module() {{
-                __exit()
-            }}
+            // Double nested modules, since then nobody can access the public items inside.
+            mod __module_init {{
+                mod __module_init {{
+                    use super::super::{type_};
+
+                    /// The \"Rust loadable module\" mark.
+                    //
+                    // This may be best done another way later on, e.g. as a new modinfo
+                    // key or a new section. For the moment, keep it simple.
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[used]
+                    static __IS_RUST_MODULE: () = ();
+
+                    static mut __MOD: Option<{type_}> = None;
+
+                    // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
+                    /// # Safety
+                    ///
+                    /// This function must not be called after module initialization, because it may be
+                    /// freed after that completes.
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    #[link_section = \".init.text\"]
+                    pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {{
+                        // SAFETY: This function is inaccessible to the outside due to the double
+                        // module wrapping it. It is called exactly once by the C side via its
+                        // unique name.
+                        unsafe {{ __init() }}
+                    }}
 
-            // Built-in modules are initialized through an initcall pointer
-            // and the identifiers need to be unique.
-            #[cfg(not(MODULE))]
-            #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
-            #[doc(hidden)]
-            #[link_section = \"{initcall_section}\"]
-            #[used]
-            pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn cleanup_module() {{
+                        // SAFETY:
+                        // - This function is inaccessible to the outside due to the double
+                        //   module wrapping it. It is called exactly once by the C side via its
+                        //   unique name,
+                        // - furthermore it is only called after `init_module` has returned `0`
+                        //   (which delegates to `__init`).
+                        unsafe {{ __exit() }}
+                    }}
 
-            #[cfg(not(MODULE))]
-            #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
-            core::arch::global_asm!(
-                r#\".section \"{initcall_section}\", \"a\"
-                __{name}_initcall:
-                    .long   __{name}_init - .
-                    .previous
-                \"#
-            );
+                    // Built-in modules are initialized through an initcall pointer
+                    // and the identifiers need to be unique.
+                    #[cfg(not(MODULE))]
+                    #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
+                    #[doc(hidden)]
+                    #[link_section = \"{initcall_section}\"]
+                    #[used]
+                    pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
+
+                    #[cfg(not(MODULE))]
+                    #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
+                    core::arch::global_asm!(
+                        r#\".section \"{initcall_section}\", \"a\"
+                        __{name}_initcall:
+                            .long   __{name}_init - .
+                            .previous
+                        \"#
+                    );
+
+                    #[cfg(not(MODULE))]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
+                        // SAFETY: This function is inaccessible to the outside due to the double
+                        // module wrapping it. It is called exactly once by the C side via its
+                        // placement above in the initcall section.
+                        unsafe {{ __init() }}
+                    }}
 
-            #[cfg(not(MODULE))]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
-                __init()
-            }}
+                    #[cfg(not(MODULE))]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn __{name}_exit() {{
+                        // SAFETY:
+                        // - This function is inaccessible to the outside due to the double
+                        //   module wrapping it. It is called exactly once by the C side via its
+                        //   unique name,
+                        // - furthermore it is only called after `__{name}_init` has returned `0`
+                        //   (which delegates to `__init`).
+                        unsafe {{ __exit() }}
+                    }}
 
-            #[cfg(not(MODULE))]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn __{name}_exit() {{
-                __exit()
-            }}
+                    /// # Safety
+                    ///
+                    /// This function must only be called once.
+                    unsafe fn __init() -> core::ffi::c_int {{
+                        match <{type_} as kernel::Module>::init(&super::super::THIS_MODULE) {{
+                            Ok(m) => {{
+                                // SAFETY: No data race, since `__MOD` can only be accessed by this
+                                // module and there only `__init` and `__exit` access it. These
+                                // functions are only called once and `__exit` cannot be called
+                                // before or during `__init`.
+                                unsafe {{
+                                    __MOD = Some(m);
+                                }}
+                                return 0;
+                            }}
+                            Err(e) => {{
+                                return e.to_errno();
+                            }}
+                        }}
+                    }}
 
-            fn __init() -> core::ffi::c_int {{
-                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
-                    Ok(m) => {{
+                    /// # Safety
+                    ///
+                    /// This function must
+                    /// - only be called once,
+                    /// - be called after `__init` has been called and returned `0`.
+                    unsafe fn __exit() {{
+                        // SAFETY: No data race, since `__MOD` can only be accessed by this module
+                        // and there only `__init` and `__exit` access it. These functions are only
+                        // called once and `__init` was already called.
                         unsafe {{
-                            __MOD = Some(m);
+                            // Invokes `drop()` on `__MOD`, which should be used for cleanup.
+                            __MOD = None;
                         }}
-                        return 0;
-                    }}
-                    Err(e) => {{
-                        return e.to_kernel_errno();
                     }}
-                }}
-            }}
 
-            fn __exit() {{
-                unsafe {{
-                    // Invokes `drop()` on `__MOD`, which should be used for cleanup.
-                    __MOD = None;
+                    {modinfo}
                 }}
             }}
-
-            {modinfo}
         ",
         type_ = info.type_,
         name = info.name,
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 41f3602fc8de..1827bc1db1e9 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -277,17 +277,20 @@ $(obj)/%.lst: $(src)/%.c FORCE
 
 rust_allowed_features := core_ffi_c
 
+# `--out-dir` is required to avoid temporaries being created by `rustc` in the
+# current working directory, which may be not accessible in the out-of-tree
+# modules case.
 rust_common_cmd = \
 	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
 	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
 	--extern alloc --extern kernel \
-	--crate-type rlib --out-dir $(obj) -L $(objtree)/rust/ \
-	--crate-name $(basename $(notdir $@))
+	--crate-type rlib -L $(objtree)/rust/ \
+	--crate-name $(basename $(notdir $@)) \
+	--out-dir $(dir $@) --emit=dep-info=$(depfile)
 
 rust_handle_depfile = \
-	mv $(obj)/$(basename $(notdir $@)).d $(depfile); \
 	sed -i '/^\#/d' $(depfile)
 
 # `--emit=obj`, `--emit=asm` and `--emit=llvm-ir` imply a single codegen unit
@@ -300,7 +303,7 @@ rust_handle_depfile = \
 
 quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_o_rs = \
-	$(rust_common_cmd) --emit=dep-info,obj $<; \
+	$(rust_common_cmd) --emit=obj=$@ $<; \
 	$(rust_handle_depfile)
 
 $(obj)/%.o: $(src)/%.rs FORCE
@@ -308,7 +311,7 @@ $(obj)/%.o: $(src)/%.rs FORCE
 
 quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_rsi_rs = \
-	$(rust_common_cmd) --emit=dep-info -Zunpretty=expanded $< >$@; \
+	$(rust_common_cmd) -Zunpretty=expanded $< >$@; \
 	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@; \
 	$(rust_handle_depfile)
 
@@ -317,7 +320,7 @@ $(obj)/%.rsi: $(src)/%.rs FORCE
 
 quiet_cmd_rustc_s_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_s_rs = \
-	$(rust_common_cmd) --emit=dep-info,asm $<; \
+	$(rust_common_cmd) --emit=asm=$@ $<; \
 	$(rust_handle_depfile)
 
 $(obj)/%.s: $(src)/%.rs FORCE
@@ -325,7 +328,7 @@ $(obj)/%.s: $(src)/%.rs FORCE
 
 quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_ll_rs = \
-	$(rust_common_cmd) --emit=dep-info,llvm-ir $<; \
+	$(rust_common_cmd) --emit=llvm-ir=$@ $<; \
 	$(rust_handle_depfile)
 
 $(obj)/%.ll: $(src)/%.rs FORCE
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index da133780b751..a447c91893de 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -80,25 +80,28 @@ host-rust	:= $(addprefix $(obj)/,$(host-rust))
 #####
 # Handle options to gcc. Support building with separate output directory
 
-_hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
+hostc_flags    = -Wp,-MMD,$(depfile) \
+                 $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
                  $(HOSTCFLAGS_$(target-stem).o)
-_hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
+hostcxx_flags  = -Wp,-MMD,$(depfile) \
+                 $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                  $(HOSTCXXFLAGS_$(target-stem).o)
-_hostrust_flags = $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
-                  $(HOSTRUSTFLAGS_$(target-stem))
+
+# `--out-dir` is required to avoid temporaries being created by `rustc` in the
+# current working directory, which may be not accessible in the out-of-tree
+# modules case.
+hostrust_flags = --out-dir $(dir $@) --emit=dep-info=$(depfile) \
+                 $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
+                 $(HOSTRUSTFLAGS_$(target-stem))
 
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
 ifdef building_out_of_srctree
-_hostc_flags   += -I $(objtree)/$(obj)
-_hostcxx_flags += -I $(objtree)/$(obj)
+hostc_flags   += -I $(objtree)/$(obj)
+hostcxx_flags += -I $(objtree)/$(obj)
 endif
 endif
 
-hostc_flags    = -Wp,-MMD,$(depfile) $(_hostc_flags)
-hostcxx_flags  = -Wp,-MMD,$(depfile) $(_hostcxx_flags)
-hostrust_flags = $(_hostrust_flags)
-
 #####
 # Compile programs on the host
 
@@ -149,9 +152,7 @@ $(host-cxxobjs): $(obj)/%.o: $(src)/%.cc FORCE
 # host-rust -> Executable
 quiet_cmd_host-rust	= HOSTRUSTC $@
       cmd_host-rust	= \
-	$(HOSTRUSTC) $(hostrust_flags) --emit=dep-info,link \
-		--out-dir=$(obj)/ $<; \
-	mv $(obj)/$(target-stem).d $(depfile); \
+	$(HOSTRUSTC) $(hostrust_flags) --emit=link=$@ $<; \
 	sed -i '/^\#/d' $(depfile)
 $(host-rust): $(obj)/%: $(src)/%.rs FORCE
 	$(call if_changed_dep,host-rust)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 3af5e5807983..0faee3a47705 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -23,7 +23,7 @@ modname = $(notdir $(@:.mod.o=))
 part-of-module = y
 
 quiet_cmd_cc_o_c = CC [M]  $@
-      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV), $(c_flags)) -c -o $@ $<
+      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV) $(CFLAGS_KCSAN), $(c_flags)) -c -o $@ $<
 
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
@@ -41,8 +41,6 @@ quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
 	if [ ! -f vmlinux ]; then					\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
-	elif [ -n "$(CONFIG_RUST)" ] && $(srctree)/scripts/is_rust_module.sh $@; then 		\
-		printf "Skipping BTF generation for %s because it's a Rust module\n" $@ 1>&2; \
 	else								\
 		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
 		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
diff --git a/scripts/is_rust_module.sh b/scripts/is_rust_module.sh
deleted file mode 100755
index 28b3831a7593..000000000000
--- a/scripts/is_rust_module.sh
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# is_rust_module.sh module.ko
-#
-# Returns `0` if `module.ko` is a Rust module, `1` otherwise.
-
-set -e
-
-# Using the `16_` prefix ensures other symbols with the same substring
-# are not picked up (even if it would be unlikely). The last part is
-# used just in case LLVM decides to use the `.` suffix.
-#
-# In the future, checking for the `.comment` section may be another
-# option, see https://github.com/rust-lang/rust/pull/97550.
-${NM} "$*" | grep -qE '^[0-9a-fA-F]+ r _R[^[:space:]]+16___IS_RUST_MODULE[^[:space:]]*$'
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
index b57d72ea4503..4e376994bf78 100644
--- a/sound/hda/intel-sdw-acpi.c
+++ b/sound/hda/intel-sdw-acpi.c
@@ -41,6 +41,8 @@ static bool is_link_enabled(struct fwnode_handle *fw_node, u8 idx)
 				 "intel-quirk-mask",
 				 &quirk_mask);
 
+	fwnode_handle_put(link);
+
 	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
 		return false;
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 77c40063d63a..f0b939862a2a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9660,6 +9660,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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
index 61f9d417fd60..f0a9e181ee72 100644
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
index 028383f949ef..272c3d2d68cb 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -351,26 +351,31 @@ static int axg_tdm_iface_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int axg_tdm_iface_hw_free(struct snd_pcm_substream *substream,
+static int axg_tdm_iface_trigger(struct snd_pcm_substream *substream,
+				 int cmd,
 				 struct snd_soc_dai *dai)
 {
-	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
+	struct axg_tdm_stream *ts =
+		snd_soc_dai_get_dma_data(dai, substream);
 
-	/* Stop all attached formatters */
-	axg_tdm_stream_stop(ts);
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
 
 	return 0;
 }
 
-static int axg_tdm_iface_prepare(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
-
-	/* Force all attached formatters to update */
-	return axg_tdm_stream_reset(ts);
-}
-
 static int axg_tdm_iface_remove_dai(struct snd_soc_dai *dai)
 {
 	if (dai->capture_dma_data)
@@ -408,8 +413,7 @@ static const struct snd_soc_dai_ops axg_tdm_iface_ops = {
 	.set_fmt	= axg_tdm_iface_set_fmt,
 	.startup	= axg_tdm_iface_startup,
 	.hw_params	= axg_tdm_iface_hw_params,
-	.prepare	= axg_tdm_iface_prepare,
-	.hw_free	= axg_tdm_iface_hw_free,
+	.trigger	= axg_tdm_iface_trigger,
 };
 
 /* TDM Backend DAIs */
diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index e9208e74e965..f875304463e2 100644
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
index ca5d1bb6ac59..4edf5b27e136 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2416,12 +2416,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
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
@@ -2448,6 +2442,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
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
 
diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 4b0673bf52c2..07cfad817d53 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -8,6 +8,7 @@
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/math.h>
+#include <linux/panic.h>
 #include <endian.h>
 #include <byteswap.h>
 
diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index 43be27bcc897..2f401e8c6c0b 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -37,4 +37,9 @@ static inline void totalram_pages_add(long count)
 {
 }
 
+static inline int early_pfn_to_nid(unsigned long pfn)
+{
+	return 0;
+}
+
 #endif
diff --git a/tools/include/linux/panic.h b/tools/include/linux/panic.h
new file mode 100644
index 000000000000..9c8f17a41ce8
--- /dev/null
+++ b/tools/include/linux/panic.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_PANIC_H
+#define _TOOLS_LINUX_PANIC_H
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static inline void panic(const char *fmt, ...)
+{
+	va_list argp;
+
+	va_start(argp, fmt);
+	vfprintf(stderr, fmt, argp);
+	va_end(argp);
+	exit(-1);
+}
+
+#endif
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 94aa40f6e348..9a7bdc0e14cc 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -45,6 +45,7 @@ static int __report_module(struct addr_location *al, u64 ip,
 {
 	Dwfl_Module *mod;
 	struct dso *dso = NULL;
+	Dwarf_Addr base;
 	/*
 	 * Some callers will use al->sym, so we can't just use the
 	 * cheaper thread__find_map() here.
@@ -57,24 +58,36 @@ static int __report_module(struct addr_location *al, u64 ip,
 	if (!dso)
 		return 0;
 
+	/*
+	 * The generated JIT DSO files only map the code segment without
+	 * ELF headers.  Since JIT codes used to be packed in a memory
+	 * segment, calculating the base address using pgoff falls info
+	 * a different code in another DSO.  So just use the map->start
+	 * directly to pick the correct one.
+	 */
+	if (!strncmp(dso->long_name, "/tmp/jitted-", 12))
+		base = al->map->start;
+	else
+		base = al->map->start - al->map->pgoff;
+
 	mod = dwfl_addrmodule(ui->dwfl, ip);
 	if (mod) {
 		Dwarf_Addr s;
 
 		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
-		if (s != al->map->start - al->map->pgoff)
-			mod = 0;
+		if (s != base)
+			mod = NULL;
 	}
 
 	if (!mod)
 		mod = dwfl_report_elf(ui->dwfl, dso->short_name, dso->long_name, -1,
-				      al->map->start - al->map->pgoff, false);
+				      base, false);
 	if (!mod) {
 		char filename[PATH_MAX];
 
 		if (dso__build_id_filename(dso, filename, sizeof(filename), false))
 			mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
-					      al->map->start - al->map->pgoff, false);
+					      base, false);
 	}
 
 	if (mod) {
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 81b6bd6e1536..b276e36e3fb4 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -327,7 +327,7 @@ static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 
 	maps__for_each_entry(ui->thread->maps, map) {
 		if (map->dso == dso && map->start < base_addr)
-			base_addr = map->start;
+			base_addr = map->start - map->pgoff;
 	}
 	base_addr -= dso->data.elf_base_addr;
 	/* Address of .eh_frame_hdr */
diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 3e1a4c4be001..7112d4732d28 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -370,7 +370,7 @@ below the processor's base frequency.
 
 Busy% = MPERF_delta/TSC_delta
 
-Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
+Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
 
 Note that these calculations depend on TSC_delta, so they
 are not reliable during intervals when TSC_MHz is not running at the base frequency.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b113900d9487..a41bad8e653b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -53,6 +53,8 @@
 #define	NAME_BYTES 20
 #define PATH_BYTES 128
 
+#define MAX_NOFILE 0x8000
+
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
@@ -1811,9 +1813,10 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
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
@@ -1966,7 +1969,7 @@ unsigned long long get_uncore_mhz(int package, int die)
 {
 	char path[128];
 
-	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/current_freq_khz", package,
+	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/current_freq_khz", package,
 		die);
 
 	return (snapshot_sysfs_counter(path) / 1000);
@@ -6718,6 +6721,22 @@ void cmdline(int argc, char **argv)
 	}
 }
 
+void set_rlimit(void)
+{
+	struct rlimit limit;
+
+	if (getrlimit(RLIMIT_NOFILE, &limit) < 0)
+		err(1, "Failed to get rlimit");
+
+	if (limit.rlim_max < MAX_NOFILE)
+		limit.rlim_max = MAX_NOFILE;
+	if (limit.rlim_cur < MAX_NOFILE)
+		limit.rlim_cur = MAX_NOFILE;
+
+	if (setrlimit(RLIMIT_NOFILE, &limit) < 0)
+		err(1, "Failed to set rlimit");
+}
+
 int main(int argc, char **argv)
 {
 	outf = stderr;
@@ -6730,6 +6749,9 @@ int main(int argc, char **argv)
 
 	probe_sysfs();
 
+	if (!getuid())
+		set_rlimit();
+
 	turbostat_init();
 
 	msr_sum_record();
diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index d2d9e965eba5..f79815b7e951 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 
 #include <sys/syscall.h>
+#include <limits.h>
 #include <test_progs.h>
 #include "bloom_filter_map.skel.h"
 
@@ -21,6 +22,11 @@ static void test_fail_cases(void)
 	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value size 0"))
 		close(fd);
 
+	/* Invalid value size: too big */
+	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, INT32_MAX, 100, NULL);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value too large"))
+		close(fd);
+
 	/* Invalid max entries size */
 	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 0, NULL);
 	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid max entries size"))
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

