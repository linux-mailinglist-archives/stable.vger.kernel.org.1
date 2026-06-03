Return-Path: <stable+bounces-260035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GrfQDC8NIGpzvAAAu9opvQ
	(envelope-from <stable+bounces-260035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:17:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CE3636F19
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:17:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=qpvjIdOA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260035-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260035-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1560B30B8DD0
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4867441022;
	Wed,  3 Jun 2026 11:06:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232F24611EE
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:06:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484812; cv=none; b=dVoFzec/8qNz5MQ86eot1Lfdj6Iu3PV1sDtANWAgvuOqRq+gwawEQG4yYCCPbBPk/qQm9G70DyAkutRWp+sJwspQqlBs5FetIO3ILTeED7p+pqcBHHD39G4eK3S9hkxp/r57miNC2s+b6CxO39ldjYM2tqF3Wq7Iv/YQ8rXQt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484812; c=relaxed/simple;
	bh=W6P26d/kErOA0izTtTGBCaL/vzda5y7B9/4LMfwwkUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aC3C1yj+4IjgksUDMHJwuSQsh3zxvxDE0A+OEAupD6Aa+0GTXiMNw3VSf36Eyi06cUmHuqVm62NNzxeRDXLZCr0DSc8aAOPmS92fCzZ+IJKqiQ3bhq8TYNHN8cPgiRjkyId68U4J0XgmJ0vrDOdeAsSDzn4PVA4voPRG3ynkQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qpvjIdOA; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3C4549E3;
	Wed,  3 Jun 2026 04:06:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE8173F86F;
	Wed,  3 Jun 2026 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484810; bh=W6P26d/kErOA0izTtTGBCaL/vzda5y7B9/4LMfwwkUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpvjIdOAwV2/6Bb1QsDvVYa/Sr6kMhS3bVzVfOXpRRVDleA4ASaIKaMGWSjFG4qkM
	 9WX5n11YA14VbGJWc8cFLfcRPKH4q4JuFVqtg57BqcjyNWd9bjFWK94vUdi0qWqNTa
	 VqO4243r9kiFe1fBmQMgehlYF9l/zK1JXeV4Lyr4=
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
Subject: [PATCH v4 04/20] KVM: arm64: Don't override FFR save/restore argument
Date: Wed,  3 Jun 2026 12:06:14 +0100
Message-Id: <20260603110630.1027435-5-mark.rutland@arm.com>
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
	TAGGED_FROM(0.00)[bounces-260035-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0CE3636F19

The __sve_save_state() and __sve_restore_state() functions take a
parameter describing whether to save/restore the FFR, but both functions
silently override this with '1'. This has always been benign (and
callers have all passed 'true' since the parameter was introduced), but
clearly this is not intentional.

Historically, the functions always saved/restored the FFR, and there was
no parameter to control this.

In v5.16, the sve_save and sve_load assembly macros used by
__sve_save_state() and __sve_restore_state() were changed to make
saving/restoring FFR optional. The implementations of __sve_save_state()
and __sve_restore_state() were changed to pass '1' to their respective
macros, and the prototypes of __sve_save_state() and
__sve_restore_state() were unchanged. See commit:

  9f5848665788 ("arm64/sve: Make access to FFR optional")

In v6.10, the prototypes of __sve_save_state() and __sve_restore_state()
were changed to add 'save_ffr' and 'restore_ffr' parameters
respectively, but the implementations were not changed to stop passing 1
to their respective macros. All callers were changed to pass 'true' to
__sve_save_state() and __sve_restore_state(). See commit:

  45f4ea9bcfe9 ("KVM: arm64: Fix prototype for __sve_save_state/__sve_restore_state")

This is all benign, but clearly unintentional, and it gets in the way of
cleaning up the FPSIMD/SVE/SME code. Remove the unnecessary overriding.

The 'save_ffr' and 'restore_ffr' parameters are 32-bit ints, and per the
AAPCS64 parameter passing rules, the upper 32 bits of the register
holding these arguments might contain arbitrary values. Thus it is
necessary to pass 'w2' rather than 'x2' to the sve_load and save_save
macros, such that the upper 32 bits are ignored when deciding whether to
save/restore the FFR.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/fpsimd.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index e950875e31cee..30507c50942eb 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -21,13 +21,11 @@ SYM_FUNC_START(__fpsimd_restore_state)
 SYM_FUNC_END(__fpsimd_restore_state)
 
 SYM_FUNC_START(__sve_restore_state)
-	mov	x2, #1
-	sve_load 0, x1, x2, 3
+	sve_load 0, x1, w2, 3
 	ret
 SYM_FUNC_END(__sve_restore_state)
 
 SYM_FUNC_START(__sve_save_state)
-	mov	x2, #1
-	sve_save 0, x1, x2, 3
+	sve_save 0, x1, w2, 3
 	ret
 SYM_FUNC_END(__sve_save_state)
-- 
2.30.2


