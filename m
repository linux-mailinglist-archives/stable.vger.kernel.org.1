Return-Path: <stable+bounces-60283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACBB932F73
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62291F23E93
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA041A08CC;
	Tue, 16 Jul 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCYoCP7V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23C1A08C2;
	Tue, 16 Jul 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152339; cv=none; b=AMFBtjhNSCyzpb5DXFLjJvxbJXfrU+QzkHIXKKpQxzLEfcTiEn0EOPvsvSBYdkIhIFTjGmVDDCr/AO/C96aGvhz5YsQUJAm8xjQoZEWJFnuVQ3OQJoT/AD4+m7r5A/Zdm85NzvsCbXL5pYReXTc9xOvG613K0dd55Sjb+PDNQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152339; c=relaxed/simple;
	bh=nUuPHoyJXLPZI9hsORkcW/G6LJ7x+O14qehpn3HYZSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIO3/kM0mjvVwQNLiYKUkLfWhLBYaPfXkbqWpCpJNp6NVY/HW0m/7I1o4ujxgE1fBEixsYbcPaKwhQNW3ahTtXtXZ4q6kzZplSptIGUESybpuJWP7cJnboWDFyzh10RvswGSTV0wjf9mAe5TaMHoIK81QMFaJl5tN4SixIHv7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCYoCP7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7074DC4AF0B;
	Tue, 16 Jul 2024 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721152339;
	bh=nUuPHoyJXLPZI9hsORkcW/G6LJ7x+O14qehpn3HYZSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCYoCP7V8bNsuBerBjAWlaLEtu5E4OoKmWKvCP3oD1nzjDgPO5kqb5Um1L3FrdZvF
	 h52Zl3GQiNRC7E2KzuyvsyUzxAPxwnOVAcKdioVQlvshlgwrcYLJgOclvqLAPWeiNJ
	 P6xZGblQ0IBjgvXXiM+7gnu+65S0bAw7wEH27mJ+bJdA9pIXhl7K2X55CLGRCEXIoJ
	 jyAFJM1siYHKhHEcmw3qE+iOi9OjtGJZnKuSH3LaVfFiEf74fuNpuaROhPbDFASzd6
	 RKD71VC0WN6dCZ05+iT137DxXwAka9mDRKeDFpj0cFjk5Ytlg/0sWJCB0NDDWb9Iqu
	 AxGPGoBS2kGnQ==
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
Subject: [PATCH 6.1.y 5/7] minmax: allow comparisons of 'int' against 'unsigned char/short'
Date: Tue, 16 Jul 2024 10:52:03 -0700
Message-Id: <20240716175205.51280-6-sj@kernel.org>
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

commit 4ead534fba42fc4fd41163297528d2aa731cd121 upstream.

Since 'unsigned char/short' get promoted to 'signed int' it is safe to
compare them against an 'int' value.

Link: https://lkml.kernel.org/r/8732ef5f809c47c28a7be47c938b28d4@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 4ead534fba42fc4fd41163297528d2aa731cd121)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/minmax.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 501fab582d68..f76b7145fc11 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -25,8 +25,9 @@
 	__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),	\
 		is_signed_type(typeof(x)), 0)
 
-#define __types_ok(x, y) \
-	(__is_signed(x) == __is_signed(y))
+#define __types_ok(x, y) 			\
+	(__is_signed(x) == __is_signed(y) ||	\
+		__is_signed((x) + 0) == __is_signed((y) + 0))
 
 #define __cmp_op_min <
 #define __cmp_op_max >
-- 
2.39.2


