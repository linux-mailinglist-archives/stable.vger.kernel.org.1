Return-Path: <stable+bounces-124150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB765A5DC58
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 13:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FD17A7FC8
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC359226CF8;
	Wed, 12 Mar 2025 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsyvP00r"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965CF22A1E2
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781304; cv=none; b=sc7gNMmPauVFCdYtZ0LmajjMlY+P6eVSCTgSm/Ni6QPsm9XJj3FTdsx7t2vS7BP8DjIg6sby3ciD2GJMzjrGQNGa4zhmOtAos6tePaqUmeswHh1cYx+UD1hdSBJ5wyRR2wjoYvmck3uIICiWgk9AXiKYckx0ymf/8HxdRn/Vsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781304; c=relaxed/simple;
	bh=f2RxDpsg2EwgBYKPMJmE3vtzJAfWBHx3E9n16QjPJIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ilDJL/y8p11smtGN4kp66blaI8aDVGoVetGRE+KQBFy2XhGWTdp17EhrGJrbKFPA/wZailEjMSIjC1Z2SEsp4RmgHCzTq4i3NI64J5+KEKw9xDYaYGj3600LDXIqjoxRXgET6ltNzY2A7yFdlQvpIpxcN8Vv4utiCdZEXYost4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsyvP00r; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe99f2a7so1775605e9.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781300; x=1742386100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlJJ7yCPg8bYNEDO1eGNr/D0ZjvxNVaE50wRxqgEJTs=;
        b=GsyvP00rgxnXXhRtm3zR19DoSCAzTRaKaXj50enIXYhKVSRUydB/eEh+CE85S+4lU4
         Zp24MPGUQJOe4Hy6/lmJiCnJfrm0xb3S+iysNU+2kFW2cgdA1VII8WcuOUaQ7G51DKgp
         5bgkTo4FrRMEw0A+fiXjb1Bx1bDae2X2SsvWOWgt10MBGl2p9CTy3NsY7vU/yQ14aGSj
         0yDKjJ7bHzpHwtZ7s88xGTSl6Ux9aO/oorBTqLSRFzTZKm+esY3Tfttr6vpAZWivuHGY
         WxAPUQkUbfZS3IMMhjmdKnIDj29yLzQrsgZX1xpLnncjnvP+4hIRgPEI6AakgVKl1T7m
         vmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781300; x=1742386100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlJJ7yCPg8bYNEDO1eGNr/D0ZjvxNVaE50wRxqgEJTs=;
        b=IIHkek7Ab8LeNtn7fItG6FnxF1DDQu1yLrrZ806PYp4jmMaiDEkvzByuxm/1EWZ8fl
         rXHNYYzjyRIB6Gbg8ywefc1ua8z/1RFnD8W9Pp4sbu6b9Rye9yUKrvoWpmaxFkIBGXtk
         j/HjQqqzhjMrgiO+fqVDmDnAKcD8AUzrYi8f8404Z9ve+Haz4uswkag/S4025ctiujC1
         MPY1L4LVjC+Jrs0l2qaaK5S3+HuaLVbImqfDKEWZxM/WeeVEK11chidWdX0eh2Eu46oc
         v20KZ5CZKvoSq6K+bv+miRrI9y5W6EEid1r/Jpa4qVbwMvJfYA5y8gjuZSqXDRODILMF
         1S+Q==
X-Gm-Message-State: AOJu0YyYUqfQTyQ1mPrUUrOcgZCqjgwuosOtcOJ0FgC0VeLrJfVIAdIm
	ZfKaRB+ad8qWifs5GTtkknkRtZz2DDutzu+heXa8i1EsQsSFP9zOoEkbAlVjQSI=
X-Gm-Gg: ASbGncv56Z9F7+W44EJTy/yjbDxh6D8Hcn+lbzBHz8P1HUdRr9U/ZtDS7deBoPYnUtE
	HyrKr6sUC4BhcfGWFWR4lRSoDKn/VmWvN4VMTljQi/UUcJcFK1WQZerPv685VMWXtnFo3m56iIg
	xy8WfVOcpm52Lh/3SQUpZ16RcQ3D3axsssUe8hU2ThLDXmKM1qmteemvFhxJw4L/HAv/GmXywdQ
	hHP5FsgZ/ddcTByfLJgVDMP7jhwqHnjTUpbDG2dqUnP0S/3ODd7a8l6msKpqOTzuJbSdyVdc1cf
	HukXrROdnKERVbon5EFiM7nzKQv8UGujoFo5Z0tPCacYvzprhiHHcJ7cxSegalTgRX5XICWnN6w
	wT4itZUcVPQ4rcJjbw2ICqOU=
X-Google-Smtp-Source: AGHT+IEBxq/0CI/jAcJfAkgPMbKNTPqomCVHL03lfAhBpc/uysQ+KNFIU9N9u5pk8gUZCwv5LTGs5Q==
X-Received: by 2002:a05:600c:a08b:b0:439:9fde:da76 with SMTP id 5b1f17b1804b1-43ce5e2d1dfmr52817115e9.0.1741781300037;
        Wed, 12 Mar 2025 05:08:20 -0700 (PDT)
Received: from pop-os.localdomain (16.146.78.188.dynamic.jazztel.es. [188.78.146.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a7903fbsm18914035e9.32.2025.03.12.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:08:19 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+010986becd65dbf9464b@syzkaller.appspotmail.com,
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
Subject: [PATCH 6.1.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date: Wed, 12 Mar 2025 13:08:03 +0100
Message-Id: <20250312120802.19500-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 91a4b1ee78cb100b19b70f077c247f211110348f upstream.

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
 fs/ntfs3/super.c   | 68 +++++++++++++++++++++++++++++++---------------
 2 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 26dbe1b46fdd..cbbf1ccc38e3 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -42,9 +42,11 @@ enum utf16_endian;
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
index eee54214f4a3..a9063771afcc 100644
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
 
@@ -871,13 +902,6 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	sb->s_maxbytes = 0xFFFFFFFFull << sbi->cluster_bits;
 #endif
 
-	/*
-	 * Compute the MFT zone at two steps.
-	 * It would be nice if we are able to allocate 1/8 of
-	 * total clusters for MFT but not more then 512 MB.
-	 */
-	sbi->zone_max = min_t(CLST, 0x20000000 >> sbi->cluster_bits, clusters >> 3);
-
 	err = 0;
 
 out:
-- 
2.34.1


