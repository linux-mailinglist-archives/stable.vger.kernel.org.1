Return-Path: <stable+bounces-127458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A68BA798B1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 01:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23EA7A4A9B
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8B1F9AB1;
	Wed,  2 Apr 2025 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8nAHA6U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D991F8670;
	Wed,  2 Apr 2025 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636074; cv=none; b=s0Aj7lglzH8RwUJbyH8qGFRbP9qchgjCoOuc1Q+xALi5eVsvSwVfMokqteEYuh82qReMKWrqJ7Ryb58kwDOSMVkTDyVtvPd3J/CbqiqdrbWes5J3cB1mzf2jwc/BxkDkN0s6HggRxhE3gYaF9neU6g7Y05Lul5/g9iUg01UHMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636074; c=relaxed/simple;
	bh=nlVU4m2cGOe9nm23h8UEok/akX92Rm8UP7rBstIa2ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lijNMV7nXr+W4Vm4YnMFByLORY91Q2Gt9ZHkG5wXfnkJ4g+/18IgqKV/eqLfKGnhVsMBErV9FpsOkQTPh88C30bMSRFpO4OeKsoEGX5Rip6l4z0HRGuIKchVs2zv+WkpQ/6fP9LjN012hf6qG/HB1gLVonpMtLPn21mzqCXjVHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8nAHA6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B6CC4CEDD;
	Wed,  2 Apr 2025 23:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743636073;
	bh=nlVU4m2cGOe9nm23h8UEok/akX92Rm8UP7rBstIa2ww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p8nAHA6U8ML2u9D7rkJHhxOTKlm9cGfIGEs8eU6oq2/EBD4+lQluCZ1sClluBNOXb
	 jd4923TNpVCfua1wO4dRrxwId7J60PJivi6gYp2+RSCbvDn0G2u1PbS4Zkirdyvkwi
	 +f/pNEwg0btl/Qe40NsisFc/SWdQWKTSRaGhmCGXADbPAtOmmV3aIx0Fy31sA/wyLv
	 yTktTCSCffibra28+U7s+ZB9h6CWSDjUqF09sTw2DWWIaknQoTynjl/9dyTD8GV0pE
	 jFmAF48s6A5wBDq0DQP5zRQeMxEU61ycaTxonRqAkrZELnXwS2ka8gR43WOrGHD6hV
	 MEn2dbjRzOImQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Apr 2025 00:20:20 +0100
Subject: [PATCH 5.15 v2 05/10] arm64/fpsimd: Stop using TIF_SVE to manage
 register saving in KVM
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-stable-sve-5-15-v2-5-30a36a78a20a@kernel.org>
References: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
In-Reply-To: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3851; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nlVU4m2cGOe9nm23h8UEok/akX92Rm8UP7rBstIa2ww=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn7cZPIbTZWpW9kWIJliuCbjXGFqWO+vyBNQAq/4Qd
 MwIzgGOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ+3GTwAKCRAk1otyXVSH0CVHB/
 9JxhSfxl+bHhXaV8hQ+yGnm/Nmglv2IW1U/KeyO5xfCZ5Y9r4t/bDRqkhYLpYOmH/PiL6TiqcD9SWv
 14v3m69Ab4zIkReHekQoUzoKVRQcwq6hwYNCdyvDbN94OWFHg2X3eInrb0J570k1oGPUHq/w9oJO7M
 FxLikNgOpVEa4lk3ZxBghm0Mq5KGbrvDEWw0x0AzvgbiNCDbIzwFUTsFANYOltXG1Cb8FlXnVK6z97
 m+3PadTJYGXyavUk65VV1gMKO7i0zYw76DLXw5SSJYI+Tf3uaPdCgBmQm2B/6KXAsowILVYPbk6cQb
 sgDHZCDyPd1ckqSg6NwqHUEINrVbrr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

[ Upstream commit 62021cc36add7b2c015b837f7893f2fb4b8c2586 ]

Now that we are explicitly telling the host FP code which register state
it needs to save we can remove the manipulation of TIF_SVE from the KVM
code, simplifying it and allowing us to optimise our handling of normal
tasks. Remove the manipulation of TIF_SVE from KVM and instead rely on
to_save to ensure we save the correct data for it.

There should be no functional or performance impact from this change.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221115094640.112848-5-broonie@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
[ Mark: trivial backport ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 40 ++++++++++++++++------------------------
 arch/arm64/kvm/fpsimd.c    |  3 ---
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 105b8aa0c038..e8f10daaa0d7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -318,7 +318,13 @@ static void task_fpsimd_load(void)
 
 /*
  * Ensure FPSIMD/SVE storage in memory for the loaded context is up to
- * date with respect to the CPU registers.
+ * date with respect to the CPU registers. Note carefully that the
+ * current context is the context last bound to the CPU stored in
+ * last, if KVM is involved this may be the guest VM context rather
+ * than the host thread for the VM pointed to by current. This means
+ * that we must always reference the state storage via last rather
+ * than via current, if we are saving KVM state then it will have
+ * ensured that the type of registers to save is set in last->to_save.
  */
 static void fpsimd_save(void)
 {
@@ -334,9 +340,15 @@ static void fpsimd_save(void)
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
 		return;
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-	    test_thread_flag(TIF_SVE)) {
-		if (WARN_ON(sve_get_vl() != last->sve_vl)) {
+	if ((last->to_save == FP_STATE_CURRENT && test_thread_flag(TIF_SVE)) ||
+	    last->to_save == FP_STATE_SVE) {
+		save_sve_regs = true;
+		vl = last->sve_vl;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && save_sve_regs) {
+		/* Get the configured VL from RDVL, will account for SM */
+		if (WARN_ON(sve_get_vl() != vl)) {
 			/*
 			 * Can't save the user regs, so current would
 			 * re-enter user with corrupt state.
@@ -347,26 +359,6 @@ static void fpsimd_save(void)
 		}
 	}
 
-	if (test_thread_flag(TIF_SVE)) {
-		save_sve_regs = true;
-		vl = last->sve_vl;
-	}
-
-	/*
-	 * Validate that an explicitly specified state to save is
-	 * consistent with the task state.
-	 */
-	switch (last->to_save) {
-	case FP_STATE_CURRENT:
-		break;
-	case FP_STATE_FPSIMD:
-		WARN_ON_ONCE(save_sve_regs);
-		break;
-	case FP_STATE_SVE:
-		WARN_ON_ONCE(!save_sve_regs);
-		break;
-	}
-
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && save_sve_regs) {
 		sve_save_state((char *)last->sve_state +
 			       sve_ffr_offset(last->sve_vl),
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 54a31c97eb7a..2e0f44f4c470 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -110,7 +110,6 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 					 &vcpu->arch.fp_type, fp_type);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
-		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
 	}
 }
 
@@ -151,7 +150,5 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
 	}
 
-	update_thread_flag(TIF_SVE, 0);
-
 	local_irq_restore(flags);
 }

-- 
2.39.5


