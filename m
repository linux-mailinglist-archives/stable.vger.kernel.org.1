Return-Path: <stable+bounces-89442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A349B82AC
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 19:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FEE1F23196
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8B71C9EB5;
	Thu, 31 Oct 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaImNOts"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F61C9DED;
	Thu, 31 Oct 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730399882; cv=none; b=QQoJGS9QtFpKpFT9FpCmPbvyTAImlenH+PriL3vu8/7lUyqAdwZt2wna+u7P1+XM+rXhtASTh/cqDL+s5di+gTtzSLjR1gvW8EFyJklq8i1lDlQTL9p3euMi5HZ7+KxeCe7tEcRdl0txDFqUz+kU9RJKvhYbKvXZ8qqzry+mb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730399882; c=relaxed/simple;
	bh=hzCrs3U1wpfuL1mByOLcpS5v+HB/qTe71dwMaFfYxG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y2jNUlQh2UnbCFb/152wmhajhEsBywnz0GeVQYVCZmf/8C9HZPfVb0tgqiVGWMtAyyXnJy/hn7lxbNCAkccv3cmFP6E5AqKwJnq1MIldguDTVgB/OVDBO7ulAOyHxbJ/b2DNigPzlkSiGYcKAMOyUI027itC0/v/nvVRkx4n0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaImNOts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3709EC4CEC3;
	Thu, 31 Oct 2024 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730399882;
	bh=hzCrs3U1wpfuL1mByOLcpS5v+HB/qTe71dwMaFfYxG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uaImNOtsGoHYSbe1m2EJckQzyLxi20TlzKdFyg4I1+pz0azw903+1CWJfhtelXv0u
	 rcmY6Tr9ux9gPygaxzdwk1bV7udBlBRiDKlIsfhKDBZhcfcA6I/SdSdIoICNuN8TX+
	 pzRDVujFnJgRi0HCN+TetdtHbetKZXEinbaPYwbUPVW/zNsnnQL0SdYaHn9RpShJZJ
	 5T/3UjPh+y4Kb/cah3MjgKf2HLyf/Sy44sv6B8pcM+LNa2ddsCwKskJmsLNAFEpz3l
	 i5KU3LKJzrL+Ix/EfuTA3m7z819N72lK00vZ9X/hxI8SQSf+WtpLumzPg0HE+BkcFJ
	 fcH+N5mWhcE5Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: handle zero {aggregation,ops_update} intervals
Date: Thu, 31 Oct 2024 11:37:56 -0700
Message-Id: <20241031183757.49610-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031183757.49610-1-sj@kernel.org>
References: <20241031183757.49610-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's logics to determine if this is the time to do aggregation and
ops update assumes next_{aggregation,ops_update}_sis are always set
larger than current passed_sample_intervals.  And therefore it further
assumes continuously incrementing passed_sample_intervals every sampling
interval will make it reaches to the next_{aggregation,ops_update}_sis
in future.  The logic therefore make the action and update
next_{aggregation,ops_updaste}_sis only if passed_sample_intervals is
same to the counts, respectively.

If Aggregation interval or Ops update interval are zero, however,
next_aggregation_sis or next_ops_update_sis are set same to current
passed_sample_intervals, respectively.  And passed_sample_intervals is
incremented before doing the next_{aggregation,ops_update}_sis check.
Hence, passed_sample_intervals becomes larger than
next_{aggregation,ops_update}_sis, and the logic says it is not the time
to do the action and update next_{aggregation,ops_update}_sis forever,
until an overflow happens.  In other words, DAMON stops doing
aggregations or ops updates effectively forever, and users cannot get
monitoring results.

Based on the documents and the common sense, a reasonable behavior for
such inputs is doing an aggregation and an ops update for every sampling
interval.  Handle the case by removing the assumption.

Note that this could incur particular real issue for DAMON sysfs
interface users, in case of zero Aggregation interval.  When user starts
DAMON with zero Aggregation interval and asks online DAMON parameter
tuning via DAMON sysfs interface, the request is handled by the
aggregation callback.  Until the callback finishes the work, the user
who requested the online tuning just waits.  Hence, the user will be
stuck until the passed_sample_intervals overflows.

Fixes: 4472edf63d66 ("mm/damon/core: use number of passed access sampling as a timer")
Cc: <stable@vger.kernel.org> # 6.7.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 27745dcf855f..931526fb2d2e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2014,7 +2014,7 @@ static int kdamond_fn(void *data)
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
-		if (ctx->passed_sample_intervals == next_aggregation_sis) {
+		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
@@ -2032,7 +2032,7 @@ static int kdamond_fn(void *data)
 
 		sample_interval = ctx->attrs.sample_interval ?
 			ctx->attrs.sample_interval : 1;
-		if (ctx->passed_sample_intervals == next_aggregation_sis) {
+		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
 			ctx->next_aggregation_sis = next_aggregation_sis +
 				ctx->attrs.aggr_interval / sample_interval;
 
@@ -2042,7 +2042,7 @@ static int kdamond_fn(void *data)
 				ctx->ops.reset_aggregated(ctx);
 		}
 
-		if (ctx->passed_sample_intervals == next_ops_update_sis) {
+		if (ctx->passed_sample_intervals >= next_ops_update_sis) {
 			ctx->next_ops_update_sis = next_ops_update_sis +
 				ctx->attrs.ops_update_interval /
 				sample_interval;
-- 
2.39.5


