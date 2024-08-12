Return-Path: <stable+bounces-66736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A17794F148
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB591F22BDE
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82117BB35;
	Mon, 12 Aug 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ApPHahEU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3E14C5A4
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475274; cv=none; b=TR42f82yfUKqqEitwWJF1wLRcEG7gS9ViZvyYmKwezWKp3EvrQLIAOa/U+BjpY6YlZl3omyxxvbdubxfb/puXnw6TBTOo8ziWLiKBd3sLSZVqmpe2MZtopfpgym2jMi+avUe1CJ4DxFtalP+ivo/yawoYElK5pFXh1JPdqqZS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475274; c=relaxed/simple;
	bh=wfmtENsWI1rsYTUM9XvhEbZZD/OknZiPNtunCwCjQXc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RKYcfI0o5KrFBoRSQEaIUgkgN/30A6Pe4ZZHaYnbA6kMeeaoFjM9aK9EFDo7W9rQ17MhudXAnvj7OQjm4Le2lTGg/VzjV9BBuo9oE03Sg1LwqDpAZ6YcJ8FuyHclyOZglVlq6fGDG/P6qd3E89eBgkTAyxsVbP1oPk5aqd+v/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ApPHahEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E773C32782;
	Mon, 12 Aug 2024 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723475273;
	bh=wfmtENsWI1rsYTUM9XvhEbZZD/OknZiPNtunCwCjQXc=;
	h=Subject:To:Cc:From:Date:From;
	b=ApPHahEUA22Aztz9kSP7dghj5yV8o4tOtwIvnv9d+Gtmwcby6DJEmRLnbXDwhMug/
	 VYJ/Bnlq8KN7ThXQ9tDU6BST1RTxFSmM0WK02SHfj/ZzFEWdpeKkByIbzrDzELk+5f
	 7OtTZf8mxhYU42uTBBjxPsJVq0pj5SQPIMpTpONU=
Subject: FAILED: patch "[PATCH] btrfs: fix double inode unlock for direct IO sync writes" failed to apply to 6.10-stable tree
To: fdmanana@suse.com,dsterba@suse.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:07:50 +0200
Message-ID: <2024081250-taco-simmering-1043@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x e0391e92f9ab4fb3dbdeb139c967dcfa7ac4b115
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081250-taco-simmering-1043@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

e0391e92f9ab ("btrfs: fix double inode unlock for direct IO sync writes")
56b7169f691c ("btrfs: use a btrfs_inode local variable at btrfs_sync_file()")
e641e323abb3 ("btrfs: pass a btrfs_inode to btrfs_wait_ordered_range()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0391e92f9ab4fb3dbdeb139c967dcfa7ac4b115 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Fri, 2 Aug 2024 09:38:51 +0100
Subject: [PATCH] btrfs: fix double inode unlock for direct IO sync writes

If we do a direct IO sync write, at btrfs_sync_file(), and we need to skip
inode logging or we get an error starting a transaction or an error when
flushing delalloc, we end up unlocking the inode when we shouldn't under
the 'out_release_extents' label, and then unlock it again at
btrfs_direct_write().

Fix that by checking if we have to skip inode unlocking under that label.

Reported-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000dfd631061eaeb4bc@google.com/
Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9f10a9f23fcc..9914419f3b7d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1868,7 +1868,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&inode->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	goto out;
 }
 


