Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C217E7A39EA
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbjIQT4R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbjIQTzt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:55:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A35132
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:55:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D06DC433CA;
        Sun, 17 Sep 2023 19:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980543;
        bh=kbzADXJwpmKTRBsd+sviLtlV2CWddOybxlfDqRq31qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vkyk5gIUHVSlGwwPf2Id0ZnIiPiy10Hzb88Q0g0f9IHXyYtYuCUk8Q/+kyC/6KdAd
         uMFuIYUwM9ttSwcIXN5bFGn9wuRX+GWyoy0MuK1QMntX6DscUhT37aknM8DpDflpNP
         L9XFlSQIipdmTz8SmN0ynS5sHC5tvwPW7bYjEMxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Like Xu <like.xu.linux@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.5 222/285] KVM: VMX: Refresh available regs and IDT vectoring info before NMI handling
Date:   Sun, 17 Sep 2023 21:13:42 +0200
Message-ID: <20230917191059.179743344@linuxfoundation.org>
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

commit 50011c2a245792993f2756e5b5b571512bfa409e upstream.

Reset the mask of available "registers" and refresh the IDT vectoring
info snapshot in vmx_vcpu_enter_exit(), before KVM potentially handles a
an NMI VM-Exit.  One of the "registers" that KVM VMX lazily loads is the
vmcs.VM_EXIT_INTR_INFO field, which is holds the vector+type on "exception
or NMI" VM-Exits, i.e. is needed to identify NMIs.  Clearing the available
registers bitmask after handling NMIs results in KVM querying info from
the last VM-Exit that read vmcs.VM_EXIT_INTR_INFO, and leads to both
missed NMIs and spurious NMIs in the host.

Opportunistically grab vmcs.IDT_VECTORING_INFO_FIELD early in the VM-Exit
path too, e.g. to guard against similar consumption of stale data.  The
field is read on every "normal" VM-Exit, and there's no point in delaying
the inevitable.

Reported-by: Like Xu <like.xu.linux@gmail.com>
Fixes: 11df586d774f ("KVM: VMX: Handle NMI VM-Exits in noinstr region")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230825014532.2846714-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx/vmx.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7243,13 +7243,20 @@ static noinstr void vmx_vcpu_enter_exit(
 				   flags);
 
 	vcpu->arch.cr2 = native_read_cr2();
+	vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
+
+	vmx->idt_vectoring_info = 0;
 
 	vmx_enable_fb_clear(vmx);
 
-	if (unlikely(vmx->fail))
+	if (unlikely(vmx->fail)) {
 		vmx->exit_reason.full = 0xdead;
-	else
-		vmx->exit_reason.full = vmcs_read32(VM_EXIT_REASON);
+		goto out;
+	}
+
+	vmx->exit_reason.full = vmcs_read32(VM_EXIT_REASON);
+	if (likely(!vmx->exit_reason.failed_vmentry))
+		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
 
 	if ((u16)vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI &&
 	    is_nmi(vmx_get_intr_info(vcpu))) {
@@ -7258,6 +7265,7 @@ static noinstr void vmx_vcpu_enter_exit(
 		kvm_after_interrupt(vcpu);
 	}
 
+out:
 	guest_state_exit_irqoff();
 }
 
@@ -7379,8 +7387,6 @@ static fastpath_t vmx_vcpu_run(struct kv
 	loadsegment(es, __USER_DS);
 #endif
 
-	vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
-
 	pt_guest_exit(vmx);
 
 	kvm_load_host_xsave_state(vcpu);
@@ -7397,17 +7403,12 @@ static fastpath_t vmx_vcpu_run(struct kv
 		vmx->nested.nested_run_pending = 0;
 	}
 
-	vmx->idt_vectoring_info = 0;
-
 	if (unlikely(vmx->fail))
 		return EXIT_FASTPATH_NONE;
 
 	if (unlikely((u16)vmx->exit_reason.basic == EXIT_REASON_MCE_DURING_VMENTRY))
 		kvm_machine_check();
 
-	if (likely(!vmx->exit_reason.failed_vmentry))
-		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
-
 	trace_kvm_exit(vcpu, KVM_ISA_VMX);
 
 	if (unlikely(vmx->exit_reason.failed_vmentry))


