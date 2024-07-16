Return-Path: <stable+bounces-60309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC77193302F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB5C281E3F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DB31A3BC9;
	Tue, 16 Jul 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzATlsJx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC11A3BBB;
	Tue, 16 Jul 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154823; cv=none; b=iNNbuwtgoGe60QuNp25ZCC2SM8rEpoYa+D3sqIX+hOchkwPB27kTeFcin1qCjKfh7sKz5s1PGU4iID4uI69SduKASlI+9pxc601DOnV/tBTHHh7KJwS2D/1Ybyhs8CStA94eQY6i+xnP5sw8Vo3SHdOFwIv+feYGFr8GQ2aqyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154823; c=relaxed/simple;
	bh=DfS+ZGQlpkyRoXAydI0Q0HXfxyiuVuX7x3ZtcbMPeEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uECurZngU71+ja9HDFUvLcVzMfMtzjZlC9N8oFkH4ESNN2YhiuFoCA/j5FU6KRsZYNsSR7k/F1DypFEm8bfhUggUjqqYb2QAFsZzaFmYNwg1e2m1G25n0vRbgjmR4C5K5/5+tVqayXpxZuqdsJOmFwbaJe8JQXlSEZ8rnfX3fLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzATlsJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EA0C4AF12;
	Tue, 16 Jul 2024 18:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154822;
	bh=DfS+ZGQlpkyRoXAydI0Q0HXfxyiuVuX7x3ZtcbMPeEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzATlsJxPkHLUoSCYVjxNIIPUBGaM+IQS/4StZsm7UtFY9wwg/WnUI35Rd6j2RCiZ
	 OZLbjNwGOM5g7s5Ryq2qo1QAM7+/0Spg+i+oe1atJ62tpqOd8rIb+0nKDQHGd4/gMm
	 j2Bl/bLKRvYP8edQjxitnIlo0x1orVcKofRJkZJ77JYn65oe5RdCogpX4LxvP13HRA
	 mpo0xG8uQ/UCNKpQVf08+ewDWxEOEnyLOwsJNHZt35YlyGAa1mP7D0adfu4G23Pe/A
	 q65G0SuEJNIWEbe2sqwlP/xRXvf/hJNM3y7diZhUgHtqadUl3KPvtlKr91ekF2TW4A
	 6VwGZ/MpEUYzQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 5.15.y 4/8] minmax: fix header inclusions
Date: Tue, 16 Jul 2024 11:33:29 -0700
Message-Id: <20240716183333.138498-5-sj@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit f6e9d38f8eb00ac8b52e6d15f6aa9bcecacb081b upstream.

BUILD_BUG_ON*() macros are defined in build_bug.h.  Include it.  Replace
compiler_types.h by compiler.h, which provides the former, to have a
definition of the __UNIQUE_ID().

Link: https://lkml.kernel.org/r/20230912092355.79280-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit f6e9d38f8eb00ac8b52e6d15f6aa9bcecacb081b)
Signed-off-by: SeongJae Park <sj@kernel.org>
[Fix a conflict due to absence of compiler_types.h include]
---
 include/linux/minmax.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index abdeae409dad..e8e9642809e0 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_MINMAX_H
 #define _LINUX_MINMAX_H
 
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
 #include <linux/const.h>
 
 /*
-- 
2.39.2


