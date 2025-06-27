Return-Path: <stable+bounces-158733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B8AEAEF4
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 08:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3A71778A6
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF64204866;
	Fri, 27 Jun 2025 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atfME/wd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB690202C3A;
	Fri, 27 Jun 2025 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005367; cv=none; b=TEyPJSdPDVUIOR/POYTG/MBFC2K8MxRjuiao7GVfQGzI1XReVD4Nf+JgDT/nsWKK+izOwAusbFckdPasLTkXD4uJc3/a/Bm0ezb5Ig2PrI8I//l/kSbIeLwUQNkSZ0dBjSI6E7N584MYYK/uIywyuxI3S+cr+z//Xyw+gScdspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005367; c=relaxed/simple;
	bh=NR1Le/QeGmW3hnvTusfj4VqQPx1dEdIZ91YrkkAOqLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWpKPWyvx4bWextoxKeIuLcne48VAboFC0CYmOqUpVTkMTmxS0uUjqOKkSTfjEsdepnrFQjmSxn4alWNFb14x6/+KY/QY939qLq07so4Oyyy1QL+oOQ+ixRlt+XwieIb8H6QLAirxQL4iIJvJC55WSDvz06nT1joh5E156sbicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atfME/wd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748f5a4a423so1279194b3a.1;
        Thu, 26 Jun 2025 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751005365; x=1751610165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/lPSXdBTYyYcW2f1P/9Kus+D32Lno4t+GB7GicU1lE=;
        b=atfME/wdOkkQeOyrzLRDRI30piORfIfup+Fab6XCOfue9pY6u1dcIDSuANVxXyzgo2
         t82jvM5u04QS2zFRStBXVRdKDxK8F22qu6HLm/NwsBS94h6WknD/l3e4zufWJ2yI8TSw
         Igt5rFWXp3FS2PVUGHLyKgqByJ/Ln2ruLmE5tmh46ok5VpFxRMxZa30AL85PRzPSXZs4
         7JJm2tHseBHAKvy22efjEyZ0100VGE50O1BoghF9BjMXcf2zCDhXq/aH+nCnNB2yBmsF
         OpifxsxX92ouXDxgA428EP/drFJp5tPytP5dBKCI0VRWJQWsQ4oIxWGHMKvpa7KyRRfm
         oAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751005365; x=1751610165;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/lPSXdBTYyYcW2f1P/9Kus+D32Lno4t+GB7GicU1lE=;
        b=LpxSEBQ6Cdp+VVu7HbHxMwiaKtG9Ck0nNibcprgcCq+fa3Jbtc5xqd37war45jLk8Z
         StzkBsYlZ/igopeQ2cYxahoWtnTSiju1Qcydnt3X8cTCft5y+iaurc/xy5UxXaY2zeo/
         bOGr1HheTID2Lkv0DsNaQmD4ZXYqu3CZI1pA/YBY1AKqLP00hWj1i1wWIHmlFgGaUFd2
         RVNuos0lcIIKADu0cvOBkYlQYbpndU91GZgBsGbH1FRClELH9AOz8ORGwvqWXpBWDUXc
         k9bjTSZhEtocchOhMbo5gCoKG5A6DHA7kC15mfhmQYMBbNIIwibOJ1c/HHDq8wTOVAr6
         umjA==
X-Forwarded-Encrypted: i=1; AJvYcCVBQRwb9111usquD+0S2bSecbBFg10BJvjjPTfWKDw1UveVc7MUZTeJ8iwu3GsWeLBUeKynVpWZSUNKOhs=@vger.kernel.org, AJvYcCWZHwJ73vx5Q7jpDAnZpWaK7DBsMPFeLDmIka/uTrohDZ+qausVl37XfgPDwM4ziXihU2Ox3GdJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxCphIqhtTyJBsF3+m/1qqAU2hhu8/eJCjewUiU/ZfdvPCJ5FNE
	mRzyDMyFowUTOXWJpyFZ59GQ0mh0dy1/o3BxmrTON6RdXuNLeBXErcXq
X-Gm-Gg: ASbGncsbGzT6Iy1uySCfwWX2jlKuMKsb7CytmbdD8gwyS02juVRWR3P/D9TPxA+2Ymf
	s0VlacOQjP65ep66ThJNd2SEf9O+oZbewTaqxqkhl6pLxcGaSTGg1VENu+A+g6OD+ACEdTLwwoM
	WtlllNvXqGdZk/5F5CLfLTXFISGBW45oYWx6VqgvUMm7pgWUEwhL7gIda3yDWUXjteVMLgvNu8w
	xqA3mqBG+M4BYkEG3ISwyebVZDMO3s9Ri1idQVqnwaJ1CnBtQlMYXngSok1DOe2ttqk8I6drxUB
	bPRIUH0x5jXCBLW8BoRT/EOM7IDFdpcUC9e0XPx+3x786KgvJ9OvRP7pzsXMuy1mI1l+lxrArTO
	v
