Return-Path: <stable+bounces-225635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ir7EpY8uGmpagEAu9opvQ
	(envelope-from <stable+bounces-225635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:23:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D38029E150
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD371304A0C7
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0F83D1CDB;
	Mon, 16 Mar 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSNumrm0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47223D1CAE
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681609; cv=none; b=Xvp8gn4q+1ghdQM2HACF5JXXJ8xImOBgGlM/esZwBFqNsJWg6OM2bMeOa83ythpVs9DVvlIbFpfuvmMLQXBELg/+BTh2Rn+aric1GGJIIbLiMk3BzOcEFnDz1ZLeYoAt9Ny+Tjv3aWNywDMJ005q5fGuZK5vuHqqnH6ulwyGDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681609; c=relaxed/simple;
	bh=oFBzYkOTD+1YhQG8gydmiWAy0MYw385s6K3JEYXIUeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rz8rJanEua3FKiv9fhNQ/m8vk8JrlTsbG3yd3gqtVa5zWJFXXfeo0/Archpzzi7jnjFqvkwsKMx7pjM26hkFjq9BmQjxmZ2AZ/Pbfrhhx4sVP+WKvfuiQhTeWCQEMwzh+AbttyPe1SFTmdRkLnOdAQF0ywuJTCN0Rrl5KNA2v3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSNumrm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EFBC19421;
	Mon, 16 Mar 2026 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773681608;
	bh=oFBzYkOTD+1YhQG8gydmiWAy0MYw385s6K3JEYXIUeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSNumrm0rCDBh9y/QKj8QUZUeKb8RrqDvpvm8crd0ngNpWoypaZd5jxuRgcLoxZBW
	 qBR/qeL24S576hJosl8ZGAL64qTx5VifV9MX8YO8bf9pyZD4ENLc2RKSlK6VZdxUZ3
	 Yjok3mGGyDfXkYeHCk6VsD/+rgjWh6pJmv+RjsGSjGPy8Ce7rCJOZcN/mE31SppWyS
	 IKnNGYD6+Fy30lObVJNkMSWJ5OUxdwYBpb3BtQD0Gc5dsIdfzjT0CFsoajMSO0agw3
	 /+mow+cimZ2/+LNMeHy+o331FnbKmUCiyAsoVZKonx2QfgBmtMRPh5MWIp+stPbQEQ
	 mB57ER8R+GR9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yan Zhao <yan.y.zhao@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/8] KVM: x86: Introduce supported_quirks to block disabling quirks
Date: Mon, 16 Mar 2026 13:20:00 -0400
Message-ID: <20260316172003.1024253-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316172003.1024253-1-sashal@kernel.org>
References: <2026031659-scroll-setting-4687@gregkh>
 <20260316172003.1024253-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225635-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D38029E150
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yan Zhao <yan.y.zhao@intel.com>

[ Upstream commit bd7d5362b4c4ac8b951385867a0fadfae0ba3c07 ]

Introduce supported_quirks in kvm_caps to store platform-specific force-enabled
quirks.

No functional changes intended.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20250224070832.31394-1-yan.y.zhao@intel.com>
[Remove unsupported quirks at KVM_ENABLE_CAP time. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e2ffe85b6d2b ("KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 9 +++++----
 arch/x86/kvm/x86.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d5a04ca134d4d..981562592d9ce 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4801,7 +4801,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = enable_pmu ? KVM_CAP_PMU_VALID_MASK : 0;
 		break;
 	case KVM_CAP_DISABLE_QUIRKS2:
-		r = KVM_X86_VALID_QUIRKS;
+		r = kvm_caps.supported_quirks;
 		break;
 	case KVM_CAP_X86_NOTIFY_VMEXIT:
 		r = kvm_caps.has_notify_vmexit;
@@ -6534,11 +6534,11 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 	switch (cap->cap) {
 	case KVM_CAP_DISABLE_QUIRKS2:
 		r = -EINVAL;
-		if (cap->args[0] & ~KVM_X86_VALID_QUIRKS)
+		if (cap->args[0] & ~kvm_caps.supported_quirks)
 			break;
 		fallthrough;
 	case KVM_CAP_DISABLE_QUIRKS:
-		kvm->arch.disabled_quirks |= cap->args[0];
+		kvm->arch.disabled_quirks |= cap->args[0] & kvm_caps.supported_quirks;
 		r = 0;
 		break;
 	case KVM_CAP_SPLIT_IRQCHIP: {
@@ -9782,6 +9782,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
 	}
+	kvm_caps.supported_quirks = KVM_X86_VALID_QUIRKS;
 	kvm_caps.inapplicable_quirks = KVM_X86_CONDITIONAL_QUIRKS;
 
 	rdmsrl_safe(MSR_EFER, &kvm_host.efer);
@@ -12781,7 +12782,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	/* Decided by the vendor code for other VM types.  */
 	kvm->arch.pre_fault_allowed =
 		type == KVM_X86_DEFAULT_VM || type == KVM_X86_SW_PROTECTED_VM;
-	kvm->arch.disabled_quirks = kvm_caps.inapplicable_quirks;
+	kvm->arch.disabled_quirks = kvm_caps.inapplicable_quirks & kvm_caps.supported_quirks;
 
 	ret = kvm_page_track_init(kvm);
 	if (ret)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 82566cd8cbef5..a1bd382232f43 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -32,6 +32,8 @@ struct kvm_caps {
 	u64 supported_xcr0;
 	u64 supported_xss;
 	u64 supported_perf_cap;
+
+	u64 supported_quirks;
 	u64 inapplicable_quirks;
 };
 
-- 
2.51.0


