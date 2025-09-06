Return-Path: <stable+bounces-177969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C58B471C4
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 17:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86F07A7CA9
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165B12036FA;
	Sat,  6 Sep 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX6d0FkZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF4202C43
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171528; cv=none; b=ixpFUNEQQ3DSKJjD65J3aIxaqTh1UOk3JksghpOkT767T2kamEbt0IRu71TXQlSDXHZROzzQCMc3xEB5PQQoJS+DN8b6/oGe96rPgrMNd/eY5zaWxy4HTJuVtsOQnjeuHvF3jv9Gg6u7BRKORBAGTjnUSQMT4Igastxm3HZ0sGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171528; c=relaxed/simple;
	bh=6S0P/WTeyAnfCIPwFuakr+N7eXvd8Rjnmovbd0YQCDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN5H9ltkdcUgYpvDMMAFic4Wg+WMZYFxGid6ueuXT5yNi3/ZserRbLi4XhxspzYqeNbpz7PUMwurcA0OnVouzm3bkXEW6XdM4+hoJbCpCXJuDBaPe64rj/Ta7tJ/LIb97oJW2rvOIE3ymnDJ6N8vLH1oub9KDAawNxSAUPoCUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX6d0FkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3989C4CEE7;
	Sat,  6 Sep 2025 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757171528;
	bh=6S0P/WTeyAnfCIPwFuakr+N7eXvd8Rjnmovbd0YQCDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RX6d0FkZBc3oEiVU/V5AxxbThtX6nPl97jUoMQ9WqI1Dt604P7E+xklV5PGwgHIAw
	 0sn9B4TfnzNRceELXorxJ4qcHIOx2jd8AMlyr4sT5GgCZ5KmOgFm0LCVgkuVwoazaU
	 LeJfef0gbK0nsm5NQpkvititSwOhNrIIVPFdbIdaKWYdATU3GTEQV5UbLmEo6q4TIA
	 bJxJRjVi1Gkzk+8tkrkhSaEcfRKgtITZCz6/1IK/uOyLf19bpT9rdvSX9/C+fhkEle
	 IiwaKnAGrrRdo0eeswii1KY0ZRUTasFemtZ7bK4vuz4XCqyqhVb1ONDpqNbHVtpSrJ
	 tCtbzUhfSDYOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] KVM: x86: Take irqfds.lock when adding/deleting IRQ bypass producer
Date: Sat,  6 Sep 2025 11:12:05 -0400
Message-ID: <20250906151205.82243-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025042806-rentable-announcer-3863@gregkh>
References: <2025042806-rentable-announcer-3863@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit f1fb088d9cecde5c3066d8ff8846789667519b7d ]

Take irqfds.lock when adding/deleting an IRQ bypass producer to ensure
irqfd->producer isn't modified while kvm_irq_routing_update() is running.
The only lock held when a producer is added/removed is irqbypass's mutex.

Fixes: 872768800652 ("KVM: x86: select IRQ_BYPASS_MANAGER")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20250404193923.1413163-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b50d0da06b599..8eb62dbb3a186 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10394,11 +10394,18 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 {
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
+	int ret;
 
+	spin_lock_irq(&kvm->irqfds.lock);
 	irqfd->producer = prod;
 
-	return kvm_x86_ops->update_pi_irte(irqfd->kvm,
+	ret = kvm_x86_ops->update_pi_irte(irqfd->kvm,
 					   prod->irq, irqfd->gsi, 1);
+
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+	return ret;
 }
 
 void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
@@ -10407,9 +10414,9 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	int ret;
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
 
 	WARN_ON(irqfd->producer != prod);
-	irqfd->producer = NULL;
 
 	/*
 	 * When producer of consumer is unregistered, we change back to
@@ -10417,10 +10424,15 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * when the irq is masked/disabled or the consumer side (KVM
 	 * int this case doesn't want to receive the interrupts.
 	*/
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = NULL;
+
 	ret = kvm_x86_ops->update_pi_irte(irqfd->kvm, prod->irq, irqfd->gsi, 0);
 	if (ret)
 		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
 		       " fails: %d\n", irqfd->consumer.token, ret);
+
+	spin_unlock_irq(&kvm->irqfds.lock);
 }
 
 int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
-- 
2.51.0


