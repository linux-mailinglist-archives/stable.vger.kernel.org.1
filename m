Return-Path: <stable+bounces-83609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D21A99B7B0
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 01:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3A91C20EC9
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552C1474A4;
	Sat, 12 Oct 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fPX2Z2PO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21014BF8D
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728775378; cv=none; b=IzGfZae5rG705dcPMKzxeXOp1FyT06q2sEqtzuwkEZANYzp58A+5WLK8xJCGzLllwpqh0eskb4p4WKeZG/LgemoZkEZDqURbY+juI+ltzw9Wq16GPuQ6rgpswKQ3NoXyLJR+O0l8y5fKamiG9Zw8vjQZZHYTqEOz1y4DPGxk+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728775378; c=relaxed/simple;
	bh=3enYBYVBIMtuxEeSQQJ4SXzUbnPwg+7wt5vFIbUsS9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tpK4fKwpoO0iqmJ/TK6jwjGL/zXMWfn1P4SW5c1qHmqiOKc6WqKArdr9kL5+XW/jjak1DbcPqlixBLwb1qZw8J/OoiJasDNGBqCdW3G+fXsqewhdACRdAI4f8Cd6jAjAsTsiu82+SvUhRG3q2BMhGSEuQFugPqp275nCMJFDyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fPX2Z2PO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35199eb2bso26082767b3.3
        for <stable@vger.kernel.org>; Sat, 12 Oct 2024 16:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728775375; x=1729380175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SrAkw4d0qEBWWu2EjGgIQZBox4bx2m3G+p9kovFJ8g=;
        b=fPX2Z2PO7LqvRGolYet2xtCbzLx9876URGK1G3jznYnny/cupOVq8F6l/Z78N72/6r
         XMV+fUH1s6siptb+d3NPtUMCFhejGbdzRgqQ4g5MZa5h6R6zIXnig+l/7awGcQz4Rklm
         NLxkNeJQSRiYLOPkKfg0IFxEEM40t5ErBoDzdqM60hcUjPVkPhBJPtOLWCNlRmWLgaD7
         jitWnR3LawzoYiLXPkzvnY16b70/jRe+TAv68Fwtb5woDSd85n+mA7aCKLl3GVKAdPH9
         Gr2P71VKyj+swKF2mwZYX7yw/4QQm2m/XdMmAA2Pb2TAfBeL75cD6GRUAqYuOGa+m2w0
         u+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728775375; x=1729380175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SrAkw4d0qEBWWu2EjGgIQZBox4bx2m3G+p9kovFJ8g=;
        b=LLG8LjEijpRm8GX2FrgFbN1iaO9A/CEmoMLXvp7B7NP6+Io7+WEeiDZosQirezGjpL
         IpZmQvPZoRF5wC5bjuFaHUFqvPSgqmDYgKEqexsLFGcVSdW+PX4MwK4pJGSH2RGx3s/u
         krJhaeMcHfnlwyYD37HM4UXl+uESn6/PKM901JusdQ8H8KdsmdBtYc5LRti0EgBfrYog
         E5ynVhcjk6L89Sv33EMHWf9ehrqssF3pcV5sSmBI/jHtjiuRnAtPOGf8WJ5OgeqQAidm
         5OGYszaIEIbrpuCmLP40PQDujV6ArXaffjAO0eleR0NzxjiyASr8txIlUaGsl1OaO/T2
         XXYg==
X-Gm-Message-State: AOJu0YyPXCL6vkLUKmll11GhHWu2PdEFWsYa8yaeHERWLJZN7P/e/GVa
	l7oPGX73oLa7dda9+TRCaI+V8i0m4gnE+iSkDsIhyueJxhykl3fk6f4XYYtVkhG7AQsl1fbpB2B
	AKgVfNUVfpDP8BULsATOIBsNxSkN9FiPdCuzYISL9lPnqYk2dnnn/7ONxIuIVR/OSQHaraLDyib
	mQK6q7fIoVhcO/go2xU7Xx49KVl5goPL9kZqm0tPS8Jlg=
X-Google-Smtp-Source: AGHT+IEHjUVkMm6BHWYWJIkYaUN3fNQV7BxXyz+UJ7IiHssxMDR0W20EYunQTOWurFKokcpduvuBXEada5a+VA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:2d04:b0:6c1:298e:5a7 with SMTP
 id 00721157ae682-6e347c66135mr512587b3.5.1728775374743; Sat, 12 Oct 2024
 16:22:54 -0700 (PDT)
Date: Sat, 12 Oct 2024 23:22:43 +0000
In-Reply-To: <20241012232244.2768048-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241012232244.2768048-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012232244.2768048-4-cmllamas@google.com>
Subject: [PATCH 5.4.y 3/4] locking/lockdep: Avoid potential access of invalid
 memory in lock_class
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, boqun.feng@gmail.com, bvanassche@acm.org, 
	cmllamas@google.com, gregkh@linuxfoundation.org, longman@redhat.com, 
	paulmck@kernel.org, xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com, 
	kernel-team@android.com, penguin-kernel@i-love.sakura.ne.jp, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

From: Waiman Long <longman@redhat.com>

commit 61cc4534b6550997c97a03759ab46b29d44c0017 upstream.

It was found that reading /proc/lockdep after a lockdep splat may
potentially cause an access to freed memory if lockdep_unregister_key()
is called after the splat but before access to /proc/lockdep [1]. This
is due to the fact that graph_lock() call in lockdep_unregister_key()
fails after the clearing of debug_locks by the splat process.

After lockdep_unregister_key() is called, the lock_name may be freed
but the corresponding lock_class structure still have a reference to
it. That invalid memory pointer will then be accessed when /proc/lockdep
is read by a user and a use-after-free (UAF) error will be reported if
KASAN is enabled.

To fix this problem, lockdep_unregister_key() is now modified to always
search for a matching key irrespective of the debug_locks state and
zap the corresponding lock class if a matching one is found.

[1] https://lore.kernel.org/lkml/77f05c15-81b6-bddd-9650-80d5f23fe330@i-love.sakura.ne.jp/

Fixes: 8b39adbee805 ("locking/lockdep: Make lockdep_unregister_key() honor 'debug_locks' again")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lkml.kernel.org/r/20220103023558.1377055-1-longman@redhat.com
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 kernel/locking/lockdep.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b9fabbab3918..8e0351970a1d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5302,7 +5302,13 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		lockdep_reset_lock_reg(lock);
 }
 
-/* Unregister a dynamically allocated key. */
+/*
+ * Unregister a dynamically allocated key.
+ *
+ * Unlike lockdep_register_key(), a search is always done to find a matching
+ * key irrespective of debug_locks to avoid potential invalid access to freed
+ * memory in lock_class entry.
+ */
 void lockdep_unregister_key(struct lock_class_key *key)
 {
 	struct hlist_head *hash_head = keyhashentry(key);
@@ -5317,10 +5323,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
+	lockdep_lock();
 
-	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
 			hlist_del_rcu(&k->hash_entry);
@@ -5328,11 +5332,13 @@ void lockdep_unregister_key(struct lock_class_key *key)
 			break;
 		}
 	}
-	WARN_ON_ONCE(!found);
-	__lockdep_free_key_range(pf, key, 1);
-	call_rcu_zapped(pf);
-	graph_unlock();
-out_irq:
+	WARN_ON_ONCE(!found && debug_locks);
+	if (found) {
+		pf = get_pending_free();
+		__lockdep_free_key_range(pf, key, 1);
+		call_rcu_zapped(pf);
+	}
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-- 
2.47.0.rc1.288.g06298d1525-goog


