Return-Path: <stable+bounces-176808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5B8B3DD7B
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EBC4413FA
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E48303C9D;
	Mon,  1 Sep 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="azuizNfH"
X-Original-To: stable@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2E2FFDDB;
	Mon,  1 Sep 2025 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717294; cv=none; b=ShQJ/V+zMFH8Oq677PgAihOnqLPbPPG1UDezUbh6oLwthig6moEe9FYmlUDxMAC13kSDFHZe+fSfXyWRk52VCcsdPQX5lSIm9yZ0MRnbhgNUInQEdst3BsyOGD43FRfcV48l8urSqqNDMUSHjLzGvln/eHdzibNAHJmqdh4YXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717294; c=relaxed/simple;
	bh=DmveVU/MnaZyGYU+Kvug6KJv7C/KbcI9vz1rPmmlMYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/4qDpjhZFjQOPkyPrbMCXGbyjN3/QDSf40BtOySzI9QJHB0ygCGn7Ylq2ygvn745Xf8s9LraeirDb15cQ41JCUCzGZTBBZaQ3H+7t43cfIe3GYH8hwRWciMqHfakitdrmQ76MBjcZ+tWNbfeadaiFyJ9TlEXV9m9tJgKa5IC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=azuizNfH; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1756717291; x=1788253291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DmveVU/MnaZyGYU+Kvug6KJv7C/KbcI9vz1rPmmlMYc=;
  b=azuizNfHJVq9AAWITn1fRu3cw+cGz6Pv3gTPhzeovhy0WXGb3CBPRSgo
   7Oz4sVv5p2YFUwhc627ZmPyHigc9iVoXzz8XZ9Gzj0t+eHUM9BiHTGiLe
   9OuR18Ni+Y2VvGW4cJ0jU6DX32qry+omujhKCR3HNOo7SvYnhprLJ6Xlp
   jI45kg6y6SYDireklYv/kHb3K4nC8qYbLcsqtuzrmhxtTRj/bhTKHE4fz
   Tah2QEtWiut4P+aISkqinyWzBKLeHEybqoQXLgmbsgNFygUZ3ClW1v+l8
   MlYaRmOsIEqtol1r+9j+MSz5St3sxPHzsLsjSNoht9Qcy7fjiYLi0HiL9
   w==;
X-CSE-ConnectionGUID: ozbhIcY0SDixj9NTVVWZAw==
X-CSE-MsgGUID: 4nBXj0PHRHCiBb/JAb5zDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="190167372"
X-IronPort-AV: E=Sophos;i="6.18,225,1751209200"; 
   d="scan'208";a="190167372"
Received: from unknown (HELO az2nlsmgr2.o.css.fujitsu.com) ([51.138.80.169])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 18:01:29 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id 45F522B83;
	Mon,  1 Sep 2025 09:01:29 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (az2uksmom3.o.css.fujitsu.com [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id EF62E100010B;
	Mon,  1 Sep 2025 09:01:28 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmom3.o.css.fujitsu.com (Postfix) with ESMTPS id B6A3A10005B6;
	Mon,  1 Sep 2025 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 349431A0071;
	Mon,  1 Sep 2025 17:01:23 +0800 (CST)
From: Ruan Shiyang <ruansy.fnst@fujitsu.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	lkp@intel.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	y-goto@fujitsu.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	mgorman@suse.de,
	vschneid@redhat.com,
	Li Zhijian <lizhijian@fujitsu.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ben Segall <bsegall@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm: memory-tiering: fix PGPROMOTE_CANDIDATE counting
Date: Mon,  1 Sep 2025 17:01:22 +0800
Message-ID: <20250901090122.124262-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
References: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Goto-san reported confusing pgpromote statistics where the
pgpromote_success count significantly exceeded pgpromote_candidate.

On a system with three nodes (nodes 0-1: DRAM 4GB, node 2: NVDIMM 4GB):
 # Enable demotion only
 echo 1 > /sys/kernel/mm/numa/demotion_enabled
 numactl -m 0-1 memhog -r200 3500M >/dev/null &
 pid=$!
 sleep 2
 numactl memhog -r100 2500M >/dev/null &
 sleep 10
 kill -9 $pid # terminate the 1st memhog
 # Enable promotion
 echo 2 > /proc/sys/kernel/numa_balancing

After a few seconds, we observeed `pgpromote_candidate < pgpromote_success`
$ grep -e pgpromote /proc/vmstat
pgpromote_success 2579
pgpromote_candidate 0

In this scenario, after terminating the first memhog, the conditions for
pgdat_free_space_enough() are quickly met, and triggers promotion.
However, these migrated pages are only counted for in PGPROMOTE_SUCCESS,
not in PGPROMOTE_CANDIDATE.

To solve these confusing statistics, introduce PGPROMOTE_CANDIDATE_NRL to
count the missed promotion pages.  And also, not counting these pages into
PGPROMOTE_CANDIDATE is to avoid changing the existing algorithm or
performance of the promotion rate limit.

Link: https://lkml.kernel.org/r/20250729035101.1601407-1-ruansy.fnst@fujitsu.com
Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
Reported-by: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>
Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Changes since v2:
  1. add 'Co-developed-by: Li Zhijian' followed by 'Signed-off-by' per Vlastimil.
---
 include/linux/mmzone.h | 16 +++++++++++++++-
 kernel/sched/fair.c    |  5 +++--
 mm/vmstat.c            |  1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0c5da9141983..9d3ea9085556 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -234,7 +234,21 @@ enum node_stat_item {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,	/* promote successfully */
-	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
+	/**
+	 * Candidate pages for promotion based on hint fault latency.  This
+	 * counter is used to control the promotion rate and adjust the hot
+	 * threshold.
+	 */
+	PGPROMOTE_CANDIDATE,
+	/**
+	 * Not rate-limited (NRL) candidate pages for those can be promoted
+	 * without considering hot threshold because of enough free pages in
+	 * fast-tier node.  These promotions bypass the regular hotness checks
+	 * and do NOT influence the promotion rate-limiter or
+	 * threshold-adjustment logic.
+	 * This is for statistics/monitoring purposes.
+	 */
+	PGPROMOTE_CANDIDATE_NRL,
 #endif
 	/* PGDEMOTE_*: pages demoted */
 	PGDEMOTE_KSWAPD,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..82c8d804c54c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1923,11 +1923,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
+		long nr = folio_nr_pages(folio);
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat)) {
 			/* workload changed, reset hot threshold */
 			pgdat->nbp_threshold = 0;
+			mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE_NRL, nr);
 			return true;
 		}
 
@@ -1941,8 +1943,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 		if (latency >= th)
 			return false;
 
-		return !numa_promotion_rate_limit(pgdat, rate_limit,
-						  folio_nr_pages(folio));
+		return !numa_promotion_rate_limit(pgdat, rate_limit, nr);
 	}
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 71cd1ceba191..e74f0b2a1021 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1280,6 +1280,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_NUMA_BALANCING
 	[I(PGPROMOTE_SUCCESS)]			= "pgpromote_success",
 	[I(PGPROMOTE_CANDIDATE)]		= "pgpromote_candidate",
+	[I(PGPROMOTE_CANDIDATE_NRL)]		= "pgpromote_candidate_nrl",
 #endif
 	[I(PGDEMOTE_KSWAPD)]			= "pgdemote_kswapd",
 	[I(PGDEMOTE_DIRECT)]			= "pgdemote_direct",
-- 
2.43.0


