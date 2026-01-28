Return-Path: <stable+bounces-212674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJlbN7Zyemme6gEAu9opvQ
	(envelope-from <stable+bounces-212674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:33:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA8AA89DF
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A195B3008D41
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 20:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB573374726;
	Wed, 28 Jan 2026 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utBmU1vA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9422D73A1
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632434; cv=none; b=DII6CHEf6Ln7oC8QsbgI8THVtJ/YuD7FS2IqazUXSo7+e9/0hAYBPpbB+7NuuOKV/SNHkjI9DhQf2xn6g2d9/T6sv3MwV7qKt0myhI/vx/ZMhUIA7dkETbybR9xQqVL7JYGoAW2wy6liHY+NtJXGewzinexUlZH9HJJD6v0MC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632434; c=relaxed/simple;
	bh=78+JLmZNMjqsAusgdxPAGHra+7DFQrpbMSqc22oxm8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1lrdHB8yP0anSQNVcVUXjNWoeNHjAq79NDy46UUR5FgXl/FDok9zAhStjpLa88QrZ6NFU7u59cX41iK8JqlQlbS96vr6EObGfM/J4xKUt1wu25E35jco7CwyWB0InXatKdpPP2fumGgY0QIn5k9TIhD1ZmyDfKnw17fjMrRA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utBmU1vA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96995C4CEF1;
	Wed, 28 Jan 2026 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632434;
	bh=78+JLmZNMjqsAusgdxPAGHra+7DFQrpbMSqc22oxm8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utBmU1vAP97IoqMY30tGeHVETM+Wv0KZyTTA4+YZnI3kULuDWKjiUXRgtHs4KsHSP
	 Rqrvmek2+y0EuPrwAYbB+wc0oDDRgBEnrZq83qnWEW6L2m8V5G80QYwK5sRkX0bOo3
	 0K7M0L+tMs31RyFpij1gj9ca2/iVjlehImmqQ+Z9fGSP36HHI4ZycfohcZqOP02s+k
	 i173WH3jazo+ZqLLcgHh5OkUIlMWr6LcrAM0PIno0DZWGiwMYUyS23ctEo7VxUkscB
	 6Gmgp6aD59TEAM9ALAS389qT+eDuMazanlF1LUhNP3fEEJ0yZVATSUGIaAywkuQxMd
	 g+sck5nvm9w7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] arm64/fpsimd: signal: Fix restoration of SVE context
Date: Wed, 28 Jan 2026 15:33:50 -0500
Message-ID: <20260128203350.2720303-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128203350.2720303-1-sashal@kernel.org>
References: <2026012703-skintight-tricycle-0f20@gregkh>
 <20260128203350.2720303-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212674-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email,svcr.sm:url]
X-Rspamd-Queue-Id: ADA8AA89DF
X-Rspamd-Action: no action

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit d2907cbe9ea0a54cbe078076f9d089240ee1e2d9 ]

When SME is supported, Restoring SVE signal context can go wrong in a
few ways, including placing the task into an invalid state where the
kernel may read from out-of-bounds memory (and may potentially take a
fatal fault) and/or may kill the task with a SIGKILL.

