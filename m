Return-Path: <stable+bounces-107900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6F6A04B25
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80A63A47C8
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 20:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B111F7554;
	Tue,  7 Jan 2025 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZ3RpU9P"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5BB1F6666
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282413; cv=none; b=owmosmvFHDwRW1h3R6UBvje602sifNjAevFx543t+UW++Ck1oIit3p+u6Q/Zb/ymHXnQai8Kjg+L7ImzI03iYYPxCcA3cmJOTTDW4e0eFrZ2+5GBTfdzLGqOR04RxFD1Nzg/s5eIMBP5sCT2TgPHFOQHrp8yX3qWqqoSyY+tVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282413; c=relaxed/simple;
	bh=OrlV9telHLmipLDh600rO1pzIX30pRvc2kgciEpZ1Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxBT1sEBQhLofhiB9YFKCH/DxuiiNQtbt2gc8aDFiMTdJvlKrqmaJZiLz+xEfIoQ6+mGDYYtcJRPQ27ijkgIty3xDZ2hJy2E68pCeJ8ywZ/uLcBr8HuztAx77g79KzUlmaBvmB8i0LyK07Fp0l88EetyKWZOa7sYnXqE7Nb85s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZ3RpU9P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736282410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lk3UnwL4Id+x/YZ2BCdCNZ6wF+YE+g3ghMfVfHdxsk=;
	b=GZ3RpU9PAB6nxQjaZ99FixZiwrQgr0hfHWCNj5jx2ALhrKa/7/cAxLJATrbJpWGve8ZMgr
	J2vucyhnspGOoikLXO5Sf/+mX4F3SicMxVSt/NZrQ7PqHi5axLtJhZ1RlUuGT6nXg8Q45y
	toHtKPwC1dd8rtAUlaAwdcxnVnmyI5I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-xJyy0Km2Nmu8a_LOIMec2A-1; Tue, 07 Jan 2025 15:40:09 -0500
X-MC-Unique: xJyy0Km2Nmu8a_LOIMec2A-1
X-Mimecast-MFC-AGG-ID: xJyy0Km2Nmu8a_LOIMec2A
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8edb40083so3482386d6.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 12:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736282408; x=1736887208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lk3UnwL4Id+x/YZ2BCdCNZ6wF+YE+g3ghMfVfHdxsk=;
        b=JeGb2BUjXybtvsaokV99Td+AOPQrz7E94/u2Ely8tSUdxdWyjtOCQg5Y/zsH3Q4ZNv
         rG2cEgEal+83JPyjqAOTuUn7hrY9o1w498iPWxaN25Il9H9+LmwZ87dtvJsjdBG5FLX6
         OGekJGAjydCOUKiY8fdM2kGYfYVxq0jSdw5Eh2k5ef3nvqKZ1rni/p6Fx3lEKlySZLvS
         +gEsslCXK4UpigWBFVt0HnTbbdpAsmRlzRhOLbs2X/3PAp6ZC5LLujuuR5yRqE4RSd+f
         6jokwbp5yhDW4cb/Zmje9gmtw33aHFGD5pt8dSWSwsE8BhHnF+QsHf2mzh8H1NiMxLVV
         ONCg==
X-Forwarded-Encrypted: i=1; AJvYcCVzMcySPtzmfle6ke3oQ4hdb6oi4z0BKKK9RfWf1mQ48ww4lzbTdzGTv+JVphzSKSRK1bQT0z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVyCHfpwfRCZlS65mSc4yfp0K5pXWt8A6lZkGA2WlaWwd9kh17
	8gn10g9/Ui3A4SNUZhIHGQuA99MpoXjzHt6/xFCIO1sLC+rKtzSyFCx7CUU6+aArp6aD1HBg3vO
	4+metlaI41o+82jxCSpxPmSM+iiW7Asuen/Audw5nyquYFj75mufX2A==
X-Gm-Gg: ASbGncsXjXHIx0ShnZxKBorqe3sBhtF41Sxr2uvd7uTQSlsv0hSoLyOCiFsd3ONwZkW
	woipbLYLtQLvwSQ5/KUofBpVFyRjXKmOo3HFR28cxPeh5QdyxBiOyQulLRr27X6Mb52bO6rI4Oy
	t5o+/Nk0Jss9ZBrwVNbSFxkoKdkWq1orp8UQRLdRbPxXmolRwUq8Y6uNR4aVTUKN6AODBRQDT6W
	zeePhR7BLLuNhGjkTrD24qkExi8D26W5GApzh/dm4wEYBGDwWh0eQ8utaNMcZVs+lC8qb69r4ZK
	yzQnxW4RsL1vvJngDsjdZlwBDb/p9IeA
X-Received: by 2002:ad4:5dc5:0:b0:6d8:b660:f6aa with SMTP id 6a1803df08f44-6df9adfb518mr7494726d6.14.1736282407070;
        Tue, 07 Jan 2025 12:40:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4opU0e+dfjClXuwDmR9cg3uGQm3YY2brmnjieEI+XeJr35YfbdedExB7KgsOyuQE8PaeuGA==
X-Received: by 2002:ad4:5dc5:0:b0:6d8:b660:f6aa with SMTP id 6a1803df08f44-6df9adfb518mr7494476d6.14.1736282406765;
        Tue, 07 Jan 2025 12:40:06 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181373f6sm184478306d6.62.2025.01.07.12.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 12:40:06 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Rik van Riel <riel@surriel.com>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Ackerley Tng <ackerleytng@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	linux-stable <stable@vger.kernel.org>
