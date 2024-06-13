Return-Path: <stable+bounces-51586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EA7907099
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B91F21022
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECEE143884;
	Thu, 13 Jun 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zr7kvWXq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9281428F0;
	Thu, 13 Jun 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281730; cv=none; b=CkifwSMEcgdcTQ9zcxGAU+bpqE45rf7YgSsP/NyU6ytf3KTIj4SksfqveJGg0ElkGYTbYufnGZWzZ73FgBNtF6Zdq3iwdgtsIqaE5hN2NVeqFcnOxR/VZJRJkcA+aAL11VnYXEIWgzjOCnivIAjoBs9SN7q11A2mt+xMGHp5lDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281730; c=relaxed/simple;
	bh=LDaJUQE/EphZHEIGqGiYJSvzOEketeFIE/J+FkXEn7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiNLKHJjQbXImSVDk/my/wiVl3QWR4U1nzQmhBD0JGK8fvD8RPhqdFxGlWJWECLzTJV5oFaGU+IR62jWh6eVYGseDQPdizdCyPyBKObJW1ty2FGyalV54VYK6gAyq324tRA6oy174xoqZitGFX4LgUzDZ0WfWBDqQQi8m5+itRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zr7kvWXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0229DC32786;
	Thu, 13 Jun 2024 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281730;
	bh=LDaJUQE/EphZHEIGqGiYJSvzOEketeFIE/J+FkXEn7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zr7kvWXqiAPYeieZEJuGGQw60SZogzEs1LLymIoqg8Lrfc5DwgZdoCKdHgK8k+krz
	 8ruOks40g+dzznX5FiAVeQr2S/ehHNvDj43088nxz7ZM1dHaR2hrqPSdnmzYUSOyZc
	 ta66EIOR0PHHn9Q3a7nENMc6wiuRjZX11yCZefoA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Sandeen <sandeen@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 036/402] openpromfs: finish conversion to the new mount API
Date: Thu, 13 Jun 2024 13:29:53 +0200
Message-ID: <20240613113303.545675918@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 8f27829974b025d4df2e78894105d75e3bf349f0 ]

The original mount API conversion inexplicably left out the change
from ->remount_fs to ->reconfigure; do that now.

Fixes: 7ab2fa7693c3 ("vfs: Convert openpromfs to use the new mount API")
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Link: https://lore.kernel.org/r/90b968aa-c979-420f-ba37-5acc3391b28f@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/openpromfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index f825176ff4ed7..07a312bf9be71 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -355,10 +355,10 @@ static struct inode *openprom_iget(struct super_block *sb, ino_t ino)
 	return inode;
 }
 
-static int openprom_remount(struct super_block *sb, int *flags, char *data)
+static int openpromfs_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	*flags |= SB_NOATIME;
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_NOATIME;
 	return 0;
 }
 
@@ -366,7 +366,6 @@ static const struct super_operations openprom_sops = {
 	.alloc_inode	= openprom_alloc_inode,
 	.free_inode	= openprom_free_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= openprom_remount,
 };
 
 static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
@@ -416,6 +415,7 @@ static int openpromfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations openpromfs_context_ops = {
 	.get_tree	= openpromfs_get_tree,
+	.reconfigure	= openpromfs_reconfigure,
 };
 
 static int openpromfs_init_fs_context(struct fs_context *fc)
-- 
2.43.0




