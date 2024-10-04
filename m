Return-Path: <stable+bounces-80890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29D990C62
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A001F26C20
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6A921C16F;
	Fri,  4 Oct 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz9OOnUJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08051F6893;
	Fri,  4 Oct 2024 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066187; cv=none; b=ovrh1sKCbKBB/XLs8HnbS8/U2Tz/Bhgve+4ki0FBgOcXTSUhA5o0JgvFrssdA8BoTQUMmFG056spp8B5KGP2AShhYzrB5wNf6Q0Fmp0wJAEMyGoKwD32dCtMFJRhVFOvho5EsK/j1rjFYatLrVVN9hAOLhP3roCZse+7QpVcuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066187; c=relaxed/simple;
	bh=/m74qJboX8ss96AC87m5nieucOTge5xzLpgbbdWJKtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClQhLHzhEjabQk1Xj1k+6+6NQmnCbPaCS3MU7cVhcgGwC+jERDRB0/9bpgsxT52Sb2W/jNyhFepacHJP/ZJB2cShMO4WXBAwLiusyYCcDKlXaioINGYoQ/SddfgbyHGaBBW7u9lTw3BizAEGtfgmlW7PMI2eqb6REmbPtDGV8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz9OOnUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6562DC4CEC6;
	Fri,  4 Oct 2024 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066187;
	bh=/m74qJboX8ss96AC87m5nieucOTge5xzLpgbbdWJKtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lz9OOnUJF8Qqd+sCtNJs+u6L5TeWPmdr+99Qky4kmhh4Vg/fnB2l3Kny1KJNRJ6No
	 kVrgIqyOdJOnYrPEwFhNWq6TPuaTHeBuXqfBtQhZIfHlcY3Hj2GbGiJGFc3jWa7Z+J
	 IzubdY6XKpoZHcfZy8hmA1xHxup2CR1f2qchcWsirUKMq3EXGaPvJIbzOPg05YEgUa
	 bluPQpXm9LhJuDKDIyYbDUgjVh/6XE0V2e68SrKSwso+ORHQdXoSLSdEBlM0No0LnT
	 DEltQDzSqOVjC04+RbRUX3Ia4CpmEpa2p51ReEm8R1LtuFKK4MSuRMor98TaCC3B11
	 malqOuLIHHfYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	andy.chiu@sifive.com,
	xiao.w.wang@intel.com,
	conor.dooley@microchip.com,
	greentime.hu@sifive.com,
	masahiroy@kernel.org,
	samitolvanen@google.com,
	kees@kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 34/70] riscv: Omit optimized string routines when using KASAN
Date: Fri,  4 Oct 2024 14:20:32 -0400
Message-ID: <20241004182200.3670903-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Samuel Holland <samuel.holland@sifive.com>

[ Upstream commit 58ff537109ac863d4ec83baf8413b17dcc10101c ]

The optimized string routines are implemented in assembly, so they are
not instrumented for use with KASAN. Fall back to the C version of the
routines in order to improve KASAN coverage. This fixes the
kasan_strings() unit test.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20240801033725.28816-2-samuel.holland@sifive.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/string.h | 2 ++
 arch/riscv/kernel/riscv_ksyms.c | 3 ---
 arch/riscv/lib/Makefile         | 2 ++
 arch/riscv/lib/strcmp.S         | 1 +
 arch/riscv/lib/strlen.S         | 1 +
 arch/riscv/lib/strncmp.S        | 1 +
 arch/riscv/purgatory/Makefile   | 2 ++
 7 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index a96b1fea24fe4..5ba77f60bf0b5 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -19,6 +19,7 @@ extern asmlinkage void *__memcpy(void *, const void *, size_t);
 extern asmlinkage void *memmove(void *, const void *, size_t);
 extern asmlinkage void *__memmove(void *, const void *, size_t);
 
+#if !(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 #define __HAVE_ARCH_STRCMP
 extern asmlinkage int strcmp(const char *cs, const char *ct);
 
@@ -27,6 +28,7 @@ extern asmlinkage __kernel_size_t strlen(const char *);
 
 #define __HAVE_ARCH_STRNCMP
 extern asmlinkage int strncmp(const char *cs, const char *ct, size_t count);
+#endif
 
 /* For those files which don't want to check by kasan. */
 #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index a72879b4249a5..5ab1c7e1a6ed5 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -12,9 +12,6 @@
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index bd6e6c1b0497b..07a7cc46ac740 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -3,9 +3,11 @@ lib-y			+= delay.o
 lib-y			+= memcpy.o
 lib-y			+= memset.o
 lib-y			+= memmove.o
+ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
 lib-y			+= strcmp.o
 lib-y			+= strlen.o
 lib-y			+= strncmp.o
+endif
 lib-y			+= csum.o
 ifeq ($(CONFIG_MMU), y)
 lib-$(CONFIG_RISCV_ISA_V)	+= uaccess_vector.o
diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
index 687b2bea5c438..542301a67a2ff 100644
--- a/arch/riscv/lib/strcmp.S
+++ b/arch/riscv/lib/strcmp.S
@@ -120,3 +120,4 @@ strcmp_zbb:
 .option pop
 #endif
 SYM_FUNC_END(strcmp)
+EXPORT_SYMBOL(strcmp)
diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
index 8ae3064e45ff0..962983b73251e 100644
--- a/arch/riscv/lib/strlen.S
+++ b/arch/riscv/lib/strlen.S
@@ -131,3 +131,4 @@ strlen_zbb:
 #endif
 SYM_FUNC_END(strlen)
 SYM_FUNC_ALIAS(__pi_strlen, strlen)
+EXPORT_SYMBOL(strlen)
diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
index aba5b3148621d..0f359ea2f55b2 100644
--- a/arch/riscv/lib/strncmp.S
+++ b/arch/riscv/lib/strncmp.S
@@ -136,3 +136,4 @@ strncmp_zbb:
 .option pop
 #endif
 SYM_FUNC_END(strncmp)
+EXPORT_SYMBOL(strncmp)
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index f11945ee24903..fb9c917c9b457 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
 purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
+ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
 purgatory-y += strcmp.o strlen.o strncmp.o
+endif
 
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
-- 
2.43.0


