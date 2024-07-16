Return-Path: <stable+bounces-60311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B344E933033
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E497B1C22014
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D71A4F25;
	Tue, 16 Jul 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJok/xsA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398A1A4F1E;
	Tue, 16 Jul 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154824; cv=none; b=quc9qoACCnsAu26U1Z5u70sXHlrkVoyiSI0aWb/PFXDRU1makNrCSJPoFW7p7AMJi44q3Xyhw1Vod++zmi7pl9hu6NtYn1ZMKI62tsvzGaeDv286DNJfRAONWv9P4PxIGiCqFDnksRWsYAC8S9uMHylBzTRz2fRLsSh6vTDf+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154824; c=relaxed/simple;
	bh=nUuPHoyJXLPZI9hsORkcW/G6LJ7x+O14qehpn3HYZSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kIn04ZsLpRp2Rjm5aiYAhUXCQUzM+RYR/hzkhLmvF8+hjIqxARuUPM9BYVZeN52O/n5KOGRW/symvzaZQSz+o6MDdWoIAMvC+dYqIqLz+T1s9exQSwLEUoLM/vscaK06SKiEsJbYOaCW8xsoSMcXLb/0HDdon6nz9GIzoMXVM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJok/xsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE849C4AF0B;
	Tue, 16 Jul 2024 18:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154824;
	bh=nUuPHoyJXLPZI9hsORkcW/G6LJ7x+O14qehpn3HYZSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJok/xsAxb6Hi7w7ANep6/L6G90vx4WvBodR4zWHhWBDYDCcNxPqpCn8zBsMkYy1q
	 h5JIGCTN5/7zFkWBA3WVwUfAIjWSliZ1qT7EVyZtMPVynqedQ0et+5Tw2D880hj8Oa
	 EaNIsrGPt5/fbyM1KICckGFftbWykQUL1vs55DBKNWrPa7QK50XRuAhUgerCwjC2GS
	 vbojg5qm74S9qtR0LW1tjRzh67vx4g3YK77C/gS7PfCMAMqIgLucOKZtDX51F913iC
	 +zgunR2H/Qy/dB5FY1OSGJqkKIPOjWvkOjxM4nQph6fVTL24/ZogxdVKPGrw52/49G
	 1dpOq8Uy5fnHg==
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
Subject: [PATCH 5.15.y 6/8] minmax: allow comparisons of 'int' against 'unsigned char/short'
Date: Tue, 16 Jul 2024 11:33:31 -0700
Message-Id: <20240716183333.138498-7-sj@kernel.org>
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


