Return-Path: <stable+bounces-89967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE8B9BDC10
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD51EB225B5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14F1D47AC;
	Wed,  6 Nov 2024 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M//Tx/NO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E318F2DB;
	Wed,  6 Nov 2024 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859014; cv=none; b=BywBnvQO+7NMb9dMNWZGfq9lG8Wa+k8sW41hdEWdYvryP7gZuVO13/DLIrIicmCRpE6dJSaMowxd0lNEj6dx7swiJ6rboX+0NS4d9GX7qEAVgfhaIgDWQ/E8Gk2oA41zkvG+avWpnJkrYnPHbEGuuzylKFS7JMdUNvjnYyXC3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859014; c=relaxed/simple;
	bh=MRu7MqtpbNGk9SRbu0G0jcEfKspoZusy2eapm8Bawj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxrD+XWqqwxMxzVJZcuXTPPHfqV4gmDB+Na38imNX0jhwmUSlT9ouJ/i6pJwPfXgqo2rnsVsI8207AiiVxnalnG3iQeS5zTP0lvMvkJI6HNm931ZzIUSpeElzgs0av4rbQegrPiwYnciuqmAcqBfRLsJMF0kzx3IDpCoAWo6v/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M//Tx/NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337EFC4CECF;
	Wed,  6 Nov 2024 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859014;
	bh=MRu7MqtpbNGk9SRbu0G0jcEfKspoZusy2eapm8Bawj8=;
	h=From:To:Cc:Subject:Date:From;
	b=M//Tx/NOoegTXAaiRyIvSenqq/knpm8GuHtmg3aTuIu7esSJ7rGeClXUzIPjQGNj4
	 k5nf73pHRkqXi13Yyz5Fa7I055eQxGB/2J7mnFVM/LBP8/Oj0okD3FvncBuRgaj/nA
	 3umHk10oHH/xDmXpW0Bw/Pu89spid9WggrLX5fVMV4WA1tWleskooYkkD/KOu9vAIb
	 kCloMYLEmowhFCHhybvmhyVqsGM4AdJvkbawIScac8P7QEjXdHLSmPKJkZDcOTZ3vo
	 7r2sRyYyXO1UEicX9nOfvF9VqqfkFJC/aSR1fYP8CfjNuMZo0PXfNyNsmsxKMzyEGu
	 7iaT3E2EPDmGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yuzhao@google.com
Cc: James Houghton <jthoughton@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	David Stevens <stevensd@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Wei Xu <weixugc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "mm: multi-gen LRU: remove MM_LEAF_OLD and MM_NONLEAF_TOTAL stats" failed to apply to v6.1-stable tree
Date: Tue,  5 Nov 2024 21:10:10 -0500
Message-ID: <20241106021010.178546-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

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
---
 include/linux/mmzone.h |  2 --
 mm/vmscan.c            | 14 +++++---------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4a28355..9342e5692dab6 100644
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
index eb4e8440c5071..4f1d33e4b3601 100644
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
 
-- 
2.43.0





