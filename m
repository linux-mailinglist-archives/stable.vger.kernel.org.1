Return-Path: <stable+bounces-192771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD24C427B9
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 06:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAED188C6CD
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 05:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6D226E6E4;
	Sat,  8 Nov 2025 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oH+7tXR4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD01F419A
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 05:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762579502; cv=none; b=vDMiayOKvpzSUoCvZUxYsJCdHdN0gBboLr7MheRqcatVCa/M1VmVOlXWsNWHe98/pJNucoUTxm6Pyvc/wkGwJnc3wybLrS2a+rWU/+3XLcQs09/QqE2lA4CsIXnLfm/JbEJDuFhTqIN/gnkiTTXG8uvZ5YjqL3t5+S54hOag2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762579502; c=relaxed/simple;
	bh=P1jQ0W5d4rPX1BoXq7spDZmh+pppZrCjAWlrSEqd6FI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SjUKKtfA+utzrLM8RpjFogRecTlZKXJtSTFz798rTSDrPkZj13Xg2vQhvZ/EyT+RVaTY/RjCTkch7mQHB6vqnyI4FDqSjCoiErGBnYa2OLMz3kXbbJIfbE8WK1XEdLCGywdIkX5/KOiV9TzJKoj6UfMBoH170yHnM8u1Daz2WWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oH+7tXR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215D8C4CEF7;
	Sat,  8 Nov 2025 05:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762579501;
	bh=P1jQ0W5d4rPX1BoXq7spDZmh+pppZrCjAWlrSEqd6FI=;
	h=Subject:To:Cc:From:Date:From;
	b=oH+7tXR4Tzb1r1metVDhOwdVzts2vAhHzU6PvZU6b54uSgOXNch0gqfd8F7WA86UP
	 RhahnqL2eS+e9q0e5AqVQDkVL9BPRn3Y2dx39rI5l7ZCrZNSIXClpxUZrNwOsOH4Kl
	 VmV1OJmmAqTXrXQJLTe8lDg58tTABotuP0ZhjW24=
Subject: FAILED: patch "[PATCH] btrfs: ensure no dirty metadata is written back for an fs" failed to apply to 6.6-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 08 Nov 2025 14:24:58 +0900
Message-ID: <2025110858-banker-discolor-266d@gregkh>
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
git cherry-pick -x 2618849f31e7cf51fadd4a5242458501a6d5b315
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110858-banker-discolor-266d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2618849f31e7cf51fadd4a5242458501a6d5b315 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Thu, 23 Oct 2025 19:44:04 +1030
Subject: [PATCH] btrfs: ensure no dirty metadata is written back for an fs
 with errors

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

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 755ec6dfd51c..23273d0e6f22 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2228,6 +2228,14 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		wbc_account_cgroup_owner(wbc, folio, range_len);
 		folio_unlock(folio);
 	}
+	/*
+	 * If the fs is already in error status, do not submit any writeback
+	 * but immediately finish it.
+	 */
+	if (unlikely(BTRFS_FS_ERROR(fs_info))) {
+		btrfs_bio_end_io(bbio, errno_to_blk_status(BTRFS_FS_ERROR(fs_info)));
+		return;
+	}
 	btrfs_submit_bbio(bbio, 0);
 }
 


