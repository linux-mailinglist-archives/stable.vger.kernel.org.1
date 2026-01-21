Return-Path: <stable+bounces-210730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BXoDle6cGmWZQAAu9opvQ
	(envelope-from <stable+bounces-210730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:36:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB8256198
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 12:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7221696932A
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71583E9F7E;
	Wed, 21 Jan 2026 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Y0e6i5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F23C00A0
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994892; cv=none; b=NbwcukZVJEKK9yHKFN+z5/VuSnh5NpU0ZhkDqnE/uMPGiplVp2EolxrgfMlG65cYKGA4lk9UVbw3XZESOHZz5L87mj9dDUNWUn6wBbFqYnwYNBD6GNT4p65aB8YFSWuhF1DlBGXglJWSSJPh/fZrpGHlE+/za+USnpOLxoa6ia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994892; c=relaxed/simple;
	bh=ggqqjAzE/3u7SEoaFqfMyqphv2ZLY8tfPMFmSgWqd1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYw4kXXhjaofCUd0BTIvrbtF7PtHWKso2YeON1lFdaDxcrGMj0a/N9nkYRrvjXnqTpk/gzusKdnsxi/vvldb8MHwiyMmamnRtckaXPdP2I/SYlpbEGk/0/E/+Mg5kGiZZLfpjdfhf3UfBWpX7v2MMhkCk7MVGf76wjEiF3xlMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Y0e6i5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA56C19424;
	Wed, 21 Jan 2026 11:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994891;
	bh=ggqqjAzE/3u7SEoaFqfMyqphv2ZLY8tfPMFmSgWqd1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/Y0e6i5R4bcGkTlpNKnrvI4VOlxh9LGi8esgMnpir3Wn5zxVeB8h18BrtOdLc2Tb
	 kSjvMUfSoqLhhAcq2zyG+RwwgtmwbvEnVfkTlUpMwYRqNo1khKymN9XL180Rc+dMTx
	 PM5V2XvAbYSHmxp/qA1Twj5hl+XidtQQLQa+nZU+nMBYiGZQBa9D8io7RvJEWq9CYJ
	 w1C2sjgPbfqbQCKGImXxy0QgvOR7lp3wr6kLiksMM4bwSsgWyb2ln7c7KaU5C10eN6
	 Jj5/Es517MsVRCjpVJYM1XMzUCm0LgDLVuw8aoiDKQ5iRJuf70wp2b4XzPmrKGTNj5
	 hp0SIpeiILsXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	SeongJae Park <sj@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Chris Mason <clm@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] mm/page_alloc/vmstat: simplify refresh_cpu_vm_stats change detection
Date: Wed, 21 Jan 2026 06:28:06 -0500
Message-ID: <20260121112808.1461983-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012041-wilder-jalapeno-0398@gregkh>
References: <2026012041-wilder-jalapeno-0398@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,google.com,fb.com,cmpxchg.org,shutemov.name,suse.com,nvidia.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-210730-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9DB8256198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Joshua Hahn <joshua.hahnjy@gmail.com>

[ Upstream commit 0acc67c4030c39f39ac90413cc5d0abddd3a9527 ]

Patch series "mm/page_alloc: Batch callers of free_pcppages_bulk", v5.

Motivation & Approach
=====================

While testing workloads with high sustained memory pressure on large
machines in the Meta fleet (1Tb memory, 316 CPUs), we saw an unexpectedly
high number of softlockups.  Further investigation showed that the zone
lock in free_pcppages_bulk was being held for a long time, and was called
to free 2k+ pages over 100 times just during boot.

This causes starvation in other processes for the zone lock, which can
lead to the system stalling as multiple threads cannot make progress
without the locks.  We can see these issues manifesting as warnings:

[ 4512.591979] rcu: INFO: rcu_sched self-detected stall on CPU
[ 4512.604370] rcu:     20-....: (9312 ticks this GP) idle=a654/1/0x4000000000000000 softirq=309340/309344 fqs=5426
[ 4512.626401] rcu:              hardirqs   softirqs   csw/system
[ 4512.638793] rcu:      number:        0        145            0
[ 4512.651177] rcu:     cputime:       30      10410          174   ==> 10558(ms)
[ 4512.666657] rcu:     (t=21077 jiffies g=783665 q=1242213 ncpus=316)

While these warnings don't indicate a crash or a kernel panic, they do
point to the underlying issue of lock contention.  To prevent starvation
in both locks, batch the freeing of pages using pcp->batch.

Because free_pcppages_bulk is called with the pcp lock and acquires the
zone lock, relinquishing and reacquiring the locks are only effective when
both of them are broken together (unless the system was built with queued
spinlocks).  Thus, instead of modifying free_pcppages_bulk to break both
locks, batch the freeing from its callers instead.

A similar fix has been implemented in the Meta fleet, and we have seen
significantly less softlockups.

Testing
=======
The following are a few synthetic benchmarks, made on three machines. The
first is a large machine with 754GiB memory and 316 processors.
The second is a relatively smaller machine with 251GiB memory and 176
processors. The third and final is the smallest of the three, which has 62GiB
memory and 36 processors.

On all machines, I kick off a kernel build with -j$(nproc).
Negative delta is better (faster compilation).

Large machine (754GiB memory, 316 processors)
make -j$(nproc)
+------------+---------------+-----------+
| Metric (s) | Variation (%) | Delta(%)  |
+------------+---------------+-----------+
| real       |        0.8070 |  - 1.4865 |
| user       |        0.2823 |  + 0.4081 |
| sys        |        5.0267 |  -11.8737 |
+------------+---------------+-----------+

