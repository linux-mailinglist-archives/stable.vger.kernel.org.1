Return-Path: <stable+bounces-169685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77FEB2745A
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EAE15E10A5
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667E61C8626;
	Fri, 15 Aug 2025 00:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drO4Nayo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1081B983F
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219458; cv=none; b=kyuZREQ8/hnUqo9znLyhRJLBMmlnGNdFcPyc9ZxDCyzN6u3IbQy2Qe9ubf9xsezYAHpeYL90xGFjl22LKIX++cJdFKbwMkg2L6GxPFlWbwWxu3yooYVlNaRos3mh/h9QPiawzy9YvVRymqScaelcahdC6ontBnCbdm96DKPmPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219458; c=relaxed/simple;
	bh=j/1Lr+UronIgRZzRhuMgqCzyJ+s+Y1BrEcIfq0eFCQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQFCdzNS3LDHNACof9BakXjR/Q3rfnuacXmmUmW5E+619AFn+xbz4SXmgMXTJCuyLwxbp/Mdgo2kqITNh1DC4bf6lURqncbUwshXDvxxyccXv1dw+MpqEGB2HO78SIb4UHgib9I7cVJ+pueE1648PgEOKbTELUBqMWfpPDhmE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drO4Nayo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471737c5efso991526a12.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755219456; x=1755824256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yn2/hQHtLRcblfHHYK8i9PorExs5KUNMzDzB5HQI7e0=;
        b=drO4Nayo3eiKFeBnW8i0c8OW9xBwxe4t8szIpNQuoSj7DpPIU8qjwOM/Smy6uHXqTa
         T9UBBgu3s6du9Wqt8QMwZtP2NeeiFEX9ha8XfwBIHPSOab1wjyUg+2jZ9fBlxuEHcjsj
         +tqdS3ng1Fjw64I8HHmCJLjMJcYVfqjy6+vRvFugt6RXT2dYoaRFno+j0WVdCL1ffNDI
         fb9iqq8szs36vemosCAQp6nWwiYtqxmPG1YXcaBknDort/c0gFV7PIbyRkf+Fm4RKJHR
         HcUKIZR6qXITFBk/izxKjOdh6/5CjHtRxVy+ONZIW1XVws6DGumgN3PYD94jxbPkv4dr
         C7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755219456; x=1755824256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn2/hQHtLRcblfHHYK8i9PorExs5KUNMzDzB5HQI7e0=;
        b=NYd5eZ+vguqj2IZlPzOuWmf9hAsvnGtw5jrvqwmXwTARlFdoJfn/FYlYgNM2a78Hah
         ZGNd72HTZYrzGqhI6Iqqemo90iTzgYD1h+hi/JPlMHIbg+c+Ex+m4I2Bx4fYtpoLA2Ak
         WRTauHnDlIuJ0+CW1357HIsmmrJoSBbdCkRKFqZ1293g30nuT7zTM0MhIEJ6c4XEpj+r
         yz4u6XeXfZjldri57c49KV5tIkCZrRAdLKU9bo/TVenub9DEfUSMndUjA+8Vgfr9tV59
         wLes9y/QOMAExHqcO0q8UhekTDIZLVWPd714baHFUasDMkpEX/ATfpQcwjFX3hBSsh4H
         EBhw==
X-Gm-Message-State: AOJu0YyqP9GAiGgrBH+hVDM5AEa36bLwIXWtt/0hyMCxp8GItJ6rG5X1
	k8uTAkSFFAHngyXkarNlkIUWwSv+XmcdGdpqA9qA7fexSbhGfKp5Y2TZ4StRuHgDNhbJsdr3Ax7
	qgMOFjEMOqjFNMzKFDuUbQwzM5HD7m214GGloeIc46qibfK4qI+nJq7VutZ7Qbj6Ab1SdTODczx
	aG8kmnZXUnku2qPIJL8GYPF+b70y1cWqql5uQq
X-Google-Smtp-Source: AGHT+IFZL2tPxvArwSPUwK98zfaa8xkAH1W3s5f0rydb+BXhSEJ8YZvFix+N5zVp7GN4wzi4lQHdrQKHjGY=
X-Received: from pglv6.prod.google.com ([2002:a63:1506:0:b0:b47:4ef:fcee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d85:b0:23d:c4c6:f406
 with SMTP id adf61e73a8af0-240d2f43f2emr449311637.43.1755219455963; Thu, 14
 Aug 2025 17:57:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:57:22 -0700
In-Reply-To: <20250815005725.2386187-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815005725.2386187-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815005725.2386187-5-seanjc@google.com>
Subject: [PATCH 6.12.y 4/7] KVM: VMX: Extract checking of guest's DEBUGCTL
 into helper
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 8a4351ac302cd8c19729ba2636acfd0467c22ae8 ]

Move VMX's logic to check DEBUGCTL values into a standalone helper so that
the code can be used by nested VM-Enter to apply the same logic to the
value being loaded from vmcs12.

KVM needs to explicitly check vmcs12->guest_ia32_debugctl on nested
VM-Enter, as hardware may support features that KVM does not, i.e. relying
on hardware to detect invalid guest state will result in false negatives.
Unfortunately, that means applying KVM's funky suppression of BTF and LBR
to vmcs12 so as not to break existing guests.

No functional change intended.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20250610232010.162191-6-seanjc@google.com
Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 529a10bba056..ff61093e9af7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2192,6 +2192,19 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	return debugctl;
 }
 
+static bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data,
+				  bool host_initiated)
+{
+	u64 invalid;
+
+	invalid = data & ~vmx_get_supported_debugctl(vcpu, host_initiated);
+	if (invalid & (DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR)) {
+		kvm_pr_unimpl_wrmsr(vcpu, MSR_IA32_DEBUGCTLMSR, data);
+		invalid &= ~(DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR);
+	}
+	return !invalid;
+}
+
 /*
  * Writes msr value into the appropriate "register".
  * Returns 0 on success, non-0 otherwise.
@@ -2260,19 +2273,12 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		}
 		vmcs_writel(GUEST_SYSENTER_ESP, data);
 		break;
-	case MSR_IA32_DEBUGCTLMSR: {
-		u64 invalid;
-
-		invalid = data & ~vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
-		if (invalid & (DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR)) {
-			kvm_pr_unimpl_wrmsr(vcpu, msr_index, data);
-			data &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
-			invalid &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
-		}
-
-		if (invalid)
+	case MSR_IA32_DEBUGCTLMSR:
+		if (!vmx_is_valid_debugctl(vcpu, data, msr_info->host_initiated))
 			return 1;
 
+		data &= vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
+
 		if (is_guest_mode(vcpu) && get_vmcs12(vcpu)->vm_exit_controls &
 						VM_EXIT_SAVE_DEBUG_CONTROLS)
 			get_vmcs12(vcpu)->guest_ia32_debugctl = data;
@@ -2282,7 +2288,6 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
 		return 0;
-	}
 	case MSR_IA32_BNDCFGS:
 		if (!kvm_mpx_supported() ||
 		    (!msr_info->host_initiated &&
-- 
2.51.0.rc1.163.g2494970778-goog


