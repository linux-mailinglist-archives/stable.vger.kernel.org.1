Return-Path: <stable+bounces-243524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDmbCtGs+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:27:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 269EF4BF789
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08C82300AD6B
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D23DE428;
	Mon,  4 May 2026 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fmkz+HWp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE91A6827;
	Mon,  4 May 2026 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904106; cv=none; b=PYPVh94o26HjYVy2INpj86dPTaUzvtZ5uosSMezFReosS04ESbsXhiy5mXBB5fdv+QEnrx1+bItZA1HQA1P+r1gKql6zvgSP4GfWpWOtnHu1ig8aUYuIuimjsCiZ/7cK4UF3Gi/DSW8va99RX6hQcBQq5cllX+i6j20B/kMENG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904106; c=relaxed/simple;
	bh=kURQAQM84F660njlrQ7DHUem5SL08avZFZxynpwrbnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT+4i65GkFqPXZMaRV3q9JKtHitNzf8GAtVM+VJXJuoy55WJKADSN1X3PuKqurMN/JEPhz5D57lWB9r6LOylpUgHUPN6igEkbEbJEQcu64eC9cwXiECQK//fn0yMooqSeE2Zxye0SSD2//s01VVCmksYo3fhLJXm+Q64KlLADGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fmkz+HWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B88EC2BCB8;
	Mon,  4 May 2026 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904105;
	bh=kURQAQM84F660njlrQ7DHUem5SL08avZFZxynpwrbnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmkz+HWp4oYG2sLds6JyARBrrW2mxt9+IWNn+crIgatx3VHVMTTiWYO7aGN6BAVN0
	 5tR7clBSpYVIbW1fDCczrRF6Bq+tbQqspZ9DYa+Pjz4g4o8uINcEswZuhPyBhckeDs
	 EQt0Ho09VPkHllKWZCT9b8A2hzfjUsbjGettcItw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.18 185/275] KVM: nSVM: Triple fault if mapping VMCB12 fails on nested #VMEXIT
Date: Mon,  4 May 2026 15:52:05 +0200
Message-ID: <20260504135149.950083909@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 269EF4BF789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243524-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yosry Ahmed <yosry@kernel.org>

commit 1b30e7551767cb95b3e49bb169c72bbd76b56e05 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1158,12 +1158,8 @@ int nested_svm_vmexit(struct vcpu_svm *s
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



