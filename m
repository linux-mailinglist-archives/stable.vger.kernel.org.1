Return-Path: <stable+bounces-118585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D2A3F601
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9357D17924C
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A25920E334;
	Fri, 21 Feb 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pMmFttSv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C820E026;
	Fri, 21 Feb 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144489; cv=none; b=iTm40qQlCWCF8xqNpPqcReKdqMqBbnyZrVhyeTFp34j6iKtQ1lnAtloqctknuqiubiQB4lSYL8w5ax/PgmOxp94VwOac9jRxlZcDKRKUxtzZ8uW1+NHN5kIuQui6e1UsirwgImfl2hTnYqa3R759xymLHKi6jDKdFpUw6Ay7QKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144489; c=relaxed/simple;
	bh=nz3qNJzb9/CtlJrN7anuTG2kiok0fJAcikXd77cHhP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMwWQsznCQ6zcSvlfcrV+E2duqcaxm8feuu1n1ATyXGzrcwzheN4NXGGIC7Qo+3pSVLWMHBYvB8GBD9KWpP3AdQC9WhXsflb6ZcyzheiCd5iQUHMiFofoJU1mbu3JzU5Y7TdUGuA+/eRyLnO/2lfntTunbr8kY3PmnodXpy/T58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pMmFttSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A17AC4CEE8;
	Fri, 21 Feb 2025 13:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740144488;
	bh=nz3qNJzb9/CtlJrN7anuTG2kiok0fJAcikXd77cHhP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMmFttSvJg7QfgMn1uHui6XC7tPYcgQQmK9qOQQkmxPPh8Y+sW9+JK1zKU32thNyn
	 Cbic8Osq/3d97i/nbxn17lu9I6Ujfa9iSHUh3Hzj9B5lR+hMMz36aWd31+dIZPWDvg
	 snmk6pyHwKmITuECqm01FYJuRj4GLv6q5tBaGLDU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.16
Date: Fri, 21 Feb 2025 14:27:56 +0100
Message-ID: <2025022156-skimmed-tinderbox-4068@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025022155-skinhead-undergrad-14b0@gregkh>
References: <2025022155-skinhead-undergrad-14b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index f2fd2df68a9e..b7241ce975b9 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -22,7 +22,7 @@ description:
   Each sub-node is identified using the node's name, with valid values listed
   for each of the pmics below.
 
-  For mp5496, s1, s2
+  For mp5496, s1, s2, l2, l5
 
   For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
   l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
diff --git a/Documentation/networking/iso15765-2.rst b/Documentation/networking/iso15765-2.rst
index 0e9d96074178..37ebb2c417cb 100644
--- a/Documentation/networking/iso15765-2.rst
+++ b/Documentation/networking/iso15765-2.rst
@@ -369,8 +369,8 @@ to their default.
 
   addr.can_family = AF_CAN;
   addr.can_ifindex = if_nametoindex("can0");
-  addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
-  addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
+  addr.can_addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
+  addr.can_addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
 
   ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
   if (ret < 0)
diff --git a/Makefile b/Makefile
index c6918c620bc3..340da922fa4f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 15
+SUBLEVEL = 16
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
@@ -1057,8 +1057,8 @@ LDFLAGS_vmlinux += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
 endif
 
 # Align the bit size of userspace programs with the kernel
-KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
-KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
+KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
+KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
@@ -1357,18 +1357,13 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
 	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=$(resolve_btfids_O) clean
 endif
 
-# Clear a bunch of variables before executing the submake
-ifeq ($(quiet),silent_)
-tools_silent=s
-endif
-
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
+	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
+	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
 # ---------------------------------------------------------------------------
 # Kernel selftest
diff --git a/arch/alpha/include/uapi/asm/ptrace.h b/arch/alpha/include/uapi/asm/ptrace.h
index 5ca45934fcbb..72ed913a910f 100644
--- a/arch/alpha/include/uapi/asm/ptrace.h
+++ b/arch/alpha/include/uapi/asm/ptrace.h
@@ -42,6 +42,8 @@ struct pt_regs {
 	unsigned long trap_a0;
 	unsigned long trap_a1;
 	unsigned long trap_a2;
+/* This makes the stack 16-byte aligned as GCC expects */
+	unsigned long __pad0;
 /* These are saved by PAL-code: */
 	unsigned long ps;
 	unsigned long pc;
diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
index 4cfeae42c79a..e9dad60b147f 100644
--- a/arch/alpha/kernel/asm-offsets.c
+++ b/arch/alpha/kernel/asm-offsets.c
@@ -19,9 +19,13 @@ static void __used foo(void)
 	DEFINE(TI_STATUS, offsetof(struct thread_info, status));
 	BLANK();
 
+	DEFINE(SP_OFF, offsetof(struct pt_regs, ps));
 	DEFINE(SIZEOF_PT_REGS, sizeof(struct pt_regs));
 	BLANK();
 
+	DEFINE(SWITCH_STACK_SIZE, sizeof(struct switch_stack));
+	BLANK();
+
 	DEFINE(HAE_CACHE, offsetof(struct alpha_machine_vector, hae_cache));
 	DEFINE(HAE_REG, offsetof(struct alpha_machine_vector, hae_register));
 }
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index dd26062d75b3..f4d41b4538c2 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -15,10 +15,6 @@
 	.set noat
 	.cfi_sections	.debug_frame
 
-/* Stack offsets.  */
-#define SP_OFF			184
-#define SWITCH_STACK_SIZE	64
-
 .macro	CFI_START_OSF_FRAME	func
 	.align	4
 	.globl	\func
@@ -198,8 +194,8 @@ CFI_END_OSF_FRAME entArith
 CFI_START_OSF_FRAME entMM
 	SAVE_ALL
 /* save $9 - $15 so the inline exception code can manipulate them.  */
-	subq	$sp, 56, $sp
-	.cfi_adjust_cfa_offset	56
+	subq	$sp, 64, $sp
+	.cfi_adjust_cfa_offset	64
 	stq	$9, 0($sp)
 	stq	$10, 8($sp)
 	stq	$11, 16($sp)
@@ -214,7 +210,7 @@ CFI_START_OSF_FRAME entMM
 	.cfi_rel_offset	$13, 32
 	.cfi_rel_offset	$14, 40
 	.cfi_rel_offset	$15, 48
-	addq	$sp, 56, $19
+	addq	$sp, 64, $19
 /* handle the fault */
 	lda	$8, 0x3fff
 	bic	$sp, $8, $8
@@ -227,7 +223,7 @@ CFI_START_OSF_FRAME entMM
 	ldq	$13, 32($sp)
 	ldq	$14, 40($sp)
 	ldq	$15, 48($sp)
-	addq	$sp, 56, $sp
+	addq	$sp, 64, $sp
 	.cfi_restore	$9
 	.cfi_restore	$10
 	.cfi_restore	$11
@@ -235,7 +231,7 @@ CFI_START_OSF_FRAME entMM
 	.cfi_restore	$13
 	.cfi_restore	$14
 	.cfi_restore	$15
-	.cfi_adjust_cfa_offset	-56
+	.cfi_adjust_cfa_offset	-64
 /* finish up the syscall as normal.  */
 	br	ret_from_sys_call
 CFI_END_OSF_FRAME entMM
@@ -382,8 +378,8 @@ entUnaUser:
 	.cfi_restore	$0
 	.cfi_adjust_cfa_offset	-256
 	SAVE_ALL		/* setup normal kernel stack */
-	lda	$sp, -56($sp)
-	.cfi_adjust_cfa_offset	56
+	lda	$sp, -64($sp)
+	.cfi_adjust_cfa_offset	64
 	stq	$9, 0($sp)
 	stq	$10, 8($sp)
 	stq	$11, 16($sp)
@@ -399,7 +395,7 @@ entUnaUser:
 	.cfi_rel_offset	$14, 40
 	.cfi_rel_offset	$15, 48
 	lda	$8, 0x3fff
-	addq	$sp, 56, $19
+	addq	$sp, 64, $19
 	bic	$sp, $8, $8
 	jsr	$26, do_entUnaUser
 	ldq	$9, 0($sp)
@@ -409,7 +405,7 @@ entUnaUser:
 	ldq	$13, 32($sp)
 	ldq	$14, 40($sp)
 	ldq	$15, 48($sp)
-	lda	$sp, 56($sp)
+	lda	$sp, 64($sp)
 	.cfi_restore	$9
 	.cfi_restore	$10
 	.cfi_restore	$11
@@ -417,7 +413,7 @@ entUnaUser:
 	.cfi_restore	$13
 	.cfi_restore	$14
 	.cfi_restore	$15
-	.cfi_adjust_cfa_offset	-56
+	.cfi_adjust_cfa_offset	-64
 	br	ret_from_sys_call
 CFI_END_OSF_FRAME entUna
 
diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index a9a38c80c4a7..7004397937cf 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -649,7 +649,7 @@ s_reg_to_mem (unsigned long s_reg)
 static int unauser_reg_offsets[32] = {
 	R(r0), R(r1), R(r2), R(r3), R(r4), R(r5), R(r6), R(r7), R(r8),
 	/* r9 ... r15 are stored in front of regs.  */
-	-56, -48, -40, -32, -24, -16, -8,
+	-64, -56, -48, -40, -32, -24, -16,	/* padding at -8 */
 	R(r16), R(r17), R(r18),
 	R(r19), R(r20), R(r21), R(r22), R(r23), R(r24), R(r25), R(r26),
 	R(r27), R(r28), R(gp),
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 8c9850437e67..a9816bbc9f34 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -78,8 +78,8 @@ __load_new_mm_context(struct mm_struct *next_mm)
 
 /* Macro for exception fixup code to access integer registers.  */
 #define dpf_reg(r)							\
-	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-16 :	\
-				 (r) <= 18 ? (r)+10 : (r)-10])
+	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-17 :	\
+				 (r) <= 18 ? (r)+11 : (r)-10])
 
 asmlinkage void
 do_page_fault(unsigned long address, unsigned long mmcsr,
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 9efd3f37c2fd..19a4988621ac 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -48,7 +48,11 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
 
+ifeq ($(call test-ge, $(CONFIG_RUSTC_VERSION), 108500),y)
+KBUILD_RUSTFLAGS += --target=aarch64-unknown-none-softfloat
+else
 KBUILD_RUSTFLAGS += --target=aarch64-unknown-none -Ctarget-feature="-neon"
+endif
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index d9c9218fa1fd..309942b06c5b 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -101,16 +101,18 @@ int populate_cache_leaves(unsigned int cpu)
 	unsigned int level, idx;
 	enum cache_type type;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	struct cacheinfo *infos = this_cpu_ci->info_list;
 
 	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
-	     idx < this_cpu_ci->num_leaves; idx++, level++) {
+	     idx < this_cpu_ci->num_leaves; level++) {
 		type = get_cache_type(level);
 		if (type == CACHE_TYPE_SEPARATE) {
-			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
-			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+			if (idx + 1 >= this_cpu_ci->num_leaves)
+				break;
+			ci_leaf_init(&infos[idx++], CACHE_TYPE_DATA, level);
+			ci_leaf_init(&infos[idx++], CACHE_TYPE_INST, level);
 		} else {
-			ci_leaf_init(this_leaf++, type, level);
+			ci_leaf_init(&infos[idx++], type, level);
 		}
 	}
 	return 0;
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index f204a9ddc833..a3f1e895e2a6 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -41,6 +41,7 @@ SECTIONS
 	 */
 	/DISCARD/	: {
 		*(.note.GNU-stack .note.gnu.property)
+		*(.ARM.attributes)
 	}
 	.note		: { *(.note.*) }		:text	:note
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f84c71f04d9e..e73326bd3ff7 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -162,6 +162,7 @@ SECTIONS
 	/DISCARD/ : {
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
+		*(.ARM.attributes)
 	}
 
 	. = KIMAGE_VADDR;
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 86d5d90ebefe..4f0912141781 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -18,16 +18,19 @@
 
 	.align	5
 SYM_FUNC_START(__arch_cpu_idle)
-	/* start of rollback region */
-	LONG_L	t0, tp, TI_FLAGS
-	nop
-	andi	t0, t0, _TIF_NEED_RESCHED
-	bnez	t0, 1f
-	nop
-	nop
-	nop
+	/* start of idle interrupt region */
+	ori	t0, zero, CSR_CRMD_IE
+	/* idle instruction needs irq enabled */
+	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
+	/*
+	 * If an interrupt lands here; between enabling interrupts above and
+	 * going idle on the next instruction, we must *NOT* go idle since the
+	 * interrupt could have set TIF_NEED_RESCHED or caused an timer to need
+	 * reprogramming. Fall through -- see handle_vint() below -- and have
+	 * the idle loop take care of things.
+	 */
 	idle	0
-	/* end of rollback region */
+	/* end of idle interrupt region */
 1:	jr	ra
 SYM_FUNC_END(__arch_cpu_idle)
 
@@ -35,11 +38,10 @@ SYM_CODE_START(handle_vint)
 	UNWIND_HINT_UNDEFINED
 	BACKUP_T0T1
 	SAVE_ALL
-	la_abs	t1, __arch_cpu_idle
+	la_abs	t1, 1b
 	LONG_L	t0, sp, PT_ERA
-	/* 32 byte rollback region */
-	ori	t0, t0, 0x1f
-	xori	t0, t0, 0x1f
+	/* 3 instructions idle interrupt region */
+	ori	t0, t0, 0b1100
 	bne	t0, t1, 1f
 	LONG_S	t0, sp, PT_ERA
 1:	move	a0, sp
diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
index 0b5dd2faeb90..54b247d8cdb6 100644
--- a/arch/loongarch/kernel/idle.c
+++ b/arch/loongarch/kernel/idle.c
@@ -11,7 +11,6 @@
 
 void __cpuidle arch_cpu_idle(void)
 {
-	raw_local_irq_enable();
-	__arch_cpu_idle(); /* idle instruction needs irq enabled */
+	__arch_cpu_idle();
 	raw_local_irq_disable();
 }
diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
index 1ef8c6383535..de8fa5a8a825 100644
--- a/arch/loongarch/kernel/reset.c
+++ b/arch/loongarch/kernel/reset.c
@@ -33,7 +33,7 @@ void machine_halt(void)
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
 	while (true) {
-		__arch_cpu_idle();
+		__asm__ __volatile__("idle 0" : : : "memory");
 	}
 }
 
@@ -53,7 +53,7 @@ void machine_power_off(void)
 #endif
 
 	while (true) {
-		__arch_cpu_idle();
+		__asm__ __volatile__("idle 0" : : : "memory");
 	}
 }
 
@@ -74,6 +74,6 @@ void machine_restart(char *command)
 		acpi_reboot();
 
 	while (true) {
-		__arch_cpu_idle();
+		__asm__ __volatile__("idle 0" : : : "memory");
 	}
 }
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 27e9b94c0a0b..7e8f5d6829ef 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -283,9 +283,9 @@ int kvm_arch_enable_virtualization_cpu(void)
 	 * TOE=0:       Trap on Exception.
 	 * TIT=0:       Trap on Timer.
 	 */
-	if (env & CSR_GCFG_GCIP_ALL)
+	if (env & CSR_GCFG_GCIP_SECURE)
 		gcfg |= CSR_GCFG_GCI_SECURE;
-	if (env & CSR_GCFG_MATC_ROOT)
+	if (env & CSR_GCFG_MATP_ROOT)
 		gcfg |= CSR_GCFG_MATC_ROOT;
 
 	write_csr_gcfg(gcfg);
diff --git a/arch/loongarch/lib/csum.c b/arch/loongarch/lib/csum.c
index a5e84b403c3b..df309ae4045d 100644
--- a/arch/loongarch/lib/csum.c
+++ b/arch/loongarch/lib/csum.c
@@ -25,7 +25,7 @@ unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
 	const u64 *ptr;
 	u64 data, sum64 = 0;
 
-	if (unlikely(len == 0))
+	if (unlikely(len <= 0))
 		return 0;
 
 	offset = (unsigned long)buff & 7;
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 56a786ca7354..c38546829345 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -331,6 +331,17 @@ static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
 	return rc;
 }
 
+static bool zpci_bus_is_isolated_vf(struct zpci_bus *zbus, struct zpci_dev *zdev)
+{
+	struct pci_dev *pdev;
+
+	pdev = zpci_iov_find_parent_pf(zbus, zdev);
+	if (!pdev)
+		return true;
+	pci_dev_put(pdev);
+	return false;
+}
+
 int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops)
 {
 	bool topo_is_tid = zdev->tid_avail;
@@ -345,6 +356,15 @@ int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops)
 
 	topo = topo_is_tid ? zdev->tid : zdev->pchid;
 	zbus = zpci_bus_get(topo, topo_is_tid);
+	/*
+	 * An isolated VF gets its own domain/bus even if there exists
+	 * a matching domain/bus already
+	 */
+	if (zbus && zpci_bus_is_isolated_vf(zbus, zdev)) {
+		zpci_bus_put(zbus);
+		zbus = NULL;
+	}
+
 	if (!zbus) {
 		zbus = zpci_bus_alloc(topo, topo_is_tid);
 		if (!zbus)
diff --git a/arch/s390/pci/pci_iov.c b/arch/s390/pci/pci_iov.c
index ead062bf2b41..191e56a623f6 100644
--- a/arch/s390/pci/pci_iov.c
+++ b/arch/s390/pci/pci_iov.c
@@ -60,18 +60,35 @@ static int zpci_iov_link_virtfn(struct pci_dev *pdev, struct pci_dev *virtfn, in
 	return 0;
 }
 
-int zpci_iov_setup_virtfn(struct zpci_bus *zbus, struct pci_dev *virtfn, int vfn)
+/**
+ * zpci_iov_find_parent_pf - Find the parent PF, if any, of the given function
+ * @zbus:	The bus that the PCI function is on, or would be added on
+ * @zdev:	The PCI function
+ *
+ * Finds the parent PF, if it exists and is configured, of the given PCI function
+ * and increments its refcount. Th PF is searched for on the provided bus so the
+ * caller has to ensure that this is the correct bus to search. This function may
+ * be used before adding the PCI function to a zbus.
+ *
+ * Return: Pointer to the struct pci_dev of the parent PF or NULL if it not
+ * found. If the function is not a VF or has no RequesterID information,
+ * NULL is returned as well.
+ */
+struct pci_dev *zpci_iov_find_parent_pf(struct zpci_bus *zbus, struct zpci_dev *zdev)
 {
-	int i, cand_devfn;
-	struct zpci_dev *zdev;
+	int i, vfid, devfn, cand_devfn;
 	struct pci_dev *pdev;
-	int vfid = vfn - 1; /* Linux' vfid's start at 0 vfn at 1*/
-	int rc = 0;
 
 	if (!zbus->multifunction)
-		return 0;
-
-	/* If the parent PF for the given VF is also configured in the
+		return NULL;
+	/* Non-VFs and VFs without RID available don't have a parent */
+	if (!zdev->vfn || !zdev->rid_available)
+		return NULL;
+	/* Linux vfid starts at 0 vfn at 1 */
+	vfid = zdev->vfn - 1;
+	devfn = zdev->rid & ZPCI_RID_MASK_DEVFN;
+	/*
+	 * If the parent PF for the given VF is also configured in the
 	 * instance, it must be on the same zbus.
 	 * We can then identify the parent PF by checking what
 	 * devfn the VF would have if it belonged to that PF using the PF's
@@ -85,15 +102,26 @@ int zpci_iov_setup_virtfn(struct zpci_bus *zbus, struct pci_dev *virtfn, int vfn
 			if (!pdev)
 				continue;
 			cand_devfn = pci_iov_virtfn_devfn(pdev, vfid);
-			if (cand_devfn == virtfn->devfn) {
-				rc = zpci_iov_link_virtfn(pdev, virtfn, vfid);
-				/* balance pci_get_slot() */
-				pci_dev_put(pdev);
-				break;
-			}
+			if (cand_devfn == devfn)
+				return pdev;
 			/* balance pci_get_slot() */
 			pci_dev_put(pdev);
 		}
 	}
+	return NULL;
+}
+
+int zpci_iov_setup_virtfn(struct zpci_bus *zbus, struct pci_dev *virtfn, int vfn)
+{
+	struct zpci_dev *zdev = to_zpci(virtfn);
+	struct pci_dev *pdev_pf;
+	int rc = 0;
+
+	pdev_pf = zpci_iov_find_parent_pf(zbus, zdev);
+	if (pdev_pf) {
+		/* Linux' vfids start at 0 while zdev->vfn starts at 1 */
+		rc = zpci_iov_link_virtfn(pdev_pf, virtfn, zdev->vfn - 1);
+		pci_dev_put(pdev_pf);
+	}
 	return rc;
 }
diff --git a/arch/s390/pci/pci_iov.h b/arch/s390/pci/pci_iov.h
index b2c828003bad..05df728f980c 100644
--- a/arch/s390/pci/pci_iov.h
+++ b/arch/s390/pci/pci_iov.h
@@ -17,6 +17,8 @@ void zpci_iov_map_resources(struct pci_dev *pdev);
 
 int zpci_iov_setup_virtfn(struct zpci_bus *zbus, struct pci_dev *virtfn, int vfn);
 
+struct pci_dev *zpci_iov_find_parent_pf(struct zpci_bus *zbus, struct zpci_dev *zdev);
+
 #else /* CONFIG_PCI_IOV */
 static inline void zpci_iov_remove_virtfn(struct pci_dev *pdev, int vfn) {}
 
@@ -26,5 +28,10 @@ static inline int zpci_iov_setup_virtfn(struct zpci_bus *zbus, struct pci_dev *v
 {
 	return 0;
 }
+
+static inline struct pci_dev *zpci_iov_find_parent_pf(struct zpci_bus *zbus, struct zpci_dev *zdev)
+{
+	return NULL;
+}
 #endif /* CONFIG_PCI_IOV */
 #endif /* __S390_PCI_IOV_h */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 171be04eca1f..1b0c2397d657 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2582,7 +2582,8 @@ config MITIGATION_IBPB_ENTRY
 	depends on CPU_SUP_AMD && X86_64
 	default y
 	help
-	  Compile the kernel with support for the retbleed=ibpb mitigation.
+	  Compile the kernel with support for the retbleed=ibpb and
+	  spec_rstack_overflow={ibpb,ibpb-vmexit} mitigations.
 
 config MITIGATION_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f558be868a50..f5bf400f6a28 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4865,20 +4865,22 @@ static inline bool intel_pmu_broken_perf_cap(void)
 
 static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 {
-	unsigned int sub_bitmaps, eax, ebx, ecx, edx;
+	unsigned int cntr, fixed_cntr, ecx, edx;
+	union cpuid35_eax eax;
+	union cpuid35_ebx ebx;
 
-	cpuid(ARCH_PERFMON_EXT_LEAF, &sub_bitmaps, &ebx, &ecx, &edx);
+	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
 
-	if (ebx & ARCH_PERFMON_EXT_UMASK2)
+	if (ebx.split.umask2)
 		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_UMASK2;
-	if (ebx & ARCH_PERFMON_EXT_EQ)
+	if (ebx.split.eq)
 		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
 
-	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
+	if (eax.split.cntr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
-			    &eax, &ebx, &ecx, &edx);
-		pmu->cntr_mask64 = eax;
-		pmu->fixed_cntr_mask64 = ebx;
+			    &cntr, &fixed_cntr, &ecx, &edx);
+		pmu->cntr_mask64 = cntr;
+		pmu->fixed_cntr_mask64 = fixed_cntr;
 	}
 
 	if (!intel_pmu_broken_perf_cap()) {
@@ -4901,11 +4903,6 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 	else
 		pmu->intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
 
-	if (pmu->intel_cap.pebs_output_pt_available)
-		pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
-	else
-		pmu->pmu.capabilities &= ~PERF_PMU_CAP_AUX_OUTPUT;
-
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->cntr_mask64,
 					  pmu->fixed_cntr_mask64,
@@ -4974,9 +4971,6 @@ static bool init_hybrid_pmu(int cpu)
 
 	pr_info("%s PMU driver: ", pmu->name);
 
-	if (pmu->intel_cap.pebs_output_pt_available)
-		pr_cont("PEBS-via-PT ");
-
 	pr_cont("\n");
 
 	x86_pmu_show_pmu_cap(&pmu->pmu);
@@ -4999,8 +4993,11 @@ static void intel_pmu_cpu_starting(int cpu)
 
 	init_debug_store_on_cpu(cpu);
 	/*
-	 * Deal with CPUs that don't clear their LBRs on power-up.
+	 * Deal with CPUs that don't clear their LBRs on power-up, and that may
+	 * even boot with LBRs enabled.
 	 */
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && x86_pmu.lbr_nr)
+		msr_clear_bit(MSR_IA32_DEBUGCTLMSR, DEBUGCTLMSR_LBR_BIT);
 	intel_pmu_lbr_reset();
 
 	cpuc->lbr_sel = NULL;
@@ -6284,11 +6281,9 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
 		if (pmu->pmu_type & hybrid_small) {
 			pmu->intel_cap.perf_metrics = 0;
-			pmu->intel_cap.pebs_output_pt_available = 1;
 			pmu->mid_ack = true;
 		} else if (pmu->pmu_type & hybrid_big) {
 			pmu->intel_cap.perf_metrics = 1;
-			pmu->intel_cap.pebs_output_pt_available = 0;
 			pmu->late_ack = true;
 		}
 	}
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 19a9fd974e3e..b6303b022453 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2523,7 +2523,15 @@ void __init intel_ds_init(void)
 			}
 			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
 
