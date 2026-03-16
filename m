Return-Path: <stable+bounces-225664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLnALeNWuGmKcAEAu9opvQ
	(envelope-from <stable+bounces-225664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:15:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BAE29FA3E
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C19B53054075
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536D33DEE6;
	Mon, 16 Mar 2026 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6mjn7Eq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA333C186
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688317; cv=none; b=YQqiEokQIlENBqw/ISBRIYKZ0tbdb+II1HF79NO+sF0nKIbozx2+dWpeMvUwsP9XJ7Q3YB7SZQFgSPFHzC/fGowsIU0ykOBvM+lQCBLHvTCSy1HKT1VOpFEK+9z9931X/rKrwIsKXFgKNZ4qZTLj9jvY+Qt92JabH4lcZ0fYTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688317; c=relaxed/simple;
	bh=IqVN6BfKN3crPEQLHoDVx72aStG+DgmWKsVucWUhdI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSDADMzuRLvmRxXHuTi6ts5rvrAHtFC52HX6lHeTGmGFJZVVwwaIbdwn7MJemk7VJjAXPP8KMBJ44BDkkT3He11JZFpz6h/rqoon/K/g4cvfKNydTOf9mQb0LTaIw/ATbcwGKlk6DO9+MMorCtxiLwyAqdiqt7RXpXjI5XowN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6mjn7Eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59E8C19421;
	Mon, 16 Mar 2026 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688317;
	bh=IqVN6BfKN3crPEQLHoDVx72aStG+DgmWKsVucWUhdI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6mjn7EqrU0lv6dfsJpgJ7bFwBQWpZbZOfCaxYrV2p+VVFLO4XGPR2SWDqaQ9JuoX
	 muKZIqWP7zkZoqZNUONSR7E1SD7zNXQCKdFyAxJ064TpWqhvgP13TPTio28wM3sGYX
	 iXTzWdx6cv01qlJVSY7SXiLfPNBhYtyiVDE5bwpZGwE7dhx6RElFUBGEE0Z5m4le1q
	 EXmlf76dRYvWwQhv7ZoXU33Mi41EmB97qXPwe1d0B7QLfqVKp/CPOCCzjVc8pZYyFG
	 JGBxbTibJKf7spREkN4XqP7izZ+e79Nbz6jxsWzjpjJ5Ew8lY5W5jxacf9l9ZQ/Dp2
	 kCYZD2BY/pemA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	"Naveen N Rao (AMD)" <naveen@kernel.org>,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated
Date: Mon, 16 Mar 2026 15:11:53 -0400
Message-ID: <20260316191153.1326996-3-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225664-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: C0BAE29FA3E
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
index d1a0ebda6ec6b..0208d49036ae9 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -180,12 +180,12 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
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
@@ -217,6 +217,9 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
 
+	if (!sev_es_guest(svm->vcpu.kvm))
+		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
+
 	/*
 	 * If running nested and the guest uses its own MSR bitmap, there
 	 * is no need to update L0's msr bitmap
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index eed104207a11a..4192f4c2d1b39 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1032,8 +1032,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	svm_set_intercept(svm, INTERCEPT_CR0_WRITE);
 	svm_set_intercept(svm, INTERCEPT_CR3_WRITE);
 	svm_set_intercept(svm, INTERCEPT_CR4_WRITE);
-	if (!kvm_vcpu_apicv_active(vcpu))
-		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
+	svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
 
 	set_dr_intercepts(svm);
 
@@ -2598,9 +2597,11 @@ static int dr_interception(struct kvm_vcpu *vcpu)
 
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


