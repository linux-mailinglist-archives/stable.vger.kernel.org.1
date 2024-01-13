Return-Path: <stable+bounces-10739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C182CB6C
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0371F22B25
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28611869;
	Sat, 13 Jan 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="neloPb1z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37B1846;
	Sat, 13 Jan 2024 09:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A13C433F1;
	Sat, 13 Jan 2024 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139961;
	bh=zt4trwVM8mArt3AeAPBSHqWkA5W93PO1x3EgDaGEeqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=neloPb1z8jiI4hgf1/hdY7GF0WmR7RWOZPE17ZR5l6gpcE507oh0I2hQG6gw5zDsW
	 gZfy9V5b+kmJeXPfRJfbJzPshMRpFgkkY0Eph6F/cLTHds+nlZU9bchZt3s+19nCZ8
	 O0P0J6C80ACAZteIc9/lmpA1p5ejVK/BZEHHcOaE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aditya Gupta <adityag@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5.10 36/43] powerpc: update ppc_save_regs to save current r1 in pt_regs
Date: Sat, 13 Jan 2024 10:50:15 +0100
Message-ID: <20240113094208.104649943@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094206.930684111@linuxfoundation.org>
References: <20240113094206.930684111@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Gupta <adityag@linux.ibm.com>

commit b684c09f09e7a6af3794d4233ef785819e72db79 upstream.

ppc_save_regs() skips one stack frame while saving the CPU register states.
Instead of saving current R1, it pulls the previous stack frame pointer.

When vmcores caused by direct panic call (such as `echo c >
/proc/sysrq-trigger`), are debugged with gdb, gdb fails to show the
backtrace correctly. On further analysis, it was found that it was because
of mismatch between r1 and NIP.

GDB uses NIP to get current function symbol and uses corresponding debug
info of that function to unwind previous frames, but due to the
mismatching r1 and NIP, the unwinding does not work, and it fails to
unwind to the 2nd frame and hence does not show the backtrace.

GDB backtrace with vmcore of kernel without this patch:

---------
(gdb) bt
 #0  0xc0000000002a53e8 in crash_setup_regs (oldregs=<optimized out>,
    newregs=0xc000000004f8f8d8) at ./arch/powerpc/include/asm/kexec.h:69
 #1  __crash_kexec (regs=<optimized out>) at kernel/kexec_core.c:974
 #2  0x0000000000000063 in ?? ()
 #3  0xc000000003579320 in ?? ()
---------

Further analysis revealed that the mismatch occurred because
"ppc_save_regs" was saving the previous stack's SP instead of the current
r1. This patch fixes this by storing current r1 in the saved pt_regs.

GDB backtrace with vmcore of patched kernel:

--------
(gdb) bt
 #0  0xc0000000002a53e8 in crash_setup_regs (oldregs=0x0, newregs=0xc00000000670b8d8)
    at ./arch/powerpc/include/asm/kexec.h:69
 #1  __crash_kexec (regs=regs@entry=0x0) at kernel/kexec_core.c:974
 #2  0xc000000000168918 in panic (fmt=fmt@entry=0xc000000001654a60 "sysrq triggered crash\n")
    at kernel/panic.c:358
 #3  0xc000000000b735f8 in sysrq_handle_crash (key=<optimized out>) at drivers/tty/sysrq.c:155
 #4  0xc000000000b742cc in __handle_sysrq (key=key@entry=99, check_mask=check_mask@entry=false)
    at drivers/tty/sysrq.c:602
 #5  0xc000000000b7506c in write_sysrq_trigger (file=<optimized out>, buf=<optimized out>,
    count=2, ppos=<optimized out>) at drivers/tty/sysrq.c:1163
 #6  0xc00000000069a7bc in pde_write (ppos=<optimized out>, count=<optimized out>,
    buf=<optimized out>, file=<optimized out>, pde=0xc00000000362cb40) at fs/proc/inode.c:340
 #7  proc_reg_write (file=<optimized out>, buf=<optimized out>, count=<optimized out>,
    ppos=<optimized out>) at fs/proc/inode.c:352
 #8  0xc0000000005b3bbc in vfs_write (file=file@entry=0xc000000006aa6b00,
    buf=buf@entry=0x61f498b4f60 <error: Cannot access memory at address 0x61f498b4f60>,
    count=count@entry=2, pos=pos@entry=0xc00000000670bda0) at fs/read_write.c:582
 #9  0xc0000000005b4264 in ksys_write (fd=<optimized out>,
    buf=0x61f498b4f60 <error: Cannot access memory at address 0x61f498b4f60>, count=2)
    at fs/read_write.c:637
 #10 0xc00000000002ea2c in system_call_exception (regs=0xc00000000670be80, r0=<optimized out>)
    at arch/powerpc/kernel/syscall.c:171
 #11 0xc00000000000c270 in system_call_vectored_common ()
    at arch/powerpc/kernel/interrupt_64.S:192
--------

Nick adds:
  So this now saves regs as though it was an interrupt taken in the
  caller, at the instruction after the call to ppc_save_regs, whereas
  previously the NIP was there, but R1 came from the caller's caller and
  that mismatch is what causes gdb's dwarf unwinder to go haywire.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Fixes: d16a58f8854b1 ("powerpc: Improve ppc_save_regs()")
Reivewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230615091047.90433-1-adityag@linux.ibm.com
Cc: stable@vger.kernel.org
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/ppc_save_regs.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kernel/ppc_save_regs.S
+++ b/arch/powerpc/kernel/ppc_save_regs.S
@@ -58,10 +58,10 @@ _GLOBAL(ppc_save_regs)
 	lbz	r0,PACAIRQSOFTMASK(r13)
 	PPC_STL	r0,SOFTE-STACK_FRAME_OVERHEAD(r3)
 #endif
-	/* go up one stack frame for SP */
-	PPC_LL	r4,0(r1)
-	PPC_STL	r4,1*SZL(r3)
+	/* store current SP */
+	PPC_STL r1,1*SZL(r3)
 	/* get caller's LR */
+	PPC_LL	r4,0(r1)
 	PPC_LL	r0,LRSAVE(r4)
 	PPC_STL	r0,_LINK-STACK_FRAME_OVERHEAD(r3)
 	mflr	r0



