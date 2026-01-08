Return-Path: <stable+bounces-206363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E20D04469
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415893147999
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4E6246766;
	Thu,  8 Jan 2026 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U5P3chs9"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C76550096B
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884667; cv=none; b=J1P9Jve4ZukV2KCzE1PdG/cCdKASpZ9XBwWE5yhBcPG5xPLfc4DhVWxGbQ25T1qOW7NmV1BBJwIS5EF7SrdBRPDl3XOhS1C6QwUCbicfKdXXqPmSOl7LJ8fF3LZ4+WtsnuWz75hAHeEt3l9SaIdBsfnsGyJ4L1B7JCXJXUNveiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884667; c=relaxed/simple;
	bh=vdOy+NxV8atoHatsuLzJBWEJZnAvsTDhHwMAlTHfuao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYSqtqVc7q83j2qfA1pZrh6nhnnXj+6Q1W9FMSlztAmXgqG6Qn7grIxd/fUt6cLqHW7Pw4dtKjZ1Erxr4+BuwJomy6zG26yesju+SSBC0js3gADzOXHpyd0DlkFEczwWKiCGEjtvgYmZ08fy86ASGrhgxFraH1HZSrMnuZzwqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U5P3chs9; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WUE4aUE6CwRc3QPhwO/0Yeo0gw69ya+gW344i5JDgOw=; b=U5P3chs9ovzBLW1DVWK6CiHi+J
	NcnadlzQQJyS0t7Wby2tE1K8vkjTz0HAww7cYBowmJXoD7iZ7iFjmakSn/b+zUJBlwZ2mua/YoCj+
	UbrQwm10Rn5c2GlFCm5TklwyqIbWfn5iJosNjIDb9XyL9V7XwOAHvN3oRDVo/q9GvW8v/qxDuC+Sp
	B4e5BKqITbnDtJm7KS26065/rFNtKQ5gBmkubQIQgLohEg47umpu3ZUUpS/sfkH+kMqenUccKxjeH
	teTYIBVthWguMHp1/isB3G91wUrWIW048xMzmyJWxMWe4iyZD9GQGq//8jgUjH/YZFf555Dd2HcAd
	0rsRA28w==;
Received: from 179-125-75-246-dinamico.pombonet.net.br ([179.125.75.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdrYj-00339G-MW; Thu, 08 Jan 2026 16:04:22 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Jason Yan <yanaijie@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 2/3] ext4: factor out ext4_hash_info_init()
Date: Thu,  8 Jan 2026 12:04:08 -0300
Message-ID: <20260108150409.3354721-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108150409.3354721-1-cascardo@igalia.com>
References: <20260108150409.3354721-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Yan <yanaijie@huawei.com>

commit db9345d9e6f075e1ec26afadf744078ead935fec upstream.

Factor out ext4_hash_info_init() to simplify __ext4_fill_super(). No
functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Link: https://lore.kernel.org/r/20230323140517.1070239-2-yanaijie@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: a2187431c395 ("ext4: fix error message when rejecting the default hash")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/super.c | 50 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 106fa338840d..05665f4a898c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5041,6 +5041,35 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 	return ret;
 }
 
+static void ext4_hash_info_init(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+	unsigned int i;
+
+	for (i = 0; i < 4; i++)
+		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
+
+	sbi->s_def_hash_version = es->s_def_hash_version;
+	if (ext4_has_feature_dir_index(sb)) {
+		i = le32_to_cpu(es->s_flags);
+		if (i & EXT2_FLAGS_UNSIGNED_HASH)
+			sbi->s_hash_unsigned = 3;
+		else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
+#ifdef __CHAR_UNSIGNED__
+			if (!sb_rdonly(sb))
+				es->s_flags |=
+					cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
+			sbi->s_hash_unsigned = 3;
+#else
+			if (!sb_rdonly(sb))
+				es->s_flags |=
+					cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
+#endif
+		}
+	}
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct ext4_super_block *es = NULL;
@@ -5193,26 +5222,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
 
-	for (i = 0; i < 4; i++)
-		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
-	sbi->s_def_hash_version = es->s_def_hash_version;
-	if (ext4_has_feature_dir_index(sb)) {
-		i = le32_to_cpu(es->s_flags);
-		if (i & EXT2_FLAGS_UNSIGNED_HASH)
-			sbi->s_hash_unsigned = 3;
-		else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
-#ifdef __CHAR_UNSIGNED__
-			if (!sb_rdonly(sb))
-				es->s_flags |=
-					cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH);
-			sbi->s_hash_unsigned = 3;
-#else
-			if (!sb_rdonly(sb))
-				es->s_flags |=
-					cpu_to_le32(EXT2_FLAGS_SIGNED_HASH);
-#endif
-		}
-	}
+	ext4_hash_info_init(sb);
 
 	if (ext4_handle_clustersize(sb))
 		goto failed_mount;
-- 
2.47.3


