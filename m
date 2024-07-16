Return-Path: <stable+bounces-60284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CCD932F76
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC2C1C225A7
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E78D1A0B0E;
	Tue, 16 Jul 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur+K61lD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D111A0AFC;
	Tue, 16 Jul 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152341; cv=none; b=de8bqREW+4oFNXDLhm+1nex4+a9NtYsI2rL4rSqfqhTVHfziBkMCaGoQrJG6YtaO5NJlOAuQlZm7F2diBtzhLxbJYBkTd2P6GFKeNrxkiqsSA/5SPanW+ILctSxEl/KC16QRvT4khA+tddZ1rouGUft06w3gVd10ycr/LopOSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152341; c=relaxed/simple;
	bh=ndvNxnnobdXY1qRGFjwKkxZc5JAWm9Mq+lzm6iZ2oDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oaoZ+HxuKJT/E41MMoFlqh8w+YWjsQy28LW54naWAhV9WS2lWDA5GuK4qVwzLUvaeDbKfWnj7i/MgcAbxNS8fZRGV3xwmefAm8xXy0D8HWliMiUU7VFtAn4ee3inLkhyE0HozRu5xoEkN35YuSTdJ/wnyIwRulasLrP6J+B12pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur+K61lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDCEC4AF1B;
	Tue, 16 Jul 2024 17:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721152340;
	bh=ndvNxnnobdXY1qRGFjwKkxZc5JAWm9Mq+lzm6iZ2oDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ur+K61lDl9kfpg0+3u6I5cYlH9yb9rBbDVzEr33elkgMxW34dgVJff++2P1tnmH8V
	 plOeoA40ruoLq6IQNiOUUmXeytIUlg/vIlYY/d0ve72RtKXCeeMulsVHRNO+qJNM0K
	 a3pT31EpKU+IrcDuSvawXvTG2FICa3zrRZE2mEE9BGgsOWmOjWSrjGH3F3thGqF2tq
	 Ug/I7EAeooNc+/Lo7xYHySRrAgYXrJ38rLrxBMSVWCKr5DhXF373aKPLACCTlwU+bu
	 nfxwEE5PaOsrkLm+aCGB/h0fxuNWJoPMwXzCyb4IFjEf3/SHr8kDiPmGeoOSc+HhnT
	 W+fjOdcoi+HlA==
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
Subject: [PATCH 6.1.y 6/7] minmax: relax check to allow comparison between unsigned arguments and signed constants
Date: Tue, 16 Jul 2024 10:52:04 -0700
Message-Id: <20240716175205.51280-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716175205.51280-1-sj@kernel.org>
References: <20240716175205.51280-1-sj@kernel.org>
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


