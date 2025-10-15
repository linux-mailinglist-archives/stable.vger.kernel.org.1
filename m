Return-Path: <stable+bounces-185805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD307BDE504
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25114503B43
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9943C322766;
	Wed, 15 Oct 2025 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GEUGPIOH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293B3218B3
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528560; cv=none; b=NkCzLaIcEdhdBt+jOVZPjhfK0v1TtRC4NVpA+wJt1LskkuOnszhQlMcrHEv/YYoA4+d9DyIaB88Mmsfle683tqERFi0EsHvjXCxYcPuV8gqdyjYN4AuBAwO+yXozKNy1eaRrdItSTK6youZAmw9lui1QKQFGH/okZKLz5QCN2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528560; c=relaxed/simple;
	bh=4Pj1eVzxexnEVSAZDsAf2HrD6C/BgO9AfsKexabbPzA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uccRf9CbExFF2e0iV84XTLcan6fKNRCNz1OgjmFBleCn+dbz17ejNpv6ouZ3nIV4AwD4L1xVzVQ3t2pjSdVDUg6g9sWzqLO6CIN7ZogncF53FyyfgUm4XVrbGTKof+WJ/Mr9IXCZ+DCn7D6D6KQ9yMzsFOc1r4J6Wj5kFxSTCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GEUGPIOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CCDC116B1;
	Wed, 15 Oct 2025 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760528560;
	bh=4Pj1eVzxexnEVSAZDsAf2HrD6C/BgO9AfsKexabbPzA=;
	h=Subject:To:Cc:From:Date:From;
	b=GEUGPIOH8a4BMZltaWe2wVHv2w/CW7hJIoFB1/IZgnuwc+XSCiQx4Oy4EstEnymJw
	 AEF4PeG8qOKF4VVgnziv2hFPYwmObM6pB2XsYtc7uyf4EAG+ZcO4Mb5cTV7sosnhQW
	 1dKRYbAnPTCpeYH94YXa9uCs/14bqzWuSIqqB1jw=
Subject: FAILED: patch "[PATCH] KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2" failed to apply to 6.6-stable tree
To: seanjc@google.com,sandipan.das@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 13:42:37 +0200
Message-ID: <2025101537-entangled-rhyme-6714@gregkh>
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
git cherry-pick -x 68e61f6fd65610e73b17882f86fedfd784d99229
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101537-entangled-rhyme-6714@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 68e61f6fd65610e73b17882f86fedfd784d99229 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 11 Jul 2025 10:27:46 -0700
Subject: [PATCH] KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2

Emulate PERF_CNTR_GLOBAL_STATUS_SET when PerfMonV2 is enumerated to the
guest, as the MSR is supposed to exist in all AMD v2 PMUs.

Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
Cc: stable@vger.kernel.org
Cc: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20250711172746.1579423-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b65c3ba5fa14..20fa4a79df13 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -733,6 +733,7 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET	0xc0000303
 
 /* AMD Hardware Feedback Support MSRs */
 #define MSR_AMD_WORKLOAD_CLASS_CONFIG		0xc0000500
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 75e9cfc689f8..a84fb3d28885 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -650,6 +650,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = pmu->global_ctrl;
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 		msr_info->data = 0;
 		break;
@@ -711,6 +712,10 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated)
 			pmu->global_status &= ~data;
 		break;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
+		if (!msr_info->host_initiated)
+			pmu->global_status |= data & ~pmu->global_status_rsvd;
+		break;
 	default:
 		kvm_pmu_mark_pmc_in_use(vcpu, msr_info->index);
 		return kvm_pmu_call(set_msr)(vcpu, msr_info);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 288f7f2a46f2..aa4379e46e96 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -113,6 +113,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		return pmu->version > 1;
 	default:
 		if (msr > MSR_F15H_PERF_CTR5 &&
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79057622fa76..5dc32f2fe391 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -367,6 +367,7 @@ static const u32 msrs_to_save_pmu[] = {
 	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
@@ -7353,6 +7354,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		if (!kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
 			return;
 		break;


