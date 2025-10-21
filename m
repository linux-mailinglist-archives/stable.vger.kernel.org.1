Return-Path: <stable+bounces-188379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F0EBF7C1A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C2854474C
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D2B345CA9;
	Tue, 21 Oct 2025 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6rCyeyC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E373451A9
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065061; cv=none; b=tu0wM59/0FM9KaTySSFwFCjazN8UcA6hNrkeM9A45XNeUVG6scw+ZzZIcuXWAtZ9eds3/BoOK6M2AUpnvpDTQb7+OBgqNxj/WLQuLt6u2f4ebrFctut8EC/3sXVotdy7tQOszBxt0/pbVpbERrH3KneDcVaPFolRwGO/K7LfSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065061; c=relaxed/simple;
	bh=XQHqP4Zfb9ebEPe4v0sujzbXeYxFSnWWPd92QEqa0Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQS3Ql+5W6zFa+sH6tMeQ/xwchf+L5AJ0G+jfiPYrYPn0WHg+TH3sK2jFG4gDY+W/Rw7dXdFa4P5/7/AqHdprbidR4174qi6n+Fu2CsoMmvZcmrx/XxnIEtptWiB+Sw1MzUeFbcxcqTufdaHAmYfS04kvBu+JpzMK3QIFn8ZaUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6rCyeyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CF5C4CEF1;
	Tue, 21 Oct 2025 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761065061;
	bh=XQHqP4Zfb9ebEPe4v0sujzbXeYxFSnWWPd92QEqa0Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6rCyeyC0lQKrWxVa2ev4fMtr6dnBcdur3IILLa8cxGhFGeRFFaqcDxKK0R2vFK/4
	 jAXW8hEwF6OWSL469XB54+8ytO5vfRoU5AySDCYhoq7fd5I1GGEowW7N0gHuz4ooj3
	 M7nAgUlplr1iswfxpCuGBhFUT+95gBQ3V1yQ8Hnefndw2IMZNwNwFuLf8SuJtzWtQO
	 CbLkzUxPMh4kkvTmRyyGEZqJ+5la9C5WrYE8VGBVlE4PktK1zBtTao/VN8jMs5ySVi
	 Aed/oToK+c2AwgkkX7J8QPBb4I7DWoMFiQrGEkTm2zh0HexD3hAlyW3Nhd5K0WS5Kv
	 5MaTmD7Yt/W1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
Date: Tue, 21 Oct 2025 12:44:18 -0400
Message-ID: <20251021164418.2381659-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101623-skydiver-grading-5b2f@gregkh>
References: <2025101623-skydiver-grading-5b2f@gregkh>
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
index 527f53bfe1b1f..16a6c249580e3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2506,7 +2506,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *s_mount_opts = NULL;
+	char s_mount_opts[65];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2514,15 +2514,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
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
@@ -2554,11 +2550,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
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


