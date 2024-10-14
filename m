Return-Path: <stable+bounces-84901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81F899D2C1
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A015285B7F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69AE1C8773;
	Mon, 14 Oct 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lTTq7oT7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7D1C8306;
	Mon, 14 Oct 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919614; cv=none; b=XA5pnOwYJxB4fg6m8tpofC+XeaOAPXuhWiebrGY8QPRzr+Nfffuzn10eTJ1nL3CS0T/oWKHlRw9ckrnveQLBN4OkjgIpSajqUvmtNZcAdAi9kqjDGawcT48iorTg0+0oydK9GP7FN9dgRI6pdVOaPKbVcpd5WrUw2KK4OLuNU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919614; c=relaxed/simple;
	bh=2A+VtHTS9U3IRQ9V+fi0lBs38tMxDuctPifqNg0gYts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBsvfYFh8LYOBrux3x7Gq/zWjuuzW5yhN/Im38PtHaeljXdXEl3IV1cKD9waB/dEknmCUgxFbpLpwufh3jqxEfYHELVmU5MBr8RAC5WrAGtiIVpkx/5i9czdpNC9TSIxyqb4bLiG1HYA1XzSQfrLOPyfLmGSBdJAFig2guOMsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lTTq7oT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9469C4CEC3;
	Mon, 14 Oct 2024 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728919614;
	bh=2A+VtHTS9U3IRQ9V+fi0lBs38tMxDuctPifqNg0gYts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTTq7oT7ttdUSn5OWJ97wjvIN5tgSjPAPFpSkIMuNNxFTFUpUt8etEKh3kVOWZheo
	 2oJRR05zHHhxZjndflhkhlK8/T5z6sXOMo8STPFPRUkTJzdzUBe8TkRNOEdyt3LDVF
	 QvtM2uBxUpuOvoYn675uXIEQTn/X3R7YzZ1+oPiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"linux-erofs@lists.ozlabs.org, LKML" <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yue Hu <huyue2@coolpad.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.1 657/798] erofs: set block size to the on-disk block size
Date: Mon, 14 Oct 2024 16:20:11 +0200
Message-ID: <20241014141243.862983581@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

From: Jingbo Xu <jefflexu@linux.alibaba.com>

commit d3c4bdcc756e60b95365c66ff58844ce75d1c8f8 upstream.

Set the block size to that specified in on-disk superblock.

Also remove the hard constraint of PAGE_SIZE block size for the
uncompressed device backend.  This constraint is temporarily remained
for compressed device and fscache backend, as there is more work needed
to handle the condition where the block size is not equal to PAGE_SIZE.

It is worth noting that the on-disk block size is read prior to
erofs_superblock_csum_verify(), as the read block size is needed in the
latter.

Besides, later we are going to make erofs refer to tar data blobs (which
is 512-byte aligned) for OCI containers, where the block size is 512
bytes.  In this case, the 512-byte block size may not be adequate for a
directory to contain enough dirents.  To fix this, we are also going to
introduce directory block size independent on the block size.

Due to we have already supported block size smaller than PAGE_SIZE now,
disable all these images with such separated directory block size until
we supported this feature later.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230313135309.75269-3-jefflexu@linux.alibaba.com
Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
[ Gao Xiang: apply this to 6.6.y to avoid further backport twists
             due to obsoleted EROFS_BLKSIZ. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/erofs_fs.h |    5 +++--
 fs/erofs/inode.c    |    3 ++-
 fs/erofs/internal.h |   10 +---------
 fs/erofs/super.c    |   45 +++++++++++++++++++++++++++++----------------
 4 files changed, 35 insertions(+), 28 deletions(-)

--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -53,7 +53,7 @@ struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
 	__le32 checksum;        /* crc32c(super_block) */
 	__le32 feature_compat;
-	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
+	__u8 blkszbits;         /* filesystem block size in bit shift */
 	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
 
 	__le16 root_nid;	/* nid of root directory */
@@ -75,7 +75,8 @@ struct erofs_super_block {
 	} __packed u1;
 	__le16 extra_devices;	/* # of devices besides the primary device */
 	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
-	__u8 reserved[6];
+	__u8 dirblkbits;	/* directory block size in bit shift */
+	__u8 reserved[5];
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 reserved2[24];
 };
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -291,7 +291,8 @@ static int erofs_fill_inode(struct inode
 	}
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		if (!erofs_is_fscache_mode(inode->i_sb))
+		if (!erofs_is_fscache_mode(inode->i_sb) &&
+		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
 			err = z_erofs_fill_inode(inode);
 		else
 			err = -EOPNOTSUPP;
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -146,7 +146,7 @@ struct erofs_sb_info {
 	u16 device_id_mask;	/* valid bits of device id to be used */
 
 	unsigned char islotbits;	/* inode slot unit size in bit shift */
-	unsigned char blkszbits;
+	unsigned char blkszbits;	/* filesystem block size in bit shift */
 
 	u32 sb_size;			/* total superblock size */
 	u32 build_time_nsec;
@@ -239,14 +239,6 @@ static inline int erofs_wait_on_workgrou
 					VAL != EROFS_LOCKED_MAGIC);
 }
 
