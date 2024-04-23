Return-Path: <stable+bounces-40562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F48AE051
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 10:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF011C21022
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554C654BF9;
	Tue, 23 Apr 2024 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACqwC38t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B5847F51
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862383; cv=none; b=OyPol5RxQa/kusWg+Bn8u5TsDBAVmMgswvN5epS6QCuqw+YVlLNVEHouujLUNgFUyZs+80OukTxzF3UUfEaFIZwfJnuLelmvoUD6RwwzoH6OJBZfiwyjNodkvSEJXb4pQFeIPv5V7k5rLjXjeJPy1xrH83pzwz9KatxVicx4j5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862383; c=relaxed/simple;
	bh=vmGKk8QfbCJLHyA/vTdFNvla0GjMsTsITrM85VN3KT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCvZ32nGPIyzxt0yTMQwgAAe/ZOJPuMGpGsUqdfOW6qvBcNZbnKB2fGiOfIzs1MbliiP7ffCh3Uxk20dbV5FlHWwZFF4UeWiFp4mw6CrQgZ0vmVV4SYST6udvAQq8DSUNtcWe4kU/w0VmjOcGq3WKMLNov8yhJ9BZzD6BHv4BWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACqwC38t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CB3C2BD11;
	Tue, 23 Apr 2024 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713862382;
	bh=vmGKk8QfbCJLHyA/vTdFNvla0GjMsTsITrM85VN3KT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACqwC38tXGqS5kIY2MboEdPG4aGyGluSghRk3iXYJyCSn7qzw7gj84BhpFVa3mSqJ
	 XZ1w0cZoyYB98zUGISEoU2Mk/Mny1pRdxpkELLFNRqk83o5rU3HuqEshoimF5bL6NF
	 b557ZJRguxc4UzQK0AC5+ma0eXUviw6gpAmlGgSbfYkMCpotSlFQ1j9o4hvHc4zRmb
	 0OYVyxVMKZ0j46dPagtyxKMe1CXt67IVHTLEOUpHcL9ZH4V7MsV7aipct5qXQtii59
	 Yyizg+1VcEkfAFDMcMHFvpNkZOHVj9U9iek7QbBpn994Hf6uRQ3Rkme46CmEzk2o9k
	 iKCMnOCoMK73A==
From: Naveen N Rao <naveen@kernel.org>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] powerpc/ftrace: Ignore ftrace locations in exit text sections
Date: Tue, 23 Apr 2024 14:17:17 +0530
Message-ID: <20240423084717.286596-1-naveen@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024021902-authentic-handpick-da09@gregkh>
References: <2024021902-authentic-handpick-da09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ea73179e64131bcd29ba6defd33732abdf8ca14b upstream.

Michael reported that we are seeing an ftrace bug on bootup when KASAN
is enabled and we are using -fpatchable-function-entry:

  ftrace: allocating 47780 entries in 18 pages
  ftrace-powerpc: 0xc0000000020b3d5c: No module provided for non-kernel address
  ------------[ ftrace bug ]------------
  ftrace faulted on modifying
  [<c0000000020b3d5c>] 0xc0000000020b3d5c
  Initializing ftrace call sites
  ftrace record flags: 0
   (0)
   expected tramp: c00000000008cef4
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:2180 ftrace_bug+0x3c0/0x424
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0-rc3-00120-g0f71dcfb4aef #860
  Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1202 0xf000005 of:SLOF,HEAD hv:linux,kvm pSeries
  NIP:  c0000000003aa81c LR: c0000000003aa818 CTR: 0000000000000000
  REGS: c0000000033cfab0 TRAP: 0700   Not tainted  (6.5.0-rc3-00120-g0f71dcfb4aef)
  MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 28028240  XER: 00000000
  CFAR: c0000000002781a8 IRQMASK: 3
  ...
  NIP [c0000000003aa81c] ftrace_bug+0x3c0/0x424
  LR [c0000000003aa818] ftrace_bug+0x3bc/0x424
  Call Trace:
   ftrace_bug+0x3bc/0x424 (unreliable)
   ftrace_process_locs+0x5f4/0x8a0
   ftrace_init+0xc0/0x1d0
   start_kernel+0x1d8/0x484

