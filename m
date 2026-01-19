Return-Path: <stable+bounces-210373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD23ED3B015
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 17:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9A7830133E0
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1970129E10F;
	Mon, 19 Jan 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5Kr307Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EB828850B
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839091; cv=none; b=B9UphMVPiWFeWRGW1KP91P2q3hn71qxwj+HyVT2J3je+VnX1jhFa/D3AYOIGPSU03330h7F4/8zh6IPCF2Tzg3xL4w9qf9mYNStC4aw0bkH91BNeKEV3kELgzEqTY0mEdVzTPvbCZ/JUoJlHoRsQdiHXh9qIsUMgcyXLTYZw/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839091; c=relaxed/simple;
	bh=LjPrxhlXashuskkdS1QinyAYIMs9j65wkVv5w4j2L5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y5XYkTq2ncdPBzULWkAhbbSt1mny9WULE1qwehViDivBq6tXlbfWz4mizo414DXSiSJBYoZxWUiwzu8vHHxj2KZhe90dr6wbL/3Qzw+Tspo8h30ttObSnY5CfOV9V+55UdDI+0v4zsFQyLO52p9uRz06aZ6YB/qdmWVpXc3bajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5Kr307Z; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c53421cdbfso433836985a.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768839089; x=1769443889; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjJfvLBGT103l6zGUDrj7QF6QyCPGm8jtIUaKkXRKrc=;
        b=G5Kr307ZszSjrqEClIqtEM5nko+kCRMJL/vZyPxv4jQYL28thVG3F2mWkA9W6qrm5S
         tWTlcwhNnFkyZJ2FD3ilCGHg8M9hBmCKN3o2Mcp7Z1vqY8YNpGxYc3ydnMaYNCqh/bWT
         fh4AS/GqFnenFgYmHWNkW+Ems1p4T8WvcB2fL0Ld9hFNOAbteIctEdTYQXdTnJFzZQUT
         wMNGuJuCFaZ+CUfxyVSuaFW4j2+AwSnr0+KS6Rm5jlTSW4y7vXDu9H/lNxVw4pHxxyxQ
         JFjLdmLix952znSSPaKRbNrGaUuXqbJ2EoIL3oDaHp9rXaY/NzJxvdC1zNa8HFmcfPy8
         Jp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768839089; x=1769443889;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjJfvLBGT103l6zGUDrj7QF6QyCPGm8jtIUaKkXRKrc=;
        b=wtTw+drMBrSLQbYMIRVCAWVva8B4oVIsqa1g/WGHtR0B9TfyK1f62NTUeQpTJnKBEm
         WIts+152YuJnh1Ql2z+2SFzQ9yp8mHnIGMlorCaqI92vSW7JDRn0GHBSMiJqJkh7uCR/
         FwN/JGsa9HRsMHTSKIc6X+mHVIJdanN3n8E/09xfgPPszEHNhfiY+jjdBInD8LaKf/5n
         tgpCj76qwE+ceMkchmY9EY74Z6wTboneytL/aAI+zCo65FM6B0V4Jd5FoyjGVgGblss8
         9Cl1/XQbtlpdeZarkaZ2zmOMaOqlszxLgyMKeOJe3DW8q++fEYoHbdYC6X04nyaMegKZ
         tCKA==
X-Forwarded-Encrypted: i=1; AJvYcCWee4xTqggmg9oFgYywfYfeG7PjeYUxa7SAOtPkay2B0AC1+Jsmbii6QXWvXX6deWXCWQ8WEKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHjMS9oRaYF/0uZyDEwvCVfmX+UxbYVjMiqfL3z7x2JZCFGqj
	Ln2y52K5ul8aqOfZr9puCyVNL7nBjcoch5WsNS5HJE2r6IWY0qn81chwaxF83I0EP6M=
X-Gm-Gg: AY/fxX59y/Bujq3Xm8TjRl6HbUtVYNXQl6rUc6b7tAQRejUTvHDeSvLmJdQcks6OuBi
	+VENT6oUlo6s8ynFb2SSDOFH0W6S31oXRiVHFxfgc9BVFHzlMmypc6vKo859tjyFL70MGADpfHC
	Ef9ZVKQ6uSFZXTtctM5fDegubOWEx+Wte/Y1FkCq6POBGjC6PA81e+d6pgOqg8WIqfEt158xDq6
	VpOlwbrwAnarPuYxRj8jsRZsMgzVsCsel99JOTDJ2dL+KcW2eJSs8+hdzQsYvzgrfOh1C76dtjZ
	ijDhtnvoPHFjYJdiJ5f/qcyzoJNLpLgtYgRpuvjJTIgZq8SZihGkxxjx6dT5yh+DvnlS0Bg1VwF
	5v+h1vXPBgjToNAFaoHPwrrHHwJF4hgwHSk/hxADCFNTVTDC8b7rqV/lzfJyo5+mWxCALJEvnlC
	OR39SCLTonAnB0r0i4P3If/sRSCTB5bjkcRYDyWjA2w2zRLHZ4
X-Received: by 2002:a05:620a:284b:b0:8b2:dfb3:dc2a with SMTP id af79cd13be357-8c6a67a2256mr1560628385a.75.1768839089399;
        Mon, 19 Jan 2026 08:11:29 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72985a8sm815336085a.54.2026.01.19.08.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:11:28 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 20 Jan 2026 00:11:21 +0800
Subject: [PATCH v3] mm/shmem, swap: fix race of truncate and swap entry
 split
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMSw7CIBSF4a0Yxl7DBVrFkfswDipcLIPSBhrUN
 N27tImJj+F/kvNNLFH0lNhxM7FI2SffhxJyu2GmbcKNwNvSTHBRc0SE1HbUQbo3Azj/gIPlJHi
 D6lpZVk5DpDKv4PlSuvVp7ONz9TMu65sSv1RGQOBOqr1TrtaVOI0UDIVxZ/qOLVgWn4D+A8QCS
 GW0qp2VWn4D8zy/AKtrZZzvAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768839084; l=4919;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=ysQSLUoYhwKPncamfXxkacphx1e+w1AheyJG0ahsEz8=;
 b=dpOk1lOYoQzKSE19Lc0fcCL6U4W81gszY7m55ZxxOMel9fsuqr7+PYmLX5KDsSrL9y1B9a+Wp
 osakKrgfLb1B/t56TuAvbwlAv2kxar3ZXjv9QbkK5p9baeoQUoDoXWA
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
Changes in v3:
- Rebased on top of mainline.
- Fix nr_pages calculation [ Baolin Wang ]
- Link to v2: https://lore.kernel.org/r/20260119-shmem-swap-fix-v2-1-034c946fd393@tencent.com

Changes in v2:
- Fix a potential retry loop issue and improvement to code style thanks
  to Baoling Wang. I didn't split the change into two patches because a
  separate patch doesn't stand well as a fix.
- Link to v1: https://lore.kernel.org/r/20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com
---
 mm/shmem.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ec6c01378e9d..6c3485d24d66 100644
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
-	free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
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
+		free_swap_and_cache_nr(radix_to_swp_entry(radswap), nr_pages);
 
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
+					if (order > 0 && indices[i] + (1 << order) > end)
+						continue;
 					/* Swap was replaced by page: retry */
 					index = indices[i];
 					break;

---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20260111-shmem-swap-fix-8d0e20a14b5d

Best regards,
-- 
Kairui Song <kasong@tencent.com>


