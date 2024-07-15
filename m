Return-Path: <stable+bounces-59336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE38931328
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520CF282A8E
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647AA189F2E;
	Mon, 15 Jul 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h5kEvDZj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C4188CBA
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043349; cv=none; b=kMsyig4Dp4XcHdY5ZRp1E5skSk0UnB4cHq/PDP2LbhamPx+yg0qj703r9jing2/wEmGBL3CZGk4HPVo2N1fa6lzcsFwUk6lwlH6niiTe9UXaPAmkmpia08yi2Myk37Ji/QEiA/+XZbhit5XT+U7u3R9H26zqPtfAsZ6zUp2fBaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043349; c=relaxed/simple;
	bh=fpbkIRfuG4oRgZNDciqE8LfNli9KYGTqw0coiCMJP2U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hR70as5+qFWjfcKgnCMsubU/crPkhCIx+6sl6VWRxCvJUL1H71hdMRZ8Du4yenw+0gsG6ygfzG7dOEKcmULzNynY59H3Fuger99zZh1VrmyOkjppgkXSWUq0hOii7HBfP7s8SWjTLF2pbREKuw7IsaubAP6vu6bNlILUa2WKQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h5kEvDZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1808C32782;
	Mon, 15 Jul 2024 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721043349;
	bh=fpbkIRfuG4oRgZNDciqE8LfNli9KYGTqw0coiCMJP2U=;
	h=Subject:To:Cc:From:Date:From;
	b=h5kEvDZjW5uVsZ4aj7HKLimN+yGamAG4uvnvP+u3u7K8vrwGBKbz2t400+D9YTG+r
	 IFcitVtDIgu3QhGW9EukGbG5+tdpCNjXuhk4hUN1trQunuFB15SfubdT+Ze+bodYW3
	 hm/pyDz372BAFVBkBqPBOWIvTVbDPIXwZgxnxA80=
Subject: FAILED: patch "[PATCH] mm/damon/core: merge regions aggressively when max_nr_regions" failed to apply to 5.15-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 13:34:47 +0200
Message-ID: <2024071546-swerve-grew-de52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071546-swerve-grew-de52@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 24 Jun 2024 10:58:14 -0700
Subject: [PATCH] mm/damon/core: merge regions aggressively when max_nr_regions
 is unmet

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

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6392f1cc97a3..e66823d6b10b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1358,14 +1358,31 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
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


