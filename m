Return-Path: <stable+bounces-92091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C77C9C3D66
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A025AB216D1
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B015747A;
	Mon, 11 Nov 2024 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pBbDWz/C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428F139578
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324876; cv=none; b=YFZDRrDMpLxrabGf3vQXGycOXJSu4ofCH297LRjGOtwOcR4YmLyAGTq55iYS+oQhNIWXVDaeS2EdXaIibG1/hxxsrTXhpfVcUyM3WRYOt4F3u3zPDI8RrSToOzrKz1i582mkHGYGtlXvCUoZF5Kxq1f0e2LhnlGGiVYeQMEOzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324876; c=relaxed/simple;
	bh=Cr9XY6CinnQBhBu63P0oI8ZtogQ+IIkCw2U3Ya/jWoM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lHsOKTuaqBIfhJAGMTB9ahRfNyrl1boJiGQGUJtUEYfcdjoerFjZ8obcNiU7Sgw4KUShYIyucAppL2ddjO01QqIS5bXt3QguGNpcF4ns/EhnvI+gt1uHoc/zwTNbENFti2utAMfaE85gxG9Yu/6ep5EegVM1/tduTBtFxL9dU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pBbDWz/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB786C4CECF;
	Mon, 11 Nov 2024 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731324876;
	bh=Cr9XY6CinnQBhBu63P0oI8ZtogQ+IIkCw2U3Ya/jWoM=;
	h=Subject:To:Cc:From:Date:From;
	b=pBbDWz/CvYZw7Vwq17RvirjGXJcGrr/CDHLIpaQIHkiEPSvceX9UJtCXw3cmv2UUB
	 vhuUb/Sxukpi1sDoInci1KGj035MSyc/KVw+G+k+2+mE54kiRmgTa/M+UnZFr7mJkl
	 5pwubd3Sa/nYQkzs4kdNKQkGrxdk09Schr/8UsN0=
Subject: FAILED: patch "[PATCH] mm/damon/core: handle zero {aggregation,ops_update} intervals" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Nov 2024 12:34:33 +0100
Message-ID: <2024111132-portal-crowbar-256b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3488af0970445ff5532c7e8dc5e6456b877aee5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111132-portal-crowbar-256b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3488af0970445ff5532c7e8dc5e6456b877aee5e Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Thu, 31 Oct 2024 11:37:56 -0700
Subject: [PATCH] mm/damon/core: handle zero {aggregation,ops_update} intervals

Patch series "mm/damon/core: fix handling of zero non-sampling intervals".

DAMON's internal intervals accounting logic is not correctly handling
non-sampling intervals of zero values for a wrong assumption.  This could
cause unexpected monitoring behavior, and even result in infinite hang of
DAMON sysfs interface user threads in case of zero aggregation interval.
Fix those by updating the intervals accounting logic.  For details of the
root case and solutions, please refer to commit messages of fixes.


This patch (of 2):

DAMON's logics to determine if this is the time to do aggregation and ops
update assumes next_{aggregation,ops_update}_sis are always set larger
than current passed_sample_intervals.  And therefore it further assumes
continuously incrementing passed_sample_intervals every sampling interval
will make it reaches to the next_{aggregation,ops_update}_sis in future.
The logic therefore make the action and update
next_{aggregation,ops_updaste}_sis only if passed_sample_intervals is same
to the counts, respectively.

If Aggregation interval or Ops update interval are zero, however,
next_aggregation_sis or next_ops_update_sis are set same to current
passed_sample_intervals, respectively.  And passed_sample_intervals is
incremented before doing the next_{aggregation,ops_update}_sis check.
Hence, passed_sample_intervals becomes larger than
next_{aggregation,ops_update}_sis, and the logic says it is not the time
to do the action and update next_{aggregation,ops_update}_sis forever,
until an overflow happens.  In other words, DAMON stops doing aggregations
or ops updates effectively forever, and users cannot get monitoring
results.

Based on the documents and the common sense, a reasonable behavior for
such inputs is doing an aggregation and an ops update for every sampling
interval.  Handle the case by removing the assumption.

Note that this could incur particular real issue for DAMON sysfs interface
users, in case of zero Aggregation interval.  When user starts DAMON with
zero Aggregation interval and asks online DAMON parameter tuning via DAMON
sysfs interface, the request is handled by the aggregation callback.
Until the callback finishes the work, the user who requested the online
tuning just waits.  Hence, the user will be stuck until the
passed_sample_intervals overflows.

Link: https://lkml.kernel.org/r/20241031183757.49610-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20241031183757.49610-2-sj@kernel.org
Fixes: 4472edf63d66 ("mm/damon/core: use number of passed access sampling as a timer")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.7.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a83f3b736d51..3131a07569e4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2000,7 +2000,7 @@ static int kdamond_fn(void *data)
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
-		if (ctx->passed_sample_intervals == next_aggregation_sis) {
+		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
@@ -2018,7 +2018,7 @@ static int kdamond_fn(void *data)
 
 		sample_interval = ctx->attrs.sample_interval ?
 			ctx->attrs.sample_interval : 1;
-		if (ctx->passed_sample_intervals == next_aggregation_sis) {
+		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
 			ctx->next_aggregation_sis = next_aggregation_sis +
 				ctx->attrs.aggr_interval / sample_interval;
 
@@ -2028,7 +2028,7 @@ static int kdamond_fn(void *data)
 				ctx->ops.reset_aggregated(ctx);
 		}
 
-		if (ctx->passed_sample_intervals == next_ops_update_sis) {
+		if (ctx->passed_sample_intervals >= next_ops_update_sis) {
 			ctx->next_ops_update_sis = next_ops_update_sis +
 				ctx->attrs.ops_update_interval /
 				sample_interval;


