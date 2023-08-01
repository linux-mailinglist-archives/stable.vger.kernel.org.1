Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE176AFEA
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjHAJvX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjHAJvG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5429213E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56F7C614F3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655F8C433C8;
        Tue,  1 Aug 2023 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883435;
        bh=y8FFAVh19zJZ36FULwbJ6DbCmIu0WfH/xbQKBTfjtHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utFzV6tPe1Y8NNPGpAYLYv4iQ8vSk0jgl/Yv3XSlvp1Ksz4Yy165DxFmmYg4lU8Yy
         J6MqaqapsL8+efAPazx7D2PCexq5pl97xkGPayIu2jCinOKE/hWKihlj3aK13wxx/k
         MfOkjsTt6Fx/F9Eux8GPDprjEef2fCorvrIxCnfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 236/239] mm/memory-failure: fix hardware poison check in unpoison_memory()
Date:   Tue,  1 Aug 2023 11:21:40 +0200
Message-ID: <20230801091934.549900939@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sidhartha Kumar <sidhartha.kumar@oracle.com>

commit 6c54312f9689fbe27c70db5d42eebd29d04b672e upstream.

It was pointed out[1] that using folio_test_hwpoison() is wrong as we need
to check the indiviual page that has poison.  folio_test_hwpoison() only
checks the head page so go back to using PageHWPoison().

User-visible effects include existing hwpoison-inject tests possibly
failing as unpoisoning a single subpage could lead to unpoisoning an
entire folio.  Memory unpoisoning could also not work as expected as
the function will break early due to only checking the head page and
not the actually poisoned subpage.

[1]: https://lore.kernel.org/lkml/ZLIbZygG7LqSI9xe@casper.infradead.org/

Link: https://lkml.kernel.org/r/20230717181812.167757-1-sidhartha.kumar@oracle.com
Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory-failure.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2490,7 +2490,7 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (!folio_test_hwpoison(folio)) {
+	if (!PageHWPoison(p)) {
 		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
 				 pfn, &unpoison_rs);
 		goto unlock_mutex;


