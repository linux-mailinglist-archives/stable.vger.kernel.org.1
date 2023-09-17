Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B217A3A17
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbjIQT62 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbjIQT6R (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:58:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA164101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:58:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2079BC433C7;
        Sun, 17 Sep 2023 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980690;
        bh=iLxdRoywkauh7b2Apk0BQR3LmdjNrX5WECw+la157RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+lbHz/1e8YiZedA7hvMQu4bacCDMF15rIw17ln0Lv/yair3Zz0Drgj2B0jzlouB3
         VjD9a5NY5hJuzXOo/e/WbjkfTD3h7RHOJvu1Sq0sUbHhDcERSxvV0+30o2MUUtgP6H
         m/Aqp5Xb/PikcS9vagd9dCmm7HwS0gtM6+/cMRQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "dengqiao.joey" <dengqiao.joey@bytedance.com>,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.5 228/285] KVM: SVM: Set target pCPU during IRTE update if target vCPU is running
Date:   Sun, 17 Sep 2023 21:13:48 +0200
Message-ID: <20230917191059.349171618@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit f3cebc75e7425d6949d726bb8e937095b0aef025 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/avic.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -791,6 +791,7 @@ static int svm_ir_list_add(struct vcpu_s
 	int ret = 0;
 	unsigned long flags;
 	struct amd_svm_iommu_ir *ir;
+	u64 entry;
 
 	/**
 	 * In some cases, the existing irte is updated and re-set,
@@ -824,6 +825,18 @@ static int svm_ir_list_add(struct vcpu_s
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
@@ -1031,6 +1044,13 @@ void avic_vcpu_load(struct kvm_vcpu *vcp
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
@@ -1067,6 +1087,14 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu
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


