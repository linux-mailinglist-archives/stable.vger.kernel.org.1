Return-Path: <stable+bounces-179757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35FCB5A400
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 23:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73953327236
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 21:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4CF221FD2;
	Tue, 16 Sep 2025 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rcHTEiml"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB231BCA4;
	Tue, 16 Sep 2025 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058313; cv=none; b=lizwwOV+68bQuNm75lVIW7Bl8+kWzBbsPb3xqUzV3KHqh79i0sCcQOLm1QWCRy3AvLGV+zD8f34lKqik1pQze3ilAEllgPB6AY/GsDA3krmGisifEZ0MRKTDmyIyyDHFUUsz/VBURQoAyWze1wk1y4aC9jNmsV53AXByNAMoB90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058313; c=relaxed/simple;
	bh=tPSnCIJ2fjfvyUqz1Sz7AtvwoH0aRAKH0F+xy1WtxRg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sDbEKj7J2LRzkPgZvxrE3ggT4d3X8BL5W+KBRbq57rMoYVNHChrghMnG3a7MjihDX1u430PhZ1Aq5Um+AxvLPQn1g6E4E173r23SWL1lEVs9RPSSolYJdMYHe2CJuoMIpjcJRcVvB28NqP8lhgEimvCfdbz6Us/gMBTUl2gUwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rcHTEiml; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758058311; x=1789594311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ilQ/73+qBfqOHe+b+q+TP6map5E/gKjcyIq4SalEjEc=;
  b=rcHTEiml9YOpTdgXOI8QSVZE3QA6KQwyAyiTCUG51FMZb4auPeIcxm0A
   nw+rz5iT4zfOBfuQYjiH6hXnuKtDYZAsyC6fcv+7CZBiv5vSNE9dN49wf
   rCBWDoNDvPbOKasqOiz/gBRipvyvUElSJU4qeHiwLkaSOo1lalUsJ7zjl
   MklsVG27gEPTWm7E5fjpnzgTecIB85gDBuR9j2Ohx42VOHEm8Ngz5jHC8
   3o/brV3FPNiVunxncIjYIKop7KaGq4AjNyGhxacfPzStYgsuIlu+0rJ0D
   mdzwF48qKhX1i61hofBYy9u3RlXvVdHPa4CLlN+UPCBrzooQ3ApXVGLP0
   A==;
X-CSE-ConnectionGUID: pfmAMyMnTturDRrqzkmVLw==
X-CSE-MsgGUID: NJ/yPmNES6aIScBUv8DgPQ==
X-IronPort-AV: E=Sophos;i="6.18,270,1751241600"; 
   d="scan'208";a="2099145"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 21:31:40 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:2298]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.3:2525] with esmtp (Farcaster)
 id 55ff7b84-21b9-4458-87e5-c739e8f7df6b; Tue, 16 Sep 2025 21:31:40 +0000 (UTC)
X-Farcaster-Flow-ID: 55ff7b84-21b9-4458-87e5-c739e8f7df6b
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 21:31:37 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 16 Sep 2025
 21:31:31 +0000
From: Eliav Farber <farbere@amazon.com>
To: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mingo@redhat.com>,
	<akpm@linux-foundation.org>, <gregkh@linuxfoundation.org>, <sj@kernel.org>,
	<David.Laight@ACULAB.COM>, <Jason@zx2c4.com>,
	<andriy.shevchenko@linux.intel.com>, <bvanassche@acm.org>,
	<keescook@chromium.org>, <linux-sparse@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jonnyc@amazon.com>, <farbere@amazon.com>, <stable@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>
Subject: [PATCH 5/7 5.10.y] minmax: allow min()/max()/clamp() if the arguments have the same signedness.
Date: Tue, 16 Sep 2025 21:31:25 +0000
Message-ID: <20250916213125.8952-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: David Laight <David.Laight@ACULAB.COM>

commit d03eba99f5bf7cbc6e2fdde3b6fa36954ad58e09 upstream.

The type-check in min()/max() is there to stop unexpected results if a
negative value gets converted to a large unsigned value.  However it also
rejects 'unsigned int' v 'unsigned long' compares which are common and
never problematc.

Replace the 'same type' check with a 'same signedness' check.

The new test isn't itself a compile time error, so use static_assert() to
report the error and give a meaningful error message.

Due to the way builtin_choose_expr() works detecting the error in the
'non-constant' side (where static_assert() can be used) also detects
errors when the arguments are constant.

Link: https://lkml.kernel.org/r/fe7e6c542e094bfca655abcd323c1c98@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit d03eba99f5bf7cbc6e2fdde3b6fa36954ad58e09)
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/minmax.h | 60 ++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index e8e9642809e0..501fab582d68 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -11,9 +11,8 @@
  *
  * - avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - perform strict type-checking (to generate warnings instead of
- *   nasty runtime surprises). See the "unnecessary" pointer comparison
- *   in __typecheck().
+ * - perform signed v unsigned type-checking (to generate compile
+ *   errors instead of nasty runtime surprises).
  * - retain result as a constant expressions when called with only
  *   constant expressions (to avoid tripping VLA warnings in stack
  *   allocation usage).
