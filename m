Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862A976AD7C
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjHAJ3t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjHAJ3e (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:29:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE92D76
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01894614F3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D710C433C8;
        Tue,  1 Aug 2023 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882096;
        bh=UauG5BKGoGGrmhc5cuzxLQXEhp2uHjJ4K/HrXkEFFQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edrZgOD+/08pMwMCHZ4Uo1Bd1umtwZtldlIsrcqWqKcrE2iU7IJzwcSitASqzxCRt
         AlQJVJKpMNkxA1HY20q4anbEqC68XNTWNnCUOd6Yb1+Cyyax9HR3JVyEogHwBX6OsT
         bCRI48wnyOWV9lnhDOkWk2pfWLiyJKQxDJWwmFSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+5feef0b9ee9c8e9e5689@syzkaller.appspotmail.com,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 139/155] KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is invalid
Date:   Tue,  1 Aug 2023 11:20:51 +0200
Message-ID: <20230801091915.106793981@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 26a0652cb453c72f6aab0974bc4939e9b14f886b ]

Reject KVM_SET_SREGS{2} with -EINVAL if the incoming CR0 is invalid,
e.g. due to setting bits 63:32, illegal combinations, or to a value that
isn't allowed in VMX (non-)root mode.  The VMX checks in particular are
"fun" as failure to disallow Real Mode for an L2 that is configured with
unrestricted guest disabled, when KVM itself has unrestricted guest
enabled, will result in KVM forcing VM86 mode to virtual Real Mode for
L2, but then fail to unwind the related metadata when synthesizing a
nested VM-Exit back to L1 (which has unrestricted guest enabled).

Opportunistically fix a benign typo in the prototype for is_valid_cr4().

Cc: stable@vger.kernel.org
Reported-by: syzbot+5feef0b9ee9c8e9e5689@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000f316b705fdf6e2b4@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20230613203037.1968489-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  3 ++-
 arch/x86/kvm/svm/svm.c             |  6 ++++++
 arch/x86/kvm/vmx/vmx.c             | 28 ++++++++++++++++++------
 arch/x86/kvm/x86.c                 | 34 +++++++++++++++++++-----------
 5 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 23ea8a25cbbeb..4bdcb91478a51 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -34,6 +34,7 @@ KVM_X86_OP(get_segment)
 KVM_X86_OP(get_cpl)
 KVM_X86_OP(set_segment)
 KVM_X86_OP_NULL(get_cs_db_l_bits)
+KVM_X86_OP(is_valid_cr0)
 KVM_X86_OP(set_cr0)
 KVM_X86_OP(is_valid_cr4)
 KVM_X86_OP(set_cr4)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9e800d4d323c6..08cfc26ee7c67 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1333,8 +1333,9 @@ struct kvm_x86_ops {
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
 	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
+	bool (*is_valid_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
-	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr0);
+	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	int (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
 	void (*get_idt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0611dac70c25c..302a4669c5a15 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1734,6 +1734,11 @@ static void svm_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 	vmcb_mark_dirty(svm->vmcb, VMCB_DT);
 }
 
+static bool svm_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	return true;
+}
+
 void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4596,6 +4601,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_segment = svm_set_segment,
 	.get_cpl = svm_get_cpl,
 	.get_cs_db_l_bits = kvm_get_cs_db_l_bits,
+	.is_valid_cr0 = svm_is_valid_cr0,
 	.set_cr0 = svm_set_cr0,
 	.is_valid_cr4 = svm_is_valid_cr4,
 	.set_cr4 = svm_set_cr4,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0841f9a34d1c2..89744ee06101a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2894,6 +2894,15 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(vcpu->kvm);
 
+	/*
+	 * KVM should never use VM86 to virtualize Real Mode when L2 is active,
+	 * as using VM86 is unnecessary if unrestricted guest is enabled, and
+	 * if unrestricted guest is disabled, VM-Enter (from L1) with CR0.PG=0
+	 * should VM-Fail and KVM should reject userspace attempts to stuff
+	 * CR0.PG=0 when L2 is active.
+	 */
+	WARN_ON_ONCE(is_guest_mode(vcpu));
+
 	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
 	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES);
 	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_DS], VCPU_SREG_DS);
