Return-Path: <stable+bounces-164887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FEEB135E0
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3947F189825A
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBA7224B04;
	Mon, 28 Jul 2025 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYg5+KcZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32AB223316;
	Mon, 28 Jul 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689219; cv=none; b=k013xdJYgA/1p5pDhqqsOjqarrQ9RC9tWHUgt5D+z2XnsHyZZm8M0X+5zJdTg+oveUErzamggfsmyvuQIZ26VEJuKopb+ODtIVca3WSWS/6euK7F0Aw3Y2HC7kX1YtY3syzToAJSW/A/XM1pcvZcIcPb/BX6DKU/uW651WgU1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689219; c=relaxed/simple;
	bh=hRCz+9c49R5D5GyoBE0XZntVBGiECY0NqPqTn0DIBWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbEkhaXWiv/hqZ2aP2yjQWD1Qc+LLm3CsLWattxGumx+6IatfqT8N37eYFr58gZd27/+vM9Ytm04b2HTSlvWS0heW9ztn5/moRb3bj7qMQANVcXQrMBDjcflzElvoWZga1Z8ceoRFJaqR2pWt9dtHzKHyKIp+UF5rr7LCf0IdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYg5+KcZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235f9ea8d08so38829255ad.1;
        Mon, 28 Jul 2025 00:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753689217; x=1754294017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B8Pr14kyOYq72ydfGcY9GMR3PRaWiTWL7M2lo2XD5cc=;
        b=lYg5+KcZp0Gyc04y1+P5tUWLV57uhcFWNHbjNjEAl2+x/3nWeQyVwFnUYhkJDvPSCO
         8fZZTqV37ZKr/lV2kc6/MfDKn6clgxYmUkNHgo3WBwASf2jmc1R8JgUeHxtTJo6X9o2E
         JaAsC0ZnuzkKPn09Jd+VQLv4Y+dRPsSv7Y7hf2w4KK7pSabueyxz5ZtZ06XOdlemwPtA
         wzpANl04DgUat6Gff10JSt/T6+zpyS3vKBL+omqaJzw7Y/8Omz4fTcOCBx1lYmEObzBN
         LKI+xMpa/NPmlLLHOaZYA3mD1s9vZYx7v0gJUeEo9FkJTwry1qEvHUUE188jeBSmYEUP
         1ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689217; x=1754294017;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8Pr14kyOYq72ydfGcY9GMR3PRaWiTWL7M2lo2XD5cc=;
        b=URpjEZlxONjzOtuV/QlJb9tE1ISrN0LPG+zlVYpPfe0pekZoZMx6X/tffq9YRTcW5s
         sfIP/gNHCJGQzvVxtPdqdXzfTc6kaGqskHZkl3u/4LD140PPqAlEN+rFq2eOfSL18epx
         38wNuh4npQ1+MCXpA95NZt+PzLFsys+dJwZhZOmT1dDD6jVSeZVRvW+/CcbW1Oc0kMfi
         sLH978qOLvqtypgi8NwuRYYAlRlDnBb8cOoDCckFLHlwgECRMooLceGbpDcpJCH22V8u
         5+RTRFqS+SQ8dyNMKVkSekiANzpdbL9w8D/5vC1+qVNr9EfT8f7qHSjhMRo9lt6VkdUx
         DBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo3d0mqVhA9SxSBqj+cdPXYPKfHmk3EPmb1S2BRIZvlMSrwPr2giSHMmQXB9CFM3v8+2v+s06u@vger.kernel.org, AJvYcCWpE/KfA2/gZdFmpo8yTdQjRS5OfzobB/h4PMD0Wy+X79tv8vnePN9MIc9jU0yPDZlXZHCHLk0webQzGMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlYgXYTjhM3Es8nFDZ1V+w+ybIIMP8gqhUVroR2N7/EW99MVE
	wa1IcUG1x88v1Sk/WsWJ8NYgmqFE1UkLgwJrmh2sZPfDY6gj4mbo+HwF
