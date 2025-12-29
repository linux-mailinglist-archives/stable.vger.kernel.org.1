Return-Path: <stable+bounces-204138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A68CE83B3
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 22:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1BE93012748
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 21:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745EE22689C;
	Mon, 29 Dec 2025 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGiTbHaj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3406F17A2FB
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767044348; cv=none; b=V8lDw0QKay2qjQTuGLWqYSevWjXS8duTNWFPfiMexypBUKJp+v76h76Mp7CJT1iE6olxYWQL6pwwLxmdfvspwjpjokzQCPZpaRA72s/guREdT1LIxlkEpiNcYu7A3Yhj66J0WTcOlW4mzBgFxnYDtaYokHH8MWwEtusqHmJS8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767044348; c=relaxed/simple;
	bh=vxfvRekR4t8geZ0SlsTp23hBm6aNOKuwHD6H3CH/N1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLI2rmE964FFLAqoPdl7FXaImkPQqYjYn/8l8QpZ8rIIQkba3vSUg6o4z+rfZWy5zLr7Jwfn4BcVDtf5omwOfSzAb07nMeWXiv+zVqO476zXWrY+NIF98QqgtszVa8zcV70I2wsPA2Lmgop2OeDXznIi2WufQYn/f8orgBw8OI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGiTbHaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6A3C4CEF7;
	Mon, 29 Dec 2025 21:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767044346;
	bh=vxfvRekR4t8geZ0SlsTp23hBm6aNOKuwHD6H3CH/N1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGiTbHajFf0haRCLBsQWqE1ZLWX6RvxAQLbQFUGY0WImn2eebnDEojwFjQ6iyZ4el
	 EoQFlE4JutVIVwWjc3/+9NcrvO73Odc4iph3Jdy3JK7z9okqADRIFHbfK3nLYz9Skz
	 w4QAKnuF5wAJ3HTalI2oSbM9eF7cWY3yKZuYfikd+3WkwJwwzkx5C5p9hD+qGqRC8s
	 JOfg/pAnZo03JQec5Vq1AGyldI/I93vwUkRiexvUA9eQPwraAzqBmY3YOBHKD3xznq
	 Q6f/Tj9OQXhu9U/yCaGgY2E0M842Adx1qUejWlSjpi/EG2CC8QKVvYUOv+odwEqhQG
	 WkVDJEuZbEbWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] btrfs: don't rewrite ret from inode_permission
Date: Mon, 29 Dec 2025 16:39:04 -0500
Message-ID: <20251229213904.1726555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122954-glance-used-2782@gregkh>
References: <2025122954-glance-used-2782@gregkh>
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
index 03c3b5d0abbe..f15cbbb81660 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2012,10 +2012,8 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			ret = inode_permission(idmap, temp_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
-			if (ret) {
-				ret = -EACCES;
+			if (ret)
 				goto out_put;
-			}
 
 			if (key.offset == upper_limit)
 				break;
-- 
2.51.0


