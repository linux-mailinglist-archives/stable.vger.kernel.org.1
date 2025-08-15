Return-Path: <stable+bounces-169683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93DB27454
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8361CC006C
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA361A08B8;
	Fri, 15 Aug 2025 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9UJZWLA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FD18A6AD
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219455; cv=none; b=tBT84WI52z/Zz8NG+Sw4ILbSgag6WCihRjojJdGcE/69pWl70qq4QimG6hekqhxN21jmWTHdSs46mAnTV4l5SDAOgoF2JITtLsPqdpdixzho+6ORB/FF5oY1Mrgb+wIbMnZ+DdQkoRF49Nx8dha003O0y4RMwQcpkpoYvJAE06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219455; c=relaxed/simple;
	bh=CEVBW4WVbt8Lnu/3tYJRzLW233Zr94AiOicIUItOI/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q1n1hLuyD6m2N8Ow8Cuy18xIN2VKcWUGxeIhnBb7XVvUAsOOYLJTZPfOzmn7RQw37BLoy1OrRUMtgQ1TEnNRZWe0i00kwDbLSzua5dDSP8B+jefD0dczBrBCy4yf0SwkFnK6C0Ht6slzxQhzEfsnccz3zoORZ/cBKbfqEXpLd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9UJZWLA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f440f0so15274915ad.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755219453; x=1755824253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0uUsJ4w557iIRI1+Xq47LADMF7Kam5FO29De9FYVnNM=;
        b=W9UJZWLAJNI+BfwSzOJ62BgM/aTO8sA/dxQh7bz56/fg3qH5m+bKaV2Cci5Lav638t
         2KZhvZHFRIsyXXoAwrMrTM9lCXfX9NlW3wAuBqeTffg5jed2TlE7MerMlIyMQeVBpw8J
         AlneuABJ7PceUJNHNJcYjiuvN/LHYGxctmicVcm9FRcEZ+VlFqa4lpt7Q0y9H1W5D3+t
         xBjzR9YGjx4VWm+bluVzYTazO+/133a0SZXVenRDShJpTcDjxDUUPqRoO2omaIn2n22+
         XlQb6AHzj4AT1jWHzH80TMbglu2h8UOc9apBJi/oRtxQF8PgNdYVgCKwasCunJnlLGOq
         0j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755219453; x=1755824253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uUsJ4w557iIRI1+Xq47LADMF7Kam5FO29De9FYVnNM=;
        b=eqj0A+iwtWy/R9A+YP2HSdIJqb8EtQocXHZEFJvoFL8TLK+0B33NHpx7OoJoDPk/51
         o16t/DlzsnWX6gqbIRRsq3aBS8CcKVzJMQfli6GOXQ/NCOMpXCxxIz0BOXLhzs2//OvN
         dHdBrma2XNMx4IPD2sl543V4FASqZhmq9vAQQKtu5In2Y7vEPJU2gI6XQr9QOo/h1ml/
         P6bd06bDU8aQLzoJmid6eW3pzwqRG4zExqpKGR1sGdrDg40DJ6Q7Nx7FyuBZ+bZW+n0Y
         XfjGLoA1nArSIT/O6n3g59zE5Nt46SYR5rPgfYsf8YutQMCyM/UN5iBmJf1KlT/5Zz3O
         0T0g==
X-Gm-Message-State: AOJu0YyuJG+h41RLPf/G3A70/fz4B1XTMiq7l29J637AQ4xL7JDs0tgp
	/cIxIZojj6tn4ao/4/K/ayaJHGwvZuJu3d7Gqmq+OKHoCUU6MLTaSmEyMyWEIglQQp0oJ//YPwf
	GJy+8VdVOoCHWTb2mnGMBarBqWdAo0+MTYebIIePn74jt6Xm3C0dYf5S+ieMCUZR8OaeOUqr+p6
	+MC347v4wII7pSXQlfFvBGOqBjQONJKPLZsl8S
