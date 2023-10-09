Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371B97BDD48
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376753AbjJINJP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376741AbjJINJO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:09:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B5AF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:09:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68421C433CB;
        Mon,  9 Oct 2023 13:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856951;
        bh=cB9MJt+msrAo2gbyobVUsX8KVxCteovgQ3jTg/b7BB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPOad1g9K/aQ3Ek8BGTvVSfpPoKqeZtDSIVGWjqeteEyTjOtMyRZGIoEAAPwK3uFp
         C+81nrGDLStPEFTCQCivABn/I0G091zRD0bWsIEngydM2sjj61d+HEIGiEvFqa7XYN
         eKIMmFRP5yHz/dmMIawkqH3Oo0UtdYTwooKIX+40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+2113e61b8848fa7951d8@syzkaller.appspotmail.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 046/163] io_uring/kbuf: dont allow registered buffer rings on highmem pages
Date:   Mon,  9 Oct 2023 15:00:10 +0200
Message-ID: <20231009130125.298121019@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

commit f8024f1f36a30a082b0457d5779c8847cea57f57 upstream.

syzbot reports that registering a mapped buffer ring on arm32 can
trigger an OOPS. Registered buffer rings have two modes, one of them
is the application passing in the memory that the buffer ring should
reside in. Once those pages are mapped, we use page_address() to get
a virtual address. This will obviously fail on highmem pages, which
aren't mapped.

Add a check if we have any highmem pages after mapping, and fail the
attempt to register a provided buffer ring if we do. This will return
the same error as kernels that don't support provided buffer rings to
begin with.

Link: https://lore.kernel.org/io-uring/000000000000af635c0606bcb889@google.com/
Fixes: c56e022c0a27 ("io_uring: add support for user mapped provided buffer ring")
Cc: stable@vger.kernel.org
Reported-by: syzbot+2113e61b8848fa7951d8@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/kbuf.c |   27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -481,7 +481,7 @@ static int io_pin_pbuf_ring(struct io_ur
 {
 	struct io_uring_buf_ring *br;
 	struct page **pages;
-	int nr_pages;
+	int i, nr_pages;
 
 	pages = io_pin_pages(reg->ring_addr,
 			     flex_array_size(br, bufs, reg->ring_entries),
@@ -489,6 +489,17 @@ static int io_pin_pbuf_ring(struct io_ur
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
 
+	/*
+	 * Apparently some 32-bit boxes (ARM) will return highmem pages,
+	 * which then need to be mapped. We could support that, but it'd
+	 * complicate the code and slowdown the common cases quite a bit.
+	 * So just error out, returning -EINVAL just like we did on kernels
+	 * that didn't support mapped buffer rings.
+	 */
+	for (i = 0; i < nr_pages; i++)
+		if (PageHighMem(pages[i]))
+			goto error_unpin;
+
 	br = page_address(pages[0]);
 #ifdef SHM_COLOUR
 	/*
@@ -500,13 +511,8 @@ static int io_pin_pbuf_ring(struct io_ur
 	 * should use IOU_PBUF_RING_MMAP instead, and liburing will handle
 	 * this transparently.
 	 */
-	if ((reg->ring_addr | (unsigned long) br) & (SHM_COLOUR - 1)) {
-		int i;
-
-		for (i = 0; i < nr_pages; i++)
-			unpin_user_page(pages[i]);
-		return -EINVAL;
-	}
+	if ((reg->ring_addr | (unsigned long) br) & (SHM_COLOUR - 1))
+		goto error_unpin;
 #endif
 	bl->buf_pages = pages;
 	bl->buf_nr_pages = nr_pages;
@@ -514,6 +520,11 @@ static int io_pin_pbuf_ring(struct io_ur
 	bl->is_mapped = 1;
 	bl->is_mmap = 0;
 	return 0;
+error_unpin:
+	for (i = 0; i < nr_pages; i++)
+		unpin_user_page(pages[i]);
+	kvfree(pages);
+	return -EINVAL;
 }
 
 static int io_alloc_pbuf_ring(struct io_uring_buf_reg *reg,


