Return-Path: <stable+bounces-20669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7F85AADF
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6273D1F20F1F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF5482E4;
	Mon, 19 Feb 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T1pnUEf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB647F79
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366955; cv=none; b=RceRbuY6Z4bH3i8mTQkIMSYhsbgFWBdv674EbnL1bkWlo1xAaWeaAdKgeOmbpX7obDnbLQ6nOO5KtkN5VdTV1ZknTmzOq1Hh4KoFT+d6yrSbehwpuaR35W05jOB02MmfzGtAH7I2XDnGpJqi2v6eMjq2LRz5VsAIveXRkZP99NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366955; c=relaxed/simple;
	bh=w9bMeHfV5G0uelB87E6wvLUUrf6iT8R38rN8CzYlxc0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kFIBqyN8D1+BGHFu1FLaeb4RzC2GmHW1Vdi9eEVyGCmSF82/I7FfyGDmxZW11RmNDjyBWoCECDpgfIsGAFhYGhcHa2LoqITpzng9nOLx7Fu9Bv5xCMWviVJATKGr9FrErjeuu4T7rovU15oZs8Io36JXAbV1sMhCt3/Ei25iZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T1pnUEf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780BAC433C7;
	Mon, 19 Feb 2024 18:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366954;
	bh=w9bMeHfV5G0uelB87E6wvLUUrf6iT8R38rN8CzYlxc0=;
	h=Subject:To:Cc:From:Date:From;
	b=T1pnUEf/3E6j/qnMxDhIB+BNdjR3vELsZB1WX2BbL4dIzJ0BM9sAjeaM8oCsWD7qj
	 4EZj4NYetk64Zm81XLsLSUgVBU0ExfyjMlBLD3eRywlZGBmdWlCXcc6wyro1yTKIvi
	 Hkv6AEHvzwYzJEkCHbTThtc9hv865C5pizScoTNI=
Subject: FAILED: patch "[PATCH] powerpc/64: Set task pt_regs->link to the LR value on scv" failed to apply to 5.10-stable tree
To: naveen@kernel.org,mpe@ellerman.id.au,nysal@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:22:31 +0100
Message-ID: <2024021931-venue-await-dbc3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x aad98efd0b121f63a2e1c221dcb4d4850128c697
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021931-venue-await-dbc3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

