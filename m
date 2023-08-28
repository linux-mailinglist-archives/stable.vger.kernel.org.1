Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4218478ADCD
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjH1Kus (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjH1Kud (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67740E4C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47C4964481
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2529BC433C9;
        Mon, 28 Aug 2023 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219807;
        bh=9XMAmSwksTgUpeSTYZ0R0ntinrxg0G3QrkflwwgiIX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBzporTktaUNlZINJTOJji+U6nO51gn/zgw0Dp/SbnrFBjS4Ui2AKLj5a9SPCbNdV
         QIxX++phhL1PESKIh9yTr+OWlIXy4DYst7zgWBmra1jSC7aLKsUehXkHxfVuP8C1+v
         TtHjzTG5slknD08cmQFC0U96qQPI4nRWi93aOcRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Vlastimil Babka <Vbabka@suse.cz>, Qian Cai <qcai@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 79/84] mm,hwpoison: refactor get_any_page
Date:   Mon, 28 Aug 2023 12:14:36 +0200
Message-ID: <20230828101151.965205685@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oscar Salvador <osalvador@suse.de>

[ Upstream commit 8295d535e2aa198bdf65a4045d622df38955ffe2 ]

Patch series "HWPoison: Refactor get page interface", v2.

This patch (of 3):

When we want to grab a refcount via get_any_page, we call __get_any_page
that calls get_hwpoison_page to get the actual refcount.

get_any_page() is only there because we have a sort of retry mechanism in
case the page we met is unknown to us or if we raced with an allocation.

Also __get_any_page() prints some messages about the page type in case the
page was a free page or the page type was unknown, but if anything, we
only need to print a message in case the pagetype was unknown, as that is
reporting an error down the chain.

Let us merge get_any_page() and __get_any_page(), and let the message be
printed in soft_offline_page.  While we are it, we can also remove the
'pfn' parameter as it is no longer used.

Link: https://lkml.kernel.org/r/20201204102558.31607-1-osalvador@suse.de
Link: https://lkml.kernel.org/r/20201204102558.31607-2-osalvador@suse.de
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Acked-by: Vlastimil Babka <Vbabka@suse.cz>
Cc: Qian Cai <qcai@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: e2c1ab070fdc ("mm: memory-failure: fix unexpected return value in soft_offline_page()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-failure.c | 101 +++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 58 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b21dd4a793926..71fd546dbdc37 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1690,70 +1690,51 @@ EXPORT_SYMBOL(unpoison_memory);
 
 /*
  * Safely get reference count of an arbitrary page.
- * Returns 0 for a free page, -EIO for a zero refcount page
- * that is not free, and 1 for any other page type.
- * For 1 the page is returned with increased page count, otherwise not.
+ * Returns 0 for a free page, 1 for an in-use page, -EIO for a page-type we
+ * cannot handle and -EBUSY if we raced with an allocation.
+ * We only incremented refcount in case the page was already in-use and it is
+ * a known type we can handle.
  */
-static int __get_any_page(struct page *p, unsigned long pfn, int flags)
+static int get_any_page(struct page *p, int flags)
 {
-	int ret;
+	int ret = 0, pass = 0;
+	bool count_increased = false;
 
 	if (flags & MF_COUNT_INCREASED)
-		return 1;
-
-	/*
-	 * When the target page is a free hugepage, just remove it
-	 * from free hugepage list.
-	 */
-	if (!get_hwpoison_page(p)) {
-		if (PageHuge(p)) {
-			pr_info("%s: %#lx free huge page\n", __func__, pfn);
-			ret = 0;
-		} else if (is_free_buddy_page(p)) {
-			pr_info("%s: %#lx free buddy page\n", __func__, pfn);
-			ret = 0;
-		} else if (page_count(p)) {
-			/* raced with allocation */
+		count_increased = true;
+
+try_again:
+	if (!count_increased && !get_hwpoison_page(p)) {
+		if (page_count(p)) {
+			/* We raced with an allocation, retry. */
+			if (pass++ < 3)
+				goto try_again;
 			ret = -EBUSY;
-		} else {
-			pr_info("%s: %#lx: unknown zero refcount page type %lx\n",
-				__func__, pfn, p->flags);
+		} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
+			/* We raced with put_page, retry. */
+			if (pass++ < 3)
+				goto try_again;
 			ret = -EIO;
 		}
 	} else {
-		/* Not a free page */
-		ret = 1;
-	}
-	return ret;
-}
-
-static int get_any_page(struct page *page, unsigned long pfn, int flags)
-{
-	int ret = __get_any_page(page, pfn, flags);
-
-	if (ret == -EBUSY)
-		ret = __get_any_page(page, pfn, flags);
-
-	if (ret == 1 && !PageHuge(page) &&
-	    !PageLRU(page) && !__PageMovable(page)) {
-		/*
-		 * Try to free it.
-		 */
-		put_page(page);
-		shake_page(page, 1);
-
-		/*
-		 * Did it turn free?
-		 */
-		ret = __get_any_page(page, pfn, 0);
-		if (ret == 1 && !PageLRU(page)) {
-			/* Drop page reference which is from __get_any_page() */
-			put_page(page);
-			pr_info("soft_offline: %#lx: unknown non LRU page type %lx (%pGp)\n",
-				pfn, page->flags, &page->flags);
-			return -EIO;
+		if (PageHuge(p) || PageLRU(p) || __PageMovable(p)) {
+			ret = 1;
+		} else {
+			/*
+			 * A page we cannot handle. Check whether we can turn
+			 * it into something we can handle.
+			 */
+			if (pass++ < 3) {
+				put_page(p);
+				shake_page(p, 1);
+				count_increased = false;
+				goto try_again;
+			}
+			put_page(p);
+			ret = -EIO;
 		}
 	}
+
 	return ret;
 }
 
@@ -1922,7 +1903,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return -EIO;
 
 	if (PageHWPoison(page)) {
-		pr_info("soft offline: %#lx page already poisoned\n", pfn);
+		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
 		if (flags & MF_COUNT_INCREASED)
 			put_page(page);
 		return 0;
@@ -1930,17 +1911,21 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
-	ret = get_any_page(page, pfn, flags);
+	ret = get_any_page(page, flags);
 	put_online_mems();
 
-	if (ret > 0)
+	if (ret > 0) {
 		ret = soft_offline_in_use_page(page);
-	else if (ret == 0)
+	} else if (ret == 0) {
 		if (soft_offline_free_page(page) && try_again) {
 			try_again = false;
 			flags &= ~MF_COUNT_INCREASED;
 			goto retry;
 		}
+	} else if (ret == -EIO) {
+		pr_info("%s: %#lx: unknown page type: %lx (%pGP)\n",
+			 __func__, pfn, page->flags, &page->flags);
+	}
 
 	return ret;
 }
-- 
2.40.1



