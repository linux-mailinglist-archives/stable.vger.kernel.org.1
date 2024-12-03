Return-Path: <stable+bounces-96304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8AF9E1CB9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 13:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158AE28494D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47D1F4707;
	Tue,  3 Dec 2024 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6uhEE7H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A61F4289;
	Tue,  3 Dec 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230099; cv=none; b=URVYj13fy/sai89O4K7tFQOE9sdu+ctRQRc+3XyOtqpqo0bnUcdYTZNSDbp69vrC/izhYxvRLF0eMpD68sH4m1k6n/7RZ2QNLcdbwlb9Jpl8/+5VkYuHWegjA/z1RXrWxfI0wToWZOadX40TPcfkuMTO3/K+Dv85PQPSmro7xso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230099; c=relaxed/simple;
	bh=tqDF+LZfpEl117YVlmHOd2bm86U4BFv5nd1yWgZtYGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFOyS28rrdbXQjx/C3ZvWAtc3A0priYHFCCDji2QbqPw/iKGDKsTeKywrf2y3sbCc/fjSc24cvIKRbdhymvygZRSxGJ8r2F7XAE4PEUWltII2IWeEx3J8DmiNM+e8y5Bxy3lCrItczqCsFEFH3CQtgm8whpSYq+nYtAjIiXB1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6uhEE7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E3FC4CECF;
	Tue,  3 Dec 2024 12:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733230098;
	bh=tqDF+LZfpEl117YVlmHOd2bm86U4BFv5nd1yWgZtYGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f6uhEE7H+DIQTiSt6efWDdKqNHf4x8FbOju6/e0fmTWKzZ3d0B9DIcj+vhB05z1B3
	 lYXZ8lJ0if1ZmJesw7RAue1VKPWYXso1SNkS9sUzPdsfMyK8eXqTk4p7ocD2wqX99C
	 Vnv+m1Q4zA7VwKhRZaavpHfgALVNFYbQvIBsaeDGn4ygeGelIrol/lInc4PLz1FQZd
	 3S8Yph/IhbU22252h0frg/hHF5CBFi3AVI/DWkVOrvhdBVY0HBzL/XbE0z/O2TPZPk
	 AYQvifJVkM9velVV/4/LrWM8uK9nkhnw2Unjvh9eOnLN9tcxCcXTqFhzJ4uggGvyKf
	 racF4Br/ohEpQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:45:57 +0000
Subject: [PATCH 5/6] arm64/signal: Avoid corruption of SME state when
 entering signal handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-sme-reenable-v1-5-d853479d1b77@kernel.org>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
In-Reply-To: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=6180; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tqDF+LZfpEl117YVlmHOd2bm86U4BFv5nd1yWgZtYGw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTv4DRiB8mALTlanBgA4iu6r/2JeW9mfceg8ltz9C
 lMm+gWGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ07+AwAKCRAk1otyXVSH0KpXB/
 91iUpGoZkqphYBXkHXp+N0vZK7oXmkKGHfuOimfDbia5FwbFMvPjAGF0/KH1aIbemNG/356x2/1zTw
 l2n+JeMtTVaAH08PKBv+bz8YlbeTzHe8/10/nkMBE35m26sZ0MVTgADLhZbuX6NDxw3FGxz+GvOnEN
 z0XxIwuCi3OGCAPmt8L905uHm3c8i0A6oMAn+ZlVxdmsiBIEmE2EH6gt++6XEQ3KMor7hptg6gd2Yw
 HtB9UITN4mPZvJr99IR8Cmwk/Xr5W5VPwh2DDTn6hVy6bE2tCNZ7EBIdNc1teFGpOFyRDr/8/tHul5
 jOhMoIZxMl/vjNRcGLNdMNJKDtjntH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We intend that signal handlers are entered with PSTATE.{SM,ZA}={0,0}.
The logic for this in setup_return() manipulates the saved state and
live CPU state in an unsafe manner, and consequently, when a task enters
a signal handler:

 * The task entering the signal handler might not have its PSTATE.{SM,ZA}
   bits cleared, and other register state that is affected by changes to
   PSTATE.{SM,ZA} might not be zeroed as expected.

 * An unrelated task might have its PSTATE.{SM,ZA} bits cleared
   unexpectedly, potentially zeroing other register state that is
   affected by changes to PSTATE.{SM,ZA}.

   Tasks which do not set PSTATE.{SM,ZA} (i.e. those only using plain
   FPSIMD or non-streaming SVE) are not affected, as there is no
   resulting change to PSTATE.{SM,ZA}.

Consider for example two tasks on one CPU:

 A: Begins signal entry in kernel mode, is preempted prior to SMSTOP.
 B: Using SM and/or ZA in userspace with register state current on the
    CPU, is preempted.
 A: Scheduled in, no register state changes made as in kernel mode.
 A: Executes SMSTOP, modifying live register state.
 A: Scheduled out.
 B: Scheduled in, fpsimd_thread_switch() sees the register state on the
    CPU is tracked as being that for task B so the state is not reloaded
    prior to returning to userspace.

