Return-Path: <stable+bounces-204139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC93CE83C2
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 22:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FE30300FF93
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D71A76BB;
	Mon, 29 Dec 2025 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDDY5vLC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7463A1E63
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 21:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045111; cv=none; b=iNIo165Tot95LbmOCMuc1HYRrYtR8Mv0V/rOMhYL0d+k08RAvSml69G5dW5+Yrj31Ag4/97NPI/6xjzvCPEN2f7oQfF4z0z0aAfl+O7/PDX9eHqy65oN9jLi3lfXZnM6N5+R143A0zeCxG1sEKWEv7Yt0+vOvE9/xgVaej7Cth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045111; c=relaxed/simple;
	bh=Qs0YcM4GnLPcwBWYtBv4hZZlKTGO0Bpy1RMTEUDPL1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CACm81IljbgCnTquabGM2cZZxqlzhaphLOTKlM4zw8mf1BIMQWpi9gnD5kMcfxWOUOuC/tmicpvx+r+/Pk8WgVS+ugmFNWjbQ0xc4SnDWHPrqbsgpfvBwiINdulOk3IZwL1/j8glY31XQquXkJ4ylprHwqmK9h2nCNiUMeYtD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDDY5vLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C25C4CEF7;
	Mon, 29 Dec 2025 21:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767045111;
	bh=Qs0YcM4GnLPcwBWYtBv4hZZlKTGO0Bpy1RMTEUDPL1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDDY5vLCsT3bdFU4fnWI1AuzhqA5GtUPsDFRo0QdsuZVD/Ad7eDmNGWXtY6OUpxzt
	 +ikR4EQvA+2Dw7PYNBk6CZkw8nynECw7J2icaszk3MOmw66hVGxJS2msZRHkBoeNp/
	 4x2Xfe8H3TMvHEr96/qUpIqcbjKsQC/MGv51ygecZhj7o2g5Z38XEkkk/tsapc+sUO
	 MfTlY3hobw0jSJAI6RYD+ke1C+KQmvsdMbf6ZevmWCq0zE/Arnm4NiEJkOQEcI0xxs
	 9xkKUdepxO0zTDvTr9VvO8E6DtupYbswEh31665pVk1CLNX95oivSXIkaXQqhaC6Gx
	 7TjB0una+jnmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] btrfs: don't rewrite ret from inode_permission
Date: Mon, 29 Dec 2025 16:51:49 -0500
Message-ID: <20251229215149.1729676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122955-fever-mustiness-049e@gregkh>
References: <2025122955-fever-mustiness-049e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 0185c2292c600993199bc6b1f342ad47a9e8c678 ]

In our user safe ino resolve ioctl we'll just turn any ret into -EACCES
from inode_permission().  This is redundant, and could potentially be
wrong if we had an ENOMEM in the security layer or some such other
error, so simply return the actual return value.

Note: The patch was taken from v5 of fscrypt patchset
(https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/)
which was handled over time by various people: Omar Sandoval, Sweet Tea
Dorminy, Josef Bacik.

Fixes: 23d0b79dfaed ("btrfs: Add unprivileged version of ino_lookup ioctl")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add note ]
Signed-off-by: David Sterba <dsterba@suse.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ae6806bc3929..71e6715efa14 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2006,10 +2006,8 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			ret = inode_permission(idmap, temp_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
-			if (ret) {
-				ret = -EACCES;
+			if (ret)
 				goto out_put;
-			}
 
 			if (key.offset == upper_limit.objectid)
 				break;
-- 
2.51.0


