Return-Path: <stable+bounces-169250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621F6B238D7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5C35A2247
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6F2D6619;
	Tue, 12 Aug 2025 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v4h8YQiZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830891E47AD;
	Tue, 12 Aug 2025 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026885; cv=none; b=u1dFdaw1/qsoPu92O3Er8tfViOaiJCA88DirDFBz0AArdlruQ8015NwhQbdfu0Yi1BmrJxN6FIOoGJDMZoma2AbJL8Dte9fJ9V538xFebEe3MCX0NvOQHtxe1rIEaR2oCUADj84miHsBR5zSwols2r0ro3eFmNFppyrbrq8nJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026885; c=relaxed/simple;
	bh=jEfyOIYdGAQ7ZGhzngX433zY6CewSHqKP5HMtwSJidw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB4q9Qzd0K6EB68JqFQWtCNBAyPq2ex56kEAncT3jzxIuQ5pY5DlerSKNFtrGqe+dzCce3APjP3sybqLiRbecrGlIX5GOXrEM1pO3GPoghhyeAaDtT4aNqASRYloFmyA/PxU6Q2QVr0HNVclMDegNRjJD2Mfs8akYskjvCBGEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v4h8YQiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8023C4CEF0;
	Tue, 12 Aug 2025 19:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026885;
	bh=jEfyOIYdGAQ7ZGhzngX433zY6CewSHqKP5HMtwSJidw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v4h8YQiZ7hhbft/1QFYVF22hb7Cufg2AAouoDIgh80KbIBY8Si6gtR2ZkFDetL7qD
	 c0bQwPWO1XceWustdKVt5mgYwqvjclxNSKYXHojFFHhTu06qtQeCswX7sV+iblVTea
	 ZckNf+s2efANvIYIUpJaOGKYcuvL+aqNdJR6Ca68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <bhe@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <kasong@tencent.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.15 468/480] mm: swap: correctly use maxpages in swapon syscall to avoid potential deadloop
Date: Tue, 12 Aug 2025 19:51:16 +0200
Message-ID: <20250812174416.687263940@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

commit 255116c5b0fa2145ede28c2f7b248df5e73834d1 upstream.

We use maxpages from read_swap_header() to initialize swap_info_struct,
however the maxpages might be reduced in setup_swap_extents() and the
si->max is assigned with the reduced maxpages from the
setup_swap_extents().

Obviously, this could lead to memory waste as we allocated memory based on
larger maxpages, besides, this could lead to a potential deadloop as
following:

1) When calling setup_clusters() with larger maxpages, unavailable
   pages within range [si->max, larger maxpages) are not accounted with
   inc_cluster_info_page().  As a result, these pages are assumed
   available but can not be allocated.  The cluster contains these pages
   can be moved to frag_clusters list after it's all available pages were
   allocated.

2) When the cluster mentioned in 1) is the only cluster in
   frag_clusters list, cluster_alloc_swap_entry() assume order 0
   allocation will never failed and will enter a deadloop by keep trying
   to allocate page from the only cluster in frag_clusters which contains
   no actually available page.

Call setup_swap_extents() to get the final maxpages before
swap_info_struct initialization to fix the issue.

After this change, span will include badblocks and will become large
value which I think is correct value:
In summary, there are two kinds of swapfile_activate operations.

1. Filesystem style: Treat all blocks logical continuity and find
   usable physical extents in logical range.  In this way, si->pages will
   be actual usable physical blocks and span will be "1 + highest_block -
   lowest_block".

2. Block device style: Treat all blocks physically continue and only
   one single extent is added.  In this way, si->pages will be si->max and
   span will be "si->pages - 1".  Actually, si->pages and si->max is only
   used in block device style and span value is set with si->pages.  As a
   result, span value in block device style will become a larger value as
   you mentioned.

I think larger value is correct based on:

1. Span value in filesystem style is "1 + highest_block -
   lowest_block" which is the range cover all possible phisical blocks
   including the badblocks.

