Return-Path: <stable+bounces-64348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59247941D87
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D5DB2945C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA91A76B1;
	Tue, 30 Jul 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2lSPi0oL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1091A76A4;
	Tue, 30 Jul 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359824; cv=none; b=kLjBiXatyEidUtWydltOrMWWLv2Y8U/15e97wkPuS21WiG281uxWfVSBzhjh84o1zwIX8coBNApqQe9AL52QGw3vhzPQCN/TywpKbUnSw/BM54yCWXZLEPrCvogM+TP9levTVCpCLmAJXvakdwkCn0eQ+W9tJ7boibR+eO/exjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359824; c=relaxed/simple;
	bh=91VKS8xERa/76gDKKShx6nAsNkFGMKb4+YRiuO02BZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbEfk/pr/eiIt+zP4QDnoky9bpgRLTsWXHlpQXbUJo69Bo7Jc5vyGnsu7PDTDRM2PIOE6pjE5xHSPXK0SYAxY57FRGJW2dy5+X3ziUOrva4sOrb0fUWrP1r41vuLzVuIPQr3MEtLfNQW356CcVJQq6prSylWqfRbExZpad1qjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2lSPi0oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F760C32782;
	Tue, 30 Jul 2024 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359824;
	bh=91VKS8xERa/76gDKKShx6nAsNkFGMKb4+YRiuO02BZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2lSPi0oL+Cuh42ySy+mnEBaQ/OGQm+s/9x2ERCepLAxpGtDa7TtRsj4BsJaXL1gjr
	 50enEZW+DZfgpkmx9upUWLaQf3cGR0zG27oURZ+GSVMoioWhZn2yz67KntrUf+ULk8
	 XguyjhMCtsfTdr9C87vZsH7KMxZF1nLiXlYQ0DrY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aristeu Rozanski <aris@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Aristeu Rozanski <aris@ruivo.org>,
	David Hildenbrand <david@redhat.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.10 536/809] hugetlb: force allocating surplus hugepages on mempolicy allowed nodes
Date: Tue, 30 Jul 2024 17:46:52 +0200
Message-ID: <20240730151745.912291150@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aristeu Rozanski <aris@redhat.com>

commit 003af997c8a945493859dd1a2d015cc9387ff27a upstream.

When trying to allocate a hugepage with no reserved ones free, it may be
allowed in case a number of overcommit hugepages was configured (using
/proc/sys/vm/nr_overcommit_hugepages) and that number wasn't reached.
This allows for a behavior of having extra hugepages allocated
dynamically, if there're resources for it.  Some sysadmins even prefer not
reserving any hugepages and setting a big number of overcommit hugepages.

But while attempting to allocate overcommit hugepages in a multi node
system (either NUMA or mempolicy/cpuset) said allocations might randomly
fail even when there're resources available for the allocation.

This happens due to allowed_mems_nr() only accounting for the number of
free hugepages in the nodes the current process belongs to and the surplus
hugepage allocation is done so it can be allocated in any node.  In case
one or more of the requested surplus hugepages are allocated in a
different node, the whole allocation will fail due allowed_mems_nr()
returning a lower value.

So allocate surplus hugepages in one of the nodes the current process
belongs to.

Easy way to reproduce this issue is to use a 2+ NUMA nodes system:

	# echo 0 >/proc/sys/vm/nr_hugepages
	# echo 1 >/proc/sys/vm/nr_overcommit_hugepages
	# numactl -m0 ./tools/testing/selftests/mm/map_hugetlb 2

Repeating the execution of map_hugetlb test application will eventually
fail when the hugepage ends up allocated in a different node.

[aris@ruivo.org: v2]
  Link: https://lkml.kernel.org/r/20240701212343.GG844599@cathedrallabs.org
Link: https://lkml.kernel.org/r/20240621190050.mhxwb65zn37doegp@redhat.com
Signed-off-by: Aristeu Rozanski <aris@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Aristeu Rozanski <aris@ruivo.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Vishal Moola <vishal.moola@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/hugetlb.c |   47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2586,6 +2586,23 @@ struct folio *alloc_hugetlb_folio_nodema
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
@@ -2599,6 +2616,8 @@ static int gather_surplus_pages(struct h
 	long i;
 	long needed, allocated;
 	bool alloc_ok = true;
+	int node;
+	nodemask_t *mbind_nodemask = policy_mbind_nodemask(htlb_alloc_mask(h));
 
 	lockdep_assert_held(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
@@ -2613,8 +2632,15 @@ static int gather_surplus_pages(struct h
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
@@ -4840,23 +4866,6 @@ static int __init default_hugepagesz_set
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



