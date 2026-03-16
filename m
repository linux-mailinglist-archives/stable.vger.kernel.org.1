Return-Path: <stable+bounces-225688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIUFONZbuGl0cgEAu9opvQ
	(envelope-from <stable+bounces-225688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:36:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934F29FD70
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1AE3301C5AE
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964953ED119;
	Mon, 16 Mar 2026 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4fMRLkV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD634F486
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689806; cv=none; b=JotgdL0KFVwXgUnwjZOogCCSOUqhvClmORJiVQOKDZ84TPqkhklb5kL6hgepy1j+OSJ9Z4N92H3HLp5WG7i3kAHonJ2F74TzfQhsOGhXpdCe/zIWmV5KJr0dTP8l3hbejipLIPmZdAII52RWcwDafeEJSLO6a8OjU6hJ++bO4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689806; c=relaxed/simple;
	bh=BSmefynQXWYkMw+YaS10986lIS6mmqmNKPRBBYebC8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giVL0woJAQpQNhxEtScAyu0UbsVlEFS1tUqRQ32vW8Av4G5FkkQFIkr1lGgiUz8jeBkYJRG+rzaJ0ClxGVwGH85gezAcaFe/JpWFMQYkjUoFCaYm/Fw/qwnkFpN8ViQcpiS0CO+P+dNM///oHnELHfy8xCNkUntvUPEahB0haQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4fMRLkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C06C2BCAF;
	Mon, 16 Mar 2026 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773689806;
	bh=BSmefynQXWYkMw+YaS10986lIS6mmqmNKPRBBYebC8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4fMRLkVXt6PZMBGw0TgSt1H6pE6xThcyGJcNf3a+e7rywgGFlIdAmwc+q4yKUBxG
	 PBYgn7Vz2ykDx2WAslfLCcckmnkp+yhhJHIN8dlYqYjipaKvzSbbdit6mwQaF6whk9
	 w1IA819QkqB7ViCpvcwDUuOS+4srl1LG5111ztfnqrUDEV1Pk901xQSCn7xmmQbSHX
	 jtUVOQENmB4RREKQnYZV0z9v958rUmRH80jHPONL+bmNKMd22qV8ZiZNwQ9dr13hXD
	 bKT4ffej8tm918llF0N9yicYHGtAkFKIhs9pDrXWnJjsySqIFUy0hu3TTAM2OI8bUG
	 u4fEfe5B06QbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naveen N Rao <naveen@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] KVM: SVM: Add a helper to look up the max physical ID for AVIC
Date: Mon, 16 Mar 2026 15:36:42 -0400
Message-ID: <20260316193643.1358734-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316193643.1358734-1-sashal@kernel.org>
References: <2026031633-ranting-ditto-0e1b@gregkh>
 <20260316193643.1358734-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-225688-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 3934F29FD70
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
index adbd7b3d2e446..ca7841bcbf1d7 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -82,13 +82,31 @@ struct amd_svm_iommu_ir {
 	void *data;		/* Storing pointer to struct amd_ir_data */
 };
 
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
 
@@ -101,8 +119,7 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 	 */
 	if (x2avic_enabled && apic_x2apic_mode(svm->vcpu.arch.apic)) {
 		vmcb->control.int_ctl |= X2APIC_MODE_MASK;
-		vmcb->control.avic_physical_id |= min(kvm->arch.max_vcpu_ids - 1,
-						      X2AVIC_MAX_PHYSICAL_ID);
+
 		/* Disabling MSR intercept for x2APIC registers */
 		svm_set_x2apic_msr_interception(svm, false);
 	} else {
@@ -112,9 +129,6 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 		 */
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
 
-		/* For xAVIC and hybrid-xAVIC modes */
-		vmcb->control.avic_physical_id |= min(kvm->arch.max_vcpu_ids - 1,
-						      AVIC_MAX_PHYSICAL_ID);
 		/* Enabling MSR intercept for x2APIC registers */
 		svm_set_x2apic_msr_interception(svm, true);
 	}
-- 
2.51.0


