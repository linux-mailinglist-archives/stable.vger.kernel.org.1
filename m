Return-Path: <stable+bounces-128406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705AEA7CB04
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324BC172E1F
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87531C68F;
	Sat,  5 Apr 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="es8LAqpX"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793BDDCD
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743874369; cv=none; b=EX2jdUcZ/KXG/8/pPS39cIQ/OVW/mzA+upeKoUwX7Re+vcl4Y/iGPiEF254mmjGER6J2vYFkGkSn04dDE7PMXUTiAN27+NVBIhqSB5LRIAGlemO8lXysoiqWxGbs7aVsOaDLdRSYWQ5FySUkp/HlnyPchC4Su6BCGMoW3GKVuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743874369; c=relaxed/simple;
	bh=xoBNN7prixtaDgSCdbTmSFGPv2Ap8qfLfsDVSVImHCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhbri4m8a5KzSyaaz5XEmBTGGkSVYoQFQT8MDW4fbXoKPIITdEhYG9huei+Rjag2uJW/qS4tkppm0E7jix5j9/BKI0yODyPiRfAVtPU3ur2U+x6jg8qUsLmpO79W18FQzEkHmRIy/+hSOM5OuvnKwuNkSRDaQBiJeQaX8ccgiig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=es8LAqpX; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id DCBA84076187;
	Sat,  5 Apr 2025 17:32:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DCBA84076187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1743874355;
	bh=wpX2rOvpqhK6Qp+s+7osfVamD+rzWFUeIoyBVrwLceA=;
	h=From:To:Cc:Subject:Date:From;
	b=es8LAqpX2HqYkJft8hR3BE8WWQZftPQqsXlXh27j/VxROvSTuta/OrifiHGFXQN2T
	 1JiJLovPGGgBiK5//Tvc1TIpiQ+BPXiqZU2zELgYSjiEPP2NpQ57829l62Np0pMOiE
	 VYAf6wD+CZ5fmQ6Nu3n/AOS++37K553G3ND4Pfg4=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>,
	syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com,
	Roman Smirnov <r.smirnov@omp.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1] Revert "fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super"
Date: Sat,  5 Apr 2025 20:32:13 +0300
Message-ID: <20250405173214.295405-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f9c572d02fcced59c68f0287680fef9a5e0f5c9a which is
commit 91a4b1ee78cb100b19b70f077c247f211110348f upstream.

The backported version of the fix does a lot of things which it shouldn't
do and which the upstream commit doesn't touch as well.

Various auto-formatting changes and duplicate assignments made by the
ported version are not a big deal on its own, but what is more important,
it just drops 'sbi->zone_max' initialization for an unknown reason.
Original commit doesn't ever intend to do anything with that.

Better revert this commit from the stable branch for now.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

FWIW there exists another variant of this backport patch [1] which at a
quick glance looks more appropriate and was posted nearly a year ago.

I've added Roman - author of [1] - to Cc. Maybe he would be interested in
resending this so that it'd appear in your queue again. Anyway, it's up to
you to decide whether to take Roman's patch or just ignore it...

[1]: https://lore.kernel.org/stable/20240424101114.192681-2-r.smirnov@omp.ru/

 fs/ntfs3/ntfs_fs.h |  2 --
 fs/ntfs3/super.c   | 68 +++++++++++++++-------------------------------
 2 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index f2f32e304b3d..05d9abd66b37 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -42,11 +42,9 @@ enum utf16_endian;
 #define MINUS_ONE_T			((size_t)(-1))
 /* Biggest MFT / smallest cluster */
 #define MAXIMUM_BYTES_PER_MFT		4096
-#define MAXIMUM_SHIFT_BYTES_PER_MFT	12
 #define NTFS_BLOCKS_PER_MFT_RECORD	(MAXIMUM_BYTES_PER_MFT / 512)
 
 #define MAXIMUM_BYTES_PER_INDEX		4096
-#define MAXIMUM_SHIFT_BYTES_PER_INDEX	12
 #define NTFS_BLOCKS_PER_INODE		(MAXIMUM_BYTES_PER_INDEX / 512)
 
 /* NTFS specific error code when fixup failed. */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 674a16c0c66b..eee54214f4a3 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -680,7 +680,7 @@ static u32 true_sectors_per_clst(const struct NTFS_BOOT *boot)
  * ntfs_init_from_boot - Init internal info from on-disk boot sector.
  */
 static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
