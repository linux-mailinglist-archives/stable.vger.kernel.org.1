Return-Path: <stable+bounces-111176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7FA21F3E
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C6F188345A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98954149C69;
	Wed, 29 Jan 2025 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WU54s9+8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H7i/Dwdm"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45128FF;
	Wed, 29 Jan 2025 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161239; cv=none; b=ouynR1P9EslNVQutEfdRdFYRSQ8Wus1KJ+v8SERIy1ElXN4ijQWlzgFPsW+tT0VILGwC9Zbzs1Ks1cGFkKc2VBAUodnM22fi8cy8KGQG5u0oxtGYgm8oc/3I14VkGR7gakw0JHx1PwezgQx7d4xzqMQmjdi0DleY0vITrl8abgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161239; c=relaxed/simple;
	bh=L74M3KHDpSyNvgRcggxvwCNCHyblalcP/GD0WNrpB4c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=u2EgFd6fAABW9Ha8+lTwQj/hWIhTIIr3qaPN7Rr6su9Y5kM+D/qbSpUlTdKBkuxYsjC8udQLMpx6KGgRyUy4SEyls85l/OsdciQsdE4a02NzsXZ3Yfg0PjZ1Ss8CjK/L6+YL9YDXGrKpkCjxT7xo7E7Vs5FMdQCP2VixPvXXzy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WU54s9+8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H7i/Dwdm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Jan 2025 14:33:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738161234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qMezJWQbRkxWMxDma2qkK64yeogvHOEOwq2Yrl8QBTg=;
	b=WU54s9+8xYBFm4+L4ZrSkJwOhOoUg8gh9rNw57YsKPMqETJa7ngcnyoUXBhgET4uaoe4by
	WJR4Nlf338BiE06peW9HreqtXKw1Qoo5O0P/hsqzuPHaKMmlFoPeE2yhDOOse/r0lYKJrG
	GFM+alVyRq/suunMpcVT653y1wuCZ/bHm1eq4FykNkEpYfU0BDoZrbqAf5o9GClv8EsCqo
	Gx3F7AtwOBFY3Xk66cc2/ymAtQ8NHwSvgS+qfcEUhAGkbL3z/BC9c0Peo1NhDOcEotX2O7
	UBRuVBwOQUIYsyUvdb9NDU1hg8AWsD1QcdPQR5A78PjGVZKwkRWj9k/j/Xy+YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738161234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qMezJWQbRkxWMxDma2qkK64yeogvHOEOwq2Yrl8QBTg=;
	b=H7i/DwdmGQYV/EkQwR/GZGN2M+mjVej2i/6h/OcckZdfUUjtKpX4bG3E9dcrj/n3EYKtuW
	qm3Q6KnPry91hQCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] rcuref: Plug slowpath race in rcuref_put()
Cc: kernel test robot <oliver.sang@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173816123142.31546.2255602054894403680.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     b9a49520679e98700d3d89689cc91c08a1c88c1d
Gitweb:        https://git.kernel.org/tip/b9a49520679e98700d3d89689cc91c08a1c88c1d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 19 Jan 2025 00:55:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 29 Jan 2025 15:21:31 +01:00

rcuref: Plug slowpath race in rcuref_put()

Kernel test robot reported an "imbalanced put" in the rcuref_put() slow
path, which turned out to be a false positive. Consider the following race:

            ref  = 0 (via rcuref_init(ref, 1))
 T1                                      T2
 rcuref_put(ref)
 -> atomic_add_negative_release(-1, ref)                                         # ref -> 0xffffffff
 -> rcuref_put_slowpath(ref)
                                         rcuref_get(ref)
                                         -> atomic_add_negative_relaxed(1, &ref->refcnt)
                                           -> return true;                       # ref -> 0

                                         rcuref_put(ref)
                                         -> atomic_add_negative_release(-1, ref) # ref -> 0xffffffff
                                         -> rcuref_put_slowpath()

    -> cnt = atomic_read(&ref->refcnt);                                          # cnt -> 0xffffffff / RCUREF_NOREF
    -> atomic_try_cmpxchg_release(&ref->refcnt, &cnt, RCUREF_DEAD))              # ref -> 0xe0000000 / RCUREF_DEAD
       -> return true
                                           -> cnt = atomic_read(&ref->refcnt);   # cnt -> 0xe0000000 / RCUREF_DEAD
                                           -> if (cnt > RCUREF_RELEASED)         # 0xe0000000 > 0xc0000000
                                             -> WARN_ONCE(cnt >= RCUREF_RELEASED, "rcuref - imbalanced put()")

