Return-Path: <stable+bounces-242727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG01KHQ892k2dwIAu9opvQ
	(envelope-from <stable+bounces-242727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:15:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F774B5998
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5133930137A0
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6063AEF4B;
	Sun,  3 May 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="efx1gzQ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412AE309F1B
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810424; cv=none; b=HA67LNpW8EyHZn3kZ3QtOp2vUFf95eOXE++IRvXCL/FEeVDenaphkiRCd/alJGvfywYSCalBYipSKj4ZCNb2HADDt0tUmJKn4yKUQmgeMWczSzkRrYaIO3V/Gw6L4L5YBtjts/0PZKI5z17Kj/H3y3p7HRCYPkDJWzOm7cvp7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810424; c=relaxed/simple;
	bh=oVFM88ZfAZ6WSE4CzBjo1C2SxH7wMrMFtTvbgq4qAQI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fY5qifyZ+jYG/XR+bwFDFNVok0n6j0U6hsEh/bRkxHCUHBmeKGnBVx3mBd44dJhpi5Ju6z8ryqL3VsTSfJ+NISDFf90BIwOUDKpg2Z5rgwWPRN8uU1s8JGqWzKQE2QIeDyt6+H3ZcqEwcIacOr16fsWbg5g0hOvMROC5vJ4Xu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=efx1gzQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E71C2BCB4;
	Sun,  3 May 2026 12:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810423;
	bh=oVFM88ZfAZ6WSE4CzBjo1C2SxH7wMrMFtTvbgq4qAQI=;
	h=Subject:To:Cc:From:Date:From;
	b=efx1gzQ4dmfLoLRy2IYnXAf08r5WGxdbLIkemzTDy1/c5YSLZgabNUqky1gLF6vge
	 x0Cr14kwBTn9zlJqxq7y7j0ijaTRHoOR6mlL9knQafLcPUGywh8l+tJqMK6YegdUsd
	 6N7XBaa7BhRDxElp7plBM+/qaKu4bEFDtXYktUhU=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Delay setting soft IRQ RIP tracking fields until" failed to apply to 5.10-stable tree
To: seanjc@google.com,yosry@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:13:27 +0200
Message-ID: <2026050327-cubbyhole-blatancy-a7af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16F774B5998
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
	TAGGED_FROM(0.00)[bounces-242727-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,msgid.link:url]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c64bc6ed1764c1b7e3c0017019f743196074092f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050327-cubbyhole-blatancy-a7af@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c64bc6ed1764c1b7e3c0017019f743196074092f Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 4 Mar 2026 16:06:56 -0800
Subject: [PATCH] KVM: nSVM: Delay setting soft IRQ RIP tracking fields until
 vCPU run

In the save+restore path, when restoring nested state, the values of RIP
and CS base passed into nested_vmcb02_prepare_control() are mostly
incorrect.  They are both pulled from the vmcb02. For CS base, the value
is only correct if system regs are restored before nested state. The
value of RIP is whatever the vCPU had in vmcb02 before restoring nested
state (zero on a freshly created vCPU).

Instead, take a similar approach to NextRIP, and delay initializing the
RIP tracking fields until shortly before the vCPU is run, to make sure
the most up-to-date values of RIP and CS base are used regardless of
KVM_SET_SREGS, KVM_SET_REGS, and KVM_SET_NESTED_STATE's relative
ordering.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
CC: stable@vger.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260225005950.3739782-8-yosry@kernel.org
[sean: deal with the svm_cancel_injection() madness]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 76d959d15e14..3e2841598a36 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -742,9 +742,7 @@ static bool is_evtinj_nmi(u32 evtinj)
 	return type == SVM_EVTINJ_TYPE_NMI;
 }
 
