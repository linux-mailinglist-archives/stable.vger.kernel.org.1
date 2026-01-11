Return-Path: <stable+bounces-208022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1526D0F89E
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 18:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E8BF300D91E
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E2D34CFB4;
	Sun, 11 Jan 2026 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InB+zk36"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35871E5B7A
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768154112; cv=none; b=GUBRlBKrGvk04nAvBLcX/GN6krygFflKwVEYfcpPRJ/QDrKjdL4vljUgDsoxCdhI7Cgj7pDN5cFRwQMZhrqQBmrUfNDZZLLVDxmUUBFbkGEjSEcTqwKu/9l9RPqvkcyFqapIGOEpNspA8dq2LALcVkikOJc9BsZsIgz0mR6l9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768154112; c=relaxed/simple;
	bh=cWCSdYt4b65eh+IzBE3IUy25Pu2/+qQ1wHSD1i1Reuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pwFAIFlXDWWDAJKVUf+yMq/wz1ZlRsK3aINs8TR9DLYWFsroOXBWSlkEFTzpCR2CXumbTNKGnCMNrIQT1SEvZt4hZIL6ICDmLugcL3likKX0mVtC7Wwh+m48mwMhVqAThraSSFyOM1vwlattNphUcjLp4FNHLt4dy/fobM3Pssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InB+zk36; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0833b5aeeso57587235ad.1
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 09:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768154110; x=1768758910; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mn2Hr5PSunu94OsN9KDSKjc7Q62FgkjIKfj/HXbAqXQ=;
        b=InB+zk36SvVaREIXOVa0ExPpRFv0ZpmEP+Bj5usQou7+ojyVSAf+4IJ51jJ6b4Hig7
         YCSbBrLzL0K2L7uc2CZSntmBS0+olbVepaq3vwigM7mQ9YrSDwJy6RkSAMdosbcZkOv9
         /fPgfs+7OBcY6Iaog6JYPrwAj6fI87Q8QOVje6VknK/hrKQIQuVHmNbsa5AjPIWhWYma
         S0r7Ill4mcEiJIqRdG1wyED7Dx9e4SOupFxBQXwDPuBepQoHlRlxBBfW49R9xA2XY3r2
         NqONr9sIQ2KpDA8mpdvgBNILY60cBt1LDt/y5Cl7uCIS/Cevr6s/7jyZfDGp5stuOZ5V
         1d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768154110; x=1768758910;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn2Hr5PSunu94OsN9KDSKjc7Q62FgkjIKfj/HXbAqXQ=;
        b=YogbzpAm9Xn3uNgsD+e39SkHvzrjA0OE+Cd75gw34PRrodQiRmzLc27xNlAQVs12Ro
         JpBauHlw6glVk0QhMbooj+p/5b8/h3KIoVAs4JJxz4J5KRtDgmkbijRaq7I+lwYObQiA
         enqhq5VmJXUVe62owKKTOYFi4oRo3g3uQzbemM+lsm6ImyEve+CdNg1fcR4oVqhWIRRU
         YHYUn77wKk/kWrv7X4vcTVhlWubGJa5MdycixW0y4OhNjke09K+ISspB5y4xAZWeM/kZ
         bX4G7C/aw4Kc6rkraEjaUfncNlY1VzzT1ETYi73+StWylPU4RWJpWg/nN7sqAE8ziV/p
         /Opg==
X-Forwarded-Encrypted: i=1; AJvYcCV8loCaZR6uk2a/YccYwkDbu//6FkQlW+UmNmnrh4CK/rJAYSFrwchJoDgD4QI6Y0WDD9vM7pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya31Kc9P4vXK5aTx5gIzmVCaWk30qE+S7S9OSXRzabztkhMqlu
	5gZHUBNdJdW20OQotUWqZApY+klx3hS63aJH5beI/qSgZKuyD+XVWt07
X-Gm-Gg: AY/fxX4yblHQHlnQxS5mpP/v7uuKQPH/mSOgMy2rw50t17NcEElvP0NQHKSPF9zbRKr
	dZYUyhqeY8ORrhvyMW3FIQtE1jmuxIZlxm7aw3u6O/5UtX+NhkPHGBi6g8U1JKS9KJGivbqkCZl
	4qxT+ShoOk9+oFpWnN+yunrjaSlbUNaWqzVbX4d30qwAIoQcfqgEzpTJTjSprn+OSdht0/E1XoV
	PeSGQXD/mFTeD3XxqnWxrec0LfuTNBh859BFdBI/HWG98d7v8205iNM6E7tXcQJr1Fjr3VJ+VnE
	YVxSUWOB3WpqBZdTWHFAoRWtVj7ySKgdFvfYMKnn21vZjmaOwjWDVP7k10XXcHFJgFVHH2qavPU
	zJLCtLpk07/wInriMOyZhtgCMRGBtNtzDcZa+mKWrFcJ2x/mK+2zODJrgoozxNqK/ElowK0rFzK
	NIEQgLaYVk0m9fPg0l/GhBqZkvdh82E2H3ypfJgjZ48UDKj0YM
