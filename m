Return-Path: <stable+bounces-17851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7141784805D
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F228BE50
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE8C12E63;
	Sat,  3 Feb 2024 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B56foexP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976612E48;
	Sat,  3 Feb 2024 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933362; cv=none; b=tw2t7S65DrCgr1136NVLVWI9jE0/T1bvfrc+COPX3sRuQ0o140UoZx8yxz3LAav3TlvFtGTumGx9W23aYQ5aGEInj9MRcQfUBVJ7V+PZXHj/uHyPBjYShLZUT0dvapmqMAAroSWBX0h5KWT9i0P4M+ZhsyeIdJObgIDuNwCUs/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933362; c=relaxed/simple;
	bh=kfoBbVSbcsjFfrf3MAFKciNNcXUtpCFuSbirWxOvAz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhBHsRmmTcA2aawas2XLQan4t7/bIjvOLxGjtY8UvZJ2WhLwKOGiyjKtICNYmP+3hbpVBV1N8DRPFAq6GZK4DmApD5lBZkvD5DDxdW8wPXPuWd9pxRD/nox7MbYBhn2T3uyzNO7p7zXYHlNciN7Bvje8MzoUEll0PAqNIUOkYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B56foexP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED0C433F1;
	Sat,  3 Feb 2024 04:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933362;
	bh=kfoBbVSbcsjFfrf3MAFKciNNcXUtpCFuSbirWxOvAz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B56foexPrjYtxRr1PXDhBzcrw0AfXAgnjmun/Mmh0sHWCE8x3NbD990qpjVck9Jc/
	 vGafeKiJwtWSJS4rchvV0ya1LjmvXGZRRLEKSl5a5VZLCzM6nyBpcrQ9KcyOpceCJD
	 ANFCK3ld9tpXq8hlXPxU8buQ8+Gpo2Jz2kfb2qEU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 042/219] ext4: unify the type of flexbg_size to unsigned int
Date: Fri,  2 Feb 2024 20:03:35 -0800
Message-ID: <20240203035322.446625830@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 658a52344fb139f9531e7543a6e0015b630feb38 ]

The maximum value of flexbg_size is 2^31, but the maximum value of int
is (2^31 - 1), so overflow may occur when the type of flexbg_size is
declared as int.

For example, when uninit_mask is initialized in ext4_alloc_group_tables(),
if flexbg_size == 2^31, the initialized uninit_mask is incorrect, and this
may causes set_flexbg_block_bitmap() to trigger a BUG_ON().

Therefore, the flexbg_size type is declared as unsigned int to avoid
overflow and memory waste.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231023013057.2117948-2-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/resize.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 9833ab6db117..31f5da7f9f6c 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -241,7 +241,7 @@ struct ext4_new_flex_group_data {
  *
  * Returns NULL on failure otherwise address of the allocated structure.
  */
-static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned long flexbg_size)
+static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
 {
 	struct ext4_new_flex_group_data *flex_gd;
 
@@ -296,7 +296,7 @@ static void free_flex_gd(struct ext4_new_flex_group_data *flex_gd)
  */
 static int ext4_alloc_group_tables(struct super_block *sb,
 				struct ext4_new_flex_group_data *flex_gd,
-				int flexbg_size)
+				unsigned int flexbg_size)
 {
 	struct ext4_new_group_data *group_data = flex_gd->groups;
 	ext4_fsblk_t start_blk;
@@ -397,12 +397,12 @@ static int ext4_alloc_group_tables(struct super_block *sb,
 		group = group_data[0].group;
 
 		printk(KERN_DEBUG "EXT4-fs: adding a flex group with "
-		       "%d groups, flexbg size is %d:\n", flex_gd->count,
+		       "%u groups, flexbg size is %u:\n", flex_gd->count,
 		       flexbg_size);
 
 		for (i = 0; i < flex_gd->count; i++) {
 			ext4_debug(
-			       "adding %s group %u: %u blocks (%d free, %d mdata blocks)\n",
+			       "adding %s group %u: %u blocks (%u free, %u mdata blocks)\n",
 			       ext4_bg_has_super(sb, group + i) ? "normal" :
 			       "no-super", group + i,
 			       group_data[i].blocks_count,
@@ -1624,7 +1624,7 @@ static int ext4_flex_group_add(struct super_block *sb,
 static int ext4_setup_next_flex_gd(struct super_block *sb,
 				    struct ext4_new_flex_group_data *flex_gd,
 				    ext4_fsblk_t n_blocks_count,
-				    unsigned long flexbg_size)
+				    unsigned int flexbg_size)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
@@ -2010,8 +2010,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	ext4_fsblk_t o_blocks_count;
 	ext4_fsblk_t n_blocks_count_retry = 0;
 	unsigned long last_update_time = 0;
-	int err = 0, flexbg_size = 1 << sbi->s_log_groups_per_flex;
+	int err = 0;
 	int meta_bg;
+	unsigned int flexbg_size = ext4_flex_bg_size(sbi);
 
 	/* See if the device is actually as big as what was requested */
 	bh = ext4_sb_bread(sb, n_blocks_count - 1, 0);
-- 
2.43.0




