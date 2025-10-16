Return-Path: <stable+bounces-186094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11088BE3905
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855DA188292A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616EF32C319;
	Thu, 16 Oct 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoAssZv7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A2205E2F
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619626; cv=none; b=qQjUoaYUsB+v+ujk4JLVWmGLnUNCXaV72uQ20j3chod5GrCR8aae9KkarEFRInt6br861ewHNXIGJLQTwjL5qZ8Udc7B/i8Pv+H9rfy0XD6YzQtHotspNVb5FOffKw63TzzOcBwuLruQiIo7s27SkNV/pXBam/Rsrv+LgTGib2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619626; c=relaxed/simple;
	bh=5V5TvVP9FGHTtP34T2C7oWzdkTY3aZmvjw5MQMxicgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHgQ1CCwc2eY1adrdOjLSr7PVQjrPe7rc80y8Y58+UTSWN5kOOwVvpANMpkNTWQpvu6MigIb3YM7yp6kQ6f5rIEKsIxrR320p+HVpENL/cQ4M03SGHGNo55MwJjSYDB14U3LYO0Yvzx0TCSwftCvNi2hWBHy6UFnzdNQ6cKzS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoAssZv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226C0C4CEF1;
	Thu, 16 Oct 2025 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619623;
	bh=5V5TvVP9FGHTtP34T2C7oWzdkTY3aZmvjw5MQMxicgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoAssZv7/WnpZ9j7qH5n91TTe/I/gnXg+B/3OOyqf+iouIW8ud7bd2zhxh7n8ZlWg
	 N98Fbhvd7WJH635UE3UH1a/X2TbUcazfkPdrn1Nh1rk34N8XiQUifnVhaspJFMO02Q
	 ooDY9eF7ejVxmQWw6Ci7WhzoF51vpApEC7YStAPdDB1J+e0eRdgJW7ULD9Fz/alTgI
	 fU2SAhOrGGH9mt+aIP1SIo6c0E/9RN2IuVNjYzcfadn68UJH8eaz0Zeh7GDaqlqU0u
	 KqHi9PoRBJ1scPbQC4j7dCvxOWggxLQ8Qcwqcb44tE0sWCxx2NOmL9mvx3mwEamOcI
	 dkSLqW5TXAU+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2
Date: Thu, 16 Oct 2025 09:00:21 -0400
Message-ID: <20251016130021.3283271-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101537-entangled-rhyme-6714@gregkh>
References: <2025101537-entangled-rhyme-6714@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 68e61f6fd65610e73b17882f86fedfd784d99229 ]

Emulate PERF_CNTR_GLOBAL_STATUS_SET when PerfMonV2 is enumerated to the
guest, as the MSR is supposed to exist in all AMD v2 PMUs.

Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
Cc: stable@vger.kernel.org
Cc: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20250711172746.1579423-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ changed global_status_rsvd field to global_status_mask ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/msr-index.h | 1 +
 arch/x86/kvm/pmu.c               | 5 +++++
 arch/x86/kvm/svm/pmu.c           | 1 +
 arch/x86/kvm/x86.c               | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 723e48b57bd0f..425980eacaa84 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -661,6 +661,7 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET	0xc0000303
 
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index da2d82e3a8735..f2cd8cfb0ef55 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -588,6 +588,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = pmu->global_ctrl;
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 		msr_info->data = 0;
 		break;
@@ -649,6 +650,10 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated)
 			pmu->global_status &= ~data;
 		break;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
+		if (!msr_info->host_initiated)
+			pmu->global_status |= data & ~pmu->global_status_mask;
+		break;
 	default:
 		kvm_pmu_mark_pmc_in_use(vcpu, msr_info->index);
 		return static_call(kvm_x86_pmu_set_msr)(vcpu, msr_info);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 3fd47de14b38a..0bad24f763d22 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -117,6 +117,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		return pmu->version > 1;
 	default:
 		if (msr > MSR_F15H_PERF_CTR5 &&
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 71d60d4e991fd..a589a5781e906 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1495,6 +1495,7 @@ static const u32 msrs_to_save_pmu[] = {
 	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
@@ -7194,6 +7195,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		if (!kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
 			return;
 		break;
-- 
2.51.0


