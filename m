Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1B783240
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjHUUCb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHUUCa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:02:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4DC11C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 544606480A
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAC5C433C8;
        Mon, 21 Aug 2023 20:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648146;
        bh=46XXh7Dqu6y9/xUNgxZxjcIDNtCkUhqNMOJFgv6Wi+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebWsL5onfqQofZw8kUj/ltw2rfiuLqvvLjsUZ1m0LnjcR4e26gfa03zVaElv4khQ4
         +c2hMdwpaA0I/066KqCHkfMvDF4oZLzap19/yFUqxHzCIJ3qWsou/Oh0IecE4lqgWo
         HW3OyrOy/5w1HT+tNmGD7m+64M4uUaf5mjHpVJVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 072/234] fs/ntfs3: Alternative boot if primary boot is corrupted
Date:   Mon, 21 Aug 2023 21:40:35 +0200
Message-ID: <20230821194131.949470567@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 6a4cd3ea7d771be17177d95ff67d22cfa2a38b50 ]

Some code refactoring added also.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 98 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 27 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 5158dd31fd97f..ecf899d571d83 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -724,6 +724,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	struct MFT_REC *rec;
 	u16 fn, ao;
 	u8 cluster_bits;
+	u32 boot_off = 0;
+	const char *hint = "Primary boot";
 
 	sbi->volume.blocks = dev_size >> PAGE_SHIFT;
 
@@ -731,11 +733,12 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	if (!bh)
 		return -EIO;
 
+check_boot:
 	err = -EINVAL;
-	boot = (struct NTFS_BOOT *)bh->b_data;
+	boot = (struct NTFS_BOOT *)Add2Ptr(bh->b_data, boot_off);
 
 	if (memcmp(boot->system_id, "NTFS    ", sizeof("NTFS    ") - 1)) {
-		ntfs_err(sb, "Boot's signature is not NTFS.");
+		ntfs_err(sb, "%s signature is not NTFS.", hint);
 		goto out;
 	}
 
@@ -748,14 +751,16 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 			   boot->bytes_per_sector[0];
 	if (boot_sector_size < SECTOR_SIZE ||
 	    !is_power_of_2(boot_sector_size)) {
-		ntfs_err(sb, "Invalid bytes per sector %u.", boot_sector_size);
+		ntfs_err(sb, "%s: invalid bytes per sector %u.", hint,
+			 boot_sector_size);
 		goto out;
 	}
 
 	/* cluster size: 512, 1K, 2K, 4K, ... 2M */
 	sct_per_clst = true_sectors_per_clst(boot);
 	if ((int)sct_per_clst < 0 || !is_power_of_2(sct_per_clst)) {
-		ntfs_err(sb, "Invalid sectors per cluster %u.", sct_per_clst);
+		ntfs_err(sb, "%s: invalid sectors per cluster %u.", hint,
+			 sct_per_clst);
 		goto out;
 	}
 
@@ -771,8 +776,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	if (mlcn * sct_per_clst >= sectors || mlcn2 * sct_per_clst >= sectors) {
 		ntfs_err(
 			sb,
-			"Start of MFT 0x%llx (0x%llx) is out of volume 0x%llx.",
-			mlcn, mlcn2, sectors);
+			"%s: start of MFT 0x%llx (0x%llx) is out of volume 0x%llx.",
+			hint, mlcn, mlcn2, sectors);
 		goto out;
 	}
 
