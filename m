Return-Path: <stable+bounces-225634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHfGJlU+uGmpagEAu9opvQ
	(envelope-from <stable+bounces-225634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:31:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE5429E47B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C5493150B05
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868343D1CC9;
	Mon, 16 Mar 2026 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULzKgjof"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C73D1CBB
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681608; cv=none; b=oR47SGg4rSj6GAZqAeLy4/5hgZmGrOY8Qu/7BHge2bFgLNai3qYB6Qcib9GaQdlWVqkxmuHkANT4lkM6pTPPbXSgTwXrepqwkpRHqZcuDoph5po8o5KQ/YkQ+6hbu3OCKAYLjKtRDiNC11Cyevh64v7qwYETwDSbDYw8TxnWK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681608; c=relaxed/simple;
	bh=fUSfsFTfHVy7IvD+AJaHS3Qxcrqtyqw20qHZNZO76AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fie8pDxrgRKh8PbapTJpLtALghF6ZAaebtVUxALYrlFHNnuHwbbRBR9k21iRsnq5m5IbNgc75m0kgnBvjcc0KbnfgVGoAsmgzYq6DgZIunFk5DlPlZuhbOvPQIH4yQRNIl2nH3xDs9dtiJElXqw8vMfpFRS/I4puBR0blKxyzfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULzKgjof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911C2C19425;
	Mon, 16 Mar 2026 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773681608;
	bh=fUSfsFTfHVy7IvD+AJaHS3Qxcrqtyqw20qHZNZO76AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULzKgjofYbL5Hs7mulGbMhvx5lemhcDOjc83vwCIN7ZASq0bBV6JfjIzcuURcY82i
	 5SBbpBvJYGTrt5fEcRdGB55MDofkHLDQiuIE9IxDvMEJ+jOF0Bpfa5ZWavCXjDqiZc
	 NqEfVBiOGh1gk77ORThL4+zbQBa1Py7oMXzGs2vwHX+ZYr50n0tPryT73nKO8ZeatD
	 UzUYYkuvkLWTBtr1MTRc61pubFNQIKGqBzA/1Ng/TICHgMINf+uJjKfai9+1gzXVZI
	 9aKQxCJLFslvn9or9TvZUWv6uR91IGSCKlVrZTRu9rBksTr1ZRcKGfjDHFImjDwKPI
	 99st0xfke2pAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/8] KVM: x86: Allow vendor code to disable quirks
Date: Mon, 16 Mar 2026 13:19:59 -0400
Message-ID: <20260316172003.1024253-4-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-225634-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2DE5429E47B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit a4dae7c7a41d803a05192015b2d47aca8aca4abf ]

In some cases, the handling of quirks is split between platform-specific
code and generic code, or it is done entirely in generic code, but the
relevant bug does not trigger on some platforms; for example,
this will be the case for "ignore guest PAT".  Allow unaffected vendor
modules to disable handling of a quirk for all VMs via a new entry in
kvm_caps.

Such quirks remain available in KVM_CAP_DISABLE_QUIRKS2, because that API
tells userspace that KVM *knows* that some of its past behavior was bogus
or just undesirable.  In other words, it's plausible for userspace to
refuse to run if a quirk is not listed by KVM_CAP_DISABLE_QUIRKS2, so
preserve that and make it part of the API.

As an example, mark KVM_X86_QUIRK_CD_NW_CLEARED as auto-disabled on
Intel systems.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e2ffe85b6d2b ("KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h | 3 +++
 arch/x86/kvm/svm/svm.c          | 1 +
 arch/x86/kvm/x86.c              | 2 ++
 arch/x86/kvm/x86.h              | 1 +
 4 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6821317eb8562..7fdaefb301d93 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2388,6 +2388,9 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 	 KVM_X86_QUIRK_SLOT_ZAP_ALL |		\
 	 KVM_X86_QUIRK_STUFF_FEATURE_MSRS)
 
+#define KVM_X86_CONDITIONAL_QUIRKS		\
+	 KVM_X86_QUIRK_CD_NW_CLEARED
+
 /*
  * KVM previously used a u32 field in kvm_run to indicate the hypercall was
  * initiated from long mode. KVM now sets bit 0 to indicate long mode, but the
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9ceb0e8dbe3c5..cd1d501da22c1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5562,6 +5562,7 @@ static __init int svm_hardware_setup(void)
 	 */
 	allow_smaller_maxphyaddr = !npt_enabled;
 
+	kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_CD_NW_CLEARED;
 	return 0;
 
 err:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 10bbc7c446cd8..d5a04ca134d4d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9782,6 +9782,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
 	}
+	kvm_caps.inapplicable_quirks = KVM_X86_CONDITIONAL_QUIRKS;
 
 	rdmsrl_safe(MSR_EFER, &kvm_host.efer);
 
@@ -12780,6 +12781,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	/* Decided by the vendor code for other VM types.  */
 	kvm->arch.pre_fault_allowed =
 		type == KVM_X86_DEFAULT_VM || type == KVM_X86_SW_PROTECTED_VM;
+	kvm->arch.disabled_quirks = kvm_caps.inapplicable_quirks;
 
 	ret = kvm_page_track_init(kvm);
 	if (ret)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index ec623d23d13d2..82566cd8cbef5 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -32,6 +32,7 @@ struct kvm_caps {
 	u64 supported_xcr0;
 	u64 supported_xss;
 	u64 supported_perf_cap;
+	u64 inapplicable_quirks;
 };
 
 struct kvm_host_values {
-- 
2.51.0


