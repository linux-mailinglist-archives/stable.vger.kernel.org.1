Return-Path: <stable+bounces-169661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C1B273C2
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7F77213BA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D35217A306;
	Fri, 15 Aug 2025 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwoJvbA1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7903EA8D
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217550; cv=none; b=Myokah/69fdeoX0WQjKzpoKyJK+4rDB/9l8isWkU8KVQ4oooSPc1wfbQjxrQ/wD57ATTSAAA0O0FjBrmFEbZmL6Kh00BP8HgE2BL8R+twVv1ow45X4wICzfggG3nYqHOW7jHXW0oUMTjnNBOb8eQvIiHdbb59gm5rmkHrv8aya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217550; c=relaxed/simple;
	bh=zlXQ4ZU3VrvB4sXa+ComF+joHtt5NQVT6oPd7DEUt/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lWbYHqHt6xqmV+EGgZmzCi118Bjh53sQHWc5d1af40OIa3EYHp5nw2rtNMCHw6dojtWVhiAbRLS+I9feeFJds2ToV8ZevcWwN6xSnm3hSqHpAkLBdu0XkYCRY37+757X1GLt8J/4D3pbKuAx9daH4XyaIRdrCwj7qgwiE8fXN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwoJvbA1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e614e73so1453409b3a.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217548; x=1755822348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yJbizRUw+p2hqJq2yCwI8a4ldo76XC44biSplLoJEII=;
        b=mwoJvbA1WZj8Lmfr0d3HjGHcEPURJ9I5eyEFHiR7UMLao32w0HY2NRWO70np4cVKJg
         Yoj+mMHbu4eXMpbszUQTfsrzFNaKj7epBD26cIpLy2MMlqdXapDQgAFLolIDLGwG+PdE
         BsOFsanMZXfbhr1vL1pJE8XXg3dTghVl6a2fmkOa/H9PmaF5NZhLks1PaqK/Gq0wZOSp
         ZRi4VmcDwJuF0rEzqrIh2qS8sYbvIljkSb3euc4t1jn+/GCTeFcn7XyFqnykyfHXpnKG
         00Ti8PWE3a8Lm6+qRFg2fmoc4saRxTPagum2T17reVRo5htQyODXRwxkeDjW0K8vmSD4
         x/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217548; x=1755822348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJbizRUw+p2hqJq2yCwI8a4ldo76XC44biSplLoJEII=;
        b=axtRVm2FDS5Dz7WOvFO7xTeVdpER9hNUDXcSdgyiuasEpjfsuLHt54158v0m3ENe2/
         bz3rQp054XwXpI0lMCDFzmRmzrzZ0jLzj3ob+s4RHboFOad2jb4HGDku7WknQSQKahVY
         bXx9TNhetKBltScezlRN6TAjSDGZbEG7EUFk62IEaqZ/ZspNxEmPMMyD+9hTVQH/txsO
         ny66+yzFnbQhhnGYb412Jikh6/Xht1cwUFP0HkBQwu0NK1kgvDWLewryRn0YIWyK68Xu
         7YdV9Afcq8bVJDJLknW/ZmUdLihUCO45qYZmjT9qzoyRLkvXwJCBmG/6OmcNzU/q4NLw
         8/7g==
X-Gm-Message-State: AOJu0Yw72Giv+aQPYMi6kEwG8iGikJfYHm6ex4lxF1WgXRyVrSZ0Vu2E
	BEi8vduqvkmcIxzDFP3he4yd5g/BU8yzIZp6O/uf0l1mSuIFhC9MP9VOnsv3g8E3rXuleCCoKvE
	IdCcW173UzWUkc39I4xioU3Tg54lzOvdw/MmLxQ7BV45o9XNJLVsfXGPLdsP1MHXLiyunaDQ10z
	3bRymL4VyFADDBTNKhmpLGPvA5Ilx0JOgOesQ2
