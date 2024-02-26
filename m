Return-Path: <stable+bounces-23647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0D386719F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48826B24D19
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46155535BA;
	Mon, 26 Feb 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Slr+99S+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06313249EE
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943386; cv=none; b=LusnCgwdHm1q2LzV+hEyF2kOIJe8/TnPVRwX7+Ffb5ZbO+xF/gK8HRIyP4ONW08QUJuNTrT8ZEmKUq0DChMBILtUbpl0C9cBfLqhT3HpeQ+bWET1XPVwS2UiLiyp/E4YrMOccOEJ1kotALIOZH8PG0pmUhVRA/t7cQ/5RGoNdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943386; c=relaxed/simple;
	bh=4BUdbkRCKpbDTadquqd8sdqSYrprc/H6J2WOTQhFpwQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NJvH/BuMtjzB3B226MuD/XuVs4cSoBep7Ll6VsFWprncE57F2XuLqIwoolNeo9NYyLxJb6h5pIg17xVUqiLT0WlAaXcq/2sblBP5sINUHn7NeDONT/oHHEIlOSRMpAQUPfaG9/ZdXRoEgc1Ajmy4iSVSiUGVIk/xKyX8Lnloc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Slr+99S+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F538C433F1;
	Mon, 26 Feb 2024 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943385;
	bh=4BUdbkRCKpbDTadquqd8sdqSYrprc/H6J2WOTQhFpwQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Slr+99S+QJ/IIhBAVllvBEqfSdT6s1ZTubQsWRBVGfoEXolEYXF0NA9u21KlEKFyn
	 ys9x7Mn0B3a+kLi1JpdYBkmgpsVPbuUWSU+4JNses7FoUY17DKDCarIdrwTJiO8peE
	 2A5r4sIae+JT/X6c9xmH+BLFHwbJRNCz1w4uPf7o=
Subject: FAILED: patch "[PATCH] mm/damon/reclaim: fix quota stauts loss due to online tunings" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:29:43 +0100
Message-ID: <2024022643-scorn-filtrate-8677@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1b0ca4e4ff10a2c8402e2cf70132c683e1c772e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022643-scorn-filtrate-8677@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

1b0ca4e4ff10 ("mm/damon/reclaim: fix quota stauts loss due to online tunings")
66d9faec0745 ("mm/damon/reclaim: add a parameter called skip_anon for avoiding anonymous pages reclamation")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b0ca4e4ff10a2c8402e2cf70132c683e1c772e4 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Fri, 16 Feb 2024 11:40:24 -0800
Subject: [PATCH] mm/damon/reclaim: fix quota stauts loss due to online tunings

Patch series "mm/damon: fix quota status loss due to online tunings".

DAMON_RECLAIM and DAMON_LRU_SORT is not preserving internal quota status
when applying new user parameters, and hence could cause temporal quota
accuracy degradation.  Fix it by preserving the status.


This patch (of 2):

For online parameters change, DAMON_RECLAIM creates new scheme based on
latest values of the parameters and replaces the old scheme with the new
one.  When creating it, the internal status of the quota of the old
scheme is not preserved.  As a result, charging of the quota starts from
zero after the online tuning.  The data that collected to estimate the
throughput of the scheme's action is also reset, and therefore the
estimation should start from the scratch again.  Because the throughput
estimation is being used to convert the time quota to the effective size
quota, this could result in temporal time quota inaccuracy.  It would be
recovered over time, though.  In short, the quota accuracy could be
temporarily degraded after online parameters update.

Fix the problem by checking the case and copying the internal fields for
the status.

Link: https://lkml.kernel.org/r/20240216194025.9207-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20240216194025.9207-2-sj@kernel.org
Fixes: e035c280f6df ("mm/damon/reclaim: support online inputs update")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[5.19+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index ab974e477d2f..66e190f0374a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -150,9 +150,20 @@ static struct damos *damon_reclaim_new_scheme(void)
 			&damon_reclaim_wmarks);
 }
 
+static void damon_reclaim_copy_quota_status(struct damos_quota *dst,
+		struct damos_quota *src)
+{
+	dst->total_charged_sz = src->total_charged_sz;
+	dst->total_charged_ns = src->total_charged_ns;
+	dst->charged_sz = src->charged_sz;
+	dst->charged_from = src->charged_from;
+	dst->charge_target_from = src->charge_target_from;
+	dst->charge_addr_from = src->charge_addr_from;
+}
+
 static int damon_reclaim_apply_parameters(void)
 {
-	struct damos *scheme;
+	struct damos *scheme, *old_scheme;
 	struct damos_filter *filter;
 	int err = 0;
 
@@ -164,6 +175,11 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		return -ENOMEM;
+	if (!list_empty(&ctx->schemes)) {
+		damon_for_each_scheme(old_scheme, ctx)
+			damon_reclaim_copy_quota_status(&scheme->quota,
+					&old_scheme->quota);
+	}
 	if (skip_anon) {
 		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
 		if (!filter) {


