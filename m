Return-Path: <stable+bounces-226875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHRNIOyPuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:31:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD952AFBDC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C48E305F876
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DB3346797;
	Tue, 17 Mar 2026 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZK7fvm6Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90A3368AE;
	Tue, 17 Mar 2026 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768566; cv=none; b=i4gNen1kLSUf+O4f38e2ju6ION9fyQK6+dcgqPhWsB5NTdpSATmN4kBf3YEG0yqL63rSvkHPkIG4BU+S6UeA5Ljyi2Wg4QNn6nyqOLKNzfiiy8rVuX/hwLwbC3Zh3Yq/7xWiUES5lYlSNTX0bj/rrGWMGm5jaTDpf758L5mQbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768566; c=relaxed/simple;
	bh=YG+K6mnP/NJjJcGCe2EvWyosqsj9m6KhmhA3lycg9GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmcP3KaOPs3A+DSbGKNgsthLfb2eV1N8o21m6YH9v9Gi1Lyi2d62AJstu2i3oxuHCkLJbXLTuZixx+Lf1GsRdk4xyWYCEL6ut+25cyFwaviUOPCTT+DL4HzEGWXpC3wamc5RmGQlyQjVgxA0vWE7fe24xL3DLKaYPI6a/j7yFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZK7fvm6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB39C4CEF7;
	Tue, 17 Mar 2026 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768565;
	bh=YG+K6mnP/NJjJcGCe2EvWyosqsj9m6KhmhA3lycg9GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZK7fvm6ZWBxQ2RPA3mjQNLpl9+4nYZgeDrWjaDgvRSaqlwfJGVm5PDYHeXzuPVhQE
	 CqFncIY2nlEu1v2UeVKg+shozLZT0ISynWA9sCYfvrsWrxitj3HhtbNppKbJydYUNi
	 UTiZ9wof9IUFWbKIHwjAFTBqUuLmfAeEbP9Mjl7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Naveen N Rao (AMD)" <naveen@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 323/333] KVM: SVM: Limit AVIC physical max index based on configured max_vcpu_ids
Date: Tue, 17 Mar 2026 17:35:52 +0100
Message-ID: <20260317163011.378665840@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226875-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1CD952AFBDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/avic.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -161,6 +161,7 @@ static void avic_set_x2apic_msr_intercep
 static void avic_activate_vmcb(struct vcpu_svm *svm)
 {
 	struct vmcb *vmcb = svm->vmcb01.ptr;
+	struct kvm *kvm = svm->vcpu.kvm;
 
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
@@ -176,7 +177,8 @@ static void avic_activate_vmcb(struct vc
 	 */
 	if (x2avic_enabled && apic_x2apic_mode(svm->vcpu.arch.apic)) {
 		vmcb->control.int_ctl |= X2APIC_MODE_MASK;
-		vmcb->control.avic_physical_id |= X2AVIC_MAX_PHYSICAL_ID;
+		vmcb->control.avic_physical_id |= min(kvm->arch.max_vcpu_ids - 1,
+						      X2AVIC_MAX_PHYSICAL_ID);
 		/* Disabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, false);
 	} else {
@@ -187,7 +189,8 @@ static void avic_activate_vmcb(struct vc
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
 
 		/* For xAVIC and hybrid-xAVIC modes */
-		vmcb->control.avic_physical_id |= AVIC_MAX_PHYSICAL_ID;
+		vmcb->control.avic_physical_id |= min(kvm->arch.max_vcpu_ids - 1,
+						      AVIC_MAX_PHYSICAL_ID);
 		/* Enabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, true);
 	}



