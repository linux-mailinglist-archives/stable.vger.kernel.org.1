Return-Path: <stable+bounces-59360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9589318E1
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 18:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAFB281A65
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52583208A9;
	Mon, 15 Jul 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbyGedrB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA01CAB8
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062640; cv=none; b=kLcGCL3R1LKZKgNBnyydJZPHNoVRUkPw//D2ZLkrz1dJbx3A/3ALrhtTZIuKXTK5GPmKJvbtP217nZkoEkqI3AofY2ewFPUgSfL12uxR49Ti0aGI8msGouZa6QuUKd2GUURZoASUOLxJp6tPKgb3yx3QV1kRS9gNhFY6LAQCt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062640; c=relaxed/simple;
	bh=2+Zgygw757qK8L+zbR8igQkEdL2qtGjhWO6k9gZTlbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFayZd41qJ84lpGgEbvmfUmVCAKsDC9D6Mz3E5R02d9PAfAe06G5VEbjfE91ESFqSpphRxfsx7qLiCb40DsPdAr3CQFaX5SES4kqsmJz/gBObiZj0n9wxPuQua+4n7Guf5JAbUbuzR9cAfxCyOpSlX93shElaQNsv31KVo1X51o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbyGedrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35331C32782;
	Mon, 15 Jul 2024 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721062639;
	bh=2+Zgygw757qK8L+zbR8igQkEdL2qtGjhWO6k9gZTlbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YbyGedrB1G/i/Mjp7/dYgwFbSD6IXGDbQLXpzZMMcqoBRfup35j8bCWRHETDOvY3d
	 Py7Q8gd7yCApeHQtB9YXMh173ZvbTN7e6wKLnIhkwsb5yrKNzM/3oPjcnp6rMhxuzk
	 4ZMWFU1PqmtU5AvHg1nMguRqBBDa1VdV9F15qd+IIXBzsg7AdoaX5tM0Zoxv8Fo8BZ
	 vh7ypyc0F/X3zPu030kkBw06RTuGQw+UV3OxPZC4X2YUS1MX8eILLhYOYObGiq34HX
	 kt5NORJ9K8N07AF+sJ3qSFIppjXddeZj9Z2CAFkyk67kLquX/F8BFqHo9u4cA0Fjeo
	 i+iryfAQuR+sg==
From: SeongJae Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: merge regions aggressively when max_nr_regions" failed to apply to 6.1-stable tree
Date: Mon, 15 Jul 2024 09:57:17 -0700
Message-Id: <20240715165717.73852-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024071547-slum-anemic-a0cc@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On Mon, 15 Jul 2024 13:34:48 +0200 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6

But this doesn't reproduce the failure on my machine, like below?

    $ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
    [...]
    $ git checkout FETCH_HEAD
    [...]
    HEAD is now at cac15753b8ce Linux 6.1.99
    $ git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6
    Auto-merging mm/damon/core.c
    [detached HEAD ecd04159c5f3] mm/damon/core: merge regions aggressively when max_nr_regions is unmet
     Date: Mon Jun 24 10:58:14 2024 -0700
     1 file changed, 19 insertions(+), 2 deletions(-)

Could the faulure depend on something such as git version?  For such a case,
attaching the resulting patch below.


Thanks,
SJ

[...]

====================== >8 ========================
From ecd04159c5f3c58dc540864d48e9480c7617717c Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 24 Jun 2024 10:58:14 -0700
Subject: [PATCH 6.1.y] mm/damon/core: merge regions aggressively when
 max_nr_regions is unmet

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


