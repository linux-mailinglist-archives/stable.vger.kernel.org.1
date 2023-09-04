Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E520791D3E
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjIDSgl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349195AbjIDSgk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:36:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5888CD7
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 799A3619AB
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C991C433C7;
        Mon,  4 Sep 2023 18:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852593;
        bh=AQkwkmdndnbM7gO1zbjje40B+lrolHYwIaiDpigLD7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0JfOQwwPwTSGBMqReqNahRSucKl22BA8QA/egLZH8qJny4eX7XQ6Ymf2C9CURZc9
         ciBSOM+DX4o5iZXSobqHHHQylqp6dvYuv+1Lio4nR3EbGF337FDfekEwTXtT5c+4ms
         NTV1+y1d9kpqmsqUJd0FQh3Y9GrKFp0rFgKZSdcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 24/28] nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()
Date:   Mon,  4 Sep 2023 19:30:55 +0100
Message-ID: <20230904182946.344370086@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
References: <20230904182945.178705038@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit f83913f8c5b882a312e72b7669762f8a5c9385e4 upstream.

A syzbot stress test reported that create_empty_buffers() called from
nilfs_lookup_dirty_data_buffers() can cause a general protection fault.

Analysis using its reproducer revealed that the back reference "mapping"
from a page/folio has been changed to NULL after dirty page/folio gang
lookup in nilfs_lookup_dirty_data_buffers().

Fix this issue by excluding pages/folios from being collected if, after
acquiring a lock on each page/folio, its back reference "mapping" differs
from the pointer to the address space struct that held the page/folio.

Link: https://lkml.kernel.org/r/20230805132038.6435-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/0000000000002930a705fc32b231@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
fs/nilfs2/segment.c | 5 +++++
 fs/nilfs2/segment.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -725,6 +725,11 @@ static size_t nilfs_lookup_dirty_data_bu
 		struct page *page = pvec.pages[i];
 
 		lock_page(page);
+		if (unlikely(page->mapping != mapping)) {
+			/* Exclude pages removed from the address space */
+			unlock_page(page);
+			continue;
+		}
 		if (!page_has_buffers(page))
 			create_empty_buffers(page, i_blocksize(inode), 0);
 		unlock_page(page);


