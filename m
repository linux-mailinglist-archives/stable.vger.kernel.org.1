Return-Path: <stable+bounces-169637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6006CB2735B
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55AF1CC4588
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7ACCA5E;
	Fri, 15 Aug 2025 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3mQMrUkR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746479F2
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216734; cv=none; b=O55nFxa0t7uALe322UyW8MhkiyK1W4Vyxt2gtDrGTitDI7FK3RJFNhEpk9gcbPxuntqs34zUqaZuQ3Q+zZoIvCjfIC+LGTIEaerb26MRZj/rql2WaiH14W3uqzwJw3/khyRxFPSSQo5a9GO0/wZiXo+KQWvwEib+Evpzw0bfJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216734; c=relaxed/simple;
	bh=PSbWRkWDWAXRqvMTOsM61pdFwGMhyKjB571cV/kv8gk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cuzlMvLwLrasNCpOfjDtCJIlnMtES5ZJ6HRJ4O24wHfQQ/joCB5B7B5iRUoIuIesSiiHd/BWwWWftgo+Ug448vdMVCMsjYTCv4NinGaqTYmD8xdnW/l7Z93rFhEaqExQeBOuLRrcpEZgpZkJC80PT+spC5gouQJncRx/fd5/vw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3mQMrUkR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e21dd6so2805984a91.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216733; x=1755821533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok+I0st58RMtMAstkKTeaepbV94MPcGrW0RKMyU13Ko=;
        b=3mQMrUkRG/CAO82IJwSVcyQxihLa5hS/F9tJQDAfGqNx+Onxa+2evF6IzkXdW+QjjI
         xVAEU4pykTz0stf4DKv/dk6PTzJzSrnPYmPzTtlWqyqjvTNabhnUOv4TEDq+V8OiEfMz
         hx38y+5yfrjJ/Z65rrlfmxmyDoZ1UeDQM2zl6xM6f/GVVLQ6kMa678IkwVySmzNPXpe4
         MK9Wuv1U+g3399jLH3YW6QV8Hw8r3rQ5Zi31UZw89WtgprVBNWJQKGBrROHyygBC1lXY
         VqPdcv15+giNz9f3neOrxgzRtU30/3Deew4/Aibv/CW1G41srGzk0TiV6ItaTVuv5PPV
         8Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216733; x=1755821533;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok+I0st58RMtMAstkKTeaepbV94MPcGrW0RKMyU13Ko=;
        b=sQ+IpQSnZVof310u2qX52trRADwQb3EqSr+D1AXJ1bW8d//n3v87EwYQeeBMIOVWh1
         RoPE9ySp14n6nJ41v1owgPzs47PmdsW82OhxqpHEp0rnzsPaOPTd7Nrvk1rxdzj6Bvnc
         kv9mUEyM/aS7BMJvLNAGuN748iFpYC8w7dlsJXJ3A9behgkcoE/YxNG/aCS99E691rwn
         Gsk5aLxSZqUBPv93I2JCi1svwIsItEvtcWgmFzeLUtinv/HfSfT5UghiT0ah5AWlzJB+
         2DGTEEg1izEWnXHUg03xpkadoTVEKlc1PBVNbnEHAUK3NeTNA5sZFdiN5KhFuGZ73Cal
         g+xA==
X-Gm-Message-State: AOJu0YxthtxsOvLKWp8BXiepaZcRavtmouA4h0DyvunOVKPvuBALk/vV
	1NIPluIYEQsFjO4304R8lCLvsy8JViiKolhVUV3hRXDQmQjqzyy9Lx/oRTKPdc12s9cm5xzNhxN
	aag5kVvq5dnrsQowd63wfsneriSY4ll1OSKWOgIBZdedKnmPDX3Woq/86IBzqsOcPxmaC3sIb6n
	n5v0uv69Ufkd8zbGPaagqc3Nf+6rih0BpKetVR
