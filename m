Return-Path: <stable+bounces-56282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29091EA5A
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 23:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B43281FE5
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 21:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934534AEE0;
	Mon,  1 Jul 2024 21:30:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DE168D0
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.14.175.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869455; cv=none; b=Uh7k00RXpQnX3OoWzf/NGCbu+fEn7qJ0HdQrisTo3cboLhwGdYWDIVh9m4BkiNEJSVca+Ih7IlZBV9aR3faTqvw1qx811eCKO5I3zQOXGl/Itj9EIa60PbdkNtogMSW10HgpPA8j5dbpYs5ffIUMzeQkDhz8Ss6P4NTeEgfEefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869455; c=relaxed/simple;
	bh=9am9wAvncg0WRlJ2SaVkTN+MzMkpRF/6a3zvkSfw73U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM8538p6Jb2ST5ob3w6twDtyTfppzR8RuMkR0wgWpJg29BNBdiZ+nuSV54e/V7XHXQqjS9PCjjXAjX5qQUyg8vDvvGsT/weGSQC3QWZzBrVGTgcIbHRZsgslbEycjnIE9MVbTqhvMOumWEksa4M6rjeS2lnrUg/elYkChb1Hw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ruivo.org; spf=pass smtp.mailfrom=ruivo.org; arc=none smtp.client-ip=173.14.175.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ruivo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruivo.org
Received: by lobo.ruivo.org (Postfix, from userid 1011)
	id 97C2753425; Mon,  1 Jul 2024 17:23:46 -0400 (EDT)
X-Spam-Level: 
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
	by lobo.ruivo.org (Postfix) with ESMTPSA id 35EA8528DF;
	Mon,  1 Jul 2024 17:23:43 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
	id 2341F12014C; Mon, 01 Jul 2024 17:23:43 -0400 (EDT)
Date: Mon, 1 Jul 2024 17:23:43 -0400
From: Aristeu Rozanski <aris@ruivo.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vishal Moola <vishal.moola@gmail.com>,
	Aristeu Rozanski <aris@redhat.com>,
	Muchun Song <muchun.song@linux.dev>, stable@vger.kernel.org
Subject: [PATCH v2] hugetlb: force allocating surplus hugepages on mempolicy
 allowed nodes
Message-ID: <20240701212343.GG844599@cathedrallabs.org>
References: <20240621190050.mhxwb65zn37doegp@redhat.com>
 <20240621175609.9658bb023d6271125c685af8@linux-foundation.org>
 <20240625155438.98bfbac706b05d7ccc9b74a3@linux-foundation.org>
 <20240701191207.GB43545@cathedrallabs.org>
 <6683024a.050a0220.45e6c.7312@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6683024a.050a0220.45e6c.7312@mx.google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

When trying to allocate a hugepage with none reserved ones free, it may
be allowed in case a number of overcommit hugepages was configured (using
/proc/sys/vm/nr_overcommit_hugepages) and that number wasn't reached. This
allows for a behavior of having extra hugepages allocated dynamically, if
there're resources for it. Some sysadmins even prefer not reserving any
hugepages and setting a big number of overcommit hugepages.

But while attempting to allocate overcommit hugepages in a multi node
system (either NUMA or mempolicy/cpuset) said allocations might randomly
fail even when there're resources available for the allocation.

This happens due allowed_mems_nr() only accounting for the number of free hugepages
in the nodes the current process belongs to and the surplus hugepage allocation is
done so it can be allocated in any node. In case one or more of the requested
surplus hugepages are allocated in a different node, the whole allocation will fail
due allowed_mems_nr() returning a lower value.

So allocate surplus hugepages in one of the nodes the current process belongs to.

Easy way to reproduce this issue is to use a 2+ NUMA nodes system:

	# echo 0 >/proc/sys/vm/nr_hugepages
	# echo 1 >/proc/sys/vm/nr_overcommit_hugepages
	# numactl -m0 ./tools/testing/selftests/mm/map_hugetlb 2

Repeating the execution of map_hugetlb test application will eventually fail
when the hugepage ends up allocated in a different node.

v2: - attempt to make the description more clear
    - prevent unitialized usage of folio in case current process isn't part of any
      nodes with memory

Cc: Vishal Moola <vishal.moola@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Aristeu Rozanski <aris@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Aristeu Rozanski <aris@ruivo.org>

---
 mm/hugetlb.c |   47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

--- upstream.orig/mm/hugetlb.c	2024-06-20 13:42:25.699568114 -0400
+++ upstream/mm/hugetlb.c	2024-07-01 16:48:53.693298053 -0400
@@ -2618,6 +2618,23 @@ struct folio *alloc_hugetlb_folio_nodema
 	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
 }
 
+static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
+{
+#ifdef CONFIG_NUMA
+	struct mempolicy *mpol = get_task_policy(current);
+
+	/*
+	 * Only enforce MPOL_BIND policy which overlaps with cpuset policy
+	 * (from policy_nodemask) specifically for hugetlb case
+	 */
+	if (mpol->mode == MPOL_BIND &&
+		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
+		 cpuset_nodemask_valid_mems_allowed(&mpol->nodes)))
+		return &mpol->nodes;
+#endif
+	return NULL;
+}
+
 /*
  * Increase the hugetlb pool such that it can accommodate a reservation
  * of size 'delta'.
@@ -2631,6 +2648,8 @@ static int gather_surplus_pages(struct h
 	long i;
 	long needed, allocated;
 	bool alloc_ok = true;
+	int node;
+	nodemask_t *mbind_nodemask = policy_mbind_nodemask(htlb_alloc_mask(h));
 
 	lockdep_assert_held(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
@@ -2645,8 +2664,15 @@ allocated = 0;
 retry:
 	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
-		folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
-				NUMA_NO_NODE, NULL);
+		folio = NULL;
+		for_each_node_mask(node, cpuset_current_mems_allowed) {
+			if (!mbind_nodemask || node_isset(node, *mbind_nodemask)) {
+				folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
+						node, NULL);
+				if (folio)
+					break;
+			}
+		}
 		if (!folio) {
 			alloc_ok = false;
 			break;
@@ -4876,23 +4902,6 @@ default_hstate_max_huge_pages = 0;
 }
 __setup("default_hugepagesz=", default_hugepagesz_setup);
 
-static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
-{
-#ifdef CONFIG_NUMA
-	struct mempolicy *mpol = get_task_policy(current);
-
-	/*
-	 * Only enforce MPOL_BIND policy which overlaps with cpuset policy
-	 * (from policy_nodemask) specifically for hugetlb case
-	 */
-	if (mpol->mode == MPOL_BIND &&
-		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
-		 cpuset_nodemask_valid_mems_allowed(&mpol->nodes)))
-		return &mpol->nodes;
-#endif
-	return NULL;
-}
-
 static unsigned int allowed_mems_nr(struct hstate *h)
 {
 	int node;

