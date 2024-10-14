Return-Path: <stable+bounces-84585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544399D0EB
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCAAB23964
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE91C1AA793;
	Mon, 14 Oct 2024 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZF4yS45/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6826296;
	Mon, 14 Oct 2024 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918514; cv=none; b=lzTGRM5NdATS3p5SXObtqY1kAV1TnPc7yseVXT1L3gF9S9BIEv3Qg+qdNJPTOi/QWzF5O3tEZYr1uj/3UV+j3JXebhss3RB/VIcDwjgWdFi11+4Bn+HAQf3D74Mst2nRWe/HeUsdbBImkPgO4Yz3t720gBY7t6vJZQ3IuE/zTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918514; c=relaxed/simple;
	bh=R0KuUGPFviW9e8N7MvliV03/SPS5VFOB0wXD6pr3Qiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I58pYiPS7VrxmbRaNRjl0yLXx9aV7vEJIrXV1eYoXfDT/n+S1ew6i7GcmgTmaSxOCIsIL6+YAa7yZ23cgctv1RePstHFbngRDtWxPNKuX/gIeRfX/9k25oZMoyhOjhybBy1ZT2InaeWpVIuVenWluW0jd4kxq+KT72zWeAX1JpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZF4yS45/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D488FC4CEC7;
	Mon, 14 Oct 2024 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918514;
	bh=R0KuUGPFviW9e8N7MvliV03/SPS5VFOB0wXD6pr3Qiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZF4yS45/E5uDO8EK2IGNddTC/8sqwgsaeV9uF9OMsX29ay0BTDt3mI61S6V+N8P6e
	 WXFtx6TZvTxCnZRae0e01ZPX6/3Gmz7eCn5d1tasX678XsUuEvqVLgEzAvbjDdpm5P
	 gVnO2rCi36GElEJgqhtkIBMHJuS0sR3xckNFGrc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 344/798] powerpc/64: Add support to build with prefixed instructions
Date: Mon, 14 Oct 2024 16:14:58 +0200
Message-ID: <20241014141231.463497103@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit dc5dac748af9087e9240bd2ae6ae7db48d5360ae ]

Add an option to build kernel and module with prefixed instructions if
the CPU and toolchain support it.

This is not related to kernel support for userspace execution of
prefixed instructions.

Building with prefixed instructions breaks some extended inline asm
memory addressing, for example it will provide immediates that exceed
the range of simple load/store displacement. Whether this is a
toolchain or a kernel asm problem remains to be seen. For now, these
are replaced with simpler and less efficient direct register addressing
when compiling with prefixed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230408021752.862660-4-npiggin@gmail.com
Stable-dep-of: 39190ac7cff1 ("powerpc/atomic: Use YZ constraints for DS-form instructions")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Kconfig                   |  3 +++
 arch/powerpc/Makefile                  |  4 +++
 arch/powerpc/include/asm/atomic.h      | 24 ++++++++++++++---
 arch/powerpc/include/asm/io.h          | 37 ++++++++++++++++++++++++++
 arch/powerpc/include/asm/uaccess.h     | 28 +++++++++++++++++--
 arch/powerpc/kernel/trace/ftrace.c     |  2 ++
 arch/powerpc/platforms/Kconfig.cputype | 20 ++++++++++++++
 7 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 345b8b4c60e1e..2fa9e87b06dc8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -4,6 +4,9 @@ source "arch/powerpc/platforms/Kconfig.cputype"
 config CC_HAS_ELFV2
 	def_bool PPC64 && $(cc-option, -mabi=elfv2)
 
+config CC_HAS_PREFIXED
+	def_bool PPC64 && $(cc-option, -mcpu=power10 -mprefixed)
+
 config 32BIT
 	bool
 	default y if PPC32
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 487e4967b60d2..d7332c6afeaac 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -176,7 +176,11 @@ ifdef CONFIG_476FPE_ERR46
 endif
 
 # No prefix or pcrel
+ifdef CONFIG_PPC_KERNEL_PREFIXED
+KBUILD_CFLAGS += $(call cc-option,-mprefixed)
+else
 KBUILD_CFLAGS += $(call cc-option,-mno-prefixed)
