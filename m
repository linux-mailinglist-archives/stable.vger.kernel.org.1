Return-Path: <stable+bounces-204315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB4BCEB2E2
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 04:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A223008894
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 03:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4996916EB42;
	Wed, 31 Dec 2025 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu6FxblG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078183C0C
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767151041; cv=none; b=GJZfqvHWMFDPkl6qiyoIMK2Yh9hfdZvYKzIb86FPvT9CNHJmjO54WAcBHsuUhvSI2mvBGX3Gfp6ux5UXkkKTteS4BKOY6EHwG1NdTX8IuMFuBkar76flYymGYWWM6yUzFgOW2q/2OTVUWipyPMNum1m4IAIRX6u+9aUAsi6F9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767151041; c=relaxed/simple;
	bh=Ixt0zNucFcSgeEKI/HbVK3RWfE46kob6XFN+kZPkgEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bfy+ilpJlzax5dxcxI5ovy/NQDigSZoQCOvloR6V4UsH1lY7wC1Trupvay3vsWFQPEkeLQrzODT9FprgZ6bZkayvdkNSdKGviQy23Z8BACmSVns9byg8UW0CFc2JAWk/ak/UjRXv3U2EKdP0YhA7xjFV8rjrRRVvsTzHDQ3ghCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu6FxblG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F22FC116B1;
	Wed, 31 Dec 2025 03:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767151040;
	bh=Ixt0zNucFcSgeEKI/HbVK3RWfE46kob6XFN+kZPkgEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hu6FxblGfpFXtk0McP1gQBQrHs7BoQbJEkwKnxaCO2/HUneh13oFLAoeiTfmrOIEj
	 VliomldFbsC05g2hVAs5JQv+VCJ15Y0BujaoEYOWDm2k00SeyjYvLqJv6mPXJgUyw7
	 bCVR8nDWh0FtHSACScpAU/q9xVkZLD+ZBQKjJcTIjNp4pVUKTC8+9BitTxeFJpFf8d
	 xlbE70tzSo4mhPYi9RqfNFy6Z9Yu2Xvs5OQviguVkX/vPBGOdS3vVhMYOkTsWcJIr7
	 RcZHya4UMQCt9+rQExNM0ru2KVxnjndl5C65ic4gpja8C0k9SIcH07KIq/YWfLxaIf
	 +01TNs/fk0M+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
	Chao Gao <chao.gao@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: nVMX: Immediately refresh APICv controls as needed on nested VM-Exit
Date: Tue, 30 Dec 2025 22:17:17 -0500
Message-ID: <20251231031717.2685182-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122927-delegate-composed-5765@gregkh>
References: <2025122927-delegate-composed-5765@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit 29763138830916f46daaa50e83e7f4f907a3236b ]

If an APICv status updated was pended while L2 was active, immediately
refresh vmcs01's controls instead of pending KVM_REQ_APICV_UPDATE as
kvm_vcpu_update_apicv() only calls into vendor code if a change is
necessary.

E.g. if APICv is inhibited, and then activated while L2 is running:

  kvm_vcpu_update_apicv()
  |
  -> __kvm_vcpu_update_apicv()
     |
     -> apic->apicv_active = true
      |
      -> vmx_refresh_apicv_exec_ctrl()
         |
         -> vmx->nested.update_vmcs01_apicv_status = true
          |
          -> return

Then L2 exits to L1:

  __nested_vmx_vmexit()
  |
  -> kvm_make_request(KVM_REQ_APICV_UPDATE)

  vcpu_enter_guest(): KVM_REQ_APICV_UPDATE
  -> kvm_vcpu_update_apicv()
     |
     -> __kvm_vcpu_update_apicv()
        |
        -> return // because if (apic->apicv_active == activate)

Reported-by: Chao Gao <chao.gao@intel.com>
Closes: https://lore.kernel.org/all/aQ2jmnN8wUYVEawF@intel.com
Fixes: 7c69661e225c ("KVM: nVMX: Defer APICv updates while L2 is active until L1 is active")
Cc: stable@vger.kernel.org
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
[sean: write changelog]
Link: https://patch.msgid.link/20251205231913.441872-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ exported vmx_refresh_apicv_exec_ctrl() and added declaration in vmx.h ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 arch/x86/kvm/vmx/vmx.c    | 2 +-
 arch/x86/kvm/vmx/vmx.h    | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e28f52f525e0..70b55267ea71 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4684,7 +4684,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 
 	if (vmx->nested.update_vmcs01_apicv_status) {
 		vmx->nested.update_vmcs01_apicv_status = false;
-		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
+		vmx_refresh_apicv_exec_ctrl(vcpu);
 	}
 
 	if ((vm_exit_reason != -1) &&
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ab3098ea4ebd..cc8e4bc596ff 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4217,7 +4217,7 @@ static u32 vmx_vmexit_ctrl(void)
 		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
 }
 
-static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
+void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index a1792d96618a..9842f6833929 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -386,6 +386,7 @@ void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
 
 bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu);
+void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
 bool vmx_nmi_blocked(struct kvm_vcpu *vcpu);
 bool __vmx_interrupt_blocked(struct kvm_vcpu *vcpu);
-- 
2.51.0