@@ -3084,6 +3093,17 @@ void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 #define CR3_EXITING_BITS (CPU_BASED_CR3_LOAD_EXITING | \
 			  CPU_BASED_CR3_STORE_EXITING)
 
+static bool vmx_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	if (is_guest_mode(vcpu))
+		return nested_guest_cr0_valid(vcpu, cr0);
+
+	if (to_vmx(vcpu)->nested.vmxon)
+		return nested_host_cr0_valid(vcpu, cr0);
+
+	return true;
+}
+
 void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -5027,18 +5047,11 @@ static int handle_set_cr0(struct kvm_vcpu *vcpu, unsigned long val)
 		val = (val & ~vmcs12->cr0_guest_host_mask) |
 			(vmcs12->guest_cr0 & vmcs12->cr0_guest_host_mask);
 
-		if (!nested_guest_cr0_valid(vcpu, val))
-			return 1;
-
 		if (kvm_set_cr0(vcpu, val))
 			return 1;
 		vmcs_writel(CR0_READ_SHADOW, orig_val);
 		return 0;
 	} else {
-		if (to_vmx(vcpu)->nested.vmxon &&
-		    !nested_host_cr0_valid(vcpu, val))
-			return 1;
-
 		return kvm_set_cr0(vcpu, val);
 	}
 }
@@ -7744,6 +7757,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_segment = vmx_set_segment,
 	.get_cpl = vmx_get_cpl,
 	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
+	.is_valid_cr0 = vmx_is_valid_cr0,
 	.set_cr0 = vmx_set_cr0,
 	.is_valid_cr4 = vmx_is_valid_cr4,
 	.set_cr4 = vmx_set_cr4,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7e1e3bc745622..285ba12be8ce3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -876,6 +876,22 @@ int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
 }
 EXPORT_SYMBOL_GPL(load_pdptrs);
 
+static bool kvm_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+#ifdef CONFIG_X86_64
+	if (cr0 & 0xffffffff00000000UL)
+		return false;
+#endif
+
+	if ((cr0 & X86_CR0_NW) && !(cr0 & X86_CR0_CD))
+		return false;
+
+	if ((cr0 & X86_CR0_PG) && !(cr0 & X86_CR0_PE))
+		return false;
+
+	return static_call(kvm_x86_is_valid_cr0)(vcpu, cr0);
+}
+
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
@@ -898,20 +914,13 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	unsigned long old_cr0 = kvm_read_cr0(vcpu);
 	unsigned long pdptr_bits = X86_CR0_CD | X86_CR0_NW | X86_CR0_PG;
 
-	cr0 |= X86_CR0_ET;
-
-#ifdef CONFIG_X86_64
-	if (cr0 & 0xffffffff00000000UL)
+	if (!kvm_is_valid_cr0(vcpu, cr0))
 		return 1;
-#endif
-
-	cr0 &= ~CR0_RESERVED_BITS;
 
-	if ((cr0 & X86_CR0_NW) && !(cr0 & X86_CR0_CD))
-		return 1;
+	cr0 |= X86_CR0_ET;
 
-	if ((cr0 & X86_CR0_PG) && !(cr0 & X86_CR0_PE))
-		return 1;
+	/* Write to CR0 reserved bits are ignored, even on Intel. */
+	cr0 &= ~CR0_RESERVED_BITS;
 
 #ifdef CONFIG_X86_64
 	if ((vcpu->arch.efer & EFER_LME) && !is_paging(vcpu) &&
@@ -10643,7 +10652,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 			return false;
 	}
 
-	return kvm_is_valid_cr4(vcpu, sregs->cr4);
+	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
+	       kvm_is_valid_cr0(vcpu, sregs->cr0);
 }
 
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
-- 
2.40.1



