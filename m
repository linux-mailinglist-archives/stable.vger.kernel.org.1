Return-Path: <stable+bounces-127383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EB9A788E9
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 09:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4573189100D
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 07:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7866230BD0;
	Wed,  2 Apr 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/C4RT49"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60561B7F4
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579564; cv=none; b=eBPEzKxtxxR6dpDUdqKV8FJNsx8sKRb1F4paeOxOvLJBPBZl+sQ6Ce8LoPEQgGt2YYh+h8P6N3ZllFN/jwvJazYgWzJtYoUtXAbq0sANa5GiWqj4juMUGahMX++oV7Esq9PrIpIMcVX66FDTICCy50Wlr4P4H0f6tqb6yAMb8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579564; c=relaxed/simple;
	bh=UMqFpCKfU89ezIGti4N8ol2rlRjUa9iDr+N2LyjsOdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnigWdh9OgYM3ks/DCJOr4hakCoGCGkSMtNdA2UeTrI2+gCFr4refUAxegoC6YtyGTHvzK0OkHe6fdL3hZ8ZGTOfNhBiiuUWU1JpErw7aQMNiSHa2Z641h8eGUEr1HUPKsTaumlBr5wT2pMMTHa9ZnQ06FiWHUsfPz8EdrXfI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/C4RT49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC12C4CEDD;
	Wed,  2 Apr 2025 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743579564;
	bh=UMqFpCKfU89ezIGti4N8ol2rlRjUa9iDr+N2LyjsOdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/C4RT49R7a2TFG2RSkuTSh7hwY1uAr7xlmV+L/TeJsf8ASqcDTjUieKoc2oCEO3n
	 596lQicbkfnaBpZvFwjNemSQE36sp5NXo0OCy1cFpVydpE/usSO6xE0RuxzEq95kip
	 P+T9Lu79428MBuZTS8wU7SxaCSJPr2TO5NcurGvEMEkMVzhVL2FR6MpkdvbHSw7Rle
	 kZ9eVTclZTeUsDQ1W6xZGO9tTxKXyrMf5EUwvH4XGPbLjulCgL8o2v50I5ttSsWphY
	 A6oeq7tnuO4ARSnxOC7ZbNW+aaJglWgdw2HsrUqRTfa5PrSihb60fnapFmXJEPHT7j
	 QAvHUnY0CQ4JA==
Date: Tue, 1 Apr 2025 21:39:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Request for backporting c4af66a95aa3 ("cgroup/rstat: Fix
 forceidle time in cpu.stat")
Message-ID: <Z-zpqngs7iRrb98V@slm.duckdns.org>
References: <Z9xWdxsAadLyp1SV@slm.duckdns.org>
 <2025040146-pennant-chain-0027@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025040146-pennant-chain-0027@gregkh>

On Tue, Apr 01, 2025 at 11:47:14AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 20, 2025 at 07:55:03AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > c4af66a95aa3 ("cgroup/rstat: Fix forceidle time in cpu.stat") fixes
> > b824766504e4 ("cgroup/rstat: add force idle show helper") and should be
> > backported to v6.11+ but I forgot to add the tag and the patch is currently
> > queued in cgroup/for-6.15. Once the cgroup pull request is merged, can you
> > please include the commit in -stable backports?
> 
> Included now in 6.13.y and 6.14.y queues, but fails to apply to 6.12.y,
> so can you send a backported version of that to us?

Here's the version for v6.12 and v6.11. Thanks.

From ff4f8b0e9e7ff0f534f7b95c7040ef254083265c Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 1 Apr 2025 21:26:03 -1000
Subject: [PATCH] cgroup/rstat: Fix forceidle time in cpu.stat

The commit b824766504e4 ("cgroup/rstat: add force idle show helper")
retrieves forceidle_time outside cgroup_rstat_lock for non-root cgroups
which can be potentially inconsistent with other stats.

Rather than reverting that commit, fix it in a way that retains the
effort of cleaning up the ifdef-messes.

Fixes: b824766504e4 ("cgroup/rstat: add force idle show helper")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/rstat.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index ce295b73c0a3..5f9121a3b7dd 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -607,32 +607,30 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
 void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	u64 usage, utime, stime;
+	struct cgroup_base_stat bstat;
 
 	if (cgroup_parent(cgrp)) {
 		cgroup_rstat_flush_hold(cgrp);
-		usage = cgrp->bstat.cputime.sum_exec_runtime;
+		bstat = cgrp->bstat;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
-			       &utime, &stime);
+			       &bstat.cputime.utime, &bstat.cputime.stime);
 		cgroup_rstat_flush_release(cgrp);
 	} else {
-		/* cgrp->bstat of root is not actually used, reuse it */
-		root_cgroup_cputime(&cgrp->bstat);
-		usage = cgrp->bstat.cputime.sum_exec_runtime;
-		utime = cgrp->bstat.cputime.utime;
-		stime = cgrp->bstat.cputime.stime;
+		root_cgroup_cputime(&bstat);
 	}
 
-	do_div(usage, NSEC_PER_USEC);
-	do_div(utime, NSEC_PER_USEC);
-	do_div(stime, NSEC_PER_USEC);
+	do_div(bstat.cputime.sum_exec_runtime, NSEC_PER_USEC);
+	do_div(bstat.cputime.utime, NSEC_PER_USEC);
+	do_div(bstat.cputime.stime, NSEC_PER_USEC);
 
 	seq_printf(seq, "usage_usec %llu\n"
 		   "user_usec %llu\n"
 		   "system_usec %llu\n",
-		   usage, utime, stime);
+		   bstat.cputime.sum_exec_runtime,
+		   bstat.cputime.utime,
+		   bstat.cputime.stime);
 
-	cgroup_force_idle_show(seq, &cgrp->bstat);
+	cgroup_force_idle_show(seq, &bstat);
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
-- 
2.49.0


