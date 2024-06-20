Return-Path: <stable+bounces-54765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8F911102
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBEDB2592E
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDBE374FA;
	Thu, 20 Jun 2024 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+Ccu7L7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA51C02
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907491; cv=none; b=enEqbsguwcmJYq9ZIqdi9RJ1LoHBElZQD+SaA3lEijoXlgUqlIlWx3KS8to0AfSHUsCTWvNR483KY4GDJRF29i8L7mK69I0a405dyKFGJG7kTqp2R00SDiK1s86MGPMfppxwLIZ9U5AdmrhHa9g2ORJfK9Uq7Urr/k9ZSjf7C0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907491; c=relaxed/simple;
	bh=IPfYwxARu7NCkgTdFg111D0I4vVo+mBYGGixl4P6r1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ds77aWMkM5ANw6bQZ3zlYFzQLIqJ0BVZgFNew4pQfGwA80IQGO/0/J+lMFkq4Pqcgwy8PoW6k+icIfkz8LUPh5akXA9k7AyjR2b+QXA+zZyORRpdq5GSKWSf0hLcOGCKzbtOBBOIkBkZYSsK8t2aIEzSYxz4our2OlKTyHjRENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+Ccu7L7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-62a379a7c80so774445a12.1
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718907489; x=1719512289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FngRutwjKPNrsS0ugT3tNFhlVCqJ7Fe8o5v3xPogwQM=;
        b=s+Ccu7L7kbe4J5jYiSF1TAQ163VOP6jyi8LJcsbUz5q/VXYLGktb3CpF+TCVecnmXU
         nz/ogMczgBCs49Vv/bMez1zlCBwLC7xfpMefjq0bJSkf3z/2kQLjcHvbvVlsT629jCT2
         jldivOoEPzQpQKHVgTdEperrRd4kct5vy3sb2KGN4OhU4OxY7Qbt6/bDRELedxMR/nh8
         1M2r/WuwuKEjXpg3UQ5Vo5w/ywpic/YVpyUffX/WA9m++0nMmGvc9oYW1oU6tUZIm3Z0
         5X8C02yQHM81XVtFj6kHcAwg6HJvccejo6w/DqUpzcAxiV5J4Mlwqw+pvl+OyAz1HyLo
         1NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907489; x=1719512289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FngRutwjKPNrsS0ugT3tNFhlVCqJ7Fe8o5v3xPogwQM=;
        b=ovVbNk/p7wPfvD3D4Jn7DEVsHFk8uCSE5Cjpj5typk4ItVAW4UTdxH314KY6bgmaZQ
         e2e9v5+mbgSwcfh5i4IC8EB1kVWlG6NIGnY6oLZPhQ2/f+rZHMJcGX9FF79PRz1a5T5a
         JeVJaJzmpjcgTkuJbyi70XSTI/i01BHX6eLHQmTPjiPq3kv/CNNLFCqQzOlPUQ43h9h1
         +x5ngCkEpq3Nd871wmCriaFflNSfpr1q2ugpyMOyt0xXeIHxF5xXxzZKluV0AGVsVjOY
         UjUig7F9SWG3lcQMwkeipaZuJszhcxUKePHpy1BowG5xZJ6TyBs1pjXpSDRT3pfANmIy
         RAkg==
X-Gm-Message-State: AOJu0YyRq+UZ8PgKCxRpx7GT3Oev9p5FsM8MDbBzukk7ovtOe1fgkJNZ
	ZGOFGzIjKuH1ac7Tv4XVpynY+hfJPjmo1nf3hVK+97bFy5gAA127NPoyQ95Sf4CScNO6OGYkPWJ
	7VJwxdViL+0hRUaX2BWgHWC8OEkcNe1+slfCGeojloUfgM2ZDxkmLZHe3e+GhvwXIv0//xzYEfl
	pJqyCBBWL0515Pdl/Ft1I6wMQrXrbJin2LrnY/gSE2QHs=
X-Google-Smtp-Source: AGHT+IE5tasoiFnp8BbqpOf9h2ql0Nx+YhV1LeivyDae19dkHE+6VTePtu31zdf4Gyoh4EE+8yr3A+P/Q/L2JA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:e047:0:b0:659:6d57:7a5e with SMTP id
 41be03b00d2f7-7108ae61581mr19197a12.5.1718907488948; Thu, 20 Jun 2024
 11:18:08 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:18:05 +0000
In-Reply-To: <2024061810-overflow-president-399a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024061810-overflow-president-399a@gregkh>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620181805.2713680-1-cmllamas@google.com>
Subject: [PATCH 6.6.y] locking/atomic: scripts: fix ${atomic}_sub_and_test() kerneldoc
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

commit f92a59f6d12e31ead999fee9585471b95a8ae8a3 upstream.

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
[cmllamas: generate headers with gen-atomics.sh]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 6 +++---
 include/linux/atomic/atomic-instrumented.h  | 8 ++++----
 include/linux/atomic/atomic-long.h          | 4 ++--
 scripts/atomic/kerneldoc/sub_and_test       | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index b83ef19da13d..313a76571019 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -2221,7 +2221,7 @@ raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 
 /**
  * raw_atomic_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: int value to add
+ * @i: int value to subtract
  * @v: pointer to atomic_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -4333,7 +4333,7 @@ raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 
 /**
  * raw_atomic64_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: s64 value to add
+ * @i: s64 value to subtract
  * @v: pointer to atomic64_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -4649,4 +4649,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 2fdd6702823fa842f9cea57a002e6e4476ae780c
+// f8888b25626bea006e7f11f7add7cecc33d0fa2e
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index d401b406ef7c..ce1af59e1c68 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1341,7 +1341,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 
 /**
  * atomic_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: int value to add
+ * @i: int value to subtract
  * @v: pointer to atomic_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -2905,7 +2905,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 
 /**
  * atomic64_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: s64 value to add
+ * @i: s64 value to subtract
  * @v: pointer to atomic64_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -4469,7 +4469,7 @@ atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 
 /**
  * atomic_long_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: long value to add
+ * @i: long value to subtract
  * @v: pointer to atomic_long_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -5000,4 +5000,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 1568f875fef72097413caab8339120c065a39aa4
+// 5f7bb165838dcca35625e7d4b42540b790abd19b
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index c82947170ddc..aa4a5c09660f 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -1527,7 +1527,7 @@ raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 
 /**
  * raw_atomic_long_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: long value to add
+ * @i: long value to subtract
  * @v: pointer to atomic_long_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
@@ -1795,4 +1795,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 4ef23f98c73cff96d239896175fd26b10b88899e
+// f8204cfa718c04a01e3c7a15257ac85bbef54c23
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
-- 
2.45.2.741.gdbec12cfda-goog


