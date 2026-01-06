Return-Path: <stable+bounces-204970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A26ECF6208
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 160F130060EB
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1519E1FDE39;
	Tue,  6 Jan 2026 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR6erKV3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1391F9F7A
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660931; cv=none; b=k/DuoQgk8mQHNSuR0Jd5UIl57VOEZIepw0UGddLK7NlxAAEntEbiLF6tGHFVijkYgm/CAV5t4OjZjXXHBrgLSpiqgemWP4nFzJJWyhVo6nuR8eBBEirT5NxYE9pgyNvXQPaZJVAqwijkaPnoKnw4cUZJ0ExpT9bJihK45c3GR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660931; c=relaxed/simple;
	bh=rjxso3LDG0AkPpImwbTyPZ91I8vkpEPmgGHuYY4yoks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLxGJX0kBLgvG4rj62c4h6pP3DcebHtCE8ZD8vp2soRlL/C8sxB0xrnk7o7Z0hOEf3c6dRxmG7GS3XXJYokeK8QF8vlmis9C5STVvUmb9h0gq8oyrawttEuJ526mHGKrbxFRLYmr+bqmw0mvRcDrWxX/roZ9wGiKDtxAwNOmxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR6erKV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200C7C116D0;
	Tue,  6 Jan 2026 00:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660931;
	bh=rjxso3LDG0AkPpImwbTyPZ91I8vkpEPmgGHuYY4yoks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pR6erKV3b8ODpjWJidY2U0hvQHWdcy1C10lqNj4AmyyE1ZsvEQeen1s1bxtFKtNEz
	 pr0UvX1y7FOrzgJoG0UmYjv36ZFDYJ+wiXox7Rvp0k7IBOcu6yAGkIXcY34JVO+2bk
	 6U8Bw3IZsc0TF5uwIwD4aTo8f2ZRWGuAvDHCDuhaaNoI4lVGU4svpV2tCRh+cyFAVk
	 nKPKnGs8TIEXIQKxHnVw4CD1fL9kp+60VYb1DH0nugnQGnrOdZLPfjpO9luxGVKnGx
	 J92DEchfEY+sSW4WllwhmC/F0Lq2ibFIp7ZMESnXdTTNH3bBe4OunL6Q7BtsdeLvKx
	 B46SjPWqLdUEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] mm/damon/core: add damos_filter->allow field
Date: Mon,  5 Jan 2026 19:55:26 -0500
Message-ID: <20260106005528.2865815-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106005528.2865815-1-sashal@kernel.org>
References: <2026010550-tank-repugnant-eee6@gregkh>
 <20260106005528.2865815-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit fe6d7fdd62491524d11433b9ff8d3db5dde32700 ]

DAMOS filters work as only exclusive (reject) filters.  This makes it easy
to be confused, and restrictive at combining multiple filters for covering
various types of memory.

Add a field named 'allow' to damos_filter.  The field will be used to
indicate whether the filter should work for inclusion or exclusion.  To
keep the old behavior, set it as 'false' (work as exclusive filter) by
default, from damos_new_filter().

Following two commits will make the core and operations set layers, which
handles damos_filter objects, respect the field, respectively.

Link: https://lkml.kernel.org/r/20250109175126.57878-3-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 28ab2265e942 ("mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h | 4 +++-
 mm/damon/core.c       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0078912823d2..0da1397cd719 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -328,7 +328,8 @@ enum damos_filter_type {
 /**
  * struct damos_filter - DAMOS action target memory filter.
  * @type:	Type of the target memory.
- * @matching:	If the @type-matching memory should be filtered out.
+ * @matching:	Whether this is for @type-matching memory.
+ * @allow:	Whether to include or exclude the @matching memory.
  * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
  * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
  * @target_idx:	Index of the &struct damon_target of
@@ -345,6 +346,7 @@ enum damos_filter_type {
 struct damos_filter {
 	enum damos_filter_type type;
 	bool matching;
+	bool allow;
 	union {
 		unsigned short memcg_id;
 		struct damon_addr_range addr_range;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ed2b75023181..17a9fe18c069 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -275,6 +275,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
+	filter->allow = false;
 	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
-- 
2.51.0


