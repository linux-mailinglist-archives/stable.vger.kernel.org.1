Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84717827DE
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjHUL11 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjHUL11 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 07:27:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99713D8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 04:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 342EC61356
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 11:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EAFC433C8;
        Mon, 21 Aug 2023 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692617244;
        bh=1hp/J2WzBMmVWifpnSK1GWlOqCGvwUPB4FPvPs0ioX0=;
        h=Subject:To:Cc:From:Date:From;
        b=hA8qYuiIISv+cs6GhJQZVt5d79Rtid1SnLOQ0zw+bNkigN3recl6r0+BX4u5rwTpB
         e4ImTo36f3NeLmcRNhN1yoShLVQTmhIT6e46idun5/brInaf/CG2y74+wL4QeciDhM
         wd+281+DXbugvv9RhnIGMGAB2OePbImredW74508=
Subject: FAILED: patch "[PATCH] arm64/ptrace: Ensure that SME is set up for target when" failed to apply to 6.1-stable tree
To:     broonie@kernel.org, David.Spickett@arm.com,
        catalin.marinas@arm.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 13:27:21 +0200
Message-ID: <2023082121-chewing-regroup-4f67@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5d0a8d2fba50e9c07cde4aad7fba28c008b07a5b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082121-chewing-regroup-4f67@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5d0a8d2fba50 ("arm64/ptrace: Ensure that SME is set up for target when writing SSVE state")
f90b529bcbe5 ("arm64/sme: Implement ZT0 ptrace support")
ce514000da4f ("arm64/sme: Rename za_state to sme_state")
1192b93ba352 ("arm64/fp: Use a struct to pass data to fpsimd_bind_state_to_cpu()")
deeb8f9a80fd ("arm64/fpsimd: Have KVM explicitly say which FP registers to save")
baa8515281b3 ("arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE")
93ae6b01bafe ("KVM: arm64: Discard any SVE state when entering KVM guests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d0a8d2fba50e9c07cde4aad7fba28c008b07a5b Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Thu, 10 Aug 2023 12:28:19 +0100
Subject: [PATCH] arm64/ptrace: Ensure that SME is set up for target when
 writing SSVE state

When we use NT_ARM_SSVE to either enable streaming mode or change the
vector length for a process we do not currently do anything to ensure that
there is storage allocated for the SME specific register state.  If the
task had not previously used SME or we changed the vector length then
the task will not have had TIF_SME set or backing storage for ZA/ZT
allocated, resulting in inconsistent register sizes when saving state
and spurious traps which flush the newly set register state.

We should set TIF_SME to disable traps and ensure that storage is
allocated for ZA and ZT if it is not already allocated.  This requires
modifying sme_alloc() to make the flush of any existing register state
optional so we don't disturb existing state for ZA and ZT.

Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Reported-by: David Spickett <David.Spickett@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 5.19.x
Link: https://lore.kernel.org/r/20230810-arm64-fix-ptrace-race-v1-1-a5361fad2bd6@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 67f2fb781f59..8df46f186c64 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -356,7 +356,7 @@ static inline int sme_max_virtualisable_vl(void)
 	return vec_max_virtualisable_vl(ARM64_VEC_SME);
 }
 
-extern void sme_alloc(struct task_struct *task);
+extern void sme_alloc(struct task_struct *task, bool flush);
 extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
@@ -388,7 +388,7 @@ static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
 static inline void sme_smstop(void) { }
 
-static inline void sme_alloc(struct task_struct *task) { }
+static inline void sme_alloc(struct task_struct *task, bool flush) { }
 static inline void sme_setup(void) { }
 static inline unsigned int sme_get_vl(void) { return 0; }
 static inline int sme_max_vl(void) { return 0; }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 75c37b1c55aa..087c05aa960e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1285,9 +1285,9 @@ void fpsimd_release_task(struct task_struct *dead_task)
  * the interest of testability and predictability, the architecture
  * guarantees that when ZA is enabled it will be zeroed.
  */
-void sme_alloc(struct task_struct *task)
+void sme_alloc(struct task_struct *task, bool flush)
 {
-	if (task->thread.sme_state) {
+	if (task->thread.sme_state && flush) {
 		memset(task->thread.sme_state, 0, sme_state_size(task));
 		return;
 	}
@@ -1515,7 +1515,7 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 	}
 
 	sve_alloc(current, false);
-	sme_alloc(current);
+	sme_alloc(current, true);
 	if (!current->thread.sve_state || !current->thread.sme_state) {
 		force_sig(SIGKILL);
 		return;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5b9b4305248b..a31af7a1abe3 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -881,6 +881,13 @@ static int sve_set_common(struct task_struct *target,
 			break;
 		case ARM64_VEC_SME:
 			target->thread.svcr |= SVCR_SM_MASK;
+
+			/*
+			 * Disable traps and ensure there is SME storage but
+			 * preserve any currently set values in ZA/ZT.
+			 */
+			sme_alloc(target, false);
+			set_tsk_thread_flag(target, TIF_SME);
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -1100,7 +1107,7 @@ static int za_set(struct task_struct *target,
 	}
 
 	/* Allocate/reinit ZA storage */
-	sme_alloc(target);
+	sme_alloc(target, true);
 	if (!target->thread.sme_state) {
 		ret = -ENOMEM;
 		goto out;
@@ -1171,7 +1178,7 @@ static int zt_set(struct task_struct *target,
 		return -EINVAL;
 
 	if (!thread_za_enabled(&target->thread)) {
-		sme_alloc(target);
+		sme_alloc(target, true);
 		if (!target->thread.sme_state)
 			return -ENOMEM;
 	}
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e304f7ebec2a..c7ebe744c64e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -475,7 +475,7 @@ static int restore_za_context(struct user_ctxs *user)
 	fpsimd_flush_task_state(current);
 	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
 
-	sme_alloc(current);
+	sme_alloc(current, true);
 	if (!current->thread.sme_state) {
 		current->thread.svcr &= ~SVCR_ZA_MASK;
 		clear_thread_flag(TIF_SME);