Medium machine (251GiB memory, 176 processors)
make -j$(nproc)
+------------+---------------+----------+
| Metric (s) | Variation (%) | Delta(%) |
+------------+---------------+----------+
| real       |        0.2806 |  +0.0351 |
| user       |        0.0994 |  +0.3170 |
| sys        |        0.6229 |  -0.6277 |
+------------+---------------+----------+

Small machine (62GiB memory, 36 processors)
make -j$(nproc)
+------------+---------------+----------+
| Metric (s) | Variation (%) | Delta(%) |
+------------+---------------+----------+
| real       |        0.1503 |  -2.6585 |
| user       |        0.0431 |  -2.2984 |
| sys        |        0.1870 |  -3.2013 |
+------------+---------------+----------+

Here, variation is the coefficient of variation, i.e.  standard deviation
/ mean.

Based on these results, it seems like there are varying degrees to how
much lock contention this reduces.  For the largest and smallest machines
that I ran the tests on, it seems like there is quite some significant
reduction.  There is also some performance increases visible from
userspace.

Interestingly, the performance gains don't scale with the size of the
machine, but rather there seems to be a dip in the gain there is for the
medium-sized machine.  One possible theory is that because the high
watermark depends on both memory and the number of local CPUs, what
impacts zone contention the most is not these individual values, but
rather the ratio of mem:processors.

This patch (of 5):

Currently, refresh_cpu_vm_stats returns an int, indicating how many
changes were made during its updates.  Using this information, callers
like vmstat_update can heuristically determine if more work will be done
in the future.

However, all of refresh_cpu_vm_stats's callers either (a) ignore the
result, only caring about performing the updates, or (b) only care about
whether changes were made, but not *how many* changes were made.

Simplify the code by returning a bool instead to indicate if updates
were made.

In addition, simplify fold_diff and decay_pcp_high to return a bool
for the same reason.

Link: https://lkml.kernel.org/r/20251014145011.3427205-1-joshua.hahnjy@gmail.com
Link: https://lkml.kernel.org/r/20251014145011.3427205-2-joshua.hahnjy@gmail.com
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Chris Mason <clm@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 038a102535eb ("mm/page_alloc: prevent pcp corruption with SMP=n")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gfp.h |  2 +-
 mm/page_alloc.c     |  8 ++++----
 mm/vmstat.c         | 28 +++++++++++++++-------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index a951de920e208..bc59016743fb7 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -397,7 +397,7 @@ extern void page_frag_free(void *addr);
 #define free_page(addr) free_pages((addr), 0)
 
 void page_alloc_init_cpuhp(void);
-int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
+bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_all_pages(struct zone *zone);
 void drain_local_pages(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9d43bd47da263..6e1669a562946 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2363,10 +2363,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  * Called from the vmstat counter updater to decay the PCP high.
  * Return whether there are addition works to do.
  */
-int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
+bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
 	int high_min, to_drain, batch;
-	int todo = 0;
+	bool todo = false;
 
 	high_min = READ_ONCE(pcp->high_min);
 	batch = READ_ONCE(pcp->batch);
@@ -2379,7 +2379,7 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 		pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
 				 pcp->high - (pcp->high >> 3), high_min);
 		if (pcp->high > high_min)
-			todo++;
+			todo = true;
 	}
 
 	to_drain = pcp->count - pcp->high;
@@ -2387,7 +2387,7 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
 		spin_unlock(&pcp->lock);
-		todo++;
+		todo = true;
 	}
 
 	return todo;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3f41344239126..3ca572cbeaf1c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -768,25 +768,25 @@ EXPORT_SYMBOL(dec_node_page_state);
 
 /*
  * Fold a differential into the global counters.
- * Returns the number of counters updated.
+ * Returns whether counters were updated.
  */
 static int fold_diff(int *zone_diff, int *node_diff)
 {
 	int i;
-	int changes = 0;
+	bool changed = false;
 
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
 		if (zone_diff[i]) {
 			atomic_long_add(zone_diff[i], &vm_zone_stat[i]);
-			changes++;
+			changed = true;
 	}
 
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 		if (node_diff[i]) {
 			atomic_long_add(node_diff[i], &vm_node_stat[i]);
-			changes++;
+			changed = true;
 	}
-	return changes;
+	return changed;
 }
 
 /*
@@ -803,16 +803,16 @@ static int fold_diff(int *zone_diff, int *node_diff)
  * with the global counters. These could cause remote node cache line
  * bouncing and will have to be only done when necessary.
  *
- * The function returns the number of global counters updated.
+ * The function returns whether global counters were updated.
  */
-static int refresh_cpu_vm_stats(bool do_pagesets)
+static bool refresh_cpu_vm_stats(bool do_pagesets)
 {
 	struct pglist_data *pgdat;
 	struct zone *zone;
 	int i;
 	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
-	int changes = 0;
+	bool changed = false;
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
@@ -836,7 +836,8 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 		if (do_pagesets) {
 			cond_resched();
 
-			changes += decay_pcp_high(zone, this_cpu_ptr(pcp));
+			if (decay_pcp_high(zone, this_cpu_ptr(pcp)))
+				changed = true;
 #ifdef CONFIG_NUMA
 			/*
 			 * Deal with draining the remote pageset of this
@@ -858,13 +859,13 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			}
 
 			if (__this_cpu_dec_return(pcp->expire)) {
-				changes++;
+				changed = true;
 				continue;
 			}
 
 			if (__this_cpu_read(pcp->count)) {
 				drain_zone_pages(zone, this_cpu_ptr(pcp));
-				changes++;
+				changed = true;
 			}
 #endif
 		}
@@ -884,8 +885,9 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 		}
 	}
 
-	changes += fold_diff(global_zone_diff, global_node_diff);
-	return changes;
+	if (fold_diff(global_zone_diff, global_node_diff))
+		changed = true;
+	return changed;
 }
 
 /*
-- 
2.51.0