-			if (!is_hybrid() && x86_pmu.intel_cap.pebs_output_pt_available) {
+			/*
+			 * The PEBS-via-PT is not supported on hybrid platforms,
+			 * because not all CPUs of a hybrid machine support it.
+			 * The global x86_pmu.intel_cap, which only contains the
+			 * common capabilities, is used to check the availability
+			 * of the feature. The per-PMU pebs_output_pt_available
+			 * in a hybrid machine should be ignored.
+			 */
+			if (x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
 				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 			}
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 861d080ed4c6..cfb22f8c451a 100644
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
index 5da67e5c0040..8499b9cb9c82 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1674,6 +1674,7 @@ struct kvm_x86_ops {
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
+	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index ce4677b8b735..3b496cdcb74b 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -37,6 +37,8 @@ typedef struct {
 	 */
 	atomic64_t tlb_gen;
 
+	unsigned long next_trim_cpumask;
+
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	struct rw_semaphore	ldt_usr_sem;
 	struct ldt_struct	*ldt;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 2886cb668d7f..795fdd53bd0a 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -151,6 +151,7 @@ static inline int init_new_context(struct task_struct *tsk,
 
 	mm->context.ctx_id = atomic64_inc_return(&last_mm_ctx_id);
 	atomic64_set(&mm->context.tlb_gen, 0);
+	mm->context.next_trim_cpumask = jiffies + HZ;
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..61e991507353 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -395,7 +395,8 @@
 #define MSR_IA32_PASID_VALID		BIT_ULL(31)
 
 /* DEBUGCTLMSR bits (others vary by model): */
-#define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
+#define DEBUGCTLMSR_LBR_BIT		0	     /* last branch recording */
+#define DEBUGCTLMSR_LBR			(1UL <<  DEBUGCTLMSR_LBR_BIT)
 #define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
 #define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 91b73571412f..7505bb5d260a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -187,11 +187,33 @@ union cpuid10_edx {
  * detection/enumeration details:
  */
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
-#define ARCH_PERFMON_EXT_UMASK2			0x1
-#define ARCH_PERFMON_EXT_EQ			0x2
-#define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
 
+union cpuid35_eax {
+	struct {
+		unsigned int	leaf0:1;
+		/* Counters Sub-Leaf */
+		unsigned int    cntr_subleaf:1;
+		/* Auto Counter Reload Sub-Leaf */
+		unsigned int    acr_subleaf:1;
+		/* Events Sub-Leaf */
+		unsigned int    events_subleaf:1;
+		unsigned int	reserved:28;
+	} split;
+	unsigned int            full;
+};
+
+union cpuid35_ebx {
+	struct {
+		/* UnitMask2 Supported */
+		unsigned int    umask2:1;
+		/* EQ-bit Supported */
+		unsigned int    eq:1;
+		unsigned int	reserved:30;
+	} split;
+	unsigned int            full;
+};
+
 /*
  * Intel Architectural LBR CPUID detection/enumeration details:
  */
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 69e79fff41b8..02fc2aa06e9e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -222,6 +222,7 @@ struct flush_tlb_info {
 	unsigned int		initiating_cpu;
 	u8			stride_shift;
 	u8			freed_tables;
+	u8			trim_cpumask;
 };
 
 void flush_tlb_local(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 47a01d4028f6..5fba44a4f988 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1115,6 +1115,8 @@ static void __init retbleed_select_mitigation(void)
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		mitigate_smt = true;
 
 		/*
 		 * IBPB on entry already obviates the need for
@@ -1124,9 +1126,6 @@ static void __init retbleed_select_mitigation(void)
 		setup_clear_cpu_cap(X86_FEATURE_UNRET);
 		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 
-		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-		mitigate_smt = true;
-
 		/*
 		 * There is no need for RSB filling: entry_ibpb() ensures
 		 * all predictions, including the RSB, are invalidated,
@@ -2643,6 +2642,7 @@ static void __init srso_select_mitigation(void)
 		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB;
 
 				/*
@@ -2652,6 +2652,13 @@ static void __init srso_select_mitigation(void)
 				 */
 				setup_clear_cpu_cap(X86_FEATURE_UNRET);
 				setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
+
+				/*
+				 * There is no need for RSB filling: entry_ibpb() ensures
+				 * all predictions, including the RSB, are invalidated,
+				 * regardless of IBPB implementation.
+				 */
+				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
@@ -2659,8 +2666,8 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
+		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
+			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 
@@ -2672,8 +2679,8 @@ static void __init srso_select_mitigation(void)
 				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 			}
 		} else {
-			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
-                }
+			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
+		}
 		break;
 	default:
 		break;
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 9eed0c144dad..9e51242ed125 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -175,7 +175,6 @@ EXPORT_SYMBOL_GPL(arch_static_call_transform);
 noinstr void __static_call_update_early(void *tramp, void *func)
 {
 	BUG_ON(system_state != SYSTEM_BOOTING);
-	BUG_ON(!early_boot_irqs_disabled);
 	BUG_ON(static_call_initialized);
 	__text_gen_insn(tramp, JMP32_INSN_OPCODE, tramp, func, JMP32_INSN_SIZE);
 	sync_core();
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4f0a94346d00..44c88537448c 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2226,6 +2226,9 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	u32 vector;
 	bool all_cpus;
 
+	if (!lapic_in_kernel(vcpu))
+		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
 	if (hc->code == HVCALL_SEND_IPI) {
 		if (!hc->fast) {
 			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send_ipi,
@@ -2852,7 +2855,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->eax |= HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
 			ent->eax |= HV_X64_APIC_ACCESS_RECOMMENDED;
 			ent->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
-			ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
+			if (!vcpu || lapic_in_kernel(vcpu))
+				ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
 			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
 			if (evmcs_ver)
 				ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9dd3796d075a..19c96278ba75 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5591,7 +5591,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 	union kvm_mmu_page_role root_role;
 
 	/* NPT requires CR0.PG=1. */
-	WARN_ON_ONCE(cpu_role.base.direct);
+	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index cf84103ce38b..2dcb9c870d5a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -646,6 +646,11 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	u32 pause_count12;
 	u32 pause_thresh12;
 
+	nested_svm_transition_tlb_flush(vcpu);
+
+	/* Enter Guest-Mode */
+	enter_guest_mode(vcpu);
+
 	/*
 	 * Filled at exit: exit_code, exit_code_hi, exit_info_1, exit_info_2,
 	 * exit_int_info, exit_int_info_err, next_rip, insn_len, insn_bytes.
@@ -762,11 +767,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 		}
 	}
 
-	nested_svm_transition_tlb_flush(vcpu);
-
-	/* Enter Guest-Mode */
-	enter_guest_mode(vcpu);
-
 	/*
 	 * Merge guest and host intercepts - must be called with vcpu in
 	 * guest-mode to take effect.
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4543dd6bcab2..a7cb7c82b38e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1993,11 +1993,11 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
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
@@ -4234,10 +4234,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
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
@@ -5033,6 +5031,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
+	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
 	.cache_reg = svm_cache_reg,
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 7668e2fb8043..47476fcc179a 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -60,6 +60,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
+	.set_dr6 = vmx_set_dr6,
 	.set_dr7 = vmx_set_dr7,
 	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
 	.cache_reg = vmx_cache_reg,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 968ddf714054..f06d443ec3c6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5631,6 +5631,12 @@ void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	set_debugreg(DR6_RESERVED, 6);
 }
 
+void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
+{
+	lockdep_assert_irqs_disabled();
+	set_debugreg(vcpu->arch.dr6, 6);
+}
+
 void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	vmcs_writel(GUEST_DR7, val);
@@ -7392,10 +7398,6 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 		vmx->loaded_vmcs->host_state.cr4 = cr4;
 	}
 
-	/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
-	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-		set_debugreg(vcpu->arch.dr6, 6);
-
 	/* When single-stepping over STI and MOV SS, we must clear the
 	 * corresponding interruptibility bits in the guest state. Otherwise
 	 * vmentry fails as it then expects bit 14 (BS) in pending debug
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 48dc76bf0ec0..4aba200f435d 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -74,6 +74,7 @@ void vmx_get_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 void vmx_set_idt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 void vmx_get_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 void vmx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
+void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val);
 void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val);
 void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu);
 void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d760b19d1e51..0846e3af5f6c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10968,6 +10968,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(vcpu->arch.eff_db[1], 1);
 		set_debugreg(vcpu->arch.eff_db[2], 2);
 		set_debugreg(vcpu->arch.eff_db[3], 3);
+		/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
+		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
+			kvm_x86_call(set_dr6)(vcpu, vcpu->arch.dr6);
 	} else if (unlikely(hw_breakpoint_active())) {
 		set_debugreg(0, 7);
 	}
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b0678d59ebdb..00ffa74d0dd0 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -893,9 +893,36 @@ static void flush_tlb_func(void *info)
 			nr_invalidate);
 }
 
-static bool tlb_is_not_lazy(int cpu, void *data)
+static bool should_flush_tlb(int cpu, void *data)
 {
-	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
+	struct flush_tlb_info *info = data;
+
+	/* Lazy TLB will get flushed at the next context switch. */
+	if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
+		return false;
+
+	/* No mm means kernel memory flush. */
+	if (!info->mm)
+		return true;
+
+	/* The target mm is loaded, and the CPU is not lazy. */
+	if (per_cpu(cpu_tlbstate.loaded_mm, cpu) == info->mm)
+		return true;
+
+	/* In cpumask, but not the loaded mm? Periodically remove by flushing. */
+	if (info->trim_cpumask)
+		return true;
+
+	return false;
+}
+
+static bool should_trim_cpumask(struct mm_struct *mm)
+{
+	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {
+		WRITE_ONCE(mm->context.next_trim_cpumask, jiffies + HZ);
+		return true;
+	}
+	return false;
 }
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
@@ -929,7 +956,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	if (info->freed_tables)
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
+		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
 				(void *)info, 1, cpumask);
 }
 
@@ -980,6 +1007,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	info->freed_tables	= freed_tables;
 	info->new_tlb_gen	= new_tlb_gen;
 	info->initiating_cpu	= smp_processor_id();
+	info->trim_cpumask	= 0;
 
 	return info;
 }
@@ -1022,6 +1050,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	 * flush_tlb_func_local() directly in this case.
 	 */
 	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+		info->trim_cpumask = should_trim_cpumask(mm);
 		flush_tlb_multi(mm_cpumask(mm), info);
 	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 55a4996d0c04..d078de2c952b 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -111,6 +111,51 @@ static pud_t level3_user_vsyscall[PTRS_PER_PUD] __page_aligned_bss;
  */
 static DEFINE_SPINLOCK(xen_reservation_lock);
 
+/* Protected by xen_reservation_lock. */
+#define MIN_CONTIG_ORDER 9 /* 2MB */
+static unsigned int discontig_frames_order = MIN_CONTIG_ORDER;
+static unsigned long discontig_frames_early[1UL << MIN_CONTIG_ORDER] __initdata;
+static unsigned long *discontig_frames __refdata = discontig_frames_early;
+static bool discontig_frames_dyn;
+
+static int alloc_discontig_frames(unsigned int order)
+{
+	unsigned long *new_array, *old_array;
+	unsigned int old_order;
+	unsigned long flags;
+
+	BUG_ON(order < MIN_CONTIG_ORDER);
+	BUILD_BUG_ON(sizeof(discontig_frames_early) != PAGE_SIZE);
+
+	new_array = (unsigned long *)__get_free_pages(GFP_KERNEL,
+						      order - MIN_CONTIG_ORDER);
+	if (!new_array)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&xen_reservation_lock, flags);
+
+	old_order = discontig_frames_order;
+
+	if (order > discontig_frames_order || !discontig_frames_dyn) {
+		if (!discontig_frames_dyn)
+			old_array = NULL;
+		else
+			old_array = discontig_frames;
+
+		discontig_frames = new_array;
+		discontig_frames_order = order;
+		discontig_frames_dyn = true;
+	} else {
+		old_array = new_array;
+	}
+
+	spin_unlock_irqrestore(&xen_reservation_lock, flags);
+
+	free_pages((unsigned long)old_array, old_order - MIN_CONTIG_ORDER);
+
+	return 0;
+}
+
 /*
  * Note about cr3 (pagetable base) values:
  *
@@ -781,6 +826,7 @@ void xen_mm_pin_all(void)
 {
 	struct page *page;
 
+	spin_lock(&init_mm.page_table_lock);
 	spin_lock(&pgd_lock);
 
 	list_for_each_entry(page, &pgd_list, lru) {
@@ -791,6 +837,7 @@ void xen_mm_pin_all(void)
 	}
 
 	spin_unlock(&pgd_lock);
+	spin_unlock(&init_mm.page_table_lock);
 }
 
 static void __init xen_mark_pinned(struct mm_struct *mm, struct page *page,
@@ -812,6 +859,9 @@ static void __init xen_after_bootmem(void)
 	SetPagePinned(virt_to_page(level3_user_vsyscall));
 #endif
 	xen_pgd_walk(&init_mm, xen_mark_pinned, FIXADDR_TOP);
+
+	if (alloc_discontig_frames(MIN_CONTIG_ORDER))
+		BUG();
 }
 
 static void xen_unpin_page(struct mm_struct *mm, struct page *page,
@@ -887,6 +937,7 @@ void xen_mm_unpin_all(void)
 {
 	struct page *page;
 
+	spin_lock(&init_mm.page_table_lock);
 	spin_lock(&pgd_lock);
 
 	list_for_each_entry(page, &pgd_list, lru) {
@@ -898,6 +949,7 @@ void xen_mm_unpin_all(void)
 	}
 
 	spin_unlock(&pgd_lock);
+	spin_unlock(&init_mm.page_table_lock);
 }
 
 static void xen_enter_mmap(struct mm_struct *mm)
@@ -2199,10 +2251,6 @@ void __init xen_init_mmu_ops(void)
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
 
-/* Protected by xen_reservation_lock. */
-#define MAX_CONTIG_ORDER 9 /* 2MB */
-static unsigned long discontig_frames[1<<MAX_CONTIG_ORDER];
-
 #define VOID_PTE (mfn_pte(0, __pgprot(0)))
 static void xen_zap_pfn_range(unsigned long vaddr, unsigned int order,
 				unsigned long *in_frames,
@@ -2319,18 +2367,25 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 				 unsigned int address_bits,
 				 dma_addr_t *dma_handle)
 {
-	unsigned long *in_frames = discontig_frames, out_frame;
+	unsigned long *in_frames, out_frame;
 	unsigned long  flags;
 	int            success;
 	unsigned long vstart = (unsigned long)phys_to_virt(pstart);
 
-	if (unlikely(order > MAX_CONTIG_ORDER))
-		return -ENOMEM;
+	if (unlikely(order > discontig_frames_order)) {
+		if (!discontig_frames_dyn)
+			return -ENOMEM;
+
+		if (alloc_discontig_frames(order))
+			return -ENOMEM;
+	}
 
 	memset((void *) vstart, 0, PAGE_SIZE << order);
 
 	spin_lock_irqsave(&xen_reservation_lock, flags);
 
+	in_frames = discontig_frames;
+
 	/* 1. Zap current PTEs, remembering MFNs. */
 	xen_zap_pfn_range(vstart, order, in_frames, NULL);
 
@@ -2354,12 +2409,12 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 
 void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 {
-	unsigned long *out_frames = discontig_frames, in_frame;
+	unsigned long *out_frames, in_frame;
 	unsigned long  flags;
 	int success;
 	unsigned long vstart;
 
-	if (unlikely(order > MAX_CONTIG_ORDER))
+	if (unlikely(order > discontig_frames_order))
 		return;
 
 	vstart = (unsigned long)phys_to_virt(pstart);
@@ -2367,6 +2422,8 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 
 	spin_lock_irqsave(&xen_reservation_lock, flags);
 
+	out_frames = discontig_frames;
+
 	/* 1. Find start MFN of contiguous extent. */
 	in_frame = virt_to_mfn((void *)vstart);
 
diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index c80183156d68..b02530d98629 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -53,13 +53,25 @@ int mac_partition(struct parsed_partitions *state)
 	}
 	secsize = be16_to_cpu(md->block_size);
 	put_dev_sector(sect);
+
+	/*
+	 * If the "block size" is not a power of 2, things get weird - we might
+	 * end up with a partition straddling a sector boundary, so we wouldn't
+	 * be able to read a partition entry with read_part_sector().
+	 * Real block sizes are probably (?) powers of two, so just require
+	 * that.
+	 */
+	if (!is_power_of_2(secsize))
+		return -1;
 	datasize = round_down(secsize, 512);
 	data = read_part_sector(state, datasize / 512, &sect);
 	if (!data)
 		return -1;
 	partoffset = secsize % 512;
-	if (partoffset + sizeof(*part) > datasize)
+	if (partoffset + sizeof(*part) > datasize) {
+		put_dev_sector(sect);
 		return -1;
+	}
 	part = (struct mac_partition *) (data + partoffset);
 	if (be16_to_cpu(part->signature) != MAC_PARTITION_MAGIC) {
 		put_dev_sector(sect);
@@ -112,8 +124,8 @@ int mac_partition(struct parsed_partitions *state)
 				int i, l;
 
 				goodness++;
-				l = strlen(part->name);
-				if (strcmp(part->name, "/") == 0)
+				l = strnlen(part->name, sizeof(part->name));
+				if (strncmp(part->name, "/", sizeof(part->name)) == 0)
 					goodness++;
 				for (i = 0; i <= l - 4; ++i) {
 					if (strncasecmp(part->name + i, "root",
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index cb45ef5240da..068c1612660b 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -407,6 +407,19 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
+	{
+		/* Vexia Edu Atla 10 tablet 5V version */
+		.matches = {
+			/* Having all 3 of these not set is somewhat unique */
+			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_BOARD_NAME, "To be filled by O.E.M."),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "05/14/2015"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+	},
 	{
 		/* Vexia Edu Atla 10 tablet 9V version */
 		.matches = {
diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 6981e5f974e9..ff7d0b14a646 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -909,6 +909,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_buf);
 	kfree(d->status_reg_buf);
 	if (d->config_buf) {
@@ -984,6 +985,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_reg_buf);
 	kfree(d->status_buf);
 	if (d->config_buf) {
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 8bd663f4bac1..53f6b4f76bcc 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1312,6 +1312,10 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 			if (opcode == 0xfc01)
 				btintel_pcie_inject_cmd_complete(hdev, opcode);
 		}
+		/* Firmware raises alive interrupt on HCI_OP_RESET */
+		if (opcode == HCI_OP_RESET)
+			data->gp0_received = false;
+
 		hdev->stat.cmd_tx++;
 		break;
 	case HCI_ACLDATA_PKT:
@@ -1349,7 +1353,6 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
 			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
 		if (opcode == HCI_OP_RESET) {
-			data->gp0_received = false;
 			ret = wait_event_timeout(data->gp0_wait_q,
 						 data->gp0_received,
 						 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 91d3c3b1c2d3..9db5354fdb02 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -696,12 +696,12 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -EOPNOTSUPP;
 	}
-	mutex_lock(&amd_pstate_driver_lock);
+	guard(mutex)(&amd_pstate_driver_lock);
+
 	ret = amd_pstate_cpu_boost_update(policy, state);
 	WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
 	policy->boost_enabled = !ret ? state : false;
 	refresh_frequency_limits(policy);
-	mutex_unlock(&amd_pstate_driver_lock);
 
 	return ret;
 }
@@ -778,24 +778,28 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 
 static void amd_pstate_update_limits(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy = NULL;
 	struct amd_cpudata *cpudata;
 	u32 prev_high = 0, cur_high = 0;
 	int ret;
 	bool highest_perf_changed = false;
 
+	if (!amd_pstate_prefcore)
+		return;
+
+	policy = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return;
 
 	cpudata = policy->driver_data;
 
-	if (!amd_pstate_prefcore)
-		return;
+	guard(mutex)(&amd_pstate_driver_lock);
 
-	mutex_lock(&amd_pstate_driver_lock);
 	ret = amd_get_highest_perf(cpu, &cur_high);
-	if (ret)
-		goto free_cpufreq_put;
+	if (ret) {
+		cpufreq_cpu_put(policy);
+		return;
+	}
 
 	prev_high = READ_ONCE(cpudata->prefcore_ranking);
 	highest_perf_changed = (prev_high != cur_high);
@@ -805,14 +809,11 @@ static void amd_pstate_update_limits(unsigned int cpu)
 		if (cur_high < CPPC_MAX_PERF)
 			sched_set_itmt_core_prio((int)cur_high, cpu);
 	}
-
-free_cpufreq_put:
 	cpufreq_cpu_put(policy);
 
 	if (!highest_perf_changed)
 		cpufreq_update_policy(cpu);
 
-	mutex_unlock(&amd_pstate_driver_lock);
 }
 
 /*
@@ -1145,11 +1146,11 @@ static ssize_t store_energy_performance_preference(
 	if (ret < 0)
 		return -EINVAL;
 
-	mutex_lock(&amd_pstate_limits_lock);
+	guard(mutex)(&amd_pstate_limits_lock);
+
 	ret = amd_pstate_set_energy_pref_index(cpudata, ret);
-	mutex_unlock(&amd_pstate_limits_lock);
 
-	return ret ?: count;
+	return ret ? ret : count;
 }
 
 static ssize_t show_energy_performance_preference(
@@ -1297,13 +1298,10 @@ EXPORT_SYMBOL_GPL(amd_pstate_update_status);
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	ssize_t ret;
 
-	mutex_lock(&amd_pstate_driver_lock);
-	ret = amd_pstate_show_status(buf);
-	mutex_unlock(&amd_pstate_driver_lock);
+	guard(mutex)(&amd_pstate_driver_lock);
 
-	return ret;
+	return amd_pstate_show_status(buf);
 }
 
 static ssize_t status_store(struct device *a, struct device_attribute *b,
@@ -1312,9 +1310,8 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	char *p = memchr(buf, '\n', count);
 	int ret;
 
-	mutex_lock(&amd_pstate_driver_lock);
+	guard(mutex)(&amd_pstate_driver_lock);
 	ret = amd_pstate_update_status(buf, p ? p - buf : count);
-	mutex_unlock(&amd_pstate_driver_lock);
 
 	return ret < 0 ? ret : count;
 }
@@ -1579,24 +1576,17 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_ctrls perf_ctrls;
-	u64 value, max_perf;
+	u64 max_perf;
 	int ret;
 
 	ret = amd_pstate_enable(true);
 	if (ret)
 		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
 
-	value = READ_ONCE(cpudata->cppc_req_cached);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
-	} else {
-		perf_ctrls.max_perf = max_perf;
-		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
-		cppc_set_perf(cpudata->cpu, &perf_ctrls);
-	}
+	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
+	amd_pstate_set_epp(cpudata, cpudata->epp_cached);
 }
 
 static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
@@ -1605,54 +1595,26 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
-	if (cppc_state == AMD_PSTATE_ACTIVE) {
-		amd_pstate_epp_reenable(cpudata);
-		cpudata->suspended = false;
-	}
+	amd_pstate_epp_reenable(cpudata);
+	cpudata->suspended = false;
 
 	return 0;
 }
 
-static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
-{
-	struct amd_cpudata *cpudata = policy->driver_data;
-	struct cppc_perf_ctrls perf_ctrls;
-	int min_perf;
-	u64 value;
-
-	min_perf = READ_ONCE(cpudata->lowest_perf);
-	value = READ_ONCE(cpudata->cppc_req_cached);
-
-	mutex_lock(&amd_pstate_limits_lock);
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
-
-		/* Set max perf same as min perf */
-		value &= ~AMD_CPPC_MAX_PERF(~0L);
-		value |= AMD_CPPC_MAX_PERF(min_perf);
-		value &= ~AMD_CPPC_MIN_PERF(~0L);
-		value |= AMD_CPPC_MIN_PERF(min_perf);
-		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
-	} else {
-		perf_ctrls.desired_perf = 0;
-		perf_ctrls.max_perf = min_perf;
-		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
-		cppc_set_perf(cpudata->cpu, &perf_ctrls);
-	}
-	mutex_unlock(&amd_pstate_limits_lock);
-}
-
 static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-
-	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
+	int min_perf;
 
 	if (cpudata->suspended)
 		return 0;
 
-	if (cppc_state == AMD_PSTATE_ACTIVE)
-		amd_pstate_epp_offline(policy);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
+
+	guard(mutex)(&amd_pstate_limits_lock);
+
+	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
+	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
 
 	return 0;
 }
@@ -1689,13 +1651,11 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->suspended) {
-		mutex_lock(&amd_pstate_limits_lock);
+		guard(mutex)(&amd_pstate_limits_lock);
 
 		/* enable amd pstate from suspend state*/
 		amd_pstate_epp_reenable(cpudata);
 
-		mutex_unlock(&amd_pstate_limits_lock);
-
 		cpudata->suspended = false;
 	}
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 70490bf2697b..acabc856fe8a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -922,13 +922,15 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
 		     EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
 		     EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
 		     EFI_MEMORY_NV | EFI_MEMORY_SP | EFI_MEMORY_CPU_CRYPTO |
-		     EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
+		     EFI_MEMORY_MORE_RELIABLE | EFI_MEMORY_HOT_PLUGGABLE |
+		     EFI_MEMORY_RUNTIME))
 		snprintf(pos, size, "|attr=0x%016llx]",
 			 (unsigned long long)attr);
 	else
 		snprintf(pos, size,
-			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
+			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
 			 attr & EFI_MEMORY_RUNTIME		? "RUN" : "",
+			 attr & EFI_MEMORY_HOT_PLUGGABLE	? "HP"  : "",
 			 attr & EFI_MEMORY_MORE_RELIABLE	? "MR"  : "",
 			 attr & EFI_MEMORY_CPU_CRYPTO   	? "CC"  : "",
 			 attr & EFI_MEMORY_SP			? "SP"  : "",
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index c41e7b2091cd..8ad3efb9b1ff 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -25,6 +25,9 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 	if (md->type != EFI_CONVENTIONAL_MEMORY)
 		return 0;
 
+	if (md->attribute & EFI_MEMORY_HOT_PLUGGABLE)
+		return 0;
+
 	if (efi_soft_reserve_enabled() &&
 	    (md->attribute & EFI_MEMORY_SP))
 		return 0;
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index d694bcfa1074..bf676dd127a1 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -53,6 +53,9 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 		if (desc->type != EFI_CONVENTIONAL_MEMORY)
 			continue;
 
+		if (desc->attribute & EFI_MEMORY_HOT_PLUGGABLE)
+			continue;
+
 		if (efi_soft_reserve_enabled() &&
 		    (desc->attribute & EFI_MEMORY_SP))
 			continue;
diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
index 2b4c2826f572..3f10b23ec941 100644
--- a/drivers/firmware/qcom/qcom_scm-smc.c
+++ b/drivers/firmware/qcom/qcom_scm-smc.c
@@ -173,6 +173,9 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		smc.args[i + SCM_SMC_FIRST_REG_IDX] = desc->args[i];
 
 	if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
+		if (!mempool)
+			return -EINVAL;
+
 		args_virt = qcom_tzmem_alloc(mempool,
 					     SCM_SMC_N_EXT_ARGS * sizeof(u64),
 					     flag);
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 5321ef98f442..64908f1a5e7f 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -69,6 +69,22 @@ struct bcm_kona_gpio {
 struct bcm_kona_gpio_bank {
 	int id;
 	int irq;
+	/*
+	 * Used to keep track of lock/unlock operations for each GPIO in the
+	 * bank.
+	 *
+	 * All GPIOs are locked by default (see bcm_kona_gpio_reset), and the
+	 * unlock count for all GPIOs is 0 by default. Each unlock increments
+	 * the counter, and each lock decrements the counter.
+	 *
+	 * The lock function only locks the GPIO once its unlock counter is
+	 * down to 0. This is necessary because the GPIO is unlocked in two
+	 * places in this driver: once for requested GPIOs, and once for
+	 * requested IRQs. Since it is possible for a GPIO to be requested
+	 * as both a GPIO and an IRQ, we need to ensure that we don't lock it
+	 * too early.
+	 */
+	u8 gpio_unlock_count[GPIO_PER_BANK];
 	/* Used in the interrupt handler */
 	struct bcm_kona_gpio *kona_gpio;
 };
@@ -86,14 +102,24 @@ static void bcm_kona_gpio_lock_gpio(struct bcm_kona_gpio *kona_gpio,
 	u32 val;
 	unsigned long flags;
 	int bank_id = GPIO_BANK(gpio);
+	int bit = GPIO_BIT(gpio);
+	struct bcm_kona_gpio_bank *bank = &kona_gpio->banks[bank_id];
 
-	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
+	if (bank->gpio_unlock_count[bit] == 0) {
+		dev_err(kona_gpio->gpio_chip.parent,
+			"Unbalanced locks for GPIO %u\n", gpio);
+		return;
+	}
 
-	val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
-	val |= BIT(gpio);
-	bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
+	if (--bank->gpio_unlock_count[bit] == 0) {
+		raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
-	raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+		val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
+		val |= BIT(bit);
+		bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
+
+		raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+	}
 }
 
 static void bcm_kona_gpio_unlock_gpio(struct bcm_kona_gpio *kona_gpio,
@@ -102,14 +128,20 @@ static void bcm_kona_gpio_unlock_gpio(struct bcm_kona_gpio *kona_gpio,
 	u32 val;
 	unsigned long flags;
 	int bank_id = GPIO_BANK(gpio);
+	int bit = GPIO_BIT(gpio);
+	struct bcm_kona_gpio_bank *bank = &kona_gpio->banks[bank_id];
 
-	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
+	if (bank->gpio_unlock_count[bit] == 0) {
+		raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
-	val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
-	val &= ~BIT(gpio);
-	bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
+		val = readl(kona_gpio->reg_base + GPIO_PWD_STATUS(bank_id));
+		val &= ~BIT(bit);
+		bcm_kona_gpio_write_lock_regs(kona_gpio->reg_base, bank_id, val);
 
-	raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+		raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
+	}
+
+	++bank->gpio_unlock_count[bit];
 }
 
 static int bcm_kona_gpio_get_dir(struct gpio_chip *chip, unsigned gpio)
@@ -360,6 +392,7 @@ static void bcm_kona_gpio_irq_mask(struct irq_data *d)
 
 	kona_gpio = irq_data_get_irq_chip_data(d);
 	reg_base = kona_gpio->reg_base;
+
 	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
 	val = readl(reg_base + GPIO_INT_MASK(bank_id));
@@ -382,6 +415,7 @@ static void bcm_kona_gpio_irq_unmask(struct irq_data *d)
 
 	kona_gpio = irq_data_get_irq_chip_data(d);
 	reg_base = kona_gpio->reg_base;
+
 	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
 
 	val = readl(reg_base + GPIO_INT_MSKCLR(bank_id));
@@ -477,15 +511,26 @@ static void bcm_kona_gpio_irq_handler(struct irq_desc *desc)
 static int bcm_kona_gpio_irq_reqres(struct irq_data *d)
 {
 	struct bcm_kona_gpio *kona_gpio = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = d->hwirq;
 
-	return gpiochip_reqres_irq(&kona_gpio->gpio_chip, d->hwirq);
+	/*
+	 * We need to unlock the GPIO before any other operations are performed
+	 * on the relevant GPIO configuration registers
+	 */
+	bcm_kona_gpio_unlock_gpio(kona_gpio, gpio);
+
+	return gpiochip_reqres_irq(&kona_gpio->gpio_chip, gpio);
 }
 
 static void bcm_kona_gpio_irq_relres(struct irq_data *d)
 {
 	struct bcm_kona_gpio *kona_gpio = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = d->hwirq;
+
+	/* Once we no longer use it, lock the GPIO again */
+	bcm_kona_gpio_lock_gpio(kona_gpio, gpio);
 
-	gpiochip_relres_irq(&kona_gpio->gpio_chip, d->hwirq);
+	gpiochip_relres_irq(&kona_gpio->gpio_chip, gpio);
 }
 
 static struct irq_chip bcm_gpio_irq_chip = {
@@ -614,7 +659,7 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 		bank->irq = platform_get_irq(pdev, i);
 		bank->kona_gpio = kona_gpio;
 		if (bank->irq < 0) {
-			dev_err(dev, "Couldn't get IRQ for bank %d", i);
+			dev_err(dev, "Couldn't get IRQ for bank %d\n", i);
 			ret = -ENOENT;
 			goto err_irq_domain;
 		}
diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 75a3633ceddb..222279a9d82b 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -191,7 +191,7 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 		[REG_IE][CSB] = STMPE_IDX_IEGPIOR_CSB,
 		[REG_IE][MSB] = STMPE_IDX_IEGPIOR_MSB,
 	};
-	int i, j;
+	int ret, i, j;
 
 	/*
 	 * STMPE1600: to be able to get IRQ from pins,
@@ -199,8 +199,16 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 	 * GPSR or GPCR registers
 	 */
 	if (stmpe->partnum == STMPE1600) {
-		stmpe_reg_read(stmpe, stmpe->regs[STMPE_IDX_GPMR_LSB]);
-		stmpe_reg_read(stmpe, stmpe->regs[STMPE_IDX_GPMR_CSB]);
+		ret = stmpe_reg_read(stmpe, stmpe->regs[STMPE_IDX_GPMR_LSB]);
+		if (ret < 0) {
+			dev_err(stmpe->dev, "Failed to read GPMR_LSB: %d\n", ret);
+			goto err;
+		}
+		ret = stmpe_reg_read(stmpe, stmpe->regs[STMPE_IDX_GPMR_CSB]);
+		if (ret < 0) {
+			dev_err(stmpe->dev, "Failed to read GPMR_CSB: %d\n", ret);
+			goto err;
+		}
 	}
 
 	for (i = 0; i < CACHE_NR_REGS; i++) {
@@ -222,6 +230,7 @@ static void stmpe_gpio_irq_sync_unlock(struct irq_data *d)
 		}
 	}
 
+err:
 	mutex_unlock(&stmpe_gpio->irq_lock);
 }
 
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 78ecd56123a3..148b4d1788a2 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1691,6 +1691,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "PNP0C50:00@8",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from GPIO 11
+		 * Found in BIOS 1.04
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3954
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Acer Nitro V 14"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "AMDI0030:00@11",
+		},
+	},
 	{} /* Terminating entry */
 };
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 44372f8647d5..1e8f0bdb6ae3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -905,13 +905,13 @@ int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev)
 	}
 
 	if (gc->ngpio == 0) {
-		chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
+		dev_err(dev, "tried to insert a GPIO chip with zero lines\n");
 		return -EINVAL;
 	}
 
 	if (gc->ngpio > FASTPATH_NGPIO)
-		chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n",
-			gc->ngpio, FASTPATH_NGPIO);
+		dev_warn(dev, "line cnt %u is greater than fast path cnt %u\n",
+			 gc->ngpio, FASTPATH_NGPIO);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b28b2cf1517..d70855d7c61c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3713,9 +3713,10 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 		if (err == -ENODEV) {
 			dev_warn(adev->dev, "cap microcode does not exist, skip\n");
 			err = 0;
-			goto out;
+		} else {
+			dev_err(adev->dev, "fail to initialize cap microcode\n");
 		}
-		dev_err(adev->dev, "fail to initialize cap microcode\n");
+		goto out;
 	}
 
 	info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CAP];
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index dbb63ce316f1..42fd7669ac7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -298,7 +298,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	return 0;
 
 free_gang_ctx_bo:
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, (*q)->gang_ctx_bo);
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, &(*q)->gang_ctx_bo);
 cleanup:
 	uninit_queue(*q);
 	*q = NULL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0c0b9aa44dfa..99d2d3092ea5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -607,7 +607,8 @@ static int smu_sys_set_pp_table(void *handle,
 		return -EIO;
 	}
 
