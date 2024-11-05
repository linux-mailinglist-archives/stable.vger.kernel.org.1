Return-Path: <stable+bounces-89881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329BC9BD27D
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562281C21F2B
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26E1D89F3;
	Tue,  5 Nov 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1w5ahcim"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4817BED0
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824639; cv=none; b=Ej+ye3iAfVWlTf4MtigEp4FQpt+4ct6/8SeeNuB+nm8YA0pBDdWCrYL4CNjkHzvgTvTY/sMnJZCFi/dfyVEaUzvyM+W30dD/JWNo4gzy2Y/z3bW4RwFAWN9+NR+fQWNMV9Qb74e5aeQ6RAuRUk8ymZT3Ybf4iBdDi4AE/vlv5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824639; c=relaxed/simple;
	bh=LiOwElzB3RfJA3f8K6iQVsiUDXqyAebFA+Df6M1V4jw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D4eMc5Worp7YKyVgNV/WJHYHEtTD7TQERVbi/WMRMe5g1gRuqLwj+U+nNOaHgClC+DfYRpAnjBN8T/wyQS61EiJAYTwC41SP0m0pANlxn/RWYWbFYfNvhgyDFhb7QjQ7ARvdjdK6PPwnc9vKE/GbbgWOMBMCSz/9eoGYQ2gN23E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1w5ahcim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86804C4CECF;
	Tue,  5 Nov 2024 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730824638;
	bh=LiOwElzB3RfJA3f8K6iQVsiUDXqyAebFA+Df6M1V4jw=;
	h=Subject:To:Cc:From:Date:From;
	b=1w5ahcim03C4Hzkglm6CAqhdKns0vjCs3AzDljjYr3RgtM+ZxqfPHgNLTz1zUVlVa
	 N03o78/tK1PjKcrFtjhFsX+eJgD2dZ4b0XrG3K2mrx8lEs2bIK1VLlbbaYt+p9QxTu
	 CI7b6yeD/nmO9piVeP4aAkXmKMjPvIreMO+pQIPM=
Subject: FAILED: patch "[PATCH] mm: multi-gen LRU: remove MM_LEAF_OLD and MM_NONLEAF_TOTAL" failed to apply to 6.11-stable tree
To: yuzhao@google.com,akpm@linux-foundation.org,axelrasmussen@google.com,dmatlack@google.com,jthoughton@google.com,oliver.upton@linux.dev,pbonzini@redhat.com,rientjes@google.com,seanjc@google.com,stable@vger.kernel.org,stevensd@google.com,weixugc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:37:01 +0100
Message-ID: <2024110501-scrubber-eating-d64d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x ddd6d8e975b171ea3f63a011a75820883ff0d479
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110501-scrubber-eating-d64d@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ddd6d8e975b171ea3f63a011a75820883ff0d479 Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 19 Oct 2024 01:29:38 +0000
Subject: [PATCH] mm: multi-gen LRU: remove MM_LEAF_OLD and MM_NONLEAF_TOTAL
 stats

Patch series "mm: multi-gen LRU: Have secondary MMUs participate in
MM_WALK".

Today, the MM_WALK capability causes MGLRU to clear the young bit from
PMDs and PTEs during the page table walk before eviction, but MGLRU does
not call the clear_young() MMU notifier in this case.  By not calling this
notifier, the MM walk takes less time/CPU, but it causes pages that are
accessed mostly through KVM / secondary MMUs to appear younger than they
should be.

We do call the clear_young() notifier today, but only when attempting to
evict the page, so we end up clearing young/accessed information less
frequently for secondary MMUs than for mm PTEs, and therefore they appear
younger and are less likely to be evicted.  Therefore, memory that is
*not* being accessed mostly by KVM will be evicted *more* frequently,
worsening performance.

ChromeOS observed a tab-open latency regression when enabling MGLRU with a
setup that involved running a VM:

		Tab-open latency histogram (ms)
