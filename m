Return-Path: <stable+bounces-185520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C694BD665A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C9218A6B13
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D272248AF;
	Mon, 13 Oct 2025 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEi6CrUX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4C2C187
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391907; cv=none; b=fCAP4cmjwamuUL/nF6+461WCAZtOcRBCyPDAyx2E7y2F+bRICFdeFiTh884efEiSYMpnven+4r5nbnrCSYzwQuPDqk8IV65qKslMZBUs7HYrT8ONKCdfcly53dkm68tKLLygCyZdEif4NoEKJW7ApBW5WsP2OxMpWlcCNYarZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391907; c=relaxed/simple;
	bh=dZZVjMZlX27ZuQusbI2TT5vrXyNcbiQ1O8qfhefjGXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nzw67xkbass2SO+lhICzMEqDCjdLeL/XBHtyF+2p9fsrdayjK5CfYAuk2TgqG6JbNgUdWv5uxH1/rghs8ckM6c75hY4imZPVsIFxZmKDh1GV5fnLemxXNWm9kwdEKb0Nc0Fd+ma4LqsX3ELEEz0P5FtVnby7vGUPOTRd6SaI2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEi6CrUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EA7C4CEFE;
	Mon, 13 Oct 2025 21:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391906;
	bh=dZZVjMZlX27ZuQusbI2TT5vrXyNcbiQ1O8qfhefjGXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lEi6CrUXZ7Bu37jxhzh2ZYe7G4Cai9LdOZAvnyQBNmdhfZ6metRUMdmAjgx7/PVw+
	 CxUJm81NSmtSKWR+qm8UjKzzVMfLju9O861DzZks2U1l5j9EIMS0mkZaYZRbGd8eOC
	 stbyU7yBy6sJVKKosNJ9eZQB4RqneHlH/4QrIPEzAZMuEJJv7bWG4Cm7W+qde0rl93
	 LXdlZnpsma3fVu+MGPZHAirgDE4+o0M5WEsbMUOEJ/osffxk6fLtc58WVLgG1hZoBj
	 7aVKojZ0lg7j+FxCLm/NbfD5OqGvZqwxn1Uyv50DVRwUx0lKb/5Eeox9Pghc4Xq5Bc
	 jV8BaAR/HqPIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] Squashfs: add additional inode sanity checking
Date: Mon, 13 Oct 2025 17:45:03 -0400
Message-ID: <20251013214504.3637196-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101321-update-disprove-8836@gregkh>
References: <2025101321-update-disprove-8836@gregkh>
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
index 95a9ff9e23997..eb6f577154d59 100644
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