-		  u64 dev_size)
+			       u64 dev_size)
 {
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	int err;
@@ -705,12 +705,12 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* 0x55AA is not mandaroty. Thanks Maxim Suhanov*/
 	/*if (0x55 != boot->boot_magic[0] || 0xAA != boot->boot_magic[1])
-	 *  goto out;
+	 *	goto out;
 	 */
 
 	boot_sector_size = (u32)boot->bytes_per_sector[1] << 8;
 	if (boot->bytes_per_sector[0] || boot_sector_size < SECTOR_SIZE ||
-		!is_power_of_2(boot_sector_size)) {
+	    !is_power_of_2(boot_sector_size)) {
 		goto out;
 	}
 
@@ -733,49 +733,15 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* Check MFT record size. */
 	if ((boot->record_size < 0 &&
-		 SECTOR_SIZE > (2U << (-boot->record_size))) ||
-		(boot->record_size >= 0 && !is_power_of_2(boot->record_size))) {
-		goto out;
-	}
-
-	/* Calculate cluster size */
-	sbi->cluster_size = boot_sector_size * sct_per_clst;
-	sbi->cluster_bits = blksize_bits(sbi->cluster_size);
-
-	if (boot->record_size >= 0) {
-		record_size = (u32)boot->record_size << sbi->cluster_bits;
-	} else if (-boot->record_size <= MAXIMUM_SHIFT_BYTES_PER_MFT) {
-		record_size = 1u << (-boot->record_size);
-	} else {
-		ntfs_err(sb, "%s: invalid record size %d.", "NTFS",
-			 boot->record_size);
-		goto out;
-	}
-
-	sbi->record_size = record_size;
-	sbi->record_bits = blksize_bits(record_size);
-	sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes
-
-	if (record_size > MAXIMUM_BYTES_PER_MFT) {
-		ntfs_err(sb, "Unsupported bytes per MFT record %u.",
-			 record_size);
-		goto out;
-	}
-
-	if (boot->index_size >= 0) {
-		sbi->index_size = (u32)boot->index_size << sbi->cluster_bits;
-	} else if (-boot->index_size <= MAXIMUM_SHIFT_BYTES_PER_INDEX) {
-		sbi->index_size = 1u << (-boot->index_size);
-	} else {
-		ntfs_err(sb, "%s: invalid index size %d.", "NTFS",
-			 boot->index_size);
+	     SECTOR_SIZE > (2U << (-boot->record_size))) ||
+	    (boot->record_size >= 0 && !is_power_of_2(boot->record_size))) {
 		goto out;
 	}
 
 	/* Check index record size. */
 	if ((boot->index_size < 0 &&
-		 SECTOR_SIZE > (2U << (-boot->index_size))) ||
-		(boot->index_size >= 0 && !is_power_of_2(boot->index_size))) {
+	     SECTOR_SIZE > (2U << (-boot->index_size))) ||
+	    (boot->index_size >= 0 && !is_power_of_2(boot->index_size))) {
 		goto out;
 	}
 
@@ -796,6 +762,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		dev_size += sector_size - 1;
 	}
 
+	sbi->cluster_size = boot_sector_size * sct_per_clst;
+	sbi->cluster_bits = blksize_bits(sbi->cluster_size);
+
 	sbi->mft.lbo = mlcn << sbi->cluster_bits;
 	sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
 
@@ -816,9 +785,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	sbi->cluster_mask = sbi->cluster_size - 1;
 	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
 	sbi->record_size = record_size = boot->record_size < 0
-		? 1 << (-boot->record_size)
-		: (u32)boot->record_size
-		  << sbi->cluster_bits;
+						 ? 1 << (-boot->record_size)
+						 : (u32)boot->record_size
+							   << sbi->cluster_bits;
 
 	if (record_size > MAXIMUM_BYTES_PER_MFT || record_size < SECTOR_SIZE)
 		goto out;
@@ -832,8 +801,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		ALIGN(sizeof(enum ATTR_TYPE), 8);
 
 	sbi->index_size = boot->index_size < 0
-		? 1u << (-boot->index_size)
-		: (u32)boot->index_size << sbi->cluster_bits;
+				  ? 1u << (-boot->index_size)
+				  : (u32)boot->index_size << sbi->cluster_bits;
 
 	sbi->volume.ser_num = le64_to_cpu(boot->serial_num);
 
@@ -902,6 +871,13 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	sb->s_maxbytes = 0xFFFFFFFFull << sbi->cluster_bits;
 #endif
 
+	/*
+	 * Compute the MFT zone at two steps.
+	 * It would be nice if we are able to allocate 1/8 of
+	 * total clusters for MFT but not more then 512 MB.
+	 */
+	sbi->zone_max = min_t(CLST, 0x20000000 >> sbi->cluster_bits, clusters >> 3);
+
 	err = 0;
 
 out:
-- 
2.49.0


