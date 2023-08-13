Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFB77ABEF
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjHMV1X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjHMV1X (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:27:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CFA10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8008629EC
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054D2C433C8;
        Sun, 13 Aug 2023 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962044;
        bh=4nxUTCpgAWUYROWKMjePS9LsqG9T7gBIbeVX6/1UuHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbjx/Qxfit/4+x60Lr3MY7vzQVc4jnlZ2nrzMgrrHjGog3NLnWOfQBjo57VLIUK30
         vBpn6/xcMw7F4XqXp5JCtqUoTm9YI5u/r6aosXkPLw7/3PfRZw6iYHEX+ZRFBhC7+4
         UjR9B5mVRSk8oDMcDQ8nho3WD0OBpbjUHsQy2o3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miaohe Lin <linmiaohe@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 063/206] mm: memory-failure: avoid false hwpoison page mapped error info
Date:   Sun, 13 Aug 2023 23:17:13 +0200
Message-ID: <20230813211726.872246882@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

commit faeb2ff2c1c5cb60ce0da193580b256c941f99ca upstream.

folio->_mapcount is overloaded in SLAB, so folio_mapped() has to be done
after folio_test_slab() is checked. Otherwise slab folio might be treated
as a mapped folio leading to false 'Someone maps the hwpoison page' error
info.

Link: https://lkml.kernel.org/r/20230727115643.639741-4-linmiaohe@huawei.com
Fixes: 230ac719c500 ("mm/hwpoison: don't try to unpoison containment-failed pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory-failure.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2502,6 +2502,13 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
+	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
+		goto unlock_mutex;
+
+	/*
+	 * Note that folio->_mapcount is overloaded in SLAB, so the simple test
+	 * in folio_mapped() has to be done after folio_test_slab() is checked.
+	 */
 	if (folio_mapped(folio)) {
 		unpoison_pr_info("Unpoison: Someone maps the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
@@ -2514,9 +2521,6 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
-		goto unlock_mutex;
-
 	ghp = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ghp) {
 		if (PageHuge(p)) {


