Return-Path: <stable+bounces-128307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A603EA7BDC7
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 15:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBB717B5F2
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501861F4196;
	Fri,  4 Apr 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppBbXraM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F21F0E38;
	Fri,  4 Apr 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773275; cv=none; b=Tu5NYyPPtsPVGcRCKVfx1wvzNMnMFkAwmAm4KdM9376XAcn0DTVg3Dl8RtYlKWfEjd9icegO77DghPawocAW3SFtylbX24HaWTwwpi2Q9WfjnoOUxjZgS+HrYUUfbkcal/gyOKGJwQkJ7Fv/BXR7s03giyXkyDtyVXlz4zlEc6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773275; c=relaxed/simple;
	bh=5jtExQAwF36VmhyMCHSi9Dr/NqZucqSesDzOeduLG/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPYFNkWOXW5EJ7TAstYWOFffPhay7qA1j5yC/XwvRcuf6YDntvY9AiOghs7F2qeadxhpjfKlP44nM3oC6aDRaFHC3oVKP33SybRcrc65FHeoIdetUKzFZdotonLIuqWkfVKWXBJ/nJl6OgKuU6dghMWXhSvgG1lgxzhLCz72DXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppBbXraM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE541C4CEE8;
	Fri,  4 Apr 2025 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743773274;
	bh=5jtExQAwF36VmhyMCHSi9Dr/NqZucqSesDzOeduLG/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ppBbXraMvMtezZw0mtRX/D3prPXYwFn4idOQRkPUNn/P6Wi+wvrhrs3BF4WAbmePH
	 qMnGZskheFh5qRr6VhJ+1wfsaU/tgTB2Bb7mKSVvYmmhUjUWHbqHG/7apo/C6qgwOZ
	 6rg8SM/jM9Btr/up8vSVtbGFeFxM4I9EF3FD1hhbHS/YcXHnVSsc2dhJShMTVfMwaW
	 /Vc0Gj0gamVP7zupprmM/YD9w5x/97V/8RNEv7nMHXoJji/ZTjb3y5RMBBUmF9CVz9
	 1nCgay16U3yd7HZwYzMLMM1wtAuOTcpMFtb91lE41X91TBe3iexRDMyyTdFARuSE49
	 8tWSQyKNJAELA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 04 Apr 2025 14:23:41 +0100
Subject: [PATCH RESEND 6.1 08/12] KVM: arm64: Remove VHE host restore of
 CPACR_EL1.SMEN
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-stable-sve-6-1-v1-8-cd5c9eb52d49@kernel.org>
References: <20250404-stable-sve-6-1-v1-0-cd5c9eb52d49@kernel.org>
In-Reply-To: <20250404-stable-sve-6-1-v1-0-cd5c9eb52d49@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Oliver Upton <oliver.upton@linux.dev>, Oleg Nesterov <oleg@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, 
 Mark Rutland <mark.rutland@arm.com>, Fuad Tabba <tabba@google.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4949; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gGHtRWYkZIvY26SXOdVNVzxHFFds99XjbSYEpsfkvMA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn794zFUdaBACXWoPRSc+Uzt5n9EGMEGdRPsJxZucS
 WnPxH7qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ+/eMwAKCRAk1otyXVSH0IDXB/
 sFJjCz99+FG6SozKUpw53LUEDTn6jY5vGIUuIzPGQF9N5skIQWMdeuAtILn1tlUKxgCW2rkZh/hC4l
 Tr2X25rfWH4MvZFriO1xrRWQ6GMObYthRFvxPEsYHLd8x2MP5wdo+gAqthHQX7l713p6vypYpjBfyV
 quZztHHXhG66hfCPbmFLk8kJSarEQn0XhyHC0ubUSHrWEYZZXnpGMm4SGONKuc8RW76ebtIp02GQDG
 TjRu4hImQbXDmW0DhfKDdcyEurPDdrfSQeQ7FC3wqTubnz4SQlKoSg3Hu8kijf7hWolyxQ1BxlWcz7
 BJVSpV1qs/bopL8wxZjc9OQXNHEQYn
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 407a99c4654e8ea65393f412c421a55cac539f5b ]

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
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20250210195226.1215254-5-mark.rutland@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
[Update for rework of flags storage -- broonie]
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  2 --
 arch/arm64/kvm/fpsimd.c           | 31 -------------------------------
 2 files changed, 33 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 181e49120e0c..757f4dea1e56 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -556,8 +556,6 @@ struct kvm_vcpu_arch {
 /* Save TRBE context if active  */
 #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
 
-/* SME enabled for EL0 */
-#define HOST_SME_ENABLED	__vcpu_single_flag(sflags, BIT(1))
 /* Physical CPU not in supported_cpus */
 #define ON_UNSUPPORTED_CPU	__vcpu_single_flag(sflags, BIT(2))
 /* WFIT instruction trapped */
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 8d073a37c266..df050e4d3562 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -87,21 +87,6 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 	 */
 	fpsimd_save_and_flush_cpu_state();
 	vcpu->arch.fp_state = FP_STATE_FREE;
-
-	/*
-	 * We don't currently support SME guests but if we leave
-	 * things in streaming mode then when the guest starts running
-	 * FPSIMD or SVE code it may generate SME traps so as a
-	 * special case if we are in streaming mode we force the host
-	 * state to be saved now and exit streaming mode so that we
-	 * don't have to handle any SME traps for valid guest
-	 * operations. Do this for ZA as well for now for simplicity.
-	 */
-	if (system_supports_sme()) {
-		vcpu_clear_flag(vcpu, HOST_SME_ENABLED);
-		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
-			vcpu_set_flag(vcpu, HOST_SME_ENABLED);
-	}
 }
 
 /*
@@ -162,22 +147,6 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
 	local_irq_save(flags);
 
-	/*
-	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
-	 * CPACR_EL1_DEFAULT and we need to reenable SME.
-	 */
-	if (has_vhe() && system_supports_sme()) {
-		/* Also restore EL0 state seen on entry */
-		if (vcpu_get_flag(vcpu, HOST_SME_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0,
-					 CPACR_EL1_SMEN_EL0EN |
-					 CPACR_EL1_SMEN_EL1EN);
-		else
-			sysreg_clear_set(CPACR_EL1,
-					 CPACR_EL1_SMEN_EL0EN,
-					 CPACR_EL1_SMEN_EL1EN);
-	}
-
 	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED) {
 		if (vcpu_has_sve(vcpu)) {
 			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);

-- 
2.39.5