-static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
-					  unsigned long vmcb12_rip,
-					  unsigned long vmcb12_csbase)
+static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 {
 	u32 int_ctl_vmcb01_bits = V_INTR_MASKING_MASK;
 	u32 int_ctl_vmcb12_bits = V_TPR_MASK | V_IRQ_INJECTION_BITS_MASK;
@@ -856,15 +854,16 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 		vmcb02->control.next_rip = svm->nested.ctl.next_rip;
 
 	svm->nmi_l1_to_l2 = is_evtinj_nmi(vmcb02->control.event_inj);
+
+	/*
+	 * soft_int_csbase, soft_int_old_rip, and soft_int_next_rip (if L1
+	 * doesn't have NRIPS) are initialized later, before the vCPU is run.
+	 */
 	if (is_evtinj_soft(vmcb02->control.event_inj)) {
 		svm->soft_int_injected = true;
-		svm->soft_int_csbase = vmcb12_csbase;
-		svm->soft_int_old_rip = vmcb12_rip;
 		if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
 		    !svm->nested.nested_run_pending)
 			svm->soft_int_next_rip = svm->nested.ctl.next_rip;
-		else
-			svm->soft_int_next_rip = vmcb12_rip;
 	}
 
 	/* LBR_CTL_ENABLE_MASK is controlled by svm_update_lbrv() */
@@ -962,7 +961,7 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
-	nested_vmcb02_prepare_control(svm, vmcb12->save.rip, vmcb12->save.cs.base);
+	nested_vmcb02_prepare_control(svm);
 	nested_vmcb02_prepare_save(svm, vmcb12);
 
 	ret = nested_svm_load_cr3(&svm->vcpu, svm->nested.save.cr3,
@@ -1907,7 +1906,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
-	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip, svm->vmcb->save.cs.base);
+	nested_vmcb02_prepare_control(svm);
 
 	/*
 	 * Any previously restored state (e.g. KVM_SET_SREGS) would mark fields
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f862bafc381a..d82e30c40eaa 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3637,6 +3637,16 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	return svm_invoke_exit_handler(vcpu, svm->vmcb->control.exit_code);
 }
 
+static void svm_set_nested_run_soft_int_state(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	svm->soft_int_csbase = svm->vmcb->save.cs.base;
+	svm->soft_int_old_rip = kvm_rip_read(vcpu);
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
+		svm->soft_int_next_rip = kvm_rip_read(vcpu);
+}
+
 static int pre_svm_run(struct kvm_vcpu *vcpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
@@ -3759,6 +3769,13 @@ static void svm_fixup_nested_rips(struct kvm_vcpu *vcpu)
 	if (boot_cpu_has(X86_FEATURE_NRIPS) &&
 	    !guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		svm->vmcb->control.next_rip = kvm_rip_read(vcpu);
+
+	/*
+	 * Simiarly, initialize the soft int metadata here to use the most
+	 * up-to-date values of RIP and CS base, regardless of restore order.
+	 */
+	if (svm->soft_int_injected)
+		svm_set_nested_run_soft_int_state(vcpu);
 }
 
 void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
@@ -4128,6 +4145,18 @@ static void svm_complete_soft_interrupt(struct kvm_vcpu *vcpu, u8 vector,
 	bool is_soft = (type == SVM_EXITINTINFO_TYPE_SOFT);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	/*
+	 * Initialize the soft int fields *before* reading them below if KVM
+	 * aborted entry to the guest with a nested VMRUN pending.  To ensure
+	 * KVM uses up-to-date values for RIP and CS base across save/restore,
+	 * regardless of restore order, KVM waits to set the soft int fields
+	 * until VMRUN is imminent.  But when canceling injection, KVM requeues
+	 * the soft int and will reinject it via the standard injection flow,
+	 * and so KVM needs to grab the state from the pending nested VMRUN.
+	 */
+	if (is_guest_mode(vcpu) && svm->nested.nested_run_pending)
+		svm_set_nested_run_soft_int_state(vcpu);
+
 	/*
 	 * If NRIPS is enabled, KVM must snapshot the pre-VMRUN next_rip that's
 	 * associated with the original soft exception/interrupt.  next_rip is


