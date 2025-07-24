Return-Path: <stable+bounces-164534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CDB0FEFC
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B29796755D
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A961C6FF5;
	Thu, 24 Jul 2025 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoxxq+gK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56422097
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325845; cv=none; b=oAyZZ2g1cROQ3H3msDllg6thSIoe69VU8UCiiQOMQpqFgyYiaQjnfjNfWNDPVWcu67Ait7vB/qfcwMWKbGhYvdyFCR4T7gdIzs71UGufhUegkYjPZ3Fh+seliazeFRSVSAehv2f5WlqRGSAmd9jDEgr7ckk+R6qS7hwB+Z+P1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325845; c=relaxed/simple;
	bh=v04iqq2oQBWE//NTTc6HfSqvm4Qr3Q4jUlWkdFoD938=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6oQrVTHVwuG6vwDzdFca7QUiWDk82gaz51u0AAqU6sNUUpcM1MUJ87hhP+IBxul1ZD0YTbe+WODwBDYBM65g9w1SNpVXxLxxXmANqfx/AA7nkTPPIHM/MXCrRcS6Jp6IxnDTPN8H9UTtGWJvC/9yqvF2xNVNduy5zniMfGvsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoxxq+gK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E99C4CEE7;
	Thu, 24 Jul 2025 02:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325845;
	bh=v04iqq2oQBWE//NTTc6HfSqvm4Qr3Q4jUlWkdFoD938=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qoxxq+gKXhsh+zp6vmDUOs+uEn0YpjPynlJqzdhPQauwXKutyXf4mEo/nJObMuEJg
	 Z29Dq0pLvKzID7tjhzkSFyRYxRVldkbkY0UExGQTuYl2i7APRvYlyFdU/yX3G1tdlp
	 50l33xzHg2DVM8PnycGAO9CQF6qwA9vcINNt3Ws1d1W72oogaF3Lt+Y78G1LaKp3ia
	 DSXAJVpUmanLiUCtwKgUPGCS7tm0d+6XDjLhUgcnW3HRRxsCD5xxjZnCtyUUGzksNq
	 kdWtB4eGnsTbKVzKnFW399hIbFzWlkvllLj1NAQaL0c6zS/Wf3NirJGLurE/XvfQQ/
	 nyVX9dKVLJw9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 01/11] ext4: don't explicit update times in ext4_fallocate()
Date: Wed, 23 Jul 2025 22:57:08 -0400
Message-Id: <20250724025718.1277650-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062009-junior-thriving-f882@gregkh>
References: <2025062009-junior-thriving-f882@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 73ae756ecdfa9684446134590eef32b0f067249c ]

After commit 'ad5cd4f4ee4d ("ext4: fix fallocate to use file_modified to
update permissions consistently"), we can update mtime and ctime
appropriately through file_modified() when doing zero range, collapse
rage, insert range and punch hole, hence there is no need to explicit
update times in those paths, just drop them.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20241220011637.1157197-3-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 29ec9bed2395 ("ext4: fix incorrect punch max_end")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 5 -----
 fs/ext4/inode.c   | 1 -
 2 files changed, 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b16d72275e105..43da9906b9240 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4675,8 +4675,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			goto out_mutex;
 		}
 
-		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
 		filemap_invalidate_unlock(mapping);
@@ -4700,7 +4698,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		goto out_mutex;
 	}
 
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ret = ext4_mark_inode_dirty(handle, inode);
@@ -5431,7 +5428,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5541,7 +5537,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f769f5cb6deb7..e4b6ab28d7055 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4113,7 +4113,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
-	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret2))
 		ret = ret2;
-- 
2.39.5


