Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED337B891B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbjJDSWv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbjJDSWu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:22:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BCABF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:22:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47D9C433CD;
        Wed,  4 Oct 2023 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443766;
        bh=lnnL1i9NJdHx8NpcZ4eul6o9oxZ+4nT800giNv7YW2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdY+0+JQvBr0lvnRLR8Zj/vd1y9MwwAO6b7MgNDpQOAXJI8PpxCGVVPLwHiUJ28xO
         rtG/oZ4MbFO8IeTbMtEDbQ9vyWta2t68SAtjVB6iG8GcM2bZPl95zrJKZpCjH+gQFE
         lr/+AVMKBok2iG9bKMX9OU8KrPkee7SBxHNud3YU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Wysochanski <dwysocha@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 013/321] netfs: Only call folio_start_fscache() one time for each folio
Date:   Wed,  4 Oct 2023 19:52:38 +0200
Message-ID: <20231004175229.814170185@linuxfoundation.org>
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

From: Dave Wysochanski <dwysocha@redhat.com>

[ Upstream commit df1c357f25d808e30b216188330e708e09e1a412 ]

If a network filesystem using netfs implements a clamp_length()
function, it can set subrequest lengths smaller than a page size.

When we loop through the folios in netfs_rreq_unlock_folios() to
set any folios to be written back, we need to make sure we only
call folio_start_fscache() once for each folio.

Otherwise, this simple testcase:

  mount -o fsc,rsize=1024,wsize=1024 127.0.0.1:/export /mnt/nfs
  dd if=/dev/zero of=/mnt/nfs/file.bin bs=4096 count=1
  1+0 records in
  1+0 records out
  4096 bytes (4.1 kB, 4.0 KiB) copied, 0.0126359 s, 324 kB/s
  echo 3 > /proc/sys/vm/drop_caches
  cat /mnt/nfs/file.bin > /dev/null

will trigger an oops similar to the following:

  page dumped because: VM_BUG_ON_FOLIO(folio_test_private_2(folio))
  ------------[ cut here ]------------
  kernel BUG at include/linux/netfs.h:44!
  ...
  CPU: 5 PID: 134 Comm: kworker/u16:5 Kdump: loaded Not tainted 6.4.0-rc5
  ...
  RIP: 0010:netfs_rreq_unlock_folios+0x68e/0x730 [netfs]
  ...
  Call Trace:
    netfs_rreq_assess+0x497/0x660 [netfs]
    netfs_subreq_terminated+0x32b/0x610 [netfs]
    nfs_netfs_read_completion+0x14e/0x1a0 [nfs]
    nfs_read_completion+0x2f9/0x330 [nfs]
    rpc_free_task+0x72/0xa0 [sunrpc]
    rpc_async_release+0x46/0x70 [sunrpc]
    process_one_work+0x3bd/0x710
    worker_thread+0x89/0x610
    kthread+0x181/0x1c0
    ret_from_fork+0x29/0x50

Fixes: 3d3c95046742 ("netfs: Provide readahead and readpage netfs helpers"
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2210612
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20230608214137.856006-1-dwysocha@redhat.com/ # v1
Link: https://lore.kernel.org/r/20230915185704.1082982-1-dwysocha@redhat.com/ # v2
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/buffered_read.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 3404707ddbe73..2cd3ccf4c4399 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -47,12 +47,14 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 	xas_for_each(&xas, folio, last_page) {
 		loff_t pg_end;
 		bool pg_failed = false;
+		bool folio_started;
 
 		if (xas_retry(&xas, folio))
 			continue;
 
 		pg_end = folio_pos(folio) + folio_size(folio) - 1;
 
+		folio_started = false;
 		for (;;) {
 			loff_t sreq_end;
 
@@ -60,8 +62,10 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 				pg_failed = true;
 				break;
 			}
-			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
+			if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
 				folio_start_fscache(folio);
+				folio_started = true;
+			}
 			pg_failed |= subreq_failed;
 			sreq_end = subreq->start + subreq->len - 1;
 			if (pg_end < sreq_end)
-- 
2.40.1



