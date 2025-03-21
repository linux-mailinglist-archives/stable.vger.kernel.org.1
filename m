Return-Path: <stable+bounces-125712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9CA6B210
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 01:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F483A60D8
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526D7DA6C;
	Fri, 21 Mar 2025 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHJzF+qO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053578F49;
	Fri, 21 Mar 2025 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516027; cv=none; b=fE+Rq5xRscePqVS/qwi0hygaB61SvrfacwxrT7uNdUxSUSwLFbZJHYSj4E71KinWn6RNVWyV+h4lUrz0/W6OaFeYlKPrFexvqbvY69C4SbWho887q7LN0RLlu6FGc7LB1s9OPite+L9jjZbj6clm+QJwRj/tmcXm71KXR6mZTpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516027; c=relaxed/simple;
	bh=LyPrPybrI4jSmvJtjiQg8E4IzuKEZoZgME8fZSHDqU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2gPUb2cvtFTJlaieY0gmnEcZkxnjBEoRyagEDdInj1zYg9ovLOzDy2glYU4pgQpcvjrimye00P1F0gLJIhtmItZ2knIGb9rWuXi0DOo1zKATzRqY6x4PVHeJaeIeAiu0ZeWUrhb6UG0tn6eLVB4nuPUduwFZmALZJzTvlS/UNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHJzF+qO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E954C4CEE3;
	Fri, 21 Mar 2025 00:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742516027;
	bh=LyPrPybrI4jSmvJtjiQg8E4IzuKEZoZgME8fZSHDqU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eHJzF+qOIO2jqJPNq9prhQxvsvyPA23KHde+r2Tb1kpXch21W+AilUeHl6gokoS1N
	 O2L/Y1oYDTWsjOAyY5QkMAbBs+RGqW3CB7o0D+prrc0wumo6gc8Otxk0w49/47URl6
	 TSgCBIAOMKE/StscMFoCfylkkUtS0W1vC8a7ZIg5axS4GlAN4O9PAxmagXHcDMy4D1
	 S1Ko8uBDpCjKPGwjMYGafDnXlhqcONALfEE8rBId8Ndd9T1KvW1pvr/tspthiRvzU9
	 f9n84F4pj80c2BQvLhCd2SAs0zE/VwWf7oGXPvAczHNGel+/qsY1c8aMmtYlXc+7tx
	 tbRfrzYid2XQQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 21 Mar 2025 00:13:02 +0000
Subject: [PATCH 6.12 v2 6/8] KVM: arm64: Refactor exit handlers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-stable-sve-6-12-v2-6-417ca2278d18@kernel.org>
References: <20250321-stable-sve-6-12-v2-0-417ca2278d18@kernel.org>
In-Reply-To: <20250321-stable-sve-6-12-v2-0-417ca2278d18@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Fuad Tabba <tabba@google.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=7922; i=broonie@kernel.org;
 h=from:subject:message-id; bh=U+HkEfycBrVjaQM2Wq7Y3xZJglZuSCZHRDWKQggF5Cs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn3K8hNigQ/NuvpaKSVYz5OtMylPrkaSc9WQf4O3Lg
 Te/8Z+CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ9yvIQAKCRAk1otyXVSH0JqpB/
 93t5qseGR4GQocm3h9XjqMO1wHUoW07hxRyQdQXWti9RbBGkgSKpcb76RT7mp+QwQGXYDEcUMnj3WP
 xAKAH/v9eXhoMwjtvx5SLsX25iRuWZ/8NHYvyVT04koH5HntuQUkakStWhgmRqbpsfl2jqXmTwqX9L
 uZ3+6U3TgmDdh4fVVITH29s5AB7y90u/HB2AbBZ4XpNrHU7zP6WJb0HwBNaU+JCfHbU6ai++simHix
 v3DdKqQYEzinV8bcx6kuQbIuolncYyi8AMLeHVyuElgZQKXKXM+n6VrvujoFmTnwPBh0GKRLKoYOyU
 +NpJxMMQFO7Jgsq/mt+ezpEh9pf7bv
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 9b66195063c5a145843547b1d692bd189be85287 ]

The hyp exit handling logic is largely shared between VHE and nVHE/hVHE,
with common logic in arch/arm64/kvm/hyp/include/hyp/switch.h. The code
in the header depends on function definitions provided by
arch/arm64/kvm/hyp/vhe/switch.c and arch/arm64/kvm/hyp/nvhe/switch.c
when they include the header.

This is an unusual header dependency, and prevents the use of
arch/arm64/kvm/hyp/include/hyp/switch.h in other files as this would
result in compiler warnings regarding missing definitions, e.g.

| In file included from arch/arm64/kvm/hyp/nvhe/hyp-main.c:8:
| ./arch/arm64/kvm/hyp/include/hyp/switch.h:733:31: warning: 'kvm_get_exit_handler_array' used but never defined
|   733 | static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu);
|       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
| ./arch/arm64/kvm/hyp/include/hyp/switch.h:735:13: warning: 'early_exit_filter' used but never defined
|   735 | static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code);
|       |             ^~~~~~~~~~~~~~~~~