+endif
 KBUILD_CFLAGS += $(call cc-option,-mno-pcrel)
 
 # No AltiVec or VSX or MMA instructions when building kernel
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 486ab78891215..50212c44be2a9 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -27,14 +27,22 @@ static __inline__ int arch_atomic_read(const atomic_t *v)
 {
 	int t;
 
-	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
+	/* -mprefixed can generate offsets beyond range, fall back hack */
+	if (IS_ENABLED(CONFIG_PPC_KERNEL_PREFIXED))
+		__asm__ __volatile__("lwz %0,0(%1)" : "=r"(t) : "b"(&v->counter));
+	else
+		__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
 
 	return t;
 }
 
 static __inline__ void arch_atomic_set(atomic_t *v, int i)
 {
-	__asm__ __volatile__("stw%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
+	/* -mprefixed can generate offsets beyond range, fall back hack */
+	if (IS_ENABLED(CONFIG_PPC_KERNEL_PREFIXED))
+		__asm__ __volatile__("stw %1,0(%2)" : "=m"(v->counter) : "r"(i), "b"(&v->counter));
+	else
+		__asm__ __volatile__("stw%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
 }
 
 #define ATOMIC_OP(op, asm_op, suffix, sign, ...)			\
@@ -226,14 +234,22 @@ static __inline__ s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 t;
 
-	__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
+	/* -mprefixed can generate offsets beyond range, fall back hack */
+	if (IS_ENABLED(CONFIG_PPC_KERNEL_PREFIXED))
+		__asm__ __volatile__("ld %0,0(%1)" : "=r"(t) : "b"(&v->counter));
+	else
+		__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
 
 	return t;
 }
 
 static __inline__ void arch_atomic64_set(atomic64_t *v, s64 i)
 {
-	__asm__ __volatile__("std%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
+	/* -mprefixed can generate offsets beyond range, fall back hack */
+	if (IS_ENABLED(CONFIG_PPC_KERNEL_PREFIXED))
+		__asm__ __volatile__("std %1,0(%2)" : "=m"(v->counter) : "r"(i), "b"(&v->counter));
+	else
+		__asm__ __volatile__("std%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 6d3ce049babdf..6010e966b1499 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -97,6 +97,42 @@ extern bool isa_io_special;
  *
  */
 
+/* -mprefixed can generate offsets beyond range, fall back hack */
+#ifdef CONFIG_PPC_KERNEL_PREFIXED
+#define DEF_MMIO_IN_X(name, size, insn)				\
+static inline u##size name(const volatile u##size __iomem *addr)	\
+{									\
+	u##size ret;							\
+	__asm__ __volatile__("sync;"#insn" %0,0,%1;twi 0,%0,0;isync"	\
+		: "=r" (ret) : "r" (addr) : "memory");			\
+	return ret;							\
+}
+
+#define DEF_MMIO_OUT_X(name, size, insn)				\
+static inline void name(volatile u##size __iomem *addr, u##size val)	\
+{									\
+	__asm__ __volatile__("sync;"#insn" %1,0,%0"			\
+		: : "r" (addr), "r" (val) : "memory");			\
+	mmiowb_set_pending();						\
+}
+
+#define DEF_MMIO_IN_D(name, size, insn)				\
+static inline u##size name(const volatile u##size __iomem *addr)	\
+{									\
+	u##size ret;							\
+	__asm__ __volatile__("sync;"#insn" %0,0(%1);twi 0,%0,0;isync"\
+		: "=r" (ret) : "b" (addr) : "memory");	\
+	return ret;							\
+}
+
+#define DEF_MMIO_OUT_D(name, size, insn)				\
+static inline void name(volatile u##size __iomem *addr, u##size val)	\
+{									\
+	__asm__ __volatile__("sync;"#insn" %1,0(%0)"			\
+		: : "b" (addr), "r" (val) : "memory");	\
+	mmiowb_set_pending();						\
+}
+#else
 #define DEF_MMIO_IN_X(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
@@ -130,6 +166,7 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 		: "=m<>" (*addr) : "r" (val) : "memory");	\
 	mmiowb_set_pending();						\
 }
+#endif
 
 DEF_MMIO_IN_D(in_8,     8, lbz);
 DEF_MMIO_OUT_D(out_8,   8, stb);
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 661046150e49f..2d17f1193b25c 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -71,14 +71,26 @@ __pu_failed:							\
  * because we do not write to any memory gcc knows about, so there
  * are no aliasing issues.
  */
+/* -mprefixed can generate offsets beyond range, fall back hack */
+#ifdef CONFIG_PPC_KERNEL_PREFIXED
+#define __put_user_asm_goto(x, addr, label, op)			\
+	asm_volatile_goto(					\
+		"1:	" op " %0,0(%1)	# put_user\n"		\
+		EX_TABLE(1b, %l2)				\
+		:						\
+		: "r" (x), "b" (addr)				\
+		:						\
+		: label)
+#else
 #define __put_user_asm_goto(x, addr, label, op)			\
 	asm goto(					\
 		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
 		EX_TABLE(1b, %l2)				\
 		:						\
-		: "r" (x), "m<>" (*addr)		\
+		: "r" (x), "m<>" (*addr)			\
 		:						\
 		: label)
+#endif
 
 #ifdef CONFIG_CC_IS_CLANG
 #define DS_FORM_CONSTRAINT "Z<>"
@@ -142,14 +154,26 @@ do {								\
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
+/* -mprefixed can generate offsets beyond range, fall back hack */
+#ifdef CONFIG_PPC_KERNEL_PREFIXED
+#define __get_user_asm_goto(x, addr, label, op)			\
+	asm_volatile_goto(					\
+		"1:	"op" %0,0(%1)	# get_user\n"		\
+		EX_TABLE(1b, %l2)				\
+		: "=r" (x)					\
+		: "b" (addr)					\
+		:						\
+		: label)
+#else
 #define __get_user_asm_goto(x, addr, label, op)			\
 	asm_goto_output(					\
 		"1:	"op"%U1%X1 %0, %1	# get_user\n"	\
 		EX_TABLE(1b, %l2)				\
 		: "=r" (x)					\
-		: "m<>" (*addr)				\
+		: "m<>" (*addr)					\
 		:						\
 		: label)
+#endif
 
 #ifdef __powerpc64__
 #define __get_user_asm2_goto(x, addr, label)			\
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 7b85c3b460a3c..72864fb7a6ccd 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -194,6 +194,8 @@ __ftrace_make_nop(struct module *mod,
 	 * get corrupted.
 	 *
 	 * Use a b +8 to jump over the load.
+	 * XXX: could make PCREL depend on MPROFILE_KERNEL
+	 * XXX: check PCREL && MPROFILE_KERNEL calling sequence
 	 */
 	if (IS_ENABLED(CONFIG_MPROFILE_KERNEL) || IS_ENABLED(CONFIG_PPC32))
 		pop = ppc_inst(PPC_RAW_NOP());
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index ce88910d54cf0..8f3db66774577 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -176,6 +176,7 @@ config POWER10_CPU
 	bool "POWER10"
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_FAST_MULTIPLIER
+	select PPC_HAVE_PREFIXED_SUPPORT
 
 config E5500_CPU
 	bool "Freescale e5500"
@@ -449,6 +450,22 @@ config PPC_RADIX_MMU_DEFAULT
 
 	  If you're unsure, say Y.
 
+config PPC_KERNEL_PREFIXED
+	depends on PPC_HAVE_PREFIXED_SUPPORT
+	depends on CC_HAS_PREFIXED
+	default n
+	bool "Build Kernel with Prefixed Instructions"
+	help
+	  POWER10 and later CPUs support prefixed instructions, 8 byte
+	  instructions that include large immediate, pc relative addressing,
+	  and various floating point, vector, MMA.
+
+	  This option builds the kernel with prefixed instructions, and
+	  allows a pc relative addressing option to be selected.
+
+	  Kernel support for prefixed instructions in applications and guests
+	  is not affected by this option.
+
 config PPC_KUEP
 	bool "Kernel Userspace Execution Prevention" if !40x
 	default y if !40x
@@ -485,6 +502,9 @@ config PPC_MMU_NOHASH
 config PPC_HAVE_PMU_SUPPORT
 	bool
 
+config PPC_HAVE_PREFIXED_SUPPORT
+	bool
+
 config PMU_SYSFS
 	bool "Create PMU SPRs sysfs file"
 	default n
-- 
2.43.0




