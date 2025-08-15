Return-Path: <stable+bounces-169645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0AB27372
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD13A188C7DE
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2331DE2AD;
	Fri, 15 Aug 2025 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1mBRpXY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED511C862F
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216748; cv=none; b=iFQ0PTHLEplEMXqtocGOCl+trgoKrh1y84woM4k7Voxm6YnX2YzpbF4tJKbAjuo3V+wvhDdMp06txga9gSJdzaQ0ArfpximoZDY8rND+T6UWCS7SF1Jv0AEKMMz+p3t/+n87RKF/tI3Dcl9emMMCdUL6iMIZimL1lbL3RDVIGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216748; c=relaxed/simple;
	bh=PVWSzQsCuzhIQraDNHBUSRWbizU7d5//fml+dTGSHko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rzo3luo4kq2kaO+m69E5kFDCFD065ZVML9cvJHbVnuZYncnDvIajTDHdWRRJ/IlStrlgjrAtYO4vf5J2qcc0ugpPTO3ik7z+ge9AyKbB7yNCtjVjjD59NNydYa4u67TzjxbFiIm4aUcAikoArUk3eZ0qsVSQ6KdAVuSFHjfysk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1mBRpXY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267bf596so1423895a91.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216746; x=1755821546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pVdj1r2b9ebCmTm8plsT1ommEw0GDtpTKl01m2bkq3Q=;
        b=I1mBRpXYmzpTElUrzsKxeqOlFdytnv9oWYsRbUcgq6c2VG/Cbx8jGGY3TICHbQnEgz
         4VdsRsxLt9lpUhzVUSOzvyXJFNJha/2DBzV191Y6uCFtprVX/+BAmVslOdQDpX3PqAVj
         8dHs7wP4eeypyCzclJxsaJoKWRuGoBWaAkKsuShNSrACEWUZodcu0NpRDe2bQRZDwoc7
         fcBCV2b6PjW7nnAb4K1ALv66PDBVwZ9ShRJIDgUYdZhZ8jpZqq2JqoRkL0V/eGFtMaJT
         BB9aKEMHGgdKiRjEf+FpL8ikGPiYfXFVip0avrvj0n3mRRTBDSLytQKzTzDfCo6On8HN
         zILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216746; x=1755821546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVdj1r2b9ebCmTm8plsT1ommEw0GDtpTKl01m2bkq3Q=;
        b=aNSWZY6PRlpY5FunR5CEl/bkxuENjca3aWWWmnVE7woOjYhpkXTTpTs620dOCyEpXy
         6x3/LD0zWoiNGI/yyfvJ8yHC27iN5SRTnS6Bq8DQjNZ78n7LUo/28BDAHodr0XrCOfVM
         1fCTXve+kq8tJXkJsf6myxQ79sNPdOQaUlVcaycai0MH+dDtSCHOyTutKrhF8+sCpncB
         EAie1uxL2JuG61lCYjYeNTJpCudckghWsL9WYtyg0EEYStKO7lWNyaSBt+QLbEe1eNs6
         EF6kxkxYXmvQkBEwTFPzDU2cNS/c0hadoxb9G+lIeTihtVAGDiUWafbo6piwhZXri6V0
         NAKg==
X-Gm-Message-State: AOJu0YxeH7ZnDMyCeyWMUCYuSIeVNDHxhAogTKNZchXJIXXAuMHoWRT4
	T2th8UNxaO80pms6UZUQsTvhVNX85sT3XVRiCrWxO1KrVdNx90APBuTtAQM6oEHx9MCybIq5da2
	lWmwIrUT0ZaefdJwwjEOKCmP7pNjwbSU1cLWsze3CDn0LQpwzkaAg6L3zlOyMy9u96cVzbU9vuA
	krqQTMnbl+G0Kllb7a3i0YWRI0PcuMZTj3FqrP
X-Google-Smtp-Source: AGHT+IHCdltiMGoEmzO852wzwsXGl3QojD4i2zmqNtHwTNCqS6gRwntRjdN0Liw8X0G78BCwZg+gEODIk28=
X-Received: from pjbsj7.prod.google.com ([2002:a17:90b:2d87:b0:312:15b:e5d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f88:b0:31e:cdfb:5f1f
 with SMTP id 98e67ed59e1d1-32341e11c6amr338244a91.14.1755216746371; Thu, 14
 Aug 2025 17:12:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:52 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-9-seanjc@google.com>
Subject: [PATCH 6.1.y 08/21] KVM: x86/pmu: Gate all "unimplemented MSR" prints
 on report_ignored_msrs
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

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
Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
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
index b922f31d1415..2c0f9c7d1242 100644
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
index c24da2cff208..390af16d9a67 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2140,9 +2140,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
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
index 0c3908544205..e7c73360890d 100644
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
2.51.0.rc1.163.g2494970778-goog