Refactor the logic such that the header doesn't depend on anything from
the C files. There should be no functional change as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20250210195226.1215254-7-mark.rutland@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 30 ++++++------------------------
 arch/arm64/kvm/hyp/nvhe/switch.c        | 28 ++++++++++++++++------------
 arch/arm64/kvm/hyp/vhe/switch.c         |  9 ++++-----
 3 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index a7f6a653f33718d1a25e232608e63ea287f2a672..e14aba19847f2c66c202a869b5173f25a9a7f66e 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -635,23 +635,16 @@ static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
 
 typedef bool (*exit_handler_fn)(struct kvm_vcpu *, u64 *);
 
-static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu);
-
-static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code);
-
 /*
  * Allow the hypervisor to handle the exit with an exit handler if it has one.
  *
  * Returns true if the hypervisor handled the exit, and control should go back
  * to the guest, or false if it hasn't.
  */
-static inline bool kvm_hyp_handle_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_exit(struct kvm_vcpu *vcpu, u64 *exit_code,
+				       const exit_handler_fn *handlers)
 {
-	const exit_handler_fn *handlers = kvm_get_exit_handler_array(vcpu);
-	exit_handler_fn fn;
-
-	fn = handlers[kvm_vcpu_trap_get_class(vcpu)];
-
+	exit_handler_fn fn = handlers[kvm_vcpu_trap_get_class(vcpu)];
 	if (fn)
 		return fn(vcpu, exit_code);
 
@@ -681,20 +674,9 @@ static inline void synchronize_vcpu_pstate(struct kvm_vcpu *vcpu, u64 *exit_code
  * the guest, false when we should restore the host state and return to the
  * main run loop.
  */
-static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool __fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code,
+				      const exit_handler_fn *handlers)
 {
-	/*
-	 * Save PSTATE early so that we can evaluate the vcpu mode
-	 * early on.
-	 */
-	synchronize_vcpu_pstate(vcpu, exit_code);
-
-	/*
-	 * Check whether we want to repaint the state one way or
-	 * another.
-	 */
-	early_exit_filter(vcpu, exit_code);
-
 	if (ARM_EXCEPTION_CODE(*exit_code) != ARM_EXCEPTION_IRQ)
 		vcpu->arch.fault.esr_el2 = read_sysreg_el2(SYS_ESR);
 
@@ -724,7 +706,7 @@ static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 		goto exit;
 
 	/* Check if there's an exit handler and allow it to handle the exit. */
-	if (kvm_hyp_handle_exit(vcpu, exit_code))
+	if (kvm_hyp_handle_exit(vcpu, exit_code, handlers))
 		goto guest;
 exit:
 	/* Return to the host kernel and handle the exit */
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 3ce16f90fe6af7be21bc7b84a9d8b3905b8b08a7..ee74006c47bc44ca1d9bdf1ce7d4d8a41cf8e494 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -224,19 +224,21 @@ static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
 	return hyp_exit_handlers;
 }
 
-/*
- * Some guests (e.g., protected VMs) are not be allowed to run in AArch32.
- * The ARMv8 architecture does not give the hypervisor a mechanism to prevent a
- * guest from dropping to AArch32 EL0 if implemented by the CPU. If the
- * hypervisor spots a guest in such a state ensure it is handled, and don't
- * trust the host to spot or fix it.  The check below is based on the one in
- * kvm_arch_vcpu_ioctl_run().
- *
- * Returns false if the guest ran in AArch32 when it shouldn't have, and
- * thus should exit to the host, or true if a the guest run loop can continue.
- */
-static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
+	const exit_handler_fn *handlers = kvm_get_exit_handler_array(vcpu);
+
+	synchronize_vcpu_pstate(vcpu, exit_code);
+
+	/*
+	 * Some guests (e.g., protected VMs) are not be allowed to run in
+	 * AArch32.  The ARMv8 architecture does not give the hypervisor a
+	 * mechanism to prevent a guest from dropping to AArch32 EL0 if
+	 * implemented by the CPU. If the hypervisor spots a guest in such a
+	 * state ensure it is handled, and don't trust the host to spot or fix
+	 * it.  The check below is based on the one in
+	 * kvm_arch_vcpu_ioctl_run().
+	 */
 	if (unlikely(vcpu_is_protected(vcpu) && vcpu_mode_is_32bit(vcpu))) {
 		/*
 		 * As we have caught the guest red-handed, decide that it isn't
@@ -249,6 +251,8 @@ static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
 		*exit_code &= BIT(ARM_EXIT_WITH_SERROR_BIT);
 		*exit_code |= ARM_EXCEPTION_IL;
 	}
+
+	return __fixup_guest_exit(vcpu, exit_code, handlers);
 }
 
 /* Switch to the guest for legacy non-VHE systems */
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index e7ca0424107adec2371ae4553ebab9857c60b6d9..46c1f5caf007331cdbbc806a184e9b4721042fc0 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -423,13 +423,10 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_MOPS]		= kvm_hyp_handle_mops,
 };
 
-static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
+static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
-	return hyp_exit_handlers;
-}
+	synchronize_vcpu_pstate(vcpu, exit_code);
 
-static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
-{
 	/*
 	 * If we were in HYP context on entry, adjust the PSTATE view
 	 * so that the usual helpers work correctly.
@@ -449,6 +446,8 @@ static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
 		*vcpu_cpsr(vcpu) &= ~(PSR_MODE_MASK | PSR_MODE32_BIT);
 		*vcpu_cpsr(vcpu) |= mode;
 	}
+
+	return __fixup_guest_exit(vcpu, exit_code, hyp_exit_handlers);
 }
 
 /* Switch to the guest for VHE systems running in EL2 */

-- 
2.39.5


