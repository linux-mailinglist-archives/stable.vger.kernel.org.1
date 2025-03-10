Return-Path: <stable+bounces-122232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B22A59EB5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44E93AB03D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C8522FF40;
	Mon, 10 Mar 2025 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kAMGF5r/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF62253FE;
	Mon, 10 Mar 2025 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627905; cv=none; b=WcqdRev1o32rcYnNO1js7DLsaYXC3ONgF8VaXdRkV8WM+G0VPupWGiYdAP5+7kbPdCo/54Qffa/dFW4W6Tyfh+KTY1dP/W1UEdhb2FCpBBBOVKeMQAeM8OdPUeTZYDoTMwLQECoH/hZpLpWL+iH/8fLEW5MtlpoH2j1pQZMirGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627905; c=relaxed/simple;
	bh=yyrHDpfsZMFhqfeBn9BR9U3ootYguqpT51wvxg+6o94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNLfXQCj0EGQngXu2ohKS9i9nJPuqcNgCtRS8XT2l1wD7IaPOBVB7ByRr7ngUv+DEijBeIg/7jeiaWQF2eyw+Ji3xzDMqct7fyDaH61Ei9PFv/csWmp+Sz4m/eaBZI9m8H3gDAb8j2VOa+K9hwlZ28YDmnFoo8unn4EcVxXz6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kAMGF5r/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F71DC4CEE5;
	Mon, 10 Mar 2025 17:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627904;
	bh=yyrHDpfsZMFhqfeBn9BR9U3ootYguqpT51wvxg+6o94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAMGF5r/XmDL74fwbjpI5ghdo6PxyqXWY8/V0LQYdFosF1N5MDxWQOudHUyehEUZ8
	 pslu5aaaeajRxgCegtHrFhHYebtSaJiu3RGvU52f+oqoC+aCZvvt4vk5q0NHKy157H
	 b0V414Qlquf0SAjJ2T8aSxoaFxfaszOZbaC/gh+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 020/145] RISC-V: Enable cbo.zero in usermode
Date: Mon, 10 Mar 2025 18:05:14 +0100
Message-ID: <20250310170435.556027990@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Jones <ajones@ventanamicro.com>

[ Upstream commit 43c16d51a19b0ba2ed66978d5924d486ec1e42bc ]

When Zicboz is present, enable its instruction (cbo.zero) in
usermode by setting its respective senvcfg bit. We don't bother
trying to set this bit per-task, which would also require an
interface for tasks to request enabling and/or disabling. Instead,
permanently set the bit for each hart which has the extension when
bringing it online.

This patch also introduces riscv_cpu_has_extension_[un]likely()
functions to check a specific hart's ISA bitmap for extensions.
Prior to checking the specific hart's bitmap in these functions
we try the bitmap which represents the LCD of extensions, but only
when we know it will use its optimized, alternatives path by gating
its call on CONFIG_RISCV_ALTERNATIVE. When alternatives are used, the
compiler ensures that the invocation of the LCD search becomes a
constant true or false. When it's true, even the new functions will
completely vanish from their callsites. OTOH, when the LCD check is
false, we need to do a search of the hart's ISA bitmap. Had we also
checked the LCD bitmap without the use of alternatives, then we would
have ended up with two bitmap searches instead of one.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230918131518.56803-10-ajones@ventanamicro.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Stable-dep-of: 564fc8eb6f78 ("riscv: signal: fix signal_minsigstksz")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/cpufeature.h |  1 +
 arch/riscv/include/asm/csr.h        |  1 +
 arch/riscv/include/asm/hwcap.h      | 16 ++++++++++++++++
 arch/riscv/kernel/cpufeature.c      |  6 ++++++
 arch/riscv/kernel/setup.c           |  4 ++++
 arch/riscv/kernel/smpboot.c         |  4 ++++
 6 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index d0345bd659c94..13b7d35648a9c 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -31,5 +31,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 void check_unaligned_access(int cpu);
+void riscv_user_isa_enable(void);
 
 #endif
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 777cb8299551c..5fba25db82d2a 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -275,6 +275,7 @@
 #define CSR_SIE			0x104
 #define CSR_STVEC		0x105
 #define CSR_SCOUNTEREN		0x106
+#define CSR_SENVCFG		0x10a
 #define CSR_SSCRATCH		0x140
 #define CSR_SEPC		0x141
 #define CSR_SCAUSE		0x142
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index f4157034efa9c..e215d3399a179 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -70,6 +70,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/jump_label.h>
+#include <asm/cpufeature.h>
 
 unsigned long riscv_get_elf_hwcap(void);
 
@@ -137,6 +138,21 @@ riscv_has_extension_unlikely(const unsigned long ext)
 	return true;
 }
 
+static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsigned long ext)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely(ext))
+		return true;
+
+	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
+}
+
+static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsigned long ext)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikely(ext))
+		return true;
+
+	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
+}
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index bb5fb2b820a21..a6b6bbf3f8598 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -676,6 +676,12 @@ static int check_unaligned_access_boot_cpu(void)
 
 arch_initcall(check_unaligned_access_boot_cpu);
 
+void riscv_user_isa_enable(void)
+{
+	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
+		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
+}
+
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
  * Alternative patch sites consider 48 bits when determining when to patch
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ff802d100a571..89ff6395dadbc 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -26,6 +26,7 @@
 #include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable.h>
@@ -307,10 +308,13 @@ void __init setup_arch(char **cmdline_p)
 	riscv_fill_hwcap();
 	init_rt_signal_env();
 	apply_boot_alternatives();
+
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
 	    riscv_isa_extension_available(NULL, ZICBOM))
 		riscv_noncoherent_supported();
 	riscv_set_dma_cache_alignment();
+
+	riscv_user_isa_enable();
 }
 
 static int __init topology_init(void)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 1b8da4e40a4d6..d1b0a6fc3adfc 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -25,6 +25,8 @@
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
+
+#include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
 #include <asm/cpufeature.h>
 #include <asm/irq.h>
@@ -253,6 +255,8 @@ asmlinkage __visible void smp_callin(void)
 			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
 	}
 
+	riscv_user_isa_enable();
+
 	/*
 	 * Remote TLB flushes are ignored while the CPU is offline, so emit
 	 * a local TLB flush right now just in case.
-- 
2.39.5




