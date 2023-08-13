Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC2977ABEE
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjHMV1U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjHMV1U (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961FF10DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:27:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CBED629E8
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4572AC433C8;
        Sun, 13 Aug 2023 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962041;
        bh=E274u9W85NclO0KqbExBUoSuku0+6F6mWXjm+9hNI0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJNKXPKqlZ5pbIC4S10yojxJm2CL3VLWEg/2zujI/KvvUFdMBm5ENgjhG0G1i+9UJ
         I4OSGkCDTQ0dUfUE7wAKaeNDCZFuwhlf8XJ54aKn7I0zQDoKma2Shu0yhO9ZdV1R6D
         NTQfZcfw0OaBckIzcWvagehesFlx54XXrnsuQb7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 062/206] mm: memory-failure: fix potential unexpected return value from unpoison_memory()
Date:   Sun, 13 Aug 2023 23:17:12 +0200
Message-ID: <20230813211726.844564492@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Miaohe Lin <linmiaohe@huawei.com>

commit f29623e4a599c295cc8f518c8e4bb7848581a14d upstream.

If unpoison_memory() fails to clear page hwpoisoned flag, return value ret
is expected to be -EBUSY.  But when get_hwpoison_page() returns 1 and
fails to clear page hwpoisoned flag due to races, return value will be
unexpected 1 leading to users being confused.  And there's a code smell
that the variable "ret" is used not only to save the return value of
unpoison_memory(), but also the return value from get_hwpoison_page().
Make a further cleanup by using another auto-variable solely to save the
return value of get_hwpoison_page() as suggested by Naoya.

Link: https://lkml.kernel.org/r/20230727115643.639741-3-linmiaohe@huawei.com
Fixes: bf181c582588 ("mm/hwpoison: fix unpoison_memory()")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory-failure.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2469,7 +2469,7 @@ int unpoison_memory(unsigned long pfn)
 {
 	struct folio *folio;
 	struct page *p;
-	int ret = -EBUSY;
+	int ret = -EBUSY, ghp;
 	unsigned long count = 1;
 	bool huge = false;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
@@ -2517,29 +2517,28 @@ int unpoison_memory(unsigned long pfn)
 	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
 		goto unlock_mutex;
 
-	ret = get_hwpoison_page(p, MF_UNPOISON);
-	if (!ret) {
+	ghp = get_hwpoison_page(p, MF_UNPOISON);
+	if (!ghp) {
 		if (PageHuge(p)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
-			if (count == 0) {
-				ret = -EBUSY;
+			if (count == 0)
 				goto unlock_mutex;
-			}
 		}
 		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
-	} else if (ret < 0) {
-		if (ret == -EHWPOISON) {
+	} else if (ghp < 0) {
+		if (ghp == -EHWPOISON) {
 			ret = put_page_back_buddy(p) ? 0 : -EBUSY;
-		} else
+		} else {
+			ret = ghp;
 			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
 					 pfn, &unpoison_rs);
+		}
 	} else {
 		if (PageHuge(p)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
 			if (count == 0) {
-				ret = -EBUSY;
 				folio_put(folio);
 				goto unlock_mutex;
 			}


