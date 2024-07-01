Return-Path: <stable+bounces-56209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F8B91DDB1
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 13:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E302B23E6F
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDF42056;
	Mon,  1 Jul 2024 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kKxHSPgI"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713413DDAF
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832799; cv=none; b=DKp+9Y4arHaJzO99KS20oltes/p63GMsF8hptTAPXbe+D8yRJSICbLSmudxrsUOyXdecQ5B8fanZTykjFDkYMswaJxSrTS56Prs95U0PwLxxCIrP2KyZdy9+f7uqkyv+pLnimi10lvEP4u7AwRzsMJD/HfwsfzOdjZwHTKBLpJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832799; c=relaxed/simple;
	bh=AyTkrgGcMg6/3PbaXxUhBgd2XeWp4mCygHH14FI//KU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpodgANrTV3kiJujU7ShO17NsqxOkMN0xvblDgLDsLmoPOGAc5wob3OlVWVnzLdn6KrDirsB6cFup5yp+lmPG5R056bIDUfGrI6ZueFXHInOdWdbGFRveflIt5qEGDEAUCTcA9+31ptnubFuVQp1pXyKpLZTlJ3Q+f+zT5KgFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kKxHSPgI; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719832798; x=1751368798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXZUovLf3XXTBCFobz3gG7lgT5lb2kLWgnoI904CK9s=;
  b=kKxHSPgIv36du3y/mYBx/UfKkBxk4Usf/Imv4863l7Hl+7ujIv8csrVD
   v0Pq/t7hyngWDxAMEmIYObNdk7x5bF52SmgrRGQkjkpHaloXGEWNtp/F6
   w1QL8HDpjwhJuX7bm5Ba4O7ZkOJjwhIUTwsH/SSrIUjhGT5yYn19JwS0g
   c=;
X-IronPort-AV: E=Sophos;i="6.09,176,1716249600"; 
   d="scan'208";a="215302683"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 11:19:55 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:19607]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.104:2525] with esmtp (Farcaster)
 id 56abde86-b913-4812-896b-1c9994934500; Mon, 1 Jul 2024 11:19:53 +0000 (UTC)
X-Farcaster-Flow-ID: 56abde86-b913-4812-896b-1c9994934500
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 1 Jul 2024 11:19:50 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.114) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 1 Jul 2024 11:19:46 +0000
From: James Gowans <jgowans@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <chenxiang66@hisilicon.com>,
	<maz@kernel.org>, <oliver.upton@linux.dev>, <yuzenghui@huawei.com>,
	<sironi@amazon.de>
Subject: [PATCH 5.15.y] KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemption
Date: Mon, 1 Jul 2024 13:19:33 +0200
Message-ID: <20240701111933.41973-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023072323-trident-unturned-7999@gregkh>
References: <2023072323-trident-unturned-7999@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
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
index 1713630bf8f5..91038fa2e5e0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -419,6 +419,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_EXCEPT_MASK		(7 << 9) /* Target EL/MODE */
 #define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */
 #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
+#define KVM_ARM64_VCPU_IN_WFI		(1 << 14) /* WFI instruction trapped */
 
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 47d737672aba..9ded5443de48 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -379,13 +379,15 @@ void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
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
@@ -696,7 +698,7 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_RELOAD_GICv4, vcpu)) {
 			/* The distributor enable bits were changed */
 			preempt_disable();
-			vgic_v4_put(vcpu, false);
+			vgic_v4_put(vcpu);
 			vgic_v4_load(vcpu);
 			preempt_enable();
 		}
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 8eb70451323b..fcd5bb242bcf 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -715,7 +715,7 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	WARN_ON(vgic_v4_put(vcpu, false));
+	WARN_ON(vgic_v4_put(vcpu));
 
 	vgic_v3_vmcr_sync(vcpu);
 
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index f507e3fcffce..2cf4a60b6e1d 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -333,14 +333,15 @@ void vgic_v4_teardown(struct kvm *kvm)
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
@@ -351,6 +352,9 @@ int vgic_v4_load(struct kvm_vcpu *vcpu)
 	if (!vgic_supports_direct_msis(vcpu->kvm) || vpe->resident)
 		return 0;
 
+	if (vcpu->arch.flags & KVM_ARM64_VCPU_IN_WFI)
+		return 0;
+
 	/*
 	 * Before making the VPE resident, make sure the redistributor
 	 * corresponding to our current CPU expects us here. See the
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index e602d848fc1a..e9caa57cd633 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -423,6 +423,6 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int irq,
 
 int vgic_v4_load(struct kvm_vcpu *vcpu);
 void vgic_v4_commit(struct kvm_vcpu *vcpu);
-int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db);
+int vgic_v4_put(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_VGIC_H */
-- 
2.34.1