Version		p50	mean	p95	p99	max
base		1315	1198	2347	3454	10319
mglru		2559	1311	7399	12060	43758
fix		1119	926	2470	4211	6947

This series replaces the final non-selftest patchs from this series[1],
which introduced a similar change (and a new MMU notifier) with KVM
optimizations.  I'll send a separate series (to Sean and Paolo) for the
KVM optimizations.

This series also makes proactive reclaim with MGLRU possible for KVM
memory.  I have verified that this functions correctly with the selftest
from [1], but given that that test is a KVM selftest, I'll send it with
the rest of the KVM optimizations later.  Andrew, let me know if you'd
like to take the test now anyway.

[1]: https://lore.kernel.org/linux-mm/20240926013506.860253-18-jthoughton@google.com/


This patch (of 2):

The removed stats, MM_LEAF_OLD and MM_NONLEAF_TOTAL, are not very helpful
and become more complicated to properly compute when adding
test/clear_young() notifiers in MGLRU's mm walk.

Link: https://lkml.kernel.org/r/20241019012940.3656292-1-jthoughton@google.com
Link: https://lkml.kernel.org/r/20241019012940.3656292-2-jthoughton@google.com
Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Matlack <dmatlack@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: David Stevens <stevensd@google.com>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4a2835..9342e5692dab 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -458,9 +458,7 @@ struct lru_gen_folio {
 
 enum {
 	MM_LEAF_TOTAL,		/* total leaf entries */
-	MM_LEAF_OLD,		/* old leaf entries */
 	MM_LEAF_YOUNG,		/* young leaf entries */
-	MM_NONLEAF_TOTAL,	/* total non-leaf entries */
 	MM_NONLEAF_FOUND,	/* non-leaf entries found in Bloom filters */
 	MM_NONLEAF_ADDED,	/* non-leaf entries added to Bloom filters */
 	NR_MM_STATS
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eb4e8440c507..4f1d33e4b360 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3399,7 +3399,6 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 			continue;
 
 		if (!pte_young(ptent)) {
-			walk->mm_stats[MM_LEAF_OLD]++;
 			continue;
 		}
 
@@ -3552,7 +3551,6 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			walk->mm_stats[MM_LEAF_TOTAL]++;
 
 			if (!pmd_young(val)) {
-				walk->mm_stats[MM_LEAF_OLD]++;
 				continue;
 			}
 
@@ -3564,8 +3562,6 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			continue;
 		}
 
-		walk->mm_stats[MM_NONLEAF_TOTAL]++;
-
 		if (!walk->force_scan && should_clear_pmd_young()) {
 			if (!pmd_young(val))
 				continue;
@@ -5254,11 +5250,11 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 	for (tier = 0; tier < MAX_NR_TIERS; tier++) {
 		seq_printf(m, "            %10d", tier);
 		for (type = 0; type < ANON_AND_FILE; type++) {
-			const char *s = "   ";
+			const char *s = "xxx";
 			unsigned long n[3] = {};
 
 			if (seq == max_seq) {
-				s = "RT ";
+				s = "RTx";
 				n[0] = READ_ONCE(lrugen->avg_refaulted[type][tier]);
 				n[1] = READ_ONCE(lrugen->avg_total[type][tier]);
 			} else if (seq == min_seq[type] || NR_HIST_GENS > 1) {
@@ -5280,14 +5276,14 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 
 	seq_puts(m, "                      ");
 	for (i = 0; i < NR_MM_STATS; i++) {
-		const char *s = "      ";
+		const char *s = "xxxx";
 		unsigned long n = 0;
 
 		if (seq == max_seq && NR_HIST_GENS == 1) {
-			s = "LOYNFA";
+			s = "TYFA";
 			n = READ_ONCE(mm_state->stats[hist][i]);
 		} else if (seq != max_seq && NR_HIST_GENS > 1) {
-			s = "loynfa";
+			s = "tyfa";
 			n = READ_ONCE(mm_state->stats[hist][i]);
 		}
 


