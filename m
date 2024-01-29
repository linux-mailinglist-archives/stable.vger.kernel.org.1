Return-Path: <stable+bounces-17116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5BE840FE3
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79232283290
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F1515EA83;
	Mon, 29 Jan 2024 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msnbx483"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086115EA8C;
	Mon, 29 Jan 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548523; cv=none; b=OSDrwN/d41Ge27EbnN/pyvktlhrErcDBrRcSOHA6aoKZlCQNhiGEdbaRXZNOwlacpQqfgVgEw5NycDX9JnpW9NdMaeRrDsENceKDPyhgJyWR0MuvG3hrVwjwDHIv2OTAGi+72YP5RInKxgg7wBpR7iJHNQDi8dQ0LaG81kdWtgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548523; c=relaxed/simple;
	bh=0sDZN+br8R3TqkFj87Ib69prPeoEGOU9WbfGb6VC3kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ur6eT+HL9cNAjC/G9b2dF7L+4Nw+WZp0kmphxeQ41qey9KQK/r6tbheSem0PPbwzcBgFp/G9y9y5O2ma3hHkTW5Q6tH3m/4nENJJ53NwbTgC1eCFt7t8FZgH6qm2pzBE+xgiHouEU6ec0TFbsW3xufWlkvXkP5D4g8b6Lb7at9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msnbx483; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1522C433C7;
	Mon, 29 Jan 2024 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548522;
	bh=0sDZN+br8R3TqkFj87Ib69prPeoEGOU9WbfGb6VC3kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msnbx483YMv3UtRqeEJUtRIT2uUF6zZeFTJ9swROewSbA5bVrsd8ujTTWMfu6ixef
	 e97zYFizRjMGbLgIDJjOuM5KRnJi8tjaSKNjDkayI9P5LRXN/zao0hjdJw+YS6ID0Q
	 tISswE6mXy0YlSFU9uuGmbIZUeFqK/K5TlUkIyGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 138/331] mm: page_alloc: unreserve highatomic page blocks before oom
Date: Mon, 29 Jan 2024 09:03:22 -0800
Message-ID: <20240129170018.982808411@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

From: Charan Teja Kalla <quic_charante@quicinc.com>

commit ac3f3b0a55518056bc80ed32a41931c99e1f7d81 upstream.

__alloc_pages_direct_reclaim() is called from slowpath allocation where
high atomic reserves can be unreserved after there is a progress in
reclaim and yet no suitable page is found.  Later should_reclaim_retry()
gets called from slow path allocation to decide if the reclaim needs to be
retried before OOM kill path is taken.

should_reclaim_retry() checks the available(reclaimable + free pages)
memory against the min wmark levels of a zone and returns:

a) true, if it is above the min wmark so that slow path allocation will
   do the reclaim retries.

b) false, thus slowpath allocation takes oom kill path.

should_reclaim_retry() can also unreserves the high atomic reserves **but
only after all the reclaim retries are exhausted.**

In a case where there are almost none reclaimable memory and free pages
contains mostly the high atomic reserves but allocation context can't use
these high atomic reserves, makes the available memory below min wmark
levels hence false is returned from should_reclaim_retry() leading the
allocation request to take OOM kill path.  This can turn into a early oom
kill if high atomic reserves are holding lot of free memory and
unreserving of them is not attempted.

(early)OOM is encountered on a VM with the below state:
[  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
local_pcp:492kB free_cma:0kB
[  295.998656] lowmem_reserve[]: 0 32
[  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
0*4096kB = 7752kB

Per above log, the free memory of ~7MB exist in the high atomic reserves
is not freed up before falling back to oom kill path.

Fix it by trying to unreserve the high atomic reserves in
should_reclaim_retry() before __alloc_pages_direct_reclaim() can fallback
to oom kill path.

Link: https://lkml.kernel.org/r/1700823445-27531-1-git-send-email-quic_charante@quicinc.com
Fixes: 0aaa29a56e4f ("mm, page_alloc: reserve pageblocks for high-order atomic allocations on demand")
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Reported-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: David Rientjes <rientjes@google.com>
Cc: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/page_alloc.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3809,14 +3809,9 @@ should_reclaim_retry(gfp_t gfp_mask, uns
 	else
 		(*no_progress_loops)++;
 
-	/*
-	 * Make sure we converge to OOM if we cannot make any progress
-	 * several times in the row.
-	 */
-	if (*no_progress_loops > MAX_RECLAIM_RETRIES) {
-		/* Before OOM, exhaust highatomic_reserve */
-		return unreserve_highatomic_pageblock(ac, true);
-	}
+	if (*no_progress_loops > MAX_RECLAIM_RETRIES)
+		goto out;
+
 
 	/*
 	 * Keep reclaiming pages while there is a chance this will lead
@@ -3859,6 +3854,11 @@ should_reclaim_retry(gfp_t gfp_mask, uns
 		schedule_timeout_uninterruptible(1);
 	else
 		cond_resched();
+out:
+	/* Before OOM, exhaust highatomic_reserve */
+	if (!ret)
+		return unreserve_highatomic_pageblock(ac, true);
+
 	return ret;
 }
 



