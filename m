Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21287B84BB
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 18:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjJDQRH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjJDQRG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 12:17:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8621EA9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 09:17:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7337C433C8;
        Wed,  4 Oct 2023 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696436223;
        bh=YNHLlZo2zvFfPhmTLCZ7S/yC4JmIASY8cTNmyp1iiRU=;
        h=Subject:To:Cc:From:Date:From;
        b=dAXE3dlERxrmVg4DVKNEpbGk9VZ8l1bQOW4XVtY2qg5MFE8B6kaqC04dZGr+quGAI
         Ra8p+Ad0wI0GMUOIo54yMfTIGniPuMnIvREyJC8+JgGKNFe0T+MAPee7d+lQczYRft
         GAo0Mc8M8k28qe01n3sCO7Z0+1S3KCyEQoANofZA=
Subject: FAILED: patch "[PATCH] btrfs: file_remove_privs needs an exclusive lock in direct io" failed to apply to 5.15-stable tree
To:     bschubert@ddn.com, dsterba@suse.com, hch@lst.de, miklos@szeredi.hu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 18:17:00 +0200
Message-ID: <2023100400-appraisal-idealize-3243@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9af86694fd5d387992699ec99007ed374966ce9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100400-appraisal-idealize-3243@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9af86694fd5d387992699ec99007ed374966ce9a Mon Sep 17 00:00:00 2001
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 6 Sep 2023 17:59:03 +0200
Subject: [PATCH] btrfs: file_remove_privs needs an exclusive lock in direct io
 write

This was noticed by Miklos that file_remove_privs might call into
notify_change(), which requires to hold an exclusive lock. The problem
exists in FUSE and btrfs. We can fix it without any additional helpers
from VFS, in case the privileges would need to be dropped, change the
lock type to be exclusive and redo the loop.

Fixes: e9adabb9712e ("btrfs: use shared lock for direct writes within EOF")
CC: Miklos Szeredi <miklos@szeredi.hu>
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6edad7b9a5d3..e8726a83b649 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1466,8 +1466,13 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
 
-	/* If the write DIO is within EOF, use a shared lock */
-	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode))
+	/*
+	 * If the write DIO is within EOF, use a shared lock and also only if
+	 * security bits will likely not be dropped by file_remove_privs() called
+	 * from btrfs_write_check(). Either will need to be rechecked after the
+	 * lock was acquired.
+	 */
+	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode) && IS_NOSEC(inode))
 		ilock_flags |= BTRFS_ILOCK_SHARED;
 
 relock:
@@ -1475,6 +1480,13 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (err < 0)
 		return err;
 
+	/* Shared lock cannot be used with security bits set. */
+	if ((ilock_flags & BTRFS_ILOCK_SHARED) && !IS_NOSEC(inode)) {
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+		ilock_flags &= ~BTRFS_ILOCK_SHARED;
+		goto relock;
+	}
+
 	err = generic_write_checks(iocb, from);
 	if (err <= 0) {
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);

