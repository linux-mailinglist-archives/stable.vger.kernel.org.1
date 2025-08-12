Return-Path: <stable+bounces-167249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0ECB22E75
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345D517FA8F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3622FAC08;
	Tue, 12 Aug 2025 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aTJkKoei"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7F2FABF1
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017840; cv=none; b=rV/du9asOns+i+2oceEEdevB+WoAyPWM/Yqv8VR3Phz2TXByEOy110yScbh2dbGWN2lMwyDbvnixh1aUU6raDMuONTg+p13QDZQGZNbyhoxW/+ViEldB9DZRNupgGyN8NG3usW0zyVIqdq7ZvhQoxL3NDkZzuw08AA79z4k18BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017840; c=relaxed/simple;
	bh=SEtywV677PoCtyqG/OqRJ3aIvv2zkIZrCIYk/ab7lfI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PBYygwKTqM6FzkppLpT4BPCXRZhk7POI8YlXvDkA7u5aAI+He7C9zjzHIrajWYNcmmMTHV+YrHp+bjc6XngjW4S6+Q5mVHavbLdl64hKtLy/RGiSu1+5bkF33RSbjGGr0zagz6D1ttYa2qC5y4PtIGI5gLXIl6SNzfW1wSgT3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aTJkKoei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913FBC4CEF0;
	Tue, 12 Aug 2025 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755017840;
	bh=SEtywV677PoCtyqG/OqRJ3aIvv2zkIZrCIYk/ab7lfI=;
	h=Subject:To:Cc:From:Date:From;
	b=aTJkKoeilWbL+E4vvl8lMdOVEsLM+WXYHSjwSq+ZygNm298WOZV5795RBDLha1PE4
	 p9CTSTVLRosC4OvkX8RJsesDQPaKSNz32LXmFrFp2+HWCkGOMJNi1JFhF8oKrPLNp1
	 YU3RQzb84BGVDFBg3Y8JPxlYUjS0aHWubG1mJSh4=
Subject: FAILED: patch "[PATCH] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is" failed to apply to 6.6-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:57:09 +0200
Message-ID: <2025081209-porcupine-shut-1d95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 17ec2f965344ee3fd6620bef7ef68792f4ac3af0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081209-porcupine-shut-1d95@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 17ec2f965344ee3fd6620bef7ef68792f4ac3af0 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Jun 2025 16:20:06 -0700
Subject: [PATCH] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is
 supported

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

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b7dded3c8113..fa878b136eba 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -419,6 +419,7 @@
 #define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
 #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
 #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+#define DEBUGCTLMSR_RTM_DEBUG		BIT(15)
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4ee6cc796855..311f6fa53b67 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2186,6 +2186,10 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	    (host_initiated || intel_pmu_lbr_is_enabled(vcpu)))
 		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
+	if (boot_cpu_has(X86_FEATURE_RTM) &&
+	    (host_initiated || guest_cpu_cap_has(vcpu, X86_FEATURE_RTM)))
+		debugctl |= DEBUGCTLMSR_RTM_DEBUG;
+
 	return debugctl;
 }
 


