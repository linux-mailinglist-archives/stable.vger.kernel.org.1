Return-Path: <stable+bounces-136915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B8FA9F6F7
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E75189B8C1
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9628BA9E;
	Mon, 28 Apr 2025 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QYq6PHRv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F814CB5B
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860328; cv=none; b=IOv/x2fTVJkTuwCcjJ0zU8xqcfoxmOshzbmBsF0Y+cMDTbhxHJ5H1cBzbDAN+dqqCjEkr9ESbSUkeXm4Rkeyt8/QgMsV2Qdfbqo7v6r3mxnXae8mNVW67xo7IjegPYReMTL7TkC/d/ZSzs6w4oqox4NpJt1zL9nnJfV05dljG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860328; c=relaxed/simple;
	bh=xBYZzhGbyuCwoRv1qxZjTqRmVdOS4IcAcDs/GtKLEx8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U3HuQQgSd/PCBYtRZKqeRqFYHp0JNKmFFD8goMe/uqW0sIHL/HgMFVte0X4EuWnbUzP+SkKxhlyT5gXbVET0dCKx3gfaqzI1bZbAnlfm7pW1cgAuqpubpG5I+ymmSZRf+VM4gIz7zLQq0DPzRBFXe9bi3orrAmXfAdsxXKtJfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QYq6PHRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C0C4CEE4;
	Mon, 28 Apr 2025 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745860328;
	bh=xBYZzhGbyuCwoRv1qxZjTqRmVdOS4IcAcDs/GtKLEx8=;
	h=Subject:To:Cc:From:Date:From;
	b=QYq6PHRvYY7P8KUR1OQQhSnHUGrNvGwarkQGYLnd5aUkHyU52wNbiubSbsWW/ruwW
	 O+S/T5ww+UfvKT2fDynfG/dq1Q1MShjasXUvfGq8vKvs+ZZpaDAaLKlihAUm882+Ua
	 IdgWX5SP7kmQAaGAoQNcEyEGRL62s/SnJ212NkQ4=
Subject: FAILED: patch "[PATCH] KVM: x86: Take irqfds.lock when adding/deleting IRQ bypass" failed to apply to 6.6-stable tree
To: seanjc@google.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 19:12:05 +0200
Message-ID: <2025042805-occupier-decibel-a03d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f1fb088d9cecde5c3066d8ff8846789667519b7d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042805-occupier-decibel-a03d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


