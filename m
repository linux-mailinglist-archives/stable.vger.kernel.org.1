Return-Path: <stable+bounces-212673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKzUBv5yemme6gEAu9opvQ
	(envelope-from <stable+bounces-212673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:35:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F91DA8A28
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6B673048DE3
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 20:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EB037418E;
	Wed, 28 Jan 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKOmGxdV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FDE2D73A1
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632433; cv=none; b=UklbYYlxnjugRYwiUTIOLY1lE7pQewjxV71hPLjo3PGzOMMSkXSG9BHcXl8cusAMwzu5BCDBzlmD/mqOdNPxy349QI9iMuFcIXwxbIK4iIZmNyIXSsVhX23Ma+YjNYxwo8s9X3HUfpz3OfxJ7TF2DOt+CcqFU/WDUJ9NCEi8ssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632433; c=relaxed/simple;
	bh=qE/L8bKYFMMVVhMd26NmC9mkZzAsFaQ77WhGyfwRFKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUSP6srFzgsnEKqDIB/4lXVvUSxJafYr6yW57hy9wjlDe1Ck67o00f5uH6s6Efrr1ckMK91nC/GCiVRlo1ZONX0XgLf0i+mPAaQjytyta54c+5J+xKviTGDlIFbQG7xwEBEyrdQij7zdQXkJ+m8gudwepITzUi+pNYrIEfy2G5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKOmGxdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6CFC16AAE;
	Wed, 28 Jan 2026 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632433;
	bh=qE/L8bKYFMMVVhMd26NmC9mkZzAsFaQ77WhGyfwRFKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKOmGxdVtcwocwjbyNgHYLj9Zbeb0W/TguySV5Xht+qBGXt31FuHKqwbgrBbYK4vf
	 9fSuX0sZ54gx7Vwpqj5M7Jo32MGQ4VK9SsV2i1OKm79f8Bb7ThiGTNF/v5FzInvqzs
	 xIadFahXnBksycdSIU1JTuIVW8tD5AkB/W1VKrcjH2Yu8rD7ejQsZBoNbbH1iTkVUz
	 KfhYKuEpnWHJwKK67E/NQndFvkG0zngH/zQZy1cSAeRR66piRiq5GgJyG6Toh9EdBP
	 7hQGQ/G9ByUWKywA+v0No2ozGlg8MMZ3LDWeldtvdHQJhFeTFz+st+gd019AoPbfhJ
	 ojCSH7NAkxuSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] arm64/fpsimd: signal: Consistently read FPSIMD context
Date: Wed, 28 Jan 2026 15:33:49 -0500
Message-ID: <20260128203350.2720303-2-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212673-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 5F91DA8A28
X-Rspamd-Action: no action

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit be625d803c3bbfa9652697eb57589fe6f2f24b89 ]

For historical reasons, restore_sve_fpsimd_context() has an open-coded
copy of the logic from read_fpsimd_context(), which is used to either
restore an FPSIMD-only context, or to merge FPSIMD state into an
SVE state when restoring an SVE+FPSIMD context. The logic is *almost*
identical.

Refactor the logic to avoid duplication and make this clearer.

This comes with two functional changes that I do not believe will be
problematic in practice:

* The user_fpsimd_state::size field will be checked in all restore paths
  that consume it user_fpsimd_state. The kernel always populates this
  field when delivering a signal, and so this should contain the
  expected value unless it has been corrupted.

* If a read of user_fpsimd_state fails, we will return early without
  modifying TIF_SVE, the saved SVCR, or the save fp_type. This will
  leave the task in a consistent state, without potentially resurrecting
  stale FPSIMD state. A read of user_fpsimd_state should never fail
  unless the structure has been corrupted or the stack has been
  unmapped.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20250508132644.1395904-5-mark.rutland@arm.com
[will: Ensure read_fpsimd_context() returns negative error code or zero]
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: d2907cbe9ea0 ("arm64/fpsimd: signal: Fix restoration of SVE context")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/signal.c | 57 +++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 916207828faaa..b615ed8fb318a 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -202,29 +202,39 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
-static int restore_fpsimd_context(struct user_ctxs *user)
+static int read_fpsimd_context(struct user_fpsimd_state *fpsimd,
+			       struct user_ctxs *user)
 {
-	struct user_fpsimd_state fpsimd;
-	int err = 0;
+	int err;
 
 	/* check the size information */
 	if (user->fpsimd_size != sizeof(struct fpsimd_context))
 		return -EINVAL;
 
 	/* copy the FP and status/control registers */
-	err = __copy_from_user(fpsimd.vregs, &(user->fpsimd->vregs),
-			       sizeof(fpsimd.vregs));
-	__get_user_error(fpsimd.fpsr, &(user->fpsimd->fpsr), err);
-	__get_user_error(fpsimd.fpcr, &(user->fpsimd->fpcr), err);
+	err = __copy_from_user(fpsimd->vregs, &(user->fpsimd->vregs),
+			       sizeof(fpsimd->vregs));
+	__get_user_error(fpsimd->fpsr, &(user->fpsimd->fpsr), err);
+	__get_user_error(fpsimd->fpcr, &(user->fpsimd->fpcr), err);
+
+	return err ? -EFAULT : 0;
+}
+
+static int restore_fpsimd_context(struct user_ctxs *user)
+{
+	struct user_fpsimd_state fpsimd;
+	int err;
+
+	err = read_fpsimd_context(&fpsimd, user);
+	if (err)
+		return err;
 
 	clear_thread_flag(TIF_SVE);
 	current->thread.fp_type = FP_STATE_FPSIMD;
 
 	/* load the hardware registers from the fpsimd_state structure */
-	if (!err)
-		fpsimd_update_current_state(&fpsimd);
-
-	return err ? -EFAULT : 0;
+	fpsimd_update_current_state(&fpsimd);
+	return 0;
 }
 
 
@@ -316,12 +326,8 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	 * consistency and robustness, reject restoring streaming SVE state
 	 * without an SVE payload.
 	 */
-	if (!sm && user->sve_size == sizeof(*user->sve)) {
-		clear_thread_flag(TIF_SVE);
-		current->thread.svcr &= ~SVCR_SM_MASK;
-		current->thread.fp_type = FP_STATE_FPSIMD;
-		goto fpsimd_only;
-	}
+	if (!sm && user->sve_size == sizeof(*user->sve))
+		return restore_fpsimd_context(user);
 
 	vq = sve_vq_from_vl(vl);
 
@@ -357,19 +363,14 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 		set_thread_flag(TIF_SVE);
 	current->thread.fp_type = FP_STATE_SVE;
 
-fpsimd_only:
-	/* copy the FP and status/control registers */
-	/* restore_sigframe() already checked that user->fpsimd != NULL. */
-	err = __copy_from_user(fpsimd.vregs, user->fpsimd->vregs,
-			       sizeof(fpsimd.vregs));
-	__get_user_error(fpsimd.fpsr, &user->fpsimd->fpsr, err);
-	__get_user_error(fpsimd.fpcr, &user->fpsimd->fpcr, err);
+	err = read_fpsimd_context(&fpsimd, user);
+	if (err)
+		return err;
 
-	/* load the hardware registers from the fpsimd_state structure */
-	if (!err)
-		fpsimd_update_current_state(&fpsimd);
+	/* Merge the FPSIMD registers into the SVE state */
+	fpsimd_update_current_state(&fpsimd);
 
-	return err ? -EFAULT : 0;
+	return 0;
 }
 
 #else /* ! CONFIG_ARM64_SVE */
-- 
2.51.0


