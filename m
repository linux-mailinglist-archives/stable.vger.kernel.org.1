Return-Path: <stable+bounces-127314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFCEA77915
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 12:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6A4188D76B
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B811E1C22;
	Tue,  1 Apr 2025 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DWbPUzop"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE89DF60
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504525; cv=none; b=AULVCA2sKpAa2KGcV3y0ZvWHOPv4Jg51eLiBLgoFqdCM8wBQJGbl+/Upfs2jmJsEsyhUP6jO0e9nOthO6Y8yESz8vYfgysBR+yoEe7oxrxNt4MlnidM2aUuxuYGAl79tahfzhtJQd30B1seRYHT/vV8ioutuYWExO7UM6UCXZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504525; c=relaxed/simple;
	bh=Q9i9jqFlg366Utbbr1XXoNm1TsWth+dlYBY6Mp5hDCM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FSWANCcQsAkct7mltprDWbOXjqBR64mAbfKgvTtNPvEm1PTu7e+e3QExQM9a6Tadwf5DjQLulyRFS/T28B2j2bPNFBDpCG8im+nSPOd/rAEm1ByeLowDs7pXQwV5YwjipQF0wYq/mQZ70Mt6DW085Xq2W3+CPn7TzaYvjxMnrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DWbPUzop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76ACC4CEE4;
	Tue,  1 Apr 2025 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743504524;
	bh=Q9i9jqFlg366Utbbr1XXoNm1TsWth+dlYBY6Mp5hDCM=;
	h=Subject:To:Cc:From:Date:From;
	b=DWbPUzopkXU/qPv2OZrjLXqk84uOuB6hIbgtFewUXJ23tDJ3GHdJUzxF7CMTK1fiN
	 +cuXme4YWzjiPMhR7liWttLV0jFSqg+jlCAMKbl7yW02j/9kadP1flc2NJhiIpnIXi
	 +4beU/cySC5gw9y7OONLleJ9W1QVVHoSZe30BYqo=
Subject: FAILED: patch "[PATCH] cgroup/rstat: Fix forceidle time in cpu.stat" failed to apply to 6.12-stable tree
To: wuyun.abel@bytedance.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Apr 2025 11:47:13 +0100
Message-ID: <2025040113-pellet-sanding-f62c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c4af66a95aa3bc1d4f607ebd4eea524fb58946e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040113-pellet-sanding-f62c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4af66a95aa3bc1d4f607ebd4eea524fb58946e3 Mon Sep 17 00:00:00 2001
From: Abel Wu <wuyun.abel@bytedance.com>
Date: Sun, 9 Feb 2025 14:13:11 +0800
Subject: [PATCH] cgroup/rstat: Fix forceidle time in cpu.stat

The commit b824766504e4 ("cgroup/rstat: add force idle show helper")
retrieves forceidle_time outside cgroup_rstat_lock for non-root cgroups
which can be potentially inconsistent with other stats.

Rather than reverting that commit, fix it in a way that retains the
effort of cleaning up the ifdef-messes.

Fixes: b824766504e4 ("cgroup/rstat: add force idle show helper")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 5877974ece92..c2784c317cdd 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -613,36 +613,33 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
 void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	u64 usage, utime, stime, ntime;
+	struct cgroup_base_stat bstat;
 
 	if (cgroup_parent(cgrp)) {
 		cgroup_rstat_flush_hold(cgrp);
-		usage = cgrp->bstat.cputime.sum_exec_runtime;
+		bstat = cgrp->bstat;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
-			       &utime, &stime);
-		ntime = cgrp->bstat.ntime;
+			       &bstat.cputime.utime, &bstat.cputime.stime);
 		cgroup_rstat_flush_release(cgrp);
 	} else {
-		/* cgrp->bstat of root is not actually used, reuse it */
-		root_cgroup_cputime(&cgrp->bstat);
-		usage = cgrp->bstat.cputime.sum_exec_runtime;
-		utime = cgrp->bstat.cputime.utime;
-		stime = cgrp->bstat.cputime.stime;
-		ntime = cgrp->bstat.ntime;
+		root_cgroup_cputime(&bstat);
 	}
 
-	do_div(usage, NSEC_PER_USEC);
-	do_div(utime, NSEC_PER_USEC);
-	do_div(stime, NSEC_PER_USEC);
-	do_div(ntime, NSEC_PER_USEC);
+	do_div(bstat.cputime.sum_exec_runtime, NSEC_PER_USEC);
+	do_div(bstat.cputime.utime, NSEC_PER_USEC);
+	do_div(bstat.cputime.stime, NSEC_PER_USEC);
+	do_div(bstat.ntime, NSEC_PER_USEC);
 
 	seq_printf(seq, "usage_usec %llu\n"
 			"user_usec %llu\n"
 			"system_usec %llu\n"
 			"nice_usec %llu\n",
-			usage, utime, stime, ntime);
+			bstat.cputime.sum_exec_runtime,
+			bstat.cputime.utime,
+			bstat.cputime.stime,
+			bstat.ntime);
 
-	cgroup_force_idle_show(seq, &cgrp->bstat);
+	cgroup_force_idle_show(seq, &bstat);
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */


