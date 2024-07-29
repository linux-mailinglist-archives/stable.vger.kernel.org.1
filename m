Return-Path: <stable+bounces-62492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3302193F3A0
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 13:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D33A2845C0
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839D714534D;
	Mon, 29 Jul 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WVQNzrRy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42166145337
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251190; cv=none; b=o8ZobbOP61zLJ+9x00kallIumvjl2BpMUJ3lCk9jUykdRbddwDPRkKbYUk9q2npf/rQ1lZBrJExN7Mrnu3aJKqXaX01pjciipHFMwYCkSfHsQf6hNbGWuRkCI1HDyDwDRRfiPMo66wLWQa2Ra+k9rfKT7OcssBP4bjex2FyJOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251190; c=relaxed/simple;
	bh=Jcx3GacQG8mgAEaytRK2pPC0nfe9f3OVZWKJlYTKTJ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DmnJdHEN1vZUK8OLNI0bhmXSgIeYAjs3oMLam21bQy+jU7VEkqa8HUhae6ioSqgXIrTWpmvsRdND/WobzHt7EatjAFxVJp+YDtwa1s9EkeTMAgPQNQy9/JFRzyZ0gAj9IYsjG33tHAE2e2zJt2cfN83I443CIT4WAjZCu4KfnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WVQNzrRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEDBC4AF0A;
	Mon, 29 Jul 2024 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722251190;
	bh=Jcx3GacQG8mgAEaytRK2pPC0nfe9f3OVZWKJlYTKTJ0=;
	h=Subject:To:Cc:From:Date:From;
	b=WVQNzrRy1KlDeMSbp9FrmV0WUQ74XQy0UFxo26ZBDk3ZX3UEWbuWfnFpmptCQTu/4
	 PiImw1N129pDWsuRc6YZad0thcySPUdk1JtmUwrN9lno2RT0PkbylfWgEJCRK2VOa/
	 1iLhsVZAsLdbE8giOQj3j4EkQzadNK18DL1zHE4Q=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Check for pending posted interrupts when looking" failed to apply to 6.1-stable tree
To: seanjc@google.com,jmattson@google.com,mlevitsk@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 13:06:19 +0200
Message-ID: <2024072918-undivided-veneering-9883@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 27c4fa42b11af780d49ce704f7fa67b3c2544df4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072918-undivided-veneering-9883@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

27c4fa42b11a ("KVM: nVMX: Check for pending posted interrupts when looking for nested events")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27c4fa42b11af780d49ce704f7fa67b3c2544df4 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 7 Jun 2024 10:26:07 -0700
Subject: [PATCH] KVM: nVMX: Check for pending posted interrupts when looking
 for nested events

Check for pending (and notified!) posted interrupts when checking if L2
has a pending wake event, as fully posted/notified virtual interrupt is a
valid wake event for HLT.

Note that KVM must check vmx->nested.pi_pending to avoid prematurely
waking L2, e.g. even if KVM sees a non-zero PID.PIR and PID.0N=1, the
virtual interrupt won't actually be recognized until a notification IRQ is
received by the vCPU or the vCPU does (nested) VM-Enter.

Fixes: 26844fee6ade ("KVM: x86: never write to memory from kvm_vcpu_check_block()")
Cc: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/all/20231207010302.2240506-1-jmattson@google.com
Link: https://lore.kernel.org/r/20240607172609.3205077-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 411fe7aa0793..732340ff3300 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4034,8 +4034,40 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
 
 static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	return nested_vmx_preemption_timer_pending(vcpu) ||
-	       to_vmx(vcpu)->nested.mtf_pending;
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	void *vapic = vmx->nested.virtual_apic_map.hva;
+	int max_irr, vppr;
+
+	if (nested_vmx_preemption_timer_pending(vcpu) ||
+	    vmx->nested.mtf_pending)
+		return true;
+
+	/*
+	 * Virtual Interrupt Delivery doesn't require manual injection.  Either
+	 * the interrupt is already in GUEST_RVI and will be recognized by CPU
+	 * at VM-Entry, or there is a KVM_REQ_EVENT pending and KVM will move
+	 * the interrupt from the PIR to RVI prior to entering the guest.
+	 */
+	if (for_injection)
+		return false;
+
+	if (!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
+	    __vmx_interrupt_blocked(vcpu))
+		return false;
+
+	if (!vapic)
+		return false;
+
+	vppr = *((u32 *)(vapic + APIC_PROCPRI));
+
+	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
+	    pi_test_on(vmx->nested.pi_desc)) {
+		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+		if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0))
+			return true;
+	}
+
+	return false;
 }
 
 /*


