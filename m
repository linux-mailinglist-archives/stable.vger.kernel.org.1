Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDE78ABCC
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjH1Ked (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjH1KeB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:34:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CFC1BD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87D7261DAA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A15DC433C8;
        Mon, 28 Aug 2023 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218817;
        bh=dOfXHCEYn5z54YVriaSvmmkLBUzR8qBLe8ywrE4aWm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJ4IX5Fm9kRLyj08whsVVaFrqW2ygX0I1g9C+vs2zHuvDOGqYB8mSp8CCod2yahHY
         c5qQezeqlkk2Fbg+fUobDwAqPAt++hcT5RKSAcXIanEXVB4SqLyH5kwhiOIkdg0wu3
         mRGzhpxDubGde9Rd2/ImFgkf4eLf9+MzK6XuhKIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lei Wang <lei4.wang@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lijun Pan <lijun.pan@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH 6.1 095/122] x86/fpu: Invalidate FPU state correctly on exec()
Date:   Mon, 28 Aug 2023 12:13:30 +0200
Message-ID: <20230828101159.557302308@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

commit 1f69383b203e28cf8a4ca9570e572da1699f76cd upstream.

The thread flag TIF_NEED_FPU_LOAD indicates that the FPU saved state is
valid and should be reloaded when returning to userspace. However, the
kernel will skip doing this if the FPU registers are already valid as
determined by fpregs_state_valid(). The logic embedded there considers
the state valid if two cases are both true:

  1: fpu_fpregs_owner_ctx points to the current tasks FPU state
  2: the last CPU the registers were live in was the current CPU.

This is usually correct logic. A CPU’s fpu_fpregs_owner_ctx is set to
the current FPU during the fpregs_restore_userregs() operation, so it
indicates that the registers have been restored on this CPU. But this
alone doesn’t preclude that the task hasn’t been rescheduled to a
different CPU, where the registers were modified, and then back to the
current CPU. To verify that this was not the case the logic relies on the
second condition. So the assumption is that if the registers have been
restored, AND they haven’t had the chance to be modified (by being
loaded on another CPU), then they MUST be valid on the current CPU.

Besides the lazy FPU optimizations, the other cases where the FPU
registers might not be valid are when the kernel modifies the FPU register
state or the FPU saved buffer. In this case the operation modifying the
FPU state needs to let the kernel know the correspondence has been
broken. The comment in “arch/x86/kernel/fpu/context.h” has:
/*
...
 * If the FPU register state is valid, the kernel can skip restoring the
 * FPU state from memory.
 *
 * Any code that clobbers the FPU registers or updates the in-memory
 * FPU state for a task MUST let the rest of the kernel know that the
 * FPU registers are no longer valid for this task.
 *
 * Either one of these invalidation functions is enough. Invalidate
 * a resource you control: CPU if using the CPU for something else
 * (with preemption disabled), FPU for the current task, or a task that
 * is prevented from running by the current task.
 */

However, this is not completely true. When the kernel modifies the
registers or saved FPU state, it can only rely on
__fpu_invalidate_fpregs_state(), which wipes the FPU’s last_cpu
tracking. The exec path instead relies on fpregs_deactivate(), which sets
the CPU’s FPU context to NULL. This was observed to fail to restore the
reset FPU state to the registers when returning to userspace in the
following scenario:

1. A task is executing in userspace on CPU0
	- CPU0’s FPU context points to tasks
	- fpu->last_cpu=CPU0

2. The task exec()’s

3. While in the kernel the task is preempted
	- CPU0 gets a thread executing in the kernel (such that no other
		FPU context is activated)
	- Scheduler sets task’s fpu->last_cpu=CPU0 when scheduling out

4. Task is migrated to CPU1

5. Continuing the exec(), the task gets to
   fpu_flush_thread()->fpu_reset_fpregs()
	- Sets CPU1’s fpu context to NULL
	- Copies the init state to the task’s FPU buffer
	- Sets TIF_NEED_FPU_LOAD on the task

6. The task reschedules back to CPU0 before completing the exec() and
   returning to userspace
	- During the reschedule, scheduler finds TIF_NEED_FPU_LOAD is set
	- Skips saving the registers and updating task’s fpu→last_cpu,
	  because TIF_NEED_FPU_LOAD is the canonical source.

7. Now CPU0’s FPU context is still pointing to the task’s, and
   fpu->last_cpu is still CPU0. So fpregs_state_valid() returns true even
   though the reset FPU state has not been restored.

So the root cause is that exec() is doing the wrong kind of invalidate. It
should reset fpu->last_cpu via __fpu_invalidate_fpregs_state(). Further,
fpu__drop() doesn't really seem appropriate as the task (and FPU) are not
going away, they are just getting reset as part of an exec. So switch to
__fpu_invalidate_fpregs_state().

Also, delete the misleading comment that says that either kind of
invalidate will be enough, because it’s not always the case.

Fixes: 33344368cb08 ("x86/fpu: Clean up the fpu__clear() variants")
Reported-by: Lei Wang <lei4.wang@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Lijun Pan <lijun.pan@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Lijun Pan <lijun.pan@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230818170305.502891-1-rick.p.edgecombe@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/fpu/context.h |    3 +--
 arch/x86/kernel/fpu/core.c    |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -19,8 +19,7 @@
  * FPU state for a task MUST let the rest of the kernel know that the
  * FPU registers are no longer valid for this task.
  *
- * Either one of these invalidation functions is enough. Invalidate
- * a resource you control: CPU if using the CPU for something else
+ * Invalidate a resource you control: CPU if using the CPU for something else
  * (with preemption disabled), FPU for the current task, or a task that
  * is prevented from running by the current task.
  */
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -679,7 +679,7 @@ static void fpu_reset_fpregs(void)
 	struct fpu *fpu = &current->thread.fpu;
 
 	fpregs_lock();
-	fpu__drop(fpu);
+	__fpu_invalidate_fpregs_state(fpu);
 	/*
 	 * This does not change the actual hardware registers. It just
 	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a


