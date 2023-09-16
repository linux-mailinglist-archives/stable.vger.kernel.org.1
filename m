Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF597A3005
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbjIPM02 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjIPM0E (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:26:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2203ECED
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:25:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C006C433C7;
        Sat, 16 Sep 2023 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867158;
        bh=s4VBkNjjJ24yTfxWYrn7NmLCXaIdH7a1o9n+/lFfAF8=;
        h=Subject:To:Cc:From:Date:From;
        b=qqXRwnyos3euk5ikEPUjy90FWjE2TLDn5RkWoKCczcwFM7XfzbNYXs5DUldCdyv+6
         NIn7qYvaPoabYbtJaaUz6T4ITsA+56OlSPaMoNN3eMbpGm2rbU6nmgY+FXNvYYhnRD
         YUbBwqHjK83BFwMaKfvcdyWQzJRFLKxJaBYQUVOo=
Subject: FAILED: patch "[PATCH] KVM: SVM: Set target pCPU during IRTE update if target vCPU" failed to apply to 5.15-stable tree
To:     seanjc@google.com, alejandro.j.jimenez@oracle.com,
        dengqiao.joey@bytedance.com, joao.m.martins@oracle.com,
        mlevitsk@redhat.com, suravee.suthikulpanit@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:25:56 +0200
Message-ID: <2023091655-resize-playmate-ac62@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f3cebc75e7425d6949d726bb8e937095b0aef025
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091655-resize-playmate-ac62@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f3cebc75e742 ("KVM: SVM: Set target pCPU during IRTE update if target vCPU is running")
4c08e737f056 ("KVM: SVM: Take and hold ir_list_lock when updating vCPU's Physical ID entry")
935a7333958e ("KVM: SVM: Drop AVIC's intermediate avic_set_running() helper")
782f64558de7 ("KVM: SVM: Skip AVIC and IRTE updates when loading blocking vCPU")
af52f5aa5c1b ("KVM: SVM: Use kvm_vcpu_is_blocking() in AVIC load to handle preemption")
e422b8896948 ("KVM: SVM: Remove unnecessary APICv/AVIC update in vCPU unblocking path")
7cfc5c653b07 ("KVM: fix avic_set_running for preemptable kernels")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f3cebc75e7425d6949d726bb8e937095b0aef025 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 8 Aug 2023 16:31:32 -0700
Subject: [PATCH] KVM: SVM: Set target pCPU during IRTE update if target vCPU
 is running

Update the target pCPU for IOMMU doorbells when updating IRTE routing if
KVM is actively running the associated vCPU.  KVM currently only updates
the pCPU when loading the vCPU (via avic_vcpu_load()), and so doorbell
events will be delayed until the vCPU goes through a put+load cycle (which
might very well "never" happen for the lifetime of the VM).

To avoid inserting a stale pCPU, e.g. due to racing between updating IRTE
routing and vCPU load/put, get the pCPU information from the vCPU's
Physical APIC ID table entry (a.k.a. avic_physical_id_cache in KVM) and
update the IRTE while holding ir_list_lock.  Add comments with --verbose
enabled to explain exactly what is and isn't protected by ir_list_lock.

Fixes: 411b44ba80ab ("svm: Implements update_pi_irte hook to setup posted interrupt")
Reported-by: dengqiao.joey <dengqiao.joey@bytedance.com>
Cc: stable@vger.kernel.org
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20230808233132.2499764-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 8e041b215ddb..2092db892d7d 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -791,6 +791,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	int ret = 0;
 	unsigned long flags;
 	struct amd_svm_iommu_ir *ir;
+	u64 entry;
 
 	/**
 	 * In some cases, the existing irte is updated and re-set,
@@ -824,6 +825,18 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	ir->data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
+
+	/*
+	 * Update the target pCPU for IOMMU doorbells if the vCPU is running.
+	 * If the vCPU is NOT running, i.e. is blocking or scheduled out, KVM
+	 * will update the pCPU info when the vCPU awkened and/or scheduled in.
+	 * See also avic_vcpu_load().
+	 */
+	entry = READ_ONCE(*(svm->avic_physical_id_cache));
+	if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
+		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
+				    true, pi->ir_data);
+
 	list_add(&ir->node, &svm->ir_list);
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 out:
@@ -1031,6 +1044,13 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (kvm_vcpu_is_blocking(vcpu))
 		return;
 
+	/*
+	 * Grab the per-vCPU interrupt remapping lock even if the VM doesn't
+	 * _currently_ have assigned devices, as that can change.  Holding
+	 * ir_list_lock ensures that either svm_ir_list_add() will consume
+	 * up-to-date entry information, or that this task will wait until
+	 * svm_ir_list_add() completes to set the new target pCPU.
+	 */
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
 	entry = READ_ONCE(*(svm->avic_physical_id_cache));
@@ -1067,6 +1087,14 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
 		return;
 
+	/*
+	 * Take and hold the per-vCPU interrupt remapping lock while updating
+	 * the Physical ID entry even though the lock doesn't protect against
+	 * multiple writers (see above).  Holding ir_list_lock ensures that
+	 * either svm_ir_list_add() will consume up-to-date entry information,
+	 * or that this task will wait until svm_ir_list_add() completes to
+	 * mark the vCPU as not running.
+	 */
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
 	avic_update_iommu_vcpu_affinity(vcpu, -1, 0);