@@ -784,7 +789,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* Check MFT record size. */
 	if (record_size < SECTOR_SIZE || !is_power_of_2(record_size)) {
-		ntfs_err(sb, "Invalid bytes per MFT record %u (%d).",
+		ntfs_err(sb, "%s: invalid bytes per MFT record %u (%d).", hint,
 			 record_size, boot->record_size);
 		goto out;
 	}
@@ -801,13 +806,13 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* Check index record size. */
 	if (sbi->index_size < SECTOR_SIZE || !is_power_of_2(sbi->index_size)) {
-		ntfs_err(sb, "Invalid bytes per index %u(%d).", sbi->index_size,
-			 boot->index_size);
+		ntfs_err(sb, "%s: invalid bytes per index %u(%d).", hint,
+			 sbi->index_size, boot->index_size);
 		goto out;
 	}
 
 	if (sbi->index_size > MAXIMUM_BYTES_PER_INDEX) {
-		ntfs_err(sb, "Unsupported bytes per index %u.",
+		ntfs_err(sb, "%s: unsupported bytes per index %u.", hint,
 			 sbi->index_size);
 		goto out;
 	}
@@ -834,7 +839,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* Compare boot's cluster and sector. */
 	if (sbi->cluster_size < boot_sector_size) {
-		ntfs_err(sb, "Invalid bytes per cluster (%u).",
+		ntfs_err(sb, "%s: invalid bytes per cluster (%u).", hint,
 			 sbi->cluster_size);
 		goto out;
 	}
@@ -930,7 +935,46 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	err = 0;
 
+	if (bh->b_blocknr && !sb_rdonly(sb)) {
+		/*
+	 	 * Alternative boot is ok but primary is not ok.
+	 	 * Update primary boot.
+		 */
+		struct buffer_head *bh0 = sb_getblk(sb, 0);
+		if (bh0) {
+			if (buffer_locked(bh0))
+				__wait_on_buffer(bh0);
+
+			lock_buffer(bh0);
+			memcpy(bh0->b_data, boot, sizeof(*boot));
+			set_buffer_uptodate(bh0);
+			mark_buffer_dirty(bh0);
+			unlock_buffer(bh0);
+			if (!sync_dirty_buffer(bh0))
+				ntfs_warn(sb, "primary boot is updated");
+			put_bh(bh0);
+		}
+	}
+
 out:
+	if (err == -EINVAL && !bh->b_blocknr && dev_size > PAGE_SHIFT) {
+		u32 block_size = min_t(u32, sector_size, PAGE_SIZE);
+		u64 lbo = dev_size - sizeof(*boot);
+
+		/*
+	 	 * Try alternative boot (last sector)
+		 */
+		brelse(bh);
+
+		sb_set_blocksize(sb, block_size);
+		bh = ntfs_bread(sb, lbo >> blksize_bits(block_size));
+		if (!bh)
+			return -EINVAL;
+
+		boot_off = lbo & (block_size - 1);
+		hint = "Alternative boot";
+		goto check_boot;
+	}
 	brelse(bh);
 
 	return err;
@@ -955,6 +999,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct ATTR_DEF_ENTRY *t;
 	u16 *shared;
 	struct MFT_REF ref;
+	bool ro = sb_rdonly(sb);
 
 	ref.high = 0;
 
@@ -1035,6 +1080,10 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->volume.minor_ver = info->minor_ver;
 	sbi->volume.flags = info->flags;
 	sbi->volume.ni = ni;
+	if (info->flags & VOLUME_FLAG_DIRTY) {
+		sbi->volume.real_dirty = true;
+		ntfs_info(sb, "It is recommened to use chkdsk.");
+	}
 
 	/* Load $MFTMirr to estimate recs_mirr. */
 	ref.low = cpu_to_le32(MFT_REC_MIRR);
@@ -1069,21 +1118,16 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	iput(inode);
 
-	if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
-		if (!sb_rdonly(sb)) {
-			ntfs_warn(sb,
-				  "failed to replay log file. Can't mount rw!");
-			err = -EINVAL;
-			goto out;
-		}
-	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
-		if (!sb_rdonly(sb) && !options->force) {
-			ntfs_warn(
-				sb,
-				"volume is dirty and \"force\" flag is not set!");
-			err = -EINVAL;
-			goto out;
-		}
+	if ((sbi->flags & NTFS_FLAGS_NEED_REPLAY) && !ro) {
+		ntfs_warn(sb, "failed to replay log file. Can't mount rw!");
+		err = -EINVAL;
+		goto out;
+	}
+
+	if ((sbi->volume.flags & VOLUME_FLAG_DIRTY) && !ro && !options->force) {
+		ntfs_warn(sb, "volume is dirty and \"force\" flag is not set!");
+		err = -EINVAL;
+		goto out;
 	}
 
 	/* Load $MFT. */
@@ -1173,7 +1217,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 		bad_len += len;
 		bad_frags += 1;
-		if (sb_rdonly(sb))
+		if (ro)
 			continue;
 
 		if (wnd_set_used_safe(&sbi->used.bitmap, lcn, len, &tt) || tt) {
-- 
2.40.1



