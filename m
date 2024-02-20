Return-Path: <stable+bounces-21520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50B085C940
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B561F22305
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5D151CD6;
	Tue, 20 Feb 2024 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vRCER3NL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130014A4D2;
	Tue, 20 Feb 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464671; cv=none; b=SLRRzh5Ia3mny+6DADQCdNzJKNT988F4OO5/3hxGUdqC35hl/hAgT7cUOXdRfCKVDctKuJon3fSc7ZETlXGtoy7rjB5bddH/DhTpV6R+htuwLBGZjXHK70pS2Y5VHvtfINsDDn0BMerBjUzq4UwlnT/8aOfHWwo/df41pOBuRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464671; c=relaxed/simple;
	bh=szW7cMHZrNebYsmUQ1FKdlOXf88QYo5FovpnF/ljHY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iom3Bda4TfN03T2UcZFtrsyhLlBt8N17ZGpMI2jkbEBq5mgs7ZED+0YSRW4WmC+ajAcSzhgUd9I6ayVqtedmy63Z4HiWMcfjm+ri3xVLn7YLd9D49WQvQd/LYCVzzlDeCtFlJGzGcKActGEaItoy/g9cQXGRR/VTquo+Ii7fdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vRCER3NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E38AC433F1;
	Tue, 20 Feb 2024 21:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464671;
	bh=szW7cMHZrNebYsmUQ1FKdlOXf88QYo5FovpnF/ljHY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRCER3NLE2yev8HFBtueGeQOmreCV56QDtPy3Ba2oslfP4R/z9z91MUEqTBtEF9f4
	 KF5JW/9cfjQQiNRgiy6mTFANgiUJO/3yRuNb9rztBRvdPsP69sdGPApcA981Njcwap
	 WOo2OJnopaHjqP9H9FzZYzPgTuZMbUxwYlUBVmxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 059/309] ptrace: Introduce exception_ip arch hook
Date: Tue, 20 Feb 2024 21:53:38 +0100
Message-ID: <20240220205635.069190996@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit 11ba1728be3edb6928791f4c622f154ebe228ae6 ]

On architectures with delay slot, architecture level instruction
pointer (or program counter) in pt_regs may differ from where
exception was triggered.

Introduce exception_ip hook to invoke architecture code and determine
actual instruction pointer to the exception.

Link: https://lore.kernel.org/lkml/00d1b813-c55f-4365-8d81-d70258e10b16@app.fastmail.com/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Stable-dep-of: 8fa507083388 ("mm/memory: Use exception ip to search exception tables")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/ptrace.h | 2 ++
 arch/mips/kernel/ptrace.c      | 7 +++++++
 include/linux/ptrace.h         | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index daf3cf244ea9..701a233583c2 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -154,6 +154,8 @@ static inline long regs_return_value(struct pt_regs *regs)
 }
 
 #define instruction_pointer(regs) ((regs)->cp0_epc)
+extern unsigned long exception_ip(struct pt_regs *regs);
+#define exception_ip(regs) exception_ip(regs)
 #define profile_pc(regs) instruction_pointer(regs)
 
 extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index d9df543f7e2c..59288c13b581 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -31,6 +31,7 @@
 #include <linux/seccomp.h>
 #include <linux/ftrace.h>
 
+#include <asm/branch.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
@@ -48,6 +49,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+unsigned long exception_ip(struct pt_regs *regs)
+{
+	return exception_epc(regs);
+}
+EXPORT_SYMBOL(exception_ip);
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index eaaef3ffec22..90507d4afcd6 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -393,6 +393,10 @@ static inline void user_single_step_report(struct pt_regs *regs)
 #define current_user_stack_pointer() user_stack_pointer(current_pt_regs())
 #endif
 
+#ifndef exception_ip
+#define exception_ip(x) instruction_pointer(x)
+#endif
+
 extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
 
 extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact);
-- 
2.43.0




