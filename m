Return-Path: <stable+bounces-192782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D087FC42E14
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 15:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7588E3A424A
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1718FDDE;
	Sat,  8 Nov 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQTEsl7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD87483
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610986; cv=none; b=AKhbxRcH7ILg164UyMxWo4NpOrPYtObeZqqC+nk93aVsOokaP2OTEW8eFoqjtVfbYtKVMR/WYf7UbM+w/sPZfB4NdZJxAdJA8nurKRDM8518rbha9HWaYNZYMfzIUOL7wy7T1ikPnEt6ZRp+Av11bRMuj8bCq7haxkRcWTNznQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610986; c=relaxed/simple;
	bh=NPUD18z25FYfm33ofmm5BfieA5EN80d39Y64AH5X9vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOdoW1+UOswuRfwNw6rdHwUQICKJKVTpoIy4TzT0F9sa3CAyGgm+tQjtCR3xDT27g7nFrD1/VuEnTBpf41l6AiPIW0sip/fe+mC9pVhQW/IyOSC0Kl5DI/7ZZQ6nMKATAeKgAo8jgNSTuWFLIYnYitU6HI3rjCYM+xe6XMC77nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQTEsl7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF56FC4CEF7;
	Sat,  8 Nov 2025 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762610986;
	bh=NPUD18z25FYfm33ofmm5BfieA5EN80d39Y64AH5X9vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQTEsl7oVwDKLEgKC/hEL32E5Wvwj7o6+GutCLxMlacMeGSRwsa5IitxgQccbsKIv
	 gFkNnNGfDvMutZgryhD49xZ+U9y/LCJ9jZDLnZPihzkZioslmVzOlf4eGt4cBd8j00
	 6hjf32x5uzO7H9LDkRLBDOTi6adG4FvWf2X6M9AZBLnhtxwvrpPXEEZ3UMob3JIpN8
	 R8yTcqfeqY5OOV/JB294pW+Qgsui7a6FwE/5exzHDiRsuGMPZT83Za/m8cPtdbs5xA
	 /EI6OUkpBw0TqnkRWZYYFc2J3l8L7Yew/taMjyYuFf1hL1uHU1FGiwPOIZ56hlOryY
	 2IugXnxb3R9FA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] btrfs: ensure no dirty metadata is written back for an fs with errors
Date: Sat,  8 Nov 2025 09:09:44 -0500
Message-ID: <20251108140944.129703-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110858-banker-discolor-266d@gregkh>
References: <2025110858-banker-discolor-266d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 2618849f31e7cf51fadd4a5242458501a6d5b315 ]

[BUG]
During development of a minor feature (make sure all btrfs_bio::end_io()
is called in task context), I noticed a crash in generic/388, where
metadata writes triggered new works after btrfs_stop_all_workers().

It turns out that it can even happen without any code modification, just
using RAID5 for metadata and the same workload from generic/388 is going
to trigger the use-after-free.

[CAUSE]
If btrfs hits an error, the fs is marked as error, no new
transaction is allowed thus metadata is in a frozen state.

But there are some metadata modifications before that error, and they are
still in the btree inode page cache.

Since there will be no real transaction commit, all those dirty folios
are just kept as is in the page cache, and they can not be invalidated
by invalidate_inode_pages2() call inside close_ctree(), because they are
dirty.

And finally after btrfs_stop_all_workers(), we call iput() on btree
inode, which triggers writeback of those dirty metadata.

And if the fs is using RAID56 metadata, this will trigger RMW and queue
new works into rmw_workers, which is already stopped, causing warning
from queue_work() and use-after-free.

[FIX]
Add a special handling for write_one_eb(), that if the fs is already in
an error state, immediately mark the bbio as failure, instead of really
submitting them.

Then during close_ctree(), iput() will just discard all those dirty
tree blocks without really writing them back, thus no more new jobs for
already stopped-and-freed workqueues.

The extra discard in write_one_eb() also acts as an extra safenet.
E.g. the transaction abort is triggered by some extent/free space
tree corruptions, and since extent/free space tree is already corrupted
some tree blocks may be allocated where they shouldn't be (overwriting
existing tree blocks). In that case writing them back will further
corrupting the fs.

CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2d6ccc21a8229..fab8ffb3a2f82 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1751,6 +1751,14 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 			unlock_page(p);
 		}
 	}
+	/*
+	 * If the fs is already in error status, do not submit any writeback
+	 * but immediately finish it.
+	 */
+	if (unlikely(BTRFS_FS_ERROR(fs_info))) {
+		btrfs_bio_end_io(bbio, errno_to_blk_status(BTRFS_FS_ERROR(fs_info)));
+		return;
+	}
 	btrfs_submit_bio(bbio, 0);
 }
 
-- 
2.51.0


