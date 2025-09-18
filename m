Return-Path: <stable+bounces-172376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B4EB31802
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CC31D22B93
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AA22FB63C;
	Fri, 22 Aug 2025 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VYyG1KJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE51A01BF;
	Fri, 22 Aug 2025 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866252; cv=none; b=StnwTcKGZLFjXAdrWMgsam7KP/grSw2RSppsSx7732aaezML2hzR6X8sVFpV9Sq4drhdTwYehthPEa7Xn25GgCuZAIxBvsEQCCAtt+EIvaXh2YqxZha4J+m27ZQu2iWwsERnRAVSPyALlMkN5NKXMviV5iyr7zUSK5hI77Olq0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866252; c=relaxed/simple;
	bh=+bLg7/9zRDc26rLO1acE93azcnnLQ95tHq7MuNVUf4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opJf6ANT/NP1kIy34MrANSVB09sOwpzl+9CIzoK3PcBWN1SabEgw1Ga132JIpJZvSV7tcGMIFrr6iXRSO2wVziHHI7JL/HIUkqeG3KwbYZeElFHmR6cUURBJswhCTk2sQUgRGkViF7rT0hdE7dtr4wZwOcQFWOmzRsqToQlEA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VYyG1KJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E4CC4CEED;
	Fri, 22 Aug 2025 12:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755866251;
	bh=+bLg7/9zRDc26rLO1acE93azcnnLQ95tHq7MuNVUf4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYyG1KJIMJGOVpx78g0pKn/Auh/OfqGpKg5yfk1rrtB9KITzNp84XztkluV6VtVJi
	 f2bGdsfRhfqArMSgp0nJ9B5q5GoZZjJ3EwnnlMLCSgk1dwz2UKifwcOUtNCrSyXJrx
	 nJDH1YJpXA6hOaCyiHhlRyAKBjlI9ob6no10i0Cg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.16 5/9] ext4: restart handle if credits are insufficient during allocating blocks
Date: Fri, 22 Aug 2025 14:37:05 +0200
Message-ID: <20250822123516.985354032@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822123516.780248736@linuxfoundation.org>
References: <20250822123516.780248736@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

commit e2c4c49dee64ca2f42ad2958cbe1805de96b6732 upstream.

After large folios are supported on ext4, writing back a sufficiently
large and discontinuous folio may consume a significant number of
journal credits, placing considerable strain on the journal. For
example, in a 20GB filesystem with 1K block size and 1MB journal size,
writing back a 2MB folio could require thousands of credits in the
worst-case scenario (when each block is discontinuous and distributed
across different block groups), potentially exceeding the journal size.
This issue can also occur in ext4_write_begin() and ext4_page_mkwrite()
when delalloc is not enabled.

Fix this by ensuring that there are sufficient journal credits before
allocating an extent in mpage_map_one_extent() and
ext4_block_write_begin(). If there are not enough credits, return
-EAGAIN, exit the current mapping loop, restart a new handle and a new
transaction, and allocating blocks on this folio again in the next
iteration.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250707140814.542883-6-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inode.c |   41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -877,6 +877,26 @@ static void ext4_update_bh_state(struct
 	} while (unlikely(!try_cmpxchg(&bh->b_state, &old_state, new_state)));
 }
 
+/*
+ * Make sure that the current journal transaction has enough credits to map
+ * one extent. Return -EAGAIN if it cannot extend the current running
+ * transaction.
+ */
+static inline int ext4_journal_ensure_extent_credits(handle_t *handle,
+						     struct inode *inode)
+{
+	int credits;
+	int ret;
+
+	/* Called from ext4_da_write_begin() which has no handle started? */
+	if (!handle)
+		return 0;
+
+	credits = ext4_chunk_trans_blocks(inode, 1);
+	ret = __ext4_journal_ensure_credits(handle, credits, credits, 0);
+	return ret <= 0 ? ret : -EAGAIN;
+}
+
 static int _ext4_get_block(struct inode *inode, sector_t iblock,
 			   struct buffer_head *bh, int flags)
 {
@@ -1175,7 +1195,9 @@ int ext4_block_write_begin(handle_t *han
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			WARN_ON(bh->b_size != blocksize);
-			err = get_block(inode, block, bh, 1);
+			err = ext4_journal_ensure_extent_credits(handle, inode);
+			if (!err)
+				err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
 			if (buffer_new(bh)) {
@@ -1374,8 +1396,9 @@ retry_journal:
 				ext4_orphan_del(NULL, inode);
 		}
 
-		if (ret == -ENOSPC &&
-		    ext4_should_retry_alloc(inode->i_sb, &retries))
+		if (ret == -EAGAIN ||
+		    (ret == -ENOSPC &&
+		     ext4_should_retry_alloc(inode->i_sb, &retries)))
 			goto retry_journal;
 		folio_put(folio);
 		return ret;
@@ -2324,6 +2347,11 @@ static int mpage_map_one_extent(handle_t
 	int get_blocks_flags;
 	int err, dioread_nolock;
 
+	/* Make sure transaction has enough credits for this extent */
+	err = ext4_journal_ensure_extent_credits(handle, inode);
+	if (err < 0)
+		return err;
+
 	trace_ext4_da_write_pages_extent(inode, map);
 	/*
 	 * Call ext4_map_blocks() to allocate any delayed allocation blocks, or
@@ -2451,7 +2479,7 @@ static int mpage_map_and_submit_extent(h
 			 * In the case of ENOSPC, if ext4_count_free_blocks()
 			 * is non-zero, a commit should free up blocks.
 			 */
-			if ((err == -ENOMEM) ||
+			if ((err == -ENOMEM) || (err == -EAGAIN) ||
 			    (err == -ENOSPC && ext4_count_free_clusters(sb))) {
 				/*
 				 * We may have already allocated extents for
@@ -2957,6 +2985,8 @@ retry:
 			ret = 0;
 			continue;
 		}
+		if (ret == -EAGAIN)
+			ret = 0;
 		/* Fatal error - ENOMEM, EIO... */
 		if (ret)
 			break;
@@ -6751,7 +6781,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_f
 retry_alloc:
 	/* Start journal and allocate blocks */
 	err = ext4_block_page_mkwrite(inode, folio, get_block);
-	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (err == -EAGAIN ||
+	    (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries)))
 		goto retry_alloc;
 out_ret:
 	ret = vmf_fs_error(err);



