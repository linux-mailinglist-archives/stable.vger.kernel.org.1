Return-Path: <stable+bounces-94793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC19D6F27
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8EB1605B6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EA51E32D0;
	Sun, 24 Nov 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgOs3g76"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF01E32C8;
	Sun, 24 Nov 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452430; cv=none; b=YGShr+W5ikFI6IXyAkcJE8fGa+iWLpHl9uWWml6dguT/anKG3JJIvnGS+C/fyTomzxS7cGm0r1cZGpG8bC/+Uv2nJwBfiqGlM31XdEQcNM64PtVJhBDMBOh1kzXiT3IEHVnoneP876tc66OEsSQ8xE56Gdork7Bu6EB7CZdtSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452430; c=relaxed/simple;
	bh=MtiqgoI2o/vw98DXdP0vCH0oo6iL6enNCXHHH09oO28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDrQBGMy88OwimsZxszW6COEBGmYOUW5KBqFZq8ST3sp/zjW7ouupg4csGKXw5yitGtTRGEXbBH5nKtSC2ImhTPrty0HCrXnHNcNsk62OsV86oF5FK8aAglB24qOrRCbLZlGa80hAvfSj/MHHGAncaYhOrvUWbsU89dUGp/HWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgOs3g76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887BFC4CECC;
	Sun, 24 Nov 2024 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452430;
	bh=MtiqgoI2o/vw98DXdP0vCH0oo6iL6enNCXHHH09oO28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NgOs3g76R4EboGitYPOkElS9jd/ZYsPfs0tljO3QLiHc07YURm0gzfULXj/SrfedZ
	 JVHQV4uvhkRqO+MyZGzOtko2AbjAedMbdoRlEyZ4oaowBIelhgYOO773+lj3BhQJ6A
	 2nxKB0w6JCz/HXPoIaKLpUnzd8wmG5rDswEjiP893QEk2Vr3HMya/esR2nr40Ps4ep
	 yg+6SxZlu15JdPiG7YJepaXXTDtyLSSf6KmFDaAhlM10aj/LIorpCGoRFOAvIb7FID
	 1XSqNMAE7kKLjpqWOjEsY8wdO2V3IVYvshRdo+IKnFSrakvlpyG/AV9GtkohFkL0te
	 oMlLdnp1MPqkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	will@kernel.org
Subject: [PATCH AUTOSEL 6.6 3/4] locking/ww_mutex: Adjust to lockdep nest_lock requirements
Date: Sun, 24 Nov 2024 07:46:57 -0500
Message-ID: <20241124124702.3338309-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124702.3338309-1-sashal@kernel.org>
References: <20241124124702.3338309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

[ Upstream commit 823a566221a5639f6c69424897218e5d6431a970 ]

When using mutex_acquire_nest() with a nest_lock, lockdep refcounts the
number of acquired lockdep_maps of mutexes of the same class, and also
keeps a pointer to the first acquired lockdep_map of a class. That pointer
is then used for various comparison-, printing- and checking purposes,
but there is no mechanism to actively ensure that lockdep_map stays in
memory. Instead, a warning is printed if the lockdep_map is freed and
there are still held locks of the same lock class, even if the lockdep_map
itself has been released.

In the context of WW/WD transactions that means that if a user unlocks
and frees a ww_mutex from within an ongoing ww transaction, and that
mutex happens to be the first ww_mutex grabbed in the transaction,
such a warning is printed and there might be a risk of a UAF.

Note that this is only problem when lockdep is enabled and affects only
dereferences of struct lockdep_map.

Adjust to this by adding a fake lockdep_map to the acquired context and
make sure it is the first acquired lockdep map of the associated
ww_mutex class. Then hold it for the duration of the WW/WD transaction.

This has the side effect that trying to lock a ww mutex *without* a
ww_acquire_context but where a such context has been acquire, we'd see
a lockdep splat. The test-ww_mutex.c selftest attempts to do that, so
modify that particular test to not acquire a ww_acquire_context if it
is not going to be used.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241009092031.6356-1-thomas.hellstrom@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ww_mutex.h       | 14 ++++++++++++++
 kernel/locking/test-ww_mutex.c |  8 +++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index bb763085479af..a401a2f31a775 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -65,6 +65,16 @@ struct ww_acquire_ctx {
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
+	/**
+	 * @first_lock_dep_map: fake lockdep_map for first locked ww_mutex.
+	 *
+	 * lockdep requires the lockdep_map for the first locked ww_mutex
+	 * in a ww transaction to remain in memory until all ww_mutexes of
+	 * the transaction have been unlocked. Ensure this by keeping a
+	 * fake locked ww_mutex lockdep map between ww_acquire_init() and
+	 * ww_acquire_fini().
+	 */
+	struct lockdep_map first_lock_dep_map;
 #endif
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
 	unsigned int deadlock_inject_interval;
@@ -146,7 +156,10 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
 	lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
 			 &ww_class->acquire_key, 0);
+	lockdep_init_map(&ctx->first_lock_dep_map, ww_class->mutex_name,
+			 &ww_class->mutex_key, 0);
 	mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
+	mutex_acquire_nest(&ctx->first_lock_dep_map, 0, 0, &ctx->dep_map, _RET_IP_);
 #endif
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
 	ctx->deadlock_inject_interval = 1;
@@ -185,6 +198,7 @@ static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
+	mutex_release(&ctx->first_lock_dep_map, _THIS_IP_);
 	mutex_release(&ctx->dep_map, _THIS_IP_);
 #endif
 #ifdef DEBUG_WW_MUTEXES
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 7c5a8f05497f2..02b84288865ca 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -62,7 +62,8 @@ static int __test_mutex(unsigned int flags)
 	int ret;
 
 	ww_mutex_init(&mtx.mutex, &ww_class);
-	ww_acquire_init(&ctx, &ww_class);
+	if (flags & TEST_MTX_CTX)
+		ww_acquire_init(&ctx, &ww_class);
 
 	INIT_WORK_ONSTACK(&mtx.work, test_mutex_work);
 	init_completion(&mtx.ready);
@@ -90,7 +91,8 @@ static int __test_mutex(unsigned int flags)
 		ret = wait_for_completion_timeout(&mtx.done, TIMEOUT);
 	}
 	ww_mutex_unlock(&mtx.mutex);
-	ww_acquire_fini(&ctx);
+	if (flags & TEST_MTX_CTX)
+		ww_acquire_fini(&ctx);
 
 	if (ret) {
 		pr_err("%s(flags=%x): mutual exclusion failure\n",
@@ -663,7 +665,7 @@ static int __init test_ww_mutex_init(void)
 	if (ret)
 		return ret;
 
-	ret = stress(2047, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
+	ret = stress(2046, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
 	if (ret)
 		return ret;
 
-- 
2.43.0


