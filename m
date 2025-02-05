Return-Path: <stable+bounces-114004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91669A29CAC
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 23:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637391888F87
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5AF21505F;
	Wed,  5 Feb 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ljepjrI"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f201.google.com (mail-vk1-f201.google.com [209.85.221.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C92116F9
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794442; cv=none; b=bgHioa3mcVm7z+wPUJAy4Xp0iVFhEX71RsIejZc6uxNLeHaMMzlxqHlXTyFIQltLPGCwdMPIGWYnzIvzj5YS7Oyhy5O6rv0myPPCMNXLwuvO8ugn4fCPbhfOYQgu+uURuea7E23yfuFjHbAu10zCmkqz3JjrCyE5vV7dn9gOzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794442; c=relaxed/simple;
	bh=yCIgw1jJBmdN+bYBivFi9kEDIFBPxRtvOBrqGUX+GLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LOqRWN3qFw03vrqHv8KWYgvcy03LUHSbhYw16h8rOTPBMj2JG4ltmQEv/vk3QyaMjEhv9ncUpaUDbizN3SMJnReE9b7ehUGfqKydusOBfWzSDEYZ/bp1oD6QXbBk8m8y6EF81AVBDDNJmVx7GHpoTnt8VceJjSrdpZ3tuTVsl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ljepjrI; arc=none smtp.client-ip=209.85.221.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vk1-f201.google.com with SMTP id 71dfb90a1353d-518aebf56f6so59852e0c.2
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 14:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738794440; x=1739399240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7G+dPoWcgBqm//f7Mv+6q1/Q0hzrbEf95XTl9Fk4e5E=;
        b=0ljepjrI8fk/YCJL5FZzIw/MfNIcChu5HdgGHGj0iRf3zYJd/j0GbONWNXMfKaGQn+
         7n6Zy60i7sjoTlobn+jyohJqaIGnzj9qM7tZ4V231772gGx5v+3hDbZRODehboxP1AO3
         XTbYTlkWktTc7AU9KJd8z0JuL29o4soBzznUkDDLxjrNBOT7/fLb3rQg5+3v+MjD1KIn
         SeS/unn+PrBcvC9SpZgbuNu5kk/jcSVtfo/qSsyN4NIr0nCAxbGt1Ypi1lysBYncwfBH
         O7azdj7ZwEG6pf4xCUrPUXbzTfTVxYKXyApDeqb88SL719sc8ZGXMyDvTzZj0l6VCya9
         1Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794440; x=1739399240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7G+dPoWcgBqm//f7Mv+6q1/Q0hzrbEf95XTl9Fk4e5E=;
        b=PMr+PWxtKealk5IsE05/4rIqf54XlB35PTtQ33fWU9yvLm7W6kKqY/105cmHiuodoc
         1bqylepqS5OWJJ+8cAM148vUzeUxosKO01rvNP/RZvy+IneYwBq9PjQfGlZcHCQo6oBo
         OQqXhU/K5xpz9Yweeswzu2YVetK062EfF4+jE7jTb2oCSW2PNQwsVFelE+rM29LrH/eU
         8zSHoaD1rlwYn/lR2aEkrk44XNImWqROxh+LFSgq/oT6WSaAGF8IW4pncl9toMG3Ip37
         JyDicNAgGYqcUf7ze6YQoRfKx8w01D0YjJQftOgLOKhLQ/mMEfNeg47387vNhrFyUnUh
         yPJw==
X-Gm-Message-State: AOJu0YzLXHn3GOAx/woH5I9r9YLC5FBEv67x7tvRWid95I8GlaWtv94w
	9K0dGf6ZbFceolrzsimNqX0EEdo77gu+exNEnEr4YR9DXisdblBhaF96OcVJ3XY3OndVQyKXQqD
	9CfwyT0c98K60JwVPX1scGI4jhBmFCnM2wTMcqzX7kQeB9M9XFc+C/d1p7KUoKu6US+u48xmMUK
	qi9zkPtLeRmBQSbrl/avepnOgX+LK2/mTJTpq07tOcfQRwYcbObtmkKg==
