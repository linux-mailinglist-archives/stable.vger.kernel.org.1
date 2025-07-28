Return-Path: <stable+bounces-164998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB73B14166
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 19:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A48178AF7
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616DE270EA3;
	Mon, 28 Jul 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yeFJ2BBP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121921C9EA
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725020; cv=none; b=OCfkT+bX6QjbDsRsLqkHMNldtpymxJXSZuFAFdq5jo50hiMHP6jIK04i36LhtsOHh4xj+ImfYM2hl3eKo8FoBAlz/ukSWzakwFOZR8JBWafhhMa3z4mrF9Qxx2QRwbDhEtk13AmmfhSvCG/ZceeCFUdGH7t9olG1w0uHW0oOGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725020; c=relaxed/simple;
	bh=E7uaaTkCWY6yKd8fWEqSxLQ9eErDVSW/6HVbrOrPe5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l1NsybC/xErmJZAvhaLBdzXy+08Upg1AAxpSkaFL+lOKXUKY6oAciWy9Sj3RauaNpC3clHvoKjrULDx3Tm+e2DlLI/fATGZ1r133LB2Kq8UdM9vd5OvtZA1NvU/vbfiOx2jDYsd9MfNouD61cyWtEu4EuwD0UT8FkZDUbcfRlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yeFJ2BBP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso4831006a91.2
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725018; x=1754329818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QU8Y06H95SHQq2tgd0vjFo+ADMsNxLspv9jmSDzeQEk=;
        b=yeFJ2BBPdvjT6LHHX77xE4ubEps7PQpzfTljpsqL0PIkaD/5qfddcMgOxsqBgFQLNn
         aDgRBy1zsiT8bT4hxT9SJeUIqlwaOg9DTFdvSnS8F7dQKFbIx6t8QCZ5h050VhlapZPP
         0ftlGBrZXgid8hAX+ryJf+i6MfnEDH89AF/VteKAmCBxUBuOnCb7sAZ/G/SVC16tQCyk
         WK5/g1E9svQjlE3+hO3Zb2uxAghmgecSEJxAm9pc3OhDq2L6S4+Od6ojOoJ9TnrWH6wD
         fkjRUGis3Bn5VocgE2VA8eWP0qt/n7009R9aSJI/1da3Is/r+dL128gKe573ge6blOPm
         KY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725018; x=1754329818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QU8Y06H95SHQq2tgd0vjFo+ADMsNxLspv9jmSDzeQEk=;
        b=bS2FX1T4EivuOLn9Qaebef5ni0KZpzPtnFCQfo9rf7u75kmUcQSocNIADK2VJaNbop
         l7ZOSwNxkyWYL+q701auJ+emP348tinB3w4Hn2RqlUMKK1/1vadO4WJQCzhpvqAJ0rJ+
         ZXODxRHDkvVPE7KhnSqlzo7GhRJcX04AjvlwFtzYJ7HMQ+DD1qbUGAgceu0KX1G26SVV
         j8RNnIyGGvj8QH3Xr2Teu1+YXzWcVG5tPhjFYsQ0ZAho59sSdE7VGEQW9CfOKhvmYUcv
         GIpBabzvt7Ao9fRrTePVOdl0CxCdj5UAfJdIJnZWhjH4JZ8NXZB0AxK+vqFqRgfnKwHS
         t0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXfNqFzZ9G1SSeA6lNRd5pCUF3v9xtp8KDABvg2qqZ6bv4tFBQx6ysJSPFq7pyFy/SVY0seZhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj83D7F5dhqb4AmFrnTLqQlHlDLD8+x/JCXnBpfAJY7lzgzoG+
	DjVAkRGB2fxfHi+YuYU3Sc5HCcNEMgc+pbKddM+vx4Hx5+AgaxqzYUG2oe/AV61T0ty/LJc6GJd
	gj17PSXc9+6SUmg==
X-Google-Smtp-Source: AGHT+IEQl8NORM6WoroXLQpmPg4pyMXM+RNr9KBNxDcGYGCQOxBFKI7XMJs3f2slP7fyqVmYAWjQbHYEUo+qwQ==
X-Received: from pjbqo3.prod.google.com ([2002:a17:90b:3dc3:b0:31f:345:2039])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e185:b0:31c:bfb9:fca0 with SMTP id 98e67ed59e1d1-31e77a18508mr18012321a91.4.1753725017991;
 Mon, 28 Jul 2025 10:50:17 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:50:02 +0000
