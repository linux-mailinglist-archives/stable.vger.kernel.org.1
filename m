Return-Path: <stable+bounces-214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25C37F758A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD17B21416
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1143728E36;
	Fri, 24 Nov 2023 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="inr7tFD7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343424A06
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD91C433C8;
	Fri, 24 Nov 2023 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700833799;
	bh=4wU+UhnIezZT9oWcObivQ/IejmAEsUxsSn1/gCEq/pM=;
	h=Subject:To:Cc:From:Date:From;
	b=inr7tFD7afH6qtTMODK6Z/68oPK6YKhUFlfBE46Ygd14Ery4yIwiJok1AXu+DsHb+
	 fmMymv85lhkKef9Ph60SG5/9hHdwEFWdAUhqUIt/ILXloZriwXxy0L+DpSdx5rqcKu
	 aK8ma80+sdK4twbvZC1VkhBcAUFN4ucAS1OJiI+0=
Subject: FAILED: patch "[PATCH] ext4: fix racy may inline data check in dio write" failed to apply to 5.15-stable tree
To: bfoster@redhat.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:49:48 +0000
Message-ID: <2023112448-opposing-boxy-53a0@gregkh>
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
git cherry-pick -x ce56d21355cd6f6937aca32f1f44ca749d1e4808
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112448-opposing-boxy-53a0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ce56d21355cd ("ext4: fix racy may inline data check in dio write")
310ee0902b8d ("ext4: allow concurrent unaligned dio overwrites")
240930fb7e6b ("ext4: dio take shared inode lock when overwriting preallocated blocks")
4bb26f2885ac ("ext4: avoid crash when inline data creation follows DIO write")
786f847f43a5 ("iomap: add per-iomap_iter private data")
36e8c62273aa ("btrfs: add a btrfs_dio_rw wrapper")
42e4c3bdcae7 ("gfs2: Variable rename")
3d198e42ce25 ("Merge tag 'gfs2-v5.17-rc4-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ce56d21355cd6f6937aca32f1f44ca749d1e4808 Mon Sep 17 00:00:00 2001
From: Brian Foster <bfoster@redhat.com>
Date: Mon, 2 Oct 2023 14:50:20 -0400
Subject: [PATCH] ext4: fix racy may inline data check in dio write

syzbot reports that the following warning from ext4_iomap_begin()
triggers as of the commit referenced below:

        if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
                return -ERANGE;

This occurs during a dio write, which is never expected to encounter
an inode with inline data. To enforce this behavior,
ext4_dio_write_iter() checks the current inline state of the inode
and clears the MAY_INLINE_DATA state flag to either fall back to
buffered writes, or enforce that any other writers in progress on
the inode are not allowed to create inline data.

The problem is that the check for existing inline data and the state
flag can span a lock cycle. For example, if the ilock is originally
locked shared and subsequently upgraded to exclusive, another writer
may have reacquired the lock and created inline data before the dio
write task acquires the lock and proceeds.

The commit referenced below loosens the lock requirements to allow
some forms of unaligned dio writes to occur under shared lock, but
AFAICT the inline data check was technically already racy for any
dio write that would have involved a lock cycle. Regardless, lift
clearing of the state bit to the same lock critical section that
checks for preexisting inline data on the inode to close the race.

Cc: stable@kernel.org
Reported-by: syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com
Fixes: 310ee0902b8d ("ext4: allow concurrent unaligned dio overwrites")
Signed-off-by: Brian Foster <bfoster@redhat.com>
Link: https://lore.kernel.org/r/20231002185020.531537-1-bfoster@redhat.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6830ea3a6c59..747c0378122d 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -569,18 +569,20 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return ext4_buffered_write_iter(iocb, from);
 	}
 
+	/*
+	 * Prevent inline data from being created since we are going to allocate
+	 * blocks for DIO. We know the inode does not currently have inline data
+	 * because ext4_should_use_dio() checked for it, but we have to clear
+	 * the state flag before the write checks because a lock cycle could
+	 * introduce races with other writers.
+	 */
+	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+
 	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend,
 				    &unwritten, &dio_flags);
 	if (ret <= 0)
 		return ret;
 
-	/*
-	 * Make sure inline data cannot be created anymore since we are going
-	 * to allocate blocks for DIO. We know the inode does not have any
-	 * inline data now because ext4_dio_supported() checked for that.
-	 */
-	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
-
 	offset = iocb->ki_pos;
 	count = ret;
 