X-Google-Smtp-Source: AGHT+IHsHBAqMwlHvO7WRbxkVh2r8s81ENQxomDxxWd355g0R82EGO/zUnb+j3Oun5qjF4qlPH9UPWdLoJwYokEr
X-Received: from vkdk10.prod.google.com ([2002:a05:6122:210a:b0:51d:f4ef:8feb])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:c8b:b0:516:2833:1b8d with SMTP id 71dfb90a1353d-51f0c56a087mr2934194e0c.11.1738794439963;
 Wed, 05 Feb 2025 14:27:19 -0800 (PST)
Date: Wed,  5 Feb 2025 22:26:51 +0000
In-Reply-To: <20250205222651.3784169-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024100123-unreached-enrage-2cb1@gregkh> <20250205222651.3784169-1-jthoughton@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205222651.3784169-3-jthoughton@google.com>
Subject: [PATCH 6.6.y 2/2] KVM: x86: Re-split x2APIC ICR into ICR+ICR2 for AMD (x2AVIC)
From: James Houghton <jthoughton@google.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Gavin Guo <gavinguo@igalia.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Re-introduce the "split" x2APIC ICR storage that KVM used prior to Intel's
IPI virtualization support, but only for AMD.  While not stated anywhere
in the APM, despite stating the ICR is a single 64-bit register, AMD CPUs
store the 64-bit ICR as two separate 32-bit values in ICR and ICR2.  When
IPI virtualization (IPIv on Intel, all AVIC flavors on AMD) is enabled,
KVM needs to match CPU behavior as some ICR ICR writes will be handled by
the CPU, not by KVM.

Add a kvm_x86_ops knob to control the underlying format used by the CPU to
store the x2APIC ICR, and tune it to AMD vs. Intel regardless of whether
or not x2AVIC is enabled.  If KVM is handling all ICR writes, the storage
format for x2APIC mode doesn't matter, and having the behavior follow AMD
versus Intel will provide better test coverage and ease debugging.

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Link: https://lore.kernel.org/r/20240719235107.3023592-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
(cherry picked from commit 73b42dc69be8564d4951a14d00f827929fe5ef79)
[JH: fixed conflict with vmx_x86_ops reshuffle due to missing commit
5f18c642ff7e2]
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/lapic.c            | 42 +++++++++++++++++++++++----------
 arch/x86/kvm/svm/svm.c          |  2 ++
 arch/x86/kvm/vmx/vmx.c          |  2 ++
 4 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 257bf2e71d06..39672561c6be 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1650,6 +1650,8 @@ struct kvm_x86_ops {
 	void (*enable_irq_window)(struct kvm_vcpu *vcpu);
 	void (*update_cr8_intercept)(struct kvm_vcpu *vcpu, int tpr, int irr);
 	bool (*check_apicv_inhibit_reasons)(enum kvm_apicv_inhibit reason);
+
+	const bool x2apic_icr_is_split;
 	const unsigned long required_apicv_inhibits;
 	bool allow_apicv_in_x2apic_without_x2apic_virtualization;
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index cd9c1e1f6fd3..66c7f2367bb3 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2459,11 +2459,25 @@ int kvm_x2apic_icr_write(struct kvm_lapic *apic, u64 data)
 	data &= ~APIC_ICR_BUSY;
 
 	kvm_apic_send_ipi(apic, (u32)data, (u32)(data >> 32));
-	kvm_lapic_set_reg64(apic, APIC_ICR, data);
+	if (kvm_x86_ops.x2apic_icr_is_split) {
+		kvm_lapic_set_reg(apic, APIC_ICR, data);
+		kvm_lapic_set_reg(apic, APIC_ICR2, data >> 32);
+	} else {
+		kvm_lapic_set_reg64(apic, APIC_ICR, data);
+	}
 	trace_kvm_apic_write(APIC_ICR, data);
 	return 0;
 }
 
