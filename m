Return-Path: <stable+bounces-90989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4049BEBF3
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF2428349D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3952C1FA25D;
	Wed,  6 Nov 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ts8IJRI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEA1FA247;
	Wed,  6 Nov 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897412; cv=none; b=Cj+NvxPCLUqDwNaT3iDJyWcMzKm7RLE+RSza0RvHvQaHe/CXWaEi2pmpj2Yw7sHjwaexMWCrdR8L6vqdMkWlRIGcHkyOzaSCF6Doo9pMSn3p5ZyoH39q9sPdrswr3+Yj1/z7imoTeN6HYWpBYJNywH0Aml0zQ4j/1lLsnxFfkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897412; c=relaxed/simple;
	bh=/FQoQW1IwaseRMG0qyOXwyCLFOZJUIrB6e3e+FP5gY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGLf0g07n+uLXGhxXpJMS7oumubW/xRjcXwxARZjEvpAwrbDEVviVJgWXVL9vXKnLSbVWmMsJZARtICTri8M4fufWD/72g+NakolBaBz0wuXRY26V6dcjj0DGp6ZUjWkdvAB24x6IwCxcaIb9ffbMoDkn3AqEjP4Orjtfhltcuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ts8IJRI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEC0C4CECD;
	Wed,  6 Nov 2024 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897411;
	bh=/FQoQW1IwaseRMG0qyOXwyCLFOZJUIrB6e3e+FP5gY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ts8IJRI/ZzhwzMmhj/CnFXrjAAF8uKXgS+Z0UXeVn0+hR090Owo0LB2X2TGcwlXeX
	 HESRvuw+DzzkXrXTExf8pUKvfcH6aM2DYlmFfRQ3tWPj9q5cwtdWr8ZyRry3uuI3Ks
	 ICnymc0cXnZsOdppT9zKCU2l6L2GC8YzSvmm8hCs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ruansy.fnst@fujitsu.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 045/151] fsdax: dax_unshare_iter needs to copy entire blocks
Date: Wed,  6 Nov 2024 13:03:53 +0100
Message-ID: <20241106120310.072265811@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

From: Darrick J. Wong <djwong@kernel.org>

[ Upstream commit 50793801fc7f6d08def48754fb0f0706b0cfc394 ]

The code that copies data from srcmap to iomap in dax_unshare_iter is
very very broken, which bfoster's recent fsx changes have exposed.

If the pos and len passed to dax_file_unshare are not aligned to an
fsblock boundary, the iter pos and length in the _iter function will
reflect this unalignment.

dax_iomap_direct_access always returns a pointer to the start of the
kmapped fsdax page, even if its pos argument is in the middle of that
page.  This is catastrophic for data integrity when iter->pos is not
aligned to a page, because daddr/saddr do not point to the same byte in
the file as iter->pos.  Hence we corrupt user data by copying it to the
wrong place.

If iter->pos + iomap_length() in the _iter function not aligned to a
page, then we fail to copy a full block, and only partially populate the
destination block.  This is catastrophic for data confidentiality
because we expose stale pmem contents.

Fix both of these issues by aligning copy_pos/copy_len to a page
boundary (remember, this is fsdax so 1 fsblock == 1 base page) so that
we always copy full blocks.

We're not done yet -- there's no call to invalidate_inode_pages2_range,
so programs that have the file range mmap'd will continue accessing the
old memory mapping after the file metadata updates have completed.

Be careful with the return value -- if the unshare succeeds, we still
need to return the number of bytes that the iomap iter thinks we're
operating on.

Cc: ruansy.fnst@fujitsu.com
Fixes: d984648e428b ("fsdax,xfs: port unshare to fsdax")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Link: https://lore.kernel.org/r/172796813328.1131942.16777025316348797355.stgit@frogsfrogsfrogs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dax.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5e7fc5017570d..8c09578fa0357 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1262,26 +1262,46 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
+	loff_t copy_pos = iter->pos;
+	u64 copy_len = iomap_length(iter);
+	u32 mod;
 	int id = 0;
 	s64 ret = 0;
 	void *daddr = NULL, *saddr = NULL;
 
 	if (!iomap_want_unshare_iter(iter))
-		return length;
+		return iomap_length(iter);
+
+	/*
+	 * Extend the file range to be aligned to fsblock/pagesize, because
+	 * we need to copy entire blocks, not just the byte range specified.
+	 * Invalidate the mapping because we're about to CoW.
+	 */
+	mod = offset_in_page(copy_pos);
+	if (mod) {
+		copy_len += mod;
+		copy_pos -= mod;
+	}
+
+	mod = offset_in_page(copy_pos + copy_len);
+	if (mod)
+		copy_len += PAGE_SIZE - mod;
+
+	invalidate_inode_pages2_range(iter->inode->i_mapping,
+				      copy_pos >> PAGE_SHIFT,
+				      (copy_pos + copy_len - 1) >> PAGE_SHIFT);
 
 	id = dax_read_lock();
-	ret = dax_iomap_direct_access(iomap, pos, length, &daddr, NULL);
+	ret = dax_iomap_direct_access(iomap, copy_pos, copy_len, &daddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	ret = dax_iomap_direct_access(srcmap, pos, length, &saddr, NULL);
+	ret = dax_iomap_direct_access(srcmap, copy_pos, copy_len, &saddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	if (copy_mc_to_kernel(daddr, saddr, length) == 0)
-		ret = length;
+	if (copy_mc_to_kernel(daddr, saddr, copy_len) == 0)
+		ret = iomap_length(iter);
 	else
 		ret = -EIO;
 
-- 
2.43.0




