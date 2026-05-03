Return-Path: <stable+bounces-242753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO79Aus892k2dwIAu9opvQ
	(envelope-from <stable+bounces-242753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:17:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FEB4B5A31
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 586D83001A44
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716752C08BC;
	Sun,  3 May 2026 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p7RzcP9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651916A956
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810661; cv=none; b=L/RZYSpoQ9b4ClrCHVBmkd/qrykEppeOCO4vLX85KrHgGZAP/sLJk8wx0EK1MN19J/jQKM2nMN2hVcWuME2VxR20m9njgXswFPTdqKkXZ2Lb+sQaNdNZpuSoyAXRHdZe2GpgDpocDGf1cvX/ODrDVVF7/4PIJo8gN+OaA9bjyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810661; c=relaxed/simple;
	bh=A0AiE+Ym0nTWa64kIjlqgWI66MQmAztl5XRCfWc1cDE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jldkCBcYbYhXzprhRe8vu/PwYXIGe8N+VGXGs+dDWFE2f9gCdS2nhrGaagQuYZ2mBOwJ5oCi8nq/Y0M4z1ID59MRHGw7fetjFPZrpU/VCBqYNSlO6fxSDJfEfwFtUL25o5Z1nx2VIUd+arAhj5SbiRo9Ke6i0DxRkwHvyCSZpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p7RzcP9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0412C2BCB4;
	Sun,  3 May 2026 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810661;
	bh=A0AiE+Ym0nTWa64kIjlqgWI66MQmAztl5XRCfWc1cDE=;
	h=Subject:To:Cc:From:Date:From;
	b=p7RzcP9rNhYirgPr5k2ekIjkOwcsB/RyRd1CgDQfLR9Wsv2vqhdgSt7rcF7Zwan7g
	 5f1/XgbrDZj1cmiNN0ghnQImYSrzRAmM9OR1OIqANRXdCgDuFTQkSr7zZBx9jOPIn8
	 t3ZXE6rGdJs1rvgFr0ISAnfRnon6buJvFI9h0Hco=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Triple fault if mapping VMCB12 fails on nested" failed to apply to 5.15-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:17:30 +0200
Message-ID: <2026050330-superhero-flagman-31b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38FEB4B5A31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242753-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1b30e7551767cb95b3e49bb169c72bbd76b56e05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050330-superhero-flagman-31b6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b30e7551767cb95b3e49bb169c72bbd76b56e05 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 00:34:02 +0000
Subject: [PATCH] KVM: nSVM: Triple fault if mapping VMCB12 fails on nested
 #VMEXIT

KVM currently injects a #GP and hopes for the best if mapping VMCB12
fails on nested #VMEXIT, and only if the failure mode is -EINVAL.
Mapping the VMCB12 could also fail if creating host mappings fails.

After the #GP is injected, nested_svm_vmexit() bails early, without
cleaning up (e.g. KVM_REQ_GET_NESTED_STATE_PAGES is set, is_guest_mode()
is true, etc).

Instead of optionally injecting a #GP, triple fault the guest if mapping
VMCB12 fails since KVM cannot make a sane recovery. The APM states that
a #VMEXIT will triple fault if host state is illegal or an exception
occurs while loading host state, so the behavior is not entirely made
up.

Do not return early from nested_svm_vmexit(), continue cleaning up the
vCPU state (e.g. switch back to vmcb01), to handle the failure as
gracefully as possible.

Fixes: cf74a78b229d ("KVM: SVM: Add VMEXIT handler and intercepts")
CC: stable@vger.kernel.org
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-9-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 8c01916cb154..30c99bbe9927 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1199,12 +1199,8 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
 	int rc;
 
-	rc = nested_svm_vmexit_update_vmcb12(vcpu);
-	if (rc) {
-		if (rc == -EINVAL)
-			kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
+	if (nested_svm_vmexit_update_vmcb12(vcpu))
+		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);


