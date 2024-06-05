Return-Path: <stable+bounces-48225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8878FD094
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 16:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761C9B29648
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EBD13FFC;
	Wed,  5 Jun 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gGPUtNiT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0hsE4Uci"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEAC257B;
	Wed,  5 Jun 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596247; cv=none; b=tdvBB2QhFDAI10zwv/qbKTRP+GJuIgIEp03nDdb9FMMF0ufzl23Gm0wIg+JCoV3w9YBsdLiOzrDvMt8opJIrypJ8CHDLFXNcqMDBPwNfIVi3SuVMQlwMQ9nwNxtuXebVwi/TIiJv+1n4pWkblnaX/EpQy1vodeGE7AN1bClz8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596247; c=relaxed/simple;
	bh=Fb0Q2ZcUDq32sPgcolecMF/mxztpDjuHvr1sFl+gII0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j++xkCu2EteMuGxr1qH4tk5mv57iELHHuQBxCW/wONj+7wWblruwYGywJNUhIcGNF2yxvqIsyZ0kB3buSAnCzD1aTsCXQDaCCFbZeY14LIJD0lqGjw8JojMvbtpZvRGA0hn885QT9PBZJcO2kH3mPBIdWqBt/sdlfV8gIDd1ibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gGPUtNiT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0hsE4Uci; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 14:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717596243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brOKJEgAwoIaoK6tDtQPbkLIQHkKhKhj0UiOZee1Xsk=;
	b=gGPUtNiT0giF2y2bJUAXiI3WBgso7VACVPKs3PBAR/k9Q+LVP8tq48snr0BkyXIVUv2YH+
	CxHs1sotySoV9mTbVE28OC868bBj0KwFe585LKHDBwFSp9SG28kyVBSAPylelexRE3mgZ6
	13QlHb3nM8y/fRjQU5uYN+g1ALA8Hwi2lorVtHI3CFQIe4WjMDTw33ivQerpK3+zdyUPr9
	HBWWCENcXliFOsuqpTpaKIlIl6+T7L4tv6wMZ82/lbpfIgBMDrdb1JzxnU2ompdI9Q+L4H
	m0UVq5fLLtpuij1B2/RCw7DVqOQPeQzMNQhv7KW5Nbo38nk5f0noYDMPZeRbYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717596243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brOKJEgAwoIaoK6tDtQPbkLIQHkKhKhj0UiOZee1Xsk=;
	b=0hsE4Uciqavfv5RV2aKRws+UbO5QjRVJYUfjTfhz/VKIzKAEnRw3E5AIDdd6eN3o5bp53S
	wdqhZ3GLB1S7OfAw==
From: "tip-bot2 for Carlos Llamas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/atomic: scripts: fix
 ${atomic}_sub_and_test() kerneldoc
Cc: Mark Rutland <mark.rutland@arm.com>, Carlos Llamas <cmllamas@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kees Cook <keescook@chromium.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240515133844.3502360-1-cmllamas@google.com>
References: <20240515133844.3502360-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171759624257.10875.11429140430350503529.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     f92a59f6d12e31ead999fee9585471b95a8ae8a3
Gitweb:        https://git.kernel.org/tip/f92a59f6d12e31ead999fee9585471b95a8ae8a3
Author:        Carlos Llamas <cmllamas@google.com>
AuthorDate:    Wed, 15 May 2024 13:37:10 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Jun 2024 15:52:34 +02:00

locking/atomic: scripts: fix ${atomic}_sub_and_test() kerneldoc

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
---
 include/linux/atomic/atomic-arch-fallback.h | 6 +++---
 include/linux/atomic/atomic-instrumented.h  | 8 ++++----
 include/linux/atomic/atomic-long.h          | 4 ++--
 scripts/atomic/kerneldoc/sub_and_test       | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 956bcba..2f9d36b 100644
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
index debd487..9409a6d 100644
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
index 3ef844b..f86b29d 100644
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
index d3760f7..96615e5 100644
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

