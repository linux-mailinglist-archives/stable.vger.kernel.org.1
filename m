Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB57D30ED
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjJWLDo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjJWLDn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:03:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709CD7A
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:03:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B540C433C9;
        Mon, 23 Oct 2023 11:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059020;
        bh=aw50T25sjhcD3kMamFaVrLOuiE9YrZtsYs++IG9OzE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZ2wPhr9nD86uVsL2A5hfGnQXUf+kuo/xSckTJdqBcOcVqdnXYkMh+T0rsbkTZucZ
         pcjLPWXJSoyG0ok12c1vOFVjoitvq95Eh06RkrFBRAKmzPr6lx++7OjkbHSDF3G7KM
         uhaXrDX0fqi71uEO283EPT8Jcq3Qb6J8A5gZKB4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, rtm@csail.mit.edu,
        Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 037/241] io_uring: fix crash with IORING_SETUP_NO_MMAP and invalid SQ ring address
Date:   Mon, 23 Oct 2023 12:53:43 +0200
Message-ID: <20231023104834.826933454@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 8b51a3956d44ea6ade962874ade14de9a7d16556 upstream.

If we specify a valid CQ ring address but an invalid SQ ring address,
we'll correctly spot this and free the allocated pages and clear them
to NULL. However, we don't clear the ring page count, and hence will
attempt to free the pages again. We've already cleared the address of
the page array when freeing them, but we don't check for that. This
causes the following crash:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Oops [#1]
Modules linked in:
CPU: 0 PID: 20 Comm: kworker/u2:1 Not tainted 6.6.0-rc5-dirty #56
Hardware name: ucbbar,riscvemu-bare (DT)
Workqueue: events_unbound io_ring_exit_work
epc : io_pages_free+0x2a/0x58
 ra : io_rings_free+0x3a/0x50
 epc : ffffffff808811a2 ra : ffffffff80881406 sp : ffff8f80000c3cd0
 status: 0000000200000121 badaddr: 0000000000000000 cause: 000000000000000d
 [<ffffffff808811a2>] io_pages_free+0x2a/0x58
 [<ffffffff80881406>] io_rings_free+0x3a/0x50
 [<ffffffff80882176>] io_ring_exit_work+0x37e/0x424
 [<ffffffff80027234>] process_one_work+0x10c/0x1f4
 [<ffffffff8002756e>] worker_thread+0x252/0x31c
 [<ffffffff8002f5e4>] kthread+0xc4/0xe0
 [<ffffffff8000332a>] ret_from_fork+0xa/0x1c

Check for a NULL array in io_pages_free(), but also clear the page counts
when we free them to be on the safer side.

Reported-by: rtm@csail.mit.edu
Fixes: 03d89a2de25b ("io_uring: support for user allocated memory for rings/sqes")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2666,7 +2666,11 @@ static void io_pages_free(struct page **
 
 	if (!pages)
 		return;
+
 	page_array = *pages;
+	if (!page_array)
+		return;
+
 	for (i = 0; i < npages; i++)
 		unpin_user_page(page_array[i]);
 	kvfree(page_array);
@@ -2750,7 +2754,9 @@ static void io_rings_free(struct io_ring
 		ctx->sq_sqes = NULL;
 	} else {
 		io_pages_free(&ctx->ring_pages, ctx->n_ring_pages);
+		ctx->n_ring_pages = 0;
 		io_pages_free(&ctx->sqe_pages, ctx->n_sqe_pages);
+		ctx->n_sqe_pages = 0;
 	}
 }
 


