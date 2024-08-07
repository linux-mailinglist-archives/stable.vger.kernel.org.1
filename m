Return-Path: <stable+bounces-65745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815A694ABB2
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A488D1C212BC
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF981751;
	Wed,  7 Aug 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qFcdxNz6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D278B4C;
	Wed,  7 Aug 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043293; cv=none; b=cAg8QxJOoFyZmr+EiCpDxRkH4cxXtTLLqSgbjPZCtzPvX3RYCLpnhguuG0YISyPMQGUGgzmHHaUrZb7zA1SQtb30EnANL3/jdmi6vtYjjFWWIwlwjMKu1PWzLLozXpOv455nFk2E/RyWTCy1Cn5N8kDXHPwX/d4HomKr10mkDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043293; c=relaxed/simple;
	bh=FwdZIQLljJgegx7JjEb6H6Ns4IaHttoSDkGCo9e81iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njLJPhBo07Pq6tQMKVyX7MYtiL0uHFClar7KucHLL7O1EMxCFmPowo74MTAnm6/O61oI+aKPEGS+BpceO0bZa+f4aZxcAk++XHlq4avtkWKAgAKO9CuRzhegjXymRCh/mBCHDeLuGncQULQiZm8X8sSW0D5wjb6uyj4LLt9cpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qFcdxNz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E0DC32781;
	Wed,  7 Aug 2024 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043293;
	bh=FwdZIQLljJgegx7JjEb6H6Ns4IaHttoSDkGCo9e81iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFcdxNz6lnPQjBKFDABz+QRrO6VuCZv2jrioZL7Du44ACgvfancpWYECRUtLH/UQE
	 HCPlRQxoA6pL8Qfhc2jU9FmwN1ZOiCQCNEghKINKcrTFE3d86T3tlzlmd7fMEpQzb2
	 ludUws923sSVu0j8eUibZbY/rz+kcv7o8tOr5DHo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Huang, Ying" <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <jweiner@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Pavel Tatashin <pasha.tatashin@soleen.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <cl@linux.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 037/121] mm: restrict the pcp batch scale factor to avoid too long latency
Date: Wed,  7 Aug 2024 16:59:29 +0200
Message-ID: <20240807150020.613231563@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
References: <20240807150019.412911622@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Ying <ying.huang@intel.com>

[ Upstream commit 52166607ecc980391b1fffbce0be3074a96d0c7b ]

In page allocator, PCP (Per-CPU Pageset) is refilled and drained in
batches to increase page allocation throughput, reduce page
allocation/freeing latency per page, and reduce zone lock contention.  But
too large batch size will cause too long maximal allocation/freeing
latency, which may punish arbitrary users.  So the default batch size is
chosen carefully (in zone_batchsize(), the value is 63 for zone > 1GB) to
avoid that.

