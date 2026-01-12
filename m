Return-Path: <stable+bounces-208137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5ED13925
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 16:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50EB4302AD89
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648942BEC21;
	Mon, 12 Jan 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjcnGNlK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EF1E4AF
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229760; cv=none; b=FG76EFaL+T3DTT27wBO7MzOapfJrWEOalIy3WEX1fnt0h0LIoucULaq6Yx60vWZdGbyfT82OTFBGxSmGtigyykmI6tbnh+8gJ4qruGdHnk6js3Sg6xcpYfbhqyBoj8FFdCMvfyvFSE6XPQS2p8pIniNmFWc+szP7ptiXy7l8z04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229760; c=relaxed/simple;
	bh=JQrsmT3OIDzkxvBU+skTTKcdXrs+aVxFFQMSvHqwOiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrJG5HFFpM0mAetUVYpg9raR+HG3Lq8FRlorWrew7Am2/+m3u3c5vUKruFleTz5lSTjpPlt4g+euek+UD2rbZrS2hCmnFXulJr+HgtA2PRBAXgbVFsut3Qypob41cPhnBcjbfNouI8IWrd8l2Xs6439/pFR7CGPuLwk7nSJjlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjcnGNlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5896DC19422;
	Mon, 12 Jan 2026 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229759;
	bh=JQrsmT3OIDzkxvBU+skTTKcdXrs+aVxFFQMSvHqwOiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjcnGNlKEQ7d4C8L6grprx3q2Apbv29rcco9lxiD7vTt1iqmUNYJV210MHo7697Yl
	 s4uojr81rM0T4EegOEjkEbXQX9HGgKhm56LDFIER5up+qP/7u0tpqZYifgr0PgM4Gb
	 z5f4NNut95AySJBjq0fOZNTMCWkcfIRcrTRuE/1G9GDkEbFCr01t6RxkTgNYk1rJ1i
	 RLe+ot/9xaSCeNlxa3umc7OLMaAj1DdEn7M/e2YcrpSosMNlsUuowaI0+dbS2ZaHZC
	 IWPmeeNGXhYIh8lLcjOOd6tWwvCtJr1K1/JQkOk84hHVrU60z3EknpuCHumrF/eLwc
	 RaisMH4Me9OQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/7] btrfs: add extra error messages for delalloc range related errors
Date: Mon, 12 Jan 2026 09:55:51 -0500
Message-ID: <20260112145555.720657-3-sashal@kernel.org>
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

[ Upstream commit 975a6a8855f45729a0fbfe2a8f2df2d3faef2a97 ]

All the error handling bugs I hit so far are all -ENOSPC from either:

- cow_file_range()
- run_delalloc_nocow()
- submit_uncompressed_range()

Previously when those functions failed, there was no error message at
all, making the debugging much harder.

So here we introduce extra error messages for:

- cow_file_range()
- run_delalloc_nocow()
- submit_uncompressed_range()
- writepage_delalloc() when btrfs_run_delalloc_range() failed
- extent_writepage() when extent_writepage_io() failed

One example of the new debug error messages is the following one:

  run fstests generic/750 at 2024-12-08 12:41:41
  BTRFS: device fsid 461b25f5-e240-4543-8deb-e7c2bd01a6d3 devid 1 transid 8 /dev/mapper/test-scratch1 (253:4) scanned by mount (2436600)
  BTRFS info (device dm-4): first mount of filesystem 461b25f5-e240-4543-8deb-e7c2bd01a6d3
  BTRFS info (device dm-4): using crc32c (crc32c-arm64) checksum algorithm
  BTRFS info (device dm-4): forcing free space tree for sector size 4096 with page size 65536
  BTRFS info (device dm-4): using free-space-tree
  BTRFS warning (device dm-4): read-write for sector size 4096 with page size 65536 is experimental
  BTRFS info (device dm-4): checking UUID tree
  BTRFS error (device dm-4): cow_file_range failed, root=363 inode=412 start=503808 len=98304: -28
  BTRFS error (device dm-4): run_delalloc_nocow failed, root=363 inode=412 start=503808 len=98304: -28
  BTRFS error (device dm-4): failed to run delalloc range, root=363 ino=412 folio=458752 submit_bitmap=11-15 start=503808 len=98304: -28

Which shows an error from cow_file_range() which is called inside a
nocow write attempt, along with the extra bitmap from
writepage_delalloc().

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: e9e3b22ddfa7 ("btrfs: fix beyond-EOF write handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 15 +++++++++++++++
 fs/btrfs/inode.c     | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d8d9f4c95c7ab..4c5288251f78f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1322,6 +1322,15 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 						       wbc);
 			if (ret >= 0)
 				last_finished_delalloc_end = found_start + found_len;
+			if (unlikely(ret < 0))
+				btrfs_err_rl(fs_info,
+"failed to run delalloc range, root=%lld ino=%llu folio=%llu submit_bitmap=%*pbl start=%llu len=%u: %d",
+					     btrfs_root_id(inode->root),
+					     btrfs_ino(inode),
+					     folio_pos(folio),
+					     fs_info->sectors_per_page,
+					     &bio_ctrl->submit_bitmap,
+					     found_start, found_len, ret);
 		} else {
 			/*
 			 * We've hit an error during previous delalloc range,
@@ -1621,6 +1630,12 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 				  PAGE_SIZE, bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
+	if (ret < 0)
+		btrfs_err_rl(fs_info,
+"failed to submit blocks, root=%lld inode=%llu folio=%llu submit_bitmap=%*pbl: %d",
+			     btrfs_root_id(inode->root), btrfs_ino(inode),
+			     folio_pos(folio), fs_info->sectors_per_page,
+			     &bio_ctrl->submit_bitmap, ret);
 
 	bio_ctrl->wbc->nr_to_write--;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 38323620b819e..b1d450459f736 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1163,6 +1163,10 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 		if (locked_folio)
 			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
 					     start, async_extent->ram_size);
+		btrfs_err_rl(inode->root->fs_info,
+			"%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
+			     __func__, btrfs_root_id(inode->root),
+			     btrfs_ino(inode), start, async_extent->ram_size, ret);
 	}
 }
 
@@ -1623,6 +1627,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					     &cached, clear_bits, page_ops);
 		btrfs_qgroup_free_data(inode, NULL, start, end - start + 1, NULL);
 	}
+	btrfs_err_rl(fs_info,
+		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
+		     __func__, btrfs_root_id(inode->root),
+		     btrfs_ino(inode), orig_start, end + 1 - orig_start, ret);
 	return ret;
 }
 
@@ -2373,6 +2381,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
 	}
 	btrfs_free_path(path);
+	btrfs_err_rl(fs_info,
+		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
+		     __func__, btrfs_root_id(inode->root),
+		     btrfs_ino(inode), start, end + 1 - start, ret);
 	return ret;
 }
 
-- 
2.51.0


