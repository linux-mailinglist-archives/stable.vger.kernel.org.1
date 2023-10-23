Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BCA7D30DA
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjJWLC6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJWLC5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:02:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127010C2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:02:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86414C433C9;
        Mon, 23 Oct 2023 11:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058974;
        bh=I48jHKlmTuX1pyy2ucxro1XzV2/lgTnYuGM+e8blY0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFkdjLERV82xE2gbPaqrJLlmb5K9XcAVKGTxpCWMXnxbXwYLMweh9OP483j+N7PX3
         1AaY7ZD2JjXUfF+5PtEcBMqDeKvec8yEmDCIrNYsMtcG1W3juPAwNML+HzNxdmoBBa
         DqtMWoh8yT2DflbsMy5hv5FFD8oCNhFpx48e9apU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tyler Stachecki <stachecki.tyler@gmail.com>,
        Leonardo Bras <leobras@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.5 021/241] KVM: x86: Constrain guest-supported xfeatures only at KVM_GET_XSAVE{2}
Date:   Mon, 23 Oct 2023 12:53:27 +0200
Message-ID: <20231023104834.448183629@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 8647c52e9504c99752a39f1d44f6268f82c40a5c upstream.

Mask off xfeatures that aren't exposed to the guest only when saving guest
state via KVM_GET_XSAVE{2} instead of modifying user_xfeatures directly.
Preserving the maximal set of xfeatures in user_xfeatures restores KVM's
ABI for KVM_SET_XSAVE, which prior to commit ad856280ddea ("x86/kvm/fpu:
Limit guest user_xfeatures to supported bits of XCR0") allowed userspace
to load xfeatures that are supported by the host, irrespective of what
xfeatures are exposed to the guest.

There is no known use case where userspace *intentionally* loads xfeatures
that aren't exposed to the guest, but the bug fixed by commit ad856280ddea
was specifically that KVM_GET_SAVE{2} would save xfeatures that weren't
exposed to the guest, e.g. would lead to userspace unintentionally loading
guest-unsupported xfeatures when live migrating a VM.

Restricting KVM_SET_XSAVE to guest-supported xfeatures is especially
problematic for QEMU-based setups, as QEMU has a bug where instead of
terminating the VM if KVM_SET_XSAVE fails, QEMU instead simply stops
loading guest state, i.e. resumes the guest after live migration with
incomplete guest state, and ultimately results in guest data corruption.

Note, letting userspace restore all host-supported xfeatures does not fix
setups where a VM is migrated from a host *without* commit ad856280ddea,
to a target with a subset of host-supported xfeatures.  However there is
no way to safely address that scenario, e.g. KVM could silently drop the
unsupported features, but that would be a clear violation of KVM's ABI and
so would require userspace to opt-in, at which point userspace could
simply be updated to sanitize the to-be-loaded XSAVE state.

Reported-by: Tyler Stachecki <stachecki.tyler@gmail.com>
Closes: https://lore.kernel.org/all/20230914010003.358162-1-tstachecki@bloomberg.net
Fixes: ad856280ddea ("x86/kvm/fpu: Limit guest user_xfeatures to supported bits of XCR0")
Cc: stable@vger.kernel.org
Cc: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Message-Id: <20230928001956.924301-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/fpu/xstate.c |    5 +----
 arch/x86/kvm/cpuid.c         |    8 --------
 arch/x86/kvm/x86.c           |   18 ++++++++++++++++--
 3 files changed, 17 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1543,10 +1543,7 @@ static int fpstate_realloc(u64 xfeatures
 		fpregs_restore_userregs();
 
 	newfps->xfeatures = curfps->xfeatures | xfeatures;
-
-	if (!guest_fpu)
-		newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
-
+	newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
 	newfps->xfd = curfps->xfd & ~xfeatures;
 
 	/* Do the final updates within the locked region */
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -326,14 +326,6 @@ static void kvm_vcpu_after_set_cpuid(str
 	vcpu->arch.guest_supported_xcr0 =
 		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
 
-	/*
-	 * FP+SSE can always be saved/restored via KVM_{G,S}ET_XSAVE, even if
-	 * XSAVE/XCRO are not exposed to the guest, and even if XSAVE isn't
-	 * supported by the host.
-	 */
-	vcpu->arch.guest_fpu.fpstate->user_xfeatures = vcpu->arch.guest_supported_xcr0 |
-						       XFEATURE_MASK_FPSSE;
-
 	kvm_update_pv_runtime(vcpu);
 
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5389,12 +5389,26 @@ static int kvm_vcpu_ioctl_x86_set_debugr
 static void kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
 					  u8 *state, unsigned int size)
 {
+	/*
+	 * Only copy state for features that are enabled for the guest.  The
+	 * state itself isn't problematic, but setting bits in the header for
+	 * features that are supported in *this* host but not exposed to the
+	 * guest can result in KVM_SET_XSAVE failing when live migrating to a
+	 * compatible host without the features that are NOT exposed to the
+	 * guest.
+	 *
+	 * FP+SSE can always be saved/restored via KVM_{G,S}ET_XSAVE, even if
+	 * XSAVE/XCRO are not exposed to the guest, and even if XSAVE isn't
+	 * supported by the host.
+	 */
+	u64 supported_xcr0 = vcpu->arch.guest_supported_xcr0 |
+			     XFEATURE_MASK_FPSSE;
+
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return;
 
 	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.guest_fpu, state, size,
-				       vcpu->arch.guest_fpu.fpstate->user_xfeatures,
-				       vcpu->arch.pkru);
+				       supported_xcr0, vcpu->arch.pkru);
 }
 
 static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,


