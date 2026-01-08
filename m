Return-Path: <stable+bounces-206366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 894B3D0446C
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 565253161534
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CFD26C39E;
	Thu,  8 Jan 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E2Datbxt"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5F25F797
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884691; cv=none; b=NtRP2qWzIbEa5/CtRJB4ZKYCWJ42Ff0xjtbJCJUu2u2xsxczqqG8b0kKRg84k2jdkCL0zd1ExuAkJ16PaBL57DKPiJxzHNJ2rbDnzd3TW9CjsRJC0h6+kxUkmvzdRm71jMCmrcKGggTgk8yIQr2YFDol96jTVKvdmsNFFh0R/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884691; c=relaxed/simple;
	bh=ha2WHF2me3nLjx8cwM5IvyvQ8GAe6zvqFyC/oy66LYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVqbFM9xwHAFCjCmjzewDwqvUnE5sckvLiBElHFzmKzUesg/bPO2DJbQjAlBLae6d7JRYrTjOFWeZauEKWf64Ug35aWv+JnRv2wtCU7MNceaGzmK1MQXrGKOVb+ztYgrVjzRWcORLpbLg7IZFV+57OAoW94pCIr/F06S6DDQjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=E2Datbxt; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uDH+mDOr4jHJV9y+UV640s64aIjynGwPWTvUylmGtOU=; b=E2Datbxtf3oGSHhmfgkXqi7mYS
	rUeAroMZe3rVtZ70UAMcpD2C1EDC+Y8SgjUlV9UgrlZAJoXw4yYCB9KA/7XcBW+ZQXK/myPyhSAjS
	mmLRbeV8w7rGG3I0edsk4nN31uisDHxn0Fm+DqhOIAZ25sOn41tyBO5GNQ5Xb68WHOD97YlOLtRgL
	ypxXq/P+v5luzyUpqbPRlk6dIFXbfVE9yFpKs8LkZGOxl0a8C4bctdhgIrgtW/gZUNVAQgDKjk5sL
	nUfl4re2m5ZMOqWFFtp5ZtSQ9FmEAGgqX2VjBv6nW4YE/Q5fxCRxN3VyHk/WY4dnBV+4O2dlRiN4v
	kwr39yVw==;
Received: from 179-125-75-246-dinamico.pombonet.net.br ([179.125.75.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdrZ9-00339z-2u; Thu, 08 Jan 2026 16:04:47 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Jason Yan <yanaijie@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 2/3] ext4: factor out ext4_hash_info_init()
Date: Thu,  8 Jan 2026 12:04:28 -0300
Message-ID: <20260108150429.3354837-2-cascardo@igalia.com>
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

From: Jason Yan <yanaijie@huawei.com>

commit db9345d9e6f075e1ec26afadf744078ead935fec upstream.

Factor out ext4_hash_info_init() to simplify __ext4_fill_super(). No
functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Link: https://lore.kernel.org/r/20230323140517.1070239-2-yanaijie@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: a2187431c395 ("ext4: fix error message when rejecting the default hash")
[cascardo: conflicts due to other parts of ext4_fill_super having been factored out]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/super.c | 50 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 58456b1a5349..2136794b46d7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3896,6 +3896,35 @@ static void ext4_setup_csum_trigger(struct super_block *sb,
 	sbi->s_journal_triggers[type].tr_triggers.t_frozen = trigger;
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
 static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
@@ -4414,26 +4443,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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
 
 	/* Handle clustersize */
 	clustersize = BLOCK_SIZE << le32_to_cpu(es->s_log_cluster_size);
-- 
2.47.3


