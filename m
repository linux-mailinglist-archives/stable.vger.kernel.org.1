Return-Path: <stable+bounces-45168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79D8C6781
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 15:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C181F2341C
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68B1272D5;
	Wed, 15 May 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3YSJsm81"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1B8595F
	for <stable@vger.kernel.org>; Wed, 15 May 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780343; cv=none; b=DLUAc/skq4Q6bDVKpbEe8ipxfCYdXVy0IA9QN0/zEfh1UP4DfSCuF1UvxwguCSDQlsboGe7sX6hYntX+PTQTxBwyLkMzR3ujNRUZNFi8+LTUL1jgxdXb6Uf63uh4ie61HDkvFEColGVpKbA2DwFqVWtqnv2rA+wnzGIdyVXBCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780343; c=relaxed/simple;
	bh=+q68qLffCQ8ohP1Ct5Wt6hlG+Spc5lOHshUFKXtvOYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uzIvn1GMlUirsv6bZxnCZh83xzUnbWRuSqT5OHkBII8A6v+s+dgFxA+Ujxn4IC4bojL89WP1OmHh8Bn4yX0ncX8O0JD3coeQ5FXYbjofi98M1q7iwsB6UeKMkZ43xhgmygsFhtYH/klc9Qkzrd6fUL3wU6SqPLKIEB04Xi+s/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3YSJsm81; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f4755be972so4452363b3a.0
        for <stable@vger.kernel.org>; Wed, 15 May 2024 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715780341; x=1716385141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPBzW+amWPhjwlTP5JQYyMHPSoVaeIQN8RijRrwrY5o=;
        b=3YSJsm81lk/qVXDvbiqWMoNcXjgMsVWuwbljSGZBzxqMw6SDftGTBJ5DOgw2BMzsYF
         B1BfLlqvaA0sgeu6TPpj2mjQYDxCr1BNnG+vPeXZggm3C61XQTjH+2D+tzB0GlvxG/8M
         2c4pv7k7CwAfVMYvWBXTCj/4ZrzWhn0L4osEmkQCVkTLjAcpWzEd9caedXji15DfvDf9
         yV1+vVmQHgvbF8mfhvn1HEXk71gdAthgokowTp0o07q0G1Ih03fzzwWqrlpBS0gpT9OA
         7pKBOQge1QKIFDLlVplNuy4mR6l3Ynt0bCSLLcObueMECULWI//DzYri0bGFw1Tou4oK
         LDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715780341; x=1716385141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPBzW+amWPhjwlTP5JQYyMHPSoVaeIQN8RijRrwrY5o=;
        b=LsLHjj73Eq+pNemdBruGKV65db89DlhkOhq9d/3++NXgxuVrM5uLnzDOWBeb1TivTr
         1WTkJ2Oyqecide5/PLX2iuZO4dvU1n8mVtNZfysY7ym78RTzHWLDoxqUPCXagVj1nuKU
         OgCyec2b/LJy4PXIE5WG/rN13cALkQdEGGfl3nQw7Zc0yw3VpUbZ3sq+zoGb2n+t+SXL
         l3+MZEfqtoNH9vMWVClUeofcAf7vryRRD8qAlUT/FQNI59B/ChxIevzP1hQsh26IjAVG
         dnZ2dFfM4m2cknsYaj1mmKnNgE/rHF4zwEjJlJjJeN4UgRgqGiwiDAhe3p9oqBQBqxKT
         nofw==
X-Forwarded-Encrypted: i=1; AJvYcCUrFneUgTSi/0H9g7Rb+WuYtZsObJnrSMAcMpmxlghrKL7ub4uhjgo3xpQAQ7CGPjTa8URLHF6AofEd7okEJ8ka+E1LMQb9
X-Gm-Message-State: AOJu0YymSbGzTklr+9/heKa4uDZVg/TE844+2auf+mjbApxYuVnsAIZW
	gM8OXMd2yvpGPPSY7Fc8NTYaHt0mj67q2uV8YyIkVCbGqg7i2lGc6qIDkxjrk2ul9bktv1nvm8U
	nZaFDbyO+YA==
X-Google-Smtp-Source: AGHT+IHjhWzgWKKbS0lhm52/3G5+5pjlBVgo1aud6No+Ix3PvQKS9gPnNT9c5Qwzn6hh0RU/XCeI9fRNWs1Rrw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:98b:b0:6f3:ea4b:d1bf with SMTP
 id d2e1a72fcca58-6f4e01b8428mr956707b3a.0.1715780341237; Wed, 15 May 2024
 06:39:01 -0700 (PDT)
Date: Wed, 15 May 2024 13:37:10 +0000
In-Reply-To: <ZkRuMcao7lusrypL@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZkRuMcao7lusrypL@J2N7QTR9R3>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515133844.3502360-1-cmllamas@google.com>
Subject: [PATCH v2] locking/atomic: scripts: fix ${atomic}_sub_and_test() kerneldoc
From: Carlos Llamas <cmllamas@google.com>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Nhat Pham <nphamcs@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

For ${atomic}_sub_and_test() the @i parameter is the value to subtract,
not add. Fix the typo in the kerneldoc template and generate the headers
with this update.

Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---

Notes:
    v2: fix kerneldoc template instead, as pointed out by Mark

 include/linux/atomic/atomic-arch-fallback.h | 6 +++---
 include/linux/atomic/atomic-instrumented.h  | 8 ++++----
 include/linux/atomic/atomic-long.h          | 4 ++--
 scripts/atomic/kerneldoc/sub_and_test       | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

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
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


