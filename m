Return-Path: <stable+bounces-7145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC7E817121
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08171F22FCD
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8BD1D157;
	Mon, 18 Dec 2023 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XV4X0XX/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C821D132;
	Mon, 18 Dec 2023 13:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80122C433C9;
	Mon, 18 Dec 2023 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907681;
	bh=2SrkWiym+hR2SDr2irpsU7S9tLiJ2NyxCrdezYKa5ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XV4X0XX/8huT+tUsg9hIl9dvQPgcjIXTdT8evR1UQ7ydRZgf/qz5Fq8yYYRLbDSPN
	 DWgeWCefUZ0FM0yD0wwuENTuzKrab2GRkYUL5mg8QLvtxE60zgo9ALCGvbojCh75Vq
	 KRION7eslIzyN3KdTNrJobrRHDM75crS+LDwbm80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 35/36] powerpc/ftrace: Create a dummy stackframe to fix stack unwind
Date: Mon, 18 Dec 2023 14:51:45 +0100
Message-ID: <20231218135043.075137950@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135041.876499958@linuxfoundation.org>
References: <20231218135041.876499958@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naveen N Rao <naveen@kernel.org>

commit 41a506ef71eb38d94fe133f565c87c3e06ccc072 upstream.

With ppc64 -mprofile-kernel and ppc32 -pg, profiling instructions to
call into ftrace are emitted right at function entry. The instruction
sequence used is minimal to reduce overhead. Crucially, a stackframe is
not created for the function being traced. This breaks stack unwinding
since the function being traced does not have a stackframe for itself.
As such, it never shows up in the backtrace:

/sys/kernel/debug/tracing # echo 1 > /proc/sys/kernel/stack_tracer_enabled
/sys/kernel/debug/tracing # cat stack_trace
        Depth    Size   Location    (17 entries)
        -----    ----   --------
  0)     4144      32   ftrace_call+0x4/0x44
  1)     4112     432   get_page_from_freelist+0x26c/0x1ad0
  2)     3680     496   __alloc_pages+0x290/0x1280
  3)     3184     336   __folio_alloc+0x34/0x90
  4)     2848     176   vma_alloc_folio+0xd8/0x540
  5)     2672     272   __handle_mm_fault+0x700/0x1cc0
  6)     2400     208   handle_mm_fault+0xf0/0x3f0
  7)     2192      80   ___do_page_fault+0x3e4/0xbe0
  8)     2112     160   do_page_fault+0x30/0xc0
  9)     1952     256   data_access_common_virt+0x210/0x220
 10)     1696     400   0xc00000000f16b100
 11)     1296     384   load_elf_binary+0x804/0x1b80
 12)      912     208   bprm_execve+0x2d8/0x7e0
 13)      704      64   do_execveat_common+0x1d0/0x2f0
 14)      640     160   sys_execve+0x54/0x70
 15)      480      64   system_call_exception+0x138/0x350
 16)      416     416   system_call_common+0x160/0x2c4

Fix this by having ftrace create a dummy stackframe for the function
being traced. With this, backtraces now capture the function being
traced:

/sys/kernel/debug/tracing # cat stack_trace
        Depth    Size   Location    (17 entries)
        -----    ----   --------
  0)     3888      32   _raw_spin_trylock+0x8/0x70
  1)     3856     576   get_page_from_freelist+0x26c/0x1ad0
  2)     3280      64   __alloc_pages+0x290/0x1280
  3)     3216     336   __folio_alloc+0x34/0x90
  4)     2880     176   vma_alloc_folio+0xd8/0x540
  5)     2704     416   __handle_mm_fault+0x700/0x1cc0
  6)     2288      96   handle_mm_fault+0xf0/0x3f0
  7)     2192      48   ___do_page_fault+0x3e4/0xbe0
  8)     2144     192   do_page_fault+0x30/0xc0
  9)     1952     608   data_access_common_virt+0x210/0x220
 10)     1344      16   0xc0000000334bbb50
 11)     1328     416   load_elf_binary+0x804/0x1b80
 12)      912      64   bprm_execve+0x2d8/0x7e0
 13)      848     176   do_execveat_common+0x1d0/0x2f0
 14)      672     192   sys_execve+0x54/0x70
 15)      480      64   system_call_exception+0x138/0x350
 16)      416     416   system_call_common+0x160/0x2c4

This results in two additional stores in the ftrace entry code, but
produces reliable backtraces.

Fixes: 153086644fd1 ("powerpc/ftrace: Add support for -mprofile-kernel ftrace ABI")
Cc: stable@vger.kernel.org
Signed-off-by: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230621051349.759567-1-naveen@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -40,6 +40,9 @@ _GLOBAL(ftrace_regs_caller)
 	/* Save the original return address in A's stack frame */
 	std	r0,LRSAVE(r1)
 
+	/* Create a minimal stack frame for representing B */
+	stdu	r1, -STACK_FRAME_MIN_SIZE(r1)
+
 	/* Create our stack frame + pt_regs */
 	stdu	r1,-SWITCH_FRAME_SIZE(r1)
 
@@ -69,6 +72,8 @@ _GLOBAL(ftrace_regs_caller)
 	mflr	r7
 	/* Save it as pt_regs->nip */
 	std     r7, _NIP(r1)
+	/* Also save it in B's stackframe header for proper unwind */
+	std	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
 	/* Save the read LR in pt_regs->link */
 	std     r0, _LINK(r1)
 
@@ -125,7 +130,7 @@ ftrace_regs_call:
 	ld	r2, 24(r1)
 
 	/* Pop our stack frame */
-	addi r1, r1, SWITCH_FRAME_SIZE
+	addi r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 
 #ifdef CONFIG_LIVEPATCH
         /* Based on the cmpd above, if the NIP was altered handle livepatch */
@@ -157,6 +162,9 @@ _GLOBAL(ftrace_caller)
 	/* Save the original return address in A's stack frame */
 	std	r0, LRSAVE(r1)
 
+	/* Create a minimal stack frame for representing B */
+	stdu	r1, -STACK_FRAME_MIN_SIZE(r1)
+
 	/* Create our stack frame + pt_regs */
 	stdu	r1, -SWITCH_FRAME_SIZE(r1)
 
@@ -170,6 +178,7 @@ _GLOBAL(ftrace_caller)
 	/* Get the _mcount() call site out of LR */
 	mflr	r7
 	std     r7, _NIP(r1)
+	std	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
 
 	/* Save callee's TOC in the ABI compliant location */
 	std	r2, 24(r1)
@@ -204,7 +213,7 @@ ftrace_call:
 	ld	r2, 24(r1)
 
 	/* Pop our stack frame */
-	addi	r1, r1, SWITCH_FRAME_SIZE
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 
 	/* Reload original LR */
 	ld	r0, LRSAVE(r1)



