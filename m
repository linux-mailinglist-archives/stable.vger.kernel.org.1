Return-Path: <stable+bounces-169640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE1BB2736E
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168379E4AE3
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F285260;
	Fri, 15 Aug 2025 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2ZbMKnV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28542A96
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216740; cv=none; b=hJUMD6ZbrkH7rQbZYT0rZ3iBXQ29U+SJFECwcppcHOGz59nnITJkm/gvQHH/1fNxQDBiRmWLwcN4SnK/XHHZapH/WsRAh0TMOLSmfYkmYNM7zb1M2eDVzaYHRmq9cDcRgWv7XtPMekxcgrqobYfas+Vu9wRoxL/FNwYy/NUxcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216740; c=relaxed/simple;
	bh=kvEVV1BoPOFs6DDYtZzil6bpoP269npdUmCmNBs7jHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EWWN4/qYXmwRuuqS+aofDXk+ok5xBt/k6/MouG1JOQ5RhsEdOgPUUc9Ve86KH6tVnt0OJJmtZ1Gurn1ko3Xn3eOnpV2S3HnP22vROrzXt6ALEDRHbRAMNFhMkVWdyjXxqhRp92PLYVuZXFZYXADMQoLwMIIXW8PdaCbwHoV5rhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2ZbMKnV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267bcee2so1447798a91.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216738; x=1755821538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ijMOWxVCOFsVrE+awRlE3st0fZ/ms+lEIOtbXiEijA4=;
        b=k2ZbMKnV9PvYErS4J+9SX1977kmRRqAFShGwEQSHhL0Ya7TCl6JNAPTgosM0m7FSPk
         iFDT8iz8tgnAJhazOtoDQc9EL3MbRcG6sLGSMJ7aY+WutVn6O3VyHJAZBhLI1ijztKPV
         SsMdrXztAQFsFe11ykvj/Cm6OFsu7Dlh0gpPEAFW5v8fZlzk0nn9IdnXbCdDiolViYAd
         DV9a2V5UzYNA5l0EY5BziRokTzhdKIBLbpJhrOp66YhC9rRVCnwCKeAAIz04WME0uJNh
         imgpvdCakC1BZUuwqvgiNL/6Xa6FjWg4zKDrApSudFM0FCO6PL82CZ//l/Rbk/zW8Xfk
         L26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216738; x=1755821538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijMOWxVCOFsVrE+awRlE3st0fZ/ms+lEIOtbXiEijA4=;
        b=C6mPDaTM4sk4fO3Cr+X28eCNCIK6ICtc7QR76B6RH2q9DHo1denQqjD5biAm/0+6Fx
         4PYDVwjl4ipl2AipQDDSgxCjv34/z4iPTMGV1nUEMmKvNTowj0HCMz58cCIDUoY0Z27+
         z8N/L2gwoW1Ye+8JQtUOOPz7RjGtNDPHqoexX0UBejzXNNf9Mer6gP4jIX7dtYaBIPyM
         yY2tlscXg/aN70VOfhOGfdjg18q6rmBU2a5zMowWiixC/QUqC2TFIF8uDZSEAJz1+GeJ
         EitCR+DK+d7VOJP1LjGu3MsshaE6rxVt+rQ4s3zQSPqLmRhPZXQP8P9b9fwo3Agmi77P
         hoeA==
X-Gm-Message-State: AOJu0YzPrVo18KlpNrD+SoUn6ATl1+HPKbF0ozlh2RpEXP/X7wmVgH5c
	dbDy3Vnx0yRbUzPOxzlAVMu6QB5KrDbe/ik7ICvObgKsLkx8CR65mgR4k9B6V41JdCbaCODAqkH
	xRHPTSroEwahw/U6QZbStJDImdupAzhFOaJiU+k0BqgeZ0nles4Ju+4hmgUfYJqiBApJ3I5/lTm
	isfolzVeMpO5/1oOHRZ7MXptjYxGxWcUh5aNTh
