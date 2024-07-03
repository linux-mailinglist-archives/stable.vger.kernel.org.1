Return-Path: <stable+bounces-57538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAF3925CE6
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24191C209E0
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B842817DA3A;
	Wed,  3 Jul 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c10157Ck"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B614D44E;
	Wed,  3 Jul 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005183; cv=none; b=K1KywDdQTFld6uwxdWbS1MWmCC+l3H3vFwbwvI65wZzCkJHXQBmy4N0n0w4VMbMbBi3dyIXaCbqpAGNhLV2FURllvj5amEzWAvFz60KjTYvCYwoiToeOvdAiyTMERUb7VK1QoPn0eNdmoWzgSTouFvlxPgRgqrHk4tJBL15KfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005183; c=relaxed/simple;
	bh=GsvO3DoNJuOyGzuScSzmPNAkhPMKbI0tMTtJrlY8OTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYr+BfRY+Xa89fLOcwP4Wk6O6i0vzqg/Pa1Kegiy9OBuREcsD3Tf1GudEwgT+Pe/8hIjGGYHJEEk9sFquXfeQ7qJb4pfFcBxAYar2s1GHjrxRkPnOI5r2lADPQm0LfxDDAV+np5/r2WXVBswTMkybAYk0HON2BkWsA2kZuDrLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c10157Ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B0CC2BD10;
	Wed,  3 Jul 2024 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005183;
	bh=GsvO3DoNJuOyGzuScSzmPNAkhPMKbI0tMTtJrlY8OTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c10157Ck0zZFM+V2yeS2ScFwL9f4JGjMdHJnQLZK26KIv0myImTxuf7bWCrwEHKhA
	 X0uw/C//CuGDYbIIKpn/83H69B/Nnr254JZwk1kXQKxRowg6uy8ZDgxI8PqlugMM79
	 /83qefbN2fHW2pwHgmP+TjSBiCWXwt/nM4kE5iVY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Gowans <jgowans@amazon.com>
Subject: [PATCH 5.10 287/290] KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemption
Date: Wed,  3 Jul 2024 12:41:08 +0200
Message-ID: <20240703102914.989706850@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

commit b321c31c9b7b309dcde5e8854b741c8e6a9a05f0 upstream.

Xiang reports that VMs occasionally fail to boot on GICv4.1 systems when
running a preemptible kernel, as it is possible that a vCPU is blocked
without requesting a doorbell interrupt.

The issue is that any preemption that occurs between vgic_v4_put() and
schedule() on the block path will mark the vPE as nonresident and *not*
request a doorbell irq. This occurs because when the vcpu thread is
resumed on its way to block, vcpu_load() will make the vPE resident
again. Once the vcpu actually blocks, we don't request a doorbell
anymore, and the vcpu won't be woken up on interrupt delivery.

Fix it by tracking that we're entering WFI, and key the doorbell
request on that flag. This allows us not to make the vPE resident
when going through a preempt/schedule cycle, meaning we don't lose
any state.

Cc: stable@vger.kernel.org
Fixes: 8e01d9a396e6 ("KVM: arm64: vgic-v4: Move the GICv4 residency flow to be driven by vcpu_load/put")
Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
Suggested-by: Zenghui Yu <yuzenghui@huawei.com>
Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20230713070657.3873244-1-maz@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
[ modified to wrangle the vCPU flags directly instead of going through
  the flag helper macros as they have not yet been introduced. Also doing
  the flag wranging in the kvm_arch_vcpu_{un}blocking() hooks as the
  introduction of kvm_vcpu_wfi has not yet happened. See:
  6109c5a6ab7f ("KVM: arm64: Move vGIC v4 handling for WFI out arch callback hook")  ]
Signed-off-by: James Gowans <jgowans@amazon.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_host.h |    1 +
 arch/arm64/kvm/arm.c              |    6 ++++--
 arch/arm64/kvm/vgic/vgic-v3.c     |    2 +-
 arch/arm64/kvm/vgic/vgic-v4.c     |    8 ++++++--
 include/kvm/arm_vgic.h            |    2 +-
 5 files changed, 13 insertions(+), 6 deletions(-)

--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -410,6 +410,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
 #define KVM_ARM64_VCPU_SVE_FINALIZED	(1 << 6) /* SVE config completed */
 #define KVM_ARM64_GUEST_HAS_PTRAUTH	(1 << 7) /* PTRAUTH exposed to guest */
+#define KVM_ARM64_VCPU_IN_WFI		(1 << 8) /* WFI instruction trapped */
 
 #define vcpu_has_sve(vcpu) (system_supports_sve() && \
 			    ((vcpu)->arch.flags & KVM_ARM64_GUEST_HAS_SVE))
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -332,13 +332,15 @@ void kvm_arch_vcpu_blocking(struct kvm_v
 	 */
 	preempt_disable();
 	kvm_vgic_vmcr_sync(vcpu);
-	vgic_v4_put(vcpu, true);
+	vcpu->arch.flags |= KVM_ARM64_VCPU_IN_WFI;
+	vgic_v4_put(vcpu);
 	preempt_enable();
 }
 
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
+	vcpu->arch.flags &= ~KVM_ARM64_VCPU_IN_WFI;
 	vgic_v4_load(vcpu);
 	preempt_enable();
 }
@@ -649,7 +651,7 @@ static void check_vcpu_requests(struct k
 		if (kvm_check_request(KVM_REQ_RELOAD_GICv4, vcpu)) {
 			/* The distributor enable bits were changed */
 			preempt_disable();
-			vgic_v4_put(vcpu, false);
+			vgic_v4_put(vcpu);
 			vgic_v4_load(vcpu);
 			preempt_enable();
 		}
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -682,7 +682,7 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	WARN_ON(vgic_v4_put(vcpu, false));
+	WARN_ON(vgic_v4_put(vcpu));
 
 	vgic_v3_vmcr_sync(vcpu);
 
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -310,14 +310,15 @@ void vgic_v4_teardown(struct kvm *kvm)
 	its_vm->vpes = NULL;
 }
 
-int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db)
+int vgic_v4_put(struct kvm_vcpu *vcpu)
 {
 	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
 
 	if (!vgic_supports_direct_msis(vcpu->kvm) || !vpe->resident)
 		return 0;
 
-	return its_make_vpe_non_resident(vpe, need_db);
+	return its_make_vpe_non_resident(vpe,
+			vcpu->arch.flags & KVM_ARM64_VCPU_IN_WFI);
 }
 
 int vgic_v4_load(struct kvm_vcpu *vcpu)
@@ -328,6 +329,9 @@ int vgic_v4_load(struct kvm_vcpu *vcpu)
 	if (!vgic_supports_direct_msis(vcpu->kvm) || vpe->resident)
 		return 0;
 
+	if (vcpu->arch.flags & KVM_ARM64_VCPU_IN_WFI)
+		return 0;
+
 	/*
 	 * Before making the VPE resident, make sure the redistributor
 	 * corresponding to our current CPU expects us here. See the
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -402,6 +402,6 @@ int kvm_vgic_v4_unset_forwarding(struct
 				 struct kvm_kernel_irq_routing_entry *irq_entry);
 
 int vgic_v4_load(struct kvm_vcpu *vcpu);
-int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db);
+int vgic_v4_put(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_VGIC_H */



