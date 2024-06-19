Return-Path: <stable+bounces-53876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E97390EB9C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343D61C216F4
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70514A615;
	Wed, 19 Jun 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQ2G2RMN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B2149DFC;
	Wed, 19 Jun 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801934; cv=none; b=e3tEq3Wm21sg4xo098oF3aCWE/bYTf37IckiJ29umwLTh7ZE9tBu1/BwaiM249thXPg9/uB65j1rJtC3bDbIappbby7Nl2L/dnfzSnmYDJn/A+/IUUH2b//CCFnVxc4m6GPXud3LQ91oCXMM1DZ3P5/MiEiqeJNNrKiDyJ10T8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801934; c=relaxed/simple;
	bh=JYpMuuXO0EAlCRs2YDxp4qTqUzQl661rUHgdUsr6/Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqBGQsCBelz8RMnsHo/wQxX6RzfoBxSCp5pIPiclqOYH+8x70NJOaCjYbrMjTRCxA46QhhI7PYBTFXhtAeTdRIDw/EhND/VsPMd/nCF/9eSfMUArvhB93kas2bVNnP816fwyi4LVqCgEgHCrI0FYn0GpS2b8R1oMftDdvNBLmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQ2G2RMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A3CC4AF49;
	Wed, 19 Jun 2024 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718801933;
	bh=JYpMuuXO0EAlCRs2YDxp4qTqUzQl661rUHgdUsr6/Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQ2G2RMNcgm6L3zUNTl+rNc/wWC0wjRJhPmCOUwpEwxtct4Z1IXZ7T5K8IjSFCqgD
	 pSbncRcRufwLzzYJDzxXdkvhFYFSljsPBRlBOpx3ZnvB09EoTuqEVwFGfAV/bpFer9
	 jyjdtlZQ4fL1mE4xj5lxaR4wjOrQRXEVQaezrp+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikunj A Dadhania <nikunj@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 026/267] KVM: SEV-ES: Delegate LBR virtualization to the processor
Date: Wed, 19 Jun 2024 14:52:57 +0200
Message-ID: <20240619125607.366856126@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@amd.com>

[ Upstream commit b7e4be0a224fe5c6be30c1c8bdda8d2317ad6ba4 ]

As documented in APM[1], LBR Virtualization must be enabled for SEV-ES
guests. Although KVM currently enforces LBRV for SEV-ES guests, there
are multiple issues with it:

o MSR_IA32_DEBUGCTLMSR is still intercepted. Since MSR_IA32_DEBUGCTLMSR
  interception is used to dynamically toggle LBRV for performance reasons,
  this can be fatal for SEV-ES guests. For ex SEV-ES guest on Zen3:

  [guest ~]# wrmsr 0x1d9 0x4
  KVM: entry failed, hardware error 0xffffffff
  EAX=00000004 EBX=00000000 ECX=000001d9 EDX=00000000

  Fix this by never intercepting MSR_IA32_DEBUGCTLMSR for SEV-ES guests.
  No additional save/restore logic is required since MSR_IA32_DEBUGCTLMSR
  is of swap type A.

o KVM will disable LBRV if userspace sets MSR_IA32_DEBUGCTLMSR before the
  VMSA is encrypted. Fix this by moving LBRV enablement code post VMSA
  encryption.

[1]: AMD64 Architecture Programmer's Manual Pub. 40332, Rev. 4.07 - June
     2023, Vol 2, 15.35.2 Enabling SEV-ES.
     https://bugzilla.kernel.org/attachment.cgi?id=304653

Fixes: 376c6d285017 ("KVM: SVM: Provide support for SEV-ES vCPU creation/loading")
Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Message-ID: <20240531044644.768-4-ravi.bangoria@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 13 ++++++++-----
 arch/x86/kvm/svm/svm.c |  8 +++++++-
 arch/x86/kvm/svm/svm.h |  3 ++-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f809dcfacc8a3..99e72b8a96ac0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -664,6 +664,14 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
 	  return ret;
 
 	vcpu->arch.guest_state_protected = true;
+
+	/*
+	 * SEV-ES guest mandates LBR Virtualization to be _always_ ON. Enable it
+	 * only after setting guest_state_protected because KVM_SET_MSRS allows
+	 * dynamic toggling of LBRV (for performance reason) on write access to
+	 * MSR_IA32_DEBUGCTLMSR when guest_state_protected is not set.
+	 */
+	svm_enable_lbrv(vcpu);
 	return 0;
 }
 
@@ -3035,7 +3043,6 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm)
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	svm->vmcb->control.nested_ctl |= SVM_NESTED_CTL_SEV_ES_ENABLE;
-	svm->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
 
 	/*
 	 * An SEV-ES guest requires a VMSA area that is a separate from the
@@ -3087,10 +3094,6 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm)
 	/* Clear intercepts on selected MSRs */
 	set_msr_interception(vcpu, svm->msrpm, MSR_EFER, 1, 1);
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_CR_PAT, 1, 1);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHFROMIP, 1, 1);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP, 1, 1);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTFROMIP, 1, 1);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP, 1, 1);
 }
 
 void sev_init_vmcb(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 08f1397138c80..e3c2acc1adc73 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -99,6 +99,7 @@ static const struct svm_direct_access_msrs {
 	{ .index = MSR_IA32_SPEC_CTRL,			.always = false },
 	{ .index = MSR_IA32_PRED_CMD,			.always = false },
 	{ .index = MSR_IA32_FLUSH_CMD,			.always = false },
+	{ .index = MSR_IA32_DEBUGCTLMSR,		.always = false },
 	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
 	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
 	{ .index = MSR_IA32_LASTINTFROMIP,		.always = false },
@@ -1008,7 +1009,7 @@ void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 	vmcb_mark_dirty(to_vmcb, VMCB_LBR);
 }
 
-static void svm_enable_lbrv(struct kvm_vcpu *vcpu)
+void svm_enable_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -1018,6 +1019,9 @@ static void svm_enable_lbrv(struct kvm_vcpu *vcpu)
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTFROMIP, 1, 1);
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP, 1, 1);
 
+	if (sev_es_guest(vcpu->kvm))
+		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_DEBUGCTLMSR, 1, 1);
+
 	/* Move the LBR msrs to the vmcb02 so that the guest can see them. */
 	if (is_guest_mode(vcpu))
 		svm_copy_lbrs(svm->vmcb, svm->vmcb01.ptr);
@@ -1027,6 +1031,8 @@ static void svm_disable_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	KVM_BUG_ON(sev_es_guest(vcpu->kvm), vcpu->kvm);
+
 	svm->vmcb->control.virt_ext &= ~LBR_CTL_ENABLE_MASK;
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHFROMIP, 0, 0);
 	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP, 0, 0);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index fb0ac8497fb20..37ada9808d9b5 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -30,7 +30,7 @@
 #define	IOPM_SIZE PAGE_SIZE * 3
 #define	MSRPM_SIZE PAGE_SIZE * 2
 
-#define MAX_DIRECT_ACCESS_MSRS	47
+#define MAX_DIRECT_ACCESS_MSRS	48
 #define MSRPM_OFFSETS	32
 extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
 extern bool npt_enabled;
@@ -542,6 +542,7 @@ u32 *svm_vcpu_alloc_msrpm(void);
 void svm_vcpu_init_msrpm(struct kvm_vcpu *vcpu, u32 *msrpm);
 void svm_vcpu_free_msrpm(u32 *msrpm);
 void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
+void svm_enable_lbrv(struct kvm_vcpu *vcpu);
 void svm_update_lbrv(struct kvm_vcpu *vcpu);
 
 int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer);
-- 
2.43.0




