Return-Path: <stable+bounces-188251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 594B6BF3802
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05CC134ECA8
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312C2E22B4;
	Mon, 20 Oct 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivAzwDYR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1B2D63FF
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993491; cv=none; b=lsnl+76Aea6AwycmWflFXy6x8ixb/k4LZHJQRWbj9tbtA+n6yvoHHTy+k31YkFnG0LIf6UVgAEhV7/VOM2vgvAyyAsL3FGmbzMEHjLulw0Sji7zDSChAt984kMQNeQ9kSifluunPoa4HLgdurS4Ld9CvgFCCPauTKhN3vC69QBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993491; c=relaxed/simple;
	bh=AaEa0mdc322sGpCmti2cbkZA7gU2aXGAzFFFalnywr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ck7KlTginM7FqsMVaTtxwlOvt1PQAFnVptDxb2rs7kJvb7llXirPMAUtdvK8O0lyQdQAIOWr7/JjAfb37VgRGOgyoQL0TvUEhEiRRtn/9XAeB9MJVA7RZfS4IPP8Jv2WKfkWkywkcajav03ammm36qwd7RqUt89hQCJ8Ef42I3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivAzwDYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D4CC113D0;
	Mon, 20 Oct 2025 20:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993491;
	bh=AaEa0mdc322sGpCmti2cbkZA7gU2aXGAzFFFalnywr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivAzwDYRprcGwIPF1+0qf8WM2RG7T8RsPg8NeXYmjSVOdVM6hYHXRaf/BQEofujUD
	 QCIAPde3h/G+wm/jaH04sSeG//CCRv3PkfFFhKGnfq+T0nOydyCGvH3dWsN3rkadln
	 3vDKkc3QefMdd7DBdGfeOWCpzO9IQix9gR21k1yjKilfgorXqmp773pI9+UWV16wsc
	 60PXu3mBALgo49aNZCz0u53DiW3MHltEwYq2IVWeJMXVcLJ0lH5ZNZMOXqM4RqBjJP
	 qDXLLHLGwG6bfHsamvhHuQyIAjkrasdFffMCt4UbTgpbqZIE14/SAAaqhFjhqyMJ9c
	 E+vVR7gRMD1rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] f2fs: add a f2fs_get_block_locked helper
Date: Mon, 20 Oct 2025 16:51:25 -0400
Message-ID: <20251020205128.1912678-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102052-work-collected-f03f@gregkh>
References: <2025102052-work-collected-f03f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit cf342d3beda000b4c60990755ca7800de5038785 ]

This allows to keep the f2fs_do_map_lock based locking scheme
private to data.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 9d5c4f5c7a2c ("f2fs: fix wrong block mapping for multi-devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 16 ++++++++++++++--
 fs/f2fs/f2fs.h |  3 +--
 fs/f2fs/file.c |  4 +---
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ac7d0ed3fb894..e1df8241ebd1e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1192,7 +1192,7 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 	return err;
 }
 
-int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
+static int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
 {
 	struct extent_info ei = {0, };
 	struct inode *inode = dn->inode;
@@ -1432,7 +1432,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	return 0;
 }
 
-void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
+static void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
 {
 	if (flag == F2FS_GET_BLOCK_PRE_AIO) {
 		if (lock)
@@ -1447,6 +1447,18 @@ void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
 	}
 }
 
+int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	int err;
+
+	f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
+	err = f2fs_get_block(dn, index);
+	f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+
+	return err;
+}
+
 /*
  * f2fs_map_blocks() tries to find or build mapping relationship which
  * maps continuous logical blocks to physical blocks, and return such
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ad7bc58ce0a40..db7ecd55b732e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3783,7 +3783,7 @@ void f2fs_set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
 int f2fs_reserve_new_block(struct dnode_of_data *dn);
-int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index);
+int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index);
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
 struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 			blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs);
@@ -3794,7 +3794,6 @@ struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
 struct page *f2fs_get_new_data_page(struct inode *inode,
 			struct page *ipage, pgoff_t index, bool new_i_size);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
-void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			int create, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5e2a0cb8d24d9..f34692864ed11 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -113,10 +113,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	if (need_alloc) {
 		/* block allocation */
-		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = f2fs_get_block(&dn, page->index);
-		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+		err = f2fs_get_block_locked(&dn, page->index);
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-- 
2.51.0


