Return-Path: <stable+bounces-169450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B65B2531C
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 20:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37ECE726F87
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502AC2D0281;
	Wed, 13 Aug 2025 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co5m8CGK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B031DF24F
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110253; cv=none; b=reoQ7lyl/h2GiNLQWhK6jBsxsHFOcyGEJpQCxcDF5McbL8Gf5PMCGW3lae6KGEPYWPbkYqq6TFvMY3am+ER5UmxEtr4bOSUdBYWn2KHU8UjzWIU1gctQczTakTZUZxJOBPfoeQAwFKUYH2iXVWg+wUri+8cXtfjbXW9gJLA089g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110253; c=relaxed/simple;
	bh=H7glysDxZJm89zUewN9SzXcSbB+jyIlixGm72y0jTDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mx1FbvGEldMmHTlVYMPSLRnZKjTsZEYtPB6Kz1ehAYqX25u+0NCBX7yPs/hzCsFYfWG/lX0tfQ0IIpLgn6YXPbF64cfObzQ+NnXAR0Md4gJMXep0GLtQDJ3Gx7vVqs0LnC9lBbY0NdfV4zabWC7R5RoxI6UM5ytjusaMwzFDEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co5m8CGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB03C4CEEB;
	Wed, 13 Aug 2025 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755110252;
	bh=H7glysDxZJm89zUewN9SzXcSbB+jyIlixGm72y0jTDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=co5m8CGKZA2Z8cSiq1sjHVs6FJRpX3LIi6Ynm+XduTmvl//m1kyiMLMJnJcqqYLvF
	 k7ryAzDeFA43ktoMod2aIWyfVxKLnKw27NFM/qiFeYhKcWu2XBFq2FAWjWu7XgI4e4
	 hP1GsyhVbJFqpH/EhKOdKeBq6MXKNSIAvxacI1i0poJ9rYAxoQanBZp6bHamyF0oMr
	 jN3qFzxuJ3zuRouXoDHT6M8uwB7cK/7OIQNYkfKvrrDWs0aqGA0ZfFjdmDPNAWYkLH
	 2cZus1ccA7xoESEN0LcMJxBZbRQF5oYeI1p6x7Z8OInEBGInHQARypQt4zNgi1ZxFq
	 qTu6Q9ZE9cysQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
Date: Wed, 13 Aug 2025 14:37:28 -0400
Message-Id: <20250813183728.2070321-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081209-porcupine-shut-1d95@gregkh>
References: <2025081209-porcupine-shut-1d95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 17ec2f965344ee3fd6620bef7ef68792f4ac3af0 ]

Let the guest set DEBUGCTL.RTM_DEBUG if RTM is supported according to the
guest CPUID model, as debug support is supposed to be available if RTM is
supported, and there are no known downsides to letting the guest debug RTM
aborts.

Note, there are no known bug reports related to RTM_DEBUG, the primary
motivation is to reduce the probability of breaking existing guests when a
future change adds a missing consistency check on vmcs12.GUEST_DEBUGCTL
(KVM currently lets L2 run with whatever hardware supports; whoops).

Note #2, KVM already emulates DR6.RTM, and doesn't restrict access to
DR7.RTM.

Fixes: 83c529151ab0 ("KVM: x86: expose Intel cpu new features (HLE, RTM) to guest")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250610232010.162191-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Changed guest_cpu_cap_has to guest_cpuid_has ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/msr-index.h | 1 +
 arch/x86/kvm/vmx/vmx.c           | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 033855457581..723e48b57bd0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -380,6 +380,7 @@
 #define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
 #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
 #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+#define DEBUGCTLMSR_RTM_DEBUG		BIT(15)
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e53620e18925..f5a89a09b5bb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2165,6 +2165,10 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	    (host_initiated || intel_pmu_lbr_is_enabled(vcpu)))
 		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
+	if (boot_cpu_has(X86_FEATURE_RTM) &&
+	    (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_RTM)))
+		debugctl |= DEBUGCTLMSR_RTM_DEBUG;
+
 	return debugctl;
 }
 
-- 
2.39.5


