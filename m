Return-Path: <stable+bounces-204969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A466FCF620B
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E82D43038197
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809401F8BD6;
	Tue,  6 Jan 2026 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnXUF6Fv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413571F0E29
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660931; cv=none; b=cKGElmWAMvLMsgw8UOOPmnGvd89CCqf5mev7GWAvHqDAprATvqw3v89F2QssNw3rMfQ6MgyhhC9U7CML409sJF8HbIXu+mqitF5V7KbDZdjo5e5OH8UQAwogqz7kPWDR+1YwrP0jgke/G2qRgCmCBukZwgepqPFtcezsaLpA4Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660931; c=relaxed/simple;
	bh=A7g4xupfxtoqzRl1qIYiSPuJUQHWNdGpk8TlrCtcZcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loajKjYx3B7qUgwNHLVfDmByD+2htp8cPsmQsIQw3rjzjleDpYLQA5S8JjDXZTKhtBb8CUoY7lWsGFUeYjxNPxxJP6gylrwwO6IOmcxC3oTtD3gMupE6q2e7DFwVslBjkHlgladz7sd2pLQutiopzCoTyH1Se0TPnBVFIU6NpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnXUF6Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468BDC16AAE;
	Tue,  6 Jan 2026 00:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660930;
	bh=A7g4xupfxtoqzRl1qIYiSPuJUQHWNdGpk8TlrCtcZcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnXUF6Fv5P0kZFfApnw8hhZ3AyFU2s6lXPQMMouD1TrkEWf/RdC7fB/08Xvqgj7Ti
	 lPz14sa231i0gDHkqSddkchulwU8uSCgv4OSDn/yzEUtl+cU0sLUd7UkTLvNK0xQfG
	 E0OfpFTt43EHfNQtKmMpU1VRQR9ttrLNPtsllQtJleARzdboW7EwBiKOpnWVsV4N+h
	 E1Ab6KNrIWbY6F6xAkUjD+QUHfhYVsUNzdlMkjhsuniJkuiId1vOMTnZs57MZxr9DI
	 tb2gKLl+hjXa05ofCJjFVOm7GeaPlxCMBuybmrNuTe5zyD7fioC7l4kl1eblrLsWA3
	 eSrJjt/INqt9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] mm/damon: fixup damos_filter kernel-doc
Date: Mon,  5 Jan 2026 19:55:25 -0500
Message-ID: <20260106005528.2865815-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010550-tank-repugnant-eee6@gregkh>
References: <2026010550-tank-repugnant-eee6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit e20f52e8e3b7947e40bd40c6cdc69884c6df716c ]

Patch series "mm/damon: extend DAMOS filters for inclusion", v2.

DAMOS fitlers are exclusive filters.  It only excludes memory of given
criterias from the DAMOS action targets.  This has below limitations.

First, the name is not explicitly explaining the behavior.  This actually
resulted in users' confusions[1].  Secondly, combined uses of multiple
filters provide only restriced coverages.  For example, building a DAMOS
scheme that applies the action to memory that belongs to cgroup A "or"
cgroup B is impossible.  A workaround would be using two schemes that
fitlers out memory that not belong to cgroup A and cgroup B, respectively.
It is cumbersome, and difficult to control quota-like per-scheme features
in an orchestration.  Monitoring of filters-passed memory statistic will
also be complicated.

Extend DAMOS filters to support not only exclusion (rejecting), but also
inclusion (allowing) behavior.  For this, add a new damos_filter struct
field called 'allow' for DAMON kernel API users.  The filter works as an
inclusion or exclusion filter when it is set or unset, respectively.  For
DAMON user-space ABI users, add a DAMON sysfs file of same name under
DAMOS filter sysfs directory.  To prevent exposing a behavioral change to
old users, set rejecting as the default behavior.

Note that allow-filters work for only inclusion, not exclusion of memory
that not satisfying the criteria.  And the default behavior of DAMOS for
memory that no filter has involved is that the action can be applied to
those memory.  Also, filters-passed memory statistics are for any memory
that passed through the DAMOS filters check stage.  These implies
installing allow-filters at the endof the filter list is useless.  Refer
to the design doc change of this series for more details.

[1] https://lore.kernel.org/20240320165619.71478-1-sj@kernel.org

This patch (of 10):

The comment is slightly wrong.  DAMOS filters are not only for pages, but
general bytes of memory.  Also the description of 'matching' is bit
confusing, since DAMOS filters do only filtering out.  Update the comments
to be less confusing.

Link: https://lkml.kernel.org/r/20250109175126.57878-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20250109175126.57878-2-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 28ab2265e942 ("mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a67f2c4940e9..0078912823d2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -327,8 +327,8 @@ enum damos_filter_type {
 
 /**
  * struct damos_filter - DAMOS action target memory filter.
- * @type:	Type of the page.
- * @matching:	If the matching page should filtered out or in.
+ * @type:	Type of the target memory.
+ * @matching:	If the @type-matching memory should be filtered out.
  * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
  * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
  * @target_idx:	Index of the &struct damon_target of
@@ -337,9 +337,10 @@ enum damos_filter_type {
  * @list:	List head for siblings.
  *
  * Before applying the &damos->action to a memory region, DAMOS checks if each
- * page of the region matches to this and avoid applying the action if so.
- * Support of each filter type depends on the running &struct damon_operations
- * and the type.  Refer to &enum damos_filter_type for more detai.
+ * byte of the region matches to this given condition and avoid applying the
+ * action if so.  Support of each filter type depends on the running &struct
+ * damon_operations and the type.  Refer to &enum damos_filter_type for more
+ * details.
  */
 struct damos_filter {
 	enum damos_filter_type type;
-- 
2.51.0


