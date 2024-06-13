Return-Path: <stable+bounces-51381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51421906FA4
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE101F232BF
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160E51448E8;
	Thu, 13 Jun 2024 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jwYasnCf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697981ABF;
	Thu, 13 Jun 2024 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281130; cv=none; b=jpDCewkH0MBWSq3680wclkO7xW/CjeFirPM5orrTkB3p9ROrTWrkcKaOLvZK+NyUfcwgjvNXazdsQSPCZ93o5tho6OmXU0yMVjw6Jy2e+IJuYai2E95zJEzGlWKMm84J/a6cWsbOg65d6KVJg7/KK9Z6vKGStUJ/+68TkUQ4TII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281130; c=relaxed/simple;
	bh=JkVFPE/Pk2NUbDrQm/NcrUQkLbvkbwOd01T8i7TTz2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ut03JPHACA4piXHL8Z7GkgWEk0MMtLKYqUzv4kwBNijzrlIAAXjq3kJvBF7B3T5vDheZqopAYWMi9rs30VxAjSw4Hc8dzKwhDqTeXKvkriNJMtt+/JOKZIdf5ELSN86gpXPzcCJ6r4UEd+5PFOYkoZa4JriRzNDdh84mIDHuqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jwYasnCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDDAC2BBFC;
	Thu, 13 Jun 2024 12:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281130;
	bh=JkVFPE/Pk2NUbDrQm/NcrUQkLbvkbwOd01T8i7TTz2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwYasnCfB/LcZ1+txHnqKKyNQpDtlpSkU/G5RQkULuLSoyVQObKomAiFw004F438C
	 2el0h2eVnjwDeaR5tnmjhHLhENRCQlCOBZf0J1X0+J9D/ZvMPyu+LlBlr/BGObVBNy
	 ipOBo8oeuAU9tqzVB1WhK/sZlSCxn/3TgZcGVL6g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <yuchao0@huawei.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 150/317] f2fs: compress: support chksum
Date: Thu, 13 Jun 2024 13:32:48 +0200
Message-ID: <20240613113253.369781373@linuxfoundation.org>
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

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit b28f047b28c51d0b9864c34b097bb0b221ea7247 ]

This patch supports to store chksum value with compressed
data, and verify the integrality of compressed data while
reading the data.

The feature can be enabled through specifying mount option
'compress_chksum'.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 7c5dffb3d90c ("f2fs: compress: fix to relocate check condition in f2fs_{release,reserve}_compress_blocks()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/f2fs.rst |  1 +
 fs/f2fs/compress.c                 | 23 +++++++++++++++++++++++
 fs/f2fs/f2fs.h                     | 16 ++++++++++++++--
 fs/f2fs/inode.c                    |  3 +++
 fs/f2fs/super.c                    |  9 +++++++++
 include/linux/f2fs_fs.h            |  2 +-
 6 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 8c0fbdd8ce6fb..3d21a9e86995f 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -260,6 +260,7 @@ compress_extension=%s	 Support adding specified extension, so that f2fs can enab
 			 For other files, we can still enable compression via ioctl.
 			 Note that, there is one reserved special extension '*', it
 			 can be set to enable compression for all files.
+compress_chksum		 Support verifying chksum of raw data in compressed cluster.
 inlinecrypt		 When possible, encrypt/decrypt the contents of encrypted
 			 files using the blk-crypto framework rather than
 			 filesystem-layer encryption. This allows the use of
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index a94e102d15866..c87020afda51f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -589,6 +589,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 				f2fs_cops[fi->i_compress_algorithm];
 	unsigned int max_len, new_nr_cpages;
 	struct page **new_cpages;
+	u32 chksum = 0;
 	int i, ret;
 
 	trace_f2fs_compress_pages_start(cc->inode, cc->cluster_idx,
@@ -642,6 +643,11 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 
 	cc->cbuf->clen = cpu_to_le32(cc->clen);
 
+	if (fi->i_compress_flag & 1 << COMPRESS_CHKSUM)
+		chksum = f2fs_crc32(F2FS_I_SB(cc->inode),
+					cc->cbuf->cdata, cc->clen);
+	cc->cbuf->chksum = cpu_to_le32(chksum);
+
 	for (i = 0; i < COMPRESS_DATA_RESERVED_SIZE; i++)
 		cc->cbuf->reserved[i] = cpu_to_le32(0);
 
@@ -777,6 +783,23 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 
 	ret = cops->decompress_pages(dic);
 
+	if (!ret && fi->i_compress_flag & 1 << COMPRESS_CHKSUM) {
+		u32 provided = le32_to_cpu(dic->cbuf->chksum);
+		u32 calculated = f2fs_crc32(sbi, dic->cbuf->cdata, dic->clen);
+
+		if (provided != calculated) {
+			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
+				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
+				printk_ratelimited(
+					"%sF2FS-fs (%s): checksum invalid, nid = %lu, %x vs %x",
+					KERN_INFO, sbi->sb->s_id, dic->inode->i_ino,
+					provided, calculated);
+			}
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			WARN_ON_ONCE(1);
+		}
+	}
+
 out_vunmap_cbuf:
 	vm_unmap_ram(dic->cbuf, dic->nr_cpages);
 out_vunmap_rbuf:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 83ebc860508b0..6dfefbf54917d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -147,7 +147,8 @@ struct f2fs_mount_info {
 
 	/* For compression */
 	unsigned char compress_algorithm;	/* algorithm type */
-	unsigned compress_log_size;		/* cluster log size */
+	unsigned char compress_log_size;	/* cluster log size */
+	bool compress_chksum;			/* compressed data chksum */
 	unsigned char compress_ext_cnt;		/* extension count */
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
 };
@@ -678,6 +679,7 @@ enum {
 	FI_ATOMIC_REVOKE_REQUEST, /* request to drop atomic data */
 	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
+	FI_COMPRESS_CORRUPT,	/* indicate compressed cluster is corrupted */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
 	FI_MAX,			/* max flag, never be used */
 };
@@ -736,6 +738,7 @@ struct f2fs_inode_info {
 	atomic_t i_compr_blocks;		/* # of compressed blocks */
 	unsigned char i_compress_algorithm;	/* algorithm type */
 	unsigned char i_log_cluster_size;	/* log of cluster size */
+	unsigned short i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
 };
 
@@ -1281,9 +1284,15 @@ enum compress_algorithm_type {
 	COMPRESS_MAX,
 };
 
-#define COMPRESS_DATA_RESERVED_SIZE		5
+enum compress_flag {
+	COMPRESS_CHKSUM,
+	COMPRESS_MAX_FLAG,
+};
+
+#define COMPRESS_DATA_RESERVED_SIZE		4
 struct compress_data {
 	__le32 clen;			/* compressed data size */
+	__le32 chksum;			/* compressed data chksum */
 	__le32 reserved[COMPRESS_DATA_RESERVED_SIZE];	/* reserved */
 	u8 cdata[];			/* compressed data */
 };
@@ -3925,6 +3934,9 @@ static inline void set_compress_context(struct inode *inode)
 			F2FS_OPTION(sbi).compress_algorithm;
 	F2FS_I(inode)->i_log_cluster_size =
 			F2FS_OPTION(sbi).compress_log_size;
+	F2FS_I(inode)->i_compress_flag =
+			F2FS_OPTION(sbi).compress_chksum ?
+				1 << COMPRESS_CHKSUM : 0;
 	F2FS_I(inode)->i_cluster_size =
 			1 << F2FS_I(inode)->i_log_cluster_size;
 	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 87752550f78c8..3e98551f4186d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -455,6 +455,7 @@ static int do_read_inode(struct inode *inode)
 					le64_to_cpu(ri->i_compr_blocks));
 			fi->i_compress_algorithm = ri->i_compress_algorithm;
 			fi->i_log_cluster_size = ri->i_log_cluster_size;