Subject: [PATCH v2 1/7] mm/hugetlb: Fix avoid_reserve to allow taking folio from subpool
Date: Tue,  7 Jan 2025 15:39:56 -0500
Message-ID: <20250107204002.2683356-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250107204002.2683356-1-peterx@redhat.com>
References: <20250107204002.2683356-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 04f2cbe35699 ("hugetlb: guarantee that COW faults for a
process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed"),
avoid_reserve was introduced for a special case of CoW on hugetlb private
mappings, and only if the owner VMA is trying to allocate yet another
hugetlb folio that is not reserved within the private vma reserved map.

Later on, in commit d85f69b0b533 ("mm/hugetlb: alloc_huge_page handle areas
hole punched by fallocate"), alloc_huge_page() enforced to not consume any
global reservation as long as avoid_reserve=true.  This operation doesn't
look correct, because even if it will enforce the allocation to not use
global reservation at all, it will still try to take one reservation from
the spool (if the subpool existed).  Then since the spool reserved pages
take from global reservation, it'll also take one reservation globally.

Logically it can cause global reservation to go wrong.

I wrote a reproducer below, trigger this special path, and every run of
such program will cause global reservation count to increment by one, until
it hits the number of free pages:

  #define _GNU_SOURCE             /* See feature_test_macros(7) */
  #include <stdio.h>
  #include <fcntl.h>
  #include <errno.h>
  #include <unistd.h>
  #include <stdlib.h>
  #include <sys/mman.h>

  #define  MSIZE  (2UL << 20)

  int main(int argc, char *argv[])
  {
      const char *path;
      int *buf;
      int fd, ret;
      pid_t child;

      if (argc < 2) {
          printf("usage: %s <hugetlb_file>\n", argv[0]);
          return -1;
      }

      path = argv[1];

      fd = open(path, O_RDWR | O_CREAT, 0666);
      if (fd < 0) {
          perror("open failed");
          return -1;
      }

      ret = fallocate(fd, 0, 0, MSIZE);
      if (ret != 0) {
          perror("fallocate");
          return -1;
      }

      buf = mmap(NULL, MSIZE, PROT_READ|PROT_WRITE,
                 MAP_PRIVATE, fd, 0);

      if (buf == MAP_FAILED) {
          perror("mmap() failed");
          return -1;
      }

      /* Allocate a page */
      *buf = 1;

      child = fork();
      if (child == 0) {
          /* child doesn't need to do anything */
          exit(0);
      }

      /* Trigger CoW from owner */
      *buf = 2;

      munmap(buf, MSIZE);
      close(fd);
      unlink(path);

      return 0;
  }

It can only reproduce with a sub-mount when there're reserved pages on the
spool, like:

  # sysctl vm.nr_hugepages=128
  # mkdir ./hugetlb-pool
  # mount -t hugetlbfs -o min_size=8M,pagesize=2M none ./hugetlb-pool

Then run the reproducer on the mountpoint:

  # ./reproducer ./hugetlb-pool/test

Fix it by taking the reservation from spool if available.  In general,
avoid_reserve is IMHO more about "avoid vma resv map", not spool's.

I copied stable, however I have no intention for backporting if it's not a
clean cherry-pick, because private hugetlb mapping, and then fork() on top
is too rare to hit.

Cc: linux-stable <stable@vger.kernel.org>
Fixes: d85f69b0b533 ("mm/hugetlb: alloc_huge_page handle areas hole punched by fallocate")
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 354eec6f7e84..2bf971f77553 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1394,8 +1394,7 @@ static unsigned long available_huge_pages(struct hstate *h)
 
 static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 				struct vm_area_struct *vma,
-				unsigned long address, int avoid_reserve,
-				long chg)
+				unsigned long address, long chg)
 {
 	struct folio *folio = NULL;
 	struct mempolicy *mpol;
@@ -1411,10 +1410,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 	if (!vma_has_reserves(vma, chg) && !available_huge_pages(h))
 		goto err;
 
-	/* If reserves cannot be used, ensure enough pages are in the pool */
-	if (avoid_reserve && !available_huge_pages(h))
-		goto err;
-
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
@@ -1430,7 +1425,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
 							nid, nodemask);
 
-	if (folio && !avoid_reserve && vma_has_reserves(vma, chg)) {
+	if (folio && vma_has_reserves(vma, chg)) {
 		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
@@ -3047,17 +3042,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
 		if (gbl_chg < 0)
 			goto out_end_reservation;
-
-		/*
-		 * Even though there was no reservation in the region/reserve
-		 * map, there could be reservations associated with the
-		 * subpool that can be used.  This would be indicated if the
-		 * return value of hugepage_subpool_get_pages() is zero.
-		 * However, if avoid_reserve is specified we still avoid even
-		 * the subpool reservations.
-		 */
-		if (avoid_reserve)
-			gbl_chg = 1;
 	}
 
 	/* If this allocation is not consuming a reservation, charge it now.
@@ -3080,7 +3064,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
 	 * a reservation exists for the allocation.
 	 */
-	folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
+	folio = dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
 	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
 		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
-- 
2.47.0


