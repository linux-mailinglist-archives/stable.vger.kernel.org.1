Return-Path: <stable+bounces-56208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4EF91DD3E
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C232827CC
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1703B13AA35;
	Mon,  1 Jul 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XX+iFEfz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C3149DF0
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831452; cv=none; b=iKAA2uUj8QhwFAmtK0bIT/ATMlySTe0i9wHhRvGYbFzsEF7JAJSuVDKmmzs00Z8xcezSKQcxeMuthRCn8OB2/ZRzbSJXzozjdNaEoRQGxo0sJvHj5cRjJ01lx+nOLzX0zfBc2QmIE0LNUC031QwjFCqrTeeI+UHB16E7mlQUeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831452; c=relaxed/simple;
	bh=GIgdgBWuHBLkgKrVYI4ZQr7ez7kdSvfDHGv9CUjpbic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9kgweWOwcj+uWSHVxd3YgeZso3hZ9H6s5yOJK+ZNXoiaXrf3EzsEih6yQNdcmhK+SV90ZiwJM5l++k/IRzm4qyx4u9hSw4LpOFAoIfFRxvAACmyJTm7RBOWa5lXVe/ICC6NQwxClQIFWYiXT+FfJCeVbHrerlug/JTEPFQtANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XX+iFEfz; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719831450; x=1751367450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xyW/DPnWBae6s10i5tFz77aFvMc3DMdENlJP17zypVo=;
  b=XX+iFEfz2lijMpFiCV53Dc89zkkU4h0AXAjMRyeRVDHgEVjUNVVNpjVN
   0XifijXYXXyAGEasUWWaJKvbdZ3d4UcJOUD7j+NfEHs8j9CXy1VSVXd6D
   xMG4bj0dvwu1w+TKX5nv+ZAE+7FErMuq0GmJEFVaevXK7GytNjDNxJSmz
   I=;
X-IronPort-AV: E=Sophos;i="6.09,176,1716249600"; 
   d="scan'208";a="664102206"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:57:28 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:22154]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.91:2525] with esmtp (Farcaster)
 id a4678b7e-90d4-4c92-b781-ea72a257f857; Mon, 1 Jul 2024 10:57:26 +0000 (UTC)
X-Farcaster-Flow-ID: a4678b7e-90d4-4c92-b781-ea72a257f857
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 1 Jul 2024 10:57:26 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.114) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 1 Jul 2024 10:57:22 +0000
From: James Gowans <jgowans@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <chenxiang66@hisilicon.com>,
	<maz@kernel.org>, <oliver.upton@linux.dev>, <yuzenghui@huawei.com>,
	<sironi@amazon.de>
Subject: [PATCH 5.10.y] KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemption
Date: Mon, 1 Jul 2024 12:57:07 +0200
Message-ID: <20240701105707.28631-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023072324-aviation-delirious-b27d@gregkh>
References: <2023072324-aviation-delirious-b27d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

From: Marc Zyngier <maz@kernel.org>

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

(cherry picked from commit b321c31c9b7b309dcde5e8854b741c8e6a9a05f0)

[modified to wrangle the vCPU flags directly instead of going through
the flag helper macros as they have not yet been introduced. Also doing
the flag wranging in the kvm_arch_vcpu_{un}blocking() hooks as the
introduction of kvm_vcpu_wfi has not yet happened. See:
6109c5a6ab7f ("KVM: arm64: Move vGIC v4 handling for WFI out arch callback hook")]

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kvm/arm.c              | 6 ++++--
 arch/arm64/kvm/vgic/vgic-v3.c     | 2 +-
 arch/arm64/kvm/vgic/vgic-v4.c     | 8 ++++++--
 include/kvm/arm_vgic.h            | 2 +-
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 912b83e784bb..48ee1fe3aca4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -410,6 +410,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
 #define KVM_ARM64_VCPU_SVE_FINALIZED	(1 << 6) /* SVE config completed */
 #define KVM_ARM64_GUEST_HAS_PTRAUTH	(1 << 7) /* PTRAUTH exposed to guest */
+#define KVM_ARM64_VCPU_IN_WFI		(1 << 8) /* WFI instruction trapped */
 
 #define vcpu_has_sve(vcpu) (system_supports_sve() && \
 			    ((vcpu)->arch.flags & KVM_ARM64_GUEST_HAS_SVE))
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 4d63fcd7574b..afe8be2fef88 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -332,13 +332,15 @@ void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
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
@@ -649,7 +651,7 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_RELOAD_GICv4, vcpu)) {
 			/* The distributor enable bits were changed */
 			preempt_disable();
-			vgic_v4_put(vcpu, false);
+			vgic_v4_put(vcpu);
 			vgic_v4_load(vcpu);
 			preempt_enable();
 		}
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 9cdf39a94a63..29c12bf9601a 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -682,7 +682,7 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	WARN_ON(vgic_v4_put(vcpu, false));
+	WARN_ON(vgic_v4_put(vcpu));
 
 	vgic_v3_vmcr_sync(vcpu);
 
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index b5fa73c9fd35..cdfaaeabbb7d 100644
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
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index a8d8fdcd3723..92348c085c0c 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -402,6 +402,6 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int irq,
 				 struct kvm_kernel_irq_routing_entry *irq_entry);
 
 int vgic_v4_load(struct kvm_vcpu *vcpu);
-int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db);
+int vgic_v4_put(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_VGIC_H */
-- 
2.34.1


