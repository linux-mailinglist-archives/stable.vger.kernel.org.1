Return-Path: <stable+bounces-93718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F1E9D05D1
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C7DB21344
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590E1DB940;
	Sun, 17 Nov 2024 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGPDdaMe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051021CACE0
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875224; cv=none; b=LDVGknK7UBMiiAQw6B60Sv1MWXERgIlsqfHyoiblQAoGaxl7Sp5Qt6dYsDJ2yDV1tdO14F+YIPqgAvlkeLHmcLC9ctdnTIa5hBdOoWJ3DH1HziDfzKlY00g19bMKqMopAfXmUSPhiEF0bd78xQscIE50moLO69/d9qXmLXstN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875224; c=relaxed/simple;
	bh=oKRjAqg+zpWdh8qLZvts6ahs99JhPpRsHKwy8lWczOw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IbpGzXoKycIZbQNBN9NdlCFSaJnJHqzEm/Rt9sY9/eKONFt96VKJWWo+IpO3iZcY0xwI0a1PKWhVvwZrqaK9mQHZ2bRiKY/PIraEfwhCaXraOe8F26cwv5eLuqA9d5qQWkuOcRdQzjc6E7+di6k/5FVzXR+3Taxxqr0qHSL6c9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGPDdaMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEF1C4CECD;
	Sun, 17 Nov 2024 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731875223;
	bh=oKRjAqg+zpWdh8qLZvts6ahs99JhPpRsHKwy8lWczOw=;
	h=Subject:To:Cc:From:Date:From;
	b=VGPDdaMetadHyI0bA01149A/XylaKy7o6pgzyfw9csY1pwNyzyxZ3yf06OJyTvJs6
	 N9UMLnU0dRRRPsvrqs1qtzER+zKDsC19UZR/5PNUh+vDEGa55zA7T65c6RM8D78E26
	 u4vhusQ7pAak/a+v3Sho2ys1OypNtMIGOsI2Nhio=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Treat vpid01 as current if L2 is active, but with" failed to apply to 5.10-stable tree
To: seanjc@google.com,chao.gao@intel.com,like.xu.linux@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:26:38 +0100
Message-ID: <2024111738-mystified-chunk-c6a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2657b82a78f18528bef56dc1b017158490970873
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111738-mystified-chunk-c6a7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2657b82a78f18528bef56dc1b017158490970873 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 31 Oct 2024 13:20:11 -0700
Subject: [PATCH] KVM: nVMX: Treat vpid01 as current if L2 is active, but with
 VPID disabled

When getting the current VPID, e.g. to emulate a guest TLB flush, return
vpid01 if L2 is running but with VPID disabled, i.e. if VPID is disabled
in vmcs12.  Architecturally, if VPID is disabled, then the guest and host
effectively share VPID=0.  KVM emulates this behavior by using vpid01 when
running an L2 with VPID disabled (see prepare_vmcs02_early_rare()), and so
KVM must also treat vpid01 as the current VPID while L2 is active.

Unconditionally treating vpid02 as the current VPID when L2 is active
causes KVM to flush TLB entries for vpid02 instead of vpid01, which
results in TLB entries from L1 being incorrectly preserved across nested
VM-Enter to L2 (L2=>L1 isn't problematic, because the TLB flush after
nested VM-Exit flushes vpid01).

The bug manifests as failures in the vmx_apicv_test KVM-Unit-Test, as KVM
incorrectly retains TLB entries for the APIC-access page across a nested
VM-Enter.

Opportunisticaly add comments at various touchpoints to explain the
architectural requirements, and also why KVM uses vpid01 instead of vpid02.

All credit goes to Chao, who root caused the issue and identified the fix.