X-Google-Smtp-Source: AGHT+IEHehy1Nsijf5r8v/quVVBhH3AlbhVTvjTmjKxr/kL02DNDQ1CmikQ6GIVuWlF8J/CCf3tK0Q==
X-Received: by 2002:a05:6a00:2ea6:b0:748:3a1a:ba72 with SMTP id d2e1a72fcca58-74af701c716mr2887242b3a.20.1751005364750;
        Thu, 26 Jun 2025 23:22:44 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5409cb6sm1456212b3a.23.2025.06.26.23.22.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Jun 2025 23:22:44 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/7] mm/shmem, swap: improve cached mTHP handling and fix potential hung
Date: Fri, 27 Jun 2025 14:20:14 +0800
Message-ID: <20250627062020.534-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627062020.534-1-ryncsn@gmail.com>
References: <20250627062020.534-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The current swap-in code assumes that, when a swap entry in shmem mapping
is order 0, its cached folios (if present) must be order 0 too, which
turns out not always correct.

The problem is shmem_split_large_entry is called before verifying the
folio will eventually be swapped in, one possible race is:

    CPU1                          CPU2
shmem_swapin_folio
/* swap in of order > 0 swap entry S1 */
  folio = swap_cache_get_folio
  /* folio = NULL */
  order = xa_get_order
  /* order > 0 */
  folio = shmem_swap_alloc_folio
  /* mTHP alloc failure, folio = NULL */
  <... Interrupted ...>
                                 shmem_swapin_folio
                                 /* S1 is swapped in */
                                 shmem_writeout
                                 /* S1 is swapped out, folio cached */
  shmem_split_large_entry(..., S1)
  /* S1 is split, but the folio covering it has order > 0 now */

Now any following swapin of S1 will hang: `xa_get_order` returns 0, and
folio lookup will return a folio with order > 0.  The
`xa_get_order(&mapping->i_pages, index) != folio_order(folio)` will always
return false causing swap-in to return -EEXIST.

And this looks fragile.  So fix this up by allowing seeing a larger folio
in swap cache, and check the whole shmem mapping range covered by the
swapin have the right swap value upon inserting the folio.  And drop the
redundant tree walks before the insertion.

This will actually improve performance, as it avoids two redundant Xarray
tree walks in the hot path, and the only side effect is that in the
failure path, shmem may redundantly reallocate a few folios causing
temporary slight memory pressure.

And worth noting, it may seems the order and value check before inserting
might help reducing the lock contention, which is not true.  The swap
cache layer ensures raced swapin will either see a swap cache folio or
failed to do a swapin (we have SWAP_HAS_CACHE bit even if swap cache is
bypassed), so holding the folio lock and checking the folio flag is
already good enough for avoiding the lock contention.  The chance that a
folio passes the swap entry value check but the shmem mapping slot has
changed should be very low.

Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: <stable@vger.kernel.org>
---
 mm/shmem.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 334b7b4a61a0..e3c9a1365ff4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *folio,
 				   pgoff_t index, void *expected, gfp_t gfp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
-	long nr = folio_nr_pages(folio);
+	unsigned long nr = folio_nr_pages(folio);
+	swp_entry_t iter, swap;
+	void *entry;
 
 	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio *folio,
 
 	gfp &= GFP_RECLAIM_MASK;
 	folio_throttle_swaprate(folio, gfp);
+	swap = iter = radix_to_swp_entry(expected);
 
 	do {
 		xas_lock_irq(&xas);
-		if (expected != xas_find_conflict(&xas)) {
-			xas_set_err(&xas, -EEXIST);
-			goto unlock;
+		xas_for_each_conflict(&xas, entry) {
+			/*
+			 * The range must either be empty, or filled with
+			 * expected swap entries. Shmem swap entries are never
+			 * partially freed without split of both entry and
+			 * folio, so there shouldn't be any holes.
+			 */
+			if (!expected || entry != swp_to_radix_entry(iter)) {
+				xas_set_err(&xas, -EEXIST);
+				goto unlock;
+			}
+			iter.val += 1 << xas_get_order(&xas);
 		}
-		if (expected && xas_find_conflict(&xas)) {
+		if (expected && iter.val - nr != swap.val) {
 			xas_set_err(&xas, -EEXIST);
 			goto unlock;
 		}
@@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			error = -ENOMEM;
 			goto failed;
 		}
-	} else if (order != folio_order(folio)) {
+	} else if (order > folio_order(folio)) {
 		/*
 		 * Swap readahead may swap in order 0 folios into swapcache
 		 * asynchronously, while the shmem mapping can still stores
@@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
 		}
+	} else if (order < folio_order(folio)) {
+		swap.val = round_down(swap.val, 1 << folio_order(folio));
 	}
 
 alloced:
 	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
 	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
-	    folio->swap.val != swap.val ||
-	    !shmem_confirm_swap(mapping, index, swap) ||
-	    xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
+	    folio->swap.val != swap.val) {
 		error = -EEXIST;
 		goto unlock;
 	}
-- 
2.50.0


