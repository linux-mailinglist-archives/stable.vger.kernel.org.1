Return-Path: <stable+bounces-152421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD0AD56A4
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04EC170BD3
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85702267B61;
	Wed, 11 Jun 2025 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1HBSnr+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393A2777F2
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647603; cv=none; b=cLXo4OBGPaCKw9RWZShaL3HnIm6m3KentNzGExopYDVUO790K3cPSUKykv3V2RxR8IVdNYUsLZQyjBo2RmzF8tW8TqWC6okt2TfPzGB+tI+hlCziDk28Kyw/rMq+1A3sHNpQ2XAh3opyQq5ynrwSHtbieKFgjTwiAwUJdf/lxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647603; c=relaxed/simple;
	bh=tVjWZZq7aC71e6oZeyUhcEByjY5cRYLLNLRos59IMKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbI6kEaeZ1nHRt2GEU5v1j0DtEFXKolDG0Kp5cY0bAAx8DTLapYUxrf3u+4aViu+9CMjPDZyLuYNsPRAw+WQlaRu+5doLvg6t4rJQup6oYEIyJyCHethuwcFDVb8SNkjoO//xDs0imINLv1FoUrVodkSZrlJoSmSumcdRZoCINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1HBSnr+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749647600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7/yCkHIcpMtAc9OSRfJ62TeWdUDAL1/W3fcogu/NpP0=;
	b=H1HBSnr+G3RKDAJld8h6lp0kzhGNBja5vbXfawP46JcBn+Yo7Ysb6GuQ0cMO205cT3o78x
	pLB/oh9B+3YMsUyuLNXa9o2K46HKvsn3CfC+Q+8j7ntSxL19MViUo2uholNFsGe1O/3ZNK
	tKsyPufKePdshhe0k8KMg2RqhvGMjxU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-uISbxn3aMiChSBaQpHirrw-1; Wed, 11 Jun 2025 09:13:18 -0400
X-MC-Unique: uISbxn3aMiChSBaQpHirrw-1
X-Mimecast-MFC-AGG-ID: uISbxn3aMiChSBaQpHirrw_1749647598
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7cd06c31ad6so131804685a.0
        for <Stable@vger.kernel.org>; Wed, 11 Jun 2025 06:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749647598; x=1750252398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/yCkHIcpMtAc9OSRfJ62TeWdUDAL1/W3fcogu/NpP0=;
        b=dJp04/FFZVsTOuWpqWeCOu+oG0tBIFGYh/mSk5lOItq+zNHjMCbSqoWO5Qx/JrfeM1
         QZuioijgKrHUgSNxKSRpBIpwxN8n1R9Qt5DHe+4eehOLBmTFUCQDJZOdp/zNeJQntNBB
         hJ2eM+9Za0KTnD9zIlDMGFw5w5eIaTUfYOy/EA4HakdXRwzTfzas/Zhj8wW3PN2VqSH+
         Yt4lZakd4YpEh+zwZH1s97zb238hH1tBcbr9le9BwoGbogaG6c7pZaP+H5w40RrHnPoc
         cBS/n38YT3tNKxcrLF8PWJSLp2c17T0a2OKOWaY3pnwe4PqeBnHNNZ/rICgLbuf7+2Je
         D6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXIG04xXCMTXghE+6SD4X5afdxZ3KFQOVfOpk55Rn86gxxEX5KpTIJ2WrYu0PKwyuffWe4Vyig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/wp7Y0e6IIoHdjl2jeKZED4SeIsgIO2VUh4IZoM/JtKeNJGkv
	vlM0CeHZ3YH3B7k8yMeX0U3FpnZPVLyo8RwhsnGmhOHKXzQ1zAkVIEExvKSnd6gewcKxoRpJkZ3
	os+aQ6xOQkqC8MEYjajOaFfUpQP99hSwIbgwKoSb/pKok52iHuH7yxzbxiEZXmSY1N8eT
X-Gm-Gg: ASbGncsgcksRCBcL11Un/mLSN4Fg2U0bHBlqkgLCKnF510B+0LvHwiM9YlLsup27zcS
	Re0KY/lAsSgMnDNm29dQo7g2K/YrMBJ39hqfiTiBAPGS7/K4IXkVGozpa69tdFZJD/nFq0/lmE8
	4bixR8ZNciZUjLkUaDSkeJiYH2+zgm3cixAZWGB1BItEB/Y6XD5l4ux29Iw3VSFcTEcz9K1qB4y
	j9+carKl3Pwsc+wbypF200InId1xqMjIb9ve7R6YOdK1zmwBiru+nlFri3DaY1IkuWj0v5gsUHa
	zYrjb9ksRdMvmH+K1oNOOjV/r8XstdbN0DIZk40omQ==
