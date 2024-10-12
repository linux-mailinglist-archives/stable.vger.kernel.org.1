Return-Path: <stable+bounces-83607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0950799B7AF
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 01:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC61F2138F
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C11487ED;
	Sat, 12 Oct 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3uO6/GQI"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB1145B27
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728775373; cv=none; b=qy3bjc+kRSORGbwl82oBH7aY3BQ4YUGTenJ1TqM9s3C7duKGtlEPwvsbQOmyvcYEsG7roxoq0ufkl1e5hR7Qx4RD88T9KGAYh3hNwKs/VVxKOFWxVb+Vym/Jp5kf99Rc+16yCDHxd2JiH9W59NrKTawpCYiYHEmYjzfg7xIQRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728775373; c=relaxed/simple;
	bh=oSuqh0pA2Kyhg/h2HjCmDik+TBHAA5PUB3uCKJMcDiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WNQJCYaepJC7gW+hQgonBbqmtEA36H4YWvt4NAOCEQel2ZNpfqriq2eGWpSaFmEt34zSC8F4o9wU+Bm7np5hJVocS3idpNzEeQ9FiEWDiU5k8j850XeKVEwIvE8JRCDzeLNysJXeqCKwbgugQlT4SIO83qu1vpnuGZ9mG5+q858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3uO6/GQI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32e8436adso41410207b3.0
        for <stable@vger.kernel.org>; Sat, 12 Oct 2024 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728775371; x=1729380171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdJGi92seBoOSQNl5S5UX0vQJXnOjs681gAPy5REJmM=;
        b=3uO6/GQIOzcNZ3TqeBVsBb972xxxkJB+/oeSXGubk1eS0R6c0tBfk6TWpAVEebGTPH
         se181gTPAM07wgt8EPHpGITbW8Yov81QplZv/KNs0hv1PiiooZY96TRG4NdXLGRlaR9F
         U02Cyt8051j05MsuLstmbFDvWoaOX//mEZCg1YzlJ+F7bLcPOBeGIsdphBF10W4nM5eL
         JJO1NRRjuGEzTr/SD7zQpNN06AatzySO4X5BMOA/018Id06/SUVJu0kJS5NPzvaLVZMZ
         rzPkIwZ4GSSVZI7N8uJU2bywTSzrmSdAIAwQqY2LP2/bCXy4fQu3kzK3ktnb+zxEXr5E
         XrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728775371; x=1729380171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdJGi92seBoOSQNl5S5UX0vQJXnOjs681gAPy5REJmM=;
        b=AZ4nqyUAz87UWUk73vCWDKD/RsnK4uvTutVt/L1iVS1csCIblzGGLGDQn/wdWw82I0
         x7UnWTNi2BCR9rE+S79/Y7Z9A+nCE+QG1D0m+DVvUuiRZBfXiGikFt1W8MSPBCtbuEjR
         EZuwyorg0rZvUWY9uRqNQHyG/65u/yANvkof1tFHMlR9YzVeT2hwVPjKAWYCemgMzmHH
         4qFQ89+IKp+XZn1myYDBKd3qUBW4HaHilKpDTKq83c/qOXlHlfbXeIK3Znr8vMJAU/7t
         vXvfbvDLQ1RVJWuQuRIPcycaizPmb9N4KRawPHScKIKC/KB8ag+F9uOHXoyd6wbap6/S
         xYCg==
X-Gm-Message-State: AOJu0YwV/Jd//Jr/EtC5QgRjwihpfnpS3FWxqtXJj/80J0eG0tQOf+p2
	7UymHkEz8lN91hrfK+Hw/N3CFUrgjItQkLA/UnDk+R66ZxUIWie9MBP+HYvCFnQDmu/Z14bVLKG
	1NjbS1O1zWi+yPZ4SCSE8VXjpe0UMVbnRIN0i3bQDPB9LTlTDEUXozG/Yxe9jtHMlL2Au2Oj17L
	7tFnc+zSgLirAyzE+75zxOF7vxTIyM6cAbHbBUygJYzWs=
X-Google-Smtp-Source: AGHT+IEXhbIXJfJgUJA0sTYwz4APkniBsRCBWUVaZvEImvBD3oSMIjQQTnoY89WZ5WoJj6qGt0vO3kW5lTOBsA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:318c:b0:6e3:f12:1ad3 with SMTP
 id 00721157ae682-6e347c75f04mr1082607b3.6.1728775370808; Sat, 12 Oct 2024
 16:22:50 -0700 (PDT)
