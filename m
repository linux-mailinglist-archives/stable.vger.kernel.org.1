Return-Path: <stable+bounces-260032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vNVzKNoMIGpYvAAAu9opvQ
	(envelope-from <stable+bounces-260032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:15:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B2636EE0
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:15:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=agyrPwbx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260032-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260032-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 962773083D16
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 11:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EFF368D5C;
	Wed,  3 Jun 2026 11:06:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91444534B7
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:06:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484806; cv=none; b=RSdxsLKfUUe25/vLsu1fJEw8zNKaKK90v5JnTirSLw+rQDIG1rRVrKNV4pOjU0YR90ujepNxkLFljVTirnfnSWKVaIsqy0rjccFmGywqZ5qPBgFGNz7D8WfL6oPytbQIdTe5fmO1P3ckvRBOW5TZ559rABFj4MhPnNI/OnFNKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484806; c=relaxed/simple;
	bh=BnwUXwvh7pSQsF8AtqSRuADbPlzg8hrur6QO/WXNcE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QXs9J0WFchiSKtaBgajrn4YjZWPw1gR+qVgKQ93A6q7Qk7vPGUY8ZOEqYsmcnquxhhyHm2SdWKhZUgtpnvdED8TPcF9fcV2UkwyFi5cacyy55HrgGJMIAs1NurvaqU30715ff1sR13ZApnczIxa0UtMimoVZds7UE7kKnz9BPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=agyrPwbx; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8760332E4;
	Wed,  3 Jun 2026 04:06:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD4443F86F;
	Wed,  3 Jun 2026 04:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484804; bh=BnwUXwvh7pSQsF8AtqSRuADbPlzg8hrur6QO/WXNcE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agyrPwbxZHm2k1g1jCOwpkwWZKvoZv28vw884L96CxRoRDzuS6byUKibUQxiiMSq2
	 44pjYD1AKVQiU8iAMOaMmoPuyf7qv+Gt4dVw30WmLQSmc3JUR140Q7gBFHphV98DsX
	 A4IeKBeOjdI667hWga4cGseIyGbxdrNyzC+3qH1Y=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	stable@vger.kernel.org,
	tabba@google.com,
	vladimir.murzin@arm.com,
	will@kernel.org
Subject: [PATCH v4 01/20] arm64: fpsimd: Fix type mismatch in sve_{save,load}_state()
Date: Wed,  3 Jun 2026 12:06:11 +0100
Message-Id: <20260603110630.1027435-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260603110630.1027435-1-mark.rutland@arm.com>
References: <20260603110630.1027435-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-260032-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:broonie@kernel.org,m:catalin.marinas@arm.com,m:james.morse@arm.com,m:mark.rutland@arm.com,m:maz@kernel.org,m:oupton@kernel.org,m:stable@vger.kernel.org,m:tabba@google.com,m:vladimir.murzin@arm.com,m:will@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 441B2636EE0

The sve_save_state() and sve_load_state() functions take a 32-bit int
argument that describes whether to save/restore the FFR. Their assembly
implementations consume the entire 64-bit register containing this
32-bit value, and will attempt to save/restore the FFR if any bit of
that 64-bit register is non-zero.

Per the AAPCS64 parameter passing rules, the callee is responsible for
any necessary widening, and the upper 32-bits are permitted to contain
arbitrary values. If the upper 32 bits are non-zero, this could result
in an unexpected attempt to save/restore the FFR, and consequently could
lead to unexpected traps/undefs/faults.

In practice compilers are very unlikely to generate code where the upper
32-bits would be non-zero, but they are permitted to do so.

Fix this by only consuming the low 32 bits of the register, and update
comments accordingly.

The hyp code __sve_save_state() and __sve_restore_state() functions
don't have the same latent bug as they override the full 64-bit register
containing the argument.

Fixes: 9f5848665788 ("arm64/sve: Make access to FFR optional")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/entry-fpsimd.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 6325db1a2179c..cb08d879cb4de 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -38,10 +38,10 @@ SYM_FUNC_END(fpsimd_load_state)
  *
  * x0 - pointer to buffer for state
  * x1 - pointer to storage for FPSR
- * x2 - Save FFR if non-zero
+ * w2 - Save FFR if non-zero
  */
 SYM_FUNC_START(sve_save_state)
-	sve_save 0, x1, x2, 3
+	sve_save 0, x1, w2, 3
 	ret
 SYM_FUNC_END(sve_save_state)
 
@@ -50,10 +50,10 @@ SYM_FUNC_END(sve_save_state)
  *
  * x0 - pointer to buffer for state
  * x1 - pointer to storage for FPSR
- * x2 - Restore FFR if non-zero
+ * w2 - Restore FFR if non-zero
  */
 SYM_FUNC_START(sve_load_state)
-	sve_load 0, x1, x2, 4
+	sve_load 0, x1, w2, 4
 	ret
 SYM_FUNC_END(sve_load_state)
 
-- 
2.30.2


