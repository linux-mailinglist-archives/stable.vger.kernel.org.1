Return-Path: <stable+bounces-114003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41610A29CAB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 23:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB323A10F5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA558215798;
	Wed,  5 Feb 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLEYToM3"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7692116F9
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794440; cv=none; b=F5aiBnaf9H92Lpk1+u3oZKPXw6tA66oAmHfLG/cYhy/JvGJ3T4lTvhsKf9HIcVV5YQA4+4nu8VJOcskIicrTIzu31M5X6IzVjiyktLhzWC+bQ4AP2dfSPIL0dEekRgP1UJwEpHYofJM2BubJj92C3/JVRKNZ7cwKYi69uCncmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794440; c=relaxed/simple;
	bh=naT37YCNQti0jn+oTlr3DTtsred8kR7WQYxcmb4qBv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pc7hcjT8j52SMxYlkhqmDuWReEKiMuTuVFcJDs4S26KyjZsh4OMS9Apof01pquRnriOwe7Riua7ECoRzNnBKs8qF1V2G2cdj6hJPJ8dqPHEEnA41RIXskVSOyjy5RcXRV7M1HTjFOrqZeSqAUBYRxs04AXkyqlnt6empkB+Dq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLEYToM3; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4aff4bc545dso41466137.3
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 14:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738794437; x=1739399237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAuB31npxmIhFTDNEUPM6v4w515TzF7BRughsuLtWvA=;
        b=oLEYToM37rqhgTh9yDscQTv7IkPtKZtqijmTurRNw1QZ1PjZpDaB/VEewRGtHKxKA4
         YShp5+6/b7KkPEM0cWDGqVc9OwFmEZ19zuK0D7A+rilMwTMYS59POOdZxIhasCacWNwv
         4cCg0RrQ/pOBsMYZyeUh6+p4gkBRclpou73Grrp6Evco1FDfJseqOSNUnMH5b4CTLXnH
         t/Lzy9qf+/+PIKEX8I5hnCAMU+dmIXiRgGB4sHj6gVyOGrG2LBMPd067DnRYcimmhwoM
         NPqZ3NJpAiuvBS8gKl5mnjMlM2oibxfyWN7TeJfPj0BLzwy+S7LYCH3WVhr+zIZDZ8U8
         jaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794437; x=1739399237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAuB31npxmIhFTDNEUPM6v4w515TzF7BRughsuLtWvA=;
        b=CKgSwN7ZprEJZOOuHJ7xk4LvPHF//J+m4eRmTafR5eErhlFCKt3dUm6Jgtjhf4AbAJ
         gDU+B2QF+PMlO/5QJ7csC0AdXg9Q8f7SZwnk88cU4DtEjzGQ8GOgHh/RjFN4WP3BQUUl
         WAYVaf6t2fVMfirI7vr72Qc5Kqi/YSMeHQlhTr/EBi5OSO7WMvCEXwZANOGhCT/RLygB
         yNBFFCAea0XthKxbsd3OCIpZKvz+FfPGqrqcoyRrLDxLN0TPBF1XkJWTLm+3wYfidk9/
         lbQrCXkSBlESEILc9u/Qa3Jv9kRWznFMp7v+f6wh1upjAcQcP4Lvg++taP84y0+mJceh
         LjEw==
X-Gm-Message-State: AOJu0Yxnhn/hetwmdMd9RgfmvCQLNKQyMkHlIue0ruRZSmHEV3PTaNMr
	rJwBoEWHR5DvcHJeiRQDWicLpxP6tWXcTgC7/K3RZzJeF8jbJODFvzMS/qCwzJrGM7wYyjHVcI9
	UXU19G5SavaO8fPHhtFc62H4/dOnnaE6zWBcbyhE1Yq04wNSdg4aexJipV9vy576dg2fVycIs+C
	IlMj9lmWzxBxgVODXa4PuMsCJe4Y92gHQKf31mWhjo0wzY5U0vgGnSeQ==
X-Google-Smtp-Source: AGHT+IH2K6qXMknxFj8ErQId/sLvBru+oB2F2un9JIIJwA6ewS9BKA9BLTCDaQ3u0CyNRsHl2/dDsOBn6m5v1yXJ
X-Received: from vsij11.prod.google.com ([2002:a05:6102:240b:b0:4ba:7624:9c31])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:5799:b0:4b2:cc94:1877 with SMTP id ada2fe7eead31-4ba47970ea1mr3571701137.13.1738794436678;
 Wed, 05 Feb 2025 14:27:16 -0800 (PST)
Date: Wed,  5 Feb 2025 22:26:50 +0000
In-Reply-To: <20250205222651.3784169-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024100123-unreached-enrage-2cb1@gregkh> <20250205222651.3784169-1-jthoughton@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205222651.3784169-2-jthoughton@google.com>
Subject: [PATCH 6.6.y 1/2] KVM: x86: Make x2APIC ID 100% readonly
From: James Houghton <jthoughton@google.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Gavin Guo <gavinguo@igalia.com>, 
	Michal Luczaj <mhal@rbox.co>, Haoyu Wu <haoyuwu254@gmail.com>, 
	syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Ignore the userspace provided x2APIC ID when fixing up APIC state for
