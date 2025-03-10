Return-Path: <stable+bounces-122000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8AA59D6A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE5D16F4F5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780DD230BC3;
	Mon, 10 Mar 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpKUiurG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1A22154C
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627243; cv=none; b=OYRYwmYSllvqJkcn/DPk1IBEAKm/KLcCEt6LfQngt48Cdmv89dyNtQWSFNtW08177thm1RmD4BGYNHky5SOX+ujevDwo4aqfPL3Dolo0kueebIs6eyZFKoXNk4r+yzodNf0827N8xP4j3VjOWqEazQCOIPbuC3u8xmmVUtijtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627243; c=relaxed/simple;
	bh=f2RxDpsg2EwgBYKPMJmE3vtzJAfWBHx3E9n16QjPJIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cx5Inekx7vHQaqSXntYz2iEUaj2n6X36r31sQNn2s3fKbiS04rtsrcr4ySSc4jaV6WDjadB/iCrMQ6R/qi7f5JjJ98j0M90KRDFnY1mRKUhlIABuJqPxEoJOHMifhPGNu1Xz8G5aZ7p7oyfA+TWTVfxQDJwvoLuunxAhy/Vlr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpKUiurG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43935d1321aso4763815e9.1
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741627239; x=1742232039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlJJ7yCPg8bYNEDO1eGNr/D0ZjvxNVaE50wRxqgEJTs=;
        b=fpKUiurGv5nHsUH1/N0DuxXzEliZLfs3RdqQSNIC+8OaB+PTW683uCmid6dqNVdZIo
         4lNKacy4cC4Hwt4qtuLJnkfmLctNQ20U9+Ef1FTBwAbuFNSajl5uxvESeTLi9Yh3Eb17
         2XytWBpbVCqsNPsQ+mhjw2CO+nSKkIyrUw7dWVLkyWrQWTeUVNnz5UwnernynL+stLGc
         2W/JxbxI/APkd5X98U9B+RS9inMD3Mhu9WrOO4BWSllPNFGQn7LReh9xeDgzV3o5L80k
         Ki/WaXPaPtF4sK7Wwd+Cc2IEq4xaotm6rfUK//TmCn2PcHueP2pwENFhzcjwbI3OHacO
         lTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741627239; x=1742232039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlJJ7yCPg8bYNEDO1eGNr/D0ZjvxNVaE50wRxqgEJTs=;
        b=GlNESyVGPW6+qtBp3A2XXTG78Ka0452tC/aQFnFkbpFYr7IYYGE/pLQRA5zYHaCRpQ
         iSRvDD374BOpSTD6hPcM+cklcVrHT56VPVvEVH2WtR+a/nmCRcsIMsb1bh3kiSREJC/s
         M7UbpBYcYe3yzeN31hGFIDUwEQDxr/rXCWrGBgTiF1r67QCsNt6xZOVEnb8DiD5vdhlq
         1K4NRESLInEBDy753LGoDBEhWg20q5lIYRHltT2svHurXK4yPquqG+VEHc/Azw9z9wHD
         hTif8T/2IWVpeq02LNhjCz+bNedkCpXdcQ5fPggMgMM56KlzYQHpp+WySpkPKRf9GROG
         9LCA==
X-Gm-Message-State: AOJu0YwVKMIcf/5wvIlpCtXIm2XgWFVpRSDup3DSeqNDxgJEGmp1wWKV
	QSoVvv8fNrCWWGiHoAyxMOkXihHUEcOs3pd63P0qCvtgjQuAaZw+UFL0zkIVgXM=
X-Gm-Gg: ASbGncsln7hFBjbBJkzJ6VyepFf71sV4yLpjHiIQ8UH1XGDhjiNdMvcL6rs8gNPEVyI
	TK8/kY3UHJaF1KWcS/d1ORviWzbB68gp8M7LeIv1pAZfacrmqzX0SObnw/6M/iMgNUcs5Qez69M
	Ifgjp6Rbuas0ZjNrT/LuB3BlIoX07Dl5875Ow8ChEwRfa8Gz6/5NoXZIW/8P/UG7sNXyLRM96mH
	dzePgWgtO/aVdE4B/ftLiVm3keX1Cz495lv6dSk1GNf35zNemyur346ic3fVZ/BHDYND96FtuAd
	97vi8WtrGYp87k1331xZPQxGLbIM4Jj5o1r3RKttTaY4R1YtokFfodActxi6zTSSQGhXxnDIrZr
	OyJv0BF9WuAHzhH6PnFvOKfDJlw2LPxn+Aw==
X-Google-Smtp-Source: AGHT+IEkVcIetOiJNQBUQ6P/z9IE+4ZROTIYNJClBeUtm1cD0CegYAwq4y65js2xCN78vTW5CzWyRg==
X-Received: by 2002:a5d:648a:0:b0:391:c42:dae with SMTP id ffacd0b85a97d-39263edca4emr205944f8f.4.1741627239060;
        Mon, 10 Mar 2025 10:20:39 -0700 (PDT)
Received: from pop-os.localdomain (16.146.78.188.dynamic.jazztel.es. [188.78.146.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f44sm15378135f8f.76.2025.03.10.10.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:20:38 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+010986becd65dbf9464b@syzkaller.appspotmail.com,
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
Subject: [PATCH 6.1.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date: Mon, 10 Mar 2025 18:19:31 +0100
Message-Id: <20250310171930.446781-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025031032-bamboo-unsent-00fa@gregkh>
References: <2025031032-bamboo-unsent-00fa@gregkh>
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


