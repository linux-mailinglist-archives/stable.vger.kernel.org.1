Return-Path: <stable+bounces-91723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A179BF760
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 20:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EC31F2114C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 19:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EA920C48C;
	Wed,  6 Nov 2024 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9YNZL5F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E703209F3C;
	Wed,  6 Nov 2024 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921866; cv=none; b=Dd4ss3hDKAXTAKC3pdwFXrGl3Z+4/RPGnjQNPI7vUySXznhhiCwnsUuJ1c7uzGG0Ulix1K3Xq0elWRAqnw6l21TZLZENZ67vutbwUqAxiRAVB/RTmfcPLBWL7KWyj3CvQQdUJ4x0nb6nFuChGTFwfYAjUZDx4Uie2/jzQhAq1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921866; c=relaxed/simple;
	bh=fN9Lf/+1M3vz8fvp9JB7a8D4GFEYSQKstM1USNDT7tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t2Vu29CwvhAyzAOi914Z3zMT+LbAFEVp+SVmpOJagcr4DZBBqjxhLjSjs30kWBdeCchI7HoPkazX3DbOYFOp5fNp94i75qngi67ImtZm8XesiN+g5QpDmzKlYbgLlaEy0nLML3VlQV4/e/j75zaVM8lYikxE3x7y7WqFRRnOTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9YNZL5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C776CC4CEC6;
	Wed,  6 Nov 2024 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730921866;
	bh=fN9Lf/+1M3vz8fvp9JB7a8D4GFEYSQKstM1USNDT7tY=;
	h=From:Date:Subject:To:Cc:From;
	b=r9YNZL5FtlvtBFjClx+bm3BBFZvMrxlkyCXwkeH4gBq0Xugpa4nJ08H6b5joQGoyi
	 nfoTKH1ZQRrYeze8ERvAsycHTfbC7Fe4J6E2sx5FbWFBCcl6+7nJhnrXxgj/26QVk2
	 gkEU5gNvL4CE+tvFvLU7QSIlRgOsekPVWND8nbCVS3xo4WpX3BC9NLQ9E3faXjnNfi
	 8ohZQh1STT651Je5Dm1JcmqIK+HHzYvuZR10NsPYLSJ5tDH3gxs3IHewseuadrW9Qe
	 5pGL36jJ4Xqq4TjkesY2pX+nBBm5L3GmgbE3ZxkqGLlWfgc+oPeXIGpGAEwpPwjSwj
	 D9Aey8V7h8d2A==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Nov 2024 19:35:46 +0000
Subject: [PATCH v3] arm64/signal: Avoid corruption of SME state when
 entering signal handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-arm64-fp-sme-sigentry-v3-1-38d06b75c850@kernel.org>
X-B4-Tracking: v=1; b=H4sIABLFK2cC/4XNQQ6CMBCF4auYrh3TTqtFV97DuCgwhUYppCWNh
 HB3CytdGJf/S+abmUUKjiK77GYWKLnoep9D7nesao1vCFydmyFHJThKMKE7KbADxI4guob8GCY
 wWNZaFJq0KFm+HQJZ99rc2z136+LYh2l7k8S6/hOTAAGoztZqqqSp+fVBwdPz0IeGrWTCD0byX
 wxmRsmKCn6sRYnfzLIsb/9qie8CAQAA
X-Change-ID: 20241023-arm64-fp-sme-sigentry-a2bd7187e71b
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=6777; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fN9Lf/+1M3vz8fvp9JB7a8D4GFEYSQKstM1USNDT7tY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnK8WH1to3G4Nc52JGFgAtq6nyvdY7xhRxskcODXv2
 tvGLqw+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyvFhwAKCRAk1otyXVSH0MbJB/
 43Z9YJKdN4EQdlLfsAL0Ro+d90IuYlIvHZjjQ7r/LoK+p4wlm6tQzK/E4rob9iAOt9ZtQjzQKs/+jW
 4FdkKVAu0sbiVCQAXs2yKbwGiXWcQYNL3xUiVpCRAmWraUUnsnMpcr+RyGAOC9m0zvIwDQznvNZtOE
 rA3bLCy1Rdcz6VBUMhQFOwK7U+m+6n3J4oGZKuEIrtmmBJkyCsan2d5IiQrI5ekLjPwQNDcERC1z+y
 0nuGf70+eXtlz+hm8l2knQywg0crvJkBRcX7MbrQ4Kfwn9cQuIA9KRw0ngawKB5uErqTC5p1xQ9EZr
 TxtdKsJbnUj71F+24UYJ4FqEx6thbt
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
Changes in v3:
- Fix the in memory update to follow the behaviour of the SMSTOP we
  issue when updating in registers.
- Link to v2: https://lore.kernel.org/r/20241030-arm64-fp-sme-sigentry-v2-1-43ce805d1b20@kernel.org

Changes in v2:
- Commit message tweaks.
- Flush the task state when updating in memory to ensure we reload.
- Link to v1: https://lore.kernel.org/r/20241023-arm64-fp-sme-sigentry-v1-1-249ff7ec3ad0@kernel.org
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
index 77006df20a75aee7c991cf116b6d06bfe953d1a4..10c8efd1c5ce83f4ea4025b213111ab9519263b1 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1693,6 +1693,45 @@ void fpsimd_signal_preserve_current_state(void)
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
index 5619869475304776fc005fe24a385bf86bfdd253..fe07d0bd9f7978d73973f07ce38b7bdd7914abb2 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1218,24 +1218,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
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
 
 	if (system_supports_poe())
 		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241023-arm64-fp-sme-sigentry-a2bd7187e71b

Best regards,
-- 
Mark Brown <broonie@kernel.org>


