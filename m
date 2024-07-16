Return-Path: <stable+bounces-60285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AC0932F77
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335291C22131
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D1D1A0B17;
	Tue, 16 Jul 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ5HFnrA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBF1A0AFB;
	Tue, 16 Jul 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152341; cv=none; b=a3/eXAqK4WSRNQ2PE6a9q9MtDx2dWV5crkr/fP/MLz9KvH6bwH5ym/Fx0wggtjsik0pLFRRaKgG4/lamZRl0xmE6/1FWHaG26OkI2xm6wgkRQvBu6lP+SHtEcztkMQe4XQtXEJDhh7o67bAVeWuDmYmu+wkAPyNRvFom+SrQWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152341; c=relaxed/simple;
	bh=T/pNo+yJuvE1fTBndW2I+PGWWQSfcSQHEgmL3hp/wPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJiSbT6Gd6jXUPu5/NwGkA8qNe8gNjECqg6cMpjHmJVW5RQdDk8IMjCe8LKWQlBke3WTm6VegJKNuzmUwT0O/7XTZxfOeVDhOJdjq5ZxT3UayGwM46yb62hyTdd08JBL7Nrmh/5uSh7Z9peNutrB7EjPWCJO1MNpKu1PlLB38lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ5HFnrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFEAC4AF0D;
	Tue, 16 Jul 2024 17:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721152340;
	bh=T/pNo+yJuvE1fTBndW2I+PGWWQSfcSQHEgmL3hp/wPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJ5HFnrA0gGqZLuEPeEMN1mg0jqaTM9UDLRevr0HupKNYdGfGxKDjFNarBVKFdQwQ
	 e9gWRGiwBUzViaku+L9z1QoGNXBFu0xxwBvLWEqvxy659vuNIFJkesFvVhZb/gmDA1
	 DtVcN0V4mlwXWuTzJs9Ds0lpaSumxhEIZrL8TivBWgkzvrrZtRgGr60m/TEuROCmUj
	 LCPNzOK+6pnJ/ORW6Z12e6u8Bjh6POkH4TYu1LwcWFdRlnMiOU+EJRWd+nz1qKKYJQ
	 Sm/9+SnNFATTz0WNRcFk2GP6CUkYETY46eEDeijaaTAFXQztYjJvYpviBpFHBL/rwu
	 jJxqBsRex9eHA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y 7/7] mm/damon/core: merge regions aggressively when max_nr_regions is unmet
Date: Tue, 16 Jul 2024 10:52:05 -0700
Message-Id: <20240716175205.51280-8-sj@kernel.org>
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

commit 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6 upstream.

DAMON keeps the number of regions under max_nr_regions by skipping regions
split operations when doing so can make the number higher than the limit.
It works well for preventing violation of the limit.  But, if somehow the
violation happens, it cannot recovery well depending on the situation.  In
detail, if the real number of regions having different access pattern is
higher than the limit, the mechanism cannot reduce the number below the
limit.  In such a case, the system could suffer from high monitoring
overhead of DAMON.

The violation can actually happen.  For an example, the user could reduce
max_nr_regions while DAMON is running, to be lower than the current number
of regions.  Fix the problem by repeating the merge operations with
increasing aggressiveness in kdamond_merge_regions() for the case, until
the limit is met.

[sj@kernel.org: increase regions merge aggressiveness while respecting min_nr_regions]
  Link: https://lkml.kernel.org/r/20240626164753.46270-1-sj@kernel.org
[sj@kernel.org: ensure max threshold attempt for max_nr_regions violation]
  Link: https://lkml.kernel.org/r/20240627163153.75969-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20240624175814.89611-1-sj@kernel.org
Fixes: b9a6ac4e4ede ("mm/damon: adaptively adjust regions")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6)
---
 mm/damon/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5db9bec8ae67..ab5c351b276c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -921,14 +921,31 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
  * access frequencies are similar.  This is for minimizing the monitoring
  * overhead under the dynamically changeable access pattern.  If a merge was
  * unnecessarily made, later 'kdamond_split_regions()' will revert it.
+ *
+ * The total number of regions could be higher than the user-defined limit,
+ * max_nr_regions for some cases.  For example, the user can update
+ * max_nr_regions to a number that lower than the current number of regions
+ * while DAMON is running.  For such a case, repeat merging until the limit is
+ * met while increasing @threshold up to possible maximum level.
  */
 static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 				  unsigned long sz_limit)
 {
 	struct damon_target *t;
+	unsigned int nr_regions;
+	unsigned int max_thres;
 
-	damon_for_each_target(t, c)
-		damon_merge_regions_of(t, threshold, sz_limit);
+	max_thres = c->attrs.aggr_interval /
+		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
+	do {
+		nr_regions = 0;
+		damon_for_each_target(t, c) {
+			damon_merge_regions_of(t, threshold, sz_limit);
+			nr_regions += damon_nr_regions(t);
+		}
+		threshold = max(1, threshold * 2);
+	} while (nr_regions > c->attrs.max_nr_regions &&
+			threshold / 2 < max_thres);
 }
 
 /*
-- 
2.39.2