+static u64 kvm_x2apic_icr_read(struct kvm_lapic *apic)
+{
+	if (kvm_x86_ops.x2apic_icr_is_split)
+		return (u64)kvm_lapic_get_reg(apic, APIC_ICR) |
+		       (u64)kvm_lapic_get_reg(apic, APIC_ICR2) << 32;
+
+	return kvm_lapic_get_reg64(apic, APIC_ICR);
+}
+
 /* emulate APIC access in a trap manner */
 void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
 {
@@ -2481,7 +2495,7 @@ void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
 	 * maybe-unecessary write, and both are in the noise anyways.
 	 */
 	if (apic_x2apic_mode(apic) && offset == APIC_ICR)
-		WARN_ON_ONCE(kvm_x2apic_icr_write(apic, kvm_lapic_get_reg64(apic, APIC_ICR)));
+		WARN_ON_ONCE(kvm_x2apic_icr_write(apic, kvm_x2apic_icr_read(apic)));
 	else
 		kvm_lapic_reg_write(apic, offset, kvm_lapic_get_reg(apic, offset));
 }
@@ -2988,18 +3002,22 @@ static int kvm_apic_state_fixup(struct kvm_vcpu *vcpu,
 
 		/*
 		 * In x2APIC mode, the LDR is fixed and based on the id.  And
-		 * ICR is internally a single 64-bit register, but needs to be
-		 * split to ICR+ICR2 in userspace for backwards compatibility.
+		 * if the ICR is _not_ split, ICR is internally a single 64-bit
+		 * register, but needs to be split to ICR+ICR2 in userspace for
+		 * backwards compatibility.
 		 */
-		if (set) {
+		if (set)
 			*ldr = kvm_apic_calc_x2apic_ldr(x2apic_id);
 
-			icr = __kvm_lapic_get_reg(s->regs, APIC_ICR) |
-			      (u64)__kvm_lapic_get_reg(s->regs, APIC_ICR2) << 32;
-			__kvm_lapic_set_reg64(s->regs, APIC_ICR, icr);
-		} else {
-			icr = __kvm_lapic_get_reg64(s->regs, APIC_ICR);
-			__kvm_lapic_set_reg(s->regs, APIC_ICR2, icr >> 32);
+		if (!kvm_x86_ops.x2apic_icr_is_split) {
+			if (set) {
+				icr = __kvm_lapic_get_reg(s->regs, APIC_ICR) |
+				      (u64)__kvm_lapic_get_reg(s->regs, APIC_ICR2) << 32;
+				__kvm_lapic_set_reg64(s->regs, APIC_ICR, icr);
+			} else {
+				icr = __kvm_lapic_get_reg64(s->regs, APIC_ICR);
+				__kvm_lapic_set_reg(s->regs, APIC_ICR2, icr >> 32);
+			}
 		}
 	}
 
@@ -3196,7 +3214,7 @@ static int kvm_lapic_msr_read(struct kvm_lapic *apic, u32 reg, u64 *data)
 	u32 low;
 
 	if (reg == APIC_ICR) {
-		*data = kvm_lapic_get_reg64(apic, APIC_ICR);
+		*data = kvm_x2apic_icr_read(apic);
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 413f1f2aadd1..d762330bce16 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5014,6 +5014,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.enable_nmi_window = svm_enable_nmi_window,
 	.enable_irq_window = svm_enable_irq_window,
 	.update_cr8_intercept = svm_update_cr8_intercept,
+
+	.x2apic_icr_is_split = true,
 	.set_virtual_apic_mode = avic_refresh_virtual_apic_mode,
 	.refresh_apicv_exec_ctrl = avic_refresh_apicv_exec_ctrl,
 	.apicv_post_state_restore = avic_apicv_post_state_restore,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 479ef26626f2..52098844290a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8323,6 +8323,8 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.enable_nmi_window = vmx_enable_nmi_window,
 	.enable_irq_window = vmx_enable_irq_window,
 	.update_cr8_intercept = vmx_update_cr8_intercept,
+
+	.x2apic_icr_is_split = false,
 	.set_virtual_apic_mode = vmx_set_virtual_apic_mode,
 	.set_apic_access_page_addr = vmx_set_apic_access_page_addr,
 	.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
-- 
2.48.1.362.g079036d154-goog