2. For block device style, si->pages is the actual usable block number
   and is already in pr_info.  The original span value before this patch
   is also refer to usable block number which is redundant in pr_info.

[shikemeng@huaweicloud.com: ensure si->pages == si->max - 1 after setup_swap_extents()]
  Link: https://lkml.kernel.org/r/20250522122554.12209-3-shikemeng@huaweicloud.com
  Link: https://lkml.kernel.org/r/20250718065139.61989-1-shikemeng@huaweicloud.com
Link: https://lkml.kernel.org/r/20250522122554.12209-3-shikemeng@huaweicloud.com
Fixes: 661383c6111a ("mm: swap: relaim the cached parts that got scanned")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/swapfile.c |   53 ++++++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3138,43 +3138,30 @@ static unsigned long read_swap_header(st
 	return maxpages;
 }
 
-static int setup_swap_map_and_extents(struct swap_info_struct *si,
-					union swap_header *swap_header,
-					unsigned char *swap_map,
-					unsigned long maxpages,
-					sector_t *span)
+static int setup_swap_map(struct swap_info_struct *si,
+			  union swap_header *swap_header,
+			  unsigned char *swap_map,
+			  unsigned long maxpages)
 {
-	unsigned int nr_good_pages;
 	unsigned long i;
-	int nr_extents;
-
-	nr_good_pages = maxpages - 1;	/* omit header page */
 
+	swap_map[0] = SWAP_MAP_BAD; /* omit header page */
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 		if (page_nr == 0 || page_nr > swap_header->info.last_page)
 			return -EINVAL;
 		if (page_nr < maxpages) {
 			swap_map[page_nr] = SWAP_MAP_BAD;
-			nr_good_pages--;
+			si->pages--;
 		}
 	}
 
-	if (nr_good_pages) {
-		swap_map[0] = SWAP_MAP_BAD;
-		si->max = maxpages;
-		si->pages = nr_good_pages;
-		nr_extents = setup_swap_extents(si, span);
-		if (nr_extents < 0)
-			return nr_extents;
-		nr_good_pages = si->pages;
-	}
-	if (!nr_good_pages) {
+	if (!si->pages) {
 		pr_warn("Empty swap-file\n");
 		return -EINVAL;
 	}
 
-	return nr_extents;
+	return 0;
 }
 
 #define SWAP_CLUSTER_INFO_COLS						\
@@ -3214,7 +3201,7 @@ static struct swap_cluster_info *setup_c
 	 * Mark unusable pages as unavailable. The clusters aren't
 	 * marked free yet, so no list operations are involved yet.
 	 *
-	 * See setup_swap_map_and_extents(): header page, bad pages,
+	 * See setup_swap_map(): header page, bad pages,
 	 * and the EOF part of the last cluster.
 	 */
 	inc_cluster_info_page(si, cluster_info, 0);
@@ -3360,6 +3347,21 @@ SYSCALL_DEFINE2(swapon, const char __use
 		goto bad_swap_unlock_inode;
 	}
 
+	si->max = maxpages;
+	si->pages = maxpages - 1;
+	nr_extents = setup_swap_extents(si, &span);
+	if (nr_extents < 0) {
+		error = nr_extents;
+		goto bad_swap_unlock_inode;
+	}
+	if (si->pages != si->max - 1) {
+		pr_err("swap:%u != (max:%u - 1)\n", si->pages, si->max);
+		error = -EINVAL;
+		goto bad_swap_unlock_inode;
+	}
+
+	maxpages = si->max;
+
 	/* OK, set up the swap map and apply the bad block list */
 	swap_map = vzalloc(maxpages);
 	if (!swap_map) {
@@ -3371,12 +3373,9 @@ SYSCALL_DEFINE2(swapon, const char __use
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	nr_extents = setup_swap_map_and_extents(si, swap_header, swap_map,
-						maxpages, &span);
-	if (unlikely(nr_extents < 0)) {
-		error = nr_extents;
+	error = setup_swap_map(si, swap_header, swap_map, maxpages);
+	if (error)
 		goto bad_swap_unlock_inode;
-	}
 
 	/*
 	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might



