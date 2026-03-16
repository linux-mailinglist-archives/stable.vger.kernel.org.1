Return-Path: <stable+bounces-225631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x3UiIUk+uGmxawEAu9opvQ
	(envelope-from <stable+bounces-225631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:30:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D0329E464
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86ADB314A82B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53673D4131;
	Mon, 16 Mar 2026 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW4QLohx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694153CFF6E
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681606; cv=none; b=H1hsO7f9inYwumEdrH82ZuTSyet1YkRMuGwAGTi6AMNcvjcetrF+w6RB1WQdpKmpnSDWyEC+PB2RTqwOfE5bkbCEhx+pESaQAMvRvb5fVAJg80q1NQkbCeJ8m3eR8/fw4ewSAY6h5IMVj5LUAKv1FxVZBuzosApTpASdS45gERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681606; c=relaxed/simple;
	bh=HNMnmPvNdVDkfMchex+qw8iaKGMYfHowY3ePHucuPPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT7L/11QEvDhyaGF1trE4CygVainhzd6t8CrumHv6c/lzGZWHAHHnvmcBfQgpcpNdqhc8U4d+hxZhZ14Wp1bWWkBUh0u/rfRdI6QHmxnkrgNXEkrRopl1fSpxPKzzcjZoMcLT9mirJlHez0jhWgPk3kD46WYf+p6m+Zql4Ij9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW4QLohx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53BAC19421;
	Mon, 16 Mar 2026 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773681606;
	bh=HNMnmPvNdVDkfMchex+qw8iaKGMYfHowY3ePHucuPPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dW4QLohxLZ75NVrsjsgGM2H7nqJJlid3Dn0+LhgEb7Wlak4Dk6ccYP+7+WiF2r3HO
	 qdI+IlwHJtLYvA/kFIQJe87lVCcevXrZi9F+mR5bDcTA09Ov2JVlt9XL1QAs2Wfzfv
	 HdAwVl+caiqZusiCentbmXAo7/86AyTM7/23RIq7cKX1T2unVttNbhuX3G2Y8jyVl9
	 AcaRjxVxKpqqN/W12q2I/J8VJsunQVMWQRVhBYIpe//2g+x4bjP3I1hSYZcZVOd72o
	 AMVH4eKFLzjsm6QEVhtd48z9fOWaM0/cdvj0Q/RzUgK6w29ZORXusU7z8VMrzqu58y
	 i8oW5oK+Wo+LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/8] KVM: x86: Co-locate initialization of feature MSRs in kvm_arch_vcpu_create()
Date: Mon, 16 Mar 2026 13:19:56 -0400
Message-ID: <20260316172003.1024253-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031659-scroll-setting-4687@gregkh>
References: <2026031659-scroll-setting-4687@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225631-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B9D0329E464
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 2142ac663a6a72ac868d0768681b1355e3a703eb ]

Bunch all of the feature MSR initialization in kvm_arch_vcpu_create() so
that it can be easily quirked in a future patch.

No functional change intended.

Link: https://lore.kernel.org/r/20240802185511.305849-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: e2ffe85b6d2b ("KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0d9035993ed36..60e2ac7ed2fc3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12383,6 +12383,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_async_pf_hash_reset(vcpu);
 
+	vcpu->arch.arch_capabilities = kvm_get_arch_capabilities();
+	vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
 	vcpu->arch.perf_capabilities = kvm_caps.supported_perf_cap;
 	kvm_pmu_init(vcpu);
 
@@ -12397,8 +12399,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (r)
 		goto free_guest_fpu;
 
-	vcpu->arch.arch_capabilities = kvm_get_arch_capabilities();
-	vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
 	kvm_xen_init_vcpu(vcpu);
 	vcpu_load(vcpu);
 	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz);
-- 
2.51.0


