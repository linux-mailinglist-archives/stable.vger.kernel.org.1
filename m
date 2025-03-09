Return-Path: <stable+bounces-121581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 108D5A58519
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 15:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787E6188E52D
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C2C14A09E;
	Sun,  9 Mar 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VprLWWUI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E09460
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532095; cv=none; b=sP04HQnXkF8Em9AA4dtOella2tLkLLJ56COGtn0yFPWAeXtUPSPhweIwAO7DuESKHIhUFWs7VytTs1uWWKp19VD7DpjrI+H7mPhWrif6MMIAjTvU8SKmhj5Nuo7cu9mD5EFKHGpgDGG6dLnT+fZXp1i20bh/HJsADNNY443CkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532095; c=relaxed/simple;
	bh=qF2LT3v8via3NOe5kV/gSv7OT7v2j+Qy6kPpUwdbT1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oZNTtWFW5OR9mi7NWbhFi0P/bSJp9FRdIiPPXEfaIAos/abvKSAociZDRvJsfA8KZRjC+bcpGZuRRdz5Q5Nylflf1STkrsVEZpcWF1aCueV8RjwQrLCbvANt7el4qxjKmZIB1oaiNfmGxSeTGoibNRC/pg4kkdPb98rptdcKgm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VprLWWUI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf825f46bso32235e9.3
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741532092; x=1742136892; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nn10Lx68II/Cb77RP/oOgpTDoED/8NGgWqnJ5fqFJJ8=;
        b=VprLWWUI49SBVC9ogJdnB9JZbvsTCZaa95t3QUVWXP03jshWjoGXAgcKm8rRxvd0my
         1n4SZpTSIs3dBKf3AHA54BtTlbkMQzW8WIq+mQc61PiK/OC2j7fxFrYBtfBDowGmFEwY
         iVvOkK34hC8SPnDGRhZEv5elFgpKl5WhJ7RiAOG2HuT3BFXhyPX01Ws0NDwfdxhBODOE
         ap/Eq0vbDWQTXGFAHM/x8eeCR/e8jrYG1/4zqd14vfDcm83NgfY+FTgTPpE1QHAvy6mV
         NIChu7QJcMHX/xxWDBBU+GVzK+rO6f+oiJg16zj0kwZcxvLMztT6UhT8vls3DytcokyX
         LZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532092; x=1742136892;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn10Lx68II/Cb77RP/oOgpTDoED/8NGgWqnJ5fqFJJ8=;
        b=SPSzpKLVzfqlu3v7KitNVQU5NBPzxF9tT2B5ni10Ir5VfHHjnLCn031JWwDl3SAIRA
         ObOSe2HBG2r6ZaG/CIy1cMrwzx3rJm78Itw+qzFBTLA7PjbeCKHYfQpNNIJOiyDQrB3R
         aJgQr67rechqnUs3K9Ofew5j4BfWTT45jf9n0g7fDejfPg02tTAl1YgJf6R3kSD+ENUU
         0BGPPqz1OyZQ9evEnA3Sd6ElHKVhYcvXQC3MdLlLa+8hSRRFHXe1Q8Ip/I1JXTK656iW
         5LCfNsrkwtPTy5SaFumbg6im8mK0AVXPd2kBRB7K8yWIAg9KGxoc1TSDlN3N93bDeZa/
         tWSA==
X-Gm-Message-State: AOJu0YyPc8WVEL9Ct5SQPtl3pjKj6mOVliZe70CiPMQyLBPbJKqU+WUs
	QBHcQn2VLu226uGC4/tCudR8o3HTMXHkm6CNdRyiUUnIQFOSx0QGu7YScGEE
X-Gm-Gg: ASbGncufD3IcTvY9fGAFuX+YAI55dF3Onu2qP62xvETED4lsOHCT6te7IelK2B3JnJ7
	3aWWBYsh3UU69a+A9yXrAyLE+ZgTj3X7RDC31zFxK2O4W+3NEfK/ACF1BeCjPDzPRspbfsskZ6F
	8wf7UtDWe/ZLd6/q+kw78oATXp1GyMkR0zBxMfZ1JmeiJtNburUkJS4gve6USWAJEye7daXxSC9
	Dqjac6/1RLOlM+Iio0aujyxJeltPQRQ13kE+3tKaT01X/pLAKFt3MHqN2NFTzhIpDiatuqjKZPL
	CqRw7oROjpNB9SP3anA/EPMXVFgrsQZGMZb8ImRjzcpGyey46rnlC3GM5/kIhCDlvwHy+8+8NEl
	9T9clrqAdFp663L/PoFPdRHIqrDCq+Pxwqg==
X-Google-Smtp-Source: AGHT+IEFHbZ5UPgy2JrG7ZCzf5pYTeuDIPrARhmge/TFnSlGXeNmoQPxzycBSUsio4BZKuNp1s4xvg==
X-Received: by 2002:a05:600c:1d1a:b0:43b:c825:6cde with SMTP id 5b1f17b1804b1-43ce6eb6c80mr13718575e9.3.1741532091736;
        Sun, 09 Mar 2025 07:54:51 -0700 (PDT)
Received: from pop-os.localdomain (16.146.78.188.dynamic.jazztel.es. [188.78.146.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceb78e18dsm47728435e9.34.2025.03.09.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:54:50 -0700 (PDT)
Date: Sun, 9 Mar 2025 15:54:48 +0100
From: Miguel =?iso-8859-1?Q?Garc=EDa?= <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: skhan@linuxfoundation.org
Subject: [PATCH 5.15.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Message-ID: <Z82ruLLR+Z2ge3Vk@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KiOaL0ucxpoQ7HhZ"
Content-Disposition: inline


--KiOaL0ucxpoQ7HhZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


--KiOaL0ucxpoQ7HhZ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fs-ntfs3-Fix-shift-out-of-bounds-in-ntfs_fill_super.patch"

From 2a433fb910874180a57199f31cf01f65e27dcb00 Mon Sep 17 00:00:00 2001
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date: Fri, 30 Jun 2023 16:25:25 +0400
Subject: [PATCH 5.15.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super

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


--KiOaL0ucxpoQ7HhZ--