-	if (!smu_table->hardcode_pptable) {
+	if (!smu_table->hardcode_pptable || smu_table->power_play_table_size < size) {
+		kfree(smu_table->hardcode_pptable);
 		smu_table->hardcode_pptable = kzalloc(size, GFP_KERNEL);
 		if (!smu_table->hardcode_pptable)
 			return -ENOMEM;
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 6ee51003de3c..9fa13da513d2 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2421,7 +2421,7 @@ u8 drm_dp_dsc_sink_bpp_incr(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE])
 {
 	u8 bpp_increment_dpcd = dsc_dpcd[DP_DSC_BITS_PER_PIXEL_INC - DP_DSC_SUPPORT];
 
-	switch (bpp_increment_dpcd) {
+	switch (bpp_increment_dpcd & DP_DSC_BITS_PER_PIXEL_MASK) {
 	case DP_DSC_BITS_PER_PIXEL_1_16:
 		return 16;
 	case DP_DSC_BITS_PER_PIXEL_1_8:
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index 5c397a2df70e..5d27e1c733c5 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -168,7 +168,7 @@ static int igt_ppgtt_alloc(void *arg)
 		return PTR_ERR(ppgtt);
 
 	if (!ppgtt->vm.allocate_va_range)
-		goto err_ppgtt_cleanup;
+		goto ppgtt_vm_put;
 
 	/*
 	 * While we only allocate the page tables here and so we could
@@ -236,7 +236,7 @@ static int igt_ppgtt_alloc(void *arg)
 			goto retry;
 	}
 	i915_gem_ww_ctx_fini(&ww);
-
+ppgtt_vm_put:
 	i915_vm_put(&ppgtt->vm);
 	return err;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
index e084406ebb07..4f110be6b750 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
@@ -391,8 +391,8 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
 		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_2,
 		.prog_fetch_lines_worst_case = 24,
-		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
-		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
 	}, {
 		.name = "intf_7", .id = INTF_7,
 		.base = 0x3b000, .len = 0x280,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 16f144cbc0c9..8ff496082902 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -42,9 +42,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
 	if (!conn_state || !conn_state->connector) {
 		DPU_ERROR("invalid connector state\n");
 		return -EINVAL;
-	} else if (conn_state->connector->status != connector_status_connected) {
-		DPU_ERROR("connector not connected %d\n", conn_state->connector->status);
-		return -EINVAL;
 	}
 
 	crtc = conn_state->crtc;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index fba78193127d..f775638d239a 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -787,8 +787,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 			goto out;
 
 		if (!submit->cmd[i].size ||
-			((submit->cmd[i].size + submit->cmd[i].offset) >
-				obj->size / 4)) {
+		    (size_add(submit->cmd[i].size, submit->cmd[i].offset) > obj->size / 4)) {
 			SUBMIT_ERROR(submit, "invalid cmdstream size: %u\n", submit->cmd[i].size * 4);
 			ret = -EINVAL;
 			goto out;
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
index 2dba7c5ffd2c..92f4261305bd 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
@@ -587,7 +587,7 @@ static int rcar_mipi_dsi_startup(struct rcar_mipi_dsi *dsi,
 	for (timeout = 10; timeout > 0; --timeout) {
 		if ((rcar_mipi_dsi_read(dsi, PPICLSR) & PPICLSR_STPST) &&
 		    (rcar_mipi_dsi_read(dsi, PPIDLSR) & PPIDLSR_STPST) &&
-		    (rcar_mipi_dsi_read(dsi, CLOCKSET1) & CLOCKSET1_LOCK))
+		    (rcar_mipi_dsi_read(dsi, CLOCKSET1) & CLOCKSET1_LOCK_PHY))
 			break;
 
 		usleep_range(1000, 2000);
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
index f8114d11f2d1..a6b276f1d6ee 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h
@@ -142,7 +142,6 @@
 
 #define CLOCKSET1			0x101c
 #define CLOCKSET1_LOCK_PHY		(1 << 17)
-#define CLOCKSET1_LOCK			(1 << 16)
 #define CLOCKSET1_CLKSEL		(1 << 8)
 #define CLOCKSET1_CLKINSEL_EXTAL	(0 << 2)
 #define CLOCKSET1_CLKINSEL_DIG		(1 << 2)
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index b99217b4e05d..90c6269ccd29 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -311,11 +311,11 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 	dev->mode_config.helper_private = &rzg2l_du_mode_config_helper;
 
 	/*
-	 * The RZ DU uses the VSP1 for memory access, and is limited
-	 * to frame sizes of 1920x1080.
+	 * The RZ DU was designed to support a frame size of 1920x1200 (landscape)
+	 * or 1200x1920 (portrait).
 	 */
 	dev->mode_config.max_width = 1920;
-	dev->mode_config.max_height = 1080;
+	dev->mode_config.max_height = 1920;
 
 	rcdu->num_crtcs = hweight8(rcdu->info->channels_mask);
 
diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 4ba869e0e794..cbd9584af329 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -70,10 +70,17 @@ static int light_up_connector(struct kunit *test,
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
+retry:
 	conn_state = drm_atomic_get_connector_state(state, connector);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
 	ret = drm_atomic_set_crtc_for_connector(conn_state, crtc);
+	if (ret == -EDEADLK) {
+		drm_atomic_state_clear(state);
+		ret = drm_modeset_backoff(ctx);
+		if (!ret)
+			goto retry;
+	}
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 1ad711f8d2a8..45f22ead3e61 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -700,7 +700,7 @@ void dispc_k2g_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask)
 {
 	dispc_irq_t old_mask = dispc_k2g_read_irqenable(dispc);
 
-	/* clear the irqstatus for newly enabled irqs */
+	/* clear the irqstatus for irqs that will be enabled */
 	dispc_k2g_clear_irqstatus(dispc, (mask ^ old_mask) & mask);
 
 	dispc_k2g_vp_set_irqenable(dispc, 0, mask);
@@ -708,6 +708,9 @@ void dispc_k2g_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask)
 
 	dispc_write(dispc, DISPC_IRQENABLE_SET, (1 << 0) | (1 << 7));
 
+	/* clear the irqstatus for irqs that were disabled */
+	dispc_k2g_clear_irqstatus(dispc, (mask ^ old_mask) & old_mask);
+
 	/* flush posted write */
 	dispc_k2g_read_irqenable(dispc);
 }
@@ -780,24 +783,20 @@ static
 void dispc_k3_clear_irqstatus(struct dispc_device *dispc, dispc_irq_t clearmask)
 {
 	unsigned int i;
-	u32 top_clear = 0;
 
 	for (i = 0; i < dispc->feat->num_vps; ++i) {
-		if (clearmask & DSS_IRQ_VP_MASK(i)) {
+		if (clearmask & DSS_IRQ_VP_MASK(i))
 			dispc_k3_vp_write_irqstatus(dispc, i, clearmask);
-			top_clear |= BIT(i);
-		}
 	}
 	for (i = 0; i < dispc->feat->num_planes; ++i) {
-		if (clearmask & DSS_IRQ_PLANE_MASK(i)) {
+		if (clearmask & DSS_IRQ_PLANE_MASK(i))
 			dispc_k3_vid_write_irqstatus(dispc, i, clearmask);
-			top_clear |= BIT(4 + i);
-		}
 	}
 	if (dispc->feat->subrev == DISPC_K2G)
 		return;
 
-	dispc_write(dispc, DISPC_IRQSTATUS, top_clear);
+	/* always clear the top level irqstatus */
+	dispc_write(dispc, DISPC_IRQSTATUS, dispc_read(dispc, DISPC_IRQSTATUS));
 
 	/* Flush posted writes */
 	dispc_read(dispc, DISPC_IRQSTATUS);
@@ -843,7 +842,7 @@ static void dispc_k3_set_irqenable(struct dispc_device *dispc,
 
 	old_mask = dispc_k3_read_irqenable(dispc);
 
-	/* clear the irqstatus for newly enabled irqs */
+	/* clear the irqstatus for irqs that will be enabled */
 	dispc_k3_clear_irqstatus(dispc, (old_mask ^ mask) & mask);
 
 	for (i = 0; i < dispc->feat->num_vps; ++i) {
@@ -868,6 +867,9 @@ static void dispc_k3_set_irqenable(struct dispc_device *dispc,
 	if (main_disable)
 		dispc_write(dispc, DISPC_IRQENABLE_CLR, main_disable);
 
+	/* clear the irqstatus for irqs that were disabled */
+	dispc_k3_clear_irqstatus(dispc, (old_mask ^ mask) & old_mask);
+
 	/* Flush posted writes */
 	dispc_read(dispc, DISPC_IRQENABLE_SET);
 }
@@ -2767,8 +2769,12 @@ static void dispc_init_errata(struct dispc_device *dispc)
  */
 static void dispc_softreset_k2g(struct dispc_device *dispc)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&dispc->tidss->wait_lock, flags);
 	dispc_set_irqenable(dispc, 0);
 	dispc_read_and_clear_irqstatus(dispc);
+	spin_unlock_irqrestore(&dispc->tidss->wait_lock, flags);
 
 	for (unsigned int vp_idx = 0; vp_idx < dispc->feat->num_vps; ++vp_idx)
 		VP_REG_FLD_MOD(dispc, vp_idx, DISPC_VP_CONTROL, 0, 0, 0);
diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/tidss_irq.c
index 604334ef526a..d053dbb9d28c 100644
--- a/drivers/gpu/drm/tidss/tidss_irq.c
+++ b/drivers/gpu/drm/tidss/tidss_irq.c
@@ -60,7 +60,9 @@ static irqreturn_t tidss_irq_handler(int irq, void *arg)
 	unsigned int id;
 	dispc_irq_t irqstatus;
 
+	spin_lock(&tidss->wait_lock);
 	irqstatus = dispc_read_and_clear_irqstatus(tidss->dispc);
+	spin_unlock(&tidss->wait_lock);
 
 	for (id = 0; id < tidss->num_crtcs; id++) {
 		struct drm_crtc *crtc = tidss->crtcs[id];
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index e3013ac3a5c2..1abfd738a601 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -384,6 +384,7 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
 	struct drm_v3d_perfmon_destroy *req = data;
+	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct v3d_perfmon *perfmon;
 
 	mutex_lock(&v3d_priv->perfmon.lock);
@@ -393,6 +394,10 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 	if (!perfmon)
 		return -EINVAL;
 
+	/* If the active perfmon is being destroyed, stop it first */
+	if (perfmon == v3d->active_perfmon)
+		v3d_perfmon_stop(v3d, perfmon, false);
+
 	v3d_perfmon_put(perfmon);
 
 	return 0;
diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index fb52a23e28f8..a89fbfbdab32 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -135,8 +135,8 @@ void xe_drm_client_add_bo(struct xe_drm_client *client,
 	XE_WARN_ON(bo->client);
 	XE_WARN_ON(!list_empty(&bo->client_link));
 
-	spin_lock(&client->bos_lock);
 	bo->client = xe_drm_client_get(client);
+	spin_lock(&client->bos_lock);
 	list_add_tail(&bo->client_link, &client->bos_list);
 	spin_unlock(&client->bos_lock);
 }
diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
index 9b1a1d4304ae..ba0f61e7d2d6 100644
--- a/drivers/gpu/drm/xe/xe_trace_bo.h
+++ b/drivers/gpu/drm/xe/xe_trace_bo.h
@@ -55,8 +55,8 @@ TRACE_EVENT(xe_bo_move,
 	    TP_STRUCT__entry(
 		     __field(struct xe_bo *, bo)
 		     __field(size_t, size)
-		     __field(u32, new_placement)
-		     __field(u32, old_placement)
+		     __string(new_placement_name, xe_mem_type_to_name[new_placement])
+		     __string(old_placement_name, xe_mem_type_to_name[old_placement])
 		     __string(device_id, __dev_name_bo(bo))
 		     __field(bool, move_lacks_source)
 			),
@@ -64,15 +64,15 @@ TRACE_EVENT(xe_bo_move,
 	    TP_fast_assign(
 		   __entry->bo      = bo;
 		   __entry->size = bo->size;
-		   __entry->new_placement = new_placement;
-		   __entry->old_placement = old_placement;
+		   __assign_str(new_placement_name);
+		   __assign_str(old_placement_name);
 		   __assign_str(device_id);
 		   __entry->move_lacks_source = move_lacks_source;
 		   ),
 	    TP_printk("move_lacks_source:%s, migrate object %p [size %zu] from %s to %s device_id:%s",
 		      __entry->move_lacks_source ? "yes" : "no", __entry->bo, __entry->size,
-		      xe_mem_type_to_name[__entry->old_placement],
-		      xe_mem_type_to_name[__entry->new_placement], __get_str(device_id))
+		      __get_str(old_placement_name),
+		      __get_str(new_placement_name), __get_str(device_id))
 );
 
 DECLARE_EVENT_CLASS(xe_vma,
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index e98528777faa..710674ef40a9 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -625,6 +625,8 @@ static int host1x_probe(struct platform_device *pdev)
 		goto free_contexts;
 	}
 
+	mutex_init(&host->intr_mutex);
+
 	pm_runtime_enable(&pdev->dev);
 
 	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
diff --git a/drivers/gpu/host1x/intr.c b/drivers/gpu/host1x/intr.c
index b3285dd10180..f77a678949e9 100644
--- a/drivers/gpu/host1x/intr.c
+++ b/drivers/gpu/host1x/intr.c
@@ -104,8 +104,6 @@ int host1x_intr_init(struct host1x *host)
 	unsigned int id;
 	int i, err;
 
-	mutex_init(&host->intr_mutex);
-
 	for (id = 0; id < host1x_syncpt_nb_pts(host); ++id) {
 		struct host1x_syncpt *syncpt = &host->syncpt[id];
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 369414c92fcc..93b5c648ef82 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1673,9 +1673,12 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		break;
 	}
 
-	if (suffix)
+	if (suffix) {
 		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						 "%s %s", hdev->name, suffix);
+		if (!hi->input->name)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index bf8b633114be..7b3596689878 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -313,6 +313,7 @@ struct steam_device {
 	u16 rumble_left;
 	u16 rumble_right;
 	unsigned int sensor_timestamp_us;
+	struct work_struct unregister_work;
 };
 
 static int steam_recv_report(struct steam_device *steam,
@@ -1072,6 +1073,31 @@ static void steam_mode_switch_cb(struct work_struct *work)
 	}
 }
 
+static void steam_work_unregister_cb(struct work_struct *work)
+{
+	struct steam_device *steam = container_of(work, struct steam_device,
+							unregister_work);
+	unsigned long flags;
+	bool connected;
+	bool opened;
+
+	spin_lock_irqsave(&steam->lock, flags);
+	opened = steam->client_opened;
+	connected = steam->connected;
+	spin_unlock_irqrestore(&steam->lock, flags);
+
+	if (connected) {
+		if (opened) {
+			steam_sensors_unregister(steam);
+			steam_input_unregister(steam);
+		} else {
+			steam_set_lizard_mode(steam, lizard_mode);
+			steam_input_register(steam);
+			steam_sensors_register(steam);
+		}
+	}
+}
+
 static bool steam_is_valve_interface(struct hid_device *hdev)
 {
 	struct hid_report_enum *rep_enum;
@@ -1117,8 +1143,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	steam->client_opened++;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	steam_sensors_unregister(steam);
-	steam_input_unregister(steam);
+	schedule_work(&steam->unregister_work);
 
 	return 0;
 }
@@ -1135,11 +1160,7 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	connected = steam->connected && !steam->client_opened;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	if (connected) {
-		steam_set_lizard_mode(steam, lizard_mode);
-		steam_input_register(steam);
-		steam_sensors_register(steam);
-	}
+	schedule_work(&steam->unregister_work);
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
@@ -1231,6 +1252,7 @@ static int steam_probe(struct hid_device *hdev,
 	INIT_LIST_HEAD(&steam->list);
 	INIT_WORK(&steam->rumble_work, steam_haptic_rumble_cb);
 	steam->sensor_timestamp_us = 0;
+	INIT_WORK(&steam->unregister_work, steam_work_unregister_cb);
 
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
@@ -1291,6 +1313,7 @@ static int steam_probe(struct hid_device *hdev,
 	cancel_work_sync(&steam->work_connect);
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
+	cancel_work_sync(&steam->unregister_work);
 
 	return ret;
 }
@@ -1306,6 +1329,8 @@ static void steam_remove(struct hid_device *hdev)
 
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->work_connect);
+	cancel_work_sync(&steam->rumble_work);
+	cancel_work_sync(&steam->unregister_work);
 	hid_destroy_device(steam->client_hdev);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
@@ -1592,7 +1617,7 @@ static void steam_do_deck_input_event(struct steam_device *steam,
 
 	if (!(b9 & BIT(6)) && steam->did_mode_switch) {
 		steam->did_mode_switch = false;
-		cancel_delayed_work_sync(&steam->mode_switch);
+		cancel_delayed_work(&steam->mode_switch);
 	} else if (!steam->client_opened && (b9 & BIT(6)) && !steam->did_mode_switch) {
 		steam->did_mode_switch = true;
 		schedule_delayed_work(&steam->mode_switch, 45 * HZ / 100);
diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
index 6c3e758bbb09..3b81468a1df2 100644
--- a/drivers/hid/hid-thrustmaster.c
+++ b/drivers/hid/hid-thrustmaster.c
@@ -171,7 +171,7 @@ static void thrustmaster_interrupts(struct hid_device *hdev)
 	b_ep = ep->desc.bEndpointAddress;
 
 	/* Are the expected endpoints present? */
-	u8 ep_addr[1] = {b_ep};
+	u8 ep_addr[2] = {b_ep, 0};
 
 	if (!usb_check_int_endpoints(usbif, ep_addr)) {
 		hid_err(hdev, "Unexpected non-int endpoint\n");
diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index 831b760c66ea..d4afbbd27807 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -106,6 +106,8 @@ static int winwing_init_led(struct hid_device *hdev,
 						"%s::%s",
 						dev_name(&input->dev),
 						info->led_name);
+		if (!led->cdev.name)
+			return -ENOMEM;
 
 		ret = devm_led_classdev_register(&hdev->dev, &led->cdev);
 		if (ret)
diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index 90dee3ec5520..77da199c7413 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -57,3 +57,14 @@ config MIPI_I3C_HCI
 
 	  This driver can also be built as a module.  If so, the module will be
 	  called mipi-i3c-hci.
+
+config MIPI_I3C_HCI_PCI
+	tristate "MIPI I3C Host Controller Interface PCI support"
+	depends on MIPI_I3C_HCI
+	depends on PCI
+	help
+	  Support for MIPI I3C Host Controller Interface compatible hardware
+	  on the PCI bus.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mipi-i3c-hci-pci.
diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile b/drivers/i3c/master/mipi-i3c-hci/Makefile
index 1f8cd5c48fde..e3d3ef757035 100644
--- a/drivers/i3c/master/mipi-i3c-hci/Makefile
+++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
@@ -5,3 +5,4 @@ mipi-i3c-hci-y				:= core.o ext_caps.o pio.o dma.o \
 					   cmd_v1.o cmd_v2.o \
 					   dat_v1.o dct_v1.o \
 					   hci_quirks.o
+obj-$(CONFIG_MIPI_I3C_HCI_PCI)		+= mipi-i3c-hci-pci.o
diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 13adc5840094..fe955703e59b 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -762,9 +762,26 @@ static bool hci_dma_irq_handler(struct i3c_hci *hci, unsigned int mask)
 			complete(&rh->op_done);
 
 		if (status & INTR_TRANSFER_ABORT) {
+			u32 ring_status;
+
 			dev_notice_ratelimited(&hci->master.dev,
 				"ring %d: Transfer Aborted\n", i);
 			mipi_i3c_hci_resume(hci);
+			ring_status = rh_reg_read(RING_STATUS);
+			if (!(ring_status & RING_STATUS_RUNNING) &&
+			    status & INTR_TRANSFER_COMPLETION &&
+			    status & INTR_TRANSFER_ERR) {
+				/*
+				 * Ring stop followed by run is an Intel
+				 * specific required quirk after resuming the
+				 * halted controller. Do it only when the ring
+				 * is not in running state after a transfer
+				 * error.
+				 */
+				rh_reg_write(RING_CONTROL, RING_CTRL_ENABLE);
+				rh_reg_write(RING_CONTROL, RING_CTRL_ENABLE |
+							   RING_CTRL_RUN_STOP);
+			}
 		}
 		if (status & INTR_WARN_INS_STOP_MODE)
 			dev_warn_ratelimited(&hci->master.dev,
diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
new file mode 100644
index 000000000000..c6c3a3ec11ea
--- /dev/null
+++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI glue code for MIPI I3C HCI driver
+ *
+ * Copyright (C) 2024 Intel Corporation
+ *
+ * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ */
+#include <linux/acpi.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+struct mipi_i3c_hci_pci_info {
+	int (*init)(struct pci_dev *pci);
+};
+
+#define INTEL_PRIV_OFFSET		0x2b0
+#define INTEL_PRIV_SIZE			0x28
+#define INTEL_PRIV_RESETS		0x04
+#define INTEL_PRIV_RESETS_RESET		BIT(0)
+#define INTEL_PRIV_RESETS_RESET_DONE	BIT(1)
+
+static DEFINE_IDA(mipi_i3c_hci_pci_ida);
+
+static int mipi_i3c_hci_pci_intel_init(struct pci_dev *pci)
+{
+	unsigned long timeout;
+	void __iomem *priv;
+
+	priv = devm_ioremap(&pci->dev,
+			    pci_resource_start(pci, 0) + INTEL_PRIV_OFFSET,
+			    INTEL_PRIV_SIZE);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Assert reset, wait for completion and release reset */
+	writel(0, priv + INTEL_PRIV_RESETS);
+	timeout = jiffies + msecs_to_jiffies(10);
+	while (!(readl(priv + INTEL_PRIV_RESETS) &
+		 INTEL_PRIV_RESETS_RESET_DONE)) {
+		if (time_after(jiffies, timeout))
+			break;
+		cpu_relax();
+	}
+	writel(INTEL_PRIV_RESETS_RESET, priv + INTEL_PRIV_RESETS);
+
+	return 0;
+}
+
+static struct mipi_i3c_hci_pci_info intel_info = {
+	.init = mipi_i3c_hci_pci_intel_init,
+};
+
+static int mipi_i3c_hci_pci_probe(struct pci_dev *pci,
+				  const struct pci_device_id *id)
+{
+	struct mipi_i3c_hci_pci_info *info;
+	struct platform_device *pdev;
+	struct resource res[2];
+	int dev_id, ret;
+
+	ret = pcim_enable_device(pci);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci);
+
+	memset(&res, 0, sizeof(res));
+
+	res[0].flags = IORESOURCE_MEM;
+	res[0].start = pci_resource_start(pci, 0);
+	res[0].end = pci_resource_end(pci, 0);
+
+	res[1].flags = IORESOURCE_IRQ;
+	res[1].start = pci->irq;
+	res[1].end = pci->irq;
+
+	dev_id = ida_alloc(&mipi_i3c_hci_pci_ida, GFP_KERNEL);
+	if (dev_id < 0)
+		return dev_id;
+
+	pdev = platform_device_alloc("mipi-i3c-hci", dev_id);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->dev.parent = &pci->dev;
+	device_set_node(&pdev->dev, dev_fwnode(&pci->dev));
+
+	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret)
+		goto err;
+
+	info = (struct mipi_i3c_hci_pci_info *)id->driver_data;
+	if (info && info->init) {
+		ret = info->init(pci);
+		if (ret)
+			goto err;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto err;
+
+	pci_set_drvdata(pci, pdev);
+
+	return 0;
+
+err:
+	platform_device_put(pdev);
+	ida_free(&mipi_i3c_hci_pci_ida, dev_id);
+	return ret;
+}
+
+static void mipi_i3c_hci_pci_remove(struct pci_dev *pci)
+{
+	struct platform_device *pdev = pci_get_drvdata(pci);
+	int dev_id = pdev->id;
+
+	platform_device_unregister(pdev);
+	ida_free(&mipi_i3c_hci_pci_ida, dev_id);
+}
+
+static const struct pci_device_id mipi_i3c_hci_pci_devices[] = {
+	/* Panther Lake-H */
+	{ PCI_VDEVICE(INTEL, 0xe37c), (kernel_ulong_t)&intel_info},
+	{ PCI_VDEVICE(INTEL, 0xe36f), (kernel_ulong_t)&intel_info},
+	/* Panther Lake-P */
+	{ PCI_VDEVICE(INTEL, 0xe47c), (kernel_ulong_t)&intel_info},
+	{ PCI_VDEVICE(INTEL, 0xe46f), (kernel_ulong_t)&intel_info},
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, mipi_i3c_hci_pci_devices);
+
+static struct pci_driver mipi_i3c_hci_pci_driver = {
+	.name = "mipi_i3c_hci_pci",
+	.id_table = mipi_i3c_hci_pci_devices,
+	.probe = mipi_i3c_hci_pci_probe,
+	.remove = mipi_i3c_hci_pci_remove,
+};
+
+module_pci_driver(mipi_i3c_hci_pci_driver);
+
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MIPI I3C HCI driver on PCI bus");
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index ad225823e6f2..45a4564c670c 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -470,7 +470,6 @@ static void efa_ib_device_remove(struct efa_dev *dev)
 	ibdev_info(&dev->ibdev, "Unregister ib device\n");
 	ib_unregister_device(&dev->ibdev);
 	efa_destroy_eqs(dev);
-	efa_com_dev_reset(&dev->edev, EFA_REGS_RESET_NORMAL);
 	efa_release_doorbell_bar(dev);
 }
 
@@ -643,12 +642,14 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
 	return ERR_PTR(err);
 }
 
-static void efa_remove_device(struct pci_dev *pdev)
+static void efa_remove_device(struct pci_dev *pdev,
+			      enum efa_regs_reset_reason_types reset_reason)
 {
 	struct efa_dev *dev = pci_get_drvdata(pdev);
 	struct efa_com_dev *edev;
 
 	edev = &dev->edev;
+	efa_com_dev_reset(edev, reset_reason);
 	efa_com_admin_destroy(edev);
 	efa_free_irq(dev, &dev->admin_irq);
 	efa_disable_msix(dev);
@@ -676,7 +677,7 @@ static int efa_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err_remove_device:
-	efa_remove_device(pdev);
+	efa_remove_device(pdev, EFA_REGS_RESET_INIT_ERR);
 	return err;
 }
 
@@ -685,7 +686,7 @@ static void efa_remove(struct pci_dev *pdev)
 	struct efa_dev *dev = pci_get_drvdata(pdev);
 
 	efa_ib_device_remove(dev);
-	efa_remove_device(pdev);
+	efa_remove_device(pdev, EFA_REGS_RESET_NORMAL);
 }
 
 static void efa_shutdown(struct pci_dev *pdev)
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 601fb4ee6900..6fb2f2919ab1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -175,6 +175,7 @@
 #define CONTROL_GAM_EN		25
 #define CONTROL_GALOG_EN	28
 #define CONTROL_GAINT_EN	29
+#define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
 #define CONTROL_IRTCACHEDIS	59
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 43131c3a2172..dbe2d13972fe 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2647,6 +2647,10 @@ static void iommu_init_flags(struct amd_iommu *iommu)
 
 	/* Set IOTLB invalidation timeout to 1s */
 	iommu_set_inv_tlb_timeout(iommu, CTRL_INV_TO_1S);
+
+	/* Enable Enhanced Peripheral Page Request Handling */
+	if (check_feature(FEATURE_EPHSUP))
+		iommu_feature_enable(iommu, CONTROL_EPH_EN);
 }
 
 static void iommu_apply_resume_quirks(struct amd_iommu *iommu)
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 4674e618797c..8b5926c1452e 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -478,6 +478,7 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 
 		ops->page_response(dev, iopf, &resp);
 		list_del_init(&group->pending_node);
+		iopf_free_group(group);
 	}
 	mutex_unlock(&fault_param->lock);
 
diff --git a/drivers/media/dvb-frontends/cxd2841er.c b/drivers/media/dvb-frontends/cxd2841er.c
index d925ca24183b..415f1f91cc30 100644
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -311,12 +311,8 @@ static int cxd2841er_set_reg_bits(struct cxd2841er_priv *priv,
 
 static u32 cxd2841er_calc_iffreq_xtal(enum cxd2841er_xtal xtal, u32 ifhz)
 {
-	u64 tmp;
-
-	tmp = (u64) ifhz * 16777216;
-	do_div(tmp, ((xtal == SONY_XTAL_24000) ? 48000000 : 41000000));
-
-	return (u32) tmp;
+	return div_u64(ifhz * 16777216ull,
+		       (xtal == SONY_XTAL_24000) ? 48000000 : 41000000);
 }
 
 static u32 cxd2841er_calc_iffreq(u32 ifhz)
diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
index b5375d736629..7670d6c82d92 100644
--- a/drivers/media/i2c/ds90ub913.c
+++ b/drivers/media/i2c/ds90ub913.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2023 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -146,6 +147,19 @@ static int ub913_write(const struct ub913_data *priv, u8 reg, u8 val)
 	return ret;
 }
 
+static int ub913_update_bits(const struct ub913_data *priv, u8 reg, u8 mask,
+			     u8 val)
+{
+	int ret;
+
+	ret = regmap_update_bits(priv->regmap, reg, mask, val);
+	if (ret < 0)
+		dev_err(&priv->client->dev,
+			"Cannot update register 0x%02x %d!\n", reg, ret);
+
+	return ret;
+}
+
 /*
  * GPIO chip
  */
@@ -733,10 +747,13 @@ static int ub913_hw_init(struct ub913_data *priv)
 	if (ret)
 		return dev_err_probe(dev, ret, "i2c master init failed\n");
 
-	ub913_read(priv, UB913_REG_GENERAL_CFG, &v);
-	v &= ~UB913_REG_GENERAL_CFG_PCLK_RISING;
-	v |= priv->pclk_polarity_rising ? UB913_REG_GENERAL_CFG_PCLK_RISING : 0;
-	ub913_write(priv, UB913_REG_GENERAL_CFG, v);
+	ret = ub913_update_bits(priv, UB913_REG_GENERAL_CFG,
+				UB913_REG_GENERAL_CFG_PCLK_RISING,
+				FIELD_PREP(UB913_REG_GENERAL_CFG_PCLK_RISING,
+					   priv->pclk_polarity_rising));
+
+	if (ret)
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index 10daecf6f457..f0bad3e64f23 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -398,8 +398,13 @@ static int ub953_gpiochip_probe(struct ub953_data *priv)
 	int ret;
 
 	/* Set all GPIOs to local input mode */
-	ub953_write(priv, UB953_REG_LOCAL_GPIO_DATA, 0);
-	ub953_write(priv, UB953_REG_GPIO_INPUT_CTRL, 0xf);
+	ret = ub953_write(priv, UB953_REG_LOCAL_GPIO_DATA, 0);
+	if (ret)
+		return ret;
+
+	ret = ub953_write(priv, UB953_REG_GPIO_INPUT_CTRL, 0xf);
+	if (ret)
+		return ret;
 
 	gc->label = dev_name(dev);
 	gc->parent = dev;
@@ -961,10 +966,11 @@ static void ub953_calc_clkout_params(struct ub953_data *priv,
 	clkout_data->rate = clkout_rate;
 }
 
-static void ub953_write_clkout_regs(struct ub953_data *priv,
-				    const struct ub953_clkout_data *clkout_data)
+static int ub953_write_clkout_regs(struct ub953_data *priv,
+				   const struct ub953_clkout_data *clkout_data)
 {
 	u8 clkout_ctrl0, clkout_ctrl1;
+	int ret;
 
 	if (priv->hw_data->is_ub971)
 		clkout_ctrl0 = clkout_data->m;
@@ -974,8 +980,15 @@ static void ub953_write_clkout_regs(struct ub953_data *priv,
 
 	clkout_ctrl1 = clkout_data->n;
 
-	ub953_write(priv, UB953_REG_CLKOUT_CTRL0, clkout_ctrl0);
-	ub953_write(priv, UB953_REG_CLKOUT_CTRL1, clkout_ctrl1);
+	ret = ub953_write(priv, UB953_REG_CLKOUT_CTRL0, clkout_ctrl0);
+	if (ret)
+		return ret;
+
+	ret = ub953_write(priv, UB953_REG_CLKOUT_CTRL1, clkout_ctrl1);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static unsigned long ub953_clkout_recalc_rate(struct clk_hw *hw,
@@ -1055,9 +1068,7 @@ static int ub953_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
 	dev_dbg(&priv->client->dev, "%s %lu (requested %lu)\n", __func__,
 		clkout_data.rate, rate);
 
-	ub953_write_clkout_regs(priv, &clkout_data);
-
-	return 0;
+	return ub953_write_clkout_regs(priv, &clkout_data);
 }
 
 static const struct clk_ops ub953_clkout_ops = {
@@ -1082,7 +1093,9 @@ static int ub953_register_clkout(struct ub953_data *priv)
 
 	/* Initialize clkout to 25MHz by default */
 	ub953_calc_clkout_params(priv, UB953_DEFAULT_CLKOUT_RATE, &clkout_data);
-	ub953_write_clkout_regs(priv, &clkout_data);
+	ret = ub953_write_clkout_regs(priv, &clkout_data);
+	if (ret)
+		return ret;
 
 	priv->clkout_clk_hw.init = &init;
 
@@ -1229,10 +1242,15 @@ static int ub953_hw_init(struct ub953_data *priv)
 	if (ret)
 		return dev_err_probe(dev, ret, "i2c init failed\n");
 
-	ub953_write(priv, UB953_REG_GENERAL_CFG,
-		    (priv->non_continous_clk ? 0 : UB953_REG_GENERAL_CFG_CONT_CLK) |
-		    ((priv->num_data_lanes - 1) << UB953_REG_GENERAL_CFG_CSI_LANE_SEL_SHIFT) |
-		    UB953_REG_GENERAL_CFG_CRC_TX_GEN_ENABLE);
+	v = 0;
+	v |= priv->non_continous_clk ? 0 : UB953_REG_GENERAL_CFG_CONT_CLK;
+	v |= (priv->num_data_lanes - 1) <<
+		UB953_REG_GENERAL_CFG_CSI_LANE_SEL_SHIFT;
+	v |= UB953_REG_GENERAL_CFG_CRC_TX_GEN_ENABLE;
+
+	ret = ub953_write(priv, UB953_REG_GENERAL_CFG, v);
+	if (ret)
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index a1d93c14553d..9f81e1582a30 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -816,11 +816,6 @@ static irqreturn_t unicam_isr(int irq, void *dev)
 		}
 	}
 
-	if (unicam_reg_read(unicam, UNICAM_ICTL) & UNICAM_FCM) {
-		/* Switch out of trigger mode if selected */
-		unicam_reg_write_field(unicam, UNICAM_ICTL, 1, UNICAM_TFC);
-		unicam_reg_write_field(unicam, UNICAM_ICTL, 0, UNICAM_FCM);
-	}
 	return IRQ_HANDLED;
 }
 
@@ -984,8 +979,7 @@ static void unicam_start_rx(struct unicam_device *unicam,
 
 	unicam_reg_write_field(unicam, UNICAM_ANA, 0, UNICAM_DDL);
 
-	/* Always start in trigger frame capture mode (UNICAM_FCM set) */
-	val = UNICAM_FSIE | UNICAM_FEIE | UNICAM_FCM | UNICAM_IBOB;
+	val = UNICAM_FSIE | UNICAM_FEIE | UNICAM_IBOB;
 	line_int_freq = max(fmt->height >> 2, 128);
 	unicam_set_field(&val, line_int_freq, UNICAM_LCIE_MASK);
 	unicam_reg_write(unicam, UNICAM_ICTL, val);
diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index 613949df897d..6d964e392d31 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -191,10 +191,11 @@ static int vidtv_start_streaming(struct vidtv_dvb *dvb)
 
 	mux_args.mux_buf_sz  = mux_buf_sz;
 
-	dvb->streaming = true;
 	dvb->mux = vidtv_mux_init(dvb->fe[0], dev, &mux_args);
 	if (!dvb->mux)
 		return -ENOMEM;
+
+	dvb->streaming = true;
 	vidtv_mux_start_thread(dvb->mux);
 
 	dev_dbg_ratelimited(dev, "Started streaming\n");
@@ -205,6 +206,11 @@ static int vidtv_stop_streaming(struct vidtv_dvb *dvb)
 {
 	struct device *dev = &dvb->pdev->dev;
 
+	if (!dvb->streaming) {
+		dev_warn_ratelimited(dev, "No streaming. Skipping.\n");
+		return 0;
+	}
+
 	dvb->streaming = false;
 	vidtv_mux_stop_thread(dvb->mux);
 	vidtv_mux_destroy(dvb->mux);
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index d832aa55056f..4d8e00b425f4 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2809,6 +2809,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_quirk_probe_minmax },
+	/* Sonix Technology Co. Ltd. - 292A IPC AR0330 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x0c45,
+	  .idProduct		= 0x6366,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_MJPEG_NO_EOF) },
 	/* MT6227 */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
@@ -2837,6 +2846,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_quirk_probe_minmax },
+	/* Kurokesu C1 PRO */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x16d0,
+	  .idProduct		= 0x0ed1,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_MJPEG_NO_EOF) },
 	/* Syntek (HP Spartan) */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d2fe01bcd209..eab7b8f55730 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <linux/unaligned.h>
 
+#include <media/jpeg.h>
 #include <media/v4l2-common.h>
 
 #include "uvcvideo.h"
@@ -1137,6 +1138,7 @@ static void uvc_video_stats_stop(struct uvc_streaming *stream)
 static int uvc_video_decode_start(struct uvc_streaming *stream,
 		struct uvc_buffer *buf, const u8 *data, int len)
 {
+	u8 header_len;
 	u8 fid;
 
 	/*
@@ -1150,6 +1152,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EINVAL;
 	}
 
+	header_len = data[0];
 	fid = data[1] & UVC_STREAM_FID;
 
 	/*
@@ -1231,9 +1234,31 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EAGAIN;
 	}
 
+	/*
+	 * Some cameras, when running two parallel streams (one MJPEG alongside
+	 * another non-MJPEG stream), are known to lose the EOF packet for a frame.
+	 * We can detect the end of a frame by checking for a new SOI marker, as
+	 * the SOI always lies on the packet boundary between two frames for
+	 * these devices.
+	 */
+	if (stream->dev->quirks & UVC_QUIRK_MJPEG_NO_EOF &&
+	    (stream->cur_format->fcc == V4L2_PIX_FMT_MJPEG ||
+	    stream->cur_format->fcc == V4L2_PIX_FMT_JPEG)) {
+		const u8 *packet = data + header_len;
+
+		if (len >= header_len + 2 &&
+		    packet[0] == 0xff && packet[1] == JPEG_MARKER_SOI &&
+		    buf->bytesused != 0) {
+			buf->state = UVC_BUF_STATE_READY;
+			buf->error = 1;
+			stream->last_fid ^= UVC_STREAM_FID;
+			return -EAGAIN;
+		}
+	}
+
 	stream->last_fid = fid;
 
-	return data[0];
+	return header_len;
 }
 
 static inline enum dma_data_direction uvc_stream_dir(
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 272dc9cf01ee..74ac2106f08e 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -76,6 +76,7 @@
 #define UVC_QUIRK_NO_RESET_RESUME	0x00004000
 #define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00008000
 #define UVC_QUIRK_INVALID_DEVICE_SOF	0x00010000
+#define UVC_QUIRK_MJPEG_NO_EOF		0x00020000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6e62415de2e5..d5d868cb4edc 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -263,6 +263,7 @@
 #define MSDC_PAD_TUNE_CMD2_SEL	  BIT(21)   /* RW */
 
 #define PAD_DS_TUNE_DLY_SEL       BIT(0)	  /* RW */
+#define PAD_DS_TUNE_DLY2_SEL      BIT(1)	  /* RW */
 #define PAD_DS_TUNE_DLY1	  GENMASK(6, 2)   /* RW */
 #define PAD_DS_TUNE_DLY2	  GENMASK(11, 7)  /* RW */
 #define PAD_DS_TUNE_DLY3	  GENMASK(16, 12) /* RW */
@@ -308,6 +309,7 @@
 
 /* EMMC50_PAD_DS_TUNE mask */
 #define PAD_DS_DLY_SEL		BIT(16)	/* RW */
+#define PAD_DS_DLY2_SEL		BIT(15)	/* RW */
 #define PAD_DS_DLY1		GENMASK(14, 10)	/* RW */
 #define PAD_DS_DLY3		GENMASK(4, 0)	/* RW */
 
@@ -2361,13 +2363,23 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct msdc_host *host = mmc_priv(mmc);
+
 	host->hs400_mode = true;
 
-	if (host->top_base)
-		writel(host->hs400_ds_delay,
-		       host->top_base + EMMC50_PAD_DS_TUNE);
-	else
-		writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
+	if (host->top_base) {
+		if (host->hs400_ds_dly3)
+			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
+				      PAD_DS_DLY3, host->hs400_ds_dly3);
+		if (host->hs400_ds_delay)
+			writel(host->hs400_ds_delay,
+			       host->top_base + EMMC50_PAD_DS_TUNE);
+	} else {
+		if (host->hs400_ds_dly3)
+			sdr_set_field(host->base + PAD_DS_TUNE,
+				      PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
+		if (host->hs400_ds_delay)
+			writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
+	}
 	/* hs400 mode must set it to 0 */
 	sdr_clr_bits(host->base + MSDC_PATCH_BIT2, MSDC_PATCH_BIT2_CFGCRCSTS);
 	/* to improve read performance, set outstanding to 2 */
@@ -2387,14 +2399,11 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
 	if (host->top_base) {
 		sdr_set_bits(host->top_base + EMMC50_PAD_DS_TUNE,
 			     PAD_DS_DLY_SEL);
-		if (host->hs400_ds_dly3)
-			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
-				      PAD_DS_DLY3, host->hs400_ds_dly3);
+		sdr_clr_bits(host->top_base + EMMC50_PAD_DS_TUNE,
+			     PAD_DS_DLY2_SEL);
 	} else {
 		sdr_set_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY_SEL);
-		if (host->hs400_ds_dly3)
-			sdr_set_field(host->base + PAD_DS_TUNE,
-				      PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
+		sdr_clr_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY2_SEL);
 	}
 
 	host->hs400_tuning = true;
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 6cba9717a6d8..399844809bbe 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -385,15 +385,16 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
 			KBUILD_MODNAME, ret);
-		goto exit_free_device;
+		goto exit_pm_runtime;
 	}
 
 	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
 		 KBUILD_MODNAME, priv->base, dev->irq);
 	return 0;
 
-exit_free_device:
+exit_pm_runtime:
 	pm_runtime_disable(priv->device);
+exit_free_device:
 	free_c_can_dev(dev);
 exit:
 	dev_err(&pdev->dev, "probe failed\n");
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 64c349fd4600..f65c1a1e05cc 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -867,10 +867,12 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 			}
 			break;
 		case CAN_STATE_ERROR_ACTIVE:
-			cf->can_id |= CAN_ERR_CNT;
-			cf->data[1] = CAN_ERR_CRTL_ACTIVE;
-			cf->data[6] = bec.txerr;
-			cf->data[7] = bec.rxerr;
+			if (skb) {
+				cf->can_id |= CAN_ERR_CNT;
+				cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+				cf->data[6] = bec.txerr;
+				cf->data[7] = bec.rxerr;
+			}
 			break;
 		default:
 			netdev_warn(ndev, "unhandled error state (%d:%s)!\n",
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index df18c85fc078..d9a937ba126c 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -622,7 +622,7 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 	netdev_dbg(priv->ndev, "RX-FIFO overflow\n");
 
 	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
-	if (skb)
+	if (!skb)
 		return 0;
 
 	rkcanfd_get_berr_counter_corrected(priv, &bec);
diff --git a/drivers/net/can/usb/etas_es58x/es58x_devlink.c b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
index eee20839d96f..0d155eb1b9e9 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_devlink.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
@@ -248,7 +248,11 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 			return ret;
 	}
 
-	return devlink_info_serial_number_put(req, es58x_dev->udev->serial);
+	if (es58x_dev->udev->serial)
+		ret = devlink_info_serial_number_put(req,
+						     es58x_dev->udev->serial);
+
+	return ret;
 }
 
 const struct devlink_ops es58x_dl_ops = {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index b4fbb99bfad2..a3d6b8f198a8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2159,8 +2159,13 @@ static int idpf_open(struct net_device *netdev)
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
+	err = idpf_set_real_num_queues(vport);
+	if (err)
+		goto unlock;
+
 	err = idpf_vport_open(vport);
 
+unlock:
 	idpf_vport_ctrl_unlock(netdev);
 
 	return err;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 60d15b3e6e2f..1e0d1f9b07fb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3008,8 +3008,6 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 		return -EINVAL;
 
 	rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
-	if (unlikely(rsc_segments == 1))
-		return 0;
 
 	NAPI_GRO_CB(skb)->count = rsc_segments;
 	skb_shinfo(skb)->gso_size = rsc_seg_len;
@@ -3072,6 +3070,7 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	idpf_rx_hash(rxq, skb, rx_desc, decoded);
 
 	skb->protocol = eth_type_trans(skb, rxq->netdev);
+	skb_record_rx_queue(skb, rxq->idx);
 
 	if (le16_get_bits(rx_desc->hdrlen_flags,
 			  VIRTCHNL2_RX_FLEX_DESC_ADV_RSC_M))
@@ -3080,8 +3079,6 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	csum_bits = idpf_rx_splitq_extract_csum_bits(rx_desc);
 	idpf_rx_csum(rxq, skb, csum_bits, decoded);
 
-	skb_record_rx_queue(skb, rxq->idx);
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6e70bca15db1..1ec9e8cc99d9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1096,6 +1096,7 @@ static int igc_init_empty_frame(struct igc_ring *ring,
 		return -ENOMEM;
 	}
 
+	buffer->type = IGC_TX_BUFFER_TYPE_SKB;
 	buffer->skb = skb;
 	buffer->protocol = 0;
 	buffer->bytecount = skb->len;
@@ -2707,8 +2708,9 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 }
 
 static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
-					    struct xdp_buff *xdp)
+					    struct igc_xdp_buff *ctx)
 {
+	struct xdp_buff *xdp = &ctx->xdp;
 	unsigned int totalsize = xdp->data_end - xdp->data_meta;
 	unsigned int metasize = xdp->data - xdp->data_meta;
 	struct sk_buff *skb;
@@ -2727,27 +2729,28 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 		__skb_pull(skb, metasize);
 	}
 
+	if (ctx->rx_ts) {
+		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
+		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
+	}
+
 	return skb;
 }
 
 static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
 				union igc_adv_rx_desc *desc,
-				struct xdp_buff *xdp,
-				ktime_t timestamp)
+				struct igc_xdp_buff *ctx)
 {
 	struct igc_ring *ring = q_vector->rx.ring;
 	struct sk_buff *skb;
 
-	skb = igc_construct_skb_zc(ring, xdp);
+	skb = igc_construct_skb_zc(ring, ctx);
 	if (!skb) {
 		ring->rx_stats.alloc_failed++;
 		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);
 		return;
 	}
 
-	if (timestamp)
-		skb_hwtstamps(skb)->hwtstamp = timestamp;
-
 	if (igc_cleanup_headers(ring, desc, skb))
 		return;
 
@@ -2783,7 +2786,6 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 		union igc_adv_rx_desc *desc;
 		struct igc_rx_buffer *bi;
 		struct igc_xdp_buff *ctx;
-		ktime_t timestamp = 0;
 		unsigned int size;
 		int res;
 
@@ -2813,6 +2815,8 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 			 */
 			bi->xdp->data_meta += IGC_TS_HDR_LEN;
 			size -= IGC_TS_HDR_LEN;
+		} else {
+			ctx->rx_ts = NULL;
 		}
 
 		bi->xdp->data_end = bi->xdp->data + size;
