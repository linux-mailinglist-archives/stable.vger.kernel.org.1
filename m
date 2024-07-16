Return-Path: <stable+bounces-60314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0700933039
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09CD1C20CB9
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA81A652F;
	Tue, 16 Jul 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjw3rELS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844211A6522;
	Tue, 16 Jul 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154826; cv=none; b=Rn9+N+oCUnH2prOAKm6LNSzs7pUUPsCM4tXXhwRtup3wRTujs1NT1Ro8Y7wkFHcF6tKqJSyi6Ad87o2RP2SQiAiYiPomh1MyLJzMq6yzrFCx/zFPgdgzo7SZERVpaPvpOmKwz0VnigF527Y5xBx2x4Oa+Ebdv5WZhyG/Ww5ktKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154826; c=relaxed/simple;
	bh=B154PBKiYl5EWcFNNPsQO6OKsGY+pG6XCthbORAZL/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwqEjc/L6sm47S1WE14iEv439diWqiLqsYkNwpME+uLpyvJEjbEn0IyS8yZyhGNuaCyKJ+d6lZz7vK3E5OeSf2fexwoK35r4ZvIfr/51dJhsaBM5OIMCFeAJSvf3gF/KX3cgy2B3dziyQ8ph5r3xcslHKzeuSmEtqnF+M2lR+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjw3rELS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32FFC4AF0F;
	Tue, 16 Jul 2024 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154826;
	bh=B154PBKiYl5EWcFNNPsQO6OKsGY+pG6XCthbORAZL/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjw3rELSz2/fCMGSuNWZ10azZwg3mYDgyAqtfvlP832tU+6N3FLJn+IuvProFtFYT
	 IweLKEc4JMCkzpyvgFIM4lRGbSxCr/8M9xpnnTKG6bqihzxFrWThfu1sWZ8rA7RMie
	 p+0bphGvjbJaKeKZ1K4C8H50AAmXXG1yhe6jn7E3M3HTbhvPJedzf+LUxDykAf+wB8
	 M6zJhR7S58Eu7CLgS3HlmcQXYRjw8FVOP5HttxscCQTAOfJiekydgXZlquULnWgylv
	 1hnSyuhuXjz1TKXE6gdW4tu/Jzm9mzWPmhYoTja8YCC0rXb+MZfOG8aLlr3av03LuF
	 R5tdHbMUyfYvg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y 8/8] mm/damon/core: merge regions aggressively when max_nr_regions is unmet
Date: Tue, 16 Jul 2024 11:33:33 -0700
Message-Id: <20240716183333.138498-9-sj@kernel.org>
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
Signed-off-by: SeongJae Park <sj@kernel.org>
[Remove use of unexisting damon_ctx->attrs field]
---
 mm/damon/core.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7a4912d6e65f..4f031412f65c 100644
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
+	max_thres = c->aggr_interval /
+		(c->sample_interval ?  c->sample_interval : 1);
+	do {
+		nr_regions = 0;
+		damon_for_each_target(t, c) {
+			damon_merge_regions_of(t, threshold, sz_limit);
+			nr_regions += damon_nr_regions(t);
+		}
+		threshold = max(1, threshold * 2);
+	} while (nr_regions > c->max_nr_regions &&
+			threshold / 2 < max_thres);
 }
 
 /*
-- 
2.39.2


