Return-Path: <stable+bounces-122041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36B1A59D9B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAED16F8BB
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B08C22B8D0;
	Mon, 10 Mar 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pmyKgTZ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3661C5F1B;
	Mon, 10 Mar 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627359; cv=none; b=EIQ/TL1QPNAyjzFyWADfrlbe2Pwd3PpTktb3xVaPN/1oyS70sIPPsWWAf21m7zK3xiLPOkNUUwyOD8jjCztpFNMeWRY4gXkyn0KGkgh6emzxhCpqPqBFZeDGFuspqxtUKhEiZt/7oNws/aRqKvlH88LnaH4VLzoqUblXKz2iwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627359; c=relaxed/simple;
	bh=kS2UwP1qrX/HBgRv2XMBxbxdjdAAhzGZl+IEX4tyiYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh33jprJBdBRHuMYMOLexAotC5WRtmMZGoDUoqn/qRAbOTLYeOSEUrfz7AftLOZ30d6BABW5AGGqiWuwyDiTe2nsyJVZBZdBDPwp8CJk/EoZtDImSrqCurqQQE2o1qLyFNZ1KPPCstvXwgqRVcIFEk99VDXzB1zDkjCS1sHf6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pmyKgTZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6979DC4CEE5;
	Mon, 10 Mar 2025 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627358;
	bh=kS2UwP1qrX/HBgRv2XMBxbxdjdAAhzGZl+IEX4tyiYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmyKgTZ+VGI2ear0r1xTTZTqgWl5pzrVQtvBDQh2NmQdezFiQVtRPyAVko8O6fdIj
	 Miu1ebEI0f054juP2tnJPsSRMYp0sJfsr9iSIJCvbDoTocGlI0PC1zg7KrKQaGmNpv
	 1JIHaC0bwD1sa7YHeTd8zhH0wfIokrhhSmwkR2fg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 102/269] Revert "mm/page_alloc.c: dont show protection in zones ->lowmem_reserve[] for empty zone"
Date: Mon, 10 Mar 2025 18:04:15 +0100
Message-ID: <20250310170501.778027688@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriel Krisman Bertazi <krisman@suse.de>

commit eae116d1f0449ade3269ca47a67432622f5c6438 upstream.

Commit 96a5c186efff ("mm/page_alloc.c: don't show protection in zone's
->lowmem_reserve[] for empty zone") removes the protection of lower zones
from allocations targeting memory-less high zones.  This had an unintended
impact on the pattern of reclaims because it makes the high-zone-targeted
allocation more likely to succeed in lower zones, which adds pressure to
said zones.  I.e, the following corresponding checks in
zone_watermark_ok/zone_watermark_fast are less likely to trigger:

        if (free_pages <= min + z->lowmem_reserve[highest_zoneidx])
                return false;

As a result, we are observing an increase in reclaim and kswapd scans, due
to the increased pressure.  This was initially observed as increased
latency in filesystem operations when benchmarking with fio on a machine
with some memory-less zones, but it has since been associated with
increased contention in locks related to memory reclaim.  By reverting
this patch, the original performance was recovered on that machine.

The original commit was introduced as a clarification of the
/proc/zoneinfo output, so it doesn't seem there are usecases depending on
it, making the revert a simple solution.

For reference, I collected vmstat with and without this patch on a freshly
booted system running intensive randread io from an nvme for 5 minutes.  I
got:

rpm-6.12.0-slfo.1.2 ->  pgscan_kswapd 5629543865
Patched             ->  pgscan_kswapd 33580844

33M scans is similar to what we had in kernels predating this patch.
These numbers is fairly representative of the workload on this machine, as
measured in several runs.  So we are talking about a 2-order of magnitude
increase.

Link: https://lkml.kernel.org/r/20250226032258.234099-1-krisman@suse.de
Fixes: 96a5c186efff ("mm/page_alloc.c: don't show protection in zone's ->lowmem_reserve[] for empty zone")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/page_alloc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5991,11 +5991,10 @@ static void setup_per_zone_lowmem_reserv
 
 			for (j = i + 1; j < MAX_NR_ZONES; j++) {
 				struct zone *upper_zone = &pgdat->node_zones[j];
-				bool empty = !zone_managed_pages(upper_zone);
 
 				managed_pages += zone_managed_pages(upper_zone);
 
-				if (clear || empty)
+				if (clear)
 					zone->lowmem_reserve[j] = 0;
 				else
 					zone->lowmem_reserve[j] = managed_pages / ratio;



