Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CCC73E99C
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjFZSiC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjFZSiA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:38:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA9DAC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9578360F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C115C433C8;
        Mon, 26 Jun 2023 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804678;
        bh=hS+keAW2J0vVOneigdJouEvRKBJPGlOqdu3cjUIvydA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSbguSvpqlyAHKttf1JODMf/b/pTKSQ8K+zJmw50xksJJwmeRP0TnGa0rbQfQS6d3
         K8E/ZNoBXaY163hDNwJ17HVD6ytrV7Bkzf4/u2QsvgGBxdV+gFWX+kdMadMJZCMBMG
         PsV12DU+DfPhK/OcdiQhEk7vWm9Sf9PceezuXiiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com,
        Qian Cai <cai@lca.pw>, Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 58/60] mm: fix VM_BUG_ON(PageTail) and BUG_ON(PageWriteback)
Date:   Mon, 26 Jun 2023 20:12:37 +0200
Message-ID: <20230626180741.934136653@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

commit 073861ed77b6b957c3c8d54a11dc503f7d986ceb upstream.

Twice now, when exercising ext4 looped on shmem huge pages, I have crashed
on the PF_ONLY_HEAD check inside PageWaiters(): ext4_finish_bio() calling
end_page_writeback() calling wake_up_page() on tail of a shmem huge page,
no longer an ext4 page at all.

The problem is that PageWriteback is not accompanied by a page reference
(as the NOTE at the end of test_clear_page_writeback() acknowledges): as
soon as TestClearPageWriteback has been done, that page could be removed
from page cache, freed, and reused for something else by the time that
wake_up_page() is reached.

https://lore.kernel.org/linux-mm/20200827122019.GC14765@casper.infradead.org/
Matthew Wilcox suggested avoiding or weakening the PageWaiters() tail
check; but I'm paranoid about even looking at an unreferenced struct page,
lest its memory might itself have already been reused or hotremoved (and
wake_up_page_bit() may modify that memory with its ClearPageWaiters()).

Then on crashing a second time, realized there's a stronger reason against
that approach.  If my testing just occasionally crashes on that check,
when the page is reused for part of a compound page, wouldn't it be much
more common for the page to get reused as an order-0 page before reaching
wake_up_page()?  And on rare occasions, might that reused page already be
marked PageWriteback by its new user, and already be waited upon?  What
would that look like?

It would look like BUG_ON(PageWriteback) after wait_on_page_writeback()
in write_cache_pages() (though I have never seen that crash myself).

Matthew Wilcox explaining this to himself:
 "page is allocated, added to page cache, dirtied, writeback starts,

  --- thread A ---
  filesystem calls end_page_writeback()
        test_clear_page_writeback()
  --- context switch to thread B ---
  truncate_inode_pages_range() finds the page, it doesn't have writeback set,
  we delete it from the page cache.  Page gets reallocated, dirtied, writeback
  starts again.  Then we call write_cache_pages(), see
  PageWriteback() set, call wait_on_page_writeback()
  --- context switch back to thread A ---
  wake_up_page(page, PG_writeback);
  ... thread B is woken, but because the wakeup was for the old use of
  the page, PageWriteback is still set.

  Devious"

And prior to 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
this would have been much less likely: before that, wake_page_function()'s
non-exclusive case would stop walking and not wake if it found Writeback
already set again; whereas now the non-exclusive case proceeds to wake.

I have not thought of a fix that does not add a little overhead: the
simplest fix is for end_page_writeback() to get_page() before calling
test_clear_page_writeback(), then put_page() after wake_up_page().

Was there a chance of missed wakeups before, since a page freed before
reaching wake_up_page() would have PageWaiters cleared?  I think not,
because each waiter does hold a reference on the page.  This bug comes
when the old use of the page, the one we do TestClearPageWriteback on,
had *no* waiters, so no additional page reference beyond the page cache
(and whoever racily freed it).  The reuse of the page has a waiter
holding a reference, and its own PageWriteback set; but the belated
wake_up_page() has woken the reuse to hit that BUG_ON(PageWriteback).

Reported-by: syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com
Reported-by: Qian Cai <cai@lca.pw>
Fixes: 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v5.8+
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c        |    8 ++++++++
 mm/page-writeback.c |    6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1388,11 +1388,19 @@ void end_page_writeback(struct page *pag
 		rotate_reclaimable_page(page);
 	}
 
+	/*
+	 * Writeback does not hold a page reference of its own, relying
+	 * on truncation to wait for the clearing of PG_writeback.
+	 * But here we must make sure that the page is not freed and
+	 * reused before the wake_up_page().
+	 */
+	get_page(page);
 	if (!test_clear_page_writeback(page))
 		BUG();
 
 	smp_mb__after_atomic();
 	wake_up_page(page, PG_writeback);
+	put_page(page);
 }
 EXPORT_SYMBOL(end_page_writeback);
 
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2746,12 +2746,6 @@ int test_clear_page_writeback(struct pag
 	} else {
 		ret = TestClearPageWriteback(page);
 	}
-	/*
-	 * NOTE: Page might be free now! Writeback doesn't hold a page
-	 * reference on its own, it relies on truncation to wait for
-	 * the clearing of PG_writeback. The below can only access
-	 * page state that is static across allocation cycles.
-	 */
 	if (ret) {
 		dec_lruvec_state(lruvec, NR_WRITEBACK);
 		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);


