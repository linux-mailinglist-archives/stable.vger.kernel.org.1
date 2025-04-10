Return-Path: <stable+bounces-132110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8E9A84410
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811969A2114
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113428A40C;
	Thu, 10 Apr 2025 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S8GljfXt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245202857E7;
	Thu, 10 Apr 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290299; cv=none; b=bh4rOp8HsdECdsUDY5iALYavYrmYXlZgAdEajxSWV6JmP6MVCyM87984ViQ1ZcwLEsTwgVO4y8Fbypes4AvXwL8HTG+TBe7jSSwxSorB3GdEby8RgXPwNO1PjY2OWzHAIfnV2JhvPrjtqMZ5uIp+t+S8GLoy2gSIYbm1VoVSazI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290299; c=relaxed/simple;
	bh=lNs8z1sji2VLsk/M0iQMuL9YA5/Gd9o7aLfXdIsPD9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CySH088QEiquVXq10/APTBujhXgf+bQ+zVWSoSmjRQpv8JPunjs3ZFO+LpyE339RpHCOIo2mhbDsCMlp6V8ZqCGmDNaIiDaZ+bE5Crj3hvmoZXD0/8qXN4+RRv8Wwjyi3QXOyNb3wd6xSqhImJZ/HguRi3sZUCZqRysyVeYP1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S8GljfXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524DCC4CEDD;
	Thu, 10 Apr 2025 13:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744290299;
	bh=lNs8z1sji2VLsk/M0iQMuL9YA5/Gd9o7aLfXdIsPD9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8GljfXtdwWJYnlorLwXSdaAt9h6R3FSse9nwXslXQaZHJLPhwsawsRQGy95+Y/yF
	 hwNhHQ2u0bbOtximSt7VpFeGAX8XpGWU8eY/aPYeLywItDrD8ZUcirH8kjURB2zX5J
	 L/XZvrD7FbLfv0hgMEBs35ItMysA5yy86syE8N0Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.23
Date: Thu, 10 Apr 2025 15:03:10 +0200
Message-ID: <2025041009-ragweed-component-7077@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025041009-elastic-engaged-6b85@gregkh>
References: <2025041009-elastic-engaged-6b85@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbfce9b4ae6b..71a1a399e1e1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -581,6 +581,8 @@ patternProperties:
     description: GlobalTop Technology, Inc.
   "^gmt,.*":
     description: Global Mixed-mode Technology, Inc.
+  "^gocontroll,.*":
+    description: GOcontroll Modular Embedded Electronics B.V.
   "^goldelico,.*":
     description: Golden Delicious Computers GmbH & Co. KG
   "^goodix,.*":
diff --git a/Makefile b/Makefile
index f380005d1600..6a2a60eb67a3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 22
+SUBLEVEL = 23
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 202397be76d8..d0040fb67c36 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -118,7 +118,7 @@ config ARM
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
-	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD)
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_CAN_USE_KEEP_IN_OVERLAY)
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index d60f6e83a9f7..14811b4f48ec 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -34,6 +34,12 @@
 #define NOCROSSREFS
 #endif
 
+#ifdef CONFIG_LD_CAN_USE_KEEP_IN_OVERLAY
+#define OVERLAY_KEEP(x)		KEEP(x)
+#else
+#define OVERLAY_KEEP(x)		x
+#endif
+
 /* Set start/end symbol names to the LMA for the section */
 #define ARM_LMA(sym, section)						\
 	sym##_start = LOADADDR(section);				\
@@ -125,13 +131,13 @@
 	__vectors_lma = .;						\
 	OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) {		\
 		.vectors {						\
-			*(.vectors)					\
+			OVERLAY_KEEP(*(.vectors))			\
 		}							\
 		.vectors.bhb.loop8 {					\
-			*(.vectors.bhb.loop8)				\
+			OVERLAY_KEEP(*(.vectors.bhb.loop8))		\
 		}							\
 		.vectors.bhb.bpiall {					\
-			*(.vectors.bhb.bpiall)				\
+			OVERLAY_KEEP(*(.vectors.bhb.bpiall))		\
 		}							\
 	}								\
 	ARM_LMA(__vectors, .vectors);					\
diff --git a/arch/arm64/kernel/compat_alignment.c b/arch/arm64/kernel/compat_alignment.c
index deff21bfa680..b68e1d328d4c 100644
--- a/arch/arm64/kernel/compat_alignment.c
+++ b/arch/arm64/kernel/compat_alignment.c
@@ -368,6 +368,8 @@ int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)
 		return 1;
 	}
 
+	if (!handler)
+		return 1;
 	type = handler(addr, instr, regs);
 
 	if (type == TYPE_ERROR || type == TYPE_FAULT)
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d9fce0fd475a..fe9f895138db 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -375,8 +375,8 @@ config CMDLINE_BOOTLOADER
 config CMDLINE_EXTEND
 	bool "Use built-in to extend bootloader kernel arguments"
 	help
-	  The command-line arguments provided during boot will be
-	  appended to the built-in command line. This is useful in
+	  The built-in command line will be appended to the command-
+	  line arguments provided during boot. This is useful in
 	  cases where the provided arguments are insufficient and
 	  you don't want to or cannot modify them.
 
diff --git a/arch/loongarch/include/asm/cache.h b/arch/loongarch/include/asm/cache.h
index 1b6d09617199..aa622c754414 100644
--- a/arch/loongarch/include/asm/cache.h
+++ b/arch/loongarch/include/asm/cache.h
@@ -8,6 +8,8 @@
 #define L1_CACHE_SHIFT		CONFIG_L1_CACHE_SHIFT
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
+#define ARCH_DMA_MINALIGN	(16)
+
 #define __read_mostly __section(".data..read_mostly")
 
 #endif /* _ASM_CACHE_H */
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 9c2ca785faa9..b2915fd53862 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -53,7 +53,7 @@ void spurious_interrupt(void);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask, int exclude_cpu);
 
-#define MAX_IO_PICS 2
+#define MAX_IO_PICS 8
 #define NR_IRQS	(64 + NR_VECTORS * (NR_CPUS + MAX_IO_PICS))
 
 struct acpi_vector_group {
diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
index f23adb15f418..fc8b64773794 100644
--- a/arch/loongarch/include/asm/stacktrace.h
+++ b/arch/loongarch/include/asm/stacktrace.h
@@ -8,6 +8,7 @@
 #include <asm/asm.h>
 #include <asm/ptrace.h>
 #include <asm/loongarch.h>
+#include <asm/unwind_hints.h>
 #include <linux/stringify.h>
 
 enum stack_type {
@@ -43,6 +44,7 @@ int get_stack_info(unsigned long stack, struct task_struct *task, struct stack_i
 static __always_inline void prepare_frametrace(struct pt_regs *regs)
 {
 	__asm__ __volatile__(
+		UNWIND_HINT_SAVE
 		/* Save $ra */
 		STORE_ONE_REG(1)
 		/* Use $ra to save PC */
@@ -80,6 +82,7 @@ static __always_inline void prepare_frametrace(struct pt_regs *regs)
 		STORE_ONE_REG(29)
 		STORE_ONE_REG(30)
 		STORE_ONE_REG(31)
+		UNWIND_HINT_RESTORE
 		: "=m" (regs->csr_era)
 		: "r" (regs->regs)
 		: "memory");
diff --git a/arch/loongarch/include/asm/unwind_hints.h b/arch/loongarch/include/asm/unwind_hints.h
index a01086ad9dde..2c68bc72736c 100644
--- a/arch/loongarch/include/asm/unwind_hints.h
+++ b/arch/loongarch/include/asm/unwind_hints.h
@@ -23,6 +23,14 @@
 	UNWIND_HINT sp_reg=ORC_REG_SP type=UNWIND_HINT_TYPE_CALL
 .endm
 
-#endif /* __ASSEMBLY__ */
+#else /* !__ASSEMBLY__ */
+
+#define UNWIND_HINT_SAVE \
+	UNWIND_HINT(UNWIND_HINT_TYPE_SAVE, 0, 0, 0)
+
+#define UNWIND_HINT_RESTORE \
+	UNWIND_HINT(UNWIND_HINT_TYPE_RESTORE, 0, 0, 0)
+
+#endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_LOONGARCH_UNWIND_HINTS_H */
diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index 2f1f5b08638f..27144de5c5fe 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -68,6 +68,8 @@ static int __init fdt_cpu_clk_init(void)
 		return -ENODEV;
 
 	clk = of_clk_get(np, 0);
+	of_node_put(np);
+
 	if (IS_ERR(clk))
 		return -ENODEV;
 
diff --git a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
index 445c452d72a7..7be5b4c0c900 100644
--- a/arch/loongarch/kernel/kgdb.c
+++ b/arch/loongarch/kernel/kgdb.c
@@ -8,6 +8,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/kdebug.h>
 #include <linux/kgdb.h>
+#include <linux/objtool.h>
 #include <linux/processor.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
@@ -224,13 +225,13 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 	regs->csr_era = pc;
 }
 
-void arch_kgdb_breakpoint(void)
+noinline void arch_kgdb_breakpoint(void)
 {
 	__asm__ __volatile__ (			\
 		".globl kgdb_breakinst\n\t"	\
-		"nop\n"				\
 		"kgdb_breakinst:\tbreak 2\n\t"); /* BRK_KDB = 2 */
 }
+STACK_FRAME_NON_STANDARD(arch_kgdb_breakpoint);
 
 /*
  * Calls linux_debug_hook before the kernel dies. If KGDB is enabled,
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index ea357a3edc09..fa1500d4aa3e 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -142,6 +142,8 @@ static void build_prologue(struct jit_ctx *ctx)
 	 */
 	if (seen_tail_call(ctx) && seen_call(ctx))
 		move_reg(ctx, TCC_SAVED, REG_TCC);
+	else
+		emit_insn(ctx, nop);
 
 	ctx->stack_size = stack_adjust;
 }
@@ -905,7 +907,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 		move_addr(ctx, t1, func_addr);
 		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
-		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
+
+		if (insn->src_reg != BPF_PSEUDO_CALL)
+			move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
+
 		break;
 
 	/* tail call */
@@ -930,7 +935,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	{
 		const u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
 
-		move_imm(ctx, dst, imm64, is32);
+		if (bpf_pseudo_func(insn))
+			move_addr(ctx, dst, imm64);
+		else
+			move_imm(ctx, dst, imm64, is32);
 		return 1;
 	}
 
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index 68586338ecf8..f9c569f53949 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -27,6 +27,11 @@ struct jit_data {
 	struct jit_ctx ctx;
 };
 
+static inline void emit_nop(union loongarch_instruction *insn)
+{
+	insn->word = INSN_NOP;
+}
+
 #define emit_insn(ctx, func, ...)						\
 do {										\
 	if (ctx->image != NULL) {						\
diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index 77306be62e9e..129355f87f80 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -78,4 +78,4 @@ CONFIG_DEBUG_VM_PGTABLE=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_BDI_SWITCH=y
 CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_GENERIC_PTDUMP=y
+CONFIG_PTDUMP_DEBUGFS=y
diff --git a/arch/powerpc/crypto/Makefile b/arch/powerpc/crypto/Makefile
index 59808592f0a1..1e52b02d8943 100644
--- a/arch/powerpc/crypto/Makefile
+++ b/arch/powerpc/crypto/Makefile
@@ -56,3 +56,4 @@ $(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S: $(obj)/%.S: $(src)/%.pl FORCE
 OBJECT_FILES_NON_STANDARD_aesp10-ppc.o := y
 OBJECT_FILES_NON_STANDARD_ghashp10-ppc.o := y
 OBJECT_FILES_NON_STANDARD_aesp8-ppc.o := y
+OBJECT_FILES_NON_STANDARD_ghashp8-ppc.o := y
diff --git a/arch/powerpc/kexec/relocate_32.S b/arch/powerpc/kexec/relocate_32.S
index 104c9911f406..dd86e338307d 100644
--- a/arch/powerpc/kexec/relocate_32.S
+++ b/arch/powerpc/kexec/relocate_32.S
@@ -348,16 +348,13 @@ write_utlb:
 	rlwinm	r10, r24, 0, 22, 27
 
 	cmpwi	r10, PPC47x_TLB0_4K
-	bne	0f
 	li	r10, 0x1000			/* r10 = 4k */
-	ANNOTATE_INTRA_FUNCTION_CALL
-	bl	1f
+	beq	0f
 
-0:
 	/* Defaults to 256M */
 	lis	r10, 0x1000
 
-	bcl	20,31,$+4
+0:	bcl	20,31,$+4
 1:	mflr	r4
 	addi	r4, r4, (2f-1b)			/* virtual address  of 2f */
 
diff --git a/arch/powerpc/platforms/cell/spufs/gang.c b/arch/powerpc/platforms/cell/spufs/gang.c
index 827d338deaf4..2c2999de6bfa 100644
--- a/arch/powerpc/platforms/cell/spufs/gang.c
+++ b/arch/powerpc/platforms/cell/spufs/gang.c
@@ -25,6 +25,7 @@ struct spu_gang *alloc_spu_gang(void)
 	mutex_init(&gang->aff_mutex);
 	INIT_LIST_HEAD(&gang->list);
 	INIT_LIST_HEAD(&gang->aff_list_head);
+	gang->alive = 1;
 
 out:
 	return gang;
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 70236d1df3d3..9f9e4b871627 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -192,13 +192,32 @@ static int spufs_fill_dir(struct dentry *dir,
 			return -ENOMEM;
 		ret = spufs_new_file(dir->d_sb, dentry, files->ops,
 					files->mode & mode, files->size, ctx);
-		if (ret)
+		if (ret) {
+			dput(dentry);
 			return ret;
+		}
 		files++;
 	}
 	return 0;
 }
 
+static void unuse_gang(struct dentry *dir)
+{
+	struct inode *inode = dir->d_inode;
+	struct spu_gang *gang = SPUFS_I(inode)->i_gang;
+
+	if (gang) {
+		bool dead;
+
+		inode_lock(inode); // exclusion with spufs_create_context()
+		dead = !--gang->alive;
+		inode_unlock(inode);
+
+		if (dead)
+			simple_recursive_removal(dir, NULL);
+	}
+}
+
 static int spufs_dir_close(struct inode *inode, struct file *file)
 {
 	struct inode *parent;
@@ -213,6 +232,7 @@ static int spufs_dir_close(struct inode *inode, struct file *file)
 	inode_unlock(parent);
 	WARN_ON(ret);
 
+	unuse_gang(dir->d_parent);
 	return dcache_dir_close(inode, file);
 }
 
@@ -405,7 +425,7 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 {
 	int ret;
 	int affinity;
-	struct spu_gang *gang;
+	struct spu_gang *gang = SPUFS_I(inode)->i_gang;
 	struct spu_context *neighbor;
 	struct path path = {.mnt = mnt, .dentry = dentry};
 
@@ -420,11 +440,15 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 	if ((flags & SPU_CREATE_ISOLATE) && !isolated_loader)
 		return -ENODEV;
 
-	gang = NULL;
+	if (gang) {
+		if (!gang->alive)
+			return -ENOENT;
+		gang->alive++;
+	}
+
 	neighbor = NULL;
 	affinity = flags & (SPU_CREATE_AFFINITY_MEM | SPU_CREATE_AFFINITY_SPU);
 	if (affinity) {
-		gang = SPUFS_I(inode)->i_gang;
 		if (!gang)
 			return -EINVAL;
 		mutex_lock(&gang->aff_mutex);
@@ -436,8 +460,11 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 	}
 
 	ret = spufs_mkdir(inode, dentry, flags, mode & 0777);
-	if (ret)
+	if (ret) {
+		if (neighbor)
+			put_spu_context(neighbor);
 		goto out_aff_unlock;
+	}
 
 	if (affinity) {
 		spufs_set_affinity(flags, SPUFS_I(d_inode(dentry))->i_ctx,
@@ -453,6 +480,8 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 out_aff_unlock:
 	if (affinity)
 		mutex_unlock(&gang->aff_mutex);
+	if (ret && gang)
+		gang->alive--; // can't reach 0
 	return ret;
 }
 
@@ -482,6 +511,7 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode->i_fop = &simple_dir_operations;
 
 	d_instantiate(dentry, inode);
+	dget(dentry);
 	inc_nlink(dir);
 	inc_nlink(d_inode(dentry));
 	return ret;
@@ -492,6 +522,21 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return ret;
 }
 
+static int spufs_gang_close(struct inode *inode, struct file *file)
+{
+	unuse_gang(file->f_path.dentry);
+	return dcache_dir_close(inode, file);
+}
+
+static const struct file_operations spufs_gang_fops = {
+	.open		= dcache_dir_open,
+	.release	= spufs_gang_close,
+	.llseek		= dcache_dir_lseek,
+	.read		= generic_read_dir,
+	.iterate_shared	= dcache_readdir,
+	.fsync		= noop_fsync,
+};
+
 static int spufs_gang_open(const struct path *path)
 {
 	int ret;
@@ -511,7 +556,7 @@ static int spufs_gang_open(const struct path *path)
 		return PTR_ERR(filp);
 	}
 
-	filp->f_op = &simple_dir_operations;
+	filp->f_op = &spufs_gang_fops;
 	fd_install(ret, filp);
 	return ret;
 }
@@ -526,10 +571,8 @@ static int spufs_create_gang(struct inode *inode,
 	ret = spufs_mkgang(inode, dentry, mode & 0777);
 	if (!ret) {
 		ret = spufs_gang_open(&path);
-		if (ret < 0) {
-			int err = simple_rmdir(inode, dentry);
-			WARN_ON(err);
-		}
+		if (ret < 0)
+			unuse_gang(dentry);
 	}
 	return ret;
 }
diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index 84958487f696..d33787c57c39 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -151,6 +151,8 @@ struct spu_gang {
 	int aff_flags;
 	struct spu *aff_ref_spu;
 	atomic_t aff_sched_count;
+
+	int alive;
 };
 
 /* Flag bits for spu_gang aff_flags */
diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
index f0da9d7b39c3..bc6c77ba837d 100644
--- a/arch/riscv/errata/Makefile
+++ b/arch/riscv/errata/Makefile
@@ -1,5 +1,9 @@
 ifdef CONFIG_RELOCATABLE
-KBUILD_CFLAGS += -fno-pie
+# We can't use PIC/PIE when handling early-boot errata parsing, as the kernel
+# doesn't have a GOT setup at that point.  So instead just use medany: it's
+# usually position-independent, so it should be good enough for the errata
+# handling.
+KBUILD_CFLAGS += -fno-pie -mcmodel=medany
 endif
 
 ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 2cddd79ff21b..f253c8dae878 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -92,7 +92,7 @@ struct dyn_arch_ftrace {
 #define make_call_t0(caller, callee, call)				\
 do {									\
 	unsigned int offset =						\
-		(unsigned long) callee - (unsigned long) caller;	\
+		(unsigned long) (callee) - (unsigned long) (caller);	\
 	call[0] = to_auipc_t0(offset);					\
 	call[1] = to_jalr_t0(offset);					\
 } while (0)
@@ -108,7 +108,7 @@ do {									\
 #define make_call_ra(caller, callee, call)				\
 do {									\
 	unsigned int offset =						\
-		(unsigned long) callee - (unsigned long) caller;	\
+		(unsigned long) (callee) - (unsigned long) (caller);	\
 	call[0] = to_auipc_ra(offset);					\
 	call[1] = to_jalr_ra(offset);					\
 } while (0)
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 3c37661801f9..e783a72d051f 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -468,6 +468,9 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		case R_RISCV_ALIGN:
 		case R_RISCV_RELAX:
 			break;
+		case R_RISCV_64:
+			*(u64 *)loc = val;
+			break;
 		default:
 			pr_err("Unknown rela relocation: %d\n", r_type);
 			return -ENOEXEC;
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 2707a51b082c..78ac3216a54d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -666,6 +666,7 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 		.type = etype,
 		.size = sizeof(struct perf_event_attr),
 		.pinned = true,
+		.disabled = true,
 		/*
 		 * It should never reach here if the platform doesn't support the sscofpmf
 		 * extension as mode filtering won't work without it.
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index b4a78a4b35cf..375dd96bb4a0 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -148,22 +148,25 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
 static pte_t get_clear_contig(struct mm_struct *mm,
 			      unsigned long addr,
 			      pte_t *ptep,
-			      unsigned long pte_num)
+			      unsigned long ncontig)
 {
-	pte_t orig_pte = ptep_get(ptep);
-	unsigned long i;
-
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++) {
-		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
-
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
+	pte_t pte, tmp_pte;
+	bool present;
+
+	pte = ptep_get_and_clear(mm, addr, ptep);
+	present = pte_present(pte);
+	while (--ncontig) {
+		ptep++;
+		addr += PAGE_SIZE;
+		tmp_pte = ptep_get_and_clear(mm, addr, ptep);
+		if (present) {
+			if (pte_dirty(tmp_pte))
+				pte = pte_mkdirty(pte);
+			if (pte_young(tmp_pte))
+				pte = pte_mkyoung(pte);
+		}
 	}
-
-	return orig_pte;
+	return pte;
 }
 
 static pte_t get_clear_contig_flush(struct mm_struct *mm,
@@ -212,6 +215,26 @@ static void clear_flush(struct mm_struct *mm,
 	flush_tlb_range(&vma, saddr, addr);
 }
 
+static int num_contig_ptes_from_size(unsigned long sz, size_t *pgsize)
+{
+	unsigned long hugepage_shift;
+
+	if (sz >= PGDIR_SIZE)
+		hugepage_shift = PGDIR_SHIFT;
+	else if (sz >= P4D_SIZE)
+		hugepage_shift = P4D_SHIFT;
+	else if (sz >= PUD_SIZE)
+		hugepage_shift = PUD_SHIFT;
+	else if (sz >= PMD_SIZE)
+		hugepage_shift = PMD_SHIFT;
+	else
+		hugepage_shift = PAGE_SHIFT;
+
+	*pgsize = 1 << hugepage_shift;
+
+	return sz >> hugepage_shift;
+}
+
 /*
  * When dealing with NAPOT mappings, the privileged specification indicates that
  * "if an update needs to be made, the OS generally should first mark all of the
@@ -226,22 +249,10 @@ void set_huge_pte_at(struct mm_struct *mm,
 		     pte_t pte,
 		     unsigned long sz)
 {
-	unsigned long hugepage_shift, pgsize;
+	size_t pgsize;
 	int i, pte_num;
 
-	if (sz >= PGDIR_SIZE)
-		hugepage_shift = PGDIR_SHIFT;
-	else if (sz >= P4D_SIZE)
-		hugepage_shift = P4D_SHIFT;
-	else if (sz >= PUD_SIZE)
-		hugepage_shift = PUD_SHIFT;
-	else if (sz >= PMD_SIZE)
-		hugepage_shift = PMD_SHIFT;
-	else
-		hugepage_shift = PAGE_SHIFT;
-
-	pte_num = sz >> hugepage_shift;
-	pgsize = 1 << hugepage_shift;
+	pte_num = num_contig_ptes_from_size(sz, &pgsize);
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
@@ -295,13 +306,14 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr,
 			      pte_t *ptep, unsigned long sz)
 {
+	size_t pgsize;
 	pte_t orig_pte = ptep_get(ptep);
 	int pte_num;
 
 	if (!pte_napot(orig_pte))
 		return ptep_get_and_clear(mm, addr, ptep);
 
-	pte_num = napot_pte_num(napot_cont_order(orig_pte));
+	pte_num = num_contig_ptes_from_size(sz, &pgsize);
 
 	return get_clear_contig(mm, addr, ptep, pte_num);
 }
@@ -351,6 +363,7 @@ void huge_pte_clear(struct mm_struct *mm,
 		    pte_t *ptep,
 		    unsigned long sz)
 {
+	size_t pgsize;
 	pte_t pte = ptep_get(ptep);
 	int i, pte_num;
 
@@ -359,8 +372,9 @@ void huge_pte_clear(struct mm_struct *mm,
 		return;
 	}
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
+	pte_num = num_contig_ptes_from_size(sz, &pgsize);
+
+	for (i = 0; i < pte_num; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 }
 
diff --git a/arch/riscv/purgatory/entry.S b/arch/riscv/purgatory/entry.S
index 0e6ca6d5ae4b..c5db2f072c34 100644
--- a/arch/riscv/purgatory/entry.S
+++ b/arch/riscv/purgatory/entry.S
@@ -12,6 +12,7 @@
 
 .text
 
+.align	2
 SYM_CODE_START(purgatory_start)
 
 	lla	sp, .Lstack
diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index fc9933a743d6..251e0372ccbd 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -34,8 +34,6 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
 #define ioremap_wc(addr, size)  \
 	ioremap_prot((addr), (size), pgprot_val(pgprot_writecombine(PAGE_KERNEL)))
-#define ioremap_wt(addr, size)  \
-	ioremap_prot((addr), (size), pgprot_val(pgprot_writethrough(PAGE_KERNEL)))
 
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 0ffbaf741955..5ee73f245a0c 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1365,9 +1365,6 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr);
 #define pgprot_writecombine	pgprot_writecombine
 pgprot_t pgprot_writecombine(pgprot_t prot);
 
-#define pgprot_writethrough	pgprot_writethrough
-pgprot_t pgprot_writethrough(pgprot_t prot);
-
 #define PFN_PTE_SHIFT		PAGE_SHIFT
 
 /*
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 594da4cba707..a7de838f8031 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -501,7 +501,7 @@ SYM_CODE_START(mcck_int_handler)
 	clgrjl	%r9,%r14, 4f
 	larl	%r14,.Lsie_leave
 	clgrjhe	%r9,%r14, 4f
-	lg	%r10,__LC_PCPU
+	lg	%r10,__LC_PCPU(%r13)
 	oi	__PCPU_FLAGS+7(%r10), _CIF_MCCK_GUEST
 4:	BPENTER	__SF_SIE_FLAGS(%r15),_TIF_ISOLATE_BP_GUEST
 	SIEEXIT __SF_SIE_CONTROL(%r15),%r13
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 2c944bafb030..b03c665d7242 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -34,16 +34,6 @@ pgprot_t pgprot_writecombine(pgprot_t prot)
 }
 EXPORT_SYMBOL_GPL(pgprot_writecombine);
 
-pgprot_t pgprot_writethrough(pgprot_t prot)
-{
-	/*
-	 * mio_wb_bit_mask may be set on a different CPU, but it is only set
-	 * once at init and only read afterwards.
-	 */
-	return __pgprot(pgprot_val(prot) & ~mio_wb_bit_mask);
-}
-EXPORT_SYMBOL_GPL(pgprot_writethrough);
-
 static inline void ptep_ipte_local(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, int nodat)
 {
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 9a039d6f1f74..77a8593f219a 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -218,7 +218,6 @@ extern int os_protect_memory(void *addr, unsigned long len,
 extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
-extern int os_mincore(void *addr, unsigned long len);
 
 /* execvp.c */
 extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index f8567b933ffa..4df1cd0d2017 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -17,7 +17,7 @@ extra-y := vmlinux.lds
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
+	um_arch.o umid.o kmsg_dump.o capflags.o skas/
 obj-y += load_file.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
diff --git a/arch/um/kernel/maccess.c b/arch/um/kernel/maccess.c
deleted file mode 100644
index 8ccd56813f68..000000000000
--- a/arch/um/kernel/maccess.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013 Richard Weinberger <richrd@nod.at>
- */
-
-#include <linux/uaccess.h>
-#include <linux/kernel.h>
-#include <os.h>
-
-bool copy_from_kernel_nofault_allowed(const void *src, size_t size)
-{
-	void *psrc = (void *)rounddown((unsigned long)src, PAGE_SIZE);
-
-	if ((unsigned long)src < PAGE_SIZE || size <= 0)
-		return false;
-	if (os_mincore(psrc, size + src - psrc) <= 0)
-		return false;
-	return true;
-}
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index e52dd37ddadc..2686120ab232 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -223,57 +223,6 @@ int __init can_drop_memory(void)
 	return ok;
 }
 
-static int os_page_mincore(void *addr)
-{
-	char vec[2];
-	int ret;
-
-	ret = mincore(addr, UM_KERN_PAGE_SIZE, vec);
-	if (ret < 0) {
-		if (errno == ENOMEM || errno == EINVAL)
-			return 0;
-		else
-			return -errno;
-	}
-
-	return vec[0] & 1;
-}
-
-int os_mincore(void *addr, unsigned long len)
-{
-	char *vec;
-	int ret, i;
-
-	if (len <= UM_KERN_PAGE_SIZE)
-		return os_page_mincore(addr);
-
-	vec = calloc(1, (len + UM_KERN_PAGE_SIZE - 1) / UM_KERN_PAGE_SIZE);
-	if (!vec)
-		return -ENOMEM;
-
-	ret = mincore(addr, UM_KERN_PAGE_SIZE, vec);
-	if (ret < 0) {
-		if (errno == ENOMEM || errno == EINVAL)
-			ret = 0;
-		else
-			ret = -errno;
-
-		goto out;
-	}
-
-	for (i = 0; i < ((len + UM_KERN_PAGE_SIZE - 1) / UM_KERN_PAGE_SIZE); i++) {
-		if (!(vec[i] & 1)) {
-			ret = 0;
-			goto out;
-		}
-	}
-
-	ret = 1;
-out:
-	free(vec);
-	return ret;
-}
-
 void init_new_thread_signals(void)
 {
 	set_handler(SIGSEGV);
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6f8e9af827e0..db38d2b9b788 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -226,7 +226,7 @@ config X86
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select HAVE_EISA
+	select HAVE_EISA			if X86_32
 	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
@@ -894,6 +894,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	depends on EFI_STUB
+	depends on PARAVIRT
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..42e6a40876ea 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -368,7 +368,7 @@ config X86_HAVE_PAE
 
 config X86_CMPXCHG64
 	def_bool y
-	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
+	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7 || MGEODEGX1 || MGEODE_LX
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index a46b1397ad01..c86cbd9cbba3 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -7,12 +7,13 @@ core-y += arch/x86/crypto/
 # GCC versions < 11. See:
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652
 #
-ifeq ($(CONFIG_CC_IS_CLANG),y)
-KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
-KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
+ifeq ($(call gcc-min-version, 110000)$(CONFIG_CC_IS_CLANG),y)
+KBUILD_CFLAGS +=  -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
 endif
 
+KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
+
 ifeq ($(CONFIG_X86_32),y)
 START := 0x8048000
 
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 2f85ed005c42..b8aeb3ac7d28 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -14,6 +14,7 @@
 #include <asm/ia32.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/traps.h>
@@ -359,7 +360,7 @@ static int handle_halt(struct ve_info *ve)
 	return ve_instr_len(ve);
 }
 
-void __cpuidle tdx_safe_halt(void)
+void __cpuidle tdx_halt(void)
 {
 	const bool irq_disabled = false;
 
@@ -370,6 +371,16 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static void __cpuidle tdx_safe_halt(void)
+{
+	tdx_halt();
+	/*
+	 * "__cpuidle" section doesn't support instrumentation, so stick
+	 * with raw_* variant that avoids tracing hooks.
+	 */
+	raw_local_irq_enable();
+}
+
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_module_args args = {
@@ -1056,6 +1067,19 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
 	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
 
+	/*
+	 * Avoid "sti;hlt" execution in TDX guests as HLT induces a #VE that
+	 * will enable interrupts before HLT TDCALL invocation if executed
+	 * in STI-shadow, possibly resulting in missed wakeup events.
+	 *
+	 * Modify all possible HLT execution paths to use TDX specific routines
+	 * that directly execute TDCALL and toggle the interrupt state as
+	 * needed after TDCALL completion. This also reduces HLT related #VEs
+	 * in addition to having a reliable halt logic execution.
+	 */
+	pv_ops.irq.safe_halt = tdx_safe_halt;
+	pv_ops.irq.halt = tdx_halt;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index ea81770629ee..626a81c6015b 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -70,6 +70,8 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
 	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
+	/* We just clobbered the return address - use the IRET frame for unwinding: */
+	UNWIND_HINT_IRET_REGS offset=3*8
 	.else
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 94941c5a10ac..51efd2da4d7f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -142,7 +142,7 @@ static __always_inline int syscall_32_enter(struct pt_regs *regs)
 #ifdef CONFIG_IA32_EMULATION
 bool __ia32_enabled __ro_after_init = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
 
-static int ia32_emulation_override_cmdline(char *arg)
+static int __init ia32_emulation_override_cmdline(char *arg)
 {
 	return kstrtobool(arg, &__ia32_enabled);
 }
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3a68b3e0b7a3..f86e47afd560 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2779,28 +2779,33 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 
 DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
 
-static void intel_pmu_read_topdown_event(struct perf_event *event)
+static void intel_pmu_read_event(struct perf_event *event)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	if (event->hw.flags & (PERF_X86_EVENT_AUTO_RELOAD | PERF_X86_EVENT_TOPDOWN)) {
+		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+		bool pmu_enabled = cpuc->enabled;
 
-	/* Only need to call update_topdown_event() once for group read. */
-	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
-	    !is_slots_event(event))
-		return;
+		/* Only need to call update_topdown_event() once for group read. */
+		if (is_metric_event(event) && (cpuc->txn_flags & PERF_PMU_TXN_READ))
+			return;
 
-	perf_pmu_disable(event->pmu);
-	static_call(intel_pmu_update_topdown_event)(event);
-	perf_pmu_enable(event->pmu);
-}
+		cpuc->enabled = 0;
+		if (pmu_enabled)
+			intel_pmu_disable_all();
 
-static void intel_pmu_read_event(struct perf_event *event)
-{
-	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
-		intel_pmu_auto_reload_read(event);
-	else if (is_topdown_count(event))
-		intel_pmu_read_topdown_event(event);
-	else
-		x86_perf_event_update(event);
+		if (is_topdown_event(event))
+			static_call(intel_pmu_update_topdown_event)(event);
+		else
+			intel_pmu_drain_pebs_buffer();
+
+		cpuc->enabled = pmu_enabled;
+		if (pmu_enabled)
+			intel_pmu_enable_all(0);
+
+		return;
+	}
+
+	x86_perf_event_update(event);
 }
 
 static void intel_pmu_enable_fixed(struct perf_event *event)
@@ -3067,7 +3072,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		handled++;
 		x86_pmu_handle_guest_pebs(regs, &data);
-		x86_pmu.drain_pebs(regs, &data);
+		static_call(x86_pmu_drain_pebs)(regs, &data);
 		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c07ca43e67e7..1617aa3efd68 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -932,11 +932,11 @@ int intel_pmu_drain_bts_buffer(void)
 	return 1;
 }
 
-static inline void intel_pmu_drain_pebs_buffer(void)
+void intel_pmu_drain_pebs_buffer(void)
 {
 	struct perf_sample_data data;
 
-	x86_pmu.drain_pebs(NULL, &data);
+	static_call(x86_pmu_drain_pebs)(NULL, &data);
 }
 
 /*
@@ -2079,15 +2079,6 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
 	return NULL;
 }
 
-void intel_pmu_auto_reload_read(struct perf_event *event)
-{
-	WARN_ON(!(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD));
-
-	perf_pmu_disable(event->pmu);
-	intel_pmu_drain_pebs_buffer();
-	perf_pmu_enable(event->pmu);
-}
-
 /*
  * Special variant of intel_pmu_save_and_restart() for auto-reload.
  */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ac1182141bf6..8c616656391e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1092,6 +1092,7 @@ extern struct x86_pmu x86_pmu __read_mostly;
 
 DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
 DECLARE_STATIC_CALL(x86_pmu_update,     *x86_pmu.update);
+DECLARE_STATIC_CALL(x86_pmu_drain_pebs,	*x86_pmu.drain_pebs);
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
@@ -1626,7 +1627,7 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
-void intel_pmu_auto_reload_read(struct perf_event *event);
+void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 04775346369c..d04ccd4b3b4a 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -30,6 +30,7 @@ void __init hv_vtl_init_platform(void)
 	x86_platform.realmode_init = x86_init_noop;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
+	x86_init.resources.probe_roms = x86_init_noop;
 
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_mptable = x86_init_noop;
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 60fc3ed72830..4065f5ef3ae0 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -339,7 +339,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	vmsa->sev_features = sev_status >> 2;
 
 	ret = snp_set_vmsa(vmsa, true);
-	if (!ret) {
+	if (ret) {
 		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
 		free_page((u64)vmsa);
 		return ret;
@@ -465,7 +465,6 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 			   enum hv_mem_host_visibility visibility)
 {
 	struct hv_gpa_range_for_visibility *input;
-	u16 pages_processed;
 	u64 hv_status;
 	unsigned long flags;
 
@@ -494,7 +493,7 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
 	hv_status = hv_do_rep_hypercall(
 			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
-			0, input, &pages_processed);
+			0, input, NULL);
 	local_irq_restore(flags);
 
 	if (hv_result_success(hv_status))
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eba178996d84..b5b633294061 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -58,7 +58,7 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
-void tdx_safe_halt(void);
+void tdx_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
@@ -69,7 +69,7 @@ u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 #else
 
 static inline void tdx_early_init(void) { };
-static inline void tdx_safe_halt(void) { };
+static inline void tdx_halt(void) { };
 
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 02fc2aa06e9e..3da645139748 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -242,7 +242,7 @@ void flush_tlb_multi(const struct cpumask *cpumask,
 	flush_tlb_mm_range((vma)->vm_mm, start, end,			\
 			   ((vma)->vm_flags & VM_HUGETLB)		\
 				? huge_page_shift(hstate_vma(vma))	\
-				: PAGE_SHIFT, false)
+				: PAGE_SHIFT, true)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..2235a7477436 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -300,13 +300,12 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	copy_user  = is_copy_from_user(regs);
 	instrumentation_end();
 
-	switch (fixup_type) {
-	case EX_TYPE_UACCESS:
-		if (!copy_user)
-			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
-		fallthrough;
+	if (copy_user) {
+		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
+		return IN_KERNEL_RECOV;
+	}
 
+	switch (fixup_type) {
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 07fc145f3531..5cd735728fa0 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -600,7 +600,7 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
 	unsigned long p_addr = (unsigned long)&mc->hdr.data_code;
 
 	if (!verify_sha256_digest(mc->hdr.patch_id, *cur_rev, (const u8 *)p_addr, psize))
-		return -1;
+		return false;
 
 	native_wrmsrl(MSR_AMD64_PATCH_LOADER, p_addr);
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7163b764c62..2d48db66fca8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -148,7 +148,8 @@ static int closid_alloc(void)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
+	    is_llc_occupancy_enabled()) {
 		cleanest_closid = resctrl_find_cleanest_closid();
 		if (cleanest_closid < 0)
 			return cleanest_closid;
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 22b65a5f5ec6..7f8d1e11dbee 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -150,13 +150,15 @@ int __init sgx_drv_init(void)
 	u64 xfrm_mask;
 	int ret;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
+	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC)) {
+		pr_info("SGX disabled: SGX launch control CPU feature is not available, /dev/sgx_enclave disabled.\n");
 		return -ENODEV;
+	}
 
 	cpuid_count(SGX_CPUID, 0, &eax, &ebx, &ecx, &edx);
 
 	if (!(eax & 1))  {
-		pr_err("SGX disabled: SGX1 instruction support not available.\n");
+		pr_info("SGX disabled: SGX1 instruction support not available, /dev/sgx_enclave disabled.\n");
 		return -ENODEV;
 	}
 
@@ -173,8 +175,10 @@ int __init sgx_drv_init(void)
 	}
 
 	ret = misc_register(&sgx_dev_enclave);
-	if (ret)
+	if (ret) {
+		pr_info("SGX disabled: Unable to register the /dev/sgx_enclave driver (%d).\n", ret);
 		return ret;
+	}
 
 	return 0;
 }
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index a7d562697e50..b2b118a8c09b 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,6 +195,7 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
+	stack = stack ?: get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -213,9 +214,7 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	 * - hardirq stack
 	 * - entry stack
 	 */
-	for (stack = stack ?: get_stack_pointer(task, regs);
-	     stack;
-	     stack = stack_info.next_sp) {
+	for (; stack; stack = stack_info.next_sp) {
 		const char *stack_name;
 
 		stack = PTR_ALIGN(stack, sizeof(long));
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1209c7aebb21..dcac3c058fb7 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -220,7 +220,7 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	struct fpstate *fpstate;
 	unsigned int size;
 
-	size = fpu_user_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
+	size = fpu_kernel_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
 	fpstate = vzalloc(size);
 	if (!fpstate)
 		return false;
@@ -232,8 +232,8 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	fpstate->is_guest	= true;
 
 	gfpu->fpstate		= fpstate;
-	gfpu->xfeatures		= fpu_user_cfg.default_features;
-	gfpu->perm		= fpu_user_cfg.default_features;
+	gfpu->xfeatures		= fpu_kernel_cfg.default_features;
+	gfpu->perm		= fpu_kernel_cfg.default_features;
 
 	/*
 	 * KVM sets the FP+SSE bits in the XSAVE header when copying FPU state
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 15507e739c25..c7ce3655b707 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -92,7 +92,12 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
  */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	memcpy(dst, src, arch_task_struct_size);
+	/* init_task is not dynamically sized (incomplete FPU state) */
+	if (unlikely(src == &init_task))
+		memcpy_and_pad(dst, arch_task_struct_size, src, sizeof(init_task), 0);
+	else
+		memcpy(dst, src, arch_task_struct_size);
+
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
@@ -933,7 +938,7 @@ void __init select_idle_routine(void)
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		static_call_update(x86_idle, tdx_safe_halt);
+		static_call_update(x86_idle, tdx_halt);
 	} else {
 		static_call_update(x86_idle, default_idle);
 	}
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2dbadf347b5f..5e3e036e6e53 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -379,6 +379,21 @@ __visible void __noreturn handle_stack_overflow(struct pt_regs *regs,
 }
 #endif
 
+/*
+ * Prevent the compiler and/or objtool from marking the !CONFIG_X86_ESPFIX64
+ * version of exc_double_fault() as noreturn.  Otherwise the noreturn mismatch
+ * between configs triggers objtool warnings.
+ *
+ * This is a temporary hack until we have compiler or plugin support for
+ * annotating noreturns.
+ */
+#ifdef CONFIG_X86_ESPFIX64
+#define always_true() true
+#else
+bool always_true(void);
+bool __weak always_true(void) { return true; }
+#endif
+
 /*
  * Runs on an IST stack for x86_64 and on a special task stack for x86_32.
  *
@@ -514,7 +529,8 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 
 	pr_emerg("PANIC: double fault, error_code: 0x%lx\n", error_code);
 	die("double fault", regs, error_code);
-	panic("Machine halted.");
+	if (always_true())
+		panic("Machine halted.");
 	instrumentation_end();
 }
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index dfe6847fd99e..310d8cdf7ca3 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -956,7 +956,7 @@ static unsigned long long cyc2ns_suspend;
 
 void tsc_save_sched_clock_state(void)
 {
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -976,7 +976,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	local_irq_save(flags);
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5a952c5ea66b..9194695662b2 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -357,19 +357,23 @@ void *arch_uprobe_trampoline(unsigned long *psize)
 	return &insn;
 }
 
-static unsigned long trampoline_check_ip(void)
+static unsigned long trampoline_check_ip(unsigned long tramp)
 {
-	unsigned long tramp = uprobe_get_trampoline_vaddr();
-
 	return tramp + (uretprobe_syscall_check - uretprobe_trampoline_entry);
 }
 
 SYSCALL_DEFINE0(uretprobe)
 {
 	struct pt_regs *regs = task_pt_regs(current);
-	unsigned long err, ip, sp, r11_cx_ax[3];
+	unsigned long err, ip, sp, r11_cx_ax[3], tramp;
+
+	/* If there's no trampoline, we are called from wrong place. */
+	tramp = uprobe_get_trampoline_vaddr();
+	if (unlikely(tramp == UPROBE_NO_TRAMPOLINE_VADDR))
+		goto sigill;
 
-	if (regs->ip != trampoline_check_ip())
+	/* Make sure the ip matches the only allowed sys_uretprobe caller. */
+	if (unlikely(regs->ip != trampoline_check_ip(tramp)))
 		goto sigill;
 
 	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3ec56bf76ef1..6154cb450b44 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3957,16 +3957,12 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 
 	/*
 	 * The target vCPU is valid, so the vCPU will be kicked unless the
-	 * request is for CREATE_ON_INIT. For any errors at this stage, the
-	 * kick will place the vCPU in an non-runnable state.
+	 * request is for CREATE_ON_INIT.
 	 */
 	kick = true;
 
 	mutex_lock(&target_svm->sev_es.snp_vmsa_mutex);
 
-	target_svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
-	target_svm->sev_es.snp_ap_waiting_for_reset = true;
-
 	/* Interrupt injection mode shouldn't change for AP creation */
 	if (request < SVM_VMGEXIT_AP_DESTROY) {
 		u64 sev_features;
@@ -4012,20 +4008,23 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 		target_svm->sev_es.snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
 		break;
 	case SVM_VMGEXIT_AP_DESTROY:
+		target_svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
 		break;
 	default:
 		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
 			    request);
 		ret = -EINVAL;
-		break;
+		goto out;
 	}
 
-out:
+	target_svm->sev_es.snp_ap_waiting_for_reset = true;
+
 	if (kick) {
 		kvm_make_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, target_vcpu);
 		kvm_vcpu_kick(target_vcpu);
 	}
 
+out:
 	mutex_unlock(&target_svm->sev_es.snp_vmsa_mutex);
 
 	return ret;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8794c0a8a2e4..45337a3fc03c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4590,6 +4590,11 @@ static bool kvm_is_vm_type_supported(unsigned long type)
 	return type < 32 && (kvm_caps.supported_vm_types & BIT(type));
 }
 
+static inline u32 kvm_sync_valid_fields(struct kvm *kvm)
+{
+	return kvm && kvm->arch.has_protected_state ? 0 : KVM_SYNC_X86_VALID_FIELDS;
+}
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r = 0;
@@ -4698,7 +4703,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 #endif
 	case KVM_CAP_SYNC_REGS:
-		r = KVM_SYNC_X86_VALID_FIELDS;
+		r = kvm_sync_valid_fields(kvm);
 		break;
 	case KVM_CAP_ADJUST_CLOCK:
 		r = KVM_CLOCK_VALID_FLAGS;
@@ -11470,6 +11475,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 {
 	struct kvm_queued_exception *ex = &vcpu->arch.exception;
 	struct kvm_run *kvm_run = vcpu->run;
+	u32 sync_valid_fields;
 	int r;
 
 	r = kvm_mmu_post_init_vm(vcpu->kvm);
@@ -11515,8 +11521,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
-	if ((kvm_run->kvm_valid_regs & ~KVM_SYNC_X86_VALID_FIELDS) ||
-	    (kvm_run->kvm_dirty_regs & ~KVM_SYNC_X86_VALID_FIELDS)) {
+	sync_valid_fields = kvm_sync_valid_fields(vcpu->kvm);
+	if ((kvm_run->kvm_valid_regs & ~sync_valid_fields) ||
+	    (kvm_run->kvm_dirty_regs & ~sync_valid_fields)) {
 		r = -EINVAL;
 		goto out;
 	}
@@ -11574,7 +11581,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 out:
 	kvm_put_guest_fpu(vcpu);
-	if (kvm_run->kvm_valid_regs)
+	if (kvm_run->kvm_valid_regs && likely(!vcpu->arch.guest_state_protected))
 		store_regs(vcpu);
 	post_kvm_run_save(vcpu);
 	kvm_vcpu_srcu_read_unlock(vcpu);
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index fc9fb5d06174..b8f74d80f35c 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -74,6 +74,24 @@ SYM_FUNC_START(rep_movs_alternative)
 	_ASM_EXTABLE_UA( 0b, 1b)
 
 .Llarge_movsq:
+	/* Do the first possibly unaligned word */
+0:	movq (%rsi),%rax
+1:	movq %rax,(%rdi)
+
+	_ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
+	_ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
+
+	/* What would be the offset to the aligned destination? */
+	leaq 8(%rdi),%rax
+	andq $-8,%rax
+	subq %rdi,%rax
+
+	/* .. and update pointers and count to match */
+	addq %rax,%rdi
+	addq %rax,%rsi
+	subq %rax,%rcx
+
+	/* make %rcx contain the number of words, %rax the remainder */
 	movq %rcx,%rax
 	shrq $3,%rcx
 	andl $7,%eax
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index ac33b2263a43..b922b9fea6b6 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -562,7 +562,7 @@ void __head sme_enable(struct boot_params *bp)
 	}
 
 	RIP_REL_REF(sme_me_mask) = me_mask;
-	physical_mask &= ~me_mask;
-	cc_vendor = CC_VENDOR_AMD;
+	RIP_REL_REF(physical_mask) &= ~me_mask;
+	RIP_REL_REF(cc_vendor) = CC_VENDOR_AMD;
 	cc_set_mask(me_mask);
 }
diff --git a/arch/x86/mm/pat/cpa-test.c b/arch/x86/mm/pat/cpa-test.c
index 3d2f7f0a6ed1..ad3c1feec990 100644
--- a/arch/x86/mm/pat/cpa-test.c
+++ b/arch/x86/mm/pat/cpa-test.c
@@ -183,7 +183,7 @@ static int pageattr_test(void)
 			break;
 
 		case 1:
-			err = change_page_attr_set(addrs, len[1], PAGE_CPA_TEST, 1);
+			err = change_page_attr_set(addrs, len[i], PAGE_CPA_TEST, 1);
 			break;
 
 		case 2:
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6a12bf..d721cc19addb 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -984,29 +984,42 @@ static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
 	return -EINVAL;
 }
 
-/*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
- *
- * If the vma has a linear pfn mapping for the entire range, we get the prot
- * from pte and reserve the entire vma range with single reserve_pfn_range call.
- */
-int track_pfn_copy(struct vm_area_struct *vma)
+int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn)
 {
+	const unsigned long vma_size = src_vma->vm_end - src_vma->vm_start;
 	resource_size_t paddr;
-	unsigned long vma_size = vma->vm_end - vma->vm_start;
 	pgprot_t pgprot;
+	int rc;
 
-	if (vma->vm_flags & VM_PAT) {
-		if (get_pat_info(vma, &paddr, &pgprot))
-			return -EINVAL;
-		/* reserve the whole chunk covered by vma. */
-		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
-	}
+	if (!(src_vma->vm_flags & VM_PAT))
+		return 0;
+
+	/*
+	 * Duplicate the PAT information for the dst VMA based on the src
+	 * VMA.
+	 */
+	if (get_pat_info(src_vma, &paddr, &pgprot))
+		return -EINVAL;
+	rc = reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (rc)
+		return rc;
 
+	/* Reservation for the destination VMA succeeded. */
+	vm_flags_set(dst_vma, VM_PAT);
+	*pfn = PHYS_PFN(paddr);
 	return 0;
 }
 
+void untrack_pfn_copy(struct vm_area_struct *dst_vma, unsigned long pfn)
+{
+	untrack_pfn(dst_vma, pfn, dst_vma->vm_end - dst_vma->vm_start, true);
+	/*
+	 * Reservation was freed, any copied page tables will get cleaned
+	 * up later, but without getting PAT involved again.
+	 */
+}
+
 /*
  * prot is passed in as a parameter for the new mapping. If the vma has
  * a linear pfn mapping for the entire range, or no vma is provided,
@@ -1095,15 +1108,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	}
 }
 
-/*
- * untrack_pfn_clear is called if the following situation fits:
- *
- * 1) while mremapping a pfnmap for a new region,  with the old vma after
- * its pfnmap page table has been removed.  The new vma has a new pfnmap
- * to the same pfn & cache type with VM_PAT set.
- * 2) while duplicating vm area, the new vma fails to copy the pgtable from
- * old vma.
- */
 void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 	vm_flags_clear(vma, VM_PAT);
diff --git a/crypto/api.c b/crypto/api.c
index bfd177a4313a..c2c4eb14ef95 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -36,7 +36,8 @@ EXPORT_SYMBOL_GPL(crypto_chain);
 DEFINE_STATIC_KEY_FALSE(__crypto_boot_test_finished);
 #endif
 
-static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg);
+static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg,
+					     u32 type, u32 mask);
 static struct crypto_alg *crypto_alg_lookup(const char *name, u32 type,
 					    u32 mask);
 
@@ -145,7 +146,7 @@ static struct crypto_alg *crypto_larval_add(const char *name, u32 type,
 	if (alg != &larval->alg) {
 		kfree(larval);
 		if (crypto_is_larval(alg))
-			alg = crypto_larval_wait(alg);
+			alg = crypto_larval_wait(alg, type, mask);
 	}
 
 	return alg;
@@ -197,7 +198,8 @@ static void crypto_start_test(struct crypto_larval *larval)
 	crypto_schedule_test(larval);
 }
 
-static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
+static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg,
+					     u32 type, u32 mask)
 {
 	struct crypto_larval *larval;
 	long time_left;
@@ -219,12 +221,7 @@ static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
 			crypto_larval_kill(larval);
 		alg = ERR_PTR(-ETIMEDOUT);
 	} else if (!alg) {
-		u32 type;
-		u32 mask;
-
 		alg = &larval->alg;
-		type = alg->cra_flags & ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
-		mask = larval->mask;
 		alg = crypto_alg_lookup(alg->cra_name, type, mask) ?:
 		      ERR_PTR(-EAGAIN);
 	} else if (IS_ERR(alg))
@@ -304,7 +301,7 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
 	}
 
 	if (!IS_ERR_OR_NULL(alg) && crypto_is_larval(alg))
-		alg = crypto_larval_wait(alg);
+		alg = crypto_larval_wait(alg, type, mask);
 	else if (alg)
 		;
 	else if (!(mask & CRYPTO_ALG_TESTED))
@@ -352,7 +349,7 @@ struct crypto_alg *crypto_alg_mod_lookup(const char *name, u32 type, u32 mask)
 	ok = crypto_probing_notify(CRYPTO_MSG_ALG_REQUEST, larval);
 
 	if (ok == NOTIFY_STOP)
-		alg = crypto_larval_wait(larval);
+		alg = crypto_larval_wait(larval, type, mask);
 	else {
 		crypto_mod_put(larval);
 		alg = ERR_PTR(-ENOENT);
diff --git a/crypto/bpf_crypto_skcipher.c b/crypto/bpf_crypto_skcipher.c
index b5e657415770..a88798d3e8c8 100644
--- a/crypto/bpf_crypto_skcipher.c
+++ b/crypto/bpf_crypto_skcipher.c
@@ -80,3 +80,4 @@ static void __exit bpf_crypto_skcipher_exit(void)
 module_init(bpf_crypto_skcipher_init);
 module_exit(bpf_crypto_skcipher_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Symmetric key cipher support for BPF");
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index a5d47819b3a4..ae035b93da08 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -485,7 +485,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		cmd_mask = nd_desc->cmd_mask;
 		if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
 			family = call_pkg->nd_family;
-			if (family > NVDIMM_BUS_FAMILY_MAX ||
+			if (call_pkg->nd_family > NVDIMM_BUS_FAMILY_MAX ||
 			    !test_bit(family, &nd_desc->bus_family_mask))
 				return -EINVAL;
 			family = array_index_nospec(family,
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 831fa4a12159..0888e4d618d5 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -268,6 +268,10 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 			 ACPI_CX_DESC_LEN, "ACPI P_LVL3 IOPORT 0x%x",
 			 pr->power.states[ACPI_STATE_C3].address);
 
+	if (!pr->power.states[ACPI_STATE_C2].address &&
+	    !pr->power.states[ACPI_STATE_C3].address)
+		return -ENODEV;
+
 	return 0;
 }
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b4cd14e7fa76..14c7bac4100b 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		/* Asus Vivobook X1404VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1404VAP"),
+		},
+	},
 	{
 		/* Asus Vivobook X1504VAP */
 		.matches = {
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 068c1612660b..4ee30c2897a2 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -374,7 +374,8 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
-					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
 	{
 		/* Medion Lifetab S10346 */
diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 21545ffba065..2a9bb31633a7 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -503,6 +503,7 @@ config HT16K33
 config MAX6959
 	tristate "Maxim MAX6958/6959 7-segment LED controller"
 	depends on I2C
+	select BITREVERSE
 	select REGMAP_I2C
 	select LINEDISP
 	help
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index a731f28455b4..6dc8798d01f9 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1664,7 +1664,7 @@ static void panel_attach(struct parport *port)
 	if (lcd.enabled)
 		charlcd_unregister(lcd.charlcd);
 err_unreg_device:
-	kfree(lcd.charlcd);
+	charlcd_free(lcd.charlcd);
 	lcd.charlcd = NULL;
 	parport_unregister_device(pprt);
 	pprt = NULL;
@@ -1692,7 +1692,7 @@ static void panel_detach(struct parport *port)
 		charlcd_unregister(lcd.charlcd);
 		lcd.initialized = false;
 		kfree(lcd.charlcd->drvdata);
-		kfree(lcd.charlcd);
+		charlcd_free(lcd.charlcd);
 		lcd.charlcd = NULL;
 	}
 
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4a67e83300e1..1abe61f11525 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -913,6 +913,9 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
+	if (!dev->power.is_suspended)
+		goto Complete;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
 		pm_runtime_enable(dev);
@@ -931,9 +934,6 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	 */
 	dev->power.is_prepared = false;
 
-	if (!dev->power.is_suspended)
-		goto Unlock;
-
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
@@ -973,7 +973,6 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	error = dpm_run_callback(callback, dev, state, info);
 	dev->power.is_suspended = false;
 
- Unlock:
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
 
@@ -1254,14 +1253,13 @@ static int device_suspend_noirq(struct device *dev, pm_message_t state, bool asy
 	dev->power.is_noirq_suspended = true;
 
 	/*
-	 * Skipping the resume of devices that were in use right before the
-	 * system suspend (as indicated by their PM-runtime usage counters)
-	 * would be suboptimal.  Also resume them if doing that is not allowed
-	 * to be skipped.
+	 * Devices must be resumed unless they are explicitly allowed to be left
+	 * in suspend, but even in that case skipping the resume of devices that
+	 * were in use right before the system suspend (as indicated by their
+	 * runtime PM usage counters and child counters) would be suboptimal.
 	 */
-	if (atomic_read(&dev->power.usage_count) > 1 ||
-	    !(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME) &&
-	      dev->power.may_skip_resume))
+	if (!(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME) &&
+	      dev->power.may_skip_resume) || !pm_runtime_need_not_resume(dev))
 		dev->power.must_resume = true;
 
 	if (dev->power.must_resume)
@@ -1628,6 +1626,7 @@ static int device_suspend(struct device *dev, pm_message_t state, bool async)
 			pm_runtime_disable(dev);
 			if (pm_runtime_status_suspended(dev)) {
 				pm_dev_dbg(dev, state, "direct-complete ");
+				dev->power.is_suspended = true;
 				goto Complete;
 			}
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 2ee45841486b..04113adb092b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1874,7 +1874,7 @@ void pm_runtime_drop_link(struct device_link *link)
 	pm_request_idle(link->supplier);
 }
 
-static bool pm_runtime_need_not_resume(struct device *dev)
+bool pm_runtime_need_not_resume(struct device *dev)
 {
 	return atomic_read(&dev->power.usage_count) <= 1 &&
 		(atomic_read(&dev->power.child_count) == 0 ||
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c7d728d686e5..79b7bd8bfd45 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1416,17 +1416,27 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 }
 
+/* Must be called when queue is frozen */
+static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
+{
+	bool canceled;
+
+	spin_lock(&ubq->cancel_lock);
+	canceled = ubq->canceling;
+	if (!canceled)
+		ubq->canceling = true;
+	spin_unlock(&ubq->cancel_lock);
+
+	return canceled;
+}
+
 static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 {
+	bool was_canceled = ubq->canceling;
 	struct gendisk *disk;
 
-	spin_lock(&ubq->cancel_lock);
-	if (ubq->canceling) {
-		spin_unlock(&ubq->cancel_lock);
+	if (was_canceled)
 		return false;
-	}
-	ubq->canceling = true;
-	spin_unlock(&ubq->cancel_lock);
 
 	spin_lock(&ub->lock);
 	disk = ub->ub_disk;
@@ -1438,14 +1448,23 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 	if (!disk)
 		return false;
 
-	/* Now we are serialized with ublk_queue_rq() */
+	/*
+	 * Now we are serialized with ublk_queue_rq()
+	 *
+	 * Make sure that ubq->canceling is set when queue is frozen,
+	 * because ublk_queue_rq() has to rely on this flag for avoiding to
+	 * touch completed uring_cmd
+	 */
 	blk_mq_quiesce_queue(disk->queue);
-	/* abort queue is for making forward progress */
-	ublk_abort_queue(ub, ubq);
+	was_canceled = ublk_mark_queue_canceling(ubq);
+	if (!was_canceled) {
+		/* abort queue is for making forward progress */
+		ublk_abort_queue(ub, ubq);
+	}
 	blk_mq_unquiesce_queue(disk->queue);
 	put_device(disk_to_dev(disk));
 
-	return true;
+	return !was_canceled;
 }
 
 static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index c409fc7e0618..775f62dddb11 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -180,14 +180,14 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
 	CLK_GATE("asrc", ASRC_IPG),
 	CLK_GATE("pdm", PDM_IPG),
 	CLK_GATE("earc", EARC_IPG),
-	CLK_GATE("ocrama", OCRAMA_IPG),
+	CLK_GATE_PARENT("ocrama", OCRAMA_IPG, "axi"),
 	CLK_GATE("aud2htx", AUD2HTX_IPG),
 	CLK_GATE_PARENT("earc_phy", EARC_PHY, "sai_pll_out_div2"),
 	CLK_GATE("sdma2", SDMA2_ROOT),
 	CLK_GATE("sdma3", SDMA3_ROOT),
 	CLK_GATE("spba2", SPBA2_ROOT),
-	CLK_GATE("dsp", DSP_ROOT),
-	CLK_GATE("dspdbg", DSPDBG_ROOT),
+	CLK_GATE_PARENT("dsp", DSP_ROOT, "axi"),
+	CLK_GATE_PARENT("dspdbg", DSPDBG_ROOT, "axi"),
 	CLK_GATE("edma", EDMA_ROOT),
 	CLK_GATE_PARENT("audpll", AUDPLL_ROOT, "osc_24m"),
 	CLK_GATE("mu2", MU2_ROOT),
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 02dda57105b1..4f92b83965d5 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -1139,8 +1139,18 @@ static struct clk_regmap g12a_cpu_clk_div16_en = {
 	.hw.init = &(struct clk_init_data) {
 		.name = "cpu_clk_div16_en",
 		.ops = &clk_regmap_gate_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&g12a_cpu_clk.hw
+		.parent_data = &(const struct clk_parent_data) {
+			/*
+			 * Note:
+			 * G12A and G12B have different cpu clocks (with
+			 * different struct clk_hw). We fallback to the global
+			 * naming string mechanism so this clock picks
+			 * up the appropriate one. Same goes for the other
+			 * clock using cpu cluster A clock output and present
+			 * on both G12 variant.
+			 */
+			.name = "cpu_clk",
+			.index = -1,
 		},
 		.num_parents = 1,
 		/*
@@ -1205,7 +1215,10 @@ static struct clk_regmap g12a_cpu_clk_apb_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_apb_div",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "cpu_clk",
+			.index = -1,
+		},
 		.num_parents = 1,
 	},
 };
@@ -1239,7 +1252,10 @@ static struct clk_regmap g12a_cpu_clk_atb_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_atb_div",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "cpu_clk",
+			.index = -1,
+		},
 		.num_parents = 1,
 	},
 };
@@ -1273,7 +1289,10 @@ static struct clk_regmap g12a_cpu_clk_axi_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_axi_div",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "cpu_clk",
+			.index = -1,
+		},
 		.num_parents = 1,
 	},
 };
@@ -1308,13 +1327,6 @@ static struct clk_regmap g12a_cpu_clk_trace_div = {
 		.name = "cpu_clk_trace_div",
 		.ops = &clk_regmap_divider_ro_ops,
 		.parent_data = &(const struct clk_parent_data) {
-			/*
-			 * Note:
-			 * G12A and G12B have different cpu_clks (with
-			 * different struct clk_hw). We fallback to the global
-			 * naming string mechanism so cpu_clk_trace_div picks
-			 * up the appropriate one.
-			 */
 			.name = "cpu_clk",
 			.index = -1,
 		},
@@ -4317,7 +4329,7 @@ static MESON_GATE(g12a_spicc_1,			HHI_GCLK_MPEG0,	14);
 static MESON_GATE(g12a_hiu_reg,			HHI_GCLK_MPEG0,	19);
 static MESON_GATE(g12a_mipi_dsi_phy,		HHI_GCLK_MPEG0,	20);
 static MESON_GATE(g12a_assist_misc,		HHI_GCLK_MPEG0,	23);
-static MESON_GATE(g12a_emmc_a,			HHI_GCLK_MPEG0,	4);
+static MESON_GATE(g12a_emmc_a,			HHI_GCLK_MPEG0,	24);
 static MESON_GATE(g12a_emmc_b,			HHI_GCLK_MPEG0,	25);
 static MESON_GATE(g12a_emmc_c,			HHI_GCLK_MPEG0,	26);
 static MESON_GATE(g12a_audio_codec,		HHI_GCLK_MPEG0,	28);
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index f071faad1ebb..d9529de200ae 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1272,14 +1272,13 @@ static struct clk_regmap gxbb_cts_i958 = {
 	},
 };
 
+/*
+ * This table skips a clock named 'cts_slow_oscin' in the documentation
+ * This clock does not exist yet in this controller or the AO one
+ */
+static u32 gxbb_32k_clk_parents_val_table[] = { 0, 2, 3 };
 static const struct clk_parent_data gxbb_32k_clk_parent_data[] = {
 	{ .fw_name = "xtal", },
-	/*
-	 * FIXME: This clock is provided by the ao clock controller but the
-	 * clock is not yet part of the binding of this controller, so string
-	 * name must be use to set this parent.
-	 */
-	{ .name = "cts_slow_oscin", .index = -1 },
 	{ .hw = &gxbb_fclk_div3.hw },
 	{ .hw = &gxbb_fclk_div5.hw },
 };
@@ -1289,6 +1288,7 @@ static struct clk_regmap gxbb_32k_clk_sel = {
 		.offset = HHI_32K_CLK_CNTL,
 		.mask = 0x3,
 		.shift = 16,
+		.table = gxbb_32k_clk_parents_val_table,
 		},
 	.hw.init = &(struct clk_init_data){
 		.name = "32k_clk_sel",
@@ -1312,7 +1312,7 @@ static struct clk_regmap gxbb_32k_clk_div = {
 			&gxbb_32k_clk_sel.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_DIVIDER_ROUND_CLOSEST,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8953.c b/drivers/clk/qcom/gcc-msm8953.c
index 855a61966f3e..8f29ecc74c50 100644
--- a/drivers/clk/qcom/gcc-msm8953.c
+++ b/drivers/clk/qcom/gcc-msm8953.c
@@ -3770,7 +3770,7 @@ static struct clk_branch gcc_venus0_axi_clk = {
 
 static struct clk_branch gcc_venus0_core0_vcodec0_clk = {
 	.halt_reg = 0x4c02c,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x4c02c,
 		.enable_mask = BIT(0),
diff --git a/drivers/clk/qcom/gcc-sm8650.c b/drivers/clk/qcom/gcc-sm8650.c
index 9dd5c48f33be..fa1672c4e7d8 100644
--- a/drivers/clk/qcom/gcc-sm8650.c
+++ b/drivers/clk/qcom/gcc-sm8650.c
@@ -3497,7 +3497,7 @@ static struct gdsc usb30_prim_gdsc = {
 	.pd = {
 		.name = "usb30_prim_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -3506,7 +3506,7 @@ static struct gdsc usb3_phy_gdsc = {
 	.pd = {
 		.name = "usb3_phy_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 7288af845434..009f39139b64 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -2564,19 +2564,6 @@ static struct clk_branch gcc_disp_hf_axi_clk = {
 	},
 };
 
-static struct clk_branch gcc_disp_xo_clk = {
-	.halt_reg = 0x27018,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x27018,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_disp_xo_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_gp1_clk = {
 	.halt_reg = 0x64000,
 	.halt_check = BRANCH_HALT,
@@ -2631,21 +2618,6 @@ static struct clk_branch gcc_gp3_clk = {
 	},
 };
 
-static struct clk_branch gcc_gpu_cfg_ahb_clk = {
-	.halt_reg = 0x71004,
-	.halt_check = BRANCH_HALT_VOTED,
-	.hwcg_reg = 0x71004,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0x71004,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_gpu_cfg_ahb_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_gpu_gpll0_cph_clk_src = {
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
@@ -6268,7 +6240,6 @@ static struct clk_regmap *gcc_x1e80100_clocks[] = {
 	[GCC_CNOC_PCIE_TUNNEL_CLK] = &gcc_cnoc_pcie_tunnel_clk.clkr,
 	[GCC_DDRSS_GPU_AXI_CLK] = &gcc_ddrss_gpu_axi_clk.clkr,
 	[GCC_DISP_HF_AXI_CLK] = &gcc_disp_hf_axi_clk.clkr,
-	[GCC_DISP_XO_CLK] = &gcc_disp_xo_clk.clkr,
 	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
 	[GCC_GP1_CLK_SRC] = &gcc_gp1_clk_src.clkr,
 	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
@@ -6281,7 +6252,6 @@ static struct clk_regmap *gcc_x1e80100_clocks[] = {
 	[GCC_GPLL7] = &gcc_gpll7.clkr,
 	[GCC_GPLL8] = &gcc_gpll8.clkr,
 	[GCC_GPLL9] = &gcc_gpll9.clkr,
-	[GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
 	[GCC_GPU_GPLL0_CPH_CLK_SRC] = &gcc_gpu_gpll0_cph_clk_src.clkr,
 	[GCC_GPU_GPLL0_DIV_CPH_CLK_SRC] = &gcc_gpu_gpll0_div_cph_clk_src.clkr,
 	[GCC_GPU_MEMNOC_GFX_CLK] = &gcc_gpu_memnoc_gfx_clk.clkr,
diff --git a/drivers/clk/qcom/mmcc-sdm660.c b/drivers/clk/qcom/mmcc-sdm660.c
index 98ba5b4518fb..b9f02d91004e 100644
--- a/drivers/clk/qcom/mmcc-sdm660.c
+++ b/drivers/clk/qcom/mmcc-sdm660.c
@@ -2544,7 +2544,7 @@ static struct clk_branch video_core_clk = {
 
 static struct clk_branch video_subcore0_clk = {
 	.halt_reg = 0x1048,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x1048,
 		.enable_mask = BIT(0),
diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 1ce40fb51f13..a1f961d5b856 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -50,7 +50,7 @@
 #define G3S_SEL_SDHI2		SEL_PLL_PACK(G3S_CPG_SDHI_DSEL, 8, 2)
 
 /* PLL 1/4/6 configuration registers macro. */
-#define G3S_PLL146_CONF(clk1, clk2)	((clk1) << 22 | (clk2) << 12)
+#define G3S_PLL146_CONF(clk1, clk2, setting)	((clk1) << 22 | (clk2) << 12 | (setting))
 
 #define DEF_G3S_MUX(_name, _id, _conf, _parent_names, _mux_flags, _clk_flags) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = (_conf), \
@@ -133,7 +133,8 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 
 	/* Internal Core Clocks */
 	DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
-	DEF_G3S_PLL(".pll1", CLK_PLL1, CLK_EXTAL, G3S_PLL146_CONF(0x4, 0x8)),
+	DEF_G3S_PLL(".pll1", CLK_PLL1, CLK_EXTAL, G3S_PLL146_CONF(0x4, 0x8, 0x100),
+		    1100000000UL),
 	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
 	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
 	DEF_FIXED(".pll4", CLK_PLL4, CLK_EXTAL, 100, 3),
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index b43b763dfe18..229f4540b219 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -51,6 +51,7 @@
 #define RZG3S_DIV_M		GENMASK(25, 22)
 #define RZG3S_DIV_NI		GENMASK(21, 13)
 #define RZG3S_DIV_NF		GENMASK(12, 1)
+#define RZG3S_SEL_PLL		BIT(0)
 
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
@@ -60,6 +61,7 @@
 #define GET_REG_OFFSET(val)		((val >> 20) & 0xfff)
 #define GET_REG_SAMPLL_CLK1(val)	((val >> 22) & 0xfff)
 #define GET_REG_SAMPLL_CLK2(val)	((val >> 12) & 0xfff)
+#define GET_REG_SAMPLL_SETTING(val)	((val) & 0xfff)
 
 #define CPG_WEN_BIT		BIT(16)
 
@@ -943,6 +945,7 @@ rzg2l_cpg_sipll5_register(const struct cpg_core_clk *core,
 
 struct pll_clk {
 	struct clk_hw hw;
+	unsigned long default_rate;
 	unsigned int conf;
 	unsigned int type;
 	void __iomem *base;
@@ -980,12 +983,19 @@ static unsigned long rzg3s_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct pll_clk *pll_clk = to_pll(hw);
 	struct rzg2l_cpg_priv *priv = pll_clk->priv;
-	u32 nir, nfr, mr, pr, val;
+	u32 nir, nfr, mr, pr, val, setting;
 	u64 rate;
 
 	if (pll_clk->type != CLK_TYPE_G3S_PLL)
 		return parent_rate;
 
+	setting = GET_REG_SAMPLL_SETTING(pll_clk->conf);
+	if (setting) {
+		val = readl(priv->base + setting);
+		if (val & RZG3S_SEL_PLL)
+			return pll_clk->default_rate;
+	}
+
 	val = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
 
 	pr = 1 << FIELD_GET(RZG3S_DIV_P, val);
@@ -1038,6 +1048,7 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 	pll_clk->base = priv->base;
 	pll_clk->priv = priv;
 	pll_clk->type = core->type;
+	pll_clk->default_rate = core->default_rate;
 
 	ret = devm_clk_hw_register(dev, &pll_clk->hw);
 	if (ret)
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index ecfe7e7ea8a1..019efe00ffd9 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -102,7 +102,10 @@ struct cpg_core_clk {
 	const struct clk_div_table *dtable;
 	const u32 *mtable;
 	const unsigned long invalid_rate;
-	const unsigned long max_rate;
+	union {
+		const unsigned long max_rate;
+		const unsigned long default_rate;
+	};
 	const char * const *parent_names;
 	notifier_fn_t notifier;
 	u32 flag;
@@ -144,8 +147,9 @@ enum clk_types {
 	DEF_TYPE(_name, _id, _type, .parent = _parent)
 #define DEF_SAMPLL(_name, _id, _parent, _conf) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SAM_PLL, .parent = _parent, .conf = _conf)
-#define DEF_G3S_PLL(_name, _id, _parent, _conf) \
-	DEF_TYPE(_name, _id, CLK_TYPE_G3S_PLL, .parent = _parent, .conf = _conf)
+#define DEF_G3S_PLL(_name, _id, _parent, _conf, _default_rate) \
+	DEF_TYPE(_name, _id, CLK_TYPE_G3S_PLL, .parent = _parent, .conf = _conf, \
+		 .default_rate = _default_rate)
 #define DEF_INPUT(_name, _id) \
 	DEF_TYPE(_name, _id, CLK_TYPE_IN)
 #define DEF_FIXED(_name, _id, _parent, _mult, _div) \
diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index 3bb87b27b662..cf60fcf2fa5c 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -201,7 +201,7 @@ PNAME(mux_aclk_peri_pre_p)	= { "cpll_peri",
 				    "gpll_peri",
 				    "hdmiphy_peri" };
 PNAME(mux_ref_usb3otg_src_p)	= { "xin24m",
-				    "clk_usb3otg_ref" };
+				    "clk_ref_usb3otg_src" };
 PNAME(mux_xin24m_32k_p)		= { "xin24m",
 				    "clk_rtc32k" };
 PNAME(mux_mac2io_src_p)		= { "clk_mac2io_src",
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index afa5760ed3a1..e6533513f8ac 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -74,12 +74,12 @@ struct samsung_clk_provider * __init samsung_clk_init(struct device *dev,
 	if (!ctx)
 		panic("could not allocate clock provider context.\n");
 
+	ctx->clk_data.num = nr_clks;
 	for (i = 0; i < nr_clks; ++i)
 		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
 
 	ctx->dev = dev;
 	ctx->reg_base = base;
-	ctx->clk_data.num = nr_clks;
 	spin_lock_init(&ctx->lock);
 
 	return ctx;
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 5f7e13e60c80..e67b2326671c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -245,7 +245,7 @@ config ARM_TEGRA186_CPUFREQ
 
 config ARM_TEGRA194_CPUFREQ
 	tristate "Tegra194 CPUFreq support"
-	depends on ARCH_TEGRA_194_SOC || (64BIT && COMPILE_TEST)
+	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || (64BIT && COMPILE_TEST)
 	depends on TEGRA_BPMP
 	default y
 	help
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index af44ee6a6430..1a7fcaf39cc9 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -145,7 +145,23 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 		time_elapsed = update_time - j_cdbs->prev_update_time;
 		j_cdbs->prev_update_time = update_time;
 
-		idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
+		/*
+		 * cur_idle_time could be smaller than j_cdbs->prev_cpu_idle if
+		 * it's obtained from get_cpu_idle_time_jiffy() when NOHZ is
+		 * off, where idle_time is calculated by the difference between
+		 * time elapsed in jiffies and "busy time" obtained from CPU
+		 * statistics.  If a CPU is 100% busy, the time elapsed and busy
+		 * time should grow with the same amount in two consecutive
+		 * samples, but in practice there could be a tiny difference,
+		 * making the accumulated idle time decrease sometimes.  Hence,
+		 * in this case, idle_time should be regarded as 0 in order to
+		 * make the further process correct.
+		 */
+		if (cur_idle_time > j_cdbs->prev_cpu_idle)
+			idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
+		else
+			idle_time = 0;
+
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
@@ -162,7 +178,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			 * calls, so the previous load value can be used then.
 			 */
 			load = j_cdbs->prev_load;
-		} else if (unlikely((int)idle_time > 2 * sampling_rate &&
+		} else if (unlikely(idle_time > 2 * sampling_rate &&
 				    j_cdbs->prev_load)) {
 			/*
 			 * If the CPU had gone completely idle and a task has
@@ -189,30 +205,15 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			load = j_cdbs->prev_load;
 			j_cdbs->prev_load = 0;
 		} else {
-			if (time_elapsed >= idle_time) {
+			if (time_elapsed > idle_time)
 				load = 100 * (time_elapsed - idle_time) / time_elapsed;
-			} else {
-				/*
-				 * That can happen if idle_time is returned by
-				 * get_cpu_idle_time_jiffy().  In that case
-				 * idle_time is roughly equal to the difference
-				 * between time_elapsed and "busy time" obtained
-				 * from CPU statistics.  Then, the "busy time"
-				 * can end up being greater than time_elapsed
-				 * (for example, if jiffies_64 and the CPU
-				 * statistics are updated by different CPUs),
-				 * so idle_time may in fact be negative.  That
-				 * means, though, that the CPU was busy all
-				 * the time (on the rough average) during the
-				 * last sampling interval and 100 can be
-				 * returned as the load.
-				 */
-				load = (int)idle_time < 0 ? 100 : 0;
-			}
+			else
+				load = 0;
+
 			j_cdbs->prev_load = load;
 		}
 
-		if (unlikely((int)idle_time > 2 * sampling_rate)) {
+		if (unlikely(idle_time > 2 * sampling_rate)) {
 			unsigned int periods = idle_time / sampling_rate;
 
 			if (periods < idle_periods)
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 8d73e6e8be2a..f2d913a91be9 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -39,8 +39,9 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 static int
 scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	u64 rate = policy->freq_table[index].frequency * 1000;
+	unsigned long freq_khz = policy->freq_table[index].frequency;
 	struct scpi_data *priv = policy->driver_data;
+	unsigned long rate = freq_khz * 1000;
 	int ret;
 
 	ret = clk_set_rate(priv->clk, rate);
@@ -48,7 +49,7 @@ scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	if (ret)
 		return ret;
 
-	if (clk_get_rate(priv->clk) != rate)
+	if (clk_get_rate(priv->clk) / 1000 != freq_khz)
 		return -EIO;
 
 	return 0;
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 30c2b1a64695..2fc04e210bc4 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -37,7 +37,6 @@ struct sec_aead_req {
 	u8 *a_ivin;
 	dma_addr_t a_ivin_dma;
 	struct aead_request *aead_req;
-	bool fallback;
 };
 
 /* SEC request of Crypto */
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index a9b1b9b0b03b..8605cb3cae92 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -57,7 +57,6 @@
 #define SEC_TYPE_MASK		0x0F
 #define SEC_DONE_MASK		0x0001
 #define SEC_ICV_MASK		0x000E
-#define SEC_SQE_LEN_RATE_MASK	0x3
 
 #define SEC_TOTAL_IV_SZ(depth)	(SEC_IV_SIZE * (depth))
 #define SEC_SGL_SGE_NR		128
@@ -80,16 +79,16 @@
 #define SEC_TOTAL_PBUF_SZ(depth)	(PAGE_SIZE * SEC_PBUF_PAGE_NUM(depth) +	\
 				SEC_PBUF_LEFT_SZ(depth))
 
-#define SEC_SQE_LEN_RATE	4
 #define SEC_SQE_CFLAG		2
 #define SEC_SQE_AEAD_FLAG	3
 #define SEC_SQE_DONE		0x1
 #define SEC_ICV_ERR		0x2
-#define MIN_MAC_LEN		4
 #define MAC_LEN_MASK		0x1U
 #define MAX_INPUT_DATA_LEN	0xFFFE00
 #define BITS_MASK		0xFF
+#define WORD_MASK		0x3
 #define BYTE_BITS		0x8
+#define BYTES_TO_WORDS(bcount)	((bcount) >> 2)
 #define SEC_XTS_NAME_SZ		0x3
 #define IV_CM_CAL_NUM		2
 #define IV_CL_MASK		0x7
@@ -691,14 +690,10 @@ static int sec_skcipher_fbtfm_init(struct crypto_skcipher *tfm)
 
 	c_ctx->fallback = false;
 
-	/* Currently, only XTS mode need fallback tfm when using 192bit key */
-	if (likely(strncmp(alg, "xts", SEC_XTS_NAME_SZ)))
-		return 0;
-
 	c_ctx->fbtfm = crypto_alloc_sync_skcipher(alg, 0,
 						  CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(c_ctx->fbtfm)) {
-		pr_err("failed to alloc xts mode fallback tfm!\n");
+		pr_err("failed to alloc fallback tfm for %s!\n", alg);
 		return PTR_ERR(c_ctx->fbtfm);
 	}
 
@@ -858,7 +853,7 @@ static int sec_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	}
 
 	memcpy(c_ctx->c_key, key, keylen);
-	if (c_ctx->fallback && c_ctx->fbtfm) {
+	if (c_ctx->fbtfm) {
 		ret = crypto_sync_skcipher_setkey(c_ctx->fbtfm, key, keylen);
 		if (ret) {
 			dev_err(dev, "failed to set fallback skcipher key!\n");
@@ -1090,11 +1085,6 @@ static int sec_aead_auth_set_key(struct sec_auth_ctx *ctx,
 	struct crypto_shash *hash_tfm = ctx->hash_tfm;
 	int blocksize, digestsize, ret;
 
-	if (!keys->authkeylen) {
-		pr_err("hisi_sec2: aead auth key error!\n");
-		return -EINVAL;
-	}
-
 	blocksize = crypto_shash_blocksize(hash_tfm);
 	digestsize = crypto_shash_digestsize(hash_tfm);
 	if (keys->authkeylen > blocksize) {
@@ -1106,7 +1096,8 @@ static int sec_aead_auth_set_key(struct sec_auth_ctx *ctx,
 		}
 		ctx->a_key_len = digestsize;
 	} else {
-		memcpy(ctx->a_key, keys->authkey, keys->authkeylen);
+		if (keys->authkeylen)
+			memcpy(ctx->a_key, keys->authkey, keys->authkeylen);
 		ctx->a_key_len = keys->authkeylen;
 	}
 
@@ -1160,8 +1151,10 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 	}
 
 	ret = crypto_authenc_extractkeys(&keys, key, keylen);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "sec extract aead keys err!\n");
 		goto bad_key;
+	}
 
 	ret = sec_aead_aes_set_key(c_ctx, &keys);
 	if (ret) {
@@ -1175,12 +1168,6 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		goto bad_key;
 	}
 
-	if (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK) {
-		ret = -EINVAL;
-		dev_err(dev, "AUTH key length error!\n");
-		goto bad_key;
-	}
-
 	ret = sec_aead_fallback_setkey(a_ctx, tfm, key, keylen);
 	if (ret) {
 		dev_err(dev, "set sec fallback key err!\n");
@@ -1583,11 +1570,10 @@ static void sec_auth_bd_fill_ex(struct sec_auth_ctx *ctx, int dir,
 
 	sec_sqe->type2.a_key_addr = cpu_to_le64(ctx->a_key_dma);
 
-	sec_sqe->type2.mac_key_alg = cpu_to_le32(authsize / SEC_SQE_LEN_RATE);
+	sec_sqe->type2.mac_key_alg = cpu_to_le32(BYTES_TO_WORDS(authsize));
 
 	sec_sqe->type2.mac_key_alg |=
-			cpu_to_le32((u32)((ctx->a_key_len) /
-			SEC_SQE_LEN_RATE) << SEC_AKEY_OFFSET);
+			cpu_to_le32((u32)BYTES_TO_WORDS(ctx->a_key_len) << SEC_AKEY_OFFSET);
 
 	sec_sqe->type2.mac_key_alg |=
 			cpu_to_le32((u32)(ctx->a_alg) << SEC_AEAD_ALG_OFFSET);
@@ -1639,12 +1625,10 @@ static void sec_auth_bd_fill_ex_v3(struct sec_auth_ctx *ctx, int dir,
 	sqe3->a_key_addr = cpu_to_le64(ctx->a_key_dma);
 
 	sqe3->auth_mac_key |=
-			cpu_to_le32((u32)(authsize /
-			SEC_SQE_LEN_RATE) << SEC_MAC_OFFSET_V3);
+			cpu_to_le32(BYTES_TO_WORDS(authsize) << SEC_MAC_OFFSET_V3);
 
 	sqe3->auth_mac_key |=
-			cpu_to_le32((u32)(ctx->a_key_len /
-			SEC_SQE_LEN_RATE) << SEC_AKEY_OFFSET_V3);
+			cpu_to_le32((u32)BYTES_TO_WORDS(ctx->a_key_len) << SEC_AKEY_OFFSET_V3);
 
 	sqe3->auth_mac_key |=
 			cpu_to_le32((u32)(ctx->a_alg) << SEC_AUTH_ALG_OFFSET_V3);
@@ -2003,8 +1987,7 @@ static int sec_aead_sha512_ctx_init(struct crypto_aead *tfm)
 	return sec_aead_ctx_init(tfm, "sha512");
 }
 
-static int sec_skcipher_cryptlen_check(struct sec_ctx *ctx,
-	struct sec_req *sreq)
+static int sec_skcipher_cryptlen_check(struct sec_ctx *ctx, struct sec_req *sreq)
 {
 	u32 cryptlen = sreq->c_req.sk_req->cryptlen;
 	struct device *dev = ctx->dev;
@@ -2026,10 +2009,6 @@ static int sec_skcipher_cryptlen_check(struct sec_ctx *ctx,
 		}
 		break;
 	case SEC_CMODE_CTR:
-		if (unlikely(ctx->sec->qm.ver < QM_HW_V3)) {
-			dev_err(dev, "skcipher HW version error!\n");
-			ret = -EINVAL;
-		}
 		break;
 	default:
 		ret = -EINVAL;
@@ -2038,17 +2017,21 @@ static int sec_skcipher_cryptlen_check(struct sec_ctx *ctx,
 	return ret;
 }
 
-static int sec_skcipher_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
+static int sec_skcipher_param_check(struct sec_ctx *ctx,
+				    struct sec_req *sreq, bool *need_fallback)
 {
 	struct skcipher_request *sk_req = sreq->c_req.sk_req;
 	struct device *dev = ctx->dev;
 	u8 c_alg = ctx->c_ctx.c_alg;
 
-	if (unlikely(!sk_req->src || !sk_req->dst ||
-		     sk_req->cryptlen > MAX_INPUT_DATA_LEN)) {
+	if (unlikely(!sk_req->src || !sk_req->dst)) {
 		dev_err(dev, "skcipher input param error!\n");
 		return -EINVAL;
 	}
+
+	if (sk_req->cryptlen > MAX_INPUT_DATA_LEN)
+		*need_fallback = true;
+
 	sreq->c_req.c_len = sk_req->cryptlen;
 
 	if (ctx->pbuf_supported && sk_req->cryptlen <= SEC_PBUF_SZ)
@@ -2106,6 +2089,7 @@ static int sec_skcipher_crypto(struct skcipher_request *sk_req, bool encrypt)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(sk_req);
 	struct sec_req *req = skcipher_request_ctx(sk_req);
 	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+	bool need_fallback = false;
 	int ret;
 
 	if (!sk_req->cryptlen) {
@@ -2119,11 +2103,11 @@ static int sec_skcipher_crypto(struct skcipher_request *sk_req, bool encrypt)
 	req->c_req.encrypt = encrypt;
 	req->ctx = ctx;
 
-	ret = sec_skcipher_param_check(ctx, req);
+	ret = sec_skcipher_param_check(ctx, req, &need_fallback);
 	if (unlikely(ret))
 		return -EINVAL;
 
-	if (unlikely(ctx->c_ctx.fallback))
+	if (unlikely(ctx->c_ctx.fallback || need_fallback))
 		return sec_skcipher_soft_crypto(ctx, sk_req, encrypt);
 
 	return ctx->req_op->process(ctx, req);
@@ -2231,52 +2215,35 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	size_t sz = crypto_aead_authsize(tfm);
 	u8 c_mode = ctx->c_ctx.c_mode;
-	struct device *dev = ctx->dev;
 	int ret;
 
-	/* Hardware does not handle cases where authsize is less than 4 bytes */
-	if (unlikely(sz < MIN_MAC_LEN)) {
-		sreq->aead_req.fallback = true;
+	if (unlikely(ctx->sec->qm.ver == QM_HW_V2 && !sreq->c_req.c_len))
 		return -EINVAL;
-	}
 
 	if (unlikely(req->cryptlen + req->assoclen > MAX_INPUT_DATA_LEN ||
-	    req->assoclen > SEC_MAX_AAD_LEN)) {
-		dev_err(dev, "aead input spec error!\n");
+		     req->assoclen > SEC_MAX_AAD_LEN))
 		return -EINVAL;
-	}
 
 	if (c_mode == SEC_CMODE_CCM) {
-		if (unlikely(req->assoclen > SEC_MAX_CCM_AAD_LEN)) {
-			dev_err_ratelimited(dev, "CCM input aad parameter is too long!\n");
+		if (unlikely(req->assoclen > SEC_MAX_CCM_AAD_LEN))
 			return -EINVAL;
-		}
-		ret = aead_iv_demension_check(req);
-		if (ret) {
-			dev_err(dev, "aead input iv param error!\n");
-			return ret;
-		}
-	}
 
-	if (sreq->c_req.encrypt)
-		sreq->c_req.c_len = req->cryptlen;
-	else
-		sreq->c_req.c_len = req->cryptlen - sz;
-	if (c_mode == SEC_CMODE_CBC) {
-		if (unlikely(sreq->c_req.c_len & (AES_BLOCK_SIZE - 1))) {
-			dev_err(dev, "aead crypto length error!\n");
+		ret = aead_iv_demension_check(req);
+		if (unlikely(ret))
+			return -EINVAL;
+	} else if (c_mode == SEC_CMODE_CBC) {
+		if (unlikely(sz & WORD_MASK))
+			return -EINVAL;
+		if (unlikely(ctx->a_ctx.a_key_len & WORD_MASK))
 			return -EINVAL;
-		}
 	}
 
 	return 0;
 }
 
-static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
+static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq, bool *need_fallback)
 {
 	struct aead_request *req = sreq->aead_req.aead_req;
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	size_t authsize = crypto_aead_authsize(tfm);
 	struct device *dev = ctx->dev;
 	u8 c_alg = ctx->c_ctx.c_alg;
 
@@ -2285,12 +2252,10 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 		return -EINVAL;
 	}
 
-	if (ctx->sec->qm.ver == QM_HW_V2) {
-		if (unlikely(!req->cryptlen || (!sreq->c_req.encrypt &&
-			     req->cryptlen <= authsize))) {
-			sreq->aead_req.fallback = true;
-			return -EINVAL;
-		}
+	if (unlikely(ctx->c_ctx.c_mode == SEC_CMODE_CBC &&
+		     sreq->c_req.c_len & (AES_BLOCK_SIZE - 1))) {
+		dev_err(dev, "aead cbc mode input data length error!\n");
+		return -EINVAL;
 	}
 
 	/* Support AES or SM4 */
@@ -2299,8 +2264,10 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 		return -EINVAL;
 	}
 
-	if (unlikely(sec_aead_spec_check(ctx, sreq)))
+	if (unlikely(sec_aead_spec_check(ctx, sreq))) {
+		*need_fallback = true;
 		return -EINVAL;
+	}
 
 	if (ctx->pbuf_supported && (req->cryptlen + req->assoclen) <=
 		SEC_PBUF_SZ)
@@ -2344,17 +2311,19 @@ static int sec_aead_crypto(struct aead_request *a_req, bool encrypt)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(a_req);
 	struct sec_req *req = aead_request_ctx(a_req);
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
+	size_t sz = crypto_aead_authsize(tfm);
+	bool need_fallback = false;
 	int ret;
 
 	req->flag = a_req->base.flags;
 	req->aead_req.aead_req = a_req;
 	req->c_req.encrypt = encrypt;
 	req->ctx = ctx;
-	req->aead_req.fallback = false;
+	req->c_req.c_len = a_req->cryptlen - (req->c_req.encrypt ? 0 : sz);
 
-	ret = sec_aead_param_check(ctx, req);
+	ret = sec_aead_param_check(ctx, req, &need_fallback);
 	if (unlikely(ret)) {
-		if (req->aead_req.fallback)
+		if (need_fallback)
 			return sec_aead_soft_crypto(ctx, a_req, encrypt);
 		return -EINVAL;
 	}
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index d2f07e34f314..e1f60f0f507c 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1527,7 +1527,7 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	iaa_wq = idxd_wq_get_private(wq);
 
 	if (!req->dst) {
-		gfp_t flags = req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
+		gfp_t flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
 
 		/* incompressible data will always be < 2 * slen */
 		req->dlen = 2 * req->slen;
@@ -1609,7 +1609,7 @@ static int iaa_comp_acompress(struct acomp_req *req)
 
 static int iaa_comp_adecompress_alloc_dest(struct acomp_req *req)
 {
-	gfp_t flags = req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	gfp_t flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
 		GFP_KERNEL : GFP_ATOMIC;
 	struct crypto_tfm *tfm = req->base.tfm;
 	dma_addr_t src_addr, dst_addr;
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index 9faef33e54bd..a17adc4beda2 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -420,6 +420,7 @@ static void adf_gen4_set_err_mask(struct adf_dev_err_mask *dev_err_mask)
 	dev_err_mask->parerr_cpr_xlt_mask = ADF_420XX_PARITYERRORMASK_CPR_XLT_MASK;
 	dev_err_mask->parerr_dcpr_ucs_mask = ADF_420XX_PARITYERRORMASK_DCPR_UCS_MASK;
 	dev_err_mask->parerr_pke_mask = ADF_420XX_PARITYERRORMASK_PKE_MASK;
+	dev_err_mask->parerr_wat_wcp_mask = ADF_420XX_PARITYERRORMASK_WAT_WCP_MASK;
 	dev_err_mask->ssmfeatren_mask = ADF_420XX_SSMFEATREN_MASK;
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
index 2dd3772bf58a..0f7f00a19e7d 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
@@ -695,7 +695,7 @@ static bool adf_handle_slice_hang_error(struct adf_accel_dev *accel_dev,
 	if (err_mask->parerr_wat_wcp_mask)
 		adf_poll_slicehang_csr(accel_dev, csr,
 				       ADF_GEN4_SLICEHANGSTATUS_WAT_WCP,
-				       "ath_cph");
+				       "wat_wcp");
 
 	return false;
 }
@@ -1043,63 +1043,16 @@ static bool adf_handle_ssmcpppar_err(struct adf_accel_dev *accel_dev,
 	return reset_required;
 }
 
-static bool adf_handle_rf_parr_err(struct adf_accel_dev *accel_dev,
+static void adf_handle_rf_parr_err(struct adf_accel_dev *accel_dev,
 				   void __iomem *csr, u32 iastatssm)
 {
-	struct adf_dev_err_mask *err_mask = GET_ERR_MASK(accel_dev);
-	u32 reg;
-
 	if (!(iastatssm & ADF_GEN4_IAINTSTATSSM_SSMSOFTERRORPARITY_BIT))
-		return false;
-
-	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_SRC);
-	reg &= ADF_GEN4_SSMSOFTERRORPARITY_SRC_BIT;
-	if (reg) {
-		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
-		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_SRC, reg);
-	}
-
-	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_ATH_CPH);
-	reg &= err_mask->parerr_ath_cph_mask;
-	if (reg) {
-		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
-		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_ATH_CPH, reg);
-	}
-
-	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_CPR_XLT);
-	reg &= err_mask->parerr_cpr_xlt_mask;
-	if (reg) {
-		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
-		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_CPR_XLT, reg);
-	}
-
-	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_DCPR_UCS);
-	reg &= err_mask->parerr_dcpr_ucs_mask;
-	if (reg) {
-		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
-		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_DCPR_UCS, reg);
-	}
-
-	reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_PKE);
-	reg &= err_mask->parerr_pke_mask;
-	if (reg) {
-		ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
-		ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_PKE, reg);
-	}
-
-	if (err_mask->parerr_wat_wcp_mask) {
-		reg = ADF_CSR_RD(csr, ADF_GEN4_SSMSOFTERRORPARITY_WAT_WCP);
-		reg &= err_mask->parerr_wat_wcp_mask;
-		if (reg) {
-			ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
-			ADF_CSR_WR(csr, ADF_GEN4_SSMSOFTERRORPARITY_WAT_WCP,
-				   reg);
-		}
-	}
+		return;
 
+	ADF_RAS_ERR_CTR_INC(accel_dev->ras_errors, ADF_RAS_UNCORR);
 	dev_err(&GET_DEV(accel_dev), "Slice ssm soft parity error reported");
 
-	return false;
+	return;
 }
 
 static bool adf_handle_ser_err_ssmsh(struct adf_accel_dev *accel_dev,
@@ -1171,8 +1124,8 @@ static bool adf_handle_iaintstatssm(struct adf_accel_dev *accel_dev,
 	reset_required |= adf_handle_slice_hang_error(accel_dev, csr, iastatssm);
 	reset_required |= adf_handle_spppar_err(accel_dev, csr, iastatssm);
 	reset_required |= adf_handle_ssmcpppar_err(accel_dev, csr, iastatssm);
-	reset_required |= adf_handle_rf_parr_err(accel_dev, csr, iastatssm);
 	reset_required |= adf_handle_ser_err_ssmsh(accel_dev, csr, iastatssm);
+	adf_handle_rf_parr_err(accel_dev, csr, iastatssm);
 
 	ADF_CSR_WR(csr, ADF_GEN4_IAINTSTATSSM, iastatssm);
 
diff --git a/drivers/crypto/nx/nx-common-pseries.c b/drivers/crypto/nx/nx-common-pseries.c
index 35f2d0d8507e..7e98f174f69b 100644
--- a/drivers/crypto/nx/nx-common-pseries.c
+++ b/drivers/crypto/nx/nx-common-pseries.c
@@ -1144,6 +1144,7 @@ static void __init nxcop_get_capabilities(void)
 {
 	struct hv_vas_all_caps *hv_caps;
 	struct hv_nx_cop_caps *hv_nxc;
+	u64 feat;
 	int rc;
 
 	hv_caps = kmalloc(sizeof(*hv_caps), GFP_KERNEL);
@@ -1154,27 +1155,26 @@ static void __init nxcop_get_capabilities(void)
 	 */
 	rc = h_query_vas_capabilities(H_QUERY_NX_CAPABILITIES, 0,
 					  (u64)virt_to_phys(hv_caps));
+	if (!rc)
+		feat = be64_to_cpu(hv_caps->feat_type);
+	kfree(hv_caps);
 	if (rc)
-		goto out;
+		return;
+	if (!(feat & VAS_NX_GZIP_FEAT_BIT))
+		return;
 
-	caps_feat = be64_to_cpu(hv_caps->feat_type);
 	/*
 	 * NX-GZIP feature available
 	 */
-	if (caps_feat & VAS_NX_GZIP_FEAT_BIT) {
-		hv_nxc = kmalloc(sizeof(*hv_nxc), GFP_KERNEL);
-		if (!hv_nxc)
-			goto out;
-		/*
-		 * Get capabilities for NX-GZIP feature
-		 */
-		rc = h_query_vas_capabilities(H_QUERY_NX_CAPABILITIES,
-						  VAS_NX_GZIP_FEAT,
-						  (u64)virt_to_phys(hv_nxc));
-	} else {
-		pr_err("NX-GZIP feature is not available\n");
-		rc = -EINVAL;
-	}
+	hv_nxc = kmalloc(sizeof(*hv_nxc), GFP_KERNEL);
+	if (!hv_nxc)
+		return;
+	/*
+	 * Get capabilities for NX-GZIP feature
+	 */
+	rc = h_query_vas_capabilities(H_QUERY_NX_CAPABILITIES,
+					  VAS_NX_GZIP_FEAT,
+					  (u64)virt_to_phys(hv_nxc));
 
 	if (!rc) {
 		nx_cop_caps.descriptor = be64_to_cpu(hv_nxc->descriptor);
@@ -1184,13 +1184,10 @@ static void __init nxcop_get_capabilities(void)
 				be64_to_cpu(hv_nxc->min_compress_len);
 		nx_cop_caps.min_decompress_len =
 				be64_to_cpu(hv_nxc->min_decompress_len);
-	} else {
-		caps_feat = 0;
+		caps_feat = feat;
 	}
 
 	kfree(hv_nxc);
-out:
-	kfree(hv_caps);
 }
 
 static const struct vio_device_id nx842_vio_driver_ids[] = {
diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/tegra-se-aes.c
index 3106fd1e84b9..0ed0515e1ed5 100644
--- a/drivers/crypto/tegra/tegra-se-aes.c
+++ b/drivers/crypto/tegra/tegra-se-aes.c
@@ -282,7 +282,7 @@ static int tegra_aes_do_one_req(struct crypto_engine *engine, void *areq)
 
 	/* Prepare the command and submit for execution */
 	cmdlen = tegra_aes_prep_cmd(ctx, rctx);
-	ret = tegra_se_host1x_submit(se, cmdlen);
+	ret = tegra_se_host1x_submit(se, se->cmdbuf, cmdlen);
 
 	/* Copy the result */
 	tegra_aes_update_iv(req, ctx);
@@ -443,6 +443,9 @@ static int tegra_aes_crypt(struct skcipher_request *req, bool encrypt)
 	if (!req->cryptlen)
 		return 0;
 
+	if (ctx->alg == SE_ALG_ECB)
+		req->iv = NULL;
+
 	rctx->encrypt = encrypt;
 	rctx->config = tegra234_aes_cfg(ctx->alg, encrypt);
 	rctx->crypto_config = tegra234_aes_crypto_cfg(ctx->alg, encrypt);
@@ -719,7 +722,7 @@ static int tegra_gcm_do_gmac(struct tegra_aead_ctx *ctx, struct tegra_aead_reqct
 
 	cmdlen = tegra_gmac_prep_cmd(ctx, rctx);
 
-	return tegra_se_host1x_submit(se, cmdlen);
+	return tegra_se_host1x_submit(se, se->cmdbuf, cmdlen);
 }
 
 static int tegra_gcm_do_crypt(struct tegra_aead_ctx *ctx, struct tegra_aead_reqctx *rctx)
@@ -736,7 +739,7 @@ static int tegra_gcm_do_crypt(struct tegra_aead_ctx *ctx, struct tegra_aead_reqc
 
 	/* Prepare command and submit */
 	cmdlen = tegra_gcm_crypt_prep_cmd(ctx, rctx);
-	ret = tegra_se_host1x_submit(se, cmdlen);
+	ret = tegra_se_host1x_submit(se, se->cmdbuf, cmdlen);
 	if (ret)
 		return ret;
 
@@ -759,7 +762,7 @@ static int tegra_gcm_do_final(struct tegra_aead_ctx *ctx, struct tegra_aead_reqc
 
 	/* Prepare command and submit */
 	cmdlen = tegra_gcm_prep_final_cmd(se, cpuvaddr, rctx);
-	ret = tegra_se_host1x_submit(se, cmdlen);
+	ret = tegra_se_host1x_submit(se, se->cmdbuf, cmdlen);
 	if (ret)
 		return ret;
 
@@ -891,7 +894,7 @@ static int tegra_ccm_do_cbcmac(struct tegra_aead_ctx *ctx, struct tegra_aead_req
 	/* Prepare command and submit */
 	cmdlen = tegra_cbcmac_prep_cmd(ctx, rctx);
 
-	return tegra_se_host1x_submit(se, cmdlen);
+	return tegra_se_host1x_submit(se, se->cmdbuf, cmdlen);
 }
 
 static int tegra_ccm_set_msg_len(u8 *block, unsigned int msglen, int csize)
@@ -1098,7 +1101,7 @@ static int tegra_ccm_do_ctr(struct tegra_aead_ctx *ctx, struct tegra_aead_reqctx
 
 	/* Prepare command and submit */
 	cmdlen = tegra_ctr_prep_cmd(ctx, rctx);
-	ret = tegra_se_host1x_submit(se, cmdlen);
+	ret = tegra_se_host1x_submit(se, se->cmdbuf, cmdlen);
 	if (ret)
 		return ret;
 
@@ -1513,23 +1516,16 @@ static int tegra_cmac_do_update(struct ahash_request *req)
 	rctx->residue.size = nresidue;
 
 	/*
-	 * If this is not the first 'update' call, paste the previous copied
+	 * If this is not the first task, paste the previous copied
 	 * intermediate results to the registers so that it gets picked up.
-	 * This is to support the import/export functionality.
 	 */
 	if (!(rctx->task & SHA_FIRST))
 		tegra_cmac_paste_result(ctx->se, rctx);
 
 	cmdlen = tegra_cmac_prep_cmd(ctx, rctx);
+	ret = tegra_se_host1x_submit(se, se->cmdbuf, cmdlen);
 
-	ret = tegra_se_host1x_submit(se, cmdlen);
-	/*
-	 * If this is not the final update, copy the intermediate results
-	 * from the registers so that it can be used in the next 'update'
-	 * call. This is to support the import/export functionality.
-	 */
-	if (!(rctx->task & SHA_FINAL))
-		tegra_cmac_copy_result(ctx->se, rctx);
+	tegra_cmac_copy_result(ctx->se, rctx);
 
 	return ret;
 }
@@ -1553,9 +1549,16 @@ static int tegra_cmac_do_final(struct ahash_request *req)
 	rctx->total_len += rctx->residue.size;
 	rctx->config = tegra234_aes_cfg(SE_ALG_CMAC, 0);
 
+	/*
+	 * If this is not the first task, paste the previous copied
+	 * intermediate results to the registers so that it gets picked up.
+	 */
+	if (!(rctx->task & SHA_FIRST))
+		tegra_cmac_paste_result(ctx->se, rctx);
+
 	/* Prepare command and submit */
 	cmdlen = tegra_cmac_prep_cmd(ctx, rctx);
-	ret = tegra_se_host1x_submit(se, cmdlen);
+	ret = tegra_se_host1x_submit(se, se->cmdbuf, cmdlen);
 	if (ret)
 		goto out;
 
@@ -1581,18 +1584,24 @@ static int tegra_cmac_do_one_req(struct crypto_engine *engine, void *areq)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct tegra_cmac_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct tegra_se *se = ctx->se;
-	int ret;
+	int ret = 0;
 
 	if (rctx->task & SHA_UPDATE) {
 		ret = tegra_cmac_do_update(req);
+		if (ret)
+			goto out;
+
 		rctx->task &= ~SHA_UPDATE;
 	}
 
 	if (rctx->task & SHA_FINAL) {
 		ret = tegra_cmac_do_final(req);
+		if (ret)
+			goto out;
+
 		rctx->task &= ~SHA_FINAL;
 	}
-
+out:
 	crypto_finalize_hash_request(se->engine, req, ret);
 
 	return 0;
diff --git a/drivers/crypto/tegra/tegra-se-hash.c b/drivers/crypto/tegra/tegra-se-hash.c
index 0b5cdd5676b1..726e30c0e63e 100644
--- a/drivers/crypto/tegra/tegra-se-hash.c
+++ b/drivers/crypto/tegra/tegra-se-hash.c
@@ -300,8 +300,9 @@ static int tegra_sha_do_update(struct ahash_request *req)
 {
 	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
 	struct tegra_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct tegra_se *se = ctx->se;
 	unsigned int nblks, nresidue, size, ret;
-	u32 *cpuvaddr = ctx->se->cmdbuf->addr;
+	u32 *cpuvaddr = se->cmdbuf->addr;
 
 	nresidue = (req->nbytes + rctx->residue.size) % rctx->blk_size;
 	nblks = (req->nbytes + rctx->residue.size) / rctx->blk_size;
@@ -353,11 +354,11 @@ static int tegra_sha_do_update(struct ahash_request *req)
 	 * This is to support the import/export functionality.
 	 */
 	if (!(rctx->task & SHA_FIRST))
-		tegra_sha_paste_hash_result(ctx->se, rctx);
+		tegra_sha_paste_hash_result(se, rctx);
 
-	size = tegra_sha_prep_cmd(ctx->se, cpuvaddr, rctx);
+	size = tegra_sha_prep_cmd(se, cpuvaddr, rctx);
 
-	ret = tegra_se_host1x_submit(ctx->se, size);
+	ret = tegra_se_host1x_submit(se, se->cmdbuf, size);
 
 	/*
 	 * If this is not the final update, copy the intermediate results
@@ -365,7 +366,7 @@ static int tegra_sha_do_update(struct ahash_request *req)
 	 * call. This is to support the import/export functionality.
 	 */
 	if (!(rctx->task & SHA_FINAL))
-		tegra_sha_copy_hash_result(ctx->se, rctx);
+		tegra_sha_copy_hash_result(se, rctx);
 
 	return ret;
 }
@@ -388,7 +389,7 @@ static int tegra_sha_do_final(struct ahash_request *req)
 
 	size = tegra_sha_prep_cmd(se, cpuvaddr, rctx);
 
-	ret = tegra_se_host1x_submit(se, size);
+	ret = tegra_se_host1x_submit(se, se->cmdbuf, size);
 	if (ret)
 		goto out;
 
@@ -416,14 +417,21 @@ static int tegra_sha_do_one_req(struct crypto_engine *engine, void *areq)
 
 	if (rctx->task & SHA_UPDATE) {
 		ret = tegra_sha_do_update(req);
+		if (ret)
+			goto out;
+
 		rctx->task &= ~SHA_UPDATE;
 	}
 
 	if (rctx->task & SHA_FINAL) {
 		ret = tegra_sha_do_final(req);
+		if (ret)
+			goto out;
+
 		rctx->task &= ~SHA_FINAL;
 	}
 
+out:
 	crypto_finalize_hash_request(se->engine, req, ret);
 
 	return 0;
@@ -559,13 +567,18 @@ static int tegra_hmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 			     unsigned int keylen)
 {
 	struct tegra_sha_ctx *ctx = crypto_ahash_ctx(tfm);
+	int ret;
 
 	if (aes_check_keylen(keylen))
 		return tegra_hmac_fallback_setkey(ctx, key, keylen);
 
+	ret = tegra_key_submit(ctx->se, key, keylen, ctx->alg, &ctx->key_id);
+	if (ret)
+		return tegra_hmac_fallback_setkey(ctx, key, keylen);
+
 	ctx->fallback = false;
 
-	return tegra_key_submit(ctx->se, key, keylen, ctx->alg, &ctx->key_id);
+	return 0;
 }
 
 static int tegra_sha_update(struct ahash_request *req)
diff --git a/drivers/crypto/tegra/tegra-se-key.c b/drivers/crypto/tegra/tegra-se-key.c
index ac14678dbd30..276b261fb6df 100644
--- a/drivers/crypto/tegra/tegra-se-key.c
+++ b/drivers/crypto/tegra/tegra-se-key.c
@@ -115,11 +115,17 @@ static int tegra_key_insert(struct tegra_se *se, const u8 *key,
 			    u32 keylen, u16 slot, u32 alg)
 {
 	const u32 *keyval = (u32 *)key;
-	u32 *addr = se->cmdbuf->addr, size;
+	u32 *addr = se->keybuf->addr, size;
+	int ret;
+
+	mutex_lock(&kslt_lock);
 
 	size = tegra_key_prep_ins_cmd(se, addr, keyval, keylen, slot, alg);
+	ret = tegra_se_host1x_submit(se, se->keybuf, size);
 
-	return tegra_se_host1x_submit(se, size);
+	mutex_unlock(&kslt_lock);
+
+	return ret;
 }
 
 void tegra_key_invalidate(struct tegra_se *se, u32 keyid, u32 alg)
diff --git a/drivers/crypto/tegra/tegra-se-main.c b/drivers/crypto/tegra/tegra-se-main.c
index f94c0331b148..55690b044e41 100644
--- a/drivers/crypto/tegra/tegra-se-main.c
+++ b/drivers/crypto/tegra/tegra-se-main.c
@@ -141,7 +141,7 @@ static struct tegra_se_cmdbuf *tegra_se_host1x_bo_alloc(struct tegra_se *se, ssi
 	return cmdbuf;
 }
 
-int tegra_se_host1x_submit(struct tegra_se *se, u32 size)
+int tegra_se_host1x_submit(struct tegra_se *se, struct tegra_se_cmdbuf *cmdbuf, u32 size)
 {
 	struct host1x_job *job;
 	int ret;
@@ -160,9 +160,9 @@ int tegra_se_host1x_submit(struct tegra_se *se, u32 size)
 	job->engine_fallback_streamid = se->stream_id;
 	job->engine_streamid_offset = SE_STREAM_ID;
 
-	se->cmdbuf->words = size;
+	cmdbuf->words = size;
 
-	host1x_job_add_gather(job, &se->cmdbuf->bo, size, 0);
+	host1x_job_add_gather(job, &cmdbuf->bo, size, 0);
 
 	ret = host1x_job_pin(job, se->dev);
 	if (ret) {
@@ -220,14 +220,22 @@ static int tegra_se_client_init(struct host1x_client *client)
 		goto syncpt_put;
 	}
 
+	se->keybuf = tegra_se_host1x_bo_alloc(se, SZ_4K);
+	if (!se->keybuf) {
+		ret = -ENOMEM;
+		goto cmdbuf_put;
+	}
+
 	ret = se->hw->init_alg(se);
 	if (ret) {
 		dev_err(se->dev, "failed to register algorithms\n");
-		goto cmdbuf_put;
+		goto keybuf_put;
 	}
 
 	return 0;
 
+keybuf_put:
+	tegra_se_cmdbuf_put(&se->keybuf->bo);
 cmdbuf_put:
 	tegra_se_cmdbuf_put(&se->cmdbuf->bo);
 syncpt_put:
diff --git a/drivers/crypto/tegra/tegra-se.h b/drivers/crypto/tegra/tegra-se.h
index b9dd7ceb8783..b54aefe717a1 100644
--- a/drivers/crypto/tegra/tegra-se.h
+++ b/drivers/crypto/tegra/tegra-se.h
@@ -420,6 +420,7 @@ struct tegra_se {
 	struct host1x_client client;
 	struct host1x_channel *channel;
 	struct tegra_se_cmdbuf *cmdbuf;
+	struct tegra_se_cmdbuf *keybuf;
 	struct crypto_engine *engine;
 	struct host1x_syncpt *syncpt;
 	struct device *dev;
@@ -502,7 +503,7 @@ void tegra_deinit_hash(struct tegra_se *se);
 int tegra_key_submit(struct tegra_se *se, const u8 *key,
 		     u32 keylen, u32 alg, u32 *keyid);
 void tegra_key_invalidate(struct tegra_se *se, u32 keyid, u32 alg);
-int tegra_se_host1x_submit(struct tegra_se *se, u32 size);
+int tegra_se_host1x_submit(struct tegra_se *se, struct tegra_se_cmdbuf *cmdbuf, u32 size);
 
 /* HOST1x OPCODES */
 static inline u32 host1x_opcode_setpayload(unsigned int payload)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 70cb7fda757a..27645606f900 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -303,6 +303,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 
 		/* The last IRQ is for eDMA err */
 		if (i == count - 1) {
+			fsl_edma->errirq = irq;
 			ret = devm_request_irq(&pdev->dev, irq,
 						fsl_edma_err_handler,
 						0, "eDMA2-ERR", fsl_edma);
@@ -322,10 +323,13 @@ static void fsl_edma_irq_exit(
 		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
 	if (fsl_edma->txirq == fsl_edma->errirq) {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+		if (fsl_edma->txirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
 	} else {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
+		if (fsl_edma->txirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+		if (fsl_edma->errirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
 	}
 }
 
@@ -513,6 +517,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!fsl_edma)
 		return -ENOMEM;
 
+	fsl_edma->errirq = -EINVAL;
+	fsl_edma->txirq = -EINVAL;
 	fsl_edma->drvdata = drvdata;
 	fsl_edma->n_chans = chans;
 	mutex_init(&fsl_edma->fsl_edma_mutex);
@@ -699,9 +705,9 @@ static void fsl_edma_remove(struct platform_device *pdev)
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
+	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 }
 
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 51556c72a967..fbdf005bed3a 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -751,6 +751,8 @@ static int i10nm_get_ddr_munits(void)
 				continue;
 			} else {
 				d->imc[lmc].mdev = mdev;
+				if (res_cfg->type == SPR)
+					skx_set_mc_mapping(d, i, lmc);
 				lmc++;
 			}
 		}
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 9ef13570f2e5..56be8ef40f37 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -91,8 +91,6 @@
 	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
 	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
 
-#define IE31200_DIMMS			4
-#define IE31200_RANKS			8
 #define IE31200_RANKS_PER_CHANNEL	4
 #define IE31200_DIMMS_PER_CHANNEL	2
 #define IE31200_CHANNELS		2
@@ -164,6 +162,7 @@
 #define IE31200_MAD_DIMM_0_OFFSET		0x5004
 #define IE31200_MAD_DIMM_0_OFFSET_SKL		0x500C
 #define IE31200_MAD_DIMM_SIZE			GENMASK_ULL(7, 0)
+#define IE31200_MAD_DIMM_SIZE_SKL		GENMASK_ULL(5, 0)
 #define IE31200_MAD_DIMM_A_RANK			BIT(17)
 #define IE31200_MAD_DIMM_A_RANK_SHIFT		17
 #define IE31200_MAD_DIMM_A_RANK_SKL		BIT(10)
@@ -377,7 +376,7 @@ static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev)
 static void __skl_populate_dimm_info(struct dimm_data *dd, u32 addr_decode,
 				     int chan)
 {
-	dd->size = (addr_decode >> (chan << 4)) & IE31200_MAD_DIMM_SIZE;
+	dd->size = (addr_decode >> (chan << 4)) & IE31200_MAD_DIMM_SIZE_SKL;
 	dd->dual_rank = (addr_decode & (IE31200_MAD_DIMM_A_RANK_SKL << (chan << 4))) ? 1 : 0;
 	dd->x16_width = ((addr_decode & (IE31200_MAD_DIMM_A_WIDTH_SKL << (chan << 4))) >>
 				(IE31200_MAD_DIMM_A_WIDTH_SKL_SHIFT + (chan << 4)));
@@ -426,7 +425,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 
 	nr_channels = how_many_channels(pdev);
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = IE31200_DIMMS;
+	layers[0].size = IE31200_RANKS_PER_CHANNEL;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = nr_channels;
@@ -618,7 +617,7 @@ static int __init ie31200_init(void)
 
 	pci_rc = pci_register_driver(&ie31200_driver);
 	if (pci_rc < 0)
-		goto fail0;
+		return pci_rc;
 
 	if (!mci_pdev) {
 		ie31200_registered = 0;
@@ -629,11 +628,13 @@ static int __init ie31200_init(void)
 			if (mci_pdev)
 				break;
 		}
+
 		if (!mci_pdev) {
 			edac_dbg(0, "ie31200 pci_get_device fail\n");
 			pci_rc = -ENODEV;
-			goto fail1;
+			goto fail0;
 		}
+
 		pci_rc = ie31200_init_one(mci_pdev, &ie31200_pci_tbl[i]);
 		if (pci_rc < 0) {
 			edac_dbg(0, "ie31200 init fail\n");
@@ -641,12 +642,12 @@ static int __init ie31200_init(void)
 			goto fail1;
 		}
 	}
-	return 0;
 
+	return 0;
 fail1:
-	pci_unregister_driver(&ie31200_driver);
-fail0:
 	pci_dev_put(mci_pdev);
+fail0:
+	pci_unregister_driver(&ie31200_driver);
 
 	return pci_rc;
 }
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 6cf17af7d911..85ec3196664d 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -120,6 +120,35 @@ void skx_adxl_put(void)
 }
 EXPORT_SYMBOL_GPL(skx_adxl_put);
 
+static void skx_init_mc_mapping(struct skx_dev *d)
+{
+	/*
+	 * By default, the BIOS presents all memory controllers within each
+	 * socket to the EDAC driver. The physical indices are the same as
+	 * the logical indices of the memory controllers enumerated by the
+	 * EDAC driver.
+	 */
+	for (int i = 0; i < NUM_IMC; i++)
+		d->mc_mapping[i] = i;
+}
+
+void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc)
+{
+	edac_dbg(0, "Set the mapping of mc phy idx to logical idx: %02d -> %02d\n",
+		 pmc, lmc);
+
+	d->mc_mapping[pmc] = lmc;
+}
+EXPORT_SYMBOL_GPL(skx_set_mc_mapping);
+
+static u8 skx_get_mc_mapping(struct skx_dev *d, u8 pmc)
+{
+	edac_dbg(0, "Get the mapping of mc phy idx to logical idx: %02d -> %02d\n",
+		 pmc, d->mc_mapping[pmc]);
+
+	return d->mc_mapping[pmc];
+}
+
 static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 {
 	struct skx_dev *d;
@@ -187,6 +216,8 @@ static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 		return false;
 	}
 
+	res->imc = skx_get_mc_mapping(d, res->imc);
+
 	for (i = 0; i < adxl_component_count; i++) {
 		if (adxl_values[i] == ~0x0ull)
 			continue;
@@ -307,6 +338,8 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list)
 			 d->bus[0], d->bus[1], d->bus[2], d->bus[3]);
 		list_add_tail(&d->list, &dev_edac_list);
 		prev = pdev;
+
+		skx_init_mc_mapping(d);
 	}
 
 	if (list)
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 54bba8a62f72..849198fd14da 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -93,6 +93,16 @@ struct skx_dev {
 	struct pci_dev *uracu; /* for i10nm CPU */
 	struct pci_dev *pcu_cr3; /* for HBM memory detection */
 	u32 mcroute;
+	/*
+	 * Some server BIOS may hide certain memory controllers, and the
+	 * EDAC driver skips those hidden memory controllers. However, the
+	 * ADXL still decodes memory error address using physical memory
+	 * controller indices. The mapping table is used to convert the
+	 * physical indices (reported by ADXL) to the logical indices
+	 * (used the EDAC driver) of present memory controllers during the
+	 * error handling process.
+	 */
+	u8 mc_mapping[NUM_IMC];
 	struct skx_imc {
 		struct mem_ctl_info *mci;
 		struct pci_dev *mdev; /* for i10nm CPU */
@@ -242,6 +252,7 @@ void skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 void skx_set_mem_cfg(bool mem_cfg_2lm);
 void skx_set_res_cfg(struct res_config *cfg);
+void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index bd1ea99c3b47..ea452f190854 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1631,6 +1631,7 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 
 	cs_dsp_debugfs_save_wmfwname(dsp, file);
 
+	ret = 0;
 out_fw:
 	cs_dsp_buf_free(&buf_list);
 
@@ -2338,6 +2339,7 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 
 	cs_dsp_debugfs_save_binname(dsp, file);
 
+	ret = 0;
 out_fw:
 	cs_dsp_buf_free(&buf_list);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 32afcf948524..7978d5189c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2633,7 +2633,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
 
 	adev->in_s4 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
-	adev->in_s4 = false;
 	if (r)
 		return r;
 
@@ -2645,8 +2644,13 @@ static int amdgpu_pmops_freeze(struct device *dev)
 static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	r = amdgpu_device_resume(drm_dev, true);
+	adev->in_s4 = false;
+
+	return r;
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
@@ -2659,6 +2663,9 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	adev->in_s4 = false;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 6162582d0aa2..d5125523bfa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -584,7 +584,7 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
 		fw_name = "amdgpu/umsch_mm_4_0_0.bin";
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, "%s", fw_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d3e8be82a172..84cf5fd297b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1549,7 +1549,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
-		adev->gfx.mec.num_mec = 2;
+		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d3798a333d1f..b259e217930c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1332,7 +1332,7 @@ static int gfx_v12_0_sw_init(void *handle)
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
-		adev->gfx.mec.num_mec = 2;
+		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 2;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 05d1ae2ef84b..114653a0b570 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1269,6 +1269,7 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 	adev->gfx.mec_fw_write_wait = false;
 
 	if ((amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 1)) &&
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 2)) &&
 	    ((adev->gfx.mec_fw_version < 0x000001a5) ||
 	     (adev->gfx.mec_feature_version < 46) ||
 	     (adev->gfx.pfp_fw_version < 0x000000b7) ||
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index dffe2a86f383..951b87e7e3f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -205,21 +205,6 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
-	if (!pdd->proc_ctx_cpu_ptr) {
-		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
-				AMDGPU_MES_PROC_CTX_SIZE,
-				&pdd->proc_ctx_bo,
-				&pdd->proc_ctx_gpu_addr,
-				&pdd->proc_ctx_cpu_ptr,
-				false);
-		if (r) {
-			dev_err(adev->dev,
-				"failed to allocate process context bo\n");
-			return r;
-		}
-		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
-	}
-
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
 	queue_input.process_id = qpd->pqm->process->pasid;
 	queue_input.page_table_base_addr =  qpd->page_table_base;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 42fd7669ac7d..ac777244ee0a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -361,10 +361,26 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	if (retval != 0)
 		return retval;
 
+	/* Register process if this is the first queue */
 	if (list_empty(&pdd->qpd.queues_list) &&
 	    list_empty(&pdd->qpd.priv_queue_list))
 		dev->dqm->ops.register_process(dev->dqm, &pdd->qpd);
 
+	/* Allocate proc_ctx_bo only if MES is enabled and this is the first queue */
+	if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes) {
+		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
+						     AMDGPU_MES_PROC_CTX_SIZE,
+						     &pdd->proc_ctx_bo,
+						     &pdd->proc_ctx_gpu_addr,
+						     &pdd->proc_ctx_cpu_ptr,
+						     false);
+		if (retval) {
+			dev_err(dev->adev->dev, "failed to allocate process context bo\n");
+			return retval;
+		}
+		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+	}
+
 	pqn = kzalloc(sizeof(*pqn), GFP_KERNEL);
 	if (!pqn) {
 		retval = -ENOMEM;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c4c6538eabae..260b6b8d29fd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3306,6 +3306,11 @@ static int dm_resume(void *handle)
 
 		return 0;
 	}
+
+	/* leave display off for S4 sequence */
+	if (adev->in_s4)
+		return 0;
+
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
 	dc_state_release(dm_state->context);
 	dm_state->context = dc_state_create(dm->dc, NULL);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 6e2fce329d73..d37ecfdde4f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -63,6 +63,10 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 
 bool should_use_dmub_lock(struct dc_link *link)
 {
+	/* ASIC doesn't support DMUB */
+	if (!link->ctx->dmub_srv)
+		return false;
+
 	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 1c10ba4dcdde..abe51cf3aab2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -281,10 +281,10 @@ static void CalculateDynamicMetadataParameters(
 		double DISPCLK,
 		double DCFClkDeepSleep,
 		double PixelClock,
-		long HTotal,
-		long VBlank,
-		long DynamicMetadataTransmittedBytes,
-		long DynamicMetadataLinesBeforeActiveRequired,
+		unsigned int HTotal,
+		unsigned int VBlank,
+		unsigned int DynamicMetadataTransmittedBytes,
+		int DynamicMetadataLinesBeforeActiveRequired,
 		int InterlaceEnable,
 		bool ProgressiveToInterlaceUnitInOPP,
 		double *Tsetup,
@@ -3277,8 +3277,8 @@ static double CalculateWriteBackDelay(
 
 
 static void CalculateDynamicMetadataParameters(int MaxInterDCNTileRepeaters, double DPPCLK, double DISPCLK,
-		double DCFClkDeepSleep, double PixelClock, long HTotal, long VBlank, long DynamicMetadataTransmittedBytes,
-		long DynamicMetadataLinesBeforeActiveRequired, int InterlaceEnable, bool ProgressiveToInterlaceUnitInOPP,
+		double DCFClkDeepSleep, double PixelClock, unsigned int HTotal, unsigned int VBlank, unsigned int DynamicMetadataTransmittedBytes,
+		int DynamicMetadataLinesBeforeActiveRequired, int InterlaceEnable, bool ProgressiveToInterlaceUnitInOPP,
 		double *Tsetup, double *Tdmbf, double *Tdmec, double *Tdmsks)
 {
 	double TotalRepeaterDelayTime = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 0aa4e4d343b0..2c1316d1b6eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -139,9 +139,8 @@ bool core_dcn4_initialize(struct dml2_core_initialize_in_out *in_out)
 		core->clean_me_up.mode_lib.ip.subvp_fw_processing_delay_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
 		core->clean_me_up.mode_lib.ip.subvp_swath_height_margin_lines = core_dcn4_ip_caps_base.subvp_swath_height_margin_lines;
 	} else {
-			memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn4_ip_caps_base, sizeof(struct dml2_core_ip_params));
+		memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn4_ip_caps_base, sizeof(struct dml2_core_ip_params));
 		patch_ip_params_with_ip_caps(&core->clean_me_up.mode_lib.ip, in_out->ip_caps);
-
 		core->clean_me_up.mode_lib.ip.imall_supported = false;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 0d71db7be325..0ce1766c859f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -459,8 +459,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	}
 	if (read_arg) {
 		smu_cmn_read_arg(smu, read_arg);
-		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x,\
-			readval: 0x%08x\n",
+		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x, readval: 0x%08x\n",
 			smu_get_message_name(smu, msg), index, param, reg, *read_arg);
 	} else {
 		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x\n",
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 41f72d458487..9ba2a667a1f3 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2463,9 +2463,9 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	if (!mhdp)
 		return -ENOMEM;
 
-	clk = devm_clk_get(dev, NULL);
+	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
-		dev_err(dev, "couldn't get clk: %ld\n", PTR_ERR(clk));
+		dev_err(dev, "couldn't get and enable clk: %ld\n", PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
 
@@ -2504,14 +2504,12 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 
 	mhdp->info = of_device_get_match_data(dev);
 
-	clk_prepare_enable(clk);
-
 	pm_runtime_enable(dev);
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm_runtime_resume_and_get failed\n");
 		pm_runtime_disable(dev);
-		goto clk_disable;
+		return ret;
 	}
 
 	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->init) {
@@ -2590,8 +2588,6 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 runtime_put:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-clk_disable:
-	clk_disable_unprepare(mhdp->clk);
 
 	return ret;
 }
@@ -2632,8 +2628,6 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
 	cancel_work_sync(&mhdp->modeset_retry_work);
 	flush_work(&mhdp->hpd_work);
 	/* Ignoring mhdp->hdcp.check_work and mhdp->hdcp.prop_work here. */
-
-	clk_disable_unprepare(mhdp->clk);
 }
 
 static const struct of_device_id mhdp_ids[] = {
diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index faee8e2e82a0..967aa24b7c53 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2042,12 +2042,13 @@ static bool it6505_hdcp_part2_ksvlist_check(struct it6505 *it6505)
 			continue;
 		}
 
-		for (i = 0; i < 5; i++) {
+		for (i = 0; i < 5; i++)
 			if (bv[i][3] != av[i][0] || bv[i][2] != av[i][1] ||
-			    av[i][1] != av[i][2] || bv[i][0] != av[i][3])
+			    bv[i][1] != av[i][2] || bv[i][0] != av[i][3])
 				break;
 
-			DRM_DEV_DEBUG_DRIVER(dev, "V' all match!! %d, %d", retry, i);
+		if (i == 5) {
+			DRM_DEV_DEBUG_DRIVER(dev, "V' all match!! %d", retry);
 			return true;
 		}
 	}
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 582cf4f73a74..95ce50ed53ac 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -480,6 +480,7 @@ static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
 				       const char *name)
 {
 	struct device *dev = pdata->dev;
+	const struct i2c_client *client = to_i2c_client(dev);
 	struct auxiliary_device *aux;
 	int ret;
 
@@ -488,6 +489,7 @@ static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
 		return -ENOMEM;
 
 	aux->name = name;
+	aux->id = (client->adapter->nr << 10) | client->addr;
 	aux->dev.parent = dev;
 	aux->dev.release = ti_sn65dsi86_aux_device_release;
 	device_set_of_node_from_dev(&aux->dev, dev);
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index da6ff36623d3..3e5f721d7540 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -179,13 +179,13 @@ static int
 drm_dp_mst_rad_to_str(const u8 rad[8], u8 lct, char *out, size_t len)
 {
 	int i;
-	u8 unpacked_rad[16];
+	u8 unpacked_rad[16] = {};
 
-	for (i = 0; i < lct; i++) {
+	for (i = 1; i < lct; i++) {
 		if (i % 2)
-			unpacked_rad[i] = rad[i / 2] >> 4;
+			unpacked_rad[i] = rad[(i - 1) / 2] >> 4;
 		else
-			unpacked_rad[i] = rad[i / 2] & BIT_MASK(4);
+			unpacked_rad[i] = rad[(i - 1) / 2] & 0xF;
 	}
 
 	/* TODO: Eventually add something to printk so we can format the rad
diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 5674f5707cca..8f6fba4217ec 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -620,13 +620,16 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 
 		mbox_send_message(mtk_crtc->cmdq_client.chan, cmdq_handle);
 		mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
+		goto update_config_out;
 	}
-#else
+#endif
 	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	mtk_crtc->config_updating = false;
 	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
-#endif
 
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+update_config_out:
+#endif
 	mutex_unlock(&mtk_crtc->hw_lock);
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index cad65ea851ed..4979d49ae25a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1746,7 +1746,7 @@ static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
 
 	ret = drm_dp_dpcd_readb(&mtk_dp->aux, DP_MSTM_CAP, &val);
 	if (ret < 1) {
-		drm_err(mtk_dp->drm_dev, "Read mstm cap failed\n");
+		dev_err(mtk_dp->dev, "Read mstm cap failed: %zd\n", ret);
 		return ret == 0 ? -EIO : ret;
 	}
 
@@ -1756,7 +1756,7 @@ static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
 					DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0,
 					&val);
 		if (ret < 1) {
-			drm_err(mtk_dp->drm_dev, "Read irq vector failed\n");
+			dev_err(mtk_dp->dev, "Read irq vector failed: %zd\n", ret);
 			return ret == 0 ? -EIO : ret;
 		}
 
@@ -2039,7 +2039,7 @@ static int mtk_dp_wait_hpd_asserted(struct drm_dp_aux *mtk_aux, unsigned long wa
 
 	ret = mtk_dp_parse_capabilities(mtk_dp);
 	if (ret) {
-		drm_err(mtk_dp->drm_dev, "Can't parse capabilities\n");
+		dev_err(mtk_dp->dev, "Can't parse capabilities: %d\n", ret);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b9b7fd08b7d7..88f3dfeb4731 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1108,12 +1108,12 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 				     const struct mipi_dsi_msg *msg)
 {
 	struct mtk_dsi *dsi = host_to_dsi(host);
-	u32 recv_cnt, i;
+	ssize_t recv_cnt;
 	u8 read_data[16];
 	void *src_addr;
 	u8 irq_flag = CMD_DONE_INT_FLAG;
 	u32 dsi_mode;
-	int ret;
+	int ret, i;
 
 	dsi_mode = readl(dsi->regs + DSI_MODE_CTRL);
 	if (dsi_mode & MODE) {
@@ -1162,7 +1162,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	if (recv_cnt)
 		memcpy(msg->rx_buf, src_addr, recv_cnt);
 
-	DRM_INFO("dsi get %d byte data from the panel address(0x%x)\n",
+	DRM_INFO("dsi get %zd byte data from the panel address(0x%x)\n",
 		 recv_cnt, *((u8 *)(msg->tx_buf)));
 
 restore_dsi_mode:
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 7687f673964e..1aad8e6cf52e 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -137,7 +137,7 @@ enum hdmi_aud_channel_swap_type {
 
 struct hdmi_audio_param {
 	enum hdmi_audio_coding_type aud_codec;
-	enum hdmi_audio_sample_size aud_sampe_size;
+	enum hdmi_audio_sample_size aud_sample_size;
 	enum hdmi_aud_input_type aud_input_type;
 	enum hdmi_aud_i2s_fmt aud_i2s_fmt;
 	enum hdmi_aud_mclk aud_mclk;
@@ -173,6 +173,7 @@ struct mtk_hdmi {
 	unsigned int sys_offset;
 	void __iomem *regs;
 	enum hdmi_colorspace csp;
+	struct platform_device *audio_pdev;
 	struct hdmi_audio_param aud_param;
 	bool audio_enable;
 	bool powered;
@@ -1074,7 +1075,7 @@ static int mtk_hdmi_output_init(struct mtk_hdmi *hdmi)
 
 	hdmi->csp = HDMI_COLORSPACE_RGB;
 	aud_param->aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-	aud_param->aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+	aud_param->aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 	aud_param->aud_input_type = HDMI_AUD_INPUT_I2S;
 	aud_param->aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
 	aud_param->aud_mclk = HDMI_AUD_MCLK_128FS;
@@ -1572,14 +1573,14 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
 	switch (daifmt->fmt) {
 	case HDMI_I2S:
 		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		hdmi_params.aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 		hdmi_params.aud_input_type = HDMI_AUD_INPUT_I2S;
 		hdmi_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
 		hdmi_params.aud_mclk = HDMI_AUD_MCLK_128FS;
 		break;
 	case HDMI_SPDIF:
 		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		hdmi_params.aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
 		hdmi_params.aud_input_type = HDMI_AUD_INPUT_SPDIF;
 		break;
 	default:
@@ -1663,6 +1664,11 @@ static const struct hdmi_codec_ops mtk_hdmi_audio_codec_ops = {
 	.no_capture_mute = 1,
 };
 
+static void mtk_hdmi_unregister_audio_driver(void *data)
+{
+	platform_device_unregister(data);
+}
+
 static int mtk_hdmi_register_audio_driver(struct device *dev)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
@@ -1672,13 +1678,20 @@ static int mtk_hdmi_register_audio_driver(struct device *dev)
 		.i2s = 1,
 		.data = hdmi,
 	};
-	struct platform_device *pdev;
+	int ret;
 
-	pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
-					     PLATFORM_DEVID_AUTO, &codec_data,
-					     sizeof(codec_data));
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	hdmi->audio_pdev = platform_device_register_data(dev,
+							 HDMI_CODEC_DRV_NAME,
+							 PLATFORM_DEVID_AUTO,
+							 &codec_data,
+							 sizeof(codec_data));
+	if (IS_ERR(hdmi->audio_pdev))
+		return PTR_ERR(hdmi->audio_pdev);
+
+	ret = devm_add_action_or_reset(dev, mtk_hdmi_unregister_audio_driver,
+				       hdmi->audio_pdev);
+	if (ret)
+		return ret;
 
 	DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
 	return 0;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 0fcae53c0b14..159665cb6b14 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1507,6 +1507,8 @@ static void a6xx_get_indexed_registers(struct msm_gpu *gpu,
 
 	/* Restore the size in the hardware */
 	gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, mempool_size);
+
+	a6xx_state->nr_indexed_regs = count;
 }
 
 static void a7xx_get_indexed_registers(struct msm_gpu *gpu,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index db6c57900781..ecd595215a6b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1191,10 +1191,6 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 
 	DRM_DEBUG_ATOMIC("%s: check\n", dpu_crtc->name);
 
-	/* force a full mode set if active state changed */
-	if (crtc_state->active_changed)
-		crtc_state->mode_changed = true;
-
 	if (cstate->num_mixers) {
 		rc = _dpu_crtc_check_and_setup_lm_bounds(crtc, crtc_state);
 		if (rc)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 2cf8150adf81..47b514c89ce6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -718,12 +718,11 @@ static int dpu_encoder_virt_atomic_check(
 		crtc_state->mode_changed = true;
 	/*
 	 * Release and Allocate resources on every modeset
-	 * Dont allocate when active is false.
 	 */
 	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
 		dpu_rm_release(global_state, drm_enc);
 
-		if (!crtc_state->active_changed || crtc_state->enable)
+		if (crtc_state->enable)
 			ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
 					drm_enc, crtc_state, topology);
 		if (!ret)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index a98d24b7cb00..7459fb8c5177 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -846,7 +846,7 @@ static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
 		dsi_write(msm_host, REG_DSI_CPHY_MODE_CTRL, BIT(0));
 }
 
-static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mode, u32 hdisplay)
+static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mode)
 {
 	struct drm_dsc_config *dsc = msm_host->dsc;
 	u32 reg, reg_ctrl, reg_ctrl2;
@@ -858,7 +858,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	/* first calculate dsc parameters and then program
 	 * compress mode registers
 	 */
-	slice_per_intf = msm_dsc_get_slices_per_intf(dsc, hdisplay);
+	slice_per_intf = dsc->slice_count;
 
 	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
 	bytes_per_pkt = dsc->slice_chunk_size; /* * slice_per_pkt; */
@@ -991,7 +991,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 	if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
 		if (msm_host->dsc)
-			dsi_update_dsc_timing(msm_host, false, mode->hdisplay);
+			dsi_update_dsc_timing(msm_host, false);
 
 		dsi_write(msm_host, REG_DSI_ACTIVE_H,
 			DSI_ACTIVE_H_START(ha_start) |
@@ -1012,7 +1012,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
 	} else {		/* command mode */
 		if (msm_host->dsc)
-			dsi_update_dsc_timing(msm_host, true, mode->hdisplay);
+			dsi_update_dsc_timing(msm_host, true);
 
 		/* image data and 1 byte write_memory_start cmd */
 		if (!msm_host->dsc)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index a210b7c9e5ca..4fabb01345aa 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -74,17 +74,35 @@ static int dsi_mgr_setup_components(int id)
 	int ret;
 
 	if (!IS_BONDED_DSI()) {
+		/*
+		 * Set the usecase before calling msm_dsi_host_register(), which would
+		 * already program the PLL source mux based on a default usecase.
+		 */
+		msm_dsi_phy_set_usecase(msm_dsi->phy, MSM_DSI_PHY_STANDALONE);
+		msm_dsi_host_set_phy_mode(msm_dsi->host, msm_dsi->phy);
+
 		ret = msm_dsi_host_register(msm_dsi->host);
 		if (ret)
 			return ret;
-
-		msm_dsi_phy_set_usecase(msm_dsi->phy, MSM_DSI_PHY_STANDALONE);
-		msm_dsi_host_set_phy_mode(msm_dsi->host, msm_dsi->phy);
 	} else if (other_dsi) {
 		struct msm_dsi *master_link_dsi = IS_MASTER_DSI_LINK(id) ?
 							msm_dsi : other_dsi;
 		struct msm_dsi *slave_link_dsi = IS_MASTER_DSI_LINK(id) ?
 							other_dsi : msm_dsi;
+
+		/*
+		 * PLL0 is to drive both DSI link clocks in bonded DSI mode.
+		 *
+		 * Set the usecase before calling msm_dsi_host_register(), which would
+		 * already program the PLL source mux based on a default usecase.
+		 */
+		msm_dsi_phy_set_usecase(clk_master_dsi->phy,
+					MSM_DSI_PHY_MASTER);
+		msm_dsi_phy_set_usecase(clk_slave_dsi->phy,
+					MSM_DSI_PHY_SLAVE);
+		msm_dsi_host_set_phy_mode(msm_dsi->host, msm_dsi->phy);
+		msm_dsi_host_set_phy_mode(other_dsi->host, other_dsi->phy);
+
 		/* Register slave host first, so that slave DSI device
 		 * has a chance to probe, and do not block the master
 		 * DSI device's probe.
@@ -98,14 +116,6 @@ static int dsi_mgr_setup_components(int id)
 		ret = msm_dsi_host_register(master_link_dsi->host);
 		if (ret)
 			return ret;
-
-		/* PLL0 is to drive both 2 DSI link clocks in bonded DSI mode. */
-		msm_dsi_phy_set_usecase(clk_master_dsi->phy,
-					MSM_DSI_PHY_MASTER);
-		msm_dsi_phy_set_usecase(clk_slave_dsi->phy,
-					MSM_DSI_PHY_SLAVE);
-		msm_dsi_host_set_phy_mode(msm_dsi->host, msm_dsi->phy);
-		msm_dsi_host_set_phy_mode(other_dsi->host, other_dsi->phy);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 798168180c1a..a2c87c84aa05 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -305,7 +305,7 @@ static void dsi_pll_commit(struct dsi_pll_7nm *pll, struct dsi_pll_config *confi
 	writel(pll->phy->cphy_mode ? 0x00 : 0x10,
 	       base + REG_DSI_7nm_PHY_PLL_CMODE_1);
 	writel(config->pll_clock_inverters,
-	       base + REG_DSI_7nm_PHY_PLL_CLOCK_INVERTERS);
+	       base + REG_DSI_7nm_PHY_PLL_CLOCK_INVERTERS_1);
 }
 
 static int dsi_pll_7nm_vco_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/gpu/drm/msm/msm_dsc_helper.h b/drivers/gpu/drm/msm/msm_dsc_helper.h
index b9049fe1e279..63f95523b2cb 100644
--- a/drivers/gpu/drm/msm/msm_dsc_helper.h
+++ b/drivers/gpu/drm/msm/msm_dsc_helper.h
@@ -12,17 +12,6 @@
 #include <linux/math.h>
 #include <drm/display/drm_dsc_helper.h>
 
-/**
- * msm_dsc_get_slices_per_intf() - calculate number of slices per interface
- * @dsc: Pointer to drm dsc config struct
- * @intf_width: interface width in pixels
- * Returns: Integer representing the number of slices for the given interface
- */
-static inline u32 msm_dsc_get_slices_per_intf(const struct drm_dsc_config *dsc, u32 intf_width)
-{
-	return DIV_ROUND_UP(intf_width, dsc->slice_width);
-}
-
 /**
  * msm_dsc_get_bytes_per_line() - calculate bytes per line
  * @dsc: Pointer to drm dsc config struct
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 266a087fe14c..3c24a63b6be8 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -607,7 +607,7 @@ static int ili9882t_add(struct ili9882t *ili)
 
 	ili->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(ili->enable_gpio)) {
-		dev_err(dev, "cannot get reset-gpios %ld\n",
+		dev_err(dev, "cannot get enable-gpios %ld\n",
 			PTR_ERR(ili->enable_gpio));
 		return PTR_ERR(ili->enable_gpio);
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index 22448abde992..6598d96c6d2a 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -102,9 +102,9 @@ struct panthor_fw_cs_output_iface {
 #define CS_STATUS_BLOCKED_REASON_SB_WAIT	1
 #define CS_STATUS_BLOCKED_REASON_PROGRESS_WAIT	2
 #define CS_STATUS_BLOCKED_REASON_SYNC_WAIT	3
-#define CS_STATUS_BLOCKED_REASON_DEFERRED	5
-#define CS_STATUS_BLOCKED_REASON_RES		6
-#define CS_STATUS_BLOCKED_REASON_FLUSH		7
+#define CS_STATUS_BLOCKED_REASON_DEFERRED	4
+#define CS_STATUS_BLOCKED_REASON_RESOURCE	5
+#define CS_STATUS_BLOCKED_REASON_FLUSH		6
 #define CS_STATUS_BLOCKED_REASON_MASK		GENMASK(3, 0)
 	u32 status_blocked_reason;
 	u32 status_wait_sync_value_hi;
diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index 84bfde31d172..fd1b858dcb78 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -151,7 +151,6 @@ static const struct of_device_id ssd130x_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ssd130x_of_match);
 
-#if IS_MODULE(CONFIG_DRM_SSD130X_SPI)
 /*
  * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
  * if the device was registered via OF. This means that the module will not be
@@ -160,7 +159,7 @@ MODULE_DEVICE_TABLE(of, ssd130x_of_match);
  * To workaround this issue, add a SPI device ID table. Even when this should
  * not be needed for this driver to match the registered SPI devices.
  */
-static const struct spi_device_id ssd130x_spi_table[] = {
+static const struct spi_device_id ssd130x_spi_id[] = {
 	/* ssd130x family */
 	{ "sh1106",  SH1106_ID },
 	{ "ssd1305", SSD1305_ID },
@@ -175,14 +174,14 @@ static const struct spi_device_id ssd130x_spi_table[] = {
 	{ "ssd1331", SSD1331_ID },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(spi, ssd130x_spi_table);
-#endif
+MODULE_DEVICE_TABLE(spi, ssd130x_spi_id);
 
 static struct spi_driver ssd130x_spi_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = ssd130x_of_match,
 	},
+	.id_table = ssd130x_spi_id,
 	.probe = ssd130x_spi_probe,
 	.remove = ssd130x_spi_remove,
 	.shutdown = ssd130x_spi_shutdown,
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 6f51bcf774e2..06f5057690bd 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -880,7 +880,7 @@ static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
 			u8 n1 = buf[i * width + j];
 			u8 n2 = buf[i * width + j + 1];
 
-			data_array[array_idx++] = (n2 << 4) | n1;
+			data_array[array_idx++] = (n2 & 0xf0) | (n1 >> 4);
 		}
 	}
 
@@ -1037,7 +1037,7 @@ static int ssd132x_fb_blit_rect(struct drm_framebuffer *fb,
 				struct drm_format_conv_state *fmtcnv_state)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
-	unsigned int dst_pitch = drm_rect_width(rect);
+	unsigned int dst_pitch;
 	struct iosys_map dst;
 	int ret = 0;
 
@@ -1046,6 +1046,8 @@ static int ssd132x_fb_blit_rect(struct drm_framebuffer *fb,
 	rect->x2 = min_t(unsigned int, round_up(rect->x2, SSD132X_SEGMENT_WIDTH),
 			 ssd130x->width);
 
+	dst_pitch = drm_rect_width(rect);
+
 	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 0c1a713b7b7b..be642ee739c4 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -245,17 +245,19 @@ static int __init vkms_init(void)
 	if (!config)
 		return -ENOMEM;
 
-	default_config = config;
-
 	config->cursor = enable_cursor;
 	config->writeback = enable_writeback;
 	config->overlay = enable_overlay;
 
 	ret = vkms_create(config);
-	if (ret)
+	if (ret) {
 		kfree(config);
+		return ret;
+	}
 
-	return ret;
+	default_config = config;
+
+	return 0;
 }
 
 static void vkms_destroy(struct vkms_config *config)
@@ -279,9 +281,10 @@ static void vkms_destroy(struct vkms_config *config)
 
 static void __exit vkms_exit(void)
 {
-	if (default_config->dev)
-		vkms_destroy(default_config);
+	if (!default_config)
+		return;
 
+	vkms_destroy(default_config);
 	kfree(default_config);
 }
 
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index f5781939de9c..a25b22238e3d 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -231,6 +231,8 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+
 	/* Try the reserved memory. Proceed if there's none. */
 	of_reserved_mem_device_init(&pdev->dev);
 
diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 473ac3f2d382..da31f1131afc 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -912,7 +912,9 @@ static enum fw_upload_err cc1352_prepare(struct fw_upload *fw_upload,
 		cc1352_bootloader_reset(bg);
 		WRITE_ONCE(bg->flashing_mode, false);
 		msleep(200);
-		gb_greybus_init(bg);
+		if (gb_greybus_init(bg) < 0)
+			return dev_err_probe(&bg->sd->dev, FW_UPLOAD_ERR_RW_ERROR,
+					     "Failed to initialize greybus");
 		gb_beagleplay_start_svc(bg);
 		return FW_UPLOAD_ERR_FW_INVALID;
 	}
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 496dab54c73a..f2900ee2ef85 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -165,7 +165,6 @@ obj-$(CONFIG_USB_KBD)		+= usbhid/
 obj-$(CONFIG_I2C_HID_CORE)	+= i2c-hid/
 
 obj-$(CONFIG_INTEL_ISH_HID)	+= intel-ish-hid/
-obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)	+= intel-ish-hid/
 
 obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
 
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 4e87380d3edd..bcca89ef7360 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -284,7 +284,7 @@ static int i2c_hid_get_report(struct i2c_hid *ihid,
 			     ihid->rawbuf, recv_len + sizeof(__le16));
 	if (error) {
 		dev_err(&ihid->client->dev,
-			"failed to set a report to device: %d\n", error);
+			"failed to get a report from device: %d\n", error);
 		return error;
 	}
 
diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index fa3351351825..79bc67ffb998 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -273,8 +273,8 @@ static const s8 NCT6776_BEEP_BITS[NUM_BEEP_BITS] = {
 static const u16 NCT6776_REG_TOLERANCE_H[] = {
 	0x10c, 0x20c, 0x30c, 0x80c, 0x90c, 0xa0c, 0xb0c };
 
-static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0 };
-static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0, 0 };
 
 static const u16 NCT6776_REG_FAN_MIN[] = {
 	0x63a, 0x63c, 0x63e, 0x640, 0x642, 0x64a, 0x64c };
diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index bfea880d6dfb..d8ad64ea81f1 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -269,7 +269,7 @@ catu_init_sg_table(struct device *catu_dev, int node,
 	 * Each table can address upto 1MB and we can have
 	 * CATU_PAGES_PER_SYSPAGE tables in a system page.
 	 */
-	nr_tpages = DIV_ROUND_UP(size, SZ_1M) / CATU_PAGES_PER_SYSPAGE;
+	nr_tpages = DIV_ROUND_UP(size, CATU_PAGES_PER_SYSPAGE * SZ_1M);
 	catu_table = tmc_alloc_sg_table(catu_dev, node, nr_tpages,
 					size >> PAGE_SHIFT, pages);
 	if (IS_ERR(catu_table))
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index ea38ecf26fcb..c42aa9fddab9 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1017,18 +1017,20 @@ static void coresight_remove_conns(struct coresight_device *csdev)
 }
 
 /**
- * coresight_timeout - loop until a bit has changed to a specific register
- *			state.
+ * coresight_timeout_action - loop until a bit has changed to a specific register
+ *                  state, with a callback after every trial.
  * @csa: coresight device access for the device
  * @offset: Offset of the register from the base of the device.
  * @position: the position of the bit of interest.
  * @value: the value the bit should have.
+ * @cb: Call back after each trial.
  *
  * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
  * TIMEOUT_US has elapsed, which ever happens first.
  */
-int coresight_timeout(struct csdev_access *csa, u32 offset,
-		      int position, int value)
+int coresight_timeout_action(struct csdev_access *csa, u32 offset,
+		      int position, int value,
+			  coresight_timeout_cb_t cb)
 {
 	int i;
 	u32 val;
@@ -1044,7 +1046,8 @@ int coresight_timeout(struct csdev_access *csa, u32 offset,
 			if (!(val & BIT(position)))
 				return 0;
 		}
-
+		if (cb)
+			cb(csa, offset, position, value);
 		/*
 		 * Delay is arbitrary - the specification doesn't say how long
 		 * we are expected to wait.  Extra check required to make sure
@@ -1056,6 +1059,13 @@ int coresight_timeout(struct csdev_access *csa, u32 offset,
 
 	return -EAGAIN;
 }
+EXPORT_SYMBOL_GPL(coresight_timeout_action);
+
+int coresight_timeout(struct csdev_access *csa, u32 offset,
+		      int position, int value)
+{
+	return coresight_timeout_action(csa, offset, position, value, NULL);
+}
 EXPORT_SYMBOL_GPL(coresight_timeout);
 
 u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 66d44a404ad0..be8b46f26ddc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -399,6 +399,29 @@ static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
 }
 #endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
 
+static void etm4x_sys_ins_barrier(struct csdev_access *csa, u32 offset, int pos, int val)
+{
+	if (!csa->io_mem)
+		isb();
+}
+
+/*
+ * etm4x_wait_status: Poll for TRCSTATR.<pos> == <val>. While using system
+ * instruction to access the trace unit, each access must be separated by a
+ * synchronization barrier. See ARM IHI0064H.b section "4.3.7 Synchronization of
+ * register updates", for system instructions section, in "Notes":
+ *
+ *   "In particular, whenever disabling or enabling the trace unit, a poll of
+ *    TRCSTATR needs explicit synchronization between each read of TRCSTATR"
+ */
+static int etm4x_wait_status(struct csdev_access *csa, int pos, int val)
+{
+	if (!csa->io_mem)
+		return coresight_timeout_action(csa, TRCSTATR, pos, val,
+						etm4x_sys_ins_barrier);
+	return coresight_timeout(csa, TRCSTATR, pos, val);
+}
+
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
@@ -430,7 +453,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		isb();
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
+	if (etm4x_wait_status(csa, TRCSTATR_IDLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 	if (drvdata->nr_pe)
@@ -523,7 +546,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		isb();
 
 	/* wait for TRCSTATR.IDLE to go back down to '0' */
-	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
+	if (etm4x_wait_status(csa, TRCSTATR_IDLE_BIT, 0))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 
@@ -906,10 +929,25 @@ static void etm4_disable_hw(void *info)
 	tsb_csync();
 	etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
 
+	/*
+	 * As recommended by section 4.3.7 ("Synchronization when using system
+	 * instructions to progrom the trace unit") of ARM IHI 0064H.b, the
+	 * self-hosted trace analyzer must perform a Context synchronization
+	 * event between writing to the TRCPRGCTLR and reading the TRCSTATR.
+	 */
+	if (!csa->io_mem)
+		isb();
+
 	/* wait for TRCSTATR.PMSTABLE to go to '1' */
-	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
+	if (etm4x_wait_status(csa, TRCSTATR_PMSTABLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for PM stable Trace Status\n");
+	/*
+	 * As recommended by section 4.3.7 (Synchronization of register updates)
+	 * of ARM IHI 0064H.b.
+	 */
+	isb();
+
 	/* read the status of the single shot comparators */
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		config->ss_status[i] =
@@ -1711,7 +1749,7 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	etm4_os_lock(drvdata);
 
 	/* wait for TRCSTATR.PMSTABLE to go up */
-	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1)) {
+	if (etm4x_wait_status(csa, TRCSTATR_PMSTABLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for PM Stable Status\n");
 		etm4_os_unlock(drvdata);
@@ -1802,7 +1840,7 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trcpdcr = etm4x_read32(csa, TRCPDCR);
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
+	if (etm4x_wait_status(csa, TRCSTATR_PMSTABLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 		etm4_os_unlock(drvdata);
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 565af3759813..87f98fa8afd5 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -990,7 +990,7 @@ static int svc_i3c_update_ibirules(struct svc_i3c_master *master)
 
 	/* Create the IBIRULES register for both cases */
 	i3c_bus_for_each_i3cdev(&master->base.bus, dev) {
-		if (I3C_BCR_DEVICE_ROLE(dev->info.bcr) == I3C_BCR_I3C_MASTER)
+		if (!(dev->info.bcr & I3C_BCR_IBI_REQ_CAP))
 			continue;
 
 		if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD) {
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 62e6369e2269..de207526babe 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -711,7 +711,7 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
-	int i, ret;
+	int i, j, ret;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret)
@@ -771,14 +771,18 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = mma8452_get_odr_index(data);
+		j = mma8452_get_odr_index(data);
 
 		for (i = 0; i < ARRAY_SIZE(mma8452_os_ratio); i++) {
-			if (mma8452_os_ratio[i][ret] == val) {
+			if (mma8452_os_ratio[i][j] == val) {
 				ret = mma8452_set_power_mode(data, i);
 				break;
 			}
 		}
+		if (i == ARRAY_SIZE(mma8452_os_ratio)) {
+			ret = -EINVAL;
+			break;
+		}
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index 57025354c7cd..f484be27058d 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -593,23 +593,25 @@ static int msa311_read_raw_data(struct iio_dev *indio_dev,
 	__le16 axis;
 	int err;
 
-	err = pm_runtime_resume_and_get(dev);
+	err = iio_device_claim_direct_mode(indio_dev);
 	if (err)
 		return err;
 
-	err = iio_device_claim_direct_mode(indio_dev);
-	if (err)
+	err = pm_runtime_resume_and_get(dev);
+	if (err) {
+		iio_device_release_direct_mode(indio_dev);
 		return err;
+	}
 
 	mutex_lock(&msa311->lock);
 	err = msa311_get_axis(msa311, chan, &axis);
 	mutex_unlock(&msa311->lock);
 
-	iio_device_release_direct_mode(indio_dev);
-
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
+	iio_device_release_direct_mode(indio_dev);
+
 	if (err) {
 		dev_err(dev, "can't get axis %s (%pe)\n",
 			chan->datasheet_name, ERR_PTR(err));
@@ -755,10 +757,6 @@ static int msa311_write_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 	unsigned int odr;
 	int err;
 
-	err = pm_runtime_resume_and_get(dev);
-	if (err)
-		return err;
-
 	/*
 	 * Sampling frequency changing is prohibited when buffer mode is
 	 * enabled, because sometimes MSA311 chip returns outliers during
@@ -768,6 +766,12 @@ static int msa311_write_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 	if (err)
 		return err;
 
+	err = pm_runtime_resume_and_get(dev);
+	if (err) {
+		iio_device_release_direct_mode(indio_dev);
+		return err;
+	}
+
 	err = -EINVAL;
 	for (odr = 0; odr < ARRAY_SIZE(msa311_odr_table); odr++)
 		if (val == msa311_odr_table[odr].integral &&
@@ -778,11 +782,11 @@ static int msa311_write_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 			break;
 		}
 
-	iio_device_release_direct_mode(indio_dev);
-
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
+	iio_device_release_direct_mode(indio_dev);
+
 	if (err)
 		dev_err(dev, "can't update frequency (%pe)\n", ERR_PTR(err));
 
diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index de32cc9d18c5..712f95f53c9e 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -223,6 +223,10 @@ enum ad4130_pin_function {
 	AD4130_PIN_FN_VBIAS = BIT(3),
 };
 
+/*
+ * If you make adaptations in this struct, you most likely also have to adapt
+ * ad4130_setup_info_eq(), too.
+ */
 struct ad4130_setup_info {
 	unsigned int			iout0_val;
 	unsigned int			iout1_val;
@@ -591,6 +595,40 @@ static irqreturn_t ad4130_irq_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static bool ad4130_setup_info_eq(struct ad4130_setup_info *a,
+				 struct ad4130_setup_info *b)
+{
+	/*
+	 * This is just to make sure that the comparison is adapted after
+	 * struct ad4130_setup_info was changed.
+	 */
+	static_assert(sizeof(*a) ==
+		      sizeof(struct {
+				     unsigned int iout0_val;
+				     unsigned int iout1_val;
+				     unsigned int burnout;
+				     unsigned int pga;
+				     unsigned int fs;
+				     u32 ref_sel;
+				     enum ad4130_filter_mode filter_mode;
+				     bool ref_bufp;
+				     bool ref_bufm;
+			     }));
+
+	if (a->iout0_val != b->iout0_val ||
+	    a->iout1_val != b->iout1_val ||
+	    a->burnout != b->burnout ||
+	    a->pga != b->pga ||
+	    a->fs != b->fs ||
+	    a->ref_sel != b->ref_sel ||
+	    a->filter_mode != b->filter_mode ||
+	    a->ref_bufp != b->ref_bufp ||
+	    a->ref_bufm != b->ref_bufm)
+		return false;
+
+	return true;
+}
+
 static int ad4130_find_slot(struct ad4130_state *st,
 			    struct ad4130_setup_info *target_setup_info,
 			    unsigned int *slot, bool *overwrite)
@@ -604,8 +642,7 @@ static int ad4130_find_slot(struct ad4130_state *st,
 		struct ad4130_slot_info *slot_info = &st->slots_info[i];
 
 		/* Immediately accept a matching setup info. */
-		if (!memcmp(target_setup_info, &slot_info->setup,
-			    sizeof(*target_setup_info))) {
+		if (ad4130_setup_info_eq(target_setup_info, &slot_info->setup)) {
 			*slot = i;
 			return 0;
 		}
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 8d94bc2b1cac..30a7392c4f8b 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -147,7 +147,11 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	bool live;
 	unsigned int cfg_slot;
-	/* Following fields are used to compare equality. */
+	/*
+	 * Following fields are used to compare for equality. If you
+	 * make adaptations in it, you most likely also have to adapt
+	 * ad7124_find_similar_live_cfg(), too.
+	 */
 	struct_group(config_props,
 		enum ad7124_ref_sel refsel;
 		bool bipolar;
@@ -334,15 +338,38 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 								  struct ad7124_channel_config *cfg)
 {
 	struct ad7124_channel_config *cfg_aux;
-	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = sizeof_field(struct ad7124_channel_config, config_props);
+	/*
+	 * This is just to make sure that the comparison is adapted after
+	 * struct ad7124_channel_config was changed.
+	 */
+	static_assert(sizeof_field(struct ad7124_channel_config, config_props) ==
+		      sizeof(struct {
+				     enum ad7124_ref_sel refsel;
+				     bool bipolar;
+				     bool buf_positive;
+				     bool buf_negative;
+				     unsigned int vref_mv;
+				     unsigned int pga_bits;
+				     unsigned int odr;
+				     unsigned int odr_sel_bits;
+				     unsigned int filter_type;
+			     }));
+
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
 		if (cfg_aux->live &&
-		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
+		    cfg->refsel == cfg_aux->refsel &&
+		    cfg->bipolar == cfg_aux->bipolar &&
+		    cfg->buf_positive == cfg_aux->buf_positive &&
+		    cfg->buf_negative == cfg_aux->buf_negative &&
+		    cfg->vref_mv == cfg_aux->vref_mv &&
+		    cfg->pga_bits == cfg_aux->pga_bits &&
+		    cfg->odr == cfg_aux->odr &&
+		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
+		    cfg->filter_type == cfg_aux->filter_type)
 			return cfg_aux;
 	}
 
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 5a65be00dd19..2eebc6f761a6 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -181,7 +181,11 @@ struct ad7173_channel_config {
 	u8 cfg_slot;
 	bool live;
 
-	/* Following fields are used to compare equality. */
+	/*
+	 * Following fields are used to compare equality. If you
+	 * make adaptations in it, you most likely also have to adapt
+	 * ad7173_find_live_config(), too.
+	 */
 	struct_group(config_props,
 		bool bipolar;
 		bool input_buf;
@@ -582,15 +586,28 @@ static struct ad7173_channel_config *
 ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
 {
 	struct ad7173_channel_config *cfg_aux;
-	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = sizeof_field(struct ad7173_channel_config, config_props);
+	/*
+	 * This is just to make sure that the comparison is adapted after
+	 * struct ad7173_channel_config was changed.
+	 */
+	static_assert(sizeof_field(struct ad7173_channel_config, config_props) ==
+		      sizeof(struct {
+				     bool bipolar;
+				     bool input_buf;
+				     u8 odr;
+				     u8 ref_sel;
+			     }));
+
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
 		if (cfg_aux->live &&
-		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
+		    cfg->bipolar == cfg_aux->bipolar &&
+		    cfg->input_buf == cfg_aux->input_buf &&
+		    cfg->odr == cfg_aux->odr &&
+		    cfg->ref_sel == cfg_aux->ref_sel)
 			return cfg_aux;
 	}
 	return NULL;
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 113703fb7245..6f8816483f1a 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -574,6 +574,21 @@ static int ad7768_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+	/*
+	 * Datasheet recommends SDI line to be kept high when data is not being
+	 * clocked out of the controller and the spi clock is free running,
+	 * to prevent accidental reset.
+	 * Since many controllers do not support the SPI_MOSI_IDLE_HIGH flag
+	 * yet, only request the MOSI idle state to enable if the controller
+	 * supports it.
+	 */
+	if (spi->controller->mode_bits & SPI_MOSI_IDLE_HIGH) {
+		spi->mode |= SPI_MOSI_IDLE_HIGH;
+		ret = spi_setup(spi);
+		if (ret < 0)
+			return ret;
+	}
+
 	st->spi = spi;
 
 	st->vref = devm_regulator_get(&spi->dev, "vref");
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index fb34a8e4d04e..42e0ee683ef6 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -155,10 +155,12 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
 	ssize_t rc;
 	int ret;
 
-	rc = simple_write_to_buffer(buf, sizeof(buf), ppos, userbuf, count);
+	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
 	if (rc < 0)
 		return rc;
 
+	buf[count] = '\0';
+
 	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
 
 	switch (ret) {
diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
index 05d4c0e9015d..859891e8f115 100644
--- a/drivers/iio/light/veml6075.c
+++ b/drivers/iio/light/veml6075.c
@@ -195,13 +195,17 @@ static int veml6075_read_uv_direct(struct veml6075_data *data, int chan,
 
 static int veml6075_read_int_time_index(struct veml6075_data *data)
 {
-	int ret, conf;
+	int ret, conf, int_index;
 
 	ret = regmap_read(data->regmap, VEML6075_CMD_CONF, &conf);
 	if (ret < 0)
 		return ret;
 
-	return FIELD_GET(VEML6075_CONF_IT, conf);
+	int_index = FIELD_GET(VEML6075_CONF_IT, conf);
+	if (int_index >= ARRAY_SIZE(veml6075_it_ms))
+		return -EINVAL;
+
+	return int_index;
 }
 
 static int veml6075_read_int_time_ms(struct veml6075_data *data, int *val)
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index e029401b5680..46102f179955 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -544,6 +544,8 @@ static struct class ib_class = {
 static void rdma_init_coredev(struct ib_core_device *coredev,
 			      struct ib_device *dev, struct net *net)
 {
+	bool is_full_dev = &dev->coredev == coredev;
+
 	/* This BUILD_BUG_ON is intended to catch layout change
 	 * of union of ib_core_device and device.
 	 * dev must be the first element as ib_core and providers
@@ -555,6 +557,13 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
 
 	coredev->dev.class = &ib_class;
 	coredev->dev.groups = dev->groups;
+
+	/*
+	 * Don't expose hw counters outside of the init namespace.
+	 */
+	if (!is_full_dev && dev->hw_stats_attr_index)
+		coredev->dev.groups[dev->hw_stats_attr_index] = NULL;
+
 	device_initialize(&coredev->dev);
 	coredev->owner = dev;
 	INIT_LIST_HEAD(&coredev->port_list);
@@ -1357,9 +1366,11 @@ static void ib_device_notify_register(struct ib_device *device)
 	u32 port;
 	int ret;
 
+	down_read(&devices_rwsem);
+
 	ret = rdma_nl_notify_event(device, 0, RDMA_REGISTER_EVENT);
 	if (ret)
-		return;
+		goto out;
 
 	rdma_for_each_port(device, port) {
 		netdev = ib_device_get_netdev(device, port);
@@ -1370,8 +1381,11 @@ static void ib_device_notify_register(struct ib_device *device)
 					   RDMA_NETDEV_ATTACH_EVENT);
 		dev_put(netdev);
 		if (ret)
-			return;
+			goto out;
 	}
+
+out:
+	up_read(&devices_rwsem);
 }
 
 /**
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 1fd54d5c4dd8..73f3a0b9a54b 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2671,11 +2671,11 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 				    struct ib_mad_private *mad)
 {
 	unsigned long flags;
-	int post, ret;
 	struct ib_mad_private *mad_priv;
 	struct ib_sge sg_list;
 	struct ib_recv_wr recv_wr;
 	struct ib_mad_queue *recv_queue = &qp_info->recv_queue;
+	int ret = 0;
 
 	/* Initialize common scatter list fields */
 	sg_list.lkey = qp_info->port_priv->pd->local_dma_lkey;
@@ -2685,7 +2685,7 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 	recv_wr.sg_list = &sg_list;
 	recv_wr.num_sge = 1;
 
-	do {
+	while (true) {
 		/* Allocate and map receive buffer */
 		if (mad) {
 			mad_priv = mad;
@@ -2693,10 +2693,8 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 		} else {
 			mad_priv = alloc_mad_private(port_mad_size(qp_info->port_priv),
 						     GFP_ATOMIC);
-			if (!mad_priv) {
-				ret = -ENOMEM;
-				break;
-			}
+			if (!mad_priv)
+				return -ENOMEM;
 		}
 		sg_list.length = mad_priv_dma_size(mad_priv);
 		sg_list.addr = ib_dma_map_single(qp_info->port_priv->device,
@@ -2705,37 +2703,41 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 						 DMA_FROM_DEVICE);
 		if (unlikely(ib_dma_mapping_error(qp_info->port_priv->device,
 						  sg_list.addr))) {
-			kfree(mad_priv);
 			ret = -ENOMEM;
-			break;
+			goto free_mad_priv;
 		}
 		mad_priv->header.mapping = sg_list.addr;
 		mad_priv->header.mad_list.mad_queue = recv_queue;
 		mad_priv->header.mad_list.cqe.done = ib_mad_recv_done;
 		recv_wr.wr_cqe = &mad_priv->header.mad_list.cqe;
-
-		/* Post receive WR */
 		spin_lock_irqsave(&recv_queue->lock, flags);
-		post = (++recv_queue->count < recv_queue->max_active);
-		list_add_tail(&mad_priv->header.mad_list.list, &recv_queue->list);
+		if (recv_queue->count >= recv_queue->max_active) {
+			/* Fully populated the receive queue */
+			spin_unlock_irqrestore(&recv_queue->lock, flags);
+			break;
+		}
+		recv_queue->count++;
+		list_add_tail(&mad_priv->header.mad_list.list,
+			      &recv_queue->list);
 		spin_unlock_irqrestore(&recv_queue->lock, flags);
+
 		ret = ib_post_recv(qp_info->qp, &recv_wr, NULL);
 		if (ret) {
 			spin_lock_irqsave(&recv_queue->lock, flags);
 			list_del(&mad_priv->header.mad_list.list);
 			recv_queue->count--;
 			spin_unlock_irqrestore(&recv_queue->lock, flags);
-			ib_dma_unmap_single(qp_info->port_priv->device,
-					    mad_priv->header.mapping,
-					    mad_priv_dma_size(mad_priv),
-					    DMA_FROM_DEVICE);
-			kfree(mad_priv);
 			dev_err(&qp_info->port_priv->device->dev,
 				"ib_post_recv failed: %d\n", ret);
 			break;
 		}
-	} while (post);
+	}
 
+	ib_dma_unmap_single(qp_info->port_priv->device,
+			    mad_priv->header.mapping,
+			    mad_priv_dma_size(mad_priv), DMA_FROM_DEVICE);
+free_mad_priv:
+	kfree(mad_priv);
 	return ret;
 }
 
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 9f97bef02149..210092b9bf17 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -988,6 +988,7 @@ int ib_setup_device_attrs(struct ib_device *ibdev)
 	for (i = 0; i != ARRAY_SIZE(ibdev->groups); i++)
 		if (!ibdev->groups[i]) {
 			ibdev->groups[i] = &data->group;
+			ibdev->hw_stats_attr_index = i;
 			return 0;
 		}
 	WARN(true, "struct ib_device->groups is too small");
diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index 771059a8eb7d..e349e8d2fb50 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -705,7 +705,6 @@ static void erdma_accept_newconn(struct erdma_cep *cep)
 		erdma_cancel_mpatimer(new_cep);
 
 		erdma_cep_put(new_cep);
-		new_cep->sock = NULL;
 	}
 
 	if (new_s) {
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 457cea6d9909..f6bf289041bf 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -358,7 +358,7 @@ static int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem
 	unsigned int tail = 0;
 	u64 *page_addr_list;
 	void *request_buf;
-	int err;
+	int err = 0;
 
 	gc = mdev_to_gc(dev);
 	hwc = gc->hwc.driver_data;
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 4c54dc578069..1aa5311b03e9 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -490,7 +490,7 @@ static int mlx5_poll_one(struct mlx5_ib_cq *cq,
 	}
 
 	qpn = ntohl(cqe64->sop_drop_qpn) & 0xffffff;
-	if (!*cur_qp || (qpn != (*cur_qp)->ibqp.qp_num)) {
+	if (!*cur_qp || (qpn != (*cur_qp)->trans_qp.base.mqp.qpn)) {
 		/* We do not have to take the QP table lock here,
 		 * because CQs will be locked while QPs are removed
 		 * from the table.
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 753faa9ad06a..068eac3bdb50 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -56,7 +56,7 @@ static void
 create_mkey_callback(int status, struct mlx5_async_work *context);
 static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 				     u64 iova, int access_flags,
-				     unsigned int page_size, bool populate,
+				     unsigned long page_size, bool populate,
 				     int access_mode);
 static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr);
 
@@ -919,6 +919,25 @@ mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
 	return ERR_PTR(ret);
 }
 
+static void mlx5r_destroy_cache_entries(struct mlx5_ib_dev *dev)
+{
+	struct rb_root *root = &dev->cache.rb_root;
+	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
+
+	mutex_lock(&dev->cache.rb_lock);
+	node = rb_first(root);
+	while (node) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
+		node = rb_next(node);
+		clean_keys(dev, ent);
+		rb_erase(&ent->node, root);
+		mlx5r_mkeys_uninit(ent);
+		kfree(ent);
+	}
+	mutex_unlock(&dev->cache.rb_lock);
+}
+
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
@@ -970,6 +989,8 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 err:
 	mutex_unlock(&cache->rb_lock);
 	mlx5_mkey_cache_debugfs_cleanup(dev);
+	mlx5r_destroy_cache_entries(dev);
+	destroy_workqueue(cache->wq);
 	mlx5_ib_warn(dev, "failed to create mkey cache entry\n");
 	return ret;
 }
@@ -1003,17 +1024,7 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 
 	/* At this point all entries are disabled and have no concurrent work. */
-	mutex_lock(&dev->cache.rb_lock);
-	node = rb_first(root);
-	while (node) {
-		ent = rb_entry(node, struct mlx5_cache_ent, node);
-		node = rb_next(node);
-		clean_keys(dev, ent);
-		rb_erase(&ent->node, root);
-		mlx5r_mkeys_uninit(ent);
-		kfree(ent);
-	}
-	mutex_unlock(&dev->cache.rb_lock);
+	mlx5r_destroy_cache_entries(dev);
 
 	destroy_workqueue(dev->cache.wq);
 	del_timer_sync(&dev->delay_timer);
@@ -1115,7 +1126,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	struct mlx5r_cache_rb_key rb_key = {};
 	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
-	unsigned int page_size;
+	unsigned long page_size;
 
 	if (umem->is_dmabuf)
 		page_size = mlx5_umem_dmabuf_default_pgsz(umem, iova);
@@ -1219,7 +1230,7 @@ reg_create_crossing_vhca_mr(struct ib_pd *pd, u64 iova, u64 length, int access_f
  */
 static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 				     u64 iova, int access_flags,
-				     unsigned int page_size, bool populate,
+				     unsigned long page_size, bool populate,
 				     int access_mode)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
@@ -1425,7 +1436,7 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
 		mr = alloc_cacheable_mr(pd, umem, iova, access_flags,
 					MLX5_MKC_ACCESS_MODE_MTT);
 	} else {
-		unsigned int page_size =
+		unsigned long page_size =
 			mlx5_umem_mkc_find_best_pgsz(dev, umem, iova);
 
 		mutex_lock(&dev->slow_path_mutex);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index b4e2a6f9cb9c..e158d5b1ab17 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -309,9 +309,6 @@ static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
 				blk_start_idx = idx;
 				in_block = 1;
 			}
-
-			/* Count page invalidations */
-			invalidations += idx - blk_start_idx + 1;
 		} else {
 			u64 umr_offset = idx & umr_block_mask;
 
@@ -321,14 +318,19 @@ static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
 						     MLX5_IB_UPD_XLT_ZAP |
 						     MLX5_IB_UPD_XLT_ATOMIC);
 				in_block = 0;
+				/* Count page invalidations */
+				invalidations += idx - blk_start_idx + 1;
 			}
 		}
 	}
-	if (in_block)
+	if (in_block) {
 		mlx5r_umr_update_xlt(mr, blk_start_idx,
 				     idx - blk_start_idx + 1, 0,
 				     MLX5_IB_UPD_XLT_ZAP |
 				     MLX5_IB_UPD_XLT_ATOMIC);
+		/* Count page invalidations */
+		invalidations += idx - blk_start_idx + 1;
+	}
 
 	mlx5_update_odp_stats(mr, invalidations, invalidations);
 
diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 001c290bc07b..cda0995b1679 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -159,8 +159,19 @@ static void set_brightness_delayed(struct work_struct *ws)
 	 * before this work item runs once. To make sure this works properly
 	 * handle LED_SET_BRIGHTNESS_OFF first.
 	 */
-	if (test_and_clear_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags))
+	if (test_and_clear_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags)) {
 		set_brightness_delayed_set_brightness(led_cdev, LED_OFF);
+		/*
+		 * The consecutives led_set_brightness(LED_OFF),
+		 * led_set_brightness(LED_FULL) could have been executed out of
+		 * order (LED_FULL first), if the work_flags has been set
+		 * between LED_SET_BRIGHTNESS_OFF and LED_SET_BRIGHTNESS of this
+		 * work. To avoid ending with the LED turned off, turn the LED
+		 * on again.
+		 */
+		if (led_cdev->delayed_set_value != LED_OFF)
+			set_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
+	}
 
 	if (test_and_clear_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags))
 		set_brightness_delayed_set_brightness(led_cdev, led_cdev->delayed_set_value);
@@ -331,10 +342,13 @@ void led_set_brightness_nopm(struct led_classdev *led_cdev, unsigned int value)
 	 * change is done immediately afterwards (before the work runs),
 	 * it uses a separate work_flag.
 	 */
-	if (value) {
-		led_cdev->delayed_set_value = value;
+	led_cdev->delayed_set_value = value;
+	/* Ensure delayed_set_value is seen before work_flags modification */
+	smp_mb__before_atomic();
+
+	if (value)
 		set_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
-	} else {
+	else {
 		clear_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
 		clear_bit(LED_SET_BLINK, &led_cdev->work_flags);
 		set_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags);
diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index 2f5165918163..cfe59c3255f7 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -2701,8 +2701,11 @@ static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
 	u8 ratio;
 
 	if (state->revision == 0x8090) {
+		u32 internal = dib8000_read32(state, 23) / 1000;
+
 		ratio = 4;
-		unit_khz_dds_val = (1<<26) / (dib8000_read32(state, 23) / 1000);
+
+		unit_khz_dds_val = (1<<26) / (internal ?: 1);
 		if (offset_khz < 0)
 			dds = (1 << 26) - (abs_offset_khz * unit_khz_dds_val);
 		else
diff --git a/drivers/media/platform/allegro-dvt/allegro-core.c b/drivers/media/platform/allegro-dvt/allegro-core.c
index 88c36eb6174a..9ca4e2f94647 100644
--- a/drivers/media/platform/allegro-dvt/allegro-core.c
+++ b/drivers/media/platform/allegro-dvt/allegro-core.c
@@ -3914,6 +3914,7 @@ static int allegro_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		v4l2_err(&dev->v4l2_dev,
 			 "failed to request firmware: %d\n", ret);
+		v4l2_device_unregister(&dev->v4l2_dev);
 		return ret;
 	}
 
diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
index 91101ba88ef0..b2210841a320 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -1961,6 +1961,13 @@ static int isp_attach_iommu(struct isp_device *isp)
 	struct dma_iommu_mapping *mapping;
 	int ret;
 
+	/* We always want to replace any default mapping from the arch code */
+	mapping = to_dma_iommu_mapping(isp->dev);
+	if (mapping) {
+		arm_iommu_detach_device(isp->dev);
+		arm_iommu_release_mapping(mapping);
+	}
+
 	/*
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
 	 * VAs. This will allocate a corresponding IOMMU domain.
diff --git a/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c b/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
index 85a44143b378..0e212198dd65 100644
--- a/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
@@ -518,6 +518,7 @@ static void set_buffers(struct hantro_ctx *ctx)
 	hantro_reg_write(vpu, &g2_stream_len, src_len);
 	hantro_reg_write(vpu, &g2_strm_buffer_len, src_buf_len);
 	hantro_reg_write(vpu, &g2_strm_start_offset, 0);
+	hantro_reg_write(vpu, &g2_start_bit, 0);
 	hantro_reg_write(vpu, &g2_write_mvs_e, 1);
 
 	hantro_write_addr(vpu, G2_TILE_SIZES_ADDR, ctx->hevc_dec.tile_sizes.dma);
diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index 9b209e687f25..2ce62fe5d60f 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -385,8 +385,8 @@ static void streamzap_disconnect(struct usb_interface *interface)
 	if (!sz)
 		return;
 
-	rc_unregister_device(sz->rdev);
 	usb_kill_urb(sz->urb_in);
+	rc_unregister_device(sz->rdev);
 	usb_free_urb(sz->urb_in);
 	usb_free_coherent(usbdev, sz->buf_in_len, sz->buf_in, sz->dma_in);
 
diff --git a/drivers/media/test-drivers/vimc/vimc-streamer.c b/drivers/media/test-drivers/vimc/vimc-streamer.c
index 807551a5143b..15d863f97cbf 100644
--- a/drivers/media/test-drivers/vimc/vimc-streamer.c
+++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
@@ -59,6 +59,12 @@ static void vimc_streamer_pipeline_terminate(struct vimc_stream *stream)
 			continue;
 
 		sd = media_entity_to_v4l2_subdev(ved->ent);
+		/*
+		 * Do not call .s_stream() to stop an already
+		 * stopped/unstarted subdev.
+		 */
+		if (!v4l2_subdev_is_streaming(sd))
+			continue;
 		v4l2_subdev_call(sd, video, s_stream, 0);
 	}
 }
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index c8a0d82f9c27..719225c09a4d 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2245,26 +2245,6 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		goto err;
 	}
 
-	if (of_node_name_eq(child, "nand")) {
-		/* Warn about older DT blobs with no compatible property */
-		if (!of_property_read_bool(child, "compatible")) {
-			dev_warn(&pdev->dev,
-				 "Incompatible NAND node: missing compatible");
-			ret = -EINVAL;
-			goto err;
-		}
-	}
-
-	if (of_node_name_eq(child, "onenand")) {
-		/* Warn about older DT blobs with no compatible property */
-		if (!of_property_read_bool(child, "compatible")) {
-			dev_warn(&pdev->dev,
-				 "Incompatible OneNAND node: missing compatible");
-			ret = -EINVAL;
-			goto err;
-		}
-	}
-
 	if (of_match_node(omap_nand_ids, child)) {
 		/* NAND specific setup */
 		val = 8;
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index b3592982a83b..5b6dc1cb9bfc 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -920,7 +920,7 @@ static void sm501_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct sm501_gpio_chip *smchip = gpiochip_get_data(chip);
 	struct sm501_gpio *smgpio = smchip->ourgpio;
-	unsigned long bit = 1 << offset;
+	unsigned long bit = BIT(offset);
 	void __iomem *regs = smchip->regbase;
 	unsigned long save;
 	unsigned long val;
@@ -946,7 +946,7 @@ static int sm501_gpio_input(struct gpio_chip *chip, unsigned offset)
 	struct sm501_gpio_chip *smchip = gpiochip_get_data(chip);
 	struct sm501_gpio *smgpio = smchip->ourgpio;
 	void __iomem *regs = smchip->regbase;
-	unsigned long bit = 1 << offset;
+	unsigned long bit = BIT(offset);
 	unsigned long save;
 	unsigned long ddr;
 
@@ -971,7 +971,7 @@ static int sm501_gpio_output(struct gpio_chip *chip,
 {
 	struct sm501_gpio_chip *smchip = gpiochip_get_data(chip);
 	struct sm501_gpio *smgpio = smchip->ourgpio;
-	unsigned long bit = 1 << offset;
+	unsigned long bit = BIT(offset);
 	void __iomem *regs = smchip->regbase;
 	unsigned long save;
 	unsigned long val;
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 335350a4e99a..ee0940d96feb 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1272,19 +1272,25 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	/* Check for some optional GPIO controls */
 	slot->vsd = devm_gpiod_get_index_optional(host->dev, "vsd",
 						  id, GPIOD_OUT_LOW);
-	if (IS_ERR(slot->vsd))
-		return dev_err_probe(host->dev, PTR_ERR(slot->vsd),
+	if (IS_ERR(slot->vsd)) {
+		r = dev_err_probe(host->dev, PTR_ERR(slot->vsd),
 				     "error looking up VSD GPIO\n");
+		goto err_free_host;
+	}
 	slot->vio = devm_gpiod_get_index_optional(host->dev, "vio",
 						  id, GPIOD_OUT_LOW);
-	if (IS_ERR(slot->vio))
-		return dev_err_probe(host->dev, PTR_ERR(slot->vio),
+	if (IS_ERR(slot->vio)) {
+		r = dev_err_probe(host->dev, PTR_ERR(slot->vio),
 				     "error looking up VIO GPIO\n");
+		goto err_free_host;
+	}
 	slot->cover = devm_gpiod_get_index_optional(host->dev, "cover",
 						    id, GPIOD_IN);
-	if (IS_ERR(slot->cover))
-		return dev_err_probe(host->dev, PTR_ERR(slot->cover),
+	if (IS_ERR(slot->cover)) {
+		r = dev_err_probe(host->dev, PTR_ERR(slot->cover),
 				     "error looking up cover switch GPIO\n");
+		goto err_free_host;
+	}
 
 	host->slots[id] = slot;
 
@@ -1344,6 +1350,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 		device_remove_file(&mmc->class_dev, &dev_attr_slot_name);
 err_remove_host:
 	mmc_remove_host(mmc);
+err_free_host:
 	mmc_free_host(mmc);
 	return r;
 }
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 5841a9afeb9f..ea4a801c9ace 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1339,8 +1339,8 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	/* R1B responses is required to properly manage HW busy detection. */
 	mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 
-	/* Allow card power off and runtime PM for eMMC/SD card devices */
-	mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_AGGRESSIVE_PM;
+	/*  Enable SDIO card power off. */
+	mmc->caps |= MMC_CAP_POWER_OFF_CARD;
 
 	ret = sdhci_setup_host(host);
 	if (ret)
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3af43ac05825..376fd927ae73 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -399,6 +399,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (!IS_ERR(pxa->clk_core))
 		clk_prepare_enable(pxa->clk_core);
 
+	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index c5e571ec94c9..0472bcdff130 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -251,18 +251,33 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			card->tx_led.default_trigger = devm_kasprintf(&pdev->dev,
 							GFP_KERNEL, "arc%d-%d-tx",
 							dev->dev_id, i);
+			if (!card->tx_led.default_trigger) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:green:tx:%d-%d",
 							dev->dev_id, i);
-
+			if (!card->tx_led.name) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->tx_led.dev = &dev->dev;
 			card->recon_led.brightness_set = led_recon_set;
 			card->recon_led.default_trigger = devm_kasprintf(&pdev->dev,
 							GFP_KERNEL, "arc%d-%d-recon",
 							dev->dev_id, i);
+			if (!card->recon_led.default_trigger) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:red:recon:%d-%d",
 							dev->dev_id, i);
+			if (!card->recon_led.name) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->recon_led.dev = &dev->dev;
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5aeecfab9630..5935100e7d65 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7301,13 +7301,13 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	err = mv88e6xxx_switch_reset(chip);
 	mv88e6xxx_reg_unlock(chip);
 	if (err)
-		goto out;
+		goto out_phy;
 
 	if (np) {
 		chip->irq = of_irq_get(np, 0);
 		if (chip->irq == -EPROBE_DEFER) {
 			err = chip->irq;
-			goto out;
+			goto out_phy;
 		}
 	}
 
@@ -7326,7 +7326,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	mv88e6xxx_reg_unlock(chip);
 
 	if (err)
-		goto out;
+		goto out_phy;
 
 	if (chip->info->g2_irqs > 0) {
 		err = mv88e6xxx_g2_irq_setup(chip);
@@ -7360,6 +7360,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		mv88e6xxx_g1_irq_free(chip);
 	else
 		mv88e6xxx_irq_poll_free(chip);
+out_phy:
+	mv88e6xxx_phy_destroy(chip);
 out:
 	if (pdata)
 		dev_put(pdata->netdev);
@@ -7382,7 +7384,6 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 		mv88e6xxx_ptp_free(chip);
 	}
 
-	mv88e6xxx_phy_destroy(chip);
 	mv88e6xxx_unregister_switch(chip);
 
 	mv88e6xxx_g1_vtu_prob_irq_free(chip);
@@ -7395,6 +7396,8 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 		mv88e6xxx_g1_irq_free(chip);
 	else
 		mv88e6xxx_irq_poll_free(chip);
+
+	mv88e6xxx_phy_destroy(chip);
 }
 
 static void mv88e6xxx_shutdown(struct mdio_device *mdiodev)
diff --git a/drivers/net/dsa/mv88e6xxx/phy.c b/drivers/net/dsa/mv88e6xxx/phy.c
index 8bb88b3d900d..ee9e5d7e5277 100644
--- a/drivers/net/dsa/mv88e6xxx/phy.c
+++ b/drivers/net/dsa/mv88e6xxx/phy.c
@@ -229,7 +229,10 @@ static void mv88e6xxx_phy_ppu_state_init(struct mv88e6xxx_chip *chip)
 
 static void mv88e6xxx_phy_ppu_state_destroy(struct mv88e6xxx_chip *chip)
 {
+	mutex_lock(&chip->ppu_mutex);
 	del_timer_sync(&chip->ppu_timer);
+	cancel_work_sync(&chip->ppu_work);
+	mutex_unlock(&chip->ppu_mutex);
 }
 
 int mv88e6185_phy_ppu_read(struct mv88e6xxx_chip *chip, struct mii_bus *bus,
diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 10687722d14c..d6eb6713e5f6 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -44,7 +44,7 @@ config NET_DSA_REALTEK_RTL8366RB
 	  Select to enable support for Realtek RTL8366RB.
 
 config NET_DSA_REALTEK_RTL8366RB_LEDS
-	bool "Support RTL8366RB LED control"
+	bool
 	depends on (LEDS_CLASS=y || LEDS_CLASS=NET_DSA_REALTEK_RTL8366RB)
 	depends on NET_DSA_REALTEK_RTL8366RB
 	default NET_DSA_REALTEK_RTL8366RB
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b619a3ec245b..04192190beba 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1802,18 +1802,22 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 	long value = simple_strtol(buf, NULL, 10);
 	long rc;
 
+	rtnl_lock();
+
 	if (attr == &veth_active_attr) {
 		if (value && !pool->active) {
 			if (netif_running(netdev)) {
 				if (ibmveth_alloc_buffer_pool(pool)) {
 					netdev_err(netdev,
 						   "unable to alloc pool\n");
-					return -ENOMEM;
+					rc = -ENOMEM;
+					goto unlock_err;
 				}
 				pool->active = 1;
 				ibmveth_close(netdev);
-				if ((rc = ibmveth_open(netdev)))
-					return rc;
+				rc = ibmveth_open(netdev);
+				if (rc)
+					goto unlock_err;
 			} else {
 				pool->active = 1;
 			}
@@ -1833,48 +1837,59 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
 
 			if (i == IBMVETH_NUM_BUFF_POOLS) {
 				netdev_err(netdev, "no active pool >= MTU\n");
-				return -EPERM;
+				rc = -EPERM;
+				goto unlock_err;
 			}
 
 			if (netif_running(netdev)) {
 				ibmveth_close(netdev);
 				pool->active = 0;
-				if ((rc = ibmveth_open(netdev)))
-					return rc;
+				rc = ibmveth_open(netdev);
+				if (rc)
+					goto unlock_err;
 			}
 			pool->active = 0;
 		}
 	} else if (attr == &veth_num_attr) {
 		if (value <= 0 || value > IBMVETH_MAX_POOL_COUNT) {
-			return -EINVAL;
+			rc = -EINVAL;
+			goto unlock_err;
 		} else {
 			if (netif_running(netdev)) {
 				ibmveth_close(netdev);
 				pool->size = value;
-				if ((rc = ibmveth_open(netdev)))
-					return rc;
+				rc = ibmveth_open(netdev);
+				if (rc)
+					goto unlock_err;
 			} else {
 				pool->size = value;
 			}
 		}
 	} else if (attr == &veth_size_attr) {
 		if (value <= IBMVETH_BUFF_OH || value > IBMVETH_MAX_BUF_SIZE) {
-			return -EINVAL;
+			rc = -EINVAL;
+			goto unlock_err;
 		} else {
 			if (netif_running(netdev)) {
 				ibmveth_close(netdev);
 				pool->buff_size = value;
-				if ((rc = ibmveth_open(netdev)))
-					return rc;
+				rc = ibmveth_open(netdev);
+				if (rc)
+					goto unlock_err;
 			} else {
 				pool->buff_size = value;
 			}
 		}
 	}
+	rtnl_unlock();
 
 	/* kick the interrupt handler to allocate/deallocate pools */
 	ibmveth_interrupt(netdev->irq, netdev);
 	return count;
+
+unlock_err:
+	rtnl_unlock();
+	return rc;
 }
 
 
diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 5e2cfa73f889..8294a7c4f122 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -803,4 +803,7 @@
 /* SerDes Control */
 #define E1000_GEN_POLL_TIMEOUT          640
 
+#define E1000_FEXTNVM12_PHYPD_CTRL_MASK	0x00C00000
+#define E1000_FEXTNVM12_PHYPD_CTRL_P1	0x00800000
+
 #endif /* _E1000_DEFINES_H_ */
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 2f9655cf5dd9..364378133526 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -285,6 +285,45 @@ static void e1000_toggle_lanphypc_pch_lpt(struct e1000_hw *hw)
 	}
 }
 
+/**
+ * e1000_reconfigure_k1_exit_timeout - reconfigure K1 exit timeout to
+ * align to MTP and later platform requirements.
+ * @hw: pointer to the HW structure
+ *
+ * Context: PHY semaphore must be held by caller.
+ * Return: 0 on success, negative on failure
+ */
+static s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)
+{
+	u16 phy_timeout;
+	u32 fextnvm12;
+	s32 ret_val;
+
+	if (hw->mac.type < e1000_pch_mtp)
+		return 0;
+
+	/* Change Kumeran K1 power down state from P0s to P1 */
+	fextnvm12 = er32(FEXTNVM12);
+	fextnvm12 &= ~E1000_FEXTNVM12_PHYPD_CTRL_MASK;
+	fextnvm12 |= E1000_FEXTNVM12_PHYPD_CTRL_P1;
+	ew32(FEXTNVM12, fextnvm12);
+
+	/* Wait for the interface the settle */
+	usleep_range(1000, 1100);
+
+	/* Change K1 exit timeout */
+	ret_val = e1e_rphy_locked(hw, I217_PHY_TIMEOUTS_REG,
+				  &phy_timeout);
+	if (ret_val)
+		return ret_val;
+
+	phy_timeout &= ~I217_PHY_TIMEOUTS_K1_EXIT_TO_MASK;
+	phy_timeout |= 0xF00;
+
+	return e1e_wphy_locked(hw, I217_PHY_TIMEOUTS_REG,
+				  phy_timeout);
+}
+
 /**
  *  e1000_init_phy_workarounds_pchlan - PHY initialization workarounds
  *  @hw: pointer to the HW structure
@@ -327,15 +366,22 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 	 * LANPHYPC Value bit to force the interconnect to PCIe mode.
 	 */
 	switch (hw->mac.type) {
+	case e1000_pch_mtp:
+	case e1000_pch_lnp:
+	case e1000_pch_ptp:
+	case e1000_pch_nvp:
+		/* At this point the PHY might be inaccessible so don't
+		 * propagate the failure
+		 */
+		if (e1000_reconfigure_k1_exit_timeout(hw))
+			e_dbg("Failed to reconfigure K1 exit timeout\n");
+
+		fallthrough;
 	case e1000_pch_lpt:
 	case e1000_pch_spt:
 	case e1000_pch_cnp:
 	case e1000_pch_tgp:
 	case e1000_pch_adp:
-	case e1000_pch_mtp:
-	case e1000_pch_lnp:
-	case e1000_pch_ptp:
-	case e1000_pch_nvp:
 		if (e1000_phy_is_accessible_pchlan(hw))
 			break;
 
@@ -419,8 +465,20 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		 *  the PHY is in.
 		 */
 		ret_val = hw->phy.ops.check_reset_block(hw);
-		if (ret_val)
+		if (ret_val) {
 			e_err("ME blocked access to PHY after reset\n");
+			goto out;
+		}
+
+		if (hw->mac.type >= e1000_pch_mtp) {
+			ret_val = hw->phy.ops.acquire(hw);
+			if (ret_val) {
+				e_err("Failed to reconfigure K1 exit timeout\n");
+				goto out;
+			}
+			ret_val = e1000_reconfigure_k1_exit_timeout(hw);
+			hw->phy.ops.release(hw);
+		}
 	}
 
 out:
@@ -4888,6 +4946,18 @@ static s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 	u16 i;
 
 	e1000_initialize_hw_bits_ich8lan(hw);
+	if (hw->mac.type >= e1000_pch_mtp) {
+		ret_val = hw->phy.ops.acquire(hw);
+		if (ret_val)
+			return ret_val;
+
+		ret_val = e1000_reconfigure_k1_exit_timeout(hw);
+		hw->phy.ops.release(hw);
+		if (ret_val) {
+			e_dbg("Error failed to reconfigure K1 exit timeout\n");
+			return ret_val;
+		}
+	}
 
 	/* Initialize identification LED */
 	ret_val = mac->ops.id_led_init(hw);
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 2504b11c3169..5feb589a9b5f 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -219,6 +219,10 @@
 #define I217_PLL_CLOCK_GATE_REG	PHY_REG(772, 28)
 #define I217_PLL_CLOCK_GATE_MASK	0x07FF
 
+/* PHY Timeouts */
+#define I217_PHY_TIMEOUTS_REG                   PHY_REG(770, 21)
+#define I217_PHY_TIMEOUTS_K1_EXIT_TO_MASK       0x0FC0
+
 #define SW_FLAG_TIMEOUT		1000	/* SW Semaphore flag timeout in ms */
 
 /* Inband Control */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index dfd56fc5ff65..7557bb6694c0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -87,7 +87,11 @@ static void idpf_remove(struct pci_dev *pdev)
  */
 static void idpf_shutdown(struct pci_dev *pdev)
 {
-	idpf_remove(pdev);
+	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&adapter->vc_event_task);
+	idpf_vc_core_deinit(adapter);
+	idpf_deinit_dflt_mbx(adapter);
 
 	if (system_state == SYSTEM_POWER_OFF)
 		pci_set_power_state(pdev, PCI_D3hot);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index f0537826f840..9c1fe84108ed 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -438,7 +438,8 @@ struct idpf_q_vector {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_q_vector, 112,
-			    424 + 2 * sizeof(struct dim),
+			    24 + sizeof(struct napi_struct) +
+			    2 * sizeof(struct dim),
 			    8 + sizeof(cpumask_var_t));
 
 struct idpf_rx_queue_stats {
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 9e02e4367bec..9bd3d76b5fe2 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -1108,6 +1108,9 @@ struct mvpp2 {
 
 	/* Spinlocks for CM3 shared memory configuration */
 	spinlock_t mss_spinlock;
+
+	/* Spinlock for shared PRS parser memory and shadow table */
+	spinlock_t prs_spinlock;
 };
 
 struct mvpp2_pcpu_stats {
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 3880dcc0418b..66b5a80c9c28 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7640,8 +7640,9 @@ static int mvpp2_probe(struct platform_device *pdev)
 	if (mvpp2_read(priv, MVPP2_VER_ID_REG) == MVPP2_VER_PP23)
 		priv->hw_version = MVPP23;
 
-	/* Init mss lock */
+	/* Init locks for shared packet processor resources */
 	spin_lock_init(&priv->mss_spinlock);
+	spin_lock_init(&priv->prs_spinlock);
 
 	/* Initialize network controller */
 	err = mvpp2_init(pdev, priv);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index 9af22f497a40..93e978bdf303 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -23,6 +23,8 @@ static int mvpp2_prs_hw_write(struct mvpp2 *priv, struct mvpp2_prs_entry *pe)
 {
 	int i;
 
+	lockdep_assert_held(&priv->prs_spinlock);
+
 	if (pe->index > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
 		return -EINVAL;
 
@@ -43,11 +45,13 @@ static int mvpp2_prs_hw_write(struct mvpp2 *priv, struct mvpp2_prs_entry *pe)
 }
 
 /* Initialize tcam entry from hw */
-int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
-			   int tid)
+static int __mvpp2_prs_init_from_hw(struct mvpp2 *priv,
+				    struct mvpp2_prs_entry *pe, int tid)
 {
 	int i;
 
+	lockdep_assert_held(&priv->prs_spinlock);
+
 	if (tid > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
 		return -EINVAL;
 
@@ -73,6 +77,18 @@ int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
 	return 0;
 }
 
+int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
+			   int tid)
+{
+	int err;
+
+	spin_lock_bh(&priv->prs_spinlock);
+	err = __mvpp2_prs_init_from_hw(priv, pe, tid);
+	spin_unlock_bh(&priv->prs_spinlock);
+
+	return err;
+}
+
 /* Invalidate tcam hw entry */
 static void mvpp2_prs_hw_inv(struct mvpp2 *priv, int index)
 {
@@ -374,7 +390,7 @@ static int mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_FLOWS)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 		bits = mvpp2_prs_sram_ai_get(&pe);
 
 		/* Sram store classification lookup ID in AI bits [5:0] */
@@ -441,7 +457,7 @@ static void mvpp2_prs_mac_drop_all_set(struct mvpp2 *priv, int port, bool add)
 
 	if (priv->prs_shadow[MVPP2_PE_DROP_ALL].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, MVPP2_PE_DROP_ALL);
+		__mvpp2_prs_init_from_hw(priv, &pe, MVPP2_PE_DROP_ALL);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -469,14 +485,17 @@ static void mvpp2_prs_mac_drop_all_set(struct mvpp2 *priv, int port, bool add)
 }
 
 /* Set port to unicast or multicast promiscuous mode */
-void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
-			       enum mvpp2_prs_l2_cast l2_cast, bool add)
+static void __mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
+					enum mvpp2_prs_l2_cast l2_cast,
+					bool add)
 {
 	struct mvpp2_prs_entry pe;
 	unsigned char cast_match;
 	unsigned int ri;
 	int tid;
 
+	lockdep_assert_held(&priv->prs_spinlock);
+
 	if (l2_cast == MVPP2_PRS_L2_UNI_CAST) {
 		cast_match = MVPP2_PRS_UCAST_VAL;
 		tid = MVPP2_PE_MAC_UC_PROMISCUOUS;
@@ -489,7 +508,7 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 
 	/* promiscuous mode - Accept unknown unicast or multicast packets */
 	if (priv->prs_shadow[tid].valid) {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 	} else {
 		memset(&pe, 0, sizeof(pe));
 		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
@@ -522,6 +541,14 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 	mvpp2_prs_hw_write(priv, &pe);
 }
 
+void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
+			       enum mvpp2_prs_l2_cast l2_cast, bool add)
+{
+	spin_lock_bh(&priv->prs_spinlock);
+	__mvpp2_prs_mac_promisc_set(priv, port, l2_cast, add);
+	spin_unlock_bh(&priv->prs_spinlock);
+}
+
 /* Set entry for dsa packets */
 static void mvpp2_prs_dsa_tag_set(struct mvpp2 *priv, int port, bool add,
 				  bool tagged, bool extend)
@@ -539,7 +566,7 @@ static void mvpp2_prs_dsa_tag_set(struct mvpp2 *priv, int port, bool add,
 
 	if (priv->prs_shadow[tid].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -610,7 +637,7 @@ static void mvpp2_prs_dsa_tag_ethertype_set(struct mvpp2 *priv, int port,
 
 	if (priv->prs_shadow[tid].valid) {
 		/* Entry exist - update port only */
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -673,7 +700,7 @@ static int mvpp2_prs_vlan_find(struct mvpp2 *priv, unsigned short tpid, int ai)
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 		match = mvpp2_prs_tcam_data_cmp(&pe, 0, tpid);
 		if (!match)
 			continue;
@@ -726,7 +753,7 @@ static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
+			__mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
 			ri_bits = mvpp2_prs_sram_ri_get(&pe);
 			if ((ri_bits & MVPP2_PRS_RI_VLAN_MASK) ==
 			    MVPP2_PRS_RI_VLAN_DOUBLE)
@@ -760,7 +787,7 @@ static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 
 		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 	}
 	/* Update ports' mask */
 	mvpp2_prs_tcam_port_map_set(&pe, port_map);
@@ -800,7 +827,7 @@ static int mvpp2_prs_double_vlan_find(struct mvpp2 *priv, unsigned short tpid1,
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 
 		match = mvpp2_prs_tcam_data_cmp(&pe, 0, tpid1) &&
 			mvpp2_prs_tcam_data_cmp(&pe, 4, tpid2);
@@ -849,7 +876,7 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
+			__mvpp2_prs_init_from_hw(priv, &pe, tid_aux);
 			ri_bits = mvpp2_prs_sram_ri_get(&pe);
 			ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
 			if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
@@ -880,7 +907,7 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 
 		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 	}
 
 	/* Update ports' mask */
@@ -1213,8 +1240,8 @@ static void mvpp2_prs_mac_init(struct mvpp2 *priv)
 	/* Create dummy entries for drop all and promiscuous modes */
 	mvpp2_prs_drop_fc(priv);
 	mvpp2_prs_mac_drop_all_set(priv, 0, false);
-	mvpp2_prs_mac_promisc_set(priv, 0, MVPP2_PRS_L2_UNI_CAST, false);
-	mvpp2_prs_mac_promisc_set(priv, 0, MVPP2_PRS_L2_MULTI_CAST, false);
+	__mvpp2_prs_mac_promisc_set(priv, 0, MVPP2_PRS_L2_UNI_CAST, false);
+	__mvpp2_prs_mac_promisc_set(priv, 0, MVPP2_PRS_L2_MULTI_CAST, false);
 }
 
 /* Set default entries for various types of dsa packets */
@@ -1533,12 +1560,6 @@ static int mvpp2_prs_vlan_init(struct platform_device *pdev, struct mvpp2 *priv)
 	struct mvpp2_prs_entry pe;
 	int err;
 
-	priv->prs_double_vlans = devm_kcalloc(&pdev->dev, sizeof(bool),
-					      MVPP2_PRS_DBL_VLANS_MAX,
-					      GFP_KERNEL);
-	if (!priv->prs_double_vlans)
-		return -ENOMEM;
-
 	/* Double VLAN: 0x88A8, 0x8100 */
 	err = mvpp2_prs_double_vlan_add(priv, ETH_P_8021AD, ETH_P_8021Q,
 					MVPP2_PRS_PORT_MASK);
@@ -1941,7 +1962,7 @@ static int mvpp2_prs_vid_range_find(struct mvpp2_port *port, u16 vid, u16 mask)
 		    port->priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VID)
 			continue;
 
-		mvpp2_prs_init_from_hw(port->priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(port->priv, &pe, tid);
 
 		mvpp2_prs_tcam_data_byte_get(&pe, 2, &byte[0], &enable[0]);
 		mvpp2_prs_tcam_data_byte_get(&pe, 3, &byte[1], &enable[1]);
@@ -1970,6 +1991,8 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	/* Scan TCAM and see if entry with this <vid,port> already exist */
 	tid = mvpp2_prs_vid_range_find(port, vid, mask);
 
@@ -1988,8 +2011,10 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 						MVPP2_PRS_VLAN_FILT_MAX_ENTRY);
 
 		/* There isn't room for a new VID filter */
-		if (tid < 0)
+		if (tid < 0) {
+			spin_unlock_bh(&priv->prs_spinlock);
 			return tid;
+		}
 
 		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VID);
 		pe.index = tid;
@@ -1997,7 +2022,7 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 		/* Mask all ports */
 		mvpp2_prs_tcam_port_map_set(&pe, 0);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 	}
 
 	/* Enable the current port */
@@ -2019,6 +2044,7 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
 	mvpp2_prs_hw_write(priv, &pe);
 
+	spin_unlock_bh(&priv->prs_spinlock);
 	return 0;
 }
 
@@ -2028,15 +2054,16 @@ void mvpp2_prs_vid_entry_remove(struct mvpp2_port *port, u16 vid)
 	struct mvpp2 *priv = port->priv;
 	int tid;
 
-	/* Scan TCAM and see if entry with this <vid,port> already exist */
-	tid = mvpp2_prs_vid_range_find(port, vid, 0xfff);
+	spin_lock_bh(&priv->prs_spinlock);
 
-	/* No such entry */
-	if (tid < 0)
-		return;
+	/* Invalidate TCAM entry with this <vid,port>, if it exists */
+	tid = mvpp2_prs_vid_range_find(port, vid, 0xfff);
+	if (tid >= 0) {
+		mvpp2_prs_hw_inv(priv, tid);
+		priv->prs_shadow[tid].valid = false;
+	}
 
-	mvpp2_prs_hw_inv(priv, tid);
-	priv->prs_shadow[tid].valid = false;
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Remove all existing VID filters on this port */
@@ -2045,6 +2072,8 @@ void mvpp2_prs_vid_remove_all(struct mvpp2_port *port)
 	struct mvpp2 *priv = port->priv;
 	int tid;
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	for (tid = MVPP2_PRS_VID_PORT_FIRST(port->id);
 	     tid <= MVPP2_PRS_VID_PORT_LAST(port->id); tid++) {
 		if (priv->prs_shadow[tid].valid) {
@@ -2052,6 +2081,8 @@ void mvpp2_prs_vid_remove_all(struct mvpp2_port *port)
 			priv->prs_shadow[tid].valid = false;
 		}
 	}
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Remove VID filering entry for this port */
@@ -2060,10 +2091,14 @@ void mvpp2_prs_vid_disable_filtering(struct mvpp2_port *port)
 	unsigned int tid = MVPP2_PRS_VID_PORT_DFLT(port->id);
 	struct mvpp2 *priv = port->priv;
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	/* Invalidate the guard entry */
 	mvpp2_prs_hw_inv(priv, tid);
 
 	priv->prs_shadow[tid].valid = false;
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Add guard entry that drops packets when no VID is matched on this port */
@@ -2079,6 +2114,8 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	pe.index = tid;
 
 	reg_val = mvpp2_read(priv, MVPP2_MH_REG(port->id));
@@ -2111,6 +2148,8 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
 	/* Update shadow table */
 	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VID);
 	mvpp2_prs_hw_write(priv, &pe);
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 /* Parser default initialization */
@@ -2118,6 +2157,20 @@ int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
 {
 	int err, index, i;
 
+	priv->prs_shadow = devm_kcalloc(&pdev->dev, MVPP2_PRS_TCAM_SRAM_SIZE,
+					sizeof(*priv->prs_shadow),
+					GFP_KERNEL);
+	if (!priv->prs_shadow)
+		return -ENOMEM;
+
+	priv->prs_double_vlans = devm_kcalloc(&pdev->dev, sizeof(bool),
+					      MVPP2_PRS_DBL_VLANS_MAX,
+					      GFP_KERNEL);
+	if (!priv->prs_double_vlans)
+		return -ENOMEM;
+
+	spin_lock_bh(&priv->prs_spinlock);
+
 	/* Enable tcam table */
 	mvpp2_write(priv, MVPP2_PRS_TCAM_CTRL_REG, MVPP2_PRS_TCAM_EN_MASK);
 
@@ -2136,12 +2189,6 @@ int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
 	for (index = 0; index < MVPP2_PRS_TCAM_SRAM_SIZE; index++)
 		mvpp2_prs_hw_inv(priv, index);
 
-	priv->prs_shadow = devm_kcalloc(&pdev->dev, MVPP2_PRS_TCAM_SRAM_SIZE,
-					sizeof(*priv->prs_shadow),
-					GFP_KERNEL);
-	if (!priv->prs_shadow)
-		return -ENOMEM;
-
 	/* Always start from lookup = 0 */
 	for (index = 0; index < MVPP2_MAX_PORTS; index++)
 		mvpp2_prs_hw_port_init(priv, index, MVPP2_PRS_LU_MH,
@@ -2158,26 +2205,13 @@ int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
 	mvpp2_prs_vid_init(priv);
 
 	err = mvpp2_prs_etype_init(priv);
-	if (err)
-		return err;
-
-	err = mvpp2_prs_vlan_init(pdev, priv);
-	if (err)
-		return err;
-
-	err = mvpp2_prs_pppoe_init(priv);
-	if (err)
-		return err;
-
-	err = mvpp2_prs_ip6_init(priv);
-	if (err)
-		return err;
-
-	err = mvpp2_prs_ip4_init(priv);
-	if (err)
-		return err;
+	err = err ? : mvpp2_prs_vlan_init(pdev, priv);
+	err = err ? : mvpp2_prs_pppoe_init(priv);
+	err = err ? : mvpp2_prs_ip6_init(priv);
+	err = err ? : mvpp2_prs_ip4_init(priv);
 
-	return 0;
+	spin_unlock_bh(&priv->prs_spinlock);
+	return err;
 }
 
 /* Compare MAC DA with tcam entry data */
@@ -2217,7 +2251,7 @@ mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 		    (priv->prs_shadow[tid].udf != udf_type))
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 		entry_pmap = mvpp2_prs_tcam_port_map_get(&pe);
 
 		if (mvpp2_prs_mac_range_equals(&pe, da, mask) &&
@@ -2229,7 +2263,8 @@ mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 }
 
 /* Update parser's mac da entry */
-int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
+static int __mvpp2_prs_mac_da_accept(struct mvpp2_port *port,
+				     const u8 *da, bool add)
 {
 	unsigned char mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 	struct mvpp2 *priv = port->priv;
@@ -2261,7 +2296,7 @@ int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
 		/* Mask all ports */
 		mvpp2_prs_tcam_port_map_set(&pe, 0);
 	} else {
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 	}
 
 	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
@@ -2317,6 +2352,17 @@ int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
 	return 0;
 }
 
+int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da, bool add)
+{
+	int err;
+
+	spin_lock_bh(&port->priv->prs_spinlock);
+	err = __mvpp2_prs_mac_da_accept(port, da, add);
+	spin_unlock_bh(&port->priv->prs_spinlock);
+
+	return err;
+}
+
 int mvpp2_prs_update_mac_da(struct net_device *dev, const u8 *da)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
@@ -2345,6 +2391,8 @@ void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
 	unsigned long pmap;
 	int index, tid;
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	for (tid = MVPP2_PE_MAC_RANGE_START;
 	     tid <= MVPP2_PE_MAC_RANGE_END; tid++) {
 		unsigned char da[ETH_ALEN], da_mask[ETH_ALEN];
@@ -2354,7 +2402,7 @@ void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
 		    (priv->prs_shadow[tid].udf != MVPP2_PRS_UDF_MAC_DEF))
 			continue;
 
-		mvpp2_prs_init_from_hw(priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(priv, &pe, tid);
 
 		pmap = mvpp2_prs_tcam_port_map_get(&pe);
 
@@ -2375,14 +2423,17 @@ void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
 			continue;
 
 		/* Remove entry from TCAM */
-		mvpp2_prs_mac_da_accept(port, da, false);
+		__mvpp2_prs_mac_da_accept(port, da, false);
 	}
+
+	spin_unlock_bh(&priv->prs_spinlock);
 }
 
 int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 {
 	switch (type) {
 	case MVPP2_TAG_TYPE_EDSA:
+		spin_lock_bh(&priv->prs_spinlock);
 		/* Add port to EDSA entries */
 		mvpp2_prs_dsa_tag_set(priv, port, true,
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
@@ -2393,9 +2444,11 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
+		spin_unlock_bh(&priv->prs_spinlock);
 		break;
 
 	case MVPP2_TAG_TYPE_DSA:
+		spin_lock_bh(&priv->prs_spinlock);
 		/* Add port to DSA entries */
 		mvpp2_prs_dsa_tag_set(priv, port, true,
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
@@ -2406,10 +2459,12 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
+		spin_unlock_bh(&priv->prs_spinlock);
 		break;
 
 	case MVPP2_TAG_TYPE_MH:
 	case MVPP2_TAG_TYPE_NONE:
+		spin_lock_bh(&priv->prs_spinlock);
 		/* Remove port form EDSA and DSA entries */
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
@@ -2419,6 +2474,7 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
+		spin_unlock_bh(&priv->prs_spinlock);
 		break;
 
 	default:
@@ -2437,11 +2493,15 @@ int mvpp2_prs_add_flow(struct mvpp2 *priv, int flow, u32 ri, u32 ri_mask)
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	tid = mvpp2_prs_tcam_first_free(priv,
 					MVPP2_PE_LAST_FREE_TID,
 					MVPP2_PE_FIRST_FREE_TID);
-	if (tid < 0)
+	if (tid < 0) {
+		spin_unlock_bh(&priv->prs_spinlock);
 		return tid;
+	}
 
 	pe.index = tid;
 
@@ -2461,6 +2521,7 @@ int mvpp2_prs_add_flow(struct mvpp2 *priv, int flow, u32 ri, u32 ri_mask)
 	mvpp2_prs_tcam_port_map_set(&pe, MVPP2_PRS_PORT_MASK);
 	mvpp2_prs_hw_write(priv, &pe);
 
+	spin_unlock_bh(&priv->prs_spinlock);
 	return 0;
 }
 
@@ -2472,6 +2533,8 @@ int mvpp2_prs_def_flow(struct mvpp2_port *port)
 
 	memset(&pe, 0, sizeof(pe));
 
+	spin_lock_bh(&port->priv->prs_spinlock);
+
 	tid = mvpp2_prs_flow_find(port->priv, port->id);
 
 	/* Such entry not exist */
@@ -2480,8 +2543,10 @@ int mvpp2_prs_def_flow(struct mvpp2_port *port)
 		tid = mvpp2_prs_tcam_first_free(port->priv,
 						MVPP2_PE_LAST_FREE_TID,
 					       MVPP2_PE_FIRST_FREE_TID);
-		if (tid < 0)
+		if (tid < 0) {
+			spin_unlock_bh(&port->priv->prs_spinlock);
 			return tid;
+		}
 
 		pe.index = tid;
 
@@ -2492,13 +2557,14 @@ int mvpp2_prs_def_flow(struct mvpp2_port *port)
 		/* Update shadow table */
 		mvpp2_prs_shadow_set(port->priv, pe.index, MVPP2_PRS_LU_FLOWS);
 	} else {
-		mvpp2_prs_init_from_hw(port->priv, &pe, tid);
+		__mvpp2_prs_init_from_hw(port->priv, &pe, tid);
 	}
 
 	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
 	mvpp2_prs_tcam_port_map_set(&pe, (1 << port->id));
 	mvpp2_prs_hw_write(port->priv, &pe);
 
+	spin_unlock_bh(&port->priv->prs_spinlock);
 	return 0;
 }
 
@@ -2509,11 +2575,14 @@ int mvpp2_prs_hits(struct mvpp2 *priv, int index)
 	if (index > MVPP2_PRS_TCAM_SRAM_SIZE)
 		return -EINVAL;
 
+	spin_lock_bh(&priv->prs_spinlock);
+
 	mvpp2_write(priv, MVPP2_PRS_TCAM_HIT_IDX_REG, index);
 
 	val = mvpp2_read(priv, MVPP2_PRS_TCAM_HIT_CNT_REG);
 
 	val &= MVPP2_PRS_TCAM_HIT_CNT_MASK;
 
+	spin_unlock_bh(&priv->prs_spinlock);
 	return val;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index cd0d7b7774f1..6575c422635b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2634,7 +2634,7 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
 		rvupf_write64(rvu, RVU_PF_VFPF_MBOX_INTX(1), intr);
 
 		rvu_queue_work(&rvu->afvf_wq_info, 64, vfs, intr);
-		vfs -= 64;
+		vfs = 64;
 	}
 
 	intr = rvupf_read64(rvu, RVU_PF_VFPF_MBOX_INTX(0));
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 7498ab429963..06f778baaeef 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -207,7 +207,7 @@ static void rvu_nix_unregister_interrupts(struct rvu *rvu)
 		rvu->irq_allocated[offs + NIX_AF_INT_VEC_RVU] = false;
 	}
 
-	for (i = NIX_AF_INT_VEC_AF_ERR; i < NIX_AF_INT_VEC_CNT; i++)
+	for (i = NIX_AF_INT_VEC_GEN; i < NIX_AF_INT_VEC_CNT; i++)
 		if (rvu->irq_allocated[offs + i]) {
 			free_irq(pci_irq_vector(rvu->pdev, offs + i), rvu_dl);
 			rvu->irq_allocated[offs + i] = false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 64b62ed17b07..31eb99f09c63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -423,7 +423,7 @@ u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5_core_dev *mdev,
 				     struct mlx5e_params *params)
 {
 	u32 resrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
-			 PAGE_SIZE;
+			 MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
 
 	return order_base_2(DIV_ROUND_UP(resrv_size, params->sw_mtu));
 }
@@ -827,7 +827,8 @@ static u32 mlx5e_shampo_get_log_cq_size(struct mlx5_core_dev *mdev,
 					struct mlx5e_params *params,
 					struct mlx5e_xsk_param *xsk)
 {
-	int rsrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) * PAGE_SIZE;
+	int rsrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
+		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
 	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk));
 	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
 	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
@@ -1036,7 +1037,8 @@ u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
 			    struct mlx5e_rq_param *rq_param)
 {
-	int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) * PAGE_SIZE;
+	int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
+		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
 	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, NULL));
 	int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
 	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, NULL);
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index ddded162c44c..d2a9cf3fde5a 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -859,7 +859,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		return reg;
 
 	/* Unmask events we are interested in and mask interrupts globally. */
-	if (phydev->phy_id == PHY_ID_BCM5221)
+	if (phydev->drv->phy_id == PHY_ID_BCM5221)
 		reg = MII_BRCM_FET_IR_ENABLE |
 		      MII_BRCM_FET_IR_MASK;
 	else
@@ -888,7 +888,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		return err;
 	}
 
-	if (phydev->phy_id != PHY_ID_BCM5221) {
+	if (phydev->drv->phy_id != PHY_ID_BCM5221) {
 		/* Set the LED mode */
 		reg = __phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
 		if (reg < 0) {
@@ -1009,7 +1009,7 @@ static int brcm_fet_suspend(struct phy_device *phydev)
 		return err;
 	}
 
-	if (phydev->phy_id == PHY_ID_BCM5221)
+	if (phydev->drv->phy_id == PHY_ID_BCM5221)
 		/* Force Low Power Mode with clock enabled */
 		reg = BCM5221_SHDW_AM4_EN_CLK_LPM | BCM5221_SHDW_AM4_FORCE_LPM;
 	else
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 7b3739b29c8f..bb0bf1415872 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -630,6 +630,16 @@ static const struct driver_info	zte_rndis_info = {
 	.tx_fixup =	rndis_tx_fixup,
 };
 
+static const struct driver_info	wwan_rndis_info = {
+	.description =	"Mobile Broadband RNDIS device",
+	.flags =	FLAG_WWAN | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT,
+	.bind =		rndis_bind,
+	.unbind =	rndis_unbind,
+	.status =	rndis_status,
+	.rx_fixup =	rndis_rx_fixup,
+	.tx_fixup =	rndis_tx_fixup,
+};
+
 /*-------------------------------------------------------------------------*/
 
 static const struct usb_device_id	products [] = {
@@ -666,9 +676,11 @@ static const struct usb_device_id	products [] = {
 	USB_INTERFACE_INFO(USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
 	.driver_info = (unsigned long) &rndis_info,
 }, {
-	/* Novatel Verizon USB730L */
+	/* Mobile Broadband Modem, seen in Novatel Verizon USB730L and
+	 * Telit FN990A (RNDIS)
+	 */
 	USB_INTERFACE_INFO(USB_CLASS_MISC, 4, 1),
-	.driver_info = (unsigned long) &rndis_info,
+	.driver_info = (unsigned long)&wwan_rndis_info,
 },
 	{ },		// END
 };
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index aeab2308b150..724b93aa4f7e 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -530,7 +530,8 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 	    netif_device_present (dev->net) &&
 	    test_bit(EVENT_DEV_OPEN, &dev->flags) &&
 	    !test_bit (EVENT_RX_HALT, &dev->flags) &&
-	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags)) {
+	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags) &&
+	    !usbnet_going_away(dev)) {
 		switch (retval = usb_submit_urb (urb, GFP_ATOMIC)) {
 		case -EPIPE:
 			usbnet_defer_kevent (dev, EVENT_RX_HALT);
@@ -551,8 +552,7 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 			tasklet_schedule (&dev->bh);
 			break;
 		case 0:
-			if (!usbnet_going_away(dev))
-				__usbnet_queue_skb(&dev->rxq, skb, rx_start);
+			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
 		}
 	} else {
 		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 8a1e33764244..cfdd92564060 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1167,6 +1167,7 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	struct brcmf_bus *bus_if;
 	struct brcmf_sdio_dev *sdiodev;
 	mmc_pm_flag_t sdio_flags;
+	bool cap_power_off;
 	int ret = 0;
 
 	func = container_of(dev, struct sdio_func, dev);
@@ -1174,19 +1175,23 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	if (func->num != 1)
 		return 0;
 
+	cap_power_off = !!(func->card->host->caps & MMC_CAP_POWER_OFF_CARD);
 
 	bus_if = dev_get_drvdata(dev);
 	sdiodev = bus_if->bus_priv.sdio;
 
-	if (sdiodev->wowl_enabled) {
+	if (sdiodev->wowl_enabled || !cap_power_off) {
 		brcmf_sdiod_freezer_on(sdiodev);
 		brcmf_sdio_wd_timer(sdiodev->bus, 0);
 
 		sdio_flags = MMC_PM_KEEP_POWER;
-		if (sdiodev->settings->bus.sdio.oob_irq_supported)
-			enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
-		else
-			sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
+
+		if (sdiodev->wowl_enabled) {
+			if (sdiodev->settings->bus.sdio.oob_irq_supported)
+				enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
+			else
+				sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
+		}
 
 		if (sdio_set_host_pm_flags(sdiodev->func1, sdio_flags))
 			brcmf_err("Failed to set pm_flags %x\n", sdio_flags);
@@ -1208,18 +1213,19 @@ static int brcmf_ops_sdio_resume(struct device *dev)
 	struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
 	struct sdio_func *func = container_of(dev, struct sdio_func, dev);
 	int ret = 0;
+	bool cap_power_off = !!(func->card->host->caps & MMC_CAP_POWER_OFF_CARD);
 
 	brcmf_dbg(SDIO, "Enter: F%d\n", func->num);
 	if (func->num != 2)
 		return 0;
 
-	if (!sdiodev->wowl_enabled) {
+	if (!sdiodev->wowl_enabled && cap_power_off) {
 		/* bus was powered off and device removed, probe again */
 		ret = brcmf_sdiod_probe(sdiodev);
 		if (ret)
 			brcmf_err("Failed to probe device on resume\n");
 	} else {
-		if (sdiodev->settings->bus.sdio.oob_irq_supported)
+		if (sdiodev->wowl_enabled && sdiodev->settings->bus.sdio.oob_irq_supported)
 			disable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
 
 		brcmf_sdiod_freezer_off(sdiodev);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index fb2ea38e89ac..6594216f873c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -558,41 +558,71 @@ static void iwl_dump_prph(struct iwl_fw_runtime *fwrt,
 }
 
 /*
- * alloc_sgtable - allocates scallerlist table in the given size,
- * fills it with pages and returns it
+ * alloc_sgtable - allocates (chained) scatterlist in the given size,
+ *	fills it with pages and returns it
  * @size: the size (in bytes) of the table
-*/
-static struct scatterlist *alloc_sgtable(int size)
+ */
+static struct scatterlist *alloc_sgtable(ssize_t size)
 {
-	int alloc_size, nents, i;
-	struct page *new_page;
-	struct scatterlist *iter;
-	struct scatterlist *table;
+	struct scatterlist *result = NULL, *prev;
+	int nents, i, n_prev;
 
 	nents = DIV_ROUND_UP(size, PAGE_SIZE);
-	table = kcalloc(nents, sizeof(*table), GFP_KERNEL);
-	if (!table)
-		return NULL;
-	sg_init_table(table, nents);
-	iter = table;
-	for_each_sg(table, iter, sg_nents(table), i) {
-		new_page = alloc_page(GFP_KERNEL);
-		if (!new_page) {
-			/* release all previous allocated pages in the table */
-			iter = table;
-			for_each_sg(table, iter, sg_nents(table), i) {
-				new_page = sg_page(iter);
-				if (new_page)
-					__free_page(new_page);
-			}
-			kfree(table);
+
+#define N_ENTRIES_PER_PAGE (PAGE_SIZE / sizeof(*result))
+	/*
+	 * We need an additional entry for table chaining,
+	 * this ensures the loop can finish i.e. we can
+	 * fit at least two entries per page (obviously,
+	 * many more really fit.)
+	 */
+	BUILD_BUG_ON(N_ENTRIES_PER_PAGE < 2);
+
+	while (nents > 0) {
+		struct scatterlist *new, *iter;
+		int n_fill, n_alloc;
+
+		if (nents <= N_ENTRIES_PER_PAGE) {
+			/* last needed table */
+			n_fill = nents;
+			n_alloc = nents;
+			nents = 0;
+		} else {
+			/* fill a page with entries */
+			n_alloc = N_ENTRIES_PER_PAGE;
+			/* reserve one for chaining */
+			n_fill = n_alloc - 1;
+			nents -= n_fill;
+		}
+
+		new = kcalloc(n_alloc, sizeof(*new), GFP_KERNEL);
+		if (!new) {
+			if (result)
+				_devcd_free_sgtable(result);
 			return NULL;
 		}
-		alloc_size = min_t(int, size, PAGE_SIZE);
-		size -= PAGE_SIZE;
-		sg_set_page(iter, new_page, alloc_size, 0);
+		sg_init_table(new, n_alloc);
+
+		if (!result)
+			result = new;
+		else
+			sg_chain(prev, n_prev, new);
+		prev = new;
+		n_prev = n_alloc;
+
+		for_each_sg(new, iter, n_fill, i) {
+			struct page *new_page = alloc_page(GFP_KERNEL);
+
+			if (!new_page) {
+				_devcd_free_sgtable(result);
+				return NULL;
+			}
+
+			sg_set_page(iter, new_page, PAGE_SIZE, 0);
+		}
 	}
-	return table;
+
+	return result;
 }
 
 static void iwl_fw_get_prph_len(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 65f8933c34b4..0b52d77f5783 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -995,7 +995,7 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 	 */
 	u8 ru = le32_get_bits(phy_data->d1, IWL_RX_PHY_DATA1_HE_RU_ALLOC_MASK);
 	u32 rate_n_flags = phy_data->rate_n_flags;
-	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1;
+	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
 	u8 offs = 0;
 
 	rx_status->bw = RATE_INFO_BW_HE_RU;
@@ -1050,13 +1050,13 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 
 	if (he_mu)
 		he_mu->flags2 |=
-			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
+			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK,
 						   rate_n_flags),
 					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW);
-	else if (he_type == RATE_MCS_HE_TYPE_TRIG_V1)
+	else if (he_type == RATE_MCS_HE_TYPE_TRIG)
 		he->data6 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_KNOWN) |
-			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
+			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK,
 						   rate_n_flags),
 					 IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index e2dfd3670c4c..6a3629f71caa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -805,6 +805,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
 	msta->deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->deflink.last_txs = jiffies;
+	msta->deflink.sta = msta;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index ce3d8197b026..c7eba60897d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3117,7 +3117,6 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 
 		.idx = idx,
 		.env = env_cap,
-		.acpi_conf = mt792x_acpi_get_flags(&dev->phy),
 	};
 	int ret, valid_cnt = 0;
 	u8 i, *pos;
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
index ffcfc3e02c35..a5aa96a31f4a 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -215,6 +215,9 @@ static int gen3_init_ntb(struct intel_ntb_dev *ndev)
 	}
 
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+	/* Make sure we are not using DB's used for link status */
+	if (ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD)
+		ndev->db_valid_mask &= ~ndev->db_link_mask;
 
 	ndev->reg->db_iowrite(ndev->db_valid_mask,
 			      ndev->self_mmio +
diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index ad1786be2554..f851397b65d6 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -288,7 +288,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	if (size != 0 && xlate_pos < 12)
 		return -EINVAL;
 
-	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
+	if (xlate_pos >= 0 && !IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
 		/*
 		 * In certain circumstances we can get a buffer that is
 		 * not aligned to its size. (Most of the time
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 72bc1d017a46..dfd175f79e8f 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -839,10 +839,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	dma_set_unmap(tx, unmap);
 
 	ret = dma_submit_error(dmaengine_submit(tx));
-	if (ret) {
-		dmaengine_unmap_put(unmap);
+	if (ret)
 		goto err_free_resource;
-	}
 
 	dmaengine_unmap_put(unmap);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e4daac9c2440..a1b3c538a4bd 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -141,7 +141,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC)) {
+		if (flags & NVME_IOCTL_VEC) {
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1d3205f08af8..af45a1b865ee 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1413,9 +1413,20 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *abort_req;
 	struct nvme_command cmd = { };
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 	u8 opcode;
 
+	/*
+	 * Shutdown the device immediately if we see it is disconnected. This
+	 * unblocks PCIe error handling if the nvme driver is waiting in
+	 * error_resume for a device that has been removed. We can't unbind the
+	 * driver while the driver's error callback is waiting to complete, so
+	 * we're relying on a timeout to break that deadlock if a removal
+	 * occurs while reset work is running.
+	 */
+	if (pci_dev_is_disconnected(pdev))
+		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	if (nvme_state_terminal(&dev->ctrl))
 		goto disable;
 
@@ -1423,7 +1434,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (pci_channel_offline(pdev))
 		return BLK_EH_RESET_TIMER;
 
 	/*
@@ -1984,6 +1995,18 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (offset > bar_size)
 		return;
 
+	/*
+	 * Controllers may support a CMB size larger than their BAR, for
+	 * example, due to being behind a bridge. Reduce the CMB to the
+	 * reported size of the BAR
+	 */
+	size = min(size, bar_size - offset);
+
+	if (!IS_ALIGNED(size, memremap_compat_align()) ||
+	    !IS_ALIGNED(pci_resource_start(pdev, bar),
+			memremap_compat_align()))
+		return;
+
 	/*
 	 * Tell the controller about the host side address mapping the CMB,
 	 * and enable CMB decoding for the NVMe 1.4+ scheme:
@@ -1994,17 +2017,10 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 			     dev->bar + NVME_REG_CMBMSC);
 	}
 
-	/*
-	 * Controllers may support a CMB size larger than their BAR,
-	 * for example, due to being behind a bridge. Reduce the CMB to
-	 * the reported size of the BAR
-	 */
-	if (size > bar_size - offset)
-		size = bar_size - offset;
-
 	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
 		dev_warn(dev->ctrl.device,
 			 "failed to register the CMB\n");
+		hi_lo_writeq(0, dev->bar + NVME_REG_CMBMSC);
 		return;
 	}
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index eeb05b7bc0fd..854aa6a070ca 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2736,6 +2736,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 	struct sock *sk = queue->sock->sk;
+	int ret;
 
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		return 0;
@@ -2743,9 +2744,9 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
-	nvme_tcp_try_recv(queue);
+	ret = nvme_tcp_try_recv(queue);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-	return queue->nr_cqe;
+	return ret < 0 ? ret : queue->nr_cqe;
 }
 
 static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 220c7391fc19..c6571fbd35e3 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -78,7 +78,7 @@ static int nvmet_ctrl_state_show(struct seq_file *m, void *p)
 	bool sep = false;
 	int i;
 
-	for (i = 0; i < 7; i++) {
+	for (i = 0; i < ARRAY_SIZE(csts_state_names); i++) {
 		int state = BIT(i);
 
 		if (!(ctrl->csts & state))
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..0bf4cde34f51 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
 	spin_unlock_irqrestore(&ep->lock, flags);
 
 	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
-		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
-		 CDNS_PCIE_MSG_NO_DATA;
+		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
 	writel(0, ep->irq_cpu_addr + offset);
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..39ee9945c903 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
 #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
 	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
-#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
+#define CDNS_PCIE_MSG_DATA			BIT(16)
 
 struct cdns_pcie;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index b58e89ea566b..dea19250598a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -755,6 +755,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	if (ret)
 		return ret;
 
+	ret = -ENOMEM;
 	if (!ep->ib_window_map) {
 		ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
 						       GFP_KERNEL);
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 7a11c618b9d9..5538e5bf99fb 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -409,16 +409,21 @@ static int histb_pcie_probe(struct platform_device *pdev)
 	ret = histb_pcie_host_enable(pp);
 	if (ret) {
 		dev_err(dev, "failed to enable host\n");
-		return ret;
+		goto err_exit_phy;
 	}
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
-		return ret;
+		goto err_exit_phy;
 	}
 
 	return 0;
+
+err_exit_phy:
+	phy_exit(hipcie->phy);
+
+	return ret;
 }
 
 static void histb_pcie_remove(struct platform_device *pdev)
@@ -427,8 +432,7 @@ static void histb_pcie_remove(struct platform_device *pdev)
 
 	histb_pcie_host_disable(hipcie);
 
-	if (hipcie->phy)
-		phy_exit(hipcie->phy);
+	phy_exit(hipcie->phy);
 }
 
 static const struct of_device_id histb_pcie_of_match[] = {
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9321280f6edb..582fa1107087 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -403,10 +403,10 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
 static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
 {
 	u16 lnkctl2 = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
-	u32 lnkcap = readl(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
+	u32 lnkcap = readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
 	lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
-	writel(lnkcap, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
+	writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
 	lnkctl2 = (lnkctl2 & ~0xf) | gen;
 	writew(lnkctl2, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
@@ -1276,6 +1276,10 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	bool ssc_good = false;
 	int ret, i;
 
+	/* Limit the generation if specified */
+	if (pcie->gen)
+		brcm_pcie_set_gen(pcie, pcie->gen);
+
 	/* Unassert the fundamental reset */
 	ret = pcie->perst_set(pcie, 0);
 	if (ret)
@@ -1302,9 +1306,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 
 	brcm_config_clkreq(pcie);
 
-	if (pcie->gen)
-		brcm_pcie_set_gen(pcie, pcie->gen);
-
 	if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie);
 		if (ret == 0)
@@ -1367,7 +1368,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
 
 		ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
 		if (ret) {
-			dev_info(dev, "No regulators for downstream device\n");
+			dev_info(dev, "Did not get regulators, err=%d\n", ret);
+			pcie->sr = NULL;
 			goto no_regulators;
 		}
 
@@ -1390,7 +1392,7 @@ static void brcm_pcie_remove_bus(struct pci_bus *bus)
 	struct subdev_regulators *sr = pcie->sr;
 	struct device *dev = &bus->dev;
 
-	if (!sr)
+	if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
 		return;
 
 	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index a0f5e1d67b04..1594d9e9e637 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -570,15 +570,17 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 		return err;
 
 	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
-	if (!bus)
-		return -ENODEV;
+	if (!bus) {
+		err = -ENODEV;
+		goto err_free_irq_domains;
+	}
 
 	port->variant = of_device_get_match_data(dev);
 
 	err = xilinx_cpm_pcie_parse_dt(port, bus->res);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
-		goto err_parse_dt;
+		goto err_free_irq_domains;
 	}
 
 	xilinx_cpm_pcie_init_port(port);
@@ -602,7 +604,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	xilinx_cpm_free_interrupts(port);
 err_setup_irq:
 	pci_ecam_free(port->cfg);
-err_parse_dt:
+err_free_irq_domains:
 	xilinx_cpm_free_irq_domains(port);
 	return err;
 }
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 736ad8baa2a5..8f3e4c7de961 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -842,7 +842,9 @@ void pcie_enable_interrupt(struct controller *ctrl)
 {
 	u16 mask;
 
-	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	mask = PCI_EXP_SLTCTL_DLLSCE;
+	if (!pciehp_poll_mode)
+		mask |= PCI_EXP_SLTCTL_HPIE;
 	pcie_write_cmd(ctrl, mask, mask);
 }
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 3e5a117f5b5d..5af4a804a4f8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1444,7 +1444,7 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 		return -EINVAL;
 
 	device_lock(dev);
-	if (dev->driver) {
+	if (dev->driver || pci_num_vf(pdev)) {
 		ret = -EBUSY;
 		goto unlock;
 	}
@@ -1466,7 +1466,7 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 
 	pci_remove_resource_files(pdev);
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
 		if (pci_resource_len(pdev, i) &&
 		    pci_resource_flags(pdev, i) == flags)
 			pci_release_resource(pdev, i);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1aa5d6f98ebd..169aa8fd74a1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -955,8 +955,10 @@ struct pci_acs {
 };
 
 static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
-			     const char *p, u16 mask, u16 flags)
+			     const char *p, const u16 acs_mask, const u16 acs_flags)
 {
+	u16 flags = acs_flags;
+	u16 mask = acs_mask;
 	char *delimit;
 	int ret = 0;
 
@@ -964,7 +966,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 		return;
 
 	while (*p) {
-		if (!mask) {
+		if (!acs_mask) {
 			/* Check for ACS flags */
 			delimit = strstr(p, "@");
 			if (delimit) {
@@ -972,6 +974,8 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 				u32 shift = 0;
 
 				end = delimit - p - 1;
+				mask = 0;
+				flags = 0;
 
 				while (end > -1) {
 					if (*(p + end) == '0') {
@@ -1028,10 +1032,14 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 
 	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
 	pci_dbg(dev, "ACS flags = %#06x\n", flags);
+	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
+	pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
 
-	/* If mask is 0 then we copy the bit from the firmware setting. */
-	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
-	caps->ctrl |= flags;
+	/*
+	 * For mask bits that are 0, copy them from the firmware setting
+	 * and apply flags for all the mask bits that are 1.
+	 */
+	caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
 
 	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
 }
@@ -5520,6 +5528,8 @@ static bool pci_bus_resettable(struct pci_bus *bus)
 		return false;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (!pci_reset_supported(dev))
+			return false;
 		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
 		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
 			return false;
@@ -5596,6 +5606,8 @@ static bool pci_slot_resettable(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
+		if (!pci_reset_supported(dev))
+			return false;
 		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
 		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
 			return false;
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..62650a2f00cc 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1242,16 +1242,16 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	parent_link = link->parent;
 
 	/*
-	 * link->downstream is a pointer to the pci_dev of function 0.  If
-	 * we remove that function, the pci_dev is about to be deallocated,
-	 * so we can't use link->downstream again.  Free the link state to
-	 * avoid this.
+	 * Free the parent link state, no later than function 0 (i.e.
+	 * link->downstream) being removed.
 	 *
-	 * If we're removing a non-0 function, it's possible we could
-	 * retain the link state, but PCIe r6.0, sec 7.5.3.7, recommends
-	 * programming the same ASPM Control value for all functions of
-	 * multi-function devices, so disable ASPM for all of them.
+	 * Do not free the link state any earlier. If function 0 is a
+	 * switch upstream port, this link state is parent_link to all
+	 * subordinate ones.
 	 */
+	if (pdev != link->downstream)
+		goto out;
+
 	pcie_config_aspm_link(link, 0);
 	list_del(&link->sibling);
 	free_link_state(link);
@@ -1262,6 +1262,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		pcie_config_aspm_path(parent_link);
 	}
 
+ out:
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
 }
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 6af5e0425872..604c055f6078 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -228,10 +228,12 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 		/*
 		 * Disable hot-plug interrupts in case they have been enabled
-		 * by the BIOS and the hot-plug service driver is not loaded.
+		 * by the BIOS and the hot-plug service driver won't be loaded
+		 * to handle them.
 		 */
-		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
-			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+		if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
+				PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
 	}
 
 #ifdef CONFIG_PCIEAER
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ebb0c1d5cae2..0e757b23a09f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -950,10 +950,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	/* Temporarily move resources off the list */
 	list_splice_init(&bridge->windows, &resources);
 	err = device_add(&bridge->dev);
-	if (err) {
-		put_device(&bridge->dev);
+	if (err)
 		goto free;
-	}
+
 	bus->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(bus->bridge);
 	pci_set_bus_of_node(bus);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 23082bc0ca37..f16c7ce3bf3f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1150,7 +1150,6 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		min_align = 1ULL << (max_order + __ffs(SZ_1M));
 		min_align = max(min_align, win_align);
 		size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), win_align);
-		add_align = win_align;
 		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
 			 b_res, &bus->busn_res);
 	}
@@ -2105,8 +2104,7 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
 		 * in case of root bus.
 		 */
 		if (bridge && pci_bridge_resources_not_assigned(dev))
-			pci_bridge_distribute_available_resources(bridge,
-								  add_list);
+			pci_bridge_distribute_available_resources(dev, add_list);
 		else
 			pci_root_bus_distribute_available_resources(b, add_list);
 	}
diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 69c3ec0938f7..be6f1ca9095a 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -266,11 +266,22 @@ enum rk_hdptx_reset {
 	RST_MAX
 };
 
+#define MAX_HDPTX_PHY_NUM	2
+
+struct rk_hdptx_phy_cfg {
+	unsigned int num_phys;
+	unsigned int phy_ids[MAX_HDPTX_PHY_NUM];
+};
+
 struct rk_hdptx_phy {
 	struct device *dev;
 	struct regmap *regmap;
 	struct regmap *grf;
 
+	/* PHY const config */
+	const struct rk_hdptx_phy_cfg *cfgs;
+	int phy_id;
+
 	struct phy *phy;
 	struct phy_config *phy_cfg;
 	struct clk_bulk_data *clks;
@@ -1019,15 +1030,14 @@ static int rk_hdptx_phy_clk_register(struct rk_hdptx_phy *hdptx)
 	struct device *dev = hdptx->dev;
 	const char *name, *pname;
 	struct clk *refclk;
-	int ret, id;
+	int ret;
 
 	refclk = devm_clk_get(dev, "ref");
 	if (IS_ERR(refclk))
 		return dev_err_probe(dev, PTR_ERR(refclk),
 				     "Failed to get ref clock\n");
 
-	id = of_alias_get_id(dev->of_node, "hdptxphy");
-	name = id > 0 ? "clk_hdmiphy_pixel1" : "clk_hdmiphy_pixel0";
+	name = hdptx->phy_id > 0 ? "clk_hdmiphy_pixel1" : "clk_hdmiphy_pixel0";
 	pname = __clk_get_name(refclk);
 
 	hdptx->hw.init = CLK_HW_INIT(name, pname, &hdptx_phy_clk_ops,
@@ -1070,8 +1080,9 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct rk_hdptx_phy *hdptx;
+	struct resource *res;
 	void __iomem *regs;
-	int ret;
+	int ret, id;
 
 	hdptx = devm_kzalloc(dev, sizeof(*hdptx), GFP_KERNEL);
 	if (!hdptx)
@@ -1079,11 +1090,27 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 
 	hdptx->dev = dev;
 
-	regs = devm_platform_ioremap_resource(pdev, 0);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs))
 		return dev_err_probe(dev, PTR_ERR(regs),
 				     "Failed to ioremap resource\n");
 
+	hdptx->cfgs = device_get_match_data(dev);
+	if (!hdptx->cfgs)
+		return dev_err_probe(dev, -EINVAL, "missing match data\n");
+
+	/* find the phy-id from the io address */
+	hdptx->phy_id = -ENODEV;
+	for (id = 0; id < hdptx->cfgs->num_phys; id++) {
+		if (res->start == hdptx->cfgs->phy_ids[id]) {
+			hdptx->phy_id = id;
+			break;
+		}
+	}
+
+	if (hdptx->phy_id < 0)
+		return dev_err_probe(dev, -ENODEV, "no matching device found\n");
+
 	ret = devm_clk_bulk_get_all(dev, &hdptx->clks);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to get clocks\n");
@@ -1147,8 +1174,19 @@ static const struct dev_pm_ops rk_hdptx_phy_pm_ops = {
 		       rk_hdptx_phy_runtime_resume, NULL)
 };
 
+static const struct rk_hdptx_phy_cfg rk3588_hdptx_phy_cfgs = {
+	.num_phys = 2,
+	.phy_ids = {
+		0xfed60000,
+		0xfed70000,
+	},
+};
+
 static const struct of_device_id rk_hdptx_phy_of_match[] = {
-	{ .compatible = "rockchip,rk3588-hdptx-phy", },
+	{
+		.compatible = "rockchip,rk3588-hdptx-phy",
+		.data = &rk3588_hdptx_phy_cfgs
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, rk_hdptx_phy_of_match);
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 928607a21d36..f8abc69a39d1 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1531,7 +1531,6 @@ static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
 		.clk_rate = 19200000,
 		.npwm = 1,
 		.base_unit_bits = 22,
-		.bypass = true,
 	};
 	struct pwm_chip *chip;
 
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index d09a5e9b2eca..f6a1e684a386 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -1290,12 +1290,14 @@ static struct npcm8xx_func npcm8xx_funcs[] = {
 };
 
 #define NPCM8XX_PINCFG(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q) \
-	[a] { .fn0 = fn_ ## b, .reg0 = NPCM8XX_GCR_ ## c, .bit0 = d, \
+	[a] = {								  \
+			.flag = q,					  \
+			.fn0 = fn_ ## b, .reg0 = NPCM8XX_GCR_ ## c, .bit0 = d, \
 			.fn1 = fn_ ## e, .reg1 = NPCM8XX_GCR_ ## f, .bit1 = g, \
 			.fn2 = fn_ ## h, .reg2 = NPCM8XX_GCR_ ## i, .bit2 = j, \
 			.fn3 = fn_ ## k, .reg3 = NPCM8XX_GCR_ ## l, .bit3 = m, \
 			.fn4 = fn_ ## n, .reg4 = NPCM8XX_GCR_ ## o, .bit4 = p, \
-			.flag = q }
+	}
 
 /* Drive strength controlled by NPCM8XX_GP_N_ODSC */
 #define DRIVE_STRENGTH_LO_SHIFT		8
@@ -2361,8 +2363,8 @@ static int npcm8xx_gpio_fw(struct npcm8xx_pinctrl *pctrl)
 			return dev_err_probe(dev, ret, "gpio-ranges fail for GPIO bank %u\n", id);
 
 		ret = fwnode_irq_get(child, 0);
-		if (!ret)
-			return dev_err_probe(dev, ret, "No IRQ for GPIO bank %u\n", id);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Failed to retrieve IRQ for bank %u\n", id);
 
 		pctrl->gpio_bank[id].irq = ret;
 		pctrl->gpio_bank[id].irq_chip = npcmgpio_irqchip;
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index af689d7c117f..773eaf508565 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -253,6 +253,8 @@ static int rza2_gpio_register(struct rza2_pinctrl_priv *priv)
 		return ret;
 	}
 
+	of_node_put(of_args.np);
+
 	if ((of_args.args[0] != 0) ||
 	    (of_args.args[1] != 0) ||
 	    (of_args.args[2] != priv->npins)) {
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 5081c7d8064f..d90685cfe2e1 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2583,6 +2583,8 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 	if (ret)
 		return dev_err_probe(pctrl->dev, ret, "Unable to parse gpio-ranges\n");
 
+	of_node_put(of_args.np);
+
 	if (of_args.args[0] != 0 || of_args.args[1] != 0 ||
 	    of_args.args[2] != pctrl->data->n_port_pins)
 		return dev_err_probe(pctrl->dev, -EINVAL,
@@ -3180,6 +3182,7 @@ static struct platform_driver rzg2l_pinctrl_driver = {
 		.name = DRV_NAME,
 		.of_match_table = of_match_ptr(rzg2l_pinctrl_of_table),
 		.pm = pm_sleep_ptr(&rzg2l_pinctrl_pm_ops),
+		.suppress_bind_attrs = true,
 	},
 	.probe = rzg2l_pinctrl_probe,
 };
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 4062c56619f5..8c7169db4fcc 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -940,6 +940,8 @@ static int rzv2m_gpio_register(struct rzv2m_pinctrl *pctrl)
 		return ret;
 	}
 
+	of_node_put(of_args.np);
+
 	if (of_args.args[0] != 0 || of_args.args[1] != 0 ||
 	    of_args.args[2] != pctrl->data->n_port_pins) {
 		dev_err(pctrl->dev, "gpio-ranges does not match selected SOC\n");
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index c83e5a65e680..3b046450bd3f 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -270,6 +270,9 @@ static int tegra_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	val = pmx_readl(pmx, g->mux_bank, g->mux_reg);
 	val &= ~(0x3 << g->mux_bit);
 	val |= i << g->mux_bit;
+	/* Set the SFIO/GPIO selection to SFIO when under pinmux control*/
+	if (pmx->soc->sfsel_in_mux)
+		val |= (1 << g->sfsel_bit);
 	pmx_writel(pmx, val, g->mux_bank, g->mux_reg);
 
 	return 0;
diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
index 8ce8816da9c1..43ba1b9aa181 100644
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -105,9 +105,12 @@ struct cookie_header {
 #define PMF_TA_IF_VERSION_MAJOR				1
 #define TA_PMF_ACTION_MAX					32
 #define TA_PMF_UNDO_MAX						8
-#define TA_OUTPUT_RESERVED_MEM				906
+#define TA_OUTPUT_RESERVED_MEM				922
 #define MAX_OPERATION_PARAMS					4
 
+#define TA_ERROR_CRYPTO_INVALID_PARAM				0x20002
+#define TA_ERROR_CRYPTO_BIN_TOO_LARGE				0x2000d
+
 #define PMF_IF_V1		1
 #define PMF_IF_V2		2
 
diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index 19c27b6e4666..09131507d7a9 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -27,8 +27,11 @@ module_param(pb_side_load, bool, 0444);
 MODULE_PARM_DESC(pb_side_load, "Sideload policy binaries debug policy failures");
 #endif
 
-static const uuid_t amd_pmf_ta_uuid = UUID_INIT(0x6fd93b77, 0x3fb8, 0x524d,
-						0xb1, 0x2d, 0xc5, 0x29, 0xb1, 0x3d, 0x85, 0x43);
+static const uuid_t amd_pmf_ta_uuid[] = { UUID_INIT(0xd9b39bf2, 0x66bd, 0x4154, 0xaf, 0xb8, 0x8a,
+						    0xcc, 0x2b, 0x2b, 0x60, 0xd6),
+					  UUID_INIT(0x6fd93b77, 0x3fb8, 0x524d, 0xb1, 0x2d, 0xc5,
+						    0x29, 0xb1, 0x3d, 0x85, 0x43),
+					};
 
 static const char *amd_pmf_uevent_as_str(unsigned int state)
 {
@@ -321,9 +324,9 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_dev *dev)
 		 */
 		schedule_delayed_work(&dev->pb_work, msecs_to_jiffies(pb_actions_ms * 3));
 	} else {
-		dev_err(dev->dev, "ta invoke cmd init failed err: %x\n", res);
+		dev_dbg(dev->dev, "ta invoke cmd init failed err: %x\n", res);
 		dev->smart_pc_enabled = false;
-		return -EIO;
+		return res;
 	}
 
 	return 0;
@@ -390,12 +393,12 @@ static int amd_pmf_amdtee_ta_match(struct tee_ioctl_version_data *ver, const voi
 	return ver->impl_id == TEE_IMPL_ID_AMDTEE;
 }
 
-static int amd_pmf_ta_open_session(struct tee_context *ctx, u32 *id)
+static int amd_pmf_ta_open_session(struct tee_context *ctx, u32 *id, const uuid_t *uuid)
 {
 	struct tee_ioctl_open_session_arg sess_arg = {};
 	int rc;
 
-	export_uuid(sess_arg.uuid, &amd_pmf_ta_uuid);
+	export_uuid(sess_arg.uuid, uuid);
 	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
 	sess_arg.num_params = 0;
 
@@ -434,7 +437,7 @@ static int amd_pmf_register_input_device(struct amd_pmf_dev *dev)
 	return 0;
 }
 
-static int amd_pmf_tee_init(struct amd_pmf_dev *dev)
+static int amd_pmf_tee_init(struct amd_pmf_dev *dev, const uuid_t *uuid)
 {
 	u32 size;
 	int ret;
@@ -445,7 +448,7 @@ static int amd_pmf_tee_init(struct amd_pmf_dev *dev)
 		return PTR_ERR(dev->tee_ctx);
 	}
 
-	ret = amd_pmf_ta_open_session(dev->tee_ctx, &dev->session_id);
+	ret = amd_pmf_ta_open_session(dev->tee_ctx, &dev->session_id, uuid);
 	if (ret) {
 		dev_err(dev->dev, "Failed to open TA session (%d)\n", ret);
 		ret = -EINVAL;
@@ -489,7 +492,8 @@ static void amd_pmf_tee_deinit(struct amd_pmf_dev *dev)
 
 int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 {
-	int ret;
+	bool status;
+	int ret, i;
 
 	ret = apmf_check_smart_pc(dev);
 	if (ret) {
@@ -502,26 +506,22 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 		return -ENODEV;
 	}
 
-	ret = amd_pmf_tee_init(dev);
-	if (ret)
-		return ret;
-
 	INIT_DELAYED_WORK(&dev->pb_work, amd_pmf_invoke_cmd);
 
 	ret = amd_pmf_set_dram_addr(dev, true);
 	if (ret)
-		goto error;
+		goto err_cancel_work;
 
 	dev->policy_base = devm_ioremap(dev->dev, dev->policy_addr, dev->policy_sz);
 	if (!dev->policy_base) {
 		ret = -ENOMEM;
-		goto error;
+		goto err_free_dram_buf;
 	}
 
 	dev->policy_buf = kzalloc(dev->policy_sz, GFP_KERNEL);
 	if (!dev->policy_buf) {
 		ret = -ENOMEM;
-		goto error;
+		goto err_free_dram_buf;
 	}
 
 	memcpy_fromio(dev->policy_buf, dev->policy_base, dev->policy_sz);
@@ -531,24 +531,60 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
 	if (!dev->prev_data) {
 		ret = -ENOMEM;
-		goto error;
+		goto err_free_policy;
 	}
 
-	ret = amd_pmf_start_policy_engine(dev);
-	if (ret)
-		goto error;
+	for (i = 0; i < ARRAY_SIZE(amd_pmf_ta_uuid); i++) {
+		ret = amd_pmf_tee_init(dev, &amd_pmf_ta_uuid[i]);
+		if (ret)
+			goto err_free_prev_data;
+
+		ret = amd_pmf_start_policy_engine(dev);
+		switch (ret) {
+		case TA_PMF_TYPE_SUCCESS:
+			status = true;
+			break;
+		case TA_ERROR_CRYPTO_INVALID_PARAM:
+		case TA_ERROR_CRYPTO_BIN_TOO_LARGE:
+			amd_pmf_tee_deinit(dev);
+			status = false;
+			break;
+		default:
+			ret = -EINVAL;
+			amd_pmf_tee_deinit(dev);
+			goto err_free_prev_data;
+		}
+
+		if (status)
+			break;
+	}
+
+	if (!status && !pb_side_load) {
+		ret = -EINVAL;
+		goto err_free_prev_data;
+	}
 
 	if (pb_side_load)
 		amd_pmf_open_pb(dev, dev->dbgfs_dir);
 
 	ret = amd_pmf_register_input_device(dev);
 	if (ret)
-		goto error;
+		goto err_pmf_remove_pb;
 
 	return 0;
 
-error:
-	amd_pmf_deinit_smart_pc(dev);
+err_pmf_remove_pb:
+	if (pb_side_load && dev->esbin)
+		amd_pmf_remove_pb(dev);
+	amd_pmf_tee_deinit(dev);
+err_free_prev_data:
+	kfree(dev->prev_data);
+err_free_policy:
+	kfree(dev->policy_buf);
+err_free_dram_buf:
+	kfree(dev->buf);
+err_cancel_work:
+	cancel_delayed_work_sync(&dev->pb_work);
 
 	return ret;
 }
diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index c45bc332af7a..e4868584cde2 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -325,7 +325,7 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
 	return PTR_ERR_OR_ZERO(dell_bl->bl);
 }
 
-struct serdev_device_driver dell_uart_bl_serdev_driver = {
+static struct serdev_device_driver dell_uart_bl_serdev_driver = {
 	.probe = dell_uart_bl_serdev_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
index e75cd6e1efe6..ab5f7d3ab824 100644
--- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -665,8 +665,10 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *attr, char
 	if (ret < 0)
 		return ret;
 
-	/* Use 2731 instead of 2731.5 to avoid unnecessary rounding */
-	return sysfs_emit(buf, "%d\n", value - 2731);
+	/* Use 2732 instead of 2731.5 to avoid unnecessary rounding and to emulate
+	 * the behaviour of the OEM application which seems to round down the result.
+	 */
+	return sysfs_emit(buf, "%d\n", value - 2732);
 }
 
 static ssize_t eppid_show(struct device *dev, struct device_attribute *attr, char *buf)
diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 445e7a59beb4..9a609358956f 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -132,6 +132,13 @@ static const struct dmi_system_id button_array_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 3"),
 		},
 	},
+	{
+		.ident = "Microsoft Surface Go 4",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 4"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index dbcd3087aaa4..31239a93dd71 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -84,7 +84,7 @@ static DECLARE_HASHTABLE(isst_hash, 8);
 static DEFINE_MUTEX(isst_hash_lock);
 
 static int isst_store_new_cmd(int cmd, u32 cpu, int mbox_cmd_type, u32 param,
-			      u32 data)
+			      u64 data)
 {
 	struct isst_cmd *sst_cmd;
 
diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 7b5cc9993974..55dd2286f3f3 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -410,6 +410,11 @@ static const struct intel_vsec_platform_info oobmsm_info = {
 	.caps = VSEC_CAP_TELEMETRY | VSEC_CAP_SDSI | VSEC_CAP_TPMI,
 };
 
+/* DMR OOBMSM info */
+static const struct intel_vsec_platform_info dmr_oobmsm_info = {
+	.caps = VSEC_CAP_TELEMETRY | VSEC_CAP_TPMI,
+};
+
 /* TGL info */
 static const struct intel_vsec_platform_info tgl_info = {
 	.caps = VSEC_CAP_TELEMETRY,
@@ -426,6 +431,7 @@ static const struct intel_vsec_platform_info lnl_info = {
 #define PCI_DEVICE_ID_INTEL_VSEC_MTL_M		0x7d0d
 #define PCI_DEVICE_ID_INTEL_VSEC_MTL_S		0xad0d
 #define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
+#define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM_DMR	0x09a1
 #define PCI_DEVICE_ID_INTEL_VSEC_RPL		0xa77d
 #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
 #define PCI_DEVICE_ID_INTEL_VSEC_LNL_M		0x647d
@@ -435,6 +441,7 @@ static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_M, &mtl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_S, &mtl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &oobmsm_info) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM_DMR, &dmr_oobmsm_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_LNL_M, &lnl_info) },
diff --git a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
index 32d9b6009c42..21de7c3a1ee3 100644
--- a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
@@ -219,7 +219,7 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
 	return 0;
 }
 
-struct serdev_device_driver yt2_1380_fc_serdev_driver = {
+static struct serdev_device_driver yt2_1380_fc_serdev_driver = {
 	.probe = yt2_1380_fc_serdev_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a3c73abb00f2..dea40da86755 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8795,6 +8795,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
 #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
 #define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution */
+#define TPACPI_FAN_NOACPI	0x0080		/* Don't use ACPI methods even if detected */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8825,6 +8826,9 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
 	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
+	TPACPI_Q_LNV3('R', '0', '0', TPACPI_FAN_NOACPI),/* E560 */
+	TPACPI_Q_LNV3('R', '1', '2', TPACPI_FAN_NOACPI),/* T495 */
+	TPACPI_Q_LNV3('R', '1', '3', TPACPI_FAN_NOACPI),/* T495s */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -8876,6 +8880,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		tp_features.fan_ctrl_status_undef = 1;
 	}
 
+	if (quirks & TPACPI_FAN_NOACPI) {
+		/* E560, T495, T495s */
+		pr_info("Ignoring buggy ACPI fan access method\n");
+		fang_handle = NULL;
+		fanw_handle = NULL;
+	}
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 51fb88aca0f9..1a20c775489c 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1913,7 +1913,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
 		cache.capacity = bq27xxx_battery_read_soc(di);
-		di->cache.flags = cache.flags;
 
 		/*
 		 * On gauges with signed current reporting the current must be
diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 4caac142c428..b32d88111185 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -608,7 +608,7 @@ static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg
 	case 4700000:
 	case 4800000:
 	case 4900000:
-		data = (uvolt - 4700000) / 100000;
+		data = ((uvolt - 4700000) / 100000) + 1;
 		break;
 	default:
 		dev_err(chg->dev, "Wrong value for charge input voltage regulation threshold\n");
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 9714afe347dc..1ffa145319f2 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -454,7 +454,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
 			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
-			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
 			.owner = THIS_MODULE,
 		},
@@ -663,7 +663,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
 			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
-			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
 			.owner = THIS_MODULE,
 		},
@@ -835,7 +835,7 @@ static const struct pca9450_regulator_desc pca9451a_regulators[] = {
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
 			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
-			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
 			.owner = THIS_MODULE,
 		},
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 32c3531b20c7..e19081d53022 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1839,6 +1839,13 @@ static int q6v5_pds_attach(struct device *dev, struct device **devs,
 	while (pd_names[num_pds])
 		num_pds++;
 
+	/* Handle single power domain */
+	if (num_pds == 1 && dev->pm_domain) {
+		devs[0] = dev;
+		pm_runtime_enable(dev);
+		return 1;
+	}
+
 	for (i = 0; i < num_pds; i++) {
 		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
 		if (IS_ERR_OR_NULL(devs[i])) {
@@ -1859,8 +1866,15 @@ static int q6v5_pds_attach(struct device *dev, struct device **devs,
 static void q6v5_pds_detach(struct q6v5 *qproc, struct device **pds,
 			    size_t pd_count)
 {
+	struct device *dev = qproc->dev;
 	int i;
 
+	/* Handle single power domain */
+	if (pd_count == 1 && dev->pm_domain) {
+		pm_runtime_disable(dev);
+		return;
+	}
+
 	for (i = 0; i < pd_count; i++)
 		dev_pm_domain_detach(pds[i], false);
 }
@@ -2469,13 +2483,13 @@ static const struct rproc_hexagon_res msm8974_mss = {
 			.supply = "pll",
 			.uA = 100000,
 		},
-		{}
-	},
-	.fallback_proxy_supply = (struct qcom_mss_reg_res[]) {
 		{
 			.supply = "mx",
 			.uV = 1050000,
 		},
+		{}
+	},
+	.fallback_proxy_supply = (struct qcom_mss_reg_res[]) {
 		{
 			.supply = "cx",
 			.uA = 100000,
@@ -2501,7 +2515,6 @@ static const struct rproc_hexagon_res msm8974_mss = {
 		NULL
 	},
 	.proxy_pd_names = (char*[]){
-		"mx",
 		"cx",
 		NULL
 	},
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 1a2d08ec9de9..ea4a91f37b50 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -509,16 +509,16 @@ static int adsp_pds_attach(struct device *dev, struct device **devs,
 	if (!pd_names)
 		return 0;
 
+	while (pd_names[num_pds])
+		num_pds++;
+
 	/* Handle single power domain */
-	if (dev->pm_domain) {
+	if (num_pds == 1 && dev->pm_domain) {
 		devs[0] = dev;
 		pm_runtime_enable(dev);
 		return 1;
 	}
 
-	while (pd_names[num_pds])
-		num_pds++;
-
 	for (i = 0; i < num_pds; i++) {
 		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
 		if (IS_ERR_OR_NULL(devs[i])) {
@@ -543,7 +543,7 @@ static void adsp_pds_detach(struct qcom_adsp *adsp, struct device **pds,
 	int i;
 
 	/* Handle single power domain */
-	if (dev->pm_domain && pd_count) {
+	if (pd_count == 1 && dev->pm_domain) {
 		pm_runtime_disable(dev);
 		return;
 	}
@@ -1356,6 +1356,7 @@ static const struct adsp_data sc7280_wpss_resource = {
 	.crash_reason_smem = 626,
 	.firmware_name = "wpss.mdt",
 	.pas_id = 6,
+	.minidump_id = 4,
 	.auto_boot = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
@@ -1418,7 +1419,7 @@ static const struct adsp_data sm8650_mpss_resource = {
 };
 
 static const struct of_device_id adsp_of_match[] = {
-	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
+	{ .compatible = "qcom,msm8226-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ef6febe35633..d2308c2f97eb 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2025,6 +2025,7 @@ int rproc_shutdown(struct rproc *rproc)
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
 	rproc->table_ptr = NULL;
+	rproc->table_sz = 0;
 out:
 	mutex_unlock(&rproc->lock);
 	return ret;
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index f1a4df6cfebd..2bcb733de4de 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -12,6 +12,7 @@ static void sdw_slave_release(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 
+	of_node_put(slave->dev.of_node);
 	mutex_destroy(&slave->sdw_dev_lock);
 	kfree(slave);
 }
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e1b9b1235787..5926e004d9a6 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1162,7 +1162,8 @@ static void bcm2835_spi_cleanup(struct spi_device *spi)
 				 sizeof(u32),
 				 DMA_TO_DEVICE);
 
-	gpiod_put(bs->cs_gpio);
+	if (!IS_ERR(bs->cs_gpio))
+		gpiod_put(bs->cs_gpio);
 	spi_set_csgpiod(spi, 0, NULL);
 
 	kfree(target);
@@ -1225,7 +1226,12 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	struct bcm2835_spidev *target = spi_get_ctldata(spi);
 	struct gpiod_lookup_table *lookup __free(kfree) = NULL;
-	int ret;
+	const char *pinctrl_compats[] = {
+		"brcm,bcm2835-gpio",
+		"brcm,bcm2711-gpio",
+		"brcm,bcm7211-gpio",
+	};
+	int ret, i;
 	u32 cs;
 
 	if (!target) {
@@ -1290,6 +1296,14 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 		goto err_cleanup;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(pinctrl_compats); i++) {
+		if (of_find_compatible_node(NULL, NULL, pinctrl_compats[i]))
+			break;
+	}
+
+	if (i == ARRAY_SIZE(pinctrl_compats))
+		return 0;
+
 	/*
 	 * TODO: The code below is a slightly better alternative to the utter
 	 * abuse of the GPIO API that I found here before. It creates a
diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index aed98ab14334..6dcba0e0ddaa 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -432,7 +432,7 @@ static bool cdns_mrvl_xspi_setup_clock(struct cdns_xspi_dev *cdns_xspi,
 	u32 clk_reg;
 	bool update_clk = false;
 
-	while (i < ARRAY_SIZE(cdns_mrvl_xspi_clk_div_list)) {
+	while (i < (ARRAY_SIZE(cdns_mrvl_xspi_clk_div_list) - 1)) {
 		clk_val = MRVL_XSPI_CLOCK_DIVIDED(
 				cdns_mrvl_xspi_clk_div_list[i]);
 		if (clk_val <= requested_clk)
diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
index 8d48c61961a6..353e6ee2c145 100644
--- a/drivers/staging/rtl8723bs/Kconfig
+++ b/drivers/staging/rtl8723bs/Kconfig
@@ -4,6 +4,7 @@ config RTL8723BS
 	depends on WLAN && MMC && CFG80211
 	depends on m
 	select CRYPTO
+	select CRYPTO_LIB_AES
 	select CRYPTO_LIB_ARC4
 	help
 	This option enables support for RTL8723BS SDIO drivers, such as
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 5fab33adf58e..97787002080a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1745,8 +1745,6 @@ static int vchiq_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_platform_init;
 
-	vchiq_debugfs_init(&mgmt->state);
-
 	dev_dbg(&pdev->dev, "arm: platform initialised - version %d (min %d)\n",
 		VCHIQ_VERSION, VCHIQ_VERSION_MIN);
 
@@ -1760,6 +1758,8 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto error_exit;
 	}
 
+	vchiq_debugfs_init(&mgmt->state);
+
 	bcm2835_audio = vchiq_device_register(&pdev->dev, "bcm2835-audio");
 	bcm2835_camera = vchiq_device_register(&pdev->dev, "bcm2835-camera");
 
@@ -1786,7 +1786,8 @@ static void vchiq_remove(struct platform_device *pdev)
 	kthread_stop(mgmt->state.slot_handler_thread);
 
 	arm_state = vchiq_platform_get_arm_state(&mgmt->state);
-	kthread_stop(arm_state->ka_thread);
+	if (!IS_ERR_OR_NULL(arm_state->ka_thread))
+		kthread_stop(arm_state->ka_thread);
 }
 
 static struct platform_driver vchiq_driver = {
diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index ab8bfb5a3946..40ab6b2d4fb0 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -45,6 +45,9 @@ static int int3402_thermal_probe(struct platform_device *pdev)
 	struct int3402_thermal_data *d;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	if (!acpi_has_method(adev->handle, "_TMP"))
 		return -ENODEV;
 
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 5e9ca4376d68..94fa981081fd 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -486,7 +486,8 @@ static int do_output_char(u8 c, struct tty_struct *tty, int space)
 static int process_output(u8 c, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int	space, retval;
+	unsigned int space;
+	int retval;
 
 	mutex_lock(&ldata->output_lock);
 
@@ -522,16 +523,16 @@ static ssize_t process_output_block(struct tty_struct *tty,
 				    const u8 *buf, unsigned int nr)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int	space;
-	int	i;
+	unsigned int space;
+	int i;
 	const u8 *cp;
 
 	mutex_lock(&ldata->output_lock);
 
 	space = tty_write_room(tty);
-	if (space <= 0) {
+	if (space == 0) {
 		mutex_unlock(&ldata->output_lock);
-		return space;
+		return 0;
 	}
 	if (nr > space)
 		nr = space;
@@ -696,7 +697,7 @@ static int n_tty_process_echo_ops(struct tty_struct *tty, size_t *tail,
 static size_t __process_echoes(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int	space, old_space;
+	unsigned int space, old_space;
 	size_t tail;
 	u8 c;
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 9f9fc733eb2c..951c3cdac3b9 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -440,7 +440,7 @@ static unsigned int lpuart_get_baud_clk_rate(struct lpuart_port *sport)
 
 static void lpuart_stop_tx(struct uart_port *port)
 {
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2);
 	temp &= ~(UARTCR2_TIE | UARTCR2_TCIE);
@@ -449,7 +449,7 @@ static void lpuart_stop_tx(struct uart_port *port)
 
 static void lpuart32_stop_tx(struct uart_port *port)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 	temp &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
@@ -458,7 +458,7 @@ static void lpuart32_stop_tx(struct uart_port *port)
 
 static void lpuart_stop_rx(struct uart_port *port)
 {
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2);
 	writeb(temp & ~UARTCR2_RE, port->membase + UARTCR2);
@@ -466,7 +466,7 @@ static void lpuart_stop_rx(struct uart_port *port)
 
 static void lpuart32_stop_rx(struct uart_port *port)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 	lpuart32_write(port, temp & ~UARTCTRL_RE, UARTCTRL);
@@ -580,7 +580,7 @@ static int lpuart_dma_tx_request(struct uart_port *port)
 	ret = dmaengine_slave_config(sport->dma_tx_chan, &dma_tx_sconfig);
 
 	if (ret) {
-		dev_err(sport->port.dev,
+		dev_err(port->dev,
 				"DMA slave config failed, err = %d\n", ret);
 		return ret;
 	}
@@ -610,13 +610,13 @@ static void lpuart_flush_buffer(struct uart_port *port)
 	}
 
 	if (lpuart_is_32(sport)) {
-		val = lpuart32_read(&sport->port, UARTFIFO);
+		val = lpuart32_read(port, UARTFIFO);
 		val |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
-		lpuart32_write(&sport->port, val, UARTFIFO);
+		lpuart32_write(port, val, UARTFIFO);
 	} else {
-		val = readb(sport->port.membase + UARTCFIFO);
+		val = readb(port->membase + UARTCFIFO);
 		val |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
-		writeb(val, sport->port.membase + UARTCFIFO);
+		writeb(val, port->membase + UARTCFIFO);
 	}
 }
 
@@ -638,38 +638,36 @@ static void lpuart32_wait_bit_set(struct uart_port *port, unsigned int offset,
 
 static int lpuart_poll_init(struct uart_port *port)
 {
-	struct lpuart_port *sport = container_of(port,
-					struct lpuart_port, port);
 	unsigned long flags;
-	unsigned char temp;
+	u8 temp;
 
-	sport->port.fifosize = 0;
+	port->fifosize = 0;
 
-	uart_port_lock_irqsave(&sport->port, &flags);
+	uart_port_lock_irqsave(port, &flags);
 	/* Disable Rx & Tx */
-	writeb(0, sport->port.membase + UARTCR2);
+	writeb(0, port->membase + UARTCR2);
 
-	temp = readb(sport->port.membase + UARTPFIFO);
+	temp = readb(port->membase + UARTPFIFO);
 	/* Enable Rx and Tx FIFO */
 	writeb(temp | UARTPFIFO_RXFE | UARTPFIFO_TXFE,
-			sport->port.membase + UARTPFIFO);
+			port->membase + UARTPFIFO);
 
 	/* flush Tx and Rx FIFO */
 	writeb(UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH,
-			sport->port.membase + UARTCFIFO);
+			port->membase + UARTCFIFO);
 
 	/* explicitly clear RDRF */
-	if (readb(sport->port.membase + UARTSR1) & UARTSR1_RDRF) {
-		readb(sport->port.membase + UARTDR);
-		writeb(UARTSFIFO_RXUF, sport->port.membase + UARTSFIFO);
+	if (readb(port->membase + UARTSR1) & UARTSR1_RDRF) {
+		readb(port->membase + UARTDR);
+		writeb(UARTSFIFO_RXUF, port->membase + UARTSFIFO);
 	}
 
-	writeb(0, sport->port.membase + UARTTWFIFO);
-	writeb(1, sport->port.membase + UARTRWFIFO);
+	writeb(0, port->membase + UARTTWFIFO);
+	writeb(1, port->membase + UARTRWFIFO);
 
 	/* Enable Rx and Tx */
-	writeb(UARTCR2_RE | UARTCR2_TE, sport->port.membase + UARTCR2);
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	writeb(UARTCR2_RE | UARTCR2_TE, port->membase + UARTCR2);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -692,33 +690,32 @@ static int lpuart_poll_get_char(struct uart_port *port)
 static int lpuart32_poll_init(struct uart_port *port)
 {
 	unsigned long flags;
-	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	u32 temp;
 
-	sport->port.fifosize = 0;
+	port->fifosize = 0;
 
-	uart_port_lock_irqsave(&sport->port, &flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Disable Rx & Tx */
-	lpuart32_write(&sport->port, 0, UARTCTRL);
+	lpuart32_write(port, 0, UARTCTRL);
 
-	temp = lpuart32_read(&sport->port, UARTFIFO);
+	temp = lpuart32_read(port, UARTFIFO);
 
 	/* Enable Rx and Tx FIFO */
-	lpuart32_write(&sport->port, temp | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
+	lpuart32_write(port, temp | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
 
 	/* flush Tx and Rx FIFO */
-	lpuart32_write(&sport->port, UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH, UARTFIFO);
+	lpuart32_write(port, UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH, UARTFIFO);
 
 	/* explicitly clear RDRF */
-	if (lpuart32_read(&sport->port, UARTSTAT) & UARTSTAT_RDRF) {
-		lpuart32_read(&sport->port, UARTDATA);
-		lpuart32_write(&sport->port, UARTFIFO_RXUF, UARTFIFO);
+	if (lpuart32_read(port, UARTSTAT) & UARTSTAT_RDRF) {
+		lpuart32_read(port, UARTDATA);
+		lpuart32_write(port, UARTFIFO_RXUF, UARTFIFO);
 	}
 
 	/* Enable Rx and Tx */
-	lpuart32_write(&sport->port, UARTCTRL_RE | UARTCTRL_TE, UARTCTRL);
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	lpuart32_write(port, UARTCTRL_RE | UARTCTRL_TE, UARTCTRL);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -751,7 +748,7 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 {
 	struct tty_port *tport = &sport->port.state->port;
-	unsigned long txcnt;
+	u32 txcnt;
 	unsigned char c;
 
 	if (sport->port.x_char) {
@@ -788,7 +785,7 @@ static void lpuart_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2);
 	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
@@ -805,7 +802,7 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
@@ -838,8 +835,8 @@ static unsigned int lpuart_tx_empty(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned char sr1 = readb(port->membase + UARTSR1);
-	unsigned char sfifo = readb(port->membase + UARTSFIFO);
+	u8 sr1 = readb(port->membase + UARTSR1);
+	u8 sfifo = readb(port->membase + UARTSFIFO);
 
 	if (sport->dma_tx_in_progress)
 		return 0;
@@ -854,9 +851,9 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned long stat = lpuart32_read(port, UARTSTAT);
-	unsigned long sfifo = lpuart32_read(port, UARTFIFO);
-	unsigned long ctrl = lpuart32_read(port, UARTCTRL);
+	u32 stat = lpuart32_read(port, UARTSTAT);
+	u32 sfifo = lpuart32_read(port, UARTFIFO);
+	u32 ctrl = lpuart32_read(port, UARTCTRL);
 
 	if (sport->dma_tx_in_progress)
 		return 0;
@@ -883,7 +880,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0, overrun = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned char rx, sr;
+	u8 rx, sr;
 
 	uart_port_lock(&sport->port);
 
@@ -960,7 +957,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned long rx, sr;
+	u32 rx, sr;
 	bool is_break;
 
 	uart_port_lock(&sport->port);
@@ -1038,7 +1035,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 static irqreturn_t lpuart_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned char sts;
+	u8 sts;
 
 	sts = readb(sport->port.membase + UARTSR1);
 
@@ -1112,7 +1109,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	int count, copied;
 
 	if (lpuart_is_32(sport)) {
-		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
+		u32 sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
 			/* Clear the error flags */
@@ -1124,10 +1121,10 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 				sport->port.icount.frame++;
 		}
 	} else {
-		unsigned char sr = readb(sport->port.membase + UARTSR1);
+		u8 sr = readb(sport->port.membase + UARTSR1);
 
 		if (sr & (UARTSR1_PE | UARTSR1_FE)) {
-			unsigned char cr2;
+			u8 cr2;
 
 			/* Disable receiver during this operation... */
 			cr2 = readb(sport->port.membase + UARTCR2);
@@ -1278,7 +1275,7 @@ static void lpuart32_dma_idleint(struct lpuart_port *sport)
 static irqreturn_t lpuart32_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned long sts, rxcount;
+	u32 sts, rxcount;
 
 	sts = lpuart32_read(&sport->port, UARTSTAT);
 	rxcount = lpuart32_read(&sport->port, UARTWATER);
@@ -1410,12 +1407,12 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	dma_async_issue_pending(chan);
 
 	if (lpuart_is_32(sport)) {
-		unsigned long temp = lpuart32_read(&sport->port, UARTBAUD);
+		u32 temp = lpuart32_read(&sport->port, UARTBAUD);
 
 		lpuart32_write(&sport->port, temp | UARTBAUD_RDMAE, UARTBAUD);
 
 		if (sport->dma_idle_int) {
-			unsigned long ctrl = lpuart32_read(&sport->port, UARTCTRL);
+			u32 ctrl = lpuart32_read(&sport->port, UARTCTRL);
 
 			lpuart32_write(&sport->port, ctrl | UARTCTRL_ILIE, UARTCTRL);
 		}
@@ -1448,12 +1445,9 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
 			struct serial_rs485 *rs485)
 {
-	struct lpuart_port *sport = container_of(port,
-			struct lpuart_port, port);
-
-	u8 modem = readb(sport->port.membase + UARTMODEM) &
+	u8 modem = readb(port->membase + UARTMODEM) &
 		~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
-	writeb(modem, sport->port.membase + UARTMODEM);
+	writeb(modem, port->membase + UARTMODEM);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
@@ -1471,32 +1465,29 @@ static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
 			modem &= ~UARTMODEM_TXRTSPOL;
 	}
 
-	writeb(modem, sport->port.membase + UARTMODEM);
+	writeb(modem, port->membase + UARTMODEM);
 	return 0;
 }
 
 static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termios,
 			struct serial_rs485 *rs485)
 {
-	struct lpuart_port *sport = container_of(port,
-			struct lpuart_port, port);
-
-	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
+	u32 modem = lpuart32_read(port, UARTMODIR)
 				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
 	u32 ctrl;
 
 	/* TXRTSE and TXRTSPOL only can be changed when transmitter is disabled. */
-	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
 	if (ctrl & UARTCTRL_TE) {
 		/* wait for the transmit engine to complete */
-		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
-		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE, UARTCTRL);
+		lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TC);
+		lpuart32_write(port, ctrl & ~UARTCTRL_TE, UARTCTRL);
 
-		while (lpuart32_read(&sport->port, UARTCTRL) & UARTCTRL_TE)
+		while (lpuart32_read(port, UARTCTRL) & UARTCTRL_TE)
 			cpu_relax();
 	}
 
-	lpuart32_write(&sport->port, modem, UARTMODIR);
+	lpuart32_write(port, modem, UARTMODIR);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
@@ -1514,10 +1505,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 			modem &= ~UARTMODIR_TXRTSPOL;
 	}
 
-	lpuart32_write(&sport->port, modem, UARTMODIR);
+	lpuart32_write(port, modem, UARTMODIR);
 
 	if (ctrl & UARTCTRL_TE)
-		lpuart32_write(&sport->port, ctrl, UARTCTRL);
+		lpuart32_write(port, ctrl, UARTCTRL);
 
 	return 0;
 }
@@ -1576,7 +1567,7 @@ static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2) & ~UARTCR2_SBK;
 
@@ -1588,7 +1579,7 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 
@@ -1622,8 +1613,7 @@ static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)
 {
-	unsigned char val, cr2;
-	unsigned char cr2_saved;
+	u8 val, cr2, cr2_saved;
 
 	cr2 = readb(sport->port.membase + UARTCR2);
 	cr2_saved = cr2;
@@ -1656,7 +1646,7 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 
 static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 {
-	unsigned char cr2;
+	u8 cr2;
 
 	lpuart_setup_watermark(sport);
 
@@ -1667,8 +1657,7 @@ static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 
 static void lpuart32_setup_watermark(struct lpuart_port *sport)
 {
-	unsigned long val, ctrl;
-	unsigned long ctrl_saved;
+	u32 val, ctrl, ctrl_saved;
 
 	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	ctrl_saved = ctrl;
@@ -1777,7 +1766,7 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 {
 	int ret;
-	unsigned char cr3;
+	u8 cr3;
 
 	if (uart_console(&sport->port))
 		goto err;
@@ -1827,14 +1816,14 @@ static void lpuart_hw_setup(struct lpuart_port *sport)
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned char temp;
+	u8 temp;
 
 	/* determine FIFO size and enable FIFO mode */
-	temp = readb(sport->port.membase + UARTPFIFO);
+	temp = readb(port->membase + UARTPFIFO);
 
 	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_TXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
-	sport->port.fifosize = sport->txfifo_size;
+	port->fifosize = sport->txfifo_size;
 
 	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_RXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
@@ -1847,7 +1836,7 @@ static int lpuart_startup(struct uart_port *port)
 
 static void lpuart32_hw_disable(struct lpuart_port *sport)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	temp &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
@@ -1857,7 +1846,7 @@ static void lpuart32_hw_disable(struct lpuart_port *sport)
 
 static void lpuart32_configure(struct lpuart_port *sport)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
@@ -1887,14 +1876,14 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 
 	/* determine FIFO size */
-	temp = lpuart32_read(&sport->port, UARTFIFO);
+	temp = lpuart32_read(port, UARTFIFO);
 
 	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_TXSIZE_OFF) &
 					    UARTFIFO_FIFOSIZE_MASK);
-	sport->port.fifosize = sport->txfifo_size;
+	port->fifosize = sport->txfifo_size;
 
 	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_RXSIZE_OFF) &
 					    UARTFIFO_FIFOSIZE_MASK);
@@ -1907,7 +1896,7 @@ static int lpuart32_startup(struct uart_port *port)
 	if (is_layerscape_lpuart(sport)) {
 		sport->rxfifo_size = 16;
 		sport->txfifo_size = 16;
-		sport->port.fifosize = sport->txfifo_size;
+		port->fifosize = sport->txfifo_size;
 	}
 
 	lpuart_request_dma(sport);
@@ -1941,7 +1930,7 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 static void lpuart_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned char temp;
+	u8 temp;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
@@ -1961,14 +1950,14 @@ static void lpuart32_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport =
 		container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
 
 	/* clear status */
-	temp = lpuart32_read(&sport->port, UARTSTAT);
-	lpuart32_write(&sport->port, temp, UARTSTAT);
+	temp = lpuart32_read(port, UARTSTAT);
+	lpuart32_write(port, temp, UARTSTAT);
 
 	/* disable Rx/Tx DMA */
 	temp = lpuart32_read(port, UARTBAUD);
@@ -1992,17 +1981,17 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned long flags;
-	unsigned char cr1, old_cr1, old_cr2, cr3, cr4, bdh, modem;
+	u8 cr1, old_cr1, old_cr2, cr3, cr4, bdh, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned int sbr, brfa;
 
-	cr1 = old_cr1 = readb(sport->port.membase + UARTCR1);
-	old_cr2 = readb(sport->port.membase + UARTCR2);
-	cr3 = readb(sport->port.membase + UARTCR3);
-	cr4 = readb(sport->port.membase + UARTCR4);
-	bdh = readb(sport->port.membase + UARTBDH);
-	modem = readb(sport->port.membase + UARTMODEM);
+	cr1 = old_cr1 = readb(port->membase + UARTCR1);
+	old_cr2 = readb(port->membase + UARTCR2);
+	cr3 = readb(port->membase + UARTCR3);
+	cr4 = readb(port->membase + UARTCR4);
+	bdh = readb(port->membase + UARTBDH);
+	modem = readb(port->membase + UARTMODEM);
 	/*
 	 * only support CS8 and CS7, and for CS7 must enable PE.
 	 * supported mode:
@@ -2034,7 +2023,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * When auto RS-485 RTS mode is enabled,
 	 * hardware flow control need to be disabled.
 	 */
-	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
@@ -2075,59 +2064,59 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Need to update the Ring buffer length according to the selected
 	 * baud rate and restart Rx DMA path.
 	 *
-	 * Since timer function acqures sport->port.lock, need to stop before
+	 * Since timer function acqures port->lock, need to stop before
 	 * acquring same lock because otherwise del_timer_sync() can deadlock.
 	 */
 	if (old && sport->lpuart_dma_rx_use)
-		lpuart_dma_rx_free(&sport->port);
+		lpuart_dma_rx_free(port);
 
-	uart_port_lock_irqsave(&sport->port, &flags);
+	uart_port_lock_irqsave(port, &flags);
 
-	sport->port.read_status_mask = 0;
+	port->read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		sport->port.read_status_mask |= UARTSR1_FE | UARTSR1_PE;
+		port->read_status_mask |= UARTSR1_FE | UARTSR1_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-		sport->port.read_status_mask |= UARTSR1_FE;
+		port->read_status_mask |= UARTSR1_FE;
 
 	/* characters to ignore */
-	sport->port.ignore_status_mask = 0;
+	port->ignore_status_mask = 0;
 	if (termios->c_iflag & IGNPAR)
-		sport->port.ignore_status_mask |= UARTSR1_PE;
+		port->ignore_status_mask |= UARTSR1_PE;
 	if (termios->c_iflag & IGNBRK) {
-		sport->port.ignore_status_mask |= UARTSR1_FE;
+		port->ignore_status_mask |= UARTSR1_FE;
 		/*
 		 * if we're ignoring parity and break indicators,
 		 * ignore overruns too (for real raw support).
 		 */
 		if (termios->c_iflag & IGNPAR)
-			sport->port.ignore_status_mask |= UARTSR1_OR;
+			port->ignore_status_mask |= UARTSR1_OR;
 	}
 
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
-	lpuart_wait_bit_set(&sport->port, UARTSR1, UARTSR1_TC);
+	lpuart_wait_bit_set(port, UARTSR1, UARTSR1_TC);
 
 	/* disable transmit and receive */
 	writeb(old_cr2 & ~(UARTCR2_TE | UARTCR2_RE),
-			sport->port.membase + UARTCR2);
+			port->membase + UARTCR2);
 
-	sbr = sport->port.uartclk / (16 * baud);
-	brfa = ((sport->port.uartclk - (16 * sbr * baud)) * 2) / baud;
+	sbr = port->uartclk / (16 * baud);
+	brfa = ((port->uartclk - (16 * sbr * baud)) * 2) / baud;
 	bdh &= ~UARTBDH_SBR_MASK;
 	bdh |= (sbr >> 8) & 0x1F;
 	cr4 &= ~UARTCR4_BRFA_MASK;
 	brfa &= UARTCR4_BRFA_MASK;
-	writeb(cr4 | brfa, sport->port.membase + UARTCR4);
-	writeb(bdh, sport->port.membase + UARTBDH);
-	writeb(sbr & 0xFF, sport->port.membase + UARTBDL);
-	writeb(cr3, sport->port.membase + UARTCR3);
-	writeb(cr1, sport->port.membase + UARTCR1);
-	writeb(modem, sport->port.membase + UARTMODEM);
+	writeb(cr4 | brfa, port->membase + UARTCR4);
+	writeb(bdh, port->membase + UARTBDH);
+	writeb(sbr & 0xFF, port->membase + UARTBDL);
+	writeb(cr3, port->membase + UARTCR3);
+	writeb(cr1, port->membase + UARTCR1);
+	writeb(modem, port->membase + UARTMODEM);
 
 	/* restore control register */
-	writeb(old_cr2, sport->port.membase + UARTCR2);
+	writeb(old_cr2, port->membase + UARTCR2);
 
 	if (old && sport->lpuart_dma_rx_use) {
 		if (!lpuart_start_rx_dma(sport))
@@ -2136,7 +2125,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void __lpuart32_serial_setbrg(struct uart_port *port,
@@ -2230,13 +2219,13 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned long flags;
-	unsigned long ctrl, old_ctrl, bd, modem;
+	u32 ctrl, old_ctrl, bd, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 
-	ctrl = old_ctrl = lpuart32_read(&sport->port, UARTCTRL);
-	bd = lpuart32_read(&sport->port, UARTBAUD);
-	modem = lpuart32_read(&sport->port, UARTMODIR);
+	ctrl = old_ctrl = lpuart32_read(port, UARTCTRL);
+	bd = lpuart32_read(port, UARTBAUD);
+	modem = lpuart32_read(port, UARTMODIR);
 	sport->is_cs7 = false;
 	/*
 	 * only support CS8 and CS7, and for CS7 must enable PE.
@@ -2269,7 +2258,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * When auto RS-485 RTS mode is enabled,
 	 * hardware flow control need to be disabled.
 	 */
-	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
@@ -2310,59 +2299,61 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Need to update the Ring buffer length according to the selected
 	 * baud rate and restart Rx DMA path.
 	 *
-	 * Since timer function acqures sport->port.lock, need to stop before
+	 * Since timer function acqures port->lock, need to stop before
 	 * acquring same lock because otherwise del_timer_sync() can deadlock.
 	 */
 	if (old && sport->lpuart_dma_rx_use)
-		lpuart_dma_rx_free(&sport->port);
+		lpuart_dma_rx_free(port);
 
-	uart_port_lock_irqsave(&sport->port, &flags);
+	uart_port_lock_irqsave(port, &flags);
 
-	sport->port.read_status_mask = 0;
+	port->read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		sport->port.read_status_mask |= UARTSTAT_FE | UARTSTAT_PE;
+		port->read_status_mask |= UARTSTAT_FE | UARTSTAT_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-		sport->port.read_status_mask |= UARTSTAT_FE;
+		port->read_status_mask |= UARTSTAT_FE;
 
 	/* characters to ignore */
-	sport->port.ignore_status_mask = 0;
+	port->ignore_status_mask = 0;
 	if (termios->c_iflag & IGNPAR)
-		sport->port.ignore_status_mask |= UARTSTAT_PE;
+		port->ignore_status_mask |= UARTSTAT_PE;
 	if (termios->c_iflag & IGNBRK) {
-		sport->port.ignore_status_mask |= UARTSTAT_FE;
+		port->ignore_status_mask |= UARTSTAT_FE;
 		/*
 		 * if we're ignoring parity and break indicators,
 		 * ignore overruns too (for real raw support).
 		 */
 		if (termios->c_iflag & IGNPAR)
-			sport->port.ignore_status_mask |= UARTSTAT_OR;
+			port->ignore_status_mask |= UARTSTAT_OR;
 	}
 
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
+	/*
+	 * disable CTS to ensure the transmit engine is not blocked by the flow
+	 * control when there is dirty data in TX FIFO
+	 */
+	lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+
 	/*
 	 * LPUART Transmission Complete Flag may never be set while queuing a break
 	 * character, so skip waiting for transmission complete when UARTCTRL_SBK is
 	 * asserted.
 	 */
-	if (!(old_ctrl & UARTCTRL_SBK)) {
-		lpuart32_write(&sport->port, 0, UARTMODIR);
-		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
-	}
+	if (!(old_ctrl & UARTCTRL_SBK))
+		lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TC);
 
 	/* disable transmit and receive */
-	lpuart32_write(&sport->port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
+	lpuart32_write(port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
 		       UARTCTRL);
 
-	lpuart32_write(&sport->port, bd, UARTBAUD);
+	lpuart32_write(port, bd, UARTBAUD);
 	lpuart32_serial_setbrg(sport, baud);
-	/* disable CTS before enabling UARTCTRL_TE to avoid pending idle preamble */
-	lpuart32_write(&sport->port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
 	/* restore control register */
-	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	lpuart32_write(port, ctrl, UARTCTRL);
 	/* re-enable the CTS if needed */
-	lpuart32_write(&sport->port, modem, UARTMODIR);
+	lpuart32_write(port, modem, UARTMODIR);
 
 	if ((ctrl & (UARTCTRL_PE | UARTCTRL_M)) == UARTCTRL_PE)
 		sport->is_cs7 = true;
@@ -2374,7 +2365,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *lpuart_type(struct uart_port *port)
@@ -2487,7 +2478,7 @@ static void
 lpuart_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct lpuart_port *sport = lpuart_ports[co->index];
-	unsigned char  old_cr2, cr2;
+	u8  old_cr2, cr2;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2517,7 +2508,7 @@ static void
 lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct lpuart_port *sport = lpuart_ports[co->index];
-	unsigned long  old_cr, cr;
+	u32 old_cr, cr;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2551,7 +2542,7 @@ static void __init
 lpuart_console_get_options(struct lpuart_port *sport, int *baud,
 			   int *parity, int *bits)
 {
-	unsigned char cr, bdh, bdl, brfa;
+	u8 cr, bdh, bdl, brfa;
 	unsigned int sbr, uartclk, baud_raw;
 
 	cr = readb(sport->port.membase + UARTCR2);
@@ -2600,7 +2591,7 @@ static void __init
 lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 			   int *parity, int *bits)
 {
-	unsigned long cr, bd;
+	u32 cr, bd;
 	unsigned int sbr, uartclk, baud_raw;
 
 	cr = lpuart32_read(&sport->port, UARTCTRL);
@@ -2806,13 +2797,13 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 {
 	struct uart_port *port = &sport->port;
 	void __iomem *global_addr;
-	unsigned long ctrl, bd;
+	u32 ctrl, bd;
 	unsigned int val = 0;
 	int ret;
 
 	ret = clk_prepare_enable(sport->ipg_clk);
 	if (ret) {
-		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
+		dev_err(port->dev, "failed to enable uart ipg clk: %d\n", ret);
 		return ret;
 	}
 
@@ -2823,10 +2814,10 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 		 */
 		ctrl = lpuart32_read(port, UARTCTRL);
 		if (ctrl & UARTCTRL_TE) {
-			bd = lpuart32_read(&sport->port, UARTBAUD);
+			bd = lpuart32_read(port, UARTBAUD);
 			if (read_poll_timeout(lpuart32_tx_empty, val, val, 1, 100000, false,
 					      port)) {
-				dev_warn(sport->port.dev,
+				dev_warn(port->dev,
 					 "timeout waiting for transmit engine to complete\n");
 				clk_disable_unprepare(sport->ipg_clk);
 				return 0;
@@ -3012,7 +3003,7 @@ static int lpuart_runtime_resume(struct device *dev)
 
 static void serial_lpuart_enable_wakeup(struct lpuart_port *sport, bool on)
 {
-	unsigned int val, baud;
+	u32 val, baud;
 
 	if (lpuart_is_32(sport)) {
 		val = lpuart32_read(&sport->port, UARTCTRL);
@@ -3077,7 +3068,7 @@ static int lpuart_suspend_noirq(struct device *dev)
 static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned int val;
+	u32 val;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -3097,7 +3088,8 @@ static int lpuart_resume_noirq(struct device *dev)
 static int lpuart_suspend(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned long temp, flags;
+	u32 temp;
+	unsigned long flags;
 
 	uart_suspend_port(&lpuart_reg, &sport->port);
 
@@ -3177,7 +3169,7 @@ static void lpuart_console_fixup(struct lpuart_port *sport)
 	 * in VLLS mode, or restore console setting here.
 	 */
 	if (is_imx7ulp_lpuart(sport) && lpuart_uport_is_active(sport) &&
-	    console_suspend_enabled && uart_console(&sport->port)) {
+	    console_suspend_enabled && uart_console(uport)) {
 
 		mutex_lock(&port->mutex);
 		memset(&termios, 0, sizeof(struct ktermios));
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 32c8693b438b..8c26275696df 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2397,10 +2397,10 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	page_size = readl(&xhci->op_regs->page_size);
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Supported page size register = 0x%x", page_size);
-	i = ffs(page_size);
-	if (i < 16)
+	val = ffs(page_size) - 1;
+	if (val < 16)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"Supported page size of %iK", (1 << (i+12)) / 1024);
+			"Supported page size of %iK", (1 << (val + 12)) / 1024);
 	else
 		xhci_warn(xhci, "WARN: no supported page size\n");
 	/* Use 4K pages, since that's common and the minimum the HC supports */
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 4b1668733a4b..511dd1b224ae 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1433,11 +1433,10 @@ static int ucsi_ccg_probe(struct i2c_client *client)
 			uc->fw_build = CCG_FW_BUILD_NVIDIA_TEGRA;
 		else if (!strcmp(fw_name, "nvidia,gpu"))
 			uc->fw_build = CCG_FW_BUILD_NVIDIA;
+		if (!uc->fw_build)
+			dev_err(uc->dev, "failed to get FW build information\n");
 	}
 
-	if (!uc->fw_build)
-		dev_err(uc->dev, "failed to get FW build information\n");
-
 	/* reset ccg device and initialize ucsi */
 	status = ucsi_ccg_init(uc);
 	if (status < 0) {
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 718fa4e0b31e..7aeff435c1d8 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1699,14 +1699,19 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		}
 	}
 
+	if (vs->vs_tpg) {
+		pr_err("vhost-scsi endpoint already set for %s.\n",
+		       vs->vs_vhost_wwpn);
+		ret = -EEXIST;
+		goto out;
+	}
+
 	len = sizeof(vs_tpg[0]) * VHOST_SCSI_MAX_TARGET;
 	vs_tpg = kzalloc(len, GFP_KERNEL);
 	if (!vs_tpg) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	if (vs->vs_tpg)
-		memcpy(vs_tpg, vs->vs_tpg, len);
 
 	mutex_lock(&vhost_scsi_mutex);
 	list_for_each_entry(tpg, &vhost_scsi_list, tv_tpg_list) {
@@ -1722,12 +1727,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		tv_tport = tpg->tport;
 
 		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
-			if (vs->vs_tpg && vs->vs_tpg[tpg->tport_tpgt]) {
-				mutex_unlock(&tpg->tv_tpg_mutex);
-				mutex_unlock(&vhost_scsi_mutex);
-				ret = -EEXIST;
-				goto undepend;
-			}
 			/*
 			 * In order to ensure individual vhost-scsi configfs
 			 * groups cannot be removed while in use by vhost ioctl,
@@ -1774,15 +1773,15 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		}
 		ret = 0;
 	} else {
-		ret = -EEXIST;
+		ret = -ENODEV;
+		goto free_tpg;
 	}
 
 	/*
-	 * Act as synchronize_rcu to make sure access to
-	 * old vs->vs_tpg is finished.
+	 * Act as synchronize_rcu to make sure requests after this point
+	 * see a fully setup device.
 	 */
 	vhost_scsi_flush(vs);
-	kfree(vs->vs_tpg);
 	vs->vs_tpg = vs_tpg;
 	goto out;
 
@@ -1802,6 +1801,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 			target_undepend_item(&tpg->se_tpg.tpg_group.cg_item);
 		}
 	}
+free_tpg:
 	kfree(vs_tpg);
 out:
 	mutex_unlock(&vs->dev.mutex);
@@ -1904,6 +1904,7 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	vhost_scsi_flush(vs);
 	kfree(vs->vs_tpg);
 	vs->vs_tpg = NULL;
+	memset(vs->vs_vhost_wwpn, 0, sizeof(vs->vs_vhost_wwpn));
 	WARN_ON(vs->vs_events_nr);
 	mutex_unlock(&vs->dev.mutex);
 	return 0;
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index bc31db6ef7d2..3e9f2bda6702 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -24,7 +24,7 @@ config VGA_CONSOLE
 	  Say Y.
 
 config MDA_CONSOLE
-	depends on !M68K && !PARISC && ISA
+	depends on VGA_CONSOLE && ISA
 	tristate "MDA text console (dual-headed)"
 	help
 	  Say Y here if you have an old MDA or monochrome Hercules graphics
@@ -52,7 +52,7 @@ config DUMMY_CONSOLE
 
 config DUMMY_CONSOLE_COLUMNS
 	int "Initial number of console screen columns"
-	depends on DUMMY_CONSOLE && !ARCH_FOOTBRIDGE
+	depends on DUMMY_CONSOLE && !(ARCH_FOOTBRIDGE && VGA_CONSOLE)
 	default 160 if PARISC
 	default 80
 	help
@@ -62,7 +62,7 @@ config DUMMY_CONSOLE_COLUMNS
 
 config DUMMY_CONSOLE_ROWS
 	int "Initial number of console screen rows"
-	depends on DUMMY_CONSOLE && !ARCH_FOOTBRIDGE
+	depends on DUMMY_CONSOLE && !(ARCH_FOOTBRIDGE && VGA_CONSOLE)
 	default 64 if PARISC
 	default 30 if ARM
 	default 25
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 840f22160763..6251a6b07b3a 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -137,13 +137,15 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 	 */
 int au1100fb_setmode(struct au1100fb_device *fbdev)
 {
-	struct fb_info *info = &fbdev->info;
+	struct fb_info *info;
 	u32 words;
 	int index;
 
 	if (!fbdev)
 		return -EINVAL;
 
+	info = &fbdev->info;
+
 	/* Update var-dependent FB info */
 	if (panel_is_active(fbdev->panel) || panel_is_color(fbdev->panel)) {
 		if (info->var.bits_per_pixel <= 8) {
diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 86ecbb2d86db..2eb27ebf822e 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -326,6 +326,13 @@ static int sm501fb_check_var(struct fb_var_screeninfo *var,
 	if (var->xres_virtual > 4096 || var->yres_virtual > 2048)
 		return -EINVAL;
 
+	/* geometry sanity checks */
+	if (var->xres + var->xoffset > var->xres_virtual)
+		return -EINVAL;
+
+	if (var->yres + var->yoffset > var->yres_virtual)
+		return -EINVAL;
+
 	/* can cope with 8,16 or 32bpp */
 
 	if (var->bits_per_pixel <= 8)
diff --git a/drivers/w1/masters/w1-uart.c b/drivers/w1/masters/w1-uart.c
index a31782e56ba7..c87eea347806 100644
--- a/drivers/w1/masters/w1-uart.c
+++ b/drivers/w1/masters/w1-uart.c
@@ -372,11 +372,11 @@ static int w1_uart_probe(struct serdev_device *serdev)
 	init_completion(&w1dev->rx_byte_received);
 	mutex_init(&w1dev->rx_mutex);
 
+	serdev_device_set_drvdata(serdev, w1dev);
+	serdev_device_set_client_ops(serdev, &w1_uart_serdev_ops);
 	ret = w1_uart_serdev_open(w1dev);
 	if (ret < 0)
 		return ret;
-	serdev_device_set_drvdata(serdev, w1dev);
-	serdev_device_set_client_ops(serdev, &w1_uart_serdev_ops);
 
 	return w1_add_master_device(&w1dev->bus);
 }
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 143ac03b7425..3397939fd2d5 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -407,8 +407,8 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 			 err);
 		goto error;
 	}
-	v9fs_fid_add(dentry, &fid);
 	v9fs_set_create_acl(inode, fid, dacl, pacl);
+	v9fs_fid_add(dentry, &fid);
 	d_instantiate(dentry, inode);
 	err = 0;
 	inc_nlink(dir);
diff --git a/fs/affs/file.c b/fs/affs/file.c
index a5a861dd5223..7a71018e3f67 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -596,7 +596,7 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 		BUG_ON(tmp > bsize);
 		AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 		AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-		AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+		AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 		affs_fix_checksum(sb, bh);
 		bh->b_state &= ~(1UL << BH_New);
@@ -724,7 +724,8 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		tmp = min(bsize - boff, to - from);
 		BUG_ON(boff + tmp > bsize || tmp > bsize);
 		memcpy(AFFS_DATA(bh) + boff, data + from, tmp);
-		be32_add_cpu(&AFFS_DATA_HEAD(bh)->size, tmp);
+		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(
+			max(boff + tmp, be32_to_cpu(AFFS_DATA_HEAD(bh)->size)));
 		affs_fix_checksum(sb, bh);
 		mark_buffer_dirty_inode(bh, inode);
 		written += tmp;
@@ -746,7 +747,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		if (buffer_new(bh)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 			AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(bsize);
 			AFFS_DATA_HEAD(bh)->next = 0;
 			bh->b_state &= ~(1UL << BH_New);
@@ -780,7 +781,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		if (buffer_new(bh)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 			AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
-			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
+			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx + 1);
 			AFFS_DATA_HEAD(bh)->size = cpu_to_be32(tmp);
 			AFFS_DATA_HEAD(bh)->next = 0;
 			bh->b_state &= ~(1UL << BH_New);
diff --git a/fs/exec.c b/fs/exec.c
index 67513bd606c2..d60794372963 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1246,13 +1246,12 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	bprm->point_of_no_return = true;
 
-	/*
-	 * Make this the only thread in the thread group.
-	 */
+	/* Make this the only thread in the thread group */
 	retval = de_thread(me);
 	if (retval)
 		goto out;
-
+	/* see the comment in check_unsafe_exec() */
+	current->fs->in_exec = 0;
 	/*
 	 * Cancel any io_uring activity across execve
 	 */
@@ -1514,6 +1513,8 @@ static void free_bprm(struct linux_binprm *bprm)
 	}
 	free_arg_pages(bprm);
 	if (bprm->cred) {
+		/* in case exec fails before de_thread() succeeds */
+		current->fs->in_exec = 0;
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
@@ -1620,6 +1621,10 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	 * suid exec because the differently privileged task
 	 * will be able to manipulate the current directory, etc.
 	 * It would be nice to force an unshare instead...
+	 *
+	 * Otherwise we set fs->in_exec = 1 to deny clone(CLONE_FS)
+	 * from another sub-thread until de_thread() succeeds, this
+	 * state is protected by cred_guard_mutex we hold.
 	 */
 	n_fs = 1;
 	spin_lock(&p->fs->lock);
@@ -1878,7 +1883,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 
 	sched_mm_cid_after_execve(current);
 	/* execve succeeded */
-	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
 	user_events_execve(current);
@@ -1897,7 +1901,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 		force_fatal_sig(SIGSEGV);
 
 	sched_mm_cid_after_execve(current);
-	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
 	return retval;
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 6f3651c6ca91..8df5ad6ebb10 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -265,7 +265,7 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 		clu = next;
 		if (exfat_ent_get(sb, clu, &next))
 			return -EIO;
-	} while (next != EXFAT_EOF_CLUSTER);
+	} while (next != EXFAT_EOF_CLUSTER && count <= p_chain->size);
 
 	if (p_chain->size != count) {
 		exfat_fs_error(sb,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 807349d8ea05..841a5b18e3df 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -582,6 +582,9 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t pos = iocb->ki_pos;
 	loff_t valid_size;
 
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	inode_lock(inode);
 
 	valid_size = ei->valid_size;
@@ -635,6 +638,16 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	return generic_file_read_iter(iocb, iter);
+}
+
 static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
 {
 	int err;
@@ -672,14 +685,26 @@ static const struct vm_operations_struct exfat_file_vm_ops = {
 
 static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	if (unlikely(exfat_forced_shutdown(file_inode(file)->i_sb)))
+		return -EIO;
+
 	file_accessed(file);
 	vma->vm_ops = &exfat_file_vm_ops;
 	return 0;
 }
 
+static ssize_t exfat_splice_read(struct file *in, loff_t *ppos,
+		struct pipe_inode_info *pipe, size_t len, unsigned int flags)
+{
+	if (unlikely(exfat_forced_shutdown(file_inode(in)->i_sb)))
+		return -EIO;
+
+	return filemap_splice_read(in, ppos, pipe, len, flags);
+}
+
 const struct file_operations exfat_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
+	.read_iter	= exfat_file_read_iter,
 	.write_iter	= exfat_file_write_iter,
 	.unlocked_ioctl = exfat_ioctl,
 #ifdef CONFIG_COMPAT
@@ -687,7 +712,7 @@ const struct file_operations exfat_file_operations = {
 #endif
 	.mmap		= exfat_file_mmap,
 	.fsync		= exfat_file_fsync,
-	.splice_read	= filemap_splice_read,
+	.splice_read	= exfat_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
 
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index d724de8f57bf..3801516ac507 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -344,7 +344,8 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 			 * The block has been partially written,
 			 * zero the unwritten part and map the block.
 			 */
-			loff_t size, off, pos;
+			loff_t size, pos;
+			void *addr;
 
 			max_blocks = 1;
 
@@ -355,17 +356,43 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 			if (!bh_result->b_folio)
 				goto done;
 
+			/*
+			 * No buffer_head is allocated.
+			 * (1) bmap: It's enough to fill bh_result without I/O.
+			 * (2) read: The unwritten part should be filled with 0
+			 *           If a folio does not have any buffers,
+			 *           let's returns -EAGAIN to fallback to
+			 *           per-bh IO like block_read_full_folio().
+			 */
+			if (!folio_buffers(bh_result->b_folio)) {
+				err = -EAGAIN;
+				goto done;
+			}
+
 			pos = EXFAT_BLK_TO_B(iblock, sb);
 			size = ei->valid_size - pos;
-			off = pos & (PAGE_SIZE - 1);
+			addr = folio_address(bh_result->b_folio) +
+			       offset_in_folio(bh_result->b_folio, pos);
+
+			/* Check if bh->b_data points to proper addr in folio */
+			if (bh_result->b_data != addr) {
+				exfat_fs_error_ratelimit(sb,
+					"b_data(%p) != folio_addr(%p)",
+					bh_result->b_data, addr);
+				err = -EINVAL;
+				goto done;
+			}
 
-			folio_set_bh(bh_result, bh_result->b_folio, off);
+			/* Read a block */
 			err = bh_read(bh_result, 0);
 			if (err < 0)
-				goto unlock_ret;
+				goto done;
+
+			/* Zero unwritten part of a block */
+			memset(bh_result->b_data + size, 0,
+			       bh_result->b_size - size);
 
-			folio_zero_segment(bh_result->b_folio, off + size,
-					off + sb->s_blocksize);
+			err = 0;
 		} else {
 			/*
 			 * The range has not been written, clear the mapped flag
@@ -376,6 +403,8 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	}
 done:
 	bh_result->b_size = EXFAT_BLK_TO_B(max_blocks, sb);
+	if (err < 0)
+		clear_buffer_mapped(bh_result);
 unlock_ret:
 	mutex_unlock(&sbi->s_lock);
 	return err;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e47a5ddfc79b..7b3951951f8a 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -639,6 +639,11 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->valid_size = le64_to_cpu(ep2->dentry.stream.valid_size);
 	info->size = le64_to_cpu(ep2->dentry.stream.size);
 
+	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clusters)) {
+		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);
+		return -EIO;
+	}
+
 	info->start_clu = le32_to_cpu(ep2->dentry.stream.start_clu);
 	if (!is_valid_cluster(sbi, info->start_clu) && info->size) {
 		exfat_warn(sb, "start_clu is invalid cluster(0x%x)",
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ef6a3c8f3a9a..b278b5703c19 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -104,6 +104,9 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 	else if (unlikely(le32_to_cpu(de->inode) >
 			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
 		error_msg = "inode out of bounds";
+	else if (unlikely(next_offset == size && de->name_len == 1 &&
+			  de->name[0] == '.'))
+		error_msg = "'.' directory cannot be the last in data block";
 	else
 		return 0;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 940ac1a49b72..d3795c6c0a9d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6781,22 +6781,29 @@ static int ext4_statfs_project(struct super_block *sb,
 			     dquot->dq_dqb.dqb_bhardlimit);
 	limit >>= sb->s_blocksize_bits;
 
-	if (limit && buf->f_blocks > limit) {
+	if (limit) {
+		uint64_t	remaining = 0;
+
 		curblock = (dquot->dq_dqb.dqb_curspace +
 			    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
-		buf->f_blocks = limit;
-		buf->f_bfree = buf->f_bavail =
-			(buf->f_blocks > curblock) ?
-			 (buf->f_blocks - curblock) : 0;
+		if (limit > curblock)
+			remaining = limit - curblock;
+
+		buf->f_blocks = min(buf->f_blocks, limit);
+		buf->f_bfree = min(buf->f_bfree, remaining);
+		buf->f_bavail = min(buf->f_bavail, remaining);
 	}
 
 	limit = min_not_zero(dquot->dq_dqb.dqb_isoftlimit,
 			     dquot->dq_dqb.dqb_ihardlimit);
-	if (limit && buf->f_files > limit) {
-		buf->f_files = limit;
-		buf->f_ffree =
-			(buf->f_files > dquot->dq_dqb.dqb_curinodes) ?
-			 (buf->f_files - dquot->dq_dqb.dqb_curinodes) : 0;
+	if (limit) {
+		uint64_t	remaining = 0;
+
+		if (limit > dquot->dq_dqb.dqb_curinodes)
+			remaining = limit - dquot->dq_dqb.dqb_curinodes;
+
+		buf->f_files = min(buf->f_files, limit);
+		buf->f_ffree = min(buf->f_ffree, remaining);
 	}
 
 	spin_unlock(&dquot->dq_dqb_lock);
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb..7faf1af59d5d 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -681,7 +681,6 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 			0, 0, fuse_wait_dax_page(inode));
 }
 
-/* dmap_end == 0 leads to unmapping of whole file */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index bd6e675023c6..a1e86ec07c38 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1936,7 +1936,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (FUSE_IS_DAX(inode) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err) {
 			filemap_invalidate_unlock(mapping);
 			return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e20d91d0ae55..f597f7e68e50 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -253,7 +253,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 
 	if (dax_truncate) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out_inode_unlock;
 	}
@@ -3146,7 +3146,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	inode_lock(inode);
 	if (block_faults) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out;
 	}
diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index 8b39c15c408c..15b2f094d36e 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -60,7 +60,7 @@ struct hostfs_stat {
 	unsigned int uid;
 	unsigned int gid;
 	unsigned long long size;
-	struct hostfs_timespec atime, mtime, ctime;
+	struct hostfs_timespec atime, mtime, ctime, btime;
 	unsigned int blksize;
 	unsigned long long blocks;
 	struct {
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 94f3cc42c740..a16a7df0766c 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -33,6 +33,7 @@ struct hostfs_inode_info {
 	struct inode vfs_inode;
 	struct mutex open_mutex;
 	dev_t dev;
+	struct hostfs_timespec btime;
 };
 
 static inline struct hostfs_inode_info *HOSTFS_I(struct inode *inode)
@@ -550,6 +551,7 @@ static int hostfs_inode_set(struct inode *ino, void *data)
 	}
 
 	HOSTFS_I(ino)->dev = dev;
+	HOSTFS_I(ino)->btime = st->btime;
 	ino->i_ino = st->ino;
 	ino->i_mode = st->mode;
 	return hostfs_inode_update(ino, st);
@@ -560,7 +562,10 @@ static int hostfs_inode_test(struct inode *inode, void *data)
 	const struct hostfs_stat *st = data;
 	dev_t dev = MKDEV(st->dev.maj, st->dev.min);
 
-	return inode->i_ino == st->ino && HOSTFS_I(inode)->dev == dev;
+	return inode->i_ino == st->ino && HOSTFS_I(inode)->dev == dev &&
+	       (inode->i_mode & S_IFMT) == (st->mode & S_IFMT) &&
+	       HOSTFS_I(inode)->btime.tv_sec == st->btime.tv_sec &&
+	       HOSTFS_I(inode)->btime.tv_nsec == st->btime.tv_nsec;
 }
 
 static struct inode *hostfs_iget(struct super_block *sb, char *name)
diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index 97e9c40a9448..3bcd9f35e70b 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -18,39 +18,48 @@
 #include "hostfs.h"
 #include <utime.h>
 
-static void stat64_to_hostfs(const struct stat64 *buf, struct hostfs_stat *p)
+static void statx_to_hostfs(const struct statx *buf, struct hostfs_stat *p)
 {
-	p->ino = buf->st_ino;
-	p->mode = buf->st_mode;
-	p->nlink = buf->st_nlink;
-	p->uid = buf->st_uid;
-	p->gid = buf->st_gid;
-	p->size = buf->st_size;
-	p->atime.tv_sec = buf->st_atime;
-	p->atime.tv_nsec = 0;
-	p->ctime.tv_sec = buf->st_ctime;
-	p->ctime.tv_nsec = 0;
-	p->mtime.tv_sec = buf->st_mtime;
-	p->mtime.tv_nsec = 0;
-	p->blksize = buf->st_blksize;
-	p->blocks = buf->st_blocks;
-	p->rdev.maj = os_major(buf->st_rdev);
-	p->rdev.min = os_minor(buf->st_rdev);
-	p->dev.maj = os_major(buf->st_dev);
-	p->dev.min = os_minor(buf->st_dev);
+	p->ino = buf->stx_ino;
+	p->mode = buf->stx_mode;
+	p->nlink = buf->stx_nlink;
+	p->uid = buf->stx_uid;
+	p->gid = buf->stx_gid;
+	p->size = buf->stx_size;
+	p->atime.tv_sec = buf->stx_atime.tv_sec;
+	p->atime.tv_nsec = buf->stx_atime.tv_nsec;
+	p->ctime.tv_sec = buf->stx_ctime.tv_sec;
+	p->ctime.tv_nsec = buf->stx_ctime.tv_nsec;
+	p->mtime.tv_sec = buf->stx_mtime.tv_sec;
+	p->mtime.tv_nsec = buf->stx_mtime.tv_nsec;
+	if (buf->stx_mask & STATX_BTIME) {
+		p->btime.tv_sec = buf->stx_btime.tv_sec;
+		p->btime.tv_nsec = buf->stx_btime.tv_nsec;
+	} else {
+		memset(&p->btime, 0, sizeof(p->btime));
+	}
+	p->blksize = buf->stx_blksize;
+	p->blocks = buf->stx_blocks;
+	p->rdev.maj = buf->stx_rdev_major;
+	p->rdev.min = buf->stx_rdev_minor;
+	p->dev.maj = buf->stx_dev_major;
+	p->dev.min = buf->stx_dev_minor;
 }
 
 int stat_file(const char *path, struct hostfs_stat *p, int fd)
 {
-	struct stat64 buf;
+	struct statx buf;
+	int flags = AT_SYMLINK_NOFOLLOW;
 
 	if (fd >= 0) {
-		if (fstat64(fd, &buf) < 0)
-			return -errno;
-	} else if (lstat64(path, &buf) < 0) {
-		return -errno;
+		flags |= AT_EMPTY_PATH;
+		path = "";
 	}
-	stat64_to_hostfs(&buf, p);
+
+	if ((statx(fd, path, flags, STATX_BASIC_STATS | STATX_BTIME, &buf)) < 0)
+		return -errno;
+
+	statx_to_hostfs(&buf, p);
 	return 0;
 }
 
diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index eb2f8273e6f1..09df40b612fb 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -147,7 +147,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 			de = tmpde;
 		}
 		/* Basic sanity check, whether name doesn't exceed dir entry */
-		if (de_len < de->name_len[0] +
+		if (de_len < sizeof(struct iso_directory_record) ||
+		    de_len < de->name_len[0] +
 					sizeof(struct iso_directory_record)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %lu\n", block,
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 8f85177f284b..93db6eec4465 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -117,7 +117,8 @@ do {									\
 	if (!(RC)) {							\
 		if (((P)->header.nextindex >				\
 		     (((BN) == 0) ? DTROOTMAXSLOT : (P)->header.maxslot)) || \
-		    ((BN) && ((P)->header.maxslot > DTPAGEMAXSLOT))) {	\
+		    ((BN) && (((P)->header.maxslot > DTPAGEMAXSLOT) ||	\
+		    ((P)->header.stblindex >= DTPAGEMAXSLOT)))) {	\
 			BT_PUTPAGE(MP);					\
 			jfs_error((IP)->i_sb,				\
 				  "DT_GETPAGE: dtree page corrupt\n");	\
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 24afbae87225..11d7f74d207b 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -559,11 +559,16 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 
       size_check:
 	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
-		int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
-
-		printk(KERN_ERR "ea_get: invalid extended attribute\n");
-		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ea_buf->xattr, size, 1);
+		if (unlikely(EALIST_SIZE(ea_buf->xattr) > INT_MAX)) {
+			printk(KERN_ERR "ea_get: extended attribute size too large: %u > INT_MAX\n",
+			       EALIST_SIZE(ea_buf->xattr));
+		} else {
+			int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
+
+			printk(KERN_ERR "ea_get: invalid extended attribute\n");
+			print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
+				       ea_buf->xattr, size, 1);
+		}
 		ea_release(inode, ea_buf);
 		rc = -EIO;
 		goto clean_up;
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index b1a66a6e6bc2..917b7edc34ef 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -108,9 +108,9 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
  * Perform a read to an application buffer, bypassing the pagecache and the
  * local disk cache.
  */
-static int netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
+static ssize_t netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 {
-	int ret;
+	ssize_t ret;
 
 	_enter("R=%x %llx-%llx",
 	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
@@ -149,7 +149,7 @@ static int netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 	}
 
 out:
-	_leave(" = %d", ret);
+	_leave(" = %zd", ret);
 	return ret;
 }
 
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 4db912f56230..325ba0663a6d 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -79,6 +79,7 @@ static void nfs_mark_return_delegation(struct nfs_server *server,
 				       struct nfs_delegation *delegation)
 {
 	set_bit(NFS_DELEGATION_RETURN, &delegation->flags);
+	set_bit(NFS4SERV_DELEGRETURN, &server->delegation_flags);
 	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
 }
 
@@ -330,14 +331,16 @@ nfs_start_delegation_return(struct nfs_inode *nfsi)
 }
 
 static void nfs_abort_delegation_return(struct nfs_delegation *delegation,
-					struct nfs_client *clp, int err)
+					struct nfs_server *server, int err)
 {
-
 	spin_lock(&delegation->lock);
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
 	if (err == -EAGAIN) {
 		set_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
-		set_bit(NFS4CLNT_DELEGRETURN_DELAYED, &clp->cl_state);
+		set_bit(NFS4SERV_DELEGRETURN_DELAYED,
+			&server->delegation_flags);
+		set_bit(NFS4CLNT_DELEGRETURN_DELAYED,
+			&server->nfs_client->cl_state);
 	}
 	spin_unlock(&delegation->lock);
 }
@@ -547,7 +550,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
  */
 static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation *delegation, int issync)
 {
-	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+	struct nfs_server *server = NFS_SERVER(inode);
 	unsigned int mode = O_WRONLY | O_RDWR;
 	int err = 0;
 
@@ -569,11 +572,11 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 		/*
 		 * Guard against state recovery
 		 */
-		err = nfs4_wait_clnt_recover(clp);
+		err = nfs4_wait_clnt_recover(server->nfs_client);
 	}
 
 	if (err) {
-		nfs_abort_delegation_return(delegation, clp, err);
+		nfs_abort_delegation_return(delegation, server, err);
 		goto out;
 	}
 
@@ -590,17 +593,6 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 
 	if (test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags))
 		ret = true;
-	else if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags)) {
-		struct inode *inode;
-
-		spin_lock(&delegation->lock);
-		inode = delegation->inode;
-		if (inode && list_empty(&NFS_I(inode)->open_files))
-			ret = true;
-		spin_unlock(&delegation->lock);
-	}
-	if (ret)
-		clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
 	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
 	    test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
 	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
@@ -619,6 +611,9 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 	struct nfs_delegation *place_holder_deleg = NULL;
 	int err = 0;
 
+	if (!test_and_clear_bit(NFS4SERV_DELEGRETURN,
+				&server->delegation_flags))
+		return 0;
 restart:
 	/*
 	 * To avoid quadratic looping we hold a reference
@@ -670,6 +665,7 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 		cond_resched();
 		if (!err)
 			goto restart;
+		set_bit(NFS4SERV_DELEGRETURN, &server->delegation_flags);
 		set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
 		goto out;
 	}
@@ -684,6 +680,9 @@ static bool nfs_server_clear_delayed_delegations(struct nfs_server *server)
 	struct nfs_delegation *d;
 	bool ret = false;
 
+	if (!test_and_clear_bit(NFS4SERV_DELEGRETURN_DELAYED,
+				&server->delegation_flags))
+		goto out;
 	list_for_each_entry_rcu (d, &server->delegations, super_list) {
 		if (!test_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags))
 			continue;
@@ -691,6 +690,7 @@ static bool nfs_server_clear_delayed_delegations(struct nfs_server *server)
 		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags);
 		ret = true;
 	}
+out:
 	return ret;
 }
 
@@ -878,11 +878,25 @@ int nfs4_inode_make_writeable(struct inode *inode)
 	return nfs4_inode_return_delegation(inode);
 }
 
-static void nfs_mark_return_if_closed_delegation(struct nfs_server *server,
-		struct nfs_delegation *delegation)
+static void
+nfs_mark_return_if_closed_delegation(struct nfs_server *server,
+				     struct nfs_delegation *delegation)
 {
-	set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
-	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
+	struct inode *inode;
+
+	if (test_bit(NFS_DELEGATION_RETURN, &delegation->flags) ||
+	    test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags))
+		return;
+	spin_lock(&delegation->lock);
+	inode = delegation->inode;
+	if (!inode)
+		goto out;
+	if (list_empty(&NFS_I(inode)->open_files))
+		nfs_mark_return_delegation(server, delegation);
+	else
+		set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
+out:
+	spin_unlock(&delegation->lock);
 }
 
 static bool nfs_server_mark_return_all_delegations(struct nfs_server *server)
@@ -1276,6 +1290,7 @@ static void nfs_mark_test_expired_delegation(struct nfs_server *server,
 		return;
 	clear_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags);
 	set_bit(NFS_DELEGATION_TEST_EXPIRED, &delegation->flags);
+	set_bit(NFS4SERV_DELEGATION_EXPIRED, &server->delegation_flags);
 	set_bit(NFS4CLNT_DELEGATION_EXPIRED, &server->nfs_client->cl_state);
 }
 
@@ -1354,6 +1369,9 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 	nfs4_stateid stateid;
 	unsigned long gen = ++server->delegation_gen;
 
+	if (!test_and_clear_bit(NFS4SERV_DELEGATION_EXPIRED,
+				&server->delegation_flags))
+		return 0;
 restart:
 	rcu_read_lock();
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
@@ -1383,6 +1401,9 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 			goto restart;
 		}
 		nfs_inode_mark_test_expired_delegation(server,inode);
+		set_bit(NFS4SERV_DELEGATION_EXPIRED, &server->delegation_flags);
+		set_bit(NFS4CLNT_DELEGATION_EXPIRED,
+			&server->nfs_client->cl_state);
 		iput(inode);
 		return -EAGAIN;
 	}
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index e8ac3f615f93..71f45cc0ca74 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -82,9 +82,8 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
  * we currently use size 2 (u64) out of (NFS4_OPAQUE_LIMIT  >> 2)
  */
 #define pagepad_maxsz		(1)
-#define open_owner_id_maxsz	(1 + 2 + 1 + 1 + 2)
-#define lock_owner_id_maxsz	(1 + 1 + 4)
-#define decode_lockowner_maxsz	(1 + XDR_QUADLEN(IDMAP_NAMESZ))
+#define open_owner_id_maxsz	(2 + 1 + 2 + 2)
+#define lock_owner_id_maxsz	(2 + 1 + 2)
 #define compound_encode_hdr_maxsz	(3 + (NFS4_MAXTAGLEN >> 2))
 #define compound_decode_hdr_maxsz	(3 + (NFS4_MAXTAGLEN >> 2))
 #define op_encode_hdr_maxsz	(1)
@@ -185,7 +184,7 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define encode_claim_null_maxsz	(1 + nfs4_name_maxsz)
 #define encode_open_maxsz	(op_encode_hdr_maxsz + \
 				2 + encode_share_access_maxsz + 2 + \
-				open_owner_id_maxsz + \
+				1 + open_owner_id_maxsz + \
 				encode_opentype_maxsz + \
 				encode_claim_null_maxsz)
 #define decode_space_limit_maxsz	(3)
@@ -255,13 +254,14 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define encode_link_maxsz	(op_encode_hdr_maxsz + \
 				nfs4_name_maxsz)
 #define decode_link_maxsz	(op_decode_hdr_maxsz + decode_change_info_maxsz)
-#define encode_lockowner_maxsz	(7)
+#define encode_lockowner_maxsz	(2 + 1 + lock_owner_id_maxsz)
+
 #define encode_lock_maxsz	(op_encode_hdr_maxsz + \
 				 7 + \
 				 1 + encode_stateid_maxsz + 1 + \
 				 encode_lockowner_maxsz)
 #define decode_lock_denied_maxsz \
-				(8 + decode_lockowner_maxsz)
+				(2 + 2 + 1 + 2 + 1 + lock_owner_id_maxsz)
 #define decode_lock_maxsz	(op_decode_hdr_maxsz + \
 				 decode_lock_denied_maxsz)
 #define encode_lockt_maxsz	(op_encode_hdr_maxsz + 5 + \
@@ -617,7 +617,7 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				 encode_lockowner_maxsz)
 #define NFS4_dec_release_lockowner_sz \
 				(compound_decode_hdr_maxsz + \
-				 decode_lockowner_maxsz)
+				 decode_release_lockowner_maxsz)
 #define NFS4_enc_access_sz	(compound_encode_hdr_maxsz + \
 				encode_sequence_maxsz + \
 				encode_putfh_maxsz + \
@@ -1412,7 +1412,7 @@ static inline void encode_openhdr(struct xdr_stream *xdr, const struct nfs_opena
 	__be32 *p;
  /*
  * opcode 4, seqid 4, share_access 4, share_deny 4, clientid 8, ownerlen 4,
- * owner 4 = 32
+ * owner 28
  */
 	encode_nfs4_seqid(xdr, arg->seqid);
 	encode_share_access(xdr, arg->share_access);
@@ -5077,7 +5077,7 @@ static int decode_link(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
 /*
  * We create the owner, so we know a proper owner.id length is 4.
  */
-static int decode_lock_denied (struct xdr_stream *xdr, struct file_lock *fl)
+static int decode_lock_denied(struct xdr_stream *xdr, struct file_lock *fl)
 {
 	uint64_t offset, length, clientid;
 	__be32 *p;
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 7b59a40d40c0..784f7c1d003b 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -14,6 +14,7 @@
 #include <linux/rcupdate.h>
 #include <linux/lockd/lockd.h>
 
+#include "internal.h"
 #include "nfs4_fs.h"
 #include "netns.h"
 #include "sysfs.h"
@@ -228,6 +229,25 @@ static void shutdown_client(struct rpc_clnt *clnt)
 	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
 }
 
+/*
+ * Shut down the nfs_client only once all the superblocks
+ * have been shut down.
+ */
+static void shutdown_nfs_client(struct nfs_client *clp)
+{
+	struct nfs_server *server;
+	rcu_read_lock();
+	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
+		if (!(server->flags & NFS_MOUNT_SHUTDOWN)) {
+			rcu_read_unlock();
+			return;
+		}
+	}
+	rcu_read_unlock();
+	nfs_mark_client_ready(clp, -EIO);
+	shutdown_client(clp->cl_rpcclient);
+}
+
 static ssize_t
 shutdown_show(struct kobject *kobj, struct kobj_attribute *attr,
 				char *buf)
@@ -259,7 +279,6 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 	server->flags |= NFS_MOUNT_SHUTDOWN;
 	shutdown_client(server->client);
-	shutdown_client(server->nfs_client->cl_rpcclient);
 
 	if (!IS_ERR(server->client_acl))
 		shutdown_client(server->client_acl);
@@ -267,6 +286,7 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (server->nlm_host)
 		shutdown_client(server->nlm_host->h_rpcclnt);
 out:
+	shutdown_nfs_client(server->nfs_client);
 	return count;
 }
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 82ae2b85d393..8ff8db09a1e0 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -579,8 +579,10 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 
 	while (!nfs_lock_request(head)) {
 		ret = nfs_wait_on_request(head);
-		if (ret < 0)
+		if (ret < 0) {
+			nfs_release_request(head);
 			return ERR_PTR(ret);
+		}
 	}
 
 	/* Ensure that nobody removed the request before we locked it */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 57f8818aa47c..5e81c819c384 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1057,6 +1057,12 @@ static struct nfs4_ol_stateid * nfs4_alloc_open_stateid(struct nfs4_client *clp)
 	return openlockstateid(stid);
 }
 
+/*
+ * As the sc_free callback of deleg, this may be called by nfs4_put_stid
+ * in nfsd_break_one_deleg.
+ * Considering nfsd_break_one_deleg is called with the flc->flc_lock held,
+ * this function mustn't ever sleep.
+ */
 static void nfs4_free_deleg(struct nfs4_stid *stid)
 {
 	struct nfs4_delegation *dp = delegstateid(stid);
@@ -5269,6 +5275,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
 
 static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 {
+	bool queued;
 	/*
 	 * We're assuming the state code never drops its reference
 	 * without first removing the lease.  Since we're in this lease
@@ -5277,7 +5284,10 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	 * we know it's safe to take a reference.
 	 */
 	refcount_inc(&dp->dl_stid.sc_count);
-	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
+	queued = nfsd4_run_cb(&dp->dl_recall);
+	WARN_ON_ONCE(!queued);
+	if (!queued)
+		nfs4_put_stid(&dp->dl_stid);
 }
 
 /* Called from break_lease() with flc_lock held. */
@@ -6689,14 +6699,19 @@ deleg_reaper(struct nfsd_net *nn)
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		if (clp->cl_state != NFSD4_ACTIVE ||
-			list_empty(&clp->cl_delegations) ||
-			atomic_read(&clp->cl_delegs_in_recall) ||
-			test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) ||
-			(ktime_get_boottime_seconds() -
-				clp->cl_ra_time < 5)) {
+
+		if (clp->cl_state != NFSD4_ACTIVE)
+			continue;
+		if (list_empty(&clp->cl_delegations))
+			continue;
+		if (atomic_read(&clp->cl_delegs_in_recall))
+			continue;
+		if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags))
+			continue;
+		if (ktime_get_boottime_seconds() - clp->cl_ra_time < 5)
+			continue;
+		if (clp->cl_cb_state != NFSD4_CB_UP)
 			continue;
-		}
 		list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */
@@ -6880,7 +6895,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		 */
 		statusmask |= SC_STATUS_REVOKED;
 
-	statusmask |= SC_STATUS_ADMIN_REVOKED;
+	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
@@ -7535,9 +7550,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
-	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG,
-				      SC_STATUS_REVOKED | SC_STATUS_FREEABLE,
-				      &s, nn);
+	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);
 	if (status)
 		goto out;
 	dp = delegstateid(s);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3adbc05ebaac..e83629f39604 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1959,6 +1959,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	struct svc_serv *serv;
 	LIST_HEAD(permsocks);
 	struct nfsd_net *nn;
+	bool delete = false;
 	int err, rem;
 
 	mutex_lock(&nfsd_mutex);
@@ -2019,34 +2020,28 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	/* For now, no removing old sockets while server is running */
-	if (serv->sv_nrthreads && !list_empty(&permsocks)) {
+	/*
+	 * If there are listener transports remaining on the permsocks list,
+	 * it means we were asked to remove a listener.
+	 */
+	if (!list_empty(&permsocks)) {
 		list_splice_init(&permsocks, &serv->sv_permsocks);
-		spin_unlock_bh(&serv->sv_lock);
-		err = -EBUSY;
-		goto out_unlock_mtx;
+		delete = true;
 	}
+	spin_unlock_bh(&serv->sv_lock);
 
-	/* Close the remaining sockets on the permsocks list */
-	while (!list_empty(&permsocks)) {
-		xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
-		list_move(&xprt->xpt_list, &serv->sv_permsocks);
-
-		/*
-		 * Newly-created sockets are born with the BUSY bit set. Clear
-		 * it if there are no threads, since nothing can pick it up
-		 * in that case.
-		 */
-		if (!serv->sv_nrthreads)
-			clear_bit(XPT_BUSY, &xprt->xpt_flags);
-
-		set_bit(XPT_CLOSE, &xprt->xpt_flags);
-		spin_unlock_bh(&serv->sv_lock);
-		svc_xprt_close(xprt);
-		spin_lock_bh(&serv->sv_lock);
+	/* Do not remove listeners while there are active threads. */
+	if (serv->sv_nrthreads) {
+		err = -EBUSY;
+		goto out_unlock_mtx;
 	}
 
-	spin_unlock_bh(&serv->sv_lock);
+	/*
+	 * Since we can't delete an arbitrary llist entry, destroy the
+	 * remaining listeners and recreate the list.
+	 */
+	if (delete)
+		svc_xprt_destroy_all(serv, net);
 
 	/* walk list of addrs again, open any that still don't exist */
 	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
@@ -2073,6 +2068,9 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 		xprt = svc_find_listener(serv, xcl_name, net, sa);
 		if (xprt) {
+			if (delete)
+				WARN_ONCE(1, "Transport type=%s already exists\n",
+					  xcl_name);
 			svc_xprt_put(xprt);
 			continue;
 		}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d6d4f2a0e898..ca29a5e1600f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1935,9 +1935,17 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	return err;
 }
 
-/*
- * Unlink a file or directory
- * N.B. After this call fhp needs an fh_put
+/**
+ * nfsd_unlink - remove a directory entry
+ * @rqstp: RPC transaction context
+ * @fhp: the file handle of the parent directory to be modified
+ * @type: enforced file type of the object to be removed
+ * @fname: the name of directory entry to be removed
+ * @flen: length of @fname in octets
+ *
+ * After this call fhp needs an fh_put.
+ *
+ * Returns a generic NFS status code in network byte-order.
  */
 __be32
 nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
@@ -2011,15 +2019,17 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	fh_drop_write(fhp);
 out_nfserr:
 	if (host_err == -EBUSY) {
-		/* name is mounted-on. There is no perfect
-		 * error status.
+		/*
+		 * See RFC 8881 Section 18.25.4 para 4: NFSv4 REMOVE
+		 * wants a status unique to the object type.
 		 */
-		err = nfserr_file_open;
-	} else {
-		err = nfserrno(host_err);
+		if (type != S_IFDIR)
+			err = nfserr_file_open;
+		else
+			err = nfserr_acces;
 	}
 out:
-	return err;
+	return err != nfs_ok ? err : nfserrno(host_err);
 out_unlock:
 	inode_unlock(dirp);
 	goto out_drop_write;
diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index da1a9312e61a..dd459316529e 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2663,8 +2663,9 @@ int attr_set_compress(struct ntfs_inode *ni, bool compr)
 		attr->nres.run_off = cpu_to_le16(run_off);
 	}
 
-	/* Update data attribute flags. */
+	/* Update attribute flags. */
 	if (compr) {
+		attr->flags &= ~ATTR_FLAG_SPARSED;
 		attr->flags |= ATTR_FLAG_COMPRESSED;
 		attr->nres.c_unit = NTFS_LZNT_CUNIT;
 	} else {
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index f704ceef9539..7976ac4611c8 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -101,8 +101,26 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 	/* Allowed to change compression for empty files and for directories only. */
 	if (!is_dedup(ni) && !is_encrypted(ni) &&
 	    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
-		/* Change compress state. */
-		int err = ni_set_compress(inode, flags & FS_COMPR_FL);
+		int err = 0;
+		struct address_space *mapping = inode->i_mapping;
+
+		/* write out all data and wait. */
+		filemap_invalidate_lock(mapping);
+		err = filemap_write_and_wait(mapping);
+
+		if (err >= 0) {
+			/* Change compress state. */
+			bool compr = flags & FS_COMPR_FL;
+			err = ni_set_compress(inode, compr);
+
+			/* For files change a_ops too. */
+			if (!err)
+				mapping->a_ops = compr ? &ntfs_aops_cmpr :
+							 &ntfs_aops;
+		}
+
+		filemap_invalidate_unlock(mapping);
+
 		if (err)
 			return err;
 	}
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 175662acd5ea..608634361a30 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3431,10 +3431,12 @@ int ni_set_compress(struct inode *inode, bool compr)
 	}
 
 	ni->std_fa = std->fa;
-	if (compr)
+	if (compr) {
+		std->fa &= ~FILE_ATTRIBUTE_SPARSE_FILE;
 		std->fa |= FILE_ATTRIBUTE_COMPRESSED;
-	else
+	} else {
 		std->fa &= ~FILE_ATTRIBUTE_COMPRESSED;
+	}
 
 	if (ni->std_fa != std->fa) {
 		ni->std_fa = std->fa;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 7eb9fae22f8d..78d20e4baa2c 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -618,7 +618,7 @@ static bool index_hdr_check(const struct INDEX_HDR *hdr, u32 bytes)
 	u32 off = le32_to_cpu(hdr->de_off);
 
 	if (!IS_ALIGNED(off, 8) || tot > bytes || end > tot ||
-	    off + sizeof(struct NTFS_DE) > end) {
+	    size_add(off, sizeof(struct NTFS_DE)) > end) {
 		/* incorrect index buffer. */
 		return false;
 	}
@@ -736,7 +736,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 	if (end > total)
 		return NULL;
 
-	if (off + sizeof(struct NTFS_DE) > end)
+	if (size_add(off, sizeof(struct NTFS_DE)) > end)
 		return NULL;
 
 	e = Add2Ptr(hdr, off);
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 241f2ffdd920..1ff13b6f9613 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -717,7 +717,7 @@ static inline struct NTFS_DE *hdr_first_de(const struct INDEX_HDR *hdr)
 	struct NTFS_DE *e;
 	u16 esize;
 
-	if (de_off >= used || de_off + sizeof(struct NTFS_DE) > used )
+	if (de_off >= used || size_add(de_off, sizeof(struct NTFS_DE)) > used)
 		return NULL;
 
 	e = Add2Ptr(hdr, de_off);
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index ea9127ba3208..5d9388b44e5b 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1803,6 +1803,14 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 
 	el = root_el;
 	while (el->l_tree_depth) {
+		if (unlikely(le16_to_cpu(el->l_tree_depth) >= OCFS2_MAX_PATH_DEPTH)) {
+			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
+				    "Owner %llu has invalid tree depth %u in extent list\n",
+				    (unsigned long long)ocfs2_metadata_cache_owner(ci),
+				    le16_to_cpu(el->l_tree_depth));
+			ret = -EROFS;
+			goto out;
+		}
 		if (le16_to_cpu(el->l_next_free_rec) == 0) {
 			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
 				    "Owner %llu has empty extent list at depth %u\n",
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b31283d81c52..a2541f5204af 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -417,7 +417,7 @@ static const struct file_operations proc_pid_cmdline_ops = {
 #ifdef CONFIG_KALLSYMS
 /*
  * Provides a wchan file via kallsyms in a proper one-value-per-file format.
- * Returns the resolved symbol.  If that fails, simply return the address.
+ * Returns the resolved symbol to user space.
  */
 static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index ebe9a7d7c70e..e36f0e2d7d21 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -763,7 +763,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 		       struct cifs_fattr *fattr, bool mode_from_special_sid)
 {
 	int i;
-	int num_aces = 0;
+	u16 num_aces = 0;
 	int acl_size;
 	char *acl_base;
 	struct smb_ace **ppace;
@@ -778,14 +778,15 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	}
 
 	/* validate that we do not go past end of acl */
-	if (end_of_acl < (char *)pdacl + le16_to_cpu(pdacl->size)) {
+	if (end_of_acl < (char *)pdacl + sizeof(struct smb_acl) ||
+	    end_of_acl < (char *)pdacl + le16_to_cpu(pdacl->size)) {
 		cifs_dbg(VFS, "ACL too small to parse DACL\n");
 		return;
 	}
 
 	cifs_dbg(NOISY, "DACL revision %d size %d num aces %d\n",
 		 le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
-		 le32_to_cpu(pdacl->num_aces));
+		 le16_to_cpu(pdacl->num_aces));
 
 	/* reset rwx permissions for user/group/other.
 	   Also, if num_aces is 0 i.e. DACL has no ACEs,
@@ -795,12 +796,15 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	acl_base = (char *)pdacl;
 	acl_size = sizeof(struct smb_acl);
 
-	num_aces = le32_to_cpu(pdacl->num_aces);
+	num_aces = le16_to_cpu(pdacl->num_aces);
 	if (num_aces > 0) {
 		umode_t denied_mode = 0;
 
-		if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
+		if (num_aces > (le16_to_cpu(pdacl->size) - sizeof(struct smb_acl)) /
+				(offsetof(struct smb_ace, sid) +
+				 offsetof(struct smb_sid, sub_auth) + sizeof(__le16)))
 			return;
+
 		ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *),
 				      GFP_KERNEL);
 		if (!ppace)
@@ -937,12 +941,12 @@ unsigned int setup_special_user_owner_ACE(struct smb_ace *pntace)
 static void populate_new_aces(char *nacl_base,
 		struct smb_sid *pownersid,
 		struct smb_sid *pgrpsid,
-		__u64 *pnmode, u32 *pnum_aces, u16 *pnsize,
+		__u64 *pnmode, u16 *pnum_aces, u16 *pnsize,
 		bool modefromsid,
 		bool posix)
 {
 	__u64 nmode;
-	u32 num_aces = 0;
+	u16 num_aces = 0;
 	u16 nsize = 0;
 	__u64 user_mode;
 	__u64 group_mode;
@@ -1050,7 +1054,7 @@ static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *p
 	u16 size = 0;
 	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
-	u32 src_num_aces = 0;
+	u16 src_num_aces = 0;
 	u16 nsize = 0;
 	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
@@ -1058,7 +1062,7 @@ static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *p
 
 	acl_base = (char *)pdacl;
 	size = sizeof(struct smb_acl);
-	src_num_aces = le32_to_cpu(pdacl->num_aces);
+	src_num_aces = le16_to_cpu(pdacl->num_aces);
 
 	nacl_base = (char *)pndacl;
 	nsize = sizeof(struct smb_acl);
@@ -1090,11 +1094,11 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 	u16 size = 0;
 	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
-	u32 src_num_aces = 0;
+	u16 src_num_aces = 0;
 	u16 nsize = 0;
 	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
-	u32 num_aces = 0;
+	u16 num_aces = 0;
 	bool new_aces_set = false;
 
 	/* Assuming that pndacl and pnmode are never NULL */
@@ -1112,7 +1116,7 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 
 	acl_base = (char *)pdacl;
 	size = sizeof(struct smb_acl);
-	src_num_aces = le32_to_cpu(pdacl->num_aces);
+	src_num_aces = le16_to_cpu(pdacl->num_aces);
 
 	/* Retain old ACEs which we can retain */
 	for (i = 0; i < src_num_aces; ++i) {
@@ -1158,7 +1162,7 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 	}
 
 finalize_dacl:
-	pndacl->num_aces = cpu_to_le32(num_aces);
+	pndacl->num_aces = cpu_to_le16(num_aces);
 	pndacl->size = cpu_to_le16(nsize);
 
 	return 0;
@@ -1293,7 +1297,7 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 			dacloffset ? dacl_ptr->revision : cpu_to_le16(ACL_REVISION);
 
 		ndacl_ptr->size = cpu_to_le16(0);
-		ndacl_ptr->num_aces = cpu_to_le32(0);
+		ndacl_ptr->num_aces = cpu_to_le16(0);
 
 		rc = set_chmod_dacl(dacl_ptr, ndacl_ptr, owner_sid_ptr, group_sid_ptr,
 				    pnmode, mode_from_sid, posix);
@@ -1651,7 +1655,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 			if (mode_from_sid)
 				nsecdesclen +=
-					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
+					le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
 			else /* cifsacl */
 				nsecdesclen += le16_to_cpu(dacl_ptr->size);
 		}
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index d327f31b317d..8b8475b4e262 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -316,6 +316,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 			 server->ssocket->flags);
 		sock_release(server->ssocket);
 		server->ssocket = NULL;
+		put_net(cifs_net_ns(server));
 	}
 	server->sequence_number = 0;
 	server->session_estab = false;
@@ -3138,8 +3139,12 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		/*
 		 * Grab netns reference for the socket.
 		 *
-		 * It'll be released here, on error, or in clean_demultiplex_info() upon server
-		 * teardown.
+		 * This reference will be released in several situations:
+		 * - In the failure path before the cifsd thread is started.
+		 * - In the all place where server->socket is released, it is
+		 *   also set to NULL.
+		 * - Ultimately in clean_demultiplex_info(), during the final
+		 *   teardown.
 		 */
 		get_net(net);
 
@@ -3155,10 +3160,8 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	}
 
 	rc = bind_socket(server);
-	if (rc < 0) {
-		put_net(cifs_net_ns(server));
+	if (rc < 0)
 		return rc;
-	}
 
 	/*
 	 * Eventually check for other socket options to change from
@@ -3204,9 +3207,6 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	if (sport == htons(RFC1001_PORT))
 		rc = ip_rfc1001_connect(server);
 
-	if (rc < 0)
-		put_net(cifs_net_ns(server));
-
 	return rc;
 }
 
diff --git a/fs/smb/common/smbacl.h b/fs/smb/common/smbacl.h
index 6a60698fc6f0..a624ec9e4a14 100644
--- a/fs/smb/common/smbacl.h
+++ b/fs/smb/common/smbacl.h
@@ -107,7 +107,8 @@ struct smb_sid {
 struct smb_acl {
 	__le16 revision; /* revision level */
 	__le16 size;
-	__le32 num_aces;
+	__le16 num_aces;
+	__le16 reserved;
 } __attribute__((packed));
 
 struct smb_ace {
diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 8892177e500f..954497513683 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -1016,9 +1016,9 @@ static int ksmbd_get_encryption_key(struct ksmbd_work *work, __u64 ses_id,
 
 	ses_enc_key = enc ? sess->smb3encryptionkey :
 		sess->smb3decryptionkey;
-	if (enc)
-		ksmbd_user_session_get(sess);
 	memcpy(key, ses_enc_key, SMB3_ENC_DEC_KEY_SIZE);
+	if (!enc)
+		ksmbd_user_session_put(sess);
 
 	return 0;
 }
@@ -1217,7 +1217,7 @@ int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 free_sg:
 	kfree(sg);
 free_req:
-	kfree(req);
+	aead_request_free(req);
 free_ctx:
 	ksmbd_release_crypto_ctx(ctx);
 	return rc;
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 91c2318639e7..14620e147dda 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -27,6 +27,7 @@ enum {
 	KSMBD_SESS_EXITING,
 	KSMBD_SESS_NEED_RECONNECT,
 	KSMBD_SESS_NEED_NEGOTIATE,
+	KSMBD_SESS_NEED_SETUP,
 	KSMBD_SESS_RELEASING
 };
 
@@ -187,6 +188,11 @@ static inline bool ksmbd_conn_need_negotiate(struct ksmbd_conn *conn)
 	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_NEGOTIATE;
 }
 
+static inline bool ksmbd_conn_need_setup(struct ksmbd_conn *conn)
+{
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_SETUP;
+}
+
 static inline bool ksmbd_conn_need_reconnect(struct ksmbd_conn *conn)
 {
 	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_RECONNECT;
@@ -217,6 +223,11 @@ static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_conn *conn)
 	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_NEGOTIATE);
 }
 
+static inline void ksmbd_conn_set_need_setup(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_SETUP);
+}
+
 static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_conn *conn)
 {
 	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_RECONNECT);
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index d960ddcbba16..f83daf72f877 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -181,7 +181,7 @@ static void ksmbd_expire_session(struct ksmbd_conn *conn)
 	down_write(&sessions_table_lock);
 	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
-		if (atomic_read(&sess->refcnt) == 0 &&
+		if (atomic_read(&sess->refcnt) <= 1 &&
 		    (sess->state != SMB2_SESSION_VALID ||
 		     time_after(jiffies,
 			       sess->last_active + SMB2_SESSION_TIMEOUT))) {
@@ -230,7 +230,11 @@ void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 			if (!ksmbd_chann_del(conn, sess) &&
 			    xa_empty(&sess->ksmbd_chann_list)) {
 				hash_del(&sess->hlist);
-				ksmbd_session_destroy(sess);
+				down_write(&conn->session_lock);
+				xa_erase(&conn->sessions, sess->id);
+				up_write(&conn->session_lock);
+				if (atomic_dec_and_test(&sess->refcnt))
+					ksmbd_session_destroy(sess);
 			}
 		}
 	}
@@ -249,13 +253,30 @@ void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 		if (xa_empty(&sess->ksmbd_chann_list)) {
 			xa_erase(&conn->sessions, sess->id);
 			hash_del(&sess->hlist);
-			ksmbd_session_destroy(sess);
+			if (atomic_dec_and_test(&sess->refcnt))
+				ksmbd_session_destroy(sess);
 		}
 	}
 	up_write(&conn->session_lock);
 	up_write(&sessions_table_lock);
 }
 
+bool is_ksmbd_session_in_connection(struct ksmbd_conn *conn,
+				   unsigned long long id)
+{
+	struct ksmbd_session *sess;
+
+	down_read(&conn->session_lock);
+	sess = xa_load(&conn->sessions, id);
+	if (sess) {
+		up_read(&conn->session_lock);
+		return true;
+	}
+	up_read(&conn->session_lock);
+
+	return false;
+}
+
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 					   unsigned long long id)
 {
@@ -309,8 +330,8 @@ void ksmbd_user_session_put(struct ksmbd_session *sess)
 
 	if (atomic_read(&sess->refcnt) <= 0)
 		WARN_ON(1);
-	else
-		atomic_dec(&sess->refcnt);
+	else if (atomic_dec_and_test(&sess->refcnt))
+		ksmbd_session_destroy(sess);
 }
 
 struct preauth_session *ksmbd_preauth_session_alloc(struct ksmbd_conn *conn,
@@ -353,13 +374,13 @@ void destroy_previous_session(struct ksmbd_conn *conn,
 	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_RECONNECT);
 	err = ksmbd_conn_wait_idle_sess_id(conn, id);
 	if (err) {
-		ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_NEGOTIATE);
+		ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_SETUP);
 		goto out;
 	}
 
 	ksmbd_destroy_file_table(&prev_sess->file_table);
 	prev_sess->state = SMB2_SESSION_EXPIRED;
-	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_NEGOTIATE);
+	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_SETUP);
 	ksmbd_launch_ksmbd_durable_scavenger();
 out:
 	up_write(&conn->session_lock);
@@ -417,7 +438,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
 	rwlock_init(&sess->tree_conns_lock);
-	atomic_set(&sess->refcnt, 1);
+	atomic_set(&sess->refcnt, 2);
 
 	ret = __init_smb2_session(sess);
 	if (ret)
diff --git a/fs/smb/server/mgmt/user_session.h b/fs/smb/server/mgmt/user_session.h
index c1c4b20bd5c6..f21348381d59 100644
--- a/fs/smb/server/mgmt/user_session.h
+++ b/fs/smb/server/mgmt/user_session.h
@@ -87,6 +87,8 @@ void ksmbd_session_destroy(struct ksmbd_session *sess);
 struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id);
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 					   unsigned long long id);
+bool is_ksmbd_session_in_connection(struct ksmbd_conn *conn,
+				     unsigned long long id);
 int ksmbd_session_register(struct ksmbd_conn *conn,
 			   struct ksmbd_session *sess);
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn);
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 592fe665973a..deacf78b4400 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -724,8 +724,8 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 	work->conn = conn;
 	work->sess = opinfo->sess;
 
+	ksmbd_conn_r_count_inc(conn);
 	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
-		ksmbd_conn_r_count_inc(conn);
 		INIT_WORK(&work->work, __smb2_oplock_break_noti);
 		ksmbd_queue_work(work);
 
@@ -833,8 +833,8 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 	work->conn = conn;
 	work->sess = opinfo->sess;
 
+	ksmbd_conn_r_count_inc(conn);
 	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
-		ksmbd_conn_r_count_inc(conn);
 		INIT_WORK(&work->work, __smb2_lease_break_noti);
 		ksmbd_queue_work(work);
 		wait_for_break_ack(opinfo);
@@ -1505,6 +1505,10 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 	if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
 		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
+		if (le16_to_cpu(cc->DataOffset) + le32_to_cpu(cc->DataLength) <
+		    sizeof(struct create_lease_v2) - 4)
+			return NULL;
+
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
 		lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
@@ -1517,6 +1521,10 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 	} else {
 		struct create_lease *lc = (struct create_lease *)cc;
 
+		if (le16_to_cpu(cc->DataOffset) + le32_to_cpu(cc->DataLength) <
+		    sizeof(struct create_lease))
+			return NULL;
+
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
 		lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8464261d7638..7fea86edc717 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1247,7 +1247,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	}
 
 	conn->srv_sec_mode = le16_to_cpu(rsp->SecurityMode);
-	ksmbd_conn_set_need_negotiate(conn);
+	ksmbd_conn_set_need_setup(conn);
 
 err_out:
 	if (rc)
@@ -1268,6 +1268,9 @@ static int alloc_preauth_hash(struct ksmbd_session *sess,
 	if (sess->Preauth_HashValue)
 		return 0;
 
+	if (!conn->preauth_info)
+		return -ENOMEM;
+
 	sess->Preauth_HashValue = kmemdup(conn->preauth_info->Preauth_HashValue,
 					  PREAUTH_HASHVALUE_SIZE, GFP_KERNEL);
 	if (!sess->Preauth_HashValue)
@@ -1671,6 +1674,11 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "Received request for session setup\n");
 
+	if (!ksmbd_conn_need_setup(conn) && !ksmbd_conn_good(conn)) {
+		work->send_no_response = 1;
+		return rc;
+	}
+
 	WORK_BUFFERS(work, req, rsp);
 
 	rsp->StructureSize = cpu_to_le16(9);
@@ -1704,44 +1712,38 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 		if (conn->dialect != sess->dialect) {
 			rc = -EINVAL;
-			ksmbd_user_session_put(sess);
 			goto out_err;
 		}
 
 		if (!(req->hdr.Flags & SMB2_FLAGS_SIGNED)) {
 			rc = -EINVAL;
-			ksmbd_user_session_put(sess);
 			goto out_err;
 		}
 
 		if (strncmp(conn->ClientGUID, sess->ClientGUID,
 			    SMB2_CLIENT_GUID_SIZE)) {
 			rc = -ENOENT;
-			ksmbd_user_session_put(sess);
 			goto out_err;
 		}
 
 		if (sess->state == SMB2_SESSION_IN_PROGRESS) {
 			rc = -EACCES;
-			ksmbd_user_session_put(sess);
 			goto out_err;
 		}
 
 		if (sess->state == SMB2_SESSION_EXPIRED) {
 			rc = -EFAULT;
-			ksmbd_user_session_put(sess);
 			goto out_err;
 		}
-		ksmbd_user_session_put(sess);
 
 		if (ksmbd_conn_need_reconnect(conn)) {
 			rc = -EFAULT;
+			ksmbd_user_session_put(sess);
 			sess = NULL;
 			goto out_err;
 		}
 
-		sess = ksmbd_session_lookup(conn, sess_id);
-		if (!sess) {
+		if (is_ksmbd_session_in_connection(conn, sess_id)) {
 			rc = -EACCES;
 			goto out_err;
 		}
@@ -1907,10 +1909,12 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 			sess->last_active = jiffies;
 			sess->state = SMB2_SESSION_EXPIRED;
+			ksmbd_user_session_put(sess);
+			work->sess = NULL;
 			if (try_delay) {
 				ksmbd_conn_set_need_reconnect(conn);
 				ssleep(5);
-				ksmbd_conn_set_need_negotiate(conn);
+				ksmbd_conn_set_need_setup(conn);
 			}
 		}
 		smb2_set_err_rsp(work);
@@ -2234,14 +2238,15 @@ int smb2_session_logoff(struct ksmbd_work *work)
 		return -ENOENT;
 	}
 
-	ksmbd_destroy_file_table(&sess->file_table);
 	down_write(&conn->session_lock);
 	sess->state = SMB2_SESSION_EXPIRED;
 	up_write(&conn->session_lock);
 
-	ksmbd_free_user(sess->user);
-	sess->user = NULL;
-	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
+	if (sess->user) {
+		ksmbd_free_user(sess->user);
+		sess->user = NULL;
+	}
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_SETUP);
 
 	rsp->StructureSize = cpu_to_le16(4);
 	err = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_logoff_rsp));
@@ -2703,6 +2708,13 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 				goto out;
 			}
 
+			if (le16_to_cpu(context->DataOffset) +
+				le32_to_cpu(context->DataLength) <
+			    sizeof(struct create_durable_reconn_v2_req)) {
+				err = -EINVAL;
+				goto out;
+			}
+
 			recon_v2 = (struct create_durable_reconn_v2_req *)context;
 			persistent_id = recon_v2->Fid.PersistentFileId;
 			dh_info->fp = ksmbd_lookup_durable_fd(persistent_id);
@@ -2736,6 +2748,13 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 				goto out;
 			}
 
+			if (le16_to_cpu(context->DataOffset) +
+				le32_to_cpu(context->DataLength) <
+			    sizeof(struct create_durable_reconn_req)) {
+				err = -EINVAL;
+				goto out;
+			}
+
 			recon = (struct create_durable_reconn_req *)context;
 			persistent_id = recon->Data.Fid.PersistentFileId;
 			dh_info->fp = ksmbd_lookup_durable_fd(persistent_id);
@@ -2761,6 +2780,13 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 				goto out;
 			}
 
+			if (le16_to_cpu(context->DataOffset) +
+				le32_to_cpu(context->DataLength) <
+			    sizeof(struct create_durable_req_v2)) {
+				err = -EINVAL;
+				goto out;
+			}
+
 			durable_v2_blob =
 				(struct create_durable_req_v2 *)context;
 			ksmbd_debug(SMB, "Request for durable v2 open\n");
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 109036e2227c..376ae68144af 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -270,6 +270,11 @@ static int sid_to_id(struct mnt_idmap *idmap,
 		return -EIO;
 	}
 
+	if (psid->num_subauth == 0) {
+		pr_err("%s: zero subauthorities!\n", __func__);
+		return -EIO;
+	}
+
 	if (sidtype == SIDOWNER) {
 		kuid_t uid;
 		uid_t id;
@@ -333,7 +338,7 @@ void posix_state_to_acl(struct posix_acl_state *state,
 	pace->e_perm = state->other.allow;
 }
 
-int init_acl_state(struct posix_acl_state *state, int cnt)
+int init_acl_state(struct posix_acl_state *state, u16 cnt)
 {
 	int alloc;
 
@@ -368,7 +373,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		       struct smb_fattr *fattr)
 {
 	int i, ret;
-	int num_aces = 0;
+	u16 num_aces = 0;
 	unsigned int acl_size;
 	char *acl_base;
 	struct smb_ace **ppace;
@@ -389,12 +394,12 @@ static void parse_dacl(struct mnt_idmap *idmap,
 
 	ksmbd_debug(SMB, "DACL revision %d size %d num aces %d\n",
 		    le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
-		    le32_to_cpu(pdacl->num_aces));
+		    le16_to_cpu(pdacl->num_aces));
 
 	acl_base = (char *)pdacl;
 	acl_size = sizeof(struct smb_acl);
 
-	num_aces = le32_to_cpu(pdacl->num_aces);
+	num_aces = le16_to_cpu(pdacl->num_aces);
 	if (num_aces <= 0)
 		return;
 
@@ -583,7 +588,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 
 static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 				       struct smb_ace *pndace,
-				       struct smb_fattr *fattr, u32 *num_aces,
+				       struct smb_fattr *fattr, u16 *num_aces,
 				       u16 *size, u32 nt_aces_num)
 {
 	struct posix_acl_entry *pace;
@@ -704,7 +709,7 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 			   struct smb_fattr *fattr)
 {
 	struct smb_ace *ntace, *pndace;
-	int nt_num_aces = le32_to_cpu(nt_dacl->num_aces), num_aces = 0;
+	u16 nt_num_aces = le16_to_cpu(nt_dacl->num_aces), num_aces = 0;
 	unsigned short size = 0;
 	int i;
 
@@ -731,7 +736,7 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 
 	set_posix_acl_entries_dacl(idmap, pndace, fattr,
 				   &num_aces, &size, nt_num_aces);
-	pndacl->num_aces = cpu_to_le32(num_aces);
+	pndacl->num_aces = cpu_to_le16(num_aces);
 	pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);
 }
 
@@ -739,7 +744,7 @@ static void set_mode_dacl(struct mnt_idmap *idmap,
 			  struct smb_acl *pndacl, struct smb_fattr *fattr)
 {
 	struct smb_ace *pace, *pndace;
-	u32 num_aces = 0;
+	u16 num_aces = 0;
 	u16 size = 0, ace_size = 0;
 	uid_t uid;
 	const struct smb_sid *sid;
@@ -795,7 +800,7 @@ static void set_mode_dacl(struct mnt_idmap *idmap,
 				 fattr->cf_mode, 0007);
 
 out:
-	pndacl->num_aces = cpu_to_le32(num_aces);
+	pndacl->num_aces = cpu_to_le16(num_aces);
 	pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);
 }
 
@@ -1025,8 +1030,11 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	struct smb_sid owner_sid, group_sid;
 	struct dentry *parent = path->dentry->d_parent;
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
-	int inherited_flags = 0, flags = 0, i, ace_cnt = 0, nt_size = 0, pdacl_size;
-	int rc = 0, num_aces, dacloffset, pntsd_type, pntsd_size, acl_len, aces_size;
+	int inherited_flags = 0, flags = 0, i, nt_size = 0, pdacl_size;
+	int rc = 0, pntsd_type, pntsd_size, acl_len, aces_size;
+	unsigned int dacloffset;
+	size_t dacl_struct_end;
+	u16 num_aces, ace_cnt = 0;
 	char *aces_base;
 	bool is_dir = S_ISDIR(d_inode(path->dentry)->i_mode);
 
@@ -1034,15 +1042,18 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 					    parent, &parent_pntsd);
 	if (pntsd_size <= 0)
 		return -ENOENT;
+
 	dacloffset = le32_to_cpu(parent_pntsd->dacloffset);
-	if (!dacloffset || (dacloffset + sizeof(struct smb_acl) > pntsd_size)) {
+	if (!dacloffset ||
+	    check_add_overflow(dacloffset, sizeof(struct smb_acl), &dacl_struct_end) ||
+	    dacl_struct_end > (size_t)pntsd_size) {
 		rc = -EINVAL;
 		goto free_parent_pntsd;
 	}
 
 	parent_pdacl = (struct smb_acl *)((char *)parent_pntsd + dacloffset);
 	acl_len = pntsd_size - dacloffset;
-	num_aces = le32_to_cpu(parent_pdacl->num_aces);
+	num_aces = le16_to_cpu(parent_pdacl->num_aces);
 	pntsd_type = le16_to_cpu(parent_pntsd->type);
 	pdacl_size = le16_to_cpu(parent_pdacl->size);
 
@@ -1201,7 +1212,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pdacl = (struct smb_acl *)((char *)pntsd + le32_to_cpu(pntsd->dacloffset));
 			pdacl->revision = cpu_to_le16(2);
 			pdacl->size = cpu_to_le16(sizeof(struct smb_acl) + nt_size);
-			pdacl->num_aces = cpu_to_le32(ace_cnt);
+			pdacl->num_aces = cpu_to_le16(ace_cnt);
 			pace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 			memcpy(pace, aces_base, nt_size);
 			pntsd_size += sizeof(struct smb_acl) + nt_size;
@@ -1238,7 +1249,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	struct smb_ntsd *pntsd = NULL;
 	struct smb_acl *pdacl;
 	struct posix_acl *posix_acls;
-	int rc = 0, pntsd_size, acl_size, aces_size, pdacl_size, dacl_offset;
+	int rc = 0, pntsd_size, acl_size, aces_size, pdacl_size;
+	unsigned int dacl_offset;
+	size_t dacl_struct_end;
 	struct smb_sid sid;
 	int granted = le32_to_cpu(*pdaccess & ~FILE_MAXIMAL_ACCESS_LE);
 	struct smb_ace *ace;
@@ -1257,7 +1270,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 	dacl_offset = le32_to_cpu(pntsd->dacloffset);
 	if (!dacl_offset ||
-	    (dacl_offset + sizeof(struct smb_acl) > pntsd_size))
+	    check_add_overflow(dacl_offset, sizeof(struct smb_acl), &dacl_struct_end) ||
+	    dacl_struct_end > (size_t)pntsd_size)
 		goto err_out;
 
 	pdacl = (struct smb_acl *)((char *)pntsd + le32_to_cpu(pntsd->dacloffset));
@@ -1282,7 +1296,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = acl_size - sizeof(struct smb_acl);
-		for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
+		for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
 			if (offsetof(struct smb_ace, access_req) > aces_size)
 				break;
 			ace_size = le16_to_cpu(ace->size);
@@ -1303,7 +1317,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = acl_size - sizeof(struct smb_acl);
-	for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
+	for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
 		if (offsetof(struct smb_ace, access_req) > aces_size)
 			break;
 		ace_size = le16_to_cpu(ace->size);
diff --git a/fs/smb/server/smbacl.h b/fs/smb/server/smbacl.h
index 24ce576fc292..355adaee39b8 100644
--- a/fs/smb/server/smbacl.h
+++ b/fs/smb/server/smbacl.h
@@ -86,7 +86,7 @@ int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 int build_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 		   struct smb_ntsd *ppntsd, int ppntsd_size, int addition_info,
 		   __u32 *secdesclen, struct smb_fattr *fattr);
-int init_acl_state(struct posix_acl_state *state, int cnt);
+int init_acl_state(struct posix_acl_state *state, u16 cnt);
 void free_acl_state(struct posix_acl_state *state);
 void posix_state_to_acl(struct posix_acl_state *state,
 			struct posix_acl_entry *pace);
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index a80ba457a858..6398a6b50bd1 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -222,6 +222,13 @@ struct drm_dp_mst_branch {
 	 */
 	struct list_head destroy_next;
 
+	/**
+	 * @rad: Relative Address of the MST branch.
+	 * For &drm_dp_mst_topology_mgr.mst_primary, it's rad[8] are all 0,
+	 * unset and unused. For MST branches connected after mst_primary,
+	 * in each element of rad[] the nibbles are ordered by the most
+	 * signifcant 4 bits first and the least significant 4 bits second.
+	 */
 	u8 rad[8];
 	u8 lct;
 	int num_ports;
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index a32eebcd23da..38b2af336e4a 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -324,6 +324,7 @@ struct cgroup_base_stat {
 #ifdef CONFIG_SCHED_CORE
 	u64 forceidle_sum;
 #endif
+	u64 ntime;
 };
 
 /*
diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
index c50b5670c4a5..197916ee91a4 100644
--- a/include/linux/context_tracking_irq.h
+++ b/include/linux/context_tracking_irq.h
@@ -10,12 +10,12 @@ void ct_irq_exit_irqson(void);
 void ct_nmi_enter(void);
 void ct_nmi_exit(void);
 #else
-static inline void ct_irq_enter(void) { }
-static inline void ct_irq_exit(void) { }
+static __always_inline void ct_irq_enter(void) { }
+static __always_inline void ct_irq_exit(void) { }
 static inline void ct_irq_enter_irqson(void) { }
 static inline void ct_irq_exit_irqson(void) { }
-static inline void ct_nmi_enter(void) { }
-static inline void ct_nmi_exit(void) { }
+static __always_inline void ct_nmi_enter(void) { }
+static __always_inline void ct_nmi_exit(void) { }
 #endif
 
 #endif
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index c13342594278..f106b1025111 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -639,6 +639,10 @@ extern int coresight_enable_sysfs(struct coresight_device *csdev);
 extern void coresight_disable_sysfs(struct coresight_device *csdev);
 extern int coresight_timeout(struct csdev_access *csa, u32 offset,
 			     int position, int value);
+typedef void (*coresight_timeout_cb_t) (struct csdev_access *, u32, int, int);
+extern int coresight_timeout_action(struct csdev_access *csa, u32 offset,
+					int position, int value,
+					coresight_timeout_cb_t cb);
 
 extern int coresight_claim_device(struct coresight_device *csdev);
 extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 0d79070c5a70..487d4bd9b0c9 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -91,7 +91,7 @@ struct fwnode_endpoint {
 #define SWNODE_GRAPH_PORT_NAME_FMT		"port@%u"
 #define SWNODE_GRAPH_ENDPOINT_NAME_FMT		"endpoint@%u"
 
-#define NR_FWNODE_REFERENCE_ARGS	8
+#define NR_FWNODE_REFERENCE_ARGS	16
 
 /**
  * struct fwnode_reference_args - Fwnode reference with additional arguments
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 457151f9f263..b378fbf885ce 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -448,7 +448,7 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 static inline void disable_irq_nosync_lockdep(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_disable();
 #endif
 }
@@ -456,7 +456,7 @@ static inline void disable_irq_nosync_lockdep(unsigned int irq)
 static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned long *flags)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_save(*flags);
 #endif
 }
@@ -471,7 +471,7 @@ static inline void disable_irq_lockdep(unsigned int irq)
 
 static inline void enable_irq_lockdep(unsigned int irq)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_enable();
 #endif
 	enable_irq(irq);
@@ -479,7 +479,7 @@ static inline void enable_irq_lockdep(unsigned int irq)
 
 static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigned long *flags)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_restore(*flags);
 #endif
 	enable_irq(irq);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index b804346a9741..81ab18658d72 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -251,6 +251,10 @@ struct nfs_server {
 	struct list_head	ss_copies;
 	struct list_head	ss_src_copies;
 
+	unsigned long		delegation_flags;
+#define NFS4SERV_DELEGRETURN		(1)
+#define NFS4SERV_DELEGATION_EXPIRED	(2)
+#define NFS4SERV_DELEGRETURN_DELAYED	(3)
 	unsigned long		delegation_gen;
 	unsigned long		mig_gen;
 	unsigned long		mig_status;
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index a8dfb38c9bb6..e78fa535f61d 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -17,7 +17,6 @@
 void lockup_detector_init(void);
 void lockup_detector_retry_init(void);
 void lockup_detector_soft_poweroff(void);
-void lockup_detector_cleanup(void);
 
 extern int watchdog_user_enabled;
 extern int watchdog_thresh;
@@ -37,7 +36,6 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_retry_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
-static inline void lockup_detector_cleanup(void) { }
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
@@ -104,12 +102,10 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
-extern void hardlockup_detector_perf_cleanup(void);
 extern void hardlockup_config_perf_event(const char *str);
 #else
 static inline void hardlockup_detector_perf_stop(void) { }
 static inline void hardlockup_detector_perf_restart(void) { }
-static inline void hardlockup_detector_perf_cleanup(void) { }
 static inline void hardlockup_config_perf_event(const char *str) { }
 #endif
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8b2ac6bd2ae..8df030ebd862 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1518,14 +1518,25 @@ static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 }
 
 /*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
+ * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
+ * tables copied during copy_page_range(). On success, stores the pfn to be
+ * passed to untrack_pfn_copy().
  */
-static inline int track_pfn_copy(struct vm_area_struct *vma)
+static inline int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn)
 {
 	return 0;
 }
 
+/*
+ * untrack_pfn_copy is called when a VM_PFNMAP VMA failed to copy during
+ * copy_page_range(), but after track_pfn_copy() was already called.
+ */
+static inline void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		unsigned long pfn)
+{
+}
+
 /*
  * untrack_pfn is called while unmapping a pfnmap for a region.
  * untrack can be called for a specific region indicated by pfn and size or
@@ -1538,8 +1549,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
 }
 
 /*
- * untrack_pfn_clear is called while mremapping a pfnmap for a new region
- * or fails to copy pgtable during duplicate vm area.
+ * untrack_pfn_clear is called in the following cases on a VM_PFNMAP VMA:
+ *
+ * 1) During mremap() on the src VMA after the page tables were moved.
+ * 2) During fork() on the dst VMA, immediately after duplicating the src VMA.
  */
 static inline void untrack_pfn_clear(struct vm_area_struct *vma)
 {
@@ -1550,7 +1563,10 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long size);
 extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 			     pfn_t pfn);
-extern int track_pfn_copy(struct vm_area_struct *vma);
+extern int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, unsigned long *pfn);
+extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		unsigned long pfn);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size, bool mm_wr_locked);
 extern void untrack_pfn_clear(struct vm_area_struct *vma);
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index d39dc863f612..d0b29cd1fd20 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -66,6 +66,7 @@ static inline bool queue_pm_work(struct work_struct *work)
 
 extern int pm_generic_runtime_suspend(struct device *dev);
 extern int pm_generic_runtime_resume(struct device *dev);
+extern bool pm_runtime_need_not_resume(struct device *dev);
 extern int pm_runtime_force_suspend(struct device *dev);
 extern int pm_runtime_force_resume(struct device *dev);
 
@@ -241,6 +242,7 @@ static inline bool queue_pm_work(struct work_struct *work) { return false; }
 
 static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
 static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
+static inline bool pm_runtime_need_not_resume(struct device *dev) {return true; }
 static inline int pm_runtime_force_suspend(struct device *dev) { return 0; }
 static inline int pm_runtime_force_resume(struct device *dev) { return 0; }
 
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48e5c03df1dd..bd69ddc102fb 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -138,7 +138,7 @@ static inline void rcu_sysrq_end(void) { }
 #if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK))
 void rcu_irq_work_resched(void);
 #else
-static inline void rcu_irq_work_resched(void) { }
+static __always_inline void rcu_irq_work_resched(void) { }
 #endif
 
 #ifdef CONFIG_RCU_NOCB_CPU
diff --git a/include/linux/sched/smt.h b/include/linux/sched/smt.h
index fb1e295e7e63..166b19af956f 100644
--- a/include/linux/sched/smt.h
+++ b/include/linux/sched/smt.h
@@ -12,7 +12,7 @@ static __always_inline bool sched_smt_active(void)
 	return static_branch_likely(&sched_smt_present);
 }
 #else
-static inline bool sched_smt_active(void) { return false; }
+static __always_inline bool sched_smt_active(void) { return false; }
 #endif
 
 void arch_smt_update(void);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 25ea8fe2313e..0da2c257e32c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -83,8 +83,6 @@ struct thermal_trip {
 #define THERMAL_TRIP_PRIV_TO_INT(_val_)	(uintptr_t)(_val_)
 #define THERMAL_INT_TO_TRIP_PRIV(_val_)	(void *)(uintptr_t)(_val_)
 
-struct thermal_zone_device;
-
 struct cooling_spec {
 	unsigned long upper;	/* Highest cooling state  */
 	unsigned long lower;	/* Lowest cooling state  */
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 77769ff50544..fcf5a64d5cfe 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -689,6 +689,20 @@ struct trace_event_file {
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
 
+#ifdef CONFIG_HIST_TRIGGERS
+extern struct irq_work hist_poll_work;
+extern wait_queue_head_t hist_poll_wq;
+
+static inline void hist_poll_wakeup(void)
+{
+	if (wq_has_sleeper(&hist_poll_wq))
+		irq_work_queue(&hist_poll_work);
+}
+
+#define hist_poll_wait(file, wait)	\
+	poll_wait(file, &hist_poll_wq, wait)
+#endif
+
 #define __TRACE_EVENT_FLAGS(name, value)				\
 	static int __init trace_init_flags_##name(void)			\
 	{								\
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 2b294bf1881f..d0cb0e02cd6a 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -28,6 +28,8 @@ struct page;
 
 #define MAX_URETPROBE_DEPTH		64
 
+#define UPROBE_NO_TRAMPOLINE_VADDR	(~0UL)
+
 struct uprobe_consumer {
 	/*
 	 * handler() can return UPROBE_HANDLER_REMOVE to signal the need to
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 67551133b522..c2b5de75daf2 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2737,6 +2737,7 @@ struct ib_device {
 	 * It is a NULL terminated array.
 	 */
 	const struct attribute_group	*groups[4];
+	u8				hw_stats_attr_index;
 
 	u64			     uverbs_cmd_mask;
 
diff --git a/init/Kconfig b/init/Kconfig
index 293c565c6216..243d0087f944 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -129,6 +129,11 @@ config CC_HAS_COUNTED_BY
 	# https://github.com/llvm/llvm-project/pull/112636
 	depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
 
+config LD_CAN_USE_KEEP_IN_OVERLAY
+	# ld.lld prior to 21.0.0 did not support KEEP within an overlay description
+	# https://github.com/llvm/llvm-project/pull/130661
+	def_bool LD_IS_BFD || LLD_VERSION >= 210000
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2b9c8c168a0b..a60a6a2ce0d7 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2290,17 +2290,18 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 	insn->code = BPF_JMP | BPF_CALL_ARGS;
 }
 #endif
-#else
+#endif
+
 static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 					 const struct bpf_insn *insn)
 {
 	/* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
-	 * is not working properly, so warn about it!
+	 * is not working properly, or interpreter is being used when
+	 * prog->jit_requested is not 0, so warn about it!
 	 */
 	WARN_ON_ONCE(1);
 	return 0;
 }
-#endif
 
 bool bpf_prog_map_compatible(struct bpf_map *map,
 			     const struct bpf_prog *fp)
@@ -2380,8 +2381,18 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
+	u32 idx = (round_up(stack_depth, 32) / 32) - 1;
 
-	fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) - 1];
+	/* may_goto may cause stack size > 512, leading to idx out-of-bounds.
+	 * But for non-JITed programs, we don't need bpf_func, so no bounds
+	 * check needed.
+	 */
+	if (!fp->jit_requested &&
+	    !WARN_ON_ONCE(idx >= ARRAY_SIZE(interpreters))) {
+		fp->bpf_func = interpreters[idx];
+	} else {
+		fp->bpf_func = __bpf_prog_ret0_warn;
+	}
 #else
 	fp->bpf_func = __bpf_prog_ret0_warn;
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0cab0d0252f..9000806ee3ba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21276,6 +21276,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
 			subprogs[cur_subprog].stack_extra = stack_depth_extra;
+
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			if (stack_depth > MAX_BPF_STACK && !prog->jit_requested) {
+				verbose(env, "stack size %d(extra %d) is too large\n",
+					stack_depth, stack_depth_extra);
+				return -EINVAL;
+			}
 			cur_subprog++;
 			stack_depth = subprogs[cur_subprog].stack_depth;
 			stack_depth_extra = 0;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index ce295b73c0a3..3e01781aeb7b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -444,6 +444,7 @@ static void cgroup_base_stat_add(struct cgroup_base_stat *dst_bstat,
 #ifdef CONFIG_SCHED_CORE
 	dst_bstat->forceidle_sum += src_bstat->forceidle_sum;
 #endif
+	dst_bstat->ntime += src_bstat->ntime;
 }
 
 static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
@@ -455,6 +456,7 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 #ifdef CONFIG_SCHED_CORE
 	dst_bstat->forceidle_sum -= src_bstat->forceidle_sum;
 #endif
+	dst_bstat->ntime -= src_bstat->ntime;
 }
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
@@ -534,8 +536,10 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
 	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
 
 	switch (index) {
-	case CPUTIME_USER:
 	case CPUTIME_NICE:
+		rstatc->bstat.ntime += delta_exec;
+		fallthrough;
+	case CPUTIME_USER:
 		rstatc->bstat.cputime.utime += delta_exec;
 		break;
 	case CPUTIME_SYSTEM:
@@ -590,6 +594,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 #ifdef CONFIG_SCHED_CORE
 		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
 #endif
+		bstat->ntime += cpustat[CPUTIME_NICE];
 	}
 }
 
@@ -607,32 +612,33 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
 void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	u64 usage, utime, stime;
+	struct cgroup_base_stat bstat;
 
 	if (cgroup_parent(cgrp)) {
 		cgroup_rstat_flush_hold(cgrp);
-		usage = cgrp->bstat.cputime.sum_exec_runtime;
+		bstat = cgrp->bstat;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
-			       &utime, &stime);
+			       &bstat.cputime.utime, &bstat.cputime.stime);
 		cgroup_rstat_flush_release(cgrp);
 	} else {
-		/* cgrp->bstat of root is not actually used, reuse it */
-		root_cgroup_cputime(&cgrp->bstat);
-		usage = cgrp->bstat.cputime.sum_exec_runtime;
-		utime = cgrp->bstat.cputime.utime;
-		stime = cgrp->bstat.cputime.stime;
+		root_cgroup_cputime(&bstat);
 	}
 
-	do_div(usage, NSEC_PER_USEC);
-	do_div(utime, NSEC_PER_USEC);
-	do_div(stime, NSEC_PER_USEC);
+	do_div(bstat.cputime.sum_exec_runtime, NSEC_PER_USEC);
+	do_div(bstat.cputime.utime, NSEC_PER_USEC);
+	do_div(bstat.cputime.stime, NSEC_PER_USEC);
+	do_div(bstat.ntime, NSEC_PER_USEC);
 
 	seq_printf(seq, "usage_usec %llu\n"
-		   "user_usec %llu\n"
-		   "system_usec %llu\n",
-		   usage, utime, stime);
-
-	cgroup_force_idle_show(seq, &cgrp->bstat);
+			"user_usec %llu\n"
+			"system_usec %llu\n"
+			"nice_usec %llu\n",
+			bstat.cputime.sum_exec_runtime,
+			bstat.cputime.utime,
+			bstat.cputime.stime,
+			bstat.ntime);
+
+	cgroup_force_idle_show(seq, &bstat);
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9ee6c9145b1d..cf02a629f990 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1452,11 +1452,6 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 
 out:
 	cpus_write_unlock();
-	/*
-	 * Do post unplug cleanup. This is still protected against
-	 * concurrent CPU hotplug via cpu_add_remove_lock.
-	 */
-	lockup_detector_cleanup();
 	arch_smt_update();
 	return ret;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5fff74c73606..b5ccf52bb71b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2407,6 +2407,7 @@ ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
 #define DETACH_DEAD	0x04UL
+#define DETACH_EXIT	0x08UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2421,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   void *info)
 {
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 	unsigned long flags = (unsigned long)info;
 
 	ctx_time_update(cpuctx, ctx);
@@ -2429,16 +2431,19 @@ __perf_remove_from_context(struct perf_event *event,
 	 * Ensure event_sched_out() switches to OFF, at the very least
 	 * this avoids raising perf_pending_task() at this time.
 	 */
-	if (flags & DETACH_DEAD)
+	if (flags & DETACH_EXIT)
+		state = PERF_EVENT_STATE_EXIT;
+	if (flags & DETACH_DEAD) {
 		event->pending_disable = 1;
+		state = PERF_EVENT_STATE_DEAD;
+	}
 	event_sched_out(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
-	if (flags & DETACH_DEAD)
-		event->state = PERF_EVENT_STATE_DEAD;
 
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
@@ -11737,6 +11742,21 @@ static int pmu_dev_alloc(struct pmu *pmu)
 static struct lock_class_key cpuctx_mutex;
 static struct lock_class_key cpuctx_lock;
 
+static bool idr_cmpxchg(struct idr *idr, unsigned long id, void *old, void *new)
+{
+	void *tmp, *val = idr_find(idr, id);
+
+	if (val != old)
+		return false;
+
+	tmp = idr_replace(idr, new, id);
+	if (IS_ERR(tmp))
+		return false;
+
+	WARN_ON_ONCE(tmp != val);
+	return true;
+}
+
 int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 {
 	int cpu, ret, max = PERF_TYPE_MAX;
@@ -11763,7 +11783,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (type >= 0)
 		max = type;
 
-	ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
+	ret = idr_alloc(&pmu_idr, NULL, max, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto free_pdc;
 
@@ -11771,6 +11791,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 
 	type = ret;
 	pmu->type = type;
+	atomic_set(&pmu->exclusive_cnt, 0);
 
 	if (pmu_bus_running && !pmu->dev) {
 		ret = pmu_dev_alloc(pmu);
@@ -11819,14 +11840,22 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
+	/*
+	 * Now that the PMU is complete, make it visible to perf_try_init_event().
+	 */
+	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu))
+		goto free_context;
 	list_add_rcu(&pmu->entry, &pmus);
-	atomic_set(&pmu->exclusive_cnt, 0);
+
 	ret = 0;
 unlock:
 	mutex_unlock(&pmus_lock);
 
 	return ret;
 
+free_context:
+	free_percpu(pmu->cpu_pmu_context);
+
 free_dev:
 	if (pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		device_del(pmu->dev);
@@ -13319,12 +13348,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		mutex_lock(&parent_event->child_mutex);
 	}
 
-	perf_remove_from_context(event, detach_flags);
-
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state > PERF_EVENT_STATE_EXIT)
-		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_remove_from_context(event, detach_flags | DETACH_EXIT);
 
 	/*
 	 * Child events can be freed.
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4f46f688d0d4..bbfa22c0a159 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -19,7 +19,7 @@
 
 static void perf_output_wakeup(struct perf_output_handle *handle)
 {
-	atomic_set(&handle->rb->poll, EPOLLIN);
+	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
 
 	handle->event->pending_wakeup = 1;
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4fdc08ca0f3c..e60f5e71e35d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -167,6 +167,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, 0);
 	int err;
 	struct mmu_notifier_range range;
+	pte_t pte;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
 				addr + PAGE_SIZE);
@@ -186,6 +187,16 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	if (!page_vma_mapped_walk(&pvmw))
 		goto unlock;
 	VM_BUG_ON_PAGE(addr != pvmw.address, old_page);
+	pte = ptep_get(pvmw.pte);
+
+	/*
+	 * Handle PFN swap PTES, such as device-exclusive ones, that actually
+	 * map pages: simply trigger GUP again to fix it up.
+	 */
+	if (unlikely(!pte_present(pte))) {
+		page_vma_mapped_walk_done(&pvmw);
+		goto unlock;
+	}
 
 	if (new_page) {
 		folio_get(new_folio);
@@ -200,7 +211,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		inc_mm_counter(mm, MM_ANONPAGES);
 	}
 
-	flush_cache_page(vma, addr, pte_pfn(ptep_get(pvmw.pte)));
+	flush_cache_page(vma, addr, pte_pfn(pte));
 	ptep_clear_flush(vma, addr, pvmw.pte);
 	if (new_page)
 		set_pte_at(mm, addr, pvmw.pte,
@@ -1887,8 +1898,8 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
  */
 unsigned long uprobe_get_trampoline_vaddr(void)
 {
+	unsigned long trampoline_vaddr = UPROBE_NO_TRAMPOLINE_VADDR;
 	struct xol_area *area;
-	unsigned long trampoline_vaddr = -1;
 
 	/* Pairs with xol_add_vma() smp_store_release() */
 	area = READ_ONCE(current->mm->uprobes_state.xol_area); /* ^^^ */
diff --git a/kernel/fork.c b/kernel/fork.c
index e192bdbc9ade..12decadff468 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -505,6 +505,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
 
+	/* track_pfn_copy() will later take care of copying internal state. */
+	if (unlikely(new->vm_flags & VM_PFNMAP))
+		untrack_pfn_clear(new);
+
 	return new;
 }
 
diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index d3689632e8b9..3a5c25b2adc9 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -390,7 +390,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 			 struct kexec_buf *kbuf,
 			 unsigned long *lowest_load_addr)
 {
-	unsigned long lowest_addr = UINT_MAX;
+	unsigned long lowest_addr = ULONG_MAX;
 	int ret;
 	size_t i;
 
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 34bfae72f295..de9117c0e671 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/wake_q.h>
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
@@ -38,7 +39,7 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
+static noinline void __up(struct semaphore *sem, struct wake_q_head *wake_q);
 
 /**
  * down - acquire the semaphore
@@ -183,13 +184,16 @@ EXPORT_SYMBOL(down_timeout);
 void __sched up(struct semaphore *sem)
 {
 	unsigned long flags;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(list_empty(&sem->wait_list)))
 		sem->count++;
 	else
-		__up(sem);
+		__up(sem, &wake_q);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(up);
 
@@ -269,11 +273,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 
-static noinline void __sched __up(struct semaphore *sem)
+static noinline void __sched __up(struct semaphore *sem,
+				  struct wake_q_head *wake_q)
 {
 	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
 						struct semaphore_waiter, list);
 	list_del(&waiter->list);
 	waiter->up = true;
-	wake_up_process(waiter->task);
+	wake_q_add(wake_q, waiter->task);
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a17c23b53049..5e7ae404c8d2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3179,7 +3179,7 @@ int sched_dl_global_validate(void)
 	 * value smaller than the currently allocated bandwidth in
 	 * any of the root_domains.
 	 */
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		rcu_read_lock_sched();
 
 		if (dl_bw_visited(cpu, gen))
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 58ba14ed8fbc..ceb023629d48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -885,6 +885,26 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 	return __node_2_se(left);
 }
 
+/*
+ * HACK, stash a copy of deadline at the point of pick in vlag,
+ * which isn't used until dequeue.
+ */
+static inline void set_protect_slice(struct sched_entity *se)
+{
+	se->vlag = se->deadline;
+}
+
+static inline bool protect_slice(struct sched_entity *se)
+{
+	return se->vlag == se->deadline;
+}
+
+static inline void cancel_protect_slice(struct sched_entity *se)
+{
+	if (protect_slice(se))
+		se->vlag = se->deadline + 1;
+}
+
 /*
  * Earliest Eligible Virtual Deadline First
  *
@@ -921,11 +941,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
-	/*
-	 * Once selected, run a task until it either becomes non-eligible or
-	 * until it gets a new slice. See the HACK in set_next_entity().
-	 */
-	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
+	if (sched_feat(RUN_TO_PARITY) && curr && protect_slice(curr))
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
@@ -5626,11 +5642,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
-		/*
-		 * HACK, stash a copy of deadline at the point of pick in vlag,
-		 * which isn't used until dequeue.
-		 */
-		se->vlag = se->deadline;
+
+		set_protect_slice(se);
 	}
 
 	update_stats_curr_start(cfs_rq, se);
@@ -7090,6 +7103,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 
 		se->slice = slice;
+		if (se != cfs_rq->curr)
+			min_vruntime_cb_propagate(&se->run_node, NULL);
 		slice = cfs_rq_min_slice(cfs_rq);
 
 		cfs_rq->h_nr_running++;
@@ -7219,6 +7234,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		update_cfs_group(se);
 
 		se->slice = slice;
+		if (se != cfs_rq->curr)
+			min_vruntime_cb_propagate(&se->run_node, NULL);
 		slice = cfs_rq_min_slice(cfs_rq);
 
 		cfs_rq->h_nr_running -= h_nr_running;
@@ -8882,8 +8899,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
 	 * in the inverse case).
 	 */
-	if (cse_is_idle && !pse_is_idle)
+	if (cse_is_idle && !pse_is_idle) {
+		/*
+		 * When non-idle entity preempt an idle entity,
+		 * don't give idle entity slice protection.
+		 */
+		cancel_protect_slice(se);
 		goto preempt;
+	}
+
 	if (cse_is_idle != pse_is_idle)
 		return;
 
@@ -8902,8 +8926,8 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * Note that even if @p does not turn out to be the most eligible
 	 * task at this moment, current's slice protection will be lost.
 	 */
-	if (do_preempt_short(cfs_rq, pse, se) && se->vlag == se->deadline)
-		se->vlag = se->deadline + 1;
+	if (do_preempt_short(cfs_rq, pse, se))
+		cancel_protect_slice(se);
 
 	/*
 	 * If @p has become the most eligible task, force preemption.
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 449efaaa387a..55f279ddfd63 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -833,7 +833,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 	if (unlikely(is_global_init(current)))
 		return -EPERM;
 
-	if (!preemptible()) {
+	if (preempt_count() != 0 || irqs_disabled()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ea8ad5480e28..3e252ba16d5c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7442,9 +7442,9 @@ static __init int rb_write_something(struct rb_test_data *data, bool nested)
 		/* Ignore dropped events before test starts. */
 		if (started) {
 			if (nested)
-				data->bytes_dropped += len;
-			else
 				data->bytes_dropped_nested += len;
+			else
+				data->bytes_dropped += len;
 		}
 		return len;
 	}
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ea9b44847ce6..29eba68e0785 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3111,6 +3111,20 @@ static bool event_in_systems(struct trace_event_call *call,
 	return !*p || isspace(*p) || *p == ',';
 }
 
+#ifdef CONFIG_HIST_TRIGGERS
+/*
+ * Wake up waiter on the hist_poll_wq from irq_work because the hist trigger
+ * may happen in any context.
+ */
+static void hist_poll_event_irq_work(struct irq_work *work)
+{
+	wake_up_all(&hist_poll_wq);
+}
+
+DEFINE_IRQ_WORK(hist_poll_work, hist_poll_event_irq_work);
+DECLARE_WAIT_QUEUE_HEAD(hist_poll_wq);
+#endif
+
 static struct trace_event_file *
 trace_create_new_event(struct trace_event_call *call,
 		       struct trace_array *tr)
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 31f5ad322fab..4ebafc655223 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5314,6 +5314,8 @@ static void event_hist_trigger(struct event_trigger_data *data,
 
 	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
 		hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals);
+
+	hist_poll_wakeup();
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -5593,49 +5595,137 @@ static void hist_trigger_show(struct seq_file *m,
 		   n_entries, (u64)atomic64_read(&hist_data->map->drops));
 }
 
+struct hist_file_data {
+	struct file *file;
+	u64 last_read;
+	u64 last_act;
+};
+
+static u64 get_hist_hit_count(struct trace_event_file *event_file)
+{
+	struct hist_trigger_data *hist_data;
+	struct event_trigger_data *data;
+	u64 ret = 0;
+
+	list_for_each_entry(data, &event_file->triggers, list) {
+		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			hist_data = data->private_data;
+			ret += atomic64_read(&hist_data->map->hits);
+		}
+	}
+	return ret;
+}
+
 static int hist_show(struct seq_file *m, void *v)
 {
+	struct hist_file_data *hist_file = m->private;
 	struct event_trigger_data *data;
 	struct trace_event_file *event_file;
-	int n = 0, ret = 0;
+	int n = 0;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
-	event_file = event_file_file(m->private);
-	if (unlikely(!event_file)) {
-		ret = -ENODEV;
-		goto out_unlock;
-	}
+	event_file = event_file_file(hist_file->file);
+	if (unlikely(!event_file))
+		return -ENODEV;
 
 	list_for_each_entry(data, &event_file->triggers, list) {
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
 			hist_trigger_show(m, data, n++);
 	}
+	hist_file->last_read = get_hist_hit_count(event_file);
+	/*
+	 * Update last_act too so that poll()/POLLPRI can wait for the next
+	 * event after any syscall on hist file.
+	 */
+	hist_file->last_act = hist_file->last_read;
 
- out_unlock:
-	mutex_unlock(&event_mutex);
+	return 0;
+}
+
+static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct trace_event_file *event_file;
+	struct seq_file *m = file->private_data;
+	struct hist_file_data *hist_file = m->private;
+	__poll_t ret = 0;
+	u64 cnt;
+
+	guard(mutex)(&event_mutex);
+
+	event_file = event_file_data(file);
+	if (!event_file)
+		return EPOLLERR;
+
+	hist_poll_wait(file, wait);
+
+	cnt = get_hist_hit_count(event_file);
+	if (hist_file->last_read != cnt)
+		ret |= EPOLLIN | EPOLLRDNORM;
+	if (hist_file->last_act != cnt) {
+		hist_file->last_act = cnt;
+		ret |= EPOLLPRI;
+	}
 
 	return ret;
 }
 
+static int event_hist_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct hist_file_data *hist_file = m->private;
+
+	kfree(hist_file);
+	return tracing_single_release_file_tr(inode, file);
+}
+
 static int event_hist_open(struct inode *inode, struct file *file)
 {
+	struct trace_event_file *event_file;
+	struct hist_file_data *hist_file;
 	int ret;
 
 	ret = tracing_open_file_tr(inode, file);
 	if (ret)
 		return ret;
 
+	guard(mutex)(&event_mutex);
+
+	event_file = event_file_data(file);
+	if (!event_file) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	hist_file = kzalloc(sizeof(*hist_file), GFP_KERNEL);
+	if (!hist_file) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	hist_file->file = file;
+	hist_file->last_act = get_hist_hit_count(event_file);
+
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
-	return single_open(file, hist_show, file);
+	ret = single_open(file, hist_show, hist_file);
+	if (ret) {
+		kfree(hist_file);
+		goto err;
+	}
+
+	return 0;
+err:
+	tracing_release_file_tr(inode, file);
+	return ret;
 }
 
 const struct file_operations event_hist_fops = {
 	.open = event_hist_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = tracing_single_release_file_tr,
+	.release = event_hist_release,
+	.poll = event_hist_poll,
 };
 
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
@@ -5876,25 +5966,19 @@ static int hist_debug_show(struct seq_file *m, void *v)
 {
 	struct event_trigger_data *data;
 	struct trace_event_file *event_file;
-	int n = 0, ret = 0;
+	int n = 0;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	event_file = event_file_file(m->private);
-	if (unlikely(!event_file)) {
-		ret = -ENODEV;
-		goto out_unlock;
-	}
+	if (unlikely(!event_file))
+		return -ENODEV;
 
 	list_for_each_entry(data, &event_file->triggers, list) {
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
 			hist_trigger_debug_show(m, data, n++);
 	}
-
- out_unlock:
-	mutex_unlock(&event_mutex);
-
-	return ret;
+	return 0;
 }
 
 static int event_hist_debug_open(struct inode *inode, struct file *file)
@@ -5907,7 +5991,10 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
-	return single_open(file, hist_debug_show, file);
+	ret = single_open(file, hist_debug_show, file);
+	if (ret)
+		tracing_release_file_tr(inode, file);
+	return ret;
 }
 
 const struct file_operations event_hist_debug_fops = {
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index c82b401a294d..24c9962c40db 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -312,7 +312,7 @@ static const char *synth_field_fmt(char *type)
 	else if (strcmp(type, "gfp_t") == 0)
 		fmt = "%x";
 	else if (synth_field_is_string(type))
-		fmt = "%.*s";
+		fmt = "%s";
 	else if (synth_field_is_stack(type))
 		fmt = "%s";
 
@@ -859,6 +859,38 @@ static struct trace_event_fields synth_event_fields_array[] = {
 	{}
 };
 
+static int synth_event_reg(struct trace_event_call *call,
+		    enum trace_reg type, void *data)
+{
+	struct synth_event *event = container_of(call, struct synth_event, call);
+
+	switch (type) {
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+#endif
+	case TRACE_REG_REGISTER:
+		if (!try_module_get(event->mod))
+			return -EBUSY;
+		break;
+	default:
+		break;
+	}
+
+	int ret = trace_event_reg(call, type, data);
+
+	switch (type) {
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_UNREGISTER:
+#endif
+	case TRACE_REG_UNREGISTER:
+		module_put(event->mod);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
 static int register_synth_event(struct synth_event *event)
 {
 	struct trace_event_call *call = &event->call;
@@ -888,7 +920,7 @@ static int register_synth_event(struct synth_event *event)
 		goto out;
 	}
 	call->flags = TRACE_EVENT_FL_TRACEPOINT;
-	call->class->reg = trace_event_reg;
+	call->class->reg = synth_event_reg;
 	call->class->probe = trace_event_raw_event_synth;
 	call->data = event;
 	call->tp = event->tp;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index ebb61ddca749..655246a9bec3 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1353,6 +1353,7 @@ void graph_trace_close(struct trace_iterator *iter)
 	if (data) {
 		free_percpu(data->cpu_data);
 		kfree(data);
+		iter->private = NULL;
 	}
 }
 
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index fce064e20570..10ea6d0a35e8 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -233,8 +233,6 @@ static void irqsoff_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-	else
-		iter->private = NULL;
 }
 
 static void irqsoff_trace_close(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 032fdeba37d3..a94790f5cda7 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2038,7 +2038,6 @@ static int start_kthread(unsigned int cpu)
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-		stop_per_cpu_kthreads();
 		return -ENOMEM;
 	}
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index ae2ace5e515a..039382576bc1 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -170,8 +170,6 @@ static void wakeup_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-	else
-		iter->private = NULL;
 }
 
 static void wakeup_trace_close(struct trace_iterator *iter)
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index d36242fd4936..e55f9810b91a 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -269,6 +269,15 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	if (ret < 0)
 		goto error;
 
+	/*
+	 * pipe_resize_ring() does not update nr_accounted for watch_queue
+	 * pipes, because the above vastly overprovisions. Set nr_accounted on
+	 * and max_usage this pipe to the number that was actually charged to
+	 * the user above via account_pipe_buffers.
+	 */
+	pipe->max_usage = nr_pages;
+	pipe->nr_accounted = nr_pages;
+
 	ret = -ENOMEM;
 	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 262691ba62b7..4dc72540c3b0 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -347,8 +347,6 @@ static int __init watchdog_thresh_setup(char *str)
 }
 __setup("watchdog_thresh=", watchdog_thresh_setup);
 
-static void __lockup_detector_cleanup(void);
-
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
 enum stats_per_group {
 	STATS_SYSTEM,
@@ -878,11 +876,6 @@ static void __lockup_detector_reconfigure(void)
 
 	watchdog_hardlockup_start();
 	cpus_read_unlock();
-	/*
-	 * Must be called outside the cpus locked section to prevent
-	 * recursive locking in the perf code.
-	 */
-	__lockup_detector_cleanup();
 }
 
 void lockup_detector_reconfigure(void)
@@ -932,24 +925,6 @@ static inline void lockup_detector_setup(void)
 }
 #endif /* !CONFIG_SOFTLOCKUP_DETECTOR */
 
-static void __lockup_detector_cleanup(void)
-{
-	lockdep_assert_held(&watchdog_mutex);
-	hardlockup_detector_perf_cleanup();
-}
-
-/**
- * lockup_detector_cleanup - Cleanup after cpu hotplug or sysctl changes
- *
- * Caller must not hold the cpu hotplug rwsem.
- */
-void lockup_detector_cleanup(void)
-{
-	mutex_lock(&watchdog_mutex);
-	__lockup_detector_cleanup();
-	mutex_unlock(&watchdog_mutex);
-}
-
 /**
  * lockup_detector_soft_poweroff - Interface to stop lockup detector(s)
  *
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 59c1d86a73a2..2fdb96eaf493 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -21,8 +21,6 @@
 #include <linux/perf_event.h>
 
 static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
-static DEFINE_PER_CPU(struct perf_event *, dead_event);
-static struct cpumask dead_events_mask;
 
 static atomic_t watchdog_cpus = ATOMIC_INIT(0);
 
@@ -181,36 +179,12 @@ void watchdog_hardlockup_disable(unsigned int cpu)
 
 	if (event) {
 		perf_event_disable(event);
+		perf_event_release_kernel(event);
 		this_cpu_write(watchdog_ev, NULL);
-		this_cpu_write(dead_event, event);
-		cpumask_set_cpu(smp_processor_id(), &dead_events_mask);
 		atomic_dec(&watchdog_cpus);
 	}
 }
 
-/**
- * hardlockup_detector_perf_cleanup - Cleanup disabled events and destroy them
- *
- * Called from lockup_detector_cleanup(). Serialized by the caller.
- */
-void hardlockup_detector_perf_cleanup(void)
-{
-	int cpu;
-
-	for_each_cpu(cpu, &dead_events_mask) {
-		struct perf_event *event = per_cpu(dead_event, cpu);
-
-		/*
-		 * Required because for_each_cpu() reports  unconditionally
-		 * CPU0 as set on UP kernels. Sigh.
-		 */
-		if (event)
-			perf_event_release_kernel(event);
-		per_cpu(dead_event, cpu) = NULL;
-	}
-	cpumask_clear(&dead_events_mask);
-}
-
 /**
  * hardlockup_detector_perf_stop - Globally stop watchdog events
  *
diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index c02baa4168e1..055356508d97 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -532,6 +532,8 @@ int sw842_compress(const u8 *in, unsigned int ilen,
 		}
 		if (repeat_count) {
 			ret = add_repeat_template(p, repeat_count);
+			if (ret)
+				return ret;
 			repeat_count = 0;
 			if (next == last) /* reached max repeat bits */
 				goto repeat;
diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
index c40818ec9c18..49d32e43d06e 100644
--- a/lib/stackinit_kunit.c
+++ b/lib/stackinit_kunit.c
@@ -146,6 +146,15 @@ static bool stackinit_range_contains(char *haystack_start, size_t haystack_size,
 #define INIT_STRUCT_assigned_copy(var_type)				\
 					; var = *(arg)
 
+/*
+ * The "did we actually fill the stack?" check value needs
+ * to be neither 0 nor any of the "pattern" bytes. The
+ * pattern bytes are compiler, architecture, and type based,
+ * so we have to pick a value that never appears for those
+ * combinations. Use 0x99 which is not 0xFF, 0xFE, nor 0xAA.
+ */
+#define FILL_BYTE	0x99
+
 /*
  * @name: unique string name for the test
  * @var_type: type to be tested for zeroing initialization
@@ -168,12 +177,12 @@ static noinline void test_ ## name (struct kunit *test)		\
 	ZERO_CLONE_ ## which(zero);				\
 	/* Clear entire check buffer for 0xFF overlap test. */	\
 	memset(check_buf, 0x00, sizeof(check_buf));		\
-	/* Fill stack with 0xFF. */				\
+	/* Fill stack with FILL_BYTE. */			\
 	ignored = leaf_ ##name((unsigned long)&ignored, 1,	\
 				FETCH_ARG_ ## which(zero));	\
-	/* Verify all bytes overwritten with 0xFF. */		\
+	/* Verify all bytes overwritten with FILL_BYTE. */	\
 	for (sum = 0, i = 0; i < target_size; i++)		\
-		sum += (check_buf[i] != 0xFF);			\
+		sum += (check_buf[i] != FILL_BYTE);		\
 	/* Clear entire check buffer for later bit tests. */	\
 	memset(check_buf, 0x00, sizeof(check_buf));		\
 	/* Extract stack-defined variable contents. */		\
@@ -184,7 +193,8 @@ static noinline void test_ ## name (struct kunit *test)		\
 	 * possible between the two leaf function calls.	\
 	 */							\
 	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
-			    "leaf fill was not 0xFF!?\n");	\
+			    "leaf fill was not 0x%02X!?\n",	\
+			    FILL_BYTE);				\
 								\
 	/* Validate that compiler lined up fill and target. */	\
 	KUNIT_ASSERT_TRUE_MSG(test,				\
@@ -196,9 +206,9 @@ static noinline void test_ ## name (struct kunit *test)		\
 		(int)((ssize_t)(uintptr_t)fill_start -		\
 		      (ssize_t)(uintptr_t)target_start));	\
 								\
-	/* Look for any bytes still 0xFF in check region. */	\
+	/* Validate check region has no FILL_BYTE bytes. */	\
 	for (sum = 0, i = 0; i < target_size; i++)		\
-		sum += (check_buf[i] == 0xFF);			\
+		sum += (check_buf[i] == FILL_BYTE);		\
 								\
 	if (sum != 0 && xfail)					\
 		kunit_skip(test,				\
@@ -233,12 +243,12 @@ static noinline int leaf_ ## name(unsigned long sp, bool fill,	\
 	 * stack frame of SOME kind...				\
 	 */							\
 	memset(buf, (char)(sp & 0xff), sizeof(buf));		\
-	/* Fill variable with 0xFF. */				\
+	/* Fill variable with FILL_BYTE. */			\
 	if (fill) {						\
 		fill_start = &var;				\
 		fill_size = sizeof(var);			\
 		memset(fill_start,				\
-		       (char)((sp & 0xff) | forced_mask),	\
+		       FILL_BYTE & forced_mask,			\
 		       fill_size);				\
 	}							\
 								\
@@ -380,7 +390,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
 			fill_start = &var;
 			fill_size = sizeof(var);
 
-			memset(fill_start, forced_mask | 0x55, fill_size);
+			memset(fill_start, (forced_mask | 0x55) & FILL_BYTE, fill_size);
 		}
 		memcpy(check_buf, target_start, target_size);
 		break;
@@ -391,7 +401,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
 			fill_start = &var;
 			fill_size = sizeof(var);
 
-			memset(fill_start, forced_mask | 0xaa, fill_size);
+			memset(fill_start, (forced_mask | 0xaa) & FILL_BYTE, fill_size);
 		}
 		memcpy(check_buf, target_start, target_size);
 		break;
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c5e2ec9303c5..a69e71a1ca55 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2255,7 +2255,7 @@ int __init no_hash_pointers_enable(char *str)
 early_param("no_hash_pointers", no_hash_pointers_enable);
 
 /* Used for Rust formatting ('%pA'). */
-char *rust_fmt_argument(char *buf, char *end, void *ptr);
+char *rust_fmt_argument(char *buf, char *end, const void *ptr);
 
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
diff --git a/mm/gup.c b/mm/gup.c
index 44c536904a83..d27e7c9e2596 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1283,6 +1283,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
 		return -EOPNOTSUPP;
 
+	if ((gup_flags & FOLL_SPLIT_PMD) && is_vm_hugetlb_page(vma))
+		return -EOPNOTSUPP;
+
 	if (vma_is_secretmem(vma))
 		return -EFAULT;
 
diff --git a/mm/memory.c b/mm/memory.c
index 525f96ad65b8..99dceaf6a105 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1356,12 +1356,12 @@ int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
 	pgd_t *src_pgd, *dst_pgd;
-	unsigned long next;
 	unsigned long addr = src_vma->vm_start;
 	unsigned long end = src_vma->vm_end;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	struct mmu_notifier_range range;
+	unsigned long next, pfn;
 	bool is_cow;
 	int ret;
 
@@ -1372,11 +1372,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
 
 	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
-		/*
-		 * We do not free on error cases below as remove_vma
-		 * gets called on error from higher level routine
-		 */
-		ret = track_pfn_copy(src_vma);
+		ret = track_pfn_copy(dst_vma, src_vma, &pfn);
 		if (ret)
 			return ret;
 	}
@@ -1413,7 +1409,6 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 			continue;
 		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
 					    addr, next))) {
-			untrack_pfn_clear(dst_vma);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1423,6 +1418,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		raw_write_seqcount_end(&src_mm->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
 	}
+	if (ret && unlikely(src_vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_copy(dst_vma, pfn);
 	return ret;
 }
 
@@ -6718,10 +6715,8 @@ void __might_fault(const char *file, int line)
 	if (pagefault_disabled())
 		return;
 	__might_sleep(file, line);
-#if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
 		might_lock_read(&current->mm->mmap_lock);
-#endif
 }
 EXPORT_SYMBOL(__might_fault);
 #endif
diff --git a/mm/zswap.c b/mm/zswap.c
index 7fefb2eb3fcd..00d51d013757 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -876,18 +876,32 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 {
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
+	struct acomp_req *req;
+	struct crypto_acomp *acomp;
+	u8 *buffer;
+
+	if (IS_ERR_OR_NULL(acomp_ctx))
+		return 0;
 
 	mutex_lock(&acomp_ctx->mutex);
-	if (!IS_ERR_OR_NULL(acomp_ctx)) {
-		if (!IS_ERR_OR_NULL(acomp_ctx->req))
-			acomp_request_free(acomp_ctx->req);
-		acomp_ctx->req = NULL;
-		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
-			crypto_free_acomp(acomp_ctx->acomp);
-		kfree(acomp_ctx->buffer);
-	}
+	req = acomp_ctx->req;
+	acomp = acomp_ctx->acomp;
+	buffer = acomp_ctx->buffer;
+	acomp_ctx->req = NULL;
+	acomp_ctx->acomp = NULL;
+	acomp_ctx->buffer = NULL;
 	mutex_unlock(&acomp_ctx->mutex);
 
+	/*
+	 * Do the actual freeing after releasing the mutex to avoid subtle
+	 * locking dependencies causing deadlocks.
+	 */
+	if (!IS_ERR_OR_NULL(req))
+		acomp_request_free(req);
+	if (!IS_ERR_OR_NULL(acomp))
+		crypto_free_acomp(acomp);
+	kfree(buffer);
+
 	return 0;
 }
 
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 01f3fbb3b67d..65230e81fa08 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -287,8 +287,8 @@ int can_send(struct sk_buff *skb, int loop)
 		netif_rx(newskb);
 
 	/* update statistics */
-	pkg_stats->tx_frames++;
-	pkg_stats->tx_frames_delta++;
+	atomic_long_inc(&pkg_stats->tx_frames);
+	atomic_long_inc(&pkg_stats->tx_frames_delta);
 
 	return 0;
 
@@ -647,8 +647,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	int matches;
 
 	/* update statistics */
-	pkg_stats->rx_frames++;
-	pkg_stats->rx_frames_delta++;
+	atomic_long_inc(&pkg_stats->rx_frames);
+	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
 	/* create non-zero unique skb identifier together with *skb */
 	while (!(can_skb_prv(skb)->skbcnt))
@@ -669,8 +669,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	consume_skb(skb);
 
 	if (matches > 0) {
-		pkg_stats->matches++;
-		pkg_stats->matches_delta++;
+		atomic_long_inc(&pkg_stats->matches);
+		atomic_long_inc(&pkg_stats->matches_delta);
 	}
 }
 
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 7c2d9161e224..22f3352c77fe 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -66,9 +66,9 @@ struct receiver {
 struct can_pkg_stats {
 	unsigned long jiffies_init;
 
-	unsigned long rx_frames;
-	unsigned long tx_frames;
-	unsigned long matches;
+	atomic_long_t rx_frames;
+	atomic_long_t tx_frames;
+	atomic_long_t matches;
 
 	unsigned long total_rx_rate;
 	unsigned long total_tx_rate;
@@ -82,9 +82,9 @@ struct can_pkg_stats {
 	unsigned long max_tx_rate;
 	unsigned long max_rx_match_ratio;
 
-	unsigned long rx_frames_delta;
-	unsigned long tx_frames_delta;
-	unsigned long matches_delta;
+	atomic_long_t rx_frames_delta;
+	atomic_long_t tx_frames_delta;
+	atomic_long_t matches_delta;
 };
 
 /* persistent statistics */
diff --git a/net/can/proc.c b/net/can/proc.c
index bbce97825f13..25fdf060e30d 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -118,6 +118,13 @@ void can_stat_update(struct timer_list *t)
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
 	unsigned long j = jiffies; /* snapshot */
 
+	long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
+	long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
+	long matches = atomic_long_read(&pkg_stats->matches);
+	long rx_frames_delta = atomic_long_read(&pkg_stats->rx_frames_delta);
+	long tx_frames_delta = atomic_long_read(&pkg_stats->tx_frames_delta);
+	long matches_delta = atomic_long_read(&pkg_stats->matches_delta);
+
 	/* restart counting in timer context on user request */
 	if (user_reset)
 		can_init_stats(net);
@@ -127,35 +134,33 @@ void can_stat_update(struct timer_list *t)
 		can_init_stats(net);
 
 	/* prevent overflow in calc_rate() */
-	if (pkg_stats->rx_frames > (ULONG_MAX / HZ))
+	if (rx_frames > (LONG_MAX / HZ))
 		can_init_stats(net);
 
 	/* prevent overflow in calc_rate() */
-	if (pkg_stats->tx_frames > (ULONG_MAX / HZ))
+	if (tx_frames > (LONG_MAX / HZ))
 		can_init_stats(net);
 
 	/* matches overflow - very improbable */
-	if (pkg_stats->matches > (ULONG_MAX / 100))
+	if (matches > (LONG_MAX / 100))
 		can_init_stats(net);
 
 	/* calc total values */
-	if (pkg_stats->rx_frames)
-		pkg_stats->total_rx_match_ratio = (pkg_stats->matches * 100) /
-			pkg_stats->rx_frames;
+	if (rx_frames)
+		pkg_stats->total_rx_match_ratio = (matches * 100) / rx_frames;
 
 	pkg_stats->total_tx_rate = calc_rate(pkg_stats->jiffies_init, j,
-					    pkg_stats->tx_frames);
+					    tx_frames);
 	pkg_stats->total_rx_rate = calc_rate(pkg_stats->jiffies_init, j,
-					    pkg_stats->rx_frames);
+					    rx_frames);
 
 	/* calc current values */
-	if (pkg_stats->rx_frames_delta)
+	if (rx_frames_delta)
 		pkg_stats->current_rx_match_ratio =
-			(pkg_stats->matches_delta * 100) /
-			pkg_stats->rx_frames_delta;
+			(matches_delta * 100) /	rx_frames_delta;
 
-	pkg_stats->current_tx_rate = calc_rate(0, HZ, pkg_stats->tx_frames_delta);
-	pkg_stats->current_rx_rate = calc_rate(0, HZ, pkg_stats->rx_frames_delta);
+	pkg_stats->current_tx_rate = calc_rate(0, HZ, tx_frames_delta);
+	pkg_stats->current_rx_rate = calc_rate(0, HZ, rx_frames_delta);
 
 	/* check / update maximum values */
 	if (pkg_stats->max_tx_rate < pkg_stats->current_tx_rate)
@@ -168,9 +173,9 @@ void can_stat_update(struct timer_list *t)
 		pkg_stats->max_rx_match_ratio = pkg_stats->current_rx_match_ratio;
 
 	/* clear values for 'current rate' calculation */
-	pkg_stats->tx_frames_delta = 0;
-	pkg_stats->rx_frames_delta = 0;
-	pkg_stats->matches_delta   = 0;
+	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
+	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
+	atomic_long_set(&pkg_stats->matches_delta, 0);
 
 	/* restart timer (one second) */
 	mod_timer(&net->can.stattimer, round_jiffies(jiffies + HZ));
@@ -214,9 +219,12 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
 
 	seq_putc(m, '\n');
-	seq_printf(m, " %8ld transmitted frames (TXF)\n", pkg_stats->tx_frames);
-	seq_printf(m, " %8ld received frames (RXF)\n", pkg_stats->rx_frames);
-	seq_printf(m, " %8ld matched frames (RXMF)\n", pkg_stats->matches);
+	seq_printf(m, " %8ld transmitted frames (TXF)\n",
+		   atomic_long_read(&pkg_stats->tx_frames));
+	seq_printf(m, " %8ld received frames (RXF)\n",
+		   atomic_long_read(&pkg_stats->rx_frames));
+	seq_printf(m, " %8ld matched frames (RXMF)\n",
+		   atomic_long_read(&pkg_stats->matches));
 
 	seq_putc(m, '\n');
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..17f8a83a5ee7 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -108,6 +108,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	struct netdev_rx_queue *rxq;
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
+	int err;
 
 	if (binding->list.next)
 		list_del(&binding->list);
@@ -119,7 +120,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
-		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
+		err = netdev_rx_queue_restart(binding->dev, rxq_idx);
+		WARN_ON(err && err != -ENETDOWN);
 	}
 
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
diff --git a/net/core/dst.c b/net/core/dst.c
index 9552a90d4772..6d76b799ce64 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -165,6 +165,14 @@ static void dst_count_dec(struct dst_entry *dst)
 void dst_release(struct dst_entry *dst)
 {
 	if (dst && rcuref_put(&dst->__rcuref)) {
+#ifdef CONFIG_DST_CACHE
+		if (dst->flags & DST_METADATA) {
+			struct metadata_dst *md_dst = (struct metadata_dst *)dst;
+
+			if (md_dst->type == METADATA_IP_TUNNEL)
+				dst_cache_reset_now(&md_dst->u.tun_info.dst_cache);
+		}
+#endif
 		dst_count_dec(dst);
 		call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
 	}
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2ba5cd965d3f..4d0ee1c9002a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1005,6 +1005,9 @@ static inline int rtnl_vfinfo_size(const struct net_device *dev,
 				 /* IFLA_VF_STATS_TX_DROPPED */
 				 nla_total_size_64bit(sizeof(__u64)));
 		}
+		if (dev->netdev_ops->ndo_get_vf_guid)
+			size += num_vfs * 2 *
+				nla_total_size(sizeof(struct ifla_vf_guid));
 		return size;
 	} else
 		return 0;
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index a3676155be78..f65d2f727381 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -416,7 +416,7 @@ int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
 
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
 
-	if (!reply || skb->pkt_type == PACKET_HOST)
+	if (!reply)
 		return 0;
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -451,7 +451,7 @@ static const struct nla_policy
 geneve_opt_policy[LWTUNNEL_IP_OPT_GENEVE_MAX + 1] = {
 	[LWTUNNEL_IP_OPT_GENEVE_CLASS]	= { .type = NLA_U16 },
 	[LWTUNNEL_IP_OPT_GENEVE_TYPE]	= { .type = NLA_U8 },
-	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 128 },
+	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8da74dc63061..f4e24fc878fa 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1470,12 +1470,12 @@ static bool udp_skb_has_head_state(struct sk_buff *skb)
 }
 
 /* fully reclaim rmem/fwd memory allocated for skb */
-static void udp_rmem_release(struct sock *sk, int size, int partial,
-			     bool rx_queue_lock_held)
+static void udp_rmem_release(struct sock *sk, unsigned int size,
+			     int partial, bool rx_queue_lock_held)
 {
 	struct udp_sock *up = udp_sk(sk);
 	struct sk_buff_head *sk_queue;
-	int amt;
+	unsigned int amt;
 
 	if (likely(partial)) {
 		up->forward_deficit += size;
@@ -1495,10 +1495,8 @@ static void udp_rmem_release(struct sock *sk, int size, int partial,
 	if (!rx_queue_lock_held)
 		spin_lock(&sk_queue->lock);
 
-
-	sk_forward_alloc_add(sk, size);
-	amt = (sk->sk_forward_alloc - partial) & ~(PAGE_SIZE - 1);
-	sk_forward_alloc_add(sk, -amt);
+	amt = (size + sk->sk_forward_alloc - partial) & ~(PAGE_SIZE - 1);
+	sk_forward_alloc_add(sk, size - amt);
 
 	if (amt)
 		__sk_mem_reduce_allocated(sk, amt >> PAGE_SHIFT);
@@ -1570,17 +1568,25 @@ static int udp_rmem_schedule(struct sock *sk, int size)
 int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct sk_buff_head *list = &sk->sk_receive_queue;
-	int rmem, err = -ENOMEM;
+	unsigned int rmem, rcvbuf;
 	spinlock_t *busy = NULL;
-	int size, rcvbuf;
+	int size, err = -ENOMEM;
 
-	/* Immediately drop when the receive queue is full.
-	 * Always allow at least one packet.
-	 */
 	rmem = atomic_read(&sk->sk_rmem_alloc);
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
-	if (rmem > rcvbuf)
-		goto drop;
+	size = skb->truesize;
+
+	/* Immediately drop when the receive queue is full.
+	 * Cast to unsigned int performs the boundary check for INT_MAX.
+	 */
+	if (rmem + size > rcvbuf) {
+		if (rcvbuf > INT_MAX >> 1)
+			goto drop;
+
+		/* Always allow at least one packet for small buffer. */
+		if (rmem > rcvbuf)
+			goto drop;
+	}
 
 	/* Under mem pressure, it might be helpful to help udp_recvmsg()
 	 * having linear skbs :
@@ -1590,10 +1596,10 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (rmem > (rcvbuf >> 1)) {
 		skb_condense(skb);
-
+		size = skb->truesize;
 		busy = busylock_acquire(sk);
 	}
-	size = skb->truesize;
+
 	udp_set_dev_scratch(skb);
 
 	atomic_add(size, &sk->sk_rmem_alloc);
@@ -1680,7 +1686,7 @@ EXPORT_SYMBOL_GPL(skb_consume_udp);
 
 static struct sk_buff *__first_packet_length(struct sock *sk,
 					     struct sk_buff_head *rcvq,
-					     int *total)
+					     unsigned int *total)
 {
 	struct sk_buff *skb;
 
@@ -1713,8 +1719,8 @@ static int first_packet_length(struct sock *sk)
 {
 	struct sk_buff_head *rcvq = &udp_sk(sk)->reader_queue;
 	struct sk_buff_head *sk_queue = &sk->sk_receive_queue;
+	unsigned int total = 0;
 	struct sk_buff *skb;
-	int total = 0;
 	int res;
 
 	spin_lock_bh(&rcvq->lock);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f7c17388ff6a..f5d49162f798 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5807,6 +5807,27 @@ static void snmp6_fill_stats(u64 *stats, struct inet6_dev *idev, int attrtype,
 	}
 }
 
+static int inet6_fill_ifla6_stats_attrs(struct sk_buff *skb,
+					struct inet6_dev *idev)
+{
+	struct nlattr *nla;
+
+	nla = nla_reserve(skb, IFLA_INET6_STATS, IPSTATS_MIB_MAX * sizeof(u64));
+	if (!nla)
+		goto nla_put_failure;
+	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_STATS, nla_len(nla));
+
+	nla = nla_reserve(skb, IFLA_INET6_ICMP6STATS, ICMP6_MIB_MAX * sizeof(u64));
+	if (!nla)
+		goto nla_put_failure;
+	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_ICMP6STATS, nla_len(nla));
+
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
 static int inet6_fill_ifla6_attrs(struct sk_buff *skb, struct inet6_dev *idev,
 				  u32 ext_filter_mask)
 {
@@ -5829,18 +5850,10 @@ static int inet6_fill_ifla6_attrs(struct sk_buff *skb, struct inet6_dev *idev,
 
 	/* XXX - MC not implemented */
 
-	if (ext_filter_mask & RTEXT_FILTER_SKIP_STATS)
-		return 0;
-
-	nla = nla_reserve(skb, IFLA_INET6_STATS, IPSTATS_MIB_MAX * sizeof(u64));
-	if (!nla)
-		goto nla_put_failure;
-	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_STATS, nla_len(nla));
-
-	nla = nla_reserve(skb, IFLA_INET6_ICMP6STATS, ICMP6_MIB_MAX * sizeof(u64));
-	if (!nla)
-		goto nla_put_failure;
-	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_ICMP6STATS, nla_len(nla));
+	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS)) {
+		if (inet6_fill_ifla6_stats_attrs(skb, idev) < 0)
+			goto nla_put_failure;
+	}
 
 	nla = nla_reserve(skb, IFLA_INET6_TOKEN, sizeof(struct in6_addr));
 	if (!nla)
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index dbcea9fee626..62618a058b8f 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1072,8 +1072,13 @@ static int calipso_sock_getattr(struct sock *sk,
 	struct ipv6_opt_hdr *hop;
 	int opt_len, len, ret_val = -ENOMSG, offset;
 	unsigned char *opt;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+
+	if (!pinfo)
+		return -EAFNOSUPPORT;
 
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;
 
@@ -1125,8 +1130,13 @@ static int calipso_sock_setattr(struct sock *sk,
 {
 	int ret_val;
 	struct ipv6_opt_hdr *old, *new;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+
+	if (!pinfo)
+		return -EAFNOSUPPORT;
 
+	txopts = txopt_get(pinfo);
 	old = NULL;
 	if (txopts)
 		old = txopts->hopopt;
@@ -1153,8 +1163,13 @@ static int calipso_sock_setattr(struct sock *sk,
 static void calipso_sock_delattr(struct sock *sk)
 {
 	struct ipv6_opt_hdr *new_hop;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+
+	if (!pinfo)
+		return;
 
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b393c37d2424..987492dcb07c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -412,12 +412,37 @@ static bool rt6_check_expired(const struct rt6_info *rt)
 	return false;
 }
 
+static struct fib6_info *
+rt6_multipath_first_sibling_rcu(const struct fib6_info *rt)
+{
+	struct fib6_info *iter;
+	struct fib6_node *fn;
+
+	fn = rcu_dereference(rt->fib6_node);
+	if (!fn)
+		goto out;
+	iter = rcu_dereference(fn->leaf);
+	if (!iter)
+		goto out;
+
+	while (iter) {
+		if (iter->fib6_metric == rt->fib6_metric &&
+		    rt6_qualify_for_ecmp(iter))
+			return iter;
+		iter = rcu_dereference(iter->fib6_next);
+	}
+
+out:
+	return NULL;
+}
+
 void fib6_select_path(const struct net *net, struct fib6_result *res,
 		      struct flowi6 *fl6, int oif, bool have_oif_match,
 		      const struct sk_buff *skb, int strict)
 {
-	struct fib6_info *match = res->f6i;
+	struct fib6_info *first, *match = res->f6i;
 	struct fib6_info *sibling;
+	int hash;
 
 	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
 		goto out;
@@ -440,16 +465,25 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		return;
 	}
 
-	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
+	first = rt6_multipath_first_sibling_rcu(match);
+	if (!first)
 		goto out;
 
-	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
+	hash = fl6->mp_hash;
+	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
+	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
+			    strict) >= 0) {
+		match = first;
+		goto out;
+	}
+
+	list_for_each_entry_rcu(sibling, &first->fib6_siblings,
 				fib6_siblings) {
 		const struct fib6_nh *nh = sibling->fib6_nh;
 		int nh_upper_bound;
 
 		nh_upper_bound = atomic_read(&nh->fib_nh_upper_bound);
-		if (fl6->mp_hash > nh_upper_bound)
+		if (hash > nh_upper_bound)
 			continue;
 		if (rt6_score_route(nh, sibling->fib6_flags, oif, strict) < 0)
 			break;
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index fe868b521622..4243f8ee5ab6 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -115,8 +115,14 @@ void drv_remove_interface(struct ieee80211_local *local,
 
 	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
 
-	/* Remove driver debugfs entries */
-	ieee80211_debugfs_recreate_netdev(sdata, sdata->vif.valid_links);
+	/*
+	 * Remove driver debugfs entries.
+	 * The virtual monitor interface doesn't get a debugfs
+	 * entry, so it's exempt here.
+	 */
+	if (sdata != rcu_access_pointer(local->monitor_sdata))
+		ieee80211_debugfs_recreate_netdev(sdata,
+						  sdata->vif.valid_links);
 
 	trace_drv_remove_interface(local, sdata);
 	local->ops->remove_interface(&local->hw, &sdata->vif);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index af9055252e6d..8bbfa45e1796 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1205,16 +1205,17 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 		return;
 	}
 
-	RCU_INIT_POINTER(local->monitor_sdata, NULL);
-	mutex_unlock(&local->iflist_mtx);
-
-	synchronize_net();
-
+	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	ieee80211_link_release_channel(&sdata->deflink);
 
 	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 		drv_remove_interface(local, sdata);
 
+	RCU_INIT_POINTER(local->monitor_sdata, NULL);
+	mutex_unlock(&local->iflist_mtx);
+
+	synchronize_net();
+
 	kfree(sdata);
 }
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6f3a86040cfc..8e1fbdd3bff1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #include <linux/jiffies.h>
@@ -3323,8 +3323,8 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	if (!ether_addr_equal(mgmt->sa, sdata->deflink.u.mgd.bssid) ||
-	    !ether_addr_equal(mgmt->bssid, sdata->deflink.u.mgd.bssid)) {
+	if (!ether_addr_equal(mgmt->sa, sdata->vif.cfg.ap_addr) ||
+	    !ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr)) {
 		/* Not from the current AP or not associated yet. */
 		return;
 	}
@@ -3340,9 +3340,9 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 	resp = skb_put_zero(skb, 24);
-	memcpy(resp->da, mgmt->sa, ETH_ALEN);
+	memcpy(resp->da, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	memcpy(resp->sa, sdata->vif.addr, ETH_ALEN);
-	memcpy(resp->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+	memcpy(resp->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	resp->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					  IEEE80211_STYPE_ACTION);
 	skb_put(skb, 1 + sizeof(resp->u.action.u.sa_query));
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa22f09e6d14..49095f19a0f2 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -4,7 +4,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/module.h>
@@ -1317,9 +1317,13 @@ static int _sta_info_move_state(struct sta_info *sta,
 		sta->sta.addr, new_state);
 
 	/* notify the driver before the actual changes so it can
-	 * fail the transition
+	 * fail the transition if the state is increasing.
+	 * The driver is required not to fail when the transition
+	 * is decreasing the state, so first, do all the preparation
+	 * work and only then, notify the driver.
 	 */
-	if (test_sta_flag(sta, WLAN_STA_INSERTED)) {
+	if (new_state > sta->sta_state &&
+	    test_sta_flag(sta, WLAN_STA_INSERTED)) {
 		int err = drv_sta_state(sta->local, sta->sdata, sta,
 					sta->sta_state, new_state);
 		if (err)
@@ -1395,6 +1399,16 @@ static int _sta_info_move_state(struct sta_info *sta,
 		break;
 	}
 
+	if (new_state < sta->sta_state &&
+	    test_sta_flag(sta, WLAN_STA_INSERTED)) {
+		int err = drv_sta_state(sta->local, sta->sdata, sta,
+					sta->sta_state, new_state);
+
+		WARN_ONCE(err,
+			  "Driver is not allowed to fail if the sta_state is transitioning down the list: %d\n",
+			  err);
+	}
+
 	sta->sta_state = new_state;
 
 	return 0;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2b6e8e7307ee..a98ae563613c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -685,7 +685,7 @@ void __ieee80211_flush_queues(struct ieee80211_local *local,
 			      struct ieee80211_sub_if_data *sdata,
 			      unsigned int queues, bool drop)
 {
-	if (!local->ops->flush)
+	if (!local->ops->flush && !drop)
 		return;
 
 	/*
@@ -712,7 +712,8 @@ void __ieee80211_flush_queues(struct ieee80211_local *local,
 		}
 	}
 
-	drv_flush(local, sdata, queues, drop);
+	if (local->ops->flush)
+		drv_flush(local, sdata, queues, drop);
 
 	ieee80211_wake_queues_by_reason(&local->hw, queues,
 					IEEE80211_QUEUE_STOP_REASON_FLUSH,
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index eb3a6f96b094..bdee187bc5dd 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2732,11 +2732,11 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 			err = nft_netdev_register_hooks(ctx->net, &hook.list);
 			if (err < 0)
 				goto err_hooks;
+
+			unregister = true;
 		}
 	}
 
-	unregister = true;
-
 	if (nla[NFTA_CHAIN_COUNTERS]) {
 		if (!nft_is_base_chain(chain)) {
 			err = -EOPNOTSUPP;
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index b93f046ac7d1..4b3452dff2ec 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -309,7 +309,8 @@ static bool nft_rhash_expr_needs_gc_run(const struct nft_set *set,
 
 	nft_setelem_expr_foreach(expr, elem_expr, size) {
 		if (expr->ops->gc &&
-		    expr->ops->gc(read_pnet(&set->net), expr))
+		    expr->ops->gc(read_pnet(&set->net), expr) &&
+		    set->flags & NFT_SET_EVAL)
 			return true;
 	}
 
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 5c6ed68cc6e0..0d99786c322e 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -335,13 +335,13 @@ static int nft_tunnel_obj_erspan_init(const struct nlattr *attr,
 static const struct nla_policy nft_tunnel_opts_geneve_policy[NFTA_TUNNEL_KEY_GENEVE_MAX + 1] = {
 	[NFTA_TUNNEL_KEY_GENEVE_CLASS]	= { .type = NLA_U16 },
 	[NFTA_TUNNEL_KEY_GENEVE_TYPE]	= { .type = NLA_U8 },
-	[NFTA_TUNNEL_KEY_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 128 },
+	[NFTA_TUNNEL_KEY_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },
 };
 
 static int nft_tunnel_obj_geneve_init(const struct nlattr *attr,
 				      struct nft_tunnel_opts *opts)
 {
-	struct geneve_opt *opt = (struct geneve_opt *)opts->u.data + opts->len;
+	struct geneve_opt *opt = (struct geneve_opt *)(opts->u.data + opts->len);
 	struct nlattr *tb[NFTA_TUNNEL_KEY_GENEVE_MAX + 1];
 	int err, data_len;
 
@@ -628,7 +628,7 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
 		if (!inner)
 			goto failure;
 		while (opts->len > offset) {
-			opt = (struct geneve_opt *)opts->u.data + offset;
+			opt = (struct geneve_opt *)(opts->u.data + offset);
 			if (nla_put_be16(skb, NFTA_TUNNEL_KEY_GENEVE_CLASS,
 					 opt->opt_class) ||
 			    nla_put_u8(skb, NFTA_TUNNEL_KEY_GENEVE_TYPE,
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 704c858cf209..61fea7baae5d 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -947,12 +947,6 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 				pskb_trim(skb, ovs_mac_header_len(key));
 		}
 
-		/* Need to set the pkt_type to involve the routing layer.  The
-		 * packet movement through the OVS datapath doesn't generally
-		 * use routing, but this is needed for tunnel cases.
-		 */
-		skb->pkt_type = PACKET_OUTGOING;
-
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
 			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index af7c99845948..e296714803dc 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -68,7 +68,7 @@ geneve_opt_policy[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_MAX + 1] = {
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_CLASS]	   = { .type = NLA_U16 },
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_TYPE]	   = { .type = NLA_U8 },
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_DATA]	   = { .type = NLA_BINARY,
-						       .len = 128 },
+						       .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 03505673d523..099ff6a3e1f5 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -766,7 +766,7 @@ geneve_opt_policy[TCA_FLOWER_KEY_ENC_OPT_GENEVE_MAX + 1] = {
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_CLASS]      = { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_TYPE]       = { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_DATA]       = { .type = NLA_BINARY,
-						       .len = 128 },
+						       .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/sched/sch_skbprio.c b/net/sched/sch_skbprio.c
index 20ff7386b74b..f485f62ab721 100644
--- a/net/sched/sch_skbprio.c
+++ b/net/sched/sch_skbprio.c
@@ -123,8 +123,6 @@ static int skbprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	/* Check to update highest and lowest priorities. */
 	if (skb_queue_empty(lp_qdisc)) {
 		if (q->lowest_prio == q->highest_prio) {
-			/* The incoming packet is the only packet in queue. */
-			BUG_ON(sch->q.qlen != 1);
 			q->lowest_prio = prio;
 			q->highest_prio = prio;
 		} else {
@@ -156,7 +154,6 @@ static struct sk_buff *skbprio_dequeue(struct Qdisc *sch)
 	/* Update highest priority field. */
 	if (skb_queue_empty(hpq)) {
 		if (q->lowest_prio == q->highest_prio) {
-			BUG_ON(sch->q.qlen);
 			q->highest_prio = 0;
 			q->lowest_prio = SKBPRIO_MAX_PRIORITY - 1;
 		} else {
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 8e1e97be4df7..ee3eac338a9d 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -525,6 +525,8 @@ static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static DEFINE_MUTEX(sctp_sysctl_mutex);
+
 static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -549,6 +551,7 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 		if (new_value > max || new_value < min)
 			return -EINVAL;
 
+		mutex_lock(&sctp_sysctl_mutex);
 		net->sctp.udp_port = new_value;
 		sctp_udp_sock_stop(net);
 		if (new_value) {
@@ -561,6 +564,7 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 		lock_sock(sk);
 		sctp_sk(sk)->udp_port = htons(net->sctp.udp_port);
 		release_sock(sk);
+		mutex_unlock(&sctp_sysctl_mutex);
 	}
 
 	return ret;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index eb6ea26b390e..d08f205b33dc 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1551,7 +1551,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 	timeout = vsk->connect_timeout;
 	prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 
-	while (sk->sk_state != TCP_ESTABLISHED && sk->sk_err == 0) {
+	/* If the socket is already closing or it is in an error state, there
+	 * is no point in waiting.
+	 */
+	while (sk->sk_state != TCP_ESTABLISHED &&
+	       sk->sk_state != TCP_CLOSING && sk->sk_err == 0) {
 		if (flags & O_NONBLOCK) {
 			/* If we're not going to block, we schedule a timeout
 			 * function to generate a timeout on the connection
diff --git a/rust/Makefile b/rust/Makefile
index 09521fc449dc..1b00e16951ee 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -227,7 +227,8 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-mfunction-return=thunk-extern -mrecord-mcount -mabi=lp64 \
 	-mindirect-branch-cs-prefix -mstack-protector-guard% -mtraceback=no \
 	-mno-pointers-to-nested-functions -mno-string \
-	-mno-strict-align -mstrict-align \
+	-mno-strict-align -mstrict-align -mdirect-extern-access \
+	-mexplicit-relocs -mno-check-zero-division \
 	-fconserve-stack -falign-jumps=% -falign-loops=% \
 	-femit-struct-debug-baseonly -fno-ipa-cp-clone -fno-ipa-sra \
 	-fno-partial-inlining -fplugin-arg-arm_ssp_per_task_plugin-% \
@@ -241,6 +242,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
+BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
 # All warnings are inhibited since GCC builds are very experimental,
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index a28077a7cb30..e52cd64333bc 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -6,12 +6,11 @@
 //!
 //! Reference: <https://docs.kernel.org/core-api/printk-basics.html>
 
-use core::{
+use crate::{
     ffi::{c_char, c_void},
-    fmt,
+    str::RawFormatter,
 };
-
-use crate::str::RawFormatter;
+use core::fmt;
 
 // Called from `vsprintf` with format specifier `%pA`.
 #[expect(clippy::missing_safety_doc)]
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index ca07243bd5cd..2b3f9a0bd6c4 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -21,9 +21,11 @@ ifeq ($(origin KBUILD_VERBOSE),undefined)
     endif
 endif
 
-revision = $(lastword $(subst -, ,$(shell dpkg-parsechangelog -S Version)))
+revision = $(shell dpkg-parsechangelog -S Version | sed -n 's/.*-//p')
 CROSS_COMPILE ?= $(filter-out $(DEB_BUILD_GNU_TYPE)-, $(DEB_HOST_GNU_TYPE)-)
-make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(revision) $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
+make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) \
+    $(addprefix KBUILD_BUILD_VERSION=,$(revision)) \
+    $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
 
 binary-targets := $(addprefix binary-, image image-dbg headers libc-dev)
 
diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
index 24086793b0d8..db40237e60ce 100755
--- a/scripts/selinux/install_policy.sh
+++ b/scripts/selinux/install_policy.sh
@@ -6,27 +6,24 @@ if [ `id -u` -ne 0 ]; then
 	exit 1
 fi
 
-SF=`which setfiles`
-if [ $? -eq 1 ]; then
+SF=`which setfiles` || {
 	echo "Could not find setfiles"
 	echo "Do you have policycoreutils installed?"
 	exit 1
-fi
+}
 
-CP=`which checkpolicy`
-if [ $? -eq 1 ]; then
+CP=`which checkpolicy` || {
 	echo "Could not find checkpolicy"
 	echo "Do you have checkpolicy installed?"
 	exit 1
-fi
+}
 VERS=`$CP -V | awk '{print $1}'`
 
-ENABLED=`which selinuxenabled`
-if [ $? -eq 1 ]; then
+ENABLED=`which selinuxenabled` || {
 	echo "Could not find selinuxenabled"
 	echo "Do you have libselinux-utils installed?"
 	exit 1
-fi
+}
 
 if selinuxenabled; then
     echo "SELinux is already enabled"
diff --git a/security/smack/smack.h b/security/smack/smack.h
index dbf8d7226eb5..1c3656b5e3b9 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -152,6 +152,7 @@ struct smk_net4addr {
 	struct smack_known	*smk_label;	/* label */
 };
 
+#if IS_ENABLED(CONFIG_IPV6)
 /*
  * An entry in the table identifying IPv6 hosts.
  */
@@ -162,7 +163,9 @@ struct smk_net6addr {
 	int			smk_masks;	/* mask size */
 	struct smack_known	*smk_label;	/* label */
 };
+#endif /* CONFIG_IPV6 */
 
+#ifdef SMACK_IPV6_PORT_LABELING
 /*
  * An entry in the table identifying ports.
  */
@@ -175,6 +178,7 @@ struct smk_port_label {
 	short			smk_sock_type;	/* Socket type */
 	short			smk_can_reuse;
 };
+#endif /* SMACK_IPV6_PORT_LABELING */
 
 struct smack_known_list_elem {
 	struct list_head	list;
@@ -314,7 +318,9 @@ extern struct smack_known smack_known_web;
 extern struct mutex	smack_known_lock;
 extern struct list_head smack_known_list;
 extern struct list_head smk_net4addr_list;
+#if IS_ENABLED(CONFIG_IPV6)
 extern struct list_head smk_net6addr_list;
+#endif /* CONFIG_IPV6 */
 
 extern struct mutex     smack_onlycap_lock;
 extern struct list_head smack_onlycap_list;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 370fd594da12..9e13fd392063 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2498,6 +2498,7 @@ static struct smack_known *smack_ipv4host_label(struct sockaddr_in *sip)
 	return NULL;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 /*
  * smk_ipv6_localhost - Check for local ipv6 host address
  * @sip: the address
@@ -2565,6 +2566,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
 
 	return NULL;
 }
+#endif /* CONFIG_IPV6 */
 
 /**
  * smack_netlbl_add - Set the secattr on a socket
@@ -2669,6 +2671,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 	return rc;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 /**
  * smk_ipv6_check - check Smack access
  * @subject: subject Smack label
@@ -2701,6 +2704,7 @@ static int smk_ipv6_check(struct smack_known *subject,
 	rc = smk_bu_note("IPv6 check", subject, object, MAY_WRITE, rc);
 	return rc;
 }
+#endif /* CONFIG_IPV6 */
 
 #ifdef SMACK_IPV6_PORT_LABELING
 /**
@@ -3033,7 +3037,9 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 		return 0;
 	if (addrlen < offsetofend(struct sockaddr, sa_family))
 		return 0;
-	if (IS_ENABLED(CONFIG_IPV6) && sap->sa_family == AF_INET6) {
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sap->sa_family == AF_INET6) {
 		struct sockaddr_in6 *sip = (struct sockaddr_in6 *)sap;
 		struct smack_known *rsp = NULL;
 
@@ -3053,6 +3059,8 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 
 		return rc;
 	}
+#endif /* CONFIG_IPV6 */
+
 	if (sap->sa_family != AF_INET || addrlen < sizeof(struct sockaddr_in))
 		return 0;
 	rc = smk_ipv4_check(sock->sk, (struct sockaddr_in *)sap);
@@ -4349,29 +4357,6 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 	return 0;
 }
 
-/**
- * smack_sock_graft - Initialize a newly created socket with an existing sock
- * @sk: child sock
- * @parent: parent socket
- *
- * Set the smk_{in,out} state of an existing sock based on the process that
- * is creating the new socket.
- */
-static void smack_sock_graft(struct sock *sk, struct socket *parent)
-{
-	struct socket_smack *ssp;
-	struct smack_known *skp = smk_of_current();
-
-	if (sk == NULL ||
-	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
-		return;
-
-	ssp = smack_sock(sk);
-	ssp->smk_in = skp;
-	ssp->smk_out = skp;
-	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
-}
-
 /**
  * smack_inet_conn_request - Smack access check on connect
  * @sk: socket involved
@@ -5160,7 +5145,6 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
 #endif
 	LSM_HOOK_INIT(sk_clone_security, smack_sk_clone_security),
-	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),
 
diff --git a/sound/core/timer.c b/sound/core/timer.c
index fbada79380f9..d774b9b71ce2 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1515,91 +1515,97 @@ static void snd_timer_user_copy_id(struct snd_timer_id *id, struct snd_timer *ti
 	id->subdevice = timer->tmr_subdevice;
 }
 
-static int snd_timer_user_next_device(struct snd_timer_id __user *_tid)
+static void get_next_device(struct snd_timer_id *id)
 {
-	struct snd_timer_id id;
 	struct snd_timer *timer;
 	struct list_head *p;
 
-	if (copy_from_user(&id, _tid, sizeof(id)))
-		return -EFAULT;
-	guard(mutex)(&register_mutex);
-	if (id.dev_class < 0) {		/* first item */
+	if (id->dev_class < 0) {		/* first item */
 		if (list_empty(&snd_timer_list))
-			snd_timer_user_zero_id(&id);
+			snd_timer_user_zero_id(id);
 		else {
 			timer = list_entry(snd_timer_list.next,
 					   struct snd_timer, device_list);
-			snd_timer_user_copy_id(&id, timer);
+			snd_timer_user_copy_id(id, timer);
 		}
 	} else {
-		switch (id.dev_class) {
+		switch (id->dev_class) {
 		case SNDRV_TIMER_CLASS_GLOBAL:
-			id.device = id.device < 0 ? 0 : id.device + 1;
+			id->device = id->device < 0 ? 0 : id->device + 1;
 			list_for_each(p, &snd_timer_list) {
 				timer = list_entry(p, struct snd_timer, device_list);
 				if (timer->tmr_class > SNDRV_TIMER_CLASS_GLOBAL) {
-					snd_timer_user_copy_id(&id, timer);
+					snd_timer_user_copy_id(id, timer);
 					break;
 				}
-				if (timer->tmr_device >= id.device) {
-					snd_timer_user_copy_id(&id, timer);
+				if (timer->tmr_device >= id->device) {
+					snd_timer_user_copy_id(id, timer);
 					break;
 				}
 			}
 			if (p == &snd_timer_list)
-				snd_timer_user_zero_id(&id);
+				snd_timer_user_zero_id(id);
 			break;
 		case SNDRV_TIMER_CLASS_CARD:
 		case SNDRV_TIMER_CLASS_PCM:
-			if (id.card < 0) {
-				id.card = 0;
+			if (id->card < 0) {
+				id->card = 0;
 			} else {
-				if (id.device < 0) {
-					id.device = 0;
+				if (id->device < 0) {
+					id->device = 0;
 				} else {
-					if (id.subdevice < 0)
-						id.subdevice = 0;
-					else if (id.subdevice < INT_MAX)
-						id.subdevice++;
+					if (id->subdevice < 0)
+						id->subdevice = 0;
+					else if (id->subdevice < INT_MAX)
+						id->subdevice++;
 				}
 			}
 			list_for_each(p, &snd_timer_list) {
 				timer = list_entry(p, struct snd_timer, device_list);
-				if (timer->tmr_class > id.dev_class) {
-					snd_timer_user_copy_id(&id, timer);
+				if (timer->tmr_class > id->dev_class) {
+					snd_timer_user_copy_id(id, timer);
 					break;
 				}
-				if (timer->tmr_class < id.dev_class)
+				if (timer->tmr_class < id->dev_class)
 					continue;
-				if (timer->card->number > id.card) {
-					snd_timer_user_copy_id(&id, timer);
+				if (timer->card->number > id->card) {
+					snd_timer_user_copy_id(id, timer);
 					break;
 				}
-				if (timer->card->number < id.card)
+				if (timer->card->number < id->card)
 					continue;
-				if (timer->tmr_device > id.device) {
-					snd_timer_user_copy_id(&id, timer);
+				if (timer->tmr_device > id->device) {
+					snd_timer_user_copy_id(id, timer);
 					break;
 				}
-				if (timer->tmr_device < id.device)
+				if (timer->tmr_device < id->device)
 					continue;
-				if (timer->tmr_subdevice > id.subdevice) {
-					snd_timer_user_copy_id(&id, timer);
+				if (timer->tmr_subdevice > id->subdevice) {
+					snd_timer_user_copy_id(id, timer);
 					break;
 				}
-				if (timer->tmr_subdevice < id.subdevice)
+				if (timer->tmr_subdevice < id->subdevice)
 					continue;
-				snd_timer_user_copy_id(&id, timer);
+				snd_timer_user_copy_id(id, timer);
 				break;
 			}
 			if (p == &snd_timer_list)
-				snd_timer_user_zero_id(&id);
+				snd_timer_user_zero_id(id);
 			break;
 		default:
-			snd_timer_user_zero_id(&id);
+			snd_timer_user_zero_id(id);
 		}
 	}
+}
+
+static int snd_timer_user_next_device(struct snd_timer_id __user *_tid)
+{
+	struct snd_timer_id id;
+
+	if (copy_from_user(&id, _tid, sizeof(id)))
+		return -EFAULT;
+	scoped_guard(mutex, &register_mutex)
+		get_next_device(&id);
 	if (copy_to_user(_tid, &id, sizeof(*_tid)))
 		return -EFAULT;
 	return 0;
@@ -1620,23 +1626,24 @@ static int snd_timer_user_ginfo(struct file *file,
 	tid = ginfo->tid;
 	memset(ginfo, 0, sizeof(*ginfo));
 	ginfo->tid = tid;
-	guard(mutex)(&register_mutex);
-	t = snd_timer_find(&tid);
-	if (!t)
-		return -ENODEV;
-	ginfo->card = t->card ? t->card->number : -1;
-	if (t->hw.flags & SNDRV_TIMER_HW_SLAVE)
-		ginfo->flags |= SNDRV_TIMER_FLG_SLAVE;
-	strscpy(ginfo->id, t->id, sizeof(ginfo->id));
-	strscpy(ginfo->name, t->name, sizeof(ginfo->name));
-	scoped_guard(spinlock_irq, &t->lock)
-		ginfo->resolution = snd_timer_hw_resolution(t);
-	if (t->hw.resolution_min > 0) {
-		ginfo->resolution_min = t->hw.resolution_min;
-		ginfo->resolution_max = t->hw.resolution_max;
-	}
-	list_for_each(p, &t->open_list_head) {
-		ginfo->clients++;
+	scoped_guard(mutex, &register_mutex) {
+		t = snd_timer_find(&tid);
+		if (!t)
+			return -ENODEV;
+		ginfo->card = t->card ? t->card->number : -1;
+		if (t->hw.flags & SNDRV_TIMER_HW_SLAVE)
+			ginfo->flags |= SNDRV_TIMER_FLG_SLAVE;
+		strscpy(ginfo->id, t->id, sizeof(ginfo->id));
+		strscpy(ginfo->name, t->name, sizeof(ginfo->name));
+		scoped_guard(spinlock_irq, &t->lock)
+			ginfo->resolution = snd_timer_hw_resolution(t);
+		if (t->hw.resolution_min > 0) {
+			ginfo->resolution_min = t->hw.resolution_min;
+			ginfo->resolution_max = t->hw.resolution_max;
+		}
+		list_for_each(p, &t->open_list_head) {
+			ginfo->clients++;
+		}
 	}
 	if (copy_to_user(_ginfo, ginfo, sizeof(*ginfo)))
 		return -EFAULT;
@@ -1674,31 +1681,31 @@ static int snd_timer_user_gstatus(struct file *file,
 	struct snd_timer_gstatus gstatus;
 	struct snd_timer_id tid;
 	struct snd_timer *t;
-	int err = 0;
 
 	if (copy_from_user(&gstatus, _gstatus, sizeof(gstatus)))
 		return -EFAULT;
 	tid = gstatus.tid;
 	memset(&gstatus, 0, sizeof(gstatus));
 	gstatus.tid = tid;
-	guard(mutex)(&register_mutex);
-	t = snd_timer_find(&tid);
-	if (t != NULL) {
-		guard(spinlock_irq)(&t->lock);
-		gstatus.resolution = snd_timer_hw_resolution(t);
-		if (t->hw.precise_resolution) {
-			t->hw.precise_resolution(t, &gstatus.resolution_num,
-						 &gstatus.resolution_den);
+	scoped_guard(mutex, &register_mutex) {
+		t = snd_timer_find(&tid);
+		if (t != NULL) {
+			guard(spinlock_irq)(&t->lock);
+			gstatus.resolution = snd_timer_hw_resolution(t);
+			if (t->hw.precise_resolution) {
+				t->hw.precise_resolution(t, &gstatus.resolution_num,
+							 &gstatus.resolution_den);
+			} else {
+				gstatus.resolution_num = gstatus.resolution;
+				gstatus.resolution_den = 1000000000uL;
+			}
 		} else {
-			gstatus.resolution_num = gstatus.resolution;
-			gstatus.resolution_den = 1000000000uL;
+			return -ENODEV;
 		}
-	} else {
-		err = -ENODEV;
 	}
-	if (err >= 0 && copy_to_user(_gstatus, &gstatus, sizeof(gstatus)))
-		err = -EFAULT;
-	return err;
+	if (copy_to_user(_gstatus, &gstatus, sizeof(gstatus)))
+		return -EFAULT;
+	return 0;
 }
 
 static int snd_timer_user_tselect(struct file *file,
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8c7da13a804c..59e59fdc38f2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -586,6 +586,9 @@ static void alc_shutup_pins(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
+	if (spec->no_shutup_pins)
+		return;
+
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
@@ -601,8 +604,7 @@ static void alc_shutup_pins(struct hda_codec *codec)
 		alc_headset_mic_no_shutup(codec);
 		break;
 	default:
-		if (!spec->no_shutup_pins)
-			snd_hda_shutup_pins(codec);
+		snd_hda_shutup_pins(codec);
 		break;
 	}
 }
@@ -4792,6 +4794,21 @@ static void alc236_fixup_hp_coef_micmute_led(struct hda_codec *codec,
 	}
 }
 
+static void alc295_fixup_hp_mute_led_coefbit11(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0xb;
+		spec->mute_led_coef.mask = 3 << 3;
+		spec->mute_led_coef.on = 1 << 3;
+		spec->mute_led_coef.off = 1 << 4;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 static void alc285_fixup_hp_mute_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -7624,6 +7641,7 @@ enum {
 	ALC290_FIXUP_MONO_SPEAKERS_HSJACK,
 	ALC290_FIXUP_SUBWOOFER,
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
+	ALC295_FIXUP_HP_MUTE_LED_COEFBIT11,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
 	ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13,
@@ -9359,6 +9377,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC283_FIXUP_INT_MIC,
 	},
+	[ALC295_FIXUP_HP_MUTE_LED_COEFBIT11] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc295_fixup_hp_mute_led_coefbit11,
+	},
 	[ALC298_FIXUP_SAMSUNG_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_samsung_amp,
@@ -10394,6 +10416,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
@@ -10618,7 +10641,9 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
+	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x1074, "ASUS G614PH/PM/PP", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x10a1, "ASUS UX391UA", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x10a4, "ASUS TP3407SA", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x10c0, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
@@ -10626,15 +10651,18 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x10d3, "ASUS K6500ZC", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1154, "ASUS TP3607SH", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x1194, "ASUS UM3406KA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1204, "ASUS Strix G615JHR_JMR_JPR", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x1214, "ASUS Strix G615LH_LM_LP", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x125e, "ASUS Q524UQK", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1271, "ASUS X430UN", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1290, "ASUS X441SA", ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x1294, "ASUS B3405CVA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x12a0, "ASUS X441UV", ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x12a3, "Asus N7691ZM", ALC269_FIXUP_ASUS_N7601ZM),
 	SND_PCI_QUIRK(0x1043, 0x12af, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x12b4, "ASUS B3405CCA / P3405CCA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
@@ -10648,6 +10676,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601VV/VU/VJ/VQ/VI", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x14d3, "ASUS G614JY/JZ/JG", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x14e3, "ASUS G513PI/PU/PV", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x14f2, "ASUS VivoBook X515JA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1503, "ASUS G733PY/PZ/PZV/PYV", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1533, "ASUS GV302XA/XJ/XQ/XU/XV/XI", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10687,6 +10716,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1c43, "ASUS UX8406MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c63, "ASUS GU605M", ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1),
+	SND_PCI_QUIRK(0x1043, 0x1c80, "ASUS VivoBook TP401", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1c9f, "ASUS G614JU/JV/JI", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JY/JZ/JI/JG", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
@@ -10715,14 +10745,28 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1f1f, "ASUS H7604JI/JV/J3D", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1f63, "ASUS P5405CSA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1fb3, "ASUS ROG Flow Z13 GZ302EA", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x3011, "ASUS B5605CVA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
+	SND_PCI_QUIRK(0x1043, 0x3061, "ASUS B3405CCA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3071, "ASUS B5405CCA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x30c1, "ASUS B3605CCA / P3605CCA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x30d1, "ASUS B5405CCA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x30e1, "ASUS B5605CCA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x31d0, "ASUS Zen AIO 27 Z272SD_A272SD", ALC274_FIXUP_ASUS_ZEN_AIO_27),
+	SND_PCI_QUIRK(0x1043, 0x31e1, "ASUS B5605CCA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x31f1, "ASUS B3605CCA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a60, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
+	SND_PCI_QUIRK(0x1043, 0x3d78, "ASUS GA603KH", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x3d88, "ASUS GA603KM", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x3e00, "ASUS G814FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x3e20, "ASUS G814PH/PM/PP", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x3e30, "ASUS TP3607SA", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x3ee0, "ASUS Strix G815_JHR_JMR_JPR", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x3ef0, "ASUS Strix G635LR_LW_LX", ALC287_FIXUP_TAS2781_I2C),
@@ -10730,6 +10774,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x3f10, "ASUS Strix G835LR_LW_LX", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x3f20, "ASUS Strix G615LR_LW", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x3f30, "ASUS Strix G815LR_LW", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x1043, 0x3fd0, "ASUS B3605CVA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3ff0, "ASUS B5405CVA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index be01b178172e..e4af2640feeb 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -13,6 +13,7 @@
  */
 
 #include "amd.h"
+#include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/export.h>
 
@@ -445,7 +446,9 @@ void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip)
 {
 	struct acpi_device *pdm_dev;
 	const union acpi_object *obj;
-	u32 pdm_addr;
+	acpi_handle handle;
+	acpi_integer dmic_status;
+	u32 pdm_addr, ret;
 
 	switch (chip->acp_rev) {
 	case ACP3X_DEV:
@@ -477,6 +480,11 @@ void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip)
 						   obj->integer.value == pdm_addr)
 				chip->is_pdm_dev = true;
 		}
+
+		handle = ACPI_HANDLE(&pci->dev);
+		ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
+		if (!ACPI_FAILURE(ret))
+			chip->is_pdm_dev = dmic_status;
 	}
 }
 EXPORT_SYMBOL_NS_GPL(check_acp_config, SND_SOC_ACP_COMMON);
diff --git a/sound/soc/codecs/cs35l41-spi.c b/sound/soc/codecs/cs35l41-spi.c
index a6db44520c06..f9b6bf7bea9c 100644
--- a/sound/soc/codecs/cs35l41-spi.c
+++ b/sound/soc/codecs/cs35l41-spi.c
@@ -32,13 +32,16 @@ static int cs35l41_spi_probe(struct spi_device *spi)
 	const struct regmap_config *regmap_config = &cs35l41_regmap_spi;
 	struct cs35l41_hw_cfg *hw_cfg = dev_get_platdata(&spi->dev);
 	struct cs35l41_private *cs35l41;
+	int ret;
 
 	cs35l41 = devm_kzalloc(&spi->dev, sizeof(struct cs35l41_private), GFP_KERNEL);
 	if (!cs35l41)
 		return -ENOMEM;
 
 	spi->max_speed_hz = CS35L41_SPI_MAX_FREQ;
-	spi_setup(spi);
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
 
 	spi_set_drvdata(spi, cs35l41);
 	cs35l41->regmap = devm_regmap_init_spi(spi, regmap_config);
diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index f4e1ea29c265..f2d194e76a94 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -3705,6 +3705,9 @@ static int rt1320_read_prop(struct sdw_slave *slave)
 	/* set the timeout values */
 	prop->clk_stop_timeout = 64;
 
+	/* BIOS may set wake_capable. Make sure it is 0 as wake events are disabled. */
+	prop->wake_capable = 0;
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 47df14ba5278..4f0236b34a2d 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -31,9 +31,7 @@
 #include "rl6231.h"
 #include "rt5665.h"
 
-#define RT5665_NUM_SUPPLIES 3
-
-static const char *rt5665_supply_names[RT5665_NUM_SUPPLIES] = {
+static const char * const rt5665_supply_names[] = {
 	"AVDD",
 	"MICVDD",
 	"VBAT",
@@ -46,7 +44,6 @@ struct rt5665_priv {
 	struct gpio_desc *gpiod_ldo1_en;
 	struct gpio_desc *gpiod_reset;
 	struct snd_soc_jack *hs_jack;
-	struct regulator_bulk_data supplies[RT5665_NUM_SUPPLIES];
 	struct delayed_work jack_detect_work;
 	struct delayed_work calibrate_work;
 	struct delayed_work jd_check_work;
@@ -4471,8 +4468,6 @@ static void rt5665_remove(struct snd_soc_component *component)
 	struct rt5665_priv *rt5665 = snd_soc_component_get_drvdata(component);
 
 	regmap_write(rt5665->regmap, RT5665_RESET, 0);
-
-	regulator_bulk_disable(ARRAY_SIZE(rt5665->supplies), rt5665->supplies);
 }
 
 #ifdef CONFIG_PM
@@ -4758,7 +4753,7 @@ static int rt5665_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5665_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5665_priv *rt5665;
-	int i, ret;
+	int ret;
 	unsigned int val;
 
 	rt5665 = devm_kzalloc(&i2c->dev, sizeof(struct rt5665_priv),
@@ -4774,24 +4769,13 @@ static int rt5665_i2c_probe(struct i2c_client *i2c)
 	else
 		rt5665_parse_dt(rt5665, &i2c->dev);
 
-	for (i = 0; i < ARRAY_SIZE(rt5665->supplies); i++)
-		rt5665->supplies[i].supply = rt5665_supply_names[i];
-
-	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(rt5665->supplies),
-				      rt5665->supplies);
+	ret = devm_regulator_bulk_get_enable(&i2c->dev, ARRAY_SIZE(rt5665_supply_names),
+					     rt5665_supply_names);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
 		return ret;
 	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(rt5665->supplies),
-				    rt5665->supplies);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
-		return ret;
-	}
-
-
 	rt5665->gpiod_ldo1_en = devm_gpiod_get_optional(&i2c->dev,
 							"realtek,ldo1-en",
 							GPIOD_OUT_HIGH);
diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index 86df5152c547..560a2c04b695 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -1875,7 +1875,7 @@ static int wsa884x_get_temp(struct wsa884x_priv *wsa884x, long *temp)
 		 * Reading temperature is possible only when Power Amplifier is
 		 * off. Report last cached data.
 		 */
-		*temp = wsa884x->temperature;
+		*temp = wsa884x->temperature * 1000;
 		return 0;
 	}
 
@@ -1934,7 +1934,7 @@ static int wsa884x_get_temp(struct wsa884x_priv *wsa884x, long *temp)
 	if ((val > WSA884X_LOW_TEMP_THRESHOLD) &&
 	    (val < WSA884X_HIGH_TEMP_THRESHOLD)) {
 		wsa884x->temperature = val;
-		*temp = val;
+		*temp = val * 1000;
 		ret = 0;
 	} else {
 		ret = -EAGAIN;
diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index a7215bad6484..93dbe40008c0 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -738,6 +738,8 @@ static int imx_card_probe(struct platform_device *pdev)
 				data->dapm_routes[i].sink =
 					devm_kasprintf(&pdev->dev, GFP_KERNEL, "%d %s",
 						       i + 1, "Playback");
+				if (!data->dapm_routes[i].sink)
+					return -ENOMEM;
 				data->dapm_routes[i].source = "CPU-Playback";
 			}
 		}
@@ -755,6 +757,8 @@ static int imx_card_probe(struct platform_device *pdev)
 				data->dapm_routes[i].source =
 					devm_kasprintf(&pdev->dev, GFP_KERNEL, "%d %s",
 						       i + 1, "Capture");
+				if (!data->dapm_routes[i].source)
+					return -ENOMEM;
 				data->dapm_routes[i].sink = "CPU-Capture";
 			}
 		}
diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index d9d1e021f5b2..0f96cc45578d 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -182,6 +182,8 @@ static int j721e_configure_refclk(struct j721e_priv *priv,
 		clk_id = J721E_CLK_PARENT_48000;
 	else if (!(rate % 11025) && priv->pll_rates[J721E_CLK_PARENT_44100])
 		clk_id = J721E_CLK_PARENT_44100;
+	else if (!(rate % 11025) && priv->pll_rates[J721E_CLK_PARENT_48000])
+		clk_id = J721E_CLK_PARENT_48000;
 	else
 		return ret;
 
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index ab5cdc3337da..e91d4c4e1c16 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -13,7 +13,7 @@
 #endif
 #include "../include/asm/inat.h" /* __ignore_sync_check__ */
 #include "../include/asm/insn.h" /* __ignore_sync_check__ */
-#include "../include/linux/unaligned.h" /* __ignore_sync_check__ */
+#include <linux/unaligned.h> /* __ignore_sync_check__ */
 
 #include <linux/errno.h>
 #include <linux/kconfig.h>
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 777600822d8e..179f6b31cbd6 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2007,7 +2007,7 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 
 	obj->sym_map[src_sym_idx] = dst_sym_idx;
 
-	if (sym_type == STT_SECTION && dst_sym) {
+	if (sym_type == STT_SECTION && dst_sec) {
 		dst_sec->sec_sym_idx = dst_sym_idx;
 		dst_sym->st_value = 0;
 	}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3c3e5760e81b..286a2c0af02a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4153,7 +4153,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	 * It may also insert a UD2 after calling a __noreturn function.
 	 */
 	prev_insn = prev_insn_same_sec(file, insn);
-	if (prev_insn->dead_end &&
+	if (prev_insn && prev_insn->dead_end &&
 	    (insn->type == INSN_BUG ||
 	     (insn->type == INSN_JUMP_UNCONDITIONAL &&
 	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
@@ -4575,35 +4575,6 @@ static int validate_sls(struct objtool_file *file)
 	return warnings;
 }
 
-static bool ignore_noreturn_call(struct instruction *insn)
-{
-	struct symbol *call_dest = insn_call_dest(insn);
-
-	/*
-	 * FIXME: hack, we need a real noreturn solution
-	 *
-	 * Problem is, exc_double_fault() may or may not return, depending on
-	 * whether CONFIG_X86_ESPFIX64 is set.  But objtool has no visibility
-	 * to the kernel config.
-	 *
-	 * Other potential ways to fix it:
-	 *
-	 *   - have compiler communicate __noreturn functions somehow
-	 *   - remove CONFIG_X86_ESPFIX64
-	 *   - read the .config file
-	 *   - add a cmdline option
-	 *   - create a generic objtool annotation format (vs a bunch of custom
-	 *     formats) and annotate it
-	 */
-	if (!strcmp(call_dest->name, "exc_double_fault")) {
-		/* prevent further unreachable warnings for the caller */
-		insn->sym->warned = 1;
-		return true;
-	}
-
-	return false;
-}
-
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn, *prev_insn;
@@ -4620,7 +4591,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		prev_insn = prev_insn_same_sec(file, insn);
 		if (prev_insn && prev_insn->dead_end) {
 			call_dest = insn_call_dest(prev_insn);
-			if (call_dest && !ignore_noreturn_call(prev_insn)) {
+			if (call_dest) {
 				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
 					  call_dest->name);
 				warnings++;
@@ -4643,6 +4614,8 @@ static int disas_funcs(const char *funcs)
 	char *cmd;
 
 	cross_compile = getenv("CROSS_COMPILE");
+	if (!cross_compile)
+		cross_compile = "";
 
 	objdump_str = "%sobjdump -wdr %s | gawk -M -v _funcs='%s' '"
 			"BEGIN { split(_funcs, funcs); }"
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 2ce71d2e5fae..b102a4c525e4 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -513,13 +513,14 @@ ifeq ($(feature-setns), 1)
   $(call detected,CONFIG_SETNS)
 endif
 
+ifeq ($(feature-reallocarray), 0)
+  CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
+endif
+
 ifdef CORESIGHT
   $(call feature_check,libopencsd)
   ifeq ($(feature-libopencsd), 1)
     CFLAGS += -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
-    ifeq ($(feature-reallocarray), 0)
-      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
-    endif
     LDFLAGS += $(LIBOPENCSD_LDFLAGS)
     EXTLIBS += $(OPENCSDLIBS)
     $(call detected,CONFIG_LIBOPENCSD)
@@ -1135,9 +1136,6 @@ ifndef NO_AUXTRACE
   ifndef NO_AUXTRACE
     $(call detected,CONFIG_AUXTRACE)
     CFLAGS += -DHAVE_AUXTRACE_SUPPORT
-    ifeq ($(feature-reallocarray), 0)
-      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
-    endif
   endif
 endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9dd2e8d3f3c9..8ee59ecb1411 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -164,7 +164,7 @@ ifneq ($(OUTPUT),)
 VPATH += $(OUTPUT)
 export VPATH
 # create symlink to the original source
-SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
+SOURCE := $(shell ln -sfn $(srctree)/tools/perf $(OUTPUT)/source)
 endif
 
 ifeq ($(V),1)
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index ea4dfc07cbd6..e7dc216f717f 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -22,8 +22,7 @@
 #define __NR_fork -1
 #endif
 
-#define LOOPS_DEFAULT 10000000
-static	int loops = LOOPS_DEFAULT;
+static	int loops;
 
 static const struct option options[] = {
 	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
@@ -80,6 +79,18 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 	const char *name = NULL;
 	int i;
 
+	switch (syscall) {
+	case __NR_fork:
+	case __NR_execve:
+		/* Limit default loop to 10000 times to save time */
+		loops = 10000;
+		break;
+	default:
+		loops = 10000000;
+		break;
+	}
+
+	/* Options -l and --loops override default above */
 	argc = parse_options(argc, argv, options, bench_syscall_usage, 0);
 
 	gettimeofday(&start, NULL);
@@ -94,16 +105,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 			break;
 		case __NR_fork:
 			test_fork();
-			/* Only loop 10000 times to save time */
-			if (i == 10000)
-				loops = 10000;
 			break;
 		case __NR_execve:
 			test_execve();
-			/* Only loop 10000 times to save time */
-			if (i == 10000)
-				loops = 10000;
-			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 645deec294c8..8700c3968066 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1551,12 +1551,12 @@ int cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
+repeat:
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
 	symbol_conf.skip_empty = report.skip_empty;
 
-repeat:
 	perf_tool__init(&report.tool, ordered_events);
 	report.tool.sample		 = process_sample_event;
 	report.tool.mmap		 = perf_event__process_mmap;
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
index c5d1d22bd034..5228f94a793f 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
@@ -229,19 +229,19 @@
     },
     {
         "MetricName": "slots_lost_misspeculation_fraction",
-        "MetricExpr": "(OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
+        "MetricExpr": "100 * (OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
         "BriefDescription": "Fraction of slots lost due to misspeculation",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
-        "ScaleUnit": "100percent of slots"
+        "ScaleUnit": "1percent of slots"
     },
     {
         "MetricName": "retired_fraction",
-        "MetricExpr": "OP_RETIRED / (CPU_CYCLES * #slots)",
+        "MetricExpr": "100 * OP_RETIRED / (CPU_CYCLES * #slots)",
         "BriefDescription": "Fraction of slots retiring, useful work",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
-        "ScaleUnit": "100percent of slots"
+        "ScaleUnit": "1percent of slots"
     },
     {
         "MetricName": "backend_core",
@@ -266,7 +266,7 @@
     },
     {
         "MetricName": "frontend_bandwidth",
-        "MetricExpr": "frontend_bound - frontend_latency",
+        "MetricExpr": "frontend_bound - 100 * frontend_latency",
         "BriefDescription": "Fraction of slots the CPU did not dispatch at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
         "MetricGroup": "TopdownL2",
         "ScaleUnit": "1percent of slots"
diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
index 75cf084a927d..577760046772 100644
--- a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
@@ -26,3 +26,5 @@ skip:
 	mov	x0, #0
 	mov	x8, #93 // __NR_exit syscall
 	svc	#0
+
+.section .note.GNU-stack, "", @progbits
diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index 1b58ccc1fd88..4d6c3c1b7fb9 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -89,7 +89,7 @@ test_bpf_filter_fail() {
 test_bpf_filter_group() {
   echo "Group bpf-filter test"
 
-  if ! perf record -e task-clock --filter 'period > 1000 || ip > 0' \
+  if ! perf record -e task-clock --filter 'period > 1000, ip > 0' \
 	  -o /dev/null true 2>/dev/null
   then
     echo "Group bpf-filter test [Failed should succeed]"
@@ -97,7 +97,7 @@ test_bpf_filter_group() {
     return
   fi
 
-  if ! perf record -e task-clock --filter 'cpu > 0 || ip > 0' \
+  if ! perf record -e task-clock --filter 'period > 1000 , cpu > 0 || ip > 0' \
 	  -o /dev/null true 2>&1 | grep -q PERF_SAMPLE_CPU
   then
     echo "Group bpf-filter test [Failed forbidden CPU]"
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 138ffc71b32d..2c06f2a85400 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -37,6 +37,8 @@
 #include "../../arch/arm64/include/asm/cputype.h"
 #define MAX_TIMESTAMP (~0ULL)
 
+#define is_ldst_op(op)		(!!((op) & ARM_SPE_OP_LDST))
+
 struct arm_spe {
 	struct auxtrace			auxtrace;
 	struct auxtrace_queues		queues;
@@ -520,6 +522,10 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
 	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
 	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
 
+	/* Only synthesize data source for LDST operations */
+	if (!is_ldst_op(record->op))
+		return 0;
+
 	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
 	else if (record->op & ARM_SPE_OP_ST)
@@ -619,7 +625,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 	 * When data_src is zero it means the record is not a memory operation,
 	 * skip to synthesize memory sample for this case.
 	 */
-	if (spe->sample_memory && data_src) {
+	if (spe->sample_memory && is_ldst_op(record->op)) {
 		err = arm_spe__synth_mem_sample(speq, spe->memory_id, data_src);
 		if (err)
 			return err;
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index f313404f95a9..6aa65ade3385 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -76,7 +76,7 @@ static int path_or_error(void)
 num_dec		[0-9]+
 num_hex		0[Xx][0-9a-fA-F]+
 space		[ \t]+
-path		[^ \t\n]+
+path		[^ \t\n,]+
 ident		[_a-zA-Z][_a-zA-Z0-9]+
 
 %%
diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 49b79cf0c5cc..8aa456d7c2cd 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -5,6 +5,8 @@
 #include <internal/rc_check.h>
 #include <linux/refcount.h>
 #include <linux/zalloc.h>
+#include <tools/libc_compat.h> // reallocarray
+
 #include "rwsem.h"
 
 DECLARE_RC_STRUCT(comm_str) {
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index d633d15329fa..e56330c85fe7 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -46,8 +46,8 @@ int debug_type_profile;
 FILE *debug_file(void)
 {
 	if (!_debug_file) {
-		pr_warning_once("debug_file not set");
 		debug_set_file(stderr);
+		pr_warning_once("debug_file not set");
 	}
 	return _debug_file;
 }
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index bb8e8f444054..c0472a41147c 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -808,7 +808,9 @@ static inline bool dso__is_kcore(const struct dso *dso)
 
 static inline bool dso__is_kallsyms(const struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->kernel && RC_CHK_ACCESS(dso)->long_name[0] != '/';
+	enum dso_binary_type bt = dso__binary_type(dso);
+
+	return bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS;
 }
 
 bool dso__is_object_file(const struct dso *dso);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a9df84692d4a..dac87dccaaaa 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1434,19 +1434,18 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 	 */
 	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
-		goto out;
+		return -ENOMEM;
 
 	threads = perf_thread_map__new_dummy();
-	if (!threads)
-		goto out_put;
+	if (!threads) {
+		perf_cpu_map__put(cpus);
+		return -ENOMEM;
+	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-
 	perf_thread_map__put(threads);
-out_put:
 	perf_cpu_map__put(cpus);
-out:
-	return -ENOMEM;
+	return 0;
 }
 
 int evlist__open(struct evlist *evlist)
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 50a3c3e07160..2c421b475b3b 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -254,7 +254,7 @@ int tpebs_start(struct evlist *evsel_list)
 		new = zalloc(sizeof(*new));
 		if (!new) {
 			ret = -1;
-			zfree(name);
+			zfree(&name);
 			goto err;
 		}
 		new->name = name;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ed893c3c6ad9..8b4e346808b4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -593,7 +593,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			};
 			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
 							 update_alias, &data) == 0)
-				pmu->cpu_json_aliases++;
+				pmu->cpu_common_json_aliases++;
 		}
 		pmu->sysfs_aliases++;
 		break;
@@ -1807,9 +1807,10 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	if (pmu->cpu_aliases_added)
 		 nr += pmu->cpu_json_aliases;
 	else if (pmu->events_table)
-		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->cpu_json_aliases;
+		nr += pmu_events_table__num_events(pmu->events_table, pmu) -
+			pmu->cpu_common_json_aliases;
 	else
-		assert(pmu->cpu_json_aliases == 0);
+		assert(pmu->cpu_json_aliases == 0 && pmu->cpu_common_json_aliases == 0);
 
 	return pmu->selectable ? nr + 1 : nr;
 }
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 4397c48ad569..bcd278b9b546 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -131,6 +131,11 @@ struct perf_pmu {
 	uint32_t cpu_json_aliases;
 	/** @sys_json_aliases: Number of json event aliases loaded matching the PMU's identifier. */
 	uint32_t sys_json_aliases;
+	/**
+	 * @cpu_common_json_aliases: Number of json events that overlapped with sysfs when
+	 * loading all sysfs events.
+	 */
+	uint32_t cpu_common_json_aliases;
 	/** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
 	bool sysfs_aliases_loaded;
 	/**
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index d7d67e09d759..362596ed2729 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -701,11 +701,25 @@ char *perf_pmus__default_pmu_name(void)
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
+	bool legacy_core_type;
 
-	if (!pmu) {
-		pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-		((struct evsel *)evsel)->pmu = pmu;
+	if (pmu)
+		return pmu;
+
+	pmu = perf_pmus__find_by_type(evsel->core.attr.type);
+	legacy_core_type =
+		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
+		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
+	if (!pmu && legacy_core_type) {
+		if (perf_pmus__supports_extended_type()) {
+			u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+
+			pmu = perf_pmus__find_by_type(type);
+		} else {
+			pmu = perf_pmus__find_core_pmu();
+		}
 	}
+	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ee3d43a7ba45..e7f36ea9e2fa 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -79,7 +79,7 @@ struct pyrf_event {
 };
 
 #define sample_members \
-	sample_member_def(sample_ip, ip, T_ULONGLONG, "event type"),			 \
+	sample_member_def(sample_ip, ip, T_ULONGLONG, "event ip"),			 \
 	sample_member_def(sample_pid, pid, T_INT, "event pid"),			 \
 	sample_member_def(sample_tid, tid, T_INT, "event tid"),			 \
 	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		 \
@@ -512,6 +512,11 @@ static PyObject *pyrf_event__new(union perf_event *event)
 	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE))
 		return NULL;
 
+	// FIXME this better be dynamic or we need to parse everything
+	// before calling perf_mmap__consume(), including tracepoint fields.
+	if (sizeof(pevent->event) < event->header.size)
+		return NULL;
+
 	ptype = pyrf_event__type[event->header.type];
 	pevent = PyObject_New(struct pyrf_event, ptype);
 	if (pevent != NULL)
@@ -1011,20 +1016,22 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 
 		evsel = evlist__event2evsel(evlist, event);
 		if (!evsel) {
+			Py_DECREF(pyevent);
 			Py_INCREF(Py_None);
 			return Py_None;
 		}
 
 		pevent->evsel = evsel;
 
-		err = evsel__parse_sample(evsel, event, &pevent->sample);
-
-		/* Consume the even only after we parsed it out. */
 		perf_mmap__consume(&md->core);
 
-		if (err)
+		err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
+		if (err) {
+			Py_DECREF(pyevent);
 			return PyErr_Format(PyExc_OSError,
 					    "perf: can't parse sample, err=%d", err);
+		}
+
 		return pyevent;
 	}
 end:
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 99376c12dd8e..7c49997fab3a 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -154,6 +154,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 {
 	const struct evsel *cur;
 	int evsel_ctx = evsel_context(evsel);
+	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
 
 	evlist__for_each_entry(evsel->evlist, cur) {
 		struct perf_stat_aggr *aggr;
@@ -180,7 +181,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 		 * Except the SW CLOCK events,
 		 * ignore if not the PMU we're looking for.
 		 */
-		if ((type != STAT_NSECS) && (evsel->pmu != cur->pmu))
+		if ((type != STAT_NSECS) && (evsel_pmu != evsel__find_pmu(cur)))
 			continue;
 
 		aggr = &cur->stats->aggr[aggr_idx];
diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
index 32c39cfe209b..4c6a86e1cb54 100644
--- a/tools/perf/util/units.c
+++ b/tools/perf/util/units.c
@@ -64,7 +64,7 @@ unsigned long convert_unit(unsigned long value, char *unit)
 
 int unit_number__scnprintf(char *buf, size_t size, u64 n)
 {
-	char unit[4] = "BKMG";
+	char unit[] = "BKMG";
 	int i = 0;
 
 	while (((n / 1024) > 1) && (i < 3)) {
diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 56c7ff6efcda..a3cf1d17163a 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -168,6 +168,8 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBPkgTmp\fP Degrees Celsius reported by the per-package Package Thermal Monitor.
 .PP
+\fBCoreThr\fP Core Thermal Throttling events during the measurement interval.  Note that events since boot can be find in /sys/devices/system/cpu/cpu*/thermal_throttle/*
+.PP
 \fBGFX%rc6\fP The percentage of time the GPU is in the "render C6" state, rc6, during the measurement interval. From /sys/class/drm/card0/power/rc6_residency_ms or /sys/class/drm/card0/gt/gt0/rc6_residency_ms or /sys/class/drm/card0/device/tile0/gtN/gtidle/idle_residency_ms depending on the graphics driver being used.
 .PP
 \fBGFXMHz\fP Instantaneous snapshot of what sysfs presents at the end of the measurement interval. From /sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz or /sys/class/drm/card0/gt_cur_freq_mhz or /sys/class/drm/card0/gt/gt0/rps_cur_freq_mhz or /sys/class/drm/card0/device/tile0/gtN/freq0/cur_freq depending on the graphics driver being used.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 235e82fe7d0a..77ef60980ee5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3242,7 +3242,7 @@ void delta_core(struct core_data *new, struct core_data *old)
 	old->c6 = new->c6 - old->c6;
 	old->c7 = new->c7 - old->c7;
 	old->core_temp_c = new->core_temp_c;
-	old->core_throt_cnt = new->core_throt_cnt;
+	old->core_throt_cnt = new->core_throt_cnt - old->core_throt_cnt;
 	old->mc6_us = new->mc6_us - old->mc6_us;
 
 	DELTA_WRAP32(new->core_energy.raw_value, old->core_energy.raw_value);
diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index cc184e4420f6..67557cda2208 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -6,6 +6,10 @@
 #include <test_progs.h>
 #include "bloom_filter_map.skel.h"
 
+#ifndef NUMA_NO_NODE
+#define NUMA_NO_NODE	(-1)
+#endif
+
 static void test_fail_cases(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts);
@@ -69,6 +73,7 @@ static void test_success_cases(void)
 
 	/* Create a map */
 	opts.map_flags = BPF_F_ZERO_SEED | BPF_F_NUMA_NODE;
+	opts.numa_node = NUMA_NO_NODE;
 	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 100, &opts);
 	if (!ASSERT_GE(fd, 0, "bpf_map_create bloom filter success case"))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 40f22454cf05..1f0977742741 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1599,6 +1599,7 @@ static void test_tailcall_bpf2bpf_freplace(void)
 		goto out;
 
 	err = bpf_link__destroy(freplace_link);
+	freplace_link = NULL;
 	if (!ASSERT_OK(err, "destroy link"))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/progs/strncmp_bench.c b/tools/testing/selftests/bpf/progs/strncmp_bench.c
index 18373a7df76e..f47bf88f8d2a 100644
--- a/tools/testing/selftests/bpf/progs/strncmp_bench.c
+++ b/tools/testing/selftests/bpf/progs/strncmp_bench.c
@@ -35,7 +35,10 @@ static __always_inline int local_strncmp(const char *s1, unsigned int sz,
 SEC("tp/syscalls/sys_enter_getpgid")
 int strncmp_no_helper(void *ctx)
 {
-	if (local_strncmp(str, cmp_str_len + 1, target) < 0)
+	const char *target_str = target;
+
+	barrier_var(target_str);
+	if (local_strncmp(str, cmp_str_len + 1, target_str) < 0)
 		__sync_add_and_fetch(&hits, 1);
 	return 0;
 }
diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 1238e1c5aae1..d87c5b1763ff 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -876,7 +876,7 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		mremap_size = thpsize / 2;
 		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
 				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-		if (mem == MAP_FAILED) {
+		if (mremap_mem == MAP_FAILED) {
 			ksft_test_result_fail("mmap() failed\n");
 			goto munmap;
 		}
diff --git a/tools/testing/selftests/net/netfilter/br_netfilter.sh b/tools/testing/selftests/net/netfilter/br_netfilter.sh
index c28379a965d8..1559ba275105 100755
--- a/tools/testing/selftests/net/netfilter/br_netfilter.sh
+++ b/tools/testing/selftests/net/netfilter/br_netfilter.sh
@@ -13,6 +13,12 @@ source lib.sh
 
 checktool "nft --version" "run test without nft tool"
 
+read t < /proc/sys/kernel/tainted
+if [ "$t" -ne 0 ];then
+	echo SKIP: kernel is tainted
+	exit $ksft_skip
+fi
+
 cleanup() {
 	cleanup_all_ns
 }
@@ -165,6 +171,7 @@ if [ "$t" -eq 0 ];then
 	echo PASS: kernel not tainted
 else
 	echo ERROR: kernel is tainted
+	dmesg
 	ret=1
 fi
 
diff --git a/tools/testing/selftests/net/netfilter/br_netfilter_queue.sh b/tools/testing/selftests/net/netfilter/br_netfilter_queue.sh
index 6a764d70ab06..4788641717d9 100755
--- a/tools/testing/selftests/net/netfilter/br_netfilter_queue.sh
+++ b/tools/testing/selftests/net/netfilter/br_netfilter_queue.sh
@@ -4,6 +4,12 @@ source lib.sh
 
 checktool "nft --version" "run test without nft tool"
 
+read t < /proc/sys/kernel/tainted
+if [ "$t" -ne 0 ];then
+	echo SKIP: kernel is tainted
+	exit $ksft_skip
+fi
+
 cleanup() {
 	cleanup_all_ns
 }
@@ -72,6 +78,7 @@ if [ "$t" -eq 0 ];then
 	echo PASS: kernel not tainted
 else
 	echo ERROR: kernel is tainted
+	dmesg
 	exit 1
 fi
 
diff --git a/tools/testing/selftests/net/netfilter/nft_queue.sh b/tools/testing/selftests/net/netfilter/nft_queue.sh
index a9d109fcc15c..00fe1a6c1f30 100755
--- a/tools/testing/selftests/net/netfilter/nft_queue.sh
+++ b/tools/testing/selftests/net/netfilter/nft_queue.sh
@@ -593,6 +593,7 @@ EOF
 		echo "PASS: queue program exiting while packets queued"
 	else
 		echo "TAINT: queue program exiting while packets queued"
+		dmesg
 		ret=1
 	fi
 }

