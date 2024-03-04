Return-Path: <stable+bounces-25837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDAB86FAB4
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFF11C2037E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F31012E54;
	Mon,  4 Mar 2024 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ensQXkG/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E98F7A
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537175; cv=none; b=rtjD9GKs2cnHw4QaAdSh39hAXsEYXOpQ30Cl4NfraW/BkCp/ajyo7udmkBVeLgbaZJl9Xtnf+DHDnprwXQ4cLeKp085F8ApX4JZMiYMpxkHoEbYV+WQtXwdepFFqnQKkWUyzalhZp+r/kXaXBNtDCN33rsKrygIwrK6QYyOcU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537175; c=relaxed/simple;
	bh=e4MlcfCtzjk5UuBX9A8w/8JxiJEJlFFITrR7cGvf2sg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iq5aoDf8ggra4rMly8zpuOtY61u5xq01U/ZKsP+JdZ9sH7HPDhKT/L1PnW6zYKW6ZzWF8PNjy700Z+yo8Xpolb7Le42Hf++SHx78zXvpdSd5dKv91y4tarVKzGaNUinRmAAhrOuCyPcNetOwxO+vONEufnRTEQDP1vxNkqZ2G1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ensQXkG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FA9C433F1;
	Mon,  4 Mar 2024 07:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709537174;
	bh=e4MlcfCtzjk5UuBX9A8w/8JxiJEJlFFITrR7cGvf2sg=;
	h=Subject:To:Cc:From:Date:From;
	b=ensQXkG/uzHHhjZJodOSXWw/1nuUJvArWuyuSIUK3+6eyi+oaoDxKERLBR77LuOuN
	 K22QfAEhTMfydpk0lXCOAfsRpZ+brUWSyBQvgSImVbClgW5blQ3GoMY7PZ59A1kLXb
	 IbqZhxQLzlQLKxTmbwHCCDIeDSD1firYlSfgX9rE=
Subject: FAILED: patch "[PATCH] riscv: add CALLER_ADDRx support" failed to apply to 5.4-stable tree
To: zong.li@sifive.com,alexghiti@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 08:26:11 +0100
Message-ID: <2024030411-default-joylessly-3437@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 680341382da56bd192ebfa4e58eaf4fec2e5bca7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030411-default-joylessly-3437@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

680341382da5 ("riscv: add CALLER_ADDRx support")
7ce047715030 ("riscv: Workaround mcount name prior to clang-13")
2f095504f4b9 ("scripts/recordmcount.pl: Fix RISC-V regex for clang")
5ad84adf5456 ("riscv: Fixup patch_text panic in ftrace")
67d945778099 ("riscv: Fixup wrong ftrace remove cflag")
043cb41a85de ("riscv: introduce interfaces to patch kernel code")
6bd33e1ece52 ("riscv: add nommu support")
a4c3733d32a7 ("riscv: abstract out CSR names for supervisor vs machine mode")
0c3ac28931d5 ("riscv: separate MMIO functions into their own header file")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 680341382da56bd192ebfa4e58eaf4fec2e5bca7 Mon Sep 17 00:00:00 2001
From: Zong Li <zong.li@sifive.com>
Date: Fri, 2 Feb 2024 01:51:02 +0000
Subject: [PATCH] riscv: add CALLER_ADDRx support

CALLER_ADDRx returns caller's address at specified level, they are used
for several tracers. These macros eventually use
__builtin_return_address(n) to get the caller's address if arch doesn't
define their own implementation.

In RISC-V, __builtin_return_address(n) only works when n == 0, we need
to walk the stack frame to get the caller's address at specified level.

data.level started from 'level + 3' due to the call flow of getting
caller's address in RISC-V implementation. If we don't have additional
three iteration, the level is corresponding to follows:

callsite -> return_address -> arch_stack_walk -> walk_stackframe
|           |                 |                  |
level 3     level 2           level 1            level 0

Fixes: 10626c32e382 ("riscv/ftrace: Add basic support")
Cc: stable@vger.kernel.org
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Link: https://lore.kernel.org/r/20240202015102.26251-1-zong.li@sifive.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 329172122952..15055f9df4da 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -25,6 +25,11 @@
 
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #ifndef __ASSEMBLY__
+
+extern void *return_address(unsigned int level);
+
+#define ftrace_return_address(n) return_address(n)
+
 void MCOUNT_NAME(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f71910718053..604d6bf7e476 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
 endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
 CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
@@ -46,6 +47,7 @@ obj-y	+= irq.o
 obj-y	+= process.o
 obj-y	+= ptrace.o
 obj-y	+= reset.o
+obj-y	+= return_address.o
 obj-y	+= setup.o
 obj-y	+= signal.o
 obj-y	+= syscall_table.o
diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/return_address.c
new file mode 100644
index 000000000000..c8115ec8fb30
--- /dev/null
+++ b/arch/riscv/kernel/return_address.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This code come from arch/arm64/kernel/return_address.c
+ *
+ * Copyright (C) 2023 SiFive.
+ */
+
+#include <linux/export.h>
+#include <linux/kprobes.h>
+#include <linux/stacktrace.h>
+
+struct return_address_data {
+	unsigned int level;
+	void *addr;
+};
+
+static bool save_return_addr(void *d, unsigned long pc)
+{
+	struct return_address_data *data = d;
+
+	if (!data->level) {
+		data->addr = (void *)pc;
+		return false;
+	}
+
+	--data->level;
+
+	return true;
+}
+NOKPROBE_SYMBOL(save_return_addr);
+
+noinline void *return_address(unsigned int level)
+{
+	struct return_address_data data;
+
+	data.level = level + 3;
+	data.addr = NULL;
+
+	arch_stack_walk(save_return_addr, &data, current, NULL);
+
+	if (!data.level)
+		return data.addr;
+	else
+		return NULL;
+
+}
+EXPORT_SYMBOL_GPL(return_address);
+NOKPROBE_SYMBOL(return_address);


