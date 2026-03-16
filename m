Return-Path: <stable+bounces-225697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK0AH5xluGlOdQEAu9opvQ
	(envelope-from <stable+bounces-225697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:18:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CED2A020E
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21E5E307E865
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B16355F2C;
	Mon, 16 Mar 2026 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSFDdZIp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AEF2C0F78
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692284; cv=none; b=BFyU7dusihD43dfgGcQF5Gdfr3wHovHbn74TknkdKf3mqSrczGqAewbhyCtUScqNjfqLyZAjlwjUykyXrC9qZYYgAf0rQ+tuD2LHN7j5wzGWuRYyXi13cNctJBdTiIxrBu2p5bEPf2imXV+hgF+rFtHhRa80k38MamRB0tu4w9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692284; c=relaxed/simple;
	bh=Xgw0bWhldJJQL74Ufbt8AJWFi3/wKvBtlFJbfcTRsmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjbBKHeTef876y8rAbcpR6q4KDTQACzkJ8K02twTPb1LQS9GgHRVHwED4/7RApi7WceEhwFbJQ/51TTj1VSSsIsoox21u0462LXFmS5G6XblDBMDZY3BN69zdILukuf0aMw5wv0dWalj7NeFUKE91rKhrkTpE8iBiX9dpJMwXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSFDdZIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C673C19421;
	Mon, 16 Mar 2026 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692283;
	bh=Xgw0bWhldJJQL74Ufbt8AJWFi3/wKvBtlFJbfcTRsmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DSFDdZIpbcDIGQhdZK61jmNFx8QE3wTFyim+/DKMyHM2eKmD5MOoLHWbEI5/WSPud
	 K+4JhG07wECdUnlTbQnwKneB5D35JW5rr932b0B8BhEWaJccR2Eh17yVCk++c0ggK/
	 RdnkRm+SWDzyxiEX26lusqcbZJgJcjMYREfYdtEhHlXxohsZW6v9exlFp2d5hcn2+4
	 XJNQ6muWgmVOhYM2Ak5cxBYPczSvxjrEX1S7Ki/dkkgeBhenjwzXynRclmVY9u9lj1
	 tQGtHk+iSMqbPC/ZGR5R1gUqXbqHf9GSTKOT78Gz/mJF/RdvXfkuYjmfHnjXOt4TAl
	 96LbB3J8T0IXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	"Naveen N Rao (AMD)" <naveen@kernel.org>,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated
Date: Mon, 16 Mar 2026 16:18:01 -0400
Message-ID: <20260316201801.1376275-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031634-departed-sandlot-6482@gregkh>
References: <2026031634-departed-sandlot-6482@gregkh>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225697-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D2CED2A020E
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
[ adjusted context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 6 +++++-
 arch/x86/kvm/svm/svm.c  | 7 ++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 0adbf0677b7c4..e6abfec5e7b29 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -79,9 +79,10 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
-
 	vmcb->control.int_ctl |= AVIC_ENABLE_MASK;
 
+	svm_clr_intercept(svm, INTERCEPT_CR8_WRITE);
+
 	/* Note:
 	 * KVM can support hybrid-AVIC mode, where KVM emulates x2APIC
 	 * MSR accesses, while interrupt injection to a running vCPU
@@ -116,6 +117,9 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
 
+	if (!sev_es_guest(svm->vcpu.kvm))
+		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
+
 	/*
 	 * If running nested and the guest uses its own MSR bitmap, there
 	 * is no need to update L0's msr bitmap
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a885fb39a6559..6e3c27cc7b7fc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1192,8 +1192,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	svm_set_intercept(svm, INTERCEPT_CR0_WRITE);
 	svm_set_intercept(svm, INTERCEPT_CR3_WRITE);
 	svm_set_intercept(svm, INTERCEPT_CR4_WRITE);
-	if (!kvm_vcpu_apicv_active(vcpu))
-		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
+	svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
 
 	set_dr_intercepts(svm);
 
@@ -2690,9 +2689,11 @@ static int dr_interception(struct kvm_vcpu *vcpu)
 
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


