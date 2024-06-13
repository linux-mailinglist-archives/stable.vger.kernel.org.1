Return-Path: <stable+bounces-51382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67733906FA5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464F61C22A05
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B681448FF;
	Thu, 13 Jun 2024 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rEbT0M51"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407281ABF;
	Thu, 13 Jun 2024 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281133; cv=none; b=BrY1D2/O3RRvP9YmhogkjCPlaK6AcGcjRrxMSfvB64vkqgbZGBJm8e4kPHf0CZsgZ+u/mkkdvN9X7tLoBjulaqif/AHaIvIKHb9C2oMd/QrBAK5Bbf2etoDFV7PZwfanz57lsJaYr0HPgjT2fHiVM+G5dcor2NF23PhRy0afaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281133; c=relaxed/simple;
	bh=B7w1xwyUbn8WTIhCqgVAadrj2lRbuQtLQdZy9YDeOZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfyFMJm3dO6CSLdxIdTzuBqOo8Pc47XmhRoOgY7dZ5Mnt0FQ4gM/BMeZlu+nFxw6J2xyy88+iRHvbF9pCV5Rvwk9EWgIm4UM95GoikejFQwDZg9ev5ZCVmz27DOdzh7WUvDmmsbWbjE+q2UGnpZHChE8GQmEOhmKzcac3O9nlck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rEbT0M51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48628C2BBFC;
	Thu, 13 Jun 2024 12:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281133;
	bh=B7w1xwyUbn8WTIhCqgVAadrj2lRbuQtLQdZy9YDeOZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEbT0M51iyDYNS3gK8oMvdG2M8rbv5DjrRKi2LFXgklIoC/bZ2yAwYX0ONV6hDMdp
	 iQdDvfOq7p4t38m00WK9DuY5eXuCTIANpKD5/Xu8LaGhA+bt4ZYg0ri9SLpwo8mGiv
	 3vJTyLUg67H88NGH2CbGf8Rjap5nsN3p93+46AVM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daeho Jeong <daehojeong@google.com>,
	Chao Yu <yuchao0@huawei.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 151/317] f2fs: add compress_mode mount option
Date: Thu, 13 Jun 2024 13:32:49 +0200
Message-ID: <20240613113253.407543015@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit 602a16d58e9aab3c423bcf051033ea6c9e8a6d37 ]

