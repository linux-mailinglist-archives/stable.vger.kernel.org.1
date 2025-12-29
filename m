Return-Path: <stable+bounces-203511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5428DCE6912
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18CC8300981D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AE8308F2E;
	Mon, 29 Dec 2025 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d3EK2P6x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A02F28FF
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008409; cv=none; b=TYVzNjdFnH3PXr6gjwtpETReptB7MENbwz0qh6dY3nkN1eR1aBUsSwExUt19ErmScsV9DHp8ffsvw24cG9HycCoblKbGb1q5dpgtox62bLEIcvBySv70YN3AJfHvPyL/l2AIQrtzkvHAr/HtnWAUWEtwmT/WA3A607HpulBh0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008409; c=relaxed/simple;
	bh=RELmR2rTMmuuGdkPSd9HHGuhST7PqpVQeVS0xZ17I6c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lPHZrcZBOipFnloV8suKUDS1MSCHPM3nteEDua6Q1kPCB2CWpJrB/JuE90dex36n4Nx7MGQLQUatHhYeKJ9Y/cyTBqKCahHGhlV4SmksvyTB8zcI7/cSr1/4TLF7cKCTA0FVnA/apPbtrnuLd6uia6MEt91p/ubgh1AkDWPYlCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d3EK2P6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515B9C116C6;
	Mon, 29 Dec 2025 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008408;
	bh=RELmR2rTMmuuGdkPSd9HHGuhST7PqpVQeVS0xZ17I6c=;
	h=Subject:To:Cc:From:Date:From;
	b=d3EK2P6x7Y9A22uno5HQtbdxQ4YqBS4Hp1r9umHA8I7nnh1hVDPfGjhYM8CMJdd00
	 wXC15uNMzbwP4+YzcV4o4HD3ITklgsGymKLnffLxv1cyWtmllIipBH4Qx4Wt7TZbCo
	 +zxw2JUYLuwwlgfPwHN5c9PslY+HKQVXRcSQOLaw=
Subject: FAILED: patch "[PATCH] btrfs: don't rewrite ret from inode_permission" failed to apply to 6.6-stable tree
To: josef@toxicpanda.com,dsterba@suse.com,johannes.thumshirn@wdc.com,neelx@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:39:55 +0100
Message-ID: <2025122955-fever-mustiness-049e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0185c2292c600993199bc6b1f342ad47a9e8c678
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122955-fever-mustiness-049e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


