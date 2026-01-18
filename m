Return-Path: <stable+bounces-210226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2EED3982C
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 17:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCCDD30019C6
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD44D236454;
	Sun, 18 Jan 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0Lz7L1M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1AB17A2F0
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768755378; cv=none; b=JcLVAM6Q6Rhres+fxjyBzPxyqG2r71ZrXwZSAVavra01rPCtCvQxbPic2HR8TU+wMktV6e6JpZnr9uewL8PBIG41hmVH5+dqUFoPWfGVgtGahQ14ojIL6+mNliZp/zXCJ48ragGVKl1sulw8258urGrenMuPtkVSwRJS8EkGL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768755378; c=relaxed/simple;
	bh=5Zii4MngEcQqkljq4Uew6I6R51Po6q4NtGvCicrQOFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q8aT0FHkq6dqjxMaXhQuLt/hdZhiJglHh7C65FUpU3SBf6N4nWsjPTfLBXMYnoPpiyil23ijtzS6KzGp0EJ+j4T7mR16AsV6hPhN2Nk/kSipibE8paPydjC85drd9PdsDKZT4fs9odRdsFUwgPnCraNpREbkc1xPsZWhxKZGzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0Lz7L1M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a102494058so22378825ad.0
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 08:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768755375; x=1769360175; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jEppzu6eviBAXebQ+gZV8Uj3Kel+sc6ehG/jURfNuz4=;
        b=Y0Lz7L1MCD0tlPpFFLEBP82dyXOQhIDkAAT4vWreWDt4p0sQan3H9f+ZcVxvARUIxy
         E6ItiXuQ/3ltWbgaNrNvinQ/G9Mda4xwh1CJOrEWmirGPJPO2HRddiS80gY0kpb75GYi
         1L1xv3p17VZrkV4/5BDTjaMnT8A0kWYH/dDUe4zspSN4xv6sBjySnjaB0L+O3PWm8TvO
         TIidmompSZgvl1FBx4M04e+5qwUQo3RpPzQuA+VeVBwNRCjk6uG9b3ZpZEjL2PZOO5JW
         cSnxRYH4xuONn2zYJvp5c/roP3w4hiVxXQlh1cEU8U5W892FvjxL2lCnig/K6l/SiRRr
         ZshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768755375; x=1769360175;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEppzu6eviBAXebQ+gZV8Uj3Kel+sc6ehG/jURfNuz4=;
        b=dBDTbBkcg0OD1cleEJLFkkMjmw6YVidJmQ5v3edBhux+zqm/KDNJV/K8Ugd2bvaCYy
         5ITAH2QaSV3tyml0wUA0Vq+PLKp7z//vCvDTh4DOfyeX4R1YHlhoFnyUiHL0AAjaYHS1
         TI2/U6NUovqIx55yPTBYkUiEA6CokskcooHeYoUaSIuFQDbJS0UDmfGNC9EFOTEvVV33
         FqMbYdSa8hs7I5YYxI3RrJhLppjtsD232m0y5/nsJ4jEQ0oR6KZdbbHdVo4juFR1IVQn
         dYslepvjEjYebP9v4YGD4+2fwTzbkwnivoDKnEBYj52xtDpFpngZ08JPnzLJjqDlmXG0
         IHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqQpyWiPRaSvzxy8XEAl0bRKTCU7OdytwA9t/EofHWB6VXhS9bq9KPynzIoau5OSrdfw32qT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHbK2TtuWOKlIbWg+kMgVbdjmKSabvbfzD8lIzfwjDFCrr+qN
	5Bcbc0fOYtyIWg3i7DhKwt+hrlDYFwqgbMq/SyNQVVjkEsAHMzZVl9Yw
X-Gm-Gg: AY/fxX65Pd/zg/8HK1ieXbglFjkhF9PsyKQrLo2EoBOE38Lv7pfMxztnZLKlsar6I1l
	Bmkez4IXIXf5U1HZoJneWevmQHHMlMfwM4vJX/7biMPx3SbrG/38aRuCoa3Gy5R40aaehYy60cA
	k4II3AWTljqlZSBvxGu1Jf19rErzmIFB196HnTNccboHcKOgc72MPNMG7rB5AfPHBqr6hv9K6Sp
	KCr0eeJyuIcIIfNC2ZzPb1QHO0+jmTlvfxAnrEtP7SC3vpn921FMB4JJjZLcQIg3qOVTcjZ+Hog
	fFUjrKI/sT0Z/e4/GzluFujkzWHtkIv/574qzFQYjjoiWuM0oOA/0OVlVioL1djxWgPv2zuPh/i
	+PltvldDQ6P97O5ohM8K37/SbsT+U0cDbp7Q6s+KPgoKdPin9Jnx+mNAnzlD7aKHDb61iUIDuTT
	7/4sRWZd5CP5YBILpp2HmLI/Hx8rm0vz87iHcjZTI/oVP6mqv5
X-Received: by 2002:a17:902:c404:b0:295:4d97:84f9 with SMTP id d9443c01a7336-2a71782679dmr81632895ad.26.1768755375428;
        Sun, 18 Jan 2026 08:56:15 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbb28sm70415175ad.49.2026.01.18.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 08:56:14 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 19 Jan 2026 00:55:59 +0800