Date: Sat, 12 Oct 2024 23:22:41 +0000
In-Reply-To: <20241012232244.2768048-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241012232244.2768048-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012232244.2768048-2-cmllamas@google.com>
Subject: [PATCH 5.4.y 1/4] locking/lockdep: Fix bad recursion pattern
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, boqun.feng@gmail.com, bvanassche@acm.org, 
	cmllamas@google.com, gregkh@linuxfoundation.org, longman@redhat.com, 
	paulmck@kernel.org, xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com, 
	kernel-team@android.com, penguin-kernel@i-love.sakura.ne.jp, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

commit 10476e6304222ced7df9b3d5fb0a043b3c2a1ad8 upstream.

There were two patterns for lockdep_recursion:

Pattern-A:
	if (current->lockdep_recursion)
		return

	current->lockdep_recursion = 1;
	/* do stuff */
	current->lockdep_recursion = 0;

Pattern-B:
	current->lockdep_recursion++;
	/* do stuff */
	current->lockdep_recursion--;

But a third pattern has emerged:

Pattern-C:
	current->lockdep_recursion = 1;
	/* do stuff */
	current->lockdep_recursion = 0;

And while this isn't broken per-se, it is highly dangerous because it
doesn't nest properly.

Get rid of all Pattern-C instances and shore up Pattern-A with a
warning.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200313093325.GW12561@hirez.programming.kicks-ass.net
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 kernel/locking/lockdep.c | 74 ++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0d9ff8b621e6..0a2be60e4aa7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -389,6 +389,12 @@ void lockdep_on(void)
 }
 EXPORT_SYMBOL(lockdep_on);
 
+static inline void lockdep_recursion_finish(void)
+{
+	if (WARN_ON_ONCE(--current->lockdep_recursion))
+		current->lockdep_recursion = 0;
+}
+
 void lockdep_set_selftest_task(struct task_struct *task)
 {
 	lockdep_selftest_task_struct = task;
@@ -1720,11 +1726,11 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_forward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -1749,11 +1755,11 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_backward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -3550,9 +3556,9 @@ void lockdep_hardirqs_on(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
 		return;
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__trace_hardirqs_on_caller(ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 }
 NOKPROBE_SYMBOL(lockdep_hardirqs_on);
 
@@ -3608,7 +3614,7 @@ void trace_softirqs_on(unsigned long ip)
 		return;
 	}
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	/*
 	 * We'll do an OFF -> ON transition:
 	 */
@@ -3623,7 +3629,7 @@ void trace_softirqs_on(unsigned long ip)
 	 */
 	if (curr->hardirqs_enabled)
 		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 }
 
 /*
@@ -3877,9 +3883,9 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 			return;
 
 		raw_local_irq_save(flags);
-		current->lockdep_recursion = 1;
+		current->lockdep_recursion++;
 		register_lock_class(lock, subclass, 1);
-		current->lockdep_recursion = 0;
+		lockdep_recursion_finish();
 		raw_local_irq_restore(flags);
 	}
 }
@@ -4561,11 +4567,11 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	check_flags(flags);
 	if (__lock_set_class(lock, name, key, subclass, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_set_class);
@@ -4578,11 +4584,11 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	check_flags(flags);
 	if (__lock_downgrade(lock, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_downgrade);
@@ -4603,11 +4609,11 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquire);
@@ -4622,11 +4628,11 @@ void lock_release(struct lockdep_map *lock, int nested,
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_release(lock, ip);
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_release);
@@ -4642,9 +4648,9 @@ int lock_is_held_type(const struct lockdep_map *lock, int read)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	ret = __lock_is_held(lock, read);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -4663,9 +4669,9 @@ struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	cookie = __lock_pin_lock(lock);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 
 	return cookie;
@@ -4682,9 +4688,9 @@ void lock_repin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_repin_lock(lock, cookie);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_repin_lock);
@@ -4699,9 +4705,9 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_unpin_lock(lock, cookie);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_unpin_lock);
@@ -4837,10 +4843,10 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_contended(lock, ip);
 	__lock_contended(lock, ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_contended);
@@ -4857,9 +4863,9 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_acquired(lock, ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquired);
@@ -5087,7 +5093,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 
 	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -5099,7 +5105,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 }
@@ -5146,11 +5152,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 
 	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
-- 
2.47.0.rc1.288.g06298d1525-goog


