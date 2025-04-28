Return-Path: <stable+bounces-136916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47961A9F6FB
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B291898ABC
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6440428DEEA;
	Mon, 28 Apr 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdBh9oZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2A28DF1A
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860342; cv=none; b=tnemMF7TdjmXNWlUyZ5orGqyO3Ci3N4I0teaqHOjK5vtBXNMma6MXkiLDNwG3U4g7xpHgX33YqbAVD4CV2x8PGxirm+MaVVt2SvNjuvI7T1C5+aULxps6gT1iPRUUycnUFxCEgugsIvJIeMmVGNq2J5FdVpCXpwo//I0ZIub/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860342; c=relaxed/simple;
	bh=q1YTCbwr7ER2ZYpxkTDgkfcnPPRWE7IaNDX0i8r3JmE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j5VckFR3A7rOKXuXSc7JawsHqFaytKXtTzlsMvuZoY1XX7ys/UyFgwPx2U+OW7tUQUW637qZy7NfCn/Yjjynesn1SiOGkukaQMvDvQVmRZxKUQcXe8nsQBZ234P2G3SlpHzKwoP7//EurFFLq5+R18+7E4VK8xAzZ/akm0kP5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bdBh9oZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35895C4CEEC;
	Mon, 28 Apr 2025 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745860341;
	bh=q1YTCbwr7ER2ZYpxkTDgkfcnPPRWE7IaNDX0i8r3JmE=;
	h=Subject:To:Cc:From:Date:From;
	b=bdBh9oZJYlCpAzdpCD5nie2vZHq+wzsf7MuQStcmmlLPDwoW4DgtBEeZ7eYbgbsQv
	 n8kjVJyIQzYARJEzI51BklZaF7Nil5vQoSN0MUn855U5/2y7wkYzR5C0rSubNZ1tq7
	 mtyRdFpF4CuzCzi5sp4G4DQCNfYK/cgxwTuKM5jI=
Subject: FAILED: patch "[PATCH] KVM: x86: Take irqfds.lock when adding/deleting IRQ bypass" failed to apply to 6.1-stable tree
To: seanjc@google.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 19:12:05 +0200
Message-ID: <2025042805-scorer-petty-9d6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f1fb088d9cecde5c3066d8ff8846789667519b7d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042805-scorer-petty-9d6b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1fb088d9cecde5c3066d8ff8846789667519b7d Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 4 Apr 2025 12:38:19 -0700
Subject: [PATCH] KVM: x86: Take irqfds.lock when adding/deleting IRQ bypass
 producer

Take irqfds.lock when adding/deleting an IRQ bypass producer to ensure
irqfd->producer isn't modified while kvm_irq_routing_update() is running.
The only lock held when a producer is added/removed is irqbypass's mutex.

Fixes: 872768800652 ("KVM: x86: select IRQ_BYPASS_MANAGER")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20250404193923.1413163-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9c98b77b7dc1..a6829a370e6a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13561,15 +13561,22 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
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
 	ret = kvm_x86_call(pi_update_irte)(irqfd->kvm,
 					   prod->irq, irqfd->gsi, 1);
 	if (ret)
 		kvm_arch_end_assignment(irqfd->kvm);
 
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
 	return ret;
 }
 
@@ -13579,9 +13586,9 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	int ret;
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
 
 	WARN_ON(irqfd->producer != prod);
-	irqfd->producer = NULL;
 
 	/*
 	 * When producer of consumer is unregistered, we change back to
@@ -13589,12 +13596,18 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * when the irq is masked/disabled or the consumer side (KVM
 	 * int this case doesn't want to receive the interrupts.
 	*/
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = NULL;
+
 	ret = kvm_x86_call(pi_update_irte)(irqfd->kvm,
 					   prod->irq, irqfd->gsi, 0);
 	if (ret)
 		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
 		       " fails: %d\n", irqfd->consumer.token, ret);
 
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
 	kvm_arch_end_assignment(irqfd->kvm);
 }
 