X-Google-Smtp-Source: AGHT+IEovMyoSfSioeHKNfE3Jd4ijY+9Qv2Y1NAtxOWL1a07qluKCMa2m5T3612U71zudeIGN424nmHt4PE=
X-Received: from pjbta5.prod.google.com ([2002:a17:90b:4ec5:b0:2e0:915d:d594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2683:b0:31f:59d1:85be
 with SMTP id 98e67ed59e1d1-3234215846bmr274941a91.24.1755216732615; Thu, 14
 Aug 2025 17:12:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-1-seanjc@google.com>
Subject: [PATCH 6.1.y 00/21] KVM: x86: Backports for 6.1.y
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

This is a collection of backports for patches that were Cc'd to stable,
but failed to apply, along with their dependencies.

Note, Sasha already posted[1][2] these (and I acked them):

  KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
  KVM: x86/pmu: Gate all "unimplemented MSR" prints on report_ignored_msrs
  KVM: VMX: Extract checking of guest's DEBUGCTL into helper
  KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
  KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs

I'm including them here to hopefully make life easier for y'all, and because
the order they are presented here is the preferred ordering, i.e. should be
the same ordering as the original upstream patches.

But, if you end up grabbing Sasha's patches first, it's not a big deal as the
only true dependencies is that the DEBUGCTL.RTM_DEBUG patch needs to land
before "Check vmcs12->guest_ia32_debugctl on nested VM-Enter".

Many of the patches to get to the last patch (the DEBUGCTLMSR_FREEZE_IN_SMM
fix) are dependencies that arguably shouldn't be backported to LTS kernels.
I opted to do the backports because none of the patches are scary (if it was
1-3 dependency patches instead of 8 I wouldn't hesitate), and there's a decent
chance they'll be dependencies for future fixes.

[1] https://lore.kernel.org/all/20250813184918.2071296-1-sashal@kernel.org
[2] https://lore.kernel.org/all/20250814132434.2096873-1-sashal@kernel.org

Chao Gao (1):
  KVM: nVMX: Defer SVI update to vmcs01 on EOI when L2 is active w/o VID

Maxim Levitsky (3):
  KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
  KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs
  KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the
    guest

Sean Christopherson (17):
  KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN out of the STI
    shadow
  KVM: x86: Re-split x2APIC ICR into ICR+ICR2 for AMD (x2AVIC)
  KVM: x86: Plumb in the vCPU to kvm_x86_ops.hwapic_isr_update()
  KVM: x86: Take irqfds.lock when adding/deleting IRQ bypass producer
  KVM: x86: Snapshot the host's DEBUGCTL in common x86
  KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs
  KVM: x86/pmu: Gate all "unimplemented MSR" prints on
    report_ignored_msrs
  KVM: x86: Plumb "force_immediate_exit" into kvm_entry() tracepoint
  KVM: VMX: Re-enter guest in fastpath for "spurious" preemption timer
    exits
  KVM: VMX: Handle forced exit due to preemption timer in fastpath
  KVM: x86: Move handling of is_guest_mode() into fastpath exit handlers
  KVM: VMX: Handle KVM-induced preemption timer exits in fastpath for L2
  KVM: x86: Fully defer to vendor code to decide how to force immediate
    exit
  KVM: x86: Convert vcpu_run()'s immediate exit param into a generic
    bitmap
  KVM: x86: Drop kvm_x86_ops.set_dr6() in favor of a new KVM_RUN flag
  KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
  KVM: VMX: Extract checking of guest's DEBUGCTL into helper

 arch/x86/include/asm/kvm-x86-ops.h |   2 -
 arch/x86/include/asm/kvm_host.h    |  24 +++--
 arch/x86/include/asm/msr-index.h   |   1 +
 arch/x86/kvm/hyperv.c              |  10 +-
 arch/x86/kvm/lapic.c               |  61 ++++++++---
 arch/x86/kvm/lapic.h               |   1 +
 arch/x86/kvm/svm/svm.c             |  49 ++++++---
 arch/x86/kvm/svm/vmenter.S         |   9 +-
 arch/x86/kvm/trace.h               |   9 +-
 arch/x86/kvm/vmx/nested.c          |  26 ++++-
 arch/x86/kvm/vmx/pmu_intel.c       |   8 +-
 arch/x86/kvm/vmx/vmx.c             | 168 ++++++++++++++++++-----------
 arch/x86/kvm/vmx/vmx.h             |  31 +++++-
 arch/x86/kvm/x86.c                 |  65 ++++++-----
 arch/x86/kvm/x86.h                 |  12 +++
 15 files changed, 322 insertions(+), 154 deletions(-)


base-commit: 3594f306da129190de25938b823f353ef7f9e322
-- 
2.51.0.rc1.163.g2494970778-goog


