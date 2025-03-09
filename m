Return-Path: <stable+bounces-121582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31AA5852E
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054C2188F3DC
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FAB1DE2C4;
	Sun,  9 Mar 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdFTWUlp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FC76026
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532348; cv=none; b=EtzHlQ6tkwWV8opKpOHHQLpZw7iN/lenCvXkdM6I7CXmkDJahtvcV9b5KYwcUe3hwVm8boh3qjI6yHSOc/RHY/dWy25Uv0po7Jg15xEdX1GH3aLzTf9QtAnyt85GUyj2Q9KwAtd4llC9f3zDibfsv7YNCNYMnDBbDC6gbPB297Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532348; c=relaxed/simple;
	bh=rjN+IvkouNcEO6Oipd/FmvbMLWPcGBGsEq5x9NXFmYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C/cr6KuXSTSiJOKtirOduvhY6bPT2CQn6NgkZ5xjEYKL59ytD6vWuHPEUuIatH3ILg21cADnPEyvCyNYz0mU8bHPFgnOA0X4uxc8fwCKWf8QVHMwSJkNLM9dI/mJaz4oavo6lI39Y6Z0Sa0uuNVQt6yu0NWrkHJtp3b44yere10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdFTWUlp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43938828d02so4573775e9.1
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741532344; x=1742137144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4eDKUpkWceGbLhKIC5MJoKk52Ya5XVk+vJg413podVw=;
        b=LdFTWUlp6jHDivtLGFq/YsAh2ytdgSFLF6dLaWkH3Zy2zFa86m9tMRIVyXGVCgxfpO
         FiowMwieXFdqYt3Ryn10yVOVHhDQjRL5Ai1cTklA+3Z5NNlLf4406fgqtPBZwCiXciO/
         zyA+xjSnxQvUgEcu6/lkNSqUKryVfLSlYLR7fr9tKGy0Luuo23zHJsCiMTfLP3W/39ot
         FSo0dcm+VcIdnW1c8a8lgD4/jvX7ztP4rDKkXpBRSLEoHmv0qpgAU0DckE6jlkmzTAXr
         VtcyVAVCsnjwWd0I9albcSODVLgU/CoHvvMdwBWYEZrjtk7eTHIdTLdIhT7XsU66OrE4
         jgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532344; x=1742137144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eDKUpkWceGbLhKIC5MJoKk52Ya5XVk+vJg413podVw=;
        b=eopuGNRo92oFtDw3BWgAcw3EttJZ6/sXWIZmQyJt3wWU0U/XJ2fnMU+MUDBE5EyBQx
         xFu5V3fKDxwMTHg+PQsI8u0IbP1rvfKljTzkhEvUP+Mfnp+hXA7hLh9F3Ctul+5kRwai
         7QfEiGffBnauJAbb8CEVkEaAqXUcLB6DVX51OGZWiphLuqJDIoFwTatiCnqjiLpj08MM
         wvBpajbAndHAqiF+iMPx7MO+5t6pubmFGC+mOSa12f9BTN0eQjrp0/JrBtfFc7t5RJJx
         ZONQ+ijipLGkB+mAbblurtKa2SPzoCoqiJLWqTGK7lLiDFf/AsllUtFD7pNBFNojg726
         UeAg==
X-Gm-Message-State: AOJu0YxIPvM5vTRhnWES0kD9jKLZf0HaFjuHBF6cqHPQPVHS3djCzNvu
	ujnb4ohDMTDmKTdOlmo6bM5YAcH0xEQqt28Amafvn0qrCiKdhwZIj6PnalYmvmQ=
