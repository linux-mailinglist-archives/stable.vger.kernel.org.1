Return-Path: <stable+bounces-169675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A72B273E9
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A43A177BEE
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF1A221265;
	Fri, 15 Aug 2025 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knv0Q+Ou"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E821D3F3
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217576; cv=none; b=ui4xy/nth2y+GMQhr9kS0RxxXG8GHdekrV5RsMlFt8rlSd6ivxp9crssVVnpaVajVLZK25LZjTrYC4NwZSMq5HEl4mhQi2tZDL+BCAb1g8yH+TVmEIzQHn1XVApWW34Ur3K+JmnIeNmMhH4N4/6A7NWVQ3h8F9b+UwzJ7u5XtqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217576; c=relaxed/simple;
	bh=/IiKb2UN6NIrbOOa08VQXgMrzpDFlocGasn1XlZEIGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kbHeWMSQtJ3VfRjg6p8BIjggF8T++u4L3EqzNElqRZ654B2HWXr9z5s1JwaP6hJb/tOJZGz6XT0pKwotu3I9BKNUNlIvJBikrwifAkr/xz86hv2VlbdzZvFh/mSL+uSJ5lcYXJKaAovQojAvjS2AmuuH+3chxKU+Ulen6iGrXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knv0Q+Ou; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f440f0so15063185ad.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217574; x=1755822374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zWqf+ODUewWqtQUwrkc1cIbhsaF3K9K+427e32UUWjo=;
        b=knv0Q+OurA2Cx/CDIokpEESNN+Nfg0FCsySgkNE6cNiPQeRcZihiRjL6nJ48MnI55p
         cekl/GciviF9+ld39okyOvl0YOosE2yPCKqhKG51khZbjrU0muc3P5PmIJzRIhpY7z3J
         YX3jJ9if+WnIu6Ubg2eQrP5KSXJ3CEFiCX8OAQiBTzJrbe0nUIpc1r/oW+GQCXwEdZ6w
         +AEnJfEHfAffdO/9vtfqgAbQJbB1+I8sAkSd7eetezWE/or2waWRmJZ3F52XtcgyVzG9
         0r29a3xPzAD7N4H0N3V5HkPlWGXkBTbnsLDtBrWx7FwrqVOgxNVuoalmp2WL52D3rQik
         5WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217574; x=1755822374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWqf+ODUewWqtQUwrkc1cIbhsaF3K9K+427e32UUWjo=;
        b=aNR7uDUiKduYEM1+fPdwMPeOTYnwuGuQLTxUEO9whYsUe/QYI7PdMh40eBNUWcxMe6
         Thssb23ty0FlW7HEsHHoQHfspWqofKjiQfihLP6iwOZqE12ujqV2CQHxzye5NUrSZYLf
         EC3Aid8rPIOHEYhMKePxOT5F6wpCNugsLYCMP3XYOpjlLEYOu3cBdjsrf6B7lwVH0u9a
         FuYu4ypRWemltFlG4Z9HqCwgpCzlRcBcYbKl6tEyyTHV00BT+sE43wjdGhqRq5X3vdeA
         KYFRK1niMVRyPsMvsLCEkdrNB9GVP/mJEOsZgVT2LSXWNrN6iOtcXuZw44i0v76AgzUz
         T94A==
X-Gm-Message-State: AOJu0YyinQNlJNWXoLeMxANMT9VN9Kz8MxUs7Lk/oBMRkKYIcme7PpoV
	FHAcB1NR0kzbXMxCwmldvx5Vh2HR+9ve6wdgw1/aCf6PoDnRipAC/M/rZQduukvWmVWfL9KCzzY
	njgpP3+Yfp/TJ0u6eLzAj4A6H1x7n3TvPo1aMt2to5BHxtvye5g3beFKoLcsnlEHeuQgdVibqs8
	ql5j+NMHOnJtuXSncvo6ZEE5xoLMjHtgoMMfab
X-Google-Smtp-Source: AGHT+IHabHEkDiu3aHpCxhpBkfZt77DDXCcXMkgWTbHMtwvNhlVRz3tRq+jdWNuZp9kMhjiWHZ4O6g7zjRQ=
X-Received: from pjbsm2.prod.google.com ([2002:a17:90b:2e42:b0:31e:c61e:663b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84b:b0:240:5523:6658
 with SMTP id d9443c01a7336-2446d89d22cmr2336095ad.29.1755217574277; Thu, 14
 Aug 2025 17:26:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:36 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-17-seanjc@google.com>
Subject: [PATCH 6.6.y 16/20] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG
 if RTM is supported
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 17ec2f965344ee3fd6620bef7ef68792f4ac3af0 ]

Let the guest set DEBUGCTL.RTM_DEBUG if RTM is supported according to the
guest CPUID model, as debug support is supposed to be available if RTM is
supported, and there are no known downsides to letting the guest debug RTM
aborts.

Note, there are no known bug reports related to RTM_DEBUG, the primary
motivation is to reduce the probability of breaking existing guests when a
future change adds a missing consistency check on vmcs12.GUEST_DEBUGCTL
(KVM currently lets L2 run with whatever hardware supports; whoops).

Note #2, KVM already emulates DR6.RTM, and doesn't restrict access to
DR7.RTM.

Fixes: 83c529151ab0 ("KVM: x86: expose Intel cpu new features (HLE, RTM) to guest")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250610232010.162191-5-seanjc@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 arch/x86/kvm/vmx/vmx.c           | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 033855457581..723e48b57bd0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -380,6 +380,7 @@
 #define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
 #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
 #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+#define DEBUGCTLMSR_RTM_DEBUG		BIT(15)
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 08ca218ee858..359c3b7f52a1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2161,6 +2161,10 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	    (host_initiated || intel_pmu_lbr_is_enabled(vcpu)))
 		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
+	if (boot_cpu_has(X86_FEATURE_RTM) &&
+	    (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_RTM)))
+		debugctl |= DEBUGCTLMSR_RTM_DEBUG;
+
 	return debugctl;
 }
 
-- 
2.51.0.rc1.163.g2494970778-goog


