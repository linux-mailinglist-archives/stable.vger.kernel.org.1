Return-Path: <stable+bounces-121006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A68A50978
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC483A4762
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E6B25A2B6;
	Wed,  5 Mar 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GPs8MFHR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2548B259CA3;
	Wed,  5 Mar 2025 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198608; cv=none; b=NKw57yZpgSoWJ3rDf64EtcCkZAJes1VD/unCAW4Og1sC1A0BrzJBkhK1RFhFZkoVZENXJydMbcqqjMlS1HE/gJKmvouXyR6nzft+/1AQf3GvqS+V9LcVd3deNVSIRyIbIy2GvNgoj3YQQJJVx80XHm/w3J50sXYktL4dCxonpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198608; c=relaxed/simple;
	bh=IfjODqrflO6ExfGT8HFAkhskMi7S4sQcVb1vjGkbxOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbDlUFzY4KfHOy4XJCvLcIIK49roY1995krwolZxBw80uvfIC7I3yfl9fMrZkrI8htUKK2daj/H+hk8W4OJ1GQjN+W42Fh1TnGDnIXyyXZNCBC30VoE8Um8m2k4/eMHk+XHASDZmRio0eL9UxTZzDBVjQK0ezuAr/ChTtNj4uqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GPs8MFHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46423C4CED1;
	Wed,  5 Mar 2025 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198607;
	bh=IfjODqrflO6ExfGT8HFAkhskMi7S4sQcVb1vjGkbxOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPs8MFHRlmUY9yN7LpGQMyKrt0zIxkrkouGbO/sp2gHuCfjPbbv94+OGDac3/Znr/
	 pPbPA6Ry1lSYtMWysNeXAJo/1ffKNBGMwr49ufENlOxQ5NcDfR1Aw3VF7MQHua9Z+M
	 VqfCJCkDON3SEjdJpoPx8Gmra82KQsDb08Hvbr9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.13 085/157] KVM: arm64: Ensure a VMID is allocated before programming VTTBR_EL2
Date: Wed,  5 Mar 2025 18:48:41 +0100
Message-ID: <20250305174508.726343650@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Upton <oliver.upton@linux.dev>

commit fa808ed4e199ed17d878eb75b110bda30dd52434 upstream.

Vladimir reports that a race condition to attach a VMID to a stage-2 MMU
sometimes results in a vCPU entering the guest with a VMID of 0:

| CPU1                                            |   CPU2
|                                                 |
|                                                 | kvm_arch_vcpu_ioctl_run
|                                                 |   vcpu_load             <= load VTTBR_EL2
|                                                 |                            kvm_vmid->id = 0
|                                                 |
| kvm_arch_vcpu_ioctl_run                         |
|   vcpu_load             <= load VTTBR_EL2       |
|                            with kvm_vmid->id = 0|
|   kvm_arm_vmid_update   <= allocates fresh      |
|                            kvm_vmid->id and     |
|                            reload VTTBR_EL2     |
|                                                 |
|                                                 |   kvm_arm_vmid_update <= observes that kvm_vmid->id
|                                                 |                          already allocated,
|                                                 |                          skips reload VTTBR_EL2

Oh yeah, it's as bad as it looks. Remember that VHE loads the stage-2
MMU eagerly but a VMID only gets attached to the MMU later on in the
KVM_RUN loop.

Even in the "best case" where VTTBR_EL2 correctly gets reprogrammed
before entering the EL1&0 regime, there is a period of time where
hardware is configured with VMID 0. That's completely insane. So, rather
than decorating the 'late' binding with another hack, just allocate the
damn thing up front.

Attaching a VMID from vcpu_load() is still rollover safe since
(surprise!) it'll always get called after a vCPU was preempted.

Excuse me while I go find a brown paper bag.

Cc: stable@vger.kernel.org
Fixes: 934bf871f011 ("KVM: arm64: Load the stage-2 MMU context in kvm_vcpu_load_vhe()")
Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20250219220737.130842-1-oliver.upton@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_host.h |    2 +-
 arch/arm64/kvm/arm.c              |   22 ++++++++++------------
 arch/arm64/kvm/vmid.c             |   11 +++--------
 3 files changed, 14 insertions(+), 21 deletions(-)

--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1262,7 +1262,7 @@ int kvm_arm_pvtime_has_attr(struct kvm_v
 extern unsigned int __ro_after_init kvm_arm_vmid_bits;
 int __init kvm_arm_vmid_alloc_init(void);
 void __init kvm_arm_vmid_alloc_free(void);
-bool kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid);
+void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid);
 void kvm_arm_vmid_clear_active(void);
 
 static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -581,6 +581,16 @@ void kvm_arch_vcpu_load(struct kvm_vcpu
 	last_ran = this_cpu_ptr(mmu->last_vcpu_ran);
 
 	/*
+	 * Ensure a VMID is allocated for the MMU before programming VTTBR_EL2,
+	 * which happens eagerly in VHE.
+	 *
+	 * Also, the VMID allocator only preserves VMIDs that are active at the
+	 * time of rollover, so KVM might need to grab a new VMID for the MMU if
+	 * this is called from kvm_sched_in().
+	 */
+	kvm_arm_vmid_update(&mmu->vmid);
+
+	/*
 	 * We guarantee that both TLBs and I-cache are private to each
 	 * vcpu. If detecting that a vcpu from the same VM has
 	 * previously run on the same physical CPU, call into the
@@ -1147,18 +1157,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 		 */
 		preempt_disable();
 
-		/*
-		 * The VMID allocator only tracks active VMIDs per
-		 * physical CPU, and therefore the VMID allocated may not be
-		 * preserved on VMID roll-over if the task was preempted,
-		 * making a thread's VMID inactive. So we need to call
-		 * kvm_arm_vmid_update() in non-premptible context.
-		 */
-		if (kvm_arm_vmid_update(&vcpu->arch.hw_mmu->vmid) &&
-		    has_vhe())
-			__load_stage2(vcpu->arch.hw_mmu,
-				      vcpu->arch.hw_mmu->arch);
-
 		kvm_pmu_flush_hwstate(vcpu);
 
 		local_irq_disable();
--- a/arch/arm64/kvm/vmid.c
+++ b/arch/arm64/kvm/vmid.c
@@ -135,11 +135,10 @@ void kvm_arm_vmid_clear_active(void)
 	atomic64_set(this_cpu_ptr(&active_vmids), VMID_ACTIVE_INVALID);
 }
 
-bool kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
+void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
 {
 	unsigned long flags;
 	u64 vmid, old_active_vmid;
-	bool updated = false;
 
 	vmid = atomic64_read(&kvm_vmid->id);
 
@@ -157,21 +156,17 @@ bool kvm_arm_vmid_update(struct kvm_vmid
 	if (old_active_vmid != 0 && vmid_gen_match(vmid) &&
 	    0 != atomic64_cmpxchg_relaxed(this_cpu_ptr(&active_vmids),
 					  old_active_vmid, vmid))
-		return false;
+		return;
 
 	raw_spin_lock_irqsave(&cpu_vmid_lock, flags);
 
 	/* Check that our VMID belongs to the current generation. */
 	vmid = atomic64_read(&kvm_vmid->id);
-	if (!vmid_gen_match(vmid)) {
+	if (!vmid_gen_match(vmid))
 		vmid = new_vmid(kvm_vmid);
-		updated = true;
-	}
 
 	atomic64_set(this_cpu_ptr(&active_vmids), vmid);
 	raw_spin_unlock_irqrestore(&cpu_vmid_lock, flags);
-
-	return updated;
 }
 
 /*



