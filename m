Return-Path: <stable+bounces-127461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EB9A798B7
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 01:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201211719D8
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8838C1FBE9E;
	Wed,  2 Apr 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMKbjuMT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEA1F8747;
	Wed,  2 Apr 2025 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636087; cv=none; b=ME/ntOV8htANVFyxJi0ssy7kzYBgaxUzadNPsXty72bd21+sPzo6sO8oHZJF+T/HwsmSz9mNvleFUyG06Ck7f6KuWmz0mopCKsfOqs+WNynBAjM64retk3APuPs5bKnUm9lp1zLOn9c4SaELRICn5cxXPaV7Gsc5B3v46bS3OO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636087; c=relaxed/simple;
	bh=94B73exkvxZIp7PjZglkCZBY40cUsa7OpOScJsLUoog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elydRZIuMhd3u7l+kemvD2S/OnJ/VqQBJq34H3lXrP6EPOEuiWfIyRNpJuCmv/z0DuBG8z0Airrbk8Ksato5GhUYNvnW+uGMjj6FC68563bD+z3xomI8+Za1q7VIKmb60YcHowwrGFWefuCCQ61x278Sy+6Kg+8qVhSq0b8Yjig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMKbjuMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E63FC4CEDD;
	Wed,  2 Apr 2025 23:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743636086;
	bh=94B73exkvxZIp7PjZglkCZBY40cUsa7OpOScJsLUoog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pMKbjuMTsbbVsQ6RiJwc/eiFmkOBCHEYLWOz2hVVUFfK17YfiIsDSWyRen77OCAaQ
	 Pkwtr6J1sAkjPDuFu+/JCrjStPS0RWWG7l89YTHH5Wf/WR1OKmi+tRP68oYRc/1KrV
	 wkUke4vcUCIyQmXFP9a6VCQEkFVRdM2vhJc9b10NJdCoLD3fnfVy89kR7DkxZKyyFP
	 gwJyf4mYCLyziuoT98x+aPgXPnfpO12I/CBweatKI2DVCIVJ5b8ULkC7pxFa/bp9vW
	 7WZKn/PMGYRwRh8L+RtUwOTAyMMejMWN3xwVKQASk9ehXX4uhygoiXbzFBoBoUD3WS
	 dMk4y9K8emBvA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Apr 2025 00:20:23 +0100
Subject: [PATCH 5.15 v2 08/10] KVM: arm64: Remove VHE host restore of
 CPACR_EL1.ZEN
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-stable-sve-5-15-v2-8-30a36a78a20a@kernel.org>
References: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
In-Reply-To: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Fuad Tabba <tabba@google.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3514; i=broonie@kernel.org;
 h=from:subject:message-id; bh=z0T8Mw2Gv92zuKeVWJq8mDeqr184OynN7N95pkdbt3E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn7cZRBfZOBeK2OmNmHazZfCtH0LV8u0J8SI75zjb6
 vtv1PnuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ+3GUQAKCRAk1otyXVSH0JX8B/
 9O5K4zPEulEboWPndCoZmFR/gJDM+51xzE5xFJFykGJahqqCzLPfgygouQrEQin75mLAt7iIO5hLU1
 lUt5d5xlYH38BaPLk1Jk5+c0il8HI4eT0lbqG0v3gEv1nFmcS9ef1KJuZtdQujAIlyhen7QHv76zij
 8UQPuRGISnwiELRx6SQneicDZgPb811J0vsW8hXL3xTleCTfj16ow71IBBf/uC4vm3AYi3XtMp4KHI
 5Lyt6T2kr5OxCpV7Ao3zashkUVOnCWHMrK4A7QGuZtQyqQ/tKAajWjLt1FIGsOT50ExV56nbpp+fPK
 jd8OugE0BV2ImQ+/iqJKVwoUY1nujX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 459f059be702056d91537b99a129994aa6ccdd35 ]

When KVM is in VHE mode, the host kernel tries to save and restore the
configuration of CPACR_EL1.ZEN (i.e. CPTR_EL2.ZEN when HCR_EL2.E2H=1)
across kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp(), since the
configuration may be clobbered by hyp when running a vCPU. This logic is
currently redundant.

The VHE hyp code unconditionally configures CPTR_EL2.ZEN to 0b01 when
returning to the host, permitting host kernel usage of SVE.

Now that the host eagerly saves and unbinds its own FPSIMD/SVE/SME
state, there's no need to save/restore the state of the EL0 SVE trap.
The kernel can safely save/restore state without trapping, as described
above, and will restore userspace state (including trap controls) before
returning to userspace.

Remove the redundant logic.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20250210195226.1215254-4-mark.rutland@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
[Rework for refactoring of where the flags are stored -- broonie]
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 -
 arch/arm64/kvm/fpsimd.c           | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 06e8d4645ecd..3d4e2396a2d7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -421,7 +421,6 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_DEBUG_DIRTY		(1 << 0)
 #define KVM_ARM64_FP_ENABLED		(1 << 1) /* guest FP regs loaded */
 #define KVM_ARM64_FP_HOST		(1 << 2) /* host FP regs loaded */
-#define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
 #define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
 #define KVM_ARM64_VCPU_SVE_FINALIZED	(1 << 6) /* SVE config completed */
 #define KVM_ARM64_GUEST_HAS_PTRAUTH	(1 << 7) /* PTRAUTH exposed to guest */
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 1ef9d6cb91ee..1360ddd4137b 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -83,9 +83,6 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 	 */
 	fpsimd_save_and_flush_cpu_state();
 	vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
-
-	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
-		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
 }
 
 /*
@@ -142,18 +139,6 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 		}
 
 		fpsimd_save_and_flush_cpu_state();
-	} else if (has_vhe() && system_supports_sve()) {
-		/*
-		 * The FPSIMD/SVE state in the CPU has not been touched, and we
-		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been
-		 * reset to CPACR_EL1_DEFAULT by the Hyp code, disabling SVE
-		 * for EL0.  To avoid spurious traps, restore the trap state
-		 * seen by kvm_arch_vcpu_load_fp():
-		 */
-		if (vcpu->arch.flags & KVM_ARM64_HOST_SVE_ENABLED)
-			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_ZEN_EL0EN);
-		else
-			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
 	}
 
 	local_irq_restore(flags);

-- 
2.39.5