-/* we strictly follow PAGE_SIZE and no buffer head yet */
-#define LOG_BLOCK_SIZE		PAGE_SHIFT
-#define EROFS_BLKSIZ		(1 << LOG_BLOCK_SIZE)
-
-#if (EROFS_BLKSIZ % 4096 || !EROFS_BLKSIZ)
-#error erofs cannot be used in this platform
-#endif
-
 enum erofs_kmap_type {
 	EROFS_NO_KMAP,		/* don't map the buffer */
 	EROFS_KMAP,		/* use kmap() to map the buffer */
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -285,7 +285,6 @@ static int erofs_read_superblock(struct
 	struct erofs_sb_info *sbi;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_super_block *dsb;
-	unsigned int blkszbits;
 	void *data;
 	int ret;
 
@@ -304,6 +303,16 @@ static int erofs_read_superblock(struct
 		goto out;
 	}
 
+	sbi->blkszbits  = dsb->blkszbits;
+	if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
+		erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
+		goto out;
+	}
+	if (dsb->dirblkbits) {
+		erofs_err(sb, "dirblkbits %u isn't supported", dsb->dirblkbits);
+		goto out;
+	}
+
 	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
 	if (erofs_sb_has_sb_chksum(sbi)) {
 		ret = erofs_superblock_csum_verify(sb, data);
@@ -312,19 +321,11 @@ static int erofs_read_superblock(struct
 	}
 
 	ret = -EINVAL;
-	blkszbits = dsb->blkszbits;
-	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
-	if (blkszbits != LOG_BLOCK_SIZE) {
-		erofs_err(sb, "blkszbits %u isn't supported on this platform",
-			  blkszbits);
-		goto out;
-	}
-
 	if (!check_layout_compatibility(sb, dsb))
 		goto out;
 
 	sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
-	if (sbi->sb_size > EROFS_BLKSIZ) {
+	if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
 		erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
 			  sbi->sb_size);
 		goto out;
@@ -678,8 +679,8 @@ static int erofs_fc_fill_super(struct su
 
 	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fscache_mode(sb)) {
-		sb->s_blocksize = EROFS_BLKSIZ;
-		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
+		sb->s_blocksize = PAGE_SIZE;
+		sb->s_blocksize_bits = PAGE_SHIFT;
 
 		err = erofs_fscache_register_fs(sb);
 		if (err)
@@ -689,8 +690,8 @@ static int erofs_fc_fill_super(struct su
 		if (err)
 			return err;
 	} else {
-		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
-			erofs_err(sb, "failed to set erofs blksize");
+		if (!sb_set_blocksize(sb, PAGE_SIZE)) {
+			errorfc(fc, "failed to set initial blksize");
 			return -EINVAL;
 		}
 
@@ -703,12 +704,24 @@ static int erofs_fc_fill_super(struct su
 	if (err)
 		return err;
 
-	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
-		BUILD_BUG_ON(EROFS_BLKSIZ != PAGE_SIZE);
+	if (sb->s_blocksize_bits != sbi->blkszbits) {
+		if (erofs_is_fscache_mode(sb)) {
+			errorfc(fc, "unsupported blksize for fscache mode");
+			return -EINVAL;
+		}
+		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
+			errorfc(fc, "failed to set erofs blksize");
+			return -EINVAL;
+		}
+	}
 
+	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
 		if (!sbi->dax_dev) {
 			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
 			clear_opt(&sbi->opt, DAX_ALWAYS);
+		} else if (sbi->blkszbits != PAGE_SHIFT) {
+			errorfc(fc, "unsupported blocksize for DAX");
+			clear_opt(&sbi->opt, DAX_ALWAYS);
 		}
 	}
 



