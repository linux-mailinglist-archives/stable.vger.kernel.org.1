Return-Path: <stable+bounces-74607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11497302B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D852287FE6
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45304188A28;
	Tue, 10 Sep 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZ4FbIKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E6EEC9;
	Tue, 10 Sep 2024 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962299; cv=none; b=H3oIEFN9+1uE37LfdTVs953I8EwcpuNvYfY+W19nIUrS3JxTH4CVws+fC8irivXa+/56vBKUruaj1SUB9IxWId+oUdY94vvAVfBsnb3gEcT1YGTvhgyqCtM+dgMr3Ebw4ZloACJ+fs07TvCwbcEjCVKDO2oLQ1br9NU6I8QStb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962299; c=relaxed/simple;
	bh=HECrWKUQsX9A7GhIvMCsLCu0FKRponCk6uTXaHZKBa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KT3hG0cNfmkaOYZ6Qrcsb2YYEs1VZAZ5OTcBWg1V47WJuXJyUsYOAjMJLbVsFXU43HN3bqXhdYpVwZgusJOUh+UdyhkzvzGG6DeAzNpUzgCoqzQMIIS5hVHwQDAtySPAAsSwQmSBEVd8v5QTx7BxMmtGtCuyVZKroBBRdtfyb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZ4FbIKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2159EC4CEC3;
	Tue, 10 Sep 2024 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962298;
	bh=HECrWKUQsX9A7GhIvMCsLCu0FKRponCk6uTXaHZKBa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZ4FbIKDkq6UFkBjyg+RaCqiT8lFWOiMGjp9g252EN4Snna49+AwCzN3QQkEZjTEC
	 KyJL3OWWx8Nb3mCfeJZk/sBgM++CcRs6AES+UYEIxT4x12C7fRUtgwYAoqn1YDR60y
	 8cBnLrd96Fpfrvfqud5hjHdVh7f4SkXqokwB/nqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>,
	syzbot+cfbcb82adf6d7279fd35@syzkaller.appspotmail.com,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 362/375] riscv: Fix RISCV_ALTERNATIVE_EARLY
Date: Tue, 10 Sep 2024 11:32:39 +0200
Message-ID: <20240910092634.777296413@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit 1ff95eb2bebda50c4c5406caaf201e0fcb24cc8f ]

RISCV_ALTERNATIVE_EARLY will issue sbi_ecall() very early in the boot
process, before the first memory mapping is setup so we can't have any
instrumentation happening here.

In addition, when the kernel is relocatable, we must also not issue any
relocation this early since they would have been patched virtually only.

So, instead of disabling instrumentation for the whole kernel/sbi.c file
and compiling it with -fno-pie, simply move __sbi_ecall() and
__sbi_base_ecall() into their own file where this is fixed.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Closes: https://lore.kernel.org/linux-riscv/20240813-pony-truck-3e7a83e9759e@spud/
Reported-by: syzbot+cfbcb82adf6d7279fd35@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-riscv/00000000000065062c061fcec37b@google.com/
Fixes: 1745cfafebdf ("riscv: don't use global static vars to store alternative data")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20240829165048.49756-1-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/sbi.h  | 20 ++++++++++-
 arch/riscv/kernel/Makefile    |  6 +++-
 arch/riscv/kernel/sbi.c       | 63 -----------------------------------
 arch/riscv/kernel/sbi_ecall.c | 48 ++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 65 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi_ecall.c

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 7cffd4ffecd0..7bd3746028c9 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -9,6 +9,7 @@
 
 #include <linux/types.h>
 #include <linux/cpumask.h>