X-Google-Smtp-Source: AGHT+IGRjrIuMsl7ABTtavQCHRXkK5SahpOXls7YS4dgUaOY68TrcZCDlcWyyr8kisqTY0HybKOKCA==
X-Received: by 2002:a17:903:184:b0:29d:65ed:f481 with SMTP id d9443c01a7336-2a3ee3411bcmr170291295ad.0.1768154109952;
        Sun, 11 Jan 2026 09:55:09 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3ae21sm150500795ad.7.2026.01.11.09.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:55:09 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 12 Jan 2026 01:53:36 +0800
Subject: [PATCH] mm/shmem, swap: fix race of truncate and swap entry split
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAzAviI9W1iHivgV8TBddT1MZQUVhn93e
 EwgyaCchBWGKkPiS1SOvQDVFSzB7Ruj+MJgje0MEaGGyBH1dieu8mDvDVvjqJlbDyU6Exf9D8f
 pfT+UL/4gYAAAAA==
X-Change-ID: 20260111-shmem-swap-fix-8d0e20a14b5d
To: linux-mm@kvack.org
Cc: Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768154106; l=3256;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=y8LXMuvlkDlyCTV58KsaetOE+va9ri7lv7P7G8ssw0g=;
 b=RVEa+tGwO0D/Cduu3BeHX+GntDWMUg1Lbu+Rm6zDB+3EfubeQAdCLcFf/7clzYQEZ1TYn9esm
 O65mahA2w1DASc67hy1Xh1z739U0JTywGL2xQIYerk3c9KQ0UdMBG2A
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=

From: Kairui Song <kasong@tencent.com>

The helper for shmem swap freeing is not handling the order of swap
entries correctly. It uses xa_cmpxchg_irq to erase the swap entry,
but it gets the entry order before that using xa_get_order
without lock protection. As a result the order could be a stalled value
if the entry is split after the xa_get_order and before the
xa_cmpxchg_irq. In fact that are more way for other races to occur
during the time window.

To fix that, open code the Xarray cmpxchg and put the order retrivial and
value checking in the same critical section. Also ensure the order won't
exceed the truncate border.

I observed random swapoff hangs and swap entry leaks when stress
testing ZSWAP with shmem. After applying this patch, the problem is resolved.

Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Cc: stable@vger.kernel.org
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0b4c8c70d017..e160da0cd30f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -961,18 +961,28 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
  * the number of pages being freed. 0 means entry not found in XArray (0 pages
  * being freed).
  */
-static long shmem_free_swap(struct address_space *mapping,
-			    pgoff_t index, void *radswap)
+static long shmem_free_swap(struct address_space *mapping, pgoff_t index,
+			    unsigned int max_nr, void *radswap)
 {
-	int order = xa_get_order(&mapping->i_pages, index);
-	void *old;
+	XA_STATE(xas, &mapping->i_pages, index);
+	unsigned int nr_pages = 0;
+	void *entry;
 
-	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
-	if (old != radswap)
-		return 0;
-	swap_put_entries_direct(radix_to_swp_entry(radswap), 1 << order);
+	xas_lock_irq(&xas);
+	entry = xas_load(&xas);
+	if (entry == radswap) {
+		nr_pages = 1 << xas_get_order(&xas);
+		if (index == round_down(xas.xa_index, nr_pages) && nr_pages < max_nr)
+			xas_store(&xas, NULL);
+		else
+			nr_pages = 0;
+	}
+	xas_unlock_irq(&xas);
+
+	if (nr_pages)
+		swap_put_entries_direct(radix_to_swp_entry(radswap), nr_pages);
 
-	return 1 << order;
+	return nr_pages;
 }
 
 /*
@@ -1124,8 +1134,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += shmem_free_swap(mapping,
-							indices[i], folio);
+				nr_swaps_freed += shmem_free_swap(mapping, indices[i],
+								  end - indices[i], folio);
 				continue;
 			}
 
@@ -1195,7 +1205,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 
 				if (unfalloc)
 					continue;
-				swaps_freed = shmem_free_swap(mapping, indices[i], folio);
+				swaps_freed = shmem_free_swap(mapping, indices[i],
+							      end - indices[i], folio);
 				if (!swaps_freed) {
 					/* Swap was replaced by page: retry */
 					index = indices[i];

---
base-commit: ab3d40bdac831c67e130fda12f3011505556500f
change-id: 20260111-shmem-swap-fix-8d0e20a14b5d

Best regards,
-- 
Kairui Song <kasong@tencent.com>