X-Gm-Gg: ASbGnct9OE1LB2EVt4hd31NVQEiz5krBVpoXZBmblIcSaTMul9wfvdzBlQ94flmyXT2
	gQ6cQ/FV8TTvtsR/slpNOokouZ5JnJFqXycM93ik5NDLC9TN8SA/olK4gEnfXsNQyZqh/4BkdUw
	k71oXf0wJU8Av+7PN5+QSF30dCaWSgEMzeUfd3ZMA7OeWZyxV+auanhwZExJUq3wE82iDy0MTzA
	pqC2C7zSAJNdbxBs3oWyBFeJvXrxvQweQGm8DQ3MWyAfoVutspTYqHQav0ZHFfEbOD2GRe/gJTl
	6ZxqxHkHaUqXQ1tqzQqEC4JkHlRH47BW1GtE7rvGP7jv3RYmXKpj13fDB8qgnNdO48mh2VRdgnj
	csDYpONgCBFk0Rd9nfVs1RNTsJKkm2QzQEiHG
X-Google-Smtp-Source: AGHT+IEvIesUH1YbOiPROpyN5FUjpzPX3drCrroBBtxQEv/yuFOn6PDCSEDUoPJ7J0n+/n7q7KAmGg==
X-Received: by 2002:a17:902:da8b:b0:240:49d1:6347 with SMTP id d9443c01a7336-24049d16472mr5275355ad.35.1753689216928;
        Mon, 28 Jul 2025 00:53:36 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2a1sm20272305ad.4.2025.07.28.00.53.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Jul 2025 00:53:36 -0700 (PDT)
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
Subject: [PATCH v6 1/8] mm/shmem, swap: improve cached mTHP handling and fix potential hang
Date: Mon, 28 Jul 2025 15:52:59 +0800
Message-ID: <20250728075306.12704-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728075306.12704-1-ryncsn@gmail.com>
References: <20250728075306.12704-1-ryncsn@gmail.com>
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
 mm/shmem.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7570a24e0ae4..1d0fd266c29b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -891,7 +891,9 @@ static int shmem_add_to_page_cache(struct folio *folio,
 				   pgoff_t index, void *expected, gfp_t gfp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
-	long nr = folio_nr_pages(folio);
+	unsigned long nr = folio_nr_pages(folio);
+	swp_entry_t iter, swap;
+	void *entry;
 
 	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -903,14 +905,25 @@ static int shmem_add_to_page_cache(struct folio *folio,
 
 	gfp &= GFP_RECLAIM_MASK;
 	folio_throttle_swaprate(folio, gfp);
+	swap = radix_to_swp_entry(expected);
 
 	do {
+		iter = swap;
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
@@ -2359,7 +2372,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			error = -ENOMEM;
 			goto failed;
 		}
-	} else if (order != folio_order(folio)) {
+	} else if (order > folio_order(folio)) {
 		/*
 		 * Swap readahead may swap in order 0 folios into swapcache
 		 * asynchronously, while the shmem mapping can still stores
@@ -2384,15 +2397,23 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
 		}
+	} else if (order < folio_order(folio)) {
+		swap.val = round_down(swap.val, 1 << folio_order(folio));
+		index = round_down(index, 1 << folio_order(folio));
 	}
 
 alloced:
-	/* We have to do this with folio locked to prevent races */
+	/*
+	 * We have to do this with the folio locked to prevent races.
+	 * The shmem_confirm_swap below only checks if the first swap
+	 * entry matches the folio, that's enough to ensure the folio
+	 * is not used outside of shmem, as shmem swap entries
+	 * and swap cache folios are never partially freed.
+	 */
 	folio_lock(folio);
 	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
-	    folio->swap.val != swap.val ||
 	    !shmem_confirm_swap(mapping, index, swap) ||
-	    xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
+	    folio->swap.val != swap.val) {
 		error = -EEXIST;
 		goto unlock;
 	}
-- 
2.50.1


