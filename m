Return-Path: <stable+bounces-4475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70968047A4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D01F28130C
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B298C03;
	Tue,  5 Dec 2023 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JwHbObjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ECB6FB1;
	Tue,  5 Dec 2023 03:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660B0C433C7;
	Tue,  5 Dec 2023 03:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747648;
	bh=z4BbZMnjQto3fW0xB1wQOHMQK4fvdy77gm/2MUFeUwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwHbObjAvEFJqxFNYV/3MFWnQ21zyYUHz44EaF87yuiP72o1u0MPbC/+jIPzE5RMQ
	 90IkfLbNzIJx2OMMb4j/DZay2ChzyPsNiibMuXzKgba44ttsVxkdcnhauwj+rUo3yD
	 OY/j7+AqtLAzsahBZAwCKGgADHeVeGQVypCoesUw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Timothy Pearson <tpearson@raptorengineering.com>,
	Jens Axboe <axboe@kernel.dk>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.15 17/67] powerpc: Dont clobber f0/vs0 during fp|altivec register save
Date: Tue,  5 Dec 2023 12:17:02 +0900
Message-ID: <20231205031520.784512926@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
References: <20231205031519.853779502@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timothy Pearson <tpearson@raptorengineering.com>

commit 5e1d824f9a283cbf90f25241b66d1f69adb3835b upstream.

During floating point and vector save to thread data f0/vs0 are
clobbered by the FPSCR/VSCR store routine. This has been obvserved to
lead to userspace register corruption and application data corruption
with io-uring.

Fix it by restoring f0/vs0 after FPSCR/VSCR store has completed for
all the FP, altivec, VMX register save paths.

Tested under QEMU in kvm mode, running on a Talos II workstation with
dual POWER9 DD2.2 CPUs.

Additional detail (mpe):

Typically save_fpu() is called from __giveup_fpu() which saves the FP
regs and also *turns off FP* in the tasks MSR, meaning the kernel will
reload the FP regs from the thread struct before letting the task use FP
again. So in that case save_fpu() is free to clobber f0 because the FP
regs no longer hold live values for the task.

There is another case though, which is the path via:
  sys_clone()
    ...
    copy_process()
      dup_task_struct()
        arch_dup_task_struct()
          flush_all_to_thread()
            save_all()

That path saves the FP regs but leaves them live. That's meant as an
optimisation for a process that's using FP/VSX and then calls fork(),
leaving the regs live means the parent process doesn't have to take a
fault after the fork to get its FP regs back. The optimisation was added
in commit 8792468da5e1 ("powerpc: Add the ability to save FPU without
giving it up").

That path does clobber f0, but f0 is volatile across function calls,
and typically programs reach copy_process() from userspace via a syscall
wrapper function. So in normal usage f0 being clobbered across a
syscall doesn't cause visible data corruption.

But there is now a new path, because io-uring can call copy_process()
via create_io_thread() from the signal handling path. That's OK if the
signal is handled as part of syscall return, but it's not OK if the
signal is handled due to some other interrupt.

That path is:

interrupt_return_srr_user()
  interrupt_exit_user_prepare()
    interrupt_exit_user_prepare_main()
      do_notify_resume()
        get_signal()
          task_work_run()
            create_worker_cb()
              create_io_worker()
                copy_process()
                  dup_task_struct()
                    arch_dup_task_struct()
                      flush_all_to_thread()
                        save_all()
                          if (tsk->thread.regs->msr & MSR_FP)
                            save_fpu()
                            # f0 is clobbered and potentially live in userspace

Note the above discussion applies equally to save_altivec().

Fixes: 8792468da5e1 ("powerpc: Add the ability to save FPU without giving it up")
Cc: stable@vger.kernel.org # v4.6+
Closes: https://lore.kernel.org/all/480932026.45576726.1699374859845.JavaMail.zimbra@raptorengineeringinc.com/
Closes: https://lore.kernel.org/linuxppc-dev/480221078.47953493.1700206777956.JavaMail.zimbra@raptorengineeringinc.com/
Tested-by: Timothy Pearson <tpearson@raptorengineering.com>
Tested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
[mpe: Reword change log to describe exact path of corruption & other minor tweaks]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/1921539696.48534988.1700407082933.JavaMail.zimbra@raptorengineeringinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/fpu.S    |   13 +++++++++++++
 arch/powerpc/kernel/vector.S |    2 ++
 2 files changed, 15 insertions(+)

--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -23,6 +23,15 @@
 #include <asm/feature-fixups.h>
 
 #ifdef CONFIG_VSX
+#define __REST_1FPVSR(n,c,base)						\
+BEGIN_FTR_SECTION							\
+	b	2f;							\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
+	REST_FPR(n,base);						\
+	b	3f;							\
+2:	REST_VSR(n,c,base);						\
+3:
+
 #define __REST_32FPVSRS(n,c,base)					\
 BEGIN_FTR_SECTION							\
 	b	2f;							\
@@ -41,9 +50,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);
 2:	SAVE_32VSRS(n,c,base);						\
 3:
 #else
+#define __REST_1FPVSR(n,b,base)		REST_FPR(n, base)
 #define __REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
 #define __SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
 #endif
+#define REST_1FPVSR(n,c,base)   __REST_1FPVSR(n,__REG_##c,__REG_##base)
 #define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base)
 #define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
 
@@ -67,6 +78,7 @@ _GLOBAL(store_fp_state)
 	SAVE_32FPVSRS(0, R4, R3)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r3)
+	REST_1FPVSR(0, R4, R3)
 	blr
 EXPORT_SYMBOL(store_fp_state)
 
@@ -133,4 +145,5 @@ _GLOBAL(save_fpu)
 2:	SAVE_32FPVSRS(0, R4, R6)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r6)
+	REST_1FPVSR(0, R4, R6)
 	blr
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -32,6 +32,7 @@ _GLOBAL(store_vr_state)
 	mfvscr	v0
 	li	r4, VRSTATE_VSCR
 	stvx	v0, r4, r3
+	lvx	v0, 0, r3
 	blr
 EXPORT_SYMBOL(store_vr_state)
 
@@ -104,6 +105,7 @@ _GLOBAL(save_altivec)
 	mfvscr	v0
 	li	r4,VRSTATE_VSCR
 	stvx	v0,r4,r7
+	lvx	v0,0,r7
 	blr
 
 #ifdef CONFIG_VSX



