Return-Path: <stable+bounces-225689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFX+BdxbuGl0cgEAu9opvQ
	(envelope-from <stable+bounces-225689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:37:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8995129FD77
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12827302DF55
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEC23ED122;
	Mon, 16 Mar 2026 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka85Sj5E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDAF3E717B
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689807; cv=none; b=PFImOWMbsmuRPFKo6giA+wbj6uLkbYZEgYldXbr8XgbNZaUIJaWDZHZf2t31FCdWA1lgzNoMf29F5Hy6+wXgus9OhKFesGAqFBJw0Q4j062UzhD3pYAUYTweHY0b823n1BZDMcM9CBW+4+3hZJZjnpN2rLwX+2FSfqold2+Zygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689807; c=relaxed/simple;
	bh=01fsWkTBHJ1C5emKVMM6FIFAjrwApmMJoIX4M60wS/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP0xmt98p0ZkX+iyR7YB0ubO11qcSWzyThVWAWaAjrlutOxBx5WG0um1AJWGd4ksHntJ1gXssFtJ46Ee5OINJpcZ5fqsbmyILj0CyveBYhX9s5aUgfzssHRFYMRzyFcvfVuY80wdxZo/3snInSuBVPvloxqMhDr+KNLBMD62xyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka85Sj5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AADAC2BC9E;
	Mon, 16 Mar 2026 19:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773689807;
	bh=01fsWkTBHJ1C5emKVMM6FIFAjrwApmMJoIX4M60wS/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ka85Sj5Eh2nlv0A/WOslpHiYKV+Q73MVxig8rv0VbiFYvRqDzhcCKX4RZMNBrIPiI
	 nSp2TXQb4iBzi5LiJ7LkeixfMrHaQ81e2ZaRVhx4D9lzyiGnO+azzRZTOhgS9G7vbL
	 i7tv5njNQpVVBb1+C9ocSZejs6HSLhlB8/THrO0IA7ZXOxaAAq11VZfajxfBBdZi2m
	 kSdoIoeVy4/mpiLyNhm6e6fAPf8N29k0nAxLdbBhArxmcpfJYEeKpkd/uP7nd4Ft2I
	 TywYOysRsymb4oI9yPRxJIh2V8EpEwU9+SDKnQtSyO4xzt4Y9AtDho6BAAAkRPZPSf
	 YoYvvlacwAnHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	"Naveen N Rao (AMD)" <naveen@kernel.org>,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated
Date: Mon, 16 Mar 2026 15:36:43 -0400
Message-ID: <20260316193643.1358734-3-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225689-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,oracle.com:email]
X-Rspamd-Queue-Id: 8995129FD77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 87d0f901a9bd8ae6be57249c737f20ac0cace93d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 7 +++++--
 arch/x86/kvm/svm/svm.c  | 7 ++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ca7841bcbf1d7..b685bc4507e20 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -104,12 +104,12 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
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
@@ -141,6 +141,9 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
 
+	if (!sev_es_guest(svm->vcpu.kvm))
+		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
+
 	/*
 	 * If running nested and the guest uses its own MSR bitmap, there
 	 * is no need to update L0's msr bitmap
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9ddd1ee5f3123..74fac4a50e1ca 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1261,8 +1261,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	svm_set_intercept(svm, INTERCEPT_CR0_WRITE);
 	svm_set_intercept(svm, INTERCEPT_CR3_WRITE);
 	svm_set_intercept(svm, INTERCEPT_CR4_WRITE);
-	if (!kvm_vcpu_apicv_active(vcpu))
-		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
+	svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
 
 	set_dr_intercepts(svm);
 
@@ -2806,9 +2805,11 @@ static int dr_interception(struct kvm_vcpu *vcpu)
 
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
-- 
2.51.0


