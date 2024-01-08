Return-Path: <stable+bounces-10019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8ED8270C4
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5F02838BF
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6FC4597C;
	Mon,  8 Jan 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVreXuk3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA445BE8
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 14:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C79C433C8;
	Mon,  8 Jan 2024 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704723079;
	bh=S/ND19QYpAmIvj7sfEODueMRBu7NfhY0qI7IFE+bEgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVreXuk3oeN4huJToa4Q4YOBs9E5U8H0RwcCIoFmjtTbrLW/vfVToo5AeHnb1SspC
	 YwDQM+2XlkPFuGlAXRg2wGMQoV8W73YOGsctUn2F/JlKXSjUHiZEB4VqkMuTO0xnMj
	 VtDDORUg0F+87mddWZtjqRQsMOfZYceAdcSHgeiA=
Date: Mon, 8 Jan 2024 15:11:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] powerpc: update ppc_save_regs to save current r1
 in pt_regs
Message-ID: <2024010805-shaft-exponent-3653@gregkh>
References: <20240106214107.552029-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106214107.552029-1-adityag@linux.ibm.com>

On Sun, Jan 07, 2024 at 03:11:07AM +0530, Aditya Gupta wrote:
> commit b684c09f09e7a6af3794d4233ef785819e72db79 upstream.
> 
> ppc_save_regs() skips one stack frame while saving the CPU register states.
> Instead of saving current R1, it pulls the previous stack frame pointer.
> 
> When vmcores caused by direct panic call (such as `echo c >
> /proc/sysrq-trigger`), are debugged with gdb, gdb fails to show the
> backtrace correctly. On further analysis, it was found that it was because
> of mismatch between r1 and NIP.
> 
> GDB uses NIP to get current function symbol and uses corresponding debug
> info of that function to unwind previous frames, but due to the
> mismatching r1 and NIP, the unwinding does not work, and it fails to
> unwind to the 2nd frame and hence does not show the backtrace.
> 
> GDB backtrace with vmcore of kernel without this patch:
> 
> ---------
> (gdb) bt
>  #0  0xc0000000002a53e8 in crash_setup_regs (oldregs=<optimized out>,
>     newregs=0xc000000004f8f8d8) at ./arch/powerpc/include/asm/kexec.h:69
>  #1  __crash_kexec (regs=<optimized out>) at kernel/kexec_core.c:974
>  #2  0x0000000000000063 in ?? ()
>  #3  0xc000000003579320 in ?? ()
> ---------
> 
> Further analysis revealed that the mismatch occurred because
> "ppc_save_regs" was saving the previous stack's SP instead of the current
> r1. This patch fixes this by storing current r1 in the saved pt_regs.
> 
> GDB backtrace with vmcore of patched kernel:
> 
> --------
> (gdb) bt
>  #0  0xc0000000002a53e8 in crash_setup_regs (oldregs=0x0, newregs=0xc00000000670b8d8)
>     at ./arch/powerpc/include/asm/kexec.h:69
>  #1  __crash_kexec (regs=regs@entry=0x0) at kernel/kexec_core.c:974
>  #2  0xc000000000168918 in panic (fmt=fmt@entry=0xc000000001654a60 "sysrq triggered crash\n")
>     at kernel/panic.c:358
>  #3  0xc000000000b735f8 in sysrq_handle_crash (key=<optimized out>) at drivers/tty/sysrq.c:155
>  #4  0xc000000000b742cc in __handle_sysrq (key=key@entry=99, check_mask=check_mask@entry=false)
>     at drivers/tty/sysrq.c:602
>  #5  0xc000000000b7506c in write_sysrq_trigger (file=<optimized out>, buf=<optimized out>,
>     count=2, ppos=<optimized out>) at drivers/tty/sysrq.c:1163
>  #6  0xc00000000069a7bc in pde_write (ppos=<optimized out>, count=<optimized out>,
>     buf=<optimized out>, file=<optimized out>, pde=0xc00000000362cb40) at fs/proc/inode.c:340
>  #7  proc_reg_write (file=<optimized out>, buf=<optimized out>, count=<optimized out>,
>     ppos=<optimized out>) at fs/proc/inode.c:352
>  #8  0xc0000000005b3bbc in vfs_write (file=file@entry=0xc000000006aa6b00,
>     buf=buf@entry=0x61f498b4f60 <error: Cannot access memory at address 0x61f498b4f60>,
>     count=count@entry=2, pos=pos@entry=0xc00000000670bda0) at fs/read_write.c:582
>  #9  0xc0000000005b4264 in ksys_write (fd=<optimized out>,
>     buf=0x61f498b4f60 <error: Cannot access memory at address 0x61f498b4f60>, count=2)
>     at fs/read_write.c:637
>  #10 0xc00000000002ea2c in system_call_exception (regs=0xc00000000670be80, r0=<optimized out>)
>     at arch/powerpc/kernel/syscall.c:171
>  #11 0xc00000000000c270 in system_call_vectored_common ()
>     at arch/powerpc/kernel/interrupt_64.S:192
> --------
> 
> Nick adds:
>   So this now saves regs as though it was an interrupt taken in the
>   caller, at the instruction after the call to ppc_save_regs, whereas
>   previously the NIP was there, but R1 came from the caller's caller and
>   that mismatch is what causes gdb's dwarf unwinder to go haywire.
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> Fixes: d16a58f8854b1 ("powerpc: Improve ppc_save_regs()")
> Reivewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://msgid.link/20230615091047.90433-1-adityag@linux.ibm.com
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
> 
> This is backport for the upstream commit b684c09f09e7a6af3794d4233ef785819e72db79.
> This solves a register mismatch issue while saving registers after a kernel crash.
> With this fixed, gdb can also unwind backtraces correctly for vmcores collected
> from such kernel crashes.
> 
> Please let me know if this is not correct format for a backport patch. Thanks.

Looks good, thanks, now queued up.

greg k-h