@@ -2821,7 +2825,7 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 		res = __igc_xdp_run_prog(adapter, prog, bi->xdp);
 		switch (res) {
 		case IGC_XDP_PASS:
-			igc_dispatch_skb_zc(q_vector, desc, bi->xdp, timestamp);
+			igc_dispatch_skb_zc(q_vector, desc, ctx);
 			fallthrough;
 		case IGC_XDP_CONSUMED:
 			xsk_buff_free(bi->xdp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index 2bed8c86b7cf..3f64cdbabfa3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -768,7 +768,9 @@ static void __mlxsw_sp_port_get_stats(struct net_device *dev,
 	err = mlxsw_sp_get_hw_stats_by_group(&hw_stats, &len, grp);
 	if (err)
 		return;
-	mlxsw_sp_port_get_stats_raw(dev, grp, prio, ppcnt_pl);
+	err = mlxsw_sp_port_get_stats_raw(dev, grp, prio, ppcnt_pl);
+	if (err)
+		return;
 	for (i = 0; i < len; i++) {
 		data[data_index + i] = hw_stats[i].getter(ppcnt_pl);
 		if (!hw_stats[i].cells_bytes)
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 3c0d067c3609..3e090f87f97e 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -585,21 +585,30 @@ static void am65_cpsw_nuss_xmit_free(struct am65_cpsw_tx_chn *tx_chn,
 static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma)
 {
 	struct am65_cpsw_tx_chn *tx_chn = data;
+	enum am65_cpsw_tx_buf_type buf_type;
 	struct cppi5_host_desc_t *desc_tx;
+	struct xdp_frame *xdpf;
 	struct sk_buff *skb;
 	void **swdata;
 
 	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_tx);
-	skb = *(swdata);
-	am65_cpsw_nuss_xmit_free(tx_chn, desc_tx);
+	buf_type = am65_cpsw_nuss_buf_type(tx_chn, desc_dma);
+	if (buf_type == AM65_CPSW_TX_BUF_TYPE_SKB) {
+		skb = *(swdata);
+		dev_kfree_skb_any(skb);
+	} else {
+		xdpf = *(swdata);
+		xdp_return_frame(xdpf);
+	}
 
-	dev_kfree_skb_any(skb);
+	am65_cpsw_nuss_xmit_free(tx_chn, desc_tx);
 }
 
 static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
 					   struct net_device *ndev,
-					   unsigned int len)
+					   unsigned int len,
+					   unsigned int headroom)
 {
 	struct sk_buff *skb;
 
@@ -609,7 +618,7 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
 	if (unlikely(!skb))
 		return NULL;
 
-	skb_reserve(skb, AM65_CPSW_HEADROOM);
+	skb_reserve(skb, headroom);
 	skb->dev = ndev;
 
 	return skb;
@@ -1191,16 +1200,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	dev_dbg(dev, "%s rx csum_info:%#x\n", __func__, csum_info);
 
 	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
-
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 
-	skb = am65_cpsw_build_skb(page_addr, ndev,
-				  AM65_CPSW_MAX_PACKET_SIZE);
-	if (unlikely(!skb)) {
-		new_page = page;
-		goto requeue;
-	}
-
 	if (port->xdp_prog) {
 		xdp_init_buff(&xdp, PAGE_SIZE, &port->xdp_rxq[flow->id]);
 		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
@@ -1210,9 +1211,16 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 		if (*xdp_state != AM65_CPSW_XDP_PASS)
 			goto allocate;
 
-		/* Compute additional headroom to be reserved */
-		headroom = (xdp.data - xdp.data_hard_start) - skb_headroom(skb);
-		skb_reserve(skb, headroom);
+		headroom = xdp.data - xdp.data_hard_start;
+	} else {
+		headroom = AM65_CPSW_HEADROOM;
+	}
+
+	skb = am65_cpsw_build_skb(page_addr, ndev,
+				  AM65_CPSW_MAX_PACKET_SIZE, headroom);
+	if (unlikely(!skb)) {
+		new_page = page;
+		goto requeue;
 	}
 
 	ndev_priv = netdev_priv(ndev);
diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index 3612b0633bd1..88187dd4eb2d 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -39,10 +39,14 @@ static ssize_t nsim_dbg_netdev_ops_read(struct file *filp,
 		if (!sap->used)
 			continue;
 
-		p += scnprintf(p, bufsize - (p - buf),
-			       "sa[%i] %cx ipaddr=0x%08x %08x %08x %08x\n",
-			       i, (sap->rx ? 'r' : 't'), sap->ipaddr[0],
-			       sap->ipaddr[1], sap->ipaddr[2], sap->ipaddr[3]);
+		if (sap->xs->props.family == AF_INET6)
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI6c\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr);
+		else
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI4\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr[3]);
 		p += scnprintf(p, bufsize - (p - buf),
 			       "sa[%i]    spi=0x%08x proto=0x%x salt=0x%08x crypt=%d\n",
 			       i, be32_to_cpu(sap->xs->id.spi),
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 7f4ef219eee4..6cfafaac1b4f 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2640,7 +2640,9 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
 				ctx.data.u32_val = nla_get_u32(attr_data);
 				break;
 			case TEAM_OPTION_TYPE_STRING:
-				if (nla_len(attr_data) > TEAM_STRING_MAX_LEN) {
+				if (nla_len(attr_data) > TEAM_STRING_MAX_LEN ||
+				    !memchr(nla_data(attr_data), '\0',
+					    nla_len(attr_data))) {
 					err = -EINVAL;
 					goto team_put;
 				}
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6e9a3795846a..5e7cdd1b806f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2871,8 +2871,11 @@ static int vxlan_init(struct net_device *dev)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	int err;
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
-		vxlan_vnigroup_init(vxlan);
+	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		err = vxlan_vnigroup_init(vxlan);
+		if (err)
+			return err;
+	}
 
 	err = gro_cells_init(&vxlan->gro_cells, dev);
 	if (err)
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 2cd3ff9b0164..a6ba97949440 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4681,6 +4681,22 @@ static struct ath12k_reg_rule
 	return reg_rule_ptr;
 }
 
+static u8 ath12k_wmi_ignore_num_extra_rules(struct ath12k_wmi_reg_rule_ext_params *rule,
+					    u32 num_reg_rules)
+{
+	u8 num_invalid_5ghz_rules = 0;
+	u32 count, start_freq;
+
+	for (count = 0; count < num_reg_rules; count++) {
+		start_freq = le32_get_bits(rule[count].freq_info, REG_RULE_START_FREQ);
+
+		if (start_freq >= ATH12K_MIN_6G_FREQ)
+			num_invalid_5ghz_rules++;
+	}
+
+	return num_invalid_5ghz_rules;
+}
+
 static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 						   struct sk_buff *skb,
 						   struct ath12k_reg_info *reg_info)
@@ -4691,6 +4707,7 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 	u32 num_2g_reg_rules, num_5g_reg_rules;
 	u32 num_6g_reg_rules_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
 	u32 num_6g_reg_rules_cl[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u8 num_invalid_5ghz_ext_rules;
 	u32 total_reg_rules = 0;
 	int ret, i, j;
 
@@ -4784,20 +4801,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 
 	memcpy(reg_info->alpha2, &ev->alpha2, REG_ALPHA2_LEN);
 
-	/* FIXME: Currently FW includes 6G reg rule also in 5G rule
-	 * list for country US.
-	 * Having same 6G reg rule in 5G and 6G rules list causes
-	 * intersect check to be true, and same rules will be shown
-	 * multiple times in iw cmd. So added hack below to avoid
-	 * parsing 6G rule from 5G reg rule list, and this can be
-	 * removed later, after FW updates to remove 6G reg rule
-	 * from 5G rules list.
-	 */
-	if (memcmp(reg_info->alpha2, "US", 2) == 0) {
-		reg_info->num_5g_reg_rules = REG_US_5G_NUM_REG_RULES;
-		num_5g_reg_rules = reg_info->num_5g_reg_rules;
-	}
-
 	reg_info->dfs_region = le32_to_cpu(ev->dfs_region);
 	reg_info->phybitmap = le32_to_cpu(ev->phybitmap);
 	reg_info->num_phy = le32_to_cpu(ev->num_phy);
@@ -4900,8 +4903,29 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 		}
 	}
 
+	ext_wmi_reg_rule += num_2g_reg_rules;
+
+	/* Firmware might include 6 GHz reg rule in 5 GHz rule list
+	 * for few countries along with separate 6 GHz rule.
+	 * Having same 6 GHz reg rule in 5 GHz and 6 GHz rules list
+	 * causes intersect check to be true, and same rules will be
+	 * shown multiple times in iw cmd.
+	 * Hence, avoid parsing 6 GHz rule from 5 GHz reg rule list
+	 */
+	num_invalid_5ghz_ext_rules = ath12k_wmi_ignore_num_extra_rules(ext_wmi_reg_rule,
+								       num_5g_reg_rules);
+
+	if (num_invalid_5ghz_ext_rules) {
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "CC: %s 5 GHz reg rules number %d from fw, %d number of invalid 5 GHz rules",
+			   reg_info->alpha2, reg_info->num_5g_reg_rules,
+			   num_invalid_5ghz_ext_rules);
+
+		num_5g_reg_rules = num_5g_reg_rules - num_invalid_5ghz_ext_rules;
+		reg_info->num_5g_reg_rules = num_5g_reg_rules;
+	}
+
 	if (num_5g_reg_rules) {
-		ext_wmi_reg_rule += num_2g_reg_rules;
 		reg_info->reg_rules_5g_ptr =
 			create_ext_reg_rules_from_wmi(num_5g_reg_rules,
 						      ext_wmi_reg_rule);
@@ -4913,7 +4937,12 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 		}
 	}
 
-	ext_wmi_reg_rule += num_5g_reg_rules;
+	/* We have adjusted the number of 5 GHz reg rules above. But still those
+	 * many rules needs to be adjusted in ext_wmi_reg_rule.
+	 *
+	 * NOTE: num_invalid_5ghz_ext_rules will be 0 for rest other cases.
+	 */
+	ext_wmi_reg_rule += (num_5g_reg_rules + num_invalid_5ghz_ext_rules);
 
 	for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
 		reg_info->reg_rules_6g_ap_ptr[i] =
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6a913f9b8315..b495cdea7111 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3943,7 +3943,6 @@ struct ath12k_wmi_eht_rate_set_params {
 #define MAX_REG_RULES 10
 #define REG_ALPHA2_LEN 2
 #define MAX_6G_REG_RULES 5
-#define REG_US_5G_NUM_REG_RULES 4
 
 enum wmi_start_event_param {
 	WMI_VDEV_START_RESP_EVENT = 0,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 5aef7fa37878..0ac84f968994 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2492,7 +2492,7 @@ static int rtw89_pci_dphy_delay(struct rtw89_dev *rtwdev)
 				       PCIE_DPHY_DLY_25US, PCIE_PHY_GEN1);
 }
 
-static void rtw89_pci_power_wake(struct rtw89_dev *rtwdev, bool pwr_up)
+static void rtw89_pci_power_wake_ax(struct rtw89_dev *rtwdev, bool pwr_up)
 {
 	if (pwr_up)
 		rtw89_write32_set(rtwdev, R_AX_HCI_OPT_CTRL, BIT_WAKE_CTRL);
@@ -2799,6 +2799,8 @@ static int rtw89_pci_ops_deinit(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 
+	rtw89_pci_power_wake(rtwdev, false);
+
 	if (rtwdev->chip->chip_id == RTL8852A) {
 		/* ltr sw trigger */
 		rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_APP_LTR_IDLE);
@@ -2841,7 +2843,7 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	rtw89_pci_power_wake(rtwdev, true);
+	rtw89_pci_power_wake_ax(rtwdev, true);
 	rtw89_pci_autoload_hang(rtwdev);
 	rtw89_pci_l12_vmain(rtwdev);
 	rtw89_pci_gen2_force_ib(rtwdev);
@@ -2886,6 +2888,13 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_pci_ops_mac_pre_deinit_ax(struct rtw89_dev *rtwdev)
+{
+	rtw89_pci_power_wake_ax(rtwdev, false);
+
+	return 0;
+}
+
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en)
 {
 	u32 val;
@@ -4264,7 +4273,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 					    B_AX_RDU_INT},
 
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_ax,
-	.mac_pre_deinit = NULL,
+	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit_ax,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_ax,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_ax,
@@ -4280,6 +4289,8 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.aspm_set = rtw89_pci_aspm_set_ax,
 	.clkreq_set = rtw89_pci_clkreq_set_ax,
 	.l1ss_set = rtw89_pci_l1ss_set_ax,
+
+	.power_wake = rtw89_pci_power_wake_ax,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_ax);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 48c3ab735db2..0ea4dcb84dd8 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1276,6 +1276,8 @@ struct rtw89_pci_gen_def {
 	void (*aspm_set)(struct rtw89_dev *rtwdev, bool enable);
 	void (*clkreq_set)(struct rtw89_dev *rtwdev, bool enable);
 	void (*l1ss_set)(struct rtw89_dev *rtwdev, bool enable);
+
+	void (*power_wake)(struct rtw89_dev *rtwdev, bool pwr_up);
 };
 
 struct rtw89_pci_info {
@@ -1766,4 +1768,13 @@ static inline int rtw89_pci_poll_txdma_ch_idle(struct rtw89_dev *rtwdev)
 
 	return gen_def->poll_txdma_ch_idle(rtwdev);
 }
+
+static inline void rtw89_pci_power_wake(struct rtw89_dev *rtwdev, bool pwr_up)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	gen_def->power_wake(rtwdev, pwr_up);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 7cc328222965..2f0d9ff25ba5 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -614,5 +614,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.aspm_set = rtw89_pci_aspm_set_be,
 	.clkreq_set = rtw89_pci_clkreq_set_be,
 	.l1ss_set = rtw89_pci_l1ss_set_be,
+
+	.power_wake = _patch_pcie_power_wake_be,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_be);
diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 3644997a8342..24d4f3a3ec3d 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -266,10 +266,14 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ 0x1409, 0x7168, 0x1409, 0xd079, 0, 0, timedia_9079c },
 
 	/* WCH CARDS */
-	{ 0x4348, 0x5053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p},
-	{ 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
-	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382_0s1p},
-	{ 0x1c00, 0x3250, 0x1c00, 0x3250, 0, 0, wch_ch382_2s1p},
+	{ PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_1S1P,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, wch_ch353_1s1p },
+	{ PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_2S1P,
+	  0x4348, 0x3253, 0, 0, wch_ch353_2s1p },
+	{ PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_0S1P,
+	  0x1c00, 0x3050, 0, 0, wch_ch382_0s1p },
+	{ PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_2S1P,
+	  0x1c00, 0x3250, 0, 0, wch_ch382_2s1p },
 
 	/* BrainBoxes PX272/PX306 MIO card */
 	{ PCI_VENDOR_ID_INTASHIELD, 0x4100,
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8103bc24a54e..064067d9c8b5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5522,7 +5522,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
  * AMD Matisse USB 3.0 Host Controller 0x149c
  * Intel 82579LM Gigabit Ethernet Controller 0x1502
  * Intel 82579V Gigabit Ethernet Controller 0x1503
- *
+ * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
  */
 static void quirk_no_flr(struct pci_dev *dev)
 {
@@ -5534,6 +5534,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
 
 /* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
 static void quirk_no_flr_snet(struct pci_dev *dev)
@@ -5985,6 +5986,17 @@ SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
 SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
 SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
 
+#define SWITCHTEC_PCI100X_QUIRK(vid) \
+	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_EFAR, vid, \
+		PCI_CLASS_BRIDGE_OTHER, 8, quirk_switchtec_ntb_dma_alias)
+SWITCHTEC_PCI100X_QUIRK(0x1001);  /* PCI1001XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1002);  /* PCI1002XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1003);  /* PCI1003XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1004);  /* PCI1004XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1005);  /* PCI1005XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1006);  /* PCI1006XG4 */
+
+
 /*
  * The PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints.
  * These IDs are used to forward responses to the originator on the other
@@ -6254,6 +6266,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa72f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index c7e1089ffdaf..b14dfab04d84 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1739,6 +1739,26 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 		.driver_data = gen, \
 	}
 
+#define SWITCHTEC_PCI100X_DEVICE(device_id, gen) \
+	{ \
+		.vendor     = PCI_VENDOR_ID_EFAR, \
+		.device     = device_id, \
+		.subvendor  = PCI_ANY_ID, \
+		.subdevice  = PCI_ANY_ID, \
+		.class      = (PCI_CLASS_MEMORY_OTHER << 8), \
+		.class_mask = 0xFFFFFFFF, \
+		.driver_data = gen, \
+	}, \
+	{ \
+		.vendor     = PCI_VENDOR_ID_EFAR, \
+		.device     = device_id, \
+		.subvendor  = PCI_ANY_ID, \
+		.subdevice  = PCI_ANY_ID, \
+		.class      = (PCI_CLASS_BRIDGE_OTHER << 8), \
+		.class_mask = 0xFFFFFFFF, \
+		.driver_data = gen, \
+	}
+
 static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x8531, SWITCHTEC_GEN3),  /* PFX 24xG3 */
 	SWITCHTEC_PCI_DEVICE(0x8532, SWITCHTEC_GEN3),  /* PFX 32xG3 */
@@ -1833,6 +1853,12 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x5552, SWITCHTEC_GEN5),  /* PAXA 52XG5 */
 	SWITCHTEC_PCI_DEVICE(0x5536, SWITCHTEC_GEN5),  /* PAXA 36XG5 */
 	SWITCHTEC_PCI_DEVICE(0x5528, SWITCHTEC_GEN5),  /* PAXA 28XG5 */
+	SWITCHTEC_PCI100X_DEVICE(0x1001, SWITCHTEC_GEN4),  /* PCI1001 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1002, SWITCHTEC_GEN4),  /* PCI1002 12XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1003, SWITCHTEC_GEN4),  /* PCI1003 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1004, SWITCHTEC_GEN4),  /* PCI1004 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1005, SWITCHTEC_GEN4),  /* PCI1005 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1006, SWITCHTEC_GEN4),  /* PCI1006 16XG4 */
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 0b13d7f17b32..42547f64453e 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -89,12 +89,12 @@ static void pinconf_generic_dump_one(struct pinctrl_dev *pctldev,
 		seq_puts(s, items[i].display);
 		/* Print unit if available */
 		if (items[i].has_arg) {
-			seq_printf(s, " (0x%x",
-				   pinconf_to_config_argument(config));
+			u32 val = pinconf_to_config_argument(config);
+
 			if (items[i].format)
-				seq_printf(s, " %s)", items[i].format);
+				seq_printf(s, " (%u %s)", val, items[i].format);
 			else
-				seq_puts(s, ")");
+				seq_printf(s, " (0x%x)", val);
 		}
 	}
 }
diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 5096ccdd459e..7a6a1434ae7f 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -42,7 +42,7 @@
 #define CY8C95X0_PORTSEL	0x18
 /* Port settings, write PORTSEL first */
 #define CY8C95X0_INTMASK	0x19
-#define CY8C95X0_PWMSEL		0x1A
+#define CY8C95X0_SELPWM		0x1A
 #define CY8C95X0_INVERT		0x1B
 #define CY8C95X0_DIRECTION	0x1C
 /* Drive mode register change state on writing '1' */
@@ -330,14 +330,14 @@ static int cypress_get_pin_mask(struct cy8c95x0_pinctrl *chip, unsigned int pin)
 static bool cy8c95x0_readable_register(struct device *dev, unsigned int reg)
 {
 	/*
-	 * Only 12 registers are present per port (see Table 6 in the
-	 * datasheet).
+	 * Only 12 registers are present per port (see Table 6 in the datasheet).
 	 */
-	if (reg >= CY8C95X0_VIRTUAL && (reg % MUXED_STRIDE) < 12)
-		return true;
+	if (reg >= CY8C95X0_VIRTUAL && (reg % MUXED_STRIDE) >= 12)
+		return false;
 
 	switch (reg) {
 	case 0x24 ... 0x27:
+	case 0x31 ... 0x3f:
 		return false;
 	default:
 		return true;
@@ -346,8 +346,11 @@ static bool cy8c95x0_readable_register(struct device *dev, unsigned int reg)
 
 static bool cy8c95x0_writeable_register(struct device *dev, unsigned int reg)
 {
-	if (reg >= CY8C95X0_VIRTUAL)
-		return true;
+	/*
+	 * Only 12 registers are present per port (see Table 6 in the datasheet).
+	 */
+	if (reg >= CY8C95X0_VIRTUAL && (reg % MUXED_STRIDE) >= 12)
+		return false;
 
 	switch (reg) {
 	case CY8C95X0_INPUT_(0) ... CY8C95X0_INPUT_(7):
@@ -355,6 +358,7 @@ static bool cy8c95x0_writeable_register(struct device *dev, unsigned int reg)
 	case CY8C95X0_DEVID:
 		return false;
 	case 0x24 ... 0x27:
+	case 0x31 ... 0x3f:
 		return false;
 	default:
 		return true;
@@ -367,8 +371,8 @@ static bool cy8c95x0_volatile_register(struct device *dev, unsigned int reg)
 	case CY8C95X0_INPUT_(0) ... CY8C95X0_INPUT_(7):
 	case CY8C95X0_INTSTATUS_(0) ... CY8C95X0_INTSTATUS_(7):
 	case CY8C95X0_INTMASK:
+	case CY8C95X0_SELPWM:
 	case CY8C95X0_INVERT:
-	case CY8C95X0_PWMSEL:
 	case CY8C95X0_DIRECTION:
 	case CY8C95X0_DRV_PU:
 	case CY8C95X0_DRV_PD:
@@ -397,7 +401,7 @@ static bool cy8c95x0_muxed_register(unsigned int reg)
 {
 	switch (reg) {
 	case CY8C95X0_INTMASK:
-	case CY8C95X0_PWMSEL:
+	case CY8C95X0_SELPWM:
 	case CY8C95X0_INVERT:
 	case CY8C95X0_DIRECTION:
 	case CY8C95X0_DRV_PU:
@@ -468,7 +472,11 @@ static const struct regmap_config cy8c9520_i2c_regmap = {
 	.max_register = 0,		/* Updated at runtime */
 	.num_reg_defaults_raw = 0,	/* Updated at runtime */
 	.use_single_read = true,	/* Workaround for regcache bug */
+#if IS_ENABLED(CONFIG_DEBUG_PINCTRL)
+	.disable_locking = false,
+#else
 	.disable_locking = true,
+#endif
 };
 
 static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip,
@@ -799,7 +807,7 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
 		reg = CY8C95X0_DIRECTION;
 		break;
 	case PIN_CONFIG_MODE_PWM:
-		reg = CY8C95X0_PWMSEL;
+		reg = CY8C95X0_SELPWM;
 		break;
 	case PIN_CONFIG_OUTPUT:
 		reg = CY8C95X0_OUTPUT;
@@ -881,7 +889,7 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 		reg = CY8C95X0_DRV_PP_FAST;
 		break;
 	case PIN_CONFIG_MODE_PWM:
-		reg = CY8C95X0_PWMSEL;
+		reg = CY8C95X0_SELPWM;
 		break;
 	case PIN_CONFIG_OUTPUT_ENABLE:
 		ret = cy8c95x0_pinmux_direction(chip, off, !arg);
@@ -1171,7 +1179,7 @@ static void cy8c95x0_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *
 	bitmap_zero(mask, MAX_LINE);
 	__set_bit(pin, mask);
 
-	if (cy8c95x0_read_regs_mask(chip, CY8C95X0_PWMSEL, pwm, mask)) {
+	if (cy8c95x0_read_regs_mask(chip, CY8C95X0_SELPWM, pwm, mask)) {
 		seq_puts(s, "not available");
 		return;
 	}
@@ -1216,7 +1224,7 @@ static int cy8c95x0_set_mode(struct cy8c95x0_pinctrl *chip, unsigned int off, bo
 	u8 port = cypress_get_port(chip, off);
 	u8 bit = cypress_get_pin_mask(chip, off);
 
-	return cy8c95x0_regmap_write_bits(chip, CY8C95X0_PWMSEL, port, bit, mode ? bit : 0);
+	return cy8c95x0_regmap_write_bits(chip, CY8C95X0_SELPWM, port, bit, mode ? bit : 0);
 }
 
 static int cy8c95x0_pinmux_mode(struct cy8c95x0_pinctrl *chip,
@@ -1365,7 +1373,7 @@ static int cy8c95x0_irq_setup(struct cy8c95x0_pinctrl *chip, int irq)
 
 	ret = devm_request_threaded_irq(chip->dev, irq,
 					NULL, cy8c95x0_irq_handler,
-					IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_HIGH,
+					IRQF_ONESHOT | IRQF_SHARED,
 					dev_name(chip->dev), chip);
 	if (ret) {
 		dev_err(chip->dev, "failed to request irq %d\n", irq);
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index eb14e5ff5a0a..e24ab5f7d2bf 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -647,15 +647,20 @@ static const struct nvmem_cell_lookup tegra234_fuse_lookups[] = {
 };
 
 static const struct nvmem_keepout tegra234_fuse_keepouts[] = {
-	{ .start = 0x01c, .end = 0x0c8 },
-	{ .start = 0x12c, .end = 0x184 },
+	{ .start = 0x01c, .end = 0x064 },
+	{ .start = 0x084, .end = 0x0a0 },
+	{ .start = 0x0a4, .end = 0x0c8 },
+	{ .start = 0x12c, .end = 0x164 },
+	{ .start = 0x16c, .end = 0x184 },
 	{ .start = 0x190, .end = 0x198 },
 	{ .start = 0x1a0, .end = 0x204 },
-	{ .start = 0x21c, .end = 0x250 },
-	{ .start = 0x25c, .end = 0x2f0 },
+	{ .start = 0x21c, .end = 0x2f0 },
 	{ .start = 0x310, .end = 0x3d8 },
-	{ .start = 0x400, .end = 0x4f0 },
-	{ .start = 0x4f8, .end = 0x7e8 },
+	{ .start = 0x400, .end = 0x420 },
+	{ .start = 0x444, .end = 0x490 },
+	{ .start = 0x4bc, .end = 0x4f0 },
+	{ .start = 0x4f8, .end = 0x54c },
+	{ .start = 0x57c, .end = 0x7e8 },
 	{ .start = 0x8d0, .end = 0x8d8 },
 	{ .start = 0xacc, .end = 0xf00 }
 };
diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index a7c3b3923b4a..fd8c8eb37d01 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -116,6 +116,9 @@ struct f_ospi {
 
 static u32 f_ospi_get_dummy_cycle(const struct spi_mem_op *op)
 {
+	if (!op->dummy.nbytes)
+		return 0;
+
 	return (op->dummy.nbytes * 8) / op->dummy.buswidth;
 }
 
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index e5310c65cf52..10a706fe4b24 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -374,6 +374,7 @@ static inline int is_omap1510_8250(struct uart_8250_port *pt)
 
 #ifdef CONFIG_SERIAL_8250_DMA
 extern int serial8250_tx_dma(struct uart_8250_port *);
+extern void serial8250_tx_dma_flush(struct uart_8250_port *);
 extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
@@ -406,6 +407,7 @@ static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
 	return -1;
 }
+static inline void serial8250_tx_dma_flush(struct uart_8250_port *p) { }
 static inline int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	return -1;
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index d215c494ee24..f245a84f4a50 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -149,6 +149,22 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	return ret;
 }
 
+void serial8250_tx_dma_flush(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	/*
+	 * kfifo_reset() has been called by the serial core, avoid
+	 * advancing and underflowing in __dma_tx_complete().
+	 */
+	dma->tx_size = 0;
+
+	dmaengine_terminate_async(dma->rxchan);
+}
+
 int serial8250_rx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6709b6a5f301..de6d90bf0d70 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -64,23 +64,17 @@
 #define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
 #define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
 #define PCI_DEVICE_ID_INTEL_PATSBURG_KT 0x1d3d
-#define PCI_VENDOR_ID_WCH		0x4348
-#define PCI_DEVICE_ID_WCH_CH352_2S	0x3253
-#define PCI_DEVICE_ID_WCH_CH353_4S	0x3453
-#define PCI_DEVICE_ID_WCH_CH353_2S1PF	0x5046
-#define PCI_DEVICE_ID_WCH_CH353_1S1P	0x5053
-#define PCI_DEVICE_ID_WCH_CH353_2S1P	0x7053
-#define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
+
+#define PCI_DEVICE_ID_WCHCN_CH352_2S	0x3253
+#define PCI_DEVICE_ID_WCHCN_CH355_4S	0x7173
+
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
-#define PCIE_VENDOR_ID_WCH		0x1c00
-#define PCIE_DEVICE_ID_WCH_CH382_2S1P	0x3250
-#define PCIE_DEVICE_ID_WCH_CH384_4S	0x3470
-#define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
-#define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
+#define PCI_DEVICE_ID_WCHIC_CH384_4S	0x3470
+#define PCI_DEVICE_ID_WCHIC_CH384_8S	0x3853
 
 #define PCI_DEVICE_ID_MOXA_CP102E	0x1024
 #define PCI_DEVICE_ID_MOXA_CP102EL	0x1025
@@ -2777,80 +2771,80 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 	},
 	/* WCH CH353 1S1P card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_1S1P,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_1S1P,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH353 2S1P card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_2S1P,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_2S1P,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH353 4S card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_4S,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_4S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH353 2S1PF card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_2S1PF,
+		.vendor         = PCI_VENDOR_ID_WCHCN,
+		.device         = PCI_DEVICE_ID_WCHCN_CH353_2S1PF,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch353_setup,
 	},
 	/* WCH CH352 2S card (16550 clone) */
 	{
-		.vendor		= PCI_VENDOR_ID_WCH,
-		.device		= PCI_DEVICE_ID_WCH_CH352_2S,
+		.vendor		= PCI_VENDOR_ID_WCHCN,
+		.device		= PCI_DEVICE_ID_WCHCN_CH352_2S,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_wch_ch353_setup,
 	},
 	/* WCH CH355 4S card (16550 clone) */
 	{
-		.vendor		= PCI_VENDOR_ID_WCH,
-		.device		= PCI_DEVICE_ID_WCH_CH355_4S,
+		.vendor		= PCI_VENDOR_ID_WCHCN,
+		.device		= PCI_DEVICE_ID_WCHCN_CH355_4S,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_wch_ch355_setup,
 	},
 	/* WCH CH382 2S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH382_2S,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH382_2S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
 	/* WCH CH382 2S1P card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH382_2S1P,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH382_2S1P,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
 	/* WCH CH384 4S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH384_4S,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH384_4S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
 	/* WCH CH384 8S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH384_8S,
+		.vendor         = PCI_VENDOR_ID_WCHIC,
+		.device         = PCI_DEVICE_ID_WCHIC_CH384_8S,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
 		.init           = pci_wch_ch38x_init,
@@ -3927,11 +3921,11 @@ static const struct pci_device_id blacklist[] = {
 
 	/* multi-io cards handled by parport_serial */
 	/* WCH CH353 2S1P */
-	{ PCI_DEVICE(0x4348, 0x7053), 0, 0, REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHCN, 0x7053), REPORT_CONFIG(PARPORT_SERIAL), },
 	/* WCH CH353 1S1P */
-	{ PCI_DEVICE(0x4348, 0x5053), 0, 0, REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHCN, 0x5053), REPORT_CONFIG(PARPORT_SERIAL), },
 	/* WCH CH382 2S1P */
-	{ PCI_DEVICE(0x1c00, 0x3250), 0, 0, REPORT_CONFIG(PARPORT_SERIAL), },
+	{ PCI_VDEVICE(WCHIC, 0x3250), REPORT_CONFIG(PARPORT_SERIAL), },
 
 	/* Intel platforms with MID UART */
 	{ PCI_VDEVICE(INTEL, 0x081b), REPORT_8250_CONFIG(MID), },
@@ -6004,27 +5998,27 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 * WCH CH353 series devices: The 2S1P is handled by parport_serial
 	 * so not listed here.
 	 */
-	{	PCI_VENDOR_ID_WCH, PCI_DEVICE_ID_WCH_CH353_4S,
+	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_4_115200 },
 
-	{	PCI_VENDOR_ID_WCH, PCI_DEVICE_ID_WCH_CH353_2S1PF,
+	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH353_2S1PF,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_2_115200 },
 
-	{	PCI_VENDOR_ID_WCH, PCI_DEVICE_ID_WCH_CH355_4S,
+	{	PCI_VENDOR_ID_WCHCN, PCI_DEVICE_ID_WCHCN_CH355_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_bt_4_115200 },
 
-	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH382_2S,
+	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH382_2S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch382_2 },
 
-	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH384_4S,
+	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH384_4S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_4 },
 
-	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH384_8S,
+	{	PCI_VENDOR_ID_WCHIC, PCI_DEVICE_ID_WCHIC_CH384_8S,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_8 },
 	/*
diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index d3930bf32fe4..f462b3d1c104 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -78,6 +78,12 @@
 #define UART_TX_BYTE_FIFO			0x00
 #define UART_FIFO_CTL				0x02
 
+#define UART_MODEM_CTL_REG			0x04
+#define UART_MODEM_CTL_RTS_SET			BIT(1)
+
+#define UART_LINE_STAT_REG			0x05
+#define UART_LINE_XMIT_CHECK_MASK		GENMASK(6, 5)
+
 #define UART_ACTV_REG				0x11
 #define UART_BLOCK_SET_ACTIVE			BIT(0)
 
@@ -94,6 +100,7 @@
 #define UART_BIT_SAMPLE_CNT_16			16
 #define BAUD_CLOCK_DIV_INT_MSK			GENMASK(31, 8)
 #define ADCL_CFG_RTS_DELAY_MASK			GENMASK(11, 8)
+#define FRAC_DIV_TX_END_POINT_MASK		GENMASK(23, 20)
 
 #define UART_WAKE_REG				0x8C
 #define UART_WAKE_MASK_REG			0x90
@@ -134,6 +141,11 @@
 #define UART_BST_STAT_LSR_FRAME_ERR		0x8000000
 #define UART_BST_STAT_LSR_THRE			0x20000000
 
+#define GET_MODEM_CTL_RTS_STATUS(reg)		((reg) & UART_MODEM_CTL_RTS_SET)
+#define GET_RTS_PIN_STATUS(val)			(((val) & TIOCM_RTS) >> 1)
+#define RTS_TOGGLE_STATUS_MASK(val, reg)	(GET_MODEM_CTL_RTS_STATUS(reg) \
+						 != GET_RTS_PIN_STATUS(val))
+
 struct pci1xxxx_8250 {
 	unsigned int nr;
 	u8 dev_rev;
@@ -254,6 +266,47 @@ static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
 	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
 }
 
+static void pci1xxxx_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	u32 fract_div_cfg_reg;
+	u32 line_stat_reg;
+	u32 modem_ctl_reg;
+	u32 adcl_cfg_reg;
+
+	adcl_cfg_reg = readl(port->membase + ADCL_CFG_REG);
+
+	/* HW is responsible in ADCL_EN case */
+	if ((adcl_cfg_reg & (ADCL_CFG_EN | ADCL_CFG_PIN_SEL)))
+		return;
+
+	modem_ctl_reg = readl(port->membase + UART_MODEM_CTL_REG);
+
+	serial8250_do_set_mctrl(port, mctrl);
+
+	if (RTS_TOGGLE_STATUS_MASK(mctrl, modem_ctl_reg)) {
+		line_stat_reg = readl(port->membase + UART_LINE_STAT_REG);
+		if (line_stat_reg & UART_LINE_XMIT_CHECK_MASK) {
+			fract_div_cfg_reg = readl(port->membase +
+						  FRAC_DIV_CFG_REG);
+
+			writel((fract_div_cfg_reg &
+			       ~(FRAC_DIV_TX_END_POINT_MASK)),
+			       port->membase + FRAC_DIV_CFG_REG);
+
+			/* Enable ADC and set the nRTS pin */
+			writel((adcl_cfg_reg | (ADCL_CFG_EN |
+			       ADCL_CFG_PIN_SEL)),
+			       port->membase + ADCL_CFG_REG);
+
+			/* Revert to the original settings */
+			writel(adcl_cfg_reg, port->membase + ADCL_CFG_REG);
+
+			writel(fract_div_cfg_reg, port->membase +
+			       FRAC_DIV_CFG_REG);
+		}
+	}
+}
+
 static int pci1xxxx_rs485_config(struct uart_port *port,
 				 struct ktermios *termios,
 				 struct serial_rs485 *rs485)
@@ -631,9 +684,14 @@ static int pci1xxxx_setup(struct pci_dev *pdev,
 	port->port.rs485_config = pci1xxxx_rs485_config;
 	port->port.rs485_supported = pci1xxxx_rs485_supported;
 
-	/* From C0 rev Burst operation is supported */
+	/*
+	 * C0 and later revisions support Burst operation.
+	 * RTS workaround in mctrl is applicable only to B0.
+	 */
 	if (rev >= 0xC0)
 		port->port.handle_irq = pci1xxxx_handle_irq;
+	else if (rev == 0xB0)
+		port->port.set_mctrl = pci1xxxx_set_mctrl;
 
 	ret = serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx, 0);
 	if (ret < 0)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 11519aa2598a..c1376727642a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2524,6 +2524,14 @@ static void serial8250_shutdown(struct uart_port *port)
 		serial8250_do_shutdown(port);
 }
 
+static void serial8250_flush_buffer(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (up->dma)
+		serial8250_tx_dma_flush(up);
+}
+
 static unsigned int serial8250_do_get_divisor(struct uart_port *port,
 					      unsigned int baud,
 					      unsigned int *frac)
@@ -3207,6 +3215,7 @@ static const struct uart_ops serial8250_pops = {
 	.break_ctl	= serial8250_break_ctl,
 	.startup	= serial8250_startup,
 	.shutdown	= serial8250_shutdown,
+	.flush_buffer	= serial8250_flush_buffer,
 	.set_termios	= serial8250_set_termios,
 	.set_ldisc	= serial8250_set_ldisc,
 	.pm		= serial8250_pm,
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index d35f1d24156c..85285c56fabf 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -173,6 +173,7 @@ EXPORT_SYMBOL(uart_remove_one_port);
  * The caller is responsible to initialize the following fields of the @port
  *   ->dev (must be valid)
  *   ->flags
+ *   ->iobase
  *   ->mapbase
  *   ->mapsize
  *   ->regshift (if @use_defaults is false)
@@ -214,7 +215,7 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
 	/* Read the registers I/O access type (default: MMIO 8-bit) */
 	ret = device_property_read_u32(dev, "reg-io-width", &value);
 	if (ret) {
-		port->iotype = UPIO_MEM;
+		port->iotype = port->iobase ? UPIO_PORT : UPIO_MEM;
 	} else {
 		switch (value) {
 		case 1:
@@ -227,11 +228,11 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
 			port->iotype = device_is_big_endian(dev) ? UPIO_MEM32BE : UPIO_MEM32;
 			break;
 		default:
+			port->iotype = UPIO_UNKNOWN;
 			if (!use_defaults) {
 				dev_err(dev, "Unsupported reg-io-width (%u)\n", value);
 				return -EINVAL;
 			}
-			port->iotype = UPIO_UNKNOWN;
 			break;
 		}
 	}
diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 58023f735c19..8d4ad0a3f2cf 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -216,6 +216,7 @@ void ufs_bsg_remove(struct ufs_hba *hba)
 		return;
 
 	bsg_remove_queue(hba->bsg_queue);
+	hba->bsg_queue = NULL;
 
 	device_del(bsg_dev);
 	put_device(bsg_dev);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b786cba9a270..67410c4cebee 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -258,10 +258,15 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 	return UFS_PM_LVL_0;
 }
 
+static bool ufshcd_has_pending_tasks(struct ufs_hba *hba)
+{
+	return hba->outstanding_tasks || hba->active_uic_cmd ||
+	       hba->uic_async_done;
+}
+
 static bool ufshcd_is_ufs_dev_busy(struct ufs_hba *hba)
 {
-	return (hba->clk_gating.active_reqs || hba->outstanding_reqs || hba->outstanding_tasks ||
-		hba->active_uic_cmd || hba->uic_async_done);
+	return hba->outstanding_reqs || ufshcd_has_pending_tasks(hba);
 }
 
 static const struct ufs_dev_quirk ufs_fixups[] = {
@@ -1835,19 +1840,16 @@ static void ufshcd_exit_clk_scaling(struct ufs_hba *hba)
 static void ufshcd_ungate_work(struct work_struct *work)
 {
 	int ret;
-	unsigned long flags;
 	struct ufs_hba *hba = container_of(work, struct ufs_hba,
 			clk_gating.ungate_work);
 
 	cancel_delayed_work_sync(&hba->clk_gating.gate_work);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (hba->clk_gating.state == CLKS_ON) {
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
-		return;
+	scoped_guard(spinlock_irqsave, &hba->clk_gating.lock) {
+		if (hba->clk_gating.state == CLKS_ON)
+			return;
 	}
 
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	ufshcd_hba_vreg_set_hpm(hba);
 	ufshcd_setup_clocks(hba, true);
 
@@ -1882,7 +1884,7 @@ void ufshcd_hold(struct ufs_hba *hba)
 	if (!ufshcd_is_clkgating_allowed(hba) ||
 	    !hba->clk_gating.is_initialized)
 		return;
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	spin_lock_irqsave(&hba->clk_gating.lock, flags);
 	hba->clk_gating.active_reqs++;
 
 start:
@@ -1898,11 +1900,11 @@ void ufshcd_hold(struct ufs_hba *hba)
 		 */
 		if (ufshcd_can_hibern8_during_gating(hba) &&
 		    ufshcd_is_link_hibern8(hba)) {
-			spin_unlock_irqrestore(hba->host->host_lock, flags);
+			spin_unlock_irqrestore(&hba->clk_gating.lock, flags);
 			flush_result = flush_work(&hba->clk_gating.ungate_work);
 			if (hba->clk_gating.is_suspended && !flush_result)
 				return;
-			spin_lock_irqsave(hba->host->host_lock, flags);
+			spin_lock_irqsave(&hba->clk_gating.lock, flags);
 			goto start;
 		}
 		break;
@@ -1931,17 +1933,17 @@ void ufshcd_hold(struct ufs_hba *hba)
 		 */
 		fallthrough;
 	case REQ_CLKS_ON:
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
+		spin_unlock_irqrestore(&hba->clk_gating.lock, flags);
 		flush_work(&hba->clk_gating.ungate_work);
 		/* Make sure state is CLKS_ON before returning */
-		spin_lock_irqsave(hba->host->host_lock, flags);
+		spin_lock_irqsave(&hba->clk_gating.lock, flags);
 		goto start;
 	default:
 		dev_err(hba->dev, "%s: clk gating is in invalid state %d\n",
 				__func__, hba->clk_gating.state);
 		break;
 	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	spin_unlock_irqrestore(&hba->clk_gating.lock, flags);
 }
 EXPORT_SYMBOL_GPL(ufshcd_hold);
 
@@ -1949,28 +1951,32 @@ static void ufshcd_gate_work(struct work_struct *work)
 {
 	struct ufs_hba *hba = container_of(work, struct ufs_hba,
 			clk_gating.gate_work.work);
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	/*
-	 * In case you are here to cancel this work the gating state
-	 * would be marked as REQ_CLKS_ON. In this case save time by
-	 * skipping the gating work and exit after changing the clock
-	 * state to CLKS_ON.
-	 */
-	if (hba->clk_gating.is_suspended ||
-		(hba->clk_gating.state != REQ_CLKS_OFF)) {
-		hba->clk_gating.state = CLKS_ON;
-		trace_ufshcd_clk_gating(dev_name(hba->dev),
-					hba->clk_gating.state);
-		goto rel_lock;
-	}
+	scoped_guard(spinlock_irqsave, &hba->clk_gating.lock) {
+		/*
+		 * In case you are here to cancel this work the gating state
+		 * would be marked as REQ_CLKS_ON. In this case save time by
+		 * skipping the gating work and exit after changing the clock
+		 * state to CLKS_ON.
+		 */
+		if (hba->clk_gating.is_suspended ||
+		    hba->clk_gating.state != REQ_CLKS_OFF) {
+			hba->clk_gating.state = CLKS_ON;
+			trace_ufshcd_clk_gating(dev_name(hba->dev),
+						hba->clk_gating.state);
+			return;
+		}
 
-	if (ufshcd_is_ufs_dev_busy(hba) || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL)
-		goto rel_lock;
+		if (hba->clk_gating.active_reqs)
+			return;
+	}
 
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (ufshcd_is_ufs_dev_busy(hba) ||
+		    hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL)
+			return;
+	}
 
 	/* put the link into hibern8 mode before turning off clocks */
 	if (ufshcd_can_hibern8_during_gating(hba)) {
@@ -1981,7 +1987,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 					__func__, ret);
 			trace_ufshcd_clk_gating(dev_name(hba->dev),
 						hba->clk_gating.state);
-			goto out;
+			return;
 		}
 		ufshcd_set_link_hibern8(hba);
 	}
@@ -2001,33 +2007,34 @@ static void ufshcd_gate_work(struct work_struct *work)
 	 * prevent from doing cancel work multiple times when there are
 	 * new requests arriving before the current cancel work is done.
 	 */
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	guard(spinlock_irqsave)(&hba->clk_gating.lock);
 	if (hba->clk_gating.state == REQ_CLKS_OFF) {
 		hba->clk_gating.state = CLKS_OFF;
 		trace_ufshcd_clk_gating(dev_name(hba->dev),
 					hba->clk_gating.state);
 	}
-rel_lock:
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-out:
-	return;
 }
 
-/* host lock must be held before calling this variant */
 static void __ufshcd_release(struct ufs_hba *hba)
 {
+	lockdep_assert_held(&hba->clk_gating.lock);
+
 	if (!ufshcd_is_clkgating_allowed(hba))
 		return;
 
 	hba->clk_gating.active_reqs--;
 
 	if (hba->clk_gating.active_reqs || hba->clk_gating.is_suspended ||
-	    hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
-	    hba->outstanding_tasks || !hba->clk_gating.is_initialized ||
-	    hba->active_uic_cmd || hba->uic_async_done ||
+	    !hba->clk_gating.is_initialized ||
 	    hba->clk_gating.state == CLKS_OFF)
 		return;
 
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (ufshcd_has_pending_tasks(hba) ||
+		    hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL)
+			return;
+	}
+
 	hba->clk_gating.state = REQ_CLKS_OFF;
 	trace_ufshcd_clk_gating(dev_name(hba->dev), hba->clk_gating.state);
 	queue_delayed_work(hba->clk_gating.clk_gating_workq,
@@ -2037,11 +2044,8 @@ static void __ufshcd_release(struct ufs_hba *hba)
 
 void ufshcd_release(struct ufs_hba *hba)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	guard(spinlock_irqsave)(&hba->clk_gating.lock);
 	__ufshcd_release(hba);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ufshcd_release);
 
@@ -2056,11 +2060,9 @@ static ssize_t ufshcd_clkgate_delay_show(struct device *dev,
 void ufshcd_clkgate_delay_set(struct device *dev, unsigned long value)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
-	unsigned long flags;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	guard(spinlock_irqsave)(&hba->clk_gating.lock);
 	hba->clk_gating.delay_ms = value;
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ufshcd_clkgate_delay_set);
 
@@ -2088,7 +2090,6 @@ static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
-	unsigned long flags;
 	u32 value;
 
 	if (kstrtou32(buf, 0, &value))
@@ -2096,9 +2097,10 @@ static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
 
 	value = !!value;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	guard(spinlock_irqsave)(&hba->clk_gating.lock);
+
 	if (value == hba->clk_gating.is_enabled)
-		goto out;
+		return count;
 
 	if (value)
 		__ufshcd_release(hba);
@@ -2106,8 +2108,7 @@ static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
 		hba->clk_gating.active_reqs++;
 
 	hba->clk_gating.is_enabled = value;
-out:
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
 	return count;
 }
 