X-Google-Smtp-Source: AGHT+IG6sETl/uXVyld3Bdf7Q1Ak70AHDx6bGGr2qU8sVh2rUEa7JPwLnAYaVKdFIqbssWVjeI35rrCmp5g=
X-Received: from pgar2.prod.google.com ([2002:a05:6a02:2e82:b0:b2b:f469:cf78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1590:b0:240:356:f06e
 with SMTP id adf61e73a8af0-240d2dc43a8mr333204637.0.1755217547650; Thu, 14
 Aug 2025 17:25:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:22 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-3-seanjc@google.com>
Subject: [PATCH 6.6.y 02/20] KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN
 out of the STI shadow
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit be45bc4eff33d9a7dae84a2150f242a91a617402 ]

Enable/disable local IRQs, i.e. set/clear RFLAGS.IF, in the common
svm_vcpu_enter_exit() just after/before guest_state_{enter,exit}_irqoff()
so that VMRUN is not executed in an STI shadow.  AMD CPUs have a quirk
(some would say "bug"), where the STI shadow bleeds into the guest's
intr_state field if a #VMEXIT occurs during injection of an event, i.e. if
the VMRUN doesn't complete before the subsequent #VMEXIT.

The spurious "interrupts masked" state is relatively benign, as it only
occurs during event injection and is transient.  Because KVM is already
injecting an event, the guest can't be in HLT, and if KVM is querying IRQ
blocking for injection, then KVM would need to force an immediate exit
anyways since injecting multiple events is impossible.

However, because KVM copies int_state verbatim from vmcb02 to vmcb12, the
spurious STI shadow is visible to L1 when running a nested VM, which can
trip sanity checks, e.g. in VMware's VMM.

Hoist the STI+CLI all the way to C code, as the aforementioned calls to
guest_state_{enter,exit}_irqoff() already inform lockdep that IRQs are
enabled/disabled, and taking a fault on VMRUN with RFLAGS.IF=1 is already
possible.  I.e. if there's kernel code that is confused by running with
RFLAGS.IF=1, then it's already a problem.  In practice, since GIF=0 also
blocks NMIs, the only change in exposure to non-KVM code (relative to
surrounding VMRUN with STI+CLI) is exception handling code, and except for
the kvm_rebooting=1 case, all exception in the core VM-Enter/VM-Exit path
are fatal.

Use the "raw" variants to enable/disable IRQs to avoid tracing in the
"no instrumentation" code; the guest state helpers also take care of
tracing IRQ state.

Oppurtunstically document why KVM needs to do STI in the first place.

Reported-by: Doug Covelli <doug.covelli@broadcom.com>
Closes: https://lore.kernel.org/all/CADH9ctBs1YPmE4aCfGPNBwA10cA8RuAk2gO7542DjMZgs4uzJQ@mail.gmail.com
Fixes: f14eec0a3203 ("KVM: SVM: move more vmentry code to assembly")
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/r/20250224165442.2338294-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[sean: resolve minor syntatic conflict in __svm_sev_es_vcpu_run()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c     | 14 ++++++++++++++
 arch/x86/kvm/svm/vmenter.S |  9 +--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 86c50747e158..abbb84ddfe02 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4170,6 +4170,18 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 
 	guest_state_enter_irqoff();
 
+	/*
+	 * Set RFLAGS.IF prior to VMRUN, as the host's RFLAGS.IF at the time of
+	 * VMRUN controls whether or not physical IRQs are masked (KVM always
+	 * runs with V_INTR_MASKING_MASK).  Toggle RFLAGS.IF here to avoid the
+	 * temptation to do STI+VMRUN+CLI, as AMD CPUs bleed the STI shadow
+	 * into guest state if delivery of an event during VMRUN triggers a
+	 * #VMEXIT, and the guest_state transitions already tell lockdep that
+	 * IRQs are being enabled/disabled.  Note!  GIF=0 for the entirety of
+	 * this path, so IRQs aren't actually unmasked while running host code.
+	 */
+	raw_local_irq_enable();
+
 	amd_clear_divider();
 
 	if (sev_es_guest(vcpu->kvm))
@@ -4177,6 +4189,8 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	else
 		__svm_vcpu_run(svm, spec_ctrl_intercepted);
 
+	raw_local_irq_disable();
+
 	guest_state_exit_irqoff();
 }
 
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 56fe34d9397f..81ecb9e1101d 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -171,12 +171,8 @@ SYM_FUNC_START(__svm_vcpu_run)
 	VM_CLEAR_CPU_BUFFERS
 
 	/* Enter guest mode */
-	sti
-
 3:	vmrun %_ASM_AX
 4:
-	cli
-
 	/* Pop @svm to RAX while it's the only available register. */
 	pop %_ASM_AX
 
@@ -341,11 +337,8 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	VM_CLEAR_CPU_BUFFERS
 
 	/* Enter guest mode */
-	sti
-
 1:	vmrun %_ASM_AX
-
-2:	cli
+2:
 
 	/* Pop @svm to RDI, guest registers have been saved already. */
 	pop %_ASM_DI
-- 
2.51.0.rc1.163.g2494970778-goog