In-Reply-To: <20250705113600-732825ae6d36da7f@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250705113600-732825ae6d36da7f@stable.kernel.org>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250728175002.4021103-1-chengkev@google.com>
Subject: [PATCH 6.12.y v2] KVM: x86: Free vCPUs before freeing VM state
From: Kevin Cheng <chengkev@google.com>
To: sashal@kernel.org
Cc: aha310510@gmail.com, stable@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Jim Mattson <jmattson@google.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 17bcd714426386fda741a4bccd96a2870179344b ]

Free vCPUs before freeing any VM state, as both SVM and VMX may access
VM state when "freeing" a vCPU that is currently "in" L2, i.e. that needs
to be kicked out of nested guest mode.

Commit 6fcee03df6a1 ("KVM: x86: avoid loading a vCPU after .vm_destroy was
called") partially fixed the issue, but for unknown reasons only moved the
MMU unloading before VM destruction.  Complete the change, and free all
vCPU state prior to destroying VM state, as nVMX accesses even more state
than nSVM.

In addition to the AVIC, KVM can hit a use-after-free on MSR filters:

  kvm_msr_allowed+0x4c/0xd0
  __kvm_set_msr+0x12d/0x1e0
  kvm_set_msr+0x19/0x40
  load_vmcs12_host_state+0x2d8/0x6e0 [kvm_intel]
  nested_vmx_vmexit+0x715/0xbd0 [kvm_intel]
  nested_vmx_free_vcpu+0x33/0x50 [kvm_intel]
  vmx_free_vcpu+0x54/0xc0 [kvm_intel]
  kvm_arch_vcpu_destroy+0x28/0xf0
  kvm_vcpu_destroy+0x12/0x50
  kvm_arch_destroy_vm+0x12c/0x1c0
  kvm_put_kvm+0x263/0x3c0
  kvm_vm_release+0x21/0x30

and an upcoming fix to process injectable interrupts on nested VM-Exit
will access the PIC:

  BUG: kernel NULL pointer dereference, address: 0000000000000090
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  CPU: 23 UID: 1000 PID: 2658 Comm: kvm-nx-lpage-re
  RIP: 0010:kvm_cpu_has_extint+0x2f/0x60 [kvm]
  Call Trace:
   <TASK>
   kvm_cpu_has_injectable_intr+0xe/0x60 [kvm]
   nested_vmx_vmexit+0x2d7/0xdf0 [kvm_intel]
   nested_vmx_free_vcpu+0x40/0x50 [kvm_intel]
   vmx_vcpu_free+0x2d/0x80 [kvm_intel]
   kvm_arch_vcpu_destroy+0x2d/0x130 [kvm]
   kvm_destroy_vcpus+0x8a/0x100 [kvm]
   kvm_arch_destroy_vm+0xa7/0x1d0 [kvm]
   kvm_destroy_vm+0x172/0x300 [kvm]
   kvm_vcpu_release+0x31/0x50 [kvm]

Inarguably, both nSVM and nVMX need to be fixed, but punt on those
cleanups for the moment.  Conceptually, vCPUs should be freed before VM
state.  Assets like the I/O APIC and PIC _must_ be allocated before vCPUs
are created, so it stands to reason that they must be freed _after_ vCPUs
are destroyed.

Reported-by: Aaron Lewis <aaronlewis@google.com>
Closes: https://lore.kernel.org/all/20240703175618.2304869-2-aaronlewis@google.com
Cc: Jim Mattson <jmattson@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20250224235542.2562848-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f378d479fea3f..7f91b11e6f0ec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12888,11 +12888,11 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		mutex_unlock(&kvm->slots_lock);
 	}
 	kvm_unload_vcpu_mmus(kvm);
+	kvm_destroy_vcpus(kvm);
 	kvm_x86_call(vm_destroy)(kvm);
 	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
 	kvm_pic_destroy(kvm);
 	kvm_ioapic_destroy(kvm);
-	kvm_destroy_vcpus(kvm);
 	kvfree(rcu_dereference_check(kvm->arch.apic_map, 1));
 	kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->srcu, 1));
 	kvm_mmu_uninit_vm(kvm);
-- 
2.50.1.487.gc89ff58d15-goog