The problem is the additional read in the slow path (after it
decremented to RCUREF_NOREF) which can happen after the counter has been
marked RCUREF_DEAD.

Prevent this by reusing the return value of the decrement. Now every "final"
put uses RCUREF_NOREF in the slow path and attempts the final cmpxchg() to
RCUREF_DEAD.

[ bigeasy: Add changelog ]

Fixes: ee1ee6db07795 ("atomics: Provide rcuref - scalable reference counting")
Reported-by: kernel test robot <oliver.sang@intel.com>
Debugged-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/oe-lkp/202412311453.9d7636a2-lkp@intel.com
---
 include/linux/rcuref.h |  9 ++++++---
 lib/rcuref.c           |  5 ++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcuref.h b/include/linux/rcuref.h
index 2c8bfd0..6322d8c 100644
--- a/include/linux/rcuref.h
+++ b/include/linux/rcuref.h
@@ -71,27 +71,30 @@ static inline __must_check bool rcuref_get(rcuref_t *ref)
 	return rcuref_get_slowpath(ref);
 }
 
-extern __must_check bool rcuref_put_slowpath(rcuref_t *ref);
+extern __must_check bool rcuref_put_slowpath(rcuref_t *ref, unsigned int cnt);
 
 /*
  * Internal helper. Do not invoke directly.
  */
 static __always_inline __must_check bool __rcuref_put(rcuref_t *ref)
 {
+	int cnt;
+
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() && preemptible(),
 			 "suspicious rcuref_put_rcusafe() usage");
 	/*
 	 * Unconditionally decrease the reference count. The saturation and
 	 * dead zones provide enough tolerance for this.
 	 */
-	if (likely(!atomic_add_negative_release(-1, &ref->refcnt)))
+	cnt = atomic_sub_return_release(1, &ref->refcnt);
+	if (likely(cnt >= 0))
 		return false;
 
 	/*
 	 * Handle the last reference drop and cases inside the saturation
 	 * and dead zones.
 	 */
-	return rcuref_put_slowpath(ref);
+	return rcuref_put_slowpath(ref, cnt);
 }
 
 /**
diff --git a/lib/rcuref.c b/lib/rcuref.c
index 97f300e..5bd726b 100644
--- a/lib/rcuref.c
+++ b/lib/rcuref.c
@@ -220,6 +220,7 @@ EXPORT_SYMBOL_GPL(rcuref_get_slowpath);
 /**
  * rcuref_put_slowpath - Slowpath of __rcuref_put()
  * @ref:	Pointer to the reference count
+ * @cnt:	The resulting value of the fastpath decrement
  *
  * Invoked when the reference count is outside of the valid zone.
  *
@@ -233,10 +234,8 @@ EXPORT_SYMBOL_GPL(rcuref_get_slowpath);
  *	with a concurrent get()/put() pair. Caller is not allowed to
  *	deconstruct the protected object.
  */
-bool rcuref_put_slowpath(rcuref_t *ref)
+bool rcuref_put_slowpath(rcuref_t *ref, unsigned int cnt)
 {
-	unsigned int cnt = atomic_read(&ref->refcnt);
-
 	/* Did this drop the last reference? */
 	if (likely(cnt == RCUREF_NOREF)) {
 		/*

