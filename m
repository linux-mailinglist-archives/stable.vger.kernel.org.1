Return-Path: <stable+bounces-109599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A905A17AEB
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 11:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6AC7A25F5
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF2F1BD9F2;
	Tue, 21 Jan 2025 10:00:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D8A1B4251
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453638; cv=none; b=RPpmytyOlwQ1mq39wvh2a9kN08quqwYlgUM69t0zlskdb5DV4XcS0TqdV/4B6aBsbMJZvaayjsGRP0bKofiTDGGPddlynFIOEocuT3+f6gMfpqM2pq8ufUUaMGpNJ8R33ICkQFnOx2pR42cSmsBCS/6Ta6xgDG35uKL/xOmF8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453638; c=relaxed/simple;
	bh=ql6N8RLFofk3FVqne14+SDMkc9FIzGX7Zd7cXhPGo0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gb6BZJMfHW/iDTgyv6FsECIFgUvXPgk5rJK7EroKdkw6O1OUbbGunReqBa9jyuz/U4FmG8qoNDMQFaGAAN3yW8X2k/8NHuvE8awe20p1B4XwY4WWGNuhYGzLZI8gOYlXwoPpWMQlIzX3HkvigJsRFUorzMlEIi4Iklb8JfRPa7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0DE6106F;
	Tue, 21 Jan 2025 02:01:03 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F276C3F740;
	Tue, 21 Jan 2025 02:00:32 -0800 (PST)
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
	wilco.dijkstra@arm.com,
	will@kernel.org
Subject: [PATCH] KVM: arm64/sve: Ensure SVE is trapped after guest exit
Date: Tue, 21 Jan 2025 10:00:26 +0000
Message-Id: <20250121100026.3974971-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a period of time after returning from a KVM_RUN ioctl where
userspace may use SVE without trapping, but the kernel can unexpectedly
discard the live SVE state. Eric Auger has observed this causing QEMU
crashes where SVE is used by memmove():

  https://issues.redhat.com/browse/RHEL-68997

The only state discarded is the user SVE state of the task which issued
the KVM_RUN ioctl. Other tasks are unaffected, plain FPSIMD state is
unaffected, and kernel state is unaffected.

This happens because fpsimd_kvm_prepare() incorrectly manipulates the
FPSIMD/SVE state. When the vCPU is loaded, fpsimd_kvm_prepare()
unconditionally clears TIF_SVE but does not reconfigure CPACR_EL1.ZEN to
trap userspace SVE usage. If the vCPU does not use FPSIMD/SVE and hyp
does not save the host's FPSIMD/SVE state, the kernel may return to
userspace with TIF_SVE clear while SVE is still enabled in
CPACR_EL1.ZEN. Subsequent userspace usage of SVE will not be trapped,
and the next save of userspace FPSIMD/SVE state will only store the
FPSIMD portion due to TIF_SVE being clear, discarding any SVE state.

The broken logic was originally introduced in commit:

  93ae6b01bafee8fa ("KVM: arm64: Discard any SVE state when entering KVM guests")

... though at the time fp_user_discard() would reconfigure CPACR_EL1.ZEN
to trap subsequent SVE usage, masking the issue until that logic was
removed in commit:

  8c845e2731041f0f ("arm64/sve: Leave SVE enabled on syscall if we don't context switch")

Avoid this issue by reconfiguring CPACR_EL1.ZEN when clearing
TIF_SVE. At the same time, add a comment to explain why
current->thread.fp_type must be set even though the FPSIMD state is not
foreign. A similar issue exists when SME is enabled, and will require
further rework. As SME currently depends on BROKEN, a BUILD_BUG() and
comment are added for now, and this issue will need to be fixed properly
in a follow-up patch.

Commit 93ae6b01bafee8fa also introduced an unintended ptrace ABI change.
Unconditionally clearing TIF_SVE regardless of whether the state is
foreign discards saved SVE state created by ptrace after syscall entry.
Avoid this by only clearing TIF_SVE when the FPSIMD/SVE state is not
foreign. When the state is foreign, KVM hyp code does not need to save
any host state, and so this will not affect KVM.

There appear to be further issues with unintentional SVE state
discarding, largely impacting ptrace and signal handling, which will
need to be addressed in separate patches.

Reported-by: Eric Auger <eauger@redhat.com>
Reported-by: Wilco Dijkstra <wilco.dijkstra@arm.com>
Cc: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

I believe there are some other issues in this area, but I'm sending this
out on its own because I beleive the other issues are more complex while
this is self-contained, and people are actively hitting this case in
production.

I intend to follow-up with fixes for the other cases I mention in the
commit message, and for the SME case with the BUILD_BUG_ON().

Mark.

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 8c4c1a2186cc5..e4053a90ed240 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1711,8 +1711,24 @@ void fpsimd_kvm_prepare(void)
 	 */
 	get_cpu_fpsimd_context();
 
-	if (test_and_clear_thread_flag(TIF_SVE)) {
-		sve_to_fpsimd(current);
+	if (!test_thread_flag(TIF_FOREIGN_FPSTATE) &&
+	    test_and_clear_thread_flag(TIF_SVE)) {
+		sve_user_disable();
+
+		/*
+		 * The KVM hyp code doesn't set fp_type when saving the host's
+		 * FPSIMD state. Set fp_type here in case the hyp code saves
+		 * the host state.
+		 *
+		 * If hyp code does not save the host state, then the host
+		 * state remains live on the CPU and saved fp_type is
+		 * irrelevant until it is overwritten by a later call to
+		 * fpsimd_save_user_state().
+		 *
+		 * This is *NOT* sufficient when CONFIG_ARM64_SME=y, where
+		 * fp_type can be FP_STATE_SVE regardless of TIF_SVE.
+		 */
+		BUILD_BUG_ON(IS_ENABLED(CONFIG_ARM64_SME));
 		current->thread.fp_type = FP_STATE_FPSIMD;
 	}
 
-- 
2.30.2


