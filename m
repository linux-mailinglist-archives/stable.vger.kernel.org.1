Return-Path: <stable+bounces-68166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B09530F1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35791C22245
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE571494C5;
	Thu, 15 Aug 2024 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlNVPBev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A07DA9E;
	Thu, 15 Aug 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729701; cv=none; b=CUWvh4WaeiBLX+jZYGXJ0jWhvWLQqY4JOn2HI1761Gm9Q3pOcyCSzBrDyOhol7NM20IMmhGzM3gxRsEq8cdiKtSsullBd6m65LhRyrrdV+LnDfSra5E18ENAUJdJ0QrmhcZt9SlLnPyHUyy+r6PPKVwvx5xWUIJ5ZpTvIUlcZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729701; c=relaxed/simple;
	bh=nZoRRoaATUsqataoianwQQr0WuiUgLBoPCKnZKwHnUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgcSgN6tbohPxBpeq3pVEPKmC6VSgMoEYZqUix0AkHvQgEJxEwenpD5HqjbSiMdn46l4YwB61qaIUIMGr9tI3Niu3FYBW51fh88G2oz7MztYXuq//C0gktuTTvlKi0M7LP04YoXULfapAWEoHfUVFdB+H5leTRhg8uyga8MQCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlNVPBev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D21C32786;
	Thu, 15 Aug 2024 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729700;
	bh=nZoRRoaATUsqataoianwQQr0WuiUgLBoPCKnZKwHnUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlNVPBevAoGqluuomVsxjhbF8O23NfIm6Ho7vDZyVXGRyMmqGMfgp0RZcJaFgeoRO
	 rGtTSX2XXgRl7O3/Fkc/MJNjR04ZCxyMqML3hQ6KErTWqoe6NPrajgEXvZJK+SLPQT
	 /+zoGWpkIGZ1p1mBZNGfxfa7oH9wYQAFBj+CBNrQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 5.15 181/484] ext2: Verify bitmap and itable block numbers before using them
Date: Thu, 15 Aug 2024 15:20:39 +0200
Message-ID: <20240815131948.410114700@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 322a6aff03937aa1ece33b4e46c298eafaf9ac41 upstream.

Verify bitmap block numbers and inode table blocks are sane before using
them for checking bits in the block bitmap.

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext2/balloc.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -79,26 +79,33 @@ static int ext2_valid_block_bitmap(struc
 	ext2_grpblk_t next_zero_bit;
 	ext2_fsblk_t bitmap_blk;
 	ext2_fsblk_t group_first_block;
+	ext2_grpblk_t max_bit;
 
 	group_first_block = ext2_group_first_block_no(sb, block_group);
+	max_bit = ext2_group_last_block_no(sb, block_group) - group_first_block;
 
 	/* check whether block bitmap block number is set */
 	bitmap_blk = le32_to_cpu(desc->bg_block_bitmap);
 	offset = bitmap_blk - group_first_block;
-	if (!ext2_test_bit(offset, bh->b_data))
+	if (offset < 0 || offset > max_bit ||
+	    !ext2_test_bit(offset, bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
 	/* check whether the inode bitmap block number is set */
 	bitmap_blk = le32_to_cpu(desc->bg_inode_bitmap);
 	offset = bitmap_blk - group_first_block;
-	if (!ext2_test_bit(offset, bh->b_data))
+	if (offset < 0 || offset > max_bit ||
+	    !ext2_test_bit(offset, bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
 	/* check whether the inode table block number is set */
 	bitmap_blk = le32_to_cpu(desc->bg_inode_table);
 	offset = bitmap_blk - group_first_block;
+	if (offset < 0 || offset > max_bit ||
+	    offset + EXT2_SB(sb)->s_itb_per_group - 1 > max_bit)
+		goto err_out;
 	next_zero_bit = ext2_find_next_zero_bit(bh->b_data,
 				offset + EXT2_SB(sb)->s_itb_per_group,
 				offset);



