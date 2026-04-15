Return-Path: <stable+bounces-238209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA/GGxT032mMawAAu9opvQ
	(envelope-from <stable+bounces-238209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:24:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB6D4079D7
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDA230866BF
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4538836E;
	Wed, 15 Apr 2026 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqXgH7tR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B23382296
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776284637; cv=none; b=EDtqB6H9ISaKDheqZIenXB04fIaNU8TH+/iqLBWRMy8K1V2BwcIzlhRhN+GrbSdg4S4wiR5u+ersvVMLN2F0Ywc++NgbE3nDOjA/YBm6/4KQRmnMZoEr9L63+tZ9tbvLlQBwhcPMOCZB/5ESvjRxwt3j/92ue/2VTDyL+Imu4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776284637; c=relaxed/simple;
	bh=XimFzuE+iTs8LG5ejhPwammpQ1xzR6hFJK1e/FsQtQk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H7shu8LSBQXTZnryRt37crfOITa9BRsA5dNIgHw2E9mdJKSmkZCdXUdjf2sQuqqBSz3KHuScDeOWrLy7L1ZvgjEDfz0WWvQjzELXEqbz+T8Ix5sWz4bFgnV+klAggZsyTbgHpFCgOn7CCgkeJ3du+SbtQclkS37i1/vBrGXdvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqXgH7tR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2497cc190so36199205ad.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776284635; x=1776889435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BibiKlMJ4/ODuW2X15QmQ8ureNdaaXO0AYMX9/zZ9s0=;
        b=sqXgH7tRy4RlOKp/WIHUwBnywmridE6OFWVMdkXxga6lhdqYqsr93Wwwt69Hg3fhRo
         kJ9KjEwW+JQDHwm5lkT2/vXUqdaPYVeRKrks8qaSJFNhJEypVONjUhJzAPS8vGFWQh64
         VbgZfMX6SQJUvrGqJAU1gEyOsQ4FsiEVD4c/2yABiCGcf4UWzNVYOhra87qvqg6L0CTJ
         SOBy1QzOAOSqrwnNqZfAD+YyjfU1DKZ1NnI1rgCzeBq1e2guscS8HmxAzlGoSlTU6VcH
         pceK9dr3B3jbj9IUqRKqoqW2Dua7oOHLKII+g9yhSUHBzlfX/klQhMOzYzCr4IrRF30C
         5NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284635; x=1776889435;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BibiKlMJ4/ODuW2X15QmQ8ureNdaaXO0AYMX9/zZ9s0=;
        b=glHen06KQMUBSOrBxSXZdpptRfw14t4ptfgbIitf3nZQPPV7RnhdrTA5Js6QWb7JSO
         7Sa2Aj8t1o5WPCC2CHo4uqevYN+WkFFllrZcsnE+C1SZsRFoZqOuO9zxi4S0j7vEHlFk
         MdGEB9QFvaTRZgfbxokxV5aBaUvVb4+SXbrywOQwyVBryJYIvGSBlQhv8aO66RmZr8Rs
         /3KB6gz5x6tHMmXkOxvmSM5WI0PA3q41zPoK8ks6lpUpL8gmr1LsoarhGentIx5XfHPd
         81mOJeYdcoUiEks9GcMQrJjIxE9qssGBJOziEfRVSUL3QmFBScCrF62f1/sks/L8oQ/8
         h2dg==
X-Gm-Message-State: AOJu0Yw2XK1CSzsyZWbpxjphw8ASvkODqc3/D3Lrl/efjzgkqjvUO3kh
	JAMpXOF4/fFFSYspf42BajLkFdJQZVCd1gsM+ZKe8HsC6iRcIKZwJXCOrcZ6UNArDbI4OIRPoWC
	PZVhKZ+yAB8sgXRXV1ZQ84Hgs/NBOet6fusbPjG5NWfsCzeavrLnZURN1FU9Y3OrOK0kC3yxaSe
	F3UJa96npgJLPY1WMr5dO1lyJqBpou5+zja+Zb
X-Received: from ploc13.prod.google.com ([2002:a17:902:848d:b0:2b2:3d4a:16db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:76c8:b0:2b4:64cf:e8f8
 with SMTP id d9443c01a7336-2b5eaa22628mr5434185ad.2.1776284634536; Wed, 15
 Apr 2026 13:23:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 15 Apr 2026 13:23:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260415202346.3026288-1-seanjc@google.com>
Subject: [PATCH 6.6] KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Taeyang Lee <0wn@theori.io>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238209-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,theori.io:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: DEB6D4079D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 321ef62b0c5f6f57bb8500a2ca5986052675abbf ]

Check for a Requested Virtual Interrupt, i.e. a virtual interrupt that is
pending delivery, in vmx_has_nested_events() and drop the one-off
kvm_x86_ops.guest_apic_has_interrupt() hook.

In addition to dropping a superfluous hook, this fixes a bug where KVM
would incorrectly treat virtual interrupts _for L2_ as always enabled due
to kvm_arch_interrupt_allowed(), by way of vmx_interrupt_blocked(),
treating IRQs as enabled if L2 is active and vmcs12 is configured to exit
on IRQs, i.e. KVM would treat a virtual interrupt for L2 as a valid wake
event based on L1's IRQ blocking status.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240607172609.3205077-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Cc: Taeyang Lee <0wn@theori.io>
[sean: deal with lack of vmx/main.c and vmx/x86_ops.h]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  1 -
 arch/x86/kvm/vmx/nested.c          |  4 ++++
 arch/x86/kvm/vmx/vmx.c             | 21 ---------------------
 arch/x86/kvm/x86.c                 | 10 +---------
 5 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index a0a4fc684e63..3d00c2444a75 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -83,7 +83,6 @@ KVM_X86_OP_OPTIONAL(update_cr8_intercept)
 KVM_X86_OP(refresh_apicv_exec_ctrl)
 KVM_X86_OP_OPTIONAL(hwapic_irr_update)
 KVM_X86_OP_OPTIONAL(hwapic_isr_update)
-KVM_X86_OP_OPTIONAL_RET0(guest_apic_has_interrupt)
 KVM_X86_OP_OPTIONAL(load_eoi_exitmap)
 KVM_X86_OP_OPTIONAL(set_virtual_apic_mode)
 KVM_X86_OP_OPTIONAL(set_apic_access_page_addr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index df950c184c59..d79b8f7a3991 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1671,7 +1671,6 @@ struct kvm_x86_ops {
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
 	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
-	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
 	void (*set_apic_access_page_addr)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index fb274bae41e2..377b30212c19 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4007,6 +4007,10 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 
 	vppr = *((u32 *)(vapic + APIC_PROCPRI));
 
+	max_irr = vmx_get_rvi();
+	if ((max_irr & 0xf0) > (vppr & 0xf0))
+		return true;
+
 	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
 	    pi_test_on(vmx->nested.pi_desc)) {
 		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b68fb5329a13..4a45e86c5e2f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4127,26 +4127,6 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 	}
 }
 
-static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	void *vapic_page;
-	u32 vppr;
-	int rvi;
-
-	if (WARN_ON_ONCE(!is_guest_mode(vcpu)) ||
-		!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
-		WARN_ON_ONCE(!vmx->nested.virtual_apic_map.gfn))
-		return false;
-
-	rvi = vmx_get_rvi();
-
-	vapic_page = vmx->nested.virtual_apic_map.hva;
-	vppr = *((u32 *)(vapic_page + APIC_PROCPRI));
-
-	return ((rvi & 0xf0) > (vppr & 0xf0));
-}
-
 static void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -8390,7 +8370,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.required_apicv_inhibits = VMX_REQUIRED_APICV_INHIBITS,
 	.hwapic_irr_update = vmx_hwapic_irr_update,
 	.hwapic_isr_update = vmx_hwapic_isr_update,
-	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
 	.sync_pir_to_irr = vmx_sync_pir_to_irr,
 	.deliver_interrupt = vmx_deliver_interrupt,
 	.dy_apicv_has_pending_interrupt = pi_has_pending_interrupt,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ac0b458582c3..485c1820e65a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12906,12 +12906,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		kvm_arch_free_memslot(kvm, old);
 }
 
-static inline bool kvm_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-{
-	return (is_guest_mode(vcpu) &&
-		static_call(kvm_x86_guest_apic_has_interrupt)(vcpu));
-}
-
 static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 {
 	if (!list_empty_careful(&vcpu->async_pf.done))
@@ -12942,9 +12936,7 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_test_request(KVM_REQ_PMI, vcpu))
 		return true;
 
-	if (kvm_arch_interrupt_allowed(vcpu) &&
-	    (kvm_cpu_has_interrupt(vcpu) ||
-	    kvm_guest_apic_has_interrupt(vcpu)))
+	if (kvm_arch_interrupt_allowed(vcpu) && kvm_cpu_has_interrupt(vcpu))
 		return true;
 
 	if (kvm_hv_has_stimer_pending(vcpu))

base-commit: 8cee53b8eaeb5d1f7c97b7f2381653ed00ffc26b
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


