Return-Path: <stable+bounces-169448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576EEB252FD
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 20:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192FC5A7F4D
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F172E8899;
	Wed, 13 Aug 2025 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7/M9HV5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121CC2D7381
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109499; cv=none; b=YCNEKdp/oGY3ydd/fwywJaxQBV0V7WzU8DZ0XX8EdNswzNeFXsEK3IHkLkIkfZoOa7llVzYve+J41Q0GI+5RRbP1U4Ra0cx8ujqMRImGLR15Tb48RQY/a0tRsSRl/ZMFImZ0iX2rBxlBhPw3OwBveBfG9kUbhbKeCTicxr+7/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109499; c=relaxed/simple;
	bh=y2r4QwW3s/4kpSEJIOdV/t7oGVHDK41dF0CoF2l621Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQ+sv12S9ywoKz9yhRJUeui7HG+11UkuCp6yit/tuOgk564CKikc1VDHcE89qGr7U91n6VIFTOWkQbJ+Znzy/BFRnbum/+wytDblejosmp6y6EHswAtx7jdPdP2td7pmS5WMOFSoVIYQka7/5nKHowqwYJljqt0ZPvp7qhtYFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7/M9HV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF45C4CEEB;
	Wed, 13 Aug 2025 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755109498;
	bh=y2r4QwW3s/4kpSEJIOdV/t7oGVHDK41dF0CoF2l621Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7/M9HV5SOOwxGQbQWt5OeT6Ii0cz5jK+jwE9EDl/TNgAE4mdG3I/t1eGJ/ExPh/p
	 PmnqHTHhxKPo/Yox6WD2oMUll58UEoQy0jLLlMlSYSgOkcCMAfC8p91JOCDypNR6O0
	 jGx+55dPhi+LuHhDjVHCpeDHxFzrHgkjnx0FvD8Ads1xaZjgMva48MlKsZ8dMziNMF
	 oHHVQDaoxQs/c+queuG4k/J+VSD5T8np74qnjm0yxo2C10H/InrUeR8A0k0r5yR+34
	 3iRfUpfwk15Q3ZuIahNoDsnAbM0TcvWA3poSkMNoS1EqSIcp9gC6f6WWm7Ii5Eyw2g
	 kiQVtzM0DIK4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
Date: Wed, 13 Aug 2025 14:24:55 -0400
Message-Id: <20250813182455.2068642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081210-overhand-panhandle-a07f@gregkh>
References: <2025081210-overhand-panhandle-a07f@gregkh>
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
index 7ebe76f69417..2b6e3127ef4e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -417,6 +417,7 @@
 #define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
 #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
 #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+#define DEBUGCTLMSR_RTM_DEBUG		BIT(15)
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9a4ebf3dfbfc..243c072368e3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2185,6 +2185,10 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
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


