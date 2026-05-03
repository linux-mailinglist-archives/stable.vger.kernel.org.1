Return-Path: <stable+bounces-242714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOVcF4M692kIdwIAu9opvQ
	(envelope-from <stable+bounces-242714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:07:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BE4B5798
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A6263008230
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF07282F2E;
	Sun,  3 May 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XI7BR+Fo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724DE2E5B2A
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810047; cv=none; b=ppXbgN/WLVleFzyf3Atu/ziKaxsIPTsuz7iD6SjbAwL0i9C/MK8tB6WvlW69XdSlGHA1ZrqQLwShvBxmOM8a/kFbTzPhzpAtOVScvjCrn+ibDjinWqYrn8q/mJn/qMpmffptWcWCxclLrOfKRrn+5d3m9akQpz8hNiYqSOYUHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810047; c=relaxed/simple;
	bh=hs4sJGa5M2yOBHD5bMKej6DlVNqLJ7PSzMIrDNUQrBc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E0V+WPyljfrBe1oAiUnm2H53k3ah0c1u1/k7y8/kSKVdVKIFw9LLH7VTdERO2YtCGbHQSGrmPAxoo56Ho9NgODB3zwUE68uvXzEs2aX8ZCyuSuP3vns6C6Q635l3Nj2mR/ZWN4KxVZkLIfuc5/F3Frw74+mzHIdSuvWLN+hwHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XI7BR+Fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD979C2BCB4;
	Sun,  3 May 2026 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810047;
	bh=hs4sJGa5M2yOBHD5bMKej6DlVNqLJ7PSzMIrDNUQrBc=;
	h=Subject:To:Cc:From:Date:From;
	b=XI7BR+FobfuSpGIWZd+zizfja1PIg1P/mRljCTjZHOe6UT00KiFfwj1NUprxXo5ta
	 NEuDyUY3nvOzPEgXcuUh33Yz7Jx+p45fQi6FOxtlyCbbUUs25ZkK8/Dlykd4zwuujk
	 fX63CBnEYeNHy2UZFYZx1FG4YQ/plgUSaIJpxkeo=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Delay stuffing L2's current RIP into NextRIP until" failed to apply to 6.12-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:07:24 +0200
Message-ID: <2026050324-undertake-purifier-b2b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B00BE4B5798
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242714-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a0592461f39c00b28f552fe842a063a00043eaa8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050324-undertake-purifier-b2b1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a0592461f39c00b28f552fe842a063a00043eaa8 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 25 Feb 2026 00:59:48 +0000
Subject: [PATCH] KVM: nSVM: Delay stuffing L2's current RIP into NextRIP until
 vCPU run

For guests with NRIPS disabled, L1 does not provide NextRIP when running
an L2 with an injected soft interrupt, instead it advances L2's RIP
before running it. KVM uses L2's current RIP as the NextRIP in vmcb02 to
emulate a CPU without NRIPS.

However, in svm_set_nested_state(), the value used for L2's current RIP
comes from vmcb02, which is just whatever the vCPU had in vmcb02 before
restoring nested state (zero on a freshly created vCPU). Passing the
cached RIP value instead (i.e. kvm_rip_read()) would only fix the issue
if registers are restored before nested state.

Instead, split the logic of setting NextRIP in vmcb02. Handle the
'normal' case of initializing vmcb02's NextRIP using NextRIP from vmcb12
(or KVM_GET_NESTED_STATE's payload) in nested_vmcb02_prepare_control().
Delay the special case of stuffing L2's current RIP into vmcb02's
NextRIP until shortly before the vCPU is run, to make sure the most
up-to-date value of RIP is used regardless of KVM_SET_REGS and
KVM_SET_NESTED_STATE's relative ordering.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
CC: stable@vger.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260225005950.3739782-7-yosry@kernel.org
[sean: use new helper, svm_fixup_nested_rips()]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1cc083f95e6a..76d959d15e14 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -845,24 +845,15 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	vmcb02->control.event_inj_err       = svm->nested.ctl.event_inj_err;
 
 	/*
-	 * NextRIP is consumed on VMRUN as the return address pushed on the
-	 * stack for injected soft exceptions/interrupts.  If nrips is exposed
-	 * to L1, take it verbatim from vmcb12.
-	 *
-	 * If nrips is supported in hardware but not exposed to L1, stuff the
-	 * actual L2 RIP to emulate what a nrips=0 CPU would do (L1 is
-	 * responsible for advancing RIP prior to injecting the event). This is
-	 * only the case for the first L2 run after VMRUN. After that (e.g.
-	 * during save/restore), NextRIP is updated by the CPU and/or KVM, and
-	 * the value of the L2 RIP from vmcb12 should not be used.
+	 * If nrips is exposed to L1, take NextRIP as-is.  Otherwise, L1
+	 * advances L2's RIP before VMRUN instead of using NextRIP. KVM will
+	 * stuff the current RIP as vmcb02's NextRIP before L2 is run.  After
+	 * the first run of L2 (e.g. after save+restore), NextRIP is updated by
+	 * the CPU and/or KVM and should be used regardless of L1's support.
 	 */
-	if (boot_cpu_has(X86_FEATURE_NRIPS)) {
-		if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
-		    !svm->nested.nested_run_pending)
-			vmcb02->control.next_rip    = svm->nested.ctl.next_rip;
-		else
-			vmcb02->control.next_rip    = vmcb12_rip;
-	}
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
+	    !svm->nested.nested_run_pending)
+		vmcb02->control.next_rip = svm->nested.ctl.next_rip;
 
 	svm->nmi_l1_to_l2 = is_evtinj_nmi(vmcb02->control.event_inj);
 	if (is_evtinj_soft(vmcb02->control.event_inj)) {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 07f096758f34..f862bafc381a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3738,6 +3738,29 @@ static void svm_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 	svm->vmcb->control.event_inj = intr->nr | SVM_EVTINJ_VALID | type;
 }
 
+static void svm_fixup_nested_rips(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!is_guest_mode(vcpu) || !svm->nested.nested_run_pending)
+		return;
+
+	/*
+	 * If nrips is supported in hardware but not exposed to L1, stuff the
+	 * actual L2 RIP to emulate what a nrips=0 CPU would do (L1 is
+	 * responsible for advancing RIP prior to injecting the event). Once L2
+	 * runs after L1 executes VMRUN, NextRIP is updated by the CPU and/or
+	 * KVM, and this is no longer needed.
+	 *
+	 * This is done here (as opposed to when preparing vmcb02) to use the
+	 * most up-to-date value of RIP regardless of the order of restoring
+	 * registers and nested state in the vCPU save+restore path.
+	 */
+	if (boot_cpu_has(X86_FEATURE_NRIPS) &&
+	    !guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
+		svm->vmcb->control.next_rip = kvm_rip_read(vcpu);
+}
+
 void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
 				     int trig_mode, int vector)
 {
@@ -4334,6 +4357,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	    kvm_register_is_dirty(vcpu, VCPU_EXREG_ERAPS))
 		svm->vmcb->control.erap_ctl |= ERAP_CONTROL_CLEAR_RAP;
 
+	svm_fixup_nested_rips(vcpu);
+
 	svm_hv_update_vp_id(svm->vmcb, vcpu);
 
 	/*


