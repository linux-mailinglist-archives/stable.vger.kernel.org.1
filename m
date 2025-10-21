Return-Path: <stable+bounces-188392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B44FBF7EF9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A34E9252
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467AC1E8826;
	Tue, 21 Oct 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtVWNae/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027932FD685
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068521; cv=none; b=hH4sDMGk79hFoMiTbK/WWa+8tSEdO8JqkVhi7L1iReUfxVmL8QRW8u4HljlTDyw5EQuZDe6S/1c3vIWEaAutgQTtsS8Yna5W24ax97h8RSsyVoMIPnveXVSWrBNAVJsm1hFapZdLq77XnNSD8EzPl982VFjQi6UgRPlcMUyarpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068521; c=relaxed/simple;
	bh=eSMIT92Z/0xLDCTPsBWAbFz8HK8n6dBQZmeus74uqSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4FeNsDwKwVM+Vqm0eCpJ7Z/vNdgFjJZJ4E3gqVn9rl9BajGS1YK9emXYug7rKblkuv+C3WtTXrmJnRmt/3MIl+DPydCRU/CvDpFQtkMpi+e6RYY/fMhJEb72nELL5FaL+vvvGTcrSjk5JVpZmlZ+BqPk7w0kyu5MF12SYCOhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtVWNae/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC8EC4CEF1;
	Tue, 21 Oct 2025 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068520;
	bh=eSMIT92Z/0xLDCTPsBWAbFz8HK8n6dBQZmeus74uqSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtVWNae/uPiIs+5CQyuh+5s04QNLkP2wKyQ+xFbn4TUiwVQ6jB0tgQvl0xNd1OnLx
	 xQvYvbCJvRleqVpBxWgHGiQyBb32qgjgfwoOx9YHd/i9/TZ85AAfpnoAXri+cbA1bU
	 NuRuqq2khEz+1Ymzb56drw0oriMo+hNfO1N3iJk4J7bWp4CtrcJv9p7oDkzCxFBevN
	 MuTlsEekj8+WeuG4scdwQAV+UGbotdoMPlzJdk8RaRN1OhKyz3CdRewgniM73aOFwt
	 gxL03bhVew0qwkDq9KZ/+RmuBJ1tBWalKcpAdyWtTIkzBo59SptY9L12QYk+EPmzvc
	 BTH2inEtwrNjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
Date: Tue, 21 Oct 2025 13:41:57 -0400
Message-ID: <20251021174157.2449192-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101635-unbuckled-masses-9441@gregkh>
References: <2025101635-unbuckled-masses-9441@gregkh>
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
[ applied to ext4_fill_super() instead of parse_apply_sb_mount_options() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3957ff246bff2..453e746ba361a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4282,18 +4282,16 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	if (sbi->s_es->s_mount_opts[0]) {
-		char *s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
-					      sizeof(sbi->s_es->s_mount_opts),
-					      GFP_KERNEL);
-		if (!s_mount_opts)
-			goto failed_mount;
+		char s_mount_opts[65];
+
+		strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts,
+			    sizeof(s_mount_opts));
 		if (!parse_options(s_mount_opts, sb, &journal_devnum,
 				   &journal_ioprio, 0)) {
 			ext4_msg(sb, KERN_WARNING,
 				 "failed to parse options in superblock: %s",
 				 s_mount_opts);
 		}
-		kfree(s_mount_opts);
 	}
 	sbi->s_def_mount_opt = sbi->s_mount_opt;
 	if (!parse_options((char *) data, sb, &journal_devnum,
-- 
2.51.0


