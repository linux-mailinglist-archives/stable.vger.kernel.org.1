Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C566FA415
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjEHJzF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjEHJzD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A3273B4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31EED62215
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0744EC4339B;
        Mon,  8 May 2023 09:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539700;
        bh=xgJQU37Ln7Obnx09CXnTZKOp6QALZyrnQZPRumKNakM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oA5r8z49VmBwObbUR2KYdY+hTu4Mu9fWdmsQvLHiGl16X9pnVZzRN+AryvefceXn3
         2xlYc1ARz3ze3T9kFI6uKut7Yf8Q+UBkssh+YFylXF4S3vvdWeCB7FKgLtJgn8fKXA
         0wyjDAg3J55k59HRFUxnkLNke7x8YkNsRrJQccO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeremy Linton <jeremy.linton@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.1 078/611] KVM: arm64: Use config_lock to protect data ordered against KVM_RUN
Date:   Mon,  8 May 2023 11:38:40 +0200
Message-Id: <20230508094424.593746538@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Oliver Upton <oliver.upton@linux.dev>

commit 4bba7f7def6f278266dadf845da472cfbfed784e upstream.

There are various bits of VM-scoped data that can only be configured
before the first call to KVM_RUN, such as the hypercall bitmaps and
the PMU. As these fields are protected by the kvm->lock and accessed
while holding vcpu->mutex, this is yet another example of lock
inversion.

Change out the kvm->lock for kvm->arch.config_lock in all of these
instances. Opportunistically simplify the locking mechanics of the
PMU configuration by holding the config_lock for the entirety of
kvm_arm_pmu_v3_set_attr().

Note that this also addresses a couple of bugs. There is an unguarded
read of the PMU version in KVM_ARM_VCPU_PMU_V3_FILTER which could race
with KVM_ARM_VCPU_PMU_V3_SET_PMU. Additionally, until now writes to the
per-vCPU vPMU irq were not serialized VM-wide, meaning concurrent calls
to KVM_ARM_VCPU_PMU_V3_IRQ could lead to a false positive in
pmu_irq_is_valid().

Cc: stable@vger.kernel.org
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230327164747.2466958-4-oliver.upton@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/arm.c        |    4 ++--
 arch/arm64/kvm/guest.c      |    2 ++
 arch/arm64/kvm/hypercalls.c |    4 ++--
 arch/arm64/kvm/pmu-emul.c   |   23 ++++++-----------------
 4 files changed, 12 insertions(+), 21 deletions(-)

--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -616,9 +616,9 @@ int kvm_arch_vcpu_run_pid_change(struct
 	if (kvm_vm_is_protected(kvm))
 		kvm_call_hyp_nvhe(__pkvm_vcpu_init_traps, vcpu);
 
-	mutex_lock(&kvm->lock);
+	mutex_lock(&kvm->arch.config_lock);
 	set_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags);
-	mutex_unlock(&kvm->lock);
+	mutex_unlock(&kvm->arch.config_lock);
 
 	return ret;
 }
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -951,7 +951,9 @@ int kvm_arm_vcpu_arch_set_attr(struct kv
 
 	switch (attr->group) {
 	case KVM_ARM_VCPU_PMU_V3_CTRL:
+		mutex_lock(&vcpu->kvm->arch.config_lock);
 		ret = kvm_arm_pmu_v3_set_attr(vcpu, attr);
+		mutex_unlock(&vcpu->kvm->arch.config_lock);
 		break;
 	case KVM_ARM_VCPU_TIMER_CTRL:
 		ret = kvm_arm_timer_set_attr(vcpu, attr);
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -377,7 +377,7 @@ static int kvm_arm_set_fw_reg_bmap(struc
 	if (val & ~fw_reg_features)
 		return -EINVAL;
 
-	mutex_lock(&kvm->lock);
+	mutex_lock(&kvm->arch.config_lock);
 
 	if (test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags) &&
 	    val != *fw_reg_bmap) {
@@ -387,7 +387,7 @@ static int kvm_arm_set_fw_reg_bmap(struc
 
 	WRITE_ONCE(*fw_reg_bmap, val);
 out:
-	mutex_unlock(&kvm->lock);
+	mutex_unlock(&kvm->arch.config_lock);
 	return ret;
 }
 
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -850,7 +850,7 @@ static int kvm_arm_pmu_v3_set_pmu(struct
 	struct arm_pmu *arm_pmu;
 	int ret = -ENXIO;
 
-	mutex_lock(&kvm->lock);
+	lockdep_assert_held(&kvm->arch.config_lock);
 	mutex_lock(&arm_pmus_lock);
 
 	list_for_each_entry(entry, &arm_pmus, entry) {
@@ -870,7 +870,6 @@ static int kvm_arm_pmu_v3_set_pmu(struct
 	}
 
 	mutex_unlock(&arm_pmus_lock);
-	mutex_unlock(&kvm->lock);
 	return ret;
 }
 
@@ -878,22 +877,20 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_v
 {
 	struct kvm *kvm = vcpu->kvm;
 
+	lockdep_assert_held(&kvm->arch.config_lock);
+
 	if (!kvm_vcpu_has_pmu(vcpu))
 		return -ENODEV;
 
 	if (vcpu->arch.pmu.created)
 		return -EBUSY;
 
-	mutex_lock(&kvm->lock);
 	if (!kvm->arch.arm_pmu) {
 		/* No PMU set, get the default one */
 		kvm->arch.arm_pmu = kvm_pmu_probe_armpmu();
-		if (!kvm->arch.arm_pmu) {
-			mutex_unlock(&kvm->lock);
+		if (!kvm->arch.arm_pmu)
 			return -ENODEV;
-		}
 	}
-	mutex_unlock(&kvm->lock);
 
 	switch (attr->attr) {
 	case KVM_ARM_VCPU_PMU_V3_IRQ: {
@@ -937,19 +934,13 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_v
 		     filter.action != KVM_PMU_EVENT_DENY))
 			return -EINVAL;
 
-		mutex_lock(&kvm->lock);
-
-		if (test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags)) {
-			mutex_unlock(&kvm->lock);
+		if (test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags))
 			return -EBUSY;
-		}
 
 		if (!kvm->arch.pmu_filter) {
 			kvm->arch.pmu_filter = bitmap_alloc(nr_events, GFP_KERNEL_ACCOUNT);
-			if (!kvm->arch.pmu_filter) {
-				mutex_unlock(&kvm->lock);
+			if (!kvm->arch.pmu_filter)
 				return -ENOMEM;
-			}
 
 			/*
 			 * The default depends on the first applied filter.
@@ -968,8 +959,6 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_v
 		else
 			bitmap_clear(kvm->arch.pmu_filter, filter.base_event, filter.nevents);
 
-		mutex_unlock(&kvm->lock);
-
 		return 0;
 	}
 	case KVM_ARM_VCPU_PMU_V3_SET_PMU: {


