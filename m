Return-Path: <stable+bounces-190623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A1CC109C3
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C472563F57
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9F532ABF6;
	Mon, 27 Oct 2025 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZT8HNgm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD0F329C6A;
	Mon, 27 Oct 2025 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591769; cv=none; b=CRnFqPVq6WbTL0RfwCCRHsYi9uVIi/1w6jDnau9xeD0lk034cx5VP07GpzCSIjuI7teqg+6cPN2TT7xxh7tKlxlXX7nZrZZg+yBpsQSH/rTMXWvB1zf74wcFSnRkOnABHh8wXNuiJMJc7a/MophooFJcW7roQEOIzDVjuk2vbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591769; c=relaxed/simple;
	bh=E1O2ojcwXxLD4mF9HPgn071Z8rHs2K5e6xPalyU+hBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB41eOgGgNX13hA0Go0Yg3tuRa4M76YO8G8MUV0PXhvSCsLRgMDbR/kQ0QFcq3r7Gqm0cW0f4BAdKLJGriUyn5GUH0F3a3mtIJ8+OzWppKykVhfkdEVrElYQNC8eeb0ys9c7174RfnZBApuCrEIDw487DN9oibtyZrZo0C3JXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZT8HNgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D35C4CEF1;
	Mon, 27 Oct 2025 19:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761591769;
	bh=E1O2ojcwXxLD4mF9HPgn071Z8rHs2K5e6xPalyU+hBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZT8HNgmKSyLG+RogcyPWy18muUj1/ZiwKS+IR9fAs7PiCL0b4YLM/s193NitbdW2
	 HUtSCd3cadJtAKxl36jRLQiB5LUiLZQX/GqKrut3QFFe8SO4AfnVNWDnRYh6bMuh9q
	 SJPx0iHBZNYVbDbjGSb268YbQXVyNpQm1SN1kWSo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 323/332] ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
Date: Mon, 27 Oct 2025 19:36:16 +0100
Message-ID: <20251027183533.400735831@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
References: <20251027183524.611456697@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4282,18 +4282,16 @@ static int ext4_fill_super(struct super_
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