(1) Restoring a context with SVE_SIG_FLAG_SM set can place the task into
    an invalid state where SVCR.SM is set (and sve_state is non-NULL)
    but TIF_SME is clear, consequently resuting in out-of-bounds memory
    reads and/or killing the task with SIGKILL.

    This can only occur in unusual (but legitimate) cases where the SVE
    signal context has either been modified by userspace or was saved in
    the context of another task (e.g. as with CRIU), as otherwise the
    presence of an SVE signal context with SVE_SIG_FLAG_SM implies that
    TIF_SME is already set.

    While in this state, task_fpsimd_load() will NOT configure SMCR_ELx
    (leaving some arbitrary value configured in hardware) before
    restoring SVCR and attempting to restore the streaming mode SVE
    registers from memory via sve_load_state(). As the value of
    SMCR_ELx.LEN may be larger than the task's streaming SVE vector
    length, this may read memory outside of the task's allocated
    sve_state, reading unrelated data and/or triggering a fault.

    While this can result in secrets being loaded into streaming SVE
    registers, these values are never exposed. As TIF_SME is clear,
    fpsimd_bind_task_to_cpu() will configure CPACR_ELx.SMEN to trap EL0
    accesses to streaming mode SVE registers, so these cannot be
    accessed directly at EL0. As fpsimd_save_user_state() verifies the
    live vector length before saving (S)SVE state to memory, no secret
    values can be saved back to memory (and hence cannot be observed via
    ptrace, signals, etc).

    When the live vector length doesn't match the expected vector length
    for the task, fpsimd_save_user_state() will send a fatal SIGKILL
    signal to the task. Hence the task may be killed after executing
    userspace for some period of time.

(2) Restoring a context with SVE_SIG_FLAG_SM clear does not clear the
    task's SVCR.SM. If SVCR.SM was set prior to restoring the context,
    then the task will be left in streaming mode unexpectedly, and some
    register state will be combined inconsistently, though the task will
    be left in legitimate state from the kernel's PoV.

    This can only occur in unusual (but legitimate) cases where ptrace
    has been used to set SVCR.SM after entry to the sigreturn syscall,
    as syscall entry clears SVCR.SM.

    In these cases, the the provided SVE register data will be loaded
    into the task's sve_state using the non-streaming SVE vector length
    and the FPSIMD registers will be merged into this using the
    streaming SVE vector length.

Fix (1) by setting TIF_SME when setting SVCR.SM. This also requires
ensuring that the task's sme_state has been allocated, but as this could
contain live ZA state, it should not be zeroed. Fix (2) by clearing
SVCR.SM when restoring a SVE signal context with SVE_SIG_FLAG_SM clear.

For consistency, I've pulled the manipulation of SVCR, TIF_SVE, TIF_SME,
and fp_type earlier, immediately after the allocation of
sve_state/sme_state, before the restore of the actual register state.
This makes it easier to ensure that these are always modified
consistently, even if a fault is taken while reading the register data
from the signal context. I do not expect any software to depend on the
exact state restored when a fault is taken while reading the context.

Fixes: 85ed24dad290 ("arm64/sme: Implement streaming SVE signal handling")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: <stable@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ preserved fpsimd_flush_task_state() call before new SME allocation logic ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/signal.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index b615ed8fb318a..6dfba3f94362c 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -344,12 +344,28 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	fpsimd_flush_task_state(current);
 	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
 
+	if (sm) {
+		sme_alloc(current, false);
+		if (!current->thread.sme_state)
+			return -ENOMEM;
+	}
+
 	sve_alloc(current, true);
 	if (!current->thread.sve_state) {
 		clear_thread_flag(TIF_SVE);
 		return -ENOMEM;
 	}
 
+	if (sm) {
+		current->thread.svcr |= SVCR_SM_MASK;
+		set_thread_flag(TIF_SME);
+	} else {
+		current->thread.svcr &= ~SVCR_SM_MASK;
+		set_thread_flag(TIF_SVE);
+	}
+
+	current->thread.fp_type = FP_STATE_SVE;
+
 	err = __copy_from_user(current->thread.sve_state,
 			       (char __user const *)user->sve +
 					SVE_SIG_REGS_OFFSET,
@@ -357,12 +373,6 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (err)
 		return -EFAULT;
 
-	if (flags & SVE_SIG_FLAG_SM)
-		current->thread.svcr |= SVCR_SM_MASK;
-	else
-		set_thread_flag(TIF_SVE);
-	current->thread.fp_type = FP_STATE_SVE;
-
 	err = read_fpsimd_context(&fpsimd, user);
 	if (err)
 		return err;
-- 
2.51.0