@@ -21,23 +20,30 @@
 #define __typecheck(x, y) \
 	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
 
-#define __no_side_effects(x, y) \
-		(__is_constexpr(x) && __is_constexpr(y))
+/* is_signed_type() isn't a constexpr for pointer types */
+#define __is_signed(x) 								\
+	__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),	\
+		is_signed_type(typeof(x)), 0)
 
-#define __safe_cmp(x, y) \
-		(__typecheck(x, y) && __no_side_effects(x, y))
+#define __types_ok(x, y) \
+	(__is_signed(x) == __is_signed(y))
 
-#define __cmp(x, y, op)	((x) op (y) ? (x) : (y))
+#define __cmp_op_min <
+#define __cmp_op_max >
 
-#define __cmp_once(x, y, unique_x, unique_y, op) ({	\
+#define __cmp(op, x, y)	((x) __cmp_op_##op (y) ? (x) : (y))
+
+#define __cmp_once(op, x, y, unique_x, unique_y) ({	\
 		typeof(x) unique_x = (x);		\
 		typeof(y) unique_y = (y);		\
-		__cmp(unique_x, unique_y, op); })
+		static_assert(__types_ok(x, y),		\
+			#op "(" #x ", " #y ") signedness error, fix types or consider u" #op "() before " #op "_t()"); \
+		__cmp(op, unique_x, unique_y); })
 
-#define __careful_cmp(x, y, op) \
-	__builtin_choose_expr(__safe_cmp(x, y), \
-		__cmp(x, y, op), \
-		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
+#define __careful_cmp(op, x, y)					\
+	__builtin_choose_expr(__is_constexpr((x) - (y)),	\
+		__cmp(op, x, y),				\
+		__cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
 
 #define __clamp(val, lo, hi)	\
 	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
@@ -46,17 +52,15 @@
 		typeof(val) unique_val = (val);				\
 		typeof(lo) unique_lo = (lo);				\
 		typeof(hi) unique_hi = (hi);				\
+		static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
+				(lo) <= (hi), true),					\
+			"clamp() low limit " #lo " greater than high limit " #hi);	\
+		static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");	\
+		static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");	\
 		__clamp(unique_val, unique_lo, unique_hi); })
 
-#define __clamp_input_check(lo, hi)					\
-        (BUILD_BUG_ON_ZERO(__builtin_choose_expr(			\
-                __is_constexpr((lo) > (hi)), (lo) > (hi), false)))
-
 #define __careful_clamp(val, lo, hi) ({					\
-	__clamp_input_check(lo, hi) +					\
-	__builtin_choose_expr(__typecheck(val, lo) && __typecheck(val, hi) && \
-			      __typecheck(hi, lo) && __is_constexpr(val) && \
-			      __is_constexpr(lo) && __is_constexpr(hi),	\
+	__builtin_choose_expr(__is_constexpr((val) - (lo) + (hi)),	\
 		__clamp(val, lo, hi),					\
 		__clamp_once(val, lo, hi, __UNIQUE_ID(__val),		\
 			     __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
@@ -66,14 +70,14 @@
  * @x: first value
  * @y: second value
  */
-#define min(x, y)	__careful_cmp(x, y, <)
+#define min(x, y)	__careful_cmp(min, x, y)
 
 /**
  * max - return maximum of two values of the same or compatible types
  * @x: first value
  * @y: second value
  */
-#define max(x, y)	__careful_cmp(x, y, >)
+#define max(x, y)	__careful_cmp(max, x, y)
 
 /**
  * umin - return minimum of two non-negative values
@@ -82,7 +86,7 @@
  * @y: second value
  */
 #define umin(x, y)	\
-	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
+	__careful_cmp(min, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
 
 /**
  * umax - return maximum of two non-negative values
@@ -90,7 +94,7 @@
  * @y: second value
  */
 #define umax(x, y)	\
-	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, >)
+	__careful_cmp(max, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
 
 /**
  * min3 - return minimum of three values
@@ -142,7 +146,7 @@
  * @x: first value
  * @y: second value
  */
-#define min_t(type, x, y)	__careful_cmp((type)(x), (type)(y), <)
+#define min_t(type, x, y)	__careful_cmp(min, (type)(x), (type)(y))
 
 /**
  * max_t - return maximum of two values, using the specified type
@@ -150,7 +154,7 @@
  * @x: first value
  * @y: second value
  */
-#define max_t(type, x, y)	__careful_cmp((type)(x), (type)(y), >)
+#define max_t(type, x, y)	__careful_cmp(max, (type)(x), (type)(y))
 
 /**
  * clamp_t - return a value clamped to a given range using a given type
-- 
2.47.3


