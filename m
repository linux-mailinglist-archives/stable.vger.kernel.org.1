Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88F57A7F19
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjITMX7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbjITMX6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:23:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C83897
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:23:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67910C433CA;
        Wed, 20 Sep 2023 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212632;
        bh=MjCM6iJ7HMzJuuAQU7ZDD8JMtrj6NPzD4sFLsJbzd6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0+/H2ymF0oI167HEXx3a6RmdKgoG2rdDPEyPcfenVKxhUDvOJVlc+jlPQI4u16BN
         gqY4f5VtlE2YIUVf0YYK26za+xfrL2wqA9URMSvu8aj6b6SR7EGkQ5lCnqMVunp/Yv
         486Cjw753cc3vMSa7r0tR7LmZm56owsVsOZ73Kbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH 5.10 73/83] mm/filemap: fix infinite loop in generic_file_buffered_read()
Date:   Wed, 20 Sep 2023 13:32:03 +0200
Message-ID: <20230920112829.541295877@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kent Overstreet <kent.overstreet@gmail.com>

commit 3644e2d2dda78e21edd8f5415b6d7ab03f5f54f3 upstream.

If iter->count is 0 and iocb->ki_pos is page aligned, this causes
nr_pages to be 0.

Then in generic_file_buffered_read_get_pages() find_get_pages_contig()
returns 0 - because we asked for 0 pages, so we call
generic_file_buffered_read_no_cached_page() which attempts to add a page
to the page cache, which fails with -EEXIST, and then we loop. Oops...

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Reported-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2203,6 +2203,9 @@ ssize_t generic_file_buffered_read(struc
 
 	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
 		return 0;
+	if (unlikely(!iov_iter_count(iter)))
+		return 0;
+
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
 	index = *ppos >> PAGE_SHIFT;