@@ -8267,7 +8268,9 @@ static void ufshcd_rtc_work(struct work_struct *work)
 	hba = container_of(to_delayed_work(work), struct ufs_hba, ufs_rtc_update_work);
 
 	 /* Update RTC only when there are no requests in progress and UFSHCI is operational */
-	if (!ufshcd_is_ufs_dev_busy(hba) && hba->ufshcd_state == UFSHCD_STATE_OPERATIONAL)
+	if (!ufshcd_is_ufs_dev_busy(hba) &&
+	    hba->ufshcd_state == UFSHCD_STATE_OPERATIONAL &&
+	    !hba->clk_gating.active_reqs)
 		ufshcd_update_rtc(hba);
 
 	if (ufshcd_is_ufs_dev_active(hba) && hba->dev_info.rtc_update_period)
@@ -9186,7 +9189,6 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
 	int ret = 0;
 	struct ufs_clk_info *clki;
 	struct list_head *head = &hba->clk_list_head;
-	unsigned long flags;
 	ktime_t start = ktime_get();
 	bool clk_state_changed = false;
 
@@ -9236,12 +9238,11 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
 			if (!IS_ERR_OR_NULL(clki->clk) && clki->enabled)
 				clk_disable_unprepare(clki->clk);
 		}
-	} else if (!ret && on) {
-		spin_lock_irqsave(hba->host->host_lock, flags);
-		hba->clk_gating.state = CLKS_ON;
+	} else if (!ret && on && hba->clk_gating.is_initialized) {
+		scoped_guard(spinlock_irqsave, &hba->clk_gating.lock)
+			hba->clk_gating.state = CLKS_ON;
 		trace_ufshcd_clk_gating(dev_name(hba->dev),
 					hba->clk_gating.state);
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
 	}
 
 	if (clk_state_changed)
@@ -10450,6 +10451,12 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	hba->irq = irq;
 	hba->vps = &ufs_hba_vps;
 
+	/*
+	 * Initialize clk_gating.lock early since it is being used in
+	 * ufshcd_setup_clocks()
+	 */
+	spin_lock_init(&hba->clk_gating.lock);
+
 	err = ufshcd_hba_init(hba);
 	if (err)
 		goto out_error;
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 6b37d1c47fce..c2ecfa3c8349 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -371,7 +371,7 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 static void acm_ctrl_irq(struct urb *urb)
 {
 	struct acm *acm = urb->context;
-	struct usb_cdc_notification *dr = urb->transfer_buffer;
+	struct usb_cdc_notification *dr;
 	unsigned int current_size = urb->actual_length;
 	unsigned int expected_size, copy_size, alloc_size;
 	int retval;
@@ -398,14 +398,25 @@ static void acm_ctrl_irq(struct urb *urb)
 
 	usb_mark_last_busy(acm->dev);
 
-	if (acm->nb_index)
+	if (acm->nb_index == 0) {
+		/*
+		 * The first chunk of a message must contain at least the
+		 * notification header with the length field, otherwise we
+		 * can't get an expected_size.
+		 */
+		if (current_size < sizeof(struct usb_cdc_notification)) {
+			dev_dbg(&acm->control->dev, "urb too short\n");
+			goto exit;
+		}
+		dr = urb->transfer_buffer;
+	} else {
 		dr = (struct usb_cdc_notification *)acm->notification_buffer;
-
+	}
 	/* size = notification-header + (optional) data */
 	expected_size = sizeof(struct usb_cdc_notification) +
 					le16_to_cpu(dr->wLength);
 
-	if (current_size < expected_size) {
+	if (acm->nb_index != 0 || current_size < expected_size) {
 		/* notification is transmitted fragmented, reassemble */
 		if (acm->nb_size < expected_size) {
 			u8 *new_buffer;
@@ -1727,13 +1738,16 @@ static const struct usb_device_id acm_ids[] = {
 	{ USB_DEVICE(0x0870, 0x0001), /* Metricom GS Modem */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
-	{ USB_DEVICE(0x045b, 0x023c),	/* Renesas USB Download mode */
+	{ USB_DEVICE(0x045b, 0x023c),	/* Renesas R-Car H3 USB Download mode */
+	.driver_info = DISABLE_ECHO,	/* Don't echo banner */
+	},
+	{ USB_DEVICE(0x045b, 0x0247),	/* Renesas R-Car D3 USB Download mode */
 	.driver_info = DISABLE_ECHO,	/* Don't echo banner */
 	},
-	{ USB_DEVICE(0x045b, 0x0248),	/* Renesas USB Download mode */
+	{ USB_DEVICE(0x045b, 0x0248),	/* Renesas R-Car M3-N USB Download mode */
 	.driver_info = DISABLE_ECHO,	/* Don't echo banner */
 	},
-	{ USB_DEVICE(0x045b, 0x024D),	/* Renesas USB Download mode */
+	{ USB_DEVICE(0x045b, 0x024D),	/* Renesas R-Car E3 USB Download mode */
 	.driver_info = DISABLE_ECHO,	/* Don't echo banner */
 	},
 	{ USB_DEVICE(0x0e8d, 0x0003), /* FIREFLY, MediaTek Inc; andrey.arapov@gmail.com */
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 21ac9b464696..906daf423cb0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1847,6 +1847,17 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
 
+	/*
+	 * The USB 2.0 spec prohibits hubs from having more than one
+	 * configuration or interface, and we rely on this prohibition.
+	 * Refuse to accept a device that violates it.
+	 */
+	if (hdev->descriptor.bNumConfigurations > 1 ||
+			hdev->actconfig->desc.bNumInterfaces > 1) {
+		dev_err(&intf->dev, "Invalid hub with more than one config or interface\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Set default autosuspend delay as 0 to speedup bus suspend,
 	 * based on the below considerations:
@@ -4698,7 +4709,6 @@ void usb_ep0_reinit(struct usb_device *udev)
 EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 
 #define usb_sndaddr0pipe()	(PIPE_CONTROL << 30)
-#define usb_rcvaddr0pipe()	((PIPE_CONTROL << 30) | USB_DIR_IN)
 
 static int hub_set_address(struct usb_device *udev, int devnum)
 {
@@ -4804,7 +4814,7 @@ static int get_bMaxPacketSize0(struct usb_device *udev,
 	for (i = 0; i < GET_MAXPACKET0_TRIES; ++i) {
 		/* Start with invalid values in case the transfer fails */
 		buf->bDescriptorType = buf->bMaxPacketSize0 = 0;
-		rc = usb_control_msg(udev, usb_rcvaddr0pipe(),
+		rc = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
 				USB_DT_DEVICE << 8, 0,
 				buf, size,
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 13171454f959..027479179f09 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -432,6 +432,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0c45, 0x7056), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* Sony Xperia XZ1 Compact (lilac) smartphone in fastboot mode */
+	{ USB_DEVICE(0x0fce, 0x0dde), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Action Semiconductor flash disk */
 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
@@ -522,6 +525,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Blackmagic Design UltraStudio SDI */
 	{ USB_DEVICE(0x1edb, 0xbd4f), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* Teclast disk */
+	{ USB_DEVICE(0x1f75, 0x0917), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Hauppauge HVR-950q */
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index e7bf9cc635be..bd4c788f03bc 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4615,6 +4615,7 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 	spin_lock_irqsave(&hsotg->lock, flags);
 
 	hsotg->driver = NULL;
+	hsotg->gadget.dev.of_node = NULL;
 	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
 	hsotg->enabled = 0;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a5d75d7d0a87..8c80bb4a467b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2618,10 +2618,38 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 2000;
+	u32			saved_config = 0;
 
 	if (pm_runtime_suspended(dwc->dev))
 		return 0;
 
+	/*
+	 * When operating in USB 2.0 speeds (HS/FS), ensure that
+	 * GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY are cleared before starting
+	 * or stopping the controller. This resolves timeout issues that occur
+	 * during frequent role switches between host and device modes.
+	 *
+	 * Save and clear these settings, then restore them after completing the
+	 * controller start or stop sequence.
+	 *
+	 * This solution was discovered through experimentation as it is not
+	 * mentioned in the dwc3 programming guide. It has been tested on an
+	 * Exynos platforms.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (reg & DWC3_GUSB2PHYCFG_SUSPHY) {
+		saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	}
+
+	if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
+		saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
+		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+	}
+
+	if (saved_config)
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
 		if (DWC3_VER_IS_WITHIN(DWC3, ANY, 187A)) {
@@ -2649,6 +2677,12 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 		reg &= DWC3_DSTS_DEVCTRLHLT;
 	} while (--timeout && !(!is_on ^ !reg));
 
+	if (saved_config) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		reg |= saved_config;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	}
+
 	if (!timeout)
 		return -ETIMEDOUT;
 
diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 1067847cc079..4153643c67dc 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -907,6 +907,15 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = -ENODEV;
 
+	/*
+	 * Reset wMaxPacketSize with maximum packet size of FS bulk transfer before
+	 * endpoint claim. This ensures that the wMaxPacketSize does not exceed the
+	 * limit during bind retries where configured dwc3 TX/RX FIFO's maxpacket
+	 * size of 512 bytes for IN/OUT endpoints in support HS speed only.
+	 */
+	bulk_in_desc.wMaxPacketSize = cpu_to_le16(64);
+	bulk_out_desc.wMaxPacketSize = cpu_to_le16(64);
+
 	/* allocate instance-specific endpoints */
 	midi->in_ep = usb_ep_autoconfig(cdev->gadget, &bulk_in_desc);
 	if (!midi->in_ep)
@@ -1000,11 +1009,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 
 	/* configure the endpoint descriptors ... */
-	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
-	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
+	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
+	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
 
-	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
-	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
+	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
+	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
 
 	/* ... and add them to the list */
 	endpoint_descriptor_index = i;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index a6f46364be65..4b3d5075621a 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1543,8 +1543,8 @@ void usb_del_gadget(struct usb_gadget *gadget)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	sysfs_remove_link(&udc->dev.kobj, "gadget");
-	flush_work(&gadget->work);
 	device_del(&gadget->dev);
+	flush_work(&gadget->work);
 	ida_free(&gadget_id_numbers, gadget->id_number);
 	cancel_work_sync(&udc->vbus_work);
 	device_unregister(&udc->dev);
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 3b01734ce1b7..a93ad93390ba 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -310,7 +310,7 @@ struct renesas_usb3_request {
 	struct list_head	queue;
 };
 
-#define USB3_EP_NAME_SIZE	8
+#define USB3_EP_NAME_SIZE	16
 struct renesas_usb3_ep {
 	struct usb_ep ep;
 	struct renesas_usb3 *usb3;
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 1f9c1b1435d8..0404489c2f6a 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -958,6 +958,15 @@ static void quirk_usb_disable_ehci(struct pci_dev *pdev)
 	 * booting from USB disk or using a usb keyboard
 	 */
 	hcc_params = readl(base + EHCI_HCC_PARAMS);
+
+	/* LS7A EHCI controller doesn't have extended capabilities, the
+	 * EECP (EHCI Extended Capabilities Pointer) field of HCCPARAMS
+	 * register should be 0x0 but it reads as 0xa0.  So clear it to
+	 * avoid error messages on boot.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_LOONGSON && pdev->device == 0x7a14)
+		hcc_params &= ~(0xffL << 8);
+
 	offset = (hcc_params >> 8) & 0xff;
 	while (offset && --count) {
 		pci_read_config_dword(pdev, offset, &cap);
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 3ba9902dd209..deb3c98c9bea 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -656,8 +656,8 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
 }
 EXPORT_SYMBOL_NS_GPL(xhci_pci_common_probe, xhci);
 
-static const struct pci_device_id pci_ids_reject[] = {
-	/* handled by xhci-pci-renesas */
+/* handled by xhci-pci-renesas if enabled */
+static const struct pci_device_id pci_ids_renesas[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0014) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0015) },
 	{ /* end: all zeroes */ }
@@ -665,7 +665,8 @@ static const struct pci_device_id pci_ids_reject[] = {
 
 static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	if (pci_match_id(pci_ids_reject, dev))
+	if (IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS) &&
+			pci_match_id(pci_ids_renesas, dev))
 		return -ENODEV;
 
 	return xhci_pci_common_probe(dev, id);
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index c58a12c147f4..30482d4cf826 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -387,8 +387,11 @@ usb_role_switch_register(struct device *parent,
 	dev_set_name(&sw->dev, "%s-role-switch",
 		     desc->name ? desc->name : dev_name(parent));
 
+	sw->registered = true;
+
 	ret = device_register(&sw->dev);
 	if (ret) {
+		sw->registered = false;
 		put_device(&sw->dev);
 		return ERR_PTR(ret);
 	}
@@ -399,8 +402,6 @@ usb_role_switch_register(struct device *parent,
 			dev_warn(&sw->dev, "failed to add component\n");
 	}
 
-	sw->registered = true;
-
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 1e2ae0c6c41c..58bd54e8c483 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -619,15 +619,6 @@ static void option_instat_callback(struct urb *urb);
 /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
 #define LUAT_PRODUCT_AIR720U			0x4e00
 
-/* MeiG Smart Technology products */
-#define MEIGSMART_VENDOR_ID			0x2dee
-/* MeiG Smart SRM815/SRM825L based on Qualcomm 315 */
-#define MEIGSMART_PRODUCT_SRM825L		0x4d22
-/* MeiG Smart SLM320 based on UNISOC UIS8910 */
-#define MEIGSMART_PRODUCT_SLM320		0x4d41
-/* MeiG Smart SLM770A based on ASR1803 */
-#define MEIGSMART_PRODUCT_SLM770A		0x4d57
-
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -1367,15 +1358,15 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1063, 0xff),	/* Telit LN920 (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1070, 0xff),	/* Telit FN990 (rmnet) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1070, 0xff),	/* Telit FN990A (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1071, 0xff),	/* Telit FN990 (MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1071, 0xff),	/* Telit FN990A (MBIM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1072, 0xff),	/* Telit FN990 (RNDIS) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1072, 0xff),	/* Telit FN990A (RNDIS) */
 	  .driver_info = NCTRL(2) | RSVD(3) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990 (ECM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990A (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990 (PCIe) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990 (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
@@ -1403,6 +1394,22 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c8, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x60) },	/* Telit FN990B (rmnet) */
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x40) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x30),
+	  .driver_info = NCTRL(5) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x60) },	/* Telit FN990B (MBIM) */
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x40) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x30),
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x60) },	/* Telit FN990B (RNDIS) */
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x40) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x30),
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x60) },	/* Telit FN990B (ECM) */
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x40) },
+	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x30),
+	  .driver_info = NCTRL(6) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
@@ -2347,6 +2354,14 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a05, 0xff) },			/* Fibocom FM650-CN (NCM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a06, 0xff) },			/* Fibocom FM650-CN (RNDIS mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a07, 0xff) },			/* Fibocom FM650-CN (MBIM mode) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d41, 0xff, 0, 0) },		/* MeiG Smart SLM320 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d57, 0xff, 0, 0) },		/* MeiG Smart SLM770A */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0, 0) },		/* MeiG Smart SRM815 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0x10, 0x02) },	/* MeiG Smart SLM828 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0x10, 0x03) },	/* MeiG Smart SLM828 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x30) },	/* MeiG Smart SRM815 and SRM825L */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x40) },	/* MeiG Smart SRM825L */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x60) },	/* MeiG Smart SRM825L */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
@@ -2403,12 +2418,6 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM770A, 0xff, 0, 0) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0, 0) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
 	  .driver_info = NCTRL(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */
diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index a7fd018aa548..9e1c57baab64 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -17,12 +17,14 @@
 #define RESMEM_REGION_INDEX VFIO_PCI_BAR2_REGION_INDEX
 #define USEMEM_REGION_INDEX VFIO_PCI_BAR4_REGION_INDEX
 
-/* Memory size expected as non cached and reserved by the VM driver */
-#define RESMEM_SIZE SZ_1G
-
 /* A hardwired and constant ABI value between the GPU FW and VFIO driver. */
 #define MEMBLK_SIZE SZ_512M
 
+#define DVSEC_BITMAP_OFFSET 0xA
+#define MIG_SUPPORTED_WITH_CACHED_RESMEM BIT(0)
+
+#define GPU_CAP_DVSEC_REGISTER 3
+
 /*
  * The state of the two device memory region - resmem and usemem - is
  * saved as struct mem_region.
@@ -46,6 +48,7 @@ struct nvgrace_gpu_pci_core_device {
 	struct mem_region resmem;
 	/* Lock to control device memory kernel mapping */
 	struct mutex remap_lock;
+	bool has_mig_hw_bug;
 };
 
 static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
@@ -66,7 +69,7 @@ nvgrace_gpu_memregion(int index,
 	if (index == USEMEM_REGION_INDEX)
 		return &nvdev->usemem;
 
-	if (index == RESMEM_REGION_INDEX)
+	if (nvdev->resmem.memlength && index == RESMEM_REGION_INDEX)
 		return &nvdev->resmem;
 
 	return NULL;
@@ -751,40 +754,67 @@ nvgrace_gpu_init_nvdev_struct(struct pci_dev *pdev,
 			      u64 memphys, u64 memlength)
 {
 	int ret = 0;
+	u64 resmem_size = 0;
 
 	/*
-	 * The VM GPU device driver needs a non-cacheable region to support
-	 * the MIG feature. Since the device memory is mapped as NORMAL cached,
-	 * carve out a region from the end with a different NORMAL_NC
-	 * property (called as reserved memory and represented as resmem). This
-	 * region then is exposed as a 64b BAR (region 2 and 3) to the VM, while
-	 * exposing the rest (termed as usable memory and represented using usemem)
-	 * as cacheable 64b BAR (region 4 and 5).
+	 * On Grace Hopper systems, the VM GPU device driver needs a non-cacheable
+	 * region to support the MIG feature owing to a hardware bug. Since the
+	 * device memory is mapped as NORMAL cached, carve out a region from the end
+	 * with a different NORMAL_NC property (called as reserved memory and
+	 * represented as resmem). This region then is exposed as a 64b BAR
+	 * (region 2 and 3) to the VM, while exposing the rest (termed as usable
+	 * memory and represented using usemem) as cacheable 64b BAR (region 4 and 5).
 	 *
 	 *               devmem (memlength)
 	 * |-------------------------------------------------|
 	 * |                                           |
 	 * usemem.memphys                              resmem.memphys
+	 *
+	 * This hardware bug is fixed on the Grace Blackwell platforms and the
+	 * presence of the bug can be determined through nvdev->has_mig_hw_bug.
+	 * Thus on systems with the hardware fix, there is no need to partition
+	 * the GPU device memory and the entire memory is usable and mapped as
+	 * NORMAL cached (i.e. resmem size is 0).
 	 */
+	if (nvdev->has_mig_hw_bug)
+		resmem_size = SZ_1G;
+
 	nvdev->usemem.memphys = memphys;
 
 	/*
 	 * The device memory exposed to the VM is added to the kernel by the
-	 * VM driver module in chunks of memory block size. Only the usable
-	 * memory (usemem) is added to the kernel for usage by the VM
-	 * workloads. Make the usable memory size memblock aligned.
+	 * VM driver module in chunks of memory block size. Note that only the
+	 * usable memory (usemem) is added to the kernel for usage by the VM
+	 * workloads.
 	 */
-	if (check_sub_overflow(memlength, RESMEM_SIZE,
+	if (check_sub_overflow(memlength, resmem_size,
 			       &nvdev->usemem.memlength)) {
 		ret = -EOVERFLOW;
 		goto done;
 	}
 
 	/*
-	 * The USEMEM part of the device memory has to be MEMBLK_SIZE
-	 * aligned. This is a hardwired ABI value between the GPU FW and
-	 * VFIO driver. The VM device driver is also aware of it and make
-	 * use of the value for its calculation to determine USEMEM size.
+	 * The usemem region is exposed as a 64B Bar composed of region 4 and 5.
+	 * Calculate and save the BAR size for the region.
+	 */
+	nvdev->usemem.bar_size = roundup_pow_of_two(nvdev->usemem.memlength);
+
+	/*
+	 * If the hardware has the fix for MIG, there is no requirement
+	 * for splitting the device memory to create RESMEM. The entire
+	 * device memory is usable and will be USEMEM. Return here for
+	 * such case.
+	 */
+	if (!nvdev->has_mig_hw_bug)
+		goto done;
+
+	/*
+	 * When the device memory is split to workaround the MIG bug on
+	 * Grace Hopper, the USEMEM part of the device memory has to be
+	 * MEMBLK_SIZE aligned. This is a hardwired ABI value between the
+	 * GPU FW and VFIO driver. The VM device driver is also aware of it
+	 * and make use of the value for its calculation to determine USEMEM
+	 * size. Note that the device memory may not be 512M aligned.
 	 */
 	nvdev->usemem.memlength = round_down(nvdev->usemem.memlength,
 					     MEMBLK_SIZE);
@@ -803,15 +833,34 @@ nvgrace_gpu_init_nvdev_struct(struct pci_dev *pdev,
 	}
 
 	/*
-	 * The memory regions are exposed as BARs. Calculate and save
-	 * the BAR size for them.
+	 * The resmem region is exposed as a 64b BAR composed of region 2 and 3
+	 * for Grace Hopper. Calculate and save the BAR size for the region.
 	 */
-	nvdev->usemem.bar_size = roundup_pow_of_two(nvdev->usemem.memlength);
 	nvdev->resmem.bar_size = roundup_pow_of_two(nvdev->resmem.memlength);
 done:
 	return ret;
 }
 
+static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
+{
+	int pcie_dvsec;
+	u16 dvsec_ctrl16;
+
+	pcie_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_NVIDIA,
+					       GPU_CAP_DVSEC_REGISTER);
+
+	if (pcie_dvsec) {
+		pci_read_config_word(pdev,
+				     pcie_dvsec + DVSEC_BITMAP_OFFSET,
+				     &dvsec_ctrl16);
+
+		if (dvsec_ctrl16 & MIG_SUPPORTED_WITH_CACHED_RESMEM)
+			return false;
+	}
+
+	return true;
+}
+
 static int nvgrace_gpu_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *id)
 {
@@ -832,6 +881,8 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
 
 	if (ops == &nvgrace_gpu_pci_ops) {
+		nvdev->has_mig_hw_bug = nvgrace_gpu_has_mig_hw_bug(pdev);
+
 		/*
 		 * Device memory properties are identified in the host ACPI
 		 * table. Set the nvgrace_gpu_pci_core_device structure.
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 66b72c289284..a0595c745732 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/vfio.h>
 #include <linux/vgaarb.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "vfio_pci_priv.h"
 
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index d63c2d266d07..3bf1043cd795 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -393,11 +393,6 @@ static ssize_t vfio_platform_read_mmio(struct vfio_platform_region *reg,
 
 	count = min_t(size_t, count, reg->size - off);
 
-	if (off >= reg->size)
-		return -EINVAL;
-
-	count = min_t(size_t, count, reg->size - off);
-
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap(reg->addr, reg->size);
@@ -482,11 +477,6 @@ static ssize_t vfio_platform_write_mmio(struct vfio_platform_region *reg,
 
 	count = min_t(size_t, count, reg->size - off);
 
-	if (off >= reg->size)
-		return -EINVAL;
-
-	count = min_t(size_t, count, reg->size - off);
-
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap(reg->addr, reg->size);
diff --git a/drivers/video/fbdev/omap/lcd_dma.c b/drivers/video/fbdev/omap/lcd_dma.c
index f85817635a8c..0da23c57e475 100644
--- a/drivers/video/fbdev/omap/lcd_dma.c
+++ b/drivers/video/fbdev/omap/lcd_dma.c
@@ -432,8 +432,8 @@ static int __init omap_init_lcd_dma(void)
 
 	spin_lock_init(&lcd_dma.lock);
 
-	r = request_irq(INT_DMA_LCD, lcd_dma_irq_handler, 0,
-			"LCD DMA", NULL);
+	r = request_threaded_irq(INT_DMA_LCD, NULL, lcd_dma_irq_handler,
+				 IRQF_ONESHOT, "LCD DMA", NULL);
 	if (r != 0)
 		pr_err("unable to request IRQ for LCD DMA (error %d)\n", r);
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a337edcf8faf..26c62e0d34e9 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -74,19 +74,21 @@ static inline phys_addr_t xen_dma_to_phys(struct device *dev,
 	return xen_bus_to_phys(dev, dma_to_phys(dev, dma_addr));
 }
 
+static inline bool range_requires_alignment(phys_addr_t p, size_t size)
+{
+	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
+	phys_addr_t bus_addr = pfn_to_bfn(XEN_PFN_DOWN(p)) << XEN_PAGE_SHIFT;
+
+	return IS_ALIGNED(p, algn) && !IS_ALIGNED(bus_addr, algn);
+}
+
 static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
 	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
 	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
-	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
 
 	next_bfn = pfn_to_bfn(xen_pfn);
 
-	/* If buffer is physically aligned, ensure DMA alignment. */
-	if (IS_ALIGNED(p, algn) &&
-	    !IS_ALIGNED((phys_addr_t)next_bfn << XEN_PAGE_SHIFT, algn))
-		return 1;
-
 	for (i = 1; i < nr_pages; i++)
 		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
 			return 1;
@@ -156,7 +158,8 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
 
 	*dma_handle = xen_phys_to_dma(dev, phys);
 	if (*dma_handle + size - 1 > dma_mask ||
-	    range_straddles_page_boundary(phys, size)) {
+	    range_straddles_page_boundary(phys, size) ||
+	    range_requires_alignment(phys, size)) {
 		if (xen_create_contiguous_region(phys, order, fls64(dma_mask),
 				dma_handle) != 0)
 			goto out_free_pages;
@@ -182,7 +185,8 @@ xen_swiotlb_free_coherent(struct device *dev, size_t size, void *vaddr,
 	size = ALIGN(size, XEN_PAGE_SIZE);
 
 	if (WARN_ON_ONCE(dma_handle + size - 1 > dev->coherent_dma_mask) ||
-	    WARN_ON_ONCE(range_straddles_page_boundary(phys, size)))
+	    WARN_ON_ONCE(range_straddles_page_boundary(phys, size) ||
+			 range_requires_alignment(phys, size)))
 	    	return;
 
 	if (TestClearPageXenRemapped(virt_to_page(vaddr)))
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 42c9899d9241..fe08c983d5bb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -901,12 +901,11 @@ void clear_folio_extent_mapped(struct folio *folio)
 	folio_detach_private(folio);
 }
 
-static struct extent_map *__get_extent_map(struct inode *inode,
-					   struct folio *folio, u64 start,
-					   u64 len, struct extent_map **em_cached)
+static struct extent_map *get_extent_map(struct btrfs_inode *inode,
+					 struct folio *folio, u64 start,
+					 u64 len, struct extent_map **em_cached)
 {
 	struct extent_map *em;
-	struct extent_state *cached_state = NULL;
 
 	ASSERT(em_cached);
 
@@ -922,14 +921,12 @@ static struct extent_map *__get_extent_map(struct inode *inode,
 		*em_cached = NULL;
 	}
 
-	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, start + len - 1, &cached_state);
-	em = btrfs_get_extent(BTRFS_I(inode), folio, start, len);
+	em = btrfs_get_extent(inode, folio, start, len);
 	if (!IS_ERR(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
 		*em_cached = em;
 	}
-	unlock_extent(&BTRFS_I(inode)->io_tree, start, start + len - 1, &cached_state);
 
 	return em;
 }
@@ -985,8 +982,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			end_folio_read(folio, true, cur, iosize);
 			break;
 		}
-		em = __get_extent_map(inode, folio, cur, end - cur + 1,
-				      em_cached);
+		em = get_extent_map(BTRFS_I(inode), folio, cur, end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
 			end_folio_read(folio, false, cur, end + 1 - cur);
 			return PTR_ERR(em);
@@ -1087,11 +1083,18 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct btrfs_inode *inode = folio_to_inode(folio);
+	const u64 start = folio_pos(folio);
+	const u64 end = start + folio_size(folio) - 1;
+	struct extent_state *cached_state = NULL;
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
 	struct extent_map *em_cached = NULL;
 	int ret;
 
+	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
+	unlock_extent(&inode->io_tree, start, end, &cached_state);
+
 	free_extent_map(em_cached);
 
 	/*
@@ -2268,12 +2271,20 @@ void btrfs_readahead(struct readahead_control *rac)
 {
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
 	struct folio *folio;
+	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
+	const u64 start = readahead_pos(rac);
+	const u64 end = start + readahead_length(rac) - 1;
+	struct extent_state *cached_state = NULL;
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
 
+	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
+
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
 
+	unlock_extent(&inode->io_tree, start, end, &cached_state);
+
 	if (em_cached)
 		free_extent_map(em_cached);
 	submit_one_bio(&bio_ctrl);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 559c177456e6..848cb2c3d9dd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1148,7 +1148,6 @@ int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from, size_t count)
 	loff_t pos = iocb->ki_pos;
 	int ret;
 	loff_t oldsize;
-	loff_t start_pos;
 
 	/*
 	 * Quickly bail out on NOWAIT writes if we don't have the nodatacow or
@@ -1172,9 +1171,8 @@ int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from, size_t count)
 	 */
 	update_time_for_write(inode);
 
-	start_pos = round_down(pos, fs_info->sectorsize);
 	oldsize = i_size_read(inode);
-	if (start_pos > oldsize) {
+	if (pos > oldsize) {
 		/* Expand hole size to cover write data, preventing empty gap */
 		loff_t end_pos = round_up(pos + count, fs_info->sectorsize);
 
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index bf378ecd5d9f..7b59a40d40c0 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -280,9 +280,9 @@ void nfs_sysfs_link_rpc_client(struct nfs_server *server,
 	char name[RPC_CLIENT_NAME_SIZE];
 	int ret;
 
-	strcpy(name, clnt->cl_program->name);
-	strcat(name, uniq ? uniq : "");
-	strcat(name, "_client");
+	strscpy(name, clnt->cl_program->name, sizeof(name));
+	strncat(name, uniq ? uniq : "", sizeof(name) - strlen(name) - 1);
+	strncat(name, "_client", sizeof(name) - strlen(name) - 1);
 
 	ret = sysfs_create_link_nowarn(&server->kobj,
 						&clnt->cl_sysfs->kobject, name);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 146a9463c3c2..d19968881855 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 						struct nfsd_file, nf_gc);
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
 		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
+		struct svc_serv *serv;
 
 		spin_lock(&l->lock);
 		list_move_tail(&nf->nf_gc, &l->freeme);
 		spin_unlock(&l->lock);
-		svc_wake_up(nn->nfsd_serv);
+
+		/*
+		 * The filecache laundrette is shut down after the
+		 * nn->nfsd_serv pointer is cleared, but before the
+		 * svc_serv is freed.
+		 */
+		serv = nn->nfsd_serv;
+		if (serv)
+			svc_wake_up(serv);
 	}
 }
 
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 4e3be7201b1c..5fb202acb0fd 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -84,6 +84,8 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 fail:
 	posix_acl_release(resp->acl_access);
 	posix_acl_release(resp->acl_default);
+	resp->acl_access = NULL;
+	resp->acl_default = NULL;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 5e34e98db969..7b5433bd3019 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -76,6 +76,8 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 fail:
 	posix_acl_release(resp->acl_access);
 	posix_acl_release(resp->acl_default);
+	resp->acl_access = NULL;
+	resp->acl_default = NULL;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index de0763652549..88c03e182573 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1486,8 +1486,11 @@ nfsd4_run_cb_work(struct work_struct *work)
 		nfsd4_process_cb_update(cb);
 
 	clnt = clp->cl_cb_client;
-	if (!clnt) {
-		/* Callback channel broken, or client killed; give up: */
+	if (!clnt || clp->cl_state == NFSD4_COURTESY) {
+		/*
+		 * Callback channel broken, client killed or
+		 * nfs4_client in courtesy state; give up.
+		 */
 		nfsd41_destroy_cb(cb);
 		return;
 	}
diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 8d789b017fa9..da1a9312e61a 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1406,7 +1406,7 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 	 */
 	if (!attr->non_res) {
 		if (vbo[1] + bytes_per_off > le32_to_cpu(attr->res.data_size)) {
-			ntfs_inode_err(&ni->vfs_inode, "is corrupted");
+			_ntfs_bad_inode(&ni->vfs_inode);
 			return -EINVAL;
 		}
 		addr = resident_data(attr);
@@ -2587,7 +2587,7 @@ int attr_force_nonresident(struct ntfs_inode *ni)
 
 	attr = ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL, &mi);
 	if (!attr) {
-		ntfs_bad_inode(&ni->vfs_inode, "no data attribute");
+		_ntfs_bad_inode(&ni->vfs_inode);
 		return -ENOENT;
 	}
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index fc6a8aa29e3a..b6da80c69ca6 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -512,7 +512,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = pos;
 	} else if (err < 0) {
 		if (err == -EINVAL)
-			ntfs_inode_err(dir, "directory corrupted");
+			_ntfs_bad_inode(dir);
 		ctx->pos = eod;
 	}
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index c33e818b3164..175662acd5ea 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -148,8 +148,10 @@ int ni_load_mi_ex(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
 		goto out;
 
 	err = mi_get(ni->mi.sbi, rno, &r);
-	if (err)
+	if (err) {
+		_ntfs_bad_inode(&ni->vfs_inode);
 		return err;
+	}
 
 	ni_add_mi(ni, r);
 
@@ -238,8 +240,7 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 	return attr;
 
 out:
-	ntfs_inode_err(&ni->vfs_inode, "failed to parse mft record");
-	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+	_ntfs_bad_inode(&ni->vfs_inode);
 	return NULL;
 }
 
@@ -330,6 +331,7 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	    vcn <= le64_to_cpu(attr->nres.evcn))
 		return attr;
 
+	_ntfs_bad_inode(&ni->vfs_inode);
 	return NULL;
 }
 
@@ -1604,8 +1606,8 @@ int ni_delete_all(struct ntfs_inode *ni)
 		roff = le16_to_cpu(attr->nres.run_off);
 
 		if (roff > asize) {
-			_ntfs_bad_inode(&ni->vfs_inode);
-			return -EINVAL;
+			/* ni_enum_attr_ex checks this case. */
+			continue;
 		}
 
 		/* run==1 means unpack and deallocate. */
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 0fa636038b4e..6c73e93afb47 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -908,7 +908,11 @@ void ntfs_bad_inode(struct inode *inode, const char *hint)
 
 	ntfs_inode_err(inode, "%s", hint);
 	make_bad_inode(inode);
-	ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+	/* Avoid recursion if bad inode is $Volume. */
+	if (inode->i_ino != MFT_REC_VOL &&
+	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING)) {
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+	}
 }
 
 /*
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 9089c58a005c..7eb9fae22f8d 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1094,8 +1094,7 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 
 ok:
 	if (!index_buf_check(ib, bytes, &vbn)) {
-		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
-		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		_ntfs_bad_inode(&ni->vfs_inode);
 		err = -EINVAL;
 		goto out;
 	}
@@ -1117,8 +1116,7 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 
 out:
 	if (err == -E_NTFS_CORRUPT) {
-		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
-		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		_ntfs_bad_inode(&ni->vfs_inode);
 		err = -EINVAL;
 	}
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index be04d2845bb7..a1e11228dafd 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -410,6 +410,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	if (!std5)
 		goto out;
 
+	if (is_bad_inode(inode))
+		goto out;
+
 	if (!is_match && name) {
 		err = -ENOENT;
 		goto out;
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 1b508f543384..fa41db088488 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -393,9 +393,9 @@ static ssize_t orangefs_debug_write(struct file *file,
 	 * Thwart users who try to jamb a ridiculous number
 	 * of bytes into the debug file...
 	 */
