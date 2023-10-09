Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D737BDD8C
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376885AbjJINKc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376832AbjJINKQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:10:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED28CB6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:10:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36983C433D9;
        Mon,  9 Oct 2023 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857013;
        bh=U9wp2ydfRlmd5RmcTVGSjXOFug/S45Qn+x6dxwpQcIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYwh+jl9hMkz3e/66XzqBay/c45mqDlw1KM0h52nm36dNYQkY4r4vLimHUb1MGxhB
         khncGdNMTO4XsOd9Sjf8uD5xo2/qdT7HNwkHptV4pn7nUXdxqzoZ5JxxWfLEGqEcNh
         gOuXlsucTVrmjodE8kvc8hpeYtlRyClWro6H1aXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 040/163] io_uring: dont allow IORING_SETUP_NO_MMAP rings on highmem pages
Date:   Mon,  9 Oct 2023 15:00:04 +0200
Message-ID: <20231009130125.112943803@linuxfoundation.org>
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

commit 223ef474316466e9f61f6e0064f3a6fe4923a2c5 upstream.

On at least arm32, but presumably any arch with highmem, if the
application passes in memory that resides in highmem for the rings,
then we should fail that ring creation. We fail it with -EINVAL, which
is what kernels that don't support IORING_SETUP_NO_MMAP will do as well.

Cc: stable@vger.kernel.org
Fixes: 03d89a2de25b ("io_uring: support for user allocated memory for rings/sqes")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2678,7 +2678,7 @@ static void *__io_uaddr_map(struct page
 {
 	struct page **page_array;
 	unsigned int nr_pages;
-	int ret;
+	int ret, i;
 
 	*npages = 0;
 
@@ -2708,6 +2708,20 @@ err:
 	 */
 	if (page_array[0] != page_array[ret - 1])
 		goto err;
+
+	/*
+	 * Can't support mapping user allocated ring memory on 32-bit archs
+	 * where it could potentially reside in highmem. Just fail those with
+	 * -EINVAL, just like we did on kernels that didn't support this
+	 * feature.
+	 */
+	for (i = 0; i < nr_pages; i++) {
+		if (PageHighMem(page_array[i])) {
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
 	*pages = page_array;
 	*npages = nr_pages;
 	return page_to_virt(page_array[0]);


