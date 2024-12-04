Return-Path: <stable+bounces-98307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 508459E3E5D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBC8B37742
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAB220CCF4;
	Wed,  4 Dec 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsUjrzZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141DA20CCEA;
	Wed,  4 Dec 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325752; cv=none; b=heQwKSX8PfGaK63n/8T9Pn1nJBZaJjbvP/9tqTUJVHXhr25n2vaclAOOf3nXX+B91FdP0gvtFVsLL6J9jFKSYMrBfLK2iXT9GFjI2WCWWkFXQ5j8teRen6EG/X6tamDV/AO9nrQvFJoR0dH9b5Q4Q0COOYKKgZLTKNwrnRz4jDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325752; c=relaxed/simple;
	bh=lZE0yTF3Wn3zm9BaDbx5EJVtSvWlxgzUZ0o5624BVkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cdHnx0+jYjQb2gZo8aho4SXT8EnSg1Ir6c5kADoNzhThA3Ko4LKobhR3jJGX8xBeLu0ijUPsFJtDoswxbkAk8DzI3bdhcoL2jQ57F1NeHsaXRgeThNT2rxKkg4LZN5YC7vKKl1pglQP1TPN9lJDSRnzt4vWh1Azk0ppT34/3NRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsUjrzZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DD1C4CECD;
	Wed,  4 Dec 2024 15:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733325752;
	bh=lZE0yTF3Wn3zm9BaDbx5EJVtSvWlxgzUZ0o5624BVkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qsUjrzZoYvGeW4O1Qo2S/QEo1kpj3bCn/WaqU3FmeHw2BoTS92MADRiV9v+ZUEYma
	 PL6q7ETvLd/+nb+k9JNrD/XMk1wJWoM9W5vYkPkbF0s0BVOcxObOU3O5I5WwDIaDzO
	 dYlFyTfadRQpnmFZkhX+n7l83OT33Kj3xcnLodcpUY0pckUkZAK1rsG4PCiQ0pIGEF
	 5ZlvBF9H6It2QWCjfWr39rwp4fBuagiKsVFIsy9Y9jpXyqPo26ZcChEGq1B6IU1FKd
	 CzgS6jT/0W+tqbO2kk+K27LrqkCSlLhTLBQGGgAG55V4vKk19dfOVAfzgCG7JWOZUw
	 kLNqqyhwFtqVg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 04 Dec 2024 15:20:52 +0000
Subject: [PATCH v2 4/6] arm64/signal: Avoid corruption of SME state when
 entering signal handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-arm64-sme-reenable-v2-4-bae87728251d@kernel.org>
References: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
In-Reply-To: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=6215; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lZE0yTF3Wn3zm9BaDbx5EJVtSvWlxgzUZ0o5624BVkc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnUHOrNgOudoKrDy1LNoXO+30vsuX1Sq99+Z0u/GpF
 cnOco76JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1BzqwAKCRAk1otyXVSH0G9vB/
 9WZhYOqn/+ue9mmPEZKnaxHPg8zv3uNoHg89HImh9V8P6iMBLBqKwK63OlDzhtRPGDiBNDpYJXTcgK
 TTCxYPgsBxqndrDp3TlvKUkf3rTA4G5DF+Lg+x1GHd6VkXVRaliTztue1LU8ZRjIc5zyOrsepipQRG
 68KD1dl/Xbt0gT1KgKWr12hOSYG0vyqgeDni5eM4mfajRtdIXwJ/XXwRwHjZAzLwezxGr+e4mzHRqQ
 an2+EfV0z7DFhpLlFM2tqpcoEMt06Rbf5chVfCrNQnAUOjHR6g35eIfs7+MhHFy7Fz7WSGS9XMwWBn
 MeZMOcqxqz6bI92ziLgC6eUvv4dJbE
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
FPMR, and resets FPSR to 0x800009f but does not change ZA, ZT or FPCR.
The in memory version clears all the user FPSIMD state including FPCR
and FPSR but does not clear FPMR. Update the code to implement the
changes the hardware implements.

Fixes: 40a8e87bb3285 ("arm64/sme: Disable ZA and streaming mode when handling signals")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/fpsimd.h |  1 +
 arch/arm64/kernel/fpsimd.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c      | 19 +------------------
 3 files changed, 42 insertions(+), 18 deletions(-)

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
index a3bb17c88942eba031d26e9f75ad46f37b6dc621..2b045d4d8f71ace5bf01a596dda279285a0998a5 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1696,6 +1696,46 @@ void fpsimd_signal_preserve_current_state(void)
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
+			current->thread.uw.fpsimd_state.fpsr = 0x800009f;
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
index 14ac6fdb872b9672e4b16a097f1b577aae8dec50..79c9c5cd0802149b3cde20b398617437d79181f2 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1487,24 +1487,7 @@ static int setup_return(struct pt_regs *regs, struct ksignal *ksig,
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


