Return-Path: <stable+bounces-152848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3A0ADCDA9
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED7C3AF3DD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A80F2E2655;
	Tue, 17 Jun 2025 13:37:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE1F21FF53
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167462; cv=none; b=PmNwAR1Cnbr4mIhj5Ca9J7U+FydEds3g3JyG6GSpbPxst9nE96vj1fGeqbPBwuW4h4nCYZbyISVs5h5c8SiBLtT5Pk9DKUC08df0blL9ldhtGroakTBKfM0tyw1DDNzmEnN6rStiRKnUlxiBda8FVbW5QCK7Sch1HdDVhKWzWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167462; c=relaxed/simple;
	bh=CRrQrQa6BBj/BkMwaNWjh8/VRkAWGpg+AprDLpfOwfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsIhghdZxeQc3Qloe/G/AcXQKrAskdOXk+/9nT2Pk9q67ad2SrasNViAzC98HnouIzRy7qarhgVu5Fms61oWKOXxVDEUAGe+u3wEk97+4JspsymVyaF5docj4kdpZZHH1tTO6yfy1sA1GctgM2A8gtYTtT59OmlB5ELJNMddCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDE061595;
	Tue, 17 Jun 2025 06:37:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2001B3F673;
	Tue, 17 Jun 2025 06:37:37 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	kvmarm@lists.linux.dev,
	mark.rutland@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	stable@vger.kernel.org,
	tabba@google.com,
	will@kernel.org
Subject: [PATCH 4/7] KVM: arm64: Remove ad-hoc CPTR manipulation from fpsimd_sve_sync()
Date: Tue, 17 Jun 2025 14:37:15 +0100
Message-Id: <20250617133718.4014181-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250617133718.4014181-1-mark.rutland@arm.com>
References: <20250617133718.4014181-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need for fpsimd_sve_sync() to write to CPTR/CPACR. All
relevant traps are always disabled earlier within __kvm_vcpu_run(), when
__deactivate_cptr_traps() configures CPTR/CPACR.

With irrelevant details elided, the flow is:

handle___kvm_vcpu_run(...)
{
	flush_hyp_vcpu(...) {
		fpsimd_sve_flush(...);
	}

	__kvm_vcpu_run(...) {
		__activate_traps(...) {
			__activate_cptr_traps(...);
		}

		do {
			__guest_enter(...);
		} while (...);

		__deactivate_traps(....) {
			__deactivate_cptr_traps(...);
		}
	}

	sync_hyp_vcpu(...) {
		fpsimd_sve_sync(...);
	}
}

Remove the unnecessary write to CPTR/CPACR. An ISB is still necessary,
so a comment is added to describe this requirement.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index e9198e56e784b..3206b2c07f82a 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -69,7 +69,10 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 	if (!guest_owns_fp_regs())
 		return;
 
-	cpacr_clear_set(0, CPACR_EL1_FPEN | CPACR_EL1_ZEN);
+	/*
+	 * Traps have been disabled by __deactivate_cptr_traps(), but there
+	 * hasn't necessarily been a context synchronization event yet.
+	 */
 	isb();
 
 	if (vcpu_has_sve(vcpu))
-- 
2.30.2


