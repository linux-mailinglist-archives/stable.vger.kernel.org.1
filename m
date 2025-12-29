Return-Path: <stable+bounces-203513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F50CE6915
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E280930204A0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448933093C1;
	Mon, 29 Dec 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KM+3PL9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6830DEBC
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008415; cv=none; b=adc81rtrHRL/JkolIVPiHRd8cfVwIJzX/Iizpkf9cdhv83NZhjeRjGU4XK+tCNsGBHB2cG5b/pRULwQBuxRkZpdyURcahA80tVvjclYassdEKD0d2MTgpEmRooEO70O/3L6g1vYtMWAIX5VM3sHqJVvn6mgQzBuqCIcKc5JE+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008415; c=relaxed/simple;
	bh=oo7w2/9O2iJWgYtYBzP+pN9JZygPk+qWEuOhAFuKOws=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ptTUkbKhQQz6o3FLWSOKmlyh8vZkUa8tHkgCCtUpzcMYrn3ri5MVOJ4KhCoWGwdjTggCBsjyVB9q/WiFPIfuTw7TrChoP/JwRHeEBk7e6cUSCSRmS3je6i9rocaEBC/+GT1JhocNMEcA6xz1A7h+gjLCQ5DQyzrUDo0eNnJzHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KM+3PL9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9471C4CEF7;
	Mon, 29 Dec 2025 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008414;
	bh=oo7w2/9O2iJWgYtYBzP+pN9JZygPk+qWEuOhAFuKOws=;
	h=Subject:To:Cc:From:Date:From;
	b=KM+3PL9EqOstxe/Ux8XaQtVOwyHSiJ2OlhpIINy/yArNv/bg2eXdbr4ysd31b7wa0
	 uTNmoM/cCTJj62F9WTkgF5/PMECJU3lLxHuIeyCFVtymwT3eWllIA/p2XTgnJqAd8b
	 AuKhsYY/MHS0jI8LcMO7VMRM4+TmHNjvbMwSnvRo=
Subject: FAILED: patch "[PATCH] btrfs: don't rewrite ret from inode_permission" failed to apply to 5.15-stable tree
To: josef@toxicpanda.com,dsterba@suse.com,johannes.thumshirn@wdc.com,neelx@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:39:56 +0100
Message-ID: <2025122956-email-disrupt-f2c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0185c2292c600993199bc6b1f342ad47a9e8c678
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122956-email-disrupt-f2c8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0185c2292c600993199bc6b1f342ad47a9e8c678 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 18 Nov 2025 17:08:41 +0100
Subject: [PATCH] btrfs: don't rewrite ret from inode_permission

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

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 59cef7e376a0..a10b60439718 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1910,10 +1910,8 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			ret = inode_permission(idmap, &temp_inode->vfs_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(&temp_inode->vfs_inode);
-			if (ret) {
-				ret = -EACCES;
+			if (ret)
 				goto out_put;
-			}
 
 			if (key.offset == upper_limit)
 				break;


