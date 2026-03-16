Return-Path: <stable+bounces-225588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NjEGU0juGk8ZgEAu9opvQ
	(envelope-from <stable+bounces-225588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:35:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F6429C7CD
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BFF830AEF38
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104839FCB6;
	Mon, 16 Mar 2026 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T3YCoIwT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E639FCC3
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674757; cv=none; b=o5zlPyF19V2Qol9mP1fj9w8OnoxhzxZMpNAzS2+tlaC6KoMTebt3cQhN+pW5ptxd7HYxQbFohGHXh9PAHYPc/PLb9QnHGUOtSIi2odW5FjGafocgwaXrE0shzivc6qhp9oZaxQEN/QbGLGD9y7G04CNm91DwbxoA8EyJvh41IWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674757; c=relaxed/simple;
	bh=+MGoEJNJ/sxXDfY0Lziq9FHaP2DEV2mveQjGveuDaBM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hn/LAFLaQIDjUbynJO7cRDH5/inWLEnLT5PCncT3Z4T+/ajU0G79ozslJBzq3aW2yqcxnN6JsbV+wqWgFENAzB7gA12dETD3SLP+Z/e7WirStNP4yqhvTXqNGL19n08+gXat4p6vEdJaZmg/jm8zik1+v5WUoUNoMeaZ1FKlIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T3YCoIwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0983CC2BCB2;
	Mon, 16 Mar 2026 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773674756;
	bh=+MGoEJNJ/sxXDfY0Lziq9FHaP2DEV2mveQjGveuDaBM=;
	h=Subject:To:Cc:From:Date:From;
	b=T3YCoIwTFp4+GdldCtEZVEJtU+fqapCGtVE/RqdYNVFoyy883kkrjt894Nz166mfU
	 Yp9NiI30WqA4aliZ6xmCMrcIKrIS1E7cccTxjkTrLwk9FmCzKW4ubzcM7eoCX719tM
	 45RDZSfOM8jnSDgfFXmEbO97hMA4OKS/t67cf2Sg=
Subject: FAILED: patch "[PATCH] KVM: SVM: Set/clear CR8 write interception when AVIC is" failed to apply to 5.15-stable tree
To: seanjc@google.com,jmattson@google.com,maciej.szmigiero@oracle.com,naveen@kernel.org,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Mar 2026 16:25:35 +0100
Message-ID: <2026031635-duty-handyman-108a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225588-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,oracle.com:email]
X-Rspamd-Queue-Id: C7F6429C7CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 87d0f901a9bd8ae6be57249c737f20ac0cace93d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031635-duty-handyman-108a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87d0f901a9bd8ae6be57249c737f20ac0cace93d Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 3 Feb 2026 11:07:10 -0800
Subject: [PATCH] KVM: SVM: Set/clear CR8 write interception when AVIC is
 (de)activated

Explicitly set/clear CR8 write interception when AVIC is (de)activated to
fix a bug where KVM leaves the interception enabled after AVIC is
activated.  E.g. if KVM emulates INIT=>WFS while AVIC is deactivated, CR8
will remain intercepted in perpetuity.

On its own, the dangling CR8 intercept is "just" a performance issue, but
combined with the TPR sync bug fixed by commit d02e48830e3f ("KVM: SVM:
Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active"), the danging
intercept is fatal to Windows guests as the TPR seen by hardware gets
wildly out of sync with reality.

Note, VMX isn't affected by the bug as TPR_THRESHOLD is explicitly ignored
when Virtual Interrupt Delivery is enabled, i.e. when APICv is active in
KVM's world.  I.e. there's no need to trigger update_cr8_intercept(), this
is firmly an SVM implementation flaw/detail.

WARN if KVM gets a CR8 write #VMEXIT while AVIC is active, as KVM should
never enter the guest with AVIC enabled and CR8 writes intercepted.

Fixes: 3bbf3565f48c ("svm: Do not intercept CR8 when enable AVIC")
Cc: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260203190711.458413-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[Squash fix to avic_deactivate_vmcb. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 44e07c27b190..f7ec7914e3c4 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -189,12 +189,12 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
-
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
 	vmcb->control.avic_physical_id |= avic_get_max_physical_id(vcpu);
-
 	vmcb->control.int_ctl |= AVIC_ENABLE_MASK;
 
+	svm_clr_intercept(svm, INTERCEPT_CR8_WRITE);
+
 	/*
 	 * Note: KVM supports hybrid-AVIC mode, where KVM emulates x2APIC MSR
 	 * accesses, while interrupt injection to a running vCPU can be
@@ -226,6 +226,9 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
 
+	if (!sev_es_guest(svm->vcpu.kvm))
+		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
+
 	/*
 	 * If running nested and the guest uses its own MSR bitmap, there
 	 * is no need to update L0's msr bitmap
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7806321c37bc..2772f22df7ed 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1077,8 +1077,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	svm_set_intercept(svm, INTERCEPT_CR0_WRITE);
 	svm_set_intercept(svm, INTERCEPT_CR3_WRITE);
 	svm_set_intercept(svm, INTERCEPT_CR4_WRITE);
-	if (!kvm_vcpu_apicv_active(vcpu))
-		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
+	svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
 
 	set_dr_intercepts(svm);
 
@@ -2674,9 +2673,11 @@ static int dr_interception(struct kvm_vcpu *vcpu)
 
 static int cr8_write_interception(struct kvm_vcpu *vcpu)
 {
+	u8 cr8_prev = kvm_get_cr8(vcpu);
 	int r;
 
-	u8 cr8_prev = kvm_get_cr8(vcpu);
+	WARN_ON_ONCE(kvm_vcpu_apicv_active(vcpu));
+
 	/* instruction emulation calls kvm_set_cr8() */
 	r = cr_interception(vcpu);
 	if (lapic_in_kernel(vcpu))


