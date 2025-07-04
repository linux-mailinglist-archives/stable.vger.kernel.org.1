Return-Path: <stable+bounces-160222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06FAF9A69
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 20:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DEA4A2F73
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84DB217F24;
	Fri,  4 Jul 2025 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgI6j4j8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D2214A97;
	Fri,  4 Jul 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653085; cv=none; b=NK4X1Y5Be9q+Vv/uw4ZAiQ5ecZky5BIdcogZ1bftrhRF3eDJ8SqqE7nwtQmIn+EOmFAmtNxh2uc+JEK6qEapYPZVeGIXe2ye1JdrJc12TsoXC/PqxMJ+++8U/ZCPkeOzWRUdIjf/d1RqBdscmzNqLAoq8Ip7dGfCTX0I8Fk+ASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653085; c=relaxed/simple;
	bh=aHEKVPEcG65zMssaVDheCdyA1eEbVFSOQxSEcrZfmqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObtVTqt5tAzIlLDxuoQwgiup50XBC4Fu48YcG2fKRIUnXtJROGDGbipSZMibU7aA/65Od8q2hkI3GWwkbhLMBs6f/HgxX4ALrk4voPHabcS5V93O2EXOub9Bya8PSu/ZEuGav3+ZF2iuTso0Bf8UhGppgBKcEiaoYliZ/b4trKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgI6j4j8; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d219896edeso142827885a.1;
        Fri, 04 Jul 2025 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751653083; x=1752257883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bl/mZF3g2hMilPsP1iGl5oIVwOLv3WwEcuUx0SZOALE=;
        b=TgI6j4j8NvQ1RSc38+62ty64bMoKYVUKba44sKW1/C5mCIy4gMhV55Qoy5JpxU9YVm
         XRXQyEKwc2DsNCOKve3DDjE16B+UAs7WAobl0tKRJ7HNreY7UBsnP2+VlmwRcz/Iq2jp
         Jty1yGuBZDUGto66R6UVes/A2695Yi6AGmt7Q5leH8h9Km3HavorJk9MgQN/TnEwiQeu
         U8D5D9z3hKvPI9TKgyqVLt1G+NLcHe2PF1acAy7m+odBzkbaSnL6RSoZMDTddadaTJQV
         TYwio411vvxY2b0NbK6dsGd5RKCDz1rJQHRHskuWWVnbGon85cNvGNC30EnTBH4ShkSa
         h50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751653083; x=1752257883;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bl/mZF3g2hMilPsP1iGl5oIVwOLv3WwEcuUx0SZOALE=;
        b=ghr68InYzthW+GB5aQFZxQjI3FfiaxE6veKfqv53flEKmn8oXQ4UmXeJmD7JcRZbZT
         AKVxf2Azq3ur+2QG9+r+5e9BZ1LOVa1UjtfbADMtL/vaf5gN8aXwoLhV+rjBAvx59iod
         HGfgvSQsF63/tHmVexLq0NenC8iGHU+SyEjVIRNudmWeu3C/k/lL6UyOy/4eQsHxmkWg
         MhFGng8QQ9v7k1h/QrG3JnSaiuMWyXYltKPWWfWqHWbtFLhwhqN1Z3j+nPk/hGnnMI5H
         sM5B1RWAK+v/Pn2MAk2trhahvrJmCuEdd+S/0wjE1bcdiIx4/kufqDCYyPo/Wha2TYbt
         nDSA==
X-Forwarded-Encrypted: i=1; AJvYcCU07E9VqsOp0vNbaZ+yMIui9zy65L2piOnwdWp8LURdT1Y4Ajesl6G8KTuljmF1dVroyhkhUV3P@vger.kernel.org, AJvYcCU7tfT87ZADPY/Uo4jZGfdBZ8vjzS8NWZinn+MGy1rHjlxFV82AC18v2+ffDw5/jmCoA5HxIM4YZScQeMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8hpKPbdJ6xrEx9LeI9CgD0V7sjvApWv2dk7IB5nBr3xIAIEo
	hDCWs2Gk+SMYhFYu37qGc5XSVCFtD4g0SqncZpOjvK7siZlCQBCIBPcK
X-Gm-Gg: ASbGncvSOUuVKbzWxQa1LVC9nbjMhzzsLfbO2WD6sBx1bYojAfampBzufiUDCjrbmGQ
	7dH9P/DfcGPTl8kG1fIuqrTqZ7IvKwVjEkXbotDeLXwyoHs2gS2vSMVmnOaiuDDU+WZKCqnDlBA
	cfIgd4R+J89w7aRkmXCNh0Pq5b22MMVZe51OEGJxEnFJfy18HJv6Nsqv1Kjwqx+gd3axgY9pdJL
	xT17MlKduif307Os7Op+1C5RMns0eh2fBqoqz1QR5tqkqgRI6qTibtKr05XCZHkPGsaJuqZm+SB
	psmOnkqzOOn6sMH0mHIAFsAdsE2ehQxt2k1NWWzHOBdJrIK292amU5Z/LQSP/AuktHA=
X-Google-Smtp-Source: AGHT+IFy3tLLLYtnh/8YAuJviyCcHo1jFc1c5QzCjrQPfcPthvfTb7Ko7B/LTrElXNHWG9aZmoeYiQ==
X-Received: by 2002:a05:620a:4147:b0:7d3:a580:c197 with SMTP id af79cd13be357-7d5ddc2f78fmr380974585a.31.1751653082750;
        Fri, 04 Jul 2025 11:18:02 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe7c188sm183300585a.59.2025.07.04.11.17.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Jul 2025 11:18:02 -0700 (PDT)
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
Subject: [PATCH v4 1/9] mm/shmem, swap: improve cached mTHP handling and fix potential hung
Date: Sat,  5 Jul 2025 02:17:40 +0800
Message-ID: <20250704181748.63181-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704181748.63181-1-ryncsn@gmail.com>
References: <20250704181748.63181-1-ryncsn@gmail.com>
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