X-Google-Smtp-Source: AGHT+IFWenSfmvpmGV9Uvy5VzE86vLvZMuLNMRdB3X6t/lZx2YcZPhmYgNcEp3Mb/9LKOQ1XlpftJN6lvyM=
X-Received: from pjbqc5.prod.google.com ([2002:a17:90b:2885:b0:31c:4a51:8b75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84b:b0:240:5523:6658
 with SMTP id d9443c01a7336-2446d89d22cmr3619125ad.29.1755219452737; Thu, 14
 Aug 2025 17:57:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:57:20 -0700
In-Reply-To: <20250815005725.2386187-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815005725.2386187-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815005725.2386187-3-seanjc@google.com>
Subject: [PATCH 6.12.y 2/7] KVM: x86: Drop kvm_x86_ops.set_dr6() in favor of a
 new KVM_RUN flag
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 80c64c7afea1da6a93ebe88d3d29d8a60377ef80 ]

Instruct vendor code to load the guest's DR6 into hardware via a new
KVM_RUN flag, and remove kvm_x86_ops.set_dr6(), whose sole purpose was to
load vcpu->arch.dr6 into hardware when DR6 can be read/written directly
by the guest.

Note, TDX already WARNs on any run_flag being set, i.e. will yell if KVM
thinks DR6 needs to be reloaded.  TDX vCPUs force KVM_DEBUGREG_AUTO_SWITCH
and never clear the flag, i.e. should never observe KVM_RUN_LOAD_GUEST_DR6.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250610232010.162191-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[sean: drop TDX changes]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  2 +-
 arch/x86/kvm/svm/svm.c             | 10 ++++++----
 arch/x86/kvm/vmx/main.c            |  1 -
 arch/x86/kvm/vmx/vmx.c             |  9 +++------
 arch/x86/kvm/x86.c                 |  2 +-
 6 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index cfb22f8c451a..861d080ed4c6 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -47,7 +47,6 @@ KVM_X86_OP(set_idt)
 KVM_X86_OP(get_gdt)
 KVM_X86_OP(set_gdt)
 KVM_X86_OP(sync_dirty_debug_regs)
-KVM_X86_OP(set_dr6)
 KVM_X86_OP(set_dr7)
 KVM_X86_OP(cache_reg)
 KVM_X86_OP(get_rflags)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cccc8cbe72db..2ed05925d9d5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1629,6 +1629,7 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 
 enum kvm_x86_run_flags {
 	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
+	KVM_RUN_LOAD_GUEST_DR6		= BIT(1),
 };
 
 struct kvm_x86_ops {
@@ -1679,7 +1680,6 @@ struct kvm_x86_ops {
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
-	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d1b871cfc02..800f781475c0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4270,10 +4270,13 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	svm_hv_update_vp_id(svm->vmcb, vcpu);
 
 	/*
-	 * Run with all-zero DR6 unless needed, so that we can get the exact cause
-	 * of a #DB.
+	 * Run with all-zero DR6 unless the guest can write DR6 freely, so that
+	 * KVM can get the exact cause of a #DB.  Note, loading guest DR6 from
+	 * KVM's snapshot is only necessary when DR accesses won't exit.
 	 */
-	if (likely(!(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)))
+	if (unlikely(run_flags & KVM_RUN_LOAD_GUEST_DR6))
+		svm_set_dr6(vcpu, vcpu->arch.dr6);
+	else if (likely(!(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)))
 		svm_set_dr6(vcpu, DR6_ACTIVE_LOW);
 
 	clgi();
@@ -5084,7 +5087,6 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
-	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
 	.cache_reg = svm_cache_reg,
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 47476fcc179a..7668e2fb8043 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -60,7 +60,6 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
-	.set_dr6 = vmx_set_dr6,
 	.set_dr7 = vmx_set_dr7,
 	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
 	.cache_reg = vmx_cache_reg,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2a977cdfcd0c..b9c7940feac6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5630,12 +5630,6 @@ void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	set_debugreg(DR6_RESERVED, 6);
 }
 
-void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
-{
-	lockdep_assert_irqs_disabled();
-	set_debugreg(vcpu->arch.dr6, 6);
-}
-
 void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	vmcs_writel(GUEST_DR7, val);
@@ -7400,6 +7394,9 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		vmcs_writel(GUEST_RIP, vcpu->arch.regs[VCPU_REGS_RIP]);
 	vcpu->arch.regs_dirty = 0;
 
+	if (run_flags & KVM_RUN_LOAD_GUEST_DR6)
+		set_debugreg(vcpu->arch.dr6, 6);
+
 	/*
 	 * Refresh vmcs.HOST_CR3 if necessary.  This must be done immediately
 	 * prior to VM-Enter, as the kernel may load a new ASID (PCID) any time
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 44ab46f2a2d2..7beea8fb6ea6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10977,7 +10977,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(vcpu->arch.eff_db[3], 3);
 		/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
 		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-			kvm_x86_call(set_dr6)(vcpu, vcpu->arch.dr6);
+			run_flags |= KVM_RUN_LOAD_GUEST_DR6;
 	} else if (unlikely(hw_breakpoint_active())) {
 		set_debugreg(DR7_FIXED_1, 7);
 	}
-- 
2.51.0.rc1.163.g2494970778-goog


