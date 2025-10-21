Return-Path: <stable+bounces-188394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57771BF7F6B
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B341119C58C3
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1734D4EE;
	Tue, 21 Oct 2025 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvH6nGVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF442050
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068949; cv=none; b=bRB8wG4JSRtjYW1YRDY4ly6f3Z7tzdILJj2LePsugEyLgckBGgqxFSBaBWB0USeW7e05vZv0sxnneDgJeV74GWCu3qK3CheGrvaq3ncznLv387G5sgCewzNB8X9FMaLBv/KIYtpZxrrGmZgsJYdJat97meeDzN8OXq/Ts3Fd1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068949; c=relaxed/simple;
	bh=YRgEhblzvv4iFIGgxpTtD/JnkzzYY5Sh6wTu7hqcRDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+WQqdONj/np2+iAJLQCMRFxM4aupN8TOzYyPn/ct+IS6Exrn7zFTkklXrtxSfYM03vJsKh0z8M5sPSApVFezZxmykoIxUc0Qad5pa7I3gFZ5sRrumm0gJp3rAdzkhgTiPDdzTpygKbTYYIYfnCcSfUTN3ZSVb30PYSx44zF0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvH6nGVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BA1C4CEF1;
	Tue, 21 Oct 2025 17:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068949;
	bh=YRgEhblzvv4iFIGgxpTtD/JnkzzYY5Sh6wTu7hqcRDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvH6nGVbj406CgGu8GISWOWLJcNMSmRnepI9eZiPZHSZbfCh4kL49mCTC3XaZObUm
	 X7WJRFDnAJbWXeMl4J6VgOZQmnhGtcUZJo4nw3JjfVodzOV3up53oRAvZil3uWOvXT
	 0/veaJ0/cQV4iNjXM2VGa0Am6GzWZTdAm0HgliLSLf/Ocf2B3CHKJiQ7L9Jmi9/Rt8
	 KhwNuunk5/6RbLrpuA2PPUUtoz0Y65W8Rh1csthRDKUWJwm1ppyJbWcehXU84AEFJV
	 4r1LjaTCEZ/UNPD4/u8IxVOFzUw+I00efT1/Z/kxguiOsTsOEV8ZTEZnSER9R3wuwx
	 K+I1dDLB1rY5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
Date: Tue, 21 Oct 2025 13:49:05 -0400
Message-ID: <20251021174905.2459401-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101635-twitch-preoccupy-ad1d@gregkh>
References: <2025101635-twitch-preoccupy-ad1d@gregkh>
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
index ff681888a123f..0c7aedcb39ea4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3882,18 +3882,16 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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