We will add a new "compress_mode" mount option to control file
compression mode. This supports "fs" and "user". In "fs" mode (default),
f2fs does automatic compression on the compression enabled files.
In "user" mode, f2fs disables the automaic compression and gives the
user discretion of choosing the target file and the timing. It means
the user can do manual compression/decompression on the compression
enabled files using ioctls.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 7c5dffb3d90c ("f2fs: compress: fix to relocate check condition in f2fs_{release,reserve}_compress_blocks()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/f2fs.rst | 35 ++++++++++++++++++++++++++++++
 fs/f2fs/compress.c                 |  2 +-
 fs/f2fs/data.c                     |  2 +-
 fs/f2fs/f2fs.h                     | 30 +++++++++++++++++++++++++
 fs/f2fs/segment.c                  |  2 +-
 fs/f2fs/super.c                    | 23 ++++++++++++++++++++
 6 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 3d21a9e86995f..de2bacc418fee 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -261,6 +261,13 @@ compress_extension=%s	 Support adding specified extension, so that f2fs can enab
 			 Note that, there is one reserved special extension '*', it
 			 can be set to enable compression for all files.
 compress_chksum		 Support verifying chksum of raw data in compressed cluster.
+compress_mode=%s	 Control file compression mode. This supports "fs" and "user"
+			 modes. In "fs" mode (default), f2fs does automatic compression
+			 on the compression enabled files. In "user" mode, f2fs disables
+			 the automaic compression and gives the user discretion of
+			 choosing the target file and the timing. The user can do manual
+			 compression/decompression on the compression enabled files using
+			 ioctls.
 inlinecrypt		 When possible, encrypt/decrypt the contents of encrypted
 			 files using the blk-crypto framework rather than
 			 filesystem-layer encryption. This allows the use of
@@ -811,6 +818,34 @@ Compress metadata layout::
 	| data length | data chksum | reserved |      compressed data       |
 	+-------------+-------------+----------+----------------------------+
 
+Compression mode
+--------------------------
+
+f2fs supports "fs" and "user" compression modes with "compression_mode" mount option.
+With this option, f2fs provides a choice to select the way how to compress the
+compression enabled files (refer to "Compression implementation" section for how to
+enable compression on a regular inode).
+
+1) compress_mode=fs
+This is the default option. f2fs does automatic compression in the writeback of the
+compression enabled files.
+
+2) compress_mode=user
+This disables the automaic compression and gives the user discretion of choosing the
+target file and the timing. The user can do manual compression/decompression on the
+compression enabled files using F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
+ioctls like the below.
+
+To decompress a file,
+
+fd = open(filename, O_WRONLY, 0);
+ret = ioctl(fd, F2FS_IOC_DECOMPRESS_FILE);
+
+To compress a file,
+
+fd = open(filename, O_WRONLY, 0);
+ret = ioctl(fd, F2FS_IOC_COMPRESS_FILE);
+
 NVMe Zoned Namespace devices
 ----------------------------
 
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c87020afda51f..6c870b741cfe5 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -929,7 +929,7 @@ int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 
 static bool cluster_may_compress(struct compress_ctx *cc)
 {
-	if (!f2fs_compressed_file(cc->inode))
+	if (!f2fs_need_compress_data(cc->inode))
 		return false;
 	if (f2fs_is_atomic_file(cc->inode))
 		return false;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e0533cffbb076..fc6c88e80cf4f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3222,7 +3222,7 @@ static inline bool __should_serialize_io(struct inode *inode,
 	if (IS_NOQUOTA(inode))
 		return false;
 
-	if (f2fs_compressed_file(inode))
+	if (f2fs_need_compress_data(inode))
 		return true;
 	if (wbc->sync_mode != WB_SYNC_ALL)
 		return true;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6dfefbf54917d..6a9f4dcea06d6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -150,6 +150,7 @@ struct f2fs_mount_info {
 	unsigned char compress_log_size;	/* cluster log size */
 	bool compress_chksum;			/* compressed data chksum */
 	unsigned char compress_ext_cnt;		/* extension count */
+	int compress_mode;			/* compression mode */
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
 };
 
@@ -681,6 +682,7 @@ enum {
 	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
 	FI_COMPRESS_CORRUPT,	/* indicate compressed cluster is corrupted */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
+	FI_ENABLE_COMPRESS,	/* enable compression in "user" compression mode */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -1255,6 +1257,18 @@ enum fsync_mode {
 	FSYNC_MODE_NOBARRIER,	/* fsync behaves nobarrier based on posix */
 };
 
+enum {
+	COMPR_MODE_FS,		/*
+				 * automatically compress compression
+				 * enabled files
+				 */
+	COMPR_MODE_USER,	/*
+				 * automatical compression is disabled.
+				 * user can control the file compression
+				 * using ioctls
+				 */
+};
+
 /*
  * this value is set in page as a private data which indicate that
  * the page is atomically written, and it is in inmem_pages list.
@@ -2795,6 +2809,22 @@ static inline int f2fs_compressed_file(struct inode *inode)
 		is_inode_flag_set(inode, FI_COMPRESSED_FILE);
 }
 
+static inline bool f2fs_need_compress_data(struct inode *inode)
+{
+	int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
+
+	if (!f2fs_compressed_file(inode))
+		return false;
+
+	if (compress_mode == COMPR_MODE_FS)
+		return true;
+	else if (compress_mode == COMPR_MODE_USER &&
+			is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
+		return true;
+
+	return false;
+}
+
 static inline unsigned int addrs_per_inode(struct inode *inode)
 {
 	unsigned int addrs = CUR_ADDRS_PER_INODE(inode) -
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a27a934292715..ad30908ac99f3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3296,7 +3296,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			else
 				return CURSEG_COLD_DATA;
 		}
-		if (file_is_cold(inode) || f2fs_compressed_file(inode))
+		if (file_is_cold(inode) || f2fs_need_compress_data(inode))
 			return CURSEG_COLD_DATA;
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 065aa01958e95..1281b59da6a2a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -147,6 +147,7 @@ enum {
 	Opt_compress_log_size,
 	Opt_compress_extension,
 	Opt_compress_chksum,
+	Opt_compress_mode,
 	Opt_atgc,
 	Opt_err,
 };
@@ -216,6 +217,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_compress_log_size, "compress_log_size=%u"},
 	{Opt_compress_extension, "compress_extension=%s"},
 	{Opt_compress_chksum, "compress_chksum"},
+	{Opt_compress_mode, "compress_mode=%s"},
 	{Opt_atgc, "atgc"},
 	{Opt_err, NULL},
 };
@@ -979,11 +981,26 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_compress_chksum:
 			F2FS_OPTION(sbi).compress_chksum = true;
 			break;
+		case Opt_compress_mode:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "fs")) {
+				F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
+			} else if (!strcmp(name, "user")) {
+				F2FS_OPTION(sbi).compress_mode = COMPR_MODE_USER;
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 #else
 		case Opt_compress_algorithm:
 		case Opt_compress_log_size:
 		case Opt_compress_extension:
 		case Opt_compress_chksum:
+		case Opt_compress_mode:
 			f2fs_info(sbi, "compression options not supported");
 			break;
 #endif
@@ -1571,6 +1588,11 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
 
 	if (F2FS_OPTION(sbi).compress_chksum)
 		seq_puts(seq, ",compress_chksum");
+
+	if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_FS)
+		seq_printf(seq, ",compress_mode=%s", "fs");
+	else if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER)
+		seq_printf(seq, ",compress_mode=%s", "user");
 }
 
 static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
@@ -1720,6 +1742,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
 	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
 	F2FS_OPTION(sbi).compress_ext_cnt = 0;
+	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 
 	sbi->sb->s_flags &= ~SB_INLINECRYPT;
-- 
2.43.0




