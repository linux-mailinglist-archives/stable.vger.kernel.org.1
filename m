Return-Path: <stable+bounces-243258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAQKGkSp+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A38A14BEC86
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37E5C3019011
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221853DDDDA;
	Mon,  4 May 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EH5jkoaV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D375801;
	Mon,  4 May 2026 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903423; cv=none; b=sQ8+OWSDNMipWGjsAKKjUrXm2wwABp87oDZOvHk8HvhpBN467WwasHHBJH311xqSmJMqSDQGPmbTUkMMy8V65mPJG6DXxoGCmB49FaN+x5hnG05c5HeOX4iUNWmObMr1e7UMpwDPtPhrkBRzOHtC/gQEZPI18MEBzXjDJozY71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903423; c=relaxed/simple;
	bh=CJogiG42R+2Ov6YA7iV4dPM+/vNDa/Pe/OxgK0lRFso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pt/gXDZv5TrGCHbJGQXNI+G5H6JTQZkv1tdZ9G0U5JUo4DTqYjua/2g48osJztdz0P45Kb1bRXHFYsiSS4hg6sweV/tBvUGr5WFwIPkfFn/p8pmoBzGVk+U81167nqE2wAa0pXU6BxzVr886QPMaX0ctVEggjt9PyJysTbvYU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EH5jkoaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC14C2BCB8;
	Mon,  4 May 2026 14:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903423;
	bh=CJogiG42R+2Ov6YA7iV4dPM+/vNDa/Pe/OxgK0lRFso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EH5jkoaVdt/VYX1wSYDRtEALNYVdPsQpSymxO9agouuX+4RU6cIR7TQwjk76KRLDm
	 sJTFTN3rxDCdzSgcKNkfHEca9UswHPCCtepQCEFi6dCO+RQ6TnhZyx9Kli4U2qxODq
	 hwSs89A0dvVUJkjNlXu/2RQI206kpjGi6RYtz360=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosry@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 7.0 228/307] KVM: nSVM: Always intercept VMMCALL when L2 is active
Date: Mon,  4 May 2026 15:51:53 +0200
Message-ID: <20260504135151.435716526@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A38A14BEC86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243258-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 33d3617a52f9930d22b2af59f813c2fbdefa6dd5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/hyperv.h |    4 ----
 arch/x86/kvm/svm/nested.c |    7 -------
 2 files changed, 11 deletions(-)

--- a/arch/x86/kvm/svm/hyperv.h
+++ b/arch/x86/kvm/svm/hyperv.h
@@ -51,10 +51,6 @@ static inline bool nested_svm_is_l2_tlb_
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
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -158,13 +158,6 @@ void recalc_intercepts(struct vcpu_svm *
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
 



