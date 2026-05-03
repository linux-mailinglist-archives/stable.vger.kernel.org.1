Return-Path: <stable+bounces-242713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF3rL3w692kIdwIAu9opvQ
	(envelope-from <stable+bounces-242713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:07:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CBC4B5791
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3A4C30087BA
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA37F2FE074;
	Sun,  3 May 2026 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FTUZXh0J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F12E5B2A
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810040; cv=none; b=WwoYhv4nPZzBGiADOcNgFfOkq9OFQ/gIGwDHGLWED/KbadLrO24pOjo/N/susfgs66ZxARutYCtC7nkuFiHNajDLChQSQ9a9J8cPdVHkCGw5YAXA8iJcVUe+nmO+ypHVwa4mZ6P80fCkcBRtLwbnTAuZeDE/Cvmm8ix0hVxI/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810040; c=relaxed/simple;
	bh=ix6UEUhECq8be0f+v9orryabp7ZrorY+VcZ3eMv8Cf0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JSSMUTuqlizS11EY0YG7p49ODvYqloHeRQYt+Y9tfD5W2IigQg6iT2uT8jHVbp3MQKsuWVmygcr0YYp4si0pM7Vd+tGYHrXVU/ns5sfjFVY2cwb7xqXOuj4YIyAdEEPyXeaxH36EPY/a8JR5Tu1c9LflEmweoQaKKYLGEU0qOsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FTUZXh0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F326BC2BCB4;
	Sun,  3 May 2026 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810040;
	bh=ix6UEUhECq8be0f+v9orryabp7ZrorY+VcZ3eMv8Cf0=;
	h=Subject:To:Cc:From:Date:From;
	b=FTUZXh0JI0ygkdhRRUOjM4WSETeEn3wswZPvHQ0XKGPsRmDnRqMag1yZZrb8x6UcU
	 IsBJK+XS4pPHJpUJYn8mx3iTPx8De8QBD4/g/3Kee8T8jiacu8dnsCmYw/ab8ktev/
	 S8q0uO+u8TSfECZq8W9cOiZ8XtGDSnBx9hRtYxz0=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Always use NextRIP as vmcb02's NextRIP after first" failed to apply to 5.15-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:07:03 +0200
Message-ID: <2026050303-straggler-drool-6f10@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26CBC4B5791
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
	TAGGED_FROM(0.00)[bounces-242713-lists,stable=lfdr.de];
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8d397582f6b5e9fbcf09781c7c934b4910e94a50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050303-straggler-drool-6f10@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d397582f6b5e9fbcf09781c7c934b4910e94a50 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 25 Feb 2026 00:59:47 +0000
Subject: [PATCH] KVM: nSVM: Always use NextRIP as vmcb02's NextRIP after first
 L2 VMRUN

For guests with NRIPS disabled, L1 does not provide NextRIP when running
an L2 with an injected soft interrupt, instead it advances the current RIP
before running it. KVM uses the current RIP as the NextRIP in vmcb02 to
emulate a CPU without NRIPS.

However, after L2 runs the first time, NextRIP will be updated by the CPU
and/or KVM, and the current RIP is no longer the correct value to use in
vmcb02.  Hence, after save/restore, use the current RIP if and only if a
nested run is pending, otherwise use NextRIP.  Give soft_int_next_rip the
same treatment, as it's the same logic, just for a narrower use case.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
CC: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260225005950.3739782-6-yosry@kernel.org
[sean: give soft_int_next_rip the same treatment]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 2308e40691c4..1cc083f95e6a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -845,24 +845,32 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	vmcb02->control.event_inj_err       = svm->nested.ctl.event_inj_err;
 
 	/*
-	 * next_rip is consumed on VMRUN as the return address pushed on the
+	 * NextRIP is consumed on VMRUN as the return address pushed on the
 	 * stack for injected soft exceptions/interrupts.  If nrips is exposed
-	 * to L1, take it verbatim from vmcb12.  If nrips is supported in
-	 * hardware but not exposed to L1, stuff the actual L2 RIP to emulate
-	 * what a nrips=0 CPU would do (L1 is responsible for advancing RIP
-	 * prior to injecting the event).
+	 * to L1, take it verbatim from vmcb12.
+	 *
+	 * If nrips is supported in hardware but not exposed to L1, stuff the
+	 * actual L2 RIP to emulate what a nrips=0 CPU would do (L1 is
+	 * responsible for advancing RIP prior to injecting the event). This is
+	 * only the case for the first L2 run after VMRUN. After that (e.g.
+	 * during save/restore), NextRIP is updated by the CPU and/or KVM, and
+	 * the value of the L2 RIP from vmcb12 should not be used.
 	 */
-	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
-		vmcb02->control.next_rip    = svm->nested.ctl.next_rip;
-	else if (boot_cpu_has(X86_FEATURE_NRIPS))
-		vmcb02->control.next_rip    = vmcb12_rip;
+	if (boot_cpu_has(X86_FEATURE_NRIPS)) {
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
+		    !svm->nested.nested_run_pending)
+			vmcb02->control.next_rip    = svm->nested.ctl.next_rip;
+		else
+			vmcb02->control.next_rip    = vmcb12_rip;
+	}
 
 	svm->nmi_l1_to_l2 = is_evtinj_nmi(vmcb02->control.event_inj);
 	if (is_evtinj_soft(vmcb02->control.event_inj)) {
 		svm->soft_int_injected = true;
 		svm->soft_int_csbase = vmcb12_csbase;
 		svm->soft_int_old_rip = vmcb12_rip;
-		if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
+		    !svm->nested.nested_run_pending)
 			svm->soft_int_next_rip = svm->nested.ctl.next_rip;
 		else
 			svm->soft_int_next_rip = vmcb12_rip;


