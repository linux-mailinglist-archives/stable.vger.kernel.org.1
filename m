Return-Path: <stable+bounces-169666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D7B273CF
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A12F1C249B1
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3747F1E1A3B;
	Fri, 15 Aug 2025 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/WYLAKy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E51DAC95
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217559; cv=none; b=qsTXiGTifimM7U8T4lOCOwj7NkOnz4XYpO4v6ufF8kxua21f1EbVTcrFgvWCqYWkK9yQnTJ39lUC+Cg0F0qoe0U4D6PQvk2QzjOnqPocRQ2LclQ9Q1+/wNdUQvBTSpiGFMtSny1nS0v4NwIS8CuG1XRHjekGLjxKuhd/QlBgE2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217559; c=relaxed/simple;
	bh=8dGhxK/JkgmBijADhNtAV6zAXFcteW9wwepKGar5Zv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mc8PmunMJmJaC8tPJFxhItvpO9LWGYKLpNB9x1B87JEgBMcnTZsbTH7NvURb+avAJfXoBiae33e4kz0VZRXF/OmVLi8TOH0BdpMHa5yrJXIYeEt0K9Rlw88DChFeCSkZVN2p4KYL4mh3/zRqQin55uVmg4TINbtAas9+l1m+UHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/WYLAKy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e8afd68so1230501b3a.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217557; x=1755822357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cctxdklEYGo3fsEjZ/qF2IryNO6hLou1BdjReTJ9XXQ=;
        b=x/WYLAKyPzs2CL6sPf0o7Ll0xvt5/KwbBtdEANFg3BKB9u39F511GvVNb0U86Pzlxg
         h4AaShVchL0WznGa4RG0EPyssNlikjIObdFzZZnCjaBIWKTgHvsteKuHKkrrXicA+fcp
         SYnrTatOAsxjv8h33TNrJYRJ9WfJRvhU3nxGOb97MuUzqU+v9QRniYyHwcHX4otIRLVl
         EIZPcRkR7ESWl50UxeCrUCmf35jlLuDzmXTBSZ1C0yRDjdCtwWR07zwLIOUWO4ZJ6zD3
         Y1w+ONHFYGYi7M/yPU+q1+scZdaaed1Y8NXtT+uQiQPBzTsBCURoDRrJjVp0oc5qhfcg
         M43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217557; x=1755822357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cctxdklEYGo3fsEjZ/qF2IryNO6hLou1BdjReTJ9XXQ=;
        b=KegE0HicZqnB56VzoGHjlgjQ0SIidqpE0KFbT37YA+CMqKKkcPYcAXHBwrDT6FECai
         VSGSwHN2qLUTUMe+LMo9SanQIH9fOlClY2/oQ3RVflSUebhjtOEfN6aK6uNAHsMSdW6T
         scRzy0vB3uTP6Zwpvitwd3S91/VtRSJBSi5Hyw8t9hm0o4B6lPMRlsUA1JOB+6rlUKVj
         PLdwvNgsNDPhtS5oDmsIgUZyudOEeBcb+QWsSb/PqzwKaLs0MV1O9a1Pb3XjnOOUT1st
         RKPfw59lXGMOHbvCzyS7UpRoi3gHtEiQ1Ov6yBVY/3ZxcHaTNG4E56cBXTfnH7LxahyH
         zSkg==
X-Gm-Message-State: AOJu0YyTcicGifCqnhAvJQCPqyGH3Su/TvWKOLdOIG1LH1ID9Nrtvbdp
	TmfBgRgVolzg6A3c4ruCBhWfKQz7xmizsBT814yAQ2PzWYMpU9oSlSsmpI9IWt2I99sdQrmw/WA
	FyTNJ0q9DeSnaTNoH5voe2E+6Y920SAm35KVCzMR6kKim2+CCXybKNLr+we9F/XC5Ubizjeh9ji
	//IcTkjWERLfBBB/Ssb6kjPKcSC556jH8M+9R2
X-Google-Smtp-Source: AGHT+IGvH9IFV195y28sIIwLG3aGx7vkoPdbO7saKYfTqg5i8QnHd16IdWLXrxZFrfkhUCUiw6yuZNROGVc=
X-Received: from pghm22.prod.google.com ([2002:a63:f616:0:b0:b47:35f:5e80])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748c:b0:23f:fd87:4279
 with SMTP id adf61e73a8af0-240d2d889f8mr371554637.8.1755217556680; Thu, 14
 Aug 2025 17:25:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:27 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-8-seanjc@google.com>
Subject: [PATCH 6.6.y 07/20] KVM: x86: Snapshot the host's DEBUGCTL after
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
index ed16f97d1320..22a191a37e41 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4823,7 +4823,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
-	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
@@ -10782,6 +10781,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	vcpu->arch.host_debugctl = get_debugctlmsr();
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
-- 
2.51.0.rc1.163.g2494970778-goog


