Return-Path: <stable+bounces-169478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E214B2588B
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 02:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D255E1C05D0C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 00:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B666111BF;
	Thu, 14 Aug 2025 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZKnOQ9K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F12FF66A
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132516; cv=none; b=Bb3tJNtDOoR0Zf2Vdwm2SVGKFg0oN/dvdQMDWxBNgKTMCjg1N71tDQIBRBRYnUYO4SeyqcNbj50wGCd8eA5xH1IDGyktZLLQaTJfyd95braq2xqgfBMhcJSqMg2JonpiaGL5NzpIbjYko8o8V3oEI84+Y0mcnsH8O13z6Tut0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132516; c=relaxed/simple;
	bh=dzA61hT+alJEZgNR/zn33eONnW4NJRTRmur07lw7UuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CP/ZX4WemchrFQsR2s7K+otu8fzGYYBeEazVkrNk2RiAV+L447caGIbSm2p2h5zUv9oDyG/JqGS9UJoKEqPQ6XSlwexU1IjcZXgbLBM4MxS4yyDes21jDYHbpTQ1kbOpni1TzLeIGpIikbbcDT7nLnzYI9MZ1gwj0eM/Xyqky98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZKnOQ9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DD6C4CEED;
	Thu, 14 Aug 2025 00:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755132515;
	bh=dzA61hT+alJEZgNR/zn33eONnW4NJRTRmur07lw7UuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZKnOQ9KmVW6oTeEXCtwjLYWKQGoVhmVlI+vHZn3c5ibj0yKyks8QzGELzOr4RTUa
	 /qCXsgX9qwUHZQn06NzzLu005BYqN5R3k2w2a1apajsfOzEp8TmiOlc4J65kvpNWS9
	 l/TmODxdPOirhN77x+N9KRES0lRPHcq+vxirCzfsbZR7vXAXwL+Ki1p1YcpugzC2oq
	 WXr0T0zn8tsKacAfGaEXB8r1VznMHcBScyslvIF+zoDmDd9wTYQ8ek7ILajIcbp5/X
	 QpHfCgV4elqjI9xTh4SRkzElrUDOddSuz+JA1ov7R4oqerRPOZu4CR7VJm4l5bPAyt
	 sH/Kso96M0mNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 2/5] KVM: arm64: Fix MDCR_EL2.HPMN reset value
Date: Wed, 13 Aug 2025 17:18:17 -0400
Message-Id: <20250813211820.2074887-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813211820.2074887-1-sashal@kernel.org>
References: <2025081248-omission-talisman-0619@gregkh>
 <20250813211820.2074887-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit c8823e51b534d490ec27d372596eb35d2bb7193c ]

The MDCR_EL2 documentation indicates that the HPMN field has
the following behaviour:

"On a Warm reset, this field resets to the expression NUM_PMU_COUNTERS."

However, it appears we reset it to zero, which is not very useful.

Add a reset helper for MDCR_EL2, and handle the case where userspace
changes the target PMU, which may force us to change HPMN again.

Reported-by: Joey Gouly <joey.gouly@arm.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Stable-dep-of: c6e35dff58d3 ("KVM: arm64: Check for SYSREGS_ON_CPU before accessing the CPU state")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/pmu-emul.c | 20 +++++++++++++++++++-
 arch/arm64/kvm/sys_regs.c |  8 +++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 60b5a5e4a6c5..2df54508f5ae 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -1027,12 +1027,30 @@ u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 	return bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
 }
 
+static void kvm_arm_set_nr_counters(struct kvm *kvm, unsigned int nr)
+{
+	kvm->arch.nr_pmu_counters = nr;
+
+	/* Reset MDCR_EL2.HPMN behind the vcpus' back... */
+	if (test_bit(KVM_ARM_VCPU_HAS_EL2, kvm->arch.vcpu_features)) {
+		struct kvm_vcpu *vcpu;
+		unsigned long i;
+
+		kvm_for_each_vcpu(i, vcpu, kvm) {
+			u64 val = __vcpu_sys_reg(vcpu, MDCR_EL2);
+			val &= ~MDCR_EL2_HPMN;
+			val |= FIELD_PREP(MDCR_EL2_HPMN, kvm->arch.nr_pmu_counters);
+			__vcpu_sys_reg(vcpu, MDCR_EL2) = val;
+		}
+	}
+}
+
 static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
 {
 	lockdep_assert_held(&kvm->arch.config_lock);
 
 	kvm->arch.arm_pmu = arm_pmu;
-	kvm->arch.nr_pmu_counters = kvm_arm_pmu_get_max_counters(kvm);
+	kvm_arm_set_nr_counters(kvm, kvm_arm_pmu_get_max_counters(kvm));
 }
 
 /**
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 554490360ff6..c1e900a66d35 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2704,6 +2704,12 @@ static int set_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	.set_user = set_imp_id_reg,			\
 	.reset = reset_imp_id_reg,			\
 	.val = mask,					\
+	}
+
+static u64 reset_mdcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	__vcpu_sys_reg(vcpu, r->reg) = vcpu->kvm->arch.nr_pmu_counters;
+	return vcpu->kvm->arch.nr_pmu_counters;
 }
 
 /*
@@ -3249,7 +3255,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	EL2_REG(SCTLR_EL2, access_rw, reset_val, SCTLR_EL2_RES1),
 	EL2_REG(ACTLR_EL2, access_rw, reset_val, 0),
 	EL2_REG_VNCR(HCR_EL2, reset_hcr, 0),
-	EL2_REG(MDCR_EL2, access_mdcr, reset_val, 0),
+	EL2_REG(MDCR_EL2, access_mdcr, reset_mdcr, 0),
 	EL2_REG(CPTR_EL2, access_rw, reset_val, CPTR_NVHE_EL2_RES1),
 	EL2_REG_VNCR(HSTR_EL2, reset_val, 0),
 	EL2_REG_VNCR(HFGRTR_EL2, reset_val, 0),
-- 
2.39.5