Subject: [PATCH v2] mm/shmem, swap: fix race of truncate and swap entry
 split
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-shmem-swap-fix-v2-1-034c946fd393@tencent.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13Myw7CIBCF4VdpZu0YBmm9rHwP0wWWwbIoNECqp
 uHdxSZuXP4nOd8KiaPjBJdmhciLSy74GnLXwDBq/2B0pjZIITtBRJjGiSdMTz2jdS88GcFSaFL
 31kA9zZHrvIG3vvboUg7xvfkLfdcfJf+phZBQ2IM6WmW7cyuvmf3APu+HMEFfSvkAp9SEmq4AA
 AA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768755372; l=4726;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=FMdqaw4ffv6MVren4jIFknJs8oVKQ1muaKKQ3HOeu28=;
 b=QyEwzfokU53F7BKHi8UG9l+VsxsJ0dnzLTd82d6PG959EqX+nQCxfNxLIy6MTv5UxJw4AVOcU
 LVWa5A8QldWCKwPNLVafnQK1e4nArWUErfvXejnNEedhAALQaSXnbgo
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=

From: Kairui Song <kasong@tencent.com>

The helper for shmem swap freeing is not handling the order of swap
entries correctly. It uses xa_cmpxchg_irq to erase the swap entry, but
it gets the entry order before that using xa_get_order without lock
protection, and it may get an outdated order value if the entry is split
or changed in other ways after the xa_get_order and before the
xa_cmpxchg_irq.

And besides, the order could grow and be larger than expected, and cause
truncation to erase data beyond the end border. For example, if the
target entry and following entries are swapped in or freed, then a large
folio was added in place and swapped out, using the same entry, the
xa_cmpxchg_irq will still succeed, it's very unlikely to happen though.

To fix that, open code the Xarray cmpxchg and put the order retrieval
and value checking in the same critical section. Also, ensure the order
won't exceed the end border, skip it if the entry goes across the
border.

Skipping large swap entries crosses the end border is safe here.
Shmem truncate iterates the range twice, in the first iteration,
find_lock_entries already filtered such entries, and shmem will
swapin the entries that cross the end border and partially truncate the
folio (split the folio or at least zero part of it). So in the second
loop here, if we see a swap entry that crosses the end order, it must
at least have its content erased already.

I observed random swapoff hangs and kernel panics when stress testing
ZSWAP with shmem. After applying this patch, all problems are gone.

Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Cc: stable@vger.kernel.org
Signed-off-by: Kairui Song <kasong@tencent.com>
---
Changes in v2:
- Fix a potential retry loop issue and improvement to code style thanks
  to Baoling Wang. I didn't split the change into two patches because a
  separate patch doesn't stand well as a fix.
- Link to v1: https://lore.kernel.org/r/20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com
---
 mm/shmem.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0b4c8c70d017..fadd5dd33d8b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -962,17 +962,29 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
  * being freed).
  */
 static long shmem_free_swap(struct address_space *mapping,
-			    pgoff_t index, void *radswap)
+			    pgoff_t index, pgoff_t end, void *radswap)
 {
-	int order = xa_get_order(&mapping->i_pages, index);
-	void *old;
+	XA_STATE(xas, &mapping->i_pages, index);
+	unsigned int nr_pages = 0;
+	pgoff_t base;
+	void *entry;
 
-	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
-	if (old != radswap)
-		return 0;
-	swap_put_entries_direct(radix_to_swp_entry(radswap), 1 << order);
+	xas_lock_irq(&xas);
+	entry = xas_load(&xas);
+	if (entry == radswap) {
+		nr_pages = 1 << xas_get_order(&xas);
+		base = round_down(xas.xa_index, nr_pages);
+		if (base < index || base + nr_pages - 1 > end)
+			nr_pages = 0;
+		else
+			xas_store(&xas, NULL);
+	}
+	xas_unlock_irq(&xas);
+
+	if (nr_pages)
+		swap_put_entries_direct(radix_to_swp_entry(radswap), nr_pages);
 
-	return 1 << order;
+	return nr_pages;
 }
 
 /*
@@ -1124,8 +1136,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += shmem_free_swap(mapping,
-							indices[i], folio);
+				nr_swaps_freed += shmem_free_swap(mapping, indices[i],
+								  end - 1, folio);
 				continue;
 			}
 
@@ -1191,12 +1203,23 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 			folio = fbatch.folios[i];
 
 			if (xa_is_value(folio)) {
+				int order;
 				long swaps_freed;
 
 				if (unfalloc)
 					continue;
-				swaps_freed = shmem_free_swap(mapping, indices[i], folio);
+				swaps_freed = shmem_free_swap(mapping, indices[i],
+							      end - 1, folio);
 				if (!swaps_freed) {
+					/*
+					 * If found a large swap entry cross the end border,
+					 * skip it as the truncate_inode_partial_folio above
+					 * should have at least zerod its content once.
+					 */
+					order = shmem_confirm_swap(mapping, indices[i],
+								   radix_to_swp_entry(folio));
+					if (order > 0 && indices[i] + order > end)
+						continue;
 					/* Swap was replaced by page: retry */
 					index = indices[i];
 					break;

---
base-commit: fe2c34b6ea5a0e1175c30d59bc1c28caafb02c62
change-id: 20260111-shmem-swap-fix-8d0e20a14b5d

Best regards,
-- 
Kairui Song <kasong@tencent.com>


