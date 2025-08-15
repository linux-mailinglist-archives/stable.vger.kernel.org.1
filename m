Return-Path: <stable+bounces-169644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CB4B2736C
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABFE5E85CE
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6221C8611;
	Fri, 15 Aug 2025 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXQDQea9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0DEEA6
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216746; cv=none; b=bjEsNbjRv8+Tb+yfziZmRaPQL47cHD+Vc2eb/CuHwhuB5pSnwNnUlnMk4awFxHaDdT2U1nDPjuV7QfE6H+cMG+q2N2qpjc55vmTfoQVKwaVGfYPirQMy9UJOPMW9byxTR2wZOmSChP9A71l1HaN0qfZMokl3NjMJYq7Y2HSKxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216746; c=relaxed/simple;
	bh=BtM8dFTmM/9dZyw4RXoSLIMVKXsY5bNsgrn1HhBtzJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pyJEWl5aGdxevLGgmrBWVFawIYnpVc2c2PC57PfBJMos77/ufezL7HAGfM/1p6hjYVq8ufG4oIMzl2U+0lBiHWu8MtlzRhKDldDWeRXsEvn1N6qMxcuTPcmAOzNf6mk9AlhVeA3vHHb0UVwPEGSi8OdXikd/PckaHc4EZC8FBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXQDQea9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47173ae5b9so1008320a12.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216744; x=1755821544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BXUEX1H6LyLUJSMPiSF5Cl3sy6zgRvsqwEwkPUOpCvs=;
        b=ZXQDQea9fO2ch2wBlP47qxH3lBvsXLDT8Q0Z8cHAYvXRkqN/An+nXX+R8jQoftaGCD
         1PP6S5w56GQXE9L/UoZb3RtGQNDVrM9i/+RHFXs5E/u9xUkKFyi6m5smhkTOdnzKx3V4
         s0baNyKWiiW11R2eK7yzs/XpwTNIbEWX3JwhVBlfBK1ku2uJvMaDIjvROfjAOhccYSo6
         59smYawOQe6h9LNTe0aGqESVeGU5ulg00wkqAgma/IHV9a8LK+YvNzf1V61OxX5LfZK8
         DI9Vu2xZ4+mZ2ZhTtJt6qw/udEgvq+de297huT0oKmdNq8aex24DfVsinnL/1dJ13+Hd
         yQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216744; x=1755821544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXUEX1H6LyLUJSMPiSF5Cl3sy6zgRvsqwEwkPUOpCvs=;
        b=tRE4m4AE3sAcaYjB2rtyfXLt4XFc26rkA6FY6NwwRjpEcE8/yN+LD/EIiOTnHoY9Xy
         uC41pFcALusu6S0VdOqjJM7nDOI1lwNFziAMHwmDjY0kRk+/npFj5YK+i5I4ZZMl363G
         coEqvh4K3UleF/FXCbam7njb3lUscia/gncBQOa68O238DGiLbkEclj1idNvBrRCi8QH
         PijUadJN7Tm47V1tgFnKmt+06NDHmC52J3dsOr4l47eDMItxNTSDwbcN/xb6m3ICL4M4
         HRTPzMGTDpc2xda85su/AKJKPVd5t6ENSnMj6HMFR9Hry65tKVyvSkTHlplMFj6zYB6t
         bV/Q==
X-Gm-Message-State: AOJu0Yxmv80CfCt+iDYoAUFrBgx8BoXQ8YaHwCK5u/uI3dhQnK9Nxb3Q
	wzq6LP4t0ICNdq0kt2/9TlQf4N42TTw2AaDBJJV34v2XzAmhHE1rmwuH2roClLN1gv0dCEqbMgN
	VaU/ZosFXA1Q7VQp43lLyUssqAuzHJpjWMk/dRe4w5oVNTl4QcU1GNlmHnB7kQotA6DptxH3bIk
	wT+YiTrgVSi1TeFmW8yjk3WOHxuM/EJ6NiCNSp
X-Google-Smtp-Source: AGHT+IEL5helDYMbTg+EjsCxZbXQyOUBux72Tc/5TNXET/7xtgbFbL1AxnUElCcBkw/pIUt2U1qDn9Z+2G0=
X-Received: from pgg2.prod.google.com ([2002:a05:6a02:4d82:b0:b47:16f7:2be5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9392:b0:240:252a:158e
 with SMTP id adf61e73a8af0-240d2d913d0mr350688637.3.1755216744472; Thu, 14
 Aug 2025 17:12:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:51 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-8-seanjc@google.com>
Subject: [PATCH 6.1.y 07/21] KVM: x86: Snapshot the host's DEBUGCTL after
 disabling IRQs
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 189ecdb3e112da703ac0699f4ec76aa78122f911 ]

Snapshot the host's DEBUGCTL after disabling IRQs, as perf can toggle
debugctl bits from IRQ context, e.g. when enabling/disabling events via
smp_call_function_single().  Taking the snapshot (long) before IRQs are
disabled could result in KVM effectively clobbering DEBUGCTL due to using
a stale snapshot.

Cc: stable@vger.kernel.org
Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250227222411.3490595-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2178f6bb8e90..0c3908544205 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4742,7 +4742,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
-	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
@@ -10851,6 +10850,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	vcpu->arch.host_debugctl = get_debugctlmsr();
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
-- 
2.51.0.rc1.163.g2494970778-goog


