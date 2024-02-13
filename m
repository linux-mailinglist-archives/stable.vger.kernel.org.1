Return-Path: <stable+bounces-19617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78533852470
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 01:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33BF1C235F2
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 00:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C397869B;
	Tue, 13 Feb 2024 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVajYzjd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5A78689;
	Tue, 13 Feb 2024 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783767; cv=none; b=Qh2jMoVXJb4GjS+S/syCXwl5CdsRddPO9MA/Mj+s1+RfhO0r1xF4ggYSc+/j8UYAFIvAxcQdwDihLhuNeALSOfdXvOS+1z2mKBX6QeuxInYlFI3rFhPuUslvcuC30cmIt8wIHw1M1USwcxwafbJIUIKLJgXtKD5+AJH5Gl+UM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783767; c=relaxed/simple;
	bh=jUbgoeI+TxGjL9aC8xmsuzU6yIW6wihjfX50gCoBepA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn4EMm5CKBQmmSrMRdJonqD8URV5A20GzqVZWnVr6QIt3P7x+xOVZyUMUyGIdwArq3ib8xsTT+34Wh6O4YRfws2HwQCxCdQk7mEFxwH2p6lQIsWMZ9v1J/ggq2PcpvDAgYE6HfYWv9ZGM7zNG/PHPvKl/LnIh1pdid+0a7DzHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVajYzjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D82AC433F1;
	Tue, 13 Feb 2024 00:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783767;
	bh=jUbgoeI+TxGjL9aC8xmsuzU6yIW6wihjfX50gCoBepA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVajYzjdCYxGTJvIx5w0bq+8MSTWev9JTAO/cyAyo1vLiTk+AfRtttkodAlKCmgTr
	 Hh3t95cmVgrGb3Lktx4UANs30BrtYM+fswQQgv29lmbqZhkNn9WbtLw0afwVMm8jLA
	 mJFrpkh5XOqdnY5tHfssKr+I4yiZh+6c55M84IoY0XW6H83MXCgeq+LNNQ3i2yMeZc
	 zqHC0gftFgPC3vXDevTaLx/rWUk2IEltIj6pNAgEkDF/msT2QUdHE5ngpQH2mHLdGD
	 ZE9JV+0GylA2qyiE9LUDlb/YjpqbHUCeaDdp6xqsTWEcLPkhlgEXjSnvoKLFbBVgwR
	 s8FrX4dJfv+FA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 09/28] fs/ntfs3: Prevent generic message "attempt to access beyond end of device"
Date: Mon, 12 Feb 2024 19:22:07 -0500
Message-ID: <20240213002235.671934-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 5ca87d01eba7bdfe9536a157ca33c1455bb8d16c ]

It used in test environment.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c  | 24 ++++++++++++++++++++++++
 fs/ntfs3/ntfs_fs.h | 14 +-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 873b1434a998..34813429e2ab 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -976,6 +976,30 @@ static inline __le32 security_hash(const void *sd, size_t bytes)
 	return cpu_to_le32(hash);
 }
 
+/*
+ * simple wrapper for sb_bread_unmovable.
+ */
+struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block)
+{
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	struct buffer_head *bh;
+
+	if (unlikely(block >= sbi->volume.blocks)) {
+		/* prevent generic message "attempt to access beyond end of device" */
+		ntfs_err(sb, "try to read out of volume at offset 0x%llx",
+			 (u64)block << sb->s_blocksize_bits);
+		return NULL;
+	}
+
+	bh = sb_bread_unmovable(sb, block);
+	if (bh)
+		return bh;
+
+	ntfs_err(sb, "failed to read volume at offset 0x%llx",
+		 (u64)block << sb->s_blocksize_bits);
+	return NULL;
+}
+
 int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer)
 {
 	struct block_device *bdev = sb->s_bdev;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 977e1422f904..cbeda94d7161 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -580,6 +580,7 @@ bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
 int log_replay(struct ntfs_inode *ni, bool *initialized);
 
 /* Globals from fsntfs.c */
+struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block);
 bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes);
 int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 		       bool simple);
@@ -1012,19 +1013,6 @@ static inline u64 bytes_to_block(const struct super_block *sb, u64 size)
 	return (size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
 }
 
-static inline struct buffer_head *ntfs_bread(struct super_block *sb,
-					     sector_t block)
-{
-	struct buffer_head *bh = sb_bread_unmovable(sb, block);
-
-	if (bh)
-		return bh;
-
-	ntfs_err(sb, "failed to read volume at offset 0x%llx",
-		 (u64)block << sb->s_blocksize_bits);
-	return NULL;
-}
-
 static inline struct ntfs_inode *ntfs_i(struct inode *inode)
 {
 	return container_of(inode, struct ntfs_inode, vfs_inode);
-- 
2.43.0


