Return-Path: <stable+bounces-62366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A353F93EE57
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FFB1F2510E
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C918002A;
	Mon, 29 Jul 2024 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="htYoMMSq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D96A8DB
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237569; cv=none; b=ZU9GEXXs9YjeuBdWhTF73Tb2j8TgR5m1QhA2heACmQw1r9mQwdTEUsqgLXm5dpMcNm6iqJo9fq+GFFSZskjem5bs9Hh5J/a8JjVZCSKaRPid0b0vKi0ZGeJlK4wo87mekPPgCwfyuZt8MSxSl5PCXMQae1SEfjRYDwSj/8nDhog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237569; c=relaxed/simple;
	bh=PyXTtllOcUNja0va9Pll0jKbRXV3vkPCuZc8TMZ66nM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xz7jnFqTKczRPUmyHPDVHkNnCKyPPhusc+NbCCWofVBdXLrDKlxP7Pz2OkiD7Zz68I+Lk3t48Y+KQuKRNfqXGO9AT+RHmr2mgKaqmzSq3U2KfJNIcrKx/p6Gr97UQfYTrayO+PIjotVd2gjciERCda6qFMoXMJyb6W6jalFbnxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=htYoMMSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81237C32786;
	Mon, 29 Jul 2024 07:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722237569;
	bh=PyXTtllOcUNja0va9Pll0jKbRXV3vkPCuZc8TMZ66nM=;
	h=Subject:To:Cc:From:Date:From;
	b=htYoMMSqFYMFtZdHQyDSiFO4bO/b2/h9iXunW6D+znXqOPSw2Q3rY1FJUnUeAI4P3
	 IpVs1Ab/xbE+LYrE0YtQqVe3iaQpS+lfIiQk3NqmG4AMyZ1TLxppfsNUu+DDECIoIG
	 uqhQtJbd5Bqlpot+y6s0YSBVf4BdAI+DWkbB5N3U=
Subject: FAILED: patch "[PATCH] mm: avoid overflows in dirty throttling logic" failed to apply to 6.10-stable tree
To: jack@suse.cz,akpm@linux-foundation.org,stable@vger.kernel.org,zokeefe@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:19:25 +0200
Message-ID: <2024072925-darling-chaplain-8e34@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 68ed2a394a0190433ba982b353579075a29099bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072925-darling-chaplain-8e34@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

68ed2a394a01 ("mm: avoid overflows in dirty throttling logic")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 68ed2a394a0190433ba982b353579075a29099bd Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Fri, 21 Jun 2024 16:42:38 +0200
Subject: [PATCH] mm: avoid overflows in dirty throttling logic

The dirty throttling logic is interspersed with assumptions that dirty
limits in PAGE_SIZE units fit into 32-bit (so that various multiplications
fit into 64-bits).  If limits end up being larger, we will hit overflows,
possible divisions by 0 etc.  Fix these problems by never allowing so
large dirty limits as they have dubious practical value anyway.  For
dirty_bytes / dirty_background_bytes interfaces we can just refuse to set
so large limits.  For dirty_ratio / dirty_background_ratio it isn't so
simple as the dirty limit is computed from the amount of available memory
which can change due to memory hotplug etc.  So when converting dirty
limits from ratios to numbers of pages, we just don't allow the result to
exceed UINT_MAX.

This is root-only triggerable problem which occurs when the operator
sets dirty limits to >16 TB.

Link: https://lkml.kernel.org/r/20240621144246.11148-2-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
Reported-by: Zach O'Keefe <zokeefe@google.com>
Reviewed-By: Zach O'Keefe <zokeefe@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c4aa6e84c20a..acff24e9fae4 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -417,13 +417,20 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 	else
 		bg_thresh = (bg_ratio * available_memory) / PAGE_SIZE;
 
-	if (bg_thresh >= thresh)
-		bg_thresh = thresh / 2;
 	tsk = current;
 	if (rt_task(tsk)) {
 		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
 		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
 	}
+	/*
+	 * Dirty throttling logic assumes the limits in page units fit into
+	 * 32-bits. This gives 16TB dirty limits max which is hopefully enough.
+	 */
+	if (thresh > UINT_MAX)
+		thresh = UINT_MAX;
+	/* This makes sure bg_thresh is within 32-bits as well */
+	if (bg_thresh >= thresh)
+		bg_thresh = thresh / 2;
 	dtc->thresh = thresh;
 	dtc->bg_thresh = bg_thresh;
 
@@ -473,7 +480,11 @@ static unsigned long node_dirty_limit(struct pglist_data *pgdat)
 	if (rt_task(tsk))
 		dirty += dirty / 4;
 
-	return dirty;
+	/*
+	 * Dirty throttling logic assumes the limits in page units fit into
+	 * 32-bits. This gives 16TB dirty limits max which is hopefully enough.
+	 */
+	return min_t(unsigned long, dirty, UINT_MAX);
 }
 
 /**
@@ -510,10 +521,17 @@ static int dirty_background_bytes_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
+	unsigned long old_bytes = dirty_background_bytes;
 
 	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
-	if (ret == 0 && write)
+	if (ret == 0 && write) {
+		if (DIV_ROUND_UP(dirty_background_bytes, PAGE_SIZE) >
+								UINT_MAX) {
+			dirty_background_bytes = old_bytes;
+			return -ERANGE;
+		}
 		dirty_background_ratio = 0;
+	}
 	return ret;
 }
 
@@ -539,6 +557,10 @@ static int dirty_bytes_handler(struct ctl_table *table, int write,
 
 	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write && vm_dirty_bytes != old_bytes) {
+		if (DIV_ROUND_UP(vm_dirty_bytes, PAGE_SIZE) > UINT_MAX) {
+			vm_dirty_bytes = old_bytes;
+			return -ERANGE;
+		}
 		writeback_set_ratelimit();
 		vm_dirty_ratio = 0;
 	}


