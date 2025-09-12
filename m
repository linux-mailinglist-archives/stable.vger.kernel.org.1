Return-Path: <stable+bounces-179378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C630DB553A6
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 17:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E51BAE4870
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC3F3115BE;
	Fri, 12 Sep 2025 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tln1Vm9p"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA51DE4CE;
	Fri, 12 Sep 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691080; cv=none; b=CQCsJKyYMxWKyrel7cpblXxwfcLatoVpN407a3ikUu0udaNGBEgWqjnB2cGLA4AZdYzzLg2NSC+IdUI7hf8PwbqaafwUKTsP99cYqHKLK1L9oOjwrMEenJwK0h3LgYJesKoC7neXNgb2mweJ3s6uHZbDqdBVu8DRVV6iWk/kPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691080; c=relaxed/simple;
	bh=zIHVFRU7JOl0bYpSHV7NTHXlYG3ByO+E7astzdMeXcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LamwJwH9fvTgczll/Y1lH4wXL0IPj7JX5StMTrl/irv0kaapxp3NioVdlBJgOZSbZpBN0v+kaaNe2tFEtI2MowX/JnjVbAu79ZpDfF1F3te0sVPTNegI8sA3YP8tDZKKLWbHhaZl0kc7IjFblJOPWxhK2KIh8RWayGtncwGVwHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tln1Vm9p; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757691077; x=1789227077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d96GNjWBbnS29dz3XYCBT3ot4b9kYSMNELBZmlAyWgg=;
  b=Tln1Vm9pnIjHgITxz8wlUqz5Dg4T6MLWriaVmfxclk6bJMu4RMY+vOHr
   Cu961Fn1kTx4nh7nM4OIHnfUzF8jM48G7R9IA2eW7o15MHLYF4gtimwmj
   2vvk3KPGYIrdRZY6wMUiUDDIt5qMkhUW+VdKTVK4pKKfG1bZp9NHKLjea
   KHBeBSWAqIrFceCqIePBIB3xiQ52Yk4OTWmFy+pcTU7iZn7V08EcgE/FL
   gMZ0y/VjTlNVK2ailXQjB1iJYl9tVNLdM2/PIJEBHKkucRiUP/xOhE0nC
   uuwZp1bdYVwkEjPq9aBGD4zVTqRzi0F6vHw2mL+0EGP8jzBWqF5H2pLYX
   Q==;
X-CSE-ConnectionGUID: 7TRs1BryQcSu/okj6nTc4A==
X-CSE-MsgGUID: YE+EMdNjS+u9FwIKsY8nXg==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="1928867"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:31:06 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:24448]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.255:2525] with esmtp (Farcaster)
 id 6341e120-1c53-481f-9e4d-f12be0e304ca; Fri, 12 Sep 2025 15:31:06 +0000 (UTC)
X-Farcaster-Flow-ID: 6341e120-1c53-481f-9e4d-f12be0e304ca
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 15:31:05 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 15:30:58 +0000
From: Eliav Farber <farbere@amazon.com>
To: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mingo@redhat.com>,
	<natechancellor@gmail.com>, <ndesaulniers@google.com>,
	<keescook@chromium.org>, <sashal@kernel.org>, <akpm@linux-foundation.org>,
	<ojeda@kernel.org>, <elver@google.com>, <gregkh@linuxfoundation.org>,
	<kbusch@kernel.org>, <sj@kernel.org>, <bvanassche@acm.org>,
	<leon@kernel.org>, <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
	<linux-sparse@vger.kernel.org>, <clang-built-linux@googlegroups.com>,
	<stable@vger.kernel.org>
CC: <jonnyc@amazon.com>, <farbere@amazon.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 2/4 5.10.y] compiler.h: drop fallback overflow checkers
Date: Fri, 12 Sep 2025 15:30:36 +0000
Message-ID: <20250912153040.26691-3-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912153040.26691-1-farbere@amazon.com>
References: <20250912153040.26691-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: Nick Desaulniers <ndesaulniers@google.com>

[ Upstream commit 4eb6bd55cfb22ffc20652732340c4962f3ac9a91 ]

Once upgrading the minimum supported version of GCC to 5.1, we can drop
the fallback code for !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW.

