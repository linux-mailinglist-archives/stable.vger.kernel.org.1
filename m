Return-Path: <stable+bounces-94326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 035D39D3C49
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1F6B22676
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797B71BBBE0;
	Wed, 20 Nov 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mG/bT7eZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7F1BB6BE;
	Wed, 20 Nov 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107670; cv=none; b=oLa3qiWBjnks+YTT52Oj71aPq63S6gpWKEO1WovSSdLL1cOq6/uZMQHUkvbbUC8+5XlFg9B4lPn2rp2tHcm/xZ6ODvvgSY+qCBSfFlL4mzIBVGkQkMUSVTUJsx1C7DSFY6uiPHIqLef5xbbK771JU8G0x30HXyhQp+HR/d8D7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107670; c=relaxed/simple;
	bh=kvJEMtPEAOJLI9/UnbpLEVSpArzJriYjsdsIaAnPU2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na7tdTa2ttNJn52nlh+ozxFP8K7rlDblMj8hgvDWQrTR5naBwdslUe+T42oAgx5+c0CM/c1tUu3QClyp1EfKkvrS+xNsDezaTZUtLFnyKTbYXC9EWEfu/DBvWuXwNia9cxSyN73irMnoGiObGt2BjPAEi5EZssK25LSqCMLkJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mG/bT7eZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D47C4CECD;
	Wed, 20 Nov 2024 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107670;
	bh=kvJEMtPEAOJLI9/UnbpLEVSpArzJriYjsdsIaAnPU2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mG/bT7eZMHe/bxJFCbybQcsORmdSeZeByqEFEhSw6Ao7tFy63GBfrIawXUy3a1XPV
	 eog5tYmxnkxNjhj38RDihfS5b6I3l5PNNhqnHncB1Qk8ARwxOkTkcCIYcl2qTYLNhE
	 3jkrlT0HCFS/lTC5FvYP+BGby8dece2BIFVStH0U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexander Lobakin <alobakin@pm.me>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Nanyong Sun <sunnanyong@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 17/73] mm: fix NULL pointer dereference in alloc_pages_bulk_noprof
Date: Wed, 20 Nov 2024 13:58:03 +0100
Message-ID: <20241120125810.034976545@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
References: <20241120125809.623237564@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjiang Tu <tujinjiang@huawei.com>

commit 8ce41b0f9d77cca074df25afd39b86e2ee3aa68e upstream.

We triggered a NULL pointer dereference for ac.preferred_zoneref->zone in
alloc_pages_bulk_noprof() when the task is migrated between cpusets.

When cpuset is enabled, in prepare_alloc_pages(), ac->nodemask may be
&current->mems_allowed.  when first_zones_zonelist() is called to find
preferred_zoneref, the ac->nodemask may be modified concurrently if the
task is migrated between different cpusets.  Assuming we have 2 NUMA Node,
when traversing Node1 in ac->zonelist, the nodemask is 2, and when
traversing Node2 in ac->zonelist, the nodemask is 1.  As a result, the
ac->preferred_zoneref points to NULL zone.

In alloc_pages_bulk_noprof(), for_each_zone_zonelist_nodemask() finds a
allowable zone and calls zonelist_node_idx(ac.preferred_zoneref), leading
to NULL pointer dereference.

__alloc_pages_noprof() fixes this issue by checking NULL pointer in commit
ea57485af8f4 ("mm, page_alloc: fix check for NULL preferred_zone") and
commit df76cee6bbeb ("mm, page_alloc: remove redundant checks from alloc
fastpath").

To fix it, check NULL pointer for preferred_zoneref->zone.

Link: https://lkml.kernel.org/r/20241113083235.166798-1-tujinjiang@huawei.com
Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexander Lobakin <alobakin@pm.me>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/page_alloc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5457,7 +5457,8 @@ unsigned long __alloc_pages_bulk(gfp_t g
 	gfp = alloc_gfp;
 
 	/* Find an allowed local zone that meets the low watermark. */
-	for_each_zone_zonelist_nodemask(zone, z, ac.zonelist, ac.highest_zoneidx, ac.nodemask) {
+	z = ac.preferred_zoneref;
+	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
 		unsigned long mark;
 
 		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&