+			fi->i_compress_flag = le16_to_cpu(ri->i_compress_flag);
 			fi->i_cluster_size = 1 << fi->i_log_cluster_size;
 			set_inode_flag(inode, FI_COMPRESSED_FILE);
 		}
@@ -633,6 +634,8 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 					&F2FS_I(inode)->i_compr_blocks));
 			ri->i_compress_algorithm =
 				F2FS_I(inode)->i_compress_algorithm;
+			ri->i_compress_flag =
+				cpu_to_le16(F2FS_I(inode)->i_compress_flag);
 			ri->i_log_cluster_size =
 				F2FS_I(inode)->i_log_cluster_size;
 		}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9a74d60f61dba..065aa01958e95 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -146,6 +146,7 @@ enum {
 	Opt_compress_algorithm,
 	Opt_compress_log_size,
 	Opt_compress_extension,
+	Opt_compress_chksum,
 	Opt_atgc,
 	Opt_err,
 };
@@ -214,6 +215,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_compress_algorithm, "compress_algorithm=%s"},
 	{Opt_compress_log_size, "compress_log_size=%u"},
 	{Opt_compress_extension, "compress_extension=%s"},
+	{Opt_compress_chksum, "compress_chksum"},
 	{Opt_atgc, "atgc"},
 	{Opt_err, NULL},
 };
@@ -974,10 +976,14 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
 			break;
+		case Opt_compress_chksum:
+			F2FS_OPTION(sbi).compress_chksum = true;
+			break;
 #else
 		case Opt_compress_algorithm:
 		case Opt_compress_log_size:
 		case Opt_compress_extension:
+		case Opt_compress_chksum:
 			f2fs_info(sbi, "compression options not supported");
 			break;
 #endif
@@ -1562,6 +1568,9 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
 		seq_printf(seq, ",compress_extension=%s",
 			F2FS_OPTION(sbi).extensions[i]);
 	}
+
+	if (F2FS_OPTION(sbi).compress_chksum)
+		seq_puts(seq, ",compress_chksum");
 }
 
 static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index a5dbb57a687fb..7dc2a06cf19a1 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -273,7 +273,7 @@ struct f2fs_inode {
 			__le64 i_compr_blocks;	/* # of compressed blocks */
 			__u8 i_compress_algorithm;	/* compress algorithm */
 			__u8 i_log_cluster_size;	/* log of cluster size */
-			__le16 i_padding;		/* padding */
+			__le16 i_compress_flag;		/* compress flag */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
 		} __packed;
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
-- 
2.43.0




