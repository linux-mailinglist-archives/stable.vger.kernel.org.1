Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA157A39CA
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbjIQTyK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbjIQTx6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43266F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:53:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7596EC433C7;
        Sun, 17 Sep 2023 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980432;
        bh=JAIXE1cvG+2nQ+CthiAIwCybma1Z7/22pP0RlCh7CSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agwnjZlKCywnM4L6HTE/KBZBe9yLE6MHPQNh7LHlUOatFKX2P2sWekk2Yk5gu1iuw
         Bxef7N5MWTcldVA0LCKkI1AKl9MaFJ+VMfq5GEcDc1dxAmXI/LX8R0Lb0n3BsHjBfn
         t5TwViEfGZCYHPkkJCy8OOGKl32s7gGGs/KC3H88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com,
        Pengfei Xu <pengfei.xu@intel.com>,
        Brian Foster <bfoster@redhat.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.5 190/285] ext4: drop dio overwrite only flag and associated warning
Date:   Sun, 17 Sep 2023 21:13:10 +0200
Message-ID: <20230917191058.178304494@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

From: Brian Foster <bfoster@redhat.com>

commit 194505b55dd7899da114a4d47825204eefc0fff5 upstream.

The commit referenced below opened up concurrent unaligned dio under
shared locking for pure overwrites. In doing so, it enabled use of
the IOMAP_DIO_OVERWRITE_ONLY flag and added a warning on unexpected
-EAGAIN returns as an extra precaution, since ext4 does not retry
writes in such cases. The flag itself is advisory in this case since
ext4 checks for unaligned I/Os and uses appropriate locking up
front, rather than on a retry in response to -EAGAIN.

As it turns out, the warning check is susceptible to false positives
because there are scenarios where -EAGAIN can be expected from lower
layers without necessarily having IOCB_NOWAIT set on the iocb. For
example, one instance of the warning has been seen where io_uring
sets IOCB_HIPRI, which in turn results in REQ_POLLED|REQ_NOWAIT on
the bio. This results in -EAGAIN if the block layer is unable to
allocate a request, etc. [Note that there is an outstanding patch to
untangle REQ_POLLED and REQ_NOWAIT such that the latter relies on
IOCB_NOWAIT, which would also address this instance of the warning.]

Another instance of the warning has been reproduced by syzbot. A dio
write is interrupted down in __get_user_pages_locked() waiting on
the mm lock and returns -EAGAIN up the stack. If the iomap dio
iteration layer has made no progress on the write to this point,
-EAGAIN returns up to the filesystem and triggers the warning.

This use of the overwrite flag in ext4 is precautionary and
half-baked. I.e., ext4 doesn't actually implement overwrite checking
in the iomap callbacks when the flag is set, so the only extra
verification it provides are i_size checks in the generic iomap dio
layer. Combined with the tendency for false positives, the added
verification is not worth the extra trouble. Remove the flag,
associated warning, and update the comments to document when
concurrent unaligned dio writes are allowed and why said flag is not
used.

Cc: stable@kernel.org
Reported-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Fixes: 310ee0902b8d ("ext4: allow concurrent unaligned dio overwrites")
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230810165559.946222-1-bfoster@redhat.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/file.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2071b1e4322c..e99cc17b6bd2 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -476,6 +476,11 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	 * required to change security info in file_modified(), for extending
 	 * I/O, any form of non-overwrite I/O, and unaligned I/O to unwritten
 	 * extents (as partial block zeroing may be required).
+	 *
+	 * Note that unaligned writes are allowed under shared lock so long as
+	 * they are pure overwrites. Otherwise, concurrent unaligned writes risk
+	 * data corruption due to partial block zeroing in the dio layer, and so
+	 * the I/O must occur exclusively.
 	 */
 	if (*ilock_shared &&
 	    ((!IS_NOSEC(inode) || *extend || !overwrite ||
@@ -492,21 +497,12 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 
 	/*
 	 * Now that locking is settled, determine dio flags and exclusivity
-	 * requirements. Unaligned writes are allowed under shared lock so long
-	 * as they are pure overwrites. Set the iomap overwrite only flag as an
-	 * added precaution in this case. Even though this is unnecessary, we
-	 * can detect and warn on unexpected -EAGAIN if an unsafe unaligned
-	 * write is ever submitted.
-	 *
-	 * Otherwise, concurrent unaligned writes risk data corruption due to
-	 * partial block zeroing in the dio layer, and so the I/O must occur
-	 * exclusively. The inode lock is already held exclusive if the write is
-	 * non-overwrite or extending, so drain all outstanding dio and set the
-	 * force wait dio flag.
+	 * requirements. We don't use DIO_OVERWRITE_ONLY because we enforce
+	 * behavior already. The inode lock is already held exclusive if the
+	 * write is non-overwrite or extending, so drain all outstanding dio and
+	 * set the force wait dio flag.
 	 */
-	if (*ilock_shared && unaligned_io) {
-		*dio_flags = IOMAP_DIO_OVERWRITE_ONLY;
-	} else if (!*ilock_shared && (unaligned_io || *extend)) {
+	if (!*ilock_shared && (unaligned_io || *extend)) {
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			ret = -EAGAIN;
 			goto out;
@@ -608,7 +604,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   dio_flags, NULL, 0);
-	WARN_ON_ONCE(ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT));
 	if (ret == -ENOTBLK)
 		ret = 0;
 
-- 
2.42.0



