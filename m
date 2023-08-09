Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89194775D78
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjHILhz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjHILhy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F340173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F31763587
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403F2C433C7;
        Wed,  9 Aug 2023 11:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581072;
        bh=hbHBrkmb3zO/4wCorDCJDA3Swc/hPtL+18fIiKGITDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izXnFLefBTBpIco/98JGJS9w3J+y+Az3xuPFSp7IMkQTO/ju7gCT6xiGKuUIQr+5e
         9AGEXki1QQEb/smrOlupBTeKE4EDkqgQRhPcN9SUHrEb8uo6O3u9r2BiSb24ksNURy
         OBn9Jo1ZtaqIrO4Xsn1A8UTJ4HO6mQIXzYipCndk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/201] KVM: nVMX: Do not clear CR3 load/store exiting bits if L1 wants em
Date:   Wed,  9 Aug 2023 12:41:38 +0200
Message-ID: <20230809103647.031132491@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 470750b3425513b9f63f176e564e63e0e7998afc ]

Keep CR3 load/store exiting enable as needed when running L2 in order to
honor L1's desires.  This fixes a largely theoretical bug where L1 could
intercept CR3 but not CR0.PG and end up not getting the desired CR3 exits
when L2 enables paging.  In other words, the existing !is_paging() check
inadvertantly handles the normal case for L2 where vmx_set_cr0() is
called during VM-Enter, which is guaranteed to run with paging enabled,
and thus will never clear the bits.

Removing the !is_paging() check will also allow future consolidation and
cleanup of the related code.  From a performance perspective, this is
all a nop, as the VMCS controls shadow will optimize away the VMWRITE
when the controls are in the desired state.

Add a comment explaining why CR3 is intercepted, with a big disclaimer
about not querying the old CR3.  Because vmx_set_cr0() is used for flows
that are not directly tied to MOV CR3, e.g. vCPU RESET/INIT and nested
VM-Enter, it's possible that is_paging() is not synchronized with CR3
load/store exiting.  This is actually guaranteed in the current code, as
KVM starts with CR3 interception disabled.  Obviously that can be fixed,
but there's no good reason to play whack-a-mole, and it tends to end
poorly, e.g. descriptor table exiting for UMIP emulation attempted to be
precise in the past and ended up botching the interception toggling.

Fixes: fe3ef05c7572 ("KVM: nVMX: Prepare vmcs02 from vmcs01 and vmcs12")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210713163324.627647-25-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: c4abd7352023 ("KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/vmx.c | 46 +++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b9abe08c9d590..ca51df0df3f94 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3063,10 +3063,14 @@ void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
 }
 
+#define CR3_EXITING_BITS (CPU_BASED_CR3_LOAD_EXITING | \
+			  CPU_BASED_CR3_STORE_EXITING)
+
 void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long hw_cr0;
+	u32 tmp;
 
 	hw_cr0 = (cr0 & ~KVM_VM_CR0_ALWAYS_OFF);
 	if (is_unrestricted_guest(vcpu))
@@ -3093,18 +3097,42 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 #endif
 
 	if (enable_ept && !is_unrestricted_guest(vcpu)) {
+		/*
+		 * Ensure KVM has an up-to-date snapshot of the guest's CR3.  If
+		 * the below code _enables_ CR3 exiting, vmx_cache_reg() will
+		 * (correctly) stop reading vmcs.GUEST_CR3 because it thinks
+		 * KVM's CR3 is installed.
+		 */
 		if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
 			vmx_cache_reg(vcpu, VCPU_EXREG_CR3);
+
+		/*
+		 * When running with EPT but not unrestricted guest, KVM must
+		 * intercept CR3 accesses when paging is _disabled_.  This is
+		 * necessary because restricted guests can't actually run with
+		 * paging disabled, and so KVM stuffs its own CR3 in order to
+		 * run the guest when identity mapped page tables.
+		 *
+		 * Do _NOT_ check the old CR0.PG, e.g. to optimize away the
+		 * update, it may be stale with respect to CR3 interception,
+		 * e.g. after nested VM-Enter.
+		 *
+		 * Lastly, honor L1's desires, i.e. intercept CR3 loads and/or
+		 * stores to forward them to L1, even if KVM does not need to
+		 * intercept them to preserve its identity mapped page tables.
+		 */
 		if (!(cr0 & X86_CR0_PG)) {
-			/* From paging/starting to nonpaging */
-			exec_controls_setbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
-						  CPU_BASED_CR3_STORE_EXITING);
-			vcpu->arch.cr0 = cr0;
-			vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
-		} else if (!is_paging(vcpu)) {
-			/* From nonpaging to paging */
-			exec_controls_clearbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
-						    CPU_BASED_CR3_STORE_EXITING);
+			exec_controls_setbit(vmx, CR3_EXITING_BITS);
+		} else if (!is_guest_mode(vcpu)) {
+			exec_controls_clearbit(vmx, CR3_EXITING_BITS);
+		} else {
+			tmp = exec_controls_get(vmx);
+			tmp &= ~CR3_EXITING_BITS;
+			tmp |= get_vmcs12(vcpu)->cpu_based_vm_exec_control & CR3_EXITING_BITS;
+			exec_controls_set(vmx, tmp);
+		}
+
+		if (!is_paging(vcpu) != !(cr0 & X86_CR0_PG)) {
 			vcpu->arch.cr0 = cr0;
 			vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
 		}
-- 
2.40.1



