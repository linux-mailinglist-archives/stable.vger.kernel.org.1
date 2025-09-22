Return-Path: <stable+bounces-180918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85AEB9002D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 12:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898634227B1
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431412FFDD8;
	Mon, 22 Sep 2025 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="s+6V9NXP"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F42FDC25;
	Mon, 22 Sep 2025 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537120; cv=none; b=GeisqQwqeG8CjD+jKL5Ph8CeiC2yGg/EwEMzTZYZPz/gcMw08pgzH7DMAcZwvWIArbaAKm3czN0TvAEORKE81ac1cHAZmVuRAsJYlXJVAYknwHHbCNl9vyKiQuNQ5bdGjcCy15vDARFZSBnFJRj1yUnLjWKehkn3Wqnx8Mprvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537120; c=relaxed/simple;
	bh=18hVRcjiq6jqKyPc+H8fDwSKZo20vfz8WvHD3u05Y74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtAijdI4FzTgzJj/05lCvfda83Lgiji2Ihq/KHI6S7iYX6+ZqaI/GKXMIXz6dPZXXfz5PPrIAD+6LLRM7mNxnvia/2wirBdVcEecoKd3G5wOdIH56rTmhVAVMiFI/NuwHqQ5NY7oclScscZInSn0ckfEqe7tQEDQXE+V324CDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=s+6V9NXP; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758537118; x=1790073118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FhepguEQ0VZAS3etCeAAj5D/xXUqupnQ1wf0VPifqWY=;
  b=s+6V9NXP3SnMuLS5v2EWsYqukrFh9yW0qLEeo6iaUXEcFZwJlZR4emxA
   RxU9j5b1qQXLuL9svE17jmk51hTcf62xwZMQiKeqY6005QdogckuNfw6K
   LKfVV2pA41PVH0XPFetifj8ssEUngaOLLHcYxP8VpJ27RYtIfIn+zWTrY
   vjpuZJe3SDbjL9OAOuIRFbHt1FfqZvQ/hGTL4HaqERJVUbI6QRIZ8h1F9
   a8lIt27qEcCeK19XtZHxrNrN/T3u9zzFFenln9RH36PPt1gvI/mow6alg
   HTQd8G7r6AvkdU9PP2NdsxMqDOWKGuZpfRDDwv5VtwhmBhbte2geoyvry
   g==;
X-CSE-ConnectionGUID: BU54+gz8R4qoBeASiy7j0Q==
X-CSE-MsgGUID: Y7Jp5SVGRqGrlUMhaZVZgg==
X-IronPort-AV: E=Sophos;i="6.18,284,1751241600"; 
   d="scan'208";a="2372067"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 10:31:47 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:1247]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.21.238:2525] with esmtp (Farcaster)
 id f77a31b1-2b16-4e2b-94b2-939375090f63; Mon, 22 Sep 2025 10:31:47 +0000 (UTC)
X-Farcaster-Flow-ID: f77a31b1-2b16-4e2b-94b2-939375090f63
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 10:31:46 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 22 Sep 2025
 10:31:42 +0000
From: Eliav Farber <farbere@amazon.com>
To: <farbere@amazon.com>, <akpm@linux-foundation.org>,
	<David.Laight@ACULAB.COM>, <arnd@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig
	<hch@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Jens Axboe <axboe@kernel.dk>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, "Matthew
 Wilcox" <willy@infradead.org>, Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH 3/7 6.12.y] minmax.h: reduce the #define expansion of min(), max() and clamp()
Date: Mon, 22 Sep 2025 10:31:19 +0000
Message-ID: <20250922103123.14538-4-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922103123.14538-1-farbere@amazon.com>
References: <20250922103123.14538-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit b280bb27a9f7c91ddab730e1ad91a9c18a051f41 ]

Since the test for signed values being non-negative only relies on
__builtion_constant_p() (not is_constexpr()) it can use the 'ux' variable
instead of the caller supplied expression.  This means that the #define
parameters are only expanded twice.  Once in the code and once quoted in
the error message.

Link: https://lkml.kernel.org/r/051afc171806425da991908ed8688a98@AcuMS.aculab.com
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
---
 include/linux/minmax.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 24e4b372649a..6f7ea669d305 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -46,10 +46,10 @@
  * comparison, and these expressions only need to be careful to not cause
  * warnings for pointer use.
  */
-#define __signed_type_use(x, ux) (2 + __is_nonneg(x, ux))
-#define __unsigned_type_use(x, ux) (1 + 2 * (sizeof(ux) < 4))
-#define __sign_use(x, ux) (is_signed_type(typeof(ux)) ? \
-	__signed_type_use(x, ux) : __unsigned_type_use(x, ux))
+#define __signed_type_use(ux) (2 + __is_nonneg(ux))
+#define __unsigned_type_use(ux) (1 + 2 * (sizeof(ux) < 4))
+#define __sign_use(ux) (is_signed_type(typeof(ux)) ? \
+	__signed_type_use(ux) : __unsigned_type_use(ux))
 
 /*
  * Check whether a signed value is always non-negative.
@@ -71,13 +71,13 @@
 #else
   #define __signed_type(ux) typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL, 1L))
 #endif
-#define __is_nonneg(x, ux) statically_true((__signed_type(ux))(x) >= 0)
+#define __is_nonneg(ux) statically_true((__signed_type(ux))(ux) >= 0)
 
-#define __types_ok(x, y, ux, uy) \
-	(__sign_use(x, ux) & __sign_use(y, uy))
+#define __types_ok(ux, uy) \
+	(__sign_use(ux) & __sign_use(uy))
 
-#define __types_ok3(x, y, z, ux, uy, uz) \
-	(__sign_use(x, ux) & __sign_use(y, uy) & __sign_use(z, uz))
+#define __types_ok3(ux, uy, uz) \
+	(__sign_use(ux) & __sign_use(uy) & __sign_use(uz))
 
 #define __cmp_op_min <
 #define __cmp_op_max >
@@ -92,7 +92,7 @@
 
 #define __careful_cmp_once(op, x, y, ux, uy) ({		\
 	__auto_type ux = (x); __auto_type uy = (y);	\
-	BUILD_BUG_ON_MSG(!__types_ok(x, y, ux, uy),	\
+	BUILD_BUG_ON_MSG(!__types_ok(ux, uy),		\
 		#op"("#x", "#y") signedness error");	\
 	__cmp(op, ux, uy); })
 
@@ -109,7 +109,7 @@
 	static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
 			(lo) <= (hi), true),					\
 		"clamp() low limit " #lo " greater than high limit " #hi);	\
-	BUILD_BUG_ON_MSG(!__types_ok3(val, lo, hi, uval, ulo, uhi),		\
+	BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),				\
 		"clamp("#val", "#lo", "#hi") signedness error");		\
 	__clamp(uval, ulo, uhi); })
 
@@ -149,7 +149,7 @@
 
 #define __careful_op3(op, x, y, z, ux, uy, uz) ({			\
 	__auto_type ux = (x); __auto_type uy = (y);__auto_type uz = (z);\
-	BUILD_BUG_ON_MSG(!__types_ok3(x, y, z, ux, uy, uz),		\
+	BUILD_BUG_ON_MSG(!__types_ok3(ux, uy, uz),			\
 		#op"3("#x", "#y", "#z") signedness error");		\
 	__cmp(op, ux, __cmp(op, uy, uz)); })
 
-- 
2.47.3


