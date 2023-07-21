Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10EE75D296
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjGUTBS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjGUTBR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:01:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847830CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:01:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0750B61D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A451C433C8;
        Fri, 21 Jul 2023 19:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966075;
        bh=mBmUGl8w4CJ/CyI7fpfR/NN12ecmnndRgBlqDk/7EM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktSWiZRUpGkcYnmzXitgPgYtqBrO+LpQpc0iqRVJbZPFPDo0CBDlAqo6dxN0W08l9
         EgncDxgBKiMSXMyeBhMXEDnRT1HSKQWkMNJ0yBT4FrdaIEHatiAblaDCACT5Vg88qQ
         NNlZI8bX+QBv7xsTADwTKKZSj309uoR0pnoTyic0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aditya Gupta <adityag@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5.15 215/532] powerpc: update ppc_save_regs to save current r1 in pt_regs
Date:   Fri, 21 Jul 2023 18:01:59 +0200
Message-ID: <20230721160626.056245474@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aditya Gupta <adityag@linux.ibm.com>

[ Upstream commit b684c09f09e7a6af3794d4233ef785819e72db79 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/ppc_save_regs.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_save_regs.S b/arch/powerpc/kernel/ppc_save_regs.S
index 6e86f3bf46735..235ae24284519 100644
--- a/arch/powerpc/kernel/ppc_save_regs.S
+++ b/arch/powerpc/kernel/ppc_save_regs.S
@@ -31,10 +31,10 @@ _GLOBAL(ppc_save_regs)
 	lbz	r0,PACAIRQSOFTMASK(r13)
 	PPC_STL	r0,SOFTE(r3)
 #endif
-	/* go up one stack frame for SP */
-	PPC_LL	r4,0(r1)
-	PPC_STL	r4,GPR1(r3)
+	/* store current SP */
+	PPC_STL	r1,GPR1(r3)
 	/* get caller's LR */
+	PPC_LL	r4,0(r1)
 	PPC_LL	r0,LRSAVE(r4)
 	PPC_STL	r0,_LINK(r3)
 	mflr	r0
-- 
2.39.2