Link: https://lore.kernel.org/all/ZwzczkIlYGX+QXJz@intel.com
Fixes: 2b4a5a5d5688 ("KVM: nVMX: Flush current VPID (L1 vs. L2) for KVM_REQ_TLB_FLUSH_GUEST")
Cc: stable@vger.kernel.org
Cc: Like Xu <like.xu.linux@gmail.com>
Debugged-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Tested-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/r/20241031202011.1580522-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a8e7bc04d9bf..931a7361c30f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1197,11 +1197,14 @@ static void nested_vmx_transition_tlb_flush(struct kvm_vcpu *vcpu,
 	kvm_hv_nested_transtion_tlb_flush(vcpu, enable_ept);
 
 	/*
-	 * If vmcs12 doesn't use VPID, L1 expects linear and combined mappings
-	 * for *all* contexts to be flushed on VM-Enter/VM-Exit, i.e. it's a
-	 * full TLB flush from the guest's perspective.  This is required even
-	 * if VPID is disabled in the host as KVM may need to synchronize the
-	 * MMU in response to the guest TLB flush.
+	 * If VPID is disabled, then guest TLB accesses use VPID=0, i.e. the
+	 * same VPID as the host, and so architecturally, linear and combined
+	 * mappings for VPID=0 must be flushed at VM-Enter and VM-Exit.  KVM
+	 * emulates L2 sharing L1's VPID=0 by using vpid01 while running L2,
+	 * and so KVM must also emulate TLB flush of VPID=0, i.e. vpid01.  This
+	 * is required if VPID is disabled in KVM, as a TLB flush (there are no
+	 * VPIDs) still occurs from L1's perspective, and KVM may need to
+	 * synchronize the MMU in response to the guest TLB flush.
 	 *
 	 * Note, using TLB_FLUSH_GUEST is correct even if nested EPT is in use.
 	 * EPT is a special snowflake, as guest-physical mappings aren't
@@ -2315,6 +2318,17 @@ static void prepare_vmcs02_early_rare(struct vcpu_vmx *vmx,
 
 	vmcs_write64(VMCS_LINK_POINTER, INVALID_GPA);
 
+	/*
+	 * If VPID is disabled, then guest TLB accesses use VPID=0, i.e. the
+	 * same VPID as the host.  Emulate this behavior by using vpid01 for L2
+	 * if VPID is disabled in vmcs12.  Note, if VPID is disabled, VM-Enter
+	 * and VM-Exit are architecturally required to flush VPID=0, but *only*
+	 * VPID=0.  I.e. using vpid02 would be ok (so long as KVM emulates the
+	 * required flushes), but doing so would cause KVM to over-flush.  E.g.
+	 * if L1 runs L2 X with VPID12=1, then runs L2 Y with VPID12 disabled,
+	 * and then runs L2 X again, then KVM can and should retain TLB entries
+	 * for VPID12=1.
+	 */
 	if (enable_vpid) {
 		if (nested_cpu_has_vpid(vmcs12) && vmx->nested.vpid02)
 			vmcs_write16(VIRTUAL_PROCESSOR_ID, vmx->nested.vpid02);
@@ -5950,6 +5964,12 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 		return nested_vmx_fail(vcpu,
 			VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
 
+	/*
+	 * Always flush the effective vpid02, i.e. never flush the current VPID
+	 * and never explicitly flush vpid01.  INVVPID targets a VPID, not a
+	 * VMCS, and so whether or not the current vmcs12 has VPID enabled is
+	 * irrelevant (and there may not be a loaded vmcs12).
+	 */
 	vpid02 = nested_get_vpid02(vcpu);
 	switch (type) {
 	case VMX_VPID_EXTENT_INDIVIDUAL_ADDR:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 81ed596e4454..9886d67d9512 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3216,7 +3216,7 @@ void vmx_flush_tlb_all(struct kvm_vcpu *vcpu)
 
 static inline int vmx_get_current_vpid(struct kvm_vcpu *vcpu)
 {
-	if (is_guest_mode(vcpu))
+	if (is_guest_mode(vcpu) && nested_cpu_has_vpid(get_vmcs12(vcpu)))
 		return nested_get_vpid02(vcpu);
 	return to_vmx(vcpu)->vpid;
 }


