Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B04713D8A
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjE1T01 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjE1T01 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:26:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EBBDC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B78FB61C3F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65A5C433D2;
        Sun, 28 May 2023 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301984;
        bh=PD/IV8r7Ll9RRwNTbszomL7eoVYLpbzDSZtlgmAYATk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SShl/pW6vNd3nXfmozCq23zwSMt2Si9Twu2OPIhwMRrxzYrV1d9WXdhSGnj4KVRH2
         ps/my8k8g8ROwrvKBlYCeSXPtKumTy44fqrsrhhdbOUv1MFgNauB6GrapGdvKJX6K6
         uJ2a+EkopzlttSNkyL5w3LykxQ+7/Y4Dm6Dvv/k8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jann Horn <jannh@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.4 097/161] KVM: x86: do not report a vCPU as preempted outside instruction boundaries
Date:   Sun, 28 May 2023 20:10:21 +0100
Message-Id: <20230528190840.204911298@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 6cd88243c7e03845a450795e134b488fc2afb736 upstream.

If a vCPU is outside guest mode and is scheduled out, it might be in the
process of making a memory access.  A problem occurs if another vCPU uses
the PV TLB flush feature during the period when the vCPU is scheduled
out, and a virtual address has already been translated but has not yet
been accessed, because this is equivalent to using a stale TLB entry.

To avoid this, only report a vCPU as preempted if sure that the guest
is at an instruction boundary.  A rescheduling request will be delivered
to the host physical CPU as an external interrupt, so for simplicity
consider any vmexit *not* instruction boundary except for external
interrupts.

It would in principle be okay to report the vCPU as preempted also
if it is sleeping in kvm_vcpu_block(): a TLB flush IPI will incur the
vmentry/vmexit overhead unnecessarily, and optimistic spinning is
also unlikely to succeed.  However, leave it for later because right
now kvm_vcpu_check_block() is doing memory accesses.  Even
though the TLB flush issue only applies to virtual memory address,
it's very much preferrable to be conservative.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[OP: use VCPU_STAT() for debugfs entries]
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    3 +++
 arch/x86/kvm/svm.c              |    3 ++-
 arch/x86/kvm/vmx/vmx.c          |    1 +
 arch/x86/kvm/x86.c              |   22 ++++++++++++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -563,6 +563,7 @@ struct kvm_vcpu_arch {
 	u64 ia32_misc_enable_msr;
 	u64 smbase;
 	u64 smi_count;
+	bool at_instruction_boundary;
 	bool tpr_access_reporting;
 	u64 ia32_xss;
 	u64 microcode_version;
@@ -981,6 +982,8 @@ struct kvm_vcpu_stat {
 	u64 irq_injections;
 	u64 nmi_injections;
 	u64 req_event;
+	u64 preemption_reported;
+	u64 preemption_other;
 };
 
 struct x86_instruction_info;
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6246,7 +6246,8 @@ out:
 
 static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
-
+	if (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_INTR)
+		vcpu->arch.at_instruction_boundary = true;
 }
 
 static void svm_sched_in(struct kvm_vcpu *vcpu, int cpu)
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6358,6 +6358,7 @@ static void handle_external_interrupt_ir
 	);
 
 	kvm_after_interrupt(vcpu);
+	vcpu->arch.at_instruction_boundary = true;
 }
 STACK_FRAME_NON_STANDARD(handle_external_interrupt_irqoff);
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -207,6 +207,8 @@ struct kvm_stats_debugfs_item debugfs_en
 	{ "nmi_injections", VCPU_STAT(nmi_injections) },
 	{ "req_event", VCPU_STAT(req_event) },
 	{ "l1d_flush", VCPU_STAT(l1d_flush) },
+	{ "preemption_reported", VCPU_STAT(preemption_reported) },
+	{ "preemption_other", VCPU_STAT(preemption_other) },
 	{ "mmu_shadow_zapped", VM_STAT(mmu_shadow_zapped) },
 	{ "mmu_pte_write", VM_STAT(mmu_pte_write) },
 	{ "mmu_pde_zapped", VM_STAT(mmu_pde_zapped) },
@@ -3562,6 +3564,19 @@ static void kvm_steal_time_set_preempted
 	struct kvm_host_map map;
 	struct kvm_steal_time *st;
 
+	/*
+	 * The vCPU can be marked preempted if and only if the VM-Exit was on
+	 * an instruction boundary and will not trigger guest emulation of any
+	 * kind (see vcpu_run).  Vendor specific code controls (conservatively)
+	 * when this is true, for example allowing the vCPU to be marked
+	 * preempted if and only if the VM-Exit was due to a host interrupt.
+	 */
+	if (!vcpu->arch.at_instruction_boundary) {
+		vcpu->stat.preemption_other++;
+		return;
+	}
+
+	vcpu->stat.preemption_reported++;
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
@@ -8446,6 +8461,13 @@ static int vcpu_run(struct kvm_vcpu *vcp
 	vcpu->arch.l1tf_flush_l1d = true;
 
 	for (;;) {
+		/*
+		 * If another guest vCPU requests a PV TLB flush in the middle
+		 * of instruction emulation, the rest of the emulation could
+		 * use a stale page translation. Assume that any code after
+		 * this point can start executing an instruction.
+		 */
+		vcpu->arch.at_instruction_boundary = false;
 		if (kvm_vcpu_running(vcpu)) {
 			r = vcpu_enter_guest(vcpu);
 		} else {


