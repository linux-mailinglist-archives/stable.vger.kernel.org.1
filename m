Return-Path: <stable+bounces-93785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40059D0EF1
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 11:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D773B2D5C1
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8861990B7;
	Mon, 18 Nov 2024 10:21:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021B198E6D
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925262; cv=none; b=CML67kcGl8RkXIkunpYvUSGm2Nes/9ytaQo4jbEVuoemDzGhPfze7CG6Z1HUZctJap1WJ4YC67YHRysoAy76yiB5C2+cDikpcl+E0iS0ZJfcFxpoSfwtkMybuvajhGp2IXtA45tMD1rTvksh9kCg0MkwVqbqqzEN1faSAnY1lQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925262; c=relaxed/simple;
	bh=VCkHQ6f3mAlnMdGatpZKxHHJ1BEwhcceEaOXrVaUX3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXLz4aUaTVr2hRuWfdeD7bhhFtT6t02ROfzqoJCcgHi7Fl5+w8lcQSPCdGNRaMmC8BUVg8fnkf4b5+oEVlCC78dY5ZNUhkBHsY1lHKA2jVUnDAQ/Q/OQ3VfuGNo3jWR36/uUqL5zPq2Xqn+QE7RuBfyL3TGvoFD7YzSnqrfJVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id C2D9923392;
	Mon, 18 Nov 2024 13:20:58 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	gerben@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH 3/3] ext4: fix error message when rejecting the default hash
Date: Mon, 18 Nov 2024 13:20:50 +0300
Message-Id: <20241118102050.16077-4-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20241118102050.16077-1-kovalev@altlinux.org>
References: <20241118102050.16077-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@suse.de>

[ Upstream commit a2187431c395cdfbf144e3536f25468c64fc7cfa ]

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
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/super.c | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 72abb8d6caf75..d5706aedf4fef 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2449,6 +2449,7 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 #define DX_HASH_HALF_MD4_UNSIGNED	4
 #define DX_HASH_TEA_UNSIGNED		5
 #define DX_HASH_SIPHASH			6
+#define DX_HASH_LAST 			DX_HASH_SIPHASH
 
 static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
 			      const void *address, unsigned int length)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 68070b1859803..3e4b9bf101454 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3559,14 +3559,6 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
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
 
@@ -5050,16 +5042,27 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
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
@@ -5077,6 +5080,7 @@ static void ext4_hash_info_init(struct super_block *sb)
 #endif
 		}
 	}
+	return 0;
 }
 
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
@@ -5234,7 +5238,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
 
-	ext4_hash_info_init(sb);
+	err = ext4_hash_info_init(sb);
+	if (err)
+		goto failed_mount;
 
 	if (ext4_handle_clustersize(sb))
 		goto failed_mount;
-- 
2.33.8


