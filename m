Return-Path: <stable+bounces-204363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FB7CEC26D
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59792300485A
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53D3285CB3;
	Wed, 31 Dec 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbMZXJmD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188C27465C
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767193916; cv=none; b=P6sbW80vZo767YoqyZ2c46jrVfIFdNWSkllYSoTBSm3uQcSeOhU01gN1Vf+0+hTedue1l3N8J9dDD7z8juXtXXSDlx1fLWk3uutIRv/XaHAzD77mcRlhEFV7uDTRGncHK7Zg63bOj4Xgo17ufQahMZwoEikdlkvFfM/YXYlSXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767193916; c=relaxed/simple;
	bh=KUyO3/Dx2b1WTQLSnIwDw0B373hmWcExHQ8xJmFOkng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgPtauKgg4e7Y8/BnfReB0PWu98rjyPV+6HfjJTFJJo6uuNo6f6QdCkSaVbDg1d8pzkrfPtfTxigqU3szKjpks2SHMUEOCJ4Aw5agJ353IoKIuWBCwloLW/Q+LPKUZHurQ9f4y4NpnvykASOimBjB+JaMfrViYC0tiKp8lF2vsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbMZXJmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A15C113D0;
	Wed, 31 Dec 2025 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767193915;
	bh=KUyO3/Dx2b1WTQLSnIwDw0B373hmWcExHQ8xJmFOkng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbMZXJmDVfXTOs8HHc+tBZCPjo0T6L7lJMLrs9v7h9h/l0wQ0/LcOTngwCqQNq1Mz
	 Y1Y1wACL44zCHEMq2n3kR9tZl88uE1kobrDzpu5sKhuW5HKrAVOynre67efztnMAe3
	 XjQu150RBJQ/+Zj555N1tq6aCzsT1Yc3VXBw0LZddW+Ygg/YwYbJgLI/H/Qxf0SNBz
	 uZdEvNBsEx2ovzQb+NB91TNYi8S38ZZ1BDqX4zFFPise5oFzta3QSCd52K4BuyHYfp
	 SIxQdmEzGLmpkPYfP8F78GqYjO86FcppUDrGtOfWtMFg7kswVQ2cCYBKykVh3rcCA1
	 q0nbC5HXWskrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
	Chao Gao <chao.gao@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: nVMX: Immediately refresh APICv controls as needed on nested VM-Exit
Date: Wed, 31 Dec 2025 10:11:53 -0500
Message-ID: <20251231151153.3146021-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122926-gigabyte-rectangle-0c68@gregkh>
References: <2025122926-gigabyte-rectangle-0c68@gregkh>
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
index 2c3cf4351c4c..bdc462944cb0 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4847,7 +4847,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 
 	if (vmx->nested.update_vmcs01_apicv_status) {
 		vmx->nested.update_vmcs01_apicv_status = false;
-		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
+		vmx_refresh_apicv_exec_ctrl(vcpu);
 	}
 
 	if (vmx->nested.update_vmcs01_hwapic_isr) {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 22e4c9bbbcb4..ebdc86030a7a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4387,7 +4387,7 @@ static u32 vmx_vmexit_ctrl(void)
 		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
 }
 
-static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
+void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc6f06326648..59c304dd51e6 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -408,6 +408,7 @@ void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
 
 bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu);
+void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
 bool vmx_nmi_blocked(struct kvm_vcpu *vcpu);
 bool __vmx_interrupt_blocked(struct kvm_vcpu *vcpu);
-- 
2.51.0


