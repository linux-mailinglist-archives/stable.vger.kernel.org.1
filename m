Return-Path: <stable+bounces-169682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CB5B27452
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0705C73E3
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAEB17B425;
	Fri, 15 Aug 2025 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8NtLdbL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F61419A9
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219453; cv=none; b=nVP8EgHI9HIBJnC8Tfe5QIPLR06ya5oYilozNNPITpzM5cIQsNvlhARizZuGFTd0/rWbSrmR3cwo+mpa94dIAnqHgBXo4GtTO+4/AEvgo/OQnIqMAfl+A4qLqYyODFyI7d5aeMPk7HbacPxHqLVNud1FhePJa7TcLRqzz+Cxppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219453; c=relaxed/simple;
	bh=usJ3ZMZnwNFZX0+CIa7aY1rGEPIY4X/4s0T7MhIPUac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M6VEW7Hd1vOvHGZtRsmrUXkFIS9xtY+oz4PGvbp71ENg876NLRj4yVXZ1Hv5ERkWiibHF4+8DZRT4niCRpuKXFLIjTSCIOZOoYwiEx4IeJNZm8S/d2fPYMQtL+HgTs7G0mldpLFN6v12cmcq1uatYrjTRS3nhxsuoaNoLc2WyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8NtLdbL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445806dc88so33362195ad.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755219451; x=1755824251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=T8isbf31D4yLNs22AviaosgvI5FbO42vVP/HzHMq/CI=;
        b=p8NtLdbLvljn8meKiIyW6oj099sri+49XGOvViFZ5rkRaME0KBJbNGTFDn6MxcgS0r
         2pwTlkYyvPuoxP+Y7wGJAlaALu2jucybXuxiuGk6ooTMnCPAD08z4qSmTe81s2y6KDhG
         1HzkFrRfWdqlPpahsmeobPspVA6oz+qpMu3U1/k+UGFHNS3AwkLKEGFIk3HEM8xTNrrp
         2o4CPAo+ZPycySPAmRg3lgZ4BuWm0SwNrTRIKSjyNz+ew2QN/0QropcXOtoJd5EbEYFG
         cqeaSQshqcoqjjqW2oYxcOSCFISK3yqih+YgLLEKhvUlCcyLqkfSx9S39P0OWpgFjJAI
         Mmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755219451; x=1755824251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8isbf31D4yLNs22AviaosgvI5FbO42vVP/HzHMq/CI=;
        b=ujp8XZQ43lw420tmZua/fjNvDNeEM/H8SgDykaOImd5CBPhf29Cs4OLlGk2VhzCa4b
         biZAPv2RnG5OJBzJ7ma9XmK6UCoZ0atST4Xl8HVCMafOVpR/JbmsgXcXGQMs/mu6RcCp
         TrhpGOBb6D016RRLO+As0eO7sNZ8zMI+86OOy1REhiGcbeLXahKuwHna/8n7MhSaMfab
         5fDc/zUqfljWCug5rCwPj/Z+v5/fc/giRJTr9ivNKkKBSZExHFpSywVJza7GMpjbor5x
         gcsGt2uwo8acyuZYEOSqVCAC4j3VAgoSC45uUqly7pLalflDr3vkOHeOsqUW3KxLkKxD
         zEYQ==
X-Gm-Message-State: AOJu0YxU7RG4hmaD4u9TRTCSJba5RltYu3nTCka8RYdrpNmp6HmKupnA
	McoAqI64eYKGKFJLWl4AHB63Y8GQupnS8EkCw2x7mEjvprPtTredt8NJp/0netN5ZlZLLyb5SBe
	2/7XIlNCSmSkgcsQptIE4DMm5XKzgj+i3n2PDN7E73uBZflvDsu8FEMYEXZsg7LfuXXYUlVhqrx
	lNnonQ3n1DkYVs/2myUTUyVZZdDZ/NEkGuIUtO
