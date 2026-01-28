Return-Path: <stable+bounces-212582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOwwESc6emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:32:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A89A5C82
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CF8A30356A5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66F33033C4;
	Wed, 28 Jan 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hFCmjx2j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899242DB791;
	Wed, 28 Jan 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616001; cv=none; b=GcKe/avhfYLeM3BwZDjZC9OHDJq+3k71BHLpko2V3L3+TbaIG3j9PSIiQWEYJyBTzlHHTB4is80UJKmcy+Pe7aPSIjOdLodb0fK5M+4sIajiug+Bw28FYm3OoX8fQ/KBnMr/DJIhvWLxvVG8zk5NKN81nYvTT18EhIUavKQ0nHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616001; c=relaxed/simple;
	bh=jOp06s2wiamrqCsGL4FiFi1ETvn1lwWTwjJh61PhAyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3m0Ybjy96ay5D0YHp8DjcWCes20vkw8VC2QZCsLQ6P1YtRI5fNAOXZVowzA4MPZLM+knQCjPP/eYOFNKdkGETMPXyaitrLZxNrDUKqE+dUrWzXYpKWKOS+4Wn3Uo7gCVRKy9ooP7nh4I115c5EycPnViz4x1/RGgF5ShuqezaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hFCmjx2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23077C4CEF7;
	Wed, 28 Jan 2026 15:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616001;
	bh=jOp06s2wiamrqCsGL4FiFi1ETvn1lwWTwjJh61PhAyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFCmjx2jB0ZtPuSz0WCFNRHMtmhbadKjWfEAjn1+fIVVEnxg7YssRz/Q7l7GnVT/X
	 o3GJ54LHz+gZ96cV5XfbcumnpTwTt62CIOuP8Vo/VveN7xRbvJWTfwPILKP0yvgrRU
	 FkAzDmjgY/QaCGoCv1UJr5zY2BqujXwQjBtrL2qg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d4ab35af21e99d07ce67@syzkaller.appspotmail.com,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.18 178/227] arm64/fpsimd: ptrace: Fix SVE writes on !SME systems
Date: Wed, 28 Jan 2026 16:23:43 +0100
Message-ID: <20260128145350.853666281@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212582-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,d4ab35af21e99d07ce67];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63A89A5C82
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 128a7494a9f15aad60cc6b7e3546bf481ac54a13 upstream.

When SVE is supported but SME is not supported, a ptrace write to the
NT_ARM_SVE regset can place the tracee into an invalid state where
(non-streaming) SVE register data is stored in FP_STATE_SVE format but
TIF_SVE is clear. This can result in a later warning from
fpsimd_restore_current_state(), e.g.

  WARNING: CPU: 0 PID: 7214 at arch/arm64/kernel/fpsimd.c:383 fpsimd_restore_current_state+0x50c/0x748

When this happens, fpsimd_restore_current_state() will set TIF_SVE,
placing the task into the correct state. This occurs before any other
check of TIF_SVE can possibly occur, as other checks of TIF_SVE only
happen while the FPSIMD/SVE/SME state is live. Thus, aside from the
warning, there is no functional issue.

This bug was introduced during rework to error handling in commit:

  9f8bf718f2923 ("arm64/fpsimd: ptrace: Gracefully handle errors")

... where the setting of TIF_SVE was moved into a block which is only
executed when system_supports_sme() is true.

Fix this by removing the system_supports_sme() check. This ensures that
TIF_SVE is set for (SVE-formatted) writes to NT_ARM_SVE, at the cost of
unconditionally manipulating the tracee's saved svcr value. The
manipulation of svcr is benign and inexpensive, and we already do
similar elsewhere (e.g. during signal handling), so I don't think it's
worth guarding this with system_supports_sme() checks.

Aside from the above, there is no functional change. The 'type' argument
to sve_set_common() is only set to ARM64_VEC_SME (in ssve_set())) when
system_supports_sme(), so the ARM64_VEC_SME case in the switch statement
is still unreachable when !system_supports_sme(). When
CONFIG_ARM64_SME=n, the only caller of sve_set_common() is sve_set(),
and the compiler can constant-fold for the case where type is
ARM64_VEC_SVE, removing the logic for other cases.

Reported-by: syzbot+d4ab35af21e99d07ce67@syzkaller.appspotmail.com
Fixes: 9f8bf718f292 ("arm64/fpsimd: ptrace: Gracefully handle errors")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: <stable@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/ptrace.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -942,20 +942,18 @@ static int sve_set_common(struct task_st
 	vq = sve_vq_from_vl(task_get_vl(target, type));
 
 	/* Enter/exit streaming mode */
-	if (system_supports_sme()) {
-		switch (type) {
-		case ARM64_VEC_SVE:
-			target->thread.svcr &= ~SVCR_SM_MASK;
-			set_tsk_thread_flag(target, TIF_SVE);
-			break;
-		case ARM64_VEC_SME:
-			target->thread.svcr |= SVCR_SM_MASK;
-			set_tsk_thread_flag(target, TIF_SME);
-			break;
-		default:
-			WARN_ON_ONCE(1);
-			return -EINVAL;
-		}
+	switch (type) {
+	case ARM64_VEC_SVE:
+		target->thread.svcr &= ~SVCR_SM_MASK;
+		set_tsk_thread_flag(target, TIF_SVE);
+		break;
+	case ARM64_VEC_SME:
+		target->thread.svcr |= SVCR_SM_MASK;
+		set_tsk_thread_flag(target, TIF_SME);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	/* Always zero V regs, FPSR, and FPCR */



