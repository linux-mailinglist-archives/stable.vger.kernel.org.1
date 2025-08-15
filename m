Return-Path: <stable+bounces-169667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C093B273D7
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F023A79AC
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C001EBA0D;
	Fri, 15 Aug 2025 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJ+u/wfr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181ED288D6
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217560; cv=none; b=CgeMXOgWh2pKqZu23dmhNUJ4Ga0fhWxYST6OtuR6fH3vW2YxhnoGrOsnYinNd32xZQ78iR0AufeOG9umS/kVBpONnH3s1OeuF/bMDgFrF2SydggC8kV6MegxVKAOWncRZBl2LPG9nltejV6Nb1ygECsFmxXmgBrS1wT6awULuQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217560; c=relaxed/simple;
	bh=N+hql3Qr4kBwfjiSAYejuhjwWUlHg5QqNsL/k41/IO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vie0idUjRRuj3r+2b9slz5cR/etCUiq/wtzKKJ0p+h2mr9ZI49YEgzGpV39dJWLV9NvsLaYpqXlKgIueSgJoad0POmlmq0kmqF3uCN9vrb4/oEzree56NeIEHY2pbLouLnT9v9BizxbUYaw89Ur//fbJSv+eEElxlAOoNjJJEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJ+u/wfr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326bf571bso2631973a91.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217558; x=1755822358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+/m1fuxWS0xyuQHwloyFiYOa5AY97HguPjFiFhAvGns=;
        b=tJ+u/wfr+qxJYyRybfxo2H3Lb7RPV4btY0H0HWfpQebjiGt3G4eQXGhR7oPA67xwCD
         ztziQQjOiGcur9apKrYNN4AHpEwGD0Py2gYJLgtX/A+t9qLs93efW6vHiaSpjE01p1L2
         YIaeQoDLqVvaxtudeT9A6XH3dCPt8nLjUvGeraCC9hMwDqCepzOQ27UCUVnEfyQzpu6W
         C167Lgv0gIVWM26yeGU7ZaKMs3XQEr/x4YCKY/SQKFfPI2Da6NkL+6ozzvTVTDDLW13i
         lqcKB4kYktcEKGx7JKYcqeGMMT55lhvMQTDD6414sMHuf6V5Sbp0vhlEac2Z5l8NyiyG
         nBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217558; x=1755822358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/m1fuxWS0xyuQHwloyFiYOa5AY97HguPjFiFhAvGns=;
        b=YrcxgrSBVy+PGh2zdmkGA+felt2vEQ9cIKVHmpPnb+AMkZ3LhR7U6YIRejrYPLceXK
         Nnn68US3AGq6BOKM1ufJRXwp7ecO/rpZtuAg4KH7Qe1OjDsWv58MKOA4AV7C92YgtpTs
         A91MIq8SbBs6tN5bPVBlOUGRkM7iYFYDyB7LHi9xOQDF9AOaNOBbLQyEzTwGE+LZv9ve
         SAAdk1p/oYD5fKEDEgmbLh2mGehdv0O51lZcfRd0fxRWJ1LoDH/FUqzl1nXiNpxsViDo
         u8R9z9rVeJ0Il+Mu4L9V/fNqC0slIbexyuTkRjzpWesMI3GNcvxDPYSMmZTNr2e6A4Kp
         hBuQ==
X-Gm-Message-State: AOJu0YxBYyV2nvqzFdAOpupgKQSSfL0lHH4GUM8gFPBIsMb3+04q3grR
	52HprlXu5rogi5Zow7L2EWN738icb3lUarAZ1KHbveryUhTFWXoygQAoRr9d9INTZGzz2ZIdp1s
	NaKymsJE1upiaX/spBY/KBiuUjzdgOdJFg5+sSiROKeQ36d3dciGfEHIiBQF9lnvbB4KT0h8GJF
	zwjqM9MFCDM/JUx6vKFobF2A2iatRN9lXobN0T
