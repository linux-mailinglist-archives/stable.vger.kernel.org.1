Return-Path: <stable+bounces-169673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3FDB273E4
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BFE602967
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2C21A95D;
	Fri, 15 Aug 2025 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbeUOkhp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE51217719
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217572; cv=none; b=D84a3IQrLtN7dzDO0JjukIFkpVbTk6ZQIHDJ1/AgW9rKMLwncmzfJAhA5ap+FqvllS+rFrZWt5eMj4s5oyXXh3tn5zquVczggi7YQL63QkqPgeno4OGHcK3+tuIcFwLpLco4N5GEkic/2xCLf17ebJo8VIKOabonW1i3wz8EBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217572; c=relaxed/simple;
	bh=G23S4kNqIwEsQRVADerKeIDf6O0t9XWndToh77VNu98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LtUUlj4vTYP7TTBw/x1qjEXkF/OBp7pC7x1ClUDgmAP7gCFDYxW+RmWCXONoVFlS1Dz77hnK71SDYJ8exkQG4lPVkzVZa5dL27XJQ2uOyv9wVv05R1J534MuVCusQQEfKyVF1CPopcIbvrQZVuFnS/GB2oAfMnn9FRxJucoM8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbeUOkhp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581950a1so17287005ad.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217571; x=1755822371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=b3Ex4BhCqTclsBZTxw66rQdaiSPLXQ9JFOBRn+0+cL0=;
        b=PbeUOkhpePpwYnZqfaBuaiH9/Zud3XFYKddKTe09RnEUBPjK/9f5HUsweRlyR9FA6k
         qQu/vuciFeWEPuqdxENoTmqdnGWMALqphJ3YkWujEpd0bxLTAXRopAZT13umZ5npEzG8
         GpCEqtL/EcwN3CIJJo8pZ84Joic2qMPSSC3RoA29m+MpLHkWUHHEpjxPlESnJ0B6TgVu
         H+e/CUhTZnLGyIQKQyuq1cBOtTzfzWJXr29dUmQTfo7lNWJlzVtY9dftAZ0Q8eUCUztS
         i25723vYPYu4pldgPsyul36uVDMslMTntLPQbvAv6bPCImf0nagYS0o9BLyMmw9jZ247
         VR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217571; x=1755822371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3Ex4BhCqTclsBZTxw66rQdaiSPLXQ9JFOBRn+0+cL0=;
        b=FgY70x3Bfm0mfmW2VHTCAUzpER19vfn3aKQiLmG4KMZuwTUE/d36a8LYtvUJZxxSxp
         vuoCVwdOi0UtKgqe1NRR9mB+zvA0AShcSytimoiP0xIR80S/v5zfkhsiOsgqyAIr8WuK
         7yGsq3Pk7uZBy2IylO55t/0Xi53mI1XISIVtusQ6FKWrkO/iMunDMiykghonLfXHvLG2
         DRFlgw2353k9SeqfNxsXr69IiGSVROZbFWLekJpvMuCyM5DehnL/ZiU/h3X2JXpWjJ4y
         NlUtzLx1ZcreICpihtKVWUSNF3iaInjGdXtYsregdGmao3+1ilhlSiJpFvkx6nnPCIbf
         Purg==
X-Gm-Message-State: AOJu0Ywh4E9N9P9RUS1d9nqulJzwg18Q2Dk7UVdWjMLIk06DQ0enyLrY
	iyuWXn4UcBmUP6Gc1HAojuMpuqrC1+Nf7kNiWUOvLVLSeqK5OvT4CsAkqNiaFr3HiVpnT+YTKZ5
	C9/N855WrjKMkM6OH2C0Gj9ehK4zsbRTXitkv+wUDamrHaoKUKu4G5mySOPSKTjsa8nwRiZ1SNN
	8tzDveV1ka84QyixzR0JzuTAb0AhL6gecYkEPI
X-Google-Smtp-Source: AGHT+IEVbOY5aRbEI6Ttg/wSMQ7ASZVe+c20PkZNWtxZFSYT5D7jsz8719NZTSboYv5vr3CpWFkKtdeI4mE=
X-Received: from plhq10.prod.google.com ([2002:a17:903:11ca:b0:23f:fd13:e74d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f708:b0:234:c8ec:51b5
 with SMTP id d9443c01a7336-2446d9a0045mr1553265ad.53.1755217570536; Thu, 14
 Aug 2025 17:26:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:34 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-15-seanjc@google.com>
Subject: [PATCH 6.6.y 14/20] KVM: x86: Convert vcpu_run()'s immediate exit
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
[sean: drop TDX crud, account for lack of kvm_x86_call()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  6 +++++-
 arch/x86/kvm/svm/svm.c          |  4 ++--
 arch/x86/kvm/vmx/vmx.c          |  3 ++-
 arch/x86/kvm/x86.c              | 10 ++++++++--
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8898ad8cb3de..aa6d04cd9ee6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1550,6 +1550,10 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 }
 
+enum kvm_x86_run_flags {
+	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
+};
+
 struct kvm_x86_ops {
 	const char *name;
 
@@ -1625,7 +1629,7 @@ struct kvm_x86_ops {
 
 	int (*vcpu_pre_run)(struct kvm_vcpu *vcpu);
 	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu,
-						  bool force_immediate_exit);
+						  u64 run_flags);
 	int (*handle_exit)(struct kvm_vcpu *vcpu,
 		enum exit_fastpath_completion exit_fastpath);
 	int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4a53b38ea386..61e5e261cde2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4197,9 +4197,9 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
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
index 704e5a552b4f..065aac2f4bce 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7345,8 +7345,9 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	guest_state_exit_irqoff();
 }
 
-static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
+static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
+	bool force_immediate_exit = run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long cr3, cr4;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 44784ad244c6..342e666a0d13 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10518,6 +10518,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		dm_request_for_irq_injection(vcpu) &&
 		kvm_cpu_accept_dm_intr(vcpu);
 	fastpath_t exit_fastpath;
+	u64 run_flags;
 
 	bool req_immediate_exit = false;
 
@@ -10750,8 +10751,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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
@@ -10787,7 +10791,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		WARN_ON_ONCE((kvm_vcpu_apicv_activated(vcpu) != kvm_vcpu_apicv_active(vcpu)) &&
 			     (kvm_get_apic_mode(vcpu) != LAPIC_MODE_DISABLED));
 
-		exit_fastpath = static_call(kvm_x86_vcpu_run)(vcpu, req_immediate_exit);
+		exit_fastpath = static_call(kvm_x86_vcpu_run)(vcpu, run_flags);
 		if (likely(exit_fastpath != EXIT_FASTPATH_REENTER_GUEST))
 			break;
 
@@ -10799,6 +10803,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			break;
 		}
 
+		run_flags = 0;
+
 		/* Note, VM-Exits that go down the "slow" path are accounted below. */
 		++vcpu->stat.exits;
 	}
-- 
2.51.0.rc1.163.g2494970778-goog


