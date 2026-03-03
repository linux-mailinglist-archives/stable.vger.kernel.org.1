Return-Path: <stable+bounces-222753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG1YIK0spmncLgAAu9opvQ
	(envelope-from <stable+bounces-222753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 01:34:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0B31E726A
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 01:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 750F2302632F
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 00:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9796B2D248D;
	Tue,  3 Mar 2026 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+YGuNHC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727E276041;
	Tue,  3 Mar 2026 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498074; cv=none; b=hSreQaAQNht8iP4Oq3yVjqHGjZK10tJvBi6kMQFRAc+SJBbF3lqX1G3xjeZbaTC320dVtaUGdTbCKlh7cqesWZFN22hYGJsFbnP0I051hvA4rf8HwU2rDc9KKszifSj4j7+TmhduEqhRMGsvu3Oc2xfz3VzZ7IDlXEseEPw2yaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498074; c=relaxed/simple;
	bh=Ah8N8t+zByEYmWJjcGNmQ4ocwVXaBIsh8l1+kytMLBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdFvnOqku1+jCeX0xJdwqUsBnlFZjrQLRlOfBnnNeXXBpeKdAjzG5D0XOuOwpuyMqW3GC7eH71n4Zg0U3KjOZYcQK2qUoeBWI2V0I1LmdRWb40ulAXguub14+mVfhoCXpDJBeB2VcFrYRNNkwcezW01IprwgYdzttAm3ngN9sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+YGuNHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B415AC2BCB0;
	Tue,  3 Mar 2026 00:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498074;
	bh=Ah8N8t+zByEYmWJjcGNmQ4ocwVXaBIsh8l1+kytMLBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+YGuNHCUuLk7iih8ueuDehBdHzQmeJbNgMqI48x2+kJbNbkEQ38zCU4X4mOoHL5j
	 pXEoZHpsXBQVimIwwC9izoFn9DYb3CnA64l3+6TTcZm8hg50cX7Dn5ErZI20VP+tEe
	 lLVFlq4Nwb+kKQhyLqEYRad6pv/y5MQQrI9H/rdSkB1YgZjbGKHSrGAJTLp4pHauVv
	 cxY9xhIQIOBSUSPLO/MQNHbCbcu2wupLMRysrZj/BasvAPAT3ZW1YFQ3WCgM7EmXJY
	 oQ99uJyxRghswPTrIs68FgY73O7Iqi4CArDeBkhB59yk4qksu6to0I4Y/5EQyT9atr
	 ckv5+2fXzoLrA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v7 06/26] KVM: nSVM: Refactor checking LBRV enablement in vmcb12 into a helper
Date: Tue,  3 Mar 2026 00:34:00 +0000
Message-ID: <20260303003421.2185681-7-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260303003421.2185681-1-yosry@kernel.org>
References: <20260303003421.2185681-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B0B31E726A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222753-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Refactor the vCPU cap and vmcb12 flag checks into a helper. The
unlikely() annotation is dropped, it's unlikely (huh) to make a
difference and the CPU will probably predict it better on its own.

CC: stable@vger.kernel.org
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 25f769a0d9a0d..d84af051f65bc 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -639,6 +639,12 @@ void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
 	svm->nested.vmcb02.ptr->save.g_pat = svm->vmcb01.ptr->save.g_pat;
 }
 
+static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
+{
+	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
+		(to_svm(vcpu)->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK);
+}
+
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12)
 {
 	bool new_vmcb12 = false;
@@ -703,8 +709,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 		vmcb_mark_dirty(vmcb02, VMCB_DR);
 	}
 
-	if (unlikely(guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
+	if (nested_vmcb12_has_lbrv(vcpu)) {
 		/*
 		 * Reserved bits of DEBUGCTL are ignored.  Be consistent with
 		 * svm_set_msr's definition of reserved bits.
@@ -1234,8 +1239,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	if (!nested_exit_on_intr(svm))
 		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
-	if (unlikely(guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
+	if (nested_vmcb12_has_lbrv(vcpu)) {
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 	} else {
 		svm_copy_lbrs(&vmcb01->save, &vmcb02->save);
-- 
2.53.0.473.g4a7958ca14-goog


