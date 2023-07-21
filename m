Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2D75C9B0
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGUOVl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGUOVl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0760D1BD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97EED6195D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A30C433C8;
        Fri, 21 Jul 2023 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689949299;
        bh=/P1y5v+Qrm6JksRzYHb+dg9ex9p1Osliha3rZHUf89o=;
        h=Subject:To:Cc:From:Date:From;
        b=cs1E1h8kqJblsUBowvQwfqC2JqOhBq5s2el338kpVRHyN+wkIVFYFXOvs2+swD3tH
         VimMoVpCWJnpKF3mTj4FX+G3WXF03WbdyXwSBrF4nI31l+Z+6FMm7/cIXOJFTVgfpq
         dm7F6kkuh43T0SgEG9dXjdJzDxN5/6f9+uLMGkoM=
Subject: FAILED: patch "[PATCH] ceph: fix blindly expanding the readahead windows" failed to apply to 5.15-stable tree
To:     xiubli@redhat.com, idryomov@gmail.com, mchangir@redhat.com,
        sehuww@mail.scut.edu.cn
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:21:16 +0200
Message-ID: <2023072116-grading-unplanned-fd32@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x dc94bb8f271c079f69583d0f12a489aaf5202751
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072116-grading-unplanned-fd32@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

dc94bb8f271c ("ceph: fix blindly expanding the readahead windows")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc94bb8f271c079f69583d0f12a489aaf5202751 Mon Sep 17 00:00:00 2001
From: Xiubo Li <xiubli@redhat.com>
Date: Thu, 4 May 2023 19:00:42 +0800
Subject: [PATCH] ceph: fix blindly expanding the readahead windows

Blindly expanding the readahead windows will cause unneccessary
pagecache thrashing and also will introduce the network workload.
We should disable expanding the windows if the readahead is disabled
and also shouldn't expand the windows too much.

Expanding forward firstly instead of expanding backward for possible
sequential reads.

Bound `rreq->len` to the actual file size to restore the previous page
cache usage.

The posix_fadvise may change the maximum size of a file readahead.

Cc: stable@vger.kernel.org
Fixes: 49870056005c ("ceph: convert ceph_readpages to ceph_readahead")
Link: https://lore.kernel.org/ceph-devel/20230504082510.247-1-sehuww@mail.scut.edu.cn
Link: https://www.spinics.net/lists/ceph-users/msg76183.html
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-and-tested-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 19c4f08454d2..59cbfb80edbd 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -187,16 +187,42 @@ static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
 	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_layout *lo = &ci->i_layout;
+	unsigned long max_pages = inode->i_sb->s_bdi->ra_pages;
+	loff_t end = rreq->start + rreq->len, new_end;
+	struct ceph_netfs_request_data *priv = rreq->netfs_priv;
+	unsigned long max_len;
 	u32 blockoff;
-	u64 blockno;
 
-	/* Expand the start downward */
-	blockno = div_u64_rem(rreq->start, lo->stripe_unit, &blockoff);
-	rreq->start = blockno * lo->stripe_unit;
-	rreq->len += blockoff;
+	if (priv) {
+		/* Readahead is disabled by posix_fadvise POSIX_FADV_RANDOM */
+		if (priv->file_ra_disabled)
+			max_pages = 0;
+		else
+			max_pages = priv->file_ra_pages;
 
-	/* Now, round up the length to the next block */
-	rreq->len = roundup(rreq->len, lo->stripe_unit);
+	}
+
+	/* Readahead is disabled */
+	if (!max_pages)
+		return;
+
+	max_len = max_pages << PAGE_SHIFT;
+
+	/*
+	 * Try to expand the length forward by rounding up it to the next
+	 * block, but do not exceed the file size, unless the original
+	 * request already exceeds it.
+	 */
+	new_end = min(round_up(end, lo->stripe_unit), rreq->i_size);
+	if (new_end > end && new_end <= rreq->start + max_len)
+		rreq->len = new_end - rreq->start;
+
+	/* Try to expand the start downward */
+	div_u64_rem(rreq->start, lo->stripe_unit, &blockoff);
+	if (rreq->len + blockoff <= max_len) {
+		rreq->start -= blockoff;
+		rreq->len += blockoff;
+	}
 }
 
 static bool ceph_netfs_clamp_length(struct netfs_io_subrequest *subreq)

