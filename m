Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6614873E99D
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjFZSiD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjFZSiD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:38:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145F5AC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CE7560E8D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C66C433C8;
        Mon, 26 Jun 2023 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804680;
        bh=K29/hOnzNh/QsfHDfjp3a0vEpl++AeTm1IP/DC4tFkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bx5RZBV9qV/iyyKMTYJykrhhAjGal9Ub97O4kpZ5UoOqVO21U8yKu0oFtNR5OGbdb
         c7hKaXHRVBhAEkbrb6gOQE4esf8BsVtA+LShcOyEJLWFDHuxHR8b0BD96hQI1bWKxJ
         RkkTcX0nwiVu75GBENuHdFTLhL0QcP+DdENNjyPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 59/60] mm: make wait_on_page_writeback() wait for multiple pending writebacks
Date:   Mon, 26 Jun 2023 20:12:38 +0200
Message-ID: <20230626180741.976238210@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit c2407cf7d22d0c0d94cf20342b3b8f06f1d904e7 upstream.

Ever since commit 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common()
logic") we've had some very occasional reports of BUG_ON(PageWriteback)
in write_cache_pages(), which we thought we already fixed in commit
073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and BUG_ON(PageWriteback)").

But syzbot just reported another one, even with that commit in place.

And it turns out that there's a simpler way to trigger the BUG_ON() than
the one Hugh found with page re-use.  It all boils down to the fact that
the page writeback is ostensibly serialized by the page lock, but that
isn't actually really true.

Yes, the people _setting_ writeback all do so under the page lock, but
the actual clearing of the bit - and waking up any waiters - happens
without any page lock.

This gives us this fairly simple race condition:

  CPU1 = end previous writeback
  CPU2 = start new writeback under page lock
  CPU3 = write_cache_pages()

  CPU1          CPU2            CPU3
  ----          ----            ----

  end_page_writeback()
    test_clear_page_writeback(page)
    ... delayed...

                lock_page();
                set_page_writeback()
                unlock_page()

                                lock_page()
                                wait_on_page_writeback();

    wake_up_page(page, PG_writeback);
    .. wakes up CPU3 ..

                                BUG_ON(PageWriteback(page));

where the BUG_ON() happens because we woke up the PG_writeback bit
becasue of the _previous_ writeback, but a new one had already been
started because the clearing of the bit wasn't actually atomic wrt the
actual wakeup or serialized by the page lock.

The reason this didn't use to happen was that the old logic in waiting
on a page bit would just loop if it ever saw the bit set again.

The nice proper fix would probably be to get rid of the whole "wait for
writeback to clear, and then set it" logic in the writeback path, and
replace it with an atomic "wait-to-set" (ie the same as we have for page
locking: we set the page lock bit with a single "lock_page()", not with
"wait for lock bit to clear and then set it").

However, out current model for writeback is that the waiting for the
writeback bit is done by the generic VFS code (ie write_cache_pages()),
but the actual setting of the writeback bit is done much later by the
filesystem ".writepages()" function.

IOW, to make the writeback bit have that same kind of "wait-to-set"
behavior as we have for page locking, we'd have to change our roughly
~50 different writeback functions.  Painful.

Instead, just make "wait_on_page_writeback()" loop on the very unlikely
situation that the PG_writeback bit is still set, basically re-instating
the old behavior.  This is very non-optimal in case of contention, but
since we only ever set the bit under the page lock, that situation is
controlled.

Reported-by: syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com
Fixes: 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/page-writeback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2811,7 +2811,7 @@ EXPORT_SYMBOL(__test_set_page_writeback)
  */
 void wait_on_page_writeback(struct page *page)
 {
-	if (PageWriteback(page)) {
+	while (PageWriteback(page)) {
 		trace_wait_on_page_writeback(page, page_mapping(page));
 		wait_on_page_bit(page, PG_writeback);
 	}