X-Google-Smtp-Source: AGHT+IEfTFBHfHbYX85mwsEulWZDBhY4u6Mp7AGxTOZZ17dTGn++cm7gJ1lMfruySsop6YG+mNhLMBQzP4A=
X-Received: from pjboi8.prod.google.com ([2002:a17:90b:3a08:b0:321:90c5:fc2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2784:b0:31f:210d:2e56
 with SMTP id 98e67ed59e1d1-32341ef60bemr371333a91.28.1755217558217; Thu, 14
 Aug 2025 17:25:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:28 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-9-seanjc@google.com>
Subject: [PATCH 6.6.y 08/20] KVM: x86: Plumb "force_immediate_exit" into
 kvm_entry() tracepoint
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 9c9025ea003a03f967affd690f39b4ef3452c0f5 ]

Annotate the kvm_entry() tracepoint with "immediate exit" when KVM is
forcing a VM-Exit immediately after VM-Enter, e.g. when KVM wants to
inject an event but needs to first complete some other operation.
Knowing that KVM is (or isn't) forcing an exit is useful information when
debugging issues related to event injection.

Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20240110012705.506918-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 3 ++-
 arch/x86/kvm/svm/svm.c          | 5 +++--
 arch/x86/kvm/trace.h            | 9 ++++++---
 arch/x86/kvm/vmx/vmx.c          | 4 ++--
 arch/x86/kvm/x86.c              | 2 +-
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b5210505abfa..5703600a454e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1624,7 +1624,8 @@ struct kvm_x86_ops {
 	void (*flush_tlb_guest)(struct kvm_vcpu *vcpu);
 
 	int (*vcpu_pre_run)(struct kvm_vcpu *vcpu);
-	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu);
+	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu,
+						  bool force_immediate_exit);
 	int (*handle_exit)(struct kvm_vcpu *vcpu,
 		enum exit_fastpath_completion exit_fastpath);
 	int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index abbb84ddfe02..5a230be224d1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4194,12 +4194,13 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	guest_state_exit_irqoff();
 }
 
-static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
+static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
+					  bool force_immediate_exit)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool spec_ctrl_intercepted = msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL);
 
-	trace_kvm_entry(vcpu);
+	trace_kvm_entry(vcpu, force_immediate_exit);
 
 	svm->vmcb->save.rax = vcpu->arch.regs[VCPU_REGS_RAX];
 	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index b82e6ed4f024..c6b4b1728006 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -15,20 +15,23 @@
  * Tracepoint for guest mode entry.
  */
 TRACE_EVENT(kvm_entry,
-	TP_PROTO(struct kvm_vcpu *vcpu),
-	TP_ARGS(vcpu),
+	TP_PROTO(struct kvm_vcpu *vcpu, bool force_immediate_exit),
+	TP_ARGS(vcpu, force_immediate_exit),
 
 	TP_STRUCT__entry(
 		__field(	unsigned int,	vcpu_id		)
 		__field(	unsigned long,	rip		)
+		__field(	bool,		immediate_exit	)
 	),
 
 	TP_fast_assign(
 		__entry->vcpu_id        = vcpu->vcpu_id;
 		__entry->rip		= kvm_rip_read(vcpu);
+		__entry->immediate_exit	= force_immediate_exit;
 	),
 
-	TP_printk("vcpu %u, rip 0x%lx", __entry->vcpu_id, __entry->rip)
+	TP_printk("vcpu %u, rip 0x%lx%s", __entry->vcpu_id, __entry->rip,
+		  __entry->immediate_exit ? "[immediate exit]" : "")
 );
 
 /*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9ba4baf2a9e9..ee501871ddb0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7312,7 +7312,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	guest_state_exit_irqoff();
 }
 
-static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
+static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long cr3, cr4;
@@ -7339,7 +7339,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		return EXIT_FASTPATH_NONE;
 	}
 
-	trace_kvm_entry(vcpu);
+	trace_kvm_entry(vcpu, force_immediate_exit);
 
 	if (vmx->ple_window_dirty) {
 		vmx->ple_window_dirty = false;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 22a191a37e41..8a7a6cf4b4ec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10795,7 +10795,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		WARN_ON_ONCE((kvm_vcpu_apicv_activated(vcpu) != kvm_vcpu_apicv_active(vcpu)) &&
 			     (kvm_get_apic_mode(vcpu) != LAPIC_MODE_DISABLED));
 
-		exit_fastpath = static_call(kvm_x86_vcpu_run)(vcpu);
+		exit_fastpath = static_call(kvm_x86_vcpu_run)(vcpu, req_immediate_exit);
 		if (likely(exit_fastpath != EXIT_FASTPATH_REENTER_GUEST))
 			break;
 
-- 
2.51.0.rc1.163.g2494970778-goog


