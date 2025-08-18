Return-Path: <stable+bounces-170009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284D9B29FE2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4648E7AB398
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388C6156F45;
	Mon, 18 Aug 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jGwyhbMz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD39261B7F
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514863; cv=none; b=sLgKqm+WOsxKZNe/f0aNAVu257nJQcOM1RqaKYQXNmTzK3/iZjKWqr+pc7r+MZZNoF6W/ECThX8XAZlzaiDC/ulI5Lq5wSV5FF4IG2cHgBzWiECE7mUoIl8Fa6k0LjsCqbvXl5+d1U7NT4ysqP3PNB8sOcdrGOw2fdsl7ywDbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514863; c=relaxed/simple;
	bh=NIGxAKPxSZFvVvX+y1h04o1N+d8q0elXsQrFwMwvUIo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C8WLmAXXNoTHOhPry9Wbc9q5hqVI4FNL6AhcAKlw72Ub3HmIhg6b4ah++O5PO79+LVtEj0GN2LGJkxPsSzSvR1ZzhKelq5dJymOubQGZEsXAvdov/B1PXDTYjhK8UV4MRbwDulCXW/Gn+/Y6q1XtcI9EHmeIs7G8SNiPCDIqXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jGwyhbMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CAFC4CEED;
	Mon, 18 Aug 2025 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514862;
	bh=NIGxAKPxSZFvVvX+y1h04o1N+d8q0elXsQrFwMwvUIo=;
	h=Subject:To:Cc:From:Date:From;
	b=jGwyhbMzva7m7c5w/EOf1U7FSO1jgco3sMWXuJUhN36puouMv3VGIiydJa5sQgi7Y
	 prpatIc5oTqULMczFjghXFte+JXfki43TR/J63+kQjRIeI4Z+tGqiPM+NOYfdVRi5G
	 Vs5P1rxKaAPxJyjv3HEXPCl8i71OHVnmE9YgLBgU=
Subject: FAILED: patch "[PATCH] btrfs: populate otime when logging an inode item" failed to apply to 6.6-stable tree
To: wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 13:00:54 +0200
Message-ID: <2025081854-eject-aloft-03ff@gregkh>
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
git cherry-pick -x 1ef94169db0958d6de39f9ea6e063ce887342e2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081854-eject-aloft-03ff@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ef94169db0958d6de39f9ea6e063ce887342e2d Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Wed, 2 Jul 2025 15:08:13 +0930
Subject: [PATCH] btrfs: populate otime when logging an inode item

[TEST FAILURE WITH EXPERIMENTAL FEATURES]
When running test case generic/508, the test case will fail with the new
btrfs shutdown support:

generic/508       - output mismatch (see /home/adam/xfstests/results//generic/508.out.bad)
    --- tests/generic/508.out	2022-05-11 11:25:30.806666664 +0930
    +++ /home/adam/xfstests/results//generic/508.out.bad	2025-07-02 14:53:22.401824212 +0930
    @@ -1,2 +1,6 @@
     QA output created by 508
     Silence is golden
    +Before:
    +After : stat.btime = Thu Jan  1 09:30:00 1970
    +Before:
    +After : stat.btime = Wed Jul  2 14:53:22 2025
    ...
    (Run 'diff -u /home/adam/xfstests/tests/generic/508.out /home/adam/xfstests/results//generic/508.out.bad'  to see the entire diff)
Ran: generic/508
Failures: generic/508
Failed 1 of 1 tests

Please note that the test case requires shutdown support, thus the test
case will be skipped using the current upstream kernel, as it doesn't
have shutdown ioctl support.

[CAUSE]
The direct cause the 0 time stamp in the log tree:

leaf 30507008 items 2 free space 16057 generation 9 owner TREE_LOG
leaf 30507008 flags 0x1(WRITTEN) backref revision 1
checksum stored e522548d
checksum calced e522548d
fs uuid 57d45451-481e-43e4-aa93-289ad707a3a0
chunk uuid d52bd3fd-5163-4337-98a7-7986993ad398
	item 0 key (257 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 9 transid 9 size 0 nbytes 0
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x0(none)
		atime 1751432947.492000000 (2025-07-02 14:39:07)
		ctime 1751432947.492000000 (2025-07-02 14:39:07)
		mtime 1751432947.492000000 (2025-07-02 14:39:07)
		otime 0.0 (1970-01-01 09:30:00) <<<

But the old fs tree has all the correct time stamp:

btrfs-progs v6.12
fs tree key (FS_TREE ROOT_ITEM 0)
leaf 30425088 items 2 free space 16061 generation 5 owner FS_TREE
leaf 30425088 flags 0x1(WRITTEN) backref revision 1
checksum stored 48f6c57e
checksum calced 48f6c57e
fs uuid 57d45451-481e-43e4-aa93-289ad707a3a0
chunk uuid d52bd3fd-5163-4337-98a7-7986993ad398
	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 3 transid 0 size 0 nbytes 16384
		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
		sequence 0 flags 0x0(none)
		atime 1751432947.0 (2025-07-02 14:39:07)
		ctime 1751432947.0 (2025-07-02 14:39:07)
		mtime 1751432947.0 (2025-07-02 14:39:07)
		otime 1751432947.0 (2025-07-02 14:39:07) <<<

The root cause is that fill_inode_item() in tree-log.c is only
populating a/c/m time, not the otime (or btime in statx output).

Part of the reason is that, the vfs inode only has a/c/m time, no native
btime support yet.

[FIX]
Thankfully btrfs has its otime stored in btrfs_inode::i_otime_sec and
btrfs_inode::i_otime_nsec.

So what we really need is just fill the otime time stamp in
fill_inode_item() of tree-log.c

There is another fill_inode_item() in inode.c, which is doing the proper
otime population.

Fixes: 94edf4ae43a5 ("Btrfs: don't bother committing delayed inode updates when fsyncing")
CC: stable@vger.kernel.org
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1e805dabfc4b..ab0815d9e7e5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4233,6 +4233,9 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_timespec_sec(leaf, &item->ctime, inode_get_ctime_sec(inode));
 	btrfs_set_timespec_nsec(leaf, &item->ctime, inode_get_ctime_nsec(inode));
 
+	btrfs_set_timespec_sec(leaf, &item->otime, BTRFS_I(inode)->i_otime_sec);
+	btrfs_set_timespec_nsec(leaf, &item->otime, BTRFS_I(inode)->i_otime_nsec);
+
 	/*
 	 * We do not need to set the nbytes field, in fact during a fast fsync
 	 * its value may not even be correct, since a fast fsync does not wait


