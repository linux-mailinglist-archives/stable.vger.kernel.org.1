Return-Path: <stable+bounces-196691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2DC80B4C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4801F3448F3
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84E3A1B5;
	Mon, 24 Nov 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iZAH3Ear"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E051A275
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990491; cv=none; b=cKVR4xIZc96jwAKv+NCi+4yyN4tH6ERLTP7y/wkuIto2IM8cysVOL6YRlQM6uUAQDO0y9DhbsFZHfai/zeWcpmvBZNUzbhTvd8rbtu6AJRIL2yI9BdZSIeX0q4NAEvDwfOCpNPogkomLU/gwcaPxHhj0091zgBiVROq8gCXH2oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990491; c=relaxed/simple;
	bh=QiXhJofLpjWM8KGFz97BhfQ+xkrHWTh8VlDUrLx+4RQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dOqcnrm25V/FZIpJFWGMf6sFx6rfMQrXXYCzalqk4XUtuOXmHaFv4NuO2nooEua3iazFG6/wsvVppmC3IWzw56SecuOsOePRyhwH/I+WU73oXeELkeWOoacm5EQyjKFvMtxbxsvWAyYEdgRzLvkjUjvdkCnvKj3NuBw12yLxqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iZAH3Ear; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B446C4CEF1;
	Mon, 24 Nov 2025 13:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763990490;
	bh=QiXhJofLpjWM8KGFz97BhfQ+xkrHWTh8VlDUrLx+4RQ=;
	h=Subject:To:Cc:From:Date:From;
	b=iZAH3EarqpoASjf5Z0m4G/bluxvi2yXGOjzgnD/GiDM+j5F8XM+FgAqLBQceaaPMs
	 lpSRM82gCk+cOrM1XpxJntNzNag+SsXI1C3GxtDSBGArlZRC/nVFACLcfxCMhlzfCx
	 kdfdvYawyzE6+ROhO3PjyoFAaCk4xfCn2cvRx33Y=
Subject: WTF: patch "[PATCH] block: add __must_check attribute to sb_min_blocksize()" was seriously submitted to be applied to the 6.15-stable tree?
To: yangyongpeng@xiaomi.com,brauner@kernel.org,hch@lst.de,jack@suse.cz,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:21:28 +0100
Message-ID: <2025112428-parsley-magnetize-c861@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below was submitted to be applied to the 6.15-stable tree.

I fail to see how this patch meets the stable kernel rules as found at
Documentation/process/stable-kernel-rules.rst.

I could be totally wrong, and if so, please respond to 
<stable@vger.kernel.org> and let me know why this patch should be
applied.  Otherwise, it is now dropped from my patch queues, never to be
seen again.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8637fa89e678422995301ddb20b74190dffcccee Mon Sep 17 00:00:00 2001
From: Yongpeng Yang <yangyongpeng@xiaomi.com>
Date: Tue, 4 Nov 2025 20:50:10 +0800
Subject: [PATCH] block: add __must_check attribute to sb_min_blocksize()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When sb_min_blocksize() returns 0 and the return value is not checked,
it may lead to a situation where sb->s_blocksize is 0 when
accessing the filesystem super block. After commit a64e5a596067bd
("bdev: add back PAGE_SIZE block size validation for
sb_set_blocksize()"), this becomes more likely to happen when the
block device’s logical_block_size is larger than PAGE_SIZE and the
filesystem is unformatted. Add the __must_check attribute to ensure
callers always check the return value.

Cc: stable@vger.kernel.org # v6.15
Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Link: https://patch.msgid.link/20251104125009.2111925-6-yangyongpeng.storage@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..638f0cd458ae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -231,7 +231,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 
 EXPORT_SYMBOL(sb_set_blocksize);
 
-int sb_min_blocksize(struct super_block *sb, int size)
+int __must_check sb_min_blocksize(struct super_block *sb, int size)
 {
 	int minsize = bdev_logical_block_size(sb->s_bdev);
 	if (size < minsize)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..3ea98c6cce81 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3423,8 +3423,8 @@ static inline void remove_inode_hash(struct inode *inode)
 extern void inode_sb_list_add(struct inode *inode);
 extern void inode_add_lru(struct inode *inode);
 
-extern int sb_set_blocksize(struct super_block *, int);
-extern int sb_min_blocksize(struct super_block *, int);
+int sb_set_blocksize(struct super_block *sb, int size);
+int __must_check sb_min_blocksize(struct super_block *sb, int size);
 
 int generic_file_mmap(struct file *, struct vm_area_struct *);
 int generic_file_mmap_prepare(struct vm_area_desc *desc);


