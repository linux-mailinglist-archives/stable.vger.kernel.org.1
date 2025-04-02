Return-Path: <stable+bounces-127455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AF7A798B0
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 01:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9910188BDBE
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762A1F874E;
	Wed,  2 Apr 2025 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfug19fT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB31F2377;
	Wed,  2 Apr 2025 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636062; cv=none; b=Be6S6k5G7u/F/I59DCmWTK6IRdxEmAK5dWckrrN9G+zSlY+u/oaa+nup9KzRrCah2CAwUAiD4LCbnR7yDFTS3OWg/lK+xZvkqWY6hQ/EjE4iFp0jtsHJHqCIm0JwA6kzhk2ybMYDFnPVIYhQ4IJQgjPm1BZ0RtR6tsj+L9qPg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636062; c=relaxed/simple;
	bh=3I3JV/ck2QZ+DL7hhJF3NDc5SpXrkme3Nu2RxTmLX10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgnWywyP5g7YBBDwonEW8i+2QooYbXX7EbimoA7QIRJHN7iuCVeqeKDPJ3tegJ+AEP0WUNqfB3kz8ZZVS2gRTTENOdYFZlbQHtW9/ALRP9clgS8iW3qibM5HM+xJPJL8aoD0GTC7yfOxBETiXtCWiTB0RfjzDOda0tsRKkJUKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfug19fT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBD4C4CEDD;
	Wed,  2 Apr 2025 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743636061;
	bh=3I3JV/ck2QZ+DL7hhJF3NDc5SpXrkme3Nu2RxTmLX10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sfug19fTEbFdtG5OGoNXUNt4CkeOQFDxdnigFcvo/Y3aThAxxIKAH1tTzQgb9yg5s
	 sKIqOMFlv6fc3PUJC83kEg1iQXv/V+TIOx3XcxllkJihk1dmBh5c5J0qiEgC4u37Ee
	 V6plwjRzYW+AdAUvDcwmFZf4Z8Dnj5o82sURZZKsUIcDWdQsgPD05dCLZ6dSLt/5q/
	 f93dvqvwdhIIrn62AEG0kgclLcGPxStWKTrirJyPhuVz7gVaoQ+Tsr3uJZ2HCLN2G2
	 kLlkS/2UYczl4oo2n1AVHVVDMrfGK3ICrN3fPUzDGkJuUyi9SZONnaTmWdzU1iLe42
	 CJMOUgkfgYAQg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Apr 2025 00:20:17 +0100
Subject: [PATCH 5.15 v2 02/10] KVM: arm64: Discard any SVE state when
 entering KVM guests
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-stable-sve-5-15-v2-2-30a36a78a20a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3I3JV/ck2QZ+DL7hhJF3NDc5SpXrkme3Nu2RxTmLX10=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhvS3x3wv588NVv9138lDQP6nU9Pa8+FP5onN93I45/LxdEq3
 QMHuTkZjFgZGLgZZMUWWtc8yVqWHS2yd/2j+K5hBrEwgUxi4OAVgIo8b2P87dckuPTD5cxX39IICl0
 LJfy+m93OH6zYvOZaVPs13fYfIHNlSLX3X/AyvMLvPiuta7Fd4Oi7mYZBdelrK+5zs5m8dYqrrzWdb
 KR55Z51uw5637ZHAiYzzOSpr7y1UTTa7nheTzrn4wr8l23k7F7ZOPLl4+t1pKqmBjDP5Xnr/F3uu0G
 CnKFC25OUshmQxnuSFkpYZ9fui7vHfKD79pPj+V/n11l9aVaZeZPFi06xpkRCsf8+QmVY99eEllvat
 134dC5aKsZJzvpuRF2290mn6muDvWz4LMnCsO1ldoODWX+Wxd7+gtUWpAU/3Y1Pdey5qgfJ5xe5Mqu
 2bd/U+T8qaIeIlOe3QI52oR8FOAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

[ Upstream commit 93ae6b01bafee8fa385aa25ee7ebdb40057f6abe ]

Since 8383741ab2e773a99 (KVM: arm64: Get rid of host SVE tracking/saving)
KVM has not tracked the host SVE state, relying on the fact that we
currently disable SVE whenever we perform a syscall. This may not be true
in future since performance optimisation may result in us keeping SVE
enabled in order to avoid needing to take access traps to reenable it.
Handle this by clearing TIF_SVE and converting the stored task state to
FPSIMD format when preparing to run the guest.  This is done with a new
call fpsimd_kvm_prepare() to keep the direct state manipulation
functions internal to fpsimd.c.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221115094640.112848-2-broonie@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
[ Mark: trivial backport to v6.1 ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h |  1 +
 arch/arm64/kernel/fpsimd.c      | 23 +++++++++++++++++++++++
 arch/arm64/kvm/fpsimd.c         |  5 ++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 9a62884183e5..f7faf0f4507c 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -44,6 +44,7 @@ extern void fpsimd_signal_preserve_current_state(void);
 extern void fpsimd_preserve_current_state(void);
 extern void fpsimd_restore_current_state(void);
 extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
+extern void fpsimd_kvm_prepare(void);
 
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 				     void *sve_state, unsigned int sve_vl);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e22571e57ae1..57e89361edcb 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1108,6 +1108,29 @@ void fpsimd_signal_preserve_current_state(void)
 		sve_to_fpsimd(current);
 }
 
+/*
+ * Called by KVM when entering the guest.
+ */
+void fpsimd_kvm_prepare(void)
+{
+	if (!system_supports_sve())
+		return;
+
+	/*
+	 * KVM does not save host SVE state since we can only enter
+	 * the guest from a syscall so the ABI means that only the
+	 * non-saved SVE state needs to be saved.  If we have left
+	 * SVE enabled for performance reasons then update the task
+	 * state to be FPSIMD only.
+	 */
+	get_cpu_fpsimd_context();
+
+	if (test_and_clear_thread_flag(TIF_SVE))
+		sve_to_fpsimd(current);
+
+	put_cpu_fpsimd_context();
+}
+
 /*
  * Associate current's FPSIMD context with this cpu
  * The caller must have ownership of the cpu FPSIMD context before calling
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 2d15e1d6e214..16e29f03dcbf 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -70,11 +70,14 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(!current->mm);
-	BUG_ON(test_thread_flag(TIF_SVE));
 
 	vcpu->arch.flags &= ~KVM_ARM64_FP_ENABLED;
 	vcpu->arch.flags |= KVM_ARM64_FP_HOST;
 
+	fpsimd_kvm_prepare();
+
+	vcpu->arch.flags &= ~KVM_ARM64_HOST_SVE_ENABLED;
+
 	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
 		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
 }

-- 
2.39.5


