Return-Path: <stable+bounces-59361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2F89318EA
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516D3B22B0E
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982981CAA1;
	Mon, 15 Jul 2024 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBpTKuVD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594704D8CB
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062933; cv=none; b=CNWKa7/xZxHiqAgO7rJzKz+iRn9IBZMwzPI7XMu1bYlpw/SYA5qf/P4s7vZjrVW+Sxb5CP6IPcJulHPcJEFVyMz1H5A/M3Y4tuoF8q5Mld/a+ifO2djKcKakW30LiTxVThK3G9kIN7wwdL8z15HK58qIRQ2EUFie0sWh3Z7TwBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062933; c=relaxed/simple;
	bh=cP6uyNFyv6dfiWPqZu88jSfNJFBddBadAcgtQqmhxz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rA5JvMv1dB8I1gstGOflhQUUPyjnsT73f3t2kDL9xPqXsqlOaAG85+/zyopQbN5VXwUOtQ3ruDElU9h8mg0jVqmUXMfafm/NN2A027ax8vR3fwPOJiF33PvriQFRElNlsL/+1uHKlOEo3aPfK7rm0dyu3ieAxETWBuX/fUZojPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBpTKuVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC78C32782;
	Mon, 15 Jul 2024 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721062932;
	bh=cP6uyNFyv6dfiWPqZu88jSfNJFBddBadAcgtQqmhxz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBpTKuVD3tnBtY+nV3DFM03UnKNEMCdOZ8VnVJA7ZdUHEHQZ8lPiDv0JYtJU7tmcK
	 Lb/cSI6aZoYiEQPXbvpKRtGHcubaLx+ZcqaNHKHA8bG2htAalhpWPEWrjIXDVg/32r
	 chM7uLFZAsxK3v4zWRdnUaWFzxzoNeAbpfqBDoYchW8PmO74xJsj5iuTrbMpLI6sQL
	 SRln7SPD5wX8qyrGDeKmrM76rLeM4yO54YRx31xZwfqz6TMsA+EGcubaSNmTrKLZPA
	 3G2NPJTu5GEPmWudRaQDjjlwOUkZpTJ1z8tdLW4mrfEVKqtAcP7FHSWsJC6moDyJC8
	 Cav7hdmmQwW2g==
From: SeongJae Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: merge regions aggressively when max_nr_regions" failed to apply to 5.15-stable tree
Date: Mon, 15 Jul 2024 10:02:09 -0700
Message-Id: <20240715170209.74009-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024071546-swerve-grew-de52@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On Mon, 15 Jul 2024 13:34:47 +0200 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6

Similar to the failure of this patch for 6.1.y, I cannot reproduce the conflict
on my setup.  Attaching the patch for successfully cherry-picked one on my
machine for any possible case.

[1] https://lore.kernel.org/2024071547-slum-anemic-a0cc@gregkh


Thanks,
SJ

[...]

==== Attachment 0 (./0001-mm-damon-core-merge-regions-aggressively-when-max_nr.patch) ====
From cd2cd0ec28c79017a9326f235077eb904e4a2cdd Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 24 Jun 2024 10:58:14 -0700
Subject: [PATCH 5.15.y] mm/damon/core: merge regions aggressively when
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
 mm/damon/core.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7a4912d6e65f..3a18e1ad8ca9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -507,14 +507,31 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
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
-
-	damon_for_each_target(t, c)
-		damon_merge_regions_of(t, threshold, sz_limit);
+	unsigned int nr_regions;
+	unsigned int max_thres;
+
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


