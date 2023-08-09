Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804B87757B3
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjHIKtF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjHIKtE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A1D1BFF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C540963123
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B28C433C8;
        Wed,  9 Aug 2023 10:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578142;
        bh=F+RXVN0k3i1juwuo8toSGH+r3hRQvCbpysTH1uIRJH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Me/W/wGPzSFJL38BnASueKLKFjz4snCOntRzcnqRpSfqYZ0+qffhhE0QZoNmWSJq6
         GZs291KmmQ1xze5pDI+gGsLPs/5cxjTePwS2njEenUTGFFrLpC4Zc9rzr6izvGamtf
         fdBfOZH2eiTUB2wD3CqjM9MGopo3LnEOd1hkCv38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Naveen N Rao <naveen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.4 120/165] powerpc/ftrace: Create a dummy stackframe to fix stack unwind
Date:   Wed,  9 Aug 2023 12:40:51 +0200
Message-ID: <20230809103646.732476771@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
 arch/powerpc/kernel/trace/ftrace_mprofile.S |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/trace/ftrace_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_mprofile.S
@@ -33,6 +33,9 @@
  * and then arrange for the ftrace function to be called.
  */
 .macro	ftrace_regs_entry allregs
+	/* Create a minimal stack frame for representing B */
+	PPC_STLU	r1, -STACK_FRAME_MIN_SIZE(r1)
+
 	/* Create our stack frame + pt_regs */
 	PPC_STLU	r1,-SWITCH_FRAME_SIZE(r1)
 
@@ -42,7 +45,7 @@
 
 #ifdef CONFIG_PPC64
 	/* Save the original return address in A's stack frame */
-	std	r0, LRSAVE+SWITCH_FRAME_SIZE(r1)
+	std	r0, LRSAVE+SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE(r1)
 	/* Ok to continue? */
 	lbz	r3, PACA_FTRACE_ENABLED(r13)
 	cmpdi	r3, 0
@@ -77,6 +80,8 @@
 	mflr	r7
 	/* Save it as pt_regs->nip */
 	PPC_STL	r7, _NIP(r1)
+	/* Also save it in B's stackframe header for proper unwind */
+	PPC_STL	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
 	/* Save the read LR in pt_regs->link */
 	PPC_STL	r0, _LINK(r1)
 
@@ -142,7 +147,7 @@
 #endif
 
 	/* Pop our stack frame */
-	addi r1, r1, SWITCH_FRAME_SIZE
+	addi r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 
 #ifdef CONFIG_LIVEPATCH_64
         /* Based on the cmpd above, if the NIP was altered handle livepatch */


