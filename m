Return-Path: <stable+bounces-179359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B577CB54EA3
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 14:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3216BA1B71
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3A3093C1;
	Fri, 12 Sep 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kgH74Ygl"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3CB30BB8E;
	Fri, 12 Sep 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681805; cv=none; b=Lc6OmSIZTv+t7DOGQScz1COjFF/SvOblHVaHl2WhrAsQroWNs/0Rh7yMA8L+x0uh09DrjPxvImO1QYo34Y999l2ciRV/f9Hwy4Su6O635Y+eoYGtHrAsL6R0UsUrgzLclx8/8Fss0WE9nzgOQ9ZmaHLNgSEQMNdaVNgYWophFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681805; c=relaxed/simple;
	bh=swWGI/iuXB2HlicTToaLJr4iNqhhtriByzMmXD01l64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hF3G7oDlA6nzOE/zaQ0lFntLkVf034+65oPd+ZA5qHbajqL3Bbw5fxi7fGzeW9Slzo91mCxpTSEMZpmxdJEffvsarJBtIr/16b+UbgphaxrQY01zIjFfeObK9lyAqLBOTOSm2awSmFgx5RgxIDZkkw3uL1AOe7UlwQQmjrr0NPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kgH74Ygl; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757681803; x=1789217803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IOuNUQwEWj5FOGisnPn2jX9TlrGfSaKV6LuhB6AHF04=;
  b=kgH74Ygl9E/pIFrnjOysaWIxB70KCIlB0eD3UBeFcMC1SZjEJmnA+49M
   J93JASLL1t7oNd3fn2Hak6P1PabLHZRaeKsWTwiKhnowiI9TqVwIrNo2G
   jqNLWv16ueBMKPJp+yNSkFBy+jflZYUftJKC6X6l4rGw6tKEoGfYHLqhV
   iymrVUlqAWB7bx+TKViJravZ9oYAQ/2HIO9RTqJisStpMOfRcwl6/UNyK
   YLnRM89vQAvrcYdftHWkF7GngHDKyjRENdiTDS/wmxlNhaDZ0jWAOSYYI
   vZ73BgYaJkl5Kbg7aq5/IpKcgfXl16C3HFYZ99e76gRAC3R3c0DYgI1VL
   w==;
X-CSE-ConnectionGUID: t97anB6gQbqsNIchGGH2nA==
X-CSE-MsgGUID: lAvWwd9zQu+Mo/5eNRs77Q==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="1907717"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 12:56:32 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:25605]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.26:2525] with esmtp (Farcaster)
 id 61b18e6f-a9ba-4ce3-b2aa-3a942596cea7; Fri, 12 Sep 2025 12:56:32 +0000 (UTC)
X-Farcaster-Flow-ID: 61b18e6f-a9ba-4ce3-b2aa-3a942596cea7
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 12:56:32 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 12:56:25 +0000
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
Subject: [PATCH 2/4 5.10.y] compiler.h: drop fallback overflow checkers
Date: Fri, 12 Sep 2025 12:56:03 +0000
Message-ID: <20250912125606.13262-3-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912125606.13262-1-farbere@amazon.com>
References: <20250912125606.13262-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
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


