Return-Path: <stable+bounces-167248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E9B22E78
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC983AA3D2
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC782FABF0;
	Tue, 12 Aug 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q0/42f2H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A572FA0FC
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017832; cv=none; b=Tr3HD8EfjCDVCzrCcdLnSMm1IahrEG44QQUvn3UmGUHmUj7Jx5pHnwWNcyjMuQLgrvhpCf4VKPrzYaruPyPJbDb7roXQp0We6eSSP1ZrM18LA+tmJWA0R+BMEYAAlFBKhfdKS4YwZC29rYfxlBaTuG/AgtmOkR5beJ+5i0fItGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017832; c=relaxed/simple;
	bh=AlbKiPI/MnJzP6JWnRvF802JH07L/FWRW6gewY/3bIQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jwB+w7jGzZ89opG1foC8Dl1e8CASH0mrCZufnjvmHFWjbX96w2sCXJesLtTgl+XtR9/NtVbYYIIsYkBcZ2EhJMJJKJBcF5j9fdqR0xo5ponrLSXDHb6U+cvdbw+ZeC9R5STBzDaINj6CZUUSkZDWB6yKGLjsH/ZdHM/C81wCXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q0/42f2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AD9C4CEF0;
	Tue, 12 Aug 2025 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755017831;
	bh=AlbKiPI/MnJzP6JWnRvF802JH07L/FWRW6gewY/3bIQ=;
	h=Subject:To:Cc:From:Date:From;
	b=q0/42f2HjshyG+IwAS95tNHOkTHwtCBrRJLXYJcGEtAlQJSGoxCf3QWbvCkn/a7Vv
	 pi1/2NnuElyUCF+Z9HLMLeGB0saTe0zzoVWlKbW8JK3n6A0pKpV4u6pk5csrDEWX9J
	 LOJIsOaB6ueKdqKBl/CD/oGDmsGP1hkpgh6KWzXA=
Subject: FAILED: patch "[PATCH] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is" failed to apply to 5.15-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:57:08 +0200
Message-ID: <2025081208-scrubber-veggie-e1a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 17ec2f965344ee3fd6620bef7ef68792f4ac3af0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081208-scrubber-veggie-e1a5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


