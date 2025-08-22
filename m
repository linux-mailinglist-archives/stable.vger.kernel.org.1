Return-Path: <stable+bounces-172426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700D0B31B64
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9362AB27B37
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA701308F01;
	Fri, 22 Aug 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXozupfl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647492FE564
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872383; cv=none; b=kRxKyfsbBYQKcAWEREVDeElVb3zmtqHJgB9CKmvnbmIkI1Amrb8nwkg75eNCtFo0/s8wzwAHeKYtTMlP1Km/KKD0kZrXIKPi3Jagu+dWnVNwkutz/xES56xrOnwvOYmRh3uvMYT2/IZ8BLKvSC8w4fV6g7qBxJvhEVUm4FXDLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872383; c=relaxed/simple;
	bh=YS6xdMqGj2uUP3Jo5pTHyS9haMd7ADhdPBWH1aFGzo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CerjnblXMS+Eb9IBeXcO+1vW1/8ivcJpeC4zNXmmuZ4t4E/jONA/TbTcmKnhe5wXjnbToQKMxwDmT73uvDQyNMcw5xEZb8PimD3824ZlD+mubFrD0/GMxpBDFjoQ1ruiHZ/EIQZqRytCAJMt2afjUpxxpahTGCvNi+e4X1bjGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXozupfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B2EC4CEED;
	Fri, 22 Aug 2025 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872382;
	bh=YS6xdMqGj2uUP3Jo5pTHyS9haMd7ADhdPBWH1aFGzo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXozupflIiYWJt0hd3Qi+A+mcBMtUzd9jwEixzcUzhdsbuINLPfYMdbqqPSWaSFii
	 UZs3D6fZSifqtrkzE3UbLLP/Pcjh6vAdebaxlU94pX3oQ1xpjkiMEA9qGVoS3s3JOc
	 Q1PBs9/oSrnFdh3FlhTOG4zQdec6/qsHu1sQNks/2DLvCvQyaCKuibkZtkzL+4ApqU
	 bKg5orKRnj5otJG1GptEsIDlRoTpnTMYjqiSyb+JhghfFw49YoC10GAJjNuuRBIFWb
	 UKmybiwQd9Yl7RnMm9IQBqJKsCwOEhrT6KgVYGifN+j4pHriJ57rxjtT4GkOz9OpTH
	 3wnmQBw+CrGYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ext4: preserve SB_I_VERSION on remount
Date: Fri, 22 Aug 2025 10:19:40 -0400
Message-ID: <20250822141940.1257026-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082138-barracuda-engorge-cf38@gregkh>
References: <2025082138-barracuda-engorge-cf38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit f2326fd14a224e4cccbab89e14c52279ff79b7ec ]

IMA testing revealed that after an ext4 remount, file accesses triggered
full measurements even without modifications, instead of skipping as
expected when i_version is unchanged.

Debugging showed `SB_I_VERSION` was cleared in reconfigure_super() during
remount due to commit 1ff20307393e ("ext4: unconditionally enable the
i_version counter") removing the fix from commit 960e0ab63b2e ("ext4: fix
i_version handling on remount").

To rectify this, `SB_I_VERSION` is always set for `fc->sb_flags` in
ext4_init_fs_context(), instead of `sb->s_flags` in __ext4_fill_super(),
ensuring it persists across all mounts.

Cc: stable@kernel.org
Fixes: 1ff20307393e ("ext4: unconditionally enable the i_version counter")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250703073903.6952-2-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d2b58f940aab..c98dd3ff059e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2028,6 +2028,9 @@ int ext4_init_fs_context(struct fs_context *fc)
 	fc->fs_private = ctx;
 	fc->ops = &ext4_context_ops;
 
+	/* i_version is always enabled now */
+	fc->sb_flags |= SB_I_VERSION;
+
 	return 0;
 }
 
@@ -5305,9 +5308,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	/* i_version is always enabled now */
-	sb->s_flags |= SB_I_VERSION;
-
 	err = ext4_check_feature_compatibility(sb, es, silent);
 	if (err)
 		goto failed_mount;
-- 
2.50.1


