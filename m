Return-Path: <stable+bounces-242764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NbHFIk992k2dwIAu9opvQ
	(envelope-from <stable+bounces-242764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:20:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC44B5A92
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 356403006965
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E58359A9F;
	Sun,  3 May 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AWNy5thj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F916A956
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810822; cv=none; b=kFYPkNWfuvR7G1/f/94mREri2pGu75T3sCLCJqyoBFFvKnkJIJjl86h6AwfL+Mzoh8T6s7VzpV8RJrFn8NaZR0AY/+EwCLiV1QB9C4GgXl1oqhJyQtozYIxazkDCL7kLPfM4Br3Wj2zrWF/mOWSBg5eXlHlR06lklja2yqn14Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810822; c=relaxed/simple;
	bh=FKUzfnuX5kRsPii9M1oyIKTcKhGngeY2AZdYDZ8OhzU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W13xcOqQ9CyyP/OKFwInBoCFcoSqNRK77+c+QKQhmZwehhdZ4T0v9lxUqfoQuRh4nv5x3P/MUL6WO7hru9VxEWB7q47sAd7qjN/F1X/0/miplddVY3msXEJftPxSSuz0m0/hQDWktoLKB3t9HSxVeLEVJDbbqpaFzALbmm/gT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AWNy5thj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3720C2BCB4;
	Sun,  3 May 2026 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810822;
	bh=FKUzfnuX5kRsPii9M1oyIKTcKhGngeY2AZdYDZ8OhzU=;
	h=Subject:To:Cc:From:Date:From;
	b=AWNy5thjW71wzfJ3Ke79gLhqTfuEvifhBDKymZE20OCiBqMZnIjYju2NiJt9UklGu
	 WQESMWUcygBlSFHXurC88YqGhZyn9+lyuU0lepHwLl5hZ2ea0OUz9KxtCvttWWE6hK
	 mil9Zi6VCtEAQQhn767rGWrZi1Q+IFSP12IbrTZk=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Always intercept VMMCALL when L2 is active" failed to apply to 6.6-stable tree
To: seanjc@google.com,vkuznets@redhat.com,yosry@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:20:19 +0200
Message-ID: <2026050319-frequency-badge-f9fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A3AC44B5A92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242764-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 33d3617a52f9930d22b2af59f813c2fbdefa6dd5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050319-frequency-badge-f9fe@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33d3617a52f9930d22b2af59f813c2fbdefa6dd5 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 3 Mar 2026 16:22:23 -0800
Subject: [PATCH] KVM: nSVM: Always intercept VMMCALL when L2 is active

Always intercept VMMCALL now that KVM properly synthesizes a #UD as
appropriate, i.e. when L1 doesn't want to intercept VMMCALL, to avoid
putting L2 into an infinite #UD loop if KVM_X86_QUIRK_FIX_HYPERCALL_INSN
is enabled.

By letting L2 execute VMMCALL natively and thus #UD, for all intents and
purposes KVM morphs the VMMCALL intercept into a #UD intercept (KVM always
intercepts #UD).  When the hypercall quirk is enabled, KVM "emulates"
VMMCALL in response to the #UD by trying to fixup the opcode to the "right"
vendor, then restarts the guest, without skipping the VMMCALL.  As a
result, the guest sees an endless stream of #UDs since it's already
executing the correct vendor hypercall instruction, i.e. the emulator
doesn't anticipate that the #UD could be due to lack of interception, as
opposed to a truly undefined opcode.

Fixes: 0d945bd93511 ("KVM: SVM: Don't allow nested guest to VMMCALL into host")
Cc: stable@vger.kernel.org
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://patch.msgid.link/20260304002223.1105129-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
index 9af03970d40c..f70d076911a6 100644
--- a/arch/x86/kvm/svm/hyperv.h
+++ b/arch/x86/kvm/svm/hyperv.h
@@ -51,10 +51,6 @@ static inline bool nested_svm_is_l2_tlb_flush_hcall(struct kvm_vcpu *vcpu)
 void svm_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu);
 #else /* CONFIG_KVM_HYPERV */
 static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu) {}
-static inline bool nested_svm_l2_tlb_flush_enabled(struct kvm_vcpu *vcpu)
-{
-	return false;
-}
 static inline bool nested_svm_is_l2_tlb_flush_hcall(struct kvm_vcpu *vcpu)
 {
 	return false;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 0f7893a7cb04..fb86f09985e7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -158,13 +158,6 @@ void recalc_intercepts(struct vcpu_svm *svm)
 			vmcb_clr_intercept(c, INTERCEPT_VINTR);
 	}
 
-	/*
-	 * We want to see VMMCALLs from a nested guest only when Hyper-V L2 TLB
-	 * flush feature is enabled.
-	 */
-	if (!nested_svm_l2_tlb_flush_enabled(&svm->vcpu))
-		vmcb_clr_intercept(c, INTERCEPT_VMMCALL);
-
 	for (i = 0; i < MAX_INTERCEPT; i++)
 		c->intercepts[i] |= g->intercepts[i];
 


