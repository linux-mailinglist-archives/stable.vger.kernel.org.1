Return-Path: <stable+bounces-164999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A08B1416C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 19:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2923818C061F
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 17:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A1270EA3;
	Mon, 28 Jul 2025 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2q5vVxbv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B22B273D8E
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725092; cv=none; b=W4/WHr7Fii6eHzIPaSyEZ2RbZy+jQVnwHSSvU4OMqNXw1EHncavmXT3h8Uetai1gDOUrk8utlJ30PE1ViA//6eyyK4AwGjI5ks8+ZPoQYHAzyEMVPAXDfDWQOyeNmVpdH0ug2fl5PV7IilRp/Gxs7OaObTlCbgRKKAcoL6mjyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725092; c=relaxed/simple;
	bh=E7uaaTkCWY6yKd8fWEqSxLQ9eErDVSW/6HVbrOrPe5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k9VUoIKC2rg79zpLYH71QuU/TeCbLIwVl6E2xHjc2jFlFq1JnQ3CZh871DexAAJMymvK1I5kl+MtVKhUIHzVWs4l/4lPiQUnWw9VMRdcNA+UQKfJkaOTk7PWDmg+e2y6tbI7iKoYq3qb74gaQ5eTP2hiaUlSIxTO8JrnW/ftq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2q5vVxbv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so3651080a12.2
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725090; x=1754329890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QU8Y06H95SHQq2tgd0vjFo+ADMsNxLspv9jmSDzeQEk=;
        b=2q5vVxbvzri0HBpPPlEYqmqJv6jdckba9kA3AuyN3iaxgKKE1ts2pH9x4waE7BLMIU
         a8yW0xVCn6saPQO9Cji5FJq29empY3XT8PdnhxuFmVmam2bWg6WoMf45PKP4LP7bD4YD
         y//1SGD3x09Bm3E1HOIlfMrgUI3+/InyN9gef3fJjTHObLJvMrVemjtIcBBHqlSe/9Z7
         nuqMe/O1TdZGbRCC+8TBboFD1gsoHT7X1pfUszejI+7NDL/8QoHCTqbm+8HGJB9jLtb9
         Anzyjv32ye8RPqjN8nuOnWTySLM1hWUXmT5lw2zOZz/OCn2EQhE+T4ahEwLy6ztPVR/L
         qB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725090; x=1754329890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QU8Y06H95SHQq2tgd0vjFo+ADMsNxLspv9jmSDzeQEk=;
        b=qrZZfQedbw07voZfcdYgsT0gTPQXg3dTmQ7EwSumD5JYX38odFTF8Xy51wzk5WOK4d
         o7twtR3N7YSxLFIg/giempef53eOw9Auu+IojKk6QO0bEbGom65gW821604T/1u6sh83
         OzcqtT3bXPbK/HbjQ6MC0sIl7Dz0YuNZVpxQClHQVADd/pNkWZmrc4OOx+oldGOIqA20
         AYQq4u5w8/rPax8VjMB+q+POGdD8oXJNHyoCtUPr7bVQOeQY/xLjR9UQcRPq+ZKvlosQ
         4P4RSs9ptUvZvx4PVueSkdpvllCLolZPtZBKBn0Mt1yDO3bbfO0hd5M1l2ykQVKi7k3X
         gDBA==
X-Gm-Message-State: AOJu0Yy42eBYmlld87TWUmHcuG7isdDmdMwyi/1G4opHzCGQgdYhhBC1
	gvYnpYvRJavWuxUxXI6ERPUd17rIPCMRUCTn20ZEjj/koTtMICW2CqpNYHeManjGlMGHAIU4Cu1
	PVBemJbmCDSSjuA==
X-Google-Smtp-Source: AGHT+IHoevGYHZ06A2Fm8GZr+xb6w9aeSHLCSf1ZjzMgZZTYlWuHesokbkluQtl4L8ZULuG1dqvZ4OoFGlf+ow==
X-Received: from pga6.prod.google.com ([2002:a05:6a02:4f86:b0:b2e:664a:d5f4])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a11c:b0:232:7657:6e46 with SMTP id adf61e73a8af0-23d701f3747mr20845197637.39.1753725090358;
 Mon, 28 Jul 2025 10:51:30 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:51:22 +0000
In-Reply-To: <1753492499-da8df97e@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1753492499-da8df97e@stable.kernel.org>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250728175122.4021478-1-chengkev@google.com>
Subject: [PATCH 6.12.y v2] KVM: x86: Free vCPUs before freeing VM state
From: Kevin Cheng <chengkev@google.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Aaron Lewis <aaronlewis@google.com>, Jim Mattson <jmattson@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kevin Cheng <chengkev@google.com>
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


