Return-Path: <stable+bounces-154567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ECCADDB68
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 20:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E8C7ABFB1
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F0F2FA622;
	Tue, 17 Jun 2025 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2CN2WmI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597828B507;
	Tue, 17 Jun 2025 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185329; cv=none; b=LE8VM4wgtEcjA4/NRsub9Pz0ENnDunxSuY7KRmZPPLMo3Ov4QwGA1Jv5YPFAmMubkhvx25+Msju5fgXrJBdqfjh4SMadyBx1uucsg4z+PwWtEaA6tJx5e7VKgB9Nyc95eswlxXRpQcTPfkroF2HjC6BPCJUIij374hJrMhF6nIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185329; c=relaxed/simple;
	bh=z98qWiz2TPOSiS2oB0qvfqGpiJumBiAmrfNf7XULJMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwsvOhYBKppm0v0E7JtaBkfOuvyMxcTavkSNRi0pfEMCTLZ1VGJLbUeaFIcLTOuvjnbuxFfGwMNxGx8NlLqfEBA4wNrglMYD2Drjd99te/wdqjv0eDFZxoUh00N/uBYSueIAJ8rg2ro1eohr9LlqTEUOwOI4p3xM9F0SxCtpVYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2CN2WmI; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so5357298a91.1;
        Tue, 17 Jun 2025 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750185327; x=1750790127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bntp77Hs3RcMQMVsD2F77AAd9YdDXm5jtfci1+gUQ14=;
        b=g2CN2WmI4Ebpbr0GyWnVKB6vJTpGE9jfI50fCvNEJwY4HooAOZSwYaQQto4l/v15aA
         kvp3ziN7BpEP7cEsZCjIrsFcFNr8UwIKlWGgQi/iNWNMzc2JvGhELD2/FZWv5elwGBV5
         sbmU+b6pdaq7jdc3kAe51BhuOSGPyfC8u/t6QssxN3sojqlcfy7FBqvPty9A6MeDsT0J
         PZ79qfiR7MmFwSjmCqiLHyQTz5sdtDOmixDCpTf0cgOtc/xTpukUDVNojtFhHmkAO4yr
         JY5WPTYEnH8tCKqKaiqdE6kbZuQo/W3CSbplloWEgCoSR2+mxzLo0a2jPs38+DZdGJwT
         YgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750185327; x=1750790127;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bntp77Hs3RcMQMVsD2F77AAd9YdDXm5jtfci1+gUQ14=;
        b=pCUpanstU05cK9VffUMd856getHRkAJepWSGl821N7WKu/Sr9T//nhbv04D/6tYhYq
         cBUIOEDM0CkRc7VdlKtqg1/7BXyKbGCJSGPilDJlQqE0dZkinFoph2KG5fa597aJa8Gq
         f2+1yR/SjsG/t6vXYmUn9WXZOkKltLOLGDYZaRHYNdgcKL/6TsTvC+NMsCazAiFPLpWV
         Q7WNNuFv+m9cai4f1xgsY97n+6O0ZvqchL5agXHYXV+G4HrrRwQrT23QErLxi6W8z2Jf
         9M/ogsERMXx5IsgWRqMljoyIOabl59NSNoGgn/DuFywc2xWKPYLAKHzXyPp7xm8cQvN1
         w5bw==
X-Forwarded-Encrypted: i=1; AJvYcCUDVl3u1LVaZ5MVWtXi1CfNHxTHaW+bXeA+z2jUOv+S+MQpL/U7scPjdTIAUYBTCHlA/yIcqJl68SJ7LN8=@vger.kernel.org, AJvYcCXpO2Myirmu7ZOmepw3w0XLUAY90hXrkk7QR2Ys5RQQFu34lpZvNT6FZgWPwLfjjY88TqE8P5hK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DJNMcUkDmxPHywk4eJWF+D42ax487b8f26tk8yiok1jN9huO
	X6To7HX82rErDWOaNgD4yror9tPRswnxrshS297ejpaVjGjhocBspN6S
X-Gm-Gg: ASbGncsY34MtewuyCWix9fTk/jcEXwK2Zzseg2yOeBbq9uSQB6vRpyleDCCnhlJZO1H
	z/xuyyUN5PDtfXSPtJI3ztkXtq4lr4PcX3hCkaTbpRqmERAMNEYofFNSZh/P7/RntfklUuZz24f
	Aj3hmyn2TQlUI6BG/7zfCCfX4MTj0F7O3O0rm2QPG1I4BBE5oC6wxLcb36te5wIwPdXVoNUbnzR
	5brkrSSKkeUMySbCOdfMujuwtV/cLg+sVurBQQnoRs4pBjIVyAbfo9Ey94BBXswKxSCLwTM+99k
	AaKI4MODaRjwSivDkqVCJQOMAzYrLViXJ907oS1pCzSKPqeIaiQ7O5dUFbYSV/Gm0alMs7hsMAF
	F9Z/hkNc=
X-Google-Smtp-Source: AGHT+IGdnat7JAHqcXUEzk7AuYqg9efS1z6IgHRw61xLREkaJw9YC8i5ETUICV3Vo2xPHkSaPRPoQg==
X-Received: by 2002:a17:90b:48ca:b0:312:e90b:419e with SMTP id 98e67ed59e1d1-313f1cacddfmr27441718a91.12.1750185326908;
        Tue, 17 Jun 2025 11:35:26 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de781c7sm83753715ad.128.2025.06.17.11.35.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Jun 2025 11:35:26 -0700 (PDT)
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
Subject: [PATCH 1/4] mm/shmem, swap: improve cached mTHP handling and fix potential hung
Date: Wed, 18 Jun 2025 02:35:00 +0800
Message-ID: <20250617183503.10527-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250617183503.10527-1-ryncsn@gmail.com>
References: <20250617183503.10527-1-ryncsn@gmail.com>
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
Fixes: 058313515d5a ("mm: shmem: fix potential data corruption during shmem swapin")
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Kairui Song <kasong@tencent.com>
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


