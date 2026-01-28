Return-Path: <stable+bounces-212672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GefCrVyemme6gEAu9opvQ
	(envelope-from <stable+bounces-212672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:33:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C23E7A89D8
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2533C3005ABF
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 20:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D90336EE5;
	Wed, 28 Jan 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEGGcnHg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6923168E6
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632432; cv=none; b=OTY7BVSnhI+g24cBI/hOY0ei2JzOxQbkC/w0o7ilOWTPNCmwH0uj8AWP3JwC/AdKCVKI4IrGDKuHSJHHBoBo35ltYZfWMSG17lXaplfky08mgXVym45szRVHp1MlsaRBYOcCQS4u1F+FkV0DrQyH53MC8QDVD6ix7+9u01AtaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632432; c=relaxed/simple;
	bh=ELffHCP1tAZDB9jqrk5H1rITbtFmSGXB2eFcYnZqM+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZDrjxZf33+UboNVW9TsX1z+y3kIy3wLAnOhD0CY0uaZRWA5GhqBK6fKEPkMV5Hb4N2i8ZnDVjPRf67Rw/1eA4sOQVCqoAvW7XcBDTRG7KygaymFXrV50cM/qT/+42v83aFQbJeqpyOKGbNV6YUulcsuhbdzjxe4Hb9oRR6Ph0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEGGcnHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960E5C4CEF1;
	Wed, 28 Jan 2026 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632432;
	bh=ELffHCP1tAZDB9jqrk5H1rITbtFmSGXB2eFcYnZqM+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEGGcnHgM2bTSj5yW9MPr/2GYMQYnWQBJg2doCb8thCZHEzckkZiexgYGZNsR0mIH
	 IUglv2/6hsAEoL6ULVLPcleSFI8rH+3kZxbl4HTO4nsSTYrTSTWFb0tA0XwqZZKnTC
	 fuURHyoMTDhYOg5z02Vf+9XjpdLalXR+iiLempmQjTdBei+1pgyW69i51yUxPDD06q
	 RhO4W0noIKFNJIDJbIFt5/GSdz0UP0mB5+0fdiPqrOGSOrjr4PnmJGSir6vqvK0Z+4
	 hNJPBalJl77im1N18S5v3j89EK4on2CDZKPmGKXA842SEmgEPnK7oaoCav3CU7cHpP
	 SCeMYGi87JgOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] arm64/fpsimd: signal: Mandate SVE payload for streaming-mode state
Date: Wed, 28 Jan 2026 15:33:48 -0500
Message-ID: <20260128203350.2720303-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012703-skintight-tricycle-0f20@gregkh>
References: <2026012703-skintight-tricycle-0f20@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212672-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: C23E7A89D8
X-Rspamd-Action: no action

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit b465ace42620970e840c7aeb2c44a6e3b1002fec ]

Non-streaming SVE state may be preserved without an SVE payload, in
which case the SVE context only has a header with VL==0, and all state
can be restored from the FPSIMD context. Streaming SVE state is always
preserved with an SVE payload, where the SVE context header has VL!=0,
and the SVE_SIG_FLAG_SM flag is set.

The kernel never preserves an SVE context where SVE_SIG_FLAG_SM is set
without an SVE payload. However, restore_sve_fpsimd_context() doesn't
forbid restoring such a context, and will handle this case by clearing
PSTATE.SM and restoring the FPSIMD context into non-streaming mode,
which isn't consistent with the SVE_SIG_FLAG_SM flag.

Forbid this case, and mandate an SVE payload when the SVE_SIG_FLAG_SM
flag is set. This avoids an awkward ABI quirk and reduces the risk that
later rework to this code permits configuring a task with PSTATE.SM==1
and fp_type==FP_STATE_FPSIMD.

I've marked this as a fix given that we never intended to support this
case, and we don't want anyone to start relying upon the old behaviour
once we re-enable SME.

Fixes: 85ed24dad290 ("arm64/sme: Implement streaming SVE signal handling")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20250508132644.1395904-4-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: d2907cbe9ea0 ("arm64/fpsimd: signal: Fix restoration of SVE context")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/signal.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 425b1bc17a3f6..916207828faaa 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -276,6 +276,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	unsigned int vl, vq;
 	struct user_fpsimd_state fpsimd;
 	u16 user_vl, flags;
+	bool sm;
 
 	if (user->sve_size < sizeof(*user->sve))
 		return -EINVAL;
@@ -285,7 +286,8 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (err)
 		return err;
 
-	if (flags & SVE_SIG_FLAG_SM) {
+	sm = flags & SVE_SIG_FLAG_SM;
+	if (sm) {
 		if (!system_supports_sme())
 			return -EINVAL;
 
@@ -305,7 +307,16 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (user_vl != vl)
 		return -EINVAL;
 
-	if (user->sve_size == sizeof(*user->sve)) {
+	/*
+	 * Non-streaming SVE state may be preserved without an SVE payload, in
+	 * which case the SVE context only has a header with VL==0, and all
+	 * state can be restored from the FPSIMD context.
+	 *
+	 * Streaming SVE state is always preserved with an SVE payload. For
+	 * consistency and robustness, reject restoring streaming SVE state
+	 * without an SVE payload.
+	 */
+	if (!sm && user->sve_size == sizeof(*user->sve)) {
 		clear_thread_flag(TIF_SVE);
 		current->thread.svcr &= ~SVCR_SM_MASK;
 		current->thread.fp_type = FP_STATE_FPSIMD;
-- 
2.51.0


