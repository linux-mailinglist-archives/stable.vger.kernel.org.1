Return-Path: <stable+bounces-169477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A333DB2588A
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 02:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CF91C05C53
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB92341AA;
	Thu, 14 Aug 2025 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwkuaVzD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6E111BF
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132515; cv=none; b=cD5qbgioZSS9gPToQT622GqUqklCCvGC8lMZu2fxZX1sJbfuc8HaR1bl5L4yert/RDvBDFbfDF/1CAapyZZc6e/kLTKz9WFtenrlykssGNo5ZJPX1qJBZhvv2h5vFmjvDVEdeduUUt34BFVD7S+bNn+Ms5xUbguyFxAjkY3VK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132515; c=relaxed/simple;
	bh=aBL9Ze5h8A07YcxgbVSmo7w6eqhSLDHkL7Qpu7YzueM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPzKZzwmMwJ3WIkzdblz+WA+TPtUXN1BiSo6Q7gWdN7z3iHvpGqH0o0Iistp/KFTdttdfGB8Vyycwj3EvOG//1R64Hb7VKp14o+a16VyHbTJS/qgi4Ifl23fa/VsXBvd6KeGDMQ52+CZeUggWf+le8RmLuVAazwEi1TbyyCspwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwkuaVzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA619C4CEEB;
	Thu, 14 Aug 2025 00:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755132514;
	bh=aBL9Ze5h8A07YcxgbVSmo7w6eqhSLDHkL7Qpu7YzueM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwkuaVzDUR5Nm1XuW2KWKh5ANbFNP35MkZ9Cxroh2e1r2QvSBBjARpkFCBb/MVInT
	 Y+JjyhF9YIRr42lKGNT0XSCU1IYjn1Zdg9qs41i0jMba6FV6RNpECJ/6qNBq2qF31C
	 R+y2iIMYPPXm0qupRLdVbaylhXHszJ7VZkfaZoOCvaULrnn/WVj5+QPxV41zrdnMvl
	 kFYUpP7uh+RJcAClLzxIdVf4LgE9dXAFlrk8CnF1Zx7NWwk3VhSXxf+dGwLHGuzlas
	 QGeCJAJzd6+WtoXNAshxSskReU1mQ6uTDXtDIChKfDCJqmm9Kxl9IpiWCVA6VGfAw9
	 jHbmZrtUGZuyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver upton <oliver.upton@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 1/5] KVM: arm64: Repaint pmcr_n into nr_pmu_counters
Date: Wed, 13 Aug 2025 17:18:16 -0400
Message-Id: <20250813211820.2074887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081248-omission-talisman-0619@gregkh>
References: <2025081248-omission-talisman-0619@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit f12b54d7c24388886277598236b3eeea5c68eec4 ]

The pmcr_n field obviously refers to PMCR_EL0.N, but is generally used
as the number of counters seen by the guest. Rename it accordingly.

Suggested-by: Oliver upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Stable-dep-of: c6e35dff58d3 ("KVM: arm64: Check for SYSREGS_ON_CPU before accessing the CPU state")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 4 ++--
 arch/arm64/kvm/pmu-emul.c         | 6 +++---
 arch/arm64/kvm/sys_regs.c         | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 08ba91e6fb03..bea8ae1b1b02 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -359,8 +359,8 @@ struct kvm_arch {
 
 	cpumask_var_t supported_cpus;
 
-	/* PMCR_EL0.N value for the guest */
-	u8 pmcr_n;
+	/* Maximum number of counters for the guest */
+	u8 nr_pmu_counters;
 
 	/* Iterator for idreg debugfs */
 	u8	idreg_debugfs_iter;
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index a1bc10d7116a..60b5a5e4a6c5 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -280,7 +280,7 @@ static u64 kvm_pmu_hyp_counter_mask(struct kvm_vcpu *vcpu)
 		return 0;
 
 	hpmn = SYS_FIELD_GET(MDCR_EL2, HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
-	n = vcpu->kvm->arch.pmcr_n;
+	n = vcpu->kvm->arch.nr_pmu_counters;
 
 	/*
 	 * Programming HPMN to a value greater than PMCR_EL0.N is
@@ -1032,7 +1032,7 @@ static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
 	lockdep_assert_held(&kvm->arch.config_lock);
 
 	kvm->arch.arm_pmu = arm_pmu;
-	kvm->arch.pmcr_n = kvm_arm_pmu_get_max_counters(kvm);
+	kvm->arch.nr_pmu_counters = kvm_arm_pmu_get_max_counters(kvm);
 }
 
 /**
@@ -1261,7 +1261,7 @@ u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 {
 	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
 
-	return u64_replace_bits(pmcr, vcpu->kvm->arch.pmcr_n, ARMV8_PMU_PMCR_N);
+	return u64_replace_bits(pmcr, vcpu->kvm->arch.nr_pmu_counters, ARMV8_PMU_PMCR_N);
 }
 
 void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 5dde9285afc8..554490360ff6 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -785,7 +785,7 @@ static unsigned int pmu_visibility(const struct kvm_vcpu *vcpu,
 static u64 reset_pmu_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	u64 mask = BIT(ARMV8_PMU_CYCLE_IDX);
-	u8 n = vcpu->kvm->arch.pmcr_n;
+	u8 n = vcpu->kvm->arch.nr_pmu_counters;
 
 	if (n)
 		mask |= GENMASK(n - 1, 0);
@@ -1217,7 +1217,7 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	 */
 	if (!kvm_vm_has_ran_once(kvm) &&
 	    new_n <= kvm_arm_pmu_get_max_counters(kvm))
-		kvm->arch.pmcr_n = new_n;
+		kvm->arch.nr_pmu_counters = new_n;
 
 	mutex_unlock(&kvm->arch.config_lock);
 
-- 
2.39.5


