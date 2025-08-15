Return-Path: <stable+bounces-169642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C69B27366
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9765E84C9
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250F918C008;
	Fri, 15 Aug 2025 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zP5yQsCc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E014A0BC
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216742; cv=none; b=QSmwMSRETY2MPS/6g76zynZbbLmF4+SKdB8ZD1LWCd42SaLcDJ965QKCFQ1bn6H5NKopK56D49eBgVxDUgz/HaBaz2qJtG12vcKxOebDlH6NaTVzsK419bcYxd9V5EFzZCWzgH7oq/wBuLNE83U6rygAX+qB+tJXiiXqbnDlk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216742; c=relaxed/simple;
	bh=VhV9EFrTudTyrNyi+hXz4xZPaoxl5bt2eNREG6X3+KU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPFkcpDwOivHSWFdcbH3hYlQ3wlsbpw4c7Dlk67bifKFma436m/8AuuKFLPwILfgkqugD+gjrRJbsL+IT6Uf6jXFDZq6GQoyeYbp1EqLsaKkCUWBSAU33BsHMA6A8ufPR25M7T9qMDSNGtIiH2FKnMvdd7o0vOXtAynp0+F/WRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zP5yQsCc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e017efso1534754a91.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216741; x=1755821541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IwosmCXhK1vj9BTxghsFWvBqb4znPc+loO6bF0vRg/w=;
        b=zP5yQsCcy5QpL2kFvKjhxF2peyA3+u4o0TlE6elSG9Ivsg3bBJdnvJ9Y6jBYpmSYgn
         mr/drTREDgzrzZ3k+moyZMe7c2lexPaQxVUSvXEbwJe9XBPa3D/PFDSlHpvRvhMvi+NJ
         0oSws3wpOReY9JsC+BpAMDvbEeiHD21IPSAjhuPoH3nRBKvJi7jULHYsW3eHJHACdNd7
         XyKki0La52diHF9vDvZBqWsCgSa70F7LBiMzei4bB9/4ygQXGWPJhlfkxjU8U2LwfxlM
         7OGAYfBIPHkeG16T5e54deb6zbKWgakdMIcXHC2+2/05dCB1KfkXfVmZ1o0A4kO/9WSN
         wgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216741; x=1755821541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwosmCXhK1vj9BTxghsFWvBqb4znPc+loO6bF0vRg/w=;
        b=RvhCckNYzcij3zB+c/T8C5MmAGHEyvKjW7EzXytHxKIsQ5Wfl5vL5grQ8Vvj10ouNk
         L99Ug0f8nHmVqqeMiYl/W6YhU8SiXzPMtIMOb9jwdHXo/MWfhx85bMcfXtLOOOWiRLLD
         +fVKmhssxXEbKoTQ6B+3uUvxoEbI71gscH0FgPA0+X+Z3YsRdBnYhgXEi7Z66+J3djhb
         JMmSpsijkLGCcxf6KvGgHvbmAW8uXHZG5qzi0usNEftgZOGruN4nIQGdb1lS4S0nyayQ
         x2O3TOQEbvABFMAG8zHbfUkXqpE4MPQg94R7KaSJwj4QTM3tKVeiHoyUxX71TrqW3O8e
         7cYg==
X-Gm-Message-State: AOJu0YzRj9c82EJ4LXNUtxCXszs/K9o1G3RgWMqwJtxC9bgvcbzyRAog
	Y/QQIZKr/Y3QUc2qbvd3wCZlSjI0cGn5E7hekTMkL2YxdHKvmbWk1Qu+GeXUEK+7C9sGgOUjCPF
	MZ+ey+zz8HglIa32CFX6yw6by6ZiTzyAcCioZfWAPqP6hOTZ76wPTmHhnbDtzhzjIUWcFhVeb0H
	AnAMZy6nMs+FcN9Srgx5fmO3Ff2D8TgleahSkU
X-Google-Smtp-Source: AGHT+IGO/jPS6jdJmEtvnGY3PxwPeRyl+ObkL45xgwHrNfQdLHZ7iDlH5jvrHyrHHvz2++/SRO0Y4P+AtJ8=
X-Received: from pjbpq1.prod.google.com ([2002:a17:90b:3d81:b0:31f:1ed:c76e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfcd:b0:312:1ae9:1525
 with SMTP id 98e67ed59e1d1-32341e17c8cmr356019a91.8.1755216740828; Thu, 14
 Aug 2025 17:12:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:49 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-6-seanjc@google.com>
Subject: [PATCH 6.1.y 05/21] KVM: x86: Take irqfds.lock when adding/deleting
 IRQ bypass producer
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit f1fb088d9cecde5c3066d8ff8846789667519b7d ]

Take irqfds.lock when adding/deleting an IRQ bypass producer to ensure
irqfd->producer isn't modified while kvm_irq_routing_update() is running.
The only lock held when a producer is added/removed is irqbypass's mutex.

Fixes: 872768800652 ("KVM: x86: select IRQ_BYPASS_MANAGER")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20250404193923.1413163-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[sean: account for lack of kvm_x86_call()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a6dc8f662fa4..08c4ad276ccb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13385,16 +13385,22 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 {
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
 	int ret;
 
-	irqfd->producer = prod;
 	kvm_arch_start_assignment(irqfd->kvm);
+
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = prod;
+
 	ret = static_call(kvm_x86_pi_update_irte)(irqfd->kvm,
 					 prod->irq, irqfd->gsi, 1);
-
 	if (ret)
 		kvm_arch_end_assignment(irqfd->kvm);
 
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
 	return ret;
 }
 
@@ -13404,9 +13410,9 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	int ret;
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
 
 	WARN_ON(irqfd->producer != prod);
-	irqfd->producer = NULL;
 
 	/*
 	 * When producer of consumer is unregistered, we change back to
@@ -13414,11 +13420,18 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * when the irq is masked/disabled or the consumer side (KVM
 	 * int this case doesn't want to receive the interrupts.
 	*/
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = NULL;
+
+
 	ret = static_call(kvm_x86_pi_update_irte)(irqfd->kvm, prod->irq, irqfd->gsi, 0);
 	if (ret)
 		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
 		       " fails: %d\n", irqfd->consumer.token, ret);
 
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
 	kvm_arch_end_assignment(irqfd->kvm);
 }
 
-- 
2.51.0.rc1.163.g2494970778-goog


