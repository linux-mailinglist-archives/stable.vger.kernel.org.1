Return-Path: <stable+bounces-164763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD29B1248D
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 21:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16E117C8C0
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 19:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16C2494FE;
	Fri, 25 Jul 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jyTvoRpI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190019C569
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469953; cv=none; b=aXRWL3LwuathAWFfwdNfc+hyJKUzmvcQqEwD7Dx+ckQJyDASjdY6Frh9837MjMWvA0u3ljA6lB/G91+TxcmCNC4mN5/2vKdg/DcmjJz5ZfUVhXCVbXqBmfucEij4d76rhwNus90XybjY57/djr2Ifnu1Jtnel1ajuc5zqrYVJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469953; c=relaxed/simple;
	bh=xFKIE3Z0SFvwujEUHtBWTNxIQTn7fOfs3kx3Yj2NRcQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p4hapzeGxCgHdvB+HQLe5M3aWj5QZih/gv72KoAr18QqRzj+/GHX608lgk56dL6H5lyqQsgIRArIEQahAR//6MHbjc3GlcUZ6zWlGfIrTQW9rwRKxOlpdE2ZvTm+c+DvxKGp5gL+TboPAQxhdlrN3K6S9/X6aKq5GRvty8f4eV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jyTvoRpI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso2778557a91.1
        for <stable@vger.kernel.org>; Fri, 25 Jul 2025 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469951; x=1754074751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JKJpIbnc4zifqEZ1ZZTGWPM9BmiyM6Ko400vs1x1X/M=;
        b=jyTvoRpIR9++LWcunU2/B2ZjspH3chAOY9YLlIqp1I0VW1+mVh2QwObJ1h6g//4Qbw
         c48U37pUaj7kYZjAGeYjEojacJ2ClJE9fpj2I3XePSu998c/+cnfE6qGFk6GclLth9Ri
         ywjQoLHqIVgS78wXzhHmSEIOOnBApNPPhlvOfQhp467dD7p59HpqV3JyZytuXJLGiUm0
         xt91PQEPToo4LmfFinvQ5Ecb9HbtD6tCglEomvE61wX5DN0pTDcWZhdvN6y0hgHM/wI1
         b90y5EVhWbFllkCtNXoX++f8+h3XZN9RTs8OUmp8+/VJAN9+y7Kb57zdO97sI2LzdcrF
         yQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469951; x=1754074751;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKJpIbnc4zifqEZ1ZZTGWPM9BmiyM6Ko400vs1x1X/M=;
        b=bmvzY3qPiLbWimT7Y/wiQQ4UE3051ihGXx3b9geivzr4ASchqnRww6+f8bx/db/hSy
         FseZi5G8yOFuVJRBKCZft/apUHYRVIa8sgBpqwxDWFAslqXmS/SRUeIyI++ksdomW3xm
         fLcUvkSdBL9VcnL7Iwbk/CWhGGyWpKmMuzW0sGR4PEGFSx2ZHnqsmoCmPtVD8tGyOo85
         iVJbfP5HANL/Wq2Bt3ot5j1g31ti4Y5shdyFstPxha2UykqiugdteUvvpJIwPiUAKwaM
         03k8Mt1AhoLsUR9zhqJiDE4nmX0/kEG9CmykJTnlKu9eLLHANsz7xLf0AdqRO5NH0rgw
         ImIg==
X-Gm-Message-State: AOJu0YyYYdZ5AMC7S3t8DmCKbtdIWQRU91GzJBBthuBEugztA9K4o8nn
	tgQ8jzF94cNTTtyagEDgvmUOQVTXGldCFstaGI4WDkyFPP6skM7o+Vl1ZPaxerOXKhtGVdczjvs
	/qYWW+oD9ltwghVI3pNkdDWZ4YuS1Dg/CgRGcWex43pR2PYep5/LeHtp01c7HMNhY7afPpPpXE7
	SQbvT2gs1owtdu1P2QirV8pKPlyJD7QhwFzw4R+Gt6BL0w/B0=
X-Google-Smtp-Source: AGHT+IHbcWCpiLYTdPjYvMC57+L/OTIsDbVAzVBxxZtOmAXjnrOmzLFn8b11rbpluD76qea86+xL8KrM/2CQVQ==
X-Received: from pjqz1.prod.google.com ([2002:a17:90a:b101:b0:31e:74cb:7677])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a0a:b0:31c:b243:2f69 with SMTP id 98e67ed59e1d1-31e77a14400mr4664145a91.29.1753469951027;
 Fri, 25 Jul 2025 11:59:11 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:58:07 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725185805.2867461-3-chengkev@google.com>
Subject: [PATCH 6.12.y] KVM: x86: Free vCPUs before freeing VM state
From: Kevin Cheng <chengkev@google.com>
To: stable@vger.kernel.org
Cc: seanjc@google.com, Aaron Lewis <aaronlewis@google.com>, 
	Jim Mattson <jmattson@google.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kevin Cheng <chengkev@google.com>
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
2.50.1.470.g6ba607880d-goog


