Return-Path: <stable+bounces-169560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71983B2674A
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 15:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFCA5E4F8C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597DC3002D8;
	Thu, 14 Aug 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+Y1KcOt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DCB7081F
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177878; cv=none; b=QzJHwedy1+BZkCi/PIWhBDtkPKZO/VWJ0R9YdVBX3q7fJ+95ZaJv2xYtdXgDSDHidG5zBFa1w4uwH375UMSuxjqH0JvWBDj4WPiun7OgFlX6lYrkNc5bSPSanWvif7BfWOmIoK6KAjs++FSTfovOpPWzM4BiS73aHBfC/slvbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177878; c=relaxed/simple;
	bh=yBHH7Ze6zNHro46kkXeU1kRxFyqrY5t9TBu89yktPnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKda3+WECp47Lk7efWmlUcnufWKsFHBSchTnM/d1c/biLMCEDAywC9PTc6qW/t5/doRRNGXf2lt8HY8FdCy1azt3GU8Cv+VZLD7GCqlJb8cl8Z+VPzyZDYzeYqkwFN+o12mkx4ltS6m9ucroKdRPIso+6OIQzIwp1nZX3KX0bhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+Y1KcOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B26C4CEF1;
	Thu, 14 Aug 2025 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755177876;
	bh=yBHH7Ze6zNHro46kkXeU1kRxFyqrY5t9TBu89yktPnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+Y1KcOtQN7/wsoEMdYu9S9foZNITmx67G3hgh+wogkEoxQLxs2x9tLObPhTcGFOY
	 90yRLj/MblcmMfNZkr7mqh5GlBzgkqjFoOJ5h19eCHteo4Mlz1UixvwK6Ij3o5apJ8
	 95DmpehttVf7u4Zezq1YS1gapLFpG7LUJvRmQtfRXAMEdzyRe/lFvTpmNR5Tvm7QD8
	 fIkAyaVRWsrk0UvFDZGxtfmx/VAdOD2M0+zGUrXNBCkK4VOBHWsNtESdhaYXGSICkz
	 6Chf8Aldx0KXtdPVijShs1P6an/PmPVUKPRFQdNqgMofrUacBp2c6/OKMrvCrmdfnV
	 AQwlGdWXygkSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] KVM: x86/pmu: Gate all "unimplemented MSR" prints on report_ignored_msrs
Date: Thu, 14 Aug 2025 09:24:31 -0400
Message-Id: <20250814132434.2096873-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081215-variable-implicit-aa4c@gregkh>
References: <2025081215-variable-implicit-aa4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit e76ae52747a82a548742107b4100e90da41a624d ]

Add helpers to print unimplemented MSR accesses and condition all such
prints on report_ignored_msrs, i.e. honor userspace's request to not
print unimplemented MSRs.  Even though vcpu_unimpl() is ratelimited,
printing can still be problematic, e.g. if a print gets stalled when host
userspace is writing MSRs during live migration, an effective stall can
result in very noticeable disruption in the guest.

E.g. the profile below was taken while calling KVM_SET_MSRS on the PMU
counters while the PMU was disabled in KVM.

  -   99.75%     0.00%  [.] __ioctl
   - __ioctl
      - 99.74% entry_SYSCALL_64_after_hwframe
           do_syscall_64
           sys_ioctl
         - do_vfs_ioctl
            - 92.48% kvm_vcpu_ioctl
               - kvm_arch_vcpu_ioctl
                  - 85.12% kvm_set_msr_ignored_check
                       svm_set_msr
                       kvm_set_msr_common
                       printk
                       vprintk_func
                       vprintk_default
                       vprintk_emit
                       console_unlock
                       call_console_drivers
                       univ8250_console_write
                       serial8250_console_write
                       uart_console_write

Reported-by: Aaron Lewis <aaronlewis@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20230124234905.3774678-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/hyperv.c  | 10 ++++------
 arch/x86/kvm/svm/svm.c |  5 ++---
 arch/x86/kvm/vmx/vmx.c |  4 +---
 arch/x86/kvm/x86.c     | 18 +++++-------------
 arch/x86/kvm/x86.h     | 12 ++++++++++++
 5 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 28555bbd52e8..cb0a531e13c5 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1406,8 +1406,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
 		return syndbg_set_msr(vcpu, msr, data, host);
 	default:
-		vcpu_unimpl(vcpu, "Hyper-V unhandled wrmsr: 0x%x data 0x%llx\n",
-			    msr, data);
+		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 		return 1;
 	}
 	return 0;