aad98efd0b12 ("powerpc/64: Set task pt_regs->link to the LR value on scv entry")
e754f4d13e39 ("powerpc/64: move interrupt return asm to interrupt_64.S")
59dc5bfca0cb ("powerpc/64s: avoid reloading (H)SRR registers if they are still valid")
1df7d5e4baea ("powerpc/64s: introduce different functions to return from SRR vs HSRR interrupts")
ac3d085368b3 ("powerpc/signal32: Remove impossible #ifdef combinations")
69d4d6e5fd9f ("powerpc: Don't use 'struct ppc_inst' to reference instruction location")
e90a21ea801d ("powerpc/lib/code-patching: Don't use struct 'ppc_inst' for runnable code in tests.")
6c0d181daabc ("powerpc/lib/code-patching: Make instr_is_branch_to_addr() static")
18c85964b10b ("powerpc: Do not dereference code as 'struct ppc_inst' (uprobe, code-patching, feature-fixups)")
f30becb5e9ec ("powerpc: Replace PPC_INST_NOP by PPC_RAW_NOP()")
ef909ba95414 ("powerpc/lib/feature-fixups: Use PPC_RAW_xxx() macros")
5a03e1e9728e ("powerpc/ftrace: Use PPC_RAW_MFLR() and PPC_RAW_NOP()")
e73045975601 ("powerpc/security: Use PPC_RAW_BLR() and PPC_RAW_NOP()")
47b04699d070 ("powerpc/modules: Use PPC_RAW_xx() macros")
1c9debbc2eb5 ("powerpc/signal: Use PPC_RAW_xx() macros")
82123a3d1d5a ("powerpc/kprobes: Fix validation of prefixed instructions across page boundary")
d72500f99284 ("powerpc/64s/syscall: Fix ptrace syscall info with scv syscalls")
5b48ba2fbd77 ("powerpc/64s: Fix stf mitigation patching w/strict RWX & hash")
49b39ec248af ("powerpc/64s: Fix entry flush patching w/strict RWX & hash")
2c8c89b95831 ("powerpc/pseries: Fix hcall tracing recursion in pv queued spinlocks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aad98efd0b121f63a2e1c221dcb4d4850128c697 Mon Sep 17 00:00:00 2001
From: Naveen N Rao <naveen@kernel.org>
Date: Fri, 2 Feb 2024 21:13:16 +0530
Subject: [PATCH] powerpc/64: Set task pt_regs->link to the LR value on scv
 entry

Nysal reported that userspace backtraces are missing in offcputime bcc
tool. As an example:
    $ sudo ./bcc/tools/offcputime.py -uU
    Tracing off-CPU time (us) of user threads by user stack... Hit Ctrl-C to end.

    ^C
	write
	-                python (9107)
	    8

	write
	-                sudo (9105)
	    9

	mmap
	-                python (9107)
	    16

	clock_nanosleep
	-                multipathd (697)
	    3001604

The offcputime bcc tool attaches a bpf program to a kprobe on
finish_task_switch(), which is usually hit on a syscall from userspace.
With the switch to system call vectored, we started setting
pt_regs->link to zero. This is because system call vectored behaves like
a function call with LR pointing to the system call return address, and
with no modification to SRR0/SRR1. The LR value does indicate our next
instruction, so it is being saved as pt_regs->nip, and pt_regs->link is
being set to zero. This is not a problem by itself, but BPF uses perf
callchain infrastructure for capturing stack traces, and that stores LR
as the second entry in the stack trace. perf has code to cope with the
second entry being zero, and skips over it. However, generic userspace
unwinders assume that a zero entry indicates end of the stack trace,
resulting in a truncated userspace stack trace.

Rather than fixing all userspace unwinders to ignore/skip past the
second entry, store the real LR value in pt_regs->link so that there
continues to be a valid, though duplicate entry in the stack trace.

With this change:
    $ sudo ./bcc/tools/offcputime.py -uU
    Tracing off-CPU time (us) of user threads by user stack... Hit Ctrl-C to end.

    ^C
	write
	write
	[unknown]
	[unknown]
	[unknown]
	[unknown]
	[unknown]
	PyObject_VectorcallMethod
	[unknown]
	[unknown]
	PyObject_CallOneArg
	PyFile_WriteObject
	PyFile_WriteString
	[unknown]
	[unknown]
	PyObject_Vectorcall
	_PyEval_EvalFrameDefault
	PyEval_EvalCode
	[unknown]
	[unknown]
	[unknown]
	_PyRun_SimpleFileObject
	_PyRun_AnyFileObject
	Py_RunMain
	[unknown]
	Py_BytesMain
	[unknown]
	__libc_start_main
	-                python (1293)
	    7

	write
	write
	[unknown]
	sudo_ev_loop_v1
	sudo_ev_dispatch_v1
	[unknown]
	[unknown]
	[unknown]
	[unknown]
	__libc_start_main
	-                sudo (1291)
	    7

	syscall
	syscall
	bpf_open_perf_buffer_opts
	[unknown]
	[unknown]
	[unknown]
	[unknown]
	_PyObject_MakeTpCall
	PyObject_Vectorcall
	_PyEval_EvalFrameDefault
	PyEval_EvalCode
	[unknown]
	[unknown]
	[unknown]
	_PyRun_SimpleFileObject
	_PyRun_AnyFileObject
	Py_RunMain
	[unknown]
	Py_BytesMain
	[unknown]
	__libc_start_main
	-                python (1293)
	    11

	clock_nanosleep
	clock_nanosleep
	nanosleep
	sleep
	[unknown]
	[unknown]
	__clone
	-                multipathd (698)
	    3001661

Fixes: 7fa95f9adaee ("powerpc/64s: system call support for scv/rfscv instructions")
Cc: stable@vger.kernel.org
Reported-by: "Nysal Jan K.A" <nysal@linux.ibm.com>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240202154316.395276-1-naveen@kernel.org

diff --git a/arch/powerpc/kernel/interrupt_64.S b/arch/powerpc/kernel/interrupt_64.S
index bd863702d812..1ad059a9e2fe 100644
--- a/arch/powerpc/kernel/interrupt_64.S
+++ b/arch/powerpc/kernel/interrupt_64.S
@@ -52,7 +52,8 @@ _ASM_NOKPROBE_SYMBOL(system_call_vectored_\name)
 	mr	r10,r1
 	ld	r1,PACAKSAVE(r13)
 	std	r10,0(r1)
-	std	r11,_NIP(r1)
+	std	r11,_LINK(r1)
+	std	r11,_NIP(r1)	/* Saved LR is also the next instruction */
 	std	r12,_MSR(r1)
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
@@ -70,7 +71,6 @@ _ASM_NOKPROBE_SYMBOL(system_call_vectored_\name)
 	std	r9,GPR13(r1)
 	SAVE_NVGPRS(r1)
 	std	r11,_XER(r1)
-	std	r11,_LINK(r1)
 	std	r11,_CTR(r1)
 
 	li	r11,\trapnr


