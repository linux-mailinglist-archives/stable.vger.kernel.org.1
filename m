Return-Path: <stable+bounces-204142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAECCE8473
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 23:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7EE7301F8D8
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 22:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5C630F95E;
	Mon, 29 Dec 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiBS9lbD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1030F941
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767046361; cv=none; b=CFfne2x7t/ZqyozkullH+dZN2iwTk6ZnjaekKgEpKmZdF7STeu/JwESGIIHVzUud8GYxfPVW+0XL5qosv95hDRD3OhIGo5/4eQ9NRDfClDFVr2SZ0H76tfPhow6IMzPjcSH4Xs+YL2rXc9RL1t03nQe3IQMLgFCdWTaZLNOaxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767046361; c=relaxed/simple;
	bh=xqTgw70GY2Comj1uBguVjBKD7DfrV7734K07WeFrsL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4ajJXiXgqHy0/ItXOZo3m+RgdzL7ZMlRa7iJrbyj1GDq5w/x258PCX2VgWZ2oJLYlWmZA0Aok/hfrfsH+t26fbjmkd1+5f92Et5IJ3XWk6CJUFt6HGetFSJBYPjoIcM3qqYPWBWJrPuaSJFAZW5uDrMH3XYSGalkh5B8413Wx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiBS9lbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E006C4CEF7;
	Mon, 29 Dec 2025 22:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767046361;
	bh=xqTgw70GY2Comj1uBguVjBKD7DfrV7734K07WeFrsL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiBS9lbD+hsB9yvWIrMtXeIV1bkzbKYei4Dsk/mLxq4AfSI4ak9YnEZ+DD1bTglXj
	 OrYIkzBnH5psaVoGuBngq16Is7wAeOngS6YXV9PmFrl66F2lJYbp0mBOXY2KhKWeD9
	 +cqH87xC972Ymm68td8qqGgzPmKMGo3nSh8HcGV2u+vpokqkR4c4/jW13zV/XaSuxg
	 I0YUU8zFuylir8Gdw/vw1oYs0mHL835AIHNK1gHOKYQdxQAN8/R59BH/HHTZmCmv7b
	 /lmcT4rzj1g4VbT78xyWh8ilITABTkZto2SSi2Dg4B+8vAHUKJWiJIgMgWzjyMMLiz
	 /fmaSKrZuRRQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] btrfs: don't rewrite ret from inode_permission
Date: Mon, 29 Dec 2025 17:12:38 -0500
Message-ID: <20251229221238.1738481-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122956-email-disrupt-f2c8@gregkh>
References: <2025122956-email-disrupt-f2c8@gregkh>
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
index 50f75986a79b..6c97610e90bf 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2553,10 +2553,8 @@ static int btrfs_search_path_in_tree_user(struct user_namespace *mnt_userns,
 			ret = inode_permission(mnt_userns, temp_inode,
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


