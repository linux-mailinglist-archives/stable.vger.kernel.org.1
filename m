Return-Path: <stable+bounces-225662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPy7ONxWuGmKcAEAu9opvQ
	(envelope-from <stable+bounces-225662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:15:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F017729FA2E
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED05A3052B51
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE326FD9A;
	Mon, 16 Mar 2026 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZooDV8sO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046740DFAD
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688316; cv=none; b=AFzda8Pt1HcrhzdVRiIUOE2Xon0bLwmD7wU26wVBCeoStsWTkYzIIpjFVJVrFB9bQN/tvsBHCJOi+86n8XhIJSCzyV1JvyQj9sbN2prFfleJvk6G9XRgKAq4DYWaxioY6pYUYwgrSwHFysXpIiKsC17uoiVshBJ1SanNbbMZI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688316; c=relaxed/simple;
	bh=Fm7L07TkCYK8gHAlcJm2JrehfrM6HPy1Dub8V+kFKXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPQ3b9rkzsJXfYzkk2NFItT+hVXIorfW3S+zeJMUQGKN2UYaOgKREtwzqr6h8S9ckqWQcg90EgYWsinBaxDtMygZWl5jL5YgnRMJmHSdi49Hcn+AZ8qx/zcsOTteN7c2sTB/mC1cqBriR0+edlLFPGWm2DAWxwMskB1/XQ0fBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZooDV8sO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC8CC19421;
	Mon, 16 Mar 2026 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688315;
	bh=Fm7L07TkCYK8gHAlcJm2JrehfrM6HPy1Dub8V+kFKXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZooDV8sOrVuHM52F4mvN6KMVzvAslbmVjdKVjUd3qV4q0Q2pwCREX5IdT22cjzHuG
	 rdZbhR2mfitkOZ/SzXSqYgnj5lRYBprqMhwjY3tzBeNBma15eUdmqg4U5Ojo24ELmw
	 LHtLGTa2v+PQPMzVI39omq69fRjqrvQx/L8KywIG4s+rpTDPAVt2FSp/BBBpxQKA6l
	 W2zNPwCyLW3NyAT8ULpnq+yfj2zKtVh0mlaXqKk/ir2VPWKL4bJu7Yh8aryr0dDL+6
	 daasR4ge3usr0Rekik393KLuRA30d0KNavMPo9PmAnhSSQTTUAsPFyUz2UZLFW0XKW
	 NxcYqM8Xl82Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Naveen N Rao <naveen@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] KVM: SVM: Limit AVIC physical max index based on configured max_vcpu_ids
Date: Mon, 16 Mar 2026 15:11:51 -0400
Message-ID: <20260316191153.1326996-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031632-turmoil-bankable-5ddd@gregkh>
References: <2026031632-turmoil-bankable-5ddd@gregkh>
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
	TAGGED_FROM(0.00)[bounces-225662-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: F017729FA2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naveen N Rao <naveen@kernel.org>

[ Upstream commit 574ef752d4aea04134bc121294d717f4422c2755 ]

KVM allows VMMs to specify the maximum possible APIC ID for a virtual
machine through KVM_CAP_MAX_VCPU_ID capability so as to limit data
structures related to APIC/x2APIC. Utilize the same to set the AVIC
physical max index in the VMCB, similar to VMX. This helps hardware
limit the number of entries to be scanned in the physical APIC ID table
speeding up IPI broadcasts for virtual machines with smaller number of
vCPUs.

Unlike VMX, SVM AVIC requires a single page to be allocated for the
Physical APIC ID table and the Logical APIC ID table, so retain the
existing approach of allocating those during VM init.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/adb07ccdb3394cd79cb372ba6bcc69a4e4d4ef54.1757009416.git.naveen@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 87d0f901a9bd ("KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index fef00546c8856..8b07f27765ae5 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -161,6 +161,7 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 static void avic_activate_vmcb(struct vcpu_svm *svm)
 {
 	struct vmcb *vmcb = svm->vmcb01.ptr;
+	struct kvm *kvm = svm->vcpu.kvm;
 
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
@@ -176,7 +177,8 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 	 */
 	if (x2avic_enabled && apic_x2apic_mode(svm->vcpu.arch.apic)) {
 		vmcb->control.int_ctl |= X2APIC_MODE_MASK;
-		vmcb->control.avic_physical_id |= X2AVIC_MAX_PHYSICAL_ID;
+		vmcb->control.avic_physical_id |= min(kvm->arch.max_vcpu_ids - 1,
+						      X2AVIC_MAX_PHYSICAL_ID);
 		/* Disabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, false);
 	} else {
@@ -187,7 +189,8 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
 
 		/* For xAVIC and hybrid-xAVIC modes */
-		vmcb->control.avic_physical_id |= AVIC_MAX_PHYSICAL_ID;
+		vmcb->control.avic_physical_id |= min(kvm->arch.max_vcpu_ids - 1,
+						      AVIC_MAX_PHYSICAL_ID);
 		/* Enabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, true);
 	}
-- 
2.51.0


