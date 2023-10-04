Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6010F7B8A7B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbjJDSgA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244430AbjJDSf6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:35:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12893AB
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:35:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57469C433C9;
        Wed,  4 Oct 2023 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444554;
        bh=Znwu/vqcd9l/Y56R0dpQyfqY/smlUU24ySWPOQLwXDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shTLQrYuf0gYNQjV+B+srX758rTg0vNqmt4UgX6S979qgKeHaooT+fQLSDGNYgGL0
         ajER+dQgGzgDiEY10QkUzVUhE+BIN1M5fH4Km69HAlvQvng/MbA6yQelmQ52LOxVU8
         sKIYvADTdS8lVMl+mGDyIEnagWDg2CBfiCaCJcEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        Bernd Schubert <bschubert@ddn.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.5 291/321] btrfs: file_remove_privs needs an exclusive lock in direct io write
Date:   Wed,  4 Oct 2023 19:57:16 +0200
Message-ID: <20231004175242.755083607@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernd Schubert <bschubert@ddn.com>

commit 9af86694fd5d387992699ec99007ed374966ce9a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/file.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1466,8 +1466,13 @@ static ssize_t btrfs_direct_write(struct
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
@@ -1475,6 +1480,13 @@ relock:
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


