Return-Path: <stable+bounces-220178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFhUIr4so2me+AQAu9opvQ
	(envelope-from <stable+bounces-220178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:58:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70E1C5481
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3E073222F7A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3423D4B8DDE;
	Sat, 28 Feb 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkDUP+79"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D994B8DE7;
	Sat, 28 Feb 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300086; cv=none; b=tOd1Pgmpvt2cA3YRLRoKt65b69uPe+3ZfJmfuWRg8XviK3Fd/4eIrpq/IBPTLlc8o+p/YXWfSYS2OlPrVrMd3E7YaUBjWHYCkVwIsvZtEGS10fjpX3AGtdb5+FJdmiUCzfO9bw9+4rDwc+8GC3xfeEfvKaBqIBtp0NTEQrYPOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300086; c=relaxed/simple;
	bh=2FxwK8i+h0M1bYTgtHo9Ve86ZHv07KMFCI3ENdzh6/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uru+2OKadZIS4RctBSWnrVZJP2jKvkrBrVl6sIrUCB4yrggYJOM8DUfVxtj7DlfQ9FrRVHIdM9n0fQ3Xui5rrcDwkFKP6R8MPMLgTf4zl4pRJPXg4iu+ekA3mmea7p5zIbbg/P274FUKEHM/Y8kWwaKIrlO1L/CAE44ydhnOdtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkDUP+79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEE6C19423;
	Sat, 28 Feb 2026 17:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300085;
	bh=2FxwK8i+h0M1bYTgtHo9Ve86ZHv07KMFCI3ENdzh6/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkDUP+79VYvD8GY8C7nN0KDa45hjMd7L8RYKHhqgvczhHukzN9SwUhFuX4PRMzjZA
	 RXfYgG6pDgv5Bgdq1EbLmc9of6jbiNmc9pa1LwVc/Wrsld4GyWeqdMDRIb63n2XQVV
	 Y5M1bmgpgFVTf7jJaLiyXnzgVYtmRO3TDh53Xt7rMze6b+YFfVdKUIgeG7QQMCQhkt
	 K4yC2sheWcBllFv7hWMeE3+VHX0L/cQAXv3DZKgUl3pojkFj4BnmMUveGoh73D05CT
	 ypldFzPqF0mQJYuBhs5oNdST2ip0e3mHisazhm8vLLan+jbIXx3lNYQz0F/aGNj/nd
	 ydAZ+x6OR25Ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Imran Khan <imran.f.khan@oracle.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 100/844] genirq/cpuhotplug: Notify about affinity changes breaking the affinity mask
Date: Sat, 28 Feb 2026 12:20:13 -0500
Message-ID: <20260228173244.1509663-101-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220178-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 2D70E1C5481
X-Rspamd-Action: no action

From: Imran Khan <imran.f.khan@oracle.com>

[ Upstream commit dd9f6d30c64001ca4dde973ac04d8d155e856743 ]

During CPU offlining the interrupts affined to that CPU are moved to other
online CPUs, which might break the original affinity mask if the outgoing
CPU was the last online CPU in that mask. This change is not propagated to
irq_desc::affinity_notify(), which leaves users of the affinity notifier
mechanism with stale information.

Avoid this by scheduling affinity change notification work for interrupts
that were affined to the CPU being offlined, if the new target CPU is not
part of the original affinity mask.

Since irq_set_affinity_locked() uses the same logic to schedule affinity
change notification work, split out this logic into a dedicated function
and use that at both places.

[ tglx: Removed the EXPORT(), removed the !SMP stub, moved the prototype,
  	added a lockdep assert instead of a comment, fixed up coding style
  	and name space. Polished and clarified the change log ]

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113143727.1041265-1-imran.f.khan@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/cpuhotplug.c |  6 ++++--
 kernel/irq/internals.h  |  2 +-
 kernel/irq/manage.c     | 26 ++++++++++++++++++--------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 755346ea98196..cd5689e383b00 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -177,9 +177,11 @@ void irq_migrate_all_off_this_cpu(void)
 		bool affinity_broken;
 
 		desc = irq_to_desc(irq);
-		scoped_guard(raw_spinlock, &desc->lock)
+		scoped_guard(raw_spinlock, &desc->lock) {
 			affinity_broken = migrate_one_irq(desc);
-
+			if (affinity_broken && desc->affinity_notify)
+				irq_affinity_schedule_notify_work(desc);
+		}
 		if (affinity_broken) {
 			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
 					    irq, smp_processor_id());
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0164ca48da59e..5568ed3a8b852 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -135,6 +135,7 @@ extern bool irq_can_set_affinity_usr(unsigned int irq);
 
 extern int irq_do_set_affinity(struct irq_data *data,
 			       const struct cpumask *dest, bool force);
+extern void irq_affinity_schedule_notify_work(struct irq_desc *desc);
 
 #ifdef CONFIG_SMP
 extern int irq_setup_affinity(struct irq_desc *desc);
@@ -142,7 +143,6 @@ extern int irq_setup_affinity(struct irq_desc *desc);
 static inline int irq_setup_affinity(struct irq_desc *desc) { return 0; }
 #endif
 
-
 #define for_each_action_of_desc(desc, act)			\
 	for (act = desc->action; act; act = act->next)
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 349ae7979da0e..4873b0f73df96 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -347,6 +347,21 @@ static bool irq_set_affinity_deactivated(struct irq_data *data,
 	return true;
 }
 
+/**
+ * irq_affinity_schedule_notify_work - Schedule work to notify about affinity change
+ * @desc:  Interrupt descriptor whose affinity changed
+ */
+void irq_affinity_schedule_notify_work(struct irq_desc *desc)
+{
+	lockdep_assert_held(&desc->lock);
+
+	kref_get(&desc->affinity_notify->kref);
+	if (!schedule_work(&desc->affinity_notify->work)) {
+		/* Work was already scheduled, drop our extra ref */
+		kref_put(&desc->affinity_notify->kref, desc->affinity_notify->release);
+	}
+}
+
 int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 			    bool force)
 {
@@ -367,14 +382,9 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 		irq_copy_pending(desc, mask);
 	}
 
-	if (desc->affinity_notify) {
-		kref_get(&desc->affinity_notify->kref);
-		if (!schedule_work(&desc->affinity_notify->work)) {
-			/* Work was already scheduled, drop our extra ref */
-			kref_put(&desc->affinity_notify->kref,
-				 desc->affinity_notify->release);
-		}
-	}
+	if (desc->affinity_notify)
+		irq_affinity_schedule_notify_work(desc);
+
 	irqd_set(data, IRQD_AFFINITY_SET);
 
 	return ret;
-- 
2.51.0


