Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359C475E4EF
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 22:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGWUlj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 16:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGWUlj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 16:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D104E4B
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 13:41:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDB7960C83
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 20:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1DBC433C8;
        Sun, 23 Jul 2023 20:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690144897;
        bh=g7aI7SrX+kwFz6eKKzH05wTiVTEc37+KQg1wowQhHqM=;
        h=Subject:To:Cc:From:Date:From;
        b=Ur+JqJs0AWGTcs0h+rhdSR1VfvehNhRmOotU5YDuMTeaaNpZiJeHEh0TFWLVJU/Gn
         LrP4oOoiwjlJpJQlX/zjDGPdR5QQmcbFOacJYt4kDmixxMdRzkVl2F7RwjW8P3zjEd
         h+1XYqGZ0iPFXMbXgKwOJWxjnKEd2lCCYXwnBns0=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t" failed to apply to 5.10-stable tree
To:     maz@kernel.org, chenxiang66@hisilicon.com, oliver.upton@linux.dev,
        yuzenghui@huawei.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 22:41:25 +0200
Message-ID: <2023072324-aviation-delirious-b27d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b321c31c9b7b309dcde5e8854b741c8e6a9a05f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072324-aviation-delirious-b27d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

b321c31c9b7b ("KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemption")
0c2f9acf6ae7 ("KVM: arm64: PMU: Don't overwrite PMUSERENR with vcpu loaded")
8681f7175901 ("KVM: arm64: PMU: Restore the host's PMUSERENR_EL0")
009d6dc87a56 ("ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM")
711432770f78 ("perf: pmuv3: Abstract PMU version checks")
df29ddf4f04b ("arm64: perf: Abstract system register accesses away")
7755cec63ade ("arm64: perf: Move PMUv3 driver to drivers/perf")
cc91b9481605 ("arm64/perf: Replace PMU version number '0' with ID_AA64DFR0_EL1_PMUVer_NI")
4151bb636acf ("KVM: arm64: Fix SMPRI_EL1/TPIDR2_EL0 trapping on VHE")
bb0cca240a16 ("Merge branch kvm-arm64/single-step-async-exception into kvmarm-master/next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b321c31c9b7b309dcde5e8854b741c8e6a9a05f0 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 13 Jul 2023 08:06:57 +0100
Subject: [PATCH] KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t
 preemption

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

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8b6096753740..d3dd05bbfe23 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -727,6 +727,8 @@ struct kvm_vcpu_arch {
 #define DBG_SS_ACTIVE_PENDING	__vcpu_single_flag(sflags, BIT(5))
 /* PMUSERENR for the guest EL0 is on physical CPU */
 #define PMUSERENR_ON_CPU	__vcpu_single_flag(sflags, BIT(6))
+/* WFI instruction trapped */
+#define IN_WFI			__vcpu_single_flag(sflags, BIT(7))
 
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a402ea5511f3..72dc53a75d1c 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -718,13 +718,15 @@ void kvm_vcpu_wfi(struct kvm_vcpu *vcpu)
 	 */
 	preempt_disable();
 	kvm_vgic_vmcr_sync(vcpu);
-	vgic_v4_put(vcpu, true);
+	vcpu_set_flag(vcpu, IN_WFI);
+	vgic_v4_put(vcpu);
 	preempt_enable();
 
 	kvm_vcpu_halt(vcpu);
 	vcpu_clear_flag(vcpu, IN_WFIT);
 
 	preempt_disable();
+	vcpu_clear_flag(vcpu, IN_WFI);
 	vgic_v4_load(vcpu);
 	preempt_enable();
 }
@@ -792,7 +794,7 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_RELOAD_GICv4, vcpu)) {
 			/* The distributor enable bits were changed */
 			preempt_disable();
-			vgic_v4_put(vcpu, false);
+			vgic_v4_put(vcpu);
 			vgic_v4_load(vcpu);
 			preempt_enable();
 		}
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index c3b8e132d599..3dfc8b84e03e 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -749,7 +749,7 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	WARN_ON(vgic_v4_put(vcpu, false));
+	WARN_ON(vgic_v4_put(vcpu));
 
 	vgic_v3_vmcr_sync(vcpu);
 
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index c1c28fe680ba..339a55194b2c 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -336,14 +336,14 @@ void vgic_v4_teardown(struct kvm *kvm)
 	its_vm->vpes = NULL;
 }
 
-int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db)
+int vgic_v4_put(struct kvm_vcpu *vcpu)
 {
 	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
 
 	if (!vgic_supports_direct_msis(vcpu->kvm) || !vpe->resident)
 		return 0;
 
-	return its_make_vpe_non_resident(vpe, need_db);
+	return its_make_vpe_non_resident(vpe, !!vcpu_get_flag(vcpu, IN_WFI));
 }
 
 int vgic_v4_load(struct kvm_vcpu *vcpu)
@@ -354,6 +354,9 @@ int vgic_v4_load(struct kvm_vcpu *vcpu)
 	if (!vgic_supports_direct_msis(vcpu->kvm) || vpe->resident)
 		return 0;
 
+	if (vcpu_get_flag(vcpu, IN_WFI))
+		return 0;
+
 	/*
 	 * Before making the VPE resident, make sure the redistributor
 	 * corresponding to our current CPU expects us here. See the
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 402b545959af..5b27f94d4fad 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -431,7 +431,7 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int irq,
 
 int vgic_v4_load(struct kvm_vcpu *vcpu);
 void vgic_v4_commit(struct kvm_vcpu *vcpu);
-int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db);
+int vgic_v4_put(struct kvm_vcpu *vcpu);
 
 /* CPU HP callbacks */
 void kvm_vgic_cpu_up(void);