In commit 3b12e7e97938 ("mm/page_alloc: scale the number of pages that are
batch freed"), the batch size will be scaled for large number of page
freeing to improve page freeing performance and reduce zone lock
contention.  Similar optimization can be used for large number of pages
allocation too.

To find out a suitable max batch scale factor (that is, max effective
batch size), some tests and measurement on some machines were done as
follows.

A set of debug patches are implemented as follows,

- Set PCP high to be 2 * batch to reduce the effect of PCP high

- Disable free batch size scaling to get the raw performance.

- The code with zone lock held is extracted from rmqueue_bulk() and
  free_pcppages_bulk() to 2 separate functions to make it easy to
  measure the function run time with ftrace function_graph tracer.

- The batch size is hard coded to be 63 (default), 127, 255, 511,
  1023, 2047, 4095.

Then will-it-scale/page_fault1 is used to generate the page
allocation/freeing workload.  The page allocation/freeing throughput
(page/s) is measured via will-it-scale.  The page allocation/freeing
average latency (alloc/free latency avg, in us) and allocation/freeing
latency at 99 percentile (alloc/free latency 99%, in us) are measured with
ftrace function_graph tracer.

The test results are as follows,

Sapphire Rapids Server
======================
Batch	throughput	free latency	free latency	alloc latency	alloc latency
	page/s		avg / us	99% / us	avg / us	99% / us
-----	----------	------------	------------	-------------	-------------
  63	513633.4	 2.33		 3.57		 2.67		  6.83
 127	517616.7	 4.35		 6.65		 4.22		 13.03
 255	520822.8	 8.29		13.32		 7.52		 25.24
 511	524122.0	15.79		23.42		14.02		 49.35
1023	525980.5	30.25		44.19		25.36		 94.88
2047	526793.6	59.39		84.50		45.22		140.81

Ice Lake Server
===============
Batch	throughput	free latency	free latency	alloc latency	alloc latency
	page/s		avg / us	99% / us	avg / us	99% / us
-----	----------	------------	------------	-------------	-------------
  63	620210.3	 2.21		 3.68		 2.02		 4.35
 127	627003.0	 4.09		 6.86		 3.51		 8.28
 255	630777.5	 7.70		13.50		 6.17		15.97
 511	633651.5	14.85		22.62		11.66		31.08
1023	637071.1	28.55		42.02		20.81		54.36
2047	638089.7	56.54		84.06		39.28		91.68

Cascade Lake Server
===================
Batch	throughput	free latency	free latency	alloc latency	alloc latency
	page/s		avg / us	99% / us	avg / us	99% / us
-----	----------	------------	------------	-------------	-------------
  63	404706.7	 3.29		  5.03		 3.53		  4.75
 127	422475.2	 6.12		  9.09		 6.36		  8.76
 255	411522.2	11.68		 16.97		10.90		 16.39
 511	428124.1	22.54		 31.28		19.86		 32.25
1023	414718.4	43.39		 62.52		40.00		 66.33
2047	429848.7	86.64		120.34		71.14		106.08

Commet Lake Desktop
===================
Batch	throughput	free latency	free latency	alloc latency	alloc latency
	page/s		avg / us	99% / us	avg / us	99% / us
-----	----------	------------	------------	-------------	-------------

  63	795183.13	 2.18		 3.55		 2.03		 3.05
 127	803067.85	 3.91		 6.56		 3.85		 5.52
 255	812771.10	 7.35		10.80		 7.14		10.20
 511	817723.48	14.17		27.54		13.43		30.31
1023	818870.19	27.72		40.10		27.89		46.28

Coffee Lake Desktop
===================
Batch	throughput	free latency	free latency	alloc latency	alloc latency
	page/s		avg / us	99% / us	avg / us	99% / us
-----	----------	------------	------------	-------------	-------------
  63	510542.8	 3.13		  4.40		 2.48		 3.43
 127	514288.6	 5.97		  7.89		 4.65		 6.04
 255	516889.7	11.86		 15.58		 8.96		12.55
 511	519802.4	23.10		 28.81		16.95		26.19
1023	520802.7	45.30		 52.51		33.19		45.95
2047	519997.1	90.63		104.00		65.26		81.74

>From the above data, to restrict the allocation/freeing latency to be less
than 100 us in most times, the max batch scale factor needs to be less
than or equal to 5.

Although it is reasonable to use 5 as max batch scale factor for the
systems tested, there are also slower systems.  Where smaller value should
be used to constrain the page allocation/freeing latency.

So, in this patch, a new kconfig option (PCP_BATCH_SCALE_MAX) is added to
set the max batch scale factor.  Whose default value is 5, and users can
reduce it when necessary.

Link: https://lkml.kernel.org/r/20231016053002.756205-5-ying.huang@intel.com
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 66eca1021a42 ("mm/page_alloc: fix pcp->count race between drain_pages_zone() vs __rmqueue_pcplist()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/Kconfig      | 11 +++++++++++
 mm/page_alloc.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 264a2df5ecf5b..ece4f2847e2b4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -704,6 +704,17 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 config CONTIG_ALLOC
 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
 
+config PCP_BATCH_SCALE_MAX
+	int "Maximum scale factor of PCP (Per-CPU pageset) batch allocate/free"
+	default 5
+	range 0 6
+	help
+	  In page allocator, PCP (Per-CPU pageset) is refilled and drained in
+	  batches.  The batch number is scaled automatically to improve page
+	  allocation/free throughput.  But too large scale factor may hurt
+	  latency.  This option sets the upper limit of scale factor to limit
+	  the maximum latency.
+
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e99d3223f0fc2..d3a2c4d3dc3eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2343,7 +2343,7 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
 	 * freeing of pages without any allocation.
 	 */
 	batch <<= pcp->free_factor;
-	if (batch < max_nr_free)
+	if (batch < max_nr_free && pcp->free_factor < CONFIG_PCP_BATCH_SCALE_MAX)
 		pcp->free_factor++;
 	batch = clamp(batch, min_nr_free, max_nr_free);
 
-- 
2.43.0




