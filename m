Return-Path: <stable+bounces-63427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCC69418E8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941932850DD
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F3183CD5;
	Tue, 30 Jul 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r8Q81MRT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196091A6161;
	Tue, 30 Jul 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356799; cv=none; b=ZV7hjtfXek1phRbl0ZWaDlZjR0/r9h7eShN9h6qhMfNn8XTjVPji2yGy1cwbYhHIt5NW1FtBMkpjmXBD9LLMu+ZuTjWvxCigltxYe8CKs/Vs72t6s/oZdHnyCcrzCylkvaNYqR561h4M0cxrPvELNjIJxH+YSAMvc0avhIrFpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356799; c=relaxed/simple;
	bh=4HXsh0cP7OPFHFpiRxRxf1og1KLcxi3QmJiTgD8crQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkBxqCkkc4FsRJ9VY2U2TgNyoZoSxyjeGJLXOYj5UZZ4GjvjTjn/SLpXGE/5PU/d6jxgNrhC+sGqPmSgRkVKF/m/uOqcyuApaxI2dOiy5U4PJVY2gQP8Qn3Sr543/rRO0n3b8C/sEkggRmthYmmAe2Th07UbSkjrWIviB6B5kvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r8Q81MRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FE3C32782;
	Tue, 30 Jul 2024 16:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356798;
	bh=4HXsh0cP7OPFHFpiRxRxf1og1KLcxi3QmJiTgD8crQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8Q81MRTq/6DMgMQ0Ku/vSS8lzQyFOPIBabMun0GayukEujhD2nntib8h2brfh4R+
	 1UAOhS4Ri8bBm2EmQZ1XwK090gM37wHQkk9P6PEwefYActF4n+6EfBTfPxrfwsPd/v
	 VHmLwqjuv8q6Q1s/KxSjWUQ7UxwWKjLOXJLzrlmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yue Sun <samsun1006219@gmail.com>,
	Xingwei Lee <xrivendell7@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 188/809] jump_label: Fix concurrency issues in static_key_slow_dec()
Date: Tue, 30 Jul 2024 17:41:04 +0200
Message-ID: <20240730151732.035384141@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 83ab38ef0a0b2407d43af9575bb32333fdd74fb2 ]

The commit which tried to fix the concurrency issues of concurrent
static_key_slow_inc() failed to fix the equivalent issues
vs. static_key_slow_dec():

CPU0                     CPU1

static_key_slow_dec()
  static_key_slow_try_dec()

	key->enabled == 1
	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
	if (val == 1)
	     return false;

  jump_label_lock();
  if (atomic_dec_and_test(&key->enabled)) {
     --> key->enabled == 0
   __jump_label_update()

			 static_key_slow_dec()
			   static_key_slow_try_dec()

			     key->enabled == 0
			     val = atomic_fetch_add_unless(&key->enabled, -1, 1);

			      --> key->enabled == -1 <- FAIL

There is another bug in that code, when there is a concurrent
static_key_slow_inc() which enables the key as that sets key->enabled to -1
so on the other CPU

	val = atomic_fetch_add_unless(&key->enabled, -1, 1);

will succeed and decrement to -2, which is invalid.

Cure all of this by replacing the atomic_fetch_add_unless() with a
atomic_try_cmpxchg() loop similar to static_key_fast_inc_not_disabled().

[peterz: add WARN_ON_ONCE for the -1 race]
Fixes: 4c5ea0a9cd02 ("locking/static_key: Fix concurrent static_key_slow_inc()")
Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported-by: Xingwei Lee <xrivendell7@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240610124406.422897838@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/jump_label.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 3218fa5688b93..1f05a19918f47 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -131,7 +131,7 @@ bool static_key_fast_inc_not_disabled(struct static_key *key)
 	STATIC_KEY_CHECK_USE(key);
 	/*
 	 * Negative key->enabled has a special meaning: it sends
-	 * static_key_slow_inc() down the slow path, and it is non-zero
+	 * static_key_slow_inc/dec() down the slow path, and it is non-zero
 	 * so it counts as "enabled" in jump_label_update().  Note that
 	 * atomic_inc_unless_negative() checks >= 0, so roll our own.
 	 */
@@ -150,7 +150,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 	lockdep_assert_cpus_held();
 
 	/*
-	 * Careful if we get concurrent static_key_slow_inc() calls;
+	 * Careful if we get concurrent static_key_slow_inc/dec() calls;
 	 * later calls must wait for the first one to _finish_ the
 	 * jump_label_update() process.  At the same time, however,
 	 * the jump_label_update() call below wants to see
@@ -247,20 +247,32 @@ EXPORT_SYMBOL_GPL(static_key_disable);
 
 static bool static_key_slow_try_dec(struct static_key *key)
 {
-	int val;
-
-	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
-	if (val == 1)
-		return false;
+	int v;
 
 	/*
-	 * The negative count check is valid even when a negative
-	 * key->enabled is in use by static_key_slow_inc(); a
-	 * __static_key_slow_dec() before the first static_key_slow_inc()
-	 * returns is unbalanced, because all other static_key_slow_inc()
-	 * instances block while the update is in progress.
+	 * Go into the slow path if key::enabled is less than or equal than
+	 * one. One is valid to shut down the key, anything less than one
+	 * is an imbalance, which is handled at the call site.
+	 *
+	 * That includes the special case of '-1' which is set in
+	 * static_key_slow_inc_cpuslocked(), but that's harmless as it is
+	 * fully serialized in the slow path below. By the time this task
+	 * acquires the jump label lock the value is back to one and the
+	 * retry under the lock must succeed.
 	 */
-	WARN(val < 0, "jump label: negative count!\n");
+	v = atomic_read(&key->enabled);
+	do {
+		/*
+		 * Warn about the '-1' case though; since that means a
+		 * decrement is concurrent with a first (0->1) increment. IOW
+		 * people are trying to disable something that wasn't yet fully
+		 * enabled. This suggests an ordering problem on the user side.
+		 */
+		WARN_ON_ONCE(v < 0);
+		if (v <= 1)
+			return false;
+	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
+
 	return true;
 }
 
@@ -271,10 +283,11 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 	if (static_key_slow_try_dec(key))
 		return;
 
-	jump_label_lock();
-	if (atomic_dec_and_test(&key->enabled))
+	guard(mutex)(&jump_label_mutex);
+	if (atomic_cmpxchg(&key->enabled, 1, 0))
 		jump_label_update(key);
-	jump_label_unlock();
+	else
+		WARN_ON_ONCE(!static_key_slow_try_dec(key));
 }
 
 static void __static_key_slow_dec(struct static_key *key)
-- 
2.43.0




