Return-Path: <stable+bounces-120292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E97AA4E761
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85284422241
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248E27CCD0;
	Tue,  4 Mar 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mSoe393D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D9209F33
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106028; cv=none; b=Fm4bbXKOTKvPCdf5c3ngRUmBsPCIswgBiz4u4n+L5yUNN8K3i5k06Vw8aa4HXIy6CB0rBaCt/4kt5PBswfbGvKmQeM54tBP7TRCmKbtWbBSXa8fW8aysXW7rcI20CwLFRCQDl0TGPiH1h6cghGpWrg5hbIuBwVCM0RCgfLfFP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106028; c=relaxed/simple;
	bh=zA3CTFKkxLKcC4IO0E4IaQXztA6UoZcCid440XIkUCs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AM4Dp1jA8p40bY/iE9mj2HQCcbElKa2FUTOMoHOFWIsl0SY7yuEwQQoJyVkDy7nTj8/w14L9/Jo5BdjD619OQJILex2Mst/tiAi2yK51aCJUdaXtZlXWNVxwH14GzLGfQ2jeSYZ++Hie4CvIti+af1KdxSutuAoSRlyxsVKCXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mSoe393D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1713C4CEE5;
	Tue,  4 Mar 2025 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106028;
	bh=zA3CTFKkxLKcC4IO0E4IaQXztA6UoZcCid440XIkUCs=;
	h=Subject:To:Cc:From:Date:From;
	b=mSoe393D1Xin1mcmjwxDNasmftCKKRdLI6Yve7vkqB0bksXteGL8xOKcsOdr6mw7D
	 ioHRX6Mbi7qA+IMEA0MkXh5sYOWvUTdgfLn29UsqJ9rlHo900myw1SjgMK0MVPVONT
	 e7T/wuu+c9xQoG4JMFzL9YnDUQe12nBNlo4A9dhw=
Subject: FAILED: patch "[PATCH] btrfs: do regular iput instead of delayed iput during extent" failed to apply to 6.12-stable tree
To: fdmanana@suse.com,dsterba@suse.com,intelfx@intelfx.name,johannes.thumshirn@wdc.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:33:45 +0100
Message-ID: <2025030445-collected-spoken-1e75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 15b3b3254d1453a8db038b7d44b311a2d6c71f98
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030445-collected-spoken-1e75@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15b3b3254d1453a8db038b7d44b311a2d6c71f98 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Sat, 15 Feb 2025 11:11:29 +0000
Subject: [PATCH] btrfs: do regular iput instead of delayed iput during extent
 map shrinking

The extent map shrinker now runs in the system unbound workqueue and no
longer in kswapd context so it can directly do an iput() on inodes even
if that blocks or needs to acquire any lock (we aren't holding any locks
when requesting the delayed iput from the shrinker). So we don't need to
add a delayed iput, wake up the cleaner and delegate the iput() to the
cleaner, which also adds extra contention on the spinlock that protects
the delayed iputs list.

Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
Tested-by: Ivan Shapovalov <intelfx@intelfx.name>
Link: https://lore.kernel.org/linux-btrfs/0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name/
CC: stable@vger.kernel.org # 6.12+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 8c6b85ffd18f..7f46abbd6311 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1256,7 +1256,7 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 
 		min_ino = btrfs_ino(inode) + 1;
 		fs_info->em_shrinker_last_ino = btrfs_ino(inode);
-		btrfs_add_delayed_iput(inode);
+		iput(&inode->vfs_inode);
 
 		if (ctx->scanned >= ctx->nr_to_scan || btrfs_fs_closing(fs_info))
 			break;


