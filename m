Return-Path: <stable+bounces-60313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ED3933038
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D2F1C22299
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6311A651F;
	Tue, 16 Jul 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsrniOlO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDB1A2553;
	Tue, 16 Jul 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154826; cv=none; b=Q8cLhgn+cbBYivTRSfqj8A0seC5UZKWMfNlyuDhhhdzuV4knZR4U1cL0CRs6fP+fWECai11Jv9V1UCi5/VLHURSfVaGkfIO3nV02IhU1kqupV7i4zXwikBkpSa0RvyHRh780+i3T+zRfjsUrCDKqYb9b8zaEUsXSdk+hT62txFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154826; c=relaxed/simple;
	bh=ndvNxnnobdXY1qRGFjwKkxZc5JAWm9Mq+lzm6iZ2oDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6uaVHVqpsRfVZWxzPcJ9cWiv7YuDBXdclsm/QPZixvM/bXuXdwYPjFD4xkNrZQP1mYP3AXcq7fR8/p60tYM6dKt0jXziuOvuNj4wV1OLEw+vaCtYEM+MhtS4E47/y7I4P4FmH3g7yrH5SF2nXFJ7XXuHEcgwJ2uLaYGXs9aRkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsrniOlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9198C4AF0D;
	Tue, 16 Jul 2024 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154825;
	bh=ndvNxnnobdXY1qRGFjwKkxZc5JAWm9Mq+lzm6iZ2oDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsrniOlOCA9NbqSZROhsTDlJdmUSh/BIZPZSXpXBQ5Kz0mQHgIaawfAfa05qS7c7Z
	 Nt517df9+ryBl4iNVvRHO0QYiHqNe+f2+PE1Y+cT06qDHrkbbJ6KHOMaZ8ZlcO7uBL
	 Khgw3NMxO2iJoplVwD2WmD+mtCc/ZQp5lIQa17/0f8D4VcOdhAxbfiojHSPVSzgD79
	 o8wwBgfor7wEvlp+fS96m/lE/l3Eo+M/W1el70kLQ/yex2Nae/moHQ2cKyM+Ef27km
	 32YbxdsRMNi1/FQ8WHzMyUJxWaXDPW/6BmpEzEBygVxVyjWM9cy0WJFPxNgQt1hs8r
	 d5LKPgNkl/6ww==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: David Laight <David.Laight@ACULAB.COM>,
	linux-kernel@vger.kernel.org,
	David Laight <david.laight@aculab.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 5.15.y 7/8] minmax: relax check to allow comparison between unsigned arguments and signed constants
Date: Tue, 16 Jul 2024 11:33:32 -0700
Message-Id: <20240716183333.138498-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716183333.138498-1-sj@kernel.org>
References: <20240716183333.138498-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.39.2