With CONFIG_FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY=y and
CONFIG_KASAN=y, compiler emits nops in functions that it generates for
registering and unregistering global variables (unlike with -pg and
-mprofile-kernel where calls to _mcount() are not generated in those
functions). Those functions then end up in INIT_TEXT and EXIT_TEXT
respectively. We don't expect to see any profiled functions in
EXIT_TEXT, so ftrace_init_nop() assumes that all addresses that aren't
in the core kernel text belongs to a module. Since these functions do
not match that criteria, we see the above bug.

Address this by having ftrace ignore all locations in the text exit
sections of vmlinux.

Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-function-entry")
Cc: stable@vger.kernel.org # v6.6+
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
Reviewed-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240213175410.1091313-1-naveen@kernel.org
---
 arch/powerpc/include/asm/ftrace.h        | 10 ++--------
 arch/powerpc/include/asm/sections.h      |  1 +
 arch/powerpc/kernel/trace/ftrace.c       | 12 ++++++++++++
 arch/powerpc/kernel/trace/ftrace_64_pg.c |  5 +++++
 arch/powerpc/kernel/vmlinux.lds.S        |  2 ++
 5 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 9e5a39b6a311..107fc5a48456 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -20,14 +20,6 @@
 #ifndef __ASSEMBLY__
 extern void _mcount(void);
 
-static inline unsigned long ftrace_call_adjust(unsigned long addr)
-{
-	if (IS_ENABLED(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY))
-		addr += MCOUNT_INSN_SIZE;
-
-       return addr;
-}
-
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
 				    unsigned long sp);
 
@@ -142,8 +134,10 @@ static inline u8 this_cpu_get_ftrace_enabled(void) { return 1; }
 #ifdef CONFIG_FUNCTION_TRACER
 extern unsigned int ftrace_tramp_text[], ftrace_tramp_init[];
 void ftrace_free_init_tramp(void);
+unsigned long ftrace_call_adjust(unsigned long addr);
 #else
 static inline void ftrace_free_init_tramp(void) { }
+static inline unsigned long ftrace_call_adjust(unsigned long addr) { return addr; }
 #endif
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index ea26665f82cf..f43f3a6b0051 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -14,6 +14,7 @@ typedef struct func_desc func_desc_t;
 
 extern char __head_end[];
 extern char __srwx_boundary[];
+extern char __exittext_begin[], __exittext_end[];
 
 /* Patch sites */
 extern s32 patch__call_flush_branch_caches1;
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 82010629cf88..d8d6b4fd9a14 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -27,10 +27,22 @@
 #include <asm/ftrace.h>
 #include <asm/syscall.h>
 #include <asm/inst.h>
+#include <asm/sections.h>
 
 #define	NUM_FTRACE_TRAMPS	2
 static unsigned long ftrace_tramps[NUM_FTRACE_TRAMPS];
 
+unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	if (addr >= (unsigned long)__exittext_begin && addr < (unsigned long)__exittext_end)
+		return 0;
+
+	if (IS_ENABLED(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY))
+		addr += MCOUNT_INSN_SIZE;
+
+	return addr;
+}
+
 static ppc_inst_t ftrace_create_branch_inst(unsigned long ip, unsigned long addr, int link)
 {
 	ppc_inst_t op;
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 7b85c3b460a3..12fab1803bcf 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -37,6 +37,11 @@
 #define	NUM_FTRACE_TRAMPS	8
 static unsigned long ftrace_tramps[NUM_FTRACE_TRAMPS];
 
+unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr;
+}
+
 static ppc_inst_t
 ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 {
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 1c5970df3233..f420df7888a7 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -281,7 +281,9 @@ SECTIONS
 	 * to deal with references from __bug_table
 	 */
 	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
+		__exittext_begin = .;
 		EXIT_TEXT
+		__exittext_end = .;
 	}
 
 	. = ALIGN(PAGE_SIZE);

base-commit: ba151416051a45ffca565f708584b9cd5c971481
-- 
2.44.0


