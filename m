Return-Path: <stable+bounces-10285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92085827439
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F92E2871FC
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40A54750;
	Mon,  8 Jan 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="unU6IhmW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA753806;
	Mon,  8 Jan 2024 15:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6113DC433C9;
	Mon,  8 Jan 2024 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728570;
	bh=DG8jWMlVX5pJpY3m/hl4/GqqO/SpYpEIHZ98m3InmCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unU6IhmWnW6Viu7An5UKbq2aNlvDICtos4ifV2EWtseOAj+eMWlQWle0ABXcWzuJ1
	 4XiNSN1DayTEj8SSfc00GcD0xCwpu7NA/DcVLwmZMn5esCY6di4I/mYkP49EVhNsq9
	 gT5zILtY7tXxumJHocMyMIP+EYHj695d8etd8nuY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 090/150] f2fs: clean up i_compress_flag and i_compress_level usage
Date: Mon,  8 Jan 2024 16:35:41 +0100
Message-ID: <20240108153515.385454364@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit b90e5086df6bf5ba819216d5ecf0667370bd565f ]

.i_compress_level was introduced by commit 3fde13f817e2 ("f2fs: compress:
support compress level"), but never be used.

This patch updates as below:
- load high 8-bits of on-disk .i_compress_flag to in-memory .i_compress_level
- load low 8-bits of on-disk .i_compress_flag to in-memory .i_compress_flag
- change type of in-memory .i_compress_flag from unsigned short to unsigned
char.

w/ above changes, we can avoid unneeded bit shift whenever during
.init_compress_ctx(), and shrink size of struct f2fs_inode_info.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: f5f3bd903a5d ("f2fs: set the default compress_level on ioctl")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c |  8 +++-----
 fs/f2fs/f2fs.h     |  7 +++----
 fs/f2fs/inode.c    | 16 +++++++++++++---
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 11d9dce994dbe..d509b47381d51 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -241,7 +241,7 @@ static int lz4_init_compress_ctx(struct compress_ctx *cc)
 	unsigned int size = LZ4_MEM_COMPRESS;
 
 #ifdef CONFIG_F2FS_FS_LZ4HC
-	if (F2FS_I(cc->inode)->i_compress_flag >> COMPRESS_LEVEL_OFFSET)
+	if (F2FS_I(cc->inode)->i_compress_level)
 		size = LZ4HC_MEM_COMPRESS;
 #endif
 
@@ -267,8 +267,7 @@ static void lz4_destroy_compress_ctx(struct compress_ctx *cc)
 #ifdef CONFIG_F2FS_FS_LZ4HC
 static int lz4hc_compress_pages(struct compress_ctx *cc)
 {
-	unsigned char level = F2FS_I(cc->inode)->i_compress_flag >>
-						COMPRESS_LEVEL_OFFSET;
+	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
 	int len;
 
 	if (level)
@@ -340,8 +339,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	zstd_cstream *stream;
 	void *workspace;
 	unsigned int workspace_size;
-	unsigned char level = F2FS_I(cc->inode)->i_compress_flag >>
-						COMPRESS_LEVEL_OFFSET;
+	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
 
 	if (!level)
 		level = F2FS_ZSTD_DEFAULT_CLEVEL;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f56abb39601ac..faf1a4953e845 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -840,7 +840,7 @@ struct f2fs_inode_info {
 	unsigned char i_compress_algorithm;	/* algorithm type */
 	unsigned char i_log_cluster_size;	/* log of cluster size */
 	unsigned char i_compress_level;		/* compress level (lz4hc,zstd) */
-	unsigned short i_compress_flag;		/* compress flag */
+	unsigned char i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
 
 	unsigned int atomic_write_cnt;
@@ -4339,9 +4339,8 @@ static inline int set_compress_context(struct inode *inode)
 	if ((F2FS_I(inode)->i_compress_algorithm == COMPRESS_LZ4 ||
 		F2FS_I(inode)->i_compress_algorithm == COMPRESS_ZSTD) &&
 			F2FS_OPTION(sbi).compress_level)
-		F2FS_I(inode)->i_compress_flag |=
-				F2FS_OPTION(sbi).compress_level <<
-				COMPRESS_LEVEL_OFFSET;
+		F2FS_I(inode)->i_compress_level =
+				F2FS_OPTION(sbi).compress_level;
 	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
 	set_inode_flag(inode, FI_COMPRESSED_FILE);
 	stat_inc_compr_inode(inode);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1fc7760499f10..933554985d328 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -450,11 +450,17 @@ static int do_read_inode(struct inode *inode)
 					(fi->i_flags & F2FS_COMPR_FL)) {
 		if (F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
 					i_log_cluster_size)) {
+			unsigned short compress_flag;
+
 			atomic_set(&fi->i_compr_blocks,
 					le64_to_cpu(ri->i_compr_blocks));
 			fi->i_compress_algorithm = ri->i_compress_algorithm;
 			fi->i_log_cluster_size = ri->i_log_cluster_size;
-			fi->i_compress_flag = le16_to_cpu(ri->i_compress_flag);
+			compress_flag = le16_to_cpu(ri->i_compress_flag);
+			fi->i_compress_level = compress_flag >>
+						COMPRESS_LEVEL_OFFSET;
+			fi->i_compress_flag = compress_flag &
+					(BIT(COMPRESS_LEVEL_OFFSET) - 1);
 			fi->i_cluster_size = 1 << fi->i_log_cluster_size;
 			set_inode_flag(inode, FI_COMPRESSED_FILE);
 		}
@@ -675,13 +681,17 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 		if (f2fs_sb_has_compression(F2FS_I_SB(inode)) &&
 			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
 							i_log_cluster_size)) {
+			unsigned short compress_flag;
+
 			ri->i_compr_blocks =
 				cpu_to_le64(atomic_read(
 					&F2FS_I(inode)->i_compr_blocks));
 			ri->i_compress_algorithm =
 				F2FS_I(inode)->i_compress_algorithm;
-			ri->i_compress_flag =
-				cpu_to_le16(F2FS_I(inode)->i_compress_flag);
+			compress_flag = F2FS_I(inode)->i_compress_flag |
+				F2FS_I(inode)->i_compress_level <<
+						COMPRESS_LEVEL_OFFSET;
+			ri->i_compress_flag = cpu_to_le16(compress_flag);
 			ri->i_log_cluster_size =
 				F2FS_I(inode)->i_log_cluster_size;
 		}
-- 
2.43.0




