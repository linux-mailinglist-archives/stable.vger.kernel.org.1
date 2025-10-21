Return-Path: <stable+bounces-188384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7ABF7D07
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7729848886C
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF112FD665;
	Tue, 21 Oct 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHyGUUtb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2991DFD8B
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066244; cv=none; b=oqzT5aNoZDEeBttM7p9DdZN24R3VGSIMOzQeNUeM2t/wCaQgbqDshuMd+GFb22qcX0JUBPROXiBWtA+Xko19oVL3N4Wv1hHuGV8aFyWWvWIfnOEfl0UA9OzkVlMKajBMCG2RH2VOG8jbrHvv1ckgNk/dsl6MWdqB1StnUtOK4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066244; c=relaxed/simple;
	bh=sLi2CcTZEynXpbIapKMXcJsrawgpKBJdqIA/RQTudCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+WqvscFdtLve4zeZQa21n3C6ffBORQ3F1mdxu7YJ5nhNHXUBcGzBzB8gCy23KwTc/NTsf3uY+o5ZQCqq5IoMPo/owXwBE7mKBWCvteaZfBDTGFK8YzdF1DiTAgOsATDKNQWUod7c2c4ZlV/vqwZo4MEyhByEf47fn8QB76kqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHyGUUtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23089C4CEF1;
	Tue, 21 Oct 2025 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761066243;
	bh=sLi2CcTZEynXpbIapKMXcJsrawgpKBJdqIA/RQTudCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHyGUUtb/YiOIHmSCXByPCxENzHq3fSGVycHZ4z5Uvd02T0RKWOEp7Ab4nnOKEzQw
	 Lw8JTDaKR9dwTJhDqP+qOayytbcOGj2i6HEAxFPVRl84cyhoPEUdUCZg6fjgNxhWZf
	 mNUR1BzmXYd9P0pNfdS5t4aBu0dRSUf60rDXwx5UbafZVj3+nyUTHbfU5fHDKIkO9W
	 5qojReh6c9Yqbj4h8roP+k5D2JG7h3Xa3FkfVVidvB/IOazJvqmHhPycWJ7kVtOxn4
	 aLS8i8TCf0eyBiMHq9jZbv8S+V74amS96UNlBTbSwUcuOJ2MD2Rfl5vQr2prgKFvC7
	 4ahnJR23SK54g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
Date: Tue, 21 Oct 2025 13:04:01 -0400
Message-ID: <20251021170401.2401806-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101622-hungrily-marbling-e7ef@gregkh>
References: <2025101622-hungrily-marbling-e7ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 8ecb790ea8c3fc69e77bace57f14cf0d7c177bd8 ]

Unlike other strings in the ext4 superblock, we rely on tune2fs to
make sure s_mount_opts is NUL terminated.  Harden
parse_apply_sb_mount_options() by treating s_mount_opts as a potential
__nonstring.

Cc: stable@vger.kernel.org
Fixes: 8b67f04ab9de ("ext4: Add mount options in superblock")
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20250916-tune2fs-v2-1-d594dc7486f0@mit.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ added sizeof() third argument to strscpy_pad() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ab99197ee22ed..b563c2e59227f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2415,7 +2415,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *s_mount_opts = NULL;
+	char s_mount_opts[65];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2423,15 +2423,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
-				sizeof(sbi->s_es->s_mount_opts),
-				GFP_KERNEL);
-	if (!s_mount_opts)
-		return ret;
+	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts, sizeof(s_mount_opts));
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-		goto out_free;
+		return -ENOMEM;
 
 	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!s_ctx)
@@ -2463,11 +2459,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	ret = 0;
 
 out_free:
-	if (fc) {
-		ext4_fc_free(fc);
-		kfree(fc);
-	}
-	kfree(s_mount_opts);
+	ext4_fc_free(fc);
+	kfree(fc);
 	return ret;
 }
 
-- 
2.51.0


