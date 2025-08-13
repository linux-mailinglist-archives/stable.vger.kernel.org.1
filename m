Return-Path: <stable+bounces-169452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8824CB2534D
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCC43AE279
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E222FF175;
	Wed, 13 Aug 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEXDKDyG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359562FF145
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110961; cv=none; b=lSuvO672FUsVE8W6eKVcFH5oMlvMUT7ZxjNF88x+qxOxa6hIaRbUeiyrC5/WPaccFDZVCuhTWoHkf297dE+7dFvSxiZyqW51Mf1Zmf+BoRCqxQ++Q5829e8S87u48nOglVHv4W9cJSuAQZnKvqcW0QFe55FkkygNWc589oHYjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110961; c=relaxed/simple;
	bh=eO+VaCfVqAgVEXUosHKSLBI2hw09lUea4Xr77bMmVIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ID8IMOGReFIPc20sNYhktp6YcRwd0tF862Xq/awey7MAtlWB3ntChNmCaN6OG1kTGGY5Hpf8o7cd8vHNuHJMqSuJu7U5qX9+DImdWfot8TYS86R4CE5usCSKgIlqyRrK+XGtYpIywqu23kcNWlk9LpnG7KEjU4oJcHVc6k2256M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEXDKDyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E63FC4CEEB;
	Wed, 13 Aug 2025 18:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755110960;
	bh=eO+VaCfVqAgVEXUosHKSLBI2hw09lUea4Xr77bMmVIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEXDKDyGRYHqaPpzgXi5v6otwKHBBFyRCEgTdpbk+5DNgtV4YTnYuLf98DTA2BjuP
	 dul5oFVvi8vcu3G6JOYT00CUyZDVe2zT5FDQlwKHOlNxNlgotURY60EZouLdxwtXuJ
	 a4bxGXAElt7PmoBTL53kSm5/pz4qayvNmMxbdQ1Xi01OIPQfrPuuOJbliLdHBOh+CU
	 93kpXFAfR5ONgAo48cvlYErZY8WzmeT5PNXjZQTz65Bbq1O+NPCGivTjyw54vAofBT
	 H8oWQ9ttccnEr5KMnMacEHVAYyLh6DNX4RLFAmeqALyvUnL0R4uYYh9xzzWOlUZyWu
	 179q/IVuPHvrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
Date: Wed, 13 Aug 2025 14:49:18 -0400
Message-Id: <20250813184918.2071296-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081208-commerce-sports-ea01@gregkh>
References: <2025081208-commerce-sports-ea01@gregkh>
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
index 727947ed5e5e..afd65c815043 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -379,6 +379,7 @@
 #define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
 #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
 #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+#define DEBUGCTLMSR_RTM_DEBUG		BIT(15)
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fbe26b88f731..40862ed8162a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2068,6 +2068,10 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
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


