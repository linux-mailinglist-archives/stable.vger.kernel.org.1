Return-Path: <stable+bounces-227890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KvIJP7hwGnAOAQAu9opvQ
	(envelope-from <stable+bounces-227890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:47:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6902ED2A5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBB45300D16D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 06:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CEA35BDAD;
	Mon, 23 Mar 2026 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2YC9Yg2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E23348883;
	Mon, 23 Mar 2026 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774248443; cv=none; b=uPubC+s4nViCmSaWroOEqNGhHkzXq9vgwKC3keBUH2oLmapemtaKNs6WyXRYu8Mx+kt6fXVx3zY49KwOs/5aiyuZ51F1xn67kePNpyVY+qS2PfaDhvOEkjZ8zI28028FvpTull6UYHpzWfCdmPEx+WXUUeQapEKV0eYW9JjsDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774248443; c=relaxed/simple;
	bh=fZ4dthvo6FiuhI8csVK1kkr1G1ANyOjv7U4MMqBAv48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+DvuVBilVyipYDr0/pl5W4u0VrELwUn5bYMK/a3Z0ErtdXNGEuakvHJHP06QNeJ+JOkOxI/OvMS/g2bbHXOqRC8M+Jhe9GoC1NwcW0Fkx/p5EmqKUCEupHz4hzkKSNlbaEsgHPfqu61i7oqNBkz5Kuw/+oJfkzZDNLlXnBuJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2YC9Yg2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774248441; x=1805784441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZ4dthvo6FiuhI8csVK1kkr1G1ANyOjv7U4MMqBAv48=;
  b=k2YC9Yg2ODZXxUAZ498Sk0fa74rAcpHelWUWa+nu8i7eidqetvs52IuR
   g/gf6dp3IeBHTEjrSy4aOwW1PdrKRyJAx0we8ptNOAeEPUeegEmlmRydB
   vnRMpvVf/+MOj5DEac6ot7KYS3hqRUOmb7JczsFFUXtHi4jUoNvQHfyl4
   3aJiQHHkM2ZOwSvLHO3r2S95h9IHAng6WwKL3dx6budNvwzAPhaAMq3jX
   PO6gqT+LyhrfBQ0UFzppiiHQsrOKg0jEU7IJpYxk62Ij7SxzhwbiUXDNd
   ai3K3V0srsiE7QDln+xY3HnNxZXAWZecwymttk7W/B6pZbr2RwXisv142
   g==;
X-CSE-ConnectionGUID: /B1aq3lYSIqRGT1Ld3bxDQ==
X-CSE-MsgGUID: gopsGW3sSqGTf7/3ns9EOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="100692618"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="100692618"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 23:47:20 -0700
X-CSE-ConnectionGUID: Mn0cimg9SXCAJWIQDhbnLg==
X-CSE-MsgGUID: ErtolgvsRzSN77y7FlHs9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="261838000"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 23:47:18 -0700
From: Sonam Sanju <sonam.sanju@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>
Cc: Dmitry Maluka <dmaluka@chromium.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sonam Sanju <sonam.sanju@intel.com>
Subject: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu out of resampler_lock
Date: Mon, 23 Mar 2026 12:12:48 +0530
Message-Id: <20260323064248.1660757-1-sonam.sanju@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323053353.805336-1-sonam.sanju@intel.com>
References: <20260323053353.805336-1-sonam.sanju@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227890-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sonam.sanju@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA6902ED2A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

irqfd_resampler_shutdown() and kvm_irqfd_assign() both call
synchronize_srcu_expedited() while holding kvm->irqfds.resampler_lock.
This can deadlock when multiple irqfd workers run concurrently on the
kvm-irqfd-cleanup workqueue during VM teardown or when VMs are rapidly
created and destroyed:

  CPU A (mutex holder)               CPU B/C/D (mutex waiters)
  irqfd_shutdown()                   irqfd_shutdown() / kvm_irqfd_assign()
   irqfd_resampler_shutdown()         irqfd_resampler_shutdown()
    mutex_lock(resampler_lock)  <---- mutex_lock(resampler_lock) //BLOCKED
    list_del_rcu(...)                     ...blocked...
    synchronize_srcu_expedited()      // Waiters block workqueue,
      // waits for SRCU grace            preventing SRCU grace
      // period which requires            period from completing
      // workqueue progress          --- DEADLOCK ---

In irqfd_resampler_shutdown(), the synchronize_srcu_expedited() in
the else branch is called directly within the mutex.  In the if-last
branch, kvm_unregister_irq_ack_notifier() also calls
synchronize_srcu_expedited() internally.  In kvm_irqfd_assign(),
synchronize_srcu_expedited() is called after list_add_rcu() but
before mutex_unlock().  All paths can block indefinitely because:

  1. synchronize_srcu_expedited() waits for an SRCU grace period
  2. SRCU grace period completion needs workqueue workers to run
  3. The blocked mutex waiters occupy workqueue slots preventing progress
  4. The mutex holder never releases the lock -> deadlock

Fix both paths by releasing the mutex before calling
synchronize_srcu_expedited().

In irqfd_resampler_shutdown(), use a bool last flag to track whether
this is the final irqfd for the resampler, then release the mutex
before the SRCU synchronization.  This is safe because list_del_rcu()
already removed the entries under the mutex, and
kvm_unregister_irq_ack_notifier() uses its own locking (kvm->irq_lock).

In kvm_irqfd_assign(), simply move synchronize_srcu_expedited() after
mutex_unlock().  The SRCU grace period still completes before the irqfd
goes live (the subsequent srcu_read_lock() ensures ordering).

Signed-off-by: Sonam Sanju <sonam.sanju@intel.com>
---
v2:
 - Fix the same deadlock in kvm_irqfd_assign() (Vineeth Pillai)

 virt/kvm/eventfd.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 0e8b8a2c5b79..8ae9f81f8bb3 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -93,6 +93,7 @@ irqfd_resampler_shutdown(struct kvm_kernel_irqfd *irqfd)
 {
 	struct kvm_kernel_irqfd_resampler *resampler = irqfd->resampler;
 	struct kvm *kvm = resampler->kvm;
+	bool last = false;
 
 	mutex_lock(&kvm->irqfds.resampler_lock);
 
@@ -100,19 +101,27 @@ irqfd_resampler_shutdown(struct kvm_kernel_irqfd *irqfd)
 
 	if (list_empty(&resampler->list)) {
 		list_del_rcu(&resampler->link);
+		last = true;
+	}
+
+	mutex_unlock(&kvm->irqfds.resampler_lock);
+
+	/*
+	 * synchronize_srcu_expedited() (called explicitly below, or internally
+	 * by kvm_unregister_irq_ack_notifier()) must not be invoked under
+	 * resampler_lock.  Holding the mutex while waiting for an SRCU grace
+	 * period creates a deadlock: the blocked mutex waiters occupy workqueue
+	 * slots that the SRCU grace period machinery needs to make forward
+	 * progress.
+	 */
+	if (last) {
 		kvm_unregister_irq_ack_notifier(kvm, &resampler->notifier);
-		/*
-		 * synchronize_srcu_expedited(&kvm->irq_srcu) already called
-		 * in kvm_unregister_irq_ack_notifier().
-		 */
 		kvm_set_irq(kvm, KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
 			    resampler->notifier.gsi, 0, false);
 		kfree(resampler);
 	} else {
 		synchronize_srcu_expedited(&kvm->irq_srcu);
 	}
-
-	mutex_unlock(&kvm->irqfds.resampler_lock);
 }
 
 /*
@@ -450,9 +459,16 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 		}
 
 		list_add_rcu(&irqfd->resampler_link, &irqfd->resampler->list);
-		synchronize_srcu_expedited(&kvm->irq_srcu);
 
 		mutex_unlock(&kvm->irqfds.resampler_lock);
+
+		/*
+		 * Ensure the resampler_link is SRCU-visible before the irqfd
+		 * itself goes live.  Moving synchronize_srcu_expedited() outside
+		 * the resampler_lock avoids deadlock with shutdown workers waiting
+		 * for the mutex while SRCU waits for workqueue progress.
+		 */
+		synchronize_srcu_expedited(&kvm->irq_srcu);
 	}
 
 	/*
-- 
2.34.1


