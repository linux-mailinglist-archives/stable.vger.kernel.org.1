Return-Path: <stable+bounces-185509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF5BD611B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DC74019D6
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D4BEEC0;
	Mon, 13 Oct 2025 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz+ARluB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D812DC794
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387087; cv=none; b=EJosNy+sy6Q7yqf4U3bfgPJBHrTfI3M0qPiw38qgryOmD0XCL4cSJqNf0VGYM9hOyLh0D1mSWM+r+qyQJtKyLkdN+Jeh9MSWz+Bd/ZCnXiAB54VfY8osv+2p78oQce19zxnmuggbQdawA09Wh4sqfVMUXRY9pSMv426FSjfagRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387087; c=relaxed/simple;
	bh=kTaNcQsuwfNc7EdxtK4dQZXXPYvRfBZzzVLecscWQh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3XjUnyHsRWkn2IOX7N8vDDyOtF9uKCgrbcwXQ7QJDKcYSMnhWBGlwOE0uyGjiiwCdxeb5EN5rq7rUg+ZZarXuOxQI6KjHS6MczV/vGk/EdXXgTTKYnbi7hfXZ/WN0ANaa90o3JLWmK5dD/XH48YYlfaLS14h+OIZvoyKXYm8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz+ARluB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596EDC4CEE7;
	Mon, 13 Oct 2025 20:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387086;
	bh=kTaNcQsuwfNc7EdxtK4dQZXXPYvRfBZzzVLecscWQh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fz+ARluBGKNMvf84B2ia8VQ4vsM0g9drHI8aWZFUcaOS/yb+CfJkluoIjFqUd35EP
	 TIgdLkqDCJCnvl4kWWb1zJJu4eTxOzu3aSuK3NGwlB1+OJ96fxvdIUi/iWvEgiwp2W
	 IT+Gpo4sAP1l5zKHn7+C1hbl2TmxaLeqVBooCW/b8fa6i+ur0zmO7PzxgjD4eMhjhR
	 xBsDc/7AqEBxptswFAz1HP69H++4j/JU0XjxhBWvg9CNQbbwDAAGwyVBvsntOqwAK/
	 3gtdENaK+6j3az+/2gQlBJlY4qzaKg2seVYUum/DwYjadWB8k5c5xEq38e66rM7+Wa
	 HsuWmlqBIZCgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] Squashfs: add additional inode sanity checking
Date: Mon, 13 Oct 2025 16:24:43 -0400
Message-ID: <20251013202444.3589382-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101320-sulphate-crafty-c0c4@gregkh>
References: <2025101320-sulphate-crafty-c0c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Lougher <phillip@squashfs.org.uk>

[ Upstream commit 9ee94bfbe930a1b39df53fa2d7b31141b780eb5a ]

Patch series "Squashfs: performance improvement and a sanity check".

This patchset adds an additional sanity check when reading regular file
inodes, and adds support for SEEK_DATA/SEEK_HOLE lseek() whence values.

This patch (of 2):

Add an additional sanity check when reading regular file inodes.

A regular file if the file size is an exact multiple of the filesystem
block size cannot have a fragment.  This is because by definition a
fragment block stores tailends which are not a whole block in size.

Link: https://lkml.kernel.org/r/20250923220652.568416-1-phillip@squashfs.org.uk
Link: https://lkml.kernel.org/r/20250923220652.568416-2-phillip@squashfs.org.uk
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 9f1c14c1de1b ("Squashfs: reject negative file sizes in squashfs_read_inode()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/squashfs/inode.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index d5918eba27e37..77eec1772998b 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -140,8 +140,17 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
+		inode->i_size = le32_to_cpu(sqsh_ino->file_size);
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
+			/*
+			 * the file cannot have a fragment (tailend) and have a
+			 * file size a multiple of the block size
+			 */
+			if ((inode->i_size & (msblk->block_size - 1)) == 0) {
+				err = -EINVAL;
+				goto failed_read;
+			}
 			frag_offset = le32_to_cpu(sqsh_ino->offset);
 			frag_size = squashfs_frag_lookup(sb, frag, &frag_blk);
 			if (frag_size < 0) {
@@ -155,7 +164,6 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		}
 
 		set_nlink(inode, 1);
-		inode->i_size = le32_to_cpu(sqsh_ino->file_size);
 		inode->i_fop = &generic_ro_fops;
 		inode->i_mode |= S_IFREG;
 		inode->i_blocks = ((inode->i_size - 1) >> 9) + 1;
@@ -183,8 +191,17 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
+		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
+			/*
+			 * the file cannot have a fragment (tailend) and have a
+			 * file size a multiple of the block size
+			 */
+			if ((inode->i_size & (msblk->block_size - 1)) == 0) {
+				err = -EINVAL;
+				goto failed_read;
+			}
 			frag_offset = le32_to_cpu(sqsh_ino->offset);
 			frag_size = squashfs_frag_lookup(sb, frag, &frag_blk);
 			if (frag_size < 0) {
@@ -199,7 +216,6 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 
 		xattr_id = le32_to_cpu(sqsh_ino->xattr);
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
-		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
 		inode->i_op = &squashfs_inode_ops;
 		inode->i_fop = &generic_ro_fops;
 		inode->i_mode |= S_IFREG;
-- 
2.51.0


