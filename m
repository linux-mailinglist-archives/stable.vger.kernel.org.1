Return-Path: <stable+bounces-206361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E57B4D03A99
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA74B301519E
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC2C248F7C;
	Thu,  8 Jan 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iewv2owG"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413C22DF9E
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884652; cv=none; b=lJJ/N+Q0xFHJR02e8V4HvejGWI8YqkIqV+Vbyc5TMMwdLIOFJ4ezb7uCLaXq0fpuAm16Uq83aEuvRDlLny6fAQ5OwVqvKl9Pd2dhPXr0vomhuxuBYhWcEgE9T/TLrfK0V9u+aeV3e8lIvazPJRrLET2qcVaXN4Qv0viAd1E7bhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884652; c=relaxed/simple;
	bh=mNvOiNzn3fFcU+L3ff6jIvp67U14XjYfIChMVXUNfAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdmMBbSU6IdFmCcYzCDUsENNd/py5k6KrMemX6K0DYe+dXUMUsVh8Tv6RQKkXCHHTmqU0w89pS0uyyQ4bF3OOF/dtYma+oAT7Px83T6lvGBvaxUSzWNU+t0kdBweY19AX1OeXX/MwC6P95hBt+0bw6CMJdJXP2AIAJP98dEmpnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iewv2owG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=upuaxP+b8+5vlkdtBy85XaNbpGsYcfiHWJY/TErfyio=; b=iewv2owGe89L90KFbwfh00ejoR
	AHd9tdEl4GPGJUKi4QxoTmVqNC+lWj72gFUOc44BQp/ftl8lbObxUoU82TkuY7Q/kZoBtW/KxUEGo
	8nm7zHcC1GdOmBzlmIn/+T2RTFL6YHtTaIk8SdCyw1gunMWZlx90OIs7nY4SBHWMr6iPbD9ErNgIY
	Plo2f0b4TUxcFubByGrnpxY0G/IVgizDEWQfxwv5Aw8ijnevfXtdNIvWsAdE0B3UeosZj9Wz2Lxzd
	js2n4kahFwZ5vUYZJrZzWGdrOERwQkM1Yj5Cqyq/kSJUbBgjnePlUc2sVBuChF0QiKtzKb8Fr0gso
	1ums5fNw==;
Received: from 179-125-75-246-dinamico.pombonet.net.br ([179.125.75.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdrYU-00338f-HQ; Thu, 08 Jan 2026 16:04:07 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.6 2/2] ext4: fix error message when rejecting the default hash
Date: Thu,  8 Jan 2026 12:03:50 -0300
Message-ID: <20260108150350.3354622-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108150350.3354622-1-cascardo@igalia.com>
References: <20260108150350.3354622-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@suse.de>

commit a2187431c395cdfbf144e3536f25468c64fc7cfa upstream.

Commit 985b67cd8639 ("ext4: filesystems without casefold feature cannot
be mounted with siphash") properly rejects volumes where
s_def_hash_version is set to DX_HASH_SIPHASH, but the check and the
error message should not look into casefold setup - a filesystem should
never have DX_HASH_SIPHASH as the default hash.  Fix it and, since we
are there, move the check to ext4_hash_info_init.

Fixes:985b67cd8639 ("ext4: filesystems without casefold feature cannot
be mounted with siphash")

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://patch.msgid.link/87jzg1en6j.fsf_-_@mailhost.krisman.be
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/super.c | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7afce7b744c0..85ba12a48f26 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2459,6 +2459,7 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 #define DX_HASH_HALF_MD4_UNSIGNED	4
 #define DX_HASH_TEA_UNSIGNED		5
 #define DX_HASH_SIPHASH			6
+#define DX_HASH_LAST 			DX_HASH_SIPHASH
 
 static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
 			      const void *address, unsigned int length)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5a1e1f7e6124..613f2bac439d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3630,14 +3630,6 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 	}
 #endif
 
-	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
-	    !ext4_has_feature_casefold(sb)) {
-		ext4_msg(sb, KERN_ERR,
-			 "Filesystem without casefold feature cannot be "
-			 "mounted with siphash");
-		return 0;
-	}
-
 	if (readonly)
 		return 1;
 
@@ -5146,16 +5138,27 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 	return ret;
 }
 
-static void ext4_hash_info_init(struct super_block *sb)
+static int ext4_hash_info_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	unsigned int i;
 
+	sbi->s_def_hash_version = es->s_def_hash_version;
+
+	if (sbi->s_def_hash_version > DX_HASH_LAST) {
+		ext4_msg(sb, KERN_ERR,
+			 "Invalid default hash set in the superblock");
+		return -EINVAL;
+	} else if (sbi->s_def_hash_version == DX_HASH_SIPHASH) {
+		ext4_msg(sb, KERN_ERR,
+			 "SIPHASH is not a valid default hash value");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < 4; i++)
 		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
 
-	sbi->s_def_hash_version = es->s_def_hash_version;
 	if (ext4_has_feature_dir_index(sb)) {
 		i = le32_to_cpu(es->s_flags);
 		if (i & EXT2_FLAGS_UNSIGNED_HASH)
@@ -5173,6 +5176,7 @@ static void ext4_hash_info_init(struct super_block *sb)
 #endif
 		}
 	}
+	return 0;
 }
 
 static int ext4_block_group_meta_init(struct super_block *sb, int silent)
@@ -5317,7 +5321,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (err)
 		goto failed_mount;
 
-	ext4_hash_info_init(sb);
+	err = ext4_hash_info_init(sb);
+	if (err)
+		goto failed_mount;
 
 	err = ext4_handle_clustersize(sb);
 	if (err)
-- 
2.47.3


