Return-Path: <stable+bounces-187653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBE7BEA86D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81F6A5A2FBC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA7289811;
	Fri, 17 Oct 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EsyamvxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDA1A9FB7;
	Fri, 17 Oct 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716693; cv=none; b=bLI2UwBJ+w9XD8xJkw52/800gZNVVbaLmzwawmZkrhP82qOXY+CQbZZ3nGALNfyd7Um2EqKiMotfSCulvVFFPo2Wv2RGC0D/ksJM+3+4KSwq+42qQlkJrGouIM1sSWGyHGK2I4NRtdpzqLUz3QgLej8JiQf1aVfHPwNjgPsOTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716693; c=relaxed/simple;
	bh=4OtdXOpSB5W1xXd2OCLFg7VdeV8SrNtuj2gcGGMHh0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbTxOA9osiW9E+4hVFDuw0ye32J/Xe8i/iBopi3EJmWaoyZ4z2W81AaS7IBRae/JEKCToaVx3JgMukHjSxHuKMkk4FcGs0fAue2xpD4lubHzo+bcaLMSoXguPCM5dX2J25PtnecLDWHdW/fP55/LPtczcN3C2DnDdxbLO1Xvz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EsyamvxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D993C4CEE7;
	Fri, 17 Oct 2025 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716693;
	bh=4OtdXOpSB5W1xXd2OCLFg7VdeV8SrNtuj2gcGGMHh0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsyamvxZl024f+jzv9xqGnd3vSYRdfE6vbBw6Z1J/Vz8MOPeStpccSrIbrP3qjukc
	 kyz0We7gc8iz1mczg2dUwednt6zxSwJ6dsdzDiyOAts7JCOvw6ug94cixKHR6RjBWg
	 jOC8qsYbHi9/OAEyeGdFaJfOTm1aABHIi2nRAiU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Laight <david.laight@aculab.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eliav Farber <farbere@amazon.com>
Subject: [PATCH 5.15 253/276] minmax.h: add whitespace around operators and after commas
Date: Fri, 17 Oct 2025 16:55:46 +0200
Message-ID: <20251017145151.715497993@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit 71ee9b16251ea4bf7c1fe222517c82bdb3220acc ]

Patch series "minmax.h: Cleanups and minor optimisations".

Some tidyups and minor changes to minmax.h.

This patch (of 7):

Link: https://lkml.kernel.org/r/c50365d214e04f9ba256d417c8bebbc0@AcuMS.aculab.com
Link: https://lkml.kernel.org/r/f04b2e1310244f62826267346fde0553@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/minmax.h |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -51,10 +51,10 @@
  * only need to be careful to not cause warnings for
  * pointer use.
  */
-#define __signed_type_use(x,ux) (2+__is_nonneg(x,ux))
-#define __unsigned_type_use(x,ux) (1+2*(sizeof(ux)<4))
-#define __sign_use(x,ux) (is_signed_type(typeof(ux))? \
-	__signed_type_use(x,ux):__unsigned_type_use(x,ux))
+#define __signed_type_use(x, ux) (2 + __is_nonneg(x, ux))
+#define __unsigned_type_use(x, ux) (1 + 2 * (sizeof(ux) < 4))
+#define __sign_use(x, ux) (is_signed_type(typeof(ux)) ? \
+	__signed_type_use(x, ux) : __unsigned_type_use(x, ux))
 
 /*
  * To avoid warnings about casting pointers to integers
@@ -74,15 +74,15 @@
 #ifdef CONFIG_64BIT
   #define __signed_type(ux) long
 #else
-  #define __signed_type(ux) typeof(__builtin_choose_expr(sizeof(ux)>4,1LL,1L))
+  #define __signed_type(ux) typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL, 1L))
 #endif
-#define __is_nonneg(x,ux) statically_true((__signed_type(ux))(x)>=0)
+#define __is_nonneg(x, ux) statically_true((__signed_type(ux))(x) >= 0)
 
-#define __types_ok(x,y,ux,uy) \
-	(__sign_use(x,ux) & __sign_use(y,uy))
+#define __types_ok(x, y, ux, uy) \
+	(__sign_use(x, ux) & __sign_use(y, uy))
 
-#define __types_ok3(x,y,z,ux,uy,uz) \
-	(__sign_use(x,ux) & __sign_use(y,uy) & __sign_use(z,uz))
+#define __types_ok3(x, y, z, ux, uy, uz) \
+	(__sign_use(x, ux) & __sign_use(y, uy) & __sign_use(z, uz))
 
 #define __cmp_op_min <
 #define __cmp_op_max >
@@ -97,7 +97,7 @@
 
 #define __careful_cmp_once(op, x, y, ux, uy) ({		\
 	__auto_type ux = (x); __auto_type uy = (y);	\
-	BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),	\
+	BUILD_BUG_ON_MSG(!__types_ok(x, y, ux, uy),	\
 		#op"("#x", "#y") signedness error");	\
 	__cmp(op, ux, uy); })
 
@@ -114,7 +114,7 @@
 	static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
 			(lo) <= (hi), true),					\
 		"clamp() low limit " #lo " greater than high limit " #hi);	\
-	BUILD_BUG_ON_MSG(!__types_ok3(val,lo,hi,uval,ulo,uhi),			\
+	BUILD_BUG_ON_MSG(!__types_ok3(val, lo, hi, uval, ulo, uhi),		\
 		"clamp("#val", "#lo", "#hi") signedness error");		\
 	__clamp(uval, ulo, uhi); })
 
@@ -154,7 +154,7 @@
 
 #define __careful_op3(op, x, y, z, ux, uy, uz) ({			\
 	__auto_type ux = (x); __auto_type uy = (y);__auto_type uz = (z);\
-	BUILD_BUG_ON_MSG(!__types_ok3(x,y,z,ux,uy,uz),			\
+	BUILD_BUG_ON_MSG(!__types_ok3(x, y, z, ux, uy, uz),		\
 		#op"3("#x", "#y", "#z") signedness error");		\
 	__cmp(op, ux, __cmp(op, uy, uz)); })
 
@@ -326,9 +326,9 @@ static inline bool in_range32(u32 val, u
  * Use these carefully: no type checking, and uses the arguments
  * multiple times. Use for obvious constants only.
  */
-#define MIN(a,b) __cmp(min,a,b)
-#define MAX(a,b) __cmp(max,a,b)
-#define MIN_T(type,a,b) __cmp(min,(type)(a),(type)(b))
-#define MAX_T(type,a,b) __cmp(max,(type)(a),(type)(b))
+#define MIN(a, b) __cmp(min, a, b)
+#define MAX(a, b) __cmp(max, a, b)
+#define MIN_T(type, a, b) __cmp(min, (type)(a), (type)(b))
+#define MAX_T(type, a, b) __cmp(max, (type)(a), (type)(b))
 
 #endif	/* _LINUX_MINMAX_H */