Task B is now running with SM and ZA incorrectly cleared.

Fix this by:

 * Checking TIF_FOREIGN_FPSTATE, and only updating the saved or live
   state as appropriate.

 * Using {get,put}_cpu_fpsimd_context() to ensure mutual exclusion
   against other code which manipulates this state. To allow their use,
   the logic is moved into a new fpsimd_enter_sighandler() helper in
   fpsimd.c.

This race has been observed intermittently with fp-stress, especially
with preempt disabled, commonly but not exclusively reporting "Bad SVCR: 0".

While we're at it also fix a discrepancy between in register and in memory
entries. When operating on the register state we issue a SMSTOP, exiting
streaming mode if we were in it. This clears the V/Z and P register and
FPMR but nothing else. The in memory version clears all the user FPSIMD
state including FPCR and FPSR but does not clear FPMR. Add the clear of
FPMR and limit the existing memset() to only cover the vregs, preserving
the state of FPCR and FPSR like SMSTOP does.

Fixes: 40a8e87bb3285 ("arm64/sme: Disable ZA and streaming mode when handling signals")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/fpsimd.h |  1 +
 arch/arm64/kernel/fpsimd.c      | 39 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c      | 19 +------------------
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index f2a84efc361858d4deda99faf1967cc7cac386c1..09af7cfd9f6c2cec26332caa4c254976e117b1bf 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -76,6 +76,7 @@ extern void fpsimd_load_state(struct user_fpsimd_state *state);
 extern void fpsimd_thread_switch(struct task_struct *next);
 extern void fpsimd_flush_thread(void);
 
+extern void fpsimd_enter_sighandler(void);
 extern void fpsimd_signal_preserve_current_state(void);
 extern void fpsimd_preserve_current_state(void);
 extern void fpsimd_restore_current_state(void);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index f02762762dbcf954e9add6dfd3575ae7055b6b0e..c5465c8ec467cb1ab8bd211dc5370f91aa2bcf35 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1696,6 +1696,45 @@ void fpsimd_signal_preserve_current_state(void)
 		sve_to_fpsimd(current);
 }
 
+/*
+ * Called by the signal handling code when preparing current to enter
+ * a signal handler. Currently this only needs to take care of exiting
+ * streaming mode and clearing ZA on SME systems.
+ */
+void fpsimd_enter_sighandler(void)
+{
+	if (!system_supports_sme())
+		return;
+
+	get_cpu_fpsimd_context();
+
+	if (test_thread_flag(TIF_FOREIGN_FPSTATE)) {
+		/*
+		 * Exiting streaming mode zeros the V/Z and P
+		 * registers and FPMR.  Zero FPMR and the V registers,
+		 * marking the state as FPSIMD only to force a clear
+		 * of the remaining bits during reload if needed.
+		 */
+		if (current->thread.svcr & SVCR_SM_MASK) {
+			memset(&current->thread.uw.fpsimd_state.vregs, 0,
+			       sizeof(current->thread.uw.fpsimd_state.vregs));
+			current->thread.uw.fpmr = 0;
+			current->thread.fp_type = FP_STATE_FPSIMD;
+		}
+
+		current->thread.svcr &= ~(SVCR_ZA_MASK |
+					  SVCR_SM_MASK);
+
+		/* Ensure any copies on other CPUs aren't reused */
+		fpsimd_flush_task_state(current);
+	} else {
+		/* The register state is current, just update it. */
+		sme_smstop();
+	}
+
+	put_cpu_fpsimd_context();
+}
+
 /*
  * Called by KVM when entering the guest.
  */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index abd0907061fe664bf22d1995319f9559c4bbed91..335c2327baf74eac9634cf594855dbf26a7d6b01 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1461,24 +1461,7 @@ static int setup_return(struct pt_regs *regs, struct ksignal *ksig,
 	/* TCO (Tag Check Override) always cleared for signal handlers */
 	regs->pstate &= ~PSR_TCO_BIT;
 
-	/* Signal handlers are invoked with ZA and streaming mode disabled */
-	if (system_supports_sme()) {
-		/*
-		 * If we were in streaming mode the saved register
-		 * state was SVE but we will exit SM and use the
-		 * FPSIMD register state - flush the saved FPSIMD
-		 * register state in case it gets loaded.
-		 */
-		if (current->thread.svcr & SVCR_SM_MASK) {
-			memset(&current->thread.uw.fpsimd_state, 0,
-			       sizeof(current->thread.uw.fpsimd_state));
-			current->thread.fp_type = FP_STATE_FPSIMD;
-		}
-
-		current->thread.svcr &= ~(SVCR_ZA_MASK |
-					  SVCR_SM_MASK);
-		sme_smstop();
-	}
+	fpsimd_enter_sighandler();
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		sigtramp = ksig->ka.sa.sa_restorer;

-- 
2.39.5


