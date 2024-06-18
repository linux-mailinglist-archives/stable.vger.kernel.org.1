Return-Path: <stable+bounces-53617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC190D318
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D74E1C24638
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027115535F;
	Tue, 18 Jun 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zSjGEqx4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF014BF92
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717630; cv=none; b=URHZ+FH07sD5cRcuTcMkd8wQcjKJtobStJkwMUpriAfOYMHh4MkdU6WfNMsP+GjgluXgqDcfU8YXdZThw9qYrX2Ip53thMoEuq8eWSt7+qGMWgkdf6JmlY+Wd9G6lMU8uhrbrNcvo9VIIR860xb5ltVmyfGk1LvjyXczvG0S4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717630; c=relaxed/simple;
	bh=gT0belOhXLo2wHVok0Hztf+1bLW4A+CvYdQomr3iZF8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fi563qXJ4T8by9sxtK2qKHCA99x5UqTxlPB9fr5xbaCl4RXCt81DC44vqMWSbRHviXs1m2RGUOfl+44JNLNIqH/hxus+kdOVQtO2D2kuyla8MAqXrVI39nnnC83c3TRnh89p/nm2jhakbQuuBEmw9RZUcK/j3KHby3pXR0dSDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zSjGEqx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88639C3277B;
	Tue, 18 Jun 2024 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717629;
	bh=gT0belOhXLo2wHVok0Hztf+1bLW4A+CvYdQomr3iZF8=;
	h=Subject:To:Cc:From:Date:From;
	b=zSjGEqx409UASAzbKm285sWysjb3wiARn2psmWjSGGfGBEGGkdWzv+LHfGJmvS3c/
	 2NKTWhB+6pIYtgNuDjkinwUOG+KjJHdDqEqpDoxskODyI+NqQyJXn9raaEpfOVCJpT
	 gLiV8IK3EdtZNZfUgKIXnKEJmCkpEq+W76wOrCao=
Subject: FAILED: patch "[PATCH] locking/atomic: scripts: fix ${atomic}_sub_and_test()" failed to apply to 6.6-stable tree
To: cmllamas@google.com,keescook@chromium.org,mark.rutland@arm.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 15:25:10 +0200
Message-ID: <2024061810-overflow-president-399a@gregkh>
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
git cherry-pick -x f92a59f6d12e31ead999fee9585471b95a8ae8a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061810-overflow-president-399a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f92a59f6d12e ("locking/atomic: scripts: fix ${atomic}_sub_and_test() kerneldoc")
6dfee110c6cc ("locking/atomic: scripts: Clarify ordering of conditional atomics")
e01cc1e8c2ad ("locking/atomic: Add generic support for sync_try_cmpxchg() and its fallback")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f92a59f6d12e31ead999fee9585471b95a8ae8a3 Mon Sep 17 00:00:00 2001
From: Carlos Llamas <cmllamas@google.com>
Date: Wed, 15 May 2024 13:37:10 +0000
Subject: [PATCH] locking/atomic: scripts: fix ${atomic}_sub_and_test()
 kerneldoc

For ${atomic}_sub_and_test() the @i parameter is the value to subtract,
not add. Fix the typo in the kerneldoc template and generate the headers
with this update.

Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20240515133844.3502360-1-cmllamas@google.com

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 956bcba5dbf2..2f9d36b72bd8 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -2242,7 +2242,7 @@ raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 
 /**
  * raw_atomic_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: int value to add
+ * @i: int value to subtract
  * @v: pointer to atomic_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -4368,7 +4368,7 @@ raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 
 /**
  * raw_atomic64_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: s64 value to add
+ * @i: s64 value to subtract
  * @v: pointer to atomic64_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -4690,4 +4690,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 14850c0b0db20c62fdc78ccd1d42b98b88d76331
+// b565db590afeeff0d7c9485ccbca5bb6e155749f
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index debd487fe971..9409a6ddf3e0 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1349,7 +1349,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 
 /**
  * atomic_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: int value to add
+ * @i: int value to subtract
  * @v: pointer to atomic_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -2927,7 +2927,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 
 /**
  * atomic64_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: s64 value to add
+ * @i: s64 value to subtract
  * @v: pointer to atomic64_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -4505,7 +4505,7 @@ atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 
 /**
  * atomic_long_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: long value to add
+ * @i: long value to subtract
  * @v: pointer to atomic_long_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -5050,4 +5050,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// ce5b65e0f1f8a276268b667194581d24bed219d4
+// 8829b337928e9508259079d32581775ececd415b
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 3ef844b3ab8a..f86b29d90877 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -1535,7 +1535,7 @@ raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 
 /**
  * raw_atomic_long_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: long value to add
+ * @i: long value to subtract
  * @v: pointer to atomic_long_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -1809,4 +1809,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 1c4a26fc77f345342953770ebe3c4d08e7ce2f9a
+// eadf183c3600b8b92b91839dd3be6bcc560c752d
diff --git a/scripts/atomic/kerneldoc/sub_and_test b/scripts/atomic/kerneldoc/sub_and_test
index d3760f7749d4..96615e50836b 100644
--- a/scripts/atomic/kerneldoc/sub_and_test
+++ b/scripts/atomic/kerneldoc/sub_and_test
@@ -1,7 +1,7 @@
 cat <<EOF
 /**
  * ${class}${atomicname}() - atomic subtract and test if zero with ${desc_order} ordering
- * @i: ${int} value to add
+ * @i: ${int} value to subtract
  * @v: pointer to ${atomic}_t
  *
  * Atomically updates @v to (@v - @i) with ${desc_order} ordering.


