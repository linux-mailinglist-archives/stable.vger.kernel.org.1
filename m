Return-Path: <stable+bounces-252221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBmIMXcjDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:11:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D8359A857
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AA7238F45D2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139D53F20FF;
	Wed, 20 May 2026 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QHWnC9ZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7736CE19;
	Wed, 20 May 2026 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300109; cv=none; b=ekFJzo0BVCSDLHscak8R+pZQ3pcaMdPDERSeYjKv+o6ybie9+qemasAgXzEAEmn6vK/L92ySiyrp4NjU9ti5bVO8dLl7IFV9HN6oU/SRY6CGT3F8zDmrzJK5GfrljUgwATekr2KSyNM1iKdd2K5wQi6/WhZeN1WtcWpJhIrPsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300109; c=relaxed/simple;
	bh=32AhLjJSvPb+agBSk1S12PpvL7piEbHtBU5nJWo4Pm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPEn+3xGphIVwde7ayYd3Yi5Zy7Lwbi6pE0K5TM2D48tkAqXZl5ZnxA8T+Dpd/Ulu3RTv7nmpAxmKWidLJDfTLJ6T7cj8JPz7boWJbyG1A+TNDOGHnbSWHlntX4DQwBjLOGjSSstZsQe6uvdH2cuQTdShhB6+oy8i1KOVBO4BOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QHWnC9ZD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398211F000E9;
	Wed, 20 May 2026 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300108;
	bh=ebmtBwCrPRvJZsLPfUn/Jw2E7KWlGcMxef/f3c3rGsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QHWnC9ZD9fhSJBvMayvKncAigKOPBRXm7WykstBN75EzKcduWW4F1tc+K7wk2nGoX
	 Q6swi6soND7gS2FN8x7riXETTVIdQfm4cHAUnR35Akq0tQz2mwKs/U2IPDhdghIWqr
	 M7F5fqssDA88ykHVX0rjaKdXgq28ABuNNvZZSS1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Clark <james.clark@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Colton Lewis <coltonlewis@google.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 050/666] arm64: cpufeature: Make PMUVer and PerfMon unsigned
Date: Wed, 20 May 2026 18:14:21 +0200
Message-ID: <20260520162112.324603653@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252221-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: 67D8359A857
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Clark <james.clark@linaro.org>

[ Upstream commit d1dcc20bcc40efe1f1c71639376c91dafa489222 ]

On the host, this change doesn't make a difference because the fields
are defined as FTR_EXACT. However, KVM allows userspace to set these
fields for a guest and overrides the type to be FTR_LOWER_SAFE. And
while KVM used to do an unsigned comparison to validate that the new
value is lower than what the hardware provides, since the linked commit
it uses the generic sanitization framework which does a signed
comparison.

Fix it by defining these fields as unsigned. In theory, without this
fix, userspace could set a higher PMU version than the hardware supports
by providing any value with the top bit set.

Fixes: c118cead07a7 ("KVM: arm64: Use generic sanitisation for ID_(AA64)DFR0_EL1")
Signed-off-by: James Clark <james.clark@linaro.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Colton Lewis <coltonlewis@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5e68d65e675e5..8246015fd2d73 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -533,7 +533,7 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 	 * We can instantiate multiple PMU instances with different levels
 	 * of support.
 	 */
-	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64DFR0_EL1_PMUVer_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64DFR0_EL1_PMUVer_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_EL1_DebugVer_SHIFT, 4, 0x6),
 	ARM64_FTR_END,
 };
@@ -677,7 +677,7 @@ static const struct arm64_ftr_bits ftr_id_pfr2[] = {
 
 static const struct arm64_ftr_bits ftr_id_dfr0[] = {
 	/* [31:28] TraceFilt */
-	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_DFR0_EL1_PerfMon_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_DFR0_EL1_PerfMon_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR0_EL1_MProfDbg_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR0_EL1_MMapTrc_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR0_EL1_CopTrc_SHIFT, 4, 0),
-- 
2.53.0




