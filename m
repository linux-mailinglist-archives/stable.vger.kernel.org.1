Return-Path: <stable+bounces-179759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA64B5A407
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 23:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D861C01879
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 21:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A8287515;
	Tue, 16 Sep 2025 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EAxXTn6h"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E431BCA4;
	Tue, 16 Sep 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058347; cv=none; b=iY3OvjGnbWKuTIP5c0An9sFaAx0+SOyBKjCcqPe/zw04TkET3JrY1rBEBqD/ojLW3HHfnvIN52JFakfKVOn1icmVx4HrEeb6zhM2QFuJU6tfhtyge/Aa13+T/c8dzPJTyoygV+6Zf0b4WRgrYXF4PFh1wSQoG9ckACpdzANUgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058347; c=relaxed/simple;
	bh=xCYkeH4QYr4X+Yb4JUrvhynQnySKOolUu9xUmaQc9tY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aLKERRqZsPYFhMhF9xKmxJ+ZOj8pplCj/UZoQhKrYCu61sFeSOOQwgZM8GJkB0DyoOFRx0uoyG812LSYH4/emx0vnsyR+oC2t+XXaonACGgJ9cY+abe7yZ6GVZJb/0jeeGFzUhGOC5E+MzWKneun65fCMG1KfbpuFDv5FgyZtd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EAxXTn6h; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758058345; x=1789594345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QLnkLMqtlLfDtwSeYQL7WGkG6mzWc6R9ymixNvsiunA=;
  b=EAxXTn6hyN/EtOkddESurYPuIvPNJQcYTNystkxFKa5UNK/nK1bheLaK
   3OVteONaTOHTDfysdWFZjz2hYQv3Dqcvj0+2/IyE009WR0/dJ18OYP4Ds
   USNkgnD7Ahcrc0VrXaHwiRQIEUTXpci65l8m6sLMZMYhc2OidCO+i0oRF
   tMLouZ9wAC/FXT+kOtV5H5idrb8UHJ7V31u4R41DjIm8l4WjxwnOpoCVV
   MpMU3fIW/l/bPPjtQe+ENOohJf0IRP65eZCS66upUCeHKA1vUKdtSxU4G
   5fYQkMm+Q9EHXqJpoh7eqmIYifreEmL2u542YVdhv7Wptejf9FqXLcdWV
   g==;
X-CSE-ConnectionGUID: +1KHj2xgR/eqU/BdJydXew==
X-CSE-MsgGUID: GCB106dVQFq8EOYtO3oG0Q==
X-IronPort-AV: E=Sophos;i="6.18,270,1751241600"; 
   d="scan'208";a="2215156"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 21:32:23 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:4626]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.21.26:2525] with esmtp (Farcaster)
 id f4cef716-ed49-4dbd-844b-4631a4751e69; Tue, 16 Sep 2025 21:32:23 +0000 (UTC)
X-Farcaster-Flow-ID: f4cef716-ed49-4dbd-844b-4631a4751e69
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 21:32:22 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 16 Sep 2025
 21:32:17 +0000
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
Subject: [PATCH 7/7 5.10.y] minmax: relax check to allow comparison between unsigned arguments and signed constants
Date: Tue, 16 Sep 2025 21:32:11 +0000
Message-ID: <20250916213211.10519-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: David Laight <David.Laight@ACULAB.COM>

commit 867046cc7027703f60a46339ffde91a1970f2901 upstream.

Allow (for example) min(unsigned_var, 20).

The opposite min(signed_var, 20u) is still errored.

Since a comparison between signed and unsigned never makes the unsigned
value negative it is only necessary to adjust the __types_ok() test.

Link: https://lkml.kernel.org/r/633b64e2f39e46bb8234809c5595b8c7@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 867046cc7027703f60a46339ffde91a1970f2901)
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/minmax.h | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index f76b7145fc11..dd52969698f7 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -9,13 +9,18 @@
 /*
  * min()/max()/clamp() macros must accomplish three things:
  *
- * - avoid multiple evaluations of the arguments (so side-effects like
+ * - Avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - perform signed v unsigned type-checking (to generate compile
- *   errors instead of nasty runtime surprises).
- * - retain result as a constant expressions when called with only
+ * - Retain result as a constant expressions when called with only
  *   constant expressions (to avoid tripping VLA warnings in stack
  *   allocation usage).
+ * - Perform signed v unsigned type-checking (to generate compile
+ *   errors instead of nasty runtime surprises).
+ * - Unsigned char/short are always promoted to signed int and can be
+ *   compared against signed or unsigned arguments.
+ * - Unsigned arguments can be compared against non-negative signed constants.
+ * - Comparison of a signed argument against an unsigned constant fails
+ *   even if the constant is below __INT_MAX__ and could be cast to int.
  */
 #define __typecheck(x, y) \
 	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
@@ -25,9 +30,14 @@
 	__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),	\
 		is_signed_type(typeof(x)), 0)
 
-#define __types_ok(x, y) 			\
-	(__is_signed(x) == __is_signed(y) ||	\
-		__is_signed((x) + 0) == __is_signed((y) + 0))
+/* True for a non-negative signed int constant */
+#define __is_noneg_int(x)	\
+	(__builtin_choose_expr(__is_constexpr(x) && __is_signed(x), x, -1) >= 0)
+
+#define __types_ok(x, y) 					\
+	(__is_signed(x) == __is_signed(y) ||			\
+		__is_signed((x) + 0) == __is_signed((y) + 0) ||	\
+		__is_noneg_int(x) || __is_noneg_int(y))
 
 #define __cmp_op_min <
 #define __cmp_op_max >
-- 
2.47.3