@@ -1528,8 +1527,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 			return 1;
 		break;
 	default:
-		vcpu_unimpl(vcpu, "Hyper-V unhandled wrmsr: 0x%x data 0x%llx\n",
-			    msr, data);
+		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 		return 1;
 	}
 
@@ -1581,7 +1579,7 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
 		return syndbg_get_msr(vcpu, msr, pdata, host);
 	default:
-		vcpu_unimpl(vcpu, "Hyper-V unhandled rdmsr: 0x%x\n", msr);
+		kvm_pr_unimpl_rdmsr(vcpu, msr);
 		return 1;
 	}
 
@@ -1646,7 +1644,7 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 		data = APIC_BUS_FREQUENCY;
 		break;
 	default:
-		vcpu_unimpl(vcpu, "Hyper-V unhandled rdmsr: 0x%x\n", msr);
+		kvm_pr_unimpl_rdmsr(vcpu, msr);
 		return 1;
 	}
 	*pdata = data;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b6bbd0dc4e65..8fbe071334d4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3035,8 +3035,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
 		if (!lbrv) {
-			vcpu_unimpl(vcpu, "%s: MSR_IA32_DEBUGCTL 0x%llx, nop\n",
-				    __func__, data);
+			kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
 			break;
 		}
 
@@ -3077,7 +3076,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_VM_CR:
 		return svm_set_vm_cr(vcpu, data);
 	case MSR_VM_IGNNE:
-		vcpu_unimpl(vcpu, "unimplemented wrmsr: 0x%x data 0x%llx\n", ecx, data);
+		kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
 		break;
 	case MSR_AMD64_DE_CFG: {
 		struct kvm_msr_entry msr_entry;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fbe26b88f731..dac7883acdd2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2144,9 +2144,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		invalid = data & ~vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
 		if (invalid & (DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR)) {
-			if (report_ignored_msrs)
-				vcpu_unimpl(vcpu, "%s: BTF|LBR in IA32_DEBUGCTLMSR 0x%llx, nop\n",
-					    __func__, data);
+			kvm_pr_unimpl_wrmsr(vcpu, msr_index, data);
 			data &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
 			invalid &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
 		}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a6dc8f662fa4..fcca0c030bcd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3573,7 +3573,6 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
-	bool pr = false;
 	u32 msr = msr_info->index;
 	u64 data = msr_info->data;
 
@@ -3625,15 +3624,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (data == BIT_ULL(18)) {
 			vcpu->arch.msr_hwcr = data;
 		} else if (data != 0) {
-			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
-				    data);
+			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 			return 1;
 		}
 		break;
 	case MSR_FAM10H_MMIO_CONF_BASE:
 		if (data != 0) {
-			vcpu_unimpl(vcpu, "unimplemented MMIO_CONF_BASE wrmsr: "
-				    "0x%llx\n", data);
+			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 			return 1;
 		}
 		break;
@@ -3813,16 +3810,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
 	case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR1:
-		pr = true;
-		fallthrough;
 	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
 	case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL1:
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
 
-		if (pr || data != 0)
-			vcpu_unimpl(vcpu, "disabled perfctr wrmsr: "
-				    "0x%x data 0x%llx\n", msr, data);
+		if (data)
+			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 		break;
 	case MSR_K7_CLK_CTL:
 		/*
@@ -3849,9 +3843,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		/* Drop writes to this legacy MSR -- see rdmsr
 		 * counterpart for further detail.
 		 */
-		if (report_ignored_msrs)
-			vcpu_unimpl(vcpu, "ignored wrmsr: 0x%x data 0x%llx\n",
-				msr, data);
+		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
 		break;
 	case MSR_AMD64_OSVW_ID_LENGTH:
 		if (!guest_cpuid_has(vcpu, X86_FEATURE_OSVW))
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 9de72586f406..f3554bf05201 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -331,6 +331,18 @@ extern bool report_ignored_msrs;
 
 extern bool eager_page_split;
 
+static inline void kvm_pr_unimpl_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+{
+	if (report_ignored_msrs)
+		vcpu_unimpl(vcpu, "Unhandled WRMSR(0x%x) = 0x%llx\n", msr, data);
+}
+
+static inline void kvm_pr_unimpl_rdmsr(struct kvm_vcpu *vcpu, u32 msr)
+{
+	if (report_ignored_msrs)
+		vcpu_unimpl(vcpu, "Unhandled RDMSR(0x%x)\n", msr);
+}
+
 static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
 {
 	return pvclock_scale_delta(nsec, vcpu->arch.virtual_tsc_mult,
-- 
2.39.5


