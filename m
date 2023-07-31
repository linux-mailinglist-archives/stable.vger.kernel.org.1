Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C738F76958B
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 14:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjGaMFP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjGaMFL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 08:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F221705
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 05:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072F361089
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47F2C433C7;
        Mon, 31 Jul 2023 12:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690805094;
        bh=GqCwwQV5uJOfbZSxXvNR8kX6ZO+Ew5P4XX/X6RQwruI=;
        h=Subject:To:Cc:From:Date:From;
        b=bQal7V8FNSCv+lD/XOvF4iVaiBJQB1cX9N72ienTWulnRrjsDMc1koh3vr1WXx5Hq
         KfQqxmk9eWn2PtiamuWsweeYp7A+hu44Uv9LhgZDardBYWAsrAAM0C4Clby1U0e29t
         GWIcEnJ3jflbnbOzRgzKz/eZ8DX0bvq+ABMdLHXs=
Subject: FAILED: patch "[PATCH] KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is" failed to apply to 5.10-stable tree
To:     seanjc@google.com, pbonzini@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 31 Jul 2023 14:04:43 +0200
Message-ID: <2023073143-juggle-brussels-4fcc@gregkh>
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
git cherry-pick -x 26a0652cb453c72f6aab0974bc4939e9b14f886b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023073143-juggle-brussels-4fcc@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

26a0652cb453 ("KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is invalid")
e4fc23bad813 ("KVM: x86: remove KVM_X86_OP_NULL and mark optional kvm_x86_ops")
8a2897853c53 ("KVM: x86: return 1 unconditionally for availability of KVM_CAP_VAPIC")
03d004cd0715 ("KVM: x86: Use more verbose names for mem encrypt kvm_x86_ops hooks")
872e0c5308d1 ("KVM: x86: Move get_cs_db_l_bits() helper to SVM")
58fccda47e4b ("KVM: VMX: Rename VMX functions to conform to kvm_x86_ops names")
7ad02ef0da25 ("KVM: x86: Use static_call() for copy/move encryption context ioctls()")
a0941a64a97d ("KVM: x86: Use static_call() for .vcpu_deliver_sipi_vector()")
e27bc0440ebd ("KVM: x86: Rename kvm_x86_ops pointers to align w/ preferred vendor names")
57dfd7b53dec ("KVM: x86: Move delivery of non-APICv interrupt into vendor code")
dd6e63122018 ("KVM: x86: add system attribute to retrieve full set of supported xsave states")
c3e8abf0f353 ("KVM: x86: Remove defunct pre_block/post_block kvm_x86_ops hooks")
98c25ead5eda ("KVM: VMX: Move preemption timer <=> hrtimer dance to common x86")
d76fb40637fc ("KVM: VMX: Handle PI descriptor updates during vcpu_put/load")
4f5a884fc212 ("Merge branch 'kvm-pi-raw-spinlock' into HEAD")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26a0652cb453c72f6aab0974bc4939e9b14f886b Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 13 Jun 2023 13:30:35 -0700
Subject: [PATCH] KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is
 invalid

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

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 13bc212cd4bc..e3054e3e46d5 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -37,6 +37,7 @@ KVM_X86_OP(get_segment)
 KVM_X86_OP(get_cpl)
 KVM_X86_OP(set_segment)
 KVM_X86_OP(get_cs_db_l_bits)
+KVM_X86_OP(is_valid_cr0)
 KVM_X86_OP(set_cr0)
 KVM_X86_OP_OPTIONAL(post_set_cr3)
 KVM_X86_OP(is_valid_cr4)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 28bd38303d70..3bc146dfd38d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1566,9 +1566,10 @@ struct kvm_x86_ops {
 	void (*set_segment)(struct kvm_vcpu *vcpu,
 			    struct kvm_segment *var, int seg);
 	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
+	bool (*is_valid_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*post_set_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
-	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr0);
+	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	int (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
 	void (*get_idt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cea08e5fa69b..956726d867aa 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1786,6 +1786,11 @@ static void sev_post_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 	}
 }
 
+static bool svm_is_valid_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	return true;
+}
+
 void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4809,6 +4814,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_segment = svm_set_segment,
 	.get_cpl = svm_get_cpl,
 	.get_cs_db_l_bits = svm_get_cs_db_l_bits,
+	.is_valid_cr0 = svm_is_valid_cr0,
 	.set_cr0 = svm_set_cr0,
 	.post_set_cr3 = sev_post_set_cr3,
 	.is_valid_cr4 = svm_is_valid_cr4,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0dd4612b0ca2..3d011d62d969 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3047,6 +3047,15 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
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
@@ -3236,6 +3245,17 @@ void ept_save_pdptrs(struct kvm_vcpu *vcpu)
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
@@ -5375,18 +5395,11 @@ static int handle_set_cr0(struct kvm_vcpu *vcpu, unsigned long val)
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
@@ -8214,6 +8227,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_segment = vmx_set_segment,
 	.get_cpl = vmx_get_cpl,
 	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
+	.is_valid_cr0 = vmx_is_valid_cr0,
 	.set_cr0 = vmx_set_cr0,
 	.is_valid_cr4 = vmx_is_valid_cr4,
 	.set_cr4 = vmx_set_cr4,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 27080bd986b5..278dbd37dab2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -906,6 +906,22 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
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
 	/*
@@ -952,20 +968,13 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	unsigned long old_cr0 = kvm_read_cr0(vcpu);
 
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
@@ -11468,7 +11477,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 			return false;
 	}
 
-	return kvm_is_valid_cr4(vcpu, sregs->cr4);
+	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
+	       kvm_is_valid_cr0(vcpu, sregs->cr0);
 }
 
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,

