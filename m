Return-Path: <stable+bounces-161510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E69DAFF79B
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 05:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC7D5A160A
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 03:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5202A283FCE;
	Thu, 10 Jul 2025 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/ajQGDg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652802836B0;
	Thu, 10 Jul 2025 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118660; cv=none; b=FTJtc0FcPddsn5uVMfh+WJCvVXS3s0RkM8erngnxldQjKR/H4DLDermsOFfUqjCcfEUsoXly2Qr3aDN66cJ5OZJwgIlUEeBiVz66/lsPHFjAaUk1hPVqX3HMstmw+gJ/scOsZKyWV8j/Apd81r8B6t6+lrWmzQ8x6q9/MceaFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118660; c=relaxed/simple;
	bh=aHEKVPEcG65zMssaVDheCdyA1eEbVFSOQxSEcrZfmqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBJ8adxaXNGEMssi4OtKxA7l5Ss+nNR8Y0JhdFcq6Gxr4f9rOG0MD84lhISmck2sNhAGC/Apkf5v199Bn0xdmeEzkft9MBUl5Bbi6MP0XHMWaGXOAeaLpWcQy6BbqTxZcH17womJ9bBNQJpeq/hCGCk8pWDDep62LoT1HeRPcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/ajQGDg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b321bd36a41so591251a12.2;
        Wed, 09 Jul 2025 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752118658; x=1752723458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bl/mZF3g2hMilPsP1iGl5oIVwOLv3WwEcuUx0SZOALE=;
        b=A/ajQGDgNbUKcGihJcIMcdTFmJye03H0sZUF0WGlX4IF2ETe6V3P8Oi9Hp3VC4h+M5
         iwzL/4dY50Vsohvcceo2Sd0y9U2I1NV+J/rPOfMTHjbGvapUxDC0AMJjEm4jHtlFDtrD
         Q7nVkfl37p/yQqopOQLGn3r/pTBEAMxxlFNijW7mW5MTQeRBQ0f6FiJpsl3OZuh3oAAU
         YBZRbwdt5R8xdF6CMoEddPz2p8el9KZ+cPcF7qudEPWWGdaoPDK10/WkSyjE1t25w2P0
         VM47HV8w0jgEc4rkKd+oKNc6gsCHDNrrCntkOLWrLV77gHR3enz6GCMsmcoNvPrZ7kiC
         pHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118658; x=1752723458;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bl/mZF3g2hMilPsP1iGl5oIVwOLv3WwEcuUx0SZOALE=;
        b=RqsadSlrm5Cq4BykaYporFl1uWbbnUynHnlaeRIrR8WSQe/L8WTpGXlZbP7jh6PfjZ
         ZKZzzImYA2T8BzlSVLfiZbVYoQQ+fW/gmJvBHWfBmWPamkaVf6uhX13xAjCZfjZztVHm
         wLRnCjw3dGK0TSM5MDJmrN6zKKjMkNAp+YsO1NVvvAYxudIkYyO5DBPBGIZBAcMQiJv4
         XyIO5Z+8rO8Y67uOqRZfLZkQkNBEsaU64aD3hrEv0dzM87Wde6aMHEWrmvVMMrjthaIT
         3oPS9i0QfymIIkfkGHA5o2c3+HnaI2lf3PMbU6tvt6rLry+V3FmhnKC8gnOjLuE++yWl
         0Zkw==
X-Forwarded-Encrypted: i=1; AJvYcCV5yblfCofpa1aVeEAu+84HQVkAfFEYUdZtx1WmCcSVIx4OV+V9v9nQYRMsGesdpscXfUmL+TQgSz6fxGg=@vger.kernel.org, AJvYcCVKFFlJxr2vKOnrSUtqcRLyrqhf+bO3CEF2nEcbFos1XRiXQ+3Rf3iN8cMPXVciyKP7HGdtRnal@vger.kernel.org
X-Gm-Message-State: AOJu0YzAe55HyqUK3DwwhTGCyGNzj4OcpHr+gVpvlGk0VbzPf+pDUFtg
	R3Nqfh1j3zw4JM/oEP8aZaTxzHb9P4OdNDS8eDVovpOjva0reMZkfZEv
X-Gm-Gg: ASbGncsw5xNA8619aWZ98cEUIAlCW9hge42a1rnUI90wDR2XvPaVDR7ncsqEVRGpN7O
	5RqNaOb8SW57gPEymYVioO7hl0QMvAb9IIRxUhj9dTy7Wm5+xs+xvi5VgUDpgqLrvUQz5bPuFK/
	lLJNdWYPV7J5LWQVjbSs1f3M25mceqozWJxxnrmSn/V2DINGbY27M0BiJpKVamVE2V1eBe6utjp
	TnP4yKXpbrGiUYdkjX/IxeL4ZQeSQmHADomgmh5heTjq1ylfw3Fj26yde74dfB30euH133ax/BM
	3XI7caeaJTsApB+Y5ahLe6iBkL6APbMl/Qq332NjjjKc/JzoiPwlBEo8YIQrHMZH0OJQYhZVJa/
	Z
X-Google-Smtp-Source: AGHT+IHjm1osjfE3BDbqUtnApUOiVzDzZtYqYWPkiNlunBCJHYXm4X1KAkOQOJDiTMx24KRJxs5NqA==
X-Received: by 2002:a17:90b:1f8d:b0:311:ffe8:20e9 with SMTP id 98e67ed59e1d1-31c3f00b99bmr1966495a91.17.1752118657447;
        Wed, 09 Jul 2025 20:37:37 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300689aasm3716320a91.13.2025.07.09.20.37.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Jul 2025 20:37:36 -0700 (PDT)
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
Subject: [PATCH v5 1/8] mm/shmem, swap: improve cached mTHP handling and fix potential hung
Date: Thu, 10 Jul 2025 11:36:59 +0800
Message-ID: <20250710033706.71042-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710033706.71042-1-ryncsn@gmail.com>
References: <20250710033706.71042-1-ryncsn@gmail.com>
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
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


