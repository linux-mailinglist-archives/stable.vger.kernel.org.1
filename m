Return-Path: <stable+bounces-60279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F64F932F6C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4691C21B30
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D471A01A7;
	Tue, 16 Jul 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Vv6KTD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F91A00F7;
	Tue, 16 Jul 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152336; cv=none; b=hqj5oyY0euBzbp344MEjoQ8bokZTvuFEn4iVJ8qoN89Uy76ZkVbhx1F8rfxJ3rD4/0z2ny89QXMMOMzjGSsgA6CPIRxGMRZzuFE+Mm/lxGwGC+oEvCSvBIYYZp4sfYnrULnbNoMb/5wRIuoeqKM0L7sayY1fJrwukKhzwKV5Lrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152336; c=relaxed/simple;
	bh=p3+cbQrtzD34rlMr4M+1CIjAqE6/GqsWTPXFKfSsxdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmLrLJsN/rZP1vTvfwK8p0+NuMcsQiePj8rtGGFcpSEoMSnRnqEAVfeXfP9nAPsE/Xqf6s+gBkAsnKIgXcSXkHZIh4Kbfbzuo2mAGVVekTAb5sfVG+vKF3Bk4iDbjdsKSHuX3RLdbv4nUurkHHbxecvvXihLiwY7rJoL8kMsxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9Vv6KTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C51C4AF0E;
	Tue, 16 Jul 2024 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721152335;
	bh=p3+cbQrtzD34rlMr4M+1CIjAqE6/GqsWTPXFKfSsxdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9Vv6KTDxu3pDLw4K2EcYpGjkhIiBszgq2OH3QC80jHrVIJEUMwUlvaF2nkbTXAu6
	 mrO3qaKhy80SadeBCLzPl7/Eqm/stbRfEsTP872cBCQST9bwU5pctzX5K7S6wzB45d
	 TRCDZ2nVHz7KOl/mN7rFeedAhY8PP4rt3WXYVXfY/4/Zj6RB9u1wo2X4OCzbVG+U1B
	 YjMEumNQzOjYRPpV5WrS5q7MLA8K0RsoFf4TbFaRWVGk1f46DctrzIHzqpPA+4jvfh
	 OwZTbAg5YjvrRryyvbZaLZzOaxnffIjDviWzqcW3JDUuUunSpXeTrIumbP4BAVporC
	 e2DieOl2H6ytQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 6.1.y 1/7] minmax: sanity check constant bounds when clamping
Date: Tue, 16 Jul 2024 10:51:59 -0700
Message-Id: <20240716175205.51280-2-sj@kernel.org>
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

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

commit 5efcecd9a3b18078d3398b359a84c83f549e22cf upstream.

The clamp family of functions only makes sense if hi>=lo.  If hi and lo
are compile-time constants, then raise a build error.  Doing so has
already caught buggy code.  This also introduces the infrastructure to
improve the clamping function in subsequent commits.

[akpm@linux-foundation.org: coding-style cleanups]
[akpm@linux-foundation.org: s@&&\@&& \@]
Link: https://lkml.kernel.org/r/20220926133435.1333846-1-Jason@zx2c4.com
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5efcecd9a3b18078d3398b359a84c83f549e22cf)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/minmax.h | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 1aea34b8f19b..8b092c66c5aa 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -37,6 +37,28 @@
 		__cmp(x, y, op), \
 		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
 
+#define __clamp(val, lo, hi)	\
+	__cmp(__cmp(val, lo, >), hi, <)
+
+#define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({	\
+		typeof(val) unique_val = (val);				\
+		typeof(lo) unique_lo = (lo);				\
+		typeof(hi) unique_hi = (hi);				\
+		__clamp(unique_val, unique_lo, unique_hi); })
+
+#define __clamp_input_check(lo, hi)					\
+        (BUILD_BUG_ON_ZERO(__builtin_choose_expr(			\
+                __is_constexpr((lo) > (hi)), (lo) > (hi), false)))
+
+#define __careful_clamp(val, lo, hi) ({					\
+	__clamp_input_check(lo, hi) +					\
+	__builtin_choose_expr(__typecheck(val, lo) && __typecheck(val, hi) && \
+			      __typecheck(hi, lo) && __is_constexpr(val) && \
+			      __is_constexpr(lo) && __is_constexpr(hi),	\
+		__clamp(val, lo, hi),					\
+		__clamp_once(val, lo, hi, __UNIQUE_ID(__val),		\
+			     __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
+
 /**
  * min - return minimum of two values of the same or compatible types
  * @x: first value
@@ -103,7 +125,7 @@
  * This macro does strict typechecking of @lo/@hi to make sure they are of the
  * same type as @val.  See the unnecessary pointer comparisons.
  */
-#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
+#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
 
 /*
  * ..and if you can't take the strict
@@ -138,7 +160,7 @@
  * This macro does no typechecking and uses temporary variables of type
  * @type to make all the comparisons.
  */
-#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
+#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
 
 /**
  * clamp_val - return a value clamped to a given range using val's type
-- 
2.39.2


