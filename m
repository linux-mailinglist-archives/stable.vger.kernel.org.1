Return-Path: <stable+bounces-169655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 641BDB2738F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB407BF7D5
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8E2221F2D;
	Fri, 15 Aug 2025 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5GnQYN5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D821D5B6
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216766; cv=none; b=iT46EdvjpxzCnqDVWlJlra5xcUTY42z92IIYJvJ0XaFx6QPsWrX5pOlERQhTj9/5r8gjHbXokj5Mar2N1EiY0/XItyb6N0XdEzpWtgqAZMJZNzRe+yu++XZ3BhWOnRApSQAwYCrrDJkXz2Cyq7LHHoXI3K+ZnAnf4EQFYmCKkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216766; c=relaxed/simple;
	bh=d4VZkPw4RAyHIWRZJDzABU/cEq7qkdsgmjzT5CLiyGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fHXjLegA1YzBY1MMGN5huMWJhsN2tUIMYIF9e9LSnGyCNM6qrpOdS2LSy1+PtpGOpHjk2hIOvnyR+4N+xmxcOdpEUvQGdim+J8sFSP5MRSOeYhFeBDTv6dPuOA1hSLec3/VldD4fym7Bt2oR1KcEUsqX/lJtd7zU72nuFO3xedA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5GnQYN5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445805d386so15510865ad.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216764; x=1755821564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eQfmi+GnDIrdp8ejQz7KjH8qWzqOpQFlk46cwdVc498=;
        b=V5GnQYN53x+sZZPDcYocLWwx8Jaa9cxT8zEbXf+PiDqEAAJuHOetTvS5Yb3PO03l4+
         gsULL0/Tv2uQ5eAYgDQ1e9oyWboJlb3kYM9dBBxiiDAcC1iPYp+Y4wJUkABpZLReCC2B
         pOxOPRm2Ue8+hUxs8i/stjZ90l+HAjZQWFGHch3fmUtO6DCQxzNdADkaS8MuS6ucV03k
         iRDwjby7Bmk1q+gROtO33562B/NUZoj5RTBdA+9RdzXndOwOSpvlD+esgwSa7bv3rPqr
         w+w0DXqHIYwHP57Q3n+S5rVqWOGAKz7DMNSW7czJclEm4nccENGApCryp5PPNgeF9R1C
         8NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216764; x=1755821564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQfmi+GnDIrdp8ejQz7KjH8qWzqOpQFlk46cwdVc498=;
        b=qQGH5kt6QgDkfB7R66dEvpdvKp7+c3bZhvXeFo/vknSrHJ3lnzm+qaqc/Z8tsA9sfm
         rPDEFTjQJI2Cy8Lh8GnoriOhkolvF73u2Fpt4WQ2YlfIMpbpNXmFyU1NirwDGwF5OPfe
         bxotpZy3XVz1h/t35AbdRdQo8MMtg2k0csW+0sklmX0twfokVMdWLDp29GMbE0CsOnFV
         sNUeMD15a7U9puKqrKVoemkjgli3qWwyroviDQySCDiAIR8An31r8mpUGHwOZyIQzlY/
         Xd0Fji6gE9Zoe3MOt0e86+o1aXKd3YNpac1k/c/qOa9BP7G6NZqRULBBXw02rrk3CreQ
         DBqA==
X-Gm-Message-State: AOJu0YzT/SU2GW4lk9jXMqkG9ZDJLl+khhZ8Eblga7uElOdjvdThKkrJ
	ZjB6WeJcVMYITwRUpEVIWIbAmsmckhqfbTmZjeIjNq/4rRf2M390NTED9RBYEdAUi4JR6hc9crM
	vzHcsDc6WaiDFjHmplNtH1qY+9pxmZ+cNX3gTBBRCg/GRLUHykQDqztAWlBHYzymKnP1C39/ygP
	Ti8R3yZ8tuxdmSxf9UdVn7NTuz77ko3AeOrklg
X-Google-Smtp-Source: AGHT+IFtuPHuUUf2dGJRUA8RXNywCif+lc9d/kdwZ3rsFPF10o+G2qnMZNWB7mcc8Bbok7Ll5v8EWWQ9YSk=
X-Received: from pjbqn6.prod.google.com ([2002:a17:90b:3d46:b0:31f:1a3e:fe3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccb:b0:235:7c6:ebdb
 with SMTP id d9443c01a7336-2446d6dc1bemr1642285ad.10.1755216764117; Thu, 14
 Aug 2025 17:12:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:12:02 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-19-seanjc@google.com>
Subject: [PATCH 6.1.y 18/21] KVM: VMX: Extract checking of guest's DEBUGCTL
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
index 9445def2b3d2..6517b9d929bf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2071,6 +2071,19 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
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
@@ -2139,19 +2152,12 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -2161,7 +2167,6 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
 		return 0;
-	}
 	case MSR_IA32_BNDCFGS:
 		if (!kvm_mpx_supported() ||
 		    (!msr_info->host_initiated &&
-- 
2.51.0.rc1.163.g2494970778-goog


