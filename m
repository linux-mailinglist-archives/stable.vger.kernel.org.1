Return-Path: <stable+bounces-169681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A70B27450
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715851CC0084
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF8015278E;
	Fri, 15 Aug 2025 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNtZ9T1i"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367B56448
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219451; cv=none; b=C2B1Wep5WghzLZ4K9fkPWrr8NH2BLBxRaicZFzeOGKDwKoAgeiq1P2awF/ZZedsvWCksb7pkSaIH1wk07S3djwMXm2EEu3ZN0ZM2phOqOiPP8ne0ItP7jVOvDjahEUkH2xvJJ1jr+UBR8PaSnvRd38wJ6TEwAzZHH+rFObWCni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219451; c=relaxed/simple;
	bh=9t9FszQWUhMri63drGVSczqbrk4+8tTMRg7vpbRoElE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lp+loQ61vjtBeyqX/pvwmYmAiZWIXlTsgYev0eqdMeGUYp1USkk8FGU9HJ1ZLB/s6le1vV/GjQUuDsI9DGLath9kWaF+jwZw8uU6m961otFRrb344t2PIvUnUk8ff1kUXCUJxDP1Zcf63rlnJnjx8s9orUHjhbk9LnGew32o1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNtZ9T1i; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445823bc21so30264645ad.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755219449; x=1755824249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiwqRmmCbJXPteijHQcOHZyVOII/6Ocy4eYGUGiwKhE=;
        b=gNtZ9T1i7tT3qsRJZ+m2iebh44delc+lq86uHQ8amyDve2t+/DhkMeZioYc8+Y5jkh
         zzHlFmWBCCrO/UuMzZz0tSqwD22pAzEad6qmzrXLGiZtWAJYMC1DkfP02b4rrDaJ3WjP
         xs2u96giYCQyV4AvYVboZ/aWst/TPbJ1cT0ERzwBTR56VR7K+AkudKM/iHoWnDSO8oXF
         4WwaVy7dnw369qMnV7AdlfHhovnPy5/TKKQL2iHNWkZfSYTGlr3D1/gt/Oa7P/+UHbg4
         fcCZgxrD4bGypUcr7MuS3wlof7/Ub+2H9MIftBotbNFCECCAupJWjBmWm3D9BvIOrpi6
         cZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755219449; x=1755824249;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiwqRmmCbJXPteijHQcOHZyVOII/6Ocy4eYGUGiwKhE=;
        b=hE0CEvIvzXkPyF8sItJGnvzGj7S3QfzE0DPqKbwbGKRD5wZAIghYCPbucPbldun39t
         UC5mh7au7zvISfv14sfeXExd8aCDmmiHAcZf5YpsTQXUY6dmSyH6d6tB91Z+pFHVpfTY
         CNurAB6tjDnYPuQN5G9jmZYPQeSq4SljrqOFR+KDdEzgFv6Wol4SW3J1S48mamFbCoE1
         xA9ajMazvuFjGDWFl+kgaF26H/cTE2VU9C6L8Vtn90QdnJzyrH/3p23BxUgLm0nBG8s5
         kLbzBM2CTcEyp+ep9dZKDSd/lY+s4JKFnansnGhY/1oEAYid2C8/vuf1h7ZHqh4qdJKQ
         oNMQ==
X-Gm-Message-State: AOJu0YxVikPrJf5LWaRXCjyuvINE/oS6LDWsh4tHAL07B0nuEIzjrUbq
	cYpES9D88y+xGI2UIU+2oiGtndTsigEDPqfvFZXBuwv8AWn9bIRLt9rsvYmh3VyFPwmq+mUF9Xg
	MOHsWVt00dNRi5GGNzIbPLx6upoOyq23n8yvgMsi6CkhqkayKtqUkuFbxN649jS0glKeRo3dgMZ
	+VHtNVjgh7uA61p0dzZeo2XqiUTkeFLF6JFat+
X-Google-Smtp-Source: AGHT+IEr6R4fe01LLKu3KV8wgkRfMZ3b9gIIuv8qMD6A7q8+n+fl8TsnN+y41iNkRNs4BR6s5fMF6bIaeCo=
X-Received: from plbkw12.prod.google.com ([2002:a17:902:f90c:b0:243:47b6:afae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f82:b0:235:15f3:ef16
 with SMTP id d9443c01a7336-2446d6ed729mr3093825ad.13.1755219449271; Thu, 14
 Aug 2025 17:57:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:57:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815005725.2386187-1-seanjc@google.com>
Subject: [PATCH 6.12.y 0/7] KVM: x86: Backports for 6.12.y
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

More KVM backports, this time for 6.12.y (and with far fewer dependencies).

Same note/caveat about Sasha already posting[1][2] many/most of these:

  KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
  KVM: VMX: Extract checking of guest's DEBUGCTL into helper
  KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
  KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs

I'm including them here to hopefully make life easier for y'all, and because
the order they are presented here is the preferred ordering, i.e. should be
the same ordering as the original upstream patches.

But, if you end up grabbing Sasha's patches first, it's not a big deal as the
only true dependencies is that the DEBUGCTL.RTM_DEBUG patch needs to land
before "Check vmcs12->guest_ia32_debugctl on nested VM-Enter".

[1] https://lore.kernel.org/all/20250813182455.2068642-1-sashal@kernel.org
[2] https://lore.kernel.org/all/20250814125614.2090890-1-sashal@kernel.org

Maxim Levitsky (3):
  KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
  KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs
  KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the
    guest

Sean Christopherson (4):
  KVM: x86: Convert vcpu_run()'s immediate exit param into a generic
    bitmap
  KVM: x86: Drop kvm_x86_ops.set_dr6() in favor of a new KVM_RUN flag
  KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
  KVM: VMX: Extract checking of guest's DEBUGCTL into helper

 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    | 15 ++++++--
 arch/x86/include/asm/msr-index.h   |  1 +
 arch/x86/kvm/svm/svm.c             | 14 ++++----
 arch/x86/kvm/vmx/main.c            |  3 +-
 arch/x86/kvm/vmx/nested.c          | 21 ++++++++---
 arch/x86/kvm/vmx/pmu_intel.c       |  8 ++---
 arch/x86/kvm/vmx/vmx.c             | 57 ++++++++++++++++++------------
 arch/x86/kvm/vmx/vmx.h             | 26 ++++++++++++++
 arch/x86/kvm/vmx/x86_ops.h         |  2 +-
 arch/x86/kvm/x86.c                 | 25 ++++++++++---
 11 files changed, 125 insertions(+), 48 deletions(-)


base-commit: 8f5ff9784f3262e6e85c68d86f8b7931827f2983
-- 
2.51.0.rc1.163.g2494970778-goog