-	if (count > ORANGEFS_MAX_DEBUG_STRING_LEN + 1) {
+	if (count > ORANGEFS_MAX_DEBUG_STRING_LEN) {
 		silly = count;
-		count = ORANGEFS_MAX_DEBUG_STRING_LEN + 1;
+		count = ORANGEFS_MAX_DEBUG_STRING_LEN;
 	}
 
 	buf = kzalloc(ORANGEFS_MAX_DEBUG_STRING_LEN, GFP_KERNEL);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 94785abc9b1b..05274121e46f 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1476,7 +1476,6 @@ struct cifs_io_parms {
 struct cifs_io_request {
 	struct netfs_io_request		rreq;
 	struct cifsFileInfo		*cfile;
-	struct TCP_Server_Info		*server;
 	pid_t				pid;
 };
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index a58a3333ecc3..313c851fc1c1 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -147,7 +147,7 @@ static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
-	struct TCP_Server_Info *server = req->server;
+	struct TCP_Server_Info *server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
 	size_t size;
 	int rc = 0;
@@ -156,6 +156,8 @@ static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
 		rdata->xid = get_xid();
 		rdata->have_xid = true;
 	}
+
+	server = cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
 	rdata->server = server;
 
 	if (cifs_sb->ctx->rsize == 0)
@@ -198,7 +200,7 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
-	struct TCP_Server_Info *server = req->server;
+	struct TCP_Server_Info *server = rdata->server;
 	int rc = 0;
 
 	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
@@ -265,7 +267,6 @@ static int cifs_init_request(struct netfs_io_request *rreq, struct file *file)
 		open_file = file->private_data;
 		rreq->netfs_priv = file->private_data;
 		req->cfile = cifsFileInfo_get(open_file);
-		req->server = cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
 			req->pid = req->cfile->pid;
 	} else if (rreq->origin != NETFS_WRITEBACK) {
diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index a6f8b098c56f..3bd9f482f0c3 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -359,6 +359,7 @@
 # define DP_DSC_BITS_PER_PIXEL_1_4          0x2
 # define DP_DSC_BITS_PER_PIXEL_1_2          0x3
 # define DP_DSC_BITS_PER_PIXEL_1_1          0x4
+# define DP_DSC_BITS_PER_PIXEL_MASK         0x7
 
 #define DP_PSR_SUPPORT                      0x070   /* XXX 1.2? */
 # define DP_PSR_IS_SUPPORTED                1
diff --git a/include/kunit/platform_device.h b/include/kunit/platform_device.h
index 0fc0999d2420..f8236a8536f7 100644
--- a/include/kunit/platform_device.h
+++ b/include/kunit/platform_device.h
@@ -2,6 +2,7 @@
 #ifndef _KUNIT_PLATFORM_DRIVER_H
 #define _KUNIT_PLATFORM_DRIVER_H
 
+struct completion;
 struct kunit;
 struct platform_device;
 struct platform_driver;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c5063e0a38a0..a53cbe256910 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -880,12 +880,22 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 				       void (*complete)(struct io_comp_batch *))
 {
 	/*
-	 * blk_mq_end_request_batch() can't end request allocated from
-	 * sched tags
+	 * Check various conditions that exclude batch processing:
+	 * 1) No batch container
+	 * 2) Has scheduler data attached
+	 * 3) Not a passthrough request and end_io set
+	 * 4) Not a passthrough request and an ioerror
 	 */
-	if (!iob || (req->rq_flags & RQF_SCHED_TAGS) || ioerror ||
-			(req->end_io && !blk_rq_is_passthrough(req)))
+	if (!iob)
 		return false;
+	if (req->rq_flags & RQF_SCHED_TAGS)
+		return false;
+	if (!blk_rq_is_passthrough(req)) {
+		if (req->end_io)
+			return false;
+		if (ioerror < 0)
+			return false;
+	}
 
 	if (!iob->complete)
 		iob->complete = complete;
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 47ae4c4d924c..a32eebcd23da 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -71,9 +71,6 @@ enum {
 
 	/* Cgroup is frozen. */
 	CGRP_FROZEN,
-
-	/* Control group has to be killed. */
-	CGRP_KILL,
 };
 
 /* cgroup_root->flags */
@@ -460,6 +457,9 @@ struct cgroup {
 
 	int nr_threaded_children;	/* # of live threaded child cgroups */
 
+	/* sequence number for cgroup.kill, serialized by css_set_lock. */
+	unsigned int kill_seq;
+
 	struct kernfs_node *kn;		/* cgroup kernfs entry */
 	struct cgroup_file procs_file;	/* handle for "cgroup.procs" */
 	struct cgroup_file events_file;	/* handle for "cgroup.events" */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e28d88066033..2f1bfd7562eb 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -128,6 +128,7 @@ typedef	struct {
 #define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
 #define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* soft reserved */
 #define EFI_MEMORY_CPU_CRYPTO	((u64)0x0000000000080000ULL)	/* supports encryption */
+#define EFI_MEMORY_HOT_PLUGGABLE	BIT_ULL(20)	/* supports unplugging at runtime */
 #define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
 #define EFI_MEMORY_DESCRIPTOR_VERSION	1
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 02d3bafebbe7..4f17b786828a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2577,6 +2577,12 @@ struct net *dev_net(const struct net_device *dev)
 	return read_pnet(&dev->nd_net);
 }
 
+static inline
+struct net *dev_net_rcu(const struct net_device *dev)
+{
+	return read_pnet_rcu(&dev->nd_net);
+}
+
 static inline
 void dev_net_set(struct net_device *dev, struct net *net)
 {
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4cf6aaed5f35..22f6b018cff8 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2589,6 +2589,11 @@
 
 #define PCI_VENDOR_ID_REDHAT		0x1b36
 
+#define PCI_VENDOR_ID_WCHIC		0x1c00
+#define PCI_DEVICE_ID_WCHIC_CH382_0S1P	0x3050
+#define PCI_DEVICE_ID_WCHIC_CH382_2S1P	0x3250
+#define PCI_DEVICE_ID_WCHIC_CH382_2S	0x3253
+
 #define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c
 
 #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
@@ -2643,6 +2648,12 @@
 #define PCI_VENDOR_ID_AKS		0x416c
 #define PCI_DEVICE_ID_AKS_ALADDINCARD	0x0100
 
+#define PCI_VENDOR_ID_WCHCN		0x4348
+#define PCI_DEVICE_ID_WCHCN_CH353_4S	0x3453
+#define PCI_DEVICE_ID_WCHCN_CH353_2S1PF	0x5046
+#define PCI_DEVICE_ID_WCHCN_CH353_1S1P	0x5053
+#define PCI_DEVICE_ID_WCHCN_CH353_2S1P	0x7053
+
 #define PCI_VENDOR_ID_ACCESSIO		0x494f
 #define PCI_DEVICE_ID_ACCESSIO_WDG_CSM	0x22c0
 
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0f2aeb37bbb0..ca1db4b92c32 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -43,6 +43,7 @@ struct kernel_clone_args {
 	void *fn_arg;
 	struct cgroup *cgrp;
 	struct css_set *cset;
+	unsigned int kill_seq;
 };
 
 /*
diff --git a/include/net/dst.h b/include/net/dst.h
index 0f303cc60252..08647c99d79c 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -440,6 +440,15 @@ static inline void dst_set_expires(struct dst_entry *dst, int timeout)
 		dst->expires = expires;
 }
 
+static inline unsigned int dst_dev_overhead(struct dst_entry *dst,
+					    struct sk_buff *skb)
+{
+	if (likely(dst))
+		return LL_RESERVED_SPACE(dst->dev);
+
+	return skb->mac_len;
+}
+
 INDIRECT_CALLABLE_DECLARE(int ip6_output(struct net *, struct sock *,
 					 struct sk_buff *));
 INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
diff --git a/include/net/ip.h b/include/net/ip.h
index d92d3bc3ec0e..fe4f85438114 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -465,9 +465,12 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
 	const struct rtable *rt = dst_rtable(dst);
-	struct net *net = dev_net(dst->dev);
-	unsigned int mtu;
+	unsigned int mtu, res;
+	struct net *net;
+
+	rcu_read_lock();
 
+	net = dev_net_rcu(dst->dev);
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
 	    ip_mtu_locked(dst) ||
 	    !forwarding) {
@@ -491,7 +494,11 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 out:
 	mtu = min_t(unsigned int, mtu, IP_MAX_MTU);
 
-	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+
+	rcu_read_unlock();
+
+	return res;
 }
 
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
diff --git a/include/net/l3mdev.h b/include/net/l3mdev.h
index 031c661aa14d..bdfa9d414360 100644
--- a/include/net/l3mdev.h
+++ b/include/net/l3mdev.h
@@ -198,10 +198,12 @@ struct sk_buff *l3mdev_l3_out(struct sock *sk, struct sk_buff *skb, u16 proto)
 	if (netif_is_l3_slave(dev)) {
 		struct net_device *master;
 
+		rcu_read_lock();
 		master = netdev_master_upper_dev_get_rcu(dev);
 		if (master && master->l3mdev_ops->l3mdev_l3_out)
 			skb = master->l3mdev_ops->l3mdev_l3_out(master, sk,
 								skb, proto);
+		rcu_read_unlock();
 	}
 
 	return skb;
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 9398c8f49953..da93873df4db 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -387,7 +387,7 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
 #endif
 }
 
-static inline struct net *read_pnet_rcu(possible_net_t *pnet)
+static inline struct net *read_pnet_rcu(const possible_net_t *pnet)
 {
 #ifdef CONFIG_NET_NS
 	return rcu_dereference(pnet->net);
diff --git a/include/net/route.h b/include/net/route.h
index 1789f1e6640b..da34b6fa9862 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -363,10 +363,15 @@ static inline int inet_iif(const struct sk_buff *skb)
 static inline int ip4_dst_hoplimit(const struct dst_entry *dst)
 {
 	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
-	struct net *net = dev_net(dst->dev);
 
-	if (hoplimit == 0)
+	if (hoplimit == 0) {
+		const struct net *net;
+
+		rcu_read_lock();
+		net = dev_net_rcu(dst->dev);
 		hoplimit = READ_ONCE(net->ipv4.sysctl_ip_default_ttl);
+		rcu_read_unlock();
+	}
 	return hoplimit;
 }
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index d5e43a1dcff2..47cba116f87b 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -402,6 +402,9 @@ enum clk_gating_state {
  * delay_ms
  * @ungate_work: worker to turn on clocks that will be used in case of
  * interrupt context
+ * @clk_gating_workq: workqueue for clock gating work.
+ * @lock: serialize access to some struct ufs_clk_gating members. An outer lock
+ * relative to the host lock
  * @state: the current clocks state
  * @delay_ms: gating delay in ms
  * @is_suspended: clk gating is suspended when set to 1 which can be used
@@ -412,11 +415,14 @@ enum clk_gating_state {
  * @is_initialized: Indicates whether clock gating is initialized or not
  * @active_reqs: number of requests that are pending and should be waited for
  * completion before gating clocks.
- * @clk_gating_workq: workqueue for clock gating work.
  */
 struct ufs_clk_gating {
 	struct delayed_work gate_work;
 	struct work_struct ungate_work;
+	struct workqueue_struct *clk_gating_workq;
+
+	spinlock_t lock;
+
 	enum clk_gating_state state;
 	unsigned long delay_ms;
 	bool is_suspended;
@@ -425,7 +431,6 @@ struct ufs_clk_gating {
 	bool is_enabled;
 	bool is_initialized;
 	int active_reqs;
-	struct workqueue_struct *clk_gating_workq;
 };
 
 /**
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index eec5eb7de843..e1895952066e 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -420,6 +420,12 @@ void io_destroy_buffers(struct io_ring_ctx *ctx)
 	}
 }
 
+static void io_destroy_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
+{
+	xa_erase(&ctx->io_bl_xa, bl->bgid);
+	io_put_bl(ctx, bl);
+}
+
 int io_remove_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_provide_buf *p = io_kiocb_to_cmd(req, struct io_provide_buf);
@@ -717,12 +723,13 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		/* if mapped buffer ring OR classic exists, don't allow */
 		if (bl->flags & IOBL_BUF_RING || !list_empty(&bl->buf_list))
 			return -EEXIST;
-	} else {
-		free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL);
-		if (!bl)
-			return -ENOMEM;
+		io_destroy_bl(ctx, bl);
 	}
 
+	free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL);
+	if (!bl)
+		return -ENOMEM;
+
 	if (!(reg.flags & IOU_PBUF_RING_MMAP))
 		ret = io_pin_pbuf_ring(&reg, bl);
 	else
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 874f9e2defd5..b2ce4b561002 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -65,9 +65,6 @@ bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
 			continue;
 
 		if (cmd->flags & IORING_URING_CMD_CANCELABLE) {
-			/* ->sqe isn't available if no async data */
-			if (!req_has_async_data(req))
-				cmd->sqe = NULL;
 			file->f_op->uring_cmd(cmd, IO_URING_F_CANCEL |
 						   IO_URING_F_COMPLETE_DEFER);
 			ret = true;
diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 6362ec20abc0..2f7b5eeab845 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -118,7 +118,6 @@ static int io_waitid_finish(struct io_kiocb *req, int ret)
 static void io_waitid_complete(struct io_kiocb *req, int ret)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
-	struct io_tw_state ts = {};
 
 	/* anyone completing better be holding a reference */
 	WARN_ON_ONCE(!(atomic_read(&iw->refs) & IO_WAITID_REF_MASK));
@@ -131,7 +130,6 @@ static void io_waitid_complete(struct io_kiocb *req, int ret)
 	if (ret < 0)
 		req_set_fail(req);
 	io_req_set_res(req, ret, 0);
-	io_req_task_complete(req, &ts);
 }
 
 static bool __io_waitid_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req)
@@ -153,6 +151,7 @@ static bool __io_waitid_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	list_del_init(&iwa->wo.child_wait.entry);
 	spin_unlock_irq(&iw->head->lock);
 	io_waitid_complete(req, -ECANCELED);
+	io_req_queue_tw_complete(req, -ECANCELED);
 	return true;
 }
 
@@ -258,6 +257,7 @@ static void io_waitid_cb(struct io_kiocb *req, struct io_tw_state *ts)
 	}
 
 	io_waitid_complete(req, ret);
+	io_req_task_complete(req, ts);
 }
 
 static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e275eaf2de7f..216535e055e1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4013,7 +4013,7 @@ static void __cgroup_kill(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_mutex);
 
 	spin_lock_irq(&css_set_lock);
-	set_bit(CGRP_KILL, &cgrp->flags);
+	cgrp->kill_seq++;
 	spin_unlock_irq(&css_set_lock);
 
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
@@ -4029,10 +4029,6 @@ static void __cgroup_kill(struct cgroup *cgrp)
 		send_sig(SIGKILL, task, 0);
 	}
 	css_task_iter_end(&it);
-
-	spin_lock_irq(&css_set_lock);
-	clear_bit(CGRP_KILL, &cgrp->flags);
-	spin_unlock_irq(&css_set_lock);
 }
 
 static void cgroup_kill(struct cgroup *cgrp)
@@ -6489,6 +6485,10 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	spin_lock_irq(&css_set_lock);
 	cset = task_css_set(current);
 	get_css_set(cset);
+	if (kargs->cgrp)
+		kargs->kill_seq = kargs->cgrp->kill_seq;
+	else
+		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
 	spin_unlock_irq(&css_set_lock);
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
@@ -6672,6 +6672,7 @@ void cgroup_post_fork(struct task_struct *child,
 		      struct kernel_clone_args *kargs)
 	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
 {
+	unsigned int cgrp_kill_seq = 0;
 	unsigned long cgrp_flags = 0;
 	bool kill = false;
 	struct cgroup_subsys *ss;
@@ -6685,10 +6686,13 @@ void cgroup_post_fork(struct task_struct *child,
 
 	/* init tasks are special, only link regular threads */
 	if (likely(child->pid)) {
-		if (kargs->cgrp)
+		if (kargs->cgrp) {
 			cgrp_flags = kargs->cgrp->flags;
-		else
+			cgrp_kill_seq = kargs->cgrp->kill_seq;
+		} else {
 			cgrp_flags = cset->dfl_cgrp->flags;
+			cgrp_kill_seq = cset->dfl_cgrp->kill_seq;
+		}
 
 		WARN_ON_ONCE(!list_empty(&child->cg_list));
 		cset->nr_tasks++;
@@ -6723,7 +6727,7 @@ void cgroup_post_fork(struct task_struct *child,
 		 * child down right after we finished preparing it for
 		 * userspace.
 		 */
-		kill = test_bit(CGRP_KILL, &cgrp_flags);
+		kill = kargs->kill_seq != cgrp_kill_seq;
 	}
 
 	spin_unlock_irq(&css_set_lock);
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a06b45272411..ce295b73c0a3 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -586,7 +586,6 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 
 		cputime->sum_exec_runtime += user;
 		cputime->sum_exec_runtime += sys;
-		cputime->sum_exec_runtime += cpustat[CPUTIME_STEAL];
 
 #ifdef CONFIG_SCHED_CORE
 		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index db68a964e34e..c4a3ccf6a8ac 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -150,7 +150,7 @@ void sched_autogroup_exit_task(struct task_struct *p)
 	 * see this thread after that: we can no longer use signal->autogroup.
 	 * See the PF_EXITING check in task_wants_autogroup().
 	 */
-	sched_move_task(p);
+	sched_move_task(p, true);
 }
 
 static void
@@ -182,7 +182,7 @@ autogroup_move_group(struct task_struct *p, struct autogroup *ag)
 	 * sched_autogroup_exit_task().
 	 */
 	for_each_thread(p, t)
-		sched_move_task(t);
+		sched_move_task(t, true);
 
 	unlock_task_sighand(p, &flags);
 	autogroup_kref_put(prev);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5d67f41d05d4..c72356836eb6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8953,7 +8953,7 @@ static void sched_change_group(struct task_struct *tsk, struct task_group *group
  * now. This function just updates tsk->se.cfs_rq and tsk->se.parent to reflect
  * its new group.
  */
-void sched_move_task(struct task_struct *tsk)
+void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 {
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -8982,7 +8982,8 @@ void sched_move_task(struct task_struct *tsk)
 		put_prev_task(rq, tsk);
 
 	sched_change_group(tsk, group);
-	scx_move_task(tsk);
+	if (!for_autogroup)
+		scx_cgroup_move_task(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -9083,7 +9084,7 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 
 	cgroup_taskset_for_each(task, css, tset)
-		sched_move_task(task);
+		sched_move_task(task, false);
 
 	scx_cgroup_finish_attach();
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4c4681cb9337..689f7e8f69f5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2458,6 +2458,9 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 {
 	struct rq *src_rq = task_rq(p);
 	struct rq *dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
+#ifdef CONFIG_SMP
+	struct rq *locked_rq = rq;
+#endif
 
 	/*
 	 * We're synchronized against dequeue through DISPATCHING. As @p can't
@@ -2494,8 +2497,9 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
 
 	/* switch to @src_rq lock */
-	if (rq != src_rq) {
-		raw_spin_rq_unlock(rq);
+	if (locked_rq != src_rq) {
+		raw_spin_rq_unlock(locked_rq);
+		locked_rq = src_rq;
 		raw_spin_rq_lock(src_rq);
 	}
 
@@ -2513,6 +2517,8 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 		} else {
 			move_remote_task_to_local_dsq(p, enq_flags,
 						      src_rq, dst_rq);
+			/* task has been moved to dst_rq, which is now locked */
+			locked_rq = dst_rq;
 		}
 
 		/* if the destination CPU is idle, wake it up */
@@ -2521,8 +2527,8 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 	}
 
 	/* switch back to @rq lock */
-	if (rq != dst_rq) {
-		raw_spin_rq_unlock(dst_rq);
+	if (locked_rq != rq) {
+		raw_spin_rq_unlock(locked_rq);
 		raw_spin_rq_lock(rq);
 	}
 #else	/* CONFIG_SMP */
@@ -3441,7 +3447,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 		curr->scx.slice = 0;
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(tick)) {
-		SCX_CALL_OP(SCX_KF_REST, tick, curr);
+		SCX_CALL_OP_TASK(SCX_KF_REST, tick, curr);
 	}
 
 	if (!curr->scx.slice)
@@ -3588,7 +3594,7 @@ static void scx_ops_disable_task(struct task_struct *p)
 	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(disable))
-		SCX_CALL_OP(SCX_KF_REST, disable, p);
+		SCX_CALL_OP_TASK(SCX_KF_REST, disable, p);
 	scx_set_task_state(p, SCX_TASK_READY);
 }
 
@@ -3617,7 +3623,7 @@ static void scx_ops_exit_task(struct task_struct *p)
 	}
 
 	if (SCX_HAS_OP(exit_task))
-		SCX_CALL_OP(SCX_KF_REST, exit_task, p, &args);
+		SCX_CALL_OP_TASK(SCX_KF_REST, exit_task, p, &args);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
 
@@ -3913,24 +3919,11 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 	return ops_sanitize_err("cgroup_prep_move", ret);
 }
 
-void scx_move_task(struct task_struct *p)
+void scx_cgroup_move_task(struct task_struct *p)
 {
 	if (!scx_cgroup_enabled)
 		return;
 
-	/*
-	 * We're called from sched_move_task() which handles both cgroup and
-	 * autogroup moves. Ignore the latter.
-	 *
-	 * Also ignore exiting tasks, because in the exit path tasks transition
-	 * from the autogroup to the root group, so task_group_is_autogroup()
-	 * alone isn't able to catch exiting autogroup tasks. This is safe for
-	 * cgroup_move(), because cgroup migrations never happen for PF_EXITING
-	 * tasks.
-	 */
-	if (task_group_is_autogroup(task_group(p)) || (p->flags & PF_EXITING))
-		return;
-
 	/*
 	 * @p must have ops.cgroup_prep_move() called on it and thus
 	 * cgrp_moving_from set.
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 4d022d17ac7d..1079b56b0f7a 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -73,7 +73,7 @@ static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify) {}
 int scx_tg_online(struct task_group *tg);
 void scx_tg_offline(struct task_group *tg);
 int scx_cgroup_can_attach(struct cgroup_taskset *tset);
-void scx_move_task(struct task_struct *p);
+void scx_cgroup_move_task(struct task_struct *p);
 void scx_cgroup_finish_attach(void);
 void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
 void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
@@ -82,7 +82,7 @@ void scx_group_set_idle(struct task_group *tg, bool idle);
 static inline int scx_tg_online(struct task_group *tg) { return 0; }
 static inline void scx_tg_offline(struct task_group *tg) {}
 static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
-static inline void scx_move_task(struct task_struct *p) {}
+static inline void scx_cgroup_move_task(struct task_struct *p) {}
 static inline void scx_cgroup_finish_attach(void) {}
 static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
 static inline void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight) {}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5426969cf478..d79de755c1c2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -572,7 +572,7 @@ extern void sched_online_group(struct task_group *tg,
 extern void sched_destroy_group(struct task_group *tg);
 extern void sched_release_group(struct task_group *tg);
 
-extern void sched_move_task(struct task_struct *tsk);
+extern void sched_move_task(struct task_struct *tsk, bool for_autogroup);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 8a40a616288b..58fb7280cabb 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -365,16 +365,18 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
 	cpus_read_lock();
-	preempt_disable();
+	migrate_disable();
 	clocksource_verify_choose_cpus();
 	if (cpumask_empty(&cpus_chosen)) {
-		preempt_enable();
+		migrate_enable();
 		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
 		return;
 	}
 	testcpu = smp_processor_id();
-	pr_warn("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n", cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
+	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
+		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
+	preempt_disable();
 	for_each_cpu(cpu, &cpus_chosen) {
 		if (cpu == testcpu)
 			continue;
@@ -394,6 +396,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 			cs_nsec_min = cs_nsec;
 	}
 	preempt_enable();
+	migrate_enable();
 	cpus_read_unlock();
 	if (!cpumask_empty(&cpus_ahead))
 		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0f8f3ffc6f09..ea8ad5480e28 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1672,7 +1672,8 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
  * must be the same.
  */
 static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
-			  struct trace_buffer *buffer, int nr_pages)
+			  struct trace_buffer *buffer, int nr_pages,
+			  unsigned long *subbuf_mask)
 {
 	int subbuf_size = PAGE_SIZE;
 	struct buffer_data_page *subbuf;
@@ -1680,6 +1681,9 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 	unsigned long buffers_end;
 	int i;
 
+	if (!subbuf_mask)
+		return false;
+
 	/* Check the meta magic and meta struct size */
 	if (meta->magic != RING_BUFFER_META_MAGIC ||
 	    meta->struct_size != sizeof(*meta)) {
@@ -1712,6 +1716,8 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 
 	subbuf = rb_subbufs_from_meta(meta);
 
+	bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);
+
 	/* Is the meta buffers and the subbufs themselves have correct data? */
 	for (i = 0; i < meta->nr_subbufs; i++) {
 		if (meta->buffers[i] < 0 ||
@@ -1725,6 +1731,12 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 			return false;
 		}
 
+		if (test_bit(meta->buffers[i], subbuf_mask)) {
+			pr_info("Ring buffer boot meta [%d] array has duplicates\n", cpu);
+			return false;
+		}
+
+		set_bit(meta->buffers[i], subbuf_mask);
 		subbuf = (void *)subbuf + subbuf_size;
 	}
 
@@ -1838,6 +1850,11 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 				cpu_buffer->cpu);
 			goto invalid;
 		}
+
+		/* If the buffer has content, update pages_touched */
+		if (ret)
+			local_inc(&cpu_buffer->pages_touched);
+
 		entries += ret;
 		entry_bytes += local_read(&head_page->page->commit);
 		local_set(&cpu_buffer->head_page->entries, ret);
@@ -1889,17 +1906,22 @@ static void rb_meta_init_text_addr(struct ring_buffer_meta *meta)
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
 	struct ring_buffer_meta *meta;
+	unsigned long *subbuf_mask;
 	unsigned long delta;
 	void *subbuf;
 	int cpu;
 	int i;
 
+	/* Create a mask to test the subbuf array */
+	subbuf_mask = bitmap_alloc(nr_pages + 1, GFP_KERNEL);
+	/* If subbuf_mask fails to allocate, then rb_meta_valid() will return false */
+
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		void *next_meta;
 
 		meta = rb_range_meta(buffer, nr_pages, cpu);
 
-		if (rb_meta_valid(meta, cpu, buffer, nr_pages)) {
+		if (rb_meta_valid(meta, cpu, buffer, nr_pages, subbuf_mask)) {
 			/* Make the mappings match the current address */
 			subbuf = rb_subbufs_from_meta(meta);
 			delta = (unsigned long)subbuf - meta->first_buffer;
@@ -1943,6 +1965,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 			subbuf += meta->subbuf_size;
 		}
 	}
+	bitmap_free(subbuf_mask);
 }
 
 static void *rbm_start(struct seq_file *m, loff_t *pos)
@@ -7157,6 +7180,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		kfree(cpu_buffer->subbuf_ids);
 		cpu_buffer->subbuf_ids = NULL;
 		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
 unlock:
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b04990385a6a..bfc4ac265c2c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8364,6 +8364,10 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct trace_iterator *iter = &info->iter;
 	int ret = 0;
 
+	/* Currently the boot mapped buffer is not supported for mmap */
+	if (iter->tr->flags & TRACE_ARRAY_FL_BOOT)
+		return -ENODEV;
+
 	ret = get_snapshot_map(iter->tr);
 	if (ret)
 		return ret;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cee65cb43108..a9d64e08dffc 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3509,12 +3509,6 @@ static int rescuer_thread(void *__rescuer)
 			}
 		}
 
-		/*
-		 * Put the reference grabbed by send_mayday().  @pool won't
-		 * go away while we're still attached to it.
-		 */
-		put_pwq(pwq);
-
 		/*
 		 * Leave this pool. Notify regular workers; otherwise, we end up
 		 * with 0 concurrency and stalling the execution.
@@ -3525,6 +3519,12 @@ static int rescuer_thread(void *__rescuer)
 
 		worker_detach_from_pool(rescuer);
 
+		/*
+		 * Put the reference grabbed by send_mayday().  @pool might
+		 * go away any time after it.
+		 */
+		put_pwq_unlocked(pwq);
+
 		raw_spin_lock_irq(&wq_mayday_lock);
 	}
 
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index aa6c714892ec..9f3b8b682adb 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -685,6 +685,15 @@ static int ax25_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
+		if (ax25->ax25_dev) {
+			if (dev == ax25->ax25_dev->dev) {
+				rcu_read_unlock();
+				break;
+			}
+			netdev_put(ax25->ax25_dev->dev, &ax25->dev_tracker);
+			ax25_dev_put(ax25->ax25_dev);
+		}
+
 		ax25->ax25_dev = ax25_dev_ax25dev(dev);
 		if (!ax25->ax25_dev) {
 			rcu_read_unlock();
@@ -692,6 +701,8 @@ static int ax25_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 		ax25_fillin_cb(ax25, ax25->ax25_dev);
+		netdev_hold(dev, &ax25->dev_tracker, GFP_ATOMIC);
+		ax25_dev_hold(ax25->ax25_dev);
 		rcu_read_unlock();
 		break;
 
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index ac11f1f08db0..d35479c465e2 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -113,8 +113,6 @@ static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
-	INIT_WORK(&hardif_neigh->bat_v.metric_work,
-		  batadv_v_elp_throughput_metric_update);
 }
 
 /**
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1d704574e6bf..b065578b4436 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -18,6 +18,7 @@
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
 #include <linux/nl80211.h>
@@ -26,6 +27,7 @@
 #include <linux/rcupdate.h>
 #include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -41,6 +43,18 @@
 #include "routing.h"
 #include "send.h"
 
+/**
+ * struct batadv_v_metric_queue_entry - list of hardif neighbors which require
+ *  and metric update
+ */
+struct batadv_v_metric_queue_entry {
+	/** @hardif_neigh: hardif neighbor scheduled for metric update */
+	struct batadv_hardif_neigh_node *hardif_neigh;
+
+	/** @list: list node for metric_queue */
+	struct list_head list;
+};
+
 /**
  * batadv_v_elp_start_timer() - restart timer for ELP periodic work
  * @hard_iface: the interface for which the timer has to be reset
@@ -59,25 +73,36 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 /**
  * batadv_v_elp_get_throughput() - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
+ * @pthroughput: calculated throughput towards the given neighbour in multiples
+ *  of 100kpbs (a value of '1' equals 0.1Mbps, '10' equals 1Mbps, etc).
  *
- * Return: The throughput towards the given neighbour in multiples of 100kpbs
- *         (a value of '1' equals 0.1Mbps, '10' equals 1Mbps, etc).
+ * Return: true when value behind @pthroughput was set
  */
