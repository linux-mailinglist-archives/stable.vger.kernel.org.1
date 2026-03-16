Return-Path: <stable+bounces-225663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDucBeFWuGmKcAEAu9opvQ
	(envelope-from <stable+bounces-225663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:15:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C2029FA37
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF14E3053F08
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FDC33A708;
	Mon, 16 Mar 2026 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5dTvJ6z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65040DFAD
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688316; cv=none; b=jwAPrjtoBATRpydysHy8SZMYBXXev+9GNbpCALd/jjp7pEskLdv8JA090cOeppBZfK2R/LtOCPFOe7AyjNqDCPGrwSSDcKlmz71iY0prsMvGxUAGlmi8rJTcIKXh58GUgHE61S/Ky7RHCtGunysDt/9uZk6A8qncr9QRuN1L1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688316; c=relaxed/simple;
	bh=5neud26m3EYAklrQM2dzYhyN78irkVZkGIDdArAUy1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUPpPrgVXduGQfX36LSLh8xdzb0ZZhC/IgWyUcQ3+MVby1RWWIiZ3LmPfRTXjgrUj1zArs7CDJ/CV8XJ/FAsNwqdorj7TrNmxYBL9NdQx1pOrdhbwbeNq9kRGhlsIabllNnpNOtKRdRVjJRjuRfULXtGGKK9uC5d3IE3Zpz3XYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5dTvJ6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2A5C2BCB0;
	Mon, 16 Mar 2026 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688316;
	bh=5neud26m3EYAklrQM2dzYhyN78irkVZkGIDdArAUy1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5dTvJ6zIx42CUCqKcR/e7MpmhTow4bHyqQZChtd/TAT2Mm4psCWICOv+bj0Q4t5R
	 M83bLGoVop/XNsM8VJ2t9QXvbqUjs4lAdvekDLI1ijnXzBEmiUq+OnOwoYAzhFG8tH
	 G7N2A1NDyBWVEUWBKM1IjxZGPItp2VozO8P8CyugSVheI0Qd1U/8GTKhvQT+3zqXwy
	 EnH3G1CDpc6rw8glaa5k2Ml0qj5EKAGRdxw0bjpkIuCibMOlf59hs3oIYqxzYkUJLG
	 ku62HhY9ELxR6FHQFihel5iiC5F9wyxkB6AgEDcGxoJGu+Gcvr64xL05+txxD0Tt7e
	 FTraQoBKxLnYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naveen N Rao <naveen@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] KVM: SVM: Add a helper to look up the max physical ID for AVIC
Date: Mon, 16 Mar 2026 15:11:52 -0400
Message-ID: <20260316191153.1326996-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316191153.1326996-1-sashal@kernel.org>
References: <2026031632-turmoil-bankable-5ddd@gregkh>
 <20260316191153.1326996-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225663-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59C2029FA37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naveen N Rao <naveen@kernel.org>

[ Upstream commit f2f6e67a56dc88fea7e9b10c4e79bb01d97386b7 ]

To help with a future change, add a helper to look up the maximum
physical ID depending on the vCPU AVIC mode. No functional change
intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/0ab9bf5e20a3463a4aa3a5ea9bbbac66beedf1d1.1757009416.git.naveen@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 87d0f901a9bd ("KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 8b07f27765ae5..d1a0ebda6ec6b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -158,13 +158,31 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 	svm->x2avic_msrs_intercepted = intercept;
 }
 
+static u32 avic_get_max_physical_id(struct kvm_vcpu *vcpu)
+{
+	u32 arch_max;
+
+	if (x2avic_enabled && apic_x2apic_mode(vcpu->arch.apic))
+		arch_max = X2AVIC_MAX_PHYSICAL_ID;
+	else
+		arch_max = AVIC_MAX_PHYSICAL_ID;
+
+	/*
+	 * Despite its name, KVM_CAP_MAX_VCPU_ID represents the maximum APIC ID
+	 * plus one, so the max possible APIC ID is one less than that.
+	 */
+	return min(vcpu->kvm->arch.max_vcpu_ids - 1, arch_max);
+}
+
 static void avic_activate_vmcb(struct vcpu_svm *svm)
 {
 	struct vmcb *vmcb = svm->vmcb01.ptr;
-	struct kvm *kvm = svm->vcpu.kvm;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
+
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
+	vmcb->control.avic_physical_id |= avic_get_max_physical_id(vcpu);
 
 	vmcb->control.int_ctl |= AVIC_ENABLE_MASK;
 
@@ -177,8 +195,7 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 	 */
 	if (x2avic_enabled && apic_x2apic_mode(svm->vcpu.arch.apic)) {
 		vmcb->control.int_ctl |= X2APIC_MODE_MASK;
-		vmcb->control.avic_physical_id |= min(kvm->arch.max_vcpu_ids - 1,
-						      X2AVIC_MAX_PHYSICAL_ID);
+
 		/* Disabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, false);
 	} else {
@@ -188,9 +205,6 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 		 */
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
 
-		/* For xAVIC and hybrid-xAVIC modes */
-		vmcb->control.avic_physical_id |= min(kvm->arch.max_vcpu_ids - 1,
-						      AVIC_MAX_PHYSICAL_ID);
 		/* Enabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, true);
 	}
-- 
2.51.0


