Return-Path: <stable+bounces-171808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18009B2C807
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 17:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5358D7BB069
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B5299AB5;
	Tue, 19 Aug 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhWkJMmL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FF298CC4
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615477; cv=none; b=G4ie/ItVbF3kxbbe2bnOEyIiMD6pLmR7TG7+QTp7hx2f8426OEfCWALE7KMV01JSLWj5ylOHE1C2clQWHB4dFFo+2D59Y25IGZHjJsZOjsxzlMldGgmdgXbagrPzePLmhb+YJJYfT+ZEILNsVzPYPD9MnMUzoFEbfWXrTjc4gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615477; c=relaxed/simple;
	bh=zePhLqzysL4qwpHq1kpDhtp4fYGeJmkfLGbXZL44LeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reNd/yRjV8w7CaSV7UNGn+EZgc17NzqQb42YhTTBBChMy4i8nUauHMcuCZSF6lCl5JGJ30KRQv9OszRi8XIHPdWkhjh33amwRhKCg7bQ94K6wVVB1bfXWXxEuQ7M8DmDdB8wZSnIlNmk/onEn/plt/KwBEOBXe7EggeMwOf3g6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhWkJMmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC41C113D0;
	Tue, 19 Aug 2025 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755615476;
	bh=zePhLqzysL4qwpHq1kpDhtp4fYGeJmkfLGbXZL44LeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhWkJMmLMeH2kmizQBFZvJYojVfnvSwvu0J78j/D/fBZfsf57fcX1maacmeYaQUgw
	 VIsbDdQoTDpj3IUzkPs1qg3AiPbmAC4ewE1LhwfY85epJx0Q6XOQPZoP5HhfSUsGMN
	 KAFPE2ZmKsEPPIyrCR8RXpO9dpyM1NjjaHH6HTrhRhIiqjsoyOPLdJymXcSkxnc7kC
	 p6plbhapNBgnhVPktmlihT+IJZZ+C7CyXdF+mA4pLlj1TH7z9W92WIxRNFnQmYZjqy
	 BBWChT0NboG2Ijxgioa1BxNRkAg+reCWktGokgdlAnl15enm3KR7mhkcRWyajUKsS9
	 AKW/l38h5elig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] btrfs: populate otime when logging an inode item
Date: Tue, 19 Aug 2025 10:57:54 -0400
Message-ID: <20250819145754.527446-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081801-shortlist-acutely-2100@gregkh>
References: <2025081801-shortlist-acutely-2100@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 1ef94169db0958d6de39f9ea6e063ce887342e2d ]

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
[ adapted token-based API and timespec64 field structure ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 75bf490cd732..ce201c003546 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3941,6 +3941,11 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_timespec_nsec(leaf, &item->ctime,
 				      inode->i_ctime.tv_nsec, &token);
 
+	btrfs_set_token_timespec_sec(leaf, &item->otime,
+				     BTRFS_I(inode)->i_otime.tv_sec, &token);
+	btrfs_set_token_timespec_nsec(leaf, &item->otime,
+				      BTRFS_I(inode)->i_otime.tv_nsec, &token);
+
 	btrfs_set_token_inode_nbytes(leaf, item, inode_get_bytes(inode),
 				     &token);
 
-- 
2.50.1


