Return-Path: <stable+bounces-77833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2BC987AA7
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671091F2208B
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 21:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B6187352;
	Thu, 26 Sep 2024 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeZwapr+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9345979;
	Thu, 26 Sep 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727385615; cv=none; b=Iir+UOSu61zrDPREY6MJe/JX/FIyqeUmSsdf1i3vLDSGouRXTnCTaIqz0pl/4pJmKoWTA4mExgeAYekOynsHn5qxWnjrKVP7qgvd8Se6/I+oNbPcrto8lWwHfpfKkbNSvCHJpQrK39vRNI1stPjG2gEzF4C04nwyNAlE8nXH8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727385615; c=relaxed/simple;
	bh=zOHoz1vlI2uLSCMofTA5VUo86Q/418Dc16V6qjRtrVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JbC1bIb1Qrf4zQ2ZkK9j5StgUtzrQv8xq1uv3QjQ4h4LfzzbJLjV8iCR0F4lQdf9+0vC6i4+KKPN0fSBEjR8h0en5VqXUGMqjhg/SvyZV8X5elXt0Bf2+TkgsYI78JnUGYfIz2GrdcHKMc0+xlLghJ/ubQ1uzb/G5g9bjFR5rKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeZwapr+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1078737a12.2;
        Thu, 26 Sep 2024 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727385613; x=1727990413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ91nBWFZA/cgktqOlSvWqcjoum6mw/iuuqt/q9fLzg=;
        b=NeZwapr+r20KlxSwygEyKLQDMB0roWoWbWEDKh0/q+Y/BMA4xOOSqKR+C2o9gNz6Sa
         6OtgyPnV9itqx7NJLs/kpYkP37R/GRAAmtqlvIf57aBVtL707QcsVT5TH8az++ln0Mjx
         xeeKxTt6au7Stujg3L+4HEgKQ3aEOYtP6V9nf/scgkY74GTpdn1i4LrW+uwlZdpJWrgW
         O1xf31Gux97r7oNbrZ1TidxysqKqcJ0KCngyp4lRdqkHWRYl2//c8NyxFOQXzbxshsuv
         uOqZg3naXrBgtVB4ytxGsM47MvQ/2FILhKJTEeghHPuY8/jjpYKAxiehiDI8MbNn/Xq4
         Oz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727385613; x=1727990413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZ91nBWFZA/cgktqOlSvWqcjoum6mw/iuuqt/q9fLzg=;
        b=kk6W4/FNiqCpQLBlv4CHi5t55dfF61UQToJ8MtonWf+44UiqIDDKYaXmUOOdEcVWnx
         KKsnwKdUeSokZlKG+FfJabBdiqb400E7j1pAl9ruKugNWyc+6Qh9L2o9ZBu8kT3ihqmJ
         R3hkthz3IM0PSPiqtQ2HxmGdipRYeMFaBzhuVy6HO6DGZyHddRNEnptj0iDcd4sVI0Gs
         nKWKVakeaCqujhN4WStaW4fFhnvAIa2yMxivEnBEeqya+o2BwR9OKuWk5btiDw0SwxlR
         MK0Z7Xr3NsEy3tHahyxe20yqIKgCi4g+qEM1UT4OYO/PP50yPMrkcDPei+upoYumyyu7
         tW1g==
X-Forwarded-Encrypted: i=1; AJvYcCX1hU5FHAWndwp5Yabm9tfEINacL/aVFb4nuJ41n8rc9xjPCIkzRf+v9wnBCHErILAFqfZHLiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHIbFMnP5nhTOOtBk4qRziGfvT2FdP7oP96ZHc3zguZH5XV5h
	R8893teS2BfDR04/s8jAhcT4rabUtHSL99K5QaZL9YRty4sQSh6S0C3lEmZi
X-Google-Smtp-Source: AGHT+IG9ekqH94a7zizhC0UXzN1YBgcZ9BF/8ctXYzeyJmPq6g4DU7IdJeBD+mf3dajOxhMZuIT5bA==
X-Received: by 2002:a05:6a21:a247:b0:1cf:4dc3:a89e with SMTP id adf61e73a8af0-1d4fa64d9d3mr1069643637.9.1727385613293;
        Thu, 26 Sep 2024 14:20:13 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26516245sm338881b3a.127.2024.09.26.14.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 14:20:12 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Kairui Song <kasong@tencent.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Minchan Kim <minchan@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	SeongJae Park <sj@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	stable@vger.kernel.org,
	Oven Liyang <liyangouwen1@oppo.com>
Subject: [PATCH] mm: avoid unconditional one-tick sleep when swapcache_prepare fails
Date: Fri, 27 Sep 2024 09:19:36 +1200
Message-Id: <20240926211936.75373-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
introduced an unconditional one-tick sleep when `swapcache_prepare()`
fails, which has led to reports of UI stuttering on latency-sensitive
Android devices. To address this, we can use a waitqueue to wake up
tasks that fail `swapcache_prepare()` sooner, instead of always
sleeping for a full tick. While tasks may occasionally be woken by an
unrelated `do_swap_page()`, this method is preferable to two scenarios:
rapid re-entry into page faults, which can cause livelocks, and
multiple millisecond sleeps, which visibly degrade user experience.

Oven's testing shows that a single waitqueue resolves the UI
stuttering issue. If a 'thundering herd' problem becomes apparent
later, a waitqueue hash similar to `folio_wait_table[PAGE_WAIT_TABLE_SIZE]`
for page bit locks can be introduced.

Fixes: 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
Cc: Kairui Song <kasong@tencent.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Reported-by: Oven Liyang <liyangouwen1@oppo.com>
Tested-by: Oven Liyang <liyangouwen1@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2366578015ad..6913174f7f41 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4192,6 +4192,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -4204,6 +4206,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *swapcache, *folio = NULL;
+	DECLARE_WAITQUEUE(wait, current);
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
@@ -4302,7 +4305,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					 * Relax a bit to prevent rapid
 					 * repeated page faults.
 					 */
+					add_wait_queue(&swapcache_wq, &wait);
 					schedule_timeout_uninterruptible(1);
+					remove_wait_queue(&swapcache_wq, &wait);
 					goto out_page;
 				}
 				need_clear_cache = true;
@@ -4609,8 +4614,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
-	if (need_clear_cache)
+	if (need_clear_cache) {
 		swapcache_clear(si, entry, nr_pages);
+		wake_up(&swapcache_wq);
+	}
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4625,8 +4632,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}
-	if (need_clear_cache)
+	if (need_clear_cache) {
 		swapcache_clear(si, entry, nr_pages);
+		wake_up(&swapcache_wq);
+	}
 	if (si)
 		put_swap_device(si);
 	return ret;
-- 
2.34.1


