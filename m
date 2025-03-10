Return-Path: <stable+bounces-121669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEDEA58E8C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 09:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591383A76D0
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E36170826;
	Mon, 10 Mar 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3DfgT4i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93942222A3
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596513; cv=none; b=nbBuAIlUTsqMUh1TynP7SQ8ip5yDpnx355bVwijWjhqoBmkv5QRTxQh9Nhv33RagdLMIYHI6plm2GhayUBHywino1puHxcvQ0xdUXvNDoMBOQy1ocr1ikEf/HUGcc1+xv8Q7kYz9dIF8R/0nm0wVmWDJEfFs8C65uZOx76ojBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596513; c=relaxed/simple;
	bh=cCo5GRrgRBMWwiGjYkN8E488Hw5rcObRX2vjhuxycNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPPUYaqysY63hTd3SGNDCgOBTXW8fztOgnXdyMF1BeQKnQQAaOA6zBN2Tw3GGJBuRCU27sjWYPbDiwXNjdxXWLBcgU/PMwf+JjjbE7Jdz/z3BLxUNG/TeSKaCyF9evaChhIWOmfvfhxlKo7zBGURiNgM4AFrAi1ZB5xyXQWx+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3DfgT4i; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bc21f831bso3615305e9.1
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741596510; x=1742201310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1OhIG0q+JmHT5j5bF2p3hmaVM/89R4M9gBOHu0bp3k=;
        b=V3DfgT4i1N1AhWwTsDBVmL0j2i3exiIwW44CLTIWvY8gRFXUBpv7MNVzRsoAk7ZTV3
         HJ0A7Rc5wPyyUNnonS8S6O0XG1WNOcG2Tyeyv0mGBRX5lKy877q3fKMdhtb133tgZKmd
         /uP5gydqFnexwZ8uWxzktD+7xGTt13+Oqr64uuOVK3//OLt6HJsTNI0p0w0jOrDnmQ9n
         XcsZVs/4UdpvDS4QaxiTyjvcBXeSE1ous3Z/QT6EWxKjTe1+UxQFjqqzygRtkCDYb/p1
         +tNrRbLikY4eWJQpLd39kpnUFv/f1S7LxPv2pgmrI4luQz62wFH+t+QsritVqfFATMWb
         k8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596510; x=1742201310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1OhIG0q+JmHT5j5bF2p3hmaVM/89R4M9gBOHu0bp3k=;
        b=iw5HGIfXSl3pGf77qccGZwCdsQCDWV9JdoU6BZYGSOB7dAeYP4eVdw00zju6V3sLdU
         krIKxvKyXrwPgzACeVMTpWslC0Qi+P3R1MXrguwiRCidZx/Sp4jd8kiO9WQpNB2CSea9
         LO527hGOb8hg7J1Giy6oT03xYzU7o2Jo5r+S5um9daGM4rhP1O5/A1Q8ExoZpoLBTrYb
         KbFErGnCAGTMw/zy1vuooCTXMNOKvVN3tO3x5Whja4FQu6qQi2lJ/EtaQv8N6hgqsF0o
         RDTB8qxsORhh2fUVWzMqxupm+Gckdl+5OhSh5jjzTXJzlslGe/+PGEUXByn5BBpFEjBc
         nuEQ==
X-Gm-Message-State: AOJu0YwftsgtfGxA9nuQEs1OsXsNq3zbHFLRcclEBJ4BdGst+nhwvwP6
	I7K/VAtso/LIiXUMGAKNANP1B2N7ph+PrqfCc/+18riZsTS/z3A0ZXBENpdaW8Q=
X-Gm-Gg: ASbGnctMsqpdPdtypFtvN49xrd4pohsTIReOEaMm7zzJs+HYWbVIBCohBX6zto324IP
	qPlbPVZAw/k+tVGCo9+JJ1IJGFb9willQRI9cNbWryfqPk8ZRI+BF8v/WTTnMEE7NjlhlfcsKqH
	0RSEuCsvYkLfiu2lrI1gDC75Y8fMcUzX5fvfT+ddBszmXzEI16fP9HvdjoXkQ4KdWQ1Uf/pviKS
	ZKgu0qu/LZB7T5rpJavyPI6kYVSOLxbfsZC+Av6SiaVegMs/uxvSYYCHYBl6Kpcz1Po7Jk5XcoN
	XFrtCyjWXTzSwZXohrNJiwkGH9TcLsWTt/aPdpzLEDFQ+oApQSWO6PWwmTWS3Q7eQ3peD0YAOQ/
	60mRuyZLpQ05eO0sGSGZjle4=
X-Google-Smtp-Source: AGHT+IFZhHX2j+8cqKjHW/rMiaBFqzMB7pm8qUl8jgi07Bwqs46LoOqBP+RAlE/MSsjSy3B4PNOjiQ==
X-Received: by 2002:a05:600c:1c1f:b0:439:a30f:2e49 with SMTP id 5b1f17b1804b1-43ce6d46431mr17513195e9.5.1741596509181;
        Mon, 10 Mar 2025 01:48:29 -0700 (PDT)
Received: from pop-os.localdomain (16.146.78.188.dynamic.jazztel.es. [188.78.146.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103aa5sm14364801f8f.94.2025.03.10.01.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:48:28 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+010986becd65dbf9464b@syzkaller.appspotmail.com,
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
Subject: [PATCH 5.15.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date: Mon, 10 Mar 2025 09:48:21 +0100
Message-Id: <20250310084820.20680-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309200218-b44aeb59f6c61146@stable.kernel.org>
References: <20250309200218-b44aeb59f6c61146@stable.kernel.org>
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