+#include <linux/jump_label.h>
 
 #ifdef CONFIG_RISCV_SBI
 enum sbi_ext_id {
@@ -304,6 +305,7 @@ struct sbiret {
 };
 
 void sbi_init(void);
+long __sbi_base_ecall(int fid);
 struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
 			  unsigned long arg2, unsigned long arg3,
 			  unsigned long arg4, unsigned long arg5,
@@ -373,7 +375,23 @@ static inline unsigned long sbi_mk_version(unsigned long major,
 		| (minor & SBI_SPEC_VERSION_MINOR_MASK);
 }
 
-int sbi_err_map_linux_errno(int err);
+static inline int sbi_err_map_linux_errno(int err)
+{
+	switch (err) {
+	case SBI_SUCCESS:
+		return 0;
+	case SBI_ERR_DENIED:
+		return -EPERM;
+	case SBI_ERR_INVALID_PARAM:
+		return -EINVAL;
+	case SBI_ERR_INVALID_ADDRESS:
+		return -EFAULT;
+	case SBI_ERR_NOT_SUPPORTED:
+	case SBI_ERR_FAILURE:
+	default:
+		return -ENOTSUPP;
+	};
+}
 
 extern bool sbi_debug_console_available;
 int sbi_debug_console_write(const char *bytes, unsigned int num_bytes);
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 5b243d46f4b1..1d71002e4f7b 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -20,17 +20,21 @@ endif
 ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
 CFLAGS_alternative.o := -mcmodel=medany
 CFLAGS_cpufeature.o := -mcmodel=medany
+CFLAGS_sbi_ecall.o := -mcmodel=medany
 ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_sbi_ecall.o = $(CC_FLAGS_FTRACE)
 endif
 ifdef CONFIG_RELOCATABLE
 CFLAGS_alternative.o += -fno-pie
 CFLAGS_cpufeature.o += -fno-pie
+CFLAGS_sbi_ecall.o += -fno-pie
 endif
 ifdef CONFIG_KASAN
 KASAN_SANITIZE_alternative.o := n
 KASAN_SANITIZE_cpufeature.o := n
+KASAN_SANITIZE_sbi_ecall.o := n
 endif
 endif
 
@@ -86,7 +90,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
-obj-$(CONFIG_RISCV_SBI)		+= sbi.o
+obj-$(CONFIG_RISCV_SBI)		+= sbi.o sbi_ecall.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP)		+= sbi-ipi.o
 obj-$(CONFIG_SMP) += cpu_ops_sbi.o
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 837bdab2601b..1989b8cade1b 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -14,9 +14,6 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
-#define CREATE_TRACE_POINTS
-#include <asm/trace.h>
-
 /* default SBI version is 0.1 */
 unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
@@ -27,55 +24,6 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
 			   unsigned long start, unsigned long size,
 			   unsigned long arg4, unsigned long arg5) __ro_after_init;
 
-struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
-			  unsigned long arg2, unsigned long arg3,
-			  unsigned long arg4, unsigned long arg5,
-			  int fid, int ext)
-{
-	struct sbiret ret;
-
-	trace_sbi_call(ext, fid);
-
-	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
-	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
-	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
-	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
-	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
-	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
-	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
-	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
-	asm volatile ("ecall"
-		      : "+r" (a0), "+r" (a1)
-		      : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
-		      : "memory");
-	ret.error = a0;
-	ret.value = a1;
-
-	trace_sbi_return(ext, ret.error, ret.value);
-
-	return ret;
-}
-EXPORT_SYMBOL(__sbi_ecall);
-
-int sbi_err_map_linux_errno(int err)
-{
-	switch (err) {
-	case SBI_SUCCESS:
-		return 0;
-	case SBI_ERR_DENIED:
-		return -EPERM;
-	case SBI_ERR_INVALID_PARAM:
-		return -EINVAL;
-	case SBI_ERR_INVALID_ADDRESS:
-		return -EFAULT;
-	case SBI_ERR_NOT_SUPPORTED:
-	case SBI_ERR_FAILURE:
-	default:
-		return -ENOTSUPP;
-	};
-}
-EXPORT_SYMBOL(sbi_err_map_linux_errno);
-
 #ifdef CONFIG_RISCV_SBI_V01
 static unsigned long __sbi_v01_cpumask_to_hartmask(const struct cpumask *cpu_mask)
 {
@@ -535,17 +483,6 @@ long sbi_probe_extension(int extid)
 }
 EXPORT_SYMBOL(sbi_probe_extension);
 
-static long __sbi_base_ecall(int fid)
-{
-	struct sbiret ret;
-
-	ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
-	if (!ret.error)
-		return ret.value;
-	else
-		return sbi_err_map_linux_errno(ret.error);
-}
-
 static inline long sbi_get_spec_version(void)
 {
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
diff --git a/arch/riscv/kernel/sbi_ecall.c b/arch/riscv/kernel/sbi_ecall.c
new file mode 100644
index 000000000000..24aabb4fbde3
--- /dev/null
+++ b/arch/riscv/kernel/sbi_ecall.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Rivos Inc. */
+
+#include <asm/sbi.h>
+#define CREATE_TRACE_POINTS
+#include <asm/trace.h>
+
+long __sbi_base_ecall(int fid)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
+	if (!ret.error)
+		return ret.value;
+	else
+		return sbi_err_map_linux_errno(ret.error);
+}
+EXPORT_SYMBOL(__sbi_base_ecall);
+
+struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
+			  unsigned long arg2, unsigned long arg3,
+			  unsigned long arg4, unsigned long arg5,
+			  int fid, int ext)
+{
+	struct sbiret ret;
+
+	trace_sbi_call(ext, fid);
+
+	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
+	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
+	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
+	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
+	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
+	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
+	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
+	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
+	asm volatile ("ecall"
+		       : "+r" (a0), "+r" (a1)
+		       : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
+		       : "memory");
+	ret.error = a0;
+	ret.value = a1;
+
+	trace_sbi_return(ext, ret.error, ret.value);
+
+	return ret;
+}
+EXPORT_SYMBOL(__sbi_ecall);
-- 
2.43.0




