Return-Path: <stable+bounces-6799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD627814687
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDB11C23B20
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68424200A8;
	Fri, 15 Dec 2023 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFxuZiJf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31874250E0
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 11:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF76C433C7;
	Fri, 15 Dec 2023 11:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702638920;
	bh=EJ6TFwgKbFhG8E7FBqpeFqiWjxRR4fen0FyuH2cfUz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFxuZiJffLBiBpSl4ZZLitNu4zzZ1uTw7v64K7Mk/7lIxXE4nrWXiTkZK278KTY+2
	 t5uIH55Od9xE6LOrZ/fa7FnekBshcQhDfXgKhD2aLza9tzb9dhXjZw+032qsvdjK/o
	 h+tqTrZoEcSd8VhKF1DAQrRnL0aa7/0XeALuucxlsD3Uodo+iOQ6lZ241PEsWVPcKT
	 IgacnVrPPAdgpgicj2Fmen1zuVtNvw4BWgP68XMv4EpMCq9WRE0sb53fiE8XotRubU
	 4gznhHjmNOKxijqMGmlNQL3T2HHVoF0xdBxbPQ/fhaoPunm8u57nmxBq4/Pm1jgD4O
	 knTbExmU5Swkg==
From: Naveen N Rao <naveen@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14.y 1/2] powerpc/ftrace: Create a dummy stackframe to fix stack unwind
Date: Fri, 15 Dec 2023 16:41:21 +0530
Message-ID: <20231215111122.2361478-1-naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023080741-polka-twice-b0df@gregkh>
References: <2023080741-polka-twice-b0df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index b4e2b7165f79..ee66f4877042 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -41,6 +41,9 @@ _GLOBAL(ftrace_caller)
 	/* Save the original return address in A's stack frame */
 	std	r0,LRSAVE(r1)
 
+	/* Create a minimal stack frame for representing B */
+	stdu	r1, -STACK_FRAME_MIN_SIZE(r1)
+
 	/* Create our stack frame + pt_regs */
 	stdu	r1,-SWITCH_FRAME_SIZE(r1)
 
@@ -64,6 +67,8 @@ _GLOBAL(ftrace_caller)
 	mflr	r7
 	/* Save it as pt_regs->nip */
 	std     r7, _NIP(r1)
+	/* Also save it in B's stackframe header for proper unwind */
+	std	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
 	/* Save the read LR in pt_regs->link */
 	std     r0, _LINK(r1)
 
@@ -146,7 +151,7 @@ ftrace_call:
 	ld	r2, 24(r1)
 
 	/* Pop our stack frame */
-	addi r1, r1, SWITCH_FRAME_SIZE
+	addi r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 
 #ifdef CONFIG_LIVEPATCH
         /*

base-commit: 27972f32764632d687a5f851c1ce5e206a09acce
-- 
2.43.0


