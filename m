Return-Path: <stable+bounces-169665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B281B273CA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172357B67BF
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5751D5AB7;
	Fri, 15 Aug 2025 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWSl4Qba"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA91C5F13
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217557; cv=none; b=lZOvyk8H0Y8hyjvHYekjz1qGMpRUA5M9Vnysta572Z3BqJbf9p1XDPWT0AsjJCkODXU725aAgeM6MSBxi3sQG7/QS+qWgJxsoXwEG9yGqfB0JMkQw1OZoZomn/QB5N87TVXPJ2FukpwpL6397a/9Gdih4IEcWt755kQY2vWEDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217557; c=relaxed/simple;
	bh=aKVZRG0JRLvF8phuQEYODZS7/hW6QX6UzV3hwELyHNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K8VxYizj8A6SSKnFvMP2ZO5Z2E5OaWOiSDcX+7dAWS+uXwd6YhKLQe1xcN++NKstUlDfcSiyvw9ewDAw7mXUzlFqnkBLb/XPGrEXRLVIfmPn9dJTUPgzSXf3AgwRFQ1HdraRQ7fjn8GCOFsM5xRtTCLCi35eqsfTgcR3gYQ+wvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EWSl4Qba; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb9bb19so2289923b3a.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217555; x=1755822355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rPOzKFPxGT9sPa6ldSUH//rHHKSpsCJXfaRkVH3vZ5A=;
        b=EWSl4QbakILTYwUZayN9raRw8scmsed3mAhZMwz+Cp8jNRhUNs90OWpyTm/iWgZEo8
         kc+wIePy+Jd3enUxjT8XsMpnzn+JnkIjEHRtAmf3Px96iR427YrCHluFKeFUtvfL/tNJ
         0m1S0W4QSkBW/cAKOyxFdkaAFkxqskPtXfH6WAXGKw3FuMPS8/n48070k/mbFwtsPefC
         pK4E5qDFWjwIYM+GTSkQOY/PFwzOP4UEzvfEsZdUQQhGsN7GMDdpvcOADvxEpmQvYc8T
         srmYDCfoONGz+ayOg9JOqnIPiIyElHljTN5U+UDXK/t+H9LRCrlQ5P6EJFJ7gcD/ATOP
         +T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217555; x=1755822355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPOzKFPxGT9sPa6ldSUH//rHHKSpsCJXfaRkVH3vZ5A=;
        b=uHmE/W8aTOGaPSPAKewCabhpVKHLSgkm5RZIKm0LtKIexHHlXSOjnzb9AUAV8U5SGG
         nGvtRwkAg0wl6lYfG3LbXA6uq7lyFG7wdeyOvYYMvzxtI/BhJwnyC6LlAlg8hc9G4mKl
         3RxkTmSaTxgz0Dhnx+Y7D7W7zlI2SfxvSEHkXIE0cOllA5lwacIv6zQPJbkYrywoF0Z3
         V1iYXtxgbEWUOEH13E3OU2P1P/ZFxCT12CH+jcZYn25DVIFZeJ10tEvt4m0I6NUnUtTo
         TniJn7HbuMhSXnJGjVEeM/9Afe4rHALmgh9gUpNvYYR+mLwAWU92FwZqclzEVycdjdFX
         WHqg==
X-Gm-Message-State: AOJu0YzZPBGKDq1yEyy+4mWGaF7Gjv9UNARq+yqgcnxQoRsNL4Wu4R58
	ItLNCgYjA0P1eQigMt+kSgbVdXJuh1qhTy2wfjCDF7yV2eopJ04hra5aMhTYdahLqs+Cr7ceyVq
	zped9ThTt6cUsxut9QSac1QPiSfB5tauKXRNKiBwq+yS+5i93+HU8xjUYWOyt+ye+UbJqMhAG9Y
	/aa7DwGZvBge8Sy+aVSteYVBXmEFdxbwsY5cY/
X-Google-Smtp-Source: AGHT+IFSZNuzQO0n+8mCRIX/sYOuoT+ph9KSlhpuxnuhywFMOY0u8KDbxD0H/EWNUJ7Hk6ed7dDmCQ93ytY=
X-Received: from pfrg12.prod.google.com ([2002:aa7:9f0c:0:b0:76c:33e1:be00])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c91:b0:76e:3668:7b08
 with SMTP id d2e1a72fcca58-76e4480b219mr66332b3a.16.1755217554742; Thu, 14
 Aug 2025 17:25:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:26 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-7-seanjc@google.com>
Subject: [PATCH 6.6.y 06/20] KVM: x86: Snapshot the host's DEBUGCTL in common x86
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
index 5fc89d255550..b5210505abfa 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -733,6 +733,7 @@ struct kvm_vcpu_arch {
 	u32 pkru;
 	u32 hflags;
 	u64 efer;
+	u64 host_debugctl;
 	u64 apic_base;
 	struct kvm_lapic *apic;    /* kernel irqchip context */
 	bool load_eoi_exitmap_pending;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4563e7a9a851..9ba4baf2a9e9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1499,13 +1499,9 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
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
@@ -7414,8 +7410,8 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	}
 
 	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
-	if (vmx->host_debugctlmsr)
-		update_debugctlmsr(vmx->host_debugctlmsr);
+	if (vcpu->arch.host_debugctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
 
 #ifndef CONFIG_X86_64
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 88c5b7ebf9d3..fb36bde2dd87 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -340,8 +340,6 @@ struct vcpu_vmx {
 	/* apic deadline value in host tsc */
 	u64 hv_deadline_tsc;
 
-	unsigned long host_debugctlmsr;
-
 	/*
 	 * Only bits masked by msr_ia32_feature_control_valid_bits can be set in
 	 * msr_ia32_feature_control. FEAT_CTL_LOCKED is always included
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bc52e24f1dda..ed16f97d1320 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4823,6 +4823,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
+	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
-- 
2.51.0.rc1.163.g2494970778-goog