-static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
+static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
+					u32 *pthroughput)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
+	struct net_device *soft_iface = hard_iface->soft_iface;
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
 	u32 throughput;
 	int ret;
 
+	/* don't query throughput when no longer associated with any
+	 * batman-adv interface
+	 */
+	if (!soft_iface)
+		return false;
+
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
 	throughput =  atomic_read(&hard_iface->bat_v.throughput_override);
-	if (throughput != 0)
-		return throughput;
+	if (throughput != 0) {
+		*pthroughput = throughput;
+		return true;
+	}
 
 	/* if this is a wireless device, then ask its throughput through
 	 * cfg80211 API
@@ -104,27 +129,39 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			 * possible to delete this neighbor. For now set
 			 * the throughput metric to 0.
 			 */
-			return 0;
+			*pthroughput = 0;
+			return true;
 		}
 		if (ret)
 			goto default_throughput;
 
-		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT))
-			return sinfo.expected_throughput / 100;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)) {
+			*pthroughput = sinfo.expected_throughput / 100;
+			return true;
+		}
 
 		/* try to estimate the expected throughput based on reported tx
 		 * rates
 		 */
-		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE))
-			return cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE)) {
+			*pthroughput = cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+			return true;
+		}
 
 		goto default_throughput;
 	}
 
+	/* only use rtnl_trylock because the elp worker will be cancelled while
+	 * the rntl_lock is held. the cancel_delayed_work_sync() would otherwise
+	 * wait forever when the elp work_item was started and it is then also
+	 * trying to rtnl_lock
+	 */
+	if (!rtnl_trylock())
+		return false;
+
 	/* if not a wifi interface, check if this device provides data via
 	 * ethtool (e.g. an Ethernet adapter)
 	 */
-	rtnl_lock();
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
 	rtnl_unlock();
 	if (ret == 0) {
@@ -135,13 +172,15 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			hard_iface->bat_v.flags &= ~BATADV_FULL_DUPLEX;
 
 		throughput = link_settings.base.speed;
-		if (throughput && throughput != SPEED_UNKNOWN)
-			return throughput * 10;
+		if (throughput && throughput != SPEED_UNKNOWN) {
+			*pthroughput = throughput * 10;
+			return true;
+		}
 	}
 
 default_throughput:
 	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
-		batadv_info(hard_iface->soft_iface,
+		batadv_info(soft_iface,
 			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %u.%1u Mbps. Consider overriding the throughput manually or checking your driver.\n",
 			    hard_iface->net_dev->name,
 			    BATADV_THROUGHPUT_DEFAULT_VALUE / 10,
@@ -150,31 +189,26 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	}
 
 	/* if none of the above cases apply, return the base_throughput */
-	return BATADV_THROUGHPUT_DEFAULT_VALUE;
+	*pthroughput = BATADV_THROUGHPUT_DEFAULT_VALUE;
+	return true;
 }
 
 /**
  * batadv_v_elp_throughput_metric_update() - worker updating the throughput
  *  metric of a single hop neighbour
- * @work: the work queue item
+ * @neigh: the neighbour to probe
  */
-void batadv_v_elp_throughput_metric_update(struct work_struct *work)
+static void
+batadv_v_elp_throughput_metric_update(struct batadv_hardif_neigh_node *neigh)
 {
-	struct batadv_hardif_neigh_node_bat_v *neigh_bat_v;
-	struct batadv_hardif_neigh_node *neigh;
-
-	neigh_bat_v = container_of(work, struct batadv_hardif_neigh_node_bat_v,
-				   metric_work);
-	neigh = container_of(neigh_bat_v, struct batadv_hardif_neigh_node,
-			     bat_v);
+	u32 throughput;
+	bool valid;
 
-	ewma_throughput_add(&neigh->bat_v.throughput,
-			    batadv_v_elp_get_throughput(neigh));
+	valid = batadv_v_elp_get_throughput(neigh, &throughput);
+	if (!valid)
+		return;
 
-	/* decrement refcounter to balance increment performed before scheduling
-	 * this task
-	 */
-	batadv_hardif_neigh_put(neigh);
+	ewma_throughput_add(&neigh->bat_v.throughput, throughput);
 }
 
 /**
@@ -248,14 +282,16 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
  */
 static void batadv_v_elp_periodic_work(struct work_struct *work)
 {
+	struct batadv_v_metric_queue_entry *metric_entry;
+	struct batadv_v_metric_queue_entry *metric_safe;
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface_bat_v *bat_v;
 	struct batadv_elp_packet *elp_packet;
+	struct list_head metric_queue;
 	struct batadv_priv *bat_priv;
 	struct sk_buff *skb;
 	u32 elp_interval;
-	bool ret;
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
@@ -291,6 +327,8 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	atomic_inc(&hard_iface->bat_v.elp_seqno);
 
+	INIT_LIST_HEAD(&metric_queue);
+
 	/* The throughput metric is updated on each sent packet. This way, if a
 	 * node is dead and no longer sends packets, batman-adv is still able to
 	 * react timely to its death.
@@ -315,16 +353,28 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 		/* Reading the estimated throughput from cfg80211 is a task that
 		 * may sleep and that is not allowed in an rcu protected
-		 * context. Therefore schedule a task for that.
+		 * context. Therefore add it to metric_queue and process it
+		 * outside rcu protected context.
 		 */
-		ret = queue_work(batadv_event_workqueue,
-				 &hardif_neigh->bat_v.metric_work);
-
-		if (!ret)
+		metric_entry = kzalloc(sizeof(*metric_entry), GFP_ATOMIC);
+		if (!metric_entry) {
 			batadv_hardif_neigh_put(hardif_neigh);
+			continue;
+		}
+
+		metric_entry->hardif_neigh = hardif_neigh;
+		list_add(&metric_entry->list, &metric_queue);
 	}
 	rcu_read_unlock();
 
+	list_for_each_entry_safe(metric_entry, metric_safe, &metric_queue, list) {
+		batadv_v_elp_throughput_metric_update(metric_entry->hardif_neigh);
+
+		batadv_hardif_neigh_put(metric_entry->hardif_neigh);
+		list_del(&metric_entry->list);
+		kfree(metric_entry);
+	}
+
 restart_timer:
 	batadv_v_elp_start_timer(hard_iface);
 out:
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 9e2740195fa2..c9cb0a307100 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -10,7 +10,6 @@
 #include "main.h"
 
 #include <linux/skbuff.h>
-#include <linux/workqueue.h>
 
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
@@ -19,6 +18,5 @@ void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface);
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
-void batadv_v_elp_throughput_metric_update(struct work_struct *work);
 
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 04f6398b3a40..85a50096f5b2 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -596,9 +596,6 @@ struct batadv_hardif_neigh_node_bat_v {
 	 *  neighbor
 	 */
 	unsigned long last_unicast_tx;
-
-	/** @metric_work: work queue callback item for metric update */
-	struct work_struct metric_work;
 };
 
 /**
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 305dd72c844c..17226b2341d0 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1132,7 +1132,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 
 	todo_size = size;
 
-	while (todo_size) {
+	do {
 		struct j1939_sk_buff_cb *skcb;
 
 		segment_size = min_t(size_t, J1939_MAX_TP_PACKET_SIZE,
@@ -1177,7 +1177,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 
 		todo_size -= segment_size;
 		session->total_queued_size += segment_size;
-	}
+	} while (todo_size);
 
 	switch (ret) {
 	case 0: /* OK */
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 95f7a7e65a73..9b72d118d756 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -382,8 +382,9 @@ sk_buff *j1939_session_skb_get_by_offset(struct j1939_session *session,
 	skb_queue_walk(&session->skb_queue, do_skb) {
 		do_skcb = j1939_skb_to_cb(do_skb);
 
-		if (offset_start >= do_skcb->offset &&
-		    offset_start < (do_skcb->offset + do_skb->len)) {
+		if ((offset_start >= do_skcb->offset &&
+		     offset_start < (do_skcb->offset + do_skb->len)) ||
+		     (offset_start == 0 && do_skcb->offset == 0 && do_skb->len == 0)) {
 			skb = do_skb;
 		}
 	}
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 154a2681f55c..388ff1d6d86b 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -37,8 +37,8 @@ static const struct fib_kuid_range fib_kuid_range_unset = {
 
 bool fib_rule_matchall(const struct fib_rule *rule)
 {
-	if (rule->iifindex || rule->oifindex || rule->mark || rule->tun_id ||
-	    rule->flags)
+	if (READ_ONCE(rule->iifindex) || READ_ONCE(rule->oifindex) ||
+	    rule->mark || rule->tun_id || rule->flags)
 		return false;
 	if (rule->suppress_ifgroup != -1 || rule->suppress_prefixlen != -1)
 		return false;
@@ -260,12 +260,14 @@ static int fib_rule_match(struct fib_rule *rule, struct fib_rules_ops *ops,
 			  struct flowi *fl, int flags,
 			  struct fib_lookup_arg *arg)
 {
-	int ret = 0;
+	int iifindex, oifindex, ret = 0;
 
-	if (rule->iifindex && (rule->iifindex != fl->flowi_iif))
+	iifindex = READ_ONCE(rule->iifindex);
+	if (iifindex && (iifindex != fl->flowi_iif))
 		goto out;
 
-	if (rule->oifindex && (rule->oifindex != fl->flowi_oif))
+	oifindex = READ_ONCE(rule->oifindex);
+	if (oifindex && (oifindex != fl->flowi_oif))
 		goto out;
 
 	if ((rule->mark ^ fl->flowi_mark) & rule->mark_mask)
@@ -1038,14 +1040,14 @@ static int fib_nl_fill_rule(struct sk_buff *skb, struct fib_rule *rule,
 	if (rule->iifname[0]) {
 		if (nla_put_string(skb, FRA_IIFNAME, rule->iifname))
 			goto nla_put_failure;
-		if (rule->iifindex == -1)
+		if (READ_ONCE(rule->iifindex) == -1)
 			frh->flags |= FIB_RULE_IIF_DETACHED;
 	}
 
 	if (rule->oifname[0]) {
 		if (nla_put_string(skb, FRA_OIFNAME, rule->oifname))
 			goto nla_put_failure;
-		if (rule->oifindex == -1)
+		if (READ_ONCE(rule->oifindex) == -1)
 			frh->flags |= FIB_RULE_OIF_DETACHED;
 	}
 
@@ -1217,10 +1219,10 @@ static void attach_rules(struct list_head *rules, struct net_device *dev)
 	list_for_each_entry(rule, rules, list) {
 		if (rule->iifindex == -1 &&
 		    strcmp(dev->name, rule->iifname) == 0)
-			rule->iifindex = dev->ifindex;
+			WRITE_ONCE(rule->iifindex, dev->ifindex);
 		if (rule->oifindex == -1 &&
 		    strcmp(dev->name, rule->oifname) == 0)
-			rule->oifindex = dev->ifindex;
+			WRITE_ONCE(rule->oifindex, dev->ifindex);
 	}
 }
 
@@ -1230,9 +1232,9 @@ static void detach_rules(struct list_head *rules, struct net_device *dev)
 
 	list_for_each_entry(rule, rules, list) {
 		if (rule->iifindex == dev->ifindex)
-			rule->iifindex = -1;
+			WRITE_ONCE(rule->iifindex, -1);
 		if (rule->oifindex == dev->ifindex)
-			rule->oifindex = -1;
+			WRITE_ONCE(rule->oifindex, -1);
 	}
 }
 
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0e638a37aa09..5db41bf2ed93 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1108,10 +1108,12 @@ bool __skb_flow_dissect(const struct net *net,
 					      FLOW_DISSECTOR_KEY_BASIC,
 					      target_container);
 
+	rcu_read_lock();
+
 	if (skb) {
 		if (!net) {
 			if (skb->dev)
-				net = dev_net(skb->dev);
+				net = dev_net_rcu(skb->dev);
 			else if (skb->sk)
 				net = sock_net(skb->sk);
 		}
@@ -1122,7 +1124,6 @@ bool __skb_flow_dissect(const struct net *net,
 		enum netns_bpf_attach_type type = NETNS_BPF_FLOW_DISSECTOR;
 		struct bpf_prog_array *run_array;
 
-		rcu_read_lock();
 		run_array = rcu_dereference(init_net.bpf.run_array[type]);
 		if (!run_array)
 			run_array = rcu_dereference(net->bpf.run_array[type]);
@@ -1150,17 +1151,17 @@ bool __skb_flow_dissect(const struct net *net,
 			prog = READ_ONCE(run_array->items[0].prog);
 			result = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
 						  hlen, flags);
-			if (result == BPF_FLOW_DISSECTOR_CONTINUE)
-				goto dissect_continue;
-			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
-						 target_container);
-			rcu_read_unlock();
-			return result == BPF_OK;
+			if (result != BPF_FLOW_DISSECTOR_CONTINUE) {
+				__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
+							 target_container);
+				rcu_read_unlock();
+				return result == BPF_OK;
+			}
 		}
-dissect_continue:
-		rcu_read_unlock();
 	}
 
+	rcu_read_unlock();
+
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		struct ethhdr *eth = eth_hdr(skb);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index cc58315a40a7..c7f7ea61b524 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3513,10 +3513,12 @@ static const struct seq_operations neigh_stat_seq_ops = {
 static void __neigh_notify(struct neighbour *n, int type, int flags,
 			   u32 pid)
 {
-	struct net *net = dev_net(n->dev);
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
+	struct net *net;
 
+	rcu_read_lock();
+	net = dev_net_rcu(n->dev);
 	skb = nlmsg_new(neigh_nlmsg_size(), GFP_ATOMIC);
 	if (skb == NULL)
 		goto errout;
@@ -3529,9 +3531,11 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 		goto errout;
 	}
 	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
-	return;
+	goto out;
 errout:
 	rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
+out:
+	rcu_read_unlock();
 }
 
 void neigh_app_ns(struct neighbour *n)
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 11c1519b3699..59ffaa89d7b0 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -659,10 +659,12 @@ static int arp_xmit_finish(struct net *net, struct sock *sk, struct sk_buff *skb
  */
 void arp_xmit(struct sk_buff *skb)
 {
+	rcu_read_lock();
 	/* Send it off, maybe filter it using firewalling first.  */
 	NF_HOOK(NFPROTO_ARP, NF_ARP_OUT,
-		dev_net(skb->dev), NULL, skb, NULL, skb->dev,
+		dev_net_rcu(skb->dev), NULL, skb, NULL, skb->dev,
 		arp_xmit_finish);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(arp_xmit);
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7cf5f7d0d0de..a55e95046984 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1351,10 +1351,11 @@ __be32 inet_select_addr(const struct net_device *dev, __be32 dst, int scope)
 	__be32 addr = 0;
 	unsigned char localnet_scope = RT_SCOPE_HOST;
 	struct in_device *in_dev;
-	struct net *net = dev_net(dev);
+	struct net *net;
 	int master_idx;
 
 	rcu_read_lock();
+	net = dev_net_rcu(dev);
 	in_dev = __in_dev_get_rcu(dev);
 	if (!in_dev)
 		goto no_in_dev;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 932bd775fc26..f45bc187a92a 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -399,10 +399,10 @@ static void icmp_push_reply(struct sock *sk,
 
 static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 {
-	struct ipcm_cookie ipc;
 	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net(rt->dst.dev);
+	struct net *net = dev_net_rcu(rt->dst.dev);
 	bool apply_ratelimit = false;
+	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	struct sock *sk;
 	struct inet_sock *inet;
@@ -610,12 +610,14 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	struct sock *sk;
 
 	if (!rt)
-		goto out;
+		return;
+
+	rcu_read_lock();
 
 	if (rt->dst.dev)
-		net = dev_net(rt->dst.dev);
+		net = dev_net_rcu(rt->dst.dev);
 	else if (skb_in->dev)
-		net = dev_net(skb_in->dev);
+		net = dev_net_rcu(skb_in->dev);
 	else
 		goto out;
 
@@ -786,7 +788,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	icmp_xmit_unlock(sk);
 out_bh_enable:
 	local_bh_enable();
-out:;
+out:
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(__icmp_send);
 
@@ -835,7 +838,7 @@ static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
 	 * avoid additional coding at protocol handlers.
 	 */
 	if (!pskb_may_pull(skb, iph->ihl * 4 + 8)) {
-		__ICMP_INC_STATS(dev_net(skb->dev), ICMP_MIB_INERRORS);
+		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 		return;
 	}
 
@@ -869,7 +872,7 @@ static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
 	struct net *net;
 	u32 info = 0;
 
-	net = dev_net(skb_dst(skb)->dev);
+	net = dev_net_rcu(skb_dst(skb)->dev);
 
 	/*
 	 *	Incomplete header ?
@@ -980,7 +983,7 @@ static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
 static enum skb_drop_reason icmp_redirect(struct sk_buff *skb)
 {
 	if (skb->len < sizeof(struct iphdr)) {
-		__ICMP_INC_STATS(dev_net(skb->dev), ICMP_MIB_INERRORS);
+		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 		return SKB_DROP_REASON_PKT_TOO_SMALL;
 	}
 
@@ -1012,7 +1015,7 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 	struct icmp_bxm icmp_param;
 	struct net *net;
 
-	net = dev_net(skb_dst(skb)->dev);
+	net = dev_net_rcu(skb_dst(skb)->dev);
 	/* should there be an ICMP stat for ignored echos? */
 	if (READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_all))
 		return SKB_NOT_DROPPED_YET;
@@ -1041,9 +1044,9 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 
 bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 {
+	struct net *net = dev_net_rcu(skb->dev);
 	struct icmp_ext_hdr *ext_hdr, _ext_hdr;
 	struct icmp_ext_echo_iio *iio, _iio;
-	struct net *net = dev_net(skb->dev);
 	struct inet6_dev *in6_dev;
 	struct in_device *in_dev;
 	struct net_device *dev;
@@ -1182,7 +1185,7 @@ static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
 	return SKB_NOT_DROPPED_YET;
 
 out_err:
-	__ICMP_INC_STATS(dev_net(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
+	__ICMP_INC_STATS(dev_net_rcu(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
 	return SKB_DROP_REASON_PKT_TOO_SMALL;
 }
 
@@ -1199,7 +1202,7 @@ int icmp_rcv(struct sk_buff *skb)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net(rt->dst.dev);
+	struct net *net = dev_net_rcu(rt->dst.dev);
 	struct icmphdr *icmph;
 
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
@@ -1372,9 +1375,9 @@ int icmp_err(struct sk_buff *skb, u32 info)
 	struct iphdr *iph = (struct iphdr *)skb->data;
 	int offset = iph->ihl<<2;
 	struct icmphdr *icmph = (struct icmphdr *)(skb->data + offset);
+	struct net *net = dev_net_rcu(skb->dev);
 	int type = icmp_hdr(skb)->type;
 	int code = icmp_hdr(skb)->code;
-	struct net *net = dev_net(skb->dev);
 
 	/*
 	 * Use ping_err to handle all icmp errors except those
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 2a27913588d0..41b320f0c20e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -390,7 +390,13 @@ static inline int ip_rt_proc_init(void)
 
 static inline bool rt_is_expired(const struct rtable *rth)
 {
-	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev));
+	bool res;
+
+	rcu_read_lock();
+	res = rth->rt_genid != rt_genid_ipv4(dev_net_rcu(rth->dst.dev));
+	rcu_read_unlock();
+
+	return res;
 }
 
 void rt_cache_flush(struct net *net)
@@ -1002,9 +1008,9 @@ out:	kfree_skb_reason(skb, reason);
 static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 {
 	struct dst_entry *dst = &rt->dst;
-	struct net *net = dev_net(dst->dev);
 	struct fib_result res;
 	bool lock = false;
+	struct net *net;
 	u32 old_mtu;
 
 	if (ip_mtu_locked(dst))
@@ -1014,6 +1020,8 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 	if (old_mtu < mtu)
 		return;
 
+	rcu_read_lock();
+	net = dev_net_rcu(dst->dev);
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1021,17 +1029,29 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 
 	if (rt->rt_pmtu == mtu && !lock &&
 	    time_before(jiffies, dst->expires - net->ipv4.ip_rt_mtu_expires / 2))
-		return;
+		goto out;
 
-	rcu_read_lock();
 	if (fib_lookup(net, fl4, &res, 0) == 0) {
 		struct fib_nh_common *nhc;
 
 		fib_select_path(net, &res, fl4, NULL);
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+		if (fib_info_num_path(res.fi) > 1) {
+			int nhsel;
+
+			for (nhsel = 0; nhsel < fib_info_num_path(res.fi); nhsel++) {
+				nhc = fib_info_nhc(res.fi, nhsel);
+				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
+						      jiffies + net->ipv4.ip_rt_mtu_expires);
+			}
+			goto out;
+		}
+#endif /* CONFIG_IP_ROUTE_MULTIPATH */
 		nhc = FIB_RES_NHC(res);
 		update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
 				      jiffies + net->ipv4.ip_rt_mtu_expires);
 	}
+out:
 	rcu_read_unlock();
 }
 
@@ -1294,10 +1314,15 @@ static void set_class_tag(struct rtable *rt, u32 tag)
 
 static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 {
-	struct net *net = dev_net(dst->dev);
 	unsigned int header_size = sizeof(struct tcphdr) + sizeof(struct iphdr);
-	unsigned int advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				    net->ipv4.ip_rt_min_advmss);
+	unsigned int advmss;
+	struct net *net;
+
+	rcu_read_lock();
+	net = dev_net_rcu(dst->dev);
+	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
+				   net->ipv4.ip_rt_min_advmss);
+	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
 }
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index a6984a29fdb9..4d14ab7f7e99 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -76,7 +76,7 @@ static int icmpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 {
 	/* icmpv6_notify checks 8 bytes can be pulled, icmp6hdr is 8 bytes */
 	struct icmp6hdr *icmp6 = (struct icmp6hdr *) (skb->data + offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	if (type == ICMPV6_PKT_TOOBIG)
 		ip6_update_pmtu(skb, net, info, skb->dev->ifindex, 0, sock_net_uid(net, NULL));
@@ -473,7 +473,10 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 
 	if (!skb->dev)
 		return;
-	net = dev_net(skb->dev);
+
+	rcu_read_lock();
+
+	net = dev_net_rcu(skb->dev);
 	mark = IP6_REPLY_MARK(net, skb->mark);
 	/*
 	 *	Make sure we respect the rules
@@ -496,7 +499,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		    !(type == ICMPV6_PARAMPROB &&
 		      code == ICMPV6_UNK_OPTION &&
 		      (opt_unrec(skb, info))))
-			return;
+			goto out;
 
 		saddr = NULL;
 	}
@@ -526,7 +529,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	if ((addr_type == IPV6_ADDR_ANY) || (addr_type & IPV6_ADDR_MULTICAST)) {
 		net_dbg_ratelimited("icmp6_send: addr_any/mcast source [%pI6c > %pI6c]\n",
 				    &hdr->saddr, &hdr->daddr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -535,7 +538,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	if (is_ineligible(skb)) {
 		net_dbg_ratelimited("icmp6_send: no reply to icmp error [%pI6c > %pI6c]\n",
 				    &hdr->saddr, &hdr->daddr);
-		return;
+		goto out;
 	}
 
 	/* Needed by both icmpv6_global_allow and icmpv6_xmit_lock */
@@ -582,7 +585,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	np = inet6_sk(sk);
 
 	if (!icmpv6_xrlim_allow(sk, type, &fl6, apply_ratelimit))
-		goto out;
+		goto out_unlock;
 
 	tmp_hdr.icmp6_type = type;
 	tmp_hdr.icmp6_code = code;
@@ -600,7 +603,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 
 	dst = icmpv6_route_lookup(net, skb, sk, &fl6);
 	if (IS_ERR(dst))
-		goto out;
+		goto out_unlock;
 
 	ipc6.hlimit = ip6_sk_dst_hoplimit(np, &fl6, dst);
 
@@ -616,7 +619,6 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		goto out_dst_release;
 	}
 
-	rcu_read_lock();
 	idev = __in6_dev_get(skb->dev);
 
 	if (ip6_append_data(sk, icmpv6_getfrag, &msg,
@@ -630,13 +632,15 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		icmpv6_push_pending_frames(sk, &fl6, &tmp_hdr,
 					   len + sizeof(struct icmp6hdr));
 	}
-	rcu_read_unlock();
+
 out_dst_release:
 	dst_release(dst);
-out:
+out_unlock:
 	icmpv6_xmit_unlock(sk);
 out_bh_enable:
 	local_bh_enable();
+out:
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(icmp6_send);
 
@@ -679,8 +683,8 @@ int ip6_err_gen_icmpv6_unreach(struct sk_buff *skb, int nhs, int type,
 	skb_pull(skb2, nhs);
 	skb_reset_network_header(skb2);
 
-	rt = rt6_lookup(dev_net(skb->dev), &ipv6_hdr(skb2)->saddr, NULL, 0,
-			skb, 0);
+	rt = rt6_lookup(dev_net_rcu(skb->dev), &ipv6_hdr(skb2)->saddr,
+			NULL, 0, skb, 0);
 
 	if (rt && rt->dst.dev)
 		skb2->dev = rt->dst.dev;
@@ -717,7 +721,7 @@ EXPORT_SYMBOL(ip6_err_gen_icmpv6_unreach);
 
 static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct sock *sk;
 	struct inet6_dev *idev;
 	struct ipv6_pinfo *np;
@@ -832,7 +836,7 @@ enum skb_drop_reason icmpv6_notify(struct sk_buff *skb, u8 type,
 				   u8 code, __be32 info)
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct inet6_protocol *ipprot;
 	enum skb_drop_reason reason;
 	int inner_offset;
@@ -889,7 +893,7 @@ enum skb_drop_reason icmpv6_notify(struct sk_buff *skb, u8 type,
 static int icmpv6_rcv(struct sk_buff *skb)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct net_device *dev = icmp6_dev(skb);
 	struct inet6_dev *idev = __in6_dev_get(dev);
 	const struct in6_addr *saddr, *daddr;
@@ -921,7 +925,7 @@ static int icmpv6_rcv(struct sk_buff *skb)
 		skb_set_network_header(skb, nh);
 	}
 
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_INMSGS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_INMSGS);
 
 	saddr = &ipv6_hdr(skb)->saddr;
 	daddr = &ipv6_hdr(skb)->daddr;
@@ -939,7 +943,7 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 	type = hdr->icmp6_type;
 
-	ICMP6MSGIN_INC_STATS(dev_net(dev), idev, type);
+	ICMP6MSGIN_INC_STATS(dev_net_rcu(dev), idev, type);
 
 	switch (type) {
 	case ICMPV6_ECHO_REQUEST:
@@ -1034,9 +1038,9 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 csum_error:
 	reason = SKB_DROP_REASON_ICMP_CSUM;
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_CSUMERRORS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_CSUMERRORS);
 discard_it:
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_INERRORS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_INERRORS);
 drop_no_count:
 	kfree_skb_reason(skb, reason);
 	return 0;
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index beb6b4cfc551..4215cebe7d85 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -255,14 +255,15 @@ static int ioam6_do_fill(struct net *net, struct sk_buff *skb)
 }
 
 static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
-			   struct ioam6_lwt_encap *tuninfo)
+			   struct ioam6_lwt_encap *tuninfo,
+			   struct dst_entry *cache_dst)
 {
 	struct ipv6hdr *oldhdr, *hdr;
 	int hdrlen, err;
 
 	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -293,7 +294,8 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 			  struct ioam6_lwt_encap *tuninfo,
 			  bool has_tunsrc,
 			  struct in6_addr *tunsrc,
-			  struct in6_addr *tundst)
+			  struct in6_addr *tundst,
+			  struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct ipv6hdr *hdr, *inner_hdr;
@@ -302,7 +304,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
 	len = sizeof(*hdr) + hdrlen;
 
-	err = skb_cow_head(skb, len + skb->mac_len);
+	err = skb_cow_head(skb, len + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -336,7 +338,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 
 static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
+	struct dst_entry *dst = skb_dst(skb), *cache_dst = NULL;
 	struct in6_addr orig_daddr;
 	struct ioam6_lwt *ilwt;
 	int err = -EINVAL;
@@ -354,6 +356,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	orig_daddr = ipv6_hdr(skb)->daddr;
 
+	local_bh_disable();
+	cache_dst = dst_cache_get(&ilwt->cache);
+	local_bh_enable();
+
 	switch (ilwt->mode) {
 	case IOAM6_IPTUNNEL_MODE_INLINE:
 do_inline:
@@ -361,7 +367,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP)
 			goto out;
 
-		err = ioam6_do_inline(net, skb, &ilwt->tuninfo);
+		err = ioam6_do_inline(net, skb, &ilwt->tuninfo, cache_dst);
 		if (unlikely(err))
 			goto drop;
 
@@ -371,7 +377,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		/* Encapsulation (ip6ip6) */
 		err = ioam6_do_encap(net, skb, &ilwt->tuninfo,
 				     ilwt->has_tunsrc, &ilwt->tunsrc,
-				     &ilwt->tundst);
+				     &ilwt->tundst, cache_dst);
 		if (unlikely(err))
 			goto drop;
 
@@ -389,46 +395,45 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
+	if (unlikely(!cache_dst)) {
+		struct ipv6hdr *hdr = ipv6_hdr(skb);
+		struct flowi6 fl6;
 
-	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
-		local_bh_disable();
-		dst = dst_cache_get(&ilwt->cache);
-		local_bh_enable();
-
-		if (unlikely(!dst)) {
-			struct ipv6hdr *hdr = ipv6_hdr(skb);
-			struct flowi6 fl6;
-
-			memset(&fl6, 0, sizeof(fl6));
-			fl6.daddr = hdr->daddr;
-			fl6.saddr = hdr->saddr;
-			fl6.flowlabel = ip6_flowinfo(hdr);
-			fl6.flowi6_mark = skb->mark;
-			fl6.flowi6_proto = hdr->nexthdr;
-
-			dst = ip6_route_output(net, NULL, &fl6);
-			if (dst->error) {
-				err = dst->error;
-				dst_release(dst);
-				goto drop;
-			}
+		memset(&fl6, 0, sizeof(fl6));
+		fl6.daddr = hdr->daddr;
+		fl6.saddr = hdr->saddr;
+		fl6.flowlabel = ip6_flowinfo(hdr);
+		fl6.flowi6_mark = skb->mark;
+		fl6.flowi6_proto = hdr->nexthdr;
+
+		cache_dst = ip6_route_output(net, NULL, &fl6);
+		if (cache_dst->error) {
+			err = cache_dst->error;
+			goto drop;
+		}
 
+		/* cache only if we don't create a dst reference loop */
+		if (dst->lwtstate != cache_dst->lwtstate) {
 			local_bh_disable();
-			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
+			dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
 			local_bh_enable();
 		}
 
-		skb_dst_drop(skb);
-		skb_dst_set(skb, dst);
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(cache_dst->dev));
+		if (unlikely(err))
+			goto drop;
+	}
 
+	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
+		skb_dst_drop(skb);
+		skb_dst_set(skb, cache_dst);
 		return dst_output(net, sk, skb);
 	}
 out:
+	dst_release(cache_dst);
 	return dst->lwtstate->orig_output(net, sk, skb);
 drop:
+	dst_release(cache_dst);
 	kfree_skb(skb);
 	return err;
 }
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b244dbf61d5f..b7b62e5a562e 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1730,21 +1730,19 @@ static struct sk_buff *mld_newpack(struct inet6_dev *idev, unsigned int mtu)
 	struct net_device *dev = idev->dev;
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	struct net *net = dev_net(dev);
 	const struct in6_addr *saddr;
 	struct in6_addr addr_buf;
 	struct mld2_report *pmr;
 	struct sk_buff *skb;
 	unsigned int size;
 	struct sock *sk;
-	int err;
+	struct net *net;
 
-	sk = net->ipv6.igmp_sk;
 	/* we assume size > sizeof(ra) here
 	 * Also try to not allocate high-order pages for big MTU
 	 */
 	size = min_t(int, mtu, PAGE_SIZE / 2) + hlen + tlen;