X-Gm-Gg: ASbGncu5ysQRTTSGhWKbN/XeANJMdgOnBcBZDmk5LaxMn2xfe+eaHJomYBKKcI6eVz2
	Lv63Bl9YiApDDBMQA8qcuoQ9Sn6CWx1lmtIxginiLqkpkCPF75LIz8DR+NIctkg0QqkUG+8ksZc
	4SXF9fUqzmkKIPcS8FVE4qfBTnW3PStN5mJcX4xzyZOqPURD3WkKiVEWl7Ou2ezsJwafMONlYzP
	0oxa+4OTdNSmvhIWx13ZKQ/0j3Hm6LxGVfD7mmq2bUeaybKCdeXS2gkGGZaz2Tm1F0Lbh2JgGiS
	5ZXslOCPvLxdexZbfHd31v8Dwg6mUd9iDludGJ0ZU0NqaUU5zy1UKOihBEEGqsX/kouz6RxhcRl
	LwU1APtbelfp0BYSD1HswFr0=
X-Google-Smtp-Source: AGHT+IH8/7K44LCBF6zyCvt5wxuWfOxZCDHN3q0zdQEilBTlMUUtyoLer9iwqxpYEHzLmK8TqW5nZw==
X-Received: by 2002:a05:600c:3594:b0:439:88bb:d00b with SMTP id 5b1f17b1804b1-43ce6ebc91fmr13904205e9.5.1741532343475;
        Sun, 09 Mar 2025 07:59:03 -0700 (PDT)
Received: from pop-os.localdomain (16.146.78.188.dynamic.jazztel.es. [188.78.146.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcb8sm12261643f8f.33.2025.03.09.07.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:59:02 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+010986becd65dbf9464b@syzkaller.appspotmail.com,
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
Subject: [PATCH 5.15.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date: Sun,  9 Mar 2025 15:56:36 +0100
Message-Id: <20250309145636.633501-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 91a4b1ee78cb ("fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super")

This patch is a backport and fixes an UBSAN warning about shift-out-of-bounds in
ntfs_fill_super() function of the NTFS3 driver. The original code
incorrectly calculated MFT record size, causing undefined behavior
when performing bit shifts with values that exceed type limits.

The fix has been verified by executing the syzkaller reproducer test case.
After applying this patch, the system successfully handles the test case
without kernel panic or UBSAN warnings.

Bug: https://syzkaller.appspot.com/bug?extid=010986becd65dbf9464b
Reported-by: syzbot+010986becd65dbf9464b@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
(cherry picked from commit 91a4b1ee78cb100b19b70f077c247f211110348f)
---
 fs/ntfs3/ntfs_fs.h |  2 ++
 fs/ntfs3/super.c   | 63 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 7b46926e920c..c5ef0e0cdf59 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -43,9 +43,11 @@ enum utf16_endian;
 #define MINUS_ONE_T			((size_t)(-1))
 /* Biggest MFT / smallest cluster */
 #define MAXIMUM_BYTES_PER_MFT		4096
+#define MAXIMUM_SHIFT_BYTES_PER_MFT	12
 #define NTFS_BLOCKS_PER_MFT_RECORD	(MAXIMUM_BYTES_PER_MFT / 512)
 
 #define MAXIMUM_BYTES_PER_INDEX		4096
+#define MAXIMUM_SHIFT_BYTES_PER_INDEX	12
 #define NTFS_BLOCKS_PER_INODE		(MAXIMUM_BYTES_PER_INDEX / 512)
 
 /* NTFS specific error code when fixup failed. */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 78b086527331..abab388e413f 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -680,7 +680,7 @@ static u32 true_sectors_per_clst(const struct NTFS_BOOT *boot)
  * ntfs_init_from_boot - Init internal info from on-disk boot sector.
  */
 static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
-			       u64 dev_size)
+		  u64 dev_size)
 {
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	int err;
@@ -705,12 +705,12 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* 0x55AA is not mandaroty. Thanks Maxim Suhanov*/
 	/*if (0x55 != boot->boot_magic[0] || 0xAA != boot->boot_magic[1])
-	 *	goto out;
+	 *  goto out;
 	 */
 
 	boot_sector_size = (u32)boot->bytes_per_sector[1] << 8;
 	if (boot->bytes_per_sector[0] || boot_sector_size < SECTOR_SIZE ||
-	    !is_power_of_2(boot_sector_size)) {
+		!is_power_of_2(boot_sector_size)) {
 		goto out;
 	}
 
@@ -733,15 +733,49 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* Check MFT record size. */
 	if ((boot->record_size < 0 &&
-	     SECTOR_SIZE > (2U << (-boot->record_size))) ||
-	    (boot->record_size >= 0 && !is_power_of_2(boot->record_size))) {
+		 SECTOR_SIZE > (2U << (-boot->record_size))) ||
+		(boot->record_size >= 0 && !is_power_of_2(boot->record_size))) {
+		goto out;
+	}
+
+	/* Calculate cluster size */
+	sbi->cluster_size = boot_sector_size * sct_per_clst;
+	sbi->cluster_bits = blksize_bits(sbi->cluster_size);
+
+	if (boot->record_size >= 0) {
+		record_size = (u32)boot->record_size << sbi->cluster_bits;
+	} else if (-boot->record_size <= MAXIMUM_SHIFT_BYTES_PER_MFT) {
+		record_size = 1u << (-boot->record_size);
+	} else {
+		ntfs_err(sb, "%s: invalid record size %d.", "NTFS",
+			 boot->record_size);
+		goto out;
+	}
+
+	sbi->record_size = record_size;
+	sbi->record_bits = blksize_bits(record_size);
+	sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes
+
+	if (record_size > MAXIMUM_BYTES_PER_MFT) {
+		ntfs_err(sb, "Unsupported bytes per MFT record %u.",
+			 record_size);
+		goto out;
+	}
+
+	if (boot->index_size >= 0) {
+		sbi->index_size = (u32)boot->index_size << sbi->cluster_bits;
+	} else if (-boot->index_size <= MAXIMUM_SHIFT_BYTES_PER_INDEX) {
+		sbi->index_size = 1u << (-boot->index_size);
+	} else {
+		ntfs_err(sb, "%s: invalid index size %d.", "NTFS",
+			 boot->index_size);
 		goto out;
 	}
 
 	/* Check index record size. */
 	if ((boot->index_size < 0 &&
-	     SECTOR_SIZE > (2U << (-boot->index_size))) ||
-	    (boot->index_size >= 0 && !is_power_of_2(boot->index_size))) {
+		 SECTOR_SIZE > (2U << (-boot->index_size))) ||
+		(boot->index_size >= 0 && !is_power_of_2(boot->index_size))) {
 		goto out;
 	}
 
