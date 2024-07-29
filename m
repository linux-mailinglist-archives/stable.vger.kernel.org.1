Return-Path: <stable+bounces-62491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8DB93F39F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 13:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FC71F22773
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AEA145B35;
	Mon, 29 Jul 2024 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+ehkUJE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AA145A08
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251181; cv=none; b=nTWXB42DBlSOVlWLGjUvk10SgWirqGzyw3OTzZEzgYIoN7XKtmBJrnvXxqmluzWG7b44w5ju9+yCRWGGt2X0cUS8XbnDWkFphMe2ffcW+kql/Vvq8fnMvikL8wouBeaHfw2K1GrcPY1pgB3tgJt0JttlOhtHYH1lHiBDe0fg2l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251181; c=relaxed/simple;
	bh=vc4wzertBGCscQyyvzCWgrMdF1gnwksvgSC80JWTKCU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=giJGcga1KBFCHRm7k6SM6GCmc9VMWBY3n2Kk3Kn3ua5LHkp9vso+8JDxPMHVK57bcGUayAggRavq6drkwbuEUQDKn9DIbX4XR1vc6En55alQQ1gJCdgPbru+rOOoP20S/28wngpky+59WpDq1cBlf/BcyEPMTz8FLMy2Da0DpnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i+ehkUJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A488C32786;
	Mon, 29 Jul 2024 11:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722251181;
	bh=vc4wzertBGCscQyyvzCWgrMdF1gnwksvgSC80JWTKCU=;
	h=Subject:To:Cc:From:Date:From;
	b=i+ehkUJEayZKFb3bV0PW9odTOqds1KZUL6jiOhJtuxPYu8II2yQjX2h3/gu5NQD8I
	 Cdem4DD2PCy/PIEBSw21yCAj9d/ZEpGShcbl7F3dfVCIfM5q442xGgL1/8dFfe301F
	 H059GV6y9OvQDVc0fNif7Y9o2kEE7m1rBnrlR3Zg=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Check for pending posted interrupts when looking" failed to apply to 6.6-stable tree
To: seanjc@google.com,jmattson@google.com,mlevitsk@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 13:06:18 +0200
Message-ID: <2024072918-outsource-hardwired-03be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 27c4fa42b11af780d49ce704f7fa67b3c2544df4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072918-outsource-hardwired-03be@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


