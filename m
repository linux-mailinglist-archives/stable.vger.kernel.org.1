Return-Path: <stable+bounces-154819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82BEAE0C29
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 19:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFE33B61A3
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7EA28DB63;
	Thu, 19 Jun 2025 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grmx4wBI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F228D8F3;
	Thu, 19 Jun 2025 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355752; cv=none; b=VV73GewNAUqjRWRJt7LU2DsQVGRdH3u4LA0wZ0vH7Uu7AX5fjQDl4lKYjh/AMU+aOkOEgI1AX7qP9FFeqFxsZSQR3NoPpdZZeMLcZB3Azg+9aIC3smYsx5ZKaP8BQPtL3KPUnuk8A1eBRUJowtmRKfT/rPMhlvXo3nmEXKIBL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355752; c=relaxed/simple;
	bh=Etb+1G0dKFWlHJP7I3ksVIxEPevKNJNx0/hd6w0pTQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqQTbBjl9voTNr/Ezfi4lG9+28KHqS0LCYkoNp2nD1AB09Qmw/qo61cq5COUrC9hSd/xx0potdClyl24IjCIbKBezRs4zKsfT7iJn06VPtNkKB9A2+xyOL8NRlJNvKiurFBcYV6oOE/fttN69DqglwVabgAkR95d2vHdFPEH5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Grmx4wBI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2352400344aso10354695ad.2;
        Thu, 19 Jun 2025 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750355750; x=1750960550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G6U4jlRW51IhrAkyNdYr7Hbh7uPerEcOuqvZV/VaVHo=;
        b=Grmx4wBI6pxbMG8xN/zk/bGhzWg6IaliOh+K6astjxu2brbfD6lyLExb5A6sSgWR70
         80MmpuTmBrGRW7pZWnAeBrxqq8GQQaN1lGkJIK8GoKe2QnAnBy4/24YuIkC/gquaFWcM
         2XRwo8SAwaVsHH0b4CWxOLPg7USzxjhIHiOTUjY03yTZb81+gMLo+m+c4PXYvC1J1mk6
         eFJxZ/HDGD3FUO07wN+YQQK1I6vOVoNofkU42zg4Xs/97VcHs/Yc8VbwfN8OBFqRy7SS
         Fw6ARPU8b9eke9TY5J7JsCtOKe39chjAc1QoxFOYqUE2TVb0lkcm1NlHEOxPFpqb+rqF
         DYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750355750; x=1750960550;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6U4jlRW51IhrAkyNdYr7Hbh7uPerEcOuqvZV/VaVHo=;
        b=F7rUhbJWvVpb97XPLKN6EDtb0+AjvIuf0GVJzGD7XFd/X47HcHzJEhohfBFuJLeU5e
         sv4gjAspLra+vE4Dc6amQE9F77Z93UBPpJIKIVsAWF8jnbClWI+MsLbqdF02zbkfMhwu
         zONCZaBXLmS8M7HtZq8a/1bpCLwtbv61mq7k7e+tbdyu+WZD/HjyothXP/0eVu6tKwE3
         XwQCaPzXHit7nQ8p7ZwzB9gZofQ/L0QoqDDmL2du4ZmtNDLMDnZEEF3xZJXaQmm8SgfF
         GFaN0u1qyCmCxJSFh1LUf0Hmsb+INMdBeooFyvSXBfv1tz+9CsL43LHmik3KsnU3SpdX
         iunA==
X-Forwarded-Encrypted: i=1; AJvYcCW3CLe/eBCxWpsvQVb/rBIAToQj4dymFDpMkG+ZBdccETx4BE2KKiABi6pvg086AqccZwSsXqgG+H2eyS8=@vger.kernel.org, AJvYcCWnVKUlCfe+BPZOTrfF0tvKxUivc08M/MOIH7iQbTNVSvT5vCOTejwkA6tspwMan0YFv7XrQtkN@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXgupkEI+2E5f36E5Wx2HeKjeNsnNbLShLaO/zxVqmqSBGZ76
	+loJhRG266OlIN44gLRR/8GxOaQB9//AR2Va7a3zSfT/07noNEyZDPHA
X-Gm-Gg: ASbGncsd4TLyH+aH6RSvSI8JqL8umSxihMF8ZC0z6LvSQkj9ykfZFrgjbHnuHQ+i5MK
	ftMxlWvYopTHNNpinGY9B6DjlFtVRfwp1Fl2iUoCvNOxJYXAqX92WUUkv092GspU4T3Y+5QN90H
	D/Q6ltqdE2rC/yWvN75gfNZLZTA8HWsIjFZPe+NZP6irlEdS9KCeNIiKt0Vx48JL51YjgPKRpvb
	bMygWNZy7DhkvDOq71A7l/ZkTv/lPQx9D+4OAchWYld7kZtVh0seKpV/NxNkSnosLzx1FQeWK8J
	tOXqogW1tRACB4nSidjzNSnsB9URwsk3MUL6z0v4Op7cdrquS1Mrr2EGTDGJUdN3ItFuzhZ2CoR
	We20OjcKCsDhumtgaIg==
X-Google-Smtp-Source: AGHT+IGSMiUkLVaHEY0qpn7YhOq9nmtfFgzCs7eZSl+BsvEKujzwRfUJdWREe52x5B5NCsObb9RRRA==
X-Received: by 2002:a17:902:7b8c:b0:234:8ef1:aa7b with SMTP id d9443c01a7336-2366afe7f06mr238436175ad.20.1750355749765;
        Thu, 19 Jun 2025 10:55:49 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83efa44sm255215ad.77.2025.06.19.10.55.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 10:55:49 -0700 (PDT)
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
Subject: [PATCH v2 1/4] mm/shmem, swap: improve cached mTHP handling and fix potential hung
Date: Fri, 20 Jun 2025 01:55:35 +0800
Message-ID: <20250619175538.15799-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250619175538.15799-1-ryncsn@gmail.com>
References: <20250619175538.15799-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The current swap-in code assumes that, when a swap entry in shmem
mapping is order 0, its cached folios (if present) must be order 0
too, which turns out not always correct.

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

Now any following swapin of S1 will hang: `xa_get_order` returns 0,
and folio lookup will return a folio with order > 0. The
`xa_get_order(&mapping->i_pages, index) != folio_order(folio)` will
always return false causing swap-in to return -EEXIST.

And this looks fragile. So fix this up by allowing seeing a larger folio
in swap cache, and check the whole shmem mapping range covered by the
swapin have the right swap value upon inserting the folio. And drop
the redundant tree walks before the insertion.

This will actually improve the performance, as it avoided two redundant
Xarray tree walks in the hot path, and the only side effect is that in
the failure path, shmem may redundantly reallocate a few folios
causing temporary slight memory pressure.

And worth noting, it may seems the order and value check before
inserting might help reducing the lock contention, which is not true.
The swap cache layer ensures raced swapin will either see a swap cache
folio or failed to do a swapin (we have SWAP_HAS_CACHE bit even if
swap cache is bypassed), so holding the folio lock and checking the
folio flag is already good enough for avoiding the lock contention.
The chance that a folio passes the swap entry value check but the
shmem mapping slot has changed should be very low.

Cc: stable@vger.kernel.org
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/shmem.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index eda35be2a8d9..4e7ef343a29b 100644
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
+		swap.val = round_down(swp_type(swap), folio_order(folio));
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


