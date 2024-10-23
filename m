Return-Path: <stable+bounces-87953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C61F9AD6CA
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 23:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0781C210D2
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F421D2B11;
	Wed, 23 Oct 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhC8Leuv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD51171671;
	Wed, 23 Oct 2024 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719203; cv=none; b=hifZbr1ZP7a1cKLS0qXDE7ZgOWycmxD7JslKlpsLeU8S94xe8p3RqibJtgsGKOQLSlMVsku9KMF9mrFrGk6hRv+oKQDy2N523wGB3C90qGSUWYtlq7ENdgjt1aVfgYA6xj33MJkt+inhZxkYMG7+pGHKKo1DRImbu0Pm/CJd96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719203; c=relaxed/simple;
	bh=4Cdl78KMSg8ESoVkXR1vtPGDTu30ACB34Uff1obLF+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cx+BKp0OC2bFcoN90Y/gKha0w/2ZYYa2k/JuJI29GIo2p/X2iH8C5fMFf7M3I1o1DEBz2i+7siAm9j4zum5GklLHlkb4fY60/9mye02TDPtDk4vcSlfLnbFOWXQQCjZY97mUKM3BeDCGaRRW4PK2zRDlvgmeEi+LvHx8QSwVr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhC8Leuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A979FC4CEC6;
	Wed, 23 Oct 2024 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729719202;
	bh=4Cdl78KMSg8ESoVkXR1vtPGDTu30ACB34Uff1obLF+s=;
	h=From:Date:Subject:To:Cc:From;
	b=YhC8LeuvFdI1wN0m3isfCcxto6XSU4YmTdslMeXDevbzGVnkdmBSeici2HTIPTIvR
	 nbH0ka//EPTeVEgqphT31zwCaWwl39ePfhHf+1a0pikShfDasJOP/g2y/nRsYwT3yM
	 8eYG5iiGq4lPlmff0xKHpbAV1HsTgzCsROy7Qafkn/at88zV68q6+W0wsFHTxiDlak
	 fxmzrf1sZaUluYm3GCclT/CrGkzbNHYApThrOuSRzwJL46f8Ujo/8Qyc9D/b8CPYPJ
	 CMqrfp36VW3TMcySp+GqS+hgvB8Ae1m3EhT5HapavU5F464rWjqpDY3Xpre16dqZSi
	 P14DT6sAuK70g==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 23 Oct 2024 22:31:24 +0100
Subject: [PATCH] arm64/signal: Avoid corruption of SME state when entering
 signal handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-arm64-fp-sme-sigentry-v1-1-249ff7ec3ad0@kernel.org>
X-B4-Tracking: v=1; b=H4sIACtrGWcC/x3MQQ5AMBBA0avIrE2iJSquIhYtg1komREh4u4ay
 7f4/wElYVJosweETlbeYoLJMxgWH2dCHpPBFrYyhS3Ry1pXOO2oK6HyTPGQG70NozONI2cCpHY
 Xmvj6v13/vh9LzOURZwAAAA==
X-Change-ID: 20241023-arm64-fp-sme-sigentry-a2bd7187e71b
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=4970; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4Cdl78KMSg8ESoVkXR1vtPGDTu30ACB34Uff1obLF+s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnGWufCXMY+wKGUe0veSFLrn03Q+QJr52eqIWW1PoS
 80ym3+OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxlrnwAKCRAk1otyXVSH0PLDB/
 sFjdjvP1i9t977GK9dzQ+jJrqtRpqRQre7WINBFglAtjiF2DbrBjDrCtaL3BfnUfChlbwiPMWu/+U8
 d6hWrvxgzvLYCFAz40zNMO/QGRLoz6urB6/B0G4kmI2oMmGTsbOvHn6UhPlRc3G5mHl/n+e5tmXqg5
 VgVax1Qc0j7AlAh9HuIMBU0GTKZgUYZmtwUswoado7ALyJWt6vF17/Jv/xV2p6jnfBqMVsQzIijZNF
 zY49gCyPO2Aa/DZ6bdmpTFClPQS10VYLUfAz+OGwecwo4iqT9hVC+Iny31N0nI8CwykPegh0yV/uVD
 /pD9rVzUnMB590PAKb64tEu45J0Ega
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we enter a signal handler we exit streaming mode in order to ensure
that signal handlers can run normal FPSIMD code, and while we're at it we
also clear PSTATE.ZA. Currently the code in setup_return() updates both the
in memory copy of the state and the register state. Not only is this
redundant it can also lead to corruption if we are preempted.

Consider two tasks on one CPU:

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

Fix this by check TIF_FOREIGN_FPSTATE and only updating one of the live
register context or the in memory copy when entering a signal handler.
Since this needs to happen atomically and all code that atomically
accesses FP state is in fpsimd.c also move the code there to ensure
consistency.

This race has been observed intermittently with fp-stress, especially
with preempt disabled.

Fixes: 40a8e87bb3285 ("arm64/sme: Disable ZA and streaming mode when handling signals")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/fpsimd.h |  1 +
 arch/arm64/kernel/fpsimd.c      | 30 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c      | 19 +------------------
 3 files changed, 32 insertions(+), 18 deletions(-)

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
index 77006df20a75aee7c991cf116b6d06bfe953d1a4..e6b086dc09f21e7f30df32ab4f6875b53c4228fd 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1693,6 +1693,36 @@ void fpsimd_signal_preserve_current_state(void)
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
+		/* Exiting streaming mode zeros the FPSIMD state */
+		if (current->thread.svcr & SVCR_SM_MASK) {
+			memset(&current->thread.uw.fpsimd_state, 0,
+			       sizeof(current->thread.uw.fpsimd_state));
+			current->thread.fp_type = FP_STATE_FPSIMD;
+		}
+
+		current->thread.svcr &= ~(SVCR_ZA_MASK |
+					  SVCR_SM_MASK);
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


