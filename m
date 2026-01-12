Return-Path: <stable+bounces-208136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147ED1370E
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 16:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45D6E302CB81
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CA22BDC32;
	Mon, 12 Jan 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUAI091s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F891F3B87
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229759; cv=none; b=FFNLpeuAF+0ICDDSRfQF+u99Fgl+VHs/HRYOJMnm/A249pyWqYgxnU1JvmRsTLO/SRhuATLvrgo4Fnia4NIHCC+0zT5zGH1ivgjdOTr4mPqQnQSwXmfwSNlg0a7Tl61Jm87GfoLmQ/iZPN5fMpyK/VswIi/7W/L/mk6iFFfB2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229759; c=relaxed/simple;
	bh=ZuqUkWhOBcoF6aIdBNlihm4eu15/FvJshQvWs4bZgog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxaIXthFCbX0GJqPXfPfzGGdcN9to6ixO9/R3NI8cEg6r7/hLv2WGDB5LimKTVDlO8tHedOrL2NSNKAIC07Sig2fbruipi++Pf7qNgFnV5DK7w3OCTvZIc5zcmoZ00bA7pGULy0mr29+CSCFDy8yy9DC0LHcaFPbUABmJhMUmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUAI091s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85685C16AAE;
	Mon, 12 Jan 2026 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229759;
	bh=ZuqUkWhOBcoF6aIdBNlihm4eu15/FvJshQvWs4bZgog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUAI091sB1d2A2sIWNa7w3jS2srkcLC+UPPJzW2/w+k9Qf0Va+K78g9azRkri8cB/
	 uHYuEVRiTceMm/mLKYJVh0yYkFUeQqdc8H8O4Ogt0YCoSHdjNiD/8QhPx4uTpcdZ62
	 vUITzW11W/DetCHweCtaJ4RwB2+d5KtSyn4+5HVEPY856D83bduRY2Y3AgHrSLrvK9
	 uovFDbf2HPgkHt0i+271dyEcgdc2Fn3hofLgRldihv0Pnfl7y7hBMQX6R/2ZPdz2oO
	 9p7YXKyPOxZ8QzsjviVscimMqfmz+eIRZ0yGeQyYfYtsCQmcRFoObepti4KVfbtyTY
	 H0q86sbpQ3fVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/7] btrfs: subpage: dump the involved bitmap when ASSERT() failed
Date: Mon, 12 Jan 2026 09:55:50 -0500
Message-ID: <20260112145555.720657-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112145555.720657-1-sashal@kernel.org>
References: <2026011242-empirical-gullible-4683@gregkh>
 <20260112145555.720657-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 61d730731b47eeee42ad11fc71e145d269acab8d ]

For btrfs_folio_assert_not_dirty() and btrfs_folio_set_lock(), we call
bitmap_test_range_all_zero() to ensure the involved range has no
dirty/lock bit already set.

However with my recent enhanced delalloc range error handling, I was
hitting the ASSERT() inside btrfs_folio_set_lock(), and it turns out
that some error handling path is not properly updating the folio flags.

So add some extra dumping for the ASSERTs to dump the involved bitmap
to help debug.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: e9e3b22ddfa7 ("btrfs: fix beyond-EOF write handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/subpage.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 71a56aaac7ad2..a1a358addc581 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -652,6 +652,28 @@ IMPLEMENT_BTRFS_PAGE_OPS(ordered, folio_set_ordered, folio_clear_ordered,
 IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
 			 folio_test_checked);
 
+#define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
+{									\
+	const int sectors_per_page = fs_info->sectors_per_page;		\
+									\
+	ASSERT(sectors_per_page < BITS_PER_LONG);			\
+	*dst = bitmap_read(subpage->bitmaps,				\
+			   sectors_per_page * btrfs_bitmap_nr_##name,	\
+			   sectors_per_page);				\
+}
+
+#define SUBPAGE_DUMP_BITMAP(fs_info, folio, name, start, len)		\
+{									\
+	const struct btrfs_subpage *subpage = folio_get_private(folio);	\
+	unsigned long bitmap;						\
+									\
+	GET_SUBPAGE_BITMAP(subpage, fs_info, name, &bitmap);		\
+	btrfs_warn(fs_info,						\
+	"dumpping bitmap start=%llu len=%u folio=%llu " #name "_bitmap=%*pbl", \
+		   start, len, folio_pos(folio),			\
+		   fs_info->sectors_per_page, &bitmap);			\
+}
+
 /*
  * Make sure not only the page dirty bit is cleared, but also subpage dirty bit
  * is cleared.
@@ -677,6 +699,10 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 	subpage = folio_get_private(folio);
 	ASSERT(subpage);
 	spin_lock_irqsave(&subpage->lock, flags);
+	if (unlikely(!bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits))) {
+		SUBPAGE_DUMP_BITMAP(fs_info, folio, dirty, start, len);
+		ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
+	}
 	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
@@ -706,23 +732,16 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 	nbits = len >> fs_info->sectorsize_bits;
 	spin_lock_irqsave(&subpage->lock, flags);
 	/* Target range should not yet be locked. */
-	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
+	if (unlikely(!bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits))) {
+		SUBPAGE_DUMP_BITMAP(fs_info, folio, locked, start, len);
+		ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
+	}
 	bitmap_set(subpage->bitmaps, start_bit, nbits);
 	ret = atomic_add_return(nbits, &subpage->nr_locked);
 	ASSERT(ret <= fs_info->sectors_per_page);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-#define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
-{									\
-	const int sectors_per_page = fs_info->sectors_per_page;		\
-									\
-	ASSERT(sectors_per_page < BITS_PER_LONG);			\
-	*dst = bitmap_read(subpage->bitmaps,				\
-			   sectors_per_page * btrfs_bitmap_nr_##name,	\
-			   sectors_per_page);				\
-}
-
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len)
 {
-- 
2.51.0


