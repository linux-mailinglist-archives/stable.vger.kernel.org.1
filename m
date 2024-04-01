Return-Path: <stable+bounces-34832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C2894115
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D921C216C6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC447A6B;
	Mon,  1 Apr 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wTJZ5f8m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A593E3F8F4;
	Mon,  1 Apr 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989448; cv=none; b=kRqT1WNx0lIDt5vvxMYGfobsr88Ny9qqZeWrESqTdXjrntK7lgF/bqGkhF/YEw2Ex6rjgewIKlPxK99U9HCjHtceGxdtlsoK/vV8BfbQLq6fs2pSosY/5EnH0XiUGHHcTW2ZitKHkw7CXPXQIAMx7JyHdllK1EqypEXoVBeTo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989448; c=relaxed/simple;
	bh=QHXImpzBGm/ILsn/7jvHMyl21hDj6UNJAgC/ohUmsb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3fXALnAkoY9pY4h35INWuUxkiU+CLHVOdHHCEGVa3YUcrrlUKkcO7NLjFG7mraU7mpjwIDBfesJB/cqh0k5xMSR72pMS8eCgubTwpB+WU+mvKrjJr9ZTbsEcEeatFZIF6Ngceol545pD5YjaGhqNrD5aGb6kb0VQCVX6fh8xoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wTJZ5f8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C5C433C7;
	Mon,  1 Apr 2024 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989448;
	bh=QHXImpzBGm/ILsn/7jvHMyl21hDj6UNJAgC/ohUmsb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wTJZ5f8mTvTyU8AbQU85yik8oltSp/TH3VSlOnRsewHJYRPcBX+jDgIE7XYuvHzv1
	 biFEA5MLd55IoX8aKaV02NUCMErbCp+ytggVo0Iiu7BKs44zJaQvJHnvPXVcCb5wOe
	 7elhmeTPoqmdRAnJXkFRXV3NFHa3gfHGqApe+wzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heming Zhao <heming.zhao@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 051/396] md/md-bitmap: fix incorrect usage for sb_index
Date: Mon,  1 Apr 2024 17:41:40 +0200
Message-ID: <20240401152549.446783478@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heming Zhao <heming.zhao@suse.com>

[ Upstream commit ecbd8ebb51bf7e4939d83b9e6022a55cac44ef06 ]

Commit d7038f951828 ("md-bitmap: don't use ->index for pages backing the
bitmap file") removed page->index from bitmap code, but left wrong code
logic for clustered-md. current code never set slot offset for cluster
nodes, will sometimes cause crash in clustered env.

Call trace (partly):
 md_bitmap_file_set_bit+0x110/0x1d8 [md_mod]
 md_bitmap_startwrite+0x13c/0x240 [md_mod]
 raid1_make_request+0x6b0/0x1c08 [raid1]
 md_handle_request+0x1dc/0x368 [md_mod]
 md_submit_bio+0x80/0xf8 [md_mod]
 __submit_bio+0x178/0x300
 submit_bio_noacct_nocheck+0x11c/0x338
 submit_bio_noacct+0x134/0x614
 submit_bio+0x28/0xdc
 submit_bh_wbc+0x130/0x1cc
 submit_bh+0x1c/0x28

Fixes: d7038f951828 ("md-bitmap: don't use ->index for pages backing the bitmap file")
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240223121128.28985-1-heming.zhao@suse.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-bitmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 6f9ff14971f98..42d4c38ba54d5 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -234,7 +234,8 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 	sector_t doff;
 
 	bdev = (rdev->meta_bdev) ? rdev->meta_bdev : rdev->bdev;
-	if (pg_index == store->file_pages - 1) {
+	/* we compare length (page numbers), not page offset. */
+	if ((pg_index - store->sb_index) == store->file_pages - 1) {
 		unsigned int last_page_size = store->bytes & (PAGE_SIZE - 1);
 
 		if (last_page_size == 0)
@@ -438,8 +439,8 @@ static void filemap_write_page(struct bitmap *bitmap, unsigned long pg_index,
 	struct page *page = store->filemap[pg_index];
 
 	if (mddev_is_clustered(bitmap->mddev)) {
-		pg_index += bitmap->cluster_slot *
-			DIV_ROUND_UP(store->bytes, PAGE_SIZE);
+		/* go to node bitmap area starting point */
+		pg_index += store->sb_index;
 	}
 
 	if (store->file)
@@ -952,6 +953,7 @@ static void md_bitmap_file_set_bit(struct bitmap *bitmap, sector_t block)
 	unsigned long index = file_page_index(store, chunk);
 	unsigned long node_offset = 0;
 
+	index += store->sb_index;
 	if (mddev_is_clustered(bitmap->mddev))
 		node_offset = bitmap->cluster_slot * store->file_pages;
 
@@ -982,6 +984,7 @@ static void md_bitmap_file_clear_bit(struct bitmap *bitmap, sector_t block)
 	unsigned long index = file_page_index(store, chunk);
 	unsigned long node_offset = 0;
 
+	index += store->sb_index;
 	if (mddev_is_clustered(bitmap->mddev))
 		node_offset = bitmap->cluster_slot * store->file_pages;
 
-- 
2.43.0




