Return-Path: <stable+bounces-167190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64561B22D16
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21DF188A814
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CE52EB5C5;
	Tue, 12 Aug 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fERWVLjP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882942F746C
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015313; cv=none; b=T7+VgNmB2qQHADUJUar0qVvTNqHeENJ0bRHTMtxIXXFxkIeS6s7oAj3G2LXHYjnYlsOhJd8Nn6k679FapVccPmNXZpkkyClvMKriFtYVx0Xya8p072pr5aHXPBi+rwFWH3gAGOa/8Rc1vb5IYcuLCbe6urrKiW9UPB1EDTpV0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015313; c=relaxed/simple;
	bh=JrX8ICOUxuK2B/B3hTiTxrzOEvR3HV1/UCCDyKO1G5A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZDCyq3DCwd9pRdeEUKPDhiNVedtmGyev6AyddAtx1RAEHsYIwKU+5NpfKn5v/3aT4Eug2wJ6Y2CfAAfJzjLF6nV/Squ0KZ4vh7JZkuk+I9vmaWIa6kl8zcYfQWlaGgE07JEbHrJaRm4FqG2Eo+7zX1XRc89IR24jjFIqc6jW3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fERWVLjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC1FC4CEF0;
	Tue, 12 Aug 2025 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015313;
	bh=JrX8ICOUxuK2B/B3hTiTxrzOEvR3HV1/UCCDyKO1G5A=;
	h=Subject:To:Cc:From:Date:From;
	b=fERWVLjPoC+enhRwUSAVCZ0h/o9G/pOzZMgoL9bs0giKCjLTJYSiuva8OhgdaHnZo
	 YAK5a6D/9MT3ZvnI7BwzK5kfpZu2qMEO6ldMgBT5OwQpqHzqz9MSLpnJQBbY7XAvoL
	 XR2+d0QbTswQlYLPQMor/G3FHFLEyD1FEXcnLXdA=
Subject: FAILED: patch "[PATCH] KVM: arm64: Filter out HCR_EL2 bits when running in" failed to apply to 6.12-stable tree
To: maz@kernel.org,oliver.upton@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:14:59 +0200
Message-ID: <2025081259-clutter-elusive-1a09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 303084ad12767db64c84ba8fcd0450aec38c8534
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081259-clutter-elusive-1a09@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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
 


