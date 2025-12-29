Return-Path: <stable+bounces-204146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEFDCE84AD
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 23:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6533030194E1
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 22:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB8E328B5C;
	Mon, 29 Dec 2025 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIkDlPZX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EE3275B1A
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767048302; cv=none; b=p2yhk3KWKjhlmo02IKA96ZD8ZBbugRpSBmMoOXuzTLgThI8qxQ2ms3QsZBUv8WsPO75SEGTQIOFelVNLwuaQfnsaPBpUqnr3q/vGeXwubaUCBfYz7zmNML5GU5jF2IPJujk30M+KqfGCpfPiimSvHTWGZo+tDBsDLMoP0QjLydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767048302; c=relaxed/simple;
	bh=A5ke8ZOFtgsGqssHk4qfWbI9vvnMK2Qjm4bvENYDsNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiM+ehYq4WTvkBjB3CUyHiUCKy6Tk9O9T/VbNPLA4EXxnrSirYTv0J9C0izl5yXVsjMj/gkIxTOgsAih+vGcR5VgdAvcPdLvppkjblSq99INUsB/wLWij5E/kuG8/C79ZyVQpVxBmCcycUfCdH8BHP2Q6xreSUv2g8gQBxCEIRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIkDlPZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D2AC4CEF7;
	Mon, 29 Dec 2025 22:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767048301;
	bh=A5ke8ZOFtgsGqssHk4qfWbI9vvnMK2Qjm4bvENYDsNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIkDlPZXf+YHDGLj85La1n51JTdwxV6pw6KarQiIiE/eNWuILP1vWj7WGPAbtm6PD
	 0IxGVYGvRylfKDmdLphk9Y8TX7Dddy/w0lu4SScvjDHyAePVuK3PfBtE01G4tp/la5
	 4MzanZnsqP4iA9r6b1dGo+OGgee+m4/zWbKtp2hEwvOd/1emUkxEb04OytJ/zdyYUZ
	 t9mKZe/8HhX7QOofS9Qdb7hLxB3yYhKt8Ik+2pcRbTWJ3B4FLQf9/nRtc/aybI0YDp
	 18Uy+kNWdMM3sZayahACUIq+BqBlVJSuW+C8DOWhHNJy+QK5fzR7jug8/PzAmbdASN
	 41FYLnCEWh39A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] btrfs: don't rewrite ret from inode_permission
Date: Mon, 29 Dec 2025 17:44:59 -0500
Message-ID: <20251229224459.1750388-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122956-output-cornmeal-7c59@gregkh>
References: <2025122956-output-cornmeal-7c59@gregkh>
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
index 9d5dfcec22de..4a35d51dfef8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2573,10 +2573,8 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 			}
 			ret = inode_permission(temp_inode, MAY_READ | MAY_EXEC);
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


