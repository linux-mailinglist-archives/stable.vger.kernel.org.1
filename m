Return-Path: <stable+bounces-179380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC0DB553A8
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA88BA35B2
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70602312817;
	Fri, 12 Sep 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z7hdhhrm"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A3317708;
	Fri, 12 Sep 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691086; cv=none; b=YVA6seFQvLkpBQMaMZT6eBpMiOpW7guRWSVT4cNQTNFXlQJ6HaYcfAjM1Iyuqk5IejEJ7aujO1F/DFIuXtCUgs/LsOHk/G7/uduNK7cpEeb5VvaJBkOR0pxJsJyNWqkwTyVmkR9baLjm6No00zbdtOFuUjszFdLTYzoQ3PqWpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691086; c=relaxed/simple;
	bh=0ZAuq1AeP2txNQ7DcSKMbLVlk6LKgVQRz0GMnBaYbvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJRDqjrH10xN3yW49tqRCvIYmSbc65xy8wYx6qmSqBo2UARhEIDiB3J/1BJAf1OA5CBGaeErDHhived21GDsYK2aD4KfjxdxkaMzEhxTwulKEIZYTc88eQD8dngcH3csxtBjrHRlJeY2i4aPukwT5KOcCQEAhW/3CP6vY9N40bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z7hdhhrm; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757691084; x=1789227084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mNZQBQctKZfrpwn21cF3GKidAAjq4amyeXpqNxgoRJI=;
  b=Z7hdhhrm5eB78M+9Fto5jg35y35OUyluwb1tX6tSEnHTZpVd66sOndAK
   Confvzb95hQUth316ldM75XMVj2uoHcU0zvkwg6cl44DFP802pQ5q4Ome
   Qage0YLFpVKubhZQlPsy6LPqNnGAgZ+TYNAlYucnS+5p+nZh3lD9Oegnk
   LRMX6lM98ie0gpY8kj0hKlsfWxthaDC8g63xnsFRHsDokq18ennd7iG92
   DKEVTQCOjbxIuo2Y9LBxgiihPCs9Dk1rTQLVy0ExuB4L7Dclq+Qo/ehpO
   3mP+ynwaokVq7x6/yrE4NXkkC8Fn3PJItT66xR+QhjsQKG11JPjI+Znuh
   w==;
X-CSE-ConnectionGUID: 7HJlotdaQDe9hzRxj9Xhgg==
X-CSE-MsgGUID: vzmFUeFfTLq6JhAyVvL6eQ==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="1926629"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:31:13 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:20571]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.20.211:2525] with esmtp (Farcaster)
 id 90cf4a3a-92b1-40c8-8a77-c06977ed7ddd; Fri, 12 Sep 2025 15:31:13 +0000 (UTC)
X-Farcaster-Flow-ID: 90cf4a3a-92b1-40c8-8a77-c06977ed7ddd
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 15:31:13 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 15:31:05 +0000
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
	<linux@rasmusvillemoes.dk>, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH v2 3/4 5.10.y] overflow: Allow mixed type arguments
Date: Fri, 12 Sep 2025 15:30:37 +0000
Message-ID: <20250912153040.26691-4-farbere@amazon.com>
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

From: Kees Cook <keescook@chromium.org>

commit d219d2a9a92e39aa92799efe8f2aa21259b6dd82 upstream.

When the check_[op]_overflow() helpers were introduced, all arguments
were required to be the same type to make the fallback macros simpler.
However, now that the fallback macros have been removed[1], it is fine
to allow mixed types, which makes using the helpers much more useful,
as they can be used to test for type-based overflows (e.g. adding two
large ints but storing into a u8), as would be handy in the drm core[2].

Remove the restriction, and add additional self-tests that exercise
some of the mixed-type overflow cases, and double-check for accidental
macro side-effects.

[1] https://git.kernel.org/linus/4eb6bd55cfb22ffc20652732340c4962f3ac9a91
[2] https://lore.kernel.org/lkml/20220824084514.2261614-2-gwan-gyeong.mun@intel.com

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-hardening@vger.kernel.org
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Tested-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
[ dropped the test portion of the commit as that doesn't apply to
  5.15.y - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/overflow.h | 72 +++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 59d7228104d0..73bc67ec2136 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -51,40 +51,50 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	return unlikely(overflow);
 }
 
-/*
- * For simplicity and code hygiene, the fallback code below insists on
- * a, b and *d having the same type (similar to the min() and max()
- * macros), whereas gcc's type-generic overflow checkers accept
- * different types. Hence we don't just make check_add_overflow an
- * alias for __builtin_add_overflow, but add type checks similar to
- * below.
+/** check_add_overflow() - Calculate addition with overflow checking
+ *
+ * @a: first addend
+ * @b: second addend
+ * @d: pointer to store sum
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted addition, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * sum has overflowed or been truncated.
  */
-#define check_add_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_add_overflow(__a, __b, __d);	\
-}))
+#define check_add_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
-#define check_sub_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_sub_overflow(__a, __b, __d);	\
-}))
+/** check_sub_overflow() - Calculate subtraction with overflow checking
+ *
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ * @d: pointer to store difference
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted subtraction, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * difference has underflowed or been truncated.
+ */
+#define check_sub_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
-#define check_mul_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_mul_overflow(__a, __b, __d);	\
-}))
+/** check_mul_overflow() - Calculate multiplication with overflow checking
+ *
+ * @a: first factor
+ * @b: second factor
+ * @d: pointer to store product
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted multiplication, but is not
+ * considered "safe for use" on a non-zero return value, which indicates
+ * that the product has overflowed or been truncated.
+ */
+#define check_mul_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
 /** check_shl_overflow() - Calculate a left-shifted value and check overflow
  *
-- 
2.47.3


