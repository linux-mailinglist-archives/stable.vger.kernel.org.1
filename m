Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0FB7831E1
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjHUTxe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHUTxd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C683FA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C3D64513
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73CBC433C8;
        Mon, 21 Aug 2023 19:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647611;
        bh=H6oo2xXiUVKrOPpu1pqiSLgl0ycsKxf3//S+0nV4Q9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hURf1mbT7rgyK7eOr4Vkniq4whfSBr1QYafoWhmPVlaIQOBXL+bcex+xl+Ep2k6i1
         bP4KzSMnX67BTXK6Jb6sYpNqsxsg33xGEP1LAafNuNaAJGPhJ9Z95LIcIqBHTEZ2tA
         zv0H5l12g4bpwk57PZFjqukD2pGIuxFYtVl48beE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiang Chen <chenxiang66@hisilicon.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 076/194] KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemption
Date:   Mon, 21 Aug 2023 21:40:55 +0200
Message-ID: <20230821194126.108512504@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit b321c31c9b7b309dcde5e8854b741c8e6a9a05f0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 2 ++
 arch/arm64/kvm/arm.c              | 6 ++++--
 arch/arm64/kvm/vgic/vgic-v3.c     | 2 +-
 arch/arm64/kvm/vgic/vgic-v4.c     | 7 +++++--
 include/kvm/arm_vgic.h            | 2 +-
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b5a8e8b3c691c..577cf444c1135 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -559,6 +559,8 @@ struct kvm_vcpu_arch {
 #define SYSREGS_ON_CPU		__vcpu_single_flag(sflags, BIT(4))
 /* Software step state is Active-pending */
 #define DBG_SS_ACTIVE_PENDING	__vcpu_single_flag(sflags, BIT(5))
+/* WFI instruction trapped */
+#define IN_WFI			__vcpu_single_flag(sflags, BIT(7))
 
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 35481d51aada8..6cc380a15eb76 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -692,13 +692,15 @@ void kvm_vcpu_wfi(struct kvm_vcpu *vcpu)
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
@@ -766,7 +768,7 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_RELOAD_GICv4, vcpu)) {
 			/* The distributor enable bits were changed */
 			preempt_disable();
-			vgic_v4_put(vcpu, false);
+			vgic_v4_put(vcpu);
 			vgic_v4_load(vcpu);
 			preempt_enable();
 		}
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index f86c3007a319c..1f8eea53e982f 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -742,7 +742,7 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	WARN_ON(vgic_v4_put(vcpu, false));
+	WARN_ON(vgic_v4_put(vcpu));
 
 	vgic_v3_vmcr_sync(vcpu);
 
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index c1c28fe680ba3..339a55194b2c6 100644
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
index 4df9e73a8bb5f..1d7d4cffaefc6 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -429,6 +429,6 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int irq,
 
 int vgic_v4_load(struct kvm_vcpu *vcpu);
 void vgic_v4_commit(struct kvm_vcpu *vcpu);
-int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db);
+int vgic_v4_put(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_VGIC_H */
-- 
2.40.1