X-Google-Smtp-Source: AGHT+IHpTDFEVltDF/eSPHVFejV9HOBd6wSUTgz0cpglTB51iNXwA6rUqHlyqBsTMJfnk58lhRvX00nXvgs=
X-Received: from pjyp16.prod.google.com ([2002:a17:90a:e710:b0:31c:160d:e3be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2882:b0:313:f6fa:5bca
 with SMTP id 98e67ed59e1d1-323421476f1mr263256a91.22.1755216737817; Thu, 14
 Aug 2025 17:12:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:47 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-4-seanjc@google.com>
Subject: [PATCH 6.1.y 03/21] KVM: x86: Plumb in the vCPU to kvm_x86_ops.hwapic_isr_update()
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 76bce9f10162cd4b36ac0b7889649b22baf70ebd ]

Pass the target vCPU to the hwapic_isr_update() vendor hook so that VMX
can defer the update until after nested VM-Exit if an EOI for L1's vAPIC
occurs while L2 is active.

Note, commit d39850f57d21 ("KVM: x86: Drop @vcpu parameter from
kvm_x86_ops.hwapic_isr_update()") removed the parameter with the
justification that doing so "allows for a decent amount of (future)
cleanup in the APIC code", but it's not at all clear what cleanup was
intended, or if it was ever realized.

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: Chao Gao <chao.gao@intel.com>
Tested-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/r/20241128000010.4051275-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[sean: account for lack of kvm_x86_call(), drop vmx/x86_ops.h change]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/lapic.c            | 8 ++++----
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 17b4e61a52b9..6db42ee82032 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1552,7 +1552,7 @@ struct kvm_x86_ops {
 	bool (*check_apicv_inhibit_reasons)(enum kvm_apicv_inhibit reason);
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
-	void (*hwapic_isr_update)(int isr);
+	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
 	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 42eec987ac3d..3d65d6a023c9 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -587,7 +587,7 @@ static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
 	 * just set SVI.
 	 */
 	if (unlikely(apic->apicv_active))
-		static_call_cond(kvm_x86_hwapic_isr_update)(vec);
+		static_call_cond(kvm_x86_hwapic_isr_update)(apic->vcpu, vec);
 	else {
 		++apic->isr_count;
 		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
@@ -632,7 +632,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	 * and must be left alone.
 	 */
 	if (unlikely(apic->apicv_active))
-		static_call_cond(kvm_x86_hwapic_isr_update)(apic_find_highest_isr(apic));
+		static_call_cond(kvm_x86_hwapic_isr_update)(apic->vcpu, apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
 		BUG_ON(apic->isr_count < 0);
@@ -2554,7 +2554,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	if (apic->apicv_active) {
 		static_call_cond(kvm_x86_apicv_post_state_restore)(vcpu);
 		static_call_cond(kvm_x86_hwapic_irr_update)(vcpu, -1);
-		static_call_cond(kvm_x86_hwapic_isr_update)(-1);
+		static_call_cond(kvm_x86_hwapic_isr_update)(vcpu, -1);
 	}
 
 	vcpu->arch.apic_arb_prio = 0;
@@ -2847,7 +2847,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	if (apic->apicv_active) {
 		static_call_cond(kvm_x86_apicv_post_state_restore)(vcpu);
 		static_call_cond(kvm_x86_hwapic_irr_update)(vcpu, apic_find_highest_irr(apic));
-		static_call_cond(kvm_x86_hwapic_isr_update)(apic_find_highest_isr(apic));
+		static_call_cond(kvm_x86_hwapic_isr_update)(vcpu, apic_find_highest_isr(apic));
 	}
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	if (ioapic_in_kernel(vcpu->kvm))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9a5cb896229f..721ba6ddb121 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6708,7 +6708,7 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 	put_page(page);
 }
 
-static void vmx_hwapic_isr_update(int max_isr)
+static void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 {
 	u16 status;
 	u8 old;
-- 
2.51.0.rc1.163.g2494970778-goog