-	skb = sock_alloc_send_skb(sk, size, 1, &err);
+	skb = alloc_skb(size, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
@@ -1752,6 +1750,12 @@ static struct sk_buff *mld_newpack(struct inet6_dev *idev, unsigned int mtu)
 	skb_reserve(skb, hlen);
 	skb_tailroom_reserve(skb, mtu, tlen);
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(dev);
+	sk = net->ipv6.igmp_sk;
+	skb_set_owner_w(skb, sk);
+
 	if (ipv6_get_lladdr(dev, &addr_buf, IFA_F_TENTATIVE)) {
 		/* <draft-ietf-magma-mld-source-05.txt>:
 		 * use unspecified address as the source address
@@ -1763,6 +1767,8 @@ static struct sk_buff *mld_newpack(struct inet6_dev *idev, unsigned int mtu)
 
 	ip6_mc_hdr(sk, skb, dev, saddr, &mld2_all_mcr, NEXTHDR_HOP, 0);
 
+	rcu_read_unlock();
+
 	skb_put_data(skb, ra, sizeof(ra));
 
 	skb_set_transport_header(skb, skb_tail_pointer(skb) - skb->data);
@@ -2122,21 +2128,21 @@ static void mld_send_cr(struct inet6_dev *idev)
 
 static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 {
-	struct net *net = dev_net(dev);
-	struct sock *sk = net->ipv6.igmp_sk;
+	const struct in6_addr *snd_addr, *saddr;
+	int err, len, payload_len, full_len;
+	struct in6_addr addr_buf;
 	struct inet6_dev *idev;
 	struct sk_buff *skb;
 	struct mld_msg *hdr;
-	const struct in6_addr *snd_addr, *saddr;
-	struct in6_addr addr_buf;
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	int err, len, payload_len, full_len;
 	u8 ra[8] = { IPPROTO_ICMPV6, 0,
 		     IPV6_TLV_ROUTERALERT, 2, 0, 0,
 		     IPV6_TLV_PADN, 0 };
-	struct flowi6 fl6;
 	struct dst_entry *dst;
+	struct flowi6 fl6;
+	struct net *net;
+	struct sock *sk;
 
 	if (type == ICMPV6_MGM_REDUCTION)
 		snd_addr = &in6addr_linklocal_allrouters;
@@ -2147,19 +2153,21 @@ static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 	payload_len = len + sizeof(ra);
 	full_len = sizeof(struct ipv6hdr) + payload_len;
 
-	rcu_read_lock();
-	IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_OUTREQUESTS);
-	rcu_read_unlock();
+	skb = alloc_skb(hlen + tlen + full_len, GFP_KERNEL);
 
-	skb = sock_alloc_send_skb(sk, hlen + tlen + full_len, 1, &err);
+	rcu_read_lock();
 
+	net = dev_net_rcu(dev);
+	idev = __in6_dev_get(dev);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 	if (!skb) {
-		rcu_read_lock();
-		IP6_INC_STATS(net, __in6_dev_get(dev),
-			      IPSTATS_MIB_OUTDISCARDS);
+		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		rcu_read_unlock();
 		return;
 	}
+	sk = net->ipv6.igmp_sk;
+	skb_set_owner_w(skb, sk);
+
 	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(skb, hlen);
 
@@ -2184,9 +2192,6 @@ static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 					 IPPROTO_ICMPV6,
 					 csum_partial(hdr, len, 0));
 
-	rcu_read_lock();
-	idev = __in6_dev_get(skb->dev);
-
 	icmpv6_flow_init(sk, &fl6, type,
 			 &ipv6_hdr(skb)->saddr, &ipv6_hdr(skb)->daddr,
 			 skb->dev->ifindex);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index d044c67019de..8699d1a188dc 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -418,15 +418,11 @@ static struct sk_buff *ndisc_alloc_skb(struct net_device *dev,
 {
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	struct sock *sk = dev_net(dev)->ipv6.ndisc_sk;
 	struct sk_buff *skb;
 
 	skb = alloc_skb(hlen + sizeof(struct ipv6hdr) + len + tlen, GFP_ATOMIC);
-	if (!skb) {
-		ND_PRINTK(0, err, "ndisc: %s failed to allocate an skb\n",
-			  __func__);
+	if (!skb)
 		return NULL;
-	}
 
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
@@ -437,7 +433,9 @@ static struct sk_buff *ndisc_alloc_skb(struct net_device *dev,
 	/* Manually assign socket ownership as we avoid calling
 	 * sock_alloc_send_pskb() to bypass wmem buffer limits
 	 */
-	skb_set_owner_w(skb, sk);
+	rcu_read_lock();
+	skb_set_owner_w(skb, dev_net_rcu(dev)->ipv6.ndisc_sk);
+	rcu_read_unlock();
 
 	return skb;
 }
@@ -473,16 +471,20 @@ static void ip6_nd_hdr(struct sk_buff *skb,
 void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 		    const struct in6_addr *saddr)
 {
+	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(skb->dev);
-	struct sock *sk = net->ipv6.ndisc_sk;
 	struct inet6_dev *idev;
+	struct net *net;
+	struct sock *sk;
 	int err;
-	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	u8 type;
 
 	type = icmp6h->icmp6_type;
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(skb->dev);
+	sk = net->ipv6.ndisc_sk;
 	if (!dst) {
 		struct flowi6 fl6;
 		int oif = skb->dev->ifindex;
@@ -490,6 +492,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 		icmpv6_flow_init(sk, &fl6, type, saddr, daddr, oif);
 		dst = icmp6_dst_alloc(skb->dev, &fl6);
 		if (IS_ERR(dst)) {
+			rcu_read_unlock();
 			kfree_skb(skb);
 			return;
 		}
@@ -504,7 +507,6 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	ip6_nd_hdr(skb, saddr, daddr, READ_ONCE(inet6_sk(sk)->hop_limit), skb->len);
 
-	rcu_read_lock();
 	idev = __in6_dev_get(dst->dev);
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
@@ -1694,7 +1696,7 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	bool ret;
 
 	if (netif_is_l3_master(skb->dev)) {
-		dev = __dev_get_by_index(dev_net(skb->dev), IPCB(skb)->iif);
+		dev = dev_get_by_index_rcu(dev_net(skb->dev), IPCB(skb)->iif);
 		if (!dev)
 			return;
 	}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 8ebfed5d6323..2736dea77575 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3196,13 +3196,18 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
 	unsigned int mtu = dst_mtu(dst);
-	struct net *net = dev_net(dev);
+	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(dev);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
+	rcu_read_unlock();
+
 	/*
 	 * Maximal non-jumbo IPv6 payload is IPV6_MAXPLEN and
 	 * corresponding MSS is IPV6_MAXPLEN - tcp_header_size.
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index db3c19a42e1c..0ac4283acdf2 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -125,7 +125,8 @@ static void rpl_destroy_state(struct lwtunnel_state *lwt)
 }
 
 static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
-			     const struct ipv6_rpl_sr_hdr *srh)
+			     const struct ipv6_rpl_sr_hdr *srh,
+			     struct dst_entry *cache_dst)
 {
 	struct ipv6_rpl_sr_hdr *isrh, *csrh;
 	const struct ipv6hdr *oldhdr;
@@ -153,7 +154,7 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 
 	hdrlen = ((csrh->hdrlen + 1) << 3);
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err)) {
 		kfree(buf);
 		return err;
@@ -186,7 +187,8 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 	return 0;
 }
 
-static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt)
+static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt,
+		      struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct rpl_iptunnel_encap *tinfo;
@@ -196,7 +198,7 @@ static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt)
 
 	tinfo = rpl_encap_lwtunnel(dst->lwtstate);
 
-	return rpl_do_srh_inline(skb, rlwt, tinfo->srh);
+	return rpl_do_srh_inline(skb, rlwt, tinfo->srh, cache_dst);
 }
 
 static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
@@ -208,14 +210,14 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
 
-	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err))
-		goto drop;
-
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
 	local_bh_enable();
 
+	err = rpl_do_srh(skb, rlwt, dst);
+	if (unlikely(err))
+		goto drop;
+
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -230,25 +232,28 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		dst = ip6_route_output(net, NULL, &fl6);
 		if (dst->error) {
 			err = dst->error;
-			dst_release(dst);
 			goto drop;
 		}
 
-		local_bh_disable();
-		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
-		local_bh_enable();
+		/* cache only if we don't create a dst reference loop */
+		if (orig_dst->lwtstate != dst->lwtstate) {
+			local_bh_disable();
+			dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	}
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
-
 	return dst_output(net, sk, skb);
 
 drop:
+	dst_release(dst);
 	kfree_skb(skb);
 	return err;
 }
@@ -262,29 +267,33 @@ static int rpl_input(struct sk_buff *skb)
 
 	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
 
-	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err))
-		goto drop;
-
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
+	local_bh_enable();
+
+	err = rpl_do_srh(skb, rlwt, dst);
+	if (unlikely(err)) {
+		dst_release(dst);
+		goto drop;
+	}
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
+			local_bh_disable();
 			dst_cache_set_ip6(&rlwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
+			local_bh_enable();
 		}
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	} else {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	}
-	local_bh_enable();
-
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
 
 	return dst_input(skb);
 
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 098632adc9b5..33833b2064c0 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -124,8 +124,8 @@ static __be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
 	return flowlabel;
 }
 
-/* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
-int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
+static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
+			       int proto, struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct net *net = dev_net(dst->dev);
@@ -137,7 +137,7 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 	hdrlen = (osrh->hdrlen + 1) << 3;
 	tot_len = hdrlen + sizeof(*hdr);
 
-	err = skb_cow_head(skb, tot_len + skb->mac_len);
+	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -197,11 +197,18 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 
 	return 0;
 }
+
+/* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
+int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
+{
+	return __seg6_do_srh_encap(skb, osrh, proto, NULL);
+}
 EXPORT_SYMBOL_GPL(seg6_do_srh_encap);
 
 /* encapsulate an IPv6 packet within an outer IPv6 header with reduced SRH */
 static int seg6_do_srh_encap_red(struct sk_buff *skb,
-				 struct ipv6_sr_hdr *osrh, int proto)
+				 struct ipv6_sr_hdr *osrh, int proto,
+				 struct dst_entry *cache_dst)
 {
 	__u8 first_seg = osrh->first_segment;
 	struct dst_entry *dst = skb_dst(skb);
@@ -230,7 +237,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 	tot_len = red_hdrlen + sizeof(struct ipv6hdr);
 
-	err = skb_cow_head(skb, tot_len + skb->mac_len);
+	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -317,8 +324,8 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 	return 0;
 }
 
-/* insert an SRH within an IPv6 packet, just after the IPv6 header */
-int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
+static int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
+				struct dst_entry *cache_dst)
 {
 	struct ipv6hdr *hdr, *oldhdr;
 	struct ipv6_sr_hdr *isrh;
@@ -326,7 +333,7 @@ int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
 
 	hdrlen = (osrh->hdrlen + 1) << 3;
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -369,9 +376,8 @@ int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(seg6_do_srh_inline);
 
-static int seg6_do_srh(struct sk_buff *skb)
+static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct seg6_iptunnel_encap *tinfo;
@@ -384,7 +390,7 @@ static int seg6_do_srh(struct sk_buff *skb)
 		if (skb->protocol != htons(ETH_P_IPV6))
 			return -EINVAL;
 
-		err = seg6_do_srh_inline(skb, tinfo->srh);
+		err = __seg6_do_srh_inline(skb, tinfo->srh, cache_dst);
 		if (err)
 			return err;
 		break;
@@ -402,9 +408,11 @@ static int seg6_do_srh(struct sk_buff *skb)
 			return -EINVAL;
 
 		if (tinfo->mode == SEG6_IPTUN_MODE_ENCAP)
-			err = seg6_do_srh_encap(skb, tinfo->srh, proto);
+			err = __seg6_do_srh_encap(skb, tinfo->srh,
+						  proto, cache_dst);
 		else
-			err = seg6_do_srh_encap_red(skb, tinfo->srh, proto);
+			err = seg6_do_srh_encap_red(skb, tinfo->srh,
+						    proto, cache_dst);
 
 		if (err)
 			return err;
@@ -425,11 +433,13 @@ static int seg6_do_srh(struct sk_buff *skb)
 		skb_push(skb, skb->mac_len);
 
 		if (tinfo->mode == SEG6_IPTUN_MODE_L2ENCAP)
-			err = seg6_do_srh_encap(skb, tinfo->srh,
-						IPPROTO_ETHERNET);
+			err = __seg6_do_srh_encap(skb, tinfo->srh,
+						  IPPROTO_ETHERNET,
+						  cache_dst);
 		else
 			err = seg6_do_srh_encap_red(skb, tinfo->srh,
-						    IPPROTO_ETHERNET);
+						    IPPROTO_ETHERNET,
+						    cache_dst);
 
 		if (err)
 			return err;
@@ -444,6 +454,13 @@ static int seg6_do_srh(struct sk_buff *skb)
 	return 0;
 }
 
+/* insert an SRH within an IPv6 packet, just after the IPv6 header */
+int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
+{
+	return __seg6_do_srh_inline(skb, osrh, NULL);
+}
+EXPORT_SYMBOL_GPL(seg6_do_srh_inline);
+
 static int seg6_input_finish(struct net *net, struct sock *sk,
 			     struct sk_buff *skb)
 {
@@ -458,31 +475,35 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	struct seg6_lwt *slwt;
 	int err;
 
-	err = seg6_do_srh(skb);
-	if (unlikely(err))
-		goto drop;
-
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
+	local_bh_enable();
+
+	err = seg6_do_srh(skb, dst);
+	if (unlikely(err)) {
+		dst_release(dst);
+		goto drop;
+	}
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
+			local_bh_disable();
 			dst_cache_set_ip6(&slwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
+			local_bh_enable();
 		}
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	} else {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	}
-	local_bh_enable();
-
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
@@ -528,16 +549,16 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 	struct seg6_lwt *slwt;
 	int err;
 
-	err = seg6_do_srh(skb);
-	if (unlikely(err))
-		goto drop;
-
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
 	local_bh_enable();
 
+	err = seg6_do_srh(skb, dst);
+	if (unlikely(err))
+		goto drop;
+
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -552,28 +573,31 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 		dst = ip6_route_output(net, NULL, &fl6);
 		if (dst->error) {
 			err = dst->error;
-			dst_release(dst);
 			goto drop;
 		}
 
-		local_bh_disable();
-		dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
-		local_bh_enable();
+		/* cache only if we don't create a dst reference loop */
+		if (orig_dst->lwtstate != dst->lwtstate) {
+			local_bh_disable();
+			dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	}
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
-
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
 			       NULL, skb_dst(skb)->dev, dst_output);
 
 	return dst_output(net, sk, skb);
 drop:
+	dst_release(dst);
 	kfree_skb(skb);
 	return err;
 }
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 78d9961fcd44..8d3c01f0e2aa 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2102,6 +2102,7 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 {
 	struct ovs_header *ovs_header;
 	struct ovs_vport_stats vport_stats;
+	struct net *net_vport;
 	int err;
 
 	ovs_header = genlmsg_put(skb, portid, seq, &dp_vport_genl_family,
@@ -2118,12 +2119,15 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	    nla_put_u32(skb, OVS_VPORT_ATTR_IFINDEX, vport->dev->ifindex))
 		goto nla_put_failure;
 
-	if (!net_eq(net, dev_net(vport->dev))) {
-		int id = peernet2id_alloc(net, dev_net(vport->dev), gfp);
+	rcu_read_lock();
+	net_vport = dev_net_rcu(vport->dev);
+	if (!net_eq(net, net_vport)) {
+		int id = peernet2id_alloc(net, net_vport, GFP_ATOMIC);
 
 		if (nla_put_s32(skb, OVS_VPORT_ATTR_NETNSID, id))
-			goto nla_put_failure;
+			goto nla_put_failure_unlock;
 	}
+	rcu_read_unlock();
 
 	ovs_vport_get_stats(vport, &vport_stats);
 	if (nla_put_64bit(skb, OVS_VPORT_ATTR_STATS,
@@ -2144,6 +2148,8 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	genlmsg_end(skb, ovs_header);
 	return 0;
 
+nla_put_failure_unlock:
+	rcu_read_unlock();
 nla_put_failure:
 	err = -EMSGSIZE;
 error:
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f5d116a1bdea..37299a7ca187 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -337,7 +337,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
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
@@ -821,6 +824,13 @@ static void __vsock_release(struct sock *sk, int level)
 	 */
 	lock_sock_nested(sk, level);
 
+	/* Indicate to vsock_remove_sock() that the socket is being released and
+	 * can be removed from the bound_table. Unlike transport reassignment
+	 * case, where the socket must remain bound despite vsock_remove_sock()
+	 * being called from the transport release() callback.
+	 */
+	sock_set_flag(sk, SOCK_DEAD);
+
 	if (vsk->transport)
 		vsk->transport->release(vsk);
 	else if (sock_type_connectible(sk->sk_type))
diff --git a/rust/Makefile b/rust/Makefile
index 9f59baacaf77..45779a064fa4 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -229,6 +229,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fzero-call-used-regs=% -fno-stack-clash-protection \
 	-fno-inline-functions-called-once -fsanitize=bounds-strict \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
+	-fzero-init-padding-bits=% \
 	--param=% --param asan-%
 
 # Derived from `scripts/Makefile.clang`.
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index d03e4aa1f481..7543378d3729 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -1147,7 +1147,7 @@ pub struct VacantEntry<'a, K, V> {
 /// # Invariants
 /// - `parent` may be null if the new node becomes the root.
 /// - `child_field_of_parent` is a valid pointer to the left-child or right-child of `parent`. If `parent` is
-///     null, it is a pointer to the root of the [`RBTree`].
+///   null, it is a pointer to the root of the [`RBTree`].
 struct RawVacantEntry<'a, K, V> {
     rbtree: *mut RBTree<K, V>,
     /// The node that will become the parent of the new node if we insert one.
diff --git a/scripts/Makefile.defconf b/scripts/Makefile.defconf
index 226ea3df3b4b..a44307f08e9d 100644
--- a/scripts/Makefile.defconf
+++ b/scripts/Makefile.defconf
@@ -1,6 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Configuration heplers
 
+cmd_merge_fragments = \
+	$(srctree)/scripts/kconfig/merge_config.sh \
+	$4 -m -O $(objtree) $(srctree)/arch/$(SRCARCH)/configs/$2 \
+	$(foreach config,$3,$(srctree)/arch/$(SRCARCH)/configs/$(config).config)
+
 # Creates 'merged defconfigs'
 # ---------------------------------------------------------------------------
 # Usage:
@@ -8,9 +13,7 @@
 #
 # Input config fragments without '.config' suffix
 define merge_into_defconfig
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-		-m -O $(objtree) $(srctree)/arch/$(SRCARCH)/configs/$(1) \
-		$(foreach config,$(2),$(srctree)/arch/$(SRCARCH)/configs/$(config).config)
+	$(call cmd,merge_fragments,$1,$2)
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 endef
 
@@ -22,8 +25,6 @@ endef
 #
 # Input config fragments without '.config' suffix
 define merge_into_defconfig_override
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-		-Q -m -O $(objtree) $(srctree)/arch/$(SRCARCH)/configs/$(1) \
-		$(foreach config,$(2),$(srctree)/arch/$(SRCARCH)/configs/$(config).config)
+	$(call cmd,merge_fragments,$1,$2,-Q)
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 endef
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 04faf15ed316..dc081cf46d21 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -31,6 +31,11 @@ KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
 ifdef CONFIG_CC_IS_CLANG
 # The kernel builds with '-std=gnu11' so use of GNU extensions is acceptable.
 KBUILD_CFLAGS += -Wno-gnu
+
+# Clang checks for overflow/truncation with '%p', while GCC does not:
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111219
+KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow-non-kprintf)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation-non-kprintf)
 else
 
 # gcc inanely warns about local variables called 'main'
@@ -77,6 +82,9 @@ KBUILD_CFLAGS += $(call cc-option,-Werror=designated-init)
 # Warn if there is an enum types mismatch
 KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
 
+# Explicitly clear padding bits during variable initialization
+KBUILD_CFLAGS += $(call cc-option,-fzero-init-padding-bits=all)
+
 KBUILD_CFLAGS += -Wextra
 KBUILD_CFLAGS += -Wunused
 
@@ -102,11 +110,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
 ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
-else
-# Clang checks for overflow/truncation with '%p', while GCC does not:
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111219
-KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow-non-kprintf)
-KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation-non-kprintf)
 endif
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index a0a0be38cbdc..fb50bd4f4103 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -105,9 +105,11 @@ configfiles = $(wildcard $(srctree)/kernel/configs/$(1) $(srctree)/arch/$(SRCARC
 all-config-fragments = $(call configfiles,*.config)
 config-fragments = $(call configfiles,$@)
 
+cmd_merge_fragments = $(srctree)/scripts/kconfig/merge_config.sh -m $(KCONFIG_CONFIG) $(config-fragments)
+
 %.config: $(obj)/conf
 	$(if $(config-fragments),, $(error $@ fragment does not exists on this architecture))
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m $(KCONFIG_CONFIG) $(config-fragments)
+	$(call cmd,merge_fragments)
 	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
 PHONY += tinyconfig
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 54f77f57ec8e..1148e9498d8e 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1132,7 +1132,22 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
-	{	/* Vexia Edu Atla 10 tablet */
+	{
+		/* Vexia Edu Atla 10 tablet 5V version */
+		.matches = {
+			/* Having all 3 of these not set is somewhat unique */
+			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_BOARD_NAME, "To be filled by O.E.M."),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "05/14/2015"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
+	{	/* Vexia Edu Atla 10 tablet 9V version */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f0d8796b984a..8e02db7e8332 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -218,6 +218,7 @@ static bool is_rust_noreturn(const struct symbol *func)
 	       str_ends_with(func->name, "_4core9panicking18panic_bounds_check")			||
 	       str_ends_with(func->name, "_4core9panicking19assert_failed_inner")			||
 	       str_ends_with(func->name, "_4core9panicking36panic_misaligned_pointer_dereference")	||
+	       strstr(func->name, "_4core9panicking13assert_failed")					||
 	       strstr(func->name, "_4core9panicking11panic_const24panic_const_")			||
 	       (strstr(func->name, "_4core5slice5index24slice_") &&
 		str_ends_with(func->name, "_fail"));
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 248ab790d143..f7206374a73d 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -251,8 +251,16 @@ void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
 #define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
 #define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
 
-void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
-void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
+int bpf_list_push_front_impl(struct bpf_list_head *head,
+				    struct bpf_list_node *node,
+				    void *meta, __u64 off) __ksym;
+#define bpf_list_push_front(head, node) bpf_list_push_front_impl(head, node, NULL, 0)
+
+int bpf_list_push_back_impl(struct bpf_list_head *head,
+				   struct bpf_list_node *node,
+				   void *meta, __u64 off) __ksym;
+#define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, node, NULL, 0)
+
 struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
 struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
 struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index f0a3a9c18e9e..9006549a1294 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -226,7 +226,7 @@ static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 	ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
 		  "pthread_create");
 
-	skel->bss->tid = gettid();
+	skel->bss->tid = syscall(SYS_gettid);
 
 	do_dummy_read_opts(skel->progs.dump_task, opts);
 
@@ -255,10 +255,10 @@ static void *run_test_task_tid(void *arg)
 	union bpf_iter_link_info linfo;
 	int num_unknown_tid, num_known_tid;
 
-	ASSERT_NEQ(getpid(), gettid(), "check_new_thread_id");
+	ASSERT_NEQ(getpid(), syscall(SYS_gettid), "check_new_thread_id");
 
 	memset(&linfo, 0, sizeof(linfo));
-	linfo.task.tid = gettid();
+	linfo.task.tid = syscall(SYS_gettid);
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
 	test_task_common(&opts, 0, 1);
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 844f6fc8487b..c1ac813ff9ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -869,21 +869,14 @@ static void consumer_test(struct uprobe_multi_consumers *skel,
 			fmt = "prog 0/1: uprobe";
 		} else {
 			/*
-			 * uprobe return is tricky ;-)
-			 *
 			 * to trigger uretprobe consumer, the uretprobe needs to be installed,
 			 * which means one of the 'return' uprobes was alive when probe was hit:
 			 *
 			 *   idxs: 2/3 uprobe return in 'installed' mask
-			 *
-			 * in addition if 'after' state removes everything that was installed in
-			 * 'before' state, then uprobe kernel object goes away and return uprobe
-			 * is not installed and we won't hit it even if it's in 'after' state.
 			 */
 			unsigned long had_uretprobes  = before & 0b1100; /* is uretprobe installed */
-			unsigned long probe_preserved = before & after;  /* did uprobe go away */
 
-			if (had_uretprobes && probe_preserved && test_bit(idx, after))
+			if (had_uretprobes && test_bit(idx, after))
 				val++;
 			fmt = "idx 2/3: uretprobe";
 		}
diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index 6fb66a687f17..bbc29ed9c60a 100755
--- a/tools/testing/selftests/gpio/gpio-sim.sh
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -46,12 +46,6 @@ remove_chip() {
 	rmdir $CONFIGFS_DIR/$CHIP || fail "Unable to remove the chip"
 }
 
-configfs_cleanup() {
-	for CHIP in `ls $CONFIGFS_DIR/`; do
-		remove_chip $CHIP
-	done
-}
-
 create_chip() {
 	local CHIP=$1
 
@@ -105,6 +99,13 @@ disable_chip() {
 	echo 0 > $CONFIGFS_DIR/$CHIP/live || fail "Unable to disable the chip"
 }
 
+configfs_cleanup() {
+	for CHIP in `ls $CONFIGFS_DIR/`; do
+		disable_chip $CHIP
+		remove_chip $CHIP
+	done
+}
+
 configfs_chip_name() {
 	local CHIP=$1
 	local BANK=$2
@@ -181,6 +182,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test -n `cat $CONFIGFS_DIR/chip/bank/chip_name` || fail "chip_name doesn't work"
+disable_chip chip
 remove_chip chip
 
 echo "1.2. chip_name returns 'none' if the chip is still pending"
@@ -195,6 +197,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test -n `cat $CONFIGFS_DIR/chip/dev_name` || fail "dev_name doesn't work"
+disable_chip chip
 remove_chip chip
 
 echo "2. Creating and configuring simulated chips"
@@ -204,6 +207,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test "`get_chip_num_lines chip bank`" = "1" || fail "default number of lines is not 1"
+disable_chip chip
 remove_chip chip
 
 echo "2.2. Number of lines can be specified"
@@ -212,6 +216,7 @@ create_bank chip bank
 set_num_lines chip bank 16
 enable_chip chip
 test "`get_chip_num_lines chip bank`" = "16" || fail "number of lines is not 16"
+disable_chip chip
 remove_chip chip
 
 echo "2.3. Label can be set"
@@ -220,6 +225,7 @@ create_bank chip bank
 set_label chip bank foobar
 enable_chip chip
 test "`get_chip_label chip bank`" = "foobar" || fail "label is incorrect"
+disable_chip chip
 remove_chip chip
 
 echo "2.4. Label can be left empty"
@@ -227,6 +233,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test -z "`cat $CONFIGFS_DIR/chip/bank/label`" || fail "label is not empty"
+disable_chip chip
 remove_chip chip
 
 echo "2.5. Line names can be configured"
@@ -238,6 +245,7 @@ set_line_name chip bank 2 bar
 enable_chip chip
 test "`get_line_name chip bank 0`" = "foo" || fail "line name is incorrect"
 test "`get_line_name chip bank 2`" = "bar" || fail "line name is incorrect"
+disable_chip chip
 remove_chip chip
 
 echo "2.6. Line config can remain unused if offset is greater than number of lines"
@@ -248,6 +256,7 @@ set_line_name chip bank 5 foobar
 enable_chip chip
 test "`get_line_name chip bank 0`" = "" || fail "line name is incorrect"
 test "`get_line_name chip bank 1`" = "" || fail "line name is incorrect"
+disable_chip chip
 remove_chip chip
 
 echo "2.7. Line configfs directory names are sanitized"
@@ -267,6 +276,7 @@ for CHIP in $CHIPS; do
 	enable_chip $CHIP
 done
 for CHIP in $CHIPS; do
+  disable_chip $CHIP
 	remove_chip $CHIP
 done
 
@@ -278,6 +288,7 @@ echo foobar > $CONFIGFS_DIR/chip/bank/label 2> /dev/null && \
 	fail "Setting label of a live chip should fail"
 echo 8 > $CONFIGFS_DIR/chip/bank/num_lines 2> /dev/null && \
 	fail "Setting number of lines of a live chip should fail"
+disable_chip chip
 remove_chip chip
 
 echo "2.10. Can't create line items when chip is live"
@@ -285,6 +296,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 mkdir $CONFIGFS_DIR/chip/bank/line0 2> /dev/null && fail "Creating line item should fail"
+disable_chip chip
 remove_chip chip
 
 echo "2.11. Probe errors are propagated to user-space"
@@ -316,6 +328,7 @@ mkdir -p $CONFIGFS_DIR/chip/bank/line4/hog
 enable_chip chip
 $BASE_DIR/gpio-mockup-cdev -s 1 /dev/`configfs_chip_name chip bank` 4 2> /dev/null && \
 	fail "Setting the value of a hogged line shouldn't succeed"
+disable_chip chip
 remove_chip chip
 
 echo "3. Controlling simulated chips"
@@ -331,6 +344,7 @@ test "$?" = "1" || fail "pull set incorrectly"
 sysfs_set_pull chip bank 0 pull-down
 $BASE_DIR/gpio-mockup-cdev /dev/`configfs_chip_name chip bank` 1
 test "$?" = "0" || fail "pull set incorrectly"
+disable_chip chip
 remove_chip chip
 
 echo "3.2. Pull can be read from sysfs"
@@ -344,6 +358,7 @@ SYSFS_PATH=/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/pull
 test `cat $SYSFS_PATH` = "pull-down" || fail "reading the pull failed"
 sysfs_set_pull chip bank 0 pull-up
 test `cat $SYSFS_PATH` = "pull-up" || fail "reading the pull failed"
+disable_chip chip
 remove_chip chip
 
 echo "3.3. Incorrect input in sysfs is rejected"
@@ -355,6 +370,7 @@ DEVNAME=`configfs_dev_name chip`
 CHIPNAME=`configfs_chip_name chip bank`
 SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/pull"
 echo foobar > $SYSFS_PATH 2> /dev/null && fail "invalid input not detected"
+disable_chip chip
 remove_chip chip
 
 echo "3.4. Can't write to value"
@@ -365,6 +381,7 @@ DEVNAME=`configfs_dev_name chip`
 CHIPNAME=`configfs_chip_name chip bank`
 SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
 echo 1 > $SYSFS_PATH 2> /dev/null && fail "writing to 'value' succeeded unexpectedly"
+disable_chip chip
 remove_chip chip
 
 echo "4. Simulated GPIO chips are functional"
@@ -382,6 +399,7 @@ $BASE_DIR/gpio-mockup-cdev -s 1 /dev/`configfs_chip_name chip bank` 0 &
 sleep 0.1 # FIXME Any better way?
 test `cat $SYSFS_PATH` = "1" || fail "incorrect value read from sysfs"
 kill $!
+disable_chip chip
 remove_chip chip
 
 echo "4.2. Bias settings work correctly"
@@ -394,6 +412,7 @@ CHIPNAME=`configfs_chip_name chip bank`
 SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
 $BASE_DIR/gpio-mockup-cdev -b pull-up /dev/`configfs_chip_name chip bank` 0
 test `cat $SYSFS_PATH` = "1" || fail "bias setting does not work"
+disable_chip chip
 remove_chip chip
 
 echo "GPIO $MODULE test PASS"
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 6c651c880fe8..66be7699c72c 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -197,6 +197,12 @@
 #
 # - pmtu_ipv6_route_change
 #	Same as above but with IPv6
+#
+# - pmtu_ipv4_mp_exceptions
+#	Use the same topology as in pmtu_ipv4, but add routeable addresses
+#	on host A and B on lo reachable via both routers. Host A and B
+#	addresses have multipath routes to each other, b_r1 mtu = 1500.
+#	Check that PMTU exceptions are created for both paths.
 
 source lib.sh
 source net_helper.sh
@@ -266,7 +272,8 @@ tests="
 	list_flush_ipv4_exception	ipv4: list and flush cached exceptions	1
 	list_flush_ipv6_exception	ipv6: list and flush cached exceptions	1
 	pmtu_ipv4_route_change		ipv4: PMTU exception w/route replace	1
-	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1"
+	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1
+	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions	1"
 
 # Addressing and routing for tests with routers: four network segments, with
 # index SEGMENT between 1 and 4, a common prefix (PREFIX4 or PREFIX6) and an
@@ -343,6 +350,9 @@ tunnel6_a_addr="fd00:2::a"
 tunnel6_b_addr="fd00:2::b"
 tunnel6_mask="64"
 
+host4_a_addr="192.168.99.99"
+host4_b_addr="192.168.88.88"
+
 dummy6_0_prefix="fc00:1000::"
 dummy6_1_prefix="fc00:1001::"
 dummy6_mask="64"
@@ -984,6 +994,52 @@ setup_ovs_bridge() {
 	run_cmd ip route add ${prefix6}:${b_r1}::1 via ${prefix6}:${a_r1}::2
 }
 
+setup_multipath_new() {
+	# Set up host A with multipath routes to host B host4_b_addr
+	run_cmd ${ns_a} ip addr add ${host4_a_addr} dev lo
+	run_cmd ${ns_a} ip nexthop add id 401 via ${prefix4}.${a_r1}.2 dev veth_A-R1
+	run_cmd ${ns_a} ip nexthop add id 402 via ${prefix4}.${a_r2}.2 dev veth_A-R2
+	run_cmd ${ns_a} ip nexthop add id 403 group 401/402
+	run_cmd ${ns_a} ip route add ${host4_b_addr} src ${host4_a_addr} nhid 403
+
+	# Set up host B with multipath routes to host A host4_a_addr
+	run_cmd ${ns_b} ip addr add ${host4_b_addr} dev lo
+	run_cmd ${ns_b} ip nexthop add id 401 via ${prefix4}.${b_r1}.2 dev veth_B-R1
+	run_cmd ${ns_b} ip nexthop add id 402 via ${prefix4}.${b_r2}.2 dev veth_B-R2
+	run_cmd ${ns_b} ip nexthop add id 403 group 401/402
+	run_cmd ${ns_b} ip route add ${host4_a_addr} src ${host4_b_addr} nhid 403
+}
+
+setup_multipath_old() {
+	# Set up host A with multipath routes to host B host4_b_addr
+	run_cmd ${ns_a} ip addr add ${host4_a_addr} dev lo
+	run_cmd ${ns_a} ip route add ${host4_b_addr} \
+			src ${host4_a_addr} \
+			nexthop via ${prefix4}.${a_r1}.2 weight 1 \
+			nexthop via ${prefix4}.${a_r2}.2 weight 1
+
+	# Set up host B with multipath routes to host A host4_a_addr
+	run_cmd ${ns_b} ip addr add ${host4_b_addr} dev lo
+	run_cmd ${ns_b} ip route add ${host4_a_addr} \
+			src ${host4_b_addr} \
+			nexthop via ${prefix4}.${b_r1}.2 weight 1 \
+			nexthop via ${prefix4}.${b_r2}.2 weight 1
+}
+
+setup_multipath() {
+	if [ "$USE_NH" = "yes" ]; then
+		setup_multipath_new
+	else
+		setup_multipath_old
+	fi
+
+	# Set up routers with routes to dummies
+	run_cmd ${ns_r1} ip route add ${host4_a_addr} via ${prefix4}.${a_r1}.1
+	run_cmd ${ns_r2} ip route add ${host4_a_addr} via ${prefix4}.${a_r2}.1
+	run_cmd ${ns_r1} ip route add ${host4_b_addr} via ${prefix4}.${b_r1}.1
+	run_cmd ${ns_r2} ip route add ${host4_b_addr} via ${prefix4}.${b_r2}.1
+}
+
 setup() {
 	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return $ksft_skip
 
@@ -1076,23 +1132,15 @@ link_get_mtu() {
 }
 
 route_get_dst_exception() {
-	ns_cmd="${1}"
-	dst="${2}"
-	dsfield="${3}"
+	ns_cmd="${1}"; shift
 
-	if [ -z "${dsfield}" ]; then
-		dsfield=0
-	fi
-
-	${ns_cmd} ip route get "${dst}" dsfield "${dsfield}"
+	${ns_cmd} ip route get "$@"
 }
 
 route_get_dst_pmtu_from_exception() {
-	ns_cmd="${1}"
-	dst="${2}"
-	dsfield="${3}"
+	ns_cmd="${1}"; shift
 
-	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "${dst}" "${dsfield}")"
+	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "$@")"
 }
 
 check_pmtu_value() {
@@ -1235,10 +1283,10 @@ test_pmtu_ipv4_dscp_icmp_exception() {
 	run_cmd "${ns_a}" ping -q -M want -Q "${dsfield}" -c 1 -w 1 -s "${len}" "${dst2}"
 
 	# Check that exceptions have been created with the correct PMTU
-	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${policy_mark}")"
+	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" dsfield "${policy_mark}")"
 	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
 
-	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${policy_mark}")"
+	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" dsfield "${policy_mark}")"
 	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
 }
 
@@ -1285,9 +1333,9 @@ test_pmtu_ipv4_dscp_udp_exception() {
 		UDP:"${dst2}":50000,tos="${dsfield}"
 
 	# Check that exceptions have been created with the correct PMTU
-	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${policy_mark}")"
+	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" dsfield "${policy_mark}")"
 	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
-	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${policy_mark}")"
+	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" dsfield "${policy_mark}")"
 	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
 }
 
@@ -2329,6 +2377,36 @@ test_pmtu_ipv6_route_change() {
 	test_pmtu_ipvX_route_change 6
 }
 
+test_pmtu_ipv4_mp_exceptions() {
+	setup namespaces routing multipath || return $ksft_skip
+
+	trace "${ns_a}"  veth_A-R1    "${ns_r1}" veth_R1-A \
+	      "${ns_r1}" veth_R1-B    "${ns_b}"  veth_B-R1 \
+	      "${ns_a}"  veth_A-R2    "${ns_r2}" veth_R2-A \
+	      "${ns_r2}" veth_R2-B    "${ns_b}"  veth_B-R2
+
+	# Set up initial MTU values
+	mtu "${ns_a}"  veth_A-R1 2000
+	mtu "${ns_r1}" veth_R1-A 2000
+	mtu "${ns_r1}" veth_R1-B 1500
+	mtu "${ns_b}"  veth_B-R1 1500
+
+	mtu "${ns_a}"  veth_A-R2 2000
+	mtu "${ns_r2}" veth_R2-A 2000
+	mtu "${ns_r2}" veth_R2-B 1500
+	mtu "${ns_b}"  veth_B-R2 1500
+
+	# Ping and expect two nexthop exceptions for two routes
+	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${host4_b_addr}"
+
+	# Check that exceptions have been created with the correct PMTU
+	pmtu_a_R1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R1)"
+	pmtu_a_R2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R2)"
+
+	check_pmtu_value "1500" "${pmtu_a_R1}" "exceeding MTU (veth_A-R1)" || return 1
+	check_pmtu_value "1500" "${pmtu_a_R2}" "exceeding MTU (veth_A-R2)" || return 1
+}
+
 usage() {
 	echo
 	echo "$0 [OPTIONS] [TEST]..."
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index bdf6f10d0558..87dce3efe31e 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -809,10 +809,10 @@ kci_test_ipsec_offload()
 	# does driver have correct offload info
 	run_cmd diff $sysfsf - << EOF
 SA count=2 tx=3
-sa[0] tx ipaddr=0x00000000 00000000 00000000 00000000
+sa[0] tx ipaddr=$dstip
 sa[0]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 sa[0]    key=0x34333231 38373635 32313039 36353433
-sa[1] rx ipaddr=0x00000000 00000000 00000000 037ba8c0
+sa[1] rx ipaddr=$srcip
 sa[1]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 sa[1]    key=0x34333231 38373635 32313039 36353433
 EOF
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4cbd2d8ebb04..397dc962f5e2 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1143,6 +1143,14 @@ static int stop_tracing;
 static struct trace_instance *hist_inst = NULL;
 static void stop_hist(int sig)
 {
+	if (stop_tracing) {
+		/*
+		 * Stop requested twice in a row; abort event processing and
+		 * exit immediately
+		 */
+		tracefs_iterate_stop(hist_inst->inst);
+		return;
+	}
 	stop_tracing = 1;
 	if (hist_inst)
 		trace_instance_stop(hist_inst);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d13be28dacd5..0def5fec51ed 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -897,6 +897,14 @@ static int stop_tracing;
 static struct trace_instance *top_inst = NULL;
 static void stop_top(int sig)
 {
+	if (stop_tracing) {
+		/*
+		 * Stop requested twice in a row; abort event processing and
+		 * exit immediately
+		 */
+		tracefs_iterate_stop(top_inst->inst);
+		return;
+	}
 	stop_tracing = 1;
 	if (top_inst)
 		trace_instance_stop(top_inst);