@@ -762,9 +796,6 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		dev_size += sector_size - 1;
 	}
 
-	sbi->cluster_size = boot_sector_size * sct_per_clst;
-	sbi->cluster_bits = blksize_bits(sbi->cluster_size);
-
 	sbi->mft.lbo = mlcn << sbi->cluster_bits;
 	sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
 
@@ -785,9 +816,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	sbi->cluster_mask = sbi->cluster_size - 1;
 	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
 	sbi->record_size = record_size = boot->record_size < 0
-						 ? 1 << (-boot->record_size)
-						 : (u32)boot->record_size
-							   << sbi->cluster_bits;
+		? 1 << (-boot->record_size)
+		: (u32)boot->record_size
+		  << sbi->cluster_bits;
 
 	if (record_size > MAXIMUM_BYTES_PER_MFT || record_size < SECTOR_SIZE)
 		goto out;
@@ -801,8 +832,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		ALIGN(sizeof(enum ATTR_TYPE), 8);
 
 	sbi->index_size = boot->index_size < 0
-				  ? 1u << (-boot->index_size)
-				  : (u32)boot->index_size << sbi->cluster_bits;
+		? 1u << (-boot->index_size)
+		: (u32)boot->index_size << sbi->cluster_bits;
 
 	sbi->volume.ser_num = le64_to_cpu(boot->serial_num);
 
@@ -879,6 +910,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	return err;
 }
 
+
+
 /*
  * ntfs_fill_super - Try to mount.
  */
-- 
2.34.1


