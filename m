Return-Path: <stable+bounces-121876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA60AA59CE2
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42B83A87BF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B671232363;
	Mon, 10 Mar 2025 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SeHUB8lb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958C231A30;
	Mon, 10 Mar 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626886; cv=none; b=PXs+G/UvAh8Onm7xaHrAK/jWTfLSQNKSWc0HZrnKtvJygEYB8D3/Ew5X2bp9eln8xOPk/+4inWM9LOOZzxnpykGl+73MEthZXjLUoAbdmsyh9x/BRRxfwJ5G/FkvJ5VPqigyTRs9PpIw6YYxo9BsrLgisIl6kF2QfwYWMg1yruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626886; c=relaxed/simple;
	bh=TXy/iq+0nt//NozOcBHUBOJdkuTEOweOJ5krxW4UuY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8sCszuY3PJ6GLS7OVmsIxBZSC0MAvy4bgbsH4XSayJd9ASOcO/g5ycFcZh/gJ/k1dHMAvZg6ErrCH0uE6ylNjaMImrYFJWepcpQxlZUKabtgOWK26famrZqzgtRHxlUe5USMCjMm/mJ2x4Y9Mj354cJYrecFkfHVDEIZo5ZHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SeHUB8lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069A9C4CEE5;
	Mon, 10 Mar 2025 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626885;
	bh=TXy/iq+0nt//NozOcBHUBOJdkuTEOweOJ5krxW4UuY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeHUB8lbbYt815k+yPMLfdyA2g2LTewdRki5HO5emJ38O1ik+hTOy9gyzFz0P+nbq
	 tSRgrLFVuVJ8ukSXEeNHcyGxJkujikM82c42364TRtuOhnUwRLmFPxK+fbwibwABjc
	 H8MoPO2A8lSbsYsc19bEQBioZYG38h4D/XNGXkig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Kun Hu <huk23@m.fudan.edu.cn>
Subject: [PATCH 6.13 139/207] exfat: fix soft lockup in exfat_clear_bitmap
Date: Mon, 10 Mar 2025 18:05:32 +0100
Message-ID: <20250310170453.326291314@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 9da33619e0ca53627641bc97d1b93ec741299111 ]

bitmap clear loop will take long time in __exfat_free_cluster()
if data size of file/dir enty is invalid.
If cluster bit in bitmap is already clear, stop clearing bitmap go to
out of loop.

Fixes: 31023864e67a ("exfat: add fat entry operations")
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/balloc.c   | 10 ++++++++--
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/fatent.c   | 11 +++++++----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index ce9be95c9172f..9ff825f1502d5 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -141,7 +141,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	return 0;
 }
 
-void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
+int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 {
 	int i, b;
 	unsigned int ent_idx;
@@ -150,13 +150,17 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	struct exfat_mount_options *opts = &sbi->options;
 
 	if (!is_valid_cluster(sbi, clu))
-		return;
+		return -EIO;
 
 	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
 	i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
 	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
 
+	if (!test_bit_le(b, sbi->vol_amap[i]->b_data))
+		return -EIO;
+
 	clear_bit_le(b, sbi->vol_amap[i]->b_data);
+
 	exfat_update_bh(sbi->vol_amap[i], sync);
 
 	if (opts->discard) {
@@ -171,6 +175,8 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 			opts->discard = 0;
 		}
 	}
+
+	return 0;
 }
 
 /*
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 78be6964a8a08..d30ce18a88b7a 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -456,7 +456,7 @@ int exfat_count_num_clusters(struct super_block *sb,
 int exfat_load_bitmap(struct super_block *sb);
 void exfat_free_bitmap(struct exfat_sb_info *sbi);
 int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync);
-void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
+int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
 int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 9e5492ac409b0..6f3651c6ca91e 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -175,6 +175,7 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 		BITMAP_OFFSET_SECTOR_INDEX(sb, CLUSTER_TO_BITMAP_ENT(clu));
 
 	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+		int err;
 		unsigned int last_cluster = p_chain->dir + p_chain->size - 1;
 		do {
 			bool sync = false;
@@ -189,7 +190,9 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 				cur_cmap_i = next_cmap_i;
 			}
 
-			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			err = exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			if (err)
+				break;
 			clu++;
 			num_clusters++;
 		} while (num_clusters < p_chain->size);
@@ -210,12 +213,13 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 				cur_cmap_i = next_cmap_i;
 			}
 
-			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			if (exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode))))
+				break;
 			clu = n_clu;
 			num_clusters++;
 
 			if (err)
-				goto dec_used_clus;
+				break;
 
 			if (num_clusters >= sbi->num_clusters - EXFAT_FIRST_CLUSTER) {
 				/*
@@ -229,7 +233,6 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 		} while (clu != EXFAT_EOF_CLUSTER);
 	}
 
-dec_used_clus:
 	sbi->used_clusters -= num_clusters;
 	return 0;
 }
-- 
2.39.5