This is effectively a revert of commit f0907827a8a9 ("compiler.h: enable
builtin overflow checkers and add fallback code")

Link: https://github.com/ClangBuiltLinux/linux/issues/1438#issuecomment-916745801
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/compiler-clang.h     |  13 ---
 include/linux/compiler-gcc.h       |   4 -
 include/linux/overflow.h           | 138 +---------------------------
 tools/include/linux/compiler-gcc.h |   4 -
 tools/include/linux/overflow.h     | 140 +----------------------------
 5 files changed, 6 insertions(+), 293 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 9ba951e3a6c2..928ec5c7776d 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -72,19 +72,6 @@
 #define __no_sanitize_coverage
 #endif
 
-/*
- * Not all versions of clang implement the type-generic versions
- * of the builtin overflow checkers. Fortunately, clang implements
- * __has_builtin allowing us to avoid awkward version
- * checks. Unfortunately, we don't know which version of gcc clang
- * pretends to be, so the macro may or may not be defined.
- */
-#if __has_builtin(__builtin_mul_overflow) && \
-    __has_builtin(__builtin_add_overflow) && \
-    __has_builtin(__builtin_sub_overflow)
-#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
-#endif
-
 #if __has_feature(shadow_call_stack)
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 5b481a22b5fe..ae9a8e17287c 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -140,10 +140,6 @@
 #define __no_sanitize_coverage
 #endif
 
-#if GCC_VERSION >= 50100
-#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
-#endif
-
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index d1dd039fe1c3..59d7228104d0 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -6,12 +6,9 @@
 #include <linux/limits.h>
 
 /*
- * In the fallback code below, we need to compute the minimum and
- * maximum values representable in a given type. These macros may also
- * be useful elsewhere, so we provide them outside the
- * COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW block.
- *
- * It would seem more obvious to do something like
+ * We need to compute the minimum and maximum values representable in a given
+ * type. These macros may also be useful elsewhere. It would seem more obvious
+ * to do something like:
  *
  * #define type_min(T) (T)(is_signed_type(T) ? (T)1 << (8*sizeof(T)-1) : 0)
  * #define type_max(T) (T)(is_signed_type(T) ? ((T)1 << (8*sizeof(T)-1)) - 1 : ~(T)0)
@@ -54,7 +51,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	return unlikely(overflow);
 }
 
-#ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
 /*
  * For simplicity and code hygiene, the fallback code below insists on
  * a, b and *d having the same type (similar to the min() and max()
@@ -90,134 +86,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	__builtin_mul_overflow(__a, __b, __d);	\
 }))
 
-#else
-
-
-/* Checking for unsigned overflow is relatively easy without causing UB. */
-#define __unsigned_add_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = __a + __b;			\
-	*__d < __a;				\
-})
-#define __unsigned_sub_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = __a - __b;			\
-	__a < __b;				\
-})
-/*
- * If one of a or b is a compile-time constant, this avoids a division.
- */
-#define __unsigned_mul_overflow(a, b, d) ({		\
-	typeof(a) __a = (a);				\
-	typeof(b) __b = (b);				\
-	typeof(d) __d = (d);				\
-	(void) (&__a == &__b);				\
-	(void) (&__a == __d);				\
-	*__d = __a * __b;				\
-	__builtin_constant_p(__b) ?			\
-	  __b > 0 && __a > type_max(typeof(__a)) / __b : \
-	  __a > 0 && __b > type_max(typeof(__b)) / __a;	 \
-})
-
-/*
- * For signed types, detecting overflow is much harder, especially if
- * we want to avoid UB. But the interface of these macros is such that
- * we must provide a result in *d, and in fact we must produce the
- * result promised by gcc's builtins, which is simply the possibly
- * wrapped-around value. Fortunately, we can just formally do the
- * operations in the widest relevant unsigned type (u64) and then
- * truncate the result - gcc is smart enough to generate the same code
- * with and without the (u64) casts.
- */
-
-/*
- * Adding two signed integers can overflow only if they have the same
- * sign, and overflow has happened iff the result has the opposite
- * sign.
- */
-#define __signed_add_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = (u64)__a + (u64)__b;		\
-	(((~(__a ^ __b)) & (*__d ^ __a))	\
-		& type_min(typeof(__a))) != 0;	\
-})
-
-/*
- * Subtraction is similar, except that overflow can now happen only
- * when the signs are opposite. In this case, overflow has happened if
- * the result has the opposite sign of a.
- */
-#define __signed_sub_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = (u64)__a - (u64)__b;		\
-	((((__a ^ __b)) & (*__d ^ __a))		\
-		& type_min(typeof(__a))) != 0;	\
-})
-
-/*
- * Signed multiplication is rather hard. gcc always follows C99, so
- * division is truncated towards 0. This means that we can write the
- * overflow check like this:
- *
- * (a > 0 && (b > MAX/a || b < MIN/a)) ||
- * (a < -1 && (b > MIN/a || b < MAX/a) ||
- * (a == -1 && b == MIN)
- *
- * The redundant casts of -1 are to silence an annoying -Wtype-limits
- * (included in -Wextra) warning: When the type is u8 or u16, the
- * __b_c_e in check_mul_overflow obviously selects
- * __unsigned_mul_overflow, but unfortunately gcc still parses this
- * code and warns about the limited range of __b.
- */
-
-#define __signed_mul_overflow(a, b, d) ({				\
-	typeof(a) __a = (a);						\
-	typeof(b) __b = (b);						\
-	typeof(d) __d = (d);						\
-	typeof(a) __tmax = type_max(typeof(a));				\
-	typeof(a) __tmin = type_min(typeof(a));				\
-	(void) (&__a == &__b);						\
-	(void) (&__a == __d);						\
-	*__d = (u64)__a * (u64)__b;					\
-	(__b > 0   && (__a > __tmax/__b || __a < __tmin/__b)) ||	\
-	(__b < (typeof(__b))-1  && (__a > __tmin/__b || __a < __tmax/__b)) || \
-	(__b == (typeof(__b))-1 && __a == __tmin);			\
-})
-
-
-#define check_add_overflow(a, b, d)	__must_check_overflow(		\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_add_overflow(a, b, d),			\
-			__unsigned_add_overflow(a, b, d)))
-
-#define check_sub_overflow(a, b, d)	__must_check_overflow(		\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_sub_overflow(a, b, d),			\
-			__unsigned_sub_overflow(a, b, d)))
-
-#define check_mul_overflow(a, b, d)	__must_check_overflow(		\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_mul_overflow(a, b, d),			\
-			__unsigned_mul_overflow(a, b, d)))
-
-#endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
-
 /** check_shl_overflow() - Calculate a left-shifted value and check overflow
  *
  * @a: Value to be shifted
diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index 95c072b70d0e..a590a1dfafd9 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -38,7 +38,3 @@
 #endif
 #define __printf(a, b)	__attribute__((format(printf, a, b)))
 #define __scanf(a, b)	__attribute__((format(scanf, a, b)))
-
-#if GCC_VERSION >= 50100
-#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
-#endif
diff --git a/tools/include/linux/overflow.h b/tools/include/linux/overflow.h
index 8712ff70995f..dcb0c1bf6866 100644
--- a/tools/include/linux/overflow.h
+++ b/tools/include/linux/overflow.h
@@ -5,12 +5,9 @@
 #include <linux/compiler.h>
 
 /*
- * In the fallback code below, we need to compute the minimum and
- * maximum values representable in a given type. These macros may also
- * be useful elsewhere, so we provide them outside the
- * COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW block.
- *
- * It would seem more obvious to do something like
+ * We need to compute the minimum and maximum values representable in a given
+ * type. These macros may also be useful elsewhere. It would seem more obvious
+ * to do something like:
  *
  * #define type_min(T) (T)(is_signed_type(T) ? (T)1 << (8*sizeof(T)-1) : 0)
  * #define type_max(T) (T)(is_signed_type(T) ? ((T)1 << (8*sizeof(T)-1)) - 1 : ~(T)0)
@@ -36,8 +33,6 @@
 #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
 #define type_min(T) ((T)((T)-type_max(T)-(T)1))
 
-
-#ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
 /*
  * For simplicity and code hygiene, the fallback code below insists on
  * a, b and *d having the same type (similar to the min() and max()
@@ -73,135 +68,6 @@
 	__builtin_mul_overflow(__a, __b, __d);	\
 })
 
-#else
-
-
-/* Checking for unsigned overflow is relatively easy without causing UB. */
-#define __unsigned_add_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = __a + __b;			\
-	*__d < __a;				\
-})
-#define __unsigned_sub_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = __a - __b;			\
-	__a < __b;				\
-})
-/*
- * If one of a or b is a compile-time constant, this avoids a division.
- */
-#define __unsigned_mul_overflow(a, b, d) ({		\
-	typeof(a) __a = (a);				\
-	typeof(b) __b = (b);				\
-	typeof(d) __d = (d);				\
-	(void) (&__a == &__b);				\
-	(void) (&__a == __d);				\
-	*__d = __a * __b;				\
-	__builtin_constant_p(__b) ?			\
-	  __b > 0 && __a > type_max(typeof(__a)) / __b : \
-	  __a > 0 && __b > type_max(typeof(__b)) / __a;	 \
-})
-
-/*
- * For signed types, detecting overflow is much harder, especially if
- * we want to avoid UB. But the interface of these macros is such that
- * we must provide a result in *d, and in fact we must produce the
- * result promised by gcc's builtins, which is simply the possibly
- * wrapped-around value. Fortunately, we can just formally do the
- * operations in the widest relevant unsigned type (u64) and then
- * truncate the result - gcc is smart enough to generate the same code
- * with and without the (u64) casts.
- */
-
-/*
- * Adding two signed integers can overflow only if they have the same
- * sign, and overflow has happened iff the result has the opposite
- * sign.
- */
-#define __signed_add_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = (u64)__a + (u64)__b;		\
-	(((~(__a ^ __b)) & (*__d ^ __a))	\
-		& type_min(typeof(__a))) != 0;	\
-})
-
-/*
- * Subtraction is similar, except that overflow can now happen only
- * when the signs are opposite. In this case, overflow has happened if
- * the result has the opposite sign of a.
- */
-#define __signed_sub_overflow(a, b, d) ({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	*__d = (u64)__a - (u64)__b;		\
-	((((__a ^ __b)) & (*__d ^ __a))		\
-		& type_min(typeof(__a))) != 0;	\
-})
-
-/*
- * Signed multiplication is rather hard. gcc always follows C99, so
- * division is truncated towards 0. This means that we can write the
- * overflow check like this:
- *
- * (a > 0 && (b > MAX/a || b < MIN/a)) ||
- * (a < -1 && (b > MIN/a || b < MAX/a) ||
- * (a == -1 && b == MIN)
- *
- * The redundant casts of -1 are to silence an annoying -Wtype-limits
- * (included in -Wextra) warning: When the type is u8 or u16, the
- * __b_c_e in check_mul_overflow obviously selects
- * __unsigned_mul_overflow, but unfortunately gcc still parses this
- * code and warns about the limited range of __b.
- */
-
-#define __signed_mul_overflow(a, b, d) ({				\
-	typeof(a) __a = (a);						\
-	typeof(b) __b = (b);						\
-	typeof(d) __d = (d);						\
-	typeof(a) __tmax = type_max(typeof(a));				\
-	typeof(a) __tmin = type_min(typeof(a));				\
-	(void) (&__a == &__b);						\
-	(void) (&__a == __d);						\
-	*__d = (u64)__a * (u64)__b;					\
-	(__b > 0   && (__a > __tmax/__b || __a < __tmin/__b)) ||	\
-	(__b < (typeof(__b))-1  && (__a > __tmin/__b || __a < __tmax/__b)) || \
-	(__b == (typeof(__b))-1 && __a == __tmin);			\
-})
-
-
-#define check_add_overflow(a, b, d)					\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_add_overflow(a, b, d),			\
-			__unsigned_add_overflow(a, b, d))
-
-#define check_sub_overflow(a, b, d)					\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_sub_overflow(a, b, d),			\
-			__unsigned_sub_overflow(a, b, d))
-
-#define check_mul_overflow(a, b, d)					\
-	__builtin_choose_expr(is_signed_type(typeof(a)),		\
-			__signed_mul_overflow(a, b, d),			\
-			__unsigned_mul_overflow(a, b, d))
-
-
-#endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
-
 /**
  * array_size() - Calculate size of 2-dimensional array.
  *
-- 
2.47.3


