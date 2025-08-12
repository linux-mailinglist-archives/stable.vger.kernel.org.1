Return-Path: <stable+bounces-167189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 319ABB22D11
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6FA1889EA9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD12DCF44;
	Tue, 12 Aug 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BxNVccGc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFBC2F7469
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015310; cv=none; b=IcDo2zJJ5GNQFnizPds8pq3orY2SiaGR77aCNWUyQUsMubnwRuTVzazofxQlt+I7hJvZ0vf7TF1LO7saAQ/MKUDmW+u3nNa8B5zzH+bHj9xzii0DdNyPwq5KCmvog+HWQz29Cf8GBC7dxWBIOgU1zyhhz6tcS9fDiOpELCqDYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015310; c=relaxed/simple;
	bh=Ql/3vjDg8cxQnfol90wmTJzYFdM9KpEwAnzyzyfZEaw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZAOo3CaIZ+qEtfzWeGcR1qSUzVbxwmX7kDOHsLoL4TEjN27xYBPKsfZ20eRyqcGr604eF63BI/YnxUXRdEXNRyHFRB8fq2Sm2FzeJC52i8SQxtD8ifiAHnKIMW4ezgRXN8BbD3wJYjecd0rQliVfI4eIyol5e8k5u1SImZae4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BxNVccGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3FBC4CEF0;
	Tue, 12 Aug 2025 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015308;
	bh=Ql/3vjDg8cxQnfol90wmTJzYFdM9KpEwAnzyzyfZEaw=;
	h=Subject:To:Cc:From:Date:From;
	b=BxNVccGcMPw583Sq/k0Vd5fdXc1Kww398fENOSpohWRnIN3Ohvuyz0N7nyQ3idisF
	 /Meue1mj67UY0t39zx+yVPYn1vJiTvh19US6NdZCb9T6vgABgo4qODYq1pZSNiIt0C
	 XS5nFt+Nr+LfpL6UaoJqPec+uWxQQRrBdTHsTpyk=
Subject: FAILED: patch "[PATCH] KVM: arm64: Filter out HCR_EL2 bits when running in" failed to apply to 6.15-stable tree
To: maz@kernel.org,oliver.upton@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:14:59 +0200
Message-ID: <2025081258-convent-unscrew-2e57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 303084ad12767db64c84ba8fcd0450aec38c8534
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081258-convent-unscrew-2e57@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 303084ad12767db64c84ba8fcd0450aec38c8534 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Mon, 21 Jul 2025 11:19:50 +0100
Subject: [PATCH] KVM: arm64: Filter out HCR_EL2 bits when running in
 hypervisor context

Most HCR_EL2 bits are not supposed to affect EL2 at all, but only
the guest. However, we gladly merge these bits with the host's
HCR_EL2 configuration, irrespective of entering L1 or L2.

This leads to some funky behaviour, such as L1 trying to inject
a virtual SError for L2, and getting a taste of its own medecine.
Not quite what the architecture anticipated.

In the end, the only bits that matter are those we have defined as
invariants, either because we've made them RESx (E2H, HCD...), or
that we actively refuse to merge because the mess with KVM's own
logic.

Use the sanitisation infrastructure to get the RES1 bits, and let
things rip in a safer way.

Fixes: 04ab519bb86df ("KVM: arm64: nv: Configure HCR_EL2 for FEAT_NV2")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250721101955.535159-3-maz@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 477f1580ffea..e482181c6632 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -48,8 +48,7 @@ DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
 static u64 __compute_hcr(struct kvm_vcpu *vcpu)
 {
-	u64 guest_hcr = __vcpu_sys_reg(vcpu, HCR_EL2);
-	u64 hcr = vcpu->arch.hcr_el2;
+	u64 guest_hcr, hcr = vcpu->arch.hcr_el2;
 
 	if (!vcpu_has_nv(vcpu))
 		return hcr;
@@ -68,10 +67,21 @@ static u64 __compute_hcr(struct kvm_vcpu *vcpu)
 		if (!vcpu_el2_e2h_is_set(vcpu))
 			hcr |= HCR_NV1;
 
+		/*
+		 * Nothing in HCR_EL2 should impact running in hypervisor
+		 * context, apart from bits we have defined as RESx (E2H,
+		 * HCD and co), or that cannot be set directly (the EXCLUDE
+		 * bits). Given that we OR the guest's view with the host's,
+		 * we can use the 0 value as the starting point, and only
+		 * use the config-driven RES1 bits.
+		 */
+		guest_hcr = kvm_vcpu_apply_reg_masks(vcpu, HCR_EL2, 0);
+
 		write_sysreg_s(vcpu->arch.ctxt.vncr_array, SYS_VNCR_EL2);
 	} else {
 		host_data_clear_flag(VCPU_IN_HYP_CONTEXT);
 
+		guest_hcr = __vcpu_sys_reg(vcpu, HCR_EL2);
 		if (guest_hcr & HCR_NV) {
 			u64 va = __fix_to_virt(vncr_fixmap(smp_processor_id()));
 


