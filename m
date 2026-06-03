Return-Path: <stable+bounces-260033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UAxfCCQNIGpwvAAAu9opvQ
	(envelope-from <stable+bounces-260033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:16:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB46636F11
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:16:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=tkK8gR6t;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260033-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260033-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B102533216D4
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13EF43901A;
	Wed,  3 Jun 2026 11:06:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D935A426EB2
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:06:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484808; cv=none; b=XYDO60i5j0DKsMvUZJg3s0P7Y3X51R+iCvrSixHs6ouFql9LcpZfiWcpjUuWoNIvHHertwYAxwRzc4hufytJQZjJ1Tqg7G4+Mk2AOXOlMknADRIvgcS4sEELZ68abB/OU8UO3mOZG3EKXcVUnL3Hi0VXjqNR/75KbqXAAVV62LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484808; c=relaxed/simple;
	bh=Bh+v4+Q9R9M0vVBjMBPjKFVsCuf/4i+18Kgt05hQyuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gL6WibzXqd+PwIBOcqQOD7vlHYK5ihkBM61UHG3xHi2ela+3M/DUgi+w05mKRNqI6GDb5u2G1Z5gnJHX0bWi92xz6a7Rsq7jGkd8IFxNxUhXCtUuimRv4SHFyBlPC2xt9QAkrDX1xVuUmTKOsiarFbWGUCGdAY8WEBs63ajUTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tkK8gR6t; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9352349E3;
	Wed,  3 Jun 2026 04:06:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C01553F86F;
	Wed,  3 Jun 2026 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484806; bh=Bh+v4+Q9R9M0vVBjMBPjKFVsCuf/4i+18Kgt05hQyuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tkK8gR6tIGdPYfWq4WCumqWzWwJfaHKG3PSohgv0X6yGGme+noEhBJt6/fZokIU5W
	 gnn2yTaOpwT4QncYUOBZR9/aKLP33fgQPfmL8ERrwaVIHdm5GpcsuBoI7t1YaFddeJ
	 VnKQshuGbfp1YS8MaXhvCRLHSJ9rN70Fi57aywSM=
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
Subject: [PATCH v4 02/20] arm64: fpsimd: Fix type mismatch in sme_{save,load}_state()
Date: Wed,  3 Jun 2026 12:06:12 +0100
Message-Id: <20260603110630.1027435-3-mark.rutland@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-260033-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EB46636F11

The sme_save_state() and sme_load_state() functions take a 32-bit int
argument that describes whether to save/restore ZT0. Their assembly
implementations consume the entire 64-bit register containing this
32-bit value, and will attempt to save/restore ZT0 if any bit of
that 64-bit register is non-zero.

Per the AAPCS64 parameter passing rules, the callee is responsible for
any necessary widening, and the upper 32-bits are permitted to contain
arbitrary values. If the upper 32 bits are non-zero, this could result
in an unexpected attempt to save/restore ZT0, and consequently could
lead to unexpected traps/undefs/faults.

In practice compilers are very unlikely to generate code where the upper
32-bits would be non-zero, but they are permitted to do so.

Fix this by only consuming the low 32 bits of the register, and update
comments accordingly.

Fixes: 95fcec713259 ("arm64/sme: Implement context switching for ZT0")
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
index cb08d879cb4de..28af4bcd97a50 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -103,13 +103,13 @@ SYM_FUNC_END(sme_set_vq)
  * Save the ZA and ZT state
  *
  * x0 - pointer to buffer for state
- * x1 - number of ZT registers to save
+ * w1 - number of ZT registers to save
  */
 SYM_FUNC_START(sme_save_state)
 	_sme_rdsvl	2, 1		// x2 = VL/8
 	sme_save_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
 
-	cbz	x1, 1f
+	cbz	w1, 1f
 	_str_zt 0
 1:
 	ret
@@ -119,13 +119,13 @@ SYM_FUNC_END(sme_save_state)
  * Load the ZA and ZT state
  *
  * x0 - pointer to buffer for state
- * x1 - number of ZT registers to save
+ * w1 - number of ZT registers to save
  */
 SYM_FUNC_START(sme_load_state)
 	_sme_rdsvl	2, 1		// x2 = VL/8
 	sme_load_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
 
-	cbz	x1, 1f
+	cbz	w1, 1f
 	_ldr_zt 0
 1:
 	ret
-- 
2.30.2


