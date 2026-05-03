Return-Path: <stable+bounces-242761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBVMLUQ992k2dwIAu9opvQ
	(envelope-from <stable+bounces-242761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:19:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2719F4B5A7C
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C2253002E40
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E7C359A9F;
	Sun,  3 May 2026 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ox5Q9NN8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B426CE11
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810754; cv=none; b=VHM3WUC7jlXP+JxLbUhWlnCPv3+xcLMC7hzGA76WE7uv1FsCUNUHtAMPUmVaILpmtuwtL/f614dJ+nvtEbvvznoxNj8kSjkRHyJwTKzO+tOeaBO43TeqrNnQqbbl4J9iYgvr7KsMyygQ1AaSSudnztFvmOwJShCN3DSfRjOTwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810754; c=relaxed/simple;
	bh=/5ZRFVpn9SiVCQwuSb7Xg8xRKwZ5faTuMHdTGgUWPAE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AKq7NulEFW04f2D0rBNaVTUHF4KEBaKu7X5tUAicunu4KQ3jUQ2Lh5/8onqMmr7yZvya8Ikc5QJO4t21GXwOuCVFN9FM0KmL9gf2IhtCkdsJnVkfgWmBJ23Hd9aNNM2z8moyR2xrEfeBlex2y3qtRExnMWzbpePuyx7E4GcYq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ox5Q9NN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9586AC2BCB4;
	Sun,  3 May 2026 12:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810753;
	bh=/5ZRFVpn9SiVCQwuSb7Xg8xRKwZ5faTuMHdTGgUWPAE=;
	h=Subject:To:Cc:From:Date:From;
	b=ox5Q9NN8YBx4YtF6PWS8zp7R+sqS9milx1WADZIQJC+KvdbUZak2h/uV/Rz3wVkg1
	 kOGuvKwbvbAcxSHsr4iB1jtVQub7YG++M+j8BVfjTK+geFeF0Vq+KQVJ+a7EZOL18y
	 RCNrs4i6324KXnou+EGKNtt1K9BcmiHCefbXgnjA=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Drop the non-architectural consistency check for" failed to apply to 5.10-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:19:03 +0200
Message-ID: <2026050303-flask-cultivate-235d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2719F4B5A7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242761-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,msgid.link:url,linuxfoundation.org:dkim]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e0b6f031d64c086edd563e7af9c0c0a2261dd2a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050303-flask-cultivate-235d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0b6f031d64c086edd563e7af9c0c0a2261dd2a4 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 00:34:08 +0000
Subject: [PATCH] KVM: nSVM: Drop the non-architectural consistency check for
 NP_ENABLE

KVM currenty fails a nested VMRUN and injects VMEXIT_INVALID (aka
SVM_EXIT_ERR) if L1 sets NP_ENABLE and the host does not support NPTs.
On first glance, it seems like the check should actually be for
guest_cpu_cap_has(X86_FEATURE_NPT) instead, as it is possible for the
host to support NPTs but the guest CPUID to not advertise it.

However, the consistency check is not architectural to begin with. The
APM does not mention VMEXIT_INVALID if NP_ENABLE is set on a processor
that does not have X86_FEATURE_NPT. Hence, NP_ENABLE should be ignored
if X86_FEATURE_NPT is not available for L1, so sanitize it when copying
from the VMCB12 to KVM's cache.

Apart from the consistency check, NP_ENABLE in VMCB12 is currently
ignored because the bit is actually copied from VMCB01 to VMCB02, not
from VMCB12.

Fixes: 4b16184c1cca ("KVM: SVM: Initialize Nested Nested MMU context on VMRUN")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-15-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 0d447d044101..2ed6530e7bd1 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -348,9 +348,6 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 	if (CC(control->asid == 0))
 		return false;
 
-	if (CC((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) && !npt_enabled))
-		return false;
-
 	if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
 					   MSRPM_SIZE)))
 		return false;
@@ -431,6 +428,11 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	nested_svm_sanitize_intercept(vcpu, to, SKINIT);
 	nested_svm_sanitize_intercept(vcpu, to, RDPRU);
 
+	/* Always clear SVM_NESTED_CTL_NP_ENABLE if the guest cannot use NPTs */
+	to->nested_ctl          = from->nested_ctl;
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
+		to->nested_ctl &= ~SVM_NESTED_CTL_NP_ENABLE;
+
 	to->iopm_base_pa        = from->iopm_base_pa;
 	to->msrpm_base_pa       = from->msrpm_base_pa;
 	to->tsc_offset          = from->tsc_offset;
@@ -444,7 +446,6 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->exit_info_2         = from->exit_info_2;
 	to->exit_int_info       = from->exit_int_info;
 	to->exit_int_info_err   = from->exit_int_info_err;
-	to->nested_ctl          = from->nested_ctl;
 	to->event_inj           = from->event_inj;
 	to->event_inj_err       = from->event_inj_err;
 	to->next_rip            = from->next_rip;