X-Google-Smtp-Source: AGHT+IEniQwUVf1/FaYQXGQg/xMubHkAxjtQ6N1MTG2nHz/Y8QbMfCVqrFZ8y+7Me/fg7/Q+nX7IAGUOAn8=
X-Received: from plij7.prod.google.com ([2002:a17:903:3807:b0:23f:c627:bd6d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:950:b0:242:9bbc:c775
 with SMTP id d9443c01a7336-2446d987fb6mr3074675ad.56.1755219451015; Thu, 14
 Aug 2025 17:57:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:57:19 -0700
In-Reply-To: <20250815005725.2386187-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815005725.2386187-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815005725.2386187-2-seanjc@google.com>
Subject: [PATCH 6.12.y 1/7] KVM: x86: Convert vcpu_run()'s immediate exit
 param into a generic bitmap
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 2478b1b220c49d25cb1c3f061ec4f9b351d9a131 ]

Convert kvm_x86_ops.vcpu_run()'s "force_immediate_exit" boolean parameter
into an a generic bitmap so that similar "take action" information can be
passed to vendor code without creating a pile of boolean parameters.

This will allow dropping kvm_x86_ops.set_dr6() in favor of a new flag, and
will also allow for adding similar functionality for re-loading debugctl
in the active VMCS.

Opportunistically massage the TDX WARN and comment to prepare for adding
more run_flags, all of which are expected to be mutually exclusive with
TDX, i.e. should be WARNed on.

No functional change intended.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250610232010.162191-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[sean: drop TDX changes]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  6 +++++-
 arch/x86/kvm/svm/svm.c          |  4 ++--
 arch/x86/kvm/vmx/vmx.c          |  3 ++-
 arch/x86/kvm/vmx/x86_ops.h      |  2 +-
 arch/x86/kvm/x86.c              | 11 ++++++++---
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0caa3293f6db..cccc8cbe72db 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1627,6 +1627,10 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 }
 
+enum kvm_x86_run_flags {
+	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
+};
+
 struct kvm_x86_ops {
 	const char *name;
 
@@ -1706,7 +1710,7 @@ struct kvm_x86_ops {
 
 	int (*vcpu_pre_run)(struct kvm_vcpu *vcpu);
 	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu,
-						  bool force_immediate_exit);
+						  u64 run_flags);
 	int (*handle_exit)(struct kvm_vcpu *vcpu,
 		enum exit_fastpath_completion exit_fastpath);
 	int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1f42a71b15c0..7d1b871cfc02 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4226,9 +4226,9 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	guest_state_exit_irqoff();
 }
 
-static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
-					  bool force_immediate_exit)
+static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
+	bool force_immediate_exit = run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool spec_ctrl_intercepted = msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9a4ebf3dfbfc..2a977cdfcd0c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7353,8 +7353,9 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	guest_state_exit_irqoff();
 }
 
-fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
+fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
+	bool force_immediate_exit = run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long cr3, cr4;
 
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 4aba200f435d..5e4ce13ab305 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -21,7 +21,7 @@ void vmx_vm_destroy(struct kvm *kvm);
 int vmx_vcpu_precreate(struct kvm *kvm);
 int vmx_vcpu_create(struct kvm_vcpu *vcpu);
 int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu);
-fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit);
+fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags);
 void vmx_vcpu_free(struct kvm_vcpu *vcpu);
 void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 213af0fda768..44ab46f2a2d2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10711,6 +10711,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		dm_request_for_irq_injection(vcpu) &&
 		kvm_cpu_accept_dm_intr(vcpu);
 	fastpath_t exit_fastpath;
+	u64 run_flags;
 
 	bool req_immediate_exit = false;
 
@@ -10955,8 +10956,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		goto cancel_injection;
 	}
 
-	if (req_immediate_exit)
+	run_flags = 0;
+	if (req_immediate_exit) {
+		run_flags |= KVM_RUN_FORCE_IMMEDIATE_EXIT;
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
+	}
 
 	fpregs_assert_state_consistent();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
@@ -10992,8 +10996,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		WARN_ON_ONCE((kvm_vcpu_apicv_activated(vcpu) != kvm_vcpu_apicv_active(vcpu)) &&
 			     (kvm_get_apic_mode(vcpu) != LAPIC_MODE_DISABLED));
 
-		exit_fastpath = kvm_x86_call(vcpu_run)(vcpu,
-						       req_immediate_exit);
+		exit_fastpath = kvm_x86_call(vcpu_run)(vcpu, run_flags);
 		if (likely(exit_fastpath != EXIT_FASTPATH_REENTER_GUEST))
 			break;
 
@@ -11005,6 +11008,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			break;
 		}
 
+		run_flags = 0;
+
 		/* Note, VM-Exits that go down the "slow" path are accounted below. */
 		++vcpu->stat.exits;
 	}
-- 
2.51.0.rc1.163.g2494970778-goog


