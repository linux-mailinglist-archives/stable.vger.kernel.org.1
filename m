Return-Path: <stable+bounces-125701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F091A6B1F7
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 01:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF6048306A
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D628489;
	Fri, 21 Mar 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvQwo43H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3D35973;
	Fri, 21 Mar 2025 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515855; cv=none; b=c8jOw0OTxVQg3G4fCG4bhni37XOgqF9yndoSrsOTAFTiAQwwld2Cz++CtQBd+8eul4or8EwKkXp2x81NM7ZX2zf/8w8t+3B72P0Jri2nakCKe3+nnzu8wK6YmZp1k/oFlL2aaMLUZ8/Q6FbaUekxYHRg20upXl6kTHXqlPso5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515855; c=relaxed/simple;
	bh=E+aOhIZc+2/jDkgAqi9VNAFDe2MB1GBPZXykaIDdI+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JN/ElQlLJf2Fv4ittunCzlSuq20q67G+SLG4i932xWlM4BVBT2z/DyGF9137dVf00HB+VGFh2ckVSGNOdENIvWUb1Auo/i7Y875HR2ohT93XkTIsnF3CbGyXoRdqFEIpxnnIJdLPfN9OpEsXwO/lKBqbUAQb3d7b1xqcmt9OJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvQwo43H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C52C4CEDD;
	Fri, 21 Mar 2025 00:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742515854;
	bh=E+aOhIZc+2/jDkgAqi9VNAFDe2MB1GBPZXykaIDdI+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lvQwo43HTIXzO7+BzgxpIoQwAWuaMViA/smGiwAswopB3gxO00/muFXJ8+yFbxqEW
	 XfpldLKLK+EK2V8sqePMiAivni7z7iZwTedcPFo922AsVQyc7Bp3DsVSZOdHbc+iet
	 HQeFtG1TA5reeo2TWBuQP2i/XmZGqtp9hV0SGLp+KhMPHskTsgxGZnkJ0l6EaaSTpa
	 EgoDsBkaposLa+FtasVbn0LIJoElSb5v/5o87dYI8u43c9mrc/98IdFOsiOSt+x2M4
	 5EmdBF7FXFIIt2v6FyXLjXQPuxOWwnk0HR0/UFl2ae5LWT/rjEzPAQmE9ECFp7o9j/
	 X2Jj4HsoLd5wg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 21 Mar 2025 00:10:13 +0000
Subject: [PATCH 6.13 v2 4/8] KVM: arm64: Remove VHE host restore of
 CPACR_EL1.ZEN
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-stable-sve-6-13-v2-4-3150e3370c40@kernel.org>
References: <20250321-stable-sve-6-13-v2-0-3150e3370c40@kernel.org>
In-Reply-To: <20250321-stable-sve-6-13-v2-0-3150e3370c40@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Fuad Tabba <tabba@google.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3661; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yO17/qmFqJwkGL3jxPrvPZFrNQ9AjVZUoiyN8pPAOE0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn3K52TqAzC8CL//mNmItcTqkrbfy/ktAiZU+akIKh
 9nEJeiWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ9yudgAKCRAk1otyXVSH0NDOB/
 sHQxIKoaGMrZWiPWz7KrALloXLYvye/VSbcUrjrNNLWr+gzFKKjezSeZLcx7NgEy064PmR/qhn6gig
 Hm0xk+jEhydJie7Bs7AnifcdNax0jc1J6NDmm8rfHAepnCHQc3/7NiKXJ2Hf+inYyUlTti0Vrt9Owa
 9EZWIHAA1Ksll1LsRaIIFg38KynXHMNtvEXlF6hPwQVEkQnW6jRy5eEirMW31Mhm0WckbBHg7luOhC
 UXequjpS92+nq2fUeeM0NeOIKEIZ4Tdz/Oo3yLte8YvNrdu7mqxsV/5qDcnEcwRCFHiaouBnb2spA0
 yo4mWPIcc/gwDzKVDJ3y0VgrxDScR5
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
 arch/arm64/include/asm/kvm_host.h |  2 --
 arch/arm64/kvm/fpsimd.c           | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0b39888e86d6d40fea56bb6cb8ccdbaf480d0d55..fe25d411d3d8efbe19d5ffba8ea23bf98eb06c38 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -902,8 +902,6 @@ struct kvm_vcpu_arch {
 /* Save TRBE context if active  */
 #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
 
-/* SVE enabled for host EL0 */
-#define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
 /* SME enabled for EL0 */
 #define HOST_SME_ENABLED	__vcpu_single_flag(sflags, BIT(1))
 /* Physical CPU not in supported_cpus */
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 2ee6bde85235581d6bc9cba7e578c55875b5d5a1..4127abfd319c2c683d2281efa52a6abe5fac67ee 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -65,10 +65,6 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 	fpsimd_save_and_flush_cpu_state();
 	*host_data_ptr(fp_owner) = FP_STATE_FREE;
 
-	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
-	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
-		vcpu_set_flag(vcpu, HOST_SVE_ENABLED);
-
 	if (system_supports_sme()) {
 		vcpu_clear_flag(vcpu, HOST_SME_ENABLED);
 		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
@@ -202,18 +198,6 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 		 * when needed.
 		 */
 		fpsimd_save_and_flush_cpu_state();
-	} else if (has_vhe() && system_supports_sve()) {
-		/*
-		 * The FPSIMD/SVE state in the CPU has not been touched, and we
-		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been
-		 * reset by kvm_reset_cptr_el2() in the Hyp code, disabling SVE
-		 * for EL0.  To avoid spurious traps, restore the trap state
-		 * seen by kvm_arch_vcpu_load_fp():
-		 */
-		if (vcpu_get_flag(vcpu, HOST_SVE_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_ZEN_EL0EN);
-		else
-			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
 	}
 
 	local_irq_restore(flags);

-- 
2.39.5