KVM_SET_LAPIC, i.e. make the x2APIC fully readonly in KVM.  Commit
a92e2543d6a8 ("KVM: x86: use hardware-compatible format for APIC ID
register"), which added the fixup, didn't intend to allow userspace to
modify the x2APIC ID.  In fact, that commit is when KVM first started
treating the x2APIC ID as readonly, apparently to fix some race:

 static inline u32 kvm_apic_id(struct kvm_lapic *apic)
 {
-       return (kvm_lapic_get_reg(apic, APIC_ID) >> 24) & 0xff;
+       /* To avoid a race between apic_base and following APIC_ID update when
+        * switching to x2apic_mode, the x2apic mode returns initial x2apic id.
+        */
+       if (apic_x2apic_mode(apic))
+               return apic->vcpu->vcpu_id;
+
+       return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
 }

Furthermore, KVM doesn't support delivering interrupts to vCPUs with a
modified x2APIC ID, but KVM *does* return the modified value on a guest
RDMSR and for KVM_GET_LAPIC.  I.e. no remotely sane setup can actually
work with a modified x2APIC ID.

Making the x2APIC ID fully readonly fixes a WARN in KVM's optimized map
calculation, which expects the LDR to align with the x2APIC ID.

  WARNING: CPU: 2 PID: 958 at arch/x86/kvm/lapic.c:331 kvm_recalculate_apic_map+0x609/0xa00 [kvm]
  CPU: 2 PID: 958 Comm: recalc_apic_map Not tainted 6.4.0-rc3-vanilla+ #35
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
  RIP: 0010:kvm_recalculate_apic_map+0x609/0xa00 [kvm]
  Call Trace:
   <TASK>
   kvm_apic_set_state+0x1cf/0x5b0 [kvm]
   kvm_arch_vcpu_ioctl+0x1806/0x2100 [kvm]
   kvm_vcpu_ioctl+0x663/0x8a0 [kvm]
   __x64_sys_ioctl+0xb8/0xf0
   do_syscall_64+0x56/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0
  RIP: 0033:0x7fade8b9dd6f

Unfortunately, the WARN can still trigger for other CPUs than the current
one by racing against KVM_SET_LAPIC, so remove it completely.

Reported-by: Michal Luczaj <mhal@rbox.co>
Closes: https://lore.kernel.org/all/814baa0c-1eaa-4503-129f-059917365e80@rbox.co
Reported-by: Haoyu Wu <haoyuwu254@gmail.com>
Closes: https://lore.kernel.org/all/20240126161633.62529-1-haoyuwu254@gmail.com
Reported-by: syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000c2a6b9061cbca3c3@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20240802202941.344889-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071)
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/kvm/lapic.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 34766abbabd8..cd9c1e1f6fd3 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -338,10 +338,8 @@ static void kvm_recalculate_logical_map(struct kvm_apic_map *new,
 	 * reversing the LDR calculation to get cluster of APICs, i.e. no
 	 * additional work is required.
 	 */
-	if (apic_x2apic_mode(apic)) {
-		WARN_ON_ONCE(ldr != kvm_apic_calc_x2apic_ldr(kvm_x2apic_id(apic)));
+	if (apic_x2apic_mode(apic))
 		return;
-	}
 
 	if (WARN_ON_ONCE(!kvm_apic_map_get_logical_dest(new, ldr,
 							&cluster, &mask))) {
@@ -2964,18 +2962,28 @@ static int kvm_apic_state_fixup(struct kvm_vcpu *vcpu,
 		struct kvm_lapic_state *s, bool set)
 {
 	if (apic_x2apic_mode(vcpu->arch.apic)) {
+		u32 x2apic_id = kvm_x2apic_id(vcpu->arch.apic);
 		u32 *id = (u32 *)(s->regs + APIC_ID);
 		u32 *ldr = (u32 *)(s->regs + APIC_LDR);
 		u64 icr;
 
 		if (vcpu->kvm->arch.x2apic_format) {
-			if (*id != vcpu->vcpu_id)
+			if (*id != x2apic_id)
 				return -EINVAL;
 		} else {
+			/*
+			 * Ignore the userspace value when setting APIC state.
+			 * KVM's model is that the x2APIC ID is readonly, e.g.
+			 * KVM only supports delivering interrupts to KVM's
+			 * version of the x2APIC ID.  However, for backwards
+			 * compatibility, don't reject attempts to set a
+			 * mismatched ID for userspace that hasn't opted into
+			 * x2apic_format.
+			 */
 			if (set)
-				*id >>= 24;
+				*id = x2apic_id;
 			else
-				*id <<= 24;
+				*id = x2apic_id << 24;
 		}
 
 		/*
@@ -2984,7 +2992,7 @@ static int kvm_apic_state_fixup(struct kvm_vcpu *vcpu,
 		 * split to ICR+ICR2 in userspace for backwards compatibility.
 		 */
 		if (set) {
-			*ldr = kvm_apic_calc_x2apic_ldr(*id);
+			*ldr = kvm_apic_calc_x2apic_ldr(x2apic_id);
 
 			icr = __kvm_lapic_get_reg(s->regs, APIC_ICR) |
 			      (u64)__kvm_lapic_get_reg(s->regs, APIC_ICR2) << 32;
-- 
2.48.1.362.g079036d154-goog


