Return-Path: <stable+bounces-112182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11EDA275B2
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 16:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929623A1C92
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46EE213E84;
	Tue,  4 Feb 2025 15:21:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BF2207E1D
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682492; cv=none; b=T+1YK8FLA/Q9ae5NrHR77f1ZArQa2kSXgDh8qEDs5uJGftwHh5GU42cgZaILJ8werOw9lPekyKqvhs8w5YI8ybk8Zb1sEZ3gg5dcjt6Jk48ds+hWaJUGAn96Z5RLlxy9FgNToIl8i/InNYk1VIRuz6ykfJijQOGbPLFp5YC89MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682492; c=relaxed/simple;
	bh=VWmcfHzUW0+DeL7kolaPIXfmxBq7532Gtx+PntPqSIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsOuvfe/SpNxeKSeAC+9S5VwHQjTv70I1kQfUXJqe5KFKM4rlgSHqItF9p7IFJLk0r5gYhrXNLmXXm2m5IVQrJL8CQOKrBR5taMwlREfTbOr+tXHSKWZJ8iueACUQxN8+fsxAHioVEf1KPN6ARicor7HuALBrQTB+ytj+TK10jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E37B1BA8;
	Tue,  4 Feb 2025 07:21:54 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06E093F63F;
	Tue,  4 Feb 2025 07:21:27 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	eauger@redhat.com,
	fweimer@redhat.com,
	jeremy.linton@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com,
	stable@vger.kernel.org,
	tabba@google.com,
	wilco.dijkstra@arm.com,
	will@kernel.org
Subject: [PATCH 4/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
Date: Tue,  4 Feb 2025 15:20:56 +0000
Message-Id: <20250204152100.705610-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250204152100.705610-1-mark.rutland@arm.com>
References: <20250204152100.705610-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KVM is in VHE mode, the host kernel tries to save and restore the
configuration of CPACR_EL1.SMEN (i.e. CPTR_EL2.SMEN when HCR_EL2.E2H=1)
across kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp(), since the
configuration may be clobbered by hyp when running a vCPU. This logic
has historically been broken, and is currently redundant.

This logic was originally introduced in commit:

  861262ab86270206 ("KVM: arm64: Handle SME host state when running guests")

At the time, the VHE hyp code would reset CPTR_EL2.SMEN to 0b00 when
returning to the host, trapping host access to SME state. Unfortunately,
this was unsafe as the host could take a softirq before calling
kvm_arch_vcpu_put_fp(), and if a softirq handler were to use kernel mode
NEON the resulting attempt to save the live FPSIMD/SVE/SME state would
result in a fatal trap.

That issue was limited to VHE mode. For nVHE/hVHE modes, KVM always
saved/restored the host kernel's CPACR_EL1 value, and configured
CPTR_EL2.TSM to 0b0, ensuring that host usage of SME would not be
trapped.

The issue above was incidentally fixed by commit:

  375110ab51dec5dc ("KVM: arm64: Fix resetting SME trap values on reset for (h)VHE")

That commit changed the VHE hyp code to configure CPTR_EL2.SMEN to 0b01
when returning to the host, permitting host kernel usage of SME,
avoiding the issue described above. At the time, this was not identified
as a fix for commit 861262ab86270206.

Now that the host eagerly saves and unbinds its own FPSIMD/SVE/SME
state, there's no need to save/restore the state of the EL0 SME trap.
The kernel can safely save/restore state without trapping, as described
above, and will restore userspace state (including trap controls) before
returning to userspace.

Remove the redundant logic.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 -
 arch/arm64/kvm/fpsimd.c           | 21 ---------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ed6841bf21b22..c77acc9904576 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -615,7 +615,6 @@ struct cpu_sve_state {
 struct kvm_host_data {
 #define KVM_HOST_DATA_FLAG_HAS_SPE			0
 #define KVM_HOST_DATA_FLAG_HAS_TRBE			1
-#define KVM_HOST_DATA_FLAG_HOST_SME_ENABLED		3
 #define KVM_HOST_DATA_FLAG_TRBE_ENABLED			4
 #define KVM_HOST_DATA_FLAG_EL1_TRACING_CONFIGURED	5
 	unsigned long flags;
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 4ff0dee1a403f..f64724197958e 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -65,12 +65,6 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 	fpsimd_save_and_flush_cpu_state();
 	*host_data_ptr(fp_owner) = FP_STATE_FREE;
 
-	if (system_supports_sme()) {
-		host_data_clear_flag(HOST_SME_ENABLED);
-		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
-			host_data_set_flag(HOST_SME_ENABLED);
-	}
-
 	/*
 	 * If normal guests gain SME support, maintain this behavior for pKVM
 	 * guests, which don't support SME.
@@ -141,21 +135,6 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
 	local_irq_save(flags);
 
-	/*
-	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
-	 * the default value and we need to reenable SME.
-	 */
-	if (has_vhe() && system_supports_sme()) {
-		/* Also restore EL0 state seen on entry */
-		if (host_data_test_flag(HOST_SME_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_SMEN);
-		else
-			sysreg_clear_set(CPACR_EL1,
-					 CPACR_EL1_SMEN_EL0EN,
-					 CPACR_EL1_SMEN_EL1EN);
-		isb();
-	}
-
 	if (guest_owns_fp_regs()) {
 		if (vcpu_has_sve(vcpu)) {
 			u64 zcr = read_sysreg_el1(SYS_ZCR);
-- 
2.30.2