X-Received: by 2002:a05:620a:170f:b0:7d2:26b4:9a91 with SMTP id af79cd13be357-7d3a87f886amr476941285a.2.1749647598025;
        Wed, 11 Jun 2025 06:13:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc2fImNRriWGsaw3Op67ph4lhGxj0zvCwpB17iJ/FdZgoWW5fEkHRMUQVllDHDRlj1xdpoSA==
X-Received: by 2002:a05:620a:170f:b0:7d2:26b4:9a91 with SMTP id af79cd13be357-7d3a87f886amr476933885a.2.1749647597463;
        Wed, 11 Jun 2025 06:13:17 -0700 (PDT)
Received: from localhost (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d3901b12easm539789085a.67.2025.06.11.06.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 06:13:17 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Hyesoo Yu <hyesoo.yu@samsung.com>,
	Stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Xu <peterx@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Aijun Sun <aijun.sun@unisoc.com>,
	Alistair Popple <apopple@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v1] mm/gup: Revert "mm: gup: fix infinite loop within __get_longterm_locked"
Date: Wed, 11 Jun 2025 15:13:14 +0200
Message-ID: <20250611131314.594529-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 1aaf8c122918 ("mm: gup: fix infinite loop within
__get_longterm_locked") we are able to longterm pin folios that are not
supposed to get longterm pinned, simply because they temporarily have
the LRU flag cleared (esp. temporarily isolated).

For example, two __get_longterm_locked() callers can race, or
__get_longterm_locked() can race with anything else that temporarily
isolates folios.

The introducing commit mentions the use case of a driver that uses
vm_ops->fault to insert pages allocated through cma_alloc() into the
page tables, assuming they can later get longterm pinned. These pages/
folios would never have the LRU flag set and consequently cannot get
isolated. There is no known in-tree user making use of that so far,
fortunately.

To handle that in the future -- and avoid retrying forever to
isolate/migrate them -- we will need a different mechanism for the CMA
area *owner* to indicate that it actually already allocated the page and
is fine with longterm pinning it. The LRU flag is not suitable for that.

Probably we can lookup the relevant CMA area and query the bitmap; we
only have have to care about some races, probably. If already allocated,
we could just allow longterm pinning)

Anyhow, let's fix the "must not be longterm pinned" problem first by
reverting the original commit.

Fixes: 1aaf8c122918 ("mm: gup: fix infinite loop within __get_longterm_locked")
Closes: https://lore.kernel.org/all/20250522092755.GA3277597@tiffany/
Reported-by: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: <Stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Cc: Aijun Sun <aijun.sun@unisoc.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e065a49842a87..3c39cbbeebef1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2303,13 +2303,13 @@ static void pofs_unpin(struct pages_or_folios *pofs)
 /*
  * Returns the number of collected folios. Return value is always >= 0.
  */
-static void collect_longterm_unpinnable_folios(
+static unsigned long collect_longterm_unpinnable_folios(
 		struct list_head *movable_folio_list,
 		struct pages_or_folios *pofs)
 {
+	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
 	bool drain_allow = true;
-	unsigned long i;
 
 	for (i = 0; i < pofs->nr_entries; i++) {
 		struct folio *folio = pofs_get_folio(pofs, i);
@@ -2321,6 +2321,8 @@ static void collect_longterm_unpinnable_folios(
 		if (folio_is_longterm_pinnable(folio))
 			continue;
 
+		collected++;
+
 		if (folio_is_device_coherent(folio))
 			continue;
 
@@ -2342,6 +2344,8 @@ static void collect_longterm_unpinnable_folios(
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
+
+	return collected;
 }
 
 /*
@@ -2418,9 +2422,11 @@ static long
 check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
 {
 	LIST_HEAD(movable_folio_list);
+	unsigned long collected;
 
-	collect_longterm_unpinnable_folios(&movable_folio_list, pofs);
-	if (list_empty(&movable_folio_list))
+	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
+						       pofs);
+	if (!collected)
 		return 0;
 
 	return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);
-- 
2.49.0


