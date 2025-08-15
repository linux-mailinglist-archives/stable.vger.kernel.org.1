Return-Path: <stable+bounces-169643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC0B27376
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97C99E40EE
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A021B4153;
	Fri, 15 Aug 2025 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBLlzg0m"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15B199E89
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216745; cv=none; b=Dm6OR4A0eJcOI+TQXLXTbXs23ZbEa6t4jJLScBjlH/fVR7Dhh3PdVb9SqFbNkPJHxfQn8TRMf+XIj1ckhz+u45RqxOcn9leOx/mbcCOYnkg1+YnZcDmPHr6QrjrL1ec9bMu6Ccm3wJeqhZg6GQk4chHzszBWSOdPG0tG+xQptjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216745; c=relaxed/simple;
	bh=O2LmGYHZhZkLGwfBk2Yp1f3Rs3CptBnqxMLK4Ir6eIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PD1x3OJBK6ABPTePkgKxoVMbPAp+YlzdLQ6/ix0Mjohf6TrxX8w5JIKOVLEs5ltu/PNw+1HV+df4fx6/kUTFQbMv6qOUlGMAeTweXiRc0XzIU5SWnPZzXJsiBATqyyR+NJmQIPLwOc0hVv45KzQdid+WIwtbMwVQxJ6qVuydrtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBLlzg0m; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f4f3ecso15734995ad.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216743; x=1755821543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pXQWA5FLczzcFgAGgva/tQ0VYzpmUU3vq4Bm8GhyjFA=;
        b=YBLlzg0mkSm6/Ww7fBGiaZIX97n0krr9u04Ap6lJlCXxVrnAiKzHghNszY94RBDbOt
         ty7hbuCo1Pv9zC7cX2wPEKyMWuhnLBl3ATGB+fOAFLRPR01tAHEhRrKopJjZoI2z8OLy
         rgpshn2ovCtYtmPQ6Tl8qGbo8oW4j2eqKSEwPoQLn78NS41rSPUD0yFfbl8E/qVMfjc6
         hEt6dwE/wb7H3Kp6MTrQuAAYgrlRWhLjJpz2ZsTfCqlNyQcN68RqqzFrs1jBoKoBfKLi
         UoHNt7ZlDj9i5IyBPcI2cFuvZhlyyXZGgOAw1IoR6yddhEyQDSTPI5uqmqnmJ2Kiv992
         MXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216743; x=1755821543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXQWA5FLczzcFgAGgva/tQ0VYzpmUU3vq4Bm8GhyjFA=;
        b=S6zwETw1KXhrBs8e8gEWw8jjnkzRXUTAN74QRTnp2hEkNaxvxC21kDAFCPTclC5WUe
         beGvdlvZasYAfqvK8E6xgoLLdm0yPxpEAdlgrzqG304pfKrEk5Qg6qwyYsWVxwtmXkJ5
         nDYfnxlC75ROszAedDwNUUUxHI55J3OONp3tCKgp4edGzclHp/LaNAC5M08JJQzteR4c
         JrCX/6dDxmCnHS2NLK2W0N6kj5ts/NCmjqOV1cOlYA9/7stC3f12+t9UxghECA4yCbJU
         z+VuSUy1uJPuEZJ/iqmGl1R6R4lVuGcAH9Yr7zSabzkvaWBj3oGU0HLDJSLV+OW0hFAZ
         x1TA==
X-Gm-Message-State: AOJu0YzwGUrsohnSKqOkbk2FyiZLNTjpN3aeJ7A5OH43TF5wOsWksH6h
	o0PSaOUoaFuDetDrdA3c6kdPhhLc0WY4qB6eDoZr8mkQjy0jhBGQN2vl3dgCBOICgcQlBnGUz12
	Mv1W/dCtnAPiLy9AJb0ROdrl/fj45zdTh7w96RoFAHelxDotI3wDcueaxxXCZBq8gqhaCleuhB5
	Gr30p6564rhfKdgqQINAfcP+JSFJIXBT7zBAQ+
X-Google-Smtp-Source: AGHT+IEpd6403VG8BvXCtL5Wm0bfYaHW/IiE3Ya7RRt9tZra7RgrQ/Ti92XyDRtdQNwdGxQoM3swrEunIu8=
X-Received: from pjuj12.prod.google.com ([2002:a17:90a:d00c:b0:314:29b4:453])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac1:b0:240:3db8:9adc
 with SMTP id d9443c01a7336-2446d5ac887mr1825575ad.4.1755216742609; Thu, 14
 Aug 2025 17:12:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:50 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-7-seanjc@google.com>
Subject: [PATCH 6.1.y 06/21] KVM: x86: Snapshot the host's DEBUGCTL in common x86
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit fb71c795935652fa20eaf9517ca9547f5af99a76 ]

Move KVM's snapshot of DEBUGCTL to kvm_vcpu_arch and take the snapshot in
common x86, so that SVM can also use the snapshot.

Opportunistically change the field to a u64.  While bits 63:32 are reserved
on AMD, not mentioned at all in Intel's SDM, and managed as an "unsigned
long" by the kernel, DEBUGCTL is an MSR and therefore a 64-bit value.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: stable@vger.kernel.org
Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250227222411.3490595-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[sean: resolve minor syntatic conflict in vmx_vcpu_load()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/vmx.c          | 8 ++------
 arch/x86/kvm/vmx/vmx.h          | 2 --
 arch/x86/kvm/x86.c              | 1 +
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6db42ee82032..555c7bf35e28 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -677,6 +677,7 @@ struct kvm_vcpu_arch {
 	u32 pkru;
 	u32 hflags;
 	u64 efer;
+	u64 host_debugctl;
 	u64 apic_base;
 	struct kvm_lapic *apic;    /* kernel irqchip context */
 	bool load_eoi_exitmap_pending;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7b87fbc69b21..c24da2cff208 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1418,13 +1418,9 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
  */
 static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
 	vmx_vcpu_load_vmcs(vcpu, cpu, NULL);
 
 	vmx_vcpu_pi_load(vcpu, cpu);
-
-	vmx->host_debugctlmsr = get_debugctlmsr();
 }
 
 static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
@@ -7275,8 +7271,8 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	}
 
 	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
-	if (vmx->host_debugctlmsr)
-		update_debugctlmsr(vmx->host_debugctlmsr);
+	if (vcpu->arch.host_debugctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
 
 #ifndef CONFIG_X86_64
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 8b4b149bd9c1..357819872d80 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -352,8 +352,6 @@ struct vcpu_vmx {
 	/* apic deadline value in host tsc */
 	u64 hv_deadline_tsc;
 
-	unsigned long host_debugctlmsr;
-
 	/*
 	 * Only bits masked by msr_ia32_feature_control_valid_bits can be set in
 	 * msr_ia32_feature_control. FEAT_CTL_LOCKED is always included
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 08c4ad276ccb..2178f6bb8e90 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4742,6 +4742,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
+	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
-- 
2.51.0.rc1.163.g2494970778-goog


