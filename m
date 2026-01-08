Return-Path: <stable+bounces-206367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1B6D03A93
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80197300FBFE
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00AB263C9F;
	Thu,  8 Jan 2026 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CDbKtqAL"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3B50096B
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884694; cv=none; b=WX7eIL3HPzQB0XYGMpq1739R/ym1swCpXjw5/61XQjNuD1B0L9ELbRZp34fbnBRvLw48lu/gCTLzocyUC5vpyptzF5n0YnmRAbGwFJVogVz6DhZw5bgBSuHTv6TzCzWG4/5EuiKoxSJAAsTlMtdz0rHzRWpnNT2FHU5HK+swbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884694; c=relaxed/simple;
	bh=t+rydfhKQnhO3oqIK2fa2P0oPOjasX/qtH/Rs7DzXCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3uGzddEVh9aHfGX4SOx1ZC3ORqrF5J0cs3L72ObxbVvukFvpTA1wfvqlXjEVymlCu2E9UZj3yzsiUKFR5pg6k2467quA7YvPZYYCk3zpKiNh/5GQ+BQ0s4Hf9cBzPjiRkssQgkbGFX/BNpX2hEZjliMz1NLNvKViLeoeScaFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CDbKtqAL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YpmU1kKOp2xNNBTnf7ZtFAoPr6N+dq1qGZFV8f+AQHw=; b=CDbKtqALB07g9fDxP+nEwoCpJv
	Z6Ycl5KiqKDgKMeYyGR3hyu1aOKrHxbDXXbO26QItzmzM/jUpg3hLVzoMp1OqN4dL4CfdzkxU0jUB
	bDKOZ59Ii8f9nZWL5M093eI5X8TFqqws3pi0pIid1xFZahq3A52PR/FNA/sbrA+GUqcXUB1mhJUiI
	Ayv6ZZl8+qdBhrksUkmoGsem69l8sON//EAdLjg840Dtc34oeNUJ1BbKM2OqxE9tUtXX7O1mC0wzR
	i66CTtCqfWJuYfzPtvGtXKaBlKnaTYA+VjPokIu3Dg6Gvs09gsuTuPenjdipIyqrn/SKWAWLGUqxF
	ll62ZpQQ==;
Received: from 179-125-75-246-dinamico.pombonet.net.br ([179.125.75.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdrZC-00339z-5I; Thu, 08 Jan 2026 16:04:50 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 3/3] ext4: fix error message when rejecting the default hash
Date: Thu,  8 Jan 2026 12:04:29 -0300
Message-ID: <20260108150429.3354837-3-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108150429.3354837-1-cascardo@igalia.com>
References: <20260108150429.3354837-1-cascardo@igalia.com>
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
[cascardo: conflicts due to other parts of ext4_fill_super having been factored out]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/super.c | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 14dc0a3160fd..389251ee9ac9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2443,6 +2443,7 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 #define DX_HASH_HALF_MD4_UNSIGNED	4
 #define DX_HASH_TEA_UNSIGNED		5
 #define DX_HASH_SIPHASH			6
+#define DX_HASH_LAST 			DX_HASH_SIPHASH
 
 static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
 			      const void *address, unsigned int length)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2136794b46d7..8766a2b39954 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3190,14 +3190,6 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
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
 
@@ -3896,16 +3888,27 @@ static void ext4_setup_csum_trigger(struct super_block *sb,
 	sbi->s_journal_triggers[type].tr_triggers.t_frozen = trigger;
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
@@ -3923,6 +3926,7 @@ static void ext4_hash_info_init(struct super_block *sb)
 #endif
 		}
 	}
+	return 0;
 }
 
 static int ext4_fill_super(struct super_block *sb, void *data, int silent)
@@ -4443,7 +4447,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
 
-	ext4_hash_info_init(sb);
+	err = ext4_hash_info_init(sb);
+	if (err)
+		goto failed_mount;
 
 	/* Handle clustersize */
 	clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);
-- 
2.47.3


